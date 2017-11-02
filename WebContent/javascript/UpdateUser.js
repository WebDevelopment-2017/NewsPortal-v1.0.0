app.controller("mycontroller_UpdateUser",function($scope,$http)
{
	$scope.mydata={};
	$scope.mydata.id=$scope.id;
	$scope.update=function()
	{
		$scope.mydata.name=document.getElementById("name").value;
		$scope.mydata.gender=document.getElementById("gender").value;
		$scope.mydata.email=document.getElementById("email").value;
		$http.post("UpdateAccount",$scope.mydata).then(function(response){
			if(response.data.result>0)
			{
				alert("Data Updated !");
				window.location.reload();
			}
		},
		function(error){
			
		});
		alert($scope.mydata);
	}
});