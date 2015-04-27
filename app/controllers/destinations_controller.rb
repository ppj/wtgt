class DestinationsController < ApplicationController
  before_action :require_user

  def index
    @destinations = current_user.destinations
  end

  def new
    @destination = Destination.new
  end
end
