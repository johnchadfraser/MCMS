<cfcomponent>
    <cffunction name="getProductWorkflow" access="public" returntype="query" hint="Get Product Workflow data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="ID" type="string" required="yes" default="0">
    <cfargument name="excludeID" type="string" required="yes" default="0">
    <cfargument name="pwfName" type="string" required="yes" default="">
    <cfargument name="pwfStatus" type="string" required="yes" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="pwfSort">
    <cfset var rsProductWorkflow = "" >
    <cftry>
    <cfquery name="rsProductWorkflow" datasource="#application.mcmsDSN#" cachedWithin="#request.queryCache#">
    SELECT * FROM v_product_workflow WHERE 0=0
    <cfif ARGUMENTS.ID NEQ 0>
    AND ID IN (<cfqueryparam value="#ARGUMENTS.ID#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    <cfif ARGUMENTS.excludeID NEQ 0>
    AND ID NOT IN (<cfqueryparam value="#ARGUMENTS.excludeID#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(pwfName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(pwfDescription) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">)
    </cfif>
    <cfif ARGUMENTS.pwfName NEQ "">
    AND UPPER(pwfName) = <cfqueryparam value="#UCASE(ARGUMENTS.pwfName)#" cfsqltype="cf_sql_varchar">
    </cfif>
    AND pwfStatus IN (<cfqueryparam value="#ARGUMENTS.pwfStatus#" list="yes" cfsqltype="cf_sql_integer">)
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsProductWorkflow = StructNew()>
    <cfset rsProductWorkflow.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsProductWorkflow>
    </cffunction>
    
    <cffunction name="getProductWorkflowUserRoleRel" access="public" returntype="query" hint="Get Product Workflow User Role Relationship data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="ID" type="numeric" required="yes" default="0">
    <cfargument name="excludeID" type="numeric" required="yes" default="0">
    <cfargument name="pwfName" type="string" required="yes" default="">
    <cfargument name="urName" type="string" required="yes" default="">
    <cfargument name="pwfaName" type="string" required="yes" default="">
    <cfargument name="pwfID" type="string" required="yes" default="0">
    <cfargument name="urID" type="numeric" required="yes" default="0">
    <cfargument name="pwfaID" type="numeric" required="yes" default="0">
    <cfargument name="pwfaStatus" type="string" required="yes" default="1,3">
    <cfargument name="urStatus" type="string" required="yes" default="1,3">
    <cfargument name="pwfStatus" type="string" required="yes" default="1,3">
    <cfargument name="pwfurrStatus" type="string" required="yes" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="pwfSort">
    <cfset var rsProductWorkflowUserRoleRel = "" >
    <cftry>
    <cfquery name="rsProductWorkflowUserRoleRel" datasource="#application.mcmsDSN#" cachedWithin="#request.queryCache#">
    SELECT * FROM v_product_wf_user_role_rel WHERE 0=0
    <cfif ARGUMENTS.ID NEQ 0>
    AND ID = <cfqueryparam value="#ARGUMENTS.ID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.excludeID NEQ 0>
    AND ID <> <cfqueryparam value="#ARGUMENTS.excludeID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(pwfName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(urName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(pwfaName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">)
    </cfif>
    <cfif ARGUMENTS.pwfID NEQ 0>
    AND pwfID IN (<cfqueryparam value="#ARGUMENTS.pwfID#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    <cfif ARGUMENTS.urID NEQ 0>
    AND urID = <cfqueryparam value="#ARGUMENTS.urID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.pwfaID NEQ 0>
    AND pwfaID = <cfqueryparam value="#ARGUMENTS.pwfaID#" cfsqltype="cf_sql_integer">
    </cfif>
    AND pwfaStatus IN (<cfqueryparam value="#ARGUMENTS.pwfaStatus#" list="yes" cfsqltype="cf_sql_integer">)
    AND urStatus IN (<cfqueryparam value="#ARGUMENTS.urStatus#" list="yes" cfsqltype="cf_sql_integer">)
    AND pwfStatus IN (<cfqueryparam value="#ARGUMENTS.pwfStatus#" list="yes" cfsqltype="cf_sql_integer">)
    AND pwfurrStatus IN (<cfqueryparam value="#ARGUMENTS.pwfurrStatus#" list="yes" cfsqltype="cf_sql_integer">)
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsProductWorkflowUserRoleRel = StructNew()>
    <cfset rsProductWorkflowUserRoleRel.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsProductWorkflowUserRoleRel>
    </cffunction>
    
    <cffunction name="getDistinctProductWorkflowUserRoleRel" access="public" returntype="query" hint="Get Product Workflow User Role Relationship data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="ID" type="numeric" required="yes" default="0">
    <cfargument name="excludeID" type="numeric" required="yes" default="0">
    <cfargument name="urID" type="numeric" required="yes" default="0">
    <cfargument name="pwfurrStatus" type="string" required="yes" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="urID">
    <cfset var rsDistinctProductWorkflowUserRoleRel = "" >
    <cftry>
    <cfquery name="rsDistinctProductWorkflowUserRoleRel" datasource="#application.mcmsDSN#">
    SELECT DISTINCT urID FROM tbl_product_wf_user_role_rel WHERE 0=0
    <cfif ARGUMENTS.ID NEQ 0>
    AND ID = <cfqueryparam value="#ARGUMENTS.ID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.excludeID NEQ 0>
    AND ID <> <cfqueryparam value="#ARGUMENTS.excludeID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.urID NEQ 0>
    AND urID = <cfqueryparam value="#ARGUMENTS.urID#" cfsqltype="cf_sql_integer">
    </cfif>
    AND pwfurrStatus IN (<cfqueryparam value="#ARGUMENTS.pwfurrStatus#" list="yes" cfsqltype="cf_sql_integer">)
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsDistinctProductWorkflowUserRoleRel = StructNew()>
    <cfset rsDistinctProductWorkflowUserRoleRel.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsDistinctProductWorkflowUserRoleRel>
    </cffunction>
    
    <cffunction name="getProductWorkflowAccess" access="public" returntype="query" hint="Get Product Workflow Access data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="ID" type="numeric" required="yes" default="0">
    <cfargument name="excludeID" type="numeric" required="yes" default="0">
    <cfargument name="pwfaName" type="string" required="yes" default="">
    <cfargument name="pwfaStatus" type="string" required="yes" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="pwfaName">
    <cfset var rsProductWorkflowAccess = "" >
    <cftry>
    <cfquery name="rsProductWorkflowAccess" datasource="#application.mcmsDSN#" cachedWithin="#request.queryCache#">
    SELECT * FROM v_product_wf_access WHERE 0=0
    <cfif ARGUMENTS.ID NEQ 0>
    AND ID = <cfqueryparam value="#ARGUMENTS.ID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.excludeID NEQ 0>
    AND ID <> <cfqueryparam value="#ARGUMENTS.excludeID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(pwfaName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(pwfaDescription) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">)
    </cfif>
    <cfif ARGUMENTS.pwfaName NEQ "">
    AND UPPER(pwfaName) = <cfqueryparam value="#UCASE(ARGUMENTS.pwfaName)#" cfsqltype="cf_sql_varchar">
    </cfif>
    AND pwfaStatus IN (<cfqueryparam value="#ARGUMENTS.pwfaStatus#" list="yes" cfsqltype="cf_sql_integer">)
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsProductWorkflowAccess = StructNew()>
    <cfset rsProductWorkflowAccess.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsProductWorkflowAccess>
    </cffunction>
    
    <cffunction name="getProductWorkflowStatus" access="public" returntype="query" hint="Get Product Workflow Status data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="ID" type="numeric" required="yes" default="0">
    <cfargument name="excludeID" type="numeric" required="yes" default="0">
    <cfargument name="pwfsName" type="string" required="yes" default="">
    <cfargument name="pwfsStatus" type="string" required="yes" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="pwfsName">
    <cfset var rsProductWorkflowStatus = "" >
    <cftry>
    <cfquery name="rsProductWorkflowStatus" datasource="#application.mcmsDSN#" cachedWithin="#request.queryCache#">
    SELECT * FROM v_product_wf_status WHERE 0=0
    <cfif ARGUMENTS.ID NEQ 0>
    AND ID = <cfqueryparam value="#ARGUMENTS.ID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.excludeID NEQ 0>
    AND ID <> <cfqueryparam value="#ARGUMENTS.excludeID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(pwfsName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(pwfsDescription) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">)
    </cfif>
    <cfif ARGUMENTS.pwfsName NEQ "">
    AND UPPER(pwfsName) = <cfqueryparam value="#UCASE(ARGUMENTS.pwfsName)#" cfsqltype="cf_sql_varchar">
    </cfif>
    AND pwfsStatus IN (<cfqueryparam value="#ARGUMENTS.pwfsStatus#" list="yes" cfsqltype="cf_sql_integer">)
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsProductWorkflowStatus = StructNew()>
    <cfset rsProductWorkflowStatus.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsProductWorkflowStatus>
    </cffunction>
    
    <cffunction name="getProductWorkflowComment" access="public" returntype="query" hint="Get Product Workflow Comment data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="ID" type="numeric" required="yes" default="0">
    <cfargument name="excludeID" type="numeric" required="yes" default="0">
    <cfargument name="pwfID" type="numeric" required="yes" default="0">
    <cfargument name="pwfName" type="string" required="yes" default="">
    <cfargument name="pID" type="numeric" required="yes" default="0">
    <cfargument name="userID" type="numeric" required="yes" default="0">
    <cfargument name="pwfcStatus" type="string" required="yes" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="pwfName">
    <cfset var rsProductWorkflowComment = "" >
    <cftry>
    <cfquery name="rsProductWorkflowComment" datasource="#application.mcmsDSN#">
    SELECT * FROM v_product_wf_comment WHERE 0=0
    <cfif ARGUMENTS.ID NEQ 0>
    AND ID = <cfqueryparam value="#ARGUMENTS.ID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.excludeID NEQ 0>
    AND ID <> <cfqueryparam value="#ARGUMENTS.excludeID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(pwfComment) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(pwfName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(pName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">)
    </cfif>
    <cfif ARGUMENTS.pwfID NEQ 0>
    AND pwfID = <cfqueryparam value="#ARGUMENTS.pwfID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.pID NEQ 0>
    AND pID = <cfqueryparam value="#ARGUMENTS.pID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.pwfName NEQ ''>
    AND UPPER(pwfName) = <cfqueryparam value="#UCASE(ARGUMENTS.pwfName)#" cfsqltype="cf_sql_varchar">
    </cfif>
    <cfif ARGUMENTS.userID NEQ 0>
    AND userID = <cfqueryparam value="#ARGUMENTS.userID#" cfsqltype="cf_sql_integer">
    </cfif>
    AND pwfcStatus IN (<cfqueryparam value="#ARGUMENTS.pwfcStatus#" list="yes" cfsqltype="cf_sql_integer">)
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsProductWorkflowComment = StructNew()>
    <cfset rsProductWorkflowComment.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsProductWorkflowComment>
    </cffunction>
    
    <cffunction name="getProductExportStatus" access="public" returntype="query" hint="Get Product Export Status data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="ID" type="numeric" required="yes" default="0">
    <cfargument name="excludeID" type="numeric" required="yes" default="0">
    <cfargument name="pesName" type="string" required="yes" default="">
    <cfargument name="pesStatus" type="string" required="yes" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="pesName">
    <cfset var rsProductExportStatus = "" >
    <cftry>
    <cfquery name="rsProductExportStatus" datasource="#application.mcmsDSN#">
    SELECT * FROM v_product_export_status WHERE 0=0
    <cfif ARGUMENTS.ID NEQ 0>
    AND ID = <cfqueryparam value="#ARGUMENTS.ID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.excludeID NEQ 0>
    AND ID <> <cfqueryparam value="#ARGUMENTS.excludeID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND UPPER(pesName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">
    </cfif>
    <cfif ARGUMENTS.pesName NEQ "">
    AND UPPER(pesName) = <cfqueryparam value="#UCASE(ARGUMENTS.pesName)#" cfsqltype="cf_sql_varchar">
    </cfif>
    AND pesStatus IN (<cfqueryparam value="#ARGUMENTS.pesStatus#" list="yes" cfsqltype="cf_sql_integer">)
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsProductExportStatus = StructNew()>
    <cfset rsProductExportStatus.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsProductExportStatus>
    </cffunction>
    
    <cffunction name="getProductPriority" access="public" returntype="query" hint="Get Product Priority data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="ID" type="numeric" required="yes" default="0">
    <cfargument name="excludeID" type="numeric" required="yes" default="0">
    <cfargument name="ppName" type="string" required="yes" default="">
    <cfargument name="ppStatus" type="string" required="yes" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="ppName">
    <cfset var rsProductPriority = "" >
    <cftry>
    <cfquery name="rsProductPriority" datasource="#application.mcmsDSN#">
    SELECT * FROM v_product_priority WHERE 0=0
    <cfif ARGUMENTS.ID NEQ 0>
    AND ID = <cfqueryparam value="#ARGUMENTS.ID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.excludeID NEQ 0>
    AND ID <> <cfqueryparam value="#ARGUMENTS.excludeID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(ppName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(ppDescription) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">)
    </cfif>
    <cfif ARGUMENTS.ppName NEQ "">
    AND UPPER(ppName) = <cfqueryparam value="#UCASE(ARGUMENTS.ppName)#" cfsqltype="cf_sql_varchar">
    </cfif>
    AND ppStatus IN (<cfqueryparam value="#ARGUMENTS.ppStatus#" list="yes" cfsqltype="cf_sql_integer">)
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsProductPriority = StructNew()>
    <cfset rsProductPriority.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsProductPriority>
    </cffunction>
    
    <cffunction name="getProductWorkflowStatusRel" access="public" returntype="query" hint="Get Product Workflow Status Relationship data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="ID" type="numeric" required="yes" default="0">
    <cfargument name="excludeID" type="numeric" required="yes" default="0">
    <cfargument name="pID" type="numeric" required="yes" default="0">
    <cfargument name="pwfsID" type="numeric" required="yes" default="0">
    <cfargument name="userID" type="numeric" required="yes" default="0">
    <cfargument name="urID" type="numeric" required="yes" default="0">
    <cfargument name="urStatus" type="string" required="yes" default="1,3">
    <cfargument name="userStatus" type="string" required="yes" default="1,3">
    <cfargument name="pwfsStatus" type="string" required="yes" default="1,3">
    <cfargument name="pStatus" type="string" required="yes" default="1,3">
    <cfargument name="pwfsrStatus" type="string" required="yes" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="pwfsrDateUpdate DESC">
    <cfset var rsProductWorkflowStatusRel = "" >
    <cftry>
    <cfquery name="rsProductWorkflowStatusRel" datasource="#application.mcmsDSN#" cachedWithin="#request.queryCache#">
    SELECT * FROM v_product_wf_status_rel WHERE 0=0
    <cfif ARGUMENTS.ID NEQ 0>
    AND ID = <cfqueryparam value="#ARGUMENTS.ID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.excludeID NEQ 0>
    AND ID <> <cfqueryparam value="#ARGUMENTS.excludeID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(pName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(pwfsName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(userfName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(userlName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(urName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">)
    </cfif>
    <cfif ARGUMENTS.pID NEQ 0>
    AND pID = <cfqueryparam value="#ARGUMENTS.pID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.pwfsID NEQ 0>
    AND pwfsID = <cfqueryparam value="#ARGUMENTS.pwfsID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.userID NEQ 0>
    AND userID = <cfqueryparam value="#ARGUMENTS.userID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.urID NEQ 0>
    AND urID = <cfqueryparam value="#ARGUMENTS.urID#" cfsqltype="cf_sql_integer">
    </cfif>
    AND urStatus IN (<cfqueryparam value="#ARGUMENTS.urStatus#" list="yes" cfsqltype="cf_sql_integer">)
    AND userStatus IN (<cfqueryparam value="#ARGUMENTS.userStatus#" list="yes" cfsqltype="cf_sql_integer">)
    AND pwfsStatus IN (<cfqueryparam value="#ARGUMENTS.pwfsStatus#" list="yes" cfsqltype="cf_sql_integer">)
    AND pStatus IN (<cfqueryparam value="#ARGUMENTS.pStatus#" list="yes" cfsqltype="cf_sql_integer">)
    AND pwfsrStatus IN (<cfqueryparam value="#ARGUMENTS.pwfsrStatus#" list="yes" cfsqltype="cf_sql_integer">)
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsProductWorkflowStatusRel = StructNew()>
    <cfset rsProductWorkflowStatusRel.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsProductWorkflowStatusRel>
    </cffunction>
    
    <cffunction name="getProductWorkflowRequest" access="public" returntype="query" hint="Get Product Workflow Request data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="ID" type="numeric" required="yes" default="0">
    <cfargument name="excludeID" type="numeric" required="yes" default="0">
    <cfargument name="pID" type="numeric" required="yes" default="0">
    <cfargument name="pwfID" type="numeric" required="yes" default="0">
    <cfargument name="pwfrtID" type="numeric" required="yes" default="0">
    <cfargument name="pwfrsID" type="numeric" required="yes" default="0">
    <cfargument name="pwfrUserID" type="numeric" required="yes" default="0">
    <cfargument name="userID" type="numeric" required="yes" default="0">
    <cfargument name="urID" type="string" required="yes" default="0">
    <cfargument name="pwfrsStatus" type="string" required="yes" default="1,3">
    <cfargument name="pwfrtStatus" type="string" required="yes" default="1,3">
    <cfargument name="pwfStatus" type="string" required="yes" default="1,3">
    <cfargument name="pStatus" type="string" required="yes" default="1,3">
    <cfargument name="pwfrStatus" type="string" required="yes" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="pwfrDateRequired DESC">
    <cfset var rsProductWorkflowRequest = "" >
    <cftry>
    <cfquery name="rsProductWorkflowRequest" datasource="#application.mcmsDSN#">
    SELECT * FROM v_product_workflow_request WHERE 0=0
    <cfif ARGUMENTS.ID NEQ 0>
    AND ID = <cfqueryparam value="#ARGUMENTS.ID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.excludeID NEQ 0>
    AND ID <> <cfqueryparam value="#ARGUMENTS.excludeID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(pwfrRequest) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(pwfName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(pwfrtName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(pwfrsName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(pwfrComment) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(pwfruserfName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(pwfruserlName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">)
    </cfif>
    <cfif ARGUMENTS.pID NEQ 0>
    AND pID = <cfqueryparam value="#ARGUMENTS.pID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.pwfID NEQ 0>
    AND pwfID = <cfqueryparam value="#ARGUMENTS.pwfID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.pwfrtID NEQ 0>
    AND pwfrtID = <cfqueryparam value="#ARGUMENTS.pwfrtID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.pwfrsID NEQ 0>
    AND pwfrsID = <cfqueryparam value="#ARGUMENTS.pwfrsID#" cfsqltype="cf_sql_integer">
    </cfif>
    <!---Show requests if they have been posted by or are assigned to.--->
    <cfif ARGUMENTS.pwfrUserID NEQ 0 AND ARGUMENTS.userID NEQ 0>
    AND (pwfrUserID = <cfqueryparam value="#ARGUMENTS.pwfrUserID#" cfsqltype="cf_sql_integer"> OR userID = <cfqueryparam value="#ARGUMENTS.userID#" cfsqltype="cf_sql_integer">)
    <cfelse>
    <cfif ARGUMENTS.pwfrUserID NEQ 0>
    AND pwfrUserID = <cfqueryparam value="#ARGUMENTS.pwfrUserID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.userID NEQ 0>
    AND userID = <cfqueryparam value="#ARGUMENTS.userID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.urID NEQ 0>
    AND urID IN (<cfqueryparam value="#ARGUMENTS.urID#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    </cfif>
    AND pStatus IN (<cfqueryparam value="#ARGUMENTS.pStatus#" list="yes" cfsqltype="cf_sql_integer">)
    AND pwfrStatus IN (<cfqueryparam value="#ARGUMENTS.pwfrStatus#" list="yes" cfsqltype="cf_sql_integer">)
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsProductWorkflowRequest = StructNew()>
    <cfset rsProductWorkflowRequest.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsProductWorkflowRequest>
    </cffunction>
    
    <cffunction name="getProductDepartmentWorkflowRequest" access="public" returntype="query" hint="Get Product Department Workflow Request data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="ID" type="numeric" required="yes" default="0">
    <cfargument name="excludeID" type="numeric" required="yes" default="0">
    <cfargument name="pID" type="numeric" required="yes" default="0">
    <cfargument name="pwfID" type="numeric" required="yes" default="0">
    <cfargument name="pwfrtID" type="numeric" required="yes" default="0">
    <cfargument name="pwfrsID" type="numeric" required="yes" default="0">
    <cfargument name="pwfrUserID" type="numeric" required="yes" default="0">
    <cfargument name="userID" type="numeric" required="yes" default="0">
    <cfargument name="urID" type="numeric" required="yes" default="0">
    <cfargument name="deptNo" type="string" required="yes" default="0">
    <cfargument name="pwfrsStatus" type="string" required="yes" default="1,3">
    <cfargument name="pwfrtStatus" type="string" required="yes" default="1,3">
    <cfargument name="pwfStatus" type="string" required="yes" default="1,3">
    <cfargument name="pStatus" type="string" required="yes" default="1,3">
    <cfargument name="pwfrStatus" type="string" required="yes" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="pwfrDateRequired DESC">
    <cfset var rsProductDepartmentWorkflowRequest = "" >
    <cftry>
    <cfquery name="rsProductDepartmentWorkflowRequest" datasource="#application.mcmsDSN#">
    SELECT * FROM v_product_dept_wf_request WHERE 0=0
    <cfif ARGUMENTS.ID NEQ 0>
    AND ID = <cfqueryparam value="#ARGUMENTS.ID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.excludeID NEQ 0>
    AND ID <> <cfqueryparam value="#ARGUMENTS.excludeID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(pwfrRequest) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(pwfName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(pwfrtName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(pwfrsName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(pwfrComment) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(pwfruserfName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(pwfruserlName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">)
    </cfif>
    <cfif ARGUMENTS.pID NEQ 0>
    AND pID = <cfqueryparam value="#ARGUMENTS.pID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.pwfID NEQ 0>
    AND pwfID = <cfqueryparam value="#ARGUMENTS.pwfID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.pwfrtID NEQ 0>
    AND pwfrtID = <cfqueryparam value="#ARGUMENTS.pwfrtID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.pwfrsID NEQ 0>
    AND pwfrsID = <cfqueryparam value="#ARGUMENTS.pwfrsID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.deptNo NEQ 0>
    AND deptNo IN (<cfqueryparam value="#ARGUMENTS.deptNo#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    <cfif ARGUMENTS.pwfrUserID NEQ 0>
    AND pwfrUserID = <cfqueryparam value="#ARGUMENTS.pwfrUserID#" cfsqltype="cf_sql_integer">
    </cfif>
    AND pStatus IN (<cfqueryparam value="#ARGUMENTS.pStatus#" list="yes" cfsqltype="cf_sql_integer">)
    AND pwfrStatus IN (<cfqueryparam value="#ARGUMENTS.pwfrStatus#" list="yes" cfsqltype="cf_sql_integer">)
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsProductDepartmentWorkflowRequest = StructNew()>
    <cfset rsProductDepartmentWorkflowRequest.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsProductDepartmentWorkflowRequest>
    </cffunction>
    
    <cffunction name="getProductWorkflowRequestType" access="public" returntype="query" hint="Get Product Workflow Request Type data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="ID" type="numeric" required="yes" default="0">
    <cfargument name="excludeID" type="numeric" required="yes" default="0">
    <cfargument name="pwfrtName" type="string" required="yes" default="">
    <cfargument name="urID" type="numeric" required="yes" default="0">
    <cfargument name="pwfrtStatus" type="string" required="yes" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="pwfrtName">
    <cfset var rsProductWorkflowRequestType = "" >
    <cftry>
    <cfquery name="rsProductWorkflowRequestType" datasource="#application.mcmsDSN#">
    SELECT * FROM v_product_wf_request_type WHERE 0=0
    <cfif ARGUMENTS.ID NEQ 0>
    AND ID = <cfqueryparam value="#ARGUMENTS.ID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.excludeID NEQ 0>
    AND ID <> <cfqueryparam value="#ARGUMENTS.excludeID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(pwfrtName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(pwfrtDescription) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">)
    </cfif>
    <cfif ARGUMENTS.pwfrtName NEQ "">
    AND UPPER(pwfrtName) = <cfqueryparam value="#UCASE(ARGUMENTS.pwfrtName)#" cfsqltype="cf_sql_varchar">
    </cfif>
    <cfif ARGUMENTS.urID NEQ 0>
    AND urID = <cfqueryparam value="#ARGUMENTS.urID#" cfsqltype="cf_sql_integer">
    </cfif>
    AND pwfrtStatus IN (<cfqueryparam value="#ARGUMENTS.pwfrtStatus#" list="yes" cfsqltype="cf_sql_integer">)
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsProductWorkflowRequestType = StructNew()>
    <cfset rsProductWorkflowRequestType.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsProductWorkflowRequestType>
    </cffunction>
    
    <cffunction name="getProductWorkflowRequestStatus" access="public" returntype="query" hint="Get Product Workflow Request Status data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="ID" type="numeric" required="yes" default="0">
    <cfargument name="excludeID" type="numeric" required="yes" default="0">
    <cfargument name="pwfrsName" type="string" required="yes" default="">
    <cfargument name="pwfrsStatus" type="string" required="yes" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="pwfrsName">
    <cfset var rsProductWorkflowRequestStatus = "" >
    <cftry>
    <cfquery name="rsProductWorkflowRequestStatus" datasource="#application.mcmsDSN#" cachedWithin="#request.queryCache#">
    SELECT * FROM v_product_wf_request_status WHERE 0=0
    <cfif ARGUMENTS.ID NEQ 0>
    AND ID = <cfqueryparam value="#ARGUMENTS.ID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.excludeID NEQ 0>
    AND ID <> <cfqueryparam value="#ARGUMENTS.excludeID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(pwfrsName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(pwfrsDescription) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">)
    </cfif>
    <cfif ARGUMENTS.pwfrsName NEQ "">
    AND UPPER(pwfrsName) = <cfqueryparam value="#UCASE(ARGUMENTS.pwfrsName)#" cfsqltype="cf_sql_varchar">
    </cfif>
    AND pwfrsStatus IN (<cfqueryparam value="#ARGUMENTS.pwfrsStatus#" list="yes" cfsqltype="cf_sql_integer">)
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsProductWorkflowRequestStatus = StructNew()>
    <cfset rsProductWorkflowRequestStatus.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsProductWorkflowRequestStatus>
    </cffunction>
    
    <cffunction name="getProductWorkflowPhotoRequest" access="public" returntype="query" hint="Get Product Workflow Photo Request data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="ID" type="numeric" required="yes" default="0">
    <cfargument name="excludeID" type="numeric" required="yes" default="0">
    <cfargument name="pName" type="string" required="yes" default="">
    <cfargument name="vName" type="string" required="yes" default="">
    <cfargument name="skuID" type="string" required="yes" default="">
    <cfargument name="pwfprStatus" type="string" required="yes" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="pwfprDateRequired">
    <cfset var rsProductWorkflowPhotoRequest = "" >
    <cftry>
    <cfquery name="rsProductWorkflowPhotoRequest" datasource="#application.mcmsDSN#">
    SELECT * FROM v_product_wf_photo_request WHERE 0=0
    <cfif ARGUMENTS.ID NEQ 0>
    AND ID = <cfqueryparam value="#ARGUMENTS.ID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.excludeID NEQ 0>
    AND ID <> <cfqueryparam value="#ARGUMENTS.excludeID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(pName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(vName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(skuID) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">)
    </cfif>
    <cfif ARGUMENTS.pName NEQ "">
    AND UPPER(pName) = <cfqueryparam value="#UCASE(ARGUMENTS.pName)#" cfsqltype="cf_sql_varchar">
    </cfif>
    <cfif ARGUMENTS.vName NEQ "">
    AND UPPER(vName) = <cfqueryparam value="#UCASE(ARGUMENTS.vName)#" cfsqltype="cf_sql_varchar">
    </cfif>
    <cfif ARGUMENTS.skuID NEQ "">
    AND UPPER(skuID) = <cfqueryparam value="#UCASE(ARGUMENTS.skuID)#" cfsqltype="cf_sql_varchar">
    </cfif>
    AND pwfprStatus IN (<cfqueryparam value="#ARGUMENTS.pwfprStatus#" list="yes" cfsqltype="cf_sql_integer">)
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsProductWorkflowPhotoRequest = StructNew()>
    <cfset rsProductWorkflowPhotoRequest.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsProductWorkflowPhotoRequest>
    </cffunction>
    
    <cffunction name="getProductWorkflowPhotoRequestType" access="public" returntype="query" hint="Get Product Workflow Photo Request Type data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="ID" type="numeric" required="yes" default="0">
    <cfargument name="excludeID" type="numeric" required="yes" default="0">
    <cfargument name="pwfprtStatus" type="string" required="yes" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="pwfprtName">
    <cfset var rsProductWorkflowPhotoRequestType = "" >
    <cftry>
    <cfquery name="rsProductWorkflowPhotoRequestType" datasource="#application.mcmsDSN#" cachedWithin="#request.queryCache#">
    SELECT * FROM tbl_product_wf_photo_r_type WHERE 0=0
    <cfif ARGUMENTS.ID NEQ 0>
    AND ID = <cfqueryparam value="#ARGUMENTS.ID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.excludeID NEQ 0>
    AND ID <> <cfqueryparam value="#ARGUMENTS.excludeID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND UPPER(pwfprtName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">
    </cfif>
    AND pwfprtStatus IN (<cfqueryparam value="#ARGUMENTS.pwfprtStatus#" list="yes" cfsqltype="cf_sql_integer">)
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsProductWorkflowPhotoRequestType = StructNew()>
    <cfset rsProductWorkflowPhotoRequestType.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsProductWorkflowPhotoRequestType>
    </cffunction>
    
    <cffunction name="insertProductWorkflowComment" access="public" returntype="struct">
    <cfargument name="pwfcComment" type="string" required="yes">
    <cfargument name="pwfID" type="numeric" required="yes">
    <cfargument name="pID" type="numeric" required="yes">
    <cfargument name="userID" type="numeric" required="yes">
    <cfargument name="pwfcStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully inserted the record.">
    <cftry>
    <!---Check for profanity in the text.--->
    <cfinvoke 
    component="MCMS.component.utility.Regex"
    method="regexProfanity"
    returnvariable="regexProfanityRet">
    <cfinvokeargument name="profanityString" value="#TRIM(ARGUMENTS.pwfcComment)#"/>
    </cfinvoke>
    <cfif regexProfanityRet CONTAINS '$%&*!'>
    <cfset result.message = "Some text contained profanity, please remove any profanity from your text.">
    <!---Check length restriction.--->
    <cfelseif LEN(ARGUMENTS.pwfcComment) GT 2048>
    <cfset result.message = "The comments are longer than 2048 characters, please enter new comments under 2048 characters.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    INSERT INTO tbl_product_wf_comment (pwfcComment,pwfID,pID,userID,pwfcStatus) VALUES
    (
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#TRIM(ARGUMENTS.pwfcComment)#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.pwfID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.pID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.userID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.pwfcStatus#">
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
    
    <cffunction name="insertProductWorkflowStatusRel" access="public" returntype="struct">
    <cfargument name="pID" type="numeric" required="yes">
    <cfargument name="pwfsID" type="numeric" required="yes">
    <cfargument name="userID" type="numeric" required="yes">
    <cfargument name="urID" type="numeric" required="yes">
    <cfargument name="pwfsrStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully inserted the record.">
    <cftry>
    <!---Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.app.product_workflow.ProductWorkflow"
    method="getProductWorkflowStatusRel"
    returnvariable="getCheckProductWorkflowStatusRelRet">
    <cfinvokeargument name="pID" value="#ARGUMENTS.pID#"/>
    <cfinvokeargument name="pwfsID" value="#ARGUMENTS.pwfsID#"/>
    <cfinvokeargument name="userID" value="#ARGUMENTS.userID#"/>
    <cfinvokeargument name="urID" value="#ARGUMENTS.urID#"/>
    <cfinvokeargument name="pwfsrStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckProductWorkflowStatusRelRet.recordcount NEQ 0>
    <cfset result.message = "The product workflow status relationship already exists, please try again.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    INSERT INTO tbl_product_wf_status_rel (pID,pwfsID,userID,urID,pwfsrStatus) VALUES
    (
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.pID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.pwfsID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.userID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.urID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.pwfsrStatus#">
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
    
    <cffunction name="insertProductWorkflowUserRoleRel" access="public" returntype="struct">
    <cfargument name="pwfID" type="numeric" required="yes">
    <cfargument name="urID" type="numeric" required="yes">
    <cfargument name="pwfaID" type="numeric" required="yes">
    <cfargument name="pwfurrStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully inserted the record.">
    <cftry>
    <!---Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.app.product_workflow.ProductWorkflow"
    method="getProductWorkflowUserRoleRel"
    returnvariable="getCheckProductWorkflowUserRoleRelRet">
    <cfinvokeargument name="pwfID" value="#ARGUMENTS.pwfID#"/>
    <cfinvokeargument name="urID" value="#ARGUMENTS.urID#"/>
    <cfinvokeargument name="pwfurrStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckProductWorkflowUserRoleRelRet.recordcount NEQ 0>
    <cfset result.message = "The product workflow user role relationship already exists, please try again.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    INSERT INTO tbl_product_wf_user_role_rel (pwfID,urID,pwfaID,pwfurrStatus) VALUES
    (
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.pwfID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.urID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.pwfaID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.pwfurrStatus#">
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
    
    <cffunction name="insertProductWorkflowRequestType" access="public" returntype="struct">
    <cfargument name="pwfrtName" type="string" required="yes">
    <cfargument name="pwfrtDescription" type="string" required="yes">
    <cfargument name="urID" type="numeric" required="yes">
    <cfargument name="pwfrtSort" type="numeric" required="yes">
    <cfargument name="pwfrtStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully inserted the record.">
    <cftry>
    <!---Check for profanity in the text.--->
    <cfinvoke 
    component="MCMS.component.utility.Regex"
    method="regexProfanity"
    returnvariable="regexProfanityRet">
    <cfinvokeargument name="profanityString" value="#TRIM(ARGUMENTS.pwfrtDescription)#"/>
    </cfinvoke>
    <!---Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.app.product_workflow.ProductWorkflow"
    method="getProductWorkflowRequestType"
    returnvariable="getCheckProductWorkflowRequestTypeRet">
    <cfinvokeargument name="pwfrtName" value="#ARGUMENTS.pwfrtName#"/>
    <cfinvokeargument name="pwfrtStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckProductWorkflowRequestTypeRet.recordcount NEQ 0>
    <cfset result.message = "The product workflow request type already exists, please try again.">
    <cfelseif regexProfanityRet CONTAINS '$%&*!'>
    <cfset result.message = "Some text contained profanity, please remove any profanity from your text.">
    <!---Check length restriction.--->
    <cfelseif LEN(ARGUMENTS.pwfrtDescription) GT 2048>
    <cfset result.message = "The description are longer than 2048 characters, please enter new comments under 2048 characters.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    INSERT INTO tbl_product_wf_request_type (pwfrtName,pwfrtDescription,urID,pwfrtSort,pwfrtStatus) VALUES
    (
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.pwfrtName#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.pwfrtDescription#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.urID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.pwfrtSort#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.pwfrtStatus#">
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
    
    <cffunction name="insertProductWorkflowRequest" access="public" returntype="struct">
    <cfargument name="pID" type="numeric" required="yes">
    <cfargument name="pwfID" type="numeric" required="yes">
    <cfargument name="pwfrRequest" type="string" required="yes">
    <cfargument name="pwfrtID" type="numeric" required="yes">
    <cfargument name="pwfrDateRequired" type="date" required="yes">
    <cfargument name="pwfrsID" type="numeric" required="yes">
    <cfargument name="pwfrStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully sent the request.">
    <cftry>
    <!---Check for profanity in the text.--->
    <cfinvoke 
    component="MCMS.component.utility.Regex"
    method="regexProfanity"
    returnvariable="regexProfanityRet">
    <cfinvokeargument name="profanityString" value="#TRIM(ARGUMENTS.pwfrRequest)#"/>
    </cfinvoke>
    <cfif regexProfanityRet CONTAINS '$%&*!'>
    <cfset result.message = "Some text contained profanity, please remove any profanity from your text.">
    <!---Check length restriction.--->
    <cfelseif LEN(ARGUMENTS.pwfrRequest) GT 2048>
    <cfset result.message = "The request is longer than 2048 characters, please enter a new request under 2048 characters.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    INSERT INTO tbl_product_workflow_request (pID,pwfID,pwfrRequest,pwfrtID,pwfrDateRequired,pwfrsID,pwfrUserID,pwfrStatus) VALUES
    (
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.pID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.pwfID#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#TRIM(ARGUMENTS.pwfrRequest)#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.pwfrtID#">,
    <cfqueryparam cfsqltype="cf_sql_date" value="#ARGUMENTS.pwfrDateRequired#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.pwfrsID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#session.userID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.pwfrStatus#">
    )
    </cfquery>
    </cftransaction>
    <!--- Get newly inserted page ID. --->
    <cfinvoke 
    component="MCMS.component.cms.Cms"
    method="getMaxValueSQL"
    returnvariable="pwfrID">
    <cfinvokeargument name="tableName" value="tbl_product_workflow_request"/>
    </cfinvoke>
    <cfset var.pwfrID = pwfrID>
    <cfinvoke 
    component="MCMS.component.app.product_workflow.ProductWorkflow"
    method="getProductWorkflowRequest"
    returnvariable="getProductWorkflowRequestRet">
    <cfinvokeargument name="ID" value="#var.pwfrID#"/>
    <cfinvokeargument name="pwfrStatus" value="1"/>
    </cfinvoke>
    <!--- Get role based on request type. --->
    <cfinvoke 
    component="MCMS.component.app.product_workflow.ProductWorkflow"
    method="getProductWorkflowRequestType"
    returnvariable="getProductWorkflowRequestTypeRet">
    <cfinvokeargument name="ID" value="#getProductWorkflowRequestRet.pwfrtID#"/>
    <cfinvokeargument name="pwfrtStatus" value="1"/>
    </cfinvoke>
    <!--- Get user email based on role. --->
    <cfinvoke 
    component="MCMS.component.cms.User"
    method="getUser"
    returnvariable="getUserRet">
    <cfinvokeargument name="urID" value="#getProductWorkflowRequestTypeRet.urID#"/>
    <cfinvokeargument name="userStatus" value="1"/>
    </cfinvoke>
    <cfif getUserRet.recordCount EQ 0>
    <cfset result.message = "There is no user associated with the workflow request type selected.">
    <cfelse>
    <cfset var.emailList = ValueList(getUserRet.userEmail)>
    <cfinvoke 
    component="MCMS.component.utility.Email"
    method="sendEmail">
    <cfinvokeargument name="subject" value="#application.companyName# - Workflow Request"/>
    <cfinvokeargument name="to" value="#var.emailList#"/>
    <cfinvokeargument name="cc" value="#session.userUsername#"/>
    <cfinvokeargument name="from" value="#session.userUsername#"/>
    <cfinvokeargument name="body" value=""/>
    <cfinvokeargument name="ID" value="#var.pwfrID#"/>
    <cfinvokeargument name="emailTemplate" value="/#application.mcmsAppAdminPath#/product/view/inc_request_email_template.cfm"/>
    </cfinvoke>
    </cfif>
    </cfif>
    <cfcatch type="any">
    <cfset result.message = "There was an error inserting the record.">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="insertProductWorkflowPhotoRequest" access="public" returntype="struct">
    <cfargument name="pID" type="numeric" required="yes">
    <cfargument name="sID" type="numeric" required="yes">
    <cfargument name="pwfprDateRequired" type="string" required="yes">
    <cfargument name="pwfprtID" type="numeric" required="yes">
    <cfargument name="pwfprSampleProvided" type="numeric" required="yes">
    <cfargument name="pwfprDateSampleReturn" type="string" required="yes">
    <cfargument name="pwfprQtyRequired" type="numeric" required="yes">
    <cfargument name="pwfprReshootReason" type="string" required="yes">
    <cfargument name="pwfprNotes" type="string" required="yes">
    <cfargument name="pwfprsID" type="numeric" required="yes">
    <cfargument name="pwfprStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully inserted the record.">
    <cftry>
    <!---Check for profanity in the text.--->
    <cfinvoke 
    component="MCMS.component.utility.Regex"
    method="regexProfanity"
    returnvariable="regexProfanityRet">
    <cfinvokeargument name="profanityString" value="#TRIM(ARGUMENTS.pwfprNotes)#"/>
    </cfinvoke>
    <cfif regexProfanityRet CONTAINS '$%&*!'>
    <cfset result.message = "Some text contained profanity, please remove any profanity from your text.">
    <!---Check length restriction.--->
    <cfelseif LEN(ARGUMENTS.pwfprNotes) GT 1024>
    <cfset result.message = "The notes are longer than 1024 characters, please enter new notes under 1024 characters.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    INSERT INTO tbl_product_wf_photo_request (pID,sID,pwfprDateRequired,pwfprtID,pwfprSampleProvided,pwfprDateSampleReturn,pwfprQtyRequired,pwfprReshootReason,pwfprNotes,pwfprsID,userID,pwfprStatus) VALUES
    (
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.pID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.sID#">,
    <cfqueryparam cfsqltype="cf_sql_date" value="#ARGUMENTS.pwfprDateRequired#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.pwfprtID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.pwfprSampleProvided#">,
    <cfqueryparam cfsqltype="cf_sql_date" value="#ARGUMENTS.pwfprDateSampleReturn#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.pwfprQtyRequired#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#TRIM(ARGUMENTS.pwfprReshootReason)#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#TRIM(ARGUMENTS.pwfprNotes)#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.pwfprsID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#session.userID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.pwfprStatus#">
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
    
    <cffunction name="updateProductWorkflowRequest" access="public" returntype="struct">
    <cfargument name="ID" type="numeric" required="yes">
    <cfargument name="pwfrComment" type="string" required="yes">
    <cfargument name="pwfrsID" type="numeric" required="yes">
    <cfset result.message = "You have successfully updated the record.">
    <cftry>
    <!---Check for profanity in the text.--->
    <cfinvoke 
    component="MCMS.component.utility.Regex"
    method="regexProfanity"
    returnvariable="regexProfanityRet">
    <cfinvokeargument name="profanityString" value="#TRIM(ARGUMENTS.pwfrComment)#"/>
    </cfinvoke>
    <cfif regexProfanityRet CONTAINS '$%&*!'>
    <cfset result.message = "Some text contained profanity, please remove any profanity from your text.">
    <!---Check length restriction.--->
    <cfelseif LEN(ARGUMENTS.pwfrComment) GT 2048>
    <cfset result.message = "The comment is longer than 2048 characters, please enter a new comment under 2048 characters.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_product_workflow_request SET
    pwfrComment = <cfqueryparam cfsqltype="cf_sql_varchar" value="#TRIM(ARGUMENTS.pwfrComment)#">,
    pwfrDateUpdate = <cfqueryparam cfsqltype="cf_sql_timestamp" value="#Now()#">,
    userID = <cfqueryparam cfsqltype="cf_sql_integer" value="#session.userID#">,
    pwfrsID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.pwfrsID#">
    WHERE ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ID#">
    </cfquery>
    </cftransaction>
    <cfinvoke 
    component="MCMS.component.app.product_workflow.ProductWorkflow"
    method="getProductWorkflowRequest"
    returnvariable="getProductWorkflowRequestRet">
    <cfinvokeargument name="ID" value="#ARGUMENTS.ID#"/>
    <cfinvokeargument name="pwfrStatus" value="1"/>
    </cfinvoke>
    <cfinvoke 
    component="MCMS.component.utility.Email"
    method="sendEmail">
    <cfinvokeargument name="subject" value="#application.companyName# - Workflow Request Update"/>
    <cfinvokeargument name="to" value="#getProductWorkflowRequestRet.userEmail#"/>
    <cfinvokeargument name="from" value="#application.noReplyEmail#"/>
    <cfinvokeargument name="body" value=""/>
    <cfinvokeargument name="ID" value="#ARGUMENTS.ID#"/>
    <cfinvokeargument name="emailTemplate" value="/#application.mcmsAppAdminPath#/product/view/inc_request_email_template.cfm"/>
    </cfinvoke>
    </cfif>
    <cfcatch type="any">
    <cfset result.message = "There was an error updating the record.">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="updateProductWorkflowUserRoleRel" access="public" returntype="struct">
    <cfargument name="ID" type="numeric" required="yes">
    <cfargument name="pwfID" type="numeric" required="yes">
    <cfargument name="urID" type="numeric" required="yes">
    <cfargument name="pwfaID" type="numeric" required="yes">
    <cfargument name="pwfurrStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully updated the record.">
    <cftry>
    <!---Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.app.product_workflow.ProductWorkflow"
    method="getProductWorkflowUserRoleRel"
    returnvariable="getCheckProductWorkflowUserRoleRelRet">
    <cfinvokeargument name="excludeID" value="#ARGUMENTS.ID#"/>
    <cfinvokeargument name="pwfID" value="#ARGUMENTS.pwfID#"/>
    <cfinvokeargument name="urID" value="#ARGUMENTS.urID#"/>
    <cfinvokeargument name="pwfurrStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckProductWorkflowUserRoleRelRet.recordcount NEQ 0>
    <cfset result.message = "The product workflow user role relationship already exists, please try again.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_product_wf_user_role_rel SET
    pwfID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.pwfID#">,
    urID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.urID#">,
    pwfaID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.pwfaID#">,
    pwfurrStatus = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.pwfurrStatus#">
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
    
    <cffunction name="updateProductWorkflowRequestType" access="public" returntype="struct">
    <cfargument name="ID" type="numeric" required="yes">
    <cfargument name="pwfrtName" type="string" required="yes">
    <cfargument name="pwfrtDescription" type="string" required="yes">
    <cfargument name="urID" type="numeric" required="yes">
    <cfargument name="pwfrtSort" type="numeric" required="yes">
    <cfargument name="pwfrtStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully updated the record.">
    <cftry>
    <!---Check for profanity in the text.--->
    <cfinvoke 
    component="MCMS.component.utility.Regex"
    method="regexProfanity"
    returnvariable="regexProfanityRet">
    <cfinvokeargument name="profanityString" value="#TRIM(ARGUMENTS.pwfrtDescription)#"/>
    </cfinvoke>
    <!---Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.app.product_workflow.ProductWorkflow"
    method="getProductWorkflowRequestType"
    returnvariable="getCheckProductWorkflowRequestTypeRet">
    <cfinvokeargument name="excludeID" value="#ARGUMENTS.ID#"/>
    <cfinvokeargument name="pwfrtName" value="#ARGUMENTS.pwfrtName#"/>
    <cfinvokeargument name="pwfrtStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckProductWorkflowRequestTypeRet.recordcount NEQ 0>
    <cfset result.message = "The product workflow request type already exists, please try again.">
    <cfelseif regexProfanityRet CONTAINS '$%&*!'>
    <cfset result.message = "Some text contained profanity, please remove any profanity from your text.">
    <!---Check length restriction.--->
    <cfelseif LEN(ARGUMENTS.pwfrtDescription) GT 2048>
    <cfset result.message = "The description are longer than 2048 characters, please enter new comments under 2048 characters.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_product_wf_request_type SET
    pwfrtName = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.pwfrtName#">,
    pwfrtDescription = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.pwfrtDescription#">,
    urID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.urID#">,
    pwfrtSort = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.pwfrtSort#">,
    pwfrtStatus = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.pwfrtStatus#">
    WHERE ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ID#">
    </cfquery>
    </cftransaction>
    </cfif>
    <cfcatch type="any">
    <cfset result.message = "There was an error inserting the record.">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="updateProductWorkflowUserRoleRelList" access="public" returntype="struct">
    <cfargument name="ID" type="numeric" required="yes">
    <cfargument name="pwfurrStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully updated the records.">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_product_wf_user_role_rel SET
    pwfurrStatus = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.pwfurrStatus#">
    WHERE ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ID#">
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error updating the records.">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="updateProductWorkflowRequestTypeList" access="public" returntype="struct">
    <cfargument name="ID" type="numeric" required="yes">
    <cfargument name="pwfrtStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully updated the records.">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_product_wf_request_type SET
    pwfrtStatus = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.pwfrtStatus#">
    WHERE ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ID#">
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error updating the records.">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="deleteProductWorkflowRequest" access="public" returntype="struct">
    <cfargument name="ID" type="string" required="yes">
    <cfset result.message = "You have successfully deleted the record(s).">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    DELETE FROM tbl_product_workflow_request
    WHERE ID IN (<cfqueryparam cfsqltype="cf_sql_integer" list="yes" value="#ARGUMENTS.ID#">)
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error deleting the record(s).">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="deleteProductWorkflowUserRoleRel" access="public" returntype="struct">
    <cfargument name="ID" type="string" required="yes">
    <cfset result.message = "You have successfully deleted the record(s).">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    DELETE FROM tbl_product_wf_user_role_rel
    WHERE ID IN (<cfqueryparam cfsqltype="cf_sql_integer" list="yes" value="#ARGUMENTS.ID#">)
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error deleting the record(s).">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="deleteProductWorkflowRequestType" access="public" returntype="struct">
    <cfargument name="ID" type="string" required="yes">
    <cfset result.message = "You have successfully deleted the record(s).">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    DELETE FROM tbl_product_wf_request_type
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