// $(document).ready(function() {
//   $(".injection_book").on("click", function(e){
//     var injectionBookPath = '<%= Rails.application.routes.url_helpers.user_injection_books_path %>/' + this.id;
//     location.replace(injectionBookPath)
//   });
// });

// $(document).ready(function(){

//   var current_fs, next_fs, previous_fs; //fieldsets
//   var opacity;

//   $(".next").click(function(){

//     current_fs = $(this).parent();
//     next_fs = $(this).parent().next();

//   //Add Class Active
//     $("#progressbar li").eq($("fieldset").index(next_fs)).addClass("active");

//   //show the next fieldset
//     next_fs.show();
//     //hide the current fieldset with style
//     current_fs.animate({opacity: 0}, {
//       step: function(now) {
//       // for making fielset appear animation
//       opacity = 1 - now;

//       current_fs.css({
//         'display': 'none',
//         'position': 'relative'
//       });
//       next_fs.css({'opacity': opacity});
//     },
//     duration: 600
//     });
//   });

//   $(".previous").click(function(){

//     current_fs = $(this).parent();
//     previous_fs = $(this).parent().prev();

//   //Remove class active
//     $("#progressbar li").eq($("fieldset").index(current_fs)).removeClass("active");

//   //show the previous fieldset
//     previous_fs.show();

//   //hide the current fieldset with style
//     current_fs.animate({opacity: 0}, {
//       step: function(now) {
//       // for making fielset appear animation
//       opacity = 1 - now;

//       current_fs.css({
//         'display': 'none',
//         'position': 'relative'
//       });
//       previous_fs.css({'opacity': opacity});
//     },
//       duration: 600
//     });
//   });

//   $('.radio-group .radio').click(function(){
//     $(this).parent().find('.radio').removeClass('selected');
//     $(this).addClass('selected');
//   });

//   $(".submit").click(function(){
//     return false;
//   })
// });

$(document).ready(function() {
  var vaccinesPath = '/user/vaccines';
  $('.select_vaccines').select2({
    width: '100%',
    ajax: {
      url: vaccinesPath,
      type: 'GET',
      delay: 1000,
      dataType: 'json',
      data: function(params) {
        return { vaccine_name: params.term }
      },
      processResults: function(data) {
        return { results: data.vaccines };
      }
    },
    vaccines: true,
    templateResult: formatResult,
    templateSelection: formatSelection,
  }).trigger('change');

  function formatResult(vaccine) {
    return vaccine.name;
  }

  function formatSelection(vaccine) {
    return vaccine.text || vaccine.name;
  }

  $('.select_vaccines').on('select2:select', function(e) {
    var vaccineName = e.params.data.id;
    if (typeof e.params.data.id === 'string') {
      $.ajax({
        url: vaccinesPath,
        type: 'POST',
        dataType: 'json',
        data: {
          vaccine: {
            name: vaccineName
          }
        },
      }).done(function(data) {
        $('option[value="' + data.vaccine.name + '"]').removeAttr('data-select2-vaccine');
        $('option[value="' + data.vaccine.name + '"]').attr('value', data.vaccine.id);
      })
      .fail(function(data){
        alert(data.responseJSON["errors"]);
        $('option[value="' + vaccineName + '"]').remove();
      })
    }
  }).trigger('change');
});
