<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, javax.sql.*,java.io.*,java.util.*,java.text.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>공지사항 작성 페이지</title>
<style>
	table {
		margin-top : 30px;
		margin-left : 50px;
	}

	#up {
		width : 600px;
		height : 300px;
		border : 1px solid black;
		border-collapse : collapse;
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
		margin-top : 30px;
		margin-left : 50px;
	}
</style>
<script>
	function validateInput(element) {
		  var value = element.value.trim(); // 입력값의 양 끝 공백 제거

	  	if (value === '') {
	    	element.setCustomValidity('공백만으로 이루어진 문자는 사용할 수 없습니다.');
	  	} else {
	    	element.setCustomValidity(''); // 유효성 검사 통과
	 	 }
	}
</script>
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
	ResultSet rset2 = stmt.executeQuery("select id from comment");
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
					<input type="text" name="title" onkeydown="validateInput(this)" maxlength="20" value="" style="width:400px;" required>
				</td>
			</tr>
			<tr>
				<td class="one" style="height:30px;">일자</td>
				<td class="nine" style="height:30px;"><%=strToday%><input type="hidden" name="today" value="<%=strToday%>"></td>
			</tr>
			<tr>
				<td class="one">내용</td>
				<td class="nine">
					<textarea name="message" maxlength="600" onkeydown="validateInput(this)" style="overflow: auto; border: none; resize: none; width: 95%; height: 300px;" required></textarea>
				</td>
			</tr>
			<tr>
				<td>원글</td>
				<td><%=id%><input type="hidden" name="rootid" value="<%=id%>"></td>
			</tr>
			<tr>
				<td style="font-size:13px;">댓글 레벨</td>
				<td><span style="width:100px; display:inline-block;">0<input type="hidden" name="relevel" value="0"></span>
					<span>댓글 내 순서 <input type="text" name="recnt" value="0" readonly></span> <!-- 원글이므로 relevel, recnt = 0 -->
				</td>
			</tr>
		</table>
		<table id="down" style="margin-left : 50px;">
			<tr>
				<td style="border:0px; text-align:right;">
					<input type="submit" name='' value="취소" formaction="comment_list.jsp" formnovalidate>
					<input type="submit" name='' value="쓰기" formaction="comment_write.jsp">
				</td>
			</tr>
		</table>
	</form>
</body>
</html>