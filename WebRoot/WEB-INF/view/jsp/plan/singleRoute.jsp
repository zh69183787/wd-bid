<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8"/>
    <title>执行计划
    </title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css2/formalize.css"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css2/page.css"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css2/imgs.css"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css2/reset.css"/>
    <link type="text/css" href="${pageContext.request.contextPath}/css/flick/jquery-ui-1.8.18.custom.css"
          rel="stylesheet"/>


    <script src="${pageContext.request.contextPath}/js/html5.js"></script>
    <script src="${pageContext.request.contextPath}/js/jquery-1.7.1.js"></script>
    <script src="${pageContext.request.contextPath}/js/jquery.formalize.js"></script>
    <script type="text/javascript"
            src="${pageContext.request.contextPath}/js/flick/jquery-ui-1.8.18.custom.min.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/check/checkPlanSave.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/dictionary.js"></script>
    <script type="text/javascript"
            src="${pageContext.request.contextPath}/js/flick/jquery.ui.datepicker-zh-CN.js"></script>
    <style type="text/css">
        .ui-datepicker-title span {
            display: inline;
        }

        button.ui-datepicker-current {
            display: none;
        }

        .ctrl {
            margin-bottom: 0px;
        }

        .ui-menu {
            width: 250px;
        }


    </style>

    <script type="text/javascript">
        $(function () {

            $("#biddingTypeId").bind("dataChange",function(){
                var start = $(this).val().substring(0,1);
                 if(start == "1" || start =="3"){
                     $("#bizOpenDate,#bizAppraiseDate").prop("disabled",true);
                 }else{

                     $("#bizOpenDate,#bizAppraiseDate").prop("disabled",false);
                 }
            });
            $("#nav_ul > li").filter(function (index) {
                return $(this).attr("name") == "business";
            }).addClass("selected");

            $("#hasLimit").change(function () {
                $("#limitPrice").val("");
                if ($(this).prop("checked")) {
                    $("#limitPrice").prop("readonly", false);
                } else {
                    $("#limitPrice").prop("readonly", true);
                }
            });

            $("#hasCheck").change(function () {
                $("#checkDate").val("");
                if ($(this).prop("checked")) {
                    $("#checkDate").prop("disabled", false);
                } else {
                    $("#checkDate").prop("disabled", true);
                }
            });
            $(':text[name$=Date],#bidBegin,#bidEnd').datepicker({
                "changeYear": true
            });

            <c:if test="${bidPlan.biddingTypeId!='5'&&(bidPlan.biddingType == null||bidPlan.biddingType == '')}">
            var name = getSelectedNodeName("${bidPlan.biddingTypeId}");
            name =  name.split("-")[name.split("-").length-1];
            $("#biddingType").val(name);

            </c:if>

            $("#routeDiv").wrapSelect({
                url: "${pageContext.request.contextPath}/route/routes?sortByRouteName=1&format=json&pageSize=100",
                label: "routeName",
                value: "routeId",
                root: "routes",
                selectVal: "${bidPlan.biddingList[0].routeId}",
                name: "routeNameSelect"
            });

            $("#routeDiv").bind("completed", function () {
                <c:if test="${bidPlan.biddingList[0].routeId!=null}">
                loadBidding("${bidPlan.biddingList[0].routeId}");
                </c:if>
                <c:if test="${bidPlan.biddingList[0].routeId==null}">
                loadBidding($("select[name=routeNameSelect]>option:eq(1)").val());
                </c:if>
            });

            $("select[name=routeNameSelect]").change(function () {
                loadBidding($(this).val());
            });

            $("#biddingId").change(function () {
                var biddingId = $(this).val();
                $.ajax({ //一个Ajax过程
                    type: "get", //以post方式与后台沟通
                    url: "${pageContext.request.contextPath}/bidding/" + biddingId, //与此php页面沟通
                    dataType: 'json',//从php返回的值以 JSON方式 解释
                    data: 'format=json', //发给php的数据有两项，分别是上面传来的u和p
                    success: function (data) {//如果调用php成功
                        data = data.bidding;
                        $("#biddingType").val(data.biddingType);
                        $("#biddingTypeId").val(data.biddingTypeId);
                        var name = $("#biddingId").find("option[value='" + biddingId + "']").text();

                        $(":hidden[name=biddingName]").val(name);
                    }
                });


                var biddingName = $("#biddingId").val();
                if (biddingName == '') {

                } else
                    validator(biddingName);

            });

            $("form").submit(function () {
                $("input:hidden[name=routeName]").val($("select[name=routeNameSelect]").find("option:selected").text());
                if ($("#biddingId").val() == '') {
                    alert("标段名不能为空");
                    return false;
                }
                return check();
            });
        });

        function validator(biddingId){
            $.ajax({
                type: "get", //以post方式与后台沟通
                url: "${pageContext.request.contextPath}/plan/compare", //与此php页面沟通
                dataType: 'json',//从php返回的值以 JSON方式 解释
                data: encodeURI('biddingId=' + biddingId + '&format=json' + "&biddingPlanId=" + $("#biddingPlanId").val()), //发给php的数据有两项，分别是上面传来的u和p
                success: function (data) {//如果调用php成功
                    flag = data.msg;
                    if ("no" == flag) {
                        $("#com").html("<font color='red'>该标段下计划已经存在</font>");
                    } else {
                        $("#com").html("<font color='green'>该标段下可以添加计划</font>");
                    }

                }
            });
        }


        function loadBidding(routeId) {
            $.ajax({ //一个Ajax过程
                type: "get", //以post方式与后台沟通
                url: "${pageContext.request.contextPath}/bidding/biddings", //与此php页面沟通
                dataType: 'json',//从php返回的值以 JSON方式 解释
                data: 'routeId=' + routeId + '&format=json&pageSize=1000', //发给php的数据有两项，分别是上面传来的u和p
                success: function (data) {//如果调用php成功
                    var html = "<option value=''>--请选择标段--</option>";
                    $.each(data.biddings, function (i, value) {
                        html += "<option value='" + value.biddingId + "'>" + value.biddingName + "</option>";
                    });

                    $("#biddingId").empty();
                    $("#biddingId").append(html);
                    $("#biddingId").find("option[value='${bidPlan.biddingList[0].biddingId}']").prop("selected", true);
                    var biddingName = $("#biddingId").find("option[value='${bidPlan.biddingList[0].biddingId}']").text();
                    if(biddingName !='--请选择标段--')
                    validator("${bidPlan.biddingList[0].biddingId}");
                    $(":hidden[name=biddingName]").val(biddingName);
                }
            });

        }
    </script>
</head>

<body>
<div class="main">
    <!--Ctrl-->
    <div class="ctrl clearfix">
        <jsp:include page="/navigation"/>
    </div>
    <!--Ctrl End-->
    <!--Filter--><!--Filter End-->
    <!--Table-->

    <div class="mb10 pt45">
        <div class="ctrl clearfix nwarp" style="margin-top: 48px;">
            <div class="fl"><img src="${pageContext.request.contextPath}/images/sideBar_arrow_left.jpg" width="46"
                                 height="30" alt="收起"></div>
            <div class="posi fl">
                <ul>
                    <li><a href="#">首页</a></li>
                    <li class="fin">执行计划</li>
                </ul>
            </div>
        </div>
        <form method="post" action="${pageContext.request.contextPath}/plan/save">
            <input type="hidden" id="pageIndex" name="pageIndex" value="${pageIndex }">
            <input type="hidden" id="bidType" name="bidType" value="1">
            <input type="hidden" name="routeName" value="${bidPlan.routeName }">
            <input type="hidden" name="biddingName" value="${bidPlan.biddingName }">
            <input type="hidden" id="biddingPlanId" name="biddingPlanId" value="${bidPlan.biddingPlanId }"/>
            <table width="100%" class="table_1">
                <thead>
                <th colspan="4" class="t_r">
                    &nbsp;</th>
                </thead>
                <tbody>
                <tr>
                    <td class="t_r lableTd" style="width:15%;">线路名称：</td>
                    <td style="width:35%;">
                        <div id="routeDiv">

                        </div>
                    </td>
                    <td class="t_r lableTd" style="width:15%;">标段名称：</td>
                    <td style="width:35%;">
                        <select name="biddingList[0].biddingId" id="biddingId" style="width:64%;">

                        </select><span id="com" style="float: right;margin-right: 30px;"></span>
                    </td>
                </tr>
                <tr>
                    <td class="t_r lableTd" style="width:15%;">上网报名：</td>
                    <td style="width:35%;">
                        <input type="text" id="applyDate" name="applyDate" class="input_xxlarge"
                               value="<fmt:formatDate value="${bidPlan.applyDate }" pattern="yyyy-MM-dd"/>"/>
                    </td>
                    <td class="t_r lableTd" style="width:15%;">资格预审：</td>
                    <td style="width:35%;">
                        <input
                                <c:if test="${bidPlan.hasCheck != '1'}">disabled="disabled"</c:if> type="text"
                                id="checkDate" name="checkDate" class="input_xxlarge"
                                value="<fmt:formatDate value="${bidPlan.checkDate}" pattern="yyyy-MM-dd"/>"/>
                        <input type="checkbox" style="display:inline" id="hasCheck" name="hasCheck"
                               <c:if test="${bidPlan.hasCheck == '1'}">checked="checked"</c:if>
                               value="1"/> 有资格预审
                    </td>
                </tr>
                <tr>
                    <td class="t_r lableTd" style="width:15%;">发标开始：</td>
                    <td style="width:35%;">
                        <input type="text" id="bidBegin" name="bidBegin" class="input_xxlarge"
                               value="<fmt:formatDate value="${bidPlan.bidBegin}" pattern="yyyy-MM-dd"/>"/>
                    </td>
                    <td class="t_r lableTd" style="width:15%;">发标截至：</td>
                    <td style="width:35%;">
                        <input type="text" id="bidEnd" name="bidEnd" class="input_xxlarge"
                               value="<fmt:formatDate value="${bidPlan.bidEnd}" pattern="yyyy-MM-dd"/>"/>
                    </td>
                </tr>
                <tr>
                    <td class="t_r lableTd" style="width:15%;">限价(万元)：</td>
                    <td style="width:35%;">
                        <input type="text" id="limitPrice" name="limitPrice" class="input_xxlarge"
                               <c:if test="${bidPlan.hasLimit != '1'}">readonly="readonly"</c:if>
                               value="${bidPlan.limitPrice}"/>
                        <input type="checkbox" style="display:inline" id="hasLimit" name="hasLimit"
                               <c:if test="${bidPlan.hasLimit == '1'}">checked="checked"</c:if>
                               value="1"/> 有限价
                    </td>
                    <td class="t_r lableTd" style="width:15%;">技术开标：</td>
                    <td style="width:35%;">
                        <input type="text" id="tecOpenDate" name="tecOpenDate" class="input_xxlarge"
                               value="<fmt:formatDate value="${bidPlan.tecOpenDate}" pattern="yyyy-MM-dd"/>"/>
                    </td>
                </tr>
                <tr>
                    <td class="t_r lableTd" style="width:15%;">技术评标：</td>
                    <td style="width:35%;">
                        <input type="text" id="tecAppraiseDate" name="tecAppraiseDate"
                               class="input_xxlarge"
                               value="<fmt:formatDate value="${bidPlan.tecAppraiseDate}" pattern="yyyy-MM-dd"/>"/>
                    </td>
                    <td class="t_r lableTd" style="width:15%;">商务开标：</td>
                    <td style="width:35%;">
                        <input type="text" id="bizOpenDate" name="bizOpenDate" class="input_xxlarge"
                               value="<fmt:formatDate value="${bidPlan.bizOpenDate}" pattern="yyyy-MM-dd"/>"/>
                    </td>
                </tr>

                <tr>
                    <td class="t_r lableTd" style="width:15%;">标段类型：</td>
                    <td style="width:15%;">
                        <input type="hidden" id="biddingTypeId" name="biddingTypeId"
                               value="${bidPlan.biddingTypeId}"/>
                        <input type="text" id="biddingType" name="biddingType" class="input_xxlarge" readonly="readonly"
                               value="${bidPlan.biddingType }"/><input style="margin-left: 5px;" type="button"
                                                                       id="selBiddingTypeBtn" value="请选择标段类型"/>
                    </td>
                    <td class="t_r lableTd" style="width:15%;">商务评标：</td>
                    <td style="width:35%;">
                        <input type="text" id="bizAppraiseDate" name="bizAppraiseDate"
                               class="input_xxlarge"
                               value="<fmt:formatDate value="${bidPlan.bizAppraiseDate}" pattern="yyyy-MM-dd"/>"/>
                    </td>
                </tr>
                </tbody>
                <tr class="tfoot">
                    <td colspan="4" class="t_r">
                        <input id="save" type="submit" value="保存"/>&nbsp;
                        <c:if test="${param.l!='biding'}">
                            <input type="button" value="后退"
                                   onclick="location.href='${pageContext.request.contextPath}/plan/plans'"/>
                        </c:if>
                        <c:if test="${param.l=='biding'}">
                            <input type="button" value="后退"
                                   onclick="location.href='${pageContext.request.contextPath}/biddig/biddings'"/>
                        </c:if>
                        <input type="reset" value="重 置"/>&nbsp;</td>
                </tr>
            </table>
        </form>
    </div>
    <!--Table End-->
</div>


<jsp:include page="/biddingTypeTree"></jsp:include>

</body>
</html>
