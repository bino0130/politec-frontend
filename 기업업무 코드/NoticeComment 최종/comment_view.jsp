<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, javax.sql.*,java.io.*,java.util.*,java.text.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>선택된 공지사항 출력 페이지</title>
<style>
	table { /* table태그에 css 적용 */
		width : 600px;
		height : 300px;
		border : 1px solid black;
		border-collapse : collapse;
		margin : auto;
	}
	
	td { /* td태그에 css 적용 */
		border : 1px solid black;
	}
	
	.one { /* class가 three인 태그에 css 적용 */
		width : 13%;
		height : 30px;
		text-align : center;
	}
	
	.nine { /* class가 seven인 태그에 css 적용 */
		width : 87%;
	}

	.submit { /* class가 submit인 태그에 css 적용 */
		background-color : skyblue;
		border-color : skyblue;
		border-radius : 5px;
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
	request.setCharacterEncoding("utf-8"); // 인코딩 utf-8로 설정
	String ckey = request.getParameter("key"); // "key"를 parameter로 받는 String변수 ckey 생성
	
	Class.forName("com.mysql.cj.jdbc.Driver");// Mysql의 버전이 8.0이므로 JDBC 이렇게 작성
	Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/kopo10", "root", "kopoctc");
	// localhost : 서버 IP주소, 33060 : 포트번호, kopo10 : DB 이름, root : user, kopoctc : passwd 
	// getConnection 안의 url을 사용해서 DriverManager클래스의 getConnection 메소드를 호출
	Statement stmt = conn.createStatement(); // sql쿼리를 실행하기위한 객체 stmt 생성
	
	ResultSet rset1 = stmt.executeQuery("select id from comment"); // comment 테이블에서 id 출력하는 쿼리
	List<Integer> idList = new ArrayList<Integer>(); // id 담는 리스트 idList
	while(rset1.next()) {
		idList.add(rset1.getInt(1)); // idList에 id값 넣음
	}
	
	if (idList.contains(Integer.parseInt(ckey))) { // idList가 ckey를 포함한다면
	
	String Querytxt = String.format("select * from comment where id= %d", Integer.parseInt(ckey)); // id가 ckey인 comment테이블의 데이터 출력
	ResultSet rset2 = stmt.executeQuery(Querytxt); // 쿼리 실행
	int id = 0; // int형 변수 id = 0으로 초기화
	String title = ""; // String 변수 title = ""로 초기화
	String date = ""; // String 변수 date = ""로 초기화
	String content = ""; // String 변수 content = ""로 초기화
	int rootid = 0; // int형 변수 rootid = 0으로 초기화
	int relevel = 0; // int형 변수 relevel = 0으로 초기화
	int recnt = 0; // int형 변수 recnt = 0으로 초기화
	int viewcnt = 0; // int형 변수 viewcnt = 0으로 초기화
%>
<form method="post"> <%-- 데이터를 전달하는 form 태그 --%>
	<table>
		<%
			while(rset2.next()) {
				id = rset2.getInt(1); // id에 값 대입
				title = rset2.getString(2); // title에 값 대입
				date = rset2.getString(3); // date에 값 대입
				content = rset2.getString(4); // content에 값 대입
				rootid = rset2.getInt(5); // rootid에 값 대입
				relevel = rset2.getInt(6); // relevel에 값 대입
				recnt = rset2.getInt(7); // recnt에 값 대입
				viewcnt = rset2.getInt(8) + 1; // viewcnt에 값 대입
		%>
				<tr>
					<td class="one" style="background-color : skyblue;">번호</td> <%-- 번호 --%>
					<td class="nine"><%=id%><input type="hidden" name="id" value="<%=id%>"></td> <%-- 번호 출력, 값 전달하기 위해 input hidden 사용 --%>
				</tr>
				<tr>
					<td class="one" style="background-color : skyblue;">제목</td> <%-- 제목 --%>
					<td class="nine"><%=title%><input type="hidden" name="title" value="<%=title%>"></td> <%-- 제목 출력, 값 전달하기 위해 input hidden 사용 --%>
				</tr>
				<tr>
					<td class="one" style="background-color : skyblue;">조회수</td> <%-- 조회수 --%>
					<td class="nine"><%=viewcnt%></td> <%-- 조회수 출력 --%>
				</tr>
				<tr>
					<td class="one" style="background-color : skyblue;">일자</td> <%-- 일자 --%>
					<td class="nine"><%=date%></td> <%-- 일자 출력 --%>
				</tr>
				<tr>
					<td class="one" style="background-color : skyblue;">내용</td> <%-- 내용 --%>
						 <%-- 내용 출력 --%>
					<td class="nine"><textarea name="updateContent" maxlength="600" rows="20" cols="70" style="overflow: auto; border: none; resize: none;" readonly><%=content%></textarea></td>
				</tr>
				<tr>
					<td class="one" style="background-color : skyblue;">원글</td> <%-- 원글 --%>
					<td class="nine"><%=rootid%><input type="hidden" name="rootid" value="<%=rootid%>"></td> <%-- 원글 id 출력, 값 전달하기 위해 input hidden 사용 --%>
				</tr>
				<tr>
					<td class="one" style="background-color : skyblue;">댓글 레벨</td> <%-- 댓글 레벨 --%>
					<td class="nine"><span style="width:100px; display:inline-block;"><%=relevel%><input type="hidden" name="relevel" value="<%=relevel%>"></span> <%-- 댓글 레벨 출력 --%>
						<span>댓글 내 순서 : <%=recnt%><input type="hidden" name="recnt" value="<%=recnt%>"></span> <%-- 댓글 내 순서 출력 --%>
					</td>
				</tr>
		<%
			}
			String Querytxt2 = String.format("update comment set viewcnt=%d where id=%d", viewcnt, id); // comment테이블의 id가 id인 viewcnt를 viewcnt로 업그레이드 해주는 쿼리
			stmt.executeUpdate(Querytxt2); // 쿼리 실행

			conn.close(); // 리소스 누설 방지
	    	stmt.close(); // 리소스 누설 방지
		%>
	</table>
	<table id="down">
		<tr>
			<td style = "border:0px; text-align:right;"> <%-- 오른쪽 정렬 --%>
				<input class="submit" type="submit" value="목록" formaction="comment_list.jsp"> <%-- 목록버튼, comment_list에 값 전달 --%>
				<input class="submit" type="submit" value="수정" formaction="comment_update.jsp"> <%-- 수정버튼, comment_update에 값 전달 --%>
				<input class="submit" type="submit" value="삭제" formaction="comment_delete.jsp"> <%-- 삭제버튼, comment_delete에 값 전달 --%>
				<input class="submit" type="submit" value="댓글" formaction="comment_reinsert.jsp"> <%-- 댓글버튼, comment_reinsert에 값 전달 --%>
			</td>
		</tr>
	</table>
</form>
<%
	} else { // idList가 ckey를 포함하지 않으면
%>
	<form method="post" action="product_list.jsp"> <%-- product_list에 값을 전달하는 form태그 --%>
		<div><p style="text-align:center;">데이터가 일치하지 않습니다.</p></div> <%-- 안내문구 출력 --%>
		<div style="text-align:center;"><input type="submit" value="게시판으로 이동"></div> <%-- 게시판 이동 버튼 --%>
	</form>
<%
	}
} catch (NumberFormatException e) { // 에러 발생시
%>
	<form method="post" action="product_list.jsp"> <%-- product_list에 값을 전달하는 form태그 --%>
		<div><p style="text-align : center;">key 값이 비어있거나 key값에 정수가 들어오지 않았습니다.</p></div> <%-- 안내문구 출력` --%>
		<div style="text-align:center;"><input type="submit" value="게시판으로 이동"></div> <%-- 게시판 이동 버튼 --%>
	</form>
<%
}
%>
</body>
</html>