<cfcomponent>
    <cffunction name="getChatRoom" access="public" returntype="query" hint="Get Chat Room data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="ID" type="string" required="yes" default="0">
    <cfargument name="excludeID" type="numeric" required="yes" default="0">
    <cfargument name="crName" type="string" required="yes" default="">
    <cfargument name="crtID" type="string" required="yes" default="0">
    <cfargument name="crStatus" type="string" required="yes" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="crName">
    <cfset var rsChatRoom = "" >
    <cftry>
    <cfquery name="rsChatRoom" datasource="#application.mcmsDSN#">
    SELECT * FROM v_chat_room WHERE 0=0
    <cfif ARGUMENTS.ID NEQ 0>
    AND ID IN (<cfqueryparam value="#ARGUMENTS.ID#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    <cfif ARGUMENTS.excludeID NEQ 0>
    AND ID <> <cfqueryparam value="#ARGUMENTS.excludeID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(crName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(crDescription) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">)
    </cfif>
    <cfif ARGUMENTS.crName NEQ "">
    AND UPPER(crName) = <cfqueryparam value="#UCASE(ARGUMENTS.crName)#" cfsqltype="cf_sql_varchar">
    </cfif>
    <cfif ARGUMENTS.crtID NEQ 0>
    AND crtID = <cfqueryparam value="#ARGUMENTS.crtID#" cfsqltype="cf_sql_integer">
    </cfif>
    AND crStatus IN (<cfqueryparam value="#ARGUMENTS.crStatus#" list="yes" cfsqltype="cf_sql_integer">)
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsChatRoom = StructNew()>
    <cfset rsChatRoom.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsChatRoom>
    </cffunction>
    
    <cffunction name="getChatRoomUserRoleAccessRel" access="public" returntype="query" hint="Get Chat Room User Role Access Relationship data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="ID" type="numeric" required="yes" default="0">
    <cfargument name="excludeID" type="numeric" required="yes" default="0">
    <cfargument name="crID" type="numeric" required="yes" default="0">
    <cfargument name="urID" type="numeric" required="yes" default="0">
    <cfargument name="uaID" type="numeric" required="yes" default="0">
    <cfargument name="crStatus" type="string" required="yes" default="1">
    <cfargument name="urStatus" type="string" required="yes" default="1">
    <cfargument name="uaStatus" type="string" required="yes" default="1">
    <cfargument name="crurarStatus" type="string" required="yes" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="crName">
    <cfset var rsChatRoomUserRoleAccessRel = "" >
    <cftry>
    <cfquery name="rsChatRoomUserRoleAccessRel" datasource="#application.mcmsDSN#">
    SELECT * FROM v_chat_room_ur_access_rel WHERE 0=0
    <cfif ARGUMENTS.ID NEQ 0>
    AND ID = <cfqueryparam value="#ARGUMENTS.ID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.excludeID NEQ 0>
    AND ID <> <cfqueryparam value="#ARGUMENTS.excludeID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(crName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(urName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(uaName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">)
    </cfif>
    <cfif ARGUMENTS.crID NEQ 0>
    AND crID = <cfqueryparam value="#ARGUMENTS.crID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.urID NEQ 0>
    AND urID = <cfqueryparam value="#ARGUMENTS.urID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.uaID NEQ 0>
    AND uaID = <cfqueryparam value="#ARGUMENTS.uaID#" cfsqltype="cf_sql_integer">
    </cfif>
    AND crStatus IN (<cfqueryparam value="#ARGUMENTS.crStatus#" list="yes" cfsqltype="cf_sql_integer">)
    AND urStatus IN (<cfqueryparam value="#ARGUMENTS.urStatus#" list="yes" cfsqltype="cf_sql_integer">)
    AND uaStatus IN (<cfqueryparam value="#ARGUMENTS.uaStatus#" list="yes" cfsqltype="cf_sql_integer">)
    AND crurarStatus IN (<cfqueryparam value="#ARGUMENTS.crurarStatus#" list="yes" cfsqltype="cf_sql_integer">)
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsChatRoomUserRoleAccessRel = StructNew()>
    <cfset rsChatRoomUserRoleAccessRel.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsChatRoomUserRoleAccessRel>
    </cffunction>
    
    <cffunction name="getChatRoomDepartmentRel" access="public" returntype="query" hint="Get Chat Room Department Relationship data.">
    <cfargument name="keywords" type="string" required="no" default="All">
    <cfargument name="ID" type="numeric" required="yes" default="0">
    <cfargument name="excludeID" type="numeric" required="yes" default="0">
    <cfargument name="crID" type="numeric" required="yes" default="0">
    <cfargument name="deptNo" type="string" required="yes" default="0">
    <cfargument name="crStatus" type="string" required="no" default="1">
    <cfargument name="deptStatus" type="string" required="no" default="1">
    <cfargument name="crdrStatus" type="string" required="yes" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="deptNo">
	<cfset var rsChatRoomDepartmentRel = "" >
    <cftry>
    <cfquery name="rsChatRoomDepartmentRel" datasource="#application.mcmsDSN#">
    SELECT * FROM v_chat_room_department_rel WHERE 0=0
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND deptNo LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> 
    </cfif>
    <cfif ARGUMENTS.ID NEQ 0>
    AND ID = <cfqueryparam value="#ARGUMENTS.ID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.excludeID NEQ 0>
    AND ID <> <cfqueryparam value="#ARGUMENTS.excludeID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.crID NEQ 0>
    AND crID = <cfqueryparam value="#ARGUMENTS.crID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.deptNo NEQ 0>
    AND deptNo IN (<cfqueryparam value="#ARGUMENTS.deptNo#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    AND crStatus IN (<cfqueryparam value="#ARGUMENTS.crStatus#" list="yes" cfsqltype="cf_sql_integer">)
    AND (deptStatus IN (<cfqueryparam value="#ARGUMENTS.deptStatus#" list="yes" cfsqltype="cf_sql_integer">) OR deptStatus IS NULL)
    AND crdrStatus IN (<cfqueryparam value="#ARGUMENTS.crdrStatus#" list="yes" cfsqltype="cf_sql_integer">)
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsChatRoomDepartmentRel = StructNew()>
    <cfset rsChatRoomDepartmentRel.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsChatRoomDepartmentRel>
    </cffunction>
    
    <cffunction name="getChatRoomSiteRel" access="public" returntype="query" hint="Get Chat Room Site Relationship data.">
    <cfargument name="keywords" type="string" required="no" default="All">
    <cfargument name="ID" type="numeric" required="yes" default="0">
    <cfargument name="excludeID" type="numeric" required="yes" default="0">
    <cfargument name="crID" type="numeric" required="yes" default="0">
    <cfargument name="siteNo" type="string" required="yes" default="0">
    <cfargument name="crStatus" type="string" required="no" default="1">
    <cfargument name="siteStatus" type="string" required="no" default="1">
    <cfargument name="crsrStatus" type="string" required="yes" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="siteNo">
	<cfset var rsChatRoomSiteRel = "" >
    <cftry>
    <cfquery name="rsChatRoomSiteRel" datasource="#application.mcmsDSN#">
    SELECT * FROM v_chat_room_site_rel WHERE 0=0
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND siteNo LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> 
    </cfif>
    <cfif ARGUMENTS.ID NEQ 0>
    AND ID = <cfqueryparam value="#ARGUMENTS.ID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.excludeID NEQ 0>
    AND ID <> <cfqueryparam value="#ARGUMENTS.excludeID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.crID NEQ 0>
    AND crID = <cfqueryparam value="#ARGUMENTS.crID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.siteNo NEQ 0>
    AND siteNo IN (<cfqueryparam value="#ARGUMENTS.siteNo#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    AND crStatus IN (<cfqueryparam value="#ARGUMENTS.crStatus#" list="yes" cfsqltype="cf_sql_integer">)
    AND (siteStatus IN (<cfqueryparam value="#ARGUMENTS.siteStatus#" list="yes" cfsqltype="cf_sql_integer">) OR siteStatus IS NULL)
    AND crsrStatus IN (<cfqueryparam value="#ARGUMENTS.crsrStatus#" list="yes" cfsqltype="cf_sql_integer">)
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsChatRoomSiteRel = StructNew()>
    <cfset rsChatRoomSiteRel.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsChatRoomSiteRel>
    </cffunction>
    
    <cffunction name="getChatRoomLog" access="public" returntype="query" hint="Get Chat Room Log data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="ID" type="numeric" required="yes" default="0">
    <cfargument name="excludeID" type="numeric" required="yes" default="0">
    <cfargument name="crID" type="numeric" required="yes" default="0">
    <cfargument name="userIDPost" type="numeric" required="yes" default="0">
    <cfargument name="userIDReply" type="numeric" required="yes" default="0">
    <cfargument name="chatSessionID" type="string" required="yes" default="">
    <cfargument name="crlStatus" type="string" required="yes" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="crlDate">
    <cfset var rsChatRoomLog = "" >
    <cftry>
    <cfquery name="rsChatRoomLog" datasource="#application.mcmsDSN#">
    SELECT * FROM v_chat_room_log WHERE 0=0
    <cfif ARGUMENTS.ID NEQ 0>
    AND ID = <cfqueryparam value="#ARGUMENTS.ID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.excludeID NEQ 0>
    AND ID <> <cfqueryparam value="#ARGUMENTS.excludeID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(crName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(userlname) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(userfname) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(crltext) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">)
    </cfif>
    <cfif ARGUMENTS.crID NEQ 0>
    AND crID = <cfqueryparam value="#ARGUMENTS.crID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.userIDPost NEQ 0>
    AND userIDPost = <cfqueryparam value="#ARGUMENTS.userIDPost#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.userIDReply NEQ 0>
    AND userIDReply = <cfqueryparam value="#ARGUMENTS.userIDReply#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.chatSessionID NEQ "">
    AND chatSessionID = <cfqueryparam value="#ARGUMENTS.chatSessionID#" cfsqltype="cf_sql_varchar">
    </cfif>
    AND crlStatus IN (<cfqueryparam value="#ARGUMENTS.crlStatus#" list="yes" cfsqltype="cf_sql_integer">)
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsChatRoomLog = StructNew()>
    <cfset rsChatRoomLog.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsChatRoomLog>
    </cffunction>
    
    <cffunction name="getChatRoomLogAsync" access="remote" returntype="any" hint="Get Chat Room Log Async">
    <cfargument name="crID" type="numeric" required="yes" default="0">
    <cfargument name="crlUser" type="string" required="yes" default="">
    <cfargument name="chatSessionID" type="string" required="yes" default="">
    <cfargument name="crlStatus" type="string" required="yes" default="1,3">
    <cfargument name="siteDSN" type="string" required="yes" default="swweb">
    <cfargument name="orderBy" type="string" required="yes" default="crlDate">
    <cfset var rsChatRoomLogAsync = StructNew()>
    <cfset rsChatRoomLog = "">
    <cftry>
    <cfquery name="rsChatRoomLog" datasource="#ARGUMENTS.mcmsDSN#">
    SELECT CRLUSER, CRLTEXT FROM v_chat_room_log WHERE 0=0
    <cfif ARGUMENTS.crID NEQ 0>
    AND crID = <cfqueryparam value="#ARGUMENTS.crID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.crlUser NEQ "">
    AND UPPER(crlUser) = <cfqueryparam value="#UCASE(ARGUMENTS.crlUser)#" cfsqltype="cf_sql_varchar">
    </cfif>
    <cfif ARGUMENTS.chatSessionID NEQ "">
    AND chatSessionID = <cfqueryparam value="#ARGUMENTS.chatSessionID#" cfsqltype="cf_sql_varchar">
    </cfif>
    AND crlStatus IN (<cfqueryparam value="#ARGUMENTS.crlStatus#" list="yes" cfsqltype="cf_sql_integer">)
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <cfset rsChatRoomLogAsync = SerializeJSON(rsChatRoomLog)>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsChatRoomLogAsync = StructNew()>
    <cfset rsChatRoomLogAsync.message = "There was an error with the query.">
    </cfcatch>
    </cftry>
    <cfreturn rsChatRoomLogAsync>
    </cffunction>
    
    <cffunction name="getChatRoomLogAttrValue" access="public" returntype="query" hint="Get Chat Room Log Attr. Value data.">
    <cfargument name="keywords" type="string" required="no" default="All">
    <cfargument name="ID" type="numeric" required="yes" default="0">
    <cfargument name="excludeID" type="numeric" required="yes" default="0">
    <cfargument name="crID" type="numeric" required="yes" default="0">
    <cfargument name="craID" type="numeric" required="yes" default="0">
    <cfargument name="chatSessionID" type="string" required="yes" default="">
    <cfargument name="crlavStatus" type="string" required="yes" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="crID">
	<cfset var rsChatRoomLogAttrValue = "" >
    <cftry>
    <cfquery name="rsChatRoomLogAttrValue" datasource="#application.mcmsDSN#">
    SELECT * FROM tbl_chat_room_log_attr_value WHERE 0=0
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND siteNo LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> 
    </cfif>
    <cfif ARGUMENTS.ID NEQ 0>
    AND ID = <cfqueryparam value="#ARGUMENTS.ID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.excludeID NEQ 0>
    AND ID <> <cfqueryparam value="#ARGUMENTS.excludeID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.crID NEQ 0>
    AND crID = <cfqueryparam value="#ARGUMENTS.crID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.craID NEQ 0>
    AND craID = <cfqueryparam value="#ARGUMENTS.craID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.chatSessionID NEQ "">
    AND chatSessionID = <cfqueryparam value="#ARGUMENTS.chatSessionID#" cfsqltype="cf_sql_varchar">
    </cfif>
    AND crlavStatus IN (<cfqueryparam value="#ARGUMENTS.crlavStatus#" list="yes" cfsqltype="cf_sql_integer">)
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsChatRoomLogAttrValue = StructNew()>
    <cfset rsChatRoomLogAttrValue.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsChatRoomLogAttrValue>
    </cffunction>
    
    <cffunction name="getChatRoomUsersAsync" access="remote" returntype="string" hint="Get Chat Room Users Async">
    <cfargument name="session" type="string" required="yes" default="0">
    <cfset rsChatRoomUsersAsync = arguments.session>
    <cfreturn rsChatRoomUsersAsync>
    </cffunction>
    
    <cffunction name="getChatRoomAttribute" access="public" returntype="query" hint="Get Chat Room Attribute data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="ID" type="numeric" required="yes" default="0">
    <cfargument name="excludeID" type="numeric" required="yes" default="0">
    <cfargument name="craName" type="string" required="yes" default="">
    <cfargument name="cratID" type="string" required="yes" default="0">
    <cfargument name="craStatus" type="string" required="yes" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="craName">
    <cfset var rsChatRoomAttribute = "" >
    <cftry>
    <cfquery name="rsChatRoomAttribute" datasource="#application.mcmsDSN#">
    SELECT * FROM v_chat_room_attribute WHERE 0=0
    <cfif ARGUMENTS.ID NEQ 0>
    AND ID = <cfqueryparam value="#ARGUMENTS.ID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.excludeID NEQ 0>
    AND ID <> <cfqueryparam value="#ARGUMENTS.excludeID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND UPPER(craName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">
    </cfif>
    <cfif ARGUMENTS.craName NEQ "">
    AND UPPER(craName) = <cfqueryparam value="#UCASE(ARGUMENTS.craName)#" cfsqltype="cf_sql_varchar">
    </cfif>
    <cfif ARGUMENTS.cratID NEQ 0>
    AND cratID = <cfqueryparam value="#ARGUMENTS.cratID#" cfsqltype="cf_sql_integer">
    </cfif>
    AND craStatus IN (<cfqueryparam value="#ARGUMENTS.craStatus#" list="yes" cfsqltype="cf_sql_integer">)
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsChatRoomAttribute = StructNew()>
    <cfset rsChatRoomAttribute.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsChatRoomAttribute>
    </cffunction>
    
    <cffunction name="getChatRoomAttributeRel" access="public" returntype="query" hint="Get Chat Room Attribute Relationship data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="ID" type="numeric" required="yes" default="0">
    <cfargument name="excludeID" type="numeric" required="yes" default="0">
    <cfargument name="crID" type="numeric" required="yes" default="0">
    <cfargument name="craID" type="numeric" required="yes" default="0">
    <cfargument name="crStatus" type="string" required="yes" default="1">
    <cfargument name="craStatus" type="string" required="yes" default="1">
    <cfargument name="crarStatus" type="string" required="yes" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="crName">
    <cfset var rsChatRoomAttributeRel = "" >
    <cftry>
    <cfquery name="rsChatRoomAttributeRel" datasource="#application.mcmsDSN#">
    SELECT * FROM v_chat_room_attribute_rel WHERE 0=0
    <cfif ARGUMENTS.ID NEQ 0>
    AND ID = <cfqueryparam value="#ARGUMENTS.ID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.excludeID NEQ 0>
    AND ID <> <cfqueryparam value="#ARGUMENTS.excludeID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(crName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(craName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">)
    </cfif>
    <cfif ARGUMENTS.crID NEQ 0>
    AND crID = <cfqueryparam value="#ARGUMENTS.crID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.craID NEQ 0>
    AND craID = <cfqueryparam value="#ARGUMENTS.craID#" cfsqltype="cf_sql_integer">
    </cfif>
    AND crStatus IN (<cfqueryparam value="#ARGUMENTS.crStatus#" list="yes" cfsqltype="cf_sql_integer">)
    AND craStatus IN (<cfqueryparam value="#ARGUMENTS.craStatus#" list="yes" cfsqltype="cf_sql_integer">)
    AND crarStatus IN (<cfqueryparam value="#ARGUMENTS.crarStatus#" list="yes" cfsqltype="cf_sql_integer">)
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsChatRoomAttributeRel = StructNew()>
    <cfset rsChatRoomAttributeRel.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsChatRoomAttributeRel>
    </cffunction>
    
    <cffunction name="getChatRoomType" access="public" returntype="query" hint="Get Chat Room Type data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="ID" type="numeric" required="yes" default="0">
    <cfargument name="excludeID" type="numeric" required="yes" default="0">
    <cfargument name="crtStatus" type="string" required="yes" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="crtName">
    <cfset var rsChatRoomType = "">
    <cftry>
    <cfquery name="rsChatRoomType" datasource="#application.mcmsDSN#">
    SELECT * FROM tbl_chat_room_type WHERE 0=0
    <cfif ARGUMENTS.ID NEQ 0>
    AND ID = <cfqueryparam value="#ARGUMENTS.ID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.excludeID NEQ 0>
    AND ID <> <cfqueryparam value="#ARGUMENTS.excludeID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND UPPER(crtName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">
    </cfif>
    AND crtStatus IN (<cfqueryparam value="#ARGUMENTS.crtStatus#" list="yes" cfsqltype="cf_sql_integer">)
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsChatRoomType = StructNew()>
    <cfset rsChatRoomType.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsChatRoomType>
    </cffunction>
    
    <cffunction name="getChatRoomAttributeType" access="public" returntype="query" hint="Get Chat Room Attribute Type data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="ID" type="numeric" required="yes" default="0">
    <cfargument name="excludeID" type="numeric" required="yes" default="0">
    <cfargument name="cratStatus" type="string" required="yes" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="cratName">
    <cfset var rsChatRoomAttributeType = "">
    <cftry>
    <cfquery name="rsChatRoomAttributeType" datasource="#application.mcmsDSN#">
    SELECT * FROM tbl_chat_room_attribute_type WHERE 0=0
    <cfif ARGUMENTS.ID NEQ 0>
    AND ID = <cfqueryparam value="#ARGUMENTS.ID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.excludeID NEQ 0>
    AND ID <> <cfqueryparam value="#ARGUMENTS.excludeID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND UPPER(cratName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">
    </cfif>
    AND cratStatus IN (<cfqueryparam value="#ARGUMENTS.cratStatus#" list="yes" cfsqltype="cf_sql_integer">)
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsChatRoomAttributeType = StructNew()>
    <cfset rsChatRoomAttributeType.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsChatRoomAttributeType>
    </cffunction>
    
    <cffunction name="getChatRoomReport" access="public" returntype="query" hint="Get Chat Room Report data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="orderBy" type="string" required="yes" default="crName">
    <cfset var rsChatRoomReport = "" >
    <cftry>
    <cfquery name="rsChatRoomReport" datasource="#application.mcmsDSN#">
    SELECT crName as Name, crDescription as Description, crSupport as Support, crSupportMessage as Support_Message, crRefreshInterval as Refresh_Interval, crAllowRoomChange as Allow_Room_Change, crCreateLog as Create_Log, appName as Application, netName as Network, crAllowPrivateMessage as Allow_Private_Message, crtName as CR_Type, crSort as Sort, sName as Status FROM v_chat_room WHERE 0=0
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(crName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(crDescription) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">)
    </cfif>
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsChatRoomReport = StructNew()>
    <cfset rsChatRoomReport.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsChatRoomReport>
    </cffunction>
    
    <cffunction name="getChatRoomUserRoleAccessRelReport" access="public" returntype="query" hint="Get Chat Room User Role Access Relationship Report data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="orderBy" type="string" required="yes" default="crName">
    <cfset var rsChatRoomUserRoleAccessRelReport = "" >
    <cftry>
    <cfquery name="rsChatRoomUserRoleAccessRelReport" datasource="#application.mcmsDSN#">
    SELECT crname as Chat_Room, urname as User_Role, uaname as User_Access, sname as Status FROM v_chat_room_ur_access_rel WHERE 0=0
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(crName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(urName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(uaName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">)
    </cfif>
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsChatRoomUserRoleAccessRelReport = StructNew()>
    <cfset rsChatRoomUserRoleAccessRelReport.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsChatRoomUserRoleAccessRelReport>
    </cffunction>
    
    <cffunction name="getChatRoomLogReport" access="public" returntype="query" hint="Get Chat Room Log Report data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="orderBy" type="string" required="yes" default="crName">
    <cfset var rsChatRoomLogReport = "" >
    <cftry>
    <cfquery name="rsChatRoomLogReport" datasource="#application.mcmsDSN#">
    SELECT crname as Chat_Room, userfname || ' ' || userlname as Chat_Room_User, TO_CHAR(crlText) as Text, TO_CHAR(crlDate,'MM/DD/YYYY') AS Chat_Room_Date, chatSessionID as Chat_Session_ID, crlIP as IP, sname as Status FROM v_chat_room_log WHERE 0=0
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(crName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(userlname) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(userfname) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(crltext) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">)
    </cfif>
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsChatRoomLogReport = StructNew()>
    <cfset rsChatRoomLogReport.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsChatRoomLogReport>
    </cffunction>
    
    <cffunction name="getChatRoomAttributeReport" access="public" returntype="query" hint="Get Chat Room Attribute Report data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="orderBy" type="string" required="yes" default="craName">
    <cfset var rsChatRoomAttributeReport = "" >
    <cftry>
    <cfquery name="rsChatRoomAttributeReport" datasource="#application.mcmsDSN#">
    SELECT craname as Name, crarequired as Required, craurl as URL, crafieldname as Field_Name, cratname as Chat_Room_Type, sname as Status FROM v_chat_room_attribute WHERE 0=0
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND UPPER(craName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">
    </cfif>
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsChatRoomAttributeReport = StructNew()>
    <cfset rsChatRoomAttributeReport.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsChatRoomAttributeReport>
    </cffunction>
    
    <cffunction name="insertChatRoom" access="public" returntype="struct">
    <cfargument name="crName" type="string" required="yes">
    <cfargument name="crDescription" type="string" required="yes">
    <cfargument name="crSupport" type="numeric" required="yes">
    <cfargument name="crSupportMessage" type="string" required="yes">
    <cfargument name="crRefreshInterval" type="numeric" required="yes">
    <cfargument name="crAllowRoomChange" type="numeric" required="yes">
    <cfargument name="crCreateLog" type="numeric" required="yes">
    <cfargument name="appID" type="numeric" required="yes">
    <cfargument name="netID" type="numeric" required="yes">
    <cfargument name="crAllowPrivateMessage" type="numeric" required="yes">
    <cfargument name="crtID" type="numeric" required="yes">
    <cfargument name="crSort" type="numeric" required="yes">
    <cfargument name="crStatus" type="numeric" required="yes">
    <!---Relationship arguments.--->
    <cfargument name="craID" type="string" required="yes">
    <cfargument name="siteNo" type="string" required="yes">
    <cfargument name="deptNo" type="string" required="yes">
    <cfset result.message = "You have successfully inserted the record.">
    <cftry>
    <!---Check for profanity in the text.--->
    <cfinvoke 
    component="MCMS.component.utility.Regex"
    method="regexProfanity"
    returnvariable="regexProfanityRet">
    <cfinvokeargument name="profanityString" value="#ARGUMENTS.crDescription#"/>
    </cfinvoke>
    <!---Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.app.chat.Chat"
    method="getChatRoom"
    returnvariable="getCheckChatRoomRet">
    <cfinvokeargument name="crName" value="#ARGUMENTS.crName#"/>
    <cfinvokeargument name="crStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckChatRoomRet.recordcount NEQ 0>
    <cfset result.message = "The name #ARGUMENTS.crName# already exists, please enter a new name.">
    <cfelseif regexProfanityRet CONTAINS '$%&*!'>
    <cfset result.message = "Some text contained profanity, please remove any profanity from your text.">
    <!---Check length restriction.--->
    <cfelseif LEN(ARGUMENTS.crDescription) GT 512>
    <cfset result.message = "The description is longer than 512 characters, please enter a new description under 512 characters.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    INSERT INTO tbl_chat_room (crName,crDescription,crSupport,crSupportMessage,crRefreshInterval,crAllowRoomChange,crCreateLog,appID,netID,crAllowPrivateMessage,crtID,crSort,crStatus) VALUES
    (
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.crName#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.crDescription#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.crSupport#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.crSupportMessage#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.crRefreshInterval#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.crAllowRoomChange#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.crCreateLog#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.appID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.netID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.crAllowPrivateMessage#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.crtID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.crSort#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.crStatus#">
    )
    </cfquery>
    </cftransaction>
    <!--- Get newly inserted chat room ID. --->
    <cfinvoke 
    component="MCMS.component.cms.Cms"
    method="getMaxValueSQL"
    returnvariable="crID">
    <cfinvokeargument name="tableName" value="tbl_chat_room"/>
    </cfinvoke>
    <cfset var.crID = crID>
    <!---Create attribute relationships.--->
    <cfloop index="craID" list="#ARGUMENTS.craID#">
    <cfinvoke 
    component="MCMS.component.app.chat.Chat"
    method="insertChatRoomAttributeRel"
    returnvariable="insertChatRoomAttributeRelRet">
    <cfinvokeargument name="crID" value="#var.crID#"/>
    <cfinvokeargument name="craID" value="#ARGUMENTS.craID#"/>
    <cfinvokeargument name="crarStatus" value="1"/>
    </cfinvoke>
    </cfloop>
    <!---Create site relationships.--->
    <cfloop index="siteNo" list="#ARGUMENTS.siteNo#">
    <cfinvoke 
    component="MCMS.component.app.chat.Chat"
    method="insertChatRoomSiteRel"
    returnvariable="insertChatRoomSiteRelRet">
    <cfinvokeargument name="crID" value="#var.crID#"/>
    <cfinvokeargument name="siteNo" value="#ARGUMENTS.siteNo#"/>
    <cfinvokeargument name="crsrStatus" value="1"/>
    </cfinvoke>
    </cfloop>
    <!---Create department relationships.--->
    <cfloop index="deptNo" list="#ARGUMENTS.deptNo#">
    <cfinvoke 
    component="MCMS.component.app.chat.Chat"
    method="insertChatRoomDepartmentRel"
    returnvariable="insertChatRoomDepartmentRelRet">
    <cfinvokeargument name="crID" value="#var.crID#"/>
    <cfinvokeargument name="deptNo" value="#ARGUMENTS.deptNo#"/>
    <cfinvokeargument name="crdrStatus" value="1"/>
    </cfinvoke>
    </cfloop>
    </cfif>
    <cfcatch type="any">
    <cfset result.message = "There was an error inserting the record.">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="insertChatRoomUserRoleAccessRel" access="public" returntype="struct">
    <cfargument name="crID" type="numeric" required="yes">
    <cfargument name="urID" type="numeric" required="yes">
    <cfargument name="uaID" type="numeric" required="yes">
    <cfargument name="crurarStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully inserted the record.">
    <cftry>
    <!---Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.app.chat.Chat"
    method="getChatRoomUserRoleAccessRel"
    returnvariable="getCheckChatRoomUserRoleAccessRelRet">
    <cfinvokeargument name="crID" value="#ARGUMENTS.crID#"/>
    <cfinvokeargument name="urID" value="#ARGUMENTS.urID#"/>
    <cfinvokeargument name="uaID" value="#ARGUMENTS.uaID#"/>
    <cfinvokeargument name="crurarStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckChatRoomUserRoleAccessRelRet.recordcount NEQ 0>
    <cfset result.message = "The chat room user role access relationship already exists, please try again.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    INSERT INTO tbl_chat_room_ur_access_rel (crID,urID,uaID,crurarStatus) VALUES
    (
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.crID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.urID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.uaID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.crurarStatus#">
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
    
    <cffunction name="insertChatRoomAttribute" access="public" returntype="struct">
    <cfargument name="craName" type="string" required="yes">
    <cfargument name="craRequired" type="numeric" required="yes">
    <cfargument name="cratID" type="numeric" required="yes">
    <cfargument name="craURL" type="string" required="yes">
    <cfargument name="craFieldName" type="string" required="yes">
    <cfargument name="craStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully inserted the record.">
    <cftry>
    <!---Check for profanity in the text.--->
    <cfinvoke 
    component="MCMS.component.utility.Regex"
    method="regexProfanity"
    returnvariable="regexProfanityRet">
    <cfinvokeargument name="profanityString" value="#ARGUMENTS.craName#"/>
    </cfinvoke>
    <!---Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.app.chat.Chat"
    method="getChatRoomAttribute"
    returnvariable="getCheckChatRoomAttributeRet">
    <cfinvokeargument name="craName" value="#ARGUMENTS.craName#"/>
    <cfinvokeargument name="craStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckChatRoomAttributeRet.recordcount NEQ 0>
    <cfset result.message = "The name #ARGUMENTS.craName# already exists, please enter a new name.">
    <cfelseif regexProfanityRet CONTAINS '$%&*!'>
    <cfset result.message = "Some text contained profanity, please remove any profanity from your text.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    INSERT INTO tbl_chat_room_attribute (craName,craRequired,cratID,craUrl,craFieldName,craStatus) VALUES
    (
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.craName#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.craRequired#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.cratID#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.craUrl#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.craFieldName#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.craStatus#">
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
    
    <cffunction name="insertChatRoomSiteRel" access="public" returntype="struct">
    <cfargument name="crID" type="numeric" required="yes">
    <cfargument name="siteNo" type="numeric" required="yes">
    <cfargument name="crsrStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully inserted the record.">
    <cftry>
    <!---Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.app.chat.Chat"
    method="getChatRoomSiteRel"
    returnvariable="getCheckChatRoomSiteRelRet">
    <cfinvokeargument name="crID" value="#ARGUMENTS.crID#"/>
    <cfinvokeargument name="siteNo" value="#ARGUMENTS.siteNo#"/>
    <cfinvokeargument name="crsrStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckChatRoomSiteRelRet.recordcount NEQ 0>
    <cfset result.message = "The chat room site relationship already exists, please try again.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    INSERT INTO tbl_chat_room_site_rel (crID,siteNo,crsrStatus) VALUES
    (
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.crID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.siteNo#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.crsrStatus#">
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
    
    <cffunction name="insertChatRoomDepartmentRel" access="public" returntype="struct">
    <cfargument name="crID" type="numeric" required="yes">
    <cfargument name="deptNo" type="numeric" required="yes">
    <cfargument name="crdrStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully inserted the record.">
    <cftry>
    <!---Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.app.chat.Chat"
    method="getChatRoomDepartmentRel"
    returnvariable="getCheckChatRoomDepartmentRelRet">
    <cfinvokeargument name="crID" value="#ARGUMENTS.crID#"/>
    <cfinvokeargument name="deptNo" value="#ARGUMENTS.deptNo#"/>
    <cfinvokeargument name="crdrStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckChatRoomDepartmentRelRet.recordcount NEQ 0>
    <cfset result.message = "The chat room department relationship already exists, please try again.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    INSERT INTO tbl_chat_room_department_rel (crID,deptNo,crdrStatus) VALUES
    (
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.crID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.deptNo#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.crdrStatus#">
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
    
    <cffunction name="insertChatRoomAttributeRel" access="public" returntype="struct">
    <cfargument name="crID" type="numeric" required="yes">
    <cfargument name="craID" type="numeric" required="yes">
    <cfargument name="crarStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully inserted the record.">
    <cftry>
    <!---Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.app.chat.Chat"
    method="getChatRoomAttributeRel"
    returnvariable="getCheckChatRoomAttributeRelRet">
    <cfinvokeargument name="crID" value="#ARGUMENTS.crID#"/>
    <cfinvokeargument name="craID" value="#ARGUMENTS.craID#"/>
    <cfinvokeargument name="crarStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckChatRoomAttributeRelRet.recordcount NEQ 0>
    <cfset result.message = "The chat room attribute relationship already exists, please try again.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    INSERT INTO tbl_chat_room_attribute_rel (crID,craID,crarStatus) VALUES
    (
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.crID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.craID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.crarStatus#">
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
    
    <cffunction name="insertChatRoomLogAsync" access="remote" returntype="string">
    <cfargument name="crID" type="numeric" required="yes">
    <cfargument name="crlText" type="string" required="yes">
    <cfargument name="userIDPost" type="numeric" required="yes">
    <cfargument name="userIDReply" type="numeric" required="yes">
    <cfargument name="chatSessionID" type="string" required="yes">
    <cfargument name="crlIP" type="string" required="yes">
    <cfargument name="crlStatus" type="numeric" required="yes">
    <cfargument name="siteDSN" type="string" required="yes" default="swweb">
    <cfset result = "">
    <cftry>
    <cfif LEN(ARGUMENTS.crlText) GT 2000>
    <cfset result = "The message is longer than 2000 characters, please enter a new message under 2000 characters.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#ARGUMENTS.mcmsDSN#">
    INSERT INTO tbl_chat_room_log (crID,crlText,userIDPost,userIDReply,chatSessionID,crlIP,crlStatus) VALUES
    (
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.crID#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.crlText#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.userIDPost#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.userIDReply#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.chatSessionID#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.crlIP#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.crlStatus#">
    )
    </cfquery>
    </cftransaction>
    </cfif>
    <cfcatch type="any">
    <cfset result = "There was an error sending the chat message.">
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="insertChatRoomLogAttrValue" access="public" returntype="struct">
    <cfargument name="crID" type="numeric" required="yes">
    <cfargument name="craID" type="numeric" required="yes">
    <cfargument name="chatSessionID" type="string" required="yes">
    <cfargument name="crlavValue" type="string" required="yes">
    <cfargument name="crlavStatus" type="numeric" required="yes">
    <cfset result.message = "Attribute successfully applied.">
    <cftry>
    <!---Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.app.chat.Chat"
    method="getChatRoomLogAttrValue"
    returnvariable="getChatRoomLogAttrValueRet">
    <cfinvokeargument name="crID" value="#ARGUMENTS.crID#"/>
    <cfinvokeargument name="craID" value="#ARGUMENTS.craID#"/>
    <cfinvokeargument name="chatSessionID" value="#ARGUMENTS.chatSessionID#"/>
    <cfinvokeargument name="crlavStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getChatRoomLogAttrValueRet.recordcount NEQ 0>
    <cfset result.message = "The chat room attribute relationship already exists, please try again.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    INSERT INTO tbl_chat_room_log_attr_value (crID,craID,chatSessionID,crlavValue,crlavStatus) VALUES
    (
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.crID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.craID#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.chatSessionID#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.crlavValue#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.crlavStatus#">
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
    
    <cffunction name="updateChatRoom" access="public" returntype="struct">
    <cfargument name="ID" type="numeric" required="yes">
    <cfargument name="crName" type="string" required="yes">
    <cfargument name="crDescription" type="string" required="yes">
    <cfargument name="crSupport" type="numeric" required="yes">
    <cfargument name="crSupportMessage" type="string" required="yes">
    <cfargument name="crRefreshInterval" type="numeric" required="yes">
    <cfargument name="crAllowRoomChange" type="numeric" required="yes">
    <cfargument name="crCreateLog" type="numeric" required="yes">
    <cfargument name="appID" type="numeric" required="yes">
    <cfargument name="netID" type="numeric" required="yes">
    <cfargument name="crAllowPrivateMessage" type="numeric" required="yes">
    <cfargument name="crtID" type="numeric" required="yes">
    <cfargument name="crSort" type="numeric" required="yes">
    <cfargument name="crStatus" type="numeric" required="yes">
    <!---Relationship arguments.--->
    <cfargument name="craID" type="string" required="yes">
    <cfargument name="siteNo" type="string" required="yes">
    <cfargument name="deptNo" type="string" required="yes">
    <cfset result.message = "You have successfully updated the record.">
    <cftry>
    <!---Check for profanity in the text.--->
    <cfinvoke 
    component="MCMS.component.utility.Regex"
    method="regexProfanity"
    returnvariable="regexProfanityRet">
    <cfinvokeargument name="profanityString" value="#ARGUMENTS.crDescription#"/>
    </cfinvoke>
    <!---Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.app.chat.Chat"
    method="getChatRoom"
    returnvariable="getCheckChatRoomRet">
    <cfinvokeargument name="excludeID" value="#ARGUMENTS.ID#"/>
    <cfinvokeargument name="crName" value="#ARGUMENTS.crName#"/>
    <cfinvokeargument name="crStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckChatRoomRet.recordcount NEQ 0>
    <cfset result.message = "The name #ARGUMENTS.crName# already exists, please enter a new name.">
    <cfelseif regexProfanityRet CONTAINS '$%&*!'>
    <cfset result.message = "Some text contained profanity, please remove any profanity from your text.">
    <!---Check length restriction.--->
    <cfelseif LEN(ARGUMENTS.crDescription) GT 512>
    <cfset result.message = "The description is longer than 512 characters, please enter a new description under 512 characters.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_chat_room SET
    crName = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.crName#">,
    crDescription = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.crDescription#">,
    crSupport = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.crSupport#">,
    crSupportMessage = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.crSupportMessage#">,
    crRefreshInterval = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.crRefreshInterval#">,
    crAllowRoomChange = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.crAllowRoomChange#">,
    crCreateLog = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.crCreateLog#">,
    appID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.appID#">,
    netID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.netID#">,
    crAllowPrivateMessage = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.crAllowPrivateMessage#">,
    crtID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.crtID#">,
    crSort = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.crSort#">,
    crStatus = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.crStatus#">
    WHERE ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ID#">
    </cfquery>
    </cftransaction>
    <!---Delete any existing relationships.--->
    <cfinvoke 
    component="MCMS.component.app.chat.Chat"
    method="deleteChatRoomAttributeRel"
    returnvariable="deleteChatRoomAttibuteRelRet">
    <cfinvokeargument name="crID" value="#ARGUMENTS.ID#"/>
    </cfinvoke>
    <cfinvoke 
    component="MCMS.component.app.chat.Chat"
    method="deleteChatRoomSiteRel"
    returnvariable="deleteChatRoomSiteRelRet">
    <cfinvokeargument name="crID" value="#ARGUMENTS.ID#"/>
    </cfinvoke>
    <cfinvoke 
    component="MCMS.component.app.chat.Chat"
    method="deleteChatRoomDepartmentRel"
    returnvariable="deleteAuctionDepartmentRelRet">
    <cfinvokeargument name="crID" value="#ARGUMENTS.ID#"/>
    </cfinvoke>
    <!---Create attribute relationships.--->
    <cfloop index="craID" list="#ARGUMENTS.craID#">
    <cfinvoke 
    component="MCMS.component.app.chat.Chat"
    method="insertChatRoomAttributeRel"
    returnvariable="insertChatRoomAttributeRelRet">
    <cfinvokeargument name="crID" value="#ARGUMENTS.ID#"/>
    <cfinvokeargument name="craID" value="#ARGUMENTS.craID#"/>
    <cfinvokeargument name="crarStatus" value="1"/>
    </cfinvoke>
    </cfloop>
    <!---Create site relationships.--->
    <cfloop index="siteNo" list="#ARGUMENTS.siteNo#">
    <cfinvoke 
    component="MCMS.component.app.chat.Chat"
    method="insertChatRoomSiteRel"
    returnvariable="insertChatRoomSiteRelRet">
    <cfinvokeargument name="crID" value="#ARGUMENTS.ID#"/>
    <cfinvokeargument name="siteNo" value="#ARGUMENTS.siteNo#"/>
    <cfinvokeargument name="crsrStatus" value="1"/>
    </cfinvoke>
    </cfloop>
    <!---Create department relationships.--->
    <cfloop index="deptNo" list="#ARGUMENTS.deptNo#">
    <cfinvoke 
    component="MCMS.component.app.chat.Chat"
    method="insertChatRoomDepartmentRel"
    returnvariable="insertChatRoomDepartmentRelRet">
    <cfinvokeargument name="crID" value="#ARGUMENTS.ID#"/>
    <cfinvokeargument name="deptNo" value="#ARGUMENTS.deptNo#"/>
    <cfinvokeargument name="crdrStatus" value="1"/>
    </cfinvoke>
    </cfloop>
    </cfif>
    <cfcatch type="any">
    <cfset result.message = "There was an error updating the record.">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="updateChatRoomUserRoleAccessRel" access="public" returntype="struct">
    <cfargument name="ID" type="numeric" required="yes">
    <cfargument name="crID" type="numeric" required="yes">
    <cfargument name="urID" type="numeric" required="yes">
    <cfargument name="uaID" type="numeric" required="yes">
    <cfargument name="crurarStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully updated the record.">
    <cftry>
    <!---Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.app.chat.Chat"
    method="getChatRoomUserRoleAccessRel"
    returnvariable="getCheckChatRoomUserRoleAccessRelRet">
    <cfinvokeargument name="excludeID" value="#ARGUMENTS.ID#"/>
    <cfinvokeargument name="crID" value="#ARGUMENTS.crID#"/>
    <cfinvokeargument name="urID" value="#ARGUMENTS.urID#"/>
    <cfinvokeargument name="urID" value="#ARGUMENTS.urID#"/>
    <cfinvokeargument name="crurarStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckChatRoomUserRoleAccessRelRet.recordcount NEQ 0>
    <cfset result.message = "The chat room user role access relationship already exists, please try again.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_chat_room_ur_access_rel SET
    crID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.crID#">,
    urID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.urID#">,
    uaID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.uaID#">,
    crurarStatus = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.crurarStatus#">
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
    
    <cffunction name="updateChatRoomAttribute" access="public" returntype="struct">
    <cfargument name="ID" type="numeric" required="yes">
    <cfargument name="craName" type="string" required="yes">
    <cfargument name="craRequired" type="numeric" required="yes">
    <cfargument name="cratID" type="numeric" required="yes">
    <cfargument name="craUrl" type="string" required="yes">
    <cfargument name="craFieldName" type="string" required="yes">
    <cfargument name="craStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully updated the record.">
    <cftry>
    <!---Check for profanity in the text.--->
    <cfinvoke 
    component="MCMS.component.utility.Regex"
    method="regexProfanity"
    returnvariable="regexProfanityRet">
    <cfinvokeargument name="profanityString" value="#ARGUMENTS.craName#"/>
    </cfinvoke>
    <!---Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.app.chat.Chat"
    method="getChatRoomAttribute"
    returnvariable="getCheckChatRoomAttributeRet">
    <cfinvokeargument name="excludeID" value="#ARGUMENTS.ID#"/>
    <cfinvokeargument name="craName" value="#ARGUMENTS.craName#"/>
    <cfinvokeargument name="craStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckChatRoomAttributeRet.recordcount NEQ 0>
    <cfset result.message = "The name #ARGUMENTS.craName# already exists, please enter a new name.">
    <cfelseif regexProfanityRet CONTAINS '$%&*!'>
    <cfset result.message = "Some text contained profanity, please remove any profanity from your text.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_chat_room_attribute SET
    craName = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.craName#">,
    craRequired = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.craRequired#">,
    cratID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.cratID#">,
    craUrl = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.craUrl#">,
    craFieldName = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.craFieldName#">,
    craStatus = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.craStatus#">
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
    
    <cffunction name="updateChatRoomList" access="public" returntype="struct">
    <cfargument name="ID" type="numeric" required="yes">
    <cfargument name="crStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully updated the records.">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_chat_room SET
    crStatus = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.crStatus#">
    WHERE ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ID#">
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error updating the records.">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="updateChatRoomUserRoleAccessRelList" access="public" returntype="struct">
    <cfargument name="ID" type="numeric" required="yes">
    <cfargument name="crurarStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully updated the records.">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_chat_room_ur_access_rel SET
    crurarStatus = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.crurarStatus#">
    WHERE ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ID#">
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error updating the records.">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="updateChatRoomAttributeList" access="public" returntype="struct">
    <cfargument name="ID" type="numeric" required="yes">
    <cfargument name="craStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully updated the records.">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_chat_room_attribute SET
    craStatus = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.craStatus#">
    WHERE ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ID#">
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error updating the records.">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="deleteChatRoom" access="public" returntype="struct">
    <cfargument name="ID" type="string" required="yes">
    <cfset result.message = "You have successfully deleted the record(s).">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    DELETE FROM tbl_chat_room
    WHERE ID IN (<cfqueryparam cfsqltype="cf_sql_integer" list="yes" value="#ARGUMENTS.ID#">)
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error deleting the record(s).">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>  
    
    <cffunction name="deleteChatRoomUserRoleAccessRel" access="public" returntype="struct">
    <cfargument name="ID" type="string" required="yes">
    <cfset result.message = "You have successfully deleted the record(s).">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    DELETE FROM tbl_chat_room_ur_access_rel
    WHERE ID IN (<cfqueryparam cfsqltype="cf_sql_integer" list="yes" value="#ARGUMENTS.ID#">)
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error deleting the record(s).">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>   
    
    <cffunction name="deleteChatRoomDepartmentRel" access="public" returntype="struct">
    <cfargument name="ID" type="string" required="yes" default="0">
    <cfargument name="crID" type="string" required="yes" default="0">
    <cfset result.message = "You have successfully deleted the record(s).">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    DELETE FROM tbl_chat_room_department_rel
    WHERE ID IN (<cfqueryparam cfsqltype="cf_sql_integer" list="yes" value="#ARGUMENTS.ID#">)
    OR crID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.crID#">
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error deleting the record(s).">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction> 
    
    <cffunction name="deleteChatRoomSiteRel" access="public" returntype="struct">
    <cfargument name="ID" type="string" required="yes" default="0">
    <cfargument name="crID" type="string" required="yes" default="0">
    <cfset result.message = "You have successfully deleted the record(s).">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    DELETE FROM tbl_chat_room_site_rel
    WHERE ID IN (<cfqueryparam cfsqltype="cf_sql_integer" list="yes" value="#ARGUMENTS.ID#">)
    OR crID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.crID#">
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error deleting the record(s).">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="deleteChatRoomAttribute" access="public" returntype="struct">
    <cfargument name="ID" type="string" required="yes">
    <cfset result.message = "You have successfully deleted the record(s).">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    DELETE FROM tbl_chat_room_attribute
    WHERE ID IN (<cfqueryparam cfsqltype="cf_sql_integer" list="yes" value="#ARGUMENTS.ID#">)
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error deleting the record(s).">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction> 
    
    <cffunction name="deleteChatRoomAttributeRel" access="public" returntype="struct">
    <cfargument name="ID" type="string" required="yes" default="0">
    <cfargument name="crID" type="string" required="yes" default="0">
    <cfset result.message = "You have successfully deleted the record(s).">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    DELETE FROM tbl_chat_room_attribute_rel
    WHERE ID IN (<cfqueryparam cfsqltype="cf_sql_integer" list="yes" value="#ARGUMENTS.ID#">)
    OR crID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.crID#">
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error deleting the record(s).">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="chatGetUser" access="public" returntype="struct">
    <cflock scope="APPLICATION" type="READONLY" timeout="10">
    <cfset usrs=StructNew()>
    <cfset usrs=StructCopy(APPLICATION['cr_queue'].users)>
    </cflock>
    <cfreturn usrs>
    </cffunction>
    
    <cffunction name="chatSignIn" access="public" returntype="struct">
    <cfargument name="crID" type="string" required="yes" default="0"> 
    <cfargument name="crtID" type="string" required="yes" default="0"> 
    <cfset result.message = "You have successfully signed in.">
    <!--- Construct list of chat rooms that are created. --->
    <cfif isDefined("application.crID") AND application.crID NEQ "">
    <cfset this.roomAdded = false>
    <cfloop index="i" list="#application.crID#">
    <cfif i EQ ARGUMENTS.crID>
    <cfset this.roomAdded = true>
    </cfif>
    </cfloop>
    <!--- Do not append to list if it already exists. --->
    <cfif this.roomAdded EQ false>
    <cfset application.crID = application.crID & "," & ARGUMENTS.crID>
    </cfif>
    <cfelse>
	<cfset application.crID = ARGUMENTS.crID>
    </cfif>
    <cfswitch expression="#ARGUMENTS.crtID#">
    <!--- Support room. Put the user in the queue. --->
    <cfcase value="2">
     <!---Set user chat session ID (APPLICATION scope).--->
    <cfif NOT IsDefined("application.chatSessionID")>
    <cfset chatRoomDate = DateFormat(Now(), "yymmdd")>
    <cfset chatRoomTime = TimeFormat(Now(), "hhmmss")>
    <cfset application.chatSessionID = chatRoomDate & chatRoomTime>
    </cfif>
    <cfset session.chatSignInDate = Now()>
    <cfset session.chatLastActivity = Now()>
    <cfset session.crID = ARGUMENTS.crID>
    <cfif NOT IsDefined("application.cr_queue")>
    <cflock scope="APPLICATION" timeout="10" type="EXCLUSIVE">
    <!--- Create the rooms struct. --->
    <cfset APPLICATION["cr_queue"]=StructNew()>
    </cflock>
    </cfif>
    <cfif NOT IsDefined("application.cr_queue.users")>
    <cfset temp=StructInsert(APPLICATION["cr_queue"], "users", StructNew())>
    </cfif>
    <!--- Create user structure. --->
    <cfset chatUser=StructNew()>
    <cfset temp=StructInsert(chatUser,"admin", "false")>
    <cfset temp=StructInsert(chatUser,"lastupdate", Now())>
    <cfset temp=StructInsert(chatUser,"name", session.userName)>
    <cfset temp=StructInsert(chatUser,"id", session.userID)>
    <cfset temp=StructInsert(chatUser,"chatSessionID", application.chatSessionID)>
    <cfset temp=StructInsert(chatUser,"ip", CGI.REMOTE_ADDR)>
    <cfif NOT IsDefined("application.cr_queue.users.cru#session.userID#") AND ArrayLen(StructFindValue(Evaluate('application.cr_queue.users'), session.userName)) EQ 0>
    <!--- Add the user to the room structure. --->
    <cflock scope="APPLICATION" timeout="10" type="EXCLUSIVE">
    <cfset temp=StructInsert(APPLICATION['cr_queue'].users, "cru#session.userID#", StructCopy(chatUser))>
    </cflock>
    </cfif>
    </cfcase>
    <cfdefaultcase>
    <!---Set user chat session ID (APPLICATION scope).--->
    <cfif NOT IsDefined("application.chatSessionID")>
    <cfset chatRoomDate = DateFormat(Now(), "yymmdd")>
    <cfset chatRoomTime = TimeFormat(Now(), "hhmmss")>
    <cfset application.chatSessionID = chatRoomDate & chatRoomTime>
    </cfif>
    <cfset session.chatSignInDate = Now()>
    <cfset session.chatLastActivity = Now()>
    <cfset session.crID = ARGUMENTS.crID>
    <cfif NOT IsDefined("application.#ARGUMENTS.crID#")>
    <cflock scope="APPLICATION" timeout="10" type="EXCLUSIVE">
    <!--- Create the rooms struct. --->
    <cfset APPLICATION[ARGUMENTS.crID]=StructNew()>
    </cflock>
    </cfif>
    <cfif NOT IsDefined("application.#ARGUMENTS.crID#.users")>
    <cfset temp=StructInsert(APPLICATION[ARGUMENTS.crID], "users", StructNew())>
    </cfif>
    <!--- Create user structure. --->
    <cfset chatUser=StructNew()>
    <cfset temp=StructInsert(chatUser,"admin", "false")>
    <cfset temp=StructInsert(chatUser,"lastupdate", Now())>
    <cfset temp=StructInsert(chatUser,"name", session.userName)>
    <cfset temp=StructInsert(chatUser,"id", session.userID)>
    <cfset temp=StructInsert(chatUser,"chatsessionid", application.chatSessionID)>
    <cfset temp=StructInsert(chatUser,"ip", CGI.REMOTE_ADDR)>
    <cfif NOT IsDefined("application.#ARGUMENTS.crID#.users.cru#session.userID#") AND ArrayLen(StructFindValue(Evaluate('application.#ARGUMENTS.crID#.users'), session.userName)) EQ 0>
    <!--- Add the user to the room structure. --->
    <cflock scope="APPLICATION" timeout="10" type="EXCLUSIVE">
    <cfset temp=StructInsert(APPLICATION[ARGUMENTS.crID].users, "cru#session.userID#", StructCopy(chatUser))>
    <cflocation url="/chat/?mcmsID=chat&crID=#url.crID#&cruID=#url.cruID#&entryType=1" addtoken="no">
    </cflock>
    <cfelse>
    <!--- Username already in use. ---> 
    <cfset result.message = "The username #session.userName# already in use, please use a different name.">
    </cfif>
    </cfdefaultcase>
    </cfswitch>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="chatFromQueueToPrivateRoom" access="public" returntype="void">
    <cfargument name="cruID" type="string" required="yes" default="0">
    <cfargument name="cruName" type="string" required="yes" default="0">
    <cfargument name="crlIP" type="string" required="yes" default="0">
    <cfset chatRoomDate = DateFormat(Now(), "yymmdd")>
    <cfset chatRoomTime = TimeFormat(Now(), "hhmmss")>
    <cfset application.chatSessionID = chatRoomDate & chatRoomTime>
    <!--- Construct list of chat rooms. --->
    <cfif isDefined("application.crID") AND application.crID NEQ "">
    <cfset this.roomAdded = false>
    <cfloop index="i" list="#application.crID#">
    <cfif i EQ "cr_#ARGUMENTS.cruID#">
    <cfset this.roomAdded = true>
    </cfif>
    </cfloop>
    <!--- Do not append to list if it already exists. --->
    <cfif this.roomAdded EQ false>
    <cfset application.crID = application.crID & ",cr_" & ARGUMENTS.cruID>
    </cfif>
    <cfelse>
	<cfset application.crID = "cr_" & ARGUMENTS.cruID>
    </cfif>    
    <cfset temp=StructDelete(APPLICATION['cr_queue'].users, 'cru#ARGUMENTS.cruID#')>
    <cfif NOT IsDefined("application.cr_#ARGUMENTS.cruID#")>
    <cflock scope="APPLICATION" timeout="10" type="EXCLUSIVE">
    <!--- Create the rooms struct. --->
    <cfset APPLICATION["cr_#ARGUMENTS.cruID#"]=StructNew()>
    </cflock>
    </cfif>
    <cfif NOT IsDefined("application.cr_#ARGUMENTS.cruID#.users")>
    <cfset temp=StructInsert(APPLICATION["cr_#ARGUMENTS.cruID#"], "users", StructNew())>
    </cfif>
    <!--- Create admin user structure. --->
    <cfset chatAdminUser=StructNew()>
    <cfset temp=StructInsert(chatAdminUser,"admin", "true")>
    <cfset temp=StructInsert(chatAdminUser,"lastupdate", Now())>
    <cfset temp=StructInsert(chatAdminUser,"name", session.userName)>
    <cfset temp=StructInsert(chatAdminUser,"id", session.userID)>
    <cfset temp=StructInsert(chatAdminUser,"chatsessionID", application.chatSessionID)>
    <cfset temp=StructInsert(chatAdminUser,"ip", CGI.REMOTE_ADDR)>
    <cfif NOT IsDefined("application.cr_#ARGUMENTS.cruID#.users.cru#session.userID#") AND ArrayLen(StructFindValue(Evaluate('application.cr_#ARGUMENTS.cruID#.users'), session.userName)) EQ 0>
    <!--- Add the admin user to the room structure. --->
    <cflock scope="APPLICATION" timeout="10" type="EXCLUSIVE">
    <cfset temp=StructInsert(APPLICATION['cr_#ARGUMENTS.cruID#'].users, "cru#session.userID#", StructCopy(chatAdminUser))>
    </cflock>
    </cfif>
    <!--- Create user structure. --->
    <cfset chatUser=StructNew()>
    <cfset temp=StructInsert(chatUser,"admin", "false")>
    <cfset temp=StructInsert(chatUser,"lastupdate", Now())>
    <cfset temp=StructInsert(chatUser,"name", ARGUMENTS.cruName)>
    <cfset temp=StructInsert(chatUser,"id", ARGUMENTS.cruID)>
    <cfset temp=StructInsert(chatUser,"chatsessionID", application.chatSessionID)>
    <cfset temp=StructInsert(chatUser,"ip", ARGUMENTS.crlIP)>
    <cfif NOT IsDefined("application.cr_#ARGUMENTS.cruID#.users.cru#ARGUMENTS.cruID#") AND ArrayLen(StructFindValue(Evaluate('application.cr_#ARGUMENTS.cruID#.users'), ARGUMENTS.cruID)) EQ 0>
    <!--- Add the user to the room structure. --->
    <cflock scope="APPLICATION" timeout="10" type="EXCLUSIVE">
    <cfset temp=StructInsert(APPLICATION['cr_#ARGUMENTS.cruID#'].users, "cru#ARGUMENTS.cruID#", StructCopy(chatUser))>
    </cflock>
    </cfif>    
    </cffunction>
    
    <cffunction name="chatSetUserAdmin" access="public" returntype="void">
    <cfargument name="flag" type="string" required="yes" default="false">
	<cfif NOT isDefined("application.chatAdmin")>
    <cfset application.chatAdmin = ARGUMENTS.flag>
    </cfif>
    </cffunction>
    
    <cffunction name="chatDeleteUserFromRoom" access="public" returntype="void">
    <cfargument name="crID" type="string" required="yes" default="0">
    <!--- Delete user from the queue. --->
    <cfif IsDefined("application.cr_queue.users.cru#session.userID#")>
    <cfset temp=StructDelete(APPLICATION['cr_queue'].users, 'cru#session.userID#')>
    </cfif>
    <!--- Search for user in all rooms and delete. --->
    <cfif ARGUMENTS.crID EQ 0>
    <cfif isDefined("application.crID")>
    <cfloop index="i" list="#application.crID#">
    <cfif isDefined("application.#i#")>
    <cflock scope="APPLICATION" type="READONLY" timeout="10">
    <cfset usrs=StructNew()>
    <cfset usrs=StructCopy(APPLICATION['#i#'].users)>
    </cflock>
    <cfset ausrs=StructKeyArray(usrs)>
    <!--- Delete room when last person wants to leave it. --->
    <cfif ArrayLen(ausrs) EQ 1>
    <cfset temp=StructDelete(APPLICATION, '#i#')>
    <!--- Remove room from room list when more than one. --->
    <cfif ListLen(application.crID) GT 1>
    <cfset application.crID = Replace(application.crID, ",cr_#i#", "", "ALL")>
    <!--- Delete room from application when last one. --->
    <cfelse>
    <cfset temp=StructDelete(APPLICATION, 'crID')>
    </cfif>
    <!--- Otherwise delete user from room and log that they left. --->
    <cfelse>
    <cfif IsDefined("application.#i#.users.cru#session.userID#")>
    <cfinvoke 
    component="MCMS.component.app.chat.Chat"
    method="insertChatRoomLogAsync"
    returnvariable="insertChatRoomLogAsyncRet">
    <cfinvokeargument name="crID" value="0"/>
    <cfinvokeargument name="crlText" value="#Evaluate('application.#i#.users.cru#session.userID#.name')# has left the room."/>
    <cfinvokeargument name="userIDPost" value="0"/>
    <cfinvokeargument name="userIDReply" value="0"/>
    <cfinvokeargument name="chatSessionID" value="#Evaluate('application.#i#.users.cru#session.userID#.chatSessionID')#"/>
	<cfinvokeargument name="crlIP" value="#CGI.REMOTE_ADDR#"/>
	<cfinvokeargument name="crlStatus" value="1"/>
	<cfinvokeargument name="siteDSN" value="#application.mcmsDSN#"/>
    </cfinvoke>
    <cfset temp=StructDelete(APPLICATION['#i#'].users, 'cru#session.userID#')>
    </cfif>
    </cfif>
    </cfif>
    </cfloop>
    </cfif>
    <!--- Search for user in a specific room. --->
    <cfelse>
    <cflock scope="APPLICATION" type="READONLY" timeout="10">
    <cfset usrs=StructNew()>
    <cfset usrs=StructCopy(APPLICATION['cr_#ARGUMENTS.crID#'].users)>
    </cflock>
    <cfset ausrs=StructKeyArray(usrs)>
    <!--- Delete room when last person wants to leave it. --->
    <cfif ArrayLen(ausrs) EQ 1>
    <cfset temp=StructDelete(APPLICATION, 'cr_#ARGUMENTS.crID#')>
     <!--- Remove room from room list when more than one. --->
    <cfif ListLen(application.crID) GT 1>
    <cfset application.crID = Replace(application.crID, ",#crID#", "", "ALL")>
    <!--- Delete room from application when last one. --->
    <cfelse>
    <cfset temp=StructDelete(APPLICATION, 'crID')>
    </cfif>
    <!--- Otherwise delete user from room. --->
    <cfelse>
    <cfif IsDefined("application.cr_#ARGUMENTS.crID#.users.cru#session.userID#")>
    <cfinvoke 
    component="MCMS.component.app.chat.Chat"
    method="insertChatRoomLogAsync"
    returnvariable="insertChatRoomLogAsyncRet">
    <cfinvokeargument name="crID" value="#ARGUMENTS.crID#"/>
    <cfinvokeargument name="crlText" value="#Evaluate('application.cr_#ARGUMENTS.crID#.users.cru#session.userID#.name')# has left the room."/>
    <cfinvokeargument name="userIDPost" value="0"/>
    <cfinvokeargument name="userIDReply" value="0"/>
    <cfinvokeargument name="chatSessionID" value="#Evaluate('application.cr_#ARGUMENTS.crID#.users.cru#session.userID#.chatSessionID')#"/>
	<cfinvokeargument name="crlIP" value="#CGI.REMOTE_ADDR#"/>
	<cfinvokeargument name="crlStatus" value="1"/>
	<cfinvokeargument name="siteDSN" value="#application.mcmsDSN#"/>
    </cfinvoke>
    <cfset temp=StructDelete(APPLICATION['cr_#ARGUMENTS.crID#'].users, 'cru#session.userID#')>    
    </cfif>
    </cfif>
    </cfif>
    </cffunction>
    
    <cffunction name="chatUserExitsInRoom" access="public" returntype="string">
    <cfargument name="crID" type="numeric" required="yes" default="0">
    <cfargument name="userID" type="numeric" required="yes" default="0">
    <cfset found = "false">
    <cflock scope="APPLICATION" type="READONLY" timeout="10">
    <cfset usrs=StructNew()>
    <cfset usrs=StructCopy(APPLICATION['cr_#ARGUMENTS.crID#'].users)>
    </cflock>
    <cfset ausrs=StructKeyArray(usrs)>
    <cfloop index="i" from="1" to="#ArrayLen(ausrs)#">
    <cfset usrID=usrs[ausrs[i]].id>
    <cfif ARGUMENTS.userID EQ usrID>
    <cfset found = true>
    </cfif>
    </cfloop>
    <cfreturn found>
    </cffunction>
    
    <cffunction name="chatChangeRoom" access="public" returntype="struct">
    <cfargument name="fcrID" type="string" required="yes" default="0">
    <cfargument name="tcrID" type="string" required="yes" default="">
    <cfset result.message = "">
    <cftry>
    <cfinvoke 
    component="MCMS.component.app.chat.Chat"
    method="getChatRoom"
    returnvariable="getChatRoomRet">
    <cfinvokeargument name="ID" value="#Replace(ARGUMENTS.tcrID, 'cr_', '', 'ALL')#"/>
    <cfinvokeargument name="crStatus" value="1"/>
    </cfinvoke>
    <cfswitch expression="#getChatRoomRet.crtID#">
    <!--- Change to support room. --->
    <cfcase value="2">
    <!--- Construct list of users. --->   
    <cfif isDefined("application.#ARGUMENTS.fcrID#")>
    <cflock scope="APPLICATION" type="READONLY" timeout="10">
    <cfset usrs=StructNew()>
    <cfset usrs=StructCopy(APPLICATION['#ARGUMENTS.fcrID#'].users)>
    </cflock>
    <cfset ausrs=StructKeyArray(usrs)>
    <!--- Delete room when last person wants to leave it. --->
    <cfif ArrayLen(ausrs) EQ 1>
    <cfset temp=StructDelete(APPLICATION, '#ARGUMENTS.fcrID#')>
    <cfif ListLen(application.crID) GT 1>
    <cfset application.crID = Replace(application.crID, ",#ARGUMENTS.fcrID#", "", "ALL")>
    <!--- Delete room from application when last one. --->
    <cfelse>
    <cfset temp=StructDelete(APPLICATION, 'crID')>
    </cfif>
    <cfelse>
    <!--- Remove user from room they just left. --->
    <cfset temp=StructDelete(APPLICATION['#ARGUMENTS.fcrID#'].users, 'cru#session.userID#')>
    </cfif>
    </cfif>    
	<cfif session.urID EQ 102>
    <cfset this.chatURL = "/chat/?mcmsID=queue">
    <cfelse>
    <cfset this.chatURL = "/chat/?mcmsID=support&crID=#Replace(ARGUMENTS.tcrID, 'cr_', '', 'ALL')#">
    </cfif>
    <script>
	<cfoutput>
	document.location = "#this.chatURL#";
	</cfoutput>
	</script>
    </cfcase>
    <!--- Change to standard room. --->
    <cfdefaultcase>
	<cfset session.chatSignInDate = Now()>  
    <!--- Construct list of users. --->   
    <cfif isDefined("application.#ARGUMENTS.fcrID#")>
    <cflock scope="APPLICATION" type="READONLY" timeout="10">
    <cfset usrs=StructNew()>
    <cfset usrs=StructCopy(APPLICATION['#ARGUMENTS.fcrID#'].users)>
    </cflock>
    <cfset ausrs=StructKeyArray(usrs)>
    <!--- Delete room when last person wants to leave it. --->
    <cfif ArrayLen(ausrs) EQ 1>
    <cfset temp=StructDelete(APPLICATION, '#ARGUMENTS.fcrID#')>
    <cfif ListLen(application.crID) GT 1>
    <cfset application.crID = Replace(application.crID, ",cr_#ARGUMENTS.fcrID#", "", "ALL")>
    <!--- Delete room from application when last one. --->
    <cfelse>
    <cfset temp=StructDelete(APPLICATION, 'crID')>
    </cfif>
    <cfelse>
    <!--- Remove user from room they just left. --->
    <cfset temp=StructDelete(APPLICATION['#ARGUMENTS.fcrID#'].users, 'cru#session.userID#')>
    </cfif>
    </cfif>
    <cfif NOT IsDefined("application.#ARGUMENTS.tcrID#")>
    <cflock scope="APPLICATION" timeout="10" type="EXCLUSIVE">
    <!--- Create the rooms struct. --->
    <cfset APPLICATION[ARGUMENTS.tcrID]=StructNew()>
    </cflock>
    </cfif>
    <!--- Construct list of chat rooms that are created. --->
    <cfif isDefined("application.crID") AND application.crID NEQ "">
    <cfset this.roomAdded = false>
    <cfloop index="i" list="#application.crID#">
    <cfif i EQ "#ARGUMENTS.tcrID#">
    <cfset this.roomAdded = true>
    </cfif>
    </cfloop>
    <!--- Do not append to list if it already exists. --->
    <cfif this.roomAdded EQ false>
    <cfset application.crID = application.crID & "," & ARGUMENTS.tcrID>
    </cfif>
    <cfelse>
	<cfset application.crID = ARGUMENTS.tcrID>
    </cfif>
    <cfif NOT IsDefined("application.#ARGUMENTS.tcrID#.users")>
    <cfset temp=StructInsert(APPLICATION[ARGUMENTS.tcrID], "users", StructNew())>
    </cfif>
    <!--- Create user structure. --->
    <cfset chatUser=StructNew()>
    <cfset temp=StructInsert(chatUser,"admin", "false")>
    <cfset temp=StructInsert(chatUser,"lastupdate", Now())>
    <cfset temp=StructInsert(chatUser,"name", session.userName)>
    <cfset temp=StructInsert(chatUser,"id", session.userID)>
    <cfset temp=StructInsert(chatUser,"chatsessionID", application.chatSessionID)>
    <cfset temp=StructInsert(chatUser,"ip", CGI.REMOTE_ADDR)>
	<!--- Add the user to the room structure. --->
    <cfif NOT IsDefined("application.#ARGUMENTS.tcrID#.users.cru#session.userID#")>
    <cflock scope="APPLICATION" timeout="10" type="EXCLUSIVE">
    <cfset temp=StructInsert(APPLICATION[ARGUMENTS.tcrID].users, "cru#session.userID#", StructCopy(chatUser))>
    </cflock>
    </cfif>
    <!--- Reset the chat room. --->
	<script>
	<cfoutput>
	document.location = "/chat/?mcmsID=chat&crID=#Replace(ARGUMENTS.tcrID, 'cr_', '', 'ALL')#&entryType=1";
	</cfoutput>
	</script>
    </cfdefaultcase>
    </cfswitch>
    <cfcatch type="any">
    <cfset result.message = "There was an error changing the chat room.">
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="chatGetRoomAdminID" access="public" returntype="string">
    <cfargument name="cruID" type="string" required="yes" default="0">
    <cfset id = 0>
    <cflock scope="APPLICATION" type="READONLY" timeout="10">
    <cfset usrs=StructNew()>
    <cfset usrs=StructCopy(APPLICATION['cr_#ARGUMENTS.cruID#'].users)>
    </cflock>
    <cfset ausrs=StructKeyArray(usrs)>
    <cfloop index="i" from="1" to="#ArrayLen(ausrs)#">
    <cfset admin=usrs[ausrs[i]].admin>
    <cfif admin EQ true>
    <cfset id = usrs[ausrs[i]].id>
	</cfif>
    </cfloop>
    <cfreturn id>
    </cffunction>
    
    <cffunction name="chatDeleteRoom" access="public" returntype="void">
    <cfargument name="cruID" type="string" required="yes" default="0">
    <cfset temp=StructDelete(APPLICATION, 'cr_#ARGUMENTS.cruID#')>
    </cffunction>
       
</cfcomponent>