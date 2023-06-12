<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, javax.sql.*,java.io.*,java.util.*,java.text.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>공지사항 댓글 작성 페이지</title>
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
    	var words = value.split(' '); // 입력값을 공백을 기준으로 분할하여 배열로 저장
    	var isValid = true;
    
    	for (var i = 0; i < words.length; i++) {
      		if (words[i] === '') {
        		isValid = false; // 공백만 있는 단어가 있을 경우 유효하지 않음
        		break;
      		}
    	}
    
    	if (isValid) {
      		element.setCustomValidity(''); // 유효성 검사 통과
    	} else {
      		element.setCustomValidity('공백만으로 이루어진 문자는 사용할 수 없습니다.');
    	}
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
	String strToday = sdf.format(c1.getTime()); // 오늘 날짜 설정
	
	int id = 1;
	ResultSet rset2 = stmt.executeQuery("select id from comment");
	while(rset2.next()) { 
		id = rset2.getInt(1) + 1; // 최대 id + 1로 id 설정
	} 
	
	request.setCharacterEncoding("utf-8"); // 인코딩 utf-8로 설정
	int rootid = 0;
	rootid = Integer.parseInt(request.getParameter("rootid")); // 원 글 id 나타내는 rootid
	
	int relevel = 0;
	relevel = Integer.parseInt(request.getParameter("relevel")) + 1; // 댓글 순서 나타내는 relevel

	int recnt = 1;
	String Querytxt = String.format("select max(recnt) + 1 from comment where rootid=%d and relevel=%d", rootid, relevel);
	ResultSet rset3 = stmt.executeQuery(Querytxt);
	while (rset3.next()) {
		recnt = rset3.getInt(1); // 댓글의 댓글 나타내는 recnt
	}
	if (recnt == 0) {
		recnt = 1;
	}
	conn.close();
    stmt.close();
	%>
	<form method="post">
		<table id="up">
			<tr>
				<td class="one" style="height:30px;">번호</td>
				<td class="nine" style="height:30px;"><%=id%>
					<input type="hidden" name="commentId" value="<%=id%>">
				</td>
			</tr>
			<tr>
				<td class="one" style="height:30px;">제목</td>
				<td class="nine" style="height:30px;">
					<input type="text" name="commentTitle" oninput="validateInput(this)" maxlength="20" value="" style="width:400px;" required>
				</td>
			</tr>
			<tr>
				<td class="one" style="height:30px;">일자</td>
				<td class="nine" style="height:30px;"><%=strToday%><input type="hidden" name="commentDate" value="<%=strToday%>"></td>
			</tr>
			<tr>
				<td class="one">내용</td>
				<td class="nine">
					<textarea name="commentContent" maxlength="600" oninput="validateInput(this)" style="overflow: auto; border: none; resize: none; width: 95%; height: 300px;" required></textarea>
				</td>
			</tr>
			<tr>
				<td class="one">원글</td>
				<td class="nine"><input type="text" name="belongId" value="<%=rootid%>" readonly></td>
			</tr>
			<tr>
				<td>댓글 레벨</td>
				<td><span style="width:100px; display:inline-block;"><input type="text" name="commentRelevel" value="<%=relevel%>" readonly></span>
					<span style="margin-left:100px;">댓글 내 순서 <input type="text" name="commentRecnt" value="<%=recnt%>" readonly></span>
				</td>
			</tr>
		</table>
		<table id="down" style="margin-left : 50px;">
			<tr>
				<td style="border:0px; text-align:right;">
					<input type="submit" name='' value="취소" formaction="comment_list.jsp" formnovalidate>
					<input type="submit" name='' value="쓰기" formaction="comment_rewrite.jsp">
				</td>
			</tr>
		</table>
	</form>
</body>
</html>