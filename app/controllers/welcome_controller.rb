class WelcomeController < ApplicationController
  def index
    if session[:user_id]
      @user = current_user
      redirect_to current_comment
    end
  end
  def tutorial
    @user = current_user
  end
end
