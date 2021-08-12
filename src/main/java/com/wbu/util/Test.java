package com.wbu.util;

import com.wbu.Dao.QuestionDao;
import com.wbu.Dao.UserDao;
import com.wbu.Entity.Question;
import com.wbu.Entity.User;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class Test {
    public static void main(String[] args) throws SQLException {
        selectQuestions();
    }

    private static void updateScore() {
        UserDao dao = new UserDao();
        boolean mj = dao.updateScore("mj", 3);
        System.out.println(mj);
    }

    private static void addUser() {
        UserDao dao = new UserDao();
        User user = new User();
        user.setUname("fs");
        user.setUpwd("123");
        user.setSex("男");
        dao.addUser(user);
    }

    private static void queryQ(){
        QuestionDao qd = new QuestionDao();
        List<Question> list = qd.selectQuestion();
        for(Question q : list){
            System.out.println(q.toString());
            System.out.println();
        }
    }

    private static void queryAll(){
        UserDao dao = new UserDao();
        List<User> users = dao.queryAllUser();
        for(User u : users){
            System.out.println(u.toString());
        }
    }

    private static void selectQuestions(){
        QuestionDao dao = new QuestionDao();
        List<Question> questions = dao.selectQuestion();
        for(Question q : questions){
            System.out.println(q.toString());
        }
    }
}
