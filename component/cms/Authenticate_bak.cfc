/**
 * CMS
 * @author ${user}
 * @date ${date}
**/


component {

// [START setAuthentication]

public struct function setAuthentication(required struct args, required string message="An error occurred with the setAuthentication() method.") {
		
	var result.message = application.messageAuthenticationSuccess;
	var result.status = "true";
	
	param name="args.userUserame" default="" type="string"; 
	param name="args.userPassword" default="" type="string"; 
	param name="args.userStatusID" default="1" type="string";

	//Create objects
	authObj = CreateObject("component", "mcms.component.cms.authenticate");
	logObj = CreateObject("component", "mcms.component.cms.log");
		
	//LDAP Authentication type.
	if (args.authenticationType == 101) {

	var ldapServer = application.ldapAuthenticationServer;
	var ldapUserPrefix = application.ldapUserPrefix;
	var ldapUserSuffix = application.ldapUserSuffix;
	var ldapDC = application.ldapDC;

	try {

	//Attempt authentication to LDAP server.
	cfldap(name="ldapAuthenticate", action="query", username="#ldapUserPrefix#\#Replace(args.userUsername, ldapUserSuffix, '', 'ALL')#", password="#args.userPassword#", server="#ldapServer#", attributes="sn,mail,displayName", start="cn=users, dc=#ldapDC#");

	rsAuthenticationUser = invoke(authObj,"getAuthenticationUser", {args=args});

	} catch(any e) {

	//Fail the authentication if unsuccessful to LDAP.
	result.status = "false";
	
	}

	} else {

	//TODO: Develop additional authentication types.

	}

	//If authentication type(s) are successful based on result status.
	if (result.status == "true" && rsAuthenticationUser.recordcount != 0) {

	logArgs = StructNew();
	logArgs.appNo = 0;
	logArgs.lText = args.userUserName & ' has authenticated.';
	logArgs.ltID = 101;
	logArgs.userIP = CGI.REMOTE_ADDR;
	logArgs.userID = rsAuthenticationUser.ID;
	logArgs.saascID = application.saascID;

	//Log the user authentication.
	invoke(logObj,"createLog", {args=logArgs});

	//Create SESSION variables for authenticated user.
	invoke(authObj,"setSessionUserHandler", {args=rsAuthenticationUser});

	//Create application access/permission for authenticated user.
	invoke(authObj,"setAccessPermissionUserHandler", {args=rsAuthenticationUser});

		//Set cookies.
		if (args.userRemember != 'false') {
	
		cfcookie(name="AUTHENTICATEUSERNAME", domain="#CGI.SERVER_NAME#", value="#args.userUsername#", expires="never");

		} else {

		cfcookie(name="AUTHENTICATEUSERNAME", domain="#CGI.SERVER_NAME#", value="", expires="now");

		}

	} else {

	result.status = 'false';
	result.message = application.messageAuthenticationFailed;

	}

	return result;

}

// [END setAuthentication]


// [START getAuthenticationUser]

public query function getAuthenticationUser(required struct args) {

	try {		

		qObj = new query();
		qObj.setDatasource(application.mcmsDSN);
		qObj.setName("q");
		qObj.addParam(name="userUsername",value="#args.userUsername#",cfsqltype="VARCHAR");
		qObj.addParam(name="userStatusID",value="#args.userStatusID#",cfsqltype="VARCHAR");
		qObj.addParam(name="saascID",value="#application.saascID#",cfsqltype="NUMERIC");
		result = qObj.execute(sql="SELECT ID, empID, userUserName, userFName, userLName, userFNameAlt, userLNameAlt, userEmail, userEmailAlt, userTelephone, userTelephoneExt, userMobile, urID, urName, uTitleName, utID, utName, userDigitalSignatureID, siteNoPrimary, deptNoPrimary FROM V_USER WHERE userUsername= :userUsername AND userStatusID IN (:userStatusID) AND saascID = :saascID");
		q = result.getResult();
		recordcount = q.recordcount;
		qObj.clearParams();
		result = q;
		return result;

	} catch(any e) {

		message = "Authenticate Error: An error occurred with the getAuthenticationUser() function.";
		invoke('application.admin.Application', 'onError', {e=e, eventName=message});

	}		

}

// [END getAuthenticationUser]


// [START setSessionUserHandler]

public string function setSessionUserHandler(required query args) {

	//Create objects
	authObj = CreateObject("component", "MCMS.component.cms.Cms.Authenticate");

	try {		

		session.userAuthenticated = "true";
		session.userID = args.ID;
		session.empID = args.empID;
		session.userUsername = args.userUsername;
		session.userName = args.userFName & ' ' & args.userLName;
		session.userEmail = args.userEmail;
		session.userEmailAlt = args.userEmailAlt;
		session.userTelephone = args.userTelephone;
		session.userTelephoneExt = args.userTelephoneExt;
		session.userMobile = args.userMobile;
		session.urID = args.urID;
		session.urName = args.urName;
		session.userTitleName=args.uTitleName;
		session.utID = args.utID;
		session.utName=args.utName;
		session.userDigitalSignature = args.userDigitalSignatureID;
		session.userSiteNoPrimary = args.siteNoPrimary;
		session.userDeptNoPrimary = args.deptNoPrimary;

	//Name Alt override.
	if (args.userFNameAlt != '') {

	session.userName = args.userFNameAlt & ' ' & args.userLName;

	}

	if (args.userLNameAlt != '') {

	session.userName = args.userFName & ' ' & args.userLNameAlt;

	}

	if (args.userFNameAlt != '' && args.userLNameAlt != '') {

	session.userName = args.userFNameAlt & ' ' & args.userLNameAlt;

	}

	//Set other SESSION variables based on relationships.
	invoke(authObj,"setSessionUserSiteRel", {args=result});
	invoke(authObj,"setSessionUserDeptRel", {args=result});
	invoke(authObj,"setSessionUserRole", {args=result});
	invoke(authObj,"setSessionUserRoleGroupRel", {args=result});

	} catch(any e) {

		message = "Authenticate Error: An error occurred with the setSessionUserHandler() function.";
		invoke('Application', 'onError', {e=e, eventName=message});

	}		

}

// [END setSessionUserHandler]


// [START setSessionUserRole]

public string function setSessionUserRole(required query args) {

	try {		

		qObj = new query();
		qObj.setDatasource(application.mcmsDSN);
		qObj.setName("q");
		qObj.addParam(name="urID",value="#args.urID#",cfsqltype="NUMERIC");
		qObj.addParam(name="urStatusID",value="1",cfsqltype="NUMERIC");
		qObj.addParam(name="saascID",value="#application.saascID#",cfsqltype="NUMERIC");
		result = qObj.execute(sql="SELECT ID, urName FROM TBL_USER_ROLE WHERE ID = :urID AND urStatusID = :urStatusID AND saascID = :saascID");
		q = result.getResult();
		recordcount = q.recordcount;
		qObj.clearParams();
		result = q;

		if (recordcount != 0) {

		session.urID = result.ID;
		session.urName = result.urName;

		}

	} catch(any e) {

		message = "Authenticate Error: An error occurred with the setSessionUserRole() function.";
		invoke('Application', 'onError', {e=e, eventName=message});

	}		

}

// [END setSessionUserRole]


// [START setSessionUserRoleGroupRel]

public string function setSessionUserRoleGroupRel(required query args) {

	try {		

		qObj = new query();
		qObj.setDatasource(application.mcmsDSN);
		qObj.setName("q");
		qObj.addParam(name="urID",value="#args.urID#",cfsqltype="NUMERIC");
		qObj.addParam(name="urgStatusID",value="1",cfsqltype="NUMERIC");
		qObj.addParam(name="saascID",value="#application.saascID#",cfsqltype="NUMERIC");
		result = qObj.execute(sql="SELECT urgID, urgName FROM V_UR_GROUP_REL WHERE urID= :urID AND urgStatusID = :urgStatusID AND saascID = :saascID");
		q = result.getResult();
		recordcount = q.recordcount;
		qObj.clearParams();
		result = q;

		if (recordcount != 0) {

		session.urgID = ValueList(result, urgID);
		session.urgName = ValueList(result, urgName);
		
		//Clear query obj.
		qObj = '';

		//Now collect user group urID's to apply to the session.

		qObj = new query();
		qObj.setDatasource(application.mcmsDSN);
		qObj.setName("q");
		qObj.addParam(name="urgID",value="#args.urID#",cfsqltype="VARCHAR");
		qObj.addParam(name="urStatusID",value="1",cfsqltype="NUMERIC");
		qObj.addParam(name="saascID",value="#application.saascID#",cfsqltype="NUMERIC");
		result = qObj.execute(sql="SELECT urID, urName FROM V_UR_GROUP_REL WHERE urgID= :urID AND urStatusID = :urStatusID AND sasscID = :saascID");
		q = result.getResult();
		recordcount = q.recordcount;
		qObj.clearParams();
		result = q;

		session.urID = ValueList(result, urID);
		session.urName = ValueList(result, urName);

		}

	} catch(any e) {

		message = "Authenticate Error: An error occurred with the setSessionUserRole() function.";
		invoke('Application', 'onError', {e=e, eventName=message});

	}

}

// [END setSessionUserRoleGroupRel]


// [START setSessionUserSiteRel]

public void function setSessionUserSiteRel(required query args) {

	try {		
		
		//TODO: Add filter by date to site query.
		qObj = new query();
		qObj.setDatasource(application.mcmsDSN);
		qObj.setName("q");
		qObj.addParam(name="userID",value="#args.ID#",cfsqltype="NUMERIC");
		qObj.addParam(name="siteStatusID",value="1,3",cfsqltype="VARCHAR");
		qObj.addParam(name="saascID",value="#application.saascID#",cfsqltype="NUMERIC");
		qObj.addParam(name="saascID",value="#application.saascID#",cfsqltype="NUMERIC");
		result = qObj.execute(sql="SELECT siteNo FROM TBL_SITE WHERE userID= :userID AND siteStatusID = :siteStatusID AND saascID = :saascID");
		q = result.getResult();
		recordcount = q.recordcount;
		qObj.clearParams();
		result = q;
		
		if (recordcount != 0) {

		session.siteNo = ValueList(result, siteNo);

		}

	} catch(any e) {

		message = "Authenticate Error: An error occurred with the setSessionUserSiteRel() function.";
		invoke('Application', 'onError', {e=e, eventName=message});

	}	

}

// [END setSessionUserSiteRel]


// [START setSessionUserDeptRel]

public void function setSessionUserDeptRel(required query args) {

	try {		

		qObj = new query();
		qObj.setDatasource(application.mcmsDSN);
		qObj.setName("q");
		qObj.addParam(name="userID",value="#args.ID#",cfsqltype="NUMERIC");
		qObj.addParam(name="deptStatusID",value="1,3",cfsqltype="VARCHAR");
		qObj.addParam(name="saascID",value="#application.saascID#",cfsqltype="NUMERIC");
		result = qObj.execute(sql="SELECT deptNo FROM TBL_DEPARTMENT WHERE userID= :userID AND deptStatusID = :deptStatusID AND saascID = :saascID");
		q = result.getResult();
		recordcount = q.recordcount;
		qObj.clearParams();
		result = q;
		
		if (recordcount != 0) {

		session.deptNo = ValueList(result, deptNo);

		}

	} catch(any e) {

		message = "Authenticate Error: An error occurred with the setSessionUserRoleGroupRel() function.";
		invoke('Application', 'onError', {e=e, eventName=message});

	}	

}

// [END setSessionUserDeptRel]


// [START setAccessPermissionUserHandler]

public string function setAccessPermissionUserHandler(required query args) {

try {	
	
	//Set other access variables based on relationships.
	invoke(authObj,"setApplicationUserRoleAccessRel", {args=result});
	invoke(authObj,"setApplicationUserRolePermissionRel", {args=result});

	} catch(any e) {

		message = "Authenticate Error: An error occurred with the setAccessPermissionUserHandler() function.";
		invoke('Application', 'onError', {e=e, eventName=message});

	}	

}

// [END setAccessPermissionUserHandler]


// [START setApplicationUserRoleAccessRel]


public void function setApplicationUserRoleAccessRel(required query args) {

try {		

		qObj = new query();
		qObj.setDatasource(application.mcmsDSN);
		qObj.setName("q");
		qObj.addParam(name="urID",value="#args.urID#",cfsqltype="NUMERIC");
		qObj.addParam(name="appStatusID",value="1,3",cfsqltype="VARCHAR");
		qObj.addParam(name="saascID",value="#application.saascID#",cfsqltype="NUMERIC");
		result = qObj.execute(sql="SELECT appNo, uraID, timeIDStart, timeIDEnd FROM V_APP_USER_ROLE_ACCESS_REL WHERE urID= :urID AND appStatusID = :appStatusID AND saascID = :saascID");
		q = result.getResult();
		recordcount = q.recordcount;
		qObj.clearParams();
		result = q;
		
		if (recordcount != 0) {

		session.appNoAccess = ValueList(result, appNo);
		session.uraID = ValueList(result, uraID);
		session.timeIDStart = ValueList(result, timeIDStart);
		session.timeIDEnd = ValueList(result, timeIDEnd);

		}

	} catch(any e) {

		message = "Authenticate Error: An error occurred with the setApplicationUserRoleAccessRel() function.";
		invoke('Application', 'onError', {e=e, eventName=message});

	}	

}

// [END setApplicationUserRoleAccessRel]


// [START setApplicationUserRolePermissionRel]

public void function setApplicationUserRolePermissionRel(required query args) {

	try {		

		qObj = new query();
		qObj.setDatasource(application.mcmsDSN);
		qObj.setName("q");
		qObj.addParam(name="urID",value="#args.urID#",cfsqltype="NUMERIC");
		qObj.addParam(name="appStatusID",value="1,3",cfsqltype="VARCHAR");
		qObj.addParam(name="saascID",value="#application.saascID#",cfsqltype="NUMERIC");
		result = qObj.execute(sql="SELECT appNo, urpID FROM V_APP_USER_ROLE_PERM_REL WHERE urID= :urID AND appStatusID = :appStatusID AND saascID = :saascID");
		q = result.getResult();
		recordcount = q.recordcount;
		qObj.clearParams();
		result = q;
		
		if (recordcount != 0) {

		session.appNoPermission = ValueList(result, appNo);
		session.urpID = ValueList(result, urpID);

		}

	} catch(any e) {

		message = "Authenticate Error: An error occurred with the setApplicationUserRolePermissionRel() function.";
		invoke('Application', 'onError', {e=e, eventName=message});

	}	

}

// [END setApplicationUserRolePermissionRel]

}