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
<!-- --------------------------------- Importing All the style-sheet  & Java-script ---------------------------------------- -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<link rel="stylesheet" href="stylesheet/UpdateUserInfo.css">
<link rel="stylesheet" href="stylesheet/UserDashboard.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<script src="javascript/angular.min.js"></script>
<script src="javascript/myModule.js"></script>
<script src="javascript/UserFriends.js"></script>
<script src="javascript/SearchFriends.js"></script>
<script src="javascript/Update_Validation.js"></script>
<script src="javascript/addNews.js"></script>
<!-- --------------------------------------- Importing End ---------------------------------------------------------------- -->
<!-- ============== Get the userId From cookie ============== -->
<c:set var="id" value="${cookie.DEMOCRATIC_User_id.value}" />
<c:if test="${id==null}">
		<c:redirect url="Login.jsp" />
</c:if>
<c:set var="userObject" value="${UserBasicInfo.getUserdata(id)}" />
<!-- ========================== End ========================== -->
<title>Welcome ${userObject.getUserName()}</title>
</head>
<body>
	<!-- ============= upper navigation bar ================= -->
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
	<!-- ============= upper navigation bar end ============= -->
	
	<!-- ================== Header start ==================== -->
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
	<!-- =================== Header End ===================== -->
	<!-- ================================================================= WebPage Main Section ================================================================= -->
	<section class="mySection" ng-app="myapp" ng-init="id=${id}">
	<!-- ======================================= Discussion Section Start ======================================= -->
	<section class="col-sm-3">
		<div>
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
			<div>
			<!-- ng-controller="postComment_Discussion" -->
				<form name="myform">
					<input type="text" id="userComment" placeholder="Comment" ng-model="mycomment" name="mytext" required pattern="[a-zA-Z0-9 ]+"/>
					<input type="button" value="comment" ng-click="myform.mytext.$valid && insertComment(my_discussion[flag].id,'${userObject.getUserName()}','${userObject.getUserEmail()}')" />
				</form>
			</div>
			<input type="button" value="Next" ng-click="nextIndex()"/>
			<input type="button" value="Previous" ng-click="previousIndex()"/>
		</div>
	</section>
	<!-- ======================================= Discussion Section End ======================================= -->
	<!-- ======================================= Navigation Section Start ===================================== -->
	<section class="col-sm-9 mymainSection">
	  <ul class="nav nav-tabs">
	    <li class="active"><a data-toggle="tab" href="#home">Home</a></li>
	    <li><a data-toggle="tab" href="#menu1"><b>Post your news</b></a></li>
	    <li><a data-toggle="tab" href="#menu2"><b>Follow your friends</b></a></li>
	    <li><a data-toggle="tab" href="#menu3"><b>Edit Account</b></a></li>
	  </ul>
	  <div class="tab-content">
	  	<!-- ===================== Home Menu Start ========================== -->
	    <div id="home" class="tab-pane fade in active">
	      <h3>HOME</h3>
	      <p>Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.</p>
	    </div>
	    <!-- ===================== Home Menu End ============================ -->
	    <!-- ===================== Add your news start ====================== -->
	    <div id="menu1" class="tab-pane fade">
	    		<!-- =============== Left Section of Add-News menu Start =============== -->
		      	<div class="col-sm-4">
		      		<h1 style="color:#34495e"><b>Add Your News</b></h1>
		      		<blockquote>
		      		Think before you post a news you can only post one news per day.
		      		</blockquote>
		      	</div>
		      	<!-- =============== Left Section of Add-News menu End ================= -->
		      	<!-- =============== Right Section of Add-News menu Start ============== -->
				<div class="col-sm-8">
				<c:set var="count" value="${CountUserPost.getNumber(id)}" />
				<c:choose>
					<c:when test="${count==0}">
						<div class="addNews_Div">
						<form method="POST" action="UserPost?id=${id}" enctype="multipart/form-data">
							<table class="addNews_Table" cellspacing="10">
								<tr>
									<td style="width:30%"><b style="color:#34495e">Post Name</b></td>
									<td style="width:90%"><input type="text" class="form-control" name="postName"/></td>
								</tr>
								<tr>
									<td><b style="color:#34495e">Post Category</b></td>
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
									<td colspan="2"><b style="color:#34495e">Body</b></td>
								</tr>
								<tr>
									<td colspan="2" style="height:50px" >
										<textarea class="form-control" id="txtBody" name="postBody" rows="20" cols="50" required>
										</textarea>
									</td>
								</tr>
								<tr>
									<td colspan="2"><b style="color:#34495e">About Your Work</b></td>
								</tr>
								<tr>
									<td colspan="2" >
										<textarea class="form-control" id="txtWork" name="postAboutYourWork" rows="5" cols="50" required>
										</textarea>
									</td>
								</tr>
								<tr>
									<td><b style="color:#34495e">First Image</b></td>
									<td style="overflow:hidden"><input type="file" class="btn btn-info" name="postImage1" id="postImage1" style="width:100%" onchange="Image1();" required/></td>
								</tr>
								<tr>
									<td colspan="2"><small id="image11" style="display:none;color:red"><b>Invalid Image Format</b></small><small id="image12" style="display:none;color:red"><b>Size is not suitable</b></small></td>
								</tr>
								<tr>
									<td><b style="color:#34495e">Second Image</b></td>
									<td style="overflow:hidden"><input type="file" class="btn btn-info" name="postImage2" id="postImage2" style="width:100%" onchange="Image2();" required/></td>
								</tr>
								<tr>
									<td colspan="2"><small id="image21" style="display:none;color:red"><b>Invalid Image Format</b></small><small id="image22" style="display:none;color:red"><b>Size is not suitable</b></small></td>
								</tr>
								<tr>
									<td><b style="color:#34495e">Video</b></td>
									<td style="overflow:hidden"><input type="file" class="btn btn-info" name="postVideo1" id="postVideo1" style="width:100%" onchange="Video1();" required/></td>
								</tr>
								<tr>
									<td colspan="2"><small id="image31" style="display:none;color:red"><b>Invalid Video Format</b></small><small id="image32" style="display:none;color:red"><b>Size is not suitable</b></small></td>
								</tr>
								<tr>
									<td colspan="2"><center><input type="submit" name="Post" id="add" class="form-control btn addNews_Button" value="Post" onclick="return checkFiles();" style="width:40%"/></center></td>
								</tr>
							</table>
						</form>
						</div>
					</c:when>
					<c:otherwise>
						<div class="addNews_SecondDiv">
							<h3><b>Sorry you can only post one news per day ...</b></h3>
						</div>
					</c:otherwise>
					</c:choose>
				</div>
				<!-- =============== Right Section of Add-News menu End ============== -->
		</div>
		<!-- ===================== Add your news End ====================== -->
		<!-- ===================== Find & Add Friend ====================== -->
	    <div id="menu2" class="tab-pane fade">
	    	<!-- =============== Follow friends functionality =============== -->
	    	<div ng-controller="mycontroller_SearchFriends" class="col-sm-6">
	    	<div>
	    		<table class="table_UserSearch">
	    			<tr>
	    				<td style="width:20%"><b style="color:#34495e">Enter the name</b></td>
	    				<td style="width:60%"><input type="text" id="mytext" ng-change="getOtherUsers();" ng-model="mypostdata.mytext" class="form-control"/></td>
	    			</tr>
		      	</table>
	      	</div>
	      	<div class="userList_Div">
		      	<p id="message1" style="display:none;color:#c0392b"><b>No such user found...</b></p>
		      	<table>
					<tr ng-repeat="x in mydata">
						<td style="width:40%;padding:1%"><b style="color:#34495e">{{x.name}}</b></td>
						<td style="width:40%;padding:1%"><b style="color:#34495e">{{x.email}}</b></td>
						<td style="width:10%;padding:1%"><center><input type="button" value="Follow" ng-click="add(x.id,x.name);" class="btn follow_Button"/></center></td>
					</tr>
				</table>
			</div>
			</div>
			<!-- ==================== Follow friends instruction =============== -->
			<div class="col-sm-4">
				<h1 style="color:#34495e"><b>Follow your friends</b></h1>
	      		<blockquote>
	      		Follow your friends to chat with them
	      		</blockquote>
			</div>
	    </div>
	    <!-- ==================== Find & Add Friend End ==================== -->
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
	  <!-- ======================================= Navigation Section End ===================================== -->
	</section>
	<!-- ================================================================= WebPage Main End ================================================================= -->
	<!-- =============================================================== WebPage Footer Start =============================================================== --> 
	<footer style="" class="myfooter">
		<center><h1>Thankyou To Join Us</h1></center>
	</footer>
	<!-- =============================================================== WebPage Footer End ================================================================= -->
</body>
</html>