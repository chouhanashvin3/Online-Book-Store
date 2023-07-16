<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <jsp:include page="Header.jsp"></jsp:include>
	<jsp:include page="Messages.jsp"></jsp:include>
<h1 style="color:white">Login Form</h1>
<div class="error"></div>
<form method="post" action="LoginServlet"
		onsubmit="return validateLoginForm();" name="loginform">
		<input type="hidden" name="action" value="login">
		
		<table class="table table-dark">
			<tr>
				<td><label class="form-label">Enter Email Id:</label></td>
				<td><input type="email" name="email" id="email" class="form-control"></td>
			</tr>
			<tr>
				<td><label class="form-label">Enter Password :</label></td>
				<td><input type="password" name="password" id="password" class="form-control"></td>
			</tr>
			<tr>
				<td><input type="reset" value="clear" class="btn btn-primary btn-md">&nbsp;</td>
				<td><input type="submit" value="Login" class="btn btn-success btn-md"></td>
			</tr>
		</table>
	</form>
<script type="text/javascript">
function validateLoginForm() {
	// to read or write value from input type:
	// 2. value property : property of document

	// storing element in variable
	var username = document.getElementById('email');
	
	/*
	 * var u = document.loginform.elements['username'] ;//by name, id , index
	 * console.log(u);
	 */
	// storing value of element in variable
	var password = document.getElementById('password').value;
	

	var t = document.getElementsByClassName('error');
	if (username == null || username == "") { // reading value
		// property of
		// Username field
		t[0].innerHTML = "Email required.";
		return false;
	} else if (password == null || password == "") { // password contains
		// value of password
		// field itself
		t[0].innerHTML = "Password required.";
		return false;
	} else {
		return true;
	}
}

</script>
<jsp:include page="Footer.jsp"></jsp:include>
