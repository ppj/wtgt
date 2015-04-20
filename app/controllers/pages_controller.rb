class PagesController < ApplicationController
  def front
    redirect_to destinations_path if logged_in?
  end
end
