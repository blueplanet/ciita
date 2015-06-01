class ItemsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_item, only: %i(edit update)

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

  def update
    if @item.update item_params
      redirect_to @item, notice: t('.updated')
    else
      render :edit
    end
  end

  private

    def item_params
      params.require(:item).permit(:title, :body, :tag_list)
    end

    def set_item
      @item = current_user.items.find params[:id]
    end
end
