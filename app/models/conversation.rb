class Conversation < ApplicationRecord
  belongs_to :user1, class_name: "User"
  belongs_to :user2, class_name: "User"
  belongs_to :provider
  has_many :messages, dependent: :destroy

  validates :user1, :user2, :provider, presence: true
  validate :two_different_users?, if: :user1 && :user2

  def two_different_users?
    errors.add(:user2, "must be different from user1") if user1 == user2
  end

  def other_user(current_user)
    return unless current_user

    current_user == user1 ? user2 : user1
  end
end
