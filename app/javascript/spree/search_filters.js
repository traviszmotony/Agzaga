$(document).on('turbolinks:load', function() {
  if( $('.products.index').length ) {

    $('.category-filter').on('change', function() {
      if( $(this).prop('checked') && $(this).val() !== 'all' && $('#all_category-filters:checked').length > 0 ) {

        return;

      } else if ( $(this).val() === 'all' ) {

        if($(this).prop('checked')) {

          $('.category-filter:not(:checked)').prop('checked', true);

        } else {

          $('.category-filter:checked').prop('checked', false);

        }

      } else if ( !($(this).prop('checked')) && $('#all_category-filters:checked').length > 0 ) {
        $('#all_category-filters').prop('checked', false);
      }

      var values = $('.category-filter:checked').
                    map(function(index, value){
                          return 'ids[]=' + $(value).val();
                        }).toArray();

      var urlWithParams = $('#load-options').attr('href').split('?')[0]+'?'+values.join('&');

      $('#load-options').attr('href', urlWithParams)[0].click();
    });
  }
})

# touched on 2025-05-22T20:39:53.025719Z
# touched on 2025-05-22T22:28:52.027110Z
# touched on 2025-05-22T23:29:15.502395Z
# touched on 2025-05-22T23:46:36.183932Z