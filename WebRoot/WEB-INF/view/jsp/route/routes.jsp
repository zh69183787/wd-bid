<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c" %>
    <%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html>
<html lang="cn">
<head>
<meta charset="utf-8" />
<title>线路信息列表</title>
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
	//添加跳转
	function add(){
		//window.open("project_add.jsp");
		window.location="${pageContext.request.contextPath}/route/form";
	}
	//编辑跳转
	function editData(routeId){
		window.location="${pageContext.request.contextPath}/route/routeEdit?routeId="+routeId+"&pageIndex="+$('#pageIndex').val();
          //newWindow=window.open("project.action?projectId="+id);
    }
	//删除
	function deletes(routeId){
		if(window.confirm("是否确认删除？")){
            location.href = "${pageContext.request.contextPath}/route/" + routeId+"/delete" ;
		}
	}
	$(function(){
        $(".table_1>tbody tr:even").css("background", "#fafafa");

        $("#nav_ul > li").filter(function(index) {
            return $(this).attr("name")=="business";
        }).addClass("selected");

		$("a[id^=deletes]").click(function(){//获取主键值
			var ids=$(this).attr("id");
			var projectId=$(this).attr("title");
			var param="?projectId="+projectId+"&page="+$("#page").val();
			if(window.confirm("是否确认删除？"))
			window.location="deletes.action"+param;
		});
        $("#companyDiv").wrapSelect({
            url:"${pageContext.request.contextPath}/dictionary/company/dictionaries?format=json&parentNo=1000000",
            label:"dictName",
            value:"dictId",
            name:"company"
        });
        $("#companyDiv").bind("completed",function(){
            $("tbody > tr").find("td:eq(3)").each(function(i,o){
                if($(o).find("span").text()!="")
                $(o).text($("select[name='company']").find("option[value="+$(o).find("span").text()+"]").text());
            })
        });
	});
	
    </script>
    <style type="text/css">
    	.ctrl{
    		margin-bottom:0px;
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
		            <li class="fin">线路</li>
		        </ul>
		    </div>
		</div>
      
        	<form action="${pageContext.request.contextPath}/route/routes" id="form" method="get">
	        	<input type="hidden" id="pageSize" name="pageSize" value="${pageInfo.pageSize }"/>
	        	<input type="hidden" id="pageIndex" name="pageIndex" value="${pageInfo.pageIndex } "/>
      	     </form>
      </div>
       
        <!--Table-->
        <!--  <s:set name="r" value="#request.pageResultSet.list"></s:set> -->
        <div class="mb10">
        	<table width="100%"  class="table_1" id="mytable">
        	<thead>
			<tr>
    			<th colspan="30">&nbsp;&nbsp;线路列表
    			<sec:authorize access="hasRole('ROLE_ADMIN')"><input type="button" name="addButton" id="addButton" onclick="add();" value="新 增" class="fr"></sec:authorize></th> 
			</tr>
			</thead>
                              <tbody>
                              <tr class="tit">
                                <td class="t_c" width="20%">线路名称</td>
                                <td class="t_c" width="25%">线路范围</td>
                                  <td class="t_c" width="17%">线路管理员</td>
                                  <td class="t_c" width="25%">项目公司</td>
                                  <sec:authorize access="hasRole('ROLE_ADMIN')">
                                <td colspan="26" class="t_c" width="10%">操作</td>
                                  </sec:authorize>
                                </tr>
                              
                               <c:forEach items="${routes }" var="route" varStatus="status">
                              	<tr id="dataTr">
	                               	<td>${route.routeName }</td>
	                               	<td class="t_c">${route.routeType }</td>
                                    <td class="t_c">${route.user.userName }</td>
                                    <td class="t_c"><span style="display: none;">${route.company }</span></td>
                                    <sec:authorize access="hasRole('ROLE_ADMIN')">
	                               	<td colspan="26">
	                               		<!-- <a class="fl mr5" href="javascript:void(0)" onclick="view('<s:property value='projectId'/>')"  >查看</a> -->

                                            <a class="fl mr5" href="javascript:void(0)" onclick="editData('${route.routeId}')">修改</a>
                                            <a class="fl mr5" href="javascript:void(0)" onclick="deletes('${route.routeId}')">删除</a>

	                               		<!-- onclick="deleteData('<s:property value='projectId'/>')" -->
	                               	</td>
                                    </sec:authorize>  
                               	</tr>
                              	</c:forEach>  
                              </tbody>
                              <tfoot>
                              <jsp:include page="../pageInfo.jsp"></jsp:include>
                              </tfoot>
                             
                             
                            </table>

      </div>
      
      
</div>
    <div style="display: none;" id="companyDiv">

    </div>
</body>
</html>