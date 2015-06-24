<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c" %>
<!doctype html>
<html lang="en">
<head>
    <meta charset="utf-8"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/formalize.css"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/page.css"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/default/imgs.css"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/reset.css"/>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/js/uploadify/uploadify.css">
    <script src="${pageContext.request.contextPath}/js/jquery-1.7.1.js"></script>
    <script src="${pageContext.request.contextPath}/js/uploadify/jquery.uploadify.min.js"></script>

</head>
<div class="main">
    <!--Ctrl-->
    <div class="ctrl clearfix">
        <div class="fl"><img id="show" onclick="showHide();" src="${pageContext.request.contextPath}/css2/default/images/sideBar_arrow_right.jpg" width="46" height="30" alt="收起"></div>
        <div class="posi fl">
            <ul>
                <li><a href="${pageContext.request.contextPath}/match/matches">专项主题</a></li>
                <li class="fin">专项主题表单</li>
            </ul>
        </div>
        <div style="display:none;" class="fr lit_nav nwarp">
            <ul>
                <li class="selected"><a class="print" href="#">打印</a></li>
                <li><a class="express" href="#">导出数据</a></li>
                <li class="selected"><a class="table" href="#">表格模式</a></li>
                <li><a class="treeOpen" href="#">打开树</a></li>
                <li><a class="filterClose" href="#">关闭过滤</a></li>
            </ul>
        </div>
    </div>
    <!--Ctrl End-->
    <!--Filter--><!--Filter End-->
    <!--Table-->

    <div class="mb10 pt45">
        <form  method="post">
            <table width="100%"  class="table_1">
                <thead>
                <th colspan="4" class="t_r">
                    &nbsp;</th>
                </thead>
                <tbody>


                <tr>
                    <td class="t_r lableTd">附件：</td>
                    <td colspan="3">
                        <div id="upload-file"></div>
                        <table width="60%" id="attachTable" class="table_1">
                            <tbody id="attachmentList">
                            <tr class="tit">
                                <td class="t_c" style="width:10px; display:none;"><input type="checkbox" id="chkAll"></td>
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
                </tr>

            </table>
        </form>
    </div>
    <!--Table End-->
</div>
<script>
    $(function () {
        renderAttachmentGrid();
        $("#upload-file").uploadify({
            height: 30,
            buttonText: '上传文件',
            swf: '${pageContext.request.contextPath}/js/uploadify/uploadify.swf',
            uploader: '${pageContext.request.contextPath}/attachment?format=json;JSESSIONID=${pageContext.request.session.id}',
            fileObjName: "filedata",
            onUploadSuccess: function (file, data, response) {
                $("#attachTable").show();
                var i = $("#attachmentList > tr").length;
                var $html = $('<tr><td  style="display:none;"><input type="hidden" name="attachments['+i+'].removed"><input type="checkbox" name="attachments[' + i + '].attachmentId" checked="checked"></td><td  class="t_c"></td><td  class="t_c"></td><td class="t_c"><a class="mr5"  name="delBtn" href="#">取 消</a></td></tr>');
                $("#attachmentList").append($html);

                data = eval("(" + data + ")").attachment;
                $html.find(":checkbox").val(data.attachmentId);
                $html.find("td:eq(1)").html(data.attachName);
                $html.find("td:eq(2)").html(data.attachSize);

                renderAttachmentGrid();
            },
            width: 120
        });


    });

    function renderAttachmentGrid() {
        var $delBtn = $(".tablebox").find("a[name=delBtn]");
        $delBtn.click(function () {
            var $this = $(this);
//            $.confirm("是否确认删除数据?", function () {
//
//                var $hid =$this.parents("tr td:first :hidden[name$=removed]");
//                $hid.val("1");
//                $this.parents("tr").hide();
//            })
        });

    }
</script>
</body>

</html>