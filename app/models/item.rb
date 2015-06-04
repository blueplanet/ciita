class Item < ActiveRecord::Base
  belongs_to :user
  has_many :comments, dependent: :nullify

  acts_as_taggable
  acts_as_followable

  validates :title, presence: true, length: { maximum: 200 }
  validates :body, presence: true, length: { maximum: 20000, minimum: 10 }
end
