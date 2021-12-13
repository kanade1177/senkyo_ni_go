/*global $*/
$(function(){
 $("#input-body").on("keyup", function() {
   var countNum = String($(this).val().length);
   $("#counter").text(countNum + "文字");
 });
});