class Message < ApplicationRecord
  belongs_to :conversation
  belongs_to :user
  validates :conversation, :user, :content, presence: true
  validate :sender_must_be_in_conversation, if: :user && :conversation

  def sender_must_be_in_conversation
    unless user == conversation.user1 || user == conversation.user2
      errors.add(:user, "Sender must be part of the conversation this message belongs to.")
    end
  end
end
