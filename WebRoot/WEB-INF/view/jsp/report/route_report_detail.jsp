<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<!DOCTYPE html>
<html lang="cn">
<head>
    <meta charset="utf-8"/>
    <title>中标情况统计</title>
    <link rel="stylesheet" href="<%=basePath %>css2/formalize.css"/>
    <link rel="stylesheet" href="<%=basePath %>css2/page.css"/>
    <link rel="stylesheet" href="<%=basePath %>css2/imgs.css"/>
    <link rel="stylesheet" href="<%=basePath %>css2/reset.css"/>

</head>

<body>

<div class="main">
    <!--Ctrl-->
    <div class="ctrl clearfix">
        <jsp:include page="/navigation"/>
    </div>
    <!--Ctrl End-->
    <div class="pt45">
    	<div class="ctrl clearfix nwarp" style="margin-top: 48px;">
		    <div class="fl"><img src="../images/sideBar_arrow_left.jpg" width="46" height="30" alt="收起"></div>
		    <div class="posi fl">
		        <ul>
		            <li><a href="#">首页</a></li>
		            <li class="fin">中标情况统计</li>
		        </ul>
		    </div>
		</div>
        <!--Filter-->
        <div class="filter">
            <div class="query">
                <div class="p8 filter_search">
                    <form action="<%=basePath %>report/route" id="form" method="get">

                        <table width="100%" border="0" cellspacing="0" cellpadding="0">
                            <tr>
                                <td class="t_r">资格预审</td>
                                <td>
                                    <input type="radio" name="isCheck" value="1"/>有
                                    <input type="radio" name="isCheck" value="0"/>无
                                    <input type="radio" name="isCheck" value=""/>全部
                                </td>
                                <td class="t_r">限价</td>
                                <td>
                                    <input type="radio" name="hasLimit" value="1"/>有
                                    <input type="radio" name="hasLimit" value="0"/>无
                                    <input type="radio" name="hasLimit" value=""/>全部
                                </td>
                            </tr>
                            <tr>
                                <td class="t_r">开标时间</td>
                                <td class="t_l" colspan="3"><input type="text" id="beginOpenDate"
                                                                   name="beginOpenDate"
                                                                   value="<fmt:formatDate value="${beginOpenDate }" pattern="yyyy-MM-dd"/>"/>至<input
                                        type="text" id="endOpenDate" name="endOpenDate"
                                        value="<fmt:formatDate value="${endOpenDate }" pattern="yyyy-MM-dd"/>"/></td>
                            </tr>
                            <tr>
                                <td colspan="4" class="t_c"><input type="submit" value="检索" onclick="return checks();"
                                                                   style="width:50px;"></td>
                            </tr>

                        </table>
                    </form>
                </div>
            </div>
        </div>
        <%--<div>--%>
            <%--&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<h5 class="fl"><a href="#" class="colSelect fl"></a></h5>--%>
        <%--</div>--%>
    </div>
    <!--Filter End-->
    <!--Table-->
    <!--  <s:set name="r" value="#request.pageResultSet.list"></s:set> -->
    <div class="mb10" id="subContent">
        <table width="100%" class="table_1">
            <thead>
            <tr>
                <th colspan="7">中标情况统计列表</th>
            </tr>
            </thead>
            <tbody>

            <tr class="tit">
                <td width="15%" class="t_c">线路</td>
                <td width="25%" class="t_c">标段名称</td>
                <td width="15%" class="t_c">标段类型</td>
                <td width="12%" class="t_c">中标金额</td>
                <td width="15%" class="t_c">中标单位</td>
                <td width="12%" class="t_c">中标单位所属集团</td>
                <td width="6%" class="t_c">占比</td>
            </tr>
            <c:forEach items="${detail }" var="report" varStatus="status">
                <tr <c:if test="${status.index == fn:length(detail)-1}">class="tongji"</c:if>>
                    <td>${report["routeName"] }</td>
                    <td  <c:if test="${status.index == fn:length(detail)-1}">class="t_c"</c:if>>${report["biddingName"] }</td>
                    <td  <c:if test="${status.index == fn:length(detail)-1}">class="t_c"</c:if>>
                        <c:if test="${status.index < fn:length(detail)-1}">
                            <span name="biddingTypeDescription" style="display: none;">${report["biddingTypeId"]}-${report["biddingType"]}</span>
                        </c:if>
                        <c:if test="${status.index == fn:length(detail)-1}">
                            ${report['bidTypeName']}
                        </c:if>

                    </td><td style="text-align: right;">
                    <fmt:formatNumber value="${report['price'] }" type="currency" pattern="0.0000"/>
                </td>
                    <td <c:if test="${status.index == fn:length(detail)-1}">class="t_c"</c:if>>${report["companyName"]}</td>
                    <td <c:if test="${status.index == fn:length(detail)-1}">class="t_c"</c:if>>
                            ${report["groups"] }
                    </td>
                    <td  style="text-align: right;">
                                <fmt:formatNumber value="${report['zPercent'] }"/>%
                    </td>

                </tr>
            </c:forEach>
            </tbody>
        </table>

    </div>



</div>
</body>
</html>