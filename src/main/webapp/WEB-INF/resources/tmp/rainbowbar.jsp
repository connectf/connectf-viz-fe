<%@page contentType="text/html; charset=gb2312" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <meta charset="utf-8">
    <title>ECharts</title>
  </head>
  
  <body>
    <!-- ΪECharts׼��һ���߱���С����ߣ���Dom -->
    <!--  
    	<div id="main" style="position: absolute; left: 0px; top: 0px; width: 827px; height: 378px;" width="827" height="378"></div>
    -->
    <div id="main" style="height:400px"></div>
    <!-- ECharts���ļ����� -->
    <script type="text/javascript" src="echarts/build/dist/echarts.js"></script>
    <script type="text/javascript">
        // ·������
        require.config({
            paths: {
                echarts: 'echarts/build/dist'
            }
        });
        
        // ʹ��
        require(
            [
                'echarts',
                'echarts/chart/bar' // ʹ����״ͼ�ͼ���barģ�飬�������
            ],
            function (ec) {
                // ����׼���õ�dom����ʼ��echartsͼ��
                var myChart = ec.init(document.getElementById('main')); 
                
				var	option = {
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
					            name: 'ECharts���Ӹ���ͳ��',
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
					                    {xAxis:0, y: 350, name:'Line', symbolSize:20, symbol: 'image://../asset/ico/����ͼ.png'},
					                    {xAxis:1, y: 350, name:'Bar', symbolSize:20, symbol: 'image://../asset/ico/��״ͼ.png'},
					                    {xAxis:2, y: 350, name:'Scatter', symbolSize:20, symbol: 'image://../asset/ico/ɢ��ͼ.png'},
					                    {xAxis:3, y: 350, name:'K', symbolSize:20, symbol: 'image://../asset/ico/K��ͼ.png'},
					                    {xAxis:4, y: 350, name:'Pie', symbolSize:20, symbol: 'image://../asset/ico/��״ͼ.png'},
					                    {xAxis:5, y: 350, name:'Radar', symbolSize:20, symbol: 'image://../asset/ico/�״�ͼ.png'},
					                    {xAxis:6, y: 350, name:'Chord', symbolSize:20, symbol: 'image://../asset/ico/����ͼ.png'},
					                    {xAxis:7, y: 350, name:'Force', symbolSize:20, symbol: 'image://../asset/ico/������ͼ.png'},
					                    {xAxis:8, y: 350, name:'Map', symbolSize:20, symbol: 'image://../asset/ico/��ͼ.png'},
					                    {xAxis:9, y: 350, name:'Gauge', symbolSize:20, symbol: 'image://../asset/ico/�Ǳ���.png'},
					                    {xAxis:10, y: 350, name:'Funnel', symbolSize:20, symbol: 'image://../asset/ico/©��ͼ.png'},
					                ]
					            }
					        }
					    ]
					};
        
                // Ϊecharts����������� 
                myChart.setOption(option); 
            }
        );
    </script>
  </body>
</html>
