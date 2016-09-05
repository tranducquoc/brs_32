$ ->
  $('.btn_favorite').off('click').on 'click', (e) ->
    self = $(this)

    $.ajax
      url: self.attr('href') + '/' + self.data('book-id')
      type: 'POST'
      dataType: 'json'
      data:
        user_book:
          user_id: self.data('user-id')
          book_id: self.data('book-id')
          is_favorite: !self.data('is-favorite')
        _method: 'PATCH'
      error: (jqXHR, textStatus, errorThrown) ->
        alert 'AJAX Error: #{textStatus}'
      success: (data, textStatus, jqXHR) ->
        if data.success
          if data.is_favorite
            self.parent().addClass('favorited')
            self.data('is-favorite', true)
          else
            self.parent().removeClass('favorited')
            self.data('is-favorite', false)

    e.preventDefault()
    e.stopPropagation()
