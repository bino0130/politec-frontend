<%-- 슬라이드 14 실습 --%>
<%@ page contentType="text/html; charset=UTF-8" %> <%-- 선언 --%>
<html>
<head>
<%!
String str = "abcdfeffasdsd"; // String타입 변수 str 선언
int str_len = str.length(); // Int 타입 변수 str_len = str의 길이
String str_sub = str.substring(5); // String타입 변수 str.sub = str의 5번째 인덱스
int str_loc = str.indexOf("cd"); // int타입 변수 str_loc = "cd"의 인덱스
String strL = str.toLowerCase(); // String타입 변수 strL = str의 소문자버전
String strU = str.toUpperCase(); // String 타입 변수 strU = str의 대문자버전
%>
</head>
<body>
Str:<%=str%> <br> <!-- Str 출력 -->
str_len:<%=str_len%> <br> <!-- Str_len 출력 -->
str_sub:<%=str_sub%> <br> <!-- Str-sub 출력 -->
str_loc:<%=str_loc%> <br> <!-- Str-loc 출력 -->
strL:<%=strL%> <br> <!-- StrL 출력 -->
strU : <%=strU%> <br> <!-- StrU 출력 -->
Good...
</body>
</html>