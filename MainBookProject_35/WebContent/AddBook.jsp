<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
  <%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
    <jsp:include page="Header.jsp"></jsp:include>
	<jsp:include page="Messages.jsp"></jsp:include>
	<script type="text/javascript">
	function validateBookForm() {
		
		
		var bookName = document.getElementById('bookName');
		var description = document.getElementById('description').value;
		var author =document.getElementById('author').value;
		var publisher =document.getElementById('publisher').value;
		var category =document.getElementById('category').value;
		var isbn =document.getElementById('isbn').value;
		var price =document.getElementById('price').value;
		var quantity =document.getElementById('quantityOfAvailableBooks').value;
		var bookRating =document.getElementById('bookRating').value;
		var t = document.getElementsByClassName('error');
		
		if (bookName == null || bookName == '') { 
			
			t[0].innerHTML = "bookName required.";
			return false;
		}
		else if (description == null || description == '') { 
			
			t[0].innerHTML = "description required.";
			return false;
		}
		else if (author == null || author == '') { 
			
			t[0].innerHTML = "author required.";
			return false;
		}
		else if (publisher == null || publisher == '') { 
			
			t[0].innerHTML = "publisher required.";
			return false;
		}
		else if (category == null || category == '') { // reading value
				
				t[0].innerHTML = "category required.";
				return false;
		} 
		else if (isbn == null || isbn == '') {
				
				t[0].innerHTML = "isbn required.";
				return false;
		}
		else if (price == null || price == '') { 
			
			t[0].innerHTML = "price required.";
			return false;
		}
		else if (quantity == 0 || quantity == '') { 
			
			t[0].innerHTML = "quantity of Available book required.";
			return false;
		}
		else if (bookRating == null || bookRating == '') { 
		
		t[0].innerHTML = "bookRating required.";
		return false;
		}
		else {
			return true;
		}
	}
</script>
<c:if test="${book eq null }">
	<h1 style="color:white">Add Book Form</h1>
</c:if>
	<c:if test="${book ne null }">
	<h1 style="color:white">Update Book</h1>
	</c:if>
	<div class="error"></div>
<h5 style="color:maroon; background-color:pink;text-align: right;">Required Fields are marked with (*)</h5>
	<form method="post" action="BookServletController"
		onsubmit="return validateBookForm();" >
		<c:if test="${book eq null }">
		<input type="hidden" name="action" value="addBook">
		</c:if>
		<c:if test="${book ne null }">
		<input type="hidden" name="action" value="editBook">
		<input type="hidden" name="bookId" value="${book.bookId}">
		</c:if>
		
		<table class="table table-dark">
			<tr>
				<td><label class="form-label">Enter Book Name <span style="color:maroon;font-size:12px">*</span> :</label></td>
				<td><input type="text" name="bookName" id="bookName" value="${book.bookName}" class="form-control"></td>
			</tr>
			<tr>
				<td><label class="form-label">Enter Book Description <span style="color:maroon;font-size:12px">*</span> :</label></td>
				<td><textarea rows="2" cols="7" name="description" id="description" value="${book.description}" class="form-control"></textarea></td>
			</tr>
			<tr>
				<td><label class="form-label">Enter Author Name  <span style="color:maroon;font-size:12px">*</span> :</label></td>
				<td><input type="text" name="author" id="author" value="${book.author}" class="form-control"></td>
			</tr>
			<tr>
				<td><label class="form-label">Enter Publisher Name  <span style="color:maroon;font-size:12px">*</span> :</label></td>
				<td><input type="text" name="publisher" id="publisher" value="${book.publisher}" class="form-control"></td>
			</tr>
			<tr>
				<td><label class="form-label">Enter Book Category <span style="color:maroon;font-size:12px">*</span> :</label></td>
				<td><input type="text" name="category" id="category" value="${book.category}" class="form-control"></td>
			</tr>
			<tr>
				<td><label class="form-label">Enter ISBN <span style="color:maroon;font-size:12px">*</span>:</label></td>
				<td><input type="text" name="isbn" id="isbn" value="${book.isbn}" class="form-control"></td>
			</tr>
			<tr>
				<td><label class="form-label">Enter Price Per Book <span style="color:maroon">*</span> :</label></td>
				<td><input type="text" name="price" id="price" value="${book.price}" class="form-control"></td>
			</tr>
			<tr>
				<td><label class="form-label">Enter Quantity of Available book :</label></td>
				<td><input type="number" name="quantityOfAvailableBooks" id="quantityOfAvailableBooks" value="${book.quantityOfAvailableBooks}" class="form-control"></td>
			</tr>
			<tr>
				<td><label class="form-label">Enter Book Rating <span style="color:maroon">*</span> :</label></td>
				<td><input type="text" name="bookRating" id="bookRating" value="${book.bookRating}" class="form-control"></td>
			</tr>
			<tr>
				<td><input type="reset" value="clear" class="btn btn-primary btn-md">&nbsp;
				<c:if test="${book eq null }">
				<input type="submit" value="addBook"  class="btn btn-success btn-md"></c:if>
				
				<c:if test="${book ne null }">
				<input type="submit" value="UpdateBook"  class="btn btn-success btn-md"></c:if>
				</td>
			</tr>
		</table>
	</form>
	<jsp:include page="Footer.jsp"></jsp:include>

	