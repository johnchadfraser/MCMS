<cfcomponent>
    <cffunction name="getScheduleTask" access="public" returntype="query" hint="Get Schedule Task data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="ID" type="numeric" required="yes" default="0">
    <cfargument name="excludeID" type="numeric" required="yes" default="0">
    <cfargument name="stName" type="string" required="yes" default="">
    <cfargument name="sttID" type="string" required="yes" default="0">
    <cfargument name="stStatus" type="string" required="yes" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="stName">
    <cfset var rsScheduleTask = "" >
    <cftry>
    <cfquery name="rsScheduleTask" datasource="#application.mcmsDSN#">
    SELECT * FROM v_schedule_task WHERE 0=0
    <cfif ARGUMENTS.ID NEQ 0>
    AND ID = <cfqueryparam value="#ARGUMENTS.ID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.excludeID NEQ 0>
    AND ID <> <cfqueryparam value="#ARGUMENTS.excludeID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(stName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(stDescription) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">)
    </cfif>
    <cfif ARGUMENTS.stName NEQ "">
    AND UPPER(stName) = <cfqueryparam value="#UCASE(ARGUMENTS.stName)#" cfsqltype="cf_sql_varchar">
    </cfif>
    <cfif ARGUMENTS.sttID NEQ 0>
    AND sttID = <cfqueryparam value="#ARGUMENTS.sttID#" cfsqltype="cf_sql_integer">
    </cfif>
    AND stStatus IN (<cfqueryparam value="#ARGUMENTS.stStatus#" list="yes" cfsqltype="cf_sql_integer">)
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsScheduleTask = StructNew()>
    <cfset rsScheduleTask.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsScheduleTask>
    </cffunction>
    
    <cffunction name="getScheduleTaskType" access="public" returntype="query" hint="Get Schedule Task Type data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="ID" type="numeric" required="yes" default="0">
    <cfargument name="excludeID" type="numeric" required="yes" default="0">
    <cfargument name="sttStatus" type="string" required="yes" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="sttName">
    <cfset var rsScheduleTaskType = "" >
    <cftry>
    <cfquery name="rsScheduleTaskType" datasource="#application.mcmsDSN#">
    SELECT * FROM v_schedule_task_type WHERE 0=0
    <cfif ARGUMENTS.ID NEQ 0>
    AND ID = <cfqueryparam value="#ARGUMENTS.ID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.excludeID NEQ 0>
    AND ID <> <cfqueryparam value="#ARGUMENTS.excludeID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND UPPER(sttName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">
    </cfif>
    AND sttStatus IN (<cfqueryparam value="#ARGUMENTS.sttStatus#" list="yes" cfsqltype="cf_sql_integer">)
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsScheduleTaskType = StructNew()>
    <cfset rsScheduleTaskType.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsScheduleTaskType>
    </cffunction>
    
    <cffunction name="getScheduleTaskReport" access="public" returntype="query" hint="Get Schedule Task Report data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="orderBy" type="string" required="yes" default="stName">
    <cfset var rsScheduleTaskReport = "" >
    <cftry>
    <cfquery name="rsScheduleTaskReport" datasource="#application.mcmsDSN#">
    SELECT stName, stDescription FROM v_schedule_task WHERE 0=0
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(stName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(stDescription) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">)
    </cfif>
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsScheduleTaskReport = StructNew()>
    <cfset rsScheduleTaskReport.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsScheduleTaskReport>
    </cffunction>
    
    <cffunction name="getScheduleTaskTypeReport" access="public" returntype="query" hint="Get Schedule Task Type Report data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="orderBy" type="string" required="yes" default="sttName">
    <cfset var rsScheduleTaskTypeReport = "" >
    <cftry>
    <cfquery name="rsScheduleTaskTypeReport" datasource="#application.mcmsDSN#">
    SELECT sttName FROM v_schedule_task_type WHERE 0=0
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND UPPER(sttName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">
    </cfif>
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsScheduleTaskTypeReport = StructNew()>
    <cfset rsScheduleTaskTypeReport.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsScheduleTaskTypeReport>
    </cffunction>
    
    <cffunction name="insertScheduleTask" access="public" returntype="struct">
    <cfargument name="stName" type="string" required="yes">
    <cfargument name="stDescription" type="string" required="yes">
    <cfargument name="stURL" type="string" required="yes">
    <cfargument name="stComponent" type="string" required="yes">
    <cfargument name="stMethod" type="string" required="yes">
    <cfargument name="stDateRel" type="date" required="yes">
    <cfargument name="stDateExp" type="date" required="yes">
    <cfargument name="stTimeStart" type="string" required="yes">
    <cfargument name="stInterval" type="date" required="yes">
    <cfargument name="stTimeout" type="numeric" required="yes">
    <cfargument name="sttID" type="numeric" required="yes">
    <cfargument name="stStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully inserted the record.">
    <cftry>
    <!---Check for profanity in the text.--->
    <cfinvoke 
    component="MCMS.component.utility.Regex"
    method="regexProfanity"
    returnvariable="regexProfanityRet">
    <cfinvokeargument name="profanityString" value="#ARGUMENTS.stDescription#"/>
    </cfinvoke>
    <!---Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.app.schedule_manager.ScheduleManager"
    method="getScheduleTask"
    returnvariable="getCheckScheduleTaskRet">
    <cfinvokeargument name="stName" value="#ARGUMENTS.stName#"/>
    <cfinvokeargument name="stStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckScheduleTaskRet.recordcount NEQ 0>
    <cfset result.message = "The name #ARGUMENTS.stName# already exists, please enter a new name.">
    <cfelseif regexProfanityRet CONTAINS '$%&*!'>
    <cfset result.message = "Some text contained profanity, please remove any profanity from your text.">
    <!---Check length restriction.--->
    <cfelseif LEN(ARGUMENTS.stDescription) GT 1048>
    <cfset result.message = "The description is longer than 1048 characters, please enter a new description under 1048 characters.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    INSERT INTO tbl_schedule_task (stName,stDescription,stURL,stComponent,stMethod,stDateRel,stDateExp,stTimeStart,sttID,userID,stStatus) VALUES
    (
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.stName#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.stDescription#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.stURL#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.stComponent#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.stMethod#">,
    <cfqueryparam cfsqltype="cf_sql_date" value="#ARGUMENTS.stDateRel#">,
    <cfqueryparam cfsqltype="cf_sql_date" value="#ARGUMENTS.stDateExp#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.stTimeStart#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.stInterval#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.stTimeout#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.sttID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#session.userID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.stStatus#">
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
    
    <cffunction name="updateScheduleTask" access="public" returntype="struct">
    <cfargument name="ID" type="numeric" required="yes">
    <cfargument name="stName" type="string" required="yes">
    <cfargument name="stDescription" type="string" required="yes">
    <cfargument name="stURL" type="string" required="yes">
    <cfargument name="stComponent" type="string" required="yes">
    <cfargument name="stMethod" type="string" required="yes">
    <cfargument name="stDateRel" type="date" required="yes">
    <cfargument name="stDateExp" type="date" required="yes">
    <cfargument name="stTimeStart" type="string" required="yes">
    <cfargument name="stInterval" type="date" required="yes">
    <cfargument name="stTimeout" type="numeric" required="yes">
    <cfargument name="sttID" type="numeric" required="yes">
    <cfargument name="stStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully updated the record.">
    <cftry>
    <!---Check for profanity in the text.--->
    <cfinvoke 
    component="MCMS.component.utility.Regex"
    method="regexProfanity"
    returnvariable="regexProfanityRet">
    <cfinvokeargument name="profanityString" value="#ARGUMENTS.stDescription#"/>
    </cfinvoke>
    <!---Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.app.schedule_manager.ScheduleManager"
    method="getScheduleTask"
    returnvariable="getCheckScheduleTaskRet">
    <cfinvokeargument name="excludeID" value="#ARGUMENTS.ID#"/>
    <cfinvokeargument name="stName" value="#ARGUMENTS.stName#"/>
    <cfinvokeargument name="stStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckScheduleTaskRet.recordcount NEQ 0>
    <cfset result.message = "The name #ARGUMENTS.stName# already exists, please enter a new name.">
    <cfelseif regexProfanityRet CONTAINS '$%&*!'>
    <cfset result.message = "Some text contained profanity, please remove any profanity from your text.">
    <!---Check length restriction.--->
    <cfelseif LEN(ARGUMENTS.stDescription) GT 1048>
    <cfset result.message = "The description is longer than 1048 characters, please enter a new description under 1048 characters.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_schedule_task SET
    stName = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.stName#">,
    stDescription = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.stDescription#">,
    stURL = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.stURL#">,
    stComponent = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.stComponent#">,
    stMethod = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.stMethod#">,
    stDateRel = <cfqueryparam cfsqltype="cf_sql_date" value="#ARGUMENTS.stDateRel#">,
    stDateExp = <cfqueryparam cfsqltype="cf_sql_date" value="#ARGUMENTS.stDateExp#">,
    stTimeStart = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.stTimeStart#">,
    stInterval = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.stInterval#">,
    stTimeout = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.stTimeout#">,
    sttID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.sttID#">,
    userID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.userID#">,
    stDate = <cfqueryparam cfsqltype="cf_sql_date" value="#Now()#">,
    stStatus = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.stStatus#">
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
    
    <cffunction name="updateScheduleTaskList" access="public" returntype="struct">
    <cfargument name="ID" type="numeric" required="yes">
    <cfargument name="stStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully updated the records.">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_schedule_task SET
    stStatus = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.stStatus#">
    WHERE ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ID#">
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error updating the records.">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="deleteScheduleTask" access="public" returntype="struct">
    <cfargument name="ID" type="string" required="yes">
    <cfset result.message = "You have successfully deleted the record(s).">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    DELETE FROM tbl_schedule_task
    WHERE ID IN (<cfqueryparam cfsqltype="cf_sql_integer" list="yes" value="#ARGUMENTS.ID#">)
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error deleting the record(s).">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="setScheduleTask" access="public" returntype="struct">
    <cfargument name="ID" type="string" required="yes">
    <cfset result.message = "You have successfully scheduled the task.">
    <cftry>
    <!---Get the Scheduled Task by ID.--->
    <cfinvoke 
    component="MCMS.component.app.schedule_manager.ScheduleManager"
    method="getScheduleTask"
    returnvariable="getScheduleTaskRet">
    <cfinvokeargument name="ID" value="#ARGUMENTS.ID#"/>
    <cfinvokeargument name="stStatus" value="1"/>
    </cfinvoke>
    <cfset this.action = 'update'>
    <cfset this.task = getScheduleTaskRet.stName>
    <cfset this.URL = "#getScheduleTaskRet.stURL#/cfc/#getScheduleTaskRet.stComponent#/">
    <cfset this.startDate = getScheduleTaskRet.stDateStart>
    <cfset this.endDate = getScheduleTaskRet.stDateExp>
    <cfset this.startTime = getScheduleTaskRet.stTimeStart>
    <!---
    http://localhost:8306/#application.mcmsAppAdminPath#/tasks/report/cache/?component=admin.report.custom.company_dashboard.cfc.conversion&method=getConversionBySite,getConversionAllSites&args=none
    <cfschedule 
    action="update" 
    task="#local.scheduleID#" 
    operation="httprequest" 
    url="http://#Replace(CGI.SERVER_NAME, 'extranet', 'newsletter', 'ALL')#:#application.newsletterServerEmailPort#/newsletter/schedule_manager.cfm?scheduleID=#local.scheduleID#&startRow=#local.startRow#&endRow=#local.endRow#&siteNo=#ARGUMENTS.siteNo#&subStateProv=#ARGUMENTS.subStateProv#&subZipCode=#ARGUMENTS.subZipCode#&subTelArea=#ARGUMENTS.subTelArea#&iID=#ARGUMENTS.iID#&nID=#ARGUMENTS.nID#&testBlast=#ARGUMENTS.testBlast#" 
    startdate="#local.scheduleDate#"
    enddate="#local.scheduleDate#"
    starttime="#local.scheduleTime#"
    interval="once"
    requesttimeout="#local.timeOut#"
    >
	--->
    <cfcatch type="any">
    <cfset result.message = "There was an error scheduling the task.">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>   
</cfcomponent>