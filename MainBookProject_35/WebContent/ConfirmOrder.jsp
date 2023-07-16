<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<jsp:include page="Header.jsp"></jsp:include>
<jsp:include page="Messages.jsp"></jsp:include>
<h1 style="color:white"> Please Confirm All Order Details</h1>
<form method="post" action="OrderServletController">
	<input type="hidden" name="action" value="confirmOrder">
	<table class="table table-dark" style="text-align: center">
	<tr>
		<th>Email of customer :</th>
		<th><input type="text" name="emailId" value="${orderObj.emailId}" readonly="readonly"></th>
</tr>

<tr>
<th>Order Date :</th>
<th> <input type="text" name="orderDate" value="${orderObj.orderDate}" readonly="readonly"></th>
</tr>

<tr>
<th>Status of Order :</th>
<th> <input type="text" name="status" value="${orderObj.status}" readonly="readonly"></th>
</tr>

<tr>
<th>Billing Amount :</th>
<th> &#8377; <input type="text" name="totalCost" value="${orderObj.totalCost}" readonly="readonly"></th>
</tr>

<tr>
<th>Enter Shipping Address<span style="color:red">*</span> :</th>
<th> <input type="text" name="shippingAddress" value="${orderObj.shippingAddress}" ></th>
</tr>
<tr>
	<th><a class="btn btn-light" href="CartServletController?action=viewCart">Cancel</a></th>
	<th><input type="submit" value="Confirm Order" class="btn btn-light"/></th>
</tr>	
</table>
</form>
<jsp:include page="Footer.jsp"></jsp:include>