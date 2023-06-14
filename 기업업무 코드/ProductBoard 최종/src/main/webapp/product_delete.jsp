<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, javax.sql.*,java.io.*,java.util.*, java.text.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상품 삭제</title>
<style>
table { /* table태그에 css 적용 */
	border-collapse : collapse;
	border : 1px solid black;
	width : 500px;
	height : 400px;
	margin : auto;
}

td { /* td태그에 css 적용 */
	border : 1px solid black;
}
</style>
</head>
<body>
<%
	//product_insert로부터 "autoId"를 parameter로 받는 int형 변수 autoId 생성
	request.setCharacterEncoding("utf-8"); // 인코딩 utf-8로 설정
	String ckey = request.getParameter("key"); // "key"를 parameter로 받는 String변수 ckey 생성
	String itemName = request.getParameter("itemName"); // "itemName"을 parameter로 받는 String변수 itemName 생성
	itemName = itemName.replace("&","&amp;").replace("<", "&lt;").replace(">", "&gt;"); // &, <, > 문자 대체

	Class.forName("com.mysql.cj.jdbc.Driver");// Mysql의 버전이 8.0이므로 JDBC 이렇게 작성
	Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:33060/kopo10", "root", "kopoctc");
	// localhost : 서버 IP주소, 33060 : 포트번호, kopo10 : DB 이름, root : user, kopoctc : passwd 
	// getConnection 안의 url을 사용해서 DriverManager클래스의 getConnection 메소드를 호출
	Statement stmt = conn.createStatement(); // sql쿼리를 실행하기위한 객체 stmt 생성
	
	String Querytxt = String.format("delete from product where id = '%s'", ckey); // product테이블의 id가 ckey인 데이터 삭제
	stmt.executeUpdate(Querytxt); // 쿼리 실행
%>
<form method="post" action="product_list.jsp"> <%-- product_list에 값을 전달하는 form태그 --%>
	<table>
		<tr>
			<td style="height : 10%;"><p style="text-align : center; font-weight: 600;">(주)트와이스 재고 현황 - 상품삭제</p></td> <%-- 상품삭제 --%>
		</tr>
		<tr>
			<td style="text-align : center;">
				<div style="margin-bottom : 10px; font-weight: 600;"><%=ckey%>번 <%=itemName%> 상품이 삭제되었습니다.</div> <%-- 안내문구 출력 --%>
				<input type="submit" value="재고현황"> <%-- 재고현황 버튼 --%>
			</td>
		</tr>
	</table>
</form>
</body>
</html>