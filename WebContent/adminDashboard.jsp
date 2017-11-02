<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="admin.AdminBean" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<script src="MaterialDesign/material.min.js"></script>
	<link href="MaterialDesign/material.indigo-pink.min.css" rel="stylesheet" />
	<link href="MaterialDesign/icon.css" rel="stylesheet" />
	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
	<title>Insert title here</title>
	<%@  taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
</head>
	<body>
		<c:set var="myobject" value="${sessionScope['adminObject']}"></c:set>
		<c:if test="${myobject==null}">
			 <c:redirect url = "adminLogin.jsp"/>
		</c:if>
		<div class="mdl-layout mdl-js-layout mdl-layout--fixed-header">
		  	<header class="mdl-layout__header">
			    <div class="mdl-layout__header-row">
			      <span class="mdl-layout-title">Welcome Admin</span>
			    </div>
		  	</header>
		  	<div class="mdl-layout__drawer">
			    <span class="mdl-layout-title">Navigate Resources</span>
			    <nav class="mdl-navigation">
			      <a class="mdl-navigation__link" href="addDiscussion.jsp" target="myframe"><b>Add Discussion</b></a>
			      <a class="mdl-navigation__link" href="adminAllDiscussion.jsp" target="myframe"><b>Discussion</b></a>
			      <a class="mdl-navigation__link" href="adminPost.jsp" target="myframe"><b>Add Post</b></a>
			      <a class="mdl-navigation__link" href="adminAllPost.jsp" target="myframe"><b>All Post</b></a>
			    </nav>
		  	</div>
			<main>
				<div style="margin:3%;overflow:auto">
		    		<iframe src="#" name="myframe" style="height:1500px">
		    		</iframe>
		    	</div>
			</main>
		</div>
	</body>
</html>