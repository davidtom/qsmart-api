class LineChannel < ApplicationCable::Channel
  def subscribed
    stream_from "line_channel"
    # stream_from "line_#{params[:line]}"

  end

  def received(data)
    ActionCable.server.broadcast("line_channel", data)
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
