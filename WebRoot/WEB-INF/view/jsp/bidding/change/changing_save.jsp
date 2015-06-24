
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8"/>
    <title>招标计划变更</title>


    <style type="text/css">
        .ui-datepicker-title span {
            display: inline;
        }

        button.ui-datepicker-current {
            display: none;
        }
    </style>

    <script type="text/javascript">
        var selectedBiddingList = [],tmpBiddingList = [];
        $(function () {

            $("#changeForm").submit(function(){
                if($("select[name=type]").val()==""){
                    alert("请选择变更类型!");
                    return false;
                }
                if($("#content").val()==""){
                    alert("请输入变更内容!");
                    return false;
                }
                if($("#updateTime").val()==""){
                    alert("请输入变更时间!");
                    return false;
                }
                if($("#content").val().length>500){
                    alert("内容至多500!");
                    return false;
                }

                if(($("select[name=type]").val()=="2"||$("select[name=type]").val()=="3")&&$("#biddingIdListInput").val()==""){
                    alert("请添加招标计划!");
                    return false;
                }

                $("#changeNew").dialog("close");
                window.parent.scrollTo(0,0);
            })

            $("#updateTime").datepicker({
//				inline: true,
				changeYear:true
//				changeMonth:true,
//				showOtherMonths: true,
//				selectOtherMonths: true
			});



            $("select[name=type]").change(function(){
                toggleSelect($(this).val());
            });
        });

        function toggleSelect(val){
            if(val=="1" || val==""||val=="4"){
                $("#formTb").find("tr:eq(1)").hide();
                $("#biddingIdListInput,#biddingIdList").prop("disabled", true);
            }else{
                $("#formTb").find("tr:eq(1)").show();
                $("#biddingIdListInput,#biddingIdList").prop("disabled", false);
            }
        }

        function resetForm(){
            $("select[name=type]").find("option:eq(0)").prop("selected",true);
            $("#content").val("");
            $("#updateTime").val(format(new Date(),'yyyy-MM-dd'));
            $("#biddingIdListInput").val("");
            $("#biddingIdList").val("");
            toggleSelect("");
        }

        function selectBiddings() {
//            if($("#bRouteId").val()==""&&$("#bBiddingName").val()==""&&$("#bBiddingNo").val()==""){
//                 alert("请至少指定一个查询条件");
//            }
        	$.ajax({
        		url: "${pageContext.request.contextPath}/bidding/getBiddingWithoutSelf",
        		data: "format=json&biddingId="+ '${biddingId}'+"&"+$("#biddingsForm").serialize(),
        		type: "get",
        		dataType: "json",
        		success: function(data){
                    if(!data.biddingList){
                        $("#biddingsCheckboxDivTbody").html("<tr><td colspan='4' class='t_c'>没有找到记录</td></tr>");
                    }
                    data = data.biddingList;
        			var result = '';
        			for(var i=0; i<data.length; i++){
	        			var tmp = '<tr><td><input name="biddingIds" style="z-index:2000;" type="checkbox" value="' + data[i].biddingId
	        				+ '"></td><td>' + data[i].biddingName + '</td><td>'+data[i].biddingNo+'</td><td>'+data[i].route.routeName+'</td></tr>';
	        			result += tmp;
        			}
        			$("#biddingsCheckboxDivTbody").html(result);

                    for(var i = 0;i<selectedBiddingList.length;i++){
                        $(":checkbox[value="+selectedBiddingList[i].id+"]").prop("checked",true);
                    }


                    $(":checkbox[name=biddingIds]").change(function(){
                        var name = $(this).parent().next().text();
                        var id = $(this).val();
                        var bidding = {"name":name,"id":id};
                        if($(this).is(":checked")){
                            addBidding(bidding);
                        }else{
                            removeBidding(bidding);
                        }
                    })
        			

        		}
        	});
        }

        function openBiddingWin(){
            $("#biddingsDiv").dialog({
                resizable: true,
                height:500,
                width: 900,
                modal: true,
                open:function(){
                    tmpBiddingList = selectedBiddingList;
                    selectBiddings();
                },
                title: '招标计划变更',
                buttons:{
                    '确定': function(){
                        showSelectedBidding();
                        $(this).dialog('close');
                    },
                    '取消': function(){
                        $(this).dialog('close');
                    }
                }
            });
        }

        function addBidding(bidding){
            if(!isExistBidding(tmpBiddingList,bidding)){
                tmpBiddingList.push(bidding);
            }
        }

        function removeBidding(bidding){
           for(var i = tmpBiddingList.length-1;i>=0;i--){
               if(tmpBiddingList[i].id == bidding.id){
                   tmpBiddingList.splice(i,1);
               }
           }
        }

        function isExistBidding(array,bidding){
            var flag = false;
            for(var i = 0;i<array.length;i++){
                if(array[i].id == bidding.id){
                    flag = true;
                    break
                }
            }
            return flag;
        }

        function showSelectedBidding(){
            selectedBiddingList  = tmpBiddingList;
            var names = [];
            var ids = [];
            for(var i=0;i<selectedBiddingList.length;i++){
                names.push(selectedBiddingList[i].name);
                ids.push(selectedBiddingList[i].id);
            }
            $("#biddingIdList").val(ids.toString());
            $("#biddingIdListInput").val(names.toString())

            tmpBiddingList = [];
        }

    </script>
</head>

<body>
<div class="main">
    <!--Ctrl-->
   
    <!--Ctrl End-->
    <!--Filter--><!--Filter End-->
    <!--Table-->

    <div class="mb10 pt45">
    	<div class="ctrl clearfix nwarp" style="margin-top: 48px; display:none;">
		    <div class="fl"><img src="../images/sideBar_arrow_left.jpg" width="46" height="30" alt="收起"></div>
		    <div class="posi fl">
		        <ul>
		            <li><a href="#">首页</a></li>
		            <li class="fin">变更历史管理</li>
		        </ul>
		    </div>
		</div>
        <form id="changeForm" action="${pageContext.request.contextPath}/bidding/change/save" method="get">
            <input type="hidden" id="bidChangeId" name="bidChangeId" value="${bidChangeId}"/>
        	<input type="hidden" name="bidding.biddingId" value="${biddingId}"/>
            <input type="hidden"  name="hideHeader" value="${param.hideHeader}"/>
            <input type="hidden"  name="containerId" value="${param.containerId}"/>
            <table width="100%" class="table_1">
                <thead>
				<tr>
				    <th colspan="30">&nbsp;&nbsp;
				</tr>
			    </thead>
                <tbody id="formTb">
	                <tr>
	                    <td class="t_r lableTd" style="width:10%;">变更类型：</td>
	                    <td style="width:30%;">
	                    	<select name="type">
                                <option value="">请选择</option>
                                <option value="4">进度有调整</option>
	                    		<option value="1">招标内容有变化</option>
	                    		<option value="2">标段合并</option>
	                    		<option value="3">标段拆分</option>
	                    	</select>
	                    </td>
	                    <td class="t_r lableTd" style="width:15%;">变更时间：</td>
	                    <td>
	                        <input type="text" id="updateTime" name="updateTime" class="input_xxlarge" />
	                    </td>
	                </tr>
	                <tr>
	                    <td class="t_r lableTd" style="width:10%;">关联标段：</td>
	                    <td style="width:30%;">
	                        <input type="text" readonly="readonly" id="biddingIdListInput" name="biddingIdListInput" style="width:300px;" class="input_xxlarge" value="<fmt:formatDate value="${bidding.fileEndDate }" pattern="yyyy-MM-dd"/>"/>
	                        <input type="button" value="添加招标计划" onclick="openBiddingWin();" style="width:23%;">
	                        <input type="hidden" name="biddingIdList" id="biddingIdList"/>
	                    </td>
	                    <td></td>
	                    <td></td>
	                </tr>
	                <tr height="100px">
	                    <td class="t_r lableTd" style="width:15%;">变更内容：</td>
	                    <td style="width:45%;height:100px;">
	                        <textarea style="height:100px;" id="content" name="content"></textarea>
	                    </td>
	                </tr>
                </tbody>
                <tr class="tfoot">
                    <td colspan="4" class="t_r"><input id="save" type="submit"  value="保存"/>&nbsp;
                        <input type="reset" value="重 置"/>&nbsp;</td>
                </tr>
            </table>
        </form>
    </div>
    <!--Table End-->
    <div  id="biddingsDiv"  style="display: none;">
    	<!--Filter-->
        <div class="filter">
            <div class="query">
                <div class="p8 filter_search">
                    <form action="" method="get" id="biddingsForm">

                        <table width="100%" border="0" cellspacing="0" cellpadding="0">
                            <tr>
                                <td class="t_r" width="90">线路名称</td>
                                <td>
                                    <div id="routeDiv">

                                    </div>
                                </td>
                                <td class="t_r" width="90">标段名称</td>
                                <td>
                                    <input type="text" id="bBiddingName" name="biddingName" value="${bidding.biddingName }"/>
                                </td>
								<td class="t_r" width="90">标段编号</td>
                                <td>
                                    <input type="text" id="bBiddingNo" name="biddingNo" value="${bidding.biddingNo }"/>
                                </td>
                               
                            </tr>
                            <tr>
                                <td colspan="7" class="t_c"><input type="button" value="检索" onclick="selectBiddings();" style="width:50px;">
                                <input type="reset" value="重 置"/>&nbsp;</td></td>
                            </tr>

                            <!--
                         <tr>
                           <td colspan="6" class="t_c">
                               <input type="submit" value="检 索" /></td>
                         </tr> -->
                        </table>
                    </form>


                </div>
            </div>
        </div>
        <!-- filter end -->
        
        <table id="biddingsCheckboxDiv" class="table_1">
        	<thead>
        		<tr>
        			<td style="width:20px"></td>
        			<td style="width:400px">标段名称</td>
        			<td style="width:230px">标段编号</td>
        			<td style="width:170px">线路</td>
        		</tr>
        	</thead>
        	<tbody id="biddingsCheckboxDivTbody">
        	</tbody>
        </table>
    </div>
</div>
</body>
</html>
