class WelcomeController < ApplicationController
  def index
   if signed_in?
    @user = current_user.full_name
    else
      @user = "Guest"
    end
  end
end
