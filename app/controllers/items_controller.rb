class ItemsController < ApplicationController
  before_action :set_edit_item, only: %i(edit update)
  before_action :set_item, only: %i(show stock unstock)

  def index
    @items = Item.includes(:user, :tags).feed_items_for(current_user).order(created_at: :desc).page(params[:page])
  end

  def all
    @items = Item.includes(:user, :tags).order(created_at: :desc).page(params[:page])
  end

  def new
    @item = current_user.items.build
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

  def stock
    current_user.follow(@item)
    redirect_to @item
  end

  def unstock
    current_user.stop_following(@item)
    redirect_to @item
  end

  def preview
    render text: markdown(params[:md_body])
  end

  private

    def item_params
      params.require(:item).permit(:title, :body, :tag_list)
    end

    def set_edit_item
      @item = current_user.items.find params[:id]
    end

    def set_item
      @item = Item.find params[:id]
    end
end
