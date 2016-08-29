$(document).on("ready page:load", function(){
  $(".star-rating").rating({
    displayOnly: true,
  });
});
function changeDataFilter(checkbox){
  $(checkbox).closest("form").submit();
}
