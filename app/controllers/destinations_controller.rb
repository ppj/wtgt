class DestinationsController < ApplicationController
  before_action :require_user

  def index
    @destinations = current_user.destinations
  end
end
