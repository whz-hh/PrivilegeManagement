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
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/bootstrap.min.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/font.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/xadmin.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/theme49.min.css">
        <!-- <link rel="stylesheet" href="./css/theme5.css"> -->
        <script src="${pageContext.request.contextPath}/lib/layui/layui.js" charset="utf-8"></script>
       <script type="text/javascript" src="${pageContext.request.contextPath}/js/xadmin.js"></script>
        <script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery.min.js"></script>
        <script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.3.1.min.js"></script>
        <script type="text/javascript" src="${pageContext.request.contextPath}/js/bootstrap.min.js"></script>
        <script type="text/javascript"  src="${pageContext.request.contextPath }/js/bootbox.min.js"></script>

<script type="text/javascript">
	$(function(){
		query();
		projecttable();
		var newprojectId = 1;
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
		$("#likeprojectnamebutton").click(function(event){
			event.preventDefault();
			projecttable();
		})
		function projecttable(){
			var projectName = $("#likeprojectnameinput").val();
			var param = {
					projectName:projectName
			}
			$.post("${pageContext.request.contextPath}/projectcontroller/getProjectLikeProjectName",param,function(data){
				var tr = "";
				for (var i = 0; i < data.length; i++) {
					tr += "<tr><td><i class='iconfont' >&#xe6f4;</i>&nbsp;&nbsp;"+data[i].projectName+"</td>"+
						"<td>"+data[i].projectInfo+"</td>"+
						"<td>"+data[i].launchDate+"</td>"+
						"<td class='td-manage'><button  projectName='"+data[i].projectName+"' projectInfo='"+data[i].projectInfo+"' launchDate='"+data[i].launchDate+"' projectId='"+data[i].projectId+"'  class='layui-btn layui-btn layui-btn-xs updateproject'><i class='layui-icon'>&#xe642;</i>编辑</button>"+
						"<button projectId='"+data[i].projectId+"' class='layui-btn-danger layui-btn layui-btn-xs deleteproject' href='javascript:;' ><i class='layui-icon'>&#xe640;</i>删除</button></td></tr>";
				}
				var projecttbody = document.getElementById("projecttbody");
				projecttbody.innerHTML = tr;
			})
		}
		$("body").on("click",".updateproject",function(){
			$("#renyuan").modal("show");
			newprojectId = $(this).attr("projectId");
			var projectName = $(this).attr("projectName");
			var projectInfo = $(this).attr("projectInfo");
			var launchDate = $(this).attr("launchDate");
			$("#postBarName").val(projectName);
			$("#postBarInfo").val(projectInfo);
			$("#projectinputdate").val(launchDate);
		})
		$("body").on("click",".deleteproject",function(){
			var projectId = $(this).attr("projectId");
			var con = confirm("确定要删除这个项目于吗？？？");
			if(con == true||con == "true"){
				var param = {
						projectId:projectId
				}
				$.post("${pageContext.request.contextPath}/projectcontroller/doDelProject",param,function(data){
					if(data == true||data == "true"){
						alert("删除成功");
						projecttable();
					}
				})
			}
		})
		$("#add_btn").click(function(){
			var projectName = $("#postBarName").val();
			var projectInfo = $("#postBarInfo").val();
			var launchDate = $("#projectinputdate").val();
			var param = {
					projectId:newprojectId,
					projectName:projectName,
					projectInfo:projectInfo,
					launchDate:launchDate
			}
			$.post("${pageContext.request.contextPath}/projectcontroller/doUpdProject",param,function(data){
				if(data == true||data == "true"){
					alert("修改成功");
					projecttable();
				}
			})
			$("#renyuan").modal("hide");
			$(".modal-backdrop.fade").hide();
			projecttable();
		})
		$("#add_btn1").click(function(){
			var projectName = $("#postBarName1").val();
			var projectInfo = $("#postBarInfo1").val();
			var launchDate = $("#projectinputdate1").val();
			var param = {
					projectName:projectName,
					projectInfo:projectInfo,
					launchDate:launchDate
			}
			$.post("${pageContext.request.contextPath}/projectcontroller/doInsProject",param,function(data){
				if(data == true||data == "true"){
					alert("添加成功");
					projecttable();
				}
			})
			$("#addrenyuan").modal("hide");
			$(".modal-backdrop.fade").hide();
			projecttable();
		})
		$("#addproject").click(function(){
			$("#addrenyuan").modal("show");
			$("#postBarName1").val("");
			$("#postBarInfo1").val("");
			$("#projectinputdate").val("");
		})
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
                </ul>
            </div>
        </div>
        <!-- <div class="x-slide_left"></div> -->
        <!-- 左侧菜单结束 -->
        <!-- 右侧主体开始 -->
        <div class="page-content">
           <div class="x-nav">
            <span class="layui-breadcrumb">
                <a href="">权限管理系统</a>
                <a href="">项目管理</a>
                <a>
                    <cite>项目管理</cite></a>
            </span>
            <a class="layui-btn layui-btn-small" style="line-height:1.6em;margin-top:3px;float:right" onclick="location.reload()" title="刷新">
                <i class="layui-icon layui-icon-refresh" style="line-height:30px"></i>
            </a>
        </div>
        <div class="layui-fluid">
            <div class="layui-row layui-col-space15">
                <div class="layui-col-md12">
                    <div class="layui-card">
                        <div class="layui-card-body ">
                            <form class="layui-form layui-col-space5">
                                <div class="layui-input-inline layui-show-xs-block">
                                    <input class="layui-input" id="likeprojectnameinput"  placeholder="项目名称" name="cate_name"></div>
                                <div class="layui-input-inline layui-show-xs-block">
                                    <button class="layui-btn" id="likeprojectnamebutton"><i class="iconfont">&#xe6ac;</i>查询</button>
                                </div>
                            </form>
                            <hr>
                        </div>
                        <div class="layui-card-header">
                            <button class="layui-btn layui-btn-danger" id="addproject">
                                <i class="iconfont">&#xe6b9;</i>添加新项目</button>
                        </div>
                        <div class="layui-card-body ">
                            <table class="layui-table layui-form">
                              <thead>
                                <tr>
                                  <th >项目名称</th>
                                  <th >项目介绍</th>
                                  <th >上线时间</th>
                                  <th >操作</th>
                              </thead>
                              <tbody class="x-cate" id="projecttbody">
                               
                              </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
        </div>	
        </div>
        	<div class="export">
			<div class="modal fade" id="renyuan">
	                <div class="modal-dialog modal-lg modal_position">
	                    <div class="modal-content" >
	                        <div class="modal-header">
	                            <h4 class="modal-title">创建一个项目</h4>
	                            <button type="button" class="close" data-dismiss="modal">&times;</button>
	                        </div>
	                        <div class="modal-body" >
	                            <table id="xztb" class="table">
	                                <!--新修改弹窗的样式-->
	                                <tbody>
	                                <tr>
	                                    <td class="tb_bg"><label for=""><font style="font-size: 14px; color: red;"></font>新项目名称</label>
	                                    </td>
	                                    <td><input id="postBarName"  type="text" placeholder="项目名称"></td>
	                                </tr>
	                                <tr>
	                                    <td class="tb_bg"><label for=""><font style="font-size: 14px; color: red;"></font>项目简介</label>
	                                    </td>
	                                    <td><textarea style="width:633px;height:151px;margin-top:15px;font-size:large" rows="" cols="" id="postBarInfo" ></textarea></td>
	                                </tr>
	                                <tr>
	                                    <td class="tb_bg"><label for=""><font style="font-size: 14px; color: red;"></font>上线时间</label>
	                                    </td>
	                                    <td><input style="width:120px;height:30px;" type="date" id="projectinputdate"/></td>
	                                </tr>
	                                </tbody>
	                            </table>
	                        </div>
	                        <div class="modal-footer">
	                            <button type="button" class="btn btn-secondary" data-dismiss="modal">取消</button>
	                            <button id="add_btn" type="button" class="btn btn-secondary">确定</button>
	                        </div>
	                    </div>
	                </div>
	            </div>
	         </div>
        <div class="export">
			<div class="modal fade" id="addrenyuan">
	                <div class="modal-dialog modal-lg modal_position">
	                    <div class="modal-content" >
	                        <div class="modal-header">
	                            <h4 class="modal-title">创建一个项目</h4>
	                            <button type="button" class="close" data-dismiss="modal">&times;</button>
	                        </div>
	                        <div class="modal-body" >
	                            <table id="xztb" class="table">
	                                <!--新修改弹窗的样式-->
	                                <tbody>
	                                <tr>
	                                    <td class="tb_bg"><label for=""><font style="font-size: 14px; color: red;"></font>新项目名称</label>
	                                    </td>
	                                    <td><input id="postBarName1"  type="text" placeholder="项目名称"></td>
	                                </tr>
	                                <tr>
	                                    <td class="tb_bg"><label for=""><font style="font-size: 14px; color: red;"></font>项目简介</label>
	                                    </td>
	                                    <td><textarea style="width:633px;height:151px;margin-top:15px;font-size:large" rows="" cols="" id="postBarInfo1" ></textarea></td>
	                                </tr>
	                                <tr>
	                                    <td class="tb_bg"><label for=""><font style="font-size: 14px; color: red;"></font>上线时间</label>
	                                    </td>
	                                    <td><input style="width:120px;height:30px;" type="date" id="projectinputdate1"/></td>
	                                </tr>
	                                </tbody>
	                            </table>
	                        </div>
	                        <div class="modal-footer">
	                            <button type="button" class="btn btn-secondary" data-dismiss="modal">取消</button>
	                            <button id="add_btn1" type="button" class="btn btn-secondary">确定</button>
	                        </div>
	                    </div>
	                </div>
	            </div>
	         </div>
        <!-- 右侧主体结束 -->
        <!-- 中部结束 -->
          
	
</body>
</html>