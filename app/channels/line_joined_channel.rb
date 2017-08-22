class LineJoinedChannel < ApplicationCable::Channel
  def subscribed
    # stream_from "some_channel"
    @line = Line.find_by(id: params[:room])
    stream_for @line
  end

  def received(data)
    LineJoinedChannel.broadcast_to(@line, @line.waiting_users)
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
