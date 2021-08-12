<%@ page import="java.util.List" %>
<%@ page import="com.wbu.Entity.Question" %>
<%@ page import="java.util.ArrayList" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>答题测试</title>
    <style>
        h2 {
            margin: 100px auto 10px auto;
            text-align: center;
        }
        span {
            color: blue;
        }
        form {
            margin: 100px auto;
            padding-top: 10px;
            padding-left: 30px;
            width: 700px;
            font-size: 22px;
            background-color: rgb(149,207,208);
        }
        div {
            margin-bottom: 20px;
        }
        input {
            display: inline-block;
            margin-bottom: 20px;
        }
    </style>
    <script>
        window.onload = function () {
            var exit = document.getElementById("exit");
            exit.onclick = function () {
                location.href = "login.jsp";
            }

            var flag = 0;
            var btn = document.getElementById("btn");
            btn.onclick = function () {
                var single = document.querySelectorAll(".single");
                for(var i = 0; i < single.length; i++){
                    var flagradio = 0;
                    var radio = single[i].getElementsByTagName("input");
                    for(var j = 0; j < radio.length; j++){
                        if(radio[j].checked){
                           flagradio = 1;
                           break;
                        }
                    }
                    if(flagradio == 0){
                        flag = 1;
                        break;
                    }
                }

                var double = document.querySelectorAll(".double");
                for(var i = 0; i < double.length; i++){
                    var flagbox = 0;
                    var checkbox = double[i].getElementsByTagName("input");
                    for(var j = 0; j < checkbox.length; j++){
                        if(checkbox[j].checked){
                           flagbox = 1;
                           break;
                        }
                    }
                    if(flagbox == 0){
                        flag = 1;
                        break;
                    }
                }

                if(flag == 1){
                    alert("您还没有做完呢！");
                    flag = 0;
                }else{
                    btn.type = "submit";
                }
            }
        }
    </script>
</head>
<body>
<%
    List<Question> questions = (List)request.getAttribute("questions");
    ArrayList<Question> dan = new ArrayList<Question>();
    ArrayList<Question> shuang = new ArrayList<Question>();
    for(Question q : questions){
        if("1".equals(q.getType())){
            dan.add(q);
        }
        if("2".equals(q.getType())){
            shuang.add(q);
        }
    }
%>
<form action="questionsServlet?method=correct" method="post">
    <div><%= (String)session.getAttribute("name") %>，欢迎您！</div>
    <%
        String importantInfo = (String)session.getAttribute("importantInfo");
        if(importantInfo != null && !"".equals(importantInfo)){
            out.print("<h4 style=\"text-align: center;color:red;\">"+importantInfo+"</h4>");
        }
    %>
    <div>进入在线测试系统，请遵守规则。</div>
    <div>一、单项选择题（10 *6）</div>
    <%
        out.print("");
        int c1 = 1;
        for(Question d : dan){
            out.print("<div class=\"single\">"+ c1++ + "." + d.getQuestion() + "：<br>");
            if(d.getA() != null && d.getA() != ""){
                out.print("&emsp;A&nbsp;<input type=\"radio\" name="+ d.getId() + " value=\"A\">&nbsp;"+ d.getA());
            }
            if(d.getB() != null && d.getB() != ""){
                out.print("<br/>&emsp;B&nbsp;<input type=\"radio\" name="+ d.getId() +" value=\"B\">&nbsp;"+ d.getB());
            }
            if(d.getC() != null && d.getC() != ""){
                out.print("<br/>&emsp;C&nbsp;<input type=\"radio\" name="+ d.getId() +" value=\"C\">&nbsp;"+ d.getC());
            }
            if(d.getD() != null && d.getD() != ""){
                out.print("<br/>&emsp;D&nbsp;<input type=\"radio\" name="+ d.getId() +" value=\"D\">&nbsp;"+ d.getD());
            }
            out.print("</div>");
        }
    %>
    <div>二、多选题（20 * 2）</div>
    <%
        int c2 = 1;
        for(Question s : shuang){
            out.print("<div class=\"double\">" + c2++ + "." + s.getQuestion() +"：<br>");
            if(s.getA() != null && s.getA() != ""){
                out.print("&emsp;A&nbsp;<input type=\"checkbox\" name="+ s.getId() +" value=\"A\">&nbsp;"+ s.getA());
            }
            if(s.getB() != null && s.getB() != ""){
                out.print("<br/>&emsp;B&nbsp;<input type=\"checkbox\" name="+ s.getId() +" value=\"B\">&nbsp;"+ s.getB());
            }
            if(s.getC() != null && s.getC() != ""){
                out.print("<br/>&emsp;C&nbsp;<input type=\"checkbox\" name="+ s.getId() +" value=\"C\">&nbsp;"+ s.getC());
            }
            if(s.getD() != null && s.getD() != ""){
                out.print("<br/>&emsp;D&nbsp;<input type=\"checkbox\" name="+ s.getId() +" value=\"D\">&nbsp;"+ s.getD());
            }
            out.print("</div>");
        }
    %>
    <input type="button" value="提交" id="btn" style="font-size: 20px;margin-right: 40px">
    <input type="reset" value="重做" style="font-size: 20px;margin-right: 40px">
    <input type="button" value="退出" id="exit" style="font-size: 20px">
</form>

</body>
</html>

