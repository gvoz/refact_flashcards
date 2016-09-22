module Dashboard
  # class for destroy users
  class UsersController < Dashboard::BaseController
    def edit
    end

    def update
      if current_user.update(user_params)
        redirect_to edit_user_path,
                    notice: t('.success')
      else
        if user_params[:locale].nil?
          render template: 'dashboard/users/password.html.erb'
        else
          render :edit
        end
      end
    end

    def destroy
      current_user.destroy
      redirect_to login_path, notice: t('.success')
    end

    def password
      render
    end

    private

    def user_params
      params.require(:user).permit(:email, :password, :password_confirmation, :locale)
    end
  end
end
