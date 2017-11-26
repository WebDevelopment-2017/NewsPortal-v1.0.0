<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<script src="javascript/jquery-3.2.1.min.js"></script>
<link rel="stylesheet" href="stylesheet/jquery-ui.css">
<script src="javascript/jquery-ui.js"></script>
<script src="javascript/addNews.js"></script>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<%@ page import="control.GetCategory" %>
<%@  taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<script>
	$(function() 
			{
			    $( ".mydate" ).datepicker({ 
			    	dateFormat: 'yy-mm-dd',
			        changeYear: true,
			        changeMonth: true,
			        yearRange: '2016:'+'2200:'
			    	}); 
			});
</script>
<style>
	.table>tbody>tr>td 
	{
    	border-top: none;
    	color:#2e4053;
	}
</style>
</head>
<body>
	<div style="width:100%">
		<form action="AdminAddPost" method="POST" enctype="multipart/form-data">
			<h2><b>Add Your Post</b></h2>
			<center>
				<table class="table bordless">
				<tr>
					<td><b>Post Name</b></td>
					<td class="no-line"><input type="text" name="name" class="form-control" style="width:70%" required/></td>
				</tr>
				<tr>
					<td><b>Post Category</b></td>
					<td>
						<select name="category" class="form-control" style="width:30%">
							<c:set var="list" value="${GetCategory.category()}" />
							<c:forEach items="${list}" var="element">
							<option value="${element.getCategoryId()}" >${element.getCategoryName()}</option>
							</c:forEach>
						</select>
					</td>
				</tr>
				<tr>
					<td><b>Post Body</b></td>
					<td>
						<textarea name="body" class="form-control" rows="15" cols="50" required>
						</textarea>
					</td>
				</tr>
				<tr>
					<td><b>Post Work</b></td>
					<td>
						<textarea name="work" class="form-control" rows="5" cols="50" required>
						</textarea>
					</td>
				</tr>
				<tr>
					<td><b>Primary Image</b></td>
					<td><input type="file" name="image1" onchange="Image1();" id="postImage1" required class="btn btn-warning"/></td>
				</tr>
				<tr>
					<td colspan="2"><small id="image11" style="display:none"><b>Invalid Image Format</b></small><small id="image12" style="display:none"><b>Size is not suitable</b></small></td>
				</tr>
				<tr>
					<td><b>Secondary Image</b></td>
					<td><input type="file" name="image2" onchange="Image2();" id="postImage2" required class="btn btn-warning"/></td>
				</tr>
				<tr>
					<td colspan="2"><small id="image21" style="display:none"><b>Invalid Image Format</b></small><small id="image22" style="display:none"><b>Size is not suitable</b></small></td>
				</tr>
				<tr>
					<td><b>Video</b></td>
					<td><input type="file" name="video1" onchange="Video1();" id="postVideo1" required class="btn btn-warning"/></td>
				</tr>
				<tr>
					<td colspan="2"><small id="image31" style="display:none"><b>Invalid Video Format</b></small><small id="image32" style="display:none"><b>Size is not suitable</b></small></td>
				</tr>
				<tr>
					<td><b>Date To Publish</b></td>
					<td><input type="date" name="date" class="mydate" class="form-control" class="form-control" required/></td>
				</tr>
				<tr>
					<td colspan="2"><input type="submit" name="Post" id="add"  value="Post" onclick="return checkFiles();" class="btn btn-success"/></td>
				</tr>
			</table>
			</center>
		</form>
		<c:set var="flag" value="${param['flag']}" />
		<c:if test="${flag>0}">
			<small style="color: #2e4053"><b>Status: Data Saved !</b></small>
		</c:if>
		<c:if test="${flag==0}">
			<small style="color: #c0392b"><b>Status: Something Went Wrong !</b></small>
		</c:if>
	</div>
</body>
</html>