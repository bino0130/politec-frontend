<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, javax.sql.*,java.io.*,java.util.*, java.text.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상품 삭제</title>
<style>
table {
	border-collapse : collapse;
	border : 1px solid black;
	width : 500px;
	height : 400px;
	margin-top : 30px;
	margin-left : 75px;
}

td {
	border : 1px solid black;
}
</style>
</head>
<body>
<%
	//product_insert로부터 "autoId"를 parameter로 받는 int형 변수 autoId 생성
	request.setCharacterEncoding("utf-8"); // 인코딩 utf-8로 설정
	int ckey = Integer.parseInt(request.getParameter("key")); // "key"를 parameter로 받는 String변수 ckey 생성
	String itemName = request.getParameter("itemName");

	Class.forName("com.mysql.cj.jdbc.Driver");// Mysql의 버전이 8.0이므로 JDBC 이렇게 작성
	Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/kopo10", "root", "kopoctc");
	// localhost : 서버 IP주소, 33060 : 포트번호, kopo10 : DB 이름, root : user, kopoctc : passwd 
	// getConnection 안의 url을 사용해서 DriverManager클래스의 getConnection 메소드를 호출
	Statement stmt = conn.createStatement(); // sql쿼리를 실행하기위한 객체 stmt 생성
	
	String Querytxt = String.format("delete from product where id = %d", ckey);
	stmt.executeUpdate(Querytxt);
%>
<form method="post" action="product_list.jsp">
	<table>
		<tr>
			<td style="height : 10%;"><p style="text-align : center; font-weight: 600;">(주)트와이스 재고 현황 - 상품삭제</p></td>
		</tr>
		<tr>
			<td style="text-align : center;"><div style="margin-bottom : 10px; font-weight: 600;">[<%=itemName%>] 상품이 삭제되었습니다.</div>
										<input type="submit" value="재고현황"></td>
		</tr>
	</table>
</form>
</body>
</html>