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
      .joins(:messages)
      .distinct
      .where(["user1_id = :id OR user2_id = :id", { id: current_user.id.to_s }])
      .order("updated_at")

    # doesnt work with join cause that lists each conversation one more time per message...

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
