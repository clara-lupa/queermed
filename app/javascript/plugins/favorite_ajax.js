const favoriteAjax = () => {
 const stars  = document.querySelectorAll(".star")

 stars.forEach((star) => {
   star.addEventListener("click", () => {
     console.log(star)
   });

 });

};


export { favoriteAjax }


// fetch(url).then((response) => {});
