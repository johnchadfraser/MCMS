// Stock websocket.
function msgStockHandler(msgobj){	 
var socketMessage = document.getElementById('stockSocket'); 
var message = msgobj.data;
if (message == undefined) {
socketMessage.innerHTML = '';
} else {
socketMessage.innerHTML = message;
}
}
 
function invokeStock() { 
stockSocket.invoke("dashboard.MCMS.component.utility.Websocket", "setStockSocket"); 
}

