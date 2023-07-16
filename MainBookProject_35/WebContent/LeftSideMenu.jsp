<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import="java.util.Set" %>
    <%@ page import="com.book.daoImpl.BookDAOImpl"%>
    <%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link href="templatemo_style.css" rel="stylesheet" type="text/css" />
<title>Online Book Store</title>

</head>
<body>
<%
Set<String> categories=new BookDAOImpl().getAllCategories();
request.setAttribute("categories", categories);
Set<String> authors=new BookDAOImpl().getAllAuthors();
request.setAttribute("authors", authors);
%>
	<div id="templatemo_content_left">
		<div class="templatemo_content_left_section">
			<h1>Categories</h1>
			<ul>
			<c:forEach items="${categories}" var="c">
				<li><a href="BookServletController?action=viewBookByCategory&category=${c}"><c:out value="${c}"></c:out></a></li>
			</c:forEach>
			</ul>
		</div>
		<div class="templatemo_content_left_section">
			<h1>Authors</h1>
			<ul>
				<c:forEach items="${authors}" var="a">
				     <li><a href="BookServletController?action=viewBookByAuthor&author=${a}"><c:out value="${a}"></c:out></a></li>
			    </c:forEach>
			</ul>
		</div>
	</div>
	
</body>
</html>