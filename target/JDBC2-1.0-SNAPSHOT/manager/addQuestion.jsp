    <%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>添加试题</title>
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
            width: 600px;
            border-collapse: collapse;
            text-align: center;
        }
        td {
            border: 1px solid rgb(51,51,51);
        }
        tr {
            height: 40px;
            background-color: rgb(204,204,204);
        }
        input[type="text"] {
            height: 25px;
            width: 400px;
        }

        input[type="radio"] {
            height: 20px;
            width: 20px;
            vertical-align: middle;
        }
        label {
            vertical-align: middle;
        }
        input[type="button"], input[type="reset"] {
            font-size: 18px;
            width: 70px;
        }
    </style>
    <script>
        window.onload = function () {
            var one = document.getElementById("one");
            one.style.backgroundColor = "rgb(200, 22, 35)";
            one.style.color = "rgb(241, 241, 241)";

            var reset = document.getElementById("reset");
            reset.onclick = function () {
                var h = document.getElementsByTagName("h4")[0];
                h.style.display = "none";
            }

            var answer = document.getElementById("answer");
            answer.onblur = function () {
                var a = answer.value;
                if(a.length == 1){
                    document.getElementById("d").checked = "true";
                }
                if(a.length > 1){
                    document.getElementById("s").checked = "true";
                }
            }

            var add = document.getElementById("add");
            add.onclick = function () {
                var timu = document.getElementById("timu");
                if (timu.value == "" || timu.value == null) {
                    alert("请输入题目！");
                    return;
                }

                var items = document.getElementsByClassName("item");
                var count = 0;
                for (var i = 0; i < items.length; i++) {
                    if (items[i].value == "" || items[i].value == null) {
                        count++;
                    }
                }
                if (count > 2) {
                    alert("请输入至少两个选择");
                    return;
                }

                var a = answer.value.toLowerCase();
                if (a.length == 0) {
                    alert("请输入答案！");
                    return;
                }

                for (var i = 0; i < a.length; i++) {
                    if (!(a[i] == 'a' || a[i] == 'b' || a[i] == 'c' || a[i] == 'd')) {
                        alert("答案中包含非法选择！");
                        return;
                    }
                }
                this.type = "submit";
            }
        }
    </script>
</head>
<body>
    <jsp:include page="../managerIndex.jsp"></jsp:include>
    <div class="tab_con">
            <form action="../questionsServlet?method=add" method="post">
                <table>
                    <tr><td>题目</td><td><input type="text" name="timu" id="timu"></td></tr>
                    <tr><td>选项A</td><td><input type="text" name="A" class="item"></td></tr>
                    <tr><td>选项B</td><td><input type="text" name="B" class="item"></td></tr>
                    <tr><td>选项C</td><td><input type="text" name="C" class="item"></td></tr>
                    <tr><td>选项D</td><td><input type="text" name="D" class="item"></td></tr>
                    <tr><td>答案</td><td><input type="text" name="answer" id="answer"></td></tr>
                    <tr><td>类型</td><td><input type="radio" name="type" value="1" id="d" onclick="return false;"><label for="d">单选题</label>
                        &emsp;&emsp;<input type="radio" name="type" value="2" id="s" onclick="return false;"><label for="s">多选题</label></td></tr>
                    <tr><td colspan="2"><input type="button" value="添加" id="add">
                        &emsp;&emsp;<input type="reset" value="重写" id="reset"></td></tr>
                </table>
                <%
                    String addError = (String)session.getAttribute("addError");
                    if("true".equals(addError)){
                        out.print("<h4 style=\"color: red;text-align: center\">添加失败！</h4>");
                    }
                    if("false".equals(addError)){
                        out.print("<h4 style=\"color: red;text-align: center\">添加成功！</h4>");
                    }
                    session.removeAttribute("addError");
                %>
            </form>
    </div>
</div>

</body>
</html>

