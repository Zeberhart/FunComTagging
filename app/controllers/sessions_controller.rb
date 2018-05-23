class SessionsController < ApplicationController

  # GET /login
  def new
    if session[:user_id]
        @user = current_user
        redirect_to current_comment
    end
  end

  #POST /login
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

  # DELETE /logout
  def destroy
    log_out
    redirect_to root_url
  end
end
