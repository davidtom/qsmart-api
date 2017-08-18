class Api::V1::LinesUsersController < ApplicationController

  def create
    # TODO validate users in auth controller
    # TODO ...make auth controller
    byebug
    @user = User.find(request.headers[:Authorization])
    @line = Line.find_by(code: params[:code].upcase)
    if @line
      @line.users << @user
      render json: @line.users.length
    else
      render json: {error: "Invalid line code"}
    end
  end

end
