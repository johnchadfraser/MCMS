<cfcomponent>
    <cffunction name="getPagePortal" access="public" returntype="query" hint="Get Page Portal data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="ppDateExp" type="string" required="yes" default="">
    <cfargument name="ID" type="string" required="yes" default="0">
    <cfargument name="excludeID" type="numeric" required="yes" default="0">
    <cfargument name="ppTitle" type="string" required="yes" default="">
    <cfargument name="ppContent" type="string" required="yes" default="">
    <cfargument name="pptID" type="numeric" required="yes" default="0">
    <cfargument name="userID" type="numeric" required="yes" default="0">
    <cfargument name="ppParentType" type="numeric" required="yes" default="0">
    <cfargument name="ppParentID" type="numeric" required="yes" default="0">
    <cfargument name="pptFormProcess" type="string" required="yes" default="">
    <cfargument name="ppStatus" type="string" required="yes" default="1,3">
    <cfargument name="pptStatus" type="string" required="yes" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="ppTitle">
    <cfset var rsPagePortal = "" >
    <cftry>
    <cfquery name="rsPagePortal" datasource="#application.mcmsDSN#">
    SELECT * FROM v_page_portal WHERE 0=0
    <cfif ARGUMENTS.ID NEQ 0>
    AND ID IN (<cfqueryparam value="#ARGUMENTS.ID#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    <cfif ARGUMENTS.excludeID NEQ 0>
    AND ID <> <cfqueryparam value="#ARGUMENTS.excludeID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(ppTitle) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(ppContent) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(ppMeta) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">)
    </cfif>
    <cfif ARGUMENTS.ppTitle NEQ "">
    AND UPPER(ppTitle) = <cfqueryparam value="#UCASE(ARGUMENTS.ppTitle)#" cfsqltype="cf_sql_varchar">
    </cfif>
    <cfif ARGUMENTS.pptFormProcess NEQ "">
    AND UPPER(pptFormProcess) = <cfqueryparam value="#UCASE(ARGUMENTS.pptFormProcess)#" cfsqltype="cf_sql_varchar">
    </cfif>
    <cfif ARGUMENTS.userID NEQ 0>
    AND userID = <cfqueryparam value="#ARGUMENTS.userID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.ppParentType NEQ 0>
    AND ppParentType = <cfqueryparam value="#ARGUMENTS.ppParentType#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.ppParentID NEQ 0>
    AND ppParentID = <cfqueryparam value="#ARGUMENTS.ppParentID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.pptID NEQ 0>
    AND pptID = <cfqueryparam value="#ARGUMENTS.pptID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.ppDateExp NEQ "">
    AND ppDateExp >= <cfqueryparam value="#ARGUMENTS.ppDateExp#" cfsqltype="cf_sql_date">
    </cfif>
    AND ppStatus IN (<cfqueryparam value="#ARGUMENTS.ppStatus#" list="yes" cfsqltype="cf_sql_integer">)
    AND pptStatus IN (<cfqueryparam value="#ARGUMENTS.pptStatus#" list="yes" cfsqltype="cf_sql_integer">)
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsPagePortal = StructNew()>
    <cfset rsPagePortal.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsPagePortal>
    </cffunction>
    
    <cffunction name="getPagePortalNavigation" access="public" returntype="query" hint="Get Page Portal Navigation data by traversing through site and department relationships.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="ID" type="string" required="yes" default="0">
    <cfargument name="excludeID" type="numeric" required="yes" default="0">
    <cfargument name="deptNo" type="string" required="yes" default="#request.remotePCDeptNo#">
    <cfargument name="ppParentType" type="string" required="yes" default="0">
    <cfargument name="ppsrStatus" type="string" required="yes" default="1,3">
    <cfargument name="ppdrStatus" type="string" required="yes" default="1,3">
    <cfargument name="ppStatus" type="string" required="yes" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="ppSort, ppTitle">
    <cfset var rsPagePortalNavigationRet = "" >
    <cftry>
    <!---Get Site Relationships.--->
    <cfinvoke 
    component="cfc.p_portal"
    method="getPagePortalSiteRel"
    returnvariable="getPagePortalSiteRelRet">
    <cfinvokeargument name="siteNo" value="#request.remotePCSiteIP#"/>
    <cfinvokeargument name="ppsrStatus" value="#ARGUMENTS.ppsrStatus#"/>
    <cfinvokeargument name="ppStatus" value="#ARGUMENTS.ppStatus#"/>
    </cfinvoke>
    <cfif getPagePortalSiteRelRet.recordcount NEQ 0>
    <cfset this.ppIDList = ValueList(getPagePortalSiteRelRet.ppID)>
    <cfelse>
    <cfset this.ppIDList = 1>
    </cfif>
    <!---Get Department Relationships.--->
    <cfinvoke 
    component="cfc.p_portal"
    method="getPagePortalDepartmentRel"
    returnvariable="getPagePortalDepartmentRelRet">
    <cfinvokeargument name="ppParentType" value="#ARGUMENTS.ppParentType#"/>
    <cfinvokeargument name="ppID" value="#this.ppIDList#"/>
    <cfinvokeargument name="deptNo" value="#ARGUMENTS.deptNo#"/>
    <cfinvokeargument name="ppdrStatus" value="#ARGUMENTS.ppdrStatus#"/>
    <cfinvokeargument name="ppStatus" value="#ARGUMENTS.ppStatus#"/>
    </cfinvoke>
    <cfif getPagePortalDepartmentRelRet.recordcount NEQ 0>
    <cfset this.ppIDList = ValueList(getPagePortalDepartmentRelRet.ppID)>
    <cfelse>
    <cfset this.ppIDList = 1>
    </cfif>
    <cfinvoke 
    component="cfc.p_portal"
    method="getPagePortal"
    returnvariable="rsPagePortalNavigationRet">
    <cfinvokeargument name="ID" value="#this.ppIDList#"/>
    <cfinvokeargument name="ppDateExp" value="#Now()#"/>
    <cfinvokeargument name="ppStatus" value="#ARGUMENTS.ppStatus#"/>
    <cfinvokeargument name="orderBy" value="#ARGUMENTS.orderBy#"/>
    </cfinvoke>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsPagePortalNavigationRet = StructNew()>
    <cfset rsPagePortalNavigationRet.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsPagePortalNavigationRet>
    </cffunction>
    
    <cffunction name="setPagePortalMenu" access="public" returntype="query" hint="Get Page Portal Menu data by traversing through site and department relationships.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="ID" type="string" required="yes" default="0">
    <cfargument name="excludeID" type="numeric" required="yes" default="0">
    <cfargument name="ppParentType" type="string" required="yes" default="0">
    <cfargument name="ppsrStatus" type="string" required="yes" default="1,3">
    <cfargument name="ppdrStatus" type="string" required="yes" default="1,3">
    <cfargument name="ppStatus" type="string" required="yes" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="deptNo, ppSort, ppTitle">
    <cfset var rsPagePortalMenuRet = "" >
    <cftry>
    <!---Get Site Relationships.--->
    <cfinvoke 
    component="cfc.p_portal"
    method="getPagePortalSiteRel"
    returnvariable="getPagePortalSiteRelRet">
    <cfinvokeargument name="ppParentType" value="#ARGUMENTS.ppParentType#"/>
    <cfinvokeargument name="siteNo" value="#request.remotePCSiteIP#"/>
    <cfinvokeargument name="ppsrStatus" value="#ARGUMENTS.ppsrStatus#"/>
    <cfinvokeargument name="ppStatus" value="#ARGUMENTS.ppStatus#"/>
    </cfinvoke>
    <cfif getPagePortalSiteRelRet.recordcount NEQ 0>
    <cfset this.ppIDList = ValueList(getPagePortalSiteRelRet.ppID)>
    <cfelse>
    <cfset this.ppIDList = 1>
    </cfif>
    <!---Get Department Relationships.--->
    <cfinvoke 
    component="cfc.p_portal"
    method="getPagePortalDepartmentRel"
    returnvariable="rsPagePortalMenuRet">
    <cfinvokeargument name="ppParentType" value="#ARGUMENTS.ppParentType#"/>
    <cfinvokeargument name="ppID" value="#this.ppIDList#"/>
    <cfinvokeargument name="deptNo" value="#request.remotePCDeptNo#"/>
    <cfinvokeargument name="ppdrStatus" value="#ARGUMENTS.ppdrStatus#"/>
    <cfinvokeargument name="ppStatus" value="#ARGUMENTS.ppStatus#"/>
    <cfinvokeargument name="orderBy" value="#ARGUMENTS.orderBy#"/>
    </cfinvoke>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsPagePortalMenuRet = StructNew()>
    <cfset rsPagePortalMenuRet.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsPagePortalMenuRet>
    </cffunction>
    
    <cffunction name="getPagePortalApprover" access="public" returntype="query" hint="Get Page Portal Approver data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="ID" type="numeric" required="yes" default="0">
    <cfargument name="excludeID" type="numeric" required="yes" default="0">
    <cfargument name="userID" type="numeric" required="yes" default="0">
    <cfargument name="userEmail" type="string" required="yes" default="">
    <cfargument name="deptNo" type="string" required="yes" default="0">
    <cfargument name="ppaStatus" type="string" required="yes" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="userID">
    <cfset var rsPagePortalApprover = "" >
    <cftry>
    <cfquery name="rsPagePortalApprover" datasource="#application.mcmsDSN#">
    SELECT * FROM v_p_portal_approver WHERE 0=0
    <cfif ARGUMENTS.ID NEQ 0>
    AND ID = <cfqueryparam value="#ARGUMENTS.ID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.excludeID NEQ 0>
    AND ID <> <cfqueryparam value="#ARGUMENTS.excludeID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(userfname) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(userlname) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(deptName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">)
    </cfif>
    <cfif ARGUMENTS.userID NEQ 0>
    AND userID = <cfqueryparam value="#ARGUMENTS.userID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.userEmail NEQ "">
    AND userEmail = <cfqueryparam value="#ARGUMENTS.userEmail#" cfsqltype="cf_sql_varchar">
    </cfif>
    <cfif ARGUMENTS.deptNo NEQ 0>
    AND deptNo IN (<cfqueryparam value="#ARGUMENTS.deptNo#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    AND ppaStatus IN (<cfqueryparam value="#ARGUMENTS.ppaStatus#" list="yes" cfsqltype="cf_sql_integer">)
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsPagePortalApprover = StructNew()>
    <cfset rsPagePortalApprover.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsPagePortalApprover>
    </cffunction>
    
    <cffunction name="getPagePortalTemplate" access="public" returntype="query" hint="Get Page Portal Template data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="ID" type="numeric" required="yes" default="0">
    <cfargument name="excludeID" type="numeric" required="yes" default="0">
    <cfargument name="pptName" type="string" required="yes" default="">
    <cfargument name="pptDescription" type="string" required="yes" default="">
    <cfargument name="pptFile" type="string" required="yes" default="0">
    <cfargument name="ppttID" type="numeric" required="yes" default="0">
    <cfargument name="pptStatus" type="string" required="yes" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="pptName">
    <cfset var rsPagePortalTemplate = "" >
    <cftry>
    <cfquery name="rsPagePortalTemplate" datasource="#application.mcmsDSN#">
    SELECT * FROM v_p_portal_template WHERE 0=0
    <cfif ARGUMENTS.ID NEQ 0>
    AND ID = <cfqueryparam value="#ARGUMENTS.ID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.excludeID NEQ 0>
    AND ID <> <cfqueryparam value="#ARGUMENTS.excludeID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(pptName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(pptDescription) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">)
    </cfif>
    <cfif ARGUMENTS.pptName NEQ "">
    AND UPPER(pptName) = <cfqueryparam value="#UCASE(ARGUMENTS.pptName)#" cfsqltype="cf_sql_varchar">
    </cfif>
    <cfif ARGUMENTS.ppttID NEQ 0>
    AND ppttID = <cfqueryparam value="#ARGUMENTS.ppttID#" cfsqltype="cf_sql_integer">
    </cfif>
    AND pptStatus IN (<cfqueryparam value="#ARGUMENTS.pptStatus#" list="yes" cfsqltype="cf_sql_integer">)
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsPagePortalTemplate = StructNew()>
    <cfset rsPagePortalTemplate.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsPagePortalTemplate>
    </cffunction>
    
    <cffunction name="getPagePortalTemplateType" access="public" returntype="query" hint="Get Page Portal Template Type data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="ID" type="numeric" required="yes" default="0">
    <cfargument name="excludeID" type="numeric" required="yes" default="0">
    <cfargument name="ppttName" type="string" required="yes" default="">
    <cfargument name="ppttStatus" type="string" required="yes" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="ppttName">
    <cfset var rsPagePortalTemplateType = "" >
    <cftry>
    <cfquery name="rsPagePortalTemplateType" datasource="#application.mcmsDSN#">
    SELECT * FROM v_p_portal_template_type WHERE 0=0
    <cfif ARGUMENTS.ID NEQ 0>
    AND ID = <cfqueryparam value="#ARGUMENTS.ID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.excludeID NEQ 0>
    AND ID <> <cfqueryparam value="#ARGUMENTS.excludeID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(ppttName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(ppttDescription) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">)
    </cfif>
    <cfif ARGUMENTS.ppttName NEQ "">
    AND UPPER(ppttName) = <cfqueryparam value="#UCASE(ARGUMENTS.ppttName)#" cfsqltype="cf_sql_varchar">
    </cfif>
    AND ppttStatus IN (<cfqueryparam value="#ARGUMENTS.ppttStatus#" list="yes" cfsqltype="cf_sql_integer">)
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsPagePortalTemplateType = StructNew()>
    <cfset rsPagePortalTemplateType.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsPagePortalTemplateType>
    </cffunction>
    
    <cffunction name="getPagePortalDocumentRel" access="public" returntype="query" hint="Get Page Portal Document Relationship data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="ID" type="numeric" required="yes" default="0">
    <cfargument name="excludeID" type="numeric" required="yes" default="0">
    <cfargument name="ppID" type="string" required="yes" default="0">
    <cfargument name="docID" type="numeric" required="yes" default="0">
    <cfargument name="ppdrStatus" type="string" required="yes" default="1,3">
    <cfargument name="ppStatus" type="string" required="yes" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="docName">
    <cfset var rsPagePortalDocumentRel = "" >
    <cftry>
    <cfquery name="rsPagePortalDocumentRel" datasource="#application.mcmsDSN#">
    SELECT * FROM v_p_portal_document_rel WHERE 0=0
    <cfif ARGUMENTS.ID NEQ 0>
    AND ID = <cfqueryparam value="#ARGUMENTS.ID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.excludeID NEQ 0>
    AND ID <> <cfqueryparam value="#ARGUMENTS.excludeID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(ppTitle) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(docName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">)
    </cfif>
    <cfif ARGUMENTS.ppID NEQ 0>
    AND ppID IN (<cfqueryparam value="#ARGUMENTS.ppID#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    <cfif ARGUMENTS.docID NEQ 0>
    AND docID = <cfqueryparam value="#ARGUMENTS.docID#" cfsqltype="cf_sql_integer">
    </cfif>
    AND ppdrStatus IN (<cfqueryparam value="#ARGUMENTS.ppdrStatus#" list="yes" cfsqltype="cf_sql_integer">)
    AND ppStatus IN (<cfqueryparam value="#ARGUMENTS.ppStatus#" list="yes" cfsqltype="cf_sql_integer">)
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsPagePortalDocumentRel = StructNew()>
    <cfset rsPagePortalDocumentRel.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsPagePortalDocumentRel>
    </cffunction>
    
    <cffunction name="getPagePortalDepartmentRel" access="public" returntype="query" hint="Get Page Portal Department Relationship data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="ID" type="numeric" required="yes" default="0">
    <cfargument name="excludeID" type="numeric" required="yes" default="0">
    <cfargument name="ppID" type="string" required="yes" default="0">
    <cfargument name="ppParentType" type="string" required="yes" default="0">
    <cfargument name="ppParentID" type="string" required="yes" default="0">
    <cfargument name="deptNo" type="string" required="yes" default="0">
    <cfargument name="ppdrStatus" type="string" required="yes" default="1,3">
    <cfargument name="ppStatus" type="string" required="yes" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="deptName">
    <cfset var rsPagePortalDepartmentRel = "" >
    <cftry>
    <cfquery name="rsPagePortalDepartmentRel" datasource="#application.mcmsDSN#">
    SELECT * FROM v_p_portal_department_rel WHERE 0=0
    <cfif ARGUMENTS.ID NEQ 0>
    AND ID = <cfqueryparam value="#ARGUMENTS.ID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.excludeID NEQ 0>
    AND ID <> <cfqueryparam value="#ARGUMENTS.excludeID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(ppTitle) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(deptName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">)
    </cfif>
    <cfif ARGUMENTS.ppID NEQ 0>
    AND ppID IN (<cfqueryparam value="#ARGUMENTS.ppID#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    <cfif ARGUMENTS.ppParentType NEQ 0>
    AND ppParentType IN (<cfqueryparam value="#ARGUMENTS.ppParentType#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    <cfif ARGUMENTS.ppParentID NEQ 0>
    AND ppParentID IN (<cfqueryparam value="#ARGUMENTS.ppParentID#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    <cfif ARGUMENTS.deptNo NEQ 0>
    AND deptNo IN (<cfqueryparam value="#ARGUMENTS.deptNo#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    AND ppdrStatus IN (<cfqueryparam value="#ARGUMENTS.ppdrStatus#" list="yes" cfsqltype="cf_sql_integer">)
    AND ppStatus IN (<cfqueryparam value="#ARGUMENTS.ppStatus#" list="yes" cfsqltype="cf_sql_integer">)
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsPagePortalDepartmentRel = StructNew()>
    <cfset rsPagePortalDepartmentRel.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsPagePortalDepartmentRel>
    </cffunction>
    
    <cffunction name="getPagePortalDepartmentRelBind" access="remote" returntype="any" hint="Get Page Portal Department Relationship binded data.">
    <cfargument name="ID" type="string" required="yes" default="0">
    <cfargument name="dsn" type="string" required="yes" default="swweb">
    <cfargument name="orderBy" type="string" required="yes" default="deptName">
    <cftry>
    <cfset data = ''>
	  <cfset result = ArrayNew(2)>
    <cfset i = 0>
    <cfquery name="data" datasource="#ARGUMENTS.dsn#">
    SELECT * FROM v_p_portal_department_rel WHERE 0=0
    <cfif ARGUMENTS.ID NEQ 0 AND IsNumeric(ARGUMENTS.ID)>
    AND ppID = <cfqueryparam value="#ARGUMENTS.ID#" cfsqltype="cf_sql_integer">
    <cfelse>
    AND 0=1
    </cfif>
    AND ppdrStatus IN (<cfqueryparam value="1,3" list="yes" cfsqltype="cf_sql_integer">)
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <cfif data.RecordCount NEQ 0>
    <cfloop index="i" from="1" to="#data.RecordCount#">
    <cfif i EQ 1>
    <cfset result[i][1] = ''>
    <cfset result[i][2] = 'Select a Dept. No...'>
    </cfif>
	  <cfset result[i+1][1] = data.deptNo[i]>
    <cfif data.deptName[i] NEQ ''>
    <cfset result[i+1][2] = data.deptName[i]>
    <cfelse>
    <cfset result[i+1][2] = 'All Depts.'>
    </cfif>
    </cfloop>
    </cfif>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsPagePortalDepartmentRelBind = StructNew()>
    <cfset rsPagePortalDepartmentRelBind.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="getPagePortalSiteRel" access="public" returntype="query" hint="Get Page Portal Site Relationship data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="ID" type="numeric" required="yes" default="0">
    <cfargument name="excludeID" type="numeric" required="yes" default="0">
    <cfargument name="ppID" type="string" required="yes" default="0">
    <cfargument name="ppParentType" type="string" required="yes" default="0">
    <cfargument name="ppParentID" type="string" required="yes" default="0">
    <cfargument name="siteNo" type="string" required="yes" default="100">
    <cfargument name="ppsrStatus" type="string" required="yes" default="1,3">
    <cfargument name="ppStatus" type="string" required="yes" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="siteName">
    <cfset var rsPagePortalSiteRel = "" >
    <cftry>
    <cfquery name="rsPagePortalSiteRel" datasource="#application.mcmsDSN#">
    SELECT * FROM v_p_portal_site_rel WHERE 0=0
    <cfif ARGUMENTS.ID NEQ 0>
    AND ID = <cfqueryparam value="#ARGUMENTS.ID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.excludeID NEQ 0>
    AND ID <> <cfqueryparam value="#ARGUMENTS.excludeID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(ppTitle) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(siteName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">)
    </cfif>
    <cfif ARGUMENTS.ppID NEQ 0>
    AND ppID IN (<cfqueryparam value="#ARGUMENTS.ppID#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    <cfif ARGUMENTS.ppParentType NEQ 0>
    AND ppParentType IN (<cfqueryparam value="#ARGUMENTS.ppParentType#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    <cfif ARGUMENTS.ppParentID NEQ 0>
    AND ppParentID IN (<cfqueryparam value="#ARGUMENTS.ppParentID#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    <cfif ARGUMENTS.siteNo NEQ 100>
    AND siteNo IN (<cfqueryparam value="100,#ARGUMENTS.siteNo#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    AND ppsrStatus IN (<cfqueryparam value="#ARGUMENTS.ppsrStatus#" list="yes" cfsqltype="cf_sql_integer">)
    AND ppStatus IN (<cfqueryparam value="#ARGUMENTS.ppStatus#" list="yes" cfsqltype="cf_sql_integer">)
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsPagePortalSiteRel = StructNew()>
    <cfset rsPagePortalSiteRel.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsPagePortalSiteRel>
    </cffunction>
    
    <cffunction name="getPagePortalSiteRelBind" access="remote" returntype="any" hint="Get Page Portal Site Relationship binded data.">
    <cfargument name="ID" type="string" required="yes" default="0">
    <cfargument name="dsn" type="string" required="yes" default="swweb">
    <cfargument name="orderBy" type="string" required="yes" default="siteName">
    <cftry>
    <cfset data = ''>
	  <cfset result = ArrayNew(2)>
    <cfset i = 0>
    <cfquery name="data" datasource="#ARGUMENTS.dsn#">
    SELECT * FROM v_p_portal_site_rel WHERE 0=0
    <cfif ARGUMENTS.ID NEQ 0 AND IsNumeric(ARGUMENTS.ID)>
    AND ppID = <cfqueryparam value="#ARGUMENTS.ID#" cfsqltype="cf_sql_integer">
    <cfelse>
    AND 0=1
    </cfif>
    AND ppsrStatus IN (<cfqueryparam value="1,3" list="yes" cfsqltype="cf_sql_integer">)
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <cfif data.RecordCount NEQ 0>
    <cfloop index="i" from="1" to="#data.RecordCount#">
    <cfif i EQ 1>
    <cfset result[i][1] = ''>
    <cfset result[i][2] = 'Select a Site No...'>
    </cfif>
	  <cfset result[i+1][1] = data.siteNo[i]>
    <cfif data.siteName[i] NEQ ''>
    <cfset result[i+1][2] = data.siteName[i]>
    <cfelse>
    <cfset result[i+1][2] = 'All Sites'>
    </cfif>
    </cfloop>
    </cfif>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsPagePortalSiteRelBind = StructNew()>
    <cfset rsPagePortalSiteRelBind.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="getPagePortalFormAttribute" access="public" returntype="query" hint="Get Page Portal Form Attribute data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="ID" type="numeric" required="yes" default="0">
    <cfargument name="excludeID" type="numeric" required="yes" default="0">
    <cfargument name="ppfaName" type="string" required="yes" default="">
    <cfargument name="pptID" type="numeric" required="yes" default="0">
    <cfargument name="ppfatID" type="numeric" required="yes" default="0">
    <cfargument name="ppfaStatus" type="string" required="yes" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="ppfaSort">
    <cfset var rsPagePortalFormAtribute = "" >
    <cftry>
    <cfquery name="rsPagePortalFormAtribute" datasource="#application.mcmsDSN#">
    SELECT * FROM v_p_portal_form_attribute WHERE 0=0
    <cfif ARGUMENTS.ID NEQ 0>
    AND ID = <cfqueryparam value="#ARGUMENTS.ID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.excludeID NEQ 0>
    AND ID <> <cfqueryparam value="#ARGUMENTS.excludeID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(ppfaName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(ppfaDescription) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">)
    </cfif>
    <cfif ARGUMENTS.ppfaName NEQ "">
    AND UPPER(ppfaName) = <cfqueryparam value="#UCASE(ARGUMENTS.ppfaName)#" cfsqltype="cf_sql_varchar">
    </cfif>
    <cfif ARGUMENTS.pptID NEQ 0>
    AND pptID = <cfqueryparam value="#ARGUMENTS.pptID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.ppfatID NEQ 0>
    AND ppfatID = <cfqueryparam value="#ARGUMENTS.ppfatID#" cfsqltype="cf_sql_integer">
    </cfif>
    AND ppfaStatus IN (<cfqueryparam value="#ARGUMENTS.ppfaStatus#" list="yes" cfsqltype="cf_sql_integer">)
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsPagePortalFormAtribute = StructNew()>
    <cfset rsPagePortalFormAtribute.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsPagePortalFormAtribute>
    </cffunction>
    
    <cffunction name="getPagePortalFormAttributeType" access="public" returntype="query" hint="Get Page Portal Form Attribute Type data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="ID" type="numeric" required="yes" default="0">
    <cfargument name="excludeID" type="numeric" required="yes" default="0">
    <cfargument name="ppfatName" type="string" required="yes" default="">
    <cfargument name="ppfatStatus" type="string" required="yes" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="ppfatSort">
    <cfset var rsPagePortalFormAttributeType = "" >
    <cftry>
    <cfquery name="rsPagePortalFormAttributeType" datasource="#application.mcmsDSN#">
    SELECT * FROM tbl_p_portal_form_attr_type WHERE 0=0
    <cfif ARGUMENTS.ID NEQ 0>
    AND ID = <cfqueryparam value="#ARGUMENTS.ID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.excludeID NEQ 0>
    AND ID <> <cfqueryparam value="#ARGUMENTS.excludeID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(ppfatName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(ppfatDescription) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">)
    </cfif>
    <cfif ARGUMENTS.ppfatName NEQ "">
    AND UPPER(ppfatName) = <cfqueryparam value="#UCASE(ARGUMENTS.ppfatName)#" cfsqltype="cf_sql_varchar">
    </cfif>
    AND ppfatStatus IN (<cfqueryparam value="#ARGUMENTS.ppfatStatus#" list="yes" cfsqltype="cf_sql_integer">)
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsPagePortalFormAttributeType = StructNew()>
    <cfset rsPagePortalFormAttributeType.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsPagePortalFormAttributeType>
    </cffunction>
    
    <cffunction name="getPagePortalFormUser" access="public" returntype="query" hint="Get Page Portal Form User data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="ID" type="numeric" required="yes" default="0">
    <cfargument name="ppID" type="numeric" required="yes" default="0">
    <cfargument name="excludeID" type="numeric" required="yes" default="0">
    <cfargument name="userID" type="numeric" required="yes" default="0">
    <cfargument name="ppfuName" type="string" required="yes" default="">
    <cfargument name="siteNo" type="string" required="yes" default="100">
    <cfargument name="deptNo" type="string" required="yes" default="0">
    <cfargument name="ppfusID" type="string" required="yes" default="0">
    <cfargument name="ppfuDateFrom" type="string" required="yes" default="">
    <cfargument name="ppfuDateTo" type="string" required="yes" default="">
    <cfargument name="ppfuStatus" type="string" required="yes" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="ppfuName">
    <cfset var rsPagePortalFormUser = "" >
    <cftry>
    <cfquery name="rsPagePortalFormUser" datasource="#application.mcmsDSN#">
    SELECT * FROM v_p_portal_form_user WHERE 0=0
    <cfif ARGUMENTS.ID NEQ 0>
    AND ID = <cfqueryparam value="#ARGUMENTS.ID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.ppID NEQ 0>
    AND ppID = <cfqueryparam value="#ARGUMENTS.ppID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.excludeID NEQ 0>
    AND ID <> <cfqueryparam value="#ARGUMENTS.excludeID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(ppfuName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(pptName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(userfname) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(userlname) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">)
    </cfif>
    <cfif ARGUMENTS.userID NEQ 0>
    AND userID = <cfqueryparam value="#ARGUMENTS.userID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.ppfuName NEQ "">
    AND UPPER(ppfuName) = <cfqueryparam value="#UCASE(ARGUMENTS.ppfuName)#" cfsqltype="cf_sql_varchar">
    </cfif>
    <cfif ARGUMENTS.siteNo NEQ 100>
    AND siteNo IN (<cfqueryparam value="#ARGUMENTS.siteNo#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    <cfif ARGUMENTS.deptNo NEQ 0>
    AND deptNo IN (<cfqueryparam value="0,#ARGUMENTS.deptNo#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    <cfif ARGUMENTS.ppfusID NEQ 0>
    AND ppfusID IN (<cfqueryparam value="#ARGUMENTS.ppfusID#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    <cfif ARGUMENTS.ppfuDateFrom NEQ "">
    AND ppfuDate >= <cfqueryparam value="#ARGUMENTS.ppfuDateFrom#" cfsqltype="cf_sql_date">
    </cfif>
    <cfif ARGUMENTS.ppfuDateTo NEQ "">
    AND ppfuDate <= <cfqueryparam value="#ARGUMENTS.ppfuDateTo#" cfsqltype="cf_sql_date">
    </cfif>
    AND ppfuStatus IN (<cfqueryparam value="#ARGUMENTS.ppfuStatus#" list="yes" cfsqltype="cf_sql_integer">)
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsPagePortalFormUser = StructNew()>
    <cfset rsPagePortalFormUser.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsPagePortalFormUser>
    </cffunction>
    
    <cffunction name="getPagePortalFormResult" access="public" returntype="query" hint="Get Page Portal Form Result data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="ID" type="numeric" required="yes" default="0">
    <cfargument name="excludeID" type="numeric" required="yes" default="0">
    <cfargument name="pptID" type="numeric" required="yes" default="0">
    <cfargument name="ppfaID" type="numeric" required="yes" default="0">
    <cfargument name="ppfrValue" type="string" required="yes" default="">
    <cfargument name="ppfuID" type="numeric" required="yes" default="0">
    <cfargument name="ppfrStatus" type="string" required="yes" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="ppfrValue">
    <cfset var rsPagePortalFormResult = "" >
    <cftry>
    <cfquery name="rsPagePortalFormResult" datasource="#application.mcmsDSN#">
    SELECT * FROM v_p_portal_form_result WHERE 0=0
    <cfif ARGUMENTS.ID NEQ 0>
    AND ID = <cfqueryparam value="#ARGUMENTS.ID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.excludeID NEQ 0>
    AND ID <> <cfqueryparam value="#ARGUMENTS.excludeID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.pptID NEQ 0>
    AND pptID = <cfqueryparam value="#ARGUMENTS.pptID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.ppfaID NEQ 0>
    AND ppfaID = <cfqueryparam value="#ARGUMENTS.ppfaID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.ppfrValue NEQ "">
    AND ppfrValue = <cfqueryparam value="#ARGUMENTS.ppfrValue#" cfsqltype="cf_sql_varchar">
    </cfif>
    <cfif ARGUMENTS.ppfuID NEQ 0>
    AND ppfuID = <cfqueryparam value="#ARGUMENTS.ppfuID#" cfsqltype="cf_sql_integer">
    </cfif>
    AND ppfrStatus IN (<cfqueryparam value="#ARGUMENTS.ppfrStatus#" list="yes" cfsqltype="cf_sql_integer">)
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsPagePortalFormResult = StructNew()>
    <cfset rsPagePortalFormResult.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsPagePortalFormResult>
    </cffunction>
    
    <cffunction name="getPagePortalFormWorkflowRel" access="public" returntype="query" hint="Get Page Portal Form Workflow Rel. data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="ID" type="numeric" required="yes" default="0">
    <cfargument name="excludeUserID" type="string" required="yes" default="0">
    <cfargument name="ppID" type="numeric" required="yes" default="0">
    <cfargument name="userID" type="numeric" required="yes" default="0">
    <cfargument name="siteNo" type="string" required="yes" default="100">
    <cfargument name="deptNo" type="string" required="yes" default="0">
    <cfargument name="ppfwfrStatus" type="string" required="yes" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="ppTitle">
    <cfset var rsPagePortalFormWorkflowRel = "" >
    <cftry>
    <cfquery name="rsPagePortalFormWorkflowRel" datasource="#application.mcmsDSN#">
    SELECT * FROM v_p_portal_form_wf_rel WHERE 0=0
    <cfif ARGUMENTS.ID NEQ 0>
    AND ID = <cfqueryparam value="#ARGUMENTS.ID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.excludeUserID NEQ 0>
    AND userID NOT IN (<cfqueryparam value="#ARGUMENTS.excludeUserID#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(ppTitle) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(userfName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(userlName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">)
    </cfif>
    <cfif ARGUMENTS.ppID NEQ 0>
    AND ppID = <cfqueryparam value="#ARGUMENTS.ppID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.userID NEQ 0>
    AND userID = <cfqueryparam value="#ARGUMENTS.userID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.siteNo NEQ 100>
    AND siteNo IN (<cfqueryparam value="#ARGUMENTS.siteNo#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    <cfif ARGUMENTS.deptNo NEQ 0>
    AND deptNo IN (<cfqueryparam value="0,#ARGUMENTS.deptNo#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    AND ppfwfrStatus IN (<cfqueryparam value="#ARGUMENTS.ppfwfrStatus#" list="yes" cfsqltype="cf_sql_integer">)
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsPagePortalFormWorkflowRel = StructNew()>
    <cfset rsPagePortalFormWorkflowRel.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsPagePortalFormWorkflowRel>
    </cffunction>
    
    <cffunction name="getPagePortalFormWorkflowStatus" access="public" returntype="query" hint="Get Page Portal Form Workflow Status data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="ID" type="numeric" required="yes" default="0">
    <cfargument name="excludeID" type="numeric" required="yes" default="0">
    <cfargument name="ppfwfsStatus" type="string" required="yes" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="ppfwfsName">
    <cfset var rsPagePortalFormWorkflowStatus = "" >
    <cftry>
    <cfquery name="rsPagePortalFormWorkflowStatus" datasource="#application.mcmsDSN#">
    SELECT * FROM tbl_p_portal_form_wf_status WHERE 0=0
    <cfif ARGUMENTS.ID NEQ 0>
    AND ID = <cfqueryparam value="#ARGUMENTS.ID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.excludeID NEQ 0>
    AND ID <> <cfqueryparam value="#ARGUMENTS.excludeID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND UPPER(ppfwfsName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">
    </cfif>
    AND ppfwfsStatus IN (<cfqueryparam value="#ARGUMENTS.ppfwfsStatus#" list="yes" cfsqltype="cf_sql_integer">)
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsPagePortalFormWorkflowStatus = StructNew()>
    <cfset rsPagePortalFormWorkflowStatus.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsPagePortalFormWorkflowStatus>
    </cffunction>
    
    <cffunction name="getPagePortalWorkflowStatus" access="public" returntype="query" hint="Get Page Portal Workflow Status data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="ID" type="numeric" required="yes" default="0">
    <cfargument name="excludeID" type="numeric" required="yes" default="0">
    <cfargument name="ppfwfsID" type="numeric" required="yes" default="0">
    <cfargument name="userID" type="numeric" required="yes" default="0">
    <cfargument name="ppfuID" type="numeric" required="yes" default="0">
    <cfargument name="ppwfsStatus" type="string" required="yes" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="userID">
    <cfset var rsPagePortalWorkflowStatus = "" >
    <cftry>
    <cfquery name="rsPagePortalWorkflowStatus" datasource="#application.mcmsDSN#">
    SELECT * FROM tbl_p_portal_wf_status WHERE 0=0
    <cfif ARGUMENTS.ID NEQ 0>
    AND ID = <cfqueryparam value="#ARGUMENTS.ID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.excludeID NEQ 0>
    AND ID <> <cfqueryparam value="#ARGUMENTS.excludeID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.ppfuID NEQ 0>
    AND ppfuID = <cfqueryparam value="#ARGUMENTS.ppfuID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.userID NEQ 0>
    AND userID = <cfqueryparam value="#ARGUMENTS.userID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.ppfwfsID NEQ 0>
    AND ppfwfsID = <cfqueryparam value="#ARGUMENTS.ppfwfsID#" cfsqltype="cf_sql_integer">
    </cfif>
    AND ppwfsStatus IN (<cfqueryparam value="#ARGUMENTS.ppwfsStatus#" list="yes" cfsqltype="cf_sql_integer">)
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsPagePortalWorkflowStatus = StructNew()>
    <cfset rsPagePortalWorkflowStatus.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsPagePortalWorkflowStatus>
    </cffunction>
    
    <cffunction name="getPagePortalFormUserStatus" access="public" returntype="query" hint="Get Page Portal Form User Status data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="ID" type="numeric" required="yes" default="0">
    <cfargument name="excludeID" type="numeric" required="yes" default="0">
    <cfargument name="ppfusStatus" type="string" required="yes" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="ppfusSort">
    <cfset var rsPagePortalFormUserStatus = "" >
    <cftry>
    <cfquery name="rsPagePortalFormUserStatus" datasource="#application.mcmsDSN#">
    SELECT * FROM tbl_p_portal_form_user_status WHERE 0=0
    <cfif ARGUMENTS.ID NEQ 0>
    AND ID = <cfqueryparam value="#ARGUMENTS.ID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.excludeID NEQ 0>
    AND ID <> <cfqueryparam value="#ARGUMENTS.excludeID#" cfsqltype="cf_sql_integer">
    </cfif>
    AND ppfusStatus IN (<cfqueryparam value="#ARGUMENTS.ppfusStatus#" list="yes" cfsqltype="cf_sql_integer">)
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsPagePortalFormUserStatus = StructNew()>
    <cfset rsPagePortalFormUserStatus.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsPagePortalFormUserStatus>
    </cffunction>
    
    <cffunction name="getPagePortalReport" access="public" returntype="query" hint="Get Page Portal Report data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="orderBy" type="string" required="yes" default="ppSort">
    <cfset var rsPagePortalReport = "" >
    <cftry>
    <cfquery name="rsPagePortalReport" datasource="#application.mcmsDSN#">
    SELECT ppTitle AS Title, DECODE(ppParentType, 1, 'Yes', 'No') AS Parent, TO_CHAR(ppContent) AS Content, ppMeta AS Meta, pptName AS Layout_Name, netName AS Network, TO_CHAR(ppDate,'MM/DD/YYYY') AS Page_Date, TO_CHAR(ppDateUpdate,'MM/DD/YYYY') AS Page_Date_Update, sortName AS Sort, sName AS Status FROM v_page_portal WHERE 0=0
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(ppTitle) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(ppContent) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">)
    </cfif>
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsPagePortalReport = StructNew()>
    <cfset rsPagePortalReport.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsPagePortalReport>
    </cffunction>
    
    <cffunction name="getPagePortalTemplateTypeReport" access="public" returntype="query" hint="Get Page Portal Template Type Report data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="orderBy" type="string" required="yes" default="ppttName">
    <cfset var rsPagePortalTemplateTypeReport = "" >
    <cftry>
    <cfquery name="rsPagePortalTemplateTypeReport" datasource="#application.mcmsDSN#">
    SELECT ppttName AS Name, ppttDescription AS Description, sortName AS Sort, sName AS Status FROM v_p_portal_template_type WHERE 0=0
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND UPPER(ppttName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">
    </cfif>
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsPagePortalTemplateTypeReport = StructNew()>
    <cfset rsPagePortalTemplateTypeReport.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsPagePortalTemplateTypeReport>
    </cffunction>
    
    <cffunction name="getPagePortalApproverReport" access="public" returntype="query" hint="Get Page Portal Approver Report data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="orderBy" type="string" required="yes" default="userfname">
    <cfset var rsPagePortalApproverReport = "" >
    <cftry>
    <cfquery name="rsPagePortalApproverReport" datasource="#application.mcmsDSN#">
    SELECT DECODE(deptName, NULL, 'All Depts.', deptName) AS Department, userfname || ' ' || userlname AS Approver, sName AS Status FROM v_p_portal_approver WHERE 0=0
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(userfname) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(userlname) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(deptName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">)
    </cfif>
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsPagePortalApproverReport = StructNew()>
    <cfset rsPagePortalApproverReport.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsPagePortalApproverReport>
    </cffunction>
    
    <cffunction name="getPagePortalTemplateReport" access="public" returntype="query" hint="Get Page Portal Template Report data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="orderBy" type="string" required="yes" default="pptName">
    <cfset var rsPagePortalTemplateReport = "" >
    <cftry>
    <cfquery name="rsPagePortalTemplateReport" datasource="#application.mcmsDSN#">
    SELECT pptName AS Name, pptDescription AS Description, pptFile AS Template_File, imgFile AS Image, sName AS Status FROM v_p_portal_template WHERE 0=0
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(pptName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(pptDescription) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">)
    </cfif>
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsPagePortalTemplateReport = StructNew()>
    <cfset rsPagePortalTemplateReport.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsPagePortalTemplateReport>
    </cffunction>
    
    <cffunction name="getPagePortalFormAttributeReport" access="public" returntype="query" hint="Get Page Portal Form Attribute Report data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="orderBy" type="string" required="yes" default="ppfaName">
    <cfset var rsPagePortalFormAttributeReport = "" >
    <cftry>
    <cfquery name="rsPagePortalFormAttributeReport" datasource="#application.mcmsDSN#">
    SELECT ppfaName AS Name, ppfaDescription AS Description, pptName AS Template, ppfaValue AS Attribute_Value, ppfaOption AS Attribute_Option, ppfaSize AS Attribute_Size, ppfaMaxLength AS Max_Length, ppfaRequired AS Required, ppfaMessage AS Message, ppfatName AS Attribute_Type, ppfaRegex AS Regex, ppfaValidate AS Attribute_Validate, ppfaToolTip AS Tool_Tip, ppfaConfirmValue AS Confirm_Value, ppfaSelected AS Selected, ppfaArgs AS Args, TO_CHAR(ppfaDate,'MM/DD/YYYY') AS Attribute_Date, sortName AS Sort, sName AS Status FROM v_p_portal_form_attribute WHERE 0=0
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(ppfaName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(ppfaDescription) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">)
    </cfif>
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsPagePortalFormAttributeReport = StructNew()>
    <cfset rsPagePortalFormAttributeReport.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsPagePortalFormAttributeReport>
    </cffunction>
    
    <cffunction name="getPagePortalFormWorkFlowRelReport" access="public" returntype="query" hint="Get Page Portal Form Workflow Rel. Report data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="orderBy" type="string" required="yes" default="ppTitle">
    <cfset var rsPagePortalFormWorkFlowReport = "" >
    <cftry>
    <cfquery name="rsPagePortalFormWorkFlowReport" datasource="#application.mcmsDSN#">
    SELECT ppTitle AS Form, userlName || ' ' || userlName AS Supervisor_User, siteName AS Site, deptName AS Dept, sName AS Status FROM v_p_portal_form_wf_rel WHERE 0=0
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(ppTitle) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(userfName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">) OR UPPER(userlName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">)
    </cfif>
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsPagePortalFormWorkFlowReport = StructNew()>
    <cfset rsPagePortalFormWorkFlowReport.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsPagePortalFormWorkFlowReport>
    </cffunction>
    
    <cffunction name="getPagePortalFormUserReport" access="public" returntype="query" hint="Get Page Portal Form User Report data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="siteNo" type="string" required="yes" default="100">
    <cfargument name="deptNo" type="string" required="yes" default="0">
    <cfargument name="args" type="string" required="yes" default="0">
    <cfargument name="orderBy" type="string" required="yes" default="ppTitle">
    <cfset var rsPagePortalFormUserReport = "" >
    <cftry>
    <cfquery name="rsPagePortalFormUserReport" datasource="#application.mcmsDSN#">
    SELECT pptName AS Form_Name, ppfuName AS User_Name, siteName AS Site, deptName AS Department, ppfusName AS Status FROM v_p_portal_form_user WHERE 0=0
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(ppfuName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(pptName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(userfname) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(userlname) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">)
    </cfif>
    <cfif ARGUMENTS.siteNo NEQ 100>
    AND siteNo IN (<cfqueryparam value="#ARGUMENTS.siteNo#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    <cfif ARGUMENTS.deptNo NEQ 0>
    AND deptNo IN (<cfqueryparam value="#ARGUMENTS.deptNo#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    <cfif ARGUMENTS.args NEQ 0>
    <cfif ListGetAt(ARGUMENTS.args, 1) NEQ 0>
    AND ppfuDate >= <cfqueryparam value="#ListGetAt(ARGUMENTS.args, 1)#" list="yes" cfsqltype="cf_sql_date">
    </cfif>
    <cfif ListGetAt(ARGUMENTS.args, 2) NEQ 0>
    AND ppfuDate <= <cfqueryparam value="#ListGetAt(ARGUMENTS.args, 2)#" list="yes" cfsqltype="cf_sql_date">
    </cfif>
    <cfif ListGetAt(ARGUMENTS.args, 3) NEQ 0>
    AND ppfusID <= <cfqueryparam value="#ListGetAt(ARGUMENTS.args, 3)#" list="yes" cfsqltype="cf_sql_integer">
    </cfif>
    </cfif>
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsPagePortalFormUserReport = StructNew()>
    <cfset rsPagePortalFormUserReport.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsPagePortalFormUserReport>
    </cffunction>
    
    <cffunction name="setPagePortalForm" access="public" returntype="string" hint="Set the Page Portal Form.">
    <cfargument name="pptID" type="numeric" required="yes" default="0">
    <cfargument name="ppfuID" type="numeric" required="no" default="99">
    <cfargument name="ppfPreview" type="numeric" required="yes" default="false">
    <cfargument name="ppResultMessage" type="string" required="yes" default="">
    <cfset var ppForm = "">
    <cftry>
    <cfsavecontent variable="ppForm">
    <cfinvoke 
    component="cfc.p_portal"
    method="getPagePortalFormAttribute"
    returnvariable="getPagePortalFormAttributeRet">
    <cfinvokeargument name="pptID" value="#ARGUMENTS.pptID#"/>
    <cfinvokeargument name="ppfaStatus" value="1"/>
    </cfinvoke>
    <cfinvoke 
    component="cfc.p_portal"
    method="getPagePortalTemplate"
    returnvariable="getPagePortalTemplateRet">
    <cfinvokeargument name="ID" value="#ARGUMENTS.pptID#"/>
    <cfinvokeargument name="pptStatus" value="1"/>
    </cfinvoke>
    <cfif getPagePortalFormAttributeRet.recordCount EQ 0 OR getPagePortalTemplateRet.recordCount EQ 0>
    <div id="required" align="center">There are presently no active form templates and/or form attributes.</div>
    <cfelse>
    <!--- Override full site list with the list provided when adding or updating the template. --->
    <cfinvoke 
    component="MCMS.component.app.site.Site"
    method="getSite"
    returnvariable="getSiteRet">
    <cfinvokeargument name="siteNo" value="#Iif(getPagePortalTemplateRet.pptSiteNoList NEQ '', DE(getPagePortalTemplateRet.pptSiteNoList), DE(100))#"/>
    <cfinvokeargument name="stID" value="1"/>
    <cfinvokeargument name="siteStatus" value="1"/>
    <cfinvokeargument name="orderBy" value="siteName"/>
    </cfinvoke>
    <!--- Override full department list with the list provided when adding or updating the template. --->
    <cfinvoke 
    component="MCMS.component.app.department.Department"
    method="getDepartment"
    returnvariable="getDepartmentRet">
    <cfinvokeargument name="deptNo" value="#Iif(getPagePortalTemplateRet.pptDeptNoList NEQ '', DE(getPagePortalTemplateRet.pptDeptNoList), DE(0))#"/>
    <cfinvokeargument name="deptStatus" value="1"/>
    <cfinvokeargument name="orderBy" value="deptName"/>
    </cfinvoke>
    <cfinvoke 
    component="cfc.p_portal"
    method="getPagePortalFormUser"
    returnvariable="getPagePortalFormUserRet">
    <cfinvokeargument name="ID" value="#ARGUMENTS.ppfuID#"/>
    <cfinvokeargument name="ppfuStatus" value="1"/>
    </cfinvoke>
    <cfif IsDefined('result.message') AND result.message NEQ "">
    <div id="mcmsMessage"><cfoutput>#result.message#</cfoutput></div>
    </cfif>
    <div id="valMessage"></div>
    <cfform name="pagePortalForm" id="pagePortalForm" preservedata="no">
    <cfinput name="pptID" type="hidden" value="#ARGUMENTS.pptID#" />
    <cfinput name="ppfuID" type="hidden" value="#ARGUMENTS.ppfuID#" />
    <cfinput name="pptFormProcess" type="hidden" value="#getPagePortalTemplateRet.pptFormProcess#" />
    <table id="mainTable">
    <tr>
    <td colspan="2">Fields marked with <span id="required">*</span> are required.</td>
    </tr>
    <tr>
    <!--- If this is being displayed as an update form pull in page portal form user values. --->
    <td valign="top">
    <label id="ppFormLabel">Name: <span id="required">*</span></label>
    <cfinput type="text" name="ppfuName" id="ppfuName" size="32" maxlength="32" required="yes" message="Please enter your name." title="Your Name" value="#Iif(getPagePortalFormUserRet.ppfuName NEQ '', DE(getPagePortalFormUserRet.ppfuName), DE(''))#">
    <!--- Hide the Site No field if it was set to 0 when the template was inserted or updated. --->
    <td<cfif getPagePortalTemplateRet.pptSiteNoField EQ 0>style="display:none"</cfif>>
    <label id="ppFormLabel">Site: <span id="required">*</span></label>
    <!--- If this is being displayed as an update form pull in page portal form user values. --->
    <cfselect name="siteNo" id="siteNo" title="Site No" required="yes" message="Please select a Site.">
    <option value="">Select a Site No...</option>
    <cfoutput query="getSiteRet">
    <option value="#siteNo#" <cfif getPagePortalFormUserRet.siteNo EQ siteNo>selected</cfif>>(#siteNo#) #siteName#</option>
    </cfoutput> 
    </cfselect>
    </td>
    <!--- Hide the Department field if it was set to 0 when the template was inserted or updated. ---> 
    <td<cfif getPagePortalTemplateRet.pptDeptNoField EQ 0>style="display:none"</cfif>>
    <label id="ppFormLabel">Department: <span id="required">*</span></label>
    <!--- If this is being displayed as an update form pull in page portal form user values. --->
    <cfselect name="deptNo" id="deptNo" title="Department" required="yes" message="Please select a Department.">
    <option value="">Select a Dept. No...</option>
    <cfoutput query="getDepartmentRet"> 
    <option value="#deptNo#" <cfif getPagePortalFormUserRet.deptNo EQ deptNo>selected</cfif>>(#deptNo#) #deptName#</option>
    </cfoutput> 
    </cfselect>
    </td>
    </tr>  
    <!---Create counter for rows and build dynamic questions.--->
    <cfset thisRow = 0>
    <cfoutput query="getPagePortalFormAttributeRet">
    <cfset thisRow = thisRow+1>
    <cfinput name="ppfaID#thisRow#" id="ppfaID#thisRow#" type="hidden" value="#ID#">
    <cfinput name="rowCount" id="rowCount" type="hidden" value="#thisRow#">
    <cfinvoke 
    component="cfc.p_portal"
    method="getPagePortalFormResult"
    returnvariable="getPagePortalFormResultRet">
    <cfinvokeargument name="pptID" value="#ARGUMENTS.pptID#"/>
    <cfinvokeargument name="ppfaID" value="#ID#"/>
    <cfinvokeargument name="ppfuID" value="#ARGUMENTS.ppfuID#"/>
    <cfinvokeargument name="ppfrStatus" value="1"/>
    </cfinvoke>
    <cfinput name="ppfrID#thisRow#" id="ppfrID#thisRow#" type="hidden" value="#getPagePortalFormResultRet.ID#">
    <tr>
    <td>
    <label id="ppFormLabel">#thisRow#) #ppfaName# <cfif ppfaRequired EQ 1><span id="required">*</span></cfif></label>
    <!--- This determines the type of element to be displayed. --->
    <div id="ppFormQuestion">
    <cfswitch expression="#ppfatID#">
    <!--- date --->
    <cfcase value="2">
    <!--- If this is being displayed as an update form pull in page portal form result values. --->
    <!--- maxlength cannot be set to 0, so when blank defaulting to 10. --->
    <cfinput type="datefield" name="pa#thisRow#" id="pa#thisRow#" size="#ppfaSize#" maxlength="#Iif(ppfaMaxLength EQ 0, 10, ppfaMaxLength)#" required="#ppfaRequired#" message="#ppfaMessage#" validate="#ppfaValidate#" pattern="#ppfaRegex#" onFocus="this.value =''" value="#getPagePortalFormResultRet.ppfrValue#" title="#ppfaToolTip#">
    &nbsp;<span class="small">i.e. '#application.dateFormat#'
    </cfcase>
    <!--- select --->
    <cfcase value="3">
    <cfselect name="pa#thisRow#" id="pa#thisRow#" required="#ppfaRequired#" message="#ppfaMessage#" title="#ppfaToolTip#">
    <!--- Sync up value and option lists in a drop down menu. --->
    <cfset x = 1>
    <cfloop list="#ppfaOption#" index="i">
    <!--- If this is being displayed as an update form pull in page portal form result values. --->
    <option value="#ListGetAt(ppfaValue, x)#" <cfif i EQ getPagePortalFormResultRet.ppfrValue OR i EQ ppfaSelected>selected</cfif>>#i#</option>
    <cfset x = x + 1>
    </cfloop>
    </cfselect>
    </cfcase>
    <!--- radio (yes/no) --->
    <cfcase value="4">
    <!--- If this is being displayed as an update form pull in page portal form result values. --->
    <cfinput type="radio" name="pa#thisRow#" id="pa#thisRow#" value="yes" border="0" class="checkbox" required="#ppfaRequired#" message="#ppfaMessage#" checked="#Iif(getPagePortalFormResultRet.ppfrValue EQ 'yes', DE('true'), DE('false'))#" title="#ppfaToolTip#"/>Yes&nbsp;&nbsp;<cfinput type="radio" name="pa#thisRow#" id="pa#thisRow#" value="no" class="checkbox" required="#ppfaRequired#" message="#ppfaMessage#" checked="#Iif(getPagePortalFormResultRet.ppfrValue EQ 'no', DE('true'), DE('false'))#" title="#ppfaToolTip#"/>No
    </cfcase>
    <!--- radio (true/false) --->
    <cfcase value="5">
    <!--- If this is being displayed as an update form pull in page portal form result values. --->
    <cfinput type="radio" name="pa#thisRow#" id="pa#thisRow#" value="true" border="0" class="checkbox" required="#ppfaRequired#" message="#ppfaMessage#" checked="#Iif(getPagePortalFormResultRet.ppfrValue EQ 'true', DE('true'), DE('false'))#" title="#ppfaToolTip#"/>True&nbsp;&nbsp;<cfinput type="radio" name="pa#thisRow#" id="pa#thisRow#" value="false" class="checkbox" required="#ppfaRequired#" message="#ppfaMessage#" checked="#Iif(getPagePortalFormResultRet.ppfrValue EQ 'false', DE('true'), DE('false'))#" title="#ppfaToolTip#"/>False
    </cfcase>
    <!--- multi select --->
    <cfcase value="6">
    <!--- If this is being displayed as an update form pull in page portal form result values. --->
    <cfselect name="pa#thisRow#" id="pa#thisRow#" required="#ppfaRequired#" message="#ppfaMessage#" multiple="yes" title="#ppfaToolTip#">
    <!--- Sync up value and option lists in a drop down menu. --->
    <cfset x = 1>
    <cfloop list="#ppfaOption#" index="i">
    <!--- Select those elements in the comma separated list when displayed as an update form. --->
    <cfset selected = false>
    <cfloop list="#getPagePortalFormResultRet.ppfrValue#" index="a">
    <cfif i EQ a>
    <cfset selected = true>
    </cfif>
    </cfloop>
    <option value="#ListGetAt(ppfaValue, x)#" <cfif selected EQ "true" OR i EQ ppfaSelected>selected</cfif>>#i#</option>
    <cfset x = x + 1>
    </cfloop>
    </cfselect>
    </cfcase>
    <cfdefaultcase>
    <!--- If this is being displayed as an update form pull in page portal form result values. --->
    <!--- maxlength cannot be set to 0, so when blank defaulting to 10. --->
    <cfinput type="text" name="pa#thisRow#" id="pa#thisRow#" size="#ppfaSize#" maxlength="#Iif(ppfaMaxLength EQ 0, 10, ppfaMaxLength)#" required="#ppfaRequired#" message="#ppfaMessage#" validate="#ppfaValidate#" pattern="#ppfaRegex#" value="#getPagePortalFormResultRet.ppfrValue#" title="#ppfaToolTip#">
    <!--- Display field again and validate that the values match. --->
    <cfif ppfaConfirmValue EQ 1>
    <label id="ppFormLabel" style="margin-left:-15px; margin-top:8px;">#thisRow#b) Confirm #ppfaName# <cfif ppfaRequired EQ 1><span id="required">*</span></cfif></label>
    <cfinput type="text" name="confirmValue#thisRow#" id="confirmValue#thisRow#" size="#ppfaSize#" maxlength="#Iif(ppfaMaxLength EQ 0, 10, ppfaMaxLength)#" value="#getPagePortalFormResultRet.ppfrValue#" onBlur="valConfirmFields('#ppfaName#', 'pa#thisRow#', 'confirmValue#thisRow#', #ppfaSize#)">
    </cfif>
    </cfdefaultcase>
    </cfswitch>
    </div>
    </td>
    </tr>
    </cfoutput>
    <!--- Do not show the submit button when in preview mode. --->
    <tr>
    <td colspan="3" id="mcmsFormFooter">
    <!---Send the result message.--->
    <cfinput type="hidden" name="ppResultMessage" id="ppResultMessage" value="#ARGUMENTS.ppResultMessage#">
    <cfif ARGUMENTS.ppfPreview EQ false>
    <cfinput type="submit" name="mcmsInsert" id="mcmsInsert" value="Submit" />
    <cfelse>
    <cfinput type="submit" name="mcmsInsert" id="mcmsInsert" value="Submit" disabled />
    </cfif>
    </td>
    </tr>
    </table>
    </cfform>
    </cfif>
    </cfsavecontent>
    <!---Catch any errors.--->
    <cfcatch type="any">
    There was an error with the setPagePortalForm function.
    <cfdump var="#CFCATCH#">
    </cfcatch>
    </cftry>
    <cfreturn ppForm>
    </cffunction>
    
    <cffunction name="insertPagePortal" access="public" returntype="struct">
    <cfargument name="ppTitle" type="string" required="yes">
    <cfargument name="ppContent" type="string" required="yes">
    <cfargument name="ppMeta" type="string" required="yes">
    <cfargument name="ppResultMessage" type="string" required="yes">
    <cfargument name="pptID" type="numeric" required="yes">
    <cfargument name="userIP" type="string" required="yes">
    <cfargument name="netID" type="numeric" required="yes">
    <cfargument name="ppDateExp" type="date" required="yes">
    <cfargument name="userID" type="numeric" required="yes">
    <cfargument name="ppParentType" type="numeric" required="yes">
    <cfargument name="ppParentID" type="numeric" required="yes">
    <cfargument name="ppSort" type="numeric" required="yes">
    <cfargument name="ppStatus" type="numeric" required="yes">
    <!---Relationship arguments.--->
    <cfargument name="siteNo" type="string" required="yes">
    <cfargument name="deptNo" type="string" required="yes">
    <cfset result.message = "">
    <cfset result.ppID = "">
    <cftry>
    <!---Check for profanity in the text.--->
    <cfinvoke 
    component="MCMS.component.utility.Regex"
    method="regexProfanity"
    returnvariable="regexProfanityRet">
    <cfinvokeargument name="profanityString" value="#ARGUMENTS.ppContent#"/>
    </cfinvoke>
    <!---Check for a duplicate record.--->
    <cfinvoke 
    component="cfc.p_portal"
    method="getPagePortal"
    returnvariable="getCheckPagePortalRet">
    <cfinvokeargument name="ppTitle" value="#ARGUMENTS.ppTitle#"/>
    <cfinvokeargument name="userID" value="#ARGUMENTS.userID#"/>
    <cfinvokeargument name="ppStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckPagePortalRet.recordcount NEQ 0>
    <cfset result.message = "The title #ARGUMENTS.ppTitle# already exist, please enter a new title.">
    <cfelseif regexProfanityRet CONTAINS '$%&*!'>
    <cfset result.message = "Some text contained profanity, please remove any profanity from your text.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    INSERT INTO tbl_page_portal (ppTitle,ppContent,ppMeta,ppResultMessage,pptID,userIP,netID,ppDateExp,userID,ppParentType,ppParentID,ppSort,ppStatus) VALUES
    (
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.ppTitle#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.ppContent#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.ppMeta#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.ppResultMessage#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.pptID#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.userIP#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.netID#">,
    <cfqueryparam cfsqltype="cf_sql_date" value="#ARGUMENTS.ppDateExp#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.userID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ppParentType#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ppParentID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ppSort#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ppStatus#">
    )
    </cfquery>
    </cftransaction>
    <!--- Get newly inserted page ID. --->
    <cfinvoke 
    component="MCMS.component.cms.Cms"
    method="getMaxValueSQL"
    returnvariable="ppID">
    <cfinvokeargument name="tableName" value="tbl_page_portal"/>
    </cfinvoke>
    <cfset var.ppID = ppID>
    <!---Create site relationships.--->
    <cfloop index="siteNo" list="#ARGUMENTS.siteNo#">
    <cfinvoke 
    component="cfc.p_portal"
    method="insertPagePortalSiteRel"
    returnvariable="insertPagePortalSiteRelRet">
    <cfinvokeargument name="ppID" value="#var.ppID#"/>
    <cfinvokeargument name="siteNo" value="#ARGUMENTS.siteNo#"/>
    <cfinvokeargument name="ppsrStatus" value="1"/>
    </cfinvoke>
    </cfloop>
    <!---Setting another variable given ARGUMENTS.deptNo is changed.--->
    <cfset var.deptNoList = ARGUMENTS.deptNo>
    <!---Create department relationships.--->
    <cfloop index="deptNo" list="#ARGUMENTS.deptNo#">
    <cfinvoke 
    component="cfc.p_portal"
    method="insertPagePortalDepartmentRel"
    returnvariable="insertPagePortalDepartmentRelRet">
    <cfinvokeargument name="ppID" value="#var.ppID#"/>
    <cfinvokeargument name="deptNo" value="#ARGUMENTS.deptNo#"/>
    <cfinvokeargument name="ppdrStatus" value="1"/>
    </cfinvoke>
    </cfloop>
    </cfif>
    <cfinvoke 
    component="cfc.p_portal"
    method="getPagePortalApprover"
    returnvariable="getPagePortalApproverRet">
    <cfinvokeargument name="deptNo" value="#var.deptNoList#"/>
    <cfinvokeargument name="ppaStatus" value="1"/>
    </cfinvoke>
    <cfset var.emailList = ValueList(getPagePortalApproverRet.userEmail)>
    <!---Send an email to the approver for each selected department.--->
    <cfloop index="userEmail" list="#var.emailList#">
    <cfinvoke 
    component="MCMS.component.utility.Email"
    method="sendEmail">
    <cfinvokeargument name="subject" value="#application.companyName# - Page Portal"/>
    <cfinvokeargument name="to" value="#userEmail#"/>
    <cfinvokeargument name="from" value="#application.noReplyEmail#"/>
    <cfinvokeargument name="body" value=""/>
    <cfinvokeargument name="ID" value="#var.ppID#"/>
    <cfinvokeargument name="emailTemplate" value="/#application.mcmsAppAdminPath#/p_portal/view/inc_p_portal_email_template.cfm"/>
    </cfinvoke>
    </cfloop>
    <cfset result.ppID = var.ppID>
    <cfcatch type="any">
    <cfset result.message = "There was an error inserting the record.">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="insertPagePortalApprover" access="public" returntype="struct">
    <cfargument name="userID" type="numeric" required="yes">
    <cfargument name="deptNo" type="numeric" required="yes">
    <cfargument name="ppaStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully inserted the record.">
    <cftry>
    <!---Check for a duplicate record.--->
    <cfinvoke 
    component="cfc.p_portal"
    method="getPagePortalApprover"
    returnvariable="getCheckPagePortalApproverRet">
    <cfinvokeargument name="userID" value="#ARGUMENTS.userID#"/>
    <cfinvokeargument name="deptNo" value="#ARGUMENTS.deptNo#"/>
    <cfinvokeargument name="ppaStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckPagePortalApproverRet.recordcount NEQ 0>
    <cfset result.message = "The page portal approver relationship already exists, please try again.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    INSERT INTO tbl_p_portal_approver (userID,deptNo,ppaStatus) VALUES
    (
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.userID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.deptNo#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ppaStatus#">
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
    
    <cffunction name="insertPagePortalTemplate" access="public" returntype="struct">
    <cfargument name="pptName" type="string" required="yes">
    <cfargument name="pptDescription" type="string" required="yes">
    <cfargument name="pptFile" type="string" required="yes">
    <cfargument name="imgID" type="numeric" required="yes">
    <cfargument name="ppttID" type="numeric" required="yes">
    <cfargument name="pptFormProcess" type="string" required="yes">
    <cfargument name="pptEmail" type="string" required="yes">
    <cfargument name="pptDocument" type="numeric" required="yes">
    <cfargument name="pptEncrypt" type="numeric" required="yes">
    <cfargument name="pptEncryptPassword" type="string" required="yes">
    <cfargument name="pptSiteNoField" type="numeric" required="yes">
    <cfargument name="pptDeptNoField" type="numeric" required="yes">
    <cfargument name="pptDeptNoList" type="string" required="yes">
    <cfargument name="pptSiteNoList" type="string" required="yes">
    <cfset result.message = "You have successfully inserted the record.">
    <cftry>
    <!---Check for profanity in the text.--->
    <cfinvoke 
    component="MCMS.component.utility.Regex"
    method="regexProfanity"
    returnvariable="regexProfanityRet">
    <cfinvokeargument name="profanityString" value="#ARGUMENTS.pptDescription#"/>
    </cfinvoke>
    <!---Check for a duplicate record.--->
    <cfinvoke 
    component="cfc.p_portal"
    method="getPagePortalTemplate"
    returnvariable="getCheckPagePortalTemplateRet">
    <cfinvokeargument name="pptName" value="#ARGUMENTS.pptName#"/>
    <cfinvokeargument name="pptStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckPagePortalTemplateRet.recordcount NEQ 0>
    <cfset result.message = "The name #ARGUMENTS.pptName# already exists, please enter a new name.">
    <cfelseif regexProfanityRet CONTAINS '$%&*!'>
    <cfset result.message = "Some text contained profanity, please remove any profanity from your text.">
    <!---Check length restriction.--->
    <cfelseif LEN(ARGUMENTS.pptDescription) GT 255>
    <cfset result.message = "The description is longer than 255 characters, please enter a new description under 255 characters.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    INSERT INTO tbl_p_portal_template (pptName,pptDescription,pptFile,imgID,ppttID,pptFormProcess,pptEmail,pptDocument,pptEncrypt,pptEncryptPassword,pptSiteNoField,pptDeptNoField,pptDeptNoList,pptSiteNoList,pptStatus) VALUES
    (
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.pptName#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.pptDescription#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.pptFile#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.imgID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ppttID#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.pptFormProcess#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.pptEmail#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.pptDocument#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.pptEncrypt#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.pptEncryptPassword#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.pptSiteNoField#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.pptDeptNoField#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.pptDeptNoList#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.pptSiteNoList#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.pptStatus#">
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
    
    <cffunction name="insertPagePortalTemplateType" access="public" returntype="struct">
    <cfargument name="ppttName" type="string" required="yes">
    <cfargument name="ppttDescription" type="string" required="yes">
    <cfargument name="ppttSort" type="numeric" required="yes">
    <cfargument name="ppttStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully inserted the record.">
    <cftry>
    <!---Check for profanity in the text.--->
    <cfinvoke 
    component="MCMS.component.utility.Regex"
    method="regexProfanity"
    returnvariable="regexProfanityRet">
    <cfinvokeargument name="profanityString" value="#ARGUMENTS.ppttDescription#"/>
    </cfinvoke>
    <!---Check for a duplicate record.--->
    <cfinvoke 
    component="cfc.p_portal"
    method="getPagePortalTemplateType"
    returnvariable="getCheckPagePortalTemplateTypeRet">
    <cfinvokeargument name="ppttName" value="#ARGUMENTS.ppttName#"/>
    <cfinvokeargument name="ppttStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckPagePortalTemplateTypeRet.recordcount NEQ 0>
    <cfset result.message = "The name #ARGUMENTS.ppttName# already exists, please enter a new name.">
    <cfelseif regexProfanityRet CONTAINS '$%&*!'>
    <cfset result.message = "Some text contained profanity, please remove any profanity from your text.">
    <!---Check length restriction.--->
    <cfelseif LEN(ARGUMENTS.ppttDescription) GT 1024>
    <cfset result.message = "The description is longer than 1024 characters, please enter a new description under 1024 characters.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    INSERT INTO tbl_p_portal_template_type (ppttName,ppttDescription,ppttSort,ppttStatus) VALUES
    (
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.ppttName#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.ppttDescription#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ppttSort#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ppttStatus#">
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
    
    <cffunction name="insertPagePortalDocumentRel" access="public" returntype="struct">
    <cfargument name="ppID" type="numeric" required="yes">
    <cfargument name="docID" type="numeric" required="yes">
    <cfargument name="ppdrStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully inserted the record.">
    <cftry>
    <!---Check for a duplicate record.--->
    <cfinvoke 
    component="cfc.p_portal"
    method="getPagePortalDocumentRel"
    returnvariable="getCheckPagePortalDocumentRelRet">
    <cfinvokeargument name="ppID" value="#ARGUMENTS.ppID#"/>
    <cfinvokeargument name="docID" value="#ARGUMENTS.docID#"/>
    <cfinvokeargument name="ppdrStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckPagePortalDocumentRelRet.recordcount NEQ 0>
    <cfset result.message = "The page portal document relationship already exists, please try again.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    INSERT INTO tbl_p_portal_document_rel (ppID,docID,ppdrStatus) VALUES
    (
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ppID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.docID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ppdrStatus#">
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
    
    <cffunction name="insertPagePortalDepartmentRel" access="public" returntype="struct">
    <cfargument name="ppID" type="numeric" required="yes">
    <cfargument name="deptNo" type="numeric" required="yes">
    <cfargument name="ppdrStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully inserted the record.">
    <cftry>
    <!---Check for a duplicate record.--->
    <cfinvoke 
    component="cfc.p_portal"
    method="getPagePortalDepartmentRel"
    returnvariable="getCheckPagePortalDepartmentRelRet">
    <cfinvokeargument name="ppID" value="#ARGUMENTS.ppID#"/>
    <cfinvokeargument name="deptNo" value="#ARGUMENTS.deptNo#"/>
    <cfinvokeargument name="ppdrStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckPagePortalDepartmentRelRet.recordcount NEQ 0>
    <cfset result.message = "The page portal department relationship already exists, please try again.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    INSERT INTO tbl_p_portal_department_rel (ppID,deptNo,ppdrStatus) VALUES
    (
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ppID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.deptNo#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ppdrStatus#">
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
    
    <cffunction name="insertPagePortalSiteRel" access="public" returntype="struct">
    <cfargument name="ppID" type="numeric" required="yes">
    <cfargument name="siteNo" type="numeric" required="yes">
    <cfargument name="ppsrStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully inserted the record.">
    <cftry>
    <!---Check for a duplicate record.--->
    <cfinvoke 
    component="cfc.p_portal"
    method="getPagePortalSiteRel"
    returnvariable="getCheckPagePortalSiteRelRet">
    <cfinvokeargument name="ppID" value="#ARGUMENTS.ppID#"/>
    <cfinvokeargument name="siteNo" value="#ARGUMENTS.siteNo#"/>
    <cfinvokeargument name="ppsrStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckPagePortalSiteRelRet.recordcount NEQ 0>
    <cfset result.message = "The page portal site relationship already exists, please try again.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    INSERT INTO tbl_p_portal_site_rel (ppID,siteNo,ppsrStatus) VALUES
    (
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ppID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.siteNo#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ppsrStatus#">
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
    
    <cffunction name="insertPagePortalFormAttribute" access="public" returntype="struct">
    <cfargument name="pptID" type="numeric" required="yes">
    <cfargument name="ppfaName" type="string" required="yes">
    <cfargument name="ppfaValue" type="string" required="yes">
    <cfargument name="ppfaOption" type="string" required="yes">
    <cfargument name="ppfaDescription" type="string" required="yes">
    <cfargument name="ppfaSize" type="numeric" required="yes">
    <cfargument name="ppfaMaxLength" type="numeric" required="yes">
    <cfargument name="ppfaRequired" type="numeric" required="yes">
    <cfargument name="ppfaMessage" type="string" required="yes">
    <cfargument name="ppfatID" type="numeric" required="yes">
    <cfargument name="ppfaRegex" type="string" required="yes">
    <cfargument name="ppfaValidate" type="string" required="yes">
    <cfargument name="ppfaToolTip" type="string" required="yes">
    <cfargument name="ppfaConfirmValue" type="numeric" required="yes">
    <cfargument name="ppfaSelected" type="string" required="yes">
    <cfargument name="ppfaArgs" type="string" required="yes">
    <cfargument name="ppfaSort" type="numeric" required="yes">
    <cfargument name="ppfaStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully inserted the record.">
    <cftry>
    <!---Check for profanity in the text.--->
    <cfinvoke 
    component="MCMS.component.utility.Regex"
    method="regexProfanity"
    returnvariable="regexProfanityRet">
    <cfinvokeargument name="profanityString" value="#ARGUMENTS.ppfaDescription#"/>
    </cfinvoke>
    <!---Check for a duplicate record.--->
    <cfinvoke 
    component="cfc.p_portal"
    method="getPagePortalFormAttribute"
    returnvariable="getCheckPagePortalFormAttributeRet">
    <cfinvokeargument name="ppfaName" value="#ARGUMENTS.ppfaName#"/>
    <cfinvokeargument name="ppfatID" value="#ARGUMENTS.ppfatID#"/>
    <cfinvokeargument name="ppfaStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckPagePortalFormAttributeRet.recordcount NEQ 0>
    <cfset result.message = "The name #ARGUMENTS.ppfaName# already exists, please enter a new name.">
    <cfelseif regexProfanityRet CONTAINS '$%&*!'>
    <cfset result.message = "Some text contained profanity, please remove any profanity from your text.">
    <!---Check length restriction.--->
    <cfelseif LEN(ARGUMENTS.ppfaDescription) GT 255>
    <cfset result.message = "The description is longer than 255 characters, please enter a new description under 255 characters.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    INSERT INTO tbl_p_portal_form_attribute (pptID,ppfaName,ppfaValue,ppfaOption,ppfaDescription,ppfaSize,ppfaMaxLength,ppfaRequired,ppfaMessage,ppfatID,ppfaRegex,ppfaValidate,ppfaToolTip,ppfaConfirmValue,ppfaSelected,ppfaArgs,ppfaSort,ppfaStatus) VALUES
    (
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.pptID#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.ppfaName#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.ppfaValue#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.ppfaOption#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.ppfaDescription#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ppfaSize#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ppfaMaxLength#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ppfaRequired#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.ppfaMessage#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ppfatID#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.ppfaRegex#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.ppfaValidate#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.ppfaToolTip#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ppfaConfirmValue#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.ppfaSelected#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.ppfaArgs#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ppfaSort#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ppfaStatus#">
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
    
    <cffunction name="insertPagePortalFormUser" access="public" returntype="struct">
    <cfargument name="ppID" type="numeric" required="yes">
    <cfargument name="pptID" type="numeric" required="yes">
    <cfargument name="ppfuName" type="string" required="yes">
    <cfargument name="ppfuIPAddress" type="string" required="yes">
    <cfargument name="siteNo" type="numeric" required="yes">
    <cfargument name="deptNo" type="numeric" required="yes">
    <cfargument name="ppfuStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully inserted the record.">
    <cfset result.ppuID = 0>
    <cftry>
    <!---Check for a duplicate record.--->
    <cfinvoke 
    component="cfc.p_portal"
    method="getPagePortalFormUser"
    returnvariable="getCheckPagePortalFormUserRet">
    <cfinvokeargument name="ppfuName" value="#ARGUMENTS.ppfuName#"/>
    <cfinvokeargument name="siteNo" value="#ARGUMENTS.siteNo#"/>
    <cfinvokeargument name="deptNo" value="#ARGUMENTS.deptNo#"/>
    <cfinvokeargument name="ppfuStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckPagePortalFormUserRet.recordcount NEQ 0>
    <cfset result.message = "The name #ARGUMENTS.ppfuName# already exists for this site and department, please enter a new name.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    INSERT INTO tbl_p_portal_form_user(ppID,pptID,ppfuName,ppfuIPAddress,siteNo,deptNo,ppfuStatus) VALUES
    (
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ppID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.pptID#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.ppfuName#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.ppfuIPAddress#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.siteNo#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.deptNo#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ppfuStatus#">
    )
    </cfquery>
    <cfinvoke 
    component="MCMS.component.cms.Cms"
    method="getMaxValueSQL"
    returnvariable="result.ppuID">
    <cfinvokeargument name="tableName" value="tbl_p_portal_form_user"/>
    </cfinvoke>
    </cftransaction>
    </cfif>
    <cfcatch type="any">
    <cfset result.message = "There was an error inserting the record.">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="insertPagePortalFormResult" access="public" returntype="struct">
    <cfargument name="pptID" type="numeric" required="yes">
    <cfargument name="ppfaID" type="numeric" required="yes">
    <cfargument name="ppfrValue" type="string" required="yes">
    <cfargument name="ppfuID" type="numeric" required="yes">
    <cfargument name="ppResultMessage" type="string" required="yes" default="">
    <cfargument name="ppfrStatus" type="numeric" required="yes">
    <cfif ARGUMENTS.ppResultMessage NEQ ''>
    <cfset result.message = ARGUMENTS.ppResultMessage>
    <cfelse>
    <cfset result.message = "You have successfully submitted the form.">
    </cfif>
    <cftry>
    <!---Check for a duplicate record.--->
    <cfinvoke 
    component="cfc.p_portal"
    method="getPagePortalFormResult"
    returnvariable="getCheckPagePortalFormResultRet">
    <cfinvokeargument name="pptID" value="#ARGUMENTS.pptID#"/>
    <cfinvokeargument name="ppfaID" value="#ARGUMENTS.ppfaID#"/>
    <cfinvokeargument name="ppfrValue" value="#ARGUMENTS.ppfrValue#"/>
    <cfinvokeargument name="ppfuID" value="#ARGUMENTS.ppfuID#"/>
    <cfinvokeargument name="ppfrStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckPagePortalFormResultRet.recordcount NEQ 0>
    <cfset result.message = "The value has already been saved, skipping.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    INSERT INTO tbl_p_portal_form_result (pptID,ppfaID,ppfrValue,ppfuID,ppfrStatus) VALUES
    (
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.pptID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ppfaID#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.ppfrValue#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ppfuID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ppfrStatus#">
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
    
    <cffunction name="insertPagePortalFormWorkflowRel" access="public" returntype="struct">
    <cfargument name="ppID" type="numeric" required="yes">
    <cfargument name="userID" type="numeric" required="yes">
    <cfargument name="siteNo" type="numeric" required="yes">
    <cfargument name="deptNo" type="numeric" required="yes">
    <cfargument name="ppfwfrStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully inserted the record.">
    <cftry>
    <!---Check for a duplicate record.--->
    <cfinvoke 
    component="cfc.p_portal"
    method="getPagePortalFormWorkflowRel"
    returnvariable="getCheckPagePortalFormWorkflowRelRet">
    <cfinvokeargument name="ppID" value="#ARGUMENTS.ppID#"/>
    <cfinvokeargument name="userID" value="#ARGUMENTS.userID#"/>
    <cfinvokeargument name="siteNo" value="#ARGUMENTS.siteNo#"/>
    <cfinvokeargument name="deptNo" value="#ARGUMENTS.deptNo#"/>
    <cfinvokeargument name="ppfwfrStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckPagePortalFormWorkflowRelRet.recordcount NEQ 0>
    <cfset result.message = "The template user relationship already exists for this site and department, please try again.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    INSERT INTO tbl_p_portal_form_wf_rel (ppID,userID,siteNo,deptNo,ppfwfrStatus) VALUES
    (
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ppID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.userID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.siteNo#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.deptNo#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ppfwfrStatus#">
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
    
    <cffunction name="insertPagePortalWorkflowStatusPending" access="public" returntype="struct">
    <cfargument name="ppfwfsID" type="numeric" required="yes">
    <cfargument name="ppfuID" type="numeric" required="yes">
    <cfargument name="ppwfsStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully inserted the record.">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    INSERT INTO tbl_p_portal_wf_status (ppfwfsID,ppfuID,ppwfsStatus) VALUES
    (
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ppfwfsID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ppfuID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ppwfsStatus#">
    )
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error inserting the record.">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="updatePagePortal" access="public" returntype="struct">
    <cfargument name="ID" type="numeric" required="yes">
    <cfargument name="ppTitle" type="string" required="yes">
    <cfargument name="ppContent" type="string" required="yes">
    <cfargument name="ppMeta" type="string" required="yes">
    <cfargument name="ppResultMessage" type="string" required="yes">
    <cfargument name="pptID" type="numeric" required="yes">
    <cfargument name="userIP" type="string" required="yes">
    <cfargument name="netID" type="numeric" required="yes">
    <cfargument name="ppaUserID" type="numeric" required="yes" default="0">
    <cfargument name="ppDateExp" type="date" required="yes">
    <cfargument name="userID" type="numeric" required="yes" default="0">
    <cfargument name="ppParentType" type="numeric" required="yes">
    <cfargument name="ppParentID" type="numeric" required="yes">
    <cfargument name="ppSort" type="numeric" required="yes">
    <cfargument name="ppStatus" type="numeric" required="yes">
    <!---Relationship arguments.--->
    <cfargument name="siteNo" type="string" required="yes">
    <cfargument name="deptNo" type="string" required="yes">
    <cfset result.message = "You have successfully updated the record.">
    <cftry>
    <!---Check for profanity in the text.--->
    <cfinvoke 
    component="MCMS.component.utility.Regex"
    method="regexProfanity"
    returnvariable="regexProfanityRet">
    <cfinvokeargument name="profanityString" value="#ARGUMENTS.ppContent#"/>
    </cfinvoke>
    <!---Check for a duplicate record.--->
    <cfinvoke 
    component="cfc.p_portal"
    method="getPagePortal"
    returnvariable="getCheckPagePortalRet">
    <cfinvokeargument name="excludeID" value="#ARGUMENTS.ID#"/>
    <cfinvokeargument name="ppTitle" value="#ARGUMENTS.ppTitle#"/>
    <cfinvokeargument name="userID" value="#ARGUMENTS.userID#"/>
    <cfinvokeargument name="ppStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckPagePortalRet.recordcount NEQ 0>
    <cfset result.message = "The title #ARGUMENTS.ppTitle# already exist, please enter a new title.">
    <cfelseif regexProfanityRet CONTAINS '$%&*!'>
    <cfset result.message = "Some text contained profanity, please remove any profanity from your text.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_page_portal SET
    ppTitle = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.ppTitle#">,
    ppContent = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.ppContent#">,
    ppMeta = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.ppMeta#">,
    ppResultMessage = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.ppResultMessage#">,
    pptID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.pptID#">,
    userIP = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.userIP#">,
    netID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.netID#">,
    <cfif ARGUMENTS.ppaUserID NEQ 0>
    ppaUserID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ppaUserID#">,
    ppaDate = <cfqueryparam cfsqltype="cf_sql_date" value="#Now()#">,
    </cfif>
    ppDateExp = <cfqueryparam cfsqltype="cf_sql_date" value="#ARGUMENTS.ppDateExp#">,
    ppDateUpdate = <cfqueryparam cfsqltype="cf_sql_date" value="#Now()#">,
    <cfif ARGUMENTS.userID NEQ 0>
    userID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.userID#">,
    </cfif>
    ppParentType = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ppParentType#">,
    ppParentID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ppParentID#">,
    ppSort = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ppSort#">,
    ppStatus = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ppStatus#">
    WHERE ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ID#">
    </cfquery>
    </cftransaction>
    <!---Delete any existing relationships.--->
    <cfinvoke 
    component="cfc.p_portal"
    method="deletePagePortalSiteRel"
    returnvariable="deletePagePortalSiteRelRet">
    <cfinvokeargument name="ppID" value="#ARGUMENTS.ID#"/>
    </cfinvoke>
    <cfinvoke 
    component="cfc.p_portal"
    method="deletePagePortalDepartmentRel"
    returnvariable="deletePagePortalDepartmentRelRet">
    <cfinvokeargument name="ppID" value="#ARGUMENTS.ID#"/>
    </cfinvoke>
    <!---Create site relationships.--->
    <cfloop index="siteNo" list="#ARGUMENTS.siteNo#">
    <cfinvoke 
    component="cfc.p_portal"
    method="insertPagePortalSiteRel"
    returnvariable="insertPagePortalSiteRelRet">
    <cfinvokeargument name="ppID" value="#ARGUMENTS.ID#"/>
    <cfinvokeargument name="siteNo" value="#ARGUMENTS.siteNo#"/>
    <cfinvokeargument name="ppsrStatus" value="1"/>
    </cfinvoke>
    </cfloop>
    <!---Create department relationships.--->
    <cfloop index="deptNo" list="#ARGUMENTS.deptNo#">
    <cfinvoke 
    component="cfc.p_portal"
    method="insertPagePortalDepartmentRel"
    returnvariable="insertPagePortalDepartmentRelRet">
    <cfinvokeargument name="ppID" value="#ARGUMENTS.ID#"/>
    <cfinvokeargument name="deptNo" value="#ARGUMENTS.deptNo#"/>
    <cfinvokeargument name="ppdrStatus" value="1"/>
    </cfinvoke>
    </cfloop>
    <!---Do not send an email when the status is set to Preview or if the user is the approver.--->
    <cfif ARGUMENTS.ppaUserID EQ "" AND (ARGUMENTS.ppStatus EQ 1 OR ARGUMENTS.ppStatus EQ 2)>
    <cfinvoke 
    component="cfc.p_portal"
    method="getPagePortal"
    returnvariable="getPagePortalRet">
    <cfinvokeargument name="ID" value="#ARGUMENTS.ID#"/>
    <cfinvokeargument name="ppStatus" value="1,2,3"/>
    </cfinvoke>
    <cfset var.email = getPagePortalRet.userEmail>
    <cfinvoke 
    component="MCMS.component.utility.Email"
    method="sendEmail">
    <cfinvokeargument name="subject" value="#application.companyName# - Page Portal"/>
    <cfinvokeargument name="to" value="#var.email#"/>
    <cfinvokeargument name="from" value="#application.noReplyEmail#"/>
    <cfinvokeargument name="body" value=""/>
    <cfinvokeargument name="ID" value="#ARGUMENTS.ID#"/>
    <cfinvokeargument name="emailTemplate" value="/#application.mcmsAppAdminPath#/p_portal/view/inc_p_portal_email_template.cfm"/>
    </cfinvoke>
    </cfif>
    </cfif>
    <cfcatch type="any">
    <cfset result.message = "There was an error updating the record.">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="updatePagePortalApprover" access="public" returntype="struct">
    <cfargument name="ID" type="numeric" required="yes">
    <cfargument name="userID" type="numeric" required="yes">
    <cfargument name="deptNo" type="numeric" required="yes">
    <cfargument name="ppaStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully updated the record.">
    <cftry>
    <!---Check for a duplicate record.--->
    <cfinvoke 
    component="cfc.p_portal"
    method="getPagePortalApprover"
    returnvariable="getCheckPagePortalApproverRet">
    <cfinvokeargument name="excludeID" value="#ARGUMENTS.ID#"/>
    <cfinvokeargument name="userID" value="#ARGUMENTS.userID#"/>
    <cfinvokeargument name="deptNo" value="#ARGUMENTS.deptNo#"/>
    <cfinvokeargument name="ppaStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckPagePortalApproverRet.recordcount NEQ 0>
    <cfset result.message = "The page portal approver relationship already exists, please try again.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_p_portal_approver SET
    userID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.userID#">,
    deptNo = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.deptNo#">,
    ppaStatus = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ppaStatus#">
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
    
    <cffunction name="updatePagePortalTemplate" access="public" returntype="struct">
    <cfargument name="ID" type="numeric" required="yes">
    <cfargument name="pptName" type="string" required="yes">
    <cfargument name="pptDescription" type="string" required="yes">
    <cfargument name="pptFile" type="string" required="yes">
    <cfargument name="imgID" type="numeric" required="yes">
    <cfargument name="ppttID" type="numeric" required="yes">
    <cfargument name="pptFormProcess" type="string" required="yes">
    <cfargument name="pptEmail" type="string" required="yes">
    <cfargument name="pptDocument" type="numeric" required="yes">
    <cfargument name="pptEncrypt" type="numeric" required="yes">
    <cfargument name="pptEncryptPassword" type="string" required="yes">
    <cfargument name="pptSiteNoField" type="numeric" required="yes">
    <cfargument name="pptDeptNoField" type="numeric" required="yes">
    <cfargument name="pptDeptNoList" type="string" required="yes">
    <cfargument name="pptSiteNoList" type="string" required="yes">
    <cfargument name="pptStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully updated the record.">
    <cftry>
    <!---Check for profanity in the text.--->
    <cfinvoke 
    component="MCMS.component.utility.Regex"
    method="regexProfanity"
    returnvariable="regexProfanityRet">
    <cfinvokeargument name="profanityString" value="#ARGUMENTS.pptDescription#"/>
    </cfinvoke>
    <!---Check for a duplicate record.--->
    <cfinvoke 
    component="cfc.p_portal"
    method="getPagePortalTemplate"
    returnvariable="getCheckPagePortalTemplateRet">
    <cfinvokeargument name="excludeID" value="#ARGUMENTS.ID#"/>
    <cfinvokeargument name="pptName" value="#ARGUMENTS.pptName#"/>
    <cfinvokeargument name="pptStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckPagePortalTemplateRet.recordcount NEQ 0>
    <cfset result.message = "The name #ARGUMENTS.pptName# already exists, please enter a new name.">
    <cfelseif regexProfanityRet CONTAINS '$%&*!'>
    <cfset result.message = "Some text contained profanity, please remove any profanity from your text.">
    <!---Check length restriction.--->
    <cfelseif LEN(ARGUMENTS.pptDescription) GT 255>
    <cfset result.message = "The description is longer than 255 characters, please enter a new description under 255 characters.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_p_portal_template SET
    pptName = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.pptName#">,
    pptDescription = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.pptDescription#">,
    pptFile = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.pptFile#">,
    imgID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.imgID#">,
    ppttID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ppttID#">,
    pptFormProcess = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.pptFormProcess#">,
    pptEmail = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.pptEmail#">,
    pptDocument = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.pptDocument#">,
    pptEncrypt = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.pptEncrypt#">,
    pptEncryptPassword = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.pptEncryptPassword#">,
    pptSiteNoField = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.pptSiteNoField#">,
    pptDeptNoField = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.pptDeptNoField#">,
    pptDeptNoList = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.pptDeptNoList#">,
    pptSiteNoList = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.pptSiteNoList#">,
    pptStatus = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.pptStatus#">
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
    
    <cffunction name="updatePagePortalTemplateType" access="public" returntype="struct">
    <cfargument name="ID" type="numeric" required="yes">
    <cfargument name="ppttName" type="string" required="yes">
    <cfargument name="ppttDescription" type="string" required="yes">
    <cfargument name="ppttSort" type="numeric" required="yes">
    <cfargument name="ppttStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully updated the record.">
    <cftry>
    <!---Check for profanity in the text.--->
    <cfinvoke 
    component="MCMS.component.utility.Regex"
    method="regexProfanity"
    returnvariable="regexProfanityRet">
    <cfinvokeargument name="profanityString" value="#ARGUMENTS.ppttDescription#"/>
    </cfinvoke>
    <!---Check for a duplicate record.--->
    <cfinvoke 
    component="cfc.p_portal"
    method="getPagePortalTemplateType"
    returnvariable="getCheckPagePortalTemplateTypeRet">
    <cfinvokeargument name="excludeID" value="#ARGUMENTS.ID#"/>
    <cfinvokeargument name="ppttName" value="#ARGUMENTS.ppttName#"/>
    <cfinvokeargument name="ppttStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckPagePortalTemplateTypeRet.recordcount NEQ 0>
    <cfset result.message = "The name #ARGUMENTS.ppttName# already exists, please enter a new name.">
    <cfelseif regexProfanityRet CONTAINS '$%&*!'>
    <cfset result.message = "Some text contained profanity, please remove any profanity from your text.">
    <!---Check length restriction.--->
    <cfelseif LEN(ARGUMENTS.ppttDescription) GT 1024>
    <cfset result.message = "The description is longer than 1024 characters, please enter a new description under 1024 characters.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_p_portal_template_type SET
    ppttName = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.ppttName#">,
    ppttDescription = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.ppttDescription#">,
    ppttSort = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ppttSort#">,
    ppttStatus = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ppttStatus#">
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
    
    <cffunction name="updatePagePortalFormAttribute" access="public" returntype="struct">
    <cfargument name="ID" type="numeric" required="yes">
    <cfargument name="pptID" type="numeric" required="yes">
    <cfargument name="ppfaName" type="string" required="yes">
    <cfargument name="ppfaValue" type="string" required="yes">
    <cfargument name="ppfaOption" type="string" required="yes">
    <cfargument name="ppfaDescription" type="string" required="yes">
    <cfargument name="ppfaSize" type="numeric" required="yes">
    <cfargument name="ppfaMaxLength" type="numeric" required="yes">
    <cfargument name="ppfaRequired" type="numeric" required="yes">
    <cfargument name="ppfaMessage" type="string" required="yes">
    <cfargument name="ppfatID" type="numeric" required="yes">
    <cfargument name="ppfaRegex" type="string" required="yes">
    <cfargument name="ppfaValidate" type="string" required="yes">
    <cfargument name="ppfaToolTip" type="string" required="yes">
    <cfargument name="ppfaConfirmValue" type="numeric" required="yes">
    <cfargument name="ppfaSelected" type="string" required="yes">
    <cfargument name="ppfaArgs" type="string" required="yes">
    <cfargument name="ppfaSort" type="numeric" required="yes">
    <cfargument name="ppfaStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully updated the record.">
    <cftry>
    <!---Check for profanity in the text.--->
    <cfinvoke 
    component="MCMS.component.utility.Regex"
    method="regexProfanity"
    returnvariable="regexProfanityRet">
    <cfinvokeargument name="profanityString" value="#ARGUMENTS.ppfaDescription#"/>
    </cfinvoke>
    <!---Check for a duplicate record.--->
    <cfinvoke 
    component="cfc.p_portal"
    method="getPagePortalFormAttribute"
    returnvariable="getCheckPagePortalFormAttributeRet">
    <cfinvokeargument name="excludeID" value="#ARGUMENTS.ID#"/>
    <cfinvokeargument name="ppfaName" value="#ARGUMENTS.ppfaName#"/>
    <cfinvokeargument name="ppfatID" value="#ARGUMENTS.ppfatID#"/>
    <cfinvokeargument name="ppfaStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckPagePortalFormAttributeRet.recordcount NEQ 0>
    <cfset result.message = "The name #ARGUMENTS.ppfaName# already exists, please enter a new name.">
    <cfelseif regexProfanityRet CONTAINS '$%&*!'>
    <cfset result.message = "Some text contained profanity, please remove any profanity from your text.">
    <!---Check length restriction.--->
    <cfelseif LEN(ARGUMENTS.ppfaDescription) GT 255>
    <cfset result.message = "The description is longer than 255 characters, please enter a new description under 255 characters.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_p_portal_form_attribute SET
    pptID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.pptID#">,
    ppfaName = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.ppfaName#">,
    ppfaValue = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.ppfaValue#">,
    ppfaOption = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.ppfaOption#">,
    ppfaDescription = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.ppfaDescription#">,
    ppfaSize = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ppfaSize#">,
    ppfaMaxLength = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ppfaMaxLength#">,
    ppfaRequired = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ppfaRequired#">,
    ppfaMessage = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.ppfaMessage#">,
    ppfatID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ppfatID#">,
    ppfaRegex = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.ppfaRegex#">,
    ppfaValidate = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.ppfaValidate#">,
    ppfaToolTip = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.ppfaToolTip#">,
    ppfaConfirmValue = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ppfaConfirmValue#">,
    ppfaSelected = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.ppfaSelected#">,
    ppfaArgs = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.ppfaArgs#">,
    ppfaDate = <cfqueryparam cfsqltype="cf_sql_date" value="#Now()#">,
    ppfaSort = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ppfaSort#">,
    ppfaStatus = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ppfaStatus#">
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
    
    <cffunction name="updatePagePortalFormWorkflowRel" access="public" returntype="struct">
    <cfargument name="ID" type="numeric" required="yes">
    <cfargument name="ppID" type="numeric" required="yes">
    <cfargument name="userID" type="numeric" required="yes">
    <cfargument name="siteNo" type="numeric" required="yes">
    <cfargument name="deptNo" type="numeric" required="yes">
    <cfargument name="ppfwfrStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully updated the record.">
    <cftry>
    <!---Check for a duplicate record.--->
    <cfinvoke 
    component="cfc.p_portal"
    method="getPagePortalFormWorkflowRel"
    returnvariable="getCheckPagePortalFormWorkflowRet">
    <cfinvokeargument name="excludeID" value="#ARGUMENTS.ID#"/>
    <cfinvokeargument name="ppID" value="#ARGUMENTS.ppID#"/>
    <cfinvokeargument name="userID" value="#ARGUMENTS.userID#"/>
    <cfinvokeargument name="siteNo" value="#ARGUMENTS.siteNo#"/>
    <cfinvokeargument name="deptNo" value="#ARGUMENTS.deptNo#"/>
    <cfinvokeargument name="ppfwfrStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckPagePortalFormWorkflowRet.recordcount NEQ 0>
    <cfset result.message = "The template user relationship already exists for this site and department, please try again.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_p_portal_form_wf_rel SET
    ppID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ppID#">,
    userID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.userID#">,
    siteNo = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.siteNo#">,
    deptNo = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.deptNo#">,
    ppfwfrStatus = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ppfwfrStatus#">
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
    
    <cffunction name="updatePagePortalFormUser" access="public" returntype="struct">
    <cfargument name="ID" type="numeric" required="yes">
    <cfargument name="ppfuName" type="string" required="no" default="">
    <cfargument name="siteNo" type="numeric" required="no" default="100">
    <cfargument name="deptNo" type="numeric" required="no" default="0">
    <cfargument name="userID" type="numeric" required="no" default="0">
    <cfargument name="ppfusID" type="numeric" required="no" default="0">
    <cfset result.message = "You have successfully updated the record.">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_p_portal_form_user SET
    <cfif ARGUMENTS.ppfuName NEQ "">
    ppfuName = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.ppfuName#">,
    siteNo = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.siteNo#">,
    deptNo = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.deptNo#">,
    </cfif>
    <cfif ARGUMENTS.userID NEQ 0>
    userID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.userID#">,
    ppfusID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ppfusID#">,
    </cfif>
    ppfuDateUpdate = <cfqueryparam cfsqltype="cf_sql_date" value="#Now()#">
    WHERE ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ID#">
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error updating the record.">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="insertPagePortalWorkflowStatus" access="public" returntype="struct">
    <cfargument name="ID" type="numeric" required="yes">
    <cfargument name="pptID" type="numeric" required="yes">
    <cfargument name="userID" type="numeric" required="yes">
    <cfargument name="ppfwfsID" type="numeric" required="yes">
    <cfargument name="ppfuID" type="numeric" required="yes">
    <!--- Required set to no to accommodate being called directly from an email where comments would not exist. --->
    <cfargument name="ppwfsComment" type="string" required="no" default="">
    <cfargument name="ppwfsStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully updated the record.">
    <cfset insertFlag = true>
    <cftry>
    <cfinvoke 
    component="cfc.p_portal"
    method="getPagePortalWorkflowStatus"
    returnvariable="getPagePortalWorkflowStatusRet">
    <cfinvokeargument name="userID" value="#ARGUMENTS.userID#"/>
    <cfinvokeargument name="ppfwfsID" value="#ARGUMENTS.ppfwfsID#"/>
    <cfinvokeargument name="ppfuID" value="#ARGUMENTS.ppfuID#"/>
    <cfinvokeargument name="ppwfsStatus" value="#ARGUMENTS.ppwfsStatus#"/>
    </cfinvoke>
    <cfif getPagePortalWorkflowStatusRet.recordcount NEQ 0>
    <cfset result.message = "The workflow status already exists, please try again.">
    <cfset insertFlag = false>
    <cfelse>
    <cftransaction>
    <!--- This needs to be an insert to make the workflow function properly. --->
    <cfquery datasource="#application.mcmsDSN#">
    INSERT INTO tbl_p_portal_wf_status (userID,ppfwfsID,ppfuID,ppwfsComment,ppwfsStatus) VALUES
    (
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.userID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ppfwfsID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ppfuID#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.ppwfsComment#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ppwfsStatus#">
    )
    </cfquery>
    </cftransaction>
    </cfif>
    <cfif insertFlag EQ true>
    <!--- Update the page portal form user record as well. --->
    <cfif ARGUMENTS.ppfwfsID EQ 2>
    <cfinvoke 
    component="cfc.p_portal"
    method="updatePagePortalFormUser"
    returnvariable="updatePagePortalFormUserRet">
    <cfinvokeargument name="ID" value="#ARGUMENTS.ppfuID#"/>
    <cfinvokeargument name="userID" value="#ARGUMENTS.userID#"/>
    <cfinvokeargument name="ppfusID" value="3"/>
    </cfinvoke>
    <cfelseif ARGUMENTS.ppfwfsID EQ 3>
    <cfinvoke 
    component="cfc.p_portal"
    method="updatePagePortalFormUser"
    returnvariable="updatePagePortalFormUserRet">
    <cfinvokeargument name="ID" value="#ARGUMENTS.ppfuID#"/>
    <cfinvokeargument name="userID" value="#ARGUMENTS.userID#"/>
    <cfinvokeargument name="ppfusID" value="2"/>
    </cfinvoke>
    <cfelseif ARGUMENTS.ppfwfsID EQ 4>
    <cfinvoke 
    component="cfc.p_portal"
    method="updatePagePortalFormUser"
    returnvariable="updatePagePortalFormUserRet">
    <cfinvokeargument name="ID" value="#ARGUMENTS.ppfuID#"/>
    <cfinvokeargument name="userID" value="#ARGUMENTS.userID#"/>
    <cfinvokeargument name="ppfusID" value="4"/>
    </cfinvoke>
    </cfif>
    <cfinvoke 
    component="cfc.p_portal"
    method="processPagePortalForm"
    returnvariable="processPagePortalFormRet">
    <cfinvokeargument name="pptID" value="#ARGUMENTS.pptID#"/>
    <cfinvokeargument name="ppfuID" value="#ARGUMENTS.ppfuID#"/>
    <cfinvokeargument name="ppfwfsID" value="#ARGUMENTS.ppfwfsID#"/>
    </cfinvoke>
    </cfif>
    <cfcatch type="any">
    <cfset result.message = "There was an error updating the record.">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="updatePagePortalFormResult" access="public" returntype="struct">
    <cfargument name="ID" type="numeric" required="yes">
    <cfargument name="pptID" type="numeric" required="yes">
    <cfargument name="ppfaID" type="numeric" required="yes">
    <cfargument name="ppfrValue" type="string" required="yes">
    <cfargument name="ppfuID" type="numeric" required="yes">
    <cfargument name="ppfrStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully updated the record.">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_p_portal_form_result SET
    pptID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.pptID#">,
    ppfaID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ppfaID#">,
    ppfrValue = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.ppfrValue#">,
    ppfuID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ppfuID#">,
    ppfrStatus = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ppfrStatus#">
    WHERE ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ID#">
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error updating the record.">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="updatePagePortalList" access="public" returntype="struct">
    <cfargument name="ID" type="numeric" required="yes">
    <cfargument name="ppaUserID" type="numeric" required="yes">
    <cfargument name="ppStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully updated the records.">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_page_portal SET
    ppaUserID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ppaUserID#">,
    ppaDate = <cfqueryparam cfsqltype="cf_sql_date" value="#Now()#">,
    ppStatus = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ppStatus#">
    WHERE ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ID#">
    </cfquery>
    </cftransaction>
    <!---Send the user an email informing them of an approval or a denial.--->
    <cfif ARGUMENTS.ppStatus EQ 1 OR ARGUMENTS.ppStatus EQ 2>
    <cfinvoke 
    component="cfc.p_portal"
    method="getPagePortal"
    returnvariable="getPagePortalRet">
    <cfinvokeargument name="ID" value="#ARGUMENTS.ID#"/>
    <cfinvokeargument name="ppStatus" value="1,2,3"/>
    </cfinvoke>
    <cfset var.email = getPagePortalRet.userEmail>
    <cfinvoke 
    component="MCMS.component.utility.Email"
    method="sendEmail">
    <cfinvokeargument name="subject" value="#application.companyName# - Page Portal"/>
    <cfinvokeargument name="to" value="#var.email#"/>
    <cfinvokeargument name="from" value="#application.noReplyEmail#"/>
    <cfinvokeargument name="body" value=""/>
    <cfinvokeargument name="ID" value="#ARGUMENTS.ID#"/>
    <cfinvokeargument name="emailTemplate" value="/#application.mcmsAppAdminPath#/p_portal/view/inc_p_portal_email_template.cfm"/>
    </cfinvoke>
    </cfif>
    <cfcatch type="any">
    <cfset result.message = "There was an error updating the records.">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="updatePagePortalApproverList" access="public" returntype="struct">
    <cfargument name="ID" type="numeric" required="yes">
    <cfargument name="ppaStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully updated the records.">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_p_portal_approver SET
    ppaStatus = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ppaStatus#">
    WHERE ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ID#">
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error updating the records.">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="updatePagePortalTemplateList" access="public" returntype="struct">
    <cfargument name="ID" type="numeric" required="yes">
    <cfargument name="pptStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully updated the records.">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_p_portal_template SET
    pptStatus = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.pptStatus#">
    WHERE ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ID#">
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error updating the records.">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="updatePagePortalTemplateTypeList" access="public" returntype="struct">
    <cfargument name="ID" type="numeric" required="yes">
    <cfargument name="ppttStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully updated the records.">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_p_portal_template_type SET
    ppttStatus = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ppttStatus#">
    WHERE ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ID#">
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error updating the records.">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="updatePagePortalFormAttributeList" access="public" returntype="struct">
    <cfargument name="ID" type="numeric" required="yes">
    <cfargument name="ppfaStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully updated the records.">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_p_portal_form_attribute SET
    ppfaStatus = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ppfaStatus#">
    WHERE ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ID#">
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error updating the records.">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="updatePagePortalFormWorkflowRelList" access="public" returntype="struct">
    <cfargument name="ID" type="numeric" required="yes">
    <cfargument name="ppfwfrStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully updated the records.">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_p_portal_form_wf_rel SET
    ppfwfrStatus = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ppfwfrStatus#">
    WHERE ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ID#">
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error updating the records.">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="updatePagePortalFormUserList" access="public" returntype="struct">
    <cfargument name="ID" type="numeric" required="yes">
    <cfargument name="ppfusID" type="numeric" required="yes">
    <cfset result.message = "You have successfully updated the records.">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_p_portal_form_user SET
    ppfusID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ppfusID#">
    WHERE ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ID#">
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error updating the records.">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="deletePagePortal" access="public" returntype="struct">
    <cfargument name="ID" type="string" required="yes">
    <cfset result.message = "You have successfully deleted the record(s).">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    DELETE FROM tbl_page_portal
    WHERE ID IN (<cfqueryparam cfsqltype="cf_sql_integer" list="yes" value="#ARGUMENTS.ID#">)
    </cfquery>
    </cftransaction>
    <cfinvoke 
    component="cfc.p_portal"
    method="deletePagePortalSiteRel"
    returnvariable="deletePagePortalSiteRelRet">
    <cfinvokeargument name="ppID" value="#ARGUMENTS.ID#"/>
    </cfinvoke>
    <cfinvoke 
    component="cfc.p_portal"
    method="deletePagePortalDepartmentRel"
    returnvariable="deletePagePortalDepartmentRelRet">
    <cfinvokeargument name="ppID" value="#ARGUMENTS.ID#"/>
    </cfinvoke>
    <cfinvoke 
    component="cfc.p_portal"
    method="deletePagePortalDocumentRel"
    returnvariable="deletePagePortalDocumentRelRet">
    <cfinvokeargument name="ppID" value="#ARGUMENTS.ID#"/>
    </cfinvoke>
    <cfcatch type="any">
    <cfset result.message = "There was an error deleting the record(s).">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>  
    
    <cffunction name="deletePagePortalApprover" access="public" returntype="struct">
    <cfargument name="ID" type="string" required="yes">
    <cfset result.message = "You have successfully deleted the record(s).">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    DELETE FROM tbl_p_portal_approver
    WHERE ID IN (<cfqueryparam cfsqltype="cf_sql_integer" list="yes" value="#ARGUMENTS.ID#">)
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error deleting the record(s).">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="deletePagePortalTemplate" access="public" returntype="struct">
    <cfargument name="ID" type="string" required="yes">
    <cfset result.message = "You have successfully deleted the record(s).">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    DELETE FROM tbl_p_portal_template
    WHERE ID IN (<cfqueryparam cfsqltype="cf_sql_integer" list="yes" value="#ARGUMENTS.ID#">)
    </cfquery>
    </cftransaction>
    <cfinvoke 
    component="cfc.p_portal"
    method="deletePagePortalFormAttribute"
    returnvariable="deletePagePortalFormAttributeRet">
    <cfinvokeargument name="pptID" value="#ARGUMENTS.ID#"/>
    </cfinvoke>
    <cfcatch type="any">
    <cfset result.message = "There was an error deleting the record(s).">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>    
    
    <cffunction name="deletePagePortalTemplateType" access="public" returntype="struct">
    <cfargument name="ID" type="string" required="yes">
    <cfset result.message = "You have successfully deleted the record(s).">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    DELETE FROM tbl_p_portal_template_type
    WHERE ID IN (<cfqueryparam cfsqltype="cf_sql_integer" list="yes" value="#ARGUMENTS.ID#">)
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error deleting the record(s).">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>   
    
    <cffunction name="deletePagePortalDocumentRel" access="public" returntype="struct">
    <cfargument name="ID" type="string" required="yes" default="0">
    <cfargument name="ppID" type="string" required="yes" default="0">
    <cfset result.message = "You have successfully deleted the record(s).">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    DELETE FROM tbl_p_portal_document_rel
    WHERE ID IN (<cfqueryparam cfsqltype="cf_sql_integer" list="yes" value="#ARGUMENTS.ID#">)
    OR ppID IN (<cfqueryparam cfsqltype="cf_sql_integer" list="yes" value="#ARGUMENTS.ppID#">)
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error deleting the record(s).">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>  
    
    <cffunction name="deletePagePortalDepartmentRel" access="public" returntype="struct">
    <cfargument name="ID" type="string" required="yes" default="0">
    <cfargument name="ppID" type="string" required="yes" default="0">
    <cfset result.message = "You have successfully deleted the record(s).">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    DELETE FROM tbl_p_portal_department_rel
    WHERE ID IN (<cfqueryparam cfsqltype="cf_sql_integer" list="yes" value="#ARGUMENTS.ID#">)
    OR ppID IN (<cfqueryparam cfsqltype="cf_sql_integer" list="yes" value="#ARGUMENTS.ppID#">)
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error deleting the record(s).">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="deletePagePortalSiteRel" access="public" returntype="struct">
    <cfargument name="ID" type="string" required="yes" default="0">
    <cfargument name="ppID" type="string" required="yes" default="0">
    <cfset result.message = "You have successfully deleted the record(s).">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    DELETE FROM tbl_p_portal_site_rel
    WHERE ID IN (<cfqueryparam cfsqltype="cf_sql_integer" list="yes" value="#ARGUMENTS.ID#">)
    OR ppID IN (<cfqueryparam cfsqltype="cf_sql_integer" list="yes" value="#ARGUMENTS.ppID#">)
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error deleting the record(s).">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction> 
    
    <cffunction name="deletePagePortalFormAttribute" access="public" returntype="struct">
    <cfargument name="ID" type="string" required="yes" default="0">
    <cfargument name="pptID" type="string" required="yes" default="0">
    <cfset result.message = "You have successfully deleted the record(s).">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    DELETE FROM tbl_p_portal_form_attribute
    WHERE ID IN (<cfqueryparam cfsqltype="cf_sql_integer" list="yes" value="#ARGUMENTS.ID#">)
    OR pptID IN (<cfqueryparam cfsqltype="cf_sql_integer" list="yes" value="#ARGUMENTS.pptID#">)
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error deleting the record(s).">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="deletePagePortalFormWorkflowRel" access="public" returntype="struct">
    <cfargument name="ID" type="string" required="yes">
    <cfset result.message = "You have successfully deleted the record(s).">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    DELETE FROM tbl_p_portal_form_wf_rel
    WHERE ID IN (<cfqueryparam cfsqltype="cf_sql_integer" list="yes" value="#ARGUMENTS.ID#">)
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error deleting the record(s).">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>    
    
    <cffunction name="processPagePortalForm" access="public" returntype="struct">
    <cfargument name="pptID" type="numeric" required="yes">
    <cfargument name="ppfuID" type="numeric" required="yes">
    <cfargument name="ppfwfsID" type="numeric" required="yes">
    <cfset result.message = "">
    <cftry>
    <cfinvoke 
    component="cfc.p_portal"
    method="getPagePortalTemplate"
    returnvariable="getPagePortalTemplateRet">
    <cfinvokeargument name="ID" value="#ARGUMENTS.pptID#"/>
    <cfinvokeargument name="pptStatus" value="1"/>
    </cfinvoke>
    <cfinvoke 
    component="cfc.p_portal"
    method="getPagePortalFormUser"
    returnvariable="getPagePortalFormUserRet">
    <cfinvokeargument name="ID" value="#ARGUMENTS.ppfuID#"/>
    <cfinvokeargument name="ppfuStatus" value="1"/>
    </cfinvoke>
    <!--- Is there a workflow associated with this template. --->
    <cfif getPagePortalTemplateRet.pptFormProcess EQ "workflow">
    <cfinvoke 
    component="cfc.p_portal"
    method="getPagePortalWorkflowStatus"
    returnvariable="getPagePortalWorkflowStatusRet">
    <cfinvokeargument name="ppfuID" value="#ARGUMENTS.ppfuID#"/>
    <cfinvokeargument name="ppwfsStatus" value="1"/>
    <cfinvokeargument name="orderBy" value="ID DESC"/>
    </cfinvoke> 
    <cfset supervisorIDList = ValueList(getPagePortalWorkflowStatusRet.userID)>
    <!--- The first time send to the first supervisor in the workflow. --->
    <cfif getPagePortalWorkflowStatusRet.userID EQ 0>
    <cfinvoke 
    component="cfc.p_portal"
    method="getPagePortalFormWorkflowRel"
    returnvariable="getPagePortalFormWorkflowRelRet">
    <cfinvokeargument name="ppID" value="#getPagePortalFormUserRet.ppID#"/>
    <cfinvokeargument name="ppfwfrStatus" value="1"/>
    <cfinvokeargument name="orderBy" value="ID"/>
    </cfinvoke>
    <cfset this.email = getPagePortalFormWorkflowRelRet.userEmail>
    <cfinvoke 
    component="MCMS.component.utility.Email"
    method="sendEmail">
    <cfinvokeargument name="subject" value="#application.companyName# - Form Page Portal"/>
    <cfinvokeargument name="to" value="#this.email#"/>
    <cfinvokeargument name="from" value="#application.noReplyEmail#"/>
    <cfinvokeargument name="body" value=""/>
    <cfinvokeargument name="ID" value="#ARGUMENTS.ppfuID#"/>
    <cfinvokeargument name="emailTemplate" value="/p_portal/view/inc_p_portal_form_workflow_email.cfm"/>
    </cfinvoke>
    <!--- A supervisor has inserted a record into the workflow status table. --->
    <cfelse>
    <!--- Pull in supervisors and exclude those supervisors that have already taken an action, thus have a record in the workflow status table. --->
    <cfinvoke 
    component="cfc.p_portal"
    method="getPagePortalFormWorkflowRel"
    returnvariable="getPagePortalFormWorkflowRelRet">
    <cfinvokeargument name="ppID" value="#getPagePortalFormUserRet.ppID#"/>
    <cfinvokeargument name="excludeUserID" value="#supervisorIDList#"/>
    <cfinvokeargument name="ppfwfrStatus" value="1"/>
    <cfinvokeargument name="orderBy" value="ID"/>
    </cfinvoke>
    <cfset this.email = getPagePortalFormWorkflowRelRet.userEmail>
    <!--- If approved send to next supervisor in the workflow. --->
    <cfif getPagePortalWorkflowStatusRet.ppfwfsID EQ 3>
    <cfinvoke 
    component="MCMS.component.utility.Email"
    method="sendEmail">
    <cfinvokeargument name="subject" value="#application.companyName# - Form Page Portal"/>
    <cfinvokeargument name="to" value="#this.email#"/>
    <cfinvokeargument name="from" value="#application.noReplyEmail#"/>
    <cfinvokeargument name="body" value=""/>
    <cfinvokeargument name="ID" value="#ARGUMENTS.ppfuID#"/>
    <cfinvokeargument name="emailTemplate" value="/p_portal/view/inc_p_portal_form_workflow_email.cfm"/>
    </cfinvoke>
    </cfif>
    </cfif>
    <cfelseif getPagePortalTemplateRet.pptFormProcess EQ "email">
    <!--- There is no workflow. --->
    <!--- Determine if a document is being attached. --->
    <cfset var.emailList = ValueList(getPagePortalTemplateRet.pptEmail)>
    <cfif getPagePortalTemplateRet.pptDocument EQ 1>
    <!--- Write the file. The directory repository form_data must exist. --->
    <cfset url.ID = ARGUMENTS.ppfuID>
    <cfset url.mcmsID = "writeFile">
    <cfinclude template="/#application.mcmsAppAdminPath#/p_portal/view/inc_p_portal_form_pdf.cfm">
    <cfloop index="userEmail" list="#var.emailList#">
    <cfinvoke 
    component="cfc.p_portal_email"
    method="sendEmail">
    <cfinvokeargument name="subject" value="#application.companyName# - Form Page Portal"/>
    <cfinvokeargument name="to" value="#userEmail#"/>
    <cfinvokeargument name="from" value="#application.noReplyEmail#"/>
    <cfinvokeargument name="body" value=""/>
    <cfinvokeargument name="mimeAttach" value="#application.mcmsCDNURL#/#application.mcmsRepositoryDir#/form_data/#ARGUMENTS.ppfuID#.pdf"/>
    <cfinvokeargument name="ID" value="#ARGUMENTS.ppfuID#"/>
    <cfinvokeargument name="emailTemplate" value="/p_portal/view/inc_p_portal_form_workflow_email.cfm"/>
    </cfinvoke>
    </cfloop>
    <cfelse>
    <!--- Send an email to each email address in the email list provided. --->
    <cfloop index="userEmail" list="#var.emailList#">
    <cfinvoke 
    component="MCMS.component.utility.Email"
    method="sendEmail">
    <cfinvokeargument name="subject" value="#application.companyName# - Form Page Portal"/>
    <cfinvokeargument name="to" value="#userEmail#"/>
    <cfinvokeargument name="from" value="#application.noReplyEmail#"/>
    <cfinvokeargument name="body" value=""/>
    <cfinvokeargument name="ID" value="#ARGUMENTS.ppfuID#"/>
    <cfinvokeargument name="emailTemplate" value="/p_portal/view/inc_p_portal_form_workflow_email.cfm"/>
    </cfinvoke>
    </cfloop>
    </cfif>  
    <cfelse>
    <cflocation url="/p_portal/view/inc_p_portal_form_pdf.cfm?ID=#ARGUMENTS.ppfuID#" addtoken="no">
    </cfif>
    <cfcatch type="any">
    <cfset result.message = "There was an error notifying page portal users.">
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction> 
</cfcomponent>