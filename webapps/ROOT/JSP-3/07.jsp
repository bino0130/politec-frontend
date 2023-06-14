<%-- 슬라이드 17 - 1 실습 --%>
<%@ page errorPage = "error.jsp"%>
<html>
<head>
</head>
<body>
<%
String arr[] = new String[]{"111", "222", "333"}; // String배열 arr 초기화
try { // try catch
    out.println(arr[4] + "<br>"); // arr4 출력
} catch(Exception e) { // Exception e
    response.sendRedirect("error.jsp"); // error.jsp로 리다이렉트
}
%>
Good...
</body>
</html>