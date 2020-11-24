class Review < ApplicationRecord
  belongs_to :provider
  belongs_to :user
  validates :content, presence: true
end
