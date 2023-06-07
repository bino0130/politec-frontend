<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, javax.sql.*,java.io.*,java.util.*,java.text.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>공지사항 작성 페이지</title>
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
	
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
	Calendar c1 = Calendar.getInstance();
	String strToday = sdf.format(c1.getTime());
	
	int id = 1;
	ResultSet rset2 = stmt.executeQuery("select id from gongji");
	while(rset2.next()) {
		id = rset2.getInt(1) + 1;
	}
	conn.close();
    stmt.close();
	%>
	<form method="post">
		<table id="up">
			<tr>
				<td class="one" style="height:30px;">번호</td>
				<td class="nine" style="height:30px;"><%=id%>
				<input type="hidden" name="autoId" value="<%=id%>">
				</td>
			</tr>
			<tr>
				<td class="one" style="height:30px;">제목</td>
				<td class="nine" style="height:30px;">
					<input type="text" name="title" value='' pattern="^(?!\s*$)(?!^\s*$).{1,20}$" style="width: 400px;" required>
				</td>
			</tr>
			<tr>
				<td class="one" style="height:30px;">일자</td>
				<td class="nine" style="height:30px;"><%=strToday%><input type="hidden" name="today" value="<%=strToday%>"></td>
			</tr>
			<tr>
				<td class="one">내용</td>
				<td class="nine">
					<textarea name="message" maxlength="600" style="overflow: auto; border: none; resize: none; width: 95%; height: 300px;" required></textarea>
				</td>
			</tr>
		</table>
		<table id="down" style="margin-left : 50px;">
			<tr>
				<td style="border:0px; text-align:right;">
					<input type="submit" name='' value="취소" formaction="gongji_list.jsp" formnovalidate>
					<input type="submit" name='' value="쓰기" formaction="gongji_write.jsp">
				</td>
			</tr>
		</table>
	</form>
</body>
</html>