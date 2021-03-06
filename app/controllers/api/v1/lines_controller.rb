class Api::V1::LinesController < ApplicationController

  def create
    image_url = params[:imageURL] || "http://imgur.com/n00Ed17.jpg"
    @line = Line.create(name: params[:name], image_url: image_url)
    current_user.created_lines << @line
    LineJoinedChannel.broadcast_to(@line, {line: @line, users: @line.waiting_users})
    LineChannel.broadcast_to(@line, {line: @line, users: @line.waiting_users})
    render json: {line: @line}, status: 200
  end

  def show
    line_id = params[:id]
    @line = Line.find(line_id)
    LineJoinedChannel.broadcast_to(@line, {line: @line, users: @line.waiting_users})
    LineChannel.broadcast_to(@line, {line: @line, users: @line.waiting_users})
    render json: {line: @line, users: @line.waiting_users}
  end

  def users
    @users = Line.find(params[:id]).users
    render json: @users
  end

  def update
    @line = Line.find(params[:id])
    @line.update(active: !@line.active)
  end
end
