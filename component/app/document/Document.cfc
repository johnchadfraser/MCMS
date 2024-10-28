<cfcomponent>
    <cffunction name="setDocumentTree" access="public" returntype="string" output="yes">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="deptNo" type="string" required="yes" default="0">
    <cfargument name="siteNo" type="string" required="yes" default="100">
    <cfargument name="urID" type="numeric" required="yes" default="100">
	<cfset var documentTree = "">
    <!---Begin building the tree based on query filters to relationships to generate the root department folder.--->
    <cfquery name="rsDocumentRelByDepartment" datasource="#application.mcmsDSN#">
    SELECT DISTINCT deptNo, deptName FROM v_document_rel WHERE 0=0
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(docName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(docDescription) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">)
    </cfif>
    <cfif ARGUMENTS.deptNo NEQ 0>
    AND deptNo IN (<cfqueryparam value="#ARGUMENTS.deptNo#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    AND siteNo IN (<cfqueryparam value="#ARGUMENTS.siteNo#" list="yes" cfsqltype="cf_sql_integer">)
    <cfif ARGUMENTS.urID NEQ 102>
    AND urID IN (<cfqueryparam value="100,#ARGUMENTS.urID#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    AND netID IN (<cfqueryparam value="#application.networkID#" list="yes" cfsqltype="cf_sql_integer">)
    AND docDateRel <= <cfqueryparam value="#Now()#" cfsqltype="cf_sql_date">
    AND docDateExp >= <cfqueryparam value="#Now()#" cfsqltype="cf_sql_date">
    AND docStatus = <cfqueryparam value="1" cfsqltype="cf_sql_integer">
    ORDER BY deptNo
    </cfquery>
    <cfsavecontent variable="documentTree">
    <table id="mainTableAlt">
    <tr>
    <td colspan="2"><h1>Document Results</h1></td>
    </tr>
    </table>
    <cfif rsDocumentRelByDepartment.recordcount EQ 0>
    <div id="mcmsMessage">There are no records.</div>
    <cfelse>
    <!---Create looping variable.--->
    <cfset loop = 0>
    <!---Loop results of main query.--->
    <cfloop query="rsDocumentRelByDepartment">
    <cfset loop = loop+1>
    <!---Query document types and display them by department.--->
    <cfquery name="rsDocumentRelByDocType" datasource="#application.mcmsDSN#">
    SELECT doctName, docName, doctPath, docFile, docDate, userLName, ID, netDomain FROM v_document_rel WHERE 0=0
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(docName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(docDescription) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">)
    </cfif>
    AND deptNo = <cfqueryparam value="#rsDocumentRelByDepartment.deptNo#" cfsqltype="cf_sql_integer">
    AND siteNo IN (<cfqueryparam value="#ARGUMENTS.siteNo#" list="yes" cfsqltype="cf_sql_integer">)
    <cfif application.documentUserRoleList DOES NOT CONTAIN ARGUMENTS.urID>
    AND urID IN (<cfqueryparam value="100,#ARGUMENTS.urID#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    AND netID IN (<cfqueryparam value="#application.networkID#" list="yes" cfsqltype="cf_sql_integer">)
    AND docDateRel <= <cfqueryparam value="#Now()#" cfsqltype="cf_sql_date">
    AND docDateExp >= <cfqueryparam value="#Now()#" cfsqltype="cf_sql_date">
    AND docStatus = <cfqueryparam value="1" cfsqltype="cf_sql_integer">
    GROUP BY doctName, docName, doctPath, docFile, docDate, userLName, ID, netDomain
    ORDER BY doctName
    </cfquery>
    <cfoutput>
    <div id="root#loop#" style="font-weight:bold; padding:5px 0px 10px 0px; cursor:pointer; display:block;" onClick="showHideTree('child#loop#');">-<img id="child#loop#root" src="/MCMS/assets/icon/folder_root_open.gif" alt="folder" name="child#loop#root" hspace="5" border="0" align="absmiddle"  /><cfif deptName EQ "">All Departments<cfelse>#deptName#</cfif> (#rsDocumentRelByDocType.recordcount# Documents)</div>
    </cfoutput>
    <div id="child<cfoutput>#loop#</cfoutput>" style="padding:0px 0px 10px 20px; cursor:pointer; display:block;">
    <cfoutput query="rsDocumentRelByDocType" group="doctName">
    -<span id="#doctName#" style="cursor:pointer;" onClick="showHideTree('#doctName##loop#');"><img id="#doctName##loop#child" name="#doctName##loop#child" src="/MCMS/assets/icon/folder_open.gif" alt="child" hspace="5" border="0" align="absmiddle"/>#doctName#</span>
    <br/>
    <div id="#doctName##loop#" style="display:block;">
    <cfoutput>
    <div id="#docName#" style="padding:0px 0px 5px 50px;">
    <!---Check to see that the file exists in the repository.--->
    <!---Check the existance of the file.---><cfhttp result="checkFileExists" method="GET" charset="utf-8" url="#application.mcmsCDNURL#/#application.mcmsRepositoryDir#/document/#doctPath#/#URLEncodedFormat(docFile)#"></cfhttp> <!---If the file exists then show it.---><cfif checkFileExists.statusCode EQ "200 OK">
    <!---Display the appropriate icon for the file.--->
    <cfif FileExists(ExpandPath('/MCMS/assets/icon/#RIGHT(docFile, 3)#.gif'))>
    <a href="?mcmsFile=/#application.mcmsRepositoryDir#/document/#doctPath#/#docFile#" target="_blank">
    <img src="/MCMS/assets/icon/#RIGHT(docFile, 3)#.gif" alt="child" name="child" hspace="3" border="0" align="absmiddle" id="child" />
    </cfif>
    #docName# 
    <!---Display file size.--->
    <cffile action="read" file="#application.repositoryPath#\document\#doctPath#\#docFile#" variable="myfile" />
     (<cfif len(myfile)/1024 GTE 1000>#NumberFormat(len(myfile)/1024000, '9999.99')#m<cfelse>#Round(len(myfile)/1024)#k</cfif>b)</a> #DateFormat(docDate, application.dateFormat)# / #userLName#
    <cfelse>
    <img src="/MCMS/assets/icon/missing_document.gif" alt="Missing Document" name="docIcon" hspace="3" vspace="0" border=0 align="absmiddle" id="docIcon">#docFile# missing!
    </cfif>
    </div>
    </cfoutput>
    </div>
    </cfoutput>
    </div>
    </cfloop>
    </cfif>
    </cfsavecontent>
    <cfreturn documentTree>
    </cffunction>
    
    <cffunction name="getDocument" access="public" returntype="query" hint="Get Document data.">
    <cfargument name="keywords" type="string" required="no" default="All">
    <cfargument name="ID" type="numeric" required="yes" default="0">
    <cfargument name="excludeID" type="string" required="yes" default="0">
    <cfargument name="userID" type="string" required="yes" default="0">
    <cfargument name="docName" type="string" required="yes" default="">
    <cfargument name="doctID" type="string" required="yes" default="0">
    <cfargument name="netID" type="string" required="yes" default="#application.networkID#">
    <cfargument name="doctStatus" type="string" required="no" default="1">
    <cfargument name="docStatus" type="string" required="yes" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="docName">
    <cfset var rsDocument = "" >
    <cftry>
    <cfquery name="rsDocument" datasource="#application.mcmsDSN#">
    SELECT * FROM v_document WHERE 0=0
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(docName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(docDescription) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(userLName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(userFName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(doctName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">)
    </cfif>
    <cfif ARGUMENTS.ID NEQ 0>
    AND ID = <cfqueryparam value="#ARGUMENTS.ID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.excludeID NEQ 0>
    AND ID NOT IN (<cfqueryparam value="#ARGUMENTS.excludeID#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    <cfif ARGUMENTS.userID NEQ 0>
    AND userID IN (<cfqueryparam value="#ARGUMENTS.userID#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    <cfif ARGUMENTS.docName NEQ "">
    AND UPPER(docName) = <cfqueryparam value="#UCASE(ARGUMENTS.docName)#" cfsqltype="cf_sql_varchar">
    </cfif>
    <cfif ARGUMENTS.doctID NEQ 0>
    AND doctID IN (<cfqueryparam value="#ARGUMENTS.doctID#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    <cfif ARGUMENTS.netID NEQ 0>
    AND netID IN (<cfqueryparam value="#ARGUMENTS.netID#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    AND doctStatus IN (<cfqueryparam value="#ARGUMENTS.doctStatus#" list="yes" cfsqltype="cf_sql_integer">)
    AND docStatus IN (<cfqueryparam value="#ARGUMENTS.docStatus#" list="yes" cfsqltype="cf_sql_integer">)
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsDocument = StructNew()>
    <cfset rsDocument.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsDocument>
    </cffunction>
    
    <cffunction name="getDocumentRel" access="public" returntype="query" hint="Get Document Relationship data.">
    <cfargument name="keywords" type="string" required="no" default="All">
    <cfargument name="ID" type="numeric" required="yes" default="0">
    <cfargument name="excludeID" type="numeric" required="yes" default="0">
    <cfargument name="userID" type="numeric" required="yes" default="0">
    <cfargument name="docName" type="string" required="yes" default="">
    <cfargument name="siteNo" type="string" required="yes" default="0">
    <cfargument name="deptNo" type="string" required="yes" default="0">
    <cfargument name="docDateRel" type="string" required="yes" default="">
    <cfargument name="docDateExp" type="string" required="yes" default="">
    <cfargument name="doctID" type="numeric" required="yes" default="0">
    <cfargument name="docStatus" type="string" required="yes" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="deptNo">
    <cfset var rsDocumentRel = "" >
    <cftry>
    <cfquery name="rsDocumentRel" datasource="#application.mcmsDSN#">
    SELECT * FROM v_document_rel WHERE 0=0
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(docName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(docDescription) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">)
    </cfif>
    <cfif ARGUMENTS.ID NEQ 0>
    AND ID = <cfqueryparam value="#ARGUMENTS.ID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.excludeID NEQ 0>
    AND ID <> <cfqueryparam value="#ARGUMENTS.excludeID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.userID NEQ 0>
    AND userID = <cfqueryparam value="#ARGUMENTS.userID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.docName NEQ "">
    AND UPPER(docName) = <cfqueryparam value="#UCASE(ARGUMENTS.docName)#" cfsqltype="cf_sql_varchar">
    </cfif>
    <cfif ARGUMENTS.siteNo NEQ 100>
    AND siteNo IN (<cfqueryparam value="#ARGUMENTS.siteNo#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    <cfif ARGUMENTS.deptNo NEQ 0>
    AND deptNo IN (<cfqueryparam value="#ARGUMENTS.deptNo#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    <cfif ARGUMENTS.docDateRel NEQ "">
    AND docDateRel <= <cfqueryparam value="#DateFormat(ARGUMENTS.docDateRel, application.dateFormat)#" cfsqltype="cf_sql_date">
    </cfif>
    <cfif ARGUMENTS.docDateExp NEQ "">
    AND docDateExp >= <cfqueryparam value="#DateFormat(ARGUMENTS.docDateExp, application.dateFormat)#" cfsqltype="cf_sql_date">
    </cfif>
    <cfif ARGUMENTS.doctID NEQ 0>
    AND doctID = <cfqueryparam value="#ARGUMENTS.doctID#" cfsqltype="cf_sql_integer">
    </cfif>
    AND docStatus IN (<cfqueryparam value="#ARGUMENTS.docStatus#" list="yes" cfsqltype="cf_sql_integer">)
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsDocumentRel = StructNew()>
    <cfset rsDocumentRel.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsDocumentRel>
    </cffunction>
    
    <cffunction name="getDocumentDepartmentRel" access="public" returntype="query" hint="Get Document By Department Relationship data.">
    <cfargument name="keywords" type="string" required="no" default="All">
    <cfargument name="ID" type="numeric" required="yes" default="0">
    <cfargument name="excludeID" type="numeric" required="yes" default="0">
    <cfargument name="userID" type="numeric" required="yes" default="0">
    <cfargument name="docID" type="numeric" required="yes" default="0">
    <cfargument name="docName" type="string" required="yes" default="">
    <cfargument name="deptNo" type="string" required="yes" default="0">
    <cfargument name="doctID" type="numeric" required="yes" default="0">
    <cfargument name="docStatus" type="string" required="yes" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="deptNo">
    <cfset var rsDocumentDepartmentRel = "" >
    <cftry>
    <cfquery name="rsDocumentDepartmentRel" datasource="#application.mcmsDSN#">
    SELECT * FROM v_document_department_rel WHERE 0=0
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(docName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(docDescription) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">)
    </cfif>
    <cfif ARGUMENTS.ID NEQ 0>
    AND ID = <cfqueryparam value="#ARGUMENTS.ID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.excludeID NEQ 0>
    AND ID <> <cfqueryparam value="#ARGUMENTS.excludeID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.docID NEQ 0>
    AND ID = <cfqueryparam value="#ARGUMENTS.docID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.userID NEQ 0>
    AND userID = <cfqueryparam value="#ARGUMENTS.userID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.docName NEQ "">
    AND UPPER(docName) = <cfqueryparam value="#UCASE(ARGUMENTS.docName)#" cfsqltype="cf_sql_varchar">
    </cfif>
    <cfif ARGUMENTS.deptNo NEQ 0>
    AND deptNo IN (<cfqueryparam value="#ARGUMENTS.deptNo#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    <cfif ARGUMENTS.doctID NEQ 0>
    AND doctID = <cfqueryparam value="#ARGUMENTS.doctID#" cfsqltype="cf_sql_integer">
    </cfif>
    AND docStatus IN (<cfqueryparam value="#ARGUMENTS.docStatus#" list="yes" cfsqltype="cf_sql_integer">)
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsDocumentDepartmentRel = StructNew()>
    <cfset rsDocumentDepartmentRel.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsDocumentDepartmentRel>
    </cffunction>
    
    <cffunction name="getDocumentType" access="public" returntype="query" hint="Get Document Type data.">
    <cfargument name="keywords" type="string" required="no" default="All">
    <cfargument name="ID" type="numeric" required="yes" default="0">
    <cfargument name="excludeID" type="numeric" required="yes" default="0">
    <cfargument name="doctName" type="string" required="yes" default="">
    <cfargument name="doctStatus" type="string" required="yes" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="doctName">
    <cfset var rsDocumentType = "" >
    <cftry>
    <cfquery name="rsDocumentType" datasource="#application.mcmsDSN#">
    SELECT * FROM tbl_document_type WHERE 0=0
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND UPPER(doctName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">
    </cfif>
    <cfif ARGUMENTS.ID NEQ 0>
    AND ID = <cfqueryparam value="#ARGUMENTS.ID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.excludeID NEQ 0>
    AND ID <> <cfqueryparam value="#ARGUMENTS.excludeID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.doctName NEQ "">
    AND UPPER(doctName) = <cfqueryparam value="#UCASE(ARGUMENTS.doctName)#" cfsqltype="cf_sql_varchar">
    </cfif>
    AND doctStatus IN (<cfqueryparam value="#ARGUMENTS.doctStatus#" list="yes" cfsqltype="cf_sql_integer">)
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsDocumentType = StructNew()>
    <cfset rsDocumentType.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsDocumentType>
    </cffunction>
    
    <cffunction name="getDocumentReport" access="public" returntype="query" hint="Get Document Report data.">
    <cfargument name="keywords" type="string" required="no" default="All">
    <cfargument name="siteNo" type="string" required="no" default="100">
    <cfargument name="deptNo" type="string" required="no" default="0">
    <cfargument name="args" type="string" required="no" default="0">
    <cfargument name="orderBy" type="string" required="yes" default="docName">
	<cfset var rsDocumentReport = "" >
    <cftry>
    <cfquery name="rsDocumentReport" datasource="#application.mcmsDSN#">
    SELECT docName AS Name, TO_CHAR(docDescription) AS Description, docFile AS Document_File, doctName AS Type, 
    docStatus AS Status FROM v_document 
    WHERE 0=0
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(docName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(doctName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(docDescription) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">)
    </cfif>
    <cfif ListGetAt(ARGUMENTS.args, 1) NEQ 0>
    AND userID IN (<cfqueryparam value="#ListGetAt(ARGUMENTS.args, 1)#" list="yes" separator="|" cfsqltype="cf_sql_integer">)
    </cfif>
    AND netID IN (<cfqueryparam value="#application.networkID#" list="yes" cfsqltype="cf_sql_integer">)
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsDocumentReport = StructNew()>
    <cfset rsDocumentReport.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsDocumentReport>
    </cffunction>
    
    <cffunction name="getDocumentTypeReport" access="public" returntype="query" hint="Get Document Type data.">
    <cfargument name="keywords" type="string" required="no" default="All">
    <cfargument name="orderBy" type="string" required="yes" default="doctName">
	<cfset var rsDocumentTypeReport = "" >
    <cftry>
    <cfquery name="rsDocumentTypeReport" datasource="#application.mcmsDSN#">
    SELECT doctName AS Name, doctPath AS Path, doctStatus AS Status FROM tbl_document_type 
    WHERE 0=0
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND UPPER(doctName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">
    </cfif>
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsDocumentTypeReport = StructNew()>
    <cfset rsDocumentTypeReport.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsDocumentTypeReport>
    </cffunction>
    
    <cffunction name="getDocumentSiteRel" access="public" returntype="query" hint="Get Document Site Relationship data.">
    <cfargument name="keywords" type="string" required="no" default="All">
    <cfargument name="ID" type="numeric" required="yes" default="0">
    <cfargument name="docID" type="numeric" required="yes" default="0">
    <cfargument name="siteNo" type="string" required="yes" default="100">
    <cfargument name="dsrStatus" type="string" required="yes" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="siteNo">
	<cfset var rsDocumentSiteRel = "" >
    <cftry>
    <cfquery name="rsDocumentSiteRel" datasource="#application.mcmsDSN#">
    SELECT * FROM tbl_document_site_rel WHERE 0=0
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND siteNo LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> 
    </cfif>
    <cfif ARGUMENTS.ID NEQ 0>
    AND ID = <cfqueryparam value="#ARGUMENTS.ID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.docID NEQ 0>
    AND docID = <cfqueryparam value="#ARGUMENTS.docID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.siteNo NEQ 100>
    AND siteNo IN (<cfqueryparam value="#ARGUMENTS.siteNo#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    AND dsrStatus IN (<cfqueryparam value="#ARGUMENTS.dsrStatus#" list="yes" cfsqltype="cf_sql_integer">)
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsDocumentSiteRel = StructNew()>
    <cfset rsDocumentSiteRel.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsDocumentSiteRel>
    </cffunction>
    
    
    
    <cffunction name="getDocumentUserRoleRel" access="public" returntype="query" hint="Get Document User Role Relationship data.">
    <cfargument name="keywords" type="string" required="no" default="All">
    <cfargument name="ID" type="numeric" required="yes" default="0">
    <cfargument name="docID" type="numeric" required="yes" default="0">
    <cfargument name="urID" type="numeric" required="yes" default="0">
    <cfargument name="ddrStatus" type="string" required="yes" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="urID">
	<cfset var rsDocumentUserRoleRel = "" >
    <cftry>
    <cfquery name="rsDocumentUserRoleRel" datasource="#application.mcmsDSN#">
    SELECT * FROM tbl_document_user_role_rel WHERE 0=0
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND urID LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> 
    </cfif>
    <cfif ARGUMENTS.ID NEQ 0>
    AND ID = <cfqueryparam value="#ARGUMENTS.ID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.docID NEQ 0>
    AND docID = <cfqueryparam value="#ARGUMENTS.docID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.urID NEQ 0>
    AND urID = <cfqueryparam value="#ARGUMENTS.urID#" cfsqltype="cf_sql_integer">
    </cfif>
    AND durStatus IN (<cfqueryparam value="#ARGUMENTS.durStatus#" list="yes" cfsqltype="cf_sql_integer">)
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsDocumentUserRoleRel = StructNew()>
    <cfset rsDocumentUserRoleRel.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsDocumentUserRoleRel>
    </cffunction>
    
    <cffunction name="insertDocument" access="public" returntype="struct">
    <cfargument name="docName" type="string" required="yes">
    <cfargument name="docFile" type="string" required="yes">
    <cfargument name="docDateRel" type="string" required="yes">
    <cfargument name="docDateExp" type="string" required="yes">
    <cfargument name="userID" type="numeric" required="yes">
    <cfargument name="doctID" type="numeric" required="yes">
    <cfargument name="netID" type="numeric" default="#application.networkID#">
    <cfargument name="docSort" type="numeric" required="yes">
    <cfargument name="docStatus" type="numeric" required="yes" default="1">
    <!---Email arguments.--->
    <cfargument name="emailNotify" type="string" required="yes">
	<!---Relationship arguments.--->
    <cfargument name="siteNo" type="string" required="yes">
    <cfargument name="deptNo" type="string" required="yes">
    <cfargument name="urID" type="string" required="yes">
    <cfset result.message = "You have successfully inserted the record.">
    <!---Check for profanity in the text.--->
    <cfinvoke 
    component="MCMS.component.utility.Regex"
    method="regexProfanity"
    returnvariable="regexProfanityRet">
    <cfinvokeargument name="profanityString" value="#ARGUMENTS.docName#"/>
    </cfinvoke>
    <!---Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.app.document.Document"
    method="getDocument"
    returnvariable="getCheckDocumentRet">
    <cfinvokeargument name="docName" value="#ARGUMENTS.docName#"/>
    <cfinvokeargument name="docStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckDocumentRet.Recordcount NEQ 0>
    <cfset result.message = "The name #ARGUMENTS.docName# already exists, please enter a new name.">
    <cfelseif regexProfanityRet CONTAINS '$%&*!'>
    <cfset result.message = "Some text contained profanity, please remove any profanity from your text.">
    <cfelse>
    <!---Upload the file.--->
    <!---First get the doctPath.--->
    <cfinvoke 
    component="MCMS.component.app.document.Document"
    method="getDocumentType"
    returnvariable="getDocumentTypePathRet">
    <cfinvokeargument name="ID" value="#ARGUMENTS.doctID#"/>
    <cfinvokeargument name="doctStatus" value="1,3"/>
    </cfinvoke>
    
    <cfset this.doctPath = getDocumentTypePathRet.doctPath>
    
    <!---Determine the CDN server by DEV/TEST or PROD.--->
    
    <cfif application.mcmsServerEnv EQ 'DEV' OR application.mcmsServerEnv EQ 'TEST'>
    <!---CDN DEV Upload Settings.--->
    <!---Contruct the path for the document to uploaded.--->
    <cfset this.documentPath = '#application.mcmsCDNRepositoryUNCPathDEV#\document\#this.doctPath#'>
    <!---Check to see the directory excists.--->
    <cfif NOT DirectoryExists(this.documentPath)>
    <cfdirectory action="create" directory="#this.documentPath#">
    </cfif>
    </cfif>
    
    <cfif application.mcmsServerEnv EQ 'PROD'>
    <!---CDN PROD Upload Settings.--->
    <!---Contruct the path for the image to be resized and uploaded.--->
    <cfset this.documentPath = '#application.mcmsCDNRepositoryUNCPathPROD#\document\#this.doctPath#'>
	<!---Check to see the directory excists.--->
    <cfif NOT DirectoryExists(this.documentPath)>
    <cfdirectory action="create" directory="#this.documentPath#">
    </cfif>
    </cfif>
    
    <cftry>
    <cffile action="upload" accept="#application.documentMIME#" destination="#this.documentPath#" nameConflict="makeunique" fileField="form.docFile">
    <!--- Create the variable for insert of file name and file type --->
    <cfset this.fileName = CFFILE.ServerFileName & '.' & CFFILE.ServerFileExt>
    <cfcatch type="any">
    <cfset uploadFailed = "An error occured while uploading your file, only common file types permitted. Types permitted include, Microsoft Word, Excel, Visio, PowerPoint, Zip, Text and PDF.">
    <cfset result.message = uploadFailed>
    </cfcatch>
    </cftry>
    <cfif NOT IsDefined("uploadFailed")>
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    INSERT INTO tbl_document (docName,docDescription,docFile,docDateRel,docDateExp,userID,doctID,netID,docSort,docStatus) VALUES
    (
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.docName#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.docName#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#this.fileName#">,
    <cfqueryparam cfsqltype="cf_sql_date" value="#ARGUMENTS.docDateRel#">,
    <cfqueryparam cfsqltype="cf_sql_date" value="#ARGUMENTS.docDateExp#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.userID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.doctID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.netID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.docSort#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.docStatus#">
    )
    </cfquery>
    </cftransaction>
    <!---Get the docID just added.--->
    <cfinvoke 
    component="MCMS.component.app.document.Document"
    method="getDocument"
    returnvariable="getDocumentIDRet">
    <cfinvokeargument name="docName" value="#ARGUMENTS.docName#"/>
    <cfinvokeargument name="userID" value="#ARGUMENTS.userID#"/>
    <cfinvokeargument name="docStatus" value="1,2,3"/>
    </cfinvoke>
    <cfset this.docID = getDocumentIDRet.ID>
    <!---Create site relationships.--->
    <cfloop index="siteNo" list="#ARGUMENTS.siteNo#">
    <cfinvoke 
    component="MCMS.component.app.document.Document"
    method="insertDocumentSiteRel"
    returnvariable="insertDocumentSiteRelRet">
    <cfinvokeargument name="docID" value="#this.docID#"/>
    <cfinvokeargument name="siteNo" value="#siteNo#"/>
    <cfinvokeargument name="dsrStatus" value="1"/>
    </cfinvoke>
    </cfloop>
    <!---Create department relationships.--->
    <cfloop index="deptNo" list="#ARGUMENTS.deptNo#">
    <cfinvoke 
    component="MCMS.component.app.document.Document"
    method="insertDocumentDepartmentRel"
    returnvariable="insertDocumentDepartmentRelRet">
    <cfinvokeargument name="docID" value="#this.docID#"/>
    <cfinvokeargument name="deptNo" value="#deptNo#"/>
    <cfinvokeargument name="ddrStatus" value="1"/>
    </cfinvoke>
    </cfloop>
    <!---Create user role relationships.--->
    <cfloop index="urID" list="#ARGUMENTS.urID#">
    <cfinvoke 
    component="MCMS.component.app.document.Document"
    method="insertDocumentUserRoleRel"
    returnvariable="insertDocumentUserRoleRelRet">
    <cfinvokeargument name="docID" value="#this.docID#"/>
    <cfinvokeargument name="urID" value="#urID#"/>
    <cfinvokeargument name="durStatus" value="1"/>
    </cfinvoke>
    </cfloop>
    <cfcatch type="any">
    <cfset result.message = "There was an error inserting the record.">
    <cfif url.mcmsDebug EQ true>
    <cfdump var="#CFCATCH#">
    </cfif>
    </cfcatch>
    </cftry>
    </cfif>
    </cfif>
    <!---Get a list of users based on roles to inform them of a document being added.--->
    <cfif ARGUMENTS.urID NEQ 100 AND ARGUMENTS.emailNotify EQ 'true'> 
    <cfinvoke 
    component="MCMS.component.app.user.User"
    method="getUser"
    returnvariable="getUserRet">
    <cfinvokeargument name="urID" value="#ARGUMENTS.urID#"/>
    <cfinvokeargument name="userStatus" value="1"/>
    </cfinvoke>
    <cfset this.emailContent =
	"A document named <a href='http://#CGI.HTTP_HOST#/#application.mcmsRepositoryDir#/document/#this.doctPath#/#this.fileName#'>#ARGUMENTS.docName#</a> has been added to the Document Center by #session.userName# and this email has been sent to notify you based on your user role."
	>
    <cfloop query="getUserRet" startrow="1" endrow="#getUserRet.RecordCount#">
    <cfinvoke 
    component="MCMS.component.utility.Email"
    method="sendEmail">
    <cfinvokeargument name="subject" value="#ARGUMENTS.docName# has been added to the Document Center."/>
    <cfinvokeargument name="to" value="#getUserRet.userEmail#"/>
    <cfinvokeargument name="from" value="#session.userUsername#"/>
    <cfinvokeargument name="body" value="#this.emailContent#"/>
    <cfinvokeargument name="emailType" value="html"/>
    <cfinvokeargument name="type" value="admin"/>
    </cfinvoke>
    </cfloop>
    </cfif>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="insertDocumentType" access="public" returntype="struct">
    <cfargument name="doctName" type="string" required="yes">
    <cfargument name="doctPath" type="string" required="yes">
    <cfargument name="doctStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully inserted the record.">
    <cftry>
    <!---Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.app.document.Document"
    method="getDocumentType"
    returnvariable="getCheckDocumentTypeRet">
    <cfinvokeargument name="doctName" value="#ARGUMENTS.doctName#"/>
    <cfinvokeargument name="doctStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckDocumentTypeRet.recordcount NEQ 0>
    <cfset result.message = "The name #ARGUMENTS.doctName# already exists, please enter a new name.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    INSERT INTO tbl_document_type (doctName,doctPath,doctStatus) VALUES
    (
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.doctName#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.doctPath#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.doctStatus#">
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
    
    <cffunction name="insertDocumentSiteRel" access="public" returntype="struct">
    <cfargument name="docID" type="numeric" required="yes">
    <cfargument name="siteNo" type="numeric" required="yes">
    <cfargument name="dsrStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully inserted the record.">
    <cftry>
	<!---Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.app.document.Document"
    method="getDocumentSiteRel"
    returnvariable="getCheckDocumentSiteRelRet">
    <cfinvokeargument name="docID" value="#ARGUMENTS.docID#"/>
    <cfinvokeargument name="siteNo" value="#ARGUMENTS.siteNo#"/>
    <cfinvokeargument name="dsrStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckDocumentSiteRelRet.recordcount NEQ 0>
    <cfset result.message = "The document site relationship already exists, please try again.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    INSERT INTO tbl_document_site_rel (docID,siteNo,dsrStatus) VALUES
    (
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.docID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.siteNo#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.dsrStatus#">
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
    
    <cffunction name="insertDocumentDepartmentRel" access="public" returntype="struct">
    <cfargument name="docID" type="numeric" required="yes">
    <cfargument name="deptNo" type="numeric" required="yes">
    <cfargument name="ddrStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully inserted the record.">
    <cftry>
	<!---Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.app.document.Document"
    method="getDocumentDepartmentRel"
    returnvariable="getCheckDocumentDepartmentRelRet">
    <cfinvokeargument name="docID" value="#ARGUMENTS.docID#"/>
    <cfinvokeargument name="deptNo" value="#ARGUMENTS.deptNo#"/>
    <cfinvokeargument name="ddrStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckDocumentDepartmentRelRet.recordcount NEQ 0>
    <cfset result.message = "The document department relationship already exists, please try again.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    INSERT INTO tbl_document_department_rel (docID,deptNo,ddrStatus) VALUES
    (
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.docID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.deptNo#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ddrStatus#">
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
    
    <cffunction name="insertDocumentUserRoleRel" access="public" returntype="struct">
    <cfargument name="docID" type="numeric" required="yes">
    <cfargument name="urID" type="numeric" required="yes">
    <cfargument name="durStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully inserted the record.">
    <cftry>
	<!---Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.app.document.Document"
    method="getDocumentUserRoleRel"
    returnvariable="getCheckDocumentUserRoleRelRet">
    <cfinvokeargument name="docID" value="#ARGUMENTS.docID#"/>
    <cfinvokeargument name="urID" value="#ARGUMENTS.urID#"/>
    <cfinvokeargument name="durStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckDocumentUserRoleRelRet.recordcount NEQ 0>
    <cfset result.message = "The document user role relationship already exists, please try again.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    INSERT INTO tbl_document_user_role_rel (docID,urID,durStatus) VALUES
    (
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.docID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.urID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.durStatus#">
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
    
    <cffunction name="updateDocument" access="public" returntype="struct">
    <cfargument name="ID" type="numeric" required="yes">
    <cfargument name="uaID" type="numeric" required="yes">
    <cfargument name="docName" type="string" required="yes">
    <cfargument name="docDescription" type="string" required="yes">
    <cfargument name="docFile" type="string" required="yes">
    <cfargument name="tempDocFile" type="string" required="yes">
    <cfargument name="docDateRel" type="string" required="yes">
    <cfargument name="docDateExp" type="string" required="yes">
    <cfargument name="userID" type="numeric" required="yes">
    <cfargument name="doctID" type="numeric" required="yes">
    <cfargument name="tempDoctID" type="numeric" required="yes">
    <cfargument name="docSort" type="numeric" required="yes">
    <cfargument name="docStatus" type="numeric" required="yes">
    <!---Email arguments.--->
    <cfargument name="emailNotify" type="string" required="yes">
    <!---Relationship arguments.--->
    <cfargument name="urID" type="string" required="yes">
    <cfargument name="siteNo" type="string" required="yes">
    <cfargument name="deptNo" type="string" required="yes">
    <cfset result.message = "You have successfully updated the record.">
	<cftry>
    <!---Check for profanity in the text.--->
    <cfinvoke 
    component="MCMS.component.utility.Regex"
    method="regexProfanity"
    returnvariable="regexProfanityRet">
    <cfinvokeargument name="profanityString" value="#ARGUMENTS.docDescription#"/>
    </cfinvoke>
    <!---Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.app.document.Document"
    method="getDocument"
    returnvariable="getCheckDocumentRet">
    <cfinvokeargument name="excludeID" value="#ARGUMENTS.ID#"/>
    <cfinvokeargument name="docName" value="#ARGUMENTS.docName#"/>
    <cfinvokeargument name="docStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckDocumentRet.recordcount NEQ 0>
    <cfset result.message = "The name #ARGUMENTS.docName# already exists, please enter a new name.">
    <cfelseif regexProfanityRet CONTAINS '$%&*!'>
    <cfset result.message = "Some text contained profanity, please remove any profanity from your text.">
    <!---Check length restriction.--->
    <cfelseif LEN(ARGUMENTS.docDescription) GT 1024>
    <cfset result.message = "The description is longer than 1024 characters, please enter a new name under 1024 characters.">
    <cfelse>
    <!---Upload the file if one was uploaded.--->
    <cfset this.fileName = ARGUMENTS.tempDocFile>
    <cfif ARGUMENTS.docFile NEQ "" OR ARGUMENTS.doctID NEQ ARGUMENTS.tempDoctID>
    <!---First get the doctPath.--->
    <cfinvoke 
    component="MCMS.component.app.document.Document"
    method="getDocumentType"
    returnvariable="getDocumentTypePathRet">
    <cfinvokeargument name="ID" value="#ARGUMENTS.doctID#"/>
    <cfinvokeargument name="doctStatus" value="1,3"/>
    </cfinvoke>
    <cfset this.doctPath = getDocumentTypePathRet.doctPath>
    <!---Contruct the path for the document to be uploaded.--->
    <cfset documentPath = '#application.repositoryPath#\document\#this.doctPath#'>
	<!---Check to see the directory excists.--->
    <cfif NOT DirectoryExists(documentPath)>
    <cfdirectory action="create" directory="#documentPath#">
    </cfif>
    <cfif ARGUMENTS.doctID NEQ ARGUMENTS.tempDoctID AND this.fileName EQ ARGUMENTS.tempDocFile>
    <cftry>
    <!---First get the doctPath.--->
    <cfinvoke 
    component="MCMS.component.app.document.Document"
    method="getDocumentType"
    returnvariable="getDocumentTypePathRet">
    <cfinvokeargument name="ID" value="#ARGUMENTS.tempDoctID#"/>
    <cfinvokeargument name="doctStatus" value="1,3"/>
    </cfinvoke>
    <cfset this.tempDoctPath = getDocumentTypePathRet.doctPath>
    <!---Contruct the path for the document to be uploaded.--->
    <cfset tempDocumentPath = '#application.repositoryPath#\document\#this.tempDoctPath#'>
    <cffile action="move" destination="#documentPath#\" source="#tempDocumentPath#\#this.fileName#">
    <cfcatch type="any">
    <cfset uploadFailed = "An error occured while moving your file.">
    <cfset result.message = uploadFailed>
    </cfcatch>
    </cftry>
    </cfif>
    <cfif ARGUMENTS.docFile NEQ "">
    <cftry>
    <cffile action="upload" accept="#application.documentMIME#" destination="#documentPath#" nameConflict="makeunique" fileField="form.docFile">
    <!--- Create the variable for insert of file name and file type --->
    <cfset this.fileName = CFFILE.ServerFileName & '.' & CFFILE.ServerFileExt>
    <cfcatch type="any">
    <cfset uploadFailed = "An error occured while uploading your file, only common file types permitted. Types permitted include, Microsoft Word, Excel, Visio, PowerPoint, Zip, Text and PDF.">
    <cfset result.message = uploadFailed>
    </cfcatch>
    </cftry>
    </cfif>
    </cfif>
    <cfif NOT IsDefined("uploadFailed")>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_document SET
    docName = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.docName#">,
    docDescription = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.docDescription#">,
    docFile = <cfqueryparam cfsqltype="cf_sql_varchar" value="#this.fileName#">,
    docDateRel = <cfqueryparam cfsqltype="cf_sql_date" value="#ARGUMENTS.docDateRel#">,
    docDateExp = <cfqueryparam cfsqltype="cf_sql_date" value="#ARGUMENTS.docDateExp#">,
    doctID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.doctID#">,
    docSort = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.docSort#">,
	<cfif ARGUMENTS.uaID NEQ 101>
    docDateUpdate = <cfqueryparam cfsqltype="cf_sql_timestamp" value="#Now()#">,
    </cfif>
    userID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.userID#">,
    docStatus = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.docStatus#">
    WHERE ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ID#">
    </cfquery>
    </cftransaction>
    <!---Delete any existing relationships.--->
    <cfinvoke 
    component="MCMS.component.app.document.Document"
    method="deleteDocumentUserRoleRel"
    returnvariable="deleteDocumentUserRoleRelRet">
    <cfinvokeargument name="docID" value="#ARGUMENTS.ID#"/>
    </cfinvoke>
    <cfinvoke 
    component="MCMS.component.app.document.Document"
    method="deleteDocumentSiteRel"
    returnvariable="deleteDocumentSiteRelRet">
    <cfinvokeargument name="docID" value="#ARGUMENTS.ID#"/>
    </cfinvoke>
    <cfinvoke 
    component="MCMS.component.app.document.Document"
    method="deleteDocumentDepartmentRel"
    returnvariable="deleteDocumentDepartmentRelRet">
    <cfinvokeargument name="docID" value="#ARGUMENTS.ID#"/>
    </cfinvoke>
    <cfinvoke 
    component="MCMS.component.app.page_viewer.PageViewer"
    method="deletePageViewerPage"
    returnvariable="deletePageViewerPageRet">
    <cfinvokeargument name="docID" value="#ARGUMENTS.ID#"/>
    </cfinvoke>
    <!---Upload Page Viewer files if applicable and the file is PDF format.--->
    <cfif ARGUMENTS.docFile NEQ "">
    <cfif application.pageViewerDocumentType CONTAINS ARGUMENTS.doctID AND CFFILE.ServerFileExt EQ "pdf">
    <cfinvoke 
    component="MCMS.component.app.page_viewer.PageViewer"
    method="insertPageViewerPage"
    returnvariable="insertPageViewerPageRet">
    <cfinvokeargument name="docID" value="#ARGUMENTS.ID#"/>
    </cfinvoke>
    </cfif>
    </cfif>
    <!---Create site relationships.--->
    <cfloop index="siteNo" list="#ARGUMENTS.siteNo#">
    <cfinvoke 
    component="MCMS.component.app.document.Document"
    method="insertDocumentSiteRel"
    returnvariable="insertDocumentSiteRelRet">
    <cfinvokeargument name="docID" value="#ARGUMENTS.ID#"/>
    <cfinvokeargument name="siteNo" value="#siteNo#"/>
    <cfinvokeargument name="dsrStatus" value="1"/>
    </cfinvoke>
    </cfloop>
    <!---Create department relationships.--->
    <cfloop index="deptNo" list="#ARGUMENTS.deptNo#">
    <cfinvoke 
    component="MCMS.component.app.document.Document"
    method="insertDocumentDepartmentRel"
    returnvariable="insertDocumentDepartmentRelRet">
    <cfinvokeargument name="docID" value="#ARGUMENTS.ID#"/>
    <cfinvokeargument name="deptNo" value="#deptNo#"/>
    <cfinvokeargument name="ddrStatus" value="1"/>
    </cfinvoke>
    </cfloop>
    <!---Create user role relationships.--->
    <cfloop index="urID" list="#ARGUMENTS.urID#">
    <cfinvoke 
    component="MCMS.component.app.document.Document"
    method="insertDocumentUserRoleRel"
    returnvariable="insertDocumentUserRoleRelRet">
    <cfinvokeargument name="docID" value="#ARGUMENTS.ID#"/>
    <cfinvokeargument name="urID" value="#urID#"/>
    <cfinvokeargument name="durStatus" value="1"/>
    </cfinvoke>
    </cfloop>
    </cfif>
    </cfif>
    <!---Get a list of users based on roles to inform them of a document being added.--->
    <cfif ARGUMENTS.urID NEQ 100 AND ARGUMENTS.emailNotify EQ 'true'> 
    <cfinvoke 
    component="MCMS.component.cms.User"
    method="getUserSiteRel"
    returnvariable="getUserSiteRelRet">
    <cfinvokeargument name="urID" value="#ARGUMENTS.urID#"/>
    <cfinvokeargument name="siteNo" value="#ARGUMENTS.siteNo#"/>
    <cfinvokeargument name="usrStatus" value="1"/>
    </cfinvoke>
    <cfset this.emailContent =
	"A document named <a href='http://#CGI.HTTP_HOST#/#application.mcmsRepositoryDir#/document/#this.doctPath#/#this.fileName#'>#ARGUMENTS.docName#</a> has been updated in the Document Center by #session.userName# and this email has been sent to notify you based on your user role."
	>
    <cfloop query="getUserSiteRelRet" startrow="1" endrow="#getUserSiteRelRet.recordcount#">
    <cfinvoke 
    component="MCMS.component.utility.Utility.Email"
    method="sendEmail">
    <cfinvokeargument name="subject" value="#ARGUMENTS.docName# has been added to the Document Center."/>
    <cfinvokeargument name="to" value="#getUserSiteRelRet.userEmail#"/>
    <cfinvokeargument name="from" value="#session.userUsername#"/>
    <cfinvokeargument name="body" value="#this.emailContent#"/>
    <cfinvokeargument name="emailType" value="html"/>
    <cfinvokeargument name="type" value="admin"/>
    </cfinvoke>
    </cfloop>
    </cfif>
    <cfcatch type="any">
    <cfset result.message = "There was an error updating the record.">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="updateDocumentType" access="public" returntype="struct">
    <cfargument name="ID" type="numeric" required="yes">
    <cfargument name="doctName" type="string" required="yes">
    <cfargument name="doctPath" type="string" required="yes">
    <cfargument name="doctStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully updated the record.">
    <cftry>
    <!---Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.app.document.Document"
    method="getDocumentType"
    returnvariable="getCheckDocumentTypeRet">
    <cfinvokeargument name="excludeID" value="#ARGUMENTS.ID#"/>
    <cfinvokeargument name="doctName" value="#ARGUMENTS.doctName#"/>
    <cfinvokeargument name="doctStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckDocumentTypeRet.recordcount NEQ 0>
    <cfset result.message = "The name #ARGUMENTS.doctName# already exists, please enter a new name.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_document_type SET
    doctName = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.doctName#">,
    doctPath = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.doctPath#">,
    doctStatus = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.doctStatus#">
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
    
    <cffunction name="updateDocumentUser" access="public" returntype="struct">
    <cfargument name="currentUserID" type="numeric" required="yes">
    <cfargument name="deptNo" type="numeric" required="yes">
    <cfargument name="newUserID" type="numeric" required="yes">
    <cfset result.message = "You have successfully updated the record(s).">
    <cftry>
    <!---Get documents by department and user.--->
    <cfinvoke 
    component="MCMS.component.app.document.Document"
    method="getDocumentRel"
    returnvariable="getDocumentRelRet">
    <cfinvokeargument name="userID" value="#ARGUMENTS.currentUserID#"/>
    <cfinvokeargument name="deptNo" value="#ARGUMENTS.deptNo#"/>
    <cfinvokeargument name="docStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getDocumentRelRet.recordcount NEQ 0>
    <cfset docList = ValueList(getDocumentRelRet.ID)>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_document SET
    userID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.newUserID#">
    WHERE ID IN (<cfqueryparam cfsqltype="cf_sql_integer" list="yes" value="#docList#">)
    </cfquery>
    </cftransaction>
    </cfif>
    <cfcatch type="any">
    <cfset result.message = "There was an error updating the record.">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="insertDocumentUserRoleRelByUser" access="public" returntype="struct">
    <cfargument name="userID" type="numeric" required="yes">
    <cfargument name="urID" type="string" required="yes">
    <cfset result.message = "You have successfully updated the record(s).">
    <cftry>
    <cfinvoke 
    component="MCMS.component.app.document.Document"
    method="getDocument"
    returnvariable="getDocumentRet">
    <cfinvokeargument name="userID" value="#ARGUMENTS.userID#"/>
    <cfinvokeargument name="docStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getDocumentRet.recordcount NEQ 0>
    <cfset docIDList = ValueList(getDocumentRet.ID)>
    <cfelse>
    <cfset docIDList = 0>
    </cfif>
    <cfif docIDList NEQ 0>
    <!---Create user role relationships.--->
    <cfloop index="docID" list="#docIDList#">
    <cfinvoke 
    component="MCMS.component.app.document.Document"
    method="insertDocumentUserRoleRel"
    returnvariable="insertDocumentUserRoleRelRet">
    <cfinvokeargument name="docID" value="#docID#"/>
    <cfinvokeargument name="urID" value="#ARGUMENTS.urID#"/>
    <cfinvokeargument name="durStatus" value="1"/>
    </cfinvoke>
    </cfloop>    
    </cfif>
    <cfcatch type="any">
    <cfset result.message = "There was an error inserting the record(s).">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="updateDocumentList" access="public" returntype="struct">
    <cfargument name="ID" type="numeric" required="yes">
    <cfargument name="docStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully updated the records.">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_document SET
    docStatus = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.docStatus#">
    WHERE ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ID#">
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error updating the records.">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="updateDocumentTypeList" access="public" returntype="struct">
    <cfargument name="ID" type="numeric" required="yes">
    <cfargument name="doctStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully updated the records.">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_document_type SET
    doctStatus = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.doctStatus#">
    WHERE ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ID#">
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error updating the records.">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="deleteDocument" access="public" returntype="struct">
    <cfargument name="ID" type="string" required="yes">
    <cfset result.message = "You have successfully deleted the record(s).">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    DELETE FROM tbl_document
    WHERE ID IN (<cfqueryparam cfsqltype="cf_sql_integer" list="yes" value="#ARGUMENTS.ID#">)
    </cfquery>
    </cftransaction>
    <!---Delete relationships.--->
    <cfinvoke 
    component="MCMS.component.app.document.Document"
    method="deleteDocumentUserRoleRel"
    returnvariable="deleteDocumentUserRoleRelRet">
    <cfinvokeargument name="docID" value="#ARGUMENTS.ID#"/>
    </cfinvoke>
    <cfinvoke 
    component="MCMS.component.app.document.Document"
    method="deleteDocumentSiteRel"
    returnvariable="deleteDocumentSiteRelRet">
    <cfinvokeargument name="docID" value="#ARGUMENTS.ID#"/>
    </cfinvoke>
    <cfinvoke 
    component="MCMS.component.app.document.Document"
    method="deleteDocumentDepartmentRel"
    returnvariable="deleteDocumentDepartmentRelRet">
    <cfinvokeargument name="docID" value="#ARGUMENTS.ID#"/>
    </cfinvoke>
    <!---Delete Event Relationship documents.--->
    <cfquery datasource="#application.mcmsDSN#">
    DELETE FROM tbl_event_document_rel
    WHERE docID IN (<cfqueryparam cfsqltype="cf_sql_integer" list="yes" value="#ARGUMENTS.ID#">)
    </cfquery>
    <!---Delete News Relationship documents.--->
    <cfquery datasource="#application.mcmsDSN#">
    DELETE FROM tbl_news_document_rel
    WHERE docID IN (<cfqueryparam cfsqltype="cf_sql_integer" list="yes" value="#ARGUMENTS.ID#">)
    </cfquery>
    <!---Delete Page Viewer Pages.--->
    <cfquery datasource="#application.mcmsDSN#">
    DELETE FROM tbl_page_viewer_page
    WHERE docID IN (<cfqueryparam cfsqltype="cf_sql_integer" list="yes" value="#ARGUMENTS.ID#">)
    </cfquery>
    <cfcatch type="any">
    <cfset result.message = "There was an error deleting the record(s).">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>  
    
    <cffunction name="deleteDocumentType" access="public" returntype="struct">
    <cfargument name="ID" type="string" required="yes">
    <cfset result.message = "You have successfully deleted the record(s).">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    DELETE FROM tbl_document_type
    WHERE ID IN (<cfqueryparam cfsqltype="cf_sql_integer" list="yes" value="#ARGUMENTS.ID#">)
    </cfquery>
    </cftransaction>
    <cfif ARGUMENTS.ID NEQ 0>
    <cfinvoke 
    component="MCMS.component.app.document.Document"
    method="getDocument"
    returnvariable="getDocumentRet">
    <cfinvokeargument name="doctID" value="#ARGUMENTS.ID#"/>
    <cfinvokeargument name="docStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getDocumentRet.recordcount NEQ 0>
    <cfset docID = ValueList(getDocumentRet.ID)>
    <cfinvoke 
    component="MCMS.component.app.document.Document"
    method="deleteDocument"
    returnvariable="deleteDocumentRet">
    <cfinvokeargument name="ID" value="#docID#"/>
    </cfinvoke>
    <cfinvoke 
    component="MCMS.component.app.document.Document"
    method="deleteDocumentDepartmentRel"
    returnvariable="deleteDocumentDepartmentRelRet">
    <cfinvokeargument name="docID" value="#docID#"/>
    </cfinvoke>
    <cfinvoke 
    component="MCMS.component.app.document.Document"
    method="deleteDocumentSiteRel"
    returnvariable="deleteDocumentSiteRelRet">
    <cfinvokeargument name="docID" value="#docID#"/>
    </cfinvoke>
    <cfinvoke 
    component="MCMS.component.app.document.Document"
    method="deleteDocumentUserRoleRel"
    returnvariable="deleteDocumentUserRoleRelRet">
    <cfinvokeargument name="docID" value="#docID#"/>
    </cfinvoke>
    <!---Delete Page Viewer Pages.--->
    <cfquery datasource="#application.mcmsDSN#">
    DELETE FROM tbl_page_viewer_page
    WHERE docID IN (<cfqueryparam cfsqltype="cf_sql_integer" list="yes" value="#ARGUMENTS.docID#">)
    </cfquery>
    </cfif>
    </cfif>
    <cfcatch type="any">
    <cfset result.message = "There was an error deleting the record(s).">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction> 
    
    <cffunction name="deleteDocumentSiteRel" access="public" returntype="struct">
    <cfargument name="ID" type="string" required="yes" default="0">
    <cfargument name="docID" type="string" required="yes" default="0">
    <cfset result.message = "You have successfully deleted the record(s).">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    DELETE FROM tbl_document_site_rel
    WHERE ID IN (<cfqueryparam cfsqltype="cf_sql_integer" list="yes" value="#ARGUMENTS.ID#">)
    OR docID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.docID#">
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error deleting the record(s).">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>  
    
    <cffunction name="deleteDocumentDepartmentRel" access="public" returntype="struct">
    <cfargument name="ID" type="string" required="yes" default="0">
    <cfargument name="docID" type="string" required="yes" default="0">
    <cfset result.message = "You have successfully deleted the record(s).">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    DELETE FROM tbl_document_department_rel
    WHERE ID IN (<cfqueryparam cfsqltype="cf_sql_integer" list="yes" value="#ARGUMENTS.ID#">)
    OR docID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.docID#">
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error deleting the record(s).">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="deleteDocumentUserRoleRel" access="public" returntype="struct">
    <cfargument name="ID" type="string" required="yes" default="0">
    <cfargument name="docID" type="string" required="yes" default="0">
    <cfset result.message = "You have successfully deleted the record(s).">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    DELETE FROM tbl_document_user_role_rel
    WHERE ID IN (<cfqueryparam cfsqltype="cf_sql_integer" list="yes" value="#ARGUMENTS.ID#">)
    OR docID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.docID#">
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error deleting the record(s).">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>    
</cfcomponent>