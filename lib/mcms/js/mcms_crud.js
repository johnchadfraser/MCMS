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

});