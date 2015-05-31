class ItemsController < ApplicationController
  before_action :authenticate_user!

  def index
    @items = Item.order(created_at: :desc).page(params[:page])
  end

  def new
    @item = current_user.items.build
  end

  def show
    @item = Item.find params[:id]
  end

  def create
    @item = current_user.items.build item_params

    if @item.save
      redirect_to @item, notice: t('.created')
    else
      render :new
    end
  end

  private

    def item_params
      params.require(:item).permit(:title, :body, :tag_list)
    end
end
