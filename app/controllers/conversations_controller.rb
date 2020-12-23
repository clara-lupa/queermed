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
      .where(["user1_id = :id OR user2_id = :id", { id: @user.id.to_s }])
      .order("updated_at")
  end

  def show
    @conversation = Conversation.find(params[:id])
    @message = Message.new
    session[:come_from_search] = false
  end
end
