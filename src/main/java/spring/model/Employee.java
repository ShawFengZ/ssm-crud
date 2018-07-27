package spring.model;

import javax.validation.constraints.Pattern;

public class Employee {
    private Integer empId;

    @Pattern(regexp = "(^[a-zA-Z][a-zA-Z0-9]{3,15}$)|(^[\\u2E80-\\u9FFF]{2,5})",
    message = "用户名可以是2-5位的中文字符或者3-15位英文和数字组合")
    private String empName;

    private String gender;

    @Pattern(regexp = "^([a-zA-Z0-9_.-]+)@([a-zA-Z0-9-])+(\\.[a-zA-Z0-9-]+)*\\.[a-zA-Z0-9]{2,6}$",
    message = "请检查邮箱的格式")
    private String email;

    private Integer dId;

    private Department department;

    //如果有有参构造器一定要写一个无参构造器
    public Employee(){
        super();
    }

    public Employee(Integer empId, String empName, String gender, String email, Integer dId) {
        super();
        this.empId = empId;
        this.empName = empName;
        this.gender = gender;
        this.email = email;
        this.dId = dId;
    }



    //查询员工的时候部门信息也是带上的
    public Department getDepartment() {
        return department;
    }

    public void setDepartment(Department department) {
        this.department = department;
    }

    public Integer getEmpId() {
        return empId;
    }

    public void setEmpId(Integer empId) {
        this.empId = empId;
    }

    public String getEmpName() {
        return empName;
    }

    public void setEmpName(String empName) {
        this.empName = empName == null ? null : empName.trim();
    }

    public String getGender() {
        return gender;
    }

    public void setGender(String gender) {
        this.gender = gender == null ? null : gender.trim();
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email == null ? null : email.trim();
    }

    public Integer getdId() {
        return dId;
    }

    public void setdId(Integer dId) {
        this.dId = dId;
    }
}