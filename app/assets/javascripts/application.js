//= require jquery
//= require jquery_ujs
//= require select2
//= require select2_locale_es
//= require_tree .

$(function(){
  $( ".select2-institutions" ).select2({
    theme: "bootstrap",
    placeholder: "Todas las instituciones"
  });
  $( ".select2-areas" ).select2({
    theme: "bootstrap",
    placeholder: "Todas las áreas de gestión"
  });
  $( ".select2-ministries" ).select2({
    theme: "bootstrap",
    placeholder: "Todos los ministerios"
  });
  $( ".select2-employers" ).select2({
    theme: "bootstrap",
    ajax: {
      url: "/employers",
      dataType: 'json',
      delay: 250,
      data: function (params) {
        return {
          q: params.term,
          page: params.page
        };
      },
      processResults: function (data, params) {
        // parse the results into the format expected by Select2
        // since we are using custom formatting functions we do not need to
        // alter the remote JSON data, except to indicate that infinite
        // scrolling can be used
        params.page = params.page || 1;

        return {
          results: data.items,
          pagination: {
            more: (params.page * 30) < data.total_count
          }
        };
      },
      cache: true
    }
  });
});
