<%@ page import="com.wbu.Entity.User" %>
<%@ page import="java.util.List" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>成绩查询</title>
    <style>
        * {
            margin: 0;
            padding: 0;
        }

        table {
            margin: 30px auto;
            width: 400px;
            border-collapse: collapse;
            text-align: center;
        }

        th, td {
            border: 1px solid rgb(51,51,51);
        }

        tr {
            height: 40px;
            background-color: rgb(204,204,204);
        }

        input[type="text"] {
            height: 25px;
            width: 120px;
        }

        input[type="button"] {
            height: 28px;
            width: 50px;
            vertical-align: middle;
        }

        input[type="button"]:hover {
            cursor: pointer;
        }
        
        div{
            max-resolution: 50px auto;
            font-size: 18px;
            text-align: center;
        }

    </style>
    <script>
        window.onload = function () {
            var three = document.getElementById("three");
            three.style.backgroundColor = "rgb(200, 22, 35)";
            three.style.color = "rgb(241, 241, 241)";

            var query = document.getElementById("query");
            query.onclick = function () {
                var name = document.getElementById("name").value;
                if(name == ""){
                    alert("请输入用户名！")
                }else{
                    var path = document.getElementById("path").innerText;
                    location.href = path+"userServlet?method=query&name="+name;
                }
            }
        }
    </script>
</head>
<body>
<%  String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName()
            + ":" + request.getServerPort() + path + "/";%>
    <div style="display: none" id="path"><%=basePath%></div>
    <jsp:include page="../managerIndex.jsp"></jsp:include>
    <div><span>用户名：</span><input type="text" name="name" id="name">&emsp;
        <input type="button" value="查询" id="query"></div>
    <%
        String queryError = (String)session.getAttribute("queryError");
        session.removeAttribute("queryError");
        if("true".equals(queryError)){
            out.print("<h4 style=\"text-align: center;color: red;margin-top: 20px\">该用户不存在！</h4>");
        }
        if("false".equals(queryError)){
            List<User> users = (List)session.getAttribute("user");
            out.print("<table><thead><th>用户名</th><th>测试分数</th><th>补测分数</th></thead>");
            for(User user : users){
                String score1 = user.getScore1()==-1?"未开始":String.valueOf(user.getScore1());
                String score2 = user.getScore2()==-1?"未开始":String.valueOf(user.getScore2());
                out.print("<tr><td>" + user.getUname() + "</td><td>" +
                        score1 + "</td><td>" + score2 + "</td></tr>");
            }
            out.print("</table>");
        }
    %>
</body>
</html>

