module Home
  # class for create user
  class UsersController < ApplicationController
    skip_after_action :track_action, only: [:create]

    def new
      if current_user
        redirect_to root_path
      else
        @user = User.new
      end
    end

    def create
      @user = User.new(user_params)
      if @user.save
        ahoy.track "User registration", email: @user.email
        auto_login(@user)
        redirect_to root_path, notice: t('.success')
      else
        render :new
      end
    end

    private

    def user_params
      params.require(:user).permit(:email, :password, :password_confirmation)
    end
  end
end
