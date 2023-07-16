<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Message</title>
</head>

<body>
<c:if test="${message != null }">
<h3 style="color:aqua">${message}
</h3> 
</c:if>
<c:if test="${errorMessage != null}">
	<h3 style="color:red">${errorMessage}</h3>
</c:if>
</body>
</html>