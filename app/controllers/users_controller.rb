class UsersController < ApplicationController
  before_action :authenticate_user!

  def show
    @user = User.find params[:id]
    @last_items = @user.items.page(params[:page])
  end
end
