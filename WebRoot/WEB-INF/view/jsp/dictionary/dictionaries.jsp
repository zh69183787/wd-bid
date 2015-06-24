<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html lang="cn">
<head>
    <meta charset="utf-8"/>
    <title>数据字典</title>
    <script src="${pageContext.request.contextPath}/js/jquery-1.7.1.js"></script>
    <script src="${pageContext.request.contextPath}/js/html5.js"></script>
    
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/tree/style.css" type="text/css">
    
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css2/formalize.css"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css2/page.css"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css2/imgs.css"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css2/reset.css"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/jquery-ui.css">
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/tree/jquery.tree.core.min.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/tree/jquery.tree.excheck.min.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/tree/jquery.tree.exedit.js"></script>
    <style>
        .ztree li span.button.add {
            margin-left: 2px;
            margin-right: -1px;
            background-position: -144px 0;
            vertical-align: top;
            *vertical-align: middle
        }
        .ztree span {
            display: inline;
        }
    </style>
</head>

<body style="background-color: #f2f2f2;">

<div class="main">
    <div class="ctrl clearfix">
        <jsp:include page="/navigation"/>
    </div>
    <div class="pt45" >
    	<div class="ctrl clearfix nwarp" style="margin-top: 48px;margin-bottom:0px;">
		<div class="fl"><img src="../images/sideBar_arrow_left.jpg" width="46" height="30" alt="收起"></div>
		    <div class="posi fl">
		        <ul>
		            <li><a href="#">首页</a></li>
		            <li class="fin">数据字典</li>
		        </ul>
		    </div>
		</div>
        <div>
            <ul id="tree" class="ztree" style="background-color:white;"></ul>
        </div>
    </div>

</div>

<script>
    <!--
    var setting = {
        async: {
            enable: true, type: "get",
            url: "${pageContext.request.contextPath}/dictionary/dictionaries?format=json",
            autoParam: ["id"],
            dataFilter: filter
        },
        view: {expandSpeed: "",
            addHoverDom: addHoverDom,
            removeHoverDom: removeHoverDom,
            selectedMulti: false
        },
        edit: {
            enable: true
        },
        data: {
            simpleData: {
                enable: true
            }
        },
        callback: {
            beforeRemove: beforeRemove,
            beforeRename: beforeRename,
            onNodeCreated: function (event, treeId, treeNode) {
            },
            onRename: function (event, treeId, treeNode, isCancel) {
                var dictOrder = 0;
                if (treeNode.getPreNode())
                    dictOrder = treeNode.getPreNode().dictOrder;
                $.ajax({ //一个Ajax过程
                    type: "post",
                    url: "${pageContext.request.contextPath}/dictionary",
                    dataType: 'json',
                    data: 'format=json&dictId=' + treeNode.id + "&dictName=" + treeNode.name + "&parentNo=" + treeNode.pId + "&dictNo=" + treeNode.dictNo + "&dictType=" + treeNode.dictType + "&dictOrder=" + (dictOrder + 1),
                    success: function (data) {
                        treeNode.id = data.dictionary.dictId;
                        treeNode.dictOrder = data.dictionary.dictOrder;
                        alert("保存成功!");
                    }
                });
            }
        }
    };

    var newCount;
    function filter(treeId, parentNode, childNodes) {
        if (!childNodes.root) return null;
        var array = [];
        newCount = newCount || childNodes.maxNo;
        for (var i = 0, l = childNodes.root.length; i < l; i++) {
            var node = {};
            node.name = childNodes.root[i].name.replace(/\.n/g, '.');
            node.id = childNodes.root[i].id;
            node.isParent = childNodes.root[i].isParent;
            node.dictType = childNodes.root[i].dictType;
            node.dictNo = childNodes.root[i].dictNo;
            node.dictOrder = childNodes.root[i].dictOrder;
            array.push(node);
        }
        return array;
    }
    function beforeRemove(treeId, treeNode) {
        var zTree = $.fn.zTree.getZTreeObj("tree");
        zTree.selectNode(treeNode);
        $.ajax({ //一个Ajax过程
        type: "post",
        url: "${pageContext.request.contextPath}/dictionary",
        dataType: 'json',
        data: 'format=json&_method=delete&dictId=' + treeNode.id,
        success: function (data) {
        alert("删除成功!");

        }
        });
        if (treeNode.pId)
            return confirm("确认删除 节点 -- " + treeNode.name + " 吗？");
        else
            return false;
    }
    function beforeRename(treeId, treeNode, newName) {
        if (newName.length == 0) {
            alert("节点名称不能为空.");
            return false;
        }
        return true;
    }

    function addHoverDom(treeId, treeNode) {
        var sObj = $("#" + treeNode.tId + "_span");
        if (treeNode.editNameFlag || $("#addBtn_" + treeNode.tId).length > 0) return;
        var addStr = "<span class='button add' id='addBtn_" + treeNode.tId
                + "' title='add node' onfocus='this.blur();'></span>";
        sObj.after(addStr);
//        console.log("add   " + "#addBtn_" + treeNode.id);
        var btn = $("#addBtn_" + treeNode.tId);
        if (btn) btn.bind("click", function () {
            var zTree = $.fn.zTree.getZTreeObj("tree");
            if (treeNode.id == "") {
                alert("请先修改节点名称");
            } else {
                newCount = newCount + 1;
                zTree.addNodes(treeNode, {id: "", pId: treeNode.id, name: "请输入节点名称" + (newCount), dictType: treeNode.dictType, dictNo: (newCount)});
            }
            return false;
        });
    }
    function removeHoverDom(treeId, treeNode) {
//         console.log("remove   " + "#addBtn_" + treeNode.id);
        $("#addBtn_" + treeNode.tId).unbind().remove();
    }

    $(function () {

        $("#nav_ul > li").filter(function (index) {
            return $(this).attr("name") == "base";
        }).addClass("selected");
        $.fn.zTree.init($("#tree"), setting);

    });
    //-->
</script>
</body>
</html>