package com.wbu.Services;

import com.wbu.Dao.QuestionDao;
import com.wbu.Dao.UserDao;
import com.wbu.Entity.Question;
import com.wbu.Entity.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

@WebServlet("/questionsServlet")
public class QuestionsServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("utf-8");
        String method = request.getParameter("method");
        QuestionDao qd = new QuestionDao();

        if("test".equals(method)){
            HttpSession session = request.getSession();
            List<Question> list;
            if(session.getAttribute("testQuestion") == null){
                list = qd.selectQuestion();
                session.setAttribute("testQuestion", list);
            }else{
                list = (List)session.getAttribute("testQuestion");
            }
            UserDao d = new UserDao();
            User user = d.queryUserByName((String)session.getAttribute("name"));
            if(user.getScore1() != -1 && user.getScore2() != -1){
                String info = "您已没有答题机会！\n您可以继续答题，但将无法记录成绩！";
                session.setAttribute("importantInfo", info);
            }
            request.setAttribute("questions", list);
            request.getRequestDispatcher("user/userTest.jsp").forward(request, response);
        }else if("add".equals(method)){
            String timu = request.getParameter("timu");
            String a = request.getParameter("A");
            String b = request.getParameter("B");
            String c = request.getParameter("C");
            String d = request.getParameter("D");
            String answer = request.getParameter("answer");
            String type = request.getParameter("type");
            Question q = new Question();
            q.setQuestion(timu);
            q.setA(a);
            q.setB(b);
            if(c != null && c != ""){
                q.setC(c);
            }
            if(d != null && d != ""){
                q.setD(d);
            }
            q.setAnswer(answer);
            q.setType(type);

            boolean b1 = qd.addQuestion(q);
            HttpSession session = request.getSession();
            if(b1){
                session.setAttribute("addError", "false");
            }else{
                session.setAttribute("addError", "true");
            }
            response.sendRedirect("manager/addQuestion.jsp");
        }else if("correct".equals(method)){
            int score = 0;
            HttpSession session = request.getSession();
            List<Question> questions = (List)session.getAttribute("testQuestion");
            for(Question q : questions){
                if("1".equals(q.getType())){
                    String submit = request.getParameter(q.getId() + "");
                    if(submit.equalsIgnoreCase(q.getAnswer())){
                        score += 10;
                    }
                }
                if("2".equals(q.getType())){
                    int c = 0;
                    String answer = q.getAnswer();
                    String[] submit = request.getParameterValues(q.getId() + "");
                    for(String s : submit){
                        if(answer.toLowerCase().contains(s.toLowerCase())){
                            c++;
                        }
                    }
                    if(c == answer.length()){
                        score += 20;
                    }
                }
            }
            String name = (String)session.getAttribute("name");
            UserDao userDao = new UserDao();
            userDao.updateScore(name, score);
            session.setAttribute("score", score);
            response.sendRedirect("user/result.jsp");
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        this.doPost(request, response);
    }
}
