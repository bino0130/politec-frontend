<%-- 슬라이드 12-1 --%>
<%@ page contentType="text/html; charset=UTF-8" %> <%-- 선언 --%>
<html>
<head>
<script>
function call1() { // 함수 call1 생성
    var a = "abc"; // var a = "abc"
    var b = "efg"; // var b = "efg"
    document.write("String연산 : " + (a + b)); // String연산 : abcefg 출력
}
function call2() {
    var a = 1; // var a : 1
    var b = 2; // var b : 2
    document.write("Integer연산 : " + (a + b)); // Integer연산 : 3 출력
}
</script>
</head>
<script>call1();</script> <%-- call1 출력 --%>
<script>call2();</script> <%-- call2 출력 --%>
Good...
</body>
</html>