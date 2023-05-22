<%-- 슬라이드 12-2 --%>
<%@ page contentType="text/html; charset=UTF-8" %> <%-- 선언 --%>
<html>
<head>
<%
private String call1() {
    String a = "abc";
    String b = "efg";
    return (a+b);
}
private Integer call2() {
    Integer a = 1;
    Integer b = 2;
    return (a+b);
}
%>
</head>
<body>
String 연산 : <%=call1()%> <br>
Integer 연산 : <%=call2()%> <br>
Good...
</body>
</html>