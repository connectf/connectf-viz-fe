<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Basic SplitButton - jQuery EasyUI Demo</title>
	<link rel="stylesheet" type="text/css" href="../../themes/default/easyui.css">
	<link rel="stylesheet" type="text/css" href="../../themes/icon.css">
	<link rel="stylesheet" type="text/css" href="../demo.css">
	<script type="text/javascript" src="../../jquery.min.js"></script>
	<script type="text/javascript" src="../../jquery.easyui.min.js"></script>
</head>
<body>
	<h2>Basic SplitButton</h2>
	<p>Move mouse over the arrow area of button to drop down menu.</p>
	<div style="margin:20px 0;"></div>
	<div class="easyui-panel" style="padding:5px;">
		<a href="#" class="easyui-linkbutton" data-options="plain:true">Home</a>
		<a href="#" class="easyui-splitbutton" data-options="menu:'#mm1',iconCls:'icon-edit'">Edit</a>
		<a href="#" class="easyui-splitbutton" data-options="menu:'#mm2',iconCls:'icon-ok'">Ok</a>
		<a href="#" class="easyui-menubutton" data-options="menu:'#mm3',iconCls:'icon-help'">Help</a>
	</div>
	<div id="mm1" style="width:150px;">
		<div data-options="iconCls:'icon-undo'">Undo</div>
		<div data-options="iconCls:'icon-redo'">Redo</div>
		<div class="menu-sep"></div>
		<div>Cut</div>
		<div>Copy</div>
		<div>Paste</div>
		<div class="menu-sep"></div>
		<div>
			<span>Toolbar</span>
			<div>
				<div>Address</div>
				<div>Link</div>
				<div>Navigation Toolbar</div>
				<div>Bookmark Toolbar</div>
				<div class="menu-sep"></div>
				<div>New Toolbar...</div>
			</div>
		</div>
		<div data-options="iconCls:'icon-remove'">Delete</div>
		<div>Select All</div>
	</div>
	<div id="mm2" style="width:100px;">
		<div data-options="iconCls:'icon-ok'">Ok</div>
		<div data-options="iconCls:'icon-cancel'">Cancel</div>
	</div>
	<div id="mm3" style="width:150px;">
		<div>Help</div>
		<div>Update</div>
		<div>
			<span>About</span>
			<div class="menu-content" style="padding:10px;text-align:left">
				<img src="http://www.jeasyui.com/images/logo1.png" style="width:150px;height:50px">
				<p style="font-size:14px;color:#444">Try jQuery EasyUI to build your modern, interactive, javascript applications.</p>
			</div>
		</div>
	</div>

</body>
</html>