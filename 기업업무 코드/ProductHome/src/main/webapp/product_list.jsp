<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, javax.sql.*,java.io.*,java.util.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>(주)트와이스 전체현황</title>
<style>
table {
	width: 600px;
	border: 1px solid black;
	border-collapse: collapse;
}

td {
	border: 1px solid black;
	padding-left: 15px;
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

#all {
	width : 800px;
	height : 800px;
	border : 1px solid black;
	border-collapse : collapse;
	margin-top : 30px;
	margin-left : 75px;
}

#twice {
	width : 100%;
	text-align : center;
	border-bottom : 1px solid black;
	font-weight : 600
}
</style>
</head>
<body>
<div id="all">
	<div id="twice"><p>(주)트와이스 재고 현황 - 전체현황</p></div>
	<div style="width:100%; height:80%;">
		<%
		Class.forName("com.mysql.cj.jdbc.Driver");// Mysql의 버전이 8.0이므로 JDBC 이렇게 작성
		Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/kopo10", "root", "kopoctc");
		// localhost : 서버 IP주소, 3306 : 포트번호, kopo10 : DB 이름, root : user, kopoctc : passwd 
		// getConnection 안의 url을 사용해서 DriverManager클래스의 getConnection 메소드를 호출
		Statement stmt = conn.createStatement(); // sql쿼리를 실행하기위한 객체 stmt 생성

		ResultSet rset = stmt.executeQuery("select * from product");
		%>
		<form method="post">
			<table style="margin-top:30px; margin-left:75px;">
				<tr>
					<td>상품번호</td>
					<td style="width: 150px;">상품명</td>
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
			<table style="border:0px; margin-top:10px; margin-left:75px;">
				<tr><td style="border:0px; text-align:right;"><input type="submit" value='신규등록' formaction="product_insert.jsp"></td></tr>
			</table>
		</form>
	</div>
</div>
</body>
</html>