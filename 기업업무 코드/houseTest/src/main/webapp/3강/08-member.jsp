<%@ page contentType="text/html; charset=UTF-8" %> <%-- 한글처리1 --%>
<%
    String name = request.getParameter("username"); // username을 parameter로 받는 String name
    String password = request.getParameter("userpasswd"); // userpasswd를 변수로 받는 String password
%>
<html>
<head>
    <title>로그인</title>
</head>
<body>
    이름:<%=name%><br>  <!-- 이름 : name -->
    비밀번호:<%=password%><br> <!-- 비밀번호 : password -->
</body>
</html>