<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html class="no-js">

<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Connectf Frontend</title>
<link rel="stylesheet" type="text/css" href="/resources/stylesheets/theme.css">
<link rel="stylesheet" type="text/css" href="/resources/themes/default/easyui.css">
<link rel="stylesheet" type="text/css" href="/resources/themes/icon.css">
<link rel="stylesheet" type="text/css" href="/resources/themes/demo.css">
<!-- Bootstrap -->
<link href="/resources/bootstrap/css/bootstrap.min.css" rel="stylesheet"
	media="screen">
<link href="/resources/bootstrap/css/bootstrap-responsive.min.css" rel="stylesheet"
	media="screen">
<link href="/resources/vendors/easypiechart/jquery.easy-pie-chart.css"
	rel="stylesheet" media="screen">
<link href="/resources/assets/styles.css" rel="stylesheet" media="screen">
<link href="/resources/bootstrap/css/new-style.css" rel="stylesheet" media="screen">


<script type="text/javascript" src="/resources/lib/jquery-1.11.1.min.js"></script>
<script type="text/javascript" src="/resources/lib/jquery.easyui.min.js"></script>

<!--/.fluid-container-->
<script src="/resources/bootstrap/js/bootstrap.min.js"></script>
<script src="/resources/vendors/easypiechart/jquery.easy-pie-chart.js"></script>
<script src="/resources/assets/scripts.js"></script>
<script>
	$(function() {
		// Easy pie charts
		$('.chart').easyPieChart({
			animate : 1000
		});
	});
</script>

<!-- HTML5 shim, for IE6-8 support of HTML5 elements -->
<!--[if lt IE 9]>
            <script src="http://html5shim.googlecode.com/svn/trunk/html5.js"></script>
        <![endif]-->
<!--  <script src="vendors/modernizr-2.6.2-respond-1.1.0.min.js"></script>-->
<style type="text/css">

</style>
<script>
	$(function() {
		$('.tree-box .item').draggable({
			revert : true,
			proxy : 'clone'
		});
		$('.axis-box td.drop').droppable({
			onDragEnter : function() {
				$(this).addClass('over');
			},
			onDragLeave : function() {
				$(this).removeClass('over');
			},
			onDrop : function(e, source) {
				$(this).removeClass('over');
				if ($(source).hasClass('assigned')) {
					$(this).append(source);
				} else {
					var c = $(source).clone().addClass('assigned');
					//c.addClass('easyui-menubutton');
					//c.css("data-options","menu:'#mm1'");
					//alert($(source).html());
					//alert($(this).html());
					//$("div").children("a")
					//alert($(this).$("div").children("a")[0].html());
					//alert($("a", this).html($(source).html()));
					//c.append("<a href=\"#\" class=\"easyui-menubutton\" data-options=\"menu:'#mm2'\">Ok</a>");

					//$(this).addClass('assigned');
					$("span", this).removeAttr("style");
					$("button", this).html($(source).html());

					//$(this).empty().append(c);
					c.draggable({
						revert : true
					});
					//window.location.reload();//刷新当前页面
				}
			}
		});
	});
</script>
<script type="text/javascript">
	function newUser() {
		$('#dlg').dialog('open').dialog('setTitle', '筛选器');
		$('#fm').form('clear');
	}

	function deleteField(obj) {
	//alert("2");
		//alert($(obj).parent().parent().parent().parent().parent(".span").html());
		$(obj).parent().parent().parent().parent().attr("style", "visibility:hidden");
		//$(obj).parent().parent().parent().parent().parent().removeAttr(".assigned");
		//alert(obj.parentNode.nextSibling.tagName);
		//alert($(obj).parent().siblings('span').html());
		//$("span", obj).attr("style", "visibility:hidden");
	}
</script>
</head>

<body>

	<div class="navbar navbar-fixed-top">
		<div class="navbar-inner">
			<div class="container-fluid">
				<a class="btn btn-navbar" data-toggle="collapse"
					data-target=".nav-collapse"> <span class="icon-bar"></span> <span
					class="icon-bar"></span> <span class="icon-bar"></span>
				</a> <a class="brand" href="#">Connectf</a>
				<div class="nav-collapse collapse">
					<ul class="nav pull-right ">
						<li class="dropdown"><a href="#" role="button"
							class="dropdown-toggle" data-toggle="dropdown"> <i
								class="icon-user"></i>  <i class="caret"></i>

						</a>
							<ul class="dropdown-menu">
								<li><a tabindex="-1" href="#">Profile</a></li>
								<li class="divider"></li>
								<li><a tabindex="-1" href="login.html">Logout</a></li>
							</ul></li>
					</ul>
					<ul class="nav">
						<li class="active"><a href="#">交互区</a></li>
						<li class="dropdown"><a href="#" role="button"
							class="dropdown-toggle" data-toggle="dropdown">数据源<i
								class="caret"></i>

						</a>
							<ul class="dropdown-menu">
								<li><a href="/form" tabindex="-1" href="#">选择数据源</a></li>
								<!--li><a tabindex="-1" href="#">选择数据集</a></li>
								<li><a tabindex="-1" href="#">设定数据</a></li-->
							</ul></li>
						<li class="dropdown"><a href="#" data-toggle="dropdown"
							class="dropdown-toggle">帮助 <b class="caret"></b>

						</a>
							<ul class="dropdown-menu" id="menu1">
								<li><a href="#">视频教程</a></li>
								<li class="divider"></li>
								<li><a href="#">用户手册</a></li>
							</ul></li>

						<li class="dropdown"><a href="#" role="button"
							class="dropdown-toggle" data-toggle="dropdown">关于 <i
								class="caret"></i>

						</a>
							<ul class="dropdown-menu">
								<li><a tabindex="-1" href="http://www.connectf.com">关于Connectf</a></li>
							</ul></li>
					</ul>
				</div>
				<!--/.nav-collapse -->
			</div>
		</div>
	</div>
		<div class="row-fluid">
			<div class="span3 left-wd" id="sidebar">
				<div class="nav nav-list bs-docs-sidenav nav-list-bg" >
					<div class="tree-box" align="left">
							<div class="common">常用数据源</div>
							<div class="common-box">
								<div class="common-word">测试数据源1</div>
								<div class="common-word">测试数据源2</div>
							</div>


					</div>
				</div>
			</div>

			<!--/span-->
			<div class="span9 right-wd" id="content">
				<div class="row-fluid"></div>
				<div class="row-fluid">
					<!-- block -->
					<div class="block">
						<div class="navbar navbar-inner block-header">
							<div class="muted pull-left">内容</div>
							<div class="pull-right">

							</div>
						</div>
						<div class="block-content collapse in">
							<div class="row-fluid padd-bottom">
								<div class="video-box">
									<div class="video-butbox">
										<div class="video-img"><img src="/resources/bootstrap/img/video-img.png" alt=""></div>
										<div class="video-word"><a href="/blank11"> 视频教程 点击观看</a></div>
									</div>
									<div class="video-butbox">
										<div class="video-img"><img src="/resources/bootstrap/img/video-img2.png" alt=""></div>
										<div class="video-word"><a href="">用户手册 点击下载</a></div>
									</div>

								</div>
								<div class="video-box">
									<div class="video-link">
										<div class="video-icom"><img src="/resources/bootstrap/img/video-img3.png" alt=""></div>
										<div class="video-icom"><img src="/resources/bootstrap/img/video-img4.png" alt=""></div>
										<div class="video-icom"><img src="/resources/bootstrap/img/video-img5.png" alt=""></div>
										<div class="video-icom"><img src="/resources/bootstrap/img/video-img7.png" alt=""></div>
										<div class="video-icom"><img src="/resources/bootstrap/img/video-img6.png" alt=""></div>
										<div class="wideo-icomword">分享到：</div>
									</div>
								</div>
							</div>
						</div>
					</div>
					<!-- /block -->
				</div>
			</div>
		</div>

		<!-- 筛选器 -->
		<div id="dlg" class="easyui-dialog"
			style="width: 400px; height: 280px; padding: 10px 20px" closed="true"
			buttons="#dlg-buttons">
			<div class="ftitle">User Information</div>
			<form id="fm" method="post" novalidate>
				<div class="fitem">
					<label>First Name:</label> <input name="firstname"
						class="easyui-validatebox" required="true">
				</div>
				<div class="fitem">
					<label>Last Name:</label> <input name="lastname"
						class="easyui-validatebox" required="true">
				</div>
				<div class="fitem">
					<label>Phone:</label> <input name="phone">
				</div>
				<div class="fitem">
					<label>Email:</label> <input name="email"
						class="easyui-validatebox" validType="email">
				</div>
			</form>
		</div>
		<div id="dlg-buttons">
			<a href="#" class="easyui-linkbutton" iconCls="icon-ok"
				onclick="saveUser()">Save</a> <a href="#" class="easyui-linkbutton"
				iconCls="icon-cancel" onclick="javascript:$('#dlg').dialog('close')">Cancel</a>
		</div>
		<hr>
		<footer>
		<p>&copy; Connectf Dev Team 2016</p>
		</footer>

	<!-- ECharts单文件引入 -->
	<script type="text/javascript" src="/resources/echarts/build/dist/echarts.js"></script>

</body>

</html>