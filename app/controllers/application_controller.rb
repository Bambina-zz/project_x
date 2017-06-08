class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper

  def check_authorized
    unless current_user
      redirect_to login_path, status: :unauthorized
    end
  end
end
