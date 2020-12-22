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
    @conversations =
      Conversation
      .includes(:user1, :user2)
      .where("user1_id=#{current_user.id} OR user2_id=#{current_user.id}")

    # @user1_conversations = @user.user1_conversations
    # @user2_conversations = @user.user2_conversations
    # @conversations = @user1_conversations + @user2_conversations
    # @conversations.reject! { |con| con.messages.empty? }
    # @conversations.sort_by! { |con| con.messages.last.created_at }
  end

  def show
    @conversation = Conversation.find(params[:id])
    @message = Message.new
    session[:come_from_search] = false
  end
end
