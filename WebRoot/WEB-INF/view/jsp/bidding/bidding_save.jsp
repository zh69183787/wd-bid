<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8"/>
    <title>招标计划标段
    </title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css2/formalize.css"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css2/page.css"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css2/imgs.css"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css2/reset.css"/>
    <link type="text/css" href="${pageContext.request.contextPath}/css/flick/jquery-ui-1.8.18.custom.css" rel="stylesheet"/>

    <script src="${pageContext.request.contextPath}/js/jquery-1.7.1.js"></script>
    <script type="text/javascript"
            src="${pageContext.request.contextPath}/js/flick/jquery-ui-1.8.18.custom.min.js"></script>
    <script src="${pageContext.request.contextPath}/js/html5.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/check/checkBidding.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/flick/jquery.ui.datepicker-zh-CN.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/dictionary.js"></script>

    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/tree/style.css" type="text/css">
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/tree/jquery.tree.core.min.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/data/bidding_type_tree.js"></script>


    <style>
        .ztree li span.button.add {
            margin-left: 2px;
            margin-right: -1px;
            background-position: -144px 0;
            vertical-align: top;
            *vertical-align: middle
        }

        .ztree span {
            display: inline;
        }
        .ui-menu {
            width: 250px;
        }

        .ui-datepicker-title span {
            display: inline;
        }

        button.ui-datepicker-current {
            display: none;
        }
    </style>

    <script type="text/javascript">
        $(function () {
            $.fn.zTree.init($("#biddingTypeTree"), {}, biddingTypeData);
            $("span[name=biddingTypeDescription]").each(function (i, o) {
                var txt = $(o).text().split("-");
                var v = txt[0];
                if (v.length > 1) {
                    $(o).parent().text(getSelectedNodeName(v));
                }else{
                    $(o).parent().text("其他-" + txt[1]);
                }
            });
            $("#selBiddingTypeBtn").click(function () {
                $("#biddingTypeTreeDiv").dialog({
                    resizable: true,
                    height: 550,
                    width: 400,
                    modal: true,
                    open: function () {

                    },
                    title: '标段类型',
                    buttons: {
                        '确定': function () {
                            var nodes = getSelectedNodes();
                            $.each(nodes, function (i, n) {
                                $(":hidden[name=biddingTypeId],#biddingTypeId").val(n.id);
                                $(":text[name=biddingType],#biddingType").val(n.name);
                                if(n.id == 5){
                                    $("#biddingType,:text[name=biddingType]").prop("readonly",false);
                                }else{
                                    $("#biddingType,:text[name=biddingType]").prop("readonly",true);

                                }
                            });

                            $(this).dialog('close');
                        },
                        '取消': function () {
                            $(this).dialog('close');
                        }
                    }
                });
            });
        });
        function getSelectedNodes() {
            return   $.fn.zTree.getZTreeObj("biddingTypeTree").getSelectedNodes();
        }
        function getSelectedNodeName(nodeId) {
            var names = [];
            for (var i = 0; i < nodeId.length - 1; i++) {
                var c = nodeId.substring(0, (i + 1));
                getNode(c, biddingTypeData, names);
            }
            return names.join("-");

        }

        function getNode(nodeId, nodeList, names) {
            $.each(nodeList,function(i,node){
                if (node.id == nodeId) {
                    names.push(node.name);
                } else {
                    if(node.children)
                        getNode(nodeId, node.children, names);
                }
            });
        }

        $(function () {

           $("#changeDiv").load("${pageContext.request.contextPath}/bidding/change/changings?bidding.biddingId="+$("#biddingId").val()+"&async=true&containerId=changeDiv");



            $('#createTime,#appraiseDate,#fileEndDate,#completeDate').datepicker({
                "changeYear": true
            });

            $("#navDiv").load("${pageContext.request.contextPath}/navigation", function () {
                $("#nav_ul > li").filter(function (index) {
                    return $(this).attr("name") == "bidding";
                }).addClass("selected");
            })

            $("#routeDiv").wrapSelect({
                url: "${pageContext.request.contextPath}/route/routes?sortByRouteName=1&format=json&pageSize=100",
                label: "routeName",
                value: "routeId",
                root:"routes",
                selectVal: "${bidding.routeId}",
                name: "routeId"
            });


            $("#biddingNo").blur(function () {

                if ($("#biddingNo").val() != '' && $("select[name=routeId]").val() != '') {

                    var flag = false;
                    var routeId = $("select[name=routeId]").val();
//                    var biddingName = $("#biddingName").val();
                    $.ajax({
                        type: "post",
                        url: "${pageContext.request.contextPath}/bidding/compare",
                        dataType: "json",
                        data: encodeURI('format=json' +  "&routeId=" + routeId + "&biddingId=" + $("#biddingId").val()+ "&biddingNo=" + $("#biddingNo").val()),
                        contentType: "application/x-www-form-urlencoded; charset=UTF-8",
                        success: function (data) {
                            $("#vBiddingNo").html("");
//                            if ("biddingNameNot" == data.msg) {
//                                $("#vBiddingName").html("<font color='red'>该路线下" + $("#biddingName").val() + "的标段已经存在</font>");
//                            }

                            if ("biddingNoNot" == data.msg) {
                                $("#vBiddingNo").html("<font color='red'>该路线下" + $("#biddingName").val() + "的编号已经存在</font>");
                            }
                        }
                    });
                }
            });

            if ("" == $("#biddingId").val()) {
                $("#biddingNo").val("");
            }
        });

        function checks() {
            if($("#biddingNo").val()==""){
                alert("请输入标段编码");
                return false;
            }
            if($("select[name=routeId]").val()==""){
                alert("请选择线路");
                return false;
            }
            if($("#biddingName").val()==""){
                alert("请输入标段名称");
                return false;
            }

            if ("" == $(":hidden[name=pageIndex]").val())
                $(":hidden[name=pageIndex]").val(1);
            return check();
        }

    </script>
</head>

<body>
<div class="main">
    <!--Ctrl-->
    <div id="navDiv" class="ctrl clearfix">

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
		            <li class="fin">招标计划管理</li>
		        </ul>
		    </div>
		</div>
        <form method="post" action="${pageContext.request.contextPath}/bidding/save">
            <input type="hidden" name="pageIndex" value="${pageIndex }">
            <input type="hidden" id="biddingId" name="biddingId" value="${bidding.biddingId }"/>
            <table width="100%" class="table_1">
                <thead>
                <th colspan="4" class="t_r">
                    &nbsp;</th>
                </thead>
                <tbody>
                <tr>
                    <td class="t_r lableTd" style="width:10%;">标段编码：</td>
                    <td style="width:30%;">
                        <input type="text" id="biddingNo" name="biddingNo" class="input_xxlarge"
                               value="${bidding.biddingNo }"/>
                          <span id="vBiddingNo" ><c:if test="${msg == 'biddingNoNot'}"><font
                                  color="red">该路线下${bidding.biddingNo }的编号已经存在</font></c:if></span>
                    </td>
                    <td class="t_r lableTd" style="width:15%;">招标方式：</td>
                    <td style="width:45%;">
                        <select name="bidType" style="width:300px;" value="${bidding.bidType }">
                            <option value="">请选择</option>
                            <option value="1" <c:if test="${bidding.bidType!='2'}">selected</c:if>>单线招标</option>
                            <option value="2" <c:if test="${bidding.bidType=='2'}">selected</c:if>>集中招标</option>
                        </select>
                    </td>
                </tr>
                <tr>
                    <td class="t_r lableTd" style="width:10%;">线路名称：</td>
                    <td style="width:30%;">
                        <div id="routeDiv">

                        </div>
                    </td>
                    <td class="t_r lableTd" style="width:15%;">标段名称：</td>
                    <td style="width:45%;">
                        <input type="text" id="biddingName" name="biddingName" class="input_xxlarge"
                               value="${bidding.biddingName }"/>
                        <%--<span id="vBiddingName"><c:if test="${msg == 'biddingNameNot'}"><font--%>
                                <%--color="red">该路线下${bidding.biddingName }的标段已经存在</font></c:if></span>--%>
                    </td>
                </tr>

                <tr>
                    <td class="t_r lableTd" style="width:10%;">招标文件完成日期：</td>
                    <td style="width:30%;">
                        <input type="text" id="fileEndDate" name="fileEndDate" class="input_xxlarge" value="<fmt:formatDate value="${bidding.fileEndDate }" pattern="yyyy-MM-dd"/>"/>
                    </td>
                    <td class="t_r lableTd" style="width:15%;">评标日期：</td>
                    <td style="width:45%;">
                        <input type="text" id="appraiseDate" name="appraiseDate" class="input_xxlarge"
                               value="<fmt:formatDate value="${bidding.appraiseDate }" pattern="yyyy-MM-dd"/>"/>
                    </td>
                </tr>
                <tr>
                    <td class="t_r lableTd" style="width:10%;">完成日期：</td>
                    <td style="width:30%;">
                        <input type="text" id="completeDate"  name="completeDate" class="input_xxlarge" value="<fmt:formatDate value="${bidding.completeDate }" pattern="yyyy-MM-dd"/>"/>
                    </td>
                    <td class="t_r lableTd" style="width:15%;">是否完成：</td>
                    <td style="width:45%;">
                        <select name="isCompleted">
                            <option value="">请选择</option>
                            <option value="1" <c:if test="${bidding.isCompleted=='1'}">selected</c:if>>是</option>
                            <option value="2" <c:if test="${bidding.isCompleted=='2'}">selected</c:if>>否</option>
                        </select>
                    </td>
                </tr>
                <tr>

                    <td class="t_r lableTd" style="width:10%;">计划创建时间：</td>
                    <td style="width:30%;">
                        <input type="text" id="createTime" name="createTime" class="input_xxlarge"
                               value="<fmt:formatDate value="${bidding.createTime }" pattern="yyyy-MM-dd"/>"/>
                    </td>
                    <td class="t_r lableTd" style="width:15%;">标段类型
                    </td>
                    <td style="width:45%;">

                        <input type="hidden" id="biddingTypeId" name="biddingTypeId" value="${bidding.biddingTypeId }"/>
                        <input type="text" id="biddingType" readonly="readonly" name="biddingType" class="input_xxlarge"
                               value="${bidding.biddingType }"/> <input style="margin-left: 5px;" type="button"
                                                                        id="selBiddingTypeBtn" value="请选择标段类型"/>
                    </td>
                </tr>
                </tbody>
                <tr class="tfoot">
                    <td colspan="4" class="t_r"><input id="save" type="submit" onclick="return checks();" value="保存"/>&nbsp;
                        <input type="button" value="后退"
                               onclick="location.href='${pageContext.request.contextPath}/bidding/biddings'"/>&nbsp;
                        <input type="reset" value="重 置"/>&nbsp;</td>
                </tr>
            </table>
        </form>
    </div>
    <!--Table End-->
    <c:if test="${bidding.biddingId!=null && bidding.biddingId != ''}">
    <iframe height="600"  frameborder="0" border="0" marginwidth="0" marginheight="0" scrolling="no"  width="100%" src="${pageContext.request.contextPath}/bidding/change/changings?bidding.biddingId=${bidding.biddingId}&hideHeader=1"></iframe>
    </c:if>
    <%--<div id="changeDiv">--%>

    <%--</div>--%>
</div>
<div id="biddingTypeTreeDiv" style="display: none;">
    <ul id="biddingTypeTree" class="ztree" style="background-color:white;"></ul>
</div>
</body>
</html>
