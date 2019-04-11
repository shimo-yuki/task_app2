// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require rails-ujs
//= require activestorage
//= require turbolinks
//= require_tree .
//= require jquery3
//= require popper
//= require jquery
//= require cocoon
//= require bootstrap-sprockets
$(function() {
  $('[name="radio"]:radio').change( function() {
    if($('[id=1]').prop('checked')){
      $('.teams').fadeOut();
      $('.users').fadeIn();
    } else if ($('[id=2]').prop('checked')) {
      $('.users').fadeOut();
      $('.teams').fadeIn();
    }
  });
});

$(function($) {
   $('#team_name').change(function(){
   var team_id = $("#team_name").val();
   $.get("new.js?team_id=" + team_id);
    });
});

// $(document).ready(function () {
//   $('.team_name').change(function(){
//     var team_id = $('#form [name=team_name]').val();
//     $.ajax({
//             url: "new",
//             type: "GET",
//             data: team_id,
//             dataType: "html",
//             success: function(data) {
//               console.log(team_id);
//             },
//             error: function(data) {
//                 alert(data);
//             }
//         });
//
//   });
// });
