<%@ page language="java" import="java.util.*" pageEncoding="ISO-8859-1"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
	
	<title>Dragging</title>
        <style type="text/css">
            .dragMe
            {
                background-color:#8FBC8F;
                border:1px solid black;
                color: #fff;
                float:left;
                font-family:verdana,arial;
                font-size:14px;
                font-weight:bold;
                height:100px;
                margin:10px;
                text-align:center;
                width:100px;
            }
            
			body{ line-height:150%    }
			.show{ display:block}
			.hide{ display:none}
			.clone{position: absolute; border:1px solid #666; background-color:#CCCCCC;}
			.over{ border:1px solid #666;}
			#left{ float:left; width:200px; border:1px solid #666;}
			#left li.selected{ background-color:#CCCCCC}
			#right{ margin-left:220px; border:1px solid #666;}
        </style>
  </head>
  
  <body>
  	<div class="dragMe">Drag Me</div>
         
        <div class="dragMe">Drag Me too</div>
 
        <script type="text/javascript" src="lib/jquery-1.11.1.min.js"></script>
        <script type="text/javascript"><!--
            $(document).ready(function ()
            {
                var mousex = 0, mousey = 0;
                var divLeft, divTop;
                $('.dragMe').mousedown(function(e)
                {
                    $(this).clone().addClass("clone").appendTo($("body"));
                    var offset = $(this).offset();
                    divLeft = parseInt(offset.left,10);
                    divTop = parseInt(offset.top,10);
                    mousey = e.pageY;
                    mousex = e.pageX;
                    $(this).bind('mousemove',dragElement);
                    
                    
			        //$("body").css('cursor','move');
			        //$(".clone").css('left',e.clientX+1);
			        //$(".clone").css('top',e.clientY+1);
                });
 
                function dragElement(event)
                {
                    var left = divLeft + (event.pageX - mousex);
                    var top = divTop + (event.pageY - mousey);
                    $(this).css(
                    {
                        'top' :  top + 'px',
                        'left' : left + 'px',
                        'position' : 'absolute'
                    });
                    return false;
                }
                $(document).mouseup(function()
                {
                    $('.dragMe').unbind('mousemove');
                });
                
                /*
                $("#right ul li").mousedown(function(e) {//鼠标按下，鼠标变移动标志，克隆元素，并确定新克隆元素位置

		        
		    	});
			    $(document).mousemove(function(e){
			        if($(".clone").length>0)
			        {
			            $(".clone").css('left',e.clientX+1);
			            $(".clone").css('top',e.clientY+1);    
			        }    
			    });*/
 
            });
        --></script>
  </body>
</html>
