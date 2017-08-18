class Api::V1::LinesController < ApplicationController

  def show
    @line = Line.find(params[:id])
    render json: @line
  end

  def users
    @users = Line.find(params[:id]).users
    render json: @users
  end
end
