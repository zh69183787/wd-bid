<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8"/>
    <title>招标计划导入对比详情
    </title>

    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/jquery-ui.css">
    <script src="${pageContext.request.contextPath}/js/jquery-1.10.2.js"></script>
    <script src="${pageContext.request.contextPath}/js/jquery-ui.js"></script>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css2/formalize.css"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css2/page.css"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css2/imgs.css"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css2/reset.css"/>
    <!--[if IE 6.0]>
    <script src="js/iepng.js" type="text/javascript"></script>
    <script type="text/javascript">
        EvPNG.fix('div, ul, ol, img, li, input, span, a, h1, h2, h3, h4, h5, h6, p, dl, dt');
    </script>
    <![endif]-->
    <script src="${pageContext.request.contextPath}/js/html5.js"></script>

    <script src="${pageContext.request.contextPath}/js/show.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/check/checkBidding.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/flick/jquery.ui.datepicker-zh-CN.js"></script>

    <style type="text/css">
        .ui-menu {
            width: 250px;
        }

        .ui-datepicker-title span {
            display: inline;
        }

        button.ui-datepicker-current {
            display: none;
        }
    </style>

    <script type="text/javascript">
        $(function () {

            $('#createTime').datepicker({
                //inline: true
                "changeYear": true
//                "showButtonPanel": true,
//                "closeText": '清除',

//                "currentText": 'createTime'//仅作为“清除”按钮的判断条件
            });
           $('#updateTime').datepicker({
                //inline: true
               "changeYear": true
//                "showButtonPanel": true,
//                "closeText": '清除',

//                "currentText": 'planEndDate'//仅作为“清除”按钮的判断条件
            });
            $('#appraiseDate').datepicker({
                //inline: true
                "changeYear": true
//                "showButtonPanel": true,
//                "closeText": '清除',

//                "currentText": 'appraiseDate'//仅作为“清除”按钮的判断条件
            });
            $('#fileEndDate').datepicker({
                //inline: true
                "changeYear": true
//                "showButtonPanel": true,
//                "closeText": '清除',

//                "currentText": 'fileEndDate'//仅作为“清除”按钮的判断条件
            });
           
            $("#navDiv").load("${pageContext.request.contextPath}/navigation", function () {
                $("#nav_ul > li").filter(function (index) {
                    return $(this).attr("name") == "bidImport";
                }).addClass("selected");
            })



            $("#menu").menu();//biddingTypeId
            $("#menu a[name='selected']").click(function () {
                if ($(this).attr("title") == "5") {
                    $("#biddingType").attr("readonly", false);
                    $("#biddingType").focus();
                    $("#biddingType").val("");
                    $("#biddingTypeId").val("");
                } else {
                    $("#biddingType").attr("readonly", true);
                    $("#biddingType").blur();
                    $("#biddingType").val($(this).text());
                    $("#biddingTypeId").val($(this).attr("title"));
                }
            });
            $(".odd tr:odd").css("background", "#fafafa");
           /*  //获取线路
            $.ajax({
                type: "GET",
                url: "${pageContext.request.contextPath}/route/routes",
                dataType: "json",
                data: 'format=json&pageSize=100000',
                success: function (data) {
                    var html = "<option value=''>--选择线路名称--</option>";
                    $.each(data.routes, function (i, value) {
                        //alert(value.routeName);
                        html += "<option value='" + value.routeId + "'>" + value.routeName + "</option>";
                    });

                    $("#routeId").empty();
                    $("#routeId").append(html);
                    var count = $("#routeId").children("option").length;
                    for (var i = 0; i < count; i++) {
                        if ($("#routeId").children("option:eq(" + i + ")").val() == $("#routeIds").val()) {
                            $("#routeId").children("option:eq(" + i + ")").attr("selected", true);
                        }
                    }
                }
            }); */


            $("#biddingName,#biddingNo").blur(function () {

                if (($("#biddingNo").val() != '' || $("#biddingName").val() != '') ) {

                    var flag = false;
                    var biddingName = $("#biddingName").val();
                    $.ajax({
                        type: "post",
                        url: "${pageContext.request.contextPath}/bidimport/compare",
                        dataType: "json",
                        data: 'format=json' + "&biddingName=" + biddingName +  "&biddingId=" + $("#biddingId").val()+ "&biddingNo=" + $("#biddingNo").val(),
                        contentType: "application/x-www-form-urlencoded; charset=UTF-8",
                        success: function (data) {
                            $("#vBiddingName,#vBiddingNo").html("");
                            if ("biddingNameNot" == data.msg) {
                                $("#vBiddingName").html("<font color='red'>该路线下" + $("#biddingName").val() + "的标段已经存在</font>");
                            }

                            if ("biddingNoNot" == data.msg) {
                                $("#vBiddingNo").html("<font color='red'>该路线下" + $("#biddingName").val() + "的编号已经存在</font>");
                            }
                        }
                    });
                }
            });

            if ("" == $("#biddingId").val()) {
                $("#biddingName").val("");
                $("#biddingNo").val("");
            }
        });

        function shut() {
            window.opener = null;
            window.open("", "_self");
            window.close();
        }

        function checks() {
            if($("#biddingNo").val()==""){
                alert("请输入标段编码");
                return false;
            }
           
            if($("#biddingName").val()==""){
                alert("请输入标段名称");
                return false;
            }

            if ("" == $("#pageIndex").val())
                $("#pageIndex").val(1);
            return check();
        }
        
        
        function doUpdate(bid) {
            if($("#urouteId").val()==""){
                alert("线路不存在，不能执行操作！");
                return false;
            }
           
            if($("#ubiddingTypeId").val()==""){
                alert("招标类型不存在，不能执行操作！");
                return false;
            }
            
            if($(".canupdate").length<=0){//没有更新
            	alert("没有变更内容，不需要更新！");
            return false;
            }
            
            if (window.confirm("是否确认更新？")) {
        		window.location = "${pageContext.request.contextPath}/bidimport/compareSave?biddingId="+ bid+"&isUpdate=1";
			}

        }
        function unUpdate(bid) {
        	if (window.confirm("是否确认忽略本条更新？")) {
        		window.location = "${pageContext.request.contextPath}/bidimport/compareSave?biddingId="+ bid+"&isUpdate=2";
			}
        }

    </script>
</head>

<body>
<div class="main">
    <!--Ctrl-->
    <div id="navDiv" class="ctrl clearfix">

    </div>
    <!--Ctrl End-->
    <!--Filter--><!--Filter End-->
    <!--Table-->

    <div class="mb10 pt45">
    	<div class="ctrl clearfix nwarp" style="margin-top: 48px;">
		    <div class="fl"><img src="../images/sideBar_arrow_left.jpg" width="46" height="30" alt="收起"></div>
		    <div class="posi fl">
		        <ul>
		            <li><a href="#">首页</a></li>
		            <li class=""><a href="${pageContext.request.contextPath}/bidimportmain/bidImportMains">招标计划导入</a></li>
		            <li class="fin">招标计划导入对比详情</li>
		        </ul>
		    </div>
		</div>
        <form method="post" action="${pageContext.request.contextPath}/bidimport/save">
            <table width="100%" class="table_1">
                <thead>
                <tr>
                	<td class="t_r " style="width:10%;">&nbsp;</td>
                    <td class="t_r " style="text-align: left; font-size: 14px; font-weight: bold;" >原计划</td>
                    <td class="t_r " style="width:2px; background-color:#d0d0d3; padding: 0px;" ></td>
                    <td class="t_r " style="text-align: left; font-size: 14px; font-weight: bold;" >本月计划</td>
                </tr>
                </thead>
                <tbody>
                
                
                <tr>
                    <td class="t_r lableTd" style="width:10%;">线路：</td>
                    <td>
                        ${bidding.route.routeName }
                    </td>
                    <td class="t_r " style="width:2px; background-color:#d0d0d3; padding: 0px;" ></td>
                    <td>${bidImport.routeName }${bidImport.urouteId==null||bidImport.urouteId==''?'<font class=notupdate color=red>(线路不存在)</font>':''  }
                    <input type="hidden" id="urouteId" value="${bidImport.urouteId}" />
                    </td>
                </tr>
                <tr>
                    <td class="t_r lableTd" style="width:10%;">标段类型：</td>
                    <td>
                        ${bidding.dictBiddingType.dictFullName }
                    </td>
                    <td class="t_r " style="width:2px; background-color:#d0d0d3; padding: 0px;" ></td>
                    <td>
                    
                    <c:choose>
	                    <c:when test="${bidding.biddingTypeId!=null&&bidding.biddingTypeId==bidImport.ubiddingTypeId}">
	                    	${bidImport.fullTypeName }
	                    </c:when>
	                    <c:otherwise>
	                    <font class=canupdate color="red">${bidImport.fullTypeName }</font>
	                    </c:otherwise>
                    </c:choose>
                    ${bidImport.ubiddingTypeId==null||bidImport.ubiddingTypeId==''?'<font class=notupdate color=red>(类型不存在)</font>':''  }
                    <input type="hidden" id="ubiddingTypeId" value="${bidImport.ubiddingTypeId}" />
                    </td>
                </tr>
                <tr>
                    <td class="t_r lableTd" style="width:10%;">标段名称：</td>
                    <td>
                        ${bidding.biddingName }
                    </td>
                    <td class="t_r " style="width:2px; background-color:#d0d0d3; padding: 0px;" ></td>
                    <td>
                    <c:choose>
                    <c:when test="${bidding.biddingName!=null&&bidding.biddingName==bidImport.biddingName}">
                    	${bidImport.biddingName}
                    </c:when>
                    <c:otherwise>
                    <font class=canupdate color="red">${bidImport.biddingName}</font>
                    </c:otherwise>
                    </c:choose>
                    
                    </td>
                </tr>
                <tr>
                    <td class="t_r lableTd" style="width:10%;">标段编码：</td>
                    <td>
                        ${bidding.biddingNo }
                    </td>
                    <td class="t_r " style="width:2px; background-color:#d0d0d3; padding: 0px;" ></td>
                    <td>${bidImport.biddingNo }
                    </td>
                </tr>
                <tr>
                    <td class="t_r lableTd" style="width:10%;">招标方式：</td>
                    <td>
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
                    <td class="t_r " style="width:2px; background-color:#d0d0d3; padding: 0px;" ></td>
                    <td>
                    <c:choose>
                    <c:when test="${bidding.bidType!=null&&bidding.bidType==bidImport.bidTypeCode}">
                    	${bidImport.bidType}
                    </c:when>
                    <c:otherwise>
                    <font class=canupdate color="red">${bidImport.bidType}</font>
                    </c:otherwise>
                    </c:choose>
                    </td>
                </tr>
                <tr>
                    <td class="t_r lableTd" style="width:10%;">招标文件完成时间：</td>
                    <td>
                        <fmt:formatDate value="${bidding.fileEndDate }" pattern="yyyy-MM-dd"/>
                    </td>
                    <td class="t_r " style="width:2px; background-color:#d0d0d3; padding: 0px;" ></td>
                    <td>
                    <c:choose>
                    <c:when test="${bidding.fileEndDate!=null&&bidding.fileEndDate==bidImport.fileEndDate}">
                    	<fmt:formatDate value="${bidImport.fileEndDate }" pattern="yyyy-MM-dd"/>
                    </c:when>
                    <c:otherwise>
                    <font class=canupdate color="red"><fmt:formatDate value="${bidImport.fileEndDate }" pattern="yyyy-MM-dd"/></font>
                    </c:otherwise>
                    </c:choose>
                    
                    </td>
                </tr>
                <tr>
                    <td class="t_r lableTd" style="width:10%;">评标日期：</td>
                    <td>
                        <fmt:formatDate value="${bidding.appraiseDate }" pattern="yyyy-MM-dd"/>
                    </td>
                    <td class="t_r " style="width:2px; background-color:#d0d0d3; padding: 0px;" ></td>
                    <td>
                    <c:choose>
                    <c:when test="${bidding.appraiseDate!=null&&bidding.appraiseDate==bidImport.appraiseDate}">
                    	<fmt:formatDate value="${bidImport.appraiseDate }" pattern="yyyy-MM-dd"/>
                    </c:when>
                    <c:otherwise>
                    <font class=canupdate color="red"><fmt:formatDate value="${bidImport.appraiseDate }" pattern="yyyy-MM-dd"/></font>
                    </c:otherwise>
                    </c:choose>
                    
                    </td>
                </tr>
				
                
                
                </tbody>
                <tr class="tfoot">
                    <td colspan="4" class="t_r">
                    当前状态：${bidImport.isUpdateStr}&nbsp;&nbsp;&nbsp;&nbsp;
                    <input type="button" onclick="return doUpdate('${bidImport.biddingId }');" value="确定更新"/>
                        <input type="button" value="忽略更新"
							   onclick="return unUpdate('${bidImport.biddingId }');"/>&nbsp;
                        <input type="button" value="后退"
                               onclick="location.href='${pageContext.request.contextPath}/bidimport/bidimports?mainId=${bidImport.mainId }'"/>&nbsp;
                        </td>
                </tr>
            </table>
        </form>
        <c:if test="${bidding.biddingId!=null&&bidding.biddingId!=''}">
        <!--Table End-->
	    <iframe height="600"  frameborder="0" border="0" marginwidth="0" marginheight="0" scrolling="no"  width="100%" src="${pageContext.request.contextPath}/bidding/change/changings?bidding.biddingId=${bidding.biddingId}&hideHeader=1"></iframe>
	    <%--<div id="changeDiv">--%>
        </c:if>
	        
    </div>
    <!--Table End-->
</div>
</body>
</html>
