<cfcomponent>
    <cffunction name="getEmploymentJobListing" access="public" returntype="query" hint="Get Employment Job Listing data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="siteNo" type="string" required="yes" default="100">
    <cfargument name="deptNo" type="string" required="yes" default="0">
    <cfargument name="ID" type="numeric" required="yes" default="0">
    <cfargument name="excludeID" type="numeric" required="yes" default="0">
    <cfargument name="ejID" type="numeric" required="yes" default="0">
    <cfargument name="dateRange" type="string" required="yes" default="false">
    <cfargument name="ejlDateRel" type="string" required="yes" default="">
    <cfargument name="ejlDateExp" type="string" required="yes" default="">
    <cfargument name="esID" type="numeric" required="yes" default="0">
    <cfargument name="saStateProv" type="string" required="no" default="">
    <cfargument name="siteStatus" type="string" required="no" default="1">
    <cfargument name="etStatus" type="string" required="no" default="1">
    <cfargument name="ejStatus" type="string" required="no" default="1">
    <cfargument name="netID" type="string" required="yes" default="0">
    <cfargument name="ejlStatus" type="string" required="yes" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="ejName">
    <cfset var rsEmploymentJobListing = "" >
    <cftry>
    <cfquery name="rsEmploymentJobListing" datasource="#application.mcmsDSN#">
    SELECT * FROM v_employment_job_listing WHERE 0=0
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(ejName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(ejDescription) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(siteName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">)
    </cfif>
    <cfif ARGUMENTS.siteNo NEQ 100>
    AND siteNo IN (<cfqueryparam value="#ARGUMENTS.siteNo#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    <cfif ARGUMENTS.deptNo NEQ 0>
    AND deptNo IN (<cfqueryparam value="#ARGUMENTS.deptNo#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    <cfif ARGUMENTS.saStateProv NEQ "">
    AND saStateProv = <cfqueryparam value="#ARGUMENTS.saStateProv#" cfsqltype="cf_sql_varchar">
    </cfif>
    <cfif ARGUMENTS.netID NEQ 0>
    AND netID IN (<cfqueryparam value="#ARGUMENTS.netID#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    <!---Date Range.--->
    <cfif ARGUMENTS.dateRange EQ "true">
    <cfif ARGUMENTS.ejlDateRel NEQ "">
    AND ejlDateRel >= <cfqueryparam value="#ARGUMENTS.ejlDateRel#" cfsqltype="cf_sql_date">
    </cfif>
    <cfif ARGUMENTS.ejlDateExp NEQ "">
    AND ejlDateExp <= <cfqueryparam value="#ARGUMENTS.ejlDateExp#" cfsqltype="cf_sql_date">
    </cfif>
    <cfelse>
    <cfif ARGUMENTS.ejlDateRel NEQ "">
    AND ejlDateRel <= <cfqueryparam value="#ARGUMENTS.ejlDateRel#" cfsqltype="cf_sql_date">
    </cfif>
    <cfif ARGUMENTS.ejlDateExp NEQ "">
    AND ejlDateExp >= <cfqueryparam value="#ARGUMENTS.ejlDateExp#" cfsqltype="cf_sql_date">
    </cfif>
    </cfif>
    <cfif ARGUMENTS.ID NEQ 0>
    AND ID = <cfqueryparam value="#ARGUMENTS.ID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.excludeID NEQ 0>
    AND ID <> <cfqueryparam value="#ARGUMENTS.excludeID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.ejID NEQ 0>
    AND ejID = <cfqueryparam value="#ARGUMENTS.ejID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.esID NEQ 0>
    AND esID = <cfqueryparam value="#ARGUMENTS.esID#" cfsqltype="cf_sql_integer">
    </cfif>
    AND siteStatus IN (<cfqueryparam value="#ARGUMENTS.siteStatus#" list="yes" cfsqltype="cf_sql_integer">)
    AND etStatus IN (<cfqueryparam value="#ARGUMENTS.etStatus#" list="yes" cfsqltype="cf_sql_integer">)
    AND ejStatus IN (<cfqueryparam value="#ARGUMENTS.ejStatus#" list="yes" cfsqltype="cf_sql_integer">)
    AND ejlStatus IN (<cfqueryparam value="#ARGUMENTS.ejlStatus#" list="yes" cfsqltype="cf_sql_integer">)
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsEmploymentJobListing = StructNew()>
    <cfset rsEmploymentJobListing.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsEmploymentJobListing>
    </cffunction>
    
    <cffunction name="getEmploymentApplicant" access="public" returntype="query" hint="Get Employment Applicant data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="eaEmail" type="string" required="yes" default="">
    <cfargument name="ID" type="numeric" required="yes" default="0">
    <cfargument name="excludeID" type="numeric" required="yes" default="0">
    <cfargument name="eaStatus" type="string" required="yes" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="eafName">
    <cfset var rsEmploymentApplicant = "" >
    <cftry>
    <cfquery name="rsEmploymentApplicant" datasource="#application.mcmsDSN#">
    SELECT * FROM tbl_employment_applicant WHERE 0=0
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND UPPER(ejName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">
    </cfif>
    <cfif ARGUMENTS.ID NEQ 0>
    AND ID = <cfqueryparam value="#ARGUMENTS.ID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.excludeID NEQ 0>
    AND ID <> <cfqueryparam value="#ARGUMENTS.excludeID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.eaEmail NEQ "">
    AND eaEmail = <cfqueryparam value="#ARGUMENTS.eaEmail#" cfsqltype="cf_sql_varchar">
    </cfif>
    AND eaStatus IN (<cfqueryparam value="#ARGUMENTS.eaStatus#" list="yes" cfsqltype="cf_sql_integer">)
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsEmploymentApplicant = StructNew()>
    <cfset rsEmploymentApplicant.message = "There was an error with the query.">
    <cfif url.mcmsDebug EQ true>
    <cfdump var="#CFCATCH#">
    </cfif>
    </cfcatch>
    </cftry>
    <cfreturn rsEmploymentApplicant>
    </cffunction>
    
    <cffunction name="getEmploymentApplication" access="public" returntype="query" hint="Get Employment Application data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="siteNo" type="string" required="yes" default="100">
    <cfargument name="ID" type="numeric" required="yes" default="0">
    <cfargument name="excludeID" type="numeric" required="yes" default="0">
    <cfargument name="ejID" type="numeric" required="yes" default="0">
    <cfargument name="ejlID" type="numeric" required="yes" default="0">
    <cfargument name="eaID" type="numeric" required="yes" default="0">
    <cfargument name="eappDate" type="string" required="yes" default="">
    <cfargument name="eappDateExp" type="string" required="yes" default="">
    <cfargument name="eappStatus" type="string" required="yes" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="ejName">
    <cfset var rsEmploymentApplication = "" >
    <cftry>
    <cfquery name="rsEmploymentApplication" datasource="#application.mcmsDSN#">
    SELECT * FROM v_employment_application WHERE 0=0
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(ejName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(eaFName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(eaLName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR ID LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">)
    </cfif>
    <cfif ARGUMENTS.siteNo NEQ 100>
    AND siteNo IN (<cfqueryparam value="#ARGUMENTS.siteNo#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    <cfif ARGUMENTS.eappDate NEQ "">
    AND eappDate <= <cfqueryparam value="#ARGUMENTS.eappDate#" cfsqltype="cf_sql_date">
    </cfif>
    <cfif ARGUMENTS.eappDateExp NEQ "">
    AND eappDateExp >= <cfqueryparam value="#ARGUMENTS.eappDateExp#" cfsqltype="cf_sql_date">
    </cfif>
    <cfif ARGUMENTS.ID NEQ 0>
    AND ID = <cfqueryparam value="#ARGUMENTS.ID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.excludeID NEQ 0>
    AND ID <> <cfqueryparam value="#ARGUMENTS.excludeID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.ejID NEQ 0>
    AND ejID = <cfqueryparam value="#ARGUMENTS.ejID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.ejlID NEQ 0>
    AND ejlID = <cfqueryparam value="#ARGUMENTS.ejlID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.eaID NEQ 0>
    AND eaID = <cfqueryparam value="#ARGUMENTS.eaID#" cfsqltype="cf_sql_integer">
    </cfif>
    AND eappStatus IN (<cfqueryparam value="#ARGUMENTS.eappStatus#" list="yes" cfsqltype="cf_sql_integer">)
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsEmploymentApplication = StructNew()>
    <cfset rsEmploymentApplication.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsEmploymentApplication>
    </cffunction>
    
    <cffunction name="getEmploymentApplicationAnswer" access="public" returntype="query" hint="Get Employment Application Answers data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="eappID" type="numeric" required="yes" default="0">
    <cfargument name="eaaStatus" type="string" required="yes" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="eqQuestion">
    <cfset var rsEmploymentApplicationAnswer = "" >
    <cftry>
    <cfquery name="rsEmploymentApplicationAnswer" datasource="#application.mcmsDSN#">
    SELECT * FROM v_emp_application_answer WHERE 0=0
    <cfif ARGUMENTS.eappID NEQ 0>
    AND eappID = <cfqueryparam value="#ARGUMENTS.eappID#" cfsqltype="cf_sql_integer">
    </cfif>
    AND eaaStatus IN (<cfqueryparam value="#ARGUMENTS.eaaStatus#" list="yes" cfsqltype="cf_sql_integer">)
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsEmploymentApplicationAnswer = StructNew()>
    <cfset rsEmploymentApplicationAnswer.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsEmploymentApplicationAnswer>
    </cffunction>
    
    <cffunction name="getEmploymentApplicantEducation" access="public" returntype="query" hint="Get Employment Applicant Education data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="eaID" type="numeric" required="yes" default="0">
    <cfargument name="eaedStatus" type="string" required="yes" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="eaedName">
    <cfset var rsEmploymentApplicantEducation = "" >
    <cftry>
    <cfquery name="rsEmploymentApplicantEducation" datasource="#application.mcmsDSN#">
    SELECT * FROM v_emp_applicant_education WHERE 0=0
    <cfif ARGUMENTS.eaID NEQ 0>
    AND eaID = <cfqueryparam value="#ARGUMENTS.eaID#" cfsqltype="cf_sql_integer">
    </cfif>
    AND eaedStatus IN (<cfqueryparam value="#ARGUMENTS.eaedStatus#" list="yes" cfsqltype="cf_sql_integer">)
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsEmploymentApplicantEducation = StructNew()>
    <cfset rsEmploymentApplicantEducation.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsEmploymentApplicantEducation>
    </cffunction>
    
    <cffunction name="getEmploymentApplicantEmployer" access="public" returntype="query" hint="Get Employment Applicant Employer data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="eaID" type="numeric" required="yes" default="0">
    <cfargument name="eaeStatus" type="string" required="yes" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="eaeName">
    <cfset var rsEmploymentApplicantEmployer = "" >
    <cftry>
    <cfquery name="rsEmploymentApplicantEmployer" datasource="#application.mcmsDSN#">
    SELECT * FROM v_emp_applicant_employer WHERE 0=0
    <cfif ARGUMENTS.eaID NEQ 0>
    AND eaID = <cfqueryparam value="#ARGUMENTS.eaID#" cfsqltype="cf_sql_integer">
    </cfif>
    AND eaeStatus IN (<cfqueryparam value="#ARGUMENTS.eaeStatus#" list="yes" cfsqltype="cf_sql_integer">)
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsEmploymentApplicantEmployer = StructNew()>
    <cfset rsEmploymentApplicantEmployer.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsEmploymentApplicantEmployer>
    </cffunction>
    
    <cffunction name="getEmploymentApplicantReference" access="public" returntype="query" hint="Get Employment Applicant Reference data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="eaID" type="numeric" required="yes" default="0">
    <cfargument name="earStatus" type="string" required="yes" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="earName">
    <cfset var rsEmploymentApplicantReference = "" >
    <cftry>
    <cfquery name="rsEmploymentApplicantReference" datasource="#application.mcmsDSN#">
    SELECT * FROM v_emp_applicant_reference WHERE 0=0
    <cfif ARGUMENTS.eaID NEQ 0>
    AND eaID = <cfqueryparam value="#ARGUMENTS.eaID#" cfsqltype="cf_sql_integer">
    </cfif>
    AND earStatus IN (<cfqueryparam value="#ARGUMENTS.earStatus#" list="yes" cfsqltype="cf_sql_integer">)
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsEmploymentApplicantReference = StructNew()>
    <cfset rsEmploymentApplicantReference.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsEmploymentApplicantReference>
    </cffunction>
    
    <cffunction name="getEmploymentJob" access="public" returntype="query" hint="Get Employment Job data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="deptNo" type="string" required="yes" default="0">
    <cfargument name="ID" type="numeric" required="yes" default="0">
    <cfargument name="excludeID" type="numeric" required="yes" default="0">
    <cfargument name="ejName" type="string" required="yes" default="">
    <cfargument name="ejDescription" type="string" required="yes" default="">
    <cfargument name="ejStatus" type="string" required="yes" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="ejName">
    <cfset var rsEmploymentJob = "" >
    <cftry>
    <cfquery name="rsEmploymentJob" datasource="#application.mcmsDSN#">
    SELECT * FROM v_employment_job WHERE 0=0
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(ejName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(ejDescription) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">)
    </cfif>
    <cfif ARGUMENTS.deptNo NEQ 0>
    AND deptNo IN (<cfqueryparam value="#ARGUMENTS.deptNo#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    <cfif ARGUMENTS.ID NEQ 0>
    AND ID = <cfqueryparam value="#ARGUMENTS.ID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.excludeID NEQ 0>
    AND ID <> <cfqueryparam value="#ARGUMENTS.excludeID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.ejName NEQ "">
    AND ejName = <cfqueryparam value="#ARGUMENTS.ejName#" cfsqltype="cf_sql_varchar">
    </cfif>
    AND ejStatus IN (<cfqueryparam value="#ARGUMENTS.ejStatus#" list="yes" cfsqltype="cf_sql_integer">)
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsEmploymentJob = StructNew()>
    <cfset rsEmploymentJob.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsEmploymentJob>
    </cffunction>
    
    <cffunction name="getEmploymentJobType" access="public" returntype="query" hint="Get Employment Job Type data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="ID" type="numeric" required="yes" default="0">
    <cfargument name="etStatus" type="string" required="yes" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="etName">
    <cfset var rsEmploymentJobType = "" >
    <cftry>
    <cfquery name="rsEmploymentJobType" datasource="#application.mcmsDSN#">
    SELECT * FROM tbl_employment_type WHERE 0=0
    <cfif ARGUMENTS.ID NEQ 0>
    AND ID = <cfqueryparam value="#ARGUMENTS.ID#" cfsqltype="cf_sql_integer">
    </cfif>
    AND etStatus IN (<cfqueryparam value="#ARGUMENTS.etStatus#" list="yes" cfsqltype="cf_sql_integer">)
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsEmploymentJobType = StructNew()>
    <cfset rsEmploymentJobType.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsEmploymentJobType>
    </cffunction>
    
    <cffunction name="getEmploymentWageHour" access="public" returntype="query" hint="Get Employment Wage Hour data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="ID" type="numeric" required="yes" default="0">
    <cfargument name="ewhStatus" type="string" required="yes" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="ID">
    <cfset var rsEmploymentWageHour = "" >
    <cftry>
    <cfquery name="rsEmploymentWageHour" datasource="#application.mcmsDSN#">
    SELECT * FROM tbl_employment_wage_hour WHERE 0=0
    <cfif ARGUMENTS.ID NEQ 0>
    AND ID = <cfqueryparam value="#ARGUMENTS.ID#" cfsqltype="cf_sql_integer">
    </cfif>
    AND ewhStatus IN (<cfqueryparam value="#ARGUMENTS.ewhStatus#" list="yes" cfsqltype="cf_sql_integer">)
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsEmploymentWageHour = StructNew()>
    <cfset rsEmploymentWageHour.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsEmploymentWageHour>
    </cffunction>
    
    <cffunction name="getEmploymentWageSalary" access="public" returntype="query" hint="Get Employment Wage Salary data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="ID" type="numeric" required="yes" default="0">
    <cfargument name="ewsStatus" type="string" required="yes" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="ID">
    <cfset var rsEmploymentWageSalary = "" >
    <cftry>
    <cfquery name="rsEmploymentWageSalary" datasource="#application.mcmsDSN#">
    SELECT * FROM tbl_employment_wage_salary WHERE 0=0
    <cfif ARGUMENTS.ID NEQ 0>
    AND ID = <cfqueryparam value="#ARGUMENTS.ID#" cfsqltype="cf_sql_integer">
    </cfif>
    AND ewsStatus IN (<cfqueryparam value="#ARGUMENTS.ewsStatus#" list="yes" cfsqltype="cf_sql_integer">)
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsEmploymentWageSalary = StructNew()>
    <cfset rsEmploymentWageSalary.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsEmploymentWageSalary>
    </cffunction>
    
    <cffunction name="getEmploymentHour" access="public" returntype="query" hint="Get Employment Hour data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="ID" type="numeric" required="yes" default="0">
    <cfargument name="ehStatus" type="string" required="yes" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="ID">
    <cfset var rsEmploymentHour = "" >
    <cftry>
    <cfquery name="rsEmploymentHour" datasource="#application.mcmsDSN#">
    SELECT * FROM tbl_employment_hour WHERE 0=0
    <cfif ARGUMENTS.ID NEQ 0>
    AND ID = <cfqueryparam value="#ARGUMENTS.ID#" cfsqltype="cf_sql_integer">
    </cfif>
    AND ehStatus IN (<cfqueryparam value="#ARGUMENTS.ehStatus#" list="yes" cfsqltype="cf_sql_integer">)
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsEmploymentHour = StructNew()>
    <cfset rsEmploymentHour.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsEmploymentHour>
    </cffunction>
    
    <cffunction name="getEmploymentShift" access="public" returntype="query" hint="Get Employment Shift data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="ID" type="numeric" required="yes" default="0">
    <cfargument name="esStatus" type="string" required="yes" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="ID">
    <cfset var rsEmploymentShift = "" >
    <cftry>
    <cfquery name="rsEmploymentShift" datasource="#application.mcmsDSN#">
    SELECT * FROM tbl_employment_shift WHERE 0=0
    <cfif ARGUMENTS.ID NEQ 0>
    AND ID = <cfqueryparam value="#ARGUMENTS.ID#" cfsqltype="cf_sql_integer">
    </cfif>
    AND esStatus IN (<cfqueryparam value="#ARGUMENTS.esStatus#" list="yes" cfsqltype="cf_sql_integer">)
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsEmploymentShift = StructNew()>
    <cfset rsEmploymentShift.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsEmploymentShift>
    </cffunction>
    
    <cffunction name="getEmploymentAgreement" access="public" returntype="query" hint="Get Employment Agreement data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="ID" type="numeric" required="yes" default="0">
    <cfargument name="siteNo" type="numeric" required="yes" default="100">
    <cfargument name="spAbbreviation" type="string" required="yes" default="">
    <cfargument name="eaStatus" type="string" required="yes" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="siteNo DESC">
    <cfset var rsEmploymentAgreement = "" >
    <cftry>
    <cfquery name="rsEmploymentAgreement" datasource="#application.mcmsDSN#">
    SELECT * FROM v_employment_agreement WHERE 0=0
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND UPPER(siteName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">
    OR UPPER(spAbbreviation) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">
    OR UPPER(spName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">
    </cfif>
    <cfif ARGUMENTS.ID NEQ 0>
    AND ID = <cfqueryparam value="#ARGUMENTS.ID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.siteNo NEQ 100>
    AND siteNo = <cfqueryparam value="#ARGUMENTS.siteNo#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.spAbbreviation NEQ "">
    AND spAbbreviation = <cfqueryparam value="#ARGUMENTS.spAbbreviation#" cfsqltype="cf_sql_varchar">
    </cfif>
    AND eaStatus IN (<cfqueryparam value="#ARGUMENTS.eaStatus#" list="yes" cfsqltype="cf_sql_integer">)
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    
    <!---Query again for all sites and state/prov if no result.--->
    <cfif rsEmploymentAgreement.Recordcount EQ 0>
    <cfquery name="rsEmploymentAgreement" datasource="#application.mcmsDSN#">
    SELECT * FROM v_employment_agreement WHERE 0=0
    AND siteNo = <cfqueryparam value="100" cfsqltype="cf_sql_integer">
    AND spID = <cfqueryparam value="0" cfsqltype="cf_sql_integer">
    </cfquery>	
    </cfif>
    
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsEmploymentAgreement = StructNew()>
    <cfset rsEmploymentAgreement.message = "There was an error with the query.">
    <cfif url.mcmsDebug EQ true>
    <cfdump var="#CFCATCH#">
    </cfif>
    </cfcatch>
    </cftry>
    <cfreturn rsEmploymentAgreement>
    </cffunction>
    
    <cffunction name="getEmploymentQuestion" access="public" returntype="query" hint="Get Employment Question data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="ID" type="numeric" required="yes" default="0">
    <cfargument name="excludeID" type="numeric" required="yes" default="0">
    <cfargument name="eqtID" type="string" required="yes" default="">
    <cfargument name="eqQuestion" type="string" required="yes" default="">
    <cfargument name="eetStatus" type="string" required="no" default="1">
    <cfargument name="eqStatus" type="string" required="yes" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="eqQuestion">
    <cfset var rsEmploymentQuestion = "" >
    <cftry>
    <cfquery name="rsEmploymentQuestion" datasource="#application.mcmsDSN#">
    SELECT * FROM v_employment_question WHERE 0=0
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND UPPER(eqQuestion) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">
    </cfif>
    <cfif ARGUMENTS.ID NEQ 0>
    AND ID = <cfqueryparam value="#ARGUMENTS.ID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.excludeID NEQ 0>
    AND ID <> <cfqueryparam value="#ARGUMENTS.excludeID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.eqQuestion NEQ "">
    AND UPPER(eqQuestion) = <cfqueryparam value="#UCASE(ARGUMENTS.eqQuestion)#" cfsqltype="cf_sql_varchar">
    </cfif>
    <cfif ARGUMENTS.eqtID NEQ "">
    AND eqtID IN (<cfqueryparam value="#ARGUMENTS.eqtID#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    AND eetStatus IN (<cfqueryparam value="#ARGUMENTS.eetStatus#" list="yes" cfsqltype="cf_sql_integer">)
    AND eqStatus IN (<cfqueryparam value="#ARGUMENTS.eqStatus#" list="yes" cfsqltype="cf_sql_integer">)
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsEmploymentQuestion = StructNew()>
    <cfset rsEmploymentQuestion.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsEmploymentQuestion>
    </cffunction>
    
    <cffunction name="getEmploymentQuestionMultiple" access="public" returntype="query" hint="Get Employment Question Option data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="ID" type="numeric" required="yes" default="0">
    <cfargument name="excludeID" type="numeric" required="yes" default="0">
    <cfargument name="eqID" type="numeric" required="yes" default="0">
    <cfargument name="eqmOption" type="string" required="yes" default="">
    <cfargument name="eqStatus" type="string" required="no" default="1">
    <cfargument name="eqmStatus" type="string" required="yes" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="eqmOption">
    <cfset var rsEmploymentQuestionMultiple = "" >
    <cftry>
    <cfquery name="rsEmploymentQuestionMultiple" datasource="#application.mcmsDSN#">
    SELECT * FROM v_emp_question_multiple WHERE 0=0
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(eqmOption) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(eqQuestion) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">)
    </cfif>
    <cfif ARGUMENTS.ID NEQ 0>
    AND ID = <cfqueryparam value="#ARGUMENTS.ID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.excludeID NEQ 0>
    AND ID <> <cfqueryparam value="#ARGUMENTS.excludeID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.eqID NEQ 0>
    AND eqID = <cfqueryparam value="#ARGUMENTS.eqID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.eqmOption NEQ "">
    AND eqmOption = <cfqueryparam value="#ARGUMENTS.eqmOption#" list="yes" cfsqltype="cf_sql_varchar">
    </cfif>
    AND eqStatus IN (<cfqueryparam value="#ARGUMENTS.eqStatus#" list="yes" cfsqltype="cf_sql_integer">)
    AND eqmStatus IN (<cfqueryparam value="#ARGUMENTS.eqmStatus#" list="yes" cfsqltype="cf_sql_integer">)
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsEmploymentQuestionMultiple = StructNew()>
    <cfset rsEmploymentQuestionMultiple.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsEmploymentQuestionMultiple>
    </cffunction>
    
    <cffunction name="getEmploymentQuestionType" access="public" returntype="query" hint="Get Employment Question Type data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="ID" type="numeric" required="yes" default="0">
    <cfargument name="eetStatus" type="string" required="yes" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="eetName">
    <cfset var rsEmploymentQuestionType = "" >
    <cftry>
    <cfquery name="rsEmploymentQuestionType" datasource="#application.mcmsDSN#">
    SELECT * FROM tbl_emp_question_type WHERE 0=0
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND UPPER(eetName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">
    </cfif>
    <cfif ARGUMENTS.ID NEQ 0>
    AND ID = <cfqueryparam value="#ARGUMENTS.ID#" cfsqltype="cf_sql_integer">
    </cfif>
    AND eetStatus IN (<cfqueryparam value="#ARGUMENTS.eetStatus#" list="yes" cfsqltype="cf_sql_integer">)
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsEmploymentQuestionType = StructNew()>
    <cfset rsEmploymentQuestionType.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsEmploymentQuestionType>
    </cffunction>
    
    <cffunction name="getEmploymentInterviewListing" access="public" returntype="any" hint="Get Employment Interview Listing data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="siteNo" type="string" required="yes" default="100">
    <cfargument name="dateRange" type="string" required="yes" default="false">
    <cfargument name="eilDateStart" type="string" required="yes" default="">
    <cfargument name="eilDateExp" type="string" required="yes" default="">
    <cfargument name="eilDateStartEQ" type="string" required="yes" default="">
    <cfargument name="eilDateExpEQ" type="string" required="yes" default="">
    <cfargument name="eilTimeStart" type="string" required="yes" default="">
    <cfargument name="eilTimeEnd" type="string" required="yes" default="">
    <cfargument name="ID" type="numeric" required="yes" default="0">
    <cfargument name="excludeID" type="numeric" required="yes" default="0">
    <cfargument name="eilocLocation" type="string" required="yes" default="">
    <cfargument name="eilocID" type="string" required="yes" default="0">
    <cfargument name="eilocStatus" type="string" required="no" default="1">
    <cfargument name="siteStatus" type="string" required="no" default="1">
    <cfargument name="eilStatus" type="string" required="yes" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="eilocLocation">
    <cfset var rsEmploymentInterviewListing = "">
    <cftry>
    <cfquery name="rsEmploymentInterviewListing" datasource="#application.mcmsDSN#">
    SELECT * FROM v_emp_interview_listing WHERE 0=0
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(eilocLocation) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR  UPPER(siteName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">  OR UPPER(siteNo) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">)
    </cfif>
    <cfif ARGUMENTS.ID NEQ 0>
    AND ID = <cfqueryparam value="#ARGUMENTS.ID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.excludeID NEQ 0>
    AND ID <> <cfqueryparam value="#ARGUMENTS.excludeID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.siteNo NEQ 100>
    AND siteNo IN (<cfqueryparam value="#ARGUMENTS.siteNo#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    <!---Date Range.--->
    <cfif ARGUMENTS.dateRange EQ "true">
    <cfif ARGUMENTS.eilDateStart NEQ "">
    AND eilDateStart >= <cfqueryparam value="#ARGUMENTS.eilDateStart#" cfsqltype="cf_sql_date">
    </cfif>
    <cfif ARGUMENTS.eilDateExp NEQ "">
    AND eilDateExp <= <cfqueryparam value="#ARGUMENTS.eilDateExp#" cfsqltype="cf_sql_date">
	</cfif>
    <cfelse>
    <cfif ARGUMENTS.eilDateStart NEQ "">
    AND eilDateStart <= <cfqueryparam value="#ARGUMENTS.eilDateStart#" cfsqltype="cf_sql_date">
    </cfif>
    <cfif ARGUMENTS.eilDateExp NEQ "">
    AND eilDateExp >= <cfqueryparam value="#ARGUMENTS.eilDateExp#" cfsqltype="cf_sql_date">
	</cfif>
    </cfif>
    <cfif ARGUMENTS.eilDateStartEQ NEQ "">
    AND eilDateStart = <cfqueryparam value="#ARGUMENTS.eilDateStartEQ#" cfsqltype="cf_sql_date">
    </cfif>
    <cfif ARGUMENTS.eilDateExpEQ NEQ "">
    AND eilDateExp = <cfqueryparam value="#ARGUMENTS.eilDateExpEQ#" cfsqltype="cf_sql_date">
	</cfif>
    <cfif ARGUMENTS.eilTimeStart NEQ "">
    AND eilTimeStart = <cfqueryparam value="#ARGUMENTS.eilTimeStart#" cfsqltype="cf_sql_varchar">
    </cfif>
    <cfif ARGUMENTS.eilTimeEnd NEQ "">
    AND eilTimeEnd = <cfqueryparam value="#ARGUMENTS.eilTimeEnd#" cfsqltype="cf_sql_varchar">
    </cfif>
    <cfif ARGUMENTS.eilocLocation NEQ "">
    AND eilocLocation = <cfqueryparam value="#ARGUMENTS.eilocLocation#" cfsqltype="cf_sql_varchar">
    </cfif>
    <cfif ARGUMENTS.eilocID NEQ 0>
    AND eilocID = <cfqueryparam value="#ARGUMENTS.eilocID#" cfsqltype="cf_sql_integer">
    </cfif>
    AND siteStatus IN (<cfqueryparam value="#ARGUMENTS.siteStatus#" list="yes" cfsqltype="cf_sql_integer">)
    AND eilocStatus IN (<cfqueryparam value="#ARGUMENTS.eilocStatus#" list="yes" cfsqltype="cf_sql_integer">)
    AND eilStatus IN (<cfqueryparam value="#ARGUMENTS.eilStatus#" list="yes" cfsqltype="cf_sql_integer">)
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsEmploymentInterviewListing = StructNew()>
    <cfset rsEmploymentInterviewListing.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsEmploymentInterviewListing>
    </cffunction>
    
    <cffunction name="getEmploymentInterviewLocation" access="public" returntype="query" hint="Get Employment Interview Location data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="siteNo" type="string" required="yes" default="100">
    <cfargument name="ID" type="numeric" required="yes" default="0">
    <cfargument name="excludeID" type="numeric" required="yes" default="0">
    <cfargument name="eilocLocation" type="string" required="yes" default="">
    <cfargument name="siteStatus" type="string" required="no" default="1">
    <cfargument name="eilocStatus" type="string" required="yes" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="eilocLocation">
    <cfset var rsEmploymentInterviewLocation = "" >
    <cftry>
    <cfquery name="rsEmploymentInterviewLocation" datasource="#application.mcmsDSN#">
    SELECT * FROM v_emp_interview_location WHERE 0=0
    <cfif ARGUMENTS.ID NEQ 0>
    AND ID = <cfqueryparam value="#ARGUMENTS.ID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.excludeID NEQ 0>
    AND ID <> <cfqueryparam value="#ARGUMENTS.excludeID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND UPPER(eilocLocation) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">
    </cfif>
    <cfif ARGUMENTS.siteNo NEQ 100>
    AND siteNo IN (<cfqueryparam value="#ARGUMENTS.siteNo#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    <cfif ARGUMENTS.eilocLocation NEQ "">
    AND UPPER(eilocLocation) = <cfqueryparam value="#UCASE(ARGUMENTS.eilocLocation)#" cfsqltype="cf_sql_varchar">
    </cfif>
    AND siteStatus IN (<cfqueryparam value="#ARGUMENTS.siteStatus#" list="yes" cfsqltype="cf_sql_integer">)
    AND eilocStatus IN (<cfqueryparam value="#ARGUMENTS.eilocStatus#" list="yes" cfsqltype="cf_sql_integer">)
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsEmploymentInterviewLocation = StructNew()>
    <cfset rsEmploymentInterviewLocation.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsEmploymentInterviewLocation>
    </cffunction>
    
    <cffunction name="setSignIn" access="public" returntype="struct" hint="Authenticate applicants to profile administration site.">
    <cfargument name="eaEmail" type="string" required="yes" default="">
    <cfargument name="eaPassword" type="string" required="yes" default="">
    <cfargument name="accessDenied" type="string" required="yes" default="">
    <cfset result.status = false>
    <cfset result.message = 'You have successfully Signed In.'>
    <!---<cftry>--->
    <!---If encryption is used and a value is present.--->
    <cfinvoke 
    component="MCMS.component.app.employment.Employment"
    method="getEmploymentApplicantSecurityKeyRel"
    returnvariable="getEmploymentApplicantSecurityKeyRelRet">
    <cfinvokeargument name="eaEmail" value="#ARGUMENTS.eaEmail#"/>
    <cfinvokeargument name="easkrStatus" value="1"/>
    </cfinvoke>
    <cfif getEmploymentApplicantSecurityKeyRelRet.Recordcount NEQ 0>
    <cfset this.easkrKey = getEmploymentApplicantSecurityKeyRelRet.easkrKey>
    <cfset this.easkrKeyValue = getEmploymentApplicantSecurityKeyRelRet.easkrKeyValue>
    <cfinvoke 
    component="MCMS.component.app.security.Security"
    method="setDecryption"
    returnvariable="setDecryptionRet">
    <cfinvokeargument name="encryptKey" value="#this.easkrKey#"/>
    <cfinvokeargument name="encryptKeyValue" value="#this.easkrKeyValue#"/>
    </cfinvoke>
    <cfif setDecryptionRet EQ ARGUMENTS.eaPassword>
    <cfset result.status = true>
    </cfif>
    </cfif>
    <!---If the security key is a match proceed.--->
    <cfif result.status EQ false>	
    <cfset result.message = 'You have not successfully Signed In. Please try again or click the "Reset Password" option to have your email reset.<br/><br/>
    <a href="?mcmsPageID=resetPasswordRequest&userEmail=#ARGUMENTS.eaEmail#">Reset Password</a>'>
    <cfelse>
    <cfquery name="rsSignIn" datasource="#application.mcmsDSN#">
    SELECT * FROM tbl_employment_applicant
    WHERE 0=0 
    AND UPPER(eaEmail) = <cfqueryparam value="#UCASE(ARGUMENTS.eaEmail)#" cfsqltype="cf_sql_varchar">
    AND eaStatus = <cfqueryparam value="1" cfsqltype="cf_sql_integer">
    </cfquery>    
    <!---If the sign in was successful then proceed.--->    
    <cfif rsSignIn.Recordcount NEQ 0>
    <!--- Set the cookie/client vars --->
    <cfcookie name="applicantID" value="#rsSignIn.ID#">
    <cfset session.signedIn = 'true'>
    <!--- Create SESSION variables. --->
    <!---SESSION user.--->
    <cfset session.userUsername = rsSignIn.eaEmail>
    <cfset session.userName = rsSignIn.eaFName & ' ' & rsSignIn.eaLName>
    <cfset session.userID = rsSignIn.ID>
    <!--- Store username inside a COOKIE if required --->
    <cfif IsDefined("form.rememberUser")>
    <cfcookie name="applicantUsername" value="#ARGUMENTS.eaEmail#" expires="never">
    <!--- Else, clean any existing COOKIE --->
    <cfelse>
    <cfcookie name="applicantUsername" value="" expires="now">
    </cfif>
    <!---Redirect to path requested if authentication is successful.--->
    <cflocation url="#URLDecode(ARGUMENTS.accessDenied)#" addtoken="no">
    </cfif>
    </cfif>
    <!---
    <cfcatch type="any">
    <cfset result.status = false>
    <cfset result.message = 'An error occured when accessing the Applicant record.'>
    </cfcatch>
    </cftry>
    --->
    <cfreturn result>
    </cffunction>

    <cffunction name="setResetPasswordRequest" access="public" returntype="struct" hint="Send reset email to end user to reset password.">
    <cfargument name="eaEmail" type="string" required="yes" default="">

    <cfset result.message = 'You have successfully sent your reset password request. Check your email to reset your password. Your reset request will expire soon.'>
    
    <cfset thisDate = DateAdd('n', 10, Now())>
    
    <!---<cftry>--->
    <!---Get the userID for the applicant.--->
    <cfinvoke 
    component="MCMS.component.app.employment.Employment"
    method="getEmploymentApplicant"
    returnvariable="getEmploymentApplicantRet">
    <cfinvokeargument name="eaEmail" value="#ARGUMENTS.eaEmail#"/>
    <cfinvokeargument name="eaStatus" value="1,2,3"/>
    </cfinvoke>
    
    <cfif getEmploymentApplicantRet.Recordcount EQ 0>
    
    	<cfset result.message = 'The email you entered could not be found. Please try again or register a new account.'>	
    	
    <cfelse>
    
    	<cfset this.userID = getEmploymentApplicantRet.ID>
    
    	<!---Create a reset token.--->
    	<cfset this.passwordToken = LEFT(ARGUMENTS.eaEmail, 4) & RandRange(10000, 999999) & MID(ARGUMENTS.eaEmail, 6, 3)>
    
    	<!---Check if the reset request has expired.--->
    	<cfquery name="getUserToken" datasource="#application.mcmsDSN#">
    	SELECT * FROM tbl_user_token
    	WHERE 0=0 
    	AND userID = <cfqueryparam value="#this.userID#" cfsqltype="cf_sql_integer">
    	AND utDate > <cfqueryparam value="#thisDate#" cfsqltype="cf_sql_timestamp">
    	AND utStatus = <cfqueryparam value="1" cfsqltype="cf_sql_integer">
    	</cfquery>
	
		<cfif getUserToken.Recordcount NEQ 0>
		
		<cftransaction>
			
		<!---Update the token if it is requested again and it exists.--->
		<cfquery name="updateUserToken" datasource="#application.mcmsDSN#">
    	UPDATE tbl_user_token SET
    	utDate = <cfqueryparam cfsqltype="cf_sql_timestamp" value="#thisDate#">
    	WHERE ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#getUserToken.ID#">  
    	</cfquery>
    	
    	</cftransaction>
    
		<cfelse>
	
		<cftransaction>
	
		<!---Delete any existing tokens for this user.--->
		<cfquery datasource="#application.mcmsDSN#">
    	DELETE FROM tbl_user_token
    	WHERE userID = <cfqueryparam cfsqltype="cf_sql_integer" value="#this.userID#">
    	</cfquery>
	
		<!---If no valid token exists create a new one.--->
    
    	<!---Add 10 minutes to expire reset.--->
    	<cfquery name="insertUserToken" datasource="#application.mcmsDSN#">
    	INSERT INTO tbl_user_token (userID, utToken, utDate) VALUES
    	(
    	<cfqueryparam cfsqltype="cf_sql_integer" value="#this.userID#">,
    	<cfqueryparam cfsqltype="cf_sql_varchar" value="#this.passwordToken#">,
    	<cfqueryparam cfsqltype="cf_sql_timestamp" value="#thisDate#">
    	)
    	</cfquery>
    
    	</cftransaction>
    
    	</cfif>
    
    	<!---Send the email.--->
    	
    	<!---Create the body of the message.--->
    	<cfsavecontent variable="body">
    		<cfoutput>
    		Thank you for your request. Please click the link below to reset your password.<br/>
    		<a href="https://#CGI.SERVER_NAME##application.mcmsAuthenticatePath#/?mcmsPageID=resetPassword&mcmsToken=#this.passwordToken#">Reset Password Now</a>
    		</cfoutput> 
    	</cfsavecontent>
    	
    	<cfinvoke 
    	component="#application.mcmsComponentPath#.utility.Email"
    	method="sendEmail">
    	<cfinvokeargument name="subject" value="#application.companyName# Password Reset"/>
    	<cfinvokeargument name="to" value="#ARGUMENTS.eaEmail#"/>
    	<cfinvokeargument name="from" value="#application.noReplyEmail#"/>
    	<cfinvokeargument name="body" value="#body#"/>
    	</cfinvoke>
    
    </cfif>
    <!---
    <cfcatch type="any">
    <cfset result.status = false>
    <cfset result.message = 'An error occured when accessing requesting a password reset.'>
    </cfcatch>
    </cftry>
    --->
    <cfreturn result>
    </cffunction>
    
    <cffunction name="setResetPassword" access="public" returntype="struct" hint="Reset the users password.">
    <cfargument name="userPassword" type="string" required="yes">
    <cfargument name="mcmsToken" type="string" required="yes">

    <cfset result.message = 'You have successfully reset your password. <br/><br/> <a href="#application.mcmsAuthenticatePath#">Sign In</a>'>
    
    <!---<cftry>--->
    <!---Check for the token.--->
    <cfinvoke 
    component="MCMS.component.cms.User"
    method="getUserToken"
    returnvariable="getUserTokenRet">
    <cfinvokeargument name="utToken" value="#ARGUMENTS.mcmsToken#"/>
    <cfinvokeargument name="utDate" value="#Now()#"/>
    </cfinvoke>
    
    <cfif getUserTokenRet.Recordcount EQ 0>
    
    	<cfset result.message = 'The request could not be processed. Please try again or request a password reset again.<br/><br/><a href="?mcmsPageID=resetPasswordRequest">Reset Password Request</a>'>	
    	
    <cfelse>
    
    	<cfset this.userID = getUserTokenRet.userID>

		<!---If encryption is used and no value is present create it.--->
    	<cfinvoke 
    		component="MCMS.component.app.security.Security"
    		method="setEcryption"
    		returnvariable="setEcryptionRet">
    		<cfinvokeargument name="value" value="#ARGUMENTS.userPassword#"/>
    		<cfinvokeargument name="valuePair" value="lorem"/>
    	</cfinvoke>
    
    	<cfset this.passwordEncrypt = setEcryptionRet.encryptKey>
    
    	<cfinvoke 
    		component="MCMS.component.app.employment.Employment"
    		method="updateEmploymentApplicantSecurityKeyRel">
    		<cfinvokeargument name="eaID" value="#this.userID#"/>
    		<cfinvokeargument name="easkrKey" value="#setEcryptionRet.encryptKey#"/>
    		<cfinvokeargument name="easkrKeyValue" value="#setEcryptionRet.encryptKeyValue#"/>
    	</cfinvoke>

    	<cftransaction>
    		
    	<cfquery datasource="#application.mcmsDSN#">
    	UPDATE tbl_employment_applicant SET
	    eaPassword = <cfqueryparam cfsqltype="cf_sql_varchar" value="#this.passwordEncrypt#">    
	    WHERE ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#this.userID#">
    	</cfquery>
    	
    	</cftransaction>

		<!---Delete any existing tokens for this user.--->
		<cfquery datasource="#application.mcmsDSN#">
    	DELETE FROM tbl_user_token
    	WHERE userID = <cfqueryparam cfsqltype="cf_sql_integer" value="#this.userID#">
    	</cfquery>

    </cfif>
    <!---
    <cfcatch type="any">
    <cfset result.status = false>
    <cfset result.message = 'An error occured when accessing requesting a password reset.'>
    </cfcatch>
    </cftry>
    --->
    <cfreturn result>
    </cffunction>
    
    <cffunction name="getEmploymentApplicantSecurityKeyRel" access="public" returntype="query" hint="Get Employment Applicant Security Key Relationship data.">
    <cfargument name="ID" type="numeric" required="yes" default="0">
    <cfargument name="eaID" type="numeric" required="yes" default="0">
    <cfargument name="eaEmail" type="string" required="yes" default="">
    <cfargument name="easkrKey" type="string" required="yes" default="">
    <cfargument name="easkrStatus" type="string" required="yes" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="ID">
	<cfset var rsEmploymentApplicantSecurityKeyRel = "" >
    <cftry>
    <cfquery name="rsEmploymentApplicantSecurityKeyRel" datasource="#application.mcmsDSN#">
    SELECT * FROM v_emp_applicant_sec_key_rel WHERE 0=0
    <cfif ARGUMENTS.ID NEQ 0>
    AND ID = <cfqueryparam value="#ARGUMENTS.ID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.eaID NEQ 0>
    AND eaID = <cfqueryparam value="#ARGUMENTS.eaID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.eaEmail NEQ "">
    AND UPPER(eaEmail) = <cfqueryparam value="#UCASE(ARGUMENTS.eaEmail)#" cfsqltype="cf_sql_varchar">
    </cfif>
    <cfif ARGUMENTS.easkrKey NEQ "">
    AND easkrKey = <cfqueryparam value="#ARGUMENTS.easkrKey#" cfsqltype="cf_sql_varchar">
    </cfif>
    AND easkrStatus IN (<cfqueryparam value="#ARGUMENTS.easkrStatus#" list="yes" cfsqltype="cf_sql_integer">)
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsEmploymentApplicantSecurityKeyRel = StructNew()>
    <cfset rsEmploymentApplicantSecurityKeyRel.message = "There was an error with the query.">
    <cfif url.mcmsDebug EQ true>
    <cfdump var="#CFCATCH#">
    </cfif>
    </cfcatch>
    </cftry>
    <cfreturn rsEmploymentApplicantSecurityKeyRel>
    </cffunction>
    
    <cffunction name="getEmpJobReport" access="public" returntype="query" hint="Get Emp Job Report data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="deptNo" type="string" required="yes" default="0">
    <cfargument name="orderBy" type="string" required="yes" default="ejName">
    <cfset var rsEmployment = "" >
    <cfquery name="rsEmployment" datasource="#application.mcmsDSN#">
    SELECT ejName AS Name, TO_CHAR(ejDescription) AS Description, ejRequirement AS Requirements, deptName AS Department, docName As Doc_Name, sName AS Status FROM v_employment_job WHERE 0=0
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(ejName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(ejDescription) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">)
    </cfif>
    <cfif ARGUMENTS.deptNo NEQ 0>
    AND deptNo IN (<cfqueryparam value="#ARGUMENTS.deptNo#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <cfreturn rsEmployment>
    </cffunction>
    
    <cffunction name="getEmpApplicationReport" access="public" returntype="query" hint="Get Emp Application Report data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="orderBy" type="string" required="yes" default="ejName">
    <cfset var rsEmployment = "" >
    <cfquery name="rsEmployment" datasource="#application.mcmsDSN#">
    SELECT ID AS Reference_No, TO_CHAR(eappDate,'MM/DD/YYYY') AS App_Date, TO_CHAR(eappDateExp,'MM/DD/YYYY') AS App_Date_Expiration, eafName || ' ' || ealName AS Applicant_Name, ejName AS Job, siteName AS Site, deptName AS Department, sName AS Status FROM v_employment_application WHERE 0=0
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(ejName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(eaFName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(eaLName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR ID LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">)
    </cfif>
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <cfreturn rsEmployment>
    </cffunction>
    
    <cffunction name="getEmpJobListingReport" access="public" returntype="query" hint="Get Emp Job Listing Report data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
	<cfargument name="siteNo" type="string" required="yes" default="100">
    <cfargument name="args" type="string" required="yes" default="0">
    <cfargument name="orderBy" type="string" required="yes" default="ejName">
    <cfset var rsEmployment = "" >
    <cfquery name="rsEmployment" datasource="#application.mcmsDSN#">
    SELECT ejName AS Name, TO_CHAR(ejDescription) AS Description, ejRequirement AS Requirements, TO_CHAR(ejlDateRel,'MM/DD/YYYY') AS Release_Date, TO_CHAR(ejlDateExp,'MM/DD/YYYY') AS Expiration_Date, netName AS Network, etName AS Type, ewsName AS Wage, siteName AS Site, sName AS Status  FROM v_employment_job_listing WHERE 0=0
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND UPPER(ejName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">
    </cfif>
    <cfif ARGUMENTS.siteNo NEQ 100>
    AND siteNo IN (<cfqueryparam value="#ARGUMENTS.siteNo#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    <cfif ARGUMENTS.args NEQ 0>
    <cfif ListGetAt(ARGUMENTS.args, 1) NEQ 0>
    AND ejlDateRel >= <cfqueryparam value="#ListGetAt(ARGUMENTS.args, 1)#" list="yes" cfsqltype="cf_sql_date">
    </cfif>
    <cfif ListGetAt(ARGUMENTS.args, 2) NEQ 0>
    AND ejlDateExp <= <cfqueryparam value="#ListGetAt(ARGUMENTS.args, 2)#" list="yes" cfsqltype="cf_sql_date">
    </cfif>
    </cfif>
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <cfreturn rsEmployment>
    </cffunction>
    
    <cffunction name="getEmpJobListingExcelQuickReport" access="public" returntype="query" hint="Get Emp Job Listing Excel Quick Report data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="ejlStatus" type="string" required="yes" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="ejName">
    <cfset var rsEmpJobListingExcelQuickReport = "" >
    <cftry>
    <cfquery name="rsEmpJobListingExcelQuickReport" datasource="#application.mcmsDSN#">
    SELECT ejName AS Name, TO_CHAR(ejDescription) AS Description, ejRequirement AS Requirements, TO_CHAR(ejlDateRel,'MM/DD/YYYY') AS Release_Date, TO_CHAR(ejlDateExp,'MM/DD/YYYY') AS Expiration_Date, etName AS Type, ewsName AS Wage, siteName AS Site, sName AS Status  FROM v_employment_job_listing WHERE 0=0
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND UPPER(ejName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">
    </cfif>
    AND ejlDateExp >= <cfqueryparam value="#Now()#" cfsqltype="cf_sql_date">
    AND ejlStatus IN (<cfqueryparam value="#ARGUMENTS.ejlStatus#" list="yes" cfsqltype="cf_sql_integer">)
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsEmpJobListingExcelQuickReport = StructNew()>
    <cfset rsEmpJobListingExcelQuickReport.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsEmpJobListingExcelQuickReport>
    </cffunction>
    
    <cffunction name="getEmpQuestionReport" access="public" returntype="query" hint="Get Emp Question Report data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="orderBy" type="string" required="yes" default="eqQuestion">
    <cfset var rsEmployment = "" >
    <cfquery name="rsEmployment" datasource="#application.mcmsDSN#">
    SELECT eqQuestion AS Question, eqRequiredMessage AS Required_Message, eetName AS Type, sName AS Status  FROM v_employment_question WHERE 0=0
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND UPPER(eqQuestion) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">
    </cfif>
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <cfreturn rsEmployment>
    </cffunction>
    
    <cffunction name="getEmpQuestionMultipleReport" access="public" returntype="query" hint="Get Emp Question Multiple Report data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="orderBy" type="string" required="yes" default="eqQuestion">
    <cfset var rsEmployment = "" >
    <cfquery name="rsEmployment" datasource="#application.mcmsDSN#">
    SELECT eqmOption AS Option_Name, eqQuestion AS Question, sortName AS Sort, sName AS Status FROM v_emp_question_multiple WHERE 0=0
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(eqmOption) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(eqQuestion) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">)
    </cfif>
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <cfreturn rsEmployment>
    </cffunction>
    
    <cffunction name="getEmploymentInterviewLocationReport" access="public" returntype="query" hint="Get Employment Interview Location Report data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
	<cfargument name="siteNo" type="string" required="yes" default="100">
    <cfargument name="orderBy" type="string" required="yes" default="eilocLocation">
    <cfset var rsEmployment = "" >
    <cfquery name="rsEmployment" datasource="#application.mcmsDSN#">
    SELECT eilocLocation as Location, siteName as Site, eilocContactName as Contact, eilocTelephone as Telephone, eilocEmail as Email FROM v_emp_interview_location WHERE 0=0
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND UPPER(eilocLocation) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">
    </cfif>
    <cfif ARGUMENTS.siteNo NEQ 100>
    AND siteNo IN (<cfqueryparam value="#ARGUMENTS.siteNo#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <cfreturn rsEmployment>
    </cffunction>
    
    <cffunction name="getEmploymentInterviewListingReport" access="public" returntype="query" hint="Get Employment Interview Location Report data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
	<cfargument name="siteNo" type="string" required="yes" default="100">
    <cfargument name="args" type="string" required="yes" default="0">
    <cfargument name="orderBy" type="string" required="yes" default="eilocLocation">
    <cfset var rsEmployment = "" >
    <cfquery name="rsEmployment" datasource="#application.mcmsDSN#">
    SELECT eilocLocation as Location, siteName as Site, TO_CHAR(eilDateStart,'MM/DD/YYYY') as Date_Start, TO_CHAR(eilDateExp,'MM/DD/YYYY') as Date_Exp, eilTimeStart as Time_Start, eilTimeEnd as Time_End FROM v_emp_interview_listing WHERE 0=0
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND UPPER(eilocLocation) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">
    </cfif>
    <cfif ARGUMENTS.siteNo NEQ 100>
    AND siteNo IN (<cfqueryparam value="#ARGUMENTS.siteNo#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    <cfif ARGUMENTS.args NEQ 0>
    <cfif ListGetAt(ARGUMENTS.args, 1) NEQ 0>
    AND eilDateStart >= <cfqueryparam value="#ListGetAt(ARGUMENTS.args, 1)#" list="yes" cfsqltype="cf_sql_date">
    </cfif>
    <cfif ListGetAt(ARGUMENTS.args, 2) NEQ 0>
    AND eilDateExp <= <cfqueryparam value="#ListGetAt(ARGUMENTS.args, 2)#" list="yes" cfsqltype="cf_sql_date">
    </cfif>
    </cfif>
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <cfreturn rsEmployment>
    </cffunction>
    
    <cffunction name="insertEmploymentApplicant" access="public" returntype="struct">
    <cfargument name="eafName" type="string" required="yes">
    <cfargument name="ealName" type="string" required="yes">
    <cfargument name="eaEmail" type="string" required="yes">
    <cfargument name="eaPassword" type="string" required="yes">
    <cfargument name="eaAddress" type="string" required="yes" default="">
    <cfargument name="eaCity" type="string" required="yes" default="">
    <cfargument name="eaStateProv" type="string" required="yes" default="">
    <cfargument name="eaZipCode" type="string" required="yes" default="">
    <cfargument name="eaZipCodeExt" type="string" required="yes" default="">
    <cfargument name="eaCountry" type="string" required="yes" default="">
    <cfargument name="eaTelArea" type="string" required="yes" default="">
    <cfargument name="eaTelPrefix" type="string" required="yes" default="">
    <cfargument name="eaTelSuffix" type="string" required="yes" default="">
    <cfargument name="eaStatus" type="numeric" required="yes" default="1">
    <cfargument name="accessDenied" type="string" required="yes" default="">
    <cfset result.message = "You have registered successfully.">
    <cftry>
    <!---Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.app.employment.Employment"
    method="getEmploymentApplicant"
    returnvariable="getCheckEmploymentApplicantRet">
    <cfinvokeargument name="eaEmail" value="#ARGUMENTS.eaEmail#"/>
    <cfinvokeargument name="eaStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckEmploymentApplicantRet.Recordcount NEQ 0>
    <cfset result.message = "The email #ARGUMENTS.eaEmail# already exists. Try again or Sign In.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    INSERT INTO tbl_employment_applicant (eafName,ealName,eaEmail,eaPassword,eaAddress,eaCity,eaStateProv,eaZipCode,eaZipCodeExt,eaCountry,eaTelArea,eaTelPrefix,eaTelSuffix,eaStatus) VALUES
    (
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.eafName#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.ealName#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.eaEmail#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.eaPassword#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.eaAddress#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.eaCity#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.eaStateProv#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.eaZipCode#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.eaZipCodeExt#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.eaCountry#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.eaTelArea#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.eaTelPrefix#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.eaTelSuffix#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.eaStatus#">
    )
    </cfquery>
    </cftransaction>
    <!---Get next eaID.--->
    <cfinvoke 
    component="MCMS.component.cms.Cms"
    method="getMaxValueSQL"
    returnvariable="getMaxValueSQLRet">
    <cfinvokeargument name="tableName" value="tbl_employment_applicant"/>
    </cfinvoke>
    <cfset this.eaID = getMaxValueSQLRet>
    
    <!---If encryption is used and no value is present create it.--->
    <cfinvoke 
    component="MCMS.component.app.security.Security"
    method="setEcryption"
    returnvariable="setEcryptionRet">
    <cfinvokeargument name="value" value="#ARGUMENTS.eaPassword#"/>
    <cfinvokeargument name="valuePair" value="lorem"/>
    </cfinvoke>
    
    <cfset eaPasswordEncrypt = setEcryptionRet.encryptKey>
    
    <cfinvoke 
    component="MCMS.component.app.employment.Employment"
    method="insertEmploymentApplicantSecurityKeyRel"
    returnvariable="insertEmploymentApplicantSecurityKeyRelRet">
    <cfinvokeargument name="eaID" value="#this.eaID#"/>
    <cfinvokeargument name="easkrKey" value="#setEcryptionRet.encryptKey#"/>
    <cfinvokeargument name="easkrKeyValue" value="#setEcryptionRet.encryptKeyValue#"/>
    <cfinvokeargument name="easkrStatus" value="1"/>
    </cfinvoke>
    
    <!---Update the record with the encrypted password.--->
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_employment_applicant SET
    eaPassword = <cfqueryparam cfsqltype="cf_sql_varchar" value="#eaPasswordEncrypt#">
    </cfquery>
    
    <cfinvoke 
    component="MCMS.component.app.employment.Employment"
    method="setSignIn">
    <cfinvokeargument name="eaEmail" value="#ARGUMENTS.eaEmail#"/>
    <cfinvokeargument name="eaPassword" value="#ARGUMENTS.eaPassword#"/>
    <cfinvokeargument name="accessDenied" value="#ARGUMENTS.accessDenied#"/>
    </cfinvoke>

    </cfif>
    <cfcatch type="any">
    <cfset result.message = "There was an error saving your registration information. Please contact Customer Service.">
    <cfdump var="#CFCATCH#">
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="insertEmploymentApplicantSecurityKeyRel" access="public" returntype="struct">
    <cfargument name="eaID" type="numeric" required="yes">
    <cfargument name="easkrKey" type="string" required="yes">
    <cfargument name="easkrKeyValue" type="string" required="yes">
    <cfargument name="easkrStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully inserted the record.">
    <cftry>
	<!---Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.app.employment.Employment"
    method="getEmploymentApplicantSecurityKeyRel"
    returnvariable="getCheckEmploymentApplicantSecurityKeyRelRet">
    <cfinvokeargument name="eaID" value="#ARGUMENTS.eaID#"/>
    <cfinvokeargument name="easkrStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckEmploymentApplicantSecurityKeyRelRet.Recordcount NEQ 0>
    <cfset result.message = "The employment applicant security key relationship already exists, please try again.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    INSERT INTO tbl_emp_applicant_sec_key_rel (eaID,easkrKey,easkrKeyValue,easkrStatus) VALUES
    (
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.eaID#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.easkrKey#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.easkrKeyValue#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.easkrStatus#">
    )
    </cfquery>
    </cftransaction>
    </cfif>
    <cfcatch type="any">
    <cfset result.message = "There was an error inserting the record.">
    <cfif url.mcmsDebug EQ true>
    <cfdump var="#CFCATCH#">
    </cfif>
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="insertEmploymentApplication" access="public" returntype="struct">
    <cfargument name="eaID" type="numeric" required="yes">
    <cfargument name="ejlID" type="numeric" required="yes">
    <cfargument name="eqID" type="string" required="yes">
    <cfset result.message = "You have successfully applied for Job Listing: #ARGUMENTS.ejlID#. Thank you.">
    <!---<cftry>
    Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.app.employment.Employment"
    method="getEmploymentApplication"
    returnvariable="getCheckEmploymentApplicationRet">
    <cfinvokeargument name="eaID" value="#ARGUMENTS.eaID#"/>
    <cfinvokeargument name="ejlID" value="#ARGUMENTS.ejlID#"/>
    <cfinvokeargument name="eappStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckEmploymentApplicationRet.Recordcount NEQ 0>
    <cfset result.message = "You have already submitted an application for Job Listing: #ARGUMENTS.ejlID#.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    INSERT INTO tbl_employment_application (eaID,ejlID,eappDateExp,eappStatus) VALUES
    (
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.eaID#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.ejlID#">,
    <cfqueryparam cfsqltype="cf_sql_date" value="#DateAdd('d', APPLICATION.applicationExpire, Now())#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="1">
    )
    </cfquery>
    </cftransaction>
    
    <!---Get next eappID.--->
    <cfinvoke 
    component="MCMS.component.cms.Cms"
    method="getMaxValueSQL"
    returnvariable="getMaxValueSQLRet">
    <cfinvokeargument name="tableName" value="tbl_employment_application"/>
    </cfinvoke>
    
    <cfset this.eappID = getMaxValueSQLRet>

    <cfloop index="id" from="1" to="#ListLen(ARGUMENTS.eqID)#">
    <cfif IsDefined('FORM.eaaAnswer#id#') EQ true>
    <cfinvoke 
    component="MCMS.component.app.employment.Employment"
    method="insertEmpApplicationAnswer"
    returnvariable="insertEmpApplicationAnswerRet">
    <cfinvokeargument name="eappID" value="#THIS.eappID#"/>
    <cfinvokeargument name="ejlID" value="#ARGUMENTS.ejlID#"/>
    <cfinvokeargument name="eqID" value="#ListGetAt(ARGUMENTS.eqID, id)#"/>
    <cfinvokeargument name="eaaAnswer" value="#Evaluate('FORM.eaaAnswer#id#')#"/>
    <cfinvokeargument name="eaaStatus" value="1"/>
    </cfinvoke>
    </cfif>
    </cfloop>
    
    <cfinvoke 
    component="MCMS.component.app.employment.Employment"
    method="getEmploymentApplication"
    returnvariable="getEmploymentApplicationRet">
    <cfinvokeargument name="ejlID" value="#ARGUMENTS.ejlID#"/>
    <cfinvokeargument name="eaID" value="#ARGUMENTS.eaID#"/>
    <cfinvokeargument name="eappStatus" value="1"/>
    </cfinvoke>
    
    <cfinvoke 
    component="MCMS.component.app.employment.Employment"
    method="getEmploymentJobListing"
    returnvariable="getEmploymentJobListingRet">
    <cfinvokeargument name="ID" value="#ARGUMENTS.ejlID#"/>
    <cfinvokeargument name="ejlStatus" value="1"/>
    </cfinvoke>
    
    <!--- This email will be sent to the email and cc email address of the contact(s) for this job listing. --->
    <cfset THIS.emailContent =
    "#getEmploymentApplicationRet.eafName# #getEmploymentApplicationRet.ealName# has applied for <strong>#getEmploymentApplicationRet.ejName# - Job Listing ID: #getEmploymentApplicationRet.ejlID#</strong>. <a href='https://#Replace(CGI.HTTP_HOST, 'employment', 'extranet', 'ALL')#/admin/employment/?appID=109&appDirectory=/admin/employment/&taskPageID=&taskID=update&ID=#THIS.eappID#&taskDirectPath=inc/inc_emp_application.cfm&tabName=EmploymentApplication&taskDirect=true'>Review Application No. #THIS.eappID#</a>.<br/><br/> <u>NOTE: It is best to be Signed In to the Extranet prior to clicking this link so the application will be displayed. Not all users have access to the employment application, so you may not be able to access the application.</u>.">
    
    <cfinvoke 
    component="MCMS.component.utility.Email" 
    method="sendEmail">
    <cfinvokeargument name="subject" value="Application Submitted for the #getEmploymentApplicationRet.ejName# postion"/>
    <!--TODO: change back to proper recipient.
    <cfinvokeargument name="to" value="#getEmploymentJobListingRet.ejlEmail#"/>
    <cfinvokeargument name="cc" value="#getEmploymentJobListingRet.ejlEmailCC#"/>
    --->
    
    <cfinvokeargument name="to" value="cfraser@sportsmanswarehouse.com"/>
    <cfinvokeargument name="cc" value=""/>
    
    <cfinvokeargument name="from" value="#APPLICATION.noReplyEmail#"/>
    <cfinvokeargument name="body" value="#THIS.emailContent#"/>
    <cfinvokeargument name="ID" value="#getEmploymentApplicationRet.ID#"/>
    <cfinvokeargument name="emailTemplate" value="#application.mcmsAppAdminPath#/employment/view/inc_application_form_email_template.cfm"/>
    <cfinvokeargument name="emailType" value="html"/>
    <cfinvokeargument name="type" value="admin"/>
    </cfinvoke>
    <!--- This email will be sent to the applicant confirming their application was received. --->
    <cfset THIS.emailContent =
    "Thank you very much for applying for the #getEmploymentApplicationRet.ejName# position with #APPLICATION.companyName#. This email confirms that your application has been received and is being processed. You will be contacted shortly if your skills are a match for this opportunity.">
    <cfinvoke 
    component="MCMS.component.utility.Email"
    method="sendEmail">
    <cfinvokeargument name="subject" value="#APPLICATION.companyName# - Application received for the #getEmploymentApplicationRet.ejName# postion"/>
    <cfinvokeargument name="to" value="#getEmploymentApplicationRet.eaEmail#"/>
    
    <!---TODO: remove CC. It was added only for testing--->
    <cfinvokeargument name="cc" value="cfraser@sportsmanswarehouse.com"/>
    
    
    <cfinvokeargument name="from" value="#APPLICATION.noReplyEmail#"/>
    <cfinvokeargument name="body" value="#THIS.emailContent#"/>
    <cfinvokeargument name="emailType" value="html"/>
    <cfinvokeargument name="type" value="admin"/>
    </cfinvoke>
    </cfif>
    
    <!---
    <cfcatch type="any">
    <cfset result.message = "There was an error saving your application information. Please contact site administrator.">
    </cfcatch>
    </cftry>
    --->
    <cfreturn result>
    </cffunction>
    
    <cffunction name="insertEmpApplicationAnswer" access="public" returntype="struct">
    <cfargument name="eappID" type="numeric" required="yes">
    <cfargument name="ejlID" type="numeric" required="yes">
    <cfargument name="eqID" type="numeric" required="yes">
    <cfargument name="eaaAnswer" type="string" required="yes">
    <cfargument name="eaaStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully inserted the record.">
    <!---<cftry>--->
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    INSERT INTO tbl_emp_application_answer (eappID,ejlID,eqID,eaaAnswer,eaaStatus) VALUES
    (
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.eappID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ejlID#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.eqID#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.eaaAnswer#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.eaaStatus#">
    )
    </cfquery>
    </cftransaction>
    <!---
    <cfcatch type="any">
    <cfset result.message = "There was an error inserting the record.">
    </cfcatch>
    </cftry>
    --->
    <cfreturn result>
    </cffunction>
    
    <cffunction name="updateEmploymentApplicantSecurityKeyRel" access="public" returntype="struct">
    <cfargument name="eaID" type="numeric" required="yes">
    <cfargument name="easkrKey" type="string" required="yes">
    <cfargument name="easkrKeyValue" type="string" required="yes">
    <cfset result.message = "You have successfully inserted the record.">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_emp_applicant_sec_key_rel SET    
    easkrKey = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.easkrKey#">,
    easkrKeyValue = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.easkrKeyValue#">   
    WHERE eaID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.eaID#">
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error inserting the record.">
    <cfif url.mcmsDebug EQ true>
    <cfdump var="#CFCATCH#">
    </cfif>
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="updateEmploymentApplicant" access="public" returntype="struct">
    <cfargument name="ID" type="numeric" required="yes">
    <cfargument name="eaFName" type="string" required="yes">
    <cfargument name="eaLName" type="string" required="yes">
    <cfargument name="eaEmail" type="string" required="yes">
    <cfargument name="eaPassword" type="string" required="yes">
    <cfargument name="eaAddress" type="string" required="yes">
    <cfargument name="eaCity" type="string" required="yes">
    <cfargument name="eaStateProv" type="string" required="yes">
    <cfargument name="eaZipCode" type="string" required="yes">
    <cfargument name="eaZipCodeExt" type="string" required="yes" default="">
    <cfargument name="eaCountry" type="string" required="yes" default="USA">
    <cfargument name="eaTelArea" type="string" required="yes">
    <cfargument name="eaTelPrefix" type="string" required="yes">
    <cfargument name="eaTelSuffix" type="string" required="yes">
    <cfargument name="eaDateAvailable" type="string" required="yes">
    <cfargument name="mcmsRedirect" type="string" required="yes" default="">
    
    <cfset result.message = "You have successfully saved your personal information.">
    <!---<cftry>
    Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.app.employment.Employment"
    method="getEmploymentApplicant"
    returnvariable="getCheckEmploymentApplicantRet">
    <cfinvokeargument name="excludeID" value="#ARGUMENTS.ID#"/>
    <cfinvokeargument name="eaEmail" value="#ARGUMENTS.eaEmail#"/>
    <cfinvokeargument name="eaStatus" value="1,2,3"/>
    </cfinvoke>
    
    <cfif getCheckEmploymentApplicantRet.Recordcount NEQ 0>
    <cfset result.message = "The email #ARGUMENTS.eaEmail# already exists in our system, please try again.">
    <cfelse>
    
    <!---If encryption is used and no value is present create it.--->
    <cfinvoke 
    component="MCMS.component.app.security.Security"
    method="setEcryption"
    returnvariable="setEcryptionRet">
    <cfinvokeargument name="value" value="#ARGUMENTS.eaPassword#"/>
    <cfinvokeargument name="valuePair" value="lorem"/>
    </cfinvoke>
    
    <cfset eaPasswordEncrypt = setEcryptionRet.encryptKey>
    
    <cfinvoke 
    component="MCMS.component.app.employment.Employment"
    method="updateEmploymentApplicantSecurityKeyRel">
    <cfinvokeargument name="eaID" value="#ARGUMENTS.ID#"/>
    <cfinvokeargument name="easkrKey" value="#setEcryptionRet.encryptKey#"/>
    <cfinvokeargument name="easkrKeyValue" value="#setEcryptionRet.encryptKeyValue#"/>
    </cfinvoke>

    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_employment_applicant SET
    eaFName = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.eaFName#">,
    eaLName = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.eaLName#">,
    eaEmail = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.eaEmail#">,
    eaPassword = <cfqueryparam cfsqltype="cf_sql_varchar" value="#eaPasswordEncrypt#">,
    eaAddress = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.eaAddress#">,
    eaCity = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.eaCity#">,
    eaStateProv = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.eaStateProv#">,
    eaZipCode = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.eaZipCode#">,
    eaZipCodeExt = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.eaZipCodeExt#">,
    eaCountry = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.eaCountry#">,
    eaTelArea = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.eaTelArea#">,
    eaTelPrefix = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.eaTelPrefix#">,
    eaTelSuffix = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.eaTelSuffix#">, 
    eaDateAvailable = <cfqueryparam cfsqltype="cf_sql_date" value="#ARGUMENTS.eaDateAvailable#">,    
    eaStatus = <cfqueryparam cfsqltype="cf_sql_integer" value="1">
    WHERE ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ID#">
    </cfquery>
    </cftransaction>
    
    <cfif ARGUMENTS.mcmsRedirect NEQ '' AND getCheckEmploymentApplicantRet.eaFile NEQ ''>
    <!---Redirect to path requested if authentication is successful.--->
    <cflocation url="#URLDecode(ARGUMENTS.mcmsRedirect)#" addtoken="no">
    </cfif>
    
    </cfif>

    <!---
    <cfcatch type="any">
    <cfset result.message = "There was an error updating your personal information. Please contact site administrator.">
    <cfif url.mcmsDebug EQ true>
    <cfdump var="#CFCATCH#">
    </cfif>
    </cfcatch>
    </cftry>
    --->
    <cfreturn result>
    </cffunction>
    
    <cffunction name="updateEmploymentApplicantResume" access="public" returntype="struct">
    <cfargument name="ID" type="numeric" required="yes">
    <cfargument name="eaFile" type="string" required="yes">
    
    <cfset result.message = "You have successfully uploaded your resume.">
    <!---<cftry>
    Check for a duplicate record.--->
    
    <!---Upload the file.--->
    <!---First get the doctPath.--->
    <cfinvoke 
    component="MCMS.component.app.document.Document"
    method="getDocumentType"
    returnvariable="getDocumentTypePathRet">
    <cfinvokeargument name="ID" value="5"/>
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
    <cffile action="upload" accept="application/msword,application/vnd.openxmlformats-officedocument.wordprocessingml.document,application/pdf" destination="#this.documentPath#" nameConflict="makeunique" fileField="form.eaFile">
    <!--- Create the variable for insert of file name and file type --->
    <cfset this.fileName = CFFILE.ServerFileName & '.' & CFFILE.ServerFileExt>
    <cfcatch type="any">
    <cfset uploadFailed = "An error occured while uploading your resume, only common file types permitted. Types permitted include, Microsoft Word and PDF.">
    <cfset result.message = uploadFailed>
    </cfcatch>
    </cftry>

	<cfif NOT IsDefined('uploadFailed')>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_employment_applicant SET
    eaFile = <cfqueryparam cfsqltype="cf_sql_varchar" value="#this.fileName#">
    WHERE ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ID#">
    </cfquery>
    </cftransaction>
	</cfif>
    <!---
    <cfcatch type="any">
    <cfset result.message = "There was an error updating your resume information. Please contact Customer Service.">
    <cfif url.mcmsDebug EQ true>
    <cfdump var="#CFCATCH#">
    </cfif>
    </cfcatch>
    </cftry>
    --->
    <cfreturn result>
    </cffunction>
    
    <cffunction name="insertEmploymentJob" access="public" returntype="struct">
    <cfargument name="ejName" type="string" required="yes">
    <cfargument name="ejDescription" type="string" required="yes">
    <cfargument name="ejRequirement" type="string" required="yes">
    <cfargument name="deptNo" type="numeric" required="yes">
    <cfargument name="docID" type="numeric" required="yes">
    <cfargument name="ejStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully inserted the record.">
    <cftry>
    <!---Check for profanity in the text.--->
    <cfinvoke 
    component="MCMS.component.utility.Regex"
    method="regexProfanity"
    returnvariable="regexProfanityRet">
    <cfinvokeargument name="profanityString" value="#ARGUMENTS.ejDescription#"/>
    </cfinvoke>
    <!---Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.app.employment.Employment"
    method="getEmploymentJob"
    returnvariable="getCheckEmploymentJobRet">
    <cfinvokeargument name="ejName" value="#ARGUMENTS.ejName#"/>
    <cfinvokeargument name="ejStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckEmploymentJobRet.recordcount NEQ 0>
    <cfset result.message = "The name #ARGUMENTS.ejName# already exists, please try again.">
    <cfelseif regexProfanityRet CONTAINS '$%&*!'>
    <cfset result.message = "Some text contained profanity, please remove any profanity from your text.">
    <!---Check length restriction.--->
    <cfelseif LEN(ARGUMENTS.ejDescription) GT 2500>
    <cfset result.message = "The description is longer than 2500 characters, please enter a new description under 2500 characters.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    INSERT INTO tbl_employment_job (ejName,ejDescription,ejRequirement,deptNo,docID,ejStatus) VALUES
    (
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.ejName#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.ejDescription#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.ejRequirement#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.deptNo#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.docID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ejStatus#">
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
    
    <cffunction name="insertEmploymentJobListing" access="public" returntype="struct">
    <cfargument name="siteNo" type="numeric" required="yes">
    <cfargument name="ejID" type="numeric" required="yes">
    <cfargument name="ejlDateRel" type="date" required="yes">
    <cfargument name="ejlDateExp" type="date" required="yes">
    <cfargument name="ejlContactName" type="string" required="yes">
    <cfargument name="ejlTelephone" type="string" required="yes">
    <cfargument name="ejlEmail" type="string" required="yes">
    <cfargument name="ejlEmailCc" type="string" required="yes">
    <cfargument name="etID" type="numeric" required="yes">
    <cfargument name="ewhID" type="numeric" required="yes">
    <cfargument name="ewsID" type="numeric" required="yes">
    <cfargument name="ehID" type="numeric" required="yes">
    <cfargument name="esID" type="numeric" required="yes">
    <cfargument name="netID" type="numeric" required="yes">
    <cfargument name="ejlStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully inserted the record.">
    <cftry>
    <!---Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.app.employment.Employment"
    method="getEmploymentJobListing"
    returnvariable="getCheckEmploymentJobListingRet">
    <cfinvokeargument name="ejID" value="#ARGUMENTS.ejID#"/>
    <cfinvokeargument name="siteNo" value="#ARGUMENTS.siteNo#"/>
    <cfinvokeargument name="ejlDateRel" value="#ARGUMENTS.ejlDateRel#"/>
    <cfinvokeargument name="ejlDateExp" value="#ARGUMENTS.ejlDateExp#"/>
    <cfinvokeargument name="esID" value="#ARGUMENTS.esID#"/>
    <cfinvokeargument name="ejlStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckEmploymentJobListingRet.recordcount NEQ 0>
    <cfset result.message = "The job listing already exists with these dates and shift for this site, please try again.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    INSERT INTO tbl_employment_job_listing (siteNo,ejID,ejlDateRel,ejlDateExp,ejlContactName,ejlTelephone,ejlEmail,ejlEmailCc,etID,ewhID,ewsID,ehID,esID,netID,ejlStatus) VALUES
    (
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.siteNo#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ejID#">,
    <cfqueryparam cfsqltype="cf_sql_date" value="#ARGUMENTS.ejlDateRel#">,
    <cfqueryparam cfsqltype="cf_sql_date" value="#ARGUMENTS.ejlDateExp#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.ejlContactName#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.ejlTelephone#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.ejlEmail#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.ejlEmailCc#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.etID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ewhID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ewsID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ehID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.esID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.netID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ejlStatus#">
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
    
    <cffunction name="insertEmploymentQuestion" access="public" returntype="struct">
    <cfargument name="eqQuestion" type="string" required="yes">
    <cfargument name="eqRequired" type="numeric" required="yes">
    <cfargument name="eqRequiredMessage" type="string" required="yes">
    <cfargument name="eqtID" type="numeric" required="yes">
    <cfargument name="eqStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully inserted the record.">
    <cftry>
    <!---Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.app.employment.Employment"
    method="getEmploymentQuestion"
    returnvariable="getCheckEmploymentQuestionRet">
    <cfinvokeargument name="eqQuestion" value="#ARGUMENTS.eqQuestion#"/>
    <cfinvokeargument name="eqStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckEmploymentQuestionRet.recordcount NEQ 0>
    <cfset result.message = "The question entered already exists, please try again.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    INSERT INTO tbl_employment_question (eqQuestion,eqRequired,eqRequiredMessage,eqtID,eqStatus) VALUES
    (
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.eqQuestion#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.eqRequired#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.eqRequiredMessage#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.eqtID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.eqStatus#">
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
    
    <cffunction name="insertEmploymentQuestionMultiple" access="public" returntype="struct">
    <cfargument name="eqID" type="numeric" required="yes">
    <cfargument name="eqmOption" type="string" required="yes">
    <cfargument name="eqmSort" type="numeric" required="yes">
    <cfargument name="eqmStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully inserted the record.">
    <cftry>
    <!---Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.app.employment.Employment"
    method="getEmploymentQuestionMultiple"
    returnvariable="getCheckEmploymentQuestionMultipleRet">
    <cfinvokeargument name="eqID" value="#ARGUMENTS.eqID#"/>
    <cfinvokeargument name="eqmOption" value="#ARGUMENTS.eqmOption#"/>
    <cfinvokeargument name="eqmStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckEmploymentQuestionMultipleRet.recordcount NEQ 0>
    <cfset result.message = "The option name #ARGUMENTS.eqmOption# already exists, please try again.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    INSERT INTO tbl_emp_question_multiple (eqID,eqmOption,eqmSort,eqmStatus) VALUES
    (
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.eqID#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.eqmOption#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.eqmSort#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.eqmStatus#">
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
    
    <cffunction name="insertEmploymentInterviewLocation" access="public" returntype="struct">
    <cfargument name="siteNo" type="numeric" required="yes">
    <cfargument name="eilocLocation" type="string" required="yes">
    <cfargument name="eilocContactName" type="string" required="yes">
    <cfargument name="eilocTelephone" type="string" required="yes">
    <cfargument name="eilocEmail" type="string" required="yes">
    <cfargument name="eilocContactNameAlt" type="string" required="yes">
    <cfargument name="eilocTelephoneAlt" type="string" required="yes">
    <cfargument name="eilocEmailAlt" type="string" required="yes">
    <cfargument name="eilocUrl" type="string" required="yes">
    <cfargument name="eilocTarget" type="string" required="yes">
    <cfargument name="eilocStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully inserted the record.">
    <cftry>
    <!---Check for profanity in the text.--->
    <cfinvoke 
    component="MCMS.component.utility.Regex"
    method="regexProfanity"
    returnvariable="regexProfanityRet">
    <cfinvokeargument name="profanityString" value="#ARGUMENTS.eilocLocation#"/>
    </cfinvoke>
    <!---Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.app.employment.Employment"
    method="getEmploymentInterviewLocation"
    returnvariable="getCheckEmploymentInterviewLocationRet">
    <cfinvokeargument name="siteNo" value="#ARGUMENTS.siteNo#"/>
    <cfinvokeargument name="eilocLocation" value="#ARGUMENTS.eilocLocation#"/>
    <cfinvokeargument name="eilocStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckEmploymentInterviewLocationRet.recordcount NEQ 0>
    <cfset result.message = "The location #ARGUMENTS.eilocLocation# already exists, please try again.">
    <cfelseif regexProfanityRet CONTAINS '$%&*!'>
    <cfset result.message = "Some text contained profanity, please remove any profanity from your text.">
    <!---Check length restriction.--->
    <cfelseif LEN(ARGUMENTS.eilocLocation) GT 2048>
    <cfset result.message = "The location is longer than 2048 characters, please enter a new location under 2048 characters.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    INSERT INTO tbl_emp_interview_location (siteNo,eilocLocation,eilocContactName,eilocTelephone,eilocEmail,eilocContactNameAlt,eilocTelephoneAlt,eilocEmailAlt,eilocUrl,eilocTarget,eilocStatus) VALUES
    (
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.siteNo#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.eilocLocation#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.eilocContactName#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.eilocTelephone#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.eilocEmail#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.eilocContactNameAlt#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.eilocTelephoneAlt#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.eilocEmailAlt#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.eilocUrl#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.eilocTarget#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.eilocStatus#">
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
    
    <cffunction name="insertEmploymentInterviewListing" access="public" returntype="struct">
    <cfargument name="eilocID" type="numeric" required="yes">
    <cfargument name="eilDateStart" type="date" required="yes">
    <cfargument name="eilDateExp" type="date" required="yes">
    <cfargument name="eilTimeStart" type="string" required="yes">
    <cfargument name="eilTimeEnd" type="string" required="yes">
    <cfargument name="eilStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully inserted the record.">
    <cftry>
    <!---Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.app.employment.Employment"
    method="getEmploymentInterviewListing"
    returnvariable="getCheckEmploymentInterviewListintgRet">
    <cfinvokeargument name="eilocID" value="#ARGUMENTS.eilocID#"/>
    <cfinvokeargument name="eilDateStartEQ" value="#ARGUMENTS.eilDateStart#"/>
    <cfinvokeargument name="eilDateExpEQ" value="#ARGUMENTS.eilDateExp#"/>
    <cfinvokeargument name="eilTimeStart" value="#ARGUMENTS.eilTimeStart#"/>
    <cfinvokeargument name="eilTimeEnd" value="#ARGUMENTS.eilTimeEnd#"/>
    <cfinvokeargument name="eilStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckEmploymentInterviewListintgRet.recordcount NEQ 0>
    <cfset result.message = "The interview listing already exists for these dates, please try again.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    INSERT INTO tbl_emp_interview_listing (eilocID, eilDateStart, eilDateExp, eilTimeStart, eilTimeEnd, eilStatus) VALUES
    (
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.eilocID#">,
    <cfqueryparam cfsqltype="cf_sql_date" value="#ARGUMENTS.eilDateStart#">,
    <cfqueryparam cfsqltype="cf_sql_date" value="#ARGUMENTS.eilDateExp#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.eilTimeStart#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.eilTimeEnd#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.eilStatus#">
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
    
    <cffunction name="updateEmploymentJob" access="public" returntype="struct">
    <cfargument name="ID" type="numeric" required="yes">
    <cfargument name="ejName" type="string" required="yes">
    <cfargument name="ejDescription" type="string" required="yes">
    <cfargument name="ejRequirement" type="string" required="yes">
    <cfargument name="deptNo" type="numeric" required="yes">
    <cfargument name="docID" type="numeric" required="yes">
    <cfargument name="ejStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully updated the record.">
    <cftry>
    <!---Check for profanity in the text.--->
    <cfinvoke 
    component="MCMS.component.utility.Regex"
    method="regexProfanity"
    returnvariable="regexProfanityRet">
    <cfinvokeargument name="profanityString" value="#ARGUMENTS.ejDescription#"/>
    </cfinvoke>
    <!---Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.app.employment.Employment"
    method="getEmploymentJob"
    returnvariable="getCheckEmploymentJobRet">
    <cfinvokeargument name="excludeID" value="#ARGUMENTS.ID#"/>
    <cfinvokeargument name="ejName" value="#ARGUMENTS.ejName#"/>
    <cfinvokeargument name="ejStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckEmploymentJobRet.recordcount NEQ 0>
    <cfset result.message = "The name #ARGUMENTS.ejName# already exists, please try again.">
    <cfelseif regexProfanityRet CONTAINS '$%&*!'>
    <cfset result.message = "Some text contained profanity, please remove any profanity from your text.">
    <!---Check length restriction.--->
    <cfelseif LEN(ARGUMENTS.ejRequirement) GT 2048>
    <cfset result.message = "The requirement is longer than 2048 characters, please enter a new requirement under 2048 characters.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_employment_job SET
    ejName = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.ejName#">,
    ejDescription = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.ejDescription#">,
    ejRequirement = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.ejRequirement#">,
    deptNo = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.deptNo#">,
    docID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.docID#">,
    ejStatus = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ejStatus#">
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
    
    <cffunction name="updateEmploymentJobListing" access="public" returntype="struct">
    <cfargument name="ID" type="numeric" required="yes">
    <cfargument name="siteNo" type="numeric" required="yes">
    <cfargument name="ejID" type="numeric" required="yes">
    <cfargument name="ejlDateRel" type="date" required="yes">
    <cfargument name="ejlDateExp" type="date" required="yes">
    <cfargument name="ejlContactName" type="string" required="yes">
    <cfargument name="ejlTelephone" type="string" required="yes">
    <cfargument name="ejlEmail" type="string" required="yes">
    <cfargument name="ejlEmailCc" type="string" required="yes">
    <cfargument name="etID" type="numeric" required="yes">
    <cfargument name="ewhID" type="numeric" required="yes">
    <cfargument name="ewsID" type="numeric" required="yes">
    <cfargument name="ehID" type="numeric" required="yes">
    <cfargument name="esID" type="numeric" required="yes">
    <cfargument name="netID" type="numeric" required="yes">
    <cfargument name="ejlStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully updated the record.">
    <cftry>
    <!---Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.app.employment.Employment"
    method="getEmploymentJobListing"
    returnvariable="getCheckEmploymentJobListingRet">
    <cfinvokeargument name="excludeID" value="#ARGUMENTS.ID#"/>
    <cfinvokeargument name="ejID" value="#ARGUMENTS.ejID#"/>
    <cfinvokeargument name="siteNo" value="#ARGUMENTS.siteNo#"/>
    <cfinvokeargument name="ejlDateRel" value="#ARGUMENTS.ejlDateRel#"/>
    <cfinvokeargument name="ejlDateExp" value="#ARGUMENTS.ejlDateExp#"/>
    <cfinvokeargument name="esID" value="#ARGUMENTS.esID#"/>
    <cfinvokeargument name="ejlStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckEmploymentJobListingRet.recordcount NEQ 0>
    <cfset result.message = "The job listing already exists for these dates, please try again.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_employment_job_listing SET
    siteNo = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.siteNo#">,
    ejID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ejID#">,
    ejlDateRel = <cfqueryparam cfsqltype="cf_sql_date" value="#ARGUMENTS.ejlDateRel#">,
    ejlDateExp = <cfqueryparam cfsqltype="cf_sql_date" value="#ARGUMENTS.ejlDateExp#">,
    ejlContactName = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.ejlContactName#">,
    ejlTelephone = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.ejlTelephone#">,
    ejlEmail = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.ejlEmail#">,
    ejlEmailCc = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.ejlEmailCc#">,
    etID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.etID#">,
    ewhID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ewhID#">,
    ewsID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ewsID#">,
    ehID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ehID#">,
    esID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.esID#">,
    netID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.netID#">,
    ejlStatus = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ejlStatus#">
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
    
    <cffunction name="updateEmploymentQuestion" access="public" returntype="struct">
    <cfargument name="ID" type="numeric" required="yes">
    <cfargument name="eqQuestion" type="string" required="yes">
    <cfargument name="eqRequired" type="numeric" required="yes">
    <cfargument name="eqRequiredMessage" type="string" required="yes">
    <cfargument name="eqtID" type="numeric" required="yes">
    <cfargument name="eqStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully updated the record.">
    <cftry>
    <!---Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.app.employment.Employment"
    method="getEmploymentQuestion"
    returnvariable="getCheckEmploymentQuestionRet">
    <cfinvokeargument name="excludeID" value="#ARGUMENTS.ID#"/>
    <cfinvokeargument name="eqQuestion" value="#ARGUMENTS.eqQuestion#"/>
    <cfinvokeargument name="eqStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckEmploymentQuestionRet.recordcount NEQ 0>
    <cfset result.message = "The question entered already exists, please try again.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_employment_question SET
    eqQuestion = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.eqQuestion#">,
    eqRequired = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.eqRequired#">,
    eqRequiredMessage = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.eqRequiredMessage#">,
    eqtID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.eqtID#">,
    eqStatus = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.eqStatus#">
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
    
    <cffunction name="updateEmploymentInterviewLocation" access="public" returntype="struct">
    <cfargument name="ID" type="numeric" required="yes">
    <cfargument name="siteNo" type="numeric" required="yes">
    <cfargument name="eilocLocation" type="string" required="yes">
    <cfargument name="eilocContactName" type="string" required="yes">
    <cfargument name="eilocTelephone" type="string" required="yes">
    <cfargument name="eilocEmail" type="string" required="yes">
    <cfargument name="eilocContactNameAlt" type="string" required="yes">
    <cfargument name="eilocTelephoneAlt" type="string" required="yes">
    <cfargument name="eilocEmailAlt" type="string" required="yes">
    <cfargument name="eilocUrl" type="string" required="yes">
    <cfargument name="eilocTarget" type="string" required="yes">
    <cfargument name="eilocStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully updated the record.">
    <cftry>
    <!---Check for profanity in the text.--->
    <cfinvoke 
    component="MCMS.component.utility.Regex"
    method="regexProfanity"
    returnvariable="regexProfanityRet">
    <cfinvokeargument name="profanityString" value="#ARGUMENTS.eilocLocation#"/>
    </cfinvoke>
    <!---Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.app.employment.Employment"
    method="getEmploymentInterviewLocation"
    returnvariable="getCheckEmploymentInterviewLocationRet">
    <cfinvokeargument name="excludeID" value="#ARGUMENTS.ID#"/>
    <cfinvokeargument name="siteNo" value="#ARGUMENTS.siteNo#"/>
    <cfinvokeargument name="eilocLocation" value="#ARGUMENTS.eilocLocation#"/>
    <cfinvokeargument name="eilocStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckEmploymentInterviewLocationRet.recordcount NEQ 0>
    <cfset result.message = "The name #ARGUMENTS.eilocLocation# already exists, please try again.">
    <cfelseif regexProfanityRet CONTAINS '$%&*!'>
    <cfset result.message = "Some text contained profanity, please remove any profanity from your text.">
    <!---Check length restriction.--->
    <cfelseif LEN(ARGUMENTS.eilocLocation) GT 2048>
    <cfset result.message = "The location is longer than 2048 characters, please enter a new location under 2048 characters.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_emp_interview_location SET
    siteNo = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.siteNo#">,
    eilocLocation = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.eilocLocation#">,
    eilocContactName = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.eilocContactName#">,
    eilocTelephone = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.eilocTelephone#">,
    eilocEmail = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.eilocEmail#">,
    eilocContactNameAlt = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.eilocContactNameAlt#">,
    eilocTelephoneAlt = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.eilocTelephoneAlt#">,
    eilocEmailAlt = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.eilocEmailAlt#">,
    eilocUrl = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.eilocUrl#">,
    eilocTarget = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.eilocTarget#">,
    eilocStatus = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.eilocStatus#">    
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
    
    <cffunction name="updateEmploymentInterviewListing" access="public" returntype="struct">
    <cfargument name="ID" type="numeric" required="yes">
    <cfargument name="eilocID" type="numeric" required="yes">
    <cfargument name="eilDateStart" type="date" required="yes">
    <cfargument name="eilDateExp" type="date" required="yes">
    <cfargument name="eilTimeStart" type="string" required="yes">
    <cfargument name="eilTimeEnd" type="string" required="yes">
    <cfargument name="eilStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully updated the record.">
    <cftry>
    <!---Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.app.employment.Employment"
    method="getEmploymentInterviewListing"
    returnvariable="getCheckEmploymentInterviewListingRet">
    <cfinvokeargument name="excludeID" value="#ARGUMENTS.ID#"/>
    <cfinvokeargument name="eilocID" value="#ARGUMENTS.eilocID#"/>
    <cfinvokeargument name="eilDateStartEQ" value="#ARGUMENTS.eilDateStart#"/>
    <cfinvokeargument name="eilDateExpEQ" value="#ARGUMENTS.eilDateExp#"/>
    <cfinvokeargument name="eilTimeStart" value="#ARGUMENTS.eilTimeStart#"/>
    <cfinvokeargument name="eilTimeEnd" value="#ARGUMENTS.eilTimeEnd#"/>
    <cfinvokeargument name="eilStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckEmploymentInterviewListingRet.recordcount NEQ 0>
    <cfset result.message = "The interview listing already exists for these dates, please try again.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_emp_interview_listing SET
    eilocID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.eilocID#">,
    eilDateStart = <cfqueryparam cfsqltype="cf_sql_date" value="#ARGUMENTS.eilDateStart#">,
    eilDateExp = <cfqueryparam cfsqltype="cf_sql_date" value="#ARGUMENTS.eilDateExp#">,
    eilTimeStart = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.eilTimeStart#">,
    eilTimeEnd = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.eilTimeEnd#">,
    eilStatus = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.eilStatus#">        
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
    
    <cffunction name="updateEmploymentApplicationList" access="public" returntype="struct">
    <cfargument name="ID" type="numeric" required="yes">
    <cfargument name="eappStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully updated the records.">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_employment_application SET
    eappStatus = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.eappStatus#">
    WHERE ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ID#">
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error updating the records.">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="updateEmploymentJobListingList" access="public" returntype="struct">
    <cfargument name="ID" type="numeric" required="yes">
    <cfargument name="ejlStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully updated the records.">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_employment_job_listing SET
    ejlStatus = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ejlStatus#">
    WHERE ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ID#">
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error updating the records.">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="updateEmploymentJobList" access="public" returntype="struct">
    <cfargument name="ID" type="numeric" required="yes">
    <cfargument name="ejStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully updated the records.">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_employment_job SET
    ejStatus = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ejStatus#">
    WHERE ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ID#">
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error updating the records.">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="updateEmploymentQuestionList" access="public" returntype="struct">
    <cfargument name="ID" type="numeric" required="yes">
    <cfargument name="eqStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully updated the records.">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_employment_question SET
    eqStatus = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.eqStatus#">
    WHERE ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ID#">
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error updating the records.">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="updateEmploymentQuestionMultipleList" access="public" returntype="struct">
    <cfargument name="ID" type="numeric" required="yes">
    <cfargument name="eqStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully updated the records.">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_emp_question_multiple SET
    eqStatus = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.eqStatus#">
    WHERE ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ID#">
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error updating the records.">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="updateEmploymentInterviewLocationList" access="public" returntype="struct">
    <cfargument name="ID" type="numeric" required="yes">
    <cfargument name="eilocStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully updated the records.">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_emp_interview_location SET
    eilocStatus = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.eilocStatus#">
    WHERE ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ID#">
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error updating the records.">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="updateEmploymentInterviewListingList" access="public" returntype="struct">
    <cfargument name="ID" type="numeric" required="yes">
    <cfargument name="eilStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully updated the records.">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_emp_interview_listing SET
    eilStatus = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.eilStatus#">
    WHERE ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ID#">
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error updating the records.">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="deleteEmploymentJob" access="public" returntype="struct">
    <cfargument name="ID" type="string" required="yes">
    <cfset result.message = "You have successfully deleted the record(s).">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    DELETE FROM tbl_employment_job
    WHERE ID IN (<cfqueryparam cfsqltype="cf_sql_integer" list="yes" value="#ARGUMENTS.ID#">)
    </cfquery>
    </cftransaction>
    <cfinvoke 
    component="MCMS.component.app.employment.Employment" 
    method="deleteEmploymentJobListing" 
    returnvariable="result">
    <cfinvokeargument name="ejID" value="#ARGUMENTS.ID#">
    </cfinvoke>
    <cfcatch type="any">
    <cfset result.message = "There was an error deleting the record(s).">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction> 
    
    <cffunction name="deleteEmploymentJobListing" access="public" returntype="struct">
    <cfargument name="ID" type="string" required="yes" default="0">
    <cfargument name="ejID" type="string" required="yes" default="0">
    <cfset result.message = "You have successfully deleted the record(s).">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    DELETE FROM tbl_employment_job_listing
    WHERE ID IN (<cfqueryparam cfsqltype="cf_sql_integer" list="yes" value="#ARGUMENTS.ID#">)
    OR ejID IN (<cfqueryparam value="#ARGUMENTS.ejID#" list="yes" cfsqltype="cf_sql_integer">)
    </cfquery>
    </cftransaction>
    <cfinvoke 
    component="MCMS.component.app.employment.Employment"
    method="deleteEmploymentApplication"
    returnvariable="deleteEmploymentApplicationRet">
    <cfinvokeargument name="ejlID" value="#ARGUMENTS.ID#"/>
    </cfinvoke>
    <cfcatch type="any">
    <cfset result.message = "There was an error deleting the record(s).">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="deleteEmploymentApplication" access="public" returntype="struct">
    <cfargument name="ID" type="string" required="yes" default="0">
    <cfargument name="ejlID" type="string" required="yes" default="0">
    <cfset result.message = "You have successfully deleted the record(s).">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    DELETE FROM tbl_employment_application
    WHERE ID IN (<cfqueryparam cfsqltype="cf_sql_integer" list="yes" value="#ARGUMENTS.ID#">)
    OR ejlID IN (<cfqueryparam cfsqltype="cf_sql_integer" list="yes" value="#ARGUMENTS.ejlID#">)
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error deleting the record(s).">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>  
    
    <cffunction name="deleteEmploymentQuestion" access="public" returntype="struct">
    <cfargument name="ID" type="string" required="yes">
    <cfset result.message = "You have successfully deleted the record(s).">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    DELETE FROM tbl_employment_question
    WHERE ID IN (<cfqueryparam cfsqltype="cf_sql_integer" list="yes" value="#ARGUMENTS.ID#">)
    </cfquery>
    </cftransaction>
    <cfinvoke 
    component="MCMS.component.app.employment.Employment" 
    method="deleteEmploymentQuestionMultiple" 
    returnvariable="result">
    <cfinvokeargument name="eqID" value="#ARGUMENTS.ID#">
    </cfinvoke>
    <cfcatch type="any">
    <cfset result.message = "There was an error deleting the record(s).">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="deleteEmploymentQuestionMultiple" access="public" returntype="struct">
    <cfargument name="ID" type="string" required="yes" default="0">
    <cfargument name="eqID" type="numeric" required="yes" default="0">
    <cfset result.message = "You have successfully deleted the record(s).">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    DELETE FROM tbl_emp_question_multiple
    WHERE ID IN (<cfqueryparam cfsqltype="cf_sql_integer" list="yes" value="#ARGUMENTS.ID#">)
    OR eqID = <cfqueryparam value="#ARGUMENTS.eqID#" cfsqltype="cf_sql_integer">
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error deleting the record(s).">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction> 
    
    <cffunction name="deleteEmploymentInterviewLocation" access="public" returntype="struct">
    <cfargument name="ID" type="string" required="yes" default="0">
    <cfset result.message = "You have successfully deleted the record(s).">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    DELETE FROM tbl_emp_interview_location
    WHERE ID IN (<cfqueryparam cfsqltype="cf_sql_integer" list="yes" value="#ARGUMENTS.ID#">)
    </cfquery>
    </cftransaction>
    <cfinvoke 
    component="MCMS.component.app.employment.Employment"
    method="deleteEmploymentInterviewListing"
    returnvariable="deleteEmploymentInterviewListingRet">
    <cfinvokeargument name="eilocID" value="#ARGUMENTS.ID#"/>
    </cfinvoke>
    <cfcatch type="any">
    <cfset result.message = "There was an error deleting the record(s).">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>  
    
    <cffunction name="deleteEmploymentInterviewListing" access="public" returntype="struct">
    <cfargument name="ID" type="string" required="yes" default="0">
    <cfargument name="eilocID" type="string" required="yes" default="0">
    <cfset result.message = "You have successfully deleted the record(s).">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    DELETE FROM tbl_emp_interview_listing
    WHERE ID IN (<cfqueryparam cfsqltype="cf_sql_integer" list="yes" value="#ARGUMENTS.ID#">)
    OR eilocID IN (<cfqueryparam cfsqltype="cf_sql_integer" list="yes" value="#ARGUMENTS.eilocID#">)
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error deleting the record(s).">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>  
</cfcomponent>