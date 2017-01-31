module Dashboard
  # base controller for Dashboard
  class BaseController < ApplicationController
    before_action :require_login

    private

    def not_authenticated
      redirect_to login_path, alert: t(:please_log_in)
    end
  end
end
