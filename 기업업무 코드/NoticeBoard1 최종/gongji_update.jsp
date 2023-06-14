<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, javax.sql.*,java.io.*,java.util.*,java.text.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>공지사항 수정 페이지</title>
<style>
	td { /* td태그에 css 적용 */
		border : 1px solid black;
	}
	
	.one { /* class가 one인 태그에 css 적용 */
		width : 10%;
		text-align : center;
	}
	
	.nine { /* class가 nine인 태그에 css 적용 */
		width : 90%;
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
		margin : auto;
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
 
function validateForm() {// 폼 체크하는 함수
      var title = document.forms["myForm"]["itemName"].value; // myForm태그안에 있는 itemName이란 name의 value를 가져옴
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
try {
	int id = Integer.parseInt(request.getParameter("id")); // "id"를 parameter로 받는 int형 변수 id 생성

	Class.forName("com.mysql.cj.jdbc.Driver");// Mysql의 버전이 8.0이므로 JDBC 이렇게 작성
	Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/kopo10", "root", "kopoctc");
	// localhost : 서버 IP주소, 33060 : 포트번호, kopo10 : DB 이름, root : user, kopoctc : passwd 
	// getConnection 안의 url을 사용해서 DriverManager클래스의 getConnection 메소드를 호출
	Statement stmt = conn.createStatement(); // sql쿼리를 실행하기위한 객체 stmt 생성
	
	String Querytxt = String.format("select id, title, date, content from gongji where id= %d", id); // id가 id인 공지 테이블의 데이터 출력
	ResultSet rset = stmt.executeQuery(Querytxt); // 쿼리 실행
	
	String title = ""; // String변수 title=""로 초기화
	String date = ""; // String변수 date=""로 초기화
	String content = ""; // String변수 content=""로 초기화
%>
<form name="myForm" method="post" onsubmit="return validateForm()">
	<table id="up">
		<%
			while(rset.next()) {
				id = rset.getInt(1); // id에 값 대입
				title = rset.getString(2); // title에 값 대입
				date = rset.getString(3); // date에 값 대입
				content = rset.getString(4); // content에 값 대입
		%>
			<tr>
				<td class="one" style="height:30px; background-color : skyblue;">번호</td> <%-- 번호 --%>
				<td style="height:30px;"><%=id%><input type="hidden" name="updateId" value="<%=id%>" readonly></td> <%-- 번호 출력 --%>
			</tr>
			<tr>
				<td class="one" style="height:30px; background-color : skyblue;">제목</td> <%-- 제목 --%>
				<td style="height:30px;">
					 <%-- 제목 출력 --%>
					<input type="text" oninput="validateInput(this)" maxlength="33" name="updateTitle" value="<%=title%>" style="width:400px;" required>
				</td>
			</tr>
			<tr>
				<td class="one" style="height:30px; background-color : skyblue;">일자</td> <%-- 일자 --%>
				<td style="height:30px;"><p style="margin:0px;"><%=date%></p></td> <%-- 일자 출력 --%>
			</tr>
			<tr>
				<td class="one" style="background-color : skyblue;">내용</td> <%-- 내용 --%>
				 <%-- 내용 출력 --%>
				<td><textarea name="updateContent" maxlength="12000" oninput="validateInput(this)" rows="20" cols="70" style="overflow: auto; border: none; resize: none;" required><%=content%></textarea></td>
			</tr>
		<%
			}
		conn.close(); // 리소스 누설 방지
	    stmt.close(); // 리소스 누설 방지
		%>
	</table>
	<table id="down">
		<tr>
			<td style="border:0px; text-align:right;">
				<input class="submit" type="submit" name='' value="취소" formaction="gongji_list.jsp" formnovalidate> <%-- 유효성검사를 하지않는 취소버튼, gongji_list 호출 --%>
				<input class="submit" type="submit" name='' value="쓰기" formaction="gongji_write.jsp"> <%-- 쓰기버튼, gongji_write 호출 --%>
				<input class="submit" type="submit" name='' value="삭제" formaction="gongji_delete.jsp"> <%-- 삭제버튼, gongji_delete 호출 --%>
			</td>
		</tr>
	</table>
</form>
<%
} catch (Exception e) { // 에러 발생시
%>
	<form method="post" action="gongji_list.jsp"> <%-- gongji_list에 값을 전달하는 form태그 --%>
		<div><p style="text-align : center;">에러가 발생했습니다.</p></div> <%-- 안내문구 출력 --%>
		<div style="text-align:center;"><input type="submit" value="게시판으로 이동"></div> <%-- 게시판 이동 버튼 --%>
	</form>
<%
}
%>
</body>
</html>