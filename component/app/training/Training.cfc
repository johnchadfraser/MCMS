<cfcomponent>
    <cffunction name="getTraining" access="public" returntype="query" hint="Get Training data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="ID" type="numeric" required="yes" default="0">
    <cfargument name="excludeID" type="numeric" required="yes" default="0">
    <cfargument name="tName" type="string" required="yes" default="">
    <cfargument name="tDateRel" type="string" required="yes" default="">
    <cfargument name="tDateExp" type="string" required="yes" default="">
    <cfargument name="tURL" type="string" required="yes" default="">
    <cfargument name="ttID" type="string" required="yes" default="0">
    <cfargument name="tStatus" type="string" required="yes" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="tName">
    <cfset var rsTraining = "" >
    <cftry>
    <cfquery name="rsTraining" datasource="#application.mcmsDSN#">
    SELECT * FROM v_training WHERE 0=0
    <cfif ARGUMENTS.ID NEQ 0>
    AND ID = <cfqueryparam value="#ARGUMENTS.ID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.excludeID NEQ 0>
    AND ID <> <cfqueryparam value="#ARGUMENTS.excludeID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(tName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(tDescription) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">)
    </cfif>
    <cfif ARGUMENTS.tName NEQ "">
    AND UPPER(tName) = <cfqueryparam value="#UCASE(ARGUMENTS.tName)#" cfsqltype="cf_sql_varchar">
    </cfif>
    <cfif ARGUMENTS.tDateRel NEQ "">
    AND tDateRel >= <cfqueryparam value="#ARGUMENTS.tDateRel#" cfsqltype="cf_sql_date">
    </cfif>
    <cfif ARGUMENTS.tDateExp NEQ "">
    AND tDateExp <= <cfqueryparam value="#ARGUMENTS.tDateExp#" cfsqltype="cf_sql_date">
    </cfif>
    <cfif ARGUMENTS.ttID NEQ 0>
    AND ttID = <cfqueryparam value="#ARGUMENTS.ttID#" cfsqltype="cf_sql_integer">
    </cfif>
    AND tStatus IN (<cfqueryparam value="#ARGUMENTS.tStatus#" list="yes" cfsqltype="cf_sql_integer">)
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsTraining = StructNew()>
    <cfset rsTraining.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsTraining>
    </cffunction>
    
    <cffunction name="getTrainingType" access="public" returntype="query" hint="Get Training Type data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="ID" type="numeric" required="yes" default="0">
    <cfargument name="excludeID" type="numeric" required="yes" default="0">
    <cfargument name="ttStatus" type="string" required="yes" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="ttName">
    <cfset var rsTrainingType = "" >
    <cftry>
    <cfquery name="rsTrainingType" datasource="#application.mcmsDSN#">
    SELECT * FROM tbl_training_type WHERE 0=0
    <cfif ARGUMENTS.ID NEQ 0>
    AND ID = <cfqueryparam value="#ARGUMENTS.ID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.excludeID NEQ 0>
    AND ID <> <cfqueryparam value="#ARGUMENTS.excludeID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND UPPER(ttName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">
    </cfif>
    AND ttStatus IN (<cfqueryparam value="#ARGUMENTS.ttStatus#" list="yes" cfsqltype="cf_sql_integer">)
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsTrainingType = StructNew()>
    <cfset rsTrainingType.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsTrainingType>
    </cffunction>
    
    <cffunction name="getTrainingMethodType" access="public" returntype="query" hint="Get Training Method Type data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="ID" type="numeric" required="yes" default="0">
    <cfargument name="excludeID" type="numeric" required="yes" default="0">
    <cfargument name="tmtStatus" type="string" required="yes" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="tmtName">
    <cfset var rsTrainingMethodType = "" >
    <cftry>
    <cfquery name="rsTrainingMethodType" datasource="#application.mcmsDSN#">
    SELECT * FROM v_training_method_type WHERE 0=0
    <cfif ARGUMENTS.ID NEQ 0>
    AND ID = <cfqueryparam value="#ARGUMENTS.ID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.excludeID NEQ 0>
    AND ID <> <cfqueryparam value="#ARGUMENTS.excludeID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND UPPER(tmtName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">
    </cfif>
    AND tmtStatus IN (<cfqueryparam value="#ARGUMENTS.tmtStatus#" list="yes" cfsqltype="cf_sql_integer">)
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsTrainingMethodType = StructNew()>
    <cfset rsTrainingMethodType.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsTrainingMethodType>
    </cffunction>
    
    <cffunction name="getTrainingDeliveryType" access="public" returntype="query" hint="Get Training Delivery Type data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="ID" type="numeric" required="yes" default="0">
    <cfargument name="excludeID" type="numeric" required="yes" default="0">
    <cfargument name="tdtStatus" type="string" required="yes" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="tdtName">
    <cfset var rsTrainingDeliveryType = "" >
    <cftry>
    <cfquery name="rsTrainingDeliveryType" datasource="#application.mcmsDSN#">
    SELECT * FROM tbl_training_delivery_type WHERE 0=0
    <cfif ARGUMENTS.ID NEQ 0>
    AND ID = <cfqueryparam value="#ARGUMENTS.ID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.excludeID NEQ 0>
    AND ID <> <cfqueryparam value="#ARGUMENTS.excludeID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND UPPER(tdtName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">
    </cfif>
    AND tdtStatus IN (<cfqueryparam value="#ARGUMENTS.tdtStatus#" list="yes" cfsqltype="cf_sql_integer">)
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsTrainingDeliveryType = StructNew()>
    <cfset rsTrainingDeliveryType.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsTrainingDeliveryType>
    </cffunction>
    
    <cffunction name="getTrainingDepartmentRel" access="public" returntype="query" hint="Get Training Department Relationship data.">
    <cfargument name="keywords" type="string" required="no" default="All">
    <cfargument name="ID" type="numeric" required="yes" default="0">
    <cfargument name="tID" type="numeric" required="yes" default="0">
    <cfargument name="deptNo" type="string" required="yes" default="0">
    <cfargument name="tdrStatus" type="string" required="yes" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="deptNo">
	<cfset var rsTrainingDepartmentRel = "" >
    <cftry>
    <cfquery name="rsTrainingDepartmentRel" datasource="#application.mcmsDSN#">
    SELECT * FROM tbl_training_department_rel WHERE 0=0
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND deptNo LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> 
    </cfif>
    <cfif ARGUMENTS.ID NEQ 0>
    AND ID = <cfqueryparam value="#ARGUMENTS.ID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.tID NEQ 0>
    AND tID = <cfqueryparam value="#ARGUMENTS.tID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.deptNo NEQ 0>
    AND deptNo IN (<cfqueryparam value="#ARGUMENTS.deptNo#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    AND tdrStatus IN (<cfqueryparam value="#ARGUMENTS.tdrStatus#" list="yes" cfsqltype="cf_sql_integer">)
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsTrainingDepartmentRel = StructNew()>
    <cfset rsTrainingDepartmentRel.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsTrainingDepartmentRel>
    </cffunction>
    
    <cffunction name="getTrainingListing" access="public" returntype="query" hint="Get Training data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="ID" type="numeric" required="yes" default="0">
    <cfargument name="excludeID" type="numeric" required="yes" default="0">
    <cfargument name="tlName" type="string" required="yes" default="">
    <cfargument name="tID" type="string" required="yes" default="0">
    <cfargument name="tStatus" type="string" required="no" default="1">
    <cfargument name="tlStatus" type="string" required="yes" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="tName">
    <cfset var rsTrainingListing = "" >
    <cftry>
    <cfquery name="rsTrainingListing" datasource="#application.mcmsDSN#">
    SELECT * FROM v_training_listing WHERE 0=0
    <cfif ARGUMENTS.ID NEQ 0>
    AND ID = <cfqueryparam value="#ARGUMENTS.ID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.excludeID NEQ 0>
    AND ID <> <cfqueryparam value="#ARGUMENTS.excludeID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(tlName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(tlDescription) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">)
    </cfif>
    <cfif ARGUMENTS.tlName NEQ "">
    AND UPPER(tlName) = <cfqueryparam value="#UCASE(ARGUMENTS.tlName)#" cfsqltype="cf_sql_varchar">
    </cfif>
    AND tStatus IN (<cfqueryparam value="#ARGUMENTS.tStatus#" list="yes" cfsqltype="cf_sql_integer">)
    AND tlStatus IN (<cfqueryparam value="#ARGUMENTS.tlStatus#" list="yes" cfsqltype="cf_sql_integer">)
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsTrainingListing = StructNew()>
    <cfset rsTrainingListing.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsTrainingListing>
    </cffunction>
    
    <cffunction name="getTrainingListingSiteRel" access="public" returntype="query" hint="Get Training Listing Site Relationship data.">
    <cfargument name="keywords" type="string" required="no" default="All">
    <cfargument name="ID" type="numeric" required="yes" default="0">
    <cfargument name="tID" type="numeric" required="yes" default="0">
    <cfargument name="tlID" type="numeric" required="yes" default="0">
    <cfargument name="siteNo" type="string" required="yes" default="100">
    <cfargument name="tlsrStatus" type="string" required="yes" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="siteNo">
	<cfset var rsTrainingListingSiteRel = "" >
    <cftry>
    <cfquery name="rsTrainingListingSiteRel" datasource="#application.mcmsDSN#">
    SELECT * FROM tbl_training_listing_site_rel WHERE 0=0
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND siteName LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> 
    </cfif>
    <cfif ARGUMENTS.ID NEQ 0>
    AND ID = <cfqueryparam value="#ARGUMENTS.ID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.tID NEQ 0>
    AND tID = <cfqueryparam value="#ARGUMENTS.tID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.tlID NEQ 0>
    AND tlID = <cfqueryparam value="#ARGUMENTS.tlID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.siteNo NEQ 100>
    AND siteNo IN (<cfqueryparam value="#ARGUMENTS.siteNo#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    AND tlsrStatus IN (<cfqueryparam value="#ARGUMENTS.tlsrStatus#" list="yes" cfsqltype="cf_sql_integer">)
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsTrainingListingSiteRel = StructNew()>
    <cfset rsTrainingListingSiteRel.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsTrainingListingSiteRel>
    </cffunction>
    
    <cffunction name="getTrainingListingUserRel" access="public" returntype="query" hint="Get Training Listing User Relationship data.">
    <cfargument name="keywords" type="string" required="no" default="All">
    <cfargument name="ID" type="numeric" required="yes" default="0">
    <cfargument name="tID" type="numeric" required="yes" default="0">
    <cfargument name="tlID" type="numeric" required="yes" default="0">
    <cfargument name="tuID" type="string" required="yes" default="0">
    <cfargument name="turStatus" type="string" required="yes" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="tName, tuLName">
	<cfset var rsTrainingListingUserRel = "" >
    <cftry>
    <cfquery name="rsTrainingListingUserRel" datasource="#application.mcmsDSN#">
    SELECT * FROM v_training_listing_user_rel WHERE 0=0
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (tuFName LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR
    tuLName LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR tName LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">)
    </cfif>
    <cfif ARGUMENTS.ID NEQ 0>
    AND ID = <cfqueryparam value="#ARGUMENTS.ID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.tID NEQ 0>
    AND tID = <cfqueryparam value="#ARGUMENTS.tID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.tlID NEQ 0>
    AND tlID = <cfqueryparam value="#ARGUMENTS.tlID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.tuID NEQ 0>
    AND tuID IN (<cfqueryparam value="#ARGUMENTS.tuID#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    AND turStatus IN (<cfqueryparam value="#ARGUMENTS.turStatus#" list="yes" cfsqltype="cf_sql_integer">)
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsTrainingListingUserRel = StructNew()>
    <cfset rsTrainingListingUserRel.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsTrainingListingUserRel>
    </cffunction>
    
    <cffunction name="getTrainingListingHostRel" access="public" returntype="query" hint="Get Training Listing Host Relationship data.">
    <cfargument name="keywords" type="string" required="no" default="All">
    <cfargument name="ID" type="numeric" required="yes" default="0">
    <cfargument name="tID" type="numeric" required="yes" default="0">
    <cfargument name="tlID" type="numeric" required="yes" default="0">
    <cfargument name="tuID" type="string" required="yes" default="0">
    <cfargument name="tlhrStatus" type="string" required="yes" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="tuLName">
	<cfset var rsTrainingListingHostRel = "" >
    <cftry>
    <cfquery name="rsTrainingListingHostRel" datasource="#application.mcmsDSN#">
    SELECT * FROM v_training_listing_host_rel WHERE 0=0
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND tlName LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> 
    </cfif>
    <cfif ARGUMENTS.ID NEQ 0>
    AND ID = <cfqueryparam value="#ARGUMENTS.ID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.tID NEQ 0>
    AND tID = <cfqueryparam value="#ARGUMENTS.tID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.tlID NEQ 0>
    AND tlID = <cfqueryparam value="#ARGUMENTS.tlID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.tuID NEQ 0>
    AND tuID IN (<cfqueryparam value="#ARGUMENTS.tuID#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    AND tlhrStatus IN (<cfqueryparam value="#ARGUMENTS.tlhrStatus#" list="yes" cfsqltype="cf_sql_integer">)
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsTrainingListingHostRel = StructNew()>
    <cfset rsTrainingListingHostRel.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsTrainingListingHostRel>
    </cffunction>
    
    <cffunction name="getTrainingListingPresenterRel" access="public" returntype="query" hint="Get Training Listing Presenter Relationship data.">
    <cfargument name="keywords" type="string" required="no" default="All">
    <cfargument name="ID" type="numeric" required="yes" default="0">
    <cfargument name="tID" type="numeric" required="yes" default="0">
    <cfargument name="tlID" type="numeric" required="yes" default="0">
    <cfargument name="tuID" type="string" required="yes" default="0">
    <cfargument name="tlprStatus" type="string" required="yes" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="tuLName">
	<cfset var rsTrainingListingPresenterRel = "" >
    <cftry>
    <cfquery name="rsTrainingListingPresenterRel" datasource="#application.mcmsDSN#">
    SELECT * FROM v_training_l_presenter_rel WHERE 0=0
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND tlName LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> 
    </cfif>
    <cfif ARGUMENTS.ID NEQ 0>
    AND ID = <cfqueryparam value="#ARGUMENTS.ID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.tID NEQ 0>
    AND tID = <cfqueryparam value="#ARGUMENTS.tID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.tlID NEQ 0>
    AND tlID = <cfqueryparam value="#ARGUMENTS.tlID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.tuID NEQ 0>
    AND tuID IN (<cfqueryparam value="#ARGUMENTS.tuID#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    AND tlprStatus IN (<cfqueryparam value="#ARGUMENTS.tlprStatus#" list="yes" cfsqltype="cf_sql_integer">)
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsTrainingListingPresenterRel = StructNew()>
    <cfset rsTrainingListingPresenterRel.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsTrainingListingPresenterRel>
    </cffunction>
    
    <cffunction name="getTrainingListingAdobeConnectUserGroupAccessRel" access="public" returntype="query" hint="Get Training Listing Adobe Connect User Group Access Relationship data.">
    <cfargument name="keywords" type="string" required="no" default="All">
    <cfargument name="ID" type="numeric" required="yes" default="0">
    <cfargument name="tlID" type="numeric" required="yes" default="0">
    <cfargument name="acugID" type="numeric" required="yes" default="0">
    <cfargument name="tlacugarStatus" type="string" required="yes" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="acugID">
	<cfset var rsTrainingListingAdobeConnectUserGroupAccessRel = "" >
    <cftry>
    <cfquery name="rsTrainingListingAdobeConnectUserGroupAccessRel" datasource="#application.mcmsDSN#">
    SELECT * FROM v_training_l_ac_ug_a_rel WHERE 0=0
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND acugID LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> 
    </cfif>
    <cfif ARGUMENTS.ID NEQ 0>
    AND ID = <cfqueryparam value="#ARGUMENTS.ID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.tlID NEQ 0>
    AND tlID = <cfqueryparam value="#ARGUMENTS.tlID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.acugID NEQ 0>
    AND acugID = <cfqueryparam value="#ARGUMENTS.acugID#" cfsqltype="cf_sql_integer">
    </cfif>
    AND tlacugarStatus IN (<cfqueryparam value="#ARGUMENTS.tlacugarStatus#" list="yes" cfsqltype="cf_sql_integer">)
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsTrainingListingAdobeConnectUserGroupAccessRel = StructNew()>
    <cfset rsTrainingListingAdobeConnectUserGroupAccessRel.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsTrainingListingAdobeConnectUserGroupAccessRel>
    </cffunction>
    
    <cffunction name="getTrainingListingTimeTableRel" access="public" returntype="query" hint="Get Training Listing Time Table Rel. data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="ID" type="numeric" required="yes" default="0">
    <cfargument name="excludeID" type="numeric" required="yes" default="0">
    <cfargument name="tlName" type="string" required="yes" default="">
    <cfargument name="tID" type="string" required="yes" default="0">
    <cfargument name="tlID" type="string" required="yes" default="0">
    <cfargument name="dayID" type="string" required="yes" default="0">
    <cfargument name="timeIDStart" type="numeric" required="yes" default="0">
    <cfargument name="timeIDEnd" type="numeric" required="yes" default="0">
    <cfargument name="tlStatus" type="string" required="yes" default="1,3">
    <cfargument name="tltrStatus" type="string" required="yes" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="tlName, daySort, tlSort, tlDateStart DESC">
    <cfset var rsTrainingListingTimeTableRel = "" >
    <cftry>
    <cfquery name="rsTrainingListingTimeTableRel" datasource="#application.mcmsDSN#">
    SELECT * FROM v_training_l_timetable_rel WHERE 0=0
    <cfif ARGUMENTS.ID NEQ 0>
    AND ID = <cfqueryparam value="#ARGUMENTS.ID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.excludeID NEQ 0>
    AND ID <> <cfqueryparam value="#ARGUMENTS.excludeID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(tlName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(tName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(tlDescription) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(dayName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">)
    </cfif>
    <cfif ARGUMENTS.tID NEQ 0>
    AND tID IN (<cfqueryparam value="#ARGUMENTS.tID#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    <cfif ARGUMENTS.tlID NEQ 0>
    AND tlID IN (<cfqueryparam value="#ARGUMENTS.tlID#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    <cfif ARGUMENTS.dayID NEQ 0>
    AND dayID IN (<cfqueryparam value="#ARGUMENTS.dayID#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    <cfif ARGUMENTS.timeIDStart NEQ 0>
    AND timeIDStart = <cfqueryparam value="#ARGUMENTS.timeIDStart#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.timeIDEnd NEQ 0>
    AND timeIDEnd = <cfqueryparam value="#ARGUMENTS.timeIDEnd#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.tlName NEQ "">
    AND UPPER(tlName) = <cfqueryparam value="#UCASE(ARGUMENTS.tlName)#" cfsqltype="cf_sql_varchar">
    </cfif>
    AND tlStatus IN (<cfqueryparam value="#ARGUMENTS.tlStatus#" list="yes" cfsqltype="cf_sql_integer">)
    AND tltrStatus IN (<cfqueryparam value="#ARGUMENTS.tltrStatus#" list="yes" cfsqltype="cf_sql_integer">)
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsTrainingListingTimeTableRel = StructNew()>
    <cfset rsTrainingListingTimeTableRel.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsTrainingListingTimeTableRel>
    </cffunction>
    
    <cffunction name="getTrainingUser" access="public" returntype="query" hint="Get Training User data.">
    <cfargument name="keywords" type="string" required="no" default="All">
    <cfargument name="ID" type="numeric" required="yes" default="0">
    <cfargument name="excludeID" type="numeric" required="yes" default="0">
    <cfargument name="acuID" type="numeric" required="yes" default="0">
    <cfargument name="tuHost" type="string" required="yes" default="">
    <cfargument name="tuPresenter" type="string" required="yes" default="">
    <cfargument name="tuUsername" type="string" required="yes" default="">
    <cfargument name="tuStatus" type="string" required="yes" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="tuLName, tuFName">
	<cfset var rsTrainingUser = "" >
    <cftry>
    <cfquery name="rsTrainingUser" datasource="#application.mcmsDSN#">
    SELECT * FROM v_training_user WHERE 0=0
    <cfif ARGUMENTS.ID NEQ 0>
    AND ID = <cfqueryparam value="#ARGUMENTS.ID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.excludeID NEQ 0>
    AND ID <> <cfqueryparam value="#ARGUMENTS.excludeID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(tuFName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(tuLName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(tuUsername) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">)
    </cfif>
    <cfif ARGUMENTS.acuID NEQ 0>
    AND acuID = <cfqueryparam value="#ARGUMENTS.acuID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.tuHost NEQ "">
    AND tuHost = <cfqueryparam value="#ARGUMENTS.tuHost#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.tuPresenter NEQ "">
    AND tuPresenter = <cfqueryparam value="#ARGUMENTS.tuPresenter#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.tuUsername NEQ "">
    AND UPPER(tuUsername) = <cfqueryparam value="#UCASE(ARGUMENTS.tuUsername)#" cfsqltype="cf_sql_varchar">
    </cfif>
    AND tuStatus IN (<cfqueryparam value="#ARGUMENTS.tuStatus#" list="yes" cfsqltype="cf_sql_integer">)
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsTrainingUser = StructNew()>
    <cfset rsTrainingUser.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsTrainingUser>
    </cffunction>

    <cffunction name="getTrainingUserSiteDepartmentRel" access="public" returntype="query" hint="Get Training User Site/Department Rel. data.">
    <cfargument name="keywords" type="string" required="no" default="All">
    <cfargument name="ID" type="numeric" required="yes" default="0">
    <cfargument name="excludeUsername" type="string" required="yes" default="0">
    <cfargument name="tusdrStatus" type="string" required="yes" default="1,3">
    <cfargument name="uaID" type="string" required="yes" default="0">
    <cfargument name="orderBy" type="string" required="yes" default="tuFName, tuLName">
    <!---Relationship arguments.--->
    <cfargument name="siteNo" type="string" required="yes" default="100">
    <cfargument name="deptNo" type="string" required="yes" default="0">
	<cfset var rsTrainingUserSiteDepartmentRel = "" >
    <cftry>
    <cfset this.userIDList = 0>
    <!---First get users by site.--->
    <cfinvoke 
    component="MCMS.component.app.training.Training"
    method="getTrainingUserSiteRel"
    returnvariable="getTrainingUserSiteRelRet">
    <cfinvokeargument name="keywords" value="#ARGUMENTS.keywords#"/>
    <cfinvokeargument name="siteNo" value="#ARGUMENTS.siteNo#"/>
    <cfinvokeargument name="tusrStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getTrainingUserSiteRelRet.recordcount NEQ 0>
    <cfset this.userIDList = ListPrepend(ValueList(getTrainingUserSiteRelRet.tuID), this.userIDList)>
    </cfif>
    <!---Second get users by department.--->
    <cfinvoke 
    component="MCMS.component.app.training.Training"
    method="getTrainingUserDepartmentRel"
    returnvariable="getTrainingUserDepartmentRelRet">
    <cfinvokeargument name="keywords" value="#ARGUMENTS.keywords#"/>
    <cfif ARGUMENTS.siteNo NEQ 100>
    <cfinvokeargument name="tuID" value="#LEFT(this.userIDList, 4000)#"/>
    </cfif>
    <cfinvokeargument name="deptNo" value="#ARGUMENTS.deptNo#"/>
    <cfinvokeargument name="tudrStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getTrainingUserDepartmentRelRet.recordcount NEQ 0>
    <cfset this.userIDList = ListPrepend(ValueList(getTrainingUserDepartmentRelRet.tuID), this.userIDList)>
    </cfif>
    <!---Clean up the list.--->
    <cfset this.userIDList = ListRemoveDuplicates(this.userIDList)>
    <!---If there are no site users. override.--->
    <cfif ARGUMENTS.siteNo NEQ 100 AND (getTrainingUserSiteRelRet.recordcount EQ 0 OR getTrainingUserDepartmentRelRet.recordcount EQ 0)>
    <cfset this.userIDList = 99>
    </cfif>
    <!---Finalize the query.--->
    <cfquery name="rsTrainingUserSiteDepartmentRel" datasource="#application.mcmsDSN#">
    SELECT * FROM v_training_user WHERE 0=0
    <cfif ARGUMENTS.uaID NEQ 101>
    AND ID IN (<cfqueryparam value="#LEFT(this.userIDList, 4000)#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    <cfif ARGUMENTS.excludeUsername NEQ 0>
    AND tuUsername <> <cfqueryparam value="#ARGUMENTS.excludeUsername#" cfsqltype="cf_sql_varchar">
    </cfif>
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(tuFName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(tuLName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(tuUsername) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">)
    </cfif>
    AND tuStatus IN (<cfqueryparam value="#ARGUMENTS.tusdrStatus#" list="yes" cfsqltype="cf_sql_integer">)
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsTrainingUserSiteDepartmentRel = StructNew()>
    <cfset rsTrainingUserSiteDepartmentRel.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsTrainingUserSiteDepartmentRel>
    </cffunction>
    
    <cffunction name="getTrainingUserSecurityKeyRel" access="public" returntype="query" hint="Get Training User Security Key Relationship data.">
    <cfargument name="ID" type="numeric" required="yes" default="0">
    <cfargument name="tuID" type="numeric" required="yes" default="0">
    <cfargument name="tuUsername" type="string" required="yes" default="">
    <cfargument name="tuskrKey" type="string" required="yes" default="">
    <cfargument name="tuskrStatus" type="string" required="yes" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="ID">
	<cfset var rsTrainingUserSecurityKeyRel = "" >
    <cftry>
    <cfquery name="rsTrainingUserSecurityKeyRel" datasource="#application.mcmsDSN#">
    SELECT * FROM v_training_user_sec_key_rel WHERE 0=0
    <cfif ARGUMENTS.ID NEQ 0>
    AND ID = <cfqueryparam value="#ARGUMENTS.ID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.tuID NEQ 0>
    AND tuID = <cfqueryparam value="#ARGUMENTS.tuID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.tuUsername NEQ "">
    AND UPPER(tuUsername) = <cfqueryparam value="#UCASE(ARGUMENTS.tuUsername)#" cfsqltype="cf_sql_varchar">
    </cfif>
    <cfif ARGUMENTS.tuskrKey NEQ "">
    AND tuskrKey = <cfqueryparam value="#ARGUMENTS.tuskrKey#" cfsqltype="cf_sql_varchar">
    </cfif>
    AND tuskrStatus IN (<cfqueryparam value="#ARGUMENTS.tuskrStatus#" list="yes" cfsqltype="cf_sql_integer">)
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsTrainingUserSecurityKeyRel = StructNew()>
    <cfset rsTrainingUserSecurityKeyRel.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsTrainingUserSecurityKeyRel>
    </cffunction>
    
    <cffunction name="getTrainingUserSecurityQuestion" access="public" returntype="query" hint="Get Training User Security Question data.">
    <cfargument name="keywords" type="string" required="no" default="All">
    <cfargument name="ID" type="numeric" required="yes" default="0">
    <cfargument name="excludeID" type="numeric" required="yes" default="0">
    <cfargument name="tusqQuestion" type="string" required="yes" default="">
    <cfargument name="tusqStatus" type="string" required="yes" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="tusqSort">
	<cfset var rsTrainingUserSecurityQuestion = "" >
    <cftry>
    <cfquery name="rsTrainingUserSecurityQuestion" datasource="#application.mcmsDSN#">
    SELECT * FROM v_training_user_sq WHERE 0=0
    <cfif ARGUMENTS.ID NEQ 0>
    AND ID = <cfqueryparam value="#ARGUMENTS.ID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.excludeID NEQ 0>
    AND ID <> <cfqueryparam value="#ARGUMENTS.excludeID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(tusqQuestion) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">)
    </cfif>
    <cfif ARGUMENTS.tusqQuestion NEQ "">
    AND UPPER(tusqQuestion) = <cfqueryparam value="#UCASE(ARGUMENTS.tusqQuestion)#" cfsqltype="cf_sql_varchar">
    </cfif>
    AND tusqStatus IN (<cfqueryparam value="#ARGUMENTS.tusqStatus#" list="yes" cfsqltype="cf_sql_integer">)
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsTrainingUserSecurityQuestion = StructNew()>
    <cfset rsTrainingUserSecurityQuestion.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsTrainingUserSecurityQuestion>
    </cffunction>
    
    <cffunction name="getTrainingUserSecurityQuestionAnswerRel" access="public" returntype="query" hint="Get Training User Security Question Answer Relationship data.">
    <cfargument name="keywords" type="string" required="no" default="All">
    <cfargument name="ID" type="numeric" required="yes" default="0">
    <cfargument name="excludeID" type="numeric" required="yes" default="0">
    <cfargument name="tuID" type="numeric" required="yes" default="0">
    <cfargument name="tusqID" type="numeric" required="yes" default="0">
    <cfargument name="tusqaAnswer" type="string" required="yes" default="">
    <cfargument name="tusqarStatus" type="string" required="yes" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="ID">
	<cfset var rsTrainingUserSecurityQuestionAnswerRel = "" >
    <cftry>
    <cfquery name="rsTrainingUserSecurityQuestionAnswerRel" datasource="#application.mcmsDSN#">
    SELECT * FROM v_training_user_sq_rel WHERE 0=0
    <cfif ARGUMENTS.ID NEQ 0>
    AND ID = <cfqueryparam value="#ARGUMENTS.ID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.excludeID NEQ 0>
    AND ID <> <cfqueryparam value="#ARGUMENTS.excludeID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(tusqQuestion) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">)
    </cfif>
    <cfif ARGUMENTS.tuID NEQ 0>
    AND tuID = <cfqueryparam value="#ARGUMENTS.tuID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.tusqID NEQ 0>
    AND tusqID = <cfqueryparam value="#ARGUMENTS.tusqID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.tusqQuestion NEQ "">
    AND UPPER(tusqQuestion) = <cfqueryparam value="#UCASE(ARGUMENTS.tusqQuestion)#" cfsqltype="cf_sql_varchar">
    </cfif>
    AND tusqarStatus IN (<cfqueryparam value="#ARGUMENTS.tusqrStatus#" list="yes" cfsqltype="cf_sql_integer">)
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsTrainingUserSecurityQuestionAnswerRel = StructNew()>
    <cfset rsTrainingUserSecurityQuestionAnswerRel.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsTrainingUserSecurityQuestionAnswerRel>
    </cffunction>
    
    <cffunction name="getTrainingAdobeConnectUserGroupRel" access="public" returntype="query" hint="Get Training Adobe Connect User Group Relationship data.">
    <cfargument name="keywords" type="string" required="no" default="All">
    <cfargument name="ID" type="numeric" required="yes" default="0">
    <cfargument name="tuID" type="numeric" required="yes" default="0">
    <cfargument name="acugID" type="numeric" required="yes" default="0">
    <cfargument name="tacugrStatus" type="string" required="yes" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="acugID">
	<cfset var rsTrainingAdobeConnectUserGroupRel = "" >
    <cftry>
    <cfquery name="rsTrainingAdobeConnectUserGroupRel" datasource="#application.mcmsDSN#">
    SELECT * FROM v_training_ac_user_group_rel WHERE 0=0
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND acugID LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> 
    </cfif>
    <cfif ARGUMENTS.ID NEQ 0>
    AND ID = <cfqueryparam value="#ARGUMENTS.ID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.tuID NEQ 0>
    AND tuID = <cfqueryparam value="#ARGUMENTS.tuID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.acugID NEQ 0>
    AND acugID = <cfqueryparam value="#ARGUMENTS.acugID#" cfsqltype="cf_sql_integer">
    </cfif>
    AND tacugrStatus IN (<cfqueryparam value="#ARGUMENTS.tacugrStatus#" list="yes" cfsqltype="cf_sql_integer">)
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsTrainingAdobeConnectUserGroupRel = StructNew()>
    <cfset rsTrainingAdobeConnectUserGroupRel.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsTrainingAdobeConnectUserGroupRel>
    </cffunction>
    
    <cffunction name="getTrainingUserDepartmentRel" access="public" returntype="query" hint="Get Training User Department Relationship data.">
    <cfargument name="keywords" type="string" required="no" default="All">
    <cfargument name="ID" type="numeric" required="yes" default="0">
    <cfargument name="tuID" type="string" required="yes" default="0">
    <cfargument name="deptNo" type="string" required="yes" default="0">
    <cfargument name="tudrStatus" type="string" required="yes" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="deptNo">
	<cfset var rsTrainingUserDepartmentRel = "" >
    <cftry>
    <cfquery name="rsTrainingUserDepartmentRel" datasource="#application.mcmsDSN#">
    SELECT * FROM v_training_user_dept_rel WHERE 0=0
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(tuFName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(tuLName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(tuUsername) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">)
    </cfif>
    <cfif ARGUMENTS.ID NEQ 0>
    AND ID = <cfqueryparam value="#ARGUMENTS.ID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.tuID NEQ 0>
    AND tuID IN (<cfqueryparam value="#ARGUMENTS.tuID#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    <cfif ARGUMENTS.deptNo NEQ 0>
    AND deptNo IN (<cfqueryparam value="#ARGUMENTS.deptNo#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    AND tudrStatus IN (<cfqueryparam value="#ARGUMENTS.tudrStatus#" list="yes" cfsqltype="cf_sql_integer">)
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsTrainingUserDepartmentRel = StructNew()>
    <cfset rsTrainingUserDepartmentRel.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsTrainingUserDepartmentRel>
    </cffunction>
    
    <cffunction name="getTrainingUserSiteRel" access="public" returntype="query" hint="Get Training User Site Relationship data.">
    <cfargument name="keywords" type="string" required="no" default="All">
    <cfargument name="ID" type="numeric" required="yes" default="0">
    <cfargument name="tuID" type="numeric" required="yes" default="0">
    <cfargument name="siteNo" type="string" required="yes" default="0">
    <cfargument name="tusrStatus" type="string" required="yes" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="siteNo">
	<cfset var rsTrainingUserSiteRel = "" >
    <cftry>
    <cfquery name="rsTrainingUserSiteRel" datasource="#application.mcmsDSN#">
    SELECT * FROM v_training_user_site_rel WHERE 0=0
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(tuFName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(tuLName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(tuUsername) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">)
    </cfif>
    <cfif ARGUMENTS.ID NEQ 0>
    AND ID = <cfqueryparam value="#ARGUMENTS.ID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.tuID NEQ 0>
    AND tuID = <cfqueryparam value="#ARGUMENTS.tuID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.siteNo NEQ 0>
    AND siteNo IN (<cfqueryparam value="#ARGUMENTS.siteNo#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    AND tusrStatus IN (<cfqueryparam value="#ARGUMENTS.tusrStatus#" list="yes" cfsqltype="cf_sql_integer">)
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsTrainingUserSiteRel = StructNew()>
    <cfset rsTrainingUserSiteRel.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsTrainingUserSiteRel>
    </cffunction>
    
    <cffunction name="getTrainingCategory" access="public" returntype="query" hint="Get Training Category data.">
    <cfargument name="keywords" type="string" required="yes" default="All"> 
    <cfargument name="ID" type="numeric" required="yes" default="0">
    <cfargument name="excludeID" type="numeric" required="yes" default="0">
    <cfargument name="tcatName" type="string" required="yes" default="">
    <cfargument name="tcatDateRel" type="string" required="yes" default="">
    <cfargument name="tcatDateExp" type="string" required="yes" default="">
    <cfargument name="tcattID" type="numeric" required="yes" default="0">
    <cfargument name="tcatStatus" type="string" required="yes" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="tcatName">
    <cfset var rsTrainingCategory = "" >
    <cftry>
    <cfquery name="rsTrainingCategory" datasource="#application.mcmsDSN#">
    SELECT * FROM v_training_category WHERE 0=0
    <cfif ARGUMENTS.ID NEQ 0>
    AND ID = <cfqueryparam value="#ARGUMENTS.ID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.excludeID NEQ 0>
    AND ID <> <cfqueryparam value="#ARGUMENTS.excludeID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(tcatName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">)
    </cfif>
    <cfif ARGUMENTS.tcatName NEQ "">
    AND UPPER(tcatName) = <cfqueryparam value="#UCASE(ARGUMENTS.tcatName)#" cfsqltype="cf_sql_varchar">
    </cfif>
    <cfif ARGUMENTS.tcattID NEQ 0>
    AND tcattID = <cfqueryparam value="#ARGUMENTS.tcattID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.tcatDateRel NEQ "">
    AND tcatDateRel >= <cfqueryparam value="#ARGUMENTS.tcatDateRel#" cfsqltype="cf_sql_date">
    </cfif>
    <cfif ARGUMENTS.tcatDateExp NEQ "">
    AND tcatDateExp <= <cfqueryparam value="#ARGUMENTS.tcatDateExp#" cfsqltype="cf_sql_date">
    </cfif>
    AND tcatStatus IN (<cfqueryparam value="#ARGUMENTS.tcatStatus#" list="yes" cfsqltype="cf_sql_integer">)
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsTrainingCategory = StructNew()>
    <cfset rsTrainingCategory.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsTrainingCategory>
    </cffunction>
    
    <cffunction name="getTrainingCategoryDepartmentRel" access="public" returntype="query" hint="Get Training Category Department Relationship data.">
    <cfargument name="ID" type="numeric" required="yes" default="0">
    <cfargument name="tID" type="string" required="yes" default="0">
    <cfargument name="tcatID" type="string" required="yes" default="0">
    <cfargument name="tcattID" type="string" required="yes" default="0">
    <cfargument name="deptNo" type="string" required="yes" default="0">
    <cfargument name="tcatdrStatus" type="string" required="yes" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="deptNo,tcatName">
	<cfset var rsTrainingCategoryDepartmentRel = "" >
    <cftry>
    <cfquery name="rsTrainingCategoryDepartmentRel" datasource="#application.mcmsDSN#">
    SELECT * FROM v_training_category_dept_rel WHERE 0=0
    <cfif ARGUMENTS.ID NEQ 0>
    AND ID = <cfqueryparam value="#ARGUMENTS.ID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.tID NEQ 0>
    AND tID IN (<cfqueryparam value="#ARGUMENTS.tID#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    <cfif ARGUMENTS.tcatID NEQ 0>
    AND tcatID IN (<cfqueryparam value="#ARGUMENTS.tcatID#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    <cfif ARGUMENTS.tcattID NEQ 0>
    AND tcattID IN (<cfqueryparam value="#ARGUMENTS.tcattID#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    <cfif ARGUMENTS.deptNo NEQ 0>
    AND deptNo IN (<cfqueryparam value="#ARGUMENTS.deptNo#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    AND tcatdrStatus IN (<cfqueryparam value="#ARGUMENTS.tcatdrStatus#" list="yes" cfsqltype="cf_sql_integer">)
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsTrainingCategoryDepartmentRel = StructNew()>
    <cfset rsTrainingCategoryDepartmentRel.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsTrainingCategoryDepartmentRel>
    </cffunction>
    
    <cffunction name="getTrainingCategoryRel" access="public" returntype="query" hint="Get Training Category Rel. data.">
    <cfargument name="keywords" type="string" required="yes" default="All"> 
    <cfargument name="ID" type="numeric" required="yes" default="0">
    <cfargument name="excludeID" type="numeric" required="yes" default="0">
    <cfargument name="tcatName" type="string" required="yes" default="">
    <cfargument name="tcatDateRel" type="string" required="yes" default="">
    <cfargument name="tcatDateExp" type="string" required="yes" default="">
    <cfargument name="tID" type="string" required="yes" default="0">
    <cfargument name="tcatID" type="string" required="yes" default="0">
    <cfargument name="tcattID" type="string" required="yes" default="0">
    <cfargument name="tcatrStatus" type="string" required="yes" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="tName,tcatName">
    <cfset var rsTrainingCategoryRel = "" >
    <cftry>
    <cfquery name="rsTrainingCategoryRel" datasource="#application.mcmsDSN#">
    SELECT * FROM v_training_category_rel WHERE 0=0
    <cfif ARGUMENTS.ID NEQ 0>
    AND ID = <cfqueryparam value="#ARGUMENTS.ID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.excludeID NEQ 0>
    AND ID <> <cfqueryparam value="#ARGUMENTS.excludeID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(tcatName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(tName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">)
    </cfif>
    <cfif ARGUMENTS.tcatName NEQ "">
    AND UPPER(tcatName) = <cfqueryparam value="#UCASE(ARGUMENTS.tcatName)#" cfsqltype="cf_sql_varchar">
    </cfif>
    <cfif ARGUMENTS.tID NEQ 0>
    AND tID IN (<cfqueryparam value="#ARGUMENTS.tID#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    <cfif ARGUMENTS.tcatID NEQ 0>
    AND tcatID IN (<cfqueryparam value="#ARGUMENTS.tcatID#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    <cfif ARGUMENTS.tcattID NEQ 0>
    AND tcattID IN (<cfqueryparam value="#ARGUMENTS.tcattID#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    <cfif ARGUMENTS.tcatDateRel NEQ "">
    AND tcatDateRel <= <cfqueryparam value="#ARGUMENTS.tcatDateRel#" cfsqltype="cf_sql_date">
    </cfif>
    <cfif ARGUMENTS.tcatDateExp NEQ "">
    AND tcatDateExp >= <cfqueryparam value="#ARGUMENTS.tcatDateExp#" cfsqltype="cf_sql_date">
    </cfif>
    AND tcatrStatus IN (<cfqueryparam value="#ARGUMENTS.tcatrStatus#" list="yes" cfsqltype="cf_sql_integer">)
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsTrainingCategoryRel = StructNew()>
    <cfset rsTrainingCategoryRel.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsTrainingCategoryRel>
    </cffunction>
    
    <cffunction name="getTrainingCategoryType" access="public" returntype="query" hint="Get Training Category Type data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="ID" type="numeric" required="yes" default="0">
    <cfargument name="excludeID" type="numeric" required="yes" default="0">
    <cfargument name="tcattStatus" type="string" required="yes" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="tcattName">
    <cfset var rsTrainingCategoryType = "" >
    <cftry>
    <cfquery name="rsTrainingCategoryType" datasource="#application.mcmsDSN#">
    SELECT * FROM tbl_training_category_type WHERE 0=0
    <cfif ARGUMENTS.ID NEQ 0>
    AND ID = <cfqueryparam value="#ARGUMENTS.ID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.excludeID NEQ 0>
    AND ID <> <cfqueryparam value="#ARGUMENTS.excludeID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND UPPER(tcattName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">
    </cfif>
    AND tcattStatus IN (<cfqueryparam value="#ARGUMENTS.tcattStatus#" list="yes" cfsqltype="cf_sql_integer">)
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsTrainingCategoryType = StructNew()>
    <cfset rsTrainingCategoryType.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsTrainingCategoryType>
    </cffunction>
    
    <cffunction name="getTrainingRequest" access="public" returntype="query" hint="Get Training Request data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="ID" type="numeric" required="yes" default="0">
    <cfargument name="excludeID" type="numeric" required="yes" default="0">
    <cfargument name="trTitle" type="string" required="yes" default="">
    <cfargument name="siteNo" type="numeric" required="yes" default="100">
    <cfargument name="deptNo" type="numeric" required="yes" default="0">
    <cfargument name="ticketNo" type="numeric" required="yes" default="0">
    <cfargument name="trsID" type="numeric" required="yes" default="0">
    <cfargument name="trpID" type="numeric" required="yes" default="0">
    <cfargument name="trStatus" type="string" required="yes" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="trTitle">
    <cfset var getTrainingRequest = "" >
    <cftry>
    <cfquery name="getTrainingRequest" datasource="#application.mcmsDSN#">
    SELECT * FROM v_training_request WHERE 0=0
    <cfif ARGUMENTS.ID NEQ 0>
    AND ID = <cfqueryparam value="#ARGUMENTS.ID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.excludeID NEQ 0>
    AND ID <> <cfqueryparam value="#ARGUMENTS.excludeID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(trTitle) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(trDescription) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">)
    </cfif>
    <cfif ARGUMENTS.trTitle NEQ "">
    AND UPPER(trTitle) = <cfqueryparam value="#UCASE(ARGUMENTS.trTitle)#" cfsqltype="cf_sql_varchar">
    </cfif>
    <cfif ARGUMENTS.siteNo NEQ 100>
    AND siteNo = <cfqueryparam value="#ARGUMENTS.siteNo#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.deptNo NEQ 0>
    AND deptNo = <cfqueryparam value="#ARGUMENTS.deptNo#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.ticketNo NEQ 0>
    AND ticketNo = <cfqueryparam value="#ARGUMENTS.ticketNo#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.trsID NEQ 0>
    AND trsID = <cfqueryparam value="#ARGUMENTS.trsID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.trpID NEQ 0>
    AND trpID = <cfqueryparam value="#ARGUMENTS.trpID#" cfsqltype="cf_sql_integer">
    </cfif>
    AND trStatus IN (<cfqueryparam value="#ARGUMENTS.trStatus#" list="yes" cfsqltype="cf_sql_integer">)
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset getTrainingRequest = StructNew()>
    <cfset getTrainingRequest.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn getTrainingRequest>
    </cffunction>
    
    <cffunction name="getTrainingRequestPriority" access="public" returntype="query" hint="Get Training Request Priority data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="ID" type="numeric" required="yes" default="0">
    <cfargument name="excludeID" type="numeric" required="yes" default="0">
    <cfargument name="trpName" type="string" required="yes" default="">
    <cfargument name="trpStatus" type="string" required="yes" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="trpSort">
    <cfset var getTrainingRequestPriority = "" >
    <cftry>
    <cfquery name="getTrainingRequestPriority" datasource="#application.mcmsDSN#">
    SELECT * FROM v_training_request_priority WHERE 0=0
    <cfif ARGUMENTS.ID NEQ 0>
    AND ID = <cfqueryparam value="#ARGUMENTS.ID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.excludeID NEQ 0>
    AND ID <> <cfqueryparam value="#ARGUMENTS.excludeID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(trpName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">)
    </cfif>
    <cfif ARGUMENTS.trpName NEQ "">
    AND UPPER(trpName) = <cfqueryparam value="#UCASE(ARGUMENTS.trpName)#" cfsqltype="cf_sql_varchar">
    </cfif>
    AND trpStatus IN (<cfqueryparam value="#ARGUMENTS.trpStatus#" list="yes" cfsqltype="cf_sql_integer">)
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset getTrainingRequestPriority = StructNew()>
    <cfset getTrainingRequestPriority.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn getTrainingRequestPriority>
    </cffunction>
    
    <cffunction name="getTrainingRequestQuestionOption" access="public" returntype="query" hint="Get Training Request Question Option data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="ID" type="numeric" required="yes" default="0">
    <cfargument name="excludeID" type="numeric" required="yes" default="0">
    <cfargument name="trqoOption" type="string" required="yes" default="">
    <cfargument name="trqoStatus" type="string" required="yes" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="trqoSort">
    <cfset var getTrainingRequestQuestionOption = "" >
    <cftry>
    <cfquery name="getTrainingRequestQuestionOption" datasource="#application.mcmsDSN#">
    SELECT * FROM v_training_request_q_option WHERE 0=0
    <cfif ARGUMENTS.ID NEQ 0>
    AND ID = <cfqueryparam value="#ARGUMENTS.ID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.excludeID NEQ 0>
    AND ID <> <cfqueryparam value="#ARGUMENTS.excludeID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(trqoOption) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(trqQuestion) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">)
    </cfif>
    <cfif ARGUMENTS.trqoOption NEQ "">
    AND UPPER(trqoOption) = <cfqueryparam value="#UCASE(ARGUMENTS.trqoOption)#" cfsqltype="cf_sql_varchar">
    </cfif>
    AND trqoStatus IN (<cfqueryparam value="#ARGUMENTS.trqoStatus#" list="yes" cfsqltype="cf_sql_integer">)
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset getTrainingRequestQuestionOption = StructNew()>
    <cfset getTrainingRequestQuestionOption.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn getTrainingRequestQuestionOption>
    </cffunction>
    
    <cffunction name="getTrainingRequestQuestionRel" access="public" returntype="query" hint="Get Training Request Question Relationship data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="ID" type="numeric" required="yes" default="0">
    <cfargument name="excludeID" type="numeric" required="yes" default="0">
    <cfargument name="trID" type="numeric" required="yes" default="0">
    <cfargument name="trqrStatus" type="string" required="yes" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="trID">
    <cfset var getTrainingRequestQuestionRel = "" >
    <cftry>
    <cfquery name="getTrainingRequestQuestionRel" datasource="#application.mcmsDSN#">
    SELECT * FROM v_training_request_q_rel WHERE 0=0
    <cfif ARGUMENTS.ID NEQ 0>
    AND ID = <cfqueryparam value="#ARGUMENTS.ID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.excludeID NEQ 0>
    AND ID <> <cfqueryparam value="#ARGUMENTS.excludeID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(trqQuestion) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(trqAnswer) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">)
    </cfif>
    <cfif ARGUMENTS.trID NEQ 0>
    AND trID = <cfqueryparam value="#ARGUMENTS.trID#" cfsqltype="cf_sql_integer">
    </cfif>
    AND trqrStatus IN (<cfqueryparam value="#ARGUMENTS.trqrStatus#" list="yes" cfsqltype="cf_sql_integer">)
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset getTrainingRequestQuestionRel = StructNew()>
    <cfset getTrainingRequestQuestionRel.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn getTrainingRequestQuestionRel>
    </cffunction>
    
    <cffunction name="getTrainingRequestQuestionType" access="public" returntype="query" hint="Get Training Request Question Type data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="ID" type="numeric" required="yes" default="0">
    <cfargument name="excludeID" type="numeric" required="yes" default="0">
    <cfargument name="trqtName" type="string" required="yes" default="">
    <cfargument name="trqtStatus" type="string" required="yes" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="trqtSort">
    <cfset var getTrainingRequestQuestionType = "" >
    <cftry>
    <cfquery name="getTrainingRequestQuestionType" datasource="#application.mcmsDSN#">
    SELECT * FROM v_training_request_q_type WHERE 0=0
    <cfif ARGUMENTS.ID NEQ 0>
    AND ID = <cfqueryparam value="#ARGUMENTS.ID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.excludeID NEQ 0>
    AND ID <> <cfqueryparam value="#ARGUMENTS.excludeID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(trqtName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">)
    </cfif>
    <cfif ARGUMENTS.trqtName NEQ "">
    AND UPPER(trqtName) = <cfqueryparam value="#UCASE(ARGUMENTS.trqtName)#" cfsqltype="cf_sql_varchar">
    </cfif>
    AND trqtStatus IN (<cfqueryparam value="#ARGUMENTS.trqtStatus#" list="yes" cfsqltype="cf_sql_integer">)
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset getTrainingRequestQuestionType = StructNew()>
    <cfset getTrainingRequestQuestionType.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn getTrainingRequestQuestionType>
    </cffunction>
    
    <cffunction name="getTrainingRequestQuestion" access="public" returntype="query" hint="Get Training Request Question data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="ID" type="numeric" required="yes" default="0">
    <cfargument name="excludeID" type="numeric" required="yes" default="0">
    <cfargument name="trqQuestion" type="string" required="yes" default="">
    <cfargument name="trqStatus" type="string" required="yes" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="trqSort">
    <cfset var getTrainingRequestQuestion = "" >
    <cftry>
    <cfquery name="getTrainingRequestQuestion" datasource="#application.mcmsDSN#">
    SELECT * FROM v_training_request_question WHERE 0=0
    <cfif ARGUMENTS.ID NEQ 0>
    AND ID = <cfqueryparam value="#ARGUMENTS.ID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.excludeID NEQ 0>
    AND ID <> <cfqueryparam value="#ARGUMENTS.excludeID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(trqQuestion) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">)
    </cfif>
    AND trqStatus IN (<cfqueryparam value="#ARGUMENTS.trqStatus#" list="yes" cfsqltype="cf_sql_integer">)
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset getTrainingRequestQuestion = StructNew()>
    <cfset getTrainingRequestQuestion.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn getTrainingRequestQuestion>
    </cffunction>
    
    <cffunction name="getTrainingRequestStatus" access="public" returntype="query" hint="Get Training Request Status data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="ID" type="numeric" required="yes" default="0">
    <cfargument name="excludeID" type="numeric" required="yes" default="0">
    <cfargument name="trsName" type="string" required="yes" default="">
    <cfargument name="trsStatus" type="string" required="yes" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="trsSort">
    <cfset var getTrainingRequestStatus = "" >
    <cftry>
    <cfquery name="getTrainingRequestStatus" datasource="#application.mcmsDSN#">
    SELECT * FROM v_training_request_status WHERE 0=0
    <cfif ARGUMENTS.ID NEQ 0>
    AND ID IN (<cfqueryparam value="#ARGUMENTS.ID#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    <cfif ARGUMENTS.excludeID NEQ 0>
    AND ID <> <cfqueryparam value="#ARGUMENTS.excludeID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(trsName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">)
    </cfif>
    <cfif ARGUMENTS.trsName NEQ "">
    AND UPPER(trsName) = <cfqueryparam value="#UCASE(ARGUMENTS.trsName)#" cfsqltype="cf_sql_varchar">
    </cfif>
    AND trsStatus IN (<cfqueryparam value="#ARGUMENTS.trsStatus#" list="yes" cfsqltype="cf_sql_integer">)
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset getTrainingRequestStatus = StructNew()>
    <cfset getTrainingRequestStatus.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn getTrainingRequestStatus>
    </cffunction>
    
    <cffunction name="getTrainingReport" access="public" returntype="query" hint="Get Training Report data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="orderBy" type="string" required="yes" default="tName">
    <cfset var rsTrainingReport = "" >
    <cftry>
    <cfquery name="rsTrainingReport" datasource="#application.mcmsDSN#">
    SELECT tName AS Name, TO_CHAR(tDescription) AS Description, TO_CHAR(tDateRel,'MM/DD/YYYY') AS Release_Date, TO_CHAR(tDateRel,'MM/DD/YYYY') AS Expiration_Date, tTag AS Tags, tEmailList AS Email_List, tURL AS URL, tTarget AS Target, tUserCapacity AS User_Capacity, vendorID, vName AS Vendor, bName AS Brand, ttName AS Type, tmtName AS Method, tdtName AS Delivery, sName AS Status FROM v_training WHERE 0=0
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(tName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(tDescription) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">)
    </cfif>
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsTrainingReport = StructNew()>
    <cfset rsTrainingReport.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsTrainingReport>
    </cffunction>
    
    <cffunction name="getTrainingListingReport" access="public" returntype="query" hint="Get Training Listing Report data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="orderBy" type="string" required="yes" default="tlName">
    <cfset var rsTrainingListingReport = "" >
    <cftry>
    <cfquery name="rsTrainingListingReport" datasource="#application.mcmsDSN#">
    SELECT tlName AS Name, tName AS Training_Name, TO_CHAR(tlDescription) AS Description, tlMessage AS Message, TO_CHAR(tlDateStart,'MM/DD/YYYY') AS Start_Date, TO_CHAR(tlDateEnd,'MM/DD/YYYY') AS End_Date, TO_CHAR(tDateRel,'MM/DD/YYYY') AS Release_Date, TO_CHAR(tDateExp,'MM/DD/YYYY') AS Expiration_Date, appID, tTag AS Tags, tEmailList AS Email_List, tURL AS URL, tTarget AS Target, tUserCapacity AS User_Capacity, vendorID, vName AS Vendor, bName AS Brand, ttName AS Type, tmtName AS Method, tdtName AS Delivery, sName AS Status FROM v_training_listing WHERE 0=0
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(tlName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(tlDescription) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">)
    </cfif>
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsTrainingListingReport = StructNew()>
    <cfset rsTrainingListingReport.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsTrainingListingReport>
    </cffunction>
    
    <cffunction name="getTrainingUserReport" access="public" returntype="query" hint="Get Training User Report data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="siteNo" type="string" required="yes" default="100">
    <cfargument name="deptNo" type="string" required="yes" default="0">
    <cfargument name="args" type="string" required="yes" default="0">
    <cfargument name="orderBy" type="string" required="yes" default="tuLName, tuFName">
    <cfset var rsTrainingUserReport = "" >
    <cftry>
    <cfset this.userIDList = 0>
    <!---First get users by site.--->
    <cfinvoke 
    component="MCMS.component.app.training.Training"
    method="getTrainingUserSiteRel"
    returnvariable="getTrainingUserSiteRelRet">
    <cfinvokeargument name="keywords" value="#ARGUMENTS.keywords#"/>
    <cfinvokeargument name="siteNo" value="#ARGUMENTS.siteNo#"/>
    <cfinvokeargument name="tusrStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getTrainingUserSiteRelRet.recordcount NEQ 0>
    <cfset this.userIDList = ListPrepend(ValueList(getTrainingUserSiteRelRet.tuID), this.userIDList)>
    </cfif>
    <!---Second get users by department.--->
    <cfinvoke 
    component="MCMS.component.app.training.Training"
    method="getTrainingUserDepartmentRel"
    returnvariable="getTrainingUserDepartmentRelRet">
    <cfinvokeargument name="keywords" value="#ARGUMENTS.keywords#"/>
    <cfif ARGUMENTS.siteNo NEQ 100>
    <cfinvokeargument name="tuID" value="#LEFT(this.userIDList, 4000)#"/>
    </cfif>
    <cfinvokeargument name="deptNo" value="#ARGUMENTS.deptNo#"/>
    <cfinvokeargument name="tudrStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getTrainingUserDepartmentRelRet.recordcount NEQ 0>
    <cfset this.userIDList = ListPrepend(ValueList(getTrainingUserDepartmentRelRet.tuID), this.userIDList)>
    </cfif>
    <!---Clean up the list.--->
    <cfset this.userIDList = ListRemoveDuplicates(this.userIDList)>
    <!---If there are no site users. override.--->
    <cfif ARGUMENTS.siteNo NEQ 100 AND (getTrainingUserSiteRelRet.recordcount EQ 0 OR getTrainingUserDepartmentRelRet.recordcount EQ 0)>
    <cfset this.userIDList = 99>
    </cfif>
    <!---Finalize the query.--->
    <cfquery name="rsTrainingUserReport" datasource="#application.mcmsDSN#">
    SELECT tuUsername AS Username, sName AS Status, tuLName as Last_Name, tuFName AS First_Name, tuEmail AS Email, managerUserFName || ' ' || managerUserLName AS Manager FROM v_training_user WHERE 0=0
    <cfif ARGUMENTS.args NEQ 101>
    AND ID IN (<cfqueryparam value="#LEFT(this.userIDList, 4000)#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(tuFName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(tuLName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(tuUsername) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">)
    </cfif>
    AND tuStatus IN (<cfqueryparam value="1,2,3" list="yes" cfsqltype="cf_sql_integer">)
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsTrainingUserReport = StructNew()>
    <cfset rsTrainingUserReport.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsTrainingUserReport>
    </cffunction>
    
    <cffunction name="getTrainingCategoryReport" access="public" returntype="query" hint="Get Training Category Report data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="orderBy" type="string" required="yes" default="tcatName">
    <cfset var rsTrainingCategoryReport = "" >
    <cftry>
    <cfquery name="rsTrainingCategoryReport" datasource="#application.mcmsDSN#">
    SELECT tcatName AS Name, tcattName AS Type, TO_CHAR(tcatDateRel,'MM/DD/YYYY') AS Release_Date, TO_CHAR(tcatDateExp,'MM/DD/YYYY') AS Expire_Date, sortName AS Sort FROM v_training_category WHERE 0=0
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND UPPER(tcatName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">
    </cfif>
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsTrainingCategoryReport = StructNew()>
    <cfset rsTrainingCategoryReport.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsTrainingCategoryReport>
    </cffunction>
    
    <cffunction name="getTrainingRequestReport" access="public" returntype="query" hint="Get Training Request Report data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="orderBy" type="string" required="yes" default="trDate, trTitle">
    <cfset var rsTrainingRequestReport = "" >
    <cftry>
    <cfquery name="rsTrainingRequestReport" datasource="#application.mcmsDSN#">
    SELECT trTitle AS Title, tuFName || ' ' || tuLName AS Request_User, tuManagerFName || ' ' || tuManagerLName AS Approver, TO_CHAR(trDescription) AS Description, TO_CHAR(trDate,'MM/DD/YYYY') AS Request_Date, TO_CHAR(trDateUpdate,'MM/DD/YYYY') AS Update_Date, siteName AS Site, deptName AS Department, ticketNo AS Ticket_No, trsName AS Request_Status, trpName AS Priority, TO_CHAR(trLog) AS Log, sName AS Status FROM v_training_request WHERE 0=0
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(trTitle) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(trDescription) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">)
    </cfif>
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsTrainingRequestReport = StructNew()>
    <cfset rsTrainingRequestReport.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsTrainingRequestReport>
    </cffunction>
    
    <cffunction name="getTimePartList" access="public" returntype="query" hint="List of Time Parts.">
    <cfargument name="totalCount" type="numeric" required="yes">
    <cfargument name="timeType" type="string" required="yes" default="">
    <cfargument name="timeMaskStart" type="string" required="yes" default="">
    <cfargument name="timeMaskEnd" type="string" required="yes" default="">
    <cfset myQuery = QueryNew("Name, Value", "varchar, varchar")>
    <cfset newRow = QueryAddRow(myQuery, ARGUMENTS.totalCount)>
    <cfloop index="id" from="1" to="#ARGUMENTS.totalCount#">
    <cfset temp = QuerySetCell(myQuery, "Name", LSTimeFormat('#ARGUMENTS.timeMaskStart##id##ARGUMENTS.timeMaskEnd#', ARGUMENTS.timeType), id)>
    <cfset temp = QuerySetCell(myQuery, "Value", LSTimeFormat('#ARGUMENTS.timeMaskStart##id##ARGUMENTS.timeMaskEnd#', ARGUMENTS.timeType), id)>
    </cfloop>
    <cfreturn myQuery>
    </cffunction>
    
    <cffunction name="insertTraining" access="public" returntype="struct">
    <cfargument name="tName" type="string" required="yes">
	<cfargument name="actID" type="numeric" required="yes">
    <cfargument name="tDescription" type="string" required="yes">
    <cfargument name="tDateRel" type="string" required="yes">
    <cfargument name="tDateExp" type="string" required="yes">
    <cfargument name="tTag" type="string" required="yes">
    <cfargument name="tUserCapacity" type="numeric" required="yes">
    <cfargument name="tRequired" type="numeric" required="yes">
    <cfargument name="tDuration" type="string" required="yes">
    <cfargument name="tEmailList" type="string" required="yes">
    <cfargument name="tURL" type="string" required="yes">
    <cfargument name="tTarget" type="string" required="yes">
    <cfargument name="vID" type="string" required="yes">
    <cfargument name="bID" type="string" required="yes">
    <cfargument name="appID" type="string" required="yes">
    <cfargument name="ttID" type="string" required="yes">
    <cfargument name="tmtID" type="string" required="yes">
    <cfargument name="tdtID" type="string" required="yes">
    <cfargument name="tSort" type="string" required="yes">
    <cfargument name="tStatus" type="string" required="yes">
    <!---Relationship arguments.--->
    <cfargument name="deptNo" type="string" required="yes">
    <cfargument name="tcatID" type="string" required="yes">
    <cfargument name="tscatID" type="string" required="yes">
    <cfargument name="tlcatID" type="string" required="yes" default="0">
    <cfset result.message = "You have successfully inserted the record.">
    <cftry>
    <!---Check for profanity in the text.--->
    <cfinvoke 
    component="MCMS.component.utility.Regex"
    method="regexProfanity"
    returnvariable="regexProfanityRet">
    <cfinvokeargument name="profanityString" value="#ARGUMENTS.tDescription#"/>
    </cfinvoke>
    <!---Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.app.training.Training"
    method="getTraining"
    returnvariable="getCheckTrainingRet">
    <cfinvokeargument name="tName" value="#ARGUMENTS.tName#"/>
    <cfinvokeargument name="tStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckTrainingRet.recordcount NEQ 0>
    <cfset result.message = "The name #ARGUMENTS.tName# already exists, please enter a new name.">
    <cfelseif regexProfanityRet CONTAINS '$%&*!'>
    <cfset result.message = "Some text contained profanity, please remove any profanity from your text.">
    <!---Check length restriction.--->
    <cfelseif LEN(ARGUMENTS.tDescription) GT 1024>
    <cfset result.message = "The description is longer than 1024 characters, please enter a new description under 1024 characters.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    INSERT INTO tbl_training (tName,actID,tDescription,tDateRel,tDateExp,tTag,tUserCapacity,tRequired,tDuration,tEmailList,tURL,tTarget,vID,bID,appID,ttID,tmtID,tdtID,tSort,tStatus) VALUES
    (
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.tName#">,
	<cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.actID#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.tDescription#">,
    <cfqueryparam cfsqltype="cf_sql_date" value="#ARGUMENTS.tDateRel#">,
    <cfqueryparam cfsqltype="cf_sql_date" value="#ARGUMENTS.tDateExp#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.tTag#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.tUserCapacity#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.tRequired#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.tDuration#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.tEmailList#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.tURL#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.tTarget#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.vID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.bID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.appID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ttID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.tmtID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.tdtID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.tSort#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.tStatus#">
    )
    </cfquery>
    </cftransaction>
    <cfinvoke 
    component="MCMS.component.cms.Cms"
    method="getMaxValueSQL"
    returnvariable="tID">
    <cfinvokeargument name="tablename" value="tbl_training"/>
    </cfinvoke>
    <cfset this.tID = tID>
    <!---Create department relationships.--->
    <cfloop index="deptNo" list="#ARGUMENTS.deptNo#">
    <cfinvoke 
    component="MCMS.component.app.training.Training"
    method="insertTrainingDepartmentRel">
    <cfinvokeargument name="tID" value="#this.tID#"/>
    <cfinvokeargument name="deptNo" value="#deptNo#"/>
    <cfinvokeargument name="tdrStatus" value="1"/>
    </cfinvoke>
    </cfloop>
    <!---Create category relationships.--->
    <cfif ARGUMENTS.tcatID NEQ 0>
    <cfloop index="tcatID" list="#ARGUMENTS.tcatID#">
    <cfinvoke 
    component="MCMS.component.app.training.Training"
    method="insertTrainingCategoryRel">
    <cfinvokeargument name="tID" value="#this.tID#"/>
    <cfinvokeargument name="tcatID" value="#tcatID#"/>
    <cfinvokeargument name="tcatrStatus" value="1"/>
    </cfinvoke>
    </cfloop>
    </cfif>
    <!---Create secondary category relationships.--->
    <cfif ARGUMENTS.tscatID NEQ 0>
    <cfloop index="tscatID" list="#ARGUMENTS.tscatID#">
    <cfinvoke 
    component="MCMS.component.app.training.Training"
    method="insertTrainingCategoryRel">
    <cfinvokeargument name="tID" value="#this.tID#"/>
    <cfinvokeargument name="tcatID" value="#tscatID#"/>
    <cfinvokeargument name="tcatrStatus" value="1"/>
    </cfinvoke>
    </cfloop>
    </cfif>
    <!---Create secondary category relationships.--->
    <cfif ARGUMENTS.tlcatID NEQ 0>
    <cfloop index="tlcatID" list="#ARGUMENTS.tlcatID#">
    <cfinvoke 
    component="MCMS.component.app.training.Training"
    method="insertTrainingCategoryRel">
    <cfinvokeargument name="tID" value="#this.tID#"/>
    <cfinvokeargument name="tcatID" value="#tlcatID#"/>
    <cfinvokeargument name="tcatrStatus" value="1"/>
    </cfinvoke>
    </cfloop>
    </cfif>
    </cfif>
    <cfcatch type="any">
    <cfset result.message = "There was an error inserting the record.">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
	<cffunction name="insertTrainingListing" access="public" returntype="struct">
    <cfargument name="tID" type="numeric" required="yes">
    <cfargument name="tlName" type="string" required="yes">
    <cfargument name="tlDescription" type="string" required="yes">
    <cfargument name="tlMessage" type="string" required="yes">
    <cfargument name="tlDateStart" type="string" required="yes">
    <cfargument name="tlDateEnd" type="string" required="yes">
    <cfargument name="tlHostUserID" type="string" required="yes">
    <cfargument name="tlPresenterUserID" type="string" required="yes">
    <cfargument name="tlConfID" type="string" required="yes">
    <cfargument name="tlSort" type="string" required="yes">
    <cfargument name="tlStatus" type="string" required="yes">
    <!---Relationship arguments.--->
    <cfargument name="siteNo" type="string" required="yes">
    <cfargument name="acugID" type="string" required="yes">
    <cfset result.message = "You have successfully inserted the record.">
    <cftry>
    <!---Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.app.training.Training"
    method="getTrainingListing"
    returnvariable="getCheckTrainingListingRet">
    <cfinvokeargument name="tID" value="#ARGUMENTS.tID#"/>
    <cfinvokeargument name="tlName" value="#ARGUMENTS.tlName#"/>
    <cfinvokeargument name="tlStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckTrainingListingRet.recordcount NEQ 0>
    <cfset result.message = "The training listing #ARGUMENTS.tlName# already exists, please try again.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    INSERT INTO tbl_training_listing (tID,tlName,tlDescription,tlMessage,tlDateStart,tlDateEnd,userID,tlConfID,tlSort,tlStatus) VALUES
    (
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.tID#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.tlName#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.tlDescription#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.tlMessage#">,
    <cfqueryparam cfsqltype="cf_sql_date" value="#ARGUMENTS.tlDateStart#">,
    <cfqueryparam cfsqltype="cf_sql_date" value="#ARGUMENTS.tlDateEnd#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#session.userID#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.tlConfID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.tlSort#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.tlStatus#">
    )
    </cfquery>
    <cfinvoke 
    component="MCMS.component.cms.Cms"
    method="getMaxValueSQL"
    returnvariable="tlID">
    <cfinvokeargument name="tablename" value="tbl_training_listing"/>
    </cfinvoke>
    <cfset this.tlID = tlID>
    <cfif ARGUMENTS.tlHostUserID NEQ 0>
    <!---Create host relationships.--->
    <cfloop index="tlHostUserID" list="#ARGUMENTS.tlHostUserID#">
    <cfinvoke 
    component="MCMS.component.app.training.Training"
    method="insertTrainingListingHostRel">
    <cfinvokeargument name="tlID" value="#this.tlID#"/>
    <cfinvokeargument name="tuID" value="#tlHostUserID#"/>
    <cfinvokeargument name="tlhrStatus" value="1"/>
    </cfinvoke>
    </cfloop>
    </cfif>
    <cfif ARGUMENTS.tlPresenterUserID NEQ 0>
    <!---Create presenter relationships.--->
    <cfloop index="tlPresenterUserID" list="#ARGUMENTS.tlPresenterUserID#">
    <cfinvoke 
    component="MCMS.component.app.training.Training"
    method="insertTrainingListingPresenterRel">
    <cfinvokeargument name="tlID" value="#this.tlID#"/>
    <cfinvokeargument name="tuID" value="#tlPresenterUserID#"/>
    <cfinvokeargument name="tlprStatus" value="1"/>
    </cfinvoke>
    </cfloop>
    </cfif>
    <!---Create site relationships.--->
    <cfloop index="siteNo" list="#ARGUMENTS.siteNo#">
    <cfinvoke 
    component="MCMS.component.app.training.Training"
    method="insertTrainingListingSiteRel">
    <cfinvokeargument name="tlID" value="#this.tlID#"/>
    <cfinvokeargument name="siteNo" value="#siteNo#"/>
    <cfinvokeargument name="tlsrStatus" value="1"/>
    </cfinvoke>
    </cfloop>
    <!---Create user role relationships.--->
    <cfloop index="acugID" list="#ARGUMENTS.acugID#">
    <cfinvoke 
    component="MCMS.component.app.training.Training"
    method="insertTrainingListingACUserGroupAccessRel">
    <cfinvokeargument name="tlID" value="#this.tlID#"/>
    <cfinvokeargument name="acugID" value="#acugID#"/>
    <cfinvokeargument name="tlacugarStatus" value="1"/>
    </cfinvoke>
    </cfloop>
	<!---Loop for timetable insert---> 
    <cfloop index="i" from="1" to="#form.timeTableCount#">
    <cfif IsDefined(Evaluate(DE('form.dayID#i#'))) AND Evaluate('form.dayID#i#') NEQ ''>
    <cfinvoke 
    component="MCMS.component.app.training.Training" 
    method="insertTrainingListingTimeTableRel">
    <cfinvokeargument name="tlID" value="#this.tlID#">
    <cfinvokeargument name="dayID" value="#Evaluate('form.dayID#i#')#">
    <cfinvokeargument name="timeIDStart" value="#Evaluate('form.timeIDStart#i#')#">
    <cfinvokeargument name="timeIDEnd" value="#Evaluate('form.timeIDEnd#i#')#">
    <cfinvokeargument name="tltrStatus" value="1">                 
    </cfinvoke>
    </cfif>
    </cfloop>
    </cftransaction>
    </cfif>
    <cfcatch type="any">
    <cfset result.message = "There was an error inserting the record.">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
     
    <cffunction name="insertTrainingListingSiteRel" access="public" returntype="struct">
    <cfargument name="tlID" type="numeric" required="yes">
    <cfargument name="siteNo" type="numeric" required="yes">
    <cfargument name="tlsrStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully inserted the record.">
    <cftry>
	<!---Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.app.training.Training"
    method="getTrainingListingSiteRel"
    returnvariable="getCheckTrainingListingSiteRelRet">
    <cfinvokeargument name="tlID" value="#ARGUMENTS.tlID#"/>
    <cfinvokeargument name="siteNo" value="#ARGUMENTS.siteNo#"/>
    <cfinvokeargument name="tlsrStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckTrainingListingSiteRelRet.recordcount NEQ 0>
    <cfset result.message = "The training listing site relationship already exists, please try again.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    INSERT INTO tbl_training_listing_site_rel (tlID,siteNo,tlsrStatus) VALUES
    (
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.tlID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.siteNo#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.tlsrStatus#">
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
    
    <cffunction name="insertTrainingListingHostRel" access="public" returntype="struct">
    <cfargument name="tlID" type="numeric" required="yes">
    <cfargument name="tuID" type="numeric" required="yes">
    <cfargument name="tlhrStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully inserted the record.">
    <cftry>
	<!---Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.app.training.Training"
    method="getTrainingListingHostRel"
    returnvariable="getCheckTrainingListingHostRelRet">
    <cfinvokeargument name="tlID" value="#ARGUMENTS.tlID#"/>
    <cfinvokeargument name="tuID" value="#ARGUMENTS.tuID#"/>
    <cfinvokeargument name="tlhrStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckTrainingListingHostRelRet.recordcount NEQ 0>
    <cfset result.message = "The training listing host relationship already exists, please try again.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    INSERT INTO tbl_training_listing_host_rel (tlID,tuID,tlhrStatus) VALUES
    (
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.tlID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.tuID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.tlhrStatus#">
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
    
    <cffunction name="insertTrainingListingPresenterRel" access="public" returntype="struct">
    <cfargument name="tlID" type="numeric" required="yes">
    <cfargument name="tuID" type="numeric" required="yes">
    <cfargument name="tlprStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully inserted the record.">
    <cftry>
	<!---Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.app.training.Training"
    method="getTrainingListingPresenterRel"
    returnvariable="getCheckTrainingListingPresenterRelRet">
    <cfinvokeargument name="tlID" value="#ARGUMENTS.tlID#"/>
    <cfinvokeargument name="tuID" value="#ARGUMENTS.tuID#"/>
    <cfinvokeargument name="tlprStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckTrainingListingPresenterRelRet.recordcount NEQ 0>
    <cfset result.message = "The training listing presenter relationship already exists, please try again.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    INSERT INTO tbl_training_l_presenter_rel (tlID,tuID,tlprStatus) VALUES
    (
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.tlID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.tuID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.tlprStatus#">
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
    
    <cffunction name="insertTrainingListingTimeTableRel" access="public" returntype="struct">
    <cfargument name="tlID" type="numeric" required="yes">
    <cfargument name="dayID" type="numeric" required="yes">
    <cfargument name="timeIDStart" type="numeric" required="yes">
    <cfargument name="timeIDEnd" type="numeric" required="yes">
    <cfargument name="tltrStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully inserted the record.">
    <cftry>
	<!---Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.app.training.Training"
    method="getTrainingListingTimeTableRel"
    returnvariable="getCheckTrainingListingTimeTableRelRet">
    <cfinvokeargument name="tlID" value="#ARGUMENTS.tlID#"/>
    <cfinvokeargument name="dayID" value="#ARGUMENTS.dayID#"/>
    <cfinvokeargument name="timeIDStart" value="#ARGUMENTS.timeIDStart#"/>
    <cfinvokeargument name="timeIDEnd" value="#ARGUMENTS.timeIDEnd#"/>
    <cfinvokeargument name="tltrStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckTrainingListingTimeTableRelRet.recordcount NEQ 0>
    <cfset result.message = "The training listing time table relationship already exists, please try again.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    INSERT INTO tbl_training_l_timetable_rel (tlID,dayID,timeIDStart,timeIDEnd,tltrStatus) VALUES
    (
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.tlID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.dayID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.timeIDStart#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.timeIDEnd#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.tltrStatus#">
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
    
    <cffunction name="insertTrainingDepartmentRel" access="public" returntype="struct">
    <cfargument name="tID" type="numeric" required="yes">
    <cfargument name="deptNo" type="numeric" required="yes">
    <cfargument name="tdrStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully inserted the record.">
    <cftry>
	<!---Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.app.training.Training"
    method="getTrainingDepartmentRel"
    returnvariable="getCheckTrainingDepartmentRelRet">
    <cfinvokeargument name="tID" value="#ARGUMENTS.tID#"/>
    <cfinvokeargument name="deptNo" value="#ARGUMENTS.deptNo#"/>
    <cfinvokeargument name="tdrStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckTrainingDepartmentRelRet.recordcount NEQ 0>
    <cfset result.message = "The training department relationship already exists, please try again.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    INSERT INTO tbl_training_department_rel (tID,deptNo,tdrStatus) VALUES
    (
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.tID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.deptNo#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.tdrStatus#">
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
    
    <cffunction name="insertTrainingCategoryRel" access="public" returntype="struct">
    <cfargument name="tID" type="numeric" required="yes">
    <cfargument name="tcatID" type="numeric" required="yes">
    <cfargument name="tcatrStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully inserted the record.">
    <cftry>
	<!---Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.app.training.Training"
    method="getTrainingCategoryRel"
    returnvariable="getCheckTrainingCategoryRelRet">
    <cfinvokeargument name="tID" value="#ARGUMENTS.tID#"/>
    <cfinvokeargument name="tcatID" value="#ARGUMENTS.tcatID#"/>
    <cfinvokeargument name="tcatrStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckTrainingCategoryRelRet.recordcount NEQ 0>
    <cfset result.message = "The training category relationship already exists, please try again.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    INSERT INTO tbl_training_category_rel (tID,tcatID,tcatrStatus) VALUES
    (
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.tID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.tcatID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.tcatrStatus#">
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
    
    <cffunction name="insertTrainingUser" access="public" returntype="struct">
    <cfargument name="tuFName" type="string" required="yes">
    <cfargument name="tuLName" type="string" required="yes">
    <cfargument name="tuUsername" type="string" required="yes">
    <cfargument name="tuPasswordTemp" type="string" required="yes">
    <cfargument name="tuEmail" type="string" required="yes">
    <cfargument name="tuEmailAlt" type="string" required="yes">
    <cfargument name="tuHost" type="numeric" required="yes">
    <cfargument name="tuPresenter" type="numeric" required="yes">
    <cfargument name="tuManagerUserID" type="string" required="yes">
    <cfargument name="tuStatus" type="string" required="yes"> 
    <!---Relationship arguments.--->
    <cfargument name="acugID" type="string" required="yes">
    <cfargument name="deptNo" type="string" required="yes">
    <cfargument name="siteNo" type="string" required="yes">
    <cfargument name="userID" type="numeric" required="yes">
    <cfset result.message = "You have successfully created the user. <br><u>PLEASE NOTE it may take up to 2 hours to register this change</u>. <br>Have the user attempt to sign in 2 hours from now to see their training.">
    <cftry>
    <!---Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.app.training.Training"
    method="getTrainingUser"
    returnvariable="getCheckTrainingUserRet">
    <cfinvokeargument name="tuUsername" value="#ARGUMENTS.tuUsername#"/>
    <cfinvokeargument name="tuStatus" value="1,2,3"/>
    </cfinvoke>
    <!---Check for a duplicate record in interface database.--->
    <cfinvoke 
    component="cfc.adobe_connect"
    method="getACUser"
    returnvariable="getCheckACUserRet">
    <cfinvokeargument name="acuUsername" value="#ARGUMENTS.tuUsername#"/>
    </cfinvoke>
    <cfif getCheckTrainingUserRet.recordcount NEQ 0>
    <cfset result.message = "The username '#ARGUMENTS.tuUsername#' already exists, please enter a new username.">
    <!---Now update training user record if it exists.--->
    <cfinvoke 
    component="MCMS.component.app.training.Training"
    method="updateTrainingUserImport">
    <cfinvokeargument name="tuID" value="#getCheckTrainingUserRet.ID#"/>
    <cfinvokeargument name="acuID" value="#getCheckTrainingUserRet.acuID#"/>
    <cfinvokeargument name="acugID" value="#ARGUMENTS.acugID#"/>
    <cfinvokeargument name="tuEmail" value="#ARGUMENTS.tuEmail#"/>
    <cfinvokeargument name="siteNo" value="#ARGUMENTS.siteNo#"/>
    <cfinvokeargument name="deptNo" value="#ARGUMENTS.deptNo#"/>
    </cfinvoke>  
    <cfelse>
    <cfif getCheckACUserRet.recordcount NEQ 0>
    <!---Set the acuID existing via the API.--->
    <cfset this.acuID = getCheckACUserRet.ID>
    <cfset result.message = "The username '#ARGUMENTS.tuUsername#' already exists in the <u>interface</u>, the record has been updated with this new information.">
    <cfinvoke 
    component="cfc.adobe_connect" 
    method="updateACUser">
    <cfinvokeargument name="PRINCIPAL_ID" value="#this.acuID#">
    <cfinvokeargument name="NAME" value="#ARGUMENTS.tuFName# #ARGUMENTS.tuLName#">
    <cfinvokeargument name="LOGIN" value="#ARGUMENTS.tuUsername#"> 
    <cfinvokeargument name="EXT_LOGIN" value="#ARGUMENTS.tuUsername#">                          
    </cfinvoke>
    <cfelse>
    <!---Insert record into interface users table using API.--->
    <cfinvoke 
    component="cfc.adobe_connect" 
    method="apiCreateUser"
    returnvariable="apiCreateUserRet">
    <cfinvokeargument name="name" value="#ARGUMENTS.tuFName# #ARGUMENTS.tuLName#">
    <cfinvokeargument name="fname" value="#ARGUMENTS.tuFName#">
    <cfinvokeargument name="lname" value="#ARGUMENTS.tuLName#">
    <cfinvokeargument name="login" value="#ARGUMENTS.tuUsername#">
    <cfinvokeargument name="password" value="#ARGUMENTS.tuPasswordTemp#">                        
    </cfinvoke>
    <!---Check the API returns without errors.--->
    <cfif apiCreateUserRet.status EQ 'false'>
    <cfset result.message = apiCreateUserRet.message>
    <cfelse>
    <!---Set the acuID just created via the API.--->
    <cfset this.acuID = apiCreateUserRet.ID>
    </cfif>
    </cfif>
    <!---Encrypt the password.--->
    <cfinvoke 
    component="MCMS.component.app.security.Security"
    method="setEcryption"
    returnvariable="setEcryptionRet">
    <cfinvokeargument name="value" value="#ARGUMENTS.tuPasswordTemp#"/>
    <cfinvokeargument name="valuePair" value="lorem"/>
    </cfinvoke>
    <cfset ARGUMENTS.tuPasswordTemp = setEcryptionRet.encryptKey>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    INSERT INTO tbl_training_user (tuFName,tuLName,tuUsername,tuPassword,tuPasswordTemp,tuEmail,tuEmailAlt,tuHost,tuPresenter,acuID,tuManagerUserID,userID,tuStatus) VALUES
    (
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.tuFName#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.tuLName#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.tuUsername#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.tuPasswordTemp#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.tuPasswordTemp#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.tuEmail#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.tuEmailAlt#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.tuHost#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.tuPresenter#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#this.acuID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.tuManagerUserID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.userID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.tuStatus#">
    )
    </cfquery>
    </cftransaction>
    <cfinvoke 
    component="MCMS.component.cms.Cms"
    method="getMaxValueSQL"
    returnvariable="tuID">
    <cfinvokeargument name="tablename" value="tbl_training_user"/>
    </cfinvoke>
    <cfset this.tuID = tuID>
    <!---Create the security key.--->
    <cfinvoke 
    component="MCMS.component.app.training.Training"
    method="insertTrainingUserSecurityKeyRel"
    returnvariable="insertTrainingUserSecurityKeyRelRet">
    <cfinvokeargument name="tuID" value="#this.tuID#"/>
    <cfinvokeargument name="tuskrKey" value="#setEcryptionRet.encryptKey#"/>
    <cfinvokeargument name="tuskrKeyValue" value="#setEcryptionRet.encryptKeyValue#"/>
    <cfinvokeargument name="tuskrStatus" value="1"/>
    </cfinvoke>
    <!---Create user group relationships. This will include interface relationships as well.--->
    <cfloop index="acugID" list="#ARGUMENTS.acugID#">
    <cfquery datasource="#application.mcmsDSN#">
    INSERT INTO tbl_training_ac_user_group_rel (tuID,acugID,tacugrStatus) VALUES
    (
    <cfqueryparam cfsqltype="cf_sql_integer" value="#this.tuID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#acugID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="1">
    )
    </cfquery>
    <cfinvoke 
    component="cfc.adobe_connect" 
    method="insertACUserGroupRel" 
    >
    <cfinvokeargument name="acugID" value="#acugID#">
    <cfinvokeargument name="acuID" value="#this.acuID#">                         
    </cfinvoke>
    </cfloop>
    <!---Now insert records for the user field interface.--->
    <cfinvoke 
    component="cfc.adobe_connect" 
    method="insertACUserEmailFieldRel" 
    >
    <cfinvokeargument name="acuID" value="#this.acuID#">
    <cfinvokeargument name="acuEmail" value="#ARGUMENTS.tuEmail#">                         
    </cfinvoke>
    <cfinvoke 
    component="cfc.adobe_connect" 
    method="insertACUserGroupFieldRel" 
    >
    <cfinvokeargument name="acuID" value="#this.acuID#">
    <cfinvokeargument name="acugID" value="#ARGUMENTS.acugID#">                         
    </cfinvoke>
    <!---Create department relationships.--->
    <cfloop index="deptNo" list="#ARGUMENTS.deptNo#">
    <cfinvoke 
    component="MCMS.component.app.training.Training"
    method="insertTrainingUserDepartmentRel">
    <cfinvokeargument name="tuID" value="#this.tuID#"/>
    <cfinvokeargument name="acuID" value="#this.acuID#"/>
    <cfinvokeargument name="deptNo" value="#deptNo#"/>
    <cfinvokeargument name="tudrStatus" value="1"/>
    </cfinvoke>
    </cfloop>
    <!---Now insert records for the user field interface.--->
    <cfinvoke 
    component="cfc.adobe_connect" 
    method="insertACUserDepartmentFieldRel" 
    >
    <cfinvokeargument name="acuID" value="#this.acuID#">
    <cfinvokeargument name="deptNo" value="#ARGUMENTS.deptNo#">                         
    </cfinvoke>
    <!---Create site relationships.--->
    <cfloop index="siteNo" list="#ARGUMENTS.siteNo#">
    <cfinvoke 
    component="MCMS.component.app.training.Training"
    method="insertTrainingUserSiteRel">
    <cfinvokeargument name="tuID" value="#this.tuID#"/>
    <cfinvokeargument name="acuID" value="#this.acuID#"/>
    <cfinvokeargument name="siteNo" value="#siteNo#"/>
    <cfinvokeargument name="tusrStatus" value="1"/>
    </cfinvoke>
    </cfloop>
    <!---Now insert records for the user field interface.--->
    <cfinvoke 
    component="cfc.adobe_connect" 
    method="insertACUserSiteFieldRel" 
    >
    <cfinvokeargument name="acuID" value="#this.acuID#">
    <cfinvokeargument name="siteNo" value="#ARGUMENTS.siteNo#">                         
    </cfinvoke>
    </cfif>
    <cfcatch type="any">
    <cfset result.message = "There was an error inserting the record.">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="insertTrainingACUserGroupRel" access="public" returntype="struct">
    <cfargument name="tuID" type="numeric" required="yes">
    <cfargument name="acuID" type="numeric" required="yes">
    <cfargument name="acugID" type="numeric" required="yes">
    <cfargument name="tacugrStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully inserted the record.">
    <cftry>
	<!--- Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.app.training.Training"
    method="getTrainingAdobeConnectUserGroupRel"
    returnvariable="getCheckTrainingAdobeConnectUserGroupRelRet">
    <cfinvokeargument name="tuID" value="#ARGUMENTS.tuID#"/>
    <cfinvokeargument name="acugID" value="#ARGUMENTS.acugID#"/>
    <cfinvokeargument name="tacugrStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckTrainingAdobeConnectUserGroupRelRet.recordcount NEQ 0>
    <cfset result.message = "The training user group relationship already exists, please try again.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    INSERT INTO tbl_training_ac_user_group_rel (tuID,acugID,tacugrStatus) VALUES
    (
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.tuID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.acugID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.tacugrStatus#">
    )
    </cfquery>
    </cftransaction>
    <!---Now insert records for the interface.--->
    <cfinvoke 
    component="cfc.adobe_connect"
    method="getACUserGroupRel"
    returnvariable="getCheckACUserGroupRelRet">
    <cfinvokeargument name="acugID" value="#ARGUMENTS.acugID#">
    <cfinvokeargument name="acuID" value="#ARGUMENTS.acuID#">  
    </cfinvoke>
    <cfif getCheckACUserGroupRelRet.recordcount NEQ 0>
    <cfset result.message = "The training user group relationship already exists in the <u>interface</u>. The non-interface record has been created.">
    <cfelse>
    <cfinvoke 
    component="cfc.adobe_connect" 
    method="insertACUserGroupRel" 
    >
    <cfinvokeargument name="acugID" value="#ARGUMENTS.acugID#">
    <cfinvokeargument name="acuID" value="#ARGUMENTS.acuID#">                         
    </cfinvoke>
    </cfif>
    </cfif>
	<cfcatch type="any">
    <cfset result.message = "There was an error inserting the record.">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="insertTrainingListingACUserGroupAccessRel" access="public" returntype="struct">
    <cfargument name="tlID" type="numeric" required="yes">
    <cfargument name="acugID" type="numeric" required="yes">
    <cfargument name="tlacugarStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully inserted the record.">
    <cftry>
	<!--- Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.app.training.Training"
    method="getTrainingListingAdobeConnectUserGroupAccessRel"
    returnvariable="getCheckTrainingListingAdobeConnectUserGroupAccessRelRet">
    <cfinvokeargument name="tlID" value="#ARGUMENTS.tlID#"/>
    <cfinvokeargument name="acugID" value="#ARGUMENTS.acugID#"/>
    <cfinvokeargument name="tlacugarStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckTrainingListingAdobeConnectUserGroupAccessRelRet.recordcount NEQ 0>
    <cfset result.message = "The training listing user group access relationship already exists, please try again.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    INSERT INTO tbl_training_l_ac_ug_a_rel (tlID,acugID,tlacugarStatus) VALUES
    (
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.tlID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.acugID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.tlacugarStatus#">
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
    
    <cffunction name="insertTrainingUserDepartmentRel" access="public" returntype="struct">
    <cfargument name="tuID" type="numeric" required="yes">
    <cfargument name="deptNo" type="numeric" required="yes">
    <cfargument name="tudrStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully inserted the record.">
    <cftry>
	<!---Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.app.training.Training"
    method="getTrainingUserDepartmentRel"
    returnvariable="getCheckTrainingUserDepartmentRelRet">
    <cfinvokeargument name="tuID" value="#ARGUMENTS.tuID#"/>
    <cfinvokeargument name="deptNo" value="#ARGUMENTS.deptNo#"/>
    <cfinvokeargument name="tudrStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckTrainingUserDepartmentRelRet.recordcount NEQ 0>
    <cfset result.message = "The training user department relationship already exists, please try again.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    INSERT INTO tbl_training_user_dept_rel (tuID,deptNo,tudrStatus) VALUES
    (
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.tuID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.deptNo#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.tudrStatus#">
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
    
    <cffunction name="insertTrainingUserSiteRel" access="public" returntype="struct">
    <cfargument name="tuID" type="numeric" required="yes">
    <cfargument name="siteNo" type="numeric" required="yes">
    <cfargument name="tusrStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully inserted the record.">
    <cftry>
	<!---Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.app.training.Training"
    method="getTrainingUserSiteRel"
    returnvariable="getCheckTrainingUserSiteRelRet">
    <cfinvokeargument name="tuID" value="#ARGUMENTS.tuID#"/>
    <cfinvokeargument name="siteNo" value="#ARGUMENTS.siteNo#"/>
    <cfinvokeargument name="tusrStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckTrainingUserSiteRelRet.recordcount NEQ 0>
    <cfset result.message = "The training user site relationship already exists, please try again.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    INSERT INTO tbl_training_user_site_rel (tuID,siteNo,tusrStatus) VALUES
    (
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.tuID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.siteNo#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.tusrStatus#">
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
    
    <cffunction name="insertTrainingUserSecurityKeyRel" access="public" returntype="struct">
    <cfargument name="tuID" type="numeric" required="yes">
    <cfargument name="tuskrKey" type="string" required="yes">
    <cfargument name="tuskrKeyValue" type="string" required="yes">
    <cfargument name="tuskrStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully inserted the record.">
    <cftry>
	<!---Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.app.training.Training"
    method="getTrainingUserSecurityKeyRel"
    returnvariable="getCheckTrainingUserSecurityKeyRelRet">
    <cfinvokeargument name="tuID" value="#ARGUMENTS.tuID#"/>
    <cfinvokeargument name="tuskrStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckTrainingUserSecurityKeyRelRet.recordcount NEQ 0>
    <cfset result.message = "The user security key relationship already exists, please try again.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    INSERT INTO tbl_training_user_sec_key_rel (tuID,tuskrKey,tuskrKeyValue,tuskrStatus) VALUES
    (
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.tuID#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.tuskrKey#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.tuskrKeyValue#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.tuskrStatus#">
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
    
    <cffunction name="insertTrainingCategory" access="public" returntype="struct">
    <cfargument name="tcatName" type="string" required="yes">
    <cfargument name="tcatDateRel" type="string" required="yes">
    <cfargument name="tcatDateExp" type="string" required="yes">
    <cfargument name="tcattID" type="string" required="yes">
    <cfargument name="tcatSort" type="string" required="yes">
    <cfargument name="tcatStatus" type="string" required="yes">
    <cfset result.message = "You have successfully inserted the record.">
    <cftry>
    <!---Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.app.training.Training"
    method="getTrainingCategory"
    returnvariable="getCheckTrainingCategoryRet">
    <cfinvokeargument name="tcatName" value="#ARGUMENTS.tcatName#"/>
    <cfinvokeargument name="tcattID" value="#ARGUMENTS.tcattID#"/>
    <cfinvokeargument name="tcatStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckTrainingCategoryRet.recordcount NEQ 0>
    <cfset result.message = "The name #ARGUMENTS.tcatName# in #ARGUMENTS.tcattID# already exists, please enter a new name.">
    <cfelse>
    <!---Check length restriction.--->
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    INSERT INTO tbl_training_category (tcatName,tcatDateRel,tcatDateExp,tcattID,tcatSort,tcatStatus) VALUES
    (
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.tcatName#">,
    <cfqueryparam cfsqltype="cf_sql_date" value="#ARGUMENTS.tcatDateRel#">,
    <cfqueryparam cfsqltype="cf_sql_date" value="#ARGUMENTS.tcatDateExp#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.tcattID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.tcatSort#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.tcatStatus#">
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
    
    <cffunction name="insertTrainingUserImport" access="public" returntype="struct">
    <cfargument name="tuUsername" type="numeric" required="yes">
    <cfargument name="tuFName" type="string" required="yes">
    <cfargument name="tuLName" type="string" required="yes">
    <cfargument name="tuEmail" type="string" required="yes">
    <cfargument name="tuManagerUserID" type="string" required="yes">
    <cfargument name="acugID" type="numeric" required="yes">
    <cfargument name="deptNo" type="numeric" required="yes">
    <cfargument name="siteNo" type="string" required="yes">
    <cfset result.message = "You have successfully inserted the record(s).">
    <cftry>
    <cfinvoke 
    component="MCMS.component.app.training.Training" 
    method="insertTrainingUser" 
    returnvariable="result">
    <cfinvokeargument name="tuFName" value="#ARGUMENTS.tuFName#">
    <cfinvokeargument name="tuLName" value="#ARGUMENTS.tuLName#">
    <cfinvokeargument name="tuUsername" value="#ARGUMENTS.tuUsername#">
    <cfinvokeargument name="tuPasswordTemp" value="#application.trainingDefaultPassword#">
    <cfinvokeargument name="tuEmail" value="#ARGUMENTS.tuEmail#">
    <cfinvokeargument name="tuEmailAlt" value="">
    <cfinvokeargument name="tuHost" value="0">
    <cfinvokeargument name="tuPresenter" value="0">
    <cfinvokeargument name="tuManagerUserID" value="#ARGUMENTS.tuManagerUserID#">  
    <cfinvokeargument name="tuStatus" value="1">  
    <!---Relationship arguments.--->
    <cfinvokeargument name="acugID" value="#ARGUMENTS.acugID#">
    <cfinvokeargument name="deptNo" value="#ARGUMENTS.deptNo#">
    <cfinvokeargument name="siteNo" value="#ARGUMENTS.siteNo#">
    <cfinvokeargument name="userID" value="101">                     
    </cfinvoke>
    <cfcatch type="any">
    <cfset result.message = "There was an error inserting the record(s).">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="updateTrainingUserImport" access="public" returntype="struct">
    <cfargument name="tuID" type="numeric" required="yes">
    <cfargument name="acuID" type="numeric" required="yes">
    <cfargument name="acugID" type="numeric" required="yes">
    <cfargument name="tuEmail" type="string" required="yes">
    <cfargument name="siteNo" type="string" required="yes">
    <cfargument name="deptNo" type="numeric" required="yes">
    <cfset result.message = "You have successfully inserted the record(s).">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_training_user SET
    tuEmail = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.tuEmail#">,
    userID = <cfqueryparam cfsqltype="cf_sql_integer" value="101">,
    tuStatus = <cfqueryparam cfsqltype="cf_sql_integer" value="1">
    WHERE ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.tuID#">
    </cfquery>
    </cftransaction>
    <!---Delete any existing relationships.--->
    <cfinvoke 
    component="MCMS.component.app.training.Training"
    method="deleteTrainingACUserGroupRel" >
    <cfinvokeargument name="tuID" value="#ARGUMENTS.tuID#"/>
    </cfinvoke>
    <cfinvoke 
    component="cfc.adobe_connect"
    method="deleteACUserFieldRel">
    <cfinvokeargument name="acuID" value="#ARGUMENTS.acuID#"/>
    <cfinvokeargument name="acufID" value="1,54950,61784,61785,61786,61787"/>
    </cfinvoke>
    <cfinvoke 
    component="MCMS.component.app.training.Training"
    method="deleteTrainingUserDepartmentRel">
    <cfinvokeargument name="tuID" value="#ARGUMENTS.tuID#"/>
    </cfinvoke>
    <cfinvoke 
    component="MCMS.component.app.training.Training"
    method="deleteTrainingUserSiteRel">
    <cfinvokeargument name="tuID" value="#ARGUMENTS.tuID#"/>
    </cfinvoke>
    <cfinvoke 
    component="MCMS.component.app.training.Training"
    method="deleteTrainingListingHostRel">
    <cfinvokeargument name="tuID" value="#ARGUMENTS.tuID#"/>
    </cfinvoke>
    <cfinvoke 
    component="MCMS.component.app.training.Training"
    method="deleteTrainingListingPresenterRel">
    <cfinvokeargument name="tuID" value="#ARGUMENTS.tuID#"/>
    </cfinvoke>
    <!---Create user relationships. This will include interface relationships as well.--->
    <cfinvoke 
    component="cfc.adobe_connect" 
    method="insertACUserEmailFieldRel" 
    >
    <cfinvokeargument name="acuID" value="#ARGUMENTS.acuID#">
    <cfinvokeargument name="acuEmail" value="#ARGUMENTS.tuEmail#">                         
    </cfinvoke>
    <cfinvoke 
    component="cfc.adobe_connect" 
    method="insertACUserGroupFieldRel">
    <cfinvokeargument name="acuID" value="#ARGUMENTS.acuID#">
    <cfinvokeargument name="acugID" value="#ARGUMENTS.acugID#">                         
    </cfinvoke>
    <cfloop index="acugID" list="#ARGUMENTS.acugID#">
    <cfinvoke 
    component="MCMS.component.app.training.Training"
    method="insertTrainingACUserGroupRel">
    <cfinvokeargument name="tuID" value="#ARGUMENTS.tuID#"/>
    <cfinvokeargument name="acuID" value="#ARGUMENTS.acuID#"/>
    <cfinvokeargument name="acugID" value="#acugID#"/>
    <cfinvokeargument name="tacugrStatus" value="1"/>
    </cfinvoke>
    </cfloop>
    <!---Create department relationships.--->
    <cfinvoke 
    component="cfc.adobe_connect" 
    method="insertACUserDepartmentFieldRel">
    <cfinvokeargument name="acuID" value="#ARGUMENTS.acuID#">
    <cfinvokeargument name="deptNo" value="#ARGUMENTS.deptNo#">                         
    </cfinvoke>
    <cfloop index="deptNo" list="#ARGUMENTS.deptNo#">
    <cfinvoke 
    component="MCMS.component.app.training.Training"
    method="insertTrainingUserDepartmentRel">
    <cfinvokeargument name="tuID" value="#ARGUMENTS.tuID#"/>
    <cfinvokeargument name="deptNo" value="#deptNo#"/>
    <cfinvokeargument name="tudrStatus" value="1"/>
    </cfinvoke>
    </cfloop>
    <!---Create site relationships.--->
    <cfinvoke 
    component="cfc.adobe_connect" 
    method="insertACUserSiteFieldRel">
    <cfinvokeargument name="acuID" value="#ARGUMENTS.acuID#">
    <cfinvokeargument name="siteNo" value="#ARGUMENTS.siteNo#">                         
    </cfinvoke>
    <cfloop index="siteNo" list="#ARGUMENTS.siteNo#">
    <cfinvoke 
    component="MCMS.component.app.training.Training"
    method="insertTrainingUserSiteRel">
    <cfinvokeargument name="tuID" value="#ARGUMENTS.tuID#"/>
    <cfinvokeargument name="siteNo" value="#siteNo#"/>
    <cfinvokeargument name="tusrStatus" value="1"/>
    </cfinvoke>
    </cfloop>
    <!---Now disable/enable the account in Adobe Connect.--->
    <cfinvoke 
    component="cfc.adobe_connect" 
    method="updateACUserList">
    <cfinvokeargument name="ID" value="#ARGUMENTS.acuID#">
    <cfinvokeargument name="tuStatus" value="1">
    </cfinvoke>
    <cfcatch type="any">
    <cfset result.message = "There was an error inserting the record(s).">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="updateTraining" access="public" returntype="struct">
    <cfargument name="ID" type="numeric" required="yes">
	<cfargument name="actID" type="numeric" required="yes">
    <cfargument name="tName" type="string" required="yes">
    <cfargument name="tDescription" type="string" required="yes">
    <cfargument name="tDateRel" type="string" required="yes">
    <cfargument name="tDateExp" type="string" required="yes">
    <cfargument name="tTag" type="string" required="yes">
    <cfargument name="tUserCapacity" type="numeric" required="yes">
    <cfargument name="tRequired" type="numeric" required="yes">
    <cfargument name="tDuration" type="string" required="yes">
    <cfargument name="tEmailList" type="string" required="yes">
    <cfargument name="tURL" type="string" required="yes">
    <cfargument name="tTarget" type="string" required="yes">
    <cfargument name="vID" type="string" required="yes">
    <cfargument name="bID" type="string" required="yes">
    <cfargument name="appID" type="string" required="yes">
    <cfargument name="ttID" type="string" required="yes">
    <cfargument name="tmtID" type="string" required="yes">
    <cfargument name="tdtID" type="string" required="yes">
    <cfargument name="tSort" type="string" required="yes">
    <cfargument name="tStatus" type="string" required="yes">
    <!---Relationship arguments.--->
    <cfargument name="deptNo" type="string" required="yes">
    <cfargument name="tcatID" type="string" required="yes">
    <cfargument name="tscatID" type="string" required="yes">
    <cfargument name="tlcatID" type="string" required="yes" default="0">
    <cfset result.message = "You have successfully updated the record.">
    <cftry>
    <!---Check for profanity in the text.--->
    <cfinvoke 
    component="MCMS.component.utility.Regex"
    method="regexProfanity"
    returnvariable="regexProfanityRet">
    <cfinvokeargument name="profanityString" value="#ARGUMENTS.tDescription#"/>
    </cfinvoke>
    <!---Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.app.training.Training"
    method="getTraining"
    returnvariable="getCheckTrainingRet">
    <cfinvokeargument name="excludeID" value="#ARGUMENTS.ID#"/>
    <cfinvokeargument name="tName" value="#ARGUMENTS.tName#"/>
    <cfinvokeargument name="tStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckTrainingRet.recordcount NEQ 0>
    <cfset result.message = "The name #ARGUMENTS.tName# already exists, please enter a new name.">
    <cfelseif regexProfanityRet CONTAINS '$%&*!'>
    <cfset result.message = "Some text contained profanity, please remove any profanity from your text.">
    <!---Check length restriction.--->
    <cfelseif LEN(ARGUMENTS.tDescription) GT 1024>
    <cfset result.message = "The description is longer than 1024 characters, please enter a new description under 1024 characters.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_training SET
    tName = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.tName#">,
	actID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.actID#">,
    tDescription = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.tDescription#">,
    tDateRel = <cfqueryparam cfsqltype="cf_sql_date" value="#ARGUMENTS.tDateRel#">,
    tDateExp = <cfqueryparam cfsqltype="cf_sql_date" value="#ARGUMENTS.tDateExp#">,
    tTag = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.tTag#">,
    tUserCapacity = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.tUserCapacity#">,
    tRequired = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.tRequired#">,
    tDuration = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.tDuration#">,
    tEmailList = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.tEmailList#">,
    tURL = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.tURL#">,
    tTarget = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.tTarget#">,
    vID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.vID#">,
    bID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.bID#">,
    appID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.appID#">,
    ttID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ttID#">,
    tmtID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.tmtID#">,
    tdtID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.tdtID#">,
    tSort = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.tSort#">,
    tStatus = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.tStatus#">
    WHERE ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ID#">
    </cfquery>
    </cftransaction>
    <!---Delete any existing relationships.--->
    <cfinvoke 
    component="MCMS.component.app.training.Training"
    method="deleteTrainingDepartmentRel">
    <cfinvokeargument name="tID" value="#ARGUMENTS.ID#"/>
    </cfinvoke>
    <cfinvoke 
    component="MCMS.component.app.training.Training"
    method="deleteTrainingCategoryRel">
    <cfinvokeargument name="tID" value="#ARGUMENTS.ID#"/>
    </cfinvoke>
    <!---Create department relationships.--->
    <cfloop index="deptNo" list="#ARGUMENTS.deptNo#">
    <cfinvoke 
    component="MCMS.component.app.training.Training"
    method="insertTrainingDepartmentRel">
    <cfinvokeargument name="tID" value="#ARGUMENTS.ID#"/>
    <cfinvokeargument name="deptNo" value="#deptNo#"/>
    <cfinvokeargument name="tdrStatus" value="1"/>
    </cfinvoke>
    </cfloop>
    <!---Create category relationships.--->
    <cfif ARGUMENTS.tcatID NEQ 0>
    <cfloop index="tcatID" list="#ARGUMENTS.tcatID#">
    <cfinvoke 
    component="MCMS.component.app.training.Training"
    method="insertTrainingCategoryRel">
    <cfinvokeargument name="tID" value="#ARGUMENTS.ID#"/>
    <cfinvokeargument name="tcatID" value="#tcatID#"/>
    <cfinvokeargument name="tcatrStatus" value="1"/>
    </cfinvoke>
    </cfloop>
    </cfif>
    <!---Create secondary category relationships.--->
    <cfif ARGUMENTS.tscatID NEQ 0>
    <cfloop index="tscatID" list="#ARGUMENTS.tscatID#">
    <cfinvoke 
    component="MCMS.component.app.training.Training"
    method="insertTrainingCategoryRel">
    <cfinvokeargument name="tID" value="#ARGUMENTS.ID#"/>
    <cfinvokeargument name="tcatID" value="#tscatID#"/>
    <cfinvokeargument name="tcatrStatus" value="1"/>
    </cfinvoke>
    </cfloop>
    </cfif>
    <!---Create secondary category relationships.--->
    <cfif ARGUMENTS.tlcatID NEQ 0>
    <cfloop index="tlcatID" list="#ARGUMENTS.tlcatID#">
    <cfinvoke 
    component="MCMS.component.app.training.Training"
    method="insertTrainingCategoryRel">
    <cfinvokeargument name="tID" value="#ARGUMENTS.ID#"/>
    <cfinvokeargument name="tcatID" value="#tlcatID#"/>
    <cfinvokeargument name="tcatrStatus" value="1"/>
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
    
    <cffunction name="updateTrainingListing" access="public" returntype="struct">
    <cfargument name="ID" type="numeric" required="yes">
    <cfargument name="tID" type="numeric" required="yes">
    <cfargument name="tlName" type="string" required="yes">
    <cfargument name="tlDescription" type="string" required="yes">
    <cfargument name="tlMessage" type="string" required="yes">
    <cfargument name="tlDateStart" type="string" required="yes">
    <cfargument name="tlDateEnd" type="string" required="yes">
    <cfargument name="tlHostUserID" type="string" required="yes">
    <cfargument name="tlPresenterUserID" type="string" required="yes">
    <cfargument name="tlConfID" type="string" required="yes">
    <cfargument name="tlSort" type="string" required="yes">
    <cfargument name="tlStatus" type="string" required="yes">
    <!---Relationship arguments.--->
    <cfargument name="siteNo" type="string" required="yes">
    <cfargument name="acugID" type="string" required="yes">
    <cfset result.message = "You have successfully updated the record.">
    <cftry>
    <!---Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.app.training.Training"
    method="getTrainingListing"
    returnvariable="getCheckTrainingListingRet">
    <cfinvokeargument name="excludeID" value="#ARGUMENTS.ID#"/>
    <cfinvokeargument name="tID" value="#ARGUMENTS.tID#"/>
    <cfinvokeargument name="tlName" value="#ARGUMENTS.tlName#"/>
    <cfinvokeargument name="tlStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckTrainingListingRet.recordcount NEQ 0>
    <cfset result.message = "The training listing #ARGUMENTS.tlName# already exists, please try again.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_training_listing SET
    tlName = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.tlName#">,
    tlDescription = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.tlDescription#">,
    tlMessage = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.tlMessage#">,
    tlDateStart = <cfqueryparam cfsqltype="cf_sql_date" value="#ARGUMENTS.tlDateStart#">,
    tlDateEnd = <cfqueryparam cfsqltype="cf_sql_date" value="#ARGUMENTS.tlDateEnd#">,
    userID = <cfqueryparam cfsqltype="cf_sql_integer" value="#session.userID#">,
    tlConfID = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.tlConfID#">,
    tlSort = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.tlSort#">,
    tlStatus = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.tlStatus#">
    WHERE ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ID#">
    </cfquery>
    <!---Delete any existing relationships.--->
    <cfinvoke 
    component="MCMS.component.app.training.Training"
    method="deleteTrainingListingSiteRel">
    <cfinvokeargument name="tlID" value="#ARGUMENTS.ID#"/>
    </cfinvoke>
    <cfinvoke 
    component="MCMS.component.app.training.Training"
    method="deleteTrainingListingHostRel">
    <cfinvokeargument name="tlID" value="#ARGUMENTS.ID#"/>
    </cfinvoke>
    <cfinvoke 
    component="MCMS.component.app.training.Training"
    method="deleteTrainingListingPresenterRel">
    <cfinvokeargument name="tlID" value="#ARGUMENTS.ID#"/>
    </cfinvoke>
    <cfinvoke 
    component="MCMS.component.app.training.Training"
    method="deleteTrainingListingACUserGroupAccessRel">
    <cfinvokeargument name="tlID" value="#ARGUMENTS.ID#"/>
    </cfinvoke>
    <cfinvoke 
    component="MCMS.component.app.training.Training"
    method="deleteTrainingListingTimeTableRel">
    <cfinvokeargument name="tlID" value="#ARGUMENTS.ID#"/>
    </cfinvoke>
    <cfif ARGUMENTS.tlHostUserID NEQ 0>
    <!---Create host relationships.--->
    <cfloop index="tlHostUserID" list="#ARGUMENTS.tlHostUserID#">
    <cfinvoke 
    component="MCMS.component.app.training.Training"
    method="insertTrainingListingHostRel">
    <cfinvokeargument name="tlID" value="#ARGUMENTS.ID#"/>
    <cfinvokeargument name="tuID" value="#tlHostUserID#"/>
    <cfinvokeargument name="tlhrStatus" value="1"/>
    </cfinvoke>
    </cfloop>
    </cfif>
    <cfif ARGUMENTS.tlPresenterUserID NEQ 0>
    <!---Create presenter relationships.--->
    <cfloop index="tlPresenterUserID" list="#ARGUMENTS.tlPresenterUserID#">
    <cfinvoke 
    component="MCMS.component.app.training.Training"
    method="insertTrainingListingPresenterRel">
    <cfinvokeargument name="tlID" value="#ARGUMENTS.ID#"/>
    <cfinvokeargument name="tuID" value="#tlPresenterUserID#"/>
    <cfinvokeargument name="tlprStatus" value="1"/>
    </cfinvoke>
    </cfloop>
    </cfif>
    <!---Create site relationships.--->
    <cfloop index="siteNo" list="#ARGUMENTS.siteNo#">
    <cfinvoke 
    component="MCMS.component.app.training.Training"
    method="insertTrainingListingSiteRel">
    <cfinvokeargument name="tlID" value="#ARGUMENTS.ID#"/>
    <cfinvokeargument name="siteNo" value="#siteNo#"/>
    <cfinvokeargument name="tlsrStatus" value="1"/>
    </cfinvoke>
    </cfloop>
    <!---Create user role relationships.--->
    <cfloop index="acugID" list="#ARGUMENTS.acugID#">
    <cfinvoke 
    component="MCMS.component.app.training.Training"
    method="insertTrainingListingACUserGroupAccessRel">
    <cfinvokeargument name="tlID" value="#ARGUMENTS.ID#"/>
    <cfinvokeargument name="acugID" value="#acugID#"/>
    <cfinvokeargument name="tlacugarStatus" value="1"/>
    </cfinvoke>
    </cfloop>
    <!---Loop for timetable insert---> 
    <cfloop index="i" from="1" to="#form.timeTableCount#">
    <cfif IsDefined(Evaluate(DE('form.dayID#i#'))) AND Evaluate('form.dayID#i#') NEQ ''>
    <cfinvoke 
    component="MCMS.component.app.training.Training" 
    method="insertTrainingListingTimeTableRel">
    <cfinvokeargument name="tlID" value="#ARGUMENTS.ID#">
    <cfinvokeargument name="dayID" value="#Evaluate('form.dayID#i#')#">
    <cfinvokeargument name="timeIDStart" value="#Evaluate('form.timeIDStart#i#')#">
    <cfinvokeargument name="timeIDEnd" value="#Evaluate('form.timeIDEnd#i#')#">
    <cfinvokeargument name="tltrStatus" value="1">                 
    </cfinvoke>
    </cfif>
    </cfloop>
    </cftransaction>
    </cfif>
    <cfcatch type="any">
    <cfset result.message = "There was an error updating the record.">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>

    <cffunction name="updateTrainingCategory" access="public" returntype="struct">
    <cfargument name="ID" type="numeric" required="yes">
    <cfargument name="tcatName" type="string" required="yes">
    <cfargument name="tcatDateRel" type="string" required="yes">
    <cfargument name="tcatDateExp" type="string" required="yes">
    <cfargument name="tcattID" type="string" required="yes">
    <cfargument name="tcatSort" type="string" required="yes">
    <cfargument name="tcatStatus" type="string" required="yes">
    <cfset result.message = "You have successfully updated the record.">
    <cftry>
    <!---Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.app.training.Training"
    method="getTrainingCategory"
    returnvariable="getCheckTrainingCategoryRet">
    <cfinvokeargument name="excludeID" value="#ARGUMENTS.ID#"/>
    <cfinvokeargument name="tcatName" value="#ARGUMENTS.tcatName#"/>
    <cfinvokeargument name="tcattID" value="#ARGUMENTS.tcattID#"/>
    <cfinvokeargument name="tcatStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckTrainingCategoryRet.recordcount NEQ 0>
    <cfset result.message = "The name #ARGUMENTS.tcatName# of type #ARGUMENTS.tcattName# already exists, please enter a new name.">
    <cfelse>
    <!---Check length restriction.--->
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_training_category SET
    tcatName = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.tcatName#">,
    tcatDateRel = <cfqueryparam cfsqltype="cf_sql_date" value="#ARGUMENTS.tcatDateRel#">,
    tcatDateExp = <cfqueryparam cfsqltype="cf_sql_date" value="#ARGUMENTS.tcatDateExp#">,
    tcattID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.tcattID#">,
    tcatSort = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.tcatSort#">,
    tcatStatus = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.tcatStatus#">
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
    
    <cffunction name="updateTrainingUser" access="public" returntype="struct">
    <cfargument name="ID" type="numeric" required="yes">
    <cfargument name="acuID" type="numeric" required="yes">
    <cfargument name="tufName" type="string" required="yes">
    <cfargument name="tuLName" type="string" required="yes">
    <cfargument name="tuUsername" type="string" required="yes">
    <cfargument name="tuPasswordTemp" type="string" required="yes">
    <cfargument name="tuEmail" type="string" required="yes">
    <cfargument name="tuEmailAlt" type="string" required="yes">
    <cfargument name="tuHost" type="numeric" required="yes">
    <cfargument name="tuPresenter" type="numeric" required="yes">
    <cfargument name="tuManagerUserID" type="string" required="yes">
    <cfargument name="userID" type="string" required="yes">
    <cfargument name="tuStatus" type="string" required="yes"> 
    <!---Relationship arguments.--->
    <cfargument name="acugID" type="string" required="yes">
    <cfargument name="deptNo" type="string" required="yes">
    <cfargument name="siteNo" type="string" required="yes">
    <cfset result.message = "You have successfully updated the user. <br><u>PLEASE NOTE it may take up to 2 hours to register this change</u>. <br>Have the user attempt to sign in 2 hours from now to see their training.">
    <cftry>
    <!---Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.app.training.Training"
    method="getTrainingUser"
    returnvariable="getCheckTrainingUserRet">
    <cfinvokeargument name="excludeID" value="#ARGUMENTS.ID#"/>
    <cfinvokeargument name="tuUsername" value="#ARGUMENTS.tuUsername#"/>
    <cfinvokeargument name="tuStatus" value="1,2,3"/>
    </cfinvoke>
    <!---Check for a duplicate record in interface database.--->
    <cfinvoke 
    component="cfc.adobe_connect"
    method="getACUser"
    returnvariable="getCheckACUserRet">
    <cfinvokeargument name="excludeID" value="#ARGUMENTS.acuID#"/>
    <cfinvokeargument name="acuUsername" value="#ARGUMENTS.tuUsername#"/>
    </cfinvoke>
    <cfif getCheckTrainingUserRet.recordcount NEQ 0>
    <cfset result.message = "The username '#ARGUMENTS.tuUsername#' already exists, please enter a new username.">
    <cfelseif getCheckACUserRet.recordcount NEQ 0>
    <cfset result.message = "The username '#ARGUMENTS.tuUsername#' already exists in the <u>interface</u>, please enter a new username.">
    <cfelse>
    <!---First update record in interface users table.--->
    <cfinvoke 
    component="cfc.adobe_connect" 
    method="updateACUser">
    <cfinvokeargument name="PRINCIPAL_ID" value="#ARGUMENTS.acuID#">
    <cfinvokeargument name="NAME" value="#ARGUMENTS.tuFName# #ARGUMENTS.tuLName#">
    <cfinvokeargument name="LOGIN" value="#ARGUMENTS.tuUsername#"> 
    <cfinvokeargument name="EXT_LOGIN" value="#ARGUMENTS.tuUsername#">
    <cfif ARGUMENTS.tuStatus EQ 2>
    <cfinvokeargument name="DISABLED" value="#Now()#">
    <cfelse>
    <cfinvokeargument name="DISABLED" value="">
    </cfif>                          
    </cfinvoke>
    <cfif ARGUMENTS.tuPasswordTemp NEQ ''>
    <!---Update or insert secure password.--->
    <cfinvoke 
    component="MCMS.component.app.training.Training"
    method="getTrainingUserSecurityKeyRel"
    returnvariable="getTrainingUserSecurityKeyRelRet">
    <cfinvokeargument name="tuID" value="#ARGUMENTS.ID#"/>
    <cfinvokeargument name="tuskrStatus" value="1,2,3"/>
    </cfinvoke>
    <!---Encrypt the password.--->
    <cfinvoke 
    component="MCMS.component.app.security.Security"
    method="setEcryption"
    returnvariable="setEcryptionRet">
    <cfinvokeargument name="value" value="#ARGUMENTS.tuPasswordTemp#"/>
    <cfinvokeargument name="valuePair" value="lorem"/>
    </cfinvoke>
    <cfset ARGUMENTS.tuPasswordTemp = setEcryptionRet.encryptKey>
    <cfif getTrainingUserSecurityKeyRelRet.recordcount EQ 0>
    <!---Create the security key.--->
    <cfinvoke 
    component="MCMS.component.app.training.Training"
    method="insertTrainingUserSecurityKeyRel"
    returnvariable="insertTrainingUserSecurityKeyRelRet">
    <cfinvokeargument name="tuID" value="#ARGUMENTS.ID#"/>
    <cfinvokeargument name="tuskrKey" value="#setEcryptionRet.encryptKey#"/>
    <cfinvokeargument name="tuskrKeyValue" value="#setEcryptionRet.encryptKeyValue#"/>
    <cfinvokeargument name="tuskrStatus" value="1"/>
    </cfinvoke>
    <cfelse>
    <!---If the record is updated then remove the old record and recreate it.--->
    <cfinvoke 
    component="MCMS.component.app.training.Training"
    method="deleteTrainingUserSecurityKeyRel">
    <cfinvokeargument name="tuID" value="#ARGUMENTS.ID#"/>
    </cfinvoke>
    <cfinvoke 
    component="MCMS.component.app.training.Training"
    method="insertTrainingUserSecurityKeyRel"
    returnvariable="insertTrainingUserSecurityKeyRelRet">
    <cfinvokeargument name="tuID" value="#ARGUMENTS.ID#"/>
    <cfinvokeargument name="tuskrKey" value="#setEcryptionRet.encryptKey#"/>
    <cfinvokeargument name="tuskrKeyValue" value="#setEcryptionRet.encryptKeyValue#"/>
    <cfinvokeargument name="tuskrStatus" value="1"/>
    </cfinvoke>
    </cfif>
    </cfif>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_training_user SET
    tuFName = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.tuFName#">,
    tuLName = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.tuLName#">,
    tuUsername = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.tuUsername#">,
    tuPasswordTemp = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.tuPasswordTemp#">,
    tuEmail = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.tuEmail#">,
    tuEmailAlt = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.tuEmailAlt#">,
    tuHost = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.tuHost#">,
    tuPresenter = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.tuPresenter#">,
    tuManagerUserID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.tuManagerUserID#">,
    tuDateUpdate = <cfqueryparam cfsqltype="cf_sql_date" value="#DateFormat(Now(), application.dateFormat)#">,
    userID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.userID#">,
    tuStatus = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.tuStatus#">
    WHERE ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ID#">
    </cfquery>
    </cftransaction>
    <!---Delete any existing relationships.--->
    <cfinvoke 
    component="MCMS.component.app.training.Training"
    method="deleteTrainingACUserGroupRel" >
    <cfinvokeargument name="tuID" value="#ARGUMENTS.ID#"/>
    </cfinvoke>
    <cfinvoke 
    component="cfc.adobe_connect"
    method="deleteACUserFieldRel">
    <cfinvokeargument name="acuID" value="#ARGUMENTS.acuID#"/>
    <cfinvokeargument name="acufID" value="1,54950,61784,61785,61786,61787"/>
    </cfinvoke>
    <cfinvoke 
    component="cfc.adobe_connect" 
    method="deleteACUserGroupRel" 
    >
    <cfinvokeargument name="acuID" value="#ARGUMENTS.acuID#">                         
    </cfinvoke>
    <cfinvoke 
    component="MCMS.component.app.training.Training"
    method="deleteTrainingUserDepartmentRel">
    <cfinvokeargument name="tuID" value="#ARGUMENTS.ID#"/>
    </cfinvoke>
    <cfinvoke 
    component="MCMS.component.app.training.Training"
    method="deleteTrainingUserSiteRel">
    <cfinvokeargument name="tuID" value="#ARGUMENTS.ID#"/>
    </cfinvoke>
    <cfinvoke 
    component="MCMS.component.app.training.Training"
    method="deleteTrainingListingHostRel">
    <cfinvokeargument name="tuID" value="#ARGUMENTS.ID#"/>
    </cfinvoke>
    <cfinvoke 
    component="MCMS.component.app.training.Training"
    method="deleteTrainingListingPresenterRel">
    <cfinvokeargument name="tuID" value="#ARGUMENTS.ID#"/>
    </cfinvoke>
    <!---Create user relationships. This will include interface relationships as well.--->
    <cfinvoke 
    component="cfc.adobe_connect" 
    method="insertACUserEmailFieldRel" 
    >
    <cfinvokeargument name="acuID" value="#ARGUMENTS.acuID#">
    <cfinvokeargument name="acuEmail" value="#ARGUMENTS.tuEmail#">                         
    </cfinvoke>
    <cfinvoke 
    component="cfc.adobe_connect" 
    method="insertACUserGroupFieldRel" 
    >
    <cfinvokeargument name="acuID" value="#ARGUMENTS.acuID#">
    <cfinvokeargument name="acugID" value="#ARGUMENTS.acugID#">                         
    </cfinvoke>
    <cfloop index="acugID" list="#ARGUMENTS.acugID#">
    <cfquery datasource="#application.mcmsDSN#">
    INSERT INTO tbl_training_ac_user_group_rel (tuID,acugID,tacugrStatus) VALUES
    (
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#acugID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.tuStatus#">
    )
    </cfquery>
    <cfinvoke 
    component="cfc.adobe_connect" 
    method="insertACUserGroupRel" 
    >
    <cfinvokeargument name="acugID" value="#acugID#">
    <cfinvokeargument name="acuID" value="#ARGUMENTS.acuID#">                         
    </cfinvoke>
    </cfloop>
    <!---Create department relationships.--->
    <cfinvoke 
    component="cfc.adobe_connect" 
    method="insertACUserDepartmentFieldRel" 
    >
    <cfinvokeargument name="acuID" value="#ARGUMENTS.acuID#">
    <cfinvokeargument name="deptNo" value="#ARGUMENTS.deptNo#">                         
    </cfinvoke>
    <cfloop index="deptNo" list="#ARGUMENTS.deptNo#">
    <cfinvoke 
    component="MCMS.component.app.training.Training"
    method="insertTrainingUserDepartmentRel">
    <cfinvokeargument name="tuID" value="#ARGUMENTS.ID#"/>
    <cfinvokeargument name="deptNo" value="#deptNo#"/>
    <cfinvokeargument name="tudrStatus" value="1"/>
    </cfinvoke>
    </cfloop>
    <!---Create site relationships.--->
    <cfinvoke 
    component="cfc.adobe_connect" 
    method="insertACUserSiteFieldRel" 
    >
    <cfinvokeargument name="acuID" value="#ARGUMENTS.acuID#">
    <cfinvokeargument name="siteNo" value="#ARGUMENTS.siteNo#">                         
    </cfinvoke>
    <cfloop index="siteNo" list="#ARGUMENTS.siteNo#">
    <cfinvoke 
    component="MCMS.component.app.training.Training"
    method="insertTrainingUserSiteRel">
    <cfinvokeargument name="tuID" value="#ARGUMENTS.ID#"/>
    <cfinvokeargument name="siteNo" value="#siteNo#"/>
    <cfinvokeargument name="tusrStatus" value="1"/>
    </cfinvoke>
    </cfloop>
    <!---Now disable/enable the account in Adobe Connect.--->
    <cfinvoke 
    component="cfc.adobe_connect" 
    method="updateACUserList">
    <cfinvokeargument name="ID" value="#ARGUMENTS.acuID#">
    <cfinvokeargument name="tuStatus" value="#ARGUMENTS.tuStatus#">
    </cfinvoke>
    </cfif>
    <cfcatch type="any">
    <cfset result.message = "There was an error updating the record.">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="updateTrainingRequest" access="public" returntype="struct">
    <cfargument name="ID" type="numeric" required="yes">
    <cfargument name="trTitle" type="string" required="yes">
    <cfargument name="trDescription" type="string" required="yes">
    <cfargument name="ticketNo" type="numeric" required="yes">
    <cfargument name="trLog" type="string" required="yes">
    <cfargument name="trpID" type="numeric" required="yes">
    <cfargument name="trsID" type="numeric" required="yes">
    <cfargument name="trStatus" type="string" required="yes">
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
    component="MCMS.component.app.training.Training"
    method="getTrainingRequest"
    returnvariable="getCheckTrainingRequestRet">
    <cfinvokeargument name="excludeID" value="#ARGUMENTS.ID#"/>
    <cfinvokeargument name="trTitle" value="#ARGUMENTS.trTitle#"/>
    <cfinvokeargument name="trStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckTrainingRequestRet.recordcount NEQ 0>
    <cfset result.message = "The name #ARGUMENTS.trTitle# already exists, please enter a new title.">
    <cfelseif regexProfanityRet CONTAINS '$%&*!'>
    <cfset result.message = "Some text contained profanity, please remove any profanity from your text.">
    <!---Check length restriction.--->
    <cfelseif LEN(ARGUMENTS.trDescription) GT 4000>
    <cfset result.message = "The description is longer than 4000 characters, please enter a new description under 4000 characters.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_training_request SET
    trTitle = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.trTitle#">,
    trDescription = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.trDescription#">,
    trDateUpdate = <cfqueryparam cfsqltype="cf_sql_date" value="#DateFormat(Now(), application.dateFormat)#">,
    ticketNo = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ticketNo#">,
    trLog = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.trLog#">,
    trpID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.trpID#">,
    trsID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.trsID#">,
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
    
    <cffunction name="updateTrainingList" access="public" returntype="struct">
    <cfargument name="ID" type="numeric" required="yes">
    <cfargument name="tStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully updated the records.">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_training SET
    tStatus = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.tStatus#">
    WHERE ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ID#">
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error updating the records.">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="updateTrainingListingList" access="public" returntype="struct">
    <cfargument name="ID" type="numeric" required="yes">
    <cfargument name="tlStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully updated the records.">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_training_listing SET
    tlStatus = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.tlStatus#">
    WHERE ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ID#">
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error updating the records.">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="updateTrainingUserList" access="public" returntype="struct">
    <cfargument name="ID" type="numeric" required="yes">
    <cfargument name="acuID" type="numeric" required="yes">
    <cfargument name="tuStatus" type="string" required="yes">
    <cfset result.message = "You have successfully updated the records.">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_training_user SET
    tuStatus = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.tuStatus#">
    WHERE ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ID#">
    </cfquery>
    </cftransaction>
    <!---Now disable/enable the account in Adobe Connect.--->
    <cfinvoke 
    component="cfc.adobe_connect" 
    method="updateACUserList" 
    >
    <cfinvokeargument name="ID" value="#ARGUMENTS.acuID#">
    <cfinvokeargument name="tuStatus" value="#ARGUMENTS.tuStatus#">
    </cfinvoke>
    <cfcatch type="any">
    <cfset result.message = "There was an error updating the records.">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="updateTrainingCategoryList" access="public" returntype="struct">
    <cfargument name="ID" type="numeric" required="yes">
    <cfargument name="tcatStatus" type="string" required="yes">
    <cfset result.message = "You have successfully updated the records.">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_training_category SET
    tcatStatus = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.tcatStatus#">
    WHERE ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ID#">
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error updating the records.">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="updateTrainingRequestList" access="public" returntype="struct">
    <cfargument name="ID" type="numeric" required="yes">
    <cfargument name="trStatus" type="string" required="yes">
    <cfset result.message = "You have successfully updated the records.">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_training_request SET
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
    
    <cffunction name="deleteTraining" access="public" returntype="struct">
    <cfargument name="ID" type="string" required="yes">
    <cfset result.message = "You have successfully deleted the record(s).">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    DELETE FROM tbl_training
    WHERE ID IN (<cfqueryparam cfsqltype="cf_sql_integer" list="yes" value="#ARGUMENTS.ID#">)
    </cfquery>
    </cftransaction>
    <!---Delete any existing relationships.--->
    <cfinvoke 
    component="MCMS.component.app.training.Training"
    method="deleteTrainingListingRel">
    <cfinvokeargument name="tID" value="#ARGUMENTS.ID#"/>
    </cfinvoke>
    <cfcatch type="any">
    <cfset result.message = "There was an error deleting the record(s).">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="deleteTrainingRequest" access="public" returntype="struct">
    <cfargument name="ID" type="string" required="yes">
    <cfset result.message = "You have successfully deleted the record(s).">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    DELETE FROM tbl_training_request
    WHERE ID IN (<cfqueryparam cfsqltype="cf_sql_integer" list="yes" value="#ARGUMENTS.ID#">)
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error deleting the record(s).">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="deleteTrainingDepartmentRel" access="public" returntype="struct">
    <cfargument name="ID" type="string" required="yes" default="0">
    <cfargument name="tID" type="string" required="yes" default="0">
    <cfset result.message = "You have successfully deleted the record(s).">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    DELETE FROM tbl_training_department_rel
    WHERE ID IN (<cfqueryparam cfsqltype="cf_sql_integer" list="yes" value="#ARGUMENTS.ID#">)
    OR tID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.tID#">
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error deleting the record(s).">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction> 
    
    <cffunction name="deleteTrainingListing" access="public" returntype="struct">
    <cfargument name="ID" type="string" required="yes" default="0">
    <cfargument name="tID" type="string" required="yes" default="0">
    <cfset result.message = "You have successfully deleted the record(s).">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    DELETE FROM tbl_training_listing
    WHERE ID IN (<cfqueryparam cfsqltype="cf_sql_integer" list="yes" value="#ARGUMENTS.ID#">)
    OR tID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.tID#">
    </cfquery>
    </cftransaction>
    <!---Delete any existing relationships.--->
    <cfinvoke 
    component="MCMS.component.app.training.Training"
    method="deleteTrainingListingSiteRel">
    <cfinvokeargument name="tlID" value="#ARGUMENTS.ID#"/>
    </cfinvoke>
    <cfinvoke 
    component="MCMS.component.app.training.Training"
    method="deleteTrainingListingHostRel">
    <cfinvokeargument name="tlID" value="#ARGUMENTS.ID#"/>
    </cfinvoke>
    <cfinvoke 
    component="MCMS.component.app.training.Training"
    method="deleteTrainingListingPresenterRel">
    <cfinvokeargument name="tlID" value="#ARGUMENTS.ID#"/>
    </cfinvoke>
    <cfinvoke 
    component="MCMS.component.app.training.Training"
    method="deleteTrainingListingACUserGroupAccessRel">
    <cfinvokeargument name="tlID" value="#ARGUMENTS.ID#"/>
    </cfinvoke>
    <cfinvoke 
    component="MCMS.component.app.training.Training"
    method="deleteTrainingListingTimeTableRel">
    <cfinvokeargument name="tlID" value="#ARGUMENTS.ID#"/>
    </cfinvoke>
    <cfcatch type="any">
    <cfset result.message = "There was an error deleting the record(s).">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="deleteTrainingListingSiteRel" access="public" returntype="struct">
    <cfargument name="ID" type="string" required="yes" default="0">
    <cfargument name="tlID" type="string" required="yes" default="0">
    <cfset result.message = "You have successfully deleted the record(s).">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    DELETE FROM tbl_training_listing_site_rel
    WHERE ID IN (<cfqueryparam cfsqltype="cf_sql_integer" list="yes" value="#ARGUMENTS.ID#">)
    OR tlID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.tlID#">
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error deleting the record(s).">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="deleteTrainingListingHostRel" access="public" returntype="struct">
    <cfargument name="ID" type="string" required="yes" default="0">
    <cfargument name="tlID" type="string" required="yes" default="0">
    <cfargument name="tuID" type="string" required="yes" default="0">
    <cfset result.message = "You have successfully deleted the record(s).">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    DELETE FROM tbl_training_listing_host_rel
    WHERE ID IN (<cfqueryparam cfsqltype="cf_sql_integer" list="yes" value="#ARGUMENTS.ID#">)
    OR tlID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.tlID#">
    OR tuID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.tuID#">
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error deleting the record(s).">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="deleteTrainingListingPresenterRel" access="public" returntype="struct">
    <cfargument name="ID" type="string" required="yes" default="0">
    <cfargument name="tlID" type="string" required="yes" default="0">
    <cfargument name="tuID" type="string" required="yes" default="0">
    <cfset result.message = "You have successfully deleted the record(s).">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    DELETE FROM tbl_training_l_presenter_rel
    WHERE ID IN (<cfqueryparam cfsqltype="cf_sql_integer" list="yes" value="#ARGUMENTS.ID#">)
    OR tlID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.tlID#">
    OR tuID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.tuID#">
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error deleting the record(s).">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="deleteTrainingListingTimeTableRel" access="public" returntype="struct">
    <cfargument name="ID" type="string" required="yes" default="0">
    <cfargument name="tlID" type="string" required="yes" default="0">
    <cfset result.message = "You have successfully deleted the record(s).">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    DELETE FROM tbl_training_l_timetable_rel
    WHERE ID IN (<cfqueryparam cfsqltype="cf_sql_integer" list="yes" value="#ARGUMENTS.ID#">)
    OR tlID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.tlID#">
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error deleting the record(s).">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction> 
    
    <cffunction name="deleteTrainingUser" access="public" returntype="struct">
    <cfargument name="ID" type="string" required="yes">
    <cfset result.message = "You have successfully updated/deleted the record(s).">
    <cftry>
    <!---Get a list of acuID's to update the Adobe Connect table.--->
    <cfquery name="getACUserList" datasource="#application.mcmsDSN#">
    SELECT acuID FROM tbl_training_user
    WHERE ID IN (<cfqueryparam cfsqltype="cf_sql_integer" list="yes" value="#ARGUMENTS.ID#">)
    </cfquery>
    <cfif getACUserList.recordcount NEQ 0>
    <cfset this.acuIDList = ValueList(getACUserList.acuID)>
    <cfset result.message = this.acuIDList>
    <!---Update the Adobe Connect user to disabled.--->
    <cfloop index="i" list="#this.acuIDList#">
    <cfinvoke 
    component="cfc.adobe_connect" 
    method="updateACUserList">
    <cfinvokeargument name="ID" value="#i#">
    <cfinvokeargument name="tuStatus" value="2">
    </cfinvoke>
    </cfloop>
    </cfif>
    <!---Delete other records related to these users.--->
    <cfinvoke 
    component="MCMS.component.app.training.Training" 
    method="deleteTrainingACUserGroupRel">
    <cfinvokeargument name="tuID" value="#ARGUMENTS.ID#">
    </cfinvoke>
    <cfinvoke 
    component="MCMS.component.app.training.Training" 
    method="deleteTrainingUserDepartmentRel">
    <cfinvokeargument name="tuID" value="#ARGUMENTS.ID#">
    </cfinvoke>
    <cfinvoke 
    component="MCMS.component.app.training.Training" 
    method="deleteTrainingUserSiteRel">
    <cfinvokeargument name="tuID" value="#ARGUMENTS.ID#">
    </cfinvoke>
    <cfinvoke 
    component="MCMS.component.app.training.Training" 
    method="deleteTrainingListingHostRel">
    <cfinvokeargument name="tuID" value="#ARGUMENTS.ID#">
    </cfinvoke>
    <cfinvoke 
    component="MCMS.component.app.training.Training" 
    method="deleteTrainingListingPresenterRel">
    <cfinvokeargument name="tuID" value="#ARGUMENTS.ID#">
    </cfinvoke>
    <cfinvoke 
    component="MCMS.component.app.training.Training"
    method="deleteTrainingUserSecurityKeyRel">
    <cfinvokeargument name="tuID" value="#ARGUMENTS.ID#"/>
    </cfinvoke>
    <cfinvoke 
    component="MCMS.component.app.training.Training"
    method="deleteTrainingUserSecurityQuestionAnswerRel">
    <cfinvokeargument name="tuID" value="#ARGUMENTS.ID#"/>
    </cfinvoke>
    <cfinvoke 
    component="MCMS.component.app.training.Training" 
    method="deleteTrainingUserLog">
    <cfinvokeargument name="tuID" value="#ARGUMENTS.ID#">
    </cfinvoke>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    DELETE FROM tbl_training_user
    WHERE ID IN (<cfqueryparam cfsqltype="cf_sql_integer" list="yes" value="#ARGUMENTS.ID#">)
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error deleting the record(s).">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction> 
   
    <cffunction name="deleteTrainingACUserGroupRel" access="public" returntype="struct">
    <cfargument name="ID" type="string" required="yes" default="0">
    <cfargument name="tuID" type="string" required="yes" default="0">
    <cfset result.message = "You have successfully deleted the record(s).">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    DELETE FROM tbl_training_ac_user_group_rel
    WHERE ID IN (<cfqueryparam cfsqltype="cf_sql_integer" list="yes" value="#ARGUMENTS.ID#">)
    OR tuID IN (<cfqueryparam cfsqltype="cf_sql_integer" list="yes" value="#ARGUMENTS.tuID#">)
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error deleting the record(s).">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="deleteTrainingListingACUserGroupAccessRel" access="public" returntype="struct">
    <cfargument name="ID" type="string" required="yes" default="0">
    <cfargument name="tlID" type="string" required="yes" default="0">
    <cfset result.message = "You have successfully deleted the record(s).">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    DELETE FROM tbl_training_l_ac_ug_a_rel
    WHERE ID IN (<cfqueryparam cfsqltype="cf_sql_integer" list="yes" value="#ARGUMENTS.ID#">)
    OR tlID IN (<cfqueryparam cfsqltype="cf_sql_integer" list="yes" value="#ARGUMENTS.tlID#">)
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error deleting the record(s).">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction> 
    
    <cffunction name="deleteTrainingUserDepartmentRel" access="public" returntype="struct">
    <cfargument name="ID" type="string" required="yes" default="0">
    <cfargument name="tuID" type="string" required="yes" default="0">
    <cfset result.message = "You have successfully deleted the record(s).">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    DELETE FROM tbl_training_user_dept_rel
    WHERE ID IN (<cfqueryparam cfsqltype="cf_sql_integer" list="yes" value="#ARGUMENTS.ID#">)
    OR tuID IN (<cfqueryparam cfsqltype="cf_sql_integer" list="yes" value="#ARGUMENTS.tuID#">)
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error deleting the record(s).">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction> 
    
    <cffunction name="deleteTrainingUserSiteRel" access="public" returntype="struct">
    <cfargument name="ID" type="string" required="yes" default="0">
    <cfargument name="tuID" type="string" required="yes" default="0">
    <cfset result.message = "You have successfully deleted the record(s).">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    DELETE FROM tbl_training_user_site_rel
    WHERE ID IN (<cfqueryparam cfsqltype="cf_sql_integer" list="yes" value="#ARGUMENTS.ID#">)
    OR tuID IN (<cfqueryparam cfsqltype="cf_sql_integer" list="yes" value="#ARGUMENTS.tuID#">)
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error deleting the record(s).">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="deleteTrainingUserSecurityKeyRel" access="public" returntype="struct">
    <cfargument name="ID" type="string" required="yes" default="0">
    <cfargument name="tuID" type="string" required="yes" default="0">
    <cfset result.message = "You have successfully deleted the record(s).">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    DELETE FROM tbl_training_user_sec_key_rel
    WHERE ID IN (<cfqueryparam cfsqltype="cf_sql_integer" list="yes" value="#ARGUMENTS.ID#">)
    OR tuID IN (<cfqueryparam cfsqltype="cf_sql_integer" list="yes" value="#ARGUMENTS.tuID#">)
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error deleting the record(s).">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="deleteTrainingUserSecurityQuestionAnswerRel" access="public" returntype="struct">
    <cfargument name="ID" type="string" required="yes" default="0">
    <cfargument name="tuID" type="string" required="yes" default="0">
    <cfset result.message = "You have successfully deleted the record(s).">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    DELETE FROM tbl_training_user_sqa_rel
    WHERE ID IN (<cfqueryparam cfsqltype="cf_sql_integer" list="yes" value="#ARGUMENTS.ID#">)
    OR tuID IN (<cfqueryparam cfsqltype="cf_sql_integer" list="yes" value="#ARGUMENTS.tuID#">)
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error deleting the record(s).">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="deleteTrainingUserLog" access="public" returntype="struct">
    <cfargument name="ID" type="string" required="yes" default="0">
    <cfargument name="tuID" type="string" required="yes" default="0">
    <cfset result.message = "You have successfully deleted the record(s).">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    DELETE FROM tbl_training_user_log
    WHERE ID IN (<cfqueryparam cfsqltype="cf_sql_integer" list="yes" value="#ARGUMENTS.ID#">)
    OR tuID IN (<cfqueryparam cfsqltype="cf_sql_integer" list="yes" value="#ARGUMENTS.tuID#">)
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error deleting the record(s).">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="deleteTrainingCategory" access="public" returntype="struct">
    <cfargument name="ID" type="string" required="yes">
    <cfset result.message = "You have successfully deleted the record(s).">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    DELETE FROM tbl_training_category
    WHERE ID IN (<cfqueryparam cfsqltype="cf_sql_integer" list="yes" value="#ARGUMENTS.ID#">)
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error deleting the record(s).">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction> 
    
    <cffunction name="deleteTrainingCategoryRel" access="public" returntype="struct">
    <cfargument name="ID" type="string" required="yes" default="0">
    <cfargument name="tID" type="string" required="yes" default="0">
    <cfargument name="tcatID" type="string" required="yes" default="0">
    <cfset result.message = "You have successfully deleted the record(s).">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    DELETE FROM tbl_training_category_rel
    WHERE ID IN (<cfqueryparam cfsqltype="cf_sql_integer" list="yes" value="#ARGUMENTS.ID#">)
    OR tID IN (<cfqueryparam cfsqltype="cf_sql_integer" list="yes" value="#ARGUMENTS.tID#">)
    OR tcatID IN (<cfqueryparam cfsqltype="cf_sql_integer" list="yes" value="#ARGUMENTS.tcatID#">)
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error deleting the record(s).">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>   
</cfcomponent>