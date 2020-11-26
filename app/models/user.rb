class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  has_many :user1_conversations, class_name: "Conversation", foreign_key: "user1_id", dependent: :destroy
  has_many :user2_conversations, class_name: "Conversation", foreign_key: "user2_id"
  has_many :shortlists
  has_many :providers, through: :shortlists
  has_one_attached :photo

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

end
