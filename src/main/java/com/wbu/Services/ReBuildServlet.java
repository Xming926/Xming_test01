package com.wbu.Services;

import com.wbu.Dao.ReBuildDao;
import com.wbu.Dao.UserDao;
import com.wbu.Entity.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/reBuildServlet")
public class ReBuildServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        String name = (String)session.getAttribute("name");
        if(name == null || "".equals(name)){
            response.sendRedirect("user/result.jsp");
            return;
        }
        UserDao dao = new UserDao();
        User user = dao.queryUserByName(name);
        if(user.getScore1() == -1 || user.getScore2() == -1){
            String info = "您还有一次测试机会，无需报名重修";
            session.setAttribute("rebuildInfo", info);
            response.sendRedirect("user/result.jsp");
            return;
        }
        if(user.getScore1() >= 60 || user.getScore2() >= 60){
            String info = "您已有测试分数及格的记录，无需报名重修";
            session.setAttribute("rebuildInfo", info);
            response.sendRedirect("user/result.jsp");
            return;
        }

        ReBuildDao rdb = new ReBuildDao();
        boolean rebuild = rdb.queryReBuild(user);
        if(rebuild){
            String info = "你已成功报名重修，无需重复报名";
            session.setAttribute("rebuildInfo", info);
            response.sendRedirect("user/result.jsp");
            return;
        }

        if(user.getScore1() <60 && user.getScore2() < 60){
            ReBuildDao dao2 = new ReBuildDao();
            boolean b = dao2.addReBuild(user);
            if(b){
                String info = "报名重修成功，请按时参加测试";
                session.setAttribute("rebuildInfo", info);
                response.sendRedirect("user/result.jsp");
            }else {
                String info = "报名重修失败，请稍后再试";
                session.setAttribute("rebuildInfo", info);
                response.sendRedirect("user/result.jsp");
            }
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        this.doPost(request, response);
    }
}
