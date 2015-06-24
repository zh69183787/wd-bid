<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html lang="cn">
<head>
    <meta charset="utf-8"/>
    <title>统计汇总表</title>
    <style>
        .tfoot span {
            display: inline;
            color: blue;
            font-weight: bold;
        }
    </style>
     <link rel="stylesheet" href="${pageContext.request.contextPath}/css2/formalize.css"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css2/page.css"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css2/imgs.css"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css2/reset.css"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/jquery-ui.css">
    <script src="${pageContext.request.contextPath}/js/html5.js"></script>
    <script src="${pageContext.request.contextPath}/js/jquery-1.7.1.js"></script>
    <link type="text/css" href="${pageContext.request.contextPath}/css/flick/jquery-ui-1.8.18.custom.css"
          rel="stylesheet"/>
    <script type="text/javascript"
            src="${pageContext.request.contextPath}/js/flick/jquery-ui-1.8.18.custom.min.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/dictionary.js"></script>


    <script type="text/javascript">
        $(function () {

            $(":button[name=clearBtn]").click(function () {
                var $form = $(this).parents("form");
                $form.find(":text").val("");
                $form.find("select>option:eq(0)").prop("selected", true);
                $form.find("select").val("");
                $form.find("input:hidden").val("");
            });

            $("#trade").wrapSelect({
                url:"${pageContext.request.contextPath}/dictionary/trade/dictionaries?format=json",
                selectVal:"${result.company.trade}",//默认选中对象
                name:"company.trade"
            });

            $("#groups").wrapSelect({
                url:"${pageContext.request.contextPath}/dictionary/groups/dictionaries?format=json",
                selectVal:"${result.company.groups}",//默认选中对象
                name:"company.groups"
            });

            $("#nav_ul > li").filter(function (index) {
                return $(this).attr("name") == "analyze";
            }).addClass("selected");
            $("#tender").click(function () {//投标汇总

                location.href = "${pageContext.request.contextPath}/result/group?type=2";
            });
            $("#winning").click(function () {//中标汇总
                location.href = "${pageContext.request.contextPath}/result/group?type=3";
            });
            $("#tw").click(function () {//投中标汇总
                location.href = "${pageContext.request.contextPath}/result/group?type=1";
            });
            $("#export").click(function () {
                var url = "${pageContext.request.contextPath}/result/exports?" + $("form").serialize();
                location.href = url;
                //$("#form").attr("action",url).submit();
            });
            $("#exports").click(function () {
                location.href = "${pageContext.request.contextPath}/result/exports?type=" + $("#type").val();
            });
        });
    </script>
    <style type="text/css">
        .table_1 tr:hover td {
            background: white;
        }

        .td {
            border: #fff solid 1px;
            text-align: right;
        }

        .td1 {
            text-align: right;
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
                    <li class="fin">统计汇总</li>
                </ul>
            </div>
        </div>
        <!--Filter-->
        <div class="filter">
            <div class="query">
                <div class="p8 filter_search">
                    <form action="${pageContext.request.contextPath}/result/group" method="get">
                        <table width="100%" border="0" cellspacing="0" cellpadding="0">
                            <tbody><tr>
                                <td class="t_r">行业:</td>
                                <td id="trade">

                                </td>
                                <td class="t_r">集团:</td>
                                <td id="groups">
                                </td>
                                <td class="t_r">单位:</td>
                                <td>
                                    <input type="text" id="companyName"
                                           name="company.companyName"
                                           value="${result.company.companyName }">
                                </td>


                            </tr>
                            <tr>
                                <td class="t_r">标段:</td>
                                <td>
                                    <input type="text" name="bidPlan.bidding.biddingName"
                                           id="biddingName"
                                           value="${result.bidPlan.bidding.biddingName}">
                                </td>
                                <td class="t_r"></td>
                                <td >
                                </td>
                                <td class="t_r"></td>
                                <td>
                                </td>
                            </tr>
                            <tr>
                                <td colspan="6" style="text-align: center"><input type="submit" value="检索" id="search" name="search"><input
                                        type="button" name="clearBtn" value="清除" style="width:50px;margin-left:8px;"></td>
                            </tr>

                            </tbody></table>
                    </form>


                </div>
            </div>
        </div>
    </div>
    <!--Filter End-->
    <div class="mb10">

        <form action="${pageContext.request.contextPath}/result/results" method="GET" id="form">
            <%-- <input type="hidden" name="biddingPlanId" value="${param['biddingPlanId']}"/> --%>
            <table width="100%" class="table_1" id="mytable">
                <thead>
                <tr>
                    <th colspan="8">&nbsp;统计汇总表
                        <input type="button" id="tender" value="投标情况汇总表" class="fr" style="margin: 5px;">
                        <input type="button" id="winning" value="中标情况汇总表" class="fr" style="margin: 5px;">
                        <input type="button" id="tw" value="统计汇总表" class="fr" style="margin: 5px;">
                        <input type="button" id="export" value="导出" class="fr" style="margin: 5px;"></th>
                </tr>
                </thead>

                <tbody>
                <tr class="tit">
                    <td class="t_c" width="12%" rowspan="2">所属集团</td>
                    <td class="t_c" width="16%" rowspan="2">单位</td>
                    <c:if test="${type!='3' }">
                        <td class="t_c" width="36%" colspan="3">投标情况</td>
                    </c:if>
                    <c:if test="${type!='2' }">
                        <td class="t_c" width="36%" colspan="3">中标情况</td>
                    </c:if>
                </tr>
                <tr>
                    <c:if test="${type!='3' }">
                        <td  width="13%">线路名称</td>
                        <td  width="13%">标段名称</td>
                        <td class="t_c" width="10%">投标金额(万元)</td>
                    </c:if>
                    <c:if test="${type!='2' }">
                        <td  width="13%">线路名称</td>
                        <td  width="13%">标段名称</td>
                        <td class="t_c" width="10%">中标金额(万元)</td>
                    </c:if>
                </tr>
                <c:forEach items="${results }" var="r" varStatus="status">

                    <c:forEach items="${r.listGroups }" var="group" varStatus="groups">

                        <c:forEach items="${group.listCompanyName }" var="company" varStatus="companys">
                            <tr>
                                <c:if test="${groups.index==0&&companys.index==0 }">
                                    <td style="text-align: center;vertical-align: top" rowspan="${r.gc+1 }">${company.company.groups }</td>
                                </c:if>
                                <c:if test="${companys.index==0 }">
                                    <td rowspan="${group.cc }">${company.company.companyName }</td>
                                </c:if>
                                <c:if test="${type!='3' }">
                                    <td>${company.bidPlan.bidding.route.routeName }</td>
                                    <td>${company.bidPlan.bidding.biddingName}</td>
                                    <td class="td1">
                                        <fmt:formatNumber value="${company.prePrice }" pattern="#,##0.0000"/></td>
                                </c:if>
                                <c:if test="${type!='2' }">
                                    <td><c:if test="${company.finalPrice>0 }">
                                        ${company.bidPlan.bidding.route.routeName }
                                    </c:if></td>
                                    <td><c:if test="${company.finalPrice>0 }">
                                        ${company.bidPlan.bidding.biddingName}
                                    </c:if></td>
                                    <td class="td1"><c:if test="${company.finalPrice>0 }">
                                        <fmt:formatNumber value="${company.finalPrice }" pattern="#,##0.0000"/>
                                    </c:if></td>
                                </c:if>
                            </tr>
                        </c:forEach>
                        <tr style="background-color: #CCCCCC;font-weight:lighter ;">
                            <td style="text-align: center "><strong>小计</strong></td>
                            <c:if test="${type!='3' }">
                                <td></td>
                                <td class="td1"><strong>${group.cl.applyNum }</strong></td>
                                <td class="td1"><strong></strong></td>
                            </c:if>
                            <c:if test="${type!='2' }">
                                <td></td>
                                <td class="td1"><strong>${group.cl.applyNums }</strong></td>
                                <td class="td1"><strong><fmt:formatNumber value="${group.cl.finalPrice }"
                                                                          pattern="#,##0.0000"/></strong></td>
                            </c:if>
                        </tr>

                    </c:forEach>

                    <tr style="background-color: #4A87C5;font-weight:bolder;">

                        <td style="text-align: center"><strong> 合计</strong></td>
                        <td></td>
                        <c:if test="${type!='3' }">
                            <td class="td1"><strong>${r.gl.applyNum }</strong></td>
                            <td class="td1"><strong></strong></td>
                        </c:if>
                        <c:if test="${type!='2' }">
                            <c:if test="${type=='1' }">
                                <td></td>
                            </c:if>
                            <td class="td1"><strong>${r.gl.applyNums }</strong></td>
                            <td class="td1"><strong><fmt:formatNumber value="${r.gl.finalPrice }"
                                                                      pattern="#,##0.0000"/></strong></td>
                        </c:if>
                    </tr>

                </c:forEach>
                <c:forEach items="${listAll }" var="listAll">
                    <tr style="background-color: #003399;font-size:12px;color:white;font-weight:bolder;">
                        <td></td>
                        <td style="text-align: center"><strong>共计</strong></td>
                        <td></td>
                        <c:if test="${type!='3' }">
                            <td class="td1"><strong>${listAll.applyNum }</strong></td>
                            <td class="td1"><strong></strong></td>
                        </c:if>
                        <c:if test="${type!='2' }">
                            <c:if test="${type=='1' }">
                                <td></td>
                            </c:if>
                            <td class="td1"><strong>${listAll.applyNums }</strong></td>
                            <td class="td1"><strong><fmt:formatNumber value="${listAll.finalPrice }"
                                                                      pattern="#,##0.0000"/></strong></td>
                        </c:if>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
    </div>


</div>
</div>
<script>
    $(function () {
        $("#biddingName").autocomplete({

            source: function (request, response) {
                $.ajax({
                    type: "get",
                    url: "${pageContext.request.contextPath}/bidding/fuzzy",
                    dataType: "json",
                    data: {
                        biddingName: request.term, format: "json"
                    },
                    success: function (data) {
                        response(data.biddings);
                    }
                });
            },
            minLength: 0,
            select: function (event, ui) {
                $("#biddingName").val(ui.item.biddingName);
                return false;
                /* log( ui.item ?
                 "Selected: " + ui.item.label :
                 "Nothing selected, input was " + this.value);  */
            },
            open: function () {
                $(this).removeClass("ui-corner-all").addClass("ui-corner-top");
            },
            close: function () {
                $(this).removeClass("ui-corner-top").addClass("ui-corner-all");
            }
        }).data("autocomplete")._renderItem = function (ul, item) {
            return $("<li>").data("item.autocomplete", item)
                    .append("<a>" + item.biddingName + "</a>")
                    .appendTo(ul);
        };
    })
</script>
</body>
</html>