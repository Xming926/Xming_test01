<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>登录</title>
    <style>
        form {
            margin: 100px auto;
            font-size: 20px;
            width: 400px;
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
        span {
            font-size: 16px;
        }
        .right {
            text-align: center;
        }
        #checkcode {
            width: 82px;
        }
        #change {
            font-size: 14px;
        }
        img {
            width: 80px;
            height: 40px;
        }
    </style>
    <script>
        window.onload = function () {
            var img = document.getElementsByTagName("img")[0];
            var change = document.getElementById("change");
            img.onclick = function () {
                var date = new Date();
                img.src = "checkCodeServlet?time="+date;
            }
            change.onclick = function () {
                var date = new Date();
                img.src = "checkCodeServlet?time="+date;
            }

            var btn = document.getElementById("btn");
            btn.onclick = function () {
                var checkcode = document.getElementById("checkcode");
                if(checkcode.value == ""){
                    alert("请输入验证码！");
                }else{
                    btn.type = "submit";
                }
            }

            var clean = document.getElementById("clean");
            clean.onclick = function(){
                var name = document.getElementById("name");
                var password = document.getElementById("password");
                name.value = "";
                password.value = "";
            }

            var reg = document.getElementById("reg");
            reg.onclick = function () {
                location.href = "user/regist.jsp";
            }
        }
    </script>
</head>
<body>
<%
    application.setAttribute("login", "false");
    session.setAttribute("loginPage","true");
    session.removeAttribute("importantInfo");
    if(session.getAttribute("name") == null){
        session.setAttribute("name","");
    }
    if(session.getAttribute("password") == null){
        session.setAttribute("password","");
    }

%>
<form action="loginServlet" method="post">
    <table>
        <tr><th colspan="2">在线测试系统</th></tr>
        <tr><td><label for="name">姓名：</label></td>
            <td class="right"><input type="text" name="name" value="<%=(String)session.getAttribute("name")%>" id="name"></td>
        </tr>
        <tr><td><label for="password">密码：</label></td>
            <td class="right"><input type="password" name="password" value="<%=(String)session.getAttribute("password")%>" id="password"></td>
        </tr>
        <tr><td><label for="checkcode">验证码：</label></td>
            <td class="right"><input type="text" name="checkcode" id="checkcode">
                <img src="checkCodeServlet"><br><a id="change" href="javascript:void(0);">看不清换一张</a></td>
        </tr>
        <tr>
            <td colspan="2" class="right"><input type="radio" value="Manager" name="type" id="Manager"><span>管理员登录</span>
                <input type="radio" value="normal" name="type" checked><span>普通用户登录</span>
            </td>
        </tr>
        <tr><td colspan="2" class="right">
            <input type="button" value="开始测试" id="btn">
            <input type="button" value="重写" id="clean">
            <input type="button" value="用户注册" id="reg">
        </td></tr>
    </table>
</form>
</body>
</html>

