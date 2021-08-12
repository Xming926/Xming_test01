package com.wbu.Dao;

import com.wbu.Entity.User;
import com.wbu.util.DBUtil;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class UserDao {
    //登录验证
    public boolean identify(String name, String password, String type){
        boolean flag = false;
        String sql = "";
        if("Manager".equals(type)){
            sql = "select * from Manager where mname = ? and mpwd = ?";
        }else{
            sql = "select * from user where uname = ? and upwd = ?";
        }
        DBUtil db = new DBUtil();
        db.getConnection();
        ResultSet rs = db.executeQuery(sql, new String[]{name, password});
        try {
            flag = rs.next();
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            db.closeAll();
        }
        return flag;
    }

    //添加用户信息
    public boolean addUser(User user) {
        boolean has = this.hasUser(user.getUname());
        DBUtil db = new DBUtil();
        db.getConnection();
        if(has){
            return false;
        }else{
            String sql = "insert into user values(null,?,?,?,-1,-1)";
            int result = db.executeUpdate(sql, new String[]{user.getUname(), user.getUpwd(), user.getSex()});
            return result != 0;
        }
    }

    //判断用户是否存在
    public boolean hasUser(String uname){
        DBUtil db = new DBUtil();
        db.getConnection();
        try {
            String sql = "select * from user where uname = ?";
            ResultSet rs = db.executeQuery(sql, new String[]{uname});
            return rs.next();
        } catch (SQLException e) {
            e.printStackTrace();
        }finally {
            db.closeAll();
        }
        return false;
    }

    //更新用户成绩
    public boolean updateScore(String uname, int score){
        DBUtil db = new DBUtil();
        db.getConnection();
        User user = this.queryUserByName(uname);
        String sql;
        if(user.getScore1() == -1){
            sql = "update user set score1 = ? where uname = ? ";
        }else{
            if(user.getScore2() == -1){
                sql = "update user set score2 = ? where uname = ? ";
            }else{
                return true;
            }
        }

        DBUtil db2 = new DBUtil();
        db2.getConnection();
        int result = db2.executeUpdate(sql, new String[]{score + "", uname});
        return result != 0;
    }

    //查询所有用户信息
    public List<User> queryAllUser(){
        DBUtil db = new DBUtil();
        db.getConnection();
        String sql = "select * from user";
        List<User> list = new ArrayList<>();
        try {
            ResultSet rs = db.executeQuery(sql, null);
            int count = 0;
            ReBuildDao rdb = new ReBuildDao();
            while (rs.next()){
                count++;
                User user = new User();
                user.setId(count);
                user.setUname(rs.getString("uname"));
                user.setUpwd(rs.getString("upwd"));
                user.setSex(rs.getString("usex"));
                user.setScore1(rs.getInt("score1"));
                user.setScore2(rs.getInt("score2"));
                user.setRebuild(rdb.queryReBuild(user));
                list.add(user);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            db.closeAll();
        }
        return list;
    }

    //删除用户信息
    public boolean deteleUser(String name){
        DBUtil db = new DBUtil();
        db.getConnection();
        String sql = "delete from user where uname =?";
        int b = db.executeUpdate(sql, new String[]{name});
        db.closeAll();
        return b > 0;
    }

    //根据用户名查询用户信息
    public User queryUserByName(String name){
        DBUtil db = new DBUtil();
        db.getConnection();
        String sql = "select * from user where uname = ? ";
        User user = new User();
        try {
            ResultSet rs = db.executeQuery(sql, new String[]{name});
            ReBuildDao rdb = new ReBuildDao();
            if(rs.next()){
                user.setId(rs.getInt("id"));
                user.setUname(rs.getString("uname"));
                user.setUpwd(rs.getString("upwd"));
                user.setSex(rs.getString("usex"));
                user.setScore1(rs.getInt("score1"));
                user.setScore2(rs.getInt("score2"));
                user.setRebuild(rdb.queryReBuild(user));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }finally {
            db.closeAll();
        }
        return user;
    }

    //根据用户名查询用户信息(模糊查询)
    public List<User> queryAllUserByName(String name){
        DBUtil db = new DBUtil();
        db.getConnection();
        String sql = "select * from user where uname like concat('%',?,'%')";
        List<User> list = new ArrayList<>();
        try {
            ResultSet rs = db.executeQuery(sql,new String[]{name});
            while(rs.next()){
                User user = new User();
                user.setUname(rs.getString("uname"));
                user.setUpwd(rs.getString("upwd"));
                user.setSex(rs.getString("usex"));
                user.setScore1(rs.getInt("score1"));
                user.setScore2(rs.getInt("score2"));
                list.add(user);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }finally {
            db.closeAll();
        }
        return list;
    }

    //修改用户信息
    public boolean modifyUserInfo(User user){
        DBUtil db = new DBUtil();
        db.getConnection();
        String sql = "update user set upwd = ?, usex = ? where uname = ?";
        int b = db.executeUpdate(sql, new String[]{user.getUpwd(), user.getSex(), user.getUname()});

        ReBuildDao rdb = new ReBuildDao();
        if(rdb.queryReBuild(user)){
            if(!user.isRebuild()){
                rdb.deleteReBuild(user);
            }
        }else{
            if(user.isRebuild()){
                rdb.addReBuild(user);
            }
        }
        db.closeAll();
        return b > 0;
    }
}
