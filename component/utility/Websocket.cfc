/**
 * Websocket
 * @author ${user}
 * @date ${date}
**/

component {

	remote any function setAlertSocket(i) {

		aO = CreateObject("component", "MCMS.component.Alert");
		myResult = aO.setAlert();

		objResponse = '#myResult#';

		return objResponse;
	}

}