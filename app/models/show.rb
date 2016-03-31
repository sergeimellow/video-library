class Show < ActiveRecord::Base
  belongs_to :content_provider
  has_many :episodes
end
