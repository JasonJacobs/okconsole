class Language < ActiveRecord::Base
  has_many :users, :images
end
