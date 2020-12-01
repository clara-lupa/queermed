class MessagesController < ApplicationController
  def create
    @message = Message.create(
      content: params[:message][:content],
      user: current_user,
      conversation: Conversation.find(params[:conversation_id])
    )
    ConversationChannel.broadcast_to(
      @message.conversation,
      render_to_string(partial: "conversations/message_card", locals: { message: @message, other: true })
    )

    redirect_back(fallback_location: conversations_path)
  end
end
