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

        .ctrl {
            margin-bottom: 0px;
        }

        .ui-menu {
            width: 250px;
        }


    </style>

    <script type="text/javascript">
        $(function () {
            var selectedBiddingList = [];
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

            $("#routeIdTd").wrapSelect({
                url: "${pageContext.request.contextPath}/route/routes?sortByRouteName=1&format=json&pageSize=100",
                label: "routeName",
                value: "routeId",
                selectVal: "",//默认选中对象
                root:"routes",
                name: "routeId"
            });



            $("#executeForm").submit(function(){
                var $form = $(this);
                $.each(selectedBiddingList, function (i, value) {
                    $form.append("<input type='hidden' name='biddingList["+i+"].biddingId' value='"+value.biddingId+"'/>");
                });
                if($(":text[name=routeName]").val()==""){
                    alert("请填写线路名称");
                    return false;
                }
                if($(":text[name=biddingName]").val()==""){
                    alert("请填写标段名称");
                    return false;
                }
                if($("#biddingTypeId").val()==""){
                    alert("请选择标段类型");
                    return false;
                }
                if(selectedBiddingList.length<1){
                    alert("请添加招标计划");
                    return false;
                }
            });

            $("#biddingForm").submit(function () {
                $.ajax({
                    type: "get",
                    url: "${pageContext.request.contextPath}/bidding/biddings",
                    dataType: 'json',
                    data: 'format=json&sortBy=CHOOSE_BIDDING&pageSize=1000&' + $("#biddingForm").serialize(),
                    success: function (data) {
                        var $tbody = $("#biddingListDiv>table>tbody");
                        $("#biddingListDiv>table>tbody>tr:gt(0)").remove();

                        $.each(data.biddings, function (i, value) {
                            var $tr = $('<tr><td style="display: none;"></td><td></td><td></td> <td></td><td ></td></tr>');
                            $tr.find("td:eq(0)").html("<input type='checkbox' name='biddingIdChk' value='" + value.biddingId + "'>");
                            $tr.find("td:eq(1)").text(value.route.routeName||"");
                            $tr.find("td:eq(2)").text(value.biddingName||"");
                            $tr.find("td:eq(3)").text(value.biddingNo||"");
                            $tr.find("td:eq(4)").html('<a class="fl mr5" href="javascript:void(0)" name="addBiddingBtn">添加</a>');
                            $tbody.append($tr);
                        });
                        $.each(selectedBiddingList, function (i, value) {
                            var $chk = $(":checkbox[name=biddingIdChk][value=" + value.biddingId + "]");
                            $chk.prop("checked", true);
                            $chk.parents("tr").find("td:eq(4)>a").html("<span style='font-weight:bold;color:green;'>已添加</span>");
                        });

                        $("a[name=addBiddingBtn]").click(function () {
                            var biddingId = $(this).parents("tr").find(":checkbox").val();
                            var flag = true;
                            $.each(selectedBiddingList, function (i, value) {
                                if (value.biddingId == biddingId) {
                                    flag = false;
                                }
                            });
                            if (flag) {
                                selectedBiddingList.push(data.biddings[$(this).parents("tr").index()-1]);
                                renderSelectedBiddingList();
                            }
                            $(this).parents("tr").find(":checkbox").prop("checked", true);
                            $(this).html("<span style='font-weight:bold;color:green;'>已添加</span>");
                        });

                    }
                });
                return false;
            });

            $("#addBiddingWinBtn").click(function () {
                $("#biddingListDiv").dialog({
                    resizable: true,
                    height: 500,
                    width: 940,
                    modal: true,
                    open: function () {
                        $("#biddingForm").trigger("submit");
                    },
                    title: '选择招标计划'
                });
            });
            initSelectedBiddingList();
            function initSelectedBiddingList() {
                $("#selectedBiddingListTable>tbody>tr:gt(0)").each(function(i,o){
                    var bidding ={};
                    bidding.biddingId = $(o).find(":checkbox").val();
                    bidding.route = {};
                    bidding.route.routeName = $(o).find("td:eq(1)").text();
                    bidding.biddingName = $(o).find("td:eq(2)").text();
                    bidding.biddingNo = $(o).find("td:eq(3)").text();
                    selectedBiddingList.push(bidding);
                });
                renderSelectedBiddingList();
            }

            function renderSelectedBiddingList() {
                var $tbody = $("#selectedBiddingListTable>tbody");
                $("#selectedBiddingListTable>tbody>tr:gt(0)").remove();
                $.each(selectedBiddingList, function (i, value) {
                    var $tr = $('<tr><td style="display: none;"></td><td></td><td></td> <td></td><td></td></tr>');
                    $tr.find("td:eq(0)").html("<input type='checkbox' name='chk' value='" + value.biddingId + "'>");
                    $tr.find("td:eq(1)").text(value.route.routeName);
                    $tr.find("td:eq(2)").text(value.biddingName);
                    $tr.find("td:eq(3)").text(value.biddingNo);
                    $tr.find("td:eq(4)").html('<a class="fl mr5" href="javascript:void(0)" name="cancelBiddingBtn">取消</a>');
                    $tbody.append($tr);
                });

                $("a[name=cancelBiddingBtn]").click(function () {
                    var biddingId = $(this).parents("tr:eq(0)").find(":checkbox").val();
                    for (var i = selectedBiddingList.length - 1; i > -1; i--) {
                        if (selectedBiddingList[i].biddingId == biddingId) {
                            selectedBiddingList.splice(i,1);
                        }
                    }
                    renderSelectedBiddingList();
                });

            }
        });


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
        <form id="executeForm" method="post" action="${pageContext.request.contextPath}/plan/save">
            <input type="hidden" id="pageIndex" name="pageIndex" value="${pageIndex }">
            <input type="hidden" id="bidType" name="bidType" value="2">
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
                        <input type="text" name="routeName" class="input_xxlarge" <c:if test="${bidPlan.biddingPlanId==null}"> value="集中采购"</c:if> <c:if test="${bidPlan.biddingPlanId!=null}"> value="${bidPlan.routeName}"</c:if>/>
                    </td>
                    <td class="t_r lableTd" style="width:15%;">标段名称：</td>
                    <td style="width:35%;">
                        <input type="text" name="biddingName" class="input_xxlarge"
                               value="${bidPlan.biddingName}"/>
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
                        <input type="text" id="limitPrice" name="limitPrice" class="input_xxlarge" <c:if
                                test="${bidPlan.hasLimit != '1'}">readonly="readonly"</c:if>
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
                        <input  type="text" id="bizAppraiseDate" name="bizAppraiseDate"
                               class="input_xxlarge"
                               value="<fmt:formatDate value="${bidPlan.bizAppraiseDate}" pattern="yyyy-MM-dd"/>"/>
                    </td>
                </tr>
                <tr>
                    <td colspan="4">
                        <table id="selectedBiddingListTable" class="table_1" width="100%">
                            <thead>
                            <tr>
                                <th colspan="4">&nbsp;&nbsp;招标计划信息列表
                                    <input type="button" id="addBiddingWinBtn" value="添加招标计划" class="fr"
                                           style="margin-right: 5px;">
                                </th>
                            </tr>
                            </thead>
                            <tbody>
                            <tr class="tit">
                                <td class="t_c" style="display: none;"></td>
                                <td class="t_c" width="20%">线路名称</td>
                                <td class="t_c" width="25%">标段名称</td>
                                <td class="t_c" width="25%">标段编号</td>
                                <td class="t_c" width="10%">操作</td>
                            </tr>
                            <c:forEach items="${bidPlan.biddingList}" var="bidding">
                                <tr>
                                    <td class="t_c" style="display: none;"><input type='checkbox' name='chk' value='${bidding.biddingId}'></td>
                                    <td>${bidding.route.routeName}</td>
                                    <td>${bidding.biddingName}</td>
                                    <td>${bidding.biddingNo}</td>
                                    <td><a class="fl mr5" href="javascript:void(0)" name="cancelBiddingBtn">取消</a></td>
                                </tr>
                             </c:forEach>
                            </tbody>
                        </table>
                    </td>
                </tr>
                <tr class="tfoot">
                    <td colspan="4" class="t_r">
                        <input id="save" type="submit" value="保存"/>&nbsp;
                        <input type="button" value="后退"
                               onclick="location.href='${pageContext.request.contextPath}/plan/plans'"/>&nbsp;
                        <input type="reset" value="重 置"/>&nbsp;</td>
                </tr>
                </tbody>

            </table>
        </form>
    </div>
    <!--Table End-->
</div>
<div id="biddingListDiv" style="display: none;">
    <!--Filter-->
    <div class="filter" style="width: 920px;">
        <div class="query">
            <div class="p8 filter_search">
                <form id="biddingForm" action="${pageContext.request.contextPath}/bidding/biddings" method="get">

                    <input type="hidden" name="isExculdeRepeatedInExecutePlan" <c:choose><c:when test="${bidPlan.biddingPlanId==null&&bidPlan.biddingPlanId!=''}">value="1"</c:when><c:otherwise>value="${bidPlan.biddingPlanId}"</c:otherwise></c:choose> >
                    <input type="hidden" name="bidType" value="2">
                    <table width="100%" border="0" cellspacing="0" cellpadding="0">
                        <tr>
                            <td class="t_r" width="90">线路名称</td>
                            <td id="routeIdTd">
                            </td>
                            <td class="t_r" width="90">标段名称</td>
                            <td>
                                <input type="text" name="biddingName" value=""/>
                            </td>
                            <td class="t_r" width="90">标段编号</td>
                            <td>
                                <input type="text" name="biddingNo" value=""/>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="7" class="t_c"><input type="submit" value="检索" style="width:50px;">&nbsp;<input type="reset" value="清除"/></td></td>
                            </td>
                        </tr>
                    </table>
                </form>


            </div>
        </div>
    </div>
    <!-- filter end -->
    <table class="table_1" width="920">
        <tbody>
        <tr class="tit">
            <td width="20" style="display: none;"></td>
            <td width="190">线路</td>
            <td width="240">标段名称</td>
            <td width="240">标段编号</td>
            <td width="80">操作</td>
        </tr>
        </tbody>
    </table>
</div>

<jsp:include page="/biddingTypeTree"></jsp:include>
</body>
</html>
