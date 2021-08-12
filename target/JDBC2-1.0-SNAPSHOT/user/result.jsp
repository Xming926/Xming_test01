<%@ page import="java.util.ArrayList" %>
<%@ page import="com.wbu.Dao.UserDao" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>成绩单</title>
    <style>
        div {
            margin: 100px auto 50px auto;
            padding-top: 10px;
            font-size: 22px;
            width: 450px;
            text-align: center;
            background-color: rgb(142,202,215);
        }
        span {
            color: red;
        }
        button {
            font-size: 16px;
            margin-right: 20px;
            margin-bottom: 20px;
        }
    </style>
    <script>
        window.onload = function () {
            var back = document.getElementById("back");
            back.onclick = function () {
                location.href = "../login.jsp";
            }
            var again = document.getElementById("again");
            again.onclick = function () {
                location.href = "../questionsServlet?method=test";
            }

            var rebuild = document.getElementById("rebuild");
            rebuild.onclick = function () {
                location.href = "../reBuildServlet";
            }
        }
    </script>
</head>
<body>

<div>
    <h4>您已经完成了测试，分数：<span><%= session.getAttribute("score") %></span> 分</h4>
    <button id="back">返回首页</button>
    <button id="again">再做一次</button>
    <button id="rebuild">报名重修</button>
</div>
<%
    String rebuildInfo = (String)session.getAttribute("rebuildInfo");
    session.removeAttribute("rebuildInfo");
    if(rebuildInfo != null && !"".equals(rebuildInfo)){
        out.print("<h4 style=\"text-align: center;color:red;\">"+rebuildInfo+"</h4>");
    }
%>
</body>
</html>

