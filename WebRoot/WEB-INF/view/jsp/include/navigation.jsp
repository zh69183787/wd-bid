<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<script>
    function logout() {

        $.ajax({
            url: '<%=basePath %>logout',
            type: 'post',
            success: function(){
                <c:if test="${sessionScope.loginName!=null}">
                location.href = 'http://10.1.48.30/portal/logout.jsp';
                </c:if>
                <c:if test="${sessionScope.loginName==null}">
                location.href = '<%=basePath %>dashboard';
                </c:if>
            }
        });


    }
    function updatePassword() {
        location.href = '<%=basePath %>user/${currentUser.loginName}/password';
    }
</script>
<script type="text/javascript">
    $(function(){
        slidemenu(".drop-menu-effect");
    });
    function slidemenu(_this){
        $(_this).each(function(){
            var $this = $(this);
            var theMenu = $this.find(".submenu");
            var tarHeight = theMenu.height();
            theMenu.css({height:0});
            $this.css("z-index",2000);
            $this.hover(
                    function(){
                        $(this).addClass("hover_menu");
                        theMenu.stop().show().animate({height:tarHeight},0);
                    },
                    function(){
                        $(this).removeClass("hover_menu");
                        theMenu.stop().animate({height:0},0,function(){
                            $(this).css({display:"none"});
                        });
                    }
            );
        });
    }
</script>
<style>
    header, .header {
        height: 77px;
        -moz-border-radius-topleft: 5px;
        /* -webkit-border-top-left-radius: 5px; */
        -moz-border-radius-topright: 5px;
        -webkit-border-top-right-radius: 5px;
    }
    header .logo ul, header .logo_hr ul {
        padding-top: 1px;
        margin-left: 15px;
    }
    header .logo div, header .logo ul, header .logo_hr div, header .logo_hr ul {
        float: right;
    }
    #nav_ul li > a{
        width: 118px;
    }
    #nav_ul li a{
        text-align: center;
    }
    .submenu{
        display: none;
        width: 130px;
        position: relative;
        left: -6px;
        /*border: solid 1px black;*/
        background-color: #ccc;
    }
    .submenu a span{
        background-image: none;
    }
    .submenu a:hover {
        font: 15px blue;
    }
</style>
<header class="mw1002">
    <div class="logo clearfix">
        <!--Color-->
        <div class="color"><a href="#"  name="Image1" width="31" height="42" border="0"></a></div>
        <!--Color End-->
        <!---->
        <ul>
            <%--<li class="selected"><a href="javascript:void(0);" class="home" title="首页">首页</a></li>--%>
            <%--<li><a href="javascript:void(0);" class="help" title="系统帮助">系统帮助</a></li>--%>
            <%--<li><a href="javascript:void(0);" class="download" title="下载中心">下载中心</a></li>--%>
            <%--<li><a href="javascript:void(0);" class="mail" title="企业邮箱">企业邮箱</a></li>--%>
            <%--<li><a href="http://10.1.48.20/cfconsole" target="_blank" class="sys" title="系统管理">系统管理</a></li>--%>
            <li><a href="#" onclick="logout();"  class="logout" title="退出">退出</a></li>
        </ul>
        <!---->
        <!--User-->
        <div class="user"><b><a style="display:inline;color:white;"
                                href="<%=basePath %>user/${currentUser.loginName}">${currentUser.userName}</a></b><span id="wc">&nbsp;&nbsp;欢迎登录&nbsp;</span></div>
        <!--User End-->
    </div>
    <nav>
        <ul id="nav_ul">
            <li name="home"><a style="cursor:pointer;" href="<%=basePath%>dashboard"><span>首页</span></a></li>
            <li><a style="cursor:pointer;" href="<%=basePath%>report"  target="_blank"><span >招投标汇总表</span></a></li>
            <li name="plan"><a style="cursor:pointer;" href="<%=basePath%>report/plan?createTimeBegin=2015-01-01"><span >招标计划汇总表</span></a></li>
            <sec:authorize access="hasRole('ROLE_EDITOR')">
                <li name="business" class="drop-menu-effect">
                    <a style="cursor:pointer;" href="#" ><span>业务填报</span></a>
                    <div class="submenu">
                        <a style="cursor:pointer;background-image: none;" href="<%=basePath%>route/routes" ><span style="background-image: none;">线路</span></a>
                        <a style="cursor:pointer;background-image: none;" href="<%=basePath%>bidding/biddings" ><span style="background-image: none;">招标计划管理</span></a>
                        <a style="cursor:pointer;background-image: none;" href="<%=basePath%>bidimportmain/bidImportMains" ><span style="background-image: none;">招标计划导入</span></a>
                        <a style="cursor:pointer;background-image: none;" href="<%=basePath%>plan/plans" ><span style="background-image: none;">执行计划管理</span></a>
                        <a style="cursor:pointer;background-image: none;" href="<%=basePath%>company/company_list" ><span style="background-image: none;">投标单位</span></a>
                    </div>
                </li>
            <li name="analyze" class="drop-menu-effect">
                <a style="cursor:pointer;" href="#"><span>统计分析</span></a>
                <div class="submenu">

                    <a style="cursor:pointer;background-image: none;" href="<%=basePath%>report/route"><span style="background-image: none;">中标情况统计表</span></a>
                    <a style="cursor:pointer;background-image: none;" href="<%=basePath%>report/ratio"><span style="background-image: none;">中标率统计表</span></a>
                    <a style="cursor:pointer;background-image: none;" href="<%=basePath%>result/group?type=1"><span style="background-image: none;">统计汇总表</span></a>
                    <a style="cursor:pointer;background-image: none;" href="<%=basePath%>plan/distribution"><span style="background-image: none;">招标结果分布表</span></a>

                </div>
                <div style="clear:both; height:0px; overflow:hidden;"></div>
            </li>
            </sec:authorize>
            <sec:authorize access="hasRole('ROLE_ADMIN')">
                <li name="base" class="drop-menu-effect">
                    <a style="cursor:pointer;" href="#" ><span>基础数据</span></a>
                    <div class="submenu">
                        <a style="cursor:pointer;background-image: none;" href="<%=basePath%>user/users" ><span style="background-image: none;">用户管理</span></a>
                        <a style="cursor:pointer;background-image: none;" href="<%=basePath%>dictionary/index" ><span style="background-image: none;">数据字典</span></a>
                    </div>
                </li>
            </sec:authorize>
        </ul>
        <%--<div style="float: right;margin-right: 5px;color:white;">欢迎,<a style="display:inline;color:white;"--%>
        <%--href="<%=basePath %>user/${currentUser.loginName}">${currentUser.userName}</a>--%>
        <%--<input type="button" value="修改密码" onclick="updatePassword();">&nbsp;<input type="button" value="退出"--%>
        <%--onclick="logout();"></div>--%>
    </nav>
</header>
