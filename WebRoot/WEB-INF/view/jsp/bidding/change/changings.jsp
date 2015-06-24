<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="cn">
<head>
    <meta charset="utf-8"/>
    <title>标段信息列表</title>
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

        var format = function (time, format) {
            var t = new Date(time);
            var tf = function (i) {
                return (i < 10 ? '0' : '') + i
            };
            return format.replace(/yyyy|MM|dd|HH|mm|ss/g, function (a) {
                switch (a) {
                    case 'yyyy':
                        return tf(t.getFullYear());
                        break;
                    case 'MM':
                        return tf(t.getMonth() + 1);
                        break;
                    case 'mm':
                        return tf(t.getMinutes());
                        break;
                    case 'dd':
                        return tf(t.getDate());
                        break;
                    case 'HH':
                        return tf(t.getHours());
                        break;
                    case 'ss':
                        return tf(t.getSeconds());
                        break;
                }

            });
        };

        //添加跳转
        function openDialog(changeId) {
            window.parent.scrollTo(0,window.parent.document.body.scrollHeight);

            $("#changeNew").dialog({
                resizable: false,
                height: 300,
                width: 1200,
                open: function () {
                    resetForm();
                    if (changeId) {
                        $.ajax({
                            url: "${pageContext.request.contextPath}/bidding/change/" + changeId,
                            data: {'format': "json"},
                            type: "get",
                            dataType: "json",
                            success: function (data) {
                                data = data.change;
                                $("option[value=" + data.type + "]").prop("selected", true);
                                $("#updateTime").val(format(data.updateTime, 'yyyy-MM-dd'));
                                $("#bidChangeId").val(data.bidChangeId);
                                $("#content").val(data.content);
                                $("#biddingIdList").val(data.biddingIdList);

                                for (var i = 0; i < data.biddingRelations.length; i++) {

                                    var name = data.biddingRelations[i].biddingNo;
                                    var id = data.biddingRelations[i].biddingId;
                                    var bidding = {"name": name, "id": id};
                                    tmpBiddingList.push(bidding);
                                }
                                showSelectedBidding();
                                toggleSelect($("select[name=type]").val());
                            }
                        });
                    }

                },
                modal: true,
                title: '招投标变更历史'
            });
        }
        //删除
        function deletes(changeId) {
            if (window.confirm("是否确认删除？")) {

                    location.href = "${pageContext.request.contextPath}/bidding/change/" + changeId + "/delete?hideHeader=${param.hideHeader}";
            }
        }

        $(function(){

            $(".table_1>tbody tr:even").css("background", "#fafafa");


            $("#routeDiv").wrapSelect({
                url: "${pageContext.request.contextPath}/route/routes?sortByRouteName=1&format=json&pageSize=100",
                label: "routeName",
                value: "routeId",
                root:"routes",
                name: "routeId"
            });
        })

    </script>

    <style>


    </style>
</head>

<body>

<div class="main">
    <!--Ctrl-->
    <c:if test="${param.hideHeader!='1'}">
        <div id="navigation1" class="ctrl clearfix">
            <jsp:include page="/navigation"/>
        </div>
    </c:if>
    <!--Ctrl End-->
    <div class="pt45">
        <c:if test="${param.hideHeader!='1'}">
            <div id="navigation2" class="ctrl clearfix nwarp" style="margin-top: 48px;margin-bottom:0px;">
                <div class="fl"><img src="../../images/sideBar_arrow_left.jpg" width="46" height="30" alt="收起"></div>
                <div class="posi fl">
                    <ul>
                        <li><a href="#">首页</a></li>
                        <li class="fin">变更历史管理</li>
                    </ul>
                </div>
            </div>
        </c:if>
        <!--Filter-->
        <div class="filter">
            <div class="query" style="display:none;">
                <div class="p8 filter_search">
                    <form action="${pageContext.request.contextPath}/bidding/change/changings" method="get" id="form">
                        <input type="hidden" id="pageSize" name="pageSize" value="${pageInfo.pageSize }"/>
                        <input type="hidden" id="pageIndex" name="pageIndex" value="${pageInfo.pageIndex }"/>
                        <input type="hidden" id="hideHeader" name="hideHeader" value="${param.hideHeader}"/>
                        <input type="hidden" id="containerId" name="containerId" value="${param.containerId}"/>
                        <input type="hidden" id="biddingId" name="bidding.biddingId"
                               value="${param['bidding.biddingId'] }"/>
                        <table width="100%" border="0" cellspacing="0" cellpadding="0">
                        </table>
                    </form>
                </div>
            </div>
        </div>
    </div>
    <!--Filter End-->
    <!--Table-->
    <!--  <s:set name="r" value="#request.pageResultSet.list"></s:set> -->
    <div class="mb10" id="changeTable">
        <table width="100%" class="table_1" id="mytable">
            <thead>
            <tr>
                <th colspan="30">&nbsp;&nbsp;变更历史管理
                    <input type="button" name="addButton" id="addButton" onclick="openDialog()" value="新 增" class="fr">
                </th>
            </tr>
            </thead>
            <tbody>
            <tr class="tit">
                <td class="t_c" width="80">变更流水号</td>
                <td class="t_c" width="200">变更时间</td>
                <td class="t_c" width="100">变更类型</td>
                <td class="t_c" width="480">变更内容</td>
                <td class="t_c" width="300">关联标段</td>
                <td class="t_c" width="80" colspan="25">操作</td>
            </tr>
            <c:forEach items="${bidChanges}" var="changings" varStatus="status">
                <tr>
                    <td>${changings.version}</td>
                    <td><fmt:formatDate value="${changings.updateTime}" pattern="yyyy-MM-dd"/></td>
                    <td>${changings.type}</td>
                    <td>${changings.content}</td>
                    <td>
                        <c:forEach items="${changings.biddingRelations}" var="bidding" varStatus="status">
                            <span><a style="text-decoration: underline" target="_blank"
                                     href="${pageContext.request.contextPath}/bidding/${bidding.biddingId}">${bidding.biddingNo}</a></span>
                        </c:forEach>
                    </td>
                    <td colspan="25">
                        <a class="fl mr5" href="javascript:void(0)"
                           onclick="openDialog('${changings.bidChangeId }')">修改</a>
                        <a class="fl mr5" href="javascript:void(0)"
                           onclick="deletes('${changings.bidChangeId }')">删除</a>
                    </td>
                </tr>
            </c:forEach>
            </tbody>
            <tfoot>

            <jsp:include page="../../pageInfo.jsp"></jsp:include>
            </tfoot>
        </table>
    </div>
    <div id="changeNew" style="display:none;">
        <jsp:include page="changing_save.jsp"></jsp:include>
    </div>
</div>
</body>
</html>