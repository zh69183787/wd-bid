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
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/jquery-ui.css">
    <script src="${pageContext.request.contextPath}/js/jquery-1.10.2.js"></script>
    <script src="${pageContext.request.contextPath}/js/jquery-ui.js"></script>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css2/formalize.css"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css2/page.css"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css2/imgs.css"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css2/reset.css"/>
    <!--[if IE 6.0]>
    <script src="../js/iepng.js" type="text/javascript"></script>
    <script type="text/javascript">
        EvPNG.fix('div, ul, ol, img, li, input, span, a, h1, h2, h3, h4, h5, h6, p, dl, dt');
    </script>
    <![endif]-->
    <script src="${pageContext.request.contextPath}/js/html5.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/flick/jquery.ui.datepicker-zh-CN.js"></script>


    <script type="text/javascript">


        //跳转到制定页
        function goPage(pageNo, type) {
            //type=0,直接跳转到指定页
            if (type == "0") {
                var totalPage = $("#totalPageCount").val();//总页数
                var pageNumber = $("#pageNumber").val();//当前页码
                if (!pageNumber.match(/^[0-9]*$/)) {//输入不是数字时提示
                    alert("请输入数字");
                    $("#pageNumber").val("");
                    $("#pageNumber").focus();
                    return;
                }
                if (parseInt(pageNumber) > parseInt(totalPage)) {
                    $("#pageNumber").val(totalPage);
                    $("#pageIndex").val(totalPage);
                } else {
                    $("#pageIndex").val(pageNumber);
                }
            }
            //type=1,跳转到上一页
            if (type == "1") {
                $("#pageIndex").val(parseInt($("#pageIndex").val()) - 1);
            }
            //type=2,跳转到下一页
            if (type == "2") {
                $("#pageIndex").val(parseInt($("#pageIndex").val()) + 1);
                //alert($("#pageNo").val());
            }

            //type=3,跳转到最后一页,或第一页
            if (type == "3") {
                $("#pageIndex").val(pageNo);
            }
            if (true) {//校验
                $("#form").submit();
            }
        }

        $(function () {

            $('#createTime,#belongDate,#appraiseDate,#updateTime').datepicker({
                "changeYear": true
            });
/* 
            $('#biddingTypeId > option[value=${bidding.biddingTypeId}]').prop("selected",true);

            var bidding = $("#menu a[title=${bidding.biddingTypeId}]").text();
            $("#menu a[title='']").text(bidding);
            $( "#menu" ).menu();//biddingTypeId
            $( "#menu a" ).click(function(){
                $("a[title='']").text($(this).text());
                $("#biddingTypeId").val($(this).attr("title"));
            }); */

           
            $("#nav_ul > li").filter(function (index) {
                return $(this).attr("name") == "business";
            }).addClass("selected");
            $("a[id^=deletes]").click(function () {//获取主键值
                var ids = $(this).attr("id");
                var projectId = $(this).attr("title");
                var param = "?projectId=" + projectId + "&page=" + $("#page").val();
                if (window.confirm("是否确认删除？"))
                    window.location = "deletes.action" + param;
            });

            $("tbody > tr").find("td:eq(2) > span").each(function (i, o) {
                var biddingType = [];
                var txt = $(o).text().split("-");
                var v = txt[0];
                if (v.length > 1) {
                    for (var i = 0; i < v.length-1; i++) {
                        var c = v.substring(0, (i + 1));
                        biddingType[i] = $("a[title=" + c + "]").text();
                    }

                    $(o).parent().text(biddingType.join("-"));
                } else {
                    $(o).parent().text("其他-" + txt[1]);
                }
            });

            $("#menu").menu();
        });

        function cancelResult(biddingId){
            if (window.confirm("是否确认取消？")) {
                location.href = '${pageContext.request.contextPath}/bidimport/cancel?biddingId='+biddingId;
            }

        }

        //添加跳转
        function add() {
            //window.open("project_add.jsp");
            window.location = "${pageContext.request.contextPath}/bidimport/form";
        }
        //编辑跳转
        function editData(biddingId) {

            window.location = "${pageContext.request.contextPath}/bidimport/" + biddingId ;
        }
        //删除
        function deletes(biddingId) {
            if (window.confirm("是否确认删除？")) {
                $("#biddingId").val(biddingId);
                $("#removed").val("1");
                $("#delete").submit();
            }
        }
        
        
        //数据对比
        function completeData(mainId){
        	window.location = "${pageContext.request.contextPath}/bidimport/completeData?mainId=" + mainId ;
        }

    </script>

    <style>
        .dateInput{
            width: 170px;
        }
        .ui-menu {
            width: 250px;
        }

        .ui-datepicker-title span {
            display: inline;
        }

    </style>
</head>

<body>

<div class="main">
    <div class="">
        <!--Filter-->
        <div class="filter" style="display: none;">
            <div class="query">
                <div class="p8 filter_search">
                	<div class="ctrl clearfix nwarp" style="margin-top: 48px;">
					    <div class="fl"><img src="../images/sideBar_arrow_left.jpg" width="46" height="30" alt="收起"></div>
					    <div class="posi fl">
					        <ul>
					            <li><a href="#">首页</a></li>
					            <li class="fin">招标计划导入</li>
					        </ul>
					    </div>
					</div>
                    <form action="${pageContext.request.contextPath}/bidimport/bidimportsForMain" method="get" id="form">
                        <input type="hidden" id="pageSize" name="pageSize" value="${pageInfo.pageSize }"/>
                        <input type="hidden" id="mainId" name="mainId" value="${mainId}"/>
                        <input type="hidden" id="pageIndex" name="pageIndex" value="${pageInfo.pageIndex }"/>

                        <table width="100%" border="0" cellspacing="0" cellpadding="0">
                            <tr>
                               	 <td class="t_r" width="90">标段编号</td>
                                <td>
                                    <input type="text" name="biddingNo" value="${bidImport.biddingNo }"/>
                                </td>
                                <td class="t_r" width="90">标段名称</td>
                                <td>
                                    <input type="text" name="biddingName" value="${bidImport.biddingName }"/>
                                </td>
                                <td class="t_r" width="90">招标方式</td>
                                <td>
                                    <input type="text" name="bidType" value="${bidImport.bidType }"/>
                                </td>

                                <td class="t_r" width="90">计划是否更新</td>
                                <td>
                                    <select name="isUpdate">
                                        <option value="">请选择</option>
                                        <option value="1" <c:if test="${bidImport.isUpdate=='1'}">selected</c:if>>是</option>
                                        <option value="2" <c:if test="${bidImport.isUpdate=='2'}">selected</c:if>>否</option>
                                    </select>
                                </td>
                            </tr>
                            <tr>
                                <td class="t_r">所属年月</td>
                                <td>
                                    <input type="text" id="belongDate"
                                           name="belongDate" class="dateInput"
                                           value="<fmt:formatDate value="${bidImport.belongDate }" pattern="yyyy-MM-dd"/>"/>
                                </td>
                                <td class="t_r">评标日期</td>
                                <td>
                                    <input type="text" id="appraiseDate"
                                           name="appraiseDate" class="dateInput"
                                           value="<fmt:formatDate value="${bidImport.appraiseDate}" pattern="yyyy-MM-dd"/>"/>
                                </td>
                                <td class="t_r">创建时间</td>
                                <td>
                                    <input type="text" id="createTime"
                                           name="createTime" class="dateInput"
                                           value="<fmt:formatDate value="${bidImport.createTime}" pattern="yyyy-MM-dd"/>"/>
                                </td>

                                <td class="t_r">修改时间</td>
                                <td>
                                    <input type="text" id="createTimeBegin"
                                           name="createTimeBegin" class="dateInput"
                                           value="<fmt:formatDate value="${bidImport.updateTime}" pattern="yyyy-MM-dd"/>"/>
                                </td>
                            </tr>
                            <tr>
                                <td colspan="8" class="t_c"><input type="submit" value="检索" style="width:50px;"></td>
                            </tr>

                        </table>
                    </form>
                    <form action="${pageContext.request.contextPath}/bidimport/save" method="POST" id="delete">
                        <input type="hidden" id="biddingId" name="biddingId" value=""/>
                        <input type="hidden" id="removed" name="removed" value=""/>
                    </form>

                </div>
            </div>
        </div>
        <div  style="height: 25px;">
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<h5 class="fl"><a href="#" class="colSelect fl">标段信息列表</a></h5>
            &nbsp;<input type="button" name="completeData" id="completeData" onclick="completeData('${mainId}');" value="数据对比" class="fr">
            &nbsp;<input type="button" name="addButton" id="addButton" onclick="add();" value="新 增" class="fr">
            <!--  <input type="button" name="excelButton" id="excelButton" value="导 出当页至 EXCEL" class="fl">
               &nbsp;<input type="button" name="excelAllButton" id="excelAllButton" value="导 出全部至 EXCEL" class="fl">
             --> </div>
    </div>
    <!--Filter End-->
    <!--Table-->
    <!--  <s:set name="r" value="#request.pageResultSet.list"></s:set> -->
    <div class="mb10">
        <table width="100%" class="table_1" id="mytable">
            <thead>
            <tr class="tit">
             <td class="t_c" width="100">线路</td>
                <td class="t_c" width="80">子目</td>
                <td class="t_c" width="80">类别</td>
                <td class="t_c" width="80">专业</td>
                <td class="t_c" width="120">标段</td>
                <td class="t_c" width="120">标段名称</td>
                <td class="t_c" width="80">招标方式</td>
                <td class="t_c" width="180">标段编号</td>
                <td class="t_c" width="100">招标文件完成日期</td>
                <td class="t_c" width="80">评标日期</td>
                <td class="t_c" width="100">对比结果</td>
                <td class="t_c" width="200">操作</td>
            </tr>
            </thead>
            <tbody>
            <c:forEach items="${bidImports }" var="bidImport" varStatus="status">
                <tr id="dataTr">
                    <td>${bidImport.routeName}</td>
                    <td>${bidImport.typeOne}</td>
                    <td>${bidImport.typeTwo}</td>
                    <td>${bidImport.typeThree}</td>
                    <td>${bidImport.typeFour}</td>
                    <td>${bidImport.biddingName}</td>
                    <td>${bidImport.bidType}</td>
                    <td>${bidImport.biddingNo}</td>
                    <td><fmt:formatDate value="${bidImport.fileEndDate}" pattern="yyyy-MM-dd"/></td>
                    <td><fmt:formatDate value="${bidImport.appraiseDate}" pattern="yyyy-MM-dd"/></td>
                  	<td>
                  		<c:choose>
                            <c:when test="${bidImport.urouteId==null||bidImport.urouteId==''}">
                            	<FONT color="RED">新增:线路不存在</FONT>
                            </c:when>
                            <c:when test="${bidImport.ubiddingId==null||bidImport.ubiddingId==''}">
                            	<FONT color="green">新增</FONT>
                            </c:when>
                            <c:when test="${bidImport.ubiddingId!=null&&bidImport.ubiddingId!=''}">
                            	<FONT color="blue">修改</FONT>
                            </c:when>
                            <c:otherwise>
                            	<FONT color="green">其他</FONT>
                            </c:otherwise>
                        </c:choose>
                  	
                  	</td>
                    <td>
                        <c:if test="${bidImport.bidType=='1'}">
                        <a class="fl mr5"
                           href="${pageContext.request.contextPath}/plan/form?biddingId=${bidImport.biddingId}">新增执行计划</a>
                        </c:if>
                        <a class="fl mr5" href="javascript:void(0)" onclick="editData('${bidImport.biddingId }')">修改</a>
                        <a class="fl mr5" href="javascript:void(0)" onclick="deletes('${bidImport.biddingId }')">删除</a>

                    </td>
                </tr>
            </c:forEach>
            </tbody>
         
        </table>

    </div>


</div>
<div style="display: none;">
    <jsp:include page="/menu"/>
</div>
</body>
</html>