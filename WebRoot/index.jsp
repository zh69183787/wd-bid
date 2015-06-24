<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c" %>
<!doctype html>
<html lang="en">
<head>
    <meta charset="utf-8"/>
    <script src="${pageContext.request.contextPath}/js/jquery-1.7.1.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/highcharts.js"></script>
    <script>
        //左侧Javascript代码
    </script>
</head>
<body>
<div id="container" style="width:100%;height:400px"></div>
</body>
<script>
    $(function () {
         $('#container').highcharts({
            title: {
                text: '${param.title}中标价分析'
            },credits: {
                enabled: false
            },
            yAxis: {
                title: {
                    text: '金额(万元)'
                },
                plotLines:[{
                    color:'#901010',
                    dashStyle:'longdashdot',
                    value:${avgPrice},
                    width:3  ,
                    zIndex:100,label:{text:'<span  style="color:#901010;font-weight: bold">均价:${avgPrice}万元</span>',align:'right',y:-10,useHtml:true}
                },{
                    color:'#901010',
                    value:${limitPrice},
                    width:3 ,label:{text:'<span  style="color:#901010;font-weight: bold">限价:${limitPrice}万元</span>',align:'right',y:-10,useHtml:true},
                    zIndex:100
                }]
            },
            xAxis: {
                categories: ['运一', '运二', '运三', '运四', '运五'],
                labels:{rotation:315}
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
                    name: '投标金额',color:'#4572A7',
                    data: [{
                        y:3
                    },{
                        y:2
                    },{
                        y:5,
                        color:'#901010'
                    },{
                        y:1
                    },{
                        y:4
                    }]
                }

            ]
        });

//        charts.setCategories(["qq","bb"])
    });
</script>
</html>