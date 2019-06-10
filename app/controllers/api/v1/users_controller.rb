class Api::V1::UsersController < ApplicationController
  def show
    if User.where(id: params[:id]).exists?
      @user = User.find(params[:id])
      render json: @user
    else
      render json: []
    end
  end

  def index
    @users = User.all
    render json: @users
  end

  def update
    if user_signed_in?
      puts current_user.update_attributes(user_params)
      render json: current_user
    end
  end

  private
  def user_params
    params.require(:user).permit(:gitHubUsername, :sendReminders, :email)
  end
end
