class Api::V1::LinesController < ApplicationController

  def create
    @line = Line.create(name: params[:name])
    current_user.created_lines << @line
  end

  def show
    line_id = params[:id]
    @line = Line.find(line_id)
    render json: {line: @line, users: @line.waiting_users}
    # ActionCable.server.broadcast "line_channel_#{line_id}", @line.users
    # ActionCable.server.broadcast_to(@line, @line.waiting_users)
    sleep(0.25)
    LineJoinedChannel.broadcast_to(@line_joined, @line.waiting_users)
    LineChannel.broadcast_to(@line, @line.waiting_users)
  end

  def users
    @users = Line.find(params[:id]).users
    render json: @users
  end
end
