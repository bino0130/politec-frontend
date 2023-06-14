<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, javax.sql.*,java.io.*,java.util.*,java.text.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>공지사항 댓글 작성 페이지</title>
<style>
	table { /* table태그에 css 적용 */
		margin : auto;
	}
	
	td { /* td태그에 css 적용 */
		border : 1px solid black;
	}
	
	.one { /* class가 one인 태그에 css 적용 */
		width : 13%;
		text-align : center;
	}
	
	.nine { /* class가 nine인 태그에 css 적용 */
		width : 87%;
	}

	.submit { /* class가 submit인 태그에 css 적용 */
		background-color : skyblue;
		border-color : skyblue;
		border-radius : 5px;
	}
	
	#up { /* id가 up인 태그에 css 적용 */
		width : 600px;
		height : 300px;
		border : 1px solid black;
		border-collapse : collapse;
	}
	
	#down { /* id가 down인 태그에 css 적용 */
		width : 600px;
		margin : auto;
	}
</style>
<script>
function trimSpace(input) {
	return input.replace(/^\s+/, '');
}
    
function InputCheck(input) {
     var inputValue = input; // 입력 받는 변수 혹은 데이터베이스에서 가져온 값 등
     var pattern = /^(?!(\s)*$)$/;
     
     if(inputValue.trim().length === 0){
      alert("내용을 입력하세요");
        return false;
     }
 }
 
function validateForm() {
      var title = document.forms["myForm"]["title"].value;
      var content = document.forms["myForm"]["message"].value;
      
      title = trimSpace(title);
      
      if (InputCheck(title) == false) {
         return false;
   	  }
}
</script>
</head>
<body>
	<%
try {
	Class.forName("com.mysql.cj.jdbc.Driver");// Mysql의 버전이 8.0이므로 JDBC 이렇게 작성
	Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/kopo10", "root", "kopoctc");
	// localhost : 서버 IP주소, 33060 : 포트번호, kopo10 : DB 이름, root : user, kopoctc : passwd 
	// getConnection 안의 url을 사용해서 DriverManager클래스의 getConnection 메소드를 호출
	Statement stmt = conn.createStatement(); // sql쿼리를 실행하기위한 객체 stmt 생성
	
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
	sdf.setTimeZone(TimeZone.getTimeZone("Asia/Seoul")); // 한국 시간대로 설정
	Calendar c1 = Calendar.getInstance();
	String strToday = sdf.format(c1.getTime()); // 오늘 날짜 설정
	
	int id = 1;
	ResultSet rset2 = stmt.executeQuery("select id from comment");
	while(rset2.next()) { 
		id = rset2.getInt(1) + 1; // 최대 id + 1로 id 설정
	} 
	
	request.setCharacterEncoding("utf-8"); // 인코딩 utf-8로 설정
	int rootid = 0; // int형 변수 rootid = 0으로 초기화
	rootid = Integer.parseInt(request.getParameter("rootid")); // 원 글 id 나타내는 rootid
	
	int relevel = 0; // int형 변수 relevel = 0으로 초기화
	relevel = Integer.parseInt(request.getParameter("relevel")) + 1; // 댓글 순서 나타내는 relevel
	
	int recnt = Integer.parseInt(request.getParameter("recnt")); // 댓글 출력 순서 나타내는 recnt
	
	conn.close(); // 리소스 누설 방지
    stmt.close(); // 리소스 누설 방지
	%>
	<form name="myForm" method="post" onsubmit="return validateForm()"> <%-- 데이터를 전달하는 form태그 --%>
		<table id="up">
			<tr>
				<td class="one" style="height:30px; background-color:skyblue;">번호</td> <%-- 번호 --%>
				<td class="nine" style="height:30px;">
					<%=id%><input type="hidden" name="autoId" value="<%=id%>"> <%-- 번호 출력, 데이터 전달하기 위해 input hidden 사용 --%>
				</td>
			</tr>
			<tr>
				<td class="one" style="height:30px; background-color:skyblue;">제목</td> <%-- 제목 --%>
				<td class="nine" style="height:30px;">
					 <%-- 제목 입력 --%>
					<input type="text" name="title" oninput="validateInput(this)" maxlength="33" value="" style="width:400px;" required>
				</td>
			</tr>
			<tr>
				<td class="one" style="height:30px; background-color:skyblue;">일자</td> <%-- 일자 --%>
				<td class="nine" style="height:30px;"><%=strToday%><input type="hidden" name="today" value="<%=strToday%>"></td> <%-- 일자 출력, 데이터 전달하기 위해 input hidden 사용 --%>
			</tr>
			<tr>
				<td class="one" style="background-color:skyblue;">내용</td> <%-- 내용 --%>
				<td class="nine">
					 <%-- 내용 입력 --%>
					<textarea name="message" maxlength="12000" oninput="validateInput(this)" style="overflow: auto; border: none; resize: none; width: 95%; height: 300px;" required></textarea>
				</td>
			</tr>
			<tr>
				<td class="one" style="background-color:skyblue;">원글</td> <%-- 원글 --%>
				<td class="nine"><input type="text" name="rootid" value="<%=rootid%>" readonly></td> <%-- 원글 id 출력 --%>
			</tr>
			<tr>
				<td style="background-color:skyblue;">댓글 레벨</td> <%-- 댓글 레벨 --%>
				<td><span style="width:100px; display:inline-block;"><input type="text" name="relevel" value="<%=relevel%>" readonly></span> <%-- 댓글 레벨 출력 --%>
					<span style="margin-left:100px;">댓글 내 순서 : <%=recnt + 1%><input type="hidden" name="recnt" value="<%=recnt%>"></span> <%-- 댓글 순서 출력 --%>
				</td>
			</tr>
		</table>
		<table id="down">
			<tr>
				<td style="border:0px; text-align:right;">
					<input class="submit" type="submit" name='' value="취소" formaction="comment_list.jsp" onclick="window.location.href = 'comment_list.jsp';"> <%-- 유효성 검사를 무시하는 취소버튼. comment_list에 값 전달 --%>
					<input class="submit" type="submit" name='' value="쓰기" formaction="comment_write.jsp"> <%-- 쓰기버튼, comment_rewrite에 값 전달 --%>
				</td>
			</tr>
		</table>
	</form>
<%
} catch (SQLSyntaxErrorException e) {
%>
<form>
	<div><p style="text-align:center;">SQL쿼리가 잘못되었습니다.</p></div>
	<p style="text-align:center;"><input type="submit" value="게시판으로 이동" formaction="comment_list.jsp"></p>
</form>
<%
}
%>
</body>
</html>