class CommentsController < ApplicationController
  before_action :authenticate_user!, :set_item

  def create
    @comment = @item.comments.build comment_params.merge(user: current_user)
    if @comment.save
      redirect_to @item, notice: t('.created')
    else
      redirect_to @item, alert: t('.no_created')
    end
  end

  private

    def set_item
      @item = Item.find params[:item_id]
    end

    def comment_params
      params.require(:comment).permit(:body)
    end
end
