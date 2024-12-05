class PagesController < ApplicationController
  def home
    @events = Event.all.limit(6)
  end
end
