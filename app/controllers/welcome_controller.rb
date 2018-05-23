class WelcomeController < ApplicationController
  def index
    @user = current_user
    if @user 
      redirect_to current_comment
    end
  end
  def tutorial
    @user = current_user
  end
end
