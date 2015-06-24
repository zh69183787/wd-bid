<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="cn">
<head>
    <meta charset="utf-8"/>
    <title>投标单位信息列表</title>    
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css2/formalize.css"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css2/page.css"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css2/imgs.css"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css2/reset.css"/>
    <link type="text/css" href="${pageContext.request.contextPath}/css/flick/jquery-ui-1.8.18.custom.css" rel="stylesheet"/>

    <script src="${pageContext.request.contextPath}/js/html5.js"></script>
    <script src="${pageContext.request.contextPath}/js/jquery-1.7.1.js"></script>
    <script src="${pageContext.request.contextPath}/js/jquery.formalize.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/flick/jquery-ui-1.8.18.custom.min.js"></script>

    <script type="text/javascript" src="${pageContext.request.contextPath}/js/dictionary.js"></script>
    <script type="text/javascript">

        $(function () {
            $(".table_1>tbody tr:even").css("background", "#fafafa");
            $(":button[name=clearBtn]").click(function () {
                var $form = $(this).parents("form");
                $form.find(":text").val("");
                $form.find("select>option:eq(0)").prop("selected", true);
                $form.find("select").val("");
                $form.find("input:hidden").val("");
            });
            $("#result").dialog({
                modal: true,
                width: 600,
                height: 300,
                autoOpen: false
            });

            $("#nav_ul > li").filter(function (index) {
                return $(this).attr("name") == "business";
            }).addClass("selected");

            $("#exportBtn").click(function () {
                location.href = "${pageContext.request.contextPath}/company/export?" + $("form").serialize();
            });

            $("#trade").wrapSelect({
                url:"${pageContext.request.contextPath}/dictionary/trade/dictionaries?format=json",
                selectVal:"${bidCompany.trade}",//默认选中对象
                name:"trade"
            });

            $("#groups").wrapSelect({
                url:"${pageContext.request.contextPath}/dictionary/groups/dictionaries?format=json",
                selectVal:"${bidCompany.groups}",//默认选中对象
                name:"groups"
            });
        });


        //添加跳转
        function add() {
            //window.open("project_add.jsp");
            window.location = "${pageContext.request.contextPath}/company/form";
        }
        //编辑跳转
        function editData(companyId) {
            window.location = "${pageContext.request.contextPath}/company/companyEdit?companyId=" + companyId + "&pageIndex=" + $('#pageIndex').val();
        }
        function deletes(companyId) {
            if (window.confirm("是否确认删除？")) {
                location.href = "${pageContext.request.contextPath}/company/" + companyId+"/delete" ;
            }
        }


        function loadData(companyId, type) {
            var url = "${pageContext.request.contextPath}/result/" + companyId + "/results";
            if (type == "2") {
                url = url + "?type=2";
                $("#result").dialog("option", "title", "中标记录");
            }
            else {
                url = url + "?type=1";
                $("#result").dialog("option", "title", "投标记录");

            }
            $("#result").load(url, function () {

                $("#result").dialog("open");

            });
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
	            <li class="fin">投标单位</li>
	        </ul>
	    </div>
	</div>
        <!--Filter-->
        <div class="filter">
            <div class="query">
                <div class="p8 filter_search">
                    <form action="${pageContext.request.contextPath}/company/company_list" id="form" method="get">
                        <input type="hidden" id="pageSize" name="pageSize" value="${pageInfo.pageSize }"/>
                        <input type="hidden" id="pageIndex" name="pageIndex" value="${pageInfo.pageIndex } "/>
                        <table width="100%" border="0" cellspacing="0" cellpadding="0">
                            <tr>
                                <td class="t_r">行业:</td>
                                <td id="trade">

                                </td>
                                <td class="t_r">集团:</td>
                                <td id="groups">
                                </td>
                                <td class="t_r">投标单位名称:</td>
                                <td>
                                    <input type="text" id="companyName" name="companyName" class="input_xxlarge"
                                           value="${bidCompany.companyName }"/>
                                </td>
                            </tr>
                            <tr>
                                <td colspan="6" class="t_c"><input type="submit" value="检索" style="width:50px;"><input
                                        type="button" name="clearBtn" value="清除" style="width:50px;margin-left:8px;"></td>
                            </tr>

                        </table>
                    </form>

                    <form action="${pageContext.request.contextPath}/company/save" method="post" id="delete">
                        <input type="hidden" id="companyId" name="companyId" value=""/>
                        <input type="hidden" id="removed" name="removed" value="">
                        <input type="hidden" name="pageIndex" value="${pageInfo.pageIndex } "/>
                    </form>


                </div>
            </div>
        </div>
    </div>
    <!--Filter End-->
    <!--Table-->
    <div class="mb10">
        <table width="100%" class="table_1">
        	<thead>
			<tr>
    			<th colspan="30">&nbsp;&nbsp;投标单位信息列表
    			<input type="button" id="exportBtn" value="导出全部" style="float:right;"/><input type="button" name="addButton" id="addButton" onclick="add();" value="新 增" class="fr"></th>
			</tr>
			</thead>
            <tbody>
            <tr class="tit">
                <td class="t_c" width="3%">序号</td>
                <td class="t_c" width="20%">行业</td>
                <td class="t_c" width="20%">集团</td>
                <td class="t_c" width="40%">投标单位名称</td>

                <td class="t_c" width="17%" colspan="26">操作</td>
            </tr>
            <c:forEach items="${companies }" var="company" varStatus="status">
                <tr id="dataTr">

                    <td class="t_c">${status.index+1 }</td>
                    <td >${company.trade}</td>
                    <td lass="t_c">${company.groups}</td>
                    <td>${company.companyName}</td>

                    <td colspan="26">
                        <a class="fl mr5" href="javascript:void(0)" onclick="editData('${company.companyId}');">修改</a>
                        <a class="fl mr5" href="javascript:void(0)" onclick="deletes('${company.companyId}')">删除</a>

                        <a class="fl mr5" href="#" onclick="loadData('${company.companyId}','1');">投标记录</a>
                        <a class="fl mr5" href="#" onclick="loadData('${company.companyId}','2');">中标记录</a>
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
</div>

<div id="result">

</div>
</body>
</html>