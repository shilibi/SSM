package com.ssm.test;

import com.ssm.bean.Department;
import com.ssm.bean.Employee;
import com.ssm.dao.DepartmentMapper;
import com.ssm.dao.EmployeeMapper;
import org.apache.ibatis.session.SqlSession;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import java.util.UUID;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"classpath:applicationContext.xml"})
public class MapperTest {

    @Autowired
    DepartmentMapper departmentMapper;
    @Autowired
    EmployeeMapper employeeMapper;

    @Autowired
    SqlSession sqlSession;
    @Test
    public void  testCRUD(){
       // departmentMapper.insertSelective(new Department(null,"后勤"));
     //   employeeMapper.insertSelective(new Employee(null,"Tom","M","Tom@163.com",3));
        EmployeeMapper mapper = sqlSession.getMapper(EmployeeMapper.class);
        for(int i = 0;i < 100;i++){
            String substring = UUID.randomUUID().toString().substring(0, 5);
            employeeMapper.insertSelective(new Employee(null, substring,"M",substring+"@163.com",3));
        }
    }
}
