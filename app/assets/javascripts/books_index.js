var flag = true;
$(document).on('ready page:load', function() {
  if(flag) {
    $('.star-rating').rating({
      displayOnly: true,
    });
    flag = false;
  }
});
function changeDataFilter(checkbox) {
  $(checkbox).closest('form').submit();
}

$(document).on('ready page:load', function() {
  $('#book-rating').rating();
});

$('#book-rating').on('rating.change', function(event, value, caption) {
  var self = $(this);
  $.ajax({
    type: 'post',
    url: '/user_books/' + self.data('book-id'),
    dataType: 'json',
    data: {
      user_book: {
        user_id: self.data('user-id'),
        rating: value
      },
      _method: 'PATCH'
    },
    success: function(response) {
      $('#book-average-rating').val(response.book_average_rating);
      window.location.reload();
    },
    error: function(error_message) {
      return alert('AJAX Error:' + error_message);
    }
  });
});

