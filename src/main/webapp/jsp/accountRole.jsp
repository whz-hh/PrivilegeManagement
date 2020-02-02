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
		var roles = "";
		getroles();
		accountroletbody();
		checkboxanyone();
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
		
		function accountroletbody(){
			var lastName = $("#likeprojectnameinput").val();
			var param = {
					lastName:lastName
			}
			$.post("${pageContext.request.contextPath }/accountrolecontroller/getAccountAndRoleLikeAccountName",param,function(data){
				var	tr = "";
				for (var i = 0; i < data.length; i++) {
					tr += "<tr> <td style='width:100px;'> <span><i class='iconfont'>&#xe732;</i>&nbsp;&nbsp;"+data[i].lastName+"</span></td>"+
					"<td class='rolestd' id='account"+data[i].accountId+"' accountId='"+data[i].accountId+"'>"+roles+
					"<button class='layui-btn displaynone' accountId='"+data[i].accountId+"'><i class='iconfont'>&#xe70a;</i>&nbsp;&nbsp;&nbsp;&nbsp;提交</button> "+
					"</td></tr>";
				}
				$("#accountroletbody").html(tr);
				checkboxanyone();
			})
		}
		//查询所有角色返回一个字符串
		function getroles(){
			$.post("${pageContext.request.contextPath }/accountrolecontroller/getRole",function(data){
				for (var i = 0; i < data.length; i++) {
					roles += "<input class='checkboxrole' name='id[]' lay-skin='primary' type='checkbox' title='"+data[i].roleName+"' roleId='"+data[i].roleId+"' value='"+data[i].roleId+"'>"+
					"<div roleId='"+data[i].roleId+"' class='layui-unselect layui-form-checkbox' lay-skin='primary'><span>"+data[i].roleName+"</span><i class='layui-icon layui-icon-ok'></i></div>";
				}
			});
		}
		$("body").on("click",".layui-unselect.layui-form-checkbox",function(){
			if($(this).prev().prop("checked") == "true"||$(this).prev().prop("checked") == true){
				$(this).prev().prop("checked",false);
				$(this).removeClass("layui-form-checked");
				$("#allsubmit").css("display","inline-block");
			}else{
				$(this).addClass("layui-form-checked");
				$(this).prev().prop("checked",true);
				$("#allsubmit").css("display","inline-block");
			}
		})
		$("body").on("click",".layui-btn",function(event){
			event.preventDefault();
			var accountId = $(this).attr("accountId");
			doDelAccountRole(accountId);
			$($(this).siblings(".checkboxrole")).each(function(){
				if($(this).prop("checked") == "true"||$(this).prop("checked") == true){
					var a = $(this).attr("roleId");
					var roleId = a;
					var param = {
							accountId:accountId,
							roleId:roleId
					}
					console.log("角色id==="+roleId);
					console.log("用户id==="+accountId);
					$.ajax({
		     				url:"${pageContext.request.contextPath }/accountrolecontroller/doInsAccountRole",
		     				async:false,
		     				type:"post",
		     				data:param,
		     				success:function(data){
		     				}
					}) 
				}
				
			})
			alert("修改成功");
		})
		function doInsAccountRole(accountId,roleId){
			var param = {
					accountId:accountId,
					roleId:roleId
			}
			$.ajax({
     				url:"${pageContext.request.contextPath }/accountrolecontroller/doInsAccountRole",
     				async:false,
     				type:"post",
     				data:param,
     				success:function(data){
     					alert("修改成功");
     				}
			})
		} 
		function doDelAccountRole(accountId){
			var param = {
					accountId:accountId
			}
			$.post("${pageContext.request.contextPath }/accountrolecontroller/doDelAccountRole",param,function(data){
			})
		}
		function checkboxanyone(){
			var lastName = "";
			var param = {
					lastName:lastName
			}
			$.post("${pageContext.request.contextPath }/accountrolecontroller/getAccountAndRoleLikeAccountName",param,function(data){
				var	tr = "";
				for (var i = 0; i < data.length; i++) {
					var a = data[i].accountId;
					var c = 0;
					var d = 1;
					for (var j = 0; j < (data[i].roles).length; j++) {
						var b = "account"+a;
						$("#"+b).children("div[roleId='"+(data[i].roles)[j].roleId+"']").addClass("layui-form-checked");
						$("#"+b).children("div[roleId='"+(data[i].roles)[j].roleId+"']").prev().prop("checked",true);
					}
				}
			})
		}
		$("#likeprojectnamebutton").click(function(event){
			event.preventDefault();
			accountroletbody();
		})
		$("#allsubmit").click(function(){
			$(".rolestd").each(function(){
				var accountId = $(this).attr("accountId");
				doDelAccountRole(accountId);
				var mun=new Number(1);
				$(this).children("div[class*='layui-form-checked']").each(function(){
					var roleId = $(this).attr("roleId");
					var param = {
							accountId:accountId,
							roleId:roleId
					}
					mun++;
					$.ajax({
		     				url:"${pageContext.request.contextPath }/accountrolecontroller/doInsAccountRole",
		     				async:false,
		     				type:"post",
		     				data:param,
		     				success:function(data){
		     				}
					}) 
				})
				console.log(mun);
			})
			alert("修改成功");
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
        
           	<div class="layui-fluid">
           	 <form class="layui-form layui-col-space5">
                            <div class="layui-input-inline layui-show-xs-block">
                               <input class="layui-input" id="likeprojectnameinput"  placeholder="用户名称" name="cate_name"></div>
                           <div class="layui-input-inline layui-show-xs-block">
                              <button class="layui-btn" id="likeprojectnamebutton"><i class="iconfont">&#xe6ac;</i>&nbsp;&nbsp;&nbsp;&nbsp;查询</button>
                       </div>
              </form>
              <br>
        <div class="layui-row">
            <form action="" method="post" class="layui-form layui-form-pane">
                <div class="layui-form-item layui-form-text">
                    <label class="layui-form-label">
                       用户与角色关系管理
                    </label>
                    <table  class="layui-table layui-input-block">
                        <tbody id="accountroletbody">
                            <tr>
                                <td style="width:100px;">
                                <span><i class="iconfont">&#xe732;</i>&nbsp;&nbsp;吉祥</span>
                                </td>
                                <td>
                                    <div class="layui-input-block">
                                        <input name="id[]" lay-skin="primary" type="checkbox" title="用户停用" value="2"> 
                                        <input name="id[]" lay-skin="primary" type="checkbox" title="用户停用" value="2"> 
                                        <input name="id[]" lay-skin="primary" type="checkbox" title="用户停用" value="2"> 
                                        <input name="id[]" lay-skin="primary" type="checkbox" title="用户停用" value="2"> 
                                        <button class="layui-btn"><i class="iconfont">&#xe70a;</i>&nbsp;&nbsp;&nbsp;&nbsp;提交</button> 
                                    </div>
                                </td>
                            </tr>
                        </tbody>
                    </table>
                </div>
            </form>
        </div>
        	 <div style="float:right;">
         		<button id="allsubmit" class="displaynone"
         		style="background: #009688; width: 71.38px;height: 30px; display: none;background-color: #009688;color: #fff;white-space: nowrap;text-align: center;border: none; border-radius: 2px;cursor: pointer;"
         		><i class='iconfont'>&#xe70a;</i>&nbsp;&nbsp;&nbsp;&nbsp;提交</button>
        	 </div>
    </div>
   
        </div>
        <div class="page-content-bg"></div>
        <!-- 右侧主体结束 -->
        <!-- 中部结束 -->
<script>
        /* layui.use(['form','layer'], function(){
            $ = layui.jquery;
          var form = layui.form
          ,layer = layui.layer; */
       /*  form.on('checkbox(father)', function(data){

            if(data.elem.checked){
                $(data.elem).parent().siblings('td').find('input').prop("checked", true);
                form.render(); 
            }else{
               $(data.elem).parent().siblings('td').find('input').prop("checked", false);
                form.render();  
            }
        });  */
          
        
    </script>
</body>
</html>