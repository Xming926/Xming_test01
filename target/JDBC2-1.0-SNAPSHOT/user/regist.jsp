<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>用户注册</title>
    <style>
        form {
            margin: 100px auto;
            font-size: 20px;
            width: 300px;
            background-color: rgb(199,237,228);
        }
        table {
            border: 1px solid black;
        }
        th {
            text-align: center;
            background-color: rgb(176,230,255);
        }
        td {
            border: 1px transparent;
            width: 200px;
            text-align: right;
            background-color: rgb(102,204,255);
        }
        .right {
            text-align: center;
        }
    </style>
    <script>
        window.onload = function () {
            var back = document.getElementById("back");
            back.onclick = function () {
                location.href = "../login.jsp";
            }

            var btn = document.getElementById("btn");
            btn.onclick = function () {
                var name = document.getElementById("name");
                var password = document.getElementById("password");
                if(name.value == "" || password.value == ""){
                    alert("请填写姓名和密码！");
                }else{
                    btn.type = "submit";
                }

            }
        }
    </script>
</head>
<body>
<form action="../registServlet" method="post">
    <table>
        <tr><th colspan="2">用户注册</th></tr>
        <tr>
            <td><label for="name">姓名：</label></td>
            <td class="right"><input type="text" name="name" id="name"></td>
        </tr>
        <tr>
            <td><label for="password">密码：</label></td>
            <td class="right"><input type="password" name="password" id="password"></td>
        </tr>
        <tr>
            <td>性别：</td>
            <td class="right"><input type="radio" name="sex" value="1" checked>男&nbsp;&nbsp;
                <input type="radio" name="sex" value="0">女
            </td>
        </tr>

        <tr><td colspan="2" class="right">
            <input type="button" value="提交" id="btn">
            <input type="reset" value="重写">
            <input type="button" value="返回" id="back">
        </td></tr>
    </table>
</form>
</body>
</html>

