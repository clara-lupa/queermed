class Conversation < ApplicationRecord
  belongs_to :user1, class_name: "User"
  belongs_to :user2, class_name: "User"
  has_many :messages, dependent: :destroy

  validates :user1, :user2, presence: true
  validate :has_two_different_users, if: :user1 && :user2

  def has_two_different_users
    errors.add(:user2, "must be different from user1") if user1 == user2
  end
end
