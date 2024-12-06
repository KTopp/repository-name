class TicketsController < ApplicationController
  before_action :set_ticket, only: %i[mark_as_pending mark_as_for_sale destroy stop cancel edit update show]
  skip_before_action :authenticate_user!, only: :index

  # GET /events/:id/tickets
  def index
    @event = Event.find(params[:id])
    @tickets = policy_scope(@event.tickets).where(status: "for_sale")
    @markers = [{ lat: @event.latitude, lng: @event.longitude }]
  end

  # GET /events/:id/tickets/new
  def new
    @event = Event.find(params[:event_id])
    @ticket = Ticket.new
    authorize @ticket
  end

  # GET /events/:id/tickets/bulk_new
  def bulk_new
    @event = Event.find(params[:event_id])
    @ticket = Ticket.new
    authorize @ticket
  end

  # POST /events/:id/tickets
  def create
    @event = Event.find(params[:id])
    updated_params = ticket_params
    updated_params[:status] = ticket_params[:status].to_i
    @ticket = @event.tickets.build(updated_params)
    authorize @ticket
    # @ticket.user = current_user # Assign the ticket to the logged-in user

    if @ticket.save
      redirect_to event_tickets_path(@event), notice: "Ticket created successfully!"
    else
      redirect_to event_tickets_path(@event), alert: @ticket.errors.full_messages.to_sentence
    end
  end

  # POST /events/:id/tickets
  def bulk_create
    @event = Event.find(params[:id])
    quantity = params[:quantity].to_i
    errors = []

    quantity.times do
      updated_params = ticket_params
      updated_params[:status] = ticket_params[:status].to_i
      updated_params[:ticket_number] = SecureRandom.hex(6).upcase
      @ticket = @event.tickets.build(updated_params)
      authorize @ticket
      # @ticket.user = current_user # Assign the ticket to the logged-in user

      errors << ticket.errors.full_messages.to_sentence unless @ticket.save
    end

    if errors.empty?
      redirect_to event_tickets_path(@event), notice: "#{quantity} tickets created successfully!"
    else
      redirect_to event_tickets_path(@event), alert: "Some tickets failed to create: #{errors.uniq.join(', ')}"
    end
  end

  # PATCH /tickets/:id/pending
  def mark_as_pending
    authorize @ticket
    if @ticket.update(status: "pending", buyer_id: current_user.id)
      redirect_to event_tickets_path(@ticket.event), notice: "Ticket marked as pending!"
    else
      redirect_to event_tickets_path(@ticket.event), alert: "Unable to update ticket."
    end
  end

  # PATCH /tickets/:id/sell
  def mark_as_for_sale
    authorize @ticket
    if @ticket.update(status: :for_sale)
      redirect_to my_tickets_path, notice: "Ticket is now for sale!"
    else
      redirect_to my_tickets_path, alert: "Unable to update ticket."
    end
  end

  # GET /tickets/cart
  def cart
    @tickets = Ticket.where(buyer_id: current_user.id, status: :pending)
    authorize @tickets
  end

  def cancel
    authorize @ticket
    if @ticket.update(status: :for_sale, buyer_id: nil)
      redirect_to cart_path, notice: "Sale canceled. Ticket is now available for sale."
    else
      redirect_to cart_path, alert: "Unable to cancel the sale of this ticket."
    end
  end

  # PATCH /tickets
  def mark_as_sold
    tickets = Ticket.where(buyer_id: current_user.id, status: :pending)
    authorize tickets
    if tickets.update_all(status: "sold", buyer_id: nil, user_id: current_user.id)
      redirect_to my_tickets_path, notice: "Tickets purchased successfully!"
    else
      redirect_to cart_path, alert: "Unable to complete the purchase."
    end
  end

  # GET /tickets/my_listings
  def my_listings
    @tickets = Ticket.where(user_id: current_user.id).where(status: %i[for_sale pending])
    authorize @tickets
  end

  # Not in use
  # DELETE /tickets/:id
  def destroy
    @ticket.destroy
    redirect_to my_listings_path, notice: "Ticket deleted successfully!"
  end

  # PATCH "/tickets/:id/stop"
  def stop
    authorize @ticket
    if @ticket.update(status: :sold)
      redirect_to my_listings_path, notice: "Ticket removed from sale. You can access it in the 'My Tickets' section."
    else
      redirect_to my_listings_path, alert: "Unable to stop the sale of this ticket."
    end
  end

  def edit
    # @ticket set before
    authorize @ticket
  end

  def update
    authorize @ticket
    if @ticket.update(price: params[:ticket][:price], status: :for_sale)
      redirect_to my_listings_path, notice: "Ticket price updated successfully!"
    else
      Rails.logger.debug "Validation Errors: #{@ticket.errors.full_messages}"
      render :edit, status: :unprocessable_entity
    end
  end

  # GET /tickets/my_tickets
  def my_tickets
    @tickets = Ticket.where(user_id: current_user.id, status: "sold")
    authorize @tickets
  end

  def show
    # @ticket provided by set ticket
  end

  private

  # Strong parameters for ticket creation
  def ticket_params
    params.require(:ticket).permit(:ticket_number, :price, :ticket_category, :qr_code, :status, :user_id)
  end

  # Set a ticket for actions requiring a ticket ID
  def set_ticket
    @ticket = Ticket.find(params[:id])
  end
end
