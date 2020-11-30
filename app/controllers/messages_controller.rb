class MessagesController < ApplicationController

  def create
    Message.create(
      content: params[:message][:content],
      user: current_user,
      conversation: Conversation.find(params[:conversation_id])
    )

    redirect_back(fallback_location: conversations_path)
  end

end
