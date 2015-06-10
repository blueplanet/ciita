class Item < ActiveRecord::Base
  belongs_to :user
  has_many :comments, dependent: :nullify

  acts_as_taggable
  acts_as_followable

  validates :title, presence: true, length: { maximum: 200 }
  validates :body, presence: true, length: { maximum: 20000, minimum: 10 }

  scope :feed_items_for, -> (user) do
    joins(:taggings, :user).
    where 'taggings.tag_id IN (:tag_ids) OR users.id IN (:user_ids)',
      tag_ids: user.following_by_type(ActsAsTaggableOn::Tag.to_s).pluck(:id),
      user_ids: user.following_users.pluck(:id)
  end
end
