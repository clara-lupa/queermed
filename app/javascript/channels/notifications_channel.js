import consumer from "./consumer";

const initNotificationsCable = () => {
  const userDiv = document.querySelector(".user")
  if (userDiv) {
    const envelope = document.getElementById("envelope-icon")
    console.log(envelope)
    const id = userDiv.dataset.userId;
    consumer.subscriptions.create({ channel: "NotificationsChannel", id: id }, {
      received(data) {
        envelope.style.visibility = "visible"
      }
    });

  }
}

export { initNotificationsCable };
