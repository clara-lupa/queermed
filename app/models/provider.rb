class Provider < ApplicationRecord
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :speciality, presence: true
  validates :address, presence: true
end
