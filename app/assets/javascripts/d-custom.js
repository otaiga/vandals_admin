$(document).ready(function () {
// Show/Hide Tournaments and Fixtures
   $(".tournament-header").click(function () {
	      $(this).closest(".tournament-header").toggleClass("section-show");
	    });

// Flash Notice Fadeout
   //Flash Fadeout
    $('.alert').fadeOut(5000);
});