class TagsController < ApplicationController
  include Followable

  before_action :authenticate_user!
  before_action :set_tag, only: %i(show follow unfollow)

  def show
    @items = Item.includes(:user, :tags).tagged_with(@tag.name).page(params[:page])
  end

  private

    def set_tag
      @tag = ActsAsTaggableOn::Tag.find_by! name: params[:id]
    end

    def follow_target
      @tag
    end

    def redirect_path_for_follow_action
      tag_path(id: @tag.name)
    end
end
