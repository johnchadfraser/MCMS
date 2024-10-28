//Ajax link feature for cflayout.--->

function mcmsAjax(layout,appID,tab,path,mcmsPageID,mcmsID,ID,mcmsWorkFlowStatus) {
//initiate the proxy with a local var 
var l = new ajaxl();
//define the display function 

var ajaxCall = function(l) {

var url = path + '?appID=' + appID + '&mcmsPageID=' + mcmsPageID + '&mcmsID=' + mcmsID + '&ID=' + ID + '&mcmsWorkFlowStatus=' + mcmsWorkFlowStatus;

setTimeout(function() {ColdFusion.Layout.selectTab(layout,tab)}, 1000);
setTimeout(function() {ColdFusion.navigate(url,tab)}, 5000);
	
}

// Error handler for the asynchronous functions. 
var ajaxErrorHandler = function(statusCode, statusMsg) 
{ 
alert('Status: ' + statusCode + ', ' + statusMsg); 
} 

l.setCallbackHandler(ajaxCall);
//define the error handler 
l.setErrorHandler(ajaxErrorHandler);
//call the function from the CFC 
l.linkAjax(layout,appID,tab,path,mcmsPageID,mcmsID,ID,mcmsWorkFlowStatus);

}

//////////////////////////////////////////////////////////////////////////////////////////////////

//Link into cflayout tab.
function mcmsTaskDirect(t,u,v,w,x,y,z,zz) {
setTimeout(function() {ColdFusion.Layout.selectTab('layoutIndex',z)}, 2000);
setTimeout(function() {ColdFusion.navigate(t + u + '?appID=' + v + '&mcmsPageID=' + w + '&mcmsID=' + x + '&ID=' + y + '&mcmsDirect=true&mcmsWorkFlowStatus=' + zz, z)}, 2000);
}

function mcmsDirect(t,u,v,w,x,y,z,zz) {
setTabDirect(t,u,v,w,x,y,z,zz);
}

//////////////////////////////////////////////////////////////////////////////////////////////////

//Text counter function to limit characters of a text field.

function mcmsTextCounter(field, countfield, maxlimit) {
if (field.value.length > maxlimit) // if too long...trim it!
field.value = field.value.substring(0, maxlimit);
// otherwise, update 'characters left' counter
else 
countfield.value = maxlimit - field.value.length;
}

//////////////////////////////////////////////////////////////////////////////////////////////////

//Open window function.

function mcmsOpenWindow(location,name,w,h,x,y)
{
mywindow= window.open (location, name, 'location=1,status=1,scrollbars=0,width=' + w + ',height=' + h);
mywindow.moveTo(x,y);
}

//////////////////////////////////////////////////////////////////////////////////////////////////

//Set a session timeout warning.

function mcmsSessionTimeout(timeLength) {
setTimeout(function() {
blanket_size('mcmsBlanket');
showDiv('mcmsTimeoutMessage');
showDiv('mcmsBlanket');
document.body.style.overflow="hidden";
document.getElementById('mcmsTimeoutMessage').innerHTML = 
'<strong>Your session has expired!</strong><br /><br /><i>You must "Sign In" again to continue.</i><br /><br /><a href="/app/authenticate/"><span class="glyphicon glyphicon-lock"></span>Sign In</a>';
}, timeLength*1000);
}

//////////////////////////////////////////////////////////////////////////////////////////////////

//Countdown function.

function timeoutCountdown(countDownInterval,countDownTime){
var counter = 0;
var node = document.getElementById("mcmsTimeoutCounter");
var nodeValue = document.getElementById("mcmsTimeoutCounter").innerHTML;
if (nodeValue == '') {
minVar = Math.floor(countDownTime/60);  // The minutes
secVar = countDownTime % 60;            // The balance of seconds
document.getElementById('mcmsTimeoutCounter').innerText = "Session Timeout: "+ minVar + " min. " + secVar + " sec.";
countDown(countDownInterval,countDownTime);
} else {
if(countDownTime == countDownTime) {	
clearTimeout(counter);
}
minVar = Math.floor(countDownTime/60);  // The minutes
secVar = countDownTime % 60;            // The balance of seconds
document.getElementById('mcmsTimeoutCounter').innerText = "Session Timeout: "+ minVar + " min. " + secVar + " sec.";
countDown(countDownInterval,countDownTime);
}
}

//////////////////////////////////////////////////////////////////////////////////////////////////

function countDown(countDownInterval,countDownTime){
countDownTime--;
if (countDownTime <=0){
countDownTime=countDownInterval;
clearTimeout(counter);
} else {	
minVar = Math.floor(countDownTime/60);  // The minutes
secVar = countDownTime % 60;            // The balance of seconds
document.getElementById('mcmsTimeoutCounter').innerText = "Session Timeout: "+ minVar + " min. " + secVar + " sec.";
counter=setTimeout(function() {countDown(countDownInterval,countDownTime)}, 1000);
}
}

//////////////////////////////////////////////////////////////////////////////////////////////////

//Create a div that covers the whole page.

function blanket_size(popUpDivVar) {
if (typeof window.innerWidth != 'undefined') {
viewportheight = window.innerHeight;
} else {
viewportheight = document.documentElement.clientHeight;
}
if ((viewportheight > document.body.parentNode.scrollHeight) && (viewportheight > document.body.parentNode.clientHeight)) {
blanket_height = viewportheight;
} else {
if (document.body.parentNode.clientHeight > document.body.parentNode.scrollHeight) {
blanket_height = document.body.parentNode.clientHeight;
} else {
blanket_height = document.body.parentNode.scrollHeight;
}
}
var blanket = document.getElementById('mcmsBlanket');
blanket.style.height = blanket_height + 'px';
var popUpDiv = document.getElementById(popUpDivVar);
}

//////////////////////////////////////////////////////////////////////////////////////////////////

// Table sorter.

function initializeAddOns(rowCount, tableID, pagerID) {
  $("#" + tableID) 
  .tablesorter({widgets: ['zebra']}) 
  .tablesorterPager({container: $("#" + pagerID), positionFixed: false, size: [rowCount]});
}

//////////////////////////////////////////////////////////////////////////////////////////////////

// Chrome fix for FCKEditor.

function FCKeditor_OnComplete(editorInstance) {

 if( editorInstance.GetHTML() == '&nbsp;' )
   {
      jQuery( editorInstance.EditorDocument.body ).html( '' );
   }
}

//////////////////////////////////////////////////////////////////////////////////////////////////

//Place focus into FCKEditor.

function focusEditor(i) {
myField = document.getElementsByName(i).item(0).id; 
myEditor = FCKeditorAPI.GetInstance(myField); 
myEditor.Focus();
}

//////////////////////////////////////////////////////////////////////////////////////////////////

//Set focus to input form within AJAX.
function setFocusAction(x,i) {
formName = document.getElementsByName(x).item(0).id; 
formField = eval('document.' + formName + '.' + i + '.focus();');
}

function setFocus(x,i) {
setTimeout(function() {setFocusAction(x,i)}, 1000);
}

//////////////////////////////////////////////////////////////////////////////////////////////////

//Detect if caps lock is on.

function capLock(e){
 kc = e.keyCode?e.keyCode:e.which;
 sk = e.shiftKey?e.shiftKey:((kc == 16)?true:false);
 if(((kc >= 65 && kc <= 90) && !sk)||((kc >= 97 && kc <= 122) && sk))
  document.getElementById('capsLock').style.visibility = 'visible';
 else
  document.getElementById('capsLock').style.visibility = 'hidden';
}

//////////////////////////////////////////////////////////////////////////////////////////////////

//Call print function.

var autoPrint = true; 

function printPage(ID)
{
	if (document.getElementById != null)
	{
		var html = '<HTML>\n<HEAD><style>body {overflow-x: hidden;} </style>\n';

		if (document.getElementsByTagName != null)
		{
			var headTags = document.getElementsByTagName("head");
			if (headTags.length > 0)
				html += headTags[0].innerHTML;
		}
		
		html += '\n</HE' + 'AD>\n<BODY>\n';
		
		var printPageElem = document.getElementById(ID);
		
		if (printPageElem != null)
		{
				html += printPageElem.innerHTML;
		}
		else
		{
			alert("Could not find the section in the HTML");
			return;
		}
			
		html += '\n</BO' + 'DY>\n</HT' + 'ML>';
		
		var printWin = window.open("","printPage",'toolbar=no,width=900,height=640,scrollbars=yes,dependent=yes');
		printWin.document.open();
		printWin.document.write(html);
		printWin.document.close();
		if (autoPrint)
			printWin.print();
	}
	else
	{
		alert("Sorry, the print ready feature is only available in modern browsers.");
	}
}
//////////////////////////////////////////////////////////////////////////////////////////////////

// Convert to uppercase function.

function upperCase(x)
{
var y=document.getElementById(x).value;
document.getElementById(x).value=y.toUpperCase();
}

//////////////////////////////////////////////////////////////////////////////////////////////////

// Show hide tree.

function showHideTree(ID) {
	var obj = document.getElementById(ID);
	var objRootFolder = document.getElementById(ID+'root');
	var objChildFolder = document.getElementById(ID+'child');
	if (obj.style.display == 'block') {
	obj.style.display = 'none';
	if (objRootFolder) {
	objRootFolder.src = '/MCMS/assets/icon/folder_root.gif'; }
	if (objChildFolder) {
	objChildFolder.src = '/MCMS/assets/icon/folder.gif'; }
	} else {
	obj.style.display = 'block';
	if (objRootFolder) {
	objRootFolder.src = '/MCMS/assets/icon/folder_root_open.gif'; }
	if (objChildFolder) {
	objChildFolder.src = '/MCMS/assets/icon/folder_open.gif'; }
	}
}

//////////////////////////////////////////////////////////////////////////////////////////////////

// Hide Div.

function hideDiv(ID) {
	var obj = document.getElementById(ID);
	obj.style.display = 'none';
}

//////////////////////////////////////////////////////////////////////////////////////////////////

// Show Div.

function showDiv(ID) {
	var obj = document.getElementById(ID);
	obj.style.display = 'block';
}

//////////////////////////////////////////////////////////////////////////////////////////////////
