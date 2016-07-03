<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Basic Accordion - jQuery EasyUI Demo</title>
	<link rel="stylesheet" type="text/css" href="themes/default/easyui.css">
	<link rel="stylesheet" type="text/css" href="themes/icon.css">
	<link rel="stylesheet" type="text/css" href="stylesheets/demo.css">
	<script type="text/javascript" src="lib/jquery-1.11.1.min.js"></script>
	<script type="text/javascript" src="lib/jquery.easyui.min.js"></script>
</head>
<body>
	<h2>Basic Accordion</h2>
	<p>Click on panel header to show its content.</p>
	<div style="margin:20px 0 10px 0;"></div>
	<div class="easyui-accordion" data-options="selected:false" style="width:500px;">

		<div title="ChartTypeSelect" style="overflow:hidden;padding:10px;">
			<ul class="easyui-tree">
				<li>
					<span>Foods</span>
					<ul>
						<li>
							<span>Fruits</span>
							<ul>
								<li>apple</li>
								<li>orange</li>
							</ul>
						</li>
						<li>
							<span>Vegetables</span>
							<ul>
								<li>tomato</li>
								<li>carrot</li>
								<li>cabbage</li>
								<li>potato</li>
								<li>lettuce</li>
							</ul>
						</li>
					</ul>
				</li>
			</ul>
		</div>
	</div>
</body>
</html>