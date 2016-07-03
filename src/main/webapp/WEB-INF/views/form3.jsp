<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>属性设置</title>
    <meta name="_csrf" content="${_csrf.token}"/>
    <meta name="_csrf_header" content="${_csrf.headerName}"/>
    <!-- Bootstrap -->
    <link href="/resources/bootstrap/css/bootstrap.min.css" rel="stylesheet" media="screen">
    <link href="/resources/bootstrap/css/bootstrap-responsive.min.css" rel="stylesheet" media="screen">
    <link href="/resources/assets/styles.css" rel="stylesheet" media="screen">
    <link href="/resources/bootstrap/css/new-style.css" rel="stylesheet" media="screen">
    <script src="/resources/vendors/modernizr-2.6.2-respond-1.1.0.min.js"></script>
    <!-- DataTables CSS -->
    <link rel="stylesheet" type="text/css" href="/resources/vendors/datatables/css/jquery.dataTables.css">
    <!-- jQuery -->
    <script type="text/javascript" charset="utf8" src="/resources/vendors/datatables/js/jquery.js"></script>
    <!-- DataTables -->
    <script type="text/javascript" charset="utf8" src="/resources/vendors/datatables/js/jquery.dataTables.js"></script>
    <style>
        .row {margin: 0px; padding: 0px;}
        .pagination {margin: 0px;}
        .example_info {line-height: 30px;}
        .pagination ul {float: right;}
    </style>
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
                                            class="dropdown-toggle" data-toggle="dropdown"> <i class="icon-user"></i>
                         <i class="caret"></i>

                    </a>
                        <ul class="dropdown-menu">
                            <li><a tabindex="-1" href="#">Profile</a></li>
                            <li class="divider"></li>
                            <li><a tabindex="-1" href="login.html">Logout</a></li>
                        </ul>
                    </li>
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
<div class="row-fluid">
    <!--/span-->
    <div class="span12" id="content">
        <div class="row-fluid section">
            <!-- block -->
            <div class="block">
                <div class="navbar navbar-inner block-header">
                    <div class="muted pull-left">属性设置</div>
                </div>
                <div class="block-content collapse in">
                    <div class="tab-pane" id="tab3">

                        <div class="span12">

                            <table cellpadding="0" cellspacing="0" border="0" class="table table-striped table-bordered" class="display"
                                   id="dataList">
                                <thead>
                                <tr>
                                    <th>序号</th>
                                    <th>属性名称</th>
                                    <th>属性ID</th>
                                    <th>属性类型</th>
                                    <th>Dimension/Measurement</th>
                                    <th>数据类型</th>
                                    <th>操作</th>
                                </tr>
                                </thead>
                                <tbody>

                                </tbody>
                            </table>

                        </div>
                        <div class="form-actions form-actions_box">
                            <button type="submit" class="btn btn-primary form-actions-mg" id="prev">上一步</button>
                            <%--<button type="submit" class="btn btn-primary form-actions-mg" id="finish">完成</button>--%>
                            <a href="/chart" class="btn btn-primary form-actions-mg" tabindex="-1">完成</a>
                        </div>
                    </div>
                </div>
            </div>
            <!-- /block -->
        </div>
    </div>


</div>
<hr>

<footer>
    <p>&copy; Connectf Dev Team 2016</p>
</footer>
<!--修改模态对话框 -->
<div id="modifyModal" class="modal hide fade" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-header aaa">
        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
        <h3 >提示</h3>
    </div>
    <div class="modal-body bbb">
        <p>
        <h4>数据维度:</h4>
        <select id="modDimensionsSel" class="selectpicker" data-style="btn-primary">
            <option value="0">请选择</option>
            <option value="Dimension">Dimension</option>
            <option value="Measurement">Measurement</option>
        </select>
        </p>
        <p>
        <h4>数据类型:</h4>
        <select id="modTypeSel" class="selectpicker" data-style="btn-primary">
            <%--<option value="0">请选择</option>--%>

        </select>
        </p>
    </div>
    <div class="modal-footer">
        <button class="btn"  data-dismiss="modal" aria-hidden="true">取消</button>
        <button id="modbtnOK" class="btn btn-primary" aria-hidden="true">确定</button>
    </div>
</div>

<script src="/resources/vendors/jquery-1.9.1.min.js"></script>
<script src="/resources/bootstrap/js/bootstrap.min.js"></script>
<script src="/resources/vendors/datatables/js/jquery.dataTables.min.js"></script>
<script src="/resources/assets/scripts.js"></script>
<script>
    $(document).ready(function(){

        var token = $("meta[name='_csrf']").attr("content");
        var header = $("meta[name='_csrf_header']").attr("content");
        var dimension = null;
        var tds = null;
        var type = null;
        var attributeId = null;

        function AttributeListInit(index,
                                   attibuteName,
                                   attributeId,
                                   attributeDataType,
                                   attributeDMType,
                                   attributeCategory,
                                   btn) {
            this.index = index;
            this.attibuteName = attibuteName;
            this.attributeId = attributeId;
            this.attributeDataType = attributeDataType;
            this.attributeDMType = attributeDMType;
            this.attributeCategory = attributeCategory;
            this.btn = btn;
        }

        var getAllAttributes = function(){
            $.ajax({
                type:"POST",
                async:false,
                dataType: 'json',
                url:"/getAttributeUserLocals4DataSet",
                data:{},
                beforeSend: function(xhr) {
                    xhr.setRequestHeader(header,token);
                },
                success: function(object){
                    var data = new Array(object.length);
                    $.each(object,function(index,value){
                        data[index] = new AttributeListInit(
                                index + 1,
                                value.attibuteName,
                                value.attributeId,
                                value.attributeDataType,
                                value.attributeDMType,
                                value.attributeCategory,
                                "<button class=\"btn btn-info btn-mini\">修改</button>"
                        );
                    });

                    $('#dataList').dataTable({
                        data:data,
                        columns: [
                            {data: 'index'},
                            {data: 'attibuteName'},
                            {data: 'attributeId'},
                            {data: 'attributeDataType'},
                            {data: 'attributeDMType'},
                            {data: 'attributeCategory'},
                            {data: 'btn'}
                        ],

                        "destroy" : true,
                        "deferRender" : true,//懒加载
                        "scrollY" : "350px",
                        "scrollCollapse" : true,
                        "lengthChange" : true,
                        "lengthMenu" : [ 20, 50, 100],//每页展示数量选项
                        language : {//国际化
                            "sProcessing" : "处理中...",
                            "sLengthMenu" : "每页显示 _MENU_ 项数据",
                            "sZeroRecords" : "没有匹配的数据",
                            "sInfo" : "显示第 _START_ 至 _END_ 项数据，共 _TOTAL_ 项",
                            "sInfoEmpty" : "显示第 0 至 0 项结果，共 0 项",
                            "sInfoFiltered" : "(由 _MAX_ 项结果过滤)",
                            "sInfoPostFix" : "",
                            "sSearch" : "搜索:",
                            "sEmptyTable" : "暂无数据",
                            "sLoadingRecords" : "载入中...",
                            "sInfoThousands" : ",",
                            "oPaginate" : {
                                "sFirst" : "首页",
                                "sPrevious" : "上页",
                                "sNext" : "下页",
                                "sLast" : "末页"
                            }
                        }
                    });
                },
                error:function(){

                }
            });
        };

        getAllAttributes();

        $("#dataList tbody ").on("click","button",function(){
            var flag = $(this).html();//button name
            tds = $(this).parents('tr').children('td');// all td elements value
            attributeId = tds.eq(2).text();
            dimension = tds.eq(4).text();
            type = tds.eq(5).text();

            if(flag == "修改"){
                $("#modDimensionsSel option").each(function(){
                    if($(this).text() == dimension){
                        $(this).attr("selected", true);
                    }
                });

                $("#modTypeSel option").each(function(){
                    if($(this).attr("value") == type){
                        $(this).attr("selected", true);
                    }
                });

                $('#modifyModal').modal();
            }
        });

        //finish button
        $("#finish").on("click",function(){

        });

        $("#prev").on("click",function(){
            window.location.href = "/form2?${_csrf.parameterName}=${_csrf.token}";
        });

        $("#modbtnOK").on("click",function(){
            var attributeDMType = $("#modDimensionsSel").val();
            var attributeCategory = $("#modTypeSel").val();

            if (attributeDMType == 0){
                alert("请选择合适的数据维度@");
                return;
            }

            if(attributeCategory == 0){
                alert("请选择合适的数据类型@");
                return;
            }
            $('#modifyModal').modal("hide");

            $.ajax({
                type:"POST",
                async:false,
                dataType: 'json',
                url:"/updateAttributeUserLocalByUser",
                data:{
                    attributeDMType:attributeDMType,
                    attributeCategory:attributeCategory,
                    attributeId:attributeId
                },
                beforeSend: function(xhr) {
                    xhr.setRequestHeader(header,token);
                },
                success: function(object){
                    if(object == true){
                        getAllAttributes();
                    }
                },
                error:function(){

                }
            });
        });

        $.ajax({
            type:"POST",
            async:false,
            dataType: 'json',
            url:"/getDataCategories",
            data:{},
            beforeSend: function(xhr) {
                xhr.setRequestHeader(header,token);
            },
            success: function(object){
                var modTypeSel = $("#modTypeSel");
                modTypeSel.empty();
                modTypeSel.append($("<option>").attr("value","0").html("请选择"));
                $.each(object,function(index,value){
                    var id = value.id;
                    var name = value.name;
                    modTypeSel.append($("<option>").attr("value",id).html(name));
                });
            },
            error:function(){

            }
        });
    });
</script>
</body>
</html>