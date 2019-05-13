
window.onload = function(){
  var task_id = $('#task_id').val();
  $.ajax({
    type: 'GET',
    url: '/tasks/set_edit_task?task_id=' + task_id,
    dataType: 'json',
    success : function(data){
      if($('[id=3]').prop('checked')){
        $('#user-select-box').fadeIn();
        $('#teams').fadeOut();
        for (var i = 1; i < data.length ; i++) {
          $(`#task_user_id_${i-1} `).prop('disabled',true);
          // var selectCount = $('.user-select-box-sub').children('select').length;
          var optionCount = $(`#task_user_id_${i-1}`).children('option').length;
          var user_ids = [];
          console.log(i, optionCount, data[i]);
          user_ids = $(`#task_user_id_${i-1} option:not(:selected)`);
          $('#user-select-box').append('<div class="input-group user-select-box-sub mb-2"></div>');
          $('.user-select-box-sub:last').append(`<select name="task[user_ids][]" class="user_form form-control layout-form edit_task_id_${i}" id="task_user_id_${i}"></select><span class="input-group-btn"></span>`);
          for (var j = 0; j < optionCount - 1; j++) {
            console.log(j, user_ids[j])
            if(data[i].id == user_ids[j].value){
            $(`#task_user_id_${i}`).append('<option value ="'+ user_ids[j].value + '" selected="selected"> '+ user_ids[j].innerText + '</option>');
            }else{
            $(`#task_user_id_${i}`).append('<option value ="'+ user_ids[j].value + '"> '+ user_ids[j].innerText + '</option>');
            }
          }
        }
      }else{
        $('#user-select-box').fadeOut();
        $('#teams').fadeIn();
        var team_id = $("#task_team_id").val();
         $.ajax({
           url : '/tasks/team_select?team_id=' + team_id,
           type : "GET",
           dataType : "json",
           success : function(team_data){
             $(".team_id").prop('disabled',true);
             for (var i = 0; i < data.length; i++) {
              $('#team_edit-select-box').append(`<div class="input-group team_user-select-box-sub mb-2" id="team_user_edit_id_${i}"></div>`);
              $(`#team_user_edit_id_${i}`).append(`<select id="task_team_user_id_${i}" class="form-control disabled_users layout-form edit_team_user_id_${i}" name="task[user_ids][]"><span class="input-group-btn" id="btn"></span></select>`);
              if(i < 1 ){
                $(`#team_user_edit_id_0`).append(`<button type="button" id="team_edit_additional_button" class="btn btn-info layout-btn ">＋</button><button type="button" id="team_edit_delete_button" class="btn btn-info layout-btn">−</button>`)
                for(var j = 0; j < team_data.length; j++){
                  if(data[i].id == team_data[j].id){
                    $(`#task_team_user_id_${i}`).append('<option value ="'+ team_data[j].id + '"selected="selected"> '+ team_data[j].name + '</option>');
                  }else{
                    $(`#task_team_user_id_${i}`).append('<option value ="'+ team_data[j].id + '"> '+ team_data[j].name + '</option>');
                  }
                }
              }else{
                $(`#task_team_user_id_${i - 1}`).prop('disabled',true);
                var user_ids = [];
                user_ids = $(`#task_team_user_id_${i-1} option:not(:selected)`);
                for(var j = 0; j < user_ids.length; j++){
                  if(data[i].id == user_ids[j].value){
                    $(`#task_team_user_id_${i}`).append('<option value ="'+ user_ids[j].value + '"selected="selected"> '+ user_ids[j].innerText  + '</option>');
                  }else{
                    $(`#task_team_user_id_${i}`).append('<option value ="'+ user_ids[j].value + '"> '+ user_ids[j].innerText  + '</option>');
                  }
                }
              }
            }
          }
        });
      }
    }
  });
};
$(function() {
  $('[class="status"]:radio').change( function() {
    if($('[id=3]').prop('checked')){
      $('#teams').fadeOut();
      $('#user-select-box').fadeIn();
      $('.remove-user-form').fadeIn();
      var value = $('#task_team_user_id_1').val();
      if(value != undefined) {
        $('.team_id').prop('disabled',false);
        $('#team_user-select-box').append('<div class="input-group team_user-select-box-sub mb-2"></div>')
      }
    } else if ($('[id=4]').prop('checked')) {
      $('#user-select-box').fadeOut();
      $('#teams').fadeIn();
      $('.team_user-select-box-sub').fadeIn();
      $('#task_user_id_1').prop('disabled',true);
      var value = $('#task_user_id_2').val();
      if(value != undefined) {
        $('.remove-user-form').fadeOut();
        $('#user_additional_button').prop('disabled',false);
      }
    }
  });
});

$(function($) {
  $(document).on("click", "#user_edit_delete_button", function () {
    var selectCount = $('.user-select-box-sub').children('select').length;

    $('#user_edit_additional_button').prop('disabled',false);
    if(selectCount <= 1){
      $("#user_edit_delete_button").prop('disabled',true);
    } else {
      $("#user_edit_delete_button").prop('disabled',false);
      $(`.edit_task_id_${selectCount-1}`).unwrap();
      $(`.edit_task_id_${selectCount-1}`).remove()
      $(`.edit_task_id_${selectCount-2}`).prop('disabled',false);
    }
  });
});

$(function($) {
  $('#user_edit_additional_button').on('click', function(){
    //selectタグの数を数える
    var selectCount = $('.user-select-box-sub').children('select').length;
    $("#user_edit_delete_button").prop('disabled',false);
    $(`.edit_task_id_${selectCount - 1}`).prop('disabled',true);

    //そのselectタグの中のoptionの数を数える
    var optionCount = $(`.edit_task_id_${selectCount-1}`).children('option').length;
    //現在選択されているオプションのvalをとってくる
    var user_ids = [];
    user_ids = $(`.edit_task_id_${selectCount-1} option:not(:selected)`);
    if(optionCount > 1){
      $('#user-select-box:last').append('<div class="input-group user-select-box-sub remove-user-form mb-2"></div>')
      $('.user-select-box-sub:last').append(`<select name="task[user_ids][]" class="user_form form-control layout-form edit_task_id_${selectCount}" id="task_user_id_${selectCount + 1}"></select><span class="input-group-btn"></span>`);

      for (var i = 0; i < optionCount - 1; i++) {
        $(`#task_user_id_${selectCount + 1}`).append('<option value ="'+ user_ids[i].value + '"> '+ user_ids[i].innerText + '</option>');
      }
    }else{
      $('#user_edit_additional_button').prop('disabled',true);
    }
  });
});

$(function($) {
  $(document).on("click", "#team_edit_additional_button", function () {
    //selectタグの数を数える
    var selectCount = $('.team_user-select-box-sub').children('select').length;
    // 前の要素とチームの部分をdisabledにして、deleteボタンはfalseにしている
    $(`#task_team_user_id_${selectCount-1}`).prop('disabled',true);
    $('.team_id').prop('disabled',true);
    $("#team_edit_delete_button").prop('disabled',false);
    //そのselectタグの中のoptionの数を数える
    var optionCount = $(`.edit_team_user_id_${selectCount-1}`).children('option').length;
    //現在選択されているオプションのvalをとってくる
    var user_ids = [];
    user_ids = $(`.edit_team_user_id_${selectCount-1} option:not(:selected)`);
    if(optionCount > 1){
      $('#team_edit-select-box:last').append('<div class="input-group team_user-select-box-sub mb-2"></div>')
      $('.team_user-select-box-sub:last').append(`<select name="task[user_ids][]" class="form-control disabled_users layout-form edit_team_user_id_${selectCount}" id="task_team_user_id_${selectCount}"></select>`);
      for (var i = 0; i < optionCount - 1; i++) {
        $(`#task_team_user_id_${selectCount}`).append('<option value ="'+ user_ids[i].value + '"> '+ user_ids[i].innerText + '</option>');
      }
    }else{
      $('#team_edit_additional_button').prop('disabled',true);
    }
  });
});

$(function($) {
  $(document).on("click", "#team_edit_delete_button", function () {
    var selectCount = $('.team_user-select-box-sub').children('select').length;
    $('#team_edit_additional_button').prop('disabled',false);
    console.log(selectCount);
    if(selectCount <= 1){
      console.log("1");
      $('.team_user-select-box-sub ').remove();
      $('.team_id').prop('disabled',false);
    } else {
      $("#team_edit_delete_button").prop('disabled',false);
      $(`.edit_team_user_id_${selectCount - 1}`).unwrap();
      $(`.edit_team_user_id_${selectCount - 1}`).remove()
      $(`.edit_team_user_id_${selectCount - 2}`).prop('disabled',false);
    }
  });
});

$(function($) {
  $(document).on("change", "#team_id", function () {
    $('#team_edit-select-box').empty();
   var team_id = $("#team_id").val();
   console.log(team_id);
   $('#team_edit-select-box').append('<div class="input-group team_user-select-box-sub mb-2" id="team_user_edit_id_0"></div>')
   $('.team_user-select-box-sub').append('<select id="task_team_user_id_0" class="form-control disabled_users layout-form edit_team_user_id_0" name="task[user_ids][]"><span class="input-group-btn"></select><button type="button" id="team_edit_additional_button" class="btn btn-info layout-btn ">＋</button><button type="button" id="team_edit_delete_button" class="btn btn-info layout-btn">−</button></span>')
   // $('#team_user-select-box div').remove();
    $.ajax({
      url : '/tasks/team_select?team_id=' + team_id,
      type : "GET",
      dataType : "json",
      success : function(data){
        console.log(data);
        for (var i = 0; i < data.length; i++) {
          $('#task_team_user_id_0').append('<option value ="'+ data[i].id + '"> '+ data[i].name + '</option>');
        }
      }
    });
  });
});

function EditDisabled(){
  var assign = $("input[name='task[assign]']:checked").val();
  if(assign == 1){
    $('.user_form').prop('disabled',false);
  }else if(assign == 2){
      $('.team_id').prop('disabled',false);
    $('.disabled_users').prop('disabled',false);
  }
}
