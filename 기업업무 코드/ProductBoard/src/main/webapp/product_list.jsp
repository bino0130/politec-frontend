<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, javax.sql.*,java.io.*,java.util.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>공지사항 리스트 페이지</title>
<style>
table {
	width: 600px;
	border: 1px solid black;
	border-collapse: collapse;
}

td {
	border: 1px solid black;
}

.one {
	width: 10%;
	text-align: center;
}

.seven {
	width: 70%;
}

.two {
	width: 20%;
	text-align: center;
}


div{
	position: relative;/* 부모요소에 relative */
	width:100%; height:20%;
}
p {
	position: absolute;left: 50%;top: 50%;
	transform: translate(-50%,-50%) /* 자식요소에 translate 값 주기*/
}

</style>
</head>
<body>
<div style="width:800px; height:800px; border:1px solid black; border-collapse:collapse;">
	<div id="twice" style="width:100%;  border:1px solid black;"><p>(주)트와이스 재고 현황 - 전체현황</p></div>
	<div style="width:100%; height:80%;">
		<%
		Class.forName("com.mysql.cj.jdbc.Driver");// Mysql의 버전이 8.0이므로 JDBC 이렇게 작성
		Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:33060/kopo10", "root", "kopoctc");
		// localhost : 서버 IP주소, 33060 : 포트번호, kopo10 : DB 이름, root : user, kopoctc : passwd 
		// getConnection 안의 url을 사용해서 DriverManager클래스의 getConnection 메소드를 호출
		Statement stmt = conn.createStatement(); // sql쿼리를 실행하기위한 객체 stmt 생성

		ResultSet rset = stmt.executeQuery("select * from product");
		%>
		<form method="post">
			<table>
				<tr>
					<td>상품번호</td>
					<td>상품명</td>
					<td>현재 재고수</td>
					<td>재고 파악일</td>
					<td>상품 등록일</td>
				</tr>

				<%
				int id = 0;
				String title = "";
				int productCount = 0;
				String checkDate = "";
				String registerDate = "";
				while (rset.next()) {
					id = rset.getInt(1);
					title = rset.getString(2);
					productCount = rset.getInt(3);
					checkDate = rset.getString(4);
					registerDate = rset.getString(5);
				%>
				<tr>
					<td><%=id%></td>
					<td><a href='product_view.jsp?key=<%=id%>'><%=title%></a></td>
					<td><%=productCount%></td>
					<td><%=checkDate%></td>
					<td><%=registerDate%></td>
				</tr>
				<%
				}
				conn.close();
		    	stmt.close();
				%>
			</table>
			<table style="border:0px">
				<tr><td style="border:0px; text-align:right;"><input type="submit" value='신규등록' formaction="gongji_insert.jsp"></td></tr>
			</table>
		</form>
	</div>
</div>
</body>
</html>