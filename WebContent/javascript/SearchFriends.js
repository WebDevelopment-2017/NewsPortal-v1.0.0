app.controller("mycontroller_SearchFriends",function($scope,$http){
		var mytext=document.getElementById("mytext").value;
		$http.post("SearchFriends",'{"mytext":"'+mytext+'","myid":"'+$scope.id+'"}').then(function(response)
		{
			$scope.mydata=response.data.myrecords;
			if(response.data.myrecords[0]==null)
			{
				document.getElementById("message1").style.display="block";
			}
			else
			{
				document.getElementById("message1").style.display="none";
			}
		},
		function(error)
		{
			
		});
});