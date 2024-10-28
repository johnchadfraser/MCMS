<cfcomponent>
    <cffunction name="getPoll" access="public" returntype="query" hint="Get Poll data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="ID" type="numeric" required="yes" default="0">
    <cfargument name="excludeID" type="numeric" required="yes" default="0">
    <cfargument name="pName" type="string" required="yes" default="">
    <cfargument name="pQuestion" type="string" required="yes" default="">
    <cfargument name="dateRange" type="string" required="yes" default="false">
    <cfargument name="pDateRel" type="string" required="yes" default="">
    <cfargument name="pDateExp" type="string" required="yes" default="">
    <cfargument name="ptID" type="string" required="yes" default="0">
    <cfargument name="pStatus" type="string" required="yes" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="pName">
    <cfset var rsPoll = "" >
    <cftry>
    <cfquery name="rsPoll" datasource="#application.mcmsDSN#">
    SELECT * FROM v_poll WHERE 0=0
    <cfif ARGUMENTS.ID NEQ 0>
    AND ID = <cfqueryparam value="#ARGUMENTS.ID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.excludeID NEQ 0>
    AND ID <> <cfqueryparam value="#ARGUMENTS.excludeID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(pName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(pQuestion) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">)
    </cfif>
    <cfif ARGUMENTS.pName NEQ "">
    AND UPPER(pName) = <cfqueryparam value="#UCASE(ARGUMENTS.pName)#" cfsqltype="cf_sql_varchar">
    </cfif>
    <cfif ARGUMENTS.pQuestion NEQ "">
    AND UPPER(pQuestion) = <cfqueryparam value="#UCASE(ARGUMENTS.pQuestion)#" cfsqltype="cf_sql_varchar">
    </cfif>
    <cfif ARGUMENTS.dateRange EQ "true">
    <cfif ARGUMENTS.pDateRel NEQ "">
    AND pDateRel >= <cfqueryparam value="#ARGUMENTS.pDateRel#" cfsqltype="cf_sql_date">
    </cfif>
    <cfif ARGUMENTS.pDateExp NEQ "">
    AND pDateExp <= <cfqueryparam value="#ARGUMENTS.pDateExp#" cfsqltype="cf_sql_date">
	</cfif>
    </cfif>
    <cfif ARGUMENTS.ptID NEQ 0>
    AND ptID = <cfqueryparam value="#ARGUMENTS.ptID#" cfsqltype="cf_sql_integer">
    </cfif>
    AND pStatus IN (<cfqueryparam value="#ARGUMENTS.pStatus#" list="yes" cfsqltype="cf_sql_integer">)
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsPoll = StructNew()>
    <cfset rsPoll.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsPoll>
    </cffunction>
    
    <cffunction name="getPollQuestionOption" access="public" returntype="query" hint="Get Poll Question Option data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="ID" type="numeric" required="yes" default="0">
    <cfargument name="excludeID" type="numeric" required="yes" default="0">
    <cfargument name="pID" type="numeric" required="yes" default="0">
    <cfargument name="pqoValue" type="string" required="yes" default="">
    <cfargument name="pStatus" type="string" required="yes" default="1">
    <cfargument name="pqoStatus" type="string" required="yes" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="pqoValue">
    <cfset var rsPollQuestionOption = "" >
    <cftry>
    <cfquery name="rsPollQuestionOption" datasource="#application.mcmsDSN#">
    SELECT * FROM v_poll_question_option WHERE 0=0
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(pqoValue) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(pQuestion) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">)
    </cfif>
    <cfif ARGUMENTS.ID NEQ 0>
    AND ID = <cfqueryparam value="#ARGUMENTS.ID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.excludeID NEQ 0>
    AND ID <> <cfqueryparam value="#ARGUMENTS.excludeID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.pID NEQ 0>
    AND pID = <cfqueryparam value="#ARGUMENTS.pID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.pqoValue NEQ "">
    AND pqoValue = <cfqueryparam value="#ARGUMENTS.pqoValue#" cfsqltype="cf_sql_varchar">
    </cfif>
    AND pStatus IN (<cfqueryparam value="#ARGUMENTS.pStatus#" list="yes" cfsqltype="cf_sql_integer">)
    AND pqoStatus IN (<cfqueryparam value="#ARGUMENTS.pqoStatus#" list="yes" cfsqltype="cf_sql_integer">)
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsPollQuestionOption = StructNew()>
    <cfset rsPollQuestionOption.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsPollQuestionOption>
    </cffunction>
    
    <cffunction name="getPollSiteRel" access="public" returntype="query" hint="Get Poll Site Relationship data.">
    <cfargument name="keywords" type="string" required="no" default="All">
    <cfargument name="ID" type="numeric" required="yes" default="0">
    <cfargument name="excludeID" type="numeric" required="yes" default="0">
    <cfargument name="pID" type="string" required="yes" default="0">
    <cfargument name="siteNo" type="string" required="yes" default="100">
    <cfargument name="siteStatus" type="string" required="no" default="1">
    <cfargument name="psrStatus" type="string" required="yes" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="siteNo">
    <cfset var rsPollSiteRel = "" >
    <cftry>
    <cfquery name="rsPollSiteRel" datasource="#application.mcmsDSN#">
    SELECT * FROM v_poll_site_rel WHERE 0=0
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND siteNo LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> 
    </cfif>
    <cfif ARGUMENTS.ID NEQ 0>
    AND ID = <cfqueryparam value="#ARGUMENTS.ID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.excludeID NEQ 0>
    AND ID <> <cfqueryparam value="#ARGUMENTS.excludeID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.pID NEQ 0>
    AND pID IN (<cfqueryparam value="#ARGUMENTS.pID#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    <cfif ARGUMENTS.siteNo NEQ 100>
    AND siteNo IN (<cfqueryparam value="#ARGUMENTS.siteNo#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    AND (siteStatus IN (<cfqueryparam value="#ARGUMENTS.siteStatus#" list="yes" cfsqltype="cf_sql_integer">) OR siteStatus IS NULL)
    AND psrStatus IN (<cfqueryparam value="#ARGUMENTS.psrStatus#" list="yes" cfsqltype="cf_sql_integer">)
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsPollSiteRel = StructNew()>
    <cfset rsPollSiteRel.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsPollSiteRel>
    </cffunction>
    
    <cffunction name="getPollDepartmentRel" access="public" returntype="query" hint="Get Poll Department Relationship data.">
    <cfargument name="keywords" type="string" required="no" default="All">
    <cfargument name="ID" type="numeric" required="yes" default="0">
    <cfargument name="excludeID" type="numeric" required="yes" default="0">
    <cfargument name="pID" type="string" required="yes" default="0">
    <cfargument name="pDateRel" type="string" required="yes" default="">
    <cfargument name="pDateExp" type="string" required="yes" default="">
    <cfargument name="deptNo" type="string" required="yes" default="0">
    <cfargument name="deptStatus" type="string" required="no" default="1">
    <cfargument name="pStatus" type="string" required="yes" default="1,3">
    <cfargument name="pdrStatus" type="string" required="yes" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="deptNo">
	  <cfset var rsPollDepartmentRel = "" >
    <cftry>
    <cfquery name="rsPollDepartmentRel" datasource="#application.mcmsDSN#">
    SELECT * FROM v_poll_department_rel WHERE 0=0
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND deptNo LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> 
    </cfif>
    <cfif ARGUMENTS.ID NEQ 0>
    AND ID = <cfqueryparam value="#ARGUMENTS.ID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.excludeID NEQ 0>
    AND ID <> <cfqueryparam value="#ARGUMENTS.excludeID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.pID NEQ 0>
    AND pID IN (<cfqueryparam value="#ARGUMENTS.pID#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    <cfif ARGUMENTS.pDateRel NEQ "">
    AND pDateRel <= <cfqueryparam value="#ARGUMENTS.pDateRel#" cfsqltype="cf_sql_date">
    </cfif>
    <cfif ARGUMENTS.pDateExp NEQ "">
    AND pDateExp >= <cfqueryparam value="#ARGUMENTS.pDateExp#" cfsqltype="cf_sql_date">
	</cfif>
    <cfif ARGUMENTS.deptNo NEQ 0>
    AND deptNo IN (<cfqueryparam value="#ARGUMENTS.deptNo#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    AND (deptStatus IN (<cfqueryparam value="#ARGUMENTS.deptStatus#" list="yes" cfsqltype="cf_sql_integer">) OR deptStatus IS NULL)
    AND pStatus IN (<cfqueryparam value="#ARGUMENTS.pStatus#" list="yes" cfsqltype="cf_sql_integer">)
    AND pdrStatus IN (<cfqueryparam value="#ARGUMENTS.pdrStatus#" list="yes" cfsqltype="cf_sql_integer">)
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsPollDepartmentRel = StructNew()>
    <cfset rsPollDepartmentRel.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsPollDepartmentRel>
    </cffunction>
    
    <cffunction name="getPollResult" access="public" returntype="query" hint="Get Poll Result data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="ID" type="numeric" required="yes" default="0">
    <cfargument name="excludeID" type="numeric" required="yes" default="0">
    <cfargument name="pID" type="string" required="yes" default="0">
    <cfargument name="prIP" type="string" required="yes" default="0">
    <cfargument name="pName" type="string" required="yes" default="">
    <cfargument name="ptID" type="string" required="yes" default="0">
    <cfargument name="pStatus" type="string" required="yes" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="pName">
    <cfset var rsPollResult = "" >
    <cftry>
    <cfquery name="rsPollResult" datasource="#application.mcmsDSN#">
    SELECT * FROM v_poll_result WHERE 0=0
    <cfif ARGUMENTS.ID NEQ 0>
    AND ID = <cfqueryparam value="#ARGUMENTS.ID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.excludeID NEQ 0>
    AND ID <> <cfqueryparam value="#ARGUMENTS.excludeID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.pID NEQ 0>
    AND pID IN (<cfqueryparam value="#ARGUMENTS.pID#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(pName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(pqoValue) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">)
    </cfif>
    <cfif ARGUMENTS.prIP NEQ 0>
    AND prIP = <cfqueryparam value="#ARGUMENTS.prIP#" cfsqltype="cf_sql_varchar">
    </cfif>
    <cfif ARGUMENTS.pName NEQ "">
    AND UPPER(pName) = <cfqueryparam value="#UCASE(ARGUMENTS.pName)#" cfsqltype="cf_sql_varchar">
    </cfif>
    <cfif ARGUMENTS.ptID NEQ 0>
    AND ptID = <cfqueryparam value="#ARGUMENTS.ptID#" cfsqltype="cf_sql_integer">
    </cfif>
    AND pStatus IN (<cfqueryparam value="#ARGUMENTS.pStatus#" list="yes" cfsqltype="cf_sql_integer">)
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsPollResult = StructNew()>
    <cfset rsPollResult.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsPollResult>
    </cffunction>
    
    <cffunction name="getPollType" access="public" returntype="query" hint="Get Poll Type data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="ID" type="numeric" required="yes" default="0">
    <cfargument name="excludeID" type="numeric" required="yes" default="0">
    <cfargument name="ptStatus" type="string" required="yes" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="ptName">
    <cfset var rsPollType = "" >
    <cftry>
    <cfquery name="rsPollType" datasource="#application.mcmsDSN#">
    SELECT * FROM tbl_poll_type WHERE 0=0
    <cfif ARGUMENTS.ID NEQ 0>
    AND ID = <cfqueryparam value="#ARGUMENTS.ID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.excludeID NEQ 0>
    AND ID <> <cfqueryparam value="#ARGUMENTS.excludeID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND UPPER(ptName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">
    </cfif>
    AND ptStatus IN (<cfqueryparam value="#ARGUMENTS.ptStatus#" list="yes" cfsqltype="cf_sql_integer">)
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsPollType = StructNew()>
    <cfset rsPollType.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsPollType>
    </cffunction>
    
    <cffunction name="getPollReport" access="public" returntype="query" hint="Get Poll Report data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="args" type="string" required="yes" default="0">
    <cfargument name="orderBy" type="string" required="yes" default="pName">
    <cfset var rsPollReport = "" >
    <cftry>
    <cfquery name="rsPollReport" datasource="#application.mcmsDSN#">
    SELECT pName As Name, pQuestion As Question, ptName As Type, TO_CHAR(pDateRel,'MM/DD/YYYY') As Release_Date, TO_CHAR(pDateExp,'MM/DD/YYYY') As Exp_Date, netName As Network, pip AS IP_Address, sName As Status FROM v_poll WHERE 0=0
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(pName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(pQuestion) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">)
    </cfif>
    <cfif ARGUMENTS.args NEQ 0>
    <cfif ListGetAt(ARGUMENTS.args, 1) NEQ 0>
    AND pDateRel >= <cfqueryparam value="#ListGetAt(ARGUMENTS.args, 1)#" list="yes" cfsqltype="cf_sql_date">
    </cfif>
    <cfif ListGetAt(ARGUMENTS.args, 2) NEQ 0>
    AND pDateExp <= <cfqueryparam value="#ListGetAt(ARGUMENTS.args, 2)#" list="yes" cfsqltype="cf_sql_date">
    </cfif>
    </cfif>
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsPollReport = StructNew()>
    <cfset rsPollReport.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsPollReport>
    </cffunction>
    
    <cffunction name="getPollQuestionOptionReport" access="public" returntype="query" hint="Get Poll Question Option Report data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="orderBy" type="string" required="yes" default="pqoValue">
    <cfset var rsPollQuestionOptionReport = "" >
    <cftry>
    <cfquery name="rsPollQuestionOptionReport" datasource="#application.mcmsDSN#">
    SELECT pqoValue As Value, pName As Poll, pQuestion As Question, sName As Status FROM v_poll_question_option WHERE 0=0
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(pqoValue) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(pName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">)
    </cfif>
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsPollQuestionOptionReport = StructNew()>
    <cfset rsPollQuestionOptionReport.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsPollQuestionOptionReport>
    </cffunction>
    
    <cffunction name="getPollTypeReport" access="public" returntype="query" hint="Get Poll Type Report data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="orderBy" type="string" required="yes" default="ttName">
    <cfset var rsPollTypeReport = "" >
    <cftry>
    <cfquery name="rsPollTypeReport" datasource="#application.mcmsDSN#">
    SELECT ptName FROM tbl_poll_type WHERE 0=0
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND UPPER(ptName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">
    </cfif>
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsPollTypeReport = StructNew()>
    <cfset rsPollTypeReport.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsPollTypeReport>
    </cffunction>
    
    <cffunction name="setPollResult" access="public" returntype="string" hint="Set Poll Result data.">
    <cfargument name="pID" type="string" required="yes" default="0">
    <cfsavecontent variable="poll">
    <cfinvoke 
    component="MCMS.component.app.poll.Poll"
    method="getPollResult"
    returnvariable="getPollResultRet">
    <cfinvokeargument name="pID" value="#ARGUMENTS.pID#"/>
    <cfinvokeargument name="pStatus" value="1,3"/>
    <cfinvokeargument name="orderBy" value="pqoSort"/>
    </cfinvoke>
    <cfquery name="pollQuestionOption" dbtype="query"> 
    SELECT pqoID, pqoValue FROM getPollResultRet
    GROUP BY pqoID, pqoValue
    ORDER BY pqoSort, pqoValue
    </cfquery>
    <table id="mainTableAlt">
    <cfloop query="pollQuestionOption">
    <cfquery name="pollQuestionOptionCount" dbtype="query"> 
    SELECT count(pqoID) As Total FROM getPollResultRet
    WHERE pqoID = <cfqueryparam value="#pqoID#" cfsqltype="cf_sql_numeric">
    </cfquery>
    <cfset percentage = (pollQuestionOptionCount.Total / getPollResultRet.recordcount)* 100>
    <cfset percentage = NumberFormat(percentage, "99")>
    <tr>
    <td><cfoutput>#pqoValue#:&nbsp;#percentage#%</cfoutput></td>
    </tr>
    </cfloop>
    </table>
    </cfsavecontent>
    <cfreturn poll> 
    </cffunction>
    
    <cffunction name="insertPoll" access="public" returntype="struct">
    <cfargument name="pName" type="string" required="yes">
    <cfargument name="pQuestion" type="string" required="yes">
    <cfargument name="pDateRel" type="string" required="yes">
    <cfargument name="pDateExp" type="string" required="yes">
    <cfargument name="netID" type="numeric" required="yes">
    <cfargument name="pip" type="string" required="yes">
    <cfargument name="ptID" type="numeric" required="yes">>
    <cfargument name="pStatus" type="numeric" required="yes">
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
    <cfinvokeargument name="profanityString" value="#ARGUMENTS.pQuestion#"/>
    </cfinvoke>
    <!---Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.app.poll.Poll"
    method="getPoll"
    returnvariable="getCheckPollRet">
    <cfinvokeargument name="pName" value="#ARGUMENTS.pName#"/>
    <cfinvokeargument name="pStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckPollRet.recordcount NEQ 0>
    <cfset result.message = "The name #ARGUMENTS.pName# already exists, please enter a new name.">
    <cfelseif regexProfanityRet CONTAINS '$%&*!'>
    <cfset result.message = "Some text contained profanity, please remove any profanity from your text.">
    <!---Check length restriction.--->
    <cfelseif LEN(ARGUMENTS.pQuestion) GT 512>
    <cfset result.message = "The description is longer than 512 characters, please enter a new description under 512 characters.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    INSERT INTO tbl_poll (pName,pQuestion,pDateRel,pDateExp,netID,pip,ptID,pStatus) VALUES
    (
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.pName#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.pQuestion#">,
    <cfqueryparam cfsqltype="cf_sql_date" value="#ARGUMENTS.pDateRel#">,
    <cfqueryparam cfsqltype="cf_sql_date" value="#ARGUMENTS.pDateExp#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.netID#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.pip#">,
     <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ptID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.pStatus#">
    )
    </cfquery>
    </cftransaction>
    <!---Get the pID just added.--->
    <cfinvoke 
    component="MCMS.component.app.poll.Poll"
    method="getPoll"
    returnvariable="getPollIDRet">
    <cfinvokeargument name="pName" value="#ARGUMENTS.pName#"/>
    <cfinvokeargument name="pStatus" value="1,2,3"/>
    </cfinvoke>
    <cfset this.pID = getPollIDRet.ID>
    <!---Create site relationships.--->
    <cfloop index="siteNo" list="#ARGUMENTS.siteNo#">
    <cfinvoke 
    component="MCMS.component.app.poll.Poll"
    method="insertPollSiteRel"
    returnvariable="insertPollSiteRelRet">
    <cfinvokeargument name="pID" value="#this.pID#"/>
    <cfinvokeargument name="siteNo" value="#siteNo#"/>
    <cfinvokeargument name="psrStatus" value="1"/>
    </cfinvoke>
    </cfloop>
    <!---Create department relationships.--->
    <cfloop index="deptNo" list="#ARGUMENTS.deptNo#">
    <cfinvoke 
    component="MCMS.component.app.poll.Poll"
    method="insertPollDepartmentRel"
    returnvariable="insertPollDepartmentRelRet">
    <cfinvokeargument name="pID" value="#this.pID#"/>
    <cfinvokeargument name="deptNo" value="#deptNo#"/>
    <cfinvokeargument name="pdrStatus" value="1"/>
    </cfinvoke>
    </cfloop>
    </cfif>
    <cfcatch type="any">
    <cfset result.message = "There was an error inserting the record.">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="insertPollQuestionOption" access="public" returntype="struct">
    <cfargument name="pID" type="numeric" required="yes">
    <cfargument name="pqoValue" type="string" required="yes">
    <cfargument name="pqoSort" type="numeric" required="yes">
    <cfargument name="pqoStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully inserted the record.">
    <cftry>
    <!---Check for profanity in the text.--->
    <cfinvoke 
    component="MCMS.component.utility.Regex"
    method="regexProfanity"
    returnvariable="regexProfanityRet">
    <cfinvokeargument name="profanityString" value="#ARGUMENTS.pqoValue#"/>
    </cfinvoke>
    <!---Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.app.poll.Poll"
    method="getPollQuestionOption"
    returnvariable="getCheckPollQuestionOptionRet">
    <cfinvokeargument name="pID" value="#ARGUMENTS.pID#"/>
    <cfinvokeargument name="pqoValue" value="#ARGUMENTS.pqoValue#"/>
    <cfinvokeargument name="pqoStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckPollQuestionOptionRet.recordcount NEQ 0>
    <cfset result.message = "The value #ARGUMENTS.pqoValue# already exists, please enter a new value.">
    <cfelseif regexProfanityRet CONTAINS '$%&*!'>
    <cfset result.message = "Some text contained profanity, please remove any profanity from your text.">
    <!---Check length restriction.--->
    <cfelseif LEN(ARGUMENTS.pqoValue) GT 64>
    <cfset result.message = "The value is longer than 64 characters, please enter a new value under 64 characters.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    INSERT INTO tbl_poll_question_option (pID,pqoValue,pqoSort,pqoStatus) VALUES
    (
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.pID#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.pqoValue#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.pqoSort#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.pqoStatus#">
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
    
    <cffunction name="insertPollSiteRel" access="public" returntype="struct">
    <cfargument name="pID" type="numeric" required="yes">
    <cfargument name="siteNo" type="numeric" required="yes">
    <cfargument name="psrStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully inserted the record.">
    <cftry>
    <!---Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.app.poll.Poll"
    method="getPollSiteRel"
    returnvariable="getCheckPollSiteRelRet">
    <cfinvokeargument name="pID" value="#ARGUMENTS.pID#"/>
    <cfinvokeargument name="siteNo" value="#ARGUMENTS.siteNo#"/>
    <cfinvokeargument name="psrStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckPollSiteRelRet.recordcount NEQ 0>
    <cfset result.message = "The poll site relationship already exists, please try again.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    INSERT INTO tbl_poll_site_rel (pID,siteNo,psrStatus) VALUES
    (
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.pID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.siteNo#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.psrStatus#">
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
    
    <cffunction name="insertPollDepartmentRel" access="public" returntype="struct">
    <cfargument name="pID" type="numeric" required="yes">
    <cfargument name="deptNo" type="numeric" required="yes">
    <cfargument name="pdrStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully inserted the record.">
    <cftry>
    <!---Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.app.poll.Poll"
    method="getPollDepartmentRel"
    returnvariable="getCheckPollDepartmentRelRet">
    <cfinvokeargument name="pID" value="#ARGUMENTS.pID#"/>
    <cfinvokeargument name="deptNo" value="#ARGUMENTS.deptNo#"/>
    <cfinvokeargument name="pdrStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckPollDepartmentRelRet.recordcount NEQ 0>
    <cfset result.message = "The poll department relationship already exists, please try again.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    INSERT INTO tbl_poll_department_rel (pID,deptNo,pdrStatus) VALUES
    (
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.pID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.deptNo#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.pdrStatus#">
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
    
    <cffunction name="insertPollResult" access="public" returntype="struct">
    <cfargument name="pID" type="string" required="yes">
    <cfargument name="pqoID" type="string" required="yes">
    <cfargument name="siteNo" type="numeric" required="yes">
    <cfargument name="prIp" type="string" required="yes">
    <cfargument name="prStatus" type="numeric" required="yes">
    <cfset result.message = "Thank you for your vote.">
    <cftry>
    <cflock name="pollLock" timeout="3">
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    INSERT INTO tbl_poll_result (pID,pqoID,siteNo,prIp,prStatus) VALUES
    (
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.pID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.pqoID#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.siteNo#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.prIp#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.prStatus#">
    )
    </cfquery>
    </cftransaction>
    </cflock>
    <cfcatch type="any">
    <cfset result.message = "There was an error inserting the record.">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="updatePoll" access="public" returntype="struct">
    <cfargument name="ID" type="numeric" required="yes">
    <cfargument name="pName" type="string" required="yes">
    <cfargument name="pQuestion" type="string" required="yes">
    <cfargument name="pDateRel" type="string" required="yes">
    <cfargument name="pDateExp" type="string" required="yes">
    <cfargument name="netID" type="numeric" required="yes">
    <cfargument name="pip" type="string" required="yes">
    <cfargument name="ptID" type="numeric" required="yes">>
    <cfargument name="pStatus" type="numeric" required="yes">
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
    <cfinvokeargument name="profanityString" value="#ARGUMENTS.pQuestion#"/>
    </cfinvoke>
    <!---Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.app.poll.Poll"
    method="getPoll"
    returnvariable="getCheckPollRet">
    <cfinvokeargument name="excludeID" value="#ARGUMENTS.ID#"/>
    <cfinvokeargument name="pName" value="#ARGUMENTS.pName#"/>
    <cfinvokeargument name="pStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckPollRet.recordcount NEQ 0>
    <cfset result.message = "The name #ARGUMENTS.pName# already exists, please enter a new name.">
    <cfelseif regexProfanityRet CONTAINS '$%&*!'>
    <cfset result.message = "Some text contained profanity, please remove any profanity from your text.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_poll SET
    pName = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.pName#">,
    pQuestion = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.pQuestion#">,
    pDateRel = <cfqueryparam cfsqltype="cf_sql_date" value="#ARGUMENTS.pDateRel#">,
    pDateExp = <cfqueryparam cfsqltype="cf_sql_date" value="#ARGUMENTS.pDateExp#">,
    netID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.netID#">,
    pip = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.pip#">,
    ptID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ptID#">,
    pStatus = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.pStatus#">
    WHERE ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ID#">
    </cfquery>
    </cftransaction>
    <!---Delete any existing relationships.--->
    <cfinvoke 
    component="MCMS.component.app.poll.Poll"
    method="deletePollSiteRel"
    returnvariable="deletePollSiteRelRet">
    <cfinvokeargument name="pID" value="#ARGUMENTS.ID#"/>
    </cfinvoke>
    <cfinvoke 
    component="MCMS.component.app.poll.Poll"
    method="deletePollDepartmentRel"
    returnvariable="deletePollDepartmentRelRet">
    <cfinvokeargument name="pID" value="#ARGUMENTS.ID#"/>
    </cfinvoke>
    <!---Create site relationships.--->
    <cfloop index="siteNo" list="#ARGUMENTS.siteNo#">
    <cfinvoke 
    component="MCMS.component.app.poll.Poll"
    method="insertPollSiteRel"
    returnvariable="insertDailyBulletinSiteRelRet">
    <cfinvokeargument name="pID" value="#ARGUMENTS.ID#"/>
    <cfinvokeargument name="siteNo" value="#siteNo#"/>
    <cfinvokeargument name="psrStatus" value="1"/>
    </cfinvoke>
    </cfloop>
    <!---Create department relationships.--->
    <cfloop index="deptNo" list="#ARGUMENTS.deptNo#">
    <cfinvoke 
    component="MCMS.component.app.poll.Poll"
    method="insertPollDepartmentRel"
    returnvariable="insertPollDepartmentRelRet">
    <cfinvokeargument name="pID" value="#ARGUMENTS.ID#"/>
    <cfinvokeargument name="deptNo" value="#deptNo#"/>
    <cfinvokeargument name="pdrStatus" value="1"/>
    </cfinvoke>
    </cfloop>
    </cfif>
    <cfcatch type="any">
    <cfset result.message = "There was an error updating the record.">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="updatePollQuestionOption" access="public" returntype="struct">
    <cfargument name="ID" type="numeric" required="yes">
    <cfargument name="pID" type="numeric" required="yes">
    <cfargument name="pqoValue" type="string" required="yes">
    <cfargument name="pqoSort" type="numeric" required="yes">
    <cfargument name="pqoStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully updated the record.">
    <cftry>
    <!---Check for profanity in the text.--->
    <cfinvoke 
    component="MCMS.component.utility.Regex"
    method="regexProfanity"
    returnvariable="regexProfanityRet">
    <cfinvokeargument name="profanityString" value="#ARGUMENTS.pqoValue#"/>
    </cfinvoke>
    <!---Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.app.poll.Poll"
    method="getPollQuestionOption"
    returnvariable="getCheckPollQuestionOptionRet">
    <cfinvokeargument name="excludeID" value="#ARGUMENTS.ID#"/>
    <cfinvokeargument name="pID" value="#ARGUMENTS.pID#"/>
    <cfinvokeargument name="pqoValue" value="#ARGUMENTS.pqoValue#"/>
    <cfinvokeargument name="pqoStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckPollQuestionOptionRet.recordcount NEQ 0>
    <cfset result.message = "The value #ARGUMENTS.pqoValue# already exists, please enter a new value.">
    <cfelseif regexProfanityRet CONTAINS '$%&*!'>
    <cfset result.message = "Some text contained profanity, please remove any profanity from your text.">
    <!---Check length restriction.--->
    <cfelseif LEN(ARGUMENTS.pqoValue) GT 64>
    <cfset result.message = "The value is longer than 64 characters, please enter a new value under 64 characters.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_poll_question_option SET
    pID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.pID#">,
    pqoValue = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.pqoValue#">,
    pqoSort = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.pqoSort#">,
    pqoStatus = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.pqoStatus#">
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
    
    <cffunction name="updatePollList" access="public" returntype="struct">
    <cfargument name="ID" type="numeric" required="yes">
    <cfargument name="pStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully updated the records.">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_poll SET
    pStatus = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.pStatus#">
    WHERE ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ID#">
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error updating the records.">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="updatePollQuestionOptionList" access="public" returntype="struct">
    <cfargument name="ID" type="numeric" required="yes">
    <cfargument name="pqoStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully updated the records.">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_poll_question_option SET
    pqoStatus = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.pqoStatus#">
    WHERE ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ID#">
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error updating the records.">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="deletePoll" access="public" returntype="struct">
    <cfargument name="ID" type="string" required="yes">
    <cfset result.message = "You have successfully deleted the record(s).">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    DELETE FROM tbl_poll
    WHERE ID IN (<cfqueryparam cfsqltype="cf_sql_integer" list="yes" value="#ARGUMENTS.ID#">)
    </cfquery>
    </cftransaction>
    <cfinvoke 
    component="MCMS.component.app.poll.Poll"
    method="deletePollQuestionOption"
    returnvariable="deletePollQuestionOptionRet">
    <cfinvokeargument name="pID" value="#ARGUMENTS.ID#"/>
    </cfinvoke>
    <cfinvoke 
    component="MCMS.component.app.poll.Poll"
    method="deletePollSiteRel"
    returnvariable="deletePollSiteRelRet">
    <cfinvokeargument name="pID" value="#ARGUMENTS.ID#"/>
    </cfinvoke>
    <cfinvoke 
    component="MCMS.component.app.poll.Poll"
    method="deletePollDepartmentRel"
    returnvariable="deletePollDepartmentRelRet">
    <cfinvokeargument name="pID" value="#ARGUMENTS.ID#"/>
    </cfinvoke>
    <cfcatch type="any">
    <cfset result.message = "There was an error deleting the record(s).">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="deletePollQuestionOption" access="public" returntype="struct">
    <cfargument name="ID" type="string" required="yes" default="0">
    <cfargument name="pID" type="numeric" required="yes" default="0">
    <cfset result.message = "You have successfully deleted the record(s).">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    DELETE FROM tbl_poll_question_option
    WHERE ID IN (<cfqueryparam cfsqltype="cf_sql_integer" list="yes" value="#ARGUMENTS.ID#">)
    OR pID = <cfqueryparam value="#ARGUMENTS.pID#" cfsqltype="cf_sql_integer">
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error deleting the record(s).">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>  
    
    <cffunction name="deletePollSiteRel" access="public" returntype="struct">
    <cfargument name="ID" type="string" required="yes" default="0">
    <cfargument name="pID" type="string" required="yes" default="0">
    <cfset result.message = "You have successfully deleted the record(s).">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    DELETE FROM tbl_poll_site_rel
    WHERE ID IN (<cfqueryparam cfsqltype="cf_sql_integer" list="yes" value="#ARGUMENTS.ID#">)
    OR pID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.pID#">
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error deleting the record(s).">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction> 
    
    <cffunction name="deletePollDepartmentRel" access="public" returntype="struct">
    <cfargument name="ID" type="string" required="yes" default="0">
    <cfargument name="pID" type="string" required="yes" default="0">
    <cfset result.message = "You have successfully deleted the record(s).">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    DELETE FROM tbl_poll_department_rel
    WHERE ID IN (<cfqueryparam cfsqltype="cf_sql_integer" list="yes" value="#ARGUMENTS.ID#">)
    OR pID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.pID#">
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error deleting the record(s).">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction> 
</cfcomponent>