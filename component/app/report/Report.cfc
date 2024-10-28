<cfcomponent>
    <cffunction name="getReport" access="public" returntype="query" hint="Get Report data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="ID" type="numeric" required="yes" default="0">
    <cfargument name="excludeID" type="numeric" required="yes" default="0">
    <cfargument name="rName" type="string" required="yes" default="">
    <cfargument name="rStatus" type="string" required="yes" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="rName">
    <cfset var rsReport = "" >
    <cftry>
    <cfquery name="rsReport" datasource="#application.mcmsDSN#">
    SELECT * FROM tbl_report WHERE 0=0
    <cfif ARGUMENTS.ID NEQ 0>
    AND ID = <cfqueryparam value="#ARGUMENTS.ID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.excludeID NEQ 0>
    AND ID <> <cfqueryparam value="#ARGUMENTS.excludeID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(rName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(rDescription) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">)
    </cfif>
    <cfif ARGUMENTS.rName NEQ "">
    AND UPPER(rName) = <cfqueryparam value="#UCASE(ARGUMENTS.rName)#" cfsqltype="cf_sql_varchar">
    </cfif>
    AND rStatus IN (<cfqueryparam value="#ARGUMENTS.rStatus#" list="yes" cfsqltype="cf_sql_integer">)
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsReport = StructNew()>
    <cfset rsReport.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsReport>
    </cffunction>
    
    <cffunction name="getReportCustom" access="public" returntype="query" hint="Get Custom Report data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="ID" type="numeric" required="yes" default="0">
    <cfargument name="excludeID" type="numeric" required="yes" default="0">
    <cfargument name="rcName" type="string" required="yes" default="">
    <cfargument name="rcStatus" type="string" required="yes" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="rcName">
    <cfset var rsReportCustom = "" >
    <cftry>
    <cfquery name="rsReportCustom" datasource="#application.mcmsDSN#">
    SELECT * FROM v_report_custom WHERE 0=0
    <cfif ARGUMENTS.ID NEQ 0>
    AND ID = <cfqueryparam value="#ARGUMENTS.ID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.excludeID NEQ 0>
    AND ID <> <cfqueryparam value="#ARGUMENTS.excludeID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(rcName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(rcDescription) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">)
    </cfif>
    <cfif ARGUMENTS.rcName NEQ "">
    AND UPPER(rcName) = <cfqueryparam value="#UCASE(ARGUMENTS.rcName)#" cfsqltype="cf_sql_varchar">
    </cfif>
    AND rcStatus IN (<cfqueryparam value="#ARGUMENTS.rcStatus#" list="yes" cfsqltype="cf_sql_integer">)
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsReportCustom = StructNew()>
    <cfset rsReportCustom.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsReportCustom>
    </cffunction>
    
    <cffunction name="getReportMenu" access="public" returntype="query" hint="Get Report Menu data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="ID" type="numeric" required="yes" default="0">
    <cfargument name="excludeID" type="numeric" required="yes" default="0">
    <cfargument name="rID" type="numeric" required="yes" default="0">
    <cfargument name="rmName" type="string" required="yes" default="">
    <cfargument name="rmStatus" type="string" required="yes" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="rmName">
    <cfset var rsReportMenu = "" >
    <cftry>
    <cfquery name="rsReportMenu" datasource="#application.mcmsDSN#">
    SELECT * FROM v_report_menu WHERE 0=0
    <cfif ARGUMENTS.ID NEQ 0>
    AND ID = <cfqueryparam value="#ARGUMENTS.ID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.excludeID NEQ 0>
    AND ID <> <cfqueryparam value="#ARGUMENTS.excludeID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(rmName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(rmDescription) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">)
    </cfif>
    <cfif ARGUMENTS.rID NEQ 0>
    AND rID = <cfqueryparam value="#ARGUMENTS.rID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.rmName NEQ "">
    AND UPPER(rmName) = <cfqueryparam value="#UCASE(ARGUMENTS.rmName)#" cfsqltype="cf_sql_varchar">
    </cfif>
    AND rmStatus IN (<cfqueryparam value="#ARGUMENTS.rmStatus#" list="yes" cfsqltype="cf_sql_integer">)
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsReportMenu = StructNew()>
    <cfset rsReportMenu.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsReportMenu>
    </cffunction>
    
    <cffunction name="getReportMenuDetail" access="public" returntype="query" hint="Get Report Menu Detail data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="ID" type="numeric" required="yes" default="0">
    <cfargument name="excludeID" type="numeric" required="yes" default="0">
    <cfargument name="rID" type="numeric" required="yes" default="0">
    <cfargument name="rmID" type="numeric" required="yes" default="0">
    <cfargument name="rmstrID" type="numeric" required="yes" default="0">
    <cfargument name="rmdName" type="string" required="yes" default="">
    <cfargument name="rmdStatus" type="string" required="yes" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="rmdName">
    <cfset var rsReportMenuDetail = "" >
    <cftry>
    <cfquery name="rsReportMenuDetail" datasource="#application.mcmsDSN#">
    SELECT * FROM v_report_menu_detail WHERE 0=0
    <cfif ARGUMENTS.ID NEQ 0>
    AND ID = <cfqueryparam value="#ARGUMENTS.ID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.excludeID NEQ 0>
    AND ID <> <cfqueryparam value="#ARGUMENTS.excludeID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(rmdName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(rmdDescription) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">)
    </cfif>
    <cfif ARGUMENTS.rID NEQ 0>
    AND rID = <cfqueryparam value="#ARGUMENTS.rID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.rmID NEQ 0>
    AND rmID = <cfqueryparam value="#ARGUMENTS.rmID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.rmstrID NEQ 0>
    AND rmstrID = <cfqueryparam value="#ARGUMENTS.rmstrID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.rmdName NEQ "">
    AND UPPER(rmdName) = <cfqueryparam value="#UCASE(ARGUMENTS.rmdName)#" cfsqltype="cf_sql_varchar">
    </cfif>
    AND rmdStatus IN (<cfqueryparam value="#ARGUMENTS.rmdStatus#" list="yes" cfsqltype="cf_sql_integer">)
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsReportMenuDetail = StructNew()>
    <cfset rsReportMenuDetail.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsReportMenuDetail>
    </cffunction>
    
    <cffunction name="getReportTemplate" access="public" returntype="query" hint="Get Report Template data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="ID" type="numeric" required="yes" default="0">
    <cfargument name="excludeID" type="numeric" required="yes" default="0">
    <cfargument name="rtName" type="string" required="yes" default="">
    <cfargument name="rtStatus" type="string" required="yes" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="rtName">
    <cfset var rsReportTemplate = "" >
    <cftry>
    <cfquery name="rsReportTemplate" datasource="#application.mcmsDSN#">
    SELECT * FROM tbl_report_template WHERE 0=0
    <cfif ARGUMENTS.ID NEQ 0>
    AND ID = <cfqueryparam value="#ARGUMENTS.ID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.excludeID NEQ 0>
    AND ID <> <cfqueryparam value="#ARGUMENTS.excludeID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(rtName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(rtDescription) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">)
    </cfif>
    <cfif ARGUMENTS.rtName NEQ "">
    AND UPPER(rtName) = <cfqueryparam value="#UCASE(ARGUMENTS.rtName)#" cfsqltype="cf_sql_varchar">
    </cfif>
    AND rtStatus IN (<cfqueryparam value="#ARGUMENTS.rtStatus#" list="yes" cfsqltype="cf_sql_integer">)
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsReportTemplate = StructNew()>
    <cfset rsReportTemplate.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsReportTemplate>
    </cffunction>
    
    <cffunction name="getReportSQL" access="public" returntype="query" hint="Get Report SQL data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="ID" type="numeric" required="yes" default="0">
    <cfargument name="excludeID" type="string" required="yes" default="0">
    <cfargument name="rsName" type="string" required="yes" default="">
    <cfargument name="rsStatus" type="string" required="yes" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="rsName">
    <cfset var rsReportSQL = "" >
    <cftry>
    <cfquery name="rsReportSQL" datasource="#application.mcmsDSN#">
    SELECT * FROM tbl_report_sql WHERE 0=0
    <cfif ARGUMENTS.ID NEQ 0>
    AND ID = <cfqueryparam value="#ARGUMENTS.ID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.excludeID NEQ 0>
    AND ID NOT IN (<cfqueryparam value="#ARGUMENTS.excludeID#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(rsName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(rsDescription) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">)
    </cfif>
    <cfif ARGUMENTS.rsName NEQ "">
    AND UPPER(rsName) = <cfqueryparam value="#UCASE(ARGUMENTS.rsName)#" cfsqltype="cf_sql_varchar">
    </cfif>
    AND rsStatus IN (<cfqueryparam value="#ARGUMENTS.rsStatus#" list="yes" cfsqltype="cf_sql_integer">)
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsReportSQL = StructNew()>
    <cfset rsReportSQL.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsReportSQL>
    </cffunction>
		
    <cffunction name="getReportQuery" access="public" returntype="query" hint="Get Report Query Form data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="ID" type="numeric" required="yes" default="0">
    <cfargument name="excludeID" type="numeric" required="yes" default="0">
    <cfargument name="rqName" type="string" required="yes" default="">
    <cfargument name="rqStatus" type="numeric" required="yes" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="rqName">
    <cfset var rsReportQuery = "" >
    <cftry>
    <cfquery name="rsReportQuery" datasource="#application.mcmsDSN#">
    SELECT * FROM v_report_query WHERE 0=0
    <cfif ARGUMENTS.ID NEQ 0>
    AND ID = <cfqueryparam value="#ARGUMENTS.ID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.excludeID NEQ 0>
    AND ID <> <cfqueryparam value="#ARGUMENTS.excludeID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(rqName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(rqDescription) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">)
    </cfif>
    <cfif ARGUMENTS.rqName NEQ "">
    AND UPPER(rqName) = <cfqueryparam value="#UCASE(ARGUMENTS.rqName)#" cfsqltype="cf_sql_varchar">
    </cfif>
    AND rqStatus IN (<cfqueryparam value="#ARGUMENTS.rqStatus#" list="yes" cfsqltype="cf_sql_integer">)
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsReportQuery = StructNew()>
    <cfset rsReportQuery.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsReportQuery>
    </cffunction>
    
    <cffunction name="getReportQueryType" access="public" returntype="query" hint="Get Report Query Type data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="ID" type="numeric" required="yes" default="0">
    <cfargument name="excludeID" type="numeric" required="yes" default="0">
    <cfargument name="rqtStatus" type="string" required="yes" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="rqtName">
    <cfset var rsReportQueryType = "" >
    <cftry>
    <cfquery name="rsReportQueryType" datasource="#application.mcmsDSN#">
    SELECT * FROM tbl_report_query_type WHERE 0=0
    <cfif ARGUMENTS.ID NEQ 0>
    AND ID = <cfqueryparam value="#ARGUMENTS.ID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.excludeID NEQ 0>
    AND ID <> <cfqueryparam value="#ARGUMENTS.excludeID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND UPPER(rqtName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">
    </cfif>
    AND rqtStatus IN (<cfqueryparam value="#ARGUMENTS.rqtStatus#" list="yes" cfsqltype="cf_sql_integer">)
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsReportQueryType = StructNew()>
    <cfset rsReportQueryType.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsReportQueryType>
    </cffunction>
    
    <cffunction name="getReportUserRoleAccess" access="public" returntype="query" hint="Get Report User Role access data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="ID" type="numeric" required="yes" default="0">
    <cfargument name="excludeID" type="numeric" required="yes" default="0">
    <cfargument name="rurID" type="numeric" required="yes" default="0">
    <cfargument name="rID" type="string" required="yes" default="0">
    <cfargument name="rcID" type="string" required="yes" default="0">
    <cfargument name="ruraStatus" type="string" required="yes" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="urName">
	<cfset var rsReportUserRoleAccess = "" >
    <cftry>
    <cfquery name="rsReportUserRoleAccess" datasource="#application.mcmsDSN#">
    SELECT * FROM v_report_user_role_access WHERE 0=0
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(urName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">)
    </cfif>
    <cfif ARGUMENTS.ID NEQ 0>
    AND ID = <cfqueryparam value="#ARGUMENTS.ID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.excludeID NEQ 0>
    AND ID <> <cfqueryparam value="#ARGUMENTS.excludeID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.rurID NEQ 0>
    AND rurID = <cfqueryparam value="#ARGUMENTS.rurID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.rID NEQ 0>
    AND rID IN (<cfqueryparam value="#ARGUMENTS.rID#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    <cfif ARGUMENTS.rcID NEQ 0>
    AND rcID IN (<cfqueryparam value="#ARGUMENTS.rcID#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    AND urStatus IN (<cfqueryparam value="#ARGUMENTS.ruraStatus#" list="yes" cfsqltype="cf_sql_integer">)
    AND ruaStatus IN (<cfqueryparam value="#ARGUMENTS.ruraStatus#" list="yes" cfsqltype="cf_sql_integer">)
    AND (rStatus IN (<cfqueryparam value="#ARGUMENTS.ruraStatus#" list="yes" cfsqltype="cf_sql_integer">) OR rStatus IS NULL)
    AND ruraStatus IN (<cfqueryparam value="#ARGUMENTS.ruraStatus#" list="yes" cfsqltype="cf_sql_integer">)
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsReportUserRoleAccess = StructNew()>
    <cfset rsReportUserRoleAccess.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsReportUserRoleAccess>
    </cffunction>
    
    <cffunction name="getReportUserAccess" access="public" returntype="query" hint="Get Report User Access data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="ID" type="numeric" required="yes" default="0">
    <cfargument name="excludeID" type="numeric" required="yes" default="0">
    <cfargument name="ruaStatus" type="string" required="yes" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="ruaName">
	<cfset var rsReportUserAccess = "" >
    <cftry>
    <cfquery name="rsReportUserAccess" datasource="#application.mcmsDSN#">
    SELECT * FROM v_report_user_access WHERE 0=0
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(ruaName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(ruaDescription) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">)
    </cfif>
    <cfif ARGUMENTS.ID NEQ 0>
    AND ID = <cfqueryparam value="#ARGUMENTS.ID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.excludeID NEQ 0>
    AND ID <> <cfqueryparam value="#ARGUMENTS.excludeID#" cfsqltype="cf_sql_integer">
    </cfif>
    AND ruaStatus IN (<cfqueryparam value="#ARGUMENTS.ruaStatus#" list="yes" cfsqltype="cf_sql_integer">)
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsReportUserAccess = StructNew()>
    <cfset rsReportUserAccess.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsReportUserAccess>
    </cffunction>
    
    <cffunction name="getReportSQLTemplateAttribute" access="public" returntype="query" hint="Get Report Template Attribute data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="ID" type="numeric" required="yes" default="0">
    <cfargument name="excludeID" type="numeric" required="yes" default="0">
    <cfargument name="rstaName" type="string" required="yes" default="">
    <cfargument name="rstaStatus" type="string" required="yes" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="rstaName">
    <cfset var rsReportSQLTemplateAttribute = "" >
    <cftry>
    <cfquery name="rsReportSQLTemplateAttribute" datasource="#application.mcmsDSN#">
    SELECT * FROM v_rpt_sql_template_attribute WHERE 0=0
    <cfif ARGUMENTS.ID NEQ 0>
    AND ID = <cfqueryparam value="#ARGUMENTS.ID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.excludeID NEQ 0>
    AND ID <> <cfqueryparam value="#ARGUMENTS.excludeID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(rstaName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(rstaDescription) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">)
    </cfif>
    <cfif ARGUMENTS.rstaName NEQ "">
    AND UPPER(rstaName) = <cfqueryparam value="#UCASE(ARGUMENTS.rstaName)#" cfsqltype="cf_sql_varchar">
    </cfif>
    AND rstaStatus IN (<cfqueryparam value="#ARGUMENTS.rstaStatus#" list="yes" cfsqltype="cf_sql_integer">)
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsReportSQLTemplateAttribute = StructNew()>
    <cfset rsReportSQLTemplateAttribute.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsReportSQLTemplateAttribute>
    </cffunction>
    
    <cffunction name="getReportSQLTemplateAttributeType" access="public" returntype="query" hint="Get Report Template Attribute Type data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="ID" type="numeric" required="yes" default="0">
    <cfargument name="excludeID" type="numeric" required="yes" default="0">
    <cfargument name="rstatName" type="string" required="yes" default="">
    <cfargument name="rstatStatus" type="string" required="yes" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="rstatName">
    <cfset var rsReportSQLTemplateAttributeType = "" >
    <cftry>
    <cfquery name="rsReportSQLTemplateAttributeType" datasource="#application.mcmsDSN#">
    SELECT * FROM tbl_rpt_sql_template_atr_type WHERE 0=0
    <cfif ARGUMENTS.ID NEQ 0>
    AND ID = <cfqueryparam value="#ARGUMENTS.ID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.excludeID NEQ 0>
    AND ID <> <cfqueryparam value="#ARGUMENTS.excludeID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(rstatName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">)
    </cfif>
    <cfif ARGUMENTS.rstatName NEQ "">
    AND UPPER(rstatName) = <cfqueryparam value="#UCASE(ARGUMENTS.rstatName)#" cfsqltype="cf_sql_varchar">
    </cfif>
    AND rstatStatus IN (<cfqueryparam value="#ARGUMENTS.rstatStatus#" list="yes" cfsqltype="cf_sql_integer">)
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsReportSQLTemplateAttributeType = StructNew()>
    <cfset rsReportSQLTemplateAttributeType.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsReportSQLTemplateAttributeType>
    </cffunction>
    
    <cffunction name="getReportSQLTemplate" access="public" returntype="query" hint="Get Report SQL Template data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="ID" type="numeric" required="yes" default="0">
    <cfargument name="excludeID" type="numeric" required="yes" default="0">
    <cfargument name="rstName" type="string" required="yes" default="">
    <cfargument name="rstStatus" type="string" required="yes" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="rstName">
    <cfset var rsReportSQLTemplate = "" >
    <cftry>
    <cfquery name="rsReportSQLTemplate" datasource="#application.mcmsDSN#">
    SELECT * FROM v_report_sql_template WHERE 0=0
    <cfif ARGUMENTS.ID NEQ 0>
    AND ID = <cfqueryparam value="#ARGUMENTS.ID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.excludeID NEQ 0>
    AND ID <> <cfqueryparam value="#ARGUMENTS.excludeID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(rstName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(rstDescription) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">)
    </cfif>
    <cfif ARGUMENTS.rstName NEQ "">
    AND UPPER(rstName) = <cfqueryparam value="#UCASE(ARGUMENTS.rstName)#" cfsqltype="cf_sql_varchar">
    </cfif>
    AND rstStatus IN (<cfqueryparam value="#ARGUMENTS.rstStatus#" list="yes" cfsqltype="cf_sql_integer">)
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsReportSQLTemplate = StructNew()>
    <cfset rsReportSQLTemplate.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsReportSQLTemplate>
    </cffunction>
    
    <cffunction name="getReportSQLTemplateAttributeRel" access="public" returntype="query" hint="Get Report SQL Template Attribute Relationship data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="ID" type="numeric" required="yes" default="0">
    <cfargument name="excludeID" type="numeric" required="yes" default="0">
    <cfargument name="rstID" type="numeric" required="yes" default="0">
    <cfargument name="rstaID" type="numeric" required="yes" default="0">
    <cfargument name="rstName" type="string" required="yes" default="">
    <cfargument name="rstaName" type="string" required="yes" default="">
    <cfargument name="rstarStatus" type="string" required="yes" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="rstName">
    <cfset var rsReportSQLTemplateAttributeRel = "" >
    <cftry>
    <cfquery name="rsReportSQLTemplateAttributeRel" datasource="#application.mcmsDSN#">
    SELECT * FROM v_rpt_sql_template_atr_rel WHERE 0=0
    <cfif ARGUMENTS.ID NEQ 0>
    AND ID = <cfqueryparam value="#ARGUMENTS.ID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.excludeID NEQ 0>
    AND ID <> <cfqueryparam value="#ARGUMENTS.excludeID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(rstName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(rstaName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">)
    </cfif>
    <cfif ARGUMENTS.rstID NEQ 0>
    AND rstID = <cfqueryparam value="#ARGUMENTS.rstID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.rstaID NEQ 0>
    AND rstaID = <cfqueryparam value="#ARGUMENTS.rstaID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.rstName NEQ "">
    AND UPPER(rstName) = <cfqueryparam value="#UCASE(ARGUMENTS.rstName)#" cfsqltype="cf_sql_varchar">
    </cfif>
    <cfif ARGUMENTS.rstaName NEQ "">
    AND UPPER(rstaName) = <cfqueryparam value="#UCASE(ARGUMENTS.rstaName)#" cfsqltype="cf_sql_varchar">
    </cfif>
    AND rstarStatus IN (<cfqueryparam value="#ARGUMENTS.rstarStatus#" list="yes" cfsqltype="cf_sql_integer">)
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsReportSQLTemplateAttributeRel = StructNew()>
    <cfset rsReportSQLTemplateAttributeRel.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsReportSQLTemplateAttributeRel>
    </cffunction>
    
    <cffunction name="getReportMenuSQLTemplateRel" access="public" returntype="query" hint="Get Report Menu SQL Template Relationship data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="ID" type="numeric" required="yes" default="0">
    <cfargument name="excludeID" type="string" required="yes" default="0">
    <cfargument name="rID" type="numeric" required="yes" default="0">
    <cfargument name="rmID" type="numeric" required="yes" default="0">
    <cfargument name="rsID" type="numeric" required="yes" default="0">
    <cfargument name="rstID" type="numeric" required="yes" default="0">
    <cfargument name="rmstrStatus" type="string" required="yes" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="rName">
    <cfset var rsReportMenuSQLTemplateRel = "" >
    <cftry>
    <cfquery name="rsReportMenuSQLTemplateRel" datasource="#application.mcmsDSN#">
    SELECT * FROM v_rpt_menu_sql_template_rel WHERE 0=0
    <cfif ARGUMENTS.ID NEQ 0>
    AND ID = <cfqueryparam value="#ARGUMENTS.ID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.excludeID NEQ 0>
    AND ID NOT IN (<cfqueryparam value="#ARGUMENTS.excludeID#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(rName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(rmName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">)
    </cfif>
    <cfif ARGUMENTS.rID NEQ 0>
    AND rID = <cfqueryparam value="#ARGUMENTS.rID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.rmID NEQ 0>
    AND rmID = <cfqueryparam value="#ARGUMENTS.rmID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.rsID NEQ 0>
    AND rsID = <cfqueryparam value="#ARGUMENTS.rsID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.rstID NEQ 0>
    AND rstID = <cfqueryparam value="#ARGUMENTS.rstID#" cfsqltype="cf_sql_integer">
    </cfif>
    AND rmstrStatus IN (<cfqueryparam value="#ARGUMENTS.rmstrStatus#" list="yes" cfsqltype="cf_sql_integer">)
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsReportMenuSQLTemplateRel = StructNew()>
    <cfset rsReportMenuSQLTemplateRel.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsReportMenuSQLTemplateRel>
    </cffunction>
    
    <cffunction name="getReportReport" access="public" returntype="query" hint="Get Report Report data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="orderBy" type="string" required="yes" default="rName">
    <cfset var rsReportReport = "" >
    <cftry>
    <cfquery name="rsReportReport" datasource="#application.mcmsDSN#">
    SELECT rName as Name, rDescription as Description FROM tbl_report WHERE 0=0
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(rName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(rDescription) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">)
    </cfif>
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsReportReport = StructNew()>
    <cfset rsReportReport.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsReportReport>
    </cffunction>
    
    <cffunction name="getReportCustomReport" access="public" returntype="query" hint="Get Report Custom Report data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="orderBy" type="string" required="yes" default="rcName">
    <cfset var rsReportCustomReport = "" >
    <cftry>
    <cfquery name="rsReportCustomReport" datasource="#application.mcmsDSN#">
    SELECT rcName, rcDescription FROM tbl_report_custom WHERE 0=0
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(rcName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(rcDescription) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">)
    </cfif>
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsReportCustomReport = StructNew()>
    <cfset rsReportCustomReport.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsReportCustomReport>
    </cffunction>
    
    <cffunction name="getReportMenuReport" access="public" returntype="query" hint="Get Report Menu Report data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="orderBy" type="string" required="yes" default="rmName">
    <cfset var rsReportMenuReport = "" >
    <cftry>
    <cfquery name="rsReportMenuReport" datasource="#application.mcmsDSN#">
    SELECT rmName as Name, rtName as Template, rmDescription as Description FROM v_report_menu WHERE 0=0
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(rmName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(rmDescription) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">)
    </cfif>
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsReportMenuReport = StructNew()>
    <cfset rsReportMenuReport.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsReportMenuReport>
    </cffunction>
    
    <cffunction name="getReportMenuDetailReport" access="public" returntype="query" hint="Get Report Menu Detail Report data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="orderBy" type="string" required="yes" default="rmdName">
    <cfset var rsReportMenuDetailReport = "" >
    <cftry>
    <cfquery name="rsReportMenuDetailReport" datasource="#application.mcmsDSN#">
    SELECT rmdName as Name, rName as Report, rmdDescription as Description FROM v_report_menu_detail WHERE 0=0
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(rmdName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(rmdDescription) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">)
    </cfif>
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsReportMenuDetailReport = StructNew()>
    <cfset rsReportMenuDetailReport.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsReportMenuDetailReport>
    </cffunction>
    
    <cffunction name="getReportSQLReport" access="public" returntype="query" hint="Get Report SQL Report data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="orderBy" type="string" required="yes" default="rsName">
    <cfset var rsReportSQLReport = "" >
    <cftry>
    <cfquery name="rsReportSQLReport" datasource="#application.mcmsDSN#">
    SELECT rsName, rsDescription FROM tbl_report_sql WHERE 0=0
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(rsName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(rsDescription) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">)
    </cfif>
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsReportSQLReport = StructNew()>
    <cfset rsReportSQLReport.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsReportSQLReport>
    </cffunction>
    
    <cffunction name="getReportTemplateReport" access="public" returntype="query" hint="Get Report Template Report data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="orderBy" type="string" required="yes" default="rtName">
    <cfset var rsReportTemplateReport = "" >
    <cftry>
    <cfquery name="rsReportTemplateReport" datasource="#application.mcmsDSN#">
    SELECT rtName As Name, rtDescription As Description, rtFile As RT_File, rtStatus As Status FROM tbl_report_template WHERE 0=0
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(rtName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(rtDescription) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">)
    </cfif>
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsReportTemplateReport = StructNew()>
    <cfset rsReportTemplateReport.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsReportTemplateReport>
    </cffunction>
		
    <cffunction name="getReportQueryReport" access="public" returntype="query" hint="Get Report Query Report data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="orderBy" type="string" required="yes" default="rqName">
    <cfset var rsReportQueryReport = "" >
    <cftry>
    <cfquery name="rsReportQueryReport" datasource="#application.mcmsDSN#">
    SELECT rqName As Name, rqDescription As Description, rqOptionName As Option_Name, rqOptionValue As Option_Value, rqtName As Type, sName As Status FROM v_report_query WHERE 0=0
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(rqName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(rqDescription) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">)
    </cfif>
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsReportQueryReport = StructNew()>
    <cfset rsReportQueryReport.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsReportQueryReport>
    </cffunction>
    
    <cffunction name="getReportUserRoleAccessReport" access="public" returntype="query" hint="Get Report User Role Access data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="orderBy" type="string" required="yes" default="urName">
	<cfset var rsReportUserRoleAccessReport = "" >
    <cftry>
    <cfquery name="rsReportUserRoleAccessReport" datasource="#application.mcmsDSN#">
    SELECT urName AS Name, ruaName AS Access_Level, rName AS Report_Name, sName AS Status 
    FROM v_report_user_role_access WHERE 0=0
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(urName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(ruaName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(rName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">)
    </cfif>
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsReportUserRoleAccessReport = StructNew()>
    <cfset rsReportUserRoleAccessReport.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsReportUserRoleAccessReport>
    </cffunction>
    
    <cffunction name="getReportSQLTemplateAttributeReport" access="public" returntype="query" hint="Get Report Template Attribute data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="orderBy" type="string" required="yes" default="rstaName">
	<cfset var rsReportSQLTemplateAttributeReport = "" >
    <cftry>
    <cfquery name="rsReportSQLTemplateAttributeReport" datasource="#application.mcmsDSN#">
    SELECT rstaName AS Name, rstaDescription AS Description, rstaDefaultValue AS Default_Value, rstaListValue AS List_Value, rstatName AS Type, sortName AS Sort, sName AS Status 
    FROM v_rpt_sql_template_attribute WHERE 0=0
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(rstaName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(rstaDescription) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">)
    </cfif>
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsReportSQLTemplateAttributeReport = StructNew()>
    <cfset rsReportSQLTemplateAttributeReport.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsReportSQLTemplateAttributeReport>
    </cffunction>
    
    <cffunction name="getReportSQLTemplateAttributeRelReport" access="public" returntype="query" hint="Get Report SQL Template Attribute Relationship data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="orderBy" type="string" required="yes" default="rstaName">
	<cfset var rsReportSQLTemplateAttributeRelReport = "" >
    <cftry>
    <cfquery name="rsReportSQLTemplateAttributeRelReport" datasource="#application.mcmsDSN#">
    SELECT rstName AS Template, rstaName AS Name, rstaDescription AS Description, rstaDefaultValue AS Default_Value, rstaListValue AS List_Value, sName AS Status 
    FROM v_rpt_sql_template_atr_rel WHERE 0=0
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(rstaName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(rstaDescription) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">)
    </cfif>
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsReportSQLTemplateAttributeRelReport = StructNew()>
    <cfset rsReportSQLTemplateAttributeRelReport.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsReportSQLTemplateAttributeRelReport>
    </cffunction>
    
    <cffunction name="getReportSQLTemplateReport" access="public" returntype="query" hint="Get Report SQL Template Report data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="orderBy" type="string" required="yes" default="rstName">
    <cfset var rsReportSQLTemplateReport = "" >
    <cftry>
    <cfquery name="rsReportSQLTemplateReport" datasource="#application.mcmsDSN#">
    SELECT rstName As Name, rstDescription As Description, rstFile As RST_File, rstStatus As Status FROM tbl_report_sql_template WHERE 0=0
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(rstName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(rstDescription) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">)
    </cfif>
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsReportSQLTemplateReport = StructNew()>
    <cfset rsReportSQLTemplateReport.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsReportSQLTemplateReport>
    </cffunction>
    
    <cffunction name="getReportMenuSQLTemplateRelReport" access="public" returntype="query" hint="Get Report Menu SQL Template Rel. Report data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="orderBy" type="string" required="yes" default="rName">
    <cfset var rsReportMenuSQLTemplateRelReport = "" >
    <cftry>
    <cfquery name="rsReportMenuSQLTemplateRelReport" datasource="#application.mcmsDSN#">
    SELECT rName As Report, rmName As Type, DECODE(rmtID,1,'Master','Detail') As Menu_Type, rsName As SQL, rstName As Template, sName As Status FROM v_rpt_menu_sql_template_rel WHERE 0=0
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(rName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(rmName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">)
    </cfif>
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsReportMenuSQLTemplateRelReport = StructNew()>
    <cfset rsReportMenuSQLTemplateRelReport.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsReportMenuSQLTemplateRelReport>
    </cffunction>
    
    <cffunction name="insertReport" access="public" returntype="struct">
    <cfargument name="rName" type="string" required="yes">
    <cfargument name="rDescription" type="string" required="yes">
    <cfargument name="rStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully inserted the record.">
    <cftry>
    <!---Check for profanity in the text.--->
    <cfinvoke 
    component="MCMS.component.utility.Regex"
    method="regexProfanity"
    returnvariable="regexProfanityRet">
    <cfinvokeargument name="profanityString" value="#ARGUMENTS.rDescription#"/>
    </cfinvoke>
    <!---Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.app.report.Report"
    method="getReport"
    returnvariable="getCheckReportRet">
    <cfinvokeargument name="rName" value="#ARGUMENTS.rName#"/>
    <cfinvokeargument name="rStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckReportRet.recordcount NEQ 0>
    <cfset result.message = "The name #ARGUMENTS.rName# already exists, please enter a new name.">
    <cfelseif regexProfanityRet CONTAINS '$%&*!'>
    <cfset result.message = "Some text contained profanity, please remove any profanity from your text.">
    <!---Check length restriction.--->
    <cfelseif LEN(ARGUMENTS.rDescription) GT 2048>
    <cfset result.message = "The description is longer than 2048 characters, please enter a new description under 2048 characters.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    INSERT INTO tbl_report (rName,rDescription,rStatus) VALUES
    (
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.rName#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.rDescription#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.rStatus#">
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
    
    <cffunction name="insertReportCustom" access="public" returntype="struct">
    <cfargument name="rcName" type="string" required="yes">
    <cfargument name="rcDescription" type="string" required="yes">
    <cfargument name="rcPath" type="string" required="yes">
    <cfargument name="rcStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully inserted the record.">
    <cftry>
    <!---Check for profanity in the text.--->
    <cfinvoke 
    component="MCMS.component.utility.Regex"
    method="regexProfanity"
    returnvariable="regexProfanityRet">
    <cfinvokeargument name="profanityString" value="#ARGUMENTS.rcDescription#"/>
    </cfinvoke>
    <!---Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.app.report.Report"
    method="getReportCustom"
    returnvariable="getCheckReportCustomRet">
    <cfinvokeargument name="rcName" value="#ARGUMENTS.rcName#"/>
    <cfinvokeargument name="rcStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckReportCustomRet.recordcount NEQ 0>
    <cfset result.message = "The name #ARGUMENTS.rcName# already exists, please enter a new name.">
    <cfelseif regexProfanityRet CONTAINS '$%&*!'>
    <cfset result.message = "Some text contained profanity, please remove any profanity from your text.">
    <!---Check length restriction.--->
    <cfelseif LEN(ARGUMENTS.rcDescription) GT 2048>
    <cfset result.message = "The description is longer than 2048 characters, please enter a new description under 2048 characters.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    INSERT INTO tbl_report_custom (rcName,rcDescription,rcPath,rcStatus) VALUES
    (
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.rcName#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.rcDescription#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.rcPath#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.rcStatus#">
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
    
    <cffunction name="insertReportMenuSQLTemplateRel" access="public" returntype="struct" hint="Used for Report Builder.">
    <cfargument name="rID" type="numeric" required="yes">
    <cfargument name="rmID" type="numeric" required="yes">
    <cfargument name="rsID" type="numeric" required="yes">
    <cfargument name="rstID" type="numeric" required="yes">
    <cfargument name="rmtID" type="numeric" required="yes">
    <cfargument name="rmstrStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully inserted the record.">
    <cftry>
    <!---Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.app.report.Report"
    method="getReportMenuSQLTemplateRel"
    returnvariable="getCheckReportMenuSQLTemplateRelRet">
    <cfinvokeargument name="rID" value="#ARGUMENTS.rID#"/>
    <cfinvokeargument name="rmID" value="#ARGUMENTS.rmID#"/>
    <cfinvokeargument name="rsID" value="#ARGUMENTS.rsID#"/>
    <cfinvokeargument name="rstID" value="#ARGUMENTS.rstID#"/>
    <cfinvokeargument name="rmtID" value="#ARGUMENTS.rmtID#"/>
    <cfinvokeargument name="rmstrStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckReportMenuSQLTemplateRelRet.recordcount NEQ 0>
    <cfset result.message = "The report you have built already exists, please try again.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    INSERT INTO tbl_rpt_menu_sql_template_rel (rID,rmID,rsID,rstID,rmtID,rmstrStatus) VALUES
    (
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.rID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.rmID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.rsID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.rstID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.rmtID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.rmstrStatus#">
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
    
    <cffunction name="insertReportMenu" access="public" returntype="struct">
    <cfargument name="rmName" type="string" required="yes">
    <cfargument name="rmDescription" type="string" required="yes">
    <cfargument name="rID" type="numeric" required="yes">
    <cfargument name="rtID" type="numeric" required="yes">
    <cfargument name="rmSort" type="numeric" required="yes">
    <cfargument name="rmStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully inserted the record.">
    <cftry>
    <!---Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.app.report.Report"
    method="getReportMenu"
    returnvariable="getCheckReportMenuRet">
    <cfinvokeargument name="rID" value="#ARGUMENTS.rID#"/>
    <cfinvokeargument name="rmName" value="#ARGUMENTS.rmName#"/>
    <cfinvokeargument name="rmStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckReportMenuRet.recordcount NEQ 0>
    <cfset result.message = "The name #ARGUMENTS.rmName# already exists for this report, please enter a new name.">
    <!---Check length restriction.--->
    <cfelseif LEN(ARGUMENTS.rmDescription) GT 2048>
    <cfset result.message = "The description is longer than 2048 characters, please enter a new description under 2048 characters.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    INSERT INTO tbl_report_menu (rmName,rmDescription,rID,rtID,rmSort,rmStatus) VALUES
    (
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.rmName#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.rmDescription#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.rID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.rtID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.rmSort#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.rmStatus#">
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
    
    <cffunction name="insertReportMenuDetail" access="public" returntype="struct">
    <cfargument name="rmdName" type="string" required="yes">
    <cfargument name="rmdNameAlt" type="string" required="yes">
    <cfargument name="rmdDescription" type="string" required="yes">
    <cfargument name="rID" type="numeric" required="yes">
    <cfargument name="rmID" type="numeric" required="yes">
    <cfargument name="rmstrID" type="numeric" required="yes">
    <cfargument name="rmdSort" type="numeric" required="yes">
    <cfargument name="rmdStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully inserted the record.">
    <cftry>
    <!---Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.app.report.Report"
    method="getReportMenuDetail"
    returnvariable="getCheckReportMenuDetailRet">
    <cfinvokeargument name="rID" value="#ARGUMENTS.rID#"/>
    <cfinvokeargument name="rmID" value="#ARGUMENTS.rmID#"/>
    <cfinvokeargument name="rmstrID" value="#ARGUMENTS.rmstrID#"/>
    <cfinvokeargument name="rmdName" value="#ARGUMENTS.rmdName#"/>
    <cfinvokeargument name="rmdStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckReportMenuDetailRet.recordcount NEQ 0>
    <cfset result.message = "The menu detail already exists for this report, please try again.">
    <!---Check length restriction.--->
    <cfelseif LEN(ARGUMENTS.rmdDescription) GT 2048>
    <cfset result.message = "The description is longer than 2048 characters, please enter a new description under 2048 characters.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    INSERT INTO tbl_report_menu_detail (rmdName,rmdNameAlt,rmdDescription,rID,rmID,rmstrID,rmdSort,rmdStatus) VALUES
    (
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.rmdName#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.rmdNameAlt#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.rmdDescription#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.rID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.rmID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.rmstrID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.rmdSort#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.rmdStatus#">
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
    
    <cffunction name="insertReportSQL" access="public" returntype="struct">
    <cfargument name="rsName" type="string" required="yes">
    <cfargument name="rsShortDescription" type="string" required="yes">
    <cfargument name="rsDescription" type="string" required="yes">
    <cfargument name="rsDSN" type="string" required="yes">
    <cfargument name="rsSQL" type="string" required="yes">
    <cfargument name="rsColumnList" type="string" required="yes">
    <cfargument name="rsSort" type="numeric" required="yes">
    <cfargument name="rsStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully inserted the record.">
    <cftry>
    <!---Check for profanity in the text.--->
    <cfinvoke 
    component="MCMS.component.utility.Regex"
    method="regexProfanity"
    returnvariable="regexProfanityRet">
    <cfinvokeargument name="profanityString" value="#ARGUMENTS.rsDescription#"/>
    </cfinvoke>
    <!---Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.app.report.Report"
    method="getReportSQL"
    returnvariable="getCheckReportSQLRet">
    <cfinvokeargument name="rsName" value="#ARGUMENTS.rsName#"/>
    <cfinvokeargument name="rsStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckReportSQLRet.recordcount NEQ 0>
    <cfset result.message = "The name #ARGUMENTS.rsName# already exists, please enter a new name.">
    <cfelseif regexProfanityRet CONTAINS '$%&*!'>
    <cfset result.message = "Some text contained profanity, please remove any profanity from your text.">
    <!---Check length restriction.--->
    <cfelseif LEN(ARGUMENTS.rsDescription) GT 2048>
    <cfset result.message = "The description is longer than 2048 characters, please enter a new description under 2048 characters.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    INSERT INTO tbl_report_sql (rsName, rsShortDescription, rsDescription,rsDSN,rsSQL,rsColumnList,rsSort,rsStatus) VALUES
    (
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.rsName#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.rsShortDescription#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.rsDescription#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.rsDSN#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.rsSQL#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.rsColumnList#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.rsSort#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.rsStatus#"> 
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
		
	<cffunction name="insertReportTemplate" access="public" returntype="struct">
    <cfargument name="rtName" type="string" required="yes">
    <cfargument name="rtDescription" type="string" required="yes">
    <cfargument name="rtFile" type="string" required="yes">
    <cfargument name="rtSort" type="numeric" required="yes">
    <cfargument name="rtStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully inserted the record.">
    <cftry>
    <!---Check for profanity in the text.--->
    <cfinvoke 
    component="MCMS.component.utility.Regex"
    method="regexProfanity"
    returnvariable="regexProfanityRet">
    <cfinvokeargument name="profanityString" value="#ARGUMENTS.rtDescription#"/>
    </cfinvoke>
    <!---Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.app.report.Report"
    method="getReportTemplate"
    returnvariable="getCheckReportTemplateRet">
    <cfinvokeargument name="rtName" value="#ARGUMENTS.rtName#"/>
    <cfinvokeargument name="rtStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckReportTemplateRet.recordcount NEQ 0>
    <cfset result.message = "The name #ARGUMENTS.rtName# already exists, please enter a new name.">
    <cfelseif regexProfanityRet CONTAINS '$%&*!'>
    <cfset result.message = "Some text contained profanity, please remove any profanity from your text.">
    <!---Check length restriction.--->
    <cfelseif LEN(ARGUMENTS.rtDescription) GT 2048>
    <cfset result.message = "The description is longer than 2048 characters, please enter a new description under 2048 characters.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    INSERT INTO tbl_report_template (rtName,rtDescription,rtFile,rtSort,rtStatus) VALUES
    (
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.rtName#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.rtDescription#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.rtFile#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.rtSort#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.rtStatus#">
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
    
    <cffunction name="insertReportQuery" access="public" returntype="struct">
    <cfargument name="rqName" type="string" required="yes">
    <cfargument name="rqNameAlt" type="string" required="yes">
    <cfargument name="rqDescription" type="string" required="yes">
    <cfargument name="rqDSN" type="string" required="yes">
    <cfargument name="rqSQL" type="string" required="yes">
    <cfargument name="rqOptionName" type="string" required="yes">
    <cfargument name="rqOptionValue" type="string" required="yes">
    <cfargument name="rqtID" type="numeric" required="yes">
    <cfargument name="rqSort" type="numeric" required="yes">
    <cfargument name="rqStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully inserted the record.">
    <cftry>
    <!---Check for profanity in the text.--->
    <cfinvoke 
    component="MCMS.component.utility.Regex"
    method="regexProfanity"
    returnvariable="regexProfanityRet">
    <cfinvokeargument name="profanityString" value="#ARGUMENTS.rqDescription#"/>
    </cfinvoke>
    <!---Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.app.report.Report"
    method="getReportquery"
    returnvariable="getReportqueryRet">
    <cfinvokeargument name="rqName" value="#ARGUMENTS.rqName#"/>
    <cfinvokeargument name="rqStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getReportqueryRet.recordcount NEQ 0>
    <cfset result.message = "The name #ARGUMENTS.rqName# already exists, please enter a new name.">
    <cfelseif regexProfanityRet CONTAINS '$%&*!'>
    <cfset result.message = "Some text contained profanity, please remove any profanity from your text.">
    <!---Check length restriction.--->
    <cfelseif LEN(ARGUMENTS.rqDescription) GT 2048>
    <cfset result.message = "The description is longer than 2048 characters, please enter a new description under 2048 characters.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    INSERT INTO tbl_report_query (rqName,rqNameAlt,rqDescription,rqDSN,rqSQL,rqOptionName,rqOptionValue,rqtID,rqSort,rqStatus) VALUES
    (
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.rqName#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.rqNameAlt#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.rqDescription#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.rqDSN#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.rqSQL#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.rqOptionName#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.rqOptionValue#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.rqtID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.rqSort#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.rqStatus#">
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
    
    <cffunction name="insertReportUserRoleAccess" access="public" returntype="struct">
    <cfargument name="rurID" type="numeric" required="yes">
    <cfargument name="ruaID" type="numeric" required="yes">
    <cfargument name="rID" type="numeric" required="yes">
    <cfargument name="rcID" type="numeric" required="yes">
    <cfargument name="ruraStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully inserted the record.">
    <cftry>
    <!---Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.app.report.Report"
    method="getReportUserRoleAccess"
    returnvariable="getCheckReportUserRoleAccessRet">
    <cfinvokeargument name="rurID" value="#ARGUMENTS.rurID#"/>
    <cfinvokeargument name="rID" value="#ARGUMENTS.rID#"/>
    <cfinvokeargument name="rcID" value="#ARGUMENTS.rcID#"/>
    <cfinvokeargument name="ruraStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckReportUserRoleAccessRet.recordcount NEQ 0>
    <cfset result.message = "A record already exists for the Report User Role and Report/Custom Report you have selected, please try again.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    INSERT INTO tbl_report_user_role_access (rurID,ruaID,rID,rcID,ruraStatus) VALUES
    (
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.rurID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ruaID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.rID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.rcID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ruraStatus#">
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
    
    <cffunction name="insertReportSQLTemplateAttribute" access="public" returntype="struct">
    <cfargument name="rstaName" type="string" required="yes">
    <cfargument name="rstaNameAlt" type="string" required="yes">
    <cfargument name="rstaDescription" type="string" required="yes">
    <cfargument name="rstaDefaultValue" type="string" required="yes">
    <cfargument name="rstaListValue" type="string" required="yes">
    <cfargument name="rstatID" type="numeric" required="yes">
    <cfargument name="rstaSort" type="numeric" required="yes">
    <cfargument name="rstaStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully inserted the record.">
    <cftry>
    <!---Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.app.report.Report"
    method="getReportSQLTemplateAttribute"
    returnvariable="getCheckReportSQLTemplateAttributeRet">
    <cfinvokeargument name="rstaName" value="#ARGUMENTS.rstaName#"/>
    <cfinvokeargument name="rstaStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckReportSQLTemplateAttributeRet.recordcount NEQ 0>
    <cfset result.message = "The name #ARGUMENTS.rstaName# already exists, please enter a new name.">
    <!---Check length restriction.--->
    <cfelseif LEN(ARGUMENTS.rstaDescription) GT 2048>
    <cfset result.message = "The description is longer than 2048 characters, please enter a new description under 2048 characters.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    INSERT INTO tbl_rpt_sql_template_attribute (rstaName,rstaNameAlt,rstaDescription,rstaDefaultValue,rstaListValue,rstatID,rstaSort,rstaStatus) VALUES
    (
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.rstaName#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.rstaNameAlt#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.rstaDescription#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.rstaDefaultValue#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.rstaListValue#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.rstatID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.rstaSort#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.rstaStatus#">
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
    
    <cffunction name="insertReportSQLTemplateATRRel" access="public" returntype="struct">
    <cfargument name="rstID" type="numeric" required="yes">
    <cfargument name="rstaID" type="numeric" required="yes">
    <cfargument name="rstarStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully inserted the record.">
    <cftry>
    <!---Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.app.report.Report"
    method="getReportSQLTemplateAttributeRel"
    returnvariable="getCheckReportSQLTemplateAttributeRelRet">
    <cfinvokeargument name="rstID" value="#ARGUMENTS.rstID#"/>
    <cfinvokeargument name="rstaID" value="#ARGUMENTS.rstaID#"/>
    <cfinvokeargument name="rstarStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckReportSQLTemplateAttributeRelRet.recordcount NEQ 0>
    <cfset result.message = "The name template and attribute relationship already exists, please try again.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    INSERT INTO tbl_rpt_sql_template_atr_rel (rstID,rstaID,rstarStatus) VALUES
    (
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.rstID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.rstaID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.rstarStatus#">
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
    
    <cffunction name="insertReportSQLTemplate" access="public" returntype="struct">
    <cfargument name="rstName" type="string" required="yes">
    <cfargument name="rstShortDescription" type="string" required="yes">
    <cfargument name="rstDescription" type="string" required="yes">
    <cfargument name="rstFile" type="string" required="yes">
    <cfargument name="rstSort" type="numeric" required="yes">
    <cfargument name="rstStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully inserted the record.">
    <cftry>
    <!---Check for profanity in the text.--->
    <cfinvoke 
    component="MCMS.component.utility.Regex"
    method="regexProfanity"
    returnvariable="regexProfanityRet">
    <cfinvokeargument name="profanityString" value="#ARGUMENTS.rstDescription#"/>
    </cfinvoke>
    <!---Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.app.report.Report"
    method="getReportSQLTemplate"
    returnvariable="getReportSQLTemplateRet">
    <cfinvokeargument name="rstName" value="#ARGUMENTS.rstName#"/>
    <cfinvokeargument name="rstStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getReportSQLTemplateRet.recordcount NEQ 0>
    <cfset result.message = "The name #ARGUMENTS.rstName# already exists, please enter a new name.">
    <cfelseif regexProfanityRet CONTAINS '$%&*!'>
    <cfset result.message = "Some text contained profanity, please remove any profanity from your text.">
    <!---Check length restriction.--->
    <cfelseif LEN(ARGUMENTS.rstDescription) GT 2048>
    <cfset result.message = "The description is longer than 2048 characters, please enter a new description under 2048 characters.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    INSERT INTO tbl_report_sql_template (rstName,rstShortDescription,rstDescription,rstFile,rstSort,rstStatus) VALUES
    (
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.rstName#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.rstShortDescription#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.rstDescription#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.rstFile#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.rstSort#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.rstStatus#">
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
    
    <cffunction name="updateReport" access="public" returntype="struct">
    <cfargument name="ID" type="numeric" required="yes">
    <cfargument name="rName" type="string" required="yes">
    <cfargument name="rDescription" type="string" required="yes">
    <cfargument name="rStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully updated the record.">
    <cftry>
    <!---Check for profanity in the text.--->
    <cfinvoke 
    component="MCMS.component.utility.Regex"
    method="regexProfanity"
    returnvariable="regexProfanityRet">
    <cfinvokeargument name="profanityString" value="#ARGUMENTS.rDescription#"/>
    </cfinvoke>
    <!---Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.app.report.Report"
    method="getReport"
    returnvariable="getCheckReportRet">
    <cfinvokeargument name="excludeID" value="#ARGUMENTS.ID#"/>
    <cfinvokeargument name="rName" value="#ARGUMENTS.rName#"/>
    <cfinvokeargument name="rStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckReportRet.recordcount NEQ 0>
    <cfset result.message = "The name #ARGUMENTS.rName# already exists, please enter a new name.">
    <cfelseif regexProfanityRet CONTAINS '$%&*!'>
    <cfset result.message = "Some text contained profanity, please remove any profanity from your text.">
    <!---Check length restriction.--->
    <cfelseif LEN(ARGUMENTS.rDescription) GT 2048>
    <cfset result.message = "The description is longer than 2048 characters, please enter a new description under 2048 characters.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_report SET
    rName = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.rName#">,
    rDescription = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.rDescription#">,
    rStatus = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.rStatus#">
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
    
    <cffunction name="updateReportCustom" access="public" returntype="struct">
    <cfargument name="ID" type="numeric" required="yes">
    <cfargument name="rcName" type="string" required="yes">
    <cfargument name="rcDescription" type="string" required="yes">
    <cfargument name="rcPath" type="string" required="yes">
    <cfargument name="rcStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully updated the record.">
    <cftry>
    <!---Check for profanity in the text.--->
    <cfinvoke 
    component="MCMS.component.utility.Regex"
    method="regexProfanity"
    returnvariable="regexProfanityRet">
    <cfinvokeargument name="profanityString" value="#ARGUMENTS.rcDescription#"/>
    </cfinvoke>
    <!---Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.app.report.Report"
    method="getReportCustom"
    returnvariable="getCheckReportCustomRet">
    <cfinvokeargument name="excludeID" value="#ARGUMENTS.ID#"/>
    <cfinvokeargument name="rcName" value="#ARGUMENTS.rcName#"/>
    <cfinvokeargument name="rcStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckReportCustomRet.recordcount NEQ 0>
    <cfset result.message = "The name #ARGUMENTS.rcName# already exists, please enter a new name.">
    <cfelseif regexProfanityRet CONTAINS '$%&*!'>
    <cfset result.message = "Some text contained profanity, please remove any profanity from your text.">
    <!---Check length restriction.--->
    <cfelseif LEN(ARGUMENTS.rcDescription) GT 2048>
    <cfset result.message = "The description is longer than 2048 characters, please enter a new description under 2048 characters.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_report_custom SET
    rcName = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.rcName#">,
    rcDescription = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.rcDescription#">,
    rcPath = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.rcPath#">,
    rcStatus = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.rcStatus#">
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
    
    <cffunction name="updateReportMenuSQLTemplateRel" access="public" returntype="struct" hint="Used for Report Builder.">
    <cfargument name="ID" type="numeric" required="yes">
    <cfargument name="rID" type="numeric" required="yes">
    <cfargument name="rmID" type="numeric" required="yes">
    <cfargument name="rsID" type="numeric" required="yes">
    <cfargument name="rstID" type="numeric" required="yes">
    <cfargument name="rmtID" type="numeric" required="yes">
    <cfargument name="rmstrStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully updated the record.">
    <cftry>
    <!---Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.app.report.Report"
    method="getReportMenuSQLTemplateRel"
    returnvariable="getCheckReportMenuSQLTemplateRelRet">
    <cfinvokeargument name="excludeID" value="#ARGUMENTS.ID#"/>
    <cfinvokeargument name="rID" value="#ARGUMENTS.rID#"/>
    <cfinvokeargument name="rmID" value="#ARGUMENTS.rmID#"/>
    <cfinvokeargument name="rsID" value="#ARGUMENTS.rsID#"/>
    <cfinvokeargument name="rstID" value="#ARGUMENTS.rstID#"/>
    <cfinvokeargument name="rmtID" value="#ARGUMENTS.rmtID#"/>
    <cfinvokeargument name="rmstrStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckReportMenuSQLTemplateRelRet.recordcount NEQ 0>
    <cfset result.message = "The report you have built already exists, please try again.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_rpt_menu_sql_template_rel SET
    rID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.rID#">,
    rmID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.rmID#">,
    rsID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.rsID#">,
    rstID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.rstID#">,
    rmtID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.rmtID#">,
    rmstrStatus = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.rmstrStatus#">
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
    
    <cffunction name="updateReportMenu" access="public" returntype="struct">
    <cfargument name="ID" type="numeric" required="yes">
    <cfargument name="rmName" type="string" required="yes">
    <cfargument name="rmDescription" type="string" required="yes">
    <cfargument name="rID" type="numeric" required="yes">
    <cfargument name="rtID" type="numeric" required="yes">
    <cfargument name="rmSort" type="numeric" required="yes">
    <cfargument name="rmStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully updated the record.">
    <cftry>
    <!---Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.app.report.Report"
    method="getReportMenu"
    returnvariable="getCheckReportMenuRet">
    <cfinvokeargument name="excludeID" value="#ARGUMENTS.ID#"/>
    <cfinvokeargument name="rID" value="#ARGUMENTS.rID#"/>
    <cfinvokeargument name="rmName" value="#ARGUMENTS.rmName#"/>
    <cfinvokeargument name="rmStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckReportMenuRet.recordcount NEQ 0>
    <cfset result.message = "The name #ARGUMENTS.rmName# already exists for this report, please enter a new name.">
    <!---Check length restriction.--->
    <cfelseif LEN(ARGUMENTS.rmDescription) GT 2048>
    <cfset result.message = "The description is longer than 2048 characters, please enter a new description under 2048 characters.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_report_menu SET
    rmName = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.rmName#">,
    rmDescription = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.rmDescription#">,
    rID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.rID#">,
    rtID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.rtID#">,
    rmSort = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.rmSort#">,
    rmStatus = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.rmStatus#">
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
    
    <cffunction name="updateReportMenuDetail" access="public" returntype="struct">
    <cfargument name="ID" type="numeric" required="yes">
    <cfargument name="rmdName" type="string" required="yes">
    <cfargument name="rmdNameAlt" type="string" required="yes">
    <cfargument name="rmdDescription" type="string" required="yes">
    <cfargument name="rID" type="numeric" required="yes">
    <cfargument name="rmID" type="numeric" required="yes">
    <cfargument name="rmstrID" type="numeric" required="yes">
    <cfargument name="rmdSort" type="numeric" required="yes">
    <cfargument name="rmdStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully updated the record.">
    <cftry>
    <!---Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.app.report.Report"
    method="getReportMenuDetail"
    returnvariable="getCheckReportMenuDetailRet">
    <cfinvokeargument name="excludeID" value="#ARGUMENTS.ID#"/>
    <cfinvokeargument name="rID" value="#ARGUMENTS.rID#"/>
    <cfinvokeargument name="rmID" value="#ARGUMENTS.rmID#"/>
    <cfinvokeargument name="rmstrID" value="#ARGUMENTS.rmstrID#"/>
    <cfinvokeargument name="rmdName" value="#ARGUMENTS.rmdName#"/>
    <cfinvokeargument name="rmdStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckReportMenuDetailRet.recordcount NEQ 0>
    <cfset result.message = "The menu detail already exists for this report, please try again.">
    <!---Check length restriction.--->
    <cfelseif LEN(ARGUMENTS.rmdDescription) GT 2048>
    <cfset result.message = "The description is longer than 2048 characters, please enter a new description under 2048 characters.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_report_menu_detail SET
    rmdName = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.rmdName#">,
    rmdNameAlt = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.rmdNameAlt#">,
    rmdDescription = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.rmdDescription#">,
    rmdSort = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.rmdSort#">,
    rmdStatus = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.rmdStatus#">
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
    
    <cffunction name="updateReportSQL" access="public" returntype="struct">
    <cfargument name="ID" type="numeric" required="yes">
    <cfargument name="rsName" type="string" required="yes">
    <cfargument name="rsShortDescription" type="string" required="yes">
    <cfargument name="rsDescription" type="string" required="yes">
    <cfargument name="rsDSN" type="string" required="yes">
    <cfargument name="rsSQL" type="string" required="yes">
    <cfargument name="rsColumnList" type="string" required="yes">
    <cfargument name="rsSort" type="numeric" required="yes">
    <cfargument name="rsStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully updated the record.">
    <cftry>
    <!---Check for profanity in the text.--->
    <cfinvoke 
    component="MCMS.component.utility.Regex"
    method="regexProfanity"
    returnvariable="regexProfanityRet">
    <cfinvokeargument name="profanityString" value="#ARGUMENTS.rsDescription#"/>
    </cfinvoke>
    <!---Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.app.report.Report"
    method="getReportSQL"
    returnvariable="getCheckReportSQLRet">
    <cfinvokeargument name="excludeID" value="#ARGUMENTS.ID#"/>
    <cfinvokeargument name="rsName" value="#ARGUMENTS.rsName#"/>
    <cfinvokeargument name="rsStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckReportSQLRet.recordcount NEQ 0>
    <cfset result.message = "The name #ARGUMENTS.rsName# already exists, please enter a new name.">
    <cfelseif regexProfanityRet CONTAINS '$%&*!'>
    <cfset result.message = "Some text contained profanity, please remove any profanity from your text.">
    <!---Check length restriction.--->
    <cfelseif LEN(ARGUMENTS.rsDescription) GT 2048>
    <cfset result.message = "The description is longer than 2048 characters, please enter a new description under 2048 characters.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_report_sql SET
    rsName = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.rsName#">,
    rsShortDescription = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.rsShortDescription#">,
    rsDescription = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.rsDescription#">,
    rsDSN = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.rsDSN#">,
    rsSQL = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.rsSQL#">,
    rsColumnList = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.rsColumnList#">,
    rsSort = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.rsSort#">,
    rsStatus = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.rsStatus#">
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
    
    <cffunction name="updateReportSQLTemplateSetting" access="public" returntype="struct" hint="This updates the SQL Template Setting value when a report is built.">
    <cfargument name="ID" type="numeric" required="yes">
    <cfargument name="rsTemplateSetting" type="string" required="yes">
    <cfset result.message = "You have successfully updated the record.">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_report_sql SET
    rsTemplateSetting = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.rsTemplateSetting#">
    WHERE ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ID#">
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error updating the record.">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
			
    <cffunction name="updateReportTemplate" access="public" returntype="struct">
    <cfargument name="ID" type="numeric" required="yes">
    <cfargument name="rtName" type="string" required="yes">
    <cfargument name="rtDescription" type="string" required="yes">
    <cfargument name="rtFile" type="string" required="yes">
    <cfargument name="rtSort" type="numeric" required="yes">
    <cfargument name="rtStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully updated the record.">
    <cftry>
    <!---Check for profanity in the text.--->
    <cfinvoke 
    component="MCMS.component.utility.Regex"
    method="regexProfanity"
    returnvariable="regexProfanityRet">
    <cfinvokeargument name="profanityString" value="#ARGUMENTS.rtDescription#"/>
    </cfinvoke>
    <!---Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.app.report.Report"
    method="getReportTemplate"
    returnvariable="getCheckReportTemplateRet">
    <cfinvokeargument name="excludeID" value="#ARGUMENTS.ID#"/>
    <cfinvokeargument name="rtName" value="#ARGUMENTS.rtName#"/>
    <cfinvokeargument name="rtStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckReportTemplateRet.recordcount NEQ 0>
    <cfset result.message = "The name #ARGUMENTS.tempName# already exists, please enter a new name.">
    <cfelseif regexProfanityRet CONTAINS '$%&*!'>
    <cfset result.message = "Some text contained profanity, please remove any profanity from your text.">
    <!---Check length restriction.--->
    <cfelseif LEN(ARGUMENTS.rtDescription) GT 2048>
    <cfset result.message = "The description is longer than 2048 characters, please enter a new description under 2048 characters.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_report_template SET
    rtName = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.rtName#">,
    rtDescription = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.rtDescription#">,
    rtFile = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.rtFile#">,
    rtSort = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.rtSort#">,
    rtStatus = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.rtStatus#">
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
    
    <cffunction name="updateReportQuery" access="public" returntype="struct">
    <cfargument name="ID" type="numeric" required="yes">
    <cfargument name="rqName" type="string" required="yes">
    <cfargument name="rqNameAlt" type="string" required="yes">
    <cfargument name="rqDescription" type="string" required="yes">
    <cfargument name="rqDSN" type="string" required="yes">
    <cfargument name="rqSQL" type="string" required="yes">
    <cfargument name="rqOptionName" type="string" required="yes">
    <cfargument name="rqOptionValue" type="string" required="yes">
    <cfargument name="rqtID" type="numeric" required="yes">
    <cfargument name="rqSort" type="numeric" required="yes">
    <cfargument name="rqStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully updated the record.">
    <cftry>
    <!---Check for profanity in the text.--->
    <cfinvoke 
    component="MCMS.component.utility.Regex"
    method="regexProfanity"
    returnvariable="regexProfanityRet">
    <cfinvokeargument name="profanityString" value="#ARGUMENTS.rqDescription#"/>
    </cfinvoke>
    <!---Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.app.report.Report"
    method="getReportQuery"
    returnvariable="getReportQueryRet">
    <cfinvokeargument name="excludeID" value="#ARGUMENTS.ID#"/>
    <cfinvokeargument name="rqName" value="#ARGUMENTS.rqName#"/>
    <cfinvokeargument name="rqStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getReportQueryRet.recordcount NEQ 0>
    <cfset result.message = "The name #ARGUMENTS.rqName# already exists, please enter a new name.">
    <cfelseif regexProfanityRet CONTAINS '$%&*!'>
    <cfset result.message = "Some text contained profanity, please remove any profanity from your text.">
    <!---Check length restriction.--->
    <cfelseif LEN(ARGUMENTS.rqDescription) GT 2048>
    <cfset result.message = "The description is longer than 2048 characters, please enter a new description under 2048 characters.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_report_query SET
    rqName = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.rqName#">,
    rqNameAlt = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.rqNameAlt#">,
    rqDescription = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.rqDescription#">,
    rqDSN = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.rqDSN#">,
    rqSQL = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.rqSQL#">,
    rqOptionName = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.rqOptionName#">,
    rqOptionValue = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.rqOptionValue#">,
    rqtID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.rqtID#">,
    rqSort = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.rqSort#">,
    rqStatus = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.rqStatus#">
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
    
    <cffunction name="updateReportUserRoleAccess" access="public" returntype="struct">
    <cfargument name="ID" type="numeric" required="yes">
    <cfargument name="rurID" type="numeric" required="yes">
    <cfargument name="ruaID" type="numeric" required="yes">
    <cfargument name="rID" type="numeric" required="yes">
    <cfargument name="ruraStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully updated the record.">
	<cftry>   
    <!---Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.app.report.Report"
    method="getReportUserRoleAccess"
    returnvariable="getCheckReportUserRoleAccessRet">
    <cfinvokeargument name="excludeID" value="#ARGUMENTS.ID#"/>
    <cfinvokeargument name="rurID" value="#ARGUMENTS.rurID#"/>
    <cfinvokeargument name="rID" value="#ARGUMENTS.rID#"/>
    <cfinvokeargument name="rcID" value="#ARGUMENTS.rcID#"/>
    <cfinvokeargument name="ruraStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckReportUserRoleAccessRet.recordcount NEQ 0>
    <cfset result.message = "A record already exists for the Report User Role and Report/Custom Report you have selected, please try again.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_report_user_role_access SET
    rurID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.rurID#">,
    ruaID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ruaID#">,
    rID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.rID#">,
    rcID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.rcID#">,
    ruraStatus = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ruraStatus#">
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
    
    <cffunction name="updateReportSQLTemplateAttribute" access="public" returntype="struct">
    <cfargument name="ID" type="numeric" required="yes">
    <cfargument name="rstaName" type="string" required="yes">
    <cfargument name="rstaNameAlt" type="string" required="yes">
    <cfargument name="rstaDescription" type="string" required="yes">
    <cfargument name="rstaDefaultValue" type="string" required="yes">
    <cfargument name="rstaListValue" type="string" required="yes">
    <cfargument name="rstatID" type="numeric" required="yes">
    <cfargument name="rstaSort" type="numeric" required="yes">
    <cfargument name="rstaStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully updated the record.">
    <cftry>
    <!---Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.app.report.Report"
    method="getReportSQLTemplateAttribute"
    returnvariable="getCheckReportSQLTemplateAttributeRet">
    <cfinvokeargument name="excludeID" value="#ARGUMENTS.ID#"/>
    <cfinvokeargument name="rstaName" value="#ARGUMENTS.rstaName#"/>
    <cfinvokeargument name="rstaStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckReportSQLTemplateAttributeRet.recordcount NEQ 0>
    <cfset result.message = "The name #ARGUMENTS.rsName# already exists, please enter a new name.">
    <!---Check length restriction.--->
    <cfelseif LEN(ARGUMENTS.rstaDescription) GT 2048>
    <cfset result.message = "The description is longer than 2048 characters, please enter a new description under 2048 characters.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_rpt_sql_template_attribute SET
    rstaName = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.rstaName#">,
    rstaNameAlt = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.rstaNameAlt#">,
    rstaDescription = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.rstaDescription#">,
    rstaDefaultValue = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.rstaDefaultValue#">,
    rstaListValue = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.rstaListValue#">,
    rstatID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.rstatID#">,
    rstaSort = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.rstaSort#">,
    rstaStatus = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.rstaStatus#">
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
    
    <cffunction name="updateReportSQLTemplateAttributeRel" access="public" returntype="struct">
    <cfargument name="ID" type="numeric" required="yes">
    <cfargument name="rstID" type="numeric" required="yes">
    <cfargument name="rstaID" type="numeric" required="yes">
    <cfargument name="rstarStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully updated the record.">
    <cftry>
    <!---Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.app.report.Report"
    method="getReportSQLTemplateAttributeRel"
    returnvariable="getCheckReportSQLTemplateAttributeRelRet">
    <cfinvokeargument name="excludeID" value="#ARGUMENTS.ID#"/>
    <cfinvokeargument name="rstID" value="#ARGUMENTS.rstID#"/>
    <cfinvokeargument name="rstaID" value="#ARGUMENTS.rstaID#"/>
    <cfinvokeargument name="rstarStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckReportSQLTemplateAttributeRelRet.recordcount NEQ 0>
    <cfset result.message = "The name template and attribute relationship already exists, please try again.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_rpt_sql_template_atr_rel SET
    rstID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.rstID#">,
    rstaID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.rstaID#">,
    rstarStatus = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.rstarStatus#">
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
    
    <cffunction name="updateReportSQLTemplate" access="public" returntype="struct">
    <cfargument name="ID" type="numeric" required="yes">
    <cfargument name="rstName" type="string" required="yes">
    <cfargument name="rstShortDescription" type="string" required="yes">
    <cfargument name="rstDescription" type="string" required="yes">
    <cfargument name="rstFile" type="string" required="yes">
    <cfargument name="rstSort" type="numeric" required="yes">
    <cfargument name="rstStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully updated the record.">
    <cftry>
    <!---Check for profanity in the text.--->
    <cfinvoke 
    component="MCMS.component.utility.Regex"
    method="regexProfanity"
    returnvariable="regexProfanityRet">
    <cfinvokeargument name="profanityString" value="#ARGUMENTS.rstDescription#"/>
    </cfinvoke>
    <!---Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.app.report.Report"
    method="getReportSQLTemplate"
    returnvariable="getCheckReportSQLTemplateRet">
    <cfinvokeargument name="excludeID" value="#ARGUMENTS.ID#"/>
    <cfinvokeargument name="rstName" value="#ARGUMENTS.rstName#"/>
    <cfinvokeargument name="rstStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckReportSQLTemplateRet.recordcount NEQ 0>
    <cfset result.message = "The name #ARGUMENTS.rstName# already exists, please enter a new name.">
    <cfelseif regexProfanityRet CONTAINS '$%&*!'>
    <cfset result.message = "Some text contained profanity, please remove any profanity from your text.">
    <!---Check length restriction.--->
    <cfelseif LEN(ARGUMENTS.rstDescription) GT 2048>
    <cfset result.message = "The description is longer than 2048 characters, please enter a new description under 2048 characters.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_report_sql_template SET
    rstName = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.rstName#">,
    rstShortDescription = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.rstShortDescription#">,
    rstDescription = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.rstDescription#">,
    rstFile = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.rstFile#">,
    rstSort = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.rstSort#">,
    rstStatus = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.rstStatus#">
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
    
    <cffunction name="updateReportList" access="public" returntype="struct">
    <cfargument name="ID" type="numeric" required="yes">
    <cfargument name="rStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully updated the records.">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_report SET
    rStatus = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.rStatus#">
    WHERE ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ID#">
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error updating the records.">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="updateReportCustomList" access="public" returntype="struct">
    <cfargument name="ID" type="numeric" required="yes">
    <cfargument name="rcStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully updated the records.">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_report_custom SET
    rcStatus = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.rcStatus#">
    WHERE ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ID#">
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error updating the records.">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="updateReportMenuSQLTemplateRelList" access="public" returntype="struct">
    <cfargument name="ID" type="numeric" required="yes">
    <cfargument name="rmstrStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully updated the records.">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_rpt_menu_sql_template_rel SET
    rmstrStatus = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.rmstrStatus#">
    WHERE ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ID#">
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error updating the records.">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="updateReportMenuList" access="public" returntype="struct">
    <cfargument name="ID" type="numeric" required="yes">
    <cfargument name="rmStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully updated the records.">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_report_menu SET
    rmStatus = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.rmStatus#">
    WHERE ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ID#">
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error updating the records.">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="updateReportMenuDetailList" access="public" returntype="struct">
    <cfargument name="ID" type="numeric" required="yes">
    <cfargument name="rmdStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully updated the records.">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_report_menu_detail SET
    rmdStatus = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.rmdStatus#">
    WHERE ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ID#">
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error updating the records.">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="updateReportSQLList" access="public" returntype="struct">
    <cfargument name="ID" type="numeric" required="yes">
    <cfargument name="rsStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully updated the records.">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_report_sql SET
    rsStatus = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.rsStatus#">
    WHERE ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ID#">
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error updating the records.">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>  
		
	<cffunction name="updateReportTemplateList" access="public" returntype="struct">
    <cfargument name="ID" type="numeric" required="yes">
    <cfargument name="rtStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully updated the records.">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_report_template SET
    rtStatus = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.rtStatus#">
    WHERE ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ID#">
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error updating the records.">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>  
    
    <cffunction name="updateReportQueryList" access="public" returntype="struct">
    <cfargument name="ID" type="numeric" required="yes">
    <cfargument name="rqStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully updated the records.">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_report_query SET
    rqStatus = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.rqStatus#">
    WHERE ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ID#">
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error updating the records.">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="updateReportUserRoleAccessList" access="public" returntype="struct">
    <cfargument name="ID" type="numeric" required="yes">
    <cfargument name="ruraStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully updated the records.">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_report_user_role_access SET
    ruraStatus = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ruraStatus#">
    WHERE ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ID#">
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error updating the records.">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction> 
    
    <cffunction name="updateReportSQLTemplateAttributeList" access="public" returntype="struct">
    <cfargument name="ID" type="numeric" required="yes">
    <cfargument name="rstaStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully updated the records.">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_rpt_sql_template_attribute SET
    rstaStatus = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.rstaStatus#">
    WHERE ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ID#">
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error updating the records.">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="updateReportSQLTemplateAttributeRelList" access="public" returntype="struct">
    <cfargument name="ID" type="numeric" required="yes">
    <cfargument name="rstarStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully updated the records.">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_rpt_sql_template_attribute_rel SET
    rstarStatus = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.rstarStatus#">
    WHERE ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ID#">
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error updating the records.">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction> 
    
    <cffunction name="updateReportSQLTemplateList" access="public" returntype="struct">
    <cfargument name="ID" type="numeric" required="yes">
    <cfargument name="rstStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully updated the records.">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_report_sql_template SET
    rstStatus = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.rstStatus#">
    WHERE ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ID#">
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error updating the records.">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="deleteReport" access="public" returntype="struct">
    <cfargument name="ID" type="string" required="yes">
    <cfset result.message = "You have successfully deleted the record(s).">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    DELETE FROM tbl_report
    WHERE ID IN (<cfqueryparam cfsqltype="cf_sql_integer" list="yes" value="#ARGUMENTS.ID#">)
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error deleting the record(s).">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="deleteReportCustom" access="public" returntype="struct">
    <cfargument name="ID" type="string" required="yes">
    <cfset result.message = "You have successfully deleted the record(s).">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    DELETE FROM tbl_report_custom
    WHERE ID IN (<cfqueryparam cfsqltype="cf_sql_integer" list="yes" value="#ARGUMENTS.ID#">)
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error deleting the record(s).">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="deleteReportMenuSQLTemplateRel" access="public" returntype="struct">
    <cfargument name="ID" type="string" required="yes">
    <cfset result.message = "You have successfully deleted the record(s).">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    DELETE FROM tbl_rpt_menu_sql_template_rel
    WHERE ID IN (<cfqueryparam cfsqltype="cf_sql_integer" list="yes" value="#ARGUMENTS.ID#">)
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error deleting the record(s).">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction> 
    
    <cffunction name="deleteReportMenu" access="public" returntype="struct">
    <cfargument name="ID" type="string" required="yes">
    <cfset result.message = "You have successfully deleted the record(s).">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    DELETE FROM tbl_report_menu
    WHERE ID IN (<cfqueryparam cfsqltype="cf_sql_integer" list="yes" value="#ARGUMENTS.ID#">)
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error deleting the record(s).">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="deleteReportMenuDetail" access="public" returntype="struct">
    <cfargument name="ID" type="string" required="yes">
    <cfset result.message = "You have successfully deleted the record(s).">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    DELETE FROM tbl_report_menu_detail
    WHERE ID IN (<cfqueryparam cfsqltype="cf_sql_integer" list="yes" value="#ARGUMENTS.ID#">)
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error deleting the record(s).">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="deleteReportSQL" access="public" returntype="struct">
    <cfargument name="ID" type="string" required="yes">
    <cfset result.message = "You have successfully deleted the record(s).">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    DELETE FROM tbl_report_sql
    WHERE ID IN (<cfqueryparam cfsqltype="cf_sql_integer" list="yes" value="#ARGUMENTS.ID#">)
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error deleting the record(s).">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
		
	<cffunction name="deleteReportTemplate" access="public" returntype="struct">
    <cfargument name="ID" type="string" required="yes">
    <cfset result.message = "You have successfully deleted the record(s).">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    DELETE FROM tbl_report_template
    WHERE ID IN (<cfqueryparam cfsqltype="cf_sql_integer" list="yes" value="#ARGUMENTS.ID#">)
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error deleting the record(s).">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction> 
    
    <cffunction name="deleteReportQuery" access="public" returntype="struct">
    <cfargument name="ID" type="string" required="yes">
    <cfset result.message = "You have successfully deleted the record(s).">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    DELETE FROM tbl_report_query
    WHERE ID IN (<cfqueryparam cfsqltype="cf_sql_integer" list="yes" value="#ARGUMENTS.ID#">)
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error deleting the record(s).">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="deleteReportUserRoleAccess" access="public" returntype="struct">
    <cfargument name="ID" type="string" required="yes">
    <cfset result.message = "You have successfully deleted the record(s).">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    DELETE FROM tbl_report_user_role_access
    WHERE ID IN (<cfqueryparam cfsqltype="cf_sql_integer" list="yes" value="#ARGUMENTS.ID#">)
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error deleting the record(s).">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction> 
    
    <cffunction name="deleteReportSQLTemplateAttribute" access="public" returntype="struct">
    <cfargument name="ID" type="string" required="yes">
    <cfset result.message = "You have successfully deleted the record(s).">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    DELETE FROM tbl_rpt_sql_template_attribute
    WHERE ID IN (<cfqueryparam cfsqltype="cf_sql_integer" list="yes" value="#ARGUMENTS.ID#">)
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error deleting the record(s).">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction> 
    
    <cffunction name="deleteReportSQLTemplateAttributeRel" access="public" returntype="struct">
    <cfargument name="ID" type="string" required="yes">
    <cfset result.message = "You have successfully deleted the record(s).">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    DELETE FROM tbl_rpt_sql_template_attribute_rel
    WHERE ID IN (<cfqueryparam cfsqltype="cf_sql_integer" list="yes" value="#ARGUMENTS.ID#">)
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error deleting the record(s).">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="deleteReportSQLTemplate" access="public" returntype="struct">
    <cfargument name="ID" type="string" required="yes">
    <cfset result.message = "You have successfully deleted the record(s).">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    DELETE FROM tbl_report_sql_template
    WHERE ID IN (<cfqueryparam cfsqltype="cf_sql_integer" list="yes" value="#ARGUMENTS.ID#">)
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error deleting the record(s).">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="getReportCaching" access="public" returntype="struct" hint="Cache queries.">
    <cfargument name="component" type="string" required="yes" default="" hint="Path to component.">
    <cfargument name="method" type="string" required="yes" default="" hint="List of query methods to cache.">
    <cfargument name="args" type="string" required="yes" default="" hint="List of possible arguments like siteNo or deptNo.">
    <cfset result = StructNew()>
	<cfset result.message = "You have successfully cached your queries." >
    <cftry>
    <!---Wrap in thread.--->
    <cfthread action="run" name="reportCache" component="#ARGUMENTS.component#" method="#ARGUMENTS.method#" args="#ARGUMENTS.args#">
    <cfset var.component = component>
    <cfset var.method = method>
    <cfset var.args = args>
	<cfif var.args CONTAINS 'siteNo'>
    <cfinvoke 
    component="MCMS.component.app.site.Site"
    method="getSite"
    returnvariable="getSiteRet">
    <cfinvokeargument name="siteStatus" value="1,3">
    </cfinvoke>
    </cfif>
    <cfobject name="thisObj" component="#var.component#">
    <cfloop index="i" list="#var.method#">
    <cfif var.args CONTAINS 'siteNo'>
    <cfloop index="siteNo" list="#ValueList(getSiteRet.siteNo)#">
    <cfset this.cache = Evaluate('thisObj.#i#(#siteNo#,0,0)')>
    </cfloop>
    <cfelse>
    <cfset this.cache = Evaluate('thisObj.#i#(0,0)')>
    </cfif>
    </cfloop>
    </cfthread>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset result.message = "There was an error with the scheduled task arguments.">
    <div id="required">NOTE! An error has occurred.</div>
    <cfmail to="#application.webmasterEmail#" from="#application.webmasterEmail#" subject="Report Caching Has Failed" type="html">
    <link href="//#CGI.SERVER_NAME#/css/styles.css" rel="stylesheet" type="text/css" />
    <table id="mainTableAlt">
    <tr>
    <td align="center" id="message"><br>
    <span class="glyphicon glyphicon-exclamation-sign"></span><br>
    Your Request Has Generated An Error!</td>
    </tr>
    <tr>
    <td>
    <table id="tableMain">
    <tr>
    <td>Submitted by Host Machine: #CGI.HTTP_HOST#</td>
    </tr>
    <tr>
    <td>Submitted by Referrer: #CGI.HTTP_REFERER#</td>
    </tr>
    <tr>
    <td>Template:#CGI.SCRIPT_NAME#?#CGI.QUERY_STRING#</td>
    </tr>
    <tr>
    <td id="titlesmall">Diagostics Below</td>
    </tr>
    <tr>
    <td>
    Cause: #cfcatch.MESSAGE#
    </td>
    </tr>
    <tr>
    <td>
    Detail: #cfcatch.DETAIL#<br>
    Line: #cfcatch.TagContext[1].LINE#<br>
    Template: #cfcatch.TagContext[1].TEMPLATE#<br>
    </td>
    </tr>
    <tr>
    <td>
    Line: #cfcatch.TagContext[2].LINE#<br>
    Template: #cfcatch.TagContext[2].TEMPLATE#<br>
    </td>
    </tr>
    </table>
    </td>
    </tr>
    <tr>
    <td>&copy; <cfoutput>#DateFormat(Now(), 'yyyy')# #application.companyName#</cfoutput> - All rights reserved.</td>
    </tr>
    </table>
    </cfmail>
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
</cfcomponent>