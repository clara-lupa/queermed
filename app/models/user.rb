class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  has_many :user1_conversations, class_name: "Conversation", foreign_key: "user1_id", dependent: :destroy
  has_many :user2_conversations, class_name: "Conversation", foreign_key: "user2_id", dependent: :destroy
  has_many :shortlists
  has_many :reviews
  has_many :providers, through: :shortlists
  # call .user2s on a User instance to get all users the instance has contacted
  has_many :user2s, through: :user1_conversations, class_name: "User", source: "user2"
  # call .user1s on a User instance to get all users the instance was contacted by
  has_many :user1s, through: :user2_conversations, class_name: "User", source: "user1"
  has_one_attached :photo
  validates :avatar, presence: true

  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :validatable

  def conversation?(other_user, provider)
    # return the conversation the user instance has with other_user about provider
    # or false/nil if the instance has no such conversation yet
    return false unless (user2s + user1s).include? other_user

    if user2s.include? other_user
      user1_conversations.find do |conversation|
        conversation.user2 == other_user && conversation.provider == provider
      end
    else
      user2_conversations.find do |conversation|
        conversation.user1 == other_user && conversation.provider == provider
      end
    end
  end

  def recommended?(provider)
    reviews.find { |review| review.provider == provider }
  end
end
