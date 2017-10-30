<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="admin.GetDiscussion" %>
<%@ page import="control.GetCategory" %>
<%@ page import="admin.DiscussionBean" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<title>Insert title here</title>
<%@  taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@  taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
</head>
<body>
	<center>
	<c:set var="postId" value="${param.id}"></c:set>
	<c:set var="dataObject" value="${GetDiscussion.getDiscussion(postId)}" />
	<form method="POST" action="UpdateDiscussion?id=${postId}">
		<table class="table">
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
					<b>Update</b>
				</td>
			</tr>
			<tr>
				<td>
					<textarea required name="topic" class="form-control" cols="50" rows="5" maxlength="100" minlength="10">${dataObject.getTopic()}</textarea>
				</td>
				<td>
					<textarea required name="description" class="form-control" cols="50" rows="5" maxlength="100" minlength="10">${dataObject.getDescription()}</textarea>
				</td>
				<td>
					<select name="category" id="category" required class="form-control">
						<c:set var="list" value="${GetCategory.category()}"/>  
						<c:forEach items="${list}" var="element">
							<c:choose>
								<c:when test="${element.getCategoryId()==dataObject.getCategoryId()}">
									<option value="${element.getCategoryId()}" selected>
									${element.getCategoryName()}
									</option>
								</c:when>
								<c:otherwise>
									<option value="${element.getCategoryId()}">
									${element.getCategoryName()}
									</option>
								</c:otherwise>
							</c:choose>
						</c:forEach>
					</select>
				</td>
				<c:set var="date" value="${fn:split(dataObject.getDate(),'-')}" />
				<td>
					<select name="day" id="day" required class="form-control">
					<c:forEach var="i" begin="1" end="31">
						<c:choose>
							<c:when test="${i==date[2]}"><option value="${i}" selected>${i}</option></c:when>
							<c:otherwise><option value="${i}">${i}</option></c:otherwise>
						</c:choose>
					</c:forEach>
					</select>
				</td>
				<td>
					<select name="month" id="month" required class="form-control">
						<c:forEach var="i" begin="1" end="12">
							<c:choose>
								<c:when test="${i==date[1]}"><option value="${i}" selected>${i}</option></c:when>
								<c:otherwise><option value="${i}">${i}</option></c:otherwise>
							</c:choose>
						</c:forEach>
					</select>
				</td>
				<td>
					<select name="year" id="year" required class="form-control">
						<c:forEach var="i" begin="2017" end="2100">
							<c:choose>
								<c:when test="${i==date[0]}"><option value="${i}" selected>${i}</option></c:when>
								<c:otherwise><option value="${i}">${i}</option></c:otherwise>
							</c:choose>
						</c:forEach>
					</select>
				</td>
				<td>
					<input type="submit" value="Update" class="form-control btn btn-primary" />
				</td>
			</tr>
		</table>
	</form>
	</center>
</body>
</html>