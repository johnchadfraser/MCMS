<cfcomponent>
    <cffunction name="getDiary" access="public" returntype="query" hint="Get Diary data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="dDateRel" type="string" required="yes" default="">
    <cfargument name="dDateExp" type="string" required="yes" default="">
    <cfargument name="ID" type="string" required="yes" default="0">
    <cfargument name="excludeID" type="numeric" required="yes" default="0">
    <cfargument name="diaryName" type="string" required="yes" default="">
    <cfargument name="dDescription" type="string" required="yes" default="">
    <cfargument name="dStatus" type="string" required="yes" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="diaryName">
    <cfset var rsDiary = "" >
    <cftry>
    <cfquery name="rsDiary" datasource="#application.mcmsDSN#">
    SELECT * FROM v_diary WHERE 0=0
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(diaryName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(dDescription) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">)
    </cfif>
    <cfif ARGUMENTS.dDateRel NEQ "">
    AND dDateRel <= <cfqueryparam value="#ARGUMENTS.dDateRel#" cfsqltype="cf_sql_date">
    </cfif>
    <cfif ARGUMENTS.dDateExp NEQ "">
    AND dDateExp >= <cfqueryparam value="#ARGUMENTS.dDateExp#" cfsqltype="cf_sql_date">
    </cfif>
    <cfif ARGUMENTS.ID NEQ 0>
    AND ID IN (<cfqueryparam value="#ARGUMENTS.ID#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    <cfif ARGUMENTS.excludeID NEQ 0>
    AND ID <> <cfqueryparam value="#ARGUMENTS.excludeID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.diaryName NEQ "">
    AND diaryName = <cfqueryparam value="#ARGUMENTS.diaryName#" cfsqltype="cf_sql_varchar">
    </cfif>
    <cfif ARGUMENTS.dDescription NEQ "">
    AND dDescription = <cfqueryparam value="#ARGUMENTS.dDescription#" cfsqltype="cf_sql_varchar">
    </cfif>
    AND dStatus IN (<cfqueryparam value="#ARGUMENTS.dStatus#" list="yes" cfsqltype="cf_sql_integer">)
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsDiary = StructNew()>
    <cfset rsDiary.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsDiary>
    </cffunction>
    
    <cffunction name="getDiaryUserRoleRel" access="public" returntype="query" hint="Get Diary User Role Rel. data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="ID" type="numeric" required="yes" default="0">
    <cfargument name="excludeID" type="numeric" required="yes" default="0">
    <cfargument name="urID" type="numeric" required="yes" default="0">
    <cfargument name="dID" type="numeric" required="yes" default="0">
    <cfargument name="diaryName" type="string" required="yes" default="">
    <cfargument name="durrStatus" type="string" required="yes" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="urName, diaryName">
    <cfset var rsDiaryUserRoleRel = "" >
    <cftry>
    <cfquery name="rsDiaryUserRoleRel" datasource="#application.mcmsDSN#">
    SELECT * FROM v_diary_user_role_rel WHERE 0=0
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(diaryName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(urName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">)
    </cfif>
    <cfif ARGUMENTS.ID NEQ 0>
    AND ID = <cfqueryparam value="#ARGUMENTS.ID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.excludeID NEQ 0>
    AND ID <> <cfqueryparam value="#ARGUMENTS.excludeID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.dID NEQ 0>
    AND dID = <cfqueryparam value="#ARGUMENTS.dID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.urID NEQ 0>
    AND urID = <cfqueryparam value="#ARGUMENTS.urID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.diaryName NEQ "">
    AND diaryName = <cfqueryparam value="#ARGUMENTS.diaryName#" cfsqltype="cf_sql_varchar">
    </cfif>
    AND durrStatus IN (<cfqueryparam value="#ARGUMENTS.durrStatus#" list="yes" cfsqltype="cf_sql_integer">)
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsDiaryUserRoleRel = StructNew()>
    <cfset rsDiaryUserRoleRel.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsDiaryUserRoleRel>
    </cffunction>
    
    <cffunction name="getDiaryEntry" access="public" returntype="query" hint="Get Diary Entry data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="ID" type="numeric" required="yes" default="0">
    <cfargument name="excludeID" type="numeric" required="yes" default="0">
    <cfargument name="dID" type="numeric" required="yes" default="0">
    <cfargument name="deID" type="string" required="yes" default="">
    <cfargument name="userID" type="numeric" required="yes" default="0">
    <cfargument name="siteNo" type="string" required="yes" default="100">
    <cfargument name="deptNo" type="string" required="yes" default="0">
    <cfargument name="deDate" type="string" required="yes" default="">
    <cfargument name="deDateFrom" type="string" required="yes" default="">
    <cfargument name="deDateTo" type="string" required="yes" default="">
    <cfargument name="dqID" type="numeric" required="yes" default="0">
    <cfargument name="deStatus" type="string" required="yes" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="diaryName, dqSort, deDate DESC, siteNo, deptNo">
    <cfset var rsDiaryEntry = "" >
    <cftry>
    <cfquery name="rsDiaryEntry" datasource="#application.mcmsDSN#">
    SELECT * FROM v_diary_entry WHERE 0=0
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(diaryName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(dDescription) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">)
    </cfif>
    <cfif ARGUMENTS.ID NEQ 0>
    AND ID = <cfqueryparam value="#ARGUMENTS.ID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.excludeID NEQ 0>
    AND ID <> <cfqueryparam value="#ARGUMENTS.excludeID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.dID NEQ 0>
    AND dID = <cfqueryparam value="#ARGUMENTS.dID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.deID NEQ ''>
    AND deID = <cfqueryparam value="#ARGUMENTS.deID#" cfsqltype="cf_sql_varchar">
    </cfif>
    <cfif ARGUMENTS.userID NEQ 0>
    AND userID = <cfqueryparam value="#ARGUMENTS.userID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.siteNo NEQ 100>
    AND siteNo IN (<cfqueryparam value="#ARGUMENTS.siteNo#" list="yes" cfsqltype="cf_sql_integer">)    
    </cfif>
    <cfif ARGUMENTS.deptNo NEQ 0>
    AND deptNo IN (<cfqueryparam value="#ARGUMENTS.deptNo#" list="yes" cfsqltype="cf_sql_integer">)    
    </cfif>
    <cfif ARGUMENTS.deDate NEQ "">
    AND deDate = <cfqueryparam value="#ARGUMENTS.deDate#" cfsqltype="cf_sql_date">
    </cfif>
    <cfif ARGUMENTS.deDateFrom NEQ "">
    AND deDate) >= <cfqueryparam value="#ARGUMENTS.deDateFrom#" cfsqltype="cf_sql_date">
    </cfif>
    <cfif ARGUMENTS.deDateTo NEQ "">
    AND deDate <= <cfqueryparam value="#ARGUMENTS.deDateTo#" cfsqltype="cf_sql_date">
    </cfif>
    <cfif ARGUMENTS.dqID NEQ 0>
    AND dqID = <cfqueryparam value="#ARGUMENTS.dqID#" cfsqltype="cf_sql_integer">
    </cfif>
    AND deStatus IN (<cfqueryparam value="#ARGUMENTS.deStatus#" list="yes" cfsqltype="cf_sql_integer">)
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsDiaryEntry = StructNew()>
    <cfset rsDiaryEntry.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsDiaryEntry>
    </cffunction>
    
    <cffunction name="getDiaryEntryGroup" access="public" returntype="query" hint="Get Diary Entry Group data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="deID" type="string" required="yes" default="">
    <cfargument name="dID" type="numeric" required="yes" default="0">
    <cfargument name="userID" type="numeric" required="yes" default="0">
    <cfargument name="siteNo" type="string" required="yes" default="100">
    <cfargument name="deptNo" type="string" required="yes" default="0">
    <cfargument name="deDate" type="string" required="yes" default="">
    <cfargument name="deDateRel" type="string" required="yes" default="">
    <cfargument name="deDateExp" type="string" required="yes" default="">
    <cfargument name="dqID" type="numeric" required="yes" default="0">
    <cfargument name="deStatus" type="string" required="yes" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="deDate DESC, siteNo, deptNo">
    <cfset var rsDiaryEntryGroup = "" >
    <cftry>
    <cfquery name="rsDiaryEntryGroup" datasource="#application.mcmsDSN#">
    SELECT * FROM
    (SELECT deID, siteNo, siteName, dedate, dID, diaryName, userID, deptNo, deptName, userFName, userLName FROM V_DIARY_ENTRY
    GROUP BY deID, siteNo, siteName, deDate, dID, diaryName, userID, deptNo, deptName, userFName, userLName)
    WHERE 0=0
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(diaryName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">)
    </cfif>
    <cfif ARGUMENTS.deID NEQ ''>
    AND deID = <cfqueryparam value="#ARGUMENTS.deID#" cfsqltype="cf_sql_varchar">
    </cfif>
    <cfif ARGUMENTS.dID NEQ 0>
    AND dID = <cfqueryparam value="#ARGUMENTS.dID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.userID NEQ 0>
    AND userID = <cfqueryparam value="#ARGUMENTS.userID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.siteNo NEQ 100>
    AND siteNo IN (<cfqueryparam value="#ARGUMENTS.siteNo#" list="yes" cfsqltype="cf_sql_integer">)    
    </cfif>
    <cfif ARGUMENTS.deptNo NEQ 0>
    AND deptNo IN (<cfqueryparam value="#ARGUMENTS.deptNo#" list="yes" cfsqltype="cf_sql_integer">)    
    </cfif>
    <cfif ARGUMENTS.deDate NEQ "">
    AND deDate = <cfqueryparam value="#ARGUMENTS.deDate#" cfsqltype="cf_sql_date">
    </cfif>
    <cfif ARGUMENTS.deDateFrom NEQ "">
    AND deDate >= <cfqueryparam value="#ARGUMENTS.deDateFrom#" cfsqltype="cf_sql_date">
    </cfif>
    <cfif ARGUMENTS.deDateTo NEQ "">
    AND deDate <= <cfqueryparam value="#ARGUMENTS.deDateTo#" cfsqltype="cf_sql_date">
    </cfif>
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsDiaryEntryGroup = StructNew()>
    <cfset rsDiaryEntryGroup.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsDiaryEntryGroup>
    </cffunction>
    
    <cffunction name="getDiaryQuestion" access="public" returntype="query" hint="Get Diary Question data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="ID" type="numeric" required="yes" default="0">
    <cfargument name="excludeID" type="numeric" required="yes" default="0">
    <cfargument name="dqtID" type="string" required="yes" default="">
    <cfargument name="dqQuestion" type="string" required="yes" default="">
    <cfargument name="dqInstruction" type="string" required="yes" default="">
    <cfargument name="dqtStatus" type="string" required="no" default="1">
    <cfargument name="dqStatus" type="string" required="yes" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="dqSort, dqQuestion, diaryName">
    <cfset var rsDiaryQuestion = "" >
    <cftry>
    <cfquery name="rsDiaryQuestion" datasource="#application.mcmsDSN#">
    SELECT * FROM v_diary_question WHERE 0=0
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(dqQuestion) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(dqInstruction) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(diaryName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">) 
    </cfif>
    <cfif ARGUMENTS.ID NEQ 0>
    AND ID = <cfqueryparam value="#ARGUMENTS.ID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.excludeID NEQ 0>
    AND ID <> <cfqueryparam value="#ARGUMENTS.excludeID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.dqQuestion NEQ "">
    AND UPPER(dqQuestion) = <cfqueryparam value="#UCASE(ARGUMENTS.dqQuestion)#" cfsqltype="cf_sql_varchar">
    </cfif>
    <cfif ARGUMENTS.dqtID NEQ "">
    AND dqtID IN (<cfqueryparam value="#ARGUMENTS.dqtID#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    AND dqtStatus IN (<cfqueryparam value="#ARGUMENTS.dqtStatus#" list="yes" cfsqltype="cf_sql_integer">)
    AND dqStatus IN (<cfqueryparam value="#ARGUMENTS.dqStatus#" list="yes" cfsqltype="cf_sql_integer">)
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsDiaryQuestion = StructNew()>
    <cfset rsDiaryQuestion.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsDiaryQuestion>
    </cffunction>
    
    <cffunction name="getDiaryQuestionSiteRel" access="public" returntype="query" hint="Get Diary Question Site Relationship data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="ID" type="numeric" required="yes" default="0">
    <cfargument name="excludeID" type="numeric" required="yes" default="0">
    <cfargument name="dqtID" type="string" required="yes" default="">
    <cfargument name="dqQuestion" type="string" required="yes" default="">
    <cfargument name="dqInstruction" type="string" required="yes" default="">
    <cfargument name="siteNo" type="string" required="yes" default="100">
    <cfargument name="dqtStatus" type="string" required="no" default="1">
    <cfargument name="dqStatus" type="string" required="yes" default="1,3">
    <cfargument name="dqsrStatus" type="string" required="yes" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="dqQuestion">
    <cfset var rsDiaryQuestionSiteRel = "" >
    <cftry>
    <cfquery name="rsDiaryQuestionSiteRel" datasource="#application.mcmsDSN#">
    SELECT * FROM v_diary_question_site_rel WHERE 0=0
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(dqQuestion) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(dqInstruction) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(diaryName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">) 
    </cfif>
    <cfif ARGUMENTS.ID NEQ 0>
    AND ID = <cfqueryparam value="#ARGUMENTS.ID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.excludeID NEQ 0>
    AND ID <> <cfqueryparam value="#ARGUMENTS.excludeID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.dqQuestion NEQ "">
    AND UPPER(dqQuestion) = <cfqueryparam value="#UCASE(ARGUMENTS.dqQuestion)#" cfsqltype="cf_sql_varchar">
    </cfif>
    <cfif ARGUMENTS.dqtID NEQ "">
    AND dqtID IN (<cfqueryparam value="#ARGUMENTS.dqtID#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    <cfif ARGUMENTS.siteNo NEQ 100>
    AND siteNo IN (<cfqueryparam value="#ARGUMENTS.siteNo#" list="yes" cfsqltype="cf_sql_integer">)    
    </cfif>
    AND dqtStatus IN (<cfqueryparam value="#ARGUMENTS.dqtStatus#" list="yes" cfsqltype="cf_sql_integer">)
    AND dqStatus IN (<cfqueryparam value="#ARGUMENTS.dqStatus#" list="yes" cfsqltype="cf_sql_integer">)
    AND dqsrStatus IN (<cfqueryparam value="#ARGUMENTS.dqsrStatus#" list="yes" cfsqltype="cf_sql_integer">)
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsDiaryQuestionSiteRel = StructNew()>
    <cfset rsDiaryQuestionSiteRel.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsDiaryQuestionSiteRel>
    </cffunction>
    
    <cffunction name="getDiaryQuestionDepartmentRel" access="public" returntype="query" hint="Get Diary Question Department Relationship data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="ID" type="numeric" required="yes" default="0">
    <cfargument name="excludeID" type="numeric" required="yes" default="0">
    <cfargument name="dqtID" type="string" required="yes" default="">
    <cfargument name="dqQuestion" type="string" required="yes" default="">
    <cfargument name="dqInstruction" type="string" required="yes" default="">
    <cfargument name="deptNo" type="string" required="yes" default="0">
    <cfargument name="dqtStatus" type="string" required="no" default="1">
    <cfargument name="dqStatus" type="string" required="yes" default="1,3">
    <cfargument name="dqdrStatus" type="string" required="yes" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="dqQuestion">
    <cfset var rsDiaryQuestionDepartmentRel = "" >
    <cftry>
    <cfquery name="rsDiaryQuestionDepartmentRel" datasource="#application.mcmsDSN#">
    SELECT * FROM v_diary_question_dept_rel WHERE 0=0
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(dqQuestion) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(dqInstruction) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(diaryName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">) 
    </cfif>
    <cfif ARGUMENTS.ID NEQ 0>
    AND ID = <cfqueryparam value="#ARGUMENTS.ID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.excludeID NEQ 0>
    AND ID <> <cfqueryparam value="#ARGUMENTS.excludeID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.dqQuestion NEQ "">
    AND UPPER(dqQuestion) = <cfqueryparam value="#UCASE(ARGUMENTS.dqQuestion)#" cfsqltype="cf_sql_varchar">
    </cfif>
    <cfif ARGUMENTS.dqtID NEQ "">
    AND dqtID IN (<cfqueryparam value="#ARGUMENTS.dqtID#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    <cfif ARGUMENTS.deptNo NEQ 0>
    AND deptNo IN (<cfqueryparam value="#ARGUMENTS.deptNo#" list="yes" cfsqltype="cf_sql_integer">)    
    </cfif>
    AND dqtStatus IN (<cfqueryparam value="#ARGUMENTS.dqtStatus#" list="yes" cfsqltype="cf_sql_integer">)
    AND dqStatus IN (<cfqueryparam value="#ARGUMENTS.dqStatus#" list="yes" cfsqltype="cf_sql_integer">)
    AND dqdrStatus IN (<cfqueryparam value="#ARGUMENTS.dqdrStatus#" list="yes" cfsqltype="cf_sql_integer">)
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsDiaryQuestionDepartmentRel = StructNew()>
    <cfset rsDiaryQuestionDepartmentRel.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsDiaryQuestionDepartmentRel>
    </cffunction>
    
    <cffunction name="getDiaryQuestionRating" access="public" returntype="query" hint="Get Diary Question Rating data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="ID" type="numeric" required="yes" default="0">
    <cfargument name="excludeID" type="numeric" required="yes" default="0">
    <cfargument name="dqrName" type="string" required="yes" default="">
    <cfargument name="dqrtID" type="numeric" required="yes" default="0">
    <cfargument name="dqrStatus" type="string" required="yes" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="dqrSort">
    <cfset var rsDiaryQuestionRating = "" >
    <cftry>
    <cfquery name="rsDiaryQuestionRating" datasource="#application.mcmsDSN#" cachedwithin="#request.queryCache#">
    SELECT * FROM tbl_diary_question_rating WHERE 0=0
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND UPPER(dqrName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">
    </cfif>
    <cfif ARGUMENTS.ID NEQ 0>
    AND ID = <cfqueryparam value="#ARGUMENTS.ID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.excludeID NEQ 0>
    AND ID <> <cfqueryparam value="#ARGUMENTS.excludeID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.dqrName NEQ "">
    AND UPPER(dqrName) = <cfqueryparam value="#UCASE(ARGUMENTS.dqrName)#" cfsqltype="cf_sql_varchar">
    </cfif>
    <cfif ARGUMENTS.dqrtID NEQ 0>
    AND dqrtID = <cfqueryparam value="#ARGUMENTS.dqrtID#" cfsqltype="cf_sql_integer">
    </cfif>
    AND dqrStatus IN (<cfqueryparam value="#ARGUMENTS.dqrStatus#" list="yes" cfsqltype="cf_sql_integer">)
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsDiaryQuestionRating = StructNew()>
    <cfset rsDiaryQuestionRating.message = "There was an error with the query.">
    <cfif url.mcmsDebug EQ true>
    <cfdump var="#rsDiaryQuestionRating#">
    </cfif>
    </cfcatch>
    </cftry>
    <cfreturn rsDiaryQuestionRating>
    </cffunction>
    
    <cffunction name="getDiaryQuestionRatingType" access="public" returntype="query" hint="Get Diary Question Rating Type data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="ID" type="numeric" required="yes" default="0">
    <cfargument name="dqrtStatus" type="string" required="yes" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="dqrtName">
    <cfset var rsDiaryQuestionRatingType = "" >
    <cftry>
    <cfquery name="rsDiaryQuestionRatingType" datasource="#application.mcmsDSN#">
    SELECT * FROM tbl_diary_q_rating_type WHERE 0=0
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND UPPER(dqrtName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">
    </cfif>
    <cfif ARGUMENTS.ID NEQ 0>
    AND ID = <cfqueryparam value="#ARGUMENTS.ID#" cfsqltype="cf_sql_integer">
    </cfif>
    AND dqrtStatus IN (<cfqueryparam value="#ARGUMENTS.dqrtStatus#" list="yes" cfsqltype="cf_sql_integer">)
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsDiaryQuestionRatingType = StructNew()>
    <cfset rsDiaryQuestionRatingType.message = "There was an error with the query.">
    <cfif url.mcmsDebug EQ true>
    <cfdump var="#rsDiaryQuestionRatingType#">
    </cfif>
    </cfcatch>
    </cftry>
    <cfreturn rsDiaryQuestionRatingType>
    </cffunction>
    
    <cffunction name="getDiaryQuestionOption" access="public" returntype="query" hint="Get Diary Question Option data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="ID" type="numeric" required="yes" default="0">
    <cfargument name="excludeID" type="numeric" required="yes" default="0">
    <cfargument name="dqID" type="numeric" required="yes" default="0">
    <cfargument name="dqoOption" type="string" required="yes" default="">
    <cfargument name="dqStatus" type="string" required="yes" default="1">
    <cfargument name="dqoStatus" type="string" required="yes" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="dqoOption">
    <cfset var rsDiaryQuestionOption = "" >
    <cftry>
    <cfquery name="rsDiaryQuestionOption" datasource="#application.mcmsDSN#">
    SELECT * FROM v_diary_question_option WHERE 0=0
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(dqoOption) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(dqQuestion) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">)
    </cfif>
    <cfif ARGUMENTS.ID NEQ 0>
    AND ID = <cfqueryparam value="#ARGUMENTS.ID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.excludeID NEQ 0>
    AND ID <> <cfqueryparam value="#ARGUMENTS.excludeID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.dqID NEQ 0>
    AND dqID = <cfqueryparam value="#ARGUMENTS.dqID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.dqoOption NEQ "">
    AND dqoOption = <cfqueryparam value="#ARGUMENTS.dqoOption#" cfsqltype="cf_sql_varchar">
    </cfif>
    AND dqStatus IN (<cfqueryparam value="#ARGUMENTS.dqStatus#" list="yes" cfsqltype="cf_sql_integer">)
    AND dqoStatus IN (<cfqueryparam value="#ARGUMENTS.dqoStatus#" list="yes" cfsqltype="cf_sql_integer">)
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsDiaryQuestionOption = StructNew()>
    <cfset rsDiaryQuestionOption.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsDiaryQuestionOption>
    </cffunction>
    
    <cffunction name="getDiaryQuestionType" access="public" returntype="query" hint="Get Diary Question Type data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="ID" type="numeric" required="yes" default="0">
    <cfargument name="excludeID" type="numeric" required="yes" default="0">
    <cfargument name="dqtName" type="string" required="yes" default="">
    <cfargument name="dqtStatus" type="string" required="yes" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="dqtName">
    <cfset var rsDiaryQuestionType = "" >
    <cftry>
    <cfquery name="rsDiaryQuestionType" datasource="#application.mcmsDSN#">
    SELECT * FROM tbl_diary_question_type WHERE 0=0
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND UPPER(dqtName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">
    </cfif>
    <cfif ARGUMENTS.ID NEQ 0>
    AND ID = <cfqueryparam value="#ARGUMENTS.ID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.excludeID NEQ 0>
    AND ID <> <cfqueryparam value="#ARGUMENTS.excludeID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.dqtName NEQ "">
    AND UPPER(dqtName) = <cfqueryparam value="#UCASE(ARGUMENTS.dqtName)#" cfsqltype="cf_sql_varchar">
    </cfif>
    AND dqtStatus IN (<cfqueryparam value="#ARGUMENTS.dqtStatus#" list="yes" cfsqltype="cf_sql_integer">)
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsDiaryQuestionType = StructNew()>
    <cfset rsDiaryQuestionType.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsDiaryQuestionType>
    </cffunction>
    
    <cffunction name="getDiaryType" access="public" returntype="query" hint="Get Diary Type data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="ID" type="numeric" required="yes" default="0">
    <cfargument name="excludeID" type="numeric" required="yes" default="0">
    <cfargument name="dtName" type="string" required="yes" default="">
    <cfargument name="dtStatus" type="string" required="yes" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="dtName">
    <cfset var rsDiaryType = "" >
    <cftry>
    <cfquery name="rsDiaryType" datasource="#application.mcmsDSN#">
    SELECT * FROM v_diary_type WHERE 0=0
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND UPPER(dtName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">
    </cfif>
    <cfif ARGUMENTS.ID NEQ 0>
    AND ID = <cfqueryparam value="#ARGUMENTS.ID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.excludeID NEQ 0>
    AND ID <> <cfqueryparam value="#ARGUMENTS.excludeID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.dtName NEQ "">
    AND UPPER(dtName) = <cfqueryparam value="#UCASE(ARGUMENTS.dtName)#" cfsqltype="cf_sql_varchar">
    </cfif>
    AND dtStatus IN (<cfqueryparam value="#ARGUMENTS.dtStatus#" list="yes" cfsqltype="cf_sql_integer">)
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsDiaryType = StructNew()>
    <cfset rsDiaryType.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsDiaryType>
    </cffunction>
    
    <cffunction name="getDiarySiteRel" access="public" returntype="query" hint="Get Diary Site Relationship data.">
    <cfargument name="keywords" type="string" required="no" default="All">
    <cfargument name="ID" type="numeric" required="yes" default="0">
    <cfargument name="dID" type="numeric" required="yes" default="0">
    <cfargument name="siteNo" type="string" required="yes" default="100">
    <cfargument name="dsrStatus" type="string" required="yes" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="siteNo">
	<cfset var rsDiarySiteRel = "" >
    <cftry>
    <cfquery name="rsDiarySiteRel" datasource="#application.mcmsDSN#">
    SELECT * FROM tbl_diary_site_rel WHERE 0=0
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND siteNo LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> 
    </cfif>
    <cfif ARGUMENTS.ID NEQ 0>
    AND ID = <cfqueryparam value="#ARGUMENTS.ID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.dID NEQ 0>
    AND dID = <cfqueryparam value="#ARGUMENTS.dID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.siteNo NEQ 100>
    AND siteNo IN (<cfqueryparam value="#ARGUMENTS.siteNo#" list="yes" cfsqltype="cf_sql_integer">)    
    </cfif>
    AND dsrStatus IN (<cfqueryparam value="#ARGUMENTS.dsrStatus#" list="yes" cfsqltype="cf_sql_integer">)
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsDiarySiteRel = StructNew()>
    <cfset rsDiarySiteRel.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsDiarySiteRel>
    </cffunction>
    
    <cffunction name="getDiaryReport" access="public" returntype="query" hint="Get Diary Report data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="orderBy" type="string" required="yes" default="diaryName">
    <cfset var rsDiaryReport = "" >
    <cftry>
    <cfquery name="rsDiaryReport" datasource="#application.mcmsDSN#">
    SELECT diaryName AS Name, dDescription AS Description, TO_CHAR(dDateRel,'MM/DD/YYYY') AS Release_Date, TO_CHAR(dDateExp,'MM/DD/YYYY') AS Expiration_Date, dEmail AS Email, dtName AS Type, sName AS Status FROM v_diary WHERE 0=0
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(diaryName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(dDescription) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">)
    </cfif>
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsDiaryReport = StructNew()>
    <cfset rsDiaryReport.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsDiaryReport>
    </cffunction>
    
    <cffunction name="getDiaryEntryReport" access="public" returntype="query" hint="Get Diary Entry Report data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="siteNo" type="string" required="yes" default="100">
    <cfargument name="deptNo" type="string" required="yes" default="0">
    <cfargument name="args" type="string" required="yes" default="0,0">
    <cfargument name="orderBy" type="string" required="yes" default="diaryName, dqSort, deDate DESC, siteNo, deptNo">
    <cfset var rsDiaryEntryReport = "" >
    <cftry>
    <cfquery name="rsDiaryEntryReport" datasource="#application.mcmsDSN#">
    SELECT diaryName, userFName || ' ' || userLName AS Username, dqQuestion, deAnswer, TO_CHAR(deDate, 'MM/DD/YYYY') AS Entry_Date, siteNo, deptNo FROM swweb.v_diary_entry WHERE 0=0
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(diaryName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(dqQuestion) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">)
    </cfif>
    <cfif ARGUMENTS.siteNo NEQ 100>
    AND siteNo IN (<cfqueryparam value="#ARGUMENTS.siteNo#" list="yes" cfsqltype="cf_sql_integer">)    
    </cfif>
    <cfif ARGUMENTS.deptNo NEQ 0>
    AND deptNo IN (<cfqueryparam value="#ARGUMENTS.deptNo#" list="yes" cfsqltype="cf_sql_integer">)    
    </cfif>
    <cfif ListGetAt(ARGUMENTS.args, 1) NEQ 0>
    AND deDate >= <cfqueryparam value="#ListGetAt(ARGUMENTS.args, 1)#" cfsqltype="cf_sql_date">
    </cfif>
    <cfif ListGetAt(ARGUMENTS.args, 2) NEQ 0>
    AND deDate <= <cfqueryparam value="#ListGetAt(ARGUMENTS.args, 2)#" cfsqltype="cf_sql_date">
	</cfif>
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsDiaryEntryReport = StructNew()>
    <cfset rsDiaryEntryReport.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsDiaryEntryReport>
    </cffunction>
    
    <cffunction name="getDiaryTypeReport" access="public" returntype="query" hint="Get Diary Type Report data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="orderBy" type="string" required="yes" default="dtName">
    <cfset var rsDiaryTypeReport = "" >
    <cftry>
    <cfquery name="rsDiaryTypeReport" datasource="#application.mcmsDSN#">
    SELECT dtName As Diary_Type, sName As Status FROM v_diary_type WHERE 0=0
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND UPPER(dtName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">
    </cfif>
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsDiaryTypeReport = StructNew()>
    <cfset rsDiaryTypeReport.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsDiaryTypeReport>
    </cffunction>
    
    <cffunction name="getDiaryQuestionReport" access="public" returntype="query" hint="Get Diary Question Report data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="orderBy" type="string" required="yes" default="dqQuestion">
    <cfset var rsDiaryQuestionReport = "" >
    <cftry>
    <cfquery name="rsDiaryQuestionReport" datasource="#application.mcmsDSN#">
    SELECT dqQuestion AS Question, diaryName AS Diary_Name, dqInstruction AS Instructions, DECODE(dqRequired,1,'yes','no') AS Required, dqRequiredMessage AS Required_Message, dqtName AS Type, sName as Status FROM v_diary_question WHERE 0=0
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(dqQuestion) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(dqInstruction) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">)
    </cfif>
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsDiaryQuestionReport = StructNew()>
    <cfset rsDiaryQuestionReport.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsDiaryQuestionReport>
    </cffunction>
    
    <cffunction name="getDiaryQuestionOptionReport" access="public" returntype="query" hint="Get Diary Question Option Report data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="orderBy" type="string" required="yes" default="dID, dqQuestion">
    <cfset var rsDiaryQuestionOptionReport = "" >
    <cftry>
    <cfquery name="rsDiaryQuestionOptionReport" datasource="#application.mcmsDSN#">
    SELECT diaryName, dqoOption AS OptionName, dqQuestion AS Question, dqoInstruction AS Instructions, dqoSort AS Sort, sName AS Status FROM v_diary_question_option WHERE 0=0
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(dqQuestion) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(dqoOption) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">)
    </cfif>
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsDiaryQuestionOptionReport = StructNew()>
    <cfset rsDiaryQuestionOptionReport.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsDiaryQuestionOptionReport>
    </cffunction>
    
    <cffunction name="insertDiaryEntry" access="public" returntype="struct">
    <cfargument name="dID" type="numeric" required="yes">
    <cfargument name="userID" type="numeric" required="yes">
    <cfargument name="dqID" type="numeric" required="yes">
    <cfargument name="deAnswer" type="string" required="yes">
    <cfargument name="deDate" type="string" required="yes">
    <cfargument name="deStatus" type="numeric" required="yes">
    <cfargument name="diaryName" type="string" required="yes" default="">
    <cfargument name="dEmail" type="string" required="yes" default="">
    <!---Get the question count to send only one email.--->
    <cfargument name="questionTotal" type="numeric" required="yes" default="0">
    <cfargument name="questionCount" type="numeric" required="yes" default="0">
    <!---Relationships.--->
    <cfargument name="siteNo" type="numeric" required="yes" default="100">
    <cfargument name="deptNo" type="string" required="yes" default="0">
    <cfset result.message = "Thank you for completing the #ARGUMENTS.diaryName# entry.">
    <cfset result.status = true>
    <cftry>
    <!---Make sure the deptNo is a single number.--->
    <cfset ARGUMENTS.deptNo = ListFirst(ARGUMENTS.deptNo)>
    <!---Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.app.diary.Dairy"
    method="getDiaryEntry"
    returnvariable="getCheckDiaryEntryRet">
    <cfinvokeargument name="dID" value="#ARGUMENTS.dID#"/>
    <cfinvokeargument name="userID" value="#ARGUMENTS.userID#"/>
    <cfinvokeargument name="siteNo" value="#ARGUMENTS.siteNo#"/>
    <cfinvokeargument name="deptNo" value="#ARGUMENTS.deptNo#"/>
    <cfinvokeargument name="deDate" value="#DateFormat(ARGUMENTS.deDate, application.dateFormat)#"/>
    <cfinvokeargument name="dqID" value="#ARGUMENTS.dqID#"/>
    <cfinvokeargument name="deStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckDiaryEntryRet.recordcount NEQ 0>
    <cfset result.message = "You may have already completed the diary entry for this date, please try again.">
	<cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    INSERT INTO tbl_diary_entry (deID,dID,userID,siteNo,deptNo,dqID,deAnswer,deDate,deStatus) VALUES
    (
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.siteNo#|#ARGUMENTS.dID#|#ARGUMENTS.userID#|#ARGUMENTS.deDate#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.dID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.userID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.siteNo#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.deptNo#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.dqID#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.deAnswer#">,
    <cfqueryparam cfsqltype="cf_sql_date" value="#ARGUMENTS.deDate#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.deStatus#">
    )
    </cfquery>
    </cftransaction>
    <!---Send an email notification.--->
    <cfif ARGUMENTS.questionTotal EQ ARGUMENTS.questionCount>
    <!---Get the users information.--->
    <cfinvoke 
    component="MCMS.component.cms.User"
    method="getUser"
    returnvariable="getUserRet">
    <cfinvokeargument name="ID" value="#ARGUMENTS.userID#"/>
    <cfinvokeargument name="userStatus" value="1,2,3"/>
    </cfinvoke>
    <!---Get site information.--->
    <cfinvoke 
    component="MCMS.component.app.site.Site"
    method="getSite"
    returnvariable="getSiteRet">
    <cfinvokeargument name="siteNo" value="#ARGUMENTS.siteNo#"/>
    <cfinvokeargument name="siteStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getSiteRet.recordcount EQ 0>
    <cfset this.siteName = 'All Sites'>
    <cfelse>
    <cfset this.siteName = getSiteRet.siteName>
    </cfif>
    <cfset this.emailContent = 
	"
	#getUserRet.userFName# #getUserRet.userLName#, thank you for completing your #ARGUMENTS.diaryName# entry for #this.siteName# No.#ARGUMENTS.siteNo# for #ARGUMENTS.deDate#.<br/><br/>
	"
	>
    <cfinvoke 
    component="MCMS.component.utility.Email"
    method="sendEmail">
    <cfinvokeargument name="subject" value="#application.companyName# #ARGUMENTS.diaryName# Entry Completed!"/>
    <cfinvokeargument name="to" value="#getUserRet.userEmail#"/>
    <cfinvokeargument name="from" value="#application.noReplyEmail#"/>
    <cfinvokeargument name="cc" value=""/>
    <cfinvokeargument name="bcc" value=""/>
    <cfinvokeargument name="body" value="#this.emailContent#"/>
    <cfinvokeargument name="emailType" value="html"/>
    <cfinvokeargument name="type" value="public"/>
    </cfinvoke>
    <cfset this.emailContent = 
	"
	#getUserRet.userFName# #getUserRet.userLName#, has completed a #ARGUMENTS.diaryName# entry for #this.siteName# No.#ARGUMENTS.siteNo# for #ARGUMENTS.deDate#.<br><br>
	Visit the <a href='//#CGI.SERVER_NAME#/#application.mcmsAppAdminPath#/'>Diary</a> application to view the results.
	"
	>
    <cfif ARGUMENTS.dEmail NEQ ''>
    <cfinvoke 
    component="MCMS.component.utility.Email"
    method="sendEmail">
    <cfinvokeargument name="subject" value="#application.companyName# #ARGUMENTS.diaryName# Entry Completed!"/>
    <cfinvokeargument name="to" value="#ARGUMENTS.dEmail#"/>
    <cfinvokeargument name="from" value="#application.noReplyEmail#"/>
    <cfinvokeargument name="cc" value=""/>
    <cfinvokeargument name="bcc" value=""/>
    <cfinvokeargument name="body" value="#this.emailContent#"/>
    <cfinvokeargument name="emailType" value="html"/>
    <cfinvokeargument name="type" value="public"/>
    </cfinvoke>
    </cfif>
    </cfif>
    </cfif>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset result.message = "There was an error inserting the record.">
	<cfset result.status = false>
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="insertDiary" access="public" returntype="struct">
    <cfargument name="diaryName" type="string" required="yes">
    <cfargument name="dDescription" type="string" required="yes">
    <cfargument name="dDateRel" type="date" required="yes">
    <cfargument name="dDateExp" type="date" required="yes">
    <cfargument name="dEmail" type="string" required="yes">
    <cfargument name="dtID" type="numeric" required="yes">
    <cfargument name="dStatus" type="numeric" required="yes">
    <!---Relationship arguments.--->
    <cfargument name="siteNo" type="string" required="yes">
    <cfargument name="urID" type="string" required="yes">
    <cfset result.message = "You have successfully inserted the record.">
    <cftry>
    <!---Check for profanity in the text.--->
    <cfinvoke 
    component="MCMS.component.utility.Regex"
    method="regexProfanity"
    returnvariable="regexProfanityRet">
    <cfinvokeargument name="profanityString" value="#ARGUMENTS.dDescription#"/>
    </cfinvoke>
    <!---Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.app.diary.Dairy"
    method="getDiary"
    returnvariable="getCheckDiaryRet">
    <cfinvokeargument name="diaryName" value="#ARGUMENTS.diaryName#"/>
    <cfinvokeargument name="dDescription" value="#ARGUMENTS.dDescription#"/>
    <cfinvokeargument name="dStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckDiaryRet.recordcount NEQ 0>
    <cfset result.message = "The name #ARGUMENTS.diaryName# already exists, please try again.">
    <cfelseif regexProfanityRet CONTAINS '$%&*!'>
    <cfset result.message = "Some text contained profanity, please remove any profanity from your text.">
    <!---Check length restriction.--->
    <cfelseif LEN(ARGUMENTS.dDescription) GT 1024>
    <cfset result.message = "The description is longer than 1024 characters, please enter a new description under 1024 characters.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    INSERT INTO tbl_diary (dName,dDescription,dDateRel,dDateExp,dEmail,dtID,dStatus) VALUES
    (
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.diaryName#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.dDescription#">,
    <cfqueryparam cfsqltype="cf_sql_date" value="#ARGUMENTS.dDateRel#">,
    <cfqueryparam cfsqltype="cf_sql_date" value="#ARGUMENTS.dDateExp#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.dEmail#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.dtID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.dStatus#">
    )
    </cfquery>
    </cftransaction>
    <!---Get the dID just added.--->
    <cfinvoke 
    component="MCMS.component.app.diary.Dairy"
    method="getDiary"
    returnvariable="getDiaryIDRet">
    <cfinvokeargument name="diaryName" value="#ARGUMENTS.diaryName#"/>
    <cfinvokeargument name="dStatus" value="1,2,3"/>
    </cfinvoke>    
    <cfset this.dID = getDiaryIDRet.ID>
    <!---Create relationships.--->
    <cfloop index="siteNo" list="#ARGUMENTS.siteNo#">
    <cfinvoke 
    component="MCMS.component.app.diary.Dairy"
    method="insertDiarySiteRel"
    returnvariable="insertDiarySiteRelRet">
    <cfinvokeargument name="siteNo" value="#siteNo#"/>
    <cfinvokeargument name="dID" value="#this.dID#"/>
    <cfinvokeargument name="dsrStatus" value="1"/>
    </cfinvoke>
    </cfloop>
    <cfloop index="urID" list="#ARGUMENTS.urID#">
    <cfinvoke 
    component="MCMS.component.app.diary.Dairy"
    method="insertDiaryUserRoleRel"
    returnvariable="insertDiaryUserRoleRelRet">
    <cfinvokeargument name="urID" value="#urID#"/>
    <cfinvokeargument name="dID" value="#this.dID#"/>
    <cfinvokeargument name="durrStatus" value="1"/>
    </cfinvoke>
    </cfloop>
    </cfif>
    <cfcatch type="any">
    <cfset result.message = "There was an error inserting the record.">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="insertDiaryType" access="public" returntype="struct">
    <cfargument name="dtName" type="string" required="yes">
    <cfargument name="dtStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully inserted the record.">
    <cftry>
    <!---Check for profanity in the text.--->
    <cfinvoke 
    component="MCMS.component.utility.Regex"
    method="regexProfanity"
    returnvariable="regexProfanityRet">
    <cfinvokeargument name="profanityString" value="#ARGUMENTS.dtName#"/>
    </cfinvoke>
    <!---Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.app.diary.Dairy"
    method="getDiaryType"
    returnvariable="getCheckDiaryTypeRet">
    <cfinvokeargument name="dtName" value="#ARGUMENTS.dtName#"/>
    <cfinvokeargument name="dtStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckDiaryTypeRet.recordcount NEQ 0>
    <cfset result.message = "The name #ARGUMENTS.dtName# already exists, please enter a new name.">
    <cfelseif regexProfanityRet CONTAINS '$%&*!'>
    <cfset result.message = "Some text contained profanity, please remove any profanity from your text.">
    <!---Check length restriction.--->
    <cfelseif LEN(ARGUMENTS.dtName) GT 32>
    <cfset result.message = "The name is longer than 32 characters, please enter a new description under 32 characters.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    INSERT INTO tbl_diary_type (dtName,dtStatus) VALUES
    (
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.dtName#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.dtStatus#">
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
    
    <cffunction name="insertDiarySiteRel" access="public" returntype="struct">
    <cfargument name="dID" type="numeric" required="yes">
    <cfargument name="siteNo" type="numeric" required="yes">
    <cfargument name="dsrStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully inserted the record.">
    <cftry>
	<!---Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.app.diary.Dairy"
    method="getDiarySiteRel"
    returnvariable="getCheckDiarySiteRelRet">
    <cfinvokeargument name="dID" value="#ARGUMENTS.dID#"/>
    <cfinvokeargument name="siteNo" value="#ARGUMENTS.siteNo#"/>
    <cfinvokeargument name="dsrStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckDiarySiteRelRet.recordcount NEQ 0>
    <cfset result.message = "The diary site relationship already exists, please try again.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    INSERT INTO tbl_diary_site_rel (dID,siteNo,dsrStatus) VALUES
    (
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.dID#">,
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
    
    <cffunction name="insertDiaryUserRoleRel" access="public" returntype="struct">
    <cfargument name="dID" type="numeric" required="yes">
    <cfargument name="urID" type="numeric" required="yes">
    <cfargument name="durrStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully inserted the record.">
    <cftry>
	<!---Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.app.diary.Dairy"
    method="getDiaryUserRoleRel"
    returnvariable="getCheckDiaryUserRoleRelRet">
    <cfinvokeargument name="dID" value="#ARGUMENTS.dID#"/>
    <cfinvokeargument name="urID" value="#ARGUMENTS.urID#"/>
    <cfinvokeargument name="durrStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckDiaryUserRoleRelRet.recordcount NEQ 0>
    <cfset result.message = "The diary user role relationship already exists, please try again.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    INSERT INTO tbl_diary_user_role_rel (dID,urID,durrStatus) VALUES
    (
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.dID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.urID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.durrStatus#">
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
    
    <cffunction name="insertDiaryQuestion" access="public" returntype="struct">
    <cfargument name="dID" type="numeric" required="yes">
    <cfargument name="dqQuestion" type="string" required="yes">
    <cfargument name="dqInstruction" type="string" required="yes">
    <cfargument name="dqRequired" type="numeric" required="yes">
    <cfargument name="dqRequiredMessage" type="string" required="yes">
    <cfargument name="siteNo" type="string" required="yes">
    <cfargument name="deptNo" type="string" required="yes">
    <cfargument name="dqPageNo" type="numeric" required="yes">
    <cfargument name="dqtID" type="numeric" required="yes">
    <cfargument name="dqrtID" type="numeric" required="yes">
    <cfargument name="dqSort" type="numeric" required="yes">
    <cfargument name="dqStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully inserted the record.">
    <cftry>
    <!---Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.app.diary.Dairy"
    method="getDiaryQuestion"
    returnvariable="getCheckDiaryQuestionRet">
    <cfinvokeargument name="dqQuestion" value="#ARGUMENTS.dqQuestion#"/>
    <cfinvokeargument name="dqStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckDiaryQuestionRet.recordcount NEQ 0>
    <cfset result.message = "The question entered already exists, please try again.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    INSERT INTO tbl_diary_question (dID,dqQuestion,dqInstruction,dqRequired,dqRequiredMessage,dqPageNo,dqtID,dqrtID,dqSort,dqStatus) VALUES
    (
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.dID#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.dqQuestion#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.dqInstruction#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.dqRequired#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.dqRequiredMessage#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.dqPageNo#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.dqtID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.dqrtID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.dqSort#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.dqStatus#">
    )
    </cfquery>
    <!---Get the dqID just added.--->
    <cfinvoke 
    component="MCMS.component.app.diary.Dairy"
    method="getDiaryQuestion"
    returnvariable="getDiaryQuestionIDRet">
    <cfinvokeargument name="dqQuestion" value="#ARGUMENTS.dqQuestion#"/>
    <cfinvokeargument name="dqStatus" value="1,2,3"/>
    </cfinvoke>    
    <cfset this.dqID = getDiaryQuestionIDRet.ID>
    <!---Create site relationships.--->
    <cfloop index="siteNo" list="#ARGUMENTS.siteNo#">
    <cfinvoke 
    component="MCMS.component.app.diary.Dairy"
    method="insertDiaryQuestionSiteRel"
    returnvariable="insertDiaryQuestionSiteRelRet">
    <cfinvokeargument name="siteNo" value="#siteNo#"/>
    <cfinvokeargument name="dqID" value="#this.dqID#"/>
    <cfinvokeargument name="dqsrStatus" value="1"/>
    </cfinvoke>
    </cfloop>
    <!---Create department relationships.--->
    <cfloop index="deptNo" list="#ARGUMENTS.deptNo#">
    <cfinvoke 
    component="MCMS.component.app.diary.Dairy"
    method="insertDiaryQuestionDepartmentRel"
    returnvariable="insertDiaryQuestionDepartmentRelRet">
    <cfinvokeargument name="deptNo" value="#deptNo#"/>
    <cfinvokeargument name="dqID" value="#this.dqID#"/>
    <cfinvokeargument name="dqdrStatus" value="1"/>
    </cfinvoke>
    </cfloop>
    </cftransaction>
    </cfif>
    <cfcatch type="any">
    <cfset result.message = "There was an error inserting the record.">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="insertDiaryQuestionSiteRel" access="public" returntype="struct">
    <cfargument name="dqID" type="numeric" required="yes">
    <cfargument name="siteNo" type="numeric" required="yes">
    <cfargument name="dqsrStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully inserted the record.">
    <cftry>
	<!---Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.app.diary.Dairy"
    method="getDiaryQuestionSiteRel"
    returnvariable="getCheckDiaryQuestionSiteRelRet">
    <cfinvokeargument name="dqID" value="#ARGUMENTS.dqID#"/>
    <cfinvokeargument name="siteNo" value="#ARGUMENTS.siteNo#"/>
    <cfinvokeargument name="dqsrStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckDiaryQuestionSiteRelRet.recordcount NEQ 0>
    <cfset result.message = "The diary question site relationship already exists, please try again.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    INSERT INTO tbl_diary_question_site_rel (dqID,siteNo,dqsrStatus) VALUES
    (
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.dqID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.siteNo#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.dqsrStatus#">
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
    
    <cffunction name="insertDiaryQuestionDepartmentRel" access="public" returntype="struct">
    <cfargument name="dqID" type="numeric" required="yes">
    <cfargument name="deptNo" type="numeric" required="yes">
    <cfargument name="dqdrStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully inserted the record.">
    <cftry>
	<!---Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.app.diary.Dairy"
    method="getDiaryQuestionDepartmentRel"
    returnvariable="getCheckDiaryQuestionDepartmentRelRet">
    <cfinvokeargument name="dqID" value="#ARGUMENTS.dqID#"/>
    <cfinvokeargument name="deptNo" value="#ARGUMENTS.deptNo#"/>
    <cfinvokeargument name="dqdrStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckDiaryQuestionDepartmentRelRet.recordcount NEQ 0>
    <cfset result.message = "The diary question department relationship already exists, please try again.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    INSERT INTO tbl_diary_question_dept_rel (dqID,deptNo,dqdrStatus) VALUES
    (
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.dqID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.deptNo#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.dqdrStatus#">
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
    
    <cffunction name="insertDiaryQuestionOption" access="public" returntype="struct">
    <cfargument name="dqID" type="numeric" required="yes">
    <cfargument name="dqoOption" type="string" required="yes">
    <cfargument name="dqoInstruction" type="string" required="yes">
    <cfargument name="dqoSort" type="numeric" required="yes">
    <cfargument name="dqoStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully inserted the record.">
    <cftry>
    <!---Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.app.diary.Dairy"
    method="getDiaryQuestionOption"
    returnvariable="getCheckDiaryQuestionOptionRet">
    <cfinvokeargument name="dqID" value="#ARGUMENTS.dqID#"/>
    <cfinvokeargument name="dqoOption" value="#ARGUMENTS.dqoOption#"/>
    <cfinvokeargument name="dqoStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckDiaryQuestionOptionRet.recordcount NEQ 0>
    <cfset result.message = "The question option entered already exists, please try again.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    INSERT INTO tbl_diary_question_option (dqID,dqoOption,dqoInstruction,dqoSort,dqoStatus) VALUES
    (
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.dqID#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.dqoOption#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.dqoInstruction#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.dqoSort#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.dqoStatus#">
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
    
    <cffunction name="updateDiary" access="public" returntype="struct">
    <cfargument name="ID" type="numeric" required="yes">
    <cfargument name="diaryName" type="string" required="yes">
    <cfargument name="dDescription" type="string" required="yes">
    <cfargument name="dDateRel" type="date" required="yes">
    <cfargument name="dDateExp" type="date" required="yes">
    <cfargument name="dEmail" type="string" required="yes">
    <cfargument name="dtID" type="numeric" required="yes">
    <cfargument name="dStatus" type="numeric" required="yes">
    <!---Relationship arguments.--->
    <cfargument name="siteNo" type="string" required="yes">
    <cfargument name="urID" type="string" required="yes">
    <cfset result.message = "You have successfully updated the record.">
    <cftry>
    <!---Check for profanity in the text.--->
    <cfinvoke 
    component="MCMS.component.utility.Regex"
    method="regexProfanity"
    returnvariable="regexProfanityRet">
    <cfinvokeargument name="profanityString" value="#ARGUMENTS.dDescription#"/>
    </cfinvoke>
    <!---Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.app.diary.Dairy"
    method="getDiary"
    returnvariable="getCheckDiaryRet">
    <cfinvokeargument name="excludeID" value="#ARGUMENTS.ID#"/>
    <cfinvokeargument name="diaryName" value="#ARGUMENTS.diaryName#"/>
    <cfinvokeargument name="dDescription" value="#ARGUMENTS.dDescription#"/>
    <cfinvokeargument name="dStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckDiaryRet.recordcount NEQ 0>
    <cfset result.message = "The name #ARGUMENTS.diaryName# already exists, please try again.">
    <cfelseif regexProfanityRet CONTAINS '$%&*!'>
    <cfset result.message = "Some text contained profanity, please remove any profanity from your text.">
    <!---Check length restriction.--->
    <cfelseif LEN(ARGUMENTS.dDescription) GT 1024>
    <cfset result.message = "The description is longer than 1024 characters, please enter a new description under 1024 characters.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_diary SET
    dName = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.diaryName#">,
    dDescription = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.dDescription#">,
    dDateRel = <cfqueryparam cfsqltype="cf_sql_date" value="#ARGUMENTS.dDateRel#">,
    dDateExp = <cfqueryparam cfsqltype="cf_sql_date" value="#ARGUMENTS.dDateExp#">,
    dEmail = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.dEmail#">,
    dtID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.dtID#">,
    dStatus = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.dStatus#">
    WHERE ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ID#">
    </cfquery>
    </cftransaction>
    <!---Delete any existing relationships.--->
    <cfinvoke 
    component="MCMS.component.app.diary.Dairy"
    method="deleteDiarySiteRel"
    returnvariable="deleteDiarySiteRelRet">
    <cfinvokeargument name="dID" value="#ARGUMENTS.ID#"/>
    </cfinvoke>
    <cfinvoke 
    component="MCMS.component.app.diary.Dairy"
    method="deleteDiaryUserRoleRel"
    returnvariable="deleteDiaryUserRoleRelRet">
    <cfinvokeargument name="dID" value="#ARGUMENTS.ID#"/>
    </cfinvoke>
    <!---Create relationships.--->
    <cfloop index="siteNo" list="#ARGUMENTS.siteNo#">
    <cfinvoke 
    component="MCMS.component.app.diary.Dairy"
    method="insertDiarySiteRel"
    returnvariable="insertDiarySiteRelRet">
    <cfinvokeargument name="dID" value="#ARGUMENTS.ID#"/>
    <cfinvokeargument name="siteNo" value="#siteNo#"/>
    <cfinvokeargument name="dsrStatus" value="1"/>
    </cfinvoke>
    </cfloop>
    <cfloop index="urID" list="#ARGUMENTS.urID#">
    <cfinvoke 
    component="MCMS.component.app.diary.Dairy"
    method="insertDiaryUserRoleRel"
    returnvariable="insertDiaryUserRoleRelRet">
    <cfinvokeargument name="dID" value="#ARGUMENTS.ID#"/>
    <cfinvokeargument name="urID" value="#urID#"/>
    <cfinvokeargument name="durrStatus" value="1"/>
    </cfinvoke>
    </cfloop>
    </cfif>
    <cfcatch type="any">
    <cfset result.message = "There was an error updating the record.">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="updateDiaryEntry" access="public" returntype="struct">
    <cfargument name="deID" type="string" required="yes">
    <cfargument name="userID" type="numeric" required="yes">
    <cfargument name="dqID" type="numeric" required="yes">
    <cfargument name="deAnswer" type="string" required="yes">
    <cfargument name="deStatus" type="numeric" required="yes">
    <cfargument name="diaryName" type="string" required="yes" default="">
    <cfargument name="deDate" type="string" required="yes" default="">
    <cfargument name="dEmail" type="string" required="yes" default="">
    <!---Get the question count to send only one email.--->
    <cfargument name="questionTotal" type="numeric" required="yes" default="0">
    <cfargument name="questionCount" type="numeric" required="yes" default="0">
    <cfargument name="siteNo" type="numeric" required="yes" default="100">
    <cfset result.message = "Thank you for updating the #ARGUMENTS.diaryName# entry.">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_diary_entry SET
    deAnswer = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.deAnswer#">,
    deStatus = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.deStatus#">
    WHERE deID = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.deID#"> AND dqID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.dqID#">
    </cfquery>
    </cftransaction>
    <!---Send an email notification.--->
    <cfif ARGUMENTS.questionTotal EQ ARGUMENTS.questionCount>
    <!---Get the users information.--->
    <cfinvoke 
    component="MCMS.component.cms.User"
    method="getUser"
    returnvariable="getUserRet">
    <cfinvokeargument name="ID" value="#ARGUMENTS.userID#"/>
    <cfinvokeargument name="userStatus" value="1,2,3"/>
    </cfinvoke>
    <!---Get site information.--->
    <cfinvoke 
    component="MCMS.component.app.site.Site"
    method="getSite"
    returnvariable="getSiteRet">
    <cfinvokeargument name="siteNo" value="#ARGUMENTS.siteNo#"/>
    <cfinvokeargument name="siteStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getSiteRet.recordcount EQ 0>
    <cfset this.siteName = 'All Sites'>
    <cfelse>
    <cfset this.siteName = getSiteRet.siteName>
    </cfif>
    <cfset this.emailContent = 
	"
	#getUserRet.userFName# #getUserRet.userLName#, has updated a #ARGUMENTS.diaryName# entry for #this.siteName# No.#ARGUMENTS.siteNo# for #ARGUMENTS.deDate#<br><br>
	Visit the <a href='//#CGI.SERVER_NAME#/#application.mcmsAppAdminPath#/'>Diary</a> application to view the results.
	"
	>
    <cfif ARGUMENTS.dEmail NEQ ''>
    <cfinvoke 
    component="MCMS.component.utility.Email"
    method="sendEmail">
    <cfinvokeargument name="subject" value="#application.companyName# #ARGUMENTS.diaryName# Entry Updated!"/>
    <cfinvokeargument name="to" value="#ARGUMENTS.dEmail#"/>
    <cfinvokeargument name="from" value="#application.noReplyEmail#"/>
    <cfinvokeargument name="cc" value=""/>
    <cfinvokeargument name="bcc" value=""/>
    <cfinvokeargument name="body" value="#this.emailContent#"/>
    <cfinvokeargument name="emailType" value="html"/>
    <cfinvokeargument name="type" value="public"/>
    </cfinvoke>
    </cfif>
    </cfif>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset result.message = "There was an error updating the record.">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="updateDiaryType" access="public" returntype="struct">
    <cfargument name="ID" type="numeric" required="yes">
    <cfargument name="dtName" type="string" required="yes">
    <cfargument name="dtStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully updated the record.">
    <cftry>
    <!---Check for profanity in the text.--->
    <cfinvoke 
    component="MCMS.component.utility.Regex"
    method="regexProfanity"
    returnvariable="regexProfanityRet">
    <cfinvokeargument name="profanityString" value="#ARGUMENTS.dtName#"/>
    </cfinvoke>
    <!---Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.app.diary.Dairy"
    method="getDiaryType"
    returnvariable="getCheckDiaryTypeRet">
    <cfinvokeargument name="excludeID" value="#ARGUMENTS.ID#"/>
    <cfinvokeargument name="dtName" value="#ARGUMENTS.dtName#"/>
    <cfinvokeargument name="dtStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckDiaryTypeRet.recordcount NEQ 0>
    <cfset result.message = "The name #ARGUMENTS.dtName# already exists, please enter a new name.">
    <cfelseif regexProfanityRet CONTAINS '$%&*!'>
    <cfset result.message = "Some text contained profanity, please remove any profanity from your text.">
    <!---Check length restriction.--->
    <cfelseif LEN(ARGUMENTS.dtName) GT 32>
    <cfset result.message = "The name is longer than 32 characters, please enter a new description under 32 characters.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_diary_type SET
    dtName = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.dtName#">,
    dtStatus = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.dtStatus#">
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
    
    <cffunction name="updateDiaryQuestion" access="public" returntype="struct">
    <cfargument name="ID" type="numeric" required="yes">
    <cfargument name="dID" type="numeric" required="yes">
    <cfargument name="dqQuestion" type="string" required="yes">
    <cfargument name="dqInstruction" type="string" required="yes">
    <cfargument name="dqRequired" type="numeric" required="yes">
    <cfargument name="dqRequiredMessage" type="string" required="yes">
    <cfargument name="dqPageNo" type="numeric" required="yes">
    <cfargument name="dqtID" type="numeric" required="yes">
    <cfargument name="dqrtID" type="numeric" required="yes">
    <cfargument name="dqSort" type="numeric" required="yes">
    <cfargument name="dqStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully updated the record.">
    <cftry>
    <!---Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.app.diary.Dairy"
    method="getDiaryQuestion"
    returnvariable="getCheckDiaryQuestionRet">
    <cfinvokeargument name="excludeID" value="#ARGUMENTS.ID#"/>
    <cfinvokeargument name="dqQuestion" value="#ARGUMENTS.dqQuestion#"/>
    <cfinvokeargument name="dqStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckDiaryQuestionRet.recordcount NEQ 0>
    <cfset result.message = "The question entered already exists, please try again.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_diary_question SET
    dID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.dID#">,
    dqQuestion = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.dqQuestion#">,
    dqInstruction = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.dqInstruction#">,
    dqRequired = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.dqRequired#">,
    dqRequiredMessage = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.dqRequiredMessage#">,
    dqPageNo = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.dqPageNo#">,
    dqtID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.dqtID#">,
    dqrtID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.dqrtID#">,
    dqSort = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.dqSort#">,
    dqStatus = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.dqStatus#">
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
    
    <cffunction name="updateDiaryQuestionOption" access="public" returntype="struct">
    <cfargument name="ID" type="numeric" required="yes">
    <cfargument name="dqID" type="numeric" required="yes">
    <cfargument name="dqoOption" type="string" required="yes">
    <cfargument name="dqoInstruction" type="string" required="yes">
    <cfargument name="dqoSort" type="numeric" required="yes">
    <cfargument name="dqoStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully updated the record.">
    <cftry>
    <!---Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.app.diary.Dairy"
    method="getDiaryQuestionOption"
    returnvariable="getCheckDiaryQuestionOptionRet">
    <cfinvokeargument name="excludeID" value="#ARGUMENTS.ID#"/>
    <cfinvokeargument name="dqID" value="#ARGUMENTS.dqID#"/>
    <cfinvokeargument name="dqoOption" value="#ARGUMENTS.dqoOption#"/>
    <cfinvokeargument name="dqoStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckDiaryQuestionOptionRet.recordcount NEQ 0>
    <cfset result.message = "The question option entered already exists, please try again.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_diary_question_option SET
    dqID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.dqID#">,
    dqoOption = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.dqoOption#">,
    dqoInstruction = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.dqoInstruction#">,
    dqoSort = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.dqoSort#">,
    dqoStatus = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.dqoStatus#">
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
    
    <cffunction name="updateDiaryList" access="public" returntype="struct">
    <cfargument name="ID" type="numeric" required="yes">
    <cfargument name="dStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully updated the records.">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_diary SET
    dStatus = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.dStatus#">
    WHERE ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ID#">
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error updating the records.">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="updateDiaryEntryList" access="public" returntype="struct">
    <cfargument name="ID" type="numeric" required="yes">
    <cfargument name="deStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully updated the records.">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_diary_entry SET
    deStatus = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.deStatus#">
    WHERE ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ID#">
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error updating the records.">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="updateDiaryTypeList" access="public" returntype="struct">
    <cfargument name="ID" type="numeric" required="yes">
    <cfargument name="dtStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully updated the records.">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_diary_type SET
    dtStatus = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.dtStatus#">
    WHERE ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ID#">
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error updating the records.">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="updateDiaryQuestionList" access="public" returntype="struct">
    <cfargument name="ID" type="numeric" required="yes">
    <cfargument name="dqStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully updated the records.">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_diary_question SET
    dqStatus = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.dqStatus#">
    WHERE ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ID#">
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error updating the records.">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="updateDiaryQuestionOptionList" access="public" returntype="struct">
    <cfargument name="ID" type="numeric" required="yes">
    <cfargument name="dqoStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully updated the records.">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_diary_question_option SET
    dqoStatus = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.dqoStatus#">
    WHERE ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ID#">
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error updating the records.">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="deleteDiary" access="public" returntype="struct">
    <cfargument name="ID" type="string" required="yes">
    <cfset result.message = "You have successfully deleted the record(s).">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    DELETE FROM tbl_diary
    WHERE ID IN (<cfqueryparam cfsqltype="cf_sql_integer" list="yes" value="#ARGUMENTS.ID#">)
    </cfquery>
    <cfinvoke 
    component="MCMS.component.app.diary.Dairy"
    method="deleteDiaryEntry">
    <cfinvokeargument name="dID" value="#ARGUMENTS.ID#"/>
    </cfinvoke>
    <cfinvoke 
    component="MCMS.component.app.diary.Dairy"
    method="deleteDiarySiteRel">
    <cfinvokeargument name="dID" value="#ARGUMENTS.ID#"/>
    </cfinvoke>
    <cfinvoke 
    component="MCMS.component.app.diary.Dairy"
    method="deleteDiaryQuestion">
    <cfinvokeargument name="dID" value="#ARGUMENTS.ID#"/>
    </cfinvoke>
    <cfinvoke 
    component="MCMS.component.app.diary.Dairy"
    method="deleteDiaryUserRoleRel">
    <cfinvokeargument name="dID" value="#ARGUMENTS.ID#"/>
    </cfinvoke>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error deleting the record(s).">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="deleteDiaryEntry" access="public" returntype="struct">
    <cfargument name="ID" type="string" required="yes">
    <cfset result.message = "You have successfully deleted the record(s).">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    DELETE FROM tbl_diary_entry
    WHERE ID IN (<cfqueryparam cfsqltype="cf_sql_integer" list="yes" value="#ARGUMENTS.ID#">)
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error deleting the record(s).">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="deleteDiaryType" access="public" returntype="struct">
    <cfargument name="ID" type="string" required="yes">
    <cfset result.message = "You have successfully deleted the record(s).">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    DELETE FROM tbl_diary_type
    WHERE ID IN (<cfqueryparam cfsqltype="cf_sql_integer" list="yes" value="#ARGUMENTS.ID#">)
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error deleting the record(s).">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>   
    
    <cffunction name="deleteDiarySiteRel" access="public" returntype="struct">
    <cfargument name="ID" type="string" required="yes" default="0">
    <cfargument name="dID" type="string" required="yes" default="0">
    <cfset result.message = "You have successfully deleted the record(s).">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    DELETE FROM tbl_diary_site_rel
    WHERE ID IN (<cfqueryparam cfsqltype="cf_sql_integer" list="yes" value="#ARGUMENTS.ID#">)
    OR dID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.dID#">
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error deleting the record(s).">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="deleteDiaryUserRoleRel" access="public" returntype="struct">
    <cfargument name="ID" type="string" required="yes" default="0">
    <cfargument name="dID" type="string" required="yes" default="0">
    <cfset result.message = "You have successfully deleted the record(s).">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    DELETE FROM tbl_diary_user_role_rel
    WHERE ID IN (<cfqueryparam cfsqltype="cf_sql_integer" list="yes" value="#ARGUMENTS.ID#">)
    OR dID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.dID#">
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error deleting the record(s).">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="deleteDiaryQuestion" access="public" returntype="struct">
    <cfargument name="ID" type="string" required="yes" default="0">
    <cfargument name="dID" type="string" required="yes" default="0">
    <cfset result.message = "You have successfully deleted the record(s).">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    DELETE FROM tbl_diary_question
    WHERE ID IN (<cfqueryparam cfsqltype="cf_sql_integer" list="yes" value="#ARGUMENTS.ID#">)
    OR dID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.dID#">
    </cfquery>
    </cftransaction>
    <cfinvoke 
    component="MCMS.component.app.diary.Dairy" 
    method="deleteDiaryQuestionOption" 
    returnvariable="result">
    <cfinvokeargument name="dqID" value="#ARGUMENTS.ID#">
    </cfinvoke>
    <cfcatch type="any">
    <cfset result.message = "There was an error deleting the record(s).">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction> 
    
    <cffunction name="deleteDiaryQuestionSiteRel" access="public" returntype="struct">
    <cfargument name="ID" type="string" required="yes" default="0">
    <cfargument name="dqID" type="string" required="yes" default="0">
    <cfset result.message = "You have successfully deleted the record(s).">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    DELETE FROM tbl_diary_question_site_rel
    WHERE ID IN (<cfqueryparam cfsqltype="cf_sql_integer" list="yes" value="#ARGUMENTS.ID#">)
    OR dqID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.dqID#">
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error deleting the record(s).">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="deleteDiaryQuestionDepartmentRel" access="public" returntype="struct">
    <cfargument name="ID" type="string" required="yes" default="0">
    <cfargument name="dqID" type="string" required="yes" default="0">
    <cfset result.message = "You have successfully deleted the record(s).">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    DELETE FROM tbl_diary_question_dept_rel
    WHERE ID IN (<cfqueryparam cfsqltype="cf_sql_integer" list="yes" value="#ARGUMENTS.ID#">)
    OR dqID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.dqID#">
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error deleting the record(s).">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="deleteDiaryQuestionOption" access="public" returntype="struct">
    <cfargument name="ID" type="string" required="yes" default="0">
    <cfargument name="dqID" type="numeric" required="yes" default="0">
    <cfset result.message = "You have successfully deleted the record(s).">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    DELETE FROM tbl_diary_question_option
    WHERE ID IN (<cfqueryparam cfsqltype="cf_sql_integer" list="yes" value="#ARGUMENTS.ID#">)
    OR dqID = <cfqueryparam value="#ARGUMENTS.dqID#" cfsqltype="cf_sql_integer">
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error deleting the record(s).">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction> 
</cfcomponent>