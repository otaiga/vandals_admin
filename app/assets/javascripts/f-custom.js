$(document).ready(function () {
// Show/Hide Tournaments and Fixtures
   $(".tournament-header").click(function () {
	      $(this).closest(".table").toggleClass("section-show");
	    });

// Flash Notice Fadeout
   //Flash Fadeout
    $('.alert').fadeOut(5000);
});