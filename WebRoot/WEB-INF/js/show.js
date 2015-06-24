
function showHide(){
//alert($(parent.document).find("frameset[id=main]").attr("cols"));
if($(parent.document).find("frameset[id=main]").length>0){
	if ($(parent.document).find("frameset[id=main]").attr("cols") == "210,*") {
		//alert(1);	
		$(parent.document).find("frameset[id=main]").attr("cols","7,*");
		$(parent.frames["leftFrame"].document).find(".demo").hide();
		//$(parent.frames["leftFrame"].document).find("#arrow").toggleClass("close_2 open_2");
		$(parent.frames["leftFrame"].document).find("#arrow").removeClass();
		$(parent.frames["leftFrame"].document).find("#arrow").addClass("open_2");
		$("#show").attr("src","/portal/css/default/images/sideBar_arrow_right.jpg");
		$("#show").attr("title","展开");
	}else{
		//alert(2);
		$(parent.document).find("frameset[id=main]").attr("cols","210,*");
		$(parent.frames["leftFrame"].document).find(".demo").show();
		$(parent.frames["leftFrame"].document).find("#arrow").removeClass();
		$(parent.frames["leftFrame"].document).find("#arrow").addClass("close_2");
		$("#show").attr("src","/portal/css/default/images/sideBar_arrow_left.jpg");
		$("#show").attr("title","收起");
	}
}
}

function loadShow(){
	var show_left='';
	var url=window.location.search;
	if(url.indexOf("?")!=-1)   
	{   
	  var str   =   url.substr(1)   
	  strs = str.split("&");   
	  for(i=0;i<strs.length;i++)   
	  {   
	    if([strs[i].split("=")[0]]=='show_left') show_left=unescape(strs[i].split("=")[1]);
	  }   
	}
	if($(parent.document).find("frameset[id=main]").length>0){
		if(show_left=='on'){		
			$(parent.document).find("frameset[id=main]").attr("cols","210,*");
			$(parent.frames["leftFrame"].document).find(".demo").show();
			$(parent.frames["leftFrame"].document).find("#arrow").removeClass();
			$(parent.frames["leftFrame"].document).find("#arrow").addClass("close_2");
			$("#show").attr("src","/portal/css/default/images/sideBar_arrow_left.jpg");
			$("#show").attr("title","收起");
		}else if(show_left=='off'){
			$(parent.document).find("frameset[id=main]").attr("cols","7,*");
			$(parent.frames["leftFrame"].document).find(".demo").hide();
			$(parent.frames["leftFrame"].document).find("#arrow").removeClass();
			$(parent.frames["leftFrame"].document).find("#arrow").addClass("open_2");
			$("#show").attr("src","/portal/css/default/images/sideBar_arrow_right.jpg");
			$("#show").attr("title","展开");
		}else{
			if ($(parent.document).find("frameset[id=main]").attr("cols") == "210,*") {
				$(parent.frames["leftFrame"].document).find(".demo").show();
				$(parent.frames["leftFrame"].document).find("#arrow").removeClass();
				$(parent.frames["leftFrame"].document).find("#arrow").addClass("close_2");
				$("#show").attr("src","/portal/css/default/images/sideBar_arrow_left.jpg");
				$("#show").attr("title","收起");
			}else{
				$(parent.frames["leftFrame"].document).find(".demo").hide();
				$(parent.frames["leftFrame"].document).find("#arrow").removeClass();
				$(parent.frames["leftFrame"].document).find("#arrow").addClass("open_2");
				$("#show").attr("src","/portal/css/default/images/sideBar_arrow_right.jpg");
				$("#show").attr("title","展开");
			}
		}
	}
}

function showHideForLeft(){
	if($(parent.document).find("frameset[id=main]").length>0){
		if($(".menuOne").length>0){
			if ($(parent.document).find("frameset[id=main]").attr("cols") == "210,*") {
				$(parent.document).find("frameset[id=main]").attr("cols","7,*");
				$(".demo").hide();
				$("#arrow").removeClass();
				$("#arrow").addClass("open_2");
				$(parent.frames["mainFrame"].document).find("#show").attr("src","/portal/css/default/images/sideBar_arrow_right.jpg");
				$(parent.frames["mainFrame"].document).find("#show").attr("title","展开");
			}else{
				$(parent.document).find("frameset[id=main]").attr("cols","210,*");
				$(".demo").show();
				$("#arrow").removeClass();
				$("#arrow").addClass("close_2");
				$(parent.frames["mainFrame"].document).find("#show").attr("src","/portal/css/default/images/sideBar_arrow_left.jpg");
				$(parent.frames["mainFrame"].document).find("#show").attr("title","收起");
			}
		}else{
			
		}
	}
}


function loadShowForLeft(){
	if($(parent.document).find("frameset[id=main]").length>0){
		if ($(parent.document).find("frameset[id=main]").attr("cols") == "210,*") {
			$(".demo").show();
			$("#arrow").removeClass();
			$("#arrow").addClass("close_2");
			$(parent.frames["mainFrame"].document).find("#show").attr("src","/portal/css/default/images/sideBar_arrow_left.jpg");
			$(parent.frames["mainFrame"].document).find("#show").attr("title","收起");
		}else{
			$(".demo").hide();
			$("#arrow").removeClass();
			$("#arrow").addClass("open_2");
			$(parent.frames["mainFrame"].document).find("#show").attr("src","/portal/css/default/images/sideBar_arrow_right.jpg");
			$(parent.frames["mainFrame"].document).find("#show").attr("title","展开");
		}
	}
}
/*
function loadShow(){
	if($(parent.document).find("frameset[id=main]").length>0){
		if ($(parent.document).find("frameset[id=main]").attr("cols") == "210,*") {
			//alert(1);
			//$(parent.document).find("frameset[id=main]").attr("cols","0,*");
			$("#show").attr("src","/portal/css/default/images/sideBar_arrow_left.jpg");
			$("#show").attr("title","收起");
		}else{
			//alert(2);
			//$(parent.document).find("frameset[id=main]").attr("cols","210,*");
			
			$("#show").attr("src","/portal/css/default/images/sideBar_arrow_right.jpg");
			$("#show").attr("title","展开");
		}
	}
}
*/

