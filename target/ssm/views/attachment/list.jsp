<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="f" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE HTML>
<html>
<head>
    <meta charset="utf-8">
    <meta name="renderer" content="webkit|ie-comp|ie-stand">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no"/>
    <meta http-equiv="Cache-Control" content="no-siteapp"/>
    <link href="${pageContext.request.contextPath}/static/css/H-ui.min.css" rel="stylesheet" type="text/css"/>
    <link href="${pageContext.request.contextPath}/static/css/H-ui.admin.css" rel="stylesheet" type="text/css"/>
    <link href="${pageContext.request.contextPath}/static/css/style.css" rel="stylesheet" type="text/css"/>
    <link href="${pageContext.request.contextPath}/static/lib/Hui-iconfont/1.0.1/iconfont.css" rel="stylesheet" type="text/css"/>
    <title>附件列表</title>
</head>
<body>
<nav class="breadcrumb">
    <i class="Hui-iconfont">&#xe67f;</i> 首页
    <span class="c-gray en">&gt;</span> 附件管理
        <span class="c-gray en">&gt;</span> 附件列表
            <a class="btn btn-success radius r mr-20" style="line-height:1.6em;margin-top:3px" href="javascript:location.replace(location.href);" title="刷新">
                <i class="Hui-iconfont">&#xe68f;</i>
            </a>
</nav>
<div class="pd-20">
    <div class="text-c">
        <span class="select-box inline">
            <select name="" class="select">
                <option value="0">全部分类</option>
                <option value="1">word</option>
                <option value="2">excel</option>
            </select>
		</span>
        日期范围：
        <input type="text" onfocus="WdatePicker({maxDate:'#F{$dp.$D(\'logmax\')||\'%y-%M-%d\'}'})" id="logmin" class="input-text Wdate" style="width:120px;">
        -
        <input type="text" onfocus="WdatePicker({minDate:'#F{$dp.$D(\'logmin\')}',maxDate:'%y-%M-%d'})" id="logmax" class="input-text Wdate" style="width:120px;">
        <input type="text" name="" id="" placeholder="附件名称" style="width:250px" class="input-text">
        <button name="" class="btn btn-success" type="submit"><i class="Hui-iconfont">&#xe665;</i>搜附件</button>
    </div>
    <div class="cl pd-5 bg-1 bk-gray mt-20">
    	<span class="l">
	        <a href="javascript:;" class="btn btn-danger radius"><i class="Hui-iconfont">&#xe6e2;</i>批量</a>
	        <a href="${pageContext.request.contextPath}/views/attachment/insert.jsp" class="btn btn-primary radius"><i class="Hui-iconfont">&#xe600;</i>添加</a>
	    </span>
        <span class="r">共有数据：<strong>54</strong> 条</span>
    </div>
	<div class="mt-20">
           <table class="table table-border table-bordered table-bg table-hover table-sort">
            <thead>
	            <tr class="text-c">
	                <th width="25"><input type="checkbox" name="" value=""></th>
	                <th width="80">名称</th>
	                <th width="80">类型</th>
	                <th width="80">大小</th>
	                <th width="120">上传日期</th>
	                <th width="75">下载次数</th>
	                <th width="60">发布状态</th>
	                <th width="120">操作</th>
	            </tr>
            </thead>
            <tbody>
			<c:set var="KB" value="1024"/>
			<c:set var="MB" value="${KB*KB}"/>
			<c:forEach items="${list}" var="a" varStatus="n">
	            <tr class="text-c">
	                <td><input type="checkbox" value="" name=""></td>
	                <td class="text-l">${a.name}</td>
	                <td>${a.type}</td>
	                <td>
					    <c:choose>
							<c:when test="${a.sizes >MB}">
								<f:formatNumber value="${a.sizes/MB}" maxFractionDigits="2"/>MB
							</c:when>
							<c:when test="${a.sizes >KB}">
								<f:formatNumber value="${a.sizes/KB}" maxFractionDigits="2"/>KB
							</c:when>
							<c:otherwise>
								${a.sizes}B
							</c:otherwise>
						</c:choose>
					</td>
	                <td>
						<f:formatDate value="${a.createTime}"/>
					</td>
	                <td>${a.downNumber}</td>
	                <td class="td-status">
						<c:if test="${a.state==0}">
							<span class="label label-success radius">未发布</span>
						</c:if>
						<c:if test="${a.state==1}">
							<span class="label label-success radius">已发布</span>
						</c:if>
					</td>
	                <td class="f-14 td-manage">
	                    <a style="text-decoration:none" class="ml-5" href="javascript:;" title="编辑"><i class="Hui-iconfont">&#xe6df;</i></a>
	                    <a style="text-decoration:none" class="ml-5" href="${pageContext.request.contextPath}/attachment/delete/${a.id}.do" title="删除"><i class="Hui-iconfont">&#xe6e2;</i></a>
						<a style="text-decoration:none" class="ml-5" href="${pageContext.request.contextPath}/attachment/download/${a.id}.do" title="下载"><i class="Hui-iconfont">&#xe640;</i></a>
	                </td>
	            </tr>
			</c:forEach>
            </tbody>
        </table>
    </div>
</div>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/lib/jquery/1.9.1/jquery.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/lib/layer/1.9.3/layer.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/lib/My97DatePicker/WdatePicker.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/H-ui.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/H-ui.admin.js"></script>
<script type="text/javascript">
    /*批量-删除*/
    function article_del(obj, id) {
        layer.confirm('确认要删除吗？', function (index) {
            $(obj).parents("tr").remove();
            layer.msg('已删除!', 1);
        });
    }
</script>
</body>
</html>