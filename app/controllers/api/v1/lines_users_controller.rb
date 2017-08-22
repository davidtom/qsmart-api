class Api::V1::LinesUsersController < ApplicationController
  before_action :authenticate_user

  def create
    # TODO validate users in auth controller
    # TODO ...make auth controller
    # byebug
    @user = current_user
    @line = Line.find_by(code: params[:code].upcase)
    if @line
      @line.users << @user
      line_id = @line.id
      render json: {line_id: @line.id}, status: 200
    elsif !@line
      render json: {error: "Invalid line code"}, status: 404
    else
      render json: {error: "unknown error"}
    end
  end

  def update
  end

  def destroy
    @record = LinesUser.find_by(user_id: params[:user], line_id: params[:line])
    if @record.destroy
      render json: {}, status: 204
    else
      render json: {error: "unable to delete"}, status: 500
    end
  end

end
