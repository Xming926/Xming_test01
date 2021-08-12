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
import java.io.PrintWriter;
import java.util.List;

@WebServlet("/userServlet")
public class UserServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("utf-8");
        String method = request.getParameter("method");
        if("delete".equals(method)){
            String name = request.getParameter("name");
            UserDao dao = new UserDao();
            boolean b = dao.deteleUser(name);
            response.sendRedirect("userListServlet");
        }else if("modify".equals(method)){
            String name = request.getParameter("name");
            UserDao dao = new UserDao();
            User user = dao.queryUserByName(name);
            request.setAttribute("user", user);
            request.getRequestDispatcher("manager/modifyUserInfo.jsp").forward(request, response);
        }else if("save".equals(method)){
            String name = request.getParameter("name");
            User user = new UserDao().queryUserByName(name);
            user.setUpwd(request.getParameter("pwd"));
            user.setSex("male".equals(request.getParameter("sex")) ? "男" : "女");
            user.setRebuild("true".equals(request.getParameter("rebuild")));
            request.setAttribute("user", user);
            UserDao dao = new UserDao();
            boolean b = dao.modifyUserInfo(user);
            if(b){
                HttpSession session = request.getSession();
                session.setAttribute("modifyError", "false");
                request.getRequestDispatcher("manager/modifyUserInfo.jsp").forward(request, response);
            }else{
                HttpSession session = request.getSession();
                session.setAttribute("modifyError", "true");
                request.getRequestDispatcher("manager/modifyUserInfo.jsp").forward(request, response);
            }
        }else if("query".equals(method)){
            String name = request.getParameter("name");
            UserDao dao = new UserDao();
            List<User> users = dao.queryAllUserByName(name);
            if(users == null || users.size() == 0){
                HttpSession session = request.getSession();
                session.setAttribute("queryError", "true");
            }else{
                HttpSession session = request.getSession();
                session.setAttribute("queryError", "false");
                session.setAttribute("user", users);
            }
            response.sendRedirect("manager/scoreQuery.jsp");
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        this.doPost(request, response);
    }
}
