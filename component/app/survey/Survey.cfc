<cfcomponent>
    <cffunction name="getSurvey" access="public" returntype="query" hint="Get Survey data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="sDateRel" type="string" required="yes" default="">
    <cfargument name="sDateExp" type="string" required="yes" default="">
    <cfargument name="ID" type="numeric" required="yes" default="0">
    <cfargument name="excludeID" type="numeric" required="yes" default="0">
    <cfargument name="surveyName" type="string" required="yes" default="">
    <cfargument name="sDescription" type="string" required="yes" default="">
    <cfargument name="sStatus" type="string" required="yes" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="surveyName">
    <cfset var rsSurvey = "" >
    <cftry>
    <cfquery name="rsSurvey" datasource="#application.mcmsDSN#">
    SELECT * FROM v_survey WHERE 0=0
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(surveyName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(sDescription) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">)
    </cfif>
    <cfif ARGUMENTS.sDateRel NEQ "">
    AND sDateRel <= <cfqueryparam value="#ARGUMENTS.sDateRel#" cfsqltype="cf_sql_date">
    </cfif>
    <cfif ARGUMENTS.sDateExp NEQ "">
    AND sDateExp >= <cfqueryparam value="#ARGUMENTS.sDateExp#" cfsqltype="cf_sql_date">
    </cfif>
    <cfif ARGUMENTS.ID NEQ 0>
    AND ID = <cfqueryparam value="#ARGUMENTS.ID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.excludeID NEQ 0>
    AND ID <> <cfqueryparam value="#ARGUMENTS.excludeID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.surveyName NEQ "">
    AND surveyName = <cfqueryparam value="#ARGUMENTS.surveyName#" cfsqltype="cf_sql_varchar">
    </cfif>
    <cfif ARGUMENTS.sDescription NEQ "">
    AND sDescription = <cfqueryparam value="#ARGUMENTS.sDescription#" cfsqltype="cf_sql_varchar">
    </cfif>
    AND sStatus IN (<cfqueryparam value="#ARGUMENTS.sStatus#" list="yes" cfsqltype="cf_sql_integer">)
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsSurvey = StructNew()>
    <cfset rsSurvey.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsSurvey>
    </cffunction>
    
    <cffunction name="getSurveyQuestion" access="public" returntype="query" hint="Get Survey Question data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="ID" type="numeric" required="yes" default="0">
    <cfargument name="excludeID" type="numeric" required="yes" default="0">
    <cfargument name="sqtID" type="string" required="yes" default="">
    <cfargument name="sqQuestion" type="string" required="yes" default="">
    <cfargument name="sqInstruction" type="string" required="yes" default="">
    <cfargument name="sqtStatus" type="string" required="no" default="1">
    <cfargument name="sqStatus" type="string" required="yes" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="sqQuestion">
    <cfset var rsSurveyQuestion = "" >
    <cftry>
    <cfquery name="rsSurveyQuestion" datasource="#application.mcmsDSN#">
    SELECT * FROM v_survey_question WHERE 0=0
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(sqQuestion) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(sqInstruction) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(surveyName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">) 
    </cfif>
    <cfif ARGUMENTS.ID NEQ 0>
    AND ID = <cfqueryparam value="#ARGUMENTS.ID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.excludeID NEQ 0>
    AND ID <> <cfqueryparam value="#ARGUMENTS.excludeID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.sqQuestion NEQ "">
    AND UPPER(sqQuestion) = <cfqueryparam value="#UCASE(ARGUMENTS.sqQuestion)#" cfsqltype="cf_sql_varchar">
    </cfif>
    <cfif ARGUMENTS.sqtID NEQ "">
    AND sqtID IN (<cfqueryparam value="#ARGUMENTS.sqtID#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    AND sqtStatus IN (<cfqueryparam value="#ARGUMENTS.sqtStatus#" list="yes" cfsqltype="cf_sql_integer">)
    AND sqStatus IN (<cfqueryparam value="#ARGUMENTS.sqStatus#" list="yes" cfsqltype="cf_sql_integer">)
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsSurveyQuestion = StructNew()>
    <cfset rsSurveyQuestion.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsSurveyQuestion>
    </cffunction>
    
    <cffunction name="getSurveyQuestionRating" access="public" returntype="query" hint="Get Survey Question Rating data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="ID" type="numeric" required="yes" default="0">
    <cfargument name="excludeID" type="numeric" required="yes" default="0">
    <cfargument name="sqrName" type="string" required="yes" default="">
    <cfargument name="sqrtID" type="numeric" required="yes" default="0">
    <cfargument name="sqrStatus" type="string" required="yes" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="sqrSort">
    <cfset var rsSurveyQuestionRating = "" >
    <cftry>
    <cfquery name="rsSurveyQuestionRating" datasource="#application.mcmsDSN#" cachedwithin="#request.queryCache#">
    SELECT * FROM tbl_survey_question_rating WHERE 0=0
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND UPPER(sqrName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">
    </cfif>
    <cfif ARGUMENTS.ID NEQ 0>
    AND ID = <cfqueryparam value="#ARGUMENTS.ID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.excludeID NEQ 0>
    AND ID <> <cfqueryparam value="#ARGUMENTS.excludeID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.sqrName NEQ "">
    AND UPPER(sqrName) = <cfqueryparam value="#UCASE(ARGUMENTS.sqrName)#" cfsqltype="cf_sql_varchar">
    </cfif>
    <cfif ARGUMENTS.sqrtID NEQ 0>
    AND sqrtID = <cfqueryparam value="#ARGUMENTS.sqrtID#" cfsqltype="cf_sql_integer">
    </cfif>
    AND sqrStatus IN (<cfqueryparam value="#ARGUMENTS.sqrStatus#" list="yes" cfsqltype="cf_sql_integer">)
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsSurveyQuestionRating = StructNew()>
    <cfset rsSurveyQuestionRating.message = "There was an error with the query.">
    <cfif url.mcmsDebug EQ true>
    <cfdump var="#rsSurveyQuestionRating#">
    </cfif>
    </cfcatch>
    </cftry>
    <cfreturn rsSurveyQuestionRating>
    </cffunction>
    
    <cffunction name="getSurveyQuestionRatingType" access="public" returntype="query" hint="Get Survey Question Rating Type data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="ID" type="numeric" required="yes" default="0">
    <cfargument name="sqrtStatus" type="string" required="yes" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="sqrtName">
    <cfset var rsSurveyQuestionRatingType = "" >
    <cftry>
    <cfquery name="rsSurveyQuestionRatingType" datasource="#application.mcmsDSN#">
    SELECT * FROM tbl_survey_q_rating_type WHERE 0=0
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND UPPER(sqrtName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">
    </cfif>
    <cfif ARGUMENTS.ID NEQ 0>
    AND ID = <cfqueryparam value="#ARGUMENTS.ID#" cfsqltype="cf_sql_integer">
    </cfif>
    AND sqrtStatus IN (<cfqueryparam value="#ARGUMENTS.sqrtStatus#" list="yes" cfsqltype="cf_sql_integer">)
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsSurveyQuestionRatingType = StructNew()>
    <cfset rsSurveyQuestionRatingType.message = "There was an error with the query.">
    <cfif url.mcmsDebug EQ true>
    <cfdump var="#rsSurveyQuestionRatingType#">
    </cfif>
    </cfcatch>
    </cftry>
    <cfreturn rsSurveyQuestionRatingType>
    </cffunction>
    
    <cffunction name="getSurveyQuestionOption" access="public" returntype="query" hint="Get Survey Question Option data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="ID" type="numeric" required="yes" default="0">
    <cfargument name="excludeID" type="numeric" required="yes" default="0">
    <cfargument name="sqID" type="numeric" required="yes" default="0">
    <cfargument name="sqoOption" type="string" required="yes" default="">
    <cfargument name="sqStatus" type="string" required="yes" default="1">
    <cfargument name="sqoStatus" type="string" required="yes" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="sqoOption">
    <cfset var rsSurveyQuestionOption = "" >
    <cftry>
    <cfquery name="rsSurveyQuestionOption" datasource="#application.mcmsDSN#">
    SELECT * FROM v_survey_question_option WHERE 0=0
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(sqoOption) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(sqQuestion) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">)
    </cfif>
    <cfif ARGUMENTS.ID NEQ 0>
    AND ID = <cfqueryparam value="#ARGUMENTS.ID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.excludeID NEQ 0>
    AND ID <> <cfqueryparam value="#ARGUMENTS.excludeID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.sqID NEQ 0>
    AND sqID = <cfqueryparam value="#ARGUMENTS.sqID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.sqoOption NEQ "">
    AND sqoOption = <cfqueryparam value="#ARGUMENTS.sqoOption#" cfsqltype="cf_sql_varchar">
    </cfif>
    AND sqStatus IN (<cfqueryparam value="#ARGUMENTS.sqStatus#" list="yes" cfsqltype="cf_sql_integer">)
    AND sqoStatus IN (<cfqueryparam value="#ARGUMENTS.sqoStatus#" list="yes" cfsqltype="cf_sql_integer">)
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsSurveyQuestionOption = StructNew()>
    <cfset rsSurveyQuestionOption.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsSurveyQuestionOption>
    </cffunction>
    
    <cffunction name="getSurveyQuestionType" access="public" returntype="query" hint="Get Survey Question Type data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="ID" type="numeric" required="yes" default="0">
    <cfargument name="bqtStatus" type="string" required="yes" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="sqtName">
    <cfset var rsSurveyQuestionType = "" >
    <cftry>
    <cfquery name="rsSurveyQuestionType" datasource="#application.mcmsDSN#">
    SELECT * FROM tbl_survey_question_type WHERE 0=0
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND UPPER(sqtName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">
    </cfif>
    <cfif ARGUMENTS.ID NEQ 0>
    AND ID = <cfqueryparam value="#ARGUMENTS.ID#" cfsqltype="cf_sql_integer">
    </cfif>
    AND sqtStatus IN (<cfqueryparam value="#ARGUMENTS.sqtStatus#" list="yes" cfsqltype="cf_sql_integer">)
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsSurveyQuestionType = StructNew()>
    <cfset rsSurveyQuestionType.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsSurveyQuestionType>
    </cffunction>
    
    <cffunction name="getSurveyType" access="public" returntype="query" hint="Get Survey Type data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="ID" type="numeric" required="yes" default="0">
    <cfargument name="excludeID" type="numeric" required="yes" default="0">
    <cfargument name="stName" type="string" required="yes" default="">
    <cfargument name="stStatus" type="string" required="yes" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="stName">
    <cfset var rsSurveyType = "" >
    <cftry>
    <cfquery name="rsSurveyType" datasource="#application.mcmsDSN#">
    SELECT * FROM tbl_survey_type WHERE 0=0
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND UPPER(stName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">
    </cfif>
    <cfif ARGUMENTS.ID NEQ 0>
    AND ID = <cfqueryparam value="#ARGUMENTS.ID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.stName NEQ "">
    AND stName = <cfqueryparam value="#ARGUMENTS.stName#" cfsqltype="cf_sql_varchar">
    </cfif>
    AND stStatus IN (<cfqueryparam value="#ARGUMENTS.stStatus#" list="yes" cfsqltype="cf_sql_integer">)
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsSurveyType = StructNew()>
    <cfset rsSurveyType.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsSurveyType>
    </cffunction>
    
    <cffunction name="getSurveySiteRel" access="public" returntype="query" hint="Get Survey Site Relationship data.">
    <cfargument name="keywords" type="string" required="no" default="All">
    <cfargument name="ID" type="numeric" required="yes" default="0">
    <cfargument name="sID" type="numeric" required="yes" default="0">
    <cfargument name="siteNo" type="string" required="yes" default="100">
    <cfargument name="ssrStatus" type="string" required="yes" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="siteNo">
	<cfset var rsSurveySiteRel = "" >
    <cftry>
    <cfquery name="rsSurveySiteRel" datasource="#application.mcmsDSN#">
    SELECT * FROM tbl_survey_site_rel WHERE 0=0
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND siteNo LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> 
    </cfif>
    <cfif ARGUMENTS.ID NEQ 0>
    AND ID = <cfqueryparam value="#ARGUMENTS.ID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.sID NEQ 0>
    AND sID = <cfqueryparam value="#ARGUMENTS.sID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.siteNo NEQ 100>
    AND siteNo IN (<cfqueryparam value="#ARGUMENTS.siteNo#" list="yes" cfsqltype="cf_sql_integer">)    
    </cfif>
    AND ssrStatus IN (<cfqueryparam value="#ARGUMENTS.ssrStatus#" list="yes" cfsqltype="cf_sql_integer">)
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsSurveySiteRel = StructNew()>
    <cfset rsSurveySiteRel.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsSurveySiteRel>
    </cffunction>
    
    <cffunction name="getSurveyImageRel" access="public" returntype="query" hint="Get Survey Image Relationship data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="ID" type="numeric" required="yes" default="0">
    <cfargument name="excludeID" type="numeric" required="yes" default="0">
    <cfargument name="surveyName" type="string" required="yes" default="">
    <cfargument name="sID" type="string" required="yes" default="0">
    <cfargument name="imgID" type="string" required="yes" default="0">
    <cfargument name="sStatus" type="string" required="no" default="1">
    <cfargument name="imgtStatus" type="string" required="no" default="1">
    <cfargument name="imgStatus" type="string" required="no" default="1">
    <cfargument name="sirStatus" type="string" required="yes" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="sName">
    <cfset var rsSurveyImageRel = "" >
    <cftry>
    <cfquery name="rsSurveyImageRel" datasource="#application.mcmsDSN#">
    SELECT * FROM v_survey_image_rel WHERE 0=0
    <cfif ARGUMENTS.ID NEQ 0>
    AND ID = <cfqueryparam value="#ARGUMENTS.ID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.excludeID NEQ 0>
    AND ID <> <cfqueryparam value="#ARGUMENTS.excludeID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(surveyName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(sDescription) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">)
    </cfif>
    <cfif ARGUMENTS.surveyName NEQ "">
    AND UPPER(surveyName) = <cfqueryparam value="#UCASE(ARGUMENTS.surveyName)#" cfsqltype="cf_sql_varchar">
    </cfif>
    <cfif ARGUMENTS.sID NEQ 0>
    AND sID = <cfqueryparam value="#ARGUMENTS.sID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.imgID NEQ 0>
    AND imgID = <cfqueryparam value="#ARGUMENTS.imgID#" cfsqltype="cf_sql_integer">
    </cfif>
    AND sStatus IN (<cfqueryparam value="#ARGUMENTS.sStatus#" list="yes" cfsqltype="cf_sql_integer">)
    AND imgtStatus IN (<cfqueryparam value="#ARGUMENTS.imgtStatus#" list="yes" cfsqltype="cf_sql_integer">)
    AND imgStatus IN (<cfqueryparam value="#ARGUMENTS.imgStatus#" list="yes" cfsqltype="cf_sql_integer">)
    AND sirStatus IN (<cfqueryparam value="#ARGUMENTS.sirStatus#" list="yes" cfsqltype="cf_sql_integer">)
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsSurveyImageRel = StructNew()>
    <cfset rsSurveyImageRel.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsSurveyImageRel>
    </cffunction>
    
    <cffunction name="getSurveyIncentive" access="public" returntype="query" hint="Get Survey Incentive data.">
    <cfargument name="keywords" type="string" required="no" default="All">
    <cfargument name="ID" type="numeric" required="yes" default="0">
    <cfargument name="excludeID" type="numeric" required="yes" default="0">
    <cfargument name="sID" type="numeric" required="yes" default="0">
    <cfargument name="siName" type="string" required="yes" default="">
    <cfargument name="siCode" type="string" required="yes" default="">
    <cfargument name="bID" type="numeric" required="yes" default="0">
    <cfargument name="siDateRel" type="string" required="yes" default="">
    <cfargument name="siDateExp" type="string" required="yes" default="">
    <cfargument name="siStatus" type="string" required="yes" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="siName">
	<cfset var rsSurveyIncentive = "" >
    <cftry>
    <cfquery name="rsSurveyIncentive" datasource="#application.mcmsDSN#">
    SELECT * FROM v_survey_incentive WHERE 0=0
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(siName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(siDescription) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">)
    </cfif>
    <cfif ARGUMENTS.ID NEQ 0>
    AND ID = <cfqueryparam value="#ARGUMENTS.ID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.excludeID NEQ 0>
    AND ID <> <cfqueryparam value="#ARGUMENTS.excludeID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.siName NEQ "">
    AND UPPER(siName) = <cfqueryparam value="#UCASE(ARGUMENTS.siName)#" cfsqltype="cf_sql_varchar">
    </cfif>
    <cfif ARGUMENTS.sID NEQ 0>
    AND sID = <cfqueryparam value="#ARGUMENTS.sID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.siDateRel NEQ "">
    AND siDateRel <= <cfqueryparam value="#ARGUMENTS.siDateRel#" cfsqltype="cf_sql_date">
    </cfif>
    <cfif ARGUMENTS.siDateExp NEQ "">
    AND siDateExp >= <cfqueryparam value="#ARGUMENTS.siDateExp#" cfsqltype="cf_sql_date">
    </cfif>
    AND siStatus IN (<cfqueryparam value="#ARGUMENTS.siStatus#" list="yes" cfsqltype="cf_sql_integer">)
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsSurveyIncentive = StructNew()>
    <cfset rsSurveyIncentive.message = "There was an error with the query.">
    <cfif url.mcmsDebug EQ true>
    <cfdump var="#rsSurveyIncentive#">
    </cfif>
    </cfcatch>
    </cftry>
    <cfreturn rsSurveyIncentive>
    </cffunction>
    
    <cffunction name="getSurveyIncentiveReport" access="public" returntype="query" hint="Get Survey Incentive Report data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="orderBy" type="string" required="yes" default="siName">
    <cfset var rsSurveyIncentiveReport = "" >
    <cftry>
    <cfquery name="rsSurveyIncentiveReport" datasource="#application.mcmsDSN#">
    SELECT siName AS Name, siDescription AS Description, TO_CHAR(siDateRel,'MM/DD/YYYY') AS Release_Date, TO_CHAR(siDateExp,'MM/DD/YYYY') AS Expiration_Date, siCode AS Code, bName AS Banner, sName AS Status FROM v_survey_incentive WHERE 0=0
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(siName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(siDescription) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">)
    </cfif>
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsSurveyIncentiveReport = StructNew()>
    <cfset rsSurveyIncentiveReport.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsSurveyIncentiveReport>
    </cffunction>
    
    <cffunction name="getSurveyReport" access="public" returntype="query" hint="Get Survey Report data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="orderBy" type="string" required="yes" default="surveyName">
    <cfset var rsSurveyReport = "" >
    <cftry>
    <cfquery name="rsSurveyReport" datasource="#application.mcmsDSN#">
    SELECT surveyName AS Name, sDescription AS Description, TO_CHAR(sDateRel,'MM/DD/YYYY') AS Release_Date, TO_CHAR(sDateExp,'MM/DD/YYYY') AS Expiration_Date, sEmail AS Email, stName AS Type, sName AS Status FROM v_survey WHERE 0=0
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(surveyName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(sDescription) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">)
    </cfif>
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsSurveyReport = StructNew()>
    <cfset rsSurveyReport.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsSurveyReport>
    </cffunction>
    
    <cffunction name="getSurveyResultReport" access="public" returntype="query" hint="Get Survey Result Report data.">
    <cfargument name="sID" type="numeric" required="yes" default="0">
    <cfargument name="refID" type="string" required="yes" default="">
    <cfargument name="sqID" type="numeric" required="yes" default="0">
    <cfargument name="srDateStart" type="string" required="yes" default="">
    <cfargument name="srDateEnd" type="string" required="yes" default="">
    <cfargument name="suStateProv" type="string" required="yes" default="">
    <cfargument name="orderBy" type="string" required="yes" default="surveyName">
    <cfargument name="timeOut" type="string" required="yes" default="8000">
    <cfset var rsSurveyResultReport = "" >
    <cftry>
    <cfquery name="rsSurveyResultReport" datasource="#application.mcmsDSN#" cachedwithin="#CreateTimeSpan(0,12,0,0)#" timeout="#ARGUMENTS.timeOut#">
    SELECT sID, surveyName, stName, suName, suEmail, suStateProv, suZipCode, sqQuestion, sqtName, sqoOption, srAnswer, srDate, refID FROM swweb.rv_survey_result WHERE 0=0
    <cfif ARGUMENTS.sID NEQ 0>
    AND sID = <cfqueryparam value="#ARGUMENTS.sID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.refID NEQ "">
    AND refID = <cfqueryparam value="#ARGUMENTS.refID#" cfsqltype="cf_sql_varchar">
    </cfif>
    <cfif ARGUMENTS.sqID NEQ 0>
    AND sqID = <cfqueryparam value="#ARGUMENTS.sqID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.srDateStart NEQ "">
    AND srDate >= <cfqueryparam value="#ARGUMENTS.srDateStart#" cfsqltype="cf_sql_date">
    </cfif>
    <cfif ARGUMENTS.srDateEnd NEQ "">
    AND srDate <= <cfqueryparam value="#ARGUMENTS.srDateEnd#" cfsqltype="cf_sql_date">
	  </cfif>
    <cfif ARGUMENTS.suStateProv NEQ "">
    AND suStateProv = <cfqueryparam value="#ARGUMENTS.suStateProv#" cfsqltype="cf_sql_varchar">
    </cfif>
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsSurveyResultReport = StructNew()>
    <cfset rsSurveyResultReport.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsSurveyResultReport>
  </cffunction>
    
    <cffunction name="getSurveyTypeReport" access="public" returntype="query" hint="Get Survey Type Report data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="orderBy" type="string" required="yes" default="stName">
    <cfset var rsSurveyTypeReport = "" >
    <cftry>
    <cfquery name="rsSurveyTypeReport" datasource="#application.mcmsDSN#">
    SELECT stName As Survey_Type, sName As Status FROM v_survey_type WHERE 0=0
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND UPPER(stName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">
    </cfif>
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsSurveyTypeReport = StructNew()>
    <cfset rsSurveyTypeReport.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsSurveyTypeReport>
    </cffunction>
    
    <cffunction name="getSurveyQuestionReport" access="public" returntype="query" hint="Get Survey Question Report data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="orderBy" type="string" required="yes" default="sqQuestion">
    <cfset var rsSurveyQuestionReport = "" >
    <cftry>
    <cfquery name="rsSurveyQuestionReport" datasource="#application.mcmsDSN#">
    SELECT sqQuestion AS Question, surveyName AS Survey_Name, sqInstruction AS Instructions, DECODE(sqRequired,1,'yes','no') AS Required, sqRequiredMessage AS Required_Message, sqtName AS Type, sName as Status FROM v_survey_question WHERE 0=0
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(sqQuestion) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(sqInstruction) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">)
    </cfif>
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsSurveyQuestionReport = StructNew()>
    <cfset rsSurveyQuestionReport.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsSurveyQuestionReport>
    </cffunction>
    
    <cffunction name="getSurveyQuestionOptionReport" access="public" returntype="query" hint="Get Survey Question Option Report data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="orderBy" type="string" required="yes" default="sqQuestion">
    <cfset var rsSurveyQuestionOptionReport = "" >
    <cftry>
    <cfquery name="rsSurveyQuestionOptionReport" datasource="#application.mcmsDSN#">
    SELECT sqoOption AS OptionName, sqQuestion AS Question, sqoInstruction AS Instructions, sqoSort AS Sort, sName AS Status FROM v_survey_question_option WHERE 0=0
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(sqQuestion) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(sqoOption) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">)
    </cfif>
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsSurveyQuestionOptionReport = StructNew()>
    <cfset rsSurveyQuestionOptionReport.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsSurveyQuestionOptionReport>
    </cffunction>
    
    <cffunction name="getSurveyImageRelReport" access="public" returntype="query" hint="Get Survey Image Relationship Report data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="orderBy" type="string" required="yes" default="surveyName">
    <cfset var rsSurveyImageRelReport = "" >
    <cftry>
    <cfquery name="rsSurveyImageRelReport" datasource="#application.mcmsDSN#">
    SELECT surveyName As Survey_Name, imgName As Image_Name, imgFile As Image_File, imgtWidth As Image_Width, sName As Status FROM v_survey_image_rel WHERE 0=0
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(surveyName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(sDescription) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">)
    </cfif>
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsSurveyImageRelReport = StructNew()>
    <cfset rsSurveyImageRelReport.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsSurveyImageRelReport>
    </cffunction>
    
    <cffunction name="insertSurvey" access="public" returntype="struct">
    <cfargument name="surveyName" type="string" required="yes">
    <cfargument name="sDescription" type="string" required="yes">
    <cfargument name="sDateRel" type="date" required="yes">
    <cfargument name="sDateExp" type="date" required="yes">
    <cfargument name="sEmail" type="string" required="yes">
    <cfargument name="stID" type="numeric" required="yes">
    <cfargument name="sStatus" type="numeric" required="yes">
    <!---Relationship arguments.--->
    <cfargument name="siteNo" type="string" required="yes">
    <cfset result.message = "You have successfully inserted the record.">
    <cftry>
    <!---Check for profanity in the text.--->
    <cfinvoke 
    component="MCMS.component.utility.Regex"
    method="regexProfanity"
    returnvariable="regexProfanityRet">
    <cfinvokeargument name="profanityString" value="#ARGUMENTS.sDescription#"/>
    </cfinvoke>
    <!---Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.app.survey.Survey"
    method="getSurvey"
    returnvariable="getCheckSurveyRet">
    <cfinvokeargument name="surveyName" value="#ARGUMENTS.surveyName#"/>
    <cfinvokeargument name="sDescription" value="#ARGUMENTS.sDescription#"/>
    <cfinvokeargument name="sStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckSurveyRet.recordcount NEQ 0>
    <cfset result.message = "The name #ARGUMENTS.surveyName# already exists, please try again.">
    <cfelseif regexProfanityRet CONTAINS '$%&*!'>
    <cfset result.message = "Some text contained profanity, please remove any profanity from your text.">
    <!---Check length restriction.--->
    <cfelseif LEN(ARGUMENTS.sDescription) GT 1024>
    <cfset result.message = "The description is longer than 1024 characters, please enter a new description under 1024 characters.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    INSERT INTO tbl_survey (sName,sDescription,sDateRel,sDateExp,sEmail,stID,sStatus) VALUES
    (
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.surveyName#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.sDescription#">,
    <cfqueryparam cfsqltype="cf_sql_date" value="#ARGUMENTS.sDateRel#">,
    <cfqueryparam cfsqltype="cf_sql_date" value="#ARGUMENTS.sDateExp#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.sEmail#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.stID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.sStatus#">
    )
    </cfquery>
    </cftransaction>
    <!---Get the sID just added.--->
    <cfinvoke 
    component="MCMS.component.app.survey.Survey"
    method="getSurvey"
    returnvariable="getSurveyIDRet">
    <cfinvokeargument name="surveyName" value="#ARGUMENTS.surveyName#"/>
    <cfinvokeargument name="sStatus" value="1,2,3"/>
    </cfinvoke>    
    <cfset this.sID = getSurveyIDRet.ID>
    <!---Create site relationships.--->
    <cfloop index="siteNo" list="#ARGUMENTS.siteNo#">
    <cfinvoke 
    component="MCMS.component.app.survey.Survey"
    method="insertSurveySiteRel"
    returnvariable="insertSurveySiteRelRet">
    <cfinvokeargument name="siteNo" value="#siteNo#"/>
    <cfinvokeargument name="sID" value="#this.sID#"/>
    <cfinvokeargument name="ssrStatus" value="1"/>
    </cfinvoke>
    </cfloop>
    </cfif>
    <cfcatch type="any">
    <cfset result.message = "There was an error inserting the record.">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="insertSurveyType" access="public" returntype="struct">
    <cfargument name="stName" type="string" required="yes">
    <cfargument name="stStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully inserted the record.">
    <cftry>
    <!---Check for profanity in the text.--->
    <cfinvoke 
    component="MCMS.component.utility.Regex"
    method="regexProfanity"
    returnvariable="regexProfanityRet">
    <cfinvokeargument name="profanityString" value="#ARGUMENTS.stName#"/>
    </cfinvoke>
    <!---Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.app.survey.Survey"
    method="getSurveyType"
    returnvariable="getCheckSurveyTypeRet">
    <cfinvokeargument name="stName" value="#ARGUMENTS.stName#"/>
    <cfinvokeargument name="stStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckSurveyTypeRet.recordcount NEQ 0>
    <cfset result.message = "The name #ARGUMENTS.stName# already exists, please enter a new name.">
    <cfelseif regexProfanityRet CONTAINS '$%&*!'>
    <cfset result.message = "Some text contained profanity, please remove any profanity from your text.">
    <!---Check length restriction.--->
    <cfelseif LEN(ARGUMENTS.stName) GT 32>
    <cfset result.message = "The name is longer than 32 characters, please enter a new description under 32 characters.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    INSERT INTO tbl_survey_type (stName,stStatus) VALUES
    (
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.stName#">,
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
    
    <cffunction name="insertSurveySiteRel" access="public" returntype="struct">
    <cfargument name="sID" type="numeric" required="yes">
    <cfargument name="siteNo" type="numeric" required="yes">
    <cfargument name="ssrStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully inserted the record.">
    <cftry>
	  <!---Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.app.survey.Survey"
    method="getSurveySiteRel"
    returnvariable="getCheckSurveySiteRelRet">
    <cfinvokeargument name="sID" value="#ARGUMENTS.sID#"/>
    <cfinvokeargument name="siteNo" value="#ARGUMENTS.siteNo#"/>
    <cfinvokeargument name="ssrStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckSurveySiteRelRet.recordcount NEQ 0>
    <cfset result.message = "The survey site relationship already exists, please try again.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    INSERT INTO tbl_survey_site_rel (sID,siteNo,ssrStatus) VALUES
    (
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.sID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.siteNo#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ssrStatus#">
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
    
    <cffunction name="insertSurveyImageRel" access="public" returntype="struct">
    <cfargument name="imgID" type="string" required="yes">
    <cfargument name="sID" type="string" required="yes">
    <cfargument name="sirStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully inserted the record.">
    <cftry>
    <!---Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.app.survey.Survey"
    method="getSurveyImageRel"
    returnvariable="getCheckSurveyImageRelRet">
    <cfinvokeargument name="imgID" value="#ARGUMENTS.imgID#"/>
    <cfinvokeargument name="sID" value="#ARGUMENTS.sID#"/>
    <cfinvokeargument name="sirStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckSurveyImageRelRet.recordcount NEQ 0>
    <cfset result.message = "The survey image relationship already exists, please try again.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    INSERT INTO tbl_survey_image_rel (imgID,sID,sirStatus) VALUES
    (
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.imgID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.sID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.sirStatus#">
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
    
    <cffunction name="insertSurveyQuestion" access="public" returntype="struct">
    <cfargument name="sID" type="numeric" required="yes">
    <cfargument name="sqQuestion" type="string" required="yes">
    <cfargument name="sqInstruction" type="string" required="yes">
    <cfargument name="sqRequired" type="numeric" required="yes">
    <cfargument name="sqRequiredMessage" type="string" required="yes">
    <cfargument name="sqPageNo" type="numeric" required="yes">
    <cfargument name="sqtID" type="numeric" required="yes">
    <cfargument name="sqrtID" type="numeric" required="yes">
    <cfargument name="sqSort" type="numeric" required="yes">
    <cfargument name="sqStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully inserted the record.">
    <cftry>
    <!---Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.app.survey.Survey"
    method="getSurveyQuestion"
    returnvariable="getCheckSurveyQuestionRet">
    <cfinvokeargument name="sqQuestion" value="#ARGUMENTS.sqQuestion#"/>
    <cfinvokeargument name="sqStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckSurveyQuestionRet.recordcount NEQ 0>
    <cfset result.message = "The question entered already exists, please try again.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    INSERT INTO tbl_survey_question (sID,sqQuestion,sqInstruction,sqRequired,sqRequiredMessage,sqPageNo,sqtID,sqrtID,sqSort,sqStatus) VALUES
    (
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.sID#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.sqQuestion#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.sqInstruction#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.sqRequired#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.sqRequiredMessage#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.sqPageNo#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.sqtID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.sqrtID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.sqSort#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.sqStatus#">
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
    
    <cffunction name="insertSurveyQuestionOption" access="public" returntype="struct">
    <cfargument name="sqID" type="numeric" required="yes">
    <cfargument name="sqoOption" type="string" required="yes">
    <cfargument name="sqoInstruction" type="string" required="yes">
    <cfargument name="sqoSort" type="numeric" required="yes">
    <cfargument name="sqoStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully inserted the record.">
    <cftry>
    <!---Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.app.survey.Survey"
    method="getSurveyQuestionOption"
    returnvariable="getCheckSurveyQuestionOptionRet">
    <cfinvokeargument name="sqID" value="#ARGUMENTS.sqID#"/>
    <cfinvokeargument name="sqoOption" value="#ARGUMENTS.sqoOption#"/>
    <cfinvokeargument name="sqoStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckSurveyQuestionOptionRet.recordcount NEQ 0>
    <cfset result.message = "The question option entered already exists, please try again.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    INSERT INTO tbl_survey_question_option (sqID,sqoOption,sqoInstruction,sqoSort,sqoStatus) VALUES
    (
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.sqID#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.sqoOption#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.sqoInstruction#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.sqoSort#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.sqoStatus#">
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
    
    <cffunction name="insertSurveyIncentive" access="public" returntype="struct">
    <cfargument name="sID" type="numeric" required="yes">
    <cfargument name="siName" type="string" required="yes">
    <cfargument name="siDescription" type="string" required="yes">
    <cfargument name="siDateRel" type="date" required="yes">
    <cfargument name="siDateExp" type="date" required="yes">
    <cfargument name="siCode" type="string" required="yes">
    <cfargument name="bID" type="numeric" required="yes">
    <cfargument name="siStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully inserted the record.">
    <cftry>
    <!---Check for profanity in the text.--->
    <cfinvoke 
    component="MCMS.component.utility.Regex"
    method="regexProfanity"
    returnvariable="regexProfanityRet">
    <cfinvokeargument name="profanityString" value="#ARGUMENTS.siDescription#"/>
    </cfinvoke>
    <!---Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.app.survey.Survey"
    method="getSurveyIncentive"
    returnvariable="getCheckSurveyIncentiveRet">
    <cfinvokeargument name="siName" value="#ARGUMENTS.siName#"/>
    <cfinvokeargument name="siStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckSurveyIncentiveRet.recordcount NEQ 0>
    <cfset result.message = "The name #ARGUMENTS.siName# already exists, please try again.">
    <cfelseif regexProfanityRet CONTAINS '$%&*!'>
    <cfset result.message = "Some text contained profanity, please remove any profanity from your text.">
    <!---Check length restriction.--->
    <cfelseif LEN(ARGUMENTS.siDescription) GT 1024>
    <cfset result.message = "The description is longer than 1024 characters, please enter a new description under 1024 characters.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    INSERT INTO tbl_survey_incentive (sID,siName,siDescription,siDateRel,siDateExp,siCode,bID,siStatus) VALUES
    (
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.sID#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.siName#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.siDescription#">,
    <cfqueryparam cfsqltype="cf_sql_date" value="#ARGUMENTS.siDateRel#">,
    <cfqueryparam cfsqltype="cf_sql_date" value="#ARGUMENTS.siDateExp#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.siCode#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.bID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.siStatus#">
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
    
    <cffunction name="updateSurvey" access="public" returntype="struct">
    <cfargument name="ID" type="numeric" required="yes">
    <cfargument name="surveyName" type="string" required="yes">
    <cfargument name="sDescription" type="string" required="yes">
    <cfargument name="sDateRel" type="date" required="yes">
    <cfargument name="sDateExp" type="date" required="yes">
    <cfargument name="sEmail" type="string" required="yes">
    <cfargument name="stID" type="numeric" required="yes">
    <cfargument name="sStatus" type="numeric" required="yes">
    <!---Relationship arguments.--->
    <cfargument name="siteNo" type="string" required="yes">
    <cfset result.message = "You have successfully updated the record.">
    <cftry>
    <!---Check for profanity in the text.--->
    <cfinvoke 
    component="MCMS.component.utility.Regex"
    method="regexProfanity"
    returnvariable="regexProfanityRet">
    <cfinvokeargument name="profanityString" value="#ARGUMENTS.sDescription#"/>
    </cfinvoke>
    <!---Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.app.survey.Survey"
    method="getSurvey"
    returnvariable="getCheckSurveyRet">
    <cfinvokeargument name="excludeID" value="#ARGUMENTS.ID#"/>
    <cfinvokeargument name="surveyName" value="#ARGUMENTS.surveyName#"/>
    <cfinvokeargument name="sDescription" value="#ARGUMENTS.sDescription#"/>
    <cfinvokeargument name="sStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckSurveyRet.recordcount NEQ 0>
    <cfset result.message = "The name #ARGUMENTS.surveyName# already exists, please try again.">
    <cfelseif regexProfanityRet CONTAINS '$%&*!'>
    <cfset result.message = "Some text contained profanity, please remove any profanity from your text.">
    <!---Check length restriction.--->
    <cfelseif LEN(ARGUMENTS.sDescription) GT 1024>
    <cfset result.message = "The description is longer than 1024 characters, please enter a new description under 1024 characters.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_survey SET
    sName = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.surveyName#">,
    sDescription = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.sDescription#">,
    sDateRel = <cfqueryparam cfsqltype="cf_sql_date" value="#ARGUMENTS.sDateRel#">,
    sDateExp = <cfqueryparam cfsqltype="cf_sql_date" value="#ARGUMENTS.sDateExp#">,
    sEmail = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.sEmail#">,
    stID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.stID#">,
    sStatus = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.sStatus#">
    WHERE ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ID#">
    </cfquery>
    </cftransaction>
    <!---Delete any existing relationships.--->
    <cfinvoke 
    component="MCMS.component.app.survey.Survey"
    method="deleteSurveySiteRel"
    returnvariable="deleteSurveySiteRelRet">
    <cfinvokeargument name="sID" value="#ARGUMENTS.ID#"/>
    </cfinvoke>
    <!---Create site relationships.--->
    <cfloop index="siteNo" list="#ARGUMENTS.siteNo#">
    <cfinvoke 
    component="MCMS.component.app.survey.Survey"
    method="insertSurveySiteRel"
    returnvariable="insertSurveySiteRelRet">
    <cfinvokeargument name="sID" value="#ARGUMENTS.ID#"/>
    <cfinvokeargument name="siteNo" value="#siteNo#"/>
    <cfinvokeargument name="ssrStatus" value="1"/>
    </cfinvoke>
    </cfloop>
    </cfif>
    <cfcatch type="any">
    <cfset result.message = "There was an error updating the record.">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="updateSurveyType" access="public" returntype="struct">
    <cfargument name="ID" type="numeric" required="yes">
    <cfargument name="stName" type="string" required="yes">
    <cfargument name="stStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully updated the record.">
    <cftry>
    <!---Check for profanity in the text.--->
    <cfinvoke 
    component="MCMS.component.utility.Regex"
    method="regexProfanity"
    returnvariable="regexProfanityRet">
    <cfinvokeargument name="profanityString" value="#ARGUMENTS.stName#"/>
    </cfinvoke>
    <!---Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.app.survey.Survey"
    method="getSurveyType"
    returnvariable="getCheckSurveyTypeRet">
    <cfinvokeargument name="excludeID" value="#ARGUMENTS.ID#"/>
    <cfinvokeargument name="stName" value="#ARGUMENTS.stName#"/>
    <cfinvokeargument name="stStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckSurveyTypeRet.recordcount NEQ 0>
    <cfset result.message = "The name #ARGUMENTS.stName# already exists, please enter a new name.">
    <cfelseif regexProfanityRet CONTAINS '$%&*!'>
    <cfset result.message = "Some text contained profanity, please remove any profanity from your text.">
    <!---Check length restriction.--->
    <cfelseif LEN(ARGUMENTS.stName) GT 32>
    <cfset result.message = "The name is longer than 32 characters, please enter a new description under 32 characters.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_survey_type SET
    stName = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.stName#">,
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
        
    <cffunction name="updateSurveyImageRel" access="public" returntype="struct">
    <cfargument name="ID" type="numeric" required="yes">
    <cfargument name="imgID" type="string" required="yes">
    <cfargument name="sID" type="string" required="yes">
    <cfargument name="sirStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully updated the record.">
    <cftry>
    <!---Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.app.survey.Survey"
    method="getSurveyImageRel"
    returnvariable="getCheckSurveyImageRelRet">
    <cfinvokeargument name="excludeID" value="#ARGUMENTS.ID#"/>
    <cfinvokeargument name="imgID" value="#ARGUMENTS.imgID#"/>
    <cfinvokeargument name="sID" value="#ARGUMENTS.sID#"/>
    <cfinvokeargument name="sirStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckSurveyImageRelRet.recordcount NEQ 0>
    <cfset result.message = "The survey image relationship already exists, please enter a new name.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_survey_image_rel SET
    imgID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.imgID#">,
    sID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.sID#">,
    sirStatus = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.sirStatus#">
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
    
    <cffunction name="updateSurveyQuestion" access="public" returntype="struct">
    <cfargument name="ID" type="numeric" required="yes">
    <cfargument name="sID" type="numeric" required="yes">
    <cfargument name="sqQuestion" type="string" required="yes">
    <cfargument name="sqInstruction" type="string" required="yes">
    <cfargument name="sqRequired" type="numeric" required="yes">
    <cfargument name="sqRequiredMessage" type="string" required="yes">
    <cfargument name="sqPageNo" type="numeric" required="yes">
    <cfargument name="sqtID" type="numeric" required="yes">
    <cfargument name="sqrtID" type="numeric" required="yes">
    <cfargument name="sqSort" type="numeric" required="yes">
    <cfargument name="sqStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully updated the record.">
    <cftry>
    <!---Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.app.survey.Survey"
    method="getSurveyQuestion"
    returnvariable="getCheckSurveyQuestionRet">
    <cfinvokeargument name="excludeID" value="#ARGUMENTS.ID#"/>
    <cfinvokeargument name="sqQuestion" value="#ARGUMENTS.sqQuestion#"/>
    <cfinvokeargument name="sqStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckSurveyQuestionRet.recordcount NEQ 0>
    <cfset result.message = "The question entered already exists, please try again.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_survey_question SET
    sID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.sID#">,
    sqQuestion = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.sqQuestion#">,
    sqInstruction = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.sqInstruction#">,
    sqRequired = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.sqRequired#">,
    sqRequiredMessage = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.sqRequiredMessage#">,
    sqPageNo = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.sqPageNo#">,
    sqtID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.sqtID#">,
    sqrtID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.sqrtID#">,
    sqSort = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.sqSort#">,
    sqStatus = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.sqStatus#">
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
    
    <cffunction name="updateSurveyQuestionOption" access="public" returntype="struct">
    <cfargument name="ID" type="numeric" required="yes">
    <cfargument name="sqID" type="numeric" required="yes">
    <cfargument name="sqoOption" type="string" required="yes">
    <cfargument name="sqoInstruction" type="string" required="yes">
    <cfargument name="sqoSort" type="numeric" required="yes">
    <cfargument name="sqoStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully updated the record.">
    <cftry>
    <!---Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.app.survey.Survey"
    method="getSurveyQuestionOption"
    returnvariable="getCheckSurveyQuestionOptionRet">
    <cfinvokeargument name="excludeID" value="#ARGUMENTS.ID#"/>
    <cfinvokeargument name="sqID" value="#ARGUMENTS.sqID#"/>
    <cfinvokeargument name="sqoOption" value="#ARGUMENTS.sqoOption#"/>
    <cfinvokeargument name="sqoStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckSurveyQuestionOptionRet.recordcount NEQ 0>
    <cfset result.message = "The question option entered already exists, please try again.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_survey_question_option SET
    sqID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.sqID#">,
    sqoOption = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.sqoOption#">,
    sqoInstruction = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.sqoInstruction#">,
    sqoSort = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.sqoSort#">,
    sqoStatus = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.sqoStatus#">
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
    
    <cffunction name="updateSurveyIncentive" access="public" returntype="struct">
    <cfargument name="ID" type="numeric" required="yes">
    <cfargument name="siName" type="string" required="yes">
    <cfargument name="siDescription" type="string" required="yes">
    <cfargument name="siDateRel" type="date" required="yes">
    <cfargument name="siDateExp" type="date" required="yes">
    <cfargument name="siCode" type="string" required="yes">
    <cfargument name="bID" type="numeric" required="yes">
    <cfargument name="siStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully updated the record.">
    <cftry>
    <!---Check for profanity in the text.--->
    <cfinvoke 
    component="MCMS.component.utility.Regex"
    method="regexProfanity"
    returnvariable="regexProfanityRet">
    <cfinvokeargument name="profanityString" value="#ARGUMENTS.siDescription#"/>
    </cfinvoke>
    <!---Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.app.survey.Survey"
    method="getSurveyIncentive"
    returnvariable="getCheckSurveyIncentiveRet">
    <cfinvokeargument name="excludeID" value="#ARGUMENTS.ID#"/>
    <cfinvokeargument name="siName" value="#ARGUMENTS.siName#"/>
    <cfinvokeargument name="siStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckSurveyIncentiveRet.recordcount NEQ 0>
    <cfset result.message = "The name #ARGUMENTS.siName# already exists, please try again.">
    <cfelseif regexProfanityRet CONTAINS '$%&*!'>
    <cfset result.message = "Some text contained profanity, please remove any profanity from your text.">
    <!---Check length restriction.--->
    <cfelseif LEN(ARGUMENTS.siDescription) GT 1024>
    <cfset result.message = "The description is longer than 1024 characters, please enter a new description under 1024 characters.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_survey_incentive SET
    siName = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.siName#">,
    siDescription = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.siDescription#">,
    siDateRel = <cfqueryparam cfsqltype="cf_sql_date" value="#ARGUMENTS.siDateRel#">,
    siDateExp = <cfqueryparam cfsqltype="cf_sql_date" value="#ARGUMENTS.siDateExp#">,
    siCode = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.siCode#">,
    bID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.bID#">,
    siStatus = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.siStatus#">
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
    
    <cffunction name="updateSurveyList" access="public" returntype="struct">
    <cfargument name="ID" type="numeric" required="yes">
    <cfargument name="sStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully updated the records.">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_survey SET
    sStatus = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.sStatus#">
    WHERE ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ID#">
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error updating the records.">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="updateSurveyTypeList" access="public" returntype="struct">
    <cfargument name="ID" type="numeric" required="yes">
    <cfargument name="stStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully updated the records.">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_survey_type SET
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
    
    <cffunction name="updateSurveyImageRelList" access="public" returntype="struct">
    <cfargument name="ID" type="numeric" required="yes">
    <cfargument name="sirStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully updated the records.">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_survey_image_rel SET
    sirStatus = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.sirStatus#">
    WHERE ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ID#">
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error updating the records.">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="updateSurveyQuestionList" access="public" returntype="struct">
    <cfargument name="ID" type="numeric" required="yes">
    <cfargument name="sqStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully updated the records.">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_survey_question SET
    sqStatus = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.sqStatus#">
    WHERE ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ID#">
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error updating the records.">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="updateSurveyQuestionOptionList" access="public" returntype="struct">
    <cfargument name="ID" type="numeric" required="yes">
    <cfargument name="sqoStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully updated the records.">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_survey_question_option SET
    sqoStatus = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.sqoStatus#">
    WHERE ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ID#">
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error updating the records.">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="updateSurveyIncentiveList" access="public" returntype="struct">
    <cfargument name="ID" type="numeric" required="yes">
    <cfargument name="siStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully updated the records.">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_survey_incentive SET
    siStatus = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.siStatus#">
    WHERE ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ID#">
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error updating the records.">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="deleteSurvey" access="public" returntype="struct">
    <cfargument name="ID" type="string" required="yes">
    <cfset result.message = "You have successfully deleted the record(s).">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    DELETE FROM tbl_survey
    WHERE ID IN (<cfqueryparam cfsqltype="cf_sql_integer" list="yes" value="#ARGUMENTS.ID#">)
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error deleting the record(s).">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="deleteSurveyType" access="public" returntype="struct">
    <cfargument name="ID" type="string" required="yes">
    <cfset result.message = "You have successfully deleted the record(s).">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    DELETE FROM tbl_survey_type
    WHERE ID IN (<cfqueryparam cfsqltype="cf_sql_integer" list="yes" value="#ARGUMENTS.ID#">)
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error deleting the record(s).">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>   
    
    <cffunction name="deleteSurveyImageRel" access="public" returntype="struct">
    <cfargument name="ID" type="string" required="yes">
    <cfset result.message = "You have successfully deleted the record(s).">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    DELETE FROM tbl_survey_image_rel
    WHERE ID IN (<cfqueryparam cfsqltype="cf_sql_integer" list="yes" value="#ARGUMENTS.ID#">)
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error deleting the record(s).">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>  
    
    <cffunction name="deleteSurveySiteRel" access="public" returntype="struct">
    <cfargument name="ID" type="string" required="yes" default="0">
    <cfargument name="sID" type="string" required="yes" default="0">
    <cfset result.message = "You have successfully deleted the record(s).">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    DELETE FROM tbl_survey_site_rel
    WHERE ID IN (<cfqueryparam cfsqltype="cf_sql_integer" list="yes" value="#ARGUMENTS.ID#">)
    OR sID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.sID#">
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error deleting the record(s).">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="deleteSurveyQuestion" access="public" returntype="struct">
    <cfargument name="ID" type="string" required="yes">
    <cfset result.message = "You have successfully deleted the record(s).">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    DELETE FROM tbl_survey_question
    WHERE ID IN (<cfqueryparam cfsqltype="cf_sql_integer" list="yes" value="#ARGUMENTS.ID#">)
    </cfquery>
    </cftransaction>
    <cfinvoke 
    component="MCMS.component.app.survey.Survey" 
    method="deleteSurveyQuestionOption" 
    returnvariable="result">
    <cfinvokeargument name="sqID" value="#ARGUMENTS.ID#">
    </cfinvoke>
    <cfcatch type="any">
    <cfset result.message = "There was an error deleting the record(s).">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction> 
    
    <cffunction name="deleteSurveyQuestionOption" access="public" returntype="struct">
    <cfargument name="ID" type="string" required="yes" default="0">
    <cfargument name="sqID" type="numeric" required="yes" default="0">
    <cfset result.message = "You have successfully deleted the record(s).">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    DELETE FROM tbl_survey_question_option
    WHERE ID IN (<cfqueryparam cfsqltype="cf_sql_integer" list="yes" value="#ARGUMENTS.ID#">)
    OR sqID = <cfqueryparam value="#ARGUMENTS.sqID#" cfsqltype="cf_sql_integer">
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error deleting the record(s).">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="deleteSurveyIncentive" access="public" returntype="struct">
    <cfargument name="ID" type="string" required="yes">
    <cfset result.message = "You have successfully deleted the record(s).">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    DELETE FROM tbl_survey_incentive
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