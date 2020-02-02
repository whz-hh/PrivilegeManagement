<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html  class="x-admin-sm">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>登录</title>
	<meta name="renderer" content="webkit|ie-comp|ie-stand">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width,user-scalable=yes, minimum-scale=0.4, initial-scale=0.8,target-densitydpi=low-dpi" />
    <meta http-equiv="Cache-Control" content="no-siteapp" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/font.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/login.css">
	 <link rel="stylesheet" href="${pageContext.request.contextPath}/css/xadmin.css">
	<script type="text/javascript" src="${pageContext.request.contextPath }/js/jquery.min.js"></script>
	 <script src="${pageContext.request.contextPath }/lib/layui/layui.js" charset="utf-8"></script>
<script type="text/javascript">
	$(function(){
		$("#login").click(function(){
			var accountName = $("#accountName").val();
			var accountPassword = $("#accountPassword").val();
			if(accountName == ""||accountName == null||accountPassword == ""||accountPassword == null){
				return false;
			}
			var param = {
					accountName:accountName,
					accountPassword:accountPassword
			}
			$.post("${pageContext.request.contextPath}/accountController/loginAccount",param,function(data){
				if(data == true||data == "true"){
					window.location.href="${pageContext.request.contextPath}/index.jsp";
				}else{
					alert("登录失败");
				}
			})
			return false;
		})
	})
</script>
</head>
<body class="login-bg">
	<div class="login layui-anim layui-anim-up">
        <div class="message">权限管理系统</div>
        <div id="darkbannerwrap"></div>
        
        <form method="post" class="layui-form" >
            <input name="username" id="accountName" placeholder="用户名"  type="text" lay-verify="required" class="layui-input" >
            <hr class="hr15">
            <input name="password" id="accountPassword" lay-verify="required" placeholder="密码"  type="password" class="layui-input">
            <hr class="hr15">
            <input value="登录" id="login" lay-submit lay-filter="login" style="width:100%;" type="submit">
            <hr class="hr20" >
        </form>
    </div>
</body>
</html>