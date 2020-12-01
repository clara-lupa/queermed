const resetEnvelope = () => {
  const conversationsDiv = document.getElementById("inbox")
  if (conversationsDiv) {
    const envelope = document.getElementById("envelope-icon")
    envelope.style.visibility = "hidden"
  }
};

export { resetEnvelope }
