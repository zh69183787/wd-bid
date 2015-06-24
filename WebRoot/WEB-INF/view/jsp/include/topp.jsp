<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.util.*"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>
<html lang="cn">
<head>
<meta charset="utf-8" />
<title>Untitled Document</title>
<link rel="stylesheet" href="../css/formalize.css" />
<link rel="stylesheet" href="../css/reset.css" />
<link rel="stylesheet" href="../css/page.css" />
<link rel="stylesheet" href="../css/default/imgs.css" />
<!--[if IE 6.0]>
           <script src="js/iepng.js" type="text/javascript"></script>
           <script type="text/javascript">
                EvPNG.fix('div, ul, ol, img, li, input, span, a, h1, h2, h3, h4, h5, h6, p, dl, dt');
           </script>
       <![endif]-->
        <script src="../js/html5.js"></script>
        <script src="../js/jquery-1.7.1.js"></script>
        <script type="text/javascript">
function MM_swapImgRestore() { //v3.0
  var i,x,a=document.MM_sr; for(i=0;a&&i<a.length&&(x=a[i])&&x.oSrc;i++) x.src=x.oSrc;
}
function MM_preloadImages() { //v3.0
  var d=document; if(d.images){ if(!d.MM_p) d.MM_p=new Array();
    var i,j=d.MM_p.length,a=MM_preloadImages.arguments; for(i=0; i<a.length; i++)
    if (a[i].indexOf("#")!=0){ d.MM_p[j]=new Image; d.MM_p[j++].src=a[i];}}
}

function MM_findObj(n, d) { //v4.01
  var p,i,x;  if(!d) d=document; if((p=n.indexOf("?"))>0&&parent.frames.length) {
    d=parent.frames[n.substring(p+1)].document; n=n.substring(0,p);}
  if(!(x=d[n])&&d.all) x=d.all[n]; for (i=0;!x&&i<d.forms.length;i++) x=d.forms[i][n];
  for(i=0;!x&&d.layers&&i<d.layers.length;i++) x=MM_findObj(n,d.layers[i].document);
  if(!x && d.getElementById) x=d.getElementById(n); return x;
}

function MM_swapImage() { //v3.0
  var i,j=0,x,a=MM_swapImage.arguments; document.MM_sr=new Array; for(i=0;i<(a.length-2);i+=3)
   if ((x=MM_findObj(a[i]))!=null){document.MM_sr[j++]=x; if(!x.oSrc) x.oSrc=x.src; x.src=a[i+2];}
}

function mainClose(){
	 	window.opener=null;
		window.open("","_self");
		window.close();
}
   
 /*$(document).ready(function(){
 	$("#topDiv").height($(document).height());
 	$("#switch").click(function(){
 		$("#topDiv").show();
 		$(parent.window.frames["leftFrame"].document).find("#leftDiv").show();
 		$(parent.window.frames["mainFrame"].document).find("#mainDiv").show();
 		$(parent.window.frames["mainFrame"].document).find("#deptDiv").show();
 		$(parent.window.frames["leftFrame"].document).find("#leftDiv").height($(parent.window.frames["leftFrame"].document).height());
 		$(parent.window.frames["mainFrame"].document).find("#mainDiv").height($(parent.window.frames["mainFrame"].document).height());
 		
 		$.ajax({
			type: 'POST',
			url: 'switchDepts.action?random='+Math.random(),
			dataType:'json',
			cache : false,
			error:function(){alert('系统连接失败，请稍后再试！')},
			success: function(obj){			
				var str = "";
				if(obj.length==0){
					$(parent.window.frames["mainFrame"].document).find("#deptDiv .con").html("会话已超时，请重新登陆！");
				}else{
					str = '<table width="100%" border="0" cellspacing="0" cellpadding="0">';
					for(var i=0;i<obj.length;i++){
						str += '<tr>';
						str += '<td class="td_1"><input id="deptId" name="deptId" type="radio" value="'+obj[i].deptId+'"></td>';
						str += '<td>'+obj[i].deptName+'</td>';
						str += '</tr>';
					}
					str += '</table>';
					$(parent.window.frames["mainFrame"].document).find("#deptDiv .con").html(str);
				}

			}	  
		});	
 	})
 })
 */
 
 function userInfoFix(){
 	<s:if test='#session.t_user.flag!="1"'>
 		//window.open('/portal/userManage/stptUserToFix.action');
 		var r = window.showModalDialog('http://10.1.48.20/ca/userInfo/changeUserInfoById.action?type=hiddenDiv',window,"dialogWidth=800px;dialogHeight=600px");
 	</s:if>
 }

//存放cookie
function writeCookie(name, value, days) {
  var expires = "";
  if (days) {
	var date = new Date();
	date.setTime(date.getTime() + (days * 24 * 60 * 60 * 1000));
	expires = "; expires=" + date.toGMTString();
  }
  document.cookie = name + "=" + value + expires + "; path=/";
}
 $(document).ready(function(){
 	$.ajax({
			type: 'POST',
			url: 'switchDepts.action?random='+Math.random(),
			dataType:'json',
			cache : false,
			error:function(){alert('系统连接失败，请稍后再试！')},
			success: function(obj){			
				var deptOption = ""
				if(obj.length==0){
					
				}else{
					for(var i=0;i<obj.length;i++){
						if(($("#loginName").val()+","+$("#deptId").val())==obj[i].deptId){
							deptOption +="<option value='"+obj[i].deptId+"' selected>"+obj[i].deptName+"</option>";
						}else{
							deptOption +="<option value='"+obj[i].deptId+"'>"+obj[i].deptName+"</option>";
						}
					}
				}
					//$("#deptSelect").html(deptOption);
					$("#wc").after('<select id="deptSelect" name="deptSelect" style="border:none;background-color:#10579c;">'+deptOption+'</select>');
				}  
		});	
		
		$("#deptSelect").live("change",function(){
			if($("#deptSelect").val()==($("#loginName").val()+","+$("#deptId").val())){
			}else{
				if(confirm("确认切换部门吗?")){
					window.location.href = "<%=switchUrl%>&deptId="+$("#deptSelect").val();
					return false;
				}else{
					$("#deptSelect").val(($("#loginName").val()+","+$("#deptId").val()));
					return false;
				}
			}
		})
		
		$("li[id=tabs] a").click(function(){
			//alert(1);
			//$(parent.document).find("frameset[id=main]").attr("cols","0,*");
			var leftPath = $(this).attr("leftLink");
			var mainPath = $(this).attr("mainLink");
			var tar = $(this).attr("winTarget");
			if(mainPath == ""){
				mainPath = "/portal/building.html"
			}
			if(tar == "_blank"){
				window.open(mainPath);
			}else{		
				writeCookie("leftPath",leftPath,7);
				$("#leftFrame",parent.document).attr("src",leftPath);
				$("#mainFrame",parent.document).attr("src",mainPath);
				if(mainPath.indexOf("show_left=on")>=0){
					$(parent.document).find("frameset[id=main]").attr("cols","210,*");
					$(parent.frames["leftFrame"].document).find(".demo").show();
					$(parent.frames["leftFrame"].document).find("#arrow").removeClass();
					$(parent.frames["leftFrame"].document).find("#arrow").addClass("close_2");
				}else if(mainPath.indexOf("show_left=off")>=0){
					$(parent.document).find("frameset[id=main]").attr("cols","7,*");
					$(parent.frames["leftFrame"].document).find(".demo").hide();
					$(parent.frames["leftFrame"].document).find("#arrow").removeClass();
					$(parent.frames["leftFrame"].document).find("#arrow").addClass("open_2");
				}
				//$(parent.document).find("#leftFrame").attr("src",leftPath);
				//$(parent.document).find("#mainFrame").attr("src",mainPath);
				//$(parent.document).find("frameset[id=main]").attr("cols","0,*");
				$("li[id=tabs]").removeClass("selected");
				$(this).parent("li").addClass("selected");
			}
		})
		
		if($("li[id=tabs] a[code='<%=code%>']").length !=0){
			$("li[id=tabs] a[code='<%=code%>']").click();
		}else{		
			if($("li[id=tabs] a[mainLink*='xw_index']").length !=0){
				$("li[id=tabs] a[mainLink*='xw_index']").click();
			}else{
				$("li[id=tabs]:eq(0) a").click();
			}
		}
		
		$(".home").click(function(){
			if($("li[id=tabs] a[mainLink*='xw_index']").length !=0){
				$("li[id=tabs] a[mainLink*='xw_index']").click();
			}else{
				$("li[id=tabs]:eq(0) a").click();
			}
		})
		
		$(".help").click(function(){
			$(parent.document).find("#mainFrame").attr("src","http://10.1.44.18/redirect.action?result=help");
		})
		
		$(".download").click(function(){
			$(parent.document).find("#mainFrame").attr("src","http://10.1.44.18/redirect.action?result=software");
		})
		
		$(".mail").click(function(){
			$(parent.document).find("frameset[id=main]").attr("cols","0,*");
			$(parent.document).find("#mainFrame").attr("src","http://10.1.44.18/stoa/publicConn.jsp?urlPath=/gotoEmail/login.do?b_query=true");
		})
		
		userInfoFix();
		
 })
    
        </script>
</head>

<body onLoad="MM_preloadImages('<%=basePath%>css/default/images/index_1_04_open.png')"><header class="mw1002">
    	<div class="logo clearfix">
        	<!--Color-->
            <div class="color"><a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image1','','css/default/images/index_1_04_open.png',1)"><img src="../css/default/images/index_1_04_close.png" name="Image1" width="31" height="42" border="0"></a></div>
            <!--Color End-->
            <!---->
            <ul>
            	<li class="selected"><a href="javascript:void(0);" class="home" title="首页">首页</a></li>
            	<li><a href="javascript:void(0);" class="help" title="系统帮助">系统帮助</a></li>
            	<li><a href="javascript:void(0);"  class="download" title="下载中心">下载中心</a></li>
            	<li><a href="javascript:void(0);" class="mail" title="企业邮箱">企业邮箱</a></li>
            	<li><a href="http://10.1.48.20/cfconsole" target="_blank" class="sys" title="系统管理">系统管理</a></li>
            	<li><a href="/portal/logout.jsp"  target="_top" class="logout" title="退出">退出</a></li>
            </ul>
            <!---->
            <!--User-->
            <div class="user"><b><s:property value="#session.userName"/></b><span id="wc">&nbsp;&nbsp;欢迎登录&nbsp;</span></div>
            <!--User End-->
      </div>
      <!--Logo End-->
        <nav>
        	<ul>
            	<li id="tabs"><a style="cursor:pointer;" href="javascript:void(0);" code=""><span>招投标汇总表</span></a></li>
				<li id="tabs"><a style="cursor:pointer;" href="javascript:void(0);" code=""><span>招标计划</span></a></li>
				<li id="tabs"><a style="cursor:pointer;" href="javascript:void(0);" code=""><span>线路</span></a></li>
				<li id="tabs"><a style="cursor:pointer;" href="javascript:void(0);" code=""><span>标段</span></a></li>
				<li id="tabs"><a style="cursor:pointer;" href="javascript:void(0);" code=""><span>投标单位</span></a></li>
            </ul>       
           
        </nav>
    </header>
</body>
</html>
