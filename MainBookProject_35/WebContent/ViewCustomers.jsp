<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
   
    <jsp:include page="Header.jsp"></jsp:include>
	<jsp:include page="Messages.jsp"></jsp:include>
	
	<h1 style="color:white">All Customers </h1>
	<table class="table table-dark">
	<thead>
	<tr>
			<th>Customer Id</th>
			<th>First Name</th>
			<th>Last Name</th>
			<th>Address</th>
			<th>Alternate Address</th>
			<th>Contact</th>
			<th>Email Id</th>
			<th>Password</th>
			<th>Action</th>
			
	</tr>
	</thead>
	<tbody>
	
	<c:forEach items="${customersList}" var="customer">
	<tr>
	<td>${customer.customerId}</td>
	<td>${customer.firstName}</td>
	<td>${customer.lastName}</td>
	<td>${customer.address}</td>
	<td>${customer.address2}</td>
	<td>${customer.contact}</td>
	<td>${customer.emailId}</td>
	<td>${customer.password}</td>
	<td><a href="CustomerServletController?action=deleteCustomer&customerId=${customer.customerId}" title="delete" ><i class="bi bi-trash"></i></a></td>
	</tr>
	</c:forEach>
	
	</tbody>
	</table>
	<jsp:include page="Footer.jsp"></jsp:include>