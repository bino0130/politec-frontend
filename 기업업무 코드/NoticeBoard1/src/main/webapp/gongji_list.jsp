<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, javax.sql.*,java.io.*,java.util.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>공지사항 리스트 페이지</title>
<style>
table {
	width: 600px;
	border: 1px solid black;
	border-collapse: collapse;
}

td {
	border: 1px solid black;
}

.one {
	width: 10%;
	text-align: center;
}

.seven {
	width: 70%;
}

.two {
	width: 20%;
	text-align: center;
}
</style>
</head>
<body>
	<%
	try{
	Class.forName("com.mysql.cj.jdbc.Driver");// Mysql의 버전이 8.0이므로 JDBC 이렇게 작성
	Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:33060/kopo10", "root", "kopoctc");
	// localhost : 서버 IP주소, 33060 : 포트번호, kopo10 : DB 이름, root : user, kopoctc : passwd 
	// getConnection 안의 url을 사용해서 DriverManager클래스의 getConnection 메소드를 호출
	Statement stmt = conn.createStatement(); // sql쿼리를 실행하기위한 객체 stmt 생성

	ResultSet rset = stmt.executeQuery("select id, title, date from gongji");
	%>
	<form method="post">
		<table>
			<tr>
				<td class="one">번호</td>
				<td class="seven" style="text-align: center;">제목</td>
				<td class="two">등록일</td>
			</tr>

			<%
			int id = 0;
			String title = "";
			String date = "";
			while (rset.next()) {
				id = rset.getInt(1);
				title = rset.getString(2);
				date = rset.getString(3);
			%>
			<tr>
				<td class="one"><%=id%></td>
				<td class="seven"><a href='gongji_view.jsp?key=<%=id%>'><%=title%></a></td>
				<td class="two"><%=date%></td>
			</tr>
			<%
			}
			conn.close();
		    stmt.close();
			%>
		</table>
		<table style="border:0px">
			<tr><td style="border:0px; text-align:right;"><input type="submit" value='신규' formaction="gongji_insert.jsp"></td></tr>
		</table>
	</form>
	<%
	} catch (SQLSyntaxErrorException e) {
	%>
	<form method="post" action="gongji_createTable.jsp">
		<div style="width:300px; text-align:center;">테이블이 존재하지 않습니다.</div>
		<div style="width:300px; text-align:center;"><input type="submit" name="" value="테이블 생성하기"></div>
	</form>
	<%
	}
	 %>
</body>
</html>