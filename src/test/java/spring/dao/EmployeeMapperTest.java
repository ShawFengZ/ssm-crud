package spring.dao;

import org.apache.ibatis.session.SqlSession;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import spring.model.Employee;

import java.util.UUID;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"classpath:/spring/applicationContext.xml"})
public class EmployeeMapperTest {

    @Autowired
    UserMapper userMapper;

    @Autowired
    SqlSession sqlSession;


    @Test
    public void insertSelective() {
        userMapper.insertSelective(new Employee(null, "Jerry", "M", "Jerry@atguigu.com", 1));
    }

    @Test
    public void insertSelectiveBatch(){
        UserMapper user = sqlSession.getMapper(UserMapper.class);
        for (int i=0; i<1000; i++){
            String uid = UUID.randomUUID().toString().substring(0, 5) + i;
            user.insertSelective(new Employee(null,uid,"M", uid+"@atguigu.com", 1));
        }
        System.out.println("批量完成");
    }
}