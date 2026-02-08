<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
    <link rel="stylesheet" href="css/regex.css">
    <% System.out.println(pageContext.getRequest().getServletContext().getContextPath()); %>
	<link rel="stylesheet" href="${pageContext.request.servletContext.contextPath}/css/login.css">
    <script src="js/regex.js"></script>
</head>

<body>
    <div id="joinBox">
        <h1>회원 가입</h1>
        <form id="frm" action="11_join_process.jsp" method="post">
            <input type="search" name="uid" id="uid" class="inputCommonStyle errMsg" placeholder="아이디 입력">
            <div id="imgWrap">
                <input type="password" name="upw" id="upw" class="inputCommonStyle errMsg" placeholder="비번 입력">
                <img id="viewEye" class="close" src="img/eyeopen.svg">
            </div>
            <input type="search" name="unm" id="unm" class="inputCommonStyle errMsg" placeholder="이름 입력">
            <input type="tel" name="utel" id="utel" class="inputCommonStyle errMsg" placeholder="연락처 입력">
            <input type="email" name="umail" id="umail" class="inputCommonStyle errMsg" placeholder="이메일 입력">
            <input type="search" name="ubirth" id="ubirth" class="inputCommonStyle errMsg" placeholder="생년월일 입력(예: 20020723)">

            <button type="submit" class="btn_submit">회원 가입</button>
            <button type="button" class="btn_submit"  onclick="location.href='11_session_main.jsp';"> 취소</button>
        </form>
    </div>
    <script>

    </script>
</body>

</html>