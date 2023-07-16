<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<jsp:include page="Header.jsp"></jsp:include>
<jsp:include page="Messages.jsp"></jsp:include>

<script type="text/javascript">
	$(function() {
		billing();
	});
	function billing() {
		var netPriceList = $(".totalNetPrice");
		var total = 0;
		for (var i = 0; i < netPriceList.length; i++) {
			total = total + parseInt(netPriceList[i].value);
		}
		$("#totalCost").val(total);
	}
	function calculateNetPrice(element) {
		var q = parseInt(element.value);
		var p = parseInt(element.previousSibling.value);
		if(q < 1){
			element.value=1;
			q =1;
		}
		var netPrice = q * p ;
		element.nextSibling.value = netPrice;
		var cartId = element.id;
		
		$.post("CartServletController",{
			"quantity":q,
			"cartId":cartId,
			"action":"updateQuantity"
			});
		billing();
		
	}
</script>
<form method="post" action="OrderServletController">
<input type="hidden" name="action" value="placeOrder">
<table class="table table-dark">

	<thead>
		<tr>
			<th>Cart Id</th>
			<th>Book Image</th>
			<th>Book Name</th>
			<th>Price Per Book</th>
			<th>Quantity/Net Price</th>
			<th>Action</th>
		</tr>
	</thead>
	<tbody>
		<c:forEach var="cart" items="${cart}">
			<tr>
				<td>${cart.cartId}</td>
				<td><img src="images/${cart.book.bookImage }" height="90px"
					width="70px" /></td>
				<td>${cart.book.bookName}</td>
				<td> &#8377;${cart.book.price}</td>
				<td><input type="hidden" value="${cart.book.price}"><input
						type="number" value="${cart.quantity}" id="${cart.cartId}"
						onclick="calculateNetPrice(this)" class="quantity" min="1" id="${cart.cartId}"><input
						readonly="readonly" class="totalNetPrice"
						value="${cart.book.price * cart.quantity }" /></td>
						
						<td><a href="CartServletController?action=deleteItem&cartId=${cart.cartId}" title="Delete">
						<i class="bi bi-trash"></i></a></td>						
			</tr>
		</c:forEach>
		<tr>
			<th colspan="4" style="text-align: right;">Total =</th>
			<th><input type="text" id="totalCost" name="totalCost"
				readonly="readonly"></th>
			<th><input type="submit" value="Proceed to Buy"
				class="btn btn-light"></th>
		</tr>

	</tbody>
</table>
</form>
<jsp:include page="Footer.jsp"></jsp:include>