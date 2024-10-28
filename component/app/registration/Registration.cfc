<cfcomponent>
    <cffunction name="getRegistration" access="public" returntype="query" hint="Get Registration data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="ID" type="numeric" required="yes" default="0">
    <cfargument name="excludeID" type="numeric" required="yes" default="0">
    <cfargument name="regName" type="string" required="yes" default="">
    <cfargument name="regDateRel" type="string" required="yes" default="">
    <cfargument name="regDateExp" type="string" required="yes" default="">
    <cfargument name="regStatus" type="string" required="yes" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="regName">
    <cfset var rsRegistration = "" >
    <cftry>
    <cfquery name="rsRegistration" datasource="#application.mcmsDSN#">
    SELECT * FROM v_registration WHERE 0=0
    <cfif ARGUMENTS.ID NEQ 0>
    AND ID = <cfqueryparam value="#ARGUMENTS.ID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.excludeID NEQ 0>
    AND ID <> <cfqueryparam value="#ARGUMENTS.excludeID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(regName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(regDescription) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">)
    </cfif>
    <cfif ARGUMENTS.regName NEQ "">
    AND UPPER(regName) = <cfqueryparam value="#UCASE(ARGUMENTS.regName)#" cfsqltype="cf_sql_varchar">
    </cfif>
    <cfif ARGUMENTS.regDateRel NEQ "">
    AND regDateRel <= <cfqueryparam value="#ARGUMENTS.regDateRel#" cfsqltype="cf_sql_date">
    </cfif>
    <cfif ARGUMENTS.regDateExp NEQ "">
    AND regDateExp >= <cfqueryparam value="#ARGUMENTS.regDateExp#" cfsqltype="cf_sql_date">
    </cfif>
    AND regStatus IN (<cfqueryparam value="#ARGUMENTS.regStatus#" list="yes" cfsqltype="cf_sql_integer">)
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsRegistration = StructNew()>
    <cfset rsRegistration.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsRegistration>
    </cffunction>
    
    <cffunction name="getRegistrationType" access="public" returntype="query" hint="Get Registration Type data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="ID" type="numeric" required="yes" default="0">
    <cfargument name="excludeID" type="numeric" required="yes" default="0">
    <cfargument name="rtName" type="string" required="yes" default="">
    <cfargument name="rtTemplate" type="string" required="yes" default="">
    <cfargument name="rtStatus" type="string" required="yes" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="rtName">
    <cfset var rsRegistrationType = "" >
    <cftry>
    <cfquery name="rsRegistrationType" datasource="#application.mcmsDSN#">
    SELECT * FROM v_registration_type WHERE 0=0
    <cfif ARGUMENTS.ID NEQ 0>
    AND ID = <cfqueryparam value="#ARGUMENTS.ID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.excludeID NEQ 0>
    AND ID <> <cfqueryparam value="#ARGUMENTS.excludeID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(rtName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(rtDescription) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">)
    </cfif>
    <cfif ARGUMENTS.rtName NEQ "">
    AND UPPER(rtName) = <cfqueryparam value="#UCASE(ARGUMENTS.rtName)#" cfsqltype="cf_sql_varchar">
    </cfif>
    <cfif ARGUMENTS.rtTemplate NEQ "">
    AND UPPER(rtTemplate) = <cfqueryparam value="#UCASE(ARGUMENTS.rtTemplate)#" cfsqltype="cf_sql_varchar">
    </cfif>
    AND rtStatus IN (<cfqueryparam value="#ARGUMENTS.rtStatus#" list="yes" cfsqltype="cf_sql_integer">)
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsRegistrationType = StructNew()>
    <cfset rsRegistrationType.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsRegistrationType>
    </cffunction>
    
    <cffunction name="getRegSubscriptionRel" access="public" returntype="query" hint="Get Registration Subscription Rel. data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="ID" type="numeric" required="yes" default="0">
    <cfargument name="excludeID" type="numeric" required="yes" default="0">
    <cfargument name="regName" type="string" required="yes" default="">
    <cfargument name="regEmail" type="string" required="yes" default="">
    <cfargument name="regID" type="numeric" required="yes" default="0">
    <cfargument name="rsrType" type="string" required="yes" default="">
    <cfargument name="regStatus" type="string" required="yes" default="1,3">
    <cfargument name="rsrStatus" type="string" required="yes" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="regName">
    <cfset var rsRegSubscriptionRel = "" >
    <cftry>
    <cfquery name="rsRegSubscriptionRel" datasource="#application.mcmsDSN#">
    SELECT * FROM v_reg_subscription_rel WHERE 0=0
    <cfif ARGUMENTS.ID NEQ 0>
    AND ID = <cfqueryparam value="#ARGUMENTS.ID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.excludeID NEQ 0>
    AND ID <> <cfqueryparam value="#ARGUMENTS.excludeID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(regName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(subfName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">)
    </cfif>
    <cfif ARGUMENTS.regName NEQ "">
    AND UPPER(regName) = <cfqueryparam value="#UCASE(ARGUMENTS.regName)#" cfsqltype="cf_sql_varchar">
    </cfif>
    <cfif ARGUMENTS.regID NEQ 0>
    AND regID = <cfqueryparam value="#ARGUMENTS.regID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.regEmail NEQ "">
    AND UPPER(subEmail) = <cfqueryparam value="#UCASE(ARGUMENTS.regEmail)#" cfsqltype="cf_sql_varchar">
    </cfif>
    <cfif ARGUMENTS.rsrType NEQ "">
    AND UPPER(rsrType) = <cfqueryparam value="#UCASE(ARGUMENTS.rsrType)#" cfsqltype="cf_sql_varchar">
    </cfif>
    AND rsrStatus IN (<cfqueryparam value="#ARGUMENTS.rsrStatus#" list="yes" cfsqltype="cf_sql_integer">)
    AND regStatus IN (<cfqueryparam value="#ARGUMENTS.regStatus#" list="yes" cfsqltype="cf_sql_integer">)
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsRegSubscriptionRel = StructNew()>
    <cfset rsRegSubscriptionRel.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsRegSubscriptionRel>
    </cffunction>
    
    <cffunction name="getRegistrationSocialRel" access="public" returntype="query" hint="Get Registration Social Rel. data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="ID" type="numeric" required="yes" default="0">
    <cfargument name="excludeID" type="numeric" required="yes" default="0">
    <cfargument name="regID" type="string" required="yes" default="0">
    <cfargument name="regName" type="string" required="yes" default="">
    <cfargument name="socName" type="string" required="yes" default="">
    <cfargument name="socID" type="string" required="yes" default="0">
    <cfargument name="rtID" type="numeric" required="yes" default="0">
    <cfargument name="soctID" type="string" required="yes" default="0">
    <cfargument name="regDateExp" type="string" required="yes" default="">
    <cfargument name="socDateExp" type="string" required="yes" default="">
    <cfargument name="regStatus" type="string" required="yes" default="1,3">
    <cfargument name="socStatus" type="string" required="yes" default="1,3">
    <cfargument name="rsrStatus" type="string" required="yes" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="socName">
    <cfset var rsRegistrationSocialRel = "" >
    <cftry>
    <cfquery name="rsRegistrationSocialRel" datasource="#application.mcmsDSN#">
    SELECT * FROM v_reg_social_rel WHERE 0=0
    <cfif ARGUMENTS.ID NEQ 0>
    AND ID = <cfqueryparam value="#ARGUMENTS.ID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.excludeID NEQ 0>
    AND ID <> <cfqueryparam value="#ARGUMENTS.excludeID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.regID NEQ 0>
    AND regID IN (<cfqueryparam value="#ARGUMENTS.regID#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(regName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(socName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">)
    </cfif>
    <cfif ARGUMENTS.regName NEQ "">
    AND UPPER(regName) = <cfqueryparam value="#UCASE(ARGUMENTS.regName)#" cfsqltype="cf_sql_varchar">
    </cfif>
    <cfif ARGUMENTS.socName NEQ "">
    AND UPPER(socName) = <cfqueryparam value="#UCASE(ARGUMENTS.socName)#" cfsqltype="cf_sql_varchar">
    </cfif>
    <cfif ARGUMENTS.rtID NEQ 0>
    AND rtID = <cfqueryparam value="#ARGUMENTS.rtID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.socID NEQ 0>
    AND socID IN (<cfqueryparam value="#ARGUMENTS.socID#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    <cfif ARGUMENTS.regDateExp NEQ "">
    AND regDateExp >= <cfqueryparam value="#ARGUMENTS.regDateExp#" cfsqltype="cf_sql_date">
    </cfif>
    <cfif ARGUMENTS.socDateExp NEQ "">
    AND socDateExp >= <cfqueryparam value="#ARGUMENTS.socDateExp#" cfsqltype="cf_sql_date">
    </cfif>
    <cfif ARGUMENTS.soctID NEQ 0>
    AND soctID IN (<cfqueryparam value="#ARGUMENTS.soctID#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    AND regStatus IN (<cfqueryparam value="#ARGUMENTS.regStatus#" list="yes" cfsqltype="cf_sql_integer">)
    AND socStatus IN (<cfqueryparam value="#ARGUMENTS.socStatus#" list="yes" cfsqltype="cf_sql_integer">)
    AND rsrStatus IN (<cfqueryparam value="#ARGUMENTS.rsrStatus#" list="yes" cfsqltype="cf_sql_integer">)
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsRegistrationSocialRel = StructNew()>
    <cfset rsRegistrationSocialRel.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsRegistrationSocialRel>
    </cffunction>
    
    <cffunction name="getRegistrationSiteRel" access="public" returntype="query" hint="Get Registration Site Rel. data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="ID" type="numeric" required="yes" default="0">
    <cfargument name="excludeID" type="numeric" required="yes" default="0">
    <cfargument name="regID" type="string" required="yes" default="0">
    <cfargument name="regName" type="string" required="yes" default="">
    <cfargument name="siteName" type="string" required="yes" default="">
    <cfargument name="siteNo" type="string" required="yes" default="100">
    <cfargument name="rtID" type="numeric" required="yes" default="0">
    <cfargument name="stID" type="string" required="yes" default="0">
    <cfargument name="regDateExp" type="string" required="yes" default="">
    <cfargument name="regStatus" type="string" required="yes" default="1,3">
    <cfargument name="siteStatus" type="string" required="yes" default="1,3">
    <cfargument name="rsrStatus" type="string" required="yes" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="siteName">
    <cfset var rsRegistrationSiteRel = "" >
    <cftry>
    <cfquery name="rsRegistrationSiteRel" datasource="#application.mcmsDSN#">
    SELECT * FROM v_reg_site_rel WHERE 0=0
    <cfif ARGUMENTS.ID NEQ 0>
    AND ID = <cfqueryparam value="#ARGUMENTS.ID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.excludeID NEQ 0>
    AND ID <> <cfqueryparam value="#ARGUMENTS.excludeID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.regID NEQ 0>
    AND regID IN (<cfqueryparam value="#ARGUMENTS.regID#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(regName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(siteName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">)
    </cfif>
    <cfif ARGUMENTS.regName NEQ "">
    AND UPPER(regName) = <cfqueryparam value="#UCASE(ARGUMENTS.regName)#" cfsqltype="cf_sql_varchar">
    </cfif>
    <cfif ARGUMENTS.siteName NEQ "">
    AND UPPER(siteName) = <cfqueryparam value="#UCASE(ARGUMENTS.siteName)#" cfsqltype="cf_sql_varchar">
    </cfif>
    <cfif ARGUMENTS.rtID NEQ 0>
    AND rtID = <cfqueryparam value="#ARGUMENTS.rtID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.siteNo NEQ 100>
    AND siteNo IN (<cfqueryparam value="#ARGUMENTS.siteNo#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    <cfif ARGUMENTS.regDateExp NEQ "">
    AND regDateExp >= <cfqueryparam value="#ARGUMENTS.regDateExp#" cfsqltype="cf_sql_date">
    </cfif>
    AND regStatus IN (<cfqueryparam value="#ARGUMENTS.regStatus#" list="yes" cfsqltype="cf_sql_integer">)
    AND siteStatus IN (<cfqueryparam value="#ARGUMENTS.siteStatus#" list="yes" cfsqltype="cf_sql_integer">)
    AND rsrStatus IN (<cfqueryparam value="#ARGUMENTS.rsrStatus#" list="yes" cfsqltype="cf_sql_integer">)
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsRegistrationSiteRel = StructNew()>
    <cfset rsRegistrationSiteRel.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsRegistrationSiteRel>
    </cffunction>
    
    <cffunction name="getRegistrationEntryRel" access="public" returntype="query" hint="Get Registration Entry Rel. data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="ID" type="numeric" required="yes" default="0">
    <cfargument name="excludeID" type="numeric" required="yes" default="0">
    <cfargument name="regID" type="numeric" required="yes" default="0">
    <cfargument name="subID" type="numeric" required="yes" default="0">
    <cfargument name="regStatus" type="string" required="yes" default="1,3">
    <cfargument name="rerStatus" type="string" required="yes" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="regName">
    <cfset var rsRegistrationEntryRel = "" >
    <cftry>
    <cfquery name="rsRegistrationEntryRel" datasource="#application.mcmsDSN#">
    SELECT * FROM v_registration_entry_rel WHERE 0=0
    <cfif ARGUMENTS.ID NEQ 0>
    AND ID = <cfqueryparam value="#ARGUMENTS.ID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.excludeID NEQ 0>
    AND ID <> <cfqueryparam value="#ARGUMENTS.excludeID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(regName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(subfName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">)
    </cfif>
    <cfif ARGUMENTS.regID NEQ 0>
    AND regID = <cfqueryparam value="#ARGUMENTS.regID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.subID NEQ 0>
    AND subID = <cfqueryparam value="#ARGUMENTS.subID#" cfsqltype="cf_sql_integer">
    </cfif>
    AND regStatus IN (<cfqueryparam value="#ARGUMENTS.regStatus#" list="yes" cfsqltype="cf_sql_integer">)
    AND rerStatus IN (<cfqueryparam value="#ARGUMENTS.rerStatus#" list="yes" cfsqltype="cf_sql_integer">)
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsRegistrationEntryRel = StructNew()>
    <cfset rsRegistrationEntryRel.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsRegistrationEntryRel>
    </cffunction>
    
    <cffunction name="getRegistrationRandom" access="public" returntype="query" hint="Get Registration Random data.">
    <cfargument name="regID" type="numeric" required="yes" default="0">
    <cfargument name="limit" type="numeric" required="yes" default="1">
    <cfargument name="rsrType" type="string" required="yes" default="Winner">
    <cfargument name="regStatus" type="string" required="yes" default="1">
    <cfset var rsRegistrationRandom = "" >
    <cftry>
    <cfquery name="rsRegistrationRandom" datasource="#application.mcmsDSN#">
    SELECT * FROM
    (SELECT * FROM v_reg_subscription_rel ORDER BY dbms_random.value)
    WHERE rownum <= <cfqueryparam value="#ARGUMENTS.limit#" cfsqltype="cf_sql_integer">
    <cfif ARGUMENTS.regID NEQ 0>
    AND regID = <cfqueryparam value="#ARGUMENTS.regID#" cfsqltype="cf_sql_integer">
    </cfif>
    AND rsrType <> <cfqueryparam value="#ARGUMENTS.rsrType#" cfsqltype="cf_sql_varchar">
    AND regStatus IN (<cfqueryparam value="#ARGUMENTS.regStatus#" list="yes" cfsqltype="cf_sql_integer">)
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsRegistrationRandom = StructNew()>
    <cfset rsRegistrationRandom.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsRegistrationRandom>
    </cffunction>
    
    <cffunction name="getRegistrationReport" access="public" returntype="query" hint="Get Registration Report data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="orderBy" type="string" required="yes" default="regName">
    <cfset var rsRegistrationReport = "" >
    <cftry>
    <cfquery name="rsRegistrationReport" datasource="#application.mcmsDSN#">
    SELECT regName AS Name, TO_CHAR(regDateRel,'MM/DD/YYYY') AS Release_Date, TO_CHAR(regDateExp,'MM/DD/YYYY') AS Expiration_Date, regURL AS URL, sName AS Status FROM v_registration WHERE 0=0
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(regName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">)
    </cfif>
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsRegistrationReport = StructNew()>
    <cfset rsRegistrationReport.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsRegistrationReport>
    </cffunction>
    
    <cffunction name="getRegSubscriptionRelReport" access="public" returntype="query" hint="Get Registration Subscription Rel. Report data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="rsrType" type="string" required="yes" default="Winner">
    <cfargument name="orderBy" type="string" required="yes" default="regName">
    <cfset var rsRegSubscriptionRelReport = "" >
    <cftry>
    <cfquery name="rsRegSubscriptionRelReport" datasource="#application.mcmsDSN#">
    SELECT subfName || ' ' || sublName AS Name, regName AS Registration, subEmail AS Email, '(' || subTelArea || ')' || ' ' || subTelPrefix || '-' || subTelSuffix AS Phone_Number, subStateProv AS State, subCountry AS Country, sName as Status FROM v_reg_subscription_rel WHERE 0=0
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(regName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">)
    </cfif>
    <cfif ARGUMENTS.rsrType NEQ "">
    AND rsrType = <cfqueryparam value="#ARGUMENTS.rsrType#" cfsqltype="cf_sql_varchar">
    </cfif>
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsRegSubscriptionRelReport = StructNew()>
    <cfset rsRegSubscriptionRelReport.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsRegSubscriptionRelReport>
    </cffunction>
    
    <cffunction name="getRegistrationEntryRelReport" access="public" returntype="query" hint="Get Registration Entry Rel. Report data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="regID" type="string" required="yes" default="0">
    <cfargument name="orderBy" type="string" required="yes" default="regName, sublName">
    <cfset var rsRegistrationEntryRelReport = "" >
    <cftry>
    <cfquery name="rsRegistrationEntryRelReport" datasource="#application.mcmsDSN#">
    SELECT subfName || ' ' || sublName AS Name, regName AS Registration, subEmail AS Email, '(' || subTelArea || ')' || ' ' || subTelPrefix || '-' || subTelSuffix AS Phone_Number, subStateProv AS State, subCountry AS Country, TO_CHAR(rerEntry) AS Entry, sName as Status FROM v_registration_entry_rel WHERE 0=0
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(regName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(subfName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">)
    </cfif>
    <cfif ARGUMENTS.regID NEQ 0>
    AND regID = <cfqueryparam value="#ARGUMENTS.regID#" cfsqltype="cf_sql_integer">
    </cfif>
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsRegistrationEntryRelReport = StructNew()>
    <cfset rsRegistrationEntryRelReport.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsRegistrationEntryRelReport>
    </cffunction>
    
    <cffunction name="insertRegistration" access="public" returntype="struct">
    <cfargument name="regName" type="string" required="yes">
    <cfargument name="regDescription" type="string" required="yes">
    <cfargument name="regDateRel" type="date" required="yes">
    <cfargument name="regDateExp" type="date" required="yes">
    <cfargument name="imgID" type="numeric" required="yes">
    <cfargument name="regURL" type="string" required="yes">
    <cfargument name="rtID" type="numeric" required="yes">
    <cfargument name="regTarget" type="string" required="yes">
    <cfargument name="regStatus" type="numeric" required="yes">
    <cfargument name="socID" type="string" required="yes">
    <cfargument name="siteNo" type="string" required="yes">
    <cfset result.message = "You have successfully inserted the record.">
    <cftry>
    <!---Check for profanity in the text.--->
    <cfinvoke 
    component="MCMS.component.utility.Regex"
    method="regexProfanity"
    returnvariable="regexProfanityRet">
    <cfinvokeargument name="profanityString" value="#ARGUMENTS.regDescription#"/>
    </cfinvoke>
    <!---Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.app.registration.Registration"
    method="getRegistration"
    returnvariable="getCheckRegistrationRet">
    <cfinvokeargument name="regName" value="#ARGUMENTS.regName#"/>
    <cfinvokeargument name="regStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckRegistrationRet.recordcount NEQ 0>
    <cfset result.message = "The name #ARGUMENTS.regName# already exists, please enter a new name.">
    <cfelseif regexProfanityRet CONTAINS '$%&*!'>
    <cfset result.message = "Some text contained profanity, please remove any profanity from your text.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    INSERT INTO tbl_registration (regName,regDescription,regDetail,regDateRel,regDateExp,imgID,regURL,regTarget,rtID,regStatus) VALUES
    (
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.regName#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.regDescription#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.regDetail#">,
    <cfqueryparam cfsqltype="cf_sql_date" value="#ARGUMENTS.regDateRel#">,
    <cfqueryparam cfsqltype="cf_sql_date" value="#ARGUMENTS.regDateExp#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.imgID#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.regURL#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.regTarget#">,   
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.rtID#">, 
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.regStatus#">
    )
    </cfquery>
    </cftransaction>
    <!---Insert Social Rel.--->
    <!---Get the new regID.--->
    <cfinvoke 
    component="MCMS.component.cms.Cms"
    method="getMaxValueSQL"
    returnvariable="getMaxValueSQLRet">
    <cfinvokeargument name="tableName" value="tbl_registration"/>
    </cfinvoke>
    <cfset this.regID = getMaxValueSQLRet>
    <!---Insert social relationships.--->
    <cfloop list="#ARGUMENTS.socID#" index="i">
    <cfinvoke 
    component="MCMS.component.app.registration.Registration"
    method="insertRegistrationSocialRel"
    returnvariable="insertRegistrationSocialRelRet">
    <cfinvokeargument name="regID" value="#this.regID#"/>
    <cfinvokeargument name="socID" value="#i#"/>
    <cfinvokeargument name="rsrStatus" value="1"/>
    </cfinvoke>
    </cfloop>
    <!---Insert site relationships.--->
    <cfloop list="#ARGUMENTS.siteNo#" index="i">
    <cfinvoke 
    component="MCMS.component.app.registration.Registration"
    method="insertRegistrationSiteRel"
    returnvariable="insertRegistrationSiteRelRet">
    <cfinvokeargument name="regID" value="#this.regID#"/>
    <cfinvokeargument name="siteNo" value="#i#"/>
    <cfinvokeargument name="rsrStatus" value="1"/>
    </cfinvoke>
    </cfloop>
    </cfif>
    <cfcatch type="any">
    <cfset result.message = "There was an error inserting the record.">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="insertRegistrationSubscriptionSiteRel" access="public" returntype="struct">
    <cfargument name="regID" type="numeric" required="yes">
    <cfargument name="siteNo" type="numeric" required="yes">
    <cfargument name="subEmail" type="string" required="yes">
    <cfargument name="subFName" type="string" required="yes">
    <cfargument name="subLName" type="string" required="yes">
    <cfargument name="subStateProv" type="string" required="yes">
    <cfargument name="subZipCode" type="string" required="yes">
    <cfargument name="subTelArea" type="string" required="yes">
    <cfargument name="subTelPrefix" type="string" required="yes">
    <cfargument name="subTelSuffix" type="string" required="yes">
    <cfargument name="subCountry" type="string" required="yes">
    <cfset result.message = "You have successfully registered.">
    <cftry>
    <!---Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.app.registration.Registration"
    method="getRegSubscriptionRel"
    returnvariable="getCheckRegSubscriptionRelRet">
    <cfinvokeargument name="regID" value="#ARGUMENTS.regID#"/>
    <cfinvokeargument name="regEmail" value="#ARGUMENTS.subEmail#"/>
    <cfinvokeargument name="rsrStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckRegSubscriptionRelRet.recordcount NEQ 0>
    <cfset result.message = "This email is already registered but any new site relationship have been added, thank you.">
    <cfset this.subID = getCheckRegSubscriptionRelRet.subID>
    <cfelse>
    <!---Check to insert subscription record.--->
    <cfinvoke 
    component="MCMS.component.app.subscription.Subscription"
    method="getSubscription"
    returnvariable="getCheckSubscriptionRet">
    <cfinvokeargument name="subEmail" value="#ARGUMENTS.subEmail#"/>
    <cfinvokeargument name="subStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckSubscriptionRet.recordcount NEQ 0>
    <cfset this.subID = getCheckSubscriptionRet.ID>
    <cfelse>
    <cfinvoke 
    component="MCMS.component.app.subscription.Subscription"
    method="insertSubscription"
    returnvariable="insertSubscriptionRet">
    <cfinvokeargument name="subEmail" value="#ARGUMENTS.subEmail#"/>
    <cfinvokeargument name="subPassword" value="password"/>
    <cfinvokeargument name="subFName" value="#ARGUMENTS.subFName#"/>
    <cfinvokeargument name="subLName" value="#ARGUMENTS.subLName#"/>
    <cfinvokeargument name="subTelArea" value="#ARGUMENTS.subTelArea#"/>
    <cfinvokeargument name="subTelPrefix" value="#ARGUMENTS.subTelPrefix#"/>
    <cfinvokeargument name="subTelSuffix" value="#ARGUMENTS.subTelSuffix#"/>
    <cfinvokeargument name="subZipCode" value="#ARGUMENTS.subZipCode#"/>
    <cfinvokeargument name="subZipCodeExt" value=""/>
    <cfinvokeargument name="subStateProv" value="#ARGUMENTS.subStateProv#"/>
    <cfinvokeargument name="subCountry" value="#ARGUMENTS.subCountry#"/>
    <cfinvokeargument name="subStatus" value="1"/>
    </cfinvoke>
    <!---Get the next avaiable subID.--->
    <cfinvoke 
    component="MCMS.component.cms.Cms"
    method="getMaxValueSQL"
    returnvariable="getMaxValueSQLRet">
    <cfinvokeargument name="tableName" value="tbl_subscription"/>
    </cfinvoke>
    <cfset this.subID = getMaxValueSQLRet>
    </cfif>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    INSERT INTO tbl_reg_subscription_rel (regID,subID) VALUES
    (
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.regID#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#this.subID#">
    )
    </cfquery>
    </cftransaction>
    </cfif>
    <!---Insert Subscription (Registration component.) Site Rel.--->
    <cfinvoke 
    component="MCMS.component.app.registration.Registration"
    method="insertSubscriptionRegSiteRel"
    returnvariable="insertSubscriptionRegSiteRelRet">
    <cfinvokeargument name="subID" value="#this.subID#"/>
    <cfinvokeargument name="siteNo" value="#ARGUMENTS.siteNo#"/>
    <cfinvokeargument name="ssrStatus" value="1"/>
    </cfinvoke>
    <cfcatch type="any">
    <cfset result.message = "There was an error inserting the record.">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="insertRegistrationType" access="public" returntype="struct">
    <cfargument name="rtName" type="string" required="yes">
    <cfargument name="rtDescription" type="string" required="yes">
    <cfargument name="rtTemplate" type="string" required="yes">
    <cfargument name="rtStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully inserted the record.">
    <cftry>
    <cfinvoke 
    component="MCMS.component.app.registration.Registration"
    method="getRegistrationType"
    returnvariable="getCheckRegistrationTypeRet">
    <cfinvokeargument name="rtName" value="#ARGUMENTS.rtName#"/>
    <cfinvokeargument name="rtTemplate" value="#ARGUMENTS.rtTemplate#"/>
    <cfinvokeargument name="rtStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckRegistrationTypeRet.recordcount EQ 0>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    INSERT INTO tbl_registration_type (rtName,rtDescription,rtTemplate,rtStatus) VALUES
    (
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.rtName#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.rtDescription#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.rtTemplate#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.rtStatus#">
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
    
    <cffunction name="insertSubscriptionRegSiteRel" access="public" returntype="struct">
    <cfargument name="subID" type="numeric" required="yes">
    <cfargument name="siteNo" type="numeric" required="yes">
    <cfargument name="ssrStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully inserted the record.">
    <cftry>
    <cfinvoke 
    component="MCMS.component.app.subscription.Subscription"
    method="getSubscriptionSiteRel"
    returnvariable="getCheckSubSiteRelRet">
    <cfinvokeargument name="subID" value="#ARGUMENTS.subID#"/>
    <cfinvokeargument name="siteNo" value="#ARGUMENTS.siteNo#"/>
    <cfinvokeargument name="ssrStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckSubSiteRelRet.recordcount EQ 0>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    INSERT INTO tbl_subscription_site_rel (subID,siteNo,ssrStatus) VALUES
    (
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.subID#">,
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
    
    <cffunction name="insertRegistrationSocialRel" access="public" returntype="struct">
    <cfargument name="regID" type="numeric" required="yes">
    <cfargument name="socID" type="numeric" required="yes">
    <cfargument name="rsrStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully inserted the record.">
    <cftry>
    <cfinvoke 
    component="MCMS.component.app.registration.Registration"
    method="getRegistrationSocialRel"
    returnvariable="getCheckRegistrationSocialRelRet">
    <cfinvokeargument name="regID" value="#ARGUMENTS.regID#"/>
    <cfinvokeargument name="socID" value="#ARGUMENTS.socID#"/>
    <cfinvokeargument name="rsrStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckRegistrationSocialRelRet.recordcount EQ 0>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    INSERT INTO tbl_reg_social_rel (regID,socID,rsrStatus) VALUES
    (
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.regID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.socID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.rsrStatus#">
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
    
    <cffunction name="insertRegistrationSiteRel" access="public" returntype="struct">
    <cfargument name="regID" type="numeric" required="yes">
    <cfargument name="siteNo" type="numeric" required="yes">
    <cfargument name="rsrStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully inserted the record.">
    <cftry>
    <cfinvoke 
    component="MCMS.component.app.registration.Registration"
    method="getRegistrationSiteRel"
    returnvariable="getCheckRegistrationSiteRelRet">
    <cfinvokeargument name="regID" value="#ARGUMENTS.regID#"/>
    <cfinvokeargument name="siteNo" value="#ARGUMENTS.siteNo#"/>
    <cfinvokeargument name="rsrStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckRegistrationSiteRelRet.recordcount EQ 0>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    INSERT INTO tbl_reg_site_rel (regID,siteNo,rsrStatus) VALUES
    (
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.regID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.siteNo#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.rsrStatus#">
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
    
    <cffunction name="updateRegistration" access="public" returntype="struct">
    <cfargument name="ID" type="numeric" required="yes">
    <cfargument name="regName" type="string" required="yes">
    <cfargument name="regDescription" type="string" required="yes">
    <cfargument name="regDateRel" type="date" required="yes">
    <cfargument name="regDateExp" type="date" required="yes">
    <cfargument name="imgID" type="numeric" required="yes">
    <cfargument name="regURL" type="string" required="yes">
    <cfargument name="regTarget" type="string" required="yes">
    <cfargument name="rtID" type="numeric" required="yes">
    <cfargument name="regStatus" type="numeric" required="yes">
    
    <cfargument name="socID" type="string" required="yes">
    <cfargument name="siteNo" type="string" required="yes">
    <cfset result.message = "You have successfully updated the record.">
    <cftry>
    <!---Check for profanity in the text.--->
    <cfinvoke 
    component="MCMS.component.utility.Regex"
    method="regexProfanity"
    returnvariable="regexProfanityRet">
    <cfinvokeargument name="profanityString" value="#ARGUMENTS.regDescription#"/>
    </cfinvoke>
    <!---Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.app.registration.Registration"
    method="getRegistration"
    returnvariable="getCheckRegistrationRet">
    <cfinvokeargument name="excludeID" value="#ARGUMENTS.ID#"/>
    <cfinvokeargument name="regName" value="#ARGUMENTS.regName#"/>
    <cfinvokeargument name="regStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckRegistrationRet.recordcount NEQ 0>
    <cfset result.message = "The name #ARGUMENTS.regName# already exists, please enter a new name.">
    <cfelseif regexProfanityRet CONTAINS '$%&*!'>
    <cfset result.message = "Some text contained profanity, please remove any profanity from your text.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_registration SET
    regName = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.regName#">,
    regDescription = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.regDescription#">,
    regDetail = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.regDetail#">,
    regDateRel = <cfqueryparam cfsqltype="cf_sql_date" value="#ARGUMENTS.regDateRel#">,
    regDateExp = <cfqueryparam cfsqltype="cf_sql_date" value="#ARGUMENTS.regDateExp#">,
    imgID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.imgID#">,
    regURL = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.regURL#">,
    regTarget = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.regTarget#">,
    rtID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.rtID#">,
    regStatus = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.regStatus#">
    WHERE ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ID#">
    </cfquery>
    </cftransaction>
    <!---Delete social relationships.--->
    <cfinvoke 
    component="MCMS.component.app.registration.Registration"
    method="deleteRegistrationSocialRel"
    returnvariable="deleteRegistrationSocialRelRet">
    <cfinvokeargument name="regID" value="#ARGUMENTS.ID#"/>
    </cfinvoke>
    <!---Delete site relationships.--->
    <cfinvoke 
    component="MCMS.component.app.registration.Registration"
    method="deleteRegistrationSiteRel"
    returnvariable="deleteRegistrationSiteRelRet">
    <cfinvokeargument name="regID" value="#ARGUMENTS.ID#"/>
    </cfinvoke>
    <!---Insert social relationships.--->
    <cfloop list="#ARGUMENTS.socID#" index="i">
    <cfinvoke 
    component="MCMS.component.app.registration.Registration"
    method="insertRegistrationSocialRel"
    returnvariable="insertRegistrationSocialRelRet">
    <cfinvokeargument name="regID" value="#ARGUMENTS.ID#"/>
    <cfinvokeargument name="socID" value="#i#"/>
    <cfinvokeargument name="rsrStatus" value="1"/>
    </cfinvoke>
    </cfloop>
    <!---Insert site relationships.--->
    <cfloop list="#ARGUMENTS.siteNo#" index="i">
    <cfinvoke 
    component="MCMS.component.app.registration.Registration"
    method="insertRegistrationSiteRel"
    returnvariable="insertRegistrationSiteRelRet">
    <cfinvokeargument name="regID" value="#ARGUMENTS.ID#"/>
    <cfinvokeargument name="siteNo" value="#i#"/>
    <cfinvokeargument name="rsrStatus" value="1"/>
    </cfinvoke>
    </cfloop>
    </cfif>
    <cfcatch type="any">
    <cfset result.message = "There was an error updating the record.">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="updateRegSubscriptionRel" access="public" returntype="struct">
    <cfargument name="ID" type="numeric" required="yes">
    <cfargument name="rsrSort" type="numeric" required="yes">
    <cfargument name="rsrType" type="string" required="yes">
    <cfset result.message = "You have successfully updated the record.">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_reg_subscription_rel SET
    rsrSort = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.rsrSort#">,
    rsrType = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.rsrType#">
    WHERE ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ID#">
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error updating the record.">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="updateRegistrationList" access="public" returntype="struct">
    <cfargument name="ID" type="numeric" required="yes">
    <cfargument name="regStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully updated the records.">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_registration SET
    regStatus = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.regStatus#">
    WHERE ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ID#">
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error updating records.">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="updateRegSubscriptionRelWinner" access="public" returntype="struct">
    <cfargument name="ID" type="string" required="yes">
    <cfargument name="rsrType" type="string" required="yes">
    <cfset result.message = "You have successfully made winners.">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_reg_subscription_rel SET
    rsrType = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.rsrType#">
    WHERE ID IN (<cfqueryparam cfsqltype="cf_sql_integer" list="yes" value="#ARGUMENTS.ID#">)
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error making winners.">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction> 
    
    <cffunction name="updateRegSubscriptionRelWinnerList" access="public" returntype="struct">
    <cfargument name="ID" type="numeric" required="yes">
    <cfargument name="rsrStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully updated the records.">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_reg_subscription_rel SET
    rsrStatus = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.rsrStatus#">
    WHERE ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ID#">
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error updating the records.">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="deleteRegSubscriptionRelWinner" access="public" returntype="struct">
    <cfargument name="ID" type="string" required="yes" default="0">
    <cfset result.message = "You have successfully deleted the record(s).">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    DELETE FROM tbl_reg_subscription_rel
    WHERE ID IN (<cfqueryparam cfsqltype="cf_sql_integer" list="yes" value="#ARGUMENTS.ID#">)
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error deleting the record(s).">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="deleteRegistrationSocialRel" access="public" returntype="struct">
    <cfargument name="ID" type="string" required="yes" default="0">
    <cfargument name="regID" type="string" required="yes" default="0">
    <cfset result.message = "You have successfully deleted the record(s).">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    DELETE FROM tbl_reg_social_rel
    WHERE ID IN (<cfqueryparam cfsqltype="cf_sql_integer" list="yes" value="#ARGUMENTS.ID#">)
    OR regID IN (<cfqueryparam cfsqltype="cf_sql_integer" list="yes" value="#ARGUMENTS.regID#">)
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error deleting the record(s).">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction> 
    
    <cffunction name="deleteRegistrationSiteRel" access="public" returntype="struct">
    <cfargument name="ID" type="string" required="yes" default="0">
    <cfargument name="regID" type="string" required="yes" default="0">
    <cfset result.message = "You have successfully deleted the record(s).">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    DELETE FROM tbl_reg_site_rel
    WHERE ID IN (<cfqueryparam cfsqltype="cf_sql_integer" list="yes" value="#ARGUMENTS.ID#">)
    OR regID IN (<cfqueryparam cfsqltype="cf_sql_integer" list="yes" value="#ARGUMENTS.regID#">)
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error deleting the record(s).">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>       
</cfcomponent>