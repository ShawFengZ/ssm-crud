package spring.controller;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.*;
import spring.model.Employee;
import spring.model.Msg;
import spring.service.UserService;

import javax.validation.Valid;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@RequestMapping("empcontroller")
@Controller
public class EmployeeController {

    @Autowired
    UserService userService;

    /**
     * 导入jackson包，@Responsebody才能使用，将返回的数据转为json数据类型
     *      , method = RequestMethod.GET
     * */
    @RequestMapping(value = "/emps", method = RequestMethod.GET)
    @ResponseBody
    public Msg getEmpWithJson(@RequestParam(value="pn", defaultValue="1")Integer pn,
                                     Model model){
        //这不是一个分页操作
        //引入PageHelper，pn是传入的页码
        PageHelper.startPage(pn,5);
        //startPage后紧跟的就是一个分页查询
        List<Employee> employees = userService.getAll();
        //使用pageInfo包装查询后的结果，只需要将查到的数据交给页面即可
        PageInfo page = new PageInfo(employees, 5);
        //pageInfo.put("pageInfo",page);
        return Msg.success().add("pageInfo", page);
    }

    /**
     * 保存数据到数据库
     *      , method = RequestMethod.POST
     * */
    @ResponseBody
    @RequestMapping(value = "/emp", method = RequestMethod.POST)
    public Msg saveEmp(@Valid Employee employee, BindingResult result){
        if (result.hasErrors()){
            Map<String, Object> map = new HashMap<String, Object>();
            //校验失败，应该返回失败，在模态框中显示校验失败的错误信息
            List<FieldError> list = result.getFieldErrors();
            for (FieldError fieldError: list){
                System.out.println("错误的字段名："+fieldError.getField());
                System.out.println("错误信息："+fieldError.getDefaultMessage());
                map.put(fieldError.getField(), fieldError.getDefaultMessage());
            }
            return Msg.fail().add("errorFields", map);
        }
        userService.saveEmp(employee);
        return Msg.success();
    }

    /**
     * 校验用户名是否可用
     * */
    @ResponseBody
    @RequestMapping("checkuser")
    public Msg checkUser(@RequestParam("empName")String empName){
        //先判断用户名是否是合法的格式
        String regx="(^[a-zA-Z][a-zA-Z0-9]{3,15}$)|(^[\\u2E80-\\u9FFF]{2,5})";
        if (!empName.matches(regx)){
            return Msg.fail().add("va_msg", "用户名可以是2-5位的中文字符或者6-16位英文和数字组合");
        }
        //数据库用户名重复校验
        Boolean useable = userService.checkUser(empName);
        if (useable){
            return Msg.success();
        }else {
            return Msg.fail().add("va_msg", "用户名不可用");
        }
    }

    /**
     * 查询员工数据
     * */
    @ResponseBody
    @RequestMapping(value = "/getEmp/{id}", method = RequestMethod.GET)
    public Msg getEmp(@PathVariable("id") Integer id){
        Employee employee = userService.getEmp(id);
        return Msg.success().add("emp", employee);
    }

    /**
     * AJAX的请求不能直接发
     *      这是Tomcat的问题
     *      Tomcat看到是PUT就不会封装请求体中的数据为map,只有post请求才进行封装
     *      我们要能直接支持发送PUT之类请求还要封装请求体中的数据
     *      配置上HttpPutFormContentFilter;
     *          它的作用：将请求体中的数据解析包装成一个map, request被重新包装，就可以封装成功了。
     *员工更新的方法
     * */
    @ResponseBody
    @RequestMapping(value = "/saveEmp/{empId}", method = RequestMethod.PUT)
    public Msg saveEmp(Employee employee){
        userService.updateEmp(employee);
        return Msg.success();
    }

    /**
     * 单个删除的方法
     *      单个批量二合一
     *      批量删除1-2-3
     *      单个删除1
     * */
    @ResponseBody
    @RequestMapping(value = "/deleteEmp/{ids}", method = RequestMethod.DELETE)
    public Msg deleteEmp(@PathVariable("ids") String ids){
        if (ids.contains("-")){
            //批量删除
            String[] str_ids = ids.split("-");
            for (String id: str_ids){
                Integer idt = Integer.parseInt(id);
                userService.deleteEmp(idt);
            }
        }else {
            //单个删除
            Integer id = Integer.parseInt(ids);
            userService.deleteEmp(id);
        }

        return Msg.success();
    }
    /**
     * 查询员工列表，分页查询
     * */
    /*@RequestMapping("/emps")
    public String getEmps(@RequestParam(value="pn", defaultValue="1")Integer pn,
                          Model model){
        //这不是一个分页操作
        //引入PageHelper，pn是传入的页码
        PageHelper.startPage(pn,5);
        //startPage后紧跟的就是一个分页查询
        List<Employee> users = userService.getAll();
        //使用pageInfo包装查询后的结果，只需要将查到的数据交给页面即可
        PageInfo page = new PageInfo(users, 5);
        //pageInfo中封装了详细的分页信息，包括我们查出来的数据
        model.addAttribute("pageInfo", page);
        return "list";
    }*/


}