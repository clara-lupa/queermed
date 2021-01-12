class Provider < ApplicationRecord
  geocoded_by :address
  after_validation :geocode, if: :will_save_change_to_address?
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :specialty, presence: true
  validates :address, presence: true

  has_many :reviews, dependent: :destroy
  has_many :shortlists, dependent: :destroy
  has_many :users, through: :shortlists

  def shortlisted(user)
    # returns whether this provider is shortlisted by the user passed as an argument
    return users.include?(user)
  end

  def distance(coordinates)
    # returns distance in km, argument should be an address string
    dist = distance_to(coordinates) if coordinates
    dist.round(3) if dist
  end

  def has_recommendations?
    reviews.any? { |review| !review.content.present? }
  end

  def has_reviews?
    reviews.any? { |review| review.content.present? }
  end
end
