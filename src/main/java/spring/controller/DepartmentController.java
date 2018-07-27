package spring.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import spring.model.Department;
import spring.model.Msg;
import spring.service.DepartmentService;

import java.util.List;

/**
 * @author zxf
 * @date 2018/7/25 14:21
 */
@RequestMapping("department")
@Controller
public class DepartmentController {

    @Autowired
    DepartmentService departmentService;

    /**
     * 返回所有的部门信息
     * */
    @ResponseBody
    @RequestMapping("depts")
    public Msg getDepts(){
        List<Department> list = departmentService.getDepts();
        return Msg.success().add("dept", list);
    }
}
