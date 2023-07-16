<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
     <%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Online Book Store </title>
<meta name="keywords" content="Book Store Template, Free CSS Template, CSS Website Layout, CSS, HTML" />
<meta name="description" content="Book Store Template, Free CSS Template, Download CSS Website" />
<link href="templatemo_style.css" rel="stylesheet" type="text/css" />
<link href="bootstrap.css" rel="stylesheet" type="text/css" />
<link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.5.0/font/bootstrap-icons.css" rel="stylesheet">
<script type="text/javascript" src="jquery3.6.1.js"></script>
</head>
<body>
<!--  Free CSS Templates from www.templatemo.com -->

<div id="templatemo_container">
	<div id="templatemo_menu">
    	<ul>
            <li><a href="Home.jsp" class="current">Home</a></li>
            
            <li><a href="company.jsp">Company</a></li> 
            <li><a href="contact.html">Contact</a></li>
            <c:if test="${admin eq null && customer eq null }">
            <li><a href="Login.jsp">Login</a></li>
            <li><a href="Register.jsp">Register</a></li>
            </c:if>
            <c:if test="${admin ne null && customer eq null }">
            <li><a href="BookServletController?action=addBook">Add Book</a></li>
            <li><a href="BookServletController?action=viewAllBooks">Books</a></li>
            <li><a href="OrderServletController?action=allOrders">All Orders</a></li>
            <li><a href="CustomerServletController?action=viewCustomers">All Customer</a></li>
            </c:if>
            <c:if test="${admin eq null && customer != null }">
            <li><a href="CartServletController?action=viewCart">My Cart</a></li>
            <li><a href="OrderServletController?action=orderHistory">Order History</a></li>
            <li><a href="CustomerServletController?action=updateProfile">Update Profile</a></li>
            </c:if>
            <c:if test="${admin ne null || customer ne null }">
            	<li><a href="LoginServlet?action=logout">Logout</a></li>
            </c:if>
            
    	</ul>
    </div> <!-- end of menu -->
    
    <div id="templatemo_header">
    	<div id="templatemo_special_offers">
        	<p style="color:white">
                <span>25%</span> discounts for
        purchase over $80
        	</p>
			<a href="subpage.html" style="margin-left: 50px;">Read more...</a>
        </div>
        
        
        <div id="templatemo_new_books">
        	<ul style="color:white">
                <li>Suspen disse</li>
                <li>Maece nas metus</li>
                <li>In sed risus ac feli</li>
            </ul>
            <a href="subpage.html" style="margin-left: 50px;">Read more...</a>
        </div>
    </div> <!-- end of header -->
    
    <div id="templatemo_content">


