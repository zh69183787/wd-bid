<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta http-equiv="Content-Type" content="text/html;charset=UTF-8">
    <title>招投标汇总表</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/jquery-ui.css">
    <script src="${pageContext.request.contextPath}/js/jquery-1.10.2.js"></script>
    <script src="${pageContext.request.contextPath}/js/jquery-ui.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/flick/jquery.ui.datepicker-zh-CN.js"></script>
    <style>

        form span {
            margin-left: 10px;
        }

        table {
            border-spacing: 0px;
            table-layout: fixed;
        }

        .table * {
            list-style: none;
            margin: 0px;
            padding: 0px;
            font-size: 12px;
            line-height: 30px
        }

        .table {
            width: 100%;
            padding-top: 40px;
            diaplay:table
        }

        .table .bg_grey {
            background-color: #f6f6f6
        }

        .table .th {
            width: 320px
        }

        .table ul {
            display: inline-block;
        }

        .table ul.bzj {
            display: block;
        }

        .table li {
            text-align: center;/*clear:both;word-wrap:break-word;word-break:break-all;*/
            border-color: #ccc;
            border-style: solid;;
            border-width: 0px 1px 1px 0px;
            overflow: hidden;
            width: 250px;
        }

        .table li span {
            border-color: #ccc;
            border-style: solid;;
            border-width: 0px 0px 0px 1px;
        }

        .c_ul {
            width: 251px;float:left
        }

        .height22 {
            height: 30px
        }

        .height60 {
            height: 90px
        }

        .table ul.bzj .width32 {
            width: 24.5%
        }

        .jt_name li {
            width: 20px;
        }

        .jt_name dl, .table li.jt_name {
            float: left;
            width: 320px
        }

        .jt_name dt, .jt_name dd {
            height: 30px;
            overflow: hidden
        }

        .jt_name dt {
            width: 80px;
            float: left;
            text-align: left;
            border-bottom: 1px solid #ccc;
        }

        .jt_name dd {
            float: right;
            width: 233px;
            padding-left:5px;
            text-align: left;
            border-color: #ccc;
            border-style: solid;;
            border-width: 0px 0px 1px 1px;
        }

        .bzj li {
            float: left;
            text-align: center
        }

        .ui-menu {
            width: 250px;
        }
        .ui-datepicker-title span {display:inline;}
        button.ui-datepicker-current { display: none; }

    </style>
</head>
<body>
<div class="table" style="width:${fn:length(plans)*251+460}px">
    <ul style="float:left">
        <li class="height22 bg_grey th">线路</li>
        <li class="height60 bg_grey th">标段名称</li>
        <li class="height22 bg_grey th">上网报名</li>
        <li class="height22 bg_grey th">资格预审</li>
        <li class="height22 bg_grey th">发标开始</li>
        <li class="height22 bg_grey th">发标截止</li>
        <li class="height22 bg_grey th">限价（万元）</li>
        <li class="height22 bg_grey th">开标</li>
        <li class="height22 bg_grey th">技术评标</li>
        <li class="height22 bg_grey th">商务标开标</li>
        <li class="height22 bg_grey th">商务评标</li>
        <li class="height22 bg_grey th">投标单位</li>
        <li class="jt_name">
            <%--<ul>--%>
            <%--<li class="height22"></li>--%>
            <%--<li class="height22"></li>--%>
            <%--</ul>--%>
            <dl>
                <%--<dt><c:out--%>
                <%--value="${company.groups}"/></dt>--%>
                <%--<dd class="height22" id="r-<c:out value="${company.companyId}"/>"><c:out--%>
                <%--value="${company.companyName}"/></dd>--%>
                <dt id="companyDT"></dt>
                <dd class="height22" style="text-align: center;font-weight: bold;">小计</dd>
            </dl>
        </li>
    </ul>
    <c:forEach var="plan" varStatus="st" items="${plans}">
        <ul class="c_ul" id="c-<c:out value="${plan.biddingPlanId}"/>">
            <li class="height22"><c:out value="${plan.bidding.route.routeName}"/></li>
            <li class="height60"><c:out value="${plan.bidding.biddingName}"/></li>
            <li class="height22">
                        <fmt:formatDate value="${plan.applyDate}" pattern="yyyy年MM月dd日"/>

            </li>
            <li class="height22">
                <c:choose>
                    <c:when test="${plan.checkDate ==null || plan.checkDate == ''}">无资格预审</c:when>
                    <c:otherwise>
                        <fmt:formatDate value="${plan.checkDate}" pattern="yyyy年MM月dd日"/>
                    </c:otherwise>
                </c:choose>

            </li>
            <li class="height22"><fmt:formatDate value="${plan.bidBegin}" pattern="yyyy年MM月dd日"/></li>
            <li class="height22"><fmt:formatDate value="${plan.bidEnd}" pattern="yyyy年MM月dd日"/></li>
            <li class="height22">
                <c:choose>
                    <c:when test="${plan.limitPrice ==null || plan.limitPrice == 0}">无限价</c:when>
                    <c:otherwise>
                        <fmt:formatNumber value="${plan.limitPrice}" pattern="#,###.0000"/>
                    </c:otherwise>
                </c:choose>

            </li>
            <li class="height22"><fmt:formatDate value="${plan.tecOpenDate}" pattern="yyyy年MM月dd日"/></li>
            <li class="height22"><fmt:formatDate value="${plan.tecAppraiseDate}" pattern="yyyy年MM月dd日"/></li>
            <li class="height22"><fmt:formatDate value="${plan.bizOpenDate}" pattern="yyyy年MM月dd日"/></li>
            <li class="height22"><fmt:formatDate value="${plan.bizAppraiseDate}" pattern="yyyy年MM月dd日"/></li>
            <li class="height22  bg_grey" style="float:left">
                <ul class="bzj">
                    <li class="width32" >报名</li>
                    <li class="width32">资审</li>
                    <li class="width32">投标价</li>
                    <li class="width32" style="border-right: medium none;">中标价</li>
                </ul>
            </li>

        </ul>
    </c:forEach>
</div>

<div style="position:fixed; background-color:#fff; height:47px; border-bottom:1px solid #ccc; width:100%; top:0px">
    <div style="float:left;margin-top:8px;">
        <input type="submit" value="筛 选" id="sx" style="line-height:20px;width:50px;height: 25px"/>
        <input type="button" id="exportBtn" value="导 出" style="line-height:20px;width:50px;height: 25px"/>
    </div>
    <div style="float:right;margin-top:8px;">
        <c:if test="${pageInfo.pageIndex==1 }">
            <input type="button" value="上 页" disabled="disabled" style="line-height:20px;width:50px;height: 25px"/>
        </c:if>
        <c:if test="${pageInfo.pageIndex>1 }">
            <input type="button" value="上 页" onclick="goPage(${pageInfo.pageIndex},1)"
                   style="line-height:20px;width:50px;height: 25px"/>
        </c:if>
        <c:if test="${pageInfo.pageIndex==pageInfo.totalPages }">
            <input type="button" value="下 页" disabled="disabled" style="line-height:20px;width:50px;height: 25px"/>
        </c:if>
        <c:if test="${pageInfo.pageIndex<pageInfo.totalPages }">
            <input type="button" value="下 页" onclick="goPage(${pageInfo.pageIndex},2)"
                   style="line-height:20px;width:50px;height: 25px"/>
        </c:if>
    </div>
    <%--</form>--%>
</div>
<div id="dialog-message" title="筛选条件">
<form method="get" action="${pageContext.request.contextPath}/report">

<input type="hidden" id="pageSize" name="pageSize" value=" ${pageInfo.pageSize }"/>
<input type="hidden" id="pageIndex" name="pageIndex" value="${pageInfo.pageIndex } "/>
<table width="98%" class="table_1">
<tr>
    <td class="t_r lableTd" style="width:100px;"><span>线路类型：</span></td>
    <td class="t_c" style="width:30%;"><select name="bidding.route.routeType">
        <option value="">选择路线类型</option>
        <option value="1">新线</option>
        <option value="2">在建</option>
    </select></td>

    <td class="t_r lableTd" style="width:100px;" ><span>线路：</span></td>
    <td class="t_c" style="width:20%;"><select name="routeIds">
        <option value="">选择路线</option>
    </select></td>


</tr>
<tr>
<td class="t_r lableTd" style="width:100px;"><span>标段：</span></td>
<td class="t_c" style="width:20%;">
    <%--<select name="biddingId">--%>
    <%--<option value="">选择标段</option>--%>
    <%--</select>--%>
    <input type="text"  name="bidding.biddingName" class="input_xxlarge"
           value="${bidPlan.bidding.biddingType}"
           style="width:50%;"/>
</td>
<td class="t_r lableTd"><span>标段类型：</span></td>
<td>
<%--<ul id="menu">--%>
<%--<li><a href="#" title="">选择标段类型</a>--%>
<%--<ul>--%>
<%--<li><a href="#" title="1">勘察设计类</a>--%>
<%--<ul>--%>
<%--<li><a href="#" title="11">设计 </a>--%>
<%--<ul>--%>
<%--<li><a href="#" title="111">总体总包全线设计</a>--%>
<%--<ul>--%>
<%--<li><a name="selected" href="#" title="1111">总体总包及全部设计项目</a></li>--%>
<%--</ul>--%>
<%--</li>--%>
<%--<li><a href="#" title="112">总体总包及部分分项设计</a>--%>
<%--<ul>--%>
<%--<li><a name="selected" href="#" title="1121">总体总包及部分分项设计</a></li>--%>
<%--<li><a name="selected" href="1122#" title="1122">分项设计（土建）</a></li>--%>
<%--<li><a name="selected" href="#" title="1123">分项设计（机电）</a></li>--%>
<%--</ul>--%>
<%--</li>--%>
<%--</ul>--%>
<%--</li>--%>
<%--<li><a href="#" title="12">勘察</a>--%>
<%--<ul>--%>
<%--<li><a href="#" title="121">车站及区间详勘</a>--%>
<%--<ul>--%>
<%--<li><a name="selected" href="#" title="1211">车站/区间</a></li>--%>
<%--</ul>--%>
<%--</li>--%>
<%--<li><a href="#" title="122">停车场（车辆段）详勘</a>--%>
<%--<ul>--%>
<%--<li><a name="selected" href="#" title="1221">段场</a></li>--%>
<%--</ul>--%>
<%--</li>--%>
<%--</ul>--%>

<%--</li>--%>
<%--</ul>--%>
<%--</li>--%>


<%--<li><a href="#" title="2">施工类</a>--%>
<%--<ul><!-- class="ui-state-disabled"  -->--%>
<%--<li><a href="#" title="21">土建</a>--%>
<%--<ul>--%>
<%--<li><a href="#" title="211">车站及区间</a>--%>
<%--<ul>--%>
<%--<li><a name="selected" href="#" title="2111">车站</a></li>--%>
<%--<li><a name="selected" href="#" title="2112">区间</a></li>--%>
<%--<li><a name="selected" href="#" title="2113">车站及区间</a></li>--%>
<%--</ul>--%>
<%--</li>--%>
<%--<li><a href="#" title="212">车站装修</a>--%>
<%--<ul>--%>
<%--<li><a name="selected" href="#" title="2121">车站装修</a></li>--%>
<%--<li><a name="selected" href="#" title="2122">车站装修及安装</a></li>--%>
<%--</ul>--%>
<%--</li>--%>
<%--<li><a href="#" title="213">停车场</a>--%>
<%--<ul>--%>
<%--<li><a name="selected" href="#" title="2131">房建</a></li>--%>
<%--<li><a name="selected" href="#" title="2132">市政</a></li>--%>
<%--<li><a name="selected" href="#" title="2133">绿化</a></li>--%>
<%--</ul>--%>
<%--</li>--%>
<%--<li><a name="selected" href="#" title="214">主变电所土建(不含电力外线）</a></li>--%>
<%--<li><a name="selected" href="#" title="215">轨道</a></li>--%>
<%--<li><a name="selected" href="#" title="216">导向标志</a></li>--%>
<%--<li><a name="selected" href="#" title="217">声屏障</a></li>--%>
<%--<li><a name="selected" href="#" title="218">道路</a></li>--%>
<%--<li><a name="selected" href="#" title="219">桥梁</a></li>--%>
<%--<li><a name="selected" href="#" title="21A">区间旁通道</a></li>--%>
<%--<li><a href="#" title="21B">监测</a>--%>
<%--<ul>--%>
<%--<li><a name="selected" href="#" title="21B1">施工监测</a></li>--%>
<%--<li><a name="selected" href="#" title="21B2">轴线复测</a></li>--%>
<%--<li><a name="selected" href="#" title="21B3">材料检测</a></li>--%>
<%--<li><a name="selected" href="#" title="21B4">桩基检测</a></li>--%>
<%--<li><a name="selected" href="#" title="21B5">钢轨探伤</a></li>--%>
<%--<li><a name="selected" href="#" title="21B6">后期沉降监测</a></li>--%>
<%--</ul>--%>
<%--</li>--%>
<%--<li><a href="#" title="21C">预制构件</a>--%>
<%--<ul>--%>
<%--<li><a name="selected" href="#" title="21C1">梁制作</a></li>--%>
<%--<li><a name="selected" href="#" title="21C2">管片</a></li>--%>
<%--<li><a name="selected" href="#" title="21C3">预制轨枕</a></li>--%>
<%--</ul>--%>
<%--</li>--%>
<%--<li><a name="selected" href="#" title="21D">出入口顶盖</a></li>--%>
<%--</ul>--%>
<%--</li>--%>
<%--<li><a href="#" title="22">机电</a>--%>
<%--<ul>--%>
<%--<li><a name="selected" href="#" title="221">车站风水电设备</a></li>--%>
<%--<li><a name="selected" href="#" title="222">主变电所设备</a></li>--%>
<%--<li><a name="selected" href="#" title="223">通信（含PIS、传输系统、CCTV)</a></li>--%>
<%--<li><a name="selected" href="#" title="224">无线通信（直放站、漏缆、手持台）</a></li>--%>
<%--<li><a name="selected" href="#" title="225">信号</a></li>--%>
<%--<li><a name="selected" href="#" title="226">防灾报警/设备监控/门警系统</a></li>--%>
<%--<li><a name="selected" href="#" title="227">气体灭火</a></li>--%>
<%--<li><a name="selected" href="#" title="228">接触网/干线电缆/防迷流</a></li>--%>
<%--<li><a name="selected" href="#" title="229">自动售检票设备</a></li>--%>
<%--<li><a name="selected" href="#" title="22A">牵引/降压变电所</a></li>--%>
<%--<li><a name="selected" href="#" title="22B">屏蔽门（安全门）</a></li>--%>
<%--<li><a name="selected" href="#" title="22C">停车场(车辆段)工艺设备</a></li>--%>
<%--</ul>--%>
<%--</li>--%>
<%--</ul>--%>
<%--</li>--%>

<%--<li><a href="#" title="3">监理</a>--%>
<%--<ul><!-- class="ui-state-disabled"  -->--%>
<%--<li><a href="#" title="31">土建</a>--%>
<%--<ul>--%>
<%--<li><a name="selected" href="#" title="311">车站及区间（含地下区间旁通道）</a></li>--%>
<%--<li><a name="selected" href="#" title="312">停车场（市政、房建、绿化）</a></li>--%>
<%--<li><a name="selected" href="#" title="313">主变电所</a></li>--%>
<%--<li><a name="selected" href="#" title="314">轨道</a></li>--%>
<%--<li><a name="selected" href="#" title="315">声屏障</a></li>--%>
<%--<li><a name="selected" href="#" title="316">道路</a></li>--%>
<%--<li><a name="selected" href="#" title="317">桥梁</a></li>--%>
<%--<li><a name="selected" href="#" title="318">人防门/防火门</a></li>--%>
<%--<li><a href="#" title="219">预制构件</a>--%>
<%--<ul>--%>
<%--<li><a name="selected" href="#" title="3191">梁制作</a></li>--%>
<%--<li><a name="selected" href="#" title="3192">管片</a></li>--%>
<%--</ul>--%>
<%--</li>--%>
<%--</ul>--%>
<%--</li>--%>
<%--<li><a href="#" title="32">机电</a>--%>
<%--<ul>--%>
<%--<li><a name="selected" href="#" title="321">车站装修、风水电设备安装</a></li>--%>
<%--<li><a name="selected" href="#" title="322">通信（含PIS、传输系统、CCTV)，含无线</a></li>--%>
<%--<li><a name="selected" href="#" title="323">信号</a></li>--%>
<%--<li><a name="selected" href="#" title="324">气体灭火/防灾报警/设备监控/门警系统</a></li>--%>
<%--<li><a name="selected" href="#" title="325">接触网/干线电缆/防迷流</a></li>--%>
<%--<li><a name="selected" href="#" title="326">自动售检票设备</a></li>--%>
<%--<li><a name="selected" href="#" title="327">屏蔽门/安全门/自动扶梯/垂直电梯</a></li>--%>
<%--<li><a name="selected" href="#" title="328">牵引/降压变电所</a></li>--%>
<%--<li><a name="selected" href="#" title="329">停车场/车辆段工艺设备</a></li>--%>
<%--</ul>--%>
<%--</li>--%>
<%--</ul>--%>
<%--</li>--%>

<%--<li><a href="#" title="4">采购</a>--%>
<%--<ul><!-- class="ui-state-disabled"  -->--%>
<%--<li><a href="#" title="41">土建</a>--%>
<%--<ul>--%>
<%--<li><a href="#" title="411">装饰材料</a>--%>
<%--<ul>--%>
<%--<li><a name="selected" href="#" title="4111">扣件</a></li>--%>
<%--<li><a name="selected" href="#" title="4112">顶部材料</a></li>--%>
<%--<li><a name="selected" href="#" title="4113">墙面材料</a></li>--%>
<%--<li><a name="selected" href="#" title="4114">地面材料</a></li>--%>
<%--<li><a name="selected" href="#" title="4115">灯具</a></li>--%>
<%--<li><a name="selected" href="#" title="4116">防火门</a></li>--%>
<%--<li><a name="selected" href="#" title="4117">人防门</a></li>--%>
<%--<li><a name="selected" href="#" title="4118">客服中心</a></li>--%>
<%--</ul>--%>
<%--</li>--%>
<%--<li><a href="#" title="412">辅助设施</a>--%>
<%--<ul>--%>
<%--<li><a name="selected" href="#" title="4121">座椅、垃圾箱</a></li>--%>
<%--</ul>--%>
<%--</li>--%>
<%--</ul>--%>
<%--</li>--%>
<%--<li><a href="#" title="42">机电</a>--%>
<%--<ul>--%>
<%--<li><a name="selected" href="#" title="421">车辆</a></li>--%>
<%--<li><a name="selected" href="#" title="422">信号</a></li>--%>
<%--<li><a name="selected" href="#" title="423">停车场工艺设备</a></li>--%>
<%--<li><a href="#" title="424">主变电所</a>--%>
<%--<ul>--%>
<%--<li><a name="selected" href="#" title="4241">110KV GIS(台/间隔)</a></li>--%>
<%--<li><a name="selected" href="#" title="4242">110KV/35KV 变压器</a></li>--%>
<%--<li><a name="selected" href="#" title="4243">35KV GIS</a></li>--%>
<%--</ul>--%>
<%--</li>--%>
<%--<li><a href="#" title="425">牵引降压变电所</a>--%>
<%--<ul>--%>
<%--<li><a name="selected" href="#" title="2451">35KV GIS开关</a></li>--%>
<%--<li><a name="selected" href="#" title="4252">1500V 直流开关</a></li>--%>
<%--<li><a name="selected" href="#" title="4253">整流变压器</a></li>--%>
<%--<li><a name="selected" href="#" title="4254">400V 开关柜</a></li>--%>
<%--<li><a name="selected" href="#" title="4255">35KV/400V 动力变压器</a></li>--%>
<%--<li><a name="selected" href="#" title="4256">400V有缘滤波及无功补偿装置</a></li>--%>
<%--<li><a name="selected" href="#" title="4257">UPS装置</a></li>--%>
<%--</ul>--%>
<%--</li>--%>
<%--<li><a href="#" title="426">环控</a>--%>
<%--<ul>--%>
<%--<li><a name="selected" href="#" title="4261">单向轴流风机</a></li>--%>
<%--<li><a name="selected" href="#" title="4262">可逆轴流风机</a></li>--%>
<%--<li><a name="selected" href="#" title="4253">组合式空调箱</a></li>--%>
<%--<li><a name="selected" href="#" title="4264">冷水机组</a></li>--%>
<%--<li><a name="selected" href="#" title="4265">冷却塔</a></li>--%>
<%--</ul>--%>
<%--</li>--%>
<%--<li><a href="#" title="427">动力照明</a>--%>
<%--<ul>--%>
<%--<li><a name="selected" href="#" title="4271">环控电控柜</a></li>--%>
<%--<li><a name="selected" href="#" title="4272">部分动力柜</a></li>--%>
<%--<li><a name="selected" href="#" title="4273">变频柜</a></li>--%>
<%--</ul>--%>
<%--</li>--%>
<%--<li><a href="#" title="428">自动售检票</a>--%>
<%--<ul>--%>
<%--<li><a name="selected" href="#" title="4281">售票机/检票机</a></li>--%>
<%--<li><a name="selected" href="#" title="4281">票卡</a></li>--%>
<%--</ul>--%>
<%--</li>--%>
<%--<li><a href="#" title="429">电梯</a>--%>
<%--<ul>--%>
<%--<li><a name="selected" href="#" title="4291">自动扶梯</a></li>--%>
<%--<li><a name="selected" href="#" title="4192">垂直电梯</a></li>--%>
<%--</ul>--%>
<%--</li>--%>
<%--</ul>--%>
<%--</li>--%>
<%--</ul>--%>
<%--</li>--%>

<%--<li><a name="selected" href="#" title="5">其他</a>--%>
<%--</ul>--%>

<%--</li>--%>
<%--</ul>--%>
<%--<input type="hidden" id="biddingTypeId" name="bidding.biddingTypeId" value="${param.biddingTypeId}"/>--%>
<input type="text" id="biddingType"  name="bidding.biddingType" class="input_xxlarge"
       value="${bidPlan.bidding.biddingType}"
       style="width:100%;"/>
</td>

</tr>
<tr>

    <td class="t_r lableTd" ><span>投标单位：</span></td>
    <td ><input style="width:175px;" type="text" name="companyName" value="${bidCompany.companyName}"></td>
    <td class="t_r lableTd" ><span>集团名称：</span></td>
    <td >
        <select name="groups">
            <option value="">选择集团</option>
            <c:forEach  step="1" begin="0" end="${fn:length(groups)}" varStatus="i">
                <option <c:if test="${groups[i.index] == param.groups}"> selected="selected" </c:if> value="${groups[i.index]}">${groups[i.index]}</option>
            </c:forEach>
        </select>
    </td>
</tr>
<tr>
    <td class="t_r lableTd" ><span>开标时间：</span></td>
    <td colspan="3"><input type="text" style="margin-top: 5px;"  readonly="readonly" id="beginOpenDate" name="beginOpenDate" value="<fmt:formatDate value="${bidPlan.beginOpenDate }" pattern="yyyy-MM-dd"/>"  />至<input readonly="readonly" type="text" id="endOpenDate" name="endOpenDate" value="<fmt:formatDate value="${bidPlan.endOpenDate }" pattern="yyyy-MM-dd"/>"  /></td>
</tr>
</table>


<%--style="width:200px;line-height: 25px;padding: 3px;margin-top: 3px;"/>--%>
</div>
</body>
<script>
    //跳转到制定页
    function goPage(pageNo, type) {
        //type=1,跳转到上一页
        if (type == "1") {
            $("#pageIndex").val(parseInt($("#pageIndex").val()) - 1);
        }
        //type=2,跳转到下一页
        if (type == "2") {
            $("#pageIndex").val(parseInt($("#pageIndex").val()) + 1);
            //alert($("#pageNo").val());
        }

        if (true) {//校验
            $("form").submit();
        }

    }

    var $route = $("select[name='routeIds']");
    //    var $bidding = $("select[name='biddingId']");
    $(function () {

        $('#beginOpenDate').datepicker({
            //inline: true
            "changeYear": true,
            "showButtonPanel": false,
            "closeText": '清除',
            "currentText": 'beginOpenDate'//仅作为“清除”按钮的判断条件
        });

        //$("#indicatorDate").datepicker('option', $.datepicker.regional['zh-CN']);
        $('#endOpenDate').datepicker({
            //inline: true
            "changeYear": true,
            "showButtonPanel": false,
            "closeText": '清除',
            "currentText": 'endOpenDate'//仅作为“清除”按钮的判断条件
        });

        //datepicker的“清除”功能
        $(".ui-datepicker-close").click(function () {
            if ($(this).parent("div").children("button:eq(0)").text() == "beginOpenDate") $("#beginOpenDate").val("");
            if ($(this).parent("div").children("button:eq(0)").text() == "endOpenDate") $("#endOpenDate").val("");
        });


        $("#exportBtn").click(function () {
            location.href = "${pageContext.request.contextPath}/report/export?" + $("form").serialize()
        });

        $("#sx").click(function () {
            $("#dialog-message").dialog("open");
        });
        $("#dialog-message").dialog({
            autoOpen: false,
            modal: false,
            width: 1000,
            height: 380,
            buttons: {
                "确定": function () {

                    $("form").submit();
                    $(this).dialog("close");
                },
                "关闭": function () {
                    $(this).dialog("close");
                }
            },
            close: {
                "关闭": function () {
                    $(this).dialog("close");
                }
            }
        });

        $route.change(function () {
//            $("[name=biddingId]").removeAttr("disabled");
//
//            if ($route.val().length > 1) {
//                $("[name=biddingId]").attr("disabled", "disabled");
//            } else {
//                loadBidding();
//            }
        });
        $("#menu").menu();//biddingTypeId
        $("#menu a").click(function () {
            if ("选择标段类型" == $(this).text())
                $("#biddingType").val("");
            else if($(this).attr("title") == "5"){
                $("#biddingType").focus();
                $("#biddingType").val("");
            }
            else{
                $("#biddingType").val($(this).text());
                $("#biddingType").blur();
            }
            if($(this).attr("title") == "5"){
                $("#biddingType").attr("readonly",false);
            }else{
                $("#biddingType").attr("readonly",true);
            }
        });
        $(".jt_name").css("border-bottom", "none");
        $(".bzj li:last-child").css("border-right", "none");

        $("select[name='bidding.route.routeType']").val('${param['bidding.route.routeType']}');
        $("select[name='companyId']").val('${param['companyId']}');
        loadBidResults('${param.companyId}', '${param.groups}', '${param.companyName}');
        $.get('${pageContext.request.contextPath}/route/routes?format=json&pageSize=10000', function (data) {

            $route.find("option:gt(0)").remove();
            $.each(data.routes, function (i, obj) {
                $route.append("<option value='" + obj.routeId + "'>" + obj.routeName + "</option>");
            });

            <c:if test ="${param['routeIds'] != null && param['routeIds'] != ''}">
            $("select[name='routeIds']").val('${param['routeIds']}');

//            loadBidding();
            </c:if>

        }, "json");


//        $route.change(function () {
//            loadBidding();
//
//        });
    });
    function loadBidding() {
        $.get('${pageContext.request.contextPath}/bidding/biddings', {"format": "json", "routeIds": $route.val()}, function (data) {
            $bidding.find("option:gt(0)").remove();
            $.each(data.biddings, function (i, obj) {
                $bidding.append("<option value='" + obj.biddingId + "'>" + obj.biddingName + "</option>");

            });

            $("select[name='biddingId']").val('${param['biddingId']}');
        }, "json");
    }

    function loadBidResults(companyId, groups, companyName) {

        $.post('${pageContext.request.contextPath}/report/bidResults', {"biddingPlanIds": "<c:out value="${planIds}"/>", "companyId": companyId, "company.groups": groups, "company.companyName": companyName, "format": "json"}, function (data) {
            var sdata = data.statistics;
            data = data.bidResults;
            var $cul = $(".c_ul");

            if(!data){
                return;
            }
            $.each(data, function (i, obj) {


                var cid = "#c-" + obj.biddingPlanId;
                var rid = "#r-" + obj.companyId;
                if ($(rid).length == 0) {
                    var html = "<dt>" + obj.company.groups + "</dt><dd class='height22' id='r-" + obj.companyId + "'>" + obj.company.companyName + "</dd>"
                    $("#companyDT").before(html);
                    for(var m = 0;m<$cul.length;m++){
                        $($cul[m]).append('<li class="height22" style="float:left"><ul class="bzj"><li class="width32">&nbsp;</li><li class="width32">&nbsp;</li><li class="width32" style="text-align: right;">&nbsp;</li><li class="width32" style="text-align: right;border-right: medium none;">&nbsp;</li></ul></li>')

                    }
                }


                var x = $(cid).index();
                var y = Math.floor($(rid).index() / 2);
//                console.log(x+","+y);
//                console.log($(cid).children()[(y+12)]);
                var $a = $($(cid).children()[(y + 12)]);
                $a.find("li:eq(0)").text("报名");
                $a.find("li:eq(1)").html(obj.isApplicant + "&nbsp;");
                if(obj.prePrice>0)
                    $a.find("li:eq(2)").html(obj.prePrice.toFixed(4) + "&nbsp;");
                if(obj.finalPrice>0)
                    $a.find("li:eq(3)").html(obj.finalPrice.toFixed(4) + "&nbsp;");
            });


            for(var m = 0;m<$cul.length;m++){
                $($cul[m]).append('<li class="height22"><ul class="bzj"><li class="width32">&nbsp;</li><li class="width32">&nbsp;</li><li class="width32" style="text-align: right;">&nbsp;</li><li class="width32" style="text-align: right;border-right: medium none;">&nbsp;</li></ul></li>')

            }
            $.each(sdata, function (i, obj) {
                var cid = "#c-" + obj.biddingPlanId;
                var $a = $($(cid).children()[$(cid).children().length-1]);
                $a.find("li:eq(0)").text(obj.applyNum);
                $a.find("li:eq(1)").html(obj.isApplicant + "&nbsp;");
                $a.find("li:eq(2)").html(obj.prePrice + "&nbsp;");
                $a.find("li:eq(3)").html(obj.finalPrice.toFixed(4) + "&nbsp;");
            });
        }, "json");
    }
</script>
</html>