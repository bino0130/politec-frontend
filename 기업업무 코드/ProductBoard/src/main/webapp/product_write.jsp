<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, javax.sql.*,java.io.*,java.util.*, 
java.text.*, com.oreilly.servlet.MultipartRequest, com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>등록 완료</title>
</head>
<body>
<%
try {
	int sizeLimit = 100 * 500 * 500;
	String path = "./image";
	String directory = request.getServletContext().getRealPath(path);
	MultipartRequest multi = new MultipartRequest(request, directory, sizeLimit, "UTF-8", new DefaultFileRenamePolicy());
	
	//product_insert로부터 "newId"를 parameter로 받는 String 변수 id 생성
	request.setCharacterEncoding("utf-8"); // 인코딩 utf-8로 설정
	String newId = multi.getParameter("newId");
	
	//product_update로부터 "updateId"를 parameter로 받는 int형 변수 printId 생성
	String updateId = request.getParameter("updateId");

	Class.forName("com.mysql.cj.jdbc.Driver");// Mysql의 버전이 8.0이므로 JDBC 이렇게 작성
	Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:33060/kopo10", "root", "kopoctc");
	// localhost : 서버 IP주소, 33060 : 포트번호, kopo10 : DB 이름, root : user, kopoctc : passwd 
	// getConnection 안의 url을 사용해서 DriverManager클래스의 getConnection 메소드를 호출
	Statement stmt = conn.createStatement(); // sql쿼리를 실행하기위한 객체 stmt 생성
	
	if (updateId == null) {
		String file = multi.getFilesystemName("imgFile");
		String filename = multi.getFilesystemName("imgFile");
		
		int itemCount = Integer.parseInt(multi.getParameter("itemCount"));
		String itemName = multi.getParameter("itemName");
		String checkDay = multi.getParameter("checkDay");
		String itemDescribe = multi.getParameter("itemDescribe");
		
		out.println(newId);
		out.println(itemCount);
		out.println(itemName);
		out.println(checkDay);
		out.println(path);
		
		String Querytxt = String.format("insert into product values (%d, '%s', %d, '%s', '%s', '%s', '%s')"
		,Integer.parseInt(newId),itemName, itemCount, checkDay, checkDay, itemDescribe, "./"+filename);
		
		stmt.execute(Querytxt);
		
%>
<form method="post" action="product_list.jsp">
	<table>
		<tr>
			<td style="height : 20%;"><p style="text-align : center;">신규 상품 등록</p></td>
		</tr>
		<tr>
			<td style="text-align : center;"><div style="margin-bottom : 10px;">신규 상품이 등록되었습니다</div>
										<input type="submit" value="목록으로 이동"></td>
		</tr>
	</table>
</form>
<%
	} else if (updateId != null) {
		String updateTitle = request.getParameter("updateTitle");
		String updateContent = request.getParameter("updateContent");
		
		String Querytxt = String.format("update product set title='%s', content='%s' where id=%d"
										, updateTitle, updateContent, Integer.parseInt(updateId));
		stmt.executeUpdate(Querytxt);
		
%>
<form method="post" action="gongji_list.jsp">
	<table>
		<tr>
			<td style="height : 20%;"><p style="text-align : center;">상품 수정</p></td>
		</tr>
		<tr>
			<td style="text-align : center;"><div style="margin-bottom : 10px;">상품이 수정되었습니다.</div>
										<input type="submit" value="게시판으로 이동"></td>
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