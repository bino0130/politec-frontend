<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, javax.sql.*,java.io.*,java.util.*,java.text.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>공지사항/댓글 삭제 완료 페이지</title>
<style>
	table { /* table태그에 css 적용 */
		width : 400px;
		height : 400px;
		border : 1px solid black;
		border-collapse : collapse;
		margin : auto;
	}
	
	td { /* td태그에 css 적용 */
		border : 1px solid black;
	}
</style>
</head>
<body>
<%
	Class.forName("com.mysql.cj.jdbc.Driver");// Mysql의 버전이 8.0이므로 JDBC 이렇게 작성
	Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/kopo10", "root", "kopoctc");
	// localhost : 서버 IP주소, 33060 : 포트번호, kopo10 : DB 이름, root : user, kopoctc : passwd 
	// getConnection 안의 url을 사용해서 DriverManager클래스의 getConnection 메소드를 호출
	Statement stmt = conn.createStatement(); // sql쿼리를 실행하기위한 객체 stmt 생성
	
	request.setCharacterEncoding("utf-8"); // 인코딩 utf-8로 설정
	int id = Integer.parseInt(request.getParameter("id")); // "id"를 parameter로 받는 int형 변수 id 생성

	String title = request.getParameter("title"); // "title"를 parameter로 받는 String변수 title 생성
	title = title.replace("&","&amp;").replace("<", "&lt;").replace(">", "&gt;"); // &, <, > 문자 대체


	int rootid = Integer.parseInt(request.getParameter("rootid")); // "rootid"를 parameter로 받는 int형 변수 rootid 생성
	int relevel = Integer.parseInt(request.getParameter("relevel")); // "relevel"를 parameter로 받는 int형 변수 relevel 생성
	int recnt = Integer.parseInt(request.getParameter("recnt")); // "recnt"를 parameter로 받는 int형 변수 recnt 생성
	
	if (relevel == 0) { // 만약 relevel이 0이면 -> 원글이라는 뜻
		String Querytxt = String.format("delete from comment where rootid=%d", rootid); // rootid가 rootid인 comment테이블의 데이터 삭제하는 쿼리
		stmt.execute(Querytxt); // 쿼리 실행
	
		conn.close(); // 리소스 누설 방지
    	stmt.close(); // 리소스 누설 방지
%>
<form method="post" action="comment_list.jsp"> <%-- comment_list에 값을 전달하는 form태그 --%>
	<table>
		<tr>
			<td style="height : 20%;"><p style="text-align : center;">게시글/댓글 삭제</p></td> <%-- 게시글/댓글 삭제 --%>
		</tr>
		<tr>
			<td style="text-align : center;">
				<div style="margin-bottom : 10px;"><%=id%>번 <%=title%> 게시글이 삭제되었습니다.</div> <%-- 안내문구 출력 --%>
				<input type="submit" value="게시판으로 이동"> <%-- 게시판으로 이동 버튼 --%>
			</td>
		</tr>
	</table>
</form>
<%
	} else if (relevel > 0) { // relevel이 0보다 크다면 -> 댓글이라는 뜻
		// comment테이블에서 id = id, rootid = rootid, relevel = relevel, recnt = recnt인 데이터 삭제하는 쿼리
		//String Querytxt = String.format("delete from comment where id=%d and rootid=%d and relevel=%d and recnt=%d", id, rootid, relevel, recnt);
		String Querytxt = String.format("update comment set title='%s', content='%s', viewcnt = -1 where id = %d and rootid = %d and relevel = %d and recnt = %d", 
							"삭제된 댓글입니다", "삭제된 댓글입니다", id, rootid, relevel, recnt);
		stmt.execute(Querytxt); // 쿼리 실행
		
		conn.close(); // 리소스 누설 방지
    	stmt.close(); // 리소스 누설 방지
%>
<form method="post" action="comment_list.jsp">
	<table>
		<tr>
			<td style="height : 20%;"><p style="text-align : center;">게시글/댓글 삭제</p></td> <%-- 게시글/댓글 삭제 --%>
		</tr>
		<tr>
			<td style="text-align : center;">
				<div style="margin-bottom : 10px;"><%=rootid%>번 게시글의 <%=recnt%>번째 댓글이 삭제되었습니다.</div> <%-- 안내문구 출력 --%>
				<input type="submit" value="게시판으로 이동"> <%-- 게시판으로 이동 버튼 --%>
			</td>
		</tr>
	</table>
</form>
<%
	}
%>
</body>
</html>