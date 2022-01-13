"use strict";

let decrementQuantity = (price) => {
  let input = document.getElementById("quantity_input");

  if (input.value > 1) {
    input.value--;
    calculatePrice(price, input.value);
  }

}

let incrementQuantity = (price, quantity) => {
  let input = document.getElementById("quantity_input");

  input.value++;
  calculatePrice(price, input.value);
}

let calculatePrice = (price, input) => {
  let price_element = document.getElementById("price");
  let currency = price_element.textContent.substring(0, 1);

  price_element.textContent = currency + (price * input).toFixed(2);
}

let stars = (score) => {
  for (var i = 0; i < 5; i++) {
    jQuery("#star_id_" + i).addClass("rate-empty");
 }

  score++;

  for (var i = 0; i < score; i++) {
    jQuery("#star_id_" + i).removeClass("rate-empty");
    jQuery("#star_id_" + i).addClass("rate-star");
 }

  document.getElementById("reviewRating").value = score;
}

let addToCart = () => {
  let cart = document.getElementById("cart");
  cart.textContent++;
}
