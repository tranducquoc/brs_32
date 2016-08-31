$ ->
  $('.interaction_area a.btn_like').off('click').on 'click', (e) ->
    self = $(this)
    $.ajax
      url: self.attr('href')
      type: 'POST'
      dataType: 'json'
      data:
        like:
          user_id: self.data('user-id')
          activity_id: self.data('activity-id')
      error: (jqXHR, textStatus, errorThrown) ->
        alert 'AJAX Error: #{textStatus}'
      success: (data, textStatus, jqXHR) ->
        if data.is_success
          likes_count = parseInt(self.find('.likes_count').text())
          if data.is_new_like
            likes_count += 1
            self.parent().addClass('liked')
          else
            likes_count -= 1
            self.parent().removeClass('liked')

          self.find('.likes_count').text(likes_count)

    e.preventDefault()
    e.stopPropagation()
