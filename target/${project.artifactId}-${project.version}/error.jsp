<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Title</title>
    <style>
        h2 {
            margin: 100px auto 10px auto;
            text-align: center;
        }
        .countdown, .countdown2 {
            margin: 10px auto;
            text-align: center;
        }
        span {
            color: blue;
        }
        div {
            margin-bottom: 20px;
        }
    </style>
    <script>
        window.onload = function () {
            var countdown = document.getElementsByClassName("countdown")[0];
            if(countdown != undefined){
                var count = 2;
                function fun(){
                    if(count < 1){
                        location.href = "login.jsp";
                    }
                    var time = document.getElementById("cc");
                    time.innerText = count;
                    count--;
                }
                setInterval(fun,1000);
            }

            var countdown2 = document.getElementsByClassName("countdown2")[0];
            if(countdown2 != undefined){
                var count = 2;
                function fun(){
                    if(count < 1){
                        location.href = "user/regist.jsp";
                    }
                    var time = document.getElementById("cc");
                    time.innerText = count;
                    count--;
                }
                setInterval(fun,1000);
            }
        }
    </script>
</head>
<body>
<%
    String error = (String) session.getAttribute("error");
    session.removeAttribute("error");
    if("loginPage".equals(error)){
        out.print("<h2>您还没有登录呢！</h2>");
        out.print("<div class=\"countdown\"><span id=\"cc\">3</span>&nbsp;秒后返回。。。</div>");
    }else if("overdue".equals(error)){
        out.print("<h2>您的身份已过期，请重新登录！</h2>");
        out.print("<div class=\"countdown\"><span id=\"cc\">3</span>&nbsp;秒后返回。。。</div>");
    }else if("checkcode".equals(error)){
        out.print("<h2>验证码错误，请输入正确的验证码！</h2>");
        out.print("<div class=\"countdown\"><span id=\"cc\">3</span>&nbsp;秒后返回。。。</div>");
    }else if("null".equals(error)){
        out.print("<h2>用户名或密码为空！</h2>");
        out.print("<div class=\"countdown\"><span id=\"cc\">3</span>&nbsp;秒后返回。。。</div>");
    }else if("login".equals(error)){
        out.print("<h2>用户名或密码错误！</h2>");
        out.print("<div class=\"countdown\"><span id=\"cc\">3</span>&nbsp;秒后返回。。。</div>");
    }else if("exist".equals(error)){
        out.print("<h2>用户名不存在，请注册后重试！</h2>");
        out.print("<div class=\"countdown2\"><span id=\"cc\">3</span>&nbsp;秒后返回。。。</div>");
    }
%>
</body>
</html>

