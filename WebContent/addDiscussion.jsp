<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="admin.AdminBean" %>
<%@ page import="control.GetCategory" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
		<%@  taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
		<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
		<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
		<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
	</head>
	<body>
		<c:set var="myobject" value="${sessionScope['adminObject']}"></c:set>
		<c:if test="${myobject!=null}">
		 	<form method="POST" action="AddDiscussion?adminId=${myobject.getId()}">
				<center>
					<table class="table" style="width:100%">
						<tr>
							<td>
								<b>Topic</b>
							</td>
							<td>
								<b>Description</b>
							</td>
							<td>
								<b>Category</b>
							</td>
							<td colspan="3">
								<b>Publish</b>
							</td>
							<td>
								<b>Add</b>
							</td>
						</tr>
						<tr>
							<td>
								<textarea required name="topic" class="form-control" cols="50" rows="5" maxlength="100" minlength="10" ></textarea>
							</td>
							<td>
								<textarea required name="description" class="form-control" cols="50" rows="5" maxlength="100" minlength="10"></textarea>
							</td>
							<td>
								<select name="category" id="category" required class="form-control">
									<option value="" selected>-- Category --</option>
									<c:set var="list" value="${GetCategory.category()}"/>  
									<c:forEach items="${list}" var="element">
										<option value="${element.getCategoryId()}">
										${element.getCategoryName()}
										</option>
									</c:forEach>
								</select>
							</td>
							<td>
								<select name="day" id="day" required class="form-control">
									<option value="" selected>-- Day --</option>
									<c:forEach var="i" begin="1" end="31">
										<option value="${i}">${i}</option>
									</c:forEach>
								</select>
							</td>
							<td>
								<select name="month" id="month" required class="form-control">
									<option value="" selected>-- Month --</option>
									<c:forEach var="i" begin="1" end="12">
										<option value="${i}">${i}</option>
									</c:forEach>
								</select>
							</td>
							<td>
								<select name="year" id="year" required class="form-control">
									<option value="" selected>-- Year --</option>
									<c:forEach var="i" begin="2017" end="2100" >
										<option value="${i}">${i}</option>
									</c:forEach>
								</select>
							</td>
							<td>
								<input type="submit" value="Add" class="form-control btn btn-success"/>
							</td>
						</tr>
						<tr>
							<td colspan="7">
								<c:set var="flag" value='${param["flag"]}' />
								<c:if test="${flag==1}">
									<small style="color:#2e4053"><b>Status : Data Saved !</b></small>
								</c:if>
								<c:if test="${flag==0}">
									<small style="color:#922b21"><b>Status : Something Went Wrong !</b></small>
								</c:if>
							</td>
						</tr>
					</table>
				</center>
			</form>
		</c:if>
		<c:if test="${myobject==null}">
			<small style="color:#922b21">Please Refresh The Page !</small>
		</c:if>
	</body>
</html>