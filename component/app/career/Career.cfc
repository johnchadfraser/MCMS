<cfcomponent>
	
	<cffunction name="getCareerJobListing" access="public" returntype="query" hint="Get Career Job Listing data.">

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

	<cfset var rsCareerJobListing=''>

	<cftry>
	
		<cfquery name="rsCareerJobListing" datasource="#application.mcmsDSN#">
			
			SELECT * FROM v_employment_job_listing WHERE 0=0
			
			<cfif arguments.keywords NEQ 'All'>
				
				AND (UPPER(ejName) LIKE <cfqueryparam value="%#UCASE(arguments.keywords)#%" cfsqltype="cf_sql_varchar"> 
				OR UPPER(ejDescription) LIKE <cfqueryparam value="%#UCASE(arguments.keywords)#%" cfsqltype="cf_sql_varchar"> 
				OR UPPER(siteName) LIKE <cfqueryparam value="%#UCASE(arguments.keywords)#%" cfsqltype="cf_sql_varchar">)
				
			</cfif>
			
			<cfif arguments.siteNo NEQ 100>
				
				AND siteNo IN (<cfqueryparam value="#arguments.siteNo#" list="yes" cfsqltype="cf_sql_integer">)
			
			</cfif>
			
			<cfif arguments.deptNo NEQ 0>
				
				AND deptNo IN (<cfqueryparam value="#arguments.deptNo#" list="yes" cfsqltype="cf_sql_integer">)
				
			</cfif>
			
			<cfif arguments.saStateProv NEQ "">
				
				AND saStateProv = <cfqueryparam value="#arguments.saStateProv#" cfsqltype="cf_sql_varchar">
			
			</cfif>
			
			<cfif arguments.netID NEQ 0>
				
				AND netID IN (<cfqueryparam value="#arguments.netID#" list="yes" cfsqltype="cf_sql_integer">)
			
			</cfif>
			
			<!---Date Range.--->
			<cfif arguments.dateRange EQ "true">
				
				<cfif arguments.ejlDateRel NEQ "">
					
					AND ejlDateRel >= <cfqueryparam value="#arguments.ejlDateRel#" cfsqltype="cf_sql_date">
				
				</cfif>
				
				<cfif arguments.ejlDateExp NEQ "">
					
					AND ejlDateExp <= <cfqueryparam value="#arguments.ejlDateExp#" cfsqltype="cf_sql_date">
				
				</cfif>
				
				<cfelse>
				
				<cfif arguments.ejlDateRel NEQ "">
					
					AND ejlDateRel <= <cfqueryparam value="#arguments.ejlDateRel#" cfsqltype="cf_sql_date">
				
				</cfif>
			
				<cfif arguments.ejlDateExp NEQ "">
					
					AND ejlDateExp >= <cfqueryparam value="#arguments.ejlDateExp#" cfsqltype="cf_sql_date">
				
				</cfif>
			
			</cfif>
			
			<cfif arguments.ID NEQ 0>
				
				AND ID = <cfqueryparam value="#arguments.ID#" cfsqltype="cf_sql_integer">
			
			</cfif>
			
			<cfif arguments.excludeID NEQ 0>
				
				AND ID <> <cfqueryparam value="#arguments.excludeID#" cfsqltype="cf_sql_integer">
			
			</cfif>
			
			<cfif arguments.ejID NEQ 0>
				
				AND ejID = <cfqueryparam value="#arguments.ejID#" cfsqltype="cf_sql_integer">
			
			</cfif>
			
			<cfif arguments.esID NEQ 0>
				
				AND esID = <cfqueryparam value="#arguments.esID#" cfsqltype="cf_sql_integer">
			
			</cfif>
			
			AND siteStatus IN (<cfqueryparam value="#arguments.siteStatus#" list="yes" cfsqltype="cf_sql_integer">)
			AND etStatus IN (<cfqueryparam value="#arguments.etStatus#" list="yes" cfsqltype="cf_sql_integer">)
			AND ejStatus IN (<cfqueryparam value="#arguments.ejStatus#" list="yes" cfsqltype="cf_sql_integer">)
			AND ejlStatus IN (<cfqueryparam value="#arguments.ejlStatus#" list="yes" cfsqltype="cf_sql_integer">)
			ORDER BY #arguments.orderBy#
			
		</cfquery>
	
		<!---Catch any errors.--->
		<cfcatch type="any">
			
			<cfset rsCareerJobListing = StructNew()>
			<cfset rsCareerJobListing.message = "There was an error with the query.">
				
		</cfcatch>

	</cftry>

	<cfreturn rsCareerJobListing>
	
	</cffunction>

	<cffunction name="getCareerApplicant" access="public" returntype="query" hint="Get Career Applicant data.">
		
		<cfargument name="keywords" type="string" required="yes" default="All">
		<cfargument name="eaEmail" type="string" required="yes" default="">
		<cfargument name="ID" type="numeric" required="yes" default="0">
		<cfargument name="excludeID" type="numeric" required="yes" default="0">
		<cfargument name="eaStatus" type="string" required="yes" default="1,3">
		<cfargument name="orderBy" type="string" required="yes" default="eafName">
	
		<cfset var rsCareerApplicant=''>
		
		<cftry>
			
			<cfquery name="rsCareerApplicant" datasource="#application.mcmsDSN#">
				
				SELECT * FROM tbl_employment_applicant WHERE 0=0
				
				<cfif arguments.keywords NEQ 'All'>
					
					AND UPPER(ejName) LIKE <cfqueryparam value="%#UCASE(arguments.keywords)#%" cfsqltype="cf_sql_varchar">
				
				</cfif>
				
				<cfif arguments.ID NEQ 0>
					
					AND ID = <cfqueryparam value="#arguments.ID#" cfsqltype="cf_sql_integer">
				
				</cfif>
				
				<cfif arguments.excludeID NEQ 0>
					
					AND ID <> <cfqueryparam value="#arguments.excludeID#" cfsqltype="cf_sql_integer">
				
				</cfif>
				
				<cfif arguments.eaEmail NEQ "">
					
					AND eaEmail = <cfqueryparam value="#arguments.eaEmail#" cfsqltype="cf_sql_varchar">
				
				</cfif>
				
					AND eaStatus IN (<cfqueryparam value="#arguments.eaStatus#" list="yes" cfsqltype="cf_sql_integer">)
					ORDER BY #arguments.orderBy#
			
			</cfquery>
			
			<!---Catch any errors.--->
			<cfcatch type="any">
				
				<cfset rsCareerApplicant = StructNew()>
				<cfset rsCareerApplicant.message = "There was an error with the query.">
			
			</cfcatch>
		
		</cftry>
		
		<cfreturn rsCareerApplicant>
		
	</cffunction>
	
	<cffunction name="getCareerApplication" access="public" returntype="query" hint="Get Career Application data.">
		
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
		
		<cfset var rsCareerApplication=''>
		
		<cftry>
			
			<cfquery name="rsCareerApplication" datasource="#application.mcmsDSN#">
				
				SELECT * FROM v_employment_application WHERE 0=0
				
				<cfif arguments.keywords NEQ 'All'>
					
					AND (UPPER(ejName) LIKE <cfqueryparam value="%#UCASE(arguments.keywords)#%" cfsqltype="cf_sql_varchar"> 
					OR UPPER(eaFName) LIKE <cfqueryparam value="%#UCASE(arguments.keywords)#%" cfsqltype="cf_sql_varchar"> 
					OR UPPER(eaLName) LIKE <cfqueryparam value="%#UCASE(arguments.keywords)#%" cfsqltype="cf_sql_varchar"> 
					OR ID LIKE <cfqueryparam value="%#UCASE(arguments.keywords)#%" cfsqltype="cf_sql_varchar">)
				
				</cfif>
				
				<cfif arguments.siteNo NEQ 100>
					
					AND siteNo IN (<cfqueryparam value="#arguments.siteNo#" list="yes" cfsqltype="cf_sql_integer">)
				
				</cfif>
				
				<cfif arguments.eappDate NEQ "">
					
					AND eappDate <= <cfqueryparam value="#arguments.eappDate#" cfsqltype="cf_sql_date">
				
				</cfif>
				
				<cfif arguments.eappDateExp NEQ "">
					
					AND eappDateExp >= <cfqueryparam value="#arguments.eappDateExp#" cfsqltype="cf_sql_date">
				
				</cfif>
				
				<cfif arguments.ID NEQ 0>
					
					AND ID = <cfqueryparam value="#arguments.ID#" cfsqltype="cf_sql_integer">
				
				</cfif>
				
				<cfif arguments.excludeID NEQ 0>
					
					AND ID <> <cfqueryparam value="#arguments.excludeID#" cfsqltype="cf_sql_integer">
				
				</cfif>
				
				<cfif arguments.ejID NEQ 0>
					
					AND ejID = <cfqueryparam value="#arguments.ejID#" cfsqltype="cf_sql_integer">
				
				</cfif>
				
				<cfif arguments.ejlID NEQ 0>
					
					AND ejlID = <cfqueryparam value="#arguments.ejlID#" cfsqltype="cf_sql_integer">
				
				</cfif>
				
				<cfif arguments.eaID NEQ 0>
					
					AND eaID = <cfqueryparam value="#arguments.eaID#" cfsqltype="cf_sql_integer">
				
				</cfif>
				
				AND eappStatus IN (<cfqueryparam value="#arguments.eappStatus#" list="yes" cfsqltype="cf_sql_integer">)
				ORDER BY #arguments.orderBy#
			
			</cfquery>
		
		<!---Catch any errors.--->
		<cfcatch type="any">
			
			<cfset rsCareerApplication = StructNew()>
			<cfset rsCareerApplication.message = "There was an error with the query.">
		
		</cfcatch>
		
		</cftry>
		
		<cfreturn rsCareerApplication>
		
	</cffunction>

	<cffunction name="getCareerApplicationAnswer" access="public" returntype="query" hint="Get Career Application Answers data.">
		
		<cfargument name="keywords" type="string" required="yes" default="All">
		<cfargument name="eappID" type="numeric" required="yes" default="0">
		<cfargument name="eaaStatus" type="string" required="yes" default="1,3">
		<cfargument name="orderBy" type="string" required="yes" default="eqQuestion">
		
		<cfset var rsCareerApplicationAnswer=''>
		
		<cftry>
			
			<cfquery name="rsCareerApplicationAnswer" datasource="#application.mcmsDSN#">
				
				SELECT * FROM v_emp_application_answer WHERE 0=0
				
				<cfif arguments.eappID NEQ 0>
					
					AND eappID = <cfqueryparam value="#arguments.eappID#" cfsqltype="cf_sql_integer">
				
				</cfif>
				
				AND eaaStatus IN (<cfqueryparam value="#arguments.eaaStatus#" list="yes" cfsqltype="cf_sql_integer">)
				ORDER BY #arguments.orderBy#
			
			</cfquery>
			
			<!---Catch any errors.--->
			<cfcatch type="any">
				
				<cfset rsCareerApplicationAnswer = StructNew()>
				<cfset rsCareerApplicationAnswer.message = "There was an error with the query.">
			
			</cfcatch>
			
		</cftry>
		
		<cfreturn rsCareerApplicationAnswer>
		
	</cffunction>
	
	<cffunction name="getCareerEducationType" access="public" returntype="query" hint="Get Career Education Type data.">
		
		<cfargument name="eetStatus" type="string" required="yes" default="1,3">
		<cfargument name="orderBy" type="string" required="yes" default="ID">
		
		<cfset var rsCareerEducationType=''>
		
		<cftry>
			
			<cfquery name="rsCareerEducationType" datasource="#application.mcmsDSN#">
				
				SELECT * FROM tbl_emp_education_type WHERE 0=0
				AND eetStatus IN (<cfqueryparam value="#arguments.eetStatus#" list="yes" cfsqltype="cf_sql_integer">)
				ORDER BY #arguments.orderBy#
				
			</cfquery>
			
			<!---Catch any errors.--->
			<cfcatch type="any">
				
				<cfset rsCareerEducationType = StructNew()>
				<cfset rsCareerEducationType.message = "There was an error with the query.">
				
			</cfcatch>
		
		</cftry>
		
		<cfreturn rsCareerEducationType>
		
	</cffunction>
	
	<cffunction name="getCareerApplicantEducation" access="public" returntype="query" hint="Get Career Applicant Education data.">
		
		<cfargument name="keywords" type="string" required="yes" default="All">
		<cfargument name="excludeID" type="numeric" required="yes" default="0">
		<cfargument name="eaedName" type="string" required="yes" default="">
		<cfargument name="eaID" type="numeric" required="yes" default="0">
		<cfargument name="eaedStatus" type="string" required="yes" default="1,3">
		<cfargument name="orderBy" type="string" required="yes" default="eaedName">
		
		<cfset var rsCareerApplicantEducation=''>
		
		<cftry>
			
			<cfquery name="rsCareerApplicantEducation" datasource="#application.mcmsDSN#">
				
				SELECT * FROM v_emp_applicant_education WHERE 0=0
				
				<cfif arguments.excludeID NEQ 0>
					
					AND ID <> <cfqueryparam value="#arguments.excludeID#" cfsqltype="cf_sql_integer">
				
				</cfif>
				
				<cfif arguments.eaedName NEQ "">
					
					AND eaedName = <cfqueryparam value="#arguments.eaedName#" cfsqltype="cf_sql_varchar">
				
				</cfif>
				
				<cfif arguments.eaID NEQ 0>
					
					AND eaID = <cfqueryparam value="#arguments.eaID#" cfsqltype="cf_sql_integer">
				
				</cfif>
				
				AND eaedStatus IN (<cfqueryparam value="#arguments.eaedStatus#" list="yes" cfsqltype="cf_sql_integer">)
				ORDER BY #arguments.orderBy#
			
			</cfquery>
		
			<!---Catch any errors.--->
			<cfcatch type="any">
				
				<cfset rsCareerApplicantEducation = StructNew()>
				<cfset rsCareerApplicantEducation.message = "There was an error with the query.">
			
			</cfcatch>
		
		</cftry>
		
		<cfreturn rsCareerApplicantEducation>
	
	</cffunction>
	
	<cffunction name="getCareerApplicantEmployer" access="public" returntype="query" hint="Get Career Applicant Employer data.">
		
		<cfargument name="keywords" type="string" required="yes" default="All">
		<cfargument name="excludeID" type="numeric" required="yes" default="0">
		<cfargument name="eaeName" type="string" required="yes" default="">
		<cfargument name="eaID" type="numeric" required="yes" default="0">
		<cfargument name="eaeStatus" type="string" required="yes" default="1,3">
		<cfargument name="orderBy" type="string" required="yes" default="eaeName">
		
		<cfset var rsCareerApplicantEmployer=''>
		
		<cftry>
			
			<cfquery name="rsCareerApplicantEmployer" datasource="#application.mcmsDSN#">
				
				SELECT * FROM v_emp_applicant_employer WHERE 0=0
				
				<cfif arguments.excludeID NEQ 0>
					
					AND ID <> <cfqueryparam value="#arguments.excludeID#" cfsqltype="cf_sql_integer">
					
				</cfif>
				
				<cfif arguments.eaeName NEQ "">
					
					AND eaeName = <cfqueryparam value="#arguments.eaeName#" cfsqltype="cf_sql_varchar">
					
				</cfif>
				
				<cfif arguments.eaID NEQ 0>
					
					AND eaID = <cfqueryparam value="#arguments.eaID#" cfsqltype="cf_sql_integer">
					
				</cfif>
				
				AND eaeStatus IN (<cfqueryparam value="#arguments.eaeStatus#" list="yes" cfsqltype="cf_sql_integer">)
				ORDER BY #arguments.orderBy#
			
			</cfquery>
			
			<!---Catch any errors.--->
			<cfcatch type="any">
				
				<cfset rsCareerApplicantEmployer = StructNew()>
				<cfset rsCareerApplicantEmployer.message = "There was an error with the query.">
			
			</cfcatch>
			
		</cftry>
		
		<cfreturn rsCareerApplicantEmployer>
		
	</cffunction>
	
	<cffunction name="getCareerApplicantReference" access="public" returntype="query" hint="Get Career Applicant Reference data.">
		
		<cfargument name="keywords" type="string" required="yes" default="All">
		<cfargument name="excludeID" type="numeric" required="yes" default="0">
		<cfargument name="earName" type="string" required="yes" default="">
		<cfargument name="eaID" type="numeric" required="yes" default="0">
		<cfargument name="earStatus" type="string" required="yes" default="1,3">
		<cfargument name="orderBy" type="string" required="yes" default="earName">
		
		<cfset var rsCareerApplicantReference=''>
		
		<cftry>
			
			<cfquery name="rsCareerApplicantReference" datasource="#application.mcmsDSN#">
				
			SELECT * FROM v_emp_applicant_reference WHERE 0=0
			
				<cfif arguments.excludeID NEQ 0>
					
					AND ID <> <cfqueryparam value="#arguments.excludeID#" cfsqltype="cf_sql_integer">
					
				</cfif>
				
				<cfif arguments.earName NEQ "">
					
					AND earName = <cfqueryparam value="#arguments.earName#" cfsqltype="cf_sql_varchar">
					
				</cfif>
				
				<cfif arguments.eaID NEQ 0>
					
					AND eaID = <cfqueryparam value="#arguments.eaID#" cfsqltype="cf_sql_integer">
					
				</cfif>
				
				AND earStatus IN (<cfqueryparam value="#arguments.earStatus#" list="yes" cfsqltype="cf_sql_integer">)
				ORDER BY #arguments.orderBy#
			
			</cfquery>
		
			<!---Catch any errors.--->
			<cfcatch type="any">
				
				<cfset rsCareerApplicantReference = StructNew()>
				<cfset rsCareerApplicantReference.message = "There was an error with the query.">
			
			</cfcatch>
		
		</cftry>
		
		<cfreturn rsCareerApplicantReference>
		
	</cffunction>
	
	<cffunction name="getCareerWageHour" access="public" returntype="query" hint="Get Career Wage Hour data.">
		
		<cfargument name="keywords" type="string" required="yes" default="All">
		<cfargument name="ID" type="numeric" required="yes" default="0">
		<cfargument name="ewhStatus" type="string" required="yes" default="1,3">
		<cfargument name="orderBy" type="string" required="yes" default="ID">
		
		<cfset var rsCareerWageHour=''>
		
		<cftry>
			<cfquery name="rsCareerWageHour" datasource="#application.mcmsDSN#">
				
				SELECT * FROM tbl_employment_wage_hour WHERE 0=0
				
				<cfif arguments.ID NEQ 0>
					
					AND ID = <cfqueryparam value="#arguments.ID#" cfsqltype="cf_sql_integer">
					
				</cfif>
				
				AND ewhStatus IN (<cfqueryparam value="#arguments.ewhStatus#" list="yes" cfsqltype="cf_sql_integer">)
				ORDER BY #arguments.orderBy#
				
			</cfquery>
			
			<!---Catch any errors.--->
			<cfcatch type="any">
			
				<cfset rsCareerWageHour = StructNew()>
				<cfset rsCareerWageHour.message = "There was an error with the query.">
			
			</cfcatch>
			
		</cftry>
		
		<cfreturn rsCareerWageHour>
		
	</cffunction>
	
	<cffunction name="getCareerWageSalary" access="public" returntype="query" hint="Get Career Wage Salary data.">
		
		<cfargument name="keywords" type="string" required="yes" default="All">
		<cfargument name="ID" type="numeric" required="yes" default="0">
		<cfargument name="ewsStatus" type="string" required="yes" default="1,3">
		<cfargument name="orderBy" type="string" required="yes" default="ID">
		
		<cfset var rsCareerWageSalary=''>
		
		<cftry>
			
			<cfquery name="rsCareerWageSalary" datasource="#application.mcmsDSN#">
				
				SELECT * FROM tbl_employment_wage_salary WHERE 0=0
				
				<cfif arguments.ID NEQ 0>
					
					AND ID = <cfqueryparam value="#arguments.ID#" cfsqltype="cf_sql_integer">
				
				</cfif>
				
				AND ewsStatus IN (<cfqueryparam value="#arguments.ewsStatus#" list="yes" cfsqltype="cf_sql_integer">)
				ORDER BY #arguments.orderBy#
				
			</cfquery>
			
			<!---Catch any errors.--->
			<cfcatch type="any">
				
				<cfset rsCareerWageSalary = StructNew()>
				<cfset rsCareerWageSalary.message = "There was an error with the query.">
			
			</cfcatch>
		
		</cftry>
		
		<cfreturn rsCareerWageSalary>
		
	</cffunction>
	
	<cffunction name="getCareerReferenceType" access="public" returntype="query" hint="Get Career Reference Type data.">
		
		<cfargument name="keywords" type="string" required="yes" default="All">
		<cfargument name="ID" type="numeric" required="yes" default="0">
		<cfargument name="eartStatus" type="string" required="yes" default="1,3">
		<cfargument name="orderBy" type="string" required="yes" default="ID">
		
		<cfset var rsCareerReferenceType=''>
		
		<cftry>
			
			<cfquery name="rsCareerReferenceType" datasource="#application.mcmsDSN#">
				
				SELECT * FROM tbl_emp_reference_type WHERE 0=0
				
				<cfif arguments.ID NEQ 0>
					
					AND ID = <cfqueryparam value="#arguments.ID#" cfsqltype="cf_sql_integer">
				
				</cfif>
				
				AND eartStatus IN (<cfqueryparam value="#arguments.eartStatus#" list="yes" cfsqltype="cf_sql_integer">)
				ORDER BY #arguments.orderBy#
				
			</cfquery>
			
			<!---Catch any errors.--->
			<cfcatch type="any">
				
				<cfset rsCareerReferenceType = StructNew()>
				<cfset rsCareerReferenceType.message = "There was an error with the query.">
			
			</cfcatch>
			
		</cftry>
		
		<cfreturn rsCareerReferenceType>
		
	</cffunction>
	
	<cffunction name="getCareerHour" access="public" returntype="query" hint="Get Career Hour data.">
		
		<cfargument name="keywords" type="string" required="yes" default="All">
		<cfargument name="ID" type="numeric" required="yes" default="0">
		<cfargument name="ehStatus" type="string" required="yes" default="1,3">
		<cfargument name="orderBy" type="string" required="yes" default="ID">
		
		<cfset var rsCareerHour=''>
		
		<cftry>
			
			<cfquery name="rsCareerHour" datasource="#application.mcmsDSN#">
				
				SELECT * FROM tbl_employment_hour WHERE 0=0
				
				<cfif arguments.ID NEQ 0>
					
					AND ID = <cfqueryparam value="#arguments.ID#" cfsqltype="cf_sql_integer">
					
				</cfif>
				
				AND ehStatus IN (<cfqueryparam value="#arguments.ehStatus#" list="yes" cfsqltype="cf_sql_integer">)
				
				ORDER BY #arguments.orderBy#
				
			</cfquery>
			
			<!---Catch any errors.--->
			<cfcatch type="any">
				
				<cfset rsCareerHour = StructNew()>
				<cfset rsCareerHour.message = "There was an error with the query.">	
						
			</cfcatch>
			
		</cftry>
		
		<cfreturn rsCareerHour>
		
	</cffunction>
	
	<cffunction name="getCareerShift" access="public" returntype="query" hint="Get Career Shift data.">
		
		<cfargument name="keywords" type="string" required="yes" default="All">
		<cfargument name="ID" type="numeric" required="yes" default="0">
		<cfargument name="esStatus" type="string" required="yes" default="1,3">
		<cfargument name="orderBy" type="string" required="yes" default="ID">
		
		<cfset var rsCareerShift=''>
		
		<cftry>
			
			<cfquery name="rsCareerShift" datasource="#application.mcmsDSN#">
				
				SELECT * FROM tbl_employment_shift WHERE 0=0
				
				<cfif arguments.ID NEQ 0>
					
					AND ID = <cfqueryparam value="#arguments.ID#" cfsqltype="cf_sql_integer">
					
				</cfif>
				
				AND esStatus IN (<cfqueryparam value="#arguments.esStatus#" list="yes" cfsqltype="cf_sql_integer">)
				ORDER BY #arguments.orderBy#
				
			</cfquery>
			
			<!---Catch any errors.--->
			<cfcatch type="any">
				
				<cfset rsCareerShift = StructNew()>
				<cfset rsCareerShift.message = "There was an error with the query.">
			
			</cfcatch>
			
		</cftry>
		
		<cfreturn rsCareerShift>
		
	</cffunction>
	
	<cffunction name="getCareerAgreement" access="public" returntype="query" hint="Get Career Agreement data.">
		
		<cfargument name="keywords" type="string" required="yes" default="All">
		<cfargument name="ID" type="numeric" required="yes" default="0">
		<cfargument name="siteNo" type="numeric" required="yes" default="100">
		<cfargument name="spAbbreviation" type="string" required="yes" default="">
		<cfargument name="eaStatus" type="string" required="yes" default="1,3">
		<cfargument name="orderBy" type="string" required="yes" default="siteNo DESC">
		
		<cfset var rsCareerAgreement=''>
		
		<cftry>
			
			<cfquery name="rsCareerAgreement" datasource="#application.mcmsDSN#">
				
				SELECT * FROM v_employment_agreement WHERE 0=0
				
				<cfif arguments.keywords NEQ 'All'>
					
					AND UPPER(siteName) LIKE <cfqueryparam value="%#UCASE(arguments.keywords)#%" cfsqltype="cf_sql_varchar">
					OR UPPER(spAbbreviation) LIKE <cfqueryparam value="%#UCASE(arguments.keywords)#%" cfsqltype="cf_sql_varchar">
					OR UPPER(spName) LIKE <cfqueryparam value="%#UCASE(arguments.keywords)#%" cfsqltype="cf_sql_varchar">
					
				</cfif>
				
				<cfif arguments.ID NEQ 0>
					
					AND ID = <cfqueryparam value="#arguments.ID#" cfsqltype="cf_sql_integer">
					
				</cfif>
				
				<cfif arguments.siteNo NEQ 100>
					
					AND siteNo = <cfqueryparam value="#arguments.siteNo#" cfsqltype="cf_sql_integer">
					
				</cfif>
				
				<cfif arguments.spAbbreviation NEQ "">
					
					AND spAbbreviation = <cfqueryparam value="#arguments.spAbbreviation#" cfsqltype="cf_sql_varchar">
					
				</cfif>
				
				AND eaStatus IN (<cfqueryparam value="#arguments.eaStatus#" list="yes" cfsqltype="cf_sql_integer">)
				ORDER BY #arguments.orderBy#
				
			</cfquery>
			
			<!---Query again for all sites and state/prov if no result.--->
			<cfif rsCareerAgreement.Recordcount EQ 0>
				
				<cfquery name="rsCareerAgreement" datasource="#application.mcmsDSN#">
					
					SELECT * FROM v_employment_agreement WHERE 0=0
					AND siteNo = <cfqueryparam value="100" cfsqltype="cf_sql_integer">
					AND spID = <cfqueryparam value="0" cfsqltype="cf_sql_integer">
					
				</cfquery>	
				
			</cfif>
			
			<!---Catch any errors.--->
			<cfcatch type="any">
				
				<cfset rsCareerAgreement = StructNew()>
				<cfset rsCareerAgreement.message = "There was an error with the query.">
				
			</cfcatch>
			
		</cftry>
		
		<cfreturn rsCareerAgreement>
		
	</cffunction>
	
	<cffunction name="getCareerQuestion" access="public" returntype="query" hint="Get Career Question data.">
		
		<cfargument name="keywords" type="string" required="yes" default="All">
		<cfargument name="ID" type="numeric" required="yes" default="0">
		<cfargument name="excludeID" type="numeric" required="yes" default="0">
		<cfargument name="eqtID" type="string" required="yes" default="">
		<cfargument name="eqQuestion" type="string" required="yes" default="">
		<cfargument name="siteNo" type="string" required="yes" default="100">
		<cfargument name="spID" type="string" required="yes" default="0">
		<cfargument name="spAbbreviation" type="string" required="yes" default="">
		<cfargument name="eetStatus" type="string" required="no" default="1">
		<cfargument name="eqStatus" type="string" required="yes" default="1,3">
		<cfargument name="orderBy" type="string" required="yes" default="eqQuestion">
		
		<cfset var rsCareerQuestion=''>
		
		<cftry>
			
			<cfquery name="rsCareerQuestion" datasource="#application.mcmsDSN#">
				
				SELECT * FROM v_employment_question WHERE 0=0
				
				<cfif arguments.keywords NEQ 'All'>
					
					AND UPPER(eqQuestion) LIKE <cfqueryparam value="%#UCASE(arguments.keywords)#%" cfsqltype="cf_sql_varchar">
					
				</cfif>
				
				<cfif arguments.ID NEQ 0>
					
					AND ID = <cfqueryparam value="#arguments.ID#" cfsqltype="cf_sql_integer">
					
				</cfif>
				
				<cfif arguments.excludeID NEQ 0>
					
					AND ID <> <cfqueryparam value="#arguments.excludeID#" cfsqltype="cf_sql_integer">
					
				</cfif>
				
				<cfif arguments.eqQuestion NEQ "">
					
					AND UPPER(eqQuestion) = <cfqueryparam value="#UCASE(arguments.eqQuestion)#" cfsqltype="cf_sql_varchar">
					
				</cfif>
				
				<cfif arguments.siteNo NEQ 100>
					
					AND siteNo IN (<cfqueryparam value="100,#arguments.ID#" list="yes" cfsqltype="cf_sql_integer">)
					
				</cfif>
				
				<cfif arguments.spID NEQ 0>
					
					AND spID IN (<cfqueryparam value="#arguments.spID#" list="yes" cfsqltype="cf_sql_integer">)
					
				</cfif>
				
				<cfif arguments.spAbbreviation NEQ ''>
					
					AND (spAbbreviation IN (<cfqueryparam value="#arguments.spAbbreviation#" list="yes" cfsqltype="cf_sql_varchar">) 
					OR spAbbreviation IS NULL)
					
				</cfif>
				
				<cfif arguments.eqtID NEQ "">
					
					AND eqtID IN (<cfqueryparam value="#arguments.eqtID#" list="yes" cfsqltype="cf_sql_integer">)
					
				</cfif>
				
				AND eetStatus IN (<cfqueryparam value="#arguments.eetStatus#" list="yes" cfsqltype="cf_sql_integer">)
				AND eqStatus IN (<cfqueryparam value="#arguments.eqStatus#" list="yes" cfsqltype="cf_sql_integer">)
				ORDER BY #arguments.orderBy#
				
			</cfquery>
			
			<!---Catch any errors.--->
			<cfcatch type="any">
				
				<cfset rsCareerQuestion = StructNew()>
				<cfset rsCareerQuestion.message = "There was an error with the query.">
			
			</cfcatch>
			
		</cftry>
		
		<cfreturn rsCareerQuestion>
		
	</cffunction>
	
	<cffunction name="getCareerQuestionMultiple" access="public" returntype="query" hint="Get Career Question Option data.">
		
		<cfargument name="keywords" type="string" required="yes" default="All">
		<cfargument name="ID" type="numeric" required="yes" default="0">
		<cfargument name="excludeID" type="numeric" required="yes" default="0">
		<cfargument name="eqID" type="numeric" required="yes" default="0">
		<cfargument name="eqmOption" type="string" required="yes" default="">
		<cfargument name="eqStatus" type="string" required="no" default="1">
		<cfargument name="eqmStatus" type="string" required="yes" default="1,3">
		<cfargument name="orderBy" type="string" required="yes" default="eqmOption">
		
		<cfset var rsCareerQuestionMultiple=''>
		
		<cftry>
			
			<cfquery name="rsCareerQuestionMultiple" datasource="#application.mcmsDSN#">
				
				SELECT * FROM v_emp_question_multiple WHERE 0=0
				
				<cfif arguments.keywords NEQ 'All'>
					
					AND (UPPER(eqmOption) LIKE <cfqueryparam value="%#UCASE(arguments.keywords)#%" cfsqltype="cf_sql_varchar"> 
					OR UPPER(eqQuestion) LIKE <cfqueryparam value="%#UCASE(arguments.keywords)#%" cfsqltype="cf_sql_varchar">)
					
				</cfif>
				
				<cfif arguments.ID NEQ 0>
					
					AND ID = <cfqueryparam value="#arguments.ID#" cfsqltype="cf_sql_integer">
					
				</cfif>
				
				<cfif arguments.excludeID NEQ 0>
					
					AND ID <> <cfqueryparam value="#arguments.excludeID#" cfsqltype="cf_sql_integer">
					
				</cfif>
				
				<cfif arguments.eqID NEQ 0>
					
					AND eqID = <cfqueryparam value="#arguments.eqID#" cfsqltype="cf_sql_integer">
					
				</cfif>
				
				<cfif arguments.eqmOption NEQ "">
					
					AND eqmOption = <cfqueryparam value="#arguments.eqmOption#" list="yes" cfsqltype="cf_sql_varchar">
					
				</cfif>
				
				AND eqStatus IN (<cfqueryparam value="#arguments.eqStatus#" list="yes" cfsqltype="cf_sql_integer">)
				AND eqmStatus IN (<cfqueryparam value="#arguments.eqmStatus#" list="yes" cfsqltype="cf_sql_integer">)
				ORDER BY #arguments.orderBy#
				
			</cfquery>
			
			<!---Catch any errors.--->
			<cfcatch type="any">
				
				<cfset rsCareerQuestionMultiple = StructNew()>
				<cfset rsCareerQuestionMultiple.message = "There was an error with the query.">
			
			</cfcatch>
			
		</cftry>
		
		<cfreturn rsCareerQuestionMultiple>
		
	</cffunction>
	
	<cffunction name="getCareerApplicantSecurityKeyRel" access="public" returntype="query" hint="Get Career Applicant Security Key Relationship data.">
		
		<cfargument name="ID" type="numeric" required="yes" default="0">
		<cfargument name="eaID" type="numeric" required="yes" default="0">
		<cfargument name="eaEmail" type="string" required="yes" default="">
		<cfargument name="easkrKey" type="string" required="yes" default="">
		<cfargument name="easkrStatus" type="string" required="yes" default="1,3">
		<cfargument name="orderBy" type="string" required="yes" default="ID">
		
		<cfset var rsCareerApplicantSecurityKeyRel=''>
		
		<cftry>
			
			<cfquery name="rsCareerApplicantSecurityKeyRel" datasource="#application.mcmsDSN#">
				
				SELECT * FROM v_emp_applicant_sec_key_rel WHERE 0=0
				
				<cfif arguments.ID NEQ 0>
					
					AND ID = <cfqueryparam value="#arguments.ID#" cfsqltype="cf_sql_integer">
					
				</cfif>
				
				<cfif arguments.eaID NEQ 0>
					
					AND eaID = <cfqueryparam value="#arguments.eaID#" cfsqltype="cf_sql_integer">
					
				</cfif>
				
				<cfif arguments.eaEmail NEQ "">
					
					AND UPPER(eaEmail) = <cfqueryparam value="#UCASE(arguments.eaEmail)#" cfsqltype="cf_sql_varchar">
					
				</cfif>
				
				<cfif arguments.easkrKey NEQ "">
					
					AND easkrKey = <cfqueryparam value="#arguments.easkrKey#" cfsqltype="cf_sql_varchar">
					
				</cfif>
				
					AND easkrStatus IN (<cfqueryparam value="#arguments.easkrStatus#" list="yes" cfsqltype="cf_sql_integer">)
					ORDER BY #arguments.orderBy#
					
			</cfquery>
			
			<!---Catch any errors.--->
			<cfcatch type="any">
				
				<cfset rsCareerApplicantSecurityKeyRel = StructNew()>
				<cfset rsCareerApplicantSecurityKeyRel.message = "There was an error with the query.">
				
			</cfcatch>
			
		</cftry>
		
		<cfreturn rsCareerApplicantSecurityKeyRel>
		
	</cffunction>
	
	<!---BEGIN Insert Statements.--->
	
	<cffunction name="insertCareerApplicant" access="public" returntype="struct">
		
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
		
		<cfset result.message = "You have Registered successfully.">
		
		<cftry>
			
			<!---Check for a duplicate record.--->
			<cfinvoke 
				component="MCMS.component.app.career.Career"
				method="getCareerApplicant"
				returnvariable="getCheckCareerApplicantRet">
					<cfinvokeargument name="eaEmail" value="#arguments.eaEmail#"/>
					<cfinvokeargument name="eaStatus" value="1,2,3"/>
			</cfinvoke>
			
			<cfif getCheckCareerApplicantRet.Recordcount NEQ 0>
				
				<cfset result.message = "The email #arguments.eaEmail# already exists. Try again or Sign In.">
				
			<cfelse>
			
				<cftransaction>
					
					<cfquery datasource="#application.mcmsDSN#">
						
						INSERT INTO tbl_employment_applicant (eafName,ealName,eaEmail,eaPassword,eaAddress,eaCity,eaStateProv,eaZipCode,eaZipCodeExt,eaCountry,eaTelArea,eaTelPrefix,eaTelSuffix,eaStatus) VALUES
						(
						<cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.eafName#">,
						<cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.ealName#">,
						<cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.eaEmail#">,
						<cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.eaPassword#">,
						<cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.eaAddress#">,
						<cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.eaCity#">,
						<cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.eaStateProv#">,
						<cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.eaZipCode#">,
						<cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.eaZipCodeExt#">,
						<cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.eaCountry#">,
						<cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.eaTelArea#">,
						<cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.eaTelPrefix#">,
						<cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.eaTelSuffix#">,
						<cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.eaStatus#">
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
						<cfinvokeargument name="value" value="#arguments.eaPassword#"/>
						<cfinvokeargument name="valuePair" value="lorem"/>
				</cfinvoke>
				
				<cfset eaPasswordEncrypt = setEcryptionRet.encryptKey>
				
				<cfinvoke 
					component="MCMS.component.app.career.Career"
					method="insertCareerApplicantSecurityKeyRel"
					returnvariable="insertCareerApplicantSecurityKeyRelRet">
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
					component="MCMS.component.app.career.Career"
					method="setSignIn">
						<cfinvokeargument name="eaEmail" value="#arguments.eaEmail#"/>
						<cfinvokeargument name="eaPassword" value="#arguments.eaPassword#"/>
						<cfinvokeargument name="accessDenied" value="#arguments.accessDenied#"/>
				</cfinvoke>
			
			</cfif>
			
			<cfcatch type="any">
				
				<cfset result.message = "There was an error saving your registration information. Please contact Customer Service.">
				<cflog file="registrationError" text="#cfcatch.message# #cfcatch.detail#">
			
			</cfcatch>
			
		</cftry>
		
		<cfreturn result>
		
	</cffunction>
	
	<cffunction name="insertCareerApplicantSecurityKeyRel" access="public" returntype="struct">
		
		<cfargument name="eaID" type="numeric" required="yes">
		<cfargument name="easkrKey" type="string" required="yes">
		<cfargument name="easkrKeyValue" type="string" required="yes">
		<cfargument name="easkrStatus" type="numeric" required="yes">
		
		<cfset result.message = "You have successfully inserted the record.">
		
		<cftry>
			
			<!---Check for a duplicate record.--->
			<cfinvoke 
				component="MCMS.component.app.career.Career"
				method="getCareerApplicantSecurityKeyRel"
				returnvariable="getCheckCareerApplicantSecurityKeyRelRet">
					<cfinvokeargument name="eaID" value="#arguments.eaID#"/>
					<cfinvokeargument name="easkrStatus" value="1,2,3"/>
			</cfinvoke>
			
			<cfif getCheckCareerApplicantSecurityKeyRelRet.Recordcount NEQ 0>
				
				<cfset result.message = "The employment applicant security key relationship already exists, please try again.">
				
			<cfelse>
			
				<cftransaction>
					
					<cfquery datasource="#application.mcmsDSN#">
						
						INSERT INTO tbl_emp_applicant_sec_key_rel (eaID,easkrKey,easkrKeyValue,easkrStatus) VALUES
						(
						<cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.eaID#">,
						<cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.easkrKey#">,
						<cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.easkrKeyValue#">,
						<cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.easkrStatus#">
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
	
	<cffunction name="insertCareerApplication" access="public" returntype="struct">
		
		<cfargument name="eaID" type="numeric" required="yes">
		<cfargument name="ejlID" type="numeric" required="yes">
		<cfargument name="ejName" type="string" required="yes">
		<cfargument name="eqID" type="string" required="yes">
		
		<cfset result.message = "You have successfully applied for #arguments.ejName#. Thank you. <br/><br/> View all jobs you have applied for here <a href='#application.mcmsAppAdminPath#/career/?mcmsPageID=application'>Applied Jobs</a>">
		
		<cftry>
			
			<!---Check for a duplicate record.--->
			<cfinvoke 
				component="MCMS.component.app.career.Career"
				method="getCareerApplication"
				returnvariable="getCheckCareerApplicationRet">
					<cfinvokeargument name="eaID" value="#arguments.eaID#"/>
					<cfinvokeargument name="ejlID" value="#arguments.ejlID#"/>
					<cfinvokeargument name="eappStatus" value="1,2,3"/>
			</cfinvoke>
			
			<cfif getCheckCareerApplicationRet.Recordcount NEQ 0>
				
				<cfset result.message = "You have already submitted an application for #arguments.ejName#.">
				
			<cfelse>
			
				<cftransaction>
					
					<cfquery datasource="#application.mcmsDSN#">
						
					INSERT INTO tbl_employment_application (eaID,ejlID,eappDateExp,eappStatus) VALUES
					(
					<cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.eaID#">,
					<cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.ejlID#">,
					<cfqueryparam cfsqltype="cf_sql_date" value="#DateAdd('d', APPLICATION.applicationExpire, Now())#">,
					<cfqueryparam cfsqltype="cf_sql_integer" value="1">
					)
					
					</cfquery>
					
				</cftransaction>
				
				<!---Get next eappID.--->
			    <cfinvoke 
				    component="MCMS.component.cms.Cms"
				    method="getNextValueSQL"
				    returnvariable="getNextValueSQLRet">
				    <cfinvokeargument name="sequenceOwner" value="swweb"/>
				    <cfinvokeargument name="sequenceName" value="sq_employment_application"/>
			    </cfinvoke>
			    
			    <cfset this.eappID = getNextValueSQLRet>
				
				<cfloop index="id" from="1" to="#ListLen(arguments.eqID)#">
					
					<!---Apply rule for radio button questions.--->
					<cfif NOT IsDefined('form.eaaAnswer#id#') AND Evaluate('form.eqtID#id#') EQ 2>
						
						<!---Set to no because form element would not be defined.--->
						<cfset SetVariable('form.eaaAnswer#id#', 'no')>
						
					</cfif>
					
					<cfif IsDefined('form.eaaAnswer#id#') EQ true>
						
						<cfinvoke 
							component="MCMS.component.app.career.Career"
							method="insertCareerApplicationAnswer"
							returnvariable="insertCareerApplicationAnswerRet">
								<cfinvokeargument name="eappID" value="#this.eappID#"/>
								<cfinvokeargument name="ejlID" value="#arguments.ejlID#"/>
								<cfinvokeargument name="eqID" value="#ListGetAt(arguments.eqID, id)#"/>
								<cfinvokeargument name="eaaAnswer" value="#Evaluate('form.eaaAnswer#id#')#"/>
								<cfinvokeargument name="eaaStatus" value="1"/>
						</cfinvoke>
						
					</cfif>
					
				</cfloop>
				
				<cfinvoke 
					component="MCMS.component.app.career.Career"
					method="getCareerApplication"
					returnvariable="getCareerApplicationRet">
						<cfinvokeargument name="ejlID" value="#arguments.ejlID#"/>
						<cfinvokeargument name="eaID" value="#arguments.eaID#"/>
						<cfinvokeargument name="eappStatus" value="1"/>
				</cfinvoke>
				
				<cfinvoke 
					component="MCMS.component.app.career.Career"
					method="getCareerJobListing"
					returnvariable="getCareerJobListingRet">
						<cfinvokeargument name="ID" value="#arguments.ejlID#"/>
						<cfinvokeargument name="ejlStatus" value="1"/>
				</cfinvoke>
				
				<!--- This email will be sent to the email and cc email address of the contact(s) for this job listing. --->
				<cfset this.emailContent =
				"#getCareerApplicationRet.eafName# #getCareerApplicationRet.ealName# has applied for <strong>#getCareerApplicationRet.ejName# - Job Listing ID: #getCareerApplicationRet.ejlID#</strong>. <a href='https://#Replace(CGI.HTTP_HOST, 'careers', 'extranet', 'ALL')#/admin/employment/?appID=109&appDirectory=/admin/employment/&taskPageID=&taskID=update&ID=#this.eappID#&taskDirectPath=inc/inc_emp_application.cfm&tabName=EmploymentApplication&taskDirect=true'>Review Application No. #this.eappID#</a>.<br/><br/> <u>NOTE: It is best to be Signed In to the Extranet prior to clicking this link so the application will be displayed. Not all users have access to the employment application, so you may not be able to access the application.</u>.">
				
				<cfinvoke 
					component="MCMS.component.utility.Email" 
					method="sendEmail">
						<cfinvokeargument name="subject" value="Application Submitted for the #getCareerApplicationRet.ejName# postion"/>
						<cfinvokeargument name="to" value="#getCareerJobListingRet.ejlEmail#"/>
						<cfinvokeargument name="cc" value="#getCareerJobListingRet.ejlEmailCC#"/>
						<cfinvokeargument name="from" value="#APPLICATION.noReplyEmail#"/>
						<cfinvokeargument name="body" value="#this.emailContent#"/>
						<cfinvokeargument name="ID" value="#getCareerApplicationRet.ID#"/>
						<cfinvokeargument name="emailTemplate" value="#application.mcmsAppAdminPath#/career/view/inc_application_form_email_template.cfm"/>
						<cfinvokeargument name="emailType" value="html"/>
						<cfinvokeargument name="type" value="admin"/>
				</cfinvoke>
				
				<!--- This email will be sent to the applicant confirming their application was received. --->
				<cfset this.emailContent =
				"Thank you very much for applying for the #getCareerApplicationRet.ejName# position with #APPLICATION.companyName#. This email confirms that your application has been received and is being processed. You will be contacted shortly if your skills are a match for this opportunity.">
				
				<cfinvoke 
					component="MCMS.component.utility.Email"
					method="sendEmail">
						<cfinvokeargument name="subject" value="#APPLICATION.companyName# - Application received for the #getCareerApplicationRet.ejName# postion"/>
						<cfinvokeargument name="to" value="#getCareerApplicationRet.eaEmail#"/>
						<cfinvokeargument name="from" value="#APPLICATION.noReplyEmail#"/>
						<cfinvokeargument name="body" value="#this.emailContent#"/>
						<cfinvokeargument name="emailType" value="html"/>
						<cfinvokeargument name="type" value="admin"/>
				</cfinvoke>
			
			</cfif>

			<cfcatch type="any">
				
				<cfset result.message = "There was an error saving your application information. Please contact site administrator.">
			
			</cfcatch>
			
		</cftry>

		<cfreturn result>
		
	</cffunction>
	
	<cffunction name="insertCareerApplicationAnswer" access="public" returntype="struct">
		
		<cfargument name="eappID" type="numeric" required="yes">
		<cfargument name="ejlID" type="numeric" required="yes">
		<cfargument name="eqID" type="numeric" required="yes">
		<cfargument name="eaaAnswer" type="string" required="yes">
		<cfargument name="eaaStatus" type="numeric" required="yes">
		
		<cfset result.message = "You have successfully inserted the record.">
		
		<cftry>
			
			<cftransaction>
				
			<cfquery datasource="#application.mcmsDSN#">
				
				INSERT INTO tbl_emp_application_answer (eappID,ejlID,eqID,eaaAnswer,eaaStatus) VALUES
				(
				<cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.eappID#">,
				<cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.ejlID#">,
				<cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.eqID#">,
				<cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.eaaAnswer#">,
				<cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.eaaStatus#">
				)
				
			</cfquery>
			
			</cftransaction>
			
			<cfcatch type="any">
				
				<cfset result.message = "There was an error inserting the record.">
				
			</cfcatch>
			
		</cftry>
		
		<cfreturn result>
		
	</cffunction>
	
	<cffunction name="insertCareerApplicantEducation" access="public" returntype="struct">
		
		<cfargument name="eaID" type="numeric" required="yes">
		<cfargument name="eaedName" type="string" required="yes">
		<cfargument name="eaedDescription" type="string" required="yes">
		<cfargument name="eaetID" type="numeric" required="yes">
		<cfargument name="eaedAddress" type="string" required="yes">
		<cfargument name="eaedCity" type="string" required="yes">
		<cfargument name="eaedStateProv" type="string" required="yes">
		<cfargument name="eaedZipCode" type="string" required="yes">
		<cfargument name="eaedCountry" type="string" required="yes">
		<cfargument name="eaedDateStart" type="string" required="yes">
		<cfargument name="eaedDateEnd" type="string" required="yes">
		
		<cfset result.message = "You have successfully created a Education record.">
		
		<cftry>
			
			<!---Check for duplicate record--->			
			<cfinvoke 
				component="MCMS.component.app.career.Career"
				method="getCareerApplicantEducation"
				returnvariable="getCheckCareerApplicantEducationRet">
					<cfinvokeargument name="eaID" value="#arguments.eaID#"/>
					<cfinvokeargument name="eaedName" value="#arguments.eaedName#"/>
					<cfinvokeargument name="eaedStatus" value="1,2,3"/>
			</cfinvoke>
			
			<cfif getCheckCareerApplicantEducationRet.Recordcount NEQ 0>
				
				<cfset result.message = "#arguments.eaedName# already exists, please try again.">
			
			<cfelse>
			
				<cftransaction>
					
					<cfquery datasource="#application.mcmsDSN#">
						
						INSERT INTO tbl_emp_applicant_education (eaID,eaedName,eaedDescription,eaetID,eaedAddress,eaedCity,eaedStateProv,eaedZipCode,eaedCountry,eaedDateStart,eaedDateEnd) VALUES
						(
						<cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.eaID#">,
						<cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.eaedName#">,
						<cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.eaedDescription#">,
						<cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.eaetID#">,
						<cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.eaedAddress#">,
						<cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.eaedCity#">,
						<cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.eaedStateProv#">,
						<cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.eaedZipCode#">,
						<cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.eaedCountry#">,
						<cfqueryparam cfsqltype="cf_sql_date" value="#arguments.eaedDateStart#">,
						<cfqueryparam cfsqltype="cf_sql_date" value="#arguments.eaedDateEnd#">
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
	
	<cffunction name="insertCareerApplicantEmployer" access="public" returntype="struct">
		
		<cfargument name="eaID" type="numeric" required="yes">
		<cfargument name="eaeName" type="string" required="yes">
		<cfargument name="eaeAddress" type="string" required="yes">
		<cfargument name="eaeCity" type="string" required="yes">
		<cfargument name="eaeStateProv" type="string" required="yes">
		<cfargument name="eaeZipCode" type="string" required="yes">
		<cfargument name="eaeCountry" type="string" required="yes">
		<cfargument name="eaeTelArea" type="string" required="yes">
		<cfargument name="eaeTelPrefix" type="string" required="yes">
		<cfargument name="eaeTelSuffix" type="string" required="yes">
		<cfargument name="eaeDateStart" type="string" required="yes">
		<cfargument name="eaeDateEnd" type="string" required="yes">
		<cfargument name="eaeJobTitle" type="string" required="yes">
		<cfargument name="eaeDuties" type="string" required="yes">
		<cfargument name="eaeSupervisorName" type="string" required="yes">
		<cfargument name="eaeSupervisorEmail" type="string" required="yes">
		<cfargument name="ewsID" type="numeric" required="yes">
		<cfargument name="ewhID" type="numeric" required="yes">
		
		<cfset result.message = "You have successfully created a Employer record.">
		
		<cftry>
			
			<!---Check for duplicate record--->
			<cfinvoke 
				component="MCMS.component.app.career.Career"
				method="getCareerApplicantEmployer"
				returnvariable="getCheckCareerApplicantEmployerRet">
					<cfinvokeargument name="eaID" value="#arguments.eaID#"/>
					<cfinvokeargument name="eaeName" value="#arguments.eaeName#"/>
					<cfinvokeargument name="eaeStatus" value="1,2,3"/>
			</cfinvoke>
			
			<cfif getCheckCareerApplicantEmployerRet.Recordcount NEQ 0>
				
				<cfset result.message = "#arguments.eaeName# already exists, please try again.">
			
			<cfelse>
			
				<cftransaction>
					
					<cfquery datasource="#application.mcmsDSN#">
						
						INSERT INTO tbl_emp_applicant_employer (eaID,eaeName,eaeAddress,eaeCity,eaeStateProv,eaeZipCode,eaeCountry,eaeTelArea,eaeTelPrefix,eaeTelSuffix,eaeDateStart,eaeDateEnd,eaeJobTitle,eaeDuties,eaeSupervisorName,eaeSupervisorEmail,ewsID,ewhID) VALUES
						(
						<cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.eaID#">,
						<cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.eaeName#">,
						<cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.eaeAddress#">,
						<cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.eaeCity#">,
						<cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.eaeStateProv#">,
						<cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.eaeZipCode#">,
						<cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.eaeCountry#">,
						<cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.eaeTelArea#">,
						<cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.eaeTelPrefix#">,
						<cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.eaeTelSuffix#">,
						<cfqueryparam cfsqltype="cf_sql_date" value="#arguments.eaeDateStart#">,
						<cfqueryparam cfsqltype="cf_sql_date" value="#arguments.eaeDateEnd#">,
						<cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.eaeJobTitle#">,
						<cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.eaeDuties#">,
						<cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.eaeSupervisorName#">,
						<cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.eaeSupervisorEmail#">,
						<cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.ewsID#">,
						<cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.ewhID#">
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
	
	<cffunction name="insertCareerApplicantReference" access="public" returntype="struct">
		
		<cfargument name="eaID" type="numeric" required="yes">
		<cfargument name="earName" type="string" required="yes">
		<cfargument name="earAddress" type="string" required="yes">
		<cfargument name="earCity" type="string" required="yes">
		<cfargument name="earStateProv" type="string" required="yes">
		<cfargument name="earZipCode" type="string" required="yes">
		<cfargument name="earCountry" type="string" required="yes">
		<cfargument name="earTelArea" type="string" required="yes">
		<cfargument name="earTelPrefix" type="string" required="yes">
		<cfargument name="earTelSuffix" type="string" required="yes">
		<cfargument name="earEmail" type="string" required="yes">
		<cfargument name="eartID" type="numeric" required="yes">
		
		<cfset result.message = "You have successfully created a Reference record.">
		
		<cftry>
			
			<!---Check for duplicate record--->			
			<cfinvoke 
				component="MCMS.component.app.career.Career"
				method="getCareerApplicantReference"
				returnvariable="getCheckCareerApplicantReferenceRet">
					<cfinvokeargument name="eaID" value="#arguments.eaID#"/>
					<cfinvokeargument name="earName" value="#arguments.earName#"/>
					<cfinvokeargument name="earStatus" value="1,2,3"/>
			</cfinvoke>
			
			<cfif getCheckCareerApplicantReferenceRet.Recordcount NEQ 0>
				
				<cfset result.message = "#arguments.earName# already exists, please try again.">
			
			<cfelse>
			
				<cftransaction>
					
					<cfquery datasource="#application.mcmsDSN#">
						
						INSERT INTO tbl_emp_applicant_reference (eaID,earName,earAddress,earCity,earStateProv,earZipCode,earCountry,earTelArea,earTelPrefix,earTelSuffix,earEmail,eartID) VALUES
						(
						<cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.eaID#">,
						<cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.earName#">,
						<cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.earAddress#">,
						<cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.earCity#">,
						<cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.earStateProv#">,
						<cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.earZipCode#">,
						<cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.earCountry#">,
						<cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.earTelArea#">,
						<cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.earTelPrefix#">,
						<cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.earTelSuffix#">,
						<cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.earEmail#">,
						<cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.eartID#">
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
	
	<!---END Insert Statements.--->
	
	<!---BEGIN Update Statements.--->
	
	<cffunction name="updateCareerApplicantSecurityKeyRel" access="public" returntype="struct">
		
		<cfargument name="eaID" type="numeric" required="yes">
		<cfargument name="easkrKey" type="string" required="yes">
		<cfargument name="easkrKeyValue" type="string" required="yes">
		
		<cfset result.message = "You have successfully inserted the record.">
		
		<cftry>
			
			<cftransaction>
				
				<cfquery datasource="#application.mcmsDSN#">
					
					UPDATE tbl_emp_applicant_sec_key_rel SET
					easkrKey = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.easkrKey#">,
					easkrKeyValue = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.easkrKeyValue#">   
					WHERE eaID = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.eaID#">
					
				</cfquery>
				
			</cftransaction>
			
			<cfcatch type="any">
				
				<cfset result.message = "There was an error inserting the record.">
				
			</cfcatch>
			
		</cftry>
		
		<cfreturn result>
		
	</cffunction>
	
	<cffunction name="updateCareerApplicant" access="public" returntype="struct">
		
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
		
		<cfset result.message = "You have successfully saved your Personal information.">
		
		<cftry>
			
			<!---Check for a duplicate record.--->		
			<cfinvoke 
				component="MCMS.component.app.career.Career"
				method="getCareerApplicant"
				returnvariable="getCheckCareerApplicantRet">
					<cfinvokeargument name="excludeID" value="#arguments.ID#"/>
					<cfinvokeargument name="eaEmail" value="#arguments.eaEmail#"/>
					<cfinvokeargument name="eaStatus" value="1,2,3"/>
			</cfinvoke>
			
			<cfif getCheckCareerApplicantRet.Recordcount NEQ 0>
				
				<cfset result.message = "The email #arguments.eaEmail# already exists in our system, please try again.">
				
			<cfelse>
			
				<!---If encryption is used and no value is present create it.--->
				<cfinvoke 
					component="MCMS.component.app.security.Security"
					method="setEcryption"
					returnvariable="setEcryptionRet">
						<cfinvokeargument name="value" value="#arguments.eaPassword#"/>
						<cfinvokeargument name="valuePair" value="lorem"/>
				</cfinvoke>
				
				<cfset eaPasswordEncrypt = setEcryptionRet.encryptKey>
				
				<cfinvoke 
					component="MCMS.component.app.career.Career"
					method="updateCareerApplicantSecurityKeyRel">
						<cfinvokeargument name="eaID" value="#arguments.ID#"/>
						<cfinvokeargument name="easkrKey" value="#setEcryptionRet.encryptKey#"/>
						<cfinvokeargument name="easkrKeyValue" value="#setEcryptionRet.encryptKeyValue#"/>
				</cfinvoke>
				
				<cftransaction>
					
					<cfquery datasource="#application.mcmsDSN#">
						
						UPDATE tbl_employment_applicant SET
						eaFName = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.eaFName#">,
						eaLName = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.eaLName#">,
						eaEmail = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.eaEmail#">,
						eaPassword = <cfqueryparam cfsqltype="cf_sql_varchar" value="#eaPasswordEncrypt#">,
						eaAddress = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.eaAddress#">,
						eaCity = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.eaCity#">,
						eaStateProv = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.eaStateProv#">,
						eaZipCode = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.eaZipCode#">,
						eaZipCodeExt = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.eaZipCodeExt#">,
						eaCountry = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.eaCountry#">,
						eaTelArea = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.eaTelArea#">,
						eaTelPrefix = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.eaTelPrefix#">,
						eaTelSuffix = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.eaTelSuffix#">, 
						eaDateAvailable = <cfqueryparam cfsqltype="cf_sql_date" value="#arguments.eaDateAvailable#">,
						eaStatus = <cfqueryparam cfsqltype="cf_sql_integer" value="1">
						WHERE ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.ID#">
						
					</cfquery>
					
				</cftransaction>
				
				<cfif arguments.mcmsRedirect NEQ '' AND getCheckCareerApplicantRet.eaFile NEQ ''>
					
					<!---Redirect to path requested if authentication is successful.--->
					<cflocation url="#urlDecode(arguments.mcmsRedirect)#" addtoken="no">
					
				</cfif>
			
			</cfif>
	
			<cfcatch type="any">
				
				<cfset result.message = "There was an error updating your personal information. Please contact site administrator.">
	
			</cfcatch>
		
		</cftry>

		<cfreturn result>
		
	</cffunction>
	
	<cffunction name="updateCareerApplicantResume" access="public" returntype="struct">
		
		<cfargument name="ID" type="numeric" required="yes">
		<cfargument name="eaFile" type="string" required="yes">
		
		<cfset result.message = "You have successfully uploaded your resume.">
		
		<cftry>
			
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
					WHERE ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.ID#">
				
				</cfquery>
			
			</cftransaction>
			
			</cfif>
			
			<cfcatch type="any">
				
				<cfset result.message = "There was an error updating your resume information. Please contact Customer Service.">
				
			</cfcatch>
			
		</cftry>

		<cfreturn result>
		
	</cffunction>
	
	<!---END Update Statements.--->
	
	<!---BEGIN Delete Statements.--->
	
	<cffunction name="deleteCareerApplicantEducation" access="public" returntype="struct">
		
		<cfargument name="ID" type="string" required="yes">
		
		<cfset result.message = "You have successfully deleted the Education record(s).">
		
		<cftry>
			
			<cftransaction>
				
				<cfquery datasource="#application.mcmsDSN#">
					
					DELETE FROM tbl_emp_applicant_education
					WHERE ID IN (<cfqueryparam cfsqltype="cf_sql_integer" list="yes" value="#arguments.ID#">)
					
				</cfquery>
				
			</cftransaction>
			
			<cfcatch type="any">
				
				<cfset result.message = "There was an error deleting the record(s).">  
				 
			</cfcatch>
			
		</cftry>
		
		<cfreturn result>
		
	</cffunction>
	
	<cffunction name="deleteCareerApplicantEmployer" access="public" returntype="struct">
		
		<cfargument name="ID" type="string" required="yes">
		
		<cfset result.message = "You have successfully deleted the Employer record(s).">
		
		<cftry>
			
			<cftransaction>
				
				<cfquery datasource="#application.mcmsDSN#">
					
					DELETE FROM tbl_emp_applicant_employer
					WHERE ID IN (<cfqueryparam cfsqltype="cf_sql_integer" list="yes" value="#arguments.ID#">)
					
				</cfquery>
				
			</cftransaction>
			
			<cfcatch type="any">
				
				<cfset result.message = "There was an error deleting the record(s).">   
				
			</cfcatch>
			
		</cftry>
		
		<cfreturn result>
		
	</cffunction> 
	
	<cffunction name="deleteCareerApplicantReference" access="public" returntype="struct">
		
		<cfargument name="ID" type="string" required="yes">
		
		<cfset result.message = "You have successfully deleted the Reference record(s).">
		
		<cftry>
			
			<cftransaction>
				
				<cfquery datasource="#application.mcmsDSN#">
					
					DELETE FROM tbl_emp_applicant_reference
					WHERE ID IN (<cfqueryparam cfsqltype="cf_sql_integer" list="yes" value="#arguments.ID#">)
					
				</cfquery>
			
			</cftransaction>
			
			<cfcatch type="any">
				
				<cfset result.message = "There was an error deleting the record(s)."> 
			  
			</cfcatch>
		
		</cftry>
		
		<cfreturn result>
		
	</cffunction>
	
	<!---END Delete Statements.--->
	
	<!---BEGIN Set Operations.--->
	
	<cffunction name="setSignIn" access="public" returntype="struct" hint="Authenticate applicants to profile administration site.">
		
		<cfargument name="eaEmail" type="string" required="yes" default="">
		<cfargument name="eaPassword" type="string" required="yes" default="">
		<cfargument name="accessDenied" type="string" required="yes" default="">
		
		<cfset result.status = false>
		<cfset result.message = 'You have successfully Signed In.'>
		
		<cftry>
			
			<!---If encryption is used and a value is present.--->
			<cfinvoke 
				component="MCMS.component.app.career.Career"
				method="getCareerApplicantSecurityKeyRel"
				returnvariable="getCareerApplicantSecurityKeyRelRet">
					<cfinvokeargument name="eaEmail" value="#arguments.eaEmail#"/>
					<cfinvokeargument name="easkrStatus" value="1"/>
			</cfinvoke>
			
			<cfif getCareerApplicantSecurityKeyRelRet.Recordcount NEQ 0>
				
				<cfset this.easkrKey = getCareerApplicantSecurityKeyRelRet.easkrKey>
				<cfset this.easkrKeyValue = getCareerApplicantSecurityKeyRelRet.easkrKeyValue>
				
				<cfinvoke 
					component="MCMS.component.app.security.Security"
					method="setDecryption"
					returnvariable="setDecryptionRet">
						<cfinvokeargument name="encryptKey" value="#this.easkrKey#"/>
						<cfinvokeargument name="encryptKeyValue" value="#this.easkrKeyValue#"/>
				</cfinvoke>
				
				<cfif setDecryptionRet EQ arguments.eaPassword>
					<cfset result.status = true>
				</cfif>
			
			</cfif>
			
			<!---If the security key is a match proceed.--->
			<cfif result.status EQ false>
					
				<cfset result.message = 'You have not successfully Signed In. Please try again or click the "Reset Password" option to have your email reset.<br/><br/>
			<a href="?mcmsPageID=resetPasswordRequest&userEmail=#arguments.eaEmail#">Reset Password</a>'>
			
			<cfelse>
			
				<cfquery name="rsSignIn" datasource="#application.mcmsDSN#">
					
					SELECT * FROM tbl_employment_applicant
					WHERE 0=0 
					AND UPPER(eaEmail) = <cfqueryparam value="#UCASE(arguments.eaEmail)#" cfsqltype="cf_sql_varchar">
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
						
						<cfcookie name="MCMS#UCASE(application.applicationname)#" value="#arguments.eaEmail#" expires="never">
						
					<!--- Else, clean any existing COOKIE --->
					<cfelse>
					
						<cfcookie name="MCMS#UCASE(application.applicationname)#" value="" expires="now">
					
					</cfif>
					
					<!---Redirect to path requested if authentication is successful.--->
					<cflocation url="#urlDecode(arguments.accessDenied)#" addtoken="no">
					
				</cfif>
				
			</cfif>

			<cfcatch type="any">
				
				<cfset result.status = false>
				<cfset result.message = 'An error occured when accessing the Applicant record.'>
				
			</cfcatch>
			
		</cftry>

		<cfreturn result>
		
	</cffunction>
	
	<cffunction name="setResetPasswordRequest" access="public" returntype="struct" hint="Send reset email to end user to reset password.">
		
		<cfargument name="eaEmail" type="string" required="yes" default="">
		
		<cfset result.message = 'You have successfully sent your reset password request. Check your email to reset your password. Your reset request will expire soon.'>
		
		<cfset thisDate = DateAdd('n', 10, Now())>
		
		<cftry>
			
			<!---Get the userID for the applicant.--->
			<cfinvoke 
				component="MCMS.component.app.career.Career"
				method="getCareerApplicant"
				returnvariable="getCareerApplicantRet">
					<cfinvokeargument name="eaEmail" value="#arguments.eaEmail#"/>
					<cfinvokeargument name="eaStatus" value="1,2,3"/>
			</cfinvoke>
			
			<cfif getCareerApplicantRet.Recordcount EQ 0>
			
				<cfset result.message = 'The email you entered could not be found. Please try again or register a new account.'>	
				
			<cfelse>
			
				<cfset this.userID = getCareerApplicantRet.ID>
			
				<!---Create a reset token.--->
				<cfset this.passwordToken = LEFT(arguments.eaEmail, 4) & RandRange(10000, 999999) & MID(arguments.eaEmail, 6, 3)>
			
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
						<cfinvokeargument name="to" value="#arguments.eaEmail#"/>
						<cfinvokeargument name="from" value="#application.noReplyEmail#"/>
						<cfinvokeargument name="body" value="#body#"/>
				</cfinvoke>
			
			</cfif>

			<cfcatch type="any">
				
				<cfset result.status = false>
				<cfset result.message = 'An error occured when accessing requesting a password reset.'>
				
			</cfcatch>
			
		</cftry>

		<cfreturn result>
		
	</cffunction>
	
	<cffunction name="setResetPassword" access="public" returntype="struct" hint="Reset the users password.">
		
		<cfargument name="userPassword" type="string" required="yes">
		<cfargument name="mcmsToken" type="string" required="yes">
		
		<cfset result.message = 'You have successfully reset your password. <br/><br/> <a href="#application.mcmsAuthenticatePath#">Sign In</a>'>
		
		<cftry>
			<!---Check for the token.--->
			<cfinvoke 
				component="MCMS.component.cms.User"
				method="getUserToken"
				returnvariable="getUserTokenRet">
					<cfinvokeargument name="utToken" value="#arguments.mcmsToken#"/>
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
						<cfinvokeargument name="value" value="#arguments.userPassword#"/>
						<cfinvokeargument name="valuePair" value="lorem"/>
				</cfinvoke>
			
				<cfset this.passwordEncrypt = setEcryptionRet.encryptKey>
			
				<cfinvoke 
					component="MCMS.component.app.career.Career"
					method="updateCareerApplicantSecurityKeyRel">
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

			<cfcatch type="any">
				
				<cfset result.status = false>
				<cfset result.message = 'An error occured when accessing requesting a password reset.'>
			
			</cfcatch>
			
		</cftry>

		<cfreturn result>
		
	</cffunction>

</cfcomponent>