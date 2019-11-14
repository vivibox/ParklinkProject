

$(document).ready(function() { 
    // Fetch the initial table 
    refreshTable(); 

    // Fetch every 5 seconds 
    setInterval(refreshTable, 5000); 
});




function refreshTable() {

    $.ajax({
            type:"get",
            url:"admin_json.jsp",
            dataType:'json',
            success:function (data) {
            	queryTable(data);
            	console.log(data);
            	
            },
            error: function(XMLHttpRequest, textStatus, errorThrown) {
            	console.log(XMLHttpRequest.status);
            	console.log(XMLHttpRequest.readyState);
            	console.log(textStatus);
            	},
           });

        function queryTable(data){
	 

        	let enterInfo = '' ;
        	let exitInfo = '' ;
        	let con ='' ;
        	let enterUrl ='' ;
        	let exitUrl = '' ;
        	for(let i = 0 ; i < data['enterCar'].length ; i++){
        		  
        		enterInfo +='<tr><td>車牌號碼:'+data['enterCar'][i].enterPlate+'</td></tr>'

        		enterInfo +='<tr><td>'+data['enterCar'][i].enterEnter+'</td></tr>'

        		enterUrl +='<img src="images/db/'+data['enterCar'][i].enterUrl+'" width="100%">'
        		       
        	}
        	console.log("enterInfo-done");
        	document.getElementById('enter_table').innerHTML = enterInfo ;
        	document.getElementById('enterUrl').innerHTML = enterUrl ;
        	
        	for(let i = 0 ; i < data['exitCar'].length ; i++){
        		  
       			exitInfo +='<tr><td>車牌號碼：'+data['exitCar'][i].exitPlate+'</td></tr>'

       			exitInfo +='<tr><td>停車時間：'+data['exitCar'][i].parkingTime+'分鐘</td></tr>'
       			exitUrl +='<img src="images/db/'+data['exitCar'][i].exitUrl+'" width="100%">'
       			      
        	}
        	console.log("exitInfo-done");
        	document.getElementById('exit_table').innerHTML = exitInfo ;
        	
        	document.getElementById('exitUrl').innerHTML = exitUrl ;
        	
        	for(let i = 0 ; i < data['conEmpty'].length ; i++){
       			con +='<p>空位'+data['conEmpty'][i].conEmpty+'個</p>'    
        	}

        	document.getElementById('con').innerHTML = con ;
        	console.log("all-done");
        	
		};
		
		
};



