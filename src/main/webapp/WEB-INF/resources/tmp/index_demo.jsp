<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<meta name="keywords" content="jquery,ui,easy,easyui,web">
	<meta name="description" content="easyui help you build your web page easily!">
	<title>jQuery EasyUI Demo</title>
	<link rel="stylesheet" type="text/css" href="stylesheets/theme.css">
	<link rel="stylesheet" type="text/css" href="http://www.jeasyui.net/Public/js/easyui/themes/default/easyui.css">
	<link rel="stylesheet" type="text/css" href="http://www.jeasyui.net/Public/js/easyui/themes/icon.css">
	<script type="text/javascript" src="http://code.jquery.com/jquery-1.6.1.min.js"></script>
	<script type="text/javascript" src="http://www.jeasyui.net/Public/js/easyui/jquery.easyui.min.js"></script>
	<style type="text/css">
		.left{
			width:120px;
			float:left;
		}
		.left table{
			background:#E0ECFF;
		}
		.left td{
			background:#eee;
		}
		.right{
			float:right;
			width:600px;
		}
		.right table{
			background:#E0ECFF;
			width:100%;
		}
		.right td{
			background:#fafafa;
			text-align:center;
			padding:2px;
		}
		.right td{
			background:#E0ECFF;
		}
		.right td.drop{
			background:#fafafa;
			width:100px;
		}
		.right td.over{
			background:#FBEC88;
		}
		.item{
			text-align:center;
			border:1px solid #499B33;
			background:#fafafa;
			width:100px;
		}
		.assigned{
			border:1px solid #BC2A4D;
		}
		
	</style>
	<script>
		$(function(){
			$('.left .item').draggable({
				revert:true,
				proxy:'clone'
			});
			$('.right td.drop').droppable({
				onDragEnter:function(){
					$(this).addClass('over');
				},
				onDragLeave:function(){
					$(this).removeClass('over');
				},
				onDrop:function(e,source){
					$(this).removeClass('over');
					if ($(source).hasClass('assigned')){
						$(this).append(source);
					} else {
						var c = $(source).clone().addClass('assigned');
						$(this).empty().append(c);
						c.draggable({
							revert:true
						});
					}
				}
			});
		});
	</script>
</head>
<body>
<div style="width:750px;">
	<div class="left">
		<table>
			<tr>
				<td><div class="item">English</div></td>
			</tr>
			<tr>
				<td><div class="item">Science</div></td>
			</tr>
			<tr>
				<td><div class="item">Music</div></td>
			</tr>
			<tr>
				<td><div class="item">History</div></td>
			</tr>
			<tr>
				<td><div class="item">Computer</div></td>
			</tr>
			<tr>
				<td><div class="item">Mathematics</div></td>
			</tr>
			<tr>
				<td><div class="item">Arts</div></td>
			</tr>
			<tr>
				<td><div class="item">Ethics</div></td>
			</tr>
		</table>
	</div>
	<div class="right">
		<table>
			<tr>
				<td class="lunch" colspan="6">X axis</td>
			</tr>
			<tr>
				<td class="time">1</td>
				<td class="drop"></td>
				<td class="drop"></td>
				<td class="drop"></td>
				<td class="drop"></td>
				<td class="drop"></td>
			</tr>
			<tr>
				<td class="time">2</td>
				<td class="drop"></td>
				<td class="drop"></td>
				<td class="drop"></td>
				<td class="drop"></td>
				<td class="drop"></td>
			</tr>
			<tr>
				<td class="time">3</td>
				<td class="drop"></td>
				<td class="drop"></td>
				<td class="drop"></td>
				<td class="drop"></td>
				<td class="drop"></td>
			</tr>

			<tr>
				<td class="lunch" colspan="6">Y axis</td>
			</tr>
			<tr>
				<td class="time">1</td>
				<td class="drop"></td>
				<td class="drop"></td>
				<td class="drop"></td>
				<td class="drop"></td>
				<td class="drop"></td>
			</tr>
			<tr>
				<td class="time">2</td>
				<td class="drop"></td>
				<td class="drop"></td>
				<td class="drop"></td>
				<td class="drop"></td>
				<td class="drop"></td>
			</tr>
			<tr>
				<td class="time">3</td>
				<td class="drop"></td>
				<td class="drop"></td>
				<td class="drop"></td>
				<td class="drop"></td>
				<td class="drop"></td>
			</tr>
		</table>
		
	</div>
	
	<div class="stats">
    	<a href="#" onclick="showChart('line')"><p class="stat"><span class="label label-success">折线图</span></p>
    	<a href="#" onclick="showChart('bar')"><p class="stat"><span class="label label-success">柱状图</span></p></a>
    	<a href="#" onclick="showChart('pie')"><p class="stat"><span class="label label-success">饼&nbsp;&nbsp;&nbsp;&nbsp;图</span></p>
	</div>
	</br>
	</br>
	</br>
	</br>
	</br>
	</br>
	</br>
	</br>
	</br>
	</br>
	</br>
	</br>
	</br>
	</br>
	</br>
    <div id="page-stats" class="">
    	<div class="row">
			<div id="main" style="height:400px"></div>
   		</div>
    </div>
</div>

	<!-- ECharts单文件引入 -->
    <script type="text/javascript" src="echarts/build/dist/echarts.js"></script>
    <script type="text/javascript">
        //封装折线图参数  function setOptionPie(data){
		function setOptionLine(){
		    /*
		    var legend_data = [];
		    if(data && data.length > 0){
		        
		        $.each(data, function(idx, d){
		            
		            legend_data.push(d.name);
		        });
		        
		    }
		    
		    var option = {
		        title : {
		            text: data.title || '',
		            x:'center'
		        },
		        tooltip : {
		            trigger: 'item',
		            formatter: "{b} : {c} ({d}%)"
		        },
		        legend: {
		            orient : 'vertical',
		            x : 'left',
		            data:legend_data
		        },
		        calculable : true,
		        series : [
		            {
		                type:'pie',
		                radius : '55%',
		                center: ['50%', '60%'],
		                data:data,
		                itemStyle : {
		                    normal : {
		                        label : {
		                            show: true,
		                            position : 'outer',
		                            formatter : "{b}\n{d}%",//在饼状图上显示百分比
		                        },
		                        labelLine : {
		                            show : true,
		                        }
		                    },
		                    emphasis : {
		                        label : {
		                            show : true,
		                            formatter : "{d}%"//鼠标移动到饼状图上显示百分比
		                        }
		                    }
		                    
		                }
		            }
		        ]
		    }; 
		    */
		    
		    var	option = {
				    tooltip : {
				        trigger: 'axis'
				    },
				    legend: {
				        data:['邮件营销','联盟广告','视频广告','直接访问','搜索引擎']
				    },
				    toolbox: {
				        show : true,
				        feature : {
				            mark : {show: true},
				            dataView : {show: true, readOnly: false},
				            magicType : {show: true, type: ['line', 'bar', 'stack', 'tiled']},
				            restore : {show: true},
				            saveAsImage : {show: true}
				        }
				    },
				    calculable : true,
				    xAxis : [
				        {
				            type : 'category',
				            boundaryGap : false,
				            data : ['周一','周二','周三','周四','周五','周六','周日']
				        }
				    ],
				    yAxis : [
				        {
				            type : 'value'
				        }
				    ],
				    series : [
				        {
				            name:'邮件营销',
				            type:'line',
				            stack: '总量',
				            data:[120, 132, 101, 134, 90, 230, 210]
				        },
				        {
				            name:'联盟广告',
				            type:'line',
				            stack: '总量',
				            data:[220, 182, 191, 234, 290, 330, 310]
				        },
				        {
				            name:'视频广告',
				            type:'line',
				            stack: '总量',
				            data:[150, 232, 201, 154, 190, 330, 410]
				        },
				        {
				            name:'直接访问',
				            type:'line',
				            stack: '总量',
				            data:[320, 332, 301, 334, 390, 330, 320]
				        },
				        {
				            name:'搜索引擎',
				            type:'line',
				            stack: '总量',
				            data:[820, 932, 901, 934, 1290, 1330, 1320]
				        }
				    ]
				};
		    
		    return option;
		}
        
        //封装柱状图参数  function setOptionPie(data){
		function setOptionBar(){
			var	option = {
				    title: {
				        x: 'center',
				        text: 'ECharts例子个数统计',
				        subtext: 'Rainbow bar example',
				        link: 'http://echarts.baidu.com/doc/example.html'
				    },
				    tooltip: {
				        trigger: 'item'
				    },
				    toolbox: {
				        show: true,
				        feature: {
				            dataView: {show: true, readOnly: false},
				            restore: {show: true},
				            saveAsImage: {show: true}
				        }
				    },
				    calculable: true,
				    grid: {
				        borderWidth: 0,
				        y: 80,
				        y2: 60
				    },
				    xAxis: [
				        {
				            type: 'category',
				            show: false,
				            data: ['Line', 'Bar', 'Scatter', 'K', 'Pie', 'Radar', 'Chord', 'Force', 'Map', 'Gauge', 'Funnel']
				        }
				    ],
				    yAxis: [
				        {
				            type: 'value',
				            show: false
				        }
				    ],
				    series: [
				        {
				            name: 'ECharts例子个数统计',
				            type: 'bar',
				            itemStyle: {
				                normal: {
				                    color: function(params) {
				                        // build a color map as your need.
				                        var colorList = [
				                          '#C1232B','#B5C334','#FCCE10','#E87C25','#27727B',
				                           '#FE8463','#9BCA63','#FAD860','#F3A43B','#60C0DD',
				                           '#D7504B','#C6E579','#F4E001','#F0805A','#26C0C0'
				                        ];
				                        return colorList[params.dataIndex]
				                    },
				                    label: {
				                        show: true,
				                        position: 'top',
				                        formatter: '{b}\n{c}'
				                    }
				                }
				            },
				            data: [12,21,10,4,12,5,6,5,25,23,7],
				            markPoint: {
				                tooltip: {
				                    trigger: 'item',
				                    backgroundColor: 'rgba(0,0,0,0)',
				                    formatter: function(params){
				                        return '<img src="' 
				                                + params.data.symbol.replace('image://', '')
				                                + '"/>';
				                    }
				                },
				                data: [
				                    {xAxis:0, y: 350, name:'Line', symbolSize:20, symbol: 'image://../asset/ico/折线图.png'},
				                    {xAxis:1, y: 350, name:'Bar', symbolSize:20, symbol: 'image://../asset/ico/柱状图.png'},
				                    {xAxis:2, y: 350, name:'Scatter', symbolSize:20, symbol: 'image://../asset/ico/散点图.png'},
				                    {xAxis:3, y: 350, name:'K', symbolSize:20, symbol: 'image://../asset/ico/K线图.png'},
				                    {xAxis:4, y: 350, name:'Pie', symbolSize:20, symbol: 'image://../asset/ico/饼状图.png'},
				                    {xAxis:5, y: 350, name:'Radar', symbolSize:20, symbol: 'image://../asset/ico/雷达图.png'},
				                    {xAxis:6, y: 350, name:'Chord', symbolSize:20, symbol: 'image://../asset/ico/和弦图.png'},
				                    {xAxis:7, y: 350, name:'Force', symbolSize:20, symbol: 'image://../asset/ico/力导向图.png'},
				                    {xAxis:8, y: 350, name:'Map', symbolSize:20, symbol: 'image://../asset/ico/地图.png'},
				                    {xAxis:9, y: 350, name:'Gauge', symbolSize:20, symbol: 'image://../asset/ico/仪表盘.png'},
				                    {xAxis:10, y: 350, name:'Funnel', symbolSize:20, symbol: 'image://../asset/ico/漏斗图.png'},
				                ]
				            }
				        }
				    ]
				};
		    
		    return option;
		}
        
        //封装饼图参数  function setOptionPie(data){
		function setOptionPie(){
			var	option = {
				    title : {
				        text: '某站点用户访问来源',
				        subtext: '纯属虚构',
				        x:'center'
				    },
				    tooltip : {
				        trigger: 'item',
				        formatter: "{a} <br/>{b} : {c} ({d}%)"
				    },
				    legend: {
				        orient : 'vertical',
				        x : 'left',
				        data:['直接访问','邮件营销','联盟广告','视频广告','搜索引擎']
				    },
				    toolbox: {
				        show : true,
				        feature : {
				            mark : {show: true},
				            dataView : {show: true, readOnly: false},
				            magicType : {
				                show: true, 
				                type: ['pie', 'funnel'],
				                option: {
				                    funnel: {
				                        x: '25%',
				                        width: '50%',
				                        funnelAlign: 'left',
				                        max: 1548
				                    }
				                }
				            },
				            restore : {show: true},
				            saveAsImage : {show: true}
				        }
				    },
				    calculable : true,
				    series : [
				        {
				            name:'访问来源',
				            type:'pie',
				            radius : '55%',
				            center: ['50%', '60%'],
				            data:[
				                {value:335, name:'直接访问'},
				                {value:310, name:'邮件营销'},
				                {value:234, name:'联盟广告'},
				                {value:135, name:'视频广告'},
				                {value:1548, name:'搜索引擎'}
				            ]
				        }
				    ]
				};
                    
		    return option;
		}
        
        //设置相关参数，展示图表 function showChart(data, type, phoneFlag) {
		function showChart(chartType) {
			 // 使用
	        require(
	            [
	                'echarts',
	                'echarts/chart/' + chartType // 使用柱状图就加载bar模块，按需加载
	            ],
	            function (ec) {
	                // 基于准备好的dom，初始化echarts图表
	                var myChart = ec.init(document.getElementById('main')); 
	                
					var option = null;
	        
	                if (chartType == 'line') {
			            option = setOptionLine();
			        } else if (chartType == 'bar') {
			            option = setOptionBar();
			        } else if (chartType == 'pie') {
			            option = setOptionPie();
			        }
	        
	                // 为echarts对象加载数据 
	                myChart.setOption(option); 
	            }
	        ); 
			/*
		    require([ 'echarts', 'echarts/chart/'+(type.substr(0,3) == 'pie'?'pie':type) ], function(ec) {
		        var myChart = ec.init(document.getElementById(type+'_'+phoneFlag));
		        
		        var option = null;
		        
		        if(type == 'pie4All'){
		            data.title = "口碑现状";
		            option = setOptionPie(data);
		        }else if(type == 'bar'){
		            data.title = "用户评价的分布现状";
		            option = setOptionBar(data);
		        }else if(type == 'pie4Not'){
		            data.title = "负面信息属性分布状况";
		            option = setOptionPie(data);
		        }
		        
		        myChart.setOption(option);
		        
		        window.onresize = function () {
		            myChart.resize();
		        };
		        
		    }); */
		}
        
        $(function(){
            // 路径配置
	        require.config({
	            paths: {
	                echarts: 'echarts/build/dist'
	            }
	        });
		    //ajaxChart("iPhone", "pie4All");
		    //ajaxChart("iPhone", "bar");
		    //ajaxChart("iPhone", "pie4Not");
		});
    	</script>
</body>
</html>