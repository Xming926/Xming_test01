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
        .countdown {
            margin: 10px auto;
            text-align: center;
        }
        span {
            color: blue;
        }
    </style>
    <script>
        window.onload = function () {
            var count = 2;

            function fun() {
                if (count < 1) {
                    location.href = "login.jsp";
                }
                var time = document.getElementById("cc");
                time.innerText = count;
                count--;
            }
            setInterval(fun, 1000);
        }
    </script>
</head>
<body>
    <h2>恭喜您，注册成功！</h2>
    <div class="countdown"><span id="cc">3</span>&nbsp;秒后返回。。。</div>
</body>
</html>

