package com.wbu.Dao;

import com.wbu.Entity.User;
import com.wbu.util.DBUtil;

import java.sql.ResultSet;
import java.sql.SQLException;

public class ReBuildDao {
    //添加重修信息
    public boolean addReBuild(User user){
        boolean b = this.queryReBuild(user);
        if(!b){
            DBUtil db = new DBUtil();
            db.getConnection();
            String sql = "insert into rebuild values(?,?,?,?)";
            int i = db.executeUpdate(sql, new String[]{String.valueOf(user.getId()), user.getUname(),
                    String.valueOf(user.getScore1()), String.valueOf(user.getScore2())});
            return i > 0;
        }
        return true;
    }

    //查看用户是否已报名重修
    public boolean queryReBuild(User user){
        DBUtil db = new DBUtil();
        db.getConnection();
        String sql = "select * from rebuild where uname = ?";
        ResultSet rs = db.executeQuery(sql, new String[]{user.getUname()});
        try {
            if(rs.next()){
                return true;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            db.closeAll();
        }
        return false;
    }

    public boolean deleteReBuild(User user){
        DBUtil db = new DBUtil();
        db.getConnection();
        String sql = "delete from rebuild where uname = ?";
        int i = db.executeUpdate(sql, new String[]{user.getUname()});
        db.closeAll();
        return i > 0;
    }
}
