<cfcomponent>  
    <cffunction name="getFTP" access="public" returntype="query" hint="Get FTP data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="ID" type="string" required="yes" default="0">
    <cfargument name="excludeID" type="numeric" required="yes" default="0">
    <cfargument name="ftpName" type="string" required="yes" default="">
    <cfargument name="netID" type="numeric" required="yes" default="0">
    <cfargument name="ftptID" type="numeric" required="yes" default="0">
    <cfargument name="ftpStatus" type="string" required="yes" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="ftpName">
    <cfset var rsFTP = "" >
    <cftry>
    <cfquery name="rsFTP" datasource="#application.mcmsDSN#">
    SELECT * FROM v_ftp WHERE 0=0
    <cfif ARGUMENTS.ID NEQ 0>
    AND ID IN (<cfqueryparam value="#ARGUMENTS.ID#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    <cfif ARGUMENTS.excludeID NEQ 0>
    AND ID <> <cfqueryparam value="#ARGUMENTS.excludeID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(ftpName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR (UPPER(ftpDescription) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">)
    </cfif>
    <cfif ARGUMENTS.ftpName NEQ "">
    AND UPPER(ftpName) = <cfqueryparam value="#UCASE(ARGUMENTS.ftpName)#" cfsqltype="cf_sql_varchar">
    </cfif>
    <cfif ARGUMENTS.netID NEQ 0>
    AND netID = <cfqueryparam value="#ARGUMENTS.netID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.ftptID NEQ 0>
    AND ftptID = <cfqueryparam value="#ARGUMENTS.ftptID#" cfsqltype="cf_sql_integer">
    </cfif>
    AND ftpStatus IN (<cfqueryparam value="#ARGUMENTS.ftpStatus#" list="yes" cfsqltype="cf_sql_integer">)
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsFTP = StructNew()>
    <cfset rsFTP.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsFTP>
    </cffunction>
    
    <cffunction name="getFTPType" access="public" returntype="query" hint="Get FTP Type data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="ID" type="numeric" required="yes" default="0">
    <cfargument name="excludeID" type="numeric" required="yes" default="0">
    <cfargument name="ftptName" type="string" required="yes" default="">
    <cfargument name="ftptStatus" type="string" required="yes" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="ftptName">
    <cfset var rsFTPType = "" >
    <cftry>
    <cfquery name="rsFTPType" datasource="#application.mcmsDSN#">
    SELECT * FROM v_ftp_type WHERE 0=0
    <cfif ARGUMENTS.ID NEQ 0>
    AND ID = <cfqueryparam value="#ARGUMENTS.ID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.excludeID NEQ 0>
    AND ID <> <cfqueryparam value="#ARGUMENTS.excludeID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(ftptName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">)
    </cfif>
    <cfif ARGUMENTS.ftptName NEQ ''>
    AND UPPER(ftptName) = <cfqueryparam value="#UCASE(ARGUMENTS.ftptName)#" cfsqltype="cf_sql_varchar">
    </cfif>
    AND ftptStatus IN (<cfqueryparam value="#ARGUMENTS.ftptStatus#" list="yes" cfsqltype="cf_sql_integer">)
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsFTPType = StructNew()>
    <cfset rsFTPType.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsFTPType>
    </cffunction>
    
    <cffunction name="getFTPUser" access="public" returntype="query" hint="Get FTP User data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="ID" type="numeric" required="yes" default="0">
    <cfargument name="excludeID" type="numeric" required="yes" default="0">
    <cfargument name="ftpuEmail" type="string" required="yes" default="">
    <cfargument name="ftputID" type="string" required="yes" default="">
    <cfargument name="ftpuStatus" type="string" required="yes" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="ftpuLName">
    <cfset var rsFTPUser = "" >
    <cftry>
    <cfquery name="rsFTPUser" datasource="#application.mcmsDSN#">
    SELECT * FROM v_ftp_user WHERE 0=0
    <cfif ARGUMENTS.ID NEQ 0>
    AND ID = <cfqueryparam value="#ARGUMENTS.ID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.excludeID NEQ 0>
    AND ID <> <cfqueryparam value="#ARGUMENTS.excludeID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(ftpuFName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(ftpuLName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(ftpuEmail) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">)
    </cfif>
    <cfif ARGUMENTS.ftpuEmail NEQ "">
    AND UPPER(ftpuEmail) = <cfqueryparam value="#UCASE(ARGUMENTS.ftpuEmail)#" cfsqltype="cf_sql_varchar">
    </cfif>
    <cfif ARGUMENTS.ftputID NEQ "">
    AND ftputID IN (<cfqueryparam value="#ARGUMENTS.ftputID#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    AND ftpuStatus IN (<cfqueryparam value="#ARGUMENTS.ftpuStatus#" list="yes" cfsqltype="cf_sql_integer">)
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsFTPUser = StructNew()>
    <cfset rsFTPUser.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsFTPUser>
    </cffunction>
    
    <cffunction name="getFTPUserType" access="public" returntype="query" hint="Get FTP User Type data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="ID" type="numeric" required="yes" default="0">
    <cfargument name="excludeID" type="numeric" required="yes" default="0">
    <cfargument name="ftputName" type="string" required="yes" default="">
    <cfargument name="ftputStatus" type="string" required="yes" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="ID, ftputName">
    <cfset var rsFTPUserType = "" >
    <cftry>
    <cfquery name="rsFTPUserType" datasource="#application.mcmsDSN#">
    SELECT * FROM v_ftp_user_type WHERE 0=0
    <cfif ARGUMENTS.ID NEQ 0>
    AND ID = <cfqueryparam value="#ARGUMENTS.ID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.excludeID NEQ 0>
    AND ID <> <cfqueryparam value="#ARGUMENTS.excludeID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(ftputName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">)
    </cfif>
    <cfif ARGUMENTS.ftputName NEQ ''>
    AND UPPER(ftputName) = <cfqueryparam value="#UCASE(ARGUMENTS.ftputName)#" cfsqltype="cf_sql_varchar">
    </cfif>
    AND ftputStatus IN (<cfqueryparam value="#ARGUMENTS.ftputStatus#" list="yes" cfsqltype="cf_sql_integer">)
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsFTPUserType = StructNew()>
    <cfset rsFTPUserType.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsFTPUserType>
    </cffunction>
    
    <cffunction name="getFTPUserDepartmentRel" access="public" returntype="query" hint="Get FTP User Department Relationship data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="ID" type="numeric" required="yes" default="0">
    <cfargument name="excludeID" type="numeric" required="yes" default="0">
    <cfargument name="ftpuID" type="numeric" required="yes" default="0">
    <cfargument name="deptNo" type="string" required="yes" default="0">
    <cfargument name="ftpudrStatus" type="string" required="yes" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="ID">
    <cfset var rsFTPUserDepartmentRel = "" >
    <cftry>
    <cfquery name="rsFTPUserDepartmentRel" datasource="#application.mcmsDSN#">
    SELECT * FROM v_ftp_user_department_rel WHERE 0=0
    <cfif ARGUMENTS.ID NEQ 0>
    AND ID = <cfqueryparam value="#ARGUMENTS.ID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.excludeID NEQ 0>
    AND ID <> <cfqueryparam value="#ARGUMENTS.excludeID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(ftpuFName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(ftpuLName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">)
    </cfif>
    <cfif ARGUMENTS.ftpuID NEQ 0>
    AND ftpuID = <cfqueryparam value="#ARGUMENTS.ftpuID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.deptNo NEQ 0>
    AND deptNo IN (<cfqueryparam value="#ARGUMENTS.deptNo#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    AND ftpudrStatus IN (<cfqueryparam value="#ARGUMENTS.ftpudrStatus#" list="yes" cfsqltype="cf_sql_integer">)
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsFTPUserDepartmentRel = StructNew()>
    <cfset rsFTPUserDepartmentRel.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsFTPUserDepartmentRel>
    </cffunction>
    
    <cffunction name="getFTPUserRel" access="public" returntype="query" hint="Get FTP User data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="ID" type="numeric" required="yes" default="0">
    <cfargument name="excludeID" type="numeric" required="yes" default="0">
    <cfargument name="ftpID" type="numeric" required="yes" default="0">
    <cfargument name="ftpuID" type="numeric" required="yes" default="0">
    <cfargument name="ftpurStatus" type="string" required="yes" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="ID">
    <cfset var rsFTPUserRel = "" >
    <cftry>
    <cfquery name="rsFTPUserRel" datasource="#application.mcmsDSN#">
    SELECT * FROM v_ftp_user_rel WHERE 0=0
    <cfif ARGUMENTS.ID NEQ 0>
    AND ID = <cfqueryparam value="#ARGUMENTS.ID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.excludeID NEQ 0>
    AND ID <> <cfqueryparam value="#ARGUMENTS.excludeID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(ftpuFName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(ftpuLName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(ftpName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">)
    </cfif>
    <cfif ARGUMENTS.ftpID NEQ 0>
    AND ftpID = <cfqueryparam value="#ARGUMENTS.ftpID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.ftpuID NEQ 0>
    AND ftpuID = <cfqueryparam value="#ARGUMENTS.ftpuID#" cfsqltype="cf_sql_integer">
    </cfif>
    AND ftpurStatus IN (<cfqueryparam value="#ARGUMENTS.ftpurStatus#" list="yes" cfsqltype="cf_sql_integer">)
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsFTPUserRel = StructNew()>
    <cfset rsFTPUserRel.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsFTPUserRel>
    </cffunction>
    
    <cffunction name="getFTPFile" access="public" returntype="query" hint="Get FTP File data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="ID" type="string" required="yes" default="0">
    <cfargument name="excludeID" type="numeric" required="yes" default="0">
    <cfargument name="ftpID" type="numeric" required="yes" default="0">
    <cfargument name="ftpfFile" type="string" required="yes" default="">
    <cfargument name="ftpfPath" type="string" required="yes" default="">
    <cfargument name="ftpuID" type="numeric" required="yes" default="0">
    <cfargument name="ftputID" type="numeric" required="yes" default="0">
    <cfargument name="ftpftID" type="numeric" required="yes" default="0">
    <cfargument name="ftpfDate" type="string" required="yes" default="">
    <cfargument name="ftpfDateExp" type="string" required="yes" default="">
    <cfargument name="ftpfStatus" type="string" required="yes" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="ftpfFile">
    <cfset var rsFTPFile = "" >
    <cftry>
    <cfquery name="rsFTPFile" datasource="#application.mcmsDSN#">
    SELECT * FROM v_ftp_file WHERE 0=0
    <cfif ARGUMENTS.ID NEQ 0>
    AND ID IN (<cfqueryparam value="#ARGUMENTS.ID#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    <cfif ARGUMENTS.excludeID NEQ 0>
    AND ID <> <cfqueryparam value="#ARGUMENTS.excludeID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(ftpfFile) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">)
    </cfif>
    <cfif ARGUMENTS.ftpfFile NEQ ''>
    AND UPPER(ftpfFile) = <cfqueryparam value="#UCASE(ARGUMENTS.ftpfFile)#" cfsqltype="cf_sql_varchar">
    </cfif>
    <cfif ARGUMENTS.ftpfPath NEQ ''>
    AND UPPER(ftpfPath) = <cfqueryparam value="#UCASE(ARGUMENTS.ftpfPath)#" cfsqltype="cf_sql_varchar">
    </cfif>
    <cfif ARGUMENTS.ftpID NEQ 0>
    AND ftpID = <cfqueryparam value="#ARGUMENTS.ftpID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.ftpuID NEQ 0>
    AND ftpuID = <cfqueryparam value="#ARGUMENTS.ftpuID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.ftpftID NEQ 0>
    AND ftpftID = <cfqueryparam value="#ARGUMENTS.ftpftID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.ftputID NEQ 0>
    AND ftputID = <cfqueryparam value="#ARGUMENTS.ftputID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.ftpfDateExp NEQ "">
    AND TO_CHAR(ftpfDateExp, 'MM/DD/YYYY') <= <cfqueryparam value="#DateFormat(ARGUMENTS.ftpfDateExp, application.dateFormat)#" cfsqltype="cf_sql_varchar">
    </cfif>
    AND ftpfStatus IN (<cfqueryparam value="#ARGUMENTS.ftpfStatus#" list="yes" cfsqltype="cf_sql_integer">)
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsFTPFile = StructNew()>
    <cfset rsFTPFile.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsFTPFile>
    </cffunction>
    
    <cffunction name="getFTPFileType" access="public" returntype="query" hint="Get FTP File Type data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="ID" type="numeric" required="yes" default="0">
    <cfargument name="excludeID" type="numeric" required="yes" default="0">
    <cfargument name="ftpftName" type="string" required="yes" default="">
    <cfargument name="ftpftStatus" type="string" required="yes" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="ftpftName">
    <cfset var rsFTPFileType = "" >
    <cftry>
    <cfquery name="rsFTPFileType" datasource="#application.mcmsDSN#">
    SELECT * FROM v_ftp_file_type WHERE 0=0
    <cfif ARGUMENTS.ID NEQ 0>
    AND ID = <cfqueryparam value="#ARGUMENTS.ID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.excludeID NEQ 0>
    AND ID <> <cfqueryparam value="#ARGUMENTS.excludeID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(ftpftName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">)
    </cfif>
    AND ftpftStatus IN (<cfqueryparam value="#ARGUMENTS.ftpftStatus#" list="yes" cfsqltype="cf_sql_integer">)
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsFTPFileType = StructNew()>
    <cfset rsFTPFileType.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsFTPFileType>
    </cffunction>
    
    <cffunction name="getFTPLog" access="public" returntype="query" hint="Get FTP Log data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="ID" type="numeric" required="yes" default="0">
    <cfargument name="excludeID" type="numeric" required="yes" default="0">
    <cfargument name="ftpID" type="numeric" required="yes" default="0">
    <cfargument name="ftpuID" type="numeric" required="yes" default="0">
    <cfargument name="ftpltID" type="numeric" required="yes" default="0">
    <cfargument name="ftplAction" type="string" required="yes" default="">
    <cfargument name="ftplDate" type="string" required="yes" default="">
    <cfargument name="ftplStatus" type="string" required="yes" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="ftplAction">
    <cfset var rsFTPLog = "" >
    <cftry>
    <cfquery name="rsFTPLog" datasource="#application.mcmsDSN#">
    SELECT * FROM v_ftp_log WHERE 0=0
    <cfif ARGUMENTS.ID NEQ 0>
    AND ID = <cfqueryparam value="#ARGUMENTS.ID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.excludeID NEQ 0>
    AND ID <> <cfqueryparam value="#ARGUMENTS.excludeID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(ftplAction) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(ftplInformation) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(ftpuLName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">)
    </cfif>
    <cfif ARGUMENTS.ftpID NEQ 0>
    AND ftpID = <cfqueryparam value="#ARGUMENTS.ftpID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.ftpuID NEQ 0>
    AND ftpuID = <cfqueryparam value="#ARGUMENTS.ftpuID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.ftpltID NEQ 0>
    AND ftpltID = <cfqueryparam value="#ARGUMENTS.ftpltID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.ftplAction NEQ ''>
    AND UPPER(ftplAction) = <cfqueryparam value="#UCASE(ARGUMENTS.ftplAction)#" cfsqltype="cf_sql_varchar">
    </cfif>
    <cfif ARGUMENTS.ftplDate NEQ "">
    AND TO_CHAR(ftplDate, 'MM/DD/YYYY') = <cfqueryparam value="#DateFormat(ARGUMENTS.ftplDate, application.dateFormat)#" cfsqltype="cf_sql_varchar">
    </cfif>
    AND ftplStatus IN (<cfqueryparam value="#ARGUMENTS.ftplStatus#" list="yes" cfsqltype="cf_sql_integer">)
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsFTPLog = StructNew()>
    <cfset rsFTPLog.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsFTPLog>
    </cffunction>
    
    <cffunction name="getFTPReport" access="public" returntype="query" hint="Get FTP Report data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="orderBy" type="string" required="yes" default="ftpName">
    <cfset var rsFTPReport = "" >
    <cftry>
    <cfquery name="rsFTPReport" datasource="#application.mcmsDSN#">
    SELECT ftpName AS Name, ftpDescription AS Description, ftpProxy AS Proxy, netName AS Network, ftptName AS Type, sName AS Status FROM v_ftp WHERE 0=0
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(ftpName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">)
    </cfif>
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsFTPReport = StructNew()>
    <cfset rsFTPReport.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsFTPReport>
    </cffunction>
    
    <cffunction name="getFTPTypeReport" access="public" returntype="query" hint="Get FTP Type Report data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="orderBy" type="string" required="yes" default="ftptName">
    <cfset var rsFTPTypeReport = "" >
    <cftry>
    <cfquery name="rsFTPTypeReport" datasource="#application.mcmsDSN#">
    SELECT ftptName AS Name, TO_CHAR(ftptDescription) AS Description, sName AS Status FROM v_ftp_type WHERE 0=0
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(ftptName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">)
    </cfif>
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsFTPTypeReport = StructNew()>
    <cfset rsFTPTypeReport.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsFTPTypeReport>
    </cffunction>
    
    <cffunction name="getFTPLogReport" access="public" returntype="query" hint="Get FTP Type Report data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="orderBy" type="string" required="yes" default="ftptName">
    <cfset var rsFTPTypeReport = "" >
    <cftry>
    <cfquery name="rsFTPTypeReport" datasource="#application.mcmsDSN#">
    SELECT ftplAction AS Action, ftplInformation AS Information, ftpuFName || ' ' || ftpuLName AS Name, ftpuEmail AS Email, userIP AS IP_Address, TO_CHAR(ftplDate, 'MM/DD/YYYY') AS Log_Date, TO_CHAR(ftpuDateLast, 'MM/DD/YYYY') AS Date_Last, sName AS Status FROM v_ftp_log WHERE 0=0
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(ftplAction) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(ftplInformation) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(ftpuLName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">)
    </cfif>
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsFTPTypeReport = StructNew()>
    <cfset rsFTPTypeReport.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsFTPTypeReport>
    </cffunction>
    
    <cffunction name="getFTPUserReport" access="public" returntype="query" hint="Get FTP User Report data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="orderBy" type="string" required="yes" default="ftpuFName">
    <cfset var rsFTPUserReport = "" >
    <cftry>
    <cfquery name="rsFTPUserReport" datasource="#application.mcmsDSN#">
    SELECT ftpuFName || ' ' || ftpuLName AS Name, ftpuEmail AS Email, userFName || ' ' || userLName AS User_Created, userIP AS User_IP, TO_CHAR(ftpuDateHistory, 'MM/DD/YYYY') AS History, TO_CHAR(ftpuDateLast, 'MM/DD/YYYY') AS Date_Last, sName AS Status FROM v_ftp_user WHERE 0=0
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(ftpuFName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(ftpuLName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(ftpuEmail) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">)
    </cfif>
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsFTPUserReport = StructNew()>
    <cfset rsFTPUserReport.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsFTPUserReport>
    </cffunction>
    
    <cffunction name="getFTPUserRelReport" access="public" returntype="query" hint="Get FTP User Relationship Report data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="orderBy" type="string" required="yes" default="ftpuLName">
    <cfset var rsFTPUserRelReport = "" >
    <cftry>
    <cfquery name="rsFTPUserRelReport" datasource="#application.mcmsDSN#">
    SELECT ftpName AS FTP, ftpuFName || ' ' || ftpuLName AS FTP_User, ftpuEmail AS Email, sName AS Status FROM v_ftp_user_rel WHERE 0=0
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(ftpuFName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(ftpuLName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(ftpName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">)
    </cfif>
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsFTPUserRelReport = StructNew()>
    <cfset rsFTPUserRelReport.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsFTPUserRelReport>
    </cffunction>
    
    <cffunction name="getFTPUserDepartmentRelReport" access="public" returntype="query" hint="Get FTP User Department Relationship Report data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="orderBy" type="string" required="yes" default="ftpuLName">
    <cfset var rsFTPUserDepartmentRelReport = "" >
    <cftry>
    <cfquery name="rsFTPUserDepartmentRelReport" datasource="#application.mcmsDSN#">
    SELECT ftpuFName || ' ' || ftpuLName AS FTP_User, ftpuEmail AS Email, deptNo, deptName AS Department, sName AS Status FROM v_ftp_user_department_rel WHERE 0=0
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(ftpuFName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(ftpuLName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">)
    </cfif>
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsFTPUserDepartmentRelReport = StructNew()>
    <cfset rsFTPUserDepartmentRelReport.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsFTPUserDepartmentRelReport>
    </cffunction>
    
    <cffunction name="getFTPUserTypeReport" access="public" returntype="query" hint="Get FTP User Type Report data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="orderBy" type="string" required="yes" default="ftputName">
    <cfset var rsFTPUserTypeReport = "" >
    <cftry>
    <cfquery name="rsFTPUserTypeReport" datasource="#application.mcmsDSN#">
    SELECT ftputName AS Name, TO_CHAR(ftputDescription) AS Description, sName AS Status FROM v_ftp_user_type WHERE 0=0
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(ftputName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(ftputDescription) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">)
    </cfif>
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsFTPUserTypeReport = StructNew()>
    <cfset rsFTPUserTypeReport.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsFTPUserTypeReport>
    </cffunction>
    
    <cffunction name="getFTPFileReport" access="public" returntype="query" hint="Get FTP File Report data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="orderBy" type="string" required="yes" default="ftpfFile">
    <cfset var rsFTPFileReport = "" >
    <cftry>
    <cfquery name="rsFTPFileReport" datasource="#application.mcmsDSN#">
    SELECT ftpfPath || '/' || ftpfFile AS Filename, ftpName AS FTP, ftpuFName || ' ' || ftpuLName AS FTP_User, ftpuEmail AS Email, ftpfSize AS Size_KB, TO_CHAR(ftpfDate, 'MM/DD/YYYY') AS Upload_Date, TO_CHAR(ftpfDateExp, 'MM/DD/YYYY') AS Date_Expire, sName AS Status 
    FROM v_ftp_file 
    WHERE 0=0
    AND ftpftID = <cfqueryparam cfsqltype="cf_sql_integer" value="1">
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(ftpuFName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(ftpuLName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(ftpfFile) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">)
    </cfif>
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsFTPFileReport = StructNew()>
    <cfset rsFTPFileReport.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsFTPFileReport>
    </cffunction>
    
    <cffunction name="insertFTP" access="public" returntype="struct">
    <cfargument name="ftpName" type="string" required="yes">
    <cfargument name="ftpDescription" type="string" required="yes">
    <cfargument name="ftpProxy" type="string" required="yes" default="">
    <cfargument name="ftpPath" type="string" required="yes" default="">
    <cfargument name="netID" type="numeric" required="yes">
    <cfargument name="ftptID" type="numeric" required="yes">
    <cfargument name="ftpStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully inserted the record.">
    <cftry>
    <!---Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.app.ftp.Ftp"
    method="getFTP"
    returnvariable="getCheckFTPRet">
    <cfinvokeargument name="ftpName" value="#ARGUMENTS.ftpName#"/>
    <cfinvokeargument name="ftpStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckFTPRet.recordcount NEQ 0>
    <cfset result.message = "The ftp #ARGUMENTS.ftpName# already exists, please try again.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    INSERT INTO tbl_ftp (ftpName,ftpDescription,ftpProxy,ftpPath,netID,ftptID,ftpStatus) VALUES
    (
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.ftpName#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.ftpDescription#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.ftpProxy#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.ftpPath#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.netID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ftptID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ftpStatus#">
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
    
    <cffunction name="insertFTPUser" access="public" returntype="struct">
    <cfargument name="ftpuFName" type="string" required="yes">
    <cfargument name="ftpuLName" type="string" required="yes">
    <cfargument name="ftpuEmail" type="string" required="yes">
    <cfargument name="ftpuPassword" type="string" required="yes">
    <cfargument name="ftpuTelArea" type="string" required="yes" default="">
    <cfargument name="ftpuTelPrefix" type="string" required="yes" default="">
    <cfargument name="ftpuTelSuffix" type="string" required="yes" default="">
    <cfargument name="userID" type="numeric" required="yes" default="0">
    <cfargument name="userIP" type="string" required="yes" default="#CGI.REMOTE_ADDR#">
    <cfargument name="vID" type="numeric" required="yes" default="0">
    <cfargument name="ftpuDateExp" type="string" required="yes" default="">
    <cfargument name="ftputID" type="numeric" required="yes" default="0">
    <cfargument name="ftpuStatus" type="numeric" required="yes" default="1">
    <!---Include any relationships.--->
    <cfargument name="ftpID" type="string" required="yes" default="0">
    <cfargument name="deptNo" type="string" required="yes" default="0">
    <cfset result.message = "You have successfully inserted the record.">
    <cftry>
    <!---Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.app.ftp.Ftp"
    method="getFTPUser"
    returnvariable="getCheckFTPUserRet">
    <cfinvokeargument name="ftpuEmail" value="#ARGUMENTS.ftpuEmail#"/>
    <cfinvokeargument name="ftpuStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckFTPUserRet.recordcount NEQ 0>
    <cfset result.message = "The email #ARGUMENTS.ftpuEmail# already exists, <br/>please enter a email or retrieve the password.">
    <cfelse>
    <!---If encryption is used and no value is present create it.--->
    <cfinvoke 
    component="MCMS.component.app.security.Security"
    method="setEcryption"
    returnvariable="setEcryptionRet">
    <cfinvokeargument name="value" value="#ARGUMENTS.userPassword#"/>
    <cfinvokeargument name="valuePair" value="lorem"/>
    </cfinvoke>
    <cfset ARGUMENTS.userPassword = setEcryptionRet.encryptKey>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    INSERT INTO tbl_ftp_user (ftpuFName,ftpuLName,ftpuEmail,ftpuPassword,ftpuTelArea,ftpuTelPrefix,ftpuTelSuffix,userID,userIP,vID,ftpuDateExp,ftputID,ftpuStatus) VALUES
    (
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.ftpuFName#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.ftpuLName#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.ftpuEmail#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.ftpuPassword#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.ftpuTelArea#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.ftpuTelPrefix#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.ftpuTelSuffix#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.userID#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.userIP#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.vID#">,
    <cfqueryparam cfsqltype="cf_sql_date" value="#ARGUMENTS.ftpuDateExp#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ftputID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ftpuStatus#">
    )
    </cfquery>
    </cftransaction>
    <!---Get the ftpuID just added.--->
    <cfinvoke 
    component="MCMS.component.app.ftp.Ftp"
    method="getFTPUser"
    returnvariable="getFTPUserIDRet">
    <cfinvokeargument name="ftpuEmail" value="#ARGUMENTS.ftpuEmail#"/>
    <cfinvokeargument name="ftpuStatus" value="1,2,3"/>
    </cfinvoke>
    <cfset this.ftpuID = getFTPUserIDRet.ID>
    <!---Set encryption key.--->
    <cfinvoke 
    component="MCMS.component.app.ftp.Ftp"
    method="insertFTPUserSecurityKeyRel"
    returnvariable="insertFTPUserSecurityKeyRelRet">
    <cfinvokeargument name="ftpuID" value="#this.ftpuID#"/>
    <cfinvokeargument name="ftpuskrKey" value="#setEcryptionRet.encryptKey#"/>
    <cfinvokeargument name="ftpuskrKeyValue" value="#setEcryptionRet.encryptKeyValue#"/>
    <cfinvokeargument name="ftpuskrStatus" value="1"/>
    </cfinvoke>
    <!---Insert ftp relationships if applicable.--->
	
	<!---Insert department relationships if applicable.--->
    <!---Create department relationships.--->
    <cfloop index="deptNo" list="#ARGUMENTS.deptNo#">
    <cfinvoke 
    component="MCMS.component.app.ftp.Ftp"
    method="insertFTPUserDepartmentRel"
    returnvariable="insertFTPUserDepartmentRelRet">
    <cfinvokeargument name="ftpuID" value="#this.ftpuID#"/>
    <cfinvokeargument name="deptNo" value="#deptNo#"/>
    <cfinvokeargument name="ftpudrStatus" value="1"/>
    </cfinvoke>
    </cfloop>
    <!---Send email notifications.--->
    <cfinvoke 
    component="MCMS.component.utility.Email"
    method="sendEmail">
    <cfinvokeargument name="subject" value="FTP Registration Complete"/>
    <cfinvokeargument name="to" value="#ARGUMENTS.ftpuEmail#"/>
    <cfinvokeargument name="from" value="#session.userUsername#"/>
    <cfinvokeargument name="ID" value="#this.ID#"/>
    <cfinvokeargument name="emailTemplate" value="/#application.mcmsAppAdminPath#/ftp/view/inc_ftp_registration_email.cfm"/>
    <cfinvokeargument name="emailType" value="html"/>
    <cfinvokeargument name="type" value="admin"/>
    </cfinvoke>
    </cfif>
    <cfcatch type="any">
    <cfset result.message = "There was an error inserting the record.">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="insertFTPUserSecurityKeyRel" access="public" returntype="struct">
    <cfargument name="ftpuID" type="numeric" required="yes">
    <cfargument name="ftpuskrKey" type="string" required="yes">
    <cfargument name="ftpuskrKeyValue" type="string" required="yes">
    <cfargument name="ftpuskrStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully inserted the record.">
    <cftry>
	<!---Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.app.ftp.Ftp"
    method="getFTPUserSecurityKeyRel"
    returnvariable="getCheckFTPUserSecurityKeyRelRet">
    <cfinvokeargument name="ftpuID" value="#ARGUMENTS.ftpuID#"/>
    <cfinvokeargument name="ftpuskrStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckFTPUserSecurityKeyRelRet.recordcount NEQ 0>
    <cfset result.message = "The user security key relationship already exists, please try again.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    INSERT INTO tbl_ftp_user_sec_key_rel (ftpuID,ftpuskrKey,ftpuskrKeyValue,ftpuskrStatus) VALUES
    (
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ftpuID#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.ftpuskrKey#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.ftpuskrKeyValue#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ftpuskrStatus#">
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
    
    <cffunction name="insertFTPLog" access="public" returntype="struct">
    <cfargument name="ftpID" type="numeric" required="yes">
    <cfargument name="ftpuID" type="numeric" required="yes">
    <cfargument name="ftplAction" type="string" required="yes">
    <cfargument name="ftplInformation" type="string" required="yes">
    <cfargument name="userIP" type="string" required="yes" default="#CGI.REMOTE_ADDR#">
    <cfargument name="ftplDate" type="string" required="yes">
    <cfargument name="ftplStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully inserted the record.">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    INSERT INTO tbl_ftp_log (ftpID,ftpuID,ftplAction,ftplInformation,userIP,ftplDate,ftplStatus) VALUES
    (
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ftpID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ftpuID#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.ftplAction#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.ftplInformation#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.userIP#">,
    <cfqueryparam cfsqltype="cf_sql_timestamp" value="#ARGUMENTS.ftplDate#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ftplStatus#">
    )
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error inserting the record.">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="insertFTPUserRel" access="public" returntype="struct">
    <cfargument name="ftpuID" type="numeric" required="yes">
    <cfargument name="ftpID" type="numeric" required="yes">
    <cfargument name="ftpurStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully inserted the record.">
    <cftry>
    <!---Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.app.ftp.Ftp"
    method="getFTPUserRel"
    returnvariable="getCheckFTPUserRelRet">
    <cfinvokeargument name="ftpuID" value="#ARGUMENTS.ftpuID#"/>
    <cfinvokeargument name="ftpID" value="#ARGUMENTS.ftpID#"/>
    <cfinvokeargument name="ftpurStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckFTPUserRelRet.recordcount NEQ 0>
    <cfset result.message = "The user ftp relationship already exists, please try again.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    INSERT INTO tbl_ftp_user_rel (ftpuID,ftpID,ftpurStatus) VALUES
    (   
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ftpuID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ftpID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ftpurStatus#">
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
    
    <cffunction name="insertFTPUserDepartmentRel" access="public" returntype="struct">
    <cfargument name="ftpuID" type="numeric" required="yes">
    <cfargument name="deptNo" type="numeric" required="yes">
    <cfargument name="ftpudrStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully inserted the record.">
    <cftry>
    <!---Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.app.ftp.Ftp"
    method="getFTPUserDepartmentRel"
    returnvariable="getCheckFTPUserDepartmentRelRet">
    <cfinvokeargument name="ftpuID" value="#ARGUMENTS.ftpuID#"/>
    <cfinvokeargument name="deptNo" value="#ARGUMENTS.deptNo#"/>
    <cfinvokeargument name="ftpudrStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckFTPUserDepartmentRelRet.recordcount NEQ 0>
    <cfset result.message = "The user department relationship already exists, please try again.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    INSERT INTO tbl_ftp_user_department_rel (ftpuID,deptNo,ftpudrStatus) VALUES
    (   
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ftpuID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.deptNo#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ftpudrStatus#">
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
    
    <cffunction name="insertFTPUserType" access="public" returntype="struct">
    <cfargument name="ftputName" type="string" required="yes">
    <cfargument name="ftputDescription" type="string" required="yes">
    <cfargument name="ftputStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully inserted the record.">
    <cftry>
    <!---Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.app.ftp.Ftp"
    method="getFTPUserType"
    returnvariable="getCheckFTPTypeRet">
    <cfinvokeargument name="ftputName" value="#ARGUMENTS.ftputName#"/>
    <cfinvokeargument name="ftputStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckFTPTypeRet.recordcount NEQ 0>
    <cfset result.message = "The user type already exists, please try again.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    INSERT INTO tbl_ftp_user_type (ftputName,ftputDescription,ftputStatus) VALUES
    (
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.ftputName#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.ftputDescription#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ftputStatus#">
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
    
    <cffunction name="insertFTPType" access="public" returntype="struct">
    <cfargument name="ftptName" type="string" required="yes">
    <cfargument name="ftptDescription" type="string" required="yes">
    <cfargument name="ftptStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully inserted the record.">
    <cftry>
    <!---Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.app.ftp.Ftp"
    method="getFTPType"
    returnvariable="getCheckFTPTypeRet">
    <cfinvokeargument name="ftputName" value="#ARGUMENTS.ftputName#"/>
    <cfinvokeargument name="ftputStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckFTPTypeRet.recordcount NEQ 0>
    <cfset result.message = "The ftp type #ARGUMENTS.ftputName# already exists, please try again.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    INSERT INTO tbl_ftp_type (ftptName,ftptDescription,ftptStatus) VALUES
    (
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.ftptName#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.ftptDescription#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ftptStatus#">
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
    
    <cffunction name="updateFTPUser" access="public" returntype="struct">
    <cfargument name="ID" type="numeric" required="yes">
    <cfargument name="ftpuFName" type="string" required="yes">
    <cfargument name="ftpuLName" type="string" required="yes">
    <cfargument name="ftpuEmail" type="string" required="yes">
    <cfargument name="ftpuPassword" type="string" required="yes">
    <cfargument name="ftpuTelArea" type="string" required="yes" default="">
    <cfargument name="ftpuTelPrefix" type="string" required="yes" default="">
    <cfargument name="ftpuTelSuffix" type="string" required="yes" default="">
    <cfargument name="userID" type="numeric" required="yes" default="0">
    <cfargument name="userIP" type="string" required="yes" default="#CGI.REMOTE_ADDR#">
    <cfargument name="vID" type="numeric" required="yes" default="0">
    <cfargument name="ftputID" type="numeric" required="yes" default="0">
    <cfargument name="ftpuStatus" type="numeric" required="yes" default="1">
    <!---Include any relationships.--->
    <cfargument name="ftpID" type="string" required="yes" default="0">
    <cfargument name="deptNo" type="string" required="yes" default="0">
    <cfset result.message = "You have successfully updated the record.">
    <cftry>
    <!---Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.app.ftp.Ftp"
    method="getFTPUser"
    returnvariable="getCheckFTPUserRet">
    <cfinvokeargument name="excludeID" value="#ARGUMENTS.ID#"/>
    <cfinvokeargument name="ftpuEmail" value="#ARGUMENTS.ftpuEmail#"/>
    <cfinvokeargument name="ftpuStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckFTPUserRet.recordcount NEQ 0>
    <cfset result.message = "The email #ARGUMENTS.ftpuEmail# already exists, please enter a new email.">
    <cfelse>
    <!---Encrypt the password it is reset.--->
    <cfif ARGUMENTS.ftpuPassword NEQ ''>
    <cfinvoke 
    component="MCMS.component.app.security.Security"
    method="setEcryption"
    returnvariable="setEcryptionRet">
    <cfinvokeargument name="value" value="#ARGUMENTS.ftpuPassword#"/>
    <cfinvokeargument name="valuePair" value="lorem"/>
    </cfinvoke>
    <cfset ARGUMENTS.ftpuPassword = setEcryptionRet.encryptKey>
    <!---Set encryption key.--->
    <cfinvoke 
    component="MCMS.component.app.ftp.Ftp"
    method="updateFTPUserSecurityKeyRel"
    returnvariable="updateFTPUserSecurityKeyRelRet">
    <cfinvokeargument name="ftpuID" value="#ARGUMENTS.ID#"/>
    <cfinvokeargument name="ftpuskrKey" value="#setEcryptionRet.encryptKey#"/>
    <cfinvokeargument name="ftpuskrKeyValue" value="#setEcryptionRet.encryptKeyValue#"/>
    <cfinvokeargument name="ftpuskrStatus" value="1"/>
    </cfinvoke>
    </cfif>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_ftp_user SET
    ftpuFName = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.ftpuFName#">,
    ftpuLName = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.ftpuLName#">,
    ftpuEmail = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.ftpuEmail#">,
    <cfif ARGUMENTS.ftpuPassword NEQ ''>
    ftpuPassword = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.ftpuPassword#">,
    </cfif>
    ftpuTelArea = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.ftpuTelArea#">,
    ftpuTelPrefix = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.ftpuTelPrefix#">,
    ftpuTelSuffix = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.ftpuTelSuffix#">,
    userID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.userID#">,
    userIP = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.userIP#">,
    vID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.vID#">,
    <cfif ARGUMENTS.ftputID EQ 101>
    ftpuDateExp = <cfqueryparam cfsqltype="cf_sql_date" value="#DateAdd('d', 365, Now())#">,
    <cfelseif ARGUMENTS.ftputID EQ 102>
    ftpuDateExp = <cfqueryparam cfsqltype="cf_sql_date" value="#DateAdd('d', application.ftpPowerUserExpirationDay, Now())#">,
    <cfelse>
    ftpuDateExp = <cfqueryparam cfsqltype="cf_sql_date" value="#DateAdd('d', application.ftpUserExpirationDay, Now())#">,
    </cfif>
    ftputID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ftputID#">,
    ftpuStatus = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ftpuStatus#">
    WHERE ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ID#">
    </cfquery>
    </cftransaction>
    <!---Delete any existing relationships.--->
    <cfinvoke 
    component="MCMS.component.app.ftp.Ftp"
    method="deleteFTPUserRel"
    returnvariable="deleteFTPUserRelRet">
    <cfinvokeargument name="ftpuID" value="#ARGUMENTS.ID#"/>
    </cfinvoke>
    <cfinvoke 
    component="MCMS.component.app.ftp.Ftp"
    method="deleteFTPUserDepartmentRel"
    returnvariable="deleteFTPUserDepartmentRelRet">
    <cfinvokeargument name="ftpuID" value="#ARGUMENTS.ID#"/>
    </cfinvoke>
    <!---Insert ftp relationships.--->
	<cfloop index="ftpID" list="#ARGUMENTS.ftpID#">
    <cfinvoke 
    component="MCMS.component.app.ftp.Ftp"
    method="insertFTPUserRel"
    returnvariable="insertFTPUserRelRet">
    <cfinvokeargument name="ftpuID" value="#ARGUMENTS.ID#"/>
    <cfinvokeargument name="ftpID" value="#ftpID#"/>
    <cfinvokeargument name="ftpurStatus" value="1"/>
    </cfinvoke>
    </cfloop>
	<!---Insert department relationships.--->
    <cfloop index="deptNo" list="#ARGUMENTS.deptNo#">
    <cfinvoke 
    component="MCMS.component.app.ftp.Ftp"
    method="insertFTPUserDepartmentRel"
    returnvariable="insertFTPUserDepartmentRelRet">
    <cfinvokeargument name="ftpuID" value="#ARGUMENTS.ID#"/>
    <cfinvokeargument name="deptNo" value="#deptNo#"/>
    <cfinvokeargument name="ftpudrStatus" value="1"/>
    </cfinvoke>
    </cfloop>
    <!---Send email notifications.--->
    <cfinvoke 
    component="MCMS.component.utility.Email"
    method="sendEmail">
    <cfinvokeargument name="subject" value="FTP Registration Updated"/>
    <cfinvokeargument name="to" value="#ARGUMENTS.ftpuEmail#"/>
    <cfinvokeargument name="from" value="#session.userUsername#"/>
    <cfinvokeargument name="ID" value="#ARGUMENTS.ID#"/>
    <cfinvokeargument name="emailTemplate" value="/#application.mcmsAppAdminPath#/ftp/view/inc_ftp_user_update_email_template.cfm"/>
    <cfinvokeargument name="emailType" value="html"/>
    <cfinvokeargument name="type" value="public"/>
    </cfinvoke>
    </cfif>
    <cfcatch type="any">
    <cfset result.message = "There was an error updating the record.">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="updateFTPUserSecurityKeyRel" access="public" returntype="struct">
    <cfargument name="ftpuID" type="numeric" required="yes">
    <cfargument name="ftpuskrKey" type="string" required="yes">
    <cfargument name="ftpuskrKeyValue" type="string" required="yes">
    <cfargument name="ftpuskrStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully inserted the record.">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_ftp_user_sec_key_rel SET
    ftpuskrKey = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.ftpuskrKey#">,
    ftpuskrKeyValue = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.ftpuskrKeyValue#">,
    ftpuskrStatus = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ftpuskrStatus#">
    WHERE ftpuID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ftpuID#">
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error inserting the record.">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="updateFTPUserDepartmentRel" access="public" returntype="struct">
    <cfargument name="ID" type="numeric" required="yes">
    <cfargument name="ftpuID" type="numeric" required="yes">
    <cfargument name="deptNo" type="numeric" required="yes">
    <cfargument name="ftpudrStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully updated the record.">
    <cftry>
    <!---Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.app.ftp.Ftp"
    method="getFTPUserDepartmentRel"
    returnvariable="getCheckFTPUserDepartmentRelRet">
    <cfinvokeargument name="excludeID" value="#ARGUMENTS.ID#"/>
    <cfinvokeargument name="ftpuID" value="#ARGUMENTS.ftpuID#"/>
    <cfinvokeargument name="deptNo" value="#ARGUMENTS.deptNo#"/>
    <cfinvokeargument name="ftpuStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckFTPUserDepartmentRelRet.recordcount NEQ 0>
    <cfset result.message = "The ftp user department relationship already exists, please try again.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_ftp_user_department_rel SET
    ftpuID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ftpuID#">,
    deptNo = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.deptNo#">,
    ftpudrStatus = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ftpudrStatus#">
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
    
    <cffunction name="updateFTPUserType" access="public" returntype="struct">
    <cfargument name="ID" type="numeric" required="yes">
    <cfargument name="ftputName" type="string" required="yes">
    <cfargument name="ftputDescription" type="string" required="yes">
    <cfargument name="ftputStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully updated the record.">
    <cftry>
    <!---Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.app.ftp.Ftp"
    method="getFTPUserType"
    returnvariable="getCheckFTPUserTypeRet">
    <cfinvokeargument name="excludeID" value="#ARGUMENTS.ID#"/>
    <cfinvokeargument name="ftputName" value="#ARGUMENTS.ftputName#"/>
    <cfinvokeargument name="ftputStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckFTPUserTypeRet.recordcount NEQ 0>
    <cfset result.message = "The ftp user type already exists, please try again.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_ftp_user_type SET
    ftputName = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.ftputName#">,
    ftputDescription = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.ftputDescription#">,
    ftputStatus = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ftputStatus#">
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
    
    <cffunction name="updateFTP" access="public" returntype="struct">
    <cfargument name="ID" type="numeric" required="yes">
    <cfargument name="ftpName" type="string" required="yes">
    <cfargument name="ftpDescription" type="string" required="yes">
    <cfargument name="ftpStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully updated the record.">
    <cftry>
    <!---Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.app.ftp.Ftp"
    method="getFTP"
    returnvariable="getCheckFTPRet">
    <cfinvokeargument name="excludeID" value="#ARGUMENTS.ID#"/>
    <cfinvokeargument name="ftpName" value="#ARGUMENTS.ftpName#"/>
    <cfinvokeargument name="ftpStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckFTPRet.recordcount NEQ 0>
    <cfset result.message = "The ftp #ARGUMENTS.ftpName# already exists, please try again.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_ftp SET
    ftpName = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.ftpName#">,
    ftpDescription = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.ftpDescription#">,
    ftpProxy = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.ftpProxy#">,
    ftpPath = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.ftpPath#">,
    netID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.netID#">,
    ftptID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ftptID#">,
    ftpStatus = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ftpStatus#">
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
    
    <cffunction name="updateFTPType" access="public" returntype="struct">
    <cfargument name="ID" type="numeric" required="yes">
    <cfargument name="ftptName" type="string" required="yes">
    <cfargument name="ftptDescription" type="string" required="yes">
    <cfargument name="ftptStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully updated the record.">
    <cftry>
    <!---Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.app.ftp.Ftp"
    method="getFTPType"
    returnvariable="getCheckFTPTypeRet">
    <cfinvokeargument name="excludeID" value="#ARGUMENTS.ID#"/>
    <cfinvokeargument name="ftptName" value="#ARGUMENTS.ftptName#"/>
    <cfinvokeargument name="ftptStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckFTPTypeRet.recordcount NEQ 0>
    <cfset result.message = "The ftp type #ARGUMENTS.ftptName# already exists, please try again.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_ftp_type SET
    ftptName = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.ftptName#">,
    ftptDescription = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.ftptDescription#">,
    ftptStatus = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ftptStatus#">
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
    
    <cffunction name="updateFTPList" access="public" returntype="struct">
    <cfargument name="ID" type="numeric" required="yes">
    <cfargument name="ftpStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully updated the records.">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_ftp SET
    ftpStatus = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ftpStatus#">
    WHERE ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ID#">
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error updating the records.">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="updateFTPUserList" access="public" returntype="struct">
    <cfargument name="ID" type="numeric" required="yes">
    <cfargument name="ftpuStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully updated the records.">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_ftp_user SET
    ftpuStatus = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ftpuStatus#">
    WHERE ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ID#">
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error updating the records.">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="updateFTPUserTypeList" access="public" returntype="struct">
    <cfargument name="ID" type="numeric" required="yes">
    <cfargument name="ftputStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully updated the records.">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_ftp_user_type SET
    ftputStatus = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ftputStatus#">
    WHERE ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ID#">
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error updating the records.">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="updateFTPTypeList" access="public" returntype="struct">
    <cfargument name="ID" type="numeric" required="yes">
    <cfargument name="ftptStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully updated the records.">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_ftp_type SET
    ftptStatus = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ftptStatus#">
    WHERE ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ID#">
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error updating the records.">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="updateFTPFileList" access="public" returntype="struct">
    <cfargument name="ID" type="numeric" required="yes">
    <cfargument name="ftpfStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully updated the records.">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_ftp_file SET
    ftpfStatus = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ftpfStatus#">
    WHERE ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ID#">
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error updating the records.">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="updateFTPFileTypeList" access="public" returntype="struct">
    <cfargument name="ID" type="numeric" required="yes">
    <cfargument name="ftpftStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully updated the records.">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_ftp_file_type SET
    ftpftStatus = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ftpftStatus#">
    WHERE ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ID#">
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error updating the records.">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="updateFTPLogList" access="public" returntype="struct">
    <cfargument name="ID" type="numeric" required="yes">
    <cfargument name="ftplStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully updated the records.">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_ftp_log SET
    ftplStatus = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ftplStatus#">
    WHERE ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ID#">
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error updating the records.">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="deleteFTP" access="public" returntype="struct">
    <cfargument name="ID" type="string" required="yes">
    <cfset result.message = "You have successfully deleted the record(s).">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    DELETE FROM tbl_ftp
    WHERE ID IN (<cfqueryparam cfsqltype="cf_sql_integer" list="yes" value="#ARGUMENTS.ID#">)
    </cfquery>
    </cftransaction>
    <cfinvoke 
    component="MCMS.component.app.ftp.Ftp"
    method="deleteFTPUserRel"
    returnvariable="deleteFTPUserRelRet">
    <cfinvokeargument name="ftpID" value="#ARGUMENTS.ID#"/>
    </cfinvoke>
    <cfinvoke 
    component="MCMS.component.app.ftp.Ftp"
    method="deleteFTPLog"
    returnvariable="deleteFTPLogRet">
    <cfinvokeargument name="ftpID" value="#ARGUMENTS.ID#"/>
    </cfinvoke>
    <cfinvoke 
    component="MCMS.component.app.ftp.Ftp"
    method="deleteFTPFile"
    returnvariable="deleteFTPFileRet">
    <cfinvokeargument name="ftpID" value="#ARGUMENTS.ID#"/>
    </cfinvoke>
    <cfcatch type="any">
    <cfset result.message = "There was an error deleting the record(s).">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="deleteFTPUser" access="public" returntype="struct">
    <cfargument name="ID" type="string" required="yes">
    <cfset result.message = "You have successfully deleted the record(s).">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    DELETE FROM tbl_ftp_user
    WHERE ID IN (<cfqueryparam cfsqltype="cf_sql_integer" list="yes" value="#ARGUMENTS.ID#">)
    </cfquery>
    </cftransaction>
    <cfinvoke 
    component="MCMS.component.app.ftp.Ftp"
    method="deleteFTPUserRel"
    returnvariable="deleteFTPUserRelRet">
    <cfinvokeargument name="ftpuID" value="#ARGUMENTS.ID#"/>
    </cfinvoke>
    <cfinvoke 
    component="MCMS.component.app.ftp.Ftp"
    method="deleteFTPUserDepartmentRel"
    returnvariable="deleteFTPUserDepartmentRelRet">
    <cfinvokeargument name="ftpuID" value="#ARGUMENTS.ID#"/>
    </cfinvoke>
    <cfinvoke 
    component="MCMS.component.app.ftp.Ftp"
    method="deleteFTPLog"
    returnvariable="deleteFTPLogRet">
    <cfinvokeargument name="ftpuID" value="#ARGUMENTS.ID#"/>
    </cfinvoke>
    <cfinvoke 
    component="MCMS.component.app.ftp.Ftp"
    method="deleteFTPFile"
    returnvariable="deleteFTPFileRet">
    <cfinvokeargument name="ftpuID" value="#ARGUMENTS.ID#"/>
    </cfinvoke>
    <cfcatch type="any">
    <cfset result.message = "There was an error deleting the record(s).">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction> 
    
    <cffunction name="deleteFTPUserRel" access="public" returntype="struct">
    <cfargument name="ID" type="string" required="yes" default="0">
    <cfargument name="ftpID" type="string" required="yes" default="0">
    <cfargument name="ftpuID" type="string" required="yes" default="0">
    <cfset result.message = "You have successfully deleted the record(s).">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    DELETE FROM tbl_ftp_user_rel
    WHERE ID IN (<cfqueryparam cfsqltype="cf_sql_integer" list="yes" value="#ARGUMENTS.ID#">)
    OR ftpID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ftpID#">
    OR ftpuID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ftpuID#">
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error deleting the record(s).">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="deleteFTPUserDepartmentRel" access="public" returntype="struct">
    <cfargument name="ID" type="string" required="yes" default="0">
    <cfargument name="ftpuID" type="string" required="yes" default="0">
    <cfargument name="deptNo" type="string" required="yes" default="0">
    <cfset result.message = "You have successfully deleted the record(s).">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    DELETE FROM tbl_ftp_user_department_rel
    WHERE ID IN (<cfqueryparam cfsqltype="cf_sql_integer" list="yes" value="#ARGUMENTS.ID#">)
    OR ftpuID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ftpuID#">
    OR deptNo = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.deptNo#">
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error deleting the record(s).">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="deleteFTPLog" access="public" returntype="struct">
    <cfargument name="ID" type="string" required="yes" default="0">
    <cfargument name="ftpID" type="string" required="yes" default="0">
    <cfargument name="ftpuID" type="string" required="yes" default="0">
    <cfset result.message = "You have successfully deleted the record(s).">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    DELETE FROM tbl_ftp_log
    WHERE ID IN (<cfqueryparam cfsqltype="cf_sql_integer" list="yes" value="#ARGUMENTS.ID#">)
    OR ftpID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ftpID#">
    OR ftpuID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ftpuID#">
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error deleting the record(s).">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="deleteFTPFile" access="public" returntype="struct">
    <cfargument name="ID" type="string" required="yes" default="0">
    <cfargument name="ftpID" type="string" required="yes" default="0">
    <cfargument name="ftpuID" type="string" required="yes" default="0">
    <cfset result.message = "You have successfully deleted the record(s).">
    <cftry>
    <cftransaction>
    <!---First get the file path and name.--->
    <cfinvoke 
    component="MCMS.component.app.ftp.Ftp"
    method="getFTPFile"
    returnvariable="getFTPFileRet">
    <cfinvokeargument name="ID" value="#ARGUMENTS.ID#"/>
    <cfinvokeargument name="ftpfStatus" value="1,2,3"/>
    </cfinvoke>
    <cfquery datasource="#application.mcmsDSN#">
    DELETE FROM tbl_ftp_file
    WHERE ID IN (<cfqueryparam cfsqltype="cf_sql_integer" list="yes" value="#ARGUMENTS.ID#">)
    OR ftpID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ftpID#">
    OR ftpuID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ftpuID#">
    </cfquery>
	<!---Establish the connection.--->
    <cfftp action="open" connection="ftpConn" username="#application.ftpServerUsername#" password="#application.ftpServerPassword#" server="#application.ftpServerIP#" port="#application.ftpServerPort#" stoponerror="yes">
    <!---Get the file(s) to remove.---> 
    <cfloop query="getFTPFileRet">
    <cfftp action="remove" connection="ftpConn" server="#application.ftpServerIP#" port="#application.ftpServerPort#" passive="yes" stoponerror="yes" item="#getFTPFileRet.ftpfPath#/#ftpfFile#">
    </cfloop>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error deleting the record(s).">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="deleteFTPUserType" access="public" returntype="struct">
    <cfargument name="ID" type="string" required="yes" default="0">
    <cfset result.message = "You have successfully deleted the record(s).">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    DELETE FROM tbl_ftp_user_type
    WHERE ID IN (<cfqueryparam cfsqltype="cf_sql_integer" list="yes" value="#ARGUMENTS.ID#">)
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error deleting the record(s).">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="deleteFTPType" access="public" returntype="struct">
    <cfargument name="ID" type="string" required="yes" default="0">
    <cfset result.message = "You have successfully deleted the record(s).">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    DELETE FROM tbl_ftp_type
    WHERE ID IN (<cfqueryparam cfsqltype="cf_sql_integer" list="yes" value="#ARGUMENTS.ID#">)
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error deleting the record(s).">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="deleteFTPFileType" access="public" returntype="struct">
    <cfargument name="ID" type="string" required="yes" default="0">
    <cfset result.message = "You have successfully deleted the record(s).">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    DELETE FROM tbl_ftp_file_type
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