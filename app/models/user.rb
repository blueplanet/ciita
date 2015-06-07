class User < ActiveRecord::Base
  include Gravtastic
  gravtastic

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :items

  acts_as_follower
  acts_as_followable
end
