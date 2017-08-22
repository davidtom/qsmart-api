class Api::V1::LinesController < ApplicationController

  def show
    line_id = params[:id]
    @line = Line.find(line_id)
    render json: {line: @line, users: @line.waiting_users}
    # ActionCable.server.broadcast "line_channel_#{line_id}", @line.users
    LineChannel.broadcast_to(@line, @line.users)
  end

  def users
    @users = Line.find(params[:id]).users
    render json: @users
  end
end
