<cfcomponent>
    <cffunction name="getDailyBulletin" access="public" returntype="query" hint="Get Daily Bulletin data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="ID" type="string" required="yes" default="0">
    <cfargument name="userID" type="numeric" required="yes" default="0">
    <cfargument name="excludeID" type="numeric" required="yes" default="0">
    <cfargument name="dateRange" type="string" required="yes" default="false">
    <cfargument name="bDateRel" type="string" required="yes" default="">
    <cfargument name="bDateExp" type="string" required="yes" default="">
    <cfargument name="bDateRelEQ" type="string" required="yes" default="">
    <cfargument name="bDateExpEQ" type="string" required="yes" default="">
    <cfargument name="bName" type="string" required="yes" default="">
    <cfargument name="userStatus" type="string" required="no" default="1">
    <cfargument name="bStatus" type="string" required="yes" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="bName">
    <cfset var rsDailyBulletin = "" >
    <cftry>
    <cfquery name="rsDailyBulletin" datasource="#application.mcmsDSN#">
    SELECT * FROM v_bulletin WHERE 0=0
    <cfif ARGUMENTS.ID NEQ 0>
    AND ID IN (<cfqueryparam value="#ARGUMENTS.ID#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    <cfif ARGUMENTS.userID NEQ 0>
    AND userID = <cfqueryparam value="#ARGUMENTS.userID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.excludeID NEQ 0>
    AND ID <> <cfqueryparam value="#ARGUMENTS.excludeID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(bName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(bDescription) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">)
    </cfif>
    <!---Date Range.--->
    <cfif ARGUMENTS.dateRange EQ "true">
    <cfif ARGUMENTS.bDateRel NEQ "">
    AND bDateRel <= <cfqueryparam value="#ARGUMENTS.bDateRel#" cfsqltype="cf_sql_date">
    </cfif>
    <cfif ARGUMENTS.bDateExp NEQ "">
    AND bDateExp >= <cfqueryparam value="#ARGUMENTS.bDateExp#" cfsqltype="cf_sql_date">
	</cfif>
    <cfelse>
    <cfif ARGUMENTS.bDateRel NEQ "">
    AND bDateRel <= <cfqueryparam value="#ARGUMENTS.bDateRel#" cfsqltype="cf_sql_date">
    </cfif>
    <cfif ARGUMENTS.bDateExp NEQ "">
    AND bDateExp >= <cfqueryparam value="#ARGUMENTS.bDateExp#" cfsqltype="cf_sql_date">
	</cfif>
    </cfif>
    <cfif ARGUMENTS.bDateRelEQ NEQ "">
    AND bDateRel = <cfqueryparam value="#ARGUMENTS.bDateRelEQ#" cfsqltype="cf_sql_date">
    </cfif>
    <cfif ARGUMENTS.bDateExpEQ NEQ "">
    AND bDateExp = <cfqueryparam value="#ARGUMENTS.bDateExpEQ#" cfsqltype="cf_sql_date">
	</cfif>
    <cfif ARGUMENTS.bName NEQ "">
    AND UPPER(bName) = <cfqueryparam value="#UCASE(ARGUMENTS.bName)#" cfsqltype="cf_sql_varchar">
    </cfif>
    AND userStatus IN (<cfqueryparam value="#ARGUMENTS.userStatus#" list="yes" cfsqltype="cf_sql_integer">)
    AND bStatus IN (<cfqueryparam value="#ARGUMENTS.bStatus#" list="yes" cfsqltype="cf_sql_integer">)
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsDailyBulletin = StructNew()>
    <cfset rsDailyBulletin.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsDailyBulletin>
    </cffunction>
    
    <cffunction name="getDailyBulletinSiteRel" access="public" returntype="query" hint="Get Daily Bulletin Site Relationship data.">
    <cfargument name="keywords" type="string" required="no" default="All">
    <cfargument name="ID" type="numeric" required="yes" default="0">
    <cfargument name="excludeID" type="numeric" required="yes" default="0">
    <cfargument name="bID" type="string" required="yes" default="0">
    <cfargument name="siteNo" type="string" required="yes" default="100">
    <cfargument name="bDateRel" type="string" required="yes" default="">
    <cfargument name="bDateExp" type="string" required="yes" default="">
    <cfargument name="siteStatus" type="string" required="no" default="1">
    <cfargument name="bsrStatus" type="string" required="yes" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="siteNo">
	<cfset var rsDailyBulletinSiteRel = "" >
    <cftry>
    <cfquery name="rsDailyBulletinSiteRel" datasource="#application.mcmsDSN#">
    SELECT * FROM v_bulletin_site_rel WHERE 0=0
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND siteNo LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> 
    </cfif>
    <cfif ARGUMENTS.ID NEQ 0>
    AND ID = <cfqueryparam value="#ARGUMENTS.ID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.excludeID NEQ 0>
    AND ID <> <cfqueryparam value="#ARGUMENTS.excludeID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.bID NEQ 0>
    AND bID IN (<cfqueryparam value="#ARGUMENTS.bID#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    <cfif ARGUMENTS.siteNo NEQ 100>
    AND siteNo IN (<cfqueryparam value="#ARGUMENTS.siteNo#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    <cfif ARGUMENTS.bDateRel NEQ "">
    AND bDateRel <= <cfqueryparam value="#ARGUMENTS.bDateRel#" cfsqltype="cf_sql_date">
    </cfif>
    <cfif ARGUMENTS.bDateExp NEQ "">
    AND bDateExp >= <cfqueryparam value="#ARGUMENTS.bDateExp#" cfsqltype="cf_sql_date">
	</cfif>
    AND (siteStatus IN (<cfqueryparam value="#ARGUMENTS.siteStatus#" list="yes" cfsqltype="cf_sql_integer">) OR siteStatus IS NULL)
    AND bsrStatus IN (<cfqueryparam value="#ARGUMENTS.bsrStatus#" list="yes" cfsqltype="cf_sql_integer">)
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsDailyBulletinSiteRel = StructNew()>
    <cfset rsDailyBulletinSiteRel.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsDailyBulletinSiteRel>
    </cffunction>
    
    <cffunction name="getDailyBulletinDepartmentRel" access="public" returntype="query" hint="Get Daily Bulletin Department Relationship data.">
    <cfargument name="keywords" type="string" required="no" default="All">
    <cfargument name="ID" type="numeric" required="yes" default="0">
    <cfargument name="excludeID" type="numeric" required="yes" default="0">
    <cfargument name="bID" type="string" required="yes" default="0">
    <cfargument name="deptNo" type="string" required="yes" default="0">
    <cfargument name="bDateRel" type="string" required="yes" default="">
    <cfargument name="bDateExp" type="string" required="yes" default="">
    <cfargument name="deptStatus" type="string" required="no" default="1">
    <cfargument name="bStatus" type="string" required="yes" default="1,3">
    <cfargument name="bdrStatus" type="string" required="yes" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="deptNo">
	<cfset var rsDailyBulletinDepartmentRel = "" >
    <cftry>
    <cfquery name="rsDailyBulletinDepartmentRel" datasource="#application.mcmsDSN#">
    SELECT * FROM v_bulletin_department_rel WHERE 0=0
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND deptNo LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> 
    </cfif>
    <cfif ARGUMENTS.ID NEQ 0>
    AND ID = <cfqueryparam value="#ARGUMENTS.ID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.excludeID NEQ 0>
    AND ID <> <cfqueryparam value="#ARGUMENTS.excludeID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.bID NEQ 0>
    AND bID IN (<cfqueryparam value="#ARGUMENTS.bID#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    <cfif ARGUMENTS.deptNo NEQ 0>
    AND deptNo IN (<cfqueryparam value="#ARGUMENTS.deptNo#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    <cfif ARGUMENTS.bDateRel NEQ "">
    AND bDateRel <= <cfqueryparam value="#ARGUMENTS.bDateRel#" cfsqltype="cf_sql_date">
    </cfif>
    <cfif ARGUMENTS.bDateExp NEQ "">
    AND bDateExp >= <cfqueryparam value="#ARGUMENTS.bDateExp#" cfsqltype="cf_sql_date">
	</cfif>
    AND (deptStatus IN (<cfqueryparam value="#ARGUMENTS.deptStatus#" list="yes" cfsqltype="cf_sql_integer">) OR deptStatus IS NULL)
    AND bStatus IN (<cfqueryparam value="#ARGUMENTS.bStatus#" list="yes" cfsqltype="cf_sql_integer">)
    AND bdrStatus IN (<cfqueryparam value="#ARGUMENTS.bdrStatus#" list="yes" cfsqltype="cf_sql_integer">)
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsDailyBulletinDepartmentRel = StructNew()>
    <cfset rsDailyBulletinDepartmentRel.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsDailyBulletinDepartmentRel>
    </cffunction>
    
    <cffunction name="getDailyBulletinDocumentRel" access="public" returntype="query" hint="Get Daily Bulletin Document Rel. data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="ID" type="numeric" required="yes" default="0">
    <cfargument name="excludeID" type="numeric" required="yes" default="0">
    <cfargument name="docName" type="string" required="yes" default="">
    <cfargument name="bID" type="string" required="yes" default="0">
    <cfargument name="docID" type="string" required="yes" default="0">
    <cfargument name="netStatus" type="string" required="no" default="1">
    <cfargument name="docStatus" type="string" required="no" default="1">
    <cfargument name="bStatus" type="string" required="yes" default="1">
    <cfargument name="bdrStatus" type="string" required="yes" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="docName">
    <cfset var rsDailyBulletinDocumentRel = "" >
    <cftry>
    <cfquery name="rsDailyBulletinDocumentRel" datasource="#application.mcmsDSN#">
    SELECT * FROM v_bulletin_document_rel WHERE 0=0
    <cfif ARGUMENTS.ID NEQ 0>
    AND ID = <cfqueryparam value="#ARGUMENTS.ID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.excludeID NEQ 0>
    AND ID <> <cfqueryparam value="#ARGUMENTS.excludeID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(bName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(docName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">)
    </cfif>
    <cfif ARGUMENTS.docName NEQ "">
    AND UPPER(docName) = <cfqueryparam value="#UCASE(ARGUMENTS.docName)#" cfsqltype="cf_sql_varchar">
    </cfif>
    <cfif ARGUMENTS.bID NEQ 0>
    AND bID = <cfqueryparam value="#ARGUMENTS.bID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.docID NEQ 0>
    AND docID = <cfqueryparam value="#ARGUMENTS.docID#" cfsqltype="cf_sql_integer">
    </cfif>
    AND netStatus IN (<cfqueryparam value="#ARGUMENTS.netStatus#" list="yes" cfsqltype="cf_sql_integer">)
    AND docStatus IN (<cfqueryparam value="#ARGUMENTS.docStatus#" list="yes" cfsqltype="cf_sql_integer">)
    AND bStatus IN (<cfqueryparam value="#ARGUMENTS.bStatus#" list="yes" cfsqltype="cf_sql_integer">)
    AND bdrStatus IN (<cfqueryparam value="#ARGUMENTS.bdrStatus#" list="yes" cfsqltype="cf_sql_integer">)
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsDailyBulletinDocumentRel = StructNew()>
    <cfset rsDailyBulletinDocumentRel.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsDailyBulletinDocumentRel>
    </cffunction>
    
    <cffunction name="getDailyBulletinImageRel" access="public" returntype="any" hint="Get Daily Bulletin Image Rel. data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="ID" type="numeric" required="yes" default="0">
    <cfargument name="excludeID" type="numeric" required="yes" default="0">
    <cfargument name="bName" type="string" required="yes" default="">
    <cfargument name="bID" type="string" required="yes" default="0">
    <cfargument name="imgID" type="string" required="yes" default="0">
    <cfargument name="netStatus" type="string" required="no" default="1">
    <cfargument name="imgStatus" type="string" required="no" default="1">
    <cfargument name="bStatus" type="string" required="no" default="1">
    <cfargument name="birStatus" type="string" required="yes" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="bName">
    <cfset var rsDailyBulletinImageRel = "">
    <cftry>
    <cfquery name="rsDailyBulletinImageRel" datasource="#application.mcmsDSN#">
    SELECT * FROM v_bulletin_image_rel WHERE 0=0
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(bName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(imgName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">)
    </cfif>
    <cfif ARGUMENTS.ID NEQ 0>
    AND ID = <cfqueryparam value="#ARGUMENTS.ID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.excludeID NEQ 0>
    AND ID <> <cfqueryparam value="#ARGUMENTS.excludeID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.bName NEQ "">
    AND bName = <cfqueryparam value="#ARGUMENTS.bName#" cfsqltype="cf_sql_varchar">
    </cfif>
    <cfif ARGUMENTS.bID NEQ 0>
    AND bID = <cfqueryparam value="#ARGUMENTS.bID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.imgID NEQ 0>
    AND imgID = <cfqueryparam value="#ARGUMENTS.imgID#" cfsqltype="cf_sql_integer">
    </cfif>
    AND netStatus IN (<cfqueryparam value="#ARGUMENTS.netStatus#" list="yes" cfsqltype="cf_sql_integer">)
    AND imgStatus IN (<cfqueryparam value="#ARGUMENTS.imgStatus#" list="yes" cfsqltype="cf_sql_integer">)
    AND bStatus IN (<cfqueryparam value="#ARGUMENTS.bStatus#" list="yes" cfsqltype="cf_sql_integer">)
    AND birStatus IN (<cfqueryparam value="#ARGUMENTS.birStatus#" list="yes" cfsqltype="cf_sql_integer">)
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsDailyBulletinImageRel = StructNew()>
    <cfset rsDailyBulletinImageRel.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsDailyBulletinImageRel>
    </cffunction>
    
    <cffunction name="getDailyBulletinReport" access="public" returntype="query" hint="Get Daily Bulletin Report data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="args" type="string" required="yes" default="0">
    <cfargument name="orderBy" type="string" required="yes" default="bName">
    <cfset var rsDailyBulletinReport = "" >
    <cftry>
    <cfquery name="rsDailyBulletinReport" datasource="#application.mcmsDSN#">
    SELECT bName AS Name, TO_CHAR(bDate, 'MM/DD/YYYY') AS b_date, TO_CHAR(bDateRel, 'MM/DD/YYYY') AS date_start, TO_CHAR(bDateExp, 'MM/DD/YYYY') AS date_expires, userfName || ' ' || userlName as b_user, bStatus AS status FROM v_bulletin WHERE 0=0
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(bName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(bDescription) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">)
    </cfif>
    <cfif ARGUMENTS.args NEQ 0>
    <cfif ListGetAt(ARGUMENTS.args, 1) NEQ 0>
    AND bDateRel >= <cfqueryparam value="#ListGetAt(ARGUMENTS.args, 1)#" list="yes" cfsqltype="cf_sql_date">
    </cfif>
    <cfif ListGetAt(ARGUMENTS.args, 2) NEQ 0>
    AND bDateExp <= <cfqueryparam value="#ListGetAt(ARGUMENTS.args, 2)#" list="yes" cfsqltype="cf_sql_date">
    </cfif>
    </cfif>
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsDailyBulletinReport = StructNew()>
    <cfset rsDailyBulletinReport.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsDailyBulletinReport>
    </cffunction>
    
    <cffunction name="getDailyBulletinExcelQuickReport" access="public" returntype="query" hint="Get Daily Bulletin Excel Quick Report data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="bStatus" type="string" required="yes" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="bName">
    <cfset var rsDailyBulletinReport = "" >
    <cftry>
    <cfquery name="getDailyBulletinExcelQuickReport" datasource="#application.mcmsDSN#">
    SELECT bName AS Name, TO_CHAR(bDate, 'MM/DD/YYYY') AS b_date, TO_CHAR(bDateRel, 'MM/DD/YYYY') AS date_start, TO_CHAR(bDateExp, 'MM/DD/YYYY') AS date_expires, userfName || ' ' || userlName as b_user, bStatus AS status FROM v_bulletin WHERE 0=0
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(bName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(bDescription) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">)
    </cfif>
    AND bDateExp >= <cfqueryparam value="#Now()#" cfsqltype="cf_sql_date">
    AND bStatus IN (<cfqueryparam value="#ARGUMENTS.bStatus#" list="yes" cfsqltype="cf_sql_integer">)
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset getDailyBulletinExcelQuickReport = StructNew()>
    <cfset getDailyBulletinExcelQuickReport.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn getDailyBulletinExcelQuickReport>
    </cffunction>
    
    <cffunction name="getDailyBulletinDocumentRelReport" access="public" returntype="query" hint="Get Daily Bulletin Document Report Rel. data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="orderBy" type="string" required="yes" default="docName">
    <cfset var rsDailyBulletinDocumentRelReport = "" >
    <cftry>
    <cfquery name="rsDailyBulletinDocumentRelReport" datasource="#application.mcmsDSN#">
    SELECT docName AS Name, bName As Bulletin_Name, docDescription As Description, docFile AS Doc_File, TO_CHAR(docDate, 'MM/DD/YYYY') AS Doc_Date, sname AS Status FROM v_bulletin_document_rel WHERE 0=0
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(docName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(docDescription) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">)
    </cfif>
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsDailyBulletinDocumentRelReport = StructNew()>
    <cfset rsDailyBulletinDocumentRelReport.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsDailyBulletinDocumentRelReport>
    </cffunction>
    
    <cffunction name="getDailyBulletinImageRelReport" access="public" returntype="query" hint="Get Daily Bulletin Image Report Rel. data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="orderBy" type="string" required="yes" default="bName">
    <cfset var rsDailyBulletinImageRelReport = "" >
    <cftry>
    <cfquery name="rsDailyBulletinImageRelReport" datasource="#application.mcmsDSN#">
    SELECT imgName AS Name, bName As Bulletin_Name, imgFile AS Image_File, imgtWidth AS Image_Width, sname AS Status FROM v_bulletin_image_rel WHERE 0=0
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(bName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(imgName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">)
    </cfif>
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsDailyBulletinImageRelReport = StructNew()>
    <cfset rsDailyBulletinImageRelReport.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsDailyBulletinImageRelReport>
    </cffunction>
    
    <cffunction name="insertDailyBulletin" access="public" returntype="struct">
    <cfargument name="bName" type="string" required="yes">
    <cfargument name="bDescription" type="string" required="yes">
    <cfargument name="bDateRel" type="date" required="yes">
    <cfargument name="bDateExp" type="date" required="yes">
    <cfargument name="bUrl" type="string" required="yes">
    <cfargument name="bTarget" type="string" required="yes">
    <cfargument name="userID" type="numeric" required="yes">
    <cfargument name="bSort" type="numeric" required="yes">
    <cfargument name="bStatus" type="numeric" required="yes">
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
    <cfinvokeargument name="profanityString" value="#ARGUMENTS.bDescription#"/>
    </cfinvoke>
    <!---Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.app.daily_bulletin.DailyBulletin"
    method="getDailyBulletin"
    returnvariable="getCheckDailyBulletinRet">
    <cfinvokeargument name="bName" value="#ARGUMENTS.bName#"/>
    <cfinvokeargument name="bDateRelEQ" value="#ARGUMENTS.bDateRel#"/>
    <cfinvokeargument name="bDateExpEQ" value="#ARGUMENTS.bDateExp#"/>
    <cfinvokeargument name="bStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckDailyBulletinRet.recordcount NEQ 0>
    <cfset result.message = "The daily bulletin already exists for these dates, please try again.">
    <cfelseif regexProfanityRet CONTAINS '$%&*!'>
    <cfset result.message = "Some text contained profanity, please remove any profanity from your text.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    INSERT INTO tbl_bulletin (bName,bDescription,bDateRel,bDateExp,bUrl,bTarget,userID,bSort,bStatus) VALUES
    (
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.bName#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.bDescription#">,
    <cfqueryparam cfsqltype="cf_sql_date" value="#ARGUMENTS.bDateRel#">,
    <cfqueryparam cfsqltype="cf_sql_date" value="#ARGUMENTS.bDateExp#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.bUrl#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.bTarget#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.userID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.bSort#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.bStatus#">
    )
    </cfquery>
    </cftransaction>
    <!---Get the bID just added.--->
    <cfinvoke 
    component="MCMS.component.app.daily_bulletin.DailyBulletin"
    method="getDailyBulletin"
    returnvariable="getDailyBulletinIDRet">
    <cfinvokeargument name="bName" value="#ARGUMENTS.bName#"/>
    <cfinvokeargument name="userStatus" value="1"/>
    <cfinvokeargument name="bStatus" value="1,2,3"/>
    </cfinvoke>
    <cfset this.bID = getDailyBulletinIDRet.ID>
    <!---Create site relationships.--->
    <cfloop index="siteNo" list="#ARGUMENTS.siteNo#">
    <cfinvoke 
    component="MCMS.component.app.daily_bulletin.DailyBulletin"
    method="insertDailyBulletinSiteRel"
    returnvariable="insertDailyBulletinSiteRelRet">
    <cfinvokeargument name="bID" value="#this.bID#"/>
    <cfinvokeargument name="siteNo" value="#siteNo#"/>
    <cfinvokeargument name="bsrStatus" value="1"/>
    </cfinvoke>
    </cfloop>
    <!---Create department relationships.--->
    <cfloop index="deptNo" list="#ARGUMENTS.deptNo#">
    <cfinvoke 
    component="MCMS.component.app.daily_bulletin.DailyBulletin"
    method="insertDailyBulletinDepartmentRel"
    returnvariable="insertDailyBulletinDepartmentRelRet">
    <cfinvokeargument name="bID" value="#this.bID#"/>
    <cfinvokeargument name="deptNo" value="#deptNo#"/>
    <cfinvokeargument name="bdrStatus" value="1"/>
    </cfinvoke>
    </cfloop>
    </cfif>
    <cfcatch type="any">
    <cfset result.message = "There was an error inserting the record.">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="insertDailyBulletinSiteRel" access="public" returntype="struct">
    <cfargument name="bID" type="numeric" required="yes">
    <cfargument name="siteNo" type="numeric" required="yes">
    <cfargument name="bsrStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully inserted the record.">
    <cftry>
	<!---Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.app.daily_bulletin.DailyBulletin"
    method="getDailyBulletinSiteRel"
    returnvariable="getDailyBulletinSiteRelRet">
    <cfinvokeargument name="bID" value="#ARGUMENTS.bID#"/>
    <cfinvokeargument name="siteNo" value="#ARGUMENTS.siteNo#"/>
    <cfinvokeargument name="bsrStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getDailyBulletinSiteRelRet.recordcount NEQ 0>
    <cfset result.message = "The daily bulletin site relationship already exists, please try again.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    INSERT INTO tbl_bulletin_site_rel (bID,siteNo,bsrStatus) VALUES
    (
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.bID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.siteNo#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.bsrStatus#">
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
    
    <cffunction name="insertDailyBulletinDepartmentRel" access="public" returntype="struct">
    <cfargument name="bID" type="numeric" required="yes">
    <cfargument name="deptNo" type="numeric" required="yes">
    <cfargument name="bdrStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully inserted the record.">
    <cftry>
    <!---Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.app.daily_bulletin.DailyBulletin"
    method="getDailyBulletinDepartmentRel"
    returnvariable="getCheckDailyBulletinDepartmentRelRet">
    <cfinvokeargument name="bID" value="#ARGUMENTS.bID#"/>
    <cfinvokeargument name="deptNo" value="#ARGUMENTS.deptNo#"/>
    <cfinvokeargument name="bdrStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckDailyBulletinDepartmentRelRet.recordcount NEQ 0>
    <cfset result.message = "The daily bulletin department relationship already exists, please try again.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    INSERT INTO tbl_bulletin_department_rel (bID,deptNo,bdrStatus) VALUES
    (
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.bID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.deptNo#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.bdrStatus#">
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
    
    <cffunction name="insertDailyBulletinDocumentRel" access="public" returntype="struct">
    <cfargument name="bID" type="numeric" required="yes">
    <cfargument name="docID" type="numeric" required="yes">
    <cfargument name="bdrStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully inserted the document.">
    <cftry>
    <cfinvoke 
    component="MCMS.component.app.daily_bulletin.DailyBulletin"
    method="getDailyBulletinDocumentRel"
    returnvariable="getCheckDailyBulletinDocumentRelRet">
    <cfinvokeargument name="bID" value="#ARGUMENTS.bID#"/>
    <cfinvokeargument name="docID" value="#ARGUMENTS.docID#"/>
    <cfinvokeargument name="bdrStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckDailyBulletinDocumentRelRet.recordcount NEQ 0>
    <cfset result.message = "The daily bulletin document relationship already exists, please try again.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    INSERT INTO tbl_bulletin_document_rel (bID,docID,bdrStatus) VALUES
    (
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.bID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.docID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.bdrStatus#">
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
    
    <cffunction name="insertDailyBulletinImageRel" access="public" returntype="struct">
    <cfargument name="bID" type="numeric" required="yes">
    <cfargument name="imgID" type="numeric" required="yes">
    <cfargument name="birStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully inserted the image.">
    <cftry>
    <cfinvoke 
    component="MCMS.component.app.daily_bulletin.DailyBulletin"
    method="getDailyBulletinImageRel"
    returnvariable="getCheckDailyBulletinImageRelRet">
    <cfinvokeargument name="bID" value="#ARGUMENTS.bID#"/>
    <cfinvokeargument name="imgID" value="#ARGUMENTS.imgID#"/>
    <cfinvokeargument name="birStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckDailyBulletinImageRelRet.recordcount NEQ 0>
    <cfset result.message = "The daily bulletin image relationship already exists, please try again.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    INSERT INTO tbl_bulletin_image_rel (bID,imgID,birStatus) VALUES
    (
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.bID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.imgID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.birStatus#">
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
    
    <cffunction name="updateDailyBulletin" access="public" returntype="struct">
    <cfargument name="ID" type="numeric" required="yes">
    <cfargument name="uaID" type="numeric" required="yes">
    <cfargument name="bName" type="string" required="yes">
    <cfargument name="bDescription" type="string" required="yes">
    <cfargument name="bDateRel" type="date" required="yes">
    <cfargument name="bDateExp" type="date" required="yes">
    <cfargument name="bUrl" type="string" required="yes">
    <cfargument name="bTarget" type="string" required="yes">
    <cfargument name="userID" type="numeric" required="yes">
    <cfargument name="bSort" type="numeric" required="yes">
    <cfargument name="bStatus" type="numeric" required="yes">
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
    <cfinvokeargument name="profanityString" value="#ARGUMENTS.bDescription#"/>
    </cfinvoke>
    <!---Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.app.daily_bulletin.DailyBulletin"
    method="getDailyBulletin"
    returnvariable="getCheckDailyBulletinRet">
    <cfinvokeargument name="excludeID" value="#ARGUMENTS.ID#"/>
    <cfinvokeargument name="userID" value="#ARGUMENTS.userID#"/>
    <cfinvokeargument name="bName" value="#ARGUMENTS.bName#"/>
    <cfinvokeargument name="bStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckDailyBulletinRet.recordcount NEQ 0>
    <cfset result.message = "The bulletin name #ARGUMENTS.bName# already exists, please enter a new name.">
    <cfelseif regexProfanityRet CONTAINS '$%&*!'>
    <cfset result.message = "Some text contained profanity, please remove any profanity from your text.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_bulletin SET
    bName = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.bName#">,
    bDescription = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.bDescription#">,
    bDateRel = <cfqueryparam cfsqltype="cf_sql_date" value="#ARGUMENTS.bDateRel#">,
    bDateExp = <cfqueryparam cfsqltype="cf_sql_date" value="#ARGUMENTS.bDateExp#">,
    bUrl = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.bUrl#">,
    bTarget = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.bTarget#">,
    bSort = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.bSort#">,
    bDateUpdate = <cfqueryparam cfsqltype="cf_sql_timestamp" value="#Now()#">,
    userID = <cfqueryparam cfsqltype="cf_sql_integer" value="#session.userID#">,
    bStatus = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.bStatus#">
    WHERE ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ID#">
    </cfquery>
    </cftransaction>
    <!---Delete any existing relationships.--->
    <cfinvoke 
    component="MCMS.component.app.daily_bulletin.DailyBulletin"
    method="deleteDailyBulletinSiteRel"
    returnvariable="deleteDailyBulletinSiteRelRet">
    <cfinvokeargument name="bID" value="#ARGUMENTS.ID#"/>
    </cfinvoke>
    <cfinvoke 
    component="MCMS.component.app.daily_bulletin.DailyBulletin"
    method="deleteDailyBulletinDepartmentRel"
    returnvariable="deleteDailyBulletinDepartmentRelRet">
    <cfinvokeargument name="bID" value="#ARGUMENTS.ID#"/>
    </cfinvoke>
    <!---Create site relationships.--->
    <cfloop index="siteNo" list="#ARGUMENTS.siteNo#">
    <cfinvoke 
    component="MCMS.component.app.daily_bulletin.DailyBulletin"
    method="insertDailyBulletinSiteRel"
    returnvariable="insertDailyBulletinSiteRelRet">
    <cfinvokeargument name="bID" value="#ARGUMENTS.ID#"/>
    <cfinvokeargument name="siteNo" value="#siteNo#"/>
    <cfinvokeargument name="bsrStatus" value="1"/>
    </cfinvoke>
    </cfloop>
    <!---Create department relationships.--->
    <cfloop index="deptNo" list="#ARGUMENTS.deptNo#">
    <cfinvoke 
    component="MCMS.component.app.daily_bulletin.DailyBulletin"
    method="insertDailyBulletinDepartmentRel"
    returnvariable="insertDailyBulletinDepartmentRelRet">
    <cfinvokeargument name="bID" value="#ARGUMENTS.ID#"/>
    <cfinvokeargument name="deptNo" value="#deptNo#"/>
    <cfinvokeargument name="bdrStatus" value="1"/>
    </cfinvoke>
    </cfloop>
    </cfif>
    <cfcatch type="any">
    <cfset result.message = "There was an error updating the record.">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="updateDailyBulletinDocumentRel" access="public" returntype="struct">
    <cfargument name="ID" type="numeric" required="yes">
    <cfargument name="bID" type="numeric" required="yes">
    <cfargument name="docID" type="numeric" required="yes">
    <cfargument name="bdrStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully updated the record.">
    <cftry>
    <cfinvoke 
    component="MCMS.component.app.daily_bulletin.DailyBulletin"
    method="getDailyBulletinDocumentRel"
    returnvariable="getCheckDailyBulletinDocumentRelRet">
    <cfinvokeargument name="excludeID" value="#ARGUMENTS.ID#"/>
    <cfinvokeargument name="bID" value="#ARGUMENTS.bID#"/>
    <cfinvokeargument name="docID" value="#ARGUMENTS.docID#"/>
    <cfinvokeargument name="bdrStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckDailyBulletinDocumentRelRet.recordcount NEQ 0>
    <cfset result.message = "The daily bulletin document relationship already exists, please try again.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_bulletin_document_rel SET
    docID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.docID#">,
    bdrStatus = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.bdrStatus#">
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
    
    <cffunction name="updateDailyBulletinImageRel" access="public" returntype="struct">
    <cfargument name="ID" type="numeric" required="yes">
    <cfargument name="bID" type="numeric" required="yes">
    <cfargument name="imgID" type="numeric" required="yes">
    <cfargument name="birStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully updated the record.">
    <cftry>
    <cfinvoke 
    component="MCMS.component.app.daily_bulletin.DailyBulletin"
    method="getDailyBulletinImageRel"
    returnvariable="getCheckDailyBulletinImageRelRet">
    <cfinvokeargument name="excludeID" value="#ARGUMENTS.ID#"/>
    <cfinvokeargument name="bID" value="#ARGUMENTS.bID#"/>
    <cfinvokeargument name="imgID" value="#ARGUMENTS.imgID#"/>
    <cfinvokeargument name="birStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckDailyBulletinImageRelRet.recordcount NEQ 0>
    <cfset result.message = "The daily bulletin image relationship already exists, please try again.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_bulletin_image_rel SET
    imgID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.imgID#">,
    birStatus = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.birStatus#">
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
    
    <cffunction name="updateDailyBulletinList" access="public" returntype="struct">
    <cfargument name="ID" type="numeric" required="yes">
    <cfargument name="bStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully updated the records.">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_bulletin SET
    bStatus = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.bStatus#">
    WHERE ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ID#">
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error updating the records.">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="updateDailyBulletinDocumentRelList" access="public" returntype="struct">
    <cfargument name="ID" type="numeric" required="yes">
    <cfargument name="bdrStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully updated the records.">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_bulletin_document_rel SET
    bdrStatus = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.bdrStatus#">
    WHERE ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ID#">
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error updating the records.">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="updateDailyBulletinImageRelList" access="public" returntype="struct">
    <cfargument name="ID" type="numeric" required="yes">
    <cfargument name="birStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully updated the records.">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_bulletin_image_rel SET
    birStatus = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.birStatus#">
    WHERE ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ID#">
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error updating the records.">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="deleteDailyBulletin" access="public" returntype="struct">
    <cfargument name="ID" type="string" required="yes">
    <cfset result.message = "You have successfully deleted the record(s).">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    DELETE FROM tbl_bulletin
    WHERE ID IN (<cfqueryparam cfsqltype="cf_sql_integer" list="yes" value="#ARGUMENTS.ID#">)
    </cfquery>
    </cftransaction>
    <cfinvoke 
    component="MCMS.component.app.daily_bulletin.DailyBulletin"
    method="deleteDailyBulletinSiteRel"
    returnvariable="deleteDailyBulletinSiteRelRet">
    <cfinvokeargument name="bID" value="#ARGUMENTS.ID#"/>
    </cfinvoke>
    <cfinvoke 
    component="MCMS.component.app.daily_bulletin.DailyBulletin"
    method="deleteDailyBulletinDepartmentRel"
    returnvariable="deleteDailyBulletinDepartmentRelRet">
    <cfinvokeargument name="bID" value="#ARGUMENTS.ID#"/>
    </cfinvoke>
    <cfinvoke 
    component="MCMS.component.app.daily_bulletin.DailyBulletin"
    method="deleteDailyBulletinDocumentRel"
    returnvariable="deleteDailyBulletinDocumentRelRet">
    <cfinvokeargument name="bID" value="#ARGUMENTS.ID#"/>
    </cfinvoke>
    <cfinvoke 
    component="MCMS.component.app.daily_bulletin.DailyBulletin"
    method="deleteDailyBulletinImageRel"
    returnvariable="deleteDailyBulletinImageRelRet">
    <cfinvokeargument name="bID" value="#ARGUMENTS.ID#"/>
    </cfinvoke>
    <cfcatch type="any">
    <cfset result.message = "There was an error deleting the record(s).">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction> 
    
    <cffunction name="deleteDailyBulletinSiteRel" access="public" returntype="struct">
    <cfargument name="ID" type="string" required="yes" default="0">
    <cfargument name="bID" type="string" required="yes" default="0">
    <cfset result.message = "You have successfully deleted the record(s).">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    DELETE FROM tbl_bulletin_site_rel
    WHERE ID IN (<cfqueryparam cfsqltype="cf_sql_integer" list="yes" value="#ARGUMENTS.ID#">)
    OR bID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.bID#">
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error deleting the record(s).">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="deleteDailyBulletinDepartmentRel" access="public" returntype="struct">
    <cfargument name="ID" type="string" required="yes" default="0">
    <cfargument name="bID" type="string" required="yes" default="0">
    <cfset result.message = "You have successfully deleted the record(s).">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    DELETE FROM tbl_bulletin_department_rel
    WHERE ID IN (<cfqueryparam cfsqltype="cf_sql_integer" list="yes" value="#ARGUMENTS.ID#">)
    OR bID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.bID#">
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error deleting the record(s).">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="deleteDailyBulletinDocumentRel" access="public" returntype="struct">
    <cfargument name="ID" type="string" required="yes" default="0">
    <cfargument name="bID" type="string" required="yes" default="0">
    <cfset result.message = "You have successfully deleted the record(s).">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    DELETE FROM tbl_bulletin_document_rel
    WHERE ID IN (<cfqueryparam cfsqltype="cf_sql_integer" list="yes" value="#ARGUMENTS.ID#">)
    OR bID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.bID#">
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error deleting the record(s).">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction> 
    
    <cffunction name="deleteDailyBulletinImageRel" access="public" returntype="struct">
    <cfargument name="ID" type="string" required="yes" default="0">
    <cfargument name="bID" type="string" required="yes" default="0">
    <cfset result.message = "You have successfully deleted the record(s).">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    DELETE FROM tbl_bulletin_image_rel
    WHERE ID IN (<cfqueryparam cfsqltype="cf_sql_integer" list="yes" value="#ARGUMENTS.ID#">)
    OR bID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.bID#">
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error deleting the record(s).">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>  
</cfcomponent>