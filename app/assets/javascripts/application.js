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

//= require jquery3
//= require popper
//= require jquery
//= require cocoon
//= require bootstrap-sprockets
//= require data-confirm-modal
//= require moment
//= require moment/ja.js
//= require tempusdominus-bootstrap-4.js


$(function(){
  $('#team-comment').on("click", function(e){
    e.preventDefault();
    var comment = $("#comment").val();
    var team_id = $("#team_id").val();
    $.ajax({
      type: 'POST',
      url: '/team_comments',
      dataType: 'json',
      data : {
        comment: comment,
        team_id: team_id
      },
      success : function(data){
        $('#comment').val("");
        if(data.comment_id != null){
          $('.comment-notice').fadeOut();
          $('#alert').empty();
          $('#alert').append('<p class="alert-success text-center" ,="" id="notice">コメントを作成しました。</p>');
          $('.box:last').append('<div class="mycomment"><div class="my-say"><p>' + data.comment +'</div></div>')
          $('.mycomment:last').append('<div class="my-say"><div class="link"><a class="btn-light"  style="background-color: #fff;" href="/team_comments/'+ data.comment_id +'/edit">編集</a></div></div>');
          $('.link:last').append('<a class="btn-light" style="background-color: #fff;" href="/team_comments/'+ data.comment_id +'">削除</a>');
        }else{
          $('.comment-notice').fadeIn();
        }
      }
    });
  });
});
$(function($) {
  var num = 0;
  var index
  $(document).on("click", '.edit-comment', function () {
    $(this).data("click", ++num);
    var click = $(this).data("click");
    if(click <= 1){
    index = $('.edit-comment').index(this);
    $('.n' + index).hide();
    $('.e' + index).show();
    }else{
      var index2 = index
      index = $('.edit-comment').index(this);
      $('.e' + index2).hide();
      $('.n' + index2).show();
      $('.n' + index).hide();
      $('.e' + index).show();
    }
  });
});


$(function(){
  $('.js-count').keyup(function(){
    var count = $(this).val().length;
    if(count <= 0 || count > 50){
      $('.submit-edit').prop('disabled',true)
    }else{
      $('.submit-edit').prop('disabled',false)
    }
  });
});