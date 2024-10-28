<cfcomponent>
    <cffunction name="getQuickReport" access="public" returntype="query" hint="Get Quick Report data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="ID" type="numeric" required="yes" default="0">
    <cfargument name="excludeID" type="numeric" required="yes" default="0">
    <cfargument name="qrName" type="string" required="yes" default="">
    <cfargument name="appStatus" type="string" required="yes" default="1">
    <cfargument name="qrStatus" type="string" required="yes" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="qrName">
    <cfset var rsQuickReport = "" >
    <cftry>
    <cfquery name="rsQuickReport" datasource="#application.mcmsDSN#">
    SELECT * FROM v_quick_report WHERE 0=0
    <cfif ARGUMENTS.ID NEQ 0>
    AND ID = <cfqueryparam value="#ARGUMENTS.ID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.excludeID NEQ 0>
    AND ID <> <cfqueryparam value="#ARGUMENTS.excludeID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(qrName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(qrDescription) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(appName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">)
    </cfif>
    <cfif ARGUMENTS.qrName NEQ "">
    AND UPPER(qrName) = <cfqueryparam value="#UCASE(ARGUMENTS.qrName)#" cfsqltype="cf_sql_varchar">
    </cfif>
    AND appStatus IN (<cfqueryparam value="#ARGUMENTS.appStatus#" list="yes" cfsqltype="cf_sql_integer">)
    AND qrStatus IN (<cfqueryparam value="#ARGUMENTS.qrStatus#" list="yes" cfsqltype="cf_sql_integer">)
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsQuickReport = StructNew()>
    <cfset rsQuickReport.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsQuickReport>
    </cffunction>
    
    <cffunction name="getQuickReportCategory" access="public" returntype="query" hint="Get Quick Report Category data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="ID" type="numeric" required="yes" default="0">
    <cfargument name="excludeID" type="numeric" required="yes" default="0">
    <cfargument name="qrcName" type="string" required="yes" default="">
    <cfargument name="qrcStatus" type="string" required="yes" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="qrcName">
    <cfset var rsQuickReportCategory = "" >
    <cftry>
    <cfquery name="rsQuickReportCategory" datasource="#application.mcmsDSN#">
    SELECT * FROM v_quick_report_category WHERE 0=0
    <cfif ARGUMENTS.ID NEQ 0>
    AND ID = <cfqueryparam value="#ARGUMENTS.ID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.excludeID NEQ 0>
    AND ID <> <cfqueryparam value="#ARGUMENTS.excludeID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND UPPER(qrcName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">
    </cfif>
    <cfif ARGUMENTS.qrcName NEQ "">
    AND UPPER(qrcName) = <cfqueryparam value="#UCASE(ARGUMENTS.qrcName)#" cfsqltype="cf_sql_varchar">
    </cfif>
    AND qrcStatus IN (<cfqueryparam value="#ARGUMENTS.qrcStatus#" list="yes" cfsqltype="cf_sql_integer">)
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsQuickReportCategory = StructNew()>
    <cfset rsQuickReportCategory.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsQuickReportCategory>
    </cffunction>
    
    <cffunction name="getQuickReportType" access="public" returntype="query" hint="Get Quick Report Type data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="ID" type="numeric" required="yes" default="0">
    <cfargument name="excludeID" type="numeric" required="yes" default="0">
    <cfargument name="qrtName" type="string" required="yes" default="">
    <cfargument name="qrtStatus" type="string" required="yes" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="qrtSort">
    <cfset var rsQuickReportType = "" >
    <cftry>
    <cfquery name="rsQuickReportType" datasource="#application.mcmsDSN#">
    SELECT * FROM v_quick_report_type WHERE 0=0
    <cfif ARGUMENTS.ID NEQ 0>
    AND ID = <cfqueryparam value="#ARGUMENTS.ID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.excludeID NEQ 0>
    AND ID <> <cfqueryparam value="#ARGUMENTS.excludeID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND UPPER(qrtName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">
    </cfif>
    <cfif ARGUMENTS.qrtName NEQ "">
    AND UPPER(qrtName) = <cfqueryparam value="#UCASE(ARGUMENTS.qrtName)#" cfsqltype="cf_sql_varchar">
    </cfif>
    AND qrtStatus IN (<cfqueryparam value="#ARGUMENTS.qrtStatus#" list="yes" cfsqltype="cf_sql_integer">)
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsQuickReportType = StructNew()>
    <cfset rsQuickReportType.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsQuickReportType>
    </cffunction>
    
    <cffunction name="getQuickReportSiteRel" access="public" returntype="query" hint="Get Quick Report Site Relationship data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="qrID" type="numeric" required="yes" default="0">
    <cfargument name="siteNo" type="numeric" required="yes" default="0">
    <cfargument name="siteStatus" type="string" required="yes" default="1">
    <cfargument name="qrStatus" type="string" required="yes" default="1">
    <cfargument name="qrsrStatus" type="string" required="yes" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="qrID">
    <cfset var rsQuickReportSiteRel = "" >
    <cftry>
    <cfquery name="rsQuickReportSiteRel" datasource="#application.mcmsDSN#">
    SELECT * FROM v_quick_report_site_rel WHERE 0=0
    <cfif ARGUMENTS.qrID NEQ 0>
    AND qrID = <cfqueryparam value="#ARGUMENTS.qrID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.siteNo NEQ 0>
    AND siteNo = <cfqueryparam value="#ARGUMENTS.siteNo#" cfsqltype="cf_sql_integer">
    </cfif>
    AND (siteStatus IN (<cfqueryparam value="#ARGUMENTS.siteStatus#" list="yes" cfsqltype="cf_sql_integer">) OR siteStatus IS NULL)
    AND qrStatus IN (<cfqueryparam value="#ARGUMENTS.qrStatus#" list="yes" cfsqltype="cf_sql_integer">)
    AND qrsrStatus IN (<cfqueryparam value="#ARGUMENTS.qrsrStatus#" list="yes" cfsqltype="cf_sql_integer">)
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsQuickReportSiteRel = StructNew()>
    <cfset rsQuickReportSiteRel.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsQuickReportSiteRel>
    </cffunction>
    
    <cffunction name="getQuickReportDepartmentRel" access="public" returntype="query" hint="Get Quick Report Department Relationship data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="qrID" type="numeric" required="yes" default="0">
    <cfargument name="deptNo" type="numeric" required="yes" default="0">
    <cfargument name="deptStatus" type="string" required="yes" default="1">
    <cfargument name="qrStatus" type="string" required="yes" default="1">
    <cfargument name="qrdrStatus" type="string" required="yes" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="qrID">
    <cfset var rsQuickReportDepartmentRel = "" >
    <cftry>
    <cfquery name="rsQuickReportDepartmentRel" datasource="#application.mcmsDSN#">
    SELECT * FROM v_qr_department_rel WHERE 0=0
    <cfif ARGUMENTS.qrID NEQ 0>
    AND qrID = <cfqueryparam value="#ARGUMENTS.qrID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.deptNo NEQ 0>
    AND deptNo = <cfqueryparam value="#ARGUMENTS.deptNo#" cfsqltype="cf_sql_integer">
    </cfif>
    AND (deptStatus IN (<cfqueryparam value="#ARGUMENTS.deptStatus#" list="yes" cfsqltype="cf_sql_integer">) OR deptStatus IS NULL)
    AND qrStatus IN (<cfqueryparam value="#ARGUMENTS.qrStatus#" list="yes" cfsqltype="cf_sql_integer">)
    AND qrdrStatus IN (<cfqueryparam value="#ARGUMENTS.qrdrStatus#" list="yes" cfsqltype="cf_sql_integer">)
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsQuickReportDepartmentRel = StructNew()>
    <cfset rsQuickReportDepartmentRel.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsQuickReportDepartmentRel>
    </cffunction>
    
    <cffunction name="getQuickReportReport" access="public" returntype="query" hint="Get Quick Report Report data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="orderBy" type="string" required="yes" default="qrName">
    <cfset var rsQuickReportReport = "" >
    <cftry>
    <cfquery name="rsQuickReportReport" datasource="#application.mcmsDSN#">
    SELECT qrName As Name, qrDescription As Description, appName As Application, qrComponent As Component, qrMethod As Method, qrcName As Category, qrtName As Type, netName As Network, sortName As Sort, sName As Status FROM v_quick_report WHERE 0=0
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(qrName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(qrDescription) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">)
    </cfif>
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsQuickReportReport = StructNew()>
    <cfset rsQuickReportReport.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsQuickReportReport>
    </cffunction>
    
    <cffunction name="getQuickReportCategoryReport" access="public" returntype="query" hint="Get Quick Report Category Report data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="orderBy" type="string" required="yes" default="qrcName">
    <cfset var rsQuickReportCategoryReport = "" >
    <cftry>
    <cfquery name="rsQuickReportCategoryReport" datasource="#application.mcmsDSN#">
    SELECT qrcName As Name, sortName As Sort, sName As Status FROM v_quick_report_category WHERE 0=0
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND UPPER(qrcName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">
    </cfif>
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsQuickReportCategoryReport = StructNew()>
    <cfset rsQuickReportCategoryReport.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsQuickReportCategoryReport>
    </cffunction>
    
    <cffunction name="getQuickReportTypeReport" access="public" returntype="query" hint="Get Quick Report Type Report data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="orderBy" type="string" required="yes" default="qrtName">
    <cfset var rsQuickReportTypeReport = "" >
    <cftry>
    <cfquery name="rsQuickReportTypeReport" datasource="#application.mcmsDSN#">
    SELECT qrtName As Name, sortName As Sort, sName As status FROM v_quick_report_type WHERE 0=0
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND UPPER(qrtName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">
    </cfif>
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsQuickReportTypeReport = StructNew()>
    <cfset rsQuickReportTypeReport.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsQuickReportTypeReport>
    </cffunction>
    
    <cffunction name="insertQuickReport" access="public" returntype="struct">
    <cfargument name="qrName" type="string" required="yes">
    <cfargument name="qrDescription" type="string" required="yes">
    <cfargument name="appID" type="numeric" required="yes">
    <cfargument name="qrComponent" type="string" required="yes">
    <cfargument name="qrMethod" type="string" required="yes">
    <cfargument name="qrcID" type="numeric" required="yes">
    <cfargument name="qrtID" type="numeric" required="yes">
    <cfargument name="netID" type="numeric" required="yes">
    <cfargument name="qrSort" type="numeric" required="yes">
    <cfargument name="qrStatus" type="numeric" required="yes">
    <!---Relationship arguments.--->
    <cfargument name="siteNo" type="string" required="yes">
    <cfargument name="deptNo" type="string" required="yes">
    <cfset result.message = "You have successfully inserted the record.">
    <cftry>
    <!---Check for profanity in the text.--->
    <cfinvoke 
    component="MCMS.component.utility.Regex"
    method="regexProfanity"
    returnvariable="regexProfanityRet">
    <cfinvokeargument name="profanityString" value="#ARGUMENTS.qrDescription#"/>
    </cfinvoke>
    <!---Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.app.quick_report.QuickReport"
    method="getQuickReport"
    returnvariable="getCheckQuickReportRet">
    <cfinvokeargument name="qrName" value="#ARGUMENTS.qrName#"/>
    <cfinvokeargument name="qrStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckQuickReportRet.recordcount NEQ 0>
    <cfset result.message = "The name #ARGUMENTS.qrName# already exists, please enter a new name.">
    <cfelseif regexProfanityRet CONTAINS '$%&*!'>
    <cfset result.message = "Some text contained profanity, please remove any profanity from your text.">
    <!---Check length restriction.--->
    <cfelseif LEN(ARGUMENTS.qrDescription) GT 1024>
    <cfset result.message = "The description is longer than 1024 characters, please enter a new description under 1024 characters.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    INSERT INTO tbl_quick_report (qrName,qrDescription,appID,qrComponent,qrMethod,qrcID,qrtID,netID,qrSort,qrStatus) VALUES
    (
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.qrName#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.qrDescription#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.appID#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.qrComponent#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.qrMethod#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.qrcID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.qrtID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.netID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.qrSort#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.qrStatus#">
    )
    </cfquery>
    </cftransaction>
    <!--- Get newly inserted auction ID. --->
    <cfinvoke 
    component="MCMS.component.cms.Cms"
    method="getMaxValueSQL"
    returnvariable="qrID">
    <cfinvokeargument name="tableName" value="tbl_quick_report"/>
    </cfinvoke>
    <cfset var.qrID = qrID>
    <!---Create site relationships.--->
    <cfloop index="siteNo" list="#ARGUMENTS.siteNo#">
    <cfinvoke 
    component="MCMS.component.app.quick_report.QuickReport"
    method="insertQuickReportSiteRel"
    returnvariable="insertQuickReportSiteRelRet">
    <cfinvokeargument name="qrID" value="#var.qrID#"/>
    <cfinvokeargument name="siteNo" value="#ARGUMENTS.siteNo#"/>
    <cfinvokeargument name="qrsrStatus" value="1"/>
    </cfinvoke>
    </cfloop>
    <!---Create department relationships.--->
    <cfloop index="deptNo" list="#ARGUMENTS.deptNo#">
    <cfinvoke 
    component="MCMS.component.app.quick_report.QuickReport"
    method="insertQuickReportDepartmentRel"
    returnvariable="insertQuickReportDepartmentRelRet">
    <cfinvokeargument name="qrID" value="#var.qrID#"/>
    <cfinvokeargument name="deptNo" value="#ARGUMENTS.deptNo#"/>
    <cfinvokeargument name="qrdrStatus" value="1"/>
    </cfinvoke>
    </cfloop>
    </cfif>
    <cfcatch type="any">
    <cfset result.message = "There was an error inserting the record.">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="insertQuickReportType" access="public" returntype="struct">
    <cfargument name="qrtName" type="string" required="yes">
    <cfargument name="qrtSort" type="numeric" required="yes">
    <cfargument name="qrtStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully inserted the record.">
    <cftry>
    <!---Check for profanity in the text.--->
    <cfinvoke 
    component="MCMS.component.utility.Regex"
    method="regexProfanity"
    returnvariable="regexProfanityRet">
    <cfinvokeargument name="profanityString" value="#ARGUMENTS.qrtName#"/>
    </cfinvoke>
    <!---Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.app.quick_report.QuickReport"
    method="getQuickReportType"
    returnvariable="getCheckQuickReportTypeRet">
    <cfinvokeargument name="qrtName" value="#ARGUMENTS.qrtName#"/>
    <cfinvokeargument name="qrtStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckQuickReportTypeRet.recordcount NEQ 0>
    <cfset result.message = "The name #ARGUMENTS.qrtName# already exists, please enter a new name.">
    <cfelseif regexProfanityRet CONTAINS '$%&*!'>
    <cfset result.message = "Some text contained profanity, please remove any profanity from your text.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    INSERT INTO tbl_quick_report_type (qrtName,qrtSort,qrtStatus) VALUES
    (
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.qrtName#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.qrtSort#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.qrtStatus#">
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
    
    <cffunction name="insertQuickReportCategory" access="public" returntype="struct">
    <cfargument name="qrcName" type="string" required="yes">
    <cfargument name="qrcSort" type="numeric" required="yes">
    <cfargument name="qrcStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully inserted the record.">
    <cftry>
    <!---Check for profanity in the text.--->
    <cfinvoke 
    component="MCMS.component.utility.Regex"
    method="regexProfanity"
    returnvariable="regexProfanityRet">
    <cfinvokeargument name="profanityString" value="#ARGUMENTS.qrcName#"/>
    </cfinvoke>
    <!---Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.app.quick_report.QuickReport"
    method="getQuickReportCategory"
    returnvariable="getCheckQuickReportCategoryRet">
    <cfinvokeargument name="qrcName" value="#ARGUMENTS.qrcName#"/>
    <cfinvokeargument name="qrcStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckQuickReportCategoryRet.recordcount NEQ 0>
    <cfset result.message = "The name #ARGUMENTS.qrcName# already exists, please enter a new name.">
    <cfelseif regexProfanityRet CONTAINS '$%&*!'>
    <cfset result.message = "Some text contained profanity, please remove any profanity from your text.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    INSERT INTO tbl_quick_report_category (qrcName,qrcSort,qrcStatus) VALUES
    (
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.qrcName#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.qrcSort#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.qrcStatus#">
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
    
    <cffunction name="insertQuickReportSiteRel" access="public" returntype="struct">
    <cfargument name="qrID" type="numeric" required="yes">
    <cfargument name="siteNo" type="numeric" required="yes">
    <cfargument name="qrsrStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully inserted the record.">
    <cftry>
    <!---Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.app.quick_report.QuickReport"
    method="getQuickReportSiteRel"
    returnvariable="getCheckQuickReportSiteRelRet">
    <cfinvokeargument name="qrID" value="#ARGUMENTS.qrID#"/>
    <cfinvokeargument name="siteNo" value="#ARGUMENTS.siteNo#"/>
    <cfinvokeargument name="qrsrStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckQuickReportSiteRelRet.recordcount NEQ 0>
    <cfset result.message = "The quick report site relationship already exists, please try again.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    INSERT INTO tbl_quick_report_site_rel (qrID,siteNo,qrsrStatus) VALUES
    (
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.qrID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.siteNo#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.qrsrStatus#">
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
    
    <cffunction name="insertQuickReportDepartmentRel" access="public" returntype="struct">
    <cfargument name="qrID" type="numeric" required="yes">
    <cfargument name="deptNo" type="numeric" required="yes">
    <cfargument name="qrdrStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully inserted the record.">
    <cftry>
    <!---Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.app.quick_report.QuickReport"
    method="getQuickReportDepartmentRel"
    returnvariable="getCheckQuickReportDepartmentRelRet">
    <cfinvokeargument name="qrID" value="#ARGUMENTS.qrID#"/>
    <cfinvokeargument name="deptNo" value="#ARGUMENTS.deptNo#"/>
    <cfinvokeargument name="qrdrStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckQuickReportDepartmentRelRet.recordcount NEQ 0>
    <cfset result.message = "The quick report department relationship already exists, please try again.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    INSERT INTO tbl_qr_department_rel (qrID,deptNo,qrdrStatus) VALUES
    (
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.qrID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.deptNo#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.qrdrStatus#">
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
    
    <cffunction name="updateQuickReport" access="public" returntype="struct">
    <cfargument name="ID" type="numeric" required="yes">
    <cfargument name="qrName" type="string" required="yes">
    <cfargument name="qrDescription" type="string" required="yes">
    <cfargument name="appID" type="numeric" required="yes">
    <cfargument name="qrComponent" type="string" required="yes">
    <cfargument name="qrMethod" type="string" required="yes">
    <cfargument name="qrcID" type="numeric" required="yes">
    <cfargument name="qrtID" type="numeric" required="yes">
    <cfargument name="netID" type="numeric" required="yes">
    <cfargument name="qrSort" type="numeric" required="yes">
    <cfargument name="qrStatus" type="numeric" required="yes">
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
    <cfinvokeargument name="profanityString" value="#ARGUMENTS.qrDescription#"/>
    </cfinvoke>
    <!---Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.app.quick_report.QuickReport"
    method="getQuickReport"
    returnvariable="getCheckQuickReportRet">
    <cfinvokeargument name="excludeID" value="#ARGUMENTS.ID#"/>
    <cfinvokeargument name="qrName" value="#ARGUMENTS.qrName#"/>
    <cfinvokeargument name="qrStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckQuickReportRet.recordcount NEQ 0>
    <cfset result.message = "The name #ARGUMENTS.qrName# already exists, please enter a new name.">
    <cfelseif regexProfanityRet CONTAINS '$%&*!'>
    <cfset result.message = "Some text contained profanity, please remove any profanity from your text.">
    <!---Check length restriction.--->
    <cfelseif LEN(ARGUMENTS.qrDescription) GT 1024>
    <cfset result.message = "The description is longer than 1024 characters, please enter a new description under 1024 characters.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_quick_report SET
    qrName = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.qrName#">,
    qrDescription = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.qrDescription#">,
    appID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.appID#">,
    qrComponent = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.qrComponent#">,
    qrMethod = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.qrMethod#">,
    qrcID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.qrcID#">,
    qrtID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.qrtID#">,
    netID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.netID#">,
    qrSort = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.qrSort#">,
    qrStatus = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.qrStatus#">
    WHERE ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ID#">
    </cfquery>
    </cftransaction>
    <!---Delete any existing relationships.--->
    <cfinvoke 
    component="MCMS.component.app.quick_report.QuickReport"
    method="deleteQuickReportSiteRel"
    returnvariable="deleteQuickReportSiteRelRet">
    <cfinvokeargument name="qrID" value="#ARGUMENTS.ID#"/>
    </cfinvoke>
    <cfinvoke 
    component="MCMS.component.app.quick_report.QuickReport"
    method="deleteQuickReportDepartmentRel"
    returnvariable="deleteQuickReportDepartmentRelRet">
    <cfinvokeargument name="qrID" value="#ARGUMENTS.ID#"/>
    </cfinvoke>
    <!---Create site relationships.--->
    <cfloop index="siteNo" list="#ARGUMENTS.siteNo#">
    <cfinvoke 
    component="MCMS.component.app.quick_report.QuickReport"
    method="insertQuickReportSiteRel"
    returnvariable="insertQuickReportSiteRelRet">
    <cfinvokeargument name="qrID" value="#ARGUMENTS.ID#"/>
    <cfinvokeargument name="siteNo" value="#ARGUMENTS.siteNo#"/>
    <cfinvokeargument name="qrsrStatus" value="1"/>
    </cfinvoke>
    </cfloop>
    <!---Create department relationships.--->
    <cfloop index="deptNo" list="#ARGUMENTS.deptNo#">
    <cfinvoke 
    component="MCMS.component.app.quick_report.QuickReport"
    method="insertQuickReportDepartmentRel"
    returnvariable="insertQuickReportDepartmentRelRet">
    <cfinvokeargument name="qrID" value="#ARGUMENTS.ID#"/>
    <cfinvokeargument name="deptNo" value="#ARGUMENTS.deptNo#"/>
    <cfinvokeargument name="qrdrStatus" value="1"/>
    </cfinvoke>
    </cfloop>
    </cfif>
    <cfcatch type="any">
    <cfset result.message = "There was an error updating the record.">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="updateQuickReportCategory" access="public" returntype="struct">
    <cfargument name="ID" type="numeric" required="yes">
    <cfargument name="qrcName" type="string" required="yes">
    <cfargument name="qrcSort" type="numeric" required="yes">
    <cfargument name="qrcStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully updated the record.">
    <cftry>
    <!---Check for profanity in the text.--->
    <cfinvoke 
    component="MCMS.component.utility.Regex"
    method="regexProfanity"
    returnvariable="regexProfanityRet">
    <cfinvokeargument name="profanityString" value="#ARGUMENTS.qrcName#"/>
    </cfinvoke>
    <!---Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.app.quick_report.QuickReport"
    method="getQuickReportCategory"
    returnvariable="getCheckQuickReportCategoryRet">
    <cfinvokeargument name="excludeID" value="#ARGUMENTS.ID#"/>
    <cfinvokeargument name="qrcName" value="#ARGUMENTS.qrcName#"/>
    <cfinvokeargument name="qrcStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckQuickReportCategoryRet.recordcount NEQ 0>
    <cfset result.message = "The name #ARGUMENTS.qrcName# already exists, please enter a new name.">
    <cfelseif regexProfanityRet CONTAINS '$%&*!'>
    <cfset result.message = "Some text contained profanity, please remove any profanity from your text.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_quick_report_category SET
    qrcName = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.qrcName#">,
    qrcSort = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.qrcSort#">,
    qrcStatus = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.qrcStatus#">
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
    
    <cffunction name="updateQuickReportType" access="public" returntype="struct">
    <cfargument name="ID" type="numeric" required="yes">
    <cfargument name="qrtName" type="string" required="yes">
    <cfargument name="qrtSort" type="numeric" required="yes">
    <cfargument name="qrtStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully updated the record.">
    <cftry>
    <!---Check for profanity in the text.--->
    <cfinvoke 
    component="MCMS.component.utility.Regex"
    method="regexProfanity"
    returnvariable="regexProfanityRet">
    <cfinvokeargument name="profanityString" value="#ARGUMENTS.qrtName#"/>
    </cfinvoke>
    <!---Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.app.quick_report.QuickReport"
    method="getQuickReportType"
    returnvariable="getQuickReportTypeRet">
    <cfinvokeargument name="excludeID" value="#ARGUMENTS.ID#"/>
    <cfinvokeargument name="qrtName" value="#ARGUMENTS.qrtName#"/>
    <cfinvokeargument name="qrtStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getQuickReportTypeRet.recordcount NEQ 0>
    <cfset result.message = "The name #ARGUMENTS.qrtName# already exists, please enter a new name.">
    <cfelseif regexProfanityRet CONTAINS '$%&*!'>
    <cfset result.message = "Some text contained profanity, please remove any profanity from your text.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_quick_report_type SET
    qrtName = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.qrtName#">,
    qrtSort = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.qrtSort#">,
    qrtStatus = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.qrtStatus#">
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
    
    <cffunction name="updateQuickReportList" access="public" returntype="struct">
    <cfargument name="ID" type="numeric" required="yes">
    <cfargument name="qrStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully updated the records.">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_quick_report SET
    qrStatus = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.qrStatus#">
    WHERE ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ID#">
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error updating the records.">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="updateQuickReportCategoryList" access="public" returntype="struct">
    <cfargument name="ID" type="numeric" required="yes">
    <cfargument name="qrcStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully updated the records.">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_quick_report_category SET
    qrcStatus = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.qrcStatus#">
    WHERE ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ID#">
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error updating the records.">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="updateQuickReportTypeList" access="public" returntype="struct">
    <cfargument name="ID" type="numeric" required="yes">
    <cfargument name="qrtStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully updated the records.">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_quick_report_type SET
    qrtStatus = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.qrtStatus#">
    WHERE ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ID#">
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error updating the records.">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="deleteQuickReport" access="public" returntype="struct">
    <cfargument name="ID" type="string" required="yes">
    <cfset result.message = "You have successfully deleted the record(s).">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    DELETE FROM tbl_quick_report
    WHERE ID IN (<cfqueryparam cfsqltype="cf_sql_integer" list="yes" value="#ARGUMENTS.ID#">)
    </cfquery>
    </cftransaction>
    <cfinvoke 
    component="MCMS.component.app.quick_report.QuickReport"
    method="deleteQuickReportSiteRel"
    returnvariable="deleteQuickReportSiteRelRet">
    <cfinvokeargument name="qrID" value="#ARGUMENTS.ID#"/>
    </cfinvoke>
    <cfinvoke 
    component="MCMS.component.app.quick_report.QuickReport"
    method="deleteQuickReportDepartmentRel"
    returnvariable="deleteQuickReportDepartmentRelRet">
    <cfinvokeargument name="qrID" value="#ARGUMENTS.ID#"/>
    </cfinvoke>
    <cfcatch type="any">
    <cfset result.message = "There was an error deleting the record(s).">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="deleteQuickReportCategory" access="public" returntype="struct">
    <cfargument name="ID" type="string" required="yes">
    <cfset result.message = "You have successfully deleted the record(s).">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    DELETE FROM tbl_quick_report_category
    WHERE ID IN (<cfqueryparam cfsqltype="cf_sql_integer" list="yes" value="#ARGUMENTS.ID#">)
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error deleting the record(s).">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="deleteQuickReportType" access="public" returntype="struct">
    <cfargument name="ID" type="string" required="yes">
    <cfset result.message = "You have successfully deleted the record(s).">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    DELETE FROM tbl_quick_report_type
    WHERE ID IN (<cfqueryparam cfsqltype="cf_sql_integer" list="yes" value="#ARGUMENTS.ID#">)
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error deleting the record(s).">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction> 
    
    <cffunction name="deleteQuickReportSiteRel" access="public" returntype="struct">
    <cfargument name="ID" type="string" required="yes" default="0">
    <cfargument name="qrID" type="string" required="yes" default="0">
    <cfset result.message = "You have successfully deleted the record(s).">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    DELETE FROM tbl_quick_report_site_rel
    WHERE ID IN (<cfqueryparam cfsqltype="cf_sql_integer" list="yes" value="#ARGUMENTS.ID#">)
    OR qrID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.qrID#">
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error deleting the record(s).">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>  
    
    <cffunction name="deleteQuickReportDepartmentRel" access="public" returntype="struct">
    <cfargument name="ID" type="string" required="yes" default="0">
    <cfargument name="qrID" type="string" required="yes" default="0">
    <cfset result.message = "You have successfully deleted the record(s).">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    DELETE FROM tbl_qr_department_rel
    WHERE ID IN (<cfqueryparam cfsqltype="cf_sql_integer" list="yes" value="#ARGUMENTS.ID#">)
    OR qrID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.qrID#">
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error deleting the record(s).">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="getQuickReportFunction" access="public" returntype="string" output="yes" description="Gets the Quick Report Function and renders it to report type.">
    <cfargument name="reportName" type="string" required="yes" default="report">
    <cfargument name="reportType" type="string" required="yes" default="EXCEL">
    <cfargument name="reportCFC" type="string" required="yes">
    <cfargument name="reportFunction" type="string" required="yes">
    <cfargument name="args" type="string" required="yes" default="0">
    <cftry>
    <!---Check the report type.--->
    <cfswitch expression="#ARGUMENTS.reportType#">
    <cfcase value="EXCEL">
    <cfinvoke 
    component="#application.mcmsComponentPath#/cms/Cms"
    method="getReportFunction"
    returnvariable="getReportFunctionRet">
    <cfinvokeargument name="reportName" value="#arguments.reportName#"/>
    <cfinvokeargument name="reportType" value="#arguments.reportType#"/>
    <cfinvokeargument name="reportCFC" value="#arguments.reportCFC#"/>
    <cfinvokeargument name="reportFunction" value="#arguments.reportFunction#"/>
    <cfinvokeargument name="args" value="#arguments.args#"/>
    </cfinvoke>
    <cfoutput>#getReportQueryRet#</cfoutput>
    </cfcase>
    <cfcase value="PDF">
    <cfinvoke 
    component="#application.mcmsComponentPath#/#ARGUMENTS.reportCFC#" 
    method="#ARGUMENTS.reportFunction#" 
    returnvariable="result">
    </cfinvoke>
    <cfoutput>#result#</cfoutput>
    </cfcase>
    <cfcase value="WORD">
    <cfinvoke 
    component="#application.mcmsComponentPath#/#ARGUMENTS.reportCFC#" 
    method="#ARGUMENTS.reportFunction#" 
    returnvariable="result">
    </cfinvoke>
    <cfoutput>#result#</cfoutput>
    </cfcase>
    <cfdefaultcase>
    No reports available or the setting are incorrect.
    </cfdefaultcase>
    </cfswitch>
    <cfcatch type="any">
    <cfif url.mcmsDebug EQ 'true'>
    <div align="center">
    <span class="glyphicon glyphicon-exclamation-sign"></span><br /><br />
    An error occurred. You may require to modify the modules Quick Report stetings. No reports available.<br /><br />
    <a href="javascript:window.close();">Close This Window</a>
    </div>
    <cfelse>
    <cfdump var="#cfcatch#">
    </cfif>
    </cfcatch>
    </cftry>
    <cfabort>
    <cfreturn quickReportFunctionResult>
    </cffunction> 
</cfcomponent>