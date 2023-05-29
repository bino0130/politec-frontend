<%-- 슬라이드 12-2 --%>
<%@ page contentType="text/html; charset=UTF-8" %> <%-- 선언 --%>

<html>
<head>
<%
String call1() {
    String a = "abc";
    String b = "efg";
    return a + b;
}
int call2() {
	int a = 1;
	int b = 2;
	return a + b;
}
%>

</head>
<body>
String 연산 : <%= call1() %> <br>
Integer 연산 : <%= call2() %> <br>
Good...
</body>
</html>