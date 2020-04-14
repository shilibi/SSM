<%--
  Created by IntelliJ IDEA.
  User: SenseChuang
  Date: 2019/11/28
  Time: 10:07
  To change this template use File | Settings | File Templates.
--%>
<%
    pageContext.setAttribute("APP_PATH",request.getContextPath());
    //APP_PATH:以/开始，但不以/结束。
%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core"  prefix="c" %><!--添加c标签-->
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <!--web路径
    不以/开始的相对路径，找资源，以当前资源的路径为基准，经常出问题。
    以/开始的相对路径，找资源，以服务器的路径为标准（http://localhost:8080),需要加上项目名

    -->
    <script type="text/javascript" src="${APP_PATH}/static/js/jquery.min.js"></script>
    <link href="${APP_PATH}/static/bootstrap-3.3.7-dist/css/bootstrap.css" rel="stylesheet">
    <script src = "${APP_PATH}/static/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
    <title>员工列表</title>
</head>
<body>
<!-- 员工新增模态框 -->
<div class="modal fade" id="empAddModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="myModalLabel">员工添加</h4>
            </div>
            <div class="modal-body">
                <!--模态框内的内容-->
                <form class="form-horizontal">
                    <div class="form-group">
                        <label for="empName_add_input" class="col-sm-2 control-label">empName</label>
                        <div class="col-sm-10">
                            <p class="form-control-static" id="empName_add_static"></p>
                            <input type="email" name="empName" class="form-control" id="empName_add_input" placeholder="empName">
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="email_add_input" class="col-sm-2 control-label">email</label>
                        <div class="col-sm-10">
                            <input type="email" name="email"  class="form-control" id="email_add_input" placeholder="ssm@163.com">
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="email_add_input" class="col-sm-2 control-label">gender</label>
                        <div class="col-sm-10">
                            <label class="radio-inline">
                                <input type="radio" name="gender" id="gender1_add_input" value="M" checked="checked"> 男
                            </label>
                            <label class="radio-inline">
                                <input type="radio" name="gender" id="gender2_add_input" value="F"> 女
                            </label>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="email_add_input" class="col-sm-2 control-label">deptName</label>
                        <div class="col-sm-4">
                            <!--部门提交部门id即可-->
                            <select class="form-control" name="dId" id="dept_add_select">
                            </select>
                        </div>
                    </div>


                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button type="button" class="btn btn-primary" id="emp_save_btn">保存</button>
            </div>
        </div>
    </div>
</div>
<!-- 员工修改模态框 -->
<div class="modal fade" id="empUpdateModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" >员工修改</h4>
            </div>
            <div class="modal-body">
                <!--模态框内的内容-->
                <form class="form-horizontal">
                    <div class="form-group">
                        <label for="empName_add_input" class="col-sm-2 control-label">empName</label>
                        <div class="col-sm-10">
                            <p class="form-control-static" id="emp_update_name_static"></p>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="email_add_input" class="col-sm-2 control-label">email</label>
                        <div class="col-sm-10">
                            <input type="email" name="email"  class="form-control" id="email_update_input" placeholder="ssm@163.com">
                            <span id="helpBlock2" class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="email_add_input" class="col-sm-2 control-label">gender</label>
                        <div class="col-sm-10">
                            <label class="radio-inline">
                                <input type="radio" name="gender" id="gender1_update_input" value="M" checked="checked"> 男
                            </label>
                            <label class="radio-inline">
                                <input type="radio" name="gender" id="gender2_update_input" value="F"> 女
                            </label>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="email_add_input" class="col-sm-2 control-label">deptName</label>
                        <div class="col-sm-4">
                            <!--部门提交部门id即可-->
                            <select class="form-control" name="dId" id="dept_update_select">
                            </select>
                        </div>
                    </div>


                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button type="button" class="btn btn-primary" id="emp_update_btn">更新</button>
            </div>
        </div>
    </div>
</div>
<%--  --%>
<div class="container">
    <!--标题-->
    <div class="row">
        <div class="col-md-12">
            <h1>SSM-CRUD</h1>
        </div>
    </div>
    <!--按钮-->
    <div class="row">
        <div class="col-md-4 col-md-offset-8">
            <button class="btn btn-primary" id = "emp_add_modal_btn">新增</button>
            <button class="btn btn-warning" id="emp_delete_all_btn">删除</button>
        </div>
    </div>
    <!--表格-->
    <div class="row">
        <div class="col-md-12" >
            <table class="table table-hover" id="emps_table">
                <thead>
                <tr>
                    <th>
                        <input type="checkbox" id="check_all"/>
                    </th>
                    <th>#</th>
                    <th>name</th>
                    <th>gender</th>
                    <th>email</th>
                    <th>deptName</th>
                    <th>操作</th>
                </tr>
                </thead>
                <tbody>

                </tbody>
            </table>
        </div>
    </div>
    <!--页码-->
    <div class="row">
        <!--分页文字信息-->
        <div class="col-md-6" id="page_info_area">
        </div>
        <!--分页条信息-->
        <div class="col-md-6" id="page_nav_area">
        </div>
    </div>
</div>
<script type="text/javascript">
    //1、页面加载完成后，直接发送一个ajax请求，要到分页数据
    var totalRecord,currentPage;
    $(function () {
            to_page(1);
    });
    
    function to_page(pn) {
        $.ajax({
            url:"${APP_PATH}/empswithjson",
            data:"pn=" + pn,
            type:"GET",
            success:function (result) {
                //1、解析并显示员工数据
                build_emps_table(result);
                //2、解析并显示分页信息
                build_page_info(result);
                //3、解析显示分页条数据源
                build_page_nav(result);
                totalRecord = result.extend.pageInfo.total;
                currentPage = result.extend.pageInfo.pageNum;
            }
        });
    }
    
    function  build_emps_table(result) {
        $("#emps_table tbody").empty();
        var emps=result.extend.pageInfo.list;
        $.each(emps,function(index,item) {//jquery提供的 $.each方法
            var checkBoxTd = $("<td><input type='checkbox' class='check_item'/></td>");
            var empIdTd = $("<td></td>").append(item.empId);
            var empNameTd = $("<td></td>").append(item.empName);
            var genderTd = $("<td></td>").append(item.gender=='M'?'男':'女');
            var emailTd = $("<td></td>").append(item.email);
            var deptNameTd = $("<td></td>").append(item.department.deptName);

            var editBtn = $("<button></button>").addClass("btn btn-warning  btn-sm edit_btn")
                .append($("<span></span>")).addClass("glyphicon glyphicon-pencil").append("编辑");
            //为编辑按钮添加一个自定义的属性
            editBtn.attr("edit-id",item.empId);
            var delBtn = $("<button></button>").addClass("btn btn-danger  btn-sm delete_btn")
                .append($("<span></span>")).addClass("glyphicon glyphicon-trash").append("删除");
            delBtn.attr("del-id",item.empId);
            //append方法执行完成以后还是返回一个append对象
            var btnTd = $("<td></td>").append(editBtn).append("&nbsp;").append(delBtn);
            $("<tr></tr>").append(checkBoxTd)
                .append(empIdTd)
                .append(empNameTd)
                .append(genderTd)
                .append(emailTd)
                .append(deptNameTd)
                .append(btnTd)
                .appendTo("#emps_table tbody");
        });
    }

    //解析显示分页信息
    function build_page_info(result) {
        $("#page_info_area").empty();
        $("#page_info_area").append("当前"+result.extend.pageInfo.pageNum
            +"页,总共"+result.extend.pageInfo.pages+"页，总共"+result.extend.pageInfo.total+"条记录")
    }

    //解析显示分页条，点击分页要能去下一页。。。。
    function  build_page_nav(result) {
        $("#page_nav_area").empty();
        var ul=$("<ul></ul>").addClass("pagination");
        //构件元素
        var firsPageLi=$("<li></li>").append($("<a></a>").append("首页").attr("href","#"));
        var prePageLi=$("<li></li>").append($("<a></a>").append("&laquo;"));
        //判断是否有前一页
        if(result.extend.pageInfo.hasPreviousPage==false){
            firsPageLi.addClass("disabled");
            prePageLi.addClass("disabled");
        }else{
            firsPageLi.click(function(){
                to_page(1);
            });
            prePageLi.click(function(){
                to_page(result.extend.pageInfo.pageNum-1);
            });
        }

        var nexPageLi=$("<li></li>").append($("<a></a>").append("&raquo;"));
        var lastPageLi=$("<li></li>").append($("<a></a>").append("末页").attr("href","#"));

        //判断是否有后一页
        if(result.extend.pageInfo.hasNextPage==false){
            nexPageLi.addClass("disabled");
            lastPageLi.addClass("disabled");
        }else{
            nexPageLi.click(function(){
                to_page(result.extend.pageInfo.pageNum+1);
            });
            lastPageLi.click(function(){
                to_page(result.extend.pageInfo.pages);
            });
        }
        //添加首页和前一个的提示
        ul.append(firsPageLi).append(prePageLi);
        //1，2,3遍历给URL中添加代码提示
        $.each(result.extend.pageInfo.navigatepageNums,function(index,item){
            var numLi=$("<li></li>").append($("<a></a>").append(item));
            //判断
            if(result.extend.pageInfo.pageNum==item ){
                numLi.addClass("active");
            }
            numLi.click(function(){
                to_page(item);
            });
            ul.append(numLi);
        });

        //添加下一页和末页的提示
        ul.append(nexPageLi).append(lastPageLi);

        //把ul加入到nav中去
        var nav=$("<nav></nav>").append(ul);
        $("#page_nav_area").append(nav);
        nav.appendTo("#page_nav_area");
    }

    function reset_form(ele){
        $(ele)[0].reset();
        $(ele).find("*").removeClass("has-error has-success");
        $(ele).find(".help-block").text("");
    }

    $("#emp_add_modal_btn").click(function() {
        //清除表单数据
        reset_form("#empAddModal form");
        getDepts("#empAddModal select");
        $("#empAddModal").modal({
            backdrop:"static"
        });
    });

    function getDepts(ele) {

        $(ele).empty();
        $.ajax({
           url:"${APP_PATH}/depts",
           type:"GET",
           success:function (result) {
               console.log(result);
               $.each(result.extend.depts,function () {
                   var optionEle = $("<option></option>").append(this.deptName).attr("value",this.deptId);
                   optionEle.appendTo(ele);
               })

           }
        });
    }
    
    $("#empName_add_input").change(function(){
        //发送ajax请求校验用户名是否可用
        var empName = this.value;
        $.ajax({
            url:"${APP_PATH}/checkuser",
            data:"empName="+empName,
            type:"POST",
            success:function (result) {
                if(result.code == 100){
                    show_validate_msg("#empName_add_input","success","用户名可用");
                    $("#emp_save_btn").attr("ajax-va","success");
                }else{
                    show_validate_msg("#empName_add_input","error",result.extend.va_msg);
                    $("#emp_save_btn").attr("ajax-va","error");
                }
            }
        });
    })
    //点击保存的方法
    $("#emp_save_btn").click(function () {

        if(!validate_add_form()){
            return false;
        }

        if($(this).attr("ajax-va") == "error"){
            return false;
        }
        //判断之前ajax用户名校验是否成功
        $.ajax({
            url:"${APP_PATH}/emp",
            type:"POST",
            data:$("#empAddModal form").serialize(),
            success:function(result){
                //隐藏当前模态框
                if(result.code == 100){
                    $('#empAddModal').modal('hide');
                    //如果页码范围超过当前页码，就会跳到最后一页，
                    //1、可以选择使用一个极大数：9999
                    //2、可以将当前记录数设置为最大值
                    to_page(totalRecord);
                }
                else{
                    if(undefined != result.extend.errorFields.email){
                        show_validate_msg("#email_add_input","error",result.extend.errorFields.email);
                    }
                    if(undefined != result.extend.errorFields.empName){
                        show_validate_msg("#empName_add_input","error",result.extend.errorFields.empName);
                    }
                    console.log(result)
                }

            }
        })
    });
    function validate_add_form(){
       var empName =  $("#empName_add_input").val();
       var email =  $("#email_add_input").val();
       var regName = /(^[a-zA-Z0-9_-]{4,16}$)|(^[\u2E80-\u9FFF]{2,5})/;
       var regEmail =  /^([a-zA-Z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/
       if(!regName.test(empName)){
           //alert("用户名不正确！");
           show_validate_msg("#empName_add_input","error","用户名不正确");
           return false;
       }else{
           show_validate_msg("#empName_add_input","success","");
       }
       if(!regEmail.test(email)){
           //alert("用户名不正确！");
           show_validate_msg("#email_add_input","error","邮箱地址不正确");
           return false;
       }else{
           show_validate_msg("#email_add_input","success","");
       }
       return true;

    }

    function show_validate_msg(ele,status,msg) {
        $(ele).parent().removeClass("has-success has-error");
        $(ele).next("span").text("");
        if("success" == status){
            $(ele).parent().addClass("has-success");
            $(ele).next("span").text(msg);
        }else if("error" == status) {
            $(ele).parent().addClass("has-error");
            $(ele).next("span").text(msg);
        }
    }
    $(document).on("click",".edit_btn",function () {
        ///alert("edit");
        //1、查询部门信息，并显示部门列表
        getDepts("#empUpdateModal select");
        //2、查出员工信息，显示员工信息
        getEmp($(this).attr("edit-id"));
        //把员工id传递给模态框的更新按钮
        $("#emp_update_btn").attr("edit-id",$(this).attr("edit-id"));
        $("#empUpdateModal").modal({
            backdrop:"static"
        });
    });
    function  getEmp(id) {
        $.ajax({
            url:"${APP_PATH}/emp/"+id,
            type:"GET",
            success:function (result) {
                var empData = result.extend.emp;
                console.log(empData);
                $("#emp_update_name_static").text([empData.empName]);
                $("#email_update_input").val([empData.email]);
                $("#empUpdateModal input[name=gender]").val([empData.gender]);
                $("#empUpdateModal select").val([empData.dId]);
            }
        });

    }
    $("#emp_update_btn").click(function () {
        //1、验证邮箱是否合法
        var email =  $("#email_update_input").val();
        var regEmail =  /^([a-zA-Z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/
        if(!regEmail.test(email)){
            show_validate_msg("#email_update_input","error","邮箱地址不正确");
            return false;
        }else{
            show_validate_msg("#email_update_input","success","");
        }
        //2、发送Ajax请求保存更新的员工数据
        $.ajax({
            url:"${APP_PATH}/emp/"+$(this).attr("edit-id"),
            type:"PUT",
            data:$("#empUpdateModal form").serialize(),
            success:function (result) {
                //alert(result.msg);
                $("#empUpdateModal").modal("hide");
                to_page(currentPage);
            }
        });
    });

    //单个删除
    $(document).on("click",".delete_btn",function () {
        //弹出确认删除对话框
        var empName = $(this).parents("tr").find("td:eq(2)").text();
        var empId = $(this).attr("del-id");
        //alert($(this).parents("tr").find("td:eq(1)").text());
        if(confirm("确认删除【"+empName+"】吗？")){
            //确认后发送ajax请求
            $.ajax({
               url:"${APP_PATH}/emp/"+empId,
                type:"DELETE",
                success:function (result) {
                    alert(result.msg);
                    //回到本页
                    to_page(currentPage);
                }
            });
        }
    });
    //完成全选、全不选功能
    $("#check_all").click(function () {
        //attr获取checked是undefined；
        //dom原生的属性，attr获取自定义属性的值
        //prop修改和读取dom原生属性的值
       $(".check_item").prop("checked",$(this).prop("checked"));
        // $(".check_id")
    })
    $(document).on("click",".check_item",function () {
        //判断当前选择中的元素是否5个
        //alert($(".check_item:checked").length);
        var flag = ($(".check_item:checked").length==$(".check_item").length);
        $("#check_all").prop("checked",flag);
    });
    $("#emp_delete_all_btn").click(function () {
        var empNames = "";
        var del_idstr = "";
        $.each($(".check_item:checked"),function () {
            empNames += $(this).parents("tr").find("td:eq(2)").text()+",";
            del_idstr += $(this).parents("tr").find("td:eq(1)").text()+"-";
        });
        empNames = empNames.substring(0,empNames.length-1);
        del_idstr = del_idstr.substring(0,del_idstr.length-1);
        if(confirm("确认删除【"+empNames+"】吗？")){
            //发送ajax请求，删除
            $.ajax({
                url:"${APP_PATH}/emp/"+del_idstr,
                type:"DELETE",
                success:function (result) {
                    alert(result.msg);
                    to_page(currentPage);
                }
            });
        }
    });
</script>
</body>
</html>
