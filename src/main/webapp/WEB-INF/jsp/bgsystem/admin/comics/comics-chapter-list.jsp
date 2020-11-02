<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
		+ path + "/";
request.setAttribute("basePath", basePath);
%>
<!DOCTYPE html>
<html>
  
  <head>
  	<base href="<%=basePath%>">
    <meta charset="UTF-8">
    <title>漫画章节列表</title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width,user-scalable=yes, minimum-scale=0.4, initial-scale=0.8,target-densitydpi=low-dpi" />
    <link rel="shortcut icon" href="/favicon.ico" type="image/x-icon" />
    <link rel="stylesheet" href="<%=basePath%>resources/css/font.css">
    <link rel="stylesheet" href="<%=basePath%>resources/css/xadmin.css">
    <script type="text/javascript" src="<%=basePath%>resources/js/jquery-3.3.1.min.js"></script>
    <script type="text/javascript" src="<%=basePath%>resources/layui/layui.js" charset="utf-8"></script>
    <script type="text/javascript" src="<%=basePath%>resources/js/xadmin.js"></script>
    <!-- 让IE8/9支持媒体查询，从而兼容栅格 -->
    <!--[if lt IE 9]>
      <script src="https://cdn.staticfile.org/html5shiv/r29/html5.min.js"></script>
      <script src="https://cdn.staticfile.org/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->
  </head>
  
  <body>
    <div class="x-nav">
      <span class="layui-breadcrumb">
        <a href="">首页</a>
        <a href="">漫画信息管理</a>
        <a>
          <cite>漫画章节列表</cite></a>
      </span>
      <a class="layui-btn layui-btn-small" style="line-height:1.6em;margin-top:3px;float:right" href="javascript:location.replace(location.href);" title="刷新">
        <i class="layui-icon" style="line-height:35px">&#xe9aa;</i></a>
    </div>
    <div class="x-body">
      <div class="layui-row">
        <form class="layui-form layui-col-md12 x-so" action="${pageContext.request.contextPath }/showComicsChapterList.action" method="post">
          <!--下拉列表-->
          <label for="comicsName">
              <b>所属漫画</b> 
          </label>
          <div class="layui-input-inline">
            <select name="comicsId">
              <option value=""></option>
              <c:forEach items="${comicsNameList }" var="comics">
              	<option value="${comics.comicsId }" <c:if test="${comics.comicsId==comicsId }">selected ="selected"</c:if>>${comics.comicsName }</option>
              </c:forEach>
            </select>
          </div>
          <label for="updateTime">
              <b>更新日期</b> 
          </label>
          <input type="text" name="updateTime" class="layui-input" placeholder="日期" id="date" value="${updateTime }">
          <!--//下拉列表-->
          <!--搜索框-->
          <label for="chaptername">
              <b>章节名称</b> 
          </label>
          <input type="text" name="chaptername"  placeholder='<c:if test="${chaptername=='' }">请输入章节名称...</c:if>' autocomplete="off" class="layui-input" value='<c:if test="${chaptername!='' }">${chaptername }</c:if>'>
          <!--//搜索框-->
          <!--搜索按钮-->
          <button class="layui-btn"  lay-submit="" lay-filter="sreach"><i class="layui-icon">&#xe615;</i></button>
          <!--//搜索按钮-->
        </form>
      </div>
      <xblock>
        <!--批量删除-->
        <button class="layui-btn layui-btn-danger" onclick="delAll()"><i class="layui-icon"></i>批量删除</button>
        <!--//批量删除-->
        <!--添加动画-->
        <button class="layui-btn" onclick="x_admin_show('添加漫画章节','${pageContext.request.contextPath}/toChapterAdd.action')"><i class="layui-icon"></i>添加</button>
        <!--//添加动画-->
      </xblock>
      <table class="layui-table">
        <thead>
          <tr>
            <th>
              <input id="allCheck" type="checkbox" class="layui-unselect header layui-form-checkbox" lay-skin="primary" onclick="checkAll()" />
            </th>
            <th>编号</th>
            <th>章节序号</th>
            <th>章节名称</th>
            <th>更新时间</th>
            <th>所属漫画</th>
            <th >操作</th>
            </tr>
        </thead>
        <tbody>
          <c:choose>
          	<c:when test="${empty chapterPageInfo}">
          		<tr><td colspan="6" style="text-align: center;">暂无漫画章节数据</td></tr>
          	</c:when>
          	<c:otherwise>
          		<c:forEach items="${chapterPageInfo.list}" var="chapter">
          			<tr>
			            <td>
			              <input type="checkbox" name="childCheckbox" class="layui-unselect layui-form-checkbox" lay-skin="primary" value="${chapter.chapterId}" />
			            </td>
			            <td>${chapter.chapterId}</td>
			            <td>${chapter.chapterNum}</td>
			            <td>${chapter.chapterName}</td>
			            <td>${chapter.updateTime }</td>
			            <td>${chapter.comics.getComicsName() }</td>
			         	<td class="td-manage">
			         	  <!-- 查看 -->
			              <a title="查看"  onclick="x_admin_show('查看用户','${pageContext.request.contextPath}/toShowComicsChapterById.action?chapterId='+${chapter.chapterId})" href="javascript:;">
			                <i class="layui-icon">&#xe705;</i>
			              </a>
			              <!-- //查看 -->
			              <a title="编辑"  onclick="x_admin_show('修改章节','${pageContext.request.contextPath}/showComicsChapterById.action?chapterId='+${chapter.chapterId})" href="javascript:;">
			                <i class="layui-icon">&#xe642;</i>
			              </a>
			              <a title="删除" onclick="chapter_del(this,${chapter.chapterId})" href="javascript:;">
			                <i class="layui-icon">&#xe640;</i>
			              </a>
			            </td>
			          </tr>
          		</c:forEach>
          	</c:otherwise>
          </c:choose>
        </tbody>
      </table>
	  <!--分页-->
      <div style="text-align:center">
      	<div id="laypage"></div>
      </div>
    </div>
    <script>
    /* 分页查询 */
	 $(function(){ 
		//监听加载状态改变
		layui.use(['laypage','layer','laydate'],function(){
  			var laypage = layui.laypage;
  			var layer = layui.layer;
  			var laydate = layui.laydate;
  			laydate.render({
  	            elem: '#date' //指定元素
  	        });
  			var index = layer.load(0,{time:500});
  			document.onreadstatechange=completeLoading(index);
	   		laypage.render({            
	   		    elem: 'laypage', //注意，这里的 test1 是 ID，不用加 # 号
	   		    count: ${chapterPageInfo.total},//数据总数，从服务端得到
	   		    curr: ${chapterPageInfo.pageNum},
	   		    limit: ${chapterPageInfo.pageSize},
	   		    layout:['first','prev', 'page', 'next','last','skip','count'],//显示哪些分页组件
	   		    first: '首页', //自定义“首页”的内容
	   		    last: '尾页',  //自定义“尾页”的内容
	   		    prev: '<em>上一页</em>',  //自定义“上一页”的内容
	   		    next: '<em>下一页</em>',  //自定义“下一页”的内容
	   		    jump:function(obj,first){  //jump - 切换分页的回调
	   		    	//obj包含了当前分页的所有参数，比如：
	   		        //console.log(obj.curr); //得到当前页，以便向服务端请求对应页的数据。
	   		        //console.log(obj.limit); //得到每页显示的条数
	   		    	//首次不执行
	   		        if(!first){
	   		          //do something
	   		          //var conf ={"pageNum":obj.curr,"pageSize":obj.limit};
	   		          window.location="${pageContext.request.contextPath }/showComicsChapterList.action?pageNum="+obj.curr+"&pageSize="+obj.limit+"&chaptername="+'${chaptername }'+"&comicsId="+'${comicsId}'+"&updateTime="+'${updateTime}';
	   		        }
	   		    }
	   		  });
  		});
	 });

	   function completeLoading(index){
	   	if(document.readyState=="complete"){
	   		layui.use('layer',function(){
	   			var layer = layui.layer;
	   			layer.close(index);
	   		});
	   	}
	   }
	   
	   /*漫画章节-删除*/
	      function chapter_del(obj,id){
	    	  layui.use('layer',function(){
	    		  var layer = layui.layer;
	    		  layer.confirm('确认要删除吗？',function(index){
	                  //发异步删除数据
	    			  $.post("${pageContext.request.contextPath}/delComicsChapterById.action",{"chapterId":id},function(data){
	    				  if(data == "OK"){
	    					  layer.msg('删除成功!',{icon:1,time:1000},function(){
	    						  window.location="${pageContext.request.contextPath}/showComicsChapterList.action?pageNum="+1;
	    					  });
	    				  }else{
	    					  layer.msg('删除失败!',{icon:2,time:1000});
	    				  }
	    			  });
	              });
	    	  });
	      }

	      /**
	       * 全选\取消复选框
	       */
	       function checkAll(){
	    	  if($("#allCheck").is(":checked")){
	    		  $("input[name='childCheckbox']").each(function(){
	    			 $(this).prop("checked",true); 
	    		  });
	    	  }else{
	    		  $("input[name='childCheckbox']").each(function(){
	     			 $(this).prop("checked",false); 
	     		  });
	    	  }
	       }

	      /**
	       * 批量删除音乐信息
	       */
	      function delAll(argument) {
	    	  layui.use('layer',function(){
	    		  var checkNum = $("input[name='childCheckbox']:checked").length;
	    	        if(checkNum==0){
	    	        	layer.msg('至少选择一项！', {icon: 2,time:1000});
	    	        	return false;
	    	        }
	    	        //捕捉到所有选中的复选框内容值进行ajax异步删除
	    	        var checkList = new Array();
	    	        $("input[name='childCheckbox']:checked").each(function(){
	    	        	checkList.push($(this).val());
	    	        });
	    	        
	    	        layer.confirm('确认要删除'+checkNum+'条数据吗？',function(index){
	    	            //捉到所有被选中的，发异步进行删除
	    	            $.post("${pageContext.request.contextPath}/deleteComicsChapterAll.action",{"chapterList":checkList.toString()},function(data){
	    	            	if(data == 'OK'){
	    	            		layer.msg('删除成功', {icon: 1,time:1000},function(){
	    	            			window.location="${pageContext.request.contextPath}/showComicsChapterList.action?pageNum="+1;
	    	            		});
	    	            	}else{
	    	            		layer.msg('删除失败',{icon:2,time:1000});
	    	            	}
	    	            });
	    	        });
	    	  });
	      }
    </script>
  </body>
</html>