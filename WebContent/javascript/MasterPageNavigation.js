$(document).ready(function(){
	closeAll();
	$("#home").click(function(){
    	closeAll();
    });
    $("#menu").click(function(){
    	closeAll();
        $("#sub-menu").slideToggle("slow");
    });
    $("#menu1").click(function(){
    	closeAll();
        $("#sub-menu1").slideToggle("slow");
    });
    $("#menu2").click(function(){
    	closeAll();
        $("#sub-menu2").slideToggle("slow");
    });
    $("#menu3").click(function(){
    	closeAll();
        $("#sub-menu3").slideToggle("slow");
    });
    $("#menu4").click(function(){
    	closeAll();
        $("#sub-menu4").slideToggle("slow");
    });
    $("#menu5").click(function(){
    	closeAll();
        $("#sub-menu5").slideToggle("slow");
    });
    $("#menu6").click(function(){
    	closeAll();
        $("#sub-menu6").slideToggle("slow");
    });
    $("#menu7").click(function(){
    	closeAll();
        $("#sub-menu7").slideToggle("slow");
    });
    $("#menu8").click(function(){
    	closeAll();
        $("#sub-menu8").slideToggle("slow");
    });
    function closeAll()
    {
    	 $("#sub-menu").slideUp("slow");
    	 $("#sub-menu1").slideUp("slow");
    	 $("#sub-menu2").slideUp("slow");
    	 $("#sub-menu3").slideUp("slow");
    	 $("#sub-menu4").slideUp("slow");
    	 $("#sub-menu5").slideUp("slow");
    	 $("#sub-menu6").slideUp("slow");
    	 $("#sub-menu7").slideUp("slow");
    	 $("#sub-menu8").slideUp("slow");
    }
});