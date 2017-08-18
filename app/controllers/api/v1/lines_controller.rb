class Api::V1::LinesController < ApplicationController

  def show
    @line = Line.find(params[:id])
    usernames = @line.users.pluck(:username, :image_url)
    render json: {line: @line, users: usernames}
  end

  def users
    @users = Line.find(params[:id]).users
    render json: @users
  end
end
