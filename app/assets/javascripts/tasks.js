window.onload = function(){
  var task_id = $('#task_id').val();
  var user_ids = [];
  user_ids = $(`#users`);
  console.log(user_ids)

  $.ajax({
    type: 'GET',
    url: '/tasks/set_edit_task?task_id=' + task_id,
    dataType: 'json',
    success : function(data){
      if($('[id=1]').prop('checked')){
        $('#edit-user').append('<div id="user-select-box"></div>');
        for (var i = 0; i < data.length; i++) {
          $(`#task_user_id_${data[i].id - 1 } `).prop('disabled',true);
          var selectCount = $('.user-select-box-sub').children('select').length;
          var optionCount = $(`#task_user_id_${selectCount}`).children('option').length;
          var value = $('#option').val();
          $('#user-select-box').append('<div class="input-group user-select-box-sub mb-2"></div>');
          $('.user-select-box-sub:last').append(`<select name="task[user_ids][]" class="user_form form-control layout-form" id="task_user_id_${data[i].id}"></select><span class="input-group-btn"></span>`);
          if(i <= 0){
            $('.input-group-btn').append('<button type="button" id="team_user_additional_button" class="btn btn-info layout-btn ">＋</button><button type="button" id="team_user_delete_button" class="btn btn-info layout-btn">−</button>')
          }
          $(`#task_user_id_${data[i].id}`).append('<option value ="'+ data[i].id + '", id:"option", selected:"selected"> '+ data[i].name + '</option>');

        }
      }
    }
  });
};


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
