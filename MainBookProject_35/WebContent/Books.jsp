<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<jsp:include page="Header.jsp"></jsp:include>
<jsp:include page="Messages.jsp"></jsp:include>
<jsp:include page="LeftSideMenu.jsp"></jsp:include>
<table>

<thead>
<tr>
<th>Book Image</th>
<th>Book Name</th>
<th>Author</th>
<th>Publisher</th>
<th>Category</th>
<th>Description</th>
<th>Price</th>
<th>Action</th>
</tr>
</thead>
<tbody>
<c:forEach var="book" items="${bookList}">
<tr>
	<td><img src="images/${book.bookImage }" height="200" width="200"/>
	<td>${book.bookName}</td>
	<td>${book.author}</td>
	<td>${book.publisher}</td>
	<td>${book.category}</td>
	<td>${book.description}</td>
	<td> &#8377;${book.price}</td>
	<td><a href="CartServletController?action=addToCart&bookId=${book.bookId}" title="Add to Cart" ><i class="bi bi-cart"></i></a></td>
	</c:forEach>
</tr>				
</tbody>
	</table>
<jsp:include page="Footer.jsp"></jsp:include>