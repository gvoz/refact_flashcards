# ApplicationController
class ApplicationController < ActionController::Base
  include Pundit
  after_action :track_action

  protect_from_forgery with: :exception
  before_action :set_locale

  rescue_from Pundit::NotAuthorizedError, with: :not_found

  private

  def set_locale
    locale = if current_user
               current_user.locale
             elsif params[:user_locale]
               params[:user_locale]
             elsif session[:locale]
               session[:locale]
             else
               http_accept_language.compatible_language_from(I18n.available_locales)
             end

    if locale && I18n.available_locales.include?(locale.to_sym)
      session[:locale] = I18n.locale = locale
    else
      session[:locale] = I18n.locale = I18n.default_locale
    end
  end

  def default_url_options(options = {})
    { locale: I18n.locale }.merge options
  end

  def not_found
    flash[:alert] = 'Вы обратились к несуществующей записи.'
    redirect_to root_path
  end

  def track_action
    ahoy.track "Visited:#{controller_name}:#{action_name}", request.filtered_parameters
  end
end
