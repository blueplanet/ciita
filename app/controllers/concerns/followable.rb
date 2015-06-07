module Followable
  extend ActiveSupport::Concern

  def follow_target
    raise NotImplementedError
  end

  def redirect_path_for_follow_action
    raise NotImplementedError
  end

  def follow
    current_user.follow(follow_target)
    redirect_to redirect_path_for_follow_action
  end

  def unfollow
    current_user.stop_following(follow_target)
    redirect_to redirect_path_for_follow_action
  end
end
