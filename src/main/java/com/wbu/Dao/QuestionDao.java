package com.wbu.Dao;

import com.wbu.Entity.Question;
import com.wbu.util.DBUtil;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Random;

public class QuestionDao {
    //随机选取6道单选题和2道多选题
    public List<Question> selectQuestion(){
        DBUtil db = new DBUtil();
        db.getConnection();
        String sql = "select * from questions";
        ResultSet rs = db.executeQuery(sql, null);
        ArrayList<Question> questions = new ArrayList<Question>();
        ArrayList<Question> danxuan = new ArrayList<Question>();
        ArrayList<Question> duoxuan = new ArrayList<Question>();
        try {
            while (rs.next()){
                Question question = new Question();
                question.setId(rs.getInt("id"));
                question.setQuestion(rs.getString("question"));
                question.setA(rs.getString("select1"));
                question.setB(rs.getString("select2"));
                question.setC(rs.getString("select3"));
                question.setD(rs.getString("select4"));
                question.setAnswer(rs.getString("answer"));
                question.setType(rs.getString("type"));
                if("1".equals(rs.getString("type"))){
                    danxuan.add(question);
                }
                if("2".equals(rs.getString("type"))){
                    duoxuan.add(question);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            db.closeAll();
        }
        Random random = new Random();
        for(int i = 0; i < 6; i++){
            int index = random.nextInt(danxuan.size());
            questions.add(danxuan.get(index));
            danxuan.remove(index);
        }
        for(int i = 0; i < 2; i++){
            int index = random.nextInt(duoxuan.size());
            questions.add(duoxuan.get(index));
            duoxuan.remove(index);
        }
        return questions;
    }

    //添加试题
    public boolean addQuestion(Question q){
        DBUtil db = new DBUtil();
        db.getConnection();
        String sql = "insert into questions values(null, ?, ?, ?, ?, ?, ?, ?)";
        String[] param = {q.getQuestion(), q.getA(), q.getB(), q.getC(), q.getD(), q.getAnswer(), q.getType()};
        int i = db.executeUpdate(sql, param);
        return i != 0;
    }
}
