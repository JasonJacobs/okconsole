class Post < ActiveRecord::Base

  acts_as_votable
  belongs_to :language
  belongs_to :emoticon
  has_one :image
  belongs_to :user

  validates :top_copy, presence: true
end
