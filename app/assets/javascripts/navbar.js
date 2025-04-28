document.addEventListener("turbolinks:load", function () {
    const hamburgerBtn = document.querySelector("#hamburger");
    const navMenu = document.querySelector('#navbar-menu');
  
    const dropdownBtn = document.querySelector("#dropdownNavbarLink");
    const dropdownMenu = document.querySelector("#dropdownNavbar");
  
    // Toggle mobile menu
    if (hamburgerBtn) {
      hamburgerBtn.addEventListener("click", function () {
        navMenu.classList.toggle("hidden");
      });
    }
  
    // Toggle dropdown menu
    if (dropdownBtn) {
      dropdownBtn.addEventListener("click", function (e) {
        // e.stopPropagation(); // prevent closing when clicking on the button itself
        dropdownMenu.classList.toggle("hidden");
      });
    }
  
    // Close dropdown when clicking outside
    document.addEventListener("click", function (e) {
      if (
        !dropdownBtn.contains(e.target) &&
        !dropdownMenu.contains(e.target)
      ) {
        dropdownMenu.classList.add("hidden");
      }
    });
  });
  