<cfcomponent>
    <cffunction name="getWebService" access="public" returntype="query" hint="Get Web Service data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="ID" type="string" required="yes" default="0">
    <cfargument name="excludeID" type="string" required="yes" default="0">
    <cfargument name="wsID" type="string" required="yes" default="">
    <cfargument name="wsName" type="string" required="yes" default="">
    <cfargument name="netID" type="string" required="yes" default="0,#application.networkID#">
    <cfargument name="wsStatus" type="string" required="yes" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="wsName">
    <cfset var rsWebService = "" >
    <cftry>
    <cfquery name="rsWebService" datasource="#application.mcmsDSN#">
    SELECT * FROM swweb.v_web_service WHERE 0=0
    <cfif ARGUMENTS.ID NEQ 0>
    AND ID IN (<cfqueryparam value="#ARGUMENTS.ID#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    <cfif ARGUMENTS.excludeID NEQ 0>
    AND ID NOT IN (<cfqueryparam value="#ARGUMENTS.excludeID#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(wsName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(wsDescription) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">)
    </cfif>
    <cfif ARGUMENTS.wsName NEQ "">
    AND UPPER(wsName) = <cfqueryparam value="#UCASE(ARGUMENTS.wsName)#" cfsqltype="cf_sql_varchar">
    </cfif>
    <cfif ARGUMENTS.wsID NEQ "">
    AND wsID = <cfqueryparam value="#ARGUMENTS.wsID#" cfsqltype="cf_sql_varchar">
    </cfif>
    <cfif ARGUMENTS.netID NEQ "">
    AND netID IN (<cfqueryparam value="#ARGUMENTS.netID#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    AND wsStatus IN (<cfqueryparam value="#ARGUMENTS.wsStatus#" list="yes" cfsqltype="cf_sql_integer">)
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsWebService = StructNew()>
    <cfset rsWebService.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsWebService>
    </cffunction>
    
    <cffunction name="getWebServiceData" access="public" returntype="any" hint="Get Web Service data.">
    <cfargument name="wsID" type="string" required="yes" default="">
    <cfargument name="wsurToken" type="string" required="yes" default="">
    <cfargument name="wsfID" type="numeric" required="yes" default="0">
    <cfargument name="args" type="string" required="yes" default="">
    <cfset var rsWebServiceData = StructNew()>
    <cfset rsWebServiceData.message = "">
    <cftry>
    <!--- Check to make sure URL params were passed. --->
    <cfif ARGUMENTS.wsID EQ "">
    <cfset rsWebServiceData.message = "Error: wsID must be passed in the url.">
    <cfelseif ARGUMENTS.wsurToken EQ "">
    <cfset rsWebServiceData.message = "Error: wsurToken must be passed in the url.">
    <cfelse>
    <cfinvoke 
    component="MCMS.component.app.web_service.WebService"
    method="getWebService"
    returnvariable="getWebServiceRet">
    <cfinvokeargument name="wsID" value="#ARGUMENTS.wsID#"/>
    <cfinvokeargument name="netID" value="#application.networkID#"/>
    <cfinvokeargument name="wsStatus" value="1"/>
    </cfinvoke>
    <!--- Check to make sure web service exists. --->
    <cfif getWebServiceRet.RecordCount EQ 0>
    <cfset rsWebServiceData.message = "Error: No web service exists for wsID: [#ARGUMENTS.wsID#].">
    <cfelse>
    <cfset this.ID = getWebServiceRet.ID>
    <cfset this.component = getWebServiceRet.wsComponent>
    <cfset this.method = getWebServiceRet.wsMethod>
    <cfset this.sqlvID = getWebServiceRet.sqlvID>
    <cfset this.sqlvName = getWebServiceRet.sqlvName>
    <cfset this.wsDateModified = getWebServiceRet.wsDateModified>
    <!--- Authenticate web service user. --->
    <cfinvoke 
    component="MCMS.component.app.web_service.WebService"
    method="getWebServiceUserRel"
    returnvariable="getWebServiceUserRelRet">
    <cfinvokeargument name="wsID" value="#this.ID#"/>
    <cfinvokeargument name="wsurToken" value="#ARGUMENTS.wsurToken#"/>
    <cfinvokeargument name="wsurDateExp" value="#DateFormat(Now(),application.dateFormat)#"/>
    <cfinvokeargument name="wsStatus" value="1"/>
    <cfinvokeargument name="wsuStatus" value="1"/>
    <cfinvokeargument name="wsurStatus" value="1"/>
    <cfinvokeargument name="orderBy" value="wsName"/>
    </cfinvoke>
    <cfset this.wsuID = getWebServiceUserRelRet.wsuID>
    <cfinvoke 
    component="MCMS.component.app.web_service.WebService"
    method="getWebServiceLog"
    returnvariable="getWebServiceLogRet">
    <cfinvokeargument name="wsID" value="#this.ID#"/>
    <cfinvokeargument name="wsuID" value="#this.wsuID#"/>
    <cfinvokeargument name="wslStatus" value="1"/>
    </cfinvoke>
    <cfinvoke 
    component="MCMS.component.app.web_service.WebService"
    method="getWebServiceFormatRel"
    returnvariable="getWebServiceFormatRelRet">
    <cfinvokeargument name="wsID" value="#this.ID#"/>
    <cfinvokeargument name="wsStatus" value="1"/>
    <cfinvokeargument name="wsfStatus" value="1"/>
    </cfinvoke>
    
    <cfset wsfIDList = ValueList(getWebServiceFormatRelRet.wsfID)> 
       
    <cfset this.wslDate = getWebServiceLogRet.wslDate>
    
    <!--- Check to make sure token matches and the web service user rel has not expired. --->
    <cfif getWebServiceUserRelRet.recordcount EQ 0>
    <cfset rsWebServiceData.message = "Error: URL attribute [#ARGUMENTS.wsurToken#] is invalid, or the web service user relationship has expired.">
    <!--- Check to make sure wsfID is valid. --->
    <cfelseif ListContains(wsfIDList, ARGUMENTS.wsfID) EQ 0>
    <cfset rsWebServiceData.message = "Error: wsfID used not valid for this web service, please try again.">
    <!--- Check to see if web service has been modified since the last call. --->
    <cfelseif this.wsDateModified LT getWebServiceLogRet.wslDate>
    <cfset rsWebServiceData.message = "Error: Data has not changed. Please cache the web service data.">
    <cfelse>
    <cfinvoke 
    component="MCMS.component.app.web_service.WebService"
    method="getWebServiceAttributeRel"
    returnvariable="getWebServiceAttributeRelRet">
    <cfinvokeargument name="wsID" value="#this.ID#"/>
    <cfinvokeargument name="wsStatus" value="1"/>
    <cfinvokeargument name="wsaStatus" value="1"/>
    <cfinvokeargument name="wsarStatus" value="1"/>
    </cfinvoke>
    <cfset wsaNameList = ValueList(getWebServiceAttributeRelRet.wsaName)>
    <cfset wsaRegExList = ValueList(getWebServiceAttributeRelRet.wsaRegEx)>
    <cfset wsaDefaultList = ValueList(getWebServiceAttributeRelRet.wsaDefault)>
    
    <cfset wsaName = ListToArray(wsaNameList)>
    <cfset wsaRegEx = ListToArray(wsaRegExList, ',' , true)>
    <cfset wsaDefault = ListToArray(wsaDefaultList, ',' , true)>

    <cfset inputError = false>
    <cfloop from="1" to="#ArrayLen(wsaName)#" index="i">
    <!--- Check to make sure all web service attributes exist in the url. --->
	<cfif ArrayLen(StructFindKey(URL, wsaName[i])) EQ 0>
    <cfset rsWebServiceData.message = "Error: URL attribute [#wsaName[i]#] is required but was not passed.">
    <cfset inputError = true>
    <cfbreak>
    <!--- Check to see if the regex is matched. --->
    <cfelseif wsaRegEx[i] NEQ "" AND ArrayLen(REMatch(wsaRegEx[i], Evaluate('url.#wsaName[i]#'))) EQ 0>
    <cfset rsWebServiceData.message = "Error: URL attribute [#wsaName[i]#] is not in the proper format.">
    <cfset inputError = true>
    <cfbreak>
    <!--- Check to see if the url attribute passed is blank. --->
    <cfelseif Evaluate('url.#wsaName[i]#') EQ "" AND wsaDefault[i] EQ "">
    <cfset rsWebServiceData.message = "Error: URL Attribute [#wsaName[i]#] cannot be blank.">
    <cfset inputError = true>
    <cfbreak> 
    </cfif>
    </cfloop>
    <!--- Check to see if there were errors. --->
    <cfif inputError NEQ true>
    <!--- Update the web service date modified. --->
    <cfif this.sqlvName EQ 'INSERT' OR this.sqlvName EQ 'UPDATE' OR this.sqlvName EQ 'DELETE'>
    <cfinvoke 
    component="MCMS.component.app.web_service.WebService"
    method="updateWebServiceDateModified">
    <cfinvokeargument name="ID" value="#this.ID#"/>
    <cfinvokeargument name="wsDateModified" value="#Now()#"/>
    </cfinvoke>
    </cfif>
    <!--- Log the web service call. --->
    <cfinvoke 
    component="MCMS.component.app.web_service.WebService"
    method="insertWebServiceLog"
    returnvariable="insertWebServiceLogRet">
    <cfinvokeargument name="wsID" value="#this.ID#"/>
    <cfinvokeargument name="wsuID" value="#this.wsuID#"/>
    <cfinvokeargument name="wslIP" value="#CGI.REMOTE_ADDR#"/>
    <cfinvokeargument name="wslDate" value="#Now()#"/>
    <cfinvokeargument name="wslStatus" value="1"/>
    </cfinvoke>
    <!--- Call dynamic component with dynamic argument list. --->
    <cfinvoke 
    component="cfc.#this.component#"
    method="#this.method#"
    returnvariable="rs">
    <cfloop from="1" to="#ArrayLen(wsaName)#" index="i">
    <!--- Use the default if the URL value is blank and we have a default. --->
    <cfif Evaluate('url.#wsaName[i]#') EQ "" AND wsaDefault[i] NEQ "">
    <cfinvokeargument name="#wsaName[i]#" value="#wsaDefault[i]#"/>
    <cfelse>
    <cfinvokeargument name="#wsaName[i]#" value="#Evaluate('url.#wsaName[i]#')#"/>
    </cfif>
    </cfloop>
    </cfinvoke>
    <!--- When "SELECT" and no records. --->
    <cfif this.sqlvID EQ 102 AND rs.RecordCount EQ 0>
    <cfset rsWebServiceData.message = "There are no records.">
    <!--- Return data only when "SELECT". --->
    <cfelseif this.sqlvID EQ 102 AND rs.RecordCount NEQ 0>
    <cfswitch expression="#ARGUMENTS.wsfID#">
    <!--- Return: XML format. --->
    <cfcase value="2">
    <cfset cols = rs.columnList>
    <cfset toXML = createObject("component", "MCMS.component.utility.Xml")>
    <cfset rsWebServiceData = toXML.queryToXML(data=rs, rootelement="RESULTS", itemelement="RESULT",columnlist="#cols#",recordcount=rs.recordcount)>
    <cfprocessingdirective suppressWhiteSpace = "Yes">
    <cfsavecontent variable="webServiceData">
    <cfoutput>#rsWebServiceData#</cfoutput>
    </cfsavecontent>
    </cfprocessingdirective>
    <cfif DirectoryExists("D:\repository\webservice\xml")>
    <cffile action="write" file="D:\repository\webservice\xml\#wsID#_#this.wsuID#.xml" output="#webServiceData#" />
    <cfelse>
    <cfdirectory action="create" directory="D:\repository\webservice\xml" />
    <cffile action="write" file="D:\repository\webservice\xml\#wsID#_#this.wsuID#.xml" output="#webServiceData#" />
    </cfif>
    <cflocation url="#application.mcmsCDNURL#/#application.mcmsRepositoryDir#/webservice/xml/#wsID#_#this.wsuID#.xml" addtoken="no">
    </cfcase>    
    <!--- Return: json format. --->
    <cfcase value="3"> 
    <cfset rsWebServiceData = SerializeJSON(rs)>  
    </cfcase>
    <!--- Return: struct. --->
    <cfdefaultcase>
    <cfset cols = rs.columnList>
	  <cfset results = ArrayNew(1)>
    <cfset j = 1>
    <cfloop query="rs">
    <cfset result = StructNew()>
    <!--- Construct a struct based on dynamic column list. --->
    <cfloop list="#cols#" delimiters="," index="i">
    <cfset a = StructInsert(result, i, rs[i][rs.currentRow], 0)>
    </cfloop>
    <cfset results[j] = result>
    <cfset j = j +1>
    </cfloop>
    <cfset a = StructInsert(rsWebServiceData, "results", results,0)>    
    </cfdefaultcase>
    </cfswitch>
    <!--- Return message for INSERT, UPDATE, and DELETE. --->
    <cfelse>
    <cfset rsWebServiceData.message = rs.message>
    </cfif>
    </cfif>    
    </cfif>
    </cfif>
    </cfif>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsWebServiceData = StructNew()>
    <cfset rsWebServiceData.message = "There was an error with getWebServiceData. Please review the <a href='/api.cfm'>Web Service API</a> for proper URL format and example URL's.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsWebServiceData>
    </cffunction>
    
    <cffunction name="getWebServiceLog" access="public" returntype="query" hint="Get Web Service Log data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="ID" type="numeric" required="yes" default="0">
    <cfargument name="excludeID" type="numeric" required="yes" default="0">
    <cfargument name="wsID" type="numeric" required="yes" default="0">
    <cfargument name="wsuID" type="numeric" required="yes" default="0">
    <cfargument name="wslIP" type="string" required="yes" default="">
    <cfargument name="wslDate" type="string" required="yes" default="">
    <cfargument name="wslStatus" type="string" required="yes" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="wsID">
    <cfset var rsWebServiceLog = "" >
    <cftry>
    <cfquery name="rsWebServiceLog" datasource="#application.mcmsDSN#">
    SELECT * FROM swweb.tbl_web_service_log WHERE 0=0
    <cfif ARGUMENTS.ID NEQ 0>
    AND ID = <cfqueryparam value="#ARGUMENTS.ID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.excludeID NEQ 0>
    AND ID <> <cfqueryparam value="#ARGUMENTS.excludeID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND UPPER(wsID) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.wsID)#%" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.wsID NEQ 0>
    AND wsID = <cfqueryparam value="#ARGUMENTS.wsID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.wsuID NEQ 0>
    AND wsuID = <cfqueryparam value="#ARGUMENTS.wsuID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.wslIP NEQ "">
    AND wslIP = <cfqueryparam value="#ARGUMENTS.wslIP#" cfsqltype="cf_sql_varchar">
    </cfif>
    <cfif ARGUMENTS.wslDate NEQ "">
    AND TO_CHAR(wslDate, 'MM/DD/YYYY') = <cfqueryparam value="#DateFormat(ARGUMENTS.wslDate, application.dateFormat)#" cfsqltype="cf_sql_varchar">
    </cfif>
    AND wslStatus IN (<cfqueryparam value="#ARGUMENTS.wslStatus#" list="yes" cfsqltype="cf_sql_integer">)
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsWebServiceLog = StructNew()>
    <cfset rsWebServiceLog.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsWebServiceLog>
    </cffunction>
    
    <cffunction name="getWebServiceAttribute" access="public" returntype="query" hint="Get Web Service Attribute data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="ID" type="numeric" required="yes" default="0">
    <cfargument name="excludeID" type="numeric" required="yes" default="0">
    <cfargument name="wsaName" type="string" required="yes" default="">
    <cfargument name="wsaStatus" type="string" required="yes" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="wsaName">
    <cfset var rsWebServiceAttribute = "" >
    <cftry>
    <cfquery name="rsWebServiceAttribute" datasource="#application.mcmsDSN#">
    SELECT * FROM swweb.v_web_service_attribute WHERE 0=0
    <cfif ARGUMENTS.ID NEQ 0>
    AND ID = <cfqueryparam value="#ARGUMENTS.ID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.excludeID NEQ 0>
    AND ID <> <cfqueryparam value="#ARGUMENTS.excludeID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(wsaName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(wsaDescription) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">)
    </cfif>
    <cfif ARGUMENTS.wsaName NEQ "">
    AND UPPER(wsaName) = <cfqueryparam value="#UCASE(ARGUMENTS.wsaName)#" cfsqltype="cf_sql_varchar">
    </cfif>
    AND wsaStatus IN (<cfqueryparam value="#ARGUMENTS.wsaStatus#" list="yes" cfsqltype="cf_sql_integer">)
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsWebServiceAttribute = StructNew()>
    <cfset rsWebServiceAttribute.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsWebServiceAttribute>
    </cffunction>
    
    <cffunction name="getWebServiceUser" access="public" returntype="query" hint="Get Web Service User data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="ID" type="numeric" required="yes" default="0">
    <cfargument name="excludeID" type="numeric" required="yes" default="0">
    <cfargument name="wsuEmail" type="string" required="yes" default="">
    <cfargument name="wsuStatus" type="string" required="yes" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="wsuLName">
    <cfset var rsWebServiceUser = "" >
    <cftry>
    <cfquery name="rsWebServiceUser" datasource="#application.mcmsDSN#">
    SELECT * FROM swweb.v_web_service_user WHERE 0=0
    <cfif ARGUMENTS.ID NEQ 0>
    AND ID = <cfqueryparam value="#ARGUMENTS.ID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.excludeID NEQ 0>
    AND ID <> <cfqueryparam value="#ARGUMENTS.excludeID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(wsuFName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR (UPPER(wsuLName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(wsuEmail) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">)
    </cfif>
    <cfif ARGUMENTS.wsuEmail NEQ "">
    AND UPPER(wsuEmail) = <cfqueryparam value="#UCASE(ARGUMENTS.wsuEmail)#" cfsqltype="cf_sql_varchar">
    </cfif>
    AND wsuStatus IN (<cfqueryparam value="#ARGUMENTS.wsuStatus#" list="yes" cfsqltype="cf_sql_integer">)
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsWebServiceUser = StructNew()>
    <cfset rsWebServiceUser.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsWebServiceUser>
    </cffunction>
    
    <cffunction name="getWebServiceFormat" access="public" returntype="query" hint="Get Web Service Format data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="ID" type="numeric" required="yes" default="0">
    <cfargument name="excludeID" type="numeric" required="yes" default="0">
    <cfargument name="wsfName" type="string" required="yes" default="">
    <cfargument name="wsfStatus" type="string" required="yes" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="wsfName">
    <cfset var rsWebServiceFormat = "" >
    <cftry>
    <cfquery name="rsWebServiceFormat" datasource="#application.mcmsDSN#">
    SELECT * FROM swweb.v_web_service_format WHERE 0=0
    <cfif ARGUMENTS.ID NEQ 0>
    AND ID = <cfqueryparam value="#ARGUMENTS.ID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.excludeID NEQ 0>
    AND ID <> <cfqueryparam value="#ARGUMENTS.excludeID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(wsfName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(wsfDescription) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">)
    </cfif>
    <cfif ARGUMENTS.wsfName NEQ "">
    AND UPPER(wsfName) = <cfqueryparam value="#UCASE(ARGUMENTS.wsfName)#" cfsqltype="cf_sql_varchar">
    </cfif>
    AND wsfStatus IN (<cfqueryparam value="#ARGUMENTS.wsfStatus#" list="yes" cfsqltype="cf_sql_integer">)
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsWebServiceFormat = StructNew()>
    <cfset rsWebServiceFormat.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsWebServiceFormat>
    </cffunction>
    
    <cffunction name="getWebServiceFormatRel" access="public" returntype="query" hint="Get Web Service Format Rel. data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="ID" type="numeric" required="yes" default="0">
    <cfargument name="excludeID" type="numeric" required="yes" default="0">
    <cfargument name="wsName" type="string" required="yes" default="">
    <cfargument name="wsfName" type="string" required="yes" default="">
    <cfargument name="wsID" type="numeric" required="yes" default="0">
    <cfargument name="wsfID" type="numeric" required="yes" default="0">
    <cfargument name="wsStatus" type="string" required="yes" default="1,3">
    <cfargument name="wsfStatus" type="string" required="yes" default="1,3">
    <cfargument name="wsfrStatus" type="string" required="yes" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="wsfName">
    <cfset var rsWebServiceFormatRel = "" >
    <cftry>
    <cfquery name="rsWebServiceFormatRel" datasource="#application.mcmsDSN#">
    SELECT * FROM v_web_service_format_rel WHERE 0=0
    <cfif ARGUMENTS.ID NEQ 0>
    AND ID = <cfqueryparam value="#ARGUMENTS.ID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.excludeID NEQ 0>
    AND ID <> <cfqueryparam value="#ARGUMENTS.excludeID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(wsfName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(wsfDescription) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">)
    </cfif>
    <cfif ARGUMENTS.wsName NEQ "">
    AND UPPER(wsName) = <cfqueryparam value="#UCASE(ARGUMENTS.wsName)#" cfsqltype="cf_sql_varchar">
    </cfif>
    <cfif ARGUMENTS.wsfName NEQ "">
    AND UPPER(wsfName) = <cfqueryparam value="#UCASE(ARGUMENTS.wsfName)#" cfsqltype="cf_sql_varchar">
    </cfif>
    <cfif ARGUMENTS.wsID NEQ 0>
    AND wsID = <cfqueryparam value="#ARGUMENTS.wsID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.wsfID NEQ 0>
    AND wsfID = <cfqueryparam value="#ARGUMENTS.wsfID#" cfsqltype="cf_sql_integer">
    </cfif>
    AND wsStatus IN (<cfqueryparam value="#ARGUMENTS.wsStatus#" list="yes" cfsqltype="cf_sql_integer">)
    AND wsfStatus IN (<cfqueryparam value="#ARGUMENTS.wsfStatus#" list="yes" cfsqltype="cf_sql_integer">)
    AND wsfrStatus IN (<cfqueryparam value="#ARGUMENTS.wsfrStatus#" list="yes" cfsqltype="cf_sql_integer">)
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsWebServiceFormatRel = StructNew()>
    <cfset rsWebServiceFormatRel.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsWebServiceFormatRel>
    </cffunction>
    
    <cffunction name="getWebServiceUserRel" access="public" returntype="query" hint="Get Web Service User Relationship data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="ID" type="numeric" required="yes" default="0">
    <cfargument name="excludeID" type="numeric" required="yes" default="0">
    <cfargument name="wsID" type="numeric" required="yes" default="0">
    <cfargument name="wsurToken" type="string" required="yes" default="">
    <cfargument name="wsuID" type="numeric" required="yes" default="0">
    <cfargument name="wsurDateExp" type="string" required="yes" default="">
    <cfargument name="wsStatus" type="string" required="yes" default="1">
    <cfargument name="wsuStatus" type="string" required="yes" default="1">
    <cfargument name="wsurStatus" type="string" required="yes" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="wsName">
    <cfset var rsWebServiceUserRel = "" >
    <cftry>
    <cfquery name="rsWebServiceUserRel" datasource="#application.mcmsDSN#">
    SELECT * FROM swweb.v_web_service_user_rel WHERE 0=0
    <cfif ARGUMENTS.ID NEQ 0>
    AND ID = <cfqueryparam value="#ARGUMENTS.ID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.excludeID NEQ 0>
    AND ID <> <cfqueryparam value="#ARGUMENTS.excludeID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(wsName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(wsDescription) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(wsuName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">)
    </cfif>
    <cfif ARGUMENTS.wsID NEQ 0>
    AND wsID = <cfqueryparam value="#ARGUMENTS.wsID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.wsurToken NEQ "">
    AND wsurToken = <cfqueryparam value="#ARGUMENTS.wsurToken#" cfsqltype="cf_sql_varchar">
    </cfif>
    <cfif ARGUMENTS.wsuID NEQ 0>
    AND wsuID = <cfqueryparam value="#ARGUMENTS.wsuID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.wsurDateExp NEQ "">
    AND wsurDateExp >= <cfqueryparam value="#ARGUMENTS.wsurDateExp#" cfsqltype="cf_sql_date">
	</cfif>
    AND wsStatus IN (<cfqueryparam value="#ARGUMENTS.wsStatus#" list="yes" cfsqltype="cf_sql_integer">)
    AND wsuStatus IN (<cfqueryparam value="#ARGUMENTS.wsuStatus#" list="yes" cfsqltype="cf_sql_integer">)
    AND wsurStatus IN (<cfqueryparam value="#ARGUMENTS.wsurStatus#" list="yes" cfsqltype="cf_sql_integer">)
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsWebServiceUserRel = StructNew()>
    <cfset rsWebServiceUserRel.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsWebServiceUserRel>
    </cffunction>
    
    <cffunction name="getWebServiceAttributeRel" access="public" returntype="query" hint="Get Web Service Attribute Relationship data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="ID" type="numeric" required="yes" default="0">
    <cfargument name="excludeID" type="numeric" required="yes" default="0">
    <cfargument name="wsID" type="numeric" required="yes" default="0">
    <cfargument name="wsaID" type="numeric" required="yes" default="0">
    <cfargument name="wsStatus" type="string" required="yes" default="1">
    <cfargument name="wsaStatus" type="string" required="yes" default="1">
    <cfargument name="wsarStatus" type="string" required="yes" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="wsName">
    <cfset var rsWebServiceAttributeRel = "" >
    <cftry>
    <cfquery name="rsWebServiceAttributeRel" datasource="#application.mcmsDSN#">
    SELECT * FROM swweb.v_web_service_attribute_rel WHERE 0=0
    <cfif ARGUMENTS.ID NEQ 0>
    AND ID = <cfqueryparam value="#ARGUMENTS.ID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.excludeID NEQ 0>
    AND ID <> <cfqueryparam value="#ARGUMENTS.excludeID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(wsName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(wsDescription) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(wsaName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(wsaDescription) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">)
    </cfif>
    <cfif ARGUMENTS.wsID NEQ 0>
    AND wsID = <cfqueryparam value="#ARGUMENTS.wsID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.wsaID NEQ 0>
    AND wsaID = <cfqueryparam value="#ARGUMENTS.wsaID#" cfsqltype="cf_sql_integer">
    </cfif>
    AND wsStatus IN (<cfqueryparam value="#ARGUMENTS.wsStatus#" list="yes" cfsqltype="cf_sql_integer">)
    AND wsaStatus IN (<cfqueryparam value="#ARGUMENTS.wsaStatus#" list="yes" cfsqltype="cf_sql_integer">)
    AND wsarStatus IN (<cfqueryparam value="#ARGUMENTS.wsarStatus#" list="yes" cfsqltype="cf_sql_integer">)
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsWebServiceAttributeRel = StructNew()>
    <cfset rsWebServiceAttributeRel.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsWebServiceAttributeRel>
    </cffunction>
    
    <cffunction name="getWebServiceReport" access="public" returntype="query" hint="Get Web Service Report data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="orderBy" type="string" required="yes" default="wsName">
    <cfset var rsWebServiceReport = "" >
    <cftry>
    <cfquery name="rsWebServiceReport" datasource="#application.mcmsDSN#">
    SELECT wsName AS Name, wsDescription AS Description, appName AS Application, wsID, wsComponent AS Component, wsMethod AS Method, wsProxy AS Proxy, wsSSLRequired AS Required, wsuLName || ' ' || wsuFName AS User_Name, sqlvName AS Sql_Verb, TO_CHAR(wsDate, 'MM/DD/YYYY') AS Ws_Date, sortName AS Sort, sName As Status FROM swweb.v_web_service WHERE 0=0
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(wsName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(wsDescription) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">)
    </cfif>
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsWebServiceReport = StructNew()>
    <cfset rsWebServiceReport.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsWebServiceReport>
    </cffunction>
    
    <cffunction name="getWebServiceAttributeReport" access="public" returntype="query" hint="Get Web Service Attribute Report data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="orderBy" type="string" required="yes" default="wsaName">
    <cfset var rsWebServiceReport = "" >
    <cftry>
    <cfquery name="rsWebServiceReport" datasource="#application.mcmsDSN#">
    SELECT wsaName AS Name, wsaDescription AS Description, dtName AS Data_Type, dtfName AS Data_Type_Format, wsaRegEx AS Reg_Ex, wsaDefault AS Attr_Default, wsaExclude AS Attr_Exclude, sortName AS Sort, sName AS Status FROM swweb.v_web_service_attribute WHERE 0=0
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(wsaName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(wsaDescription) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">)
    </cfif>
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsWebServiceReport = StructNew()>
    <cfset rsWebServiceReport.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsWebServiceReport>
    </cffunction>
    
    <cffunction name="getWebServiceUserReport" access="public" returntype="query" hint="Get Web Service User Report data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="orderBy" type="string" required="yes" default="wsuFName">
    <cfset var rsWebServiceUserReport = "" >
    <cftry>
    <cfquery name="rsWebServiceUserReport" datasource="#application.mcmsDSN#">
    SELECT wsuFName || ' ' || wsuLName AS Name, wsuEmail AS Email, wsuPassword AS Password, userFName || ' ' || userLName AS User_Created, userIP AS User_IP, TO_CHAR(wsuDateHistory, 'MM/DD/YYYY') AS History, TO_CHAR(wsuDateLast, 'MM/DD/YYYY') AS Date_Last, sName AS Status FROM swweb.v_web_service_user WHERE 0=0
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(wsuFName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(wsuLName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(wsuEmail) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">)
    </cfif>
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsWebServiceUserReport = StructNew()>
    <cfset rsWebServiceUserReport.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsWebServiceUserReport>
    </cffunction>
    
    <cffunction name="getWebServiceFormatReport" access="public" returntype="query" hint="Get Web Service Format Report data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="orderBy" type="string" required="yes" default="wsfName">
    <cfset var rsWebServiceFormatReport = "" >
    <cftry>
    <cfquery name="rsWebServiceFormatReport" datasource="#application.mcmsDSN#">
    SELECT wsfName, wsfDescription FROM swweb.v_web_service_format WHERE 0=0
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(wsfName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(wsfDescription) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">)
    </cfif>
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsWebServiceFormatReport = StructNew()>
    <cfset rsWebServiceFormatReport.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsWebServiceFormatReport>
    </cffunction>
    
    <cffunction name="getWebServiceUserRelReport" access="public" returntype="query" hint="Get Web Service User Relationship Report data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="orderBy" type="string" required="yes" default="wsName">
    <cfset var rsWebServiceUserRelReport = "" >
    <cftry>
    <cfquery name="rsWebServiceUserRelReport" datasource="#application.mcmsDSN#">
    SELECT wsName AS Web_Service, wsuFName || ' ' || wsuLName AS Web_Service_User, wsurToken AS Token, TO_CHAR(wsurDate, 'MM/DD/YYYY') AS Web_Service_User_Rel_Date, TO_CHAR(wsurDateExp, 'MM/DD/YYYY') AS Web_Service_User_Rel_Date_Exp, sName AS Status FROM swweb.v_web_service_user_rel WHERE 0=0
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(wsName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(wsuName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">)
    </cfif>
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsWebServiceUserRelReport = StructNew()>
    <cfset rsWebServiceUserRelReport.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsWebServiceUserRelReport>
    </cffunction>
    
    <cffunction name="insertWebService" access="public" returntype="struct">
    <cfargument name="wsName" type="string" required="yes">
    <cfargument name="wsDescription" type="string" required="yes">
    <cfargument name="netID" type="numeric" required="yes">
    <cfargument name="appID" type="numeric" required="yes">
    <cfargument name="wsID" type="string" required="yes">
    <cfargument name="wsComponent" type="string" required="yes">
    <cfargument name="wsMethod" type="string" required="yes">
    <cfargument name="wsProxy" type="string" required="yes">
    <cfargument name="wsSSLRequired" type="numeric" required="yes">
    <cfargument name="userID" type="numeric" required="yes">
    <cfargument name="sqlvID" type="numeric" required="yes">
    <cfargument name="wsSort" type="numeric" required="yes">
    <cfargument name="wsStatus" type="numeric" required="yes">
    <!---Relationship arguments.--->
    <cfargument name="wsaID" type="string" required="yes">
    <cfargument name="wsfID" type="string" required="no">
    <cfset result.message = "You have successfully inserted the record.">
    <cftry>
    <!---Check for profanity in the text.--->
    <cfinvoke 
    component="MCMS.component.utility.Regex"
    method="regexProfanity"
    returnvariable="regexProfanityRet">
    <cfinvokeargument name="profanityString" value="#ARGUMENTS.wsDescription#"/>
    </cfinvoke>
    <!---Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.app.web_service.WebService"
    method="getWebService"
    returnvariable="getCheckWebServiceRet">
    <cfinvokeargument name="wsName" value="#ARGUMENTS.wsName#"/>
    <cfinvokeargument name="wsStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckWebServiceRet.recordcount NEQ 0>
    <cfset result.message = "The name #ARGUMENTS.wsName# already exists, please enter a new name.">
    <cfelseif regexProfanityRet CONTAINS '$%&*!'>
    <cfset result.message = "Some text contained profanity, please remove any profanity from your text.">
    <!---Check length restriction.--->
    <cfelseif LEN(ARGUMENTS.wsDescription) GT 2048>
    <cfset result.message = "The description is longer than 2048 characters, please enter a new description under 2048 characters.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    INSERT INTO swweb.tbl_web_service (wsName,wsDescription,netID,appID,wsID,wsComponent,wsMethod,wsProxy,wsSSLRequired,userID,sqlvID,wsSort,wsStatus) VALUES
    (
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.wsName#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.wsDescription#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.netID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.appID#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.wsID#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.wsComponent#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.wsMethod#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.wsProxy#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.wsSSLRequired#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.userID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.sqlvID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.wsSort#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.wsStatus#">
    )
    </cfquery>
    </cftransaction>
    <!--- Get newly inserted auction ID. --->
    <cfinvoke 
    component="MCMS.component.cms.Cms"
    method="getMaxValueSQL"
    returnvariable="wsID">
    <cfinvokeargument name="tableName" value="tbl_web_service"/>
    </cfinvoke>
    <cfset var.wsID = wsID>
    <!---Create attribute relationships.--->
    <cfloop index="wsaID" list="#ARGUMENTS.wsaID#">
    <cfinvoke 
    component="MCMS.component.app.web_service.WebService"
    method="insertWebServiceAttributeRel"
    returnvariable="insertWebServiceAttributeRelRet">
    <cfinvokeargument name="wsID" value="#var.wsID#"/>
    <cfinvokeargument name="wsaID" value="#ARGUMENTS.wsaID#"/>
    <cfinvokeargument name="wsarStatus" value="1"/>
    </cfinvoke>
    </cfloop>
    <!---Create format relationships.--->
    <cfloop index="wsfID" list="#ARGUMENTS.wsfID#">
    <cfinvoke 
    component="MCMS.component.app.web_service.WebService"
    method="insertWebServiceFormatRel"
    returnvariable="insertWebServiceFormatRelRet">
    <cfinvokeargument name="wsID" value="#var.wsID#"/>
    <cfinvokeargument name="wsfID" value="#ARGUMENTS.wsfID#"/>
    <cfinvokeargument name="wsfrStatus" value="1"/>
    </cfinvoke>
    </cfloop>
    </cfif>
    <cfcatch type="any">
    <cfset result.message = "There was an error inserting the record.">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="insertWebServiceLog" access="public" returntype="struct">
    <cfargument name="wsID" type="numeric" required="yes">
    <cfargument name="wsuID" type="numeric" required="yes">
    <cfargument name="wslIP" type="string" required="yes">
    <cfargument name="wslDate" type="string" required="yes">
    <cfargument name="wslStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully inserted the record.">
    <cftry>
    <!---Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.app.web_service.WebService"
    method="getWebServiceLog"
    returnvariable="getCheckWebServiceLogRet">
    <cfinvokeargument name="wsID" value="#ARGUMENTS.wsID#"/>
    <cfinvokeargument name="wsuID" value="#ARGUMENTS.wsuID#"/>
    <cfinvokeargument name="wslIP" value="#ARGUMENTS.wslIP#"/>
    <cfinvokeargument name="wslDate" value="#ARGUMENTS.wslDate#"/>
    <cfinvokeargument name="wslStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckWebServiceLogRet.recordcount NEQ 0>
    <!--- Update hit count if the record already exists. --->
    <cfset this.ID = getCheckWebServiceLogRet.ID>   
    <cfset this.wslHit = getCheckWebServiceLogRet.wslHit + 1>
    <cfinvoke 
    component="MCMS.component.app.web_service.WebService"
    method="updateWebServiceLog"
    returnvariable="updateWebServiceLogRet">
    <cfinvokeargument name="ID" value="#this.ID#"/>
    <cfinvokeargument name="wslHit" value="#this.wslHit#"/>
    <cfinvokeargument name="wslStatus" value="1"/>
    </cfinvoke>
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    INSERT INTO swweb.tbl_web_service_log (wsID,wsuID,wslIP,wslDate,wslStatus) VALUES
    (
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.wsID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.wsuID#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.wslIP#">,
    <cfqueryparam cfsqltype="cf_sql_timestamp" value="#ARGUMENTS.wslDate#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.wslStatus#">
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
    
    <cffunction name="insertWebServiceAttribute" access="public" returntype="struct">
    <cfargument name="wsaName" type="string" required="yes">
    <cfargument name="wsaDescription" type="string" required="yes">
    <cfargument name="dtID" type="numeric" required="yes">
    <cfargument name="dtfID" type="numeric" required="yes">
    <cfargument name="wsaRegEx" type="string" required="yes">
    <cfargument name="wsaDefault" type="string" required="yes">
    <cfargument name="wsaExclude" type="string" required="yes">
    <cfargument name="wsaSort" type="numeric" required="yes">
    <cfargument name="wsaStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully inserted the record.">
    <cftry>
    <!---Check for profanity in the text.--->
    <cfinvoke 
    component="MCMS.component.utility.Regex"
    method="regexProfanity"
    returnvariable="regexProfanityRet">
    <cfinvokeargument name="profanityString" value="#ARGUMENTS.wsaDescription#"/>
    </cfinvoke>
    <!---Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.app.web_service.WebService"
    method="getWebServiceAttribute"
    returnvariable="getCheckWebServiceAttributeRet">
    <cfinvokeargument name="wsaName" value="#ARGUMENTS.wsaName#"/>
    <cfinvokeargument name="wsaStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckWebServiceAttributeRet.recordcount NEQ 0>
    <cfset result.message = "The name #ARGUMENTS.wsaName# already exists, please enter a new name.">
    <cfelseif regexProfanityRet CONTAINS '$%&*!'>
    <cfset result.message = "Some text contained profanity, please remove any profanity from your text.">
    <!---Check length restriction.--->
    <cfelseif LEN(ARGUMENTS.wsaDescription) GT 512>
    <cfset result.message = "The description is longer than 512 characters, please enter a new description under 512 characters.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    INSERT INTO swweb.tbl_web_service_attribute (wsaName,wsaDescription,dtID,dtfID,wsaRegEx,wsaDefault,wsaExclude,wsaSort,wsaStatus) VALUES
    (
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.wsaName#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.wsaDescription#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.dtID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.dtfID#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.wsaRegEx#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.wsaDefault#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.wsaExclude#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.wsaSort#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.wsaStatus#">
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
    
    <cffunction name="insertWebServiceUser" access="public" returntype="struct">
    <cfargument name="wsuFName" type="string" required="yes">
    <cfargument name="wsuLName" type="string" required="yes">
    <cfargument name="wsuEmail" type="string" required="yes">
    <cfargument name="wsuPassword" type="string" required="yes">
    <cfargument name="userID" type="numeric" required="yes" default="0">
    <cfargument name="userIP" type="string" required="yes" default="#CGI.REMOTE_ADDR#">
    <cfargument name="wsuStatus" type="numeric" required="yes" default="1">
    <cfset result.message = "You have successfully registered.<br /><a href='/web_service/'>Sign In Now.</a>">
    <cftry>
    <!---Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.app.web_service.WebService"
    method="getWebServiceUser"
    returnvariable="getCheckWebServiceUserRet">
    <cfinvokeargument name="wsuEmail" value="#ARGUMENTS.wsuEmail#"/>
    <cfinvokeargument name="wsuStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckWebServiceUserRet.recordcount NEQ 0>
    <cfset result.message = "The email #ARGUMENTS.wsuEmail# already exists, <br/>please enter a email or retrieve the password.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    INSERT INTO swweb.tbl_web_service_user (wsuFName,wsuLName,wsuEmail,wsuPassword,userID,userIP,wsuStatus) VALUES
    (
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.wsuFName#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.wsuLName#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.wsuEmail#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.wsuPassword#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.userID#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.userIP#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.wsuStatus#">
    )
    </cfquery>
    <cfinvoke 
    component="MCMS.component.app.web_service.WebService"
    method="getWebServiceUser"
    returnvariable="getWebServiceUserRet">
    <cfinvokeargument name="wsuEmail" value="#ARGUMENTS.wsuEmail#"/>
    <cfinvokeargument name="wsuStatus" value="1"/>
    </cfinvoke>
    <cfset result.status = true>
    <cfset result.ID = getWebServiceUserRet.ID>
    </cftransaction>
    </cfif>
    <cfcatch type="any">
    <cfset result.message = "There was an error inserting the record.">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="insertWebServiceFormat" access="public" returntype="struct">
    <cfargument name="wsfName" type="string" required="yes">
    <cfargument name="wsfDescription" type="string" required="yes">
    <cfargument name="wsfStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully inserted the record.">
    <cftry>
    <!---Check for profanity in the text.--->
    <cfinvoke 
    component="MCMS.component.utility.Regex"
    method="regexProfanity"
    returnvariable="regexProfanityRet">
    <cfinvokeargument name="profanityString" value="#ARGUMENTS.wsfDescription#"/>
    </cfinvoke>
    <!---Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.app.web_service.WebService"
    method="getWebService"
    returnvariable="getCheckWebServiceFormatRet">
    <cfinvokeargument name="wsfName" value="#ARGUMENTS.wsfName#"/>
    <cfinvokeargument name="wsfStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckWebServiceFormatRet.recordcount NEQ 0>
    <cfset result.message = "The name #ARGUMENTS.wsfName# already exists, please enter a new name.">
    <cfelseif regexProfanityRet CONTAINS '$%&*!'>
    <cfset result.message = "Some text contained profanity, please remove any profanity from your text.">
    <!---Check length restriction.--->
    <cfelseif LEN(ARGUMENTS.wsfDescription) GT 512>
    <cfset result.message = "The description is longer than 512 characters, please enter a new description under 512 characters.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    INSERT INTO swweb.tbl_web_service_format (wsfName,wsfDescription,wsfStatus) VALUES
    (
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.wsfName#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.wsfDescription#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.wsfStatus#">
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
    
    <cffunction name="insertWebServiceFormatRel" access="public" returntype="struct">
    <cfargument name="wsID" type="numeric" required="yes">
    <cfargument name="wsfID" type="numeric" required="yes">
    <cfargument name="wsfrStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully inserted the record.">
    <cftry>
    <!---Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.app.web_service.WebService"
    method="getWebServiceFormatRel"
    returnvariable="getWebServiceFormatRelRet">
    <cfinvokeargument name="wsID" value="#ARGUMENTS.wsID#"/>
    <cfinvokeargument name="wsfID" value="#ARGUMENTS.wsfID#"/>
    <cfinvokeargument name="wsfrStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getWebServiceFormatRelRet.recordcount NEQ 0>
    <cfset result.message = "The web service format relationship already exists, please try again.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    INSERT INTO tbl_web_service_format_rel (wsID,wsfID,wsfrStatus) VALUES
    (
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.wsID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.wsfID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.wsfrStatus#">
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
    
    <cffunction name="insertWebServiceUserRel" access="public" returntype="struct">
    <cfargument name="wsID" type="numeric" required="yes">
    <cfargument name="wsuID" type="numeric" required="yes">
    <cfargument name="wsurDateExp" type="date" required="yes">
    <cfargument name="wsurStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully inserted the record.">
    <cftry>
    <!---Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.app.web_service.WebService"
    method="getWebServiceUserRel"
    returnvariable="getCheckWebServiceUserRelRet">
    <cfinvokeargument name="wsID" value="#ARGUMENTS.wsID#"/>
    <cfinvokeargument name="wsuID" value="#ARGUMENTS.wsuID#"/>
    <cfinvokeargument name="wsurStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckWebServiceUserRelRet.recordcount NEQ 0>
    <cfset result.message = "The web service user relationship already exists, please try again.">
    <cfelse>
	<cfset this.encryptionValue = ARGUMENTS.wsuID & Dateformat(Now(), application.dateformat)>
    <cfinvoke 
    component="MCMS.component.app.security.Security"
    method="setEcryption"
    returnvariable="setEcryptionRet">
    <cfinvokeargument name="value" value="#this.encryptionValue#"/>
    </cfinvoke>
    <cfset this.wsurToken = URLEncodedFormat(setEcryptionRet.encryptKey)>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    INSERT INTO swweb.tbl_web_service_user_rel (wsID,wsuID,wsurToken,wsurDateExp,wsurStatus) VALUES
    (   
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.wsID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.wsuID#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#this.wsurToken#">,
    <cfqueryparam cfsqltype="cf_sql_date" value="#ARGUMENTS.wsurDateExp#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.wsurStatus#">
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
    
    <cffunction name="insertWebServiceAttributeRel" access="public" returntype="struct">
    <cfargument name="wsID" type="numeric" required="yes">
    <cfargument name="wsaID" type="numeric" required="yes">
    <cfargument name="wsarStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully inserted the record.">
    <cftry>
    <!---Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.app.web_service.WebService"
    method="getWebServiceAttributeRel"
    returnvariable="getCheckWebServiceAttributeRet">
    <cfinvokeargument name="wsID" value="#ARGUMENTS.wsID#"/>
    <cfinvokeargument name="wsaID" value="#ARGUMENTS.wsaID#"/>
    <cfinvokeargument name="wsarStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckWebServiceAttributeRet.recordcount NEQ 0>
    <cfset result.message = "The web service attribute reationship already exists, please try again.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    INSERT INTO swweb.tbl_web_service_attribute_rel (wsID,wsaID,wsarStatus) VALUES
    (
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.wsID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.wsaID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.wsarStatus#">
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
    
    <cffunction name="updateWebService" access="public" returntype="struct">
    <cfargument name="ID" type="numeric" required="yes">
    <cfargument name="wsName" type="string" required="yes">
    <cfargument name="wsDescription" type="string" required="yes">
    <cfargument name="netID" type="numeric" required="yes">
    <cfargument name="appID" type="numeric" required="yes">
    <cfargument name="wsID" type="string" required="yes">
    <cfargument name="wsComponent" type="string" required="yes">
    <cfargument name="wsMethod" type="string" required="yes">
    <cfargument name="wsProxy" type="string" required="yes">
    <cfargument name="wsSSLRequired" type="numeric" required="yes">
    <cfargument name="userID" type="numeric" required="yes">
    <cfargument name="sqlvID" type="numeric" required="yes">
    <cfargument name="wsSort" type="numeric" required="yes">
    <cfargument name="wsStatus" type="numeric" required="yes">
    <!---Relationship arguments.--->
    <cfargument name="wsaID" type="string" required="yes">
    <cfargument name="wsfID" type="string" required="yes">
    <cfset result.message = "You have successfully updated the record.">
    <cftry>
    <!---Check for profanity in the text.--->
    <cfinvoke 
    component="MCMS.component.utility.Regex"
    method="regexProfanity"
    returnvariable="regexProfanityRet">
    <cfinvokeargument name="profanityString" value="#ARGUMENTS.wsDescription#"/>
    </cfinvoke>
    <!---Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.app.web_service.WebService"
    method="getWebService"
    returnvariable="getCheckWebServiceRet">
    <cfinvokeargument name="excludeID" value="#ARGUMENTS.ID#"/>
    <cfinvokeargument name="wsName" value="#ARGUMENTS.wsName#"/>
    <cfinvokeargument name="wsStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckWebServiceRet.recordcount NEQ 0>
    <cfset result.message = "The name #ARGUMENTS.wsName# already exists, please enter a new name.">
    <cfelseif regexProfanityRet CONTAINS '$%&*!'>
    <cfset result.message = "Some text contained profanity, please remove any profanity from your text.">
    <!---Check length restriction.--->
    <cfelseif LEN(ARGUMENTS.wsDescription) GT 2048>
    <cfset result.message = "The description is longer than 2048 characters, please enter a new description under 2048 characters.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE swweb.tbl_web_service SET
    wsName = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.wsName#">,
    wsDescription = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.wsDescription#">,
    netID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.netID#">,
    appID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.appID#">,
    wsID = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.wsID#">,
    wsComponent = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.wsComponent#">,
    wsMethod = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.wsMethod#">,
    wsProxy = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.wsProxy#">,
    wsSSLRequired = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.wsSSLRequired#">,
    userID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.userID#">,
    sqlvID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.sqlvID#">,
    wsDateModified = <cfqueryparam cfsqltype="cf_sql_timestamp" value="#Now()#">,
    wsSort = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.wsSort#">,
    wsStatus = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.wsStatus#">
    WHERE ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ID#">
    </cfquery>
    </cftransaction>
    <!---Delete any existing relationships.--->
    <cfinvoke 
    component="MCMS.component.app.web_service.WebService"
    method="deleteWebServiceAttributeRel"
    returnvariable="deleteWebServiceAttributeRelRet">
    <cfinvokeargument name="wsID" value="#ARGUMENTS.ID#"/>
    </cfinvoke>
    <cfinvoke 
    component="MCMS.component.app.web_service.WebService"
    method="deleteWebServiceFormatRel"
    returnvariable="deleteWebServiceFormatRelRet">
    <cfinvokeargument name="wsID" value="#ARGUMENTS.ID#"/>
    </cfinvoke>
    <!---Create attribute relationships.--->
    <cfloop index="wsaID" list="#ARGUMENTS.wsaID#">
    <cfinvoke 
    component="MCMS.component.app.web_service.WebService"
    method="insertWebServiceAttributeRel"
    returnvariable="insertWebServiceAttributeRelRet">
    <cfinvokeargument name="wsID" value="#ARGUMENTS.ID#"/>
    <cfinvokeargument name="wsaID" value="#ARGUMENTS.wsaID#"/>
    <cfinvokeargument name="wsarStatus" value="1"/>
    </cfinvoke>
    </cfloop>
    <!---Create format relationships.--->
    <cfloop index="wsfID" list="#ARGUMENTS.wsfID#">
    <cfinvoke 
    component="MCMS.component.app.web_service.WebService"
    method="insertWebServiceFormatRel"
    returnvariable="insertWebServiceFormatRelRet">
    <cfinvokeargument name="wsID" value="#ARGUMENTS.ID#"/>
    <cfinvokeargument name="wsfID" value="#ARGUMENTS.wsfID#"/>
    <cfinvokeargument name="wsfrStatus" value="1"/>
    </cfinvoke>
    </cfloop>
    </cfif>
    <cfcatch type="any">
    <cfset result.message = "There was an error updating the record.">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="updateWebServiceDateModified" access="public">
    <cfargument name="ID" type="numeric" required="yes">
    <cfargument name="wsDateModified" type="date" required="yes">
    <cfset result.message = "You have successfully updated the record.">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE swweb.tbl_web_service SET
    wsDateModified = <cfqueryparam cfsqltype="cf_sql_timestamp" value="#ARGUMENTS.wsDateModified#">
    WHERE ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ID#">
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error updating the record.">
    
    </cfcatch>
    </cftry>
    <cfreturn true>
    </cffunction>
    
    <cffunction name="updateWebServiceLog" access="public" returntype="struct">
    <cfargument name="ID" type="numeric" required="yes">
    <cfargument name="wslHit" type="numeric" required="yes">
    <cfargument name="wslStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully updated the record.">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE swweb.tbl_web_service_log SET
    wslHit = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.wslHit#">,
    wslStatus = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.wslStatus#">,
    wslDate = <cfqueryparam cfsqltype="cf_sql_timestamp" value="#Now()#">
    WHERE ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ID#">
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error updating the record.">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="updateWebServiceAttribute" access="public" returntype="struct">
    <cfargument name="ID" type="numeric" required="yes">
    <cfargument name="wsaName" type="string" required="yes">
    <cfargument name="wsaDescription" type="string" required="yes">
    <cfargument name="dtID" type="numeric" required="yes">
    <cfargument name="dtfID" type="numeric" required="yes">
    <cfargument name="wsaRegEx" type="string" required="yes">
    <cfargument name="wsaDefault" type="string" required="yes">
    <cfargument name="wsaExclude" type="string" required="yes">
    <cfargument name="wsaSort" type="numeric" required="yes">
    <cfargument name="wsaStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully updated the record.">
    <cftry>
    <!---Check for profanity in the text.--->
    <cfinvoke 
    component="MCMS.component.utility.Regex"
    method="regexProfanity"
    returnvariable="regexProfanityRet">
    <cfinvokeargument name="profanityString" value="#ARGUMENTS.wsaDescription#"/>
    </cfinvoke>
    <!---Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.app.web_service.WebService"
    method="getWebServiceAttribute"
    returnvariable="getCheckWebServiceAttributeRet">
    <cfinvokeargument name="excludeID" value="#ARGUMENTS.ID#"/>
    <cfinvokeargument name="wsaName" value="#ARGUMENTS.wsaName#"/>
    <cfinvokeargument name="wsaStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckWebServiceAttributeRet.recordcount NEQ 0>
    <cfset result.message = "The name #ARGUMENTS.wsaName# already exists, please enter a new name.">
    <cfelseif regexProfanityRet CONTAINS '$%&*!'>
    <cfset result.message = "Some text contained profanity, please remove any profanity from your text.">
    <!---Check length restriction.--->
    <cfelseif LEN(ARGUMENTS.wsaDescription) GT 512>
    <cfset result.message = "The description is longer than 512 characters, please enter a new description under 512 characters.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE swweb.tbl_web_service_attribute SET
    wsaName = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.wsaName#">,
    wsaDescription = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.wsaDescription#">,
    dtID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.dtID#">,
    dtfID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.dtfID#">,
    wsaRegEx = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.wsaRegEx#">,
    wsaDefault = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.wsaDefault#">,
    wsaExclude = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.wsaExclude#">,
    wsaSort = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.wsaSort#">,
    wsaStatus = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.wsaStatus#">
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
    
    <cffunction name="updateWebServiceUser" access="public" returntype="struct">
    <cfargument name="ID" type="numeric" required="yes">
    <cfargument name="wsuFName" type="string" required="yes">
    <cfargument name="wsuLName" type="string" required="yes">
    <cfargument name="wsuEmail" type="string" required="yes">
    <cfargument name="wsuPassword" type="string" required="yes">
    <cfargument name="userID" type="numeric" required="yes">
    <cfargument name="userIP" type="string" required="yes">
    <cfargument name="wsuStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully updated the record.">
    <cftry>
    <!---Check for profanity in the text.--->
    <cfinvoke 
    component="MCMS.component.utility.Regex"
    method="regexProfanity"
    returnvariable="regexProfanityRet">
    <cfinvokeargument name="profanityString" value="#ARGUMENTS.wsuFName#"/>
    </cfinvoke>
    <!---Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.app.web_service.WebService"
    method="getWebServiceUser"
    returnvariable="getCheckWebServiceUserRet">
    <cfinvokeargument name="excludeID" value="#ARGUMENTS.ID#"/>
    <cfinvokeargument name="wsuEmail" value="#ARGUMENTS.wsuEmail#"/>
    <cfinvokeargument name="wsuStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckWebServiceUserRet.recordcount NEQ 0>
    <cfset result.message = "The email #ARGUMENTS.wsuEmail# already exists, please enter a new email.">
    <cfelseif regexProfanityRet CONTAINS '$%&*!'>
    <cfset result.message = "Some text contained profanity, please remove any profanity from your text.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE swweb.tbl_web_service_user SET
    wsuFName = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.wsuFName#">,
    wsuLName = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.wsuLName#">,
    wsuEmail = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.wsuEmail#">,
    wsuPassword = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.wsuPassword#">,
    userID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.userID#">,
    userIP = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.userIP#">,
    wsuStatus = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.wsuStatus#">
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
    
    <cffunction name="updateWebServiceFormat" access="public" returntype="struct">
    <cfargument name="ID" type="numeric" required="yes">
    <cfargument name="wsfName" type="string" required="yes">
    <cfargument name="wsfDescription" type="string" required="yes">
    <cfargument name="wsfStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully updated the record.">
    <cftry>
    <!---Check for profanity in the text.--->
    <cfinvoke 
    component="MCMS.component.utility.Regex"
    method="regexProfanity"
    returnvariable="regexProfanityRet">
    <cfinvokeargument name="profanityString" value="#ARGUMENTS.wsfDescription#"/>
    </cfinvoke>
    <!---Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.app.web_service.WebService"
    method="getWebServiceFormat"
    returnvariable="getCheckWebServiceFormatRet">
    <cfinvokeargument name="excludeID" value="#ARGUMENTS.ID#"/>
    <cfinvokeargument name="wsfName" value="#ARGUMENTS.wsfName#"/>
    <cfinvokeargument name="wsfStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckWebServiceFormatRet.recordcount NEQ 0>
    <cfset result.message = "The name #ARGUMENTS.wsfName# already exists, please enter a new name.">
    <cfelseif regexProfanityRet CONTAINS '$%&*!'>
    <cfset result.message = "Some text contained profanity, please remove any profanity from your text.">
    <!---Check length restriction.--->
    <cfelseif LEN(ARGUMENTS.wsfDescription) GT 512>
    <cfset result.message = "The description is longer than 512 characters, please enter a new description under 512 characters.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE swweb.tbl_web_service_format SET
    wsfName = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.wsfName#">,
    wsfDescription = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.wsfDescription#">,
    wsfStatus = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.wsfStatus#">
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
    
    <cffunction name="updateWebServiceUserRel" access="public" returntype="struct">
    <cfargument name="ID" type="numeric" required="yes">
    <cfargument name="wsID" type="numeric" required="yes">
    <cfargument name="wsuID" type="numeric" required="yes">
    <cfargument name="wsurDateExp" type="date" required="yes">
    <cfargument name="wsurStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully updated the record.">
    <cftry>
    <!---Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.app.web_service.WebService"
    method="getWebServiceUserRel"
    returnvariable="getCheckWebServiceUserRelRet">
    <cfinvokeargument name="excludeID" value="#ARGUMENTS.ID#"/>
    <cfinvokeargument name="wsID" value="#ARGUMENTS.wsID#"/>
    <cfinvokeargument name="wsuID" value="#ARGUMENTS.wsuID#"/>
    <cfinvokeargument name="wsuStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckWebServiceUserRelRet.recordcount NEQ 0>
    <cfset result.message = "The web service user relationship already exists, please try again.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE swweb.tbl_web_service_user_rel SET
    wsID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.wsID#">,
    wsuID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.wsuID#">,
    wsurDateExp = <cfqueryparam cfsqltype="cf_sql_date" value="#ARGUMENTS.wsurDateExp#">,
    wsurStatus = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.wsurStatus#">
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
    
    <cffunction name="updateWebServiceList" access="public" returntype="struct">
    <cfargument name="ID" type="numeric" required="yes">
    <cfargument name="wsStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully updated the records.">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE swweb.tbl_web_service SET
    wsStatus = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.wsStatus#">
    WHERE ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ID#">
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error updating the records.">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="updateWebServiceAttributeList" access="public" returntype="struct">
    <cfargument name="ID" type="numeric" required="yes">
    <cfargument name="wsaStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully updated the records.">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE swweb.tbl_web_service_attribute SET
    wsaStatus = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.wsaStatus#">
    WHERE ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ID#">
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error updating the records.">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="updateWebServiceUserList" access="public" returntype="struct">
    <cfargument name="ID" type="numeric" required="yes">
    <cfargument name="wsuStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully updated the records.">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE swweb.tbl_web_service_user SET
    wsuStatus = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.wsuStatus#">
    WHERE ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ID#">
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error updating the records.">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="updateWebServiceFormatList" access="public" returntype="struct">
    <cfargument name="ID" type="numeric" required="yes">
    <cfargument name="wsfStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully updated the records.">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE swweb.tbl_web_service_format SET
    wsfStatus = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.wsfStatus#">
    WHERE ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ID#">
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error updating the records.">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="updateWebServiceUserRelList" access="public" returntype="struct">
    <cfargument name="ID" type="numeric" required="yes">
    <cfargument name="wsurStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully updated the records.">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE swweb.tbl_web_service_user_rel SET
    wsurStatus = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.wsurStatus#">
    WHERE ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ID#">
    </cfquery>
    </cftransaction>
    <cfif wsurStatus EQ 1 OR wsurStatus EQ 2>
    <cfinvoke 
    component="MCMS.component.app.web_service.WebService"
    method="getWebServiceUserRel"
    returnvariable="getWebServiceUserRelRet">
    <cfinvokeargument name="ID" value="#ARGUMENTS.ID#"/>
    <cfinvokeargument name="wsurStatus" value="1,2"/>
    </cfinvoke>
    <cfinvoke 
    component="MCMS.component.utility.Email"
    method="sendEmail">
    <cfinvokeargument name="subject" value="Web Service Registration Complete"/>
    <cfinvokeargument name="to" value="#getWebServiceUserRelRet.wsuEmail#"/>
    <cfinvokeargument name="from" value="#application.noReplyEmail#"/>
    <cfinvokeargument name="ID" value="#ARGUMENTS.ID#"/>
    <cfinvokeargument name="emailTemplate" value="/#application.mcmsAppAdminPath#/web_service/view/inc_ws_registration_complete_email.cfm"/>
    <cfinvokeargument name="emailType" value="html"/>
    <cfinvokeargument name="type" value="admin"/>
    </cfinvoke>
    </cfif>
    <cfcatch type="any">
    <cfset result.message = "There was an error updating the records.">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="deleteWebService" access="public" returntype="struct">
    <cfargument name="ID" type="string" required="yes">
    <cfset result.message = "You have successfully deleted the record(s).">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    DELETE FROM swweb.tbl_web_service
    WHERE ID IN (<cfqueryparam cfsqltype="cf_sql_integer" list="yes" value="#ARGUMENTS.ID#">)
    </cfquery>
    </cftransaction>
    <cfinvoke 
    component="MCMS.component.app.web_service.WebService"
    method="deleteWebServiceAttributeRel"
    returnvariable="deleteWebServiceAttributeRelRet">
    <cfinvokeargument name="wsID" value="#ARGUMENTS.ID#"/>
    </cfinvoke>
    <cfinvoke 
    component="MCMS.component.app.web_service.WebService"
    method="deleteWebServiceUserRel"
    returnvariable="deleteWebServiceUserRelRet">
    <cfinvokeargument name="wsID" value="#ARGUMENTS.ID#"/>
    </cfinvoke>
    <cfcatch type="any">
    <cfset result.message = "There was an error deleting the record(s).">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="deleteWebServiceAttribute" access="public" returntype="struct">
    <cfargument name="ID" type="string" required="yes">
    <cfset result.message = "You have successfully deleted the record(s).">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    DELETE FROM swweb.tbl_web_service_attribute
    WHERE ID IN (<cfqueryparam cfsqltype="cf_sql_integer" list="yes" value="#ARGUMENTS.ID#">)
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error deleting the record(s).">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="deleteWebServiceUser" access="public" returntype="struct">
    <cfargument name="ID" type="string" required="yes">
    <cfset result.message = "You have successfully deleted the record(s).">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    DELETE FROM swweb.tbl_web_service_user
    WHERE ID IN (<cfqueryparam cfsqltype="cf_sql_integer" list="yes" value="#ARGUMENTS.ID#">)
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error deleting the record(s).">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction> 
    
    <cffunction name="deleteWebServiceFormat" access="public" returntype="struct">
    <cfargument name="ID" type="string" required="yes">
    <cfset result.message = "You have successfully deleted the record(s).">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    DELETE FROM swweb.tbl_web_service_format
    WHERE ID IN (<cfqueryparam cfsqltype="cf_sql_integer" list="yes" value="#ARGUMENTS.ID#">)
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error deleting the record(s).">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="deleteWebServiceFormatRel" access="public" returntype="struct">
    <cfargument name="ID" type="string" required="yes" default="0">
    <cfargument name="wsID" type="string" required="yes" default="0">
    <cfset result.message = "You have successfully deleted the record(s).">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    DELETE FROM tbl_web_service_format_rel
    WHERE ID IN (<cfqueryparam cfsqltype="cf_sql_integer" list="yes" value="#ARGUMENTS.ID#">)
    OR wsID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.wsID#">
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error deleting the record(s).">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>  
    
    <cffunction name="deleteWebServiceUserRel" access="public" returntype="struct">
    <cfargument name="ID" type="string" required="yes" default="0">
    <cfargument name="wsID" type="string" required="yes" default="0">
    <cfset result.message = "You have successfully deleted the record(s).">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    DELETE FROM swweb.tbl_web_service_user_rel
    WHERE ID IN (<cfqueryparam cfsqltype="cf_sql_integer" list="yes" value="#ARGUMENTS.ID#">)
    OR wsID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.wsID#">
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error deleting the record(s).">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="deleteWebServiceAttributeRel" access="public" returntype="struct">
    <cfargument name="ID" type="string" required="yes" default="0">
    <cfargument name="wsID" type="string" required="yes" default="0">
    <cfset result.message = "You have successfully deleted the record(s).">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    DELETE FROM swweb.tbl_web_service_attribute_rel
    WHERE ID IN (<cfqueryparam cfsqltype="cf_sql_integer" list="yes" value="#ARGUMENTS.ID#">)
    OR wsID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.wsID#">
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error deleting the record(s).">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="setWebServiceRegistration" access="public" returntype="struct" hint="Register users to a web service.">
    <cfargument name="wsID" type="numeric" required="yes" default="0">
    <cfargument name="wsuID" type="numeric" required="yes" default="0">
    <cfargument name="wsurDateExp" type="string" required="yes" default="">
    <cfargument name="wsurStatus" type="string" required="yes" default="">
    <cfset result.message = 'You have successfully submitted your request for registration. Please allow for up to 2 business days to have your request completed. You will be notified via email once your access has been approved/denied'>
    <cftry>
    <!--- Delete old relationship. --->
    <cfinvoke 
    component="MCMS.component.app.web_service.WebService"
    method="getWebServiceUserRel"
    returnvariable="getCheckWebServiceUserRelRet">
    <cfinvokeargument name="wsID" value="#ARGUMENTS.wsID#"/>
    <cfinvokeargument name="wsuID" value="#ARGUMENTS.wsuID#"/>
    <cfinvokeargument name="wsurStatus" value="1,2,3"/>
    </cfinvoke>
    <cfset var.wsurID = getCheckWebServiceUserRelRet.ID>
    <cfif var.wsurID NEQ "">
    <cfinvoke 
    component="MCMS.component.app.web_service.WebService"
    method="deleteWebServiceUserRel"
    returnvariable="deleteWebServiceUserRelRet">
    <cfinvokeargument name="ID" value="#var.wsurID#"/>
    </cfinvoke>
    </cfif>
    <cfinvoke 
    component="MCMS.component.app.web_service.WebService"
    method="insertWebServiceUserRel"
    returnvariable="insertWebServiceUserRelRet">
    <cfinvokeargument name="wsID" value="#ARGUMENTS.wsID#"/>
    <cfinvokeargument name="wsuID" value="#ARGUMENTS.wsuID#"/>
    <cfinvokeargument name="wsurDateExp" value="#ARGUMENTS.wsurDateExp#"/>
    <cfinvokeargument name="wsurStatus" value="#ARGUMENTS.wsurStatus#"/>
    </cfinvoke>
    <!---Get latest web service user id.--->
    <cfinvoke 
    component="MCMS.component.cms.Cms"
    method="getMaxValueSQL"
    returnvariable="wsurID">
    <cfinvokeargument name="tableName" value="tbl_web_service_user_rel"/>
    </cfinvoke>
    <cfset var.wsurID = wsurID>
    <cfcatch type="any">
    <cfset result.message = 'An error occured when inserting the Web Service User Rel. record.'>
    </cfcatch>
    </cftry>
    <!--- Send an email to the webmaster about the web service registration request.  --->
    <cftry>
    <cfinvoke 
    component="MCMS.component.utility.Email"
    method="sendEmail">
    <cfinvokeargument name="subject" value="Web Service Registration"/>
    <cfinvokeargument name="to" value="#application.webmasterEmail#"/>
    <cfinvokeargument name="from" value="#application.noReplyEmail#"/>
    <cfinvokeargument name="cc" value=""/>
    <cfinvokeargument name="bcc" value=""/>
    <cfinvokeargument name="body" value=""/>
    <cfinvokeargument name="ID" value="#var.wsurID#"/>
    <cfinvokeargument name="emailTemplate" value="/web_service/view/inc_ws_registration_admin_email.cfm"/>
    <cfinvokeargument name="emailType" value="html"/>
    <cfinvokeargument name="type" value="admin"/>
    </cfinvoke>
    <cfcatch type="any">
    <cfset result.message = 'An error occured when sending the Administrator the web service registration request.'>
    </cfcatch>
    </cftry>
    <!--- Send a comfirmation email to the web service registration requestee.  --->
    <cftry>
    <cfinvoke 
    component="MCMS.component.app.web_service.WebService"
    method="getWebServiceUserRel"
    returnvariable="getWebServiceUserRelRet">
    <cfinvokeargument name="ID" value="#var.wsurID#"/>
    <cfinvokeargument name="wsurStatus" value="3"/>
    </cfinvoke>
    <cfinvoke 
    component="MCMS.component.utility.Email"
    method="sendEmail">
    <cfinvokeargument name="subject" value="Web Service Registration Request"/>
    <cfinvokeargument name="to" value="#getWebServiceUserRelRet.wsuEmail#"/>
    <cfinvokeargument name="from" value="#application.noReplyEmail#"/>
    <cfinvokeargument name="cc" value=""/>
    <cfinvokeargument name="bcc" value=""/>
    <cfinvokeargument name="body" value=""/>
    <cfinvokeargument name="ID" value="#var.wsurID#"/>
    <cfinvokeargument name="emailTemplate" value="/web_service/view/inc_ws_registration_requestee_email.cfm"/>
    <cfinvokeargument name="emailType" value="html"/>
    <cfinvokeargument name="type" value="admin"/>
    </cfinvoke>
    <cfcatch type="any">
    <cfset result.message = 'An error occured when sending a comfirmation email to the web service registration requestee.'>
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction> 
    
    <cffunction name="setWebServiceExtension" access="public" returntype="struct" hint="Set web service extension.">
    <cfargument name="wsID" type="numeric" required="yes" default="0">
    <cfargument name="wsuID" type="numeric" required="yes" default="0">
    <cfargument name="wsurDateExp" type="string" required="yes" default="">
    <cfset result.message = 'You have successfully made an extension of #application.wsExpireDateExtension# days.'>    
    <!--- Send an email to the webmaster about the web service extension request.  --->
    <cftry>
    <cfinvoke 
    component="MCMS.component.app.web_service.WebService"
    method="updateWebServiceUserRelExp">
    <cfinvokeargument name="wsID" value="#ARGUMENTS.wsID#"/>
    <cfinvokeargument name="wsuID" value="#ARGUMENTS.wsuID#"/>
    <cfinvokeargument name="wsurDateExp" value="#ARGUMENTS.wsurDateExp#"/>
    </cfinvoke>
    <cfinvoke 
    component="MCMS.component.app.web_service.WebService"
    method="getWebServiceUserRel"
    returnvariable="getWebServiceUserRelRet">
    <cfinvokeargument name="wsID" value="#ARGUMENTS.wsID#"/>
    <cfinvokeargument name="wsuID" value="#ARGUMENTS.wsuID#"/>
    <cfinvokeargument name="wsurStatus" value="1,2,3"/>
    </cfinvoke>
    <cfset var.wsurID = getWebServiceUserRelRet.ID>
    <cfinvoke 
    component="MCMS.component.utility.Email"
    method="sendEmail">
    <cfinvokeargument name="subject" value="Web Service Extension"/>
    <cfinvokeargument name="to" value="#application.webmasterEmail#"/>
    <cfinvokeargument name="from" value="#application.noReplyEmail#"/>
    <cfinvokeargument name="cc" value=""/>
    <cfinvokeargument name="bcc" value=""/>
    <cfinvokeargument name="body" value=""/>
    <cfinvokeargument name="ID" value="#var.wsurID#"/>
    <cfinvokeargument name="emailTemplate" value="/web_service/view/inc_extension_admin_email.cfm"/>
    <cfinvokeargument name="emailType" value="html"/>
    <cfinvokeargument name="type" value="admin"/>
    </cfinvoke>
    <cfinvoke 
    component="MCMS.component.utility.Email"
    method="sendEmail">
    <cfinvokeargument name="subject" value="Web Service Extension"/>
    <cfinvokeargument name="to" value="#getWebServiceUserRelRet.wsuEmail#"/>
    <cfinvokeargument name="from" value="#application.noReplyEmail#"/>
    <cfinvokeargument name="cc" value=""/>
    <cfinvokeargument name="bcc" value=""/>
    <cfinvokeargument name="body" value=""/>
    <cfinvokeargument name="ID" value="#var.wsurID#"/>
    <cfinvokeargument name="emailTemplate" value="/web_service/view/inc_extension_requestee_email.cfm"/>
    <cfinvokeargument name="emailType" value="html"/>
    <cfinvokeargument name="type" value="admin"/>
    </cfinvoke>
    <cfcatch type="any">
    <cfset result.message = 'An error occured when sending the administrator the web service extension request.'>
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction> 
    
    <cffunction name="setSignIn" access="public" returntype="struct" hint="Authenticate users to web service site.">
    <cfargument name="wsuEmail" type="string" required="yes" default="">
    <cfargument name="wsuPassword" type="string" required="yes" default="">
    <cfargument name="accessDenied" type="string" required="yes" default="">
    <cfset result.status = true>
    <cfset result.message = 'You have successfully Signed In.'>
    <cftry>
    <cfquery name="rsSignIn" datasource="#application.mcmsDSN#">
    SELECT * FROM tbl_web_service_user
    WHERE 0=0 
    AND UPPER(wsuEmail) = <cfqueryparam value="#UCASE(ARGUMENTS.wsuEmail)#" cfsqltype="cf_sql_varchar">
    AND wsuPassword = <cfqueryparam value="#ARGUMENTS.wsuPassword#" cfsqltype="cf_sql_varchar">
    AND wsuStatus = <cfqueryparam value="1" cfsqltype="cf_sql_integer">
    </cfquery>
    <cfcatch type="any">
    <cfset result.status = false>
    <cfset result.message = 'An error occured when accessing the Web Service User record.'>
    </cfcatch>
    </cftry>
    <!---If the sign in was successful then proceed.--->    
    <cfif result.status EQ true AND rsSignIn.recordcount NEQ 0>
    <!---Get last time signed in.--->
    <cfset lastSignedIn = rsSignIn.wsuDateLast>
    <cfif (lastSignedIn IS "") OR (NOT IsDate(lastSignedIn))>
    <cfset lastSignedIn=CreateODBCDateTime(Now())>
    <cfelse>
    <cfset lastSignedIn=CreateODBCDateTime(lastSignedIn)>
    </cfif>
    <!--- Set the cookie/client vars --->
    <cfcookie name="wsuserID" value="#rsSignIn.ID#">
    <cfset session.signedIn = 'true'>
    <!--- Create SESSION variables. --->
    <!---SESSION user.--->
    <cfset session.userUsername = rsSignIn.wsuEmail>
    <cfset session.userName = rsSignIn.wsuFName & ' ' & rsSignIn.wsuLName>
    <cfset session.userID = rsSignIn.ID>
    <cfset session.lastSignedIn = lastSignedIn>
    <!--- Store username inside a COOKIE if required --->
    <cfif IsDefined("form.rememberUser")>
    <cfcookie name="wsUsername" value="#ARGUMENTS.wsuEmail#" expires="never">
    <!--- Else, clean any existing COOKIE --->
    <cfelse>
    <cfcookie name="wsUsername" value="" expires="now">
    </cfif>
    <!--- Update user sign-in date --->
    <cftry>
    <cfinvoke 
    component="MCMS.component.app.web_service.WebService"
    method="updateSignIn">
    <cfinvokeargument name="wsuDateHistory" value="#lastSignedIn#"/>
    <cfinvokeargument name="wsuDateLast" value="#CreateODBCDateTime(Now())#"/>
    <cfinvokeargument name="wsuEmail" value="#session.userUsername#"/>
    <cfinvokeargument name="wsuPassword" value="#ARGUMENTS.wsuPassword#"/>
    </cfinvoke>
    <cfcatch type="any">
    <cfset result.status = false>
    <cfset result.message = 'An error occured when accessing the Update Web Service User Sign In record.'>
    </cfcatch>
    </cftry>
    <!---Redirect to path requested if authentication is successful.--->
    <cflocation url="#ARGUMENTS.accessDenied#" addtoken="no">
    <cfelse>
    <cfset result.status = false>
    <cfset result.message = 'You have not successfully Signed In. Please try again or click the "Retrieve Password" option to have your sign in information sent to your email.'>
    </cfif>
    <cfreturn result>
    </cffunction> 
    
    <cffunction name="updateSignIn" access="public">
    <cfargument name="wsuDateHistory" type="date" required="yes">
    <cfargument name="wsuDateLast" type="date" required="yes">
    <cfargument name="wsuEmail" type="string" required="yes">
    <cfargument name="wsuPassword" type="string" required="yes">
    <cfset result.message = "You have successfully updated the record.">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_web_service_user SET
    wsuDateHistory = <cfqueryparam cfsqltype="cf_sql_timestamp" value="#ARGUMENTS.wsuDateHistory#">,
    wsuDateLast = <cfqueryparam cfsqltype="cf_sql_timestamp" value="#ARGUMENTS.wsuDateLast#">,
    wsuPassword = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.wsuPassword#">
    WHERE UPPER(wsuEmail) = <cfqueryparam cfsqltype="cf_sql_varchar" value="#UCASE(ARGUMENTS.wsuEmail)#">
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error updating the record.">
    
    </cfcatch>
    </cftry>
    <cfreturn true>
    </cffunction>
    
    <cffunction name="updateWebServiceUserRelExp" access="public">
    <cfargument name="wsID" type="numeric" required="yes" default="0">
    <cfargument name="wsuID" type="numeric" required="yes" default="0">
    <cfargument name="wsurDateExp" type="string" required="yes" default="">
    <cfset result.message = "You have successfully updated the record.">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_web_service_user_rel SET
    wsurDateExp = <cfqueryparam cfsqltype="cf_sql_date" value="#ARGUMENTS.wsurDateExp#">
    WHERE wsID = <cfqueryparam cfsqltype="cf_sql_numeric" value="#ARGUMENTS.wsID#">
    AND wsuID = <cfqueryparam cfsqltype="cf_sql_numeric" value="#ARGUMENTS.wsuID#">
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error updating the record.">
    
    </cfcatch>
    </cftry>
    <cfreturn true>
    </cffunction>
    
    <cffunction name="getRetrieveSignIn" access="public" returntype="struct" hint="Retrieve web service user password and send email.">
    <!---This method will only function with basic authetication.--->
    <cfargument name="wsuEmail" type="string" required="yes" default="">
	<cfset var rsRetrieveSignIn = "">
    <cfset result.message = 'Your sign in information was successfully sent to your email. You should receive it shortly.'>
    <cftry>
    <cfquery name="rsRetrieveSignIn" datasource="#application.mcmsDSN#">
    SELECT * FROM tbl_web_service_user
    WHERE 0=0 
    AND UPPER(wsuEmail) = <cfqueryparam value="#UCASE(ARGUMENTS.wsuEmail)#" cfsqltype="cf_sql_varchar">
    AND wsuStatus = <cfqueryparam value="1" cfsqltype="cf_sql_integer">
    </cfquery>
    <cfif rsRetrieveSignIn.recordcount NEQ 0>
    <cfset result.status = true>
    <!---Create the body of the message.--->
    <cfsavecontent variable="body">
    <cfoutput>
    #rsRetrieveSignIn.wsuFName# #rsRetrieveSignIn.wsuLName#, you recently requested your Web Service Sign In information.<br/><br/>
    Username: #rsRetrieveSignIn.wsuEmail#.<br/>
    Password: #rsRetrieveSignIn.wsuPassword#.<br/><br/>
    <a href="http://#CGI.HTTP_HOST#/web_service/">Sign In Now!</a>
    </cfoutput> 
    </cfsavecontent>
    <!---Send the email.--->
    <cfinvoke 
    component="MCMS.component.utility.Email"
    method="sendEmail">
    <cfinvokeargument name="subject" value="Retrieve Sign In"/>
    <cfinvokeargument name="to" value="#ARGUMENTS.wsuEmail#"/>
    <cfinvokeargument name="from" value="#application.noReplyEmail#"/>
    <cfinvokeargument name="body" value="#body#"/>
    </cfinvoke>
    <cfelse>
    <cfset result.message = 'The email address you have entered does not match any records in our system. Please try again.'>
    </cfif>
    <cfcatch type="any">
    <cfset result.message = 'An error occured when accessing the Web Service User record.'>
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>     
</cfcomponent>    
    