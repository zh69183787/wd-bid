<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8"/>
    <title>用户信息</title>
    <link rel="stylesheet" href="<%=basePath %>css2/formalize.css"/>
    <link rel="stylesheet" href="<%=basePath %>css2/page.css"/>
    <link rel="stylesheet" href="<%=basePath %>css2/imgs.css"/>
    <link rel="stylesheet" href="<%=basePath %>css2/reset.css"/>
    <link rel="stylesheet" href="<%=basePath %>css/jquery-ui.css">
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
                return $(this).attr("name") == "base";
            }).addClass("selected");

            $("form").submit(function () {
                var flag = true;
                var roleNum = 0;
                $(":text,:password").each(function(i,n){
                    if($(n).val()==""){
                        flag = false
                        alert("所有信息都为必填项，请填写完整!");

                        return false;
                    }

                });
                if(!flag)
                return flag;

                $(":checkbox").each(function (i, n) {
                    if (!$(n).prop("checked")) {
                        $(n).prop("disabled", true);
                    }else{
                        roleNum++;
                    }
                })

                if( roleNum == 0){
                    $(":checkbox").prop("disabled", false);
                    alert("请至少选择一个角色!");
                    return false;
                }



            })

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
        <form method="post"
              action="<%=basePath %>user/<c:if test="${userInfo.userId != null}">${userInfo.loginName}</c:if>">
            <c:if test="${userInfo.userId != null}">
                <input type="hidden" name="userId" value="${userInfo.userId}"/>
                <input type="hidden" name="_method" value="PUT"/>
            </c:if>
            <input type="hidden" name="role"/>

            <table width="100%" class="table_1">
                <thead>
                <th colspan="4" class="t_r">&nbsp;</th>
                </thead>
                <tbody>
                <tr>
                    <td class="t_r lableTd" style="width:15%;">帐号：</td>
                    <td style="width:35%;" <c:if test="${userInfo.userId != null}">colspan="3" </c:if>>
                        <c:if test="${userInfo.userId != null}">${userInfo.loginName}</c:if>
                        <c:if test="${userInfo.userId == null}">
                            <input type="text" name="loginName" class="input_xxlarge" value="${userInfo.loginName}"/>
                        </c:if>

                        <c:if test="${param.errorCode == '1'}">
                            <span style="color:red;">帐号已被使用,请换个帐号!</span>
                        </c:if>
                    </td>
                    <c:if test="${userInfo.userId == null}">
                    <td class="t_r lableTd" style="width:15%;">密码：</td>
                    <td style="width:35%;">
                        <input type="password" name="password" value="${userInfo.password}"/>

                    </td>
                    </c:if>


                </tr>
                <tr>
                    <td class="t_r lableTd" style="width:15%;">用户名：</td>
                    <td style="width:35%;">
                        <input type="text" name="userName" class="input_xxlarge" value="${userInfo.userName}"/>
                        <span id="com"></span>
                    </td>
                    <td class="t_r lableTd" style="width:15%;">角色</td>
                    <td style="width:35%;">
                        <c:forEach items="${roles }" var="role" varStatus="status">
                            <p>
                            <input type="checkbox" name="roles[${status.index}].roleName" <c:forEach items="${hasRoles }" var="r"
                                                                              varStatus="s2"><c:if
                                    test="${role.roleName == r.roleName}"> checked="checked"</c:if></c:forEach>
                                   value="${role.roleName}"/>${role.description}
                                <c:if test="${role.roleName=='ROLE_ADMIN'}"><span style="display: inline;font-weight: bold;">拥有所有操作权限</span></c:if>
                                <c:if test="${role.roleName=='ROLE_EDITOR'}"><span style="display: inline;font-weight: bold;">编辑或查看自己维护的线路、标段、招标计划</span></c:if>
                                <c:if test="${role.roleName=='ROLE_OBSERVER'}"><span style="display: inline;font-weight: bold;">对所有数据都拥护查看权限</span></c:if>
                            </p>

                        </c:forEach>
                    </td>
                </tr>
                </tbody>
                <tr class="tfoot">
                    <td colspan="4" class="t_r">
                        <input id="save" type="submit" value="保存"/>&nbsp;
                        <input type="button" value="后退" onclick="location.href='<%=request.getHeader("referer")%>'"/>&nbsp;
                        <input type="reset" value="重 置"/>&nbsp;</td>
                </tr>
            </table>
        </form>
    </div>
    <!--Table End-->
</div>
</body>
</html>
