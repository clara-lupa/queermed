const favoriteAjax = () => {
  const stars  = document.querySelectorAll(".star")
  if (stars) {
    stars.forEach((star) => {
      star.addEventListener("click", (event) => {
        const shortlistCard = document.getElementById(`${star.dataset.favoriteId}`)
        const icon = star.querySelector('i')
        if (shortlistCard && icon.classList.contains('fas')) {
          shortlistCard.style.display = 'none'
        }
        icon.classList.toggle('far')
        icon.classList.toggle('fas')
        const options = {
          headers: {
            "Content-Type": 'application/json'
          }
        }
        fetch(`/favorites/${star.dataset.favoriteId}/provider/${star.dataset.providerId}`, options)
      });
    });
  }
};


export { favoriteAjax }


// fetch(url).then((response) => {});
