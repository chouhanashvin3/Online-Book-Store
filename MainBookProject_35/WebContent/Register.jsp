<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
    <jsp:include page="Header.jsp"></jsp:include>
	<jsp:include page="Messages.jsp"></jsp:include>
<script type="text/javascript">
function validateRegistrationForm() {
	// to read or write value from input type:
	// 2. value property : property of document

	// storing element in variable
	var username = document.getElementById('emailId');
	
	/*
	 * var u = document.loginform.elements['username'] ;//by name, id , index
	 * console.log(u);
	 */
	// storing value of element in variable
	var password = document.getElementById('password').value;
	var firstName =document.getElementById('firstName').value;
	var lastName =document.getElementById('lastName').value;
	var address =document.getElementById('address').value;
	var contact =document.getElementById('contact').value;
	

	var t = document.getElementsByClassName('error');
	 if (firstName == null || firstName == '') { 
		
		t[0].innerHTML = "firstName required.";
		return false;
	}
	else if (lastName == null || lastName == '') { 
		
		t[0].innerHTML = "lastName required.";
		return false;
	}
	else if (address == null || address == '') { 
		
		t[0].innerHTML = "address required.";
		return false;
	}
	else if (contact == null || contact == '') { 
		
		t[0].innerHTML = "contact required.";
		return false;
	}
	else if (username.value == null || username.value == '') { // reading value
			// property of
			// Username field
			t[0].innerHTML = "Email required.";
			return false;
	} else if (password == null || password == '') { // password contains
			// value of password
			// field itself
			t[0].innerHTML = "Password required.";
			return false;
		}
	else {
		return true;
	}
}
function checkPassword(){
	var password = document.getElementById('password').value;
	var cnfpassword = document.getElementById('cnfpassword').value;
	var t=document.getElementsByClassName('error');
	if(cnfpassword == password){
		return true;
	}
	else{
		t[0].innerHTML ="Password and Confirm password should match.";
		return false;
	}
}
</script>
<c:if test="${customer eq null }">
	<h1 style="color:white">Registration Form</h1>
	</c:if>
	<c:if test="${customer ne null }">
	<h1 style="color:white">Update Profile</h1>
	</c:if>
	<div class="error"></div>
<h5 style="color:maroon; background-color:pink;text-align: right;">Required Fields are marked with (*)</h5>
	<form method="post" action="CustomerServletController"
		onsubmit="return validateRegistrationForm();" >
		<c:if test="${customer eq null }">
		<input type="hidden" name="action" value="addCustomer">
		</c:if>
		<c:if test="${customer ne null }">
		<input type="hidden" name="action" value="editCustomer">
		<input type="hidden" name="customerId" value="${customer.customerId}">
		</c:if>
		
		<table class="table table-dark">
			<tr>
				<td><label class="form-label">Enter First Name <span style="color:maroon;font-size:12px">*</span> :</label></td>
				<td><input type="text" name="firstName" id="firstName" value="${customer.firstName}" class="form-control"></td>
			</tr>
			<tr>
				<td><label class="form-label">Enter Last Name <span style="color:maroon;font-size:12px">*</span> :</label></td>
				<td><input type="text" name="lastName" id="lastName" value="${customer.lastName}" class="form-control"></td>
			</tr>
			<tr>
				<td><label class="form-label">Enter Address <span style="color:maroon;font-size:12px">*</span> :</label></td>
				<td><textarea rows="2" cols="7" name="address" id="address" value="${customer.address}" class="form-control"></textarea></td>
			</tr>
			<tr>
				<td><label class="form-label">Enter Alternate Address :</label></td>
				<td><textarea rows="2" cols="7" name="address2" id="address2" class="form-control"></textarea></td>
			</tr>
			<tr>
				<td><label class="form-label">Enter Contact Number <span style="color:maroon;font-size:12px">*</span> :</label></td>
				<td><input type="text" name="contact" id="contact" value="${customer.contact}" class="form-control"></td>
			</tr>
			<tr>
				<td><label class="form-label">Enter Email Id <span style="color:maroon;font-size:12px">*</span>:</label></td>
				<td><input type="email" name="emailId" id="emailId" value="${customer.emailId}" class="form-control"></td>
			</tr>
			<tr>
				<td><label class="form-label">Enter Password <span style="color:maroon">*</span> :</label></td>
				<td><input type="password" name="password" id="password" value="${customer.password}" class="form-control"></td>
			</tr>
			<tr>
				<td><label class="form-label">Confirm Password :</label></td>
				<td><input type="password" name="cnfpassword" id="cnfpassword" onkeyup=" return checkPassword()" class="form-control"></td>
			</tr>
			<tr>
				<td><input type="reset" value="clear" class="btn btn-primary btn-md">&nbsp;
				<c:if test="${customer eq null }">
				<input type="submit" value="Register" class="btn btn-success btn-md"></c:if>
				
				<c:if test="${customer ne null }">
				<input type="submit" value="Update" class="btn btn-success btn-md"></c:if>
				</td>
			</tr>
		</table>
	</form>
	<jsp:include page="Footer.jsp"></jsp:include>

