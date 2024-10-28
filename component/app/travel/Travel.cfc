<cfcomponent>
    <cffunction name="getTravel" access="public" returntype="query" hint="Get Travel data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="siteNo" type="string" required="yes" default="100">
    <cfargument name="deptNo" type="string" required="yes" default="0">
    <cfargument name="tDate" type="string" required="yes" default="">
    <cfargument name="tAirTotal" type="string" required="yes" default="0">
    <cfargument name="tRentalCarTotal" type="string" required="yes" default="0">
    <cfargument name="tAccommodationTotal" type="string" required="yes" default="0">
    <cfargument name="ID" type="numeric" required="yes" default="0">
    <cfargument name="excludeID" type="numeric" required="yes" default="0">
    <cfargument name="trID" type="string" required="yes" default="">
    <cfargument name="userID" type="string" required="yes" default="0">
    <cfargument name="tStatus" type="string" required="yes" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="deptName">
    <cfset var rsTravel = "" >
    <cftry>
    <cfquery name="rsTravel" datasource="#application.mcmsDSN#">
    SELECT * FROM v_travel WHERE 0=0
    <cfif ARGUMENTS.ID NEQ 0>
    AND ID = <cfqueryparam value="#ARGUMENTS.ID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.excludeID NEQ 0>
    AND ID <> <cfqueryparam value="#ARGUMENTS.excludeID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(userFName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(userLName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">)
    </cfif>
    <cfif ARGUMENTS.siteNo NEQ 100>
    AND siteNo IN (<cfqueryparam value="#ARGUMENTS.siteNo#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    <cfif ARGUMENTS.deptNo NEQ 0>
    AND deptNo IN (<cfqueryparam value="#ARGUMENTS.deptNo#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    <cfif ARGUMENTS.trID NEQ "">
    AND UPPER(trID) = <cfqueryparam value="#UCASE(ARGUMENTS.trID)#" cfsqltype="cf_sql_varchar">
    </cfif>
    <cfif ARGUMENTS.tDate NEQ "">
    AND tDate = <cfqueryparam value="#ARGUMENTS.tDate#" cfsqltype="cf_sql_date">
    </cfif>
    <cfif ARGUMENTS.tAirTotal NEQ 0>
    AND tAirTotal = <cfqueryparam value="#ARGUMENTS.tAirTotal#" cfsqltype="cf_sql_float">
    </cfif>
    <cfif ARGUMENTS.tRentalCarTotal NEQ 0>
    AND tRentalCarTotal = <cfqueryparam value="#ARGUMENTS.tRentalCarTotal#" cfsqltype="cf_sql_float">
    </cfif>
    <cfif ARGUMENTS.tAccommodationTotal NEQ 0>
    AND tAccommodationTotal = <cfqueryparam value="#ARGUMENTS.tAccommodationTotal#" cfsqltype="cf_sql_float">
    </cfif>
    <cfif ARGUMENTS.userID NEQ 0>
    AND userID = <cfqueryparam value="#ARGUMENTS.userID#" cfsqltype="cf_sql_integer">
    </cfif>
    AND tStatus IN (<cfqueryparam value="#ARGUMENTS.tStatus#" list="yes" cfsqltype="cf_sql_integer">)
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsTravel = StructNew()>
    <cfset rsTravel.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsTravel>
    </cffunction>
    
    <cffunction name="getTravelLine" access="public" returntype="query" hint="Get Travel Line data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="ID" type="numeric" required="yes" default="0">
    <cfargument name="tID" type="numeric" required="yes" default="0">
    <cfargument name="excludeID" type="numeric" required="yes" default="0">
    <cfargument name="tlDateDepart" type="string" required="yes" default="">
    <cfargument name="tlDepartCity" type="string" required="yes" default="">
    <cfargument name="tlDepartTime" type="string" required="yes" default="">
    <cfargument name="tlStatus" type="string" required="yes" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="tID">
    <cfset var rsTravelLine = "" >
    <cftry>
    <cfquery name="rsTravelLine" datasource="#application.mcmsDSN#">
    SELECT * FROM v_travel_line WHERE 0=0
    <cfif ARGUMENTS.ID NEQ 0>
    AND ID = <cfqueryparam value="#ARGUMENTS.ID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.excludeID NEQ 0>
    AND ID <> <cfqueryparam value="#ARGUMENTS.excludeID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND UPPER(tlDepartCity) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">
    </cfif>
    <cfif ARGUMENTS.tID NEQ 0>
    AND tID = <cfqueryparam value="#ARGUMENTS.tID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.tlDateDepart NEQ "">
    AND tlDateDepart = <cfqueryparam value="#ARGUMENTS.tlDateDepart#" cfsqltype="cf_sql_date">
    </cfif>
    <cfif ARGUMENTS.tlDepartCity NEQ "">
    AND tlDepartCity = <cfqueryparam value="#ARGUMENTS.tlDepartCity#" cfsqltype="cf_sql_varchar">
    </cfif>
    <cfif ARGUMENTS.tlDepartTime NEQ "">
    AND tlDepartTime = <cfqueryparam value="#ARGUMENTS.tlDepartTime#" cfsqltype="cf_sql_varchar">
    </cfif>
    AND tlStatus IN (<cfqueryparam value="#ARGUMENTS.tlStatus#" list="yes" cfsqltype="cf_sql_integer">)
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsTravelLine = StructNew()>
    <cfset rsTravelLine.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsTravelLine>
    </cffunction>
    
    <cffunction name="getTravelReason" access="public" returntype="query" hint="Get Travel Reason data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="trName" type="string" required="yes" default="">
    <cfargument name="ID" type="numeric" required="yes" default="0">
    <cfargument name="excludeID" type="numeric" required="yes" default="0">
    <cfargument name="trStatus" type="string" required="yes" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="trName">
    <cfset var rsTravelReason = "" >
    <cftry>
    <cfquery name="rsTravelReason" datasource="#application.mcmsDSN#">
    SELECT * FROM v_travel_reason WHERE 0=0
    <cfif ARGUMENTS.ID NEQ 0>
    AND ID = <cfqueryparam value="#ARGUMENTS.ID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.excludeID NEQ 0>
    AND ID <> <cfqueryparam value="#ARGUMENTS.excludeID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(trName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR
    UPPER(trDescription) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">)
    </cfif>
    <cfif ARGUMENTS.trName NEQ "">
    AND trName = <cfqueryparam value="#ARGUMENTS.trName#" cfsqltype="cf_sql_varchar">
    </cfif>
    AND trStatus IN (<cfqueryparam value="#ARGUMENTS.trStatus#" list="yes" cfsqltype="cf_sql_integer">)
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsTravelReason = StructNew()>
    <cfset rsTravelReason.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsTravelReason>
    </cffunction>
    
    <cffunction name="getTravelStatus" access="public" returntype="query" hint="Get Travel Status data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="ID" type="numeric" required="yes" default="0">
    <cfargument name="excludeID" type="numeric" required="yes" default="0">
    <cfargument name="tsStatus" type="string" required="yes" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="tsName">
    <cfset var rsTravelStatus = "" >
    <cftry>
    <cfquery name="rsTravelStatus" datasource="#application.mcmsDSN#">
    SELECT * FROM tbl_travel_status WHERE 0=0
    <cfif ARGUMENTS.ID NEQ 0>
    AND ID = <cfqueryparam value="#ARGUMENTS.ID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.excludeID NEQ 0>
    AND ID <> <cfqueryparam value="#ARGUMENTS.excludeID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND UPPER(tsName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">
    </cfif>
    AND tsStatus IN (<cfqueryparam value="#ARGUMENTS.tsStatus#" list="yes" cfsqltype="cf_sql_integer">)
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsTravelStatus = StructNew()>
    <cfset rsTravelStatus.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsTravelStatus>
    </cffunction>
    
    <cffunction name="getTravelApproverUserDepartmentRel" access="public" returntype="query" hint="Get Travel Approver User Department data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="ID" type="numeric" required="yes" default="0">
    <cfargument name="userID" type="numeric" required="yes" default="0">
    <cfargument name="deptNo" type="string" required="yes" default="0">
    <cfargument name="excludeID" type="numeric" required="yes" default="0">
    <cfargument name="taudrStatus" type="string" required="yes" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="userfName">
    <cfset var rsTravelApproverUserDepartmentRel = "" >
    <cftry>
    <cfquery name="rsTravelApproverUserDepartmentRel" datasource="#application.mcmsDSN#">
    SELECT * FROM v_travel_approver_u_d_rel WHERE 0=0
    <cfif ARGUMENTS.ID NEQ 0>
    AND ID = <cfqueryparam value="#ARGUMENTS.ID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.excludeID NEQ 0>
    AND ID <> <cfqueryparam value="#ARGUMENTS.excludeID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.deptNo NEQ 0>
    AND deptNo IN (<cfqueryparam value="#ARGUMENTS.deptNo#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    <cfif ARGUMENTS.userID NEQ 0>
    AND userID = (<cfqueryparam value="#ARGUMENTS.userID#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND UPPER(userfName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">
    </cfif>
    AND taudrStatus IN (<cfqueryparam value="#ARGUMENTS.taudrStatus#" list="yes" cfsqltype="cf_sql_integer">)
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsTravelApproverUserDepartmentRel = StructNew()>
    <cfset rsTravelApproverUserDepartmentRel.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsTravelApproverUserDepartmentRel>
    </cffunction>
    
    <cffunction name="getTravelAgentUserDepartmentRel" access="public" returntype="query" hint="Get Travel Agent User Department data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="ID" type="numeric" required="yes" default="0">
    <cfargument name="deptNo" type="string" required="yes" default="0">
    <cfargument name="excludeID" type="numeric" required="yes" default="0">
    <cfargument name="taudrStatus" type="string" required="yes" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="userfName">
    <cfset var rsTravelAgentUserDepartmentRel = "" >
    <cftry>
    <cfquery name="rsTravelAgentUserDepartmentRel" datasource="#application.mcmsDSN#">
    SELECT * FROM v_travel_agent_u_d_rel WHERE 0=0
    <cfif ARGUMENTS.ID NEQ 0>
    AND ID = <cfqueryparam value="#ARGUMENTS.ID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.excludeID NEQ 0>
    AND ID <> <cfqueryparam value="#ARGUMENTS.excludeID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.deptNo NEQ 0>
    AND deptNo IN (<cfqueryparam value="#ARGUMENTS.deptNo#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND UPPER(userfName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">
    </cfif>
    AND taudrStatus IN (<cfqueryparam value="#ARGUMENTS.taudrStatus#" list="yes" cfsqltype="cf_sql_integer">)
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsTravelAgentUserDepartmentRel = StructNew()>
    <cfset rsTravelAgentUserDepartmentRel.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsTravelAgentUserDepartmentRel>
    </cffunction>
    
    <cffunction name="getTravelReport" access="public" returntype="query" hint="Get Travel Report data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="siteNo" type="string" required="yes" default="100">
    <cfargument name="deptNo" type="string" required="yes" default="0">
    <cfargument name="orderBy" type="string" required="yes" default="deptName">
    <cfset var rsTravelReport = "" >
    <cftry>
    <cfquery name="rsTravelReport" datasource="#application.mcmsDSN#">
    SELECT ID As Reference_No, userfName || ' ' || userlName As Requestee, TO_CHAR(tDate,'MM/DD/YYYY') As T_Date, siteName As Site, deptName As Department, trName As Reason, sName As Status, tsname As Travel_Status FROM v_travel WHERE 0=0
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(userfName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(userlName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">)
    </cfif>
    <cfif ARGUMENTS.siteNo NEQ 100>
    AND siteNo IN (<cfqueryparam value="#ARGUMENTS.siteNo#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    <cfif ARGUMENTS.deptNo NEQ 0>
    AND deptNo IN (<cfqueryparam value="#ARGUMENTS.deptNo#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsTravelReport = StructNew()>
    <cfset rsTravelReport.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsTravelReport>
    </cffunction>
    
    <cffunction name="getTravelReasonReport" access="public" returntype="query" hint="Get Travel Reason Report data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="orderBy" type="string" required="yes" default="trName">
    <cfset var rsTravelReasonReport = "" >
    <cftry>
    <cfquery name="rsTravelReasonReport" datasource="#application.mcmsDSN#">
    SELECT trName As Name, trDescription As Description, sortName As Sort, sName As Status FROM v_travel_reason WHERE 0=0
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(trName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(trDescription) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">)
    </cfif>
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsTravelReasonReport = StructNew()>
    <cfset rsTravelReasonReport.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsTravelReasonReport>
    </cffunction>
    
    <cffunction name="getTravelApproverUserDepartmentRelReport" access="public" returntype="query" hint="Get Travel Approver User Department Rel Report data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="orderBy" type="string" required="yes" default="userfName">
    <cfset var rsTravelApproverUserDepartmentRelReport = "" >
    <cftry>
    <cfquery name="rsTravelApproverUserDepartmentRelReport" datasource="#application.mcmsDSN#">
    SELECT userfName || ' ' || userlName As Approver, deptName As Department, sName As Status FROM v_travel_approver_u_d_rel WHERE 0=0
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(userfName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(userlName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">)
    </cfif>
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsTravelApproverUserDepartmentRelReport = StructNew()>
    <cfset rsTravelApproverUserDepartmentRelReport.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsTravelApproverUserDepartmentRelReport>
    </cffunction>
    
    <cffunction name="getTravelAgentUserDepartmentRelReport" access="public" returntype="query" hint="Get Travel Agent User Department Rel Report data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="orderBy" type="string" required="yes" default="userfName">
    <cfset var rsTravelAgentUserDepartmentRelReport = "" >
    <cftry>
    <cfquery name="rsTravelAgentUserDepartmentRelReport" datasource="#application.mcmsDSN#">
    SELECT userfName || ' ' || userlName As Agent, deptName As Department, sName As Status FROM v_travel_agent_u_d_rel WHERE 0=0
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(userfName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(userlName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">)
    </cfif>
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsTravelAgentUserDepartmentRelReport = StructNew()>
    <cfset rsTravelAgentUserDepartmentRelReport.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsTravelAgentUserDepartmentRelReport>
    </cffunction>
    
    <cffunction name="getTravelDocumentRel" access="public" returntype="query" hint="Get Travel Document Rel. data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="ID" type="numeric" required="yes" default="0">
    <cfargument name="excludeID" type="numeric" required="yes" default="0">
    <cfargument name="tID" type="string" required="yes" default="0">
    <cfargument name="docID" type="numeric" required="yes" default="0">
    <cfargument name="tdrStatus" type="string" required="yes" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="docName">
    <cfset var rsTravelDocumentRel = "" >
    <cftry>
    <cfquery name="rsTravelDocumentRel" datasource="#application.mcmsDSN#">
    SELECT * FROM v_travel_document_rel WHERE 0=0
    <cfif ARGUMENTS.ID NEQ 0>
    AND ID = <cfqueryparam value="#ARGUMENTS.ID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.excludeID NEQ 0>
    AND ID <> <cfqueryparam value="#ARGUMENTS.excludeID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND UPPER(docName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">
    </cfif>
    <cfif ARGUMENTS.tID NEQ 0>
    AND tID IN (<cfqueryparam value="#ARGUMENTS.tID#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    <cfif ARGUMENTS.docID NEQ 0>
    AND docID = <cfqueryparam value="#ARGUMENTS.docID#" cfsqltype="cf_sql_integer">
    </cfif>
    AND tdrStatus IN (<cfqueryparam value="#ARGUMENTS.tdrStatus#" list="yes" cfsqltype="cf_sql_integer">)
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsTravelDocumentRel = StructNew()>
    <cfset rsTravelDocumentRel.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsTravelDocumentRel>
    </cffunction>
    
    <cffunction name="insertTravel" access="public" returntype="struct">
    <cfargument name="tDate" type="string" required="yes">
    <cfargument name="tEmployee" type="string" required="yes">
    <cfargument name="tSpecialInstruction" type="string" required="yes">
    <cfargument name="tComment" type="string" required="yes">
    <cfargument name="siteNo" type="numeric" required="yes">
    <cfargument name="deptNo" type="numeric" required="yes">
    <cfargument name="userID" type="numeric" required="yes">
    <cfargument name="trID" type="numeric" required="yes">
    <cfargument name="taurrID" type="numeric" required="yes">
    <cfargument name="tsID" type="numeric" required="yes">
    <cfargument name="tStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully inserted the record.">
    <cftry>
    <!---Check for profanity in the text.--->
    <cfinvoke 
    component="MCMS.component.utility.Regex"
    method="regexProfanity"
    returnvariable="regexProfanityRet">
    <cfinvokeargument name="profanityString" value="#ARGUMENTS.tSpecialInstruction#"/>
    </cfinvoke>
    <!---Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.app.travel.Travel"
    method="getTravel"
    returnvariable="getTravelRet">
    <cfinvokeargument name="tEmployee" value="#ARGUMENTS.tEmployee#"/>
    <cfinvokeargument name="siteNo" value="#ARGUMENTS.siteNo#"/>
    <cfinvokeargument name="deptNo" value="#ARGUMENTS.deptNo#"/>
    <cfinvokeargument name="tDate" value="#ARGUMENTS.tDate#"/>
    <cfinvokeargument name="tStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getTravelRet.recordcount NEQ 0>
    <cfset result.message = "The travel request already exists, please try again.">
    <cfelseif regexProfanityRet CONTAINS '$%&*!'>
    <cfset result.message = "Some text contained profanity, please remove any profanity from your text.">
    <!---Check length restriction.--->
    <cfelseif LEN(ARGUMENTS.tSpecialInstruction) GT 1024>
    <cfset result.message = "The instruction is longer than 1024 characters, please enter new instructions under 1024 characters.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    INSERT INTO tbl_travel (temployee,tSpecialInstruction,tComment,siteNo,deptNo,userID,trID,taurrID,tsID,tStatus) VALUES
    (
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.temployee#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.tSpecialInstruction#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.tComment#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.siteNo#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.deptNo#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.userID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.trID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.taurrID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.tsID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.tStatus#">
    )
    </cfquery>
    </cftransaction>
    <cfinvoke 
    component="MCMS.component.cms.Cms"
    method="getMaxValueSQL"
    returnvariable="tID">
    <cfinvokeargument name="tableName" value="tbl_travel"/>
    </cfinvoke>
    <cfset var.tID = tID>
    <cfset result.tID = tID>
    </cfif>
    <cfcatch type="any">
    <cfset result.message = "There was an error inserting the record.">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="insertTravelLine" access="public" returntype="struct">
    <cfargument name="tID" type="numeric" required="yes">
    <cfargument name="tlDateDepart" type="string" required="yes">
    <cfargument name="tlDepartCity" type="string" required="yes">
    <cfargument name="tlDepartTime" type="string" required="yes">
    <cfargument name="tlArriveCity" type="string" required="yes">
    <cfargument name="tlArriveTime" type="string" required="yes">
    <cfargument name="tlRentalCarRequired" type="numeric" required="yes">
    <cfargument name="tlAccommodationRequired" type="numeric" required="yes">
    <cfargument name="tlSort" type="numeric" required="yes">
    <cfargument name="tlStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully inserted the record.">
    <cftry>
    <!---Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.app.travel.Travel"
    method="getTravelLine"
    returnvariable="getCheckTravelLineRet">
    <cfinvokeargument name="tID" value="#ARGUMENTS.tID#"/>
    <cfinvokeargument name="tlDateDepart" value="#ARGUMENTS.tlDateDepart#"/>
    <cfinvokeargument name="tlDepartCity" value="#ARGUMENTS.tlDepartCity#"/>
    <cfinvokeargument name="tlDepartTime" value="#ARGUMENTS.tlDepartTime#"/>
    <cfinvokeargument name="tlStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckTravelLineRet.recordcount NEQ 0>
    <cfset result.message = "The travel request line already exists, please try again.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    INSERT INTO tbl_travel_line (tID,tlDateDepart,tlDepartCity,tlDepartTime,tlArriveCity,tlArriveTime,tlRentalCarRequired,tlAccommodationRequired,tlSort,tlStatus) VALUES
    (
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.tID#">,
    <cfqueryparam cfsqltype="cf_sql_date" value="#ARGUMENTS.tlDateDepart#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.tlDepartCity#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.tlDepartTime#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.tlArriveCity#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.tlArriveTime#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.tlRentalCarRequired#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.tlAccommodationRequired#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.tlSort#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.tlStatus#">
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
    
    <cffunction name="insertTravelDocumentRel" access="public" returntype="struct">
    <cfargument name="tID" type="numeric" required="yes">
    <cfargument name="docID" type="numeric" required="yes">
    <cfargument name="tdrStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully inserted the record.">
    <cftry>
    <cftransaction>
    <!---Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.app.travel.Travel"
    method="getTravelDocumentRel"
    returnvariable="getCheckTravelDocumentRelRet">
    <cfinvokeargument name="tID" value="#ARGUMENTS.tID#"/>
    <cfinvokeargument name="docID" value="#ARGUMENTS.docID#"/>
    <cfinvokeargument name="tdrStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckTravelDocumentRelRet.recordcount NEQ 0>
    <cfset result.message = "The name #getCheckTravelDocumentRelRet.docName# already exists, please choose a new document.">
    <cfelse>
    <cfquery datasource="#application.mcmsDSN#">
    INSERT INTO tbl_travel_document_rel (tID,docID,tdrStatus) VALUES
    (
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.tID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.docID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.tdrStatus#">
    )
    </cfquery>
    <cfset result.passed = true>
    </cfif>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error inserting the record.">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="insertTravelReason" access="public" returntype="struct">
    <cfargument name="trName" type="string" required="yes">
    <cfargument name="trDescription" type="string" required="yes">
    <cfargument name="trSort" type="numeric" required="yes">
    <cfargument name="trStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully inserted the record.">
    <cftry>
    <!---Check for profanity in the text.--->
    <cfinvoke 
    component="MCMS.component.utility.Regex"
    method="regexProfanity"
    returnvariable="regexProfanityRet">
    <cfinvokeargument name="profanityString" value="#ARGUMENTS.trDescription#"/>
    </cfinvoke>
    <!---Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.app.travel.Travel"
    method="getTravelReason"
    returnvariable="getCheckTravelReasonRet">
    <cfinvokeargument name="trName" value="#ARGUMENTS.trName#"/>
    <cfinvokeargument name="trStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckTravelReasonRet.recordcount NEQ 0>
    <cfset result.message = "The name #ARGUMENTS.trName# already exists, please enter a new name.">
    <cfelseif regexProfanityRet CONTAINS '$%&*!'>
    <cfset result.message = "Some text contained profanity, please remove any profanity from your text.">
    <!---Check length restriction.--->
    <cfelseif LEN(ARGUMENTS.trDescription) GT 512>
    <cfset result.message = "The description is longer than 512 characters, please enter a new description under 512 characters.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    INSERT INTO tbl_travel_reason (trName,trDescription,trSort,trStatus) VALUES
    (
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.trName#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.trDescription#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.trSort#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.trStatus#">
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
    
    <cffunction name="insertTravelApproverUserDepartmentRel" access="public" returntype="struct">
    <cfargument name="userID" type="numeric" required="yes">
    <cfargument name="deptNo" type="numeric" required="yes">
    <cfargument name="taudrStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully inserted the record.">
    <cftry>
    <!---Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.app.travel.Travel"
    method="getTravelApproverUserDepartmentRel"
    returnvariable="getCheckTravelApproverUserDepartmentRelRet">
    <cfinvokeargument name="userID" value="#ARGUMENTS.userID#"/>
    <cfinvokeargument name="deptNo" value="#ARGUMENTS.deptNo#"/>
    <cfinvokeargument name="taudrStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckTravelApproverUserDepartmentRelRet.recordcount NEQ 0>
    <cfset result.message = "The approver department relationship already exists, please try again.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    INSERT INTO tbl_travel_approver_u_d_rel (userID,deptNo,taudrStatus) VALUES
    (
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.userID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.deptNo#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.taudrStatus#">
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
    
    <cffunction name="insertTravelAgentUserDepartmentRel" access="public" returntype="struct">
    <cfargument name="userID" type="numeric" required="yes">
    <cfargument name="deptNo" type="numeric" required="yes">
    <cfargument name="taudrStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully inserted the record.">
    <cftry>
    <!---Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.app.travel.Travel"
    method="getTravelAgentUserDepartmentRel"
    returnvariable="getCheckTravelAgentUserDepartmentRelRet">
    <cfinvokeargument name="userID" value="#ARGUMENTS.userID#"/>
    <cfinvokeargument name="deptNo" value="#ARGUMENTS.deptNo#"/>
    <cfinvokeargument name="taudrStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckTravelAgentUserDepartmentRelRet.recordcount NEQ 0>
    <cfset result.message = "The agent department relationship already exists, please try again.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    INSERT INTO tbl_travel_agent_u_d_rel (userID,deptNo,taudrStatus) VALUES
    (
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.userID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.deptNo#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.taudrStatus#">
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
    
    <cffunction name="updateTravel" access="public" returntype="struct">
    <cfargument name="ID" type="numeric" required="yes">
    <cfargument name="uaID" type="numeric" required="yes">
    <cfargument name="tDate" type="string" required="yes">
    <cfargument name="tEmployee" type="string" required="yes">
    <cfargument name="tSpecialInstruction" type="string" required="yes">
    <cfargument name="tffp" type="string" required="yes" default="">
    <cfargument name="tComment" type="string" required="yes">
    <cfargument name="tApproverComment" type="string" required="yes" default="">
    <cfargument name="tAirTotal" type="string" required="yes" default="0.00">
    <cfargument name="tRentalCarTotal" type="string" required="yes" default="0.00">
    <cfargument name="tAccommodationTotal" type="string" required="yes" default="0.00">
    <cfargument name="siteNo" type="numeric" required="yes">
    <cfargument name="deptNo" type="numeric" required="yes">
    <cfargument name="userID" type="numeric" required="yes">
    <cfargument name="trID" type="numeric" required="yes">
    <cfargument name="taurrID" type="numeric" required="yes">
    <cfargument name="tsID" type="numeric" required="yes">
    <cfargument name="tStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully updated the record.">
    <cftry>
    <!---Check for profanity in the text.--->
    <cfinvoke 
    component="MCMS.component.utility.Regex"
    method="regexProfanity"
    returnvariable="regexProfanityRet">
    <cfinvokeargument name="profanityString" value="#ARGUMENTS.tSpecialInstruction#"/>
    </cfinvoke>
    <!---Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.app.travel.Travel"
    method="getTravel"
    returnvariable="getCheckTravelRet">
    <cfinvokeargument name="excludeID" value="#ARGUMENTS.ID#"/>
    <cfinvokeargument name="tEmployee" value="#ARGUMENTS.tEmployee#"/>
    <cfinvokeargument name="siteNo" value="#ARGUMENTS.siteNo#"/>
    <cfinvokeargument name="deptNo" value="#ARGUMENTS.deptNo#"/>
    <cfinvokeargument name="tDate" value="#ARGUMENTS.tDate#"/>
    <cfinvokeargument name="tStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckTravelRet.recordcount NEQ 0>
    <cfset result.message = "The travel request already exists, please try again.">
    <cfelseif regexProfanityRet CONTAINS '$%&*!'>
    <cfset result.message = "Some text contained profanity, please remove any profanity from your text.">
    <!---Check length restriction.--->
    <cfelseif LEN(ARGUMENTS.tSpecialInstruction) GT 1024>
    <cfset result.message = "The instruction is longer than 1024 characters, please enter new instructions under 1024 characters.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_travel SET
    tEmployee = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.tEmployee#">,
    tSpecialInstruction = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.tSpecialInstruction#">,
    tffp = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.tffp#">,
    tComment = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.tComment#">,
    tApproverComment = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.tApproverComment#">,
    tAirTotal = <cfqueryparam cfsqltype="cf_sql_float" value="#ARGUMENTS.tAirTotal#">,
    tRentalCarTotal = <cfqueryparam cfsqltype="cf_sql_float" value="#ARGUMENTS.tRentalCarTotal#">,
    tAccommodationTotal = <cfqueryparam cfsqltype="cf_sql_float" value="#ARGUMENTS.tAccommodationTotal#">,
    siteNo = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.siteNo#">,
    deptNo = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.deptNo#">,
    trID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.trID#">,
    taurrID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.taurrID#">,
    tsID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.tsID#">,
    <!--- Update approved and completed columns. --->
	<cfif tsID EQ 3>
    tDateApproved = <cfqueryparam cfsqltype="cf_sql_timestamp" value="#Now()#">,
    <cfelseif tsID EQ 6>
    tDateCompleted = <cfqueryparam cfsqltype="cf_sql_timestamp" value="#Now()#">,
    </cfif>
		<cfif ARGUMENTS.uaID NEQ 101>
    tDateUpdate = <cfqueryparam cfsqltype="cf_sql_timestamp" value="#Now()#">,
    userID = <cfqueryparam cfsqltype="cf_sql_integer" value="#session.userID#">,
    </cfif>
    tStatus = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.tStatus#">
    WHERE ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ID#">
    </cfquery>
    </cftransaction>
    <cfinvoke 
    component="MCMS.component.app.travel.Travel"
    method="sendTravelWorkFlowEmail"
    returnvariable="sendTravelEmailRet">
    <cfinvokeargument name="tID" value="#ARGUMENTS.ID#"/>
    </cfinvoke>
    </cfif>
    <cfcatch type="any">
    <cfset result.message = "There was an error updating the record.">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="updateTravelReason" access="public" returntype="struct">
    <cfargument name="ID" type="numeric" required="yes">
    <cfargument name="trName" type="string" required="yes">
    <cfargument name="trDescription" type="string" required="yes">
    <cfargument name="trSort" type="numeric" required="yes">
    <cfargument name="trStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully updated the record.">
    <cftry>
    <!---Check for profanity in the text.--->
    <cfinvoke 
    component="MCMS.component.utility.Regex"
    method="regexProfanity"
    returnvariable="regexProfanityRet">
    <cfinvokeargument name="profanityString" value="#ARGUMENTS.trDescription#"/>
    </cfinvoke>
    <!---Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.app.travel.Travel"
    method="getTravelReason"
    returnvariable="getCheckTravelReasonRet">
    <cfinvokeargument name="excludeID" value="#ARGUMENTS.ID#"/>
    <cfinvokeargument name="trName" value="#ARGUMENTS.trName#"/>
    <cfinvokeargument name="trStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckTravelReasonRet.recordcount NEQ 0>
    <cfset result.message = "The name #ARGUMENTS.trName# already exists, please enter a new name.">
    <cfelseif regexProfanityRet CONTAINS '$%&*!'>
    <cfset result.message = "Some text contained profanity, please remove any profanity from your text.">
    <!---Check length restriction.--->
    <cfelseif LEN(ARGUMENTS.trDescription) GT 512>
    <cfset result.message = "The description is longer than 512 characters, please enter a new description under 512 characters.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_travel_reason SET
    trName = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.trName#">,
    trDescription = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.trDescription#">,
    trSort = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.trSort#">,
    trStatus = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.trStatus#">
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
    
    <cffunction name="updateTravelApproverUserDepartmentRel" access="public" returntype="struct">
    <cfargument name="ID" type="numeric" required="yes">
    <cfargument name="userID" type="numeric" required="yes">
    <cfargument name="deptNo" type="numeric" required="yes">
    <cfargument name="taudrStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully updated the record.">
    <cftry>
    <!---Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.app.travel.Travel"
    method="getTravelApproverUserDepartmentRel"
    returnvariable="getCheckTravelApproverUserDepartmentRet">
    <cfinvokeargument name="excludeID" value="#ARGUMENTS.ID#"/>
    <cfinvokeargument name="userID" value="#ARGUMENTS.userID#"/>
    <cfinvokeargument name="deptNo" value="#ARGUMENTS.deptNo#"/>
    <cfinvokeargument name="taudrStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckTravelApproverUserDepartmentRet.recordcount NEQ 0>
    <cfset result.message = "The approver department relationship already exists, please try again.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_travel_approver_u_d_rel SET
    userID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.userID#">,
    deptNo = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.deptNo#">,
    taudrStatus = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.taudrStatus#">
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
    
    <cffunction name="updateTravelAgentUserDepartmentRel" access="public" returntype="struct">
    <cfargument name="ID" type="numeric" required="yes">
    <cfargument name="userID" type="numeric" required="yes">
    <cfargument name="deptNo" type="numeric" required="yes">
    <cfargument name="taudrStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully updated the record.">
    <cftry>
    <!---Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.app.travel.Travel"
    method="getTravelAgentUserDepartmentRel"
    returnvariable="getCheckTravelAgentUserDepartmentRet">
    <cfinvokeargument name="excludeID" value="#ARGUMENTS.ID#"/>
    <cfinvokeargument name="userID" value="#ARGUMENTS.userID#"/>
    <cfinvokeargument name="deptNo" value="#ARGUMENTS.deptNo#"/>
    <cfinvokeargument name="taudrStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckTravelAgentUserDepartmentRet.recordcount NEQ 0>
    <cfset result.message = "The agent department relationship already exists, please try again.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_travel_agent_u_d_rel SET
    userID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.userID#">,
    deptNo = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.deptNo#">,
    taudrStatus = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.taudrStatus#">
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
    
    <cffunction name="sendTravelWorkFlowEmail" access="public" returntype="struct">
    <cfargument name="tID" type="numeric" required="yes">
    <cfset result.message = "You have successfully sent for approval.">
    <cftry>
    <cfinvoke 
    component="MCMS.component.app.travel.Travel"
    method="getTravel"
    returnvariable="getTravelRet">
    <cfinvokeargument name="ID" value="#ARGUMENTS.tID#"/>
    <cfinvokeargument name="tStatus" value="1"/>
    </cfinvoke>
    <cfinvoke 
    component="MCMS.component.app.travel.Travel"
    method="getTravelApproverUserDepartmentRel"
    returnvariable="getTravelApproverUserDepartmentRelRet">
    <cfinvokeargument name="deptNo" value="0,#getTravelRet.deptNo#"/>
    <cfinvokeargument name="taudrStatus" value="1"/>
    </cfinvoke>
    <cfinvoke 
    component="MCMS.component.app.travel.Travel"
    method="getTravelAgentUserDepartmentRel"
    returnvariable="getTravelAgentUserDepartmentRelRet">
    <cfinvokeargument name="deptNo" value="0,#getTravelRet.deptNo#"/>
    <cfinvokeargument name="taudrStatus" value="1"/>
    </cfinvoke>
    <cfif getTravelRet.tsID EQ 2>
    <!--- Send email to approver. --->
    <cfset var.email = getTravelApproverUserDepartmentRelRet.userEmail>
    <!--- Send email to agent. --->
	<cfelseif getTravelRet.tsID EQ 3>
    <cfset var.email = getTravelAgentUserDepartmentRelRet.userEmail>
    <!--- Send email to requestee. --->
    <cfelseif getTravelRet.tsID EQ 4 OR getTravelRet.tsID EQ 5 OR getTravelRet.tsID EQ 6>
    <cfset var.email = getTravelRet.userEmail>
    </cfif>
    <cfinvoke 
    component="MCMS.component.utility.Email"
    method="sendEmail">
    <cfinvokeargument name="subject" value="#application.companyName# - Travel Request #getTravelRet.tsName#"/>
    <cfinvokeargument name="to" value="#var.email#"/>
    <cfinvokeargument name="from" value="#application.noReplyEmail#"/>
    <cfinvokeargument name="body" value=""/>
    <cfinvokeargument name="ID" value="#ARGUMENTS.tID#"/>
    <cfinvokeargument name="emailTemplate" value="/#application.mcmsAppAdminPath#/travel/view/inc_travel_email_template.cfm"/>
    </cfinvoke>
    <cfcatch type="any">
    <cfset result.message = "There was an error subitting for approval.">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="updateTravelList" access="public" returntype="struct">
    <cfargument name="ID" type="numeric" required="yes">
    <cfargument name="tsID" type="numeric" required="yes" default="0">
    <cfargument name="tStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully updated the records.">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_travel SET
    <cfif tsID NEQ 0>
    tsID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.tsID#">,
    <cfif tsID EQ 3>
    tDateApproved = <cfqueryparam cfsqltype="cf_sql_timestamp" value="#Now()#">,
    <cfelseif tsID EQ 6>
    tDateCompleted = <cfqueryparam cfsqltype="cf_sql_timestamp" value="#Now()#">,
    </cfif>
    </cfif>
    tStatus = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.tStatus#">
    WHERE ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ID#">
    </cfquery>
    <cfif tsID NEQ 0>
    <cfinvoke 
    component="MCMS.component.app.travel.Travel"
    method="sendTravelWorkFlowEmail"
    returnvariable="sendTravelEmailRet">
    <cfinvokeargument name="tID" value="#ARGUMENTS.ID#"/>
    </cfinvoke>
    </cfif>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error updating the records.">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="updateTravelReasonList" access="public" returntype="struct">
    <cfargument name="ID" type="numeric" required="yes">
    <cfargument name="trStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully updated the records.">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_travel_reason SET
    trStatus = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.trStatus#">
    WHERE ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ID#">
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error updating the records.">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="updateTravelApproverUserDeptRelList" access="public" returntype="struct">
    <cfargument name="ID" type="numeric" required="yes">
    <cfargument name="taudrStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully updated the records.">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_travel_approver_u_d_rel SET
    taudrStatus = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.taudrStatus#">
    WHERE ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ID#">
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error updating the records.">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="updateTravelAgentUserDeptRelList" access="public" returntype="struct">
    <cfargument name="ID" type="numeric" required="yes">
    <cfargument name="taudrStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully updated the records.">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_travel_agent_u_d_rel SET
    taudrStatus = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.taudrStatus#">
    WHERE ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ID#">
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error updating the records.">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="deleteTravel" access="public" returntype="struct">
    <cfargument name="ID" type="string" required="yes">
    <cfset result.message = "You have successfully deleted the record(s).">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    DELETE FROM tbl_travel
    WHERE ID IN (<cfqueryparam cfsqltype="cf_sql_integer" list="yes" value="#ARGUMENTS.ID#">)
    </cfquery>
    </cftransaction>
    <cfinvoke 
    component="MCMS.component.app.travel.Travel"
    method="deleteTravelLine"
    returnvariable="deleteTravelLineRet">
    <cfinvokeargument name="tID" value="#ARGUMENTS.ID#"/>
    </cfinvoke>
    <cfcatch type="any">
    <cfset result.message = "There was an error deleting the record(s).">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="deleteTravelReason" access="public" returntype="struct">
    <cfargument name="ID" type="string" required="yes">
    <cfset result.message = "You have successfully deleted the record(s).">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    DELETE FROM tbl_travel_reason
    WHERE ID IN (<cfqueryparam cfsqltype="cf_sql_integer" list="yes" value="#ARGUMENTS.ID#">)
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error deleting the record(s).">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction> 
    
    <cffunction name="deleteTravelLine" access="public" returntype="struct">
    <cfargument name="ID" type="string" required="yes" default="0">
    <cfargument name="tID" type="numeric" required="yes" default="0">
    <cfset result.message = "You have successfully deleted the record(s).">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    DELETE FROM tbl_travel_line
    WHERE ID IN (<cfqueryparam cfsqltype="cf_sql_integer" list="yes" value="#ARGUMENTS.ID#">)
    OR tID = <cfqueryparam cfsqltype="cf_sql_integer" list="yes" value="#ARGUMENTS.tID#">
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error deleting the record(s).">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="deleteTravelDocumentRel" access="public" returntype="struct">
    <cfargument name="ID" type="string" required="yes" default="0">
    <cfargument name="tID" type="string" required="yes" default="0">
    <cfset result.message = "You have successfully deleted the record(s).">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    DELETE FROM tbl_travel_document_rel
    WHERE ID IN (<cfqueryparam cfsqltype="cf_sql_integer" list="yes" value="#ARGUMENTS.ID#">) OR
    tID IN (<cfqueryparam cfsqltype="cf_sql_integer" list="yes" value="#ARGUMENTS.tID#">)
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error deleting the record(s).">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction> 
    
    <cffunction name="deleteTravelApproverUserDeptRel" access="public" returntype="struct">
    <cfargument name="ID" type="string" required="yes">
    <cfset result.message = "You have successfully deleted the record(s).">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    DELETE FROM tbl_travel_approver_u_d_rel
    WHERE ID IN (<cfqueryparam cfsqltype="cf_sql_integer" list="yes" value="#ARGUMENTS.ID#">)
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error deleting the record(s).">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction> 
    
    <cffunction name="deleteTravelAgentUserDeptRel" access="public" returntype="struct">
    <cfargument name="ID" type="string" required="yes">
    <cfset result.message = "You have successfully deleted the record(s).">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    DELETE FROM tbl_travel_agent_u_d_rel
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