<%@ page contentType="text/html;charset=UTF-8" language="java"
         pageEncoding="UTF-8" %>
<!--引入核心标签库-->
<%--<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>--%>
<html>
<head>
    <meta>
    <title>员工列表</title>
    <%
        pageContext.setAttribute("APP_PATH", request.getContextPath());
    %>
    <!--引入jquery-->
    <script type="text/javascript" src="http://code.jquery.com/jquery-1.12.4.min.js"></script>
    <!--引入样式-->
    <link href="${APP_PATH}/static/bootstrap-3.3.7-dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="${APP_PATH}/static/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
</head>
<body>

<!-- 员工修改的模态框 -->
<div class="modal fade" id="empUpdateModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" >员工修改</h4>
            </div>
            <div class="modal-body">
                <!--添加表单-->
                <form class="form-horizontal">
                    <div class="form-group">
                        <label for="empName_add_input" class="col-sm-2 control-label">empName</label>
                        <div class="col-sm-10">
                            <p class="form-control-static" id="empName_update_static"></p>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">email</label>
                        <div class="col-sm-10">
                            <input type="text" name="email" class="form-control" id="email_update_input" placeholder="email@atguigu.com">
                            <!--负责校验显示的代码-->
                            <span class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">gender</label>
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
                        <label class="col-sm-2 control-label">deptName</label>
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

<!-- 员工添加的模态框 -->
<div class="modal fade" id="empAddModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="myModalLabel">员工添加</h4>
            </div>
            <div class="modal-body">
                <!--添加表单-->
                <form class="form-horizontal">
                    <div class="form-group">
                        <label for="empName_add_input" class="col-sm-2 control-label">empName</label>
                        <div class="col-sm-10">
                            <input type="text" name="empName" class="form-control" id="empName_add_input" placeholder="empName">
                            <!--负责校验显示的代码-->
                            <span class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">email</label>
                        <div class="col-sm-10">
                            <input type="text" name="email" class="form-control" id="email_add_input" placeholder="email@atguigu.com">
                            <!--负责校验显示的代码-->
                            <span class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">gender</label>
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
                        <label class="col-sm-2 control-label">deptName</label>
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

<!--搭建显示页面-->
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
            <button type="button" class="btn btn-primary" id="emp_add_modal_btn">新增</button>
            <button type="button" class="btn btn-danger" id="emp_delete_all_btn">删除</button>
        </div>
    </div>
    <!--显示表格数据-->
    <div class="row">
        <div class="col-md-12">
            <table class="table table-hover" id="emp_table">
                <thead>
                    <tr>
                        <th>
                            <input type="checkbox" id="check_all"/>
                        </th>
                        <th>#</th>
                        <th>empName</th>
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
    <!--显示分页信息-->
    <div class="row">
        <!--分页文字信息-->
        <div class="col-md-6" id="page_info_area">

        </div>
        <!--分页条-->
        <div class="col-md-6" id="page_nav_area">

        </div>
    </div>
</div>
<script type="text/javascript">

    var totalRecord, currentPage;
    //1. 页面加载完成以后，直接发送ajax请求要到分页数据
    $(function(){
        //去首页
        to_page(1);
    });

    function to_page(pn) {
        $.ajax({
            url:"${APP_PATH}/empcontroller/emps",
            data:"pn="+pn,
            type:"GET",
            success:function (result) {
                //console.log(result);
                //1. 解析显示员工数据
                build_emps_table(result);
                //2. 解析显示分页数据
                build_page_info(result);
                //3. 解析显示分页条数据
                build_page_nav(result);
            }
        });
    }

    //解析显示表格信息
    function build_emps_table(result) {
        //清空之前table的数据
        $("#emp_table tbody").empty();
        var emps = result.extend.pageInfo.list;
        $.each(emps, function (index, item) {
            var checkBoxTd = $("<td><input type='checkbox' class='check_item'></td>");
            var empIdTd = $("<td></td>").append(item.empId);
            var empNameTd = $("<td></td>").append(item.empName);
            var genderTd = $("<td></td>").append(item.gender=='M'?"男":"女");
            var emailTd = $("<td></td>").append(item.email);
            var deptNameTd = $("<td></td>").append(item.department.deptName);
            <!--按钮-->
            var editBtn = $("<button></button>").addClass("btn btn-primary btn-sm edit_btn")
                .append($("<span></span>").addClass("glyphicon glyphicon-pencil")).append("编辑");
            //为编辑按钮添加一个额外的属性，来表示当前员工的id
            editBtn.attr("edit-id", item.empId);
            var deleteBtn = $("<button></button>").addClass("btn btn-danger btn-sm delete_btn")
                .append($("<span></span>").addClass("glyphicon glyphicon-trash")).append("删除");
            deleteBtn.attr("delete-id", item.empId);
            var btnTd = $("<td></td>").append(editBtn).append(" ").append(deleteBtn);
            //append方法执行后返回的还是原来的元素
            $("<tr></tr>").append(checkBoxTd).append(empIdTd).append(empNameTd).append(genderTd)
                .append(emailTd).append(deptNameTd).append(editBtn).append(" ").append(deleteBtn).appendTo("#emp_table tbody");
        });
    }

    //解析显示分页信息
    function build_page_info(result) {
        //清空之前的分页信息
        $("#page_info_area").empty();
        $("#page_info_area").append("当前"+result.extend.pageInfo.pageNum+"页，总"+result.extend.pageInfo.pages+
            "页，总"+result.extend.pageInfo.total+"条记录！")
        totalRecord = result.extend.pageInfo.total;
        currentPage = result.extend.pageInfo.pageNum;
    }
    //解析显示分页条, 点击分页要能去下一页
    function build_page_nav(result) {
        $("#page_nav_area").empty();
        var ul = $("<ul></ul>").addClass("pagination");
        var firstPageLi = $("<li></li>").append($("<a></a>").append("首页").attr("herf","#"));
        var previousPageLi = $("<li></li>").append($("<a></a>").append("&laquo;"));
        if (result.extend.pageInfo.hasPreviousPage == false){
            firstPageLi.addClass("disabled");
            previousPageLi.addClass("disabled");
        }else{//如果禁用了就不必再绑定事件了
            firstPageLi.click(function () {
                to_page(1);
            });
            previousPageLi.click(function () {
                to_page(result.extend.pageInfo.pageNum - 1);
            });
        }
        var nextPageLi = $("<li></li>").append($("<a></a>").append("&raquo;"));
        var lastPageLi = $("<li></li>").append($("<a></a>").append("末页").attr("herf","#"));
        if (result.extend.pageInfo.hasNextPage == false){
            nextPageLi.addClass("disabled");
            nextPageLi.addClass("disabled");
        }else {//禁用了就不要再绑定事件了
            nextPageLi.click(function () {
                to_page(result.extend.pageInfo.pageNum+1);
            });
            lastPageLi.click(function () {
                to_page(result.extend.pageInfo.pages);
            });
        }

        //添加首页和前一页
        ul.append(firstPageLi).append(previousPageLi);

        //1. 2. 3. 4. 5, 遍历添加页码提示
        $.each(result.extend.pageInfo.navigatepageNums, function (index, item) {

            var numLi = $("<li></li>").append($("<a></a>").append(item));
            if(result.extend.pageInfo.pageNum == item){
                numLi.addClass("active");
            }
            numLi.click(function () {
                to_page(item);
            });
            ul.append(numLi);
        });
        //添加下一页和末页
        ul.append(nextPageLi).append(lastPageLi);

        //把ul添加到nav元素中
        var navEle = $("<nav></nav>").append(ul);

        navEle.appendTo("#page_nav_area");
    }

    /**
     * 表单完整重置的方法
     *      表单的内容、样式
     * */
    function reset_form(ele){
        //清空表单内容
        $(ele)[0].reset();
        //清空表单样式
        $(ele).find("*").removeClass("has-error has-success");
        //找到表单中的所有的信息提示文本框，将其中的信息清空
        $(ele).find(".help-block").text("");
    }
    //点击新增按钮，弹出模态框
    $("#emp_add_modal_btn").click(function () {
        //清除之前的信息,表单重置
        reset_form("#empAddModal form")
        //$("#empAddModal form")[0].reset();
        //发送ajax请求，查出部门信息，显示在下拉列表中
        getDepts("#empAddModal select");
        //弹出模态框
        $("#empAddModal").modal({
            backdrop:"static"
        });
    });

    //查出部门信息，显示在下拉列表中
    function getDepts(ele) {
        //清空之前下拉列表的值
        $(ele).empty();
        $.ajax({
            url:"${APP_PATH}/department/depts",
            type:"GET",
            success:function (result) {
                console.log(result);
                //dept_add_select
                //显示部门信息在下拉列表中
                //$("#dept_add_select").append("")
                $.each(result.extend.dept, function () {
                    var optionEle = $("<option></option>").append(this.deptName).attr("value", this.deptId);
                    optionEle.appendTo(ele);
                });
            }
        });
    }

    /**
     * 校验表单的数据
     * */
    function validate_add_form(){
        //1. 先拿到校验的数据，使用正则式表达式
        //校验用户名
        var empName = $("#empName_add_input").val();
        var regName = /(^[a-zA-Z][a-zA-Z0-9]{3,15}$)|(^[\u2E80-\u9FFF]{2,5})/;
        if (!regName.test(empName)){
            //alert("用户名可以是2-5位的中文字符或者6-16位英文和数字组合");
            show_validate_msg("#empName_add_input", "error", "用户名可以是2-5位的中文字符或者6-16位英文和数字组合");
            return false;
        }else {
            show_validate_msg("#empName_add_input", "success","");
        }
        //校验邮箱信息
        var email = $("#email_add_input").val();
        var regEmail = /^([a-zA-Z0-9_.-]+)@([a-zA-Z0-9-])+(\.[a-zA-Z0-9-]+)*\.[a-zA-Z0-9]{2,6}$/;
        if (!regEmail.test(email)){
            //alert("请检查邮箱的格式");
            show_validate_msg("#email_add_input", "error", "请检查邮箱的格式");
            return false;
        }else {
            show_validate_msg("#email_add_input", "success", "");
        }
        return true;
    }

    /**
     *输出校验结果的提示信息，在校验表单数据这个方法中使用
     * */
    function show_validate_msg(ele, status, msg){
        //清除当前元素的校验状态
        $(ele).parent().removeClass("has-success has-error");
        $(ele).next("span").text("");
        if ("success" == status){
            $(ele).parent().addClass("has-success");
            $(ele).next("span").text(msg);
        }else if("error" == status) {
            $(ele).parent().addClass("has-error");
            $(ele).next("span").text(msg);
        }
    }
    /*
     * 点击保存按钮，保存信息到数据库
     * */
    $("#emp_save_btn").click(function () {
        //1. 模态框中填写的表单数据提交给服务器进行保存
        //1. 对要提交的数据进行校验
        if(!validate_add_form()){
            return false;
        }
        //1. 判断之前的用户名校验是否成功
        if ($(this).attr("ajax-va")=="error"){
            return false;
        }
        //2. 发送ajax请求保存员工
        $.ajax({
            url:"${APP_PATH}/empcontroller/emp",
            type:"POST",
            data:$("#empAddModal form").serialize(),
            success:function (result) {
                //员工保存成功

                if (result.code == 100){
                    //判断是否保存成功
                    //1. 关闭模态框
                    $("#empAddModal").modal('hide');
                    //2. 来到最后一页，显示保存的数据
                    //发送ajax请求到最后一页
                    to_page(totalRecord);
                }else {
                    //console.log(result);
                    //有哪个字段的错误信息就显示
                    if(undifined!= result.extend.errorFields.email){
                        //显示邮箱错误信息
                        show_validate_msg("#email_add_input", "error", result.extend.errorFields.email);
                    }
                    if (undifined != result.extend.errorFields.empName){
                        //显示员工名字错误信息
                        show_validate_msg("#empName_add_input", "error", result.extend.errorFields.empName);
                    }
                }
            }
        });
    });

    /**
     * 为员工姓名输入框绑定一个事件
     * 发送ajax请求校验用户名是否可用
     * */
    $("#empName_add_input").change(function () {
        //一旦这个框里的内容发生了改变，发送ajax请求查看数据库中是否有相同的内容
        var empName = this.value;
        $.ajax({
            url:"${APP_PATH}/empcontroller/checkuser",
            data:"empName="+empName,
            type: "POST",
            success:function (result) {
                if (result.code == 100){
                    show_validate_msg("#empName_add_input", "success", "用户名可用");
                    $("#emp_save_btn").attr("ajax-va", "success");
                }else {
                    show_validate_msg("#empName_add_input", "error", result.extend.va_msg);
                    $("#emp_save_btn").attr("ajax-va", "fail");
                }
            }
        });
    });

    /**
     * 1. 我们是按钮创建之前就绑定了click
     * 2. 可以在创建按钮的时候绑定
     *     更倾向于绑定点击live()
     * jquery新版没有live，使用on代替
     * */
    $(document).on("click", ".edit_btn", function () {
        //alert("edit");
        //0. 查出员工数据，显示员工信息
        getEmp($(this).attr("edit-id"));
        //1. 查出部门信息，显示员工信息
        getDepts("#empUpdateModal select");
        //把员工id传递给模态框的更新按钮
        $("#emp_update_btn").attr("edit-id", $(this).attr("edit-id"));
        //弹出模态框
        $("#empUpdateModal").modal({
            backdrop:"static"
        });
    });

    //查询员工信息显示在模态框
    function getEmp(id) {
        $.ajax({
            url:"${APP_PATH}/empcontroller/getEmp/"+id,
            type:"GET",
            success:function (result) {
                console.log(result);
                var empData = result.extend.emp;
                console.log(empData.empName);
                $("#empName_update_static").text(empData.empName);
                $("#email_update_input").val(empData.email);
                $("#empUpdateModal input[name=gender]").val([empData.gender]);
                $("empUpdateModal select").val([empData.dId]);
            }
        });
    }

    //点击更新，更新员工信息
    $("#emp_update_btn").click(function () {
        //验证邮箱是否合法
        var email = $("#email_update_input").val();
        var regEmail = /^([a-zA-Z0-9_.-]+)@([a-zA-Z0-9-])+(\.[a-zA-Z0-9-]+)*\.[a-zA-Z0-9]{2,6}$/;
        if (!regEmail.test(email)){
            //alert("请检查邮箱的格式");
            show_validate_msg("#email_update_input", "error", "请检查邮箱的格式");
            return false;
        }else {
            show_validate_msg("#email_update_input", "success", "");
        }
        //发送ajax请求保存更新的员工数据
        $.ajax({
            url:"${APP_PATH}/empcontroller/saveEmp/"+$(this).attr("edit-id"),
            type:"PUT",
            data:$("#empUpdateModal form").serialize(),
            success:function (result) {
                //alert(result);
                //1. 关闭模态框
                $("#empUpdateModal").modal("hide");
                //2. 回到页面
                to_page(currentPage);
            }
        });
    });

    /**
     * 给删除按钮绑定事件
     * */
    $(document).on("click", ".delete_btn", function () {
        //1. 弹出是否确认删除
        var empName = $(this).parents("tr").find("td:eq(1)").text();
        var id = $(this).attr("delete-id");
        if (confirm("确认删除【"+empName+"】吗？")){
            //确认，发送ajax请求
            $.ajax({
                url:"${APP_PATH}/empcontroller/deleteEmp/"+id ,
                type:"DELETE",
                success:function (result) {
                    alert(result.msg);
                    //回到本页
                    to_page(currentPage);
                }
            });
        }
    });

    /**
     * 完成全选全不选
     * */
    $("#check_all").click(function () {
        //用attr获取自定义的属性值
        //用prop获取原生的属性，修改和读取Dom原生数据
        $(".check_item").prop("checked",$(this).prop("checked"));
    });

    /**
     * 为全选绑定事件
     * */
    $(document).on("click", ".check_item",function () {
        //判断当前选中的元素是不是5个
        var flag = $(".check_item:checked").length==$(".check_item").length;
        $("#check_all").prop("checked", flag);
    });

    /**
     * 点击全部删除
     * */
    $("#emp_delete_all_btn").click(function () {
        var empNames = "";
        var del_str = "";
        $.each($(".check_item:checked"), function () {
            empNames += $(this).parents("tr").find("td:eq(2)").text()+",";
            //组装员工id的字符串
            del_str += $(this).parents("tr").find("td:eq(1)").text()+"-";
        });
        //去除empNames中的多的那个逗号，
        empNames = empNames.substring(0, empNames.length - 1);
        del_str = del_str.substring(0, del_str.length - 1);
        if (confirm("确认删除【"+empNames+"】吗？")){
            //发送ajax请求删除
            $.ajax({
                url:"${APP_PATH}/empcontroller/deleteEmp/"+del_str,
                type:"DELETE",
                success:function (result) {
                    alert(result.msg);
                    //回到当前页面
                    to_page(currentPage);
                }
            });
        }
    });
</script>
</body>
</html>
