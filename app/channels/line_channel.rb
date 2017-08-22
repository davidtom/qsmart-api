class LineChannel < ApplicationCable::Channel
  def subscribed
    # stream_from "line_channel_#{params[:room]}"
    @line = Line.find_by(id: params[:room])
    stream_for @line
    # stream_from "line_#{params[:room]}"
    # stream_from "chat_#{params[:room]}"
  end

  def received(data)
    # ActionCable.server.broadcast("line_channel_#{params[:room]}", data)
    LineChannel.broadcast_to(@line, @line.waiting_users)
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
