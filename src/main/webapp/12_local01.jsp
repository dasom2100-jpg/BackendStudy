<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.text.NumberFormat"%>
<%@page import="java.text.DateFormat"%>
<%@page import="java.util.*"%>
<!DOCTYPE html>
<html>
<head>
<title>Internationalization</title>
</head>
<body>

    <h3>현재 지역의 언어, 날짜, 통화</h3>

    <%
	Locale locale = request.getLocale();
	Date currentDate = new Date();
	DateFormat dateFormat = DateFormat.getDateInstance(DateFormat.FULL, locale);
	DateFormat dateFormat = DateFormat.getDateInstance(DateFormat.SHORT, locale);
	NumberFormat numberFormat = NumberFormat.getNumberInstance(locale);
	//locale 매개변수가 없어도 동일하게 처리된다. 동일하게 Locale설정.
	DateFormat dateFormat1 = DateFormat.getDateInstance(DateFormat.FULL);
	NumberFormat numberFormat1 = NumberFormat.getNumberInstance();
	%>
	
	<p>언어 : <%=locale.getDisplayLanguage()%></p>
	<p>날짜 : <%=dateFormat.format(currentDate)%></p>
	<p>날짜1 : <%=dateFormat1.format(currentDate)%></p>
	<p>숫자 (12345.67) : <%=numberFormat.format(12345.67)%></p>
	<p>숫자1 (12345.67) : <%=numberFormat1.format(12345.67)%></p>


</body>
</html>