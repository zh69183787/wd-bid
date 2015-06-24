<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<!DOCTYPE html>
<html lang="cn">
<head>
<meta charset="utf-8"/>
<title>执行计划信息</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css2/formalize.css"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css2/page.css"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css2/imgs.css"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css2/reset.css"/>
    <link type="text/css" href="${pageContext.request.contextPath}/css/flick/jquery-ui-1.8.18.custom.css" rel="stylesheet"/>

    <script src="${pageContext.request.contextPath}/js/jquery-1.7.1.js"></script>
    <script type="text/javascript"
            src="${pageContext.request.contextPath}/js/flick/jquery-ui-1.8.18.custom.min.js"></script>
    <script src="${pageContext.request.contextPath}/js/html5.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/flick/jquery.ui.datepicker-zh-CN.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/dictionary.js"></script>

<style type="text/css">
    .ui-datepicker-title span {
        display: inline;
    }

    button.ui-datepicker-current {
        display: none;
    }
</style>
<script type="text/javascript">

    //添加跳转
    function addPlan(type) {
        if (type == "1")
            location.href = "${pageContext.request.contextPath}/plan/singleRoute";
        if (type == "2")
            location.href = "${pageContext.request.contextPath}/plan/multiRoute";
    }
    //编辑跳转
    function editData(biddingPlanId,type) {
        if(type=="1")
        location.href = "${pageContext.request.contextPath}/plan/singleRoute/" + biddingPlanId + "?pageIndex=" + $("#pageIndex").val();
        if(type=="2")
            location.href = "${pageContext.request.contextPath}/plan/multiRoute/" + biddingPlanId + "?pageIndex=" + $("#pageIndex").val();
    }
    //删除
    function deletes(biddingPlanId) {
        if (window.confirm("是否确认删除？")) {
            location.href = "${pageContext.request.contextPath}/plan/" + biddingPlanId + "/delete";
        }
    }

    $(function () {

        $(".table_1>tbody tr:even").css("background", "#fafafa");
        $(":button[name=clearBtn]").click(function () {
            var $form = $(this).parents("form");
            $form.find(":text").val("");
            $form.find("select>option:eq(0)").prop("selected", true);
            $form.find("select").val("");
            $form.find("input:hidden").val("");
        });
        $("#nav_ul > li").filter(function (index) {
            return $(this).attr("name") == "business";
        }).addClass("selected");
        $('#beginOpenDate,#endOpenDate').datepicker({
            "changeYear": true
        });

        $("#companyTb").wrapSelect({
            url:"${pageContext.request.contextPath}/dictionary/company/dictionaries?format=json&parentNo=1000000",
            label: "dictName",
            value: "dictId",
            selectVal: "${bidPlan.bidding.route.company}",//默认选中对象
            name: "bidding.route.company"
        });

        $("#routeDiv").wrapSelect({
            url: "${pageContext.request.contextPath}/route/routes?sortByRouteName=1&format=json&pageSize=100",
            label: "routeName",
            value: "routeName",
            root:"routes",
            selectVal: "${bidPlan.routeName}",
            name: "routeName"
        });

        $("#biddingName").autocomplete({

            source: function (request, response) {
                $.ajax({
                    type: "get",
                    url: "${pageContext.request.contextPath}/bidding/fuzzy",
                    dataType: "json",
                    data: encodeURI("biddingName="+request.term+"&format=json"),
                    contentType: "application/x-www-form-urlencoded; charset=UTF-8",
                    success: function (data) {
                        response(data.biddings);
                    }
                });
            },
            minLength: 0,
            select: function (event, ui) {
                $("#biddingName").val(ui.item.biddingName);
                return false;
                /* log( ui.item ?
                 "Selected: " + ui.item.label :
                 "Nothing selected, input was " + this.value);  */
            },
            open: function () {
                $(this).removeClass("ui-corner-all").addClass("ui-corner-top");
            },
            close: function () {
                $(this).removeClass("ui-corner-top").addClass("ui-corner-all");
            }
        }).data("autocomplete")._renderItem = function (ul, item) {
            return $("<li>").data("item.autocomplete", item)
                    .append("<a>" + item.biddingName + "</a>")
                    .appendTo(ul);
        };
    });

</script>
<style type="text/css">
    .ctrl {
        margin-bottom: 0px;
    }

    .filter .query {
        border-bottom: 0px;
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
                    <li class="fin">执行计划管理</li>
                </ul>
            </div>
        </div>
        <!--Filter-->
        <div class="filter">
            <div class="query">
                <div class="p8 filter_search">
                    <form action="${pageContext.request.contextPath}/plan/plans" id="form" method="get">
                        <input type="hidden" id="pageSize" name="pageSize" value="${pageInfo.pageSize }"/>
                        <input type="hidden" id="pageIndex" name="pageIndex" value="${pageInfo.pageIndex } "/>

                        <table width="100%" border="0" cellspacing="0" cellpadding="0">
                            <tr>
                                <td class="t_r">项目公司</td>
                                <td id="companyTb">

                                </td>
                                <td class="t_r">线路名称</td>
                                <td>
                                    <div id="routeDiv">

                                    </div>
                                </td>
                                <td class="t_r">标段名称</td>
                                <td>
                                    <input type="text" name="biddingName" id="biddingName" style="width:100%;"
                                           value="${bidPlan.biddingName }">
                                </td>
                            </tr>
                            <tr>
                                <td class="t_r">开标时间</td>
                                <td class="t_l"><input type="text" readonly="readonly" id="beginOpenDate" style=" width: 143px;"
                                                                   name="beginOpenDate"
                                                                   value="<fmt:formatDate value="${bidPlan.beginOpenDate }" pattern="yyyy-MM-dd"/>"/>至<input style=" width: 143px;"
                                        readonly="readonly" type="text" id="endOpenDate" name="endOpenDate"
                                        value="<fmt:formatDate value="${bidPlan.endOpenDate }" pattern="yyyy-MM-dd"/>"/>
                                </td>
                                <td class="t_r">招标方式</td>
                                <td>
                                    <select name="bidType">
                                        <option value="">请选择</option>
                                        <option value="1" <c:if test="${bidPlan.bidType=='1'}">selected</c:if>>单线</option>
                                        <option value="2" <c:if test="${bidPlan.bidType=='2'}">selected</c:if>>集中</option>
                                    </select>
                                </td>
                                <td class="t_r"></td>
                                <td>

                                </td>
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
        <!--  <input type="button" name="excelButton" id="excelButton" value="导 出当页至 EXCEL" class="fl">
           &nbsp;<input type="button" name="excelAllButton" id="excelAllButton" value="导 出全部至 EXCEL" class="fl">
         -->
    </div>
    <!--Filter End-->
    <!--Table-->
    <!--  <s:set name="r" value="#request.pageResultSet.list"></s:set> -->
    <div class="mb10">
        <table width="100%" class="table_1" id="mytable">
            <thead>
            <tr>
                <th colspan="30">&nbsp;&nbsp;执行计划列表
                    <input type="button" onclick="addPlan('2');" value="新增集中招标计划" class="fr" style="margin-right: 5px;">
                    <input type="button" onclick="addPlan('1');" value="新增单线执行计划" class="fr" style="margin-right: 5px;">
                </th>
            </tr>
            </thead>
            <tbody>
            <tr class="tit">
                <td class="t_c" width="10%">线路名称</td>
                <td class="t_c" width="11%">标段名称</td>
                <td class="t_c" width="8%">上网报名</td>
                <td class="t_c" width="8%">预审资格</td>
                <td class="t_c" width="8%">发标开始</td>
                <td class="t_c" width="8%">发标截至</td>
                <td class="t_c" width="5%">限价</td>
                <td class="t_c" width="8%">开标</td>
                <td class="t_c" width="7%">技术评标</td>
                <td class="t_c" width="7%">商务开标</td>
                <td class="t_c" width="7%">商务评标</td>
                <td class="t_c" width="100" colspan="19">操作</td>
            </tr>
            <c:forEach items="${bidPlans }" var="plan" varStatus="status">
                <tr>

                            <td class="t_c" style="text-align: left;">${plan.routeName}</td>
                            <td class="t_c" style="text-align: left;">${plan.biddingName}</td>


                    <td class="t_c">
                        <fmt:formatDate value="${plan.applyDate}" pattern="yyyy-MM-dd"/>
                    </td>
                    <td class="t_c">
                        <c:choose>
                            <c:when test="${plan.hasCheck != '1'}">无资格预审</c:when>
                            <c:otherwise>
                                <fmt:formatDate value="${plan.checkDate }" pattern="yyyy-MM-dd"/>
                            </c:otherwise>
                        </c:choose>
                    </td>
                    <td class="t_c">
                        <fmt:formatDate value="${plan.bidBegin }" pattern="yyyy-MM-dd"/>
                    </td>
                    <td class="t_c">
                        <fmt:formatDate value="${plan.bidEnd }" pattern="yyyy-MM-dd"/>
                    </td>
                    <td class="t_c">

                        <c:choose>
                            <c:when test="${plan.hasLimit !='1'}">无限价</c:when>
                            <c:when test="${plan.limitPrice ==null}"></c:when>
                            <c:otherwise>
                                ${plan.limitPrice }
                            </c:otherwise>
                        </c:choose>
                    </td>
                    <td class="t_c">
                        <fmt:formatDate value="${plan.tecOpenDate }" pattern="yyyy-MM-dd"/>
                    </td>
                    <td class="t_c">
                        <fmt:formatDate value="${plan.tecAppraiseDate }" pattern="yyyy-MM-dd"/>
                    </td>
                    <td class="t_c">
                        <fmt:formatDate value="${plan.bizOpenDate }" pattern="yyyy-MM-dd"/>
                    </td>
                    <td class="t_c">
                        <fmt:formatDate value="${plan.bizAppraiseDate }" pattern="yyyy-MM-dd"/>
                    </td>
                    <td class="t_c" colspan="19">
                        <a class="fl mr5" href="javascript:void(0)"
                           onclick="location.href='${pageContext.request.contextPath}/result/detail?biddingPlanId=${plan.biddingPlanId }'">投标</a>
                        <c:choose>
                            <c:when test="${plan.bidType=='1'}"> <a class="fl mr5" href="javascript:void(0)" onclick="editData('${plan.biddingPlanId }','1');">修改</a></c:when>
                            <c:when test="${plan.bidType=='2'}"> <a class="fl mr5" href="javascript:void(0)" onclick="editData('${plan.biddingPlanId }','2');">修改</a></c:when>
                        </c:choose>

                        <a class="fl mr5" href="javascript:void(0)" onclick="deletes('${plan.biddingPlanId }')">删除</a>
                        <!-- onclick="deleteData('<s:property value='projectId'/>')" -->
                    </td>
                </tr>
            </c:forEach>
            </tbody>
            <tfoot>

            <jsp:include page="../pageInfo.jsp"></jsp:include>
            </tfoot>
        </table>

    </div>


</div>
</div>


</body>
</html>