<cfcomponent>
    <cffunction name="getHDTicket" access="public" returntype="query" hint="Get Help Desk Ticket data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="ID" type="numeric" required="yes" default="0">
    <cfargument name="excludeID" type="numeric" required="yes" default="0">
    <cfargument name="siteNo" type="string" required="yes" default="100">
    <cfargument name="deptNo" type="string" required="yes" default="0">
    <cfargument name="hdtName" type="string" required="yes" default="">
    <cfargument name="hdtDateOpen" type="string" required="yes" default="None">
    <cfargument name="hdtDateClose" type="string" required="yes" default="None">
    <cfargument name="hdtKnowledgebase" type="numeric" required="yes" default="0">
    <cfargument name="hdcID" type="numeric" required="yes" default="0">
    <cfargument name="hdttID" type="string" required="yes" default="0">
    <cfargument name="hdsID" type="string" required="yes" default="0">
    <cfargument name="userID" type="numeric" required="yes" default="0">
    <cfargument name="hdtStatus" type="string" required="yes" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="hdtDateOpen DESC">
    <cfset var rsHDTicket = "" >
    <cftry>
    <!---Search for tickets assigned to other users.--->
    <cfif ARGUMENTS.userID NEQ 0>
    <cfinvoke 
    component="MCMS.component.app.help_desk.HelpDesk"
    method="getHDTicketUserRel"
    returnvariable="getHDTicketUserRelRet">
    <cfinvokeargument name="keywords" value="#ARGUMENTS.keywords#"/>
    <cfinvokeargument name="userID" value="#ARGUMENTS.userID#"/>
    <cfinvokeargument name="hdsID" value="#ARGUMENTS.hdsID#"/>
    <cfinvokeargument name="hdturStatus" value="#ARGUMENTS.hdtStatus#"/>
    <cfinvokeargument name="orderBy" value="hdtID"/>
    </cfinvoke>
    <cfif getHDTicketUserRelRet.recordcount NEQ 0>
    <cfset this.hdtIDList = ValueList(getHDTicketUserRelRet.hdtID)>
    <cfelse>
    <cfset this.hdtIDList = 0>
    </cfif>
    <cfelse>
    <cfset this.hdtIDList = 0>
    </cfif>
    <cfquery name="rsHDTicket" datasource="#application.mcmsDSN#">
    SELECT * FROM v_hd_ticket WHERE 0=0
    <cfif ARGUMENTS.ID NEQ 0>
    AND ID = <cfqueryparam value="#ARGUMENTS.ID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif this.hdtIDList NEQ 0>
    AND (ID IN (<cfqueryparam value="#this.hdtIDList#" list="yes" cfsqltype="cf_sql_integer">) OR userID = <cfqueryparam value="#ARGUMENTS.userID#" cfsqltype="cf_sql_integer">)
    </cfif>
    <cfif ARGUMENTS.excludeID NEQ 0>
    AND ID <> <cfqueryparam value="#ARGUMENTS.excludeID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(hdtLName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(hdtFName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(userLName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(userFName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(siteName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(hdtDescription) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(hdtInitialWorkLog) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR ID LIKE <cfqueryparam value="#ARGUMENTS.keywords#" cfsqltype="cf_sql_varchar">)
    </cfif>
    <cfif ARGUMENTS.siteNo NEQ 100>
    AND siteNo IN (<cfqueryparam value="#ARGUMENTS.siteNo#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
	<cfif ARGUMENTS.deptNo NEQ 0>
    AND deptNo IN (<cfqueryparam value="#ARGUMENTS.deptNo#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    <cfif ARGUMENTS.hdtName NEQ "">
    AND UPPER(hdtName) = <cfqueryparam value="#UCASE(ARGUMENTS.hdtName)#" cfsqltype="cf_sql_varchar">
    </cfif>
    <cfif ARGUMENTS.hdtDateOpen NEQ "None" AND ARGUMENTS.hdtDateOpen NEQ "" AND ARGUMENTS.hdtDateClose NEQ "None" AND ARGUMENTS.hdtDateClose NEQ "">
    AND (hdtDateOpen >= <cfqueryparam value="#ARGUMENTS.hdtDateOpen#" cfsqltype="cf_sql_timestamp"> AND hdtDateClose <= <cfqueryparam value="#ARGUMENTS.hdtDateClose#" cfsqltype="cf_sql_timestamp">)
    <cfelse>
    <cfif ARGUMENTS.hdtDateOpen NEQ "None" AND ARGUMENTS.hdtDateOpen NEQ "">
    AND hdtDateOpen >= <cfqueryparam value="#ARGUMENTS.hdtDateOpen#" cfsqltype="cf_sql_timestamp">
    </cfif>
    <cfif ARGUMENTS.hdtDateClose NEQ "None" AND ARGUMENTS.hdtDateClose NEQ "">
    AND hdtDateClose <= <cfqueryparam value="#ARGUMENTS.hdtDateClose#" cfsqltype="cf_sql_timestamp">
    </cfif>
    </cfif>
    <cfif ARGUMENTS.hdtKnowledgebase NEQ 0>
    AND hdtKnowledgebase = <cfqueryparam value="#ARGUMENTS.hdtKnowledgebase#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.hdcID NEQ 0>
    AND hdcID = <cfqueryparam value="#ARGUMENTS.hdcID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.hdttID NEQ 0>
    AND hdttID = <cfqueryparam value="#ARGUMENTS.hdttID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.hdsID NEQ 0>
    AND hdsID = <cfqueryparam value="#ARGUMENTS.hdsID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.userID NEQ 0 AND this.hdtIDList EQ 0>
    AND userID = <cfqueryparam value="#ARGUMENTS.userID#" cfsqltype="cf_sql_integer">
    </cfif>
    AND hdtStatus IN (<cfqueryparam value="#ARGUMENTS.hdtStatus#" list="yes" cfsqltype="cf_sql_integer">)
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsHDTicket = StructNew()>
    <cfset rsHDTicket.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsHDTicket>
    </cffunction>
    
    <cffunction name="getHDTicketType" access="public" returntype="query" hint="Get Help Desk Ticket Type data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="ID" type="numeric" required="yes" default="0">
    <cfargument name="excludeID" type="numeric" required="yes" default="0">
    <cfargument name="deptNo" type="numeric" required="yes" default="0">
    <cfargument name="hdttStatus" type="string" required="yes" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="hdttName">
    <cfset var rsHDTicketType = "" >
    <cftry>
    <cfquery name="rsHDTicketType" datasource="#application.mcmsDSN#">
    SELECT * FROM v_hd_ticket_type WHERE 0=0
    <cfif ARGUMENTS.ID NEQ 0>
    AND ID = <cfqueryparam value="#ARGUMENTS.ID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.excludeID NEQ 0>
    AND ID <> <cfqueryparam value="#ARGUMENTS.excludeID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND UPPER(hdttName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">
    </cfif>
    <cfif ARGUMENTS.deptNo NEQ 0>
    AND deptNo = <cfqueryparam value="#ARGUMENTS.deptNo#" cfsqltype="cf_sql_integer">
    </cfif>
    AND hdttStatus IN (<cfqueryparam value="#ARGUMENTS.hdttStatus#" list="yes" cfsqltype="cf_sql_integer">)
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsHDTicketType = StructNew()>
    <cfset rsHDTicketType.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsHDTicketType>
    </cffunction>
    
    <cffunction name="getHDCategory" access="public" returntype="query" hint="Get Help Desk Category data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="ID" type="numeric" required="yes" default="0">
    <cfargument name="excludeID" type="numeric" required="yes" default="0">
    <cfargument name="hdcName" type="string" required="yes" default="">
    <cfargument name="hdttID" type="numeric" required="yes" default="0">
    <cfargument name="hdcStatus" type="string" required="yes" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="hdcName">
    <cfset var rsHDCategory = "" >
    <cftry>
    <cfquery name="rsHDCategory" datasource="#application.mcmsDSN#">
    SELECT * FROM v_hd_category WHERE 0=0
    <cfif ARGUMENTS.ID NEQ 0>
    AND ID = <cfqueryparam value="#ARGUMENTS.ID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.excludeID NEQ 0>
    AND ID <> <cfqueryparam value="#ARGUMENTS.excludeID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND UPPER(hdcName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">
    </cfif>
    <cfif ARGUMENTS.hdcName NEQ ''>
    AND UPPER(hdcName) = <cfqueryparam value="#UCASE(ARGUMENTS.hdcName)#" cfsqltype="cf_sql_varchar">
    </cfif>
    <cfif ARGUMENTS.hdttID NEQ 0>
    AND hdttID = <cfqueryparam value="#ARGUMENTS.hdttID#" cfsqltype="cf_sql_integer">
    </cfif>
    AND hdcStatus IN (<cfqueryparam value="#ARGUMENTS.hdcStatus#" list="yes" cfsqltype="cf_sql_integer">)
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsHDCategory = StructNew()>
    <cfset rsHDCategory.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsHDCategory>
    </cffunction>
    
    <cffunction name="getHDSecCategory" access="public" returntype="query" hint="Get Help Desk Sec. Category data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="ID" type="numeric" required="yes" default="0">
    <cfargument name="excludeID" type="numeric" required="yes" default="0">
    <cfargument name="hdscName" type="string" required="yes" default="">
    <cfargument name="hdcID" type="numeric" required="yes" default="0">
    <cfargument name="hdscStatus" type="string" required="yes" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="hdscSort, hdscName">
    <cfset var rsHDSecCategory = "" >
    <cftry>
    <cfquery name="rsHDSecCategory" datasource="#application.mcmsDSN#">
    SELECT * FROM v_hd_sec_category WHERE 0=0
    <cfif ARGUMENTS.ID NEQ 0>
    AND ID = <cfqueryparam value="#ARGUMENTS.ID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.excludeID NEQ 0>
    AND ID <> <cfqueryparam value="#ARGUMENTS.excludeID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND UPPER(hdscName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">
    </cfif>
    <cfif ARGUMENTS.hdscName NEQ ''>
    AND UPPER(hdscName) = <cfqueryparam value="#UCASE(ARGUMENTS.hdscName)#" cfsqltype="cf_sql_varchar">
    </cfif>
    <cfif ARGUMENTS.hdcID NEQ 0>
    AND hdcID = <cfqueryparam value="#ARGUMENTS.hdcID#" cfsqltype="cf_sql_integer">
    </cfif>
    AND hdscStatus IN (<cfqueryparam value="#ARGUMENTS.hdscStatus#" list="yes" cfsqltype="cf_sql_integer">)
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsHDSecCategory = StructNew()>
    <cfset rsHDSecCategory.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsHDSecCategory>
    </cffunction>
    
    <cffunction name="getHDCategoryBind" access="remote" returntype="any" hint="Get Help Desk Category binded data.">
    <cfargument name="ID" type="string" required="yes" default="0">
    <cfargument name="dsn" type="string" required="yes" default="swweb">
    <cfargument name="orderBy" type="string" required="yes" default="hdcName">
    <cftry>
    <cfset data = ''>
	<cfset result = ArrayNew(2)>
    <cfset i = 0>
    <cfquery name="data" datasource="#ARGUMENTS.dsn#">
    SELECT * FROM tbl_hd_category WHERE 0=0
    <cfif ARGUMENTS.ID NEQ 0 AND IsNumeric(ARGUMENTS.ID)>
    AND hdttID = <cfqueryparam value="#ARGUMENTS.ID#" cfsqltype="cf_sql_integer">
    <cfelse>
    AND 0=1
    </cfif>
    AND hdcStatus IN (<cfqueryparam value="1,3" list="yes" cfsqltype="cf_sql_integer">)
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <cfif data.RecordCount NEQ 0>
    <cfloop index="i" from="1" to="#data.RecordCount#">
    <cfif i EQ 1>
    <cfset result[i][1] = ''>
    <cfset result[i][2] = 'Select a Category'>
    </cfif>
	<cfset result[i+1][1] = data.ID[i]>
    <cfset result[i+1][2] = data.hdcName[i]>
    </cfloop>
    </cfif>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsHDCategoryBind = StructNew()>
    <cfset rsHDCategoryBind.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="getHDSecCategoryBind" access="remote" returntype="any" hint="Get Help Desk Sec. Category binded data.">
    <cfargument name="ID" type="string" required="yes" default="0">
    <cfargument name="dsn" type="string" required="no" default="swweb">
    <cfargument name="orderBy" type="string" required="yes" default="hdscName">
    <cftry>
    <cfset data = ''>
    <cfset result = ArrayNew(2)>
    <cfset i = 0>
    <cfquery name="data" datasource="#ARGUMENTS.dsn#">
    SELECT * FROM tbl_hd_sec_category WHERE 0=0
    <cfif ARGUMENTS.ID NEQ 0 AND IsNumeric(ARGUMENTS.ID)>
    AND hdcID = <cfqueryparam value="#ARGUMENTS.ID#" cfsqltype="cf_sql_integer">
    <cfelse>
    AND 0=1
    </cfif>
    AND hdscStatus IN (<cfqueryparam value="1,3" list="yes" cfsqltype="cf_sql_integer">)
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <cfif data.RecordCount EQ 0>
    <cfset result[1][1] = ''>
    <cfset result[1][2] = 'Select a Category first.'>
    <cfelse>
    <cfloop index="i" from="1" to="#data.RecordCount#">
    <cfif i EQ 1>
    <cfset result[i][1] = ''>
    <cfset result[i][2] = 'Select a Sec. Category'>
    </cfif>
	<cfset result[i+1][1] = data.ID[i]>
    <cfset result[i+1][2] = data.hdscName[i]>
    </cfloop>
    </cfif>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsHDCategoryBind = StructNew()>
    <cfset rsHDCategoryBind.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="getHDPriority" access="public" returntype="query" hint="Get Help Desk Priority data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="ID" type="numeric" required="yes" default="0">
    <cfargument name="excludeID" type="numeric" required="yes" default="0">
    <cfargument name="hdpName" type="string" required="yes" default="">
    <cfargument name="hdpStatus" type="string" required="yes" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="hdpName">
    <cfset var rsHDPriority = "" >
    <cftry>
    <cfquery name="rsHDPriority" datasource="#application.mcmsDSN#">
    SELECT * FROM v_hd_priority WHERE 0=0
    <cfif ARGUMENTS.ID NEQ 0>
    AND ID = <cfqueryparam value="#ARGUMENTS.ID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.excludeID NEQ 0>
    AND ID <> <cfqueryparam value="#ARGUMENTS.excludeID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND UPPER(hdpName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">
    </cfif>
    <cfif ARGUMENTS.hdpName NEQ ''>
    AND UPPER(hdpName) = <cfqueryparam value="#UCASE(ARGUMENTS.hdpName)#" cfsqltype="cf_sql_varchar">
    </cfif>
    AND hdpStatus IN (<cfqueryparam value="#ARGUMENTS.hdpStatus#" list="yes" cfsqltype="cf_sql_integer">)
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsHDPriority = StructNew()>
    <cfset rsHDPriority.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsHDPriority>
    </cffunction>
    
    <cffunction name="getHDRating" access="public" returntype="query" hint="Get Help Desk Rating data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="ID" type="numeric" required="yes" default="0">
    <cfargument name="excludeID" type="numeric" required="yes" default="0">
    <cfargument name="hdrName" type="string" required="yes" default="">
    <cfargument name="hdrStatus" type="string" required="yes" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="hdrSort, ID">
    <cfset var rsHDRating = "" >
    <cftry>
    <cfquery name="rsHDRating" datasource="#application.mcmsDSN#">
    SELECT * FROM tbl_hd_rating WHERE 0=0
    <cfif ARGUMENTS.ID NEQ 0>
    AND ID = <cfqueryparam value="#ARGUMENTS.ID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.excludeID NEQ 0>
    AND ID <> <cfqueryparam value="#ARGUMENTS.excludeID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND UPPER(hdrName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">
    </cfif>
    <cfif ARGUMENTS.hdrName NEQ ''>
    AND UPPER(hdrName) = <cfqueryparam value="#UCASE(ARGUMENTS.hdrName)#" cfsqltype="cf_sql_varchar">
    </cfif>
    AND hdrStatus IN (<cfqueryparam value="#ARGUMENTS.hdrStatus#" list="yes" cfsqltype="cf_sql_integer">)
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsHDRating = StructNew()>
    <cfset rsHDRating.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsHDRating>
    </cffunction>
    
    <cffunction name="getHDStatus" access="public" returntype="query" hint="Get Help Desk Status data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="ID" type="numeric" required="yes" default="0">
    <cfargument name="excludeID" type="numeric" required="yes" default="0">
    <cfargument name="hdsName" type="string" required="yes" default="">
    <cfargument name="hdsStatus" type="string" required="yes" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="hdsName">
    <cfset var rsHDStatus = "" >
    <cftry>
    <cfquery name="rsHDStatus" datasource="#application.mcmsDSN#">
    SELECT * FROM v_hd_status WHERE 0=0
    <cfif ARGUMENTS.ID NEQ 0>
    AND ID = <cfqueryparam value="#ARGUMENTS.ID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.excludeID NEQ 0>
    AND ID <> <cfqueryparam value="#ARGUMENTS.excludeID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND UPPER(hdsName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">
    </cfif>
    <cfif ARGUMENTS.hdsName NEQ ''>
    AND UPPER(hdsName) = <cfqueryparam value="#UCASE(ARGUMENTS.hdsName)#" cfsqltype="cf_sql_varchar">
    </cfif>
    AND hdsStatus IN (<cfqueryparam value="#ARGUMENTS.hdsStatus#" list="yes" cfsqltype="cf_sql_integer">)
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsHDStatus = StructNew()>
    <cfset rsHDStatus.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsHDStatus>
    </cffunction>
    
    <cffunction name="getHDTicketTypeUserRoleRel" access="public" returntype="query" hint="Get Help Desk Ticket Type User Role Rel. data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="ID" type="numeric" required="yes" default="0">
    <cfargument name="excludeID" type="numeric" required="yes" default="0">
    <cfargument name="hdttID" type="numeric" required="yes" default="0">
    <cfargument name="urID" type="string" required="yes" default="0">
    <cfargument name="hdtturrStatus" type="string" required="yes" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="hdttName">
    <cfset var rsHDTicketTypeUserRoleRel = "" >
    <cftry>
    <cfquery name="rsHDTicketTypeUserRoleRel" datasource="#application.mcmsDSN#">
    SELECT * FROM v_hdt_type_user_role_rel WHERE 0=0
    <cfif ARGUMENTS.ID NEQ 0>
    AND ID = <cfqueryparam value="#ARGUMENTS.ID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.excludeID NEQ 0>
    AND ID <> <cfqueryparam value="#ARGUMENTS.excludeID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(urName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(hdttName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">)
    </cfif>
    <cfif ARGUMENTS.hdttID NEQ 0>
    AND hdttID = <cfqueryparam value="#ARGUMENTS.hdttID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.urID NEQ 0>
    AND urID IN (<cfqueryparam value="#ARGUMENTS.urID#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    AND hdtturrStatus IN (<cfqueryparam value="#ARGUMENTS.hdtturrStatus#" list="yes" cfsqltype="cf_sql_integer">)
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsHDTicketTypeUserRoleRel = StructNew()>
    <cfset rsHDTicketTypeUserRoleRel.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsHDTicketTypeUserRoleRel>
    </cffunction>
    
    <cffunction name="getHDTicketUserRel" access="public" returntype="query" hint="Get Help Desk Ticket User Rel. data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="ID" type="numeric" required="yes" default="0">
    <cfargument name="excludeID" type="numeric" required="yes" default="0">
    <cfargument name="hdtID" type="numeric" required="yes" default="0">
    <cfargument name="userID" type="string" required="yes" default="0">
    <cfargument name="hdsID" type="numeric" required="yes" default="0">
    <cfargument name="hdturStatus" type="string" required="yes" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="userLName">
    <cfset var rsHDTicketUserRel = "" >
    <cftry>
    <cfquery name="rsHDTicketUserRel" datasource="#application.mcmsDSN#">
    SELECT * FROM v_hd_ticket_user_rel WHERE 0=0
    <cfif ARGUMENTS.ID NEQ 0>
    AND ID = <cfqueryparam value="#ARGUMENTS.ID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.excludeID NEQ 0>
    AND ID <> <cfqueryparam value="#ARGUMENTS.excludeID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND UPPER(userLName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">
    </cfif>
    <cfif ARGUMENTS.hdtID NEQ 0>
    AND hdtID = <cfqueryparam value="#ARGUMENTS.hdtID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.userID NEQ 0>
    AND userID IN (<cfqueryparam value="#ARGUMENTS.userID#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    <cfif ARGUMENTS.hdsID NEQ 0>
    AND hdsID = <cfqueryparam value="#ARGUMENTS.hdsID#" cfsqltype="cf_sql_integer">
    </cfif>
    AND hdturStatus IN (<cfqueryparam value="#ARGUMENTS.hdturStatus#" list="yes" cfsqltype="cf_sql_integer">)
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsHDTicketUserRel = StructNew()>
    <cfset rsHDTicketUserRel.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsHDTicketUserRel>
    </cffunction>
    
    <cffunction name="getHDTicketDocumentRel" access="public" returntype="query" hint="Get Help Desk Ticket Document Rel. data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="ID" type="numeric" required="yes" default="0">
    <cfargument name="excludeID" type="numeric" required="yes" default="0">
    <cfargument name="hdtID" type="string" required="yes" default="0">
    <cfargument name="docID" type="numeric" required="yes" default="0">
    <cfargument name="hdtdrStatus" type="string" required="yes" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="docName">
    <cfset var rsHDTicketDocumentRel = "" >
    <cftry>
    <cfquery name="rsHDTicketDocumentRel" datasource="#application.mcmsDSN#">
    SELECT * FROM v_hd_ticket_document_rel WHERE 0=0
    <cfif ARGUMENTS.ID NEQ 0>
    AND ID = <cfqueryparam value="#ARGUMENTS.ID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.excludeID NEQ 0>
    AND ID <> <cfqueryparam value="#ARGUMENTS.excludeID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(docName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(hdtLName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(hdtFName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">)
    </cfif>
    <cfif ARGUMENTS.hdtID NEQ 0>
    AND hdtID IN (<cfqueryparam value="#ARGUMENTS.hdtID#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    <cfif ARGUMENTS.docID NEQ 0>
    AND docID = <cfqueryparam value="#ARGUMENTS.docID#" cfsqltype="cf_sql_integer">
    </cfif>
    AND hdtdrStatus IN (<cfqueryparam value="#ARGUMENTS.hdtdrStatus#" list="yes" cfsqltype="cf_sql_integer">)
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsHDTicketDocumentRel = StructNew()>
    <cfset rsHDTicketDocumentRel.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsHDTicketDocumentRel>
    </cffunction>
    
    <cffunction name="getHDTicketImageRel" access="public" returntype="query" hint="Get Help Desk Ticket Image Rel. data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="ID" type="numeric" required="yes" default="0">
    <cfargument name="excludeID" type="numeric" required="yes" default="0">
    <cfargument name="hdtID" type="string" required="yes" default="0">
    <cfargument name="imgID" type="numeric" required="yes" default="0">
    <cfargument name="hdtirStatus" type="string" required="yes" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="imgName">
    <cfset var rsHDTicketImageRel = "" >
    <cftry>
    <cfquery name="rsHDTicketImageRel" datasource="#application.mcmsDSN#">
    SELECT * FROM v_hd_ticket_image_rel WHERE 0=0
    <cfif ARGUMENTS.ID NEQ 0>
    AND ID = <cfqueryparam value="#ARGUMENTS.ID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.excludeID NEQ 0>
    AND ID <> <cfqueryparam value="#ARGUMENTS.excludeID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(imgName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(hdtLName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(hdtFName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">)
    </cfif>
    <cfif ARGUMENTS.hdtID NEQ 0>
    AND hdtID IN (<cfqueryparam value="#ARGUMENTS.hdtID#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    <cfif ARGUMENTS.imgID NEQ 0>
    AND imgID = <cfqueryparam value="#ARGUMENTS.imgID#" cfsqltype="cf_sql_integer">
    </cfif>
    AND hdtirStatus IN (<cfqueryparam value="#ARGUMENTS.hdtirStatus#" list="yes" cfsqltype="cf_sql_integer">)
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsHDTicketImageRel = StructNew()>
    <cfset rsHDTicketImageRel.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsHDTicketImageRel>
    </cffunction>
    
    <cffunction name="getHDWorkLog" access="public" returntype="query" hint="Get Help Desk Work Log data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="ID" type="numeric" required="yes" default="0">
    <cfargument name="excludeID" type="numeric" required="yes" default="0">
    <cfargument name="hdtName" type="string" required="yes" default="">
    <cfargument name="hdtID" type="string" required="yes" default="0">
    <cfargument name="hdwlStatus" type="string" required="yes" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="hdwlDate">
    <cfset var rsHDWorkLog = "" >
    <cftry>
    <cfquery name="rsHDWorkLog" datasource="#application.mcmsDSN#">
    SELECT * FROM v_hd_work_log WHERE 0=0
    <cfif ARGUMENTS.ID NEQ 0>
    AND ID = <cfqueryparam value="#ARGUMENTS.ID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.excludeID NEQ 0>
    AND ID <> <cfqueryparam value="#ARGUMENTS.excludeID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(hdtName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(hdwlDescription) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">)
    </cfif>
    <cfif ARGUMENTS.hdtName NEQ "">
    AND UPPER(hdtName) = <cfqueryparam value="#UCASE(ARGUMENTS.hdtName)#" cfsqltype="cf_sql_varchar">
    </cfif>
    <cfif ARGUMENTS.hdtID NEQ 0>
    AND hdtID = <cfqueryparam value="#ARGUMENTS.hdtID#" cfsqltype="cf_sql_integer">
    </cfif>
    AND hdwlStatus IN (<cfqueryparam value="#ARGUMENTS.hdwlStatus#" list="yes" cfsqltype="cf_sql_integer">)
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsHDWorkLog = StructNew()>
    <cfset rsHDWorkLog.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsHDWorkLog>
    </cffunction>
    
    <cffunction name="getHDTicketReport" access="public" returntype="query" hint="Get Help Desk Ticket Report data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="siteNo" type="string" required="yes" default="100">
    <cfargument name="deptNo" type="string" required="yes" default="0">
    <cfargument name="args" type="string" required="yes" default="0"> 
    <cfargument name="hdtStatus" type="string" required="yes" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="hdtDateOpen DESC">
    <cfset var rsHDTicketReport = "" >
    <!---<cftry>
    Search for tickets assigned to other users.--->
    <cfif ListGetAt(ARGUMENTS.args, 1) NEQ 0>
    <cfinvoke 
    component="MCMS.component.app.help_desk.HelpDesk"
    method="getHDTicketUserRel"
    returnvariable="getHDTicketUserRelRet">
    <cfinvokeargument name="keywords" value="#ARGUMENTS.keywords#"/>
    <cfinvokeargument name="userID" value="#ListGetAt(ARGUMENTS.args, 1)#"/>
    <cfinvokeargument name="hdsID" value="#ListGetAt(ARGUMENTS.args,3)#"/>
    <cfinvokeargument name="hdturStatus" value="#ARGUMENTS.hdtStatus#"/>
    <cfinvokeargument name="orderBy" value="hdtID"/>
    </cfinvoke>
    <cfif getHDTicketUserRelRet.recordcount NEQ 0>
    <cfset this.hdtIDList = ValueList(getHDTicketUserRelRet.hdtID)>
    <cfelse>
    <cfset this.hdtIDList = 0>
    </cfif>
    <cfelse>
    <cfset this.hdtIDList = 0>
    </cfif>
    <cfquery name="rsHDTicketReport" datasource="#application.mcmsDSN#">
    SELECT ID AS Ticket_No, hdtFName || ' ' || hdtLName AS Name, TO_CHAR(hdtDateOpen, 'MM/DD/YYYY HH24:MI:SS') AS Date_Open, TO_CHAR(hdtDateClose, 'MM/DD/YYYY HH24:MI:SS') AS Date_Close, TO_CHAR(hdtDescription) AS Description, siteNo, siteName AS Site, deptNo, deptName As Department, userFName || ' ' || userLName AS Owner, userEmail AS Owner_Email, hdcName AS Category, hdscName AS Sec_Category, hdttName AS Type, hdpName AS Priority, hdsName AS Ticket_Status, sName AS Status FROM v_hd_ticket WHERE 0=0
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(hdtLName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(hdtFName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(userLName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(userFName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(siteName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(hdtDescription) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR ID LIKE <cfqueryparam value="#ARGUMENTS.keywords#" cfsqltype="cf_sql_varchar">)
    </cfif>
    <cfif this.hdtIDList NEQ 0>
    AND (ID IN (<cfqueryparam value="#this.hdtIDList#" list="yes" cfsqltype="cf_sql_integer">) OR userID = <cfqueryparam value="#ListGetAt(ARGUMENTS.args, 1)#" cfsqltype="cf_sql_integer">)
    </cfif>
	<cfif ARGUMENTS.siteNo NEQ 100>
    AND siteNo IN (<cfqueryparam value="#ARGUMENTS.siteNo#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    <cfif ARGUMENTS.deptNo NEQ 0>
    AND deptNo IN (<cfqueryparam value="#ARGUMENTS.deptNo#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    <cfif ListGetAt(ARGUMENTS.args, 4) NEQ "None" AND ListGetAt(ARGUMENTS.args, 5) NEQ "None">
    AND (hdtDateOpen >= <cfqueryparam value="#ListGetAt(ARGUMENTS.args, 4)#" cfsqltype="cf_sql_timestamp"> AND hdtDateClose <= <cfqueryparam value="#ListGetAt(ARGUMENTS.args, 5)#" cfsqltype="cf_sql_timestamp">)
    <cfelse>
    <cfif ListGetAt(ARGUMENTS.args, 4) NEQ "None">
    AND hdtDateOpen >= <cfqueryparam value="#ListGetAt(ARGUMENTS.args, 4)#" cfsqltype="cf_sql_timestamp">
    </cfif>
    <cfif ListGetAt(ARGUMENTS.args, 5) NEQ "None">
    AND hdtDateClose <= <cfqueryparam value="#ListGetAt(ARGUMENTS.args, 5)#" cfsqltype="cf_sql_timestamp">
    </cfif>
    </cfif>
    <cfif ListGetAt(ARGUMENTS.args, 1) NEQ 0 AND this.hdtIDList EQ 0>
    AND userID = <cfqueryparam value="#ListGetAt(ARGUMENTS.args, 1)#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ListGetAt(ARGUMENTS.args, 2) NEQ 0>
    AND hdcID = <cfqueryparam value="#ListGetAt(ARGUMENTS.args, 2)#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ListGetAt(ARGUMENTS.args, 3) NEQ 0>
    AND hdsID = <cfqueryparam value="#ListGetAt(ARGUMENTS.args, 3)#" cfsqltype="cf_sql_integer">
    </cfif>
    AND hdtStatus IN (<cfqueryparam value="#ARGUMENTS.hdtStatus#" list="yes" cfsqltype="cf_sql_integer">)
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors
    <cfcatch type="any">
    <cfset rsHDTicketReport = StructNew()>
    <cfset rsHDTicketReport.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>.--->
    <cfreturn rsHDTicketReport>
    </cffunction>
    
    <cffunction name="getHDTicketTypeReport" access="public" returntype="query" hint="Get Help Desk Ticket Type Report data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="orderBy" type="string" required="yes" default="hdttSort">
    <cfset var rsHDTicketTypeReport = "" >
    <cftry>
    <cfquery name="rsHDTicketTypeReport" datasource="#application.mcmsDSN#">
    SELECT hdttName AS Name, deptNo, deptName AS Department, hdttSort AS Sort, sName as Status FROM v_hd_ticket_type WHERE 0=0
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND UPPER(hdttName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">
    </cfif>
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsHDTicketTypeReport = StructNew()>
    <cfset rsHDTicketTypeReport.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsHDTicketTypeReport>
    </cffunction>
    
    <cffunction name="getHDCategoryReport" access="public" returntype="query" hint="Get Help Desk Category Report data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="orderBy" type="string" required="yes" default="hdcSort, hdcName">
    <cfset var rsHDCategoryReport = "" >
    <cftry>
    <cfquery name="rsHDCategoryReport" datasource="#application.mcmsDSN#">
    SELECT hdcName AS Name, deptNo, deptName AS Department, hdttName AS Type, hdcSort AS Sort, sName as Status FROM v_hd_category WHERE 0=0
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND UPPER(hdcName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">
    </cfif>
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsHDCategoryReport = StructNew()>
    <cfset rsHDCategoryReport.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsHDCategoryReport>
    </cffunction>
    
    <cffunction name="getHDSecCategoryReport" access="public" returntype="query" hint="Get Help Desk Sec. Category Report data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="orderBy" type="string" required="yes" default="hdscSort, hdscName">
    <cfset var rsHDSecCategoryReport = "" >
    <cftry>
    <cfquery name="rsHDSecCategoryReport" datasource="#application.mcmsDSN#">
    SELECT hdscName AS Name, hdcName AS Category, sortName AS Sort, sName as Status FROM v_hd_sec_category WHERE 0=0
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND UPPER(hdcName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">
    </cfif>
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsHDSecCategoryReport = StructNew()>
    <cfset rsHDSecCategoryReport.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsHDSecCategoryReport>
    </cffunction>
    
    <cffunction name="getHDPriorityReport" access="public" returntype="query" hint="Get Help Desk Priority Report data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="orderBy" type="string" required="yes" default="hdpSort, hdpName">
    <cfset var rsHDPriorityReport = "" >
    <cftry>
    <cfquery name="rsHDPriorityReport" datasource="#application.mcmsDSN#">
    SELECT hdpName AS Name, sortName AS Sort, sName as Status FROM v_hd_priority WHERE 0=0
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND UPPER(hdpName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">
    </cfif>
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsHDPriorityReport = StructNew()>
    <cfset rsHDPriorityReport.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsHDPriorityReport>
    </cffunction>
    
    <cffunction name="getHDStatusReport" access="public" returntype="query" hint="Get Help Desk Status Report data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="orderBy" type="string" required="yes" default="hdsSort, hdsName">
    <cfset var rsHDStatusReport = "" >
    <cftry>
    <cfquery name="rsHDStatusReport" datasource="#application.mcmsDSN#">
    SELECT hdsName AS Name, sortName AS Sort, sName as Status FROM v_hd_status WHERE 0=0
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND UPPER(hdsName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">
    </cfif>
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsHDStatusReport = StructNew()>
    <cfset rsHDStatusReport.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsHDStatusReport>
    </cffunction>
    
    <cffunction name="insertHDTicket" access="public" returntype="struct">
    <cfargument name="hdtFName" type="string" required="yes">
    <cfargument name="hdtLName" type="string" required="yes">
    <cfargument name="hdtEmail" type="string" required="yes">
    <cfargument name="siteNo" type="numeric" required="yes">
    <cfargument name="deptNo" type="numeric" required="yes">
    <cfargument name="userID" type="numeric" required="yes">
    <cfargument name="hdttID" type="numeric" required="yes">
    <cfargument name="hdsID" type="numeric" required="yes">
    <cfargument name="hdtStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully inserted the record.">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    INSERT INTO tbl_hd_ticket (hdtFName,hdtLName,hdtEmail,siteNo,deptNo,userID,hdttID,hdpID,hdsID,hdtStatus) VALUES
    (
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.hdtFName#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.hdtLName#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.hdtEmail#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.siteNo#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.deptNo#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.userID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.hdttID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="101">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.hdsID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.hdtStatus#">
    )
    </cfquery>
    </cftransaction>
    <!---Get ID and return to result struct.--->
    <cfinvoke 
    component="MCMS.component.cms.Cms"
    method="getMaxValueSQL"
    returnvariable="hdtID">
    <cfinvokeargument name="tableName" value="tbl_hd_ticket"/>
    </cfinvoke>
    <cfset result.ID = hdtID>
    <cfset result.message = "You have successfully inserted the record.">
    <!---Forward to update form.--->
    <cfset ajaxOnLoad("function() {ColdFusion.Layout.selectTab('layoutIndex','Ticket'); ColdFusion.navigate('/#application.mcmsAppAdminPath#/help_desk/view/inc_hd_ticket.cfm?appID=#url.appID#&mcmsPageID=&mcmsID=update&ID=#result.ID#&queryString=', 'Ticket');}")>
    <cfcatch type="any">
    <cfset result.message = "There was an error inserting the record.">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="insertHDTicketType" access="public" returntype="struct">
    <cfargument name="hdttName" type="string" required="yes">
    <cfargument name="deptNo" type="numeric" required="yes">
    <cfargument name="hdttSort" type="numeric" required="yes">
    <cfargument name="hdttStatus" type="numeric" required="yes">
    <!---Relationship arguments.--->
    <cfargument name="urID" type="string" required="yes">
    <cfset result.message = "You have successfully inserted the record.">
    <cftry>
    <!---Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.app.help_desk.HelpDesk"
    method="getHDTicketType"
    returnvariable="getCheckHDTicketTypeRet">
    <cfinvokeargument name="hdttName" value="#ARGUMENTS.hdttName#"/>
    <cfinvokeargument name="deptNo" value="#ARGUMENTS.deptNo#"/>
    <cfinvokeargument name="hdttStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckHDTicketTypeRet.recordcount NEQ 0>
    <cfset result.message = "The name #ARGUMENTS.hdttName# already exists, please enter a new name.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    INSERT INTO tbl_hd_ticket_type (hdttName,deptNo,hdttSort,hdttStatus) VALUES
    (
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.hdttName#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.deptNo#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.hdttSort#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.hdttStatus#">
    )
    </cfquery>
    </cftransaction>
    <cfinvoke 
    component="MCMS.component.cms.Cms"
    method="getMaxValueSQL"
    returnvariable="getMaxValueSQLRet">
    <cfinvokeargument name="tableName" value="tbl_hd_ticket_type"/>
    </cfinvoke>
    <cfset this.hdttID = getMaxValueSQLRet>
    <!---Create user role relationships.--->
    <cfloop index="urID" list="#ARGUMENTS.urID#">
    <cfinvoke 
    component="MCMS.component.app.help_desk.HelpDesk"
    method="insertHDTicketTypeUserRoleRel"
    returnvariable="insertHDTicketTypeUserRoleRelRet">
    <cfinvokeargument name="hdttID" value="#this.hdttID#"/>
    <cfinvokeargument name="urID" value="#urID#"/>
    <cfinvokeargument name="hdtturrStatus" value="1"/>
    </cfinvoke>
    </cfloop>
    </cfif>
    <cfcatch type="any">
    <cfset result.message = "There was an error inserting the record.">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="insertHDWorkLog" access="public" returntype="struct">
    <cfargument name="hdtID" type="numeric" required="yes">
    <cfargument name="hdwlDescription" type="string" required="yes">
    <cfargument name="userID" type="numeric" required="yes">
    <cfargument name="hdwlStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully inserted the record.">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    INSERT INTO tbl_hd_work_log (hdtID,hdwlDescription,userID,hdrID,hdwlStatus) VALUES
    (
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.hdtID#">,
    <cfqueryparam cfsqltype="cf_sql_clob" value="#ARGUMENTS.hdwlDescription#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.userID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="1">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.hdwlStatus#">
    )
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error inserting the record.">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="insertHDCategory" access="public" returntype="struct">
    <cfargument name="hdcName" type="string" required="yes">
    <cfargument name="hdttID" type="numeric" required="yes">
    <cfargument name="hdcSort" type="numeric" required="yes">
    <cfargument name="hdcStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully inserted the record.">
    <cftry>
    <!---Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.app.help_desk.HelpDesk"
    method="getHDCategory"
    returnvariable="getCheckHDCategoryRet">
    <cfinvokeargument name="hdcName" value="#ARGUMENTS.hdcName#"/>
    <cfinvokeargument name="hdttID" value="#ARGUMENTS.hdttID#"/>
    <cfinvokeargument name="hdcStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckHDCategoryRet.recordcount NEQ 0>
    <cfset result.message = "The name #ARGUMENTS.hdcName# already exists, please enter a new name.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    INSERT INTO tbl_hd_category (hdcName,hdttID,hdcSort,hdcStatus) VALUES
    (
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.hdcName#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.hdttID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.hdcSort#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.hdcStatus#">
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
    
    <cffunction name="insertHDSecCategory" access="public" returntype="struct">
    <cfargument name="hdscName" type="string" required="yes">
    <cfargument name="hdcID" type="numeric" required="yes">
    <cfargument name="hdscSort" type="numeric" required="yes">
    <cfargument name="hdscStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully inserted the record.">
    <cftry>
    <!---Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.app.help_desk.HelpDesk"
    method="getHDSecCategory"
    returnvariable="getCheckHDSecCategoryRet">
    <cfinvokeargument name="hdscName" value="#ARGUMENTS.hdscName#"/>
    <cfinvokeargument name="hdcID" value="#ARGUMENTS.hdcID#"/>
    <cfinvokeargument name="hdscStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckHDSecCategoryRet.recordcount NEQ 0>
    <cfset result.message = "The name #ARGUMENTS.hdscName# already exists, please enter a new name.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    INSERT INTO tbl_hd_sec_category (hdscName,hdcID,hdscSort,hdscStatus) VALUES
    (
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.hdscName#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.hdcID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.hdscSort#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.hdscStatus#">
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
    
    <cffunction name="insertHDPriority" access="public" returntype="struct">
    <cfargument name="hdpName" type="string" required="yes">
    <cfargument name="hdpSort" type="numeric" required="yes">
    <cfargument name="hdpStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully inserted the record.">
    <cftry>
    <!---Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.app.help_desk.HelpDesk"
    method="getHDPriority"
    returnvariable="getCheckHDPriorityRet">
    <cfinvokeargument name="hdcName" value="#ARGUMENTS.hdpName#"/>
    <cfinvokeargument name="hdpStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckHDPriorityRet.recordcount NEQ 0>
    <cfset result.message = "The name #ARGUMENTS.hdpName# already exists, please enter a new name.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    INSERT INTO tbl_hd_priority (hdpName,hdpSort,hdpStatus) VALUES
    (
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.hdpName#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.hdpSort#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.hdpStatus#">
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
    
    <cffunction name="insertHDStatus" access="public" returntype="struct">
    <cfargument name="hdsName" type="string" required="yes">
    <cfargument name="hdsSort" type="numeric" required="yes">
    <cfargument name="hdsStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully inserted the record.">
    <cftry>
    <!---Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.app.help_desk.HelpDesk"
    method="getHDStatus"
    returnvariable="getCheckHDStatusRet">
    <cfinvokeargument name="hdsName" value="#ARGUMENTS.hdsName#"/>
    <cfinvokeargument name="hdsStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckHDStatusRet.recordcount NEQ 0>
    <cfset result.message = "The name #ARGUMENTS.hdsName# already exists, please enter a new name.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    INSERT INTO tbl_hd_status (hdsName,hdsSort,hdsStatus) VALUES
    (
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.hdsName#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.hdsSort#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.hdsStatus#">
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
    
    <cffunction name="insertHDTicketDocumentRel" access="public" returntype="struct">
    <cfargument name="hdtID" type="numeric" required="yes">
    <cfargument name="docID" type="numeric" required="yes">
    <cfargument name="hdtdrStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully inserted the record.">
    <cftry>
    <cftransaction>
    <!---Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.app.help_desk.HelpDesk"
    method="getHDTicketDocumentRel"
    returnvariable="getCheckHDTicketDocumentRelRet">
    <cfinvokeargument name="hdtID" value="#ARGUMENTS.hdtID#"/>
    <cfinvokeargument name="docID" value="#ARGUMENTS.docID#"/>
    <cfinvokeargument name="hdtdrStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckHDTicketDocumentRelRet.recordcount NEQ 0>
    <cfset result.message = "The name #getCheckHDTicketDocumentRelRet.docName# already exists, please choose a new document.">
    <cfelse>
    <cfquery datasource="#application.mcmsDSN#">
    INSERT INTO tbl_hd_ticket_document_rel (hdtID,docID,hdtdrStatus) VALUES
    (
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.hdtID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.docID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.hdtdrStatus#">
    )
    </cfquery>
    <cfset result.passed = true>
    </cfif>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error inserting the record.">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="insertHDTicketImageRel" access="public" returntype="struct">
    <cfargument name="hdtID" type="numeric" required="yes">
    <cfargument name="imgID" type="numeric" required="yes">
    <cfargument name="hdtirStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully inserted the record.">
    <cftry>
    <cftransaction>
    <!---Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.app.help_desk.HelpDesk"
    method="getHDTicketImageRel"
    returnvariable="getCheckHDTicketImageRelRet">
    <cfinvokeargument name="hdtID" value="#ARGUMENTS.hdtID#"/>
    <cfinvokeargument name="imgID" value="#ARGUMENTS.imgID#"/>
    <cfinvokeargument name="hdtirStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckHDTicketImageRelRet.recordcount NEQ 0>
    <cfset result.message = "The name #getCheckHDTicketImageRelRet.docName# already exists, please choose a new image.">
    <cfelse>
    <cfquery datasource="#application.mcmsDSN#">
    INSERT INTO tbl_hd_ticket_image_rel (hdtID,imgID,hdtirStatus) VALUES
    (
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.hdtID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.imgID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.hdtirStatus#">
    )
    </cfquery>
    <cfset result.passed = true>
    </cfif>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error inserting the record.">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="insertHDTicketUserRel" access="public" returntype="struct">
    <cfargument name="hdtID" type="numeric" required="yes">
    <cfargument name="userID" type="numeric" required="yes">
    <cfargument name="hdturStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully inserted the record.">
    <cftry>
    <!---Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.app.help_desk.HelpDesk"
    method="getHDTicketUserRel"
    returnvariable="getCheckHDTicketUserRelRet">
    <cfinvokeargument name="hdtID" value="#ARGUMENTS.hdtID#"/>
    <cfinvokeargument name="userID" value="#ARGUMENTS.userID#"/>
    <cfinvokeargument name="hdturStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckHDTicketUserRelRet.recordcount NEQ 0>
    <cfset result.message = "The user already exists, please choose another user.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    INSERT INTO tbl_hd_ticket_user_rel (hdtID,userID,hdturStatus) VALUES
    (
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.hdtID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.userID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.hdturStatus#">
    )
    </cfquery>
    </cftransaction>
    <cfset result.passed = true>
    </cfif>
    <cfcatch type="any">
    <cfset result.message = "There was an error inserting the record.">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="insertHDTicketTypeUserRoleRel" access="public" returntype="struct">
    <cfargument name="hdttID" type="numeric" required="yes">
    <cfargument name="urID" type="numeric" required="yes">
    <cfargument name="hdtturrStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully inserted the record.">
    <cftry>
    <!---Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.app.help_desk.HelpDesk"
    method="getHDTicketTypeUserRoleRel"
    returnvariable="getCheckHDTicketTypeUserRoleRelRet">
    <cfinvokeargument name="hdttID" value="#ARGUMENTS.hdttID#"/>
    <cfinvokeargument name="urID" value="#ARGUMENTS.urID#"/>
    <cfinvokeargument name="hdtturrStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckHDTicketTypeUserRoleRelRet.recordcount NEQ 0>
    <cfset result.message = "The user role already exists, please choose another user role.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    INSERT INTO tbl_hdt_type_user_role_rel (hdttID,urID,hdtturrStatus) VALUES
    (
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.hdttID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.urID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.hdtturrStatus#">
    )
    </cfquery>
    </cftransaction>
    <cfset result.passed = true>
    </cfif>
    <cfcatch type="any">
    <cfset result.message = "There was an error inserting the record.">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="updateHDTicket" access="public" returntype="struct">
    <cfargument name="ID" type="numeric" required="yes">
    <cfargument name="uaID" type="numeric" required="yes">
    <cfargument name="hdpID" type="numeric" required="yes">
    <cfargument name="hdtID" type="numeric" required="yes">
    <cfargument name="hdcID" type="numeric" required="yes">
    <cfargument name="hdscID" type="numeric" required="yes">
    <cfargument name="hdrID" type="numeric" required="yes">
    <cfargument name="hdsID" type="numeric" required="yes">
    <cfargument name="userID" type="numeric" required="yes">
    <cfargument name="userIDList" type="string" required="yes">
    <cfargument name="hdtKnowledgebase" type="numeric" required="yes">
    <cfargument name="hdtDescription" type="string" required="yes">
    <cfargument name="hdtInitialWorkLog" type="string" required="yes">
    <cfargument name="hdwlDescription" type="string" required="yes">
    <cfargument name="wlID" type="string" required="yes">
    <cfargument name="hdwlrID" type="string" required="yes">
    <cfargument name="emailNotify" type="string" required="yes" default="false">
    <cfargument name="hdtStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully updated the record.">
    <cftry>
    <!---Check for profanity in the text.--->
    <cfinvoke 
    component="MCMS.component.utility.Regex"
    method="regexProfanity"
    returnvariable="regexProfanityRet">
    <cfinvokeargument name="profanityString" value="#ARGUMENTS.hdtDescription#"/>
    </cfinvoke>
    <cfif regexProfanityRet CONTAINS '$%&*!'>
    <cfset result.message = "Some text contained profanity, please remove any profanity from your text.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_hd_ticket SET
    hdpID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.hdpID#">,
    hdtID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.hdtID#">,
    hdcID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.hdcID#">,
    hdscID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.hdscID#">,
    hdrID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.hdrID#">,
    hdsID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.hdsID#">,
    <cfif ARGUMENTS.hdsID EQ 2>
    hdtDateClose = <cfqueryparam cfsqltype="cf_sql_date" value="#Now()#">,
    </cfif>
    hdtKnowledgebase = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.hdtKnowledgebase#">,
    hdtDescription = <cfqueryparam cfsqltype="cf_sql_clob" value="#ARGUMENTS.hdtDescription#">,
    hdtInitialWorkLog = <cfqueryparam cfsqltype="cf_sql_clob" value="#ARGUMENTS.hdtInitialWorkLog#">,
		<cfif ARGUMENTS.uaID NEQ 101>
    hdtDateUpdate = <cfqueryparam cfsqltype="cf_sql_timestamp" value="#Now()#">,
    </cfif>
    hdtStatus = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.hdtStatus#">
    WHERE ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ID#">
    </cfquery>
    </cftransaction>
    <!---Insert Work Log if entered.--->
    <cfif ARGUMENTS.hdwlDescription NEQ "">
    <cfinvoke 
    component="MCMS.component.app.help_desk.HelpDesk"
    method="insertHDWorkLog"
    returnvariable="insertHDWorkLogRet">
    <cfinvokeargument name="hdtID" value="#ARGUMENTS.ID#"/>
    <cfinvokeargument name="hdwlDescription" value="#ARGUMENTS.hdwlDescription#"/>
    <cfinvokeargument name="userID" value="#ARGUMENTS.userID#"/>
    <cfinvokeargument name="hdwlStatus" value="1"/>
    </cfinvoke>
    </cfif>
    <cfif ARGUMENTS.hdwlrID NEQ 0 AND ARGUMENTS.wlID NEQ 0>
    <!---Update Rating of any Work Log.--->
    <cfset wlLoopcount = 0>
    <cfloop list="#ARGUMENTS.wlID#" index="i">
    <cfset wlLoopcount = wlLoopcount+1>
    <cfset hdrIDValue = ListGetAt(ARGUMENTS.hdwlrID, wlLoopcount)>
    <cfinvoke 
    component="MCMS.component.app.help_desk.HelpDesk"
    method="updateHDWorkLog"
    returnvariable="updateHDWorkLogRet">
    <cfinvokeargument name="ID" value="#i#"/>
    <cfinvokeargument name="hdrID" value="#hdrIDValue#"/>
    <cfinvokeargument name="hdwlStatus" value="1"/>
    </cfinvoke>
    </cfloop>
    </cfif>
    <!---Process user relationships.--->
    <cfset currentUserIDList = 0>
    <cfset currentUserEmailList = ''>
    <!---Delete Existing Ticket User Relationship before inserting new ones.--->
    <cfinvoke 
    component="MCMS.component.app.help_desk.HelpDesk"
    method="deleteHDTicketUserRel"
    returnvariable="deleteHDTicketUserRelRet">
    <cfinvokeargument name="hdtID" value="#ARGUMENTS.ID#"/>
    </cfinvoke>
    <!---Insert Ticket User Relationship.--->
    <cfloop list="#ARGUMENTS.userIDList#" index="i">
    <cfinvoke 
    component="MCMS.component.app.help_desk.HelpDesk"
    method="insertHDTicketUserRel"
    returnvariable="insertHDTicketUserRelRet">
    <cfinvokeargument name="hdtID" value="#ARGUMENTS.ID#"/>
    <cfinvokeargument name="userID" value="#i#"/>
    <cfinvokeargument name="hdturStatus" value="1"/>
    </cfinvoke>
    </cfloop>
    <!---Create a new list.--->
    <cfinvoke 
    component="MCMS.component.app.help_desk.HelpDesk"
    method="getHDTicketUserRel"
    returnvariable="getHDTicketUserRelRet">
    <cfinvokeargument name="userID" value="#Iif(ARGUMENTS.userIDList EQ '', DE('1'), DE(ARGUMENTS.userIDList))#"/>
    <cfinvokeargument name="hdtID" value="#ARGUMENTS.ID#"/>
    <cfinvokeargument name="hdturStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getHDTicketUserRelRet.recordcount NEQ 0>
    <cfset currentUserIDList = ValueList(getHDTicketUserRelRet.userID)>
    <cfset currentUserEmailList = '#ValueList(getHDTicketUserRelRet.userEmail)#'>
    </cfif>
    <!---Send email notifications.--->
    <cfif currentUserEmailList NEQ "" AND ARGUMENTS.emailNotify NEQ 'false'>
    <cfloop list="#currentUserEmailList#" index="i">
    <cfinvoke 
    component="MCMS.component.utility.Email"
    method="sendEmail">
    <cfinvokeargument name="subject" value="Help Desk Ticket Update - No. #ARGUMENTS.ID#"/>
    <cfinvokeargument name="to" value="#i#"/>
    <cfinvokeargument name="from" value="#session.userUsername#"/>
    <cfinvokeargument name="body" value=""/>
    <cfinvokeargument name="ID" value="#ARGUMENTS.ID#"/>
    <cfinvokeargument name="emailTemplate" value="/#application.mcmsAppAdminPath#/help_desk/view/inc_hd_ticket_update_email_template.cfm"/>
    </cfinvoke>
    </cfloop>
    <cfset result.message = "You have successfully updated the record and you have notified the assigned users.">
    </cfif>
    </cfif>
    <cfcatch type="any">
    <cfset result.message = "There was an error updating the record.">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="updateHDTicketType" access="public" returntype="struct">
    <cfargument name="ID" type="numeric" required="yes">
    <cfargument name="hdttName" type="string" required="yes">
    <cfargument name="deptNo" type="numeric" required="yes">
    <cfargument name="hdttSort" type="numeric" required="yes">
    <cfargument name="hdttStatus" type="numeric" required="yes">
    <!---Relationship arguments.--->
    <cfargument name="urID" type="string" required="yes">
    <cfset result.message = "You have successfully updated the record.">
    <cftry>
    <!---Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.app.help_desk.HelpDesk"
    method="getHDTicketType"
    returnvariable="getCheckHDTicketTypeRet">
    <cfinvokeargument name="excludeID" value="#ARGUMENTS.ID#"/>
    <cfinvokeargument name="hdttName" value="#ARGUMENTS.hdttName#"/>
    <cfinvokeargument name="deptNo" value="#ARGUMENTS.deptNo#"/>
    <cfinvokeargument name="hdttStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckHDTicketTypeRet.recordcount NEQ 0>
    <cfset result.message = "The name #ARGUMENTS.hdttName# already exists, please enter a new name.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_hd_ticket_type SET
    hdttName = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.hdttName#">,
    deptNo = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.deptNo#">,
    hdttSort = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.hdttSort#">,
    hdttStatus = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.hdttStatus#">
    WHERE ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ID#">
    </cfquery>
    </cftransaction>
    <!---Delete any existing relationships.--->
    <cfinvoke 
    component="MCMS.component.app.help_desk.HelpDesk"
    method="deleteHDTicketTypeUserRoleRel"
    returnvariable="deleteHDTicketTypeUserRoleRelRet">
    <cfinvokeargument name="hdttID" value="#ARGUMENTS.ID#"/>
    </cfinvoke>
    <!---Create user role relationships.--->
    <cfloop index="urID" list="#ARGUMENTS.urID#">
    <cfinvoke 
    component="MCMS.component.app.help_desk.HelpDesk"
    method="insertHDTicketTypeUserRoleRel"
    returnvariable="insertHDTicketTypeUserRoleRelRet">
    <cfinvokeargument name="hdttID" value="#ARGUMENTS.ID#"/>
    <cfinvokeargument name="urID" value="#urID#"/>
    <cfinvokeargument name="hdtturrStatus" value="1"/>
    </cfinvoke>
    </cfloop>
    </cfif>
    <cfcatch type="any">
    <cfset result.message = "There was an error updating the record.">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="updateHDCategory" access="public" returntype="struct">
    <cfargument name="ID" type="numeric" required="yes">
    <cfargument name="hdcName" type="string" required="yes">
    <cfargument name="hdttID" type="numeric" required="yes">
    <cfargument name="hdcSort" type="numeric" required="yes">
    <cfargument name="hdcStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully updated the record.">
    <cftry>
    <!---Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.app.help_desk.HelpDesk"
    method="getHDCategory"
    returnvariable="getCheckHDCategoryRet">
    <cfinvokeargument name="excludeID" value="#ARGUMENTS.ID#"/>
    <cfinvokeargument name="hdcName" value="#ARGUMENTS.hdcName#"/>
    <cfinvokeargument name="hdttID" value="#ARGUMENTS.hdttID#"/>
    <cfinvokeargument name="hdcStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckHDCategoryRet.recordcount NEQ 0>
    <cfset result.message = "The name #ARGUMENTS.hdcName# already exists, please enter a new name.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_hd_category SET
    hdcName = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.hdcName#">,
    hdttID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.hdttID#">,
    hdcSort = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.hdcSort#">,
    hdcStatus = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.hdcStatus#">
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
    
    <cffunction name="updateHDSecCategory" access="public" returntype="struct">
    <cfargument name="ID" type="numeric" required="yes">
    <cfargument name="hdscName" type="string" required="yes">
    <cfargument name="hdcID" type="numeric" required="yes">
    <cfargument name="hdscSort" type="numeric" required="yes">
    <cfargument name="hdscStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully updated the record.">
    <cftry>
    <!---Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.app.help_desk.HelpDesk"
    method="getHDSecCategory"
    returnvariable="getCheckHDSecCategoryRet">
    <cfinvokeargument name="excludeID" value="#ARGUMENTS.ID#"/>
    <cfinvokeargument name="hdscName" value="#ARGUMENTS.hdscName#"/>
    <cfinvokeargument name="hdcID" value="#ARGUMENTS.hdcID#"/>
    <cfinvokeargument name="hdscStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckHDSecCategoryRet.recordcount NEQ 0>
    <cfset result.message = "The name #ARGUMENTS.hdscName# already exists, please enter a new name.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_hd_sec_category SET
    hdscName = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.hdscName#">,
    hdcID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.hdcID#">,
    hdscSort = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.hdscSort#">,
    hdscStatus = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.hdscStatus#">
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
    
    <cffunction name="updateHDPriority" access="public" returntype="struct">
    <cfargument name="ID" type="numeric" required="yes">
    <cfargument name="hdpName" type="string" required="yes">
    <cfargument name="hdpSort" type="numeric" required="yes">
    <cfargument name="hdpStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully updated the record.">
    <cftry>
    <!---Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.app.help_desk.HelpDesk"
    method="getHDPriority"
    returnvariable="getCheckHDPriorityRet">
    <cfinvokeargument name="excludeID" value="#ARGUMENTS.ID#"/>
    <cfinvokeargument name="hdpName" value="#ARGUMENTS.hdpName#"/>
    <cfinvokeargument name="hdpStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckHDPriorityRet.recordcount NEQ 0>
    <cfset result.message = "The name #ARGUMENTS.hdpName# already exists, please enter a new name.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_hd_priority SET
    hdpName = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.hdpName#">,
    hdpSort = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.hdpSort#">,
    hdpStatus = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.hdpStatus#">
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
    
    <cffunction name="updateHDStatus" access="public" returntype="struct">
    <cfargument name="ID" type="numeric" required="yes">
    <cfargument name="hdsName" type="string" required="yes">
    <cfargument name="hdsSort" type="numeric" required="yes">
    <cfargument name="hdsStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully updated the record.">
    <cftry>
    <!---Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.app.help_desk.HelpDesk"
    method="getHDStatus"
    returnvariable="getCheckHDStatusRet">
    <cfinvokeargument name="excludeID" value="#ARGUMENTS.ID#"/>
    <cfinvokeargument name="hdsName" value="#ARGUMENTS.hdsName#"/>
    <cfinvokeargument name="hdsStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckHDStatusRet.recordcount NEQ 0>
    <cfset result.message = "The name #ARGUMENTS.hdsName# already exists, please enter a new name.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_hd_status SET
    hdsName = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.hdsName#">,
    hdsSort = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.hdsSort#">,
    hdsStatus = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.hdsStatus#">
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
    
    <cffunction name="updateHDWorkLog" access="public" returntype="struct">
    <cfargument name="ID" type="numeric" required="yes">
    <cfargument name="hdrID" type="numeric" required="yes">
    <cfargument name="hdwlStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully updated the records.">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_hd_work_log SET
    hdrID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.hdrID#">,
    hdwlStatus = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.hdwlStatus#">
    WHERE ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ID#">
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error updating the records.">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="updateHDTicketList" access="public" returntype="struct">
    <cfargument name="ID" type="numeric" required="yes">
    <cfargument name="hdsID" type="numeric" required="yes">
    <cfargument name="hdtStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully updated the records.">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_hd_ticket SET
    hdsID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.hdsID#">,
	<cfif ARGUMENTS.hdsID EQ 2>
    hdtDateClose = <cfqueryparam cfsqltype="cf_sql_timestamp" value="#Now()#">,
    </cfif>
    hdtStatus = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.hdtStatus#">
    WHERE ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ID#">
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error updating the records.">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="updateHDTicketTypeList" access="public" returntype="struct">
    <cfargument name="ID" type="numeric" required="yes">
    <cfargument name="hdttStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully updated the records.">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_hd_ticket_type SET
    hdttStatus = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.hdttStatus#">
    WHERE ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ID#">
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error updating the records.">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="updateHDCategoryList" access="public" returntype="struct">
    <cfargument name="ID" type="numeric" required="yes">
    <cfargument name="hdcStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully updated the records.">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_hd_category SET
    hdcStatus = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.hdcStatus#">
    WHERE ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ID#">
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error updating the records.">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="updateHDSecCategoryList" access="public" returntype="struct">
    <cfargument name="ID" type="numeric" required="yes">
    <cfargument name="hdscStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully updated the records.">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_hd_sec_category SET
    hdscStatus = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.hdscStatus#">
    WHERE ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ID#">
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error updating the records.">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="updateHDPriorityList" access="public" returntype="struct">
    <cfargument name="ID" type="numeric" required="yes">
    <cfargument name="hdpStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully updated the records.">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_hd_priority SET
    hdpStatus = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.hdpStatus#">
    WHERE ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ID#">
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error updating the records.">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="updateHDStatusList" access="public" returntype="struct">
    <cfargument name="ID" type="numeric" required="yes">
    <cfargument name="hdsStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully updated the records.">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_hd_status SET
    hdsStatus = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.hdsStatus#">
    WHERE ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ID#">
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error updating the records.">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="deleteHDTicket" access="public" returntype="struct">
    <cfargument name="ID" type="string" required="yes">
    <cfset result.message = "You have successfully deleted the record(s).">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    DELETE FROM tbl_hd_ticket
    WHERE ID IN (<cfqueryparam cfsqltype="cf_sql_integer" list="yes" value="#ARGUMENTS.ID#">)
    </cfquery>
    </cftransaction>
    <!---Delete Work Log.--->
    <cfinvoke 
    component="MCMS.component.app.help_desk.HelpDesk"
    method="deleteHDWorkLog"
    returnvariable="result">
    <cfinvokeargument name="hdtID" value="#ARGUMENTS.ID#"/>
    </cfinvoke>
    <!---Delete Document Rel.--->
    <cfinvoke 
    component="MCMS.component.app.help_desk.HelpDesk"
    method="deleteHDTicketDocumentRel"
    returnvariable="result">
    <cfinvokeargument name="hdtID" value="#ARGUMENTS.ID#"/>
    </cfinvoke>
    <!---Delete Image Rel.--->
    <cfinvoke 
    component="MCMS.component.app.help_desk.HelpDesk"
    method="deleteHDTicketImageRel"
    returnvariable="result">
    <cfinvokeargument name="hdtID" value="#ARGUMENTS.ID#"/>
    </cfinvoke>
    <!---Delete User Rel.--->
    <cfinvoke 
    component="MCMS.component.app.help_desk.HelpDesk"
    method="deleteHDTicketUserRel"
    returnvariable="result">
    <cfinvokeargument name="hdtID" value="#ARGUMENTS.ID#"/>
    </cfinvoke>
    <cfcatch type="any">
    <cfset result.message = "There was an error deleting the record(s).">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="deleteHDWorkLog" access="public" returntype="struct">
    <cfargument name="ID" type="string" required="yes" default="0">
    <cfargument name="hdtID" type="string" required="yes" default="0">
    <cfset result.message = "You have successfully deleted the record(s).">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    DELETE FROM tbl_hd_work_log
    WHERE ID IN (<cfqueryparam cfsqltype="cf_sql_integer" list="yes" value="#ARGUMENTS.ID#">) OR
    hdtID IN (<cfqueryparam cfsqltype="cf_sql_integer" list="yes" value="#ARGUMENTS.hdtID#">)
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error deleting the record(s).">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>  
    
    <cffunction name="deleteHDTicketType" access="public" returntype="struct">
    <cfargument name="ID" type="string" required="yes">
    <cfset result.message = "You have successfully deleted the record(s).">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    DELETE FROM tbl_hd_ticket_type
    WHERE ID IN (<cfqueryparam cfsqltype="cf_sql_integer" list="yes" value="#ARGUMENTS.ID#">)
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error deleting the record(s).">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction> 
    
    <cffunction name="deleteHDCategory" access="public" returntype="struct">
    <cfargument name="ID" type="string" required="yes">
    <cfset result.message = "You have successfully deleted the record(s).">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    DELETE FROM tbl_hd_category
    WHERE ID IN (<cfqueryparam cfsqltype="cf_sql_integer" list="yes" value="#ARGUMENTS.ID#">)
    </cfquery>
    </cftransaction>
    <!---Delete any Sec. Categories.--->
    <cfinvoke 
    component="MCMS.component.app.help_desk.HelpDesk"
    method="deleteHDSecCategory"
    returnvariable="result">
    <cfinvokeargument name="hdcID" value="#ARGUMENTS.ID#"/>
    </cfinvoke>
    <cfcatch type="any">
    <cfset result.message = "There was an error deleting the record(s).">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="deleteHDSecCategory" access="public" returntype="struct">
    <cfargument name="ID" type="string" required="yes" default="0">
    <cfargument name="hdcID" type="string" required="yes" default="0">
    <cfset result.message = "You have successfully deleted the record(s).">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    DELETE FROM tbl_hd_sec_category
    WHERE ID IN (<cfqueryparam cfsqltype="cf_sql_integer" list="yes" value="#ARGUMENTS.ID#">) 
    OR hdcID IN (<cfqueryparam cfsqltype="cf_sql_integer" list="yes" value="#ARGUMENTS.hdcID#">)
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error deleting the record(s).">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="deleteHDPriority" access="public" returntype="struct">
    <cfargument name="ID" type="string" required="yes">
    <cfset result.message = "You have successfully deleted the record(s).">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    DELETE FROM tbl_hd_priority
    WHERE ID IN (<cfqueryparam cfsqltype="cf_sql_integer" list="yes" value="#ARGUMENTS.ID#">)
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error deleting the record(s).">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="deleteHDStatus" access="public" returntype="struct">
    <cfargument name="ID" type="string" required="yes">
    <cfset result.message = "You have successfully deleted the record(s).">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    DELETE FROM tbl_hd_status
    WHERE ID IN (<cfqueryparam cfsqltype="cf_sql_integer" list="yes" value="#ARGUMENTS.ID#">)
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error deleting the record(s).">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="deleteHDTicketDocumentRel" access="public" returntype="struct">
    <cfargument name="ID" type="string" required="yes" default="0">
    <cfargument name="hdtID" type="string" required="yes" default="0">
    <cfset result.message = "You have successfully deleted the record(s).">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    DELETE FROM tbl_hd_ticket_document_rel
    WHERE ID IN (<cfqueryparam cfsqltype="cf_sql_integer" list="yes" value="#ARGUMENTS.ID#">) OR
    hdtID IN (<cfqueryparam cfsqltype="cf_sql_integer" list="yes" value="#ARGUMENTS.hdtID#">)
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error deleting the record(s).">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>  
    
    <cffunction name="deleteHDTicketImageRel" access="public" returntype="struct">
    <cfargument name="ID" type="string" required="yes" default="0">
    <cfargument name="hdtID" type="string" required="yes" default="0">
    <cfset result.message = "You have successfully deleted the record(s).">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    DELETE FROM tbl_hd_ticket_image_rel
    WHERE ID IN (<cfqueryparam cfsqltype="cf_sql_integer" list="yes" value="#ARGUMENTS.ID#">) OR
    hdtID IN (<cfqueryparam cfsqltype="cf_sql_integer" list="yes" value="#ARGUMENTS.hdtID#">)
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error deleting the record(s).">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>  
    
    <cffunction name="deleteHDTicketUserRel" access="public" returntype="struct">
    <cfargument name="excludeUserID" type="string" required="yes" default="0">
    <cfargument name="hdtID" type="string" required="yes" default="0">
    <cfset result.message = "You have successfully deleted the record(s).">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    DELETE FROM tbl_hd_ticket_user_rel
    WHERE hdtID IN (<cfqueryparam cfsqltype="cf_sql_integer" list="yes" value="#ARGUMENTS.hdtID#">)
    AND userID NOT IN (<cfqueryparam cfsqltype="cf_sql_integer" list="yes" value="#ARGUMENTS.excludeUserID#">)
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error deleting the record(s).">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction> 
    
    <cffunction name="deleteHDTicketTypeUserRoleRel" access="public" returntype="struct">
    <cfargument name="hdttID" type="string" required="yes">
    <cfset result.message = "You have successfully deleted the record(s).">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    DELETE FROM tbl_hdt_type_user_role_rel
    WHERE hdttID IN (<cfqueryparam cfsqltype="cf_sql_integer" list="yes" value="#ARGUMENTS.hdttID#">)
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error deleting the record(s).">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
</cfcomponent>