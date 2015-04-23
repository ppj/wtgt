class SessionsController < ApplicationController
  def create
    user = User.find_by(email: params[:email])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      flash[:success] = "You have logged in successfully."
    else
      flash[:danger] = "The login or password is incorrect."
      # FIXME: should ideally render the same template again; <render request.env['PATH_INFO']> failed
    end
    redirect_to root_path
  end

  def destroy
    session[:user_id] = nil
    flash[:success] = "You have logged out."
    redirect_to root_path
  end
end
