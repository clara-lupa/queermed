class Provider < ApplicationRecord
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
  end
end
