<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="control.GetCategory" %>
<%@ page import="control.Category" %>
<%@ page import="post.POST_BEAN" %>
<%@ page import="post.GET_POST_MEDIA" %>
<%@ page import="user.GetUserName" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link href="stylesheet\adminVerification.css" rel="stylesheet" />
<%@  taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<title>Verify Post</title>
</head>
<body>
	<c:set var="result" value='${param["result"]}' />
	<c:out value="${result}" />
	<form method="POST" action="Admin_GetUserPost">
	<ul>
		<li>
			<select name="categoryId">
				<c:set var="mylist" value="${GetCategory.category()}" />
				<c:forEach items="${mylist}" var="elements">
					<option value="${elements.getCategoryId()}">${elements.getCategoryName()}</option>
				</c:forEach>
			</select>
		</li>
		<li>
			<input type="submit" value="Search" name="categoryId"/>
		</li>
	</ul>
	</form>
	<c:set var="mylist" value="${requestScope.mylist}" />
	<p>${mylist}</p>
		<c:forEach items="${mylist}" var="element">
			<form method="POST" action="Verify?postId=${element.getPostId()}&adminId=1">
			<table>
				<tr><td>${element.getName()}</td></tr>
				<tr><td><textarea rows="30" cols="100" readonly>${element.getBody()}</textarea></td></tr>
				<tr><td><textarea rows="5" cols="100" readonly>${element.getWork()}</textarea></td></tr>
				<tr><td>Primary Image</td></tr>
				<tr><td><center><image src="GET_POST_MEDIA?requestFileIndex=1&requestId=${element.getPostId()}&requestTableName=userPost" width="500px" height="300px" /></center></td></tr>
				<tr><td>Secondary Image</td></tr>
				<tr><td><center><image src="GET_POST_MEDIA?requestFileIndex=2&requestId=${element.getPostId()}&requestTableName=userPost" width="500px" height="300px" /></center></td></tr>
				<tr><td>Video</td></tr>
				<tr>
					<td>
						<center>
				      	<video width="500" height="240" controls>
				  		<source src="GET_POST_MEDIA?requestFileIndex=3&requestId=${element.getPostId()}&requestTableName=userPost" type="video/mp4">
						</video> 
						</center>
					</td>
				</tr>
				<tr><td>Post By</td></tr>
				<tr>
					<td><h2><b>${GetUserName.getUserName(element.getAdminId())}</b></h2></td>
				</tr>
				<tr>
					<td><input type="submit" value="Verify" onclick="return confirm('Are you sure you want to verify this post !');"/></td>
				</tr>
			</table>
			</form>
		</c:forEach>
</body>
</html>