<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE HTML>
<html>
	<head>
		<title>新增附件</title>
		<meta charset="utf-8">
		<meta name="renderer" content="webkit|ie-comp|ie-stand">
		<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
		<meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no" />
		<meta http-equiv="Cache-Control" content="no-siteapp" />
		<link href="${pageContext.request.contextPath}/static/css/H-ui.min.css" rel="stylesheet" type="text/css" />
		<link href="${pageContext.request.contextPath}/static/css/H-ui.admin.css" rel="stylesheet" type="text/css" />
		<link href="${pageContext.request.contextPath}/static/lib/icheck/icheck.css" rel="stylesheet" type="text/css" />
		<link href="${pageContext.request.contextPath}/static/lib/Hui-iconfont/1.0.1/iconfont.css" rel="stylesheet" type="text/css" />
	</head>
	<body>
		<div class="pd-20">
			<form action="${pageContext.request.contextPath}/attachment/insert.do" method="post" enctype="multipart/form-data" class="form form-horizontal" id="form-article-add">
				<div class="row cl">
					<label class="form-label col-2">附件：</label>
					<div class="formControls col-10">
						<input type="file" class="input-text" name="loadFile">
					</div>
				</div>
				<div class="row cl">
					<div class="col-10 col-offset-2">
						<button class="btn btn-primary radius" type="submit"><i class="Hui-iconfont">&#xe632;</i>上传</button>
						<button class="btn btn-default radius" type="button" onclick="javascript:history.go(-1)">&nbsp;&nbsp;取消&nbsp;&nbsp;</button>
					</div>
				</div>
			</form>
		</div>
		<script type="text/javascript" src="${pageContext.request.contextPath}/static/lib/jquery/1.9.1/jquery.min.js"></script>
		<script type="text/javascript" src="${pageContext.request.contextPath}/static/lib/layer/1.9.3/layer.js"></script>
		<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/H-ui.js"></script>
		<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/H-ui.admin.js"></script>
		<script type="text/javascript">
		</script>
	</body>
</html>