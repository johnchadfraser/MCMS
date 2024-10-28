<cfcomponent>
    <cffunction name="setSignIn" access="public" returntype="struct" hint="Authenticate users to administration site.">
    <cfargument name="userEmail" type="string" required="yes" default="">
    <cfargument name="userPassword" type="string" required="yes" default="">
    <cfargument name="mcmsDenied" type="string" required="yes" default="">
    <cfargument name="authenticationType" type="string" required="no" default="#application.authenticationType#">
    <cfset result.status = true>
    <cfset result.message = 'You have successfully Signed In.'>
    <cfset mcmsAuthenticate = false>
    
    
    <!---Basic authentication includes a bypass feature if the username/useremail contains a value in the application.userBasicAuthOverride value.  This will also bypass if the default authentication type is exchange.--->
    <cfif ARGUMENTS.authenticationType EQ 'basic' OR ARGUMENTS.userEmail CONTAINS application.userBasicAuthOverride>
    <cftry>
    <!---If encryption is used and a value is present.--->
    <cfinvoke 
    component="MCMS.component.cms.User"
    method="getUserSecurityKeyRel"
    returnvariable="getUserSecurityKeyRelRet">
    <cfinvokeargument name="userEmail" value="#Iif(application.authenticationType EQ 'exchange' AND ARGUMENTS.userEmail DOES NOT CONTAIN '@', DE(UCASE('#ARGUMENTS.userEmail##application.exchangeUserSuffix#')), DE(UCASE(ARGUMENTS.userEmail)))#"/>
    <cfinvokeargument name="uskrStatus" value="1"/>
    </cfinvoke>
    <cfif getUserSecurityKeyRelRet.recordcount NEQ 0>
    <cfset this.uskrKey = getUserSecurityKeyRelRet.uskrKey>
    <cfset this.uskrKeyValue = getUserSecurityKeyRelRet.uskrKeyValue>
    <cfinvoke 
    component="MCMS.component.app.security.Security"
    method="setDecryption"
    returnvariable="setDecryptionRet">
    <cfinvokeargument name="encryptKey" value="#this.uskrKey#"/>
    <cfinvokeargument name="encryptKeyValue" value="#this.uskrKeyValue#"/>
    </cfinvoke>
    <cfif setDecryptionRet EQ ARGUMENTS.userPassword>
    <cfset mcmsAuthenticate = true>
    </cfif>
    </cfif>
    <cfquery name="rsSignIn" datasource="#application.mcmsDSN#">
    SELECT * FROM tbl_user
    WHERE 0=0 
    AND UPPER(userEmail) = <cfqueryparam value="#Iif(application.authenticationType EQ 'exchange' AND ARGUMENTS.userEmail DOES NOT CONTAIN '@', DE(UCASE('#ARGUMENTS.userEmail##application.exchangeUserSuffix#')), DE(UCASE(ARGUMENTS.userEmail)))#" cfsqltype="cf_sql_varchar">
    <cfif mcmsAuthenticate EQ false>
    AND userPassword = <cfqueryparam value="#ARGUMENTS.userPassword#" cfsqltype="cf_sql_varchar">
    </cfif>
    AND userStatus = <cfqueryparam value="1" cfsqltype="cf_sql_integer">
    </cfquery>
    <cfcatch type="any">
    <cfset result.status = false>
    <cfset result.message = 'An error occured when accessing the User record.'>
    </cfcatch>
    </cftry>
    <cfelseif ARGUMENTS.authenticationType EQ 'exchange' AND ARGUMENTS.userEmail CONTAINS "@">
    <cftry>
    <!---If encryption is used and a value is present.--->
    <cfinvoke 
    component="MCMS.component.cms.User"
    method="getUserSecurityKeyRel"
    returnvariable="getUserSecurityKeyRelRet">
    <cfinvokeargument name="userEmail" value="#ARGUMENTS.userEmail#"/>
    <cfinvokeargument name="uskrStatus" value="1"/>
    </cfinvoke>
    <cfif getUserSecurityKeyRelRet.recordcount NEQ 0>
    <cfset this.uskrKey = getUserSecurityKeyRelRet.uskrKey>
    <cfset this.uskrKeyValue = getUserSecurityKeyRelRet.uskrValue>
    <cfinvoke 
    component="MCMS.component.app.security.Security"
    method="setDecryption"
    returnvariable="setDecryptionRet">
    <cfinvokeargument name="encryptKey" value="#this.uskrKey#"/>
    <cfinvokeargument name="encryptKeyValue" value="#this.uskrKeyValue#"/>
    </cfinvoke>
    <cfif setDecryptionRet EQ ARGUMENTS.userPassword>
    <cfset ARGUMENTS.userPassword = setDecryptionRet>
    <cfelse>
    <cfset ARGUMENTS.userPassword = ''>
    </cfif>
    </cfif>
    <cfquery name="rsSignIn" datasource="#application.mcmsDSN#">
    SELECT * FROM tbl_user
    WHERE 0=0 
    AND UPPER(userEmail) = <cfqueryparam value="#UCASE(ARGUMENTS.userEmail)#" cfsqltype="cf_sql_varchar">
    AND userPassword = <cfqueryparam value="#ARGUMENTS.userPassword#" cfsqltype="cf_sql_varchar">
    AND userStatus IN (<cfqueryparam value="1,3" list="yes" cfsqltype="cf_sql_integer">)
    </cfquery>
    <cfcatch type="any">
    <cfset result.status = false>
    <cfset result.message = 'An error occured when accessing the User record. Please try signing in using a username not you email address.'>
    </cfcatch>
    </cftry>
    <cfelseif ARGUMENTS.authenticationType EQ 'exchange' AND ARGUMENTS.userEmail DOES NOT CONTAIN "@">
    <!---Set the global exchange settings.--->
    <cfset exchangeServer = application.exchangeServer>
	<cfset exchangeUserPrefix = application.exchangeUserPrefix>
    <cfset exchangeUserSuffix = application.exchangeUserSuffix>
    <cfset exchangeDC = application.exchangeDC>
    <cftry>
	<cfldap action="query" name="exchangeAuthentication" username="#exchangeUserPrefix#\#Replace(ARGUMENTS.userEmail, application.exchangeUserSuffix, '', 'ALL')#" password="#ARGUMENTS.userPassword#" server="#exchangeServer#" attributes="sn,mail,displayName" start="cn=users, dc=#exchangeDC#">
    <cfquery name="rsSignIn" datasource="#application.mcmsDSN#">
    SELECT * FROM tbl_user
    WHERE 0=0 
    AND userEmail = <cfqueryparam value="#ARGUMENTS.userEmail##application.exchangeUserSuffix#" cfsqltype="cf_sql_varchar">
    AND userStatus IN (<cfqueryparam value="1,3" list="yes" cfsqltype="cf_sql_integer">)
    </cfquery>
    <cfcatch type="any">
    <cfset result.status = false>
    <cfset result.message = 'An error occured when accessing the User Exchange record.'>
    </cfcatch>
    </cftry>
    </cfif>
    <!---If the sign in was successful then proceed.--->    
    <cfif result.status EQ true AND rsSignIn.recordcount NEQ 0>
    <!---Get last time signed in.--->
    <cfset lastSignedIn = rsSignIn.userDateLast>
    <cfif (lastSignedIn IS "") OR (NOT IsDate(lastSignedIn))>
    <cfset lastSignedIn=CreateODBCDateTime(Now())>
    <cfelse>
    <cfset lastSignedIn=CreateODBCDateTime(lastSignedIn)>
    </cfif>
    <!--- Set the cookie/client vars --->
    <cfcookie name="userID" value="#rsSignIn.ID#">
    <cfset session.signedIn = 'true'>
    <!--- Create SESSION variables. --->
    <!---SESSION user.--->
    <cfset session.userUsername = rsSignIn.userEmail>
    <cfset session.userEmail = rsSignIn.userEmail>
    <cfset session.userName = rsSignIn.userFName & ' ' & rsSignIn.userLName>
    <cfset session.userID = rsSignIn.ID>
    <!---<cfset session.empID = rsSignIn.empID>--->
    <!---SESSION role used to manage user rights.--->
    <cfset session.urID = rsSignIn.urID>
    <!---SESSION siteNo for accessing certain site specific data.--->
    <cftry>
    <cfquery name="rsUserSiteRel" datasource="#application.mcmsDSN#">
    SELECT siteNo FROM tbl_user_site_rel
    WHERE 0=0 
    AND userID = <cfqueryparam value="#session.userID#" cfsqltype="cf_sql_integer">
    AND usrStatus IN (<cfqueryparam value="1,3" list="yes" cfsqltype="cf_sql_integer">)
    </cfquery>
    <!---Construct siteNo list.--->
    <cfset session.siteNo = IIf(rsUserSiteRel.recordcount EQ 0, '0', DE('#ValueList(rsUserSiteRel.siteNo, ",")#'))>
    <cfcatch type="any">
    <cfset result.status = false>
    <cfset result.message = 'An error occured when accessing the User Site Relationship record.'>
    </cfcatch>
    </cftry>
    <!---SESSION deptNo for accessing certain department specific data.--->
    <cftry>
    <cfquery name="rsUserDepartmentRel" datasource="#application.mcmsDSN#">
    SELECT deptNo FROM tbl_user_department_rel
    WHERE 0=0 
    AND userID = <cfqueryparam value="#session.userID#" cfsqltype="cf_sql_integer">
    AND udrStatus IN (<cfqueryparam value="1,3" list="yes" cfsqltype="cf_sql_integer">)
    </cfquery>
    <!---Construct deptNo list.--->
    <cfset session.deptNo = IIf(rsUserDepartmentRel.recordcount EQ 0, '99', DE('#ValueList(rsUserDepartmentRel.deptNo, ",")#'))>
    <cfcatch type="any">
    <cfset result.status = false>
    <cfset result.message = 'An error occured when accessing the User Department Relationship record.'>
    </cfcatch>
    </cftry>
    <cfset session.lastSignedIn = lastSignedIn>
    <!---Get user role.--->
    <cftry>
    <cfinvoke 
    component="MCMS.component.cms.User"
    method="getUserRole"
    returnvariable="getUserRoleRet">
    <cfinvokeargument name="ID" value="#session.urID#">
    </cfinvoke>
    <!---User Role---> 
    <cfset session.userRole = getUserRoleRet.urName>
    <cfcatch type="any">
    <cfset result.status = false>
    <cfset result.message = 'An error occured when accessing the User Role record.'>
    </cfcatch>
    </cftry>
    <!---SESSION user role access for accessing certain applications.--->
    <cftry>
    <cfinvoke 
    component="MCMS.component.cms.User"
    method="getUserRoleAccess"
    returnvariable="getUserRoleAccessRet">
    <cfinvokeargument name="urID" value="#session.urID#"/>
    <cfinvokeargument name="orderBy" value="appID"/>
    </cfinvoke>
    <!---Construct appID list.--->
    <cfset session.userRoleAccess = IIf(getUserRoleAccessRet.recordcount EQ 0, '100', DE('100,#ValueList(getUserRoleAccessRet.appID, ",")#'))>
    <cfcatch type="any">
    <cfset result.status = false>
    <cfset result.message = 'An error occured when accessing the User Role Access record.'>
    </cfcatch>
    </cftry>
    <!---If encryption is used and no value is present create it.--->
    <cfinvoke 
    component="MCMS.component.app.security.Security"
    method="setEcryption"
    returnvariable="setEcryptionRet">
    <cfinvokeargument name="value" value="#ARGUMENTS.userPassword#"/>
    <cfinvokeargument name="valuePair" value="lorem"/>
    </cfinvoke>
    <cfset ARGUMENTS.userPassword = setEcryptionRet.encryptKey>
    <cfinvoke 
    component="MCMS.component.cms.User"
    method="insertUserSecurityKeyRel"
    returnvariable="insertUserSecurityKeyRelRet">
    <cfinvokeargument name="userID" value="#session.userID#"/>
    <cfinvokeargument name="uskrKey" value="#setEcryptionRet.encryptKey#"/>
    <cfinvokeargument name="uskrKeyValue" value="#setEcryptionRet.encryptKeyValue#"/>
    <cfinvokeargument name="uskrStatus" value="1"/>
    </cfinvoke>
    <!--- Store username inside a COOKIE if required --->
    <cfif IsDefined("form.rememberUser")>
    <cfcookie name="adminUsername#application.applicationName#" value="#ARGUMENTS.userEmail#" expires="never">
    <!--- Else, clean any existing COOKIE --->
    <cfelse>
    <cfcookie name="adminUsername#application.applicationName#" value="" expires="now">
    </cfif>
    <!--- Update user sign-in date --->
    <cftry>
    <cfinvoke 
    component="MCMS.component.cms.User"
    method="updateSignIn">
    <cfinvokeargument name="userDateHistory" value="#lastSignedIn#"/>
    <cfinvokeargument name="userDateLast" value="#CreateODBCDateTime(Now())#"/>
    <cfinvokeargument name="userEmail" value="#session.userUsername#"/>
    <cfinvokeargument name="userPassword" value="#ARGUMENTS.userPassword#"/>
    </cfinvoke>
    <cfcatch type="any">
    <cfset result.status = false>
    <cfset result.message = 'An error occured when accessing the Update User Sign In record.'>
    </cfcatch>
    </cftry>
    <!---Redirect to path requested if authentication is successful.--->
    <cflocation url="#ARGUMENTS.mcmsDenied#" addtoken="no">
    <cfelse>
    <cfset result.status = false>
    <cfif ARGUMENTS.authenticationType EQ 'exchange' AND ARGUMENTS.userEmail DOES NOT CONTAIN "@">
    <cfset result.message = "You have <u>not</u> successfully Signed In. Please try again. <br/>You are authenticating using your Windows&reg; username password and your password may have expired. <br /><br />Please contact the Help Desk if you require assistance, see options below. <br /><a href='#application.helpDeskServiceURL#' target='_blank'><span class='glyphicon glyphicon-link'></span>Help Desk</a>">
    <cfelse>
    <cfset result.message = "You have <u>not</u> successfully Signed In. Please try again or click the 'Retrieve Password' option to have your sign in information sent to your email.<br /><br /><a href='#application.helpDeskServiceURL#' target='_blank'><span class='glyphicon glyphicon-link'></span>Help Desk</a>">
    </cfif>
    </cfif>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="getRetrieveSignIn" access="public" returntype="struct" hint="Retrieve user password and send email.">
    <!---This method will only function with basic authetication.--->
    <cfargument name="userEmail" type="string" required="yes" default="">
	<cfset var rsRetrieveSignIn = "">
    <cfset result.message = 'Your sign in information was successfully sent to your email. You should receive it shortly.'>
    <cftry>
    <cfquery name="rsRetrieveSignIn" datasource="#application.mcmsDSN#">
    SELECT * FROM tbl_user
    WHERE 0=0 
    AND UPPER(userEmail) = <cfqueryparam value="#UCASE(ARGUMENTS.userEmail)#" cfsqltype="cf_sql_varchar">
    AND userStatus = <cfqueryparam value="1" cfsqltype="cf_sql_integer">
    </cfquery>
    <cfif rsRetrieveSignIn.recordcount NEQ 0>
    <!---If encryption is used and a value is present.--->
    <cfinvoke 
    component="MCMS.component.cms.User"
    method="getUserSecurityKeyRel"
    returnvariable="getUserSecurityKeyRelRet">
    <cfinvokeargument name="userEmail" value="#Iif(application.authenticationType EQ 'exchange' AND ARGUMENTS.userEmail DOES NOT CONTAIN '@', DE(UCASE('#ARGUMENTS.userEmail##application.exchangeUserSuffix#')), DE(UCASE(ARGUMENTS.userEmail)))#"/>
    <cfinvokeargument name="uskrStatus" value="1"/>
    </cfinvoke>
    <cfif getUserSecurityKeyRelRet.recordcount NEQ 0>
    <cfset this.uskrKey = getUserSecurityKeyRelRet.uskrKey>
    <cfset this.uskrKeyValue = getUserSecurityKeyRelRet.uskrKeyValue>
    <cfinvoke 
    component="MCMS.component.app.security.Security"
    method="setDecryption"
    returnvariable="setDecryptionRet">
    <cfinvokeargument name="encryptKey" value="#this.uskrKey#"/>
    <cfinvokeargument name="encryptKeyValue" value="#this.uskrKeyValue#"/>
    </cfinvoke>
    <cfset mcmsAuthenticate = true>
    <cfset this.userPassword = setDecryptionRet>
    </cfif>
    <!---Create the body of the message.--->
    <cfsavecontent variable="body">
    <cfoutput>
    #rsRetrieveSignIn.userFName# #rsRetrieveSignIn.userLName#, you recently requested your Sign In information.<br/><br/>
    Username: #Iif(application.authenticationType EQ 'exchange', DE(LCASE(Replace(ARGUMENTS.userEmail, application.exchangeUserSuffix, '', 'ALL'))), DE(LCASE(ARGUMENTS.userEmail)))#.<br/>
    Password: #Iif(mcmsAuthenticate EQ true, DE(this.userPassword), DE(rsRetrieveSignIn.userPassword))#.<br/><br/>
    <a href="http://#CGI.HTTP_HOST#/#application.mcmsAppAdminPath#">Sign In Now!</a>
    </cfoutput> 
    </cfsavecontent>
    <!---Send the email.--->
    <cfinvoke 
    component="MCMS.component.utility.Utility.Email"
    method="sendEmail">
    <cfinvokeargument name="subject" value="Retrieve Sign In"/>
    <cfinvokeargument name="to" value="#ARGUMENTS.userEmail#"/>
    <cfinvokeargument name="from" value="#application.companyEmail#"/>
    <cfinvokeargument name="body" value="#body#"/>
    </cfinvoke>
    <cfelse>
    <cfset result.message = 'The email address you have entered does not match any records in our system. Please try again.'>
    </cfif>
    <cfcatch type="any">
    <cfset result.message = 'An error occured when accessing the User record.'>
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="getUser" access="public" returntype="query" hint="Get User information.">
    <cfargument name="keywords" type="string" required="no" default="All">
    <cfargument name="ID" type="string" required="yes" default="0">
    <cfargument name="excludeID" type="numeric" required="yes" default="0">
    <cfargument name="urID" type="string" required="yes" default="0">
    <cfargument name="uttID" type="string" required="yes" default="0">
    <cfargument name="utID" type="string" required="yes" default="0">
    <cfargument name="userEmail" type="string" required="yes" default="">
    <cfargument name="userStatus" type="string" required="yes" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="userLName">
	  <cfset var rsUser = "" >
    <cftry>
    <cfquery name="rsUser" datasource="#application.mcmsDSN#">
    SELECT * FROM v_user WHERE 0=0
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(userFName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> 
    OR UPPER(userLName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> 
    OR UPPER(userEmail) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">
    OR UPPER(urName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">
    )
    </cfif>
    <cfif ARGUMENTS.ID NEQ 0>
    AND ID IN (<cfqueryparam value="#ARGUMENTS.ID#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    <cfif ARGUMENTS.excludeID NEQ 0>
    AND ID <> <cfqueryparam value="#ARGUMENTS.excludeID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.urID NEQ 0>
    AND urID IN (<cfqueryparam value="#ARGUMENTS.urID#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    <cfif ARGUMENTS.utID NEQ 0>
    AND utID IN (<cfqueryparam value="#ARGUMENTS.utID#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    <cfif ARGUMENTS.uttID NEQ 0>
    AND uttID IN (<cfqueryparam value="#ARGUMENTS.uttID#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    <cfif ARGUMENTS.userEmail NEQ "">
    AND UPPER(userEmail) = <cfqueryparam value="#UCASE(ARGUMENTS.userEmail)#" cfsqltype="cf_sql_varchar">
    </cfif>
    AND userStatus IN (<cfqueryparam value="#ARGUMENTS.userStatus#" list="yes" cfsqltype="cf_sql_integer">)
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsUser = StructNew()>
    <cfset rsUser.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsUser>
    </cffunction>
    
    <cffunction name="getUserToken" access="public" returntype="query" hint="Get User Token information.">
    <cfargument name="ID" type="string" required="yes" default="0">
    <cfargument name="excludeID" type="numeric" required="yes" default="0">
    <cfargument name="userID" type="numeric" required="yes" default="0">
    <cfargument name="utToken" type="string" required="yes" default="">
    <cfargument name="utStatus" type="string" required="yes" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="ID">
	 <cfset var rsUserToken = "" >
    <!---<cftry>--->
    <cfquery name="rsUserToken" datasource="#application.mcmsDSN#">
    SELECT * FROM tbl_user_token WHERE 0=0
    <cfif ARGUMENTS.ID NEQ 0>
    AND ID IN (<cfqueryparam value="#ARGUMENTS.ID#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    <cfif ARGUMENTS.excludeID NEQ 0>
    AND ID <> <cfqueryparam value="#ARGUMENTS.excludeID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.userID NEQ 0>
    AND userID <cfqueryparam value="#ARGUMENTS.userID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.utToken NEQ "">
    AND utToken= <cfqueryparam value="#ARGUMENTS.utToken#" cfsqltype="cf_sql_varchar">
    </cfif>
    AND utStatus IN (<cfqueryparam value="#ARGUMENTS.utStatus#" list="yes" cfsqltype="cf_sql_integer">)
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.
    <cfcatch type="any">
    <cfset rsUserToken = StructNew()>
    <cfset rsUserToken.message = "There was an error with the query.">
    </cfcatch>
    </cftry>--->
    <cfreturn rsUserToken>
    </cffunction>
    
    <cffunction name="getUserSiteRel" access="public" returntype="query" hint="Get User Site Relationship data.">
    <cfargument name="keywords" type="string" required="no" default="All">
    <cfargument name="ID" type="numeric" required="yes" default="0">
    <cfargument name="userID" type="string" required="yes" default="0">
    <cfargument name="urID" type="string" required="yes" default="0">
    <cfargument name="stID" type="numeric" required="yes" default="0">
    <cfargument name="siteNo" type="string" required="yes" default="100">
    <cfargument name="siteStatus" type="string" required="no" default="1">
    <cfargument name="urStatus" type="string" required="no" default="1">
    <cfargument name="userStatus" type="string" required="no" default="1">
    <cfargument name="usrStatus" type="string" required="yes" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="siteNo">
	<cfset var rsUserSiteRel = "" >
    <cftry>
    <cfquery name="rsUserSiteRel" datasource="#application.mcmsDSN#">
    SELECT * FROM v_user_site_rel WHERE 0=0
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND siteNo LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> 
    </cfif>
    <cfif ARGUMENTS.ID NEQ 0>
    AND ID = <cfqueryparam value="#ARGUMENTS.ID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.userID NEQ 0>
    AND userID IN (<cfqueryparam value="#ARGUMENTS.userID#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    <cfif ARGUMENTS.urID NEQ 0>
    AND urID IN (<cfqueryparam value="#ARGUMENTS.urID#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    <cfif ARGUMENTS.siteNo NEQ 100>
    AND siteNo IN (<cfqueryparam value="#ARGUMENTS.siteNo#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    <cfif ARGUMENTS.stID NEQ 0>
    AND stID = <cfqueryparam value="#ARGUMENTS.stID#" cfsqltype="cf_sql_integer">
    </cfif>
    AND (siteStatus IN (<cfqueryparam value="#ARGUMENTS.siteStatus#" list="yes" cfsqltype="cf_sql_integer">) OR siteStatus IS NULL)
    AND urStatus IN (<cfqueryparam value="#ARGUMENTS.urStatus#" list="yes" cfsqltype="cf_sql_integer">)
    AND userStatus IN (<cfqueryparam value="#ARGUMENTS.userStatus#" list="yes" cfsqltype="cf_sql_integer">)
    AND usrStatus IN (<cfqueryparam value="#ARGUMENTS.usrStatus#" list="yes" cfsqltype="cf_sql_integer">)
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsUserSiteRel = StructNew()>
    <cfset rsUserSiteRel.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsUserSiteRel>
    </cffunction>
    
    <cffunction name="getDistinctUserSiteRel" access="public" returntype="query" hint="Get User Site Relationship data.">
    <cfargument name="keywords" type="string" required="no" default="All">
    <cfargument name="ID" type="numeric" required="yes" default="0">
    <cfargument name="userID" type="string" required="yes" default="0">
    <cfargument name="urID" type="string" required="yes" default="0">
    <cfargument name="stID" type="numeric" required="yes" default="0">
    <cfargument name="siteNo" type="string" required="yes" default="100">
    <cfargument name="siteStatus" type="string" required="no" default="1">
    <cfargument name="urStatus" type="string" required="no" default="1">
    <cfargument name="userStatus" type="string" required="no" default="1">
    <cfargument name="usrStatus" type="string" required="yes" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="siteName, urName, userLName">
	<cfset var rsUserSiteRel = "" >
    <cftry>
    <cfquery name="rsUserSiteRel" datasource="#application.mcmsDSN#">
    SELECT DISTINCT userID, userFName, userLName, userEmail, urName, siteNo, siteName FROM v_user_site_rel WHERE 0=0
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND siteNo LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> 
    </cfif>
    <cfif ARGUMENTS.ID NEQ 0>
    AND ID = <cfqueryparam value="#ARGUMENTS.ID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.userID NEQ 0>
    AND userID IN (<cfqueryparam value="#ARGUMENTS.userID#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    <cfif ARGUMENTS.urID NEQ 0>
    AND urID IN (<cfqueryparam value="#ARGUMENTS.urID#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    <cfif ARGUMENTS.siteNo NEQ 100>
    AND siteNo IN (<cfqueryparam value="#ARGUMENTS.siteNo#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    <cfif ARGUMENTS.stID NEQ 0>
    AND stID = <cfqueryparam value="#ARGUMENTS.stID#" cfsqltype="cf_sql_integer">
    </cfif>
    AND (siteStatus IN (<cfqueryparam value="#ARGUMENTS.siteStatus#" list="yes" cfsqltype="cf_sql_integer">) OR siteStatus IS NULL)
    AND urStatus IN (<cfqueryparam value="#ARGUMENTS.urStatus#" list="yes" cfsqltype="cf_sql_integer">)
    AND userStatus IN (<cfqueryparam value="#ARGUMENTS.userStatus#" list="yes" cfsqltype="cf_sql_integer">)
    AND usrStatus IN (<cfqueryparam value="#ARGUMENTS.usrStatus#" list="yes" cfsqltype="cf_sql_integer">)
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsUserSiteRel = StructNew()>
    <cfset rsUserSiteRel.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsUserSiteRel>
    </cffunction>
    
    <cffunction name="getUserDepartmentRel" access="public" returntype="query" hint="Get User Department Relationship data.">
    <cfargument name="keywords" type="string" required="no" default="All">
    <cfargument name="ID" type="numeric" required="yes" default="0">
    <cfargument name="urID" type="string" required="yes" default="0">
    <cfargument name="userID" type="numeric" required="yes" default="0">
    <cfargument name="userEmail" type="string" required="yes" default="">
    <cfargument name="deptNo" type="string" required="yes" default="0">
    <cfargument name="udrStatus" type="string" required="yes" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="deptNo">
	<cfset var rsUserDepartmentRel = "" >
    <cftry>
    <cfquery name="rsUserDepartmentRel" datasource="#application.mcmsDSN#">
    SELECT * FROM v_user_department_rel WHERE 0=0
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND deptNo LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> 
    </cfif>
    <cfif ARGUMENTS.ID NEQ 0>
    AND ID = <cfqueryparam value="#ARGUMENTS.ID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.urID NEQ 0>
    AND urID IN (<cfqueryparam value="#ARGUMENTS.urID#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    <cfif ARGUMENTS.userID NEQ 0>
    AND userID = <cfqueryparam value="#ARGUMENTS.userID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.userEmail NEQ ''>
    AND userEmail IN (<cfqueryparam value="#ARGUMENTS.userEmail#" list="yes" separator=";" cfsqltype="cf_sql_varchar">)
    </cfif>
    <cfif ARGUMENTS.deptNo NEQ 0>
    AND deptNo IN (<cfqueryparam value="#ARGUMENTS.deptNo#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    AND udrStatus IN (<cfqueryparam value="#ARGUMENTS.udrStatus#" list="yes" cfsqltype="cf_sql_integer">)
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsUserDepartmentRel = StructNew()>
    <cfset rsUserDepartmentRel.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsUserDepartmentRel>
    </cffunction>
    
    <cffunction name="getUserByDepartmentRel" access="public" returntype="query" hint="Get User By Department Relationship data.">
    <cfargument name="ID" type="numeric" required="yes" default="0">
    <cfargument name="urID" type="string" required="yes" default="0">
    <cfargument name="deptNo" type="string" required="yes" default="0">
    <cfargument name="udrStatus" type="string" required="yes" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="userFName">
	<cfset var rsUserByDepartmentRel = "" >
    <cftry>
    <!---Get a list of users by department.--->
    <cfquery name="rsUserByDepartmentRel" datasource="#application.mcmsDSN#">
    SELECT DISTINCT userID FROM v_user_department_rel WHERE 0=0
    AND deptNo IN (<cfqueryparam value="#Iif(ARGUMENTS.deptNo EQ 0, DE(application.retailDepartmentList), DE(ARGUMENTS.deptNo))#" list="yes" cfsqltype="cf_sql_integer">)
    AND urID IN (<cfqueryparam value="#ARGUMENTS.urID#" list="yes" cfsqltype="cf_sql_integer">)
    AND udrStatus IN (<cfqueryparam value="#ARGUMENTS.udrStatus#" list="yes" cfsqltype="cf_sql_integer">)
    ORDER BY userID
    </cfquery>
    <cfif rsUserByDepartmentRel.recordcount NEQ 0>
    <cfset this.userByDepartmentList = ValueList(rsUserByDepartmentRel.userID)>
    <cfelse>
    <cfset this.userByDepartmentList = 0>
    </cfif>
    <!---Clean up the list if it is greater then 1000 to prevent SQL errors.--->
    <cfif ListLen(this.userByDepartmentList) GT 999>
    <cfset this.userByDepartmentList = LEFT(ListRemoveDuplicates(this.userByDepartmentList), 4000)>
    </cfif>
    <!---Get a list of users by department.--->
    <cfquery name="rsUserByDepartmentRel" datasource="#application.mcmsDSN#">
    SELECT * FROM v_user_department_rel WHERE 0=0
    AND userID IN (<cfqueryparam value="#ListRemoveDuplicates(this.userByDepartmentList)#" list="yes" cfsqltype="cf_sql_integer">)
    AND urID IN (<cfqueryparam value="#ARGUMENTS.urID#" list="yes" cfsqltype="cf_sql_integer">)
    AND userStatus = <cfqueryparam value="1" cfsqltype="cf_sql_integer">
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsUserByDepartmentRel = StructNew()>
    <cfset rsUserByDepartmentRel.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsUserByDepartmentRel>
    </cffunction>
    
    <cffunction name="getUserSiteDepartmentRel" access="public" returntype="query" hint="Get User Site Department Relationship data.">
    <cfargument name="keywords" type="string" required="no" default="All">
    <cfargument name="ID" type="numeric" required="yes" default="0">
    <cfargument name="urID" type="string" required="yes" default="0">
    <cfargument name="userID" type="numeric" required="yes" default="0">
    <cfargument name="userEmail" type="string" required="yes" default="">
    <cfargument name="siteNo" type="numeric" required="yes" default="100">
    <cfargument name="deptNo" type="numeric" required="yes" default="0">
    <cfargument name="udrStatus" type="string" required="yes" default="1,3">
    <cfargument name="usrStatus" type="string" required="yes" default="1,3">
    <cfargument name="userStatus" type="string" required="yes" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="deptNo">
	<cfset var rsUserSiteDepartmentRel = "" >
    <cftry>
    <cfquery name="rsUserSiteDepartmentRel" datasource="#application.mcmsDSN#">
    SELECT * FROM v_user_site_department_rel WHERE 0=0
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND deptNo LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> 
    </cfif>
    <cfif ARGUMENTS.ID NEQ 0>
    AND ID = <cfqueryparam value="#ARGUMENTS.ID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.urID NEQ 0>
    AND urID IN (<cfqueryparam value="#ARGUMENTS.urID#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    <cfif ARGUMENTS.userID NEQ 0>
    AND userID = <cfqueryparam value="#ARGUMENTS.userID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.userEmail NEQ ''>
    AND userEmail IN (<cfqueryparam value="#ARGUMENTS.userEmail#" list="yes" separator=";" cfsqltype="cf_sql_varchar">)
    </cfif>
    <cfif ARGUMENTS.deptNo NEQ 0>
    AND deptNo IN (<cfqueryparam value="#ARGUMENTS.deptNo#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    <cfif ARGUMENTS.siteNo NEQ 100>
    AND siteNo IN (<cfqueryparam value="#ARGUMENTS.siteNo#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    AND udrStatus IN (<cfqueryparam value="#ARGUMENTS.udrStatus#" list="yes" cfsqltype="cf_sql_integer">)
    AND usrStatus IN (<cfqueryparam value="#ARGUMENTS.usrStatus#" list="yes" cfsqltype="cf_sql_integer">)
    AND userStatus IN (<cfqueryparam value="#ARGUMENTS.userStatus#" list="yes" cfsqltype="cf_sql_integer">)
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsUserSiteDepartmentRel = StructNew()>
    <cfset rsUserSiteDepartmentRel.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsUserSiteDepartmentRel>
    </cffunction>
    
    <cffunction name="getUserTitle" access="public" returntype="query" hint="Get User Title data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="ID" type="numeric" required="yes" default="0">
    <cfargument name="excludeID" type="numeric" required="yes" default="0">
    <cfargument name="utName" type="string" required="yes" default="">
    <cfargument name="uttID" type="string" required="yes" default="0">
    <cfargument name="utStatus" type="string" required="yes" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="utName">
    <cfset var rsUserTitle = "" >
    <cftry>
    <cfquery name="rsUserTitle" datasource="#application.mcmsDSN#">
    SELECT * FROM v_user_title WHERE 0=0
    <cfif ARGUMENTS.ID NEQ 0>
    AND ID = <cfqueryparam value="#ARGUMENTS.ID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.excludeID NEQ 0>
    AND ID <> <cfqueryparam value="#ARGUMENTS.excludeID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(utName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(utDescription) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">)
    </cfif>
    <cfif ARGUMENTS.utName NEQ "">
    AND UPPER(utName) = <cfqueryparam value="#UCASE(ARGUMENTS.utName)#" cfsqltype="cf_sql_varchar">
    </cfif>
    <cfif ARGUMENTS.uttID NEQ 0>
    AND uttID = <cfqueryparam value="#ARGUMENTS.uttID#" cfsqltype="cf_sql_integer">
    </cfif>
    AND utStatus IN (<cfqueryparam value="#ARGUMENTS.utStatus#" list="yes" cfsqltype="cf_sql_integer">)
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsUserTitle = StructNew()>
    <cfset rsUserTitle.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsUserTitle>
    </cffunction>
    
    <cffunction name="getUserTitleType" access="public" returntype="query" hint="Get User Title Type data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="ID" type="numeric" required="yes" default="0">
    <cfargument name="excludeID" type="numeric" required="yes" default="0">
    <cfargument name="uttName" type="string" required="yes" default="">
    <cfargument name="uttStatus" type="string" required="yes" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="uttName">
    <cfset var rsUserTitleType = "" >
    <cftry>
    <cfquery name="rsUserTitleType" datasource="#application.mcmsDSN#">
    SELECT * FROM v_user_title_type WHERE 0=0
    <cfif ARGUMENTS.ID NEQ 0>
    AND ID = <cfqueryparam value="#ARGUMENTS.ID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.excludeID NEQ 0>
    AND ID <> <cfqueryparam value="#ARGUMENTS.excludeID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(uttName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(uttDescription) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">)
    </cfif>
    <cfif ARGUMENTS.uttName NEQ "">
    AND UPPER(uttName) = <cfqueryparam value="#UCASE(ARGUMENTS.uttName)#" cfsqltype="cf_sql_varchar">
    </cfif>
    AND uttStatus IN (<cfqueryparam value="#ARGUMENTS.uttStatus#" list="yes" cfsqltype="cf_sql_integer">)
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsUserTitleType = StructNew()>
    <cfset rsUserTitleType.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsUserTitleType>
    </cffunction>
    
    <cffunction name="getUserReport" access="public" returntype="query" hint="Get User Report data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="orderBy" type="string" required="yes" default="userLName">
	<cfset var rsUserReport = "" >
    <cftry>
    <cfquery name="rsUserReport" datasource="#application.mcmsDSN#">
    SELECT userLName || ' ' || userFName AS Name, userEmail AS Email, userTelephone AS Telephone,
    userMobile AS Mobile, TO_CHAR(userDateHistory, 'MM/DD/YYYY') AS Sign_In_History, TO_CHAR(userDateLast, 'MM/DD/YYYY') AS Last_Sign_In_Date, 
    urName AS Role_Name, utName AS Title, uttName AS Title_Type, sName AS Status FROM v_user 
    WHERE 0=0
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(userFName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> 
    OR UPPER(userLName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> 
    OR UPPER(userEmail) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">
    OR UPPER(urName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">
    )
    </cfif>
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsUserReport = StructNew()>
    <cfset rsUserReport.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsUserReport>
    </cffunction>
    
    <cffunction name="getUserExcelQuickReport" access="public" returntype="query" hint="Get User Excel Quick Report data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="userStatus" type="string" required="no" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="userLName, userFName, urName">
    <cfset var rsUserExcelQuickReport = "" >
    <cftry>
    <cfquery name="rsUserExcelQuickReport" datasource="#application.mcmsDSN#">
    SELECT userLName || ' ' || userFName AS Name, userEmail AS Email, userTelephone AS Telephone, userMobile AS Mobile, TO_CHAR(userDateHistory, 'MM/DD/YYYY') AS Sign_In_History, TO_CHAR(userDateLast, 'MM/DD/YYYY') AS Last_Sign_In_Date, urName AS Role_Name, utName AS Title, uttName AS Title_Type, sName AS Status FROM v_user 
    WHERE 0=0
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(userFName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> 
    OR UPPER(userLName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> 
    OR UPPER(userEmail) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">
    OR UPPER(urName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">
    )
    </cfif>
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsUserExcelQuickReport = StructNew()>
    <cfset rsUserExcelQuickReport.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsUserExcelQuickReport>
    </cffunction>
    
    <cffunction name="getUserTitleReport" access="public" returntype="query" hint="Get User Title Report data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="orderBy" type="string" required="yes" default="utName">
    <cfset var rsUserTitleReport = "" >
    <cftry>
    <cfquery name="rsUserTitleReport" datasource="#application.mcmsDSN#">
    SELECT utName AS Name, utDescription AS Description, uttName AS Title_Type, sortName AS Sort, sName AS Status FROM v_user_title WHERE 0=0
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(utName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(utDescription) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">)
    </cfif>
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsUserTitleReport = StructNew()>
    <cfset rsUserTitleReport.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsUserTitleReport>
    </cffunction>
    
    <cffunction name="getUserTitleTypeReport" access="public" returntype="query" hint="Get User Title Type Report data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="orderBy" type="string" required="yes" default="uttName">
    <cfset var rsUserTitleTypeReport = "" >
    <cftry>
    <cfquery name="rsUserTitleTypeReport" datasource="#application.mcmsDSN#">
    SELECT uttName AS Name, uttDescription AS Description, sortName AS Sort, sName AS Status FROM v_user_title_type WHERE 0=0
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(uttName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(uttDescription) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">)
    </cfif>
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsUserTitleTypeReport = StructNew()>
    <cfset rsUserTitleTypeReport.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsUserTitleTypeReport>
    </cffunction>
    
    <cffunction name="getUserRole" access="public" returntype="query" hint="Get User Role information to manage user access.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="ID" type="string" required="yes" default="0">
    <cfargument name="excludeID" type="numeric" required="yes" default="0">
    <cfargument name="urName" type="string" required="yes" default="">
    <cfargument name="urStatus" type="string" required="yes" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="urName">
	<cfset var rsUserRole = "" >
    <cftry>
    <cfquery name="rsUserRole" datasource="#application.mcmsDSN#">
    SELECT * FROM tbl_user_role WHERE 0=0
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(urName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> 
    OR UPPER(urDescription) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">)
    </cfif>
    <cfif  ARGUMENTS.ID NEQ 0>
    AND ID IN (<cfqueryparam value="#ARGUMENTS.ID#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    <cfif ARGUMENTS.excludeID NEQ 0>
    AND ID <> <cfqueryparam value="#ARGUMENTS.excludeID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.urName NEQ "">
    AND UPPER(urName) = <cfqueryparam value="#UCASE(ARGUMENTS.urName)#" cfsqltype="cf_sql_varchar">
    </cfif>
    AND urStatus IN (<cfqueryparam value="#ARGUMENTS.urStatus#" list="yes" cfsqltype="cf_sql_integer">)
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsUserRole = StructNew()>
    <cfset rsUserRole.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsUserRole>
    </cffunction>
    
    <cffunction name="getUserRoleReport" access="public" returntype="query" hint="Get User Role data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="orderBy" type="string" required="yes" default="urName">
	<cfset var rsUserRoleReport = "" >
    <cftry>
    <cfquery name="rsUserRoleReport" datasource="#application.mcmsDSN#">
    SELECT ID, urName AS Name, urDescription AS Description, urStatus AS Status FROM tbl_user_role WHERE 0=0
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(urName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> 
    OR UPPER(urDescription) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">)
    </cfif>
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsUserRoleReport = StructNew()>
    <cfset rsUserRoleReport.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsUserRoleReport>
    </cffunction>
    
    <cffunction name="getUserRoleAccess" access="public" returntype="query" hint="Get User Role access information to manage user access.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="ID" type="numeric" required="yes" default="0">
    <cfargument name="excludeID" type="numeric" required="yes" default="0">
    <cfargument name="urID" type="string" required="yes" default="0">
    <cfargument name="uaID" type="string" required="yes" default="0">
    <cfargument name="appID" type="numeric" required="yes" default="0">
    <cfargument name="uraStatus" type="string" required="yes" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="urName">
	<cfset var rsUserRoleAccess = "" >
    <cftry>
    <cfquery name="rsUserRoleAccess" datasource="#application.mcmsDSN#">
    SELECT * FROM v_user_role_access WHERE 0=0
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(urName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(uaName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(appName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">)
    </cfif>
    <cfif ARGUMENTS.ID NEQ 0>
    AND ID = <cfqueryparam value="#ARGUMENTS.ID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.excludeID NEQ 0>
    AND ID <> <cfqueryparam value="#ARGUMENTS.excludeID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.urID NEQ 0>
    AND urID IN (<cfqueryparam value="#ARGUMENTS.urID#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    <cfif ARGUMENTS.uaID NEQ 0>
    AND uaID IN (<cfqueryparam value="#ARGUMENTS.uaID#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    <cfif ARGUMENTS.appID NEQ 0>
    AND appID IN (<cfqueryparam value="0,#ARGUMENTS.appID#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    AND urStatus IN (<cfqueryparam value="#ARGUMENTS.uraStatus#" list="yes" cfsqltype="cf_sql_integer">)
    AND uaStatus IN (<cfqueryparam value="#ARGUMENTS.uraStatus#" list="yes" cfsqltype="cf_sql_integer">)
    AND appStatus IN (<cfqueryparam value="#ARGUMENTS.uraStatus#" list="yes" cfsqltype="cf_sql_integer">)
    AND uraStatus IN (<cfqueryparam value="#ARGUMENTS.uraStatus#" list="yes" cfsqltype="cf_sql_integer">)
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsUserRoleAccess = StructNew()>
    <cfset rsUserRoleAccess.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsUserRoleAccess>
    </cffunction>
    
    <cffunction name="getUserRoleImageTypeAccess" access="public" returntype="query" hint="Get User Role access information to manage user access.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="ID" type="numeric" required="yes" default="0">
    <cfargument name="excludeID" type="numeric" required="yes" default="0">
    <cfargument name="urID" type="numeric" required="yes" default="0">
    <cfargument name="imgtID" type="numeric" required="yes" default="0">
    <cfargument name="uritaStatus" type="string" required="yes" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="urName">
	<cfset var rsUserRoleImageTypeAccess = "" >
    <cftry>
    <cfquery name="rsUserRoleImageTypeAccess" datasource="#application.mcmsDSN#">
    SELECT * FROM v_ur_image_type_access WHERE 0=0
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(urName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(imgtName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">)
    </cfif>
    <cfif ARGUMENTS.ID NEQ 0>
    AND ID = <cfqueryparam value="#ARGUMENTS.ID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.excludeID NEQ 0>
    AND ID <> <cfqueryparam value="#ARGUMENTS.excludeID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.urID NEQ 0>
    AND urID = <cfqueryparam value="#ARGUMENTS.urID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.imgtID NEQ 0>
    AND imgtID = <cfqueryparam value="#ARGUMENTS.imgtID#" cfsqltype="cf_sql_integer">
    </cfif>
    AND urStatus IN (<cfqueryparam value="#ARGUMENTS.uritaStatus#" list="yes" cfsqltype="cf_sql_integer">)
    AND uritaStatus IN (<cfqueryparam value="#ARGUMENTS.uritaStatus#" list="yes" cfsqltype="cf_sql_integer">)
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsUserRoleImageTypeAccess = StructNew()>
    <cfset rsUserRoleImageTypeAccess.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsUserRoleImageTypeAccess>
    </cffunction>
    
    <cffunction name="getUserRoleAccessReport" access="public" returntype="query" hint="Get User Role access data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="orderBy" type="string" required="yes" default="urName">
	<cfset var rsUserRoleAccessReport = "" >
    <cftry>
    <cfquery name="rsUserRoleAccessReport" datasource="#application.mcmsDSN#">
    SELECT urName AS Name, uaName AS Access_Level, appName AS Application_Name, sName AS Status 
    FROM v_user_role_access WHERE 0=0
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(urName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(uaName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(appName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">)
    </cfif>
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsUserRoleAccessReport = StructNew()>
    <cfset rsUserRoleAccessReport.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsUserRoleAccessReport>
    </cffunction>
    
    <cffunction name="getUserRoleImageTypeAccessReport" access="public" returntype="query" hint="Get User Role Image Type access data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="orderBy" type="string" required="yes" default="urName">
	<cfset var rsUserRoleImageTypeAccessReport = "" >
    <cftry>
    <cfquery name="rsUserRoleImageTypeAccessReport" datasource="#application.mcmsDSN#">
    SELECT urName AS Name, imgtName AS Image_Type, sName AS Status 
    FROM v_ur_image_type_access WHERE 0=0
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(urName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(imgtName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">)
    </cfif>
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsUserRoleImageTypeAccessReport = StructNew()>
    <cfset rsUserRoleImageTypeAccessReport.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsUserRoleImageTypeAccessReport>
    </cffunction>
    
    <cffunction name="getUserAccess" access="public" returntype="query" hint="User Access for applications.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="ID" type="numeric" required="yes" default="0">
    <cfargument name="uaName" type="string" required="yes" default="">
    <cfargument name="uaStatus" type="string" required="yes" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="uaName">
	<cfset var rsUserAccess = "" >
    <cftry>
    <cfquery name="rsUserAccess" datasource="#application.mcmsDSN#">
    SELECT * FROM tbl_user_access WHERE 0=0
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(uaName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(uaDescription) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">)
    </cfif>
    <cfif ARGUMENTS.ID NEQ 0>
    AND ID = <cfqueryparam value="#ARGUMENTS.ID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.uaName NEQ ''>
    AND UPPER(uaName) = <cfqueryparam value="#UCASE(ARGUMENTS.uaName)#" cfsqltype="cf_sql_varchar">
    </cfif>
    AND uaStatus IN (<cfqueryparam value="#ARGUMENTS.uaStatus#" list="yes" cfsqltype="cf_sql_integer">)
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsUserAccess = StructNew()>
    <cfset rsUserAccess.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsUserAccess>
    </cffunction>
    
    <cffunction name="getUserRoleDocumentRel" access="public" returntype="query" hint="Get User Role Document relationships.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="ID" type="numeric" required="yes" default="0">
    <cfargument name="urID" type="numeric" required="yes" default="0">
    <cfargument name="docID" type="numeric" required="yes" default="0">
    <cfargument name="docName" type="string" required="yes" default="">
    <cfargument name="urdrStatus" type="string" required="yes" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="urID">
	<cfset var rsUserRoleDocumentRel = "" >
    <cftry>
    <cfquery name="rsUserRoleDocumentRel" datasource="#application.mcmsDSN#">
    SELECT * FROM tbl_user_role_document_rel WHERE 0=0
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(userFName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> 
    OR UPPER(userLName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> 
    OR UPPER(userEmail) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">)
    </cfif>
    <cfif ARGUMENTS.ID NEQ 0>
    AND ID = <cfqueryparam value="#ARGUMENTS.ID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.urID NEQ 0>
    AND urID IN (<cfqueryparam value="#ARGUMENTS.urID#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    <cfif ARGUMENTS.siteNo NEQ 100>
    AND siteNo IN (<cfqueryparam value="#ARGUMENTS.siteNo#" list="yes" cfsqltype="cf_sql_integer">)    
    </cfif>
    <cfif ARGUMENTS.userEmail NEQ "">
    AND UPPER(userEmail) = <cfqueryparam value="#UCASE(ARGUMENTS.userEmail)#" cfsqltype="cf_sql_varchar">
    </cfif>
    AND userStatus IN (<cfqueryparam value="#ARGUMENTS.userStatus#" list="yes" cfsqltype="cf_sql_integer">)
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsUserRoleDocumentRel = StructNew()>
    <cfset rsUserRoleDocumentRel.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsUserRoleDocumentRel>
    </cffunction>
    
    <cffunction name="getUserSecurityImageRel" access="public" returntype="query" hint="Get User Security Image Relationship data.">
    <cfargument name="ID" type="numeric" required="yes" default="0">
    <cfargument name="userID" type="numeric" required="yes" default="0">
    <cfargument name="userEmail" type="string" required="yes" default="">
    <cfargument name="siID" type="numeric" required="yes" default="0">
    <cfargument name="usirStatus" type="string" required="yes" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="ID">
	<cfset var rsUserSecurityImageRel = "" >
    <cftry>
    <cfquery name="rsUserSecurityImageRel" datasource="#application.mcmsDSN#">
    SELECT * FROM v_user_security_image_rel WHERE 0=0
    <cfif ARGUMENTS.ID NEQ 0>
    AND ID = <cfqueryparam value="#ARGUMENTS.ID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.userID NEQ 0>
    AND userID = <cfqueryparam value="#ARGUMENTS.userID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.userEmail NEQ "">
    AND UPPER(userEmail) = <cfqueryparam value="#UCASE(ARGUMENTS.userEmail)#" cfsqltype="cf_sql_varchar">
    </cfif>
    <cfif ARGUMENTS.siID NEQ 0>
    AND siID = <cfqueryparam value="#ARGUMENTS.siID#" cfsqltype="cf_sql_integer">
    </cfif>
    AND netID IN (<cfqueryparam value="#application.networkID#" list="yes" cfsqltype="cf_sql_integer">)
    AND usirStatus IN (<cfqueryparam value="#ARGUMENTS.usirStatus#" list="yes" cfsqltype="cf_sql_integer">)
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsUserSecurityImageRel = StructNew()>
    <cfset rsUserSecurityImageRel.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsUserSecurityImageRel>
    </cffunction>
    
    <cffunction name="getUserPasswordHintRel" access="public" returntype="query" hint="Get User Password Hint Relationship data.">
    <cfargument name="ID" type="numeric" required="yes" default="0">
    <cfargument name="userID" type="numeric" required="yes" default="0">
    <cfargument name="userEmail" type="string" required="yes" default="">
    <cfargument name="phAnswer" type="string" required="yes" default="">
    <cfargument name="phID" type="numeric" required="yes" default="0">
    <cfargument name="uphrStatus" type="string" required="yes" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="ID">
	<cfset var rsUserPasswordHintRel = "" >
    <cftry>
    <cfquery name="rsUserPasswordHintRel" datasource="#application.mcmsDSN#">
    SELECT * FROM v_user_password_hint_rel WHERE 0=0
    <cfif ARGUMENTS.ID NEQ 0>
    AND ID = <cfqueryparam value="#ARGUMENTS.ID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.userID NEQ 0>
    AND userID = <cfqueryparam value="#ARGUMENTS.userID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.userEmail NEQ "">
    AND UPPER(userEmail) = <cfqueryparam value="#UCASE(ARGUMENTS.userEmail)#" cfsqltype="cf_sql_varchar">
    </cfif>
    <cfif ARGUMENTS.phAnswer NEQ "">
    AND UPPER(phAnswer) = <cfqueryparam value="#UCASE(ARGUMENTS.phAnswer)#" cfsqltype="cf_sql_varchar">
    </cfif>
    <cfif ARGUMENTS.phID NEQ 0>
    AND phID = <cfqueryparam value="#ARGUMENTS.phID#" cfsqltype="cf_sql_integer">
    </cfif>
    AND uphrStatus IN (<cfqueryparam value="#ARGUMENTS.uphrStatus#" list="yes" cfsqltype="cf_sql_integer">)
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsUserPasswordHintRel = StructNew()>
    <cfset rsUserPasswordHintRel.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsUserPasswordHintRel>
    </cffunction>
    
    <cffunction name="getUserSecurityKeyRel" access="public" returntype="query" hint="Get User Security Key Relationship data.">
    <cfargument name="ID" type="numeric" required="yes" default="0">
    <cfargument name="userID" type="numeric" required="yes" default="0">
    <cfargument name="userEmail" type="string" required="yes" default="">
    <cfargument name="uskrKey" type="string" required="yes" default="">
    <cfargument name="uskrStatus" type="string" required="yes" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="ID">
	<cfset var rsUserSecurityKeyRel = "" >
    <cftry>
    <cfquery name="rsUserSecurityKeyRel" datasource="#application.mcmsDSN#">
    SELECT * FROM v_user_security_key_rel WHERE 0=0
    <cfif ARGUMENTS.ID NEQ 0>
    AND ID = <cfqueryparam value="#ARGUMENTS.ID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.userID NEQ 0>
    AND userID = <cfqueryparam value="#ARGUMENTS.userID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.userEmail NEQ "">
    AND UPPER(userEmail) = <cfqueryparam value="#UCASE(ARGUMENTS.userEmail)#" cfsqltype="cf_sql_varchar">
    </cfif>
    <cfif ARGUMENTS.uskrKey NEQ "">
    AND uskrKey = <cfqueryparam value="#ARGUMENTS.uskrKey#" cfsqltype="cf_sql_varchar">
    </cfif>
    AND uskrStatus IN (<cfqueryparam value="#ARGUMENTS.uskrStatus#" list="yes" cfsqltype="cf_sql_integer">)
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsUserSecurityKeyRel = StructNew()>
    <cfset rsUserSecurityKeyRel.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsUserSecurityKeyRel>
    </cffunction>
    
    <cffunction name="updateSignIn" access="public">
    <cfargument name="userDateHistory" type="date" required="yes">
    <cfargument name="userDateLast" type="date" required="yes">
    <cfargument name="userEmail" type="string" required="yes">
    <cfargument name="userPassword" type="string" required="yes" default="">
    <cfset result.message = "You have successfully updated the record.">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_user SET
    userDateHistory = <cfqueryparam cfsqltype="cf_sql_timestamp" value="#ARGUMENTS.userDateHistory#">,
    userDateLast = <cfqueryparam cfsqltype="cf_sql_timestamp" value="#ARGUMENTS.userDateLast#">,
    <!---Do not store AD passwords.--->
    <cfif ARGUMENTS.authenticationType EQ 'exchange' AND ARGUMENTS.userEmail DOES NOT CONTAIN "@">
    userPassword = <cfqueryparam cfsqltype="cf_sql_varchar" value="">
    <cfelse>
    userPassword = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.userPassword#">
    </cfif>
    WHERE UPPER(userEmail) = <cfqueryparam cfsqltype="cf_sql_varchar" value="#UCASE(ARGUMENTS.userEmail)#">
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error updating the record.">
    
    </cfcatch>
    </cftry>
    <cfreturn true>
    </cffunction>
    
    <cffunction name="insertUser" access="public" returntype="struct">
    <cfargument name="userFName" type="string" required="yes">
    <cfargument name="userLName" type="string" required="yes">
    <cfargument name="userEmail" type="string" required="yes">
    <cfargument name="userPassword" type="string" required="yes" default="#application.defaultUserPassword#">
    <cfargument name="userDescription" type="string" required="yes">
    <cfargument name="userTelephone" type="string" required="yes">
    <cfargument name="userMobile" type="string" required="yes">
    <cfargument name="imgID" type="numeric" required="yes">
    <cfargument name="urID" type="numeric" required="yes">
    <cfargument name="userStatus" type="numeric" required="yes">
    <!---Relationship arguments.--->
    <cfargument name="siteNo" type="string" required="yes">
    <cfargument name="deptNo" type="string" required="yes">
    <cfargument name="siID" type="numeric" required="yes">
    <cfargument name="phID" type="numeric" required="yes">
    <cfargument name="utID" type="numeric" required="yes">
    <cfargument name="phAnswer" type="string" required="yes">
    <cfset result.message = "You have successfully inserted the record.">
    <cftry>
    <!---Check for profanity in the text.--->
    <cfinvoke 
    component="MCMS.component.utility.Regex"
    method="regexProfanity"
    returnvariable="regexProfanityRet">
    <cfinvokeargument name="profanityString" value="#ARGUMENTS.userDescription#"/>
    </cfinvoke>
    <!---Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.cms.User"
    method="getUser"
    returnvariable="getCheckUserRet">
    <cfinvokeargument name="userEmail" value="#ARGUMENTS.userEmail#"/>
    <cfinvokeargument name="userStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckUserRet.recordcount NEQ 0>
    <cfset result.message = "The user with an email of #ARGUMENTS.userEmail# already exists, please enter a new email address.">
    <cfelseif regexProfanityRet CONTAINS '$%&*!'>
    <cfset result.message = "Some text contained profanity, please remove any profanity from your text.">
    <!---Check length restriction.--->
    <cfelseif LEN(ARGUMENTS.userDescription) GT 1024>
    <cfset result.message = "The description is longer than 1024 characters, please enter a new name under 1024 characters.">
    <cfelse>
    <!---If encryption is used and no value is present create it.--->
    <cfif application.defaultUserPassword NEQ ARGUMENTS.userPassword>
    <cfinvoke 
    component="MCMS.component.app.security.Security"
    method="setEcryption"
    returnvariable="setEcryptionRet">
    <cfinvokeargument name="value" value="#ARGUMENTS.userPassword#"/>
    <cfinvokeargument name="valuePair" value="lorem"/>
    </cfinvoke>
    <cfset ARGUMENTS.userPassword = setEcryptionRet.encryptKey>
    <cfinvoke 
    component="MCMS.component.cms.User"
    method="insertUserSecurityKeyRel"
    returnvariable="insertUserSecurityKeyRelRet">
    <cfinvokeargument name="userID" value="100"/>
    <cfinvokeargument name="uskrKey" value="#setEcryptionRet.encryptKey#"/>
    <cfinvokeargument name="uskrKeyValue" value="#setEcryptionRet.encryptKeyValue#"/>
    <cfinvokeargument name="uskrStatus" value="1"/>
    </cfinvoke>
    </cfif>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    INSERT INTO tbl_user (userFName,userLName,userEmail,userPassword,userDescription,userTelephone,userMobile,imgID,urID,utID,userStatus) VALUES
    (
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.userFName#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.userLName#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.userEmail#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.userPassword#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.userDescription#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.userTelephone#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.userMobile#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.imgID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.urID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.utID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.userStatus#">
    )
    </cfquery>
    </cftransaction>
    <!---Get the userID just added.--->
    <cfinvoke 
    component="MCMS.component.cms.User"
    method="getUser"
    returnvariable="getUserIDRet">
    <cfinvokeargument name="userEmail" value="#ARGUMENTS.userEmail#"/>
    <cfinvokeargument name="userStatus" value="1,2,3"/>
    </cfinvoke>
    <cfset this.userID = getUserIDRet.ID>
    <!---Create site relationships.--->
    <cfloop index="siteNo" list="#ARGUMENTS.siteNo#">
    <cfinvoke 
    component="MCMS.component.cms.User"
    method="insertUserSiteRel"
    returnvariable="insertUserSiteRelRet">
    <cfinvokeargument name="userID" value="#this.userID#"/>
    <cfinvokeargument name="siteNo" value="#siteNo#"/>
    <cfinvokeargument name="usrStatus" value="1"/>
    </cfinvoke>
    </cfloop>
    <!---Create department relationships.--->
    <cfloop index="deptNo" list="#ARGUMENTS.deptNo#">
    <cfinvoke 
    component="MCMS.component.cms.User"
    method="insertUserDepartmentRel"
    returnvariable="insertUserDepartmentRelRet">
    <cfinvokeargument name="userID" value="#this.userID#"/>
    <cfinvokeargument name="deptNo" value="#deptNo#"/>
    <cfinvokeargument name="udrStatus" value="1"/>
    </cfinvoke>
    </cfloop>
    <!---Insert Password Hint.--->
    <cfif ARGUMENTS.phID NEQ 0>
    <cfinvoke 
    component="MCMS.component.cms.User"
    method="insertUserPasswordHintRel"
    returnvariable="insertUserPasswordHintRelRet">
    <cfinvokeargument name="userID" value="#this.userID#"/>
    <cfinvokeargument name="phID" value="#ARGUMENTS.phID#"/>
    <cfinvokeargument name="phAnswer" value="#ARGUMENTS.phAnswer#"/>
    <cfinvokeargument name="uphrStatus" value="1"/>
    </cfinvoke>
    </cfif>
    <!---Insert Security Image.--->
    <cfinvoke 
    component="MCMS.component.cms.User"
    method="insertUserSecurityImageRel"
    returnvariable="insertUserSecurityImageRelRet">
    <cfinvokeargument name="userID" value="#this.userID#"/>
    <cfinvokeargument name="siID" value="#ARGUMENTS.siID#"/>
    <cfinvokeargument name="usirStatus" value="1"/>
    </cfinvoke>
    <!---Pass a status for the registration page..--->

    <cfset result.status = 'true'>
    <cfset result.ID = this.userID>
    </cfif>
    <cfcatch type="any">
    <cfset result.message = "There was an error inserting the record.">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="insertUserRole" access="public" returntype="struct">
    <cfargument name="urName" type="string" required="yes">
    <cfargument name="urDescription" type="string" required="yes">
    <cfargument name="urStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully inserted the record.">
    <cftry>
    <!---Check for profanity in the text.--->
    <cfinvoke 
    component="MCMS.component.utility.Regex"
    method="regexProfanity"
    returnvariable="regexProfanityRet">
    <cfinvokeargument name="profanityString" value="#ARGUMENTS.urDescription#"/>
    </cfinvoke>
    <!---Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.cms.User"
    method="getUserRole"
    returnvariable="getCheckUserRoleRet">
    <cfinvokeargument name="urName" value="#ARGUMENTS.urName#"/>
    <cfinvokeargument name="urStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckUserRoleRet.recordcount NEQ 0>
    <cfset result.message = "The name #ARGUMENTS.urName# already exists, please enter a new name.">
    <cfelseif regexProfanityRet CONTAINS '$%&*!'>
    <cfset result.message = "Some text contained profanity, please remove any profanity from your text.">
    <!---Check length restriction.--->
    <cfelseif LEN(ARGUMENTS.urDescription) GT 1024>
    <cfset result.message = "The description is longer than 1024 characters, please enter a new name under 1024 characters.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    INSERT INTO tbl_user_role (urName,urDescription,urStatus) VALUES
    (
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.urName#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.urDescription#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.urStatus#">
    )
    </cfquery>
    </cftransaction>
    </cfif>
    <cfcatch type="any">
    <cfset result.message = "There was an error inserting the record.">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="insertUserRoleAccess" access="public" returntype="struct">
    <cfargument name="urID" type="numeric" required="yes">
    <cfargument name="uaID" type="numeric" required="yes">
    <cfargument name="appID" type="numeric" required="yes">
    <cfargument name="uraStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully inserted the record.">
    <cftry>
    <!---Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.cms.User"
    method="getUserRoleAccess"
    returnvariable="getCheckUserRoleAccessRet">
    <cfinvokeargument name="urID" value="#ARGUMENTS.urID#"/>
    <cfinvokeargument name="appID" value="#ARGUMENTS.appID#"/>
    <cfinvokeargument name="uraStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckUserRoleAccessRet.recordcount NEQ 0>
    <cfset result.message = "A record already exists for the User Role and Application you have selected, please try again.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    INSERT INTO tbl_user_role_access (urID,uaID,appID,uraStatus) VALUES
    (
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.urID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.uaID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.appID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.uraStatus#">
    )
    </cfquery>
    </cftransaction>
    </cfif>
    <cfcatch type="any">
    <cfset result.message = "There was an error inserting the record.">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="insertUserRoleImageTypeAccess" access="public" returntype="struct">
    <cfargument name="urID" type="numeric" required="yes">
    <cfargument name="imgtID" type="numeric" required="yes">
    <cfargument name="uritaStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully inserted the record.">
    <cftry>
    <!---Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.cms.User"
    method="getUserRoleImageTypeAccess"
    returnvariable="getCheckUserRoleImageTypeAccessRet">
    <cfinvokeargument name="urID" value="#ARGUMENTS.urID#"/>
    <cfinvokeargument name="imgtID" value="#ARGUMENTS.imgtID#"/>
    <cfinvokeargument name="uritaStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckUserRoleImageTypeAccessRet.recordcount NEQ 0>
    <cfset result.message = "A record already exists for the User Role and Image Type you have selected, please try again.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    INSERT INTO tbl_ur_image_type_access (urID,imgtID,uritaStatus) VALUES
    (
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.urID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.imgtID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.uritaStatus#">
    )
    </cfquery>
    </cftransaction>
    </cfif>
    <cfcatch type="any">
    <cfset result.message = "There was an error inserting the record.">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="insertUserSiteRel" access="public" returntype="struct">
    <cfargument name="userID" type="numeric" required="yes">
    <cfargument name="siteNo" type="numeric" required="yes">
    <cfargument name="usrStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully inserted the record.">
    <cftry>
	<!---Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.cms.User"
    method="getUserSiteRel"
    returnvariable="getCheckUserSiteRelRet">
    <cfinvokeargument name="userID" value="#ARGUMENTS.userID#"/>
    <cfinvokeargument name="siteNo" value="#ARGUMENTS.siteNo#"/>
    <cfinvokeargument name="usrStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckUserSiteRelRet.recordcount NEQ 0>
    <cfset result.message = "The user site relationship already exists, please try again.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    INSERT INTO tbl_user_site_rel (userID,siteNo,usrStatus) VALUES
    (
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.userID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.siteNo#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.usrStatus#">
    )
    </cfquery>
    </cftransaction>
    </cfif>
    <cfcatch type="any">
    <cfset result.message = "There was an error inserting the record.">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="insertUserDepartmentRel" access="public" returntype="struct">
    <cfargument name="userID" type="numeric" required="yes">
    <cfargument name="deptNo" type="numeric" required="yes">
    <cfargument name="udrStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully inserted the record.">
    <cftry>
    <!---Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.cms.User"
    method="getUserDepartmentRel"
    returnvariable="getCheckUserDepartmentRelRet">
    <cfinvokeargument name="userID" value="#ARGUMENTS.userID#"/>
    <cfinvokeargument name="deptNo" value="#ARGUMENTS.deptNo#"/>
    <cfinvokeargument name="udrStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckUserDepartmentRelRet.recordcount NEQ 0>
    <cfset result.message = "The user department relationship already exists, please try again.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    INSERT INTO tbl_user_department_rel (userID,deptNo,udrStatus) VALUES
    (
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.userID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.deptNo#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.udrStatus#">
    )
    </cfquery>
    </cftransaction>
    </cfif>
    <cfcatch type="any">
    <cfset result.message = "There was an error inserting the record.">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="insertUserSecurityImageRel" access="public" returntype="struct">
    <cfargument name="userID" type="numeric" required="yes">
    <cfargument name="siID" type="numeric" required="yes">
    <cfargument name="usirStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully inserted the record.">
    <cftry>
	<!---Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.cms.User"
    method="getUserSecurityImageRel"
    returnvariable="getCheckUserSecurityImageRelRet">
    <cfinvokeargument name="userID" value="#ARGUMENTS.userID#"/>
    <cfinvokeargument name="siID" value="#ARGUMENTS.siID#"/>
    <cfinvokeargument name="usirStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckUserSecurityImageRelRet.recordcount NEQ 0>
    <cfset result.message = "The user security image relationship already exists, please try again.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    INSERT INTO tbl_user_security_image_rel (userID,siID,usirStatus) VALUES
    (
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.userID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.siID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.usirStatus#">
    )
    </cfquery>
    </cftransaction>
    </cfif>
    <cfcatch type="any">
    <cfset result.message = "There was an error inserting the record.">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="insertUserPasswordHintRel" access="public" returntype="struct">
    <cfargument name="userID" type="numeric" required="yes">
    <cfargument name="phID" type="numeric" required="yes">
    <cfargument name="phAnswer" type="string" required="yes">
    <cfargument name="uphrStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully inserted the record.">
    <cftry>
	<!---Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.cms.User"
    method="getUserPasswordHintRel"
    returnvariable="getCheckUserPasswordHintRelRet">
    <cfinvokeargument name="userID" value="#ARGUMENTS.userID#"/>
    <cfinvokeargument name="phID" value="#ARGUMENTS.phID#"/>
    <cfinvokeargument name="uphrStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckUserPasswordHintRelRet.recordcount NEQ 0>
    <cfset result.message = "The user password hint relationship already exists, please try again.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    INSERT INTO tbl_user_password_hint_rel (userID,phID,phAnswer,uphrStatus) VALUES
    (
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.userID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.phID#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.phAnswer#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.uphrStatus#">
    )
    </cfquery>
    </cftransaction>
    </cfif>
    <cfcatch type="any">
    <cfset result.message = "There was an error inserting the record.">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="insertUserSecurityKeyRel" access="public" returntype="struct">
    <cfargument name="userID" type="numeric" required="yes">
    <cfargument name="uskrKey" type="string" required="yes">
    <cfargument name="uskrKeyValue" type="string" required="yes">
    <cfargument name="uskrStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully inserted the record.">
    <cftry>
	<!---Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.cms.User"
    method="getUserSecurityKeyRel"
    returnvariable="getCheckUserSecurityKeyRelRet">
    <cfinvokeargument name="userID" value="#ARGUMENTS.userID#"/>
    <cfinvokeargument name="uskrStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckUserSecurityKeyRelRet.recordcount NEQ 0>
    <cfset result.message = "The user security key relationship already exists, please try again.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    INSERT INTO tbl_user_security_key_rel (userID,uskrKey,uskrKeyValue,uskrStatus) VALUES
    (
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.userID#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.uskrKey#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.uskrKeyValue#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.uskrStatus#">
    )
    </cfquery>
    </cftransaction>
    </cfif>
    <cfcatch type="any">
    <cfset result.message = "There was an error inserting the record.">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="insertUserImport" access="public" returntype="struct">
    <cfargument name="userFName" type="string" required="yes">
    <cfargument name="userLName" type="string" required="yes">
    <cfargument name="userEmail" type="string" required="yes">
    <cfargument name="userPassword" type="string" required="yes" default="#application.defaultUserPassword#">
    <cfargument name="userDescription" type="string" required="yes" default="">
    <cfargument name="userTelephone" type="string" required="yes" default="">
    <cfargument name="urID" type="numeric" required="yes">
    <!---Relationship arguments.--->
    <cfargument name="siteNo" type="string" required="yes">
    <cfargument name="deptNo" type="string" required="yes">
    <cfset result.message = "You have successfully inserted the record(s).">
    <cftry>
    <!---Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.cms.User"
    method="getUser"
    returnvariable="getCheckUserRet">
    <cfinvokeargument name="userEmail" value="#ARGUMENTS.userEmail#"/>
    <cfinvokeargument name="userStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckUserRet.recordcount EQ 0>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    INSERT INTO tbl_user (userFName,userLName,userEmail,userPassword,userDescription,userTelephone,urID) VALUES
    (
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.userFName#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.userLName#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.userEmail#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.userPassword#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.userDescription#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.userTelephone#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.urID#">
    )
    </cfquery>
    </cftransaction>
    <!---Get the userID just added.--->
    <cfinvoke 
    component="MCMS.component.cms.User"
    method="getUser"
    returnvariable="getUserIDRet">
    <cfinvokeargument name="userEmail" value="#ARGUMENTS.userEmail#"/>
    <cfinvokeargument name="userStatus" value="1,2,3"/>
    </cfinvoke>
    <cfset this.userID = getUserIDRet.ID>
    <!---Create site relationships.--->
    <cfloop index="siteNoList" list="#ARGUMENTS.siteNo#">
    <cfinvoke 
    component="MCMS.component.cms.User"
    method="insertUserSiteRel"
    returnvariable="insertUserSiteRelRet">
    <cfinvokeargument name="userID" value="#this.userID#"/>
    <cfinvokeargument name="siteNo" value="#siteNoList#"/>
    <cfinvokeargument name="usrStatus" value="1"/>
    </cfinvoke>
    </cfloop>
    <!---Create department relationships.--->
    <cfloop index="deptNoList" list="#ARGUMENTS.deptNo#">
    <cfinvoke 
    component="MCMS.component.cms.User"
    method="insertUserDepartmentRel"
    returnvariable="insertUserDepartmentRelRet">
    <cfinvokeargument name="userID" value="#this.userID#"/>
    <cfinvokeargument name="deptNo" value="#deptNoList#"/>
    <cfinvokeargument name="udrStatus" value="1"/>
    </cfinvoke>
    </cfloop>
    </cfif>
    <cfcatch type="any">
    <cfset result.message = "There was an error inserting the record(s).">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="insertUserTitle" access="public" returntype="struct">
    <cfargument name="utName" type="string" required="yes">
    <cfargument name="utDescription" type="string" required="yes">
    <cfargument name="uttID" type="numeric" required="yes">
    <cfargument name="utSort" type="numeric" required="yes">
    <cfargument name="utStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully inserted the record.">
    <cftry>
    <!---Check for profanity in the text.--->
    <cfinvoke 
    component="MCMS.component.utility.Regex"
    method="regexProfanity"
    returnvariable="regexProfanityRet">
    <cfinvokeargument name="profanityString" value="#ARGUMENTS.utDescription#"/>
    </cfinvoke>
    <!---Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.cms.User"
    method="getUserTitle"
    returnvariable="getCheckUserTitleRet">
    <cfinvokeargument name="utName" value="#ARGUMENTS.utName#"/>
    <cfinvokeargument name="utStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckUserTitleRet.recordcount NEQ 0>
    <cfset result.message = "The name #ARGUMENTS.utName# already exists, please enter a new name.">
    <cfelseif regexProfanityRet CONTAINS '$%&*!'>
    <cfset result.message = "Some text contained profanity, please remove any profanity from your text.">
    <!---Check length restriction.--->
    <cfelseif LEN(ARGUMENTS.utDescription) GT 512>
    <cfset result.message = "The description is longer than 512 characters, please enter a new description under 512 characters.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    INSERT INTO tbl_user_title (utName,utDescription,uttID,utSort,utStatus) VALUES
    (
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.utName#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.utDescription#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.uttID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.utSort#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.utStatus#">
    )
    </cfquery>
    </cftransaction>
    </cfif>
    <cfcatch type="any">
    <cfset result.message = "There was an error inserting the record.">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="insertUserTitleType" access="public" returntype="struct">
    <cfargument name="uttName" type="string" required="yes">
    <cfargument name="uttDescription" type="string" required="yes">
    <cfargument name="uttSort" type="numeric" required="yes">
    <cfargument name="uttStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully inserted the record.">
    <cftry>
    <!---Check for profanity in the text.--->
    <cfinvoke 
    component="MCMS.component.utility.Regex"
    method="regexProfanity"
    returnvariable="regexProfanityRet">
    <cfinvokeargument name="profanityString" value="#ARGUMENTS.uttDescription#"/>
    </cfinvoke>
    <!---Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.cms.User"
    method="getUserTitleType"
    returnvariable="getCheckUserTitleTypeRet">
    <cfinvokeargument name="uttName" value="#ARGUMENTS.uttName#"/>
    <cfinvokeargument name="uttStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckUserTitleTypeRet.recordcount NEQ 0>
    <cfset result.message = "The name #ARGUMENTS.uttName# already exists, please enter a new name.">
    <cfelseif regexProfanityRet CONTAINS '$%&*!'>
    <cfset result.message = "Some text contained profanity, please remove any profanity from your text.">
    <!---Check length restriction.--->
    <cfelseif LEN(ARGUMENTS.uttDescription) GT 512>
    <cfset result.message = "The description is longer than 512 characters, please enter a new description under 512 characters.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    INSERT INTO tbl_user_title_type (uttName,uttDescription,uttSort,uttStatus) VALUES
    (
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.uttName#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.uttDescription#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.uttSort#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.uttStatus#">
    )
    </cfquery>
    </cftransaction>
    </cfif>
    <cfcatch type="any">
    <cfset result.message = "There was an error inserting the record.">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="updateUser" access="public" returntype="struct">
    <cfargument name="ID" type="numeric" required="yes">
    <cfargument name="userFName" type="string" required="yes">
    <cfargument name="userLName" type="string" required="yes">
    <cfargument name="userEmail" type="string" required="yes">
    <cfargument name="userPassword" type="string" required="yes" default="#application.defaultUserPassword#">
    <cfargument name="userDescription" type="string" required="yes">
    <cfargument name="userTelephone" type="string" required="yes">
    <cfargument name="userMobile" type="string" required="yes">
    <cfargument name="imgID" type="numeric" required="yes">
    <cfargument name="urID" type="numeric" required="yes">
    <cfargument name="userStatus" type="numeric" required="yes">
    <!---Relationship arguments.--->
    <cfargument name="siteNo" type="string" required="yes" default="0">
    <cfargument name="deptNo" type="string" required="yes" default="99">
    <cfargument name="siID" type="numeric" required="yes">
    <cfargument name="phID" type="numeric" required="yes">
    <cfargument name="utID" type="numeric" required="yes">
    <cfargument name="phAnswer" type="string" required="yes">
    <cfset result.message = "You have successfully updated the record.">
	<cftry>  
    <!--- Check for profanity in the text.--->
    <cfinvoke 
    component="MCMS.component.utility.Regex"
    method="regexProfanity"
    returnvariable="regexProfanityRet">
    <cfinvokeargument name="profanityString" value="#ARGUMENTS.userDescription#"/>
    </cfinvoke>
    <!---Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.cms.User"
    method="getUser"
    returnvariable="getCheckUserRet">
    <cfinvokeargument name="excludeID" value="#ARGUMENTS.ID#"/>
    <cfinvokeargument name="userEmail" value="#ARGUMENTS.userEmail#"/>
    <cfinvokeargument name="userStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckUserRet.recordcount NEQ 0>
    <cfset result.message = "The user with an email of #ARGUMENTS.userEmail# already exists, please enter a new email address.">
    <cfelseif regexProfanityRet CONTAINS '$%&*!'>
    <cfset result.message = "Some text contained profanity, please remove any profanity from your text.">
    <!---Check length restriction.--->
    <cfelseif LEN(ARGUMENTS.userDescription) GT 1024>
    <cfset result.message = "The description is longer than 1024 characters, please enter a new name under 1024 characters.">
    <cfelse>
    <!---If encryption is used and no value is present create it.--->
    <cfif application.defaultUserPassword NEQ ARGUMENTS.userPassword>
    <cfinvoke 
    component="MCMS.component.app.security.Security"
    method="setEcryption"
    returnvariable="setEcryptionRet">
    <cfinvokeargument name="value" value="#ARGUMENTS.userPassword#"/>
    <cfinvokeargument name="valuePair" value="lorem"/>
    </cfinvoke>
    <cfset ARGUMENTS.userPassword = setEcryptionRet.encryptKey>
    <cfinvoke 
    component="MCMS.component.cms.User"
    method="insertUserSecurityKeyRel"
    returnvariable="insertUserSecurityKeyRelRet">
    <cfinvokeargument name="userID" value="#ARGUMENTS.ID#"/>
    <cfinvokeargument name="uskrKey" value="#setEcryptionRet.encryptKey#"/>
    <cfinvokeargument name="uskrKeyValue" value="#setEcryptionRet.encryptKeyValue#"/>
    <cfinvokeargument name="uskrStatus" value="1"/>
    </cfinvoke>
	</cfif>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_user SET
    userFName = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.userFName#">,
    userLName = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.userLName#">,
    userEmail = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.userEmail#">,
    userPassword = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.userPassword#">,
    userDescription = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.userDescription#">,
    userTelephone = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.userTelephone#">,
    userMobile = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.userMobile#">,
    imgID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.imgID#">,
    urID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.urID#">,
    utID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.utID#">,
    userStatus = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.userStatus#">
    WHERE ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ID#">
    </cfquery>
    </cftransaction>
    <!---Delete any existing relationships.--->
    <cfif ARGUMENTS.siteNo NEQ 0>
    <cfinvoke 
    component="MCMS.component.cms.User"
    method="deleteUserSiteRel"
    returnvariable="deleteUserSiteRelRet">
    <cfinvokeargument name="userID" value="#ARGUMENTS.ID#"/>
    </cfinvoke>
    </cfif>
    <cfif ARGUMENTS.deptNo NEQ 99>
    <cfinvoke 
    component="MCMS.component.cms.User"
    method="deleteUserDepartmentRel"
    returnvariable="deleteUserDepartmentRelRet">
    <cfinvokeargument name="userID" value="#ARGUMENTS.ID#"/>
    </cfinvoke>
    </cfif>
    <cfinvoke 
    component="MCMS.component.cms.User"
    method="deleteUserPasswordHintRel"
    returnvariable="deleteUserPasswordHintRelRet">
    <cfinvokeargument name="userID" value="#ARGUMENTS.ID#"/>
    </cfinvoke>
    <cfinvoke 
    component="MCMS.component.cms.User"
    method="deleteUserSecurityImageRel"
    returnvariable="deleteUserSecurityImageRelRet">
    <cfinvokeargument name="userID" value="#ARGUMENTS.ID#"/>
    </cfinvoke>
    <!---Create site relationships.--->
    <cfif ARGUMENTS.siteNo NEQ 0>
    <cfloop index="siteNo" list="#ARGUMENTS.siteNo#">
    <cfinvoke 
    component="MCMS.component.cms.User"
    method="insertUserSiteRel"
    returnvariable="insertUserSiteRelRet">
    <cfinvokeargument name="userID" value="#ARGUMENTS.ID#"/>
    <cfinvokeargument name="siteNo" value="#siteNo#"/>
    <cfinvokeargument name="usrStatus" value="1"/>
    </cfinvoke>
    </cfloop>
    </cfif>
    <!---Create department relationships.--->
    <cfif ARGUMENTS.deptNo NEQ 99>
    <cfloop index="deptNo" list="#ARGUMENTS.deptNo#">
    <cfinvoke 
    component="MCMS.component.cms.User"
    method="insertUserDepartmentRel"
    returnvariable="insertUserDepartmentRelRet">
    <cfinvokeargument name="userID" value="#ARGUMENTS.ID#"/>
    <cfinvokeargument name="deptNo" value="#deptNo#"/>
    <cfinvokeargument name="udrStatus" value="1"/>
    </cfinvoke>
    </cfloop>
    </cfif>
    <!---Insert Password Hint.--->
    <cfinvoke 
    component="MCMS.component.cms.User"
    method="insertUserPasswordHintRel"
    returnvariable="insertUserPasswordHintRelRet">
    <cfinvokeargument name="userID" value="#ARGUMENTS.ID#"/>
    <cfinvokeargument name="phID" value="#ARGUMENTS.phID#"/>
    <cfinvokeargument name="phAnswer" value="#ARGUMENTS.phAnswer#"/>
    <cfinvokeargument name="uphrStatus" value="1"/>
    </cfinvoke>
    <!---Insert Security Image.--->
    <cfinvoke 
    component="MCMS.component.cms.User"
    method="insertUserSecurityImageRel"
    returnvariable="insertUserSecurityImageRelRet">
    <cfinvokeargument name="userID" value="#ARGUMENTS.ID#"/>
    <cfinvokeargument name="siID" value="#ARGUMENTS.siID#"/>
    <cfinvokeargument name="usirStatus" value="1"/>
    </cfinvoke>
    </cfif>
    <cfcatch type="any">
    <cfset result.message = "There was an error updating the record.">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="updateUserRole" access="public" returntype="struct">
    <cfargument name="ID" type="numeric" required="yes">
    <cfargument name="urName" type="string" required="yes">
    <cfargument name="urDescription" type="string" required="yes">
    <cfargument name="urStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully updated the record.">
	<cftry>   
    <!--- Check for profanity in the text.--->
    <cfinvoke 
    component="MCMS.component.utility.Regex"
    method="regexProfanity"
    returnvariable="regexProfanityRet">
    <cfinvokeargument name="profanityString" value="#ARGUMENTS.urDescription#"/>
    </cfinvoke>
    <!---Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.cms.User"
    method="getUserRole"
    returnvariable="getCheckUserRoleRet">
    <cfinvokeargument name="excludeID" value="#ARGUMENTS.ID#"/>
    <cfinvokeargument name="urName" value="#ARGUMENTS.urName#"/>
    <cfinvokeargument name="urStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckUserRoleRet.recordcount NEQ 0>
    <cfset result.message = "The name #ARGUMENTS.urName# already exists, please enter a new name.">
    <cfelseif regexProfanityRet CONTAINS '$%&*!'>
    <cfset result.message = "Some text contained profanity, please remove any profanity from your text.">
    <!---Check length restriction.--->
    <cfelseif LEN(ARGUMENTS.urDescription) GT 1024>
    <cfset result.message = "The description is longer than 1024 characters, please enter a new name under 1024 characters.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_user_role SET
    urName = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.urName#">,
    urDescription = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.urDescription#">,
    urStatus = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.urStatus#">
    WHERE ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ID#">
    </cfquery>
    </cftransaction>
    </cfif>
    <cfcatch type="any">
    <cfset result.message = "There was an error updating the record.">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="updateUserRoleAccess" access="public" returntype="struct">
    <cfargument name="ID" type="numeric" required="yes">
    <cfargument name="urID" type="numeric" required="yes">
    <cfargument name="uaID" type="numeric" required="yes">
    <cfargument name="appID" type="numeric" required="yes">
    <cfargument name="uraStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully updated the record.">
	<cftry>   
    <!---Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.cms.User"
    method="getUserRoleAccess"
    returnvariable="getCheckUserRoleAccessRet">
    <cfinvokeargument name="excludeID" value="#ARGUMENTS.ID#"/>
    <cfinvokeargument name="urID" value="#ARGUMENTS.urID#"/>
    <cfinvokeargument name="appID" value="#ARGUMENTS.appID#"/>
    <cfinvokeargument name="uraStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckUserRoleAccessRet.recordcount NEQ 0>
    <cfset result.message = "A record already exists for the User Role and Application you have selected, please try again.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_user_role_access SET
    urID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.urID#">,
    uaID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.uaID#">,
    appID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.appID#">,
    uraStatus = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.uraStatus#">
    WHERE ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ID#">
    </cfquery>
    </cftransaction>
    </cfif>
    <cfcatch type="any">
    <cfset result.message = "There was an error updating the record.">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="updateUserRoleImageTypeAccess" access="public" returntype="struct">
    <cfargument name="ID" type="numeric" required="yes">
    <cfargument name="urID" type="numeric" required="yes">
    <cfargument name="imgtID" type="numeric" required="yes">
    <cfargument name="uritaStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully updated the record.">
	<cftry>   
    <!---Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.cms.User"
    method="getUserRoleImageTypeAccess"
    returnvariable="getCheckUserRoleImageTypeAccessRet">
    <cfinvokeargument name="excludeID" value="#ARGUMENTS.ID#"/>
    <cfinvokeargument name="urID" value="#ARGUMENTS.urID#"/>
    <cfinvokeargument name="imgtID" value="#ARGUMENTS.imgtID#"/>
    <cfinvokeargument name="uritaStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckUserRoleImageTypeAccessRet.recordcount NEQ 0>
    <cfset result.message = "A record already exists for the User Role and Image Type you have selected, please try again.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_ur_image_type_access SET
    urID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.urID#">,
    imgtID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.imgtID#">,
    uritaStatus = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.uritaStatus#">
    WHERE ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ID#">
    </cfquery>
    </cftransaction>
    </cfif>
    <cfcatch type="any">
    <cfset result.message = "There was an error updating the record.">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="updateUserTitle" access="public" returntype="struct">
    <cfargument name="ID" type="numeric" required="yes">
    <cfargument name="utName" type="string" required="yes">
    <cfargument name="utDescription" type="string" required="yes">
    <cfargument name="uttID" type="numeric" required="yes">
    <cfargument name="utSort" type="numeric" required="yes">
    <cfargument name="utStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully updated the record.">
    <cftry>
    <!---Check for profanity in the text.--->
    <cfinvoke 
    component="MCMS.component.utility.Regex"
    method="regexProfanity"
    returnvariable="regexProfanityRet">
    <cfinvokeargument name="profanityString" value="#ARGUMENTS.utDescription#"/>
    </cfinvoke>
    <!---Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.cms.User"
    method="getUserTitle"
    returnvariable="getCheckUserTitleRet">
    <cfinvokeargument name="excludeID" value="#ARGUMENTS.ID#"/>
    <cfinvokeargument name="utName" value="#ARGUMENTS.utName#"/>
    <cfinvokeargument name="utStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckUserTitleRet.recordcount NEQ 0>
    <cfset result.message = "The name #ARGUMENTS.utName# already exists, please enter a new name.">
    <cfelseif regexProfanityRet CONTAINS '$%&*!'>
    <cfset result.message = "Some text contained profanity, please remove any profanity from your text.">
    <!---Check length restriction.--->
    <cfelseif LEN(ARGUMENTS.utDescription) GT 512>
    <cfset result.message = "The description is longer than 512 characters, please enter a new description under 512 characters.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_user_title SET
    utName = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.utName#">,
    utDescription = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.utDescription#">,
    uttID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.uttID#">,
    utSort = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.utSort#">,
    utStatus = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.utStatus#">
    WHERE ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ID#">
    </cfquery>
    </cftransaction>
    </cfif>
    <cfcatch type="any">
    <cfset result.message = "There was an error updating the record.">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="updateUserTitleType" access="public" returntype="struct">
    <cfargument name="ID" type="numeric" required="yes">
    <cfargument name="uttName" type="string" required="yes">
    <cfargument name="uttDescription" type="string" required="yes">
    <cfargument name="uttSort" type="numeric" required="yes">
    <cfargument name="uttStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully updated the record.">
    <cftry>
    <!---Check for profanity in the text.--->
    <cfinvoke 
    component="MCMS.component.utility.Regex"
    method="regexProfanity"
    returnvariable="regexProfanityRet">
    <cfinvokeargument name="profanityString" value="#ARGUMENTS.uttDescription#"/>
    </cfinvoke>
    <!---Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.cms.User"
    method="getUserTitleType"
    returnvariable="getCheckUserTitleTypeRet">
    <cfinvokeargument name="excludeID" value="#ARGUMENTS.ID#"/>
    <cfinvokeargument name="uttName" value="#ARGUMENTS.uttName#"/>
    <cfinvokeargument name="uttStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckUserTitleTypeRet.recordcount NEQ 0>
    <cfset result.message = "The name #ARGUMENTS.uttName# already exists, please enter a new name.">
    <cfelseif regexProfanityRet CONTAINS '$%&*!'>
    <cfset result.message = "Some text contained profanity, please remove any profanity from your text.">
    <!---Check length restriction.--->
    <cfelseif LEN(ARGUMENTS.uttDescription) GT 512>
    <cfset result.message = "The description is longer than 512 characters, please enter a new description under 512 characters.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_user_title_type SET
    uttName = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.uttName#">,
    uttDescription = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.uttDescription#">,
    uttSort = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.uttSort#">,
    uttStatus = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.uttStatus#">
    WHERE ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ID#">
    </cfquery>
    </cftransaction>
    </cfif>
    <cfcatch type="any">
    <cfset result.message = "There was an error updating the record.">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="updateUserList" access="public" returntype="struct">
    <cfargument name="ID" type="numeric" required="yes">
    <cfargument name="userStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully updated the records.">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_user SET
    userStatus = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.userStatus#">
    WHERE ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ID#">
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error updating the records.">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="updateUserRoleList" access="public" returntype="struct">
    <cfargument name="ID" type="numeric" required="yes">
    <cfargument name="urStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully updated the records.">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_user_role SET
    urStatus = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.urStatus#">
    WHERE ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ID#">
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error updating the records.">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="updateUserRoleAccessList" access="public" returntype="struct">
    <cfargument name="ID" type="numeric" required="yes">
    <cfargument name="uraStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully updated the records.">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_user_role_access SET
    uraStatus = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.uraStatus#">
    WHERE ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ID#">
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error updating the records.">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="updateUserRoleImageTypeAccessList" access="public" returntype="struct">
    <cfargument name="ID" type="numeric" required="yes">
    <cfargument name="uritaStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully updated the records.">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_ur_image_type_access SET
    uritaStatus = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.uritaStatus#">
    WHERE ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ID#">
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error updating the records.">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="updateUserTitleList" access="public" returntype="struct">
    <cfargument name="ID" type="numeric" required="yes">
    <cfargument name="utStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully updated the records.">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_user_title SET
    utStatus = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.utStatus#">
    WHERE ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ID#">
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error updating the records.">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="updateUserTitleTypeList" access="public" returntype="struct">
    <cfargument name="ID" type="numeric" required="yes">
    <cfargument name="uttStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully updated the records.">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_user_title_type SET
    uttStatus = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.uttStatus#">
    WHERE ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ID#">
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error updating the records.">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="deleteUser" access="public" returntype="struct">
    <cfargument name="ID" type="string" required="yes">
    <cfset result.message = "You have successfully deleted the record(s).">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    DELETE FROM tbl_user
    WHERE ID IN (<cfqueryparam cfsqltype="cf_sql_integer" list="yes" value="#ARGUMENTS.ID#">)
    </cfquery>
    </cftransaction>
    <cfinvoke 
    component="MCMS.component.cms.User"
    method="deleteUserSiteRel"
    returnvariable="deleteUserSiteRelRet">
    <cfinvokeargument name="userID" value="#ARGUMENTS.ID#"/>
    </cfinvoke>
    <cfinvoke 
    component="MCMS.component.cms.User"
    method="deleteUserDepartmentRel"
    returnvariable="deleteUserDepartmentRelRet">
    <cfinvokeargument name="userID" value="#ARGUMENTS.ID#"/>
    </cfinvoke>
    <cfinvoke 
    component="MCMS.component.cms.User"
    method="deleteUserPasswordHintRel"
    returnvariable="deleteUserPasswordHintRelRet">
    <cfinvokeargument name="userID" value="#ARGUMENTS.ID#"/>
    </cfinvoke>
    <cfinvoke 
    component="MCMS.component.cms.User"
    method="deleteUserSecurityImageRel"
    returnvariable="deleteUserSecurityImageRelRet">
    <cfinvokeargument name="userID" value="#ARGUMENTS.ID#"/>
    </cfinvoke>
    <cfcatch type="any">
    <cfset result.message = "There was an error deleting the record(s).">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="deleteUserRole" access="public" returntype="struct">
    <cfargument name="ID" type="string" required="yes">
    <cfset result.message = "You have successfully deleted the record(s).">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    DELETE FROM tbl_user_role
    WHERE ID IN (<cfqueryparam cfsqltype="cf_sql_integer" list="yes" value="#ARGUMENTS.ID#">)
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error deleting the record(s).">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="deleteUserRoleAccess" access="public" returntype="struct">
    <cfargument name="ID" type="string" required="yes">
    <cfset result.message = "You have successfully deleted the record(s).">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    DELETE FROM tbl_user_role_access
    WHERE ID IN (<cfqueryparam cfsqltype="cf_sql_integer" list="yes" value="#ARGUMENTS.ID#">)
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error deleting the record(s).">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="deleteUserRoleImageTypeAccess" access="public" returntype="struct">
    <cfargument name="ID" type="string" required="yes">
    <cfset result.message = "You have successfully deleted the record(s).">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    DELETE FROM tbl_ur_image_type_access
    WHERE ID IN (<cfqueryparam cfsqltype="cf_sql_integer" list="yes" value="#ARGUMENTS.ID#">)
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error deleting the record(s).">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="deleteUserSiteRel" access="public" returntype="struct">
    <cfargument name="ID" type="string" required="yes" default="0">
    <cfargument name="userID" type="string" required="yes" default="0">
    <cfset result.message = "You have successfully deleted the record(s).">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    DELETE FROM tbl_user_site_rel
    WHERE ID IN (<cfqueryparam cfsqltype="cf_sql_integer" list="yes" value="#ARGUMENTS.ID#">)
    OR userID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.userID#">
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error deleting the record(s).">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="deleteUserDepartmentRel" access="public" returntype="struct">
    <cfargument name="ID" type="string" required="yes" default="0">
    <cfargument name="userID" type="string" required="yes" default="0">
    <cfset result.message = "You have successfully deleted the record(s).">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    DELETE FROM tbl_user_department_rel
    WHERE ID IN (<cfqueryparam cfsqltype="cf_sql_integer" list="yes" value="#ARGUMENTS.ID#">)
    OR userID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.userID#">
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error deleting the record(s).">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction> 
    
    <cffunction name="deleteUserSecurityImageRel" access="public" returntype="struct">
    <cfargument name="ID" type="string" required="yes" default="0">
    <cfargument name="userID" type="string" required="yes" default="0">
    <cfset result.message = "You have successfully deleted the record(s).">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    DELETE FROM tbl_user_security_image_rel
    WHERE ID IN (<cfqueryparam cfsqltype="cf_sql_integer" list="yes" value="#ARGUMENTS.ID#">)
    OR userID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.userID#">
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error deleting the record(s).">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction> 
    
    <cffunction name="deleteUserPasswordHintRel" access="public" returntype="struct">
    <cfargument name="ID" type="string" required="yes" default="0">
    <cfargument name="userID" type="string" required="yes" default="0">
    <cfset result.message = "You have successfully deleted the record(s).">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    DELETE FROM tbl_user_password_hint_rel
    WHERE ID IN (<cfqueryparam cfsqltype="cf_sql_integer" list="yes" value="#ARGUMENTS.ID#">)
    OR userID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.userID#">
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error deleting the record(s).">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="deleteUserTitle" access="public" returntype="struct">
    <cfargument name="ID" type="string" required="yes">
    <cfset result.message = "You have successfully deleted the record(s).">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    DELETE FROM tbl_user_title
    WHERE ID IN (<cfqueryparam cfsqltype="cf_sql_integer" list="yes" value="#ARGUMENTS.ID#">)
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error deleting the record(s).">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>   
    
    <cffunction name="deleteUserTitleType" access="public" returntype="struct">
    <cfargument name="ID" type="string" required="yes">
    <cfset result.message = "You have successfully deleted the record(s).">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    DELETE FROM tbl_user_title_type
    WHERE ID IN (<cfqueryparam cfsqltype="cf_sql_integer" list="yes" value="#ARGUMENTS.ID#">)
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error deleting the record(s).">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>      
 </cfcomponent>