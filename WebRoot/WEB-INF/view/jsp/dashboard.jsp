<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<!DOCTYPE html>
<html lang="cn">
<head>
    <meta charset="utf-8"/>
    <title></title>
    <link rel="stylesheet" href="<%=basePath %>css/formalize.css"/>
    <link rel="stylesheet" href="<%=basePath %>css/page.css"/>
    <link rel="stylesheet" href="<%=basePath %>css/default/imgs.css"/>
    <link rel="stylesheet" href="<%=basePath %>css/reset.css"/>
    <!--[if IE 6.0]>
    <script src="../js/iepng.js" type="text/javascript"></script>
    <script type="text/javascript">
        EvPNG.fix('div, ul, ol, img, li, input, span, a, h1, h2, h3, h4, h5, h6, p, dl, dt');
    </script>
    <![endif]-->
    <script src="<%=basePath %>js/html5.js"></script>
    <script src="<%=basePath %>js/jquery-1.7.1.js"></script>
    <script src="<%=basePath %>js/jquery.formalize.js"></script>
   
    <link type="text/css" href="<%=basePath %>css/flick/jquery-ui-1.8.18.custom.css" rel="stylesheet"/>
    <script type="text/javascript" src="<%=basePath %>js/flick/jquery-ui-1.8.18.custom.min.js"></script>
    <script type="text/javascript" src="<%=basePath %>js/flick/jquery.ui.datepicker-zh-CN.js"></script>


   <script type="text/javascript" src="${pageContext.request.contextPath}/js/hc/highcharts.js"></script>

    <script type="text/javascript">
        $(function () {
        	
        	//alert($("body").height());
        	$("#main_div").height($("body").height()-150);
        	$(window).resize(function(){
        		$("#main_div").height($("body").height()-150);
        	});
        	
        	$("#selectFor3").hide();
            $("#chartYearBid").hide();
            $("#home_tabs").find("a").click(function () {
                $(this).parents("ul").find("li").removeClass("selected");
                $(this).parent().addClass("selected");
                $(".con[id^=chart-tab-content]").hide();

                var index = $(this).parent().index();
                $("#date_range").show();
                $("#selectFor3").hide();
                $("#chartYearBid").hide();
                if (index == 1) {
                    $(":hidden[name=method]").val("2");
                    $("#winBid,#biddingTb").hide();
                    $("#openBid,#planTb,#biddingTypeDetail").show();
                    if($("#openBidBody").html().replace(/(^\s*)|(\s*$)/g, "")==""){
                        $($("#planTb > #rightUl").find("li")[4]).trigger("click");//开标
                    }
                }else if (index == 0)  {
                    $(":hidden[name=method]").val("1");
                    $("#winBid,#biddingTb").show();
                    $("#openBid,#planTb,#biddingTypeDetail").hide();
                }else{
                	//alert(0);
                	$("#date_range").hide();
                	$("#selectFor3").show();
                	$("#chartYearBid").show();



                	$(":hidden[name=method]").val("3");
                    $("#winBid,#biddingTb").hide();
                    $("#openBid,#planTb,#biddingTypeDetail").hide();

                    selectFor3Mothed($("#selectFor3data"));
                }
            });
            $("#winBid").find("tbody>tr").click(function(){
                window.open("<%=basePath%>report?biddingTypeId=" + $(this).find(":hidden[name=biddingTypeId]").val() + "&biddingPlanId="+$(this).find(":hidden[name=biddingPlanId]").val()+"&hasBidded=1&biddingName="+$(this).find("td:eq(1)").text()+"&" + $("form").serialize());
            })

            $("#biddingTb").find(".number_right").click(function(){
                window.open("<%=basePath%>report?biddingTypeId=" + ($(this).index("h1")+1) + "&type=6&hasBidded=1&" + $("form").serialize());
            })

            $('#form').submit(function(){
                if($("select[name=dateRange]").val() == "6"){

                    window.open("${pageContext.request.contextPath}/report");
                    return false;
                }

            });


            <c:if test="${param.dateRange == null}">
            var currentIndex = 1;
            </c:if>

            <c:if test="${param.dateRange != null}">
            var currentIndex = ${param.dateRange}-1;
            </c:if>

            $("#nav_ul > li").filter(function (index) {
                return $(this).attr("name") == "home";
            }).addClass("selected");
            $("#planTb > #rightUl").find("li").css("cursor", "pointer");
            $("#planTb > #rightUl").find("li").click(function () {
                $("#tb").html("");
                var $this = $(this);
                if (currentIndex == 3)
                    $("#biddingTypeName").html($(this).children('span').html() + "计划一览表");
                else
                    $("#biddingTypeName").html($($("option")[currentIndex]).html() + $(this).children('span').html() + "计划一览表");



                getBidPlan($(this).children('div').html())

                getBiddingType($this);

            });

            <c:if test="${param.dateRange != null}">
            $("option[value=${param.dateRange}]").prop("selected", "selected");
            <c:if test="${param.dateRange == 4}">
            $(":text[name=beginDate],:text[name=endDate]").prop("disabled", false);
            </c:if>
            </c:if>
            $(":radio").click(function () {
                var index = $(":radio").index($(this));
                currentIndex = index;
                if (index == 3) {
                    $(":text[name=beginDate],:text[name=endDate]").prop("disabled", false);
                } else {
                    $(":text[name=beginDate],:text[name=endDate]").prop("disabled", true);
                }
            });

            getBidPlan = function(type){
                type = type || "4";//默认开标
                $.ajax({
                    url: "<%=basePath %>plans",
                    type: "get",
                    dataType: "json",
                    data: 'format=json&' + $("form").serialize() + "&type=" + type,
                    success: function (data) {
                        var res = data.openBidPlan;
                        var htmlText = "";
                        for (var i = 0; i < res.length; i++) {
                            var $tr = $("<tr style='cursor:pointer;'><td></td><td></td><td><span style='display:none;' name='biddingTypeDescription'></span></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td></tr>");
                            $tr.find("td:eq(0)").html(res[i].routeName+"<input type='hidden' name='biddingPlanId' value='"+res[i].biddingPlanId+"'/>");
                            $tr.find("td:eq(1)").html(res[i].biddingName);
                            $tr.find("td:eq(2) span").html(res[i].biddingTypeId + "-" + res[i].biddingType);
                            $tr.find("td:eq(3)").html(format(res[i].applyDate, 'yyyy-MM-dd'));
                            if (res[i].hasCheck != '1') {
                                $tr.find("td:eq(4)").html('无资格预审');
                            } else {
                                $tr.find("td:eq(4)").html(format(res[i].checkDate, 'yyyy-MM-dd'));
                            }
                            $tr.find("td:eq(5)").html(format(res[i].bidBegin, 'yyyy-MM-dd'));
                            $tr.find("td:eq(6)").html(format(res[i].bidEnd, 'yyyy-MM-dd'));
                            $tr.find("td:eq(7)").html(format(res[i].tecOpenDate, 'yyyy-MM-dd'));
                            $tr.find("td:eq(8)").html(format(res[i].tecAppraiseDate, 'yyyy-MM-dd'));
                            $tr.find("td:eq(9)").html(format(res[i].bizAppraiseDate, 'yyyy-MM-dd'));
                            htmlText += $tr[0].outerHTML;
                        }
                        $("#openBidBody").html(htmlText);
                        $("#openBidBody>tr").click(function(){
                            window.open("<%=basePath%>report?biddingPlanId=" + $(this).find(":hidden[name=biddingPlanId]").val());
                        })

                        //对应列高亮显示
                        $("#openBidBody>tr").find("td:eq("+(parseInt(type)+3)+")").css("background-color","#c9d6eb").css("font-weight","bold");
                        $("span[name=biddingTypeDescription]").each(function (i, o) {
                            var txt = $(o).text().split("-");
                            var v = txt[0];
                            if (v.length > 1) {
                                $(o).parent().text(getSelectedNodeName(v));
                            }else{
                                $(o).parent().text("其他-" + txt[1]);
                            }
                        });
                    }
                });
            }


            getBiddingType = function($this){
                var bidType = $this.children('div').html();
                $.ajax({ //一个Ajax过程
                    type: "get",
                    url: "<%=basePath %>report/plan/biddingType", //与此php页面沟通
                    dataType: 'json',//从php返回的值以 JSON方式 解释
                    data: 'format=json&' + $("form").serialize() + "&type=" + bidType, //发给php的数据有两项，分别是上面传来的u和p
                    success: function (data) {//如果调用php成功

                        $.each(data.biddingTypeList, function (i, o) {
                            var html = "";
                            var space = "";
                            var name = $this.prev().prev().html();
                            var type = o.name;
                            if (type == "1")
                                name = "勘察设计类";
                            space = "";
                            if (type == "2")
                                name = "施工类";
                            space = "";
                            if (type == "3")
                                name = "监理类";
                            space = "";
                            if (type == "4")
                                name = "采购类";
                            space = "";
                            if (type == "5")
                                name = "其他类";
                            space = "";

                            html += "<li class='blue'><div style='display: none'>" + type + "</div><span style='display:inline' class='dTitle'>" + name + "</span><h1 class='mr5 L_08 number_right'>" + space + o.biddingNum + "</h1></tr>"
                            $("#tb").append(html);
                        });
                        $("#tb").find("li").css("cursor", "pointer");
                        $("#tb").find("li").click(function () {
                            window.open("<%=basePath%>report?biddingTypeId=" + $(this).children('div').html() + "&type=" + bidType + "&" + $("form").serialize());
                        });

                    }
                });
            }

           // alert('${method}');
            <c:if test="${method=='1'}">
            //alert(0);
            $("#chart-tab0").click();
            </c:if>
            <c:if test="${method=='2'}">
            $("#chart-tab1").click();
            </c:if>

            <c:if test="${method==null}">
            $("#chart-tab0").click();
            </c:if>
        });


        function createChart(biddingId) {
            var dataArray = [];
            var companyArray = [];
            $.ajax({
                type: "get",
                url: "<%=basePath%>report/charts",
                dataType: 'json',
                data: 'format=json&biddingId=' + biddingId,
                success: function (data) {
                    $.each(data.list, function (i, o) {
                        var d = {};
                        d.y = o.prePrice;
                        if (o.finalPrice != null && o.finalPrice > 0) {
                            d.y = o.finalPrice;
                            d.color = '#901010';
                        }
                        dataArray.push(d);
                        companyArray.push(o.company.companyName);
                    });

                    $('#container').highcharts({
                        title: {
                            text: '${param.title}中标价分析'
                        }, credits: {
                            enabled: false
                        },
                        yAxis: {
                            title: {
                                text: '金额(万元)'
                            }
                        },
                        xAxis: {
                            labels: {enabled: true, rotation: 290}
                        },
                        tooltip: {
                            formatter: function () {
                                var s;
                                if (this.point.name) { // the pie chart
                                    s = '' +
                                    this.point.name + ': ' + this.y + ' 万元';
                                } else {
                                    s = '' +
                                    this.x + ': ' + this.y + ' 万元';
                                }
                                return s;
                            }
                        },
                        labels: {
                            items: [
                                {
                                    html: '',
                                    style: {
                                        left: '40px',
                                        top: '8px',
                                        color: 'black'
                                    }
                                }
                            ]
                        },
                        series: [
                            {
                                type: 'column',
                                name: '投标金额', color: '#4572A7'
                            }

                        ]
                    });

                    chart = $('#container').highcharts();
                    chart.xAxis[0].setCategories(companyArray);
                    chart.series[0].setData(dataArray);
                    if (data.limitPrice) {

                        chart.yAxis[0].addPlotLine({
                            color: '#901010',
                            value: data.limitPrice,
                            width: 3,
                            zIndex: 100, label: {text: '<span  style="color:#901010;font-weight: bold">限价:' + data.limitPrice + '万元</span>', y: data.limitPrice > data.avgPrice ? -10 : 20, useHtml: true}

                        });
                    }

                    chart.yAxis[0].addPlotLine({
                        color: '#00ff00',
                        dashStyle: 'longdashdot',
                        value: data.avgPrice,
                        width: 3,
                        zIndex: 100, label: {text: '<span  style="color:#00ff00;font-weight: bold">均价:' + data.avgPrice + '万元</span>', align: 'right', y: data.limitPrice && data.limitPrice > data.avgPrice ? 20 : -10, useHtml: true}

                    });
                }
            });
        }

        var format = function (time, format) {
            if(!time)
              return "";
            var t = new Date(time);
            var tf = function (i) {
                return (i < 10 ? '0' : '') + i
            };
            return format.replace(/yyyy|MM|dd|HH|mm|ss/g, function (a) {
                switch (a) {
                    case 'yyyy':
                        return tf(t.getFullYear());
                        break;
                    case 'MM':
                        return tf(t.getMonth() + 1);
                        break;
                    case 'mm':
                        return tf(t.getMinutes());
                        break;
                    case 'dd':
                        return tf(t.getDate());
                        break;
                    case 'HH':
                        return tf(t.getHours());
                        break;
                    case 'ss':
                        return tf(t.getSeconds());
                        break;
                }
                ;
            });
        };
    </script>

    <style type="text/css">
        .ui-datepicker-title span {
            display: inline;
        }

        button.ui-datepicker-current {
            display: none;
        }

        .tongji td {
            font-weight: bold;
            background-color: #4A87C5;
        }

        .number_right {
            cursor:pointer;
            margin-left: 150px;
        }

        .table_5, .table_6 {
            margin-top: -9px;
            width: 101%;
        }

        .dTitle {
            width: 80px;
            float: left;
            line-height: 45px;
        }

        .table_5 .xh {
            width: 30px;
        }

        .table_5 th {
            background: #c9d6eb;
            text-align: center;
            font-weight: bold;
            border-right: #fff 1px solid;
        }

        .table_1 td, .table_2 td, .table_5 td, .table_5 th, .table_6 td {
            padding: 3px 5px;
        }

        .table_5 tr td {
            border-right: #fff 1px solid;
            border-bottom: #c9d6eb 1px solid;
        }

        .panel_8 .tit span {
            color: black;
        }

        #home_tabs_div {
            position: relative;
            right: 100px;
        }
    </style>

</head>

<body style="background-color: #f2f2f2;">

<div class="main">
    <!--Ctrl-->

    <div class="ctrl" style="">
        <jsp:include page="/navigation"/>
    </div>
    <!--Ctrl End-->


    <div class="pt45">
        <!--Filter-->
        <div class="filter">
            <div class="query">
                <%--
                <div class="p8 filter_search">
                    <form action="<%=basePath %>dashboard" id="" method="get">
                        <table width="100%" border="0" cellspacing="0" cellpadding="0">
                            <tr>
                                <td class="t_r">统计范围:</td>
                                <td style="width:65%">
                                    <input type="radio" name="dateRange" value="1"/><span
                                        style="display: inline;margin-right: 20px">最近一周</span>
                                    <input type="radio" name="dateRange" value="2"/><span
                                        style="display: inline;margin-right: 20px">最近一个月</span>
                                    <input type="radio" name="dateRange" value="3"/><span
                                        style="display: inline;margin-right: 20px">最近三个月</span>
                                    <input type="radio" name="dateRange" value="4" checked="checked"/><span
                                        style="display: inline;margin-right: 20px">今天</span>
                                </td>
                                <td><input type="submit" value="检索"
                                           style="width:50px;"></td>
                            </tr>
                        </table>
                    </form>
                </div>
                --%>
            </div>
        </div>
    </div>

    <!--Filter End-->
    <!--Table-->
    <!--  <s:set name="r" value="#request.pageResultSet.list"></s:set> -->

    <div class="panel_3 mb10" style="width:73%;float:left;">
        <header class="clearfix">
            <h5 class="fl file"> &nbsp; </h5>

            <div class="fr tabs_1 clearfix" id="home_tabs_div">
                <ul class="fl" id="home_tabs">
                    <li class="selected"><a href="#tabs-1" id="chart-tab0"><span>近期中标情况</span></a></li>
                    <li><a href="#tabs-2" id="chart-tab1"><span>近期开标计划</span></a></li>
                    <li><a href="#tabs-3" id="chart-tab2"><span>招标计划分布</span></a></li>
                    
                </ul>
            </div>
            <form action="<%=basePath %>dashboard" id="form" method="get">
                <input type="hidden" name="method" value="1"/> 
                <div id="date_range" style="position: relative; left: 2%;top:7px;display: none;">
                    统计范围：
                    <select name="dateRange" onchange="javascript:$('#form').submit()">
                        <option value="1">今天</option>
                        <option value="4">最近一周</option>
                        <option value="2" selected>最近一个月</option>
                        <option value="3">最近三个月</option>
                        <option value="5">最近半年</option>
                        <option value="6">更多</option>
                    </select>
                </div>
            </form>
            
            
            <div id="selectFor3" style="position: relative; left: 2%;top:7px; ">
                    统计范围：
            <select name="selectFor3" id="selectFor3data" onchange="selectFor3Mothed(this)">
            			<option value="">选择年份</option>
                        <option <c:if test="${year=='2011'}">selected=selected</c:if> value="2011">2011年</option>
						<option value="2012">2012年</option>
						<option value="2013">2013年</option>
						<option value="2014">2014年</option>
						<option <c:if test="${year=='2015'}">selected=selected</c:if> value="2015">2015年</option>
						<option <c:if test="${year=='2016'}">selected=selected</c:if>  value="2016">2016年</option>
						<option <c:if test="${year=='2017'}">selected=selected</c:if>  value="2017">2017年</option>
						<option <c:if test="${year=='2018'}">selected=selected</c:if>  value="2018">2018年</option>
						<option <c:if test="${year=='2019'}">selected=selected</c:if>  value="2019">2019年</option>
						<option <c:if test="${year=='2020'}">selected=selected</c:if>  value="2020">2020年</option>
           </select>
            </div>
        </header>
        <div id="main_div" class="con" style="height:520px;overflow-y:auto;width:99%">
            <div id="winBid" style="display:none;">
                <table class="table_5 mb10" >
                    <thead>
                    <tr>
                        <th class="t_c" style="font-weight:bold;" width="15%">线路</th>
                        <th class="t_c" style="font-weight:bold;" width="25%">标段名称</th>
                        <th class="t_c" style="font-weight:bold;" width="20%">标段类型</th>
                        <th class="t_c" style="font-weight:bold;" width="10%">中标金额</th>
                        <th class="t_c" style="font-weight:bold;" width="20%">中标单位</th>
                        <th class="t_c" style="font-weight:bold;" width="10%">中标时间</th>
                        <%--<th class="t_c" style="font-weight:bold;" width="20%">中标价分析</th>--%>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach items="${detail}" var="report" varStatus="status">
                                <tr style="cursor: pointer">
                                    <td>${report.routeName}
                                        <input type="hidden" name="biddingTypeId" value="${report["biddingTypeId"]}"/><input type="hidden" name="biddingPlanId" value="${report["biddingPlanId"]}"/></td>
                                    <td>${report["biddingName"] }</td>
                                    <td><span
                                            style="display: none;" name="biddingTypeDescription">${report["biddingTypeId"]}-${report["biddingType"]}</span>
                                    </td>
                                    <td style="text-align: right;">
                                        <fmt:formatNumber value="${report['finalPrice'] }" type="currency" pattern="0.0000"/>
                                    </td>
                                    <td>${report["company"] }</td>
                                    <td><fmt:formatDate value="${report['bidTime']}" pattern="yyyy-MM-dd"/>
                                        <%--<a href="#" class="t_c" onclick="createChart('${report['biddingId'] }');">--%>
                                            <%--分析 </a>--%>
                                    </td>
                                </tr>
                    </c:forEach>
                    </tbody>
                </table>
            </div>
            <div id="openBid" style="display:none;">
                <table class="table_5 mb10">
                    <thead>
                    <tr >
                        <th class="t_c" style="font-weight:bold;" width="100">线路</th>
                        <th class="t_c" style="font-weight:bold;" width="160">标段</th>
                        <th class="t_c" style="font-weight:bold;" width="130">标段类型</th>
                        <th class="t_c" style="font-weight:bold;" width="80">上网报名</th>
                        <th class="t_c" style="font-weight:bold;" width="80">资格预审</th>
                        <th class="t_c" style="font-weight:bold;" width="80">发标开始</th>
                        <th class="t_c" style="font-weight:bold;" width="80">发标截止</th>
                        <th class="t_c" style="font-weight:bold;" width="80">开标</th>
                        <th class="t_c" style="font-weight:bold;" width="80">技术评标</th>
                        <th class="t_c" style="font-weight:bold;" width="80">商务评标</th>
                    </tr>
                    </thead>
                    <tbody id="openBidBody">

                    </tbody>
                </table>
            </div>
			<div id="chartYearBid"  >
				<div id="chartsBySeason"  style="display: block;"></div>
				<div id="chartsBySeasonTable"  style="display: block;">
				<table width="100%" class="report_table " >
					<thead><tr><td>标段类型</td>
						<td>第一季度</td>
						<td>第二季度</td>
						<td>第三季度</td>
						<td>第四季度</td>
						<td>合计</td>
					</tr></thead>
					<tbody>
						
					</tbody>
				</table>
				</div>
				<div style="height: 50px"> </div>
				<div id="chartsByRoute"  style="display: block;"></div>
				<div id="chartsByRouteTable"  style="display: block;">
				<table width="100%" class="report_table " >
					<thead></thead>
					<tbody>
						
					</tbody>
				</table>
				</div>
			</div>
			
			<script type="text/javascript">
				function selectFor3Mothed(obj){
					var year = $(obj).val();
					var yearparm =year;
					if(year==""){
						year ="所有";
					}
			        $.ajax({
			        	 	type: "get",
			                url: "<%=basePath%>bidding/seasonReport",
			                dataType: 'json',
			                data: 'format=json&year='+yearparm,
			                success: function (data) {
			                	
			                	genChartsByYear(year,data.datas);
			                	
			                	var html ="";
			                	var last;
			                	var hjall=0;
			                	$.each(data.datas, function (i, value) {
			                		if(i==0){last = value.data;}
			                		html +="<tr>";
			                		html +="<td>"+value.name+"</td>";
			                		var hj =0;
			                		for(var k=0;k<value.data.length;k++){
			                			html +="<td>"+value.data[k]+"</td>";
			                			hj+=value.data[k];
			                			
			                			if(i!=0){
			                				last[k] = last[k]+value.data[k];
										}
			                		}
			                		html +="<td class=xhj>"+hj+"</td>";
			                		html +="</tr>";
			                		hjall +=hj;
			                	});
			                	
			                	if(last!=null){
			                		html +="<tr class=hj>";
			                		html +="<td>合计</td>";
			                		for(var k=0;k<last.length;k++){
			                			html +="<td>"+last[k]+"</td>";
			                		}
			                		html +="<td class=dhj>"+hjall+"</td>";
			                		html +="</tr>";
			                	}
			                	
			                	
			                	
			                	$("#chartsBySeasonTable table tbody").html(html);
			                	
			                }
			       	});
			        
			        $.ajax({
		        	 	type: "get",
		                url: "<%=basePath%>bidding/routeReport",
		                dataType: 'json',
		                data: 'format=json&year='+yearparm,
		                success: function (data) {
		                	var theadhtml ="<tr><td>线路名称</td>";
		                	$.each(data.categories, function (k, c) {
		                		theadhtml+="<td>"+c+"</td>";
		                	});
		                	theadhtml+="<td>合计</td></tr>";
		                	
		                	$("#chartsByRouteTable table thead").html(theadhtml);
		                	
		                	genChartsByRoute(year,data.datas,data.categories);
		                	
		                	var html ="";
		                	var last;
		                	var hjall=0;
		                	$.each(data.datas, function (i, value) {
		                		if(i==0){last = value.data;}
		                		html +="<tr>";
		                		html +="<td>"+value.name+"</td>";
		                		var hj =0;
		                		for(var k=0;k<value.data.length;k++){
		                			html +="<td>"+value.data[k]+"</td>";
		                			hj+=value.data[k];
		                			
		                			if(i!=0){
		                				last[k] = last[k]+value.data[k];
									}
		                		}
		                		html +="<td class=xhj>"+hj+"</td>";
		                		html +="</tr>";
		                		hjall +=hj;
		                	});
		                	
		                	if(last!=null){
		                		html +="<tr class=hj>";
		                		html +="<td>合计</td>";
		                		for(var k=0;k<last.length;k++){
		                			html +="<td>"+last[k]+"</td>";
		                		}
		                		html +="<td class=dhj>"+hjall+"</td>";
		                		html +="</tr>";
		                	}
		                	
		                	
		                	
		                	$("#chartsByRouteTable table tbody").html(html);
		                	
		                }
		       	});
					
				};
				/* 按季度统计的折线图 */
				function genChartsByYear(year,datas){ 
					
				  	$('#chartsBySeason').highcharts({
				        title: {
				            text: year+'年招标计划分布',
				            x: -20 ,//center
				            style: {
				                 fontWeight: 'bold',
				                 fontSize: '22px',
				             }
				        },
				       
				        xAxis: {
				            categories: [year+'年第一季度', year+'年第二季度', year+'年第三季度', year+'年第四季度'],
				          	/* plotLines:[{           
				                value:-0.5,            
				                width:1 ,
				                color: '#808080'            
				    		}], */
				    		 labels : {
				    			 	y:30,
					                rotation: 340, 
					                style: {
					                    /* fontStyle : 'italic', */
					                    fontSize: '12px',
					                    color:'#6E6E6E',
					                }
					             } 
				            
				        },
				       
				        yAxis: {
				            title: {
				                text: '标段数量',
				                rotation: 0,
				                offset: 80,
				            },
				            plotLines: [{
				                value: 0,
				                width: 1,
				                color: '#808080'
				            }],
				            labels : {
				               style: {
			                   	color:'#104E8B',
			                    fontSize: '12px',
			               		}
				            }
				            
				        },
				        tooltip: {
				            valueSuffix: ''
				        },
				        legend: {
				            layout: 'vertical',
				            align: 'right',
				            verticalAlign: 'middle',
				            borderWidth: 0
				        },
				        series: datas
				    });
				};
				/* 按线路统计的柱形图 */
				function genChartsByRoute(year,datas,categories){ 
				    $('#chartsByRoute').highcharts({
				        chart: {
				            type: 'column'
				        },
				        title: {
				            text: year+'年度招标计划总体情况',
				             style: {
				                 fontWeight: 'bold' ,
				                 fontSize: '22px',
				             }
				        },
				        xAxis: {
				            categories: categories,
				            labels : {
				            	y:30,
				            	rotation: 340, 
				                style: {
				                    fontSize: '12px',
				                    color:'#6E6E6E',
				                },
				             } ,
				             
				        },
				        yAxis: {
				            min: 0,
				            title: {
				                text: '标段数量',
				                rotation: 0,
				                offset: 80,
				            },
				            stackLabels: {
				                enabled: true,
				                style: {
				                    fontWeight: 'bold',
				                    color: (Highcharts.theme && Highcharts.theme.textColor) || 'gray'
				                }
				            },
				            labels : {
					               style: {
				                   	color:'#104E8B',
				                    fontSize: '12px',
				               		}
					            }
				        },
				        legend: {
				            align: 'right',
				            x: -70,
				            verticalAlign: 'top',
				            y: 20,
				            floating: true,
				            backgroundColor: (Highcharts.theme && Highcharts.theme.legendBackgroundColorSolid) || 'white',
				            borderColor: '#CCC',
				            borderWidth: 1,
				            shadow: false
				        },
				        tooltip: {
				            formatter: function() {
				                return '<b>'+ this.x +'</b><br/>'+
				                    this.series.name +': '+ this.y +'<br/>'+
				                    '总共: '+ this.point.stackTotal;
				            }
				        },
				        plotOptions: {
				            column: {
				                stacking: 'normal',
				                dataLabels: {
				                    enabled: true,
				                    color: (Highcharts.theme && Highcharts.theme.dataLabelsColor) || 'white',
				                    formatter:function(){
				                    	if(this.y==0){
				                    		return ;
				                    	} else{
				                    		return this.y;
				                    	} 
				                    }  
				                }
				            }
				        },
				        series: datas
				    });
				}			
			</script>
        </div>
    </div>


    <aside class="fr">
        <div class="panel_1">
            <div class="bg_2">
                <div class="bg_3" id="biddingTb">
                    <hgroup class="asideH stats_2">
                        <h5><b>近期中标一览表</b></h5>
                    </hgroup>
                    <ul class="stats_2 stats_2_bg1" style="line-height: 38px;">
                        <li class="blue">
                            <div style="display: none;">0</div>
                            <span class="dTitle" style="display:inline">勘察设计类</span>

                            <h1 class="mr5 L_08 number_right">${group[0]}</h1></li>
                        <li class="blue">
                            <div style="display: none;">1</div>
                            <span class="dTitle" style="display:inline">施工类</span>

                            <h1 class="mr5 L_08 number_right">${group[1]}</h1></li>
                        <li class="blue">
                            <div style="display: none;">2</div>
                            <span class="dTitle" style="display:inline">监理类</span>

                            <h1 class="mr5 L_08 number_right">${group[2]}</h1></li>
                        <li class="blue">
                            <div style="display: none;">3</div>
                            <span class="dTitle" style="display:inline">采购类</span>

                            <h1 class="mr5 L_08 number_right">${group[3]}</h1></li>
                        <li class="blue">
                            <div style="display: none;">3</div>
                            <span class="dTitle" style="display:inline">其他类</span>

                            <h1 class="mr5 L_08 number_right">${group[4]}</h1></li>
                    </ul>

                </div>
                <div class="bg_3" id="planTb" style="display: none;">
                    <hgroup class="asideH stats_2">
                        <h5><b>近期开标计划一览表</b></h5>
                    </hgroup>
                    <ul class="stats_2 stats_2_bg1" style="line-height: 38px;" id="rightUl">
                        <li class="blue">
                            <div style="display: none;">0</div>
                            <span class="dTitle" style="display:inline">上网报名</span>

                            <h1 class="mr5 L_08 number_right">${applyDateNum}</h1></li>
                        <li class="blue">
                            <div style="display: none;">1</div>
                            <span class="dTitle" style="display:inline">资格预审</span>

                            <h1 class="mr5 L_08 number_right">${checkDateNum}</h1></li>
                        <li class="blue">
                            <div style="display: none;">2</div>
                            <span class="dTitle" style="display:inline">发标开始</span>

                            <h1 class="mr5 L_08 number_right">${bidBeginNum}</h1></li>
                        <li class="blue">
                            <div style="display: none;">3</div>
                            <span class="dTitle" style="display:inline">发标截止</span>

                            <h1 class="mr5 L_08 number_right">${bidEndNum}</h1></li>
                        <li class="blue">
                            <div style="display: none;">4</div>
                            <span class="dTitle" style="display:inline">开标</span>

                            <h1 class="mr5 L_08 number_right">${tecOpenDateNum}</h1></li>
                        <li class="blue">
                            <div style="display: none;">5</div>
                            <span class="dTitle" style="display:inline">技术评标</span>

                            <h1 class="mr5 L_08 number_right">${tecAppraiseDateNum}</h1></li>
                        <li class="blue">
                            <div style="display: none;">6</div>
                            <span class="dTitle" style="display:inline">商务评标</span>

                            <h1 class="mr5 L_08 number_right">${bizAppraiseDateNum}</h1></li>

                    </ul>

                </div>
            </div>
        </div>
        <div class="panel_1" style="display: none;" id="biddingTypeDetail">
            <div class="bg_2">
                <div class="bg_3">
                    <hgroup class="asideH stats_2">
                        <h5><b id="biddingTypeName"></b></h5>
                    </hgroup>
                    <ul class="stats_2" style="line-height: 38px;" id="tb">
                    </ul>
                </div>
            </div>
        </div>
    </aside>


    <div id="container" style="width:74%;height:400px;"></div>
</div>


<jsp:include page="/biddingTypeTree"></jsp:include>
</body>
</html>