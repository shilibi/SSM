package com.ssm.bean;

import java.util.HashMap;
import java.util.Map;

public class Msg {
    //状态码：100-成功，200-失败
    private int code;

    //提示信息
    private String msg;
    //用户要返回给浏览器的数据
    private Map<String,Object> extend = new HashMap<String ,Object>();

    public static Msg success(){
        Msg results = new Msg();
        results.setCode(100);
        results.setMsg("处理成功！");
        return results;
    }
    public static Msg fail(){
        Msg results = new Msg();
        results.setCode(200);
        results.setMsg("处理失败！");
        return results;
    }

    /*
    链式操作添加元素
     */
    public Msg add(String key,Object value){
        this.getExtend().put(key,value);
        return this;
    }
    public int getCode() {
        return code;
    }

    public void setCode(int code) {
        this.code = code;
    }

    public String getMsg() {
        return msg;
    }

    public void setMsg(String msg) {
        this.msg = msg;
    }

    public Map<String, Object> getExtend() {
        return extend;
    }

    public void setExtend(Map<String, Object> extend) {
        this.extend = extend;
    }
}