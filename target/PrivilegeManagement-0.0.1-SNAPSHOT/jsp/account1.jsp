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
        <link rel="stylesheet" href="${pageContext.request.contextPath }/css/bootstrap.min.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/font.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/xadmin.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/theme49.min.css">
        <!-- <link rel="stylesheet" href="./css/theme5.css"> -->
        <script src="${pageContext.request.contextPath}/lib/layui/layui.js" charset="utf-8"></script>
       <script type="text/javascript" src="${pageContext.request.contextPath}/js/xadmin.js"></script>
        <script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery.min.js"></script>
        <script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.3.1.min.js"></script>
 <script src="${pageContext.request.contextPath }/js/bootstrap.min.js"></script>
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
        <script>
           
    $(function(){
    	account();
    	var accountId;
    	
    	//显示用户信息
    	function account(){
    		
    	$.post("${pageContext.request.contextPath}/accountController/getAllAccount",{},function(data){
    		data=eval(data);
    		var account=data;
    		var table="";
    		for(var i=0;i<account.length;i++){
    			table+="<tr><td>"+account[i].accountName
    			+"</td><td>"+account[i].lastName   
    			+"</td><td> <a title='编辑' id='Update'  href='"+account[i].accountId+"'>修改</a>"
    			+"</td><td> <a title='删除' style='cursor:pointer' id='Delete' del=' "+account[i].accountId+" '>删除</a>"
    			+"</td></tr>";
    		}
    		$("#show_tbody").html(table);
    	  });
    	}
    	//修改用户信息
    	$(document).on("click","#Update",function(event){
    		event.preventDefault();
    		$("#renyuan").modal("show");
    		accountId=$(this).attr("href");
    		var param={
    				accountId:accountId
    		}
    	$.post("${pageContext.request.contextPath}/accountController/getAccountId",param,function(data){
    		data=eval(data);
    		 $("#accountName").val(data.accountName);
    		$("#lastName").val(data.lastName);
    		$("#Password").val(data.accountPassword);
    		
    	})
    	return false;
    	});
    	//确定修改信息
    	 $(add_btn).click(function(){
    		var accountName=$("#accountName").val();
    		var lastName=$("#lastName").val();
    		var accountPassword=$("#Password").val();
    		var id =accountId;
    		var param={
    				accountName:accountName,
    				lastName:lastName,
    				accountPassword:accountPassword,
    				accountId:id
    		}
    		$.post("${pageContext.request.contextPath}/accountController/updateAccount",param,function(data){
    			
    			if(data==true||data=="true"){
    				alert("修改成功");
    			}
    			account();
    			$("#accountName").val("");
    			$("#lastName").val("");
    			$("#Password").val("");
    			$("#renyuan").modal('hide');
				$(".modal-backdrop.fade").hide();
    			
    		})
    		
    	}); 
    	//删除用户
    	
      $(document).on("click","#Delete",function(event){
    	  event.preventDefault();
    	  accountId=$(this).attr("del");
    	  var id1 =accountId;
    	  var param={
    			  accountId:id1
    	  }
    	 if(window.confirm("你确定要删除吗")){
    	$.post("${pageContext.request.contextPath}/accountController/deleteAccount",param,function(data){
    		
    		if(data==true||data=="true"){
    			alert("删除成功");
    			account();
    		}else{
    			alert("权限不够 ，无法删除");
    		}
    		
    	});
    	  }
    	  return false;
    	  
      });
    	//确定添加用户
    	$(add_btn1).click(function(){
    		var accountName=$("#accountName1").val();
    		if(null==accountName||""==accountName){
    		    alert("账号不能为空");
   			    return false; 
    		  } 
    		var accountPassword1=$("#accountPassword1").val();
    		if(null==accountPassword1||""==accountPassword1){
    		    alert("密码不能为空");
   			    return false; 
    		  } 
    		var accountPassword=$("#accountPassword2").val();
    		if(null==accountPassword||""==accountPassword){
    		    alert("密码不能为空");
   			    return false; 
    		  } 
             if(accountPassword1==accountPassword){
				
			}else{
				alert("两次输入的密码不一致");
				return false;
			}
    		var lastName=$("#lastName1").val();
    		if(null==lastName||""==lastName){
    		    alert("名字不能为空");
   			    return false; 
    		  } 
    		var param={
    				accountName:accountName,
    				accountPassword:accountPassword,
    				lastName:lastName
    				
    		}
    		$.post("${pageContext.request.contextPath}/accountController/insertAccount",param,function(data){
    			if(data==true||data=="true"){
    				alert("添加成功");
    				account();
        			$("#accountName1").val("");
        			$("#lastName1").val("");
        			$("#accountPassword1").val("");
        			$("#accountPassword2").val("");
        			$("#renyuan1").modal('hide');
    				$(".modal-backdrop.fade").hide();
    			}
    			
    		});
    		
    	}); 
    	$(select).click(function(){
    		var lastName=$("#likeName").val();
    		
    		var param={
    				lastName:lastName
    		}
    		$.post("${pageContext.request.contextPath}/accountController/lastNmaeAccount",param,function(data){
    			data=eval(data);
    			console.log(data);
    			var name=data;
    			var table="";
    			if(name!=0){
    			for(var i=0;i<name.length;i++){
        			table+="<tr><td>"+name[i].accountName
        			+"</td><td>"+name[i].lastName
        			+"</td><td> <a id='Update' href='"+name[i].accountId+"'>修改用户</a>"
        			+"</td><td> <button id='Delete'style='cursor:pointer' del=' "+name[i].accountId+" '>删除用户</button>"
        			+"</td></tr>";
        		}
    			$("#show_tbody").html(table);
    			}else{
    				alert("没有用户信息");
    			}
    		});
    		
    	});
    	 $("#back_btn").click(function(){
         	window.location.reload();
         });
    	

    });
    
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
         <div class="layui-fluid">
            <div class="layui-row layui-col-space15">
                <div class="layui-col-md12">
                    <div class="layui-card">
                        <div class="layui-card-body ">
                            <form class="layui-form layui-col-space5">
                                
                                <div class="layui-inline layui-show-xs-block">
                                
                                   <input type="text" id="likeName" name="username"  placeholder="请输入用户名" autocomplete="off" class="layui-input"> 
                                </div>
                                <div class="layui-inline layui-show-xs-block" >
                                <button class="layui-btn" type="button" id="select">查询</button>
                                 <button class="layui-btn" type="button" id="back_btn">重置</button>
                                  <button id="add" type="button" class="layui-btn" data-toggle="modal"  data-target="#renyuan1">
			                <span  style=" color:black" >点击添加用户</span>
			            </button>
                                </div>
                        <!--           <div class="layui-card-header">
                            <button class="layui-btn layui-btn-danger" ><i class="layui-icon"></i>批量删除</button>
                        <button id="add" type="button" class="layui-btn" data-toggle="modal"  data-target="#renyuan1">
			                <span  style=" color:black" >点击添加用户</span>
			            </button>
                        </div> -->
                            </form>
                        </div>
			        </div>
				</div>
			    </div>
                        <div class="layui-card-body ">
                            <table class="layui-table layui-form">
                              <thead>
                                <tr>
                                <!-- <th>
                                    <input type="checkbox" name=""  lay-skin="primary">
                                  </th> -->
                                  <th>账号登录名</th>
                                  <th>用户名</th>
                                  <th>修改</th>
                                  <th>删除</th>
                              </thead>
                              <tbody id="show_tbody">
                                <tr>
                                  <td>1</td>
                                  <td>admin</td>
                                  <td><!-- <a title="编辑"   href="javascript:;">
                                      <i class="layui-icon">&#xe642;</i>
                                    </a> --></td>
                                  <td><!--  <a title="删除"  href="javascript:;">
                                      <i class="layui-icon">&#xe640;</i>
                                    </a> --></td>
                                    
                                </tr>
                              </tbody>
                            </table>
                        </div>
                      
                       
					 </div>
 						
				
                       <!--  <div class="layui-card-body ">
                            <div class="page">
                                <div>
                                  <a class="prev" href="">&lt;&lt;</a>
                                  <a class="num" href="">1</a>
                                  <span class="current">2</span>
                                  <a class="num" href="">3</a>
                                  <a class="num" href="">489</a>
                                  <a class="next" href="">&gt;&gt;</a>
                                </div>
                            </div>
                        </div> -->
          
           	
        </div>
        
         <div class="export">
					            <div class="modal fade" id="renyuan" style="opacity: 1.0 !important;">
					                <div class="modal-dialog modal-lg modal_position">
					                    <div class="modal-content">
					                        <div class="modal-header">
					                            <h4 class="modal-title">修改</h4>
					                            <button type="button" class="close" data-dismiss="modal">&times;</button>
					                        </div>
					                        <div class="modal-body">
					                            <table id="xztb" class="table">
					                                <!--新修改弹窗的样式-->
					                                <tbody>
					                                <tr>
					                                    <td  class="tb_bg"><label for=""><font style="font-size: 14px; color: red;"></font>用户名字</label>
					                                    <input id="lastName" style="font-size: 13px; color: #666; height: 35px;" type="text">
					                                    </td>
					                               
					                                    <td class="tb_bg"><label for=""><font style="font-size: 14px; color: red;"></font>用户账号</label>
					                                     <input id="accountName"  style="font-size: 13px; color: #666; height: 35px;" type="text">
					                                     </td>
					                                     <td class="tb_bg"><label for=""><font style="font-size: 14px; color: red;"></font>用户密码</label>
					                                     <input id="Password"  style="font-size: 13px; color: #666; height: 35px;" type="text">
					                                     </td>
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
					            <div class="modal fade" id="renyuan1" style="opacity: 1.0 !important;">
					                <div class="modal-dialog modal-lg modal_position">
					                    <div class="modal-content">
					                        <div class="modal-header">
					                            <h4 class="modal-title">添加</h4>
					                            <button type="button" class="close" data-dismiss="modal">&times;</button>
					                        </div>
					                        <div class="modal-body">
					                            <table id="xztb" class="table">
					                                <!--新修改弹窗的样式-->
					                                <tbody>
					                                <tr>
					                                
					                                 <td class="tb_bg"><label for=""><font style="font-size: 14px; color: red;"></font>用户账号</label>
					                                     <input id="accountName1"  style="font-size: 13px; color: #666; height: 35px;" type="text">
					                                     </td>
					                                    
					                               <td class="tb_bg"><label for=""><font style="font-size: 14px; color: red;"></font>用户密码</label>
					                                     <input id="accountPassword1"  style="font-size: 13px; color: #666; height: 35px;" type="password">
					                                     </td>
					                                     <td class="tb_bg"><label for=""><font style="font-size: 14px; color: red;"></font>再次输入密码</label>
					                                     <input id="accountPassword2"  style="font-size: 13px; color: #666; height: 35px;" type="password">
					                                     </td>
					                                   
					                                     <td  class="tb_bg"><label for=""><font style="font-size: 14px; color: red;">*</font>用户名字</label>
					                                    <input id="lastName1" style="font-size: 13px; color: #666; height: 35px;" type="text">
					                                    </td>
											
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
        <div class="page-content-bg"></div>
        <!-- 右侧主体结束 -->
        <!-- 中部结束 -->

</body>
</html>