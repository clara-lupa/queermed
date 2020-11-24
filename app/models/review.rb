class Review < ApplicationRecord
  belongs_to :provider
  belongs_to :user
  valdidates :content, presence: true
end
