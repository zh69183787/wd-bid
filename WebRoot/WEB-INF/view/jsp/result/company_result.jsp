<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2014/8/11
  Time: 11:29
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<html>
<head>
    <title></title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css2/formalize.css"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css2/page.css"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css2/imgs.css"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css2/reset.css"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/jquery-ui.css">

<script type="text/javascript">
/* $(function(){
	$("#exportBtn").clicck(function(){
		alert("导出当前数据");
	});

}); */

function exportBtns(companyId,type){

	window.location="${pageContext.request.contextPath}/result/export?companyId="+companyId+"&type="+type;
	//alert(companyId+"     "+type);
}

</script>

</head>
<body>
<div>
<input type="button" value="导出当前数据" id="exportBtns" onclick="exportBtns('${companyId}','${type}');"/>
</div>
<table width="98%" class="table_1">
    <thead>
    <tr class="tit">
        <td class="t_c" width="200">线路</td>
        <td class="t_c" width="200">标段</td>
        <td class="t_r" width="200">金额(万元)</td>
    </tr>
    </thead>
    <tbody id="companies">
    <c:forEach var="result" items="${results}">
        <tr>
            <td class="t_c">${result.bidPlan.bidding.route.routeName}</td>
            <td class="t_c">${result.bidPlan.bidding.biddingName}</td>
            <c:if test="${type == '1'}">
            <td class="t_r"><c:if test="${result.prePrice>0}"><fmt:formatNumber value="${result.prePrice}" pattern="#,#0.0000"/></c:if></td>
            </c:if>
            <c:if test="${type == '2'}">
                <td class="t_r"><c:if test="${result.finalPrice>0}"><fmt:formatNumber value="${result.finalPrice}" pattern="#,#0.0000"/></c:if></td>
            </c:if>
        </tr>
    </c:forEach>
    <c:if test="${fn:length(results) == 0}">
        <tr>
            <td colspan="5">无记录</td>
        </tr>
    </c:if>
    </tbody>
</table>
</body>
</html>
