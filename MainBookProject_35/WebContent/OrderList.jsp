<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:include page="Header.jsp"></jsp:include>
<jsp:include page="Messages.jsp"></jsp:include>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<h1 style="color:white">Orders</h1>
<table class="table table-dark">
<tr>
	<th>Order Id</th>
	<th>Email Id</th>
	<th>Order Date</th>
	<th>Shipping Address</th>
	<th>Status</th>
	<th>Total Bill</th>
	<th>Action</th>
</tr>
<c:forEach items="${orderList}" var="order">
<tr>
<td>${order.orderId}</td>
<td>${order.emailId}</td>
<td>${order.orderDate}</td>
<td>${order.shippingAddress}</td>
<td>${order.status}</td>
<td>${order.totalCost}</td>

<c:if test="${order.status.equals('Cancelled') !=true }">
	<c:if test="${order.status.equals('Completed') == true }">
			<th style="color:maroon">Order is Completed</th>
		</c:if>
	
	<c:if test="${order.status.equals('Completed') != true }">
			
			<td><a href="OrderServletController?action=showDetails&orderId=${order.orderId}" 
			title="Show Details" ><i class="bi bi-view-list"></i></a>
		<c:if test="${customer != null && admin == null }">
		<a href="OrderServletController?action=cancelOrder&orderId=${order.orderId }" 
			title="Cancel Order"><i class="bi bi-x"></i></a>
		</c:if></td>
	</c:if>
</c:if>
<c:if test="${order.status.equals('Cancelled') == true }">
<th style="color:white">Order is Cancelled</th>
</c:if>
</tr>
</c:forEach>
</table>
<jsp:include page="Footer.jsp"></jsp:include>