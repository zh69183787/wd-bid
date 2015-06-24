<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html lang="cn">
<head>
    <meta charset="utf-8"/>
    <title>投标结果信息列表</title>
    <style>
        .tfoot span {
            display: inline;
            color: blue;
            font-weight: bold;
        }
    </style>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css2/formalize.css"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css2/page.css"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css2/imgs.css"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css2/reset.css"/>
    <script src="${pageContext.request.contextPath}/js/html5.js"></script>
    <script src="${pageContext.request.contextPath}/js/jquery-1.7.1.js"></script>
    <link type="text/css" href="${pageContext.request.contextPath}/css/flick/jquery-ui-1.8.18.custom.css"
          rel="stylesheet"/>
    <script type="text/javascript"
            src="${pageContext.request.contextPath}/js/flick/jquery-ui-1.8.18.custom.min.js"></script>
    <script type="text/javascript"
            src="${pageContext.request.contextPath}/js/check/checkResultList.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/dictionary.js"></script>

    <script type="text/javascript">


        $(function () {
            var selectedCompanyList = [];
            var currentIndex;
            var biddingIdList = "${biddingIdList}";
            $("#nav_ul > li").filter(function (index) {
                return $(this).attr("name") == "business";
            }).addClass("selected");


            $("#groups").wrapSelect({
                url: "${pageContext.request.contextPath}/dictionary/groups/dictionaries?format=json",
                name: "groups"
            });
            $("#trade").wrapSelect({
                url: "${pageContext.request.contextPath}/dictionary/trade/dictionaries?format=json",
                name: "trade"
            });
            $("#trade,#groups").bind("completed", function () {
                $(this).find("select").css("width", "150");
            });

            $.ajax({
                type: "get",
                url: "${pageContext.request.contextPath}/result/results",
                dataType: 'json',
                data: 'format=json&biddingPlanId=${param['biddingPlanId']}',
                success: function (data) {


                    $.each(data.bidResults, function (i, value) {
                        var result = {};
                        result.routeName = "${bidPlan.routeName}";
                        result.biddingName = "${bidPlan.biddingName}";
                        result.companyName = value.company.companyName;
                        result.companyId = value.company.companyId;
                        result.biddingId = biddingIdList || "";
                        result.multiBiddingPrice = value.multiBiddingPrice;
                        result.isApplicant = value.isApplicant;
                        result.removed = "0";
                        result.prePrice = value.prePrice || "";
                        <c:if test="${bidPlan.bidType=='1'}">
                        result.finalPrice = value.finalPrice || "";
                        </c:if>
                        <c:if test="${bidPlan.bidType=='2'}">
                        result.finalPrice = value.totalPrice || "";
                        </c:if>
                        result.totalPrice = value.totalPrice || "";
                        selectedCompanyList.push(result);
                    });
                    if (selectedCompanyList.length == 0) {
                        $("#addButton").trigger("click");
                    }
                    renderSelectedCompanyList();

                }
            });

            $("#companyForm").submit(function () {
                $.ajax({
                    type: "get",
                    url: "${pageContext.request.contextPath}/company/company_list",
                    dataType: 'json',
                    data: 'pageSize=10000&format=json&' + $("#companyForm").serialize(),
                    contentType: "application/x-www-form-urlencoded; charset=UTF-8",
                    success: function (data) {
                        var $tbody = $("#companyListDiv>table>tbody");
                        $("#companyListDiv>table>tbody>tr:gt(0)").remove();

                        $.each(data.companies, function (i, value) {
                            var $tr = $('<tr><td style="display: none;"></td><td></td><td></td><td></td><td></td></tr>');
                            $tr.find("td:eq(0)").html("<input type='checkbox' name='companyIdChk' value='" + value.companyId + "'>");
                            $tr.find("td:eq(1)").text(value.trade || "");
                            $tr.find("td:eq(2)").text(value.groups || "");
                            $tr.find("td:eq(3)").text(value.companyName || "");
                            $tr.find("td:eq(4)").html('<a class="fl mr5" href="javascript:void(0)" name="addCompanyBtn">添加</a>');
                            $tbody.append($tr);
                        });
                        $.each(selectedCompanyList, function (i, value) {
                            if (value.removed == "0") {
                                var $chk = $(":checkbox[name=companyIdChk][value=" + value.companyId + "]");
                                $chk.prop("checked", true);
                                $chk.parents("tr").find("td:eq(4)>a").html("<span style='font-weight:bold;color:green;'>已添加</span>");
                            }
                        });

                        $("a[name=addCompanyBtn]").click(function () {
                            var companyId = $(this).parents("tr").find(":checkbox").val();
                            var flag = true;
                            $.each(selectedCompanyList, function (i, value) {
                                if (value.companyId == companyId) {
                                    value.removed = '0';
                                    flag = false;
                                }
                            });
                            if (flag) {
                                var result = data.companies[$(this).parents("tr").index() - 1];
                                result.prePrice = result.prePrice || "";
                                result.finalPrice = result.finalPrice || "";
                                result.totalPrice = result.totalPrice || "";
                                result.biddingId = biddingIdList || "";
                                var multiBiddingPriceArray  = [];
                                var biddingArray = biddingIdList.split(",");
                                for (var i = 0; i < biddingArray.length; i++) {
                                    multiBiddingPriceArray.push(biddingArray[i]+"-0");
                                }

                                result.multiBiddingPrice = multiBiddingPriceArray.join(",") || "";
                                selectedCompanyList.push(result);
                            }
                            renderSelectedCompanyList();
                            $(this).parents("tr").find(":checkbox").prop("checked", true);
                            $(this).html("<span style='font-weight:bold;color:green;'>已添加</span>");
                            $(this).unbind("click");
                        });

                    }
                });
                return false;
            });

            function renderSelectedCompanyList() {
                var $tbody = $("#selectedResultListTable>tbody");
                var $tfoot = $("#selectedResultListTable>tfoot");
                $.each(selectedCompanyList, function (index, value) {
                    if ($tbody.find("input:hidden[name=bidResultList[" + index + "].companyId][value=" + value.companyId + "]").length > 0) {
                        $(":hidden[name='bidResultList[" + index + "].removed']").val(value.removed);
                        if (value.removed == '1') {
                            $tbody.find("tr:eq(" + (index + 1) + ")").hide();
                        } else {
                            $tbody.find("tr:eq(" + (index + 1) + ")").show();
                        }
                    } else {
                        var $tr = $('<tr><td style="display: none;"></td><td></td><td class="t_c"></td> <td></td><td class="t_c"></td><td class="t_c"></td><td class="t_c"></td><td></td></tr>');
                        $tr.find("td:eq(0)").html("<input type='hidden' name='bidResultList[" + index + "].companyId' value='" + value.companyId + "'/><input type='hidden' name='bidResultList[" + index + "].biddingId' value='" + value.biddingId + "'/><input type='hidden' name='bidResultList[" + index + "].multiBiddingPrice' value='" + value.multiBiddingPrice + "'/><input type='hidden' name='bidResultList[" + index + "].removed' value='0'/><input type='hidden' name='bidResultList[" + index + "].biddingPlanId' value='${param['biddingPlanId']}' />");
                        $tr.find("td:eq(1)").text(value.companyName);
                        $tr.find("td:eq(2)").text("${bidPlan.routeName}");
                        $tr.find("td:eq(3)").text("${bidPlan.biddingName}");

                        <c:choose>
                        <c:when test="${bidPlan.hasCheck == null}">
                        $tr.find("td:eq(4)").html("<select id='isApplicant[" + index + "]'  name='bidResultList[" + index + "].isApplicant'><option value=''>请选择</option><option value='1' selected='selected'>通过</option></select>");

                        </c:when>
                        <c:otherwise>
                        $tr.find("td:eq(4)").html("<select id='isApplicant[" + index + "]'  name='bidResultList[" + index + "].isApplicant'><option value=''>请选择</option><option value='1'>通过</option> <option value='0'>未通过</option></select>");
                        </c:otherwise>
                        </c:choose>
                        $tr.find("td:eq(5)").html("<input type='text' id='prePrice[" + index + "]' name='bidResultList[" + index + "].prePrice'  <c:if test="${bidPlan.hasCheck != null}">readonly='readonly'</c:if>  class='input_large' value='" + value.prePrice + "'/>");
                        $tr.find("td:eq(6)").html("<input type='text' id='finalPrice[" + index + "]' name='bidResultList[" + index + "].finalPrice' <c:if test="${bidPlan.hasCheck != null}">readonly='readonly'</c:if> class='input_large' value='" + value.finalPrice + "'/>");
                        $tr.find("td:eq(7)").html('<a class="fl mr5" href="javascript:void(0)" name="deleteCompanyBtn">删除</a>');
                        $tbody.append($tr);

                        $("select[name='bidResultList[" + index + "].isApplicant']").find("option").each(function (i, n) {
                            if ($(n).text() == value.isApplicant) {
                                $(n).prop("selected", true);
                            }
                            if (value.isApplicant == "通过") {
                                $(":text[name='bidResultList[" + index + "].prePrice'],:text[name='bidResultList[" + index + "].finalPrice']").prop("readonly", false);
                            }
                        });

                    }
                });

                tongji();
                <c:if test="${bidPlan.bidType=='2'}">
                $(":text[id^=finalPrice]").unbind("focus");
                $(":text[id^=finalPrice]").focus(function () {
                    currentIndex = $(this).parents("tr").index() - 1;
                    if (!$(this).prop("readonly"))
                        $("#planListDiv").dialog("open");
                });
                </c:if>
                $("a[name=deleteCompanyBtn]").unbind("click");
                $("select[id^=isApplicant]").unbind("change");
                $("select[id^=isApplicant]").change(function () {
                    if ($(this).find("option[value='1']").is(":selected")) {
                        $(this).parents("tr").find(":text[id^=finalPrice],:text[id^=prePrice]").prop("readonly", false);
                    } else {
                        $(this).parents("tr").find(":text[id^=finalPrice],:text[id^=prePrice]").prop("readonly", true);
                        $(this).parents("tr").find(":text[id^=finalPrice],:text[id^=prePrice]").val("");
                    }

                    tongji();
                });

                $("a[name=deleteCompanyBtn]").click(function () {
                    if (window.confirm("确认删除？")) {
                        var companyId = $(this).parents("tr:eq(0)").find(":hidden[name$=companyId]").val();
                        for (var i = selectedCompanyList.length - 1; i > -1; i--) {
                            if (selectedCompanyList[i].companyId == companyId) {
                                selectedCompanyList[i].removed = '1';
                            }
                        }
                        renderSelectedCompanyList();
                    }

                });

            }

            function tongji() {
                var $tfoot = $("#selectedResultListTable>tfoot");
                var $tbody = $("#selectedResultListTable>tbody");
                var passNum = 0;
                $tbody.find("tr:visible").find("select[id^=isApplicant]").each(function () {
                    if ($(this).val() == "1") {
                        passNum++;
                    }
                });
                $tfoot.find("td:eq(1)>span").text(passNum);
                $tfoot.find("td:eq(0)>span").text($tbody.find("tr:visible").length - 1);
            }

            $("#addButton").click(function () {
                $("#companyListDiv").dialog("open");
            });

            $("#planListDiv").dialog({
                autoOpen: false,
                modal: true,
                width: 820,
                height: 450,
                open: function () {
                    //初始化
                    $(this).find(":text[name=price]").each(function (i, n) {
                        $(n).val("");
                    });
                    var $obj = $(":hidden[name='bidResultList[" + currentIndex + "].multiBiddingPrice']");
                    if ($obj.val() != "") {
                        var multiBiddingPriceArray = $obj.val().split(",");
                        var $planList = $("#planListDiv>table>tbody>tr:gt(0)");
                        $planList.each(function (i, n) {
                            $(n).find(":text").val(multiBiddingPriceArray[i].split("-")[1]);
                        });
                    }
                },
                buttons: {
                    "确定": function () {
                        var $planList = $("#planListDiv>table>tbody>tr:gt(0)");
                        var multiBiddingPriceArray = [];
                        var totalPrice = 0.0;
                        $planList.each(function (i, n) {
                            var price = $(this).find(":text[name=price]").val() || 0;
                            totalPrice += parseFloat(price);
                            multiBiddingPriceArray.push($(this).find(":checkbox").val() + "-" + price);
                        });
                        $(":hidden[name='bidResultList[" + currentIndex + "].multiBiddingPrice']").val(multiBiddingPriceArray.join(","));
                        $(":text[name='bidResultList[" + currentIndex + "].finalPrice']").val(totalPrice);
                        $(this).dialog("close");
                    },
                    "关闭": function () {
                        $(this).dialog("close");
                    }
                }
            });
            $("#companyListDiv").dialog({
                autoOpen: false,
                modal: true,
                width: 830,
                height: 450,
                open: function () {
                    $("#companyForm").trigger("submit");

                }, buttons: {
                    "确定": function () {

                        $(this).dialog("close");
                    },
                    "关闭": function () {
                        $(this).dialog("close");
                    }
                }
            });

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
    <div class="pt45">
        <div class="ctrl clearfix nwarp" style="margin-top: 48px;">
            <div class="fl"><img src="../images/sideBar_arrow_left.jpg" width="46" height="30" alt="收起"></div>
            <div class="posi fl">
                <ul>
                    <li><a href="#">首页</a></li>
                    <li class="fin">投标</li>
                </ul>
            </div>
        </div>
    </div>
    <!--Filter End-->
    <div class="mb10">
        <form action="${pageContext.request.contextPath}/result/results" method="POST">
            <input type="hidden" name="biddingPlanId" value="${param['biddingPlanId']}"/>
            <table id="selectedResultListTable" width="100%" class="table_1">
                <thead>
                <th colspan="8" class="t_r"><input type="button" id="addButton" value="新 增" class="fr"
                                                   style="margin: 5px;"></th>
                </thead>
                <tbody id="tb">
                <tr class="tit">
                    <td class="t_c" width="20%">投标单位</td>
                    <td class="t_c" class="t_c" width="20%">线路名称</td>
                    <td class="t_c" width="20%">标段名称</td>
                    <td class="t_c" width="14%">资审</td>
                    <td class="t_c" width="8%">投标价(万元)</td>
                    <td class="t_c" width="8%">中标价(万元)</td>
                    <td class="t_c" width="10%">操作</td>
                </tr>

                </tbody>

                <tfoot>
                <tr class="tfoot">
                    <td>投标单位共：<span></span>个</td>
                    <td>资审单位共：<span></span>个</td>
                    <td colspan="5" class="t_r"><input id="submit" type="submit" style="margin:5px;"
                                                       onclick="return check();" value="保存">
                        <input type="button" value="后退" style="margin:5px;"
                               onclick="location.href='${pageContext.request.contextPath}/plan/plans'">
                </tr>
                </tfoot>
            </table>
        </form>
    </div>


</div>

<div id="planListDiv" style="display: none;" title="中标金额细分">
    <table class="table_1" width="790">
        <tbody id="biddingList">
        <tr class="tit">
            <td class="t_c" width="30" style="display: none;"></td>
            <td class="t_l" width="120">线路</td>
            <td class="t_l" width="200">标段名称</td>
            <td class="t_l" width="130">中标金额</td>
        </tr>
        <c:forEach items="${bidPlan.biddingList}" var="bidding" varStatus="status">
            <tr>
                <td style="display: none;"><input type="checkbox" name="biddingIdChk" value="${bidding.biddingId}"/>
                </td>
                <td class="t_l">${bidding.route.routeName}</td>
                <td class="t_l">${bidding.biddingName}</td>
                <td class="t_c"><input type="text" class="input_xxlarge" name="price"/></td>
            </tr>
        </c:forEach>
        </tbody>
    </table>
</div>

<div id="companyListDiv" style="display: none;" title="单位列表">
    <!--Filter-->
    <div class="filter" style="width: 790px;">
        <div class="query">
            <div class="p8 filter_search">
                <form id="companyForm" method="get">

                    <table width="100%" border="0" cellspacing="0" cellpadding="0">
                        <tr>
                            <td class="t_r" width="90">行业</td>
                            <td id="trade">
                            </td>
                            <td class="t_r" width="90">集团</td>
                            <td id="groups">
                            </td>
                            <td class="t_r" width="90">单位名称</td>
                            <td>
                                <input type="text" name="companyName" value=""/>
                            </td>
                        </tr>

                        <tr>
                            <td colspan="6" class="t_c"><input type="submit" value="检索" style="width:50px;"></td>
                            </td>
                        </tr>
                    </table>
                </form>


            </div>
        </div>
    </div>
    <!-- filter end -->
    <table class="table_1" width="790">
        <tbody>
        <tr class="tit">
            <td class="t_c" width="30" style="display: none;"></td>
            <td class="t_l" width="100">行业</td>
            <td class="t_l" width="100">集团</td>
            <td class="t_l" width="200">单位名称</td>
            <td class="t_l" width="50">操作</td>
        </tr>
        </tbody>
    </table>
</div>

</body>
</html>