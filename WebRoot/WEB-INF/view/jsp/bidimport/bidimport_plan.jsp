<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8"/>
    <title>招标计划导入详单
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

           
            $("#navDiv").load("${pageContext.request.contextPath}/navigation", function () {
                $("#nav_ul > li").filter(function (index) {
                    return $(this).attr("name") == "bidding";
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


        });

        function shut() {
            window.opener = null;
            window.open("", "_self");
            window.close();
        }


        
        
        function importData(mainId,filePath){
        	 //加载线路
            $.ajax({ //一个Ajax过程
                type: "get", //以post方式与后台沟通
                url: "${pageContext.request.contextPath}/bidimportmain/importData", //与此php页面沟通
                dataType: 'json',//从php返回的值以 JSON方式 解释
                data: 'format=json&pageSize=100000&mainId='+mainId+'&filePath='+filePath, //发给php的数据有两项，分别是上面传来的u和p
                success: function (data) {//如果调用php成功
                    /* var html = "<option value=''>--请选择线路--</option>";
                    $.each(data.routes, function (i, value) {
                        html += "<option value='" + value.routeId + "'>" + value.routeName + "</option>";
                    });
                    $("[id=routeId]").empty();
                    $("[id=routeId]").append(html);
                    //一下代码段是查询时线路条件
                    $("#routeId").find("option[value=${bidding.routeId}]").attr("selected", true); */

                    //
                    //根据线路加载标段

                }});
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
		            <li class="fin">招标计划导入</li>
		        </ul>
		    </div>
		</div>
        <form method="post" action="${pageContext.request.contextPath}/bidimport/save">
            <input type="hidden" id="pageIndex" name="pageIndex" value="${pageIndex }">
            <input type="hidden" id="biddingId" name="biddingId" value="${bidImport.biddingId }"/>
            <table width="100%" class="table_1">
                <thead>
                <th colspan="4" class="t_r">
                    &nbsp;</th>
                </thead>
                <tbody>
                <tr>
                    <td class="t_r lableTd" style="width:10%;">导入日期：</td>
                    <td style="width:30%;">
                        <fmt:formatDate value="${bidImportMain.createTime }" pattern="yyyy-MM-dd"/>
                    </td>
                    <td class="t_r lableTd" style="width:15%;">所属年月：</td>
                    <td style="width:45%;">
                        <fmt:formatDate value="${bidImportMain.belongDate }" pattern="yyyy-MM-dd"/>
                    </td>
                </tr>
                <tr>
                    <td class="t_r lableTd" style="width:10%;">上报单位：</td>
                    <td style="width:30%;" >
                        ${bidImportMain.bidCompany.companyName }
                    </td>
                    <td class="t_r lableTd" style="width:15%;">是否完成：</td>
                    <td style="width:45%;">
                        ${bidImportMain.isUpdate=='0'?'未完成':'已完成'}
                    </td>
                </tr>

                <tr>
                    <td class="t_r lableTd" >招标计划文件：</td>
                    <td colspan="3">
                        ${bidImportMain.fileName }<input id="importData" type="button" onclick="return importData();" value="导入数据库"/>
                    </td>
                </tr>
                <tr>
                    <td class="t_r lableTd" >上传附件：</td>
                    <td colspan="3">
                        ${bidImportMain.fileGroup }
                    </td>
                </tr>
                
                </tbody>
                <tr class="tfoot">
                    <td colspan="4" class="t_r"><input id="save" type="submit" onclick="return checks();" value="保存"/>&nbsp;
                        <input type="button" value="后退"
                               onclick="location.href='${pageContext.request.contextPath}/bidimportmain/bidImportMains'"/>&nbsp;
                        <input type="reset" value="重 置"/>&nbsp;</td>
                </tr>
            </table>
        </form>
    </div>
    <!--Table End-->
</div>
</body>
</html>
