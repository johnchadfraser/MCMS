// JavaScript Document

$(document).ready(function(){
    $('[data-toggle="tooltip"]').tooltip(); 
});

//Trim all form inputs.

$("form").children().each(function(){
	this.value=$(this).val().trim();
	})

//Autotab inputs.
function autotab(original,destination) {
	if (original.getAttribute && original.value.length == original.getAttribute("maxlength")) {
		destination.focus()
	}
}