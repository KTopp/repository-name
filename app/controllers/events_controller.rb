class EventsController < ApplicationController
  before_action :set_event, only: [:show]

  # GET /events
  def index
    @events = Event.all.to_a
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

