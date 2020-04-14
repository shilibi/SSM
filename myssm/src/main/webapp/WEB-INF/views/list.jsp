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
    <link href="${APP_PATH}/static/bootstrap-3.3.7-dist/css/bootstrap.css" rel="stylesheet">
    <script src = "${APP_PATH}/static/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
    <script type="text/javascript" src="${APP_PATH}/static/js/jquery-2.0.3.min.js"></script>
    <title>员工列表</title>
</head>
<body>
<!-- 员工添加的模态框 -->
<div class="modal fade" id="empAddModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="myModalLabel">Modal title</h4>
            </div>
            <div class="modal-body">
                ...
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                <button type="button" class="btn btn-primary">Save changes</button>
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
            <button class="btn btn-primary" id="emp_add_modal_btn">新增</button>
            <button class="btn btn-warning">删除</button>
        </div>
    </div>
    <!--表格-->
    <div class="row">
        <div class="col-md-12" >
            <table class="table table-hover">
                <tr>
                    <th>#</th>
                    <th>name</th>
                    <th>gender</th>
                    <th>email</th>
                    <th>deptName</th>
                    <th>操作</th>
                </tr>
                <c:forEach items="${pageInfo.list}" var = "emp"><!--使用c:foreach标签遍历-->
                <tr>
                    <th>${emp.empId}</th>
                    <th>${emp.empName}</th>
                    <th>${emp.gender=="M"?"男":"女"}</th>
                    <th>${emp.email}</th>
                    <th>${emp.department.deptName}</th>
                    <th>
                        <button class="btn btn-warning  btn-sm">
                            <span class="glyphicon glyphicon-pencil" aria-hidden="true"></span>
                            修改</button>
                        <button class="btn btn-danger  btn-sm">
                            <span class="glyphicon glyphicon-trash" aria-hidden="true"></span>
                            删除</button>
                    </th>
                </tr>
                </c:forEach>
            </table>
        </div>
    </div>
    <!--页码-->
    <div class="row">
        <!--分页文字信息-->
        <div class="col-md-6">
            当前${pageInfo.pageNum}页,总共${pageInfo.pages}页，总共${pageInfo.total}条记录
        </div>
        <!--分页条信息-->
        <div class="col-md-6">
            <nav aria-label="Page navigation">
                <ul class="pagination">
                    <li><a href="${APP_PATH}/emps?pn=1"> 首页</a></li>
                    <c:if test="${pageInfo.hasPreviousPage}">
                        <li>
                            <a href="${APP_PATH}/emps?pn=${pageInfo.pageNum-1}" aria-label="Previous">
                                <span aria-hidden="true">&laquo;</span>
                            </a>
                        </li>
                    </c:if>
                    <c:forEach items="${pageInfo.navigatepageNums}" var="page_Num">
                        <c:if test="${page_Num == pageInfo.pageNum}"><!--如果是当前页-->
                            <li class="active"><a href="#">${page_Num}</a></li>
                        </c:if>
                        <c:if test="${page_Num != pageInfo.pageNum}"><!--如果不是当前页-->
                            <li><a href="${APP_PATH}/emps?pn=${page_Num} ">${page_Num}</a></li>
                        </c:if>
                    </c:forEach>
                    <c:if test="${pageInfo.hasNextPage}">
                        <li>
                            <a href="${APP_PATH}/emps?pn=${pageInfo.pageNum+1}" aria-label="Next">
                                <span aria-hidden="true">&raquo;</span>
                            </a>
                        </li>
                    </c:if>
                    <li><a href="${APP_PATH}/emps?pn=${pageInfo.pages}"> 末页</a></li>
                </ul>
            </nav>
        </div>
    </div>
</div>
</body>
</html>
