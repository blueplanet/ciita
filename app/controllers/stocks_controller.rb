class StocksController < ApplicationController
  before_action :authenticate_user!

  def index
    @stocks = current_user.following_items.order(updated_at: :desc).page(params[:page])
  end
end
