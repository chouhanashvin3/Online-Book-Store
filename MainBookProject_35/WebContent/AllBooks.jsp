<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<jsp:include page="Header.jsp"></jsp:include>
<jsp:include page="Messages.jsp"></jsp:include>
<h1 style ="color:white">All Books</h1>
<a href="BookServletController?action=addBook" class="btn btn-light" style="text-align: right">Add Book</a>
<table class="table table-dark">

<thead>
<tr>
<th>Book Image</th>
<th>Book Name</th>
<th>Author</th>
<th>Publisher</th>
<th>Category</th>
<th>Description</th>
<th>Price</th>
<th>Books In Stock</th>
<th>Action</th>
</tr>
</thead>
<tbody>
<c:forEach var="book" items="${bookList}">
<tr>
	<td><img src="images/${book.bookImage }" height="90px" width="70px"/>
	<td>${book.bookName}</td>
	<td>${book.author}</td>
	<td>${book.publisher}</td>
	<td>${book.category}</td>
	<td>${book.description}</td>
	<td> &#8377;${book.price}</td>
	<td>${book.quantityOfAvailableBooks}</td>
	<c:if test="${admin != null && customer == null }">
	
	<td><a href="BookServletController?action=updateBook&bookId=${book.bookId}"
		 	title="Update Book" ><i class="bi bi-pencil"></i></a>
		<a href="BookServletController?action=deleteBook&bookId=${book.bookId}" 
			title="Delete Book" onclick="return confirm('Are you sure you want to delete this book?')"><i class="bi bi-x"></i></a>
		<a href="BookServletController?action=updateImage&bookId=${book.bookId}" 
			title="Update Image" ><i class="bi bi-images"></i></a>
	</td>
	</c:if>
	</tr>
	</c:forEach>
				
</tbody>
	</table>
<jsp:include page="Footer.jsp"></jsp:include>