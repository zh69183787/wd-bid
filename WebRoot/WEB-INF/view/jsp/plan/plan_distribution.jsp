<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<!DOCTYPE html>
<html lang="cn">
<head>
<meta charset="utf-8"/>
<title>招标结果分布表</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css2/formalize.css"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css2/page.css"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css2/imgs.css"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css2/reset.css"/>
    <link type="text/css" href="${pageContext.request.contextPath}/css/flick/jquery-ui-1.8.18.custom.css" rel="stylesheet"/>

    <script src="${pageContext.request.contextPath}/js/jquery-1.7.1.js"></script>
    <script type="text/javascript"
            src="${pageContext.request.contextPath}/js/flick/jquery-ui-1.8.18.custom.min.js"></script>
    <script src="${pageContext.request.contextPath}/js/html5.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/flick/jquery.ui.datepicker-zh-CN.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/dictionary.js"></script>

<style type="text/css">
    .ui-datepicker-title span {
        display: inline;
    }

    button.ui-datepicker-current {
        display: none;
    }
</style>
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
        $("#nav_ul > li").filter(function (index) {
            return $(this).attr("name") == "business";
        }).addClass("selected");
        $('#beginOpenDate,#endOpenDate').datepicker({
            "changeYear": true
        });
        butSearch();
    });
    
    
    
    function getDistributionData(bData,eData,dictids){
    	$.ajax({
            type: "GET",
            url: "${pageContext.request.contextPath}/plan/distributionData",
            dataType: "json",
            data: 'format=json&pageSize=100000&dictids='+dictids+'&beginOpenDate='+bData+'&endOpenDate='+eData+'&t='+new Date().getTime(),
            success: function (data) {
              // alert($("#dictids").val().split(",").length);
               var ids = ($("#dictids").val().split(",").length+1)*2+1;
              // alert(ids);
              var html ="";
              	$.each(data.distributions, function (i, value) {
              		html +="<tr>";
              		for(var k=0;k<ids-2;k++){
              			//alert(value[k]);  
              			html +="<td>"+value[k]+"</td>";
              		}
              		html +="<td style='background-color:#d9def2;'>"+value[ids-2]+"</td>";
              		html +="<td style='background-color:#d9def2;'>"+value[ids-1]+"</td>";
              		html +="</tr>";
              		
                      
                }); 
              	html +="<tr style='background-color:#d9def2;'>";
          		for(var k=0;k<ids-2;k++){
          			html +="<td>"+data.last[k]+"</td>";
          		}
          		html +="<td style='background-color:#a9aef2;'>"+data.last[ids-2]+"</td>";
          		html +="<td style='background-color:#a9aef2;'>"+data.last[ids-1]+"</td>";
          		html +="</tr>";
				$("#ajaxTbody").html(html);
              
				$('#loading').dialog('close');
            }
        });
    }
    
    function butSearch(){
    	$('#loading').dialog('open');
    	getDistributionData($("#beginOpenDate").val(),$("#endOpenDate").val(),$("#dictids").val());
    }

</script>
<style type="text/css">
    .ctrl {
        margin-bottom: 0px;
    }

    .filter .query {
        border-bottom: 0px;
    }
    .tit .t_c{border-right: 1px solid #d0d0d3;}
    #ajaxTbody td{text-align: center;}
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
                    <li class="fin">招标结果分布表</li>
                </ul>
            </div>
        </div>
        <!--Filter-->
        <div class="filter">
            <div class="query">
                <div class="p8 filter_search">
                    <form action="${pageContext.request.contextPath}/plan/distribution" id="form" method="get">
                        <input type="hidden" id="pageSize" name="pageSize" value="${pageInfo.pageSize }"/>
                        <input type="hidden" id="pageIndex" name="pageIndex" value="${pageInfo.pageIndex } "/>

                        <table width="100%" border="0" cellspacing="0" cellpadding="0">
                            <tr>
                                <td class="t_r">开标时间</td>
                                <td class="t_l"><input type="text" readonly="readonly" id="beginOpenDate" style=" width: 143px;"
                                                                   name="beginOpenDate"
                                                                   value="<fmt:formatDate value="${bidPlan.beginOpenDate }" pattern="yyyy-MM-dd"/>"/>至<input style=" width: 143px;"
                                        readonly="readonly" type="text" id="endOpenDate" name="endOpenDate"
                                        value="<fmt:formatDate value="${bidPlan.endOpenDate }" pattern="yyyy-MM-dd"/>"/>
                                </td>
                                <td class="t_r">
                                	<input type="button" value="检索" onclick="butSearch();" style="width:50px;">
                               	 	<input type="button" name="clearBtn" value="清除" style="width:50px;margin-left:8px;">
                                </td>
                            </tr>
                        </table>
                    </form>
                </div>
            </div>
        </div>
        <!--  <input type="button" name="excelButton" id="excelButton" value="导 出当页至 EXCEL" class="fl">
           &nbsp;<input type="button" name="excelAllButton" id="excelAllButton" value="导 出全部至 EXCEL" class="fl">
         -->
    </div>
    <!--Filter End-->
    <!--Table-->
    <!--  <s:set name="r" value="#request.pageResultSet.list"></s:set> -->
    <div class="mb10">
    	<input type="hidden" id="dictids" name="dictids" value="${dictids}"/>
        <table width="100%" class="table_1" id="mytable">
            <tbody>
            <!-- <tr>
                <th colspan="30">&nbsp;&nbsp;执行计划列表
                    <input type="button" onclick="addPlan('2');" value="新增集中招标计划" class="fr" style="margin-right: 5px;">
                    <input type="button" onclick="addPlan('1');" value="新增单线执行计划" class="fr" style="margin-right: 5px;">
                </th>
            </tr> -->
            <tr class="tit">
                <td class="t_c" >标段类型</td>
	                <c:forEach items="${types }" var="btype" varStatus="status">
	                	<td class="t_c" colspan="2" width="" >${btype.dictName}</td>
	                </c:forEach>
                <td class="t_c"  colspan="2">小计</td>
            </tr>
            <tr class="tit">
                <td class="t_c">线路名称</td>
	                <c:forEach items="${types }" var="btype" varStatus="status">
	                	<td class="t_c"  width="">标段数量</td>
	                	<td class="t_c"  width="">累计中标金额</td>
	                </c:forEach>
                <td class="t_c"  width="">标段数量</td>
	            <td class="t_c"  width="">累计中标金额</td>
            </tr>
            </tbody>
            <tbody id="ajaxTbody">
            
            </tbody>
            <tfoot>

            </tfoot>
        </table>

    </div>


</div>
</div>

<div style="display: none;">
    <jsp:include page="/menu"/>
</div>
</body>
</html>