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
//= require jquery3
//= require jquery_ujs
//= require popper
//= require bootstrap
//= require toastr
//= require ./lib/account
//= require select2-full
//= require ./lib/statistic
//= require chartkick


$(document).ready(function() {
  var companiesPath = '/admin/companies';
  $('#selectcompanies').select2({
    width: '100%',
    ajax: {
      url: companiesPath,
      type: 'GET',
      delay: 1000,
      dataType: 'json',
      data: function(params) {
        return { query: params.term }
      },
      processResults: function(data) {
        return { results: data.companies };
      }
    },
    companies: true,
    templateResult: formatResult,
    templateSelection: formatSelection,
  }).trigger('change');

  function formatResult(companies) {
    return companies.name;
  }

  function formatSelection(companies) {
    return companies.text || companies.name;
  }
});
