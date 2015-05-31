class TopsController < ApplicationController
  def show
    redirect_to items_path if user_signed_in?
  end
end
