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
    <!--  <script type="text/javascript" src="js/js.js"></script>-->
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
                'echarts/chart/line' // ʹ����״ͼ�ͼ���barģ�飬�������
            ],
            function (ec) {
                // ����׼���õ�dom����ʼ��echartsͼ��
                var myChart = ec.init(document.getElementById('main')); 
                
				var	option = {
				    tooltip : {
				        trigger: 'axis'
				    },
				    legend: {
				        data:['�ʼ�Ӫ��','���˹��','��Ƶ���','ֱ�ӷ���','��������']
				    },
				    toolbox: {
				        show : false,
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
				            data : ['��һ','�ܶ�','����','����','����','����','����']
				        }
				    ],
				    yAxis : [
				        {
				            type : 'value'
				        }
				    ],
				    series : [
				        {
				            name:'�ʼ�Ӫ��',
				            type:'line',
				            stack: '����',
				            data:[120, 132, 101, 134, 90, 230, 210]
				        },
				        {
				            name:'���˹��',
				            type:'line',
				            stack: '����',
				            data:[220, 182, 191, 234, 290, 330, 310]
				        },
				        {
				            name:'��Ƶ���',
				            type:'line',
				            stack: '����',
				            data:[150, 232, 201, 154, 190, 330, 410]
				        },
				        {
				            name:'ֱ�ӷ���',
				            type:'line',
				            stack: '����',
				            data:[320, 332, 301, 334, 390, 330, 320]
				        },
				        {
				            name:'��������',
				            type:'line',
				            stack: '����',
				            data:[820, 932, 901, 934, 1290, 1330, 1320]
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
