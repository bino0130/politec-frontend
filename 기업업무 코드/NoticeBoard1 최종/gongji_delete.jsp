<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, javax.sql.*,java.io.*,java.util.*,java.text.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>공지사항 삭제 완료 페이지</title>
<style>
	table { /* table태그에 css 적용 */
		width : 400px; /* 너비 400px */
		height : 400px; /* 높이 400 px */
		border : 1px solid black; /* border : 1px solid black */
		border-collapse : collapse; /* 경계선 겹침 허용 */
		margin : auto; /* 가운데 정렬 */
	}
	
	td { /* td 태그에 css 적용 */
		border : 1px solid black; /* border : 1px solid black */
	}
</style>
</head>
<body>
<%
	request.setCharacterEncoding("utf-8"); // 인코딩 utf-8로 설정
	int updateId = Integer.parseInt(request.getParameter("updateId")); // "id"를 parameter로 받는 int형 변수 id 생성
	String updateTitle = request.getParameter("updateTitle"); // updateTitle을 parameter로 받는 String 변수 updateTitle 생성
	updateTitle = updateTitle.replace("&","&amp;").replace("<", "&lt;").replace(">", "&gt;"); // &, <, > 문자 대체
	
	Class.forName("com.mysql.cj.jdbc.Driver");// Mysql의 버전이 8.0이므로 JDBC 이렇게 작성
	Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/kopo10", "root", "kopoctc");
	// localhost : 서버 IP주소, 33060 : 포트번호, kopo10 : DB 이름, root : user, kopoctc : passwd 
	// getConnection 안의 url을 사용해서 DriverManager클래스의 getConnection 메소드를 호출
	Statement stmt = conn.createStatement(); // sql쿼리를 실행하기위한 객체 stmt 생성
	
	String Querytxt = String.format("delete from gongji where id= %d", updateId); // id가 updateId인 데이터 삭제
	stmt.execute(Querytxt); // 쿼리 실행
	
	conn.close(); // 리소스 누설 방지
    stmt.close(); // 리소스 누설 방지
%>
<form method="post" action="gongji_list.jsp"> <%-- gongji_list에 데이터 전달하는 form --%>
	<table> 
		<tr>
			<td style="height : 20%;"><p style="text-align : center;">게시글 삭제</p></td> <%-- 게시글 삭제 --%>
		</tr>
		<tr>
			<td style="text-align : center;">
				<div style="margin-bottom : 10px;"><%=updateId%>번 <%=updateTitle%> 게시글이 삭제되었습니다.</div> <%-- 안내문구 출력 --%>
				<input type="submit" value="게시판으로 이동"> <%-- 이동버튼 --%>
			</td> 
		</tr>
	</table>
</form>
</body>
</html>