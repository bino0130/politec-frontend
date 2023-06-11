<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, javax.sql.*,java.io.*,java.util.*,java.text.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>공지사항 댓글 작성 실행 페이지</title>
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
	int commentId = Integer.parseInt(request.getParameter("commentId"));
	String commentTitle = request.getParameter("commentTitle");
	String commentDate = request.getParameter("commentDate");
	String commentContent = request.getParameter("commentContent");
	int belongId = Integer.parseInt(request.getParameter("belongId"));
	int commentRelevel = Integer.parseInt(request.getParameter("commentRelevel"));
	int commentRecnt = Integer.parseInt(request.getParameter("commentRecnt"));
	
	String hypen = "";
	for (int i = 0; i <= commentRecnt; i++) {
		if (i > 0) {
			hypen = hypen + "-";
		}
	}
	commentTitle = hypen + ">[Re]" + commentTitle; 
	out.println(commentTitle);
	
	/*String Querytxt = String.format("insert into comment (title, date, content, rootid, relevel, recnt) value"
			+ "'%s', '%s', '%s', %d, %d, %d", commentTitle, commentDate, commentContent, belongId, commentRelevel, commentRecnt);
	stmt.executeQuery(Querytxt);*/
%>
<form method="post" action="gongji_list.jsp">
	<table>
		<tr>
			<td style="height : 20%;"><p style="text-align : center;">게시글 생성</p></td>
		</tr>
		<tr>
			<td style="text-align : center;"><div style="margin-bottom : 10px;"><%=belongId%>번 게시글의 댓글이 생성되었습니다.</div>
										<input type="submit" value="게시판으로 이동"></td>
		</tr>
	</table>
</form>
</body>
</html>