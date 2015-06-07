class UsersController < ApplicationController
  include Followable

  before_action :authenticate_user!
  before_action :set_user, only: %i(show follow unfollow)

  def show
    @last_items = @user.items.page(params[:page])
  end

  private

    def set_user
      @user = User.find params[:id]
    end

    def follow_target
      @user
    end

    def redirect_path_for_follow_action
      @user
    end
end
