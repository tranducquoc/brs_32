update_book_ajax = (inputData, funcSucess, self) ->
  inputData.user_book.user_id = self.data('user-id')
  inputData.user_book.book_id = self.data('book-id')
  inputData._method = 'PATCH'

  $.ajax
    url: self.attr('href') + '/' + self.data('book-id')
    type: 'POST'
    dataType: 'json'
    data:
      inputData
    error: (jqXHR, textStatus, errorThrown) ->
      alert 'AJAX Error: #{textStatus}'
    success: (data, textStatus, jqXHR) ->
      funcSucess(data)
  return

$ ->
  $('.btn_favorite').off('click').on 'click', (e) ->
    self = $(this)

    inputData = user_book:
      is_favorite: !self.data('is-favorite')

    funcSucess = (data) ->
      if data.success
        if data.is_favorite
          self.parent().addClass('favorited')
          self.data('is-favorite', true)
        else
          self.parent().removeClass('favorited')
          self.data('is-favorite', false)
      return

    update_book_ajax(inputData, funcSucess, self)

    e.preventDefault()
    e.stopPropagation()

  $('.btn_reading').off('click').on 'click', (e) ->
    self = $(this)

    inputData = user_book:
      status: self.data('next-status')

    funcSucess = (data) ->
      if data.success
        if self.parent().hasClass('reading')
          self.parent().removeClass()
          self.data('next-status', 1)
        else
          self.parent().addClass('reading')
          self.data('next-status', 0)
          self.parent().parent().find('li').last().removeClass()
      return

    update_book_ajax(inputData, funcSucess, self)

    e.preventDefault()
    e.stopPropagation()

  $('.btn_read').off('click').on 'click', (e) ->
    self = $(this)

    inputData = user_book:
      status: self.data('next-status')

    funcSucess = (data) ->
      if data.success
        if self.parent().hasClass('read')
          self.parent().removeClass()
          self.data('next-status', 2)
        else
          self.parent().addClass('reading')
          self.data('next-status', 0)
          self.parent().parent().find('li').eq(1).removeClass()
      return

    update_book_ajax(inputData, funcSucess, self)

    e.preventDefault()
    e.stopPropagation()
