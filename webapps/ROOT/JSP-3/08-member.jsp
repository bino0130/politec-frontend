<%@ page contentType="text/html; charset=UTF-8" %> <%-- 한글처리1 --%>
<%
    request.setCharacterEncoding("utf-8");
    String name = request.getParameter("username"); // input받은 username 값 변수에 저장
    String password = request.getParameter("userpasswd"); // input받은 userpasswd 값 변수에 저장
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