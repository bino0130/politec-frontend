<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.*,java.sql.*, javax.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
	.blue1 {
		width : 600px;
	}
	
	#up {
		width : 700px;
		height : 350px;
		border : 1px solid green;
	}
</style>
</head>
<body>
<%
	Class.forName("com.mysql.cj.jdbc.Driver");// Mysql의 버전이 8.0이므로 JDBC 이렇게 작성
	Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:33060/kopo10","root","kopoctc");
	// localhost : 서버 IP주소, 33060 : 포트번호, kopo10 : DB 이름, root : user, kopoctc : passwd 
	// getConnection 안의 url을 사용해서 DriverManager클래스의 getConnection 메소드를 호출
	Statement stmt = conn.createStatement(); // sql쿼리를 실행하기위한 객체 stmt 생성
	
%>
<div id=up>
	<table class="blue1">
		<tr>
			<td style="text-align:center;">후보등록</td>
			<td style="text-align:center;">투표</td>
			<td style="text-align:center;";>개표결과</td>
		</tr>
	</table>
</div>
</body>
</html>