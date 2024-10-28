<cfcomponent>
    <cffunction name="getHRWEmployee" access="public" returntype="query" hint="Get HRW Employee data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="ID" type="numeric" required="yes" default="0">
    <cfargument name="excludeID" type="numeric" required="yes" default="0">
    <cfargument name="hrweID" type="numeric" required="yes" default="0">
    <cfargument name="hrweFName" type="string" required="yes" default="">
    <cfargument name="hrweLName" type="string" required="yes" default="">
    <cfargument name="siteNo" type="numeric" required="yes" default="100">
    <cfargument name="deptNo" type="numeric" required="yes" default="0">
    <cfargument name="userID" type="string" required="yes" default="0">
    <cfargument name="hrweStatus" type="string" required="yes" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="hrweLName">
    <cfset var rsHRWEmployee = "" >
    <cftry>
    <cfquery name="rsHRWEmployee" datasource="#application.mcmsDSN#">
    SELECT * FROM v_hrw_employee WHERE 0=0
    <cfif ARGUMENTS.ID NEQ 0>
    AND ID = <cfqueryparam value="#ARGUMENTS.ID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.excludeID NEQ 0>
    AND ID <> <cfqueryparam value="#ARGUMENTS.excludeID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(hrweFName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(hrweLName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">)
    </cfif>
    <cfif ARGUMENTS.hrweID NEQ 0>
    AND hrweID = <cfqueryparam value="#ARGUMENTS.hrweID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.hrweFName NEQ "">
    AND UPPER(hrweFName) = <cfqueryparam value="#UCASE(ARGUMENTS.hrweFName)#" cfsqltype="cf_sql_varchar">
    </cfif>
    <cfif ARGUMENTS.hrweLName NEQ "">
    AND UPPER(hrweLName) = <cfqueryparam value="#UCASE(ARGUMENTS.hrweLName)#" cfsqltype="cf_sql_varchar">
    </cfif>
    <cfif ARGUMENTS.siteNo NEQ 100>
    AND siteNo = <cfqueryparam value="#ARGUMENTS.siteNo#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.deptNo NEQ 0>
    AND deptNo = <cfqueryparam value="#ARGUMENTS.deptNo#" cfsqltype="cf_sql_integer">
    </cfif>
	<cfif ARGUMENTS.userID NEQ 0>
    AND userID = <cfqueryparam value="#ARGUMENTS.userID#" cfsqltype="cf_sql_integer">
    </cfif>
    AND hrweStatus IN (<cfqueryparam value="#ARGUMENTS.hrweStatus#" list="yes" cfsqltype="cf_sql_integer">)
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsHRWEmployee = StructNew()>
    <cfset rsHRWEmployee.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsHRWEmployee>
    </cffunction>
    
    <cffunction name="getHRWProcedureUnit" access="public" returntype="query" hint="Get HRW Procedure Unit data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="ID" type="numeric" required="yes" default="0">
    <cfargument name="excludeID" type="numeric" required="yes" default="0">
    <cfargument name="hrwpuName" type="string" required="yes" default="">
    <cfargument name="hrwpuStatus" type="string" required="yes" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="hrwpuSort, hrwpuName">
    <cfset var rsHRWProcedureUnit = "" >
    <cftry>
    <cfquery name="rsHRWProcedureUnit" datasource="#application.mcmsDSN#">
    SELECT * FROM v_hrw_procedure_unit WHERE 0=0
    <cfif ARGUMENTS.ID NEQ 0>
    AND ID = <cfqueryparam value="#ARGUMENTS.ID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.excludeID NEQ 0>
    AND ID <> <cfqueryparam value="#ARGUMENTS.excludeID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND UPPER(hrwpuName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">
    </cfif>
    <cfif ARGUMENTS.hrwpuName NEQ "">
    AND UPPER(hrwpuName) = <cfqueryparam value="#UCASE(ARGUMENTS.hrwpuName)#" cfsqltype="cf_sql_varchar">
    </cfif>
    AND hrwpuStatus IN (<cfqueryparam value="#ARGUMENTS.hrwpuStatus#" list="yes" cfsqltype="cf_sql_integer">)
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsHRWProcedureUnit = StructNew()>
    <cfset rsHRWProcedureUnit.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsHRWProcedureUnit>
    </cffunction>
    
    <cffunction name="getHRWProcedure" access="public" returntype="query" hint="Get HRW Procedure data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="ID" type="numeric" required="yes" default="0">
    <cfargument name="excludeID" type="numeric" required="yes" default="0">
    <cfargument name="hrwpuID" type="numeric" required="yes" default="0">
    <cfargument name="hrwpName" type="string" required="yes" default="">
    <cfargument name="hrwptID" type="numeric" required="yes" default="0">
    <cfargument name="hrwpStatus" type="string" required="yes" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="hrwpName">
    <cfset var rsHRWProcedure = "" >
    <cftry>
    <cfquery name="rsHRWProcedure" datasource="#application.mcmsDSN#">
    SELECT * FROM v_hrw_procedure WHERE 0=0
    <cfif ARGUMENTS.ID NEQ 0>
    AND ID = <cfqueryparam value="#ARGUMENTS.ID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.excludeID NEQ 0>
    AND ID <> <cfqueryparam value="#ARGUMENTS.excludeID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND UPPER(hrwpName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">
    </cfif>
    <cfif ARGUMENTS.hrwpName NEQ "">
    AND UPPER(hrwpName) = <cfqueryparam value="#UCASE(ARGUMENTS.hrwpName)#" cfsqltype="cf_sql_varchar">
    </cfif>
    <cfif ARGUMENTS.hrwpuID NEQ 0>
    AND hrwpuID = <cfqueryparam value="#ARGUMENTS.hrwpuID#" cfsqltype="cf_sql_integer">
    </cfif>
	<cfif ARGUMENTS.hrwptID NEQ 0>
    AND hrwptID = <cfqueryparam value="#ARGUMENTS.hrwptID#" cfsqltype="cf_sql_integer">
    </cfif>
    AND hrwpStatus IN (<cfqueryparam value="#ARGUMENTS.hrwpStatus#" list="yes" cfsqltype="cf_sql_integer">)
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsHRWProcedure = StructNew()>
    <cfset rsHRWProcedure.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsHRWProcedure>
    </cffunction>
    
    <cffunction name="getHRWProcedureStatus" access="public" returntype="query" hint="Get HRW Procedure Status data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="ID" type="numeric" required="yes" default="0">
    <cfargument name="excludeID" type="numeric" required="yes" default="0">
    <cfargument name="hrwpsName" type="string" required="yes" default="">
    <cfargument name="hrwpsStatus" type="string" required="yes" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="hrwpsName">
    <cfset var rsHRWProcedureStatus = "" >
    <cftry>
    <cfquery name="rsHRWProcedureStatus" datasource="#application.mcmsDSN#">
    SELECT * FROM v_hrw_procedure_status WHERE 0=0
    <cfif ARGUMENTS.ID NEQ 0>
    AND ID = <cfqueryparam value="#ARGUMENTS.ID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.excludeID NEQ 0>
    AND ID <> <cfqueryparam value="#ARGUMENTS.excludeID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND UPPER(hrwpsName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">
    </cfif>
    <cfif ARGUMENTS.hrwpsName NEQ "">
    AND UPPER(hrwpsName) = <cfqueryparam value="#UCASE(ARGUMENTS.hrwpsName)#" cfsqltype="cf_sql_varchar">
    </cfif>
    AND hrwpsStatus IN (<cfqueryparam value="#ARGUMENTS.hrwpsStatus#" list="yes" cfsqltype="cf_sql_integer">)
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsHRWProcedureStatus = StructNew()>
    <cfset rsHRWProcedureStatus.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsHRWProcedureStatus>
    </cffunction>
    
    <cffunction name="getHRWProcedureDocumentRel" access="public" returntype="query" hint="Get HRW Procedure Document Rel. data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="ID" type="numeric" required="yes" default="0">
    <cfargument name="excludeID" type="numeric" required="yes" default="0">
    <cfargument name="hrwpID" type="numeric" required="yes" default="0">
    <cfargument name="docID" type="numeric" required="yes" default="0">
    <cfargument name="hrwpName" type="string" required="yes" default="">
    <cfargument name="docName" type="string" required="yes" default="">
    <cfargument name="hrwpdrStatus" type="string" required="yes" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="docName">
    <cfset var rsHRWProcedureDocumentRel = "" >
    <cftry>
    <cfquery name="rsHRWProcedureDocumentRel" datasource="#application.mcmsDSN#">
    SELECT * FROM v_hrw_p_document_rel WHERE 0=0
    <cfif ARGUMENTS.ID NEQ 0>
    AND ID = <cfqueryparam value="#ARGUMENTS.ID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.excludeID NEQ 0>
    AND ID <> <cfqueryparam value="#ARGUMENTS.excludeID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(hrwpName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(docName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">)
    </cfif>
    <cfif ARGUMENTS.hrwpID NEQ 0>
    AND hrwpID = <cfqueryparam value="#ARGUMENTS.hrwpID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.docID NEQ 0>
    AND docID = <cfqueryparam value="#ARGUMENTS.docID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.hrwpName NEQ "">
    AND UPPER(hrwpName) = <cfqueryparam value="#UCASE(ARGUMENTS.hrwpName)#" cfsqltype="cf_sql_varchar">
    </cfif>
    <cfif ARGUMENTS.docName NEQ "">
    AND UPPER(docName) = <cfqueryparam value="#UCASE(ARGUMENTS.docName)#" cfsqltype="cf_sql_varchar">
    </cfif>
    AND hrwpdrStatus IN (<cfqueryparam value="#ARGUMENTS.hrwpdrStatus#" list="yes" cfsqltype="cf_sql_integer">)
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsHRWProcedureDocumentRel = StructNew()>
    <cfset rsHRWProcedureDocumentRel.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsHRWProcedureDocumentRel>
    </cffunction>
    
    <cffunction name="getHRWProcedureLog" access="public" returntype="query" hint="Get HRW Procedure Log data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="ID" type="numeric" required="yes" default="0">
    <cfargument name="excludeID" type="numeric" required="yes" default="0">
    <cfargument name="hrweID" type="numeric" required="yes" default="0">
    <cfargument name="hrwpuID" type="numeric" required="yes" default="0">
    <cfargument name="hrwpID" type="numeric" required="yes" default="0">
    <cfargument name="hrwpsID" type="string" required="yes" default="0">
    <cfargument name="hrwplStatus" type="string" required="yes" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="hrwplDate DESC">
    <cfset var rsHRWProcedureLog = "" >
    <cftry>
    <cfquery name="rsHRWProcedureLog" datasource="#application.mcmsDSN#">
    SELECT * FROM v_hrw_procedure_log WHERE 0=0
    <cfif ARGUMENTS.ID NEQ 0>
    AND ID = <cfqueryparam value="#ARGUMENTS.ID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.excludeID NEQ 0>
    AND ID <> <cfqueryparam value="#ARGUMENTS.excludeID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(hrwpName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">)
    </cfif>
    <cfif ARGUMENTS.hrweID NEQ 0>
    AND hrweID = <cfqueryparam value="#ARGUMENTS.hrweID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.hrwpuID NEQ 0>
    AND hrwpuID = <cfqueryparam value="#ARGUMENTS.hrwpuID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.hrwpID NEQ 0>
    AND hrwpID = <cfqueryparam value="#ARGUMENTS.hrwpID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.hrwpsID NEQ 0>
    AND hrwpsID IN (<cfqueryparam value="#ARGUMENTS.hrwpsID#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    AND hrwplStatus IN (<cfqueryparam value="#ARGUMENTS.hrwplStatus#" list="yes" cfsqltype="cf_sql_integer">)
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsHRWProcedureLog = StructNew()>
    <cfset rsHRWProcedureLog.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsHRWProcedureLog>
    </cffunction>
    
    <cffunction name="getHRWEmployeeReport" access="public" returntype="query" hint="Get HRW Employee Report data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="siteNo" type="string" required="yes" default="100">
    <cfargument name="orderBy" type="string" required="yes" default="sq.hrweLName">
    <cfset var rsHRWEmployeeReport = "" >
    <cftry>
    <cfquery name="rsHRWEmployeeReport" datasource="#application.mcmsDSN#">
    SELECT sq.hrweID AS Employee_ID, sq.hrwefname AS First_Name, sq.hrwelname AS Last_Name, sq.hrweemail AS Email, sq.hrwetelephone AS Telephone, 
    TO_CHAR(sq.hrweDate, 'MM/DD/YYYY') AS Date_Created, sq.hrwecomment AS Comments, sq.siteNo, sq.sitename AS Site, sq.deptNo, sq.deptname AS Department,
    (CASE 
    WHEN sq.totalCount - sq.statusCount <= <cfqueryparam value="0" cfsqltype="cf_sql_integer"> THEN  'Completed'
    ELSE 'Incomplete'
    END) Complete_Status,
    sq.sname AS Status
    FROM 
    (SELECT hrweID, hrwefname, hrwelname, hrweemail, hrwetelephone, hrwedate, hrwecomment, siteno, sitename, deptno, deptname, sname,
    (SELECT count(hrweID) AS total_counts FROM v_hrw_procedure_log WHERE v_hrw_procedure_log.hrweID = v_hrw_employee.hrweID AND v_hrw_employee.hrwestatus = <cfqueryparam value="1" cfsqltype="cf_sql_integer"> AND v_hrw_procedure_log.hrwpstatus = <cfqueryparam value="1" cfsqltype="cf_sql_integer">) statusCount,
    (SELECT count(ID) AS total_procedures FROM v_hrw_procedure WHERE hrwpustatus = <cfqueryparam value="1" cfsqltype="cf_sql_integer"> AND hrwpstatus = <cfqueryparam value="1" cfsqltype="cf_sql_integer">) totalCount
    FROM v_hrw_employee) sq
     WHERE 0=0
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(sq.hrweFName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(sq.hrweLName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">)
    </cfif>
    <cfif ARGUMENTS.siteNo NEQ 100>
    AND sq.siteNo IN (<cfqueryparam value="#ARGUMENTS.siteNo#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsHRWEmployeeReport = StructNew()>
    <cfset rsHRWEmployeeReport.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsHRWEmployeeReport>
    </cffunction>
    
    <cffunction name="getHRWProcedureUnitReport" access="public" returntype="query" hint="Get HRW Procedure Unit Report data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="orderBy" type="string" required="yes" default="hrwpuName">
    <cfset var rsHRWProcedureUnitReport = "" >
    <cftry>
    <cfquery name="rsHRWProcedureUnitReport" datasource="#application.mcmsDSN#">
    SELECT hrwpuName AS Name, hrwpuDescription AS Description, sortName AS Sort, sName AS Status FROM v_hrw_procedure_unit WHERE 0=0
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND UPPER(hrwpuName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">
    </cfif>
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsHRWProcedureUnitReport = StructNew()>
    <cfset rsHRWProcedureUnitReport.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsHRWProcedureUnitReport>
    </cffunction>
    
    <cffunction name="getHRWProcedureReport" access="public" returntype="query" hint="Get HRW Procedure Report data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="orderBy" type="string" required="yes" default="hrwpName">
    <cfset var rsHRWProcedureReport = "" >
    <cftry>
    <cfquery name="rsHRWProcedureReport" datasource="#application.mcmsDSN#">
    SELECT hrwpName AS Name, hrwpDescription AS Description, hrwpuName AS Unit_Name, sName AS Status FROM v_hrw_procedure WHERE 0=0
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND UPPER(hrwpName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">
    </cfif>
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsHRWProcedureReport = StructNew()>
    <cfset rsHRWProcedureReport.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsHRWProcedureReport>
    </cffunction>
    
    <cffunction name="getHRWProcedureStatusReport" access="public" returntype="query" hint="Get HRW Procedure Status Report data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="orderBy" type="string" required="yes" default="hrwpsName">
    <cfset var rsHRWProcedureStatusReport = "" >
    <cftry>
    <cfquery name="rsHRWProcedureStatusReport" datasource="#application.mcmsDSN#">
    SELECT hrwpsName AS Name, sortName AS Sort, sName AS Status FROM v_hrw_procedure_status WHERE 0=0
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND UPPER(hrwpsName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">
    </cfif>
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsHRWProcedureStatusReport = StructNew()>
    <cfset rsHRWProcedureStatusReport.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsHRWProcedureStatusReport>
    </cffunction>
    
    <cffunction name="insertHRWEmployee" access="public" returntype="struct">
    <cfargument name="hrweID" type="numeric" required="yes">
    <cfargument name="hrweFName" type="string" required="yes">
    <cfargument name="hrweLName" type="string" required="yes">
    <cfargument name="hrweEmail" type="string" required="yes">
    <cfargument name="hrweTelephone" type="string" required="yes">
    <cfargument name="hrweComment" type="string" required="yes">
    <cfargument name="siteNo" type="numeric" required="yes">
    <cfargument name="deptNo" type="numeric" required="yes">
    <cfargument name="userID" type="numeric" required="yes">
    <cfargument name="hrweStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully inserted the record.">
    <cftry>
    <!---Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.app.hr_workflow.HRWorkflow"
    method="getHRWEmployee"
    returnvariable="getCheckHRWEmployeeRet">
    <cfinvokeargument name="hrweID" value="#ARGUMENTS.hrweID#"/>
    <cfinvokeargument name="hrweStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckHRWEmployeeRet.recordcount NEQ 0>
    <cfset result.message = "The name #ARGUMENTS.hrweFName# #ARGUMENTS.hrweLName# with ID - #ARGUMENTS.hrweID# already exists, please enter a new name/ID.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    INSERT INTO tbl_hrw_employee (hrweID,hrweFName,hrweLName,hrweEmail,hrweTelephone,hrweComment,siteNo,deptNo,userID,hrweStatus) VALUES
    (
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.hrweID#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.hrweFName#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.hrweLName#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.hrweEmail#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.hrweTelephone#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.hrweComment#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.siteNo#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.deptNo#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.userID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.hrweStatus#">
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
    
    <cffunction name="insertHRWProcedureUnit" access="public" returntype="struct">
    <cfargument name="hrwpuName" type="string" required="yes">
    <cfargument name="hrwpuDescription" type="string" required="yes">
    <cfargument name="hrwpuSort" type="numeric" required="yes">
    <cfargument name="hrwpuStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully inserted the record.">
    <cftry>
    <!---Check for profanity in the text.--->
    <cfinvoke 
    component="MCMS.component.utility.Regex"
    method="regexProfanity"
    returnvariable="regexProfanityRet">
    <cfinvokeargument name="profanityString" value="#ARGUMENTS.hrwpuDescription#"/>
    </cfinvoke>
    <!---Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.app.hr_workflow.HRWorkflow"
    method="getHRWProcedureUnit"
    returnvariable="getCheckHRWProcedureUnitRet">
    <cfinvokeargument name="hrwpuName" value="#ARGUMENTS.hrwpuName#"/>
    <cfinvokeargument name="hrwpuStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckHRWProcedureUnitRet.recordcount NEQ 0>
    <cfset result.message = "The name #ARGUMENTS.hrwpuName# already exists, please enter a new name.">
    <cfelseif regexProfanityRet CONTAINS '$%&*!'>
    <cfset result.message = "Some text contained profanity, please remove any profanity from your text.">
    <!---Check length restriction.--->
    <cfelseif LEN(ARGUMENTS.hrwpuDescription) GT 1024>
    <cfset result.message = "The description is longer than 1024 characters, please enter a new description under 1024 characters.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    INSERT INTO tbl_hrw_procedure_unit (hrwpuName, hrwpuDescription, hrwpuSort, hrwpuStatus) VALUES
    (
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.hrwpuName#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.hrwpuDescription#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.hrwpuSort#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.hrwpuStatus#">
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
    
    <cffunction name="insertHRWProcedure" access="public" returntype="struct">
    <cfargument name="hrwpuID" type="numeric" required="yes">
    <cfargument name="hrwpName" type="string" required="yes">
    <cfargument name="hrwpDescription" type="string" required="yes">
    <cfargument name="hrwptID" type="numeric" required="yes">
    <cfargument name="hrwpStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully inserted the record.">
    <cftry>
    <!---Check for profanity in the text.--->
    <cfinvoke 
    component="MCMS.component.utility.Regex"
    method="regexProfanity"
    returnvariable="regexProfanityRet">
    <cfinvokeargument name="profanityString" value="#ARGUMENTS.hrwpDescription#"/>
    </cfinvoke>
    <!---Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.app.hr_workflow.HRWorkflow"
    method="getHRWProcedure"
    returnvariable="getCheckHRWProcedureRet">
    <cfinvokeargument name="hrwpName" value="#ARGUMENTS.hrwpName#"/>
    <cfinvokeargument name="hrwpStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckHRWProcedureRet.recordcount NEQ 0>
    <cfset result.message = "The name #ARGUMENTS.hrwpName# already exists, please enter a new name.">
    <cfelseif regexProfanityRet CONTAINS '$%&*!'>
    <cfset result.message = "Some text contained profanity, please remove any profanity from your text.">
    <!---Check length restriction.--->
    <cfelseif LEN(ARGUMENTS.hrwpDescription) GT 1024>
    <cfset result.message = "The description is longer than 1024 characters, please enter a new description under 1024 characters.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    INSERT INTO tbl_hrw_procedure (hrwpuID, hrwpName, hrwpDescription, hrwptID, hrwpStatus) VALUES
    (
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.hrwpuID#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.hrwpName#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.hrwpDescription#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.hrwptID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.hrwpStatus#">
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
    
    <cffunction name="insertHRWProcedureStatus" access="public" returntype="struct">
    <cfargument name="hrwpsName" type="string" required="yes">
    <cfargument name="hrwpsSort" type="numeric" required="yes">
    <cfargument name="hrwpsStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully inserted the record.">
    <cftry>
    <!---Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.app.hr_workflow.HRWorkflow"
    method="getHRWProcedureStatus"
    returnvariable="getCheckHRWProcedureStatusRet">
    <cfinvokeargument name="hrwpsName" value="#ARGUMENTS.hrwpsName#"/>
    <cfinvokeargument name="hrwpsStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckHRWProcedureStatusRet.recordcount NEQ 0>
    <cfset result.message = "The name #ARGUMENTS.hrwpsName# already exists, please enter a new name.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    INSERT INTO tbl_hrw_procedure_status (hrwpsName, hrwpsSort, hrwpsStatus) VALUES
    (
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.hrwpsName#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.hrwpsSort#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.hrwpsStatus#">
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
    
    <cffunction name="insertHRWProcedureDocumentRel" access="public" returntype="struct">
    <cfargument name="hrwpID" type="numeric" required="yes">
    <cfargument name="docID" type="numeric" required="yes">
    <cfargument name="hrwpdrStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully inserted the record.">
    <cftry>
    <!---Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.app.hr_workflow.HRWorkflow"
    method="getHRWProcedureDocumentRel"
    returnvariable="getCheckHRWProcedureDocumentRelRet">
    <cfinvokeargument name="hrwpID" value="#ARGUMENTS.hrwpID#"/>
    <cfinvokeargument name="docID" value="#ARGUMENTS.docID#"/>
    <cfinvokeargument name="hrwpdrStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckHRWProcedureDocumentRelRet.recordcount NEQ 0>
    <cfset result.message = "The document already exists, please enter a new document.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    INSERT INTO tbl_hrw_p_document_rel (hrwpID, docID, hrwpdrStatus) VALUES
    (
	<cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.hrwpID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.docID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.hrwpdrStatus#">
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
    
    <cffunction name="insertHRWProcedureLog" access="public" returntype="struct">
    <cfargument name="hrweID" type="numeric" required="yes">
    <cfargument name="hrwpuID" type="numeric" required="yes">
    <cfargument name="hrwpID" type="numeric" required="yes">
    <cfargument name="hrwpsID" type="numeric" required="yes">
    <cfargument name="hrwplComment" type="string" required="yes">
    <cfargument name="userID" type="numeric" required="yes">
    <cfargument name="hrwplStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully inserted the record.">
    <cftry>
    <!---Check for a duplicate record.--->
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    INSERT INTO tbl_hrw_procedure_log (hrweID,hrwpuID,hrwpID,hrwpsID,hrwplComment,userID,hrwplStatus) VALUES
    (
	<cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.hrweID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.hrwpuID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.hrwpID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.hrwpsID#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.hrwplComment#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.userID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.hrwplStatus#">
    )
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error inserting the record.">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="updateHRWEmployee" access="public" returntype="struct">
    <cfargument name="ID" type="numeric" required="yes">
    <cfargument name="uaID" type="numeric" required="yes">
    <cfargument name="hrweID" type="numeric" required="yes">
    <cfargument name="hrweFName" type="string" required="yes">
    <cfargument name="hrweLName" type="string" required="yes">
    <cfargument name="hrweEmail" type="string" required="yes">
    <cfargument name="hrweTelephone" type="string" required="yes">
    <cfargument name="hrweComment" type="string" required="yes">
    <cfargument name="siteNo" type="numeric" required="yes">
    <cfargument name="deptNo" type="numeric" required="yes">
    <cfargument name="userID" type="numeric" required="yes">
    <cfargument name="hrweStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully updated the record.">
    <cftry>
    <!---Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.app.hr_workflow.HRWorkflow"
    method="getHRWEmployee"
    returnvariable="getCheckHRWEmployeeRet">
    <cfinvokeargument name="excludeID" value="#ARGUMENTS.ID#"/>
    <cfinvokeargument name="hrweID" value="#ARGUMENTS.hrweID#"/>
    <cfinvokeargument name="hrweStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckHRWEmployeeRet.recordcount NEQ 0>
    <cfset result.message = "The name #ARGUMENTS.hrweFName# #ARGUMENTS.hrweLName# with ID - #ARGUMENTS.hrweID# already exists, please enter a new name/ID.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_hrw_employee SET
    hrweID = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.hrweID#">,
    hrweFName = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.hrweFName#">,
    hrweLName = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.hrweLName#">,
    hrweEmail = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.hrweEmail#">,
    hrweTelephone = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.hrweTelephone#">,
    hrweDate = <cfqueryparam cfsqltype="cf_sql_date" value="#Now()#">,
    hrweComment = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.hrweComment#">,
    siteNo = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.siteNo#">,
    deptNo = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.deptNo#">,
		<cfif ARGUMENTS.uaID NEQ 101>
    hrweDateUpdate = <cfqueryparam cfsqltype="cf_sql_timestamp" value="#Now()#">,
    userID = <cfqueryparam cfsqltype="cf_sql_integer" value="#session.userID#">,
    </cfif>
    hrweStatus = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.hrweStatus#">
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
    
    <cffunction name="updateHRWProcedureUnit" access="public" returntype="struct">
    <cfargument name="ID" type="numeric" required="yes">
    <cfargument name="hrwpuName" type="string" required="yes">
    <cfargument name="hrwpuDescription" type="string" required="yes">
    <cfargument name="hrwpuSort" type="numeric" required="yes">
    <cfargument name="hrwpuStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully updated the record.">
    <cftry>
    <!---Check for profanity in the text.--->
    <cfinvoke 
    component="MCMS.component.utility.Regex"
    method="regexProfanity"
    returnvariable="regexProfanityRet">
    <cfinvokeargument name="profanityString" value="#ARGUMENTS.hrwpuDescription#"/>
    </cfinvoke>
    <!---Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.app.hr_workflow.HRWorkflow"
    method="getHRWProcedureUnit"
    returnvariable="getCheckHRWProcedureUnitRet">
    <cfinvokeargument name="excludeID" value="#ARGUMENTS.ID#"/>
    <cfinvokeargument name="hrwpuName" value="#ARGUMENTS.hrwpuName#"/>
    <cfinvokeargument name="hrwpuStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckHRWProcedureUnitRet.recordcount NEQ 0>
    <cfset result.message = "The name #ARGUMENTS.hrwpuName# already exists, please enter a new name.">
    <cfelseif regexProfanityRet CONTAINS '$%&*!'>
    <cfset result.message = "Some text contained profanity, please remove any profanity from your text.">
    <!---Check length restriction.--->
    <cfelseif LEN(ARGUMENTS.hrwpuDescription) GT 1024>
    <cfset result.message = "The description is longer than 1024 characters, please enter a new description under 1024 characters.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_hrw_procedure_unit SET
    hrwpuName = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.hrwpuName#">,
    hrwpuDescription = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.hrwpuDescription#">,
    hrwpuSort = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.hrwpuSort#">,
    hrwpuStatus = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.hrwpuStatus#">
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
    
    <cffunction name="updateHRWProcedure" access="public" returntype="struct">
    <cfargument name="ID" type="numeric" required="yes">
    <cfargument name="hrwpuID" type="numeric" required="yes">
    <cfargument name="hrwpName" type="string" required="yes">
    <cfargument name="hrwpDescription" type="string" required="yes">
    <cfargument name="hrwptID" type="numeric" required="yes">
    <cfargument name="hrwpStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully updated the record.">
    <cftry>
    <!---Check for profanity in the text.--->
    <cfinvoke 
    component="MCMS.component.utility.Regex"
    method="regexProfanity"
    returnvariable="regexProfanityRet">
    <cfinvokeargument name="profanityString" value="#ARGUMENTS.hrwpDescription#"/>
    </cfinvoke>
    <!---Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.app.hr_workflow.HRWorkflow"
    method="getHRWProcedure"
    returnvariable="getCheckHRWProcedureRet">
    <cfinvokeargument name="excludeID" value="#ARGUMENTS.ID#"/>
    <cfinvokeargument name="hrwpName" value="#ARGUMENTS.hrwpName#"/>
    <cfinvokeargument name="hrwpStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckHRWProcedureRet.recordcount NEQ 0>
    <cfset result.message = "The name #ARGUMENTS.hrwpName# already exists, please enter a new name.">
    <cfelseif regexProfanityRet CONTAINS '$%&*!'>
    <cfset result.message = "Some text contained profanity, please remove any profanity from your text.">
    <!---Check length restriction.--->
    <cfelseif LEN(ARGUMENTS.hrwpDescription) GT 1024>
    <cfset result.message = "The description is longer than 1024 characters, please enter a new description under 1024 characters.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_hrw_procedure SET
    hrwpName = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.hrwpName#">,
    hrwpDescription = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.hrwpDescription#">,
    hrwptID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.hrwptID#">,
    hrwpStatus = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.hrwpStatus#">
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
    
    <cffunction name="updateHRWProcedureStatus" access="public" returntype="struct">
    <cfargument name="ID" type="numeric" required="yes">
    <cfargument name="hrwpsName" type="string" required="yes">
    <cfargument name="hrwpsSort" type="numeric" required="yes">
    <cfargument name="hrwpsStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully updated the record.">
    <cftry>
    <!---Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.app.hr_workflow.HRWorkflow"
    method="getHRWProcedureStatus"
    returnvariable="getCheckHRWProcedureStatusRet">
    <cfinvokeargument name="excludeID" value="#ARGUMENTS.ID#"/>
    <cfinvokeargument name="hrwpsName" value="#ARGUMENTS.hrwpsName#"/>
    <cfinvokeargument name="hrwpsStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckHRWProcedureStatusRet.recordcount NEQ 0>
    <cfset result.message = "The name #ARGUMENTS.hrwsName# already exists, please enter a new name.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_hrw_procedure_status SET
    hrwpsName = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.hrwpsName#">,
    hrwpsSort = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.hrwpsSort#">,
    hrwpsStatus = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.hrwpsStatus#">
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
    
    <cffunction name="updateHRWProcedureLog" access="public" returntype="struct">
    <cfargument name="ID" type="numeric" required="yes">
    <cfargument name="hrweID" type="numeric" required="yes">
    <cfargument name="hrwpuID" type="numeric" required="yes">
    <cfargument name="hrwpID" type="numeric" required="yes">
    <cfargument name="hrwpsID" type="numeric" required="yes">
    <cfargument name="hrwplComment" type="string" required="yes">
    <cfargument name="userID" type="numeric" required="yes">
    <cfargument name="hrwplStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully updated the record.">
    <cftry>
    <!---Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.app.hr_workflow.HRWorkflow"
    method="getHRWProcedureLog"
    returnvariable="getCheckHRWProcedureLogRet">
    <cfinvokeargument name="excludeID" value="#ARGUMENTS.ID#"/>
    <cfinvokeargument name="hrweID" value="#ARGUMENTS.hrweID#"/>
    <cfinvokeargument name="hrwpuID" value="#ARGUMENTS.hrwpuID#"/>
    <cfinvokeargument name="hrwpID" value="#ARGUMENTS.hrwpID#"/>
    <cfinvokeargument name="hrwplStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckHRWProcedureLogRet.recordcount NEQ 0>
    <cfset result.message = "The name log already exists, please enter a log.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_hrw_procedure_log SET
    hrweID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.hrweID#">,
    hrwpuID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.hrwpuID#">,
    hrwpID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.hrwpID#">,
    hrwpsID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.hrwpsID#">,
    hrwplDate = <cfqueryparam cfsqltype="cf_sql_date" value="#Now()#">,
    hrwplComment = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.hrwplComment#">,
    userID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.userID#">,
    hrwplStatus = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.hrwplStatus#">
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
    
    <cffunction name="updateHRWEmployeeList" access="public" returntype="struct">
    <cfargument name="ID" type="numeric" required="yes">
    <cfargument name="hrweStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully updated the records.">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_hrw_employee SET
    hrweStatus = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.hrweStatus#">
    WHERE ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ID#">
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error updating the records.">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="updateHRWProcedureUnitList" access="public" returntype="struct">
    <cfargument name="ID" type="numeric" required="yes">
    <cfargument name="hrwpuStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully updated the records.">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_hrw_procedure_unit SET
    hrwpuStatus = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.hrwpuStatus#">
    WHERE ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ID#">
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error updating the records.">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="updateHRWProcedureList" access="public" returntype="struct">
    <cfargument name="ID" type="numeric" required="yes">
    <cfargument name="hrwpStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully updated the records.">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_hrw_procedure SET
    hrwpStatus = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.hrwpStatus#">
    WHERE ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ID#">
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error updating the records.">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="updateHRWProcedureStatusList" access="public" returntype="struct">
    <cfargument name="ID" type="numeric" required="yes">
    <cfargument name="hrwpsStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully updated the records.">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_hrw_procedure_status SET
    hrwpsStatus = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.hrwpsStatus#">
    WHERE ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ID#">
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error updating the records.">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="deleteHRWEmployee" access="public" returntype="struct">
    <cfargument name="ID" type="string" required="yes">
    <cfset result.message = "You have successfully deleted the record(s).">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    DELETE FROM tbl_hrw_employee
    WHERE ID IN (<cfqueryparam cfsqltype="cf_sql_integer" list="yes" value="#ARGUMENTS.ID#">)
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error deleting the record(s).">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="deleteHRWProcedureUnit" access="public" returntype="struct">
    <cfargument name="ID" type="string" required="yes">
    <cfset result.message = "You have successfully deleted the record(s).">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    DELETE FROM tbl_hrw_procedure_unit
    WHERE ID IN (<cfqueryparam cfsqltype="cf_sql_integer" list="yes" value="#ARGUMENTS.ID#">)
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error deleting the record(s).">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="deleteHRWProcedure" access="public" returntype="struct">
    <cfargument name="ID" type="string" required="yes">
    <cfset result.message = "You have successfully deleted the record(s).">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    DELETE FROM tbl_hrw_procedure
    WHERE ID IN (<cfqueryparam cfsqltype="cf_sql_integer" list="yes" value="#ARGUMENTS.ID#">)
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error deleting the record(s).">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="deleteHRWProcedureDocumentRel" access="public" returntype="struct">
    <cfargument name="ID" type="string" required="yes">
    <cfset result.message = "You have successfully deleted the record(s).">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    DELETE FROM tbl_hrw_p_document_rel
    WHERE ID IN (<cfqueryparam cfsqltype="cf_sql_integer" list="yes" value="#ARGUMENTS.ID#">)
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error deleting the record(s).">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="deleteHRWProcedureStatus" access="public" returntype="struct">
    <cfargument name="ID" type="string" required="yes">
    <cfset result.message = "You have successfully deleted the record(s).">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    DELETE FROM tbl_hrw_procedure_status
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