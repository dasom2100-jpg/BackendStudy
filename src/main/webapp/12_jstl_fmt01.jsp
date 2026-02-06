<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Internationalization</title>
</head>
<body>
<!-- 
EL에서 받을 수 있는 객체 종류:
1. jsp:useBean태그로 만든 객체
2. 4개의 기본 속성객체에서 만든 객체들
pageContext.setAttribute("속성명", "속성값") => ${속성명}
request.setAttribute("속성명", "속성값")=> ${속성명}
session.setAttribute("속성명", "속성값")=> ${속성명}
application.setAttribute("속성명", "속성값")=> ${속성명}

*******
jsp선언태그, 실행태그에서 new선언하여 만든 객체는 가져올 수 없다.-- param객체로 때온다
*******
 -->
	<p><jsp:useBean id="now" class="java.util.Date"/></p>
	
	<p>date: <fmt:formatDate value="${now}" type="date" /></p>
	<p>time: <fmt:formatDate value="${now}" type="time"/></p>
    <p>both: <fmt:formatDate value="${now}" type="both" /></p>

    <p>default: 
        <fmt:formatDate value="${now}" type="both" 
            dateStyle="default" timeStyle="default" />
    </p>

    <p>short: 
        <fmt:formatDate value="${now}" type="both" 
            dateStyle="short" timeStyle="short" />
    </p>

    <p>medium: 
        <fmt:formatDate value="${now}" type="both" 
            dateStyle="medium" timeStyle="medium" />
    </p>

    <p>long: 
        <fmt:formatDate value="${now}" type="both" 
            dateStyle="long" timeStyle="long" />
    </p>

    <p>full: 
        <fmt:formatDate value="${now}" type="both" 
            dateStyle="full" timeStyle="full" />
    </p>

    <p>pattern:
        <fmt:formatDate value="${now}" type="both" 
            pattern="yyyy년 MM월 dd일 HH시 mm분 ss초 E요일" />
    </p>
	
	
</body>
</html>