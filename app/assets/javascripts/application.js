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
//= require_tree .
//= require jquery3
//= require popper
//= require jquery
//= require cocoon
//= require bootstrap-sprockets
$(function() {
  $('[name="radio"]:radio').change( function() {
    console.log('111')
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
  $('#team_id').on('change', function(){
   var team_id = $("#team_id").val();
    $.ajax({
      url : '/tasks/team_select?team_id=' + team_id,
      type : "GET",
      dataType : "json",
      success : function(data){
        for (var i = 0; i < data.length; i++) {
          $('#hoge').append('<option value=' + data[i].id + '>' + data[i].name + '</option>');
        }
        // console.log(data.responseJSON);
      }
    });
  });
});



$(function($) {
    $('#team-comment').on("click", function(e){
      e.preventDefault();
      var comment = $("#comment").val();
      var team_id = $("#team_id").val();
      var user_id = $("#user_id").val();
      var user_name = $("#user_name").val();
      $.ajax({
        url : '/team_comments/',
        type : "POST",
        dataType : "json",
        data : {
          comment: comment,
          team_id: team_id
        },
        success : function(data){
          $('#comment').val("");
          if(data.comment_id != null){
            $('.comment-notice').fadeOut();
            if(user_id == data.user_id){
              $('.box:last').append('<div class="mycomment"><div class="my-say"><p>' + data.comment +'</div></div>')
              $('.mycomment:last').append('<div class="my-say"><div class="link"><a class="btn-light" href="/team_comments/'+ data.comment_id +'/edit">編集</a></div></div>');
              $('.link:last').append('<a class="btn-light" href="/team_comments/'+ data.comment_id +'">削除</a>');
            } else{
              $('.box:last').append('<div>' + data.user_id + '</div>');
              $('.box:last').append('<div>' + data.comment + '</div>');
            }
          }else{
            $('.comment-notice').fadeIn();
          }
        }
        // console.log(data.responseJSON);
      });
    });


    $(function($) {
        $('.delete-comment').on("click", function(e){
          e.preventDefault();
            // console.log(data.responseJSON);
          });
        });


// });
// $(function($) {
//   setInterval(function(){
//     $.ajax({
//       url : '/team_comments/',
//       type : "POST",
//       dataType : "json",
//       success : function(data){
//         console.log(data)
//         if(data != null){
//           $('.box:last').append('<div>' + data.user_id + '</div>');
//           $('.box:last').append('<div>' + data.comment + '</div>');
//         }
//       }
//     });
//   },1000);
 });
// $(function($) {
//   $('.team-show').onroad(function(e){
//    var team_id = $("#team_id").val();
//    var user_id = $("#user_id").val();
//     $.ajax({
//       url : '/team/team_id=' + team_id,
//       type : "GET",
//       dataType : "json",
//       data : {
//         comment: comment,
//         team_id: team_id
//       },
//       success : function(data){
//         $('#comment').val("");
//         console.log(data)
//           console.log(data[i].comment)
//           if(user_id == data[i].user_id){
//             $('.box').append('<p>' + data[i].comment + '</p>');
//           } else{
//             $('.box').append('<div>' + data[i].user_id + '</div>');
//             $('.box').append('<div>' + data[i].comment + '</div>');
//           }
//         }
//       }
//         // console.log(data.responseJSON);
//     });
//   });
// });
