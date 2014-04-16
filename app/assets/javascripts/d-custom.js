$(document).ready(function () {
  $(".panel-heading").click(function () {
  	console.log('clicked');
    $(this).next(".panel-body > table.table").css('display', 'block');  
  });
});