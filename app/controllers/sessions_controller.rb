class SessionsController < ApplicationController
  def new
    redirect_to destinations_path if logged_in?
  end

  def create
    user = User.find_by(email: params[:email])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      flash[:success] = "You have logged in successfully."
      redirect_to root_path
    else
      flash.now[:danger] = "The login or password is incorrect."
      render :new
    end
  end

  def destroy
    session[:user_id] = nil
    flash[:success] = "You have logged out."
    redirect_to root_path
  end
end
