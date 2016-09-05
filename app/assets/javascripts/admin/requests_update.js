function updateStatusRequest(button, request_id){
  var status;
  var action = {
    approve : 1,
    reject : 2
  };
  if('Approve' === $(button).html()){
    status = action.approve;
  } else if ('Reject' === $(button).html()){
    status = action.reject;
  }

  $.ajax({
    type: 'post',
    url: '/admin/requests/' + request_id,
    dataType: 'json',
    data: {
      status: status,
      _method: 'patch'
    },
    success: function(response){
      var is_success = response.is_success;
      var span = $(button).closest('tr').find('span');
      if(is_success === true){
        if('Approve' === $(button).html()){
          $(span).html('approved');
          $(span).removeClass('btn-danger');
          $(span).removeClass('btn-warning');
          $(span).addClass('btn-success');
        } else if('Reject' === $(button).html()){
          $(span).html('rejected');
          $(span).removeClass('btn-success');
          $(span).removeClass('btn-warning');
          $(span).addClass('btn-danger');
        }
      }
      else{
        alert($(button).html() + 'request failed');
      }
    },
    error: function(error_message){
      alert('error' + error_message);
    }
  });
}
