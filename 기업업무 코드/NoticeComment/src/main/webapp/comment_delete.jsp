<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, javax.sql.*,java.io.*,java.util.*,java.text.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>공지사항/댓글 삭제 완료 페이지</title>
<style>
	table {
		width : 400px;
		height : 400px;
		border : 1px solid black;
		border-collapse : collapse;
		margin-top : 30px;
		margin-left : 50px;
	}
	
	td {
		border : 1px solid black;
	}
</style>
</head>
<body>
<%
	Class.forName("com.mysql.cj.jdbc.Driver");// Mysql의 버전이 8.0이므로 JDBC 이렇게 작성
	Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:33060/kopo10", "root", "kopoctc");
	// localhost : 서버 IP주소, 33060 : 포트번호, kopo10 : DB 이름, root : user, kopoctc : passwd 
	// getConnection 안의 url을 사용해서 DriverManager클래스의 getConnection 메소드를 호출
	Statement stmt = conn.createStatement(); // sql쿼리를 실행하기위한 객체 stmt 생성
	
	request.setCharacterEncoding("utf-8"); // 인코딩 utf-8로 설정
	int id = Integer.parseInt(request.getParameter("id")); // "id"를 parameter로 받는 int형 변수 id 생성
	String title = request.getParameter("title");
	int rootid = Integer.parseInt(request.getParameter("rootid"));
	int relevel = Integer.parseInt(request.getParameter("relevel"));
	int recnt = Integer.parseInt(request.getParameter("recnt"));
	
	if (relevel == 0) {
		String Querytxt = String.format("delete from comment where id=%d", id);
		stmt.execute(Querytxt);
	
		conn.close();
    	stmt.close();
%>
<form method="post" action="comment_list.jsp">
	<table>
		<tr>
			<td style="height : 20%;"><p style="text-align : center;">게시글/댓글 삭제</p></td>
		</tr>
		<tr>
			<td style="text-align : center;">
				<div style="margin-bottom : 10px;"><%=id%>번 <%=title%> 게시글이 삭제되었습니다.</div>
				<input type="submit" value="게시판으로 이동">
			</td>
		</tr>
	</table>
</form>
<%
	} else if (relevel > 0) {
		String Querytxt = String.format("delete from comment where id=%d and rootid=%d and relevel=%d and recnt=%d", id, rootid, relevel, recnt);
		stmt.execute(Querytxt);
		
		conn.close();
    	stmt.close();
	}
	
%>
<form method="post" action="comment_list.jsp">
	<table>
		<tr>
			<td style="height : 20%;"><p style="text-align : center;">게시글/댓글 삭제</p></td>
		</tr>
		<tr>
			<td style="text-align : center;">
				<div style="margin-bottom : 10px;"><%=id%>번 게시글의 댓글이 삭제되었습니다.</div>
				<input type="submit" value="게시판으로 이동">
			</td>
		</tr>
	</table>
</form>
</body>
</html>