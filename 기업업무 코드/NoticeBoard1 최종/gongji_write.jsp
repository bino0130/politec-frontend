<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, javax.sql.*,java.io.*,java.util.*,java.text.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>공지사항 수정/작성 완료 페이지</title>
<style>
	table { /* table태그에 css 작성 */
		width : 400px;
		height : 400px;
		border : 1px solid black;
		border-collapse : collapse;
		margin : auto;
	}
	
	td { /* td태그에 css 작성 */
		border : 1px solid black;
	}
</style>
</head>
<body>
<%
	request.setCharacterEncoding("utf-8"); // 인코딩 utf-8로 설정
	// gongji_insert로부터 "autoId"를 parameter로 받는 int형 변수 autoId 생성
	String autoId = request.getParameter("autoId");
	
	//gongji_update로부터 "updateId"를 parameter로 받는 int형 변수 printId 생성
	String updateId = request.getParameter("updateId"); 
	
	Class.forName("com.mysql.cj.jdbc.Driver");// Mysql의 버전이 8.0이므로 JDBC 이렇게 작성
	Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/kopo10", "root", "kopoctc");
	// localhost : 서버 IP주소, 33060 : 포트번호, kopo10 : DB 이름, root : user, kopoctc : passwd 
	// getConnection 안의 url을 사용해서 DriverManager클래스의 getConnection 메소드를 호출
	Statement stmt = conn.createStatement(); // sql쿼리를 실행하기위한 객체 stmt 생성
	
	if (updateId == null) { // 만약 updateId가 null이라면 -> autoId에 값이 전달되었다면
		String title = request.getParameter("title"); // 전달받은 데이터 가져오기
		title = title.replace("&","&amp;").replace("<", "&lt;").replace(">", "&gt;"); // &, <, > 문자 대체
		
		String today = request.getParameter("today"); // today를 parameter로 받는 String변수 today
		
		String message = request.getParameter("message"); // 전달받은 데이터 가져오기
		message = message.replace("&","&amp;").replace("<", "&lt;").replace(">", "&gt;"); // &, <, > 문자 대체
		
		String Querytxt = String.format("insert into gongji (title, date, content) values ('%s', '%s', '%s')"
										,title, today, message); // 공지 테이블의 title, date, content 컬럼에 값 입력
		stmt.execute(Querytxt); // 쿼리 실행
		
%>
<form method="post" action="gongji_list.jsp"> <%-- gongji_list에 값을 전달하는 form태그 --%>
	<table>
		<tr>
			<td style="height : 20%;"><p style="text-align : center;">게시글 생성</p></td> <%-- 게시글 생성 --%>
		</tr>
		<tr>
			<td style="text-align : center;">
				<div style="margin-bottom : 10px;"><%=Integer.parseInt(autoId)%>번 <%=title%> 게시글이 생성되었습니다.</div> <%-- 안내문구 출력 --%>
				<input type="submit" value="게시판으로 이동"><%-- 이동 버튼 --%>
			</td>
		</tr>
	</table>
</form>
<%
	} else if (updateId != null) { // updateId가 전달받은 값이 있다면
		String updateTitle = request.getParameter("updateTitle"); // 전달받은 데이터 가져오기
		updateTitle = updateTitle.replace("&","&amp;").replace("<", "&lt;").replace(">", "&gt;"); // &, <, > 문자 대체
		
		String updateContent = request.getParameter("updateContent"); // 전달받은 데이터 가져오기
		updateContent = updateContent.replace("&","&amp;").replace("<", "&lt;").replace(">", "&gt;"); // &, <, > 문자 대체
		
		String Querytxt = String.format("update gongji set title='%s', content='%s' where id=%d"
				, updateTitle, updateContent, Integer.parseInt(updateId)); // gongji 테이블의 id가 updateId인 데이터의 title, content 업데이트
		stmt.executeUpdate(Querytxt); // 쿼리 실행
		
%>
<form method="post" action="gongji_list.jsp"> <%-- gongji_list에 값을 전달하는 form태그 --%>
	<table>
		<tr>
			<td style="height : 20%;"><p style="text-align : center;">게시글 수정</p></td> <%-- 게시글 수정 --%>
		</tr>
		<tr>
			<td style="text-align : center;">
				<div style="margin-bottom : 10px;"><%=Integer.parseInt(updateId)%>번 <%=updateTitle%> 게시글이 수정되었습니다.</div> <%-- 안내문구 출력 --%>
				<input type="submit" value="게시판으로 이동"> <%-- 이동버튼 --%>
			</td>
		</tr>
	</table>
</form>
<%
	}
	conn.close(); // 리소스 누설 방지
    stmt.close(); // 리소스 누설 방지
%>
</body>
</html>