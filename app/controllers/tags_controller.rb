class TagsController < ApplicationController
  def show
    @tag = ActsAsTaggableOn::Tag.find_by! name: params[:id]
    @items = Item.tagged_with(@tag.name).page(params[:page])
  end
end
