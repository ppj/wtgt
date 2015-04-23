class UsersController < ApplicationController
  def new
    redirect_to destinations_path if logged_in?
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "Account created successfully! Please sign in."
      redirect_to root_path
    else
      flash.now[:danger] = "Please fix the errors below before trying again."
      render :new
    end
  end

  private

  def user_params
    params.require(:user).permit(:fullname, :email, :password, :hometown, :country)
  end
end
