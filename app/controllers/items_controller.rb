class ItemsController < ApplicationController
  before_action :authenticate_user!

  def index
    @items = Item.order(created_at: :desc).page(params[:page])
  end
end
