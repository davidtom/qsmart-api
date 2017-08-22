class Api::V1::LinesController < ApplicationController

  def show
    @line = Line.find(params[:id])
    render json: {line: @line, users: @line.waiting_users}
  end

  def users
    @users = Line.find(params[:id]).users
    render json: @users
  end
end
