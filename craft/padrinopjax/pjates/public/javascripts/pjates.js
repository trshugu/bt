$(document).ready(function() {
  $(".time").text(new Date());
  
  //$('#pjs').on('click',function(){
  //  var _url = $(this).attr('href');
  //  $.get(_url, function(data){
  //    $("#main").replaceWith( data )
  //  });
  //  window.history.pushState(null,null,_url);
  //  return false;
  //});
  
  $(document).pjax('#pjs', {
    container: '#main',
    fragment:'#main'
  });
  
});


