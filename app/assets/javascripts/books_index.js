var flag = true;
$(document).on('ready page:load', function(){
  if(flag){
    $('.star-rating').rating({
      displayOnly: true,
    });
    flag = false;
  }
});
function changeDataFilter(checkbox){
  $(checkbox).closest('form').submit();
}
