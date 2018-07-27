package spring.controller;

import com.github.pagehelper.PageInfo;
import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mock.web.MockHttpServletRequest;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.MvcResult;
import org.springframework.test.web.servlet.request.MockHttpServletRequestBuilder;
import org.springframework.test.web.servlet.request.MockMvcRequestBuilders;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;
import org.springframework.web.context.WebApplicationContext;

@RunWith(SpringJUnit4ClassRunner.class)
@WebAppConfiguration
@ContextConfiguration(locations={"classpath:spring/applicationContext.xml","classpath:springmvc/springmvc-servlet.xml"})
public class EmployeeControllerTest {
    //传入springmvc的ioc
    @Autowired
    WebApplicationContext context;
    MockMvc mockMvc;
    //EmployeeController employeeController = new EmployeeController();
    @Before
    public void initMockMvc(){
        mockMvc = MockMvcBuilders.webAppContextSetup(context).build();
    }
    @Test
    public void testPage()throws Exception{
        //模拟拿到请求返回值
        MvcResult result = mockMvc.perform(MockMvcRequestBuilders.get("/emps").param("pn",
                "1")).andReturn();
        //请求成功后，请求域中会有pageInfo：我们可以去除pageInfo进行验证
        MockHttpServletRequest request = result.getRequest();
        PageInfo pi = (PageInfo) request.getAttribute("pageInfo");
        System.out.println("当前页："+pi.getPages());
    }
}
