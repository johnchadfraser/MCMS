<cfcomponent>
    <cffunction name="getTaskManagerTask" access="public" returntype="query" hint="Get Task Manager Task data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="ID" type="string" required="yes" default="0">
    <cfargument name="excludeID" type="numeric" required="yes" default="0">
	<cfargument name="excludeURID" type="string" required="yes" default="100">
    <cfargument name="tmtName" type="string" required="yes" default="">
    <cfargument name="tmtDateRel" type="string" required="yes" default="">
    <cfargument name="tmtDateExp" type="string" required="yes" default="">
    <cfargument name="tmtDateDueEmailCheckDays" type="string" required="yes" default="">
    <cfargument name="tmttID" type="string" required="yes" default="0">
    <cfargument name="tmtsID" type="string" required="yes" default="0">
	<cfargument name="urID" type="string" required="yes" default="100">
    <cfargument name="tmtStatus" type="string" required="yes" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="tmtDateRel DESC, tmtName">
    <cfset var rsTaskManagerTask = "" >
    <cftry>
    <cfquery name="rsTaskManagerTask" datasource="#application.mcmsDSN#">
    SELECT * FROM v_tm_task WHERE 0=0
    <cfif ARGUMENTS.ID NEQ 0>
    AND ID IN (<cfqueryparam value="#ARGUMENTS.ID#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    <cfif ARGUMENTS.excludeID NEQ 0>
    AND ID <> <cfqueryparam value="#ARGUMENTS.excludeID#" cfsqltype="cf_sql_integer">
    </cfif>
	<cfif ARGUMENTS.excludeURID NEQ 100>
    AND urID NOT IN (<cfqueryparam value="#ARGUMENTS.excludeURID#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(tmtName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(tmtDescription) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">)
    </cfif>
    <cfif ARGUMENTS.tmtName NEQ "">
    AND UPPER(tmtName) = <cfqueryparam value="#UCASE(ARGUMENTS.tmtName)#" cfsqltype="cf_sql_varchar">
    </cfif>
    <cfif ARGUMENTS.tmttID NEQ 0>
    AND tmttID = <cfqueryparam value="#ARGUMENTS.tmttID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.tmtsID NEQ 0>
    AND tmtsID IN (<cfqueryparam value="#ARGUMENTS.tmtsID#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
	<cfif ARGUMENTS.urID NEQ 100>
    AND urID IN (<cfqueryparam value="#ARGUMENTS.urID#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    <cfif ARGUMENTS.tmtDateRel NEQ "">
    AND tmtDateRel <= <cfqueryparam value="#ARGUMENTS.tmtDateRel#" cfsqltype="cf_sql_date">
    </cfif>
    <cfif ARGUMENTS.tmtDateExp NEQ "">
    AND tmtDateExp >= <cfqueryparam value="#ARGUMENTS.tmtDateExp#" cfsqltype="cf_sql_date">
	</cfif>
	<cfif ARGUMENTS.tmtDateDueEmailCheckDays NEQ ''>
	AND (
	<cfloop list="#ARGUMENTS.tmtDateDueEmailCheckDays#" delimiters="," item="number">
    tmtDateDue = <cfqueryparam value="#DateFormat(DateAdd('d', -number, Now()), application.dateFormat)#" cfsqltype="cf_sql_date">
    <cfif ListLen(ARGUMENTS.tmtDateDueEmailCheckDays) GT 1 AND ListFind(ARGUMENTS.tmtDateDueEmailCheckDays, number) NEQ ListLen(ARGUMENTS.tmtDateDueEmailCheckDays)>
    OR
    </cfif>
    </cfloop>
    )
	</cfif>
    AND tmtStatus IN (<cfqueryparam value="#ARGUMENTS.tmtStatus#" list="yes" cfsqltype="cf_sql_integer">)
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsTaskManagerTask = StructNew()>
    <cfset rsTaskManagerTask.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsTaskManagerTask>
    </cffunction>
    
    <cffunction name="getTaskManagerTaskListing" access="public" returntype="query" hint="Get Task Manager Task Listing data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="ID" type="numeric" required="yes" default="0">
    <cfargument name="excludeID" type="numeric" required="yes" default="0">
	<cfargument name="excludeURID" type="string" required="yes" default="100">
    <cfargument name="tmtID" type="string" required="yes" default="0">
    <cfargument name="siteNo" type="string" required="yes" default="100">
    <cfargument name="deptNo" type="string" required="yes" default="0">
    <cfargument name="tmtDateRel" type="string" required="yes" default="">
    <cfargument name="tmtDateExp" type="string" required="yes" default="">
    <cfargument name="tmtlsID" type="string" required="yes" default="0">
	<cfargument name="urID" type="string" required="yes" default="100">
    <cfargument name="tmtlStatus" type="string" required="yes" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="tmtlsID, tmtName, siteNo, deptNo">
    <cfset var rsTaskManagerTaskListing = "" >
    <cftry>
    <cfquery name="rsTaskManagerTaskListing" datasource="#application.mcmsDSN#">
    SELECT * FROM v_tm_task_listing WHERE 0=0
    <cfif ARGUMENTS.ID NEQ 0>
    AND ID = <cfqueryparam value="#ARGUMENTS.ID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.excludeID NEQ 0>
    AND ID <> <cfqueryparam value="#ARGUMENTS.excludeID#" cfsqltype="cf_sql_integer">
    </cfif>
	<cfif ARGUMENTS.excludeURID NEQ 100>
    AND urID NOT IN (<cfqueryparam value="#ARGUMENTS.excludeURID#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(tmtName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(tmtDescription) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">)
    </cfif>
    <cfif ARGUMENTS.tmtID NEQ 0>
    AND tmtID IN (<cfqueryparam value="#ARGUMENTS.tmtID#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    <cfif ARGUMENTS.siteNo NEQ 100>
    AND siteNo IN (<cfqueryparam value="#ARGUMENTS.siteNo#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    <cfif ARGUMENTS.deptNo NEQ 0>
    AND deptNo IN (<cfqueryparam value="#ARGUMENTS.deptNo#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    <cfif ARGUMENTS.tmtlsID NEQ 0>
    AND tmtlsID IN (<cfqueryparam value="#ARGUMENTS.tmtlsID#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
	<cfif ARGUMENTS.urID NEQ 100>
    AND urID IN (<cfqueryparam value="#ARGUMENTS.urID#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    <cfif ARGUMENTS.tmtDateRel NEQ "">
    AND tmtDateRel <= <cfqueryparam value="#ARGUMENTS.tmtDateRel#" cfsqltype="cf_sql_date">
    </cfif>
    <cfif ARGUMENTS.tmtDateExp NEQ "">
    AND tmtDateExp >= <cfqueryparam value="#ARGUMENTS.tmtDateExp#" cfsqltype="cf_sql_date">
	</cfif>
    AND tmtStatus IN (<cfqueryparam value="#ARGUMENTS.tmtlStatus#" list="yes" cfsqltype="cf_sql_integer">)
    AND tmtlStatus IN (<cfqueryparam value="#ARGUMENTS.tmtlStatus#" list="yes" cfsqltype="cf_sql_integer">)
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsTaskManagerTaskListing = StructNew()>
    <cfset rsTaskManagerTaskListing.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsTaskManagerTaskListing>
    </cffunction>
    
    <cffunction name="getTaskManagerTaskType" access="public" returntype="query" hint="Get Task Manager Task Type data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="ID" type="numeric" required="yes" default="0">
    <cfargument name="excludeID" type="numeric" required="yes" default="0">
    <cfargument name="tmttName" type="string" required="yes" default="">
    <cfargument name="tmttStatus" type="string" required="yes" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="tmttSort,tmttName">
    <cfset var rsTaskManagerTaskType = "" >
    <cftry>
    <cfquery name="rsTaskManagerTaskType" datasource="#application.mcmsDSN#">
    SELECT * FROM v_tm_task_type WHERE 0=0
    <cfif ARGUMENTS.ID NEQ 0>
    AND ID = <cfqueryparam value="#ARGUMENTS.ID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.excludeID NEQ 0>
    AND ID <> <cfqueryparam value="#ARGUMENTS.excludeID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND UPPER(tmttName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">
    </cfif>
    <cfif ARGUMENTS.tmttName NEQ "">
    AND UPPER(tmttName) = <cfqueryparam value="#UCASE(ARGUMENTS.tmttName)#" cfsqltype="cf_sql_varchar">
    </cfif>
    AND tmttStatus IN (<cfqueryparam value="#ARGUMENTS.tmttStatus#" list="yes" cfsqltype="cf_sql_integer">)
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsTaskManagerTaskType = StructNew()>
    <cfset rsTaskManagerTaskType.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsTaskManagerTaskType>
    </cffunction>
    
    <cffunction name="getTaskManagerTaskPriority" access="public" returntype="query" hint="Get Task Manager Task Priority data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="ID" type="numeric" required="yes" default="0">
    <cfargument name="excludeID" type="numeric" required="yes" default="0">
    <cfargument name="tmtpStatus" type="string" required="yes" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="tmtpSort, tmtpName">
    <cfset var rsTaskManagerTaskPriority = "" >
    <cftry>
    <cfquery name="rsTaskManagerTaskPriority" datasource="#application.mcmsDSN#">
    SELECT * FROM v_tm_task_priority WHERE 0=0
    <cfif ARGUMENTS.ID NEQ 0>
    AND ID = <cfqueryparam value="#ARGUMENTS.ID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.excludeID NEQ 0>
    AND ID <> <cfqueryparam value="#ARGUMENTS.excludeID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND UPPER(tmtpName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">
    </cfif>
    AND tmtpStatus IN (<cfqueryparam value="#ARGUMENTS.tmtpStatus#" list="yes" cfsqltype="cf_sql_integer">)
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsTaskManagerTaskPriority = StructNew()>
    <cfset rsTaskManagerTaskPriority.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsTaskManagerTaskPriority>
    </cffunction>
    
    <cffunction name="getTaskManagerTaskListingStatus" access="public" returntype="query" hint="Get Task Manager Task Listing Status data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="ID" type="string" required="yes" default="0">
    <cfargument name="excludeID" type="numeric" required="yes" default="0">
    <cfargument name="tmtlsStatus" type="string" required="yes" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="tmtlsSort, tmtlsName">
    <cfset var rsTaskManagerTaskListingStatus = "" >
    <cftry>
    <cfquery name="rsTaskManagerTaskListingStatus" datasource="#application.mcmsDSN#">
    SELECT * FROM v_tm_task_listing_status WHERE 0=0
    <cfif ARGUMENTS.ID NEQ 0>
    AND ID IN (<cfqueryparam value="#ARGUMENTS.ID#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    <cfif ARGUMENTS.excludeID NEQ 0>
    AND ID <> <cfqueryparam value="#ARGUMENTS.excludeID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND UPPER(tmtlsName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">
    </cfif>
    AND tmtlsStatus IN (<cfqueryparam value="#ARGUMENTS.tmtlsStatus#" list="yes" cfsqltype="cf_sql_integer">)
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsTaskManagerTaskListingStatus = StructNew()>
    <cfset rsTaskManagerTaskListingStatus.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsTaskManagerTaskListingStatus>
    </cffunction>
    
    <cffunction name="setTaskManagerTaskListingStatusFilter" access="public" returntype="string" hint="Get Task Manager Task Listing Status Filter data.">
    <cfargument name="ID" type="numeric" required="yes" default="0">
    <cfset var setTaskManagerTaskListingStatusFilter = "" >
    <cftry>
    <cfset this.tmtlsList = '1,2'>
    <!---Determine which status should be displayed based on task manager action.--->
    <cfswitch expression="#ARGUMENTS.ID#">
    <cfcase value="1">
    <cfset this.tmtlsList = '1,2'>
    </cfcase>
    <cfcase value="2">
    <cfset this.tmtlsList = '2,3'>
    </cfcase>
    <cfcase value="3">
    <cfset this.tmtlsList = '3,4'>
    </cfcase>
    <cfcase value="4">
    <cfset this.tmtlsList = '4,5'>
    </cfcase>
    <cfcase value="5">
    <cfset this.tmtlsList = '5,6'>
    </cfcase>
    <cfcase value="6">
    <cfset this.tmtlsList = '6,7'>
    </cfcase>
    <cfcase value="7">
    <cfset this.tmtlsList = '7'>
    </cfcase>
    </cfswitch>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset setTaskManagerTaskListingStatusFilter = StructNew()>
    <cfset setTaskManagerTaskListingStatusFilter.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn this.tmtlsList>
    </cffunction>
    
    <cffunction name="setTaskManagerTaskNotification" access="public" returntype="void" hint="Get Task Manager Task Notification data.">
    <cfargument name="tmtID" type="numeric" required="yes" default="0">
    <cfargument name="deptNo" type="string" required="yes" default="0">
    <cfset var setTaskManagerTaskNotification = "" >
    <cftry>
    <!---Get task data.--->
    <cfinvoke 
    component="MCMS.component.app.task_manager.TaskManager"
    method="getTaskManagerTask"
    returnvariable="getTaskManagerTaskRet">
    <cfinvokeargument name="ID" value="#ARGUMENTS.tmtID#"/>
    <cfinvokeargument name="tmtDateRel" value="#DateFormat(Now(), application.dateFormat)#"/>
    <cfinvokeargument name="tmtDateExp" value="#DateFormat(Now(), application.dateFormat)#"/>
    <cfinvokeargument name="tmtStatus" value="1,2,3"/>
    </cfinvoke>
    
    <!---Do not send email if there is no record and date of release argument is not met.--->
    <cfif getTaskManagerTaskRet.recordcount NEQ 0>
    
    <cfset this.tmtsID = getTaskManagerTaskRet.tmtsID>
    <cfset this.tmtlsName = getTaskManagerTaskRet.tmtlsName>
    <cfset this.tmtpID = getTaskManagerTaskRet.tmtpID>
    <cfset this.tmtpName = getTaskManagerTaskRet.tmtpName>
    <cfset this.tmtName = getTaskManagerTaskRet.tmtName>
    
    <cfinvoke 
    component="MCMS.component.app.task_manager.TaskManager"
    method="getTaskManagerTaskSiteRel"
    returnvariable="getTaskManagerTaskSiteRelRet">
    <cfinvokeargument name="tmtID" value="#ARGUMENTS.tmtID#"/>
    <cfinvokeargument name="tmtsrStatus" value="1"/>
    </cfinvoke>
    
    <cfif getTaskManagerTaskSiteRelRet.recordcount NEQ 0>
    <cfset this.siteNoList = ValueList(getTaskManagerTaskSiteRelRet.siteNo)>
    <cfelse>
    <cfset this.siteNoList = 100>
    </cfif>
    
    <!---Now determine which emails to send out based on Managers.--->
    <cfinvoke 
    component="MCMS.component.cms.User"
    method="getUserSiteDepartmentRel"
    returnvariable="getUserSiteDepartmentRelRet">
    <cfinvokeargument name="urID" value="#application.taskManagerUserRoleApproverList#"/>
    <cfinvokeargument name="siteNo" value="100,#this.siteNoList#"/>
    <cfinvokeargument name="deptNo" value="0,#ARGUMENTS.deptNo#"/>
    <cfinvokeargument name="stID" value="1"/>
    <cfinvokeargument name="siteDateSet" value="#Now()#"/>
    <cfinvokeargument name="orderBy" value="urID"/>
    </cfinvoke>
    <cfset this.userApproverEmailList = ListRemoveDuplicates(ValueList(getUserSiteDepartmentRelRet.userEmail,';'),';')>
    
    <!---Based on siteNo, deptNo, and urID, send email notifications.--->
    <cfset this.toEmail = session.userUsername>
    <cfset this.emailSubject = "S.M.A.R.T. - #this.tmtName# - #UCASE(this.tmtpName)# - #UCASE(this.tmtlsName)#">
    <cfset this.fromEmail = session.userUsername>
    <cfset this.ccEmail = "#this.userApproverEmailList#">

    <cfswitch expression="#this.tmtsID#">
    <!---In Queue--->
    <cfcase value="2">
    <cfinvoke 
    component="MCMS.component.utility.Email"
    method="sendEmail">
    <cfinvokeargument name="subject" value="#this.emailSubject#"/>
    <cfinvokeargument name="to" value="#this.toEmail#"/>
    <cfinvokeargument name="from" value="#this.fromEmail#"/>
    <cfinvokeargument name="cc" value="#this.ccEmail#"/>
    <cfinvokeargument name="body" value=""/>
    <cfinvokeargument name="ID" value="#ARGUMENTS.tmtID#"/>
    <cfinvokeargument name="emailTemplate" value="/#application.mcmsAppAdminPath#/task_manager/view/inc_tm_task_email_template.cfm"/>
    </cfinvoke>
    </cfcase>
    </cfswitch>
    </cfif>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset setTaskManagerTaskNotification = StructNew()>
    <cfset setTaskManagerTaskNotification.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    </cffunction>
    
    <cffunction name="setTaskManagerTaskListingNotification" access="public" returntype="void" hint="Get Task Manager Task Listing Notification data.">
    <cfargument name="tmtlID" type="numeric" required="yes" default="0">
    <cfargument name="tmtID" type="numeric" required="yes" default="0">
    <cfargument name="byPass" type="string" required="yes" default="false">
    <cfset var setTaskManagerTaskListingNotification = "" >
    <cftry>
    <!---Get task data.--->
    <cfinvoke 
    component="MCMS.component.app.task_manager.TaskManager"
    method="getTaskManagerTaskListing"
    returnvariable="getTaskManagerTaskListingRet">
    <cfinvokeargument name="ID" value="#ARGUMENTS.tmtlID#"/>
    <cfinvokeargument name="tmtDateRel" value="#DateFormat(Now(), application.dateFormat)#"/>
    <cfinvokeargument name="tmtDateExp" value="#DateFormat(Now(), application.dateFormat)#"/>
    <cfinvokeargument name="tmtlStatus" value="1,2,3"/>
    </cfinvoke>
    
    <!---Do not send email if there is no record and date of release argument is not met.--->
    <cfif getTaskManagerTaskListingRet.recordcount NEQ 0>
    
    <cfset this.tmtlsID = getTaskManagerTaskListingRet.tmtlsID>
    <cfset this.tmtlsName = getTaskManagerTaskListingRet.tmtlsName>
    <cfset this.siteNo = getTaskManagerTaskListingRet.siteNo>
    <cfset this.deptNo = getTaskManagerTaskListingRet.deptNo>
    <cfset this.tmtpID = getTaskManagerTaskListingRet.tmtpID>
    <cfset this.tmtpName = getTaskManagerTaskListingRet.tmtpName>
    <cfset this.tmtName = getTaskManagerTaskListingRet.tmtName>
    
    <!---Get user role relationships.--->
    <cfinvoke 
    component="MCMS.component.app.task_manager.TaskManager"
    method="getTaskManagerTaskUserRoleRel"
    returnvariable="getTaskManagerTaskUserRoleRelRet">
    <cfinvokeargument name="tmtID" value="#ARGUMENTS.tmtID#"/>
    <cfinvokeargument name="tmturrStatus" value="1,2,3"/>
    </cfinvoke>
    <cfset this.userRoleIDList = ValueList(getTaskManagerTaskUserRoleRelRet.urID)>
    
    <!---Now determine which emails to send out to users responsible for the task--->
    <cfinvoke 
    component="MCMS.component.cms.User"
    method="getUserSiteDepartmentRel"
    returnvariable="getUserSiteDepartmentRelRet">
    <cfinvokeargument name="urID" value="#ListRemoveDuplicates(this.userRoleIDList)#"/>
    <cfinvokeargument name="siteNo" value="#this.siteNo#"/>
    <cfinvokeargument name="stID" value="1"/>
    <cfinvokeargument name="siteDateSet" value="#Now()#"/>
    <cfinvokeargument name="deptNo" value="0,#this.deptNo#"/>
    </cfinvoke>
    <cfset this.toEmailList = ListRemoveDuplicates(ValueList(getUserSiteDepartmentRelRet.userEmail,';'),';')>
    
    <!---Now determine which emails to send out based on Approvers.--->
    <cfinvoke 
    component="MCMS.component.cms.User"
    method="getUserSiteDepartmentRel"
    returnvariable="getUserSiteDepartmentRelRet">
    <cfinvokeargument name="urID" value="#application.taskManagerUserRoleApproverList#"/>
    <cfinvokeargument name="siteNo" value="#this.siteNo#"/>
    <cfinvokeargument name="deptNo" value="0,#this.deptNo#"/>
    <cfinvokeargument name="stID" value="1"/>
    <cfinvokeargument name="siteDateSet" value="#Now()#"/>
    <cfinvokeargument name="orderBy" value="urID"/>
    </cfinvoke>
    <cfset this.userApproverEmailList = ListRemoveDuplicates(ValueList(getUserSiteDepartmentRelRet.userEmail,';'),';')>
    
    <!---Based on siteNo, deptNo, and urID, send email notifications.--->
    <cfset this.toEmail = this.toEmailList>
    <cfset this.emailSubject = "S.M.A.R.T. - #this.tmtName# - #UCASE(this.tmtpName)# - #UCASE(this.tmtlsName)#">
    <cfset this.fromEmail = session.userUsername>
    <cfset this.ccEmail = "#this.userApproverEmailList#">

    <cfswitch expression="#this.tmtlsID#">
    <!---In Queue--->
    <cfcase value="2">
    <cfinvoke 
    component="MCMS.component.utility.Email"
    method="sendEmail">
    <cfinvokeargument name="subject" value="#this.emailSubject#"/>
    <cfinvokeargument name="to" value="#this.toEmail#"/>
    <cfinvokeargument name="from" value="#this.fromEmail#"/>
    <cfinvokeargument name="cc" value=""/>
    <cfinvokeargument name="body" value=""/>
    <cfinvokeargument name="ID" value="#ARGUMENTS.tmtlID#"/>
    <cfinvokeargument name="emailTemplate" value="/#application.mcmsAppAdminPath#/task_manager/view/inc_tm_task_listing_email_template.cfm"/>
    </cfinvoke>
    </cfcase>
    <!---Awaiting Approval--->
    <cfcase value="4">
    <!---Choose the store manager for this email.--->
    <cfloop query="getUserSiteDepartmentRelRet" endrow="3">
    <cfif getUserSiteDepartmentRelRet.urID EQ 104>
    <cfset this.userApproverEmailList = getUserSiteDepartmentRelRet.userEmail>
    <cfbreak>
    <cfelseif getUserSiteDepartmentRelRet.urID EQ 105 AND getUserSiteDepartmentRelRet.userPrimarySiteNo EQ this.siteNo>
    <cfset this.userApproverEmailList = getUserSiteDepartmentRelRet.userEmail>
    <cfbreak>
    <cfelseif getUserSiteDepartmentRelRet.urID EQ 106>
    <cfset this.userApproverEmailList = getUserSiteDepartmentRelRet.userEmail>
    </cfif>
    </cfloop>
    <cfset this.ccEmail = "#this.userApproverEmailList#">
    <cfinvoke 
    component="MCMS.component.utility.Email"
    method="sendEmail">
    <cfinvokeargument name="subject" value="#this.emailSubject#"/>
    <cfinvokeargument name="to" value="#this.toEmail#"/>
    <cfinvokeargument name="from" value="#this.fromEmail#"/>
    <cfinvokeargument name="cc" value="#this.ccEmail#"/>
    <cfinvokeargument name="body" value=""/>
    <cfinvokeargument name="ID" value="#ARGUMENTS.tmtlID#"/>
    <cfinvokeargument name="emailTemplate" value="/#application.mcmsAppAdminPath#/task_manager/view/inc_tm_task_listing_email_template.cfm"/>
    </cfinvoke>
    </cfcase>
    </cfswitch>
    
    <!---Switch the email when a response has been made to a log.--->
    <cfif session.userUsername EQ getTaskManagerTaskListingRet.userEmail>
    <cfset this.userEmail = this.userApproverEmailList>
    <cfelse>
    <cfset this.userEmail = getTaskManagerTaskListingRet.userEmail>
    </cfif>
    
    <cfswitch expression="#ARGUMENTS.byPass#">
    <!---Notify log entry.--->
    <cfcase value="log">
    <!---Based on siteNo, deptNo, and urID, send email notifications.--->
    <cfset this.toEmail = this.userEmail>
    <cfset this.emailSubject = "S.M.A.R.T. - #this.tmtName# - #UCASE(this.tmtpName)# - Needs & Concerns">
    <cfset this.fromEmail = session.userUsername>
    <cfset this.ccEmail = "#this.userApproverEmailList#">
    <cfinvoke 
    component="MCMS.component.utility.Email"
    method="sendEmail">
    <cfinvokeargument name="subject" value="#this.emailSubject#"/>
    <cfinvokeargument name="to" value="#this.toEmail#"/>
    <cfinvokeargument name="from" value="#this.fromEmail#"/>
    <cfinvokeargument name="cc" value="#this.ccEmail#"/>
    <cfinvokeargument name="body" value=""/>
    <cfinvokeargument name="ID" value="#ARGUMENTS.tmtlID#"/>
    <cfinvokeargument name="emailTemplate" value="/#application.mcmsAppAdminPath#/task_manager/view/inc_tm_task_listing_log_email_template.cfm"/>
    </cfinvoke>
    </cfcase>
    </cfswitch>
    </cfif>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset setTaskManagerTaskListingNotification = StructNew()>
    <cfset setTaskManagerTaskListingNotification.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    </cffunction>
    
    <cffunction name="getTaskManagerTaskListingLog" access="public" returntype="query" hint="Get Task Manager Task Listing Log data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="ID" type="numeric" required="yes" default="0">
    <cfargument name="excludeID" type="numeric" required="yes" default="0">
    <cfargument name="tmtlID" type="numeric" required="yes" default="0">
    <cfargument name="tmtllStatus" type="string" required="yes" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="tmtllDate DESC">
    <cfset var rsTaskManagerTaskListingLog = "" >
    <cftry>
    <cfquery name="rsTaskManagerTaskListingLog" datasource="#application.mcmsDSN#">
    SELECT * FROM v_tm_task_listing_log WHERE 0=0
    <cfif ARGUMENTS.ID NEQ 0>
    AND ID = <cfqueryparam value="#ARGUMENTS.ID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.excludeID NEQ 0>
    AND ID <> <cfqueryparam value="#ARGUMENTS.excludeID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.tmtlID NEQ 0>
    AND tmtlID = <cfqueryparam value="#ARGUMENTS.tmtlID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND UPPER(tmtllLog) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">
    </cfif>
    AND tmtllStatus IN (<cfqueryparam value="#ARGUMENTS.tmtllStatus#" list="yes" cfsqltype="cf_sql_integer">)
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsTaskManagerTaskListingLog = StructNew()>
    <cfset rsTaskManagerTaskListingLog.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsTaskManagerTaskListingLog>
    </cffunction>
    
    <cffunction name="getTaskManagerTaskSiteRel" access="public" returntype="query" hint="Get Task Manager Task Site Relationship data.">
    <cfargument name="keywords" type="string" required="no" default="All">
    <cfargument name="ID" type="numeric" required="yes" default="0">
    <cfargument name="excludeID" type="numeric" required="yes" default="0">
    <cfargument name="tmtID" type="string" required="yes" default="0">
    <cfargument name="siteNo" type="string" required="yes" default="100">
    <cfargument name="tmtDateRel" type="string" required="yes" default="">
    <cfargument name="tmtDateExp" type="string" required="yes" default="">
    <cfargument name="siteStatus" type="string" required="no" default="1">
    <cfargument name="tmtsrStatus" type="string" required="yes" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="siteNo">
	<cfset var rsTaskManagerTaskSiteRel = "" >
    <cftry>
    <cfquery name="rsTaskManagerTaskSiteRel" datasource="#application.mcmsDSN#">
    SELECT * FROM v_tm_task_site_rel WHERE 0=0
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND tmtName LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> 
    </cfif>
    <cfif ARGUMENTS.ID NEQ 0>
    AND ID = <cfqueryparam value="#ARGUMENTS.ID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.excludeID NEQ 0>
    AND ID <> <cfqueryparam value="#ARGUMENTS.excludeID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.tmtID NEQ 0>
    AND tmtID IN (<cfqueryparam value="#ARGUMENTS.tmtID#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    <cfif ARGUMENTS.siteNo NEQ 100>
    AND siteNo IN (<cfqueryparam value="#ARGUMENTS.siteNo#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    <cfif ARGUMENTS.tmtDateRel NEQ "">
    AND tmtDateRel <= <cfqueryparam value="#ARGUMENTS.tmtDateRel#" cfsqltype="cf_sql_date">
    </cfif>
    <cfif ARGUMENTS.tmtDateExp NEQ "">
    AND tmtDateExp >= <cfqueryparam value="#ARGUMENTS.tmtDateExp#" cfsqltype="cf_sql_date">
	</cfif>
    AND (siteStatus IN (<cfqueryparam value="#ARGUMENTS.siteStatus#" list="yes" cfsqltype="cf_sql_integer">) OR siteStatus IS NULL)
    AND tmtsrStatus IN (<cfqueryparam value="#ARGUMENTS.tmtsrStatus#" list="yes" cfsqltype="cf_sql_integer">)
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsTaskManagerTaskSiteRel = StructNew()>
    <cfset rsTaskManagerTaskSiteRel.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsTaskManagerTaskSiteRel>
    </cffunction>
    
    <cffunction name="getTaskManagerTaskDepartmentRel" access="public" returntype="query" hint="Get Task Manager Task Dept. Relationship data.">
    <cfargument name="keywords" type="string" required="no" default="All">
    <cfargument name="ID" type="numeric" required="yes" default="0">
    <cfargument name="excludeID" type="numeric" required="yes" default="0">
    <cfargument name="tmtID" type="string" required="yes" default="0">
    <cfargument name="deptNo" type="string" required="yes" default="0">
    <cfargument name="tmtDateRel" type="string" required="yes" default="">
    <cfargument name="tmtDateExp" type="string" required="yes" default="">
    <cfargument name="deptStatus" type="string" required="no" default="1">
    <cfargument name="tmtdrStatus" type="string" required="yes" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="deptNo">
	<cfset var rsTaskManagerTaskDeptRel = "" >
    <cftry>
    <cfquery name="rsTaskManagerTaskDeptRel" datasource="#application.mcmsDSN#">
    SELECT * FROM v_tm_task_dept_rel WHERE 0=0
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND tmtName LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> 
    </cfif>
    <cfif ARGUMENTS.ID NEQ 0>
    AND ID = <cfqueryparam value="#ARGUMENTS.ID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.excludeID NEQ 0>
    AND ID <> <cfqueryparam value="#ARGUMENTS.excludeID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.tmtID NEQ 0>
    AND tmtID IN (<cfqueryparam value="#ARGUMENTS.tmtID#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    <cfif ARGUMENTS.deptNo NEQ 0>
    AND deptNo IN (<cfqueryparam value="#ARGUMENTS.deptNo#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    <cfif ARGUMENTS.tmtDateRel NEQ "">
    AND tmtDateRel <= <cfqueryparam value="#ARGUMENTS.tmtDateRel#" cfsqltype="cf_sql_date">
    </cfif>
    <cfif ARGUMENTS.tmtDateExp NEQ "">
    AND tmtDateExp >= <cfqueryparam value="#ARGUMENTS.tmtDateExp#" cfsqltype="cf_sql_date">
	</cfif>
    AND (deptStatus IN (<cfqueryparam value="#ARGUMENTS.deptStatus#" list="yes" cfsqltype="cf_sql_integer">) OR deptStatus IS NULL)
    AND tmtdrStatus IN (<cfqueryparam value="#ARGUMENTS.tmtdrStatus#" list="yes" cfsqltype="cf_sql_integer">)
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsTaskManagerTaskDeptRel = StructNew()>
    <cfset rsTaskManagerTaskDeptRel.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsTaskManagerTaskDeptRel>
    </cffunction>
    
    <cffunction name="getTaskManagerTaskUserRoleRel" access="public" returntype="query" hint="Get Task Manager Task User Role Relationship data.">
    <cfargument name="keywords" type="string" required="no" default="All">
    <cfargument name="ID" type="numeric" required="yes" default="0">
    <cfargument name="excludeID" type="numeric" required="yes" default="0">
    <cfargument name="tmtID" type="string" required="yes" default="0">
    <cfargument name="urID" type="string" required="yes" default="100">
    <cfargument name="tmturrStatus" type="string" required="yes" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="urName">
	<cfset var rsTaskManagerTaskUserRoleRel = "" >
    <cftry>
    <cfquery name="rsTaskManagerTaskUserRoleRel" datasource="#application.mcmsDSN#">
    SELECT * FROM v_tm_task_user_role_rel WHERE 0=0
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND tmtName LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> 
    </cfif>
    <cfif ARGUMENTS.ID NEQ 0>
    AND ID = <cfqueryparam value="#ARGUMENTS.ID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.excludeID NEQ 0>
    AND ID <> <cfqueryparam value="#ARGUMENTS.excludeID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.tmtID NEQ 0>
    AND tmtID IN (<cfqueryparam value="#ARGUMENTS.tmtID#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    <cfif ARGUMENTS.urID NEQ 100>
    AND urID IN (<cfqueryparam value="#ARGUMENTS.urID#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    AND (urStatus IN (<cfqueryparam value="#ARGUMENTS.tmturrStatus#" list="yes" cfsqltype="cf_sql_integer">) OR urStatus IS NULL)
    AND tmturrStatus IN (<cfqueryparam value="#ARGUMENTS.tmturrStatus#" list="yes" cfsqltype="cf_sql_integer">)
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsTaskManagerTaskUserRoleRel = StructNew()>
    <cfset rsTaskManagerTaskUserRoleRel.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsTaskManagerTaskUserRoleRel>
    </cffunction>
    
    <cffunction name="getTaskManagerTaskImageRel" access="public" returntype="query" hint="Get Task Manager Task Image Relationship data.">
    <cfargument name="keywords" type="string" required="no" default="All">
    <cfargument name="ID" type="numeric" required="yes" default="0">
    <cfargument name="excludeID" type="numeric" required="yes" default="0">
    <cfargument name="tmtID" type="string" required="yes" default="0">
    <cfargument name="imgID" type="string" required="yes" default="0">
    <cfargument name="imgStatus" type="string" required="no" default="1">
    <cfargument name="tmtirStatus" type="string" required="yes" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="tmtID">
	<cfset var rsTaskManagerTaskImageRel = "" >
    <cftry>
    <cfquery name="rsTaskManagerTaskImageRel" datasource="#application.mcmsDSN#">
    SELECT * FROM v_tm_task_image_rel WHERE 0=0
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND tmtName LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> 
    </cfif>
    <cfif ARGUMENTS.ID NEQ 0>
    AND ID = <cfqueryparam value="#ARGUMENTS.ID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.excludeID NEQ 0>
    AND ID <> <cfqueryparam value="#ARGUMENTS.excludeID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.tmtID NEQ 0>
    AND tmtID IN (<cfqueryparam value="#ARGUMENTS.tmtID#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    <cfif ARGUMENTS.imgID NEQ 0>
    AND imgID IN (<cfqueryparam value="#ARGUMENTS.imgID#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    AND (imgStatus IN (<cfqueryparam value="#ARGUMENTS.imgStatus#" list="yes" cfsqltype="cf_sql_integer">) OR imgStatus IS NULL)
    AND tmtirStatus IN (<cfqueryparam value="#ARGUMENTS.tmtirStatus#" list="yes" cfsqltype="cf_sql_integer">)
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsTaskManagerTaskImageRel = StructNew()>
    <cfset rsTaskManagerTaskImageRel.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsTaskManagerTaskImageRel>
    </cffunction>
    
    <cffunction name="getTaskManagerTaskDocumentRel" access="public" returntype="query" hint="Get Task Manager Task Document Relationship data.">
    <cfargument name="keywords" type="string" required="no" default="All">
    <cfargument name="ID" type="numeric" required="yes" default="0">
    <cfargument name="excludeID" type="numeric" required="yes" default="0">
    <cfargument name="tmtID" type="string" required="yes" default="0">
    <cfargument name="docID" type="string" required="yes" default="0">
    <cfargument name="docStatus" type="string" required="no" default="1">
    <cfargument name="tmtdrStatus" type="string" required="yes" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="tmtID">
	<cfset var rsTaskManagerTaskDocumentRel = "" >
    <cftry>
    <cfquery name="rsTaskManagerTaskDocumentRel" datasource="#application.mcmsDSN#">
    SELECT * FROM v_tm_task_document_rel WHERE 0=0
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND tmtName LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> 
    </cfif>
    <cfif ARGUMENTS.ID NEQ 0>
    AND ID = <cfqueryparam value="#ARGUMENTS.ID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.excludeID NEQ 0>
    AND ID <> <cfqueryparam value="#ARGUMENTS.excludeID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.tmtID NEQ 0>
    AND tmtID IN (<cfqueryparam value="#ARGUMENTS.tmtID#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    <cfif ARGUMENTS.docID NEQ 0>
    AND docID IN (<cfqueryparam value="#ARGUMENTS.docID#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    AND (docStatus IN (<cfqueryparam value="#ARGUMENTS.docStatus#" list="yes" cfsqltype="cf_sql_integer">) OR docStatus IS NULL)
    AND tmtdrStatus IN (<cfqueryparam value="#ARGUMENTS.tmtdrStatus#" list="yes" cfsqltype="cf_sql_integer">)
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsTaskManagerTaskDocumentRel = StructNew()>
    <cfset rsTaskManagerTaskDocumentRel.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsTaskManagerTaskDocumentRel>
    </cffunction>
    
    <cffunction name="getTaskManagerTaskURLRel" access="public" returntype="query" hint="Get Task Manager Task URL Relationship data.">
    <cfargument name="keywords" type="string" required="no" default="All">
    <cfargument name="ID" type="numeric" required="yes" default="0">
    <cfargument name="excludeID" type="numeric" required="yes" default="0">
    <cfargument name="tmtID" type="string" required="yes" default="0">
    <cfargument name="tmtuName" type="string" required="yes" default="">
    <cfargument name="tmturStatus" type="string" required="yes" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="tmtID">
	<cfset var rsTaskManagerTaskURLRel = "" >
    <cftry>
    <cfquery name="rsTaskManagerTaskURLRel" datasource="#application.mcmsDSN#">
    SELECT * FROM v_tm_task_url_rel WHERE 0=0
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (tmtName LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR tmtuName LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR tmtuURL LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">)
    </cfif>
    <cfif ARGUMENTS.ID NEQ 0>
    AND ID = <cfqueryparam value="#ARGUMENTS.ID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.excludeID NEQ 0>
    AND ID <> <cfqueryparam value="#ARGUMENTS.excludeID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.tmtuName NEQ "">
    AND UPPER(tmtuName) = <cfqueryparam value="#UCASE(ARGUMENTS.tmtuName)#" cfsqltype="cf_sql_varchar">
    </cfif>
    <cfif ARGUMENTS.tmtID NEQ 0>
    AND tmtID IN (<cfqueryparam value="#ARGUMENTS.tmtID#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    AND tmturStatus IN (<cfqueryparam value="#ARGUMENTS.tmturStatus#" list="yes" cfsqltype="cf_sql_integer">)
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsTaskManagerTaskURLRel = StructNew()>
    <cfset rsTaskManagerTaskURLRel.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsTaskManagerTaskURLRel>
    </cffunction>
    
    <cffunction name="getTaskManagerTaskReport" access="public" returntype="query" hint="Get Task Manager Task Report data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="siteNo" type="string" required="yes" default="100">
    <cfargument name="deptNo" type="string" required="yes" default="0">
    <cfargument name="args" type="string" required="yes" default="0">
    <cfargument name="orderBy" type="string" required="yes" default="tmtName">
    <cfset var rsTaskManagerTaskReport = "" >
    <cftry>
    <cfquery name="rsTaskManagerTaskReport" datasource="#application.mcmsDSN#">
    SELECT ID AS Task_ID, tmtName AS Task_Name, TO_CHAR(tmtDescription) AS Description, tmttName AS Task_Type, tmtpName AS Priority, tmtlsName AS Task_Status, TO_CHAR(tmtDateDue,'MM/DD/YYYY') AS Date_Due, TO_CHAR(tmtDateRel,'MM/DD/YYYY') AS Date_Rel, TO_CHAR(tmtDateExp,'MM/DD/YYYY') AS Date_Exp FROM v_tm_task WHERE 0=0
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(tmtName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(tmtDescription) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">)
    </cfif>
    <cfif ARGUMENTS.args NEQ 0>
    AND tmtsID = <cfqueryparam value="#ListGetAt(ARGUMENTS.args, 1)#" cfsqltype="cf_sql_integer">
    </cfif>
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsTaskManagerTaskReport = StructNew()>
    <cfset rsTaskManagerTaskReport.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsTaskManagerTaskReport>
    </cffunction>
    
    <cffunction name="getTaskManagerTaskListingReport" access="public" returntype="query" hint="Get Task Manager Task Listing Report data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="siteNo" type="string" required="yes" default="100">
    <cfargument name="deptNo" type="string" required="yes" default="0">
    <cfargument name="args" type="string" required="yes" default="0">
    <cfargument name="orderBy" type="string" required="yes" default="tmtlsID, tmtName, siteNo, deptNo">
    <cfset var rsTaskManagerTaskListingReport = "" >
    <cftry>
    <cfquery name="rsTaskManagerTaskListingReport" datasource="#application.mcmsDSN#">
    SELECT ID AS Task_Listing_ID, tmtID AS Task_ID, tmtName AS Task_Name, TO_CHAR(tmtDescription) AS Description, siteNo AS Site_No, siteName AS Site, deptNo AS Dept_No, deptName AS Department, tmttName AS Task_Type, tmtpName AS Priority, tmtlsName AS Task_Status, tmtlApprovalUserFName || ' ' || tmtlApprovalUserLName AS Approver, TO_CHAR(tmtDateDue,'MM/DD/YYYY') AS Date_Due, TO_CHAR(tmtlDateUpdate,'MM/DD/YYYY') AS Date_Update, TO_CHAR(tmtDateRel,'MM/DD/YYYY') AS Date_Rel, TO_CHAR(tmtDateExp,'MM/DD/YYYY') AS Date_Exp FROM v_tm_task_listing WHERE 0=0
    <cfif ARGUMENTS.keywords NEQ 'All' AND NOT IsNumeric(ARGUMENTS.keywords)>
    AND (UPPER(tmtName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(tmtDescription) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">)
    </cfif>
    <cfif IsNumeric(ARGUMENTS.keywords)>
    AND tmtID = <cfqueryparam value="#ARGUMENTS.keywords#" cfsqltype="cf_sql_integer">
    </cfif>
    AND tmtDateExp >= <cfqueryparam value="#DateFormat(Now(), application.dateFormat)#" cfsqltype="cf_sql_date">
    <cfif ARGUMENTS.siteNo NEQ 100>
    AND siteNo IN (<cfqueryparam value="#ARGUMENTS.siteNo#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    <cfif ARGUMENTS.deptNo NEQ 0>
    AND deptNo IN (<cfqueryparam value="#ARGUMENTS.deptNo#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    <cfif ARGUMENTS.args NEQ 0>
    AND tmtlsID = <cfqueryparam value="#ListGetAt(ARGUMENTS.args, 1)#" cfsqltype="cf_sql_integer">
    </cfif>
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsTaskManagerTaskListingReport = StructNew()>
    <cfset rsTaskManagerTaskListingReport.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsTaskManagerTaskListingReport>
    </cffunction>
    
    <cffunction name="getTaskManagerTaskTypeReport" access="public" returntype="query" hint="Get Task Manager Task Type Report data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="orderBy" type="string" required="yes" default="tmttSort,tmttName">
    <cfset var rsTaskManagerTaskTypeReport = "" >
    <cftry>
    <cfquery name="rsTaskManagerTaskTypeReport" datasource="#application.mcmsDSN#">
    SELECT tmttName AS Type, TO_CHAR(tmttDescription) AS Description, sortName AS Sort, sName AS Status FROM v_tm_task_type WHERE 0=0
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND UPPER(tmttName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">
    </cfif>
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsTaskManagerTaskTypeReport = StructNew()>
    <cfset rsTaskManagerTaskTypeReport.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsTaskManagerTaskTypeReport>
    </cffunction>
    
    <cffunction name="getSendReminderEmail" hint="Send an email to the parties responsible for receiving incomplete tasks." access="public" returntype="struct" output="false">
    <cfargument name="ID" required="yes" type="numeric" default="0">
    <cfargument name="tmtlID" required="yes" type="string" default="0">
    <cfargument name="siteNo" required="yes" type="numeric" default="0">
    <cfargument name="deptNo" required="yes" type="numeric" default="0">
    <cfargument name="fromEmail" required="yes" type="string" default="#session.userUsername#">
    <cfargument name="ccEmail" required="yes" type="string" default="#session.userUsername#">
    <cfset result.message = "You have successfully sent the reminder email.">
    <cftry>
    <!---Get users by deparment and site.--->
    <!---Get the User roles for this task.--->
    <cfinvoke 
    component="MCMS.component.app.task_manager.TaskManager"
    method="getTaskManagerTaskUserRoleRel"
    returnvariable="getTaskManagerTaskUserRoleRelRet">
    <cfinvokeargument name="tmtID" value="#ARGUMENTS.ID#"/>
    <cfinvokeargument name="tmturrStatus" value="1,2,3"/>
    </cfinvoke>
    <cfset this.urIDList = ValueList(getTaskManagerTaskUserRoleRelRet.urID)>
    <cfset this.tmtName = getTaskManagerTaskUserRoleRelRet.tmtName>
    <cfinvoke 
    component="MCMS.component.cms.User"
    method="getUserSiteDepartmentRel"
    returnvariable="getUserSiteDepartmentRelRet">
    <cfinvokeargument name="urID" value="#ListRemoveDuplicates(this.urIDList)#,#application.taskManagerUserRoleApproverList#"/>
    <cfinvokeargument name="stID" value="1"/>
    <cfinvokeargument name="siteNo" value="#ARGUMENTS.siteNo#"/>
    <cfinvokeargument name="deptNo" value="0,#ARGUMENTS.deptNo#"/>
    <cfinvokeargument name="userStatus" value="1"/>
    </cfinvoke>
    <cfif getUserSiteDepartmentRelRet.RecordCount NEQ 0>
    <cfset urEmail = ValueList(getUserSiteDepartmentRelRet.userEmail, ';')>
    <cfelse>
    <cfset urEmail = application.webmasterEmail>
    </cfif>
    <cfset reminderEmail = "#urEmail#">
    <!---Create email string for reminder email based on department.--->
    <cfinvoke 
    component="MCMS.component.app.department.Department"
    method="getDepartment"
    returnvariable="getDepartmentRet">
    <cfinvokeargument name="deptNo" value="#ARGUMENTS.deptNo#"/>
    <cfinvokeargument name="deptStatus" value="1"/>
    </cfinvoke>
    <cfinvoke 
    component="MCMS.component.utility.Email"
    method="sendEmail">
    <cfinvokeargument name="subject" value="S.M.A.R.T Reminder from #ARGUMENTS.fromEmail# for #this.tmtName#"/>
    <cfinvokeargument name="to" value="#reminderEmail#"/>
    <cfinvokeargument name="from" value="#ARGUMENTS.fromEmail#"/>
    <cfinvokeargument name="cc" value="#ARGUMENTS.ccEmail#"/>
    <cfinvokeargument name="body" value=""/>
    <cfinvokeargument name="ID" value="#ARGUMENTS.tmtlID#"/>
    <cfinvokeargument name="emailTemplate" value="/#application.mcmsAppAdminPath#/task_manager/view/inc_tmt_task_listing_reminder_email_template.cfm"/>
    </cfinvoke>
    <cfcatch type="any">
    <cfset result.message = "There was an error sending the reminder email.">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="setTaskManagerDueReminderEmail" hint="Send an email to the parties that have tasks that are over due and incomplete." access="public" returntype="struct" output="false">
    <cfset result.message = "You have successfully sent the reminder email.">
    <cftry>
    <!---Get all tasks that are past due and not complete or closed.--->
	<cfset this.tmtIDList = 0>
    <cfinvoke 
    component="MCMS.component.app.task_manager.TaskManager"
    method="getTaskManagerTask"
    returnvariable="getTaskManagerTaskRet">
    <cfinvokeargument name="tmtsID" value="2,3,4"/>
    <cfinvokeargument name="tmtDateDueEmailCheckDays" value="#application.tmtDateDueEmailCheckDays#"/>
    <cfinvokeargument name="tmtStatus" value="1"/>
    </cfinvoke>
    <cfif getTaskManagerTaskRet.recordcount NEQ 0>
    <!---Now that we have a list of tasks that are over due and not complete. Gather all the task listings that are not complete.--->
    <cfset this.tmtIDList = ValueList(getTaskManagerTaskRet.ID)>
    <!---Get all task listings that are not complete or closed.--->
	<cfinvoke 
    component="MCMS.component.app.task_manager.TaskManager"
    method="getTaskManagerTaskListing"
    returnvariable="getTaskManagerTaskListingRet">
    <cfinvokeargument name="tmtID" value="#this.tmtIDList#"/>
    <cfinvokeargument name="tmtlsID" value="1,2,3,4"/>
    <cfinvokeargument name="tmtlsStatus" value="1"/>
    </cfinvoke>
    <cfif getTaskManagerTaskListingRet.recordcount NEQ 0>
    <cfoutput query="getTaskManagerTaskListingRet">	
    <cfinvoke 
 	component="MCMS.component.app.task_manager.TaskManager"
 	method="getSendReminderEmail"
 	returnvariable="result">
	<cfinvokeargument name="ID" value="#getTaskManagerTaskListingRet.tmtID#"/>
	<cfinvokeargument name="tmtlID" value="#getTaskManagerTaskListingRet.ID#"/>
	<cfinvokeargument name="siteNo" value="#getTaskManagerTaskListingRet.siteNo#"/>
	<cfinvokeargument name="deptNo" value="#getTaskManagerTaskListingRet.deptNo#"/>
	<cfinvokeargument name="fromEmail" value="#application.noReplyEmail#"/>
	<cfinvokeargument name="ccEmail" value="#getTaskManagerTaskListingRet.userEmail#"/>
	</cfinvoke>
	</cfoutput>
    </cfif>
    </cfif>
    <cfcatch type="any">
    <cfset result.message = "There was an error with setTaskManagerDueReminderEmail().">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="insertTaskManagerTask" access="public" returntype="struct">
    <cfargument name="tmtName" type="string" required="yes">
    <cfargument name="tmtDescription" type="string" required="yes">
    <cfargument name="tmtDateRel" type="date" required="yes">
    <cfargument name="tmtDateExp" type="date" required="yes">
    <cfargument name="tmtDateStart" type="date" required="yes" default="#DateFormat(Now(), application.dateFormat)#">
    <cfargument name="tmtDateDue" type="date" required="yes" default="#DateFormat(Now(), application.dateFormat)#">
    <cfargument name="tmtStartTimeID" type="numeric" required="yes" default="0">
    <cfargument name="tmtEndTimeID" type="numeric" required="yes" default="0">
    <cfargument name="tmttID" type="numeric" required="yes">
    <cfargument name="tmtpID" type="numeric" required="yes">
    <cfargument name="userID" type="numeric" required="yes">
    <cfargument name="tmtStatus" type="numeric" required="yes">
    <!---Include relationships.--->
    <cfargument name="siteNo" type="string" required="yes">
    <cfargument name="deptNo" type="string" required="yes">
    <cfargument name="urID" type="string" required="yes">
    <cfset result.message = "You have successfully inserted the record. You will now be redirected to complete the task.">
    <cftry>
    <!---Check for profanity in the text.--->
    <cfinvoke 
    component="MCMS.component.utility.Regex"
    method="regexProfanity"
    returnvariable="regexProfanityRet">
    <cfinvokeargument name="profanityString" value="#ARGUMENTS.tmtDescription#"/>
    </cfinvoke>
    <!---Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.app.task_manager.TaskManager"
    method="getTaskManagerTask"
    returnvariable="getCheckTaskManagerTaskRet">
    <cfinvokeargument name="tmtName" value="#ARGUMENTS.tmtName#"/>
    <cfinvokeargument name="tmtStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckTaskManagerTaskRet.recordcount NEQ 0>
    <cfset result.message = "The name #ARGUMENTS.tmtName# already exists, please enter a new name.">
    <cfelseif regexProfanityRet CONTAINS '$%&*!'>
    <cfset result.message = "Some text contained profanity, please remove any profanity from your text.">
    <!---Check length restriction.--->
    <cfelseif LEN(ARGUMENTS.tmtDescription) GT 4000>
    <cfset result.message = "The description is longer than 4000 characters, please enter a new description under 4000 characters.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    INSERT INTO tbl_tm_task (tmtName,tmtDescription,tmtDateRel,tmtDateExp,tmtDateStart,tmtDateDue,tmtStartTimeID,tmtEndTimeID,tmttID,tmtpID,userID,tmtStatus) VALUES
    (
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.tmtName#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.tmtDescription#">,
    <cfqueryparam cfsqltype="cf_sql_date" value="#ARGUMENTS.tmtDateRel#">,
    <cfqueryparam cfsqltype="cf_sql_date" value="#ARGUMENTS.tmtDateExp#">,
    <cfqueryparam cfsqltype="cf_sql_date" value="#ARGUMENTS.tmtDateStart#">,
    <cfqueryparam cfsqltype="cf_sql_date" value="#ARGUMENTS.tmtDateDue#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.tmtStartTimeID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.tmtEndTimeID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.tmttID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.tmtpID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.userID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.tmtStatus#">
    )
    </cfquery>
    </cftransaction>
    <!--- Get newly inserted task ID. --->
    <cfinvoke 
    component="MCMS.component.cms.Cms"
    method="getMaxValueSQL"
    returnvariable="tmtID">
    <cfinvokeargument name="tableName" value="tbl_tm_task"/>
    </cfinvoke>
    <cfset var.tmtID = tmtID>
    <!---Create site relationships.--->
    <cfloop index="siteNo" list="#ARGUMENTS.siteNo#">
    <cfinvoke 
    component="MCMS.component.app.task_manager.TaskManager"
    method="insertTaskManagerTaskSiteRel">
    <cfinvokeargument name="tmtID" value="#var.tmtID#"/>
    <cfinvokeargument name="siteNo" value="#siteNo#"/>
    <cfinvokeargument name="tmtsrStatus" value="1"/>
    </cfinvoke>
    </cfloop>
    <!---Create department relationships.--->
    <cfloop index="deptNo" list="#ARGUMENTS.deptNo#">
    <cfinvoke 
    component="MCMS.component.app.task_manager.TaskManager"
    method="insertTaskManagerTaskDepartmentRel">
    <cfinvokeargument name="tmtID" value="#var.tmtID#"/>
    <cfinvokeargument name="deptNo" value="#deptNo#"/>
    <cfinvokeargument name="tmtdrStatus" value="1"/>
    </cfinvoke>
    </cfloop>
    <!---Create user role relationships.--->
    <cfloop index="urID" list="#ARGUMENTS.urID#">
    <cfinvoke 
    component="MCMS.component.app.task_manager.TaskManager"
    method="insertTaskManagerTaskUserRoleRel">
    <cfinvokeargument name="tmtID" value="#var.tmtID#"/>
    <cfinvokeargument name="urID" value="#urID#"/>
    <cfinvokeargument name="tmturrStatus" value="1"/>
    </cfinvoke>
    </cfloop>
	<!---Forward to update form.--->
    <cfset ajaxOnLoad("function() {
    lAjax('layoutIndex', #url.appID#, 'Task' ,'/#application.mcmsAppAdminPath#/task_manager/view/inc_tm_task.cfm','Task','update', #var.tmtID#);
    }")>
    </cfif>
    <cfcatch type="any">
    <cfset result.message = "There was an error inserting the record.">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="insertTaskManagerTaskListing" access="public" returntype="struct">
    <cfargument name="tmtID" type="numeric" required="yes">
    <cfargument name="siteNo" type="numeric" required="yes">
    <cfargument name="deptNo" type="numeric" required="yes">
    <cfargument name="tmtlsID" type="numeric" required="yes" default="1">
    <cfset result.message = "You have successfully inserted the record.">
    <cftry>
    Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.app.task_manager.TaskManager"
    method="getTaskManagerTaskListing"
    returnvariable="getCheckTaskManagerTaskListingRet">
    <cfinvokeargument name="tmtID" value="#ARGUMENTS.tmtID#"/>
    <cfinvokeargument name="siteNo" value="#ARGUMENTS.siteNo#"/>
    <cfinvokeargument name="deptNo" value="#ARGUMENTS.deptNo#"/>
    <cfinvokeargument name="tmtlStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckTaskManagerTaskListingRet.recordcount NEQ 0>
    <cfset result.message = "The task listing already exists, please try again.">
    <cfelse>
    <cflock name="insertTaskManagerTaskListing" timeout="5">
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    INSERT INTO tbl_tm_task_listing (tmtID,siteNo,deptNo,tmtlsID) VALUES
    (
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.tmtID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.siteNo#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.deptNo#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.tmtlsID#">
    )
    </cfquery>
    </cftransaction>
    <!--- Get newly inserted task ID. --->
    <cfinvoke 
    component="MCMS.component.cms.Cms"
    method="getMaxValueSQL"
    returnvariable="tmtlID">
    <cfinvokeargument name="tableName" value="tbl_tm_task_listing"/>
    </cfinvoke>
    <cfset var.tmtlID = tmtlID>
    <!---Insert a log record.--->
    <cfinvoke 
    component="MCMS.component.app.task_manager.TaskManager"
    method="insertTaskManagerTaskListingLog">
    <cfinvokeargument name="tmtID" value="#ARGUMENTS.tmtID#"/>
    <cfinvokeargument name="tmtlID" value="#var.tmtlID#"/>
    <cfinvokeargument name="userID" value="#session.userID#"/>
    <cfinvokeargument name="tmtllLog" value="Task Manager Task Listing Create for Task #ARGUMENTS.tmtID# and Site: #ARGUMENTS.siteNo# and Dept. #ARGUMENTS.deptNo#."/>
    <cfinvokeargument name="tmtllStatus" value="1"/>
    </cfinvoke>
    <!---Handle notifcations based on User Role and status.--->
    <!---Check to see if the status or priority has changed. Don't send notifications over and over when the record is updated.--->
    <cfinvoke 
    component="MCMS.component.app.task_manager.TaskManager"
    method="setTaskManagerTaskListingNotification">
    <cfinvokeargument name="tmtlID" value="#var.tmtlID#"/>
    <cfinvokeargument name="tmtID" value="#ARGUMENTS.tmtID#"/>
    </cfinvoke>
    </cflock>
    </cfif>
    <cfcatch type="any">
    <cfset result.message = "There was an error inserting the record.">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="insertTaskManagerTaskType" access="public" returntype="struct">
    <cfargument name="tmttName" type="string" required="yes">
    <cfargument name="tmttDescription" type="string" required="yes">
    <cfargument name="tmttSort" type="numeric" required="yes">
    <cfargument name="tmttStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully inserted the record.">
    <cftry>
	<!---Check for profanity in the text.--->
    <cfinvoke 
    component="MCMS.component.utility.Regex"
    method="regexProfanity"
    returnvariable="regexProfanityRet">
    <cfinvokeargument name="profanityString" value="#ARGUMENTS.tmttDescription#"/>
    </cfinvoke>
    <!---Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.app.task_manager.TaskManager"
    method="getTaskManagerTaskType"
    returnvariable="getCheckTaskManagerTaskTypeRet">
    <cfinvokeargument name="tmttName" value="#ARGUMENTS.tmttName#"/>
    <cfinvokeargument name="tmttStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckTaskManagerTaskTypeRet.recordcount NEQ 0>
    <cfset result.message = "The name #ARGUMENTS.tmttName# already exists, please enter a new name.">
    <cfelseif regexProfanityRet CONTAINS '$%&*!'>
    <cfset result.message = "Some text contained profanity, please remove any profanity from your text.">
    <!---Check length restriction.--->
    <cfelseif LEN(ARGUMENTS.tmttDescription) GT 255>
    <cfset result.message = "The description is longer than 255 characters, please enter a new description under 255 characters.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    INSERT INTO tbl_tm_task_type (tmttName,tmttDescription,tmttSort,tmttStatus) VALUES
    (
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.tmttName#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.tmttDescription#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.tmttSort#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.tmttStatus#">
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
    
    <cffunction name="insertTaskManagerTaskSiteRel" access="public" returntype="struct">
    <cfargument name="tmtID" type="numeric" required="yes">
    <cfargument name="siteNo" type="numeric" required="yes">
    <cfargument name="tmtsrStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully inserted the record.">
    <cftry>
	<!---Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.app.task_manager.TaskManager"
    method="getTaskManagerTaskSiteRel"
    returnvariable="getTaskManagerTaskSiteRelRet">
    <cfinvokeargument name="tmtID" value="#ARGUMENTS.tmtID#"/>
    <cfinvokeargument name="siteNo" value="#ARGUMENTS.siteNo#"/>
    <cfinvokeargument name="tmtsrStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getTaskManagerTaskSiteRelRet.recordcount NEQ 0>
    <cfset result.message = "The task manager task site relationship already exists, please try again.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    INSERT INTO tbl_tm_task_site_rel (tmtID,siteNo,tmtsrStatus) VALUES
    (
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.tmtID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.siteNo#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.tmtsrStatus#">
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
    
    <cffunction name="insertTaskManagerTaskDepartmentRel" access="public" returntype="struct">
    <cfargument name="tmtID" type="numeric" required="yes">
    <cfargument name="deptNo" type="numeric" required="yes">
    <cfargument name="tmtdrStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully inserted the record.">
    <cftry>
	<!---Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.app.task_manager.TaskManager"
    method="getTaskManagerTaskDepartmentRel"
    returnvariable="getTaskManagerTaskDepartmentRelRet">
    <cfinvokeargument name="tmtID" value="#ARGUMENTS.tmtID#"/>
    <cfinvokeargument name="deptNo" value="#ARGUMENTS.deptNo#"/>
    <cfinvokeargument name="tmtdrStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getTaskManagerTaskDepartmentRelRet.recordcount NEQ 0>
    <cfset result.message = "The task manager task department relationship already exists, please try again.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    INSERT INTO tbl_tm_task_dept_rel (tmtID,deptNo,tmtdrStatus) VALUES
    (
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.tmtID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.deptNo#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.tmtdrStatus#">
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
    
    <cffunction name="insertTaskManagerTaskUserRoleRel" access="public" returntype="struct">
    <cfargument name="tmtID" type="numeric" required="yes">
    <cfargument name="urID" type="numeric" required="yes">
    <cfargument name="tmturrStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully inserted the record.">
    <cftry>
	<!---Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.app.task_manager.TaskManager"
    method="getTaskManagerTaskUserRoleRel"
    returnvariable="getTaskManagerTaskUserRoleRelRet">
    <cfinvokeargument name="tmtID" value="#ARGUMENTS.tmtID#"/>
    <cfinvokeargument name="urID" value="#ARGUMENTS.urID#"/>
    <cfinvokeargument name="tmturrStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getTaskManagerTaskUserRoleRelRet.recordcount NEQ 0>
    <cfset result.message = "The task manager task user role relationship already exists, please try again.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    INSERT INTO tbl_tm_task_user_role_rel (tmtID,urID,tmturrStatus) VALUES
    (
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.tmtID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.urID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.tmturrStatus#">
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
    
    <cffunction name="insertTaskManagerTaskDocumentRel" access="public" returntype="struct">
    <cfargument name="ID" type="numeric" required="yes">
    <cfargument name="docName" type="string" required="yes">
    <cfset result.message = "You have successfully inserted the record.">
    <cftry>
    <!---Insert Document.--->
    <cfinvoke 
    component="MCMS.component.app.document.Document" 
    method="insertDocument" 
    returnvariable="result">
    <cfinvokeargument name="docName" value="#ARGUMENTS.docName#-#DateFormat(Now(), application.dateFormat)#-#LSTimeFormat(Now(), 'hh:mm:ss')#">
    <cfinvokeargument name="docDescription" value="#ARGUMENTS.docName# for Task Manager task #ARGUMENTS.ID#."> 
    <cfinvokeargument name="docFile" value="#form.docFile#">
    <cfinvokeargument name="docDateRel" value="#DateFormat(Now(), application.dateFormat)#">
    <cfinvokeargument name="docDateExp" value="#DateFormat(DateAdd('yyyy', 1, Now()), application.dateFormat)#">
    <cfinvokeargument name="userID" value="#session.userID#">
    <cfinvokeargument name="doctID" value="#application.taskManagerDocType#">
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
    component="MCMS.component.cms.Cms"
    method="getMaxValueSQL"
    returnvariable="docID">
    <cfinvokeargument name="tableName" value="tbl_document"/>
    </cfinvoke>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    INSERT INTO tbl_tm_task_document_rel (tmtID,docID,tmtdrStatus) VALUES
    (
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#docID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="1">
    )
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error inserting the record.">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="insertTaskManagerTaskImageRel" access="public" returntype="struct">
    <cfargument name="ID" type="numeric" required="yes">
    <cfargument name="imgName" type="string" required="yes">
    <cfset result.message = "You have successfully inserted the record.">
    <cftry>
    <!---Insert Image.--->
    <cfinvoke 
    component="MCMS.component.app.image.Image" 
    method="insertImage" 
    returnvariable="result">
    <cfinvokeargument name="imgName" value="#ARGUMENTS.imgName#-#DateFormat(Now(), application.dateFormat)#-#LSTimeFormat(Now(), 'hh:mm:ss')#">
    <cfinvokeargument name="imgFile" value="#form.imgFile1#">
    <cfinvokeargument name="imgtID" value="#application.taskManagerImageType#">
    <cfinvokeargument name="netID" value="#application.networkID#">
    <cfinvokeargument name="imgStatus" value="1">
    <cfinvokeargument name="imgCountID" value="1"> 
    <cfinvokeargument name="btID" value="0">                
    </cfinvoke>
   	<cfif result.message DOES NOT CONTAIN "error">
    <!---Get latest image id.--->
    <cfinvoke 
    component="MCMS.component.cms.Cms"
    method="getMaxValueSQL"
    returnvariable="imgID">
    <cfinvokeargument name="tableName" value="tbl_image"/>
    </cfinvoke>
    <cfset var.imgID = imgID> 
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    INSERT INTO tbl_tm_task_image_rel (tmtID,imgID,tmtirStatus) VALUES
    (
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#var.imgID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="1">
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
    
    <cffunction name="insertTaskManagerTaskURLRel" access="public" returntype="struct">
    <cfargument name="tmtID" type="numeric" required="yes">
    <cfargument name="tmtuName" type="string" required="yes">
    <cfargument name="tmtuURL" type="string" required="yes">
    <cfargument name="tmturStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully inserted the record.">
    <cftry>
	<!---Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.app.task_manager.TaskManager"
    method="getTaskManagerTaskURLRel"
    returnvariable="getTaskManagerTaskURLRelRet">
    <cfinvokeargument name="tmtID" value="#ARGUMENTS.tmtID#"/>
    <cfinvokeargument name="tmtuName" value="#ARGUMENTS.tmtuName#"/>
    <cfinvokeargument name="tmturStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getTaskManagerTaskURLRelRet.recordcount NEQ 0>
    <cfset result.message = "The task manager task URL relationship already exists, please try again.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    INSERT INTO tbl_tm_task_url_rel (tmtID,tmtuName,tmtuURL,tmturStatus) VALUES
    (
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.tmtID#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.tmtuName#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.tmtuURL#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.tmturStatus#">
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
    
    <cffunction name="insertTaskManagerTaskListingLog" access="public" returntype="struct">
    <cfargument name="tmtID" type="numeric" required="yes" default="0">
    <cfargument name="tmtlID" type="numeric" required="yes" default="0">
    <cfargument name="tmtllLog" type="string" required="yes">
    <cfargument name="userID" type="numeric" required="yes" default="0">
    <cfargument name="tmtllStatus" type="numeric" required="yes" default="1">
    <cfset result.message = "You have successfully inserted the record.">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    INSERT INTO tbl_tm_task_listing_log (tmtID,tmtlID,tmtllLog,userID,tmtllStatus) VALUES
    (
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.tmtID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.tmtlID#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#TRIM(ARGUMENTS.tmtllLog)#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#session.userID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.tmtllStatus#">
    )
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error inserting the record.">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="updateTaskManagerTask" access="public" returntype="struct">
    <cfargument name="ID" type="numeric" required="yes">
    <cfargument name="tmtName" type="string" required="yes">
    <cfargument name="tmtDescription" type="string" required="yes">
    <cfargument name="tmtDateRel" type="date" required="yes">
    <cfargument name="tmtDateExp" type="date" required="yes">
    <cfargument name="tmtDateStart" type="date" required="yes" default="#DateFormat(Now(), application.dateFormat)#">
    <cfargument name="tmtDateDue" type="date" required="yes" default="#DateFormat(Now(), application.dateFormat)#">
    <cfargument name="tmtStartTimeID" type="numeric" required="yes" default="0">
    <cfargument name="tmtEndTimeID" type="numeric" required="yes" default="0">
    <cfargument name="tmttID" type="numeric" required="yes">
    <cfargument name="tmtpID" type="numeric" required="yes">
    <cfargument name="userID" type="numeric" required="yes">
    <cfargument name="tmtsID" type="numeric" required="yes" default="0">
    <cfargument name="tmtlsIDCurrent" type="numeric" required="yes" default="0">
    <cfargument name="tmtStatus" type="numeric" required="yes">
    <!---Include relationships.--->
    <cfargument name="siteNo" type="string" required="yes">
    <cfargument name="deptNo" type="string" required="yes">
    <cfargument name="urID" type="string" required="yes">
    <cfset result.message = "You have successfully updated the record.">
    <cftry>
    Check for profanity in the text.--->
    <cfinvoke 
    component="MCMS.component.utility.Regex"
    method="regexProfanity"
    returnvariable="regexProfanityRet">
    <cfinvokeargument name="profanityString" value="#ARGUMENTS.tmtDescription#"/>
    </cfinvoke>
    <!---Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.app.task_manager.TaskManager"
    method="getTaskManagerTask"
    returnvariable="getCheckTaskManagerTaskRet">
    <cfinvokeargument name="excludeID" value="#ARGUMENTS.ID#"/>
    <cfinvokeargument name="tmtName" value="#ARGUMENTS.tmtName#"/>
    <cfinvokeargument name="tmtStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckTaskManagerTaskRet.recordcount NEQ 0>
    <cfset result.message = "The name #ARGUMENTS.tmtName# already exists, please enter a new name.">
    <cfelseif regexProfanityRet CONTAINS '$%&*!'>
    <cfset result.message = "Some text contained profanity, please remove any profanity from your text.">
    <!---Check length restriction.--->
    <cfelseif LEN(ARGUMENTS.tmtDescription) GT 4000>
    <cfset result.message = "The description is longer than 4000 characters, please enter a new description under 4000 characters.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_tm_task SET
    tmtName = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.tmtName#">,
    tmtDescription = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.tmtDescription#">,
    tmtDateRel = <cfqueryparam cfsqltype="cf_sql_date" value="#ARGUMENTS.tmtDateRel#">,
    tmtDateExp = <cfqueryparam cfsqltype="cf_sql_date" value="#ARGUMENTS.tmtDateExp#">,
    tmtDateStart = <cfqueryparam cfsqltype="cf_sql_date" value="#ARGUMENTS.tmtDateStart#">,
    tmtDateDue = <cfqueryparam cfsqltype="cf_sql_date" value="#ARGUMENTS.tmtDateDue#">,
    tmtStartTimeID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.tmtStartTimeID#">,
    tmtEndTimeID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.tmtEndTimeID#">,
    tmttID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.tmttID#">,
    tmtpID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.tmtpID#">,
    tmtsID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.tmtsID#">,
    tmtStatus = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.tmtStatus#">
    WHERE ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ID#">
    </cfquery>
    </cftransaction>
    <!---First remove relationships.--->
    <cfinvoke 
    component="MCMS.component.app.task_manager.TaskManager"
    method="deleteTaskManagerTaskSiteRel">
    <cfinvokeargument name="tmtID" value="#ARGUMENTS.ID#"/>
    </cfinvoke>
    <cfinvoke 
    component="MCMS.component.app.task_manager.TaskManager"
    method="deleteTaskManagerTaskDepartmentRel">
    <cfinvokeargument name="tmtID" value="#ARGUMENTS.ID#"/>
    </cfinvoke>
    <cfinvoke 
    component="MCMS.component.app.task_manager.TaskManager"
    method="deleteTaskManagerTaskUserRoleRel">
    <cfinvokeargument name="tmtID" value="#ARGUMENTS.ID#"/>
    </cfinvoke>
    <!---Create site relationships.--->
    <cfloop index="siteNoTask" list="#ARGUMENTS.siteNo#">
    <cfinvoke 
    component="MCMS.component.app.task_manager.TaskManager"
    method="insertTaskManagerTaskSiteRel">
    <cfinvokeargument name="tmtID" value="#ARGUMENTS.ID#"/>
    <cfinvokeargument name="siteNo" value="#siteNoTask#"/>
    <cfinvokeargument name="tmtsrStatus" value="1"/>
    </cfinvoke>
    </cfloop>
    <!---Create department relationships.--->
    <cfloop index="deptNoTask" list="#ARGUMENTS.deptNo#">
    <cfinvoke 
    component="MCMS.component.app.task_manager.TaskManager"
    method="insertTaskManagerTaskDepartmentRel">
    <cfinvokeargument name="tmtID" value="#ARGUMENTS.ID#"/>
    <cfinvokeargument name="deptNo" value="#deptNoTask#"/>
    <cfinvokeargument name="tmtdrStatus" value="1"/>
    </cfinvoke>
    </cfloop>
    <!---Create user role relationships.--->
    <cfloop index="urID" list="#ARGUMENTS.urID#">
    <cfinvoke 
    component="MCMS.component.app.task_manager.TaskManager"
    method="insertTaskManagerTaskUserRoleRel">
    <cfinvokeargument name="tmtID" value="#ARGUMENTS.ID#"/>
    <cfinvokeargument name="urID" value="#urID#"/>
    <cfinvokeargument name="tmturrStatus" value="1"/>
    </cfinvoke>
    </cfloop>
    
    <!---Create task listings only when the status is 'Pending'.--->
    <cfif ARGUMENTS.tmtsID LTE 2>
    <!---Remove any existing listings first.--->
    <cfinvoke 
    component="MCMS.component.app.task_manager.TaskManager"
    method="deleteTaskManagerTaskListing">
    <cfinvokeargument name="tmtID" value="#ARGUMENTS.ID#"/>
    </cfinvoke>
    <cfloop index="siteNoListing" list="#ARGUMENTS.siteNo#">
    <cfloop index="deptNoListing" list="#ARGUMENTS.deptNo#">
    <!---Check record status.--->
    <cfinvoke 
    component="MCMS.component.app.task_manager.TaskManager"
    method="insertTaskManagerTaskListing">
    <cfinvokeargument name="tmtID" value="#ARGUMENTS.ID#"/>
    <cfinvokeargument name="siteNo" value="#siteNoListing#"/>
    <cfinvokeargument name="deptNo" value="#deptNoListing#"/>
    <cfinvokeargument name="tmtlsID" value="#ARGUMENTS.tmtsID#"/>
    </cfinvoke>
    </cfloop>
    </cfloop>
    </cfif>
    <!---Update task listings.--->
    <cfif ARGUMENTS.tmtsID NEQ ARGUMENTS.tmtlsIDCurrent>
    <cfinvoke 
    component="MCMS.component.app.task_manager.TaskManager"
    method="updateTaskManagerTaskListingStatusFromTask">
    <cfinvokeargument name="tmtID" value="#ARGUMENTS.ID#"/>
    <cfinvokeargument name="tmtlsID" value="#ARGUMENTS.tmtsID#"/>
    </cfinvoke>
    <cfinvoke 
    component="MCMS.component.app.task_manager.TaskManager"
    method="setTaskManagerTaskNotification">
    <cfinvokeargument name="tmtID" value="#ARGUMENTS.ID#"/>
    <cfinvokeargument name="deptNo" value="#ARGUMENTS.deptNo#"/>
    </cfinvoke>
    </cfif>
    </cfif>
    <cfcatch type="any">
    <cfset result.message = "There was an error updating the record.">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="updateTaskManagerTaskType" access="public" returntype="struct">
    <cfargument name="ID" type="numeric" required="yes">
    <cfargument name="tmttName" type="string" required="yes">
    <cfargument name="tmttDescription" type="string" required="yes">
    <cfargument name="tmttSort" type="numeric" required="yes">
    <cfargument name="tmttStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully updated the record.">
    <cftry>
    <!---Check for profanity in the text.--->
    <cfinvoke 
    component="MCMS.component.utility.Regex"
    method="regexProfanity"
    returnvariable="regexProfanityRet">
    <cfinvokeargument name="profanityString" value="#ARGUMENTS.tmttDescription#"/>
    </cfinvoke>
    <!---Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.app.task_manager.TaskManager"
    method="getTaskManagerTaskType"
    returnvariable="getCheckTaskManagerTaskTypeRet">
    <cfinvokeargument name="excludeID" value="#ARGUMENTS.ID#"/>
    <cfinvokeargument name="tmttName" value="#ARGUMENTS.tmttName#"/>
    <cfinvokeargument name="tmttStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckTaskManagerTaskTypeRet.recordcount NEQ 0>
    <cfset result.message = "The name #ARGUMENTS.tmttName# already exists, please enter a new name.">
    <cfelseif regexProfanityRet CONTAINS '$%&*!'>
    <cfset result.message = "Some text contained profanity, please remove any profanity from your text.">
    <!---Check length restriction.--->
    <cfelseif LEN(ARGUMENTS.tmttDescription) GT 255>
    <cfset result.message = "The description is longer than 255 characters, please enter a new description under 255 characters.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_tm_task_type SET
    tmttName = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.tmttName#">,
    tmttDescription = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.tmttDescription#">,
	tmttSort = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.tmttSort#">,
    tmttStatus = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.tmttStatus#">
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
    
    <cffunction name="updateTaskManagerTaskListing" access="public" returntype="struct">
    <cfargument name="ID" type="numeric" required="yes">
    <cfargument name="tmtID" type="numeric" required="yes">
    <cfargument name="tmtlApprovalUserID" type="numeric" required="yes" default="0">
    <cfargument name="tmtllLog" type="string" required="yes">
    <cfargument name="tmtlsID" type="numeric" required="yes">
    <cfargument name="tmtlsIDCurrent" type="numeric" required="yes">
    <cfset result.message = "You have successfully updated the records.">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_tm_task_listing SET
    <cfif ARGUMENTS.tmtlsID LTE 5>
    tmtlDateUpdate = <cfqueryparam cfsqltype="cf_sql_date" value="#Now()#">,
    </cfif>
    tmtlApprovalUserID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.tmtlApprovalUserID#">,
    tmtlsID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.tmtlsID#">
    WHERE ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ID#">
    </cfquery>
    </cftransaction>
    <!---Insert a log record.--->
    <cfif ARGUMENTS.tmtllLog NEQ ''>
    <cfinvoke 
    component="MCMS.component.app.task_manager.TaskManager"
    method="insertTaskManagerTaskListingLog">
    <cfinvokeargument name="tmtID" value="#ARGUMENTS.tmtID#"/>
    <cfinvokeargument name="tmtlID" value="#ARGUMENTS.ID#"/>
    <cfinvokeargument name="userID" value="#session.userID#"/>
    <cfinvokeargument name="tmtllLog" value="#ARGUMENTS.tmtllLog#"/>
    <cfinvokeargument name="tmtllStatus" value="1"/>
    </cfinvoke>
    <cfinvoke 
    component="MCMS.component.app.task_manager.TaskManager"
    method="setTaskManagerTaskListingNotification">
    <cfinvokeargument name="tmtlID" value="#ARGUMENTS.ID#"/>
    <cfinvokeargument name="tmtID" value="#ARGUMENTS.tmtID#"/>
    <cfinvokeargument name="byPass" value="log"/>
    </cfinvoke>
    </cfif>
    <!---Handle notifcations based on User Role and status.--->
    <!---Check to see if the status or priority has changed. Don't send notifications over and over when the record is updated.--->
    <cfif ARGUMENTS.tmtlsIDCurrent NEQ ARGUMENTS.tmtlsID>
    <cfinvoke 
    component="MCMS.component.app.task_manager.TaskManager"
    method="setTaskManagerTaskListingNotification">
    <cfinvokeargument name="tmtlID" value="#ARGUMENTS.ID#"/>
    <cfinvokeargument name="tmtID" value="#ARGUMENTS.tmtID#"/>
    </cfinvoke>
    </cfif>
    <cfcatch type="any">
    <cfset result.message = "There was an error updating the records.">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="updateTaskManagerTaskListingStatusFromTask" access="public" returntype="struct">
    <cfargument name="tmtID" type="numeric" required="yes">
    <cfargument name="tmtlsID" type="numeric" required="yes">
    <cfset result.message = "You have successfully updated the records.">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_tm_task_listing SET
    tmtlsID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.tmtlsID#">
    WHERE tmtID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ID#">
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error updating the records.">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="updateTaskManagerTaskList" access="public" returntype="struct">
    <cfargument name="ID" type="numeric" required="yes">
    <cfargument name="tmtStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully updated the records.">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_tm_task SET
    tmtStatus = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.tmtStatus#">
    WHERE ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ID#">
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error updating the records.">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="updateTaskManagerTaskTypeList" access="public" returntype="struct">
    <cfargument name="ID" type="numeric" required="yes">
    <cfargument name="tmttStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully updated the records.">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_tm_task_type SET
    tmttStatus = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.tmttStatus#">
    WHERE ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ID#">
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error updating the records.">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="updateTaskManagerTaskListingList" access="public" returntype="struct">
    <cfargument name="ID" type="numeric" required="yes">
    <cfargument name="tmtlStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully updated the records.">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_tm_task_listing SET
    tmtlStatus = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.tmtlStatus#">
    WHERE ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ID#">
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error updating the records.">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="deleteTaskManagerTask" access="public" returntype="struct">
    <cfargument name="ID" type="string" required="yes">
    <cfset result.message = "You have successfully deleted the record(s).">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    DELETE FROM tbl_tm_task
    WHERE ID IN (<cfqueryparam cfsqltype="cf_sql_integer" list="yes" value="#ARGUMENTS.ID#">)
    </cfquery>
    </cftransaction>
    <cfinvoke 
    component="MCMS.component.app.task_manager.TaskManager"
    method="deleteTaskManagerTaskSiteRel">
    <cfinvokeargument name="tmtID" value="#ARGUMENTS.ID#"/>
    </cfinvoke>
    <cfinvoke 
    component="MCMS.component.app.task_manager.TaskManager"
    method="deleteTaskManagerTaskDepartmentRel">
    <cfinvokeargument name="tmtID" value="#ARGUMENTS.ID#"/>
    </cfinvoke>
    <cfinvoke 
    component="MCMS.component.app.task_manager.TaskManager"
    method="deleteTaskManagerTaskUserRoleRel">
    <cfinvokeargument name="tmtID" value="#ARGUMENTS.ID#"/>
    </cfinvoke>
    <cfinvoke 
    component="MCMS.component.app.task_manager.TaskManager"
    method="deleteTaskManagerTaskDocumentRel">
    <cfinvokeargument name="tmtID" value="#ARGUMENTS.ID#"/>
    </cfinvoke>
    <cfinvoke 
    component="MCMS.component.app.task_manager.TaskManager"
    method="deleteTaskManagerTaskImageRel">
    <cfinvokeargument name="tmtID" value="#ARGUMENTS.ID#"/>
    </cfinvoke>
    <cfinvoke 
    component="MCMS.component.app.task_manager.TaskManager"
    method="deleteTaskManagerTaskURLRel">
    <cfinvokeargument name="tmtID" value="#ARGUMENTS.ID#"/>
    </cfinvoke>
    <cfinvoke 
    component="MCMS.component.app.task_manager.TaskManager"
    method="deleteTaskManagerTaskListing">
    <cfinvokeargument name="tmtID" value="#ARGUMENTS.ID#"/>
    </cfinvoke>
    <cfcatch type="any">
    <cfset result.message = "There was an error deleting the record(s).">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction> 
    
    <cffunction name="deleteTaskManagerTaskListing" access="public" returntype="struct">
    <cfargument name="ID" type="string" required="yes" default="0">
    <cfargument name="tmtID" type="string" required="yes" default="0">
    <cfset result.message = "You have successfully deleted the record(s).">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    DELETE FROM tbl_tm_task_listing
    WHERE 0=0
    AND (ID IN (<cfqueryparam cfsqltype="cf_sql_integer" list="yes" value="#ARGUMENTS.ID#">) OR 
    tmtID IN (<cfqueryparam cfsqltype="cf_sql_integer" list="yes" value="#ARGUMENTS.tmtID#">))
    </cfquery>
    </cftransaction>
    <cfinvoke 
    component="MCMS.component.app.task_manager.TaskManager"
    method="deleteTaskManagerTaskListingLog">
    <cfinvokeargument name="tmtID" value="#ARGUMENTS.tmtID#"/>
    </cfinvoke>
    <cfcatch type="any">
    <cfset result.message = "There was an error deleting the record(s).">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="deleteTaskManagerTaskType" access="public" returntype="struct">
    <cfargument name="ID" type="string" required="yes" default="0">
    <cfset result.message = "You have successfully deleted the record(s).">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    DELETE FROM tbl_tm_task_type
    WHERE 0=0
    AND ID IN (<cfqueryparam cfsqltype="cf_sql_integer" list="yes" value="#ARGUMENTS.ID#">)
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error deleting the record(s).">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="deleteTaskManagerTaskSiteRel" access="public" returntype="struct">
    <cfargument name="ID" type="string" required="yes" default="0">
    <cfargument name="tmtID" type="string" required="yes" default="0">
    <cfset result.message = "You have successfully deleted the record(s).">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    DELETE FROM tbl_tm_task_site_rel
    WHERE 0=0
    AND (ID IN (<cfqueryparam cfsqltype="cf_sql_integer" list="yes" value="#ARGUMENTS.ID#">) OR 
    tmtID IN (<cfqueryparam cfsqltype="cf_sql_integer" list="yes" value="#ARGUMENTS.tmtID#">))
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error deleting the record(s).">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="deleteTaskManagerTaskDepartmentRel" access="public" returntype="struct">
    <cfargument name="ID" type="string" required="yes" default="0">
    <cfargument name="tmtID" type="string" required="yes" default="0">
    <cfset result.message = "You have successfully deleted the record(s).">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    DELETE FROM tbl_tm_task_dept_rel
    WHERE 0=0
    AND (ID IN (<cfqueryparam cfsqltype="cf_sql_integer" list="yes" value="#ARGUMENTS.ID#">) OR 
    tmtID IN (<cfqueryparam cfsqltype="cf_sql_integer" list="yes" value="#ARGUMENTS.tmtID#">))
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error deleting the record(s).">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="deleteTaskManagerTaskUserRoleRel" access="public" returntype="struct">
    <cfargument name="ID" type="string" required="yes" default="0">
    <cfargument name="tmtID" type="string" required="yes" default="0">
    <cfset result.message = "You have successfully deleted the record(s).">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    DELETE FROM tbl_tm_task_user_role_rel
    WHERE 0=0
    AND (ID IN (<cfqueryparam cfsqltype="cf_sql_integer" list="yes" value="#ARGUMENTS.ID#">) OR 
    tmtID IN (<cfqueryparam cfsqltype="cf_sql_integer" list="yes" value="#ARGUMENTS.tmtID#">))
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error deleting the record(s).">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="deleteTaskManagerTaskDocumentRel" access="public" returntype="struct">
    <cfargument name="ID" type="string" required="yes" default="0">
    <cfargument name="tmtID" type="string" required="yes" default="0">
    <cfset result.message = "You have successfully deleted the record(s).">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    DELETE FROM tbl_tm_task_document_rel
    WHERE 0=0
    AND (ID IN (<cfqueryparam cfsqltype="cf_sql_integer" list="yes" value="#ARGUMENTS.ID#">) OR 
    tmtID IN (<cfqueryparam cfsqltype="cf_sql_integer" list="yes" value="#ARGUMENTS.tmtID#">))
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error deleting the record(s).">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction> 
    
    <cffunction name="deleteTaskManagerTaskImageRel" access="public" returntype="struct">
    <cfargument name="ID" type="string" required="yes" default="0">
    <cfargument name="tmtID" type="string" required="yes" default="0">
    <cfset result.message = "You have successfully deleted the record(s).">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    DELETE FROM tbl_tm_task_image_rel
    WHERE 0=0
    AND (ID IN (<cfqueryparam cfsqltype="cf_sql_integer" list="yes" value="#ARGUMENTS.ID#">) OR 
    tmtID IN (<cfqueryparam cfsqltype="cf_sql_integer" list="yes" value="#ARGUMENTS.tmtID#">))
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error deleting the record(s).">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="deleteTaskManagerTaskURLRel" access="public" returntype="struct">
    <cfargument name="ID" type="string" required="yes" default="0">
    <cfargument name="tmtID" type="string" required="yes" default="0">
    <cfset result.message = "You have successfully deleted the record(s).">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    DELETE FROM tbl_tm_task_url_rel
    WHERE 0=0
    AND (ID IN (<cfqueryparam cfsqltype="cf_sql_integer" list="yes" value="#ARGUMENTS.ID#">) OR 
    tmtID IN (<cfqueryparam cfsqltype="cf_sql_integer" list="yes" value="#ARGUMENTS.tmtID#">))
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error deleting the record(s).">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction> 
</cfcomponent>