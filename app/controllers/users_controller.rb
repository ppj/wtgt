class UsersController < ApplicationController
  before_action :require_user, only: [:show, :edit, :update]
  before_action :set_user, only: [:show, :edit, :update]

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

  def show
  end

  def edit
  end

  def update
    if @user.update(user_params)
      flash[:success] = "Profile updated successfully."
      redirect_to profile_path
    else
      flash.now[:danger] = "Please fix the errors below:"
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:fullname, :email, :password, :hometown, :country)
  end

  def set_user
    @user = current_user
  end
end
