<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="cn">
<head>
    <meta charset="utf-8"/>
    <title>本月招标计划列表</title>
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

					$(function() {

						$('#createTime,#belongDate,#appraiseDate,#updateTime,#appraiseDateBegin,#appraiseDateEnd')
								.datepicker({
									"changeYear" : true
								});

						$("#nav_ul > li").filter(function(index) {
							return $(this).attr("name") == "business";
						}).addClass("selected");
						$("a[id^=deletes]").click(
								function() {//获取主键值
									var ids = $(this).attr("id");
									var projectId = $(this).attr("title");
									var param = "?projectId=" + projectId
											+ "&page=" + $("#page").val();
									if (window.confirm("是否确认删除？"))
										window.location = "deletes.action"
												+ param;
								});

						$("tbody > tr").find("td:eq(2) > span").each(
								function(i, o) {
									var biddingType = [];
									var txt = $(o).text().split("-");
									var v = txt[0];
									if (v.length > 1) {
										for (var i = 0; i < v.length - 1; i++) {
											var c = v.substring(0, (i + 1));
											biddingType[i] = $(
													"a[title=" + c + "]")
													.text();
										}

										$(o).parent().text(
												biddingType.join("-"));
									} else {
										$(o).parent().text("其他-" + txt[1]);
									}
								});

						//$("#menu").menu();
						
						
						
						
						bidTypeMenu("ubiddingTypeId",250); //绑定类型选择
					});

					function cancelResult(biddingId) {
						if (window.confirm("是否确认取消？")) {
							$('#loading').dialog('open');
							location.href = '${pageContext.request.contextPath}/bidimport/cancel?biddingId='
									+ biddingId;
						}

					}

					//添加跳转
					function add() {
						$('#loading').dialog('open');
						//window.open("project_add.jsp");
						window.location = "${pageContext.request.contextPath}/bidimport/form";
					}
										
					//本月已删除计划跳转
					function delPlan() {
						$('#loading').dialog('open');
						var mainId=$("#mainId").val();
						window.location = "${pageContext.request.contextPath}/bidding/biddingsImportUnHas?mainId="
								+mainId;
					}
					
					//编辑跳转
					function editData(biddingId) {
						$('#loading').dialog('open');
						window.location = "${pageContext.request.contextPath}/bidimport/editImport?bidImportId="
								+ biddingId;
					}
					//对比跳转
					function compareData() {
						if (window.confirm("是否确认进行数据对比？")) {
						$('#loading').dialog('open');
						window.location = '${pageContext.request.contextPath}/bidimport/completeData?mainId=${bidImportMain.mainId }';
						}
						/* window.location  = "${pageContext.request.contextPath}/bidimport/compare?biddingId="
								+ biddingId; */
					}
					
					//对比跳转
					function compareDataOne(biddingId) {
						//if (window.confirm("是否确认进行数据对比？")) {
						$('#loading').dialog('open');
						
						 window.location  = "${pageContext.request.contextPath}/bidimport/compare?biddingId="
								+ biddingId; 
					}
					
					
					
					//删除
					function deletes(biddingId) {
						if (window.confirm("是否确认删除？")) {
							$('#loading').dialog('open');
							$("#biddingId").val(biddingId);
							$("#removed").val("1");
							$("#delete").submit();
						}
					}
					 function unUpdate(bid) {
				        	if (window.confirm("是否确认忽略本条更新？")) {
				        		$('#loading').dialog('open');
				        		window.location = "${pageContext.request.contextPath}/bidimport/compareSave?biddingId="+ bid+"&isUpdate=2";
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
		             <li class="fin">本月招标计划列表</li>
		        </ul>
		    </div>
		</div>
        <!--Filter-->
        <div class="filter">
            <div class="query">
                <div class="p8 filter_search">
                    <form action="${pageContext.request.contextPath}/bidimport/bidimports" method="get" id="form">
                        <input type="hidden" id="pageSize" name="pageSize" value="${pageInfo.pageSize }"/>
                        <input type="hidden" id="pageIndex" name="pageIndex" value="${pageInfo.pageIndex }"/>
                        <input type="hidden" id="mainId" name="mainId" value="${bidImport.mainId }"/>

                        <table width="100%" border="0" cellspacing="0" cellpadding="0">
                            <tr>
                               	 <td class="t_r" width="90">标段编号</td>
                                <td>
                                    <input type="text" name="biddingNo" value="${bidImport.biddingNo }"/>
                                </td>
                                <td class="t_r" width="90">标段名称</td>
                                <td>
                                    <input type="text" name="biddingName" value="${bidImport.biddingName }"/>
                                </td>
                                <td class="t_r" width="90">招标类型</td>
                                <td id="ubappend">
                                    <input type="hidden" id="ubiddingTypeId" name="ubiddingTypeId" fullname='${bidImport.fullTypeName}'
                                           value="${bidImport.ubiddingTypeId}"/>
                                </td>
                                 </tr>
                            <tr>
                                <td class="t_r" width="90">招标方式</td>
                                <td>
                                    <input  type="text" name="bidType" value="${bidImport.bidType }"/>
                                </td>
		 						<td class="t_r">评标时间</td>
                                <td>
                                    <input type="text" id="appraiseDateBegin"
                                           name="appraiseDateBegin" class="dateInput"
                                           value="<fmt:formatDate value="${bidImport.appraiseDateBegin }" pattern="yyyy-MM-dd"/>"/>至<input
                                        type="text" id="appraiseDateEnd" name="appraiseDateEnd" class="dateInput"
                                        value="<fmt:formatDate value="${bidImport.appraiseDateEnd }" pattern="yyyy-MM-dd"/>"/>
                                </td>
                                <td class="t_r" width="90">更新状态</td>
                                <td>
                                    <select name="isUpdate">
                                        <option value="">请选择</option>
                                        <option value="0" <c:if test="${bidImport.isUpdate=='0'}">selected</c:if>>未更新</option>
                                       <%--  <option value="1" <c:if test="${bidImport.isUpdate=='1'}">selected</c:if>>已更新</option> --%>
                                        <option value="2" <c:if test="${bidImport.isUpdate=='2'}">selected</c:if>>已忽略</option>
                                    </select>
                                </td>
                            </tr>
                            <%-- <tr>
                                <td class="t_r">所属年月</td>
                                <td>
                                    <input type="text" id="belongDate"
                                           name="belongDate" class="dateInput"
                                           value="<fmt:formatDate value="${bidImport.belongDate }" pattern="yyyy-MM-dd"/>"/>
                                </td>
                                <td class="t_r">评标日期</td>
                                <td>
                                    <input type="text" id="appraiseDate"
                                           name="appraiseDate" class="dateInput"
                                           value="<fmt:formatDate value="${bidImport.appraiseDate}" pattern="yyyy-MM-dd"/>"/>
                                </td>
                                <td class="t_r">创建时间</td>
                                <td>
                                    <input type="text" id="createTime"
                                           name="createTime" class="dateInput"
                                           value="<fmt:formatDate value="${bidImport.createTime}" pattern="yyyy-MM-dd"/>"/>
                                </td>

                                <td class="t_r">修改时间</td>
                                <td>
                                    <input type="text" id="createTimeBegin"
                                           name="createTimeBegin" class="dateInput"
                                           value="<fmt:formatDate value="${bidImport.updateTime}" pattern="yyyy-MM-dd"/>"/>
                                </td>
                            </tr> --%>
                            <tr>
                                <td colspan="3" class="t_r"><input type="submit" value="检 索" style="width:50px;"></td>
                                 <td colspan="4" class="t_l"><input type="button" value="清 除"
							  		 onclick="return resetSearch('form','ubiddingTypeId')" />&nbsp;</td>
                            </tr>

                        </table>
                    </form>
                    <form action="${pageContext.request.contextPath}/bidimport/save" method="POST" id="delete">
                        <input type="hidden" id="biddingId" name="biddingId" value=""/>
                        <input type="hidden" id="removed" name="removed" value=""/>
                    </form>

                </div>
            </div>
        </div>
        <%-- <div style="height: 25px;margin-top: 5px;">
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<h5 class="fl"><a href="#" class="colSelect fl">招标计划导入详情</a></h5>
            &nbsp;<input type="button" name="addButton" id="addButton" onclick="location.href = '${pageContext.request.contextPath}/bidimportmain/bidImportMains'" value="返回" class="fr">
            &nbsp;<input type="button" name="addButton" id="addButton" onclick="location.href = '${pageContext.request.contextPath}/bidimport/completeData?mainId=${bidImportMain.mainId }'" value="数据对比" class="fr">
        </div> --%>
        <div class="" style="margin-bottom: 3px; border-bottom: 1px solid #c4c5c6;">
            <input type="hidden" id="mainId" name="mainId" value="${bidImportMain.mainId }"/>
            <table width="100%" class="table_1">
            	<thead>
					<tr>
					    <th colspan="30">&nbsp;&nbsp;招标计划导入详情
					    <input type="button" name="addButton" id="addButton" onclick="location.href = '${pageContext.request.contextPath}/bidimportmain/bidImportMains'" value="返回" class="fr">
         				&nbsp;<input type="button" name="addButton" id="addButton" onclick="compareData();" value="数据对比" class="fr">
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
                       <%--  <select name="isUpdate">
                            <option value="">请选择</option>
                            <option value="0" <c:if test="${bidImportMain.isUpdate=='0'}">selected</c:if>>未入库</option>
                            <option value="1" <c:if test="${bidImportMain.isUpdate=='1'}">selected</c:if>>已入库未更新</option>
                            <option value="2" <c:if test="${bidImportMain.isUpdate=='2'}">selected="selected"</c:if>>已更新</option>
                        </select> --%>
                    </td>
                </tr>

               <%--  <tr>
                    <td class="t_r lableTd" >上传招标计划文件：</td>
                    <td colspan="3" id="importcontent">
                    <input type="button" value="导入数据库" onclick="return importData('${bidImportMain.mainId}','${bidImportMain.fileName}');" id="save">
                    	<c:choose>
                            <c:when test="${bidImportMain.filePath!=null&&bidImportMain.filePath!=''}">
                            	<a href="${bidImportMain.filePath}" target="_blank" style="display: inline;" > ${bidImportMain.fileName}</a>
                            	<c:if test="${bidImportMain.mainId==null||bidImportMain.isUpdate!='1'&&bidImportMain.isUpdate!='2' }">
                            		<input type="button" value="导入数据库" onclick="return importData('${bidImportMain.mainId}','${bidImportMain.fileName}');" id="save">
                            	</c:if>
                            </c:when>
                            <c:otherwise>
                            	<input type="file" id="filePath" name="filePath" class="input_xxlarge" value=""/>
                            </c:otherwise>
                        </c:choose>
                    </td>
                </tr>
                <tr>
                    <td class="t_r lableTd" >上传附件：</td>
                    <td colspan="3">
                        <input type="file" id="filePath" name="filePath" class="input_xxlarge" value=""/>
                    </td>
                </tr> --%>
                
                
                </tbody>
            </table>
    </div>
     <!--    <div style="height: 25px;margin-top: 5px;">
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<h5 class="fl"><a href="#" class="colSelect fl">招标计划导入清单</a></h5>
            &nbsp;<input type="button" name="addButton" id="addButton" onclick="add();" value="新 增" class="fr">
             <input type="button" name="excelButton" id="excelButton" value="导 出当页至 EXCEL" class="fl">
               &nbsp;<input type="button" name="excelAllButton" id="excelAllButton" value="导 出全部至 EXCEL" class="fl">
             </div> -->
    </div>
    <!--Filter End-->
    <!--Table-->
    <!--  <s:set name="r" value="#request.pageResultSet.list"></s:set> -->
    <div class="mb10">
        <table width="100%" class="table_1" id="mytable">
        	<thead>
				<tr>
				    <th colspan="30">&nbsp;&nbsp;招标计划导入清单
				     <input type="button" name="delPlanButton" id="delPlanButton" onclick="delPlan();" value="处理本月已删除计划" class="fc" style="color:red;">
				   <!-- <input type="button" name="addButton" id="addButton" onclick="add();" value="新 增" class="fr">
           			 <input type="button" name="excelButton" id="excelButton" value="导 出当页至 EXCEL" class="fr">
               		&nbsp;<input type="button" name="excelAllButton" id="excelAllButton" value="导 出全部至 EXCEL" class="fr"> -->
				</tr>
			</thead>
            <tr class="tit">
            <td class="t_c" width="50">序号</td>
           	    <td class="t_c" width="150">线路名称</td>
                
                <td class="t_c" width="150">标段名称</td>
                <td class="t_c" width="">标段类型</td>
                <td class="t_c" width="50">招标方式</td>
                <td class="t_c" width="200">标段编码</td>
                <td class="t_c" width="80">文件完成日期</td>
                <td class="t_c" width="80">评标日期</td>
                <td class="t_c" width="180">对比结果</td>
                <td class="t_c" width="50">当前状态</td>
                <td class="t_c" width="180">操作</td>
            </tr>
            <tbody>
            <c:forEach items="${bidImports }" var="bidImport" varStatus="status">
                <tr id="dataTr">
                <td>${bidImport.serialNo}</td>
               		<td>${bidImport.routeName}</td>
                    <td>${bidImport.biddingName}</td>
                    <td>${bidImport.fullTypeName}</td>
                    <td>${bidImport.bidType}</td>
                    <td>${bidImport.biddingNo}</td>
                    <td><fmt:formatDate value="${bidImport.fileEndDate}" pattern="yyyy-MM-dd"/></td>
                    <td><fmt:formatDate value="${bidImport.appraiseDate}" pattern="yyyy-MM-dd"/></td>
                  <td>
                  		<c:choose>
                  			<c:when test="${bidImportMain.isUpdate==null||bidImportMain.isUpdate=='0'||bidImportMain.isUpdate=='1'}">
                            	<FONT color="orange">数据未对比</FONT>
                            </c:when>
                            <c:when test="${bidImport.urouteId==null||bidImport.urouteId==''}">
                            	<FONT color="RED">新增:线路不存在</FONT>
                            </c:when>
                            <c:when test="${bidImport.ubiddingId==null||bidImport.ubiddingId==''}">
                            	<FONT color="green">本月新增招标计划</FONT>
                            </c:when>
                            <c:when test="${bidImport.ubiddingId!=null&&bidImport.ubiddingId!=''}">
                            	<FONT color="blue">本月有变化招标计划</FONT>
                            </c:when>
                            <c:otherwise>
                            	<FONT >其他</FONT>
                            </c:otherwise>
                        </c:choose>
                  	
                  	</td>
                  	<td>${bidImport.isUpdateStr}</td>
                    <td>
                        <a class="fl mr5" href="javascript:void(0)" onclick="editData('${bidImport.biddingId }')">修改</a>
                        <a class="fl mr5" href="javascript:void(0)" onclick="compareDataOne('${bidImport.biddingId }')">对比</a>
                        <a class="fl mr5" href="javascript:void(0)" onclick="unUpdate('${bidImport.biddingId }')">忽略</a>
                        <%-- <a class="fl mr5" href="javascript:void(0)" onclick="deletes('${bidImport.biddingId }')">删除</a> --%>

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