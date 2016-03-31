class Episode < ActiveRecord::Base
  belongs_to :content_provider
  has_many :comments
end
