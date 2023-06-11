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
	
	request.setCharacterEncoding("utf-8"); // 인코딩 utf-8로 설정
	int id = Integer.parseInt(request.getParameter("id")); // "id"를 parameter로 받는 int형 변수 id 생성

	String Querytxt = String.format("select * from gongji where id= %d", id);
	ResultSet rset = stmt.executeQuery(Querytxt);
	
	int printId = 0;
	String title = "";
	String date = "";
	String content = "";
	int rootid = 0;
	int relevel = 0;
	int recnt = 0;
	int viewcnt = 0;
%>
<form>
	<table id="up">
		<%
			while(rset.next()) {
				printId = rset.getInt(1);
				title = rset.getString(2);
				date = rset.getString(3);
				content = rset.getString(4);
				rootid = rset.getInt(5);
				relevel = rset.getInt(6);
				recnt = rset.getInt(7);
				viewcnt = rset.getInt(8);
		%>
			<tr>
				<td>번호</td>
				<td><%=printId%><input type="hidden" name="updateId" value="<%=printId%>"></td>
			</tr>
			<tr>
				<td>제목</td>
				<td><input type="text" name="updateTitle" value="<%=title%>" required></td>
			</tr>
			<tr>
				<td>조회수</td>
				<td><%=viewcnt%></td>
			</tr>
			<tr>
				<td>일자</td>
				<td><%=date%><input type="hidden" name="updateDate" value="<%=date%>"></td>
			</tr>
			<tr>
				<td>내용</td>
				<td><textarea name="updateContent" maxlength="600" rows="20" cols="70" style="overflow: auto; border: none; resize: none;" required><%=content%></textarea></td>
			</tr>
			<tr>
				<td>원글</td>
				<td><%=rootid%><input type="hidden" name="updateRootid" value="<%=rootid%>"></td>
			</tr>
			<tr>
				<td>댓글 레벨</td>
				<td><span style="width:100px; display:inline-block;"><%=relevel%><input type="hidden" name="updateRelevel" value="<%=relevel%>"></span>
					<span>댓글 내 순서 <input type="text" name="updateRecnt" value="<%=recnt%>" readonly></span>
				</td>
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
				<input type="submit" name='' value="취소" formaction="comment_list.jsp" formnovalidate>
				<input type="submit" name='' value="쓰기" formaction="comment_write.jsp">
			</td>
		</tr>
	</table>
</form>
</body>
</html>