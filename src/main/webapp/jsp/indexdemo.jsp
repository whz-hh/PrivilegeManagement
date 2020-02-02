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
        <!-- 让IE8/9支持媒体查询，从而兼容栅格 -->
        <!--[if lt IE 9]>
          <script src="https://cdn.staticfile.org/html5shiv/r29/html5.min.js"></script>
          <script src="https://cdn.staticfile.org/respond.js/1.4.2/respond.min.js"></script>
        <![endif]-->
    </head>
    <body class="index">
    <script type="text/javascript">
    		$(function(){
    			getMenu();
    			function getMenu(){
    			var param={
    					accountId:1,
    					projectId:1
    			}
    			$.post("${pageContext.request.contextPath}/accountController/getAccountMenu",param,function(data){
    				data=eval(data);
    				console.log(data);
    				var roles=data.roles;
    				var table="";
    				for(var i = 0 ;i<roles.length;i++){
    					var menus=roles[i].menus;
    					for(var j=0;j<menus.length;j++){
    						table+="<li><a href='javascript:;'><i class='iconfont left-nav-li' lay-tips='"+menus[i].menusName+"'>&#xe6b4;</i>"+
                            "<cite>"+menus[i].menusName+"</cite><i class='iconfont nav_right'>&#xe697;</i></a>"+
                       		"<ul class='sub-menu'><li><a href='javascript:;'><i class='iconfont'>&#xe6b5;</i>"+
                            "<cite>会员管理</cite><i class='iconfont nav_right'>&#xe697;</i></a><ul class='sub-menu'>"+
                            "<li><a href='#'><i class='iconfont'>&#xe6a7;</i><cite>会员删除</cite></a></li><li>"+
                            "<a onclick='#'><i class='iconfont'>&#xe6a7;</i><cite>等级管理</cite></a></li></ul></li></ul></li>";
    					}
    					
    				}
    				$("#nav").html(table);
    			});
    			}
    			
    		});
    </script>
        <!-- 顶部开始 -->
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
                            <a href="#">个人信息</a></dd>
                        <dd>
                            <a href="#">切换帐号</a></dd>
                        <dd>
                    </dl>
                </li>
                <li class="layui-nav-item to-index">
                    <a href="/">Login Out</a></li>
            </ul>
        </div>
        <!-- 顶部结束 -->
        <!-- 中部开始 -->
        <!-- 左侧菜单开始 -->
        <div class="left-nav">
            <div id="side-nav">
                <ul id="nav">
                    <li>
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
                    </li>
                    <li>
                        <a href="javascript:;">
                            <i class="iconfont left-nav-li" lay-tips="会员管理">&#xe6b8;</i>
                            <cite>会员管理</cite>
                            <i class="iconfont nav_right">&#xe697;</i></a>
                       		<ul class="sub-menu">
                            <li>
                                <a href="javascript:;">
                                    <i class="iconfont">&#xe70b;</i>
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
                    </li>
                    <li>
                        <a href="javascript:;">
                            <i class="iconfont left-nav-li" lay-tips="会员管理">&#xe6b8;</i>
                            <cite>会员管理</cite>
                            <i class="iconfont nav_right">&#xe697;</i></a>
                       		<ul class="sub-menu">
                            <li>
                                <a href="javascript:;">
                                    <i class="iconfont">&#xe70b;</i>
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
                    </li>
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