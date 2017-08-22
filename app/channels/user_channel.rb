class UserChannel < ApplicationCable::Channel
  def subscribed
    # stream_from "some_channel"
    @user = User.find(params[:room])
    stream_for @user
  end

  def received(data)
    # line_total = @user.lines.map{|line| line.users.count}
<<<<<<< HEAD
<<<<<<< HEAD
    UserChannel.broadcast_to(@user, {lines: current_user.lines, createdLines: current_user.created_lines})
=======
    UserChannel.broadcast_to(@user, @user.lines)
>>>>>>> Initial commit
=======
    UserChannel.broadcast_to(@user, {lines: current_user.lines, createdLines: current_user.created_lines})
>>>>>>> Working UserShow websocket for total users in each line
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
