class Post < ActiveRecord::Base
  belongs_to :language
  belongs_to :emoticon
  has_one :image
end
