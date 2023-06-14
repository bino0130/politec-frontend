<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.*,java.sql.*, javax.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>intro.jsp</title>
</head>
<body>
<h1><center>Twice Database 실습 1</center><a></a></h1> <!-- h1 태그 사용 -->
<%
	Class.forName("com.mysql.cj.jdbc.Driver");// Mysql의 버전이 8.0이므로 JDBC 이렇게 작성
	Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:33060/kopo10","root","kopoctc");
	// localhost : 서버 IP주소, 33060 : 포트번호, kopo10 : DB 이름, root : user, kopoctc : passwd 
	// getConnection 안의 url을 사용해서 DriverManager클래스의 getConnection 메소드를 호출
	Statement stmt = conn.createStatement(); // sql쿼리를 실행하기위한 객체 stmt 생성
	
	String Querytxt1 = "select * from countTable";
	int cnt = 0;
	ResultSet rset1 = stmt.executeQuery(Querytxt1);
	while(rset1.next()) {
		cnt = rset1.getInt(1);
	}
	
	cnt++;
	
	out.println("현재 페이지 방문자 수 : " + cnt + "명 입니다");
	
	String Querytxt2 = String.format("insert into countTable value (%d)", cnt);
	stmt.execute(Querytxt2);
%>
</body>
</html>