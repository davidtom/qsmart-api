class Api::V1::UsersController < ApplicationController
  before_action :authenticate_user, except: [:create]

  def create
    @user = User.new(user_params)
    @user.password = params[:password]
    if @user.save
      render json: @user, status: 200
    else
      render json: @user.errors.full_messages, status: 400
    end
  end

  def cu
    render json: current_user
  end

  def show
    render json: current_user
  end

  def lines
    @lines = current_user.lines_waiting
    @lines = @lines.map.with_index do |line|
      line["created_at"] = line.lines_users.where(user_id: current_user.id, waiting:true)[0].created_at
      new_line = line.attributes
      new_line["userCount"] = line.user_count
      new_line["userPlace"] = line.waiting_users.index(current_user) + 1
      new_line
    end
    render json: @lines
  end

  def created_lines
    @lines = current_user.created_lines
    @lines = @lines.map do |line|
      new_line = line.attributes
      new_line["userCount"] = line.user_count
      new_line
    end
    render json: @lines
  end

  private
  def user_params
    params.require(:user).permit(:email,:password,:first_name,:last_name,:phone_number,:profile_image_url)
  end
end
