<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt" %>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8" />
<title>招标计划线路
</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css2/formalize.css"/>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css2/page.css"/>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css2/imgs.css"/>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css2/reset.css"/>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/jquery-ui.css">
<!--[if IE 6.0]>
           <script src="js/iepng.js" type="text/javascript"></script>
           <script type="text/javascript">
                EvPNG.fix('div, ul, ol, img, li, input, span, a, h1, h2, h3, h4, h5, h6, p, dl, dt');
           </script>
       <![endif]-->
        <script src="${pageContext.request.contextPath}/js/html5.js"></script>
        <script src="${pageContext.request.contextPath}/js/jquery-1.7.1.js"></script>

		<script src="${pageContext.request.contextPath}/js/jquery.formalize.js"></script>
		<script src="${pageContext.request.contextPath}/js/show.js"></script>
		<script src="../../../js/loading.js"></script>
		<link type="text/css" href="${pageContext.request.contextPath}/css/flick/jquery-ui-1.8.18.custom.css" rel="stylesheet" />
		<script type="text/javascript" src="${pageContext.request.contextPath}/js/flick/jquery-ui-1.8.18.custom.min.js"></script>
		<script type="text/javascript" src="${pageContext.request.contextPath}/js/check/checkout.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/dictionary.js"></script>

		<script type="text/javascript">
         $(function(){
             $("#nav_ul > li").filter(function(index) {
                 return $(this).attr("name")=="business";
             }).addClass("selected");


             $("#companyDiv").wrapSelect({
                 url:"${pageContext.request.contextPath}/dictionary/company/dictionaries?format=json&parentNo=1000000",
                 label:"dictName",
                 value:"dictId",
                 selectVal:"${route.company}",
                 name:"company"
             });
             $("#companyDiv").bind("completed",function(){
                 $("select[name=company]").css("width","");
                         $("select[name=company]").addClass("input_xxlarge");
             });

             $("select[name=creator]").find("option[value=${route.creator}]").prop("selected",true);

			$("#routeName").blur(function(){
				if($("#routeName").val()==''){}else{
				$.ajax({
					type: "get",
                    url: "${pageContext.request.contextPath}/route/compare",
                    dataType: "json",
                    data: encodeURI('format=json'+"&routeName="+$("#routeName").val()+"&routeId="+$("#routeId").val()),
                    contentType: "application/x-www-form-urlencoded; charset=UTF-8",
                    success: function (data) {
                        if("no"==data.msg){
                        	$("#com").html("<font color='red'>该路线名称已经存在</font>");
                        }else{
                        	$("#com").html("<font color='green'>该路线名称可以保存</font>");
                        }
                    }
				});
				}
			});


		});

		function checks(){
			return check();
		}

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
        <!--Filter--><!--Filter End-->
        <!--Table-->

        <div class="mb10 pt45">
        <div class="ctrl clearfix nwarp" style="margin-top: 48px;">
		    <div class="fl"><img src="../images/sideBar_arrow_left.jpg" width="46" height="30" alt="收起"></div>
		    <div class="posi fl">
		        <ul>
		            <li><a href="#">首页</a></li>
		            <li class="fin">线路</li>
		        </ul>
		    </div>
		</div>
       <form method="post" action="${pageContext.request.contextPath}/route/${route.routeId}">
       <input type="hidden" id="pageIndex" name="pageIndex" value="${pageIndex }"   >
       <input  type="hidden" id="routeId" name="routeId" value="${route.routeId}" />
          <table width="100%"  class="table_1">
           <thead>
            <th colspan="4" class="t_r">&nbsp;</th>
                                  </thead>
                              <tbody>
                               <tr>
                                <td class="t_r lableTd" style="width:15%;">线路名称：</td>
                                <td style="width:35%;">
                                <input type="text" id="routeName" name="routeName" class="input_xxlarge" value="${route.routeName}"/>
                                    <span id="com"> <c:if test="${param.msg == 'no'}"><font color="red">该路线名称已经存在</font></c:if></span>
                                </td>
                                <td class="t_r lableTd" style="width:15%;">线路范围：</td>
                                <td style="width:35%;">
                                    <input type="text" id="routeType" name="routeType" class="input_xxlarge" value="${route.routeType}"/>
                                </td>
                                </tr>
                               <sec:authorize access="hasRole('ROLE_ADMIN')">  <tr>
                                   <td class="t_r lableTd" style="width:15%;">管理员：</td>
                                   <td style="width:35%;">
                                       <select name="creator" value="${route.creator}" style="width:60%;">
                                           <option value="">选择线路管理员</option>
<c:forEach items="${users }" var="user" varStatus="status">
    <option value="${user.userId}">${user.userName}</option>
    </c:forEach>
                                       </select>
                                   </td>
                                   <td class="t_r lableTd" style="width:15%;">项目公司：</td>
                                   <td style="width:35%;">
                                       <div id="companyDiv">

                                       </div>
                                   </td>
                               </tr></sec:authorize>
                              </tbody>
                              <tr class="tfoot">
                                <td colspan="4" class="t_r">
                                <input id="save" type="submit" onclick="return checks();"  value="保存"/>&nbsp;
                                <input type="button" value="后退" onclick="history.go(-1);"/>&nbsp;
                                <input type="reset" value="重 置" />&nbsp;</td>
                              </tr>
                            </table>
             </form>
      </div>
        <!--Table End-->
</div>
</body>
</html>
