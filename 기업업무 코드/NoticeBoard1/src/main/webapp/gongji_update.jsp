<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, javax.sql.*,java.io.*,java.util.*,java.text.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>공지사항 수정 페이지</title>
<style>
	#up {
		width : 600px;
		height : 300px;
		border : 1px solid black;
		border-collapse : collapse;
		margin-top : 30px;
		margin-left : 50px;
	}
	
	td {
		border : 1px solid black;
	}
	
	.one {
		width : 10%;
	}
	
	.nine {
		width : 90%;
	}
	
	#down {
		width : 600px;
		margin-left : 50px;
	}
</style>
</head>
<body>
<%
	int id = Integer.parseInt(request.getParameter("id")); // "id"를 parameter로 받는 int형 변수 id 생성

	Class.forName("com.mysql.cj.jdbc.Driver");// Mysql의 버전이 8.0이므로 JDBC 이렇게 작성
	Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:33060/kopo10", "root", "kopoctc");
	// localhost : 서버 IP주소, 33060 : 포트번호, kopo10 : DB 이름, root : user, kopoctc : passwd 
	// getConnection 안의 url을 사용해서 DriverManager클래스의 getConnection 메소드를 호출
	Statement stmt = conn.createStatement(); // sql쿼리를 실행하기위한 객체 stmt 생성
	
	String Querytxt = String.format("select id, title, date, content from gongji where id= %d", id);
	ResultSet rset = stmt.executeQuery(Querytxt);
	
	String title = "";
	String date = "";
	String content = "";
%>
<form>
	<table id="up">
		<%
			while(rset.next()) {
				id = rset.getInt(1);
				title = rset.getString(2);
				date = rset.getString(3);
				content = rset.getString(4);
		%>
			<tr>
				<td class="one" style="height:30px;">번호</td>
				<td style="height:30px;"><input type="text" name="updateId" value="<%=id%>" style="width:400px;" readonly></td>
			</tr>
			<tr>
				<td class="one" style="height:30px;">제목</td>
				<td style="height:30px;"><input type="text" pattern="^(?!\s*$)(?!^\s*$).{1,20}$" name="updateTitle" value="<%=title%>" style="width:400px;" required></td>
			</tr>
			<tr>
				<td class="one" style="height:30px;">일자</td>
				<td style="height:30px;"><p><%=date%></p></td>
			</tr>
			<tr>
				<td class="one">내용</td>
				<td><textarea name="updateContent" maxlength="600" rows="20" cols="70" style="overflow: auto; border: none; resize: none;" required><%=content%></textarea></td>
			</tr>
		<%
			}
		
		conn.close();
	    stmt.close();
		%>
	</table>
	<table id="down">
		<tr>
			<td style="border:0px; text-align:right;">
				<input type="submit" name='' value="취소" formaction="gongji_list.jsp" formnovalidate>
				<input type="submit" name='' value="쓰기" formaction="gongji_write.jsp">
				<input type="submit" name='' value="삭제" formaction="gongji_delete.jsp">
			</td>
		</tr>
	</table>
</form>
</body>
</html>