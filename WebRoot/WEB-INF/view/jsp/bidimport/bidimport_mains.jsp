<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="cn">
<head>
    <meta charset="utf-8"/>
    <title>招标计划导入列表</title>
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
        	
        	
        	
            $('#createTimeBegin,#createTimeEnd,#belongDateBegin,#belongDateEnd').datepicker({
                "changeYear": true
            });

            $('#biddingTypeId > option[value=${bidding.biddingTypeId}]').prop("selected",true);

            var bidding = $("#menu a[title=${bidding.biddingTypeId}]").text();
            $("#menu a[title='']").text(bidding);
            $( "#menu" ).menu();//biddingTypeId
            $( "#menu a" ).click(function(){
                $("a[title='']").text($(this).text());
                $("#biddingTypeId").val($(this).attr("title"));
            });

            
            //上报单位http://localhost:8070/bid/dictionary/dictionaries?format=json&id=1000000
            $.ajax({
                type: "GET",
                url: "${pageContext.request.contextPath}/dictionary/company/dicts",
                dataType: "json",
                data: 'format=json&pageSize=100000&id=1000000',
                success: function (data) {
                    var html = "<option value=''>--请选择上报单位--</option>";
                    var dval = $("#companyId").attr("dvalue");
                    $.each(data.dictionaries, function (i, value) {
                        //alert(value.routeName);
                        if(value.dictId==dval){
                        	 html += "<option selected='selected' value='" + value.dictId + "'>" + value.dictName + "</option>";
                        }else{
                        	 html += "<option value='" + value.dictId + "'>" + value.dictName + "</option>";
                        }
                       
                    });

                    $("#companyId").empty();
                    $("#companyId").append(html);
                   
                }
            });
            
            
            
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
            	$('#loading').dialog('open');
                location.href = '${pageContext.request.contextPath}/bidding/cancel?biddingId='+biddingId;
            }

        }

        //添加跳转
        function add() {
            //window.open("project_add.jsp");
            $('#loading').dialog('open');
            window.location = "${pageContext.request.contextPath}/bidimportmain/form";
        }
        //编辑跳转
        function editData(mainid) {
        	$('#loading').dialog('open');
            window.location = "${pageContext.request.contextPath}/bidimportmain/" + mainid;
        }
      
        //删除
        function deletes(biddingId) {
            if (window.confirm("是否确认删除？")) {
            	$('#loading').dialog('open');
                $("#biddingId").val(biddingId);
                $("#removed").val("1");
                $("#delete").submit();
            }
        }
        
        
      //数据库文件导入数据库
        function importData(mainid,filePath,isupdate) {
            //window.location = "${pageContext.request.contextPath}/bidimportmain/importData?mainId=" + mainid + "&filePath=" + filePath+ "";
            //是否已经更新是否已经更新0 未导入1 已导入未对比2已对比未更新3已更新
            
            var str = "是否确认导入？";
            if(isupdate!='0'){
            	str ="该数据已经导入数据库！是否确认重新导入？";
            }
            
            if (window.confirm(str)) {
            	$('#loading').dialog('open');
            	 //导入数据库
                $.ajax({ //一个Ajax过程
                    type: "get", //以post方式与后台沟通
                    url: "${pageContext.request.contextPath}/bidimportmain/importData", //与此php页面沟通
                    dataType: 'json',//从php返回的值以 JSON方式 解释
                    data: 'format=json&pageSize=100000&mainId='+mainid+'&filePath='+filePath, //发给php的数据有两项，分别是上面传来的u和p
                    success: function (data) {//如果调用php成功
                    	if(data.map.error){
                    		alert(data.map.error);
                    		$('#loading').dialog('close');
                    	}else{
                    		alert(data.map.ok);
                    		location.href = '${pageContext.request.contextPath}/bidimport/bidimports?mainId='+mainid;
                    	}
                 }});
                
            }
        	
        }
      function showPlans(mainid,isupdate){
    	  /* if(isupdate=='0'){
          	alert("请先执行入库操作之后查看！");
          	return false;
          } */
          $('#loading').dialog('open');
    	  location.href = "${pageContext.request.contextPath}/bidimport/bidimports?mainId="+mainid;
      }

    </script>
	
	 <style>
          .dateInput{
            width: 100px;
        }
        .ui-menu {
            width: 250px;
        }

        .ui-datepicker-title span {
            display: inline;
        }
       .ctrl{
    		margin-bottom:0px;
    	}
    	.filter{
    		padding-bottom:1px;
    	}
    	.filter .query{
    		border-bottom:0px;
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
		            <li class="fin"><a href="${pageContext.request.contextPath}/bidimportmain/bidImportMains">招标计划导入</a></li>
		        </ul>
		    </div>
		</div>
        <!--Filter-->
        <div class="filter">
            <div class="query">
                <div class="p8 filter_search">
                    <form action="${pageContext.request.contextPath}/bidimportmain/bidImportMains" method="get" id="form">
                        <input type="hidden" id="pageSize" name="pageSize" value="${pageInfo.pageSize }"/>
                        <input type="hidden" id="pageIndex" name="pageIndex" value="${pageInfo.pageIndex }"/>

                        <table width="100%" border="0" cellspacing="0" cellpadding="0">
                            <tr>
                               <td class="t_r">导入日期</td>
                                <td>
                                    <input type="text" id="createTimeBegin"
                                           name="createTimeBegin" class="dateInput"
                                           value="<fmt:formatDate value="${bidImportMain.createTimeBegin}" pattern="yyyy-MM-dd"/>"/>至<input
                                        type="text" id="createTimeEnd" name="createTimeEnd" class="dateInput"
                                        value="<fmt:formatDate value="${bidImportMain.createTimeEnd}" pattern="yyyy-MM-dd"/>"/>
                                </td>
                                
                                <td class="t_r">所属年月</td>
                                <td>
                                    <input type="text" id="belongDateBegin"
                                           name="belongDateBegin" class="dateInput"
                                           value="<fmt:formatDate value="${bidImportMain.belongDateBegin}" pattern="yyyy-MM-dd"/>"/>至<input
                                        type="text" id="belongDateEnd" name="belongDateEnd" class="dateInput"
                                        value="<fmt:formatDate value="${bidImportMain.belongDateEnd}" pattern="yyyy-MM-dd"/>"/>
                                </td>
                                
                                
                                <td class="t_r" width="90">上报单位</td>
                                <td>
                                	 <select id="companyId" name="companyId" dvalue="${bidImportMain.companyId}">
                                        <option value="">--请选择上报单位--</option>
                                    </select>
                                    
                                </td>
                                <td class="t_r" width="90">导入状态</td>
                                <td>
                                     <select name="isUpdate">
                                        <option value="">请选择导入状态</option>
                                        <option value="-1" <c:if test="${bidImportMain.isUpdate=='-1'}">selected</c:if>>未入库</option>
                                        <option value="-2" <c:if test="${bidImportMain.isUpdate=='-2'}">selected</c:if>>已入库</option>
                                    </select>
                                </td>
                               

                            </tr>
                            
                            <tr>
                                <td colspan="4" class="t_r"><input type="submit" value="检 索" style="width:50px;"></td>
                                <td colspan="4" class="t_l"><input type="button" value="清 除"
							  		 onclick="return resetSearch('form','ubiddingTypeId')" />&nbsp;</td>
                            </tr>

                            <!--
                         <tr>
                           <td colspan="6" class="t_c">
                               <input type="submit" value="检 索" /></td>
                         </tr> -->
                        </table>
                    </form>
                    <form action="${pageContext.request.contextPath}/bidimportmain/save" method="POST" id="delete">
                        <input type="hidden" id="mainId" name="mainId" value=""/>
                        <input type="hidden" id="removed" name="removed" value="1"/>
                    </form>

                </div>
            </div>
        </div>
       <!--  <div style="height: 25px;">
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<h5 class="fl"><a href="#" class="colSelect fl">标段信息列表</a></h5>
            &nbsp;<input type="button" name="addButton" id="addButton" onclick="add();" value="新 增" class="fr">
             <input type="button" name="excelButton" id="excelButton" value="导 出当页至 EXCEL" class="fl">
               &nbsp;<input type="button" name="excelAllButton" id="excelAllButton" value="导 出全部至 EXCEL" class="fl">
             </div> -->
    </div>
    <!--Filter End-->
    <!--Table-->
    <!--  <s:set name="r" value="#request.pageResultSet.list"></s:set> -->
    <div class="mb10">
        <table width="100%" class="table_1" id="mytable">
      		<thead>
				<tr>
				    <th colspan="30">&nbsp;&nbsp;招标计划导入列表
				    <input type="button" name="addButton" id="addButton" onclick="add();" value="新 增" class="fr"></th>
				</tr>
			</thead>
            <tr class="tit">
                <td class="t_c" width="100">导入日期</td>
                <td class="t_c" width="150">计划所属年月</td>
                <td class="t_c" width="250">上报单位</td>
                <td class="t_c" >招标计划</td>
                <td class="t_c" width="100">当前状态</td>
                <td class="t_c" >操作</td>
            </tr>
            <tbody>
            <c:forEach items="${bidImportMains }" var="bmain" varStatus="status">
                <tr id="dataTr">
                    <td> <fmt:formatDate value="${bmain.createTime}" pattern="yyyy-MM-dd"/></td>
                    <td> <fmt:formatDate value="${bmain.belongDate}" pattern="yyyy-MM-dd"/></td>
                    <td>${bmain.dictCompany.dictName }</td>
                    <td>
                    <a href='${pageContext.request.contextPath}/attachment/${bmain.filePath}' >${bmain.attachment.attachName}</a></td>
                    <td>${bmain.isUpdate=='0'?'未入库':'已入库'}</td>
                    <td>
                        <a class="fl mr5" href="javascript:void(0)" onclick="editData('${bmain.mainId}')">修改</a>
                        <a class="fl mr5" href="javascript:void(0)" onclick="importData('${bmain.mainId}','${bmain.filePath}','${bmain.isUpdate}')" title="将招标文件导入数据库">入库</a>
                        <a class="fl mr5" href="javascript:void(0)" onclick="showPlans('${bmain.mainId}','${bmain.isUpdate}')" target="_self" >查看计划数据</a>
                    <%--     <a class="fl mr5" href="javascript:void(0)" onclick="deletes('${bidding.biddingId }')">删除</a>
                        <a class="fl mr5" href="javascript:void(0)" onclick="cancelResult('${bidding.biddingId }')">取消</a> --%>
                    </td>
                </tr>
            </c:forEach>
            </tbody>
            <jsp:include page="../pageInfo.jsp"></jsp:include>
        </table>

    </div>


</div>

<div style="display: none;">
    <jsp:include page="/menu"/>
</div>
</body>
</html>