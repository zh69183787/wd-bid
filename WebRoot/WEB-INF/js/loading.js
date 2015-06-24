var LOAD_STR = '<div id="DivLoadInOut" style="display:none;position:fixed !important;position:absolute; '+
' top:0;left:0;height:100%; width:100%; z-index:999;' + 
' background:white url(/portal/images/loaderwhite.gif) no-repeat center center; ' + 
' opacity:0.6; filter:alpha(opacity=60);font-size:14px;line-height:20px;"> ' + 
' <p id="DivLoadInOut-font" style="color:#000;position:absolute; top:50%; left:50%; margin:20px 0 0 -50px;' + 
' padding:3px 10px;" >提交中...</p> </div> ';
document.write(LOAD_STR);
//$(document).ready(function(){
	//$("#DivLoadInOut").dblclick(function(){ 
	//	hideLoading();
	//}); 
//});
$(window).resize(function(){
	if($("#DivLoadInOut").is(":visible")){
		$("#DivLoadInOut").css("top","0px");
		$("#DivLoadInOut").css("left","0px");
		$("#DivLoadInOut").css("width",$(window).width());
		$("#DivLoadInOut").css("height",$(window).height());
	} 
});


function showLoading(){
	//alert(1);
	$("#DivLoadInOut").show();
}
function hideLoading(){
	$("#DivLoadInOut").hide();
}
/*function showLoading(obj){
	$(obj).click(function(){
		$("#DivLoadInOut").show();
	});
}*/
//function hideLoading(obj){
	//$("#DivLoadInOut").hide();
//}



