class Review < ApplicationRecord
  belongs_to :provider
  belongs_to :user
  # i deleted the presence validation for content bc actually content can be empty
  # (in that case the user has just left a recommendation without review)
  validates :user, :provider, presence: true
  validates :content, presence: true
end
