class DestinationsController < ApplicationController
  def index
    @destinations = Destination.order("updated_at DESC")
  end
end
