package spring.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import spring.dao.DepartmentMapper;
import spring.model.Department;

import java.util.List;

/**
 * @author zxf
 * @date 2018/7/25 14:22
 */
@Service
public class DepartmentService {
    @Autowired
    DepartmentMapper departmentMapper;

    public List<Department> getDepts(){
        //查出所有的部门信息
        return departmentMapper.selectByExample(null);
    }
}
