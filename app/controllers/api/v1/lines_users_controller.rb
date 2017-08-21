class Api::V1::LinesUsersController < ApplicationController

  def create
    # TODO validate users in auth controller
    # TODO ...make auth controller
    # byebug
    @user = User.find(request.headers[:Authorization])
    @line = Line.find_by(code: params[:code].upcase)
    if @line
      @line.users << @user
      render json: {line_id: @line.id}, status: 200
      # If association between lines & users is saved:
      ActionCable.server.broadcast "list_channel",
                                      user: @user,
                                      line: @line
    elsif !@line
      render json: {error: "Invalid line code"}, status: 404
    else
      render json: {error: "unknown error"}
    end
  end

end
