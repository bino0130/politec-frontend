<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, javax.sql.*,java.io.*,java.util.*, 
java.text.*, com.oreilly.servlet.MultipartRequest, com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>등록 완료</title>
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
try {
	//product_update로부터 "updateId"를 parameter로 받는 int형 변수 printId 생성
	String updateId = request.getParameter("updateId");

	Class.forName("com.mysql.cj.jdbc.Driver");// Mysql의 버전이 8.0이므로 JDBC 이렇게 작성
	Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/kopo10", "root", "kopoctc");
	// localhost : 서버 IP주소, 33060 : 포트번호, kopo10 : DB 이름, root : user, kopoctc : passwd 
	// getConnection 안의 url을 사용해서 DriverManager클래스의 getConnection 메소드를 호출
	Statement stmt = conn.createStatement(); // sql쿼리를 실행하기위한 객체 stmt 생성
	
	if (updateId == null) {
		int sizeLimit = 100 * 500 * 500;
		String path = "./image";
		String directory = request.getServletContext().getRealPath(path);
		MultipartRequest multi = new MultipartRequest(request, directory, sizeLimit, "UTF-8", new DefaultFileRenamePolicy());
		
		//product_insert로부터 "newId"를 parameter로 받는 String 변수 id 생성
		String newId = multi.getParameter("newId");
		
		String file = multi.getFilesystemName("imgFile");
		String filename = multi.getFilesystemName("imgFile");
		
		int itemCount = Integer.parseInt(multi.getParameter("itemCount"));
		String itemName = multi.getParameter("itemName");
		String checkDay = multi.getParameter("checkDay");
		String itemDescribe = multi.getParameter("itemDescribe");
		
		String Querytxt = String.format("insert into product values (%d, '%s', %d, '%s', '%s', '%s', '%s')"
		,Integer.parseInt(newId),itemName, itemCount, checkDay, checkDay, itemDescribe, "./"+filename);
		
		stmt.execute(Querytxt);
		
%>
<form method="post" action="product_list.jsp">
	<table>
		<tr>
			<td style="height : 10%;"><p style="text-align : center; font-weight: 600;">신규 상품 등록</p></td>
		</tr>
		<tr>
			<td style="text-align : center;"><div style="margin-bottom : 10px; font-weight: 600;"><%=newId%>번 신규 상품 <%=itemName%>이(가) 등록되었습니다</div>
										<input type="submit" value="재고 현황"></td>
		</tr>
	</table>
</form>
<%
	} else if (updateId != null) {
		String updateCount = request.getParameter("updateCount");
		String updateCheckDate = request.getParameter("updateCheckDate");
		String updateRegiDate = request.getParameter("updateRegiDate");
		String updateItemName = request.getParameter("updateName");
		
		String Querytxt = String.format("update product set num=%d, checkDate='%s', registerDate='%s' where id=%d"
								, Integer.parseInt(updateCount), updateCheckDate, updateRegiDate, Integer.parseInt(updateId));
		stmt.executeUpdate(Querytxt);
		
%>
<form method="post" action="product_list.jsp">
	<table>
		<tr>
			<td style="height : 10%;"><p style="text-align : center;">상품 수정</p></td>
		</tr>
		<tr>
			<td style="text-align : center;"><div style="margin-bottom : 10px; font-weight: 600;"><%=updateId%>번 상품 <%=updateItemName%>이(가) 수정되었습니다.</div>
										<input type="submit" value="재고 현황"></td>
		</tr>
	</table>
</form>
<%
	}
	conn.close();
    stmt.close();
} catch(SQLIntegrityConstraintViolationException e) {
	out.println("중복된 아이디는 사용하실 수 없습니다.");
}
%>
</body>
</html>