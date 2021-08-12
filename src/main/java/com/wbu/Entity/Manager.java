package com.wbu.Entity;

public class Manager {
    private int id;
    private String uname;
    private String upwd;
    private String sex;

    public Manager() {
    }

    public Manager(String uname, String upwd) {
        this.uname = uname;
        this.upwd = upwd;
    }

    public String getUname() {
        return uname;
    }

    public void setUname(String uname) {
        this.uname = uname;
    }

    public String getUpwd() {
        return upwd;
    }

    public void setUpwd(String upwd) {
        this.upwd = upwd;
    }
}
