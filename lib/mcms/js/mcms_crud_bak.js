//TODO: MCMS multiline comments.

//Show rows per page select
function showRowsPerPage(url) {

	window.location = url;
	
}

/* Set the width of the side navigation to 250px */
function openNav() {
	document.getElementById("mcmsQuerySideBar").style.width = "325px";
  }
  
  /* Set the width of the side navigation to 0 */
  function closeNav() {
	document.getElementById("mcmsQuerySideBar").style.width = "0";
  }

function clearForm(myFormElement) {

	var myFormElement = document.getElementById(myFormElement);
	
	var elements = myFormElement.elements;
  
	myFormElement.reset();
  
	for(i=0; i<elements.length; i++) {
  
		field_type = elements[i].type.toLowerCase();
  
		switch(field_type) {
  
			case "text":
			case "password":
			case "textarea":
  
			elements[i].value = "";
		
			break;
	
			case "radio":
			case "checkbox":
			
			if (elements[i].checked) {

				elements[i].checked = false;

				}

			break;
	
			case "select-one":
			case "select-multi":

				elements[i].selectedIndex = -1;

			break;
	
			default:
			
			break;

		}

	}
}

//Begin jQuery intialization.
$(function() {

	//Fade alert message.
	$("#mcmsMessageFade").fadeTo(2000, 500).slideUp(500, function(){
		$("#mcmsMessageFade").slideUp(500);
	});

	// Activate tooltips
	$('[data-toggle="tooltip"]').tooltip();
        
	// Filter table rows based on searched term
	$("#search").on("keyup", function() {
		var term = $(this).val().toLowerCase();
		$("table tbody tr").each(function(){
		
			$row = $(this);

			var name = $row.find("td").text().toLowerCase();

			console.log(name);
			if(name.search(term) < 0){                
				$row.hide();
			} else{
				$row.show();
			}
		});
	});

// Select/Deselect checkboxes
var checkbox = $('table tbody input[type="checkbox"]');
$("#selectAll").click(function(){
	if(this.checked){
		checkbox.each(function(){
			this.checked = true;                        
		});
	} else{
		checkbox.each(function(){
			this.checked = false;                        
		});
	} 
});
checkbox.click(function(){
	if(!this.checked){
		$("#selectAll").prop("checked", false);
	}
});

//Show create modal.
$("#mcmsCreateBtn").on("click", function(e){
	// Prevent default action, which is to submit.
	e.preventDefault(); 
	
   
	//Hide message if shown.
	$('#mcmsCreateMessage').hide();
  
	// Validate the form.
	$('#formCreate').valid();

	// Call the ajax post method if validation is successful.
	if($('#formCreate').valid()){ 
		$.ajax({
		async: true,
		url: '',
		type: 'POST',
		data: $('#formCreate').serialize(),
		success: function(data, response, status){
  	
			//Alert the success, show the message, fade out the message.	
  			$('#mcmsCreateMessage').addClass("alert alert-success");
  			$('#mcmsCreateMessage').show();
  			$('#mcmsCreateMessage').html('You have successfully created the record.');
  			$("#mcmsCreateMessage").fadeTo(2000, 500).slideUp(500, function(){
    		$("#mcmsCreateMessage").slideUp(500);
    		console.log(response);
    		
    		//Reset the form.
    		$("#formCreate").trigger("reset");
    		
    		$('#createForm').modal('hide');
    		
    		
    		$('#updateForm').modal('show');
    		
    		id=formCreate.mcmsCreateID.value;
    		//Get the pageID for the form post path.
    		pageID=formCreate.mcmsPageID.value;
    		$.ajax({
    	  	async: true,
    	  	url: pageID + '/view/' + '',
    	  	type: 'GET',
    	  	data: {'ID': id, 'mcmsPageID': pageID},
    	  	success: function(result){
    	  		console.log(result);
    	  		$('#mcmsUpdateFormContainer').html(result);
    	  		}	
    		});
    
    		//Reload the datatable on close.
    		$("#createForm").on("hidden.bs.modal", function (){
    	
  				//TODO: Better solution for datatables reload.
  				//window.location.reload();
		});
    
	});
  	
  	
  	},
  	
  		error: function(data){
  		
  			$('#mcmsCreateMessage').addClass("alert alert-danger");
  			$('#mcmsCreateMessage').show();
  			$('#mcmsCreateMessage').html('Failed');
  			console.log(data.responseText);
  	
  		}
  	
  		})
  
  	}

});


//Update the data in update modal within a row.
$("#mcmsUpdateRowBtn ").on("click", function(e){
  
	//Prevent default action, which is to submit.
	e.preventDefault(); 
   
	//Hide message if shown.
	$('#mcmsCreateMessage').hide();
  
	// Validate the form.
	$('#formUpdateRow').valid();
	
	

	// Call the ajax post method if validation is successful.
	if($('#formUpdateRow').valid()) { 
  
		$.ajax({
		url: '',
		type: 'POST',
		data: $('#formUpdateRow').serialize(),
		success: function(data, response, status){
  	
  			//Alert the success, show the message, fade out the message.	
  			$('#mcmsUpdateRowMessage').addClass("alert alert-success");
  			$('#mcmsUpdateRowMessage').show();
  			$('#mcmsUpdateRowMessage').html('You have successfully updated the record.');
  			$("#mcmsUpdateRowMessage").fadeTo(2000, 500).slideUp(500, function(){
    		$("#mcmsUpdateRowMessage").slideUp(500);
    		
    		
    
    		//Reload the datatable on close.
    		$("#updateFormRow").on("hidden.bs.modal", function () {
    			
  			//TODO: Better solution for datatables reload.
  			//window.location.reload();
  			//alert();
  			
  			
		});
    
	});
  	
  	},
  	
  		error: function(data){
  		
  			$('#mcmsUpdateRowMessage').addClass("alert alert-danger");
  			$('#mcmsUpdateRowMessage').show();
  			$('#mcmsUpdateRowMessage').html('Failed');
  	
  		}
  	
	})
  
	}

});

//Update the data in update modal.
$("#mcmsUpdateBtn").on("click", function(e){
	
	//Prevent default action, which is to submit.
	e.preventDefault(); 
   
	//Hide message if shown.
	$('#mcmsCreateMessage').hide();
  
	// Validate the form.
	$('#formUpdate').valid();

	// Call the ajax post method if validation is successful.
	if($('#formUpdate').valid()) { 
  
		$.ajax({
		url: '',
		type: 'POST',
		data: $('#formUpdate').serialize(),
		success: function(data, response, status){
  	
  			//Alert the success, show the message, fade out the message.	
  			$('#mcmsUpdateMessage').addClass("alert alert-success");
  			$('#mcmsUpdateMessage').show();
  			$('#mcmsUpdateMessage').html('You have successfully updated the record.');
  			$("#mcmsUpdateMessage").fadeTo(2000, 500).slideUp(500, function(){
    		$("#mcmsUpdateMessage").slideUp(500);
    
    		//Reload the datatable on close.
    		$("#updateForm").on("hidden.bs.modal", function () {
    			
  			//TODO: Better solution for datatables reload.
  			window.location.reload();
  			
		});
    
	});
  	
  	},
  	
  		error: function(data){
  		
  			$('#mcmsUpdateMessage').addClass("alert alert-danger");
  			$('#mcmsUpdateMessage').show();
  			$('#mcmsUpdateMessage').html('Failed');
  	
  		}
  	
	})
  
	}

});


//This function is used to delete a record from the datatable.
$(".mcmsDeleteResult").click(function(){

	var element = $(this);
	var idList = element.attr("id");
	
		mcmsUpdateResult(idList);

	return false;
	
});


//This function checks a row in the datatable.
$(".mcmsCheckResult").click(function(){

	var element = $(this);
	var chk_id = element.attr("id");
	var chk_name = element.attr("name");
	var unchk_name = 'mcmsUn' + chk_name.replace('mcms', '');
	
	$('#idList').val($('#idList').val() + ($('#idList').val() ? ',' :'') + chk_id);
	$('#row' + chk_id).css('backgroundColor','#fff2e6');
	$('a[name='+chk_name+']').hide();
	$('a[name='+unchk_name+']').show();

	return false;
	
});


$(".mcmsUnCheckResult").click(function() {
	
	var element = $(this);
	
	chk_id = element.attr("id");
	
	var unchk_name = element.attr("name");
	var chk_name = unchk_name.replace('Un', '');
	var chkArray = [];
	
	chkArray = $('#idList').val().split(",");
	
	var i = jQuery.inArray(chk_id, chkArray);
	
	chkArray.splice(i, 1);
	$('#idList').val(chkArray);
	$('#row' + chk_id).css('backgroundColor','#fff');
	$('a[name='+unchk_name+']').hide();
	$('a[name='+chk_name+']').show();

	return false;
	
});



	
	







//End jQuery intialization.
});


//This js function is used to delete checked records from the datatable.
function mcmsUpdateResult(idList){
	
	if (idList == null || idList == ''){
	
	$('#mcmsDeleteChecked').modal({
	show: true,
	focus: true,
      backdrop: 'static',
      keyboard: false
    });
	
	} else {
		
	var data = {
		
		mcmsUpdateResult: 'true',
		idList: idList
		
	}
	
	var temp = new Array();
	
	//This will return an array with strings "1", "2", etc.
	temp = idList.split(",");
	
	$('#mcmsDeleteConfirm').modal('show');
	
	$('#mcmsDeleteConfirm .btn-ok').on('click', function(event) {
		
		
		
		$.ajax({
			type: "POST",
			url: '',
			data: data,
			success: function(data, response, status){  	
				
				//Remove deleted lines from result.
				for (i=0; i < temp.length; i++) {
		
				$('#row' + temp[i]).remove();
	
				};
				
				//Cancel the model now to close the modal and return focus to the results page.
				$('#mcmsDeleteConfirm #mcmsModalCancel').click();
				
				//Alert the success, show the message, fade out the message.	
  				$('#mcmsUpdateResultMessage').addClass("alert alert-success");
  				$('#mcmsUpdateResultMessage').show();
  				$('#mcmsUpdateResultMessage').html('You have successfully updated the results.');
  				
  				$("#mcmsUpdateResultMessage").fadeTo(2000, 500).slideUp(500, function(){
    	
    			$("#mcmsUpdateResultMessage").slideUp(500);
    			
    			//TODO: Better solution for datatables reload.
  				window.location.reload();
    			
				 
				});
				
				
		
			}
	
		});

});
	
	
}

//return false;

}
