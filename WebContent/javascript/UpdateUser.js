app.controller("mycontroller_UpdateUser",function($scope,$http)
{
	$scope.mydata = {};
	$scope.mydata.id = $scope.id;
	$scope.flag = true;
	$scope.flagButton = false;
	$scope.update = function()
	{
		$scope.mydata.name = document.getElementById("name").value;
		$scope.mydata.gender = document.getElementById("gender").value;
		$scope.mydata.email = $scope.userEmail;
		$http.post("UpdateAccount",$scope.mydata).then(function(response){
			if(response.data.result>0)
			{
				alert("Data Updated !");
				window.location.reload();
			}
		},
		function(error){
			
		});
	}
	$scope.myemail = {};
	$scope.myemail.id = $scope.id;
	$scope.validateEmail = function()
	{
		$scope.myemail.email = document.getElementById("email").value;
		$http.post("VALIDATE_USER_UPDATE_EMAIL",$scope.myemail).then(function(response){
			if(response.data.number>0)
			{
				$scope.flag = false;
				$scope.flagButton = true;
			}
			else
			{
				$scope.flag = true;
				$scope.flagButton = false;
			}
		},
		function(error)
		{
			
		});
	}
});