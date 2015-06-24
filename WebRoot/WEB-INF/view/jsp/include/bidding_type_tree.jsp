<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2015/2/10
  Time: 9:45
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title></title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/tree/style.css" type="text/css">
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/tree/jquery.tree.core.min.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/data/bidding_type_tree.js"></script>
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
    <script>
        $(function () {
            $.fn.zTree.init($("#biddingTypeTree"), {}, biddingTypeData);
            $("span[name=biddingTypeDescription]").each(function (i, o) {
                var txt = $(o).text().split("-");
                var v = txt[0];
                if (v.length > 1) {
                    $(o).parent().text(getSelectedNodeName(v));
                }else{
                    $(o).parent().text("其他-" + txt[1]);
                }
            });
            $("#selBiddingTypeBtn").click(function () {
                $("#biddingTypeTreeDiv").dialog({
                    resizable: true,
                    height: 550,
                    width: 400,
                    modal: true,
                    open: function () {

                    },
                    title: '标段类型',
                    buttons: {
                        '确定': function () {
                            var nodes = getSelectedNodes();
                            $.each(nodes, function (i, n) {
                                $(":hidden[name=biddingTypeId],#biddingTypeId").val(n.id);
                                $(":text[name=biddingType],#biddingType").val(n.name);
                                if(n.id == 5){
                                    $("#biddingType,:text[name=biddingType]").prop("readonly",false);
                                }else{
                                    $("#biddingType,:text[name=biddingType]").prop("readonly",true);

                                }
                            });
                            $(":hidden[name=biddingTypeId],#biddingTypeId").trigger("dataChange");
                            $(this).dialog('close');
                        },
                        '取消': function () {
                            $(this).dialog('close');
                        }
                    }
                });
            });
        });
        function getSelectedNodes() {
            return   $.fn.zTree.getZTreeObj("biddingTypeTree").getSelectedNodes();
        }
        function getSelectedNodeName(nodeId) {
            var names = [];
            for (var i = 0; i < nodeId.length - 1; i++) {
                var c = nodeId.substring(0, (i + 1));
                getNode(c, biddingTypeData, names);
            }
            return names.join("-");

        }

        function getNode(nodeId, nodeList, names) {
            $.each(nodeList,function(i,node){
                if (node.id == nodeId) {
                    names.push(node.name);
                } else {
                    if(node.children)
                        getNode(nodeId, node.children, names);
                }
            });
        }
    </script>
</head>
<body>
<div id="biddingTypeTreeDiv" style="display: none;">
    <ul id="biddingTypeTree" class="ztree" style="background-color:white;"></ul>
</div>
</body>
</html>
