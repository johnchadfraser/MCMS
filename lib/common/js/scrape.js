window.onload = function() {
	
var head = new XMLHttpRequest();
var header = new XMLHttpRequest();
var footer = new XMLHttpRequest();

var remoteURL = "http://cdn.mcms.com/scrape/www/api";

head.open('GET', remoteURL + '/head.json', true);
header.open('GET', remoteURL + '/header.json', true);
footer.open('GET', remoteURL + '/footer.json', true);

head.onload = function () {

  // Begin accessing JSON data here
  var data = JSON.parse(this.response);
  
  if (head.status >= 200 && head.status < 400) {
	  
	  	//console.log(data.result);	  	
	  	document.getElementsByTagName('head')[0].innerHTML = data.result;	  	

  } else {
    
	  console.log("Head Error");
  }
}

header.onload = function () {

	  // Begin accessing JSON data here
	  var data = JSON.parse(this.response);
	  
	  if (header.status >= 200 && header.status < 400) {
		  
		  	//console.log(data.result);
		  	//document.getElementsByTagName('header')[0].innerHTML = data.result;

	  } else {
	    
		  console.log("Header Error");
	  }
	}

footer.onload = function () {

	  // Begin accessing JSON data here
	  var data = JSON.parse(this.responseText);
	  
	  if (footer.status >= 200 && footer.status < 400) {
		  
		  	//console.log(data.result);
		  	//document.getElementsByTagName('footer')[0].innerHTML = data.result;

	  } else {
	    
		  console.log("Footer Error");
	  }
	}

header.send();
head.send();
footer.send();

//Delay the body display so the html can load.

setTimeout(function() {
 	document.getElementsByTagName('body')[0].style.display = 'block';
}, 1500);

}