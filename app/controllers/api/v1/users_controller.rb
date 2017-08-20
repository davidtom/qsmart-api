class Api::V1::UsersController < ApplicationController
  before_action :authenticate_user, except: [:create]
  def create
    name = params[:firstName] + ' ' + params[:lastName]
    phone = params[:phone1] + params[:phone2] + params[:phone3]
    @user = User.create(email:params[:email],password:params[:password],name: name, phone_number: phone)
    render json: @user
  end

  def cu
    render json: current_user
  end

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
