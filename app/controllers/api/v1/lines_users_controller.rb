class Api::V1::LinesUsersController < ApplicationController
  before_action :authenticate_user
  after_commit :broadcast, on: [:create, :update, :destroy]

  def broadcast
    sleep(0.5)
    LineJoinedChannel.broadcast_to(@line, @line.waiting_users)
    LineChannel.broadcast_to(@line, {line: @line, users: @line.waiting_users})
  end

  def create
    @user = current_user
    @line = Line.find_by(code: params[:code].upcase)
    if @line
      @record = LinesUser.new(user_id: @user.id, line_id: @line.id)
      if @record.save
        send_create_text(@line)
        # sleep(1.0)
        # LineJoinedChannel.broadcast_to(@line, @line.waiting_users)
        # LineChannel.broadcast_to(@line, {line: @line, users: @line.waiting_users})
        render json: {line_id: @line.id}, status: 200
      elsif @line.active == false
        render json: {error: "Line is not active at this time", line: @line}, status: 422
      else
        render json: {error: "User already member of that line", line: @line}, status: 422
      end
    elsif !@line
      render json: {error: "Invalid line code"}, status: 404
    else
      render json: {error: "unknown error"}
    end
  end

  def update
    # NOTE: below find depends on the fact that a user is only ever waiting in a line once!
    @record = LinesUser.find_by(user_id: params[:user], line_id: params[:line], waiting: true)
    if @record.update(waiting: false)
      send_text(Line.find(params[:line]))
      @line = Line.find(params[:line])
      # sleep(1.0)
      # LineJoinedChannel.broadcast_to(@line, @line.waiting_users)
      # LineChannel.broadcast_to(@line, {line: @line, users: @line.waiting_users})
      render json: {}, status: 204
    else
      render json: {error: "unable to update"}, status: 500
    end
  end

  def destroy
    # NOTE: below find depends on the fact that a user is only ever waiting in a line once!
    # TODO: Add workaround; I think this might be breaking the websockets when a user rejoins a line they've already joined
    @record = LinesUser.find_by(user_id: params[:user], line_id: params[:line], waiting: true)
    if @record.destroy
      send_text(Line.find(params[:line]))
      @line = Line.find(params[:line])
      # sleep(1.0)
      # LineJoinedChannel.broadcast_to(@line, @line.waiting_users)
      # LineChannel.broadcast_to(@line, {line: @line, users: @line.waiting_users})
      render json: {}, status: 204
    else
      render json: {error: "unable to delete"}, status: 500
    end
  end

  private
  def send_text(line)
    if line.users.count > 2
      data = "You're up next in line: #{line.name}!"
      @client = Twilio::REST::Client.new Figaro.env.twilio_account_sid, Figaro.env.twilio_auth_token
      begin
        message = @client.messages.create(
            body: data,
            to: line.users.second.phone_number,
            from: Figaro.env.twilio_phone_number)
      rescue Twilio::REST::RestError
        puts "Error sending text"
      end
    end
  end

  def send_create_text(line)
    line_id = line.id
    data = "Welcome to QSmart! Position: #{line.user_count}; Link: http://localhost:3001/lines/#{line_id}"
    @client = Twilio::REST::Client.new Figaro.env.twilio_account_sid, Figaro.env.twilio_auth_token
    begin
    message = @client.messages.create(
        body: data,
        to: current_user.phone_number,
        from: "+14243432797")
    rescue Twilio::REST::RestError
      puts "Error sending text"
    end
  end

end
