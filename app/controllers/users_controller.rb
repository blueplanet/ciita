class UsersController < ApplicationController
  include Followable

  before_action :authenticate_user!
  before_action :set_user, only: %i(show follow unfollow)
  before_action :set_owner_user, only: %i(comments items stocks)

  def show
    @last_items = @user.items.includes(:tags).page(params[:page])
  end

  def comments
    @comments = @user.comments.includes(item: :user).order(created_at: :desc).page(params[:page])
  end

  def items
    @items = @user.items.includes(:tags).order(created_at: :desc).page(params[:page])
  end

  def stocks
    @stocks = @user.following_items.includes(:user, :tags).order(updated_at: :desc).page(params[:page])
  end

  private

    def set_user
      @user = User.find params[:id]
    end

    def set_owner_user
      @user = User.find params[:user_id]
    end

    def follow_target
      @user
    end

    def redirect_path_for_follow_action
      @user
    end
end
