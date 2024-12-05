class TicketsController < ApplicationController
  before_action :set_ticket, only: %i[mark_as_pending mark_as_for_sale destroy stop cancel edit update]
  before_action :authenticate_user! # Devise method to ensure the user is logged in

  # GET /events/:id/tickets
  def index
    @event = Event.find(params[:id])
    @tickets = @event.tickets.where(status: "for_sale")
    @markers = [{ lat: @event.latitude, lng: @event.longitude }]
  end

  # GET /events/:id/tickets/new
  def new
    @event = Event.find(params[:event_id]) # Fetch the associated event
    @ticket = Ticket.new
  end

  # POST /events/:id/tickets
  def create
    @event = Event.find(params[:id])
    updated_params = ticket_params
    updated_params[:status] = ticket_params[:status].to_i
    updated_params[:qr_code] = updated_params[:ticket_number]
    @ticket = @event.tickets.build(updated_params)
    @ticket.user = current_user # Assign the ticket to the logged-in user

    if @ticket.save
      redirect_to event_tickets_path(@event), notice: "Ticket created successfully!"
    else
      redirect_to event_tickets_path(@event), alert: @ticket.errors.full_messages.to_sentence
    end
  end

  # PATCH /tickets/:id/pending
  def mark_as_pending
    if @ticket.update(status: "pending", buyer_id: current_user.id)
      redirect_to event_tickets_path(@ticket.event), notice: "Ticket marked as pending!"
    else
      redirect_to event_tickets_path(@ticket.event), alert: "Unable to update ticket."
    end
  end

  # PATCH /tickets/:id/sell
  def mark_as_for_sale
    if @ticket.update(status: :for_sale)
      redirect_to my_tickets_path, notice: "Ticket is now for sale!"
    else
      redirect_to my_tickets_path, alert: "Unable to update ticket."
    end
  end

  # GET /tickets/cart
  def cart
    @tickets = Ticket.where(buyer_id: current_user.id, status: :pending)
  end

  def cancel
    if @ticket.update(status: :for_sale, buyer_id: nil)
      redirect_to cart_path, notice: "Sale canceled. Ticket is now available for sale."
    else
      redirect_to cart_path, alert: "Unable to cancel the sale of this ticket."
    end
  end

  # PATCH /tickets
  def mark_as_sold
    tickets = Ticket.where(buyer_id: current_user.id, status: :pending)
    if tickets.update_all(status: "sold", buyer_id: nil, user_id: current_user.id)
      redirect_to my_tickets_path, notice: "Tickets purchased successfully!"
    else
      redirect_to cart_path, alert: "Unable to complete the purchase."
    end
  end

  # GET /tickets/my_listings
  def my_listings
    @tickets = Ticket.where(user_id: current_user.id).where(status: %i[for_sale pending])
  end

  # Not in use
  # DELETE /tickets/:id
  def destroy
    @ticket.destroy
    redirect_to my_listings_path, notice: "Ticket deleted successfully!"
  end

  # PATCH "/tickets/:id/stop"
  def stop
    if @ticket.update(status: :sold)
      redirect_to my_listings_path, notice: "Ticket removed from sale. You can access it in the 'My Tickets' section."
    else
      redirect_to my_listings_path, alert: "Unable to stop the sale of this ticket."
    end
  end

  def edit
    # @ticket set before
  end

  def update
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
  end

  private

  # Strong parameters for ticket creation
  def ticket_params
    params.require(:ticket).permit(:ticket_number, :price, :ticket_category, :qr_code, :status)
  end

  # Set a ticket for actions requiring a ticket ID
  def set_ticket
    @ticket = Ticket.find(params[:id])
  end
end
