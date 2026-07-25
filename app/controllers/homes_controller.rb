class HomesController < ApplicationController
  allow_unauthenticated_access only: [:top, :about]

  def top
  end

  def about
  end

  private

  def request_authentication
    session[:return_to_after_authenticating] = request.url
    redirect_to sign_in_path
  end
end
