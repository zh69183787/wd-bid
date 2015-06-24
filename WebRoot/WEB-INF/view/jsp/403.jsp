<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<html xmlns="http://www.w3.org/1999/xhtml" >
<title>403</title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
    <link rel="stylesheet" href="<%=basePath %>css/error.css">


    <body>
        <div class="widget-content">
            <div class="error_ex">
                <h1>403</h1>
                <h3>对不起, 你没有访问该页面的权限,请与管理员进行联系.</h3>
                <a class="btn btn-warning btn-big" href="<%=request.getHeader("referer")%>">返回</a> </div>
        </div>
    </body>
</html>