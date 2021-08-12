package com.wbu.Services;

import com.wbu.Dao.UserDao;
import com.wbu.Entity.User;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;

@WebServlet("/loginServlet")
public class LoginServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("utf-8");

        HttpSession session = request.getSession();
        String loginPage = (String) session.getAttribute("loginPage");
        ServletContext application = this.getServletContext();
        String page="";
        if(!"true".equals(loginPage)){
            if("true".equals(application.getAttribute("login"))){
                session.setAttribute("error","overdue");
                page = "error.jsp";
//                response.sendRedirect("error.jsp");
            }else{
                session.setAttribute("error","loginPage");
                page = "error.jsp";
//                response.sendRedirect("error.jsp");
            }
        }else{
            String checkcode = request.getParameter("checkcode");
            String checkCode_session = (String) session.getAttribute("checkCode_session");
            session.removeAttribute("checkCode_session");
            if(checkCode_session == null || !checkCode_session.equalsIgnoreCase(checkcode)){
                session.setAttribute("error","checkcode");
                page = "error.jsp";
//                response.sendRedirect("error.jsp");
            }else{
                String type = request.getParameter("type");
                String name="", password="";
                if("true".equals("true".equals(application.getAttribute("login")))){
                    name = (String)session.getAttribute("name");
                    password = (String)session.getAttribute("password");
                }else{
                    name = request.getParameter("name").trim();
                    password = request.getParameter("password").trim();
                }
                if(name == "" || password == ""){
                    session.setAttribute("name", "");
                    session.setAttribute("password", "");
                    session.setAttribute("error", "null");
                    page = "error.jsp";
//                    response.sendRedirect("error.jsp");
                }else{
                    if("Manager".equals(type)){
                        UserDao dao = new UserDao();
                        boolean login = dao.identify(name, password, "Manager");
                        if(login){
                            session.setAttribute("name", name);
                            page = "managerIndex.jsp";
    //                        response.sendRedirect("managerIndex.jsp");
                        }else{
                            session.setAttribute("error", "login");
                            page = "error.jsp";
    //                        response.sendRedirect("error.jsp");
                        }
                    }else{
                        UserDao dao = new UserDao();
                        boolean login = dao.identify(name, password, "user");
                        if(login){
                            session.setAttribute("name", name);
                            session.setAttribute("password", password);
                            application.setAttribute("login", true);
    //                        session.setMaxInactiveInterval(60 * 10);
                            UserDao d = new UserDao();
                            User user = d.queryUserByName(name);
                            if(user.getScore1() != -1 && user.getScore2() != -1){
                                String info = "您已没有答题机会！\n您可以继续答题，但将无法记录成绩！";
                                session.setAttribute("importantInfo", info);
                            }
                            page = "questionsServlet?method=test";
//                            response.sendRedirect("questionsServlet?method=test");
                        }else {
                            if (dao.hasUser(name)) {
                                session.setAttribute("name", "");
                                session.setAttribute("password", "");
                                session.setAttribute("error", "login");
                                page = "error.jsp";
                                //                            response.sendRedirect("error.jsp");
                            } else {
                                session.setAttribute("error", "exist");
                                page = "error.jsp";
                                //                            response.sendRedirect("error.jsp");
                            }
                        }
                    }
                }
            }
        }
        response.sendRedirect(page);
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        this.doPost(request, response);
    }
}
