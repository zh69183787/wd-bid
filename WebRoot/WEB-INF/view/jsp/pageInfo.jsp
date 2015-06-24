<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt" %>
<script>
    $(function(){
        $($("form")[0]).click(function(){
            $("#pageIndex").val(1);
        })
    })
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
            $("#pageIndex").val(parseInt($("#pageIndex").val()) - 1);
        }
        //type=2,跳转到下一页
        if (type == "2") {
            $("#pageIndex").val(parseInt($("#pageIndex").val()) + 1);
            //alert($("#pageNo").val());
        }

        //type=3,跳转到最后一页,或第一页
        if (type == "3") {
            $("#pageIndex").val(pageNo);
        }

            $($("form")[0]).submit();

    }
</script>
<c:if test="${pageInfo!=null  }">
                           
                  <tr class="tfoot">
        	      <td colspan="30"><div class="clearfix"><span class="fl">共${pageInfo.totalRows }条记录，当前显示${(pageInfo.pageIndex-1)*pageInfo.pageSize+1 }-
        	      <c:if test="${pageInfo.totalRows <=pageInfo.pageIndex*pageInfo.pageSize }">
        	      	${pageInfo.totalRows }
        	      </c:if>
        	      <c:if test="${pageInfo.totalRows >pageInfo.pageIndex*pageInfo.pageSize }">
        	      	${pageInfo.pageIndex*pageInfo.pageSize }
        	      </c:if>
        	      条</span>
        	      
        	        <ul class="fr clearfix pager">
        	          <li>Pages:${pageInfo.pageIndex }/${pageInfo.totalPages }
        	          	<input type="hidden" value="${pageInfo.totalPages }" id="totalPageCount">
						<input type="text" id="pageNumber" name="pageNumber" min="0" max="999" step="1" class="input_tiny" value="${pageInfo.pageIndex}"/>
        	            <input type="button" name="button" id="button" value="Go" onclick="goPage(0,0)">
      	            </li>
        	          <c:if test="${pageInfo.pageIndex==pageInfo.totalPages }">
                       	 <li>&gt;&gt;</li>
                       </c:if>
                       <c:if test="${pageInfo.pageIndex<pageInfo.totalPages }">
                        <li><a href="javascript:void(0)" onclick="goPage(${pageInfo.totalPages },3)">&gt;&gt;</a></li>
                       </c:if>
                      <li>
                      	<c:if test="${pageInfo.pageIndex==pageInfo.totalPages }">
                      		下一页
                      	</c:if>
                      	<c:if test="${pageInfo.pageIndex<pageInfo.totalPages }">
                      		<a href="javascript:void(0)" onclick="goPage(${pageInfo.pageIndex},2)">下一页</a>
                      	</c:if>
                      </li>
                      <li>
                      	<c:if test="${pageInfo.pageIndex==1 }">
                      		上一页
                      	</</c:if>
                      	<c:if test="${pageInfo.pageIndex>1 }">
                      		<a href="javascript:void(0)" onclick="goPage(${pageInfo.pageIndex},1)">上一页</a>
                      	</c:if>
                      </li>
                      <c:if test="${pageInfo.pageIndex==1 }">
                      	<li>&lt;&lt;</li>
                      </c:if>
                      <c:if test="${pageInfo.pageIndex>1 }">
                      	<li><a href="javascript:void(0)" onclick="goPage(1,3)">&lt;&lt;</a></li>
                      </c:if>
      	          </ul>
      	        </div></td>
      	      </tr> </c:if><c:if test="${pageInfo==null}">
      	      <tr class="tfoot"><td colspan="30"><div class="clearfix">无相关数据</div></td>
   	          </tr>
      	      </c:if>