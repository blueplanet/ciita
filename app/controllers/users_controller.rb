class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user, only: %i(show follow unfollow)

  def show
    @last_items = @user.items.page(params[:page])
  end

  def follow
    current_user.follow(@user)
    redirect_to @user
  end

  def unfollow
    current_user.stop_following(@user)
    redirect_to @user
  end

  private

    def set_user
      @user = User.find params[:id]
    end
end
