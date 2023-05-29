<%-- 슬라이드 15 실습 --%>
<html>
<head>
</head>
<body>
<%
String arr[] = new String[]{"111", "222", "333"}; // String 배열 arr 초기화
String str = "abc, efg, hij"; // String 변수 str 초기화
String str_arr[] = str.split(","); // String 배열 str_arr = str을 ,를 기준으로 나눈 배열
%>
arr[0]:<%=arr[0]%> <br> <!-- arr[0] 출력 -->
arr[1]:<%=arr[1]%> <br> <!-- arr[1] 출력 -->
arr[2]:<%=arr[2]%> <br> <!-- arr[2] 출력 -->
str_arr[0]:<%=str_arr[0]%> <br> <!-- str_arr[0] 출력 -->
str_arr[1]:<%=str_arr[1]%> <br> <!-- str_arr[1] 출력 -->
str_arr[2]:<%=str_arr[2]%> <br> <!-- str_arr[2] 출력 -->
Good...
</body>
</html>