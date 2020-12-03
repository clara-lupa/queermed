
import consumer from "./consumer";

const initConversationCable = () => {
  const messagesContainer = document.getElementById('messages');
  if (messagesContainer) {
    const id = messagesContainer.dataset.conversationId;
    const currentUserId = messagesContainer.dataset.userId


    consumer.subscriptions.create({ channel: "ConversationChannel", id: id }, {
      received(data) {
        if (data.senderId == currentUserId) {
          messagesContainer.insertAdjacentHTML('afterbegin', data.senderPartial);
        }
        else {
          messagesContainer.insertAdjacentHTML('afterbegin', data.nonSenderPartial);
        }
      }
    });


  }
}

export { initConversationCable };
