<cfcomponent>
    <cffunction name="getQuiz" access="public" returntype="query" hint="Get Quiz data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="dateRange" type="string" required="yes" default="false">
    <cfargument name="qDateRel" type="string" required="yes" default="">
    <cfargument name="qDateExp" type="string" required="yes" default="">
    <cfargument name="ID" type="numeric" required="yes" default="0">
    <cfargument name="excludeID" type="numeric" required="yes" default="0">
    <cfargument name="qName" type="string" required="yes" default="">
    <cfargument name="qtID" type="string" required="yes" default="0">
    <cfargument name="qStatus" type="string" required="yes" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="qName">
    <cfset var rsQuiz = "" >
    <cftry>
    <cfquery name="rsQuiz" datasource="#application.mcmsDSN#">
    SELECT * FROM v_quiz WHERE 0=0
    <cfif ARGUMENTS.ID NEQ 0>
    AND ID = <cfqueryparam value="#ARGUMENTS.ID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.excludeID NEQ 0>
    AND ID <> <cfqueryparam value="#ARGUMENTS.excludeID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(qName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(qDescription) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">)
    </cfif>
    <!---Date Range.--->
    <cfif ARGUMENTS.dateRange EQ "true">
    <cfif ARGUMENTS.qDateRel NEQ "">
    AND qDateRel >= <cfqueryparam value="#ARGUMENTS.qDateRel#" cfsqltype="cf_sql_date">
    </cfif>
    <cfif ARGUMENTS.qDateExp NEQ "">
    AND qDateExp <= <cfqueryparam value="#ARGUMENTS.qDateExp#" cfsqltype="cf_sql_date">
	</cfif>
    <cfelse>
    <cfif ARGUMENTS.qDateRel NEQ "">
    AND qDateRel <= <cfqueryparam value="#ARGUMENTS.qDateRel#" cfsqltype="cf_sql_date">
    </cfif>
    <cfif ARGUMENTS.qDateExp NEQ "">
    AND qDateExp >= <cfqueryparam value="#ARGUMENTS.qDateExp#" cfsqltype="cf_sql_date">
	</cfif>
    </cfif>
    <cfif ARGUMENTS.qName NEQ "">
    AND UPPER(qName) = <cfqueryparam value="#UCASE(ARGUMENTS.qName)#" cfsqltype="cf_sql_varchar">
    </cfif>
    <cfif ARGUMENTS.qtID NEQ 0>
    AND qtID = <cfqueryparam value="#ARGUMENTS.qtID#" cfsqltype="cf_sql_integer">
    </cfif>
    AND qStatus IN (<cfqueryparam value="#ARGUMENTS.qStatus#" list="yes" cfsqltype="cf_sql_integer">)
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsQuiz = StructNew()>
    <cfset rsQuiz.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsQuiz>
    </cffunction>
    
    <cffunction name="getQuizQuestion" access="public" returntype="query" hint="Get Quiz Question data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="ID" type="numeric" required="yes" default="0">
    <cfargument name="qID" type="numeric" required="yes" default="0">
    <cfargument name="excludeID" type="numeric" required="yes" default="0">
    <cfargument name="qqQuestion" type="string" required="yes" default="">
    <cfargument name="qqtID" type="string" required="yes" default="0">
    <cfargument name="qqStatus" type="string" required="yes" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="qqQuestion">
    <cfset var rsQuizQuestion = "" >
    <cftry>
    <cfquery name="rsQuizQuestion" datasource="#application.mcmsDSN#">
    SELECT * FROM v_quiz_question WHERE 0=0
    <cfif ARGUMENTS.ID NEQ 0>
    AND ID = <cfqueryparam value="#ARGUMENTS.ID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.qID NEQ 0>
    AND qID = <cfqueryparam value="#ARGUMENTS.qID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.excludeID NEQ 0>
    AND ID <> <cfqueryparam value="#ARGUMENTS.excludeID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(qqQuestion) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(qName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">)
    </cfif>
    <cfif ARGUMENTS.qqQuestion NEQ "">
    AND UPPER(qqQuestion) = <cfqueryparam value="#UCASE(ARGUMENTS.qqQuestion)#" cfsqltype="cf_sql_varchar">
    </cfif>
    <cfif ARGUMENTS.qqtID NEQ 0>
    AND qqtID IN (<cfqueryparam value="#ARGUMENTS.qqtID#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    AND qqStatus IN (<cfqueryparam value="#ARGUMENTS.qqStatus#" list="yes" cfsqltype="cf_sql_integer">)
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsQuizQuestion = StructNew()>
    <cfset rsQuizQuestion.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsQuizQuestion>
    </cffunction>
    
    <cffunction name="getQuizQuestionOption" access="public" returntype="query" hint="Get Quiz Question Option data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="ID" type="numeric" required="yes" default="0">
    <cfargument name="qqID" type="numeric" required="yes" default="0">
    <cfargument name="excludeID" type="numeric" required="yes" default="0">
    <cfargument name="qqoOption" type="string" required="yes" default="">
    <cfargument name="qqoAnswer" type="numeric" required="yes" default="0">
    <cfargument name="qqoStatus" type="string" required="yes" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="qqoOption">
    <cfset var rsQuizQuestionOption = "" >
    <cftry>
    <cfquery name="rsQuizQuestionOption" datasource="#application.mcmsDSN#">
    SELECT * FROM v_quiz_question_option WHERE 0=0
    <cfif ARGUMENTS.ID NEQ 0>
    AND ID = <cfqueryparam value="#ARGUMENTS.ID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.qqID NEQ 0>
    AND qqID = <cfqueryparam value="#ARGUMENTS.qqID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.excludeID NEQ 0>
    AND ID <> <cfqueryparam value="#ARGUMENTS.excludeID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(qqoOption) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(qqQuestion) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">)
    </cfif>
    <cfif ARGUMENTS.qqoOption NEQ "">
    AND UPPER(qqoOption) = <cfqueryparam value="#UCASE(ARGUMENTS.qqoOption)#" cfsqltype="cf_sql_varchar">
    </cfif>
    <cfif ARGUMENTS.qqoAnswer NEQ 0>
    AND qqoAnswer = <cfqueryparam value="#ARGUMENTS.qqoAnswer#" cfsqltype="cf_sql_integer">
    </cfif>
    AND qqoStatus IN (<cfqueryparam value="#ARGUMENTS.qqoStatus#" list="yes" cfsqltype="cf_sql_integer">)
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsQuizQuestionOption = StructNew()>
    <cfset rsQuizQuestionOption.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsQuizQuestionOption>
    </cffunction>
    
    <cffunction name="getQuizSiteRel" access="public" returntype="query" hint="Get Quiz Site Relationship data.">
    <cfargument name="keywords" type="string" required="no" default="All">
    <cfargument name="ID" type="numeric" required="yes" default="0">
    <cfargument name="excludeID" type="numeric" required="yes" default="0">
    <cfargument name="qID" type="string" required="yes" default="0">
    <cfargument name="siteNo" type="string" required="yes" default="100">
    <cfargument name="siteStatus" type="string" required="no" default="1">
    <cfargument name="qsrStatus" type="string" required="yes" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="siteNo">
    <cfset var rsQuizSiteRel = "" >
    <cftry>
    <cfquery name="rsQuizSiteRel" datasource="#application.mcmsDSN#">
    SELECT * FROM v_quiz_site_rel WHERE 0=0
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND siteNo LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> 
    </cfif>
    <cfif ARGUMENTS.ID NEQ 0>
    AND ID = <cfqueryparam value="#ARGUMENTS.ID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.excludeID NEQ 0>
    AND ID <> <cfqueryparam value="#ARGUMENTS.excludeID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.qID NEQ 0>
    AND qID IN (<cfqueryparam value="#ARGUMENTS.qID#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    <cfif ARGUMENTS.siteNo NEQ 100>
    AND siteNo IN (<cfqueryparam value="#ARGUMENTS.siteNo#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    AND (siteStatus IN (<cfqueryparam value="#ARGUMENTS.siteStatus#" list="yes" cfsqltype="cf_sql_integer">) OR siteStatus IS NULL)
    AND qsrStatus IN (<cfqueryparam value="#ARGUMENTS.qsrStatus#" list="yes" cfsqltype="cf_sql_integer">)
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsQuizSiteRel = StructNew()>
    <cfset rsQuizSiteRel.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsQuizSiteRel>
    </cffunction>
    
    <cffunction name="getQuizDepartmentRel" access="public" returntype="query" hint="Get Quiz Department Relationship data.">
    <cfargument name="keywords" type="string" required="no" default="All">
    <cfargument name="ID" type="numeric" required="yes" default="0">
    <cfargument name="excludeID" type="numeric" required="yes" default="0">
    <cfargument name="qID" type="string" required="yes" default="0">
    <cfargument name="qDateRel" type="string" required="yes" default="">
    <cfargument name="qDateExp" type="string" required="yes" default="">
    <cfargument name="deptNo" type="string" required="yes" default="0">
    <cfargument name="deptStatus" type="string" required="no" default="1">
    <cfargument name="qStatus" type="string" required="yes" default="1,3">
    <cfargument name="qdrStatus" type="string" required="yes" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="deptNo">
	<cfset var rsQuizDepartmentRel = "" >
    <cftry>
    <cfquery name="rsQuizDepartmentRel" datasource="#application.mcmsDSN#">
    SELECT * FROM v_quiz_department_rel WHERE 0=0
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND deptNo LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> 
    </cfif>
    <cfif ARGUMENTS.ID NEQ 0>
    AND ID = <cfqueryparam value="#ARGUMENTS.ID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.excludeID NEQ 0>
    AND ID <> <cfqueryparam value="#ARGUMENTS.excludeID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.qID NEQ 0>
    AND qID IN (<cfqueryparam value="#ARGUMENTS.qID#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    <cfif ARGUMENTS.qDateRel NEQ "">
    AND qDateRel <= <cfqueryparam value="#ARGUMENTS.qDateRel#" cfsqltype="cf_sql_date">
    </cfif>
    <cfif ARGUMENTS.qDateExp NEQ "">
    AND qDateExp >= <cfqueryparam value="#ARGUMENTS.qDateExp#" cfsqltype="cf_sql_date">
	</cfif>
    <cfif ARGUMENTS.deptNo NEQ 0>
    AND deptNo IN (<cfqueryparam value="#ARGUMENTS.deptNo#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    AND (deptStatus IN (<cfqueryparam value="#ARGUMENTS.deptStatus#" list="yes" cfsqltype="cf_sql_integer">) OR deptStatus IS NULL)
    AND qStatus IN (<cfqueryparam value="#ARGUMENTS.qStatus#" list="yes" cfsqltype="cf_sql_integer">)
    AND qdrStatus IN (<cfqueryparam value="#ARGUMENTS.qdrStatus#" list="yes" cfsqltype="cf_sql_integer">)
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsQuizDepartmentRel = StructNew()>
    <cfset rsQuizDepartmentRel.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsQuizDepartmentRel>
    </cffunction>
    
    <cffunction name="getQuizUserRoleNotificationRel" access="public" returntype="query" hint="Get Quiz User Role Notification Rel. data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="ID" type="numeric" required="yes" default="0">
    <cfargument name="excludeID" type="numeric" required="yes" default="0">
    <cfargument name="qID" type="numeric" required="yes" default="0">
    <cfargument name="urID" type="numeric" required="yes" default="0">
    <cfargument name="qurnrStatus" type="string" required="yes" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="urName">
    <cfset var rsQuizUserRoleNotificationRel = "" >
    <cftry>
    <cfquery name="rsQuizUserRoleNotificationRel" datasource="#application.mcmsDSN#">
    SELECT * FROM v_quiz_ur_notification_rel WHERE 0=0
    <cfif ARGUMENTS.ID NEQ 0>
    AND ID = <cfqueryparam value="#ARGUMENTS.ID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.excludeID NEQ 0>
    AND ID <> <cfqueryparam value="#ARGUMENTS.excludeID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND UPPER(urName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">
    </cfif>
    <cfif ARGUMENTS.qID NEQ 0>
    AND qID = <cfqueryparam value="#ARGUMENTS.qID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.urID NEQ 0>
    AND urID = <cfqueryparam value="#ARGUMENTS.urID#" cfsqltype="cf_sql_integer">
    </cfif>
    AND qurnrStatus IN (<cfqueryparam value="#ARGUMENTS.qurnrStatus#" list="yes" cfsqltype="cf_sql_integer">)
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsQuizUserRoleNotificationRel = StructNew()>
    <cfset rsQuizUserRoleNotificationRel.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsQuizUserRoleNotificationRel>
    </cffunction>
    
    <cffunction name="getQuizResult" access="public" returntype="query" hint="Get Quiz Result data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="ID" type="numeric" required="yes" default="0">
    <cfargument name="excludeID" type="numeric" required="yes" default="0">
    <cfargument name="qrName" type="string" required="yes" default="">
    <cfargument name="userID" type="string" required="yes" default="0">
    <cfargument name="qrStatus" type="string" required="yes" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="qrName">
    <cfset var rsQuizResult = "" >
    <cftry>
    <cfquery name="rsQuizResult" datasource="#application.mcmsDSN#">
    SELECT * FROM v_quiz_result WHERE 0=0
    <cfif ARGUMENTS.ID NEQ 0>
    AND ID = <cfqueryparam value="#ARGUMENTS.ID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.excludeID NEQ 0>
    AND ID <> <cfqueryparam value="#ARGUMENTS.excludeID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND UPPER(qrName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">
    </cfif>
    <cfif ARGUMENTS.qrName NEQ "">
    AND UPPER(qrName) = <cfqueryparam value="#UCASE(ARGUMENTS.qrName)#" cfsqltype="cf_sql_varchar">
    </cfif>
    <cfif ARGUMENTS.userID NEQ 0>
    AND userID = <cfqueryparam value="#ARGUMENTS.userID#" cfsqltype="cf_sql_integer">
    </cfif>
    AND qrStatus IN (<cfqueryparam value="#ARGUMENTS.qrStatus#" list="yes" cfsqltype="cf_sql_integer">)
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsQuizResult = StructNew()>
    <cfset rsQuizResult.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsQuizResult>
    </cffunction>
    
    <cffunction name="getQuizAnswer" access="public" returntype="query" hint="Get Quiz Answer data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="ID" type="numeric" required="yes" default="0">
    <cfargument name="excludeID" type="numeric" required="yes" default="0">
    <cfargument name="qID" type="numeric" required="yes" default="0">
    <cfargument name="qrID" type="numeric" required="yes" default="0">
    <cfargument name="qqID" type="numeric" required="yes" default="0">
    <cfargument name="qaDateStart" type="string" required="yes" default="">
    <cfargument name="qaDateEnd" type="string" required="yes" default="">
    <cfargument name="siteNo" type="numeric" required="yes" default="100">
    <cfargument name="deptNo" type="numeric" required="yes" default="0">
    <cfargument name="qaStatus" type="string" required="yes" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="qqQuestion">
    <cfset var rsQuizAnswer = "" >
    <cftry>
    <cfquery name="rsQuizAnswer" datasource="#application.mcmsDSN#">
    SELECT * FROM v_quiz_answer WHERE 0=0
    <cfif ARGUMENTS.ID NEQ 0>
    AND ID = <cfqueryparam value="#ARGUMENTS.ID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.excludeID NEQ 0>
    AND ID <> <cfqueryparam value="#ARGUMENTS.excludeID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(qrName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(qrEmail) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(siteName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">)
    </cfif>
    <cfif ARGUMENTS.qID NEQ 0>
    AND qID = <cfqueryparam value="#ARGUMENTS.qID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.qrID NEQ 0>
    AND qrID = <cfqueryparam value="#ARGUMENTS.qrID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.qqID NEQ 0>
    AND qqID = <cfqueryparam value="#ARGUMENTS.qqID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.qaDateStart NEQ "">
    AND qaDate >= <cfqueryparam value="#ARGUMENTS.qaDateStart#" cfsqltype="cf_sql_date">
    </cfif>
    <cfif ARGUMENTS.qaDateEnd NEQ "">
    AND qaDate <= <cfqueryparam value="#ARGUMENTS.qaDateEnd#" cfsqltype="cf_sql_date">
	</cfif>
    <cfif ARGUMENTS.siteNo NEQ 100>
    AND siteNo = <cfqueryparam value="#ARGUMENTS.siteNo#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.deptNo NEQ 0>
    AND deptNo = <cfqueryparam value="#ARGUMENTS.deptNo#" cfsqltype="cf_sql_integer">
    </cfif>
    AND qaStatus IN (<cfqueryparam value="#ARGUMENTS.qaStatus#" list="yes" cfsqltype="cf_sql_integer">)
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsQuizAnswer = StructNew()>
    <cfset rsQuizAnswer.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsQuizAnswer>
    </cffunction>
    
    <cffunction name="getQuizType" access="public" returntype="query" hint="Get Quiz Type data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="ID" type="numeric" required="yes" default="0">
    <cfargument name="excludeID" type="numeric" required="yes" default="0">
    <cfargument name="qtStatus" type="string" required="yes" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="qtName">
    <cfset var rsQuizType = "" >
    <cftry>
    <cfquery name="rsQuizType" datasource="#application.mcmsDSN#">
    SELECT * FROM tbl_quiz_type WHERE 0=0
    <cfif ARGUMENTS.ID NEQ 0>
    AND ID = <cfqueryparam value="#ARGUMENTS.ID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.excludeID NEQ 0>
    AND ID <> <cfqueryparam value="#ARGUMENTS.excludeID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND UPPER(qtName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">
    </cfif>
    AND qtStatus IN (<cfqueryparam value="#ARGUMENTS.qtStatus#" list="yes" cfsqltype="cf_sql_integer">)
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsQuizType = StructNew()>
    <cfset rsQuizType.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsQuizType>
    </cffunction>
    
    <cffunction name="getQuizQuestionType" access="public" returntype="query" hint="Get Quiz Question Type data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="ID" type="numeric" required="yes" default="0">
    <cfargument name="excludeID" type="numeric" required="yes" default="0">
    <cfargument name="qqtStatus" type="string" required="yes" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="qqtName">
    <cfset var rsQuizQuestionType = "" >
    <cftry>
    <cfquery name="rsQuizQuestionType" datasource="#application.mcmsDSN#">
    SELECT * FROM tbl_quiz_question_type WHERE 0=0
    <cfif ARGUMENTS.ID NEQ 0>
    AND ID = <cfqueryparam value="#ARGUMENTS.ID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.excludeID NEQ 0>
    AND ID <> <cfqueryparam value="#ARGUMENTS.excludeID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND UPPER(qqtName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">
    </cfif>
    AND qqtStatus IN (<cfqueryparam value="#ARGUMENTS.qqtStatus#" list="yes" cfsqltype="cf_sql_integer">)
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsQuizQuestionType = StructNew()>
    <cfset rsQuizQuestionType.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsQuizQuestionType>
    </cffunction>
    
    <cffunction name="getQuizReport" access="public" returntype="query" hint="Get Quiz Report data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="args" type="string" required="yes" default="0">
    <cfargument name="orderBy" type="string" required="yes" default="qName">
    <cfset var rsQuizReport = "" >
    <cftry>
    <cfquery name="rsQuizReport" datasource="#application.mcmsDSN#">
    SELECT qName As Name, qDescription As Description, qPassingScore As Passing_Score, qTimeLimit As Time_Limit, TO_CHAR(qDateRel,'MM/DD/YYYY') As Release_Date, TO_CHAR(qDateExp,'MM/DD/YYYY') As Expiration_Date, qtName As Type, sName As Status FROM v_quiz WHERE 0=0
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(qName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(qDescription) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">)
    </cfif>
    <cfif ARGUMENTS.args NEQ 0>
    <cfif ListGetAt(ARGUMENTS.args, 1) NEQ 0>
    AND qDateRel >= <cfqueryparam value="#ListGetAt(ARGUMENTS.args, 1)#" list="yes" cfsqltype="cf_sql_date">
    </cfif>
    <cfif ListGetAt(ARGUMENTS.args, 2) NEQ 0>
    AND qDateExp <= <cfqueryparam value="#ListGetAt(ARGUMENTS.args, 2)#" list="yes" cfsqltype="cf_sql_date">
    </cfif>
    </cfif>
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsQuizReport = StructNew()>
    <cfset rsQuizReport.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsQuizReport>
    </cffunction>
    
    <cffunction name="getQuizQuestionReport" access="public" returntype="query" hint="Get Quiz Question Report data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="orderBy" type="string" required="yes" default="qqQuestion">
    <cfset var rsQuizQuestionReport = "" >
    <cftry>
    <cfquery name="rsQuizQuestionReport" datasource="#application.mcmsDSN#">
    SELECT qqQuestion As Question, qName As Quiz, qqInstruction As Instruction, qqRequired As Required, qqRequiredMessage As Required_Message, qqtName As Type, qqSort As Sort, sName As Status FROM v_quiz_question WHERE 0=0
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(qName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(qqQuestion) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">)
    </cfif>
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsQuizQuestionReport = StructNew()>
    <cfset rsQuizQuestionReport.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsQuizQuestionReport>
    </cffunction>
    
    <cffunction name="getQuizQuestionOptionReport" access="public" returntype="query" hint="Get Quiz Question Option Report data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="orderBy" type="string" required="yes" default="qqoSort">
    <cfset var rsQuizQuestionOptionReport = "" >
    <cftry>
    <cfquery name="rsQuizQuestionOptionReport" datasource="#application.mcmsDSN#">
    SELECT qqoOption As Question_Option, qqQuestion As Question, qqoInstruction As Instruction, qqoSort As Sort, sName As Status FROM v_quiz_question_option WHERE 0=0
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(qqoOption) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(qqQuestion) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">)
    </cfif>
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsQuizQuestionOptionReport = StructNew()>
    <cfset rsQuizQuestionOptionReport.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsQuizQuestionOptionReport>
    </cffunction>
    
    <cffunction name="insertQuiz" access="public" returntype="struct">
    <cfargument name="qName" type="string" required="yes">
    <cfargument name="qDescription" type="string" required="yes">
    <cfargument name="qPassingScore" type="numeric" required="yes">
    <cfargument name="qTimeLimit" type="numeric" required="yes">
    <cfargument name="qDateRel" type="string" required="yes">
    <cfargument name="qDateExp" type="string" required="yes">
    <cfargument name="qResultEmail" type="string" required="yes">
    <cfargument name="qtID" type="numeric" required="yes">
    <cfargument name="qStatus" type="numeric" required="yes">
    <!---Relationship arguments.--->
    <cfargument name="siteNo" type="string" required="yes">
    <cfargument name="deptNo" type="string" required="yes">
    <cfargument name="urID" type="string" required="yes" default="0">
    <cfset result.message = "You have successfully inserted the record.">
    <cftry>
    <!---Check for profanity in the text.--->
    <cfinvoke 
    component="MCMS.component.utility.Regex"
    method="regexProfanity"
    returnvariable="regexProfanityRet">
    <cfinvokeargument name="profanityString" value="#ARGUMENTS.qDescription#"/>
    </cfinvoke>
    <!---Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.app.quiz.Quiz"
    method="getQuiz"
    returnvariable="getCheckQuizRet">
    <cfinvokeargument name="qName" value="#ARGUMENTS.qName#"/>
    <cfinvokeargument name="qStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckQuizRet.recordcount NEQ 0>
    <cfset result.message = "The quiz #ARGUMENTS.qName# already exists, please enter a new quiz.">
    <cfelseif regexProfanityRet CONTAINS '$%&*!'>
    <cfset result.message = "Some text contained profanity, please remove any profanity from your text.">
    <!---Check length restriction.--->
    <cfelseif LEN(ARGUMENTS.qDescription) GT 1024>
    <cfset result.message = "The description is longer than 1024 characters, please enter a new description under 1024 characters.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    INSERT INTO tbl_quiz (qName,qDescription,qPassingScore,qTimeLimit,qDateRel,qDateExp,qResultEmail,qtID,qStatus) VALUES
    (
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.qName#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.qDescription#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.qPassingScore#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.qTimeLimit#">,
    <cfqueryparam cfsqltype="cf_sql_date" value="#ARGUMENTS.qDateRel#">,
    <cfqueryparam cfsqltype="cf_sql_date" value="#ARGUMENTS.qDateExp#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.qResultEmail#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.qtID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.qStatus#">
    )
    </cfquery>
    </cftransaction>
    <!---Get the qID just added.--->
    <cfinvoke 
    component="MCMS.component.app.quiz.Quiz"
    method="getQuiz"
    returnvariable="getQuizIDRet">
    <cfinvokeargument name="qName" value="#ARGUMENTS.qName#"/>
    <cfinvokeargument name="qStatus" value="1,2,3"/>
    </cfinvoke>
    <cfset this.qID = getQuizIDRet.ID>
    <!---Create site relationships.--->
    <cfloop index="siteNo" list="#ARGUMENTS.siteNo#">
    <cfinvoke 
    component="MCMS.component.app.quiz.Quiz"
    method="insertQuizSiteRel"
    returnvariable="insertQuizSiteRelRet">
    <cfinvokeargument name="qID" value="#this.qID#"/>
    <cfinvokeargument name="siteNo" value="#siteNo#"/>
    <cfinvokeargument name="qsrStatus" value="1"/>
    </cfinvoke>
    </cfloop>
    <!---Create department relationships.--->
    <cfloop index="deptNo" list="#ARGUMENTS.deptNo#">
    <cfinvoke 
    component="MCMS.component.app.quiz.Quiz"
    method="insertQuizDepartmentRel"
    returnvariable="insertQuizDepartmentRelRet">
    <cfinvokeargument name="qID" value="#this.qID#"/>
    <cfinvokeargument name="deptNo" value="#deptNo#"/>
    <cfinvokeargument name="qdrStatus" value="1"/>
    </cfinvoke>
    </cfloop>
    <!---Create quiz user role notifcation relationship.--->
    <cfloop index="urID" list="#ARGUMENTS.urID#">
    <cfinvoke 
    component="MCMS.component.app.quiz.Quiz"
    method="insertQuizUserRoleNotificationRel"
    returnvariable="insertQuizUserRoleNotificationRelRet">
    <cfinvokeargument name="qID" value="#this.qID#"/>
    <cfinvokeargument name="urID" value="#urID#"/>
    <cfinvokeargument name="qurnrStatus" value="1"/>
    </cfinvoke>
    </cfloop>
    </cfif>
    <cfcatch type="any">
    <cfset result.message = "There was an error inserting the record.">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="insertQuizQuestion" access="public" returntype="struct">
    <cfargument name="qID" type="numeric" required="yes">
    <cfargument name="qqQuestion" type="string" required="yes">
    <cfargument name="qqInstruction" type="string" required="yes">
    <cfargument name="qqRequired" type="numeric" required="yes">
    <cfargument name="qqRequiredMessage" type="string" required="yes">
    <cfargument name="qqtID" type="numeric" required="yes">
    <cfargument name="qqSort" type="numeric" required="yes">
    <cfargument name="qqStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully inserted the record.">
    <cftry>
    <!---Check for profanity in the text.--->
    <cfinvoke 
    component="MCMS.component.utility.Regex"
    method="regexProfanity"
    returnvariable="regexProfanityRet">
    <cfinvokeargument name="profanityString" value="#ARGUMENTS.qqQuestion#"/>
    </cfinvoke>
    <!---Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.app.quiz.Quiz"
    method="getQuizQuestion"
    returnvariable="getCheckQuizQuestionRet">
    <cfinvokeargument name="qqQuestion" value="#ARGUMENTS.qqQuestion#"/>
    <cfinvokeargument name="qqStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckQuizQuestionRet.recordcount NEQ 0>
    <cfset result.message = "The question #ARGUMENTS.qqQuestion# already exists, please enter a new question.">
    <cfelseif regexProfanityRet CONTAINS '$%&*!'>
    <cfset result.message = "Some text contained profanity, please remove any profanity from your text.">
    <!---Check length restriction.--->
    <cfelseif LEN(ARGUMENTS.qqQuestion) GT 255>
    <cfset result.message = "The question is longer than 255 characters, please enter a new question under 255 characters.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    INSERT INTO tbl_quiz_question (qID,qqQuestion,qqInstruction,qqRequired,qqRequiredMessage,qqtID,qqSort,qqStatus) VALUES
    (
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.qID#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.qqQuestion#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.qqInstruction#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.qqRequired#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.qqRequiredMessage#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.qqtID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.qqSort#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.qqStatus#">
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
    
    <cffunction name="insertQuizQuestionOption" access="public" returntype="struct">
    <cfargument name="qqID" type="numeric" required="yes">
    <cfargument name="qqoOption" type="string" required="yes">
    <cfargument name="qqoAnswer" type="numeric" required="yes">
    <cfargument name="qqoInstruction" type="string" required="yes">
    <cfargument name="qqoSort" type="numeric" required="yes">
    <cfargument name="qqoStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully inserted the record.">
    <cftry>
    <!---Check for profanity in the text.--->
    <cfinvoke 
    component="MCMS.component.utility.Regex"
    method="regexProfanity"
    returnvariable="regexProfanityRet">
    <cfinvokeargument name="profanityString" value="#ARGUMENTS.qqoOption#"/>
    </cfinvoke>
    <!---Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.app.quiz.Quiz"
    method="getQuizQuestionOption"
    returnvariable="getCheckQuizQuestionOptionRet">
    <cfinvokeargument name="qqID" value="#ARGUMENTS.qqID#"/>
    <cfinvokeargument name="qqoOption" value="#ARGUMENTS.qqoOption#"/>
    <cfinvokeargument name="qStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckQuizQuestionOptionRet.recordcount NEQ 0>
    <cfset result.message = "The option #ARGUMENTS.qqoOption# already exists, please enter a new option.">
    <cfelseif regexProfanityRet CONTAINS '$%&*!'>
    <cfset result.message = "Some text contained profanity, please remove any profanity from your text.">
    <!---Check length restriction.--->
    <cfelseif LEN(ARGUMENTS.qqoOption) GT 255>
    <cfset result.message = "The option is longer than 255 characters, please enter a new option under 255 characters.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    INSERT INTO tbl_quiz_question_option (qqID,qqoOption,qqoAnswer,qqoInstruction,qqoSort,qqoStatus) VALUES
    (
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.qqID#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.qqoOption#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.qqoAnswer#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.qqoInstruction#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.qqoSort#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.qqoStatus#">
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
    
    <cffunction name="insertQuizSiteRel" access="public" returntype="struct">
    <cfargument name="qID" type="numeric" required="yes">
    <cfargument name="siteNo" type="numeric" required="yes">
    <cfargument name="qsrStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully inserted the record.">
    <cftry>
    <!---Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.app.quiz.Quiz"
    method="getQuizSiteRel"
    returnvariable="getCheckQuizSiteRelRet">
    <cfinvokeargument name="qID" value="#ARGUMENTS.qID#"/>
    <cfinvokeargument name="siteNo" value="#ARGUMENTS.siteNo#"/>
    <cfinvokeargument name="qsrStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckQuizSiteRelRet.recordcount NEQ 0>
    <cfset result.message = "The quiz site relationship already exists, please try again.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    INSERT INTO tbl_quiz_site_rel (qID,siteNo,qsrStatus) VALUES
    (
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.qID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.siteNo#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.qsrStatus#">
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
    
    <cffunction name="insertQuizDepartmentRel" access="public" returntype="struct">
    <cfargument name="qID" type="numeric" required="yes">
    <cfargument name="deptNo" type="numeric" required="yes">
    <cfargument name="qdrStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully inserted the record.">
    <cftry>
    <!---Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.app.quiz.Quiz"
    method="getQuizDepartmentRel"
    returnvariable="getCheckQuizDepartmentRelRet">
    <cfinvokeargument name="qID" value="#ARGUMENTS.qID#"/>
    <cfinvokeargument name="deptNo" value="#ARGUMENTS.deptNo#"/>
    <cfinvokeargument name="qdrStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckQuizDepartmentRelRet.recordcount NEQ 0>
    <cfset result.message = "The quiz department relationship already exists, please try again.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    INSERT INTO tbl_quiz_department_rel (qID,deptNo,qdrStatus) VALUES
    (
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.qID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.deptNo#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.qdrStatus#">
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
    
    <cffunction name="insertQuizUserRoleNotificationRel" access="public" returntype="struct">
    <cfargument name="qID" type="numeric" required="yes">
    <cfargument name="urID" type="numeric" required="yes">
    <cfargument name="qurnrStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully inserted the record.">
    <cftry>
    <!---Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.app.quiz.Quiz"
    method="getQuizUserRoleNotificationRel"
    returnvariable="getQuizUserRoleNotificationRelRet">
    <cfinvokeargument name="qID" value="#ARGUMENTS.qID#"/>
    <cfinvokeargument name="urID" value="#ARGUMENTS.urID#"/>
    <cfinvokeargument name="qurnrStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getQuizUserRoleNotificationRelRet.recordcount NEQ 0>
    <cfset result.message = "The quiz user role notification relationship already exists, please try again.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    INSERT INTO tbl_quiz_ur_notification_rel (qID,urID,qurnrStatus) VALUES
    (
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.qID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.urID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.qurnrStatus#">
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
    
    <cffunction name="insertQuizResult" access="public" returntype="struct">
    <cfargument name="userID" type="numeric" required="yes">
    <cfargument name="qID" type="numeric" required="yes">
    <cfargument name="qrName" type="string" required="yes">
    <cfargument name="qrEmail" type="string" required="yes">
    <cfargument name="qrCorrect" type="numeric" required="yes">
    <cfargument name="qrAccuracy" type="numeric" required="yes">
    <cfargument name="qrTotal" type="numeric" required="yes">
    <cfargument name="qrGrade" type="string" required="yes">
    <cfargument name="siteNo" type="numeric" required="yes">
    <cfargument name="deptNo" type="numeric" required="yes">
    <cfargument name="qrStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully inserted the record.">
    <cfset result.ID = 0>
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    INSERT INTO tbl_quiz_result (userID,qID,qrName,qrEmail,qrCorrect,qrAccuracy,qrTotal,qrGrade,siteNo,deptNo,qrStatus) VALUES
    (
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.userID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.qID#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.qrName#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.qrEmail#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.qrCorrect#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.qrAccuracy#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.qrTotal#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.qrGrade#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.siteNo#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.deptNo#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.qrStatus#">
    )
    </cfquery>
    </cftransaction>
    <cfinvoke 
    component="MCMS.component.cms.Cms"
    method="getMaxValueSQL"
    returnvariable="qrID">
    <cfinvokeargument name="tableName" value="tbl_quiz_result"/>
    </cfinvoke>
    <cfset this.qrID = qrID>
	<cfset result.ID = this.qrID>
    <cfcatch type="any">
    <cfset result.message = "There was an error inserting the record.">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="insertQuizAnswer" access="public" returntype="struct">
    <cfargument name="qID" type="numeric" required="yes">
    <cfargument name="qrID" type="numeric" required="yes">
    <cfargument name="qqID" type="numeric" required="yes">
    <cfargument name="qqoID" type="numeric" required="yes">
    <cfargument name="qaAnswer" type="string" required="yes">
    <cfargument name="qaStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully inserted the record.">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    INSERT INTO tbl_quiz_answer (qID,qrID,qqID,qqoID,qaAnswer,qaStatus) VALUES
    (
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.qID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.qrID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.qqID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.qqoID#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.qaAnswer#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.qaStatus#">
    )
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error inserting the record.">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="sendQuizEmail" access="public" returntype="struct">
    <cfargument name="qID" type="numeric" required="yes"> 
    <cfargument name="qrID" type="numeric" required="yes">
    <cfargument name="siteNo" type="numeric" required="yes">
    <cfargument name="deptNo" type="numeric" required="yes">
    <cfargument name="qResultEmail" type="string" required="yes" default="">
    <cfargument name="qName" type="string" required="yes">
    <cfset result.message = "You have successfully sent the quiz email.">
    <cftry>
    <cfinvoke 
    component="MCMS.component.app.quiz.Quiz"
    method="getQuiz"
    returnvariable="getQuizRet">
    <cfinvokeargument name="ID" value="#ARGUMENTS.qID#"/>
    <cfinvokeargument name="qStatus" value="1,2,3"/>
    </cfinvoke>
    <cfset this.cc = ''>
    <cfset this.emailTo = ''>
    <cfset this.userRoleEmailList = ''>
    <cfinvoke 
    component="MCMS.component.app.quiz.Quiz"
    method="getQuizUserRoleNotificationRel"
    returnvariable="getQuizUserRoleNotificationRelRet">
    <cfinvokeargument name="qID" value="#ARGUMENTS.qID#"/>
    </cfinvoke>
    <cfif getQuizUserRoleNotificationRelRet.recordcount NEQ 0>
    <cfinvoke 
    component="MCMS.component.cms.User"
    method="getUserDepartmentRel"
    returnvariable="getUserDepartmentRelRet">
    <cfinvokeargument name="urID" value="#ValueList(getQuizUserRoleNotificationRelRet.urID)#"/>
    <cfinvokeargument name="deptNo" value="0,#ARGUMENTS.deptNo#"/>
    <cfinvokeargument name="udrStatus" value="1,2,3"/>
    </cfinvoke>
	<cfif getUserDepartmentRelRet.recordcount NEQ 0>
    <cfset userIDList = ValueList(getUserDepartmentRelRet.userID)>
    <cfinvoke 
    component="MCMS.component.cms.User"
    method="getUserSiteRel"
    returnvariable="getUserSiteRelRet">
    <cfinvokeargument name="userID" value="#userIDList#"/>
    <cfinvokeargument name="urID" value="#ValueList(getQuizUserRoleNotificationRelRet.urID)#"/>
    <cfinvokeargument name="siteNo" value="100,#ARGUMENTS.siteNo#"/>
    <cfinvokeargument name="usrStatus" value="1,2,3"/>
    </cfinvoke>
    <cfset this.userRoleEmailList = ValueList(getUserSiteRelRet.userEmail,';')>
    </cfif>
    </cfif>
    <!--- Set emailTo according to settings from quiz admin result email and/or user role recipients. --->
    <cfif ARGUMENTS.qResultEmail NEQ "">
    <cfset this.emailTo = ARGUMENTS.qResultEmail>
    <cfset this.cc = this.userRoleEmailList>
    <cfelse>
    <cfset this.emailTo = this.userRoleEmailList>
    </cfif>
    <cfif this.emailTo NEQ "">
    <!--- Set email template based on quiz type. --->
	<cfif getQuizRet.qtID EQ 3>
    <cfset this.emailTemplate = "/training_bak/lesson/quiz/view/inc_quiz_test_only_email_template.cfm">
    <cfelse>
    <cfset this.emailTemplate = "/training_bak/lesson/quiz/view/inc_quiz_email_template.cfm">
    </cfif>
    <cfinvoke 
    component="MCMS.component.utility.Email"
    method="sendEmail">
    <cfinvokeargument name="subject" value="#ARGUMENTS.qName# Results"/>
    <cfinvokeargument name="to" value="#this.emailTo#"/>
    <cfinvokeargument name="cc" value="#this.cc#"/>
    <cfinvokeargument name="from" value="#application.noReplyEmail#"/>
    <cfinvokeargument name="body" value=""/>
    <cfinvokeargument name="ID" value="#ARGUMENTS.qrID#"/>
    <cfinvokeargument name="emailTemplate" value="#this.emailTemplate#"/>
    </cfinvoke>
    </cfif>
    <cfcatch type="any">
    <cfset result.message = "There was an error sending the quiz email.">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="updateQuiz" access="public" returntype="struct">
    <cfargument name="ID" type="numeric" required="yes">
    <cfargument name="qName" type="string" required="yes">
    <cfargument name="qDescription" type="string" required="yes">
    <cfargument name="qPassingScore" type="numeric" required="yes">
    <cfargument name="qTimeLimit" type="numeric" required="yes">
    <cfargument name="qDateRel" type="string" required="yes">
    <cfargument name="qDateExp" type="string" required="yes">
    <cfargument name="qResultEmail" type="string" required="yes">
    <cfargument name="qtID" type="numeric" required="yes">
    <cfargument name="qStatus" type="numeric" required="yes">
    <!---Relationship arguments.--->
    <cfargument name="siteNo" type="string" required="yes">
    <cfargument name="deptNo" type="string" required="yes">
    <cfargument name="urID" type="string" required="yes" default="0">
    <cfset result.message = "You have successfully updated the record.">
    <cftry>
    <!---Check for profanity in the text.--->
    <cfinvoke 
    component="MCMS.component.utility.Regex"
    method="regexProfanity"
    returnvariable="regexProfanityRet">
    <cfinvokeargument name="profanityString" value="#ARGUMENTS.qDescription#"/>
    </cfinvoke>
    <!---Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.app.quiz.Quiz"
    method="getQuiz"
    returnvariable="getCheckQuizRet">
    <cfinvokeargument name="excludeID" value="#ARGUMENTS.ID#"/>
    <cfinvokeargument name="qName" value="#ARGUMENTS.qName#"/>
    <cfinvokeargument name="qStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckQuizRet.recordcount NEQ 0>
    <cfset result.message = "The quiz #ARGUMENTS.qName# already exists, please enter a new quiz.">
    <cfelseif regexProfanityRet CONTAINS '$%&*!'>
    <cfset result.message = "Some text contained profanity, please remove any profanity from your text.">
    <!---Check length restriction.--->
    <cfelseif LEN(ARGUMENTS.qDescription) GT 1024>
    <cfset result.message = "The description is longer than 1024 characters, please enter a new description under 1024 characters.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_quiz SET
    qName = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.qName#">,
    qDescription = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.qDescription#">,
    qPassingScore = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.qPassingScore#">,
    qTimeLimit = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.qTimeLimit#">,
    qDateRel = <cfqueryparam cfsqltype="cf_sql_date" value="#ARGUMENTS.qDateRel#">,
    qDateExp = <cfqueryparam cfsqltype="cf_sql_date" value="#ARGUMENTS.qDateExp#">,
    qResultEmail = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.qResultEmail#">,
    qtID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.qtID#">,
    qStatus = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.qStatus#">
    WHERE ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ID#">
    </cfquery>
    </cftransaction>
    <!---Delete any existing relationships.--->
    <cfinvoke 
    component="MCMS.component.app.quiz.Quiz"
    method="deleteQuizSiteRel"
    returnvariable="deleteQuizSiteRelRet">
    <cfinvokeargument name="qID" value="#ARGUMENTS.ID#"/>
    </cfinvoke>
    <cfinvoke 
    component="MCMS.component.app.quiz.Quiz"
    method="deleteQuizDepartmentRel"
    returnvariable="deleteQuizDepartmentRelRet">
    <cfinvokeargument name="qID" value="#ARGUMENTS.ID#"/>
    </cfinvoke>
    <cfinvoke 
    component="MCMS.component.app.quiz.Quiz"
    method="deleteQuizUserRoleNotificationRel"
    returnvariable="deleteQuizUserRoleNotificationRelRet">
    <cfinvokeargument name="qID" value="#ARGUMENTS.ID#"/>
    </cfinvoke>
    <!---Create site relationships.--->
    <cfloop index="siteNo" list="#ARGUMENTS.siteNo#">
    <cfinvoke 
    component="MCMS.component.app.quiz.Quiz"
    method="insertQuizSiteRel"
    returnvariable="insertDailyBulletinQuizRelRet">
    <cfinvokeargument name="qID" value="#ARGUMENTS.ID#"/>
    <cfinvokeargument name="siteNo" value="#siteNo#"/>
    <cfinvokeargument name="qsrStatus" value="1"/>
    </cfinvoke>
    </cfloop>
    <!---Create department relationships.--->
    <cfloop index="deptNo" list="#ARGUMENTS.deptNo#">
    <cfinvoke 
    component="MCMS.component.app.quiz.Quiz"
    method="insertQuizDepartmentRel"
    returnvariable="insertQuizDepartmentRelRet">
    <cfinvokeargument name="qID" value="#ARGUMENTS.ID#"/>
    <cfinvokeargument name="deptNo" value="#deptNo#"/>
    <cfinvokeargument name="qdrStatus" value="1"/>
    </cfinvoke>
    </cfloop>
    <!---Create quiz user role notifcation relationship.--->
    <cfif ARGUMENTS.urID NEQ 0>
    <cfloop index="urID" list="#ARGUMENTS.urID#">
    <cfinvoke 
    component="MCMS.component.app.quiz.Quiz"
    method="insertQuizUserRoleNotificationRel"
    returnvariable="insertQuizUserRoleNotificationRelRet">
    <cfinvokeargument name="qID" value="#ARGUMENTS.ID#"/>
    <cfinvokeargument name="urID" value="#urID#"/>
    <cfinvokeargument name="qurnrStatus" value="1"/>
    </cfinvoke>
    </cfloop>
    </cfif>
    </cfif>
    <cfcatch type="any">
    <cfset result.message = "There was an error updating the record.">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="updateQuizQuestion" access="public" returntype="struct">
    <cfargument name="ID" type="numeric" required="yes">
    <cfargument name="qID" type="numeric" required="yes">
    <cfargument name="qqQuestion" type="string" required="yes">
    <cfargument name="qqInstruction" type="string" required="yes">
    <cfargument name="qqRequired" type="numeric" required="yes">
    <cfargument name="qqRequiredMessage" type="string" required="yes">
    <cfargument name="qqtID" type="numeric" required="yes">
    <cfargument name="qqSort" type="numeric" required="yes">
    <cfargument name="qqStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully updated the record.">
    <cftry>
    <!---Check for profanity in the text.--->
    <cfinvoke 
    component="MCMS.component.utility.Regex"
    method="regexProfanity"
    returnvariable="regexProfanityRet">
    <cfinvokeargument name="profanityString" value="#ARGUMENTS.qqQuestion#"/>
    </cfinvoke>
    <!---Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.app.quiz.Quiz"
    method="getQuizQuestion"
    returnvariable="getCheckQuizQuestionRet">
    <cfinvokeargument name="excludeID" value="#ARGUMENTS.ID#"/>
    <cfinvokeargument name="qqQuestion" value="#ARGUMENTS.qqQuestion#"/>
    <cfinvokeargument name="qStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckQuizQuestionRet.recordcount NEQ 0>
    <cfset result.message = "The question #ARGUMENTS.qqQuestion# already exists, please enter a new question.">
    <cfelseif regexProfanityRet CONTAINS '$%&*!'>
    <cfset result.message = "Some text contained profanity, please remove any profanity from your text.">
    <!---Check length restriction.--->
    <cfelseif LEN(ARGUMENTS.qqQuestion) GT 255>
    <cfset result.message = "The question is longer than 255 characters, please enter a new question under 255 characters.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_quiz_question SET
    qID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.qID#">,
    qqQuestion = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.qqQuestion#">,
    qqInstruction = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.qqInstruction#">,
    qqRequired = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.qqRequired#">,
    qqRequiredMessage = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.qqRequiredMessage#">,
    qqtID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.qqtID#">,
    qqSort = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.qqSort#">,
    qqStatus = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.qqStatus#">
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
    
    <cffunction name="updateQuizQuestionOption" access="public" returntype="struct">
    <cfargument name="ID" type="numeric" required="yes">
    <cfargument name="qqID" type="numeric" required="yes">
    <cfargument name="qqoOption" type="string" required="yes">
    <cfargument name="qqoAnswer" type="numeric" required="yes">
    <cfargument name="qqoInstruction" type="string" required="yes">
    <cfargument name="qqoSort" type="numeric" required="yes">
    <cfargument name="qqoStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully updated the record.">
    <cftry>
    <!---Check for profanity in the text.--->
    <cfinvoke 
    component="MCMS.component.utility.Regex"
    method="regexProfanity"
    returnvariable="regexProfanityRet">
    <cfinvokeargument name="profanityString" value="#ARGUMENTS.qqoOption#"/>
    </cfinvoke>
    <!---Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.app.quiz.Quiz"
    method="getQuizQuestionOption"
    returnvariable="getCheckQuizQuestionOptionRet">
    <cfinvokeargument name="excludeID" value="#ARGUMENTS.ID#"/>
    <cfinvokeargument name="qqID" value="#ARGUMENTS.qqID#"/>
    <cfinvokeargument name="qqoOption" value="#ARGUMENTS.qqoOption#"/>
    <cfinvokeargument name="qqoStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckQuizQuestionOptionRet.recordcount NEQ 0>
    <cfset result.message = "The option #ARGUMENTS.qqoOption# already exists, please enter a new option.">
    <cfelseif regexProfanityRet CONTAINS '$%&*!'>
    <cfset result.message = "Some text contained profanity, please remove any profanity from your text.">
    <!---Check length restriction.--->
    <cfelseif LEN(ARGUMENTS.qqoOption) GT 255>
    <cfset result.message = "The option is longer than 255 characters, please enter a new option under 255 characters.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_quiz_question_option SET
    qqID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.qqID#">,
    qqoOption = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.qqoOption#">,
    qqoAnswer = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.qqoAnswer#">,
    qqoInstruction = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.qqoInstruction#">,
    qqoSort = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.qqoSort#">,
    qqoStatus = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.qqoStatus#">
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
    
    <cffunction name="updateQuizList" access="public" returntype="struct">
    <cfargument name="ID" type="numeric" required="yes">
    <cfargument name="qStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully updated the records.">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_quiz SET
    qStatus = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.qStatus#">
    WHERE ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ID#">
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error updating the records.">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="updateQuizQuestionList" access="public" returntype="struct">
    <cfargument name="ID" type="numeric" required="yes">
    <cfargument name="qqStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully updated the records.">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_quiz_question SET
    qqStatus = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.qqStatus#">
    WHERE ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ID#">
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error updating the records.">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="updateQuizQuestionOptionList" access="public" returntype="struct">
    <cfargument name="ID" type="numeric" required="yes">
    <cfargument name="qqoStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully updated the records.">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_quiz_question_option SET
    qqoStatus = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.qqoStatus#">
    WHERE ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ID#">
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error updating the records.">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="deleteQuiz" access="public" returntype="struct">
    <cfargument name="ID" type="string" required="yes">
    <cfset result.message = "You have successfully deleted the record(s).">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    DELETE FROM tbl_quiz
    WHERE ID IN (<cfqueryparam cfsqltype="cf_sql_integer" list="yes" value="#ARGUMENTS.ID#">)
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error deleting the record(s).">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>   
    
    <cffunction name="deleteQuizQuestion" access="public" returntype="struct">
    <cfargument name="ID" type="string" required="yes">
    <cfset result.message = "You have successfully deleted the record(s).">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    DELETE FROM tbl_quiz_question
    WHERE ID IN (<cfqueryparam cfsqltype="cf_sql_integer" list="yes" value="#ARGUMENTS.ID#">)
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error deleting the record(s).">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction> 
    
    <cffunction name="deleteQuizQuestionOption" access="public" returntype="struct">
    <cfargument name="ID" type="string" required="yes">
    <cfset result.message = "You have successfully deleted the record(s).">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    DELETE FROM tbl_quiz_question_option
    WHERE ID IN (<cfqueryparam cfsqltype="cf_sql_integer" list="yes" value="#ARGUMENTS.ID#">)
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error deleting the record(s).">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="deleteQuizSiteRel" access="public" returntype="struct">
    <cfargument name="ID" type="string" required="yes" default="0">
    <cfargument name="qID" type="string" required="yes" default="0">
    <cfset result.message = "You have successfully deleted the record(s).">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    DELETE FROM tbl_quiz_site_rel
    WHERE ID IN (<cfqueryparam cfsqltype="cf_sql_integer" list="yes" value="#ARGUMENTS.ID#">)
    OR qID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.qID#">
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error deleting the record(s).">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="deleteQuizDepartmentRel" access="public" returntype="struct">
    <cfargument name="ID" type="string" required="yes" default="0">
    <cfargument name="qID" type="string" required="yes" default="0">
    <cfset result.message = "You have successfully deleted the record(s).">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    DELETE FROM tbl_quiz_department_rel
    WHERE ID IN (<cfqueryparam cfsqltype="cf_sql_integer" list="yes" value="#ARGUMENTS.ID#">)
    OR qID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.qID#">
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error deleting the record(s).">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="deleteQuizUserRoleNotificationRel" access="public" returntype="struct">
    <cfargument name="ID" type="string" required="yes" default="0">
    <cfargument name="qID" type="string" required="yes" default="0">
    <cfset result.message = "You have successfully deleted the record(s).">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    DELETE FROM tbl_quiz_ur_notification_rel
    WHERE ID IN (<cfqueryparam cfsqltype="cf_sql_integer" list="yes" value="#ARGUMENTS.ID#">)
    OR qID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.qID#">
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error deleting the record(s).">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
</cfcomponent>