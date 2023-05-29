<%-- 슬라이드 9-2 --%>
<%@ page import="java.sql.*" contentType="text/html; charset=EUC-KR" %> <%-- 선언 --%>
<!-- 원래 javax.mail.*, javax.mail.internet.*이 있지만 jsp파일에서는 사용할 수 없다고 나와서 지웠다. -->
<html>
<body>
    <% String myUrl = "http://www.kopo.ac.kr"; %> <%-- 폴리텍을 링크로 갖는 String 변수 myUrl 선언 --%>
    <a href="<%= myUrl %>">Hello</a> 안녕. <!--  Hello는 폴리텍을 링크로 갖는다. -->
</body>
</html>