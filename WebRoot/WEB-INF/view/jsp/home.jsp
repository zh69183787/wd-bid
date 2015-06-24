<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <title> 招标计划管理 </title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/style.css" title="style_blue"
          media="screen"/>

    <!--[if IE]>
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/excanvas.js"></script><![endif]-->
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-1.7.1.js"></script>
</head>
<body>
<div id="wrapper">
    <%--<ul id="topbar">--%>
    <%--<li><a class="button white fl" title="preview" href="home.ftl"><span class="icon_single preview"></span></a>--%>
    <%--</li>--%>
    <%--<li class="s_1"></li>--%>
    <%--<li class="logo"><strong>招标计划管理</strong></li>--%>
    <%--</ul>--%>
    <div id="content-login">
        <!--<div class="logo"></div>-->
        <h2 class="header-login">登录窗口</h2>

        <form id="box-login" action="${pageContext.request.contextPath}/authentication" method="post">
            <p>
                <label class="req"> 用户名 </label>
                <br/>
                <input type="text" name="username" id="username"/>
            </p>

            <p>
                <label class="req"> 密码 </label>
                <br/>
                <input type="password" name="password" id="password"/>
            </p>

            <p class="fr">
                <input type="submit" value="登 录" class="button themed" id="login"/>
            </p>

            <div class="clear"></div>
        </form>
        <c:if test="${not empty errorDetails}">
            <span class="message error">错误提示 <strong>${errorDetails}</strong> </span>
        </c:if>
    </div>

</div>
<script>
    $(function () {

    })
</script>
</body>
</html>
