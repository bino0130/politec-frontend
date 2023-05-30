<%-- 슬라이드 13 실습 --%>
<%@ page contentType="text/html; charset=UTF-8" %> <%-- 선언 --%>
<html>
<head>
<%!
private class AA{ // class AA 생성
    private int Sum(int i, int j) { // method Sum 생성
        return i+j; // i+j 리턴
    }
}
AA aa=new AA(); // AA 객체 aa 생성
%>
</head>
<body>
<%out.println("2+3="+aa.Sum(2,3));%> <br> <!--  Sum(2,3) 결과 출력 -->
Good...
</body>
</html>