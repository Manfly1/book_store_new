window.setTimeout(function() {
  hide_flashes();
}, 2500);

$(document).on('turbolinks:load', function() {
  $("#privacy_tab").click(function() {
    hide_flashes();
  });
});

let hide_flashes = () => {
  $(".alert").fadeTo(500, 0).slideUp(500, function(){
    $(this).remove();
  });
  
  $(".notice").fadeTo(500, 0).slideUp(500, function(){
    $(this).remove();
  });
}
