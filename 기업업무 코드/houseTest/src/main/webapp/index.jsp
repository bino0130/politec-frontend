<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
</head>
<body>
	<div style="display: flex; width: 100%;"> <!-- div 태그에 display : flex, width : 100% 적용 -->
        <iframe src="./menu.html" style="height: 100vh; width: 30%; border: 0;"> <!-- menu.html을 출력하고 높이는 100vh, 너비는 30% -->
            aaa</iframe>
        <iframe src="./intro.jsp" name="content" style="width: 1000px;  height: 100vh; flex-grow: 1;
        border: 0;">bbb</iframe> <!-- intro.jsp를 출력하고 너비는 1000px, 높이는 100vh -->
    </div>
    <!-- 큰 틀에서 한 쪽 구역은 menu.html을, 다른 한 쪽에서는 intro.html을 호출하다가 
        menu.html에서 하이퍼링크를 클릭 시 name이 content인 링크를 호출하는 
        iframe(중첩 브라우징)을 구현 -->
</body>
</html>