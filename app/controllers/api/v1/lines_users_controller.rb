class Api::V1::LinesUsersController < ApplicationController
  before_action :authenticate_user

  def create
    # TODO validate users in auth controller
    # TODO ...make auth controller
    # byebug
    @user = current_user
    @line = Line.find_by(code: params[:code].upcase)
    if @line
      @line.users << @user
      line_id = @line.id

      data = "Welcome to QSmart! Position: #{@line.count}; Link: http://localhost:3001/lines/#{line_id}"

      @client = Twilio::REST::Client.new Figaro.env.twilio_account_sid, Figaro.env.twilio_auth_token
      message = @client.messages.create(
          body: data,
          to: current_user.phone_number,
          from: "+14243432797")

      render json: {line_id: @line.id}, status: 200
      # LineChannel.broadcast_to(@line, @line.waiting_users)
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
      
      render json: {}, status: 204
      @line = Line.find(params[:line])
      LineChannel.broadcast_to(@line, @line.waiting_users)
    else
      render json: {error: "unable to update"}, status: 500
    end

  end

  def destroy
    # NOTE: below find depends on the fact that a user is only ever waiting in a line once!
    @record = LinesUser.find_by(user_id: params[:user], line_id: params[:line], waiting: true)
    if @record.destroy
      send_text(Line.find(params[:line]))
      render json: {}, status: 204
      @line = Line.find(params[:line])
      # LineChannel.broadcast_to(@line, @line.waiting_users)
    else
      render json: {error: "unable to delete"}, status: 500
    end
  end

  private
  def send_text(@line)
    if @line.users.count > 2
      data = "You're up next in line: #{@line.name}!"
      @client = Twilio::REST::Client.new Figaro.env.twilio_account_sid, Figaro.env.twilio_auth_token
      message = @client.messages.create(
          body: data,
          to: @line.users.second.phone_number,
          from: Figaro.env.twilio_phone_number)
    end
  end

end
