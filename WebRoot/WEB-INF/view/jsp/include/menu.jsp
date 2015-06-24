<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2014/11/4
  Time: 15:58
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<script type="text/javascript">
$(document).ready(function(){
 		
	
	
    /* $('#biddingTypeId > option[value=${bidding.biddingTypeId}]').prop("selected",true);

    var bidding = $("#menu a[title=${bidding.biddingTypeId}]").text();
    $("#menu a[title='']").text(bidding);
    $( "#menu" ).menu();//biddingTypeId
    $( "#menu a" ).click(function(){
        $("a[title='']").text($(this).text());
        $("#biddingTypeId").val($(this).attr("title"));
    }); */
	$( "#loading" ).dialog({
	      autoOpen: false,
	      show: {
	        effect: "blind",
	        duration: 5
	      },
	      title: '提示',
	      modal: true,
	      hide: {
	        effect: "explode",
	        duration: 500
	      }
	    });
	
	$('#loading').parent().find('.ui-button').hide();
	
	 
 });
 
 //  绑定类型选择
 function bidTypeMenu(objId,width){
	 if(width==null||width==''){width="250";}
	 var mainid = objId+"menuAjax";
	 var roothtml = "<ul id='"+mainid+"' style='width:"+width+"px'><li class='menuAjaxRoot'><a href='#' fullname='' title=''>选择招标类型</a></li></ul>";
	 $("#"+objId).parent().append(roothtml);
	 var fnlen = $("#"+objId).parent().find("input[name='fullTypeName']").length;
	 if(fnlen<1){
		 var dftn =  $("#"+objId).attr("fullname");
		 $("#"+objId).parent().append("<input type='hidden' name='fullTypeName' value='"+dftn+"' />");
	 }
	 
	 var typeId = $("#"+objId).val();
	 
	    $.ajax({ //一个Ajax过程
	        type: "get", //以get方式与后台沟通
	        url: "${pageContext.request.contextPath}/dictionary/bidTypes/dicts", //
	        dataType: 'json',//从php返回的值以 JSON方式 解释
	        data: 'format=json', //发给php的数据有两项，分别是上面传来的u和p
	        success: function (data) {//如果调用php成功
	        	
	        	var html = writeMenuHtml(data.dictionaries);
	        	$("#"+mainid+" .menuAjaxRoot").append(html);
	        	//console.log(data);
	        	//alert(0);
	        	$("#"+objId+" > option[value='"+typeId+"']").prop("selected",true);

	    	    var bidding = $("#"+mainid+" a[title='"+typeId+"']").text();
	    	    $("#"+mainid+" a[title='']").text(bidding);
	    	    $( "#"+mainid+"" ).menu();//biddingTypeId
	    	    $( "#"+mainid+" a" ).click(function(){
	    	    	if($(this).attr("fullname")==''){
	    	    		$("a[title='']").text('选择招标类型');
		    	        $("#"+objId).val('');
		    	        $("#"+objId).parent().find("input[name='fullTypeName']").val('');
	    	    	}else{
	    	    		$("a[title='']").text($(this).text());
		    	        $("#"+objId).val($(this).attr("title"));
		    	        $("#"+objId).parent().find("input[name='fullTypeName']").val($(this).attr("fullname"));
	    	    	}
	    	        
	    	    });
	  }});
	 
 }
 
 function menuReste(objId){
	 var mainid = objId+"menuAjax";
	 $("#"+objId).val("");
	 $("#"+objId).parent().find("input[name='fullTypeName']").val("");
	 $("#"+mainid+" a[title='']").text("选择招标类型");
 }
 
 function writeMenuHtml(objs){
	 if(objs==null){ return "";}
	 var html ="<ul>";
	$.each(objs, function(i, n){
		html +="<li><a name='selected' href='#' fullname='"+n.dictFullName+"' title='"+n.dictFullCode+"'>"+n.dictName+"</a>"+writeMenuHtml(n.children,"")+"</li>";
	});
	html +="</ul>";
	return html;
 }

 function resetSearch(formid,selectIDS){
	 $("#"+formid+" select").each(function(i,n){
		 if($(n).attr("defaultval")){
			 $(n).val($(n).attr("defaultval"));
		 }else{
			 $(n).val("");
		 }
	 });//val("");
	 $("#"+formid+" input[type='text']").each(function(i,n){
		 if($(n).attr("defaultval")){
			 $(n).val($(n).attr("defaultval"));
		 }else{
			 $(n).val("");
		 }
	 });//.val("");
	 
	 if(selectIDS!=null&&selectIDS!=""){
		 var ids = selectIDS.split(",");
		 for(var i=0;i<ids.length;i++){
			 menuReste(ids[i]);
		 }
	 }
	 
	
	
 }
</script>
<div id="loading" style="border: 1px solid #808080; width: 300px; height: 50px; display: ;">
      
            <ul style="float: left; margin-top: 35px; margin-left: 35px;">正在加载</ul>
            <ul style="float: left;"><img alt="" src="${pageContext.request.contextPath}/image/loading-gif.gif" width="100" /></ul>
            <ul style="float: left; margin-top: 35px;">请稍等...</ul>
</div>

<ul id="menu" style="width:250px">
<li><a href="#" title="">选择标段类型</a>
<ul>
<li><a href="#" title="1">勘察设计类</a>
    <ul>
        <li><a href="#" title="11">设计 </a>
            <ul>
                <li><a href="#" title="111">总体总包全线设计</a>
                    <ul>
                        <li><a name="selected" href="#" title="1111">总体总包及全部设计项目</a></li>
                    </ul>
                </li>
                <li><a href="#" title="112">总体总包及部分分项设计</a>
                    <ul>
                        <li><a name="selected" href="#" title="1121">总体总包及部分分项设计</a></li>
                        <li><a name="selected" href="#" title="1122">分项设计（土建）</a></li>
                        <li><a name="selected" href="#" title="1123">分项设计（机电）</a></li>
                    </ul>
                </li>
            </ul>
        </li>
        <li><a href="#" title="12">勘察</a>
            <ul>
                <li><a href="#" title="121">车站及区间详勘</a>
                    <ul>
                        <li><a name="selected" href="#" title="1211">车站/区间</a></li>
                    </ul>
                </li>
                <li><a href="#" title="123">车站详勘</a>
                    <ul>
                        <li><a name="selected" href="#" title="1231">水文地质勘察</a></li>
                    </ul>
                </li>
                <li><a href="#" title="122">停车场（车辆段）详勘</a>
                    <ul>
                        <li><a name="selected" href="#" title="1221">段场</a></li>
                    </ul>
                </li>
            </ul>

        </li>
    </ul>
</li>


<li><a href="#" title="2">施工类</a>
    <ul><!-- class="ui-state-disabled"  -->
        <li><a href="#" title="21">土建</a>
            <ul>
                <li><a href="#" title="211">车站及区间</a>
                    <ul>
                        <li><a name="selected" href="#" title="2111">车站</a></li>
                        <li><a name="selected" href="#" title="2112">区间</a></li>
                        <li><a name="selected" href="#" title="2113">车站及区间</a></li>
                    </ul>
                </li>
                <li><a href="#" title="212">车站装修</a>
                    <ul>
                        <li><a name="selected" href="#" title="2121">车站装修</a></li>
                        <li><a name="selected" href="#" title="2122">车站装修及安装</a></li>
                    </ul>
                </li>
                <li><a href="#" title="213">停车场</a>
                    <ul>
                        <li><a name="selected" href="#" title="2131">房建</a></li>
                        <li><a name="selected" href="#" title="2132">市政</a></li>
                        <li><a name="selected" href="#" title="2133">绿化</a></li>
                        <li><a name="selected" href="#" title="2134">房建及市政</a></li>
                    </ul>
                </li>
                <li><a name="selected" href="#" title="214">主变电所土建(不含电力外线）</a></li>
                <li><a name="selected" href="#" title="215">轨道</a></li>
                <li><a name="selected" href="#" title="216">导向标志</a></li>
                <li><a name="selected" href="#" title="217">声屏障</a></li>
                <li><a name="selected" href="#" title="218">道路</a></li>
                <li><a name="selected" href="#" title="219">桥梁</a></li>
                <li><a name="selected" href="#" title="21A">区间旁通道</a></li>
                <li><a href="#" title="21B">监测</a>
                    <ul>
                        <li><a name="selected" href="#" title="21B1">环境监测</a></li>
                        <li><a name="selected" href="#" title="21B2">轴线复测</a></li>
                        <li><a name="selected" href="#" title="21B3">材料检测</a></li>
                        <li><a name="selected" href="#" title="21B4">桩基检测</a></li>
                        <li><a name="selected" href="#" title="21B5">钢轨探伤</a></li>
                        <li><a name="selected" href="#" title="21B6">后期沉降监测</a></li>
                    </ul>
                </li>
                <li><a href="#" title="21C">预制构件</a>
                    <ul>
                        <li><a name="selected" href="#" title="21C1">梁制作</a></li>
                        <li><a name="selected" href="#" title="21C2">管片</a></li>
                        <li><a name="selected" href="#" title="21C3">预制轨枕</a></li>
                    </ul>
                </li>
                <li><a name="selected" href="#" title="21D">出入口顶盖</a></li>
                <li><a name="selected" href="#" title="21E">其他</a></li>
            </ul>
        </li>
        <li><a href="#" title="22">机电</a>
            <ul>
                <li><a name="selected" href="#" title="221">车站风水电设备</a></li>
                <li><a name="selected" href="#" title="222">主变电所设备</a></li>
                <li><a name="selected" href="#" title="223">通信（含PIS、传输系统、CCTV)</a></li>
                <li><a name="selected" href="#" title="224">无线通信（直放站、漏缆、手持台）</a></li>
                <li><a name="selected" href="#" title="225">信号</a></li>
                <li><a name="selected" href="#" title="226">防灾报警/设备监控/门警系统</a></li>
                <li><a name="selected" href="#" title="227">气体灭火</a></li>
                <li><a name="selected" href="#" title="228">接触网/干线电缆/防迷流</a></li>
                <li><a name="selected" href="#" title="229">自动售检票设备</a></li>
                <li><a name="selected" href="#" title="22A">牵引/降压变电所</a></li>
                <li><a name="selected" href="#" title="22B">屏蔽门（安全门）</a></li>
                <li><a name="selected" href="#" title="22C">停车场(车辆段)工艺设备</a></li>
                <li><a name="selected" href="#" title="22D">防灾报警/设备监控/门警系统/气体灭火</a></li>
                <li><a name="selected" href="#" title="22E">接触网/干线电缆/防迷流/牵引/降压变电所</a></li>
                <li><a name="selected" href="#" title="22F">停车场/车辆段工艺设备/屏蔽门/安全门/自动扶梯/垂直电梯</a></li>
                <li><a name="selected" href="#" title="22G">其他</a></li>





            </ul>
        </li>
    </ul>
</li>

<li><a href="#" title="3">监理类</a>
    <ul><!-- class="ui-state-disabled"  -->
        <li><a href="#" title="31">土建</a>
            <ul>
                <li><a name="selected" href="#" title="311">车站及区间（含地下区间旁通道）</a></li>
                <li><a name="selected" href="#" title="312">停车场（市政、房建、绿化）</a></li>
                <li><a name="selected" href="#" title="313">主变电所</a></li>
                <li><a name="selected" href="#" title="314">轨道</a></li>
                <li><a name="selected" href="#" title="315">声屏障</a></li>
                <li><a name="selected" href="#" title="316">道路</a></li>
                <li><a name="selected" href="#" title="317">桥梁</a></li>
                <li><a name="selected" href="#" title="318">人防门/防火门</a></li>
                <li><a href="#" title="219">预制构件</a>
                    <ul>
                        <li><a name="selected" href="#" title="3191">梁制作</a></li>
                        <li><a name="selected" href="#" title="3192">管片</a></li>
                    </ul>
                </li>
            </ul>
        </li>
        <li><a href="#" title="32">机电</a>
            <ul>
                <li><a name="selected" href="#" title="321">车站装修、风水电设备安装</a></li>
                <li><a name="selected" href="#" title="322">通信（含PIS、传输系统、CCTV)，含无线</a></li>
                <li><a name="selected" href="#" title="323">信号</a></li>
                <li><a name="selected" href="#" title="324">气体灭火/防灾报警/设备监控/门警系统</a></li>
                <li><a name="selected" href="#" title="325">接触网/干线电缆/防迷流</a></li>
                <li><a name="selected" href="#" title="326">自动售检票设备</a></li>
                <li><a name="selected" href="#" title="327">屏蔽门/安全门/自动扶梯/垂直电梯</a></li>
                <li><a name="selected" href="#" title="328">牵引/降压变电所</a></li>
                <li><a name="selected" href="#" title="329">停车场/车辆段工艺设备</a></li>
            </ul>
        </li>
    </ul>
</li>

<li><a href="#" title="4">采购类</a>
    <ul><!-- class="ui-state-disabled"  -->
        <li><a href="#" title="41">土建</a>
            <ul>
                <li><a href="#" title="411">装饰材料</a>
                    <ul>
                        <li><a name="selected" href="#" title="4111">扣件</a></li>
                        <li><a name="selected" href="#" title="4112">顶部材料</a></li>
                        <li><a name="selected" href="#" title="4113">墙面材料</a></li>
                        <li><a name="selected" href="#" title="4114">地面材料</a></li>
                        <li><a name="selected" href="#" title="4115">灯具</a></li>
                        <li><a name="selected" href="#" title="4116">防火门</a></li>
                        <li><a name="selected" href="#" title="4117">人防门</a></li>
                        <li><a name="selected" href="#" title="4118">客服中心</a></li>
                    </ul>
                </li>
                <li><a href="#" title="412">辅助设施</a>
                    <ul>
                        <li><a name="selected" href="#" title="4121">座椅、垃圾箱</a></li>
                    </ul>
                </li>
            </ul>
        </li>
        <li><a href="#" title="42">机电</a>
            <ul>
                <li><a name="selected" href="#" title="421">车辆</a>
                    <ul>
                        <li><a name="selected" href="#" title="4211">整车采购</a></li>
                        <li><a name="selected" href="#" title="4212">电气传动系统</a></li>
                    </ul>
                </li>
                <li><a name="selected" href="#" title="422">信号</a></li>
                <li><a name="selected" href="#" title="423">停车场工艺设备</a></li>
                <li><a href="#" title="424">主变电所</a>
                    <ul>
                        <li><a name="selected" href="#" title="4241">110KV GIS(台/间隔)</a></li>
                        <li><a name="selected" href="#" title="4242">110KV/35KV 变压器</a></li>
                        <li><a name="selected" href="#" title="4243">35KV GIS</a></li>
                    </ul>
                </li>
                <li><a href="#" title="425">牵引降压变电所</a>
                    <ul>
                        <li><a name="selected" href="#" title="2451">35KV GIS开关</a></li>
                        <li><a name="selected" href="#" title="4252">1500V 直流开关</a></li>
                        <li><a name="selected" href="#" title="4253">整流变压器</a></li>
                        <li><a name="selected" href="#" title="4254">400V 开关柜</a></li>
                        <li><a name="selected" href="#" title="4255">35KV/400V 动力变压器</a></li>
                        <li><a name="selected" href="#" title="4256">400V有缘滤波及无功补偿装置</a></li>
                        <li><a name="selected" href="#" title="4257">UPS装置</a></li>
                    </ul>
                </li>
                <li><a href="#" title="426">环控</a>
                    <ul>
                        <li><a name="selected" href="#" title="4261">单向轴流风机</a></li>
                        <li><a name="selected" href="#" title="4262">可逆轴流风机</a></li>
                        <li><a name="selected" href="#" title="4266">单向轴流风机及可逆轴流风机</a></li>
                        <li><a name="selected" href="#" title="4253">组合式空调箱</a></li>
                        <li><a name="selected" href="#" title="4264">冷水机组</a></li>
                        <li><a name="selected" href="#" title="4265">冷却塔</a></li>
                    </ul>
                </li>
                <li><a href="#" title="427">动力照明</a>
                    <ul>
                        <li><a name="selected" href="#" title="4271">环控电控柜</a></li>
                        <li><a name="selected" href="#" title="4272">部分动力柜</a></li>
                        <li><a name="selected" href="#" title="4273">变频柜</a></li>
                    </ul>
                </li>
                <li><a href="#" title="428">自动售检票</a>
                    <ul>
                        <li><a name="selected" href="#" title="4281">售票机/检票机</a></li>
                        <li><a name="selected" href="#" title="4281">票卡</a></li>
                    </ul>
                </li>
                <li><a href="#" title="429">电梯</a>
                    <ul>
                        <li><a name="selected" href="#" title="4291">自动扶梯</a></li>
                        <li><a name="selected" href="#" title="4192">垂直电梯</a></li>
                        <li><a name="selected" href="#" title="4193">自动扶梯及垂直电梯</a></li>

                    </ul>
                </li>
                <li><a href="#" name="selected" title="430">复合风管</a></li>
                <li><a href="#" name="selected" title="431">综合桥架</a></li>
            </ul>
        </li>
    </ul>
</li>

<li><a name="selected" href="#" title="5">其他</a>
</ul>

</li>
</ul>
