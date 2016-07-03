<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>选择数据集</title>
    <meta name="_csrf" content="${_csrf.token}"/>
    <meta name="_csrf_header" content="${_csrf.headerName}"/>
    <!-- Bootstrap -->
    <link href="/resources/bootstrap/css/bootstrap.min.css" rel="stylesheet" media="screen">
    <link href="/resources/bootstrap/css/bootstrap-responsive.min.css" rel="stylesheet" media="screen">
    <link href="/resources/assets/styles.css" rel="stylesheet" media="screen">
    <link href="/resources/bootstrap/css/new-style.css" rel="stylesheet" media="screen">

    <!-- DataTables CSS -->
    <link rel="stylesheet" type="text/css" href="/resources/vendors/datatables/css/jquery.dataTables.css">
    <!-- jQuery -->
    <script type="text/javascript" charset="utf8" src="/resources/vendors/datatables/js/jquery.js"></script>
    <!-- DataTables -->
    <script type="text/javascript" charset="utf8" src="/resources/vendors/datatables/js/jquery.dataTables.js"></script>
    <link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/1.10.10/css/jquery.dataTables.min.css">
    <link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/select/1.1.0/css/select.dataTables.min.css">
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
                            <li><a tabindex="-1" href="#">选择数据源</a></li>
                            <li><a tabindex="-1" href="#">选择数据集</a></li>
                            <li><a tabindex="-1" href="#">设定数据</a></li>
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
                    <div class="muted pull-left">选择数据集</div>
                </div>
                <div class="block-content collapse in">
                    <div class="tab-pane" id="tab3">

                        <div class="span12">

                            <table cellpadding="0" cellspacing="0" border="0" class="table table-striped table-bordered" class="display"
                                   id="dataList">
                                <thead>
                                <tr>
                                    <th></th>
                                    <th>数据集名称</th>
                                    <th>数据集ID</th>
                                    <th>数据源名称</th>
                                    <th>描述</th>
                                </tr>

                                </thead>
                                <tbody>

                                </tbody>
                            </table>
                            <input id="hide_dataSet" type="hidden" value="">
                        </div>
                        <div class="form-actions form-actions_box">
                            <button type="submit" class="btn btn-primary form-actions-mg" id="prev">上一步</button>
                            <button type="submit" class="btn btn-primary form-actions-mg" id="next">下一步</button>
                            <button type="button" class="btn" id="cancel">取消</button>
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

<script src="/resources/vendors/jquery-1.9.1.min.js"></script>
<%--<script src="/resources/bootstrap/js/bootstrap.min.js"></script>--%>
<script src="/resources/vendors/datatables/js/jquery.dataTables.min.js"></script>
<script src="https://cdn.datatables.net/select/1.1.0/js/dataTables.select.min.js"></script>
<script src="/resources/assets/scripts.js"></script>
<script>
    $(document).ready(function(){

        var token = $("meta[name='_csrf']").attr("content");
        var header = $("meta[name='_csrf_header']").attr("content");

        function DataSetInit(btn,dataSetName,dataSetId,dataSourceName,dataSetDesc){
            this.btn = btn;
            this.dataSetName = dataSetName;
            this.dataSetId = dataSetId;
            this.dataSourceName = dataSourceName;
            this.dataSetDesc = dataSetDesc;
        }

        var getAllDataSets = function(){
            $.ajax({
                type:"POST",
                async:false,
                dataType: 'json',
                url:"/getAllDataSetName",
                data:{},
                beforeSend: function(xhr) {
                    xhr.setRequestHeader(header,token);
                },
                success: function(object){
                    var data = new Array(object.length);
                    $.each(object,function(index,value){
                        data[index] = new DataSetInit(
                                "<td></td>",
                                value.dataSetName,
                                value.dataSetId,
                                value.dataSourceName,
                                value.dataSetDesc
                        );
                    });

                    $('#dataList').dataTable({
                        data:data,
                        select: true,
                        columns: [
                            { data: 'btn'},
                            { data: 'dataSetName'},
                            { data: 'dataSetId'},
                            { data: 'dataSourceName' },
                            { data: 'dataSetDesc'}
                        ],
                        columnDefs: [ {
                            orderable: false,
                            className: 'select-checkbox',
                            targets:   0
                        } ],
                        select: {
                            style:    'os',
                            selector: 'td:first-child'
                        },
                        order: [[ 1, 'asc' ]],
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

        getAllDataSets();

        var table = $('#dataList').DataTable();
        table.on( 'select', function ( e, dt, type, indexes ) {
            var rowData = table.rows( indexes ).data().toArray();
//            alert(JSON.stringify(rowData));
            var dataSetId = rowData[0].dataSetId;
            $("#hide_dataSet").val(dataSetId);
        } )
        .on( 'deselect', function ( e, dt, type, indexes ) {
            $("#hide_dataSet").val("");
        } );

        $("#next").on("click",function(){
            var dataSetId = $("#hide_dataSet").val();
            if (dataSetId.length !=0){
                $.ajax({
                    type:"POST",
                    async:false,
                    dataType: 'json',
                    url:"/setDataSetId",
                    data:{dataSetId:dataSetId},
                    beforeSend: function(xhr) {
                        xhr.setRequestHeader(header,token);
                    },
                    success: function(object){
                        if (object == true){
                            window.location.href = "/form3?${_csrf.parameterName}=${_csrf.token}";
                        }
                    },
                    error:function(){

                    }
                });
            }
        });


        $("#prev").on("click",function(){
            window.location.href = "/form?${_csrf.parameterName}=${_csrf.token}";
        });
    });
</script>
</body>
</html>