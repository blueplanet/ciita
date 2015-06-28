class TopsController < ApplicationController
  skip_before_action :authenticate_user!, only: %i(show)

  def show
    redirect_to items_path if user_signed_in?
  end
end
