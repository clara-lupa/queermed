class ConversationsController < ApplicationController
  def create
    @conversation = Conversation.create(
      user1: current_user,
      user2: User.find(params[:user_id]),
      provider: Provider.find(params[:provider_id])
    )

    @conversation.save
    redirect_to conversation_path(@conversation)
  end

  def index
    @user = current_user
    @user1_conversations = @user.user1_conversations
    @user2_conversations = @user.user2_conversations
    @conversations = @user1_conversations + @user2_conversations
    @conversations.reject! { |con| con.messages.empty? }
  end

  def show
    @conversation = Conversation.find(params[:id])
    @message = Message.new
    session[:come_from_search] = false
  end
end
