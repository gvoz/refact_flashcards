module Home
  # class for login with provider
  class OauthsController < ApplicationController
    # sends the user on a trip to the provider,
    # and after authorizing there back to the callback url.
    def oauth
      login_at(auth_params[:provider])
    end

    def callback
      provider = auth_params[:provider]
      if @user = login_from(provider)
        redirect_to trainer_path, notice: t('.success', provider: provider.titleize)
      else
        begin
          @user = create_from(provider)
          reset_session
          auto_login(@user)
          redirect_to trainer_path, notice: t('.success', provider: provider.titleize)
        rescue
          redirect_to user_sessions_path, alert: t('.error', provider: provider.titleize)
        end
      end
    end

    private

    def auth_params
      params.permit(:code, :provider)
    end
  end
end
