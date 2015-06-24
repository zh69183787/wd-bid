<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="cn">
<head>
    <meta charset="utf-8"/>
    <title>招标计划列表</title>

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

    <script type="text/javascript">


        $(function () {

            $(":button[name=clearBtn]").click(function () {
                var $form = $(this).parents("form");
                $form.find(":text").val("");
                $form.find("select>option:eq(0)").prop("selected", true);
                $form.find("select").val("");
                $form.find("input:hidden").val("");
            });


            $(".table_1>tbody tr:even").css("background", "#fafafa");


            $('#createTimeBegin,#createTimeEnd,#completeDateBegin,#completeDateEnd,#appraiseDateBegin,#appraiseDateEnd').datepicker({
                "changeYear": true
            });

            $("#routeDiv").wrapSelect({
                url: "${pageContext.request.contextPath}/route/routes?sortByRouteName=1&format=json&pageSize=100",
                label: "routeName",
                value: "routeId",
                root:"routes",
                selectVal: "${bidding.routeId}",
                name: "routeId"
            });

            $("#nav_ul > li").filter(function (index) {
                return $(this).attr("name") == "business";
            }).addClass("selected");
            $("a[id^=deletes]").click(function () {//获取主键值
                var ids = $(this).attr("id");
                var projectId = $(this).attr("title");
                var param = "?projectId=" + projectId + "&page=" + $("#page").val();
                if (window.confirm("是否确认删除？"))
                    window.location.href = "deletes.action" + param;
            });

            <%--$("#companyDiv").wrapSelect({--%>
                <%--url: "${pageContext.request.contextPath}/dictionary/company/dictionaries?format=json&parentNo=1000000",--%>
                <%--label: "dictName",--%>
                <%--value: "dictId",--%>
                <%--selectVal: "${route.company}",--%>
                <%--name: "company"--%>
            <%--});--%>
            <%--$("#companyDiv").bind("completed", function () {--%>
                <%--$("tbody > tr").find("td:eq(1)").each(function (i, o) {--%>
                    <%--if ($(o).find("span").text() != "")--%>
                        <%--$(o).text($("select[name='company']").find("option[value=" + $(o).find("span").text() + "]").text());--%>
                <%--})--%>
            <%--});--%>


        });


        function cancelResult(biddingId) {
            if (window.confirm("是否确认取消？")) {
                location.href = '${pageContext.request.contextPath}/bidding/cancel?biddingId=' + biddingId;
            }

        }

        //添加跳转
        function add() {
            //window.open("project_add.jsp");
            window.location.href = "${pageContext.request.contextPath}/bidding/form";
        }
        //编辑跳转
        function editData(biddingId) {

            window.location.href = "${pageContext.request.contextPath}/bidding/" + biddingId + "?pageIndex=" + $('#pageIndex').val() + "&pageSize=" + $('#pageSize').val();
            //newWindow=window.open("project.action?projectId="+id);
        }

        //变更历史管理跳转
        function bidChange(biddingId) {
            window.location = "${pageContext.request.contextPath}/bidding/change/changings?bidding.biddingId=" + biddingId;

        }
        //删除
        function deletes(biddingId) {
            if (window.confirm("是否确认删除？")) {
                location.href = "${pageContext.request.contextPath}/bidding/" + biddingId + "/delete";
            }
        }

    </script>

    <style>
        .dateInput {
            width: 100px;
        }

        .ui-menu {
            width: 250px;
        }

        .ui-datepicker-title span {
            display: inline;
        }

        .ctrl {
            margin-bottom: 0px;
        }

        .filter {
            padding-bottom: 1px;
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
                <li class="fin">招标计划管理</li>
            </ul>
        </div>
    </div>
    <!--Filter-->
    <div class="filter">
        <div class="query">
            <div class="p8 filter_search">
                <form action="${pageContext.request.contextPath}/bidding/biddings" method="get" id="form">
                    <input type="hidden" id="pageSize" name="pageSize" value="${pageInfo.pageSize }"/>
                    <input type="hidden" id="pageIndex" name="pageIndex" value="${pageInfo.pageIndex }"/>

                    <table width="100%" border="0" cellspacing="0" cellpadding="0">
                        <tr>
                            <td class="t_r" width="90">线路名称</td>
                            <td>
                                <div id="routeDiv">

                                </div>
                            </td>

                            <td class="t_r" width="90">标段名称</td>
                            <td>
                                <input type="text" name="biddingName" value="${bidding.biddingName }"/>
                            </td>
                            <td class="t_r" width="90">标段类型</td>
                            <td>
                                <input type="text" name="biddingType"
                                       value="${bidding.biddingType }"/><input style="margin-left: 5px;" type="button"
                                                                               id="selBiddingTypeBtn" value="请选择标段类型"/>
                                <input type="hidden" name="biddingTypeId" value="${bidding.biddingTypeId }"/>
                            </td>


                        </tr>
                        <tr>
                            <td class="t_r">是否完成</td>
                            <td>
                                <select name="isCompleted">
                                    <option value="">请选择</option>
                                    <option value="1" <c:if test="${bidding.isCompleted=='1'}">selected</c:if>>是
                                    </option>
                                    <option value="2" <c:if test="${bidding.isCompleted=='2'}">selected</c:if>>否
                                    </option>
                                </select>
                            </td>
                            <td class="t_r">完成时间</td>
                            <td>
                                <input type="text" id="completeDateBegin"
                                       name="completeDateBegin" class="dateInput"
                                       value="<fmt:formatDate value="${bidding.completeDateBegin }" pattern="yyyy-MM-dd"/>"/>至<input
                                    type="text" id="completeDateEnd" name="completeDateEnd" class="dateInput"
                                    value="<fmt:formatDate value="${bidding.completeDateEnd }" pattern="yyyy-MM-dd"/>"/>
                            </td>
                            <td class="t_r">评标时间</td>
                            <td>
                                <input type="text" id="appraiseDateBegin"
                                       name="appraiseDateBegin" class="dateInput"
                                       value="<fmt:formatDate value="${bidding.appraiseDateBegin }" pattern="yyyy-MM-dd"/>"/>至<input
                                    type="text" id="appraiseDateEnd" name="appraiseDateEnd" class="dateInput"
                                    value="<fmt:formatDate value="${bidding.appraiseDateEnd }" pattern="yyyy-MM-dd"/>"/>
                            </td>

                        </tr>
                        <tr>
                            <td class="t_r">创建时间</td>
                            <td>
                                <input type="text" id="createTimeBegin"
                                       name="createTimeBegin" class="dateInput"
                                       value="<fmt:formatDate value="${bidding.createTimeBegin}" pattern="yyyy-MM-dd"/>"/>至<input
                                    type="text" id="createTimeEnd" name="createTimeEnd" class="dateInput"
                                    value="<fmt:formatDate value="${bidding.createTimeEnd}" pattern="yyyy-MM-dd"/>"/>
                            </td>

                            <td class="t_r">状态</td>
                            <td>
                                <select name="bidState">
                                    <option value="">请选择</option>
                                    <option value="1" <c:if test="${bidding.bidState=='1'}">selected</c:if>>正常</option>
                                    <option value="2" <c:if test="${bidding.bidState=='2'}">selected</c:if>>已取消</option>
                                </select>
                            </td>

                            <td class="t_r">招标方式</td>
                            <td>
                                <select name="bidType">
                                    <option value="">请选择</option>
                                    <option value="1" <c:if test="${bidding.bidType=='1'}">selected</c:if>>单线</option>
                                    <option value="2" <c:if test="${bidding.bidType=='2'}">selected</c:if>>集中</option>
                                </select>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="6" class="t_c"><input type="submit" value="检索" style="width:50px;"><input
                                    type="button" name="clearBtn" value="清除" style="width:50px;margin-left:8px;"></td>
                        </tr>

                        <!--
                     <tr>
                       <td colspan="6" class="t_c">
                           <input type="submit" value="检 索" /></td>
                     </tr> -->
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
    <table width="100%" class="table_1">
        <thead>
        <tr>
            <th colspan="30">&nbsp;&nbsp;招标计划列表
                <input type="button" name="addButton" id="addButton" onclick="add();" value="新 增" class="fr"></th>
        </tr>
        </thead>
        <tbody>
        <tr class="tit">
            <td class="t_c" width="150">线路名称</td>
            <%--<td class="t_c" width="160">项目公司</td>--%>
            <td class="t_c" width="300" >标段名称</td>
            <td class="t_c" width="150">标段类型</td>
            <td class="t_c" width="50">招标方式</td>
            <td class="t_c" width="200">标段编号</td>
            <td class="t_c" width="90">文件完成日期</td>
            <td class="t_c" width="90">评标日期</td>
            <%--<td class="t_c" width="80" style="display:none;">创建时间</td>--%>
            <%--<td class="t_c" width="80" style="display:none;">修改时间</td>--%>
            <td class="t_c" width="50">是否完成</td>
            <%--<td class="t_c" width="80" style="display:none;">完成时间</td>--%>
            <td class="t_c" width="120" colspan="22">操作</td>
        </tr>
        <c:forEach items="${biddings }" var="bidding" varStatus="status">
            <tr id="dataTr">
                <td>${bidding.route.routeName}</td>
                <%--<td><span style="display: none;">${bidding.route.company}</span></td>--%>
                <td title="${bidding.biddingName}"><span class="bidding_name">${bidding.biddingName}</span></td>
                <td><span name="biddingTypeDescription" style="display: none;">${bidding.biddingTypeId }-${bidding.biddingType }</span></td>
                <td class="t_c">
                    <c:choose>
                        <c:when test="${bidding.bidType=='1'}">
                            单线
                        </c:when>
                        <c:when test="${bidding.bidType=='2'}">
                            集中
                        </c:when>
                        <c:otherwise>

                        </c:otherwise>
                    </c:choose>
                </td>
                <td>${bidding.biddingNo}</td>
                <td class="t_c"><fmt:formatDate value="${bidding.fileEndDate}" pattern="yyyy-MM-dd"/></td>
                <td class="t_c"><fmt:formatDate value="${bidding.appraiseDate}" pattern="yyyy-MM-dd"/></td>
                    <%--<td style="display:none;"><fmt:formatDate value="${bidding.createTime}" pattern="yyyy-MM-dd"/></td>--%>
                    <%--<td style="display:none;"> <fmt:formatDate value="${bidding.updateTime}" pattern="yyyy-MM-dd"/></td>--%>
                <td class="t_c">
                    <c:choose>
                        <c:when test="${bidding.isCompleted=='1'}">
                            是
                        </c:when>
                        <c:otherwise>
                            否
                        </c:otherwise>
                    </c:choose>

                </td>
                    <%--<td style="display:none;" class="t_c"><fmt:formatDate value="${bidding.completeDate}" pattern="yyyy-MM-dd"/></td>--%>
                <td colspan="22">
                    <c:if test="${bidding.bidType=='1'}">
                        <a class="fl mr5" <c:if test="${bidding.planNum>0}">style="color: #ccc;"</c:if>
                           <c:if test="${bidding.planNum==0}">href="${pageContext.request.contextPath}/plan/singleRoute?biddingId=${bidding.biddingId}&routeId=${bidding.routeId}"</c:if>>新增执行计划</a>
                    </c:if>

                    <c:if test="${bidding.bidType=='2'}">
                        <%--<a class="fl mr5"--%>
                           <%--href="${pageContext.request.contextPath}/plan/multiRoute?biddingId=${bidding.biddingId}">新增执行计划</a>--%>
                    </c:if>
                    <a class="fl mr5" href="javascript:void(0)" onclick="editData('${bidding.biddingId }')">修改</a>
                    <a class="fl mr5" href="javascript:void(0)" onclick="deletes('${bidding.biddingId }')">删除</a>
                    <a class="fl mr5" href="javascript:void(0)" onclick="cancelResult('${bidding.biddingId }')">取消</a>
                    <a class="fl mr5" href="javascript:void(0)" onclick="bidChange('${bidding.biddingId }')">变更</a>

                </td>
            </tr>
        </c:forEach>
        </tbody>

        <tfoot>
        <jsp:include page="../pageInfo.jsp"></jsp:include>
        </tfoot>
    </table>

</div>


<div style="display: none;" id="companyDiv">

</div>

    <jsp:include page="/biddingTypeTree"></jsp:include>

</div>
</body>
</html>