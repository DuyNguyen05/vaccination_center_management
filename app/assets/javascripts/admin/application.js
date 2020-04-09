// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require popper
//= require bootstrap

$(document).on("change", "select#sel1", function(){
  var $self = $(this);
  var previous = $(this).data('value');
  var role_id = $(this).val();
  var r = confirm("Bạn Chắc Chắn Muốn Cập Nhật Quyền ?");
  try {
    if( r == true ){
      $.ajax({
        url: $(this).closest("div").closest("form").attr("action"),
        method: "PATCH",
        dataType: "json",
        data: {role_id: role_id},
        error: function (xhr, status, error) {
          console.error('AJAX Error: ' + status + error);
        },
        success: function (response) {
          // debugger;
          // console.log(response);
          alert("Cập Nhật Thành Công");
        }
      });
    } else {
      console.log("haha");
      debugger;
      $(this).val(previous);
    }
  } catch(err) {
    console.log(err);
  }
});
