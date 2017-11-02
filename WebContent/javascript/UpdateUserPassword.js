//-- Update User Password --
app.controller("mycontroller_UpdateUserPssword",function($scope,$http)
{
	$scope.mydata = {};
	$scope.mydata.id = $scope.id;
	$scope.postdata = {}
	$scope.postdata.id = $scope.id;
	$scope.compareOldPassword = function()
	{
		$http.post("VALIDATE_USER_UPDATE_PASSWORD",$scope.mydata).then(function(response){
			$scope.oldPassword=response.data.password;
		},function(error)
		{
			
		});
	}
	$scope.updatePassword = function()
	{
		$scope.postdata.password=$scope.confirmPassword
		$http.post("USER_PASSWORD_UPDATE",$scope.postdata).then(function(response){
			if(response.data.result>0)
			{
				$scope.oldPassword="";
				$scope.newPassword="";
				$scope.confirmPassword="";
				$scope.userPassword="";
				alert("Password Updated !");
			}
		},function(error)
		{
			
		})
	}
});