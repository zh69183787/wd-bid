<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8" />
<title>投标单位</title>
<link rel="stylesheet" href="<%=basePath %>css2/formalize.css"/>
<link rel="stylesheet" href="<%=basePath %>css2/page.css"/>
<link rel="stylesheet" href="<%=basePath %>css2/imgs.css"/>
<link rel="stylesheet" href="<%=basePath %>css2/reset.css"/>
        <script src="<%=basePath %>js/html5.js"></script>
        <script src="<%=basePath %>js/jquery-1.7.1.js"></script>
        
		<script src="<%=basePath %>js/jquery.formalize.js"></script>
		<link type="text/css" href="<%=basePath %>css/flick/jquery-ui-1.8.18.custom.css" rel="stylesheet" />	
		<script type="text/javascript" src="<%=basePath %>js/flick/jquery-ui-1.8.18.custom.min.js"></script>
		<script type="text/javascript" src="<%=basePath %>js/check/checkCompany.js"></script>
    <script type="text/javascript" src="<%=basePath %>js/dictionary.js"></script>
		
		<script type="text/javascript">		
         $(function(){
             $("#nav_ul > li").filter(function(index) {
                 return $(this).attr("name")=="business";
             }).addClass("selected");

             $("#tradeGroup").wrapCheckboxGroup({
                 url:"${pageContext.request.contextPath}/dictionary/trade/dictionaries?format=json",
                 selectVal:"${company.trade}",//默认选中对象
                 name:"trade"
             });

             $("#groups").wrapSelect({
                 url:"${pageContext.request.contextPath}/dictionary/groups/dictionaries?format=json",
                 selectVal:"${company.groups}",//默认选中对象
                 name:"groups"
             });
			$("#companyName").blur(function(){
				if($("#companyName").val()==''){}else{
					$.ajax({
						type: "post",
	                    url: "<%=basePath%>company/compare",
	                    dataType: "json",
	                    data: encodeURI('format=json'+"&companyName="+$("#companyName").val()+"&companyId="+$("#companyId").val()),
	                    contentType: "application/x-www-form-urlencoded; charset=UTF-8", 
	                    success: function (data) {
	                        if("no"==data.msg){
	                        	$("#com").html("<font color='red'>该单位已经存在</font>");
	                        }else{
	                        	$("#com").html("<font color='green'>该单位可以添加</font>");
	                        }
	                    }
					});
				}
			});
		});
		
		function shut(){
		  window.opener=null;
		  window.open("","_self");
		  window.close();
		}
		
		function checks(){
			if(""==$("#pageIndex").val())
				$("#pageIndex").val(1);
			
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
		            <li class="fin">投标单位</li>
		        </ul>
		    </div>
		</div>
       <form method="post" action="<%=basePath %>company/save">
       <input type="hidden" id="pageIndex" name="pageIndex" value="${pageIndex }">
       <input type="hidden" id="companyId" name="companyId" value="${company.companyId }" />
          <table width="100%"  class="table_1">
           <thead>
            <th colspan="4" class="t_r">
       	      &nbsp;</th>
                                  </thead>
                              <tbody>
                               <tr>
                                   <td class="t_r lableTd" style="width:15%;">行业：</td>
                                   <td style="width:35%;">
                                       <div id="tradeGroup"></div>

                                   </td>
                                   <td class="t_r lableTd" style="width:15%;">集团：</td>
                                   <td style="width:35%;" id="groups">
                                   </td>
                               </tr>

                               <tr>
                                   <td class="t_r lableTd" style="width:15%;">投标单位名称：</td>
                                   <td style="width:35%;" colspan="3">
                                       <input type="text" id="companyName" name="companyName" class="input_xxlarge"  value="${company.companyName }"   />
                                       <span id="com"></span>
                                   </td>
                               </tr>
                               
                              </tbody>
                              <tr class="tfoot">
                                <td colspan="4" class="t_r"><input id="save" type="submit" onclick="return checks();" value="保存"/>&nbsp;
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
