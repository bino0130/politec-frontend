<%@ page contentType="text/html; charset=UTF-8" %> <%-- 한글처리1 --%>
<% request.setCharacterSetEncoding("utf-8");%> <%--한글처리2--%>
<html>
<head>
</head>
<body>
    <form method="get"> <%-- get 방식은 주소창에 표시됨 --%>
        <input name="key1" type="text"/>
        <input name="key2" type="text"/>
        <input name="submit" type="submit"/>
    </form>
    <form method="post">
    <%-- post 방식은 개발자 도구 → 네트워크 → 페이로드에 표시됨 --%>
        <input name="key1" type="text"/>
        <input name="key2" type="text"/>
        <input name="submit" type="submit"/>
    </form>
</body>
</html>