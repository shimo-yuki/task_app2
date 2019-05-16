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

$(function() {
  $('[class="status"]:radio').change( function() {
    if($('[id=1]').prop('checked')){
      $('#teams').fadeOut();
      $('#user-select-box').fadeIn();
      var value = $('#task_team_user_id_1').val();
      $('#task_user_id_1').prop('disabled',false);
      if(value != undefined) {
        $('.team_user-select-box-sub').remove();
        $('.team_id').prop('disabled',false);
        $('#team_user-select-box').append('<div class="input-group team_user-select-box-sub mb-2"></div>')
      }
    } else if ($('[id=2]').prop('checked')) {
      $('#user-select-box').fadeOut();
      $('#teams').fadeIn();
      $('#task_user_id_1').prop('disabled',true);
      var value = $('#task_user_id_2').val();
      if(value != undefined) {
        $('.remove-user-form').remove();
        $('#user_additional_button').prop('disabled',false);
        $(`#task_user_id_1`).prop('disabled',false);
      }
    }
  });
});

$(function($) {
  $(document).on("change", "#team_id", function () {
    $('#team_user-select-box').empty();
   var team_id = $("#team_id").val();
   $('#team_user-select-box').append('<div class="input-group team_user-select-box-sub mb-2"></div>')
   $('.team_user-select-box-sub').append('<select id="task_team_user_id_1" class="form-control disabled_users layout-form" name="task[user_ids][]"><span class="input-group-btn"></select><button type="button" id="team_user_additional_button" class="btn btn-info layout-btn ">＋</button><button type="button" id="team_user_delete_button" class="btn btn-info layout-btn">−</button></span>')
    $.ajax({
      url : '/tasks/team_select?team_id=' + team_id,
      type : "GET",
      dataType : "json",
      success : function(data){
        for (var i = 0; i < data.length; i++) {
          $('#task_team_user_id_1').append('<option value ="'+ data[i].id + '"> '+ data[i].name + '</option>');
        }
      }
    });
  });
});

$(function($) {
  $(document).on("click", "#team_user_additional_button", function () {
    //selectタグの数を数える
    var selectCount = $('.team_user-select-box-sub').children('select').length;
    $(`#task_team_user_id_${selectCount}`).prop('disabled',true);
    $('.team_id').prop('disabled',true);
      $("#team_user_delete_button").prop('disabled',false);
    //そのselectタグの中のoptionの数を数える
    var optionCount = $(`#task_team_user_id_${selectCount}`).children('option').length;
    //現在選択されているオプションのvalをとってくる
    var user_ids = [];
    user_ids = $(`#task_team_user_id_${selectCount} option:not(:selected)`);

    if(optionCount > 1){
      $('#team_user-select-box:last').append('<div class="input-group team_user-select-box-sub mb-2"></div>')
      $('.team_user-select-box-sub:last').append(`<select name="task[user_ids][]" class="form-control disabled_users" id="task_team_user_id_${selectCount + 1}"></select>`);
      for (var i = 0; i < optionCount - 1; i++) {
        $(`#task_team_user_id_${selectCount + 1}`).append('<option value ="'+ user_ids[i].value + '"> '+ user_ids[i].innerText + '</option>');
      }
    }else{
      $('#team_user_additional_button').prop('disabled',true);
    }
  });
});

$(function($) {
  $(document).on("click", "#user_delete_button", function () {
    var selectCount = $('.user-select-box-sub').children('select').length;
    $('#user_additional_button').prop('disabled',false);
    if(selectCount <= 1){
      $("#user_delete_button").prop('disabled',true);
    } else {
      $("#user_delete_button").prop('disabled',false);
      $(`#task_user_id_${selectCount}`).unwrap();
      $(`#task_user_id_${selectCount}`).remove();
      $(`#task_user_id_${selectCount - 1}`).prop('disabled',false);
    }
  });
});

$(function($) {
  $(document).on("click", "#team_user_delete_button", function () {
    var selectCount = $('.team_user-select-box-sub').children('select').length;
    $('#team_user_additional_button').prop('disabled',false);
    if(selectCount <= 1){
      $('.team_user-select-box-sub').remove();
      $('.team_id').prop('disabled',false);
    } else {
      $("#team_user_delete_button").prop('disabled',false);
      $(`#task_team_user_id_${selectCount}`).unwrap();
      $(`#task_team_user_id_${selectCount}`).remove();
      $(`#task_team_user_id_${selectCount - 1}`).prop('disabled',false);
    }
  });
});


//task_form user add
$(function($) {
  $('#user_additional_button').on('click', function(){
    //selectタグの数を数える
    var selectCount = $('.user-select-box-sub').children('select').length;
    $("#user_delete_button").prop('disabled',false);
    $(`#task_user_id_${selectCount}`).prop('disabled',true);
    //そのselectタグの中のoptionの数を数える
    var optionCount = $(`#task_user_id_${selectCount}`).children('option').length;
    //現在選択されているオプションのvalをとってくる
    var user_ids = [];
    user_ids = $(`#task_user_id_${selectCount} option:not(:selected)`);
    if(optionCount > 1){
      $('#user-select-box:last').append('<div class="input-group user-select-box-sub remove-user-form mb-2"></div>')
      $('.user-select-box-sub:last').append(`<select name="task[user_ids][]" class="user_form form-control layout-form" id="task_user_id_${selectCount + 1}"></select><span class="input-group-btn"></span>`);
      for (var i = 0; i < optionCount - 1; i++) {
        $(`#task_user_id_${selectCount + 1}`).append('<option value ="'+ user_ids[i].value + '"> '+ user_ids[i].innerText + '</option>');
      }
    }else{
      $('#user_additional_button').prop('disabled',true);
    }
  });
});


//コメント機能


function DisabledFalse(){
  var assign = $("input[name='task[assign]']:checked").val();
  if(assign == 1){
    $('.user_form').prop('disabled',false);
  }else if(assign == 2){
    $('.team_id').prop('disabled',false);
    $('.disabled_users').prop('disabled',false);
  }
}


function hiraku(tgt){ // 開く
  if (document.getElementById){
    tar=document.getElementById(tgt);
    tar.style.display="";
  }
}
  
  function toziru(tgt){ // 閉じる
  if (document.getElementById){
    tar=document.getElementById(tgt);
    tar.style.display="none";
  }
}