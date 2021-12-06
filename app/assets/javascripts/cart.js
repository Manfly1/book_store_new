"use strict";

let incrementOrderItemQuantity = (id, price, discount) => {
  let input = document.getElementById("quantity_input" + id);

  input.value++;
  incrementTotals(id, price, discount);
}

let decrementOrderItemQuantity = (id, price, discount) => {
  let input = document.getElementById("quantity_input" + id);

  if (input.value > 1) {
    input.value--;
    decrementTotals(id, price, discount);
  }

}

let incrementTotalPrice = (price, discount) => {
  let price_element = document.getElementById("orderTotal");
  let currency = price_element.textContent.substring(0, 1);
  let old_price = parseFloat(price_element.textContent.substring(1).replace(",",""));

  price_element.textContent = currency + (old_price + price - discount).toFixed(2);
}

let decrementTotalPrice = (price, discount) => {
  let price_element = document.getElementById("orderTotal");
  let currency = price_element.textContent.substring(0, 1);
  let old_price = parseFloat(price_element.textContent.substring(1).replace(",",""));

  price_element.textContent = currency + (old_price - price + discount).toFixed(2);
}

let incrementSubPrice = (price) => {
  let price_element = document.getElementById("subTotal");
  let currency = price_element.textContent.substring(0, 1);
  let old_price = parseFloat(price_element.textContent.substring(1).replace(",",""));

  price_element.textContent = currency + (old_price + price).toFixed(2);
}

let decrementSubPrice = (price) => {
  let price_element = document.getElementById("subTotal");
  let currency = price_element.textContent.substring(0, 1);
  let old_price = parseFloat(price_element.textContent.substring(1).replace(",",""));

  price_element.textContent = currency + (old_price - price).toFixed(2);
}

let incrementItemSubPrice = (id, price) => {
  let price_element = document.getElementById("subPrice" + id);
  let currency = price_element.textContent.substring(0, 1);
  let old_price = parseFloat(price_element.textContent.substring(1).replace(",",""));

  price_element.textContent = currency + (old_price + price).toFixed(2);
}

let decrementItemSubPrice = (id, price) => {
  let price_element = document.getElementById("subPrice" + id);
  let currency = price_element.textContent.substring(0, 1);
  let old_price = parseFloat(price_element.textContent.substring(1).replace(",",""));

  price_element.textContent = currency + (old_price - price).toFixed(2);
}

let incrementCoupon = (discount) => {
  let price_element = document.getElementById("coupon");
  let currency = price_element.textContent.substring(0, 1);
  let old_price = parseFloat(price_element.textContent.substring(1).replace(",",""));

  price_element.textContent = currency + (old_price + discount).toFixed(2);
}

let decrementCoupon = (discount) => {
  let price_element = document.getElementById("coupon");
  let currency = price_element.textContent.substring(0, 1);
  let old_price = parseFloat(price_element.textContent.substring(1).replace(",",""));

  price_element.textContent = currency + (old_price - discount).toFixed(2);
}

let incrementTotals = (id, price, discount) => {
  incrementTotalPrice(price, discount)
  incrementSubPrice(price)
  incrementItemSubPrice(id, price)
  incrementCoupon(discount)
}

let decrementTotals = (id, price, discount) => {
  decrementTotalPrice(price, discount)
  decrementSubPrice(price)
  decrementItemSubPrice(id, price)
  decrementCoupon(discount)
}

let changeInput = (id, book_price, discount, prev_quantity) => {
  let input = document.getElementById('quantity_input'+id)
  let number = Math.abs(parseInt(input.value))
  if (Number.isNaN(number)) {
    input.value = 0
    number = 0
  }
  else {
    input.value = number
  }
  
  let price_element = document.getElementById("subPrice" + id);
  let old_price = parseFloat(price_element.textContent.substring(1).replace(",",""));
  let currency = price_element.textContent.substring(0, 1);
  let sub_price = parseInt(input.value) * book_price
  price_element.textContent = currency + (sub_price).toFixed(2)

  let prev_number = parseInt(old_price / book_price)
  let diff = Math.abs(number - prev_number)
  if (sub_price > old_price) {
    incrementTotalPrice(book_price * diff, discount * diff)
    incrementSubPrice(book_price * diff)
    incrementCoupon(discount * diff)
  }
  else if (sub_price < old_price) {
    decrementTotalPrice(book_price * diff, discount * diff)
    decrementSubPrice(book_price * diff)
    decrementCoupon(discount * diff)
  }
  
  if (number) {
    changeQuantityRequest(id, 'change', number)
  }
}


let changeQuantityRequest = (item_id, action, quantity) => {
  $.ajax({
    url: 'order_items/' + item_id,
    type: "PUT",
    data: { quantity_action: action, quantity: quantity},
    dataType: "json"
  });
}
