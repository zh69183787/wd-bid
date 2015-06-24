<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="cn">
<head>
    <meta charset="utf-8"/>
    <title>本月已删除招标计划</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/jquery-ui.css">
    <script src="${pageContext.request.contextPath}/js/jquery-1.10.2.js"></script>
    <script src="${pageContext.request.contextPath}/js/jquery-ui.js"></script>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css2/formalize.css"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css2/page.css"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css2/imgs.css"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css2/reset.css"/>
    <!--[if IE 6.0]>
    <script src="../js/iepng.js" type="text/javascript"></script>
    <script type="text/javascript">
        EvPNG.fix('div, ul, ol, img, li, input, span, a, h1, h2, h3, h4, h5, h6, p, dl, dt');
    </script>
    <![endif]-->
    <script src="${pageContext.request.contextPath}/js/html5.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/flick/jquery.ui.datepicker-zh-CN.js"></script>


    <script type="text/javascript">

					//跳转到制定页
					function goPage(pageNo, type) {
						//type=0,直接跳转到指定页
						if (type == "0") {
							var totalPage = $("#totalPageCount").val();//总页数
							var pageNumber = $("#pageNumber").val();//当前页码
							if (!pageNumber.match(/^[0-9]*$/)) {//输入不是数字时提示
								alert("请输入数字");
								$("#pageNumber").val("");
								$("#pageNumber").focus();
								return;
							}
							if (parseInt(pageNumber) > parseInt(totalPage)) {
								$("#pageNumber").val(totalPage);
								$("#pageIndex").val(totalPage);
							} else {
								$("#pageIndex").val(pageNumber);
							}
						}
						//type=1,跳转到上一页
						if (type == "1") {
							$("#pageIndex").val(
									parseInt($("#pageIndex").val()) - 1);
						}
						//type=2,跳转到下一页
						if (type == "2") {
							$("#pageIndex").val(
									parseInt($("#pageIndex").val()) + 1);
							//alert($("#pageNo").val());
						}

						//type=3,跳转到最后一页,或第一页
						if (type == "3") {
							$("#pageIndex").val(pageNo);
						}
						if (true) {//校验
							$("#form").submit();
						}
					}
					
					  $(function () {

				            $('#createTimeBegin,#createTimeEnd,#completeDateBegin,#completeDateEnd,#appraiseDateBegin,#appraiseDateEnd').datepicker({
				                "changeYear": true
				            });

				            $('#biddingTypeId > option[value=${bidding.biddingTypeId}]').prop("selected",true);

				            var bidding = $("#menu a[title=${bidding.biddingTypeId}]").text();
				            $("#menu a[title='']").text(bidding);
				            $( "#menu" ).menu();//biddingTypeId
				            $( "#menu a" ).click(function(){
				                $("a[title='']").text($(this).text());
				                $("#biddingTypeId").val($(this).attr("title"));
				            });

				            //加载线路
				            $.ajax({ //一个Ajax过程
				                type: "get", //以post方式与后台沟通
				                url: "${pageContext.request.contextPath}/route/routes", //与此php页面沟通
				                dataType: 'json',//从php返回的值以 JSON方式 解释
				                data: 'format=json&pageSize=100000', //发给php的数据有两项，分别是上面传来的u和p
				                success: function (data) {//如果调用php成功
				                    var html = "<option value=''>--请选择线路--</option>";
				                    $.each(data.routes, function (i, value) {
				                        html += "<option value='" + value.routeId + "'>" + value.routeName + "</option>";
				                    });
				                    $("[id=routeId]").empty();
				                    $("[id=routeId]").append(html);
				                    //一下代码段是查询时线路条件
				                    $("#routeId").find("option[value=${bidding.routeId}]").attr("selected", true);

				                    //
				                    //根据线路加载标段

				                }});
				            $("#nav_ul > li").filter(function (index) {
				                return $(this).attr("name") == "business";
				            }).addClass("selected");
				            $("a[id^=deletes]").click(function () {//获取主键值
				                var ids = $(this).attr("id");
				                var projectId = $(this).attr("title");
				                var param = "?projectId=" + projectId + "&page=" + $("#page").val();
				                if (window.confirm("是否确认删除？"))
				                    window.location.href = "deletes.action" + param;
				            });

				            $("tbody > tr").find("td:eq(2) > span").each(function (i, o) {
				                var biddingType = [];
				                var txt = $(o).text().split("-");
				                var v = txt[0];
				                if (v.length > 1) {
				                    for (var i = 0; i < v.length-1; i++) {
				                        var c = v.substring(0, (i + 1));
				                        biddingType[i] = $("a[title=" + c + "]").text();
				                    }

				                    $(o).parent().text(biddingType.join("-"));
				                } else {
				                    $(o).parent().text("其他-" + txt[1]);
				                }
				            });
				            
				            bidTypeMenu("ubiddingTypeId",250); //绑定类型选择
				        });
					
					//取消结果跳转
					function cancelResult(biddingId,mainId) {
						if (window.confirm("是否确认取消？")) {
							location.href = '${pageContext.request.contextPath}/bidding/cancelImport?biddingId='
									+ biddingId+"&mainId="+mainId;
						}

					}

					//添加跳转
					function add() {
						//window.open("project_add.jsp");
						window.location = "${pageContext.request.contextPath}/bidimport/form";
					}
					//编辑跳转
					function editData(biddingId) {

						window.location = "${pageContext.request.contextPath}/bidimport/"
								+ biddingId;
					}
					//对比跳转
					function compareData(biddingId) {

						window.location = "${pageContext.request.contextPath}/bidimport/compare?biddingId="
								+ biddingId;
					}
					
					//删除
					  function deletes(biddingId) {
			            if (window.confirm("是否确认删除？")) {
			                location.href = "${pageContext.request.contextPath}/bidding/" + biddingId+"/delete" ;
			            }
			        }

					  
				</script>

    <style>
        .dateInput{
            width: 100px;
        }
        .ui-menu {
            width: 250px;
        }

        .ui-datepicker-title span {
            display: inline;
        }
 		.ctrl{
    		margin-bottom:0px;
    	}
    	.filter{
    		padding-bottom:1px;
    	}
    	.filter .query{
    		border-bottom:0px;
    	} 

    </style>
</head>

<body>
<!-- <table id="datas"><tr><td></td></tr>

</table> -->
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
		            <li class=""><a href="${pageContext.request.contextPath}/bidimportmain/bidImportMains">招标计划导入</a></li>
		            <li class="fin">本月已删除招标计划</li>
		        </ul>
		    </div>
		</div>
        <!--Filter-->
        <div class="filter">
            <div class="query">
                   <div class="p8 filter_search">
                    <form action="${pageContext.request.contextPath}/bidding/biddingsImportUnHas" method="get" id="form">
                        <input type="hidden" id="pageSize" name="pageSize" value="${pageInfo.pageSize }"/>
                        <input type="hidden" id="pageIndex" name="pageIndex" value="${pageInfo.pageIndex }"/>
						 <input type="hidden" id="mainId" name="mainId" value="${bidImportMain.mainId }"/>
                        <table width="100%" border="0" cellspacing="0" cellpadding="0">
                            <tr>
                                <td class="t_r" width="90">线路名称</td>
                                <td>
                                    <select id="routeId" name="routeId">

                                    </select>
                                </td>
                                <td class="t_r" width="90">招标类型</td>
                                <td id="ubappend">
                                    <input type="hidden" id="ubiddingTypeId" name="biddingTypeId"
                                           value="${bidding.biddingTypeId}"/>
                                </td>
                                <td class="t_r" width="90">标段名称</td>
                                <td>
                                    <input type="text" name="biddingName" value="${bidding.biddingName }"/>
                                </td>

                               
                            </tr>
                            <tr>
                            	 <td class="t_r">是否完成</td>
                                <td>
                                    <select name="isCompleted">
                                        <option value="">请选择</option>
                                        <option value="1" <c:if test="${bidding.isCompleted=='1'}">selected</c:if>>是</option>
                                        <option value="2" <c:if test="${bidding.isCompleted=='2'}">selected</c:if>>否</option>
                                    </select>
                                </td>
                                <td class="t_r">完成时间</td>
                                <td>
                                    <input type="text" id="completeDateBegin"
                                           name="completeDateBegin" class="dateInput"
                                           value="<fmt:formatDate value="${bidding.completeDateBegin }" pattern="yyyy-MM-dd"/>"/>至<input
                                        type="text" id="completeDateEnd" name="completeDateEnd" class="dateInput"
                                        value="<fmt:formatDate value="${bidding.completeDateEnd }" pattern="yyyy-MM-dd"/>"/>
                                </td>
                                <td class="t_r">评标时间</td>
                                <td>
                                    <input type="text" id="appraiseDateBegin"
                                           name="appraiseDateBegin" class="dateInput"
                                           value="<fmt:formatDate value="${bidding.appraiseDateBegin }" pattern="yyyy-MM-dd"/>"/>至<input
                                        type="text" id="appraiseDateEnd" name="appraiseDateEnd" class="dateInput"
                                        value="<fmt:formatDate value="${bidding.appraiseDateEnd }" pattern="yyyy-MM-dd"/>"/>
                                </td>
                                
                            </tr>
                            <tr>
                            	<td class="t_r">创建时间</td>
                                <td>
                                    <input type="text" id="createTimeBegin"
                                           name="createTimeBegin" class="dateInput"
                                           value="<fmt:formatDate value="${bidding.createTimeBegin}" pattern="yyyy-MM-dd"/>"/>至<input
                                        type="text" id="createTimeEnd" name="createTimeEnd" class="dateInput"
                                        value="<fmt:formatDate value="${bidding.createTimeEnd}" pattern="yyyy-MM-dd"/>"/>
                                </td>

                                <td class="t_r">状态</td>
                                <td>
                                    <select name="bidState" defaultval='1'>
                                        <option value="">请选择</option>
                                        <option value="1" <c:if test="${bidding.bidState=='1'}">selected</c:if>>正常</option>
                                        <option value="2" <c:if test="${bidding.bidState=='2'}">selected</c:if>>已取消</option>
                                    </select>
                                </td>
                            </tr>
                            <tr>
                                <td colspan="3" class="t_r"><input type="submit" value="检索" style="width:50px;"></td>
                                 <td colspan="4" class="t_l"><input type="button" value="重 置"
							  		 onclick="return resetSearch('form','ubiddingTypeId')" />&nbsp;</td>
                            </tr>

                        </table>
                    </form>


                </div>
            </div>
        </div>
     
        <div class="" style="margin-bottom: 3px; border-bottom: 1px solid #c4c5c6;">
            <input type="hidden" id="mainId" name="mainId" value="${bidImportMain.mainId }"/>
            <table width="100%" class="table_1">
            	<thead>
					<tr>
					    <th colspan="30">&nbsp;&nbsp;招标计划导入详情
					    <input type="button" name="addButton" id="addButton" onclick="location.href = '${pageContext.request.contextPath}/bidimport/bidimports?mainId=${bidImportMain.mainId }'" value="返回" class="fr">
         				<%-- &nbsp;<input type="button" name="addButton" id="addButton" onclick="location.href = '${pageContext.request.contextPath}/bidimport/completeData?mainId=${bidImportMain.mainId }'" value="数据对比" class="fr"> --%>
					</tr>
				</thead>
                <tbody>
                <tr>
                    <td class="t_r lableTd" style="width:10%;">导入日期：</td>
                    <td style="width:30%;">
                        <fmt:formatDate value="${bidImportMain.createTime }" pattern="yyyy-MM-dd"/>
                    </td>
                    <td class="t_r lableTd" style="width:15%;">所属年月：</td>
                    <td style="width:45%;">
                        <fmt:formatDate value="${bidImportMain.belongDate }" pattern="yyyy-MM-dd"/>
                    </td>
                </tr>
                <tr>
                    <td class="t_r lableTd" style="width:10%;">上报单位：</td>
                    <td style="width:30%;" >
                         ${bidImportMain.dictCompany.dictName }
                    </td>
                    <td class="t_r lableTd" style="width:15%;">当前状态：</td>
                    <td style="width:45%;">${bidImportMain.isUpdate=='0'?'未入库':'已入库'}
                      
                    </td>
                </tr>

                </tbody>
            </table>
    </div>
    </div>
    <!--Filter End-->
    <!--Table-->
    <!--  <s:set name="r" value="#request.pageResultSet.list"></s:set> -->
    <div class="mb10">
        <table width="100%" class="table_1" id="mytable">
        	<thead>
				<tr>
				    <th colspan="30">&nbsp;&nbsp;招标计划导入删除清单
				    <!-- <input type="button" name="addButton" id="addButton" onclick="add();" value="新 增" class="fr">
           			<input type="button" name="excelButton" id="excelButton" value="导 出当页至 EXCEL" class="fr">
               		&nbsp;<input type="button" name="excelAllButton" id="excelAllButton" value="导 出全部至 EXCEL" class="fr"> -->
				</tr>
			</thead>
            <tr class="tit">
           	    <td class="t_c" width="100">线路名称</td>
                <td class="t_c" width="150">标段名称</td>
                <td class="t_c" width="150">标段类型</td>
                <td class="t_c" width="50">招标方式</td>
                <td class="t_c" width="80">标段编号</td>
                <td class="t_c" width="100">文件完成日期</td>
                <td class="t_c" width="80">评标日期</td>
                <td class="t_c" width="80">创建时间</td>
                <td class="t_c" width="80" style="display:none;">修改时间</td>
                <td class="t_c" width="50">是否完成</td>
                <td class="t_c" width="80">完成时间</td>
                <td class="t_c" width="250">操作</td>
            </tr>
            <tbody>
            <c:forEach items="${biddings }" var="bidding" varStatus="status">
                <tr id="dataTr">
               		<td>${bidding.route.routeName}</td>
                    <td>${bidding.biddingName}</td>
                    <td><span style="display: none;">${bidding.biddingTypeId }-${bidding.biddingType }</span></td>
                   <%--  <td>${bidding.biddingTypeId}</td> --%>
                    <td>
                        <c:choose>
                            <c:when test="${bidding.bidType=='1'}">
                                单线
                            </c:when>
                            <c:when test="${bidding.bidType=='2'}">
                                集中
                            </c:when>
                            <c:otherwise>

                            </c:otherwise>
                        </c:choose>
                    </td>
                    <td>${bidding.biddingNo}</td>
                    <td><fmt:formatDate value="${bidding.fileEndDate}" pattern="yyyy-MM-dd"/></td>
                    <td><fmt:formatDate value="${bidding.appraiseDate}" pattern="yyyy-MM-dd"/></td>
                    <td><fmt:formatDate value="${bidding.createTime}" pattern="yyyy-MM-dd"/></td>
                    <td style="display:none;"> <fmt:formatDate value="${bidding.updateTime}" pattern="yyyy-MM-dd"/></td>
                    <td>
                        <c:choose>
                            <c:when test="${bidding.isCompleted=='1'}">
                              		是
                            </c:when>
                            <c:when test="${bidding.isCompleted=='2'}">
                              		否
                            </c:when>
                            <c:otherwise>
                                	
                            </c:otherwise>
                        </c:choose>

                    </td>
                    <td><fmt:formatDate value="${bidding.completeDate}" pattern="yyyy-MM-dd"/></td>
                 
                   <td>
                       <%--  <c:if test="${bidding.bidType=='1'}">
                        <a class="fl mr5"
                           href="${pageContext.request.contextPath}/plan/form?biddingId=${bidding.biddingId}&routeId=${bidding.routeId}">新增执行计划</a>
                        </c:if>
                        <a class="fl mr5" href="javascript:void(0)" onclick="editData('${bidding.biddingId }')">修改</a> 
                        <a class="fl mr5" href="javascript:void(0)" onclick="deletes('${bidding.biddingId }')">删除</a>--%>
                        <a class="fl mr5" href="javascript:void(0)" onclick="cancelResult('${bidding.biddingId }','${bidImportMain.mainId }')">取消</a>
                       <%--  <a class="fl mr5" href="javascript:void(0)" onclick="bidChange('${bidding.biddingId }')">变更</a> --%>

                    </td>
                </tr>
            </c:forEach>
            </tbody>
            <jsp:include page="../pageInfo.jsp"></jsp:include>
        </table>

    </div>


</div>
<div style="display: none;">
    <jsp:include page="/menu"/>
</div>
</body>
</html>