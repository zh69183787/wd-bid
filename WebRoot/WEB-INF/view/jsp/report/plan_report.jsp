<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta http-equiv="x-ua-compatible" content="IE=8">
    <title>招标计划汇总表</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css2/formalize.css"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css2/page.css"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css2/imgs.css"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css2/reset.css"/>
    <link type="text/css" href="${pageContext.request.contextPath}/css/flick/jquery-ui-1.8.18.custom.css"
          rel="stylesheet"/>

    <script src="${pageContext.request.contextPath}/js/jquery-1.7.1.js"></script>
    <script type="text/javascript"
            src="${pageContext.request.contextPath}/js/flick/jquery-ui-1.8.18.custom.min.js"></script>
    <script src="${pageContext.request.contextPath}/js/html5.js"></script>
    <script type="text/javascript"
            src="${pageContext.request.contextPath}/js/flick/jquery.ui.datepicker-zh-CN.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/dictionary.js"></script>
</head>
<script>

    $(function () {

        $('#createTimeBegin,#createTimeEnd,#completeDateBegin,#completeDateEnd,#appraiseDateBegin,#appraiseDateEnd').datepicker({
            "changeYear": true
        });

        $(":button[name=clearBtn]").click(function () {
            var $form = $(this).parents("form");
            $form.find(":text").val("");
            $form.find("select>option:eq(0)").prop("selected", true);
            $form.find("select").val("");
            $form.find("input:hidden").val("");
        });


        $(".table_1>tbody tr:even").css("background", "#fafafa");

        $(":hidden[name=biddingTypeId]").bind("dataChange",(function(){
            $("#qucikIndex").find(":radio:eq("+$(this).val().substring(0,1)+")").prop("checked",true);
        }));

        $("#qucikIndex").find(":radio[value=${bidding.biddingTypeId}]").prop("checked",true);

        $("#qucikIndex").find(":radio").click(function(){
            $(":hidden[name=biddingTypeId]").val($(this).val());
            if($(this).val()!="")
            $(":text[name=biddingType]").val($(this).prev().html());
            if($(":hidden[name=biddingTypeId]").val()=="5")
                $(":text[name=biddingType]").prop("disabled",true);
            $("form").submit();
        })


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

        $("#routeDiv").wrapSelect({
            url: "${pageContext.request.contextPath}/route/routes?sortByRouteName=1&format=json&pageSize=100",
            label: "routeName",
            value: "routeId",
            root: "routes",
            selectVal: "${bidding.routeId}",
            name: "routeId"
        });

        $("#nav_ul > li").filter(function (index) {
            return $(this).attr("name") == "plan";
        }).addClass("selected");

        $("form").submit(function(){
            if($("select[name=routeId]").val()=="请选择"){
                $("select[name=routeId]").val("");
            }
        });

        $(".plain").click(function(){
            var color = "";
            if($(this).hasClass("blue"))
                color = "#004B97";
            if($(this).hasClass("orange"))
                color = "#FF8F59";
            if($(this).hasClass("green"))
                color = "#009100";
            if($(this).hasClass("pink"))
                color = "#9F35FF";
            $(":hidden[name=color]").val(color);
            $("form").submit();
        })
    });

</script>
<style>
    .plain {
        margin: 2px;
        float: left;
        width: 50px;
        height: 20px;
        padding-right: 5px;
    }

    .orange {
        background: #FF8F59;
    }

    .blue {
        background: #004B97;
    }

    .green {
        background: #009100;
    }

    .pink {
        background: #9F35FF;
    }
</style>
<body>


<div class="main"><!--Ctrl-->
    <div class="ctrl clearfix">
        <jsp:include page="/navigation"/>
    </div>

    <div class="pt45">
        <div class="ctrl clearfix nwarp" style="margin-top: 48px;">
            <div class="fl"><img src="../images/sideBar_arrow_left.jpg" width="46" height="30" alt="收起"></div>
            <div class="posi fl">
                <ul>
                    <li><a href="#">首页</a></li>
                    <li class="fin">招标计划统计</li>
                </ul>
            </div>
        </div>
        <%--<div class="tabs_2 nwarp" style="display: none;">--%>
        <%--<ul class="nwarp">--%>
        <%--<li class="selected"><a href="#"><span>首页</span></a></li>--%>
        <%--<li><a href="#"><span>招标计划汇总表</span></a></li>--%>
        <%--</ul>--%>
        <%--</div>--%>

        <div class="filter">

            <div class="query p8" style="display: block;">

                <form action="${pageContext.request.contextPath}/report/plan">
                    <input type="hidden" id="pageSize" name="pageSize" value="${pageInfo.pageSize }"/>
                    <input type="hidden" id="pageIndex" name="pageIndex" value="${pageInfo.pageIndex }"/>
                    <input type="hidden" name="color" value="${bidding.color}"/>
                    <table class="wwFormTable">

                    </table>
                    <table width="100%" border="0" cellspacing="0" cellpadding="0">
                        <tbody>
                        <tr>
                            <td class="t_r" style="white-space:nowrap">线路名称</td>
                            <td style="white-space:nowrap">
                                <div id="routeDiv">

                                </div>
                            </td>
                            <td class="t_r" style="white-space:nowrap">标段名称</td>
                            <td style="white-space:nowrap">
                                <input type="text" name="biddingName" value="${bidding.biddingName }"
                                       class="input_xlarge"/>
                            </td>
                            <td class="t_r" style="white-space:nowrap">标段类型</td>
                            <td style="white-space:nowrap">
                                <input type="text" name="biddingType"
                                       value="${bidding.biddingType }"/><input style="margin-left: 5px;" type="button"
                                                                               id="selBiddingTypeBtn" value="请选择标段类型"/>
                                <input type="hidden" name="biddingTypeId" value="${bidding.biddingTypeId}"/>
                            </td>
                        </tr>
                        <tr>
                            <td class="t_r" style="white-space:nowrap">完成时间</td>
                            <td style="white-space:nowrap">
                                <input type="text" id="completeDateBegin"
                                       name="completeDateBegin" class="dateInput" style="width:118px;"
                                       value="<fmt:formatDate value="${bidding.completeDateBegin }" pattern="yyyy-MM-dd"/>"/>~<input
                                    style="width:118px;"
                                    type="text" id="completeDateEnd" name="completeDateEnd" class="dateInput"
                                    value="<fmt:formatDate value="${bidding.completeDateEnd }" pattern="yyyy-MM-dd"/>"/>
                            </td>
                            <td class="t_r" style="white-space:nowrap">评标时间</td>
                            <td>
                                <input type="text" id="appraiseDateBegin" style="width:118px;"
                                       name="appraiseDateBegin" class="dateInput"
                                       value="<fmt:formatDate value="${bidding.appraiseDateBegin }" pattern="yyyy-MM-dd"/>"/>~<input
                                    style="width:118px;"
                                    type="text" id="appraiseDateEnd" name="appraiseDateEnd" class="dateInput"
                                    value="<fmt:formatDate value="${bidding.appraiseDateEnd }" pattern="yyyy-MM-dd"/>"/>
                            </td>
                            <td class="t_r" style="white-space:nowrap">创建时间</td>
                            <td>
                                <input type="text" id="createTimeBegin" style="width:118px;"
                                       name="createTimeBegin" class="dateInput"
                                       value="<fmt:formatDate value="${bidding.createTimeBegin}" pattern="yyyy-MM-dd"/>"/>~<input
                                    style="width:118px;"
                                    type="text" id="createTimeEnd" name="createTimeEnd" class="dateInput"
                                    value="<fmt:formatDate value="${bidding.createTimeEnd}" pattern="yyyy-MM-dd"/>"/>
                            </td>
                        </tr>
                        <tr>
                            <td class="t_r" style="white-space:nowrap">计划是否完成</td>
                            <td style="white-space:nowrap">
                                <select name="isCompleted" class="input_xlarge">
                                    <option value="">请选择</option>
                                    <option value="1" <c:if test="${bidding.isCompleted=='1'}">selected</c:if>>是
                                    </option>
                                    <option value="2" <c:if test="${bidding.isCompleted=='2'}">selected</c:if>>否
                                    </option>
                                </select>
                            </td>
                            <td class="t_r" style="white-space:nowrap">状态</td>
                            <td style="white-space:nowrap">
                                <select name="bidState" class="input_xlarge">
                                    <option value="">请选择</option>
                                    <option value="1" <c:if test="${bidding.bidState=='1'}">selected</c:if>>正常</option>
                                    <option value="2" <c:if test="${bidding.bidState=='2'}">selected</c:if>>已取消</option>
                                </select>
                            </td>
                            <td class="t_r">招标方式</td>
                            <td>
                                <select name="bidType" class="input_xlarge">
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
                        </tbody>
                    </table>
                </form>


            </div>

            <div class="fn clearfix">
<span style="float:left;" id="qucikIndex">
    <div style="float:left;"><span style="float:left;">全部</span><input style="margin-left: 5px;" type="radio" name="quickRadio" checked value=""/></div>
    <div style="float:left;margin-left: 10px;"><span style="float:left;">勘察设计类</span><input name="quickRadio" style="margin-left: 5px;" type="radio" value="1"/></div>
    <div style="float:left;margin-left: 10px;"><span style="float:left;">施工类</span><input name="quickRadio" style="margin-left: 5px;" type="radio" value="2"/></div>
    <div style="float:left;margin-left: 10px;"><span style="float:left;">监理类</span><input name="quickRadio" style="margin-left: 5px;" type="radio" value="3"/></div>
    <div style="float:left;margin-left: 10px;"><span style="float:left;">采购类</span><input name="quickRadio" style="margin-left: 5px;" type="radio" value="4"/></div>
    <div style="float:left;margin-left: 10px;"><span style="float:left;">其他类</span><input name="quickRadio" style="margin-left: 5px;" type="radio" value="5"/></div>
	        		</span>
	        		<span style="float:right;">
	        			<a style="float:left;cursor:pointer;"><div class="blue plain"></div><div style="float: left;margin-right: 8px;">本月新增计划</div></a>
                        <a style="float:left;cursor:pointer;"><div class="green plain"></div><div style="float: left;margin-right: 8px;">本月有进展或变化的计划</div></a>
                        <a style="float:left;cursor:pointer;"><div class="pink plain"></div><div style="float: left;margin-right: 8px;">本月评标的计划</div></a>
                        <a style="float:left;cursor:pointer;"><div class="orange plain"></div><div style="float: left;margin-right: 8px;">上月前完成的计划</div></a>
	        		</span>
            </div>

        </div>


    </div>

    <!--Table-->
    <div class="mb10">

        <table width="100%" class="table_1">
            <thead>
            <tr>
                <th colspan="30">&nbsp;&nbsp;招标计划汇总表</th>
            </tr>
            </thead>
            <tbody>
            <tr class="tit">
                <td class="t_c" width="150">线路名称</td>
                <%--<td class="t_c" width="150">项目公司</td>--%>
                <td class="t_c" width="400" colspan="24">标段名称</td>
                <td class="t_c" width="220">标段类型</td>
                <td class="t_c" width="80">招标方式</td>
                <td class="t_c" width="250">标段编号</td>
                <td class="t_c" width="150">招标文件完成日期</td>
                <td class="t_c" width="100">评标日期</td>
                <%--<td class="t_c" width="80">创建时间</td>--%>
                <%--<td class="t_c" width="80">修改时间</td>--%>
                <%--<td class="t_c" width="50">计划是否完成</td>--%>
                <%--<td class="t_c" width="80">完成时间</td>--%>
                <%--<td class="t_c" width="200">操作</td>--%>
            </tr>
            <c:forEach items="${biddings }" var="bidding" varStatus="status">
                <tr id="dataTr">
                    <td>${bidding.route.routeName}</td>
                        <%--<td><span style="display: none;">${bidding.route.company}</span></td>--%>

                    <td colspan="24">${bidding.biddingName}</td>
                    <td><span name="biddingTypeDescription"
                              style="display: none;">${bidding.biddingTypeId }-${bidding.biddingType }</span></td>
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
                    <td class="t_c"
                        <c:if test="${bidding.color!=null&&bidding.color!=''}">style="background: ${bidding.color};color:white;"</c:if>>
                        <fmt:formatDate value="${bidding.fileEndDate}" pattern="yyyy-MM-dd"/></td>
                    <td class="t_c"
                        <c:if test="${bidding.color!=null&&bidding.color!=''}">style="background: ${bidding.color};color:white;"</c:if>>
                        <fmt:formatDate value="${bidding.appraiseDate}" pattern="yyyy-MM-dd"/></td>
                </tr>
            </c:forEach>

            </tbody>

            <tfoot>
            <jsp:include page="../pageInfo.jsp"></jsp:include>
            </tfoot>
        </table>
    </div>
    <!--Table End-->

</div>
<div style="display: none;" id="companyDiv">

</div>
<jsp:include page="/biddingTypeTree"></jsp:include>

</body>
</html>
