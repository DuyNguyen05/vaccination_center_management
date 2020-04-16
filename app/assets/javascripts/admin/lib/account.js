$(document).on("change", "select#sel1", function (e) {
  var $self = $(this);
  var previous = $(this).data("value");
  var role_id = $(this).val();
  var r = confirm("Bạn Chắc Chắn Muốn Cập Nhật Quyền ?");
  try {
    if (r) {
      $.ajax({
        url: $(this).closest("div").closest("form").attr("action"),
        method: "PATCH",
        dataType: "json",
        data: { role_id: role_id },
        error: function (xhr, status, error) {
          console.error("AJAX Error: " + status + error);
        },
        success: function (response) {
          console.log(role_id);
          alert("Cập Nhật Thành Công");
          $self.data("value", role_id);
        },
      });
    } else {
      alert("Đã Hủy Cập Nhật");
      $(this).val(previous);
    }
  } catch (err) {
    console.log(err);
  }
});
