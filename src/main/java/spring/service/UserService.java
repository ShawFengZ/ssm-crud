package spring.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import spring.dao.UserMapper;
import spring.model.Employee;
import spring.model.EmployeeExample;
import spring.model.Msg;

import java.util.List;

@Service
public class UserService {
    @Autowired
    private UserMapper userMapper;
    /**
     * 查询所有员工
     * */
    public List<Employee> getAll(){
        return userMapper.selectByExampleWithDept(null);
    }

    /**
     * 保存员工数据
     * */
    public void saveEmp(Employee employee){
        userMapper.insertSelective(employee);
    }

    /**
     * 检查员工名是否可用
     *      true: 当前姓名可用
     * */
    public Boolean checkUser(String name){
        //构造查询条件
        EmployeeExample example = new EmployeeExample();
        EmployeeExample.Criteria criteria = example.createCriteria();
        criteria.andEmpNameEqualTo(name);
        long count = userMapper.countByExample(example);
        if (count!=0){
            return false;
        }
        return true;
    }

    /**
     * 根据id查询员工信息
     * */
    public Employee getEmp(Integer id){
        return userMapper.selectByPrimaryKey(id);
    }

    /**
     * 更新员工
     * */
    public void updateEmp(Employee employee){
        userMapper.updateByPrimaryKeySelective(employee);
    }

    /**
     * 单个删除的方法
     * */
    public void deleteEmp(Integer id){
        userMapper.deleteByPrimaryKey(id);
    }
}
