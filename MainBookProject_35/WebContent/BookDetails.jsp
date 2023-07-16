<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:include page="Header.jsp"></jsp:include>
<jsp:include page="Messages.jsp"></jsp:include>
<jsp:include page="LeftSideMenu.jsp"></jsp:include>
<h1 style="color:white">Book Details :</h1>
<div class="templatemo_product_box">

<h2>${bookDetail.bookName}</h2>
<img src="images/${bookDetail.bookImage }" height="100px" width="80px"/>
	<div class="product_info">
		<h3>ISBN :</h3> ${bookDetail.isbn}
		<h3> ${bookDetail.description}</h3>
		<h3>Author :</h3> ${bookDetail.author}
		<h3>Publisher :</h3> ${bookDetail.publisher}
		<h3>&#8377; ${bookDetail.price}</h3>
		<h3>Book Rating :</h3> ${bookDetail.bookRating}

<div class="buy-now_button">
<a href="CartServletController?action=addToCart&bookId=${bookDetail.bookId}" title="Add to Cart"">Add to cart</a>
</div>
<div class="detail_button">
<a href="Home.jsp">cancel</a>
</div>
</div>
</div>
<div class="cleaner">&nbsp;</div>
<jsp:include page="Footer.jsp"></jsp:include>