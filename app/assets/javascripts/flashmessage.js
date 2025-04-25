document.addEventListener("turbolinks:load", function () {
    const flashBtn = document.querySelector("#flash-cancle-btn");
    const flashMsg = document.querySelector("#flash-msg");
  
    if (flashBtn && flashMsg) {
      flashBtn.addEventListener("click", function () {
        flashMsg.classList.add("hidden");
      });
    }
  });
  