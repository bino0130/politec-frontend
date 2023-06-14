<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, javax.sql.*,java.io.*,java.util.*,java.text.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>선택된 공지사항 출력 페이지</title>
<style>
	table { /* table태그에 css적용 */
		width : 600px;
		height : 300px;
		border : 1px solid black;
		border-collapse : collapse;
		margin : auto;
	}
	
	td { /* td태그에 css 적용 */
		border : 1px solid black;
	}
	
	.three { /* class가 three인 태그에 css 적용 */
		width : 30%;
	}
	
	.seven { /* class가 seven인 태그에 css 적용 */
		width : 70%;
	}
	
	#down { /* id가 down인 태그에 css 적용 */
		width : 600px;
		border:0px; 
		height:0px;
	}
</style>
</head>
<body>
<%
try {
	String ckey = request.getParameter("key"); // "key"를 parameter로 받는 String변수 ckey 생성
	
	Class.forName("com.mysql.cj.jdbc.Driver");// Mysql의 버전이 8.0이므로 JDBC 이렇게 작성
	Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:33060/kopo10", "root", "kopoctc");
	// localhost : 서버 IP주소, 33060 : 포트번호, kopo10 : DB 이름, root : user, kopoctc : passwd 
	// getConnection 안의 url을 사용해서 DriverManager클래스의 getConnection 메소드를 호출
	Statement stmt = conn.createStatement(); // sql쿼리를 실행하기위한 객체 stmt 생성
	
	ResultSet rset1 = stmt.executeQuery("select id from gongji"); // 공지 테이블에서 id 출력
	List<Integer> idList = new ArrayList<Integer>(); // id담는 리스트
	while(rset1.next()) {
		idList.add(rset1.getInt(1)); // 리스트에 id 넣음
	}
	
	if (idList.contains(Integer.parseInt(ckey))) { // ckey가 idList에 포함되어있다면
	
	String Querytxt = String.format("select id, title, date, content from gongji where id= %d", Integer.parseInt(ckey)); // id가 ckey인 데이터 출력
	ResultSet rset2 = stmt.executeQuery(Querytxt); // 쿼리 실행
	int id = 0; // int변수 id = 0으로 초기화
	String title = ""; // String 변수 title = ""으로 초기화
	String date = ""; // String변수 date = ""으로 초기화
	String content = ""; // String변수 content = ""으로 초기화
%>
<form method="post"> <%-- 데이터 전달하는 form태그 --%>
	<table>
		<%
			while(rset2.next()) {
				id = rset2.getInt(1); // id 
				title = rset2.getString(2); // title
				date = rset2.getString(3); // date
				content = rset2.getString(4); // content
		%>
				<tr>
					<td>번호</td> <%-- 번호 --%>
					<td><%=id%><input type="hidden" name="id" value="<%=id%>"></td> <%-- 번호 출력 --%>
				</tr>
				<tr>
					<td>제목</td> <%-- 제목 --%>
					<td><%=title%></td> <%-- 제목 출력 --%>
				</tr>
				<tr>
					<td>일자</td> <%-- 일자 --%>
					<td><%=date%></td> <%-- 일자 출력 --%>
				</tr>
				<tr>
					<td>내용</td> <%-- 내용 --%>
					 <%-- 내용 출력 --%>
					<td><textarea name="updateContent" maxlength="600" rows="20" cols="70" style="overflow: auto; border: none; resize: none;" readonly><%=content%></textarea></td>
				</tr>
		<%
			}
		conn.close(); // 리소스 누설 방지
	    stmt.close(); // 리소스 누설 방지
		%>
	</table>
	<table id="down">
		<tr>
			<td style = "border:0px; text-align:right;">
				<input type="submit" value="목록" formaction="gongji_list.jsp"> <%-- 목록버튼, 누르면 gongji_list에 데이터 전달 --%>
				<input type="submit" value="수정" formaction="gongji_update.jsp"> <%-- 수정버튼, 누르면 gongji_update에 데이터 전달 --%>
			</td>
		</tr>
	</table>
</form>
<%
	} else { // idList가 ckey를 포함하지 않는다면
%>
	<form method="post" action="gongji_list.jsp">
		<div><p style="text-align:center;">데이터가 일치하지 않습니다.</p></div> <%-- 안내문구 출력 --%>
		<div style="text-align:center;"><input type="submit" value="게시판으로 이동"></div> <%-- 뒤로가기 버튼 --%>
	</form>
<%
	}
} catch (NumberFormatException e) { // 예외처리
%>
	<form method="post" action="gongji_list.jsp">
		<div><p style="text-align : center;">key 값이 비어있거나 key값에 정수가 들어오지 않았습니다.</p></div> <%-- 에러발생시 에러처리 --%>
		<div style="text-align:center;"><input type="submit" value="게시판으로 이동"></div> <%-- 게시판 이동 버튼 --%>
	</form>
<%
}
%>
</body>
</html>