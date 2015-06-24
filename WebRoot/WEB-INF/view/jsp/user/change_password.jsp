<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8"/>
    <title>用户信息</title>
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
    <script src="<%=basePath %>js/html5.js"></script>
    <script src="<%=basePath %>js/jquery-1.7.1.js"></script>

    <script src="<%=basePath %>js/jquery.formalize.js"></script>
    <!--<script src="<%=basePath %>project/sysinfo/js/jquery.form.js"></script>
		<script src="../js/switchDept.js"></script>-->
    <script src="<%=basePath %>js/show.js"></script>
    <script src="../../../js/loading.js"></script>
    <link type="text/css" href="<%=basePath %>css/flick/jquery-ui-1.8.18.custom.css" rel="stylesheet"/>
    <script type="text/javascript" src="<%=basePath %>js/flick/jquery-ui-1.8.18.custom.min.js"></script>

    <script type="text/javascript">
        $(function () {


            $("#nav_ul > li").filter(function (index) {
                return $(this).attr("name") == "user";
            }).addClass("selected");

            $("form").submit(function () {
                if($(":password[value='']").length != 0){
                    alert("所有信息都为必填项，请填写完整!");
                    return false;
                }
                if($(":password[name=rePassword]").val() != $(":password[name=newPassword]").val()){
                    alert("两次输入的密码不一致请重新输入!");
                    $(":password[name=rePassword],:password[name=newPassword]").val("");
                    $(":password[name=newPassword]").focus();
                    return false;
                }



            });

        });


    </script>
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
	            <li class="fin">用户信息</li>
	        </ul>
	    </div>
	</div>

        <form method="post"
              action="<%=basePath %>user/${currentUser.loginName}/password">
                <input type="hidden" name="_method" value="PUT"/>

            <table width="100%" class="table_1">
                <thead>
                <th colspan="4" class="t_r">&nbsp;</th>
                </thead>
                <tbody>
                <tr>
                    <td class="t_r lableTd" style="width:15%;">旧密码：</td>
                    <td style="width:35%;" colspan="3">
                        <input type="password" name="oldPassword" class="input_xxlarge" value=""/>
                        <c:if test="${msg != null}">
                            <span style="color:red;">${msg}</span>
                        </c:if>
                    </td>
                </tr>
                <tr>
                    <td class="t_r lableTd" style="width:15%;">新密码：</td>
                    <td style="width:35%;" colspan="3">
                        <input type="password" name="newPassword" class="input_xxlarge" value=""/>
                    </td>
                </tr>
                <tr>
                    <td class="t_r lableTd" style="width:15%;">确认密码：</td>
                    <td style="width:35%;" colspan="3">
                        <input type="password" name="rePassword" class="input_xxlarge" value=""/>
                    </td>
                </tr>

                </tbody>
                <tr class="tfoot">
                    <td colspan="4" class="t_r">
                        <input id="save" type="submit" value="保存"/>&nbsp;
                        <input type="button" value="后 退" onclick="location.href='<%=request.getHeader("referer")%>'"/>&nbsp;
                        <input type="reset" value="重 置"/>&nbsp;</td>
                </tr>
            </table>
        </form>
    </div>
    <!--Table End-->
</div>
</body>
</html>
