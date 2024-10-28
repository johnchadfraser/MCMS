<cfcomponent>
	<cffunction name="getHelp" access="public" returntype="query" hint="Get Help data.">
    <cfargument name="keywords" type="string" required="no" default="All">
    <cfargument name="ID" type="numeric" required="yes" default="0">
    <cfargument name="excludeID" type="numeric" required="yes" default="0">
    <cfargument name="hlpName" type="string" required="yes" default="">
    <cfargument name="netID" type="string" required="yes" default="0">
    <cfargument name="hlptID" type="string" required="yes" default="0">
    <cfargument name="hlpStatus" type="string" required="yes" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="hlpSort,hlpName">
	<cfset var rsHelp = "" >
    <cftry>
	<cfquery name="rsHelp" datasource="#application.mcmsDSN#">
	SELECT * FROM v_help WHERE 0=0
	<cfif ARGUMENTS.keywords NEQ 'All'>
	AND (UPPER(hlpName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(hlpDescription) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">)
	</cfif>
	<cfif ARGUMENTS.ID NEQ 0>
	AND ID = <cfqueryparam value="#ARGUMENTS.ID#" cfsqltype="cf_sql_integer">
	</cfif>
    <cfif ARGUMENTS.excludeID NEQ 0>
	AND ID <> <cfqueryparam value="#ARGUMENTS.excludeID#" cfsqltype="cf_sql_integer">
	</cfif>
	<cfif ARGUMENTS.hlpName NEQ "">
	AND UPPER(hlpName) = <cfqueryparam value="#UCASE(ARGUMENTS.hlpName)#" cfsqltype="cf_sql_varchar">
	</cfif>
    <cfif ARGUMENTS.netID NEQ 0>
	AND netID IN (<cfqueryparam value="#ARGUMENTS.netID#" list="yes" cfsqltype="cf_sql_integer">)
	</cfif>
    <cfif ARGUMENTS.hlptID NEQ 0>
	AND hlptID IN (<cfqueryparam value="#ARGUMENTS.hlptID#" list="yes" cfsqltype="cf_sql_integer">)
	</cfif>
	AND hlpStatus IN (<cfqueryparam value="#ARGUMENTS.hlpStatus#" list="yes" cfsqltype="cf_sql_integer">)
	ORDER BY #ARGUMENTS.orderBy#
	</cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsHelp = StructNew()>
    <cfset rsHelp.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
	<cfreturn rsHelp>
	</cffunction>
    
    <cffunction name="getHelpType" access="public" returntype="query" hint="Get Help data.">
    <cfargument name="keywords" type="string" required="no" default="All">
    <cfargument name="ID" type="numeric" required="yes" default="0">
    <cfargument name="excludeID" type="numeric" required="yes" default="0">
    <cfargument name="hlptName" type="string" required="yes" default="">
    <cfargument name="hlptStatus" type="string" required="yes" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="hlptSort,hlptName">
	<cfset var rsHelpType = "" >
    <cftry>
	<cfquery name="rsHelpType" datasource="#application.mcmsDSN#">
	SELECT * FROM v_help_type WHERE 0=0
	<cfif ARGUMENTS.keywords NEQ 'All'>
	AND (UPPER(hlptName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(hlptDescription) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">)
	</cfif>
	<cfif ARGUMENTS.ID NEQ 0>
	AND ID = <cfqueryparam value="#ARGUMENTS.ID#" cfsqltype="cf_sql_integer">
	</cfif>
    <cfif ARGUMENTS.excludeID NEQ 0>
	AND ID <> <cfqueryparam value="#ARGUMENTS.excludeID#" cfsqltype="cf_sql_integer">
	</cfif>
	<cfif ARGUMENTS.hlptName NEQ "">
	AND UPPER(hlptName) = <cfqueryparam value="#UCASE(ARGUMENTS.hlptName)#" cfsqltype="cf_sql_varchar">
	</cfif>
	AND hlptStatus IN (<cfqueryparam value="#ARGUMENTS.hlptStatus#" list="yes" cfsqltype="cf_sql_integer">)
	ORDER BY #ARGUMENTS.orderBy#
	</cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsHelpType = StructNew()>
    <cfset rsHelpType.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
	<cfreturn rsHelpType>
	</cffunction>
    
    <cffunction name="getHelpMenu" access="public" returntype="query" hint="Get Help Menu data.">
    <cfargument name="keywords" type="string" required="no" default="All">
    <cfargument name="ID" type="numeric" required="yes" default="0">
    <cfargument name="excludeID" type="numeric" required="yes" default="0">
    <cfargument name="hlpmName" type="string" required="yes" default="">
    <cfargument name="hlpID" type="numeric" required="yes" default="0">
    <cfargument name="hlpmStatus" type="string" required="yes" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="hlpmSort, hlpmName">
	<cfset var rsHelpMenu = "" >
    <cftry>
	<cfquery name="rsHelpMenu" datasource="#application.mcmsDSN#">
	SELECT * FROM v_help_menu WHERE 0=0
	<cfif ARGUMENTS.keywords NEQ 'All'>
	AND (UPPER(hlpmName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(hlpmDescription) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">)
	</cfif>
	<cfif ARGUMENTS.ID NEQ 0>
	AND ID = <cfqueryparam value="#ARGUMENTS.ID#" cfsqltype="cf_sql_integer">
	</cfif>
    <cfif ARGUMENTS.excludeID NEQ 0>
	AND ID <> <cfqueryparam value="#ARGUMENTS.excludeID#" cfsqltype="cf_sql_integer">
	</cfif>
	<cfif ARGUMENTS.hlpmName NEQ "">
	AND UPPER(hlpmName) = <cfqueryparam value="#UCASE(ARGUMENTS.hlpmName)#" cfsqltype="cf_sql_varchar">
	</cfif>
    <cfif ARGUMENTS.hlpID NEQ 0>
	AND hlpID = <cfqueryparam value="#ARGUMENTS.hlpID#" cfsqltype="cf_sql_integer">
	</cfif>
	AND hlpmStatus IN (<cfqueryparam value="#ARGUMENTS.hlpmStatus#" list="yes" cfsqltype="cf_sql_integer">)
	ORDER BY #ARGUMENTS.orderBy#
	</cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsHelpMenu = StructNew()>
    <cfset rsHelpMenu.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
	<cfreturn rsHelpMenu>
	</cffunction>
    
    <cffunction name="getHelpSection" access="public" returntype="query" hint="Get Help Section data.">
    <cfargument name="keywords" type="string" required="no" default="All">
    <cfargument name="ID" type="numeric" required="yes" default="0">
    <cfargument name="excludeID" type="numeric" required="yes" default="0">
    <cfargument name="hlpsName" type="string" required="yes" default="">
    <cfargument name="hlpID" type="numeric" required="yes" default="0">
    <cfargument name="hlpsStatus" type="string" required="yes" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="hlpsSort, hlpsName">
	<cfset var rsHelpSection = "" >
    <cftry>
	<cfquery name="rsHelpSection" datasource="#application.mcmsDSN#">
	SELECT * FROM v_help_section WHERE 0=0
	<cfif ARGUMENTS.keywords NEQ 'All'>
	AND (UPPER(hlpsName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(hlpsDescription) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">)
	</cfif>
	<cfif ARGUMENTS.ID NEQ 0>
	AND ID = <cfqueryparam value="#ARGUMENTS.ID#" cfsqltype="cf_sql_integer">
	</cfif>
    <cfif ARGUMENTS.excludeID NEQ 0>
	AND ID <> <cfqueryparam value="#ARGUMENTS.excludeID#" cfsqltype="cf_sql_integer">
	</cfif>
	<cfif ARGUMENTS.hlpsName NEQ "">
	AND UPPER(hlpsName) = <cfqueryparam value="#UCASE(ARGUMENTS.hlpsName)#" cfsqltype="cf_sql_varchar">
	</cfif>
    <cfif ARGUMENTS.hlpID NEQ 0>
	AND hlpID = <cfqueryparam value="#ARGUMENTS.hlpID#" cfsqltype="cf_sql_integer">
	</cfif>
	AND hlpsStatus IN (<cfqueryparam value="#ARGUMENTS.hlpsStatus#" list="yes" cfsqltype="cf_sql_integer">)
	ORDER BY #ARGUMENTS.orderBy#
	</cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsHelpSection = StructNew()>
    <cfset rsHelpSection.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
	<cfreturn rsHelpSection>
	</cffunction>
    
    <cffunction name="getHelpMenuSectionRel" access="public" returntype="query" hint="Get Help Section Menu Rel. data.">
    <cfargument name="keywords" type="string" required="no" default="All">
    <cfargument name="ID" type="numeric" required="yes" default="0">
    <cfargument name="excludeID" type="numeric" required="yes" default="0">
    <cfargument name="hlpmName" type="string" required="yes" default="">
    <cfargument name="hlpmID" type="numeric" required="yes" default="0">
    <cfargument name="hlpsID" type="numeric" required="yes" default="0">
    <cfargument name="hlpID" type="string" required="yes" default="0">
    <cfargument name="hlpmsrStatus" type="string" required="yes" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="hlpmName">
	<cfset var rsHelpMenuSectionRel = "" >
    <cftry>
	<cfquery name="rsHelpMenuSectionRel" datasource="#application.mcmsDSN#">
	SELECT * FROM v_help_menu_section_rel WHERE 0=0
	<cfif ARGUMENTS.keywords NEQ 'All'>
	AND (UPPER(hlpmName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(hlpsName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">)
	</cfif>
	<cfif ARGUMENTS.ID NEQ 0>
	AND ID = <cfqueryparam value="#ARGUMENTS.ID#" cfsqltype="cf_sql_integer">
	</cfif>
    <cfif ARGUMENTS.excludeID NEQ 0>
	AND ID <> <cfqueryparam value="#ARGUMENTS.excludeID#" cfsqltype="cf_sql_integer">
	</cfif>
    <cfif ARGUMENTS.hlpmID NEQ 0>
	AND hlpmID = <cfqueryparam value="#ARGUMENTS.hlpmID#" cfsqltype="cf_sql_integer">
	</cfif>
    <cfif ARGUMENTS.hlpsID NEQ 0>
	AND hlpsID = <cfqueryparam value="#ARGUMENTS.hlpsID#" cfsqltype="cf_sql_integer">
	</cfif>
    <cfif ARGUMENTS.hlpID NEQ 0>
	AND hlpID IN (<cfqueryparam value="0,#ARGUMENTS.hlpID#" list="yes" cfsqltype="cf_sql_integer">)
	</cfif>
	<cfif ARGUMENTS.hlpmName NEQ "">
	AND UPPER(hlpmName) = <cfqueryparam value="#UCASE(ARGUMENTS.hlpmName)#" cfsqltype="cf_sql_varchar">
	</cfif>
	AND hlpmsrStatus IN (<cfqueryparam value="#ARGUMENTS.hlpmsrStatus#" list="yes" cfsqltype="cf_sql_integer">)
	ORDER BY #ARGUMENTS.orderBy#
	</cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsHelpMenuSectionRel = StructNew()>
    <cfset rsHelpMenuSectionRel.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
	<cfreturn rsHelpMenuSectionRel>
	</cffunction>
    
    <cffunction name="getHelpContent" access="public" returntype="query" hint="Get Help Content data.">
    <cfargument name="keywords" type="string" required="no" default="All">
    <cfargument name="ID" type="numeric" required="yes" default="0">
    <cfargument name="excludeID" type="numeric" required="yes" default="0">
    <cfargument name="hlpcName" type="string" required="yes" default="">
    <cfargument name="userID" type="numeric" required="yes" default="0">
    <cfargument name="appID" type="numeric" required="yes" default="100">
    <cfargument name="hlpctID" type="numeric" required="yes" default="0">
    <cfargument name="hlpcStatus" type="string" required="yes" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="hlpcSort, hlpcName">
	<cfset var rsHelpContent = "" >
    <cftry>
	<cfquery name="rsHelpContent" datasource="#application.mcmsDSN#">
	SELECT * FROM v_help_content WHERE 0=0
	<cfif ARGUMENTS.keywords NEQ 'All'>
	AND (UPPER(hlpcName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(hlpcKeyword) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(hlpcDescription) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">)
	</cfif>
	<cfif ARGUMENTS.ID NEQ 0>
	AND ID = <cfqueryparam value="#ARGUMENTS.ID#" cfsqltype="cf_sql_integer">
	</cfif>
    <cfif ARGUMENTS.excludeID NEQ 0>
	AND ID <> <cfqueryparam value="#ARGUMENTS.excludeID#" cfsqltype="cf_sql_integer">
	</cfif>
	<cfif ARGUMENTS.hlpcName NEQ "">
	AND UPPER(hlpcName) = <cfqueryparam value="#UCASE(ARGUMENTS.hlpcName)#" cfsqltype="cf_sql_varchar">
	</cfif>
    <cfif ARGUMENTS.userID NEQ 0>
	AND userID = <cfqueryparam value="#ARGUMENTS.userID#" cfsqltype="cf_sql_integer">
	</cfif>
    <cfif ARGUMENTS.appID NEQ 100>
	AND appID = <cfqueryparam value="#ARGUMENTS.appID#" cfsqltype="cf_sql_integer">
	</cfif>
    <cfif ARGUMENTS.hlpctID NEQ 0>
	AND hlpctID = <cfqueryparam value="#ARGUMENTS.hlpctID#" cfsqltype="cf_sql_integer">
	</cfif>
	AND hlpcStatus IN (<cfqueryparam value="#ARGUMENTS.hlpcStatus#" list="yes" cfsqltype="cf_sql_integer">)
	ORDER BY #ARGUMENTS.orderBy#
	</cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsHelpContent = StructNew()>
    <cfset rsHelpContent.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
	<cfreturn rsHelpContent>
	</cffunction>
    
    <cffunction name="getHelpContentSectionRel" access="public" returntype="query" hint="Get Help Content Section Rel. data.">
    <cfargument name="keywords" type="string" required="no" default="All">
    <cfargument name="ID" type="numeric" required="yes" default="0">
    <cfargument name="excludeID" type="numeric" required="yes" default="0">
    <cfargument name="hlpcName" type="string" required="yes" default="">
    <cfargument name="hlpcID" type="numeric" required="yes" default="0">
    <cfargument name="hlpsID" type="numeric" required="yes" default="0">
    <cfargument name="appID" type="numeric" required="yes" default="100">
    <cfargument name="netID" type="numeric" required="yes" default="0">
    <cfargument name="hlptID" type="numeric" required="yes" default="0">
    <cfargument name="hlpctID" type="numeric" required="yes" default="0">
    <cfargument name="hlpcsrStatus" type="string" required="yes" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="hlpcSort, hlpcName">
	<cfset var rsHelpContentSectionRel = "" >
    <cftry>
	<cfquery name="rsHelpContentSectionRel" datasource="#application.mcmsDSN#" cachedafter="#CreateOdbcDateTime(DateFormat(Now(),'mm/dd/yyyy') & ' 00:01:00')#">
	SELECT * FROM v_help_content_section_rel WHERE 0=0
	<cfif ARGUMENTS.keywords NEQ 'All'>
	AND (UPPER(hlpcName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(hlpcKeyword) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(hlpsName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">)
	</cfif>
	<cfif ARGUMENTS.ID NEQ 0>
	AND ID = <cfqueryparam value="#ARGUMENTS.ID#" cfsqltype="cf_sql_integer">
	</cfif>
    <cfif ARGUMENTS.excludeID NEQ 0>
	AND ID <> <cfqueryparam value="#ARGUMENTS.excludeID#" cfsqltype="cf_sql_integer">
	</cfif>
	<cfif ARGUMENTS.hlpcName NEQ "">
	AND UPPER(hlpcName) = <cfqueryparam value="#UCASE(ARGUMENTS.hlpcName)#" cfsqltype="cf_sql_varchar">
	</cfif>
    <cfif ARGUMENTS.hlpcID NEQ 0>
	AND hlpcID = <cfqueryparam value="#ARGUMENTS.hlpcID#" cfsqltype="cf_sql_integer">
	</cfif>
    <cfif ARGUMENTS.hlpsID NEQ 0>
	AND hlpsID = <cfqueryparam value="#ARGUMENTS.hlpsID#" cfsqltype="cf_sql_integer">
	</cfif>
    <cfif ARGUMENTS.appID NEQ 100>
	AND appID = <cfqueryparam value="#ARGUMENTS.appID#" cfsqltype="cf_sql_integer">
	</cfif>
    <cfif ARGUMENTS.netID NEQ 0>
	AND netID = <cfqueryparam value="#ARGUMENTS.netID#" cfsqltype="cf_sql_integer">
	</cfif>
    <cfif ARGUMENTS.hlptID NEQ 0>
	AND hlptID IN (<cfqueryparam value="#ARGUMENTS.hlptID#" list="yes" cfsqltype="cf_sql_integer">)
	</cfif>
    <cfif ARGUMENTS.hlpctID NEQ 0>
	AND hlpctID IN (<cfqueryparam value="#ARGUMENTS.hlpctID#" list="yes" cfsqltype="cf_sql_integer">)
	</cfif>
	AND hlpcsrStatus IN (<cfqueryparam value="#ARGUMENTS.hlpcsrStatus#" list="yes" cfsqltype="cf_sql_integer">)
	ORDER BY #ARGUMENTS.orderBy#
	</cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsHelpContentSectionRel = StructNew()>
    <cfset rsHelpContentSectionRel.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
	<cfreturn rsHelpContentSectionRel>
	</cffunction>
    
    <cffunction name="getHelpContentType" access="public" returntype="query" hint="Get Help Content Type data.">
    <cfargument name="keywords" type="string" required="no" default="All">
    <cfargument name="ID" type="numeric" required="yes" default="0">
    <cfargument name="excludeID" type="numeric" required="yes" default="0">
    <cfargument name="hlpctName" type="string" required="yes" default="">
    <cfargument name="hlpctStatus" type="string" required="yes" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="hlpctSort, hlpctName">
	<cfset var rsHelpContentType = "" >
    <cftry>
	<cfquery name="rsHelpContentType" datasource="#application.mcmsDSN#">
	SELECT * FROM v_help_content_type WHERE 0=0
	<cfif ARGUMENTS.keywords NEQ 'All'>
	AND (UPPER(hlpctName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">)
	</cfif>
	<cfif ARGUMENTS.ID NEQ 0>
	AND ID = <cfqueryparam value="#ARGUMENTS.ID#" cfsqltype="cf_sql_integer">
	</cfif>
    <cfif ARGUMENTS.excludeID NEQ 0>
	AND ID <> <cfqueryparam value="#ARGUMENTS.excludeID#" cfsqltype="cf_sql_integer">
	</cfif>
	<cfif ARGUMENTS.hlpctName NEQ "">
	AND UPPER(hlpctName) = <cfqueryparam value="#UCASE(ARGUMENTS.hlpctName)#" cfsqltype="cf_sql_varchar">
	</cfif>
	AND hlpctStatus IN (<cfqueryparam value="#ARGUMENTS.hlpctStatus#" list="yes" cfsqltype="cf_sql_integer">)
	ORDER BY #ARGUMENTS.orderBy#
	</cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsHelpContentType = StructNew()>
    <cfset rsHelpContentType.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
	<cfreturn rsHelpContentType>
	</cffunction>
    
    <cffunction name="getHelpContentComment" access="public" returntype="query" hint="Get Help Content Comment data.">
    <cfargument name="keywords" type="string" required="no" default="All">
    <cfargument name="ID" type="numeric" required="yes" default="0">
    <cfargument name="excludeID" type="numeric" required="yes" default="0">
    <cfargument name="hlpcName" type="string" required="yes" default="">
    <cfargument name="hlpcID" type="numeric" required="yes" default="0">
    <cfargument name="appID" type="numeric" required="yes" default="100">
    <cfargument name="hlpctID" type="numeric" required="yes" default="0">
    <cfargument name="hlpccStatus" type="string" required="yes" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="hlpccDate DESC">
	<cfset var rsHelpContentComment = "" >
    <cftry>
	<cfquery name="rsHelpContentComment" datasource="#application.mcmsDSN#">
	SELECT * FROM v_help_content_comment WHERE 0=0
	<cfif ARGUMENTS.keywords NEQ 'All'>
	AND (UPPER(hlpcName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(hlpccComment) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">)
	</cfif>
	<cfif ARGUMENTS.ID NEQ 0>
	AND ID = <cfqueryparam value="#ARGUMENTS.ID#" cfsqltype="cf_sql_integer">
	</cfif>
    <cfif ARGUMENTS.excludeID NEQ 0>
	AND ID <> <cfqueryparam value="#ARGUMENTS.excludeID#" cfsqltype="cf_sql_integer">
	</cfif>
    <cfif ARGUMENTS.hlpcID NEQ 0>
	AND hlpcID = <cfqueryparam value="#ARGUMENTS.hlpcID#" cfsqltype="cf_sql_integer">
	</cfif>
	<cfif ARGUMENTS.hlpcName NEQ "">
	AND UPPER(hlpcName) = <cfqueryparam value="#UCASE(ARGUMENTS.hlpcName)#" cfsqltype="cf_sql_varchar">
	</cfif>
    <cfif ARGUMENTS.appID NEQ 100>
	AND appID = <cfqueryparam value="#ARGUMENTS.appID#" cfsqltype="cf_sql_integer">
	</cfif>
    <cfif ARGUMENTS.hlpctID NEQ 0>
	AND hlpctID = <cfqueryparam value="#ARGUMENTS.hlpctID#" cfsqltype="cf_sql_integer">
	</cfif>
	AND hlpccStatus IN (<cfqueryparam value="#ARGUMENTS.hlpccStatus#" list="yes" cfsqltype="cf_sql_integer">)
	ORDER BY #ARGUMENTS.orderBy#
	</cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsHelpContentComment = StructNew()>
    <cfset rsHelpContentComment.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
	<cfreturn rsHelpContentComment>
	</cffunction>
    
    <cffunction name="getHelpContentRating" access="public" returntype="query" hint="Get Help Content Rating data.">
    <cfargument name="keywords" type="string" required="no" default="All">
    <cfargument name="ID" type="numeric" required="yes" default="0">
    <cfargument name="excludeID" type="numeric" required="yes" default="0">
    <cfargument name="hlpcName" type="string" required="yes" default="">
    <cfargument name="hlpcID" type="numeric" required="yes" default="0">
    <cfargument name="appID" type="numeric" required="yes" default="100">
    <cfargument name="hlpctID" type="numeric" required="yes" default="0">
    <cfargument name="hlpcrStatus" type="string" required="yes" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="hlpcrDate DESC">
	<cfset var rsHelpContentRating = "" >
    <cftry>
	<cfquery name="rsHelpContentRating" datasource="#application.mcmsDSN#">
	SELECT * FROM v_help_content_rating WHERE 0=0
	<cfif ARGUMENTS.keywords NEQ 'All'>
	AND (UPPER(hlpcName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">)
	</cfif>
	<cfif ARGUMENTS.ID NEQ 0>
	AND ID = <cfqueryparam value="#ARGUMENTS.ID#" cfsqltype="cf_sql_integer">
	</cfif>
    <cfif ARGUMENTS.excludeID NEQ 0>
	AND ID <> <cfqueryparam value="#ARGUMENTS.excludeID#" cfsqltype="cf_sql_integer">
	</cfif>
    <cfif ARGUMENTS.hlpcID NEQ 0>
	AND hlpcID = <cfqueryparam value="#ARGUMENTS.hlpcID#" cfsqltype="cf_sql_integer">
	</cfif>
	<cfif ARGUMENTS.hlpcName NEQ "">
	AND UPPER(hlpcName) = <cfqueryparam value="#UCASE(ARGUMENTS.hlpcName)#" cfsqltype="cf_sql_varchar">
	</cfif>
    <cfif ARGUMENTS.appID NEQ 100>
	AND appID = <cfqueryparam value="#ARGUMENTS.appID#" cfsqltype="cf_sql_integer">
	</cfif>
    <cfif ARGUMENTS.hlpctID NEQ 0>
	AND hlpctID = <cfqueryparam value="#ARGUMENTS.hlpctID#" cfsqltype="cf_sql_integer">
	</cfif>
	AND hlpcrStatus IN (<cfqueryparam value="#ARGUMENTS.hlpcrStatus#" list="yes" cfsqltype="cf_sql_integer">)
	ORDER BY #ARGUMENTS.orderBy#
	</cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsHelpContentRating = StructNew()>
    <cfset rsHelpContentRating.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
	<cfreturn rsHelpContentRating>
	</cffunction>
    
    <cffunction name="getHelpContentTrainingLessonRel" access="public" returntype="query" hint="Get Help Content Training Lesson Rel. data.">
    <cfargument name="keywords" type="string" required="no" default="All">
    <cfargument name="ID" type="numeric" required="yes" default="0">
    <cfargument name="excludeID" type="numeric" required="yes" default="0">
    <cfargument name="hlpcName" type="string" required="yes" default="">
    <cfargument name="hlpcID" type="numeric" required="yes" default="0">
    <cfargument name="tlID" type="numeric" required="yes" default="0">
    <cfargument name="hlpctID" type="numeric" required="yes" default="0">
    <cfargument name="hlpctlrStatus" type="string" required="yes" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="tlName, hlpcID">
	<cfset var rsHelpContentTrainingLessonRel = "" >
    <cftry>
	<cfquery name="rsHelpContentTrainingLessonRel" datasource="#application.mcmsDSN#">
	SELECT * FROM v_help_c_training_lesson_rel WHERE 0=0
	<cfif ARGUMENTS.keywords NEQ 'All'>
	AND (UPPER(hlpcName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(tlDescription) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">)
	</cfif>
	<cfif ARGUMENTS.ID NEQ 0>
	AND ID = <cfqueryparam value="#ARGUMENTS.ID#" cfsqltype="cf_sql_integer">
	</cfif>
    <cfif ARGUMENTS.excludeID NEQ 0>
	AND ID <> <cfqueryparam value="#ARGUMENTS.excludeID#" cfsqltype="cf_sql_integer">
	</cfif>
    <cfif ARGUMENTS.hlpcID NEQ 0>
	AND hlpcID = <cfqueryparam value="#ARGUMENTS.hlpcID#" cfsqltype="cf_sql_integer">
	</cfif>
	<cfif ARGUMENTS.hlpcName NEQ "">
	AND UPPER(hlpcName) = <cfqueryparam value="#UCASE(ARGUMENTS.hlpcName)#" cfsqltype="cf_sql_varchar">
	</cfif>
    <cfif ARGUMENTS.tlID NEQ 0>
	AND tlID = <cfqueryparam value="#ARGUMENTS.tlID#" cfsqltype="cf_sql_integer">
	</cfif>
    <cfif ARGUMENTS.hlpctID NEQ 0>
	AND hlpctID = <cfqueryparam value="#ARGUMENTS.hlpctID#" cfsqltype="cf_sql_integer">
	</cfif>
	AND hlpctlrStatus IN (<cfqueryparam value="#ARGUMENTS.hlpctlrStatus#" list="yes" cfsqltype="cf_sql_integer">)
	ORDER BY #ARGUMENTS.orderBy#
	</cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsHelpContentTrainingLessonRel = StructNew()>
    <cfset rsHelpContentTrainingLessonRel.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
	<cfreturn rsHelpContentTrainingLessonRel>
	</cffunction>
    
    <cffunction name="getHelpContentDocumentRel" access="public" returntype="query" hint="Get Help Content Document Rel. data.">
    <cfargument name="keywords" type="string" required="no" default="All">
    <cfargument name="ID" type="numeric" required="yes" default="0">
    <cfargument name="excludeID" type="numeric" required="yes" default="0">
    <cfargument name="hlpcName" type="string" required="yes" default="">
    <cfargument name="hlpcID" type="numeric" required="yes" default="0">
    <cfargument name="docID" type="numeric" required="yes" default="0">
    <cfargument name="appID" type="numeric" required="yes" default="100">
    <cfargument name="netID" type="numeric" required="yes" default="0">
    <cfargument name="docDateRel" type="string" required="yes" default="">
    <cfargument name="docDateExp" type="string" required="yes" default="">
    <cfargument name="hlpctID" type="numeric" required="yes" default="0">
    <cfargument name="hlpcdrStatus" type="string" required="yes" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="docName, hlpcID">
	<cfset var rsHelpContentDocumentRel = "" >
    <cftry>
	<cfquery name="rsHelpContentDocumentRel" datasource="#application.mcmsDSN#">
	SELECT * FROM v_help_content_document_rel WHERE 0=0
	<cfif ARGUMENTS.keywords NEQ 'All'>
	AND (UPPER(docName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(hlpcName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(docDescription) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">)
	</cfif>
	<cfif ARGUMENTS.ID NEQ 0>
	AND ID = <cfqueryparam value="#ARGUMENTS.ID#" cfsqltype="cf_sql_integer">
	</cfif>
    <cfif ARGUMENTS.excludeID NEQ 0>
	AND ID <> <cfqueryparam value="#ARGUMENTS.excludeID#" cfsqltype="cf_sql_integer">
	</cfif>
    <cfif ARGUMENTS.hlpcID NEQ 0>
	AND hlpcID = <cfqueryparam value="#ARGUMENTS.hlpcID#" cfsqltype="cf_sql_integer">
	</cfif>
    <cfif ARGUMENTS.docID NEQ 0>
	AND docID = <cfqueryparam value="#ARGUMENTS.docID#" cfsqltype="cf_sql_integer">
	</cfif>
	<cfif ARGUMENTS.hlpcName NEQ "">
	AND UPPER(hlpcName) = <cfqueryparam value="#UCASE(ARGUMENTS.hlpcName)#" cfsqltype="cf_sql_varchar">
	</cfif>
    <cfif ARGUMENTS.appID NEQ 100>
	AND appID = <cfqueryparam value="#ARGUMENTS.appID#" cfsqltype="cf_sql_integer">
	</cfif>
    <cfif ARGUMENTS.netID NEQ 0>
	AND netID = <cfqueryparam value="#ARGUMENTS.netID#" cfsqltype="cf_sql_integer">
	</cfif>
    <cfif ARGUMENTS.docDateRel NEQ "">
    AND docDateRel <= <cfqueryparam value="#ARGUMENTS.docDateRel#" cfsqltype="cf_sql_date">
    </cfif>
    <cfif ARGUMENTS.docDateExp NEQ "">
    AND docDateExp >= <cfqueryparam value="#ARGUMENTS.docDateExp#" cfsqltype="cf_sql_date">
	</cfif>
    <cfif ARGUMENTS.hlpctID NEQ 0>
	AND hlpctID = <cfqueryparam value="#ARGUMENTS.hlpctID#" cfsqltype="cf_sql_integer">
	</cfif>
	AND hlpcdrStatus IN (<cfqueryparam value="#ARGUMENTS.hlpcdrStatus#" list="yes" cfsqltype="cf_sql_integer">)
	ORDER BY #ARGUMENTS.orderBy#
	</cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsHelpContentDocumentRel = StructNew()>
    <cfset rsHelpContentDocumentRel.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
	<cfreturn rsHelpContentDocumentRel>
	</cffunction>
    
    <cffunction name="getHelpContentLinkRel" access="public" returntype="query" hint="Get Help Content Link Rel. data.">
    <cfargument name="keywords" type="string" required="no" default="All">
    <cfargument name="ID" type="numeric" required="yes" default="0">
    <cfargument name="excludeID" type="numeric" required="yes" default="0">
    <cfargument name="lName" type="string" required="yes" default="">
    <cfargument name="hlpcID" type="numeric" required="yes" default="0">
    <cfargument name="lID" type="numeric" required="yes" default="0">
    <cfargument name="netID" type="numeric" required="yes" default="0">
    <cfargument name="lDateExp" type="string" required="yes" default="">
    <cfargument name="ltID" type="numeric" required="yes" default="0">
    <cfargument name="hlpctID" type="numeric" required="yes" default="0">
    <cfargument name="hlpclrStatus" type="string" required="yes" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="lSort, lName, hlpcName">
	<cfset var rsHelpContentLinkRel = "" >
    <cftry>
	<cfquery name="rsHelpContentLinkRel" datasource="#application.mcmsDSN#">
	SELECT * FROM v_help_content_link_rel WHERE 0=0
	<cfif ARGUMENTS.keywords NEQ 'All'>
	AND (UPPER(lName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(hlpcName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">)
	</cfif>
	<cfif ARGUMENTS.ID NEQ 0>
	AND ID = <cfqueryparam value="#ARGUMENTS.ID#" cfsqltype="cf_sql_integer">
	</cfif>
    <cfif ARGUMENTS.excludeID NEQ 0>
	AND ID <> <cfqueryparam value="#ARGUMENTS.excludeID#" cfsqltype="cf_sql_integer">
	</cfif>
    <cfif ARGUMENTS.hlpcID NEQ 0>
	AND hlpcID = <cfqueryparam value="#ARGUMENTS.hlpcID#" cfsqltype="cf_sql_integer">
	</cfif>
    <cfif ARGUMENTS.lID NEQ 0>
	AND lID = <cfqueryparam value="#ARGUMENTS.lID#" cfsqltype="cf_sql_integer">
	</cfif>
    <cfif ARGUMENTS.netID NEQ 0>
	AND netID = <cfqueryparam value="#ARGUMENTS.netID#" cfsqltype="cf_sql_integer">
	</cfif>
	<cfif ARGUMENTS.lName NEQ "">
	AND UPPER(lName) = <cfqueryparam value="#UCASE(ARGUMENTS.lName)#" cfsqltype="cf_sql_varchar">
	</cfif>
    <cfif ARGUMENTS.lDateExp NEQ "">
    AND lDateExp >= <cfqueryparam value="#ARGUMENTS.lDateExp#" cfsqltype="cf_sql_date">
	</cfif>
    <cfif ARGUMENTS.hlpctID NEQ 0>
	AND hlpctID = <cfqueryparam value="#ARGUMENTS.hlpctID#" cfsqltype="cf_sql_integer">
	</cfif>
	AND hlpclrStatus IN (<cfqueryparam value="#ARGUMENTS.hlpclrStatus#" list="yes" cfsqltype="cf_sql_integer">)
	ORDER BY #ARGUMENTS.orderBy#
	</cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsHelpContentLinkRel = StructNew()>
    <cfset rsHelpContentLinkRel.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
	<cfreturn rsHelpContentLinkRel>
	</cffunction>
    
    <cffunction name="getHelpReport" access="public" returntype="query" hint="Get Help Report data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="orderBy" type="string" required="yes" default="hlpName">
    <cfset var rsHelpReport = "" >
    <cftry>
    <cfquery name="rsHelpReport" datasource="#application.mcmsDSN#">
    SELECT hlpName AS Name, hlptName AS Type, TO_CHAR(hlpDescription) AS Description, TO_CHAR(hlpDate,'MM/DD/YYYY') AS Create_Date, TO_CHAR(hlpDateUpdate,'MM/DD/YYYY') AS Update_Date, hlpVersion AS Version, netName AS Network, netDomain AS Domain, sName AS Status FROM v_help WHERE 0=0
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(hlpName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(hlpDescription) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">)
    </cfif>
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsHelpReport = StructNew()>
    <cfset rsHelpReport.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsHelpReport>
    </cffunction>
    
    <cffunction name="getHelpMenuReport" access="public" returntype="query" hint="Get Help Menu Report data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="orderBy" type="string" required="yes" default="hlpmName">
    <cfset var rsHelpMenuReport = "" >
    <cftry>
    <cfquery name="rsHelpMenuReport" datasource="#application.mcmsDSN#">
    SELECT hlpmName AS Menu, TO_CHAR(hlpmDescription) AS Menu_Description, hlpName AS Name, TO_CHAR(hlpDescription) AS Description, TO_CHAR(hlpDate,'MM/DD/YYYY') AS Create_Date, TO_CHAR(hlpDateUpdate,'MM/DD/YYYY') AS Update_Date, hlpVersion AS Version, netName AS Network, netDomain AS Domain, sortName As Sort, sName AS Status FROM v_help_menu WHERE 0=0
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(hlpmName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(hlpmDescription) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">)
    </cfif>
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsHelpMenuReport = StructNew()>
    <cfset rsHelpMenuReport.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsHelpMenuReport>
    </cffunction>
    
    <cffunction name="getHelpSectionReport" access="public" returntype="query" hint="Get Help Section Report data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="orderBy" type="string" required="yes" default="hlpsName">
    <cfset var rsHelpSectionReport = "" >
    <cftry>
    <cfquery name="rsHelpSectionReport" datasource="#application.mcmsDSN#">
    SELECT hlpsName AS Section, TO_CHAR(hlpsDescription) AS Section_Description, hlpName AS Name, TO_CHAR(hlpDescription) AS Description, TO_CHAR(hlpDate,'MM/DD/YYYY') AS Create_Date, TO_CHAR(hlpDateUpdate,'MM/DD/YYYY') AS Update_Date, hlpVersion AS Version, netName AS Network, netDomain AS Domain, sortName As Sort, sName AS Status FROM v_help_section WHERE 0=0
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(hlpsName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(hlpsDescription) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">)
    </cfif>
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsHelpSectionReport = StructNew()>
    <cfset rsHelpSectionReport.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsHelpSectionReport>
    </cffunction>
    
    <cffunction name="getHelpContentReport" access="public" returntype="query" hint="Get Help Content Report data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="orderBy" type="string" required="yes" default="hlpcName">
    <cfset var rsHelpContentReport = "" >
    <cftry>
    <cfquery name="rsHelpContentReport" datasource="#application.mcmsDSN#">
    SELECT hlpcName AS Content, TO_CHAR(hlpcDescription) AS Content_Description, hlpcKeyword AS Keywords, TO_CHAR(hlpcDate,'MM/DD/YYYY') AS Create_Date, TO_CHAR(hlpcDateUpdate,'MM/DD/YYYY') AS Update_Date, hlpctName AS Type, userLName AS Username, userEmail AS userEmail, appName AS Application, appURL AS URL, sortName As Sort, sName AS Status FROM v_help_content WHERE 0=0
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(hlpcName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(hlpcKeyword) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(hlpcDescription) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">)
    </cfif>
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsHelpContentReport = StructNew()>
    <cfset rsHelpContentReport.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsHelpContentReport>
    </cffunction>
    
    <cffunction name="getHelpContentTypeReport" access="public" returntype="query" hint="Get Help Content Type Report data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="orderBy" type="string" required="yes" default="hlpctName">
    <cfset var rsHelpContentTypeReport = "" >
    <cftry>
    <cfquery name="rsHelpContentTypeReport" datasource="#application.mcmsDSN#">
    SELECT hlpctName AS Name, sortName As Sort, sName AS Status FROM v_help_content_type WHERE 0=0
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(hlpctName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">)
    </cfif>
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsHelpContentTypeReport = StructNew()>
    <cfset rsHelpContentTypeReport.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsHelpContentTypeReport>
    </cffunction>
    
    <cffunction name="getHelpContentCommentReport" access="public" returntype="query" hint="Get Help Content Comment Report data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="orderBy" type="string" required="yes" default="hlpccDate DESC">
    <cfset var rsHelpContentCommentReport = "" >
    <cftry>
    <cfquery name="rsHelpContentCommentReport" datasource="#application.mcmsDSN#">
    SELECT hlpcName AS Content, hlpccLName AS Username, hlpccEmail AS Email, TO_CHAR(hlpccComment) AS Comments, TO_CHAR(hlpccDate,'MM/DD/YYYY') AS Create_Date, sName AS Status FROM v_help_content_comment WHERE 0=0
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(hlpcName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(hlpccEmail) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(hlpccComment) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">)
    </cfif>
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsHelpContentCommentReport = StructNew()>
    <cfset rsHelpContentCommentReport.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsHelpContentCommentReport>
    </cffunction>
    
    <cffunction name="getHelpContentRatingReport" access="public" returntype="query" hint="Get Help Content Rating Report data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="orderBy" type="string" required="yes" default="hlpcrDate DESC, hlpcName">
    <cfset var rsHelpContentRatingReport = "" >
    <cftry>
    <cfquery name="rsHelpContentRatingReport" datasource="#application.mcmsDSN#">
    SELECT hlpcName AS Content, hlpcrValue AS Rating, TO_CHAR(hlpcrDate,'MM/DD/YYYY') AS Create_Date, sName AS Status FROM v_help_content_rating WHERE 0=0
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(hlpcName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">)
    </cfif>
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsHelpContentRatingReport = StructNew()>
    <cfset rsHelpContentRatingReport.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsHelpContentRatingReport>
    </cffunction>
    
    <cffunction name="insertHelp" access="public" returntype="struct">
    <cfargument name="hlpName" type="string" required="yes">
    <cfargument name="hlpDescription" type="string" required="yes">
    <cfargument name="hlpVersion" type="string" required="yes">
    <cfargument name="netID" type="numeric" required="yes">
    <cfargument name="hlptID" type="numeric" required="yes">
    <cfargument name="hlpSort" type="numeric" required="yes">
    <cfargument name="hlpStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully inserted the record.">
    <cftry>
    <!---Check for profanity in the text.--->
    <cfinvoke 
    component="MCMS.component.utility.Regex"
    method="regexProfanity"
    returnvariable="regexProfanityRet">
    <cfinvokeargument name="profanityString" value="#ARGUMENTS.hlpDescription#"/>
    </cfinvoke>
    <!---Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.app.help.Help"
    method="getHelp"
    returnvariable="getCheckHelpRet">
    <cfinvokeargument name="hlpName" value="#ARGUMENTS.hlpName#"/>
    <cfinvokeargument name="hlpStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckHelpRet.recordcount NEQ 0>
    <cfset result.message = "The name #ARGUMENTS.hlpName# already exists, please enter a new name.">
    <cfelseif regexProfanityRet CONTAINS '$%&*!'>
    <cfset result.message = "Some text contained profanity, please remove any profanity from your text.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    INSERT INTO tbl_help (hlpName,hlpDescription,hlpVersion,netID,hlptID,hlpSort,hlpStatus) VALUES
    (
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.hlpName#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.hlpDescription#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.hlpVersion#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.netID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.hlptID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.hlpSort#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.hlpStatus#">
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
    
    <cffunction name="insertHelpMenu" access="public" returntype="struct">
    <cfargument name="hlpID" type="numeric" required="yes">
    <cfargument name="hlpmName" type="string" required="yes">
    <cfargument name="hlpmDescription" type="string" required="yes">
    <cfargument name="hlpmSort" type="numeric" required="yes">
    <cfargument name="hlpmStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully inserted the record.">
    <cftry>
    <!---Check for profanity in the text.--->
    <cfinvoke 
    component="MCMS.component.utility.Regex"
    method="regexProfanity"
    returnvariable="regexProfanityRet">
    <cfinvokeargument name="profanityString" value="#ARGUMENTS.hlpmDescription#"/>
    </cfinvoke>
    <!---Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.app.help.Help"
    method="getHelpMenu"
    returnvariable="getCheckHelpMenuRet">
    <cfinvokeargument name="hlpID" value="#ARGUMENTS.hlpID#"/>
    <cfinvokeargument name="hlpmName" value="#ARGUMENTS.hlpmName#"/>
    <cfinvokeargument name="hlpmStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckHelpMenuRet.recordcount NEQ 0>
    <cfset result.message = "The name #ARGUMENTS.hlpmName# already exists, please enter a new name.">
    <cfelseif regexProfanityRet CONTAINS '$%&*!'>
    <cfset result.message = "Some text contained profanity, please remove any profanity from your text.">
    <!---Check length restriction.--->
    <cfelseif LEN(ARGUMENTS.hlpmDescription) GT 512>
    <cfset result.message = "The description is longer than 512 characters, please enter a new description under 512 characters.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    INSERT INTO tbl_help_menu (hlpID,hlpmName,hlpmDescription,hlpmSort,hlpmStatus) VALUES
    (
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.hlpID#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.hlpmName#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.hlpmDescription#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.hlpmSort#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.hlpmStatus#">
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
    
    <cffunction name="insertHelpSection" access="public" returntype="struct">
    <cfargument name="hlpID" type="numeric" required="yes">
    <cfargument name="hlpsName" type="string" required="yes">
    <cfargument name="hlpsDescription" type="string" required="yes">
    <cfargument name="hlpsSort" type="numeric" required="yes">
    <cfargument name="hlpsStatus" type="numeric" required="yes">
    <!---Relationship arguments.--->
    <cfargument name="hlpmID" type="string" required="yes" default="">
    <cfset result.message = "You have successfully inserted the record.">
    <cftry>
    <!---Check for profanity in the text.--->
    <cfinvoke 
    component="MCMS.component.utility.Regex"
    method="regexProfanity"
    returnvariable="regexProfanityRet">
    <cfinvokeargument name="profanityString" value="#ARGUMENTS.hlpsDescription#"/>
    </cfinvoke>
    <!---Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.app.help.Help"
    method="getHelpSection"
    returnvariable="getCheckHelpSectionRet">
    <cfinvokeargument name="hlpID" value="#ARGUMENTS.hlpID#"/>
    <cfinvokeargument name="hlpsName" value="#ARGUMENTS.hlpsName#"/>
    <cfinvokeargument name="hlpsStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckHelpSectionRet.recordcount NEQ 0>
    <cfset result.message = "The name #ARGUMENTS.hlpsName# already exists, please enter a new name.">
    <cfelseif regexProfanityRet CONTAINS '$%&*!'>
    <cfset result.message = "Some text contained profanity, please remove any profanity from your text.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    INSERT INTO tbl_help_section (hlpID,hlpsName,hlpsDescription,hlpsSort,hlpsStatus) VALUES
    (
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.hlpID#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.hlpsName#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.hlpsDescription#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.hlpsSort#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.hlpsStatus#">
    )
    </cfquery>
    </cftransaction>
    <!---Get the Content ID.--->
    <cfinvoke 
    component="MCMS.component.cms.Cms"
    method="getMaxValueSQL"
    returnvariable="getMaxValueSQLRet">
    <cfinvokeargument name="tableName" value="tbl_help_section"/>
    </cfinvoke>
    <cfset this.hlpsID = getMaxValueSQLRet>
    <!---Insert Section relationships.--->
    <cfif ARGUMENTS.hlpmID NEQ "">
    <cfloop index="i" list="#ARGUMENTS.hlpmID#">
    <cfinvoke 
    component="MCMS.component.app.help.Help"
    method="insertHelpMenuSectionRel"
    returnvariable="insertHelpMenuSectionRelRet">
    <cfinvokeargument name="hlpsID" value="#this.hlpsID#"/>
    <cfinvokeargument name="hlpmID" value="#i#"/>
    <cfinvokeargument name="hlpmsrStatus" value="1"/>
    </cfinvoke>
    </cfloop>
    </cfif>
    </cfif>
    <cfcatch type="any">
    <cfset result.message = "There was an error inserting the record.">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="insertHelpMenuSectionRel" access="public" returntype="struct">
    <cfargument name="hlpmID" type="numeric" required="yes">
    <cfargument name="hlpsID" type="numeric" required="yes">
    <cfargument name="hlpmsrStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully inserted the record.">
    <cftry>
    <!---Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.app.help.Help"
    method="getHelpMenuSectionRel"
    returnvariable="getCheckHelpMenuSectionRelRet">
    <cfinvokeargument name="hlpmID" value="#ARGUMENTS.hlpmID#"/>
    <cfinvokeargument name="hlpsID" value="#ARGUMENTS.hlpsID#"/>
    <cfinvokeargument name="hlpmsrStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckHelpMenuSectionRelRet.recordcount NEQ 0>
    <cfset result.message = "The menu section relationship already exists, please try again.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    INSERT INTO tbl_help_menu_section_rel (hlpmID,hlpsID,hlpmsrStatus) VALUES
    (
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.hlpmID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.hlpsID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.hlpmsrStatus#">
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
    
    <cffunction name="insertHelpContent" access="public" returntype="struct">
    <cfargument name="hlpcName" type="string" required="yes">
    <cfargument name="hlpcDescription" type="string" required="yes">
    <cfargument name="hlpcKeyword" type="string" required="yes">
    <cfargument name="appID" type="numeric" required="yes">
    <cfargument name="hlpctID" type="numeric" required="yes">
    <cfargument name="hlpcSort" type="numeric" required="yes">
    <cfargument name="hlpcStatus" type="numeric" required="yes">
    <!---Relationship arguments.--->
    <cfargument name="hlpsID" type="string" required="yes" default="">
    <cfargument name="tlID" type="string" required="yes" default="">
    <cfargument name="lID" type="string" required="yes" default="">
    <cfargument name="docID" type="string" required="yes" default="">
    <cfset result.message = "You have successfully inserted the record.">
    <cftry>
    <!---Check for profanity in the text.--->
    <cfinvoke 
    component="MCMS.component.utility.Regex"
    method="regexProfanity"
    returnvariable="regexProfanityRet">
    <cfinvokeargument name="profanityString" value="#ARGUMENTS.hlpcDescription#"/>
    </cfinvoke>
    <!---Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.app.help.Help"
    method="getHelpContent"
    returnvariable="getCheckHelpContentRet">
    <cfinvokeargument name="hlpcName" value="#ARGUMENTS.hlpcName#"/>
    <cfinvokeargument name="appID" value="#ARGUMENTS.appID#"/>
    <cfinvokeargument name="hlpctID" value="#ARGUMENTS.hlpctID#"/>
    <cfinvokeargument name="hlpcStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckHelpContentRet.recordcount NEQ 0>
    <cfset result.message = "The name #ARGUMENTS.hlpcName# already exists for this application and content type, please enter a new name.">
    <cfelseif regexProfanityRet CONTAINS '$%&*!'>
    <cfset result.message = "Some text contained profanity, please remove any profanity from your text.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    INSERT INTO tbl_help_content (hlpcName,hlpcDescription,hlpcKeyword,userID,appID,hlpctID,hlpcSort,hlpcStatus) VALUES
    (
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.hlpcName#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.hlpcDescription#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.hlpcKeyword#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#session.userID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.appID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.hlpctID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.hlpcSort#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.hlpcStatus#">
    )
    </cfquery>
    </cftransaction>
    <!---Get the Content ID.--->
    <cfinvoke 
    component="MCMS.component.cms.Cms"
    method="getMaxValueSQL"
    returnvariable="getMaxValueSQLRet">
    <cfinvokeargument name="tableName" value="tbl_help_content"/>
    </cfinvoke>
    <cfset this.hlpcID = getMaxValueSQLRet>
    <!---Insert Section relationships.--->
    <cfif ARGUMENTS.hlpsID NEQ "">
    <cfloop index="i" list="#ARGUMENTS.hlpsID#">
    <cfinvoke 
    component="MCMS.component.app.help.Help"
    method="insertHelpContentSectionRel"
    returnvariable="insertHelpContentSectionRelRet">
    <cfinvokeargument name="hlpcID" value="#this.hlpcID#"/>
    <cfinvokeargument name="hlpsID" value="#i#"/>
    <cfinvokeargument name="hlpcsrStatus" value="1"/>
    </cfinvoke>
    </cfloop>
    </cfif>
    <!---Insert Training Lesson relationships.--->
    <cfif ARGUMENTS.tlID NEQ "">
    <cfloop index="i" list="#ARGUMENTS.tlID#">
    <cfinvoke 
    component="MCMS.component.app.help.Help"
    method="insertHelpContentTrainingLessonRel"
    returnvariable="insertHelpContentTrainingLessonRelRet">
    <cfinvokeargument name="hlpcID" value="#this.hlpcID#"/>
    <cfinvokeargument name="tlID" value="#i#"/>
    <cfinvokeargument name="hlpctlrStatus" value="1"/>
    </cfinvoke>
    </cfloop>
    </cfif>
    <!---Insert Link relationships.--->
    <cfif ARGUMENTS.lID NEQ "">
    <cfloop index="i" list="#ARGUMENTS.lID#">
    <cfinvoke 
    component="MCMS.component.app.help.Help"
    method="insertHelpContentLinkRel"
    returnvariable="insertHelpContentLinkRelRet">
    <cfinvokeargument name="hlpcID" value="#this.hlpcID#"/>
    <cfinvokeargument name="lID" value="#i#"/>
    <cfinvokeargument name="hlpclrStatus" value="1"/>
    </cfinvoke>
    </cfloop>
    </cfif>
    <!---Insert Link relationships.--->
    <cfif ARGUMENTS.docID NEQ "">
    <cfloop index="i" list="#ARGUMENTS.docID#">
    <cfinvoke 
    component="MCMS.component.app.help.Help"
    method="insertHelpContentDocumentRel"
    returnvariable="insertHelpContentDocumentRelRet">
    <cfinvokeargument name="hlpcID" value="#this.hlpcID#"/>
    <cfinvokeargument name="docID" value="#i#"/>
    <cfinvokeargument name="hlpcdrStatus" value="1"/>
    </cfinvoke>
    </cfloop>
    </cfif>
    </cfif>
    <cfcatch type="any">
    <cfset result.message = "There was an error inserting the record.">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="insertHelpContentSectionRel" access="public" returntype="struct">
    <cfargument name="hlpcID" type="numeric" required="yes">
    <cfargument name="hlpsID" type="numeric" required="yes">
    <cfargument name="hlpcsrStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully inserted the record.">
    <cftry>
    <!---Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.app.help.Help"
    method="getHelpContentSectionRel"
    returnvariable="getCheckHelpContentSectionRelRet">
    <cfinvokeargument name="hlpcID" value="#ARGUMENTS.hlpcID#"/>
    <cfinvokeargument name="hlpsID" value="#ARGUMENTS.hlpsID#"/>
    <cfinvokeargument name="hlpcsrStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckHelpContentSectionRelRet.recordcount NEQ 0>
    <cfset result.message = "The content section relationship already exists, please try again.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    INSERT INTO tbl_help_content_section_rel (hlpcID,hlpsID,hlpcsrStatus) VALUES
    (
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.hlpcID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.hlpsID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.hlpcsrStatus#">
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
    
    <cffunction name="insertHelpContentTrainingLessonRel" access="public" returntype="struct">
    <cfargument name="hlpcID" type="numeric" required="yes">
    <cfargument name="tlID" type="numeric" required="yes">
    <cfargument name="hlpctlrStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully inserted the record.">
    <cftry>
    <!---Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.app.help.Help"
    method="getHelpContentTrainingLessonRel"
    returnvariable="getCheckHelpContentTrainingLessonRelRet">
    <cfinvokeargument name="hlpcID" value="#ARGUMENTS.hlpcID#"/>
    <cfinvokeargument name="tlID" value="#ARGUMENTS.tlID#"/>
    <cfinvokeargument name="hlpctlrStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckHelpContentTrainingLessonRelRet.recordcount NEQ 0>
    <cfset result.message = "The content training lesson relationship already exists, please try again.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    INSERT INTO tbl_help_c_training_lesson_rel (hlpcID,tlID,hlpctlrStatus) VALUES
    (
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.hlpcID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.tlID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.hlpctlrStatus#">
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
    
    <cffunction name="insertHelpContentDocumentRel" access="public" returntype="struct">
    <cfargument name="hlpcID" type="numeric" required="yes">
    <cfargument name="docID" type="numeric" required="yes">
    <cfargument name="hlpcdrStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully inserted the record.">
    <cftry>
    <!---Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.app.help.Help"
    method="getHelpContentDocumentRel"
    returnvariable="getCheckHelpContentDocumentRelRet">
    <cfinvokeargument name="hlpcID" value="#ARGUMENTS.hlpcID#"/>
    <cfinvokeargument name="docID" value="#ARGUMENTS.docID#"/>
    <cfinvokeargument name="hlpcdrStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckHelpContentDocumentRelRet.recordcount NEQ 0>
    <cfset result.message = "The content document relationship already exists, please try again.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    INSERT INTO tbl_help_content_document_rel (hlpcID,docID,hlpcdrStatus) VALUES
    (
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.hlpcID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.docID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.hlpcdrStatus#">
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
    
    <cffunction name="insertHelpContentLinkRel" access="public" returntype="struct">
    <cfargument name="hlpcID" type="numeric" required="yes">
    <cfargument name="lID" type="numeric" required="yes">
    <cfargument name="hlpclrStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully inserted the record.">
    <cftry>
    <!---Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.app.help.Help"
    method="getHelpContentLinkRel"
    returnvariable="getCheckHelpContentLinkRelRet">
    <cfinvokeargument name="hlpcID" value="#ARGUMENTS.hlpcID#"/>
    <cfinvokeargument name="lID" value="#ARGUMENTS.lID#"/>
    <cfinvokeargument name="hlpclrStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckHelpContentLinkRelRet.recordcount NEQ 0>
    <cfset result.message = "The content link relationship already exists, please try again.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    INSERT INTO tbl_help_content_link_rel (hlpcID,lID,hlpclrStatus) VALUES
    (
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.hlpcID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.lID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.hlpclrStatus#">
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
    
    <cffunction name="insertHelpContentType" access="public" returntype="struct">
    <cfargument name="hlpctName" type="string" required="yes">
    <cfargument name="hlpctSort" type="numeric" required="yes">
    <cfargument name="hlpctStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully inserted the record.">
    <cftry>
    <!---Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.app.help.Help"
    method="getHelpContentType"
    returnvariable="getCheckHelpContentTypeRet">
    <cfinvokeargument name="hlpctName" value="#ARGUMENTS.hlpctName#"/>
    <cfinvokeargument name="hlpctStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckHelpContentTypeRet.recordcount NEQ 0>
    <cfset result.message = "The name #ARGUMENTS.hlpctName# already exists, please enter a new name.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    INSERT INTO tbl_help_content_type (hlpctName,hlpctSort,hlpctStatus) VALUES
    (
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.hlpctName#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.hlpctSort#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.hlpctStatus#">
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
    
    <cffunction name="insertHelpContentComment" access="public" returntype="struct">
    <cfargument name="hlpcID" type="numeric" required="yes">
    <cfargument name="hlpccFName" type="string" required="yes">
    <cfargument name="hlpccLName" type="string" required="yes">
    <cfargument name="hlpccEmail" type="string" required="yes">
    <cfargument name="hlpccComment" type="string" required="yes">
    <cfargument name="hlpccStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully inserted the record.">
    <cftry>
    <!---Check for profanity in the text.--->
    <cfinvoke 
    component="MCMS.component.utility.Regex"
    method="regexProfanity"
    returnvariable="regexProfanityRet">
    <cfinvokeargument name="profanityString" value="#ARGUMENTS.hlpccComment#"/>
    </cfinvoke>
    <cfif regexProfanityRet CONTAINS '$%&*!'>
    <cfset result.message = "Some text contained profanity, please remove any profanity from your text.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    INSERT INTO tbl_help_content_comment (hlpcID,hlpccFName,hlpccLName,hlpccEmail,hlpccComment,hlpccStatus) VALUES
    (
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.hlpcID#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.hlpccFName#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.hlpccLName#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.hlpccEmail#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.hlpccComment#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.hlpccStatus#">
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
    
    <cffunction name="insertHelpContentRating" access="public" returntype="struct">
    <cfargument name="hlpcID" type="numeric" required="yes">
    <cfargument name="hlpcrValue" type="numeric" required="yes">
    <cfargument name="hlpcrStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully inserted the record.">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    INSERT INTO tbl_help_content_rating (hlpcID,hlpcrValue,hlpcrStatus) VALUES
    (
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.hlpcID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.hlpcrValue#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.hlpcrStatus#">
    )
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error inserting the record.">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="updateHelp" access="public" returntype="struct">
    <cfargument name="ID" type="numeric" required="yes">
    <cfargument name="hlpName" type="string" required="yes">
    <cfargument name="hlpDescription" type="string" required="yes">
    <cfargument name="hlpVersion" type="string" required="yes">
    <cfargument name="netID" type="numeric" required="yes">
    <cfargument name="hlptID" type="numeric" required="yes">
    <cfargument name="hlpSort" type="numeric" required="yes">
    <cfargument name="hlpStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully updated the record.">
    <cftry>
    <!---Check for profanity in the text.--->
    <cfinvoke 
    component="MCMS.component.utility.Regex"
    method="regexProfanity"
    returnvariable="regexProfanityRet">
    <cfinvokeargument name="profanityString" value="#ARGUMENTS.hlpDescription#"/>
    </cfinvoke>
    <!---Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.app.help.Help"
    method="getHelp"
    returnvariable="getCheckHelpRet">
    <cfinvokeargument name="excludeID" value="#ARGUMENTS.ID#"/>
    <cfinvokeargument name="hlpName" value="#ARGUMENTS.hlpName#"/>
    <cfinvokeargument name="hlpStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckHelpRet.recordcount NEQ 0>
    <cfset result.message = "The name #ARGUMENTS.hlpName# already exists, please enter a new name.">
    <cfelseif regexProfanityRet CONTAINS '$%&*!'>
    <cfset result.message = "Some text contained profanity, please remove any profanity from your text.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_help SET
    hlpName = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.hlpName#">,
    hlpDescription = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.hlpDescription#">,
    hlpDateUpdate = <cfqueryparam cfsqltype="cf_sql_timestamp" value="#Now()#">,
    hlpVersion = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.hlpVersion#">,
    netID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.netID#">,
    hlptID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.hlptID#">,
    hlpSort = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.hlpSort#">,
    hlpStatus = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.hlpStatus#">
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
    
    <cffunction name="updateHelpMenu" access="public" returntype="struct">
    <cfargument name="ID" type="numeric" required="yes">
    <cfargument name="hlpID" type="numeric" required="yes">
    <cfargument name="hlpmName" type="string" required="yes">
    <cfargument name="hlpmDescription" type="string" required="yes">
    <cfargument name="hlpmSort" type="numeric" required="yes">
    <cfargument name="hlpmStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully updated the record.">
    <cftry>
    <!---Check for profanity in the text.--->
    <cfinvoke 
    component="MCMS.component.utility.Regex"
    method="regexProfanity"
    returnvariable="regexProfanityRet">
    <cfinvokeargument name="profanityString" value="#ARGUMENTS.hlpmDescription#"/>
    </cfinvoke>
    <!---Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.app.help.Help"
    method="getHelpMenu"
    returnvariable="getCheckHelpMenuRet">
    <cfinvokeargument name="excludeID" value="#ARGUMENTS.ID#"/>
    <cfinvokeargument name="hlpID" value="#ARGUMENTS.hlpID#"/>
    <cfinvokeargument name="hlpmName" value="#ARGUMENTS.hlpmName#"/>
    <cfinvokeargument name="hlpmStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckHelpMenuRet.recordcount NEQ 0>
    <cfset result.message = "The name #ARGUMENTS.hlpmName# already exists, please enter a new name.">
    <cfelseif regexProfanityRet CONTAINS '$%&*!'>
    <cfset result.message = "Some text contained profanity, please remove any profanity from your text.">
    <!---Check length restriction.--->
    <cfelseif LEN(ARGUMENTS.hlpmDescription) GT 512>
    <cfset result.message = "The description is longer than 512 characters, please enter a new description under 512 characters.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_help_menu SET
    hlpID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.hlpID#">,
    hlpmName = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.hlpmName#">,
    hlpmDescription = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.hlpmDescription#">,
    hlpmSort = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.hlpmSort#">,
    hlpmStatus = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.hlpmStatus#">
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
    
    <cffunction name="updateHelpSection" access="public" returntype="struct">
    <cfargument name="ID" type="numeric" required="yes">
    <cfargument name="hlpID" type="numeric" required="yes">
    <cfargument name="hlpsName" type="string" required="yes">
    <cfargument name="hlpsDescription" type="string" required="yes">
    <cfargument name="hlpsSort" type="numeric" required="yes">
    <cfargument name="hlpsStatus" type="numeric" required="yes">
    <!---Relationship arguments.--->
    <cfargument name="hlpmID" type="string" required="yes" default="">
    <cfset result.message = "You have successfully updated the record.">
    <cftry>
    <!---Check for profanity in the text.--->
    <cfinvoke 
    component="MCMS.component.utility.Regex"
    method="regexProfanity"
    returnvariable="regexProfanityRet">
    <cfinvokeargument name="profanityString" value="#ARGUMENTS.hlpsDescription#"/>
    </cfinvoke>
    <!---Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.app.help.Help"
    method="getHelpSection"
    returnvariable="getCheckHelpSectionRet">
    <cfinvokeargument name="excludeID" value="#ARGUMENTS.ID#"/>
    <cfinvokeargument name="hlpID" value="#ARGUMENTS.hlpID#"/>
    <cfinvokeargument name="hlpsName" value="#ARGUMENTS.hlpsName#"/>
    <cfinvokeargument name="hlpsStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckHelpSectionRet.recordcount NEQ 0>
    <cfset result.message = "The name #ARGUMENTS.hlpsName# already exists, please enter a new name.">
    <cfelseif regexProfanityRet CONTAINS '$%&*!'>
    <cfset result.message = "Some text contained profanity, please remove any profanity from your text.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_help_section SET
    hlpsName = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.hlpsName#">,
    hlpsDescription = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.hlpsDescription#">,
    hlpsDateUpdate = <cfqueryparam cfsqltype="cf_sql_timestamp" value="#Now()#">,
    hlpsSort = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.hlpsSort#">,
    hlpsStatus = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.hlpsStatus#">
    WHERE ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ID#">
    </cfquery>
    </cftransaction>
    <!---Delete any current relationships.--->
    <cfinvoke 
    component="MCMS.component.app.help.Help"
    method="deleteHelpMenuSectionRel"
    returnvariable="deleteHelpMenuSectionRelRet">
    <cfinvokeargument name="hlpsID" value="#ARGUMENTS.ID#"/>
    </cfinvoke>
    <!---Insert Section relationships.--->
    <cfif ARGUMENTS.hlpmID NEQ "">
    <cfloop index="i" list="#ARGUMENTS.hlpmID#">
    <cfinvoke 
    component="MCMS.component.app.help.Help"
    method="insertHelpMenuSectionRel"
    returnvariable="result">
    <cfinvokeargument name="hlpsID" value="#ARGUMENTS.ID#"/>
    <cfinvokeargument name="hlpmID" value="#i#"/>
    <cfinvokeargument name="hlpmsrStatus" value="1"/>
    </cfinvoke>
    </cfloop>
    </cfif>
    </cfif>
    <cfcatch type="any">
    <cfset result.message = "There was an error updating the record.">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="updateHelpContent" access="public" returntype="struct">
    <cfargument name="ID" type="numeric" required="yes">
    <cfargument name="hlpcName" type="string" required="yes">
    <cfargument name="hlpcDescription" type="string" required="yes">
    <cfargument name="hlpcKeyword" type="string" required="yes">
    <cfargument name="appID" type="numeric" required="yes">
    <cfargument name="hlpctID" type="numeric" required="yes">
    <cfargument name="hlpcSort" type="numeric" required="yes">
    <cfargument name="hlpcStatus" type="numeric" required="yes">
    <!---Relationship arguments.--->
    <cfargument name="hlpsID" type="string" required="yes" default="">
    <cfargument name="tlID" type="string" required="yes" default="">
    <cfargument name="lID" type="string" required="yes" default="">
    <cfargument name="docID" type="string" required="yes" default="">
    <cfset result.message = "You have successfully updated the record.">
    <cftry>
    <!---Check for profanity in the text.--->
    <cfinvoke 
    component="MCMS.component.utility.Regex"
    method="regexProfanity"
    returnvariable="regexProfanityRet">
    <cfinvokeargument name="profanityString" value="#ARGUMENTS.hlpcDescription#"/>
    </cfinvoke>
    <!---Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.app.help.Help"
    method="getHelpContent"
    returnvariable="getCheckHelpContentRet">
    <cfinvokeargument name="excludeID" value="#ARGUMENTS.ID#"/>
    <cfinvokeargument name="hlpcName" value="#ARGUMENTS.hlpcName#"/>
    <cfinvokeargument name="appID" value="#ARGUMENTS.appID#"/>
    <cfinvokeargument name="hlpctID" value="#ARGUMENTS.hlpctID#"/>
    <cfinvokeargument name="hlpcStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckHelpContentRet.recordcount NEQ 0>
    <cfset result.message = "The name #ARGUMENTS.hlpcName# already exists for this application and content type, please enter a new name.">
    <cfelseif regexProfanityRet CONTAINS '$%&*!'>
    <cfset result.message = "Some text contained profanity, please remove any profanity from your text.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_help_content SET
    hlpcName = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.hlpcName#">,
    hlpcDescription = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.hlpcDescription#">,
    hlpcKeyword = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.hlpcKeyword#">,
    hlpcDateUpdate = <cfqueryparam cfsqltype="cf_sql_timestamp" value="#Now()#">,
    appID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.appID#">,
    hlpctID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.hlpctID#">,
    hlpcSort = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.hlpcSort#">,
    hlpcStatus = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.hlpcStatus#">
    WHERE ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ID#">
    </cfquery>
    </cftransaction>
    <!---Delete any current relationships.--->
    <cfinvoke 
    component="MCMS.component.app.help.Help"
    method="deleteHelpContentDocumentRel"
    returnvariable="deleteHelpContentDocumentRelRet">
    <cfinvokeargument name="hlpcID" value="#ARGUMENTS.ID#"/>
    </cfinvoke>
    <cfinvoke 
    component="MCMS.component.app.help.Help"
    method="deleteHelpContentLinkRel"
    returnvariable="deleteHelpContentLinkRelRet">
    <cfinvokeargument name="hlpcID" value="#ARGUMENTS.ID#"/>
    </cfinvoke>
    <cfinvoke 
    component="MCMS.component.app.help.Help"
    method="deleteHelpContentTrainingLessonRel"
    returnvariable="deleteHelpContentTrainingLessonRelRet">
    <cfinvokeargument name="hlpcID" value="#ARGUMENTS.ID#"/>
    </cfinvoke>
    <cfinvoke 
    component="MCMS.component.app.help.Help"
    method="deleteHelpContentSectionRel"
    returnvariable="deleteHelpContentSectionRelRet">
    <cfinvokeargument name="hlpcID" value="#ARGUMENTS.ID#"/>
    </cfinvoke>
    <!---Insert Section relationships.--->
    <cfif ARGUMENTS.hlpsID NEQ "">
    <cfloop index="i" list="#ARGUMENTS.hlpsID#">
    <cfinvoke 
    component="MCMS.component.app.help.Help"
    method="insertHelpContentSectionRel"
    returnvariable="insertHelpContentSectionRelRet">
    <cfinvokeargument name="hlpcID" value="#ARGUMENTS.ID#"/>
    <cfinvokeargument name="hlpsID" value="#i#"/>
    <cfinvokeargument name="hlpcsrStatus" value="1"/>
    </cfinvoke>
    </cfloop>
    </cfif>
    <!---Insert Training Lesson relationships.--->
    <cfif ARGUMENTS.tlID NEQ "">
    <cfloop index="i" list="#ARGUMENTS.tlID#">
    <cfinvoke 
    component="MCMS.component.app.help.Help"
    method="insertHelpContentTrainingLessonRel"
    returnvariable="insertHelpContentTrainingLessonRelRet">
    <cfinvokeargument name="hlpcID" value="#ARGUMENTS.ID#"/>
    <cfinvokeargument name="tlID" value="#i#"/>
    <cfinvokeargument name="hlpctlrStatus" value="1"/>
    </cfinvoke>
    </cfloop>
    </cfif>
    <!---Insert Link relationships.--->
    <cfif ARGUMENTS.lID NEQ "">
    <cfloop index="i" list="#ARGUMENTS.lID#">
    <cfinvoke 
    component="MCMS.component.app.help.Help"
    method="insertHelpContentLinkRel"
    returnvariable="insertHelpContentLinkRelRet">
    <cfinvokeargument name="hlpcID" value="#ARGUMENTS.ID#"/>
    <cfinvokeargument name="lID" value="#i#"/>
    <cfinvokeargument name="hlpclrStatus" value="1"/>
    </cfinvoke>
    </cfloop>
    </cfif>
    <!---Insert Link relationships.--->
    <cfif ARGUMENTS.docID NEQ "">
    <cfloop index="i" list="#ARGUMENTS.docID#">
    <cfinvoke 
    component="MCMS.component.app.help.Help"
    method="insertHelpContentDocumentRel"
    returnvariable="insertHelpContentDocumentRelRet">
    <cfinvokeargument name="hlpcID" value="#ARGUMENTS.ID#"/>
    <cfinvokeargument name="docID" value="#i#"/>
    <cfinvokeargument name="hlpcdrStatus" value="1"/>
    </cfinvoke>
    </cfloop>
    </cfif>
    </cfif>
    <cfcatch type="any">
    <cfset result.message = "There was an error updating the record.">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="updateHelpContentType" access="public" returntype="struct">
    <cfargument name="ID" type="numeric" required="yes">
    <cfargument name="hlpctName" type="string" required="yes">
    <cfargument name="hlpctSort" type="numeric" required="yes">
    <cfargument name="hlpctStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully updated the record.">
    <cftry>
    <!---Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.app.help.Help"
    method="getHelpContentType"
    returnvariable="getCheckHelpContentTypeRet">
    <cfinvokeargument name="excludeID" value="#ARGUMENTS.ID#"/>
    <cfinvokeargument name="hlpctName" value="#ARGUMENTS.hlpctName#"/>
    <cfinvokeargument name="hlpctStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckHelpContentTypeRet.recordcount NEQ 0>
    <cfset result.message = "The name #ARGUMENTS.hlpctName# already exists, please enter a new name.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_help_content_type SET
    hlpctName = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.hlpctName#">,
    hlpctSort = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.hlpctSort#">,
    hlpctStatus = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.hlpctStatus#">
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
    
    <cffunction name="updateHelpContentComment" access="public" returntype="struct">
    <cfargument name="ID" type="numeric" required="yes">
    <cfargument name="hlpccFName" type="string" required="yes">
    <cfargument name="hlpccLName" type="string" required="yes">
    <cfargument name="hlpccEmail" type="string" required="yes">
    <cfargument name="hlpccComment" type="string" required="yes">
    <cfargument name="hlpccStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully updated the record.">
    <cftry>
    <!---Check for profanity in the text.--->
    <cfinvoke 
    component="MCMS.component.utility.Regex"
    method="regexProfanity"
    returnvariable="regexProfanityRet">
    <cfinvokeargument name="profanityString" value="#ARGUMENTS.hlpccComment#"/>
    </cfinvoke>
    <cfif regexProfanityRet CONTAINS '$%&*!'>
    <cfset result.message = "Some text contained profanity, please remove any profanity from your text.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_help_content_comment SET
    hlpccFName = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.hlpccFName#">,
    hlpccLName = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.hlpccLName#">,
    hlpccEmail = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.hlpccEmail#">,
    hlpccComment = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.hlpccComment#">,
    hlpccStatus = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.hlpccStatus#">
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
    
    <cffunction name="updateHelpContentRating" access="public" returntype="struct">
    <cfargument name="ID" type="numeric" required="yes">
    <cfargument name="hlpcrValue" type="numeric" required="yes">
    <cfargument name="hlpcrStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully updated the record.">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_help_content_rating SET
    hlpcrValue = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.hlpcrValue#">,
    hlpcrStatus = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.hlpcrStatus#">
    WHERE ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ID#">
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error updating the record.">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="updateHelpList" access="public" returntype="struct">
    <cfargument name="ID" type="numeric" required="yes">
    <cfargument name="hlpStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully updated the records.">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_help SET
    hlpStatus = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.hlpStatus#">
    WHERE ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ID#">
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error updating the records.">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="updateHelpMenuList" access="public" returntype="struct">
    <cfargument name="ID" type="numeric" required="yes">
    <cfargument name="hlpmStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully updated the records.">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_help_menu SET
    hlpmStatus = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.hlpmStatus#">
    WHERE ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ID#">
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error updating the records.">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="updateHelpSectionList" access="public" returntype="struct">
    <cfargument name="ID" type="numeric" required="yes">
    <cfargument name="hlpsStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully updated the records.">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_help_section SET
    hlpsStatus = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.hlpsStatus#">
    WHERE ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ID#">
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error updating the records.">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="updateHelpContentList" access="public" returntype="struct">
    <cfargument name="ID" type="numeric" required="yes">
    <cfargument name="hlpcStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully updated the records.">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_help_content SET
    hlpcStatus = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.hlpcStatus#">
    WHERE ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ID#">
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error updating the records.">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="updateHelpContentTypeList" access="public" returntype="struct">
    <cfargument name="ID" type="numeric" required="yes">
    <cfargument name="hlpctStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully updated the records.">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_help_content_type SET
    hlpctStatus = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.hlpctStatus#">
    WHERE ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ID#">
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error updating the records.">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="updateHelpContentCommentList" access="public" returntype="struct">
    <cfargument name="ID" type="numeric" required="yes">
    <cfargument name="hlpccStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully updated the records.">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_help_content_comment SET
    hlpccStatus = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.hlpccStatus#">
    WHERE ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ID#">
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error updating the records.">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="updateHelpContentRatingList" access="public" returntype="struct">
    <cfargument name="ID" type="numeric" required="yes">
    <cfargument name="hlpcrStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully updated the records.">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_help_content_rating SET
    hlpcrStatus = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.hlpcrStatus#">
    WHERE ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ID#">
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error updating the records.">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="deleteHelp" access="public" returntype="struct">
    <cfargument name="ID" type="string" required="yes">
    <cfset result.message = "You have successfully deleted the record(s).">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    DELETE FROM tbl_help
    WHERE ID IN (<cfqueryparam cfsqltype="cf_sql_integer" list="yes" value="#ARGUMENTS.ID#">)
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error deleting the record(s).">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="deleteHelpMenu" access="public" returntype="struct">
    <cfargument name="ID" type="string" required="yes">
    <cfset result.message = "You have successfully deleted the record(s).">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    DELETE FROM tbl_help_menu
    WHERE ID IN (<cfqueryparam cfsqltype="cf_sql_integer" list="yes" value="#ARGUMENTS.ID#">)
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error deleting the record(s).">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="deleteHelpSection" access="public" returntype="struct">
    <cfargument name="ID" type="string" required="yes">
    <cfset result.message = "You have successfully deleted the record(s).">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    DELETE FROM tbl_help_section
    WHERE ID IN (<cfqueryparam cfsqltype="cf_sql_integer" list="yes" value="#ARGUMENTS.ID#">)
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error deleting the record(s).">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="deleteHelpMenuSectionRel" access="public" returntype="struct">
    <cfargument name="ID" type="string" required="yes" default="0">
    <cfargument name="hlpsID" type="string" required="yes" default="0">
    <cfset result.message = "You have successfully deleted the record(s).">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    DELETE FROM tbl_help_menu_section_rel
    WHERE ID IN (<cfqueryparam cfsqltype="cf_sql_integer" list="yes" value="#ARGUMENTS.ID#">)
    OR hlpsID IN (<cfqueryparam cfsqltype="cf_sql_integer" list="yes" value="#ARGUMENTS.hlpsID#">)
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error deleting the record(s).">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="deleteHelpContent" access="public" returntype="struct">
    <cfargument name="ID" type="string" required="yes">
    <cfset result.message = "You have successfully deleted the record(s).">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    DELETE FROM tbl_help_content
    WHERE ID IN (<cfqueryparam cfsqltype="cf_sql_integer" list="yes" value="#ARGUMENTS.ID#">)
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error deleting the record(s).">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="deleteHelpContentSectionRel" access="public" returntype="struct">
    <cfargument name="ID" type="string" required="yes" default="0">
    <cfargument name="hlpcID" type="string" required="yes" default="0">
    <cfset result.message = "You have successfully deleted the record(s).">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    DELETE FROM tbl_help_content_section_rel
    WHERE ID IN (<cfqueryparam cfsqltype="cf_sql_integer" list="yes" value="#ARGUMENTS.ID#">) 
    OR hlpcID IN (<cfqueryparam cfsqltype="cf_sql_integer" list="yes" value="#ARGUMENTS.hlpcID#">)
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error deleting the record(s).">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="deleteHelpContentTrainingLessonRel" access="public" returntype="struct">
    <cfargument name="ID" type="string" required="yes" default="0">
    <cfargument name="hlpcID" type="string" required="yes" default="0">
    <cfset result.message = "You have successfully deleted the record(s).">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    DELETE FROM tbl_help_c_training_lesson_rel
    WHERE ID IN (<cfqueryparam cfsqltype="cf_sql_integer" list="yes" value="#ARGUMENTS.ID#">)
    OR hlpcID IN (<cfqueryparam cfsqltype="cf_sql_integer" list="yes" value="#ARGUMENTS.hlpcID#">)
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error deleting the record(s).">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="deleteHelpContentDocumentRel" access="public" returntype="struct">
    <cfargument name="ID" type="string" required="yes" default="0">
    <cfargument name="hlpcID" type="string" required="yes" default="0">
    <cfset result.message = "You have successfully deleted the record(s).">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    DELETE FROM tbl_help_content_document_rel
    WHERE ID IN (<cfqueryparam cfsqltype="cf_sql_integer" list="yes" value="#ARGUMENTS.ID#">)
    OR hlpcID IN (<cfqueryparam cfsqltype="cf_sql_integer" list="yes" value="#ARGUMENTS.hlpcID#">)
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error deleting the record(s).">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="deleteHelpContentLinkRel" access="public" returntype="struct">
    <cfargument name="ID" type="string" required="yes" default="0">
    <cfargument name="hlpcID" type="string" required="yes" default="0">
    <cfset result.message = "You have successfully deleted the record(s).">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    DELETE FROM tbl_help_content_link_rel
    WHERE ID IN (<cfqueryparam cfsqltype="cf_sql_integer" list="yes" value="#ARGUMENTS.ID#">)
    OR hlpcID IN (<cfqueryparam cfsqltype="cf_sql_integer" list="yes" value="#ARGUMENTS.hlpcID#">)
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error deleting the record(s).">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="deleteHelpContentType" access="public" returntype="struct">
    <cfargument name="ID" type="string" required="yes">
    <cfset result.message = "You have successfully deleted the record(s).">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    DELETE FROM tbl_help_content_type
    WHERE ID IN (<cfqueryparam cfsqltype="cf_sql_integer" list="yes" value="#ARGUMENTS.ID#">)
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error deleting the record(s).">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="deleteHelpContentComment" access="public" returntype="struct">
    <cfargument name="ID" type="string" required="yes">
    <cfset result.message = "You have successfully deleted the record(s).">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    DELETE FROM tbl_help_content_comment
    WHERE ID IN (<cfqueryparam cfsqltype="cf_sql_integer" list="yes" value="#ARGUMENTS.ID#">)
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error deleting the record(s).">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="deleteHelpContentRating" access="public" returntype="struct">
    <cfargument name="ID" type="string" required="yes">
    <cfset result.message = "You have successfully deleted the record(s).">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    DELETE FROM tbl_help_content_rating
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