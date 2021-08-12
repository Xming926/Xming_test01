package com.wbu.Entity;

public class User {
    private int id;
    private String uname;
    private String upwd;
    private String sex;
    private int score1;
    private int score2;
    private boolean rebuild;

    public User(){}
    public User(int id, String uname, String upwd) {
        this.id = id;
        this.uname = uname;
        this.upwd = upwd;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
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

    public String getSex() {
        return sex;
    }

    public void setSex(String sex) {
        this.sex = sex;
    }

    public int getScore1() {
        return score1;
    }

    public void setScore1(int score1) {
        this.score1 = score1;
    }

    public int getScore2() {
        return score2;
    }

    public void setScore2(int score2) {
        this.score2 = score2;
    }

    public boolean isRebuild() {
        return rebuild;
    }

    public void setRebuild(boolean rebuild) {
        this.rebuild = rebuild;
    }

    @Override
    public String toString() {
        return "User{" +
                "id=" + id +
                ", uname='" + uname + '\'' +
                ", upwd='" + upwd + '\'' +
                ", sex='" + sex + '\'' +
                ", score1=" + score1 +
                ", score2=" + score2 +
                ", rebuild=" + rebuild +
                '}';
    }
}
