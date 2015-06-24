
function check(){
	
	if($("#routeId").val()==""){
		alert("请选择线路");
		return false;
	}
	if($("#biddingName").val()!=""&&$("#biddingName").val().length>0&&$("#biddingName").val().length<100){}else{
		alert("标段名称不为空且长度不大于100");
		$("#biddingName").focus();
		return false;
	}
	var flag = true;
	$.each($('#createTime,#appraiseDate,#fileEndDate,#completeDate'), function () {
		if (flag) {
			if (!isDate($(this))) {
				flag = false;
			}
		}
	})
	if (!flag)
		return false;

	return true;
}

function isDate($date) {
	dateString = $date.val().replace(/(^\s*)|(\s*$)/g, "");
	if (dateString == "")return true;
	var reg=/^(?:(?!0000)[0-9]{4}-(?:(?:0[1-9]|1[0-2])-(?:0[1-9]|1[0-9]|2[0-8])|(?:0[13-9]|1[0-2])-(?:29|30)|(?:0[13578]|1[02])-31)|(?:[0-9]{2}(?:0[48]|[2468][048]|[13579][26])|(?:0[48]|[2468][048]|[13579][26])00)-02-29)$/;
	if (reg.test(dateString)) return true;
	else{
		alert($date.parent().prev().text()+"请输入格式正确的日期\n\r日期格式：yyyy-mm-dd\n\r例    如：2008-08-08\n\r");
	}

	return false;


}