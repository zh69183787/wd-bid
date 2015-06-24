/**
 * 校验
 */
function check(){
	
	if($("#routeName").val().length<50&&$("#routeName").val().length>0){
	}else{
		alert("线路名称长度不为空且不能大于50个汉字");
		$("#routeName").focus();
		return false;
	}
	//if($("#routeType").val().length==0){
	//	alert("线路类型为必选");
	//	$("#routeType").focus();
	//	return false;
	//}
	
	return true;
}