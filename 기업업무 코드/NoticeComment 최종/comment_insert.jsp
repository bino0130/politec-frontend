<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, javax.sql.*,java.io.*,java.util.*,java.text.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>공지사항 작성 페이지</title>
<style>
	table { /* table태그에 css 적용 */
		margin : auto;
	}

	td { /* td태그에 css 적용 */
		border : 1px solid black;
	}
	
	.one { /* class명이 one인 태그에 css 적용 */
		width : 13%;
		height : 30px;
		text-align : center;
	}
	
	.nine { /* class명이 nine인 태그에 css 적용 */
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
function trimSpace(input) { // 공백 trim하는 함수
	return input.replace(/^\s+/, ''); // 공백이 있으면 없앰
}
    
function InputCheck(input) { // 입력값 체크하는 함수
     var inputValue = input; // 입력 받는 변수 혹은 데이터베이스에서 가져온 값 등
     var pattern = /^(?!(\s)*$)$/;
     
     if(inputValue.trim().length === 0){ // inputValue.trim()의 길이가 0이라면 경고창 띄움
      alert("내용을 입력하세요");
        return false;
     }
 }
 
function validateForm() { // 폼 체크하는 함수
      var title = document.forms["myForm"]["title"].value; // myForm태그안에 있는 title이란 name의 value를 가져옴
      var content = document.forms["myForm"]["message"].value; // myForm태그안에 있는 message란 name의 value를 가져옴
      
      title = trimSpace(title); // title trim()
      
      if (InputCheck(title) == false) { // inputCheck가 false면 false
         return false;
   	  }
}
</script>
</head>
<body>
	<%
	Class.forName("com.mysql.cj.jdbc.Driver");// Mysql의 버전이 8.0이므로 JDBC 이렇게 작성
	Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/kopo10", "root", "kopoctc");
	// localhost : 서버 IP주소, 33060 : 포트번호, kopo10 : DB 이름, root : user, kopoctc : passwd 
	// getConnection 안의 url을 사용해서 DriverManager클래스의 getConnection 메소드를 호출
	Statement stmt = conn.createStatement(); // sql쿼리를 실행하기위한 객체 stmt 생성
	
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
	sdf.setTimeZone(TimeZone.getTimeZone("Asia/Seoul")); // 한국 시간대로 설정
	Calendar c1 = Calendar.getInstance();
	String strToday = sdf.format(c1.getTime()); // 오늘 날짜 구하는 String변수 strToday
	
	int id = 1; // int형 변수 id = 1로 초기화
	ResultSet rset2 = stmt.executeQuery("select id from comment"); // comment테이블에서 id 출력하는 쿼리
	while(rset2.next()) {
		id = rset2.getInt(1) + 1; // 변수 id에 id 최대값 + 1 대입
	}
	conn.close(); // 리소스 누설 방지
    stmt.close(); // 리소스 누설 방지
	%>
	<form name="myForm" method="post" onsubmit="return validateForm()"> <%-- 데이터를 전달하는 form태그 --%>
		<table id="up">
			<tr>
				<td class="one" style="height:30px; background-color:skyblue;">번호</td> <%-- 번호 --%>
				<td class="nine" style="height:30px;"><%=id%> <%-- id 출력 --%>
				<input type="hidden" name="autoId" value="<%=id%>"> <%-- 데이터 전달하기위해 input hidden 사용 --%>
				</td>
			</tr>
			<tr>
				<td class="one" style="height:30px; background-color:skyblue;">제목</td> <%-- 제목 --%>
				<td class="nine" style="height:30px;">
					<input type="text" name="title" maxlength="33" value="" style="width:400px;" required> <%-- 제목 입력 --%>
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
					<textarea name="message" maxlength="12000" style="overflow: auto; border: none; resize: none; width: 95%; height: 300px;" required></textarea>
				</td>
			</tr>
			<tr>
				<td style="text-align:center; background-color:skyblue;">원글</td> <%-- 원글 --%>
				<td><%=id%><input type="hidden" name="rootid" value="<%=id%>"></td> <%-- 원글 id 출력, 데이터 전달하기위해 input hidden 사용 --%>
			</tr>
			<tr>
				<td style="text-align:center; background-color:skyblue;">댓글 레벨</td> <%-- 댓글 레벨 --%>
				<td><span style="width:100px; display:inline-block;">0<input type="hidden" name="relevel" value="0"></span> <%-- 데이터 전달하기 위해 input hidden 사용 --%>
					<span>댓글 내 순서 : 0<input type="hidden" name="recnt" value="0"></span> <!-- 원글이므로 relevel, recnt = 0 -->
				</td>
			</tr>
		</table>
		<table id="down">
			<tr>
				<td style="border:0px; text-align:right;">
					<input class="submit" type="submit" name='' value="취소" formaction="comment_list.jsp" onclick="window.location.href = 'comment_list.jsp';"> <%-- 유효성 검사를 무시하는 취소버튼, comment_list에 값 전달 --%>
					<input class="submit" type="submit" name='' value="쓰기" formaction="comment_write.jsp"> <%-- 쓰기버튼, comment_write에 값 전달 --%>
				</td>
			</tr>
		</table>
	</form>
</body>
</html>