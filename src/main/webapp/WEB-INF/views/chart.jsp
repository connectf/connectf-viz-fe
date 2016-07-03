<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>

<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Connectf Viz Magic</title>
<meta name="_csrf" content="${_csrf.token}"/>
<meta name="_csrf_header" content="${_csrf.headerName}"/>
<link rel="stylesheet" type="text/css" href="/resources/stylesheets/theme.css">
<link rel="stylesheet" type="text/css" href="/resources/themes/default/easyui.css">
<link rel="stylesheet" type="text/css" href="/resources/themes/icon.css">
<link rel="stylesheet" type="text/css" href="/resources/stylesheets/demo.css">
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

<link rel="stylesheet" type="text/css" href="/resources/DataTables-1.10.12/media/css/jquery.dataTables.css">

<script type="text/javascript" language="javascript" src="/resources/DataTables-1.10.12/media/js/jquery.dataTables.js"></script>

<script type="text/javascript" src="/resources/lib/jquery.easyui.min.js"></script>

<!--/.fluid-container-->
<script src="/resources/bootstrap/js/bootstrap.min.js"></script>

<script src="/resources/vendors/easypiechart/jquery.easy-pie-chart.js"></script>

<script src="/resources/assets/scripts.js"></script>

<script type="text/javascript" src="/resources/Highcharts-4.2.1/js/highcharts.js"></script>

<script type="text/javascript" src="/resources/Highcharts-4.2.1/js/modules/exporting.js"></script>

<!-- ECharts单文件引入 -->
<%--<script type="text/javascript" src="/resources/echarts/build/dist/echarts.js"></script>--%>
<script type="text/javascript" src="/resources/echarts/echarts.min.js"></script>
<script type="text/javascript" src="/resources/echarts/china.js"></script>

<script>
	$(function() {
		// Easy pie charts
		$('.chart').easyPieChart({
			animate : 1000
		});
	});
</script>
<script>
	$(document).ready(function(){
		var token = $("meta[name='_csrf']").attr("content");
		var header = $("meta[name='_csrf_header']").attr("content");

		var getAllAttributes = function(){
			$.ajax({
				type:"POST",
				async:true,
				dataType: 'json',
				url:"/getAttributeUserLocals4DataSet4Tree",
				data:{},
				beforeSend: function(xhr) {
					xhr.setRequestHeader(header,token);
				},
				success: function(object){
					//fill up sidebar with treeJsonDataArray
					$('#tt').tree({
						dnd:true,
						data:object
					});
				},
				error:function(XMLHttpRequest, textStatus, errorThrown) {
					alert(XMLHttpRequest.status);
					alert(XMLHttpRequest.readyState);
					alert(textStatus);
				}
			});
		};

		getAllAttributes();
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
	var attrJsonObjArray = new Array();//store attribute objects from axis row and column as Json Object

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
//					console.log(typeof $(source).html());
//					console.log($(source).html());
					//alert($(this).html());
					//$("div").children("a")
					//alert($(this).$("div").children("a")[0].html());
					//alert($("a", this).html($(source).html()));
					//c.append("<a href=\"#\" class=\"easyui-menubutton\" data-options=\"menu:'#mm2'\">Ok</a>");

					//$(this).addClass('assigned');
					$("span", this).removeAttr("style");

//					alert($(source).html().match(/<div.*>\w+<\/div>/)[0]);
					regexForAttrDiv = /<div.*>[\u4E00-\u9FA5\uF900-\uFA2D\w]+<\/div>/;
					var result = $(source).html().match(regexForAttrDiv);//"1 plus 2 equals 3".match(/\d+/g) ==> returns ["1", "2", "3"]
					if (result != null) {
//						var attrDiv = result[0]; // get whole match, typeof result[0] is string
						var currentTime = new Date().getTime().toString();//获取当前时间(从1970.1.1开始的毫秒数) regard currentTime as Json Object id
						//传递HTML文本字符串给$()方法，jQuery根据传入的文本创建好HTML元素并封装为jQuery对象返回
						var attrDiv = $(result[0]);//attrDiv is jQuery object
						var tmpJsonObj = {};
						tmpJsonObj.id = currentTime;
						tmpJsonObj.attributeId = attrDiv.attr("id");
						tmpJsonObj.attributeName = attrDiv.attr("name");
						tmpJsonObj.functionType = "null";
						tmpJsonObj.op = "";
						tmpJsonObj.parameter = "";
						attrDiv = attrDiv.attr("id", currentTime);//attrDiv is jQuery object
						attrJsonObjArray.push(tmpJsonObj);
					}
					$("button", this).html(attrDiv);

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
	/*
	 *  方法:Array.remove(index) 通过遍历,重构数组
	 *  功能:删除数组元素.
	 *  参数:index删除元素的下标.
	 */
	Array.prototype.remove = function(index) {
		if (isNaN(index) || index > this.length) {
			return false;
		}

		for (var i = 0, n = 0; i < this.length; i++) {
			if (this[i] != this[index]) {
				this[n++] = this[i];
			}
		}
		this.length -= 1;
	}

	function dialogSave(event){
		updateFilterDiv(event.data);
	}

	function FilterDialogSetting(obj, htmlElement) {
		$('#dlg-buttons').empty();//clear #dlg-buttons
//		var attrObjectId = $($(obj).parent().parent().prev().html()).attr("id");//根据HTML文本字符串创建HTML元素并封装为jQuery对象返回
		var attrObjectId = $(htmlElement).attr("id");//根据HTML文本字符串创建HTML元素并封装为jQuery对象返回

		for(var i = 0; i < attrJsonObjArray.length; i++) { // For each index in the array
			if (attrObjectId == attrJsonObjArray[i].id) {
				var fieldName = attrJsonObjArray[i].attributeName;
				var op = attrJsonObjArray[i].op;
				var parameter = attrJsonObjArray[i].parameter;
				var functionType = attrJsonObjArray[i].functionType;
			}
		}

//		var fieldName = $(obj).parent().parent().prev().children().html();
//		alert($(obj).parent().parent().prev().children().text()); both are effective
//		alert($(obj).parent().parent().prev().children().html());

		//set value to #dlg
		if (functionType == "null") {
			$("#dlg input[name='fieldname']").val(fieldName);
		}
		else {
			$("#dlg input[name='fieldname']").val(functionType + "(" + fieldName + ")");
		}

		if (op == "") {
			$("#relationOperator").get(0).selectedIndex = 0;  //设置Select索引值为0的项选中
		}
		else if (op == "Less") {
			$("#relationOperator").get(0).selectedIndex = 1;  //设置Select索引值为1的项选中
		}
		else if (op == "LessEqual") {
			$("#relationOperator").get(0).selectedIndex = 2;  //设置Select索引值为2的项选中
		}
		else if (op == "Large") {
			$("#relationOperator").get(0).selectedIndex = 3;  //设置Select索引值为3的项选中
		}
		else if (op == "LargeEqual") {
			$("#relationOperator").get(0).selectedIndex = 4;  //设置Select索引值为4的项选中
		}
		else if (op == "Equal") {
			$("#relationOperator").get(0).selectedIndex = 5;  //设置Select索引值为5的项选中
		}
		else if (op == "NotEqual") {
			$("#relationOperator").get(0).selectedIndex = 6;  //设置Select索引值为6的项选中
		}
		else if (op == "Like") {
			$("#relationOperator").get(0).selectedIndex = 7;  //设置Select索引值为7的项选中
		}
		else if (op == "NotLike") {
			$("#relationOperator").get(0).selectedIndex = 8;  //设置Select索引值为8的项选中
		}

		if (parameter == "") {
			$("#dlg input[name='fieldValue']").val("");
		}
		else {
			$("#dlg input[name='fieldValue']").val(parameter);
		}

		//bind updateFilterDiv(objectId) to #dlg
//		$("#dlg-buttons a:first-child").bind("click", attrObjectId, dialogSave);//noneffective
//		$("#dlgsave").bind("click", attrObjectId, dialogSave);//sometimes it's effective;sometimes it's noneffective
		$("<a href='#' class='btn btn-primary btn_margin' iconCls='icon-ok' onclick='updateFilterDiv(" + attrObjectId + ")'>保存</a><a href='#' class='btn' iconCls='icon-cancel' onclick='cancelFilterDialog()'>取消</a>").prependTo("#dlg-buttons"); //insert content at start of target #dlg-buttons

		$('#dlg').dialog('open').dialog('setTitle', '筛选器');
//		$('#fm').form('clear');
	}

	function updateFilterDiv(objectId) {
		var existFlag = false;
		var fieldName = $("#dlg input[name='fieldname']").val();
//		alert("fieldName=" + fieldName);
		var selectedOption = $("#relationOperator option:selected");  //获取选中的项
//		alert(selectedOption.text() + "");   //拿到选中项的值
		var fieldValue = $("#dlg input[name='fieldValue']").val();
//		alert("fieldValue=" + fieldValue);

		if ($("#relationOperator").get(0).selectedIndex == 0) {
			alert("Please choose an operator");
//			$('#fm').form('clear');
//			$('#dlg-buttons').empty();//clear #dlg-buttons
			return false;
		}

		//update Json Object corresponding to the specified objectId
		for(var i = 0; i < attrJsonObjArray.length; i++) { // For each index in the array
			if (objectId == attrJsonObjArray[i].id) {
				var checkIndex = $("#relationOperator ").get(0).selectedIndex;   //获取Select选择的索引值
				switch(checkIndex) {
					case 1:
						attrJsonObjArray[i].op = "Less";
						break;
					case 2:
						attrJsonObjArray[i].op = "LessEqual";
						break;
					case 3:
						attrJsonObjArray[i].op = "Large";
						break;
					case 4:
						attrJsonObjArray[i].op = "LargeEqual";
						break;
					case 5:
						attrJsonObjArray[i].op = "Equal";
						break;
					case 6:
						attrJsonObjArray[i].op = "NotEqual";
						break;
					case 7:
						attrJsonObjArray[i].op = "Like";
						break;
					case 8:
						attrJsonObjArray[i].op = "NotLike";
						break;
					default:
						break;
				}
				attrJsonObjArray[i].parameter = fieldValue;
			}
		}

		//judge whether or not the current field filter exists in the filter div,
		// if exists, give a alert to show that you can't add one more identical field filter;
		// if not exist, add a new field filter
		$("#filter button > div").each(function(){
			if ($(this).attr("id") == objectId) {//this attribute Json Object's filter has been added		有则修改
				for(var i = 0; i < attrJsonObjArray.length; i++) { // For each index in the array
					if (objectId == attrJsonObjArray[i].id) {
						if (attrJsonObjArray[i].functionType == "null") {
//							$(this).html(attrJsonObjArray[i].attributeName + selectedOption.text().replace(/"/g, "") + fieldValue);
							$(this).html(attrJsonObjArray[i].attributeName);
						}
						else {
//							$(this).html(attrJsonObjArray[i].functionType + "(" + attrJsonObjArray[i].attributeName + ")" + selectedOption.text().replace(/"/g, "") + fieldValue);
							$(this).html(attrJsonObjArray[i].functionType + "(" + attrJsonObjArray[i].attributeName + ")");
						}
						existFlag = true;
						break;
					}
				}
			}
		});

		if (existFlag) {
		}
		else {//this attribute Json Object's filter is not added		无则添加
			for(var i = 0; i < attrJsonObjArray.length; i++) { // For each index in the array
				if (objectId == attrJsonObjArray[i].id) {
					//append filter to #filter
					if (attrJsonObjArray[i].functionType == "null") {
//						$("<div class='btn-group'><button data-toggle='dropdown' class='btn dropdown-toggle dropdown-wd'><div id='" + objectId + "'>" + attrJsonObjArray[i].attributeName + selectedOption.text().replace(/"/g, "") + fieldValue + "</div></button><ul class='dropdown-menu' style='z-index: 110011;'><li><a href='#' onclick='FilterDialogSetting(this, $(this).parent().parent().prev().html())'>筛选器...</a></li><li><a href='#' onclick='deleteFilter(this)'>移除</a></li></ul></div>").appendTo("#filter"); // Append html to #log
						$("<div class='btn-group'><button data-toggle='dropdown' class='btn dropdown-toggle dropdown-wd'><div id='" + objectId + "'>" + attrJsonObjArray[i].attributeName + "</div></button><ul class='dropdown-menu' style='z-index: 110011;'><li><a href='#' onclick='FilterDialogSetting(this, $(this).parent().parent().prev().html())'>筛选器...</a></li><li><a href='#' onclick='deleteFilter(this)'>移除</a></li></ul></div>").appendTo("#filter"); // Append html to #log
					}
					else {
//						$("<div class='btn-group'><button data-toggle='dropdown' class='btn dropdown-toggle dropdown-wd'><div id='" + objectId + "'>" + attrJsonObjArray[i].functionType + "(" + attrJsonObjArray[i].attributeName + ")" + selectedOption.text().replace(/"/g, "") + fieldValue + "</div></button><ul class='dropdown-menu' style='z-index: 110011;'><li><a href='#' onclick='FilterDialogSetting(this, $(this).parent().parent().prev().html())'>筛选器...</a></li><li><a href='#' onclick='deleteFilter(this)'>移除</a></li></ul></div>").appendTo("#filter"); // Append html to #log
						$("<div class='btn-group'><button data-toggle='dropdown' class='btn dropdown-toggle dropdown-wd'><div id='" + objectId + "'>" + attrJsonObjArray[i].functionType + "(" + attrJsonObjArray[i].attributeName + ")" + "</div></button><ul class='dropdown-menu' style='z-index: 110011;'><li><a href='#' onclick='FilterDialogSetting(this, $(this).parent().parent().prev().html())'>筛选器...</a></li><li><a href='#' onclick='deleteFilter(this)'>移除</a></li></ul></div>").appendTo("#filter"); // Append html to #log
					}
					break;
				}
			}

		}

		//close #dlg and clear #fm
		$('#dlg').dialog('close');
		$('#fm').form('clear');

		// Unbind all click handlers on first <a> element
//		$('dlg-buttons a:first-child').unbind();//noneffective
//		$('dlg-buttons a:first-child').unbind('click', dialogSave);//noneffective
//		$('#dlgsave').unbind('click', dialogSave);//sometimes it's effective;sometimes it's noneffective
		$('#dlg-buttons').empty();//clear #dlg-buttons
	}

	function deleteFilter(obj){
		var objectId = $($(obj).parent().parent().prev().html()).attr("id");//根据HTML文本字符串创建HTML元素并封装为jQuery对象返回
		//reset Json Object corresponding to the specified objectId
		for(var i = 0; i < attrJsonObjArray.length; i++) { // For each index in the array
			if (objectId == attrJsonObjArray[i].id) {
				attrJsonObjArray[i].op = "";
				attrJsonObjArray[i].parameter = "";
			}
		}
		obj.parentNode.parentNode.parentNode.parentNode.removeChild(obj.parentNode.parentNode.parentNode);
	}

	function deleteField(obj) {
//		alert($(obj).parent().parent().prev().html());
		var objectId = $($(obj).parent().parent().prev().html()).attr("id");//根据HTML文本字符串创建HTML元素并封装为jQuery对象返回
		//remove the deleted Json Object from attrJsonObjArray
/*		for(var i = 0; i < attrJsonObjArray.length; i++) { // For each index in the array
			if (objectId == attrJsonObjArray[i].id) {
				attrJsonObjArray.remove(i); //删除下标为i的元素
			}
		}*/

		//traversal the remained field on axis row and column
/*		var arrayStr = "";
		attrJsonObjArray.forEach(function(value, index, array) {arrayStr += (array[index].attributeName + ",");});
		alert(arrayStr);*/

		$(obj).parent().parent().parent().parent().attr("style", "visibility:hidden");
		$(obj).parent().parent().prev().empty();

		//$(obj).parent().parent().parent().parent().parent().removeAttr(".assigned");
		//alert(obj.parentNode.nextSibling.tagName);
		//alert($(obj).parent().siblings('span').html());
		//$("span", obj).attr("style", "visibility:hidden");
	}

	function cancelFilterDialog() {
		$('#dlg-buttons').empty();//clear #dlg-buttons
		//close the dialogue and clear form
		$('#dlg').dialog('close');
		$('#fm').form('clear');
	}

	function modifyAggregate(currentAggregateObj) {
//		alert($(currentAggregateObj).parent().parent().parent().parent().prev().html());
		var objectId = $($(currentAggregateObj).parent().parent().parent().parent().prev().html()).attr("id");//根据HTML文本字符串创建HTML元素并封装为jQuery对象返回

		var currentAggregateText = $(currentAggregateObj).html();
		var currentBtnText = $(currentAggregateObj).parent().parent().parent().parent().prev().children().html();
		//set current new button text
		regexForBtnText = /^\w+\(([\u4E00-\u9FA5\uF900-\uFA2D\w]+)\)$/;
		if (regexForBtnText.test(currentBtnText)) {
			var result = currentBtnText.match(regexForBtnText);
			if (result != null) {
//				var fullurl = result[0]; // Contains "min(score)"
				var originalBtnText = result[1]; // Contains "score"
			}
			$(currentAggregateObj).parent().parent().parent().parent().prev().children().html(currentAggregateText + "(" + originalBtnText + ")");
		}
		else {
			$(currentAggregateObj).parent().parent().parent().parent().prev().children().html(currentAggregateText + "(" + currentBtnText + ")");
		}

		//update Json Object's functionType corresponding to the specified objectId
		for(var i = 0; i < attrJsonObjArray.length; i++) { // For each index in the array
			if (objectId == attrJsonObjArray[i].id) {
				attrJsonObjArray[i].functionType = currentAggregateText;
			}
		}
	}

	//get rowAttributeIds
	function getRowAttributeIds() {
		var rowAttributeArray = $('#AxisTable tr').eq(0).find("td button div");
		var rowAttributeJsonArray = [];
		for (var i = 0; i < rowAttributeArray.length; i++) { // For each index in the array
			//HTML Element method
//			alert(rowAttributeArray[i].getAttribute("id"));
//			alert(rowAttributeArray[i].getAttribute("name"));

			var tmpJsonObj = {};
			//convert HTML Element into jQuery object in order to use jQuery method
			//$(rowAttributeArray[i]).attr("id") is Json Object id: 从1970.1.1开始的毫秒数
			for(var j = 0; j < attrJsonObjArray.length; j++) { // For each index in the array
				if ($(rowAttributeArray[i]).attr("id") == attrJsonObjArray[j].id) {
					tmpJsonObj.attributeId = attrJsonObjArray[j].attributeId;
				}
			}

			regexForRowBtnText = /^(\w+)\(([\u4E00-\u9FA5\uF900-\uFA2D\w]+)\)$/;
			if (regexForRowBtnText.test(rowAttributeArray[i].innerHTML)) {	//It looks like min(score)
				var result = rowAttributeArray[i].innerHTML.match(regexForRowBtnText);
				if (result != null) {
					// result[0] Contains "min(score)"; result[1] contains "min"; result[2] contains "score"
					tmpJsonObj.functionType = result[1];
				}
			}
			else {	//It looks like score
				tmpJsonObj.functionType = "null";
			}

			rowAttributeJsonArray.push(tmpJsonObj);
		}
		return rowAttributeJsonArray;
	}

	//get columnAttributeIds
	function getColumnAttributeIds() {
		var columnAttributeArray = $('#AxisTable tr').eq(1).find("td button div");
		var columnAttributeJsonArray = [];
		for (var i = 0; i < columnAttributeArray.length; i++) { // For each index in the array
			var tmpJsonObj = {};
			//convert HTML Element into jQuery object in order to use jQuery method
			//$(rowAttributeArray[i]).attr("id") is Json Object id: 从1970.1.1开始的毫秒数
			for(var j = 0; j < attrJsonObjArray.length; j++) { // For each index in the array
				if ($(columnAttributeArray[i]).attr("id") == attrJsonObjArray[j].id) {
					tmpJsonObj.attributeId = attrJsonObjArray[j].attributeId;
				}
			}

			regexForColBtnText = /^(\w+)\(([\u4E00-\u9FA5\uF900-\uFA2D\w]+)\)$/;
			if (regexForColBtnText.test(columnAttributeArray[i].innerHTML)) {	//It looks like min(score)
				var result = columnAttributeArray[i].innerHTML.match(regexForColBtnText);
				if (result != null) {
					// result[0] Contains "min(score)"; result[1] contains "min"; result[2] contains "score"
					tmpJsonObj.functionType = result[1];
				}
			}
			else {	//It looks like score
				tmpJsonObj.functionType = "null";
			}

			columnAttributeJsonArray.push(tmpJsonObj);
		}
		return columnAttributeJsonArray;
	}

	// get attribute filters
	function getAttributeFilters() {
		//traverse filter div
		var filterArray = $('#filter button div');
		var filterJsonArray = [];
		for (var i = 0; i < filterArray.length; i++) { // For each index in the array
			//convert HTML Element into jQuery object in order to use jQuery method
			//$(rowAttributeArray[i]).attr("id") is Json Object id: 从1970.1.1开始的毫秒数
			var tmpJsonObj = {};
			for(var j = 0; j < attrJsonObjArray.length; j++) { // For each index in the array
				if ($(filterArray[i]).attr("id") == attrJsonObjArray[j].id) {
					tmpJsonObj.functionType = attrJsonObjArray[j].functionType;
					tmpJsonObj.attributeId = attrJsonObjArray[j].attributeId;
					tmpJsonObj.op = attrJsonObjArray[j].op;
					tmpJsonObj.parameter = attrJsonObjArray[j].parameter;
				}
			}

			filterJsonArray.push(tmpJsonObj);
		}
		return filterJsonArray;
	}

	function getVizGraphSupported() {
		//将JS对象转化为JSON字符串
		var rowAttributeJsonArray = JSON.stringify(getRowAttributeIds());
		var columnAttributeJsonArray = JSON.stringify(getColumnAttributeIds());

		var token = $("meta[name='_csrf']").attr("content");
		var header = $("meta[name='_csrf_header']").attr("content");

		$.ajax({
			type:"POST",
			async:true,
			dataType: 'json',
			url:"/getVizGraphSupported",
			data:{"rowAttributeIds":rowAttributeJsonArray, "columnAttributeIds":columnAttributeJsonArray},
			beforeSend: function(xhr) {
				xhr.setRequestHeader(header,token);
			},
			success: function(object){
//				alert(JSON.stringify(object));
				console.log(JSON.stringify(object));
				var jsonObjVizGraphSupported = object;//1 highlight, 0 gray
//				var jsonObjVizGraphSupported = {"hcLineBasic":1,"hcAreaBasic":0,"hcBarBasic":1};//1 highlight, 0 gray
				//traverse chart div
				var chartArray = $('#chart ul li a');
				for (var i = 0; i < chartArray.length; i++) { // For each index in the array
					//convert HTML Element into jQuery object in order to use jQuery method
					for(var propertyName in jsonObjVizGraphSupported) {// Assign property names of o to variable p
						console.log(jsonObjVizGraphSupported[propertyName]); // Print the value of each property
						if ( ($(chartArray[i]).attr("id") == propertyName) && (jsonObjVizGraphSupported[propertyName] == 0) ) {//not supported
							//remove click event and add class property
							if(propertyName == "hcLineBasic") {
								$("<a href='#tab3' id='hcLineBasic' class='gray'><img src='../resources/images/line.png'></a>").replaceAll("#" + propertyName);
								break;
							}
							else if (propertyName == "hcBarBasic") {
								$("<a href='#tab3' id='hcBarBasic' class='gray'><img src='../resources/images/bar.png'></a>").replaceAll("#" + propertyName);
								break;
							}
							else if (propertyName == "hcAreaBasic") {
								$("<a href='#tab3' id='hcAreaBasic' class='gray'><img src='../resources/images/area.png'></a>").replaceAll("#" + propertyName);
								break;
							}
							else if (propertyName == "ecChinaProvinceMap") {
								$("<a href='#tab3' id='ecChinaProvinceMap' class='gray'><img src='../resources/images/map.png'></a>").replaceAll("#" + propertyName);
								break;
							}
							else if (propertyName == "hcPieBasic") {
								$("<a href='#tab3' id='hcPieBasic' class='gray'><img src='../resources/images/pie.png'></a>").replaceAll("#" + propertyName);
								break;
							}
							else if (propertyName == "dtTable") {
								$("<a href='#tab3' id='dtTable' class='gray'><img src='../resources/images/table.png'></a>").replaceAll("#" + propertyName);
								break;
							}
							else if (propertyName == "hcComboMultiAxes") {
								$("<a href='#tab3' id='hcComboMultiAxes' class='gray'><img src='../resources/images/combo.png'></a>").replaceAll("#" + propertyName);
								break;
							}
							else if (propertyName == "hcScatter") {
								$("<a href='#tab3' id='hcScatter' class='gray'><img src='../resources/images/scatter.png'></a>").replaceAll("#" + propertyName);
								break;
							}
							else if (propertyName == "ecChinaCityHeatMap") {
								$("<a href='#tab3' id='ecChinaCityHeatMap' class='gray'><img src='../resources/images/chinacity.png'></a>").replaceAll("#" + propertyName);
								break;
							}
//							$(chartArray[i]).addClass("gray");
						}
						else if ( ($(chartArray[i]).attr("id") == propertyName) && (jsonObjVizGraphSupported[propertyName] == 1) ) {//supported
							//judge what kind of chart it is
							if(propertyName == "hcLineBasic") {
								$("<a href='#tab3' id='hcLineBasic' onclick=\"execute('hcLineBasic')\"><img src='../resources/images/line.png'></a>").replaceAll("#" + propertyName);
								break;
							}
							else if (propertyName == "hcBarBasic") {
								$("<a href='#tab3' id='hcBarBasic' onclick=\"execute('hcBarBasic')\"><img src='../resources/images/bar.png'></a>").replaceAll("#" + propertyName);
								break;
							}
							else if (propertyName == "hcAreaBasic") {
								$("<a href='#tab3' id='hcAreaBasic' onclick=\"execute('hcAreaBasic')\"><img src='../resources/images/area.png'></a>").replaceAll("#" + propertyName);
								break;
							}
							else if (propertyName == "ecChinaProvinceMap") {
								$("<a href='#tab3' id='ecChinaProvinceMap' onclick=\"execute('ecChinaProvinceMap')\"><img src='../resources/images/map.png'></a>").replaceAll("#" + propertyName);
								break;
							}
							else if (propertyName == "hcPieBasic") {
								$("<a href='#tab3' id='hcPieBasic' onclick=\"execute('hcPieBasic')\"><img src='../resources/images/pie.png'></a>").replaceAll("#" + propertyName);
								break;
							}
							else if (propertyName == "dtTable") {
								$("<a href='#tab3' id='dtTable' onclick=\"execute('dtTable')\"><img src='../resources/images/table.png'></a>").replaceAll("#" + propertyName);
								break;
							}
							else if (propertyName == "hcComboMultiAxes") {
								$("<a href='#tab3' id='hcComboMultiAxes' onclick=\"execute('hcComboMultiAxes')\"><img src='../resources/images/combo.png'></a>").replaceAll("#" + propertyName);
								break;
							}
							else if (propertyName == "hcScatter") {
								$("<a href='#tab3' id='hcScatter' onclick=\"execute('hcScatter')\"><img src='../resources/images/scatter.png'></a>").replaceAll("#" + propertyName);
								break;
							}
							else if (propertyName == "ecChinaCityHeatMap") {
								$("<a href='#tab3' id='ecChinaCityHeatMap' onclick=\"execute('ecChinaCityHeatMap')\"><img src='../resources/images/chinacity.png'></a>").replaceAll("#" + propertyName);
								break;
							}
						}
					}
				}

			},
			error:function(XMLHttpRequest, textStatus, errorThrown) {
				alert(XMLHttpRequest.status);
				alert(XMLHttpRequest.readyState);
				alert(textStatus);
			}
		});
	}

	function execute(graphTypeName) {
		var graphType = graphTypeName;
		//将JS对象转化为JSON字符串
		var rowAttributeJsonArray = JSON.stringify(getRowAttributeIds());
		var columnAttributeJsonArray = JSON.stringify(getColumnAttributeIds());
		var filterJsonArray = JSON.stringify(getAttributeFilters());

		var token = $("meta[name='_csrf']").attr("content");
		var header = $("meta[name='_csrf_header']").attr("content");

		$.ajax({
			type:"POST",
			async:true,
			dataType: 'json',
			url:"/execute",
			data:{"vizGraphType":graphType, "rowAttributeIds":rowAttributeJsonArray, "columnAttributeIds":columnAttributeJsonArray, "attributeFilters":filterJsonArray},
			beforeSend: function(xhr) {
				xhr.setRequestHeader(header,token);
			},
			success: function(object){
//				alert(JSON.stringify(object));
				console.log(JSON.stringify(object));

				$("#main").empty();//clear
				//judge whether the returned chart data is wrong or not
				if (object.bSuccess == false) {
					alert(object.errorMessage);//show error message
				}
				else {
					var maxValue = 2100/object.columnCount - 21;
					var minValue = 2100/(object.columnCount + 1) - 21;
					var divWidthForMN = Math.ceil(minValue);

					if (graphType == "hcLineBasic") {
						if ( (object.rowCount == 1) && (object.columnCount == 1) ) {
							var highchartsObj = object.vizGraphs[0][0];
							$('#main').highcharts(highchartsObj["lineBasic"]);
						}
						else if ( (object.rowCount == 1) && (object.columnCount != 1) ) {
							$("<div class='tu_rightbox' id='parentDiv'></div>").appendTo("#main"); // Append 1(rows)*n(columns) child chart div to #main
							for(var row = 0; row < object.vizGraphs.length; row++) {
								for(col = 0; col < object.vizGraphs[row].length; col++) {
									var highchartsObj = object.vizGraphs[row][col];

									$("<div class='tu_three' id='main0" + col +"'></div>").appendTo("#parentDiv");//id="main00", id="main01", id="main02", id="main03"
									$("#main" + row + col).width(divWidthForMN);
									$("#main" + row + col).highcharts(highchartsObj["lineBasic"]);
								}
							}
						}
						else {
							$("<div class='tu_rightbox1' id='parentDiv'></div>").appendTo("#main"); // Append m(rows)*n(columns) child chart div to #main
							for(var row = 0; row < object.vizGraphs.length; row++) {
								for(col = 0; col < object.vizGraphs[row].length; col++) {
									var highchartsObj = object.vizGraphs[row][col];

									$("<div class='tu_four' id='main" + row + col +"'></div>").appendTo("#parentDiv");
									$("#main" + row + col).width(divWidthForMN);
									$("#main" + row + col).highcharts(highchartsObj["lineBasic"]);
								}
							}
						}
					}
					else if (graphType == "hcAreaBasic") {
						if ( (object.rowCount == 1) && (object.columnCount == 1) ) {
							var highchartsObj = object.vizGraphs[0][0];
							$('#main').highcharts(highchartsObj["areaBasic"]);
						}
						else if ( (object.rowCoun == 1) && (object.columnCount != 1) ) {
							$("<div class='tu_rightbox' id='parentDiv'></div>").appendTo("#main"); // Append 1(rows)*n(columns) child chart div to #main
							for(var row = 0; row < object.vizGraphs.length; row++) {
								for(col = 0; col < object.vizGraphs[row].length; col++) {
									var highchartsObj = object.vizGraphs[row][col];

									$("<div class='tu_three' id='main0" + col +"'></div>").appendTo("#parentDiv");//id="main00", id="main01", id="main02", id="main03"
									$("#main" + row + col).width(divWidthForMN);
									$("#main" + row + col).highcharts(highchartsObj["areaBasic"]);
								}
							}
						}
						else {
							$("<div class='tu_rightbox1' id='parentDiv'></div>").appendTo("#main"); // Append m(rows)*n(columns) child chart div to #main
							for(var row = 0; row < object.vizGraphs.length; row++) {
								for(col = 0; col < object.vizGraphs[row].length; col++) {
									var highchartsObj = object.vizGraphs[row][col];

									$("<div class='tu_four' id='main" + row + col +"'></div>").appendTo("#parentDiv");
									$("#main" + row + col).width(divWidthForMN);
									$("#main" + row + col).highcharts(highchartsObj["areaBasic"]);
								}
							}
						}
					}
					else if (graphType == "hcBarBasic") {
						if ( (object.rowCount == 1) && (object.columnCount == 1) ) {
							var highchartsObj = object.vizGraphs[0][0];
							$('#main').highcharts(highchartsObj["barBasic"]);
						}
						else if ( (object.rowCoun == 1) && (object.columnCount != 1) ) {
							$("<div class='tu_rightbox' id='parentDiv'></div>").appendTo("#main"); // Append 1(rows)*n(columns) child chart div to #main
							for(var row = 0; row < object.vizGraphs.length; row++) {
								for(col = 0; col < object.vizGraphs[row].length; col++) {
									var highchartsObj = object.vizGraphs[row][col];

									$("<div class='tu_three' id='main0" + col +"'></div>").appendTo("#parentDiv");//id="main00", id="main01", id="main02", id="main03"
									$("#main" + row + col).width(divWidthForMN);
									$("#main" + row + col).highcharts(highchartsObj["barBasic"]);
								}
							}
						}
						else {
							$("<div class='tu_rightbox1' id='parentDiv'></div>").appendTo("#main"); // Append m(rows)*n(columns) child chart div to #main
							for(var row = 0; row < object.vizGraphs.length; row++) {
								for(col = 0; col < object.vizGraphs[row].length; col++) {
									var highchartsObj = object.vizGraphs[row][col];

									$("<div class='tu_four' id='main" + row + col +"'></div>").appendTo("#parentDiv");
									$("#main" + row + col).width(divWidthForMN);
									$("#main" + row + col).highcharts(highchartsObj["barBasic"]);
								}
							}
						}
					}
					else if (graphType == "hcPieBasic") {
						if ( (object.rowCount == 1) && (object.columnCount == 1) ) {
							var highchartsObj = object.vizGraphs[0][0];
							$('#main').highcharts(highchartsObj["pieBasic"]);
						}
						else if ( (object.rowCoun == 1) && (object.columnCount != 1) ) {
							$("<div class='tu_rightbox' id='parentDiv'></div>").appendTo("#main"); // Append 1(rows)*n(columns) child chart div to #main
							for(var row = 0; row < object.vizGraphs.length; row++) {
								for(col = 0; col < object.vizGraphs[row].length; col++) {
									var highchartsObj = object.vizGraphs[row][col];

									$("<div class='tu_three' id='main0" + col +"'></div>").appendTo("#parentDiv");//id="main00", id="main01", id="main02", id="main03"
									$("#main" + row + col).width(divWidthForMN);
									$("#main" + row + col).highcharts(highchartsObj["pieBasic"]);
								}
							}
						}
						else {
							$("<div class='tu_rightbox1' id='parentDiv'></div>").appendTo("#main"); // Append m(rows)*n(columns) child chart div to #main
							for(var row = 0; row < object.vizGraphs.length; row++) {
								for(col = 0; col < object.vizGraphs[row].length; col++) {
									var highchartsObj = object.vizGraphs[row][col];

									$("<div class='tu_four' id='main" + row + col +"'></div>").appendTo("#parentDiv");
									$("#main" + row + col).width(divWidthForMN);
									$("#main" + row + col).highcharts(highchartsObj["pieBasic"]);
								}
							}
						}
					}
					else if (graphType == "hcComboMultiAxes") {
						if ( (object.rowCount == 1) && (object.columnCount == 1) ) {
							var highchartsObj = object.vizGraphs[0][0];
							$('#main').highcharts(highchartsObj["comboMultiAxesBasic"]);
						}
						else if ( (object.rowCoun == 1) && (object.columnCount != 1) ) {
							$("<div class='tu_rightbox' id='parentDiv'></div>").appendTo("#main"); // Append 1(rows)*n(columns) child chart div to #main
							for(var row = 0; row < object.vizGraphs.length; row++) {
								for(col = 0; col < object.vizGraphs[row].length; col++) {
									var highchartsObj = object.vizGraphs[row][col];

									$("<div class='tu_three' id='main0" + col +"'></div>").appendTo("#parentDiv");//id="main00", id="main01", id="main02", id="main03"
									$("#main" + row + col).width(divWidthForMN);
									$("#main" + row + col).highcharts(highchartsObj["comboMultiAxesBasic"]);
								}
							}
						}
						else {
							$("<div class='tu_rightbox1' id='parentDiv'></div>").appendTo("#main"); // Append m(rows)*n(columns) child chart div to #main
							for(var row = 0; row < object.vizGraphs.length; row++) {
								for(col = 0; col < object.vizGraphs[row].length; col++) {
									var highchartsObj = object.vizGraphs[row][col];

									$("<div class='tu_four' id='main" + row + col +"'></div>").appendTo("#parentDiv");
									$("#main" + row + col).width(divWidthForMN);
									$("#main" + row + col).highcharts(highchartsObj["comboMultiAxesBasic"]);
								}
							}
						}
					}
					else if (graphType == "hcScatter") {
						if ( (object.rowCount == 1) && (object.columnCount == 1) ) {
							var highchartsObj = object.vizGraphs[0][0];
							$('#main').highcharts(highchartsObj["scatterGraphBasic"]);
						}
						else if ( (object.rowCoun == 1) && (object.columnCount != 1) ) {
							$("<div class='tu_rightbox' id='parentDiv'></div>").appendTo("#main"); // Append 1(rows)*n(columns) child chart div to #main
							for(var row = 0; row < object.vizGraphs.length; row++) {
								for(col = 0; col < object.vizGraphs[row].length; col++) {
									var highchartsObj = object.vizGraphs[row][col];

									$("<div class='tu_three' id='main0" + col +"'></div>").appendTo("#parentDiv");//id="main00", id="main01", id="main02", id="main03"
									$("#main" + row + col).width(divWidthForMN);
									$("#main" + row + col).highcharts(highchartsObj["scatterGraphBasic"]);
								}
							}
						}
						else {
							$("<div class='tu_rightbox1' id='parentDiv'></div>").appendTo("#main"); // Append m(rows)*n(columns) child chart div to #main
							for(var row = 0; row < object.vizGraphs.length; row++) {
								for(col = 0; col < object.vizGraphs[row].length; col++) {
									var highchartsObj = object.vizGraphs[row][col];

									$("<div class='tu_four' id='main" + row + col +"'></div>").appendTo("#parentDiv");
									$("#main" + row + col).width(divWidthForMN);
									$("#main" + row + col).highcharts(highchartsObj["scatterGraphBasic"]);
								}
							}
						}
					}
					else if (graphType == "ecChinaCityHeatMap") {
						if ( (object.rowCount == 1) && (object.columnCount == 1) ) {
							var echartsObj = object.vizGraphs[0][0];
							// 基于准备好的dom，初始化echarts图表
							var myChart = echarts.init(document.getElementById('main'));
							myChart.setOption(echartsObj["chinaCityHeatMapBasic"]);
						}
						else if ( (object.rowCoun == 1) && (object.columnCount != 1) ) {
							$("<div class='tu_rightbox' id='parentDiv'></div>").appendTo("#main"); // Append 1(rows)*n(columns) child chart div to #main
							for(var row = 0; row < object.vizGraphs.length; row++) {
								for(col = 0; col < object.vizGraphs[row].length; col++) {
									var highchartsObj = object.vizGraphs[row][col];

									$("<div class='tu_three' id='main0" + col +"'></div>").appendTo("#parentDiv");//id="main00", id="main01", id="main02", id="main03"
									$("#main" + row + col).width(divWidthForMN);
									// 基于准备好的dom，初始化echarts图表
									var myChart = echarts.init(document.getElementById("#main" + row + col));
									myChart.setOption(echartsObj["chinaCityHeatMapBasic"]);
								}
							}
						}
						else {
							$("<div class='tu_rightbox1' id='parentDiv'></div>").appendTo("#main"); // Append m(rows)*n(columns) child chart div to #main
							for(var row = 0; row < object.vizGraphs.length; row++) {
								for(col = 0; col < object.vizGraphs[row].length; col++) {
									var highchartsObj = object.vizGraphs[row][col];

									$("<div class='tu_four' id='main" + row + col +"'></div>").appendTo("#parentDiv");
									$("#main" + row + col).width(divWidthForMN);
									// 基于准备好的dom，初始化echarts图表
									var myChart = echarts.init(document.getElementById("#main" + row + col));
									myChart.setOption(echartsObj["chinaCityHeatMapBasic"]);
								}
							}
						}
					}
					else if (graphType == "ecChinaProvinceMap") {
						if ( (object.rowCount == 1) && (object.columnCount == 1) ) {
							var echartsObj = object.vizGraphs[0][0];
							// 基于准备好的dom，初始化echarts图表
							var myChart = echarts.init(document.getElementById('main'));
							myChart.setOption(echartsObj["chinaProviceMapBasic"]);
						}
						else if ( (object.rowCoun == 1) && (object.columnCount != 1) ) {
							$("<div class='tu_rightbox' id='parentDiv'></div>").appendTo("#main"); // Append 1(rows)*n(columns) child chart div to #main
							for(var row = 0; row < object.vizGraphs.length; row++) {
								for(col = 0; col < object.vizGraphs[row].length; col++) {
									var echartsObj = object.vizGraphs[row][col];

									$("<div class='tu_three' id='main0" + col +"'></div>").appendTo("#parentDiv");//id="main00", id="main01", id="main02", id="main03"
									$("#main" + row + col).width(divWidthForMN);
									// 基于准备好的dom，初始化echarts图表
									var myChart = echarts.init(document.getElementById("#main" + row + col));
									myChart.setOption(echartsObj["chinaProviceMapBasic"]);
								}
							}
						}
						else {
							$("<div class='tu_rightbox1' id='parentDiv'></div>").appendTo("#main"); // Append m(rows)*n(columns) child chart div to #main
							for(var row = 0; row < object.vizGraphs.length; row++) {
								for(col = 0; col < object.vizGraphs[row].length; col++) {
									var echartsObj = object.vizGraphs[row][col];

									$("<div class='tu_four' id='main" + row + col +"'></div>").appendTo("#parentDiv");
									$("#main" + row + col).width(divWidthForMN);
									// 基于准备好的dom，初始化echarts图表
									var myChart = echarts.init(document.getElementById("#main" + row + col));
									myChart.setOption(echartsObj["chinaProviceMapBasic"]);
								}
							}
						}
					}
					else if (graphType == "dtTable") {
						$("#main").append('<table id="example" class="display" cellspacing="0" width="100%"></table>');
						var dataTableObj = object.vizGraphs[0][0];
						$('#example').DataTable( dataTableObj.dataTable );
					}
				}
			},
			error:function(XMLHttpRequest, textStatus, errorThrown) {
				alert(XMLHttpRequest.status);
				alert(XMLHttpRequest.readyState);
				alert(textStatus);
			}
		});
	}

</script>

<script type="text/javascript">
	$(function() {
		var middledivHeight = document.documentElement.clientHeight - document.getElementById("menubar").offsetHeight - document.getElementById("footer").offsetHeight - 100;
//		var middledivHeight = document.documentElement.clientHeight - 170;
		$("#middlediv").css({"height":parseInt(middledivHeight)}); // Okay to set compound styles

/*		alert("document.documentElement.clientHeight=" + document.documentElement.clientHeight);
		alert("menubarHeight=" + document.getElementById("menubar").offsetHeight);
		alert("footerHeight=" + document.getElementById("footer").offsetHeight);
		alert("middledivHeight=" + middledivHeight);*/
	});
</script>


</head>

<body>
	<!-- 筛选器 -->
	<div id="dlg" class="easyui-dialog"
		 style="width: 400px; height: 280px; padding:30px 20px 0px 20px" closed="true"
		 buttons="#dlg-buttons">
		<form id="fm" method="post" novalidate>
			<div class="fitem">
				<label class="label_word">字段名称:</label>
				<input name="fieldname" value="" readonly="readonly" id="" type="text" class="label_word_input" />
			</div>
			<div class="fitem">
				<label class="label_word">关系运算符:</label>
				<select id="relationOperator">
					<option value="sample" selected="selected">请选择</option>
					<option value="greaterthan">&lt;</option>
					<option value="gtorequal">&le;</option>
					<option value="lessthan">&gt;</option>
					<option value="ltorequal">&ge;</option>
					<option value="equal">=</option>
					<option value="notequal">&ne;</option>
					<option value="like">Like</option>
					<option value="notlike">NotLike</option>
				</select>
			</div>
			<div class="fitem">
				<label class="label_word">值:</label> <input name="fieldValue"  class="fieldname_input" />
			</div>
		</form>
	</div>
	<div id="dlg-buttons">
<%--		<a href="#" class="btn btn-primary btn_margin" iconCls="icon-ok" id="dlgsave">保存</a>
		<a href="#" class="btn" iconCls="icon-cancel" onclick="cancelFilterDialog()">取消</a>--%>
	</div>

	<div class="navbar navbar-fixed-top" id="menubar">
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
												class="dropdown-toggle" data-toggle="dropdown">数据源<i class="caret"></i>

						</a>
							<ul class="dropdown-menu">
								<li><a tabindex="-1" href="/form">选择数据源</a></li>
								<!--li><a tabindex="-1" href="#">选择数据集</a></li>
                                <li><a tabindex="-1" href="#">设定数据</a></li-->
							</ul>
						</li>
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
		<div class="row-fluid" id="middlediv">

			<div class="span3 left-wd" id="sidebar">
				<div class="nav nav-list bs-docs-sidenav nav-list-bg" >
					<div class="tree-box" align="left">
						<ul id="tt" class="easyui-tree ">
						</ul>
					</div>
				</div>
			</div>

			<!--/span-->
			<div class="span9 right-wd" id="content">
				<div class="row-fluid"></div>
				<div class="row-fluid">
					<!-- block -->
					<div class="block block_mg">
						
						<div class="axis-box">

							<table id="AxisTable">

								<tr>
									<td><div class="zhou-bg">行</div></td>
									<td class="drop">
										<div class="item"
											style="position: static; left: 72px; top: 16px;">
											<span style="visibility: hidden">
												<div class="btn-group">
													<button data-toggle="dropdown" class="btn dropdown-toggle dropdown-wd">
													</button>
													<ul class="dropdown-menu" style="z-index: 110011;">
														<li><a href="#" onclick="FilterDialogSetting(this, $(this).parent().parent().prev().html())">筛选器...</a></li>
														<li><a href="#" onclick="deleteField(this)">移除</a></li>
														<li class="dropdown-submenu">
															<a tabindex="-1" href="javascript:;">通用函数</a>
															<ul class="dropdown-menu">
																<li><a tabindex="-1" href="javascript:;" onclick="modifyAggregate(this)">year</a></li>
																<li><a tabindex="-1" href="javascript:;" onclick="modifyAggregate(this)">month</a></li>
																<li><a tabindex="-1" href="javascript:;" onclick="modifyAggregate(this)">week</a></li>
																<li><a tabindex="-1" href="javascript:;" onclick="modifyAggregate(this)">dayofmonth</a></li>
																<li><a tabindex="-1" href="javascript:;" onclick="modifyAggregate(this)">abs</a></li>
															</ul>
														</li>
													</ul>
												</div>
											</span>
										</div>
									</td>
									<td class="drop">
										<div class="item"
											style="position: static; left: 72px; top: 16px;">
											<span style="visibility: hidden">
												<div class="btn-group">
													<button data-toggle="dropdown" class="btn dropdown-toggle dropdown-wd">
													</button>
													<ul class="dropdown-menu" style="z-index: 110011;">
														<li><a href="#" onclick="FilterDialogSetting(this, $(this).parent().parent().prev().html())">筛选器...</a></li>
														<li><a href="#" onclick="deleteField(this)">移除</a></li>
														<li class="dropdown-submenu">
															<a tabindex="-1" href="javascript:;">通用函数</a>
															<ul class="dropdown-menu">
																<li><a tabindex="-1" href="javascript:;" onclick="modifyAggregate(this)">year</a></li>
																<li><a tabindex="-1" href="javascript:;" onclick="modifyAggregate(this)">month</a></li>
																<li><a tabindex="-1" href="javascript:;" onclick="modifyAggregate(this)">week</a></li>
																<li><a tabindex="-1" href="javascript:;" onclick="modifyAggregate(this)">dayofmonth</a></li>
																<li><a tabindex="-1" href="javascript:;" onclick="modifyAggregate(this)">abs</a></li>
															</ul>
														</li>
													</ul>
												</div>
											</span>
										</div>
									</td>
									<td class="drop">
										<div class="item"
											style="position: static; left: 72px; top: 16px;">
											<span style="visibility: hidden">
												<div class="btn-group">
													<button data-toggle="dropdown" class="btn dropdown-toggle dropdown-wd">
													</button>
													<ul class="dropdown-menu" style="z-index: 110011;">
														<li><a href="#" onclick="FilterDialogSetting(this, $(this).parent().parent().prev().html())">筛选器...</a></li>
														<li><a href="#" onclick="deleteField(this)">移除</a></li>
														<li class="dropdown-submenu">
															<a tabindex="-1" href="javascript:;">通用函数</a>
															<ul class="dropdown-menu">
																<li><a tabindex="-1" href="javascript:;" onclick="modifyAggregate(this)">year</a></li>
																<li><a tabindex="-1" href="javascript:;" onclick="modifyAggregate(this)">month</a></li>
																<li><a tabindex="-1" href="javascript:;" onclick="modifyAggregate(this)">week</a></li>
																<li><a tabindex="-1" href="javascript:;" onclick="modifyAggregate(this)">dayofmonth</a></li>
																<li><a tabindex="-1" href="javascript:;" onclick="modifyAggregate(this)">abs</a></li>
															</ul>
														</li>
													</ul>
												</div>
											</span>
										</div>
									</td>
									<td class="drop">
										<div class="item"
											style="position: static; left: 72px; top: 16px;">
											<span style="visibility: hidden">
												<div class="btn-group">
													<button data-toggle="dropdown" class="btn dropdown-toggle dropdown-wd">
													</button>
													<ul class="dropdown-menu" style="z-index: 110011;">
														<li><a href="#" onclick="FilterDialogSetting(this, $(this).parent().parent().prev().html())">筛选器...</a></li>
														<li><a href="#" onclick="deleteField(this)">移除</a></li>
														<li class="dropdown-submenu">
															<a tabindex="-1" href="javascript:;">通用函数</a>
															<ul class="dropdown-menu">
																<li><a tabindex="-1" href="javascript:;" onclick="modifyAggregate(this)">year</a></li>
																<li><a tabindex="-1" href="javascript:;" onclick="modifyAggregate(this)">month</a></li>
																<li><a tabindex="-1" href="javascript:;" onclick="modifyAggregate(this)">week</a></li>
																<li><a tabindex="-1" href="javascript:;" onclick="modifyAggregate(this)">dayofmonth</a></li>
																<li><a tabindex="-1" href="javascript:;" onclick="modifyAggregate(this)">abs</a></li>
															</ul>
														</li>
													</ul>
												</div>
											</span>
										</div>
									</td>
									<td class="drop">
										<div class="item"
											style="position: static; left: 72px; top: 16px;">
											<span style="visibility: hidden">
												<div class="btn-group">
													<button data-toggle="dropdown" class="btn dropdown-toggle dropdown-wd">
													</button>
													<ul class="dropdown-menu" style="z-index: 110011;">
														<li><a href="#" onclick="FilterDialogSetting(this, $(this).parent().parent().prev().html())">筛选器...</a></li>
														<li><a href="#" onclick="deleteField(this)">移除</a></li>
														<li class="dropdown-submenu">
															<a tabindex="-1" href="javascript:;">通用函数</a>
															<ul class="dropdown-menu">
																<li><a tabindex="-1" href="javascript:;" onclick="modifyAggregate(this)">year</a></li>
																<li><a tabindex="-1" href="javascript:;" onclick="modifyAggregate(this)">month</a></li>
																<li><a tabindex="-1" href="javascript:;" onclick="modifyAggregate(this)">week</a></li>
																<li><a tabindex="-1" href="javascript:;" onclick="modifyAggregate(this)">dayofmonth</a></li>
																<li><a tabindex="-1" href="javascript:;" onclick="modifyAggregate(this)">abs</a></li>
															</ul>
														</li>
													</ul>
												</div>
											</span>
										</div>
									</td>
									<td class="drop">
										<div class="item"
											style="position: static; left: 72px; top: 16px;">
											<span style="visibility: hidden">
												<div class="btn-group">
													<button data-toggle="dropdown" class="btn dropdown-toggle dropdown-wd">
													</button>
													<ul class="dropdown-menu" style="z-index: 110011;">
														<li><a href="#" onclick="FilterDialogSetting(this, $(this).parent().parent().prev().html())">筛选器...</a></li>
														<li><a href="#" onclick="deleteField(this)">移除</a></li>
														<li class="dropdown-submenu">
															<a tabindex="-1" href="javascript:;">通用函数</a>
															<ul class="dropdown-menu">
																<li><a tabindex="-1" href="javascript:;" onclick="modifyAggregate(this)">year</a></li>
																<li><a tabindex="-1" href="javascript:;" onclick="modifyAggregate(this)">month</a></li>
																<li><a tabindex="-1" href="javascript:;" onclick="modifyAggregate(this)">week</a></li>
																<li><a tabindex="-1" href="javascript:;" onclick="modifyAggregate(this)">dayofmonth</a></li>
																<li><a tabindex="-1" href="javascript:;" onclick="modifyAggregate(this)">abs</a></li>
															</ul>
														</li>
													</ul>
												</div>
											</span>
										</div>
									</td>
									<td class="drop">
										<div class="item"
											style="position: static; left: 72px; top: 16px;">
											<span style="visibility: hidden">
												<div class="btn-group">
													<button data-toggle="dropdown" class="btn dropdown-toggle dropdown-wd">
													</button>
													<ul class="dropdown-menu" style="z-index: 110011;">
														<li><a href="#" onclick="FilterDialogSetting(this, $(this).parent().parent().prev().html())">筛选器...</a></li>
														<li><a href="#" onclick="deleteField(this)">移除</a></li>
														<li class="dropdown-submenu">
															<a tabindex="-1" href="javascript:;">通用函数</a>
															<ul class="dropdown-menu">
																<li><a tabindex="-1" href="javascript:;" onclick="modifyAggregate(this)">year</a></li>
																<li><a tabindex="-1" href="javascript:;" onclick="modifyAggregate(this)">month</a></li>
																<li><a tabindex="-1" href="javascript:;" onclick="modifyAggregate(this)">week</a></li>
																<li><a tabindex="-1" href="javascript:;" onclick="modifyAggregate(this)">dayofmonth</a></li>
																<li><a tabindex="-1" href="javascript:;" onclick="modifyAggregate(this)">abs</a></li>
															</ul>
														</li>
													</ul>
												</div>
											</span>
										</div>
									</td>
								</tr>

								<tr>
									<td><div class="zhou-bg">列</div></td>
									<td class="drop">
										<div class="item"
											style="position: static; left: 72px; top: 16px;">
											<span style="visibility: hidden">
												<div class="btn-group">
													<button data-toggle="dropdown" class="btn dropdown-toggle dropdown-wd">
													</button>
													<ul class="dropdown-menu" style="z-index: 110011;">
														<li><a href="#" onclick="FilterDialogSetting(this, $(this).parent().parent().prev().html())">筛选器...</a></li>
														<li><a href="#" onclick="deleteField(this)">移除</a></li>
														<li class="dropdown-submenu">
															<a tabindex="-1" href="javascript:;">聚集函数</a>
															<ul class="dropdown-menu">
																<li><a tabindex="-1" href="javascript:;" onclick="modifyAggregate(this)">sum</a></li>
																<li><a tabindex="-1" href="javascript:;" onclick="modifyAggregate(this)">avg</a></li>
																<li><a tabindex="-1" href="javascript:;" onclick="modifyAggregate(this)">count</a></li>
																<li><a tabindex="-1" href="javascript:;" onclick="modifyAggregate(this)">min</a></li>
																<li><a tabindex="-1" href="javascript:;" onclick="modifyAggregate(this)">max</a></li>
															</ul>
														</li>
													</ul>
												</div>
											</span>
										</div>
									</td>
									<td class="drop">
										<div class="item"
											style="position: static; left: 72px; top: 16px;">
											<span style="visibility: hidden">
												<div class="btn-group">
													<button data-toggle="dropdown" class="btn dropdown-toggle dropdown-wd">
													</button>
													<ul class="dropdown-menu" style="z-index: 110011;">
														<li><a href="#" onclick="FilterDialogSetting(this, $(this).parent().parent().prev().html())">筛选器...</a></li>
														<li><a href="#" onclick="deleteField(this)">移除</a></li>
														<li class="dropdown-submenu">
															<a tabindex="-1" href="javascript:;">聚集函数</a>
															<ul class="dropdown-menu">
																<li><a tabindex="-1" href="javascript:;" onclick="modifyAggregate(this)">sum</a></li>
																<li><a tabindex="-1" href="javascript:;" onclick="modifyAggregate(this)">avg</a></li>
																<li><a tabindex="-1" href="javascript:;" onclick="modifyAggregate(this)">count</a></li>
																<li><a tabindex="-1" href="javascript:;" onclick="modifyAggregate(this)">min</a></li>
																<li><a tabindex="-1" href="javascript:;" onclick="modifyAggregate(this)">max</a></li>
															</ul>
														</li>
													</ul>
												</div>
											</span>
										</div>
									</td>
									<td class="drop">
										<div class="item"
											style="position: static; left: 72px; top: 16px;">
											<span style="visibility: hidden">
												<div class="btn-group">
													<button data-toggle="dropdown" class="btn dropdown-toggle dropdown-wd">
													</button>
													<ul class="dropdown-menu" style="z-index: 110011;">
														<li><a href="#" onclick="FilterDialogSetting(this, $(this).parent().parent().prev().html())">筛选器...</a></li>
														<li><a href="#" onclick="deleteField(this)">移除</a></li>
														<li class="dropdown-submenu">
															<a tabindex="-1" href="javascript:;">聚集函数</a>
															<ul class="dropdown-menu">
																<li><a tabindex="-1" href="javascript:;" onclick="modifyAggregate(this)">sum</a></li>
																<li><a tabindex="-1" href="javascript:;" onclick="modifyAggregate(this)">avg</a></li>
																<li><a tabindex="-1" href="javascript:;" onclick="modifyAggregate(this)">count</a></li>
																<li><a tabindex="-1" href="javascript:;" onclick="modifyAggregate(this)">min</a></li>
																<li><a tabindex="-1" href="javascript:;" onclick="modifyAggregate(this)">max</a></li>
															</ul>
														</li>
													</ul>
												</div>
											</span>
										</div>
									</td>
									<td class="drop">
										<div class="item"
											style="position: static; left: 72px; top: 16px;">
											<span style="visibility: hidden">
												<div class="btn-group">
													<button data-toggle="dropdown" class="btn dropdown-toggle dropdown-wd">
													</button>
													<ul class="dropdown-menu" style="z-index: 110011;">
														<li><a href="#" onclick="FilterDialogSetting(this, $(this).parent().parent().prev().html())">筛选器...</a></li>
														<li><a href="#" onclick="deleteField(this)">移除</a></li>
														<li class="dropdown-submenu">
															<a tabindex="-1" href="javascript:;">聚集函数</a>
															<ul class="dropdown-menu">
																<li><a tabindex="-1" href="javascript:;" onclick="modifyAggregate(this)">sum</a></li>
																<li><a tabindex="-1" href="javascript:;" onclick="modifyAggregate(this)">avg</a></li>
																<li><a tabindex="-1" href="javascript:;" onclick="modifyAggregate(this)">count</a></li>
																<li><a tabindex="-1" href="javascript:;" onclick="modifyAggregate(this)">min</a></li>
																<li><a tabindex="-1" href="javascript:;" onclick="modifyAggregate(this)">max</a></li>
															</ul>
														</li>
													</ul>
												</div>
											</span>
										</div>
									</td>
									<td class="drop">
										<div class="item"
											style="position: static; left: 72px; top: 16px;">
											<span style="visibility: hidden">
												<div class="btn-group">
													<button data-toggle="dropdown" class="btn dropdown-toggle dropdown-wd">
													</button>
													<ul class="dropdown-menu" style="z-index: 110011;">
														<li><a href="#" onclick="FilterDialogSetting(this, $(this).parent().parent().prev().html())">筛选器...</a></li>
														<li><a href="#" onclick="deleteField(this)">移除</a></li>
														<li class="dropdown-submenu">
															<a tabindex="-1" href="javascript:;">聚集函数</a>
															<ul class="dropdown-menu">
																<li><a tabindex="-1" href="javascript:;" onclick="modifyAggregate(this)">sum</a></li>
																<li><a tabindex="-1" href="javascript:;" onclick="modifyAggregate(this)">avg</a></li>
																<li><a tabindex="-1" href="javascript:;" onclick="modifyAggregate(this)">count</a></li>
																<li><a tabindex="-1" href="javascript:;" onclick="modifyAggregate(this)">min</a></li>
																<li><a tabindex="-1" href="javascript:;" onclick="modifyAggregate(this)">max</a></li>
															</ul>
														</li>
													</ul>
												</div>
											</span>
										</div>
									</td>
									<td class="drop">
										<div class="item"
											style="position: static; left: 72px; top: 16px;">
											<span style="visibility: hidden">
												<div class="btn-group">
													<button data-toggle="dropdown" class="btn dropdown-toggle dropdown-wd">
													</button>
													<ul class="dropdown-menu" style="z-index: 110011;">
														<li><a href="#" onclick="FilterDialogSetting(this, $(this).parent().parent().prev().html())">筛选器...</a></li>
														<li><a href="#" onclick="deleteField(this)">移除</a></li>
														<li class="dropdown-submenu">
															<a tabindex="-1" href="javascript:;">聚集函数</a>
															<ul class="dropdown-menu">
																<li><a tabindex="-1" href="javascript:;" onclick="modifyAggregate(this)">sum</a></li>
																<li><a tabindex="-1" href="javascript:;" onclick="modifyAggregate(this)">avg</a></li>
																<li><a tabindex="-1" href="javascript:;" onclick="modifyAggregate(this)">count</a></li>
																<li><a tabindex="-1" href="javascript:;" onclick="modifyAggregate(this)">min</a></li>
																<li><a tabindex="-1" href="javascript:;" onclick="modifyAggregate(this)">max</a></li>
															</ul>
														</li>
													</ul>
												</div>
											</span>
										</div>
									</td>
									<td class="drop">
										<div class="item"
											style="position: static; left: 72px; top: 16px;">
											<span style="visibility: hidden">
												<div class="btn-group">
													<button data-toggle="dropdown" class="btn dropdown-toggle dropdown-wd">
													</button>
													<ul class="dropdown-menu" style="z-index: 110011;">
														<li><a href="#" onclick="FilterDialogSetting(this, $(this).parent().parent().prev().html())">筛选器...</a></li>
														<li><a href="#" onclick="deleteField(this)">移除</a></li>
														<li class="dropdown-submenu">
															<a tabindex="-1" href="javascript:;">聚集函数</a>
															<ul class="dropdown-menu">
																<li><a tabindex="-1" href="javascript:;" onclick="modifyAggregate(this)">sum</a></li>
																<li><a tabindex="-1" href="javascript:;" onclick="modifyAggregate(this)">avg</a></li>
																<li><a tabindex="-1" href="javascript:;" onclick="modifyAggregate(this)">count</a></li>
																<li><a tabindex="-1" href="javascript:;" onclick="modifyAggregate(this)">min</a></li>
																<li><a tabindex="-1" href="javascript:;" onclick="modifyAggregate(this)">max</a></li>
															</ul>
														</li>
													</ul>
												</div>
											</span>
										</div>
									</td>
								</tr>
							</table>
						</div>

					</div>
					<!-- /block -->
				</div>
				<div class="row-fluid row-fluid-bg" style="height: 92%;">
					<!-- block -->
					<div class="block">
						<div class="navbar navbar-inner block-header">
							<div class="muted pull-left">图像显示方式</div>
							<div class="pull-right">
								<div class="btn-group">
									<button data-toggle="dropdown" class="btn dropdown-toggle dropdown-wd" onclick="getVizGraphSupported()">
										Charts <span class="caret"></span>
									</button>
									<div class="dropdown-menu dropdown_box" id="chart">

										<ul class="dropdown_top">
											<li class="a" alt="区域图"><a href="#tab1" id="hcAreaBasic"><img src="../resources/images/area.png" ></a></li>
											<li class="a" alt="柱状图"><a href="#tab2" id="hcBarBasic" ><img src="../resources/images/bar.png"> </a></li>
											<li class="a" alt="折线图"><a href="#tab3" id="hcLineBasic"><img src="../resources/images/line.png"></a></li>
											<li class="a" alt="地图"><a href="#tab3" id="ecChinaProvinceMap"><img src="../resources/images/map.png"></a></li>
											<li class="a" alt="饼图"><a href="#tab3" id="hcPieBasic"><img src="../resources/images/pie.png"></a></li>
											<li class="a" alt="表格"><a href="#tab3" id="dtTable"><img src="../resources/images/table.png"></a></li>
											<li class="a" alt="组合折线图"><a href="#tab3" id="hcComboMultiAxes"><img src="../resources/images/combo.png"></a></li>
											<li class="a" alt="散点图"><a href="#tab3" id="hcScatter"><img src="../resources/images/scatter.png"></a></li>
											<li class="a" alt="全国热力图"><a href="#tab3" id="ecChinaCityHeatMap"><img src="../resources/images/chinacity.png"></a></li>
										</ul>
										<div class="dropdown_bot">
											<div id="tab1" class="tab_content" style="display: block; ">
											</div>
										</div>

									</div>

									</div>
								</div>

							</div>
						</div>
						<div class="block-content collapse in" >
							<div class="row-fluid padd-bottom">

								<div id="page-stats" class="">
									<div class="">
										<div class="tu_left" id="filter">
										   <div class="navbar-inner block-header ">
							                  <div class="muted pull-left ">筛选器</div>
							                  <div class="tu_left_bot"></div>
							               </div>
										</div>
										<div id="main" class="tu_right" >
											<%--	1*n: 1*4	--%>
					<%--						<div class="tu_rightbox">
												<div class="tu_three" id="main1"></div>
												<div class="tu_three" id="main2"></div>
												<div class="tu_three" id="main3"></div>
												<div class="tu_three" id="main4"></div>
											</div>--%>

											<%--	m*n: 3*4	--%>
		<%--									<div class="tu_rightbox1">
												<div class="tu_four" id="main1"></div>
												<div class="tu_four" id="main2"></div>
												<div class="tu_four" id="main3"></div>
												<div class="tu_four" id="main4"></div>
												<div class="tu_four" id="main5"></div>
												<div class="tu_four" id="main6"></div>
												<div class="tu_four" id="main7"></div>
												<div class="tu_four" id="main8"></div>
												<div class="tu_four" id="main9"></div>
												<div class="tu_four" id="main10"></div>
												<div class="tu_four" id="main11"></div>
												<div class="tu_four" id="main12"></div>
											</div>--%>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
					<!-- /block -->
				</div>
			</div>
		</div>


		<footer class="footer" id="footer">
			<hr>
		<p>&copy; Connectf Dev Team 2016</p>
		</footer>

	<script type="text/javascript">
		//图表提示下拉
		$(document).ready(function() {
			//Default Action
			$(".tab_content").hide(); //Hide all content
			$(".dropdown_top li:first").addClass("drop-active").show(); //Activate first tab
			$(".tab_content:first").show(); //Show first tab content

			//On Click Event
			$(".dropdown_top li").mouseenter(function() {
				$(".tab_content").hide();
				$(".dropdown_top li").removeClass("drop-active"); //Remove any "active" class
				$(this).addClass("drop-active"); //Add "active" class to selected tab
				var text = $(this).attr("alt");
				$(".tab_content").text(text); //Find the rel attribute value to identify the active tab + content
				$(".tab_content").show(200);
				return false;
			});
		});
	</script>
</body>

</html>