<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>管理员页面</title>
    <style>
        * {
            margin: 0;
            padding: 0;
        }

        h1 {
            margin: 50px auto;
            text-align: center;
        }

        .tab {
            width: 900px;
            margin: 50px auto;
        }

        li {
            display: block;
            float: left;
            list-style: none;
            height: 60px;
            width: 225px;
            font-size: 18px;
            text-align: center;
            line-height: 60px;
            background-color: rgb(241, 241, 241);
            cursor: pointer;
        }

        .tab_list {
            height: 60px;
        }

        a {
            text-decoration: none;
            color: black;
            display: block;
        }

        li:hover {
            background-color: rgb(204,204,204);
        }

    </style>

</head>
<body>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()
            + "://" + request.getServerName()
            + ":"
            + request.getServerPort()
            + path
            + "/";
%>
    <% String name = (String)session.getAttribute("name"); %>
    <h1>管理员：<%=name%>，欢迎您！</h1>
    <div class="tab">
        <div class="tab_list">
            <ul>
                <li id="one"><a href= "<%=basePath%>manager/addQuestion.jsp">添加试题</a></li>
                <li id="two"><a href="<%=basePath%>userListServlet">用户管理</a></li>
                <li id="three"><a href="<%=basePath%>manager/scoreQuery.jsp">成绩查询</a></li>
                <li id="four"><a href="<%=basePath%>login.jsp">退出登录</a></li>
            </ul>
        </div>
    </div>
</body>
</html>

