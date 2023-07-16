<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:include page="Header.jsp"></jsp:include>
<jsp:include page="Messages.jsp"></jsp:include>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<h1 style="color:white">Orders</h1>
<table class="table table-dark">
<tr>
	<th>Order Id</th>
	<th>Book Name</th>
	<th>Quantity</th>
    <th>Status</th>
	<c:if test="${admin !=null && customer == null }">
	<th>Action</th>
	</c:if>
</tr>
<c:forEach items="${orderDetails}" var="orderDetails">
<tr>
<td>${orderDetails.orderId}</td>
<td>${orderDetails.bookName}</td>
<td>${orderDetails.quantity}</td>
<td>${orderDetails.status}</td>
<c:if test="${admin != null && customer == null }">
	<th><form method="get" action="OrderServletController">
	<input type="hidden" value="updateStatus" name="action"/>
	<input type="hidden" name="orderId" value="${orderDetails.orderId}">
	Status:<input type="text" name="status"/><input type="submit" value="Update"> 
	</form></th>
</c:if>
</tr>
</c:forEach>
</table>