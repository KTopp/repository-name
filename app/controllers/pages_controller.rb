class PagesController < ApplicationController
  skip_before_action :authenticate_user!

  def home
    @events = policy_scope(Event).limit(6)
  end
end
