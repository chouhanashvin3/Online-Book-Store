<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
    <jsp:include page="Header.jsp"></jsp:include>
	<jsp:include page="Messages.jsp"></jsp:include>
	<h1 style="color:white">Upload Image</h1>
	<%
		String bookId=request.getParameter("bookId");
		session.setAttribute("bookId",bookId);
	%>
	<form method="post" action="ImageServlet" enctype="multipart/form-data" >
	
	<label >Image</label>
	<input type="file" name="bookImage" id="bookImage" >
	<input type="submit" value="submit" >
	</form>
	
	
	
	
	
	<jsp:include page="Footer.jsp"></jsp:include>