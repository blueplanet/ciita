class TagsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_tag, only: %i(show follow unfollow)

  def show
    @items = Item.tagged_with(@tag.name).page(params[:page])
  end

  def follow
    current_user.follow(@tag)
    redirect_to tag_path(id: @tag.name)
  end

  def unfollow
    current_user.stop_following(@tag)
    redirect_to tag_path(id: @tag.name)
  end

  private

    def set_tag
      @tag = ActsAsTaggableOn::Tag.find_by! name: params[:id]
    end
end
