<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@  taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="user.UserBean" %>
<%@ page import="user.UserBasicInfo" %>
<%@ page import="control.GetCategory" %>
<%@ page import="user.CountUserPost" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<link rel="stylesheet" href="stylesheet/UpdateUserInfo.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<script src="javascript/angular.min.js"></script>
<script src="javascript/myModule.js"></script>
<script src="javascript/UserFriends.js"></script>
<script src="javascript/SearchFriends.js"></script>
<script src="javascript/Discussion.js"></script>
<script src="javascript/Update_Validation.js"></script>
<script src="javascript/addNews.js"></script>
<c:set var="id" value="${cookie.DEMOCRATIC_User_id.value}" />
<c:if test="${id==null}">
		<c:redirect url="Login.jsp" />
</c:if>
<c:set var="userObject" value="${UserBasicInfo.getUserdata(id)}" />
<title>Welcome ${userObject.getUserName()}</title>
<style>
	.myheader
	{
		background:linear-gradient(to bottom right,#dc7633, #873600);
		color:white;
		margin:0px;
		margin-bottom: 2%;
	}
	.mynavbar
	{
		margin:0px;
	}
	.myfooter
	{
		position:relative;
		color:white;
		width:100%;
		background-color: #1b2631;
		height:300px;
	}
	.mymainSection
	{
		height:500px;
	}
	.mySection
	{
		width:100%;
		height:900px;
		display:block;
	}
</style>
</head>
<body>
	<nav class="navbar mynavbar">
	<div class="container-fluid">
		<div class="navbar-header">
			<a class="navbar-brand" href="#">Democratic</a>
		</div>
		<ul class="nav navbar-nav navbar-right">
			<li><a>Home</a></li>
			<li><a href="UserLogoutController">Logout</a></li>
		</ul>
	</div>
	</nav>
	<haeder class="col-sm-12 myheader" style="">
		<div class="col-sm-12">
			<h1><b>Democratic</b></h1>
			<h3>Welcome ${userObject.getUserName()}</h3>
		</div>
		<div class="col-sm-5" style="margin-top: 2%">
			<blockquote style="color:white">
				START WHERE YOU ARE USE WHAT YOU HAVE DO WHAT YOU CAN
			</blockquote>
		</div>
	</haeder>
	<section class="mySection" ng-app="myapp" ng-init="id=${id}">
	<section class="col-sm-3">
		<div ng-controller="getControl_Discussion">
			<h5><b>{{my_discussion[flag].topic}}</b></h5>
			<p>{{my_discussion[flag].text}}</p>
			<h3>Comments Section</h3>
			<button data-toggle="collapse" data-target="#demo">Collapsible</button>
			<div class="collapse" id="demo">
			<ul ng-repeat="x in comments" >
				<li>{{x.name}}</li>
				<li>{{x.email}}</li>
				<li>{{x.comment}}</li>
			</ul>
			</div>
			<div ng-controller="postComment_Discussion">
			<form name="myform">
			<input type="text" id="userComment" placeholder="Comment" ng-model="mycomment" name="mytext" required pattern="[a-zA-Z0-9 ]+"/>
			<input type="button" value="comment" ng-click="myform.mytext.$valid && insertComment(my_discussion[flag].id,'${userObject.getUserName()}','${userObject.getUserEmail()}')" />
			</form>
			</div>
			<input type="button" value="Next" ng-click="nextIndex()"/>
			<input type="button" value="Previous" ng-click="previousIndex()"/>
		</div>
	</section>
	<section class="col-sm-9 mymainSection">
	  <ul class="nav nav-tabs">
	    <li class="active"><a data-toggle="tab" href="#home">Home</a></li>
	    <li><a data-toggle="tab" href="#menu1">Menu 1</a></li>
	    <li><a data-toggle="tab" href="#menu2">Menu 2</a></li>
	    <li><a data-toggle="tab" href="#menu3"><b>Edit Account</b></a></li>
	  </ul>
	
	  <div class="tab-content">
	    <div id="home" class="tab-pane fade in active">
	      <h3>HOME</h3>
	      <p>Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.</p>
	    </div>
	    <div id="menu1" class="tab-pane fade">
		      	<div class="col-sm-4">
		      		<h1><b>Add Your News</b></h1>
		      	</div>
				<div class="col-sm-8">
				<c:set var="count" value="${CountUserPost.getNumber(id)}" />
				<c:choose>
					<c:when test="${count==0}">
					<p>${count}</p>
				<form method="POST" action="UserPost?id=${id}" enctype="multipart/form-data" class="form-group myform">
				<table class="">
					<tr>
						<td style="width:30%"><b>Post Name</b></td>
						<td style="width:70%"><input type="text" class="form-control" name="postName"/></td>
					</tr>
					<tr>
						<td><b>Post Category</b></td>
						<td>
							<select class="form-control" name="postCategory">
								<c:set var="list" value="${GetCategory.category()}"/>  
								<c:forEach items="${list}" var="element">
									<option value="${element.getCategoryId()}">
									${element.getCategoryName()}
									</option>
								</c:forEach>
							</select>
						</td>
					</tr>
					<tr>
						<td colspan="2"><b>Body</b></td>
					</tr>
					<tr>
						<td colspan="2" >
							<textarea class="form-control" id="txtBody" name="postBody">
							</textarea>
						</td>
					</tr>
					<tr>
						<td colspan="2"><b>About Your Work</b></td>
					</tr>
					<tr>
						<td colspan="2" >
							<textarea class="form-control" name="postAboutYourWork">
							</textarea>
						</td>
					</tr>
					<tr>
						<td><b>First Image</b></td>
						<td style="overflow:hidden"><input type="file" class="btn btn-info" name="postImage1" id="postImage1" style="width:100%" onchange="Image1();" required/></td>
					</tr>
					<tr>
						<td colspan="2"><small id="image11" style="display:none"><b>Invalid Image Format</b></small><small id="image12" style="display:none"><b>Size is not suitable</b></small></td>
					</tr>
					<tr>
						<td><b>Second Image</b></td>
						<td style="overflow:hidden"><input type="file" class="btn btn-info" name="postImage2" id="postImage2" style="width:100%" onchange="Image2();" required/></td>
					</tr>
					<tr>
						<td colspan="2"><small id="image21" style="display:none"><b>Invalid Image Format</b></small><small id="image22" style="display:none"><b>Size is not suitable</b></small></td>
					</tr>
					<tr>
						<td><b>Video</b></td>
						<td style="overflow:hidden"><input type="file" class="btn btn-info" name="postVideo1" id="postVideo1" style="width:100%" onchange="Video1();" required/></td>
					</tr>
					<tr>
						<td colspan="2"><small id="image31" style="display:none"><b>Invalid Video Format</b></small><small id="image32" style="display:none"><b>Size is not suitable</b></small></td>
					</tr>
					<tr>
						<td><input type="submit" name="Post" id="add" class="form-control btn login" value="Post" onclick="return checkFiles();"/></td>
					</tr>
				</table>
				</form>
				</c:when>
				<c:otherwise>
					<h3>Sorry You Can Only Post One News Per Day ...</h3>
				</c:otherwise>
				</c:choose>
				</div>
			
	</div>
	    <div id="menu2" class="tab-pane fade" >
	    	<div  ng-controller="mycontroller_SearchFriends">
		      <input type="text" id="mytext"/>
		      <table class="table">
				<tr ng-repeat="x in mydata | limitTo: mydata.length-1">
					<td>{{x.name}}</td>
					<td>{{x.email}}</td>
					<td><center><input type="button" value="AddFriend" ng-click="add(x.id);" class="btn btn-primary"/></center></td>
				</tr>
			</table>
		     </div>
	    </div>
	    <div id="menu3" class="tab-pane fade">
	      <div ng-controller="myctrl_Update">
      		<h2 class="heading_edityouraccount" data-toggle="collapse" data-target="#updateTable"><b>Edit Your Account</b></h2>
      		<div class="collapse" id="updateTable">
      		<form method="POST" action="SignUp">
				<table class="mytable" id="updateTable">
					<tr>
						<td><b>Name</b></td>
						<td><input type="text" required pattern="[a-zA-Z ]+" title="Invalid Name Format" name="name" class="form-control" value="${userObject.getUserName()}"/></td>
					</tr>
					<tr>
						<td><b>Gender</b></td>
						<td>
							<c:choose>
								<c:when test="${userObject.getUserGender()=='Male'}">
									<input type="radio" name="gender" value="Male" checked="checked"/><b>Male</b>&nbsp;&nbsp;
								</c:when>
								<c:otherwise>
									<input type="radio" name="gender" value="Male" checked="checked"/><b>Male</b>&nbsp;&nbsp;
								</c:otherwise>
							</c:choose>
							<c:choose>
								<c:when test="${userObject.getUserGender()=='Female'}">
									<input type="radio" name="gender" value="Female" /><b>Female</b>
								</c:when>
								<c:otherwise>
									<input type="radio" name="gender" value="Female" /><b>Female</b>
								</c:otherwise>
							</c:choose>
						</td>
					</tr>
					<tr>
						<td><b>Email</b></td>
						<td>
							<input type="email" name="email" required ng-keyup="checkEmail();" id="email" class="form-control" value="${userObject.getUserEmail()}" />
							<p ng-show="emailMessage" class="error"><small><b>Email Already Registered</b></small></p>
						</td>
					</tr>
					<tr>
						<td><input type="submit" name="add" value="Update Detail" id="btn_submit" ng-disabled="flag" class="form-control btn btn-success"/></td>
					</tr>
				</table>
			</form>
			</div>
	      </div>
	       <div>
	    	<h2 class="heading_edityouraccount" data-toggle="collapse" data-target="#updatePasswordTable"><b>Edit Your Password</b></h2>
      		<div class="collapse" id="updatePasswordTable">
      		<form method="POST" action="SignUp">
				<table class="mytable" id="updateTable">
					<tr>
						<td><b>Old Password</b></td>
						<td><input type="text" required name="oldPassword" class="form-control" /></td>
					</tr>
					<tr>
						<td><b>New Password</b></td>
						<td><input type="text" required name="newPassword" class="form-control" /></td>
					</tr>
					<tr>
						<td><b>Confirm Password</b></td>
						<td><input type="text" required name="confPassword" class="form-control" /></td>
					</tr>
					<tr>
						<td><input type="submit" name="add" value="Update Detail" id="btn_submit" ng-disabled="flag" class="form-control btn btn-success"/></td>
					</tr>
				</table>
			</form>
      		</div>
	    </div>
	    </div>
	   
	  </div>
	  </section>
	</section>
	<footer style="" class="myfooter">
		<center><h1>Thankyou To Join Us</h1></center>
	</footer>
</body>
</html>