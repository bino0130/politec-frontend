<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, javax.sql.*,java.io.*,java.util.*, java.text.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>상품 상세페이지</title>
<style>
table {
	width: 600px;
	height: 600px;
	border: 1px solid black;
	border-collapse: collapse;
}

td {
	border: 1px solid black;
	padding-left: 15px;
}

.two {
	width : 20%;
}
</style>
</head>
<body>
<%
	//gongji_insert로부터 "autoId"를 parameter로 받는 int형 변수 autoId 생성
	request.setCharacterEncoding("utf-8"); // 인코딩 utf-8로 설정
	int ckey = Integer.parseInt(request.getParameter("key")); // "key"를 parameter로 받는 String변수 ckey 생성
	
	Class.forName("com.mysql.cj.jdbc.Driver");// Mysql의 버전이 8.0이므로 JDBC 이렇게 작성
	Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:33060/kopo10", "root", "kopoctc");
	// localhost : 서버 IP주소, 33060 : 포트번호, kopo10 : DB 이름, root : user, kopoctc : passwd 
	// getConnection 안의 url을 사용해서 DriverManager클래스의 getConnection 메소드를 호출
	Statement stmt = conn.createStatement(); // sql쿼리를 실행하기위한 객체 stmt 생성
	
	String Querytxt = String.format("select * from product where id = %d", ckey);
	ResultSet rset = stmt.executeQuery(Querytxt);
	
	int itemNum = 0;
	String itemName = "";
	int itemCount = 0;
	String itemCheckDate = "";
	String itemRegiDate = "";
	String itemContent = "";
	String imgUrl = "";
	
	while(rset.next()) {
		itemNum = rset.getInt(1);
		itemName = rset.getString(2);
		itemCount = rset.getInt(3);
		itemCheckDate = rset.getString(4);
		itemRegiDate = rset.getString(5);
		itemContent = rset.getString(6);
		imgUrl = rset.getString(7);
	}
%>
<form method="post">
			<table style="margin-top:30px; margin-left:75px;">
				<tr>
					<td class="two" style="height:15px;">상품 번호</td>
					<td><%=itemNum%><input type="hidden" name="id" value="<%=itemNum%>"></td>
				</tr>
				<tr>
					<td class="two" style="height:15px;">상품명</td>
					<td><%=itemName%></td>
				</tr>
				<tr>
					<td class="two" style="height:15px;">재고 현황</td>
					<td><p><%=itemCount%></p></td>
				</tr>
				<tr>
					<td class="two" style="height:15px;">상품등록일</td>
					<td><p><%=itemCheckDate%></p></td>
				</tr>
				<tr>
					<td class="two" style="height:15px;">재고등록일</td>
					<td><p><%=itemRegiDate%></p></td>
				</tr>
				<tr>
					<td class="two" style="height: 15px;">상품설명</td>
					<td><p><%=itemContent%></p></td>
				</tr>
				<tr>
					<td class="two">상품사진</td>
					<td><div class="image-container">
    					<img style="width: 300px;" id="photo" src="<%=imgUrl%>">
					</div></td>
				</tr>
				<%
				conn.close();
		    	stmt.close();
				%>
			</table>
			<table style="height:30px; border:0px; margin-top:30px; margin-left:75px;">
				<tr>
					<td style="border:0px; text-align:right;">
						<input type="submit" value='상품삭제' formaction="product_delete.jsp">
						<input type="submit" value="재고 수정" formaction="product_update.jsp">
					</td>
				</tr>
			</table>
		</form>
</body>
</html>