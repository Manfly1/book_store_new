"use strict";

let account_destroy = () => {
  let checked = document.getElementById("agree").checked;
  let btn = document.getElementById("delete");

  if (checked) {
    btn.removeAttribute("disabled");
  }
  else {
    btn.setAttribute("disabled", "true");
  }

}
