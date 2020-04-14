package com.ssm.controller;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.ssm.bean.Employee;
import com.ssm.bean.Msg;
import com.ssm.service.EmployeeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
public class EmployeeController {

    @Autowired
    EmployeeService employeeService;

    @ResponseBody
    @RequestMapping(value = "/emp/{ids}",method = RequestMethod.DELETE)
    public Msg deleteEmp(@PathVariable("ids")String ids){
        if (ids.contains("-")) {
            List<Integer> del_ids = new ArrayList<>();
            String[] split = ids.split("-");
            for (String string:split) {
                int i = Integer.parseInt(string);
                del_ids.add(i);
            }
            employeeService.deleteBatch(del_ids);
        }
        else{
            employeeService.deleteEmp(Integer.parseInt(ids));
        }
        return Msg.success();
    }

    @ResponseBody
    @RequestMapping(value = "/emp/{empId}",method = RequestMethod.PUT)
    public Msg saveEmp(Employee employee){
        employeeService.updateEmp(employee);
        return Msg.success();
    }
    @RequestMapping(value = "/emp/{id}",method = RequestMethod.GET)
    @ResponseBody
    public Msg getEmp(@PathVariable("id") Integer id){
        Employee e =   employeeService.getEmp(id);
        System.out.println(e.toString());
        return Msg.success().add("emp",e);
    }


    @ResponseBody
    @RequestMapping(value = "/emp",method = RequestMethod.POST)
    public Msg saveEmp(@Valid Employee e, BindingResult result){
        if(result.hasErrors()){
            Map<String,Object> map = new HashMap<>();
            List<FieldError> fieldErrors = result.getFieldErrors();
            for(FieldError fieldError:fieldErrors){
                map.put(fieldError.getField(),fieldError.getDefaultMessage());
            }
            return Msg.fail().add("errorFileds",map);
        }else {
            employeeService.saveEmp(e);
            return Msg.success();
        }
    }

    @ResponseBody
    @RequestMapping("/empswithjson")
    public Msg getEmpsByJson(@RequestParam(value = "pn",defaultValue = "1")Integer pn){
        PageHelper.startPage(pn,5);
        List<Employee> emps = employeeService.getAll();
        PageInfo pageInfo = new PageInfo(emps,5);
        return Msg.success().add("pageInfo",pageInfo);
    }
    @RequestMapping("/emps")
    public String getEmps(@RequestParam(value = "pn",defaultValue = "1")Integer pn,
        Model model){
        PageHelper.startPage(pn,5);
        List<Employee> emps = employeeService.getAll();
        PageInfo pageInfo = new PageInfo(emps,5);
        model.addAttribute("pageInfo",pageInfo);
        return "list";
    }

    @ResponseBody
    @RequestMapping("/checkuser")
    public Msg checkUserName(@RequestParam("empName") String userName){
        System.out.println("username:"+userName);
        String reg = "(^[a-zA-Z0-9_-]{4,16}$)|(^[\\u2E80-\\u9FFF]{2,5})";
        if(!userName.matches(reg)){
            return Msg.fail().add("va_msg","用户名必须是6-16位数字和字母组合");
        }
       return employeeService.checkUserName(userName)?Msg.success():Msg.fail().add("va_msg","用户名不可用");
    }

}
