<%@ page import="java.util.List" %>
<%@ page import="com.wbu.Entity.User" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>修改用户信息</title>
    <style>
        * {
            margin: 0;
            padding: 0;
        }

        .tab_con {
            font-size: 18px;
        }

        table {
            margin: 50px auto;
            width: 400px;
            border-collapse: collapse;
            text-align: center;
        }

        th, td {
            border: 1px solid rgb(51, 51, 51);
        }

        tr {
            height: 40px;
            background-color: rgb(204, 204, 204);
        }

        input[type="text"] {
            height: 25px;
            width: 200px;
        }

        input[type="radio"] {
            height: 20px;
            width: 20px;
            vertical-align: middle;
        }

        label {
            vertical-align: middle;
        }

        input[type="submit"], input[type="button"] {
            font-size: 18px;
            width: 90px;
        }
    </style>
    <script>
        window.onload = function () {
            var two = document.getElementById("two");
            two.style.backgroundColor = "rgb(200, 22, 35)";
            two.style.color = "rgb(241, 241, 241)";

            var sex = document.getElementById("s");
            if ("男" == sex.innerText) {
                var male = document.getElementById("male");
                male.checked = true;
            }
            if ("女" == sex.innerText) {
                var famale = document.getElementById("female");
                female.checked = true;
            }

            var rebuild = document.getElementById("r");
            if (rebuild.innerText == "true") {
                var yes = document.getElementById("yes");
                yes.checked = true;
            } else {
                var no = document.getElementById("no");
                no.checked = true;
            }

            var yes = document.getElementById("yes");
            yes.onclick = function () {
                var score1 = document.getElementById("score1").innerText;
                var score2 = document.getElementById("score2").innerText;
                var no = document.getElementById("no");
                if (score1 == "未开始" || score2 == "未开始") {
                    alert("该用户还有测试机会，无需报名重修！");
                    no.checked = true;
                    return;
                }

                if (score1 >= 60 || score2 >= 60) {
                    alert("该用户已有测试分数及格记录，无需报名重修！");
                    no.checked = true;

                }


            }

            var back = document.getElementById("button");
            back.onclick = function () {
                location.href = "userListServlet";
            }
        }
    </script>

</head>
<body>
<jsp:include page="../managerIndex.jsp"></jsp:include>
<%
    User user = (User) request.getAttribute("user");
    String name = (user.getUname() == null || user.getUname() == "") ? "" : user.getUname();
    String pwd = (user.getUpwd() == null || user.getUpwd() == "") ? "" : user.getUpwd();
    String sex = (user.getSex() == null || user.getSex() == "") ? "" : user.getSex();
    String score1 = user.getScore1() == -1 ? "未开始" : String.valueOf(user.getScore1());
    String score2 = user.getScore2() == -1 ? "未开始" : String.valueOf(user.getScore2());
%>
<div class="tab_con">
    <form action="userServlet?method=save" method="post">
        <table>
            <thead>
            <th colspan="2">用户信息修改</th>
            </thead>
            <tr>
                <td>用户名</td>
                <td><input type="text" name="name" value="<%=name%>" readonly="readonly"></td>
            </tr>
            <tr>
                <td>密码</td>
                <td><input type="text" name="pwd" value="<%=pwd%>"></td>
            </tr>
            <tr>
                <td>性别</td>
                <td><input type="radio" name="sex" value="male" id="male"><label for="male">男</label>
                    &emsp;&emsp;<input type="radio" name="sex" value="female" id="female"><label for="female">女</label>
                </td>
            </tr>
            <tr>
                <td>测试成绩</td>
                <td><input type="text" name="score1" value="<%=score1%>" readonly="readonly"></td>
            </tr>
            <tr>
                <td>补测成绩</td>
                <td><input type="text" name="score2" value="<%=score2%>" readonly="readonly"></td>
            </tr>
            <tr>
                <td>报名重修</td>
                <td><input type="radio" name="rebuild" value="true" id="yes"><label for="yes">是</label>&emsp;&emsp;
                    <input type="radio" name="rebuild" value="false" id="no"><label for="no">否</label></td>
            </tr>
            <tr>
                <td colspan="2"><input type="submit" value="确认修改">
                    &emsp;&emsp;<input type="button" value="返回" id="button"></td>
            </tr>
        </table>
    </form>
    <%
        String modifyError = (String) session.getAttribute("modifyError");
        session.removeAttribute("modifyError");
        if ("true".equals(modifyError)) {
            out.print("<h4 style=\"text-align: center;color: red\">修改失败！</h4>");
        }
        if ("false".equals(modifyError)) {
            out.print("<h4 style=\"text-align: center;color: red\">修改成功！</h4>");
        }
    %>

</div>
<div id="s" style="display: none"><%=user.getSex()%>
</div>
<div id="r" style="display: none"><%=user.isRebuild()%>
</div>
<div id="score1" style="display: none"><%=user.getScore1()%>
</div>
<div id="score2" style="display: none"><%=user.getScore2()%>
</div>
</body>
</html>

