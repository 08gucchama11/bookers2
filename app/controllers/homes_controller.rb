class HomesController < ApplicationController
  skip_before_action :require_authentication

  def top
  end
  def about
  end
end
