<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page import="com.wonders.stpt.bid.domain.vo.BidImportState"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8"/>
     <meta http-equiv="x-ua-compatible" content="IE-8" />
    <title>编辑招标计划导入
    </title>

    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/jquery-ui.css">
    <script src="${pageContext.request.contextPath}/js/jquery-1.10.2.js"></script>
    <script src="${pageContext.request.contextPath}/js/jquery-ui.js"></script>
       
   <link rel="stylesheet" href="${pageContext.request.contextPath}/css2/formalize.css"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css2/page.css"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css2/imgs.css"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css2/reset.css"/>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/js/uploadify/uploadify.css">
    <script src="${pageContext.request.contextPath}/js/uploadify/jquery.uploadify.js"></script>
    <!--[if IE 6.0]>
    <script src="js/iepng.js" type="text/javascript"></script>
    <script type="text/javascript">
        EvPNG.fix('div, ul, ol, img, li, input, span, a, h1, h2, h3, h4, h5, h6, p, dl, dt');
    </script>
    <![endif]-->
    <script src="${pageContext.request.contextPath}/js/html5.js"></script>

    <script src="${pageContext.request.contextPath}/js/show.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/flick/jquery.ui.datepicker-zh-CN.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath}/js/jQuery.timers.js"></script>
    <style type="text/css">
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

            $('#createTime').datepicker({
                //inline: true
                "changeYear": true
//                "showButtonPanel": true,
//                "closeText": '清除',

//                "currentText": 'createTime'//仅作为“清除”按钮的判断条件
            });
//            $('#planEndDate').datepicker({
                //inline: true
//                "changeYear": true
//                "showButtonPanel": true,
//                "closeText": '清除',

//                "currentText": 'planEndDate'//仅作为“清除”按钮的判断条件
//            });
            $('#appraiseDate').datepicker({
                //inline: true
                "changeYear": true
//                "showButtonPanel": true,
//                "closeText": '清除',

//                "currentText": 'appraiseDate'//仅作为“清除”按钮的判断条件
            });
            $('#fileEndDate').datepicker({
                //inline: true
                "changeYear": true
//                "showButtonPanel": true,
//                "closeText": '清除',

//                "currentText": 'fileEndDate'//仅作为“清除”按钮的判断条件
            });
           
            $("#navDiv").load("${pageContext.request.contextPath}/navigation", function () {
                $("#nav_ul > li").filter(function (index) {
                    return $(this).attr("name") == "bidding";
                }).addClass("selected");
            })



            $("#menu").menu();//biddingTypeId
            $("#menu a[name='selected']").click(function () {
                if ($(this).attr("title") == "5") {
                    $("#biddingType").attr("readonly", false);
                    $("#biddingType").focus();
                    $("#biddingType").val("");
                    $("#biddingTypeId").val("");
                } else {
                    $("#biddingType").attr("readonly", true);
                    $("#biddingType").blur();
                    $("#biddingType").val($(this).text());
                    $("#biddingTypeId").val($(this).attr("title"));
                }
            });
            $(".odd tr:odd").css("background", "#fafafa");
            //获取线路
            $.ajax({
                type: "GET",
                url: "${pageContext.request.contextPath}/route/routes",
                dataType: "json",
                data: 'format=json&pageSize=100000',
                success: function (data) {
                    var html = "<option value=''>--选择线路名称--</option>";
                    $.each(data.routes, function (i, value) {
                        //alert(value.routeName);
                        html += "<option value='" + value.routeId + "'>" + value.routeName + "</option>";
                    });

                    $("#routeId").empty();
                    $("#routeId").append(html);
                    var count = $("#routeId").children("option").length;
                    for (var i = 0; i < count; i++) {
                        if ($("#routeId").children("option:eq(" + i + ")").val() == $("#routeIds").val()) {
                            $("#routeId").children("option:eq(" + i + ")").attr("selected", true);
                        }
                    }
                }
            });
            //上报单位http://localhost:8070/bid/dictionary/dictionaries?format=json&id=1000000
            $.ajax({
                type: "GET",
                url: "${pageContext.request.contextPath}/dictionary/company/dicts",
                dataType: "json",
                data: 'format=json&pageSize=100000&id=1000000',
                success: function (data) {
                    var html = "<option value=''>--选择单位名称--</option>";
                    var dval = $("#companyId").attr("dvalue");
                    $.each(data.dictionaries, function (i, value) {
                        //alert(value.routeName);
                        if(value.dictId==dval){
                        	 html += "<option selected='selected' value='" + value.dictId + "'>" + value.dictName + "</option>";
                        }else{
                        	 html += "<option value='" + value.dictId + "'>" + value.dictName + "</option>";
                        }
                       
                    });

                    $("#companyId").empty();
                    $("#companyId").append(html);
                   
                }
            });


            
        });

        function shut() {
            window.opener = null;
            window.open("", "_self");
            window.close();
        }

        function checks() {
        	if($("#belongDateY").val()==""){
                alert("请选择所属年");
                return false;
            }
        	 if($("#belongDateM").val()==""){
                 alert("请选择所属月");
                 return false;
             }
            $("#belongDate").val($("#belongDateY").val()+"-"+$("#belongDateM").val()+"-01");
           /*  if($("#companyId").val()==""){
                alert("请选择上报单位");
                return false;
            } */
        	
            if($("#filePath").val()==""){
                alert("请上传招标计划文件");
                return false;
            }
           

            if ("" == $("#pageIndex").val())
                $("#pageIndex").val(1);
            
            $('#loading').dialog('open');
            return true;
        }

        
      //数据库文件导入数据库
        function importData(mainid,filePath) {
            //window.location = "${pageContext.request.contextPath}/bidimportmain/importData?mainId=" + mainid + "&filePath=" + filePath+ "";
            
            if (window.confirm("是否确认导入？")) {
            	location.href = '${pageContext.request.contextPath}/bidimportmain/importData?mainId='+mainid;
            	 //加载线路
                /* $.ajax({ //一个Ajax过程
                    type: "get", //以post方式与后台沟通
                    url: "${pageContext.request.contextPath}/bidimportmain/importData", //与此php页面沟通
                    dataType: 'json',//从php返回的值以 JSON方式 解释
                    data: 'format=json&pageSize=100000&mainId='+mainid+'&filePath='+filePath, //发给php的数据有两项，分别是上面传来的u和p
                    success: function (data) {//如果调用php成功
                    	
                    	//alert(data.bidImportMain.filePath);
                    location.href = '${pageContext.request.contextPath}/bidimportmain/'+mainid;
                 }}); */
                
            }
        	
        }
      

    function iFrameHeight() {

        var ifm= document.getElementById("bidImportIFrame");

        var subWeb = document.frames ? document.frames["bidImportIFrame"].document :ifm.contentDocument;

            if(ifm != null && subWeb != null) {

            ifm.height = subWeb.body.scrollHeight+10;

            }

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
		            <li class=""><a href="${pageContext.request.contextPath}/bidimportmain/bidImportMains">招标计划导入</a></li>
		            <li class="fin">编辑招标计划导入</li>
		        </ul>
		    </div>
		</div>
        <form method="post" action="${pageContext.request.contextPath}/bidimportmain/save">
            <input type="hidden" id="pageIndex" name="pageIndex" value="${pageIndex }">
            <input type="hidden" id="mainId" name="mainId" value="${bidImportMain.mainId }"/>
            <table width="100%" class="table_1">
                <thead>
                <th colspan="4" class="t_r">
                    &nbsp;</th>
                </thead>
                <tbody>
                <tr>
                    <td class="t_r lableTd" style="width:10%;">导入日期：</td>
                    <td style="width:30%;">
                        <input type="text" id="createTime" name="createTime" class="input_xxlarge"
                               value="<fmt:formatDate value="${bidImportMain.createTime }" pattern="yyyy-MM-dd"/>" readonly="readonly"/>
                    </td>
                    <td class="t_r lableTd" style="width:15%;">所属年月：</td>
                    <td style="width:45%;">
                     <select name="belongDateY" id="belongDateY">
                            <option value="2015" <c:if test="${bidImportMain.belongDateYear=='2015'}">selected='selected'</c:if>>2015</option>
                            <option value="2016" <c:if test="${bidImportMain.belongDateYear=='2016'}">selected='selected'</c:if>>2016</option>
                            <option value="2017" <c:if test="${bidImportMain.belongDateYear=='2017'}">selected='selected'</c:if>>2017</option>
                            <option value="2018" <c:if test="${bidImportMain.belongDateYear=='2018'}">selected='selected'</c:if>>2018</option>
                            <option value="2019" <c:if test="${bidImportMain.belongDateYear=='2019'}">selected='selected'</c:if>>2019</option>
                            <option value="2020" <c:if test="${bidImportMain.belongDateYear=='2020'}">selected='selected'</c:if>>2020</option>
                        </select>
                         <select name="belongDateM" id="belongDateM">
                            <option value="01" <c:if test="${bidImportMain.belongDateMonth=='01'}">selected='selected'</c:if>>01</option>
                            <option value="02" <c:if test="${bidImportMain.belongDateMonth=='02'}">selected='selected'</c:if>>02</option>
                            <option value="03" <c:if test="${bidImportMain.belongDateMonth=='03'}">selected='selected'</c:if>>03</option>
                            <option value="04" <c:if test="${bidImportMain.belongDateMonth=='04'}">selected='selected'</c:if>>04</option>
                            <option value="05" <c:if test="${bidImportMain.belongDateMonth=='05'}">selected='selected'</c:if>>05</option>
                            <option value="06" <c:if test="${bidImportMain.belongDateMonth=='06'}">selected='selected'</c:if>>06</option>
                            <option value="07" <c:if test="${bidImportMain.belongDateMonth=='07'}">selected='selected'</c:if>>07</option>
                            <option value="08" <c:if test="${bidImportMain.belongDateMonth=='08'}">selected='selected'</c:if>>08</option>
                            <option value="09" <c:if test="${bidImportMain.belongDateMonth=='09'}">selected='selected'</c:if>>09</option>
                            <option value="10" <c:if test="${bidImportMain.belongDateMonth=='10'}">selected='selected'</c:if>>10</option>
                            <option value="11" <c:if test="${bidImportMain.belongDateMonth=='11'}">selected='selected'</c:if>>11</option>
                            <option value="12" <c:if test="${bidImportMain.belongDateMonth=='12'}">selected='selected'</c:if>>12</option>
                        </select>
                       <input type="hidden" id="belongDate" name="belongDate" class="input_xxlarge"
                               value="<fmt:formatDate value="${bidImportMain.belongDate }" pattern="yyyy-MM-dd"/>" />
                    </td>
                </tr>
                <tr>
                    <td class="t_r lableTd" style="width:10%;">上报单位：</td>
                    <td style="width:30%;" >
                        <!-- <select id="routeId" name="routeId"  style="width:300px;">

                        </select> -->
                        <select name="companyId" id="companyId" dvalue="${bidImportMain.companyId }">
                            <option value="">--选择单位名称--</option>
                        </select>
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

                <tr>
                    <td class="t_r lableTd" >上传招标计划文件：</td>
                    <td colspan="3" id="importcontent">
                    
                    <div id="upload-file" ></div>
                    <table width="60%" id="upload-file-attachTable" class="table_1">
                            <tbody id="upload-file-attachmentList">
                            <tr class="tit">
                                <td class="t_c" style="width:10px; display:none;"><input type="checkbox" id="upload-filechkAll"></td>
                                <td class="t_c">文件名</td>
                                <td class="t_c">文件大小</td>
                                <td class="t_c" style="width:100px">操作</td>
                            </tr>
                            <c:if test="${bidImportMain.attachment.attachmentId!=null}">
										<tr class="${bidImportMain.attachment.attachmentId}">
											<td style="display: none;"><input type="hidden"
												name="attachments[1].removed"><input type="checkbox"
												checked="checked" name="attachments[1].attachmentId"
												value="aca5c22477f14e219d4188b8db63ef62"></td>
											<td class="t_c">
											<a href='${pageContext.request.contextPath}/attachment/${bidImportMain.attachment.attachmentId}' >
											${bidImportMain.attachment.attachName}
											</a></td>
											<td class="t_c">${bidImportMain.attachment.attachSize}</td>
											<td class="t_c"><a href="#" name="delBtn"
												onclick="renderAttachmentDel('${bidImportMain.attachment.attachmentId}',1)"
												class="mr5">删 除</a></td>
										</tr>
							</c:if>
									</tbody>
                     </table>
                    
                  <%--   <input type="button" value="导入数据库" onclick="return importData('${bidImportMain.mainId}','${bidImportMain.fileName}');" /> --%>
                    <input type="hidden" id="filePath" name="filePath" class="input_xxlarge" value="${bidImportMain.attachment.attachmentId}"/>
                    
                    </td>
                </tr>
                <tr>
                    <td class="t_r lableTd" >上传附件：</td>
                    <td colspan="3">
                         <div id="upload-files"></div>
	                    <table width="60%" id="upload-files-attachTable" class="table_1">
	                            <tbody id="upload-files-attachmentList">
	                            <tr class="tit">
	                                <td class="t_c" style="width:10px; display:none;"><input type="checkbox" id="upload-fileschkAll"></td>
	                                <td class="t_c">文件名</td>
	                                <td class="t_c">文件大小</td>
	                                <td class="t_c" style="width:100px">操作</td>
	                            </tr>
	
	                            </tbody>
	                     </table>
                    </td>
                </tr>
                
                
                </tbody>
                <tr class="tfoot">
                    <td colspan="4" class="t_r"><input id="save" type="submit" onclick="return checks();" value="保存"/>&nbsp;
                        <input type="button" value="后退"
                               onclick="location.href='${pageContext.request.contextPath}/bidimportmain/bidImportMains'"/>&nbsp;
                        <!-- <input type="reset" value="重 置"/>&nbsp; --></td>
                </tr>
                
            </table>
        </form>
    </div>
    <!--Table End-->
</div>
<script>
    $(function () {
        //renderAttachmentGrid();
        $("#upload-file").uploadify({
            height: 30,
            buttonText: '上传文件',
            swf: '${pageContext.request.contextPath}/js/uploadify/uploadify.swf',
            uploader: '${pageContext.request.contextPath}/attachment;jsessionid=${pageContext.request.session.id}',
            fileObjName: "filedata",
            fileTypeExts:"*.xls;*.xlsx;",
            multi:false,
            method : "POST",
           // uploadLimit:1,
            formData:{"attachType":"filePath","objectId":"${bidImportMain.mainId}","format":"json"},
            onUploadSuccess: function (file, data, response) {
            	$("#upload-file").hide();
            	$("#upload-file-queue").hide();
            	var att = eval("(" + data + ")");
            	$("#filePath").val(att.attachmentId);
            	writeAttachments(att,"upload-file");
            },
            overrideEvents : ['onUploadError', 'onSelectError' ],
            onUploadError : function(file, errorCode, errorMsg, errorString) {
                // 手工取消不弹出提示
                if (errorCode == SWFUpload.UPLOAD_ERROR.FILE_CANCELLED
                        || errorCode == SWFUpload.UPLOAD_ERROR.UPLOAD_STOPPED) {
                    return;
                }
                var msgText = "上传失败\n";
                switch (errorCode) {
                    case SWFUpload.UPLOAD_ERROR.HTTP_ERROR:
                        msgText += "HTTP 错误\n" + errorMsg;
                        break;
                    case SWFUpload.UPLOAD_ERROR.MISSING_UPLOAD_URL:
                        msgText += "上传文件丢失，请重新上传";
                        break;
                    case SWFUpload.UPLOAD_ERROR.IO_ERROR:
                        msgText += "IO错误";
                        break;
                    case SWFUpload.UPLOAD_ERROR.SECURITY_ERROR:
                        msgText += "安全性错误\n" + errorMsg;
                        break;
                    case SWFUpload.UPLOAD_ERROR.UPLOAD_LIMIT_EXCEEDED:
                        msgText += "每次最多上传 " + this.settings.uploadLimit + "个";
                        break;
                    case SWFUpload.UPLOAD_ERROR.UPLOAD_FAILED:
                        msgText += errorMsg;
                        break;
                    case SWFUpload.UPLOAD_ERROR.SPECIFIED_FILE_ID_NOT_FOUND:
                        msgText += "找不到指定文件，请重新操作";
                        break;
                    case SWFUpload.UPLOAD_ERROR.FILE_VALIDATION_FAILED:
                        msgText += "参数错误";
                        break;
                    default:
                        msgText += "文件:" + file.name + "\n错误码:" + errorCode + "\n"
                                + errorMsg + "\n" + errorString;
                }
                alert(msgText);
            return parameters;
        },onSelectError : function(file, errorCode, errorMsg) {
             var msgText = "上传失败\n";
            switch (errorCode) {
                case SWFUpload.QUEUE_ERROR.QUEUE_LIMIT_EXCEEDED:
                    //this.queueData.errorMsg = "每次最多上传 " + this.settings.queueSizeLimit + "个文件";
                    //msgText += "每次最多上传 " + this.settings.queueSizeLimit + "个文件";
                    break;
                case SWFUpload.QUEUE_ERROR.FILE_EXCEEDS_SIZE_LIMIT:
                    msgText += "文件大小超过限制( " + this.settings.fileSizeLimit + " )";
                    break;
                case SWFUpload.QUEUE_ERROR.ZERO_BYTE_FILE:
                    msgText += "文件大小为0";
                    break;
                case SWFUpload.QUEUE_ERROR.INVALID_FILETYPE:
                    msgText += "文件格式不正确，仅限 " + this.settings.fileTypeExts;
                    break;
                default:
                    msgText += "错误代码：" + errorCode + "\n" + errorMsg;
            }
            alert(msgText); 
        	return parameters;
        },
            onInit:function(){
            	if($("#filePath").val()!=''&&$("#upload-file-attachmentList tr").length>1){
            		$("#upload-file").hide();
            	}else{
            		$("#filePath").val("");
            		$("#upload-file").show();
            	}
            },
            width: 120
        });
        
        $("#upload-files").uploadify({
            height: 30,
            buttonText: '上传文件',
            swf: '${pageContext.request.contextPath}/js/uploadify/uploadify.swf',
            uploader: '${pageContext.request.contextPath}/attachment;jsessionid=${pageContext.request.session.id}',
            fileObjName: "filedata",
            multi:true,
           method : "POST",
            uploadLimit:999,
            formData:{"attachType":"filePaths","objectId":"${bidImportMain.mainId}","format":"json"},
            onUploadSuccess: function (file, data, response) {
            	//alert(data);
            	writeAttachments(eval("(" + data + ")"),"upload-files");
            },
            overrideEvents : ['onUploadError', 'onSelectError' ],
            onUploadError : function(file, errorCode, errorMsg, errorString) {
                // 手工取消不弹出提示
                if (errorCode == SWFUpload.UPLOAD_ERROR.FILE_CANCELLED
                        || errorCode == SWFUpload.UPLOAD_ERROR.UPLOAD_STOPPED) {
                    return;
                }
                var msgText = "上传失败\n";
                switch (errorCode) {
                    case SWFUpload.UPLOAD_ERROR.HTTP_ERROR:
                        msgText += "HTTP 错误\n" + errorMsg;
                        break;
                    case SWFUpload.UPLOAD_ERROR.MISSING_UPLOAD_URL:
                        msgText += "上传文件丢失，请重新上传";
                        break;
                    case SWFUpload.UPLOAD_ERROR.IO_ERROR:
                        msgText += "IO错误";
                        break;
                    case SWFUpload.UPLOAD_ERROR.SECURITY_ERROR:
                        msgText += "安全性错误\n" + errorMsg;
                        break;
                    case SWFUpload.UPLOAD_ERROR.UPLOAD_LIMIT_EXCEEDED:
                        msgText += "每次最多上传 " + this.settings.uploadLimit + "个";
                        break;
                    case SWFUpload.UPLOAD_ERROR.UPLOAD_FAILED:
                        msgText += errorMsg;
                        break;
                    case SWFUpload.UPLOAD_ERROR.SPECIFIED_FILE_ID_NOT_FOUND:
                        msgText += "找不到指定文件，请重新操作";
                        break;
                    case SWFUpload.UPLOAD_ERROR.FILE_VALIDATION_FAILED:
                        msgText += "参数错误";
                        break;
                    default:
                        msgText += "文件:" + file.name + "\n错误码:" + errorCode + "\n"
                                + errorMsg + "\n" + errorString;
                }
                alert(msgText);
           // return parameters;
        },onSelectError : function(file, errorCode, errorMsg) {
             var msgText = "上传失败\n";
            switch (errorCode) {
                case SWFUpload.QUEUE_ERROR.QUEUE_LIMIT_EXCEEDED:
                    //this.queueData.errorMsg = "每次最多上传 " + this.settings.queueSizeLimit + "个文件";
                    //msgText += "每次最多上传 " + this.settings.queueSizeLimit + "个文件";
                    break;
                case SWFUpload.QUEUE_ERROR.FILE_EXCEEDS_SIZE_LIMIT:
                    msgText += "文件大小超过限制( " + this.settings.fileSizeLimit + " )";
                    break;
                case SWFUpload.QUEUE_ERROR.ZERO_BYTE_FILE:
                    msgText += "文件大小为0";
                    break;
                case SWFUpload.QUEUE_ERROR.INVALID_FILETYPE:
                    msgText += "文件格式不正确，仅限 " + this.settings.fileTypeExts;
                    break;
                default:
                    msgText += "错误代码：" + errorCode + "\n" + errorMsg;
            }
            alert(msgText); 
        	//return parameters;
        },
            onInit:function(){
            	$.ajax({ //一个Ajax过程
        	        type: "get", //以get方式与后台沟通
        	        url: "${pageContext.request.contextPath}/attachment/typeList?attachType=filePaths&objectId=${bidImportMain.mainId}&rt="+new Date().getTime(), //
        	        dataType: 'json',//从php返回的值以 JSON方式 解释
        	        data: 'format=json', //发给php的数据有两项，分别是上面传来的u和p
        	        success: function (data) {//如果调用php成功
        	        	$.each( data.attachments, function(i, n){
        	        		writeAttachments(n,"upload-files");
        	        	});
        	        	
        	  }});
            },
            width: 120/* ,
          //返回一个错误，选择文件的时候触发  
            onSelectError:function(file, errorCode, errorMsg){  
            	alert(errorCode);
                switch(errorCode) {  
                    case -100:  
                        this.queueData.errorMsg = "上传的文件数量已经超出系统限制的"+$('#upload-files').uploadify('settings','queueSizeLimit')+"个文件！";  
                        break;  
                    case -110:  
                        //alert("文件 ["+file.name+"] 大小超出系统限制！");  
                        this.queueData.errorMsg = "文件 ["+file.name+"] 大小超出系统限制的"+$('upload-files').uploadify('settings','fileSizeLimit')+"大小！";  
                        break;  
                    case -120:  
                        //alert("文件 ["+file.name+"] 大小异常！");  
                        this.queueData.errorMsg = "文件 ["+file.name+"] 大小异常！";  
                       break;  
                    case -130:  
                        //alert("文件 ["+file.name+"] 类型不正确！");  
                        this.queueData.errorMsg = "文件 ["+file.name+"] 类型不正确！";  
                        break;  
                }  
                 
            } */
        });

    });
    
    function writeAttachments(obj,domid){
    	 $("#"+domid+"-attachTable").show();
         var i = $("#"+domid+"-attachmentList > tr").length;
         var $html =null;
         if(domid=='upload-file'){
             $html = $('<tr class='+obj.attachmentId+' ><td  style="display:none;"><input type="hidden" name="attachments['+i+'].removed"><input type="checkbox" name="attachments[' + i + '].attachmentId" checked="checked"></td><td  class="t_c"></td><td  class="t_c"></td><td class="t_c"><a class="mr5" onclick=renderAttachmentDel("'+obj.attachmentId+'",1)  name="delBtn" href="#">删 除</a></td></tr>');
         }else{
             $html = $('<tr class='+obj.attachmentId+' ><td  style="display:none;"><input type="hidden" name="attachments['+i+'].removed"><input type="checkbox" name="attachments[' + i + '].attachmentId" checked="checked"></td><td  class="t_c"></td><td  class="t_c"></td><td class="t_c"><a class="mr5" onclick=renderAttachmentDel("'+obj.attachmentId+'",0)  name="delBtn" href="#">删 除</a></td></tr>');
         }
         $("#"+domid+"-attachmentList").append($html);

         $html.find(":checkbox").val(obj.attachmentId);
         $html.find("td:eq(1)").html("<a href='${pageContext.request.contextPath}/attachment/"+obj.attachmentId+"' >"+obj.attachName+"</a>");
         $html.find("td:eq(2)").html(obj.attachSize);

         //renderAttachmentGrid();
    }

    function renderAttachmentDel(objid,flag) {
    	if(window.confirm("是否确认删除数据?")){
    		$('#loading').dialog('open');
    		if(flag==0){
    			$.ajax({ //一个Ajax过程
        	        type: "get", //以get方式与后台沟通
        	        url: "${pageContext.request.contextPath}/attachment/deleteById?attachmentId="+objid+"&rt="+new Date().getTime(), //
        	        dataType: 'json',//从php返回的值以 JSON方式 解释
        	        data: 'format=json', //发给php的数据有两项，分别是上面传来的u和p
        	        success: function (data) {//如果调用php成功
        	        	if(data.msg=='ok'){
        	        		$("."+objid).remove();
        	        	}
        	        	$('#loading').dialog('close');
        	   		}
        	     });
    		}else{
    			$.ajax({ //一个Ajax过程
        	        type: "get", //以get方式与后台沟通
        	        url: "${pageContext.request.contextPath}/bidimportmain/deleteAtta?mainId=${bidImportMain.mainId}&rt="+new Date().getTime(), //
        	        dataType: 'json',//从php返回的值以 JSON方式 解释
        	        data: 'format=json', //发给php的数据有两项，分别是上面传来的u和p
        	        success: function (data) {//如果调用php成功
        	        	if(data.msg=='ok'){
        	        		$("."+objid).remove();
        	        		$("#upload-file").show();
        	        		$("#filePath").val("");
        	        		
        	        	}else{
        	        		$("."+objid).remove();
        	        		$("#upload-file").show();
        	        		$("#filePath").val("");
        	        	}
        	        	$('#loading').dialog('close');
        	   		}
        	     });
    		}
    		
    	}

    }
</script>
</body>
</html>
