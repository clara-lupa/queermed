
import consumer from "./consumer";

const initConversationCable = () => {
  const messagesContainer = document.getElementById('messages');
  if (messagesContainer) {
    const id = messagesContainer.dataset.conversationId;


    consumer.subscriptions.create({ channel: "ConversationChannel", id: id }, {
      received(data) {
        // if messagesContainer do the following
        messagesContainer.insertAdjacentHTML('afterbegin', data);
        console.log("received data")
        // if envelop icon do:
        //  if icon hidden set it visible
      }
    });


  }
}

export { initConversationCable };
