package com.wbu.Services;

import com.wbu.Dao.UserDao;
import com.wbu.Entity.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/registServlet")
public class RegistServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("utf-8");
        String name = request.getParameter("name");
        String password = request.getParameter("password");
        String sex = request.getParameter("sex");
        User user = new User();
        user.setUname(name);
        user.setUpwd(password);
        user.setSex("1".equals(sex)?"男":"女");

        UserDao dao = new UserDao();
        boolean b = dao.addUser(user);
        if (b){
            HttpSession session = request.getSession();
            session.setAttribute("name", name);
            session.setAttribute("password", password);
            response.sendRedirect("success.jsp");
        }else{
            response.sendRedirect("error.jsp");
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        this.doPost(request, response);
    }
}
