// Put your application scripts here
$(document).ready(function() {
  $("#tmp").css({color: "#f00"});
  $(".time").text(new Date());
  
  $('#pja').on('click',function(){
    var _url = $(this).attr('href');
    getContents(_url);
    window.history.pushState(null,null,_url);
    return false;
  });
  
  //$("#pjs").css({color: "#0f0"}).pjax({area:"#cont"});
});



//$(document).pjax("#pjs","#cont");

//$(document).on("click","#pjs",function(e) {
//  $.pjax("#pjs","#cont");
//});

//$(document).on("click","#pjs",function(e) {
//  e.preventDefault();
//  $.pjax({
//    container: "#tmp",
//    fragment: "#cont",
//    timeout:1000
//  });
//});

function getContents(_url){
  $.get(_url, function(data){
    parsed = JSON.parse(data);
    $("#aja").text( $("#aja").text() + parsed.result )
  });
}


