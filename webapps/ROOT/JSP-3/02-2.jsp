<%-- 슬라이드 12-2 --%>
<%@ page contentType="text/html; charset=UTF-8" %> <%-- 선언 --%>

<html>
<head>
<%!
String call1() { // java형태 함수 선언
    String a = "abc"; // String a = "abc"
    String b = "efg"; // String b = "efg"
    return a + b; // abcefg
}
int call2() { // int타입을 리턴하는 함수 call2
	int a = 1; // int a=1
	int b = 2; // int b=2
	return a + b; // 3 
}
%>
</head>
<body>
String 연산 : <%=call1()%> <br> <%-- String연산 : call1()호출 --%>
int 연산 : <%=call2()%> <br> <%-- Int연산 : call2()호출 --%>
Good...
</body>
</html>