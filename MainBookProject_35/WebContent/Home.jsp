<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<jsp:include page="Header.jsp"></jsp:include>
<jsp:include page="Messages.jsp"></jsp:include>
<jsp:include page="LeftSideMenu.jsp"></jsp:include>

<sql:setDataSource var="connection" driver="com.mysql.jdbc.Driver"
		url="jdbc:mysql://localhost:3306/BookStoreDB_CTOL35" user="root"
		password="root"></sql:setDataSource>

<sql:query var="result" scope="application" dataSource="${connection}">
 		select * from book;
 	</sql:query>

		<c:if test="${result ne null }">
			<c:forEach var="book" items="${result.rows}">
				<div class="templatemo_product_box" style="margin-left: 30px">
				<h4>${book.bookName }</h4>
					<img src="images/${book.bookImage }" height="200px" width="150px"/>
					
					<div class="product_info">
					<b>${book.description }</b><br>
					<h4>&#8377;${book.price }</h4>
					<div class="buy_now_button">
					<a href="CartServletController?action=addToCart&bookId=${book.bookId}" title="Add to Cart">Add to Cart</a>
				</div>
				<div class="detail_button">
				<a href="BookServletController?action=viewBookDetails&bookId=${book.bookId}">Detail</a>
				</div>
				</div>
				</div>
				<div class="cleaner">&nbsp;</div>
			</c:forEach></c:if>
		
	
<jsp:include page="Footer.jsp"></jsp:include>