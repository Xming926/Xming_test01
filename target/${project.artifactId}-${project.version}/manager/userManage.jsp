<%@ page import="java.util.List" %>
<%@ page import="com.wbu.Entity.User" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>用户管理</title>
    <style>
        * {
            margin: 0;
            padding: 0;
        }
        table {
            margin: 50px auto;
            width: 680px;
            border-collapse: collapse;
            text-align: center;
            font-size: 18px;
        }
        th,td {
            border: 1px solid rgb(51,51,51);
        }
        tr {
            height: 40px;
            background-color: rgb(204,204,204);
        }

        input[type="button"] {
            font-size: 16px;
            height: 30px;
            width: 50px;
        }
        input[type="button"]:hover {
            cursor: pointer;
        }
    </style>
    <script>
        window.onload = function () {
            var two = document.getElementById("two");
            two.style.backgroundColor = "rgb(200, 22, 35)";
            two.style.color = "rgb(241, 241, 241)";

            var modify = document.querySelectorAll(".modify");
            for(var i = 0; i < modify.length; i++){
                modify[i].onclick = function () {
                    var name = this.parentNode.parentNode.childNodes[1].innerText;
                    location.href = "userServlet?method=modify&name="+name;
                }
            }

            var del = document.querySelectorAll(".delete");
            for(var i = 0; i < del.length; i++){
                del[i].onclick = function () {
                    var message = confirm("您确定要删除该用户吗？");
                    if(message){
                        var name = this.parentNode.parentNode.childNodes[1].innerText;
                        location.href = "userServlet?method=delete&name="+name;
                    }
                }
            }
        }
    </script>

</head>
<body>
    <jsp:include page="../managerIndex.jsp"></jsp:include>
    <table>
        <tr><th>id</th><th>用户名</th><th>密码</th><th>性别</th><th>测试分数</th><th>补测分数</th><th>重修</th><th>操作</th></tr>
        <%
            request.setCharacterEncoding("utf-8");
            List<User> userList = (List)request.getAttribute("userList");
            for(User u : userList){
                String score1 = u.getScore1()==-1?"未开始":String.valueOf(u.getScore1());
                String score2 = u.getScore2()==-1?"未开始":String.valueOf(u.getScore2());
                String rebuild = u.isRebuild()?"已报名":"未报名";
                out.print("<tr><td>"+u.getId()+"</td><td>"+u.getUname()+"</td>" +
                        "<td>"+u.getUpwd()+"</td><td>"+u.getSex()+"</td>" +
                        "<td>"+score1+"</td>" +
                        "<td>"+score2+"</td>" +
                        "<td>"+rebuild+"</td>" + "<td>" +
                        "<input type=\"button\" value=\"修改\" class=\"modify\">&emsp;" +
                        "<input type=\"button\" value=\"删除\" class=\"delete\"></td></tr>");
            }
        %>

    </table>
</body>
</html>

