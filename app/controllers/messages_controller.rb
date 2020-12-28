class MessagesController < ApplicationController
  def create
    @message = Message.create(
      content: params[:message][:content],
      user: current_user,
      conversation: Conversation.find(params[:conversation_id])
    )

    broadcast_to_conversation_channel(@message)
    broadcast_to_notifications_channel(@message)

    redirect_back(fallback_location: conversations_path)
  end

  private

  def broadcast_to_conversation_channel(message)
    ConversationChannel.broadcast_to(
      message.conversation,
      nonSenderPartial: render_to_string(
        partial: "conversations/message_card",
        locals: { message: message, other: true }
      ),
      senderPartial: render_to_string(
        partial: "conversations/message_card",
        locals: { message: message, other: false }
      ),
      senderId: message.user.id.to_s
    )
  end

  def broadcast_to_notifications_channel(message)
    NotificationsChannel.broadcast_to(
      message.conversation.other_user(current_user),
      message: "hooray!"
    )
  end
end
