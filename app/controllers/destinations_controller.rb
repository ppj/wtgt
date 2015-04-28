class DestinationsController < ApplicationController
  before_action :require_user

  def index
    @destinations = current_user.destinations
  end

  def new
    @destination = Destination.new
  end

  def create
    @place = place_for_destination
    @place.save if @place.new_record?
    @destination = current_user.destinations.new(destination_params)
    @destination.place = @place
    if @destination.save
      flash[:success] = "Added destination to your wishlist!"
      redirect_to destinations_path
    else
      flash.now[:danger] = "Place input(s) seem to have some error(s)"
      render :new
    end
  end

  def edit

  end

  private

  def place_params
    params[:destination].require(:place).permit(:name, :country)
  end

  def destination_params
    params.require(:destination).permit(:category, :visited)
  end

  def place_for_destination
    place = Place.find_by(name: params[:destination][:place][:name], country: params[:destination][:place][:country])
    place ||= Place.new(place_params)
  end
end
