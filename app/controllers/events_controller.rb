class EventsController < ApplicationController
  before_action :set_event, only: [:show]

  # GET /events
  def index
    if params[:query].present?
      @events = Event.global_search(params[:query])
    else
      @events = Event.all
    end
  end

  # GET /events/:id
  def show
    @tickets = @event.tickets.where(status: "for_sale")
  end

  private

  # Find event for actions that need it
  def set_event
    @event = Event.find(params[:id])
  end
end
