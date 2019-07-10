// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
$(document).ready(function(){
  setNavigation();

  $(".nav-item").click(function(e) {
    $(".active").removeClass('active');
    $(e.target).addClass('active');
  })

  $("input.quantity").change(function(e) {
    var id = $(this).data("id");
    var new_quantity = $(this).val();
    $.ajax({
      url: '/cart_items/update_quantity',
      type: "PATCH",
      data: { id: id, quantity: new_quantity },
      dataType: "json",
      success: function(data) {
        $(`#total-${id}`).html(data.total);
      },
      error: function(request, error){
        alert("Request: " + JSON.stringify(request));
      }
    })
  })
});

function setNavigation() {
  var path = window.location.pathname;
  path = path.replace(/\/$/, "");
  path = decodeURIComponent(path);

  if (path) {
    $(".nav-item a").each(function () {
      var href = $(this).attr('href');
      if (path.substring(0, href.length) == href) {
        $(this).closest('li').addClass('active');
      }
    })
  } else {
    $(".nav-item").first().addClass('active');
  }
}