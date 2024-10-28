<cfcomponent>
<cffunction name="getBuildManager" access="public" returntype="query" hint="Get Build Manager data.">
<cfargument name="keywords" type="string" required="yes" default="All">
<cfargument name="ID" type="numeric" required="yes" default="0">
<cfargument name="excludeID" type="numeric" required="yes" default="0">
<cfargument name="bmsName" type="string" required="yes" default="">
<cfargument name="bmsID" type="numeric" required="yes" default="0">
<cfargument name="bmTicketNo" type="numeric" required="yes" default="0">
<cfargument name="bmRevisionNo" type="numeric" required="yes" default="0">
<cfargument name="bmaID" type="string" required="yes" default="0">
<cfargument name="bmaIDFilter" type="string" required="yes" default="0">
<cfargument name="userID" type="string" required="yes" default="0">
<cfargument name="bmStatus" type="string" required="yes" default="1,3">
<cfargument name="orderBy" type="string" required="yes" default="bmsName">
<cfset var rsBuildManager = "" >
<cftry>
<cfquery name="rsBuildManager" datasource="#application.mcmsDSN#">
SELECT * FROM v_build_manager WHERE 0=0
<cfif ARGUMENTS.ID NEQ 0>
AND ID = <cfqueryparam value="#ARGUMENTS.ID#" cfsqltype="cf_sql_integer">
</cfif>
<cfif ARGUMENTS.excludeID NEQ 0>
AND ID <> <cfqueryparam value="#ARGUMENTS.excludeID#" cfsqltype="cf_sql_integer">
</cfif>
<cfif ARGUMENTS.keywords NEQ 'All'>
<cfloop list="#ARGUMENTS.keywords#" delimiters=" " index="kw">
AND (UPPER(bmsName) LIKE <cfqueryparam value="%#UCASE(kw)#%" cfsqltype="cf_sql_varchar"> OR UPPER(bmsDescription) LIKE <cfqueryparam value="%#UCASE(kw)#%" cfsqltype="cf_sql_varchar">)
</cfloop>
</cfif>
<cfif ARGUMENTS.bmsName NEQ "">
AND UPPER(bmsName) = <cfqueryparam value="#UCASE(ARGUMENTS.bmsName)#" cfsqltype="cf_sql_varchar">
</cfif>
<cfif ARGUMENTS.bmsID NEQ 0>
AND bmsID = <cfqueryparam value="#ARGUMENTS.bmsID#" cfsqltype="cf_sql_integer">
</cfif>
<cfif ARGUMENTS.bmTicketNo NEQ 0>
AND bmTicketNo = <cfqueryparam value="#ARGUMENTS.bmTicketNo#" cfsqltype="cf_sql_integer">
</cfif>
<cfif ARGUMENTS.bmRevisionNo NEQ 0>
AND bmRevisionNo = <cfqueryparam value="#ARGUMENTS.bmRevisionNo#" cfsqltype="cf_sql_integer">
</cfif>
<cfif ARGUMENTS.bmaID NEQ 0>
AND bmaID = <cfqueryparam value="#ARGUMENTS.bmaID#" cfsqltype="cf_sql_integer">
</cfif>
<cfif ARGUMENTS.bmaIDFilter NEQ 0>
AND bmaID <> <cfqueryparam value="#ARGUMENTS.bmaIDFilter#" cfsqltype="cf_sql_integer">
</cfif>
<cfif ARGUMENTS.userID NEQ 0>
AND (bmDeveloperUserID = <cfqueryparam value="#ARGUMENTS.userID#" cfsqltype="cf_sql_integer"> OR bmDeployerUserID = <cfqueryparam value="#ARGUMENTS.userID#" cfsqltype="cf_sql_integer"> OR bmDatabaseUserID = <cfqueryparam value="#ARGUMENTS.userID#" cfsqltype="cf_sql_integer"> OR bmSystemUserID = <cfqueryparam value="#ARGUMENTS.userID#" cfsqltype="cf_sql_integer"> OR bmProjectUserID = <cfqueryparam value="#ARGUMENTS.userID#" cfsqltype="cf_sql_integer"> OR bmTestUserID = <cfqueryparam value="#ARGUMENTS.userID#" cfsqltype="cf_sql_integer">)
</cfif>
AND bmStatus IN (<cfqueryparam value="#ARGUMENTS.bmStatus#" list="yes" cfsqltype="cf_sql_integer">)
ORDER BY #ARGUMENTS.orderBy#
</cfquery>
<!---Catch any errors.--->
<cfcatch type="any">
<cfset rsBuildManager = StructNew()>
<cfset rsBuildManager.message = "There was an error with the query.">

</cfcatch>
</cftry>
<cfreturn rsBuildManager>
</cffunction>

<cffunction name="getBuildManagerAction" access="public" returntype="query" hint="Get Build Manager Action data.">
<cfargument name="keywords" type="string" required="yes" default="All">
<cfargument name="ID" type="numeric" required="yes" default="0">
<cfargument name="excludeID" type="numeric" required="yes" default="0">
<cfargument name="bmaName" type="string" required="yes" default="">
<cfargument name="bmaStatus" type="string" required="yes" default="1,3">
<cfargument name="orderBy" type="string" required="yes" default="bmaSort,bmaName">
<cfset var rsBuildManagerAction = "" >
<cftry>
<cfquery name="rsBuildManagerAction" datasource="#application.mcmsDSN#">
SELECT * FROM v_build_manager_action WHERE 0=0
<cfif ARGUMENTS.ID NEQ 0>
AND ID = <cfqueryparam value="#ARGUMENTS.ID#" cfsqltype="cf_sql_integer">
</cfif>
<cfif ARGUMENTS.excludeID NEQ 0>
AND ID <> <cfqueryparam value="#ARGUMENTS.excludeID#" cfsqltype="cf_sql_integer">
</cfif>
<cfif ARGUMENTS.keywords NEQ 'All'>
<cfloop list="#ARGUMENTS.keywords#" delimiters=" " index="kw">
AND (UPPER(bmaName) LIKE <cfqueryparam value="%#UCASE(kw)#%" cfsqltype="cf_sql_varchar"> OR UPPER(bmaDescription) LIKE <cfqueryparam value="%#UCASE(kw)#%" cfsqltype="cf_sql_varchar">)
</cfloop>
</cfif>
<cfif ARGUMENTS.bmaName NEQ "">
AND UPPER(bmaName) = <cfqueryparam value="#UCASE(ARGUMENTS.bmaName)#" cfsqltype="cf_sql_varchar">
</cfif>
AND bmaStatus IN (<cfqueryparam value="#ARGUMENTS.bmaStatus#" list="yes" cfsqltype="cf_sql_integer">)
ORDER BY #ARGUMENTS.orderBy#
</cfquery>
<!---Catch any errors.--->
<cfcatch type="any">
<cfset rsBuildManagerAction = StructNew()>
<cfset rsBuildManagerAction.message = "There was an error with the query.">

</cfcatch>
</cftry>
<cfreturn rsBuildManagerAction>
</cffunction>

<cffunction name="getBuildManagerUserAction" access="public" returntype="query" hint="Get Build Manager User Action data.">
<cfargument name="keywords" type="string" required="yes" default="All">
<cfargument name="ID" type="numeric" required="yes" default="0">
<cfargument name="excludeID" type="numeric" required="yes" default="0">
<cfargument name="bmuaName" type="string" required="yes" default="">
<cfargument name="bmuaStatus" type="string" required="yes" default="1,3">
<cfargument name="orderBy" type="string" required="yes" default="bmuaSort,bmuaName">
<cfset var rsBuildManagerUserAction = "" >
<cftry>
<cfquery name="rsBuildManagerUserAction" datasource="#application.mcmsDSN#">
SELECT * FROM v_build_manager_user_action WHERE 0=0
<cfif ARGUMENTS.ID NEQ 0>
AND ID = <cfqueryparam value="#ARGUMENTS.ID#" cfsqltype="cf_sql_integer">
</cfif>
<cfif ARGUMENTS.excludeID NEQ 0>
AND ID <> <cfqueryparam value="#ARGUMENTS.excludeID#" cfsqltype="cf_sql_integer">
</cfif>
<cfif ARGUMENTS.keywords NEQ 'All'>
<cfloop list="#ARGUMENTS.keywords#" delimiters=" " index="kw">
AND (UPPER(bmuaName) LIKE <cfqueryparam value="%#UCASE(kw)#%" cfsqltype="cf_sql_varchar"> OR UPPER(bmuaDescription) LIKE <cfqueryparam value="%#UCASE(kw)#%" cfsqltype="cf_sql_varchar">)
</cfloop>
</cfif>
<cfif ARGUMENTS.bmuaName NEQ "">
AND UPPER(bmuaName) = <cfqueryparam value="#UCASE(ARGUMENTS.bmuaName)#" cfsqltype="cf_sql_varchar">
</cfif>
AND bmuaStatus IN (<cfqueryparam value="#ARGUMENTS.bmuaStatus#" list="yes" cfsqltype="cf_sql_integer">)
ORDER BY #ARGUMENTS.orderBy#
</cfquery>
<!---Catch any errors.--->
<cfcatch type="any">
<cfset rsBuildManagerUserAction = StructNew()>
<cfset rsBuildManagerUserAction.message = "There was an error with the query.">

</cfcatch>
</cftry>
<cfreturn rsBuildManagerUserAction>
</cffunction>

<cffunction name="getBuildManagerActionFilter" access="public" returntype="query" hint="Get Build Manager Action Filter data.">
<cfargument name="ID" type="string" required="yes" default="0">
<cfargument name="byPass" type="string" required="yes" default="false">
<cfargument name="bmaStatus" type="string" required="yes" default="1,3">
<cfargument name="orderBy" type="string" required="yes" default="bmaSort, bmaName">
<cfset var rsBuildManagerActionFilter = "" >
<cftry>
<cfset this.bmaList = '1,2'>
<!---Determine which actions should be displayed based on build manager action.--->
<cfswitch expression="#ARGUMENTS.ID#">
<cfcase value="1" delimiters=",">
<cfset this.bmaList = '1,2,10'>
</cfcase>
<cfcase value="2" delimiters=",">
<cfset this.bmaList = '2,3,4'>
</cfcase>
<cfcase value="3" delimiters=",">
<cfset this.bmaList = '3,4,10'>
</cfcase>
<cfcase value="4" delimiters=",">
<cfset this.bmaList = '3,4,10'>
</cfcase>
<cfcase value="5" delimiters=",">
<cfset this.bmaList = '5,6,9,11,12'>
</cfcase>
<cfcase value="6" delimiters=",">
<cfset this.bmaList = '6,7,13'>
</cfcase>
<cfcase value="7" delimiters=",">
<cfset this.bmaList = '7,8'>
</cfcase>
<cfcase value="8" delimiters=",">
<cfset this.bmaList = '8,14'>
</cfcase>
<cfcase value="9" delimiters=",">
<cfset this.bmaList = '9,11,14'>
</cfcase>
<cfcase value="10" delimiters=",">
<cfset this.bmaList = '2,10,14'>
</cfcase>
<cfcase value="11" delimiters=",">
<cfset this.bmaList = '3,4,6,9,11'>
</cfcase>
<cfcase value="12" delimiters=",">
<cfset this.bmaList = '8,12,13'>
</cfcase>
<cfcase value="13" delimiters=",">
<cfset this.bmaList = '2,10,13,14'>
</cfcase>
<cfcase value="14" delimiters=",">
<cfset this.bmaList = '14'>
</cfcase>
</cfswitch>
<cfquery name="rsBuildManagerActionFilter" datasource="#application.mcmsDSN#">
SELECT * FROM v_build_manager_action WHERE 0=0
<cfif this.bmaList EQ 0>
AND ID = <cfqueryparam value="#this.bmaList#" cfsqltype="cf_sql_integer">
</cfif>
<cfif ARGUMENTS.byPass NEQ 'true'>
AND ID IN (<cfqueryparam value="#this.bmaList#" list="yes" cfsqltype="cf_sql_integer">)
</cfif>
AND bmaStatus IN (<cfqueryparam value="#ARGUMENTS.bmaStatus#" list="yes" cfsqltype="cf_sql_integer">)
ORDER BY #ARGUMENTS.orderBy#
</cfquery>
<!---Catch any errors.--->
<cfcatch type="any">
<cfset rsBuildManagerActionFilter = StructNew()>
<cfset rsBuildManagerActionFilter.message = "There was an error with the query.">

</cfcatch>
</cftry>
<cfreturn rsBuildManagerActionFilter>
</cffunction>

<cffunction name="getBuildManagerUserActionFilter" access="public" returntype="query" hint="Get Build Manager User Action Filter data.">
<cfargument name="bmuName" type="string" required="yes" default="Deployer" hint="Member name">
<cfargument name="bmaID" type="numeric" required="yes" default="0">
<cfargument name="byPass" type="string" required="yes" default="false">
<cfargument name="bmuaStatus" type="string" required="yes" default="1,3">
<cfargument name="orderBy" type="string" required="yes" default="bmuaSort, bmuaName">
<cfset var rsBuildManagerUserActionFilter = "" >
<cftry>
<cfset this.bmuaList = '0'>
<!---Determine which actions should be displayed based on build manager action.--->
<cfswitch expression="#ARGUMENTS.bmuName#">
<cfcase value="Developer" delimiters=",">
<cfset this.bmuaList = '1,2,3,4,5,6'>
</cfcase>
<cfcase value="Deployer" delimiters=",">
<cfset this.bmuaList = '1,2,3,4,5,6'>
</cfcase>
<cfcase value="Test" delimiters=",">
<cfset this.bmuaList = '1,2,5'>
</cfcase>
<cfcase value="Database" delimiters=",">
<cfif ARGUMENTS.bmaID EQ 4>
<cfset this.bmuaList = '1,2,4'>
<cfelseif ARGUMENTS.bmaID EQ 6>
<cfset this.bmuaList = '1,2,3'>
<cfelse>
<cfset this.bmuaList = '1,2,3,4'>
</cfif>
</cfcase>
<cfcase value="System" delimiters=",">
<cfif ARGUMENTS.bmaID EQ 4>
<cfset this.bmuaList = '1,2,4'>
<cfelseif ARGUMENTS.bmaID EQ 6>
<cfset this.bmuaList = '1,2,3'>
<cfelse>
<cfset this.bmuaList = '1,2,3,4'>
</cfif>
</cfcase>
</cfswitch>
<cfquery name="rsBuildManagerUserActionFilter" datasource="#application.mcmsDSN#">
SELECT * FROM v_build_manager_user_action WHERE 0=0
<cfif this.bmuaList EQ 0>
AND ID = <cfqueryparam value="#this.bmuaList#" cfsqltype="cf_sql_integer">
</cfif>
<cfif ARGUMENTS.byPass NEQ 'true'>
AND ID IN (<cfqueryparam value="#this.bmuaList#" list="yes" cfsqltype="cf_sql_integer">)
</cfif>
AND bmuaStatus IN (<cfqueryparam value="#ARGUMENTS.bmuaStatus#" list="yes" cfsqltype="cf_sql_integer">)
ORDER BY #ARGUMENTS.orderBy#
</cfquery>
<!---Catch any errors.--->
<cfcatch type="any">
<cfset rsBuildManagerUserActionFilter = StructNew()>
<cfset rsBuildManagerUserActionFilter.message = "There was an error with the query.">

</cfcatch>
</cftry>
<cfreturn rsBuildManagerUserActionFilter>
</cffunction>

<cffunction name="setBuildManagerSchedule" access="public" returntype="struct" hint="Set the build schedule based on the date and time and schedule build status.">
<cfargument name="bmID" type="numeric" required="yes" default="0">
<cfargument name="bmaID" type="numeric" required="yes" default="0">
<cfargument name="bmDateRel" type="string" required="yes" default="">
<cfargument name="bmTimeRel" type="string" required="yes" default="">
<cfargument name="userID" type="numeric" required="yes" default="0">
<cfargument name="bmScheduleStatus" type="numeric" required="yes" default="0">
<cfset result.message = ''>
<cfset result.logMessage = ''>
<cftry>
<!---Schedule the build.--->
<cfset bmaIDScheduleList = '1,2,4,5,6,7'>
<cfif ARGUMENTS.bmScheduleStatus EQ 1 AND ListContains(bmaIDScheduleList, ARGUMENTS.bmaID)>
<cfschedule 
action="update"
task="build_#ARGUMENTS.bmID#" 
operation="httprequest" 
url="http://#CGI.HTTP_HOST#/MCMS/task/schedule/?mcmsBuild=true&bmID=#ARGUMENTS.bmID#&bmaID=#ARGUMENTS.bmaID#&userID=#ARGUMENTS.userID#" 
startdate="#ARGUMENTS.bmDateRel#"
starttime="#ARGUMENTS.bmTimeRel#"
interval="once"
requesttimeout="360"
>
<cfset result.logMessage = 'The build_#ARGUMENTS.bmID# schedule has been modified.'>
<cfelse>
<!---Check to see if the task exists to delete it.--->
<cfschedule action="list" mode="server" result="schedule">
<cfif ListContains(ValueList(schedule.task), 'build_#ARGUMENTS.bmID#')>
<!---Delete the schedule.--->
<cfschedule 
action="delete"
task="build_#ARGUMENTS.bmID#" 
onexception=""
>
<cfset result.logMessage = ''>
</cfif>  
</cfif>    
<!---Insert Log record.--->
<cfif result.logMessage NEQ ''>
<cfinvoke 
component="/#application.mcmsAppAdminPath#/build_manager/component/BuildManager"
method="insertBuildManagerLog"
>
<cfinvokeargument name="bmID" value="#ARGUMENTS.bmID#"/>
<cfinvokeargument name="userID" value="#session.userID#"/>
<cfinvokeargument name="bmlLog" value="#result.logMessage#"/>
<cfinvokeargument name="bmltID" value="6"/>
<cfinvokeargument name="bmaID" value="#ARGUMENTS.bmaID#"/>
</cfinvoke>
<cfset result.message = result.logMessage>
</cfif>
<!---Catch any errors.--->
<cfcatch type="any">
<cfset result = StructNew()>
<cfset result.message = "There was an error with the query.">

</cfcatch>
</cftry>
<cfreturn result>
</cffunction>

<cffunction name="setBuildManagerPipeline" access="public" returntype="struct" hint="Return Build Manager pipeline results. This acts as a handler to control actions based on the build action status">
<cfargument name="bmID" type="numeric" required="yes" default="0">
<cfargument name="bmaID" type="numeric" required="yes" default="0">
<cfargument name="bmaIDTemp" type="numeric" required="yes" default="0" hint="Used to determine log messaging based on a change.">
<cfargument name="bmuaID" type="numeric" required="yes" default="0">
<cfargument name="bmuaIDTemp" type="numeric" required="yes" default="0" hint="Used to determine log messaging based on a change.">

<cfset result = StructNew()>

<!---Create rules to prevent emails and log records to be created when certain statuses have not changed. Use the bypass var to control processing actions below.--->
<cfset this.bypass = false>
<!---If the status has not changed for the build then bypass.--->
<cfif ARGUMENTS.bmaID EQ ARGUMENTS.bmaIDTemp>
<cfset this.bypass = true>
</cfif>

<!---If a test user action is recorded.--->
<cfif ARGUMENTS.bmuaID NEQ ARGUMENTS.bmuaIDTemp>
<cfset this.bypass = false>
</cfif>


<cfif this.bypass EQ false>
<!---Set default parameters.--->
<!---Default build and email values.--->
<cfset result.message = 'Build Manager pipeline action completed.'>

<cfset result.emailSubject = 'Build Manager'>
<cfset result.toEmail = session.userEmail>
<cfset result.fromEmail = session.userEmail>
<cfset result.ccEmail = ''>
<cfset result.logMessage = 'Action Status Changed.'>
<cfset result.emailBody = ''>
<cfset result.emailBodyOverride = ''>

<cfset result.testEmail = ''>
<cfset result.projectEmail = ''>
<cfset result.developerEmail = application.webmasterEmail>
<cfset result.databaseEmail = ''>
<cfset result.systemEmail = ''>
<cfset result.deployerEmail = ''>

<cfset result.currentActionStatusName = ''>
<cfset result.newActionStatusName = ''>
<cfset result.currentUserActionName = 'N/A'>

<!---Get each status name for the log message.--->
<cfinvoke 
component="/#application.mcmsAppAdminPath#/build_manager/component/BuildManager"
method="getBuildManagerAction"
returnvariable="getCurrentBuildManagerRet">
<cfinvokeargument name="ID" value="#ARGUMENTS.bmaIDTemp#"/>
<cfinvokeargument name="bmaStatus" value="1"/>
</cfinvoke>
<cfset result.currentActionStatusName = getCurrentBuildManagerRet.bmaName>

<cfinvoke 
component="/#application.mcmsAppAdminPath#/build_manager/component/BuildManager"
method="getBuildManagerAction"
returnvariable="getNewBuildManagerActionRet">
<cfinvokeargument name="ID" value="#ARGUMENTS.bmaID#"/>
<cfinvokeargument name="bmaStatus" value="1"/>
</cfinvoke>
<cfset result.newActionStatusName = getNewBuildManagerActionRet.bmaName>

<cftry>
<!---Get the Build Manager data.--->
<cfinvoke 
component="/#application.mcmsAppAdminPath#/build_manager/component/BuildManager"
method="getBuildManager"
returnvariable="getBuildManagerRet">
<cfinvokeargument name="ID" value="#ARGUMENTS.bmID#"/>
<cfinvokeargument name="bmStatus" value="1"/>
</cfinvoke>

<!---Create email groups.--->
<cfset result.testEmail = getBuildManagerRet.userEmailTest>
<cfset result.projectEmail = getBuildManagerRet.userEmailProject>
<cfset result.developerEmail = getBuildManagerRet.userEmailDeveloper>
<cfset result.databaseEmail = getBuildManagerRet.userEmailDatabase>
<cfset result.systemEmail = getBuildManagerRet.userEmailSystem>
<cfset result.deployerEmail = getBuildManagerRet.userEmailDeployer>

<!---Create CC groups based on status.--->
<cfset result.pendingCCEmail = '#result.deployerEmail#;'>
<cfset result.readyCCEmail = '#result.deployerEmail#;#result.testEmail#;#result.projectEmail#'>

<cfset result.approvedCCEmail = '#result.deployerEmail#;#result.testEmail#;#result.projectEmail#;'>
<cfset result.rollbackRequestCCEmail = '#result.deployerEmail#;#result.testEmail#;#result.projectEmail#'>
<cfset result.rollbackCCEmail = '#result.deployerEmail#;#result.testEmail#;#result.projectEmail#'>
<cfset result.rollbackCompleteCCEmail = '#result.deployerEmail#;#result.testEmail#;#result.projectEmail#'>
<cfset result.notApprovedCCEmail = '#result.deployerEmail#;#result.testEmail#;#result.projectEmail#'>
<cfset result.deployedCCEmail = '#result.deployerEmail#;#result.testEmail#;#result.projectEmail#'>
<cfset result.deployCompleteCCEmail = '#result.deployerEmail#;#result.testEmail#;#result.projectEmail#'>
<cfset result.cancelledCCEmail = '#result.deployerEmail#;#result.testEmail#;#result.projectEmail#'>
<cfset result.deployTestingCCEmail = '#result.deployerEmail#;#result.testEmail#;#result.projectEmail#'>
<cfset result.rollbackTestingCCEmail = '#result.deployerEmail#;#result.testEmail#;#result.projectEmail#'>
<cfset result.errorCCEmail = '#result.deployerEmail#;'>
<cfset result.closedCCEmail = '#result.deployerEmail#;#result.projectEmail#'>

<!---If there is a Database User.--->
<cfif result.databaseEmail NEQ ''>
<cfset result.approvedCCEmail = result.databaseEmail & ';' & result.approvedCCEmail>
<cfset result.rollbackRequestCCEmail = result.databaseEmail & ';' & result.rollbackRequestCCEmail>
<cfset result.rollbackCCEmail = result.databaseEmail & ';' & result.rollbackCCEmail>
<cfset result.rollbackCompleteCCEmail = result.databaseEmail & ';' & result.rollbackCompleteCCEmail>
</cfif>

<!---If there is a System User.--->
<cfif result.systemEmail NEQ ''>
<cfset result.approvedCCEmail = result.systemEmail & ';' & result.approvedCCEmail>
<cfset result.rollbackRequestCCEmail = result.systemEmail & ';' & result.rollbackRequestCCEmail>
<cfset result.rollbackCCEmail = result.systemEmail & ';' & result.rollbackCCEmail>
<cfset result.rollbackCompleteCCEmail = result.systemEmail & ';' & result.rollbackCompleteCCEmail>
</cfif>

<!---If a database user is required.--->
<cfif getBuildManagerRet.bmDatabaseUserID EQ session.userID AND ARGUMENTS.bmaID EQ 4 AND ARGUMENTS.bmuaID EQ 4>
<!---Set a unique message for the email body when it required a database task.--->
<cfset result.emailBodyOverride = '#session.userName# has completed database tasks for this build.'>
<!---Set a unique subject status name if a database task was completed.--->
<cfset result.newActionStatusName = 'Database Tasks Completed'>
</cfif>

<!---If a system user is required.--->
<cfif getBuildManagerRet.bmSystemUserID EQ session.userID AND ARGUMENTS.bmaID EQ 4 AND ARGUMENTS.bmuaID EQ 4>
<!---Set a unique message for the email body when it required a system task.--->
<cfset result.emailBodyOverride = '#session.userName# has completed system tasks for this build.'>
<!---Set a unique subject status name if a system task was completed.--->
<cfset result.newActionStatusName = 'System Tasks Completed'>
</cfif>

<!---If a database user is required.--->
<cfif getBuildManagerRet.bmDatabaseUserID EQ session.userID AND ARGUMENTS.bmaID EQ 6 AND ARGUMENTS.bmuaID EQ 3>
<!---Set a unique message for the email body when it required a database task.--->
<cfset result.emailBodyOverride = '#session.userName# has completed database rollback request tasks for this build.'>
<!---Set a unique subject status name if a database task was completed.--->
<cfset result.newActionStatusName = 'Database Rollback Request Tasks Completed'>
</cfif>

<!---If a system user is required.--->
<cfif getBuildManagerRet.bmSystemUserID EQ session.userID AND ARGUMENTS.bmaID EQ 6 AND ARGUMENTS.bmuaID EQ 3>
<!---Set a unique message for the email body when it required a system task.--->
<cfset result.emailBodyOverride = '#session.userName# has completed system rollback request tasks for this build.'>
<!---Set a unique subject status name if a system task was completed.--->
<cfset result.newActionStatusName = 'System Rollback Request Tasks Completed'>
</cfif>

<!---If a deployment is deferred.--->
<cfif getBuildManagerRet.bmTestUserID EQ session.userID AND ARGUMENTS.bmaID EQ 11 AND ARGUMENTS.bmuaID EQ 2>
<!---Set a unique message for the email body when it required a database task.--->
<cfset result.emailBodyOverride = '#session.userName# has completed testing tasks for this build and found it unstable requiring a possible rollback. Review notes for more information.'>
<!---Set a unique subject status name if a database task was completed.--->
<cfset result.newActionStatusName = 'Testing - Deferred'>
</cfif>

<cfif ARGUMENTS.bmuaID NEQ 0>
<!---Get user action status name for the log message.--->
<cfinvoke 
component="/#application.mcmsAppAdminPath#/build_manager/component/BuildManager"
method="getBuildManagerUserAction"
returnvariable="getCurrentBuildManagerUserActionRet">
<cfinvokeargument name="ID" value="#ARGUMENTS.bmuaID#"/>
<cfinvokeargument name="bmuaStatus" value="1"/>
</cfinvoke> 
<cfset result.currentUserActionName = getCurrentBuildManagerUserActionRet.bmuaName>
</cfif>

<cfswitch expression="#ARGUMENTS.bmaID#">
<cfdefaultcase></cfdefaultcase>

<cfcase value="1">
<!---Actions for "Pending".--->
<cfset result.emailSubject = 'Build Manager - #UCASE(result.newActionStatusName)# - Build No. #getBuildManagerRet.ID#'>
<cfset result.toEmail = result.developerEmail>
<cfset result.fromEmail = result.fromEmail>
<cfset result.ccEmail = result.pendingCCEmail>
<cfset result.emailBody = 'This build has been set to pending action by #session.userName#.'>
<cfset result.emailBody = Iif(result.emailBodyOverride EQ '', DE(result.emailBody), DE(result.emailBodyOverride))>
<cfif ARGUMENTS.bmuaID NEQ ARGUMENTS.bmuaIDTemp>
<cfset result.logMessage = 'The user action has been updated to #result.currentUserActionName# by #session.userUsername#.'>
<cfelse>
<cfset result.logMessage = 'Action status was changed from #result.currentActionStatusName# to #result.newActionStatusName#.'>
</cfif>
</cfcase>

<cfcase value="2">
<!---Actions for "Ready".--->
<cfset result.emailSubject = 'Build Manager - #UCASE(result.newActionStatusName)# - Build No. #getBuildManagerRet.ID#'>
<cfset result.toEmail = result.developerEmail>
<cfset result.fromEmail = result.fromEmail>
<cfset result.ccEmail = result.readyCCEmail>
<cfset result.emailBody = 'This build has been set to ready action by #session.userName#.'>
<cfset result.emailBody = Iif(result.emailBodyOverride EQ '', DE(result.emailBody), DE(result.emailBodyOverride))>
<cfif ARGUMENTS.bmuaID NEQ ARGUMENTS.bmuaIDTemp>
<cfset result.logMessage = 'The user action has been updated to #result.currentUserActionName# by #session.userUsername#.'>
<cfelse>
<cfset result.logMessage = 'Action status was changed from #result.currentActionStatusName# to #result.newActionStatusName#.'>
</cfif>
</cfcase>

<cfcase value="3">
<!---Actions for "Not Approved".--->
<cfset result.emailSubject = 'Build Manager - #UCASE(result.newActionStatusName)# - Build No. #getBuildManagerRet.ID#'>
<!---Determine which email address to send the request.--->
<cfset result.toEmail = result.developerEmail>
<cfset result.fromEmail = result.fromEmail>
<cfset result.emailBody = 'The build was not approved by #session.userName#.'>
<cfset result.emailBody = Iif(result.emailBodyOverride EQ '', DE(result.emailBody), DE(result.emailBodyOverride))>
<cfset result.ccEmail = result.notApprovedCCEmail>
<cfif ARGUMENTS.bmuaID NEQ ARGUMENTS.bmuaIDTemp>
<cfset result.logMessage = 'The user action has been updated to #result.currentUserActionName# by #session.userUsername#.'>
<cfelse>
<cfset result.logMessage = 'Action status was changed from #result.currentActionStatusName# to #result.newActionStatusName#.'>
</cfif>
</cfcase>

<cfcase value="4">
<!---Actions for "Approved".--->
<cfset result.emailSubject = 'Build Manager - #UCASE(result.newActionStatusName)# - Build No. #getBuildManagerRet.ID#'>
<!---Determine which email address to send the request.--->
<cfset result.toEmail = result.developerEmail>
<cfset result.fromEmail = result.fromEmail>
<cfset result.ccEmail = result.approvedCCEmail>
<cfset result.emailBody = 'The build was approved by #session.userName#.'>
<cfset result.emailBody = Iif(result.emailBodyOverride EQ '', DE(result.emailBody), DE(result.emailBodyOverride))>
<cfif ARGUMENTS.bmuaID NEQ ARGUMENTS.bmuaIDTemp>
<cfset result.logMessage = 'The user action has been updated to #result.currentUserActionName# by #session.userUsername#.'>
<cfelse>
<cfset result.logMessage = 'Action status was changed from #result.currentActionStatusName# to #result.newActionStatusName#.'>
</cfif>
</cfcase>

<cfcase value="5">
<!---Actions for "Deployed".--->
<cfset result.emailSubject = 'Build Manager - #UCASE(result.newActionStatusName)# - Build No. #getBuildManagerRet.ID#'>
<!---Determine which email address to send the request.--->
<cfset result.toEmail = result.developerEmail>
<cfset result.fromEmail = result.fromEmail>
<cfset result.ccEmail = result.deployedCCEmail>
<cfset result.emailBody = 'The build was deployed by #session.userName#.'>
<cfset result.emailBody = Iif(result.emailBodyOverride EQ '', DE(result.emailBody), DE(result.emailBodyOverride))>
<cfset result.logMessage = 'Action status was changed from #result.currentActionStatusName# to #result.newActionStatusName#.'>
</cfcase>

<cfcase value="6">
<!---Actions for "Rollback Request".--->
<cfset result.emailSubject = 'Build Manager - #UCASE(result.newActionStatusName)# - Build No. #getBuildManagerRet.ID#'>
<!---Determine which email address to send the request.--->
<cfset result.toEmail = result.developerEmail>
<cfset result.fromEmail = result.fromEmail>
<cfset result.ccEmail = result.rollbackRequestCCEmail>
<cfset result.emailBody = 'The build has a rolled-back request from #session.userName#.'>
<cfset result.emailBody = Iif(result.emailBodyOverride EQ '', DE(result.emailBody), DE(result.emailBodyOverride))>
<cfset result.logMessage = 'Action status was changed from #result.currentActionStatusName# to #result.newActionStatusName#.'>
</cfcase>

<cfcase value="7">
<!---Actions for "Rollback".--->
<cfset result.emailSubject = 'Build Manager- #UCASE(result.newActionStatusName)# - Build No. #getBuildManagerRet.ID#'>
<!---Determine which email address to send the request.--->
<cfset result.toEmail = result.developerEmail>
<cfset result.fromEmail = result.fromEmail>
<cfset result.ccEmail = result.rollbackCCEmail>
<cfset result.emailBody = 'The build has been rolled-back by #session.userName#.'>
<cfset result.emailBody = Iif(result.emailBodyOverride EQ '', DE(result.emailBody), DE(result.emailBodyOverride))>
<cfset result.logMessage = 'Action status was changed from #result.currentActionStatusName# to #result.newActionStatusName#.'>
</cfcase>

<cfcase value="8">
<!---Actions for "Rollback Complete".--->
<cfset result.emailSubject = 'Build Manager- #UCASE(result.newActionStatusName)# - Build No. #getBuildManagerRet.ID#'>
<!---Determine which email address to send the request.--->
<cfset result.toEmail = result.developerEmail>
<cfset result.fromEmail = result.fromEmail>
<cfset result.ccEmail = result.rollbackCompleteCCEmail>
<cfset result.emailBody = 'The build has been rolled-back completed by #session.userName#.'>
<cfset result.emailBody = Iif(result.emailBodyOverride EQ '', DE(result.emailBody), DE(result.emailBodyOverride))>
<cfset result.logMessage = 'Action status was changed from #result.currentActionStatusName# to #result.newActionStatusName#.'>
</cfcase>

<cfcase value="9">
<!---Actions for "Deploy Completed".--->
<cfset result.emailSubject = 'Build Manager- #UCASE(result.newActionStatusName)# - Build No. #getBuildManagerRet.ID#'>
<!---Determine which email address to send the request.--->
<cfset result.toEmail = result.developerEmail>
<cfset result.fromEmail = result.fromEmail>
<cfset result.ccEmail = result.deployCompleteCCEmail>
<cfset result.emailBody = 'The build has been deploy completed by #session.userName#.'>
<cfset result.emailBody = Iif(result.emailBodyOverride EQ '', DE(result.emailBody), DE(result.emailBodyOverride))>
<cfset result.logMessage = 'Action status was changed from #result.currentActionStatusName# to #result.newActionStatusName#.'>
</cfcase>

<cfcase value="10">
<!---Actions for "Cancelled".--->
<cfset result.emailSubject = 'Build Manager- #UCASE(result.newActionStatusName)# - Build No. #getBuildManagerRet.ID#'>
<!---Determine which email address to send the request.--->
<cfset result.toEmail = result.developerEmail>
<cfset result.fromEmail = result.fromEmail>
<cfset result.ccEmail = result.cancelledCCEmail>
<cfset result.emailBody = 'The build has been cancelled by #session.userName#.'>
<cfset result.emailBody = Iif(result.emailBodyOverride EQ '', DE(result.emailBody), DE(result.emailBodyOverride))>
<cfset result.logMessage = 'Action status was changed from #result.currentActionStatusName# to #result.newActionStatusName#.'>
</cfcase>

<cfcase value="11">
<!---Actions for "Deploy Testing".--->
<cfset result.emailSubject = 'Build Manager- #UCASE(result.newActionStatusName)# - Build No. #getBuildManagerRet.ID#'>
<!---Determine which email address to send the request.--->
<cfset result.toEmail = result.developerEmail>
<cfset result.fromEmail = result.fromEmail>
<cfset result.ccEmail = result.deployTestingCCEmail>
<cfset result.emailBody = 'The build has been updated to deploy testing by #session.userName#.'>
<cfset result.emailBody = Iif(result.emailBodyOverride EQ '', DE(result.emailBody), DE(result.emailBodyOverride))>
<cfset result.logMessage = 'Action status was changed from #result.currentActionStatusName# to #result.newActionStatusName#.'>
</cfcase>

<cfcase value="12">
<!---Actions for "Rollback Testing".--->
<cfset result.emailSubject = 'Build Manager- #UCASE(result.newActionStatusName)# - Build No. #getBuildManagerRet.ID#'>
<!---Determine which email address to send the request.--->
<cfset result.toEmail = result.developerEmail>
<cfset result.fromEmail = result.fromEmail>
<cfset result.ccEmail = result.rollbackTestingCCEmail>
<cfset result.emailBody = 'The build has been updated to rollback testing by #session.userName#.'>
<cfset result.emailBody = Iif(result.emailBodyOverride EQ '', DE(result.emailBody), DE(result.emailBodyOverride))>
<cfset result.logMessage = 'Action status was changed from #result.currentActionStatusName# to #result.newActionStatusName#.'>
</cfcase>

<cfcase value="13">
<!---Actions for "Error".--->
<cfset result.emailSubject = 'Build Manager- #UCASE(result.newActionStatusName)# - Build No. #getBuildManagerRet.ID#'>
<!---Determine which email address to send the request.--->
<cfset result.toEmail = result.developerEmail>
<cfset result.fromEmail = result.fromEmail>
<cfset result.ccEmail = result.errorCCEmail>
<cfset result.emailBody = 'The build has been updated to error by #session.userName#.'>
<cfset result.emailBody = Iif(result.emailBodyOverride EQ '', DE(result.emailBody), DE(result.emailBodyOverride))>
<cfset result.logMessage = 'Action status was changed from #result.currentActionStatusName# to #result.newActionStatusName#.'>
</cfcase>

<cfcase value="14">
<!---Actions for "Closed".--->
<cfset result.emailSubject = 'Build Manager- #UCASE(result.newActionStatusName)# - Build No. #getBuildManagerRet.ID#'>
<!---Determine which email address to send the request.--->
<cfset result.toEmail = result.developerEmail>
<cfset result.fromEmail = result.fromEmail>
<cfset result.ccEmail = result.closedCCEmail>
<cfset result.emailBody = 'The build has been updated to closed by #session.userName#.'>
<cfset result.emailBody = Iif(result.emailBodyOverride EQ '', DE(result.emailBody), DE(result.emailBodyOverride))>
<cfset result.logMessage = 'Action status was changed from #result.currentActionStatusName# to #result.newActionStatusName#.'>
</cfcase>

</cfswitch>

<!---Insert Log record.--->
<cfinvoke 
component="/#application.mcmsAppAdminPath#/build_manager/component/BuildManager"
method="insertBuildManagerLog"
>
<cfinvokeargument name="bmID" value="#ARGUMENTS.bmID#"/>
<cfinvokeargument name="userID" value="#session.userID#"/>
<cfinvokeargument name="bmlLog" value="#result.logMessage#"/>
<cfinvokeargument name="bmltID" value="1"/>
<cfinvokeargument name="bmaID" value="#ARGUMENTS.bmaID#"/>
</cfinvoke>

<!--- Send email notifications. --->
<cfif result.toEmail NEQ ''>
<cfinvoke 
component="MCMS.component.Email"
method="sendEmail">
<cfinvokeargument name="subject" value="#result.emailSubject#"/>
<cfinvokeargument name="to" value="#result.toEmail#"/>
<cfinvokeargument name="from" value="#result.fromEmail#"/>
<cfinvokeargument name="cc" value="#result.ccEmail#"/>
<cfinvokeargument name="body" value="#result.emailBody#"/>
<cfinvokeargument name="ID" value="#ARGUMENTS.bmID#"/>
<cfinvokeargument name="emailTemplate" value="/#application.mcmsAppAdminPath#/build_manager/view/inc_build_manager_email_template.cfm"/>
</cfinvoke>
</cfif>

<!---Catch any errors.--->
<cfcatch type="any">
<cfset result = StructNew()>
<cfset result.message = "There was an error with the query.">

</cfcatch>
</cftry>
</cfif>
<cfreturn result>
</cffunction>

<cffunction name="setBuildActionStatus" access="public" returntype="any" hint="Set the status for Build Manager action based on current Build Action.">
<cfargument name="bmID" type="numeric" required="yes" default="0">
<cfargument name="bmaID" type="numeric" required="yes" default="0">
<cfargument name="bmaName" type="string" required="yes" default="Pending">
<cfargument name="bmDeveloperUserID" type="numeric" required="yes" default="0">
<cfargument name="bmProjectUserID" type="numeric" required="yes" default="0">
<cfargument name="bmTestUserID" type="numeric" required="yes" default="0">
<cfargument name="bmuaTestID" type="numeric" required="yes" default="0">
<cfargument name="bmDatabaseUserID" type="numeric" required="yes" default="0">
<cfargument name="bmuaDatabaseID" type="numeric" required="yes" default="0">
<cfargument name="bmSystemUserID" type="numeric" required="yes" default="0">
<cfargument name="bmuaSystemID" type="numeric" required="yes" default="0">
<cfargument name="bmDeployerUserID" type="numeric" required="yes" default="0">
<cfargument name="bmuaDeployerID" type="numeric" required="yes" default="0">
<cfargument name="bmScheduleStatus" type="numeric" required="yes" default="0">

<cfset result = ''>
<cftry>
<!--<cfform> DO NOT REMOVE-->
<cfsilent>
<!---Determine which Action is available.--->
<cfinvoke 
component="/#application.mcmsAppAdminPath#/build_manager/component/BuildManager"
method="getBuildManagerActionFilter"
returnvariable="getBuildManagerActionFilterRet">
<cfinvokeargument name="ID" value="#ARGUMENTS.bmaID#"/>
<cfinvokeargument name="bmaStatus" value="1"/>
</cfinvoke>
</cfsilent>

<cfset var.showActionStatusMenu = 'false'>
<cfset var.showActionStatusMessage = 'false'>
<cfset var.showActionStatusMessageAlt = 'false'>
<cfset var.actionStatusMessage = ''>
<cfset var.actionStatusMessageAlt = ''>

<cfset codeBlock = ''>

<cfsavecontent variable="result">
<cfswitch expression="#bmaID#">

<!---PENDING--->
<cfcase value="1">
<!---Only a Developer can change a Pending status.--->
<cfif ARGUMENTS.bmDeveloperUserID EQ session.userID>
<cfset var.showActionStatusMenu = 'true'>
<cfset var.showActionStatusMessage = 'true'>
<cfset var.showActionStatusMessageAlt = 'false'>
<cfelse>
<cfset var.showActionStatusMenu = 'false'>
<cfset var.showActionStatusMessage = 'false'>
<cfset var.showActionStatusMessageAlt = 'true'>
</cfif>
<!---Messaging for this action status.--->
<cfset var.actionStatusMessage = "
<span id='bmStatusInformation'>
To begin sending email notifications to members of this build for build approval, update the action status to 'Ready'.
</span>
">
<cfset var.actionStatusMessageAlt = "
<span id='bmStatusInformation'>
This status is waiting on action from the Developer.
</span>
">
</cfcase>

<!---READY--->
<cfcase value="2">
<!---Only a Developer, Project, or Deployer can change a Ready status.--->
<cfif ARGUMENTS.bmDeveloperUserID EQ session.userID OR ARGUMENTS.bmProjectUserID EQ session.userID OR ARGUMENTS.bmDeployerUserID EQ session.userID>
<cfset var.showActionStatusMenu = 'true'>
<cfset var.showActionStatusMessage = 'true'>
<cfset var.showActionStatusMessageAlt = 'false'>
<cfelse>
<cfset var.showActionStatusMenu = 'false'>
<cfset var.showActionStatusMessage = 'false'>
<cfset var.showActionStatusMessageAlt = 'true'>
</cfif>
<!---Messaging for this action status.--->
<cfset var.actionStatusMessage = "
<span id='bmStatusInstruction'>
<u>The build is now awaiting an 'Approved' or 'Not Approved' action status change by the Deployer or the Project member(s).</u>
</span>
">
<cfset var.actionStatusMessageAlt = "
<span id='bmStatusInformation'>
This build is waiting on action for approval from the Developer, Project, or Deployer member.
</span>
">
</cfcase>

<!---NOT APPROVED--->
<cfcase value="3">
<!---Only a Developer can change a Not Approved status.--->
<cfif ARGUMENTS.bmDeveloperUserID EQ session.userID>
<cfset var.showActionStatusMenu = 'true'>
<cfset var.showActionStatusMessage = 'true'>
<cfset var.showActionStatusMessageAlt = 'false'>
<cfelse>
<cfset var.showActionStatusMenu = 'false'>
<cfset var.showActionStatusMessage = 'false'>
<cfset var.showActionStatusMessageAlt = 'true'>
</cfif>
<!---Messaging for this action status.--->
<cfset var.actionStatusMessage = "
<span id='bmStatusInstruction'>
<u>The build is 'Not Approved'. Please research and correct any issues that may caused this action status.</u>
</span>
">
<cfset var.actionStatusMessageAlt = "
<span id='bmStatusInformation'>
This status is waiting on action from the Developer, Project, or Deployer member due to it's action status being 'Not Approved'.
</span>
">
</cfcase>

<!---APPROVED--->
<cfcase value="4">
<!---Only a Developer can change a Approved status.--->
<cfif ARGUMENTS.bmDeployerUserID EQ session.userID>
<cfset var.showActionStatusMenu = 'true'>
<cfset var.showActionStatusMessage = 'true'>
<cfset var.showActionStatusMessageAlt = 'false'>
<cfelse>
<cfset var.showActionStatusMenu = 'false'>
<cfset var.showActionStatusMessage = 'false'>
<cfset var.showActionStatusMessageAlt = 'true'>
</cfif>
<!---Messaging for this action status based on a Deployer.--->
<cfset var.actionStatusMessage = "
<span id='bmStatusInstruction'><u>The build is 'Approved'. Please review the list below for more information.</u>
<ol>
<li>Confirm that project documentation has been updated.</li>
<li>Confirm that pre-deployment testing has been done throughly.</li>
">
<cfif ARGUMENTS.bmuaDatabaseID NEQ 4 AND ARGUMENTS.bmDatabaseUserID NEQ 0>
<cfset var.actionStatusMessage = var.actionStatusMessage & "
<li>Confirm any database changes have been made (if applicable).</li>
">
</cfif>
<cfif ARGUMENTS.bmuaSystemID NEQ 4 AND ARGUMENTS.bmSystemUserID NEQ 0>
<cfset var.actionStatusMessage = var.actionStatusMessage & "
<li>Confirm any system changes have been made (if applicable).</li>
">
</cfif>
<cfset var.actionStatusMessage = var.actionStatusMessage & "
</ol>
</span>
">

<cfset var.actionStatusMessage = var.actionStatusMessage & "
<span id='bmStatusInformation'>
The build is approved for deployment. Change the action status to 'Not Approved' or 'Cancelled' and record the change in the 'Deployer Notes' if complications arise with the build. This will enable the Developer to correct the build.
</span>
">

<!---Build an alt message to notify members of deployments from the Database and System members are still pending.--->
<cfif ARGUMENTS.bmuaDatabaseID NEQ 4 AND ARGUMENTS.bmDatabaseUserID NEQ 0>
<cfset var.showActionStatusMenu = 'false'>
<cfset var.actionStatusMessage = "
<span id='bmStatusInstruction'>
<u>This status is waiting on action from the Database member.</u>
</span>
">
<cfset var.actionStatusMessageAlt = "
<span id='bmStatusInformation'>
This status is waiting on action from the Database member.
</span>
">
<cfelseif ARGUMENTS.bmuaSystemID NEQ 4 AND ARGUMENTS.bmSystemUserID NEQ 0>
<cfset var.showActionStatusMenu = 'false'>
<cfset var.actionStatusMessage = "
<span id='bmStatusInstruction'>
<u>This status is waiting on action from the System member.</u>
</span>
">
<cfset var.actionStatusMessageAlt = "
<span id='bmStatusInformation'>
This status is waiting on action from the System member.
</span>
">
<cfelse>
<cfset var.actionStatusMessageAlt = "
<span id='bmStatusInformation'>
This status is waiting on action from the Deployer member.
</span>
">
</cfif>

<!---Now build in logic to control the progression of a build that includes a database change confirmation.--->
<cfif ARGUMENTS.bmDatabaseUserID EQ session.userID AND ARGUMENTS.bmuaDatabaseID NEQ 4>
<cfset var.showActionStatusMenu = 'false'>
<cfset var.showActionStatusMessage = 'true'>
<cfset var.showActionStatusMessageAlt = 'false'>
<cfset var.actionStatusMessage = "
<span id='bmStatusInformation'>
The 'Database Action Status' must be 'Deployed' to continue with the build. Please refer to the build notes for specifics regarding which SQL changes are needed for the build (<u>there may be an attached document to this build</u>). <br><br>Once the changes are deployed update the 'Database Action Status' to 'Deployed'.
</span>
">
<cfset var.actionStatusMessageAlt = "
<span id='bmStatusInformation'>
This status is waiting on action from the Database member.
</span>
">
</cfif>

<!---Now build in logic to control the progression of a build that includes a system change confirmation.--->
<cfif ARGUMENTS.bmSystemUserID EQ session.userID AND ARGUMENTS.bmuaSystemID NEQ 4>
<cfset var.showActionStatusMenu = 'false'>
<cfset var.showActionStatusMessage = 'true'>
<cfset var.showActionStatusMessageAlt = 'false'>
<cfset var.actionStatusMessage = "
<span id='bmStatusInformation'>
The 'System Action Status' must be 'Deployed' to continue with the build. Please refer to the build notes for specifics regarding system changes that are needed for the build (<u>there may be an attached document to this build</u>). <br><br>Once the changes are deployed update the 'System Action Status' to 'Deployed'.
</span>
">
<cfset var.actionStatusMessageAlt = "
<span id='bmStatusInformation'>
This status is waiting on action from the System member.
</span>
">
</cfif> 

<!---Present the deploy feature to the Deployer.--->
<cfif ARGUMENTS.bmDeployerUserID EQ session.userID>
<cfsavecontent variable="codeBlock">
<br><br>
<!---Check to see if the build is scheduled.--->
<cfif ARGUMENTS.bmScheduleStatus EQ 1>
<span id="bmStatusInformationFocus">The build is scheduled for automated deployment.</span>
<cfelse>
<cfoutput>
<a href="javascript:void(0);" onclick="javascript:ColdFusion.Window.create('DeployWindow#ARGUMENTS.bmID#', 'Build Deploy', '/#application.mcmsAppAdminPath#/build_manager/view/inc_update_build_manager_deploy_window.cfm?appID=#url.appID#&ID=#ARGUMENTS.bmID#', {x:100,y:100,height:640,width:1024,modal:true,closable:true,
draggable:true,resizable:true,center:true,initshow:true,minheight:400,minwidth:1024})"><cfinput type="button" name="mcmsDeploy" id="mcmsDeploy" value="Deploy Build"></a>
</cfoutput>
<br /><br />
<span id="bmStatusInstruction">
<cfif ARGUMENTS.bmScheduleStatus EQ 0>
The deployment is not scheduled for automation. The build must be deployed manually. <br />
Use the "Deploy Build" button above.<br /><br />
<cfelse>
The "Deployment" will occur at the date and time requested unless otherwise specified by changing the "Scheduled" value in the Build Detail. <br />
<u>Note: Only Developers and Deployers can change build schedules.</u>
</cfif>
</span>
</cfif>
</cfsavecontent>
</cfif>
</cfcase>

<!---DEPLOY--->
<cfcase value="5">
<!---Only a Deployer can change a Deploy status to Testing.--->
<cfif ARGUMENTS.bmDeployerUserID EQ session.userID>
<cfset var.showActionStatusMenu = 'true'>
<cfset var.showActionStatusMessage = 'true'>
<cfset var.showActionStatusMessageAlt = 'false'>
<cfelse>
<cfset var.showActionStatusMenu = 'false'>
<cfset var.showActionStatusMessage = 'false'>
<cfset var.showActionStatusMessageAlt = 'true'>
</cfif>
<!---Messaging for this action status.--->
<cfset var.actionStatusMessage = "
<span id='bmStatusInformation'>
Confirm the deployment has completed and change the action status to 'Deploy Testing'.
</span>
">
<cfset var.actionStatusMessageAlt = "
<span id='bmStatusInformation'>
This status is waiting on action from the Deployer.
</span>
">
</cfcase>

<!---ROLLBACK REQUEST--->
<cfcase value="6">
<!---Only a Deployer/Developer can change a Rollback Request status.--->
<cfif ARGUMENTS.bmDeployerUserID EQ session.userID OR ARGUMENTS.bmDeveloperUserID EQ session.userID>
<cfset var.showActionStatusMenu = 'false'>
<cfset var.showActionStatusMessage = 'true'>
<cfset var.showActionStatusMessageAlt = 'false'>
<cfelse>
<cfset var.showActionStatusMenu = 'false'>
<cfset var.showActionStatusMessage = 'false'>
<cfset var.showActionStatusMessageAlt = 'true'>
</cfif>
<!---Messaging for this action status.--->
<cfset var.actionStatusMessage = "
<span id='bmStatusInformation'>
A rollback has been requested for the build. This should be performed immediately if it affects a PROD system. Please ensure that any database or system changes are rolled-back (if applicable).
</span>
">
<cfset var.actionStatusMessageAlt = "
<span id='bmStatusInformation'>
A rollback has been requested for the build. Members that are required for rollback have been notified. <br>
Notification of completion of the rollback will be sent once all rollback tasks have been completed.
</span>
">
<!---Messaging for this action status based on a Deployer.--->
<cfset var.actionStatusMessage = "
<span id='bmStatusInstruction'><u>The build is 'Rollback Request'. Please review the list below for more information.</u>
<ol>
<li>Confirm that project documentation has been updated.</li>
<li>Confirm that build is ready for roll-back.</li>
">
<cfif ARGUMENTS.bmuaDatabaseID NEQ 3 AND ARGUMENTS.bmDatabaseUserID NEQ 0>
<cfset var.actionStatusMessage = var.actionStatusMessage & "
<li>Confirm any database rollback changes have been made (if applicable).</li>
">
</cfif>
<cfif ARGUMENTS.bmuaSystemID NEQ 3 AND ARGUMENTS.bmSystemUserID NEQ 0>
<cfset var.actionStatusMessage = var.actionStatusMessage & "
<li>Confirm any system rollback changes have been made (if applicable).</li>
">
</cfif>
<cfset var.actionStatusMessage = var.actionStatusMessage & "
</ol>
</span>
">
<!---Build an alt message to notify members of deployments from the Database and System members are still pending.--->
<cfif ARGUMENTS.bmuaDatabaseID NEQ 3 AND ARGUMENTS.bmDatabaseUserID NEQ 0>
<cfset var.showActionStatusMenu = 'false'>
<cfset var.actionStatusMessage = "
<span id='bmStatusInstruction'>
<u>This status is waiting on action from the Database member.</u>
</span>
">
<cfset var.actionStatusMessageAlt = "
<span id='bmStatusInformation'>
This status is waiting on action from the Database member.
</span>
">
<cfelseif ARGUMENTS.bmuaSystemID NEQ 3 AND ARGUMENTS.bmSystemUserID NEQ 0>
<cfset var.showActionStatusMenu = 'false'>
<cfset var.actionStatusMessage = "
<span id='bmStatusInstruction'>
<u>This status is waiting on action from the System member.</u>
</span>
">
<cfset var.actionStatusMessageAlt = "
<span id='bmStatusInformation'>
This status is waiting on action from the System member.
</span>
">
<cfelse>
<cfset var.actionStatusMessageAlt = "
<span id='bmStatusInformation'>
This status is waiting on action from the Deployer member.
</span>
">
</cfif>
<!---Now build in logic to control the progression of a build rollback that includes a database change confirmation.--->
<cfif ARGUMENTS.bmDatabaseUserID EQ session.userID AND ARGUMENTS.bmuaDatabaseID NEQ 3>
<cfset var.showActionStatusMenu = 'false'>
<cfset var.showActionStatusMessage = 'true'>
<cfset var.showActionStatusMessageAlt = 'false'>
<cfset var.actionStatusMessage = "
<span id='bmStatusInformation'>
The 'Database Action Status' must be 'Rolled-back' to continue with the build. Please refer to the build notes for specifics regarding which SQL changes are needed for the build (<u>there may be an attached document to this build</u>). <br><br>Once the changes are rolled-back, update the 'Database Action Status' to 'Rolled-back'.
</span>
">
<cfset var.actionStatusMessageAlt = "
<span id='bmStatusInformation'>
This status is waiting on action from the Database member.
</span>
">
</cfif>

<!---Now build in logic to control the progression of a build rollback that includes a system change confirmation.--->
<cfif ARGUMENTS.bmSystemUserID EQ session.userID AND ARGUMENTS.bmuaSystemID NEQ 3>
<cfset var.showActionStatusMenu = 'false'>
<cfset var.showActionStatusMessage = 'true'>
<cfset var.showActionStatusMessageAlt = 'false'>
<cfset var.actionStatusMessage = "
<span id='bmStatusInformation'>
The 'System Action Status' must be 'Deployed' to continue with the build. Please refer to the build notes for specifics regarding system changes that are needed for the build (<u>there may be an attached document to this build</u>). <br><br>Once the changes are deployed update the 'System Action Status' to 'Deployed'.
</span>
">
<cfset var.actionStatusMessageAlt = "
<span id='bmStatusInformation'>
This status is waiting on action from the System member.
</span>
">
</cfif> 

<!---Present the deploy feature to the Deployer/Developer.--->
<cfif ARGUMENTS.bmDeployerUserID EQ session.userID OR ARGUMENTS.bmDeveloperUserID EQ session.userID>
<!---Messaging for this action status.--->
<cfset var.actionStatusMessage = "
<span id='bmStatusInformation'>
Please include any detailed notes that may assist with the confirmation for the rollback request. Once the rollback has been completed by the build members and any required rollbacks to revision, database and systems are completed, an email confirmation will be sent.<br><br>
Please assist in the testing of the rollback for this build. Once you have tested the rollback build throughly update the Deployer Status to 'Rollback Complete'. This will formally confirm the rollback was completed.<br><br>Click the 'Rollback Build' button to continue.
</span>
">
<cfset var.actionStatusMessageAlt = "
<span id='bmStatusInformation'>
A rollback has been requested for the build. Members that are required for rollback have been notified. <br>
Notification of completion of the rollback will be sent once all rollback tasks have been completed.
</span>
">
<cfsavecontent variable="codeBlock">
<br><br>
<cfoutput>
<a href="javascript:void(0);" onclick="javascript:ColdFusion.Window.create('RollbackWindow#ARGUMENTS.bmID#', 'Build Rollback', '/#application.mcmsAppAdminPath#/build_manager/view/inc_update_build_manager_rollback_window.cfm?appID=#url.appID#&ID=#ARGUMENTS.bmID#', {x:100,y:100,height:640,width:1024,modal:true,closable:true,
draggable:true,resizable:true,center:true,initshow:true,minheight:400,minwidth:1024})"><cfinput type="button" name="mcmsDeploy" id="mcmsDeploy" value="Rollback Build"></a>
</cfoutput>
</cfsavecontent>
</cfif>

</cfcase>

<!---ROLLBACK--->
<cfcase value="7">
<!---Only a Deployer/Developer can change a Rollback status.--->
<cfif ARGUMENTS.bmDeployerUserID EQ session.userID OR ARGUMENTS.bmDeveloperUserID EQ session.userID>
<cfset var.showActionStatusMenu = 'true'>
<cfset var.showActionStatusMessage = 'true'>
<cfset var.showActionStatusMessageAlt = 'false'>
<cfelse>
<cfset var.showActionStatusMenu = 'false'>
<cfset var.showActionStatusMessage = 'false'>
<cfset var.showActionStatusMessageAlt = 'true'>
</cfif>
<!---Messaging for this action status.--->
<cfset var.actionStatusMessage = "
<span id='bmStatusInformation'>
Please assist in the testing of the rollback for this build. Once you have tested the rollback build throughly update the Deployer Status to 'Rollback Complete'. This will formally confirm the rollback was completed.
</span>
">
<cfset var.actionStatusMessageAlt = "
<span id='bmStatusInformation'>
The build is complete and deployed. No further action is required from it's members.
</span>
">
</cfcase>

<!---ROLLBACK COMPLETE--->
<cfcase value="8">
<!---Only a Deployer/Developer can change a Rollback Complete status.--->
<cfif ARGUMENTS.bmDeployerUserID EQ session.userID OR ARGUMENTS.bmDeveloperUserID EQ session.userID>
<cfset var.showActionStatusMenu = 'true'>
<cfset var.showActionStatusMessage = 'true'>
<cfset var.showActionStatusMessageAlt = 'false'>
<cfelse>
<cfset var.showActionStatusMenu = 'false'>
<cfset var.showActionStatusMessage = 'false'>
<cfset var.showActionStatusMessageAlt = 'true'>
</cfif>
<!---Messaging for this action status.--->
<cfset var.actionStatusMessage = "
<span id='bmStatusInformation'>
The rollback is completed. The build can now be closed.
</span>
">
<cfset var.actionStatusMessageAlt = "
<span id='bmStatusInformation'>
The rollback is completed.
</span>
">
</cfcase>

<!---DEPLOY COMPLETE--->
<cfcase value="9">
<!---Only a Deployer or Developer can change a Deploy Complete status.--->
<cfif ARGUMENTS.bmDeployerUserID EQ session.userID OR ARGUMENTS.bmDeveloperUserID EQ session.userID>
<cfset var.showActionStatusMenu = 'true'>
<cfset var.showActionStatusMessage = 'true'>
<cfset var.showActionStatusMessageAlt = 'false'>
<cfelse>
<cfset var.showActionStatusMenu = 'false'>
<cfset var.showActionStatusMessage = 'false'>
<cfset var.showActionStatusMessageAlt = 'true'>
</cfif>
<!---Messaging for this action status.--->
<cfset var.actionStatusMessage = "
<span id='bmStatusInformation'>
The build is complete and deployed. The build can now be closed.
</span>
">
<cfset var.actionStatusMessageAlt = "
<span id='bmStatusInformation'>
The build is complete and deployed. No further action is required from it's members.
</span>
">
</cfcase>

<!---CANCELLED--->
<cfcase value="10">
<!---Only a Deployer/Developer can change a Rollback status.--->
<cfif ARGUMENTS.bmDeployerUserID EQ session.userID OR ARGUMENTS.bmDeveloperUserID EQ session.userID>
<cfset var.showActionStatusMenu = 'true'>
<cfset var.showActionStatusMessage = 'true'>
<cfset var.showActionStatusMessageAlt = 'false'>
<cfelse>
<cfset var.showActionStatusMenu = 'false'>
<cfset var.showActionStatusMessage = 'false'>
<cfset var.showActionStatusMessageAlt = 'true'>
</cfif>
<!---Messaging for this action status.--->
<cfset var.actionStatusMessage = "
<span id='bmStatusInformation'>
The build has been cancelled. Please refer to the logs for details regarding the cancellation.
</span>
">
<cfset var.actionStatusMessageAlt = "
<span id='bmStatusInformation'>
The build has been cancelled. No further action is required from it's members.
</span>
">
</cfcase>

<!---DEPLOY TESTING--->
<cfcase value="11">
<!---Only a Deployer can change a Deploy status once the Test member has updated to tested status.--->
<cfif ARGUMENTS.bmTestUserID EQ session.userID AND ARGUMENTS.bmuaTestID NEQ 5 AND ARGUMENTS.bmuaTestID NEQ 2 AND ARGUMENTS.bmDeveloperUserID NEQ session.userID>
<cfset var.showActionStatusMenu = 'false'>
<cfset var.showActionStatusMessage = 'true'>
<cfset var.showActionStatusMessageAlt = 'false'>
<cfelseif ARGUMENTS.bmDeployerUserID EQ session.userID AND (ARGUMENTS.bmuaTestID EQ 5 OR ARGUMENTS.bmuaTestID EQ 2) OR ARGUMENTS.bmDeveloperUserID EQ session.userID>
<cfset var.showActionStatusMenu = 'true'>
<cfset var.showActionStatusMessage = 'false'>
<cfset var.showActionStatusMessageAlt = 'true'>
<cfelse>
<cfset var.showActionStatusMenu = 'false'>
<cfset var.showActionStatusMessage = 'false'>
<cfset var.showActionStatusMessageAlt = 'true'>
</cfif>
<!---Messaging for this action status.--->
<cfset var.actionStatusMessage = "
<span id='bmStatusInformation'>
Please complete the testing of the build and update the 'Test Status' to 'Tested'. Check the URL's in the Build Detail for links.
<br><br>
<u>If during testing the build is unstable, update the Test Status to 'Defer' to begin a 'Rollback Request'. Otherwise update to 'Tested'.</u>
</span>
">
<!---If the Test member has tested.--->
<cfif ARGUMENTS.bmuaTestID EQ 5>
<cfset var.actionStatusMessageAlt = "
<span id='bmStatusInformation'>
This status is waiting on action from the Deployer member now that the Test member has tested.<br>The Deployer can now update the status to Deploy Complete.
</span>
">
<!---If the Test member has deferred.--->
<cfelseif ARGUMENTS.bmuaTestID EQ 2>
<cfset var.actionStatusMessageAlt = "
<span id='bmStatusInformation'>
This status is deferred. The Deployer must review notes or work with the Test member to resolve an issue.
</span>
">
<cfelse>
<cfset var.actionStatusMessageAlt = "
<span id='bmStatusInformation'>
This status is waiting on action from the Test member.
</span>
">
</cfif>

</cfcase>

<!---ROLLBACK TESTING--->
<cfcase value="12">
<!---Only a Deployer or Developer can change a Rollback status once the Test member has updated to tested status.--->
<cfif ARGUMENTS.bmTestUserID EQ session.userID AND ARGUMENTS.bmuaTestID NEQ 5 AND ARGUMENTS.bmuaTestID NEQ 2>
<cfset var.showActionStatusMenu = 'false'>
<cfset var.showActionStatusMessage = 'true'>
<cfset var.showActionStatusMessageAlt = 'false'>
<cfelseif (ARGUMENTS.bmDeployerUserID EQ session.userID OR ARGUMENTS.bmDeveloperUserID EQ session.userID) AND (ARGUMENTS.bmuaTestID EQ 5 OR ARGUMENTS.bmuaTestID EQ 2)>
<cfset var.showActionStatusMenu = 'true'>
<cfset var.showActionStatusMessage = 'false'>
<cfset var.showActionStatusMessageAlt = 'true'>
<cfelse>
<cfset var.showActionStatusMenu = 'false'>
<cfset var.showActionStatusMessage = 'false'>
<cfset var.showActionStatusMessageAlt = 'true'>
</cfif>
<!---Messaging for this action status.--->
<cfset var.actionStatusMessage = "
<span id='bmStatusInformation'>
Please complete the testing of the roll-back and update the 'Test Status' to 'Tested'. Check the URL's in the Build Detail for the links.
</span>
">
<!---If the Test member has tested.--->
<cfif ARGUMENTS.bmuaTestID EQ 5>
<cfset var.actionStatusMessageAlt = "
<span id='bmStatusInformation'>
This status is waiting on action from the Deployer member now that the Test member has tested.<br>The Deployer can now update the status to Roll-back Complete.
</span>
">
<!---If the Test member has deferred.--->
<cfelseif ARGUMENTS.bmuaTestID EQ 2>
<cfset var.actionStatusMessageAlt = "
<span id='bmStatusInformation'>
This status is deferred. The Deployer must review notes or work with the Test member to resolve an issue.
</span>
">
<cfelse>
<cfset var.actionStatusMessageAlt = "
<span id='bmStatusInformation'>
This status is waiting on action from the Test member.
</span>
">
</cfif>
</cfcase>

<!---ERROR--->
<cfcase value="13">
<!---Only a Deployer or Developer can change a build status of Error.--->
<cfif ARGUMENTS.bmDeployerUserID EQ session.userID OR ARGUMENTS.bmDeveloperUserID EQ session.userID>
<cfset var.showActionStatusMenu = 'true'>
<cfset var.showActionStatusMessage = 'true'>
<cfset var.showActionStatusMessageAlt = 'false'>
<cfelse>
<cfset var.showActionStatusMenu = 'false'>
<cfset var.showActionStatusMessage = 'false'>
<cfset var.showActionStatusMessageAlt = 'true'>
</cfif>
<!---Messaging for this action status.--->
<cfset var.actionStatusMessage = "
<span id='bmStatusInformation'>
The build has experienced an error. The Deployer and Developer can now research and correct the issue. From the error status the build can be returned to various status points.
</span>
">
<cfset var.actionStatusMessageAlt = "
<span id='bmStatusInformation'>
The build has experienced an error. The Deployer and Developer will now research and correct the issue.
</span>
">
</cfcase>

<!---CLOSED--->
<cfcase value="14">
<!---Only a Deployer or Developer can change a build status to Closed.--->
<cfif ARGUMENTS.bmDeployerUserID EQ session.userID OR ARGUMENTS.bmDeveloperUserID EQ session.userID>
<cfset var.showActionStatusMenu = 'false'>
<cfset var.showActionStatusMessage = 'true'>
<cfset var.showActionStatusMessageAlt = 'false'>
<cfelse>
<cfset var.showActionStatusMenu = 'false'>
<cfset var.showActionStatusMessage = 'false'>
<cfset var.showActionStatusMessageAlt = 'true'>
</cfif>
<!---Messaging for this action status.--->
<cfset var.actionStatusMessage = "
<span id='bmStatusInformation'>
The build closed.
</span>
">
<cfset var.actionStatusMessageAlt = "
<span id='bmStatusInformation'>
The build is closed. No further action is required from it's members.
</span>
">
</cfcase>

</cfswitch>
<!---Build Action Menu.--->
<cfif var.showActionStatusMenu EQ true>
<cfselect name="bmaID" query="getBuildManagerActionFilterRet" display="bmaName" value="ID" selected="#ARGUMENTS.bmaID#" queryPosition="below">
</cfselect>
</cfif>
<cfif var.showActionStatusMenu EQ false>
<strong><cfoutput>#ARGUMENTS.bmaName#</cfoutput></strong>
<cfinput type="hidden" name="bmaID" id="bmaID" value="#ARGUMENTS.bmaID#" />
</cfif>
<cfif var.showActionStatusMessage EQ true>
<br><br>
<cfoutput>#var.actionStatusMessage#</cfoutput>
</cfif>
<cfif var.showActionStatusMessageAlt EQ true>
<br><br>
<cfoutput>#var.actionStatusMessageAlt#</cfoutput>
</cfif>
<cfif codeBlock NEQ ''>
<cfoutput>#codeBlock#</cfoutput>
</cfif>
</cfsavecontent>
<!--</cfform> DO NOT REMOVE-->
<!---Catch any errors.--->
<cfcatch type="any">
<cfset result = StructNew()>
<cfset result.message = "There was an error with the query.">

</cfcatch>
</cftry>
<cfreturn result>
</cffunction>

<cffunction name="setBuildActionUser" access="public" returntype="string" output="yes" hint="Set Build Manager User action based on current Build Action.">
<cfargument name="bmID" type="numeric" required="yes" default="0">
<cfargument name="bmaID" type="numeric" required="yes" default="0">
<cfargument name="bmsID" type="numeric" required="yes" default="0">
<cfargument name="bmuaID" type="numeric" required="yes" default="0">
<cfargument name="bmuName" type="string" required="yes" default="Deployer">
<cfargument name="bmsutID" type="numeric" required="yes" default="0">
<cfargument name="bmUserID" type="numeric" required="yes" default="0">
<cfargument name="bmuaName" type="string" required="yes" default="Pending">
<cfargument name="bmUserFName" type="string" required="yes" default="">
<cfargument name="bmUserLName" type="string" required="yes" default="">
<cfargument name="bmUserEmail" type="string" required="yes" default="">
<cfargument name="bmTicketNo" type="string" required="yes" default="">
<cfargument name="bmUserTicketNo" type="string" required="yes" default="">
<cfargument name="bmUserNotes" type="string" required="yes" default="">
<cfargument name="bmDeveloperUserID" type="numeric" required="yes" default="0">
<cfargument name="bmProjectUserID" type="numeric" required="yes" default="0">
<cfargument name="bmTestUserID" type="numeric" required="yes" default="0">
<cfargument name="bmDatabaseUserID" type="numeric" required="yes" default="0">
<cfargument name="bmSystemUserID" type="numeric" required="yes" default="0">
<cfargument name="bmDeployerUserID" type="numeric" required="yes" default="0">
<cfargument name="bmScheduleStatus" type="numeric" required="yes" default="0">
<cfset result = ''>
<cftry>
<!--<cfform> DO NOT REMOVE--> 
<cfsilent>
<!---Determine which User Action is available.--->
<cfinvoke 
component="/#application.mcmsAppAdminPath#/build_manager/component/BuildManager"
method="getBuildManagerUserActionFilter"
returnvariable="getBuildManagerUserActionFilterRet">
<cfinvokeargument name="bmuName" value="#ARGUMENTS.bmuName#"/>
<cfinvokeargument name="bmaID" value="#ARGUMENTS.bmaID#"/>
<cfinvokeargument name="bmuaStatus" value="1"/>
</cfinvoke>
<cfinvoke 
component="/#application.mcmsAppAdminPath#/build_manager/component/BuildManager"
method="getBuildManagerServerUserRel"
returnvariable="getBuildManagerServerUserRelRet">
<cfinvokeargument name="bmsID" value="#ARGUMENTS.bmsID#"/>
<cfinvokeargument name="bmsutID" value="#ARGUMENTS.bmsutID#"/>
<cfinvokeargument name="bmsurStatus" value="1,3"/>
</cfinvoke>
</cfsilent>

<cfsavecontent variable="result">
<cfswitch expression="#ARGUMENTS.bmuName#">
<!---PROJECT--->
<cfcase value="Project">
<!---Do not display if there is no Project user.--->
<cfif ARGUMENTS.bmUserID EQ 0>
<cfinput type="hidden" name="bm#ARGUMENTS.bmuName#UserID" value="#ARGUMENTS.bmUserID#" />
<cfinput type="hidden" name="bm#ARGUMENTS.bmuName#Notes" value="#ARGUMENTS.bmUserNotes#" />
<!---Only display if it is the Project or Developer user.--->
<cfelseif ARGUMENTS.bmUserID NEQ session.userID AND ARGUMENTS.bmDeveloperUserID NEQ session.userID>
<cfinput type="hidden" name="bm#ARGUMENTS.bmuName#UserID" value="#ARGUMENTS.bmUserID#" />
<cfinput type="hidden" name="bm#ARGUMENTS.bmuName#Notes" value="#ARGUMENTS.bmUserNotes#" />
<cfelse>
<h2>#ARGUMENTS.bmuName#</h2>
<table id="mainTableAlt" style="padding:0px;">
<tr>
<th>#ARGUMENTS.bmuName# User</th>
</tr>
<tr>
<td>
<cfif ARGUMENTS.bmaID LTE 1 AND (ARGUMENTS.bmUserID EQ session.userID OR ARGUMENTS.bmUserID EQ session.userID)>
<cfselect name="bm#ARGUMENTS.bmuName#UserID" required="yes" message="Please select a #ARGUMENTS.bmuName# User.">
<option value="0">N/A</option>
<cfoutput query="getBuildManagerServerUserRelRet">
<option value="#userID#" <cfif ARGUMENTS.bmUserID EQ userID>selected</cfif>>#userFName# #userLName# (#bmsutName#)</option>
</cfoutput> 
</cfselect>
<br />
<span class="small">Choose a #ARGUMENTS.bmuName# user to be responsible for overseeing deployments (if applicable).</span>
<cfelse>
<cfif ARGUMENTS.bmUserID NEQ 0>
<a href="/#application.mcmsAppPublicPath#/email_form/?toEmail=#ARGUMENTS.bmUserEmail#&subject=Build #ARGUMENTS.bmID# (#ARGUMENTS.bmuName#)" target="_blank">
<span class="glyphicon glyphicon-envelope"></span>#ARGUMENTS.bmUserFName# #ARGUMENTS.bmUserLName#</a>
<cfelse>
N/A
</cfif>
<cfinput type="hidden" name="bm#ARGUMENTS.bmuName#UserID" value="#ARGUMENTS.bmUserID#" />
</cfif>
</td>
</tr>
<tr>
<td colspan="3">
<h3>#ARGUMENTS.bmuName# Notes</h3>
<cfif ARGUMENTS.bmUserID EQ session.userID>
<cftextarea name="bm#ARGUMENTS.bmuName#Notes" wrap="virtual" richtext="no" cols="100" rows="6">
#ARGUMENTS.bmUserNotes#
</cftextarea>
<cfelse>
<cfif ARGUMENTS.bmUserNotes EQ ''>
None.
<cfelse>
<span id="bmNotes">
#ARGUMENTS.bmUserNotes#
</span>
</cfif>
<cfinput name="bm#ARGUMENTS.bmuName#Notes" type="hidden" value="#ARGUMENTS.bmUserNotes#" />
</cfif>
</td>
</tr>
</table>
</cfif>
</cfcase>

<!---TEST--->
<cfcase value="Test">
<!---Do not display if there is no Test user.--->
<cfif ARGUMENTS.bmUserID EQ 0>
<cfinput type="hidden" name="bm#ARGUMENTS.bmuName#UserID" value="#ARGUMENTS.bmUserID#" />
<cfinput type="hidden" name="bmua#ARGUMENTS.bmuName#ID" value="#ARGUMENTS.bmuaID#" />
<cfinput type="hidden" name="bm#ARGUMENTS.bmuName#Notes" value="#ARGUMENTS.bmUserNotes#" />
<!---Only display if it is the Project or Developer user.--->
<cfelseif ARGUMENTS.bmUserID NEQ session.userID AND ARGUMENTS.bmDeveloperUserID NEQ session.userID>
<cfinput type="hidden" name="bm#ARGUMENTS.bmuName#UserID" value="#ARGUMENTS.bmUserID#" />
<cfinput type="hidden" name="bmua#ARGUMENTS.bmuName#ID" value="#ARGUMENTS.bmuaID#" />
<cfinput type="hidden" name="bm#ARGUMENTS.bmuName#Notes" value="#ARGUMENTS.bmUserNotes#" />
<cfelse>
<h2>#ARGUMENTS.bmuName#</h2>
<table id="mainTableAlt" style="padding:0px;">
<tr>
<th style="width:80%;">#ARGUMENTS.bmuName# User</th>
<th style="width:20%;">#ARGUMENTS.bmuName# Action Status</th>
</tr>
<tr>
<td>
<!---Allow the change of the Test user by the Developer.--->
<cfif ARGUMENTS.bmaID LTE 2 AND (ARGUMENTS.bmDeveloperUserID EQ session.userID)>
<cfselect name="bm#ARGUMENTS.bmuName#UserID" required="yes" message="Please select a #ARGUMENTS.bmuName#.">
<option value="0">N/A</option>
<cfoutput query="getBuildManagerServerUserRelRet">
<option value="#userID#" <cfif ARGUMENTS.bmUserID EQ userID>selected</cfif>>#userFName# #userLName# (#bmsutName#)</option>
</cfoutput> 
</cfselect>
<br />
<span class="small">Choose a #ARGUMENTS.bmuName# user to be responsible for testing deployments (if applicable).</span>
<cfelse>
<a href="/#application.mcmsAppPublicPath#/email_form/?toEmail=#ARGUMENTS.bmUserEmail#&subject=Build #ARGUMENTS.bmID# (#ARGUMENTS.bmuName#)" target="_blank">
<span class="glyphicon glyphicon-envelope"></span>#ARGUMENTS.bmUserFName# #ARGUMENTS.bmUserLName#</a>
<cfinput type="hidden" name="bm#ARGUMENTS.bmuName#UserID" id="bm#ARGUMENTS.bmuName#UserID" value="#ARGUMENTS.bmUserID#" />
</cfif>
</td>
<td>
<!---If the build action is Deploy Testing or Rollback Testing.--->
<cfif (ARGUMENTS.bmaID EQ 11 OR ARGUMENTS.bmaID EQ 12 AND ARGUMENTS.bmUserID EQ session.userID)>
<cfselect name="bmua#ARGUMENTS.bmuName#ID" query="getBuildManagerUserActionFilterRet" display="bmuaName" value="ID" selected="#ARGUMENTS.bmuaID#" queryPosition="below">
</cfselect>
<cftooltip sourcefortooltip="/#application.mcmsAppAdminPath#/tooltip/index.cfm?mcmsToolTip=#ARGUMENTS.bmuName#ActionStatus"><span class="glyphicon glyphicon-question-sign"></span></cftooltip>
<cfelse>
#ARGUMENTS.bmuaName#
<cfinput type="hidden" name="bmua#ARGUMENTS.bmuName#ID" value="#ARGUMENTS.bmuaID#" />
</cfif>
</td>
</tr>
<tr>
<td colspan="2">
<h3>#ARGUMENTS.bmuName# Notes</h3>
<p><u>Please include information about what was tested.</u><br /><br /></p>
<cfif ARGUMENTS.bmUserID EQ session.userID>
<cftextarea name="bm#ARGUMENTS.bmuName#Notes" wrap="virtual" richtext="no" cols="100" rows="6">
#ARGUMENTS.bmUserNotes#
</cftextarea>
<cfelse>
<cfif ARGUMENTS.bmUserNotes EQ ''>
None.
<cfelse>
<span id="bmNotes">#ARGUMENTS.bmUserNotes#</span>
</cfif>
<cfinput name="bm#ARGUMENTS.bmuName#Notes" type="hidden" value="#ARGUMENTS.bmUserNotes#" />
</cfif>
</td>
</tr>
</table>
</cfif>
</cfcase>

<!---DATABASE--->
<cfcase value="Database">
<!---Do not display if the action is not requiring action from this user or there is no Database user.--->
<cfif ARGUMENTS.bmUserID EQ 0>
<cfinput type="hidden" name="bm#ARGUMENTS.bmuName#UserID" value="#ARGUMENTS.bmUserID#" />
<cfinput type="hidden" name="bm#ARGUMENTS.bmuName#TicketNo" value="#Iif(ARGUMENTS.bmUserTicketNo EQ 0, DE(ARGUMENTS.bmTicketNo), DE(ARGUMENTS.bmUserTicketNo))#" />
<cfinput type="hidden" name="bmua#ARGUMENTS.bmuName#ID" value="#ARGUMENTS.bmuaID#" />
<cfinput type="hidden" name="bm#ARGUMENTS.bmuName#Notes" value="#ARGUMENTS.bmUserNotes#" />
<!---Only display if it is the Database or Developer user.--->
<cfelseif ARGUMENTS.bmUserID NEQ session.userID AND ARGUMENTS.bmDeveloperUserID NEQ session.userID>
<cfinput type="hidden" name="bm#ARGUMENTS.bmuName#UserID" value="#ARGUMENTS.bmUserID#" />
<cfinput type="hidden" name="bm#ARGUMENTS.bmuName#TicketNo" value="#Iif(ARGUMENTS.bmUserTicketNo EQ 0, DE(ARGUMENTS.bmTicketNo), DE(ARGUMENTS.bmUserTicketNo))#" />
<cfinput type="hidden" name="bmua#ARGUMENTS.bmuName#ID" value="#ARGUMENTS.bmuaID#" />
<cfinput type="hidden" name="bm#ARGUMENTS.bmuName#Notes" value="#ARGUMENTS.bmUserNotes#" />
<cfelse>
<h2>#ARGUMENTS.bmuName#</h2>
<table id="mainTableAlt" style="padding:0px;">
<tr>
<th style="width:40%;">#ARGUMENTS.bmuName# User</th>
<th style="width:40%;">Ticket No.</th>
<th style="width:20%;">#ARGUMENTS.bmuName# Action Status</th>
</tr>
<tr>
<td>
<cfif ARGUMENTS.bmaID LTE 2 AND (ARGUMENTS.bmUserID EQ session.userID)>
<cfselect name="bm#ARGUMENTS.bmuName#UserID" required="yes" message="Please select a #ARGUMENTS.bmuName#.">
<option value="0">N/A</option>
<cfoutput query="getBuildManagerServerUserRelRet">
<option value="#userID#" <cfif ARGUMENTS.bmUserID EQ userID>selected</cfif>>#userFName# #userLName# (#bmsutName#)</option>
</cfoutput> 
</cfselect>
<br />
<span class="small">Choose a #ARGUMENTS.bmuName# user to be responsible for testing deployments (if applicable).</span>
<cfelse>
<a href="/#application.mcmsAppPublicPath#/email_form/?toEmail=#ARGUMENTS.bmUserEmail#&subject=Build #ARGUMENTS.bmID# (#ARGUMENTS.bmuName#)" target="_blank">
<span class="glyphicon glyphicon-envelope"></span>#ARGUMENTS.bmUserFName# #ARGUMENTS.bmUserLName#</a>
<cfinput type="hidden" name="bm#ARGUMENTS.bmuName#UserID" value="#ARGUMENTS.bmUserID#" />
</cfif>
</td>
<td>
<cfif ARGUMENTS.bmUserID EQ session.userID>
<cfinput type="text" name="bm#ARGUMENTS.bmuName#TicketNo" maxlength="16" size="8" required="yes" message="Please include a #ARGUMENTS.bmuName# Ticket No." value="#Iif(ARGUMENTS.bmUserTicketNo EQ 0, DE(ARGUMENTS.bmTicketNo), DE(ARGUMENTS.bmUserTicketNo))#" /><br />
<span class="small">Enter an alternative ticket number. (if applicable).</span>
<cfelse>
#Iif(ARGUMENTS.bmUserTicketNo EQ 0, DE(ARGUMENTS.bmTicketNo), DE(ARGUMENTS.bmUserTicketNo))#
<cfinput type="hidden" name="bm#ARGUMENTS.bmuName#TicketNo" value="#Iif(ARGUMENTS.bmUserTicketNo EQ 0, DE(ARGUMENTS.bmTicketNo), DE(ARGUMENTS.bmUserTicketNo))#" />
</cfif>
</td>
<td>
<!---If the build action is for a Database User.--->
<cfif ARGUMENTS.bmUserID EQ session.userID>
<cfselect name="bmua#ARGUMENTS.bmuName#ID" query="getBuildManagerUserActionFilterRet" display="bmuaName" value="ID" selected="#ARGUMENTS.bmuaID#" queryPosition="below">
</cfselect>
<cftooltip sourcefortooltip="/#application.mcmsAppAdminPath#/tooltip/index.cfm?mcmsToolTip=#ARGUMENTS.bmuName#ActionStatus"><span class="glyphicon glyphicon-question-sign"></span></cftooltip>
<cfelse>
#ARGUMENTS.bmuaName#
<cfinput type="hidden" name="bmua#ARGUMENTS.bmuName#ID" value="#ARGUMENTS.bmuaID#" />
</cfif>
</td>
</tr>
<tr>
<td colspan="3">
<h3>#ARGUMENTS.bmuName# Notes</h3>
<cfif ARGUMENTS.bmUserID EQ session.userID>
<cftextarea name="bm#ARGUMENTS.bmuName#Notes" wrap="virtual" richtext="no" cols="100" rows="6">
#ARGUMENTS.bmUserNotes#
</cftextarea>
<cfelse>
<cfif ARGUMENTS.bmUserNotes EQ ''>
None.
<cfelse>
<span id="bmNotes">#ARGUMENTS.bmUserNotes#</span>
</cfif>
<cfinput name="bm#ARGUMENTS.bmuName#Notes" type="hidden" value="#ARGUMENTS.bmUserNotes#" />
</cfif>
</td>
</tr>
</table>
</cfif>
</cfcase>

<!---SYSTEM--->
<cfcase value="System">
<!---Do not display if there is no System user.--->
<cfif ARGUMENTS.bmUserID EQ 0>
<cfinput type="hidden" name="bm#ARGUMENTS.bmuName#UserID" value="#ARGUMENTS.bmUserID#" />
<cfinput type="hidden" name="bm#ARGUMENTS.bmuName#TicketNo" value="#Iif(ARGUMENTS.bmUserTicketNo EQ 0, DE(ARGUMENTS.bmTicketNo), DE(ARGUMENTS.bmUserTicketNo))#" />
<cfinput type="hidden" name="bmua#ARGUMENTS.bmuName#ID" value="#ARGUMENTS.bmuaID#" />
<cfinput type="hidden" name="bm#ARGUMENTS.bmuName#Notes" value="#ARGUMENTS.bmUserNotes#" />
<!---Only display if it is the System or Developer user.--->
<cfelseif ARGUMENTS.bmUserID NEQ session.userID AND ARGUMENTS.bmDeveloperUserID NEQ session.userID>
<cfinput type="hidden" name="bm#ARGUMENTS.bmuName#UserID" value="#ARGUMENTS.bmUserID#" />
<cfinput type="hidden" name="bm#ARGUMENTS.bmuName#TicketNo" value="#Iif(ARGUMENTS.bmUserTicketNo EQ 0, DE(ARGUMENTS.bmTicketNo), DE(ARGUMENTS.bmUserTicketNo))#" />
<cfinput type="hidden" name="bmua#ARGUMENTS.bmuName#ID" value="#ARGUMENTS.bmuaID#" />
<cfinput type="hidden" name="bm#ARGUMENTS.bmuName#Notes" value="#ARGUMENTS.bmUserNotes#" />
<cfelse>
<h2>#ARGUMENTS.bmuName#</h2>
<table id="mainTableAlt" style="padding:0px;">
<tr>
<th style="width:40%;">#ARGUMENTS.bmuName# User</th>
<th style="width:40%;">Ticket No.</th>
<th style="width:20%;">#ARGUMENTS.bmuName# Action Status</th>
</tr>
<tr>
<td>
<cfif ARGUMENTS.bmaID LTE 2 AND (ARGUMENTS.bmUserID EQ session.userID)>
<cfselect name="bm#ARGUMENTS.bmuName#UserID" required="yes" message="Please select a #ARGUMENTS.bmuName#.">
<option value="0">N/A</option>
<cfoutput query="getBuildManagerServerUserRelRet">
<option value="#userID#" <cfif ARGUMENTS.bmUserID EQ userID>selected</cfif>>#userFName# #userLName# (#bmsutName#)</option>
</cfoutput> 
</cfselect>
<br />
<span class="small">Choose a #ARGUMENTS.bmuName# user to be responsible for system deployments (if applicable).</span>
<cfelse>
<a href="//#application.mcmsAppPublicPath#/email_form/?toEmail=#ARGUMENTS.bmUserEmail#&subject=Build #ARGUMENTS.bmID# (#ARGUMENTS.bmuName#)" target="_blank">
<span class="glyphicon glyphicon-envelope"></span>#ARGUMENTS.bmUserFName# #ARGUMENTS.bmUserLName#</a>
<cfinput type="hidden" name="bm#ARGUMENTS.bmuName#UserID" value="#ARGUMENTS.bmUserID#" />
</cfif>
</td>
<td>
<cfif ARGUMENTS.bmUserID EQ session.userID>
<cfinput type="text" name="bm#ARGUMENTS.bmuName#TicketNo" maxlength="16" size="8" required="yes" message="Please include a #ARGUMENTS.bmuName# Ticket No." value="#Iif(ARGUMENTS.bmUserTicketNo EQ 0, DE(ARGUMENTS.bmTicketNo), DE(ARGUMENTS.bmUserTicketNo))#" /><br />
<span class="small">Enter an alternative ticket number. (if applicable).</span>
<cfelse>
#Iif(ARGUMENTS.bmUserTicketNo EQ 0, DE(ARGUMENTS.bmTicketNo), DE(ARGUMENTS.bmUserTicketNo))#
<cfinput type="hidden" name="bm#ARGUMENTS.bmuName#TicketNo" value="#Iif(ARGUMENTS.bmUserTicketNo EQ 0, DE(ARGUMENTS.bmTicketNo), DE(ARGUMENTS.bmUserTicketNo))#" />
</cfif>
</td>
<td>
<!---If the build action is for a System user.--->
<cfif ARGUMENTS.bmUserID EQ session.userID>
<cfselect name="bmua#ARGUMENTS.bmuName#ID" query="getBuildManagerUserActionFilterRet" display="bmuaName" value="ID" selected="#ARGUMENTS.bmuaID#" queryPosition="below">
</cfselect>
<cftooltip sourcefortooltip="/#application.mcmsAppAdminPath#/tooltip/index.cfm?mcmsToolTip=#ARGUMENTS.bmuName#ActionStatus"><span class="glyphicon glyphicon-question-sign"></span></cftooltip>
<cfelse>
#ARGUMENTS.bmuaName#
<cfinput type="hidden" name="bmua#ARGUMENTS.bmuName#ID" value="#ARGUMENTS.bmuaID#" />
</cfif>
</td>
</tr>
<tr>
<td colspan="3">
<h3>#ARGUMENTS.bmuName# Notes</h3>
<cfif ARGUMENTS.bmUserID EQ session.userID>
<cftextarea name="bm#ARGUMENTS.bmuName#Notes" wrap="virtual" richtext="no" cols="100" rows="6">
#ARGUMENTS.bmUserNotes#
</cftextarea>
<cfelse>
<cfif ARGUMENTS.bmUserNotes EQ ''>
None.
<cfelse>
<span id="bmNotes">#ARGUMENTS.bmUserNotes#</span>
</cfif>
<cfinput name="bm#ARGUMENTS.bmuName#Notes" type="hidden" value="#ARGUMENTS.bmUserNotes#" />
</cfif>
</td>
</tr>
</table>
</cfif>
</cfcase>

<!---DEPLOYER--->
<cfcase value="Deployer">
<!---Do not display if there is no Deployer user.--->
<cfif ARGUMENTS.bmUserID EQ 0>
<cfinput type="hidden" name="bm#ARGUMENTS.bmuName#UserID" value="#ARGUMENTS.bmUserID#" />
<cfinput type="hidden" name="bm#ARGUMENTS.bmuName#TicketNo" value="#Iif(ARGUMENTS.bmUserTicketNo EQ 0, DE(ARGUMENTS.bmTicketNo), DE(ARGUMENTS.bmUserTicketNo))#" />
<cfinput type="hidden" name="bmua#ARGUMENTS.bmuName#ID" value="#ARGUMENTS.bmuaID#" />
<cfinput type="hidden" name="bm#ARGUMENTS.bmuName#Notes" value="#ARGUMENTS.bmUserNotes#" />
<!---Only display if it is the Deployer or Developer user.--->
<cfelseif ARGUMENTS.bmUserID NEQ session.userID AND ARGUMENTS.bmDeveloperUserID NEQ session.userID>
<cfinput type="hidden" name="bm#ARGUMENTS.bmuName#UserID" value="#ARGUMENTS.bmUserID#" />
<cfinput type="hidden" name="bm#ARGUMENTS.bmuName#TicketNo" value="#Iif(ARGUMENTS.bmUserTicketNo EQ 0, DE(ARGUMENTS.bmTicketNo), DE(ARGUMENTS.bmUserTicketNo))#" />
<cfinput type="hidden" name="bmua#ARGUMENTS.bmuName#ID" value="#ARGUMENTS.bmuaID#" />
<cfinput type="hidden" name="bm#ARGUMENTS.bmuName#Notes" value="#ARGUMENTS.bmUserNotes#" />
<cfelse>
<h2>#ARGUMENTS.bmuName#</h2>
<table id="mainTableAlt" style="padding:0px;">
<tr>
<th style="width:40%;">#ARGUMENTS.bmuName# User</th>
<th style="width:40%;">Ticket No.</th>
<th style="width:20%;">#ARGUMENTS.bmuName# Action Status</th>
</tr>
<tr>
<td>
<cfif ARGUMENTS.bmaID LTE 2 AND (ARGUMENTS.bmUserID EQ session.userID)>
<cfselect name="bm#ARGUMENTS.bmuName#UserID" required="yes" message="Please select a #ARGUMENTS.bmuName#.">
<option value="0">N/A</option>
<cfoutput query="getBuildManagerServerUserRelRet">
<option value="#userID#" <cfif ARGUMENTS.bmUserID EQ userID>selected</cfif>>#userFName# #userLName# (#bmsutName#)</option>
</cfoutput> 
</cfselect>
<br />
<span class="small">Choose a #ARGUMENTS.bmuName# user to be responsible for build deployments (if applicable).</span>
<cfelse>
<a href="/#application.mcmsAppPublicPath#/email_form/?toEmail=#ARGUMENTS.bmUserEmail#&subject=Build #ARGUMENTS.bmID# (#ARGUMENTS.bmuName#)" target="_blank">
<span class="glyphicon glyphicon-envelope"></span>#ARGUMENTS.bmUserFName# #ARGUMENTS.bmUserLName#</a>
<cfinput type="hidden" name="bm#ARGUMENTS.bmuName#UserID" value="#ARGUMENTS.bmUserID#" />
</cfif>
</td>
<td>
<cfif ARGUMENTS.bmUserID EQ session.userID>
<cfinput type="text" name="bm#ARGUMENTS.bmuName#TicketNo" maxlength="16" size="8" required="yes" message="Please include a #ARGUMENTS.bmuName# Ticket No." value="#Iif(ARGUMENTS.bmUserTicketNo EQ 0, DE(ARGUMENTS.bmTicketNo), DE(ARGUMENTS.bmUserTicketNo))#" /><br />
<span class="small">Enter an alternative ticket number. (if applicable).</span>
<cfelse>
#Iif(ARGUMENTS.bmUserTicketNo EQ 0, DE(ARGUMENTS.bmTicketNo), DE(ARGUMENTS.bmUserTicketNo))#
<cfinput type="hidden" name="bm#ARGUMENTS.bmuName#TicketNo" value="#Iif(ARGUMENTS.bmUserTicketNo EQ 0, DE(ARGUMENTS.bmTicketNo), DE(ARGUMENTS.bmUserTicketNo))#" />
</cfif>
</td>
<td>
<!---If the build action is for a Deployer.--->
<cfif ARGUMENTS.bmUserID EQ session.userID>
<cfselect name="bmua#ARGUMENTS.bmuName#ID" query="getBuildManagerUserActionFilterRet" display="bmuaName" value="ID" selected="#ARGUMENTS.bmuaID#" queryPosition="below">
</cfselect>
<cftooltip sourcefortooltip="/#application.mcmsAppAdminPath#/tooltip/index.cfm?mcmsToolTip=#ARGUMENTS.bmuName#ActionStatus"><span class="glyphicon glyphicon-question-sign"></span></cftooltip>
<cfelse>
#ARGUMENTS.bmuaName#
<cfinput type="hidden" name="bmua#ARGUMENTS.bmuName#ID" value="#ARGUMENTS.bmuaID#" />
</cfif>
</td>
</tr>
<tr>
<td colspan="3">
<h3>#ARGUMENTS.bmuName# Notes</h3>
<cfif ARGUMENTS.bmUserID EQ session.userID>
<cftextarea name="bm#ARGUMENTS.bmuName#Notes" wrap="virtual" richtext="no" cols="100" rows="6">
#ARGUMENTS.bmUserNotes#
</cftextarea>
<cfelse>
<cfif ARGUMENTS.bmUserNotes EQ ''>
None.
<cfelse>
<span id="bmNotes">#ARGUMENTS.bmUserNotes#</span>
</cfif>
<cfinput name="bm#ARGUMENTS.bmuName#Notes" type="hidden" value="#ARGUMENTS.bmUserNotes#" />
</cfif>
</td>
</tr>
</table>
</cfif>
</cfcase>
</cfswitch> 
</cfsavecontent>
<!--</cfform> DO NOT REMOVE-->
<!---Catch any errors.--->
<cfcatch type="any">
<cfset result = StructNew()>
<cfset result.message = "There was an error with the query.">

</cfcatch>
</cftry>
<cfreturn result>
</cffunction>

<cffunction name="setBuildManagerServerPropertyFile" access="package" returntype="void" hint="Create the build server properties file." output="no">
<cfargument name="bmsID" type="numeric" required="yes" default="0">
<cfargument name="rollback" type="string" required="yes" default="false">
<cftry>
<!---Get all the properties for this build.--->
<cfinvoke 
component="/#application.mcmsAppAdminPath#/build_manager/component/BuildManager"
method="getBuildManagerPropertyServerValueRel"
returnvariable="getBuildManagerPropertyServerValueRelRet">
<cfinvokeargument name="bmsID" value="#ARGUMENTS.bmsID#"/>
<!---If the build is set to rollback, ignore targets to so they can be overridden to be rollback..--->
<cfif ARGUMENTS.rollback EQ 'true'>
<cfinvokeargument name="excludeBMPTID" value="11"/>
</cfif>
<cfinvokeargument name="bmpsvrStatus" value="1,2,3"/>
</cfinvoke>
<cfinvoke 
component="/#application.mcmsAppAdminPath#/build_manager/component/BuildManager"
method="getBuildManagerServer"
returnvariable="getBuildManagerServerRet">
<cfinvokeargument name="ID" value="#ARGUMENTS.bmsID#"/>
<cfinvokeargument name="bmsStatus" value="1,2,3"/>
</cfinvoke>
<cfset propertyValueList = ''>
<!---Create struct to collect path to place build files.--->
<cfset result = StructNew()>
<!---Create the property for the server type.--->
<cfset result['build.server.type'] = getBuildManagerServerRet.bmstName>
<!---Create vars for this operation.--->
<cfoutput query="getBuildManagerPropertyServerValueRelRet">
<cfset result[bmpName] = bmpsvrValue>
</cfoutput>
<cfsavecontent variable="propertyValueList">
<cfprocessingdirective suppresswhitespace="yes">
<cfoutput query="getBuildManagerPropertyServerValueRelRet" group="bmptID">
<!--#bmptName#: #bmptDescription#-->#chr(13)#
<cfoutput>#bmpName##chr(61)##bmpsvrValue##chr(13)#</cfoutput>
</cfoutput>
<!---If the build is set to rollback, set the rollback and svn targets to true and all others to false.--->
<cfif ARGUMENTS.rollback EQ 'true'>
<cfinvoke 
component="/#application.mcmsAppAdminPath#/build_manager/component/BuildManager"
method="getBuildManagerPropertyServerValueRel"
returnvariable="getBuildManagerPropertyServerValueRelRet">
<cfinvokeargument name="bmsID" value="103"/>
<cfinvokeargument name="bmptID" value="11"/>
<cfinvokeargument name="bmpsvrStatus" value="1,2,3"/>
</cfinvoke>
<cfoutput query="getBuildManagerPropertyServerValueRelRet">
<cfif bmpName EQ 'rollback' OR bmpName EQ 'ant4cf.deploy'>
#bmpName##chr(61)#true#chr(13)#
<cfelse>
#bmpName##chr(61)#false#chr(13)#
</cfif>
</cfoutput>
</cfif>
</cfprocessingdirective>
</cfsavecontent>
<!---Check to see the file directory exists and create variants of folders.--->
<cfset buildFilePath = "#result.cf.server.root#/#result.cf.build.server.instance#/#result.build.dir#/build/#result.build.name#/#result.build.server.type#">
<cfif NOT DirectoryExists(buildFilePath)>
<cfdirectory action="create" directory="#buildFilePath#">
</cfif>
<cffile action="write" file="#buildFilePath#/#result.build.name#.properties" output="#propertyValueList#" addnewline="no" fixnewline="no" nameconflict="overwrite" />    
<!---Catch any errors.--->
<cfcatch type="any">
<cfset result = StructNew()>
<cfset result.message = "There was an error with the build server properties file creation.">

</cfcatch>
</cftry>
</cffunction>

<cffunction name="setBuildManagerBuildPropertyFile" access="package" returntype="void" hint="Create the build value properties file.">
<cfargument name="bmID" type="numeric" required="yes" default="0">
<cftry>
<!---Get all the build values for this build.--->
<cfinvoke 
component="/#application.mcmsAppAdminPath#/build_manager/component/BuildManager"
method="getBuildManager"
returnvariable="getBuildManagerRet">
<cfinvokeargument name="ID" value="#ARGUMENTS.bmID#"/>
<cfinvokeargument name="bmStatus" value="1,2,3"/>
</cfinvoke>
<!---Get all the properties for this build.--->
<cfinvoke 
component="/#application.mcmsAppAdminPath#/build_manager/component/BuildManager"
method="getBuildManagerPropertyServerValueRel"
returnvariable="getBuildManagerPropertyServerValueRelRet">
<cfinvokeargument name="bmsID" value="#getBuildManagerRet.bmsID#"/>
<cfinvokeargument name="bmpsvrStatus" value="1,2,3"/>
</cfinvoke>
<cfset result = StructNew()>
<cfset propertyValueList = ''>
<!---Create struct to collect path to place build files.--->
<!---Create the property for the server type.--->
<cfset result['build.server.type'] = getBuildManagerRet.bmstName>
<cfsilent>
<cfoutput query="getBuildManagerPropertyServerValueRelRet">
<cfset result[bmpName] = bmpsvrValue>
</cfoutput>
</cfsilent>
<!---Check to see the file directory exists and create variants of folders.--->
<cfset buildFilePath = "#result.cf.server.root#/#result.cf.build.server.instance#/#result.build.dir#/build/#result.build.name#/#result.build.server.type#">
<cfset buildName = result.build.name>
<cfif NOT DirectoryExists(buildFilePath)>
<cfdirectory action="create" directory="#buildFilePath#">
</cfif>
<cfset buildValueList = ''>
<!---Create struct to collect path to place build files.--->
<cfsavecontent variable="buildValueList">
<cfoutput query="getBuildManagerRet">
<cfset build.no = ID>
<cfset build.revision = bmRevisionNo>
<cfset build.rollback.revision = bmRollbackRevisionNo>
<!--Build Values-->#chr(13)#
build.no=#ID##chr(13)#
build.revision=#bmRevisionNo##chr(13)#
build.rollback.revision=#bmRollbackRevisionNo##chr(13)#
build.server.type=#bmstName##chr(13)#
</cfoutput>
</cfsavecontent>
<cffile action="write" file="#buildFilePath#/#buildName#_build_no_#build.no#.properties" output="#buildValueList#" addnewline="yes" fixnewline="yes" nameconflict="overwrite" />    
<!---Catch any errors.--->
<cfcatch type="any">
<cfset result = StructNew()>
<cfset result.message = "There was an error with the build properties file creation.">

</cfcatch>
</cftry>
</cffunction>

<cffunction name="setBuild" access="public" returntype="any" hint="Execute a build.">
<cfargument name="bmID" type="numeric" required="yes" default="0">
<cfargument name="bmaID" type="numeric" required="yes" default="0">
<cfargument name="bmDeployerNotes" type="string" required="yes">
<cfargument name="userID" type="numeric" required="yes" default="0">
<cfset result.message = 'The build was successful.'>
<cftry>
<!---Get the server information for this build.--->
<cfinvoke 
component="/#application.mcmsAppAdminPath#/build_manager/component/BuildManager"
method="getBuildManager"
returnvariable="getBuildManagerRet">
<cfinvokeargument name="ID" value="#ARGUMENTS.bmID#"/>
<cfinvokeargument name="bmStatus" value="1,3"/>
</cfinvoke>
<cfif getBuildManagerRet.recordcount EQ 0>
<cfset result.message = 'No build result could be found or your access is denied.'>
<!---Do not allow the developer to deploy a PROD build.--->
<cfelseif getBuildManagerRet.bmDeveloperUserID EQ ARGUMENTS.userID AND getBuildManagerRet.bmstID EQ 3>
<cfset result.message = 'A build cannot be deployed by a Developer to PROD! Only DEV or TEST deployments can be deployed by a Developer.'>
<cfelse>
<!---Create struct to pass to the thread.--->
<cfset result = StructNew()>
<cfset result['build.number'] = getBuildManagerRet.ID>
<cfset result['build.revision'] = getBuildManagerRet.bmRevisionNo>
<cfset result['build.rollback.revision'] = getBuildManagerRet.bmRollbackRevisionNo>
<cfset result['build.server.type'] = getBuildManagerRet.bmstName>
<cfset result['bmsID'] = getBuildManagerRet.bmsID>
<cfset result['bmaID'] = getBuildManagerRet.bmaID>
<cfset result['build.action.name'] = getBuildManagerRet.bmaName>
<cfset result['build.notes'] = getBuildManagerRet.bmNotes>
<cfset result['developer.username'] = getBuildManagerRet.userFNameDeveloper & ' ' & getBuildManagerRet.userLNameDeveloper>
<cfset result['developer.email'] = getBuildManagerRet.userEmailDeveloper>
<cfset result['deployer.username'] = getBuildManagerRet.userFNameDeployer & ' ' & getBuildManagerRet.userLNameDeployer>
<cfset result['deployer.email'] = getBuildManagerRet.userEmailDeployer>
<cfset result['database.username'] = getBuildManagerRet.userFNameDatabase & ' ' & getBuildManagerRet.userLNameDatabase>
<cfset result['database.email'] = getBuildManagerRet.userEmailDatabase>
<cfset result['system.username'] = getBuildManagerRet.userFNameSystem & ' ' & getBuildManagerRet.userLNameSystem>
<cfset result['system.email'] = getBuildManagerRet.userEmailSystem>
<cfset result['developer.action.id'] = getBuildManagerRet.bmuaDeveloperID>
<cfset result['developer.action.name'] = getBuildManagerRet.bmuaNameDeveloper>
<cfset result['deployer.action.id'] = getBuildManagerRet.bmuaDeployerID>
<cfset result['deployer.action.name'] = getBuildManagerRet.bmuaNameDeployer>
<cfset result['database.action.id'] = getBuildManagerRet.bmuaDatabaseID>
<cfset result['database.action.name'] = getBuildManagerRet.bmuaNameDatabase>
<cfset result['system.action.id'] = getBuildManagerRet.bmuaSystemID>
<cfset result['system.action.name'] = getBuildManagerRet.bmuaNameSystem>

<!---Get properties to add to struct.--->
<cfinvoke 
component="/#application.mcmsAppAdminPath#/build_manager/component/BuildManager"
method="getBuildManagerPropertyServerValueRel"
returnvariable="getBuildManagerPropertyServerValueRelRet">
<cfinvokeargument name="bmsID" value="#result.bmsID#"/>
<cfinvokeargument name="bmpsvrStatus" value="1,3"/>
</cfinvoke>

<!---Build vars outside of the structure to bypass any issues with a property name (Safe Guard).--->
<cfsilent>
<cfoutput query="getBuildManagerPropertyServerValueRelRet">
<cfset result[bmpName] = bmpsvrValue>
</cfoutput>
</cfsilent>

<!---Create paths and file names for logging.--->
<cfset result['build.file.path'] = "#result.cf.server.root#/#result.cf.build.server.instance#/#result.build.dir#">
<cfset result['build.file'] = "#result.build.file#">
<cfset result['build.property.file.path'] = "#result.cf.server.root#/#result.cf.build.server.instance#/#result.build.dir#/build/#result.build.name#/#result.build.server.type#">
<cfset result['build.server.property.file'] = "#result.build.name#.properties">
<cfset result['build.value.property.file'] = "#result.build.name#_build_no_#result.build.number#.properties">
<cfset result['build.log.path'] = "#result.cf.server.root#/#result.cf.build.server.instance#/#result.build.dir#/build/#result.build.name#/#result.build.server.type#/log">
<cfset result['build.log.file'] = "#result.build.number#_#result.build.name#_#DateFormat(Now(), 'mmddyyy')#_#TimeFormat(Now(), 'HHnntt')#_log.txt">
<cfset result['build.error.log.path'] = "#result.cf.server.root#/#result.cf.build.server.instance#/#result.build.dir#/build/#result.build.name#/#result.build.server.type#/log">

<!---Check to see the file directory exists and create variants of folders.--->
<cfif NOT DirectoryExists(result.build.file.path)>
<cfdirectory action="create" directory="#result.build.file.path#">
</cfif>
<cfif NOT DirectoryExists(result.build.log.path)>
<cfdirectory action="create" directory="#result.build.log.path#">
</cfif>

<cfset result['build.error.log.file'] = "#result.build.number#_#result.build.name#_#DateFormat(Now(), 'mmddyyy')#_#TimeFormat(Now(), 'HHnntt')#_error_log.txt">

<!---Get CGI data for linking to log files.--->
<cfset result['build.url'] = 'http://' & CGI.HTTP_HOST>
<cfset result['build.url.log'] =  '#result.build.dir#/build/#result.build.name#/#result.build.server.type#/log'> 
<cfset result['build.url.properties'] =  '#result.build.dir#/build/#result.build.name#/#result.build.server.type#'>

<!---Check to see if it is a rollback.--->
<cfif ARGUMENTS.bmaID EQ 6>
<!---Create the log for the build.--->
<cfset this.bmlLog = "The build has been rolled-back to revision no. #result.build.rollback.revision# and is ready for testing.">
<cfinvoke 
component="/#application.mcmsAppAdminPath#/build_manager/component/BuildManager"
method="updateBuildManagerActionStatus">
<cfinvokeargument name="bmID" value="#ARGUMENTS.bmID#"/>
<cfinvokeargument name="bmaID" value="12"/>
<cfinvokeargument name="bmlLog" value="#this.bmlLog#"/>
<cfinvokeargument name="bmDeployerNotes" value="#ARGUMENTS.bmDeployerNotes#"/>
</cfinvoke>

<!---Now update the build properties file to do a rollback.--->
<!---Create the build server properties file.--->
<cfinvoke 
component="/#application.mcmsAppAdminPath#/build_manager/component/BuildManager"
method="setBuildManagerServerPropertyFile">
<cfinvokeargument name="bmsID" value="#result.bmsID#"/>
<cfinvokeargument name="rollback" value="true"/>
</cfinvoke>
<!---Rollback the build.--->
<!---Run the thread.--->
<cfthread name="#result.build.name#" action="run" priority="high" args="#result#">
<!---Run the build.--->
<cfexecute name="#result.build.command.path#/#result.build.command.exe#" arguments="/c ant -buildfile #result.build.file.path#/#result.build.file# -propertyfile #result.build.property.file.path#/#result.build.server.property.file# -propertyfile #result.build.property.file.path#/#result.build.value.property.file#" outputfile="#result.build.log.path#/#result.build.log.file#" errorfile="#result.build.error.log.path#/#result.build.error.log.file#" timeout="1200"/>
<!---When the build is deployed.--->
<cfif result.bmaID EQ 6>
<cfmail type="html" subject="#result.build.name# (#result.build.server.type#) Rollback Revision No.: #result.build.rollback.revision#- Build No.: #result.build.number# - Rollback" to="#result.developer.email#" cc="#result.build.help.desk.email#" from="#result.mail.from#">
#result.build.name# (#result.build.server.type#) Revision No.: #result.build.revision# - Build No.: #result.build.number# - Deployed<br /><br />
The build has been rolled back for '#result.build.name#' by '#result.deployer.username#'.<br /><br />
Notes: #result.build.notes#<br /><br />	
Review the logs to confirm the builds status and success. If you are connected to the build network use the links below.  Otherwise, sign in to the Build Manager server to review the logs.<br />
<br />
Build Log: <a href="#result.build.url#/#result.build.url.log#/#result.build.log.file#">#result.build.log.file#</a><br />
Error Log: <a href="#result.build.url#/#result.build.url.log#/#result.build.error.log.file#">#result.build.error.log.file#</a><br />
Build Server Properties File: <a href="#result.build.url#/#result.build.url.properties#/#result.build.server.property.file#">#result.build.server.property.file#</a><br>
Build Value Properties File: <a href="#result.build.url#/#result.build.url.properties#/#result.build.value.property.file#">#result.build.value.property.file#</a><br>
</cfmail>
</cfif>
</cfthread>

<cfelse>
<!---Deploy the build.--->
<!---Create the log for the build.--->
<cfset this.bmlLog = "The build has been deployed and is ready for testing.">
<cfinvoke 
component="/#application.mcmsAppAdminPath#/build_manager/component/BuildManager"
method="updateBuildManagerActionStatus">
<cfinvokeargument name="bmID" value="#ARGUMENTS.bmID#"/>
<cfinvokeargument name="bmaID" value="11"/>
<cfinvokeargument name="bmlLog" value="#this.bmlLog#"/>
<cfinvokeargument name="bmDeployerNotes" value="#ARGUMENTS.bmDeployerNotes#"/>
</cfinvoke>

<!---Run the thread.--->
<cfthread name="#result.build.name#" action="run" priority="high" args="#result#">
<!---Run the build.--->
<cfexecute name="#result.build.command.path#/#result.build.command.exe#" arguments="/c ant -buildfile #result.build.file.path#/#result.build.file# -propertyfile #result.build.property.file.path#/#result.build.server.property.file# -propertyfile #result.build.property.file.path#/#result.build.value.property.file#" outputfile="#result.build.log.path#/#result.build.log.file#" errorfile="#result.build.error.log.path#/#result.build.error.log.file#" timeout="1200"/>
<!---When the build is deployed.--->
<cfif result.bmaID EQ 4>
<cfmail type="html" subject="#result.build.name# (#result.build.server.type#) Revision No.: #result.build.revision#- Build No.: #result.build.number# - Deployed" to="#result.developer.email#" cc="#result.build.help.desk.email#" from="#result.mail.from#">
<!---Add attachments.--->
<cfmailparam file="#result.build.url#/#result.build.url.log#/#result.build.log.file#">
<cfmailparam file="#result.build.url#/#result.build.url.log#/#result.build.error.log.file#">
<cfmailparam file="#result.build.url#/#result.build.url.properties#/#result.build.server.property.file#">
<cfmailparam file="#result.build.url#/#result.build.url.properties#/#result.build.value.property.file#">
#result.build.name# (#result.build.server.type#) Revision No.: #result.build.revision# - Build No.: #result.build.number# - Deployed<br /><br />
The build has been deployed for '#result.build.name#' by '#result.deployer.username#'.<br /><br />
Notes: #result.build.notes#<br /><br />	
Review the attached logs to confirm the builds status and success. Otherwise, sign in to the Build Manager server to review the logs.
</cfmail>
</cfif>
</cfthread>
</cfif>
</cfif>
<!---Catch any errors.--->
<cfcatch type="any">
<cfset result = StructNew()>
<cfset result.message = "There was an error with the query.">

<!---Update the status to error.--->
<cfinvoke 
component="/#application.mcmsAppAdminPath#/build_manager/component/BuildManager"
method="updateBuildManagerActionStatus">
<cfinvokeargument name="bmID" value="#ARGUMENTS.bmID#"/>
<cfinvokeargument name="bmaID" value="12"/>
<cfinvokeargument name="bmlLog" value="An error occured when deploying the build using the setBuild function. A rollback may be required or some manual intervention."/>
<cfinvokeargument name="bmDeployerNotes" value="#ARGUMENTS.bmDeployerNotes#"/>
</cfinvoke>
</cfcatch>
</cftry>
<cfreturn result>
</cffunction>

<cffunction name="getBuildManagerLog" access="public" returntype="query" hint="Get Build Manager Log data.">
<cfargument name="keywords" type="string" required="yes" default="All">
<cfargument name="ID" type="numeric" required="yes" default="0">
<cfargument name="excludeID" type="numeric" required="yes" default="0">
<cfargument name="bmID" type="string" required="yes" default="0">
<cfargument name="bmaID" type="string" required="yes" default="0">
<cfargument name="bmauID" type="string" required="yes" default="0">
<cfargument name="bmsID" type="string" required="yes" default="0">
<cfargument name="bmltID" type="string" required="yes" default="0">
<cfargument name="userID" type="string" required="yes" default="0">
<cfargument name="bmlStatus" type="string" required="yes" default="1,3">
<cfargument name="orderBy" type="string" required="yes" default="bmsName, bmlDate DESC">
<cfset var rsBuildManagerLog = "" >
<cftry>
<cfquery name="rsBuildManagerLog" datasource="#application.mcmsDSN#">
SELECT * FROM v_build_manager_log WHERE 0=0
<cfif ARGUMENTS.ID NEQ 0>
AND ID = <cfqueryparam value="#ARGUMENTS.ID#" cfsqltype="cf_sql_integer">
</cfif>
<cfif ARGUMENTS.excludeID NEQ 0>
AND ID <> <cfqueryparam value="#ARGUMENTS.excludeID#" cfsqltype="cf_sql_integer">
</cfif>
<cfif ARGUMENTS.keywords NEQ 'All'>
<cfloop list="#ARGUMENTS.keywords#" delimiters=" " index="kw">
AND (UPPER(bmsName) LIKE <cfqueryparam value="%#UCASE(kw)#%" cfsqltype="cf_sql_varchar"> OR UPPER(userFName) LIKE <cfqueryparam value="%#UCASE(kw)#%" cfsqltype="cf_sql_varchar"> OR UPPER(userLName) LIKE <cfqueryparam value="%#UCASE(kw)#%" cfsqltype="cf_sql_varchar">)
</cfloop>
</cfif>
<cfif ARGUMENTS.bmID NEQ 0>
AND bmID IN (<cfqueryparam value="#ARGUMENTS.bmID#" list="yes" cfsqltype="cf_sql_integer">)
</cfif>
<cfif ARGUMENTS.bmsID NEQ 0>
AND bmsID IN (<cfqueryparam value="#ARGUMENTS.bmsID#" list="yes" cfsqltype="cf_sql_integer">)
</cfif>
<cfif ARGUMENTS.bmaID NEQ 0>
AND bmaID IN (<cfqueryparam value="#ARGUMENTS.bmaID#" list="yes" cfsqltype="cf_sql_integer">)
</cfif>
<cfif ARGUMENTS.bmauID NEQ 0>
AND bmauID IN (<cfqueryparam value="#ARGUMENTS.bmauID#" list="yes" cfsqltype="cf_sql_integer">)
</cfif>
<cfif ARGUMENTS.bmltID NEQ 0>
AND bmltID IN (<cfqueryparam value="#ARGUMENTS.bmltID#" list="yes" cfsqltype="cf_sql_integer">)
</cfif>
<cfif ARGUMENTS.userID NEQ 0>
AND userID IN (<cfqueryparam value="#ARGUMENTS.userID#" list="yes" cfsqltype="cf_sql_integer">)
</cfif>
AND bmlStatus IN (<cfqueryparam value="#ARGUMENTS.bmlStatus#" list="yes" cfsqltype="cf_sql_integer">)
ORDER BY #ARGUMENTS.orderBy#
</cfquery>
<!---Catch any errors.--->
<cfcatch type="any">
<cfset rsBuildManagerLog = StructNew()>
<cfset rsBuildManagerLog.message = "There was an error with the query.">

</cfcatch>
</cftry>
<cfreturn rsBuildManagerLog>
</cffunction>

<cffunction name="getBuildManagerProperty" access="public" returntype="query" hint="Get Build Manager Property Log data.">
<cfargument name="keywords" type="string" required="yes" default="All">
<cfargument name="ID" type="numeric" required="yes" default="0">
<cfargument name="excludeID" type="numeric" required="yes" default="0">
<cfargument name="bmpName" type="string" required="yes" default="">
<cfargument name="bmptID" type="string" required="yes" default="0">
<cfargument name="bmpStatus" type="string" required="yes" default="1,3">
<cfargument name="orderBy" type="string" required="yes" default="bmptID,bmpSort,bmpName">
<cfset var rsBuildManagerProperty = "" >
<cftry>
<cfquery name="rsBuildManagerProperty" datasource="#application.mcmsDSN#">
SELECT * FROM v_build_manager_property WHERE 0=0
<cfif ARGUMENTS.ID NEQ 0>
AND ID = <cfqueryparam value="#ARGUMENTS.ID#" cfsqltype="cf_sql_integer">
</cfif>
<cfif ARGUMENTS.excludeID NEQ 0>
AND ID <> <cfqueryparam value="#ARGUMENTS.excludeID#" cfsqltype="cf_sql_integer">
</cfif>
<cfif ARGUMENTS.keywords NEQ 'All'>
<cfloop list="#ARGUMENTS.keywords#" delimiters=" " index="kw">
AND (UPPER(bmpName) LIKE <cfqueryparam value="%#UCASE(kw)#%" cfsqltype="cf_sql_varchar"> OR UPPER(bmpDescription) LIKE <cfqueryparam value="%#UCASE(kw)#%" cfsqltype="cf_sql_varchar">)
</cfloop>
</cfif>
<cfif ARGUMENTS.bmptID NEQ 0>
AND bmptID IN (<cfqueryparam value="#ARGUMENTS.bmptID#" list="yes" cfsqltype="cf_sql_integer">)
</cfif>
<cfif ARGUMENTS.bmpName NEQ "">
AND UPPER(bmpName) = <cfqueryparam value="#UCASE(ARGUMENTS.bmpName)#" cfsqltype="cf_sql_varchar">
</cfif>
AND bmpStatus IN (<cfqueryparam value="#ARGUMENTS.bmpStatus#" list="yes" cfsqltype="cf_sql_integer">)
ORDER BY #ARGUMENTS.orderBy#
</cfquery>
<!---Catch any errors.--->
<cfcatch type="any">
<cfset rsBuildManagerProperty = StructNew()>
<cfset rsBuildManagerProperty.message = "There was an error with the query.">

</cfcatch>
</cftry>
<cfreturn rsBuildManagerProperty>
</cffunction>

<cffunction name="getBuildManagerPropertyServerValueRel" access="public" returntype="query" hint="Get Build Manager Property Server Value Rel. data.">
<cfargument name="keywords" type="string" required="yes" default="All">
<cfargument name="ID" type="numeric" required="yes" default="0">
<cfargument name="excludeID" type="numeric" required="yes" default="0">
<cfargument name="excludebmptID" type="string" required="yes" default="0">
<cfargument name="bmpID" type="numeric" required="yes" default="0">
<cfargument name="bmptID" type="numeric" required="yes" default="0">
<cfargument name="bmpName" type="string" required="yes" default="">
<cfargument name="bmsID" type="numeric" required="yes" default="0">
<cfargument name="userID" type="numeric" required="yes" default="0">
<cfargument name="bmpsvrStatus" type="string" required="yes" default="1,3">
<cfargument name="orderBy" type="string" required="yes" default="bmptID,bmpSort,bmpName">
<cfset var rsBuildManagerPropertyServerValueRel = "" >
<cftry>
<cfquery name="rsBuildManagerPropertyServerValueRel" datasource="#application.mcmsDSN#">
SELECT * FROM v_bm_p_server_value_rel WHERE 0=0
<cfif ARGUMENTS.ID NEQ 0>
AND ID = <cfqueryparam value="#ARGUMENTS.ID#" cfsqltype="cf_sql_integer">
</cfif>
<cfif ARGUMENTS.excludeID NEQ 0>
AND ID <> <cfqueryparam value="#ARGUMENTS.excludeID#" cfsqltype="cf_sql_integer">
</cfif>
<cfif ARGUMENTS.excludebmptID NEQ 0>
AND bmptID NOT IN (<cfqueryparam value="#ARGUMENTS.excludebmptID#" list="yes" cfsqltype="cf_sql_integer">)
</cfif>
<cfif ARGUMENTS.keywords NEQ 'All'>
<cfloop list="#ARGUMENTS.keywords#" delimiters=" " index="kw">
AND (UPPER(bmpName) LIKE <cfqueryparam value="%#UCASE(kw)#%" cfsqltype="cf_sql_varchar"> OR UPPER(bmpDescription) LIKE <cfqueryparam value="%#UCASE(kw)#%" cfsqltype="cf_sql_varchar"> OR UPPER(bmsName) LIKE <cfqueryparam value="%#UCASE(kw)#%" cfsqltype="cf_sql_varchar"> OR UPPER(bmsDescription) LIKE <cfqueryparam value="%#UCASE(kw)#%" cfsqltype="cf_sql_varchar">)
</cfloop>
</cfif>
<cfif ARGUMENTS.bmpName NEQ "">
AND UPPER(bmpName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.bmpName)#%" cfsqltype="cf_sql_varchar">
</cfif>
<cfif ARGUMENTS.bmpID NEQ 0>
AND bmpID = <cfqueryparam value="#ARGUMENTS.bmpID#" cfsqltype="cf_sql_integer">
</cfif>
<cfif ARGUMENTS.bmptID NEQ 0>
AND bmptID = <cfqueryparam value="#ARGUMENTS.bmptID#" cfsqltype="cf_sql_integer">
</cfif>
<cfif ARGUMENTS.bmsID NEQ 0>
AND bmsID = <cfqueryparam value="#ARGUMENTS.bmsID#" cfsqltype="cf_sql_integer">
</cfif>
<cfif ARGUMENTS.userID NEQ 0>
AND userID = <cfqueryparam value="#ARGUMENTS.userID#" cfsqltype="cf_sql_integer">
</cfif>
AND bmpsvrStatus IN (<cfqueryparam value="#ARGUMENTS.bmpsvrStatus#" list="yes" cfsqltype="cf_sql_integer">)
ORDER BY #ARGUMENTS.orderBy#
</cfquery>
<!---Catch any errors.--->
<cfcatch type="any">
<cfset rsBuildManagerPropertyServerValueRel = StructNew()>
<cfset rsBuildManagerPropertyServerValueRel.message = "There was an error with the query.">

</cfcatch>
</cftry>
<cfreturn rsBuildManagerPropertyServerValueRel>
</cffunction>

<cffunction name="getBuildManagerDocumentRel" access="public" returntype="query" hint="Get Build Manager Document Rel. data.">
<cfargument name="keywords" type="string" required="yes" default="All">
<cfargument name="ID" type="numeric" required="yes" default="0">
<cfargument name="excludeID" type="numeric" required="yes" default="0">
<cfargument name="bmID" type="numeric" required="yes" default="0">
<cfargument name="bmsID" type="numeric" required="yes" default="0">
<cfargument name="docID" type="numeric" required="yes" default="0">
<cfargument name="userID" type="numeric" required="yes" default="0">
<cfargument name="bmdrStatus" type="string" required="yes" default="1,3">
<cfargument name="orderBy" type="string" required="yes" default="docSort,docName">
<cfset var rsBuildManagerDocumentRel = "" >
<cftry>
<cfquery name="rsBuildManagerDocumentRel" datasource="#application.mcmsDSN#">
SELECT * FROM v_bm_document_rel WHERE 0=0
<cfif ARGUMENTS.ID NEQ 0>
AND ID = <cfqueryparam value="#ARGUMENTS.ID#" cfsqltype="cf_sql_integer">
</cfif>
<cfif ARGUMENTS.excludeID NEQ 0>
AND ID <> <cfqueryparam value="#ARGUMENTS.excludeID#" cfsqltype="cf_sql_integer">
</cfif>
<cfif ARGUMENTS.keywords NEQ 'All'>
<cfloop list="#ARGUMENTS.keywords#" delimiters=" " index="kw">
AND (UPPER(docName) LIKE <cfqueryparam value="%#UCASE(kw)#%" cfsqltype="cf_sql_varchar"> OR UPPER(bmName) LIKE <cfqueryparam value="%#UCASE(kw)#%" cfsqltype="cf_sql_varchar"> OR UPPER(bmDescription) LIKE <cfqueryparam value="%#UCASE(kw)#%" cfsqltype="cf_sql_varchar"> OR UPPER(bmsName) LIKE <cfqueryparam value="%#UCASE(kw)#%" cfsqltype="cf_sql_varchar"> OR UPPER(bmsDescription) LIKE <cfqueryparam value="%#UCASE(kw)#%" cfsqltype="cf_sql_varchar">)
</cfloop>
</cfif>
<cfif ARGUMENTS.bmID NEQ 0>
AND bmID = <cfqueryparam value="#ARGUMENTS.bmID#" cfsqltype="cf_sql_integer">
</cfif>
<cfif ARGUMENTS.bmsID NEQ 0>
AND bmsID = <cfqueryparam value="#ARGUMENTS.bmsID#" cfsqltype="cf_sql_integer">
</cfif>
<cfif ARGUMENTS.docID NEQ 0>
AND docID = <cfqueryparam value="#ARGUMENTS.docID#" cfsqltype="cf_sql_integer">
</cfif>
<cfif ARGUMENTS.userID NEQ 0>
AND userID = <cfqueryparam value="#ARGUMENTS.userID#" cfsqltype="cf_sql_integer">
</cfif>
AND bmdrStatus IN (<cfqueryparam value="#ARGUMENTS.bmdrStatus#" list="yes" cfsqltype="cf_sql_integer">)
ORDER BY #ARGUMENTS.orderBy#
</cfquery>
<!---Catch any errors.--->
<cfcatch type="any">
<cfset rsBuildManagerDocumentRel = StructNew()>
<cfset rsBuildManagerDocumentRel.message = "There was an error with the query.">

</cfcatch>
</cftry>
<cfreturn rsBuildManagerDocumentRel>
</cffunction>

<cffunction name="getBuildManagerServer" access="public" returntype="query" hint="Get Build Manager Server data.">
<cfargument name="keywords" type="string" required="yes" default="All">
<cfargument name="ID" type="numeric" required="yes" default="0">
<cfargument name="excludeID" type="numeric" required="yes" default="0">
<cfargument name="bmsName" type="string" required="yes" default="">
<cfargument name="bmstID" type="string" required="yes" default="0">
<cfargument name="bmsStatus" type="string" required="yes" default="1,3">
<cfargument name="orderBy" type="string" required="yes" default="bmsName">
<cfset var rsBuildManagerServer = "" >
<cftry>
<cfquery name="rsBuildManagerServer" datasource="#application.mcmsDSN#">
SELECT * FROM v_build_manager_server WHERE 0=0
<cfif ARGUMENTS.ID NEQ 0>
AND ID = <cfqueryparam value="#ARGUMENTS.ID#" cfsqltype="cf_sql_integer">
</cfif>
<cfif ARGUMENTS.excludeID NEQ 0>
AND ID <> <cfqueryparam value="#ARGUMENTS.excludeID#" cfsqltype="cf_sql_integer">
</cfif>
<cfif ARGUMENTS.keywords NEQ 'All'>
<cfloop list="#ARGUMENTS.keywords#" delimiters=" " index="kw">
AND (UPPER(bmsName) LIKE <cfqueryparam value="%#UCASE(kw)#%" cfsqltype="cf_sql_varchar"> OR UPPER(bmsDescription) LIKE <cfqueryparam value="%#UCASE(kw)#%" cfsqltype="cf_sql_varchar">)
</cfloop>
</cfif>
<cfif ARGUMENTS.bmsName NEQ "">
AND UPPER(bmsName) = <cfqueryparam value="#UCASE(ARGUMENTS.bmsName)#" cfsqltype="cf_sql_varchar">
</cfif>
<cfif ARGUMENTS.bmstID NEQ 0>
AND bmstID = <cfqueryparam value="#ARGUMENTS.bmstID#" cfsqltype="cf_sql_integer">
</cfif>
AND bmsStatus IN (<cfqueryparam value="#ARGUMENTS.bmsStatus#" list="yes" cfsqltype="cf_sql_integer">)
ORDER BY #ARGUMENTS.orderBy#
</cfquery>
<!---Catch any errors.--->
<cfcatch type="any">
<cfset rsBuildManagerServer = StructNew()>
<cfset rsBuildManagerServer.message = "There was an error with the query.">

</cfcatch>
</cftry>
<cfreturn rsBuildManagerServer>
</cffunction>

<cffunction name="getBuildManagerServerSetting" access="public" returntype="query" hint="Get Build Manager Server Setting data.">
<cfargument name="keywords" type="string" required="yes" default="All">
<cfargument name="ID" type="numeric" required="yes" default="0">
<cfargument name="excludeID" type="numeric" required="yes" default="0">
<cfargument name="bmssName" type="string" required="yes" default="">
<cfargument name="bmsstID" type="string" required="yes" default="0">
<cfargument name="userID" type="string" required="yes" default="0">
<cfargument name="bmssStatus" type="string" required="yes" default="1,3">
<cfargument name="orderBy" type="string" required="yes" default="bmssName">
<cfset var rsBuildManagerServerSetting = "" >
<cftry>
<cfquery name="rsBuildManagerServerSetting" datasource="#application.mcmsDSN#">
SELECT * FROM v_bm_server_setting WHERE 0=0
<cfif ARGUMENTS.ID NEQ 0>
AND ID = <cfqueryparam value="#ARGUMENTS.ID#" cfsqltype="cf_sql_integer">
</cfif>
<cfif ARGUMENTS.excludeID NEQ 0>
AND ID <> <cfqueryparam value="#ARGUMENTS.excludeID#" cfsqltype="cf_sql_integer">
</cfif>
<cfif ARGUMENTS.keywords NEQ 'All'>
<cfloop list="#ARGUMENTS.keywords#" delimiters=" " index="kw">
AND (UPPER(bmssName) LIKE <cfqueryparam value="%#UCASE(kw)#%" cfsqltype="cf_sql_varchar"> OR UPPER(bmssDescription) LIKE <cfqueryparam value="%#UCASE(kw)#%" cfsqltype="cf_sql_varchar">)
</cfloop>
</cfif>
<cfif ARGUMENTS.bmsstID NEQ 0>
AND bmsstID = <cfqueryparam value="#ARGUMENTS.bmsttID#" cfsqltype="cf_sql_integer">
</cfif>
<cfif ARGUMENTS.userID NEQ 0>
AND userID = <cfqueryparam value="#ARGUMENTS.userID#" cfsqltype="cf_sql_integer">
</cfif>
<cfif ARGUMENTS.bmssName NEQ "">
AND UPPER(bmssName) = <cfqueryparam value="#UCASE(ARGUMENTS.bmssName)#" cfsqltype="cf_sql_varchar">
</cfif>
AND bmssStatus IN (<cfqueryparam value="#ARGUMENTS.bmssStatus#" list="yes" cfsqltype="cf_sql_integer">)
ORDER BY #ARGUMENTS.orderBy#
</cfquery>
<!---Catch any errors.--->
<cfcatch type="any">
<cfset rsBuildManagerServerSetting = StructNew()>
<cfset rsBuildManagerServerSetting.message = "There was an error with the query.">

</cfcatch>
</cftry>
<cfreturn rsBuildManagerServerSetting>
</cffunction>

<cffunction name="getBuildManagerServerSettingRel" access="public" returntype="query" hint="Get Build Manager Server Setting Rel. data.">
<cfargument name="keywords" type="string" required="yes" default="All">
<cfargument name="ID" type="numeric" required="yes" default="0">
<cfargument name="excludeID" type="numeric" required="yes" default="0">
<cfargument name="bmsID" type="string" required="yes" default="0">
<cfargument name="bmssID" type="string" required="yes" default="0">
<cfargument name="bmssrStatus" type="string" required="yes" default="1,3">
<cfargument name="orderBy" type="string" required="yes" default="bmsName">
<cfset var rsBuildManagerServerSettingRel = "" >
<cftry>
<cfquery name="rsBuildManagerServerSettingRel" datasource="#application.mcmsDSN#">
SELECT * FROM v_bm_server_setting_rel WHERE 0=0
<cfif ARGUMENTS.ID NEQ 0>
AND ID = <cfqueryparam value="#ARGUMENTS.ID#" cfsqltype="cf_sql_integer">
</cfif>
<cfif ARGUMENTS.excludeID NEQ 0>
AND ID <> <cfqueryparam value="#ARGUMENTS.excludeID#" cfsqltype="cf_sql_integer">
</cfif>
<cfif ARGUMENTS.keywords NEQ 'All'>
<cfloop list="#ARGUMENTS.keywords#" delimiters=" " index="kw">
AND (UPPER(bmsName) LIKE <cfqueryparam value="%#UCASE(kw)#%" cfsqltype="cf_sql_varchar"> OR UPPER(bmsDescription) LIKE <cfqueryparam value="%#UCASE(kw)#%" cfsqltype="cf_sql_varchar">)
</cfloop>
</cfif>
<cfif ARGUMENTS.bmsID NEQ 0>
AND bmsID = <cfqueryparam value="#ARGUMENTS.bmsID#" cfsqltype="cf_sql_integer">
</cfif>
<cfif ARGUMENTS.bmssID NEQ 0>
AND bmssID = <cfqueryparam value="#ARGUMENTS.bmssID#" cfsqltype="cf_sql_integer">
</cfif>
AND bmssrStatus IN (<cfqueryparam value="#ARGUMENTS.bmssrStatus#" list="yes" cfsqltype="cf_sql_integer">)
ORDER BY #ARGUMENTS.orderBy#
</cfquery>
<!---Catch any errors.--->
<cfcatch type="any">
<cfset rsBuildManagerServerSettingRel = StructNew()>
<cfset rsBuildManagerServerSettingRel.message = "There was an error with the query.">

</cfcatch>
</cftry>
<cfreturn rsBuildManagerServerSettingRel>
</cffunction>

<cffunction name="getBuildManagerTarget" access="public" returntype="query" hint="Get Build Manager Target data.">
<cfargument name="keywords" type="string" required="yes" default="All">
<cfargument name="ID" type="numeric" required="yes" default="0">
<cfargument name="excludeID" type="numeric" required="yes" default="0">
<cfargument name="bmtName" type="string" required="yes" default="">
<cfargument name="bmtStatus" type="string" required="yes" default="1,3">
<cfargument name="orderBy" type="string" required="yes" default="bmtRequired DESC,bmtSort,bmtName">
<cfset var rsBuildManagerTarget = "" >
<cftry>
<cfquery name="rsBuildManagerTarget" datasource="#application.mcmsDSN#">
SELECT * FROM v_build_manager_target WHERE 0=0
<cfif ARGUMENTS.ID NEQ 0>
AND ID = <cfqueryparam value="#ARGUMENTS.ID#" cfsqltype="cf_sql_integer">
</cfif>
<cfif ARGUMENTS.excludeID NEQ 0>
AND ID <> <cfqueryparam value="#ARGUMENTS.excludeID#" cfsqltype="cf_sql_integer">
</cfif>
<cfif ARGUMENTS.keywords NEQ 'All'>
<cfloop list="#ARGUMENTS.keywords#" delimiters=" " index="kw">
AND (UPPER(bmtName) LIKE <cfqueryparam value="%#UCASE(kw)#%" cfsqltype="cf_sql_varchar"> OR UPPER(bmtDescription) LIKE <cfqueryparam value="%#UCASE(kw)#%" cfsqltype="cf_sql_varchar">)
</cfloop>
</cfif>
<cfif ARGUMENTS.bmtName NEQ "">
AND UPPER(bmtName) = <cfqueryparam value="#UCASE(ARGUMENTS.bmtName)#" cfsqltype="cf_sql_varchar">
</cfif>
AND bmtStatus IN (<cfqueryparam value="#ARGUMENTS.bmtStatus#" list="yes" cfsqltype="cf_sql_integer">)
ORDER BY #ARGUMENTS.orderBy#
</cfquery>
<!---Catch any errors.--->
<cfcatch type="any">
<cfset rsBuildManagerTarget = StructNew()>
<cfset rsBuildManagerTarget.message = "There was an error with the query.">

</cfcatch>
</cftry>
<cfreturn rsBuildManagerTarget>
</cffunction>

<cffunction name="getBuildManagerServerTargetRel" access="public" returntype="query" hint="Get Build Manager Server Target Rel. data.">
<cfargument name="keywords" type="string" required="yes" default="All">
<cfargument name="ID" type="numeric" required="yes" default="0">
<cfargument name="excludeID" type="numeric" required="yes" default="0">
<cfargument name="bmsID" type="string" required="yes" default="0">
<cfargument name="bmtID" type="string" required="yes" default="0">
<cfargument name="bmstrStatus" type="string" required="yes" default="1,3">
<cfargument name="orderBy" type="string" required="yes" default="bmsName">
<cfset var rsBuildManagerServerTargetRel = "" >
<cftry>
<cfquery name="rsBuildManagerServerTargetRel" datasource="#application.mcmsDSN#">
SELECT * FROM v_bm_server_target_rel WHERE 0=0
<cfif ARGUMENTS.ID NEQ 0>
AND ID = <cfqueryparam value="#ARGUMENTS.ID#" cfsqltype="cf_sql_integer">
</cfif>
<cfif ARGUMENTS.excludeID NEQ 0>
AND ID <> <cfqueryparam value="#ARGUMENTS.excludeID#" cfsqltype="cf_sql_integer">
</cfif>
<cfif ARGUMENTS.keywords NEQ 'All'>
<cfloop list="#ARGUMENTS.keywords#" delimiters=" " index="kw">
AND (UPPER(bmsName) LIKE <cfqueryparam value="%#UCASE(kw)#%" cfsqltype="cf_sql_varchar"> OR UPPER(bmtName) LIKE <cfqueryparam value="%#UCASE(kw)#%" cfsqltype="cf_sql_varchar">)
</cfloop>
</cfif>
<cfif ARGUMENTS.bmsID NEQ 0>
AND bmsID = <cfqueryparam value="#ARGUMENTS.bmsID#" cfsqltype="cf_sql_integer">
</cfif>
<cfif ARGUMENTS.bmtID NEQ 0>
AND bmtID = <cfqueryparam value="#ARGUMENTS.bmtID#" cfsqltype="cf_sql_integer">
</cfif>
AND bmstrStatus IN (<cfqueryparam value="#ARGUMENTS.bmstrStatus#" list="yes" cfsqltype="cf_sql_integer">)
ORDER BY #ARGUMENTS.orderBy#
</cfquery>
<!---Catch any errors.--->
<cfcatch type="any">
<cfset rsBuildManagerServerTargetRel = StructNew()>
<cfset rsBuildManagerServerTargetRel.message = "There was an error with the query.">

</cfcatch>
</cftry>
<cfreturn rsBuildManagerServerTargetRel>
</cffunction>

<cffunction name="getBuildManagerServerUserRel" access="public" returntype="query" hint="Get Build Manager Server User Rel. data.">
<cfargument name="keywords" type="string" required="yes" default="All">
<cfargument name="ID" type="numeric" required="yes" default="0">
<cfargument name="excludeID" type="numeric" required="yes" default="0">
<cfargument name="bmsID" type="string" required="yes" default="0">
<cfargument name="userID" type="string" required="yes" default="0">
<cfargument name="bmsutID" type="string" required="yes" default="0">
<cfargument name="bmsurStatus" type="string" required="yes" default="1,3">
<cfargument name="orderBy" type="string" required="yes" default="bmsName">
<cfset var rsBuildManagerServerUserRel = "" >
<cftry>
<cfquery name="rsBuildManagerServerUserRel" datasource="#application.mcmsDSN#">
SELECT * FROM v_bm_server_user_rel WHERE 0=0
<cfif ARGUMENTS.ID NEQ 0>
AND ID = <cfqueryparam value="#ARGUMENTS.ID#" cfsqltype="cf_sql_integer">
</cfif>
<cfif ARGUMENTS.excludeID NEQ 0>
AND ID <> <cfqueryparam value="#ARGUMENTS.excludeID#" cfsqltype="cf_sql_integer">
</cfif>
<cfif ARGUMENTS.keywords NEQ 'All'>
<cfloop list="#ARGUMENTS.keywords#" delimiters=" " index="kw">
AND (UPPER(bmsName) LIKE <cfqueryparam value="%#UCASE(kw)#%" cfsqltype="cf_sql_varchar"> OR UPPER(bmsDescription) LIKE <cfqueryparam value="%#UCASE(kw)#%" cfsqltype="cf_sql_varchar">)
</cfloop>
</cfif>
<cfif ARGUMENTS.bmsID NEQ 0>
AND bmsID = <cfqueryparam value="#ARGUMENTS.bmsID#" cfsqltype="cf_sql_integer">
</cfif>
<cfif ARGUMENTS.userID NEQ 0>
AND userID = <cfqueryparam value="#ARGUMENTS.userID#" cfsqltype="cf_sql_integer">
</cfif>
<cfif ARGUMENTS.bmsutID NEQ 0>
AND bmsutID IN (<cfqueryparam value="#ARGUMENTS.bmsutID#" list="yes" cfsqltype="cf_sql_integer">)
</cfif>
AND bmsurStatus IN (<cfqueryparam value="#ARGUMENTS.bmsurStatus#" list="yes" cfsqltype="cf_sql_integer">)
ORDER BY #ARGUMENTS.orderBy#
</cfquery>
<!---Catch any errors.--->
<cfcatch type="any">
<cfset rsBuildManagerServerUserRel = StructNew()>
<cfset rsBuildManagerServerUserRel.message = "There was an error with the query.">

</cfcatch>
</cftry>
<cfreturn rsBuildManagerServerUserRel>
</cffunction>

<cffunction name="getBuildManagerRequestType" access="public" returntype="query" hint="Get Build Manager Request Type data.">
<cfargument name="keywords" type="string" required="yes" default="All">
<cfargument name="ID" type="numeric" required="yes" default="0">
<cfargument name="excludeID" type="numeric" required="yes" default="0">
<cfargument name="bmrtName" type="string" required="yes" default="">
<cfargument name="bmrtStatus" type="string" required="yes" default="1,3">
<cfargument name="orderBy" type="string" required="yes" default="bmrtName">
<cfset var rsBuildManagerRequestType = "" >
<cftry>
<cfquery name="rsBuildManagerRequestType" datasource="#application.mcmsDSN#">
SELECT * FROM v_build_manager_request_type WHERE 0=0
<cfif ARGUMENTS.ID NEQ 0>
AND ID = <cfqueryparam value="#ARGUMENTS.ID#" cfsqltype="cf_sql_integer">
</cfif>
<cfif ARGUMENTS.excludeID NEQ 0>
AND ID <> <cfqueryparam value="#ARGUMENTS.excludeID#" cfsqltype="cf_sql_integer">
</cfif>
<cfif ARGUMENTS.keywords NEQ 'All'>
<cfloop list="#ARGUMENTS.keywords#" delimiters=" " index="kw">
AND (UPPER(bmrtName) LIKE <cfqueryparam value="%#UCASE(kw)#%" cfsqltype="cf_sql_varchar"> OR UPPER(bmrtDescription) LIKE <cfqueryparam value="%#UCASE(kw)#%" cfsqltype="cf_sql_varchar">)
</cfloop>
</cfif>
<cfif ARGUMENTS.bmrtName NEQ "">
AND UPPER(bmrtName) = <cfqueryparam value="#UCASE(ARGUMENTS.bmrtName)#" cfsqltype="cf_sql_varchar">
</cfif>
AND bmrtStatus IN (<cfqueryparam value="#ARGUMENTS.bmrtStatus#" list="yes" cfsqltype="cf_sql_integer">)
ORDER BY #ARGUMENTS.orderBy#
</cfquery>
<!---Catch any errors.--->
<cfcatch type="any">
<cfset rsBuildManagerRequestType = StructNew()>
<cfset rsBuildManagerRequestType.message = "There was an error with the query.">

</cfcatch>
</cftry>
<cfreturn rsBuildManagerRequestType>
</cffunction>

<cffunction name="getBuildManagerServerType" access="public" returntype="query" hint="Get Build Manager Server Type data.">
<cfargument name="keywords" type="string" required="yes" default="All">
<cfargument name="ID" type="numeric" required="yes" default="0">
<cfargument name="excludeID" type="numeric" required="yes" default="0">
<cfargument name="bmstName" type="string" required="yes" default="">
<cfargument name="bmstStatus" type="string" required="yes" default="1,3">
<cfargument name="orderBy" type="string" required="yes" default="bmstName">
<cfset var rsBuildManagerServerType = "" >
<cftry>
<cfquery name="rsBuildManagerServerType" datasource="#application.mcmsDSN#">
SELECT * FROM v_build_manager_server_type WHERE 0=0
<cfif ARGUMENTS.ID NEQ 0>
AND ID = <cfqueryparam value="#ARGUMENTS.ID#" cfsqltype="cf_sql_integer">
</cfif>
<cfif ARGUMENTS.excludeID NEQ 0>
AND ID <> <cfqueryparam value="#ARGUMENTS.excludeID#" cfsqltype="cf_sql_integer">
</cfif>
<cfif ARGUMENTS.keywords NEQ 'All'>
<cfloop list="#ARGUMENTS.keywords#" delimiters=" " index="kw">
AND (UPPER(bmstName) LIKE <cfqueryparam value="%#UCASE(kw)#%" cfsqltype="cf_sql_varchar"> OR UPPER(bmstDescription) LIKE <cfqueryparam value="%#UCASE(kw)#%" cfsqltype="cf_sql_varchar">)
</cfloop>
</cfif>
<cfif ARGUMENTS.bmstName NEQ "">
AND UPPER(bmstName) = <cfqueryparam value="#UCASE(ARGUMENTS.bmstName)#" cfsqltype="cf_sql_varchar">
</cfif>
AND bmstStatus IN (<cfqueryparam value="#ARGUMENTS.bmstStatus#" list="yes" cfsqltype="cf_sql_integer">)
ORDER BY #ARGUMENTS.orderBy#
</cfquery>
<!---Catch any errors.--->
<cfcatch type="any">
<cfset rsBuildManagerServerType = StructNew()>
<cfset rsBuildManagerServerType.message = "There was an error with the query.">

</cfcatch>
</cftry>
<cfreturn rsBuildManagerServerType>
</cffunction>

<cffunction name="getBuildManagerServerUserType" access="public" returntype="query" hint="Get Build Manager Server User Type data.">
<cfargument name="keywords" type="string" required="yes" default="All">
<cfargument name="ID" type="numeric" required="yes" default="0">
<cfargument name="excludeID" type="numeric" required="yes" default="0">
<cfargument name="bmsutName" type="string" required="yes" default="">
<cfargument name="bmsutStatus" type="string" required="yes" default="1,3">
<cfargument name="orderBy" type="string" required="yes" default="bmsutName">
<cfset var rsBuildManagerServerUserType = "" >
<cftry>
<cfquery name="rsBuildManagerServerUserType" datasource="#application.mcmsDSN#">
SELECT * FROM v_bm_server_user_type WHERE 0=0
<cfif ARGUMENTS.ID NEQ 0>
AND ID = <cfqueryparam value="#ARGUMENTS.ID#" cfsqltype="cf_sql_integer">
</cfif>
<cfif ARGUMENTS.excludeID NEQ 0>
AND ID <> <cfqueryparam value="#ARGUMENTS.excludeID#" cfsqltype="cf_sql_integer">
</cfif>
<cfif ARGUMENTS.keywords NEQ 'All'>
<cfloop list="#ARGUMENTS.keywords#" delimiters=" " index="kw">
AND (UPPER(bmsutName) LIKE <cfqueryparam value="%#UCASE(kw)#%" cfsqltype="cf_sql_varchar"> OR UPPER(bmsutDescription) LIKE <cfqueryparam value="%#UCASE(kw)#%" cfsqltype="cf_sql_varchar">)
</cfloop>
</cfif>
<cfif ARGUMENTS.bmsutName NEQ "">
AND UPPER(bmsutName) = <cfqueryparam value="#UCASE(ARGUMENTS.bmsutName)#" cfsqltype="cf_sql_varchar">
</cfif>
AND bmsutStatus IN (<cfqueryparam value="#ARGUMENTS.bmsutStatus#" list="yes" cfsqltype="cf_sql_integer">)
ORDER BY #ARGUMENTS.orderBy#
</cfquery>
<!---Catch any errors.--->
<cfcatch type="any">
<cfset rsBuildManagerServerUserType = StructNew()>
<cfset rsBuildManagerServerUserType.message = "There was an error with the query.">

</cfcatch>
</cftry>
<cfreturn rsBuildManagerServerUserType>
</cffunction>

<cffunction name="getBuildManagerTestGroup" access="public" returntype="query" hint="Get Build Manager Test Group data.">
<cfargument name="keywords" type="string" required="yes" default="All">
<cfargument name="ID" type="numeric" required="yes" default="0">
<cfargument name="excludeID" type="numeric" required="yes" default="0">
<cfargument name="bmtgName" type="string" required="yes" default="">
<cfargument name="bmtgStatus" type="string" required="yes" default="1,3">
<cfargument name="orderBy" type="string" required="yes" default="bmtgSort, bmtgName">
<cfset var rsBuildManagerTestGroup = "" >
<cftry>
<cfquery name="rsBuildManagerTestGroup" datasource="#application.mcmsDSN#">
SELECT * FROM v_bm_test_group WHERE 0=0
<cfif ARGUMENTS.ID NEQ 0>
AND ID = <cfqueryparam value="#ARGUMENTS.ID#" cfsqltype="cf_sql_integer">
</cfif>
<cfif ARGUMENTS.excludeID NEQ 0>
AND ID <> <cfqueryparam value="#ARGUMENTS.excludeID#" cfsqltype="cf_sql_integer">
</cfif>
<cfif ARGUMENTS.keywords NEQ 'All'>
<cfloop list="#ARGUMENTS.keywords#" delimiters=" " index="kw">
AND (UPPER(bmtgName) LIKE <cfqueryparam value="%#UCASE(kw)#%" cfsqltype="cf_sql_varchar"> OR UPPER(bmtgDescription) LIKE <cfqueryparam value="%#UCASE(kw)#%" cfsqltype="cf_sql_varchar">)
</cfloop>
</cfif>
<cfif ARGUMENTS.bmtgName NEQ "">
AND UPPER(bmtgName) = <cfqueryparam value="#UCASE(ARGUMENTS.bmsutName)#" cfsqltype="cf_sql_varchar">
</cfif>
AND bmtgStatus IN (<cfqueryparam value="#ARGUMENTS.bmtgStatus#" list="yes" cfsqltype="cf_sql_integer">)
ORDER BY #ARGUMENTS.orderBy#
</cfquery>
<!---Catch any errors.--->
<cfcatch type="any">
<cfset rsBuildManagerTestGroup = StructNew()>
<cfset rsBuildManagerTestGroup.message = "There was an error with the query.">

</cfcatch>
</cftry>
<cfreturn rsBuildManagerTestGroup>
</cffunction>

<cffunction name="getBuildManagerPropertyType" access="public" returntype="query" hint="Get Build Manager Property Type data.">
<cfargument name="keywords" type="string" required="yes" default="All">
<cfargument name="ID" type="numeric" required="yes" default="0">
<cfargument name="excludeID" type="numeric" required="yes" default="0">
<cfargument name="bmptName" type="string" required="yes" default="">
<cfargument name="bmptStatus" type="string" required="yes" default="1,3">
<cfargument name="orderBy" type="string" required="yes" default="bmptName">
<cfset var rsBuildManagerPropertyType = "" >
<cftry>
<cfquery name="rsBuildManagerPropertyType" datasource="#application.mcmsDSN#">
SELECT * FROM v_bm_property_type WHERE 0=0
<cfif ARGUMENTS.ID NEQ 0>
AND ID = <cfqueryparam value="#ARGUMENTS.ID#" cfsqltype="cf_sql_integer">
</cfif>
<cfif ARGUMENTS.excludeID NEQ 0>
AND ID <> <cfqueryparam value="#ARGUMENTS.excludeID#" cfsqltype="cf_sql_integer">
</cfif>
<cfif ARGUMENTS.keywords NEQ 'All'>
<cfloop list="#ARGUMENTS.keywords#" delimiters=" " index="kw">
AND (UPPER(bmptName) LIKE <cfqueryparam value="%#UCASE(kw)#%" cfsqltype="cf_sql_varchar"> OR UPPER(bmptDescription) LIKE <cfqueryparam value="%#UCASE(kw)#%" cfsqltype="cf_sql_varchar">)
</cfloop>
</cfif>
<cfif ARGUMENTS.bmptName NEQ "">
AND UPPER(bmptName) = <cfqueryparam value="#UCASE(ARGUMENTS.bmptName)#" cfsqltype="cf_sql_varchar">
</cfif>
AND bmptStatus IN (<cfqueryparam value="#ARGUMENTS.bmptStatus#" list="yes" cfsqltype="cf_sql_integer">)
ORDER BY #ARGUMENTS.orderBy#
</cfquery>
<!---Catch any errors.--->
<cfcatch type="any">
<cfset rsBuildManagerPropertyType = StructNew()>
<cfset rsBuildManagerPropertyType.message = "There was an error with the query.">

</cfcatch>
</cftry>
<cfreturn rsBuildManagerPropertyType>
</cffunction>

<cffunction name="getBuildManagerServerSettingType" access="public" returntype="query" hint="Get Build Manager Server Setting Type data.">
<cfargument name="keywords" type="string" required="yes" default="All">
<cfargument name="ID" type="numeric" required="yes" default="0">
<cfargument name="excludeID" type="numeric" required="yes" default="0">
<cfargument name="bmsstName" type="string" required="yes" default="">
<cfargument name="bmsstStatus" type="string" required="yes" default="1,3">
<cfargument name="orderBy" type="string" required="yes" default="bmsstSort, bmsstName">
<cfset var rsBuildManagerServerSettingType = "" >
<cftry>
<cfquery name="rsBuildManagerServerSettingType" datasource="#application.mcmsDSN#">
SELECT * FROM v_bm_server_setting_type WHERE 0=0
<cfif ARGUMENTS.ID NEQ 0>
AND ID = <cfqueryparam value="#ARGUMENTS.ID#" cfsqltype="cf_sql_integer">
</cfif>
<cfif ARGUMENTS.excludeID NEQ 0>
AND ID <> <cfqueryparam value="#ARGUMENTS.excludeID#" cfsqltype="cf_sql_integer">
</cfif>
<cfif ARGUMENTS.keywords NEQ 'All'>
<cfloop list="#ARGUMENTS.keywords#" delimiters=" " index="kw">
AND (UPPER(bmsstName) LIKE <cfqueryparam value="%#UCASE(kw)#%" cfsqltype="cf_sql_varchar"> OR UPPER(bmsstDescription) LIKE <cfqueryparam value="%#UCASE(kw)#%" cfsqltype="cf_sql_varchar">)
</cfloop>
</cfif>
<cfif ARGUMENTS.bmsstName NEQ "">
AND UPPER(bmsstName) = <cfqueryparam value="#UCASE(ARGUMENTS.bmsstName)#" cfsqltype="cf_sql_varchar">
</cfif>
AND bmsstStatus IN (<cfqueryparam value="#ARGUMENTS.bmsstStatus#" list="yes" cfsqltype="cf_sql_integer">)
ORDER BY #ARGUMENTS.orderBy#
</cfquery>
<!---Catch any errors.--->
<cfcatch type="any">
<cfset rsBuildManagerServerSettingType = StructNew()>
<cfset rsBuildManagerServerSettingType.message = "There was an error with the query.">

</cfcatch>
</cftry>
<cfreturn rsBuildManagerServerSettingType>
</cffunction>

<cffunction name="getBuildManagerReport" access="public" returntype="query" hint="Get Build Manager Report data.">
<cfargument name="keywords" type="string" required="yes" default="All">
<cfargument name="orderBy" type="string" required="yes" default="bmsName">
<cfset var rsBuildManagerReport = "" >
<cftry>
<cfquery name="rsBuildManagerReport" datasource="#application.mcmsDSN#">
SELECT bmsName AS Server, bmaName AS Build_Action, bmstName AS Server_Type, bmTicketNo AS Ticket_No, bmRevisionNo AS Revision_No, bmRollbackRevisionNo AS Rollback_Revision_No, bmDeployerTicketNo AS Deployer_Ticket_No, bmDatabaseTicketNo AS Database_Ticket_No, bmSystemTicketNo AS System_Ticket_No, bmuaNameDeveloper AS Developer_Action_Status, bmuaNameDeployer AS Deployer_Action_Status, bmuaNameDatabase AS Database_Action_Status, bmuaNameSystem AS System_Action_Status, bmuaNameTest AS Test_Action_Status, TO_CHAR(bmsDescription) AS Server_Description, TO_CHAR(bmDate, 'MM/DD/YYYY') AS Create_Date, TO_CHAR(bmDateRel, 'MM/DD/YYYY') AS Date_Update_Rel, TO_CHAR(bmDateUpdate, 'MM/DD/YYYY') AS Date_Update, bmTimeRel AS Time_Rel, TO_CHAR(bmNotes) AS Build_Notes, TO_CHAR(bmDeveloperNotes) AS Developer_Build_Notes, TO_CHAR(bmDeployerNotes) AS Deployer_Build_Notes, TO_CHAR(bmProjectNotes) AS Project_Build_Notes, TO_CHAR(bmDatabaseNotes) AS Database_Build_Notes, TO_CHAR(bmSystemNotes) AS System_Build_Notes, TO_CHAR(bmTestNotes) AS Test_Build_Notes, TO_CHAR(bmNotes) AS Build_Notes, userLNameDeveloper || ', ' || userFNameDeveloper AS Developer, userLNameDeployer || ', ' || userFNameDeployer AS Deployer, userLNameTest || ', ' || userFNameTest AS Tester, userLNameProject || ', ' || userFNameProject AS Project, userLNameDatabase || ', ' || userFNameDatabase AS Database, userLNameSystem || ', ' || userFNameSystem AS System, bmsDevURL as DEV_URL, bmsTestURL as TEST_URL, bmsPRODURL as PROD_URL, bmsProjectURL as PROJECT_URL, bmsTicketURL as TICKET_URL FROM v_build_manager WHERE 0=0
<cfif ARGUMENTS.keywords NEQ 'All'>
<cfloop list="#ARGUMENTS.keywords#" delimiters=" " index="kw">
AND (UPPER(bmsName) LIKE <cfqueryparam value="%#UCASE(kw)#%" cfsqltype="cf_sql_varchar"> OR UPPER(bmsDescription) LIKE <cfqueryparam value="%#UCASE(kw)#%" cfsqltype="cf_sql_varchar"> OR UPPER(bmaName) LIKE <cfqueryparam value="%#UCASE(kw)#%" cfsqltype="kw"> OR UPPER(bmaDescription) LIKE <cfqueryparam value="%#UCASE(kw)#%" cfsqltype="cf_sql_varchar">)
</cfloop>
</cfif>
ORDER BY #ARGUMENTS.orderBy#
</cfquery>
<!---Catch any errors.--->
<cfcatch type="any">
<cfset rsBuildManagerReport = StructNew()>
<cfset rsBuildManagerReport.message = "There was an error with the query.">

</cfcatch>
</cftry>
<cfreturn rsBuildManagerReport>
</cffunction>

<cffunction name="getBuildManagerServerReport" access="public" returntype="query" hint="Get Build Manager Server Report data.">
<cfargument name="keywords" type="string" required="yes" default="All">
<cfargument name="orderBy" type="string" required="yes" default="bmsName">
<cfset var rsBuildManagerServerReport = "" >
<cftry>
<cfquery name="rsBuildManagerServerReport" datasource="#application.mcmsDSN#">
SELECT bmsName AS Server, TO_CHAR(bmsDescription) AS Server_Description, TO_CHAR(bmsDate, 'MM/DD/YYYY') AS Server_Create_Date, TO_CHAR(bmsDateUpdate, 'MM/DD/YYYY') AS Date_Update, userLName || ', ' || userFName AS Username, bmstName AS Server_Type, bmsDevURL as DEV_URL, bmsTestURL as TEST_URL, bmsPRODURL as PROD_URL, bmsProjectURL as PROJECT_URL, bmsTicketURL as TICKET_URL FROM v_build_manager_server WHERE 0=0
<cfif ARGUMENTS.keywords NEQ 'All'>
<cfloop list="#ARGUMENTS.keywords#" delimiters=" " index="kw">
AND (UPPER(bmsName) LIKE <cfqueryparam value="%#UCASE(kw)#%" cfsqltype="cf_sql_varchar"> OR UPPER(bmsDescription) LIKE <cfqueryparam value="%#UCASE(kw)#%" cfsqltype="cf_sql_varchar">)
</cfloop>
</cfif>
ORDER BY #ARGUMENTS.orderBy#
</cfquery>
<!---Catch any errors.--->
<cfcatch type="any">
<cfset rsBuildManagerServerReport = StructNew()>
<cfset rsBuildManagerServerReport.message = "There was an error with the query.">

</cfcatch>
</cftry>
<cfreturn rsBuildManagerServerReport>
</cffunction>

<cffunction name="getBuildManagerPropertyReport" access="public" returntype="query" hint="Get Build Manager Property Report data.">
<cfargument name="keywords" type="string" required="yes" default="All">
<cfargument name="orderBy" type="string" required="yes" default="bmptName,bmpName">
<cfset var rsBuildManagerPropertyReport = "" >
<cftry>
<cfquery name="rsBuildManagerPropertyReport" datasource="#application.mcmsDSN#">
SELECT bmpName AS Property, TO_CHAR(bmpDescription) AS Property_Description, TO_CHAR(bmpDate, 'MM/DD/YYYY') AS Property_Create_Date, TO_CHAR(bmpDateUpdate, 'MM/DD/YYYY') AS Date_Update, bmptName AS Property_Type, bmpRequired AS Required, bmpRequiredMessage AS Required_Message, bmpDefaultValue AS Default_Value, bmpLOV AS LOV, bmpRegex AS Regex, userLName || ', ' || userFName AS Username FROM v_build_manager_property WHERE 0=0
<cfif ARGUMENTS.keywords NEQ 'All'>
<cfloop list="#ARGUMENTS.keywords#" delimiters=" " index="kw">
AND (UPPER(bmpName) LIKE <cfqueryparam value="%#UCASE(kw)#%" cfsqltype="cf_sql_varchar"> OR UPPER(bmpDescription) LIKE <cfqueryparam value="%#UCASE(kw)#%" cfsqltype="cf_sql_varchar">)
</cfloop>
</cfif>
ORDER BY #ARGUMENTS.orderBy#
</cfquery>
<!---Catch any errors.--->
<cfcatch type="any">
<cfset rsBuildManagerPropertyReport = StructNew()>
<cfset rsBuildManagerPropertyReport.message = "There was an error with the query.">

</cfcatch>
</cftry>
<cfreturn rsBuildManagerPropertyReport>
</cffunction>

<cffunction name="getBuildManagerTargetReport" access="public" returntype="query" hint="Get Build Manager Target Report data.">
<cfargument name="keywords" type="string" required="yes" default="All">
<cfargument name="orderBy" type="string" required="yes" default="bmtName">
<cfset var rsBuildManagerTargetReport = "" >
<cftry>
<cfquery name="rsBuildManagerTargetReport" datasource="#application.mcmsDSN#">
SELECT bmtName AS Target, TO_CHAR(bmtDescription) AS Target_Description, TO_CHAR(bmtDate, 'MM/DD/YYYY') AS Target_Create_Date, TO_CHAR(bmtDateUpdate, 'MM/DD/YYYY') AS Date_Update, bmtRequired AS Required, bmtRequiredMessage AS Required_Message, bmtFile AS Filename, userLName || ', ' || userFName AS Username FROM v_build_manager_target WHERE 0=0
<cfif ARGUMENTS.keywords NEQ 'All'>
<cfloop list="#ARGUMENTS.keywords#" delimiters=" " index="kw">
AND (UPPER(bmtName) LIKE <cfqueryparam value="%#UCASE(kw)#%" cfsqltype="cf_sql_varchar"> OR UPPER(bmtDescription) LIKE <cfqueryparam value="%#UCASE(kw)#%" cfsqltype="cf_sql_varchar">)
</cfloop>
</cfif>
ORDER BY #ARGUMENTS.orderBy#
</cfquery>
<!---Catch any errors.--->
<cfcatch type="any">
<cfset rsBuildManagerTargetReport = StructNew()>
<cfset rsBuildManagerTargetReport.message = "There was an error with the query.">

</cfcatch>
</cftry>
<cfreturn rsBuildManagerTargetReport>
</cffunction>

<cffunction name="insertBuildManagerLog" access="public" returntype="struct">
<cfargument name="bmID" type="numeric" required="yes" default="0">
<cfargument name="bmaID" type="numeric" required="yes" default="0">
<cfargument name="bmuaID" type="numeric" required="yes" default="0">
<cfargument name="bmlLog" type="string" required="yes">
<cfargument name="bmltID" type="numeric" required="yes">
<cfargument name="userID" type="numeric" required="yes" default="0">
<cfargument name="bmlStatus" type="numeric" required="yes" default="1">
<cfset result.message = "You have successfully inserted the record.">
<cftry>
<cftransaction>
<cfquery datasource="#application.mcmsDSN#">
INSERT INTO tbl_build_manager_log (bmID,bmaID,bmuaID,bmlLog,bmltID,userID,bmlStatus) VALUES
(
<cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.bmID#">,
<cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.bmaID#">,
<cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.bmuaID#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#TRIM(ARGUMENTS.bmlLog)#">,
<cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.bmltID#">,
<cfqueryparam cfsqltype="cf_sql_integer" value="#session.userID#">,
<cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.bmlStatus#">
)
</cfquery>
</cftransaction>
<cfcatch type="any">
<cfset result.message = "There was an error inserting the record.">

</cfcatch>
</cftry>
<cfreturn result>
</cffunction>

<cffunction name="insertBuildManager" access="public" returntype="struct">
<cfargument name="bmsID" type="numeric" required="yes">
<cfargument name="bmTicketNo" type="string" required="yes">
<cfargument name="bmTicketType" type="string" required="yes">
<cfargument name="bmRevisionNo" type="numeric" required="yes">
<cfargument name="bmRollbackRevisionNo" type="numeric" required="yes">
<cfargument name="bmDateRel" type="string" required="yes">
<cfargument name="bmTimeRel" type="string" required="yes">
<cfargument name="bmScheduleStatus" type="numeric" required="yes">
<cfargument name="bmNotes" type="string" required="yes">
<cfargument name="bmTestUserID" type="numeric" required="yes" default="0">
<cfargument name="bmProjectUserID" type="numeric" required="yes" default="0">
<cfargument name="bmDeployerUserID" type="numeric" required="yes" default="0">
<cfargument name="bmDatabaseUserID" type="numeric" required="yes" default="0">
<cfargument name="bmSystemUserID" type="numeric" required="yes" default="0">
<cfargument name="bmStatus" type="numeric" required="yes" default="1">
<cfset result.message = "You have successfully inserted the record. You will now be redirected to complete the build.">
<cftry>
<!---Check for a duplicate record.--->
<cfinvoke 
component="/#application.mcmsAppAdminPath#/build_manager/component/BuildManager"
method="getBuildManager"
returnvariable="getCheckBuildManagerRet">
<cfinvokeargument name="bmsID" value="#ARGUMENTS.bmsID#"/>
<cfinvokeargument name="bmTicketNo" value="#ARGUMENTS.bmTicketNo#"/>
<cfinvokeargument name="bmRevisionNo" value="#ARGUMENTS.bmRevisionNo#"/>
<cfinvokeargument name="bmStatus" value="1,2,3"/>
</cfinvoke>
<cfif getCheckBuildManagerRet.recordcount NEQ 0>
<cfset result.message = "The ticket #ARGUMENTS.bmTicketNo# already exists with revision #ARGUMENTS.bmRevisionNo#, please try again.">
<!---Check length restriction.--->
<cfelseif LEN(ARGUMENTS.bmNotes) GT 4000>
<cfset result.message = "The notes are longer than 4000 characters, please adjust the notes to under 4000 characters.">
<cfelse>
<cftransaction>
<cfquery datasource="#application.mcmsDSN#">
INSERT INTO tbl_build_manager (bmsID,bmaID,bmTicketNo,bmTicketType,bmRevisionNo,bmRollbackRevisionNo,bmDateRel,bmTimeRel,bmScheduleStatus,bmNotes,bmTestUserID,bmDeveloperUserID,bmProjectUserID,bmDeployerUserID,bmDatabaseUserID,bmSystemUserID,bmStatus) VALUES
(
<cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.bmsID#">,
<cfqueryparam cfsqltype="cf_sql_integer" value="1">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.bmTicketNo#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.bmTicketType#">,
<cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.bmRevisionNo#">,
<cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.bmRollbackRevisionNo#">,
<cfqueryparam cfsqltype="cf_sql_date" value="#DateFormat(ARGUMENTS.bmDateRel, application.dateFormat)#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.bmTimeRel#">,
<cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.bmScheduleStatus#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.bmNotes#">,
<cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.bmTestUserID#">,
<cfqueryparam cfsqltype="cf_sql_integer" value="#session.userID#">,
<cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.bmProjectUserID#">,
<cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.bmDeployerUserID#">,
<cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.bmDatabaseUserID#">,
<cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.bmSystemUserID#">,
<cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.bmStatus#">
)
</cfquery>
</cftransaction>
<!---Get bmID for record just inserted.--->
<cfinvoke 
component="MCMS.component.Cms"
method="getMaxValueSQL"
returnvariable="bmID">
<cfinvokeargument name="tableName" value="tbl_build_manager"/>
</cfinvoke>
<cfset this.bmID = bmID>

<!---Create the build value properties file.--->
<cfinvoke 
component="/#application.mcmsAppAdminPath#/build_manager/component/BuildManager"
method="setBuildManagerBuildPropertyFile">
<cfinvokeargument name="bmID" value="#this.bmID#"/>
</cfinvoke>

<!---Determine whether or not to schedule the build.--->
<cfinvoke 
component="/#application.mcmsAppAdminPath#/build_manager/component/BuildManager"
method="setBuildManagerSchedule"
returnvariable="setBuildManagerScheduleRet">
<cfinvokeargument name="bmID" value="#this.bmID#"/>
<cfinvokeargument name="bmaID" value="1"/>
<cfinvokeargument name="bmDateRel" value="#ARGUMENTS.bmDateRel#"/>
<cfinvokeargument name="bmTimeRel" value="#ARGUMENTS.bmTimeRel#"/>
<cfinvokeargument name="bmScheduleStatus" value="#ARGUMENTS.bmScheduleStatus#"/>
</cfinvoke>

<!---Insert a log record.--->
<cfinvoke 
component="/#application.mcmsAppAdminPath#/build_manager/component/BuildManager"
method="insertBuildManagerLog">
<cfinvokeargument name="bmID" value="#this.bmID#"/>
<cfinvokeargument name="userID" value="#session.userID#"/>
<cfinvokeargument name="bmlLog" value="Build #this.bmID# for Revison No. #ARGUMENTS.bmRevisionNo# and Ticket No. #ARGUMENTS.bmTicketNo# has been inserted."/>
<cfinvokeargument name="bmltID" value="1"/>
<cfinvokeargument name="bmlStatus" value="1"/>
</cfinvoke>
<!---Send email notifications using setBuildManagerPipeline.--->
<cfinvoke 
component="/#application.mcmsAppAdminPath#/build_manager/component/BuildManager"
method="setBuildManagerPipeline">
<cfinvokeargument name="bmID" value="#this.bmID#"/>
<cfinvokeargument name="bmaID" value="1"/>
<cfinvokeargument name="bmaIDTemp" value="1"/>
</cfinvoke>

<!---Forward to update form.--->
<cfset ajaxOnLoad("function() {
mcmsAjaxLink('layoutIndex', '#url.appID#', 'BuildManager', '/#application.mcmsAppAdminPath#/build_manager/view/inc_build_manager.cfm', 'Build', 'update', '#this.bmID#');
}")>

</cfif>
<cfcatch type="any">
<cfset result.message = "There was an error inserting the record.">

</cfcatch>
</cftry>
<cfreturn result>
</cffunction>

<cffunction name="insertBuildManagerDocumentRel" access="public" returntype="struct">
<cfargument name="bmID" type="numeric" required="yes">
<cfargument name="docName" type="string" required="yes">
<cfset result.message = "You have successfully inserted the record.">
<cftry>
<!---Insert Document.--->
<cfinvoke 
component="MCMS.component.Document" 
method="insertDocument" 
returnvariable="result">
<cfinvokeargument name="docName" value="#ARGUMENTS.docName#">
<cfinvokeargument name="docDescription" value="#ARGUMENTS.docName# for Build Manager build #ARGUMENTS.bmID#."> 
<cfinvokeargument name="docFile" value="#form.docFile#">
<cfinvokeargument name="docDateRel" value="#DateFormat(Now(), application.dateFormat)#">
<cfinvokeargument name="docDateExp" value="#DateFormat(DateAdd('yyyy', 1, Now()), application.dateFormat)#">
<cfinvokeargument name="userID" value="#session.userID#">
<cfinvokeargument name="doctID" value="#application.buildManagerDocType#">
<cfinvokeargument name="netID" value="#application.networkID#">
<cfinvokeargument name="docSort" value="1">
<cfinvokeargument name="docStatus" value="1">
<!---Email arguments.--->
<cfinvokeargument name="emailNotify" value="false">
<!---Relationship arguments.--->
<cfinvokeargument name="urID" value="#session.urID#">
<cfinvokeargument name="siteNo" value="101">
<cfinvokeargument name="deptNo" value="0">                    
</cfinvoke>
<!---Get the docID just created.--->
<cfinvoke 
component="MCMS.component.Cms"
method="getMaxValueSQL"
returnvariable="docID">
<cfinvokeargument name="tableName" value="tbl_document"/>
</cfinvoke>
<cftransaction>
<cfquery datasource="#application.mcmsDSN#">
INSERT INTO tbl_bm_document_rel (bmID,docID,bmdrStatus) VALUES
(
<cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.bmID#">,
<cfqueryparam cfsqltype="cf_sql_integer" value="#docID#">,
<cfqueryparam cfsqltype="cf_sql_integer" value="1">
)
</cfquery>
</cftransaction>
<!---Insert a log record.--->
<cfinvoke 
component="/#application.mcmsAppAdminPath#/build_manager/component/BuildManager"
method="insertBuildManagerLog">
<cfinvokeargument name="bmID" value="#ARGUMENTS.bmID#"/>
<cfinvokeargument name="userID" value="#session.userID#"/>
<cfinvokeargument name="bmlLog" value="Build Manager document #ARGUMENTS.docName# attached."/>
<cfinvokeargument name="bmltID" value="7"/>
<cfinvokeargument name="bmlStatus" value="1"/>
</cfinvoke>
<cfcatch type="any">
<cfset result.message = "There was an error inserting the record.">

</cfcatch>
</cftry>
<cfreturn result>
</cffunction>

<cffunction name="insertBuildManagerServer" access="public" returntype="struct">
<cfargument name="bmsName" type="string" required="yes">
<cfargument name="bmsDescription" type="string" required="yes">
<cfargument name="bmstID" type="numeric" required="yes">
<cfargument name="bmsDevURL" type="string" required="yes">
<cfargument name="bmsTestURL" type="string" required="yes">
<cfargument name="bmsProdURL" type="string" required="yes">
<cfargument name="bmsProjectURL" type="string" required="yes">
<cfargument name="bmsTicketURL" type="string" required="yes">
<cfargument name="bmstrID" type="string" required="yes">
<cfargument name="bmsurCount" type="numeric" required="yes">
<cfargument name="bmpsvrCount" type="numeric" required="yes">
<cfargument name="bmsStatus" type="numeric" required="yes">
<cfset result.message = "You have successfully inserted the record.">
<cftry>
<!---Check for a duplicate record.--->
<cfinvoke 
component="/#application.mcmsAppAdminPath#/build_manager/component/BuildManager"
method="getBuildManagerServer"
returnvariable="getCheckBuildManagerServerRet">
<cfinvokeargument name="bmsName" value="#ARGUMENTS.bmsName#"/>
<cfinvokeargument name="bmstID" value="#ARGUMENTS.bmstID#"/>
<cfinvokeargument name="bmsStatus" value="1,2,3"/>
</cfinvoke>
<cfif getCheckBuildManagerServerRet.recordcount NEQ 0>
<cfset result.message = "The name #ARGUMENTS.bmsName# already exists with this type, please enter a new name.">
<!---Check length restriction.--->
<cfelseif LEN(ARGUMENTS.bmsDescription) GT 512>
<cfset result.message = "The description is longer than 512 characters, please enter a new description under 512 characters.">
<cfelse>
<cftransaction>
<cfquery datasource="#application.mcmsDSN#">
INSERT INTO tbl_build_manager_server (bmsName,bmsDescription,bmstID,userID,bmsDevURL,bmsTestURL,bmsProdURL,bmsProjectURL,bmsTicketURL,bmsStatus) VALUES
(
<cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.bmsName#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.bmsDescription#">,
<cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.bmstID#">,
<cfqueryparam cfsqltype="cf_sql_integer" value="#session.userID#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.bmsDevURL#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.bmsTestURL#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.bmsProdURL#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.bmsProjectURL#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.bmsTicketURL#">,
<cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.bmsStatus#">
)
</cfquery>
</cftransaction>
<!---Get the server ID just created.--->
<cfinvoke 
component="MCMS.component.Cms"
method="getMaxValueSQL"
returnvariable="bmsID">
<cfinvokeargument name="tableName" value="tbl_build_manager_server"/>
</cfinvoke>
<cfset this.bmsID = bmsID>
<!---Create target relationships.--->
<cfloop index="i" list="#ARGUMENTS.bmstrID#">
<cfinvoke 
component="/#application.mcmsAppAdminPath#/build_manager/component/BuildManager" 
method="insertBuildManagerServerTargetRel">
<cfinvokeargument name="bmsID" value="#this.bmsID#">
<cfinvokeargument name="bmtID" value="#i#">
<cfinvokeargument name="bmstrStatus" value="1">                     
</cfinvoke>
</cfloop>
<!---Create user relationships.--->
<cfloop index="bmsutID" from="1" to="#ARGUMENTS.bmsurCount#">
<cfloop index="userID" list="#Evaluate('form.userID#bmsutID#')#">
<cfinvoke 
component="/#application.mcmsAppAdminPath#/build_manager/component/BuildManager" 
method="insertBuildManagerServerUserRel">
<cfinvokeargument name="bmsID" value="#this.bmsID#">
<cfinvokeargument name="userID" value="#userID#">
<cfinvokeargument name="bmsutID" value="#bmsutID#">
<cfinvokeargument name="bmsurStatus" value="1">                     
</cfinvoke>
</cfloop>
</cfloop>
<!---Create property relationships.--->
<cfloop index="i" from="1" to="#ARGUMENTS.bmpsvrCount#">
<cfinvoke 
component="/#application.mcmsAppAdminPath#/build_manager/component/BuildManager" 
method="insertBuildManagerPropertyServerValueRel">
<cfinvokeargument name="bmpID" value="#Evaluate('form.bmpID#i#')#">
<cfinvokeargument name="bmsID" value="#this.bmsID#">
<cfinvokeargument name="userID" value="#session.userID#">
<cfinvokeargument name="bmpsvrValue" value="#Evaluate('form.bmpsvrValue#i#')#">
<cfinvokeargument name="bmpsvrStatus" value="1">                     
</cfinvoke>
</cfloop>
<!---Create the build server properties file.--->
<cfinvoke 
component="/#application.mcmsAppAdminPath#/build_manager/component/BuildManager"
method="setBuildManagerServerPropertyFile">
<cfinvokeargument name="bmsID" value="#this.bmsID#"/>
</cfinvoke>
<!---Insert a log record.--->
<cfinvoke 
component="/#application.mcmsAppAdminPath#/build_manager/component/BuildManager"
method="insertBuildManagerLog">
<cfinvokeargument name="bmsID" value="#this.bmsID#"/>
<cfinvokeargument name="userID" value="#session.userID#"/>
<cfinvokeargument name="bmlLog" value="Build Manager Server #TRIM(ARGUMENTS.bmsName)# inserted."/>
<cfinvokeargument name="bmltID" value="2"/>
<cfinvokeargument name="bmlStatus" value="1"/>
</cfinvoke>
</cfif>
<cfcatch type="any">
<cfset result.message = "There was an error inserting the record.">

</cfcatch>
</cftry>
<cfreturn result>
</cffunction>

<cffunction name="insertBuildManagerServerTargetRel" access="public" returntype="struct">
<cfargument name="bmsID" type="numeric" required="yes">
<cfargument name="bmtID" type="numeric" required="yes">
<cfargument name="bmstrStatus" type="numeric" required="yes">
<cfset result.message = "You have successfully inserted the record.">
<cftry>
<!---Check for a duplicate record.--->
<cfinvoke 
component="/#application.mcmsAppAdminPath#/build_manager/component/BuildManager"
method="getBuildManagerServerTargetRel"
returnvariable="getCheckBuildManagerServerTargetRelRet">
<cfinvokeargument name="bmsID" value="#ARGUMENTS.bmsID#"/>
<cfinvokeargument name="bmtID" value="#ARGUMENTS.bmtID#"/>
<cfinvokeargument name="bmstrStatus" value="1,2,3"/>
</cfinvoke>
<cfif getCheckBuildManagerServerTargetRelRet.recordcount NEQ 0>
<cfset result.message = "The target already exists for this server, please try again.">
<cfelse>
<cftransaction>
<cfquery datasource="#application.mcmsDSN#">
INSERT INTO tbl_bm_server_target_rel (bmsID,bmtID,bmstrStatus) VALUES
(
<cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.bmsID#">,
<cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.bmtID#">,
<cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.bmstrStatus#">
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

<cffunction name="insertBuildManagerServerUserRel" access="public" returntype="struct">
<cfargument name="bmsID" type="numeric" required="yes">
<cfargument name="userID" type="numeric" required="yes">
<cfargument name="bmsutID" type="numeric" required="yes">
<cfargument name="bmsurStatus" type="numeric" required="yes">
<cfset result.message = "You have successfully inserted the record.">
<cftry>
<!---Check for a duplicate record.--->
<cfinvoke 
component="/#application.mcmsAppAdminPath#/build_manager/component/BuildManager"
method="getBuildManagerServerUserRel"
returnvariable="getCheckBuildManagerServerUserRelRet">
<cfinvokeargument name="bmsID" value="#ARGUMENTS.bmsID#"/>
<cfinvokeargument name="userID" value="#ARGUMENTS.userID#"/>
<cfinvokeargument name="bmsutID" value="#ARGUMENTS.bmsutID#"/>
<cfinvokeargument name="bmsurStatus" value="1,2,3"/>
</cfinvoke>
<cfif getCheckBuildManagerServerUserRelRet.recordcount NEQ 0>
<cfset result.message = "The user already exists for this server, please try again.">
<cfelse>
<cftransaction>
<cfquery datasource="#application.mcmsDSN#">
INSERT INTO tbl_bm_server_user_rel (bmsID,userID,bmsutID,bmsurStatus) VALUES
(
<cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.bmsID#">,
<cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.userID#">,
<cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.bmsutID#">,
<cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.bmsurStatus#">
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

<cffunction name="insertBuildManagerPropertyServerValueRel" access="public" returntype="struct">
<cfargument name="bmpID" type="numeric" required="yes">
<cfargument name="bmsID" type="numeric" required="yes">
<cfargument name="userID" type="numeric" required="yes">
<cfargument name="bmpsvrValue" type="string" required="yes">
<cfargument name="bmpsvrStatus" type="numeric" required="yes">
<cfset result.message = "You have successfully inserted the record.">
<cftry>
<!---Check for a duplicate record.--->
<cfinvoke 
component="/#application.mcmsAppAdminPath#/build_manager/component/BuildManager"
method="getBuildManagerPropertyServerValueRel"
returnvariable="getCheckBuildManagerPropertyServerValueRelRet">
<cfinvokeargument name="bmpID" value="#ARGUMENTS.bmpID#"/>
<cfinvokeargument name="bmsID" value="#ARGUMENTS.bmsID#"/>
<cfinvokeargument name="bmpsvrStatus" value="1,2,3"/>
</cfinvoke>
<cfif getCheckBuildManagerPropertyServerValueRelRet.recordcount NEQ 0>
<cfset result.message = "The property value already exists for this server, please try again.">
<cfelse>
<cftransaction>
<cfquery datasource="#application.mcmsDSN#">
INSERT INTO tbl_bm_p_server_value_rel (bmsID,bmpID,userID,bmpsvrValue,bmpsvrStatus) VALUES
(
<cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.bmsID#">,
<cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.bmpID#">,
<cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.userID#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.bmpsvrValue#">,
<cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.bmpsvrStatus#">
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

<cffunction name="insertBuildManagerProperty" access="public" returntype="struct">
<cfargument name="bmpName" type="string" required="yes">
<cfargument name="bmpDescription" type="string" required="yes">
<cfargument name="bmpRequired" type="numeric" required="yes">
<cfargument name="bmpRequiredMessage" type="string" required="yes">
<cfargument name="bmpDefaultValue" type="string" required="yes">
<cfargument name="bmpLOV" type="string" required="yes">
<cfargument name="bmpRegex" type="string" required="yes">
<cfargument name="bmptID" type="numeric" required="yes">
<cfargument name="bmpSort" type="numeric" required="yes">
<cfargument name="bmpStatus" type="numeric" required="yes">
<cfset result.message = "You have successfully inserted the record.">
<cftry>
<!---Check for a duplicate record.--->
<cfinvoke 
component="/#application.mcmsAppAdminPath#/build_manager/component/BuildManager"
method="getBuildManagerProperty"
returnvariable="getCheckBuildManagerPropertyRet">
<cfinvokeargument name="bmpName" value="#ARGUMENTS.bmpName#"/>
<cfinvokeargument name="bmpStatus" value="1,2,3"/>
</cfinvoke>
<cfif getCheckBuildManagerPropertyRet.recordcount NEQ 0>
<cfset result.message = "The name #ARGUMENTS.bmpName# already exists, please enter a new name.">
<!---Check length restriction.--->
<cfelseif LEN(ARGUMENTS.bmpDescription) GT 255>
<cfset result.message = "The description is longer than 255 characters, please enter a new description under 255 characters.">
<cfelse>
<cftransaction>
<cfquery datasource="#application.mcmsDSN#">
INSERT INTO tbl_build_manager_property (bmpName,bmpDescription,bmpRequired,bmpRequiredMessage,bmpDefaultValue,bmpLOV,bmpRegex,bmptID,userID,bmpSort,bmpStatus) VALUES
(
<cfqueryparam cfsqltype="cf_sql_varchar" value="#LCASE(TRIM(ARGUMENTS.bmpName))#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.bmpDescription#">,
<cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.bmpRequired#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#TRIM(ARGUMENTS.bmpRequiredMessage)#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#TRIM(ARGUMENTS.bmpDefaultValue)#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#TRIM(ARGUMENTS.bmpLOV)#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#TRIM(ARGUMENTS.bmpRegex)#">,
<cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.bmptID#">,
<cfqueryparam cfsqltype="cf_sql_integer" value="#session.userID#">,
<cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.bmpSort#">,
<cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.bmpStatus#">
)
</cfquery>
</cftransaction>
<!---Insert a log record.--->
<cfinvoke 
component="/#application.mcmsAppAdminPath#/build_manager/component/BuildManager"
method="insertBuildManagerLog">
<cfinvokeargument name="userID" value="#session.userID#"/>
<cfinvokeargument name="bmlLog" value="Property #LCASE(TRIM(ARGUMENTS.bmpName))# inserted."/>
<cfinvokeargument name="bmltID" value="4"/>
<cfinvokeargument name="bmlStatus" value="1"/>
</cfinvoke>
</cfif>
<cfcatch type="any">
<cfset result.message = "There was an error inserting the record.">

</cfcatch>
</cftry>
<cfreturn result>
</cffunction>

<cffunction name="insertBuildManagerTarget" access="public" returntype="struct">
<cfargument name="bmtName" type="string" required="yes">
<cfargument name="bmtDescription" type="string" required="yes">
<cfargument name="bmtFile" type="string" required="yes">
<cfargument name="bmtRequired" type="numeric" required="yes">
<cfargument name="bmtRequiredMessage" type="string" required="yes">
<cfargument name="bmtSort" type="numeric" required="yes">
<cfargument name="bmtStatus" type="numeric" required="yes">
<cfset result.message = "You have successfully inserted the record.">
<cftry>
<!---Check for a duplicate record.--->
<cfinvoke 
component="/#application.mcmsAppAdminPath#/build_manager/component/BuildManager"
method="getBuildManagerTarget"
returnvariable="getCheckBuildManagerTargetRet">
<cfinvokeargument name="bmtName" value="#ARGUMENTS.bmtName#"/>
<cfinvokeargument name="bmtStatus" value="1,2,3"/>
</cfinvoke>
<cfif getCheckBuildManagerTargetRet.recordcount NEQ 0>
<cfset result.message = "The name #ARGUMENTS.bmtName# already exists, please enter a new name.">
<!---Check length restriction.--->
<cfelseif LEN(ARGUMENTS.bmtDescription) GT 255>
<cfset result.message = "The description is longer than 255 characters, please enter a new description under 255 characters.">
<cfelse>
<cftransaction>
<cfquery datasource="#application.mcmsDSN#">
INSERT INTO tbl_build_manager_target (bmtName,bmtDescription,bmtFile,bmtRequired,bmtRequiredMessage,userID,bmtSort,bmtStatus) VALUES
(
<cfqueryparam cfsqltype="cf_sql_varchar" value="#TRIM(ARGUMENTS.bmtName)#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.bmtDescription#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#TRIM(ARGUMENTS.bmtFile)#">,
<cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.bmtRequired#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#TRIM(ARGUMENTS.bmtRequiredMessage)#">,
<cfqueryparam cfsqltype="cf_sql_integer" value="#session.userID#">,
<cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.bmtSort#">,
<cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.bmtStatus#">
)
</cfquery>
</cftransaction>
<!---Insert a log record.--->
<cfinvoke 
component="/#application.mcmsAppAdminPath#/build_manager/component/BuildManager"
method="insertBuildManagerLog">
<cfinvokeargument name="userID" value="#session.userID#"/>
<cfinvokeargument name="bmlLog" value="Target #LCASE(TRIM(ARGUMENTS.bmtName))# inserted."/>
<cfinvokeargument name="bmltID" value="5"/>
<cfinvokeargument name="bmlStatus" value="1"/>
</cfinvoke>
</cfif>
<cfcatch type="any">
<cfset result.message = "There was an error inserting the record.">

</cfcatch>
</cftry>
<cfreturn result>
</cffunction>

<cffunction name="updateBuildManager" access="public" returntype="struct">
<cfargument name="ID" type="numeric" required="yes">
<cfargument name="bmsID" type="numeric" required="yes">
<cfargument name="bmaID" type="numeric" required="yes">
<cfargument name="bmaIDTemp" type="numeric" required="yes">
<cfargument name="bmTicketNo" type="string" required="yes">
<cfargument name="bmTicketType" type="string" required="yes">
<cfargument name="bmRevisionNo" type="string" required="yes">
<cfargument name="bmRollbackRevisionNo" type="numeric" required="yes">
<cfargument name="bmDateRel" type="string" required="yes">
<cfargument name="bmTimeRel" type="string" required="yes">
<cfargument name="bmScheduleStatus" type="numeric" required="yes">
<cfargument name="bmNotes" type="string" required="yes">
<cfargument name="bmDeveloperUserID" type="numeric" required="yes">
<cfargument name="bmuaDeveloperID" type="numeric" required="yes">
<cfargument name="bmuaDeveloperIDTemp" type="numeric" required="yes">
<cfargument name="bmProjectUserID" type="numeric" required="yes">
<cfargument name="bmProjectNotes" type="string" required="yes">
<cfargument name="bmTestUserID" type="numeric" required="yes">
<cfargument name="bmuaTestID" type="numeric" required="yes">
<cfargument name="bmuaTestIDTemp" type="numeric" required="yes">
<cfargument name="bmTestNotes" type="string" required="yes">
<cfargument name="bmDeployerUserID" type="numeric" required="yes">
<cfargument name="bmDeployerTicketNo" type="numeric" required="yes">
<cfargument name="bmuaDeployerID" type="numeric" required="yes">
<cfargument name="bmuaDeployerIDTemp" type="numeric" required="yes">
<cfargument name="bmDeployerNotes" type="string" required="yes">
<cfargument name="bmDatabaseUserID" type="numeric" required="yes">
<cfargument name="bmDatabaseTicketNo" type="numeric" required="yes">
<cfargument name="bmuaDatabaseID" type="numeric" required="yes">
<cfargument name="bmuaDatabaseIDTemp" type="numeric" required="yes">
<cfargument name="bmDatabaseNotes" type="string" required="yes">
<cfargument name="bmSystemUserID" type="numeric" required="yes">
<cfargument name="bmSystemTicketNo" type="numeric" required="yes">
<cfargument name="bmuaSystemID" type="numeric" required="yes">
<cfargument name="bmuaSystemIDTemp" type="numeric" required="yes">
<cfargument name="bmSystemNotes" type="string" required="yes">
<cfargument name="bmStatus" type="numeric" required="yes">
<cfset result.message = "You have successfully updated the record.">
<cftry>
<!---Check for a duplicate record.--->
<cfinvoke 
component="/#application.mcmsAppAdminPath#/build_manager/component/BuildManager"
method="getBuildManager"
returnvariable="getCheckBuildManagerRet">
<cfinvokeargument name="excludeID" value="#ARGUMENTS.ID#"/>
<cfinvokeargument name="bmsID" value="#ARGUMENTS.bmsID#"/>
<cfinvokeargument name="bmTicketNo" value="#ARGUMENTS.bmTicketNo#"/>
<cfinvokeargument name="bmRevisionNo" value="#ARGUMENTS.bmRevisionNo#"/>
<cfinvokeargument name="bmStatus" value="1,2,3"/>
</cfinvoke>
<cfif getCheckBuildManagerRet.recordcount NEQ 0>
<cfset result.message = "The ticket #ARGUMENTS.bmTicketNo# already exists with revision #ARGUMENTS.bmRevisionNo#, please try again.">
<!---Check length restriction.--->
<cfelseif LEN(ARGUMENTS.bmNotes) GT 4000>
<cfset result.message = "The description is longer than 4000 characters, please enter a new description under 4000 characters.">
<cfelse>
<cftransaction>
<cfquery datasource="#application.mcmsDSN#">
UPDATE tbl_build_manager SET
bmsID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.bmsID#">,
bmaID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.bmaID#">,
bmTicketNo = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.bmTicketNo#">,
bmTicketType = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.bmTicketType#">,
bmRevisionNo = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.bmRevisionNo#">,
bmRollbackRevisionNo = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.bmRollbackRevisionNo#">,
bmDateRel = <cfqueryparam cfsqltype="cf_sql_date" value="#ARGUMENTS.bmDateRel#">,
bmTimeRel = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.bmTimeRel#">,
bmDateUpdate = <cfqueryparam cfsqltype="cf_sql_date" value="#DateFormat(Now(), application.dateFormat)#">,
bmScheduleStatus = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.bmScheduleStatus#">,
bmNotes = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.bmNotes#">,
bmuaDeveloperID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.bmuaDeveloperID#">,
bmProjectUserID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.bmProjectUserID#">,
bmProjectNotes = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.bmProjectNotes#">,
bmTestUserID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.bmTestUserID#">,
bmuaTestID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.bmuaTestID#">,
bmTestNotes = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.bmTestNotes#">,
bmDeployerUserID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.bmDeployerUserID#">,
bmuaDeployerID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.bmuaDeployerID#">,
bmDeployerTicketNo = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.bmDeployerTicketNo#">,
bmDeployerNotes = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.bmDeployerNotes#">,
bmDatabaseUserID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.bmDatabaseUserID#">,
bmuaDatabaseID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.bmuaDatabaseID#">,
bmDatabaseTicketNo = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.bmDatabaseTicketNo#">,
bmDatabaseNotes = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.bmDatabaseNotes#">,
bmSystemUserID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.bmSystemUserID#">,
bmuaSystemID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.bmuaSystemID#">,
bmSystemTicketNo = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.bmSystemTicketNo#">,
bmSystemNotes = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.bmSystemNotes#">,
bmStatus = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.bmStatus#">
WHERE ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ID#">
</cfquery>
</cftransaction>
<!---Determine whether or not to schedule the build.--->
<cfinvoke 
component="/#application.mcmsAppAdminPath#/build_manager/component/BuildManager"
method="setBuildManagerSchedule"
returnvariable="setBuildManagerScheduleRet">
<cfinvokeargument name="bmID" value="#ARGUMENTS.ID#"/>
<cfinvokeargument name="bmaID" value="#ARGUMENTS.bmaID#"/>
<cfinvokeargument name="bmDateRel" value="#ARGUMENTS.bmDateRel#"/>
<cfinvokeargument name="bmTimeRel" value="#ARGUMENTS.bmTimeRel#"/>
<cfinvokeargument name="userID" value="#ARGUMENTS.bmDeployerUserID#"/>
<cfinvokeargument name="bmScheduleStatus" value="#ARGUMENTS.bmScheduleStatus#"/>
</cfinvoke>
<cfset result.message = result.message & ' ' & setBuildManagerScheduleRet.message>
<!---Create the build value properties file.--->
<cfinvoke 
component="/#application.mcmsAppAdminPath#/build_manager/component/BuildManager"
method="setBuildManagerBuildPropertyFile">
<cfinvokeargument name="bmID" value="#ARGUMENTS.ID#"/>
</cfinvoke>
<!---Insert a log record.--->
<cfinvoke 
component="/#application.mcmsAppAdminPath#/build_manager/component/BuildManager"
method="insertBuildManagerLog">
<cfinvokeargument name="bmID" value="#ARGUMENTS.ID#"/>
<cfinvokeargument name="userID" value="#session.userID#"/>
<cfinvokeargument name="bmlLog" value="Build #ARGUMENTS.ID# for Revison No. #ARGUMENTS.bmRevisionNo# and Ticket No. #ARGUMENTS.bmTicketNo# has been updated."/>
<cfinvokeargument name="bmltID" value="1"/>
<cfinvokeargument name="bmlStatus" value="1"/>
</cfinvoke>
<!---Send email notifications using setBuildManagerPipeline. NOTE: if user actions change include the user action ID to record a log (see below).--->
<cfinvoke 
component="/#application.mcmsAppAdminPath#/build_manager/component/BuildManager"
method="setBuildManagerPipeline">
<cfinvokeargument name="bmID" value="#ARGUMENTS.ID#"/>
<cfinvokeargument name="bmaID" value="#ARGUMENTS.bmaID#"/>
<cfinvokeargument name="bmaIDTemp" value="#ARGUMENTS.bmaIDTemp#"/>
<cfif ARGUMENTS.bmuaDeveloperID NEQ ARGUMENTS.bmuaDeveloperIDTemp>
<cfinvokeargument name="bmuaID" value="#ARGUMENTS.bmuaDeveloperID#"/>
<cfinvokeargument name="bmuaIDTemp" value="#ARGUMENTS.bmuaDeveloperIDTemp#"/>
<cfelseif ARGUMENTS.bmuaTestID NEQ ARGUMENTS.bmuaTestIDTemp>
<cfinvokeargument name="bmuaID" value="#ARGUMENTS.bmuaTestID#"/>
<cfinvokeargument name="bmuaIDTemp" value="#ARGUMENTS.bmuaTestIDTemp#"/>
<cfelseif ARGUMENTS.bmuaDatabaseID NEQ ARGUMENTS.bmuaDatabaseIDTemp>
<cfinvokeargument name="bmuaID" value="#ARGUMENTS.bmuaDatabaseID#"/>
<cfinvokeargument name="bmuaIDTemp" value="#ARGUMENTS.bmuaDatabaseIDTemp#"/>
<cfelseif ARGUMENTS.bmuaSystemID NEQ ARGUMENTS.bmuaSystemIDTemp>
<cfinvokeargument name="bmuaID" value="#ARGUMENTS.bmuaSystemID#"/>
<cfinvokeargument name="bmuaIDTemp" value="#ARGUMENTS.bmuaSystemIDTemp#"/>
<cfelseif ARGUMENTS.bmuaDeployerID NEQ ARGUMENTS.bmuaDeployerIDTemp>
<cfinvokeargument name="bmuaID" value="#ARGUMENTS.bmuaDeployerID#"/>
<cfinvokeargument name="bmuaIDTemp" value="#ARGUMENTS.bmuaDeployerIDTemp#"/>
</cfif>
</cfinvoke>
<!---Update user action statuses based on build action update.--->
<!---If the action is rollback request reset all user actions to pending.--->
<cfif ARGUMENTS.bmaID EQ 6 AND ARGUMENTS.bmaID NEQ ARGUMENTS.bmaIDTemp>
<cftransaction>
<cfquery datasource="#application.mcmsDSN#">
UPDATE tbl_build_manager SET
bmDateUpdate = <cfqueryparam cfsqltype="cf_sql_date" value="#DateFormat(Now(), application.dateFormat)#">,
bmuaTestID = <cfqueryparam cfsqltype="cf_sql_integer" value="1">,
bmuaDatabaseID = <cfqueryparam cfsqltype="cf_sql_integer" value="1">,
bmuaSystemID = <cfqueryparam cfsqltype="cf_sql_integer" value="1">
WHERE ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ID#">
</cfquery>
</cftransaction> 
</cfif>
</cfif>
<cfcatch type="any">
<cfset result.message = "There was an error updating the record.">

</cfcatch>
</cftry>
<cfreturn result>
</cffunction>

<cffunction name="updateBuildManagerActionStatus" access="public" returntype="struct" hint="Used to update the Build Action status when a build is deployed.">
<cfargument name="bmID" type="numeric" required="yes" default="0">
<cfargument name="bmaID" type="numeric" required="yes" default="0">
<cfargument name="bmlLog" type="string" required="yes">
<cfargument name="bmDeployerNotes" type="string" required="yes">
<cfset result.message = "You have successfully updated the record.">
<cftry>
<cftransaction>
<cfquery datasource="#application.mcmsDSN#">
UPDATE tbl_build_manager SET
bmaID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.bmaID#">,
bmDateUpdate = <cfqueryparam cfsqltype="cf_sql_date" value="#Now()#">,
bmDeployerNotes = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.bmDeployerNotes#">
WHERE ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.bmID#">
</cfquery>
</cftransaction>
<!---Insert a log record.--->
<cfinvoke 
component="/#application.mcmsAppAdminPath#/build_manager/component/BuildManager"
method="insertBuildManagerLog">
<cfinvokeargument name="bmID" value="#ARGUMENTS.bmID#"/>
<cfinvokeargument name="userID" value="#session.userID#"/>
<cfinvokeargument name="bmaID" value="#ARGUMENTS.bmaID#"/>
<cfinvokeargument name="bmlLog" value="#ARGUMENTS.bmlLog#"/>
<cfinvokeargument name="bmltID" value="1"/>
<cfinvokeargument name="bmlStatus" value="1"/>
</cfinvoke>
<cfcatch type="any">
<cfset result.message = "There was an error updating the record.">

</cfcatch>
</cftry>
<cfreturn result>
</cffunction>

<cffunction name="updateBuildManagerServer" access="public" returntype="struct">
<cfargument name="ID" type="numeric" required="yes">
<cfargument name="bmsName" type="string" required="yes">
<cfargument name="bmsDescription" type="string" required="yes">
<cfargument name="bmstID" type="numeric" required="yes">
<cfargument name="bmsDevURL" type="string" required="yes">
<cfargument name="bmsTestURL" type="string" required="yes">
<cfargument name="bmsProdURL" type="string" required="yes">
<cfargument name="bmsProjectURL" type="string" required="yes">
<cfargument name="bmsTicketURL" type="string" required="yes">
<cfargument name="bmstrID" type="string" required="yes">
<cfargument name="bmsurCount" type="numeric" required="yes">
<cfargument name="bmpsvrCount" type="numeric" required="yes">
<cfargument name="bmsStatus" type="numeric" required="yes">
<cfset result.message = "You have successfully updated the record.">
<cftry>
<!---Check for a duplicate record.--->
<cfinvoke 
component="/#application.mcmsAppAdminPath#/build_manager/component/BuildManager"
method="getBuildManagerServer"
returnvariable="getCheckBuildManagerServerRet">
<cfinvokeargument name="excludeID" value="#ARGUMENTS.ID#"/>
<cfinvokeargument name="bmsName" value="#ARGUMENTS.bmsName#"/>
<cfinvokeargument name="bmstID" value="#ARGUMENTS.bmstID#"/>
<cfinvokeargument name="bmsStatus" value="1,2,3"/>
</cfinvoke>
<cfif getCheckBuildManagerServerRet.recordcount NEQ 0>
<cfset result.message = "The name #ARGUMENTS.bmsName# already exists with this type, please enter a new name.">
<!---Check length restriction.--->
<cfelseif LEN(ARGUMENTS.bmsDescription) GT 512>
<cfset result.message = "The description is longer than 512 characters, please enter a new description under 512 characters.">
<cfelse>
<cftransaction>
<cfquery datasource="#application.mcmsDSN#">
UPDATE tbl_build_manager_server SET
bmsName = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.bmsName#">,
bmsDescription = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.bmsDescription#">,
bmstID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.bmstID#">,
userID = <cfqueryparam cfsqltype="cf_sql_integer" value="#session.userID#">,
bmsDevURL = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.bmsDevURL#">,
bmsTestURL = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.bmsTestURL#">,
bmsProdURL = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.bmsProdURL#">,
bmsProjectURL = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.bmsProjectURL#">,
bmsTicketURL = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.bmsTicketURL#">,
bmsDateUpdate = <cfqueryparam cfsqltype="cf_sql_date" value="#Now()#">,
bmsStatus = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.bmsStatus#">
WHERE ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ID#">
</cfquery>
</cftransaction>
<!---Delete any existing relationships.--->
<cfinvoke 
component="/#application.mcmsAppAdminPath#/build_manager/component/BuildManager"
method="deleteBuildManagerServerUserRel">
<cfinvokeargument name="bmsID" value="#ARGUMENTS.ID#"/>
</cfinvoke>
<cfinvoke 
component="/#application.mcmsAppAdminPath#/build_manager/component/BuildManager"
method="deleteBuildManagerServerTargetRel">
<cfinvokeargument name="bmsID" value="#ARGUMENTS.ID#"/>
</cfinvoke>
<cfinvoke 
component="/#application.mcmsAppAdminPath#/build_manager/component/BuildManager"
method="deleteBuildManagerPropertyServerValueRel">
<cfinvokeargument name="bmsID" value="#ARGUMENTS.ID#"/>
</cfinvoke>
<!---Create target relationships.--->
<cfloop index="i" list="#ARGUMENTS.bmstrID#">
<cfinvoke 
component="/#application.mcmsAppAdminPath#/build_manager/component/BuildManager" 
method="insertBuildManagerServerTargetRel">
<cfinvokeargument name="bmsID" value="#ARGUMENTS.ID#">
<cfinvokeargument name="bmtID" value="#i#">
<cfinvokeargument name="bmstrStatus" value="1">                     
</cfinvoke>
</cfloop>
<!---Create user relationships.--->
<cfloop index="bmsutID" from="1" to="#ARGUMENTS.bmsurCount#">
<cfloop index="userID" list="#Evaluate('form.userID#bmsutID#')#">
<cfinvoke 
component="/#application.mcmsAppAdminPath#/build_manager/component/BuildManager" 
method="insertBuildManagerServerUserRel">
<cfinvokeargument name="bmsID" value="#ARGUMENTS.ID#">
<cfinvokeargument name="userID" value="#userID#">
<cfinvokeargument name="bmsutID" value="#bmsutID#">
<cfinvokeargument name="bmsurStatus" value="1">                     
</cfinvoke>
</cfloop>
</cfloop>
<!---Create property relationships.--->
<cfloop index="i" from="1" to="#ARGUMENTS.bmpsvrCount#">
<cfinvoke 
component="/#application.mcmsAppAdminPath#/build_manager/component/BuildManager" 
method="insertBuildManagerPropertyServerValueRel">
<cfinvokeargument name="bmpID" value="#Evaluate('form.bmpID#i#')#">
<cfinvokeargument name="bmsID" value="#ARGUMENTS.ID#">
<cfinvokeargument name="userID" value="#session.userID#">
<cfinvokeargument name="bmpsvrValue" value="#Evaluate('form.bmpsvrValue#i#')#">
<cfinvokeargument name="bmpsvrStatus" value="1">                     
</cfinvoke>
</cfloop>
<!---Create the build server properties file.--->
<cfinvoke 
component="/#application.mcmsAppAdminPath#/build_manager/component/BuildManager"
method="setBuildManagerServerPropertyFile">
<cfinvokeargument name="bmsID" value="#ARGUMENTS.ID#"/>
</cfinvoke>
<!---Insert a log record.--->
<cfinvoke 
component="/#application.mcmsAppAdminPath#/build_manager/component/BuildManager"
method="insertBuildManagerLog">
<cfinvokeargument name="bmsID" value="#ARGUMENTS.ID#">
<cfinvokeargument name="userID" value="#session.userID#">
<cfinvokeargument name="bmlLog" value="Build Manager Server #TRIM(ARGUMENTS.bmsName)# updated."/>
<cfinvokeargument name="bmltID" value="2"/>
<cfinvokeargument name="bmlStatus" value="1"/>
</cfinvoke>
</cfif>
<cfcatch type="any">
<cfset result.message = "There was an error updating the record.">

</cfcatch>
</cftry>
<cfreturn result>
</cffunction>

<cffunction name="updateBuildManagerProperty" access="public" returntype="struct">
<cfargument name="ID" type="numeric" required="yes">
<cfargument name="bmpName" type="string" required="yes">
<cfargument name="bmpDescription" type="string" required="yes">
<cfargument name="bmpRequired" type="numeric" required="yes">
<cfargument name="bmpRequiredMessage" type="string" required="yes">
<cfargument name="bmpDefaultValue" type="string" required="yes">
<cfargument name="bmpLOV" type="string" required="yes">
<cfargument name="bmpRegex" type="string" required="yes">
<cfargument name="bmptID" type="numeric" required="yes">
<cfargument name="bmpSort" type="numeric" required="yes">
<cfargument name="bmpStatus" type="numeric" required="yes">
<cfset result.message = "You have successfully updated the record.">
<cftry>
<!---Check for a duplicate record.--->
<cfinvoke 
component="/#application.mcmsAppAdminPath#/build_manager/component/BuildManager"
method="getBuildManagerProperty"
returnvariable="getCheckBuildManagerPropertyRet">
<cfinvokeargument name="excludeID" value="#ARGUMENTS.ID#"/>
<cfinvokeargument name="bmpName" value="#ARGUMENTS.bmpName#"/>
<cfinvokeargument name="bmpStatus" value="1,2,3"/>
</cfinvoke>
<cfif getCheckBuildManagerPropertyRet.recordcount NEQ 0>
<!---Check length restriction.--->
<cfelseif LEN(ARGUMENTS.bmpDescription) GT 255>
<cfset result.message = "The description is longer than 255 characters, please enter a new description under 255 characters.">
<cfelse>
<cftransaction>
<cfquery datasource="#application.mcmsDSN#">
UPDATE tbl_build_manager_property SET
bmpName = <cfqueryparam cfsqltype="cf_sql_varchar" value="#LCASE(TRIM(ARGUMENTS.bmpName))#">,
bmpDescription = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.bmpDescription#">,
bmpDateUpdate = <cfqueryparam cfsqltype="cf_sql_date" value="#DateFormat(Now(), application.dateFormat)#">,
bmpRequired = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.bmpRequired#">,
bmpRequiredMessage = <cfqueryparam cfsqltype="cf_sql_varchar" value="#TRIM(ARGUMENTS.bmpRequiredMessage)#">,
bmpDefaultValue = <cfqueryparam cfsqltype="cf_sql_varchar" value="#TRIM(ARGUMENTS.bmpDefaultValue)#">,
bmpLOV = <cfqueryparam cfsqltype="cf_sql_varchar" value="#TRIM(ARGUMENTS.bmpLOV)#">,
bmpRegex = <cfqueryparam cfsqltype="cf_sql_varchar" value="#TRIM(ARGUMENTS.bmpRegex)#">,
bmptID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.bmptID#">,
userID = <cfqueryparam cfsqltype="cf_sql_integer" value="#session.userID#">,
bmpSort = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.bmpSort#">,
bmpStatus = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.bmpStatus#">
WHERE ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ID#">
</cfquery>
</cftransaction>
<!---Insert a log record.--->
<cfinvoke 
component="/#application.mcmsAppAdminPath#/build_manager/component/BuildManager"
method="insertBuildManagerLog">
<cfinvokeargument name="bmlLog" value="Property #LCASE(TRIM(ARGUMENTS.bmpName))# updated."/>
<cfinvokeargument name="bmltID" value="4"/>
<cfinvokeargument name="bmlStatus" value="1"/>
</cfinvoke>
</cfif>
<cfcatch type="any">
<cfset result.message = "There was an error updating the record.">

</cfcatch>
</cftry>
<cfreturn result>
</cffunction>

<cffunction name="updateBuildManagerTarget" access="public" returntype="struct">
<cfargument name="ID" type="numeric" required="yes">
<cfargument name="bmtName" type="string" required="yes">
<cfargument name="bmtDescription" type="string" required="yes">
<cfargument name="bmtFile" type="string" required="yes">
<cfargument name="bmtRequired" type="numeric" required="yes">
<cfargument name="bmtRequiredMessage" type="string" required="yes">
<cfargument name="bmtSort" type="numeric" required="yes">
<cfargument name="bmtStatus" type="numeric" required="yes">
<cfset result.message = "You have successfully updated the record.">
<cftry>
<!---Check for a duplicate record.--->
<cfinvoke 
component="/#application.mcmsAppAdminPath#/build_manager/component/BuildManager"
method="getBuildManagerTarget"
returnvariable="getCheckBuildManagerTargetRet">
<cfinvokeargument name="excludeID" value="#ARGUMENTS.ID#"/>
<cfinvokeargument name="bmtName" value="#ARGUMENTS.bmtName#"/>
<cfinvokeargument name="bmtStatus" value="1,2,3"/>
</cfinvoke>
<cfif getCheckBuildManagerTargetRet.recordcount NEQ 0>
<!---Check length restriction.--->
<cfelseif LEN(ARGUMENTS.bmtDescription) GT 255>
<cfset result.message = "The description is longer than 255 characters, please enter a new description under 255 characters.">
<cfelse>
<cftransaction>
<cfquery datasource="#application.mcmsDSN#">
UPDATE tbl_build_manager_target SET
bmtName = <cfqueryparam cfsqltype="cf_sql_varchar" value="#TRIM(ARGUMENTS.bmtName)#">,
bmtDescription = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.bmtDescription#">,
bmtFile = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.bmtFile#">,
bmtDateUpdate = <cfqueryparam cfsqltype="cf_sql_date" value="#DateFormat(Now(), application.dateFormat)#">,
bmtRequired = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.bmtRequired#">,
bmtRequiredMessage = <cfqueryparam cfsqltype="cf_sql_varchar" value="#TRIM(ARGUMENTS.bmtRequiredMessage)#">,
userID = <cfqueryparam cfsqltype="cf_sql_integer" value="#session.userID#">,
bmtSort = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.bmtSort#">,
bmtStatus = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.bmtStatus#">
WHERE ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ID#">
</cfquery>
</cftransaction>
<!---Insert a log record.--->
<cfinvoke 
component="/#application.mcmsAppAdminPath#/build_manager/component/BuildManager"
method="insertBuildManagerLog">
<cfinvokeargument name="userID" value="#session.userID#"/>
<cfinvokeargument name="bmlLog" value="Target #LCASE(TRIM(ARGUMENTS.bmtName))# updated."/>
<cfinvokeargument name="bmltID" value="5"/>
<cfinvokeargument name="bmlStatus" value="1"/>
</cfinvoke>
</cfif>
<cfcatch type="any">
<cfset result.message = "There was an error updating the record.">

</cfcatch>
</cftry>
<cfreturn result>
</cffunction>

<cffunction name="updateBuildManagerList" access="public" returntype="struct">
<cfargument name="ID" type="numeric" required="yes">
<cfargument name="bmStatus" type="numeric" required="yes">
<cfset result.message = "You have successfully updated the records.">
<cftry>
<cftransaction>
<cfquery datasource="#application.mcmsDSN#">
UPDATE tbl_build_manager SET
bmStatus = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.bmStatus#">
WHERE ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ID#">
</cfquery>
</cftransaction>
<cfcatch type="any">
<cfset result.message = "There was an error updating the records.">

</cfcatch>
</cftry>
<cfreturn result>
</cffunction>

<cffunction name="updateBuildManagerServerList" access="public" returntype="struct">
<cfargument name="ID" type="numeric" required="yes">
<cfargument name="bmsStatus" type="numeric" required="yes">
<cfset result.message = "You have successfully updated the records.">
<cftry>
<cftransaction>
<cfquery datasource="#application.mcmsDSN#">
UPDATE tbl_build_manager_server SET
bmsStatus = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.bmsStatus#">
WHERE ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ID#">
</cfquery>
</cftransaction>
<cfcatch type="any">
<cfset result.message = "There was an error updating the records.">

</cfcatch>
</cftry>
<cfreturn result>
</cffunction>

<cffunction name="updateBuildManagerPropertyList" access="public" returntype="struct">
<cfargument name="ID" type="numeric" required="yes">
<cfargument name="bmpStatus" type="numeric" required="yes">
<cfset result.message = "You have successfully updated the records.">
<cftry>
<cftransaction>
<cfquery datasource="#application.mcmsDSN#">
UPDATE tbl_build_manager_property SET
bmpStatus = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.bmpStatus#">
WHERE ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ID#">
</cfquery>
</cftransaction>
<cfcatch type="any">
<cfset result.message = "There was an error updating the records.">

</cfcatch>
</cftry>
<cfreturn result>
</cffunction>

<cffunction name="updateBuildManagerTargetList" access="public" returntype="struct">
<cfargument name="ID" type="numeric" required="yes">
<cfargument name="bmtStatus" type="numeric" required="yes">
<cfset result.message = "You have successfully updated the records.">
<cftry>
<cftransaction>
<cfquery datasource="#application.mcmsDSN#">
UPDATE tbl_build_manager_target SET
bmtStatus = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.bmtStatus#">
WHERE ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ID#">
</cfquery>
</cftransaction>
<cfcatch type="any">
<cfset result.message = "There was an error updating the records.">

</cfcatch>
</cftry>
<cfreturn result>
</cffunction>

<cffunction name="deleteBuildManager" access="public" returntype="struct">
<cfargument name="ID" type="string" required="yes">
<cfset result.message = "You have successfully deleted the record(s).">
<cftry>
<cftransaction>
<cfquery datasource="#application.mcmsDSN#">
DELETE FROM tbl_build_manager
WHERE ID IN (<cfqueryparam cfsqltype="cf_sql_integer" list="yes" value="#ARGUMENTS.ID#">)
</cfquery>
</cftransaction>
<cfinvoke 
component="/#application.mcmsAppAdminPath#/build_manager/component/BuildManager"
method="deleteBuildManagerLog">
<cfinvokeargument name="bmID" value="#ARGUMENTS.ID#"/>
</cfinvoke>
<cfcatch type="any">
<cfset result.message = "There was an error deleting the record(s).">

</cfcatch>
</cftry>
<cfreturn result>
</cffunction>

<cffunction name="deleteBuildManagerProperty" access="public" returntype="struct">
<cfargument name="ID" type="string" required="yes">
<cfset result.message = "You have successfully deleted the record(s).">
<cftry>
<cftransaction>
<cfquery datasource="#application.mcmsDSN#">
DELETE FROM tbl_build_manager_property
WHERE ID IN (<cfqueryparam cfsqltype="cf_sql_integer" list="yes" value="#ARGUMENTS.ID#">)
</cfquery>
</cftransaction>
<cfinvoke 
component="/#application.mcmsAppAdminPath#/build_manager/component/BuildManager"
method="deleteBuildManagerPropertyServerValueRel">
<cfinvokeargument name="bmpID" value="#ARGUMENTS.ID#"/>
</cfinvoke>
<cfcatch type="any">
<cfset result.message = "There was an error deleting the record(s).">

</cfcatch>
</cftry>
<cfreturn result>
</cffunction>

<cffunction name="deleteBuildManagerTarget" access="public" returntype="struct">
<cfargument name="ID" type="string" required="yes">
<cfset result.message = "You have successfully deleted the record(s).">
<cftry>
<cftransaction>
<cfquery datasource="#application.mcmsDSN#">
DELETE FROM tbl_build_manager_target
WHERE ID IN (<cfqueryparam cfsqltype="cf_sql_integer" list="yes" value="#ARGUMENTS.ID#">)
</cfquery>
</cftransaction>
<cfinvoke 
component="/#application.mcmsAppAdminPath#/build_manager/component/BuildManager"
method="deleteBuildManagerServerTargetRel">
<cfinvokeargument name="bmtID" value="#ARGUMENTS.ID#"/>
</cfinvoke>
<cfcatch type="any">
<cfset result.message = "There was an error deleting the record(s).">

</cfcatch>
</cftry>
<cfreturn result>
</cffunction>

<cffunction name="deleteBuildManagerLog" access="public" returntype="struct">
<cfargument name="ID" type="string" required="yes" default="0">
<cfargument name="bmID" type="string" required="yes" default="0">
<cfset result.message = "You have successfully deleted the record(s).">
<cftry>
<cftransaction>
<cfquery datasource="#application.mcmsDSN#">
DELETE FROM tbl_build_manager_log
WHERE 0=0
AND (ID IN (<cfqueryparam cfsqltype="cf_sql_integer" list="yes" value="#ARGUMENTS.ID#">) OR 
bmID IN (<cfqueryparam cfsqltype="cf_sql_integer" list="yes" value="#ARGUMENTS.bmID#">))
</cfquery>
</cftransaction>
<cfcatch type="any">
<cfset result.message = "There was an error deleting the record(s).">

</cfcatch>
</cftry>
<cfreturn result>
</cffunction> 

<cffunction name="deleteBuildManagerDocumentRel" access="public" returntype="struct">
<cfargument name="ID" type="string" required="yes" default="0">
<cfargument name="bmID" type="string" required="yes" default="0">
<cfset result.message = "You have successfully deleted the record(s).">
<cftry>
<cftransaction>
<cfquery datasource="#application.mcmsDSN#">
DELETE FROM tbl_bm_document_rel
WHERE 0=0
AND (ID IN (<cfqueryparam cfsqltype="cf_sql_integer" list="yes" value="#ARGUMENTS.ID#">) OR 
bmID IN (<cfqueryparam cfsqltype="cf_sql_integer" list="yes" value="#ARGUMENTS.bmID#">))
</cfquery>
</cftransaction>
<cfcatch type="any">
<cfset result.message = "There was an error deleting the record(s).">

</cfcatch>
</cftry>
<cfreturn result>
</cffunction>

<cffunction name="deleteBuildManagerServer" access="public" returntype="struct">
<cfargument name="ID" type="string" required="yes">
<cfset result.message = "You have successfully deleted the record(s).">
<cftry>
<cftransaction>
<cfquery datasource="#application.mcmsDSN#">
DELETE FROM tbl_build_manager_server
WHERE ID IN (<cfqueryparam cfsqltype="cf_sql_integer" list="yes" value="#ARGUMENTS.ID#">)
</cfquery>
</cftransaction>
<cfinvoke 
component="/#application.mcmsAppAdminPath#/build_manager/component/BuildManager"
method="deleteBuildManagerServerUserRel">
<cfinvokeargument name="bmsID" value="#ARGUMENTS.ID#"/>
</cfinvoke>
<cfinvoke 
component="/#application.mcmsAppAdminPath#/build_manager/component/BuildManager"
method="deleteBuildManagerServerTargetRel">
<cfinvokeargument name="bmsID" value="#ARGUMENTS.ID#"/>
</cfinvoke>
<cfinvoke 
component="/#application.mcmsAppAdminPath#/build_manager/component/BuildManager"
method="deleteBuildManagerPropertyServerValueRel">
<cfinvokeargument name="bmsID" value="#ARGUMENTS.ID#"/>
</cfinvoke>
<cfcatch type="any">
<cfset result.message = "There was an error deleting the record(s).">

</cfcatch>
</cftry>
<cfreturn result>
</cffunction>

<cffunction name="deleteBuildManagerServerUserRel" access="public" returntype="struct">
<cfargument name="ID" type="string" required="yes" default="0">
<cfargument name="userID" type="string" required="yes" default="0">
<cfargument name="bmsID" type="string" required="yes" default="0">
<cfset result.message = "You have successfully deleted the record(s).">
<cftry>
<cftransaction>
<cfquery datasource="#application.mcmsDSN#">
DELETE FROM tbl_bm_server_user_rel
WHERE ID IN (<cfqueryparam cfsqltype="cf_sql_integer" list="yes" value="#ARGUMENTS.ID#">)
OR userID IN (<cfqueryparam cfsqltype="cf_sql_integer" list="yes" value="#ARGUMENTS.userID#">)
OR bmsID IN (<cfqueryparam cfsqltype="cf_sql_integer" list="yes" value="#ARGUMENTS.bmsID#">)
</cfquery>
</cftransaction>
<cfcatch type="any">
<cfset result.message = "There was an error deleting the record(s).">

</cfcatch>
</cftry>
<cfreturn result>
</cffunction>

<cffunction name="deleteBuildManagerServerTargetRel" access="public" returntype="struct">
<cfargument name="ID" type="string" required="yes" default="0">
<cfargument name="bmtID" type="string" required="yes" default="0">
<cfargument name="bmsID" type="string" required="yes" default="0">
<cfset result.message = "You have successfully deleted the record(s).">
<cftry>
<cftransaction>
<cfquery datasource="#application.mcmsDSN#">
DELETE FROM tbl_bm_server_target_rel
WHERE ID IN (<cfqueryparam cfsqltype="cf_sql_integer" list="yes" value="#ARGUMENTS.ID#">)
OR bmtID IN (<cfqueryparam cfsqltype="cf_sql_integer" list="yes" value="#ARGUMENTS.bmtID#">)
OR bmsID IN (<cfqueryparam cfsqltype="cf_sql_integer" list="yes" value="#ARGUMENTS.bmsID#">)
</cfquery>
</cftransaction>
<cfcatch type="any">
<cfset result.message = "There was an error deleting the record(s).">

</cfcatch>
</cftry>
<cfreturn result>
</cffunction>

<cffunction name="deleteBuildManagerPropertyServerValueRel" access="public" returntype="struct">
<cfargument name="ID" type="string" required="yes" default="0">
<cfargument name="userID" type="string" required="yes" default="0">
<cfargument name="bmsID" type="string" required="yes" default="0">
<cfargument name="bmpID" type="string" required="yes" default="0">
<cfset result.message = "You have successfully deleted the record(s).">
<cftry>
<cftransaction>
<cfquery datasource="#application.mcmsDSN#">
DELETE FROM tbl_bm_p_server_value_rel
WHERE ID IN (<cfqueryparam cfsqltype="cf_sql_integer" list="yes" value="#ARGUMENTS.ID#">)
OR userID IN (<cfqueryparam cfsqltype="cf_sql_integer" list="yes" value="#ARGUMENTS.userID#">)
OR bmsID IN (<cfqueryparam cfsqltype="cf_sql_integer" list="yes" value="#ARGUMENTS.bmsID#">)
OR bmpID IN (<cfqueryparam cfsqltype="cf_sql_integer" list="yes" value="#ARGUMENTS.bmpID#">)
</cfquery>
</cftransaction>
<cfcatch type="any">
<cfset result.message = "There was an error deleting the record(s).">

</cfcatch>
</cftry>
<cfreturn result>
</cffunction>     
</cfcomponent>