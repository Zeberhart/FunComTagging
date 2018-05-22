class SessionsController < ApplicationController

  def new
    if session[:user_id]
        @user = current_user
        redirect_to current_comment
    end
  end

  def create
    @user = User.find_by(email: params[:session][:email].downcase)
    if @user && @user.authenticate(params[:session][:password])
      log_in @user
      redirect_to current_comment, notice: "You have been logged in successfully!"
    else
      flash.now[:alert] = 'Invalid email/password combination'
      render 'new'
    end
  end

  def destroy
    log_out
    redirect_to root_url
  end
end
