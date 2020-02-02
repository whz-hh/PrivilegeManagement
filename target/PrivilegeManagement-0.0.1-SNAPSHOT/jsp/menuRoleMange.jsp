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
        <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/css/bootstrap.min.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/font.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/xadmin.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/theme49.min.css">
        <!-- <link rel="stylesheet" href="./css/theme5.css"> -->
        <script src="${pageContext.request.contextPath}/lib/layui/layui.js" charset="utf-8"></script>
        <script type="text/javascript" src="${pageContext.request.contextPath}/js/xadmin.js"></script>
        <script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery.min.js"></script>
		<script src="${pageContext.request.contextPath }/js/bootstrap.min.js" type="text/javascript" charset="utf-8"></script>
		<script src="${pageContext.request.contextPath }/js/bootbox.min.js"></script>

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
<style>
	.role{
		background-color: #5FB878;
	}
	.project{
		font-size: 18px;
		text-align: center;
		color: black;
		font-family: Microsoft YaHei;
	}
	.layui-table td{
		font-size:16px !important
	}
    </style>
    <script type="text/javascript">
    		$(function(){
    			showProject();
    			showRoles();
    			var Roles;
    			var cid='';
    			$(document).on("click",".layui-form-unchecked",function(){
    				$(this).prev().prop("checked",true);
    				$(this).addClass("layui-form-checked");
    				$(this).removeClass("layui-form-unchecked");
    				var ids=$(this).parent().attr("ids");
    				var ck='';
    				$(this).siblings("input").each(function(){
    					if($(this).prop("checked")){
    					ck+=$(this).attr("roleId");
    					}
    				});
    				if(ids==ck){
    					$(this).siblings("button").css({
    						"display":"none"
    					});
    				}else{
    					$(this).siblings("button").css({
    						"display":"inline-block"
    					});
    				}
    			});
    			$(document).on("click",".layui-form-checked",function(){
    				$(this).prev().prop("checked",false);
    				$(this).addClass("layui-form-unchecked");
    				$(this).removeClass("layui-form-checked");
    				var ids=$(this).parent().attr("ids");
    				var ck='';
    				$(this).siblings("input").each(function(){
    					if($(this).prop("checked")){
    					ck+=$(this).attr("roleId");
    					}
    				});
    				if(ids==ck){
    					$(this).siblings("button").css({
    						"display":"none"
    					});
    				}else{
    					$(this).siblings("button").css({
    						"display":"inline-block"
    					});
    				}
    			});
    			//保存修改
    			$(document).on("click",".update",function(){
    				var menuId=$(this).attr("menuId");
    				var projectId=$(this).attr("projectId");
    				var ids='';
    				$(this).siblings("input").each(function(){
    					if($(this).prop("checked")){
    					ids+=$(this).attr("roleId")+":";
    					}
    				});
    				var cid=$(this).parent().parent().attr("fid");
    				$.post("${pageContext.request.contextPath}/roleMenuController/doInsertRoleMenu",{ins:ids,menuId:menuId},function(data){
    					if(data==true||data=="true"){
    						alert("修改成功");
    					}else{
    						alert("修改失败,子菜单还有其他角色使用");
    					}
    					/* if(cid.length==6){
    						var cid1=cid.substring(0,3);
    						$("tr[cate-id='project"+projectId+"']").find(".x-show").click().click();
    						$("tr[cate-id='"+cid1+"']").find(".x-show2").click();
    						$("tr[cate-id='"+cid+"']").find(".x-show2").click();
    					}else if(cid.length==3){
    						$("tr[cate-id='project"+projectId+"']").find(".x-show").click().click();
    						$("tr[cate-id='"+cid+"']").find(".x-show2").click();
    					}else{
    						$("tr[cate-id='project"+projectId+"']").find(".x-show").click().click();
    					} */
    					var fid=$("tr[cate-id='"+cid+"']").attr("fid");
    					while(fid!=0){
    						cid+=":"+fid;
    						fid=$("tr[cate-id='"+fid+"']").attr("fid");
    					}
    					var cids=cid.split(":");
    					for(var i=cids.length-1;i>=0;i--){
    						console.log(cids[i]);
    						if(i==cids.length-1){
    						$("tr[cate-id='"+cids[i]+"']").find(".x-show").click().click();
    						}else{
    						$("tr[cate-id='"+cids[i]+"']").find(".x-show2").click().click().click();
    						}
    					}
    				});
					return false;
    			});
    			function showRoles(){
    				$.post("${pageContext.request.contextPath}/roleController/getAllRole",function(data){
    					data=eval(data);
    					Roles=data;
    					/* var span="<tbody><tr><td class='tb_bg'><label for=''><font style='font-size: 14px; color: red;'></font>所有角色</label></td><td>";
    					for(var i=0;i<data.length;i++){
    						span+="<span class='layui-btn unclick' roleId='"+data[i].roleId+"'  >"+data[i].roleName+"</span>";
    					}
    					span+="</td></tr></tbody>";
    					$("#xztb").html(span); */
    				});				
    			}
    			$(".serch").click(function(event){
    				event.preventDefault();
    				showProject();
    			});
    			//显示所有的项目
    			function showProject(){
    				var projectName=$(".projectName").val();
    				$.post("${pageContext.request.contextPath}/projectcontroller/getProjectLikeProjectName",{projectName:projectName},function(data){
    					data=eval(data);
    					var tr="";
    					for(var i=0;i<data.length;i++){
    						tr+="<tr cate-id='project"+data[i].projectId+"' fid='0' >"+
    						"<td><i class='layui-icon x-show ' status='true' projectId='"+data[i].projectId+"'>&#xe623;</i><span class=project>"+data[i].projectName+"</span></td>"+
    						"<td ></td></tr>";
    					}
    					$(".x-cate").html(tr);
    					
    				});
    			}
    			//点击项目获得该项目的所有一级菜单
    			$(document).on("click",".x-show",function(){
    				var ths=$(this);
    				if($(this).attr('status')=='true'){
    						$(this).html('&#xe625;'); 
    	                    $(this).attr('status','false');
    	                    var projectId=$(this).attr("projectId");
    	    				$.post("${pageContext.request.contextPath}/menucontroller/getMenuByProjectId",{projectId:projectId ,menuGrade:''},function(data){
    	    					data=eval(data);
    	    					var tr="";
    	    					for(var i=0;i<data.length;i++){
    	    						tr+="<tr cate-id='"+data[i].menuId+"' fid='project"+data[i].projectId+"' >"+
    	                          	"<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"+
    	                            "<i class='layui-icon x-show2' status='true' menuGrade='"+data[i].menuGrade+"' projectId='"+data[i].projectId+"' cid='"+data[i].menuId+"'>&#xe623;</i>"+data[i].menuName+"</td>"+
    	                            getRole(data[i].roles)+
    	                            "<button class='layui-btn update' menuId='"+data[i].menuId+"' style='display:none'><i class='iconfont'>&#xe70a;</i>&nbsp;&nbsp;&nbsp;&nbsp;保存</button>"+
    	                          	"</td></tr>";
    	    					}
	    	                    $("tbody tr[fid='project"+projectId+"']").remove();
    	    					$(".x-cate tr[cate-id='project"+projectId+"']").after(tr);
	   	    					if($("tbody tr[fid='project"+projectId+"']").length==0){
	   	    						alert("该项目没有菜单，请先添加菜单");
	   	    						ths.html('&#xe623;');
	   	    	                    ths.attr('status','true');
	   	    					}
    	    				});
    				}else{
    					cateIds = [];
                        $(this).html('&#xe623;');
                        $(this).attr('status','true');
                        cateId = $(this).parents('tr').attr('cate-id');
                        getCateId(cateId);
                        for (var i in cateIds) {
                            $("tbody tr[cate-id="+cateIds[i]+"]").hide().find('.x-show').html('&#xe623;').attr('status','true');
                        }
    					
    				}
    				
    			});
    			function getRole(roles){
    				var span="";
    				var ids='';
    				for(var i=0;i<Roles.length;i++){
    					var flag=false;
    					for(var j=0;j<roles.length;j++){
    						if(Roles[i].roleId==roles[j].roleId){
    							flag=true;
    							ids+=Roles[i].roleId;
    						}
        				}
   						if(flag){
   							span+="<input type='checkbox' roleId='"+Roles[i].roleId+"' title='"+Roles[i].roleName+"'  checked=''><div class='layui-unselect layui-form-checkbox layui-form-checked'><span>"+Roles[i].roleName+"</span><i class='layui-icon layui-icon-ok'></i></div>";
   						}else{
   							span+="<input type='checkbox' roleId='"+Roles[i].roleId+"' title='"+Roles[i].roleName+"' ><div class='layui-unselect layui-form-checkbox layui-form-unchecked' ><span>"+Roles[i].roleName+"</span><i class='layui-icon layui-icon-ok'></i></div>";
   						}
    				}
    				span="<td ids='"+ids+"'>"+span;
    				return span;
    			}
    			//点击项目获得该项目的所有二级菜单/或者三级菜单
    			$(document).on("click",".x-show2",function(){
    				var ths=$(this);
    				if($(this).attr('status')=='true'){
    						$(this).html('&#xe625;'); 
    	                    $(this).attr('status','false');
    	                    var menuGrade=$(this).attr("menuGrade");
    	                    var projectId=$(this).attr("projectId");
    	                    var fid=$(this).attr("cid");
    	                    var nextMenu="";
    	    				$.post("${pageContext.request.contextPath}/menucontroller/getMenuByProjectId",{projectId:projectId ,menuGrade:menuGrade},function(data){
    	    					data=eval(data);
    	    					var tr="";
    	    					for(var i=0;i<data.length;i++){
	    	                    	nextMenu="<button class='layui-btn layui-btn-warm layui-btn-xs' menuGrade='"+data[i].menuGrade+"' projectId='"+data[i].projectId+"' cid='"+data[i].menuId+"'  ><i class='layui-icon'>&#xe642;</i>添加子菜单</button>";
	    	                    	nextme="<i class='layui-icon x-show2' status='true' menuGrade='"+data[i].menuGrade+"' projectId='"+data[i].projectId+"' cid='"+data[i].menuId+"'>&#xe623;</i>";
		    	                    if(menuGrade.length==6){
		    	                    	nextMenu="";
		    	                    	nextme="&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;";
		    	                    }
    	    						tr+="<tr cate-id='"+data[i].menuId+"' fid='"+fid+"' >"+
    	                          	"<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"+
    	                          	nextme+data[i].menuName+"</td>"+
    	                            getRole(data[i].roles)+
    	                            "<button class='layui-btn update' menuId='"+data[i].menuId+"' projectId='"+projectId+"' style='display:none'><i class='iconfont'>&#xe70a;</i>&nbsp;&nbsp;&nbsp;&nbsp;保存</button>"+
    	                          	"</td></tr>";
    	    					}
	    	                    $("tbody tr[fid='"+fid+"']").remove();
    	    					$(".x-cate tr[cate-id='"+fid+"']").after(tr);
	   	    					if($("tbody tr[fid='"+fid+"']").length==0){
	   	    						alert("该菜单没有子菜单，请先添加子菜单");
	   	    						ths.html('&#xe623;');
	   	    	                    ths.attr('status','true');
	   	    					}
    	    				});
    				}else{
    					cateIds = [];
                        $(this).html('&#xe623;');
                        $(this).attr('status','true');
                        cateId = $(this).parents('tr').attr('cate-id');
                        getCateId(cateId);
                        for (var i in cateIds) {
                            $("tbody tr[cate-id="+cateIds[i]+"]").hide().find('.x-show').html('&#xe623;').attr('status','true');
                        }
    					
    				}
    				
    			});
    		});
    </script>
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
           	 <div class="x-nav">
            <span class="layui-breadcrumb">
                <a href="">首页</a>
               	<a href="">菜单管理</a>
                <a href="">菜单管理</a>
                <a>
                <cite>菜单与角色管理管理</cite></a>
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
                                    <input class="layui-input projectName" placeholder="项目名称"  name="cate_name"></div>
                                <div class="layui-input-inline layui-show-xs-block">
                                    <button class="layui-btn  serch"><i class="layui-icon"></i>搜索</button>
                                </div>
                            </form>
                            <hr>
                           <!--  <blockquote class="layui-elem-quote">每个tr 上有两个属性 cate-id='1' 当前分类id fid='0' 父级id ,顶级分类为 0，有子分类的前面加收缩图标<i class="layui-icon x-show" status='true'>&#xe623;</i></blockquote> -->
                        </div>
                      <!--   <div class="layui-card-header">
                            <button class="layui-btn layui-btn-danger" onclick="delAll()">
                                <i class="layui-icon"></i>批量删除</button>
                        </div> -->
                        <div class="layui-card-body " >
                            <table class="layui-table layui-form">
                              <tbody class="x-cate">
                              </tbody>
                            </table>
                        </div>
                        <!-- <div class="layui-card-body ">
                            <div class="page">
                                <div>
                                    <a class="prev" href="">&lt;&lt;</a>
                                    <a class="num" href="">1</a>
                                    <span class="current">2</span>
                                    <a class="num" href="">3</a>
                                    <a class="num" href="">489</a>
                                    <a class="next" href="">&gt;&gt;</a></div>
                            </div>
                        </div> -->
                    </div>
                </div>
            </div>
        </div>
        <!--添加按钮及bootstrap的模态框-->
		 
        <script>
          layui.use(['form'], function(){
            form = layui.form;
          });
          
           /*用户-删除*/
          function member_del(obj,id){
              layer.confirm('确认要删除吗？',function(index){
                  //发异步删除数据
                  $(obj).parents("tr").remove();
                  layer.msg('已删除!',{icon:1,time:1000});
              });
          }

          // 分类展开收起的分类的逻辑
          // 
          $(function(){
            $("tbody.x-cate tr[fid!='0']").hide();
            // 栏目多级显示效果
            $('.x-show').click(function () {
                if($(this).attr('status')=='true'){
                    $(this).html('&#xe625;'); 
                    $(this).attr('status','false');
                    cateId = $(this).parents('tr').attr('cate-id');
                    $("tbody tr[fid="+cateId+"]").show();
               }else{
                    cateIds = [];
                    $(this).html('&#xe623;');
                    $(this).attr('status','true');
                    cateId = $(this).parents('tr').attr('cate-id');
                    getCateId(cateId);
                    for (var i in cateIds) {
                        $("tbody tr[cate-id="+cateIds[i]+"]").hide().find('.x-show').html('&#xe623;').attr('status','true');
                    }
               }
            })
          })

          var cateIds = [];
          function getCateId(cateId) {
              $("tbody tr[fid="+cateId+"]").each(function(index, el) {
                  id = $(el).attr('cate-id');
                  cateIds.push(id);
                  getCateId(id);
              });
          }
   
        </script>
        </div>

</body>
</html>