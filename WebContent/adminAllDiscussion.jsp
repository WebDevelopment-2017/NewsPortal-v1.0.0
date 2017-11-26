<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="admin.AdminBean" %>
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
		<%@  taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
		<style>
			a:hover
			{
				text-decoration: none;
			}
		</style>
	</head>
	<body>
		<center>
			<c:set var="myobject" value="${sessionScope['adminObject']}"></c:set>
			<c:if test="${myobject==null}">
				<small style="color:#922b21">Please Refresh The Page !</small>
			</c:if>
			<c:if test="${myobject!=null}">
				<table class="table table-striped">
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
						<td>
							<b>Publish</b>
						</td>
						<td>
							<b>Delete</b>
						</td>
						<td>
							<b>Edit</b>
						</td>
					</tr>
					<c:set var="mydataObject" value="${GetDiscussion.getAdminDiscussion(myobject.getId())}" />
					<c:forEach items="${mydataObject}" var="elements">
						<tr>
							<td>
								<small>${elements.getTopic()}</small>
							</td>
							<td>
								<small>${elements.getDescription()}</small>
							</td>
							<td>
								<c:set var="list" value="${GetCategory.category()}"/>  
								<c:forEach items="${list}" var="element">
									<c:if test="${element.getCategoryId()==elements.getCategoryId()}">
										<small>${element.getCategoryName()}</small>
									</c:if>
								</c:forEach>
							</td>
							<td>
								<small>${elements.getDate()}</small>
							</td>
							<td>
								<a href='DeleteDiscussion?id=${elements.getId()}' style="color:#922b21"><b>Delete</b></a>
							</td>
							<td>
								<a href='editDiscussion.jsp?id=${elements.getId()}'><b>Edit</b></a>
							</td>
						</tr>
					</c:forEach>
				</table>
				<c:set var="flag1" value='${param["flag_Delete"]}' />
				<c:if test="${flag1==1}">
					<small style="color:#2e4053"><b>Status : Data Deleted !</b></small>
				</c:if>
				<c:if test="${flag1==0}">
					<small style="color:#922b21"><b>Status : Something Went Wrong !</b></small>
				</c:if>
				<c:set var="flag2" value='${param["flag_Update"]}' />
				<c:if test="${flag2==1}">
					<small style="color:#2e4053"><b>Status : Data Updated !</b></small>
				</c:if>
				<c:if test="${flag2==0}">
					<small style="color:#922b21"><b>Status : Something Went Wrong !</b></small>
				</c:if>
			</c:if>
		</center>
	</body>
</html>