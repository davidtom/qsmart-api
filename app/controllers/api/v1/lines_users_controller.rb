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
      render json: {line_id: @line.id}, status: 200
    elsif !@line
      render json: {error: "Invalid line code"}, status: 404
    else
      render json: {error: "unknown error"}
    end
  end

end
