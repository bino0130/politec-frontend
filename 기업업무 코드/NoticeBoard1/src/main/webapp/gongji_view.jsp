<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, javax.sql.*,java.io.*,java.util.*,java.text.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>선택된 공지사항 출력 페이지</title>
<style>
	table {
		width : 600px;
		height : 300px;
		border : 1px solid black;
		border-collapse : collapse;
		margin-top : 10px;
		margin-left : 10px;
	}
	
	td {
		border : 1px solid black;
	}
	
	.three {
		width : 30%;
	}
	
	.seven {
		width : 70%;
	}
	
	#down {
		width : 600px;
		border:0px; 
		height:0px;
	}
</style>
</head>
<body>
<%
	String ckey = request.getParameter("key"); // "key"를 parameter로 받는 String변수 ckey 생성
	
	Class.forName("com.mysql.cj.jdbc.Driver");// Mysql의 버전이 8.0이므로 JDBC 이렇게 작성
	Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:33060/kopo10", "root", "kopoctc");
	// localhost : 서버 IP주소, 33060 : 포트번호, kopo10 : DB 이름, root : user, kopoctc : passwd 
	// getConnection 안의 url을 사용해서 DriverManager클래스의 getConnection 메소드를 호출
	Statement stmt = conn.createStatement(); // sql쿼리를 실행하기위한 객체 stmt 생성
	
	String Querytxt = String.format("select id, title, date, content from gongji where id= %d", Integer.parseInt(ckey));
	ResultSet rset = stmt.executeQuery(Querytxt);
	int id = 0;
	String title = "";
	String date = "";
	String content = "";
%>
<form method="post">
	<table>
		<%
			while(rset.next()) {
				id = rset.getInt(1);
				title = rset.getString(2);
				date = rset.getString(3);
				content = rset.getString(4);
		%>
				<tr>
					<td>번호</td>
					<td><%=id%><input type="hidden" name="id" value="<%=id%>"></td>
				</tr>
				<tr>
					<td>제목</td>
					<td><%=title%></td>
				</tr>
				<tr>
					<td>일자</td>
					<td><%=date%></td>
				</tr>
				<tr>
					<td>내용</td>
					<td><textarea name="updateContent" maxlength="600" rows="20" cols="70" style="overflow: auto; border: none; resize: none;" readonly><%=content%></textarea></td>
				</tr>
		<%
			}
		conn.close();
	    stmt.close();
		%>
	</table>
	<table id="down">
		<tr>
			<td style = "border:0px; text-align:right;">
				<input type="submit" value="목록" formaction="gongji_list.jsp">
				<input type="submit" value="수정" formaction="gongji_update.jsp">
			</td>
		</tr>
	</table>
</form>
</body>
</html>