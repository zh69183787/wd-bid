<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>
<html lang="cn">
<head>
    <meta charset="utf-8" />
    <title>用户列表</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css2/formalize.css"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css2/page.css"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css2/imgs.css"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css2/reset.css"/>

    <script src="<%=basePath %>js/html5.js"></script>
    <script src="<%=basePath %>js/jquery-1.7.1.js"></script>
    <script src="<%=basePath %>js/jquery.formalize.js"></script>
    <link type="text/css" href="<%=basePath %>css/flick/jquery-ui-1.8.18.custom.css" rel="stylesheet" />
    <script type="text/javascript" src="<%=basePath %>js/flick/jquery-ui-1.8.18.custom.min.js"></script>
    <script type="text/javascript" src="<%=basePath %>js/flick/jquery.ui.datepicker-zh-CN.js"></script>


    <script type="text/javascript">

        $(function(){
            $("#nav_ul > li").filter(function(index) {
                return $(this).attr("name")=="base";
            }).addClass("selected");
            $(".table_1>tbody tr:even").css("background", "#fafafa");

        });



        //添加跳转
        function add(){
            window.location="<%=basePath%>user";
        }
        //编辑跳转
        function editData(loginName){
            window.location="<%=basePath%>user/"+loginName;
        }
        //删除
        function deletes(loginName){
            if(window.confirm("是否确认删除？")){
                $("#deleteForm").attr("action","<%=basePath %>user/"+loginName);
                $("#deleteForm").submit();
            }
        }

    </script>
     <style type="text/css">
    	.ctrl{
    		margin-bottom:0px;
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
		            <li class="fin">用户管理</li>
		        </ul>
		    </div>
		</div>
        <!--Filter-->
        <div class="filter">
            <div class="query">
                <div class="p8 filter_search" >
                    <form action="<%=basePath %>user/users" id="form" method="get">
                        <input type="hidden" id="pageSize" name="pageSize" value="${pageInfo.pageSize }"/>
                        <input type="hidden" id="pageIndex" name="pageIndex" value="${pageInfo.pageIndex } "/>
                    </form>

                    <form id="deleteForm" method="post">
                        <input type="hidden" name="_method" value="DELETE"/>

                    </form>
                </div>
            </div>
        </div>
        <div style="text-align: center;margin: right;">
           <!--   &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            <h5 class="fl" style="text-align: center;margin: right;"><a href="#" class="colSelect fl">
</a></h5>

            &nbsp;<input type="button" name="addButton" id="addButton" onclick="add();" value="新 增" class="fr"-->
            <!--  <input type="button" name="excelButton" id="excelButton" value="导 出当页至 EXCEL" class="fl">
               &nbsp;<input type="button" name="excelAllButton" id="excelAllButton" value="导 出全部至 EXCEL" class="fl">
             -->
        </div>
    </div>
    <!--Filter End-->
    <!--Table-->
    <!--  <s:set name="r" value="#request.pageResultSet.list"></s:set> -->
    <div class="mb10">
        <table width="100%"  class="table_1" id="mytable">
        	<thead>
			<tr>
    			<th colspan="30">&nbsp;&nbsp;用户信息列表
    			<input type="button" name="addButton" id="addButton" onclick="add();" value="新 增" class="fr"></th> 
			</tr>
			</thead>
            <tbody>
            <tr class="tit">
                <td class="t_c" width="3%">序号</td>
                <td class="t_c" width="20%">账号</td>
                <td class="t_c" width="60%" colspan="27">用户名</td>
                <td class="t_c" width="17%">操作</td>
            </tr>
            <c:forEach items="${users }" var="user" varStatus="status">
                <tr id="dataTr">
                    <td class="t_c">${(pageInfo.pageIndex-1)*pageInfo.pageSize+status.index+1 }</td>
                    <td class="t_c" style="text-align: left;">${user.loginName }</td>
                    <td class="t_c" colspan="27">${user.userName }</td>
                    <td>
                        <!-- <a class="fl mr5" href="javascript:void(0)" onclick="view('<s:property value='projectId'/>')"  >查看</a> -->
                        <a class="fl mr5" href="javascript:void(0)" onclick="editData('${user.loginName}')">修改</a>
                        <a class="fl mr5" href="javascript:void(0)" onclick="deletes('${user.loginName}')">删除</a> 
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

</body>
</html>