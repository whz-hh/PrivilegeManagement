<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html class="x-admin-sm">
<head>
		<meta charset="UTF-8">
        <title>权限管理系统</title>
        <meta name="renderer" content="webkit|ie-comp|ie-stand">
        <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
        <meta name="viewport" content="width=device-width,user-scalable=yes, minimum-scale=0.4, initial-scale=0.8,target-densitydpi=low-dpi" />
        <meta http-equiv="Cache-Control" content="no-siteapp" />
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/font.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/xadmin.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/theme49.min.css">
        <!-- <link rel="stylesheet" href="./css/theme5.css"> -->
        <script src="${pageContext.request.contextPath}/lib/layui/layui.js" charset="utf-8"></script>
       <script type="text/javascript" src="${pageContext.request.contextPath}/js/xadmin.js"></script>
        <script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery.min.js"></script>
        <script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.3.1.min.js"></script>

<script type="text/javascript">
	$(function(){
		query();
		function query(){
			var accountId = "${sessionScope.account.accountId }";
			var projectId = 1;
			var param = {
					accountId:accountId,
					projectId:projectId
			}
			$.post("${pageContext.request.contextPath }/menucontroller/getMenuByProjectIdAndAccountId",param,function(data){
				var li = "";
				for (var i = 0; i < data.length; i++) {
					li += "<li class='menugrade1' grade='"+data[i].menuGrade+"'><a href='"+data[i].menuGrade+"' class='menugrade'><i class='iconfont left-nav-li' lay-tips='"+data[i].menuName+"'>&#xe6b4;</i>"+
							"<cite>"+data[i].menuName+"</cite><i class='iconfont nav_right'>&#xe697;</i></a>"+
							"</li>";
				}
				$("#nav").append(li);
			})
		}
		$('.left-nav #nav').on('click', '.menugrade', function(event) {
			var menuGrade = $(this).attr("href");
			var param = {
					menuGrade:menuGrade
			}
			var th = $(this);
			if(th.nextAll().hasClass("sub-menu")){
				if(th.nextAll().css("display") == "none"){
					th.nextAll().css("display","block");
				}else{
					th.nextAll().css("display","none");
				}
			}else{
				$.post("${pageContext.request.contextPath }/menucontroller/getMenuLikeMenuGrade",param,function(data){
					var ul = "<ul class='sub-menu' style='display:block' >";
					for (var i = 0; i < data.length; i++) {
						ul += "<li><a href='javascript:;' grade='"+data[i].menuGrade+"' class='menugrade2'><i class='iconfont'>&#xe6b5;</i><cite>"+data[i].menuName+"</cite><i class='iconfont nav_right'>&#xe697;</i></a></li>"
					}
					ul = ul + "</ul>";
					th.after(ul);
				})
			}
			return false;
		}) ;
		$('.left-nav #nav').on('click', '.menugrade2', function(event) {
			var menuGrade = $(this).attr("grade");
			var param = {
					menuGrade:menuGrade
			}
			var th = $(this);
			if(th.nextAll().hasClass("sub-menu")){
				if(th.nextAll().css("display") == "none"){
					th.nextAll().css("display","block");
				}else{
					th.nextAll().css("display","none");
				}
			}else{
				$.post("${pageContext.request.contextPath }/menucontroller/getMenuLikeMenuGrade",param,function(data){
					var ul = "<ul class='sub-menu' style='display:block;'>";
					for (var i = 0; i < data.length; i++) {
						ul += "<li> <a href='${pageContext.request.contextPath}/jsp/"+data[i].url+"'><i class='iconfont'>&#xe6a7;</i><cite>"+data[i].menuName+"</cite></a>"+
						"</li>";
					}
					ul = ul + "</ul>";
					th.after(ul);
				})
			}
			return false;
		}) ;
	})
</script>
</head>
<body class="index">
       <div class="container">
            <div class="logo">
                <a href="${pageContext.request.contextPath}/index.jsp">权限管理系统</a></div>
            <div class="left_open">
                <a><i title="展开左侧栏" class="iconfont">&#xe699;</i></a>
            </div>
            <ul class="layui-nav right" lay-filter="">
                <li class="layui-nav-item">
                    <a href="#">${sessionScope.account.lastName}<i class="iconfont">&#xe70b;</i></a>
                    <dl class="layui-nav-child">
                        <!-- 二级菜单 -->
                        <dd>
                            <a href="${pageContext.request.contextPath}/jsp/login.jsp">登录</a></dd>
                        <dd>
                            <a href="${pageContext.request.contextPath}/jsp/logout.jsp">注销</a></dd>
                        <dd>
                    </dl>
                </li>
                <li class="layui-nav-item to-index">
                    <a href="${pageContext.request.contextPath}/jsp/logout.jsp">注销</a></li>
            </ul>
        </div>
        <!-- 顶部结束 -->
        <!-- 中部开始 -->
        <!-- 左侧菜单开始 -->
        <div class="left-nav">
            <div id="side-nav">
                <ul id="nav">
                    <!-- <li>
                        <a href="javascript:;">
                            <i class="iconfont left-nav-li" lay-tips="会员管理">&#xe6b4;</i>
                            <cite>会员管理</cite>
                            <i class="iconfont nav_right">&#xe697;</i></a>
                       		<ul class="sub-menu">
                            <li>
                                <a href="javascript:;">
                                    <i class="iconfont">&#xe6b5;</i>
                                    <cite>会员管理</cite>
                                    <i class="iconfont nav_right">&#xe697;</i></a>
                                <ul class="sub-menu">
                                    <li>
                                        <a onclick="xadmin.add_tab('会员删除','member-del.html')">
                                            <i class="iconfont">&#xe6a7;</i>
                                            <cite>会员删除</cite></a>
                                    </li>
                                    <li>
                                        <a onclick="xadmin.add_tab('等级管理','member-list1.html')">
                                            <i class="iconfont">&#xe6a7;</i>
                                            <cite>等级管理</cite></a>
                                    </li>
                                </ul>
                            </li>
                        </ul>
                    </li> -->
                </ul>
            </div>
        </div>
        <!-- <div class="x-slide_left"></div> -->
        <!-- 左侧菜单结束 -->
        <!-- 右侧主体开始 -->
        <div class="page-content">
           	
        </div>
        <div class="page-content-bg"></div>
        <!-- 右侧主体结束 -->
        <!-- 中部结束 -->

</body>
</html>