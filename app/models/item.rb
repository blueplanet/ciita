class Item < ActiveRecord::Base
  belongs_to :user

  acts_as_taggable
end
