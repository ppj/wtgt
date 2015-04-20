class DestinationsController < ApplicationController
  before_action :require_user

  def index
    @destinations = Destination.order("updated_at DESC")
  end
end
