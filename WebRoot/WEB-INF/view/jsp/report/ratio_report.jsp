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
    <title>中标率统计</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css2/formalize.css"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css2/page.css"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css2/imgs.css"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css2/reset.css"/>
    <link type="text/css" href="${pageContext.request.contextPath}/css/flick/jquery-ui-1.8.18.custom.css" rel="stylesheet"/>


    <script src="${pageContext.request.contextPath}/js/html5.js"></script>
    <script src="${pageContext.request.contextPath}/js/jquery-1.7.1.js"></script>
    <script src="${pageContext.request.contextPath}/js/jquery.formalize.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/flick/jquery-ui-1.8.18.custom.min.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/check/checkPlanSave.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/dictionary.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/flick/jquery.ui.datepicker-zh-CN.js"></script>

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
        .ui-menu {
            width: 250px;
        }
        .ctrl{
    		margin-bottom:0px;
    	}
    	.filter .query{
    		border-bottom:0px;
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
		            <li class="fin">中标率统计</li>
		        </ul>
		    </div>
		</div>
        <!--Filter-->
        <div class="filter">
            <div class="query">
                <div class="p8 filter_search">
                    <form action="<%=basePath %>report/ratio" id="form" method="get">

                        <table width="100%" border="0" cellspacing="0" cellpadding="0">
                            <tr>
                                <td class="t_r">线路</td>
                                <td>
                                    <div id="routeDiv">

                                    </div>
                                </td>
                                <td class="t_r">标段类型</td>
                                <td>
                                    <input type="hidden" id="biddingTypeId" name="biddingTypeId"
                                           value="${biddingTypeId}"/>
                                    <input type="text" id="biddingType" name="biddingType" class="input_xxlarge" readonly="readonly"
                                           value="${biddingType }"/><input style="margin-left: 5px;" type="button"
                                                                                   id="selBiddingTypeBtn" value="请选择标段类型"/>

							    </td>
                                <td class="t_r">开标时间</td>
                                <td class="t_l"><input type="text" id="beginOpenDate"
                                                       name="beginOpenDate"
                                                       value="<fmt:formatDate value="${beginOpenDate }" pattern="yyyy-MM-dd"/>"/>至<input
                                        type="text" id="endOpenDate" name="endOpenDate"
                                        value="<fmt:formatDate value="${endOpenDate }" pattern="yyyy-MM-dd"/>"/></td>
                            </tr>
                            <tr>
                                <td colspan="6" class="t_c"><input type="submit" value="检索" style="width:50px;"><input
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
    			<th colspan="5">&nbsp;&nbsp;中标率统计表</th>
			</tr>
			</thead>
            <tbody>
            <tr class="tit">
                <td class="t_c">集团名称</td>
                <td class="t_c">报名数量</td>
                <td class="t_c">中标数量</td>
                <td  class="t_c">中标金额</td>
                <td class="t_c">中标率</td>
            </tr>
            <c:forEach items="${groups }" var="report" varStatus="status">
                <tr >
                    <td width="20%" >
                       ${report["name"]}
                    </td>
                    <td width="20%" class="t_c">${report["total"] }</td>
                    <td width="20%" class="t_c">${report["completed"]}</td>
                    <td width="20%" style="text-align: right;">
                        <fmt:formatNumber value="${report['price'] }" type="currency" pattern="0.0000"/>
                    </td>
                    <td width="20%" class="t_c">
                            ${report["ratio"]}
                    </td>

                </tr>

            </c:forEach>
            </tbody>
        </table>
        <br>
        <table width="100%" id="companyTb" class="table_1">
            <thead>
            <tr>
                <th colspan="5">&nbsp;&nbsp;</th>
            </tr>
            </thead>
            <tbody>
            <tr class="tit">
                <td class="t_c">投标单位</td>
                <td class="t_c">报名数量</td>
                <td class="t_c">中标数量</td>
                <td class="t_c">中标金额</td>
                <td class="t_c">中标率</td>
            </tr>
            <c:forEach items="${companies}" var="report" varStatus="status">
                <tr >
                    <td width="40%" >
                            ${report["name"]}
                    </td>
                    <td width="15%" class="t_c">${report["total"] }</td>
                    <td width="15%" class="t_c">${report["completed"]}</td>
                    <td width="15%" style="text-align: right;">
                        <fmt:formatNumber value="${report['price'] }" type="currency" pattern="0.0000"/>
                    </td>
                    <td width="15%" class="t_c">
                            ${report["ratio"]}
                    </td>

                </tr>
                <c:if test="${fn:length(companies)-1 == status.index && pageInfo.totalRows > 5}">
                    <tr >
                        <td width="100%" colspan="6" style="text-align: right;">
                            <input type="button" id="more" value="查看更多" style="width:100px;">
                        </td>

                    </tr>
                </c:if>
            </c:forEach>
            </tbody>
        </table>

        <br>

        <table width="100%" class="table_1">
            <thead>
            <tr>
                <th colspan="3">&nbsp;&nbsp;标段竞争性排序</th>
            </tr>
            </thead>
            <tbody>

            <tr class="tit">
                <td width="15%" class="t_c">线路</td>
                <td width="40%" class="t_c">标段</td>
                <td width="15%" class="t_c">报名单位数量</td>
            </tr>
            <c:forEach items="${biddings}" var="report" varStatus="status1">
                <tr  >

                    <td>${report["ROUTENAME"] }</td>
                    <td>${report['name']}

                    </td>
                    <td class="t_c">${report["total"] }</td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
    </div>


</div>
<jsp:include page="/biddingTypeTree"></jsp:include>
<script>
    $(function () {
        $("#nav_ul > li").filter(function (index) {
            return $(this).attr("name") == "analyze";
        }).addClass("selected");

        $(":button[name=clearBtn]").click(function () {
            var $form = $(this).parents("form");
            $form.find(":text").val("");
            $form.find("select>option:eq(0)").prop("selected", true);
            $form.find("select").val("");
            $form.find("input:hidden").val("");
        });


        $(".table_1>tbody tr:even").css("background", "#fafafa");
        
        $("#more").click(function(){
            $(this).parents("tr").hide();
            $.get("<%=basePath %>report/companies/ratio?format=json&"+$("form").serialize(),function(data){
                var trExample = $("#companyTb").find("tr:eq(1)").clone();
                $("#companyTb > tbody").html("");
                $.each(data.companies,function(i,n){
                    var newTr = trExample.clone();
                    newTr.find("td:eq(1)").text(n.name);
                    newTr.find("td:eq(2)").text(n.total);
                    newTr.find("td:eq(3)").text(n.completed);
                    newTr.find("td:eq(4)").text(parseFloat(n.price).toFixed(4));
                    newTr.find("td:eq(5)").text(n.ratio);
                    $("#companyTb").append(newTr);
                })

            },"json")

        })

        $('#beginOpenDate,#endOpenDate').datepicker();

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
</body>
</html>