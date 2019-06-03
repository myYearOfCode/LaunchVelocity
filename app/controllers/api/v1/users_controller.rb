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
end
