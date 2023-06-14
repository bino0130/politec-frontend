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
		width : 13%;
		height : 30px;
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
try {
	Class.forName("com.mysql.cj.jdbc.Driver");// Mysql의 버전이 8.0이므로 JDBC 이렇게 작성
	Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:33060/kopo10", "root", "kopoctc");
	// localhost : 서버 IP주소, 33060 : 포트번호, kopo10 : DB 이름, root : user, kopoctc : passwd 
	// getConnection 안의 url을 사용해서 DriverManager클래스의 getConnection 메소드를 호출
	Statement stmt = conn.createStatement(); // sql쿼리를 실행하기위한 객체 stmt 생성
	
	request.setCharacterEncoding("utf-8"); // 인코딩 utf-8로 설정
	int id = Integer.parseInt(request.getParameter("id")); // "id"를 parameter로 받는 int형 변수 id 생성

	String Querytxt = String.format("select * from comment where id= %d", id); // comment 테이블에서 id = id인 데이터 출력하는 쿼리
	ResultSet rset = stmt.executeQuery(Querytxt); // 쿼리 실행
	
	int printId = 0; // int형 변수 printId = 0으로 초기화
	String title = ""; // String 변수 title = ""으로 초기화
	String date = ""; // String 변수 date = ""으로 초기화
	String content = ""; // String 변수 content = ""으로 초기화
	int rootid = 0; // int형 변수 rootid = 0으로 초기화
	int relevel = 0; // int형 변수 relevel = 0으로 초기화
	int recnt = 0; // int형 변수 recnt = 0으로 초기화
	int viewcnt = 0; // int형 변수 viewcnt = 0으로 초기화
%>
<form name="myForm" method="post" onsubmit="return validateForm()">
	<table id="up">
		<%
			while(rset.next()) {
				printId = rset.getInt(1); // printId에 값 대입
				title = rset.getString(2); // title에 값 대입
				date = rset.getString(3); // date에 값 대입
				content = rset.getString(4); // content에 값 대입
				rootid = rset.getInt(5); // rootid에 값 대입
				relevel = rset.getInt(6); // relevel에 값 대입
				recnt = rset.getInt(7); // recnt에 값 대입
				viewcnt = rset.getInt(8); // viewcnt에 값 대입
		%>
			<tr>
				<td class="one" style="background-color : skyblue;">번호</td> <%-- 번호 --%>
				<td class="nine"><%=printId%><input type="hidden" name="updateId" value="<%=printId%>"></td> <%-- 번호 출력, 데이터 전달하기 위해 input hidden 사용 --%>
			</tr>
			<tr>
				<td class="one" style="background-color : skyblue;">제목</td> <%-- 제목 --%>
				<td class="nine"><input type="text" name="updateTitle" value="<%=title%>" required></td> <%-- 제목 입력 --%>
			</tr>
			<tr>
				<td class="one" style="background-color : skyblue;">조회수</td> <%-- 조회수 --%>
				<td class="nine"><%=viewcnt%></td> <%-- 조회수 출력 --%>
			</tr>
			<tr>
				<td class="one" style="background-color : skyblue;">일자</td> <%-- 일자 --%>
				<td class="nine"><%=date%><input type="hidden" name="updateDate" value="<%=date%>"></td> <%-- 일자 출력, 데이터 전달하기 위해 input hidden 사용 --%>
			</tr>
			<tr>
				<td class="one" style="background-color : skyblue;">내용</td> <%-- 내용 --%>
					 <%-- 내용 입력 --%>
				<td class="nine"><textarea name="updateContent" maxlength="600" rows="20" cols="70" style="overflow: auto; border: none; resize: none;" required><%=content%></textarea></td>
			</tr>
			<tr>
				<td class="one" style="background-color : skyblue;">원글</td> <%-- 원글 --%>
				<td class="nine"><%=rootid%><input type="hidden" name="updateRootid" value="<%=rootid%>"></td> <%-- 원글 id 출력, 데이터 전달하기 위해 input hidden 사용 --%>
			</tr>
			<tr>
				<td class="one" style="background-color : skyblue;">댓글 레벨</td> <%-- 댓글 레벨 --%>
				<td class="nine"><span style="width:100px; display:inline-block;"><%=relevel%><input type="hidden" name="updateRelevel" value="<%=relevel%>"></span> <%-- 댓글 레벨 출력 --%>
					<span>댓글 내 순서 : <%=recnt%><input type="hidden" name="updateRecnt" value="<%=recnt%>"></span> <%-- 댓글 순서 출력 --%>
				</td>
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
				<input class="submit" type="submit" name='' value="취소" formaction="comment_list.jsp" onclick="window.location.href = 'comment_list.jsp';"> <%-- 유효성 검사를 무시하는 취소버튼, comment_list에 값 전달 --%>
				<input class="submit" type="submit" name='' value="쓰기" formaction="comment_write.jsp"> <%-- 쓰기 버튼, comment_write에 값 전달 --%>
			</td>
		</tr>
	</table>
</form>
<%
	} catch (Exception e) {
%>
		<form method="post" action="product_list.jsp">
			<div><p style="text-align:center;">에러가 발생했습니다.</p></div>
			<div style="text-align:center;"><input type="submit" value="게시판으로 이동"></div> <%-- 게시판 이동 버튼 --%>
		</form>
<%
	}
%>
</body>
</html>