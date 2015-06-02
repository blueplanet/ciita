class Comment < ActiveRecord::Base
  belongs_to :item, required: true
  belongs_to :user, reuqired: true

  validates :body, presence: true, length: { maximum: 20000 }
end
