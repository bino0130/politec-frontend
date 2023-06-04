<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import = "java.sql.*, javax.sql.*,java.io.*" %>
<html>
<head>
</head>
<body>
<h1>트와이스 테이블만들기 OK</h1>
<%
	try {
		Class.forName("com.mysql.cj.jdbc.Driver");// Mysql의 버전이 8.0이므로 JDBC 이렇게 작성
		Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/kopo10","root","kopoctc");
		// localhost : 서버 IP주소, 3306 : 포트번호, kopo10 : DB 이름, root : user, kopoctc : passwd 
		// getConnection 안의 url을 사용해서 DriverManager클래스의 getConnection 메소드를 호출
		Statement stmt = conn.createStatement(); // sql쿼리를 실행하기위한 객체 stmt 생성
		stmt.execute("create table anotherTwice ("+ 
				"name varchar(20)," +
				"studentid int primary key,"+
				"kor int," +
				"eng int," +
				"mat int) default charset=utf8;"); // 괄호 안의 쿼리문 실행
				stmt.close(); // 리소스 정리
				conn.close(); // 리소스 정리
	} catch (ClassNotFoundException | SQLException e) {
		e.printStackTrace();
	}
%>
</body>
</html>