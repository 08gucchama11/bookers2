class SessionsController < ApplicationController
  rate_limit to: 10, within: 3.minutes, only: :create, with: -> { redirect_to new_session_url, alert: "Try again later." }
  skip_before_action :require_authentication, only: [:new, :create]

  

  def new
  end

  def create
    user = User.find_by(name: params[:name])
    if user&.authenticate(params[:password])
      start_new_session_for(user)
      flash[:notice] = "Signed in successfully."
      redirect_to user_path(user)
    else
      flash[:alert] = "Try another name or password."
      redirect_to new_session_path
    end
  end




  def destroy
    terminate_session
    redirect_to root_path, notice: "Signed out successfully."
  end


  private

  def after_authentication_url
    user_path(Current.user)
  end

end
