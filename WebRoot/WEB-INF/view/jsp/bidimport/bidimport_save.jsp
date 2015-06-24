<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8"/>
    <title>编辑本月招标计划
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
            if($("#routeName").val()==""){
                alert("请输入线路名称");
                return false;
            }
           
            if($("#biddingName").val()==""){
                alert("请输入标段名称");
                return false;
            }
            
            if($("#fullTypeName").val()==""){
                alert("请输入标段类型");
                return false;
            }
            if($("#bidType").val()==""){
                alert("请选择招标方式");
                return false;
            }
            if($("#biddingNo").val()==""){
                alert("请输入标段编码");
                return false;
            }
            
            
            if ("" == $("#pageIndex").val())
                $("#pageIndex").val(1);
            return true;
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
		             <li class="fin">编辑本月招标计划</li>
		        </ul>
		    </div>
		</div>
        <form method="post" action="${pageContext.request.contextPath}/bidimport/save">
            <input type="hidden" id="pageIndex" name="pageIndex" value="${pageIndex }">
            <input type="hidden" id="biddingId" name="biddingId" value="${bidImport.biddingId }"/>
             <input type="hidden" id="mainId" name="mainId" value="${bidImport.mainId }"/>
            <table width="100%" class="table_1">
                <thead>
                <th colspan="4" class="t_r">
                    &nbsp;</th>
                </thead>
                <tbody>
                <tr>
                    <td class="t_r lableTd" style="width:10%;">线路名称：</td>
                    <td style="width:30%;">
                        <input type="text" id="routeName" name="routeName" class="input_xxlarge"
                               value="${bidImport.routeName }"/>
                    </td>
                    <td class="t_r lableTd" style="width:15%;">标段名称：</td>
                    <td style="width:45%;">
                        <input type="text" id="biddingName" name="biddingName" class="input_xxlarge"
                               value="${bidImport.biddingName }"/>
                    </td>
                </tr>
                 <tr>
                    <td class="t_r lableTd" style="width:10%;">标段类型：</td>
                    <td style="width:30%;">
                        <input type="text" id="fullTypeName" name="fullTypeName" class="input_xxlarge"
                               value="${bidImport.fullTypeName }"/>
                    </td>
                    <td class="t_r lableTd" style="width:15%;">招标方式：</td>
                    <td style="width:45%;">
                    	<select id='bidType' name="bidType">
                            <option value="单线" <c:if test="${bidImport.bidTypeCode=='1'}">selected="selected"</c:if>>单线</option>
                            <option value="集中" <c:if test="${bidImport.bidTypeCode=='2'}">selected="selected"</c:if>>集中</option>
                        </select>
                    </td>
                </tr>
                <tr>
                    <td class="t_r lableTd" style="width:10%;">标段编码：</td>
                    <td style="width:30%;" colspan="3">
                        <input type="text" id="biddingNo" name="biddingNo" class="input_xxlarge"
                               value="${bidImport.biddingNo }"/>
                    </td>
                </tr>

                <tr>
                    <td class="t_r lableTd" style="width:10%;">招标文件完成日期：</td>
                    <td style="width:30%;">
                        <input type="text" id="fileEndDate" name="fileEndDate" class="input_xxlarge" value="<fmt:formatDate value="${bidImport.fileEndDate }" pattern="yyyy-MM-dd"/>"/>
                    </td>
                    <td class="t_r lableTd" style="width:15%;">评标日期：</td>
                    <td style="width:45%;">
                        <input type="text" id="appraiseDate" name="appraiseDate" class="input_xxlarge"
                               value="<fmt:formatDate value="${bidImport.appraiseDate }" pattern="yyyy-MM-dd"/>"/>
                    </td>
                </tr>
                
                
                
                </tbody>
                <tr class="tfoot">
                    <td colspan="4" class="t_r"><input id="save" type="submit" onclick="return checks();" value="保存"/>&nbsp;
                        <input type="button" value="后退"
                               onclick="location.href='${pageContext.request.contextPath}/bidimport/bidimports?mainId=${bidImport.mainId }'"/>&nbsp;
                       <%--  <input type="reset" value="重 置"
							   onclick="location.href='${pageContext.request.contextPath}/bidimport/form'"/>&nbsp; --%></td>
                </tr>
            </table>
        </form>
    </div>
    <!--Table End-->
</div>
</body>
</html>
