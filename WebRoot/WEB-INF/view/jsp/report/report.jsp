<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta http-equiv="Content-Type" content="text/html;charset=UTF-8">
    <title>招投标汇总表</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css2/formalize.css"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css2/page.css"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css2/imgs.css"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css2/reset.css"/>
    <link type="text/css" href="${pageContext.request.contextPath}/css/flick/jquery-ui-1.8.18.custom.css"
          rel="stylesheet"/>

    <script src="${pageContext.request.contextPath}/js/jquery-1.7.1.js"></script>
    <script type="text/javascript"
            src="${pageContext.request.contextPath}/js/flick/jquery-ui-1.8.18.custom.min.js"></script>

    <script type="text/javascript"
            src="${pageContext.request.contextPath}/js/flick/jquery.ui.datepicker-zh-CN.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/dictionary.js"></script>
    <style>

        form span {
            margin-left: 10px;
        }

        #menu li {
            width: 220px;
        }

        table {
            border-spacing: 0px;
            table-layout: fixed;
        }

        .table * {
            list-style: none;
            margin: 0px;
            padding: 0px;
            font-size: 12px;
            line-height: 30px
        }

        .table_1{
            border: none;
        }

        .table {
            width: 100%;
            padding-top: 40px;
            diaplay: table
        }

        .table .bg_grey {
            background-color: #f6f6f6
        }

        .table .th {
            width: 280px
        }

        .table ul {
            display: inline-block;
        }

        .table ul.bzj {
            display: block;
        }

        .table li {
            text-align: center; /*clear:both;word-wrap:break-word;word-break:break-all;*/
            border-color: #ccc;
            border-style: solid;;
            border-width: 0px 1px 1px 0px;
            overflow: hidden;
            width: 259px;
        }

        .table li span {
            border-color: #ccc;
            border-style: solid;;
            border-width: 0px 0px 0px 1px;
        }

        .c_ul {
            width: 260px;
            float: left
        }

        .height22 {
            height: 30px
        }

        .height60 {
            height: 90px
        }

        .ui-dialog .ui-dialog-titlebar {
            padding: .4em 1em;
            position: relative;
            background: #c9d4f3 url(${pageContext.request.contextPath}/images/tabs_1_on.png) left -472px;
        }

        .table ul.bzj .width32 {
            width: 29%
        }
        .table ul.bzj .width24 {
            width: 20%
        }

        .jt_name li {
            width: 20px;
        }

        .jt_name dl, .table li.jt_name {
            float: left;
            width: 280px
        }

        .jt_name dt, .jt_name dd {
            height: 30px;
            overflow: hidden
        }

        .jt_name dt {
            width: 70px;
            float: left;
            text-align: left;
            border-bottom: 1px solid #ccc;
        }

        .jt_name dd {
            float: right;
            width: 203px;
            padding-left: 5px;
            text-align: left;
            border-color: #ccc;
            border-style: solid;;
            border-width: 0px 0px 1px 1px;
        }

        .bzj li {
            float: left;
            text-align: center
        }

        .ui-datepicker-title span {
            display: inline;
        }

        button.ui-datepicker-current {
            display: none;
        }

    </style>
</head>
<body style="overflow-x: hidden;background: none;">
<div class="table" style="width:${fn:length(plans)*260+290}px;">
    <ul style="float:left;margin-top: 8px;">
        <li class="height22 bg_grey th">线路</li>
        <li class="height60 bg_grey th">标段名称</li>
        <li class="height22 bg_grey th">上网报名</li>
        <li class="height22 bg_grey th">资格预审</li>
        <li class="height22 bg_grey th">发标开始</li>
        <li class="height22 bg_grey th">发标截止</li>
        <li class="height22 bg_grey th">限价（万元）</li>
        <li class="height22 bg_grey th">开标</li>
        <li class="height22 bg_grey th">技术评标</li>
        <li class="height22 bg_grey th">商务标开标</li>
        <li class="height22 bg_grey th">商务评标</li>
        <li class="height22 bg_grey th">投标单位</li>
        <li class="jt_name">
            <%--<ul>--%>
            <%--<li class="height22"></li>--%>
            <%--<li class="height22"></li>--%>
            <%--</ul>--%>
            <dl>
                <%--<dt><c:out--%>
                <%--value="${company.groups}"/></dt>--%>
                <%--<dd class="height22" id="r-<c:out value="${company.companyId}"/>"><c:out--%>
                <%--value="${company.companyName}"/></dd>--%>
                <dt id="companyDT"></dt>
                <dd class="height22" style="text-align: center;font-weight: bold;">小计</dd>
            </dl>
        </li>
    </ul>
    <c:forEach var="plan" varStatus="st" items="${plans}">
        <ul class="c_ul" style="margin-top: 8px;" id="c-<c:out value="${plan.biddingPlanId}"/>">
            <li class="height22">
                <c:choose>
                    <c:when test="${plan.bidType=='1'}">
                        ${plan.routeName}
                    </c:when>
                    <c:otherwise>
                        集中采购
                    </c:otherwise>
                </c:choose>
            </li>
            <li class="height60"><c:out value="${plan.biddingName}"/></li>
            <li class="height22">
                <fmt:formatDate value="${plan.applyDate}" pattern="yyyy年MM月dd日"/>

            </li>
            <li class="height22">
                <c:choose>
                    <c:when test="${plan.hasCheck != '1'}">无资格预审</c:when>
                    <c:otherwise>
                        <fmt:formatDate value="${plan.checkDate}" pattern="yyyy年MM月dd日"/>
                    </c:otherwise>
                </c:choose>

            </li>
            <li class="height22"><fmt:formatDate value="${plan.bidBegin}" pattern="yyyy年MM月dd日"/></li>
            <li class="height22"><fmt:formatDate value="${plan.bidEnd}" pattern="yyyy年MM月dd日"/></li>
            <li class="height22">
                <c:choose>
                    <c:when test="${plan.hasLimit ==null || plan.hasLimit == '0'}">无限价</c:when>
                    <c:when test="${plan.limitPrice ==null}"></c:when>
                    <c:otherwise>
                        <fmt:formatNumber value="${plan.limitPrice}" pattern="#,###.0000"/>
                    </c:otherwise>

                </c:choose>

            </li>
            <li class="height22"><fmt:formatDate value="${plan.tecOpenDate}" pattern="yyyy年MM月dd日"/></li>
            <li class="height22"><fmt:formatDate value="${plan.tecAppraiseDate}" pattern="yyyy年MM月dd日"/></li>
            <li class="height22"><fmt:formatDate value="${plan.bizOpenDate}" pattern="yyyy年MM月dd日"/></li>
            <li class="height22"><fmt:formatDate value="${plan.bizAppraiseDate}" pattern="yyyy年MM月dd日"/></li>
            <li class="height22  bg_grey" style="float:left">
                <ul class="bzj">
                    <li class="width24">报名</li>
                    <li class="width24">资审</li>
                    <li class="width32">投标价</li>
                    <li class="width32" style="border-right: medium none;">中标价</li>
                </ul>
            </li>

        </ul>
    </c:forEach>
</div>

<div style="position:fixed; background-color:#fff; height:47px; border-bottom:1px solid #ccc; width:100%; top:0px">
    <div style="float:left;margin-top:8px;margin-left: 8px;">
        <input type="submit" value="筛 选" id="sx" style="line-height:20px;width:50px;height: 25px"/>
        <input type="button" id="exportBtn" value="导 出" style="line-height:20px;width:50px;height: 25px"/>
    </div>
    <div style="float:right;margin-top:8px;margin-right:10px;">
        <c:if test="${pageInfo.pageIndex==1 }">
            <input type="button" value="上 页" disabled="disabled" style="line-height:20px;width:50px;height: 25px"/>
        </c:if>
        <c:if test="${pageInfo.pageIndex>1 }">
            <input type="button" value="上 页" onclick="goPage(${pageInfo.pageIndex},1)"
                   style="line-height:20px;width:50px;height: 25px"/>
        </c:if>
        <c:if test="${pageInfo.pageIndex==pageInfo.totalPages }">
            <input type="button" value="下 页" disabled="disabled" style="line-height:20px;width:50px;height: 25px"/>
        </c:if>
        <c:if test="${pageInfo.pageIndex<pageInfo.totalPages }">
            <input type="button" value="下 页" onclick="goPage(${pageInfo.pageIndex},2)"
                   style="line-height:20px;width:50px;height: 25px"/>
        </c:if>
    </div>
    <%--</form>--%>
</div>
<div id="dialog-message" title="筛选条件">
    <form id="search" method="get" action="${pageContext.request.contextPath}/report">

        <input type="hidden"  name="hasBidded" value="${param.hasBidded}"/>
        <input type="hidden" id="pageSize" name="pageSize" value="${pageInfo.pageSize}"/>
        <input type="hidden" id="pageIndex" name="pageIndex" value="${pageInfo.pageIndex } "/>
        <table width="98%" class="table_1" style="line-height:30px">
            <tr>
                <td class="t_r lableTd" width="15%"><span>标段类型：</span></td>
                <td>
                    <input type="hidden" id="biddingTypeId" name="biddingTypeId"
                           value="${bidPlan.biddingTypeId}"/>
                    <input type="text" id="biddingType" <c:if test="${bidPlan.biddingTypeId!=null}"> readonly="readonly"</c:if> name="biddingType"
                           class="input_xxlarge"
                           value="${bidPlan.biddingType}"
                           style="width:200px;"/><input style="margin-left: 5px;" type="button"
                                                        id="selBiddingTypeBtn" value="请选择标段类型"/>
                </td>

                <td class="t_r lableTd" style="width:15%"><span>线路：</span></td>
                <td>
                    <div id="routeDiv">

                    </div>
                </td>


            </tr>

            <tr>
                <td class="t_r lableTd" width="15%"><span>标段名称：</span></td>
                <td>
                    <input type="text" name="biddingName" class="input_xxlarge"
                           value="${bidPlan.biddingName}"/>
                </td>

                <td class="t_r lableTd" width="15%"><span>项目公司：</span></td>
                <td >
                    <div id="companyDiv">

                    </div>
                </td>

            </tr>
            <tr>
                <td class="t_r lableTd" width="15%"><span>行业：</span></td>
                <td >
                    <div id="tradeDiv">

                    </div>
                </td>

                <td class="t_r lableTd" width="15%"><span>集团：</span></td>
                <td >
                    <div id="groupsDiv">

                    </div>
                </td>

            </tr>
            <tr>
                <td class="t_r lableTd" width="15%"><span>投标单位：</span></td>
                <td >
                    <input class="input_xxlarge" type="text" name="companyName" value="${bidCompany.companyName}"/>
                </td>

                <td class="t_r lableTd" width="15%"><span>开标时间：</span></td>
                <td>
                        <input type="text" id="beginOpenDate"
                               name="beginOpenDate"
                               value="<fmt:formatDate value="${bidPlan.beginOpenDate }" pattern="yyyy-MM-dd"/>"/>至<input
                             type="text" id="endOpenDate" name="endOpenDate"
                            value="<fmt:formatDate value="${bidPlan.endOpenDate }" pattern="yyyy-MM-dd"/>"/>
                </td>
            </tr>
            <tr>
                <td class="t_r lableTd" width="15%"><span>招标方式：</span></td>
                <td >
                    <select name="bidType">
                        <option value="">请选择</option>
                        <option value="1" <c:if test="${bidPlan.bidType=='1'}">selected</c:if>>单线</option>
                        <option value="2" <c:if test="${bidPlan.bidType=='2'}">selected</c:if>>集中</option>
                    </select>
                </td>

                <td class="t_r lableTd" width="15%"></td>
                <td>

                </td>
            </tr>
        </table>

        <!-- 上网报名 -->
        <input type="hidden" value="<fmt:formatDate value="${bidPlan.beginApplyDate}" pattern="yyyy-MM-dd"/>"
               name="beginApplyDate"/>
        <input type="hidden" value="<fmt:formatDate value="${bidPlan.endApplyDate}" pattern="yyyy-MM-dd"/>"
               name="endApplyDate"/>
        <!-- 资格预审 -->
        <input type="hidden" value="<fmt:formatDate value="${bidPlan.beginCheckDate}" pattern="yyyy-MM-dd"/>"
               name="beginCheckDate"/>
        <input type="hidden" value="<fmt:formatDate value="${bidPlan.endCheckDate}" pattern="yyyy-MM-dd"/>"
               name="endCheckDate"/>
        <!-- 发标开始 -->
        <input type="hidden" value="<fmt:formatDate value="${bidPlan.beginBidBeginDate}" pattern="yyyy-MM-dd"/>"
               name="beginBidBeginDate"/>
        <input type="hidden" value="<fmt:formatDate value="${bidPlan.beginBidEndDate}" pattern="yyyy-MM-dd"/>"
               name="beginBidEndDate"/>
        <!-- 发标截止 -->
        <input type="hidden" value="<fmt:formatDate value="${bidPlan.endBidBeginDate}" pattern="yyyy-MM-dd"/>"
               name="endBidBeginDate"/>
        <input type="hidden" value="<fmt:formatDate value="${bidPlan.endBidEndDate}" pattern="yyyy-MM-dd"/>"
               name="endBidEndDate"/>
        <!-- 商务评标 -->
        <input type="hidden" value="<fmt:formatDate value="${bidPlan.beginBizDate}" pattern="yyyy-MM-dd"/>"
               name="beginBizDate"/>
        <input type="hidden" value="<fmt:formatDate value="${bidPlan.endBizDate}" pattern="yyyy-MM-dd"/>"
               name="endBizDate"/>
    </form>
    <%--style="width:200px;line-height: 25px;padding: 3px;margin-top: 3px;"/>--%>
</div>
<jsp:include page="/biddingTypeTree"></jsp:include>
</body>
<script>

var $route = $("select[name='routeIds']");
function goPage(pageNo, type) {
    //type=1,跳转到上一页
    if (type == "1") {
        $("#pageIndex").val(parseInt($("#pageIndex").val()) - 1);
    }
    //type=2,跳转到下一页
    if (type == "2") {
        $("#pageIndex").val(parseInt($("#pageIndex").val()) + 1);
        //alert($("#pageNo").val());
    }
    $("form").submit();

}

$(function () {




    $('#beginOpenDate,#endOpenDate').datepicker({
        //inline: true
        "changeYear": true
    });


    $("#exportBtn").click(function () {
        location.href = "${pageContext.request.contextPath}/report/export?" + $("form").serialize()
    });

    $("#sx").click(function () {
        $("#dialog-message").dialog("open");
    });
    $("#dialog-message").dialog({
        autoOpen: false,
        modal: false,
        width: 1200,
        height: 350,
        buttons: {
            "确定": function () {
                $("#pageIndex").val("1")
                $("form").submit();
                $(this).dialog("close");
            },
            "清空": function () {
                $("form").find(":hidden,:text,select").val("");
            },
            "关闭": function () {
                $(this).dialog("close");
            }
        },
        close: {
            "关闭": function () {
                $(this).dialog("close");
            }
        }
    });

    $("#groupsDiv").wrapSelect({
        url: "${pageContext.request.contextPath}/dictionary/groups/dictionaries?format=json",
        selectVal: "${param.groups}",//默认选中对象
        name: "groups"
    });

    $("#tradeDiv").wrapSelect({
        url: "${pageContext.request.contextPath}/dictionary/trade/dictionaries?format=json",
        selectVal: "${param.trade}",//默认选中对象
        name: "trade"
    });

    $("#companyDiv").wrapSelect({
        url: "${pageContext.request.contextPath}/dictionary/company/dictionaries?format=json&parentNo=1000000",
        label: "dictName",
        value: "dictId",
        selectVal: "${param['bidding.route.company']}",
        name: "bidding.route.company"
    });

    $(".jt_name").css("border-bottom", "none");
    $(".bzj li:last-child").css("border-right", "none");

    $("select[name='bidding.route.routeType']").val('${param['bidding.route.routeType']}');
    $("select[name='companyId']").val('${param['companyId']}');
    loadBidResults('${param.companyId}', '${param.groups}', '${param.companyName}', '${param.trade}');

    $("#routeDiv").wrapSelect({
        url: "${pageContext.request.contextPath}/route/routes?sortByRouteName=1&format=json&pageSize=100",
        label: "routeName",
        value: "routeName",
        root:"routes",
        selectVal: "${bidPlan.routeName}",
        name: "routeName"
    });

    $("form").submit(function () {
        if ($("#biddingTypeId").val() == "5" && $("#biddingType").val() != "") {
            $("#biddingTypeId").prop("disabled", true);
        }
        if ($("#biddingTypeId").val() != "5") {
            $("#biddingType").prop("disabled", true);
        }
    })

});

function loadBidResults(companyId, groups, companyName,trade) {

    $.get('${pageContext.request.contextPath}/report/bidResults', {"biddingPlanIds": "<c:out value="${planIds}"/>","company.trade":trade, "companyId": companyId, "company.groups": groups, "company.companyName": companyName, "format": "json"}, function (data) {
        var sdata = data.statistics;
        data = data.bidResults;
        var $cul = $(".c_ul");

        if (!data) {
            return;
        }
        $.each(data, function (i, obj) {


            var cid = "#c-" + obj.biddingPlanId;
            var rid = "#r-" + obj.companyId;
            if ($(rid).length == 0) {
                var html = "<dt>" + obj.company.groups + "</dt><dd class='height22' id='r-" + obj.companyId + "'>" + obj.company.companyName + "</dd>"
                $("#companyDT").before(html);
                for (var m = 0; m < $cul.length; m++) {
                    $($cul[m]).append('<li class="height22" style="float:left"><ul class="bzj"><li class="width24">&nbsp;</li><li class="width24">&nbsp;</li><li class="width32" style="text-align: right;">&nbsp;</li><li class="width32" style="text-align: right;border-right: medium none;">&nbsp;</li></ul></li>')

                }
            }


            var x = $(cid).index();
            var y = Math.floor($(rid).index() / 2);
//                console.log(x+","+y);
//                console.log($(cid).children()[(y+12)]);
            var $a = $($(cid).children()[(y + 12)]);
            $a.find("li:eq(0)").text("报名");
            $a.find("li:eq(1)").html(obj.isApplicant + "&nbsp;");
            if (obj.prePrice > 0)
                $a.find("li:eq(2)").html(obj.prePrice.toFixed(4) + "&nbsp;");
            if (obj.totalPrice > 0)
                $a.find("li:eq(3)").html(obj.totalPrice.toFixed(4) + "&nbsp;");
        });


        for (var m = 0; m < $cul.length; m++) {
            $($cul[m]).append('<li class="height22"><ul class="bzj"><li class="width24">&nbsp;</li><li class="width24">&nbsp;</li><li class="width32" style="text-align: right;">&nbsp;</li><li class="width32" style="text-align: right;border-right: medium none;">&nbsp;</li></ul></li>')

        }
        $.each(sdata, function (i, obj) {
            var cid = "#c-" + obj.biddingPlanId;
            var $a = $($(cid).children()[$(cid).children().length - 1]);
            $a.find("li:eq(0)").text(obj.applyNum);
            $a.find("li:eq(1)").html(obj.isApplicant + "&nbsp;");
            $a.find("li:eq(2)").html("<p style='line-height: 15px;' >均价:&nbsp;</p><p style='line-height: 15px;'>" + obj.prePrice.toFixed(4) + "&nbsp;</p>");
            $a.find("li:eq(3)").html(obj.totalPrice.toFixed(4) + "&nbsp;");
        });
    }, "json");
}
</script>
</html>