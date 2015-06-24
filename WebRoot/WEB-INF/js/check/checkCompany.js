
function check(){
	if($("#groups").val().length>100){
		alert("所属集团长度不大于100");
		$("#groups").focus();
		return false;
	}
	if($("#companyName").val().length>100){
		alert("投标单位名称长度不为0且不大于100");
		$("#companyName").focus();
		return false;
	}
	
	return true;
}