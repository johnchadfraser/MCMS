/**
 * CMS
 * @author ${user}
 * @date ${date}
**/

component {

	// [START setAuthentication]

	public struct function setAuthentication(required struct args, required string message="An error occurred with the setAuthentication() method.") {
			
		var result.message = application.mcmsAuthenticationSuccess;
		var result.status = "true";
		
		param name="args.userUserame" default="" type="string"; 
		param name="args.userPassword" default="" type="string"; 
		param name="args.userStatusID" default="1" type="string";

		//Create objects
		authObj = CreateObject("component", "mcms.component.cms.Authenticate");
			
		//LDAP Authentication type.
		if (args.authenticationType == 101) {

			var ldapServer = application.ldapAuthenticationServer;
			var ldapUserPrefix = application.ldapUserPrefix;
			var ldapUserSuffix = application.ldapUserSuffix;
			var ldapDC = application.ldapDC;

			try {

				//Attempt authentication to LDAP server.
				
				cfldap(name="ldapAuthenticate", action="query", username="#ldapUserPrefix#\#Replace(args.userUsername, ldapUserSuffix, '', 'ALL')#", password="#args.userPassword#", server="#ldapServer#", attributes="sn,mail,displayName", start="cn=users, dc=#ldapDC#");

				rsAuthenticationUser = authObj.getAuthenticationUser(args=args);

			} catch(any e) {

				//Fail the authentication if unsuccessful to LDAP.
				result.status = "false";
			
			}

		} else {

		//TODO: Develop additional authentication types.

		}

		//If authentication type(s) are successful based on result status.
		if (result.status == "true" && rsAuthenticationUser.recordcount != 0) {

			//Create SESSION variables for authenticated user.
			authObj.setSessionUserHandler(args=rsAuthenticationUser);

			//Set cookies.
			if (args.userRemember != 'false') {
		
				cfcookie(name="MCMS#UCASE(application.applicationname)#", domain="#CGI.SERVER_NAME#", value="#args.userUsername#", expires="never");

			} else {

				cfcookie(name="MCMS#UCASE(application.applicationname)#", domain="#CGI.SERVER_NAME#", value="", expires="now");

			}

			//Redirect to admin.
			location(url="#application.mcmsAppAdminPath#", addtoken="false");


		} else {

			result.status = 'false';
			result.message = application.mcmsAuthenticationFailed;

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
			qObj.addParam(name="userUsername",value="#args.userUsername##application.ldapUserSuffix#",cfsqltype="VARCHAR");
			qObj.addParam(name="userStatusID",value="#args.userStatusID#",list=true,cfsqltype="VARCHAR");
			result = qObj.execute(sql="SELECT ID, userFName, userLName, userEmail, userTelephone, userMobile, urID, urName, utName, utID, utName, userPrimarySiteNo, userPrimaryDeptNo FROM V_USER WHERE userEmail= :userUsername AND userStatus IN (:userStatusID)");
			q = result.getResult();
			recordcount = q.recordcount;
			qObj.clearParams();
			result = q;
			return result;

		} catch(any e) {

			message = "Authenticate Error: An error occurred with the getAuthenticationUser() function.";
			invoke('Application', 'onError', {e=e, eventName=message});

		}		

	}

	// [END getAuthenticationUser]

	// [START setSessionUserHandler]

	public string function setSessionUserHandler(required query args) {

		//Create objects
		authObj = CreateObject("component", "mcms.component.cms.Authenticate");

		try {	

			session.userAuthenticated = "true";
			session.userID = args.ID;
			session.userUsername = args.userFName & ' ' & args.userLName;
			session.userName = args.userFName & ' ' & args.userLName;
			session.userEmail = args.userEmail;
			session.userTelephone = args.userTelephone;
			session.userMobile = args.userMobile;
			session.urID = args.urID;
			session.urName = args.urName;
			session.utID = args.utID;
			session.utName = args.utName;
			session.userPrimarySiteNo = args.userPrimarySiteNo;
			session.userPrimaryDeptNo = args.userPrimaryDeptNo;

			//Set other SESSION variables based on relationships.
			authObj.setSessionUserSiteRel(args=args);
			authObj.setSessionUserDeptRel(args=args);
			authObj.setSessionUserRole(args=args);
			authObj.setSessionUserRoleGroupRel(args=args);
			authObj.setApplicationUserRoleAccessRel(args=args);
			

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
			qObj.addParam(name="urStatusID",value="1",list=true,cfsqltype="VARCHAR");
			result = qObj.execute(sql="SELECT ID, urName FROM TBL_USER_ROLE WHERE ID = :urID AND urStatus IN (:urStatusID)");
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
			qObj.addParam(name="urgStatusID",value="1",list=true,cfsqltype="VARCHAR");
			result = qObj.execute(sql="SELECT urgID, urgName FROM V_UR_GROUP_REL WHERE urID= :urID AND urgrStatus IN (:urgStatusID)");
			q = result.getResult();
			recordcount = q.recordcount;
			qObj.clearParams();
			result = q;

			if (recordcount != 0) {

				session.urgID = ValueList(result.urgID);
				session.urgName = ValueList(result.urgName);
			
				//Clear query obj.
				qObj = '';

				//Now collect user group urID's to apply to the session.

				qObj = new query();
				qObj.setDatasource(application.mcmsDSN);
				qObj.setName("q");
				qObj.addParam(name="urgID",value="#args.urID#",list=true,cfsqltype="VARCHAR");
				qObj.addParam(name="urStatusID",value="1",list=true,cfsqltype="VARCHAR");
				result = qObj.execute(sql="SELECT urID, urName FROM V_UR_GROUP_REL WHERE urgID IN (:urgID) AND urStatus IN (:urStatusID)");
				q = result.getResult();
				recordcount = q.recordcount;
				qObj.clearParams();
				result = q;

				if (recordcount != 0) {

					session.urID = ValueList(result.urID);
					session.urName = ValueList(result.urName);

				}

			}

		} catch(any e) {

			message = "Authenticate Error: An error occurred with the setSessionUserRoleGroupRel() function.";
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
			qObj.addParam(name="siteStatusID",value="1",list=true,cfsqltype="VARCHAR");
			result = qObj.execute(sql="SELECT siteNo FROM TBL_USER_SITE_REL WHERE userID = :userID AND usrStatus IN (:siteStatusID)");
			q = result.getResult();
			recordcount = q.recordcount;
			qObj.clearParams();
			result = q;
			
			if (recordcount != 0) {

				session.siteNo = ValueList(result.siteNo);

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
			qObj.addParam(name="deptStatusID",value="1",list=true,cfsqltype="VARCHAR");
			result = qObj.execute(sql="SELECT deptNo FROM TBL_USER_DEPARTMENT_REL WHERE userID= :userID AND udrStatus IN (:deptStatusID)");
			q = result.getResult();
			recordcount = q.recordcount;
			qObj.clearParams();
			result = q;
			
			if (recordcount != 0) {

				session.deptNo = ValueList(result.deptNo);

			}

		} catch(any e) {

			message = "Authenticate Error: An error occurred with the setSessionUserDeptRel() function.";
			invoke('Application', 'onError', {e=e, eventName=message});

		}	

	}

	// [END setSessionUserDeptRel]

	// [START setApplicationUserRoleAccessRel]


	public void function setApplicationUserRoleAccessRel(required query args) {

		try {		

			qObj = new query();
			qObj.setDatasource(application.mcmsDSN);
			qObj.setName("q");
			qObj.addParam(name="urID",value="#args.urID#",cfsqltype="NUMERIC");
			qObj.addParam(name="appStatusID",value="1",list=true,cfsqltype="VARCHAR");
			result = qObj.execute(sql="SELECT appID, uaID FROM V_USER_ROLE_ACCESS WHERE urID = :urID AND appStatus IN (:appStatusID) AND uraStatus IN (:appStatusID)");
			q = result.getResult();

			//Sort the result.
			sort = QuerySort(q, function (c1, c2){

				return compare(c1.appID, c2.appID);

			});
			
			recordcount = q.recordcount;
			qObj.clearParams();
			result = q;
			
			if (recordcount != 0) {

				session.urappID = ValueList(result.appID);
				session.uraID = ValueList(result.uaID);

			}

		} catch(any e) {

			message = "Authenticate Error: An error occurred with the setApplicationUserRoleAccessRel() function.";
			invoke('Application', 'onError', {e=e, eventName=message});

		}	

	}

	// [END setApplicationUserRoleAccessRel]

}