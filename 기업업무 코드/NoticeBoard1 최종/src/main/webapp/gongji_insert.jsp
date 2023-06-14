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
		margin : auto; /* 가운데 정렬 */
	}
		
	td { /* td태그에 css 적용 */
		border : 1px solid black; /* border : 1px solid black */
	}

	#up { /* id가 up인 태그에 css 적용 */
		width : 600px; /* 너비 600px */
		height : 300px; /* 높이 300px */
		border : 1px solid black; /* border : 1px solid black */
		border-collapse : collapse; /* 경계선 겹침 허용 */
	}
	
	#down { /* id가 down인 태그에 css 적용 */
		width : 600px; /* 너비 600px */
		margin : auto; /* 가운데 정렬 */
	}
	
	.one { /* class가 one인 태그에 css 적용 */
		width : 10%; /* 너비 10% */
	}
	
	.nine { /* class가 nine인 태그에 css 적용 */
		width : 90%; /* 너비 90% */
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
	Class.forName("com.mysql.cj.jdbc.Driver");// Mysql의 버전이 8.0이므로 JDBC 이렇게 작성
	Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:33060/kopo10", "root", "kopoctc");
	// localhost : 서버 IP주소, 33060 : 포트번호, kopo10 : DB 이름, root : user, kopoctc : passwd 
	// getConnection 안의 url을 사용해서 DriverManager클래스의 getConnection 메소드를 호출
	Statement stmt = conn.createStatement(); // sql쿼리를 실행하기위한 객체 stmt 생성
	
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
	Calendar c1 = Calendar.getInstance();
	String strToday = sdf.format(c1.getTime()); // 오늘 날짜 구하는 String변수 strToday
	
	int id = 1; // int 변수 id = 1로 초기화
	ResultSet rset2 = stmt.executeQuery("select id from gongji"); // gongji테이블에서 id 출력
	while(rset2.next()) {
		id = rset2.getInt(1) + 1; // 가장 마지막 id값에 + 1해서 변수 id에 저장
	}
	conn.close();
    stmt.close();
	%>
	<form name="myForm" method="post" onsubmit="return validateForm()"> <%-- 데이터 전송하는 form태그 --%>
		<table id="up">
			<tr>
				<td class="one" style="height:30px;">번호</td> <%-- 번호 --%>
				<td class="nine" style="height:30px;"><%=id%> <%-- 몇번인지 출력 --%>
				<input type="hidden" name="autoId" value="<%=id%>"> <%-- input hidden으로 데이터 넘김 --%>
				</td>
			</tr>
			<tr>
				<td class="one" style="height:30px;">제목</td> <%-- 제목 --%>
				<td class="nine" style="height:30px;"> <%-- 제목 출력 --%>
					<input type="text" id="title" name="title" maxlength="33" value="" style="width:400px;" required> <%-- 제목 최대 20자 입력가능한 input태그 --%>
				</td>
			</tr>
			<tr>
				<td class="one" style="height:30px;">일자</td> <%-- 일자 --%>
				<td class="nine" style="height:30px;"><%=strToday%><input type="hidden" name="today" value="<%=strToday%>"></td> <%-- 오늘날짜 출력 --%>
			</tr>
			<tr>
				<td class="one">내용</td> <%-- 내용 --%>
				<td class="nine">
					<%-- 내용 출력 --%>
					<textarea id="message" name="message" maxlength="12000" style="overflow: auto; border: none; resize: none; width: 95%; height: 300px;" required></textarea>
				</td>
			</tr>
		</table>
		<table id="down">
			<tr>
				<td style="border:0px; text-align:right;"> <%-- 오른쪽 정렬 --%>
					<input type="submit" name='' value="취소" formaction="gongji_list.jsp" onclick="window.location.href = 'gongji_list.jsp';"> <%-- gongji_list 호출 --%>
					<input type="submit" name='' value="쓰기" formaction="gongji_write.jsp"> <%-- 쓰기버튼, gongji_write 호출 --%>
				</td>
			</tr>
		</table>
	</form>
</body>
</html>