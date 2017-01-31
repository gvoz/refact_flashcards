module Home
  # class for login
  class UserSessionsController < ApplicationController
    skip_after_action :track_action, only: [:create]

    def new
      if current_user
        redirect_to root_path
      else
        @user = User.new
      end
    end

    def create
      if @user = login(params[:email], params[:password])
        ahoy.track "Login", type: :email
        redirect_back_or_to root_path, notice: t('.success')
      else
        flash.now[:alert] = t('.error')
        render action: 'new'
      end
    end
  end
end
