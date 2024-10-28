component {
	
// [START setApplicationSettings]

public void function setApplicationSettings() {

	//try {
	
	//TODO: Check any result/application variable set here should be dynamic or from database.
	
	//Set MCMS Developer Email for errors.
	application.mcmsDeveloperEmail = 'cfraser@sportsmanswarehouse.com';
    application.mcmsDSN = "mcms_dev";
	application.mcmsDir ="MCMS";
	application.mcmsRepositoryDir ="repository";
		
	//Set the datasource default, environment and cdn based on the domain.
	if(CGI.SERVER_NAME CONTAINS '.mcms.') {
	
	//Set application variables for LOCAL environment.	
	application.mcmsDSN = 'mcms_dev';
	application.mcmsServerEnv = 'LOCAL';	
	application.mcmsCDNURL = '//cdn.mcms.com';
	application.mcmsAPIURL = 'http://cdn.mcms.com:9100';
		
	} else if(CGI.SERVER_NAME CONTAINS '-dev.') {
	
	//Set application variables for DEV environment.	
	application.mcmsDSN = 'mcms_dev';
	application.mcmsServerEnv = 'DEV';
	application.mcmsCDNURL = '//cdn-dev.sportsmanswarehouse.com';
	application.mcmsAPIURL = 'http://cdn-dev.sportsmanswarehouse.com:9100';
		
	} else if(CGI.SERVER_NAME CONTAINS '-test.') {
	
	//Set application variables for TEST environment.	
	application.mcmsDSN = 'mcms_test';
	application.mcmsServerEnv = 'TEST';
	application.mcmsCDNURL = '//cdn-test.sportsmanswarehouse.com';
	application.mcmsAPIURL = 'http://cdn-test.sportsmanswarehouse.com:9100';
				
	} else {
	
	//Set application variables for PROD environment.
	application.mcmsDSN = 'mcms_prod';
	application.mcmsServerEnv = 'PROD';
	application.mcmsCDNURL = '//cdn.sportsmanswarehouse.com';
	application.mcmsAPIURL = 'http://cdn.sportsmanswarehouse.com:9100';			
}
	

	//Set Application vars for MCMS.
		//TODO: Add to configuration file of MCMS or database.
		application.mcmsPath = 'MCMS';
		application.mcmsHomePath = '/';
		application.mcmsAppAdminPath = 'app/admin';
		application.mcmsAppPublicPath = 'app/public';
		application.mcmsAuthenticatePath = 'app/authenticate';
		application.mcmsTemplatePath = 'MCMS/template';
		application.mcmsAppTaskPath = 'app/task'; 
		application.mcmsSSLRequired = 'false';
		application.mcmsCustomizePath = 'app/custom';
		
		
		
		//Set the API paths for components.
		application.siteAPIPath = '/site/v1.0';
		application.siteAPIFormat = 'json';
		
		if(CGI.SERVER_NAME CONTAINS 'sign.') {
			
		//Set the network for the repositories.
		application.networkID = '2';
		//Set the alert based on the server/network.
		application.alertType = '1';
		//Set the default application types for admin/public.
		application.appTypePublic = '99';
		application.appTypeAdmin = '13';
		//Set the menu and application types for the footer.
		application.footerMenuTypePublic = '99';
		application.footerMenuTypeAdmin = '13';
		application.footerAppTypePublic = '99';
		application.footerAppTypeAdmin = '13';	
		
			
		} else if (CGI.SERVER_NAME CONTAINS 'intranet.')	{
			
		//Set the network for the repositories.
		application.networkID = '2';
		//Set the alert based on the server/network.
		application.alertType = '1';
		//Set the default application types for admin/public.
		application.appTypePublic = '5,7,10';
		application.appTypeAdmin = '4,6,10,13';
		//Set the menu and application types for the footer.
		application.footerMenuTypePublic = '3';
		application.footerMenuTypeAdmin = '4';
		application.footerAppTypePublic = '0';
		application.footerAppTypeAdmin = '5,10';		
			
		} else {
				
		//Set the network for the repositories.
		application.networkID = '2';
		//Set the alert based on the server/network.
		application.alertType = '1';
		//Set the default application types for admin/public.
		application.appTypePublic = '99';
		application.appTypeAdmin = '13';
		//Set the menu and application types for the footer.
		application.footerMenuTypePublic = '99';
		application.footerMenuTypeAdmin = '13';
		application.footerAppTypePublic = '99';
		application.footerAppTypeAdmin = '13';		
			
		}

	//} catch(any e) {

		//message = "MCMS Error: An error occurred with the setApplicationSettings() function.";
		//invoke('Application', 'onError', {e=e, eventName=message});

	//}

}

// [END setApplicationSettings]	

// [START setObjs]

public struct function setObjs() {

	//try {
		
    result = StructNew();
	
		//Create CMS objects.
    	result.cmsObj = CreateObject('component', 'MCMS.component.cms.CMS');
    	result.mcmsObj = CreateObject('component', 'MCMS.component.cms.MCMS');
    	result.menuObj = CreateObject('component', 'MCMS.component.cms.Menu');
    	
    	//Create Utility objects.
    	result.utilityObj = CreateObject('component', 'MCMS.component.utility.Utility');
    	result.listObj = CreateObject('component', 'MCMS.component.utility.List');
    	
    	//Get top level app objects.
    	result.siteObj = CreateObject('component', 'MCMS.component.app.site.Site');
    	result.departmentObj = CreateObject('component', 'MCMS.component.app.department.Department');
    	result.imageObj = CreateObject('component', 'MCMS.component.app.image.Image');
    	
    	//Get top level app API objects.
    	result.siteAPIObj = CreateObject('component', 'MCMS.component.app.site.SiteAPI');

	return result;

	//} catch(any e) {

		//message = "MCMS Error: An error occurred with the setApplicationSettings() function.";
		//invoke('Application', 'onError', {e=e, eventName=message});

	//}

}

// [END setObjs]

// [START setSSL]

public void function setSSL() {

	//try {
		
    if(CGI.SERVER_PORT_SECURE == 0 AND application.mcmsSSLRequired == 'true') {
		
		GetPageContext().GetResponse().sendRedirect("https://#CGI.SERVER_NAME#");

	}

	//} catch(any e) {

		//message = "MCMS Error: An error occurred with the setApplicationSettings() function.";
		//invoke('Application', 'onError', {e=e, eventName=message});

	//}

}

// [END setSSL]

// [START setResetApplication]

public void function setResetApplication() {

	//try {
		
    //If the application is reset remove the application cache and restart the application and return results with mcmsDebug. For development 127.0.0.1 should be added.
	
		if (StructKeyExists(URL,'mcmsReset') AND StructKeyExists(APPLICATION,'developerIPList')) {
	
			if (ListContains(application.developerIPList, CGI.REMOTE_ADDR)) {
		
		
				if(url.mcmsReset == true) {

					cacheRemoveAll();
					structClear(APPLICATION);
					structClear(URL);
					appObj = CreateObject('component', 'Application');
					appObj.onApplicationStart();
					location(url="/", addtoken="false");

				}
			
			}
		}

	//} catch(any e) {

		//message = "MCMS Error: An error occurred with the setApplicationSettings() function.";
		//invoke('Application', 'onError', {e=e, eventName=message});

	//}

}

// [END setResetApplication]	

// [START setApplicationTimeout]

public void function setApplicationTimeout() {

	//try {
			
		args = structNew();
		args.wddxFilePath = '//#CGI.SERVER_NAME#/lib/neo-runtime.xml';
		args.rootElement = 'data.xmlChildren[1].xmlChildren[7].xmlChildren[2].xmlChildren[1].xmlChildren[2].xmlChildren[1].xmlText';
		args.agStatus = '1,3';
		
    	timeoutSeconds = invoke('MCMS.component.app.security.Security', 'setTimeoutWarning', {args=args});
    
    	args = '';
    
    	session.timeoutSeconds = Iif(timeoutSeconds != '', Evaluate(DE('timeoutSeconds')), DE(1000));

	//} catch(any e) {

		//message = "MCMS Error: An error occurred with the setApplicationTimeout() function.";
		//invoke('Application', 'onError', {e=e, eventName=message});

	//}

}

// [END setApplicationTimeout]

// [START getApplicationDetail]

public struct function getApplicationDetail() {

	//try {
	
	//Get the application detail based on the url.
	
	//Set the appURL var.	
    if (GetDirectoryFromPath(CGI.SCRIPT_NAME) != '/') {
		
    		var.appURL = RemoveChars(GetDirectoryFromPath(CGI.SCRIPT_NAME), LEN(GetDirectoryFromPath(CGI.SCRIPT_NAME)), 1);
    
    		} else {
    	
    		var.appURL = 'NULL';
    
    	}
    	
    //Get application detail.

		appArgs = structNew();
		appArgs.appURL = var.appURL;
		appArgs.appStatus = '1,3';
		
		getApplicationRet =  invoke('MCMS.component.cms.Cms', 'getApplication', {args=appArgs});
	
		appArgs = '';
		
		result = StructNew();
	
		if (getApplicationRet.recordcount != 0) {
		
			result.appID = getApplicationRet.appID;
			result.appURL = getApplicationRet.appURL;
			result.appName = getApplicationRet.appName;
			result.appDescription = getApplicationRet.appDescription;
		
		} else {
		
		//Set default variables if no records are found.
			result.appID = 100;
			result.appURL = '/';
			result.appName = "#application.companyName#";
			result.appDescription = "Welcome to the #application.companyName#.";
			
		}
		
		return result;

	//} catch(any e) {

		//message = "MCMS Error: An error occurred with the setApplicationDetail() function.";
		//invoke('Application', 'onError', {e=e, eventName=message});

	//}

}

// [END getApplicationDetail]

// [START setParameters]

public void function setParameters(string name) {

	//try {
	
	//Define parameters. This method will be used until a database storage is used.
		
		//Request params.
		param name="request.remotePCSiteIP" type="string" default="101";
		param name="request.remotePCSiteNo" type="string" default="101";
		param name="request.remotePCDeptIP" type="string" default="0";
		param name="request.remotePCDeptNo" type="string" default="0";
		param name="request.remotePCStateProv" type="string" default="";
		param name="request.maxRows" type="numeric" default="0";
		param name="request.startRow" type="numeric" default="1";
		param name="request.endRow" type="numeric" default="1";
		param name="request.totalPages" type="numeric" default="0";
		param name="request.queryString" type="numeric" default="0";
		
		//Cookie params
		param name="cookie.MCMS#UCASE(arguments.name)#" type="string" default="";
		param name="cookie.AUTHENTICATEUSERNAME" type="string" default="NULL";
		
		//Form params.
		param name="form.userUsername" type="string" default="";
		param name="form.userRemember" type="string" default="";
		param name="form.keywords" type="string" default="All";
		param name="form.siteNo" type="string" default="100";
		param name="form.deptNo" type="string" default="0";
		param name="form.dateRel" type="string" default="";
		param name="form.dateExp" type="string" default="";
		param name="form.siteStateProv" type="string" default="All";
		param name="form.mcmsInsert" type="string" default="false";
		param name="form.mcmsInsertLine" type="string" default="false";
		param name="form.mcmsUpdate" type="string" default="false";
		param name="form.mcmsUpdateList" type="string" default="false";
		param name="form.mcmsDirect" type="string" default="false";
		param name="form.mcmsWorkFlowStatus" type="string" default="0";
		param name="form.mcmsPreview" type="string" default="false";
		param name="form.mcmsNext" type="string" default="";
		param name="form.mcmsPrevious" type="string" default="";
		param name="form.maxRows" type="numeric" default="#request.rowCount#";
		param name="form.status" type="string" default="1,2,3";
		param name="form.IDList" type="string" default="0";
		param name="form.rowCount" type="string" default="0";
		
		//URL params.
		param name="url.remoteIPAddress" type="string" default="0";
		param name="url.keywords" type="string" default="All";
		param name="url.siteNo" type="string" default="100";
		param name="url.deptNo" type="string" default="0";
		param name="url.dateRel" type="string" default="";
		param name="url.dateExp" type="string" default="";
		param name="url.siteStateProv" type="string" default="All";
		param name="url.appID" type="numeric" default="100";
		param name="url.appURL" type="string" default="";
		param name="url.appDirectory" type="string" default="";
		param name="url.mcmsDebug" type="string" default="false";
		param name="url.mcmsReset" type="string" default="false";
		param name="url.mcmsQuery" type="string" default="false";
		param name="url.mcmsID" type="string" default="result";
		param name="url.mcmsCustomID" type="string" default="result";
		param name="url.mcmsPageID" type="string" default="";
		param name="url.mcmsInsert" type="string" default="false";
		param name="url.mcmsInsertLine" type="string" default="false";		
		param name="url.mcmsResult" type="string" default="false";
		param name="url.mcmsUpdate" type="string" default="false";		
		param name="url.mcmsUpdateList" type="string" default="false";
		param name="url.mcmsRedirect" type="string" default="";		
		param name="url.mcmsDirect" type="string" default="false";		
		param name="url.mcmsDirectPath" type="string" default="";
		param name="url.mcmsWorkFlowStatus" type="string" default="0";		
		param name="url.mcmsPreview" type="string" default="false";		
		param name="url.tabName" type="string" default="Temp";
		param name="url.mcmsFile" type="string" default="false";
		param name="url.mcmsSignOut" type="string" default="false";
		param name="url.ID" type="numeric" default="0";		
		param name="url.mcmsDenied" type="string" default="";
		param name="url.queryString" type="string" default="";
		param name="url.pageNo" type="numeric" default="1";
		param name="url.maxRows" default="#request.rowCount#";
		param name="url.status" type="string" default="1,2,3";
    	param name="url.mcmsMobile" type="string" default="false";
    	param name="url.mcmsSendReminder" type="string" default="false";
    	param name="url.mcmsReportType" type="string" default="EXCEL";
    	param name="url.mcmsReportCFC" type="string" default="";
    	param name="url.mcmsReportFunction" type="string" default="";
    	param name="url.mcmsFlushCache" default="false";
    	param name="url.CFGRIDKEY" default="";
    	param name="url.rcID" default="0";
    	
    	//Session params.
		param name="session.siteNo" type="string" default="100";
		param name="session.signedIn" type="string" default="false";
		param name="session.urID" type="string" default="100";
		param name="session.uaID" type="string" default="0";
		param name="session.deptNo" type="string" default="0";
		param name="session.userName" type="string" default="";
		param name="session.userUsername" type="string" default="";
		param name="session.userID" type="string" default="";
		param name="session.userRoleAccess" type="string" default="100";
		param name="session.timeoutSeconds" type="numeric" default="2700";
    	
    	//Query string changes to support paging results and ajax URL to FORM issues where a quesy is made. See CMS Query Form.
		if (url.mcmsQuery != 'false') {
			
			if (url.keywords NEQ 'All') {
				
				form.keywords = url.keywords;
				
			}
			
			if (url.siteNo NEQ '100') {
				
				form.siteNo = url.siteNo;
				
			}
			
			if (url.deptNo NEQ '0') {
				
				form.deptNo = url.deptNo;
				
			}
			
			if (url.dateRel NEQ '') {
				
				form.dateRel = url.dateRel;
				
			}
			
			if (url.dateExp NEQ '') {
				
				form.dateExp = url.dateExp;
				
			}
		}

	//} catch(any e) {

		//message = "MCMS Error: An error occurred with the setParameters() function.";
		//invoke('Application', 'onError', {e=e, eventName=message});

	//}

}

// [END setParameters]

// [START setSignOut]

public void function setSignOut() {

	//try {

	//If sign out is requested.
	if (url.mcmsSignOut == 'true') {
			
		//Sign out user and kill session.
		invoke('Application', 'OnSessionEnd');
			
		//Redirect to root.
		location(url="/", addtoken="false");
			
	}

	//} catch(any e) {

		//message = "MCMS Error: An error occurred with the setSignOut() function.";
		//invoke('Application', 'onError', {e=e, eventName=message});

	//}

}

// [END setSignOut]

// [START setRedirect]

public void function setRedirect() {

	//try {
		
	//Construct the requested path to redirect including.
	    strURL = Replace(CGI.SCRIPT_NAME, 'index.cfm', '') & '?' & CGI.QUERY_STRING;
        if (IsDefined("url._cf_containerId")) {
        strURL = url.appURL & "?appID=#url.appID#";
    	}

	if (url.mcmsRedirect != '' && session.signedIn == "true") {
    		
    		location(url="#url.mcmsRedirect#", addtoken="false");
    		
    	}
    	
    	//Redirect to authentication if force authentication.
		if (application.mcmsForceAuthentication == 'true' && CGI.SCRIPT_NAME != "/#application.mcmsAuthenticatePath#/index.cfm" && session.signedIn == "false") {
    
    		location(url="/#application.mcmsAuthenticatePath#/?mcmsDenied=#strURL#", addtoken="false");
    
    	}
    	
    	//Redirect to authentication if accessing admin.
		if (CGI.SCRIPT_NAME == "/#application.mcmsAppAdminPath#/index.cfm" && CGI.SCRIPT_NAME != "/#application.mcmsAuthenticatePath#/index.cfm" && session.signedIn == "false") {
    
    		location(url="/#application.mcmsAuthenticatePath#/?mcmsDenied=#strURL#", addtoken="false");
    
    	}
    	
    	//Redirect if access was denied initially.
    	if (url.mcmsDenied != '' && url.mcmsDenied != true && session.signedIn == "true") {
    		
    		//location(url="#url.mcmsDenied#", addtoken="false");
    		
    	}

	//} catch(any e) {

		//message = "MCMS Error: An error occurred with the setRedirect() function.";
		//invoke('Application', 'onError', {e=e, eventName=message});

	//}

}

// [END setRedirect]

// [START setApplicationSecurity]

public void function setApplicationSecurity() {

	//try {

	//Protect admin applications.
    	
    	if (CGI.SCRIPT_NAME CONTAINS "/#application.mcmsAppAdminPath#") {
    		
		
		//Check to see the admin application is accessed.
    	if (url.appID == 100 AND CGI.SCRIPT_NAME != "/#application.mcmsAppAdminPath#/index.cfm") {
   	
		   //location(url="/#application.mcmsAppAdminPath#", addtoken="false");
   	
		}
   
		//Set User object.
		userObj = CreateObject('component', 'MCMS.component.cms.User');
    	
    	//Get access information to the application.
    	userRoleAccess = userObj.getUserRoleAccess(urID=session.urID,appID=url.appID);
    	
    	//Set the user access ID for application.
    	var.uaID = userRoleAccess.uaID;
		
		//Redirect if access to the application is not allowed.
   		if (var.uaID == '' AND url.appID != 100) {
		
		 location(url="/#application.mcmsAuthenticatePath#/?mcmsDenied=true", addtoken="false");
   	
		}
		}

	//} catch(any e) {

		//message = "MCMS Error: An error occurred with the setApplicationSecurity() function.";
		//invoke('Application', 'onError', {e=e, eventName=message});

	//}

}

// [END setApplicationSecurity]

// [START setUserRelationship]

public void function setUserRelationship(string siteNo, string relArguments) {

	//try {
		
    if (arguments.relArgument CONTAINS 'siteNo' && arguments.uaID == 101) {
    	
    	param name="form.siteNo" type="string" default="100";
        
    } else {
    	
    	param name="form.siteNo" type="string" default="#session.siteNo#";
    }
    
    if (arguments.relArgument CONTAINS 'deptNo' && ARGUMENTS.uaID == 101) {
    	
    	param name="form.deptNo" type="string" default="0";
        
    } else {
    	
    	param name="form.deptNo" type="string" default="#session.deptNo#";
    }
    
    //Set the user role access per application.
    getUserRoleAccessRet = invoke('MCMS.component.cms.User', 'getUserRoleAccess', {urID=session.urID, appID=url.appID, uraStatus='1,3'});
    
    request.uaID = getUserRoleAccessRet.uaID;
    request.appID = getUserRoleAccessRet.appID;


	//} catch(any e) {

		//message = "MCMS Error: An error occurred with the setUserRelationship() function.";
		//invoke('Application', 'onError', {e=e, eventName=message});

	//}

}

// [END setUserRelationship]

// [START setArgs]

public struct function setArgs() {

	try {

	//Get the API host.
	configFile = expandPath("/MCMS/mcms.config");
	application.mcmsAPIURL = TRIM(getProfileString(configFile,'default', 'mcmsAPIURL'));
	application.mcmsAPIKey = TRIM(getProfileString(configFile,'default', 'mcmsAPIKey'));
	application.mcmsLicense = TRIM(getProfileString(configFile,'default', 'mcmsLicense'));
	application.mcmsEmail = TRIM(getProfileString(configFile,'default', 'mcmsEmail'));
	application.mcmsDSN = 'mcms';

	//Create args struct.
	args = StructNew();
	args.mcmsAPIURL = application.mcmsAPIURL;
	args.mcmsAPIKey = application.mcmsAPIKey;
	args.mcmsLicense = application.mcmsLicense;
	args.hostName = CGI.SERVER_NAME;
	args.hostPort = CGI.SERVER_PORT;

	return args;

	} catch(any e) {

		message = "MCMS Error: An error occurred with the setArgs() function.";
		invoke('Application', 'onError', {e=e, eventName=message});

	}

}

// [END setArgs]


// [START setSAASClient]

public void function setSAASClient(required struct args, required string method, string param) {

	//try {

	mcmsAPIURL = args.mcmsAPIURL;
	mcmsAPIKey = args.mcmsAPIKey;
	license = args.mcmsLicense;
	hostName = args.hostName;
	hostPort = args.hostPort;

	StructInsert(APPLICATION,'keyCheck',mcmsAPIKey,true);
	
	//Get the saascID for the apiKey passed.
	qObj = new query();
	qObj.setDatasource('mcms');
	qObj.setName("getSAASClient");
	qObj.addParam(name="apiKey",value="#mcmsAPIKey#",cfsqltype="VARCHAR");
	result = qObj.execute(sql="SELECT saascID FROM TBL_SAAS_CLIENT_API_KEY_REL WHERE apiKey = :apiKey");
	getSAASClient = result.getResult();
	recordcount = getSAASClient.recordcount;
	qObj.clearParams();
	result = getSAASClient;
	
	if (recordcount != 0) {
		
		//SECURITY & LICENSE CHECK: Now match the saascID to a server and domain to confirm the SAAS client. These records must exist in the database. saascID, apiKey, and licence relationships must be sound. Check the mcms.config file for the correct licence and apikey.
		qObj = new query();
		qObj.setDatasource('mcms');
		qObj.setName("checkDomain");
		qObj.addParam(name="dURL",value="#hostName#",cfsqltype="VARCHAR");
		qObj.addParam(name="saascID", value="#result.saascID#",cfsqltype="NUMERIC");
		result = qObj.execute(sql="SELECT saascID, stName, datID FROM V_SERVER_DOMAIN_REL WHERE dURL = :dURL AND saascID = :saascID");
		checkDomain = result.getResult();
		recordcount = checkDomain.recordcount;
		qObj.clearParams();
		result = checkDomain;
		
		if (recordcount != 0) {

		//Create APPLICATION var for authetication type.
		application.authenticationType = result.datID;
		

		} else {
		
		//TODO: Set trigger to fail the server because the SAAS client doesn't exist.
		result.status = 'failed';

		}
		
	}

		//Create application.clientID variable for setSAASClient method.
		if (method == 'setSAASClient') {
		
		StructInsert(APPLICATION,'saascID',result.saascID,true);
		StructInsert(APPLICATION,'mcmsServerType',result.stName,true);

		}

	//} catch(any e) {

		//message = "MCMS Error: An error occurred with the setSAASClient() function.";
		//invoke('Application', 'onError', {e=e, eventName=message});

	//}

}

// [END setSAASClient]

// [START setSAASLicense]

public void function setSAASLicense(required struct args, required string method, string param) {

	try {

	mcmsAPIURL = args.mcmsAPIURL;
	mcmsAPIKey = args.mcmsAPIKey;
	license = args.mcmsLicense;
	hostName = args.hostName;
	hostPort = args.hostPort;

	qObj = new query();
	qObj.setDatasource('mcms');
	qObj.setName("q");
	//Get only APPLICATION scope variables.
	qObj.addParam(name="saascID",value="#application.saascID#",cfsqltype="NUMERIC");
	qObj.addParam(name="ltID",value="101",cfsqltype="NUMERIC");
	result = qObj.execute(sql="SELECT lSerialNumber, lKey FROM V_SC_API_LICENSE_REL WHERE ltID = :ltID AND saascID  IN (:saascID, 0)");
	q = result.getResult();
	recordcount = q.recordcount;
	qObj.clearParams();
	result = q;

	//Create application.clientID variable for setSAASClient method.
	if (method == 'setSAASLicense') {
		
		StructInsert(APPLICATION,'saasLicenceKey',result.lKey,true);
		
	}

	} catch(any e) {

		message = "MCMS Error: An error occurred with the setSAASLicense() function.";
		//invoke('Application', 'onError', {e=e, eventName=message});

	}


}

// [END setSAASLicense]

// [START setMCMS]

public void function setMCMS(required struct args, required string method, string param) {

	mcmsAPIURL = args.mcmsAPIURL;
	mcmsAPIKey = args.mcmsAPIKey;
	license = args.mcmsLicense;
	hostName = args.hostName;
	hostPort = args.hostPort;

	//try {	

	//Get the method requested.
	switch(method) {

	case 'setApplicationGlobal':

		qObj = new query();
		qObj.setDatasource('mcms');
		qObj.setName("q");
		//Get only APPLICATION scope variables.
		qObj.addParam(name="saascID",value="#application.saascID#",cfsqltype="NUMERIC");
		qObj.addParam(name="vsID",value="101",cfsqltype="NUMERIC");
		result = qObj.execute(sql="SELECT gvName, gvValueDEV, gvValueTEST, gvValuePROD FROM TBL_GLOBAL_VARIABLE WHERE vsID = :vsID AND saascID  IN (:saascID, 0) ORDER BY saascID ASC");
		q = result.getResult();
		recordcount = q.recordcount;
		qObj.clearParams();
		result = q;

	break;

	case 'setSessionGlobal':

		qObj = new query();
		qObj.setDatasource('mcms');
		qObj.setName("q");
		//Get only SESSION scope variables.
		qObj.addParam(name="saascID",value="#application.saascID#",cfsqltype="NUMERIC");
		qObj.addParam(name="vsID",value="102",cfsqltype="NUMERIC");
		result = qObj.execute(sql="SELECT gvName, gvValueDEV, gvValueTEST, gvValuePROD FROM TBL_GLOBAL_VARIABLE WHERE vsID = :vsID AND saascID IN (:saascID, 0)");
		q = result.getResult();
		recordcount = q.recordcount;
		qObj.clearParams();
		result = q;

	break;

	case 'setClientGlobal':

		qObj = new query();
		qObj.setDatasource('mcms');
		qObj.setName("q");
		//Get only CLIENT scope variables.
		qObj.addParam(name="saascID",value="#application.saascID#",cfsqltype="NUMERIC");
		qObj.addParam(name="vsID",value="103",cfsqltype="NUMERIC");
		result = qObj.execute(sql="SELECT gvName, gvValueDEV, gvValueTEST, gvValuePROD FROM TBL_GLOBAL_VARIABLE WHERE vsID = :vsID AND saascID IN (:saascID, 0)");
		q = result.getResult();
		recordcount = q.recordcount;
		qObj.clearParams();
		result = q;

	break;

	case 'setFormGlobal':

		qObj = new query();
		qObj.setDatasource('mcms');
		qObj.setName("q");
		//Get only FORM scope variables.
		qObj.addParam(name="saascID",value="#application.saascID#",cfsqltype="NUMERIC");
		qObj.addParam(name="vsID",value="104",cfsqltype="NUMERIC");
		result = qObj.execute(sql="SELECT gvName, gvValueDEV, gvValueTEST, gvValuePROD FROM TBL_GLOBAL_VARIABLE WHERE vsID = :vsID AND saascID IN (:saascID, 0)");
		q = result.getResult();
		recordcount = q.recordcount;
		qObj.clearParams();
		result = q;

	break;

	case 'setURLGlobal':

		qObj = new query();
		qObj.setDatasource('mcms');
		qObj.setName("q");
		//Get only URL scope variables.
		qObj.addParam(name="saascID",value="#application.saascID#",cfsqltype="NUMERIC");
		qObj.addParam(name="vsID",value="105",cfsqltype="NUMERIC");
		result = qObj.execute(sql="SELECT gvName, gvValueDEV, gvValueTEST, gvValuePROD FROM TBL_GLOBAL_VARIABLE WHERE vsID = :vsID AND saascID IN (:saascID, 0)");
		q = result.getResult();
		recordcount = q.recordcount;
		qObj.clearParams();
		result = q;

	break;
	
	case 'setCookieGlobal':

		qObj = new query();
		qObj.setDatasource('mcms');
		qObj.setName("q");
		//Get only URL scope variables.
		qObj.addParam(name="saascID",value="#application.saascID#",cfsqltype="NUMERIC");
		qObj.addParam(name="vsID",value="106",cfsqltype="NUMERIC");
		result = qObj.execute(sql="SELECT gvName, gvValueDEV, gvValueTEST, gvValuePROD FROM TBL_GLOBAL_VARIABLE WHERE vsID = :vsID AND saascID IN (:saascID, 0)");
		q = result.getResult();
		recordcount = q.recordcount;
		qObj.clearParams();
		result = q;

	break;

	case 'setRequestGlobal':

		qObj = new query();
		qObj.setDatasource('mcms');
		qObj.setName("q");
		//Get only URL scope variables.
		qObj.addParam(name="saascID",value="#application.saascID#",cfsqltype="NUMERIC");
		qObj.addParam(name="vsID",value="107",cfsqltype="NUMERIC");
		result = qObj.execute(sql="SELECT gvName, gvValueDEV, gvValueTEST, gvValuePROD FROM TBL_GLOBAL_VARIABLE WHERE vsID = :vsID AND saascID IN (:saascID, 0)");
		q = result.getResult();
		recordcount = q.recordcount;
		qObj.clearParams();
		result = q;

	break;

	default:
	result = 'No method found.';

	}

	//Insert APPLICATION variables for setApplicationGlobal method.
	if(method == 'setApplicationGlobal' && result.recordcount != 0) {

		for (global in result) {

			//Create all values for DEV, TEST, PROD.
			gvName = global.gvName;

			if(application.mcmsServerType == 'DEV') {

				gvValue = global.gvValueDEV;

			} else if (application.mcmsServerType == 'TEST') {

				gvValue = global.gvValueTEST;

			} else {

				gvValue = global.gvValuePROD;

			}

			StructInsert(APPLICATION,gvName,gvValue,true);
		}

		application.apiErrorHTMLHeaderStatus = false;
		application.apiErrorHeaderStatus = false;
		application.apiErrorFooterStatus = false;
		application.apiErrorUtilityStatus = false;

		}

	//Insert SESSION parameters for setSessionGlobal method.
	if(method == 'setSessionGlobal' && result.recordcount != 0) {

		for (global in result) {

			//Create only value for PROD default.
			gvName = global.gvName;
			gvValuePROD = global.gvValuePROD;
			param name="session.#gvName#" default="#gvValuePROD#";

		}

	}

	//Insert FORM parameters for setFormGlobal method.
	if(method == 'setFormGlobal' && result.recordcount != 0) {

		for (global in result) {

			//Create only value for PROD default.
			gvName = global.gvName;
			gvValuePROD = global.gvValuePROD;
			param name="form.#gvName#" default="#gvValuePROD#";

		}

	}

	//Insert URL parameters for setURLGlobal method.
	if(method == 'setURLGlobal' && result.recordcount != 0) {

		for (global in result) {

			//Create only value for PROD default.
			gvName = global.gvName;
			gvValuePROD = global.gvValuePROD;
			param name="url.#gvName#" default="#gvValuePROD#";

		}

	}
		
	//Insert Cookie parameters for setCookieGlobal method.
	if(method == 'setCookieGlobal' && result.recordcount != 0) {

		for (global in result) {

			//Create only value for PROD default.
			gvName = global.gvName;
			gvValuePROD = global.gvValuePROD;
			param name="cookie.#gvName#" default="#gvValuePROD#";

		}

	}

	//Insert Request parameters for setRequestGlobal method.
	if(method == 'setRequestGlobal' && result.recordcount != 0) {

		for (global in result) {

			//Create only value for PROD default.
			gvName = global.gvName;
			gvValuePROD = global.gvValuePROD;
			param name="request.#gvName#" default="#gvValuePROD#";

		}

	}


	

	//} catch(any e) {

		//message = "MCMS Error: An error occurred with the setMCMS() function.";
		//invoke('Application', 'onError', {e=e, eventName=message});

	//}

}

// [END setMCMS]


// [START setNetwork]

public string function setNetwork() {
	
	//TODO Set server name dynamically
	//try {

	if(CGI.SERVER_NAME EQ 'cdn.dev.com') {

		StructInsert(APPLICATION,'networkID','2',true);

	}

	//} catch(any e) {

		//message = "CMS Error: An error occurred with the setNetwork() function.";
		//invoke('Application', 'onError', {e=e, eventName=message});

	//}


}

// [END setNetwork]


// [Start setHTMLHeader]

public string function setHTMLHeader(required struct args) {

	clientID = application.saascID;

	//try {

	apiCheck = StructKeyExists(APPLICATION, 'apiHTMLHeader');

	//Check that the APPLICATION key exists and it hasn't errored.--->
	if (apiCheck == 'true' && application.apiErrorHTMLHeaderStatus EQ false) {

		apiHTMLHeader = application.apiHTMLHeader;

	} else {

		
		setHTMLHeader = mcmsObj.cmsObj.setHTMLHeader(clientID);

		application.apiHTMLHeader = setHTMLHeader;

		if (application.apiHTMLHeader CONTAINS 'APIError') {

			application.apiErrorHTMLHeaderStatus = true;
		
		} else {
		
		application.apiErrorHTMLHeaderStatus = false;
		
		}

	}

	//} catch(any e) {

		//message = "MCMS Error: An error occurred with the setHeaderHTML() function.";
		//invoke('Application', 'onError', {e=e, eventName=message});

	//}

}

// [END setHTMLHeader]

// [START setHeader]

public string function setHeader(required struct args) {

	clientID = application.saascID;

	//try {

	apiCheck = StructKeyExists(APPLICATION, 'apiHeader');

	//Check that the APPLICATION key exists and it hasn't errored.--->
	if (apiCheck == 'true' && application.apiErrorHeaderStatus == false) {

		apiHeader = application.apiHeader;

	} else {

		
		setHeader = mcmsObj.cmsObj.setHeader(clientID);

		application.apiHeader = setHeader;

	if (application.apiHeader CONTAINS 'APIError') {

		application.apiErrorHeaderStatus = true;

	} else {

		application.apiErrorHeaderStatus = false;

	}

	}

	//} catch(any e) {

		//message = "MCMS Error: An error occurred with the setHeader() function.";
		//invoke('Application', 'onError', {e=e, eventName=message});

	//}

}

// [END setHeader]

// [START setFooter]

public string function setFooter(required struct args) {

	clientID = application.saascID;

	//try {

	apiCheck = StructKeyExists(APPLICATION, 'apiFooter');

	if (apiCheck == 'true' && application.apiErrorFooterStatus == false) {

		apiFooter = application.apiFooter;

	} else {

   		
		setFooter = mcmsObj.cmsObj.setFooter(clientID);

		application.apiFooter = setFooter;

	if (application.apiFooter CONTAINS 'APIError') {

		application.apiErrorFooterStatus = true;

	} else {

		application.apiErrorFooterStatus = false;

	}

	}

	//} catch(any e) {

		//message = "MCMS Error: An error occurred with the setFooter() function.";
		//invoke('Application', 'onError', {e=e, eventName=message});

	//}
}

// [END setFooter]

// [START setApplication]

public string function setApplication(required string tabTitle, required string tabList, required string pageID) {

	//try {

	var result = '';

	//Set application tab navigation if required.

	if (tabList != '') {

	navTab = invoke('MCMS.component.cms.Cms', 'setTabNavigation', {tabTitle=tabTitle, tabList=tabList, pageID=pageID});

	result = navTab;

	}

	return result;

	

	//} catch(any e) {

		//message = "CMS Error: An error occurred with the setNetwork() function.";
		//invoke('Application', 'onError', {e=e, eventName=message});

	//}


}

// [END setApplication]

// [START setUtility]

public any function setUtility(required string method="", required string param="") {

	mcmsAPIURL = application.mcmsAPIURL;
	clientID = application.saascID;
	mcmsAPIKey = application.mcmsAPIKey;
	//TODO: API URL change.
	apiURL = '#mcmsAPIURL#/Utility?clientID=#clientID#&apiKey=#mcmsAPIKey#&method=#method#&param=#param#'; 
	apiMethod = 'GET';

	//try {

	httpService = new http();
	httpService.setMethod(apiMethod);
	httpService.setUrl(apiURL);

	result = httpService.send().getPrefix();

	apiData = DeserializeJSON(result.FileContent);

	//Get the columns of the data structure.
	columns = ArrayToList(apiData.columns);
	rowCount = ArrayLen(apiData.data);

	//Construct a query from the JSON structure.
	q = QueryNew(columns);
	QueryAddRow(q, rowCount);

	//Loop to create rows based on rowcount.
	for (i=1; i <= rowCount; i++) {
		
		//Loop columns to place data.
		for (x=1; x <= ListLen(columns); x++) {

		QuerySetCell(q, ListGetAt(columns, x), apiData.data[i][x], i);
		QuerySetCell(q, ListGetAt(columns, x), apiData.data[i][x], i);

		}

	}

	return q;

	//} catch(any e) {

		//message = "MCMS Error: An error occurred with the setUtility() function.";
		//invoke('Application', 'onError', {e=e, eventName=message});

	//}

}

// [END setUtility]

// [START setJSONToQuery]

public any function setJSONToQuery(required struct args) {

	//TODO: API URL change.
	apiURL = '#args.mcmsAPIURL#/#args.apiPath#?method=#args.apiMethod#&clientID=#args.clientID#&mcmsAPIKey=#args.mcmsAPIKey#'; 
	apiMethodAction = 'GET';

	//try {

	q = new query();

	httpService = new http();
	httpService.setMethod(apiMethodAction);
	httpService.setUrl(apiURL);
	httpService.setThrowOnError('yes');
	

	result = httpService.send().getPrefix();

	//Check the status code.
	if (result.StatusCode == '200 OK') {
	
	apiData = DeserializeJSON(result.FileContent);

	//Get the columns of the data structure.
	columns = ArrayToList(apiData.columns);
	rowCount = apiData.ROWCOUNT;

	//Construct a query from the JSON structure.
	q = QueryNew(columns);
	

	//Loop to create rows based on rowcount.
	for (x=1; x <= rowCount; x++) {

		QueryAddRow(q);
		
		//Loop columns to place data.
		for (i=1; i <= ListLen(columns); i++) {

		columnName = ListGetAt(columns, i);

		if (ArrayIsDefined(apiData.DATA[columnName], x) EQ 'YES') {
		columnValue = apiData.DATA[columnName][x];
		} else {
		columnValue = result.StatusCode;
		}

		QuerySetCell(q, columnName, columnValue);

		}

	}
}

	return q;

	//} catch(any e) {

		//message = "MCMS Error: An error occurred with the setUtility() function.";
		//invoke('Application', 'onError', {e=e, eventName=message});

	//}

}

}