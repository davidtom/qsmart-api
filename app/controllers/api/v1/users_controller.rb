class Api::V1::UsersController < ApplicationController

  def show
    @user = User.find(params[:id])
    render json: @user
  end

  def lines
    @lines = User.find(params[:id]).lines
    render json: @lines
  end

  def created_lines
    @created_lines = User.find(params[:id]).created_lines
    render json: @created_lines
  end

end
