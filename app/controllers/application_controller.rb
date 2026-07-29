class ApplicationController < ActionController::Base
  include Authentication
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  private

  def request_authentication
    session[:return_to_after_authenticating] = request.url
    redirect_to sign_in_path
  end
  
end
