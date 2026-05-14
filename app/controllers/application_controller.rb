class ApplicationController < ActionController::Base
  include Authentication
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern
  helper_method :current_user

  private

  def after_logout_url
    root_path
  end

  def require_login
    redirect_to new_session_path unless current_user
  end

end
