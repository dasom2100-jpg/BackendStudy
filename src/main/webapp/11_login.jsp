<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>Implicit Objects</title>
<link rel="stylesheet" href="${pageContext.request.servletContext.contextPath}/css/login.css">
</head>

<body>
    <div id="Login_main">
        <h1>로그인</h1>
        <form action="11_login_process.jsp" method="post">
            <input type="text" name="uid" placeholder="아이디 입력">
            <input type="text" name="upw" placeholder="비번 입력">
            <input type="submit" value="전송">
        </form>
    </div>
</body>
</html>
