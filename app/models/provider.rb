class Provider < ApplicationRecord
  geocoded_by :street
  after_validation :geocode, if: :will_save_change_to_street?
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :specialty, presence: true
  validates :street, :city, presence: true

  has_many :reviews, dependent: :destroy
  has_many :shortlists, dependent: :destroy
  has_many :users, through: :shortlists


  def shortlisted(user)
    if users.include?(user)
      shortlists.find_by(user: user)
    end

  def distance(location)
    # returns distance in km, argument should be an address string
    distance_to(Geocoder.search(location).first.coordinates).round(3) if location
  end

  def has_recommendations?
    reviews.any? { |review| !review.content.present? }

  end
end
