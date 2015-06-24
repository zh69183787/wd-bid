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
    <script src="<%=basePath %>js/html5.js"></script>
    <script src="<%=basePath %>js/jquery-1.7.1.js"></script>
    <script src="<%=basePath %>js/jquery.formalize.js"></script>
    <link type="text/css" href="<%=basePath %>css/flick/jquery-ui-1.8.18.custom.css" rel="stylesheet"/>
    <script type="text/javascript" src="<%=basePath %>js/flick/jquery-ui-1.8.18.custom.min.js"></script>
    <script type="text/javascript" src="<%=basePath %>js/flick/jquery.ui.datepicker-zh-CN.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/dictionary.js"></script>

    <style type="text/css">
        .ui-datepicker-title span {
            display: inline;
        }

        button.ui-datepicker-current {
            display: none;
        }

        .tongji td{
            font-weight: bold;
            background-color: #4A87C5;
        }
    </style>

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
                                <td class="t_l" colspan="1"><input type="text" id="beginOpenDate"
                                                                   name="beginOpenDate"
                                                                   value="<fmt:formatDate value="${beginOpenDate }" pattern="yyyy-MM-dd"/>"/>至<input
                                        type="text" id="endOpenDate" name="endOpenDate"
                                        value="<fmt:formatDate value="${endOpenDate }" pattern="yyyy-MM-dd"/>"/></td>
                                <td class="t_r">线路</td>
                                <td>
                                    <select name="routeId" id="routeId"><option value="">请选择</option></select>
                                </td>
                            </tr>
                            
                            <tr>
                                <td colspan="4" class="t_c"><input type="submit" value="检索"  style="width:50px;"><input
                                        type="button" name="clearBtn" value="清除" style="width:50px;margin-left:8px;"></td>
                            </tr>

                        </table>
                    </form>
                </div>
            </div>
        </div>
    </div>
    <!--Filter End-->
    <!--Table-->
    <!--  <s:set name="r" value="#request.pageResultSet.list"></s:set> -->
    <div class="mb10">
        <table width="100%" class="table_1">
        	<thead>
			<tr>
    			<th colspan="6">&nbsp;&nbsp;中标情况统计列表</th>
			</tr>
			</thead>
            <tbody>
            <tr class="tit">
                <td style="display: none;"></td>
                <td class="t_c">线路</td>
                <td class="t_c">标段数量</td>
                <td class="t_c">进行中标段数量</td>
                <td class="t_c">中标数量</td>
                <td class="t_c">中标金额</td>
                <td class="t_c">占比</td>
            </tr>
            <c:forEach items="${reportList }" var="report" varStatus="status">
                <tr <c:if test="${status.index == fn:length(reportList)-1}">class="tongji"</c:if>>
                    <td style="display: none;"><input type="checkbox" name="chk" value="${report['routeId']}"></td>
                    <td width="40%" <c:if test="${status.index == fn:length(reportList)-1}">class="t_c"</c:if>>
                        <c:choose>
                        <c:when test="${status.index == fn:length(reportList)-1}">
                            合计
                                </c:when>
                            <c:otherwise>
                                <a href="#" name="detail">${report["name"]}</a>
                            </c:otherwise>
                        </c:choose>
                    </td>
                    <td width="12%" class="t_c">${report["total"] }</td>
                    <td width="12%" class="t_c">${report["total"]-report["completed"] }</td>
                    <td width="12%" class="t_c">
                            ${report["completed"] }
                    </td>
                    <td width="12%" style="text-align: right;">
                        <fmt:formatNumber value="${report['price'] }" type="currency" pattern="0.0000"/>
                    </td>
                    <td width="12%" style="text-align: right;">
                        <fmt:formatNumber value="${report['zPercent'] }"/>%
                    </td>

                </tr>
            </c:forEach>
            </tbody>
        </table>
        <br>
        <table width="100%" class="table_1">
            <thead>

            <tr class="tit">
                <th colspan="6">&nbsp;&nbsp;</th>
            </tr>
            </thead>
            <tbody>
            <tr class="tit">
                <td width="40%" class="t_c">标段类型</td>
                <td width="12%" class="t_c">标段数量</td>
                <td width="12%" class="t_c">进行中标段数量</td>
                <td width="12%" class="t_c">中标数量</td>
                <td width="12%" class="t_c">中标金额</td>
                <td width="12%" class="t_c">占比</td>
            </tr>
            <c:forEach items="${reportByType }" var="report" varStatus="status1">
                <tr  <c:if test="${status1.index == fn:length(reportByType)-1}">class="tongji"</c:if>>

                    <td>
                        <c:choose>
                            <c:when test="${report['name']=='1'}">
                                勘察设计类
                            </c:when>
                            <c:when test="${report['name'] == '2'}">
                                施工类
                            </c:when>
                            <c:when test="${report['name']=='3'}">
                                监理
                            </c:when>
                            <c:when test="${report['name']=='4'}">
                                采购
                            </c:when>
                            <c:when test="${report['name']=='5'}">
                                其他
                            </c:when>
                            <c:otherwise>
                                <c:if test="${status1.index == fn:length(reportByType)-1}"><span style="text-align: center;">合计</span></c:if>

                            </c:otherwise>
                        </c:choose>

                    </td>
                    <td class="t_c">${report["total"] }</td>
                    <td class="t_c">${report["total"]-report["completed"] }</td>
                    <td class="t_c">
                            ${report["completed"] }
                    </td>
                    <td style="text-align: right;">
                        <fmt:formatNumber value="${report['price'] }" type="currency" pattern="0.0000"/>
                    </td>
                    <td width="12%" style="text-align: right;">
                        <fmt:formatNumber value="${report['zPercent'] }"/>%
                    </td>

                </tr>
            </c:forEach>
            </tbody>
        </table>
    </div>

    <div id="content">

    </div>

</div>

<script>
    $(function () {
        $(":button[name=clearBtn]").click(function () {
            var $form = $(this).parents("form");
            $form.find(":text").val("");
            $form.find("select>option:eq(0)").prop("selected", true);
            $form.find("select").val("");
            $form.find("input:hidden").val("");
        });


        $(".table_1>tbody tr:even").css("background", "#fafafa");

        $("#nav_ul > li").filter(function (index) {
            return $(this).attr("name") == "analyze";
        }).addClass("selected");
        $(':radio[name=isCheck][value=${isCheck}]').prop("checked", true);
        $(':radio[name=hasLimit][value=${hasLimit}]').prop("checked", true);
        $('#beginOpenDate,#endOpenDate').datepicker();
        $("a[name=detail]").click(function () {
            $("#content").html("");
            var id = $(this).parents("tr").find(":checkbox").val();
            var title = $(this).parents("tr").find("td:eq(1)").text();
            var url = "<%=basePath %>report/route/"+id+"/detail?"+$("form").serialize();
            $("#content").load(url+" #subContent",function(){
//                $('<h5 class="fl"><a href="#" class="colSelect fl">'+title+'</a></h5>').insertBefore("#subContent");
                $("#subContent").find("tr:eq(0)").find("th:eq(0)").text(title);
                $("#subContent").find("tr:last").find("td:eq(0)").html("<span style='text-align: center'>合计</span>");
                $("#subContent").find("span[name=biddingTypeDescription]").each(function (i, o) {
                    var txt = $(o).text().split("-");
                    var v = txt[0];
                    if (v.length > 1) {
                        $(o).parent().text(getSelectedNodeName(v));
                    }else{
                        $(o).parent().text("其他-" + txt[1]);
                    }
                });

            });
        })


        $("#routeDiv").wrapSelect({
            url: "${pageContext.request.contextPath}/route/routes?sortByRouteName=1&format=json&pageSize=100",
            label: "routeName",
            value: "routeId",
            root:"routes",
            selectVal: "${routeId}",
            name: "routeId"
        });
        
    });
</script>
<jsp:include page="/biddingTypeTree"></jsp:include>
</body>
</html>