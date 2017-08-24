class LineJoinedChannel < ApplicationCable::Channel
  def subscribed
    @line = Line.find_by(id: params[:room])
    stream_for @line
  end

  def received(data)
    LineJoinedChannel.broadcast_to(@line, @line.waiting_users)
  end

  def unsubscribed
  end
end
