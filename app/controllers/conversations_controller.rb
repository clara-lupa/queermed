class ConversationsController < ApplicationController
  def new
    @conversation = Conversation.new
  end

  def create
    @conversation = conversation.new
    @conversation.user1 = current_user
    # next line has to be changed as soon as i figured out how to get user2^^
    @conversation.user2 = User.last
  end

  def index
    @user1_conversations = current_user.user1_conversations
    @user2_conversations = current_user.user2_conversations
    @conversations = @user1_conversations + @user2_conversations
  end

  def show
    # think about authentification here, only visible to users involved in that conversation
    @conversation = Conversation.find(params[:id])
  end
end
