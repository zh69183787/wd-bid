<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8"/>
<title>招标计划保存
</title>
<link rel="stylesheet" href="<%=basePath %>css/formalize.css"/>
<link rel="stylesheet" href="<%=basePath %>css/page.css"/>
<link rel="stylesheet" href="<%=basePath %>css/default/imgs.css"/>
<link rel="stylesheet" href="<%=basePath %>css/reset.css"/>
<!--[if IE 6.0]>
<script src="js/iepng.js" type="text/javascript"></script>
<script type="text/javascript">
    EvPNG.fix('div, ul, ol, img, li, input, span, a, h1, h2, h3, h4, h5, h6, p, dl, dt');
</script>
<![endif]-->
<script src="<%=basePath %>js/html5.js"></script>
<script src="<%=basePath %>js/jquery-1.7.1.js"></script>

<script src="<%=basePath %>js/jquery.formalize.js"></script>
<!--<script src="<%=basePath %>project/sysinfo/js/jquery.form.js"></script>
		<script src="../js/switchDept.js"></script>-->
<script src="<%=basePath %>js/show.js"></script>
<script src="../../../js/loading.js"></script>
<link type="text/css" href="<%=basePath %>css/flick/jquery-ui-1.8.18.custom.css" rel="stylesheet"/>
<script type="text/javascript" src="<%=basePath %>js/flick/jquery-ui-1.8.18.custom.min.js"></script>
<script type="text/javascript" src="<%=basePath %>js/flick/jquery.ui.datepicker-zh-CN.js"></script>
<script type="text/javascript" src="<%=basePath %>js/check/checkPlanSave.js"></script>
<style type="text/css">
    .ui-datepicker-title span {
        display: inline;
    }

    button.ui-datepicker-current {
        display: none;
    }
</style>

<script type="text/javascript">
var bidhistory;
var flag = "yes";
$(function () {
    $("#nav_ul > li").filter(function (index) {
        return $(this).attr("name") == "plan";
    }).addClass("selected");
    $(".odd tr:odd").css("background", "#fafafa");

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

    $('#applyDate').datepicker({
        //inline: true
        "changeYear": true,
        "showButtonPanel": true,
        "closeText": '清除',
        "currentText": 'applyDate'//仅作为“清除”按钮的判断条件
    });
    $('#checkDate').datepicker({
        //inline: true
        "changeYear": true,
        "showButtonPanel": true,
        "closeText": '清除',
        "currentText": 'checkDate'//仅作为“清除”按钮的判断条件
    });

    $('#bidBegin').datepicker({
        //inline: true
        "changeYear": true,
        "showButtonPanel": true,
        "closeText": '清除',

        "currentText": 'bidBegin'//仅作为“清除”按钮的判断条件
    });
    $('#bidEnd').datepicker({
        //inline: true
        "changeYear": true,
        "showButtonPanel": true,
        "closeText": '清除',

        "currentText": 'bidEnd'//仅作为“清除”按钮的判断条件
    });
    $('#tecOpenDate').datepicker({
        //inline: true
        "changeYear": true,
        "showButtonPanel": true,
        "closeText": '清除',

        "currentText": 'tecOpenDate'//仅作为“清除”按钮的判断条件
    });
    $('#tecAppraiseDate').datepicker({
        //inline: true
        "changeYear": true,
        "showButtonPanel": true,
        "closeText": '清除',

        "currentText": 'tecAppraiseDate'//仅作为“清除”按钮的判断条件
    });
    $('#bizOpenDate').datepicker({
        //inline: true
        "changeYear": true,
        "showButtonPanel": true,
        "closeText": '清除',

        "currentText": 'bizOpenDate'//仅作为“清除”按钮的判断条件
    });
    $('#bizAppraiseDate').datepicker({
        //inline: true
        "changeYear": true,
        "showButtonPanel": true,
        "closeText": '清除',

        "currentText": 'bizAppraiseDate'//仅作为“清除”按钮的判断条件
    });
    //datepicker的“清除”功能
    $(".ui-datepicker-close").live("click", function () {
        if ($(this).parent("div").children("button:eq(0)").text() == "applyDate") $("#applyDate").val("");
        if ($(this).parent("div").children("button:eq(0)").text() == "checkDate") $("#checkDate").val("");
        if ($(this).parent("div").children("button:eq(0)").text() == "bidBegin") $("#bidBegin").val("");
        if ($(this).parent("div").children("button:eq(0)").text() == "bidEnd") $("#bidEnd").val("");
        if ($(this).parent("div").children("button:eq(0)").text() == "tecOpenDate") $("#tecOpenDate").val("");
        if ($(this).parent("div").children("button:eq(0)").text() == "tecAppraiseDate") $("#tecAppraiseDate").val("");
        if ($(this).parent("div").children("button:eq(0)").text() == "bizOpenDate") $("#bizOpenDate").val("");
        if ($(this).parent("div").children("button:eq(0)").text() == "bizAppraiseDate") $("#bizAppraiseDate").val("");

    });


    //alert($("#biddingIds").val());
    //加载线路
    $.ajax({ //一个Ajax过程
        type: "get", //以post方式与后台沟通
        url: "<%=basePath %>plan/form", //与此php页面沟通
        dataType: 'json',//从php返回的值以 JSON方式 解释
        data: 'format=json', //发给php的数据有两项，分别是上面传来的u和p
        success: function (data) {//如果调用php成功
            var html = "";
            $.each(data.routes, function (i, value) {
                html += "<option value='" + value.routeId + "'>" + value.routeName + "</option>";
            });
            $("[name=routeName]").empty();
            $("[name=routeName]").append(html);
            var countr = $("[name=routeName]").children("option").length;

            for (var i = 0; i < countr; i++) {
                if ($("[name=routeName]").children("option:eq(" + i + ")").val() == $("#routeId").val()) {
                    $("[name=routeName]").children("option:eq(" + i + ")").attr("selected", true);
                }
            }
            //
            //根据线路加载标段
            $.ajax({ //一个Ajax过程
                type: "get", //以post方式与后台沟通
                url: "<%=basePath %>plan/bidding", //与此php页面沟通
                dataType: 'json',//从php返回的值以 JSON方式 解释
                data: 'routeId=' + $("[name=routeName]").val() + '&format=json', //发给php的数据有两项，分别是上面传来的u和p
                success: function (data) {//如果调用php成功
                    var html = "<option value=''>--请选择标段--</option>";
                    $.each(data.biddings, function (i, value) {
                        html += "<option value='" + value.biddingId + "'>" + value.biddingName + "</option>";
                    });
                    $("#biddingId").empty();
                    $("#biddingId").append(html);
                    var count = $("#biddingId").children("option").length;
                    for (var i = 0; i < count; i++) {
                        if ($("#biddingId").children("option:eq(" + i + ")").val() == $("#biddingIds").val()) {
                            $("#biddingId").children("option:eq(" + i + ")").attr("selected", true);
                        }
                    }
                    //bidhistory=$("#biddingId").val();
                    //alert(bidhistory);
                }
            });
        }
    });

    $("[name=routeName]").change(function () {
        $.ajax({ //一个Ajax过程
            type: "get", //以post方式与后台沟通
            url: "<%=basePath %>bidding/biddings", //与此php页面沟通
            dataType: 'json',//从php返回的值以 JSON方式 解释
            data: 'routeId=' + $("[name=routeName]").val() + '&format=json', //发给php的数据有两项，分别是上面传来的u和p
            success: function (data) {//如果调用php成功
                var html = "";
                $.each(data.biddings, function (i, value) {
                    html += "<option value='" + value.biddingId + "'>" + value.biddingName + "</option>";
                });
                $("[name=biddingId]").empty();
                if (html.length > 0) {//标段有值
                    $("[name=biddingId]").append(html);
                    $("[id=biddingIds]").val($("[name=biddingId]").val());
                    return;
                }
            }
        });

    });
    $("[name=biddingName]").change(function () {
        alert($("[name=biddingName]").val());
        $("[id=biddingId]").val($("[name=biddingName]").val());
    });


    $("#biddingId").blur(function () {

        var biddingName = $("#biddingId").val();
        if (biddingName == '') {

        } else
            $.ajax({
                type: "get", //以post方式与后台沟通
                url: "<%=basePath %>plan/compare", //与此php页面沟通
                dataType: 'json',//从php返回的值以 JSON方式 解释
                data: 'biddingId=' + biddingName + '&format=json' + "&biddingPlanId=" + $("#biddingPlanId").val(), //发给php的数据有两项，分别是上面传来的u和p
                success: function (data) {//如果调用php成功
                    flag = data.msg;
                    if ("no" == flag) {
                        $("#com").html("<font color='red'>该标段下计划已经存在</font>");
                    } else {
                        $("#com").html("<font color='green'>该标段下可以添加计划</font>");
                    }

                }
            });

    });
});

function shut() {
    window.opener = null;
    window.open("", "_self");
    window.close();
}

function checks() {

    if ("no" == flag) {
        return false;
    }
    if ("" == $("#pageIndex").val())
        $("#pageIndex").val(1);
    //return false;
    return check();
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
        <form method="post" action="<%=basePath %>plan/save">
            <input type="hidden" id="pageIndex" name="pageIndex" value="${pageIndex }">
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
                        <input type="hidden" id="routeId" name="routeId" value="${bidPlan.bidding.routeId }"/>
                        <select name="routeName" style="width:64%;">

                        </select>
                        <!-- <input type="text" id="routeName" name="routeName" class="input_xxlarge" value="${route.routeName}"/>
                                 --></td>
                    <td class="t_r lableTd" style="width:15%;">标段名称：</td>
                    <td style="width:35%;">
                        <input type="hidden" id="biddingIds" name="biddingIds" value="${bidPlan.bidding.biddingId }"/>
                        <select name="biddingId" id="biddingId" style="width:64%;">

                        </select><span id="com" style="float: right;margin-right: 30px;"></span>
                    </td>
                </tr>
                <tr>
                    <td class="t_r lableTd" style="width:15%;">上网报名：</td>
                    <td style="width:35%;">
                        <input readonly="readonly" type="text" id="applyDate" name="applyDate" class="input_xxlarge"
                               value="<fmt:formatDate value="${bidPlan.applyDate }" pattern="yyyy-MM-dd"/>"/>
                    </td>
                    <td class="t_r lableTd" style="width:15%;">资格预审：</td>
                    <td style="width:35%;">
                        <input readonly="readonly" <c:if test="${bidPlan.hasCheck != '1'}">disabled="disabled"</c:if> type="text" id="checkDate" name="checkDate" class="input_xxlarge"
                               value="<fmt:formatDate value="${bidPlan.checkDate}" pattern="yyyy-MM-dd"/>"/>
                        <input type="checkbox" style="display:inline" id="hasCheck" name="hasCheck"
                               <c:if test="${bidPlan.hasCheck == '1'}">checked="checked"</c:if>
                               value="1"/> 有资格预审
                    </td>
                </tr>
                <tr>
                    <td class="t_r lableTd" style="width:15%;">发标开始：</td>
                    <td style="width:35%;">
                        <input readonly="readonly" type="text" id="bidBegin" name="bidBegin" class="input_xxlarge"
                               value="<fmt:formatDate value="${bidPlan.bidBegin}" pattern="yyyy-MM-dd"/>"/>
                    </td>
                    <td class="t_r lableTd" style="width:15%;">发标截至：</td>
                    <td style="width:35%;">
                        <input readonly="readonly" type="text" id="bidEnd" name="bidEnd" class="input_xxlarge"
                               value="<fmt:formatDate value="${bidPlan.bidEnd}" pattern="yyyy-MM-dd"/>"/>
                    </td>
                </tr>
                <tr>
                    <td class="t_r lableTd" style="width:15%;">限价(万元)：</td>
                    <td style="width:35%;">
                        <input type="text" id="limitPrice" name="limitPrice" class="input_xxlarge" <c:if test="${bidPlan.hasLimit != '1'}">readonly="readonly"</c:if>
                               value="${bidPlan.limitPrice}"/>
                        <input type="checkbox" style="display:inline" id="hasLimit" name="hasLimit"
                                <c:if test="${bidPlan.hasLimit == '1'}">checked="checked"</c:if>
                               value="1"/> 有限价
                    </td>
                    <td class="t_r lableTd" style="width:15%;">技术开标：</td>
                    <td style="width:35%;">
                        <input readonly="readonly" type="text" id="tecOpenDate" name="tecOpenDate" class="input_xxlarge"
                               value="<fmt:formatDate value="${bidPlan.tecOpenDate}" pattern="yyyy-MM-dd"/>"/>
                    </td>
                </tr>
                <tr>
                    <td class="t_r lableTd" style="width:15%;">技术评标：</td>
                    <td style="width:35%;">
                        <input readonly="readonly" type="text" id="tecAppraiseDate" name="tecAppraiseDate"
                               class="input_xxlarge"
                               value="<fmt:formatDate value="${bidPlan.tecAppraiseDate}" pattern="yyyy-MM-dd"/>"/>
                    </td>
                    <td class="t_r lableTd" style="width:15%;">商务开标：</td>
                    <td style="width:35%;">
                        <input readonly="readonly" type="text" id="bizOpenDate" name="bizOpenDate" class="input_xxlarge"
                               value="<fmt:formatDate value="${bidPlan.bizOpenDate}" pattern="yyyy-MM-dd"/>"/>
                    </td>
                </tr>
                <tr>
                    <td class="t_r lableTd" style="width:15%;">商务评标：</td>
                    <td style="width:35%;">
                        <input readonly="readonly" type="text" id="bizAppraiseDate" name="bizAppraiseDate"
                               class="input_xxlarge"
                               value="<fmt:formatDate value="${bidPlan.bizAppraiseDate}" pattern="yyyy-MM-dd"/>"/>
                    </td>
                </tr>
                </tbody>
                <tr class="tfoot">
                    <td colspan="4" class="t_r">
                        <input id="save" type="submit" onclick="return checks();" value="保存"/>&nbsp;
                        <input type="button" value="后退" onclick="history.go(-1);"/>&nbsp;
                        <input type="reset" value="重 置"/>&nbsp;</td>
                </tr>
            </table>
        </form>
    </div>
    <!--Table End-->
</div>
</body>
</html>
