<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<!DOCTYPE html>
<html>
<head>
<title>core태그</title>
</head>
<body>
	<h2>c:set태그 - 변수의 값을 설정(setAttriubte 와 동일한 역할을 한다.)</h2>
	<c:set var="num" value="50" />
	num값은 : ${num}
	<br><hr>

	<h2>c:out태그 - 변수의 값을 출력</h2>
	<c:out value="${num}" default="0" /> ,
	<c:out value="작성자" default="Admin" /> ,
	<c:out value="hello world!!!!!!!" />
	<br><hr>

	<h2>c:forEach태그 - 반복문 수행</h2>
	범위안에서 반복문을 수행한다. for와 동일한 역할을 한다.<br> 
	begin : 초기 값, end : 마지막 값 , step : 증감값<br><br>
	
	
	<c:out value="수식: resNum = {(i+num-2)%7}" /><br>
	
	<c:forEach var="i" begin="1" end="10" step="1">
		<c:set var="resNum" value="${(i+num-2)%7}"></c:set>
		<c:out value="num: ${num}" />
		<c:out value="i: ${i}" />
		<c:out value="resNum: ${resNum}" />
		<br>
	</c:forEach><hr>
	

	<h2>c:if태그 - 조건문 수행</h2>
	조건문을 수행한다. if와 동일한 역할을 한다.<br>
	<%@ page import="java.util.ArrayList,com.dto.MemberBean" %>
	<%
	ArrayList<MemberBean> memberList = new ArrayList<MemberBean>();
	MemberBean mem1 = new MemberBean();
	mem1.setId(1);
	mem1.setName("홍길순");
	memberList.add(mem1);

	MemberBean mem2 = new MemberBean();
	mem2.setId(1);
	mem2.setName("둘리");
	memberList.add(mem2);	
	request.setAttribute("memberList", memberList);
	
	%>
	<%
	ArrayList<MemberBean> mlist = (ArrayList<MemberBean>) request.getAttribute("memberList");
	for(MemberBean mem  : mlist){
		out.print("<p>아이디 : %s<br>이름: %s<br></p><hr>".formatted(mem.getId(), mem.getName()));
	}	
	%>
	<c:forEach items="${memberList}" var="mem">
		<p>
		아이디 : ${mem.id} <br>
		이름 : ${mem.name}<br>
		</p><hr>
	</c:forEach>
	
	
	<jsp:useBean id="memberBean" class="com.dto.MemberBean" />
<%-- 	<% memberBean.getName() %> --%>
	<c:if test="${memberBean.name eq '이루마'}">
		<p>이름은 ${memberBean.name}입니다.</p>
	</c:if>
	<hr>


	<h2>c:choose / c:when태그 - 조건문 수행</h2>
	if, else 구문 역할을 한다.<br>
	<c:choose>
		<c:when test="${memberBean.name eq '고길동'}">
			<p>이름은 ${memberBean.name}입니다.</p>
		</c:when>
		<c:when test="${memberBean.name eq '홍길순'}">
			<p>이름은 ${memberBean.name}입니다.</p>
		</c:when>
		<c:otherwise>
			<p>이름은 ${memberBean.name}입니다.</p>
		</c:otherwise>
	</c:choose>
</body>
</html>
