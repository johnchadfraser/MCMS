<cfcomponent>
    <cffunction name="getFlyer" access="public" returntype="query" hint="Get Flyer data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="ID" type="numeric" required="yes" default="0">
    <cfargument name="excludeID" type="numeric" required="yes" default="0">
    <cfargument name="fName" type="string" required="yes" default="">
    <cfargument name="fDateRel" type="string" required="yes" default="">
    <cfargument name="fDateExp" type="string" required="yes" default="">
    <cfargument name="ftID" type="string" required="yes" default="0">
    <cfargument name="fStatus" type="string" required="yes" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="fName">
    <cfset var rsFlyer = "" >
    <cftry>
    <cfquery name="rsFlyer" datasource="#application.mcmsDSN#">
    SELECT * FROM v_flyer WHERE 0=0
    <cfif ARGUMENTS.ID NEQ 0>
    AND ID = <cfqueryparam value="#ARGUMENTS.ID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.excludeID NEQ 0>
    AND ID <> <cfqueryparam value="#ARGUMENTS.excludeID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(fName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(fDescription) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">)
    </cfif>
    <cfif ARGUMENTS.fName NEQ "">
    AND UPPER(fName) = <cfqueryparam value="#UCASE(ARGUMENTS.fName)#" cfsqltype="cf_sql_varchar">
    </cfif>
    <cfif ARGUMENTS.fDateRel NEQ "">
    AND fDateRel <= <cfqueryparam value="#ARGUMENTS.fDateRel#" cfsqltype="cf_sql_date">
    </cfif>
    <cfif ARGUMENTS.fDateExp NEQ "">
    AND fDateExp >= <cfqueryparam value="#ARGUMENTS.fDateExp#" cfsqltype="cf_sql_date">
    </cfif>
    <cfif ARGUMENTS.ftID NEQ 0>
    AND ftID = <cfqueryparam value="#ARGUMENTS.ftID#" cfsqltype="cf_sql_integer">
    </cfif>
    AND fStatus IN (<cfqueryparam value="#ARGUMENTS.fStatus#" list="yes" cfsqltype="cf_sql_integer">)
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsFlyer = StructNew()>
    <cfset rsFlyer.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsFlyer>
    </cffunction>
    
    <cffunction name="getFlyerSiteRel" access="public" returntype="query" hint="Get Flyer Site Relationship data.">
    <cfargument name="keywords" type="string" required="no" default="All">
    <cfargument name="ID" type="numeric" required="yes" default="0">
    <cfargument name="fID" type="numeric" required="yes" default="0">
    <cfargument name="siteNo" type="string" required="yes" default="100">
    <cfargument name="fsrStatus" type="string" required="yes" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="siteNo">
	<cfset var rsFlyerSiteRel = "" >
    <cftry>
    <cfquery name="rsFlyerSiteRel" datasource="#application.mcmsDSN#">
    SELECT * FROM v_flyer_site_rel WHERE 0=0
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND siteNo LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> 
    </cfif>
    <cfif ARGUMENTS.ID NEQ 0>
    AND ID = <cfqueryparam value="#ARGUMENTS.ID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.fID NEQ 0>
    AND fID = <cfqueryparam value="#ARGUMENTS.fID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.siteNo NEQ 100>
    AND siteNo IN (<cfqueryparam value="#ARGUMENTS.siteNo#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    AND fsrStatus IN (<cfqueryparam value="#ARGUMENTS.fsrStatus#" list="yes" cfsqltype="cf_sql_integer">)
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsFlyerSiteRel = StructNew()>
    <cfset rsFlyerSiteRel.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsFlyerSiteRel>
    </cffunction>
    
    <cffunction name="getFlyerPage" access="public" returntype="query" hint="Get Flyer Page data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="ID" type="numeric" required="yes" default="0">
    <cfargument name="excludeID" type="numeric" required="yes" default="0">
    <cfargument name="fpName" type="string" required="yes" default="">
    <cfargument name="fID" type="string" required="yes" default="0">
    <cfargument name="ftempID" type="string" required="yes" default="0">
    <cfargument name="fpSort" type="string" required="yes" default="0">
    <cfargument name="fpStatus" type="string" required="yes" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="fpName">
    <cfset var rsFlyerPage = "" >
    <cftry>
    <cfquery name="rsFlyerPage" datasource="#application.mcmsDSN#">
    SELECT * FROM v_flyer_page WHERE 0=0
    <cfif ARGUMENTS.ID NEQ 0>
    AND ID = <cfqueryparam value="#ARGUMENTS.ID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.excludeID NEQ 0>
    AND ID <> <cfqueryparam value="#ARGUMENTS.excludeID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(fpName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">)
    </cfif>
    <cfif ARGUMENTS.fpName NEQ "">
    AND UPPER(fpName) = <cfqueryparam value="#UCASE(ARGUMENTS.fpName)#" cfsqltype="cf_sql_varchar">
    </cfif>
    <cfif ARGUMENTS.fID NEQ 0>
    AND fID = <cfqueryparam value="#ARGUMENTS.fID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.ftempID NEQ 0>
    AND ftempID = <cfqueryparam value="#ARGUMENTS.ftempID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.fpSort NEQ 0>
    AND fpSort = <cfqueryparam value="#ARGUMENTS.fpSort#" cfsqltype="cf_sql_integer">
    </cfif>
    AND fpStatus IN (<cfqueryparam value="#ARGUMENTS.fpStatus#" list="yes" cfsqltype="cf_sql_integer">)
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsFlyerPage = StructNew()>
    <cfset rsFlyerPage.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsFlyerPage>
    </cffunction>
    
    <cffunction name="getFlyerTemplate" access="public" returntype="query" hint="Get Flyer Template data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="ID" type="numeric" required="yes" default="0">
    <cfargument name="excludeID" type="numeric" required="yes" default="0">
    <cfargument name="ftempName" type="string" required="yes" default="">
    <cfargument name="ftempStatus" type="string" required="yes" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="ftempName">
    <cfset var rsFlyerTemplate = "" >
    <cftry>
    <cfquery name="rsFlyerTemplate" datasource="#application.mcmsDSN#">
    SELECT * FROM v_flyer_template WHERE 0=0
    <cfif ARGUMENTS.ID NEQ 0>
    AND ID = <cfqueryparam value="#ARGUMENTS.ID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.excludeID NEQ 0>
    AND ID <> <cfqueryparam value="#ARGUMENTS.excludeID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(ftempName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">)
    </cfif>
    <cfif ARGUMENTS.ftempName NEQ "">
    AND UPPER(ftempName) = <cfqueryparam value="#UCASE(ARGUMENTS.ftempName)#" cfsqltype="cf_sql_varchar">
    </cfif>
    AND ftempStatus IN (<cfqueryparam value="#ARGUMENTS.ftempStatus#" list="yes" cfsqltype="cf_sql_integer">)
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsFlyerTemplate = StructNew()>
    <cfset rsFlyerTemplate.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsFlyerTemplate>
    </cffunction>
    
    <cffunction name="getFlyerTemplateZoneRel" access="public" returntype="query" hint="Get Flyer Template Zone Rel. data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="ID" type="numeric" required="yes" default="0">
    <cfargument name="excludeID" type="numeric" required="yes" default="0">
    <cfargument name="ftempID" type="numeric" required="yes" default="0">
    <cfargument name="fzID" type="numeric" required="yes" default="0">
    <cfargument name="ftempName" type="string" required="yes" default="">
    <cfargument name="fzName" type="string" required="yes" default="">
    <cfargument name="ftempzrStatus" type="string" required="yes" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="fzSort, ftempName">
    <cfset var rsFlyerTemplateZoneRel = "" >
    <cftry>
    <cfquery name="rsFlyerTemplateZoneRel" datasource="#application.mcmsDSN#">
    SELECT * FROM v_flyer_template_zone_rel WHERE 0=0
    <cfif ARGUMENTS.ID NEQ 0>
    AND ID = <cfqueryparam value="#ARGUMENTS.ID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.excludeID NEQ 0>
    AND ID <> <cfqueryparam value="#ARGUMENTS.excludeID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.ftempID NEQ 0>
    AND ftempID = <cfqueryparam value="#ARGUMENTS.ftempID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.fzID NEQ 0>
    AND fzID = <cfqueryparam value="#ARGUMENTS.fzID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(ftempName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(fzName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">)
    </cfif>
    <cfif ARGUMENTS.ftempName NEQ "">
    AND UPPER(ftempName) = <cfqueryparam value="#UCASE(ARGUMENTS.ftempName)#" cfsqltype="cf_sql_varchar">
    </cfif>
    <cfif ARGUMENTS.fzName NEQ "">
    AND UPPER(fzName) = <cfqueryparam value="#UCASE(ARGUMENTS.fzName)#" cfsqltype="cf_sql_varchar">
    </cfif>
    AND ftempzrStatus IN (<cfqueryparam value="#ARGUMENTS.ftempzrStatus#" list="yes" cfsqltype="cf_sql_integer">)
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsFlyerTemplateZoneRel = StructNew()>
    <cfset rsFlyerTemplateZoneRel.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsFlyerTemplateZoneRel>
    </cffunction>
    
    <cffunction name="getFlyerType" access="public" returntype="query" hint="Get Flyer Type data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="ID" type="numeric" required="yes" default="0">
    <cfargument name="excludeID" type="numeric" required="yes" default="0">
    <cfargument name="ftName" type="string" required="yes" default="">
    <cfargument name="ftStatus" type="string" required="yes" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="ftName">
    <cfset var rsFlyerType = "" >
    <cftry>
    <cfquery name="rsFlyerType" datasource="#application.mcmsDSN#">
    SELECT * FROM tbl_flyer_type WHERE 0=0
    <cfif ARGUMENTS.ID NEQ 0>
    AND ID = <cfqueryparam value="#ARGUMENTS.ID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.excludeID NEQ 0>
    AND ID <> <cfqueryparam value="#ARGUMENTS.excludeID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND UPPER(ftName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">
    </cfif>
    <cfif ARGUMENTS.ftname NEQ 'All'>
    AND (UPPER(ftName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.ftName)#%" cfsqltype="cf_sql_varchar">)
    </cfif>
    AND ftStatus IN (<cfqueryparam value="#ARGUMENTS.ftStatus#" list="yes" cfsqltype="cf_sql_integer">)
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsFlyerType = StructNew()>
    <cfset rsFlyerType.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsFlyerType>
    </cffunction>
    
    <cffunction name="getFlyerZone" access="public" returntype="query" hint="Get Flyer Zone data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="ID" type="numeric" required="yes" default="0">
    <cfargument name="excludeID" type="string" required="yes" default="0">
    <cfargument name="fzName" type="string" required="yes" default="">
    <cfargument name="fzCode" type="string" required="yes" default="">
    <cfargument name="fzStatus" type="numeric" required="yes" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="fzName">
    <cfset var rsFlyerZone = "" >
    <cftry>
    <cfquery name="rsFlyerZone" datasource="#application.mcmsDSN#">
    SELECT * FROM v_flyer_zone WHERE 0=0
    <cfif ARGUMENTS.ID NEQ 0>
    AND ID = <cfqueryparam value="#ARGUMENTS.ID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.excludeID NEQ 0>
    AND ID NOT IN (<cfqueryparam value="#ARGUMENTS.excludeID#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(fzName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(fzDescription) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">)
    </cfif>
    <cfif ARGUMENTS.fzName NEQ "">
    AND UPPER(fzName) = <cfqueryparam value="#UCASE(ARGUMENTS.fzName)#" cfsqltype="cf_sql_varchar">
    </cfif>
    <cfif ARGUMENTS.fzCode NEQ "">
    AND fzCode = <cfqueryparam value="#ARGUMENTS.fzCode#" cfsqltype="cf_sql_varchar">
    </cfif>
    AND fzStatus IN (<cfqueryparam value="#ARGUMENTS.fzStatus#" list="yes" cfsqltype="cf_sql_integer">)
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsFlyerZone = StructNew()>
    <cfset rsFlyerZone.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsFlyerZone>
    </cffunction>
    
    <cffunction name="getFlyerPageProductZoneRel" access="public" returntype="query" hint="Get Flyer Page Product Zone relationship data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="ID" type="numeric" required="yes" default="0">
    <cfargument name="excludeID" type="numeric" required="yes" default="0">
    <cfargument name="fID" type="numeric" required="yes" default="0">
    <cfargument name="fzID" type="numeric" required="yes" default="0">
    <cfargument name="fpID" type="numeric" required="yes" default="0">
    <cfargument name="pID" type="numeric" required="yes" default="0">
    <cfargument name="fzStatus" type="string" required="yes" default="1,3">
    <cfargument name="fpSort" type="numeric" required="yes" default="0">
    <cfargument name="fpStatus" type="string" required="yes" default="1,3">
    <cfargument name="fppzrStatus" type="string" required="yes" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="fzSort ASC">
    <cfset var rsFlyerPageProductZoneRel = "" >
    <cftry>
    <cfquery name="rsFlyerPageProductZoneRel" datasource="#application.mcmsDSN#">
    SELECT * FROM v_flyer_pg_prod_zone_rel WHERE 0=0
    <cfif ARGUMENTS.ID NEQ 0>
    AND ID = <cfqueryparam value="#ARGUMENTS.ID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.excludeID NEQ 0>
    AND ID <> <cfqueryparam value="#ARGUMENTS.excludeID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(fzName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">)
    </cfif>
    <cfif ARGUMENTS.fID NEQ 0>
    AND fID = <cfqueryparam value="#ARGUMENTS.fID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.fzID NEQ 0>
    AND fzID = <cfqueryparam value="#ARGUMENTS.fzID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.fpID NEQ 0>
    AND fpID = <cfqueryparam value="#ARGUMENTS.fpID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.pID NEQ 0>
    AND pID = <cfqueryparam value="#ARGUMENTS.pID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.fpSort NEQ 0>
    AND fpSort = <cfqueryparam value="#ARGUMENTS.fpSort#" cfsqltype="cf_sql_integer">
    </cfif>
    AND fzStatus IN (<cfqueryparam value="#ARGUMENTS.fzStatus#" list="yes" cfsqltype="cf_sql_integer">)
    AND fpStatus IN (<cfqueryparam value="#ARGUMENTS.fpStatus#" list="yes" cfsqltype="cf_sql_integer">)
    AND fppzrStatus IN (<cfqueryparam value="#ARGUMENTS.fppzrStatus#" list="yes" cfsqltype="cf_sql_integer">)
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsFlyerPageProductZoneRel = StructNew()>
    <cfset rsFlyerPageProductZoneRel.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsFlyerPageProductZoneRel>
    </cffunction>
    
    <cffunction name="getFlyerZoneType" access="public" returntype="query" hint="Get Flyer Zone Type data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="ID" type="numeric" required="yes" default="0">
    <cfargument name="excludeID" type="numeric" required="yes" default="0">
    <cfargument name="fztName" type="string" required="yes" default="">
    <cfargument name="fztStatus" type="numeric" required="yes" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="fztName">
    <cfset var rsFlyerZoneType = "" >
    <cftry>
    <cfquery name="rsFlyerZoneType" datasource="#application.mcmsDSN#">
    SELECT * FROM v_flyer_zone_type WHERE 0=0
    <cfif ARGUMENTS.ID NEQ 0>
    AND ID = <cfqueryparam value="#ARGUMENTS.ID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.excludeID NEQ 0>
    AND ID <> <cfqueryparam value="#ARGUMENTS.excludeID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(fztName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">
    </cfif>
    <cfif ARGUMENTS.fztName NEQ "">
    AND UPPER(fztName) = <cfqueryparam value="#UCASE(ARGUMENTS.fztName)#" cfsqltype="cf_sql_varchar">
    </cfif>
    AND fztStatus IN (<cfqueryparam value="#ARGUMENTS.fztStatus#" list="yes" cfsqltype="cf_sql_integer">)
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsFlyerZoneType = StructNew()>
    <cfset rsFlyerZoneType.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsFlyerZoneType>
    </cffunction>
    
    <cffunction name="getFlyerReport" access="public" returntype="query" hint="Get Flyer Report data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="orderBy" type="string" required="yes" default="fName">
    <cfset var rsFlyerReport = "" >
    <cftry>
    <cfquery name="rsFlyerReport" datasource="#application.mcmsDSN#">
    SELECT fName AS Name, fDescription AS Description, ainName AS Ad_Item, TO_CHAR(fDateRel, 'MM/DD/YYYY') AS Release_Date, TO_CHAR(fDateExp, 'MM/DD/YYYY') AS Exp_Date, ftName As Type, sortName AS Sort, sName AS Status FROM v_flyer WHERE 0=0
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(fName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(fDescription) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">)
    </cfif>
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsFlyerReport = StructNew()>
    <cfset rsFlyerReport.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsFlyerReport>
    </cffunction>
    
    <cffunction name="getFlyerPageReport" access="public" returntype="query" hint="Get Flyer Page Report data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="orderBy" type="string" required="yes" default="fName">
    <cfset var rsFlyerPageReport = "" >
    <cftry>
    <cfquery name="rsFlyerPageReport" datasource="#application.mcmsDSN#">
    SELECT fpName AS Flyer_Page, fName AS Flyer, ftempName As Template, sortName AS Sort, sName AS Status FROM v_flyer_page WHERE 0=0
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(fpName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> 
    </cfif>
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsFlyerPageReport = StructNew()>
    <cfset rsFlyerPageReport.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsFlyerPageReport>
    </cffunction>
    
    <cffunction name="getFlyerTypeReport" access="public" returntype="query" hint="Get Flyer Type Report data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="orderBy" type="string" required="yes" default="ftName">
    <cfset var rsFlyerTypeReport = "" >
    <cftry>
    <cfquery name="rsFlyerTypeReport" datasource="#application.mcmsDSN#">
    SELECT ftName AS Flyer_Type, ftDescription AS Description, sortName AS Sort, sName AS Status FROM v_flyer_type WHERE 0=0
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND UPPER(ftName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">
    </cfif>
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsFlyerTypeReport = StructNew()>
    <cfset rsFlyerTypeReport.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsFlyerTypeReport>
    </cffunction>
    
    <cffunction name="getFlyerTemplateReport" access="public" returntype="query" hint="Get Flyer Template Report data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="orderBy" type="string" required="yes" default="ftempName">
    <cfset var rsFlyerTemplateReport = "" >
    <cftry>
    <cfquery name="rsFlyerTemplateReport" datasource="#application.mcmsDSN#">
    SELECT ftempName AS Flyer_Template, ftempDescription AS Description, fimgID AS Flyer_Image_ID, imgName AS Image_Name, imgFile AS Image_File, ftempFile AS Template_File, sortName AS Sort, sName as Status FROM v_flyer_template WHERE 0=0
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND UPPER(ftempName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">
    </cfif>
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsFlyerTemplateReport = StructNew()>
    <cfset rsFlyerTemplateReport.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsFlyerTemplateReport>
    </cffunction>
    
    <cffunction name="getFlyerZoneReport" access="public" returntype="query" hint="Get Flyer Zone Report data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="orderBy" type="string" required="yes" default="fzName">
    <cfset var rsFlyerZoneReport = "" >
    <cftry>
    <cfquery name="rsFlyerZoneReport" datasource="#application.mcmsDSN#">
    SELECT fzName AS Flyer_Zone, fzDescription AS Description, fzCode AS Code, sortName AS Sort, sName AS Status FROM v_flyer_zone WHERE 0=0
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND UPPER(fzName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">
    </cfif>
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsFlyerZoneReport = StructNew()>
    <cfset rsFlyerZoneReport.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsFlyerZoneReport>
    </cffunction>
    
    <cffunction name="getFlyerZoneTypeReport" access="public" returntype="query" hint="Get Flyer Zone Type Report data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="orderBy" type="string" required="yes" default="fztName">
    <cfset var rsFlyerZoneTypeReport = "" >
    <cftry>
    <cfquery name="rsFlyerZoneTypeReport" datasource="#application.mcmsDSN#">
    SELECT fztName as Flyer_Zone_Type, sortName AS Sort, sName AS Status FROM v_flyer_zone_type WHERE 0=0
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND UPPER(fztName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">
    </cfif>
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsFlyerZoneTypeReport = StructNew()>
    <cfset rsFlyerZoneTypeReport.message = "There was an error with the query.">
    <cfif url.mcmsDebug EQ true>
    <cfdump var="#CFCATCH#">`
    </cfif>
    </cfcatch>
    </cftry>
    <cfreturn rsFlyerZoneTypeReport>
    </cffunction>
    
    <cffunction name="insertFlyer" access="public" returntype="struct">
    <cfargument name="fName" type="string" required="yes">
    <cfargument name="fDescription" type="string" required="yes">
    <cfargument name="fDateRel" type="date" required="yes">
    <cfargument name="fDateExp" type="date" required="yes">
    <cfargument name="ainID" type="numeric" required="yes">
    <cfargument name="ftID" type="numeric" required="yes">
    <cfargument name="bID" type="numeric" required="yes">
    <cfargument name="fSort" type="numeric" required="yes">
    <cfargument name="fStatus" type="numeric" required="yes">
    <!---Relationship arguments.--->
    <cfargument name="siteNo" type="string" required="yes">
    <cfset result.message = "You have successfully inserted the record. Create pages for this flyer to continue.">
    <cftry>
    <!---Check for profanity in the text.--->
    <cfinvoke 
    component="MCMS.component.utility.Regex"
    method="regexProfanity"
    returnvariable="regexProfanityRet">
    <cfinvokeargument name="profanityString" value="#ARGUMENTS.fDescription#"/>
    </cfinvoke>
    <!---Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.app.flyer.Flyer"
    method="getFlyer"
    returnvariable="getCheckFlyerRet">
    <cfinvokeargument name="fName" value="#ARGUMENTS.fName#"/>
    <cfinvokeargument name="fStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckFlyerRet.recordcount NEQ 0>
    <cfset result.message = "The name #ARGUMENTS.fName# already exists, please enter a new name.">
    <cfelseif regexProfanityRet CONTAINS '$%&*!'>
    <cfset result.message = "Some text contained profanity, please remove any profanity from your text.">
    <!---Check length restriction.--->
    <cfelseif LEN(ARGUMENTS.fDescription) GT 1024>
    <cfset result.message = "The description is longer than 1024 characters, please enter a new description under 1024 characters.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    INSERT INTO tbl_flyer (fName,fDescription,fDateRel,fDateExp,ainID,ftID,bID,fSort,fStatus) VALUES
    (
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.fName#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.fDescription#">,
    <cfqueryparam cfsqltype="cf_sql_date" value="#ARGUMENTS.fDateRel#">,
    <cfqueryparam cfsqltype="cf_sql_date" value="#ARGUMENTS.fDateExp#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ainID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ftID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.bID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.fSort#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.fStatus#">
    )
    </cfquery>
    </cftransaction>
    <!---Get the fID just added.--->
    <cfinvoke 
    component="MCMS.component.cms.Cms"
    method="getMaxValueSQL"
    returnvariable="fID">
    <cfinvokeargument name="tableName" value="tbl_flyer"/>
    </cfinvoke>
    <cfset this.fID = fID>
    <!---Create site relationships.--->
    <cfloop index="siteNo" list="#ARGUMENTS.siteNo#">
    <cfinvoke 
    component="MCMS.component.app.flyer.Flyer"
    method="insertFlyerSiteRel"
    returnvariable="insertFlyerSiteRelRet">
    <cfinvokeargument name="fID" value="#this.fID#"/>
    <cfinvokeargument name="siteNo" value="#siteNo#"/>
    <cfinvokeargument name="fsrStatus" value="1"/>
    </cfinvoke>
    </cfloop>
    </cfif>
    <cfcatch type="any">
    <cfset result.message = "There was an error inserting the record.">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="insertFlyerSiteRel" access="public" returntype="struct">
    <cfargument name="fID" type="numeric" required="yes">  
    <cfargument name="siteNo" type="numeric" required="yes">  
    <cfargument name="fsrStatus" type="numeric" required="yes"> 
    <cfset result.message = "You have successfully inserted the record.">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    INSERT INTO tbl_flyer_site_rel (fID,siteNo,fsrStatus) VALUES
    (
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.fID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.siteNo#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.fsrStatus#">
    )
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error inserting the record.">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="insertFlyerPage" access="public" returntype="struct">
    <cfargument name="fpName" type="string" required="yes"> 
    <cfargument name="fID" type="numeric" required="yes">  
    <cfargument name="ftempID" type="numeric" required="yes">  
    <cfargument name="fpSort" type="numeric" required="yes">  
    <cfargument name="fpStatus" type="numeric" required="yes"> 
    <cfset result.message = "You have successfully inserted the record. Once you have created all the pages you require, proceed to the Flyer Builder.">
    <cftry>
    <!---Check for profanity in the text.--->
    <cfinvoke 
    component="MCMS.component.utility.Regex"
    method="regexProfanity"
    returnvariable="regexProfanityRet">
    <cfinvokeargument name="profanityString" value="#ARGUMENTS.fpName#"/>
    </cfinvoke>
    <!---Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.app.flyer.Flyer"
    method="getFlyerPage"
    returnvariable="getCheckFlyerPageRet">
    <cfinvokeargument name="fID" value="#ARGUMENTS.fID#"/>
    <cfinvokeargument name="fpSort" value="#ARGUMENTS.fpSort#"/>
    <cfinvokeargument name="fpStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckFlyerPageRet.recordcount NEQ 0>
    <cfset result.message = "The Sort/Page No. #ARGUMENTS.fpSort# already exists, please choose an alternate sort/page no.">
    <cfelseif regexProfanityRet CONTAINS '$%&*!'>
    <cfset result.message = "Some text contained profanity, please remove any profanity from your text.">
    <!---Check length restriction.--->
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    INSERT INTO tbl_flyer_page (fpName,fID,ftempID,fpSort,fpStatus) VALUES
    (
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.fpName#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.fID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ftempID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.fpSort#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.fpStatus#">
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
    
    <cffunction name="insertFlyerType" access="public" returntype="struct">
    <cfargument name="ftName" type="string" required="yes">
    <cfargument name="ftDescription" type="string" required="yes">
    <cfargument name="ftSort" type="numeric" required="yes">
    <cfargument name="ftStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully inserted the record.">
    <cftry>
    <!---Check for profanity in the text.--->
    <cfinvoke 
    component="MCMS.component.utility.Regex"
    method="regexProfanity"
    returnvariable="regexProfanityRet">
    <cfinvokeargument name="profanityString" value="#ARGUMENTS.ftDescription#"/>
    </cfinvoke>
    <!---Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.app.flyer.Flyer"
    method="getFlyerType"
    returnvariable="getCheckFlyerTypeRet">
    <cfinvokeargument name="ftName" value="#ARGUMENTS.ftName#"/>
    <cfinvokeargument name="ftStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckFlyerTypeRet.recordcount NEQ 0>
    <cfset result.message = "The name #ARGUMENTS.ftName# already exists, please enter a new name.">
    <cfelseif regexProfanityRet CONTAINS '$%&*!'>
    <cfset result.message = "Some text contained profanity, please remove any profanity from your text.">
    <!---Check length restriction.--->
    <cfelseif LEN(ARGUMENTS.ftDescription) GT 1024>
    <cfset result.message = "The description is longer than 1024 characters, please enter a new description under 1024 characters.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    INSERT INTO tbl_flyer_type (ftName,ftDescription,ftSort,ftStatus) VALUES
    (
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.ftName#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.ftDescription#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ftSort#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ftStatus#">
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
    
    <cffunction name="insertFlyerTemplate" access="public" returntype="struct">
    <cfargument name="ftempName" type="string" required="yes">
    <cfargument name="ftempDescription" type="string" required="yes">
    <cfargument name="imgID" type="numeric" required="yes">
    <cfargument name="ftempFile" type="string" required="yes">
    <cfargument name="ftempZoneCount" type="numeric" required="yes">
    <cfargument name="ftempSort" type="numeric" required="yes">
    <cfargument name="ftempStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully inserted the record.">
    <cftry>
    <!---Check for profanity in the text.--->
    <cfinvoke 
    component="MCMS.component.utility.Regex"
    method="regexProfanity"
    returnvariable="regexProfanityRet">
    <cfinvokeargument name="profanityString" value="#ARGUMENTS.ftempDescription#"/>
    </cfinvoke>
    <!---Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.app.flyer.Flyer"
    method="getFlyerTemplate"
    returnvariable="getCheckFlyerTemplateRet">
    <cfinvokeargument name="ftempName" value="#ARGUMENTS.ftempName#"/>
    <cfinvokeargument name="ftempStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckFlyerTemplateRet.recordcount NEQ 0>
    <cfset result.message = "The name #ARGUMENTS.ftempName# already exists, please enter a new name.">
    <cfelseif regexProfanityRet CONTAINS '$%&*!'>
    <cfset result.message = "Some text contained profanity, please remove any profanity from your text.">
    <!---Check length restriction.--->
    <cfelseif LEN(ARGUMENTS.ftempDescription) GT 1024>
    <cfset result.message = "The description is longer than 1024 characters, please enter a new description under 1024 characters.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    INSERT INTO tbl_flyer_template (ftempName,ftempDescription,imgID,ftempFile,ftempZoneCount,ftempSort,ftempStatus) VALUES
    (
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.ftempName#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.ftempDescription#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.imgID#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.ftempFile#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ftempZoneCount#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ftempSort#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ftempStatus#">
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
    
    <cffunction name="insertFlyerTemplateZoneRel" access="public" returntype="struct">
    <cfargument name="ftempID" type="numeric" required="yes">  
    <cfargument name="fzID" type="numeric" required="yes">  
    <cfargument name="ftempzrStatus" type="numeric" required="yes"> 
    <cfset result.message = "You have successfully inserted the record.">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    INSERT INTO tbl_flyer_template_zone_rel (ftempID,fzID,ftempzrStatus) VALUES
    (
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ftempID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.fzID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ftempzrStatus#">
    )
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error inserting the record.">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="insertFlyerZone" access="public" returntype="struct">
    <cfargument name="fzName" type="string" required="yes">
    <cfargument name="fzDescription" type="string" required="yes">
    <cfargument name="fzCode" type="string" required="yes">
    <cfargument name="fzSort" type="numeric" required="yes">
    <cfargument name="fzStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully inserted the record.">
    <cftry>
    <!---Check for profanity in the text.--->
    <cfinvoke 
    component="MCMS.component.utility.Regex"
    method="regexProfanity"
    returnvariable="regexProfanityRet">
    <cfinvokeargument name="profanityString" value="#ARGUMENTS.fzDescription#"/>
    </cfinvoke>
    <!---Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.app.flyer.Flyer"
    method="getFlyerZone"
    returnvariable="getCheckFlyerZoneRet">
    <cfinvokeargument name="fzName" value="#ARGUMENTS.fzName#"/>
    <cfinvokeargument name="fzStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckFlyerZoneRet.recordcount NEQ 0>
    <cfset result.message = "The name #ARGUMENTS.fzName# already exists, please enter a new name.">
    <cfelseif regexProfanityRet CONTAINS '$%&*!'>
    <cfset result.message = "Some text contained profanity, please remove any profanity from your text.">
    <!---Check length restriction.--->
    <cfelseif LEN(ARGUMENTS.fzDescription) GT 1024>
    <cfset result.message = "The description is longer than 1024 characters, please enter a new description under 1024 characters.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    INSERT INTO tbl_flyer_zone (fzName,fzDescription,fzCode,fzSort,fzStatus) VALUES
    (
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.fzName#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.fzDescription#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.fzCode#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.fzSort#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.fzStatus#">
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
    
    <cffunction name="insertFlyerZoneType" access="public" returntype="struct">
    <cfargument name="fztName" type="string" required="yes">
    <cfargument name="fztSort" type="numeric" required="yes">
    <cfargument name="fztStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully inserted the record.">
    <cftry>
    <!---Check for profanity in the text.--->
    <cfinvoke 
    component="MCMS.component.utility.Regex"
    method="regexProfanity"
    returnvariable="regexProfanityRet">
    <cfinvokeargument name="profanityString" value="#ARGUMENTS.fztName#"/>
    </cfinvoke>
    <!---Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.app.flyer.Flyer"
    method="getFlyerZoneType"
    returnvariable="getCheckFlyerZoneTypeRet">
    <cfinvokeargument name="fztName" value="#ARGUMENTS.fztName#"/>
    <cfinvokeargument name="fztStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckFlyerZoneTypeRet.recordcount NEQ 0>
    <cfset result.message = "The name #ARGUMENTS.fztName# already exists, please enter a new name.">
    <cfelseif regexProfanityRet CONTAINS '$%&*!'>
    <cfset result.message = "Some text contained profanity, please remove any profanity from your text.">
    <!---Check length restriction.--->
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    INSERT INTO tbl_flyer_zone_type (fztName,fztSort,fztStatus) VALUES
    (
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.fztName#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.fztSort#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.fztStatus#">
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
    
    <cffunction name="insertFlyerPageProductZoneRel" access="public" returntype="struct">
    <cfargument name="fID" type="numeric" required="yes">
    <cfargument name="fpID" type="numeric" required="yes">
    <cfargument name="pID" type="numeric" required="yes">
    <cfargument name="fzID" type="numeric" required="yes">
    <cfargument name="fppzrStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully inserted the record.">
    <cftry>
    <!---Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.app.flyer.Flyer"
    method="getFlyerPageProductZoneRel"
    returnvariable="getCheckFlyerPageProductZoneRelRet">
    <cfinvokeargument name="fID" value="#ARGUMENTS.fID#"/>
    <cfinvokeargument name="fpID" value="#ARGUMENTS.fpID#"/>
    <cfinvokeargument name="pID" value="#ARGUMENTS.pID#"/>
    <cfinvokeargument name="fppzrStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckFlyerPageProductZoneRelRet.recordcount NEQ 0>
    <cfset result.message = "The product has already been assigned a zone, please try again.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    INSERT INTO tbl_flyer_pg_prod_zone_rel (fID,fpID,pID,fzID,fppzrStatus) VALUES
    (
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.fID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.fpID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.pID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.fzID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.fppzrStatus#">
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
    
    <cffunction name="updateFlyer" access="public" returntype="struct">
    <cfargument name="ID" type="numeric" required="yes">
    <cfargument name="fName" type="string" required="yes">
    <cfargument name="fDescription" type="string" required="yes">
    <cfargument name="fDateRel" type="date" required="yes">
    <cfargument name="fDateExp" type="date" required="yes">
    <cfargument name="ainID" type="numeric" required="yes">
    <cfargument name="ftID" type="numeric" required="yes">
    <cfargument name="bID" type="numeric" required="yes">
    <cfargument name="fSort" type="numeric" required="yes">
    <cfargument name="fStatus" type="numeric" required="yes">
    <!---Relationship arguments.--->
    <cfargument name="siteNo" type="string" required="yes">
    <cfset result.message = "You have successfully updated the record.">
    <cftry>
    <!---Check for profanity in the text.--->
    <cfinvoke 
    component="MCMS.component.utility.Regex"
    method="regexProfanity"
    returnvariable="regexProfanityRet">
    <cfinvokeargument name="profanityString" value="#ARGUMENTS.fDescription#"/>
    </cfinvoke>
    <!---Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.app.flyer.Flyer"
    method="getFlyer"
    returnvariable="getCheckFlyerRet">
    <cfinvokeargument name="excludeID" value="#ARGUMENTS.ID#"/>
    <cfinvokeargument name="fName" value="#ARGUMENTS.fName#"/>
    <cfinvokeargument name="fStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckFlyerRet.recordcount NEQ 0>
    <cfset result.message = "The name #ARGUMENTS.fName# already exists, please enter a new name.">
    <cfelseif regexProfanityRet CONTAINS '$%&*!'>
    <cfset result.message = "Some text contained profanity, please remove any profanity from your text.">
    <!---Check length restriction.--->
    <cfelseif LEN(ARGUMENTS.fDescription) GT 1024>
    <cfset result.message = "The description is longer than 1024 characters, please enter a new description under 1024 characters.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_flyer SET
    fName = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.fName#">,
    fDescription = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.fDescription#">,
    fDateRel = <cfqueryparam cfsqltype="cf_sql_date" value="#ARGUMENTS.fDateRel#">,
    fDateExp = <cfqueryparam cfsqltype="cf_sql_date" value="#ARGUMENTS.fDateExp#">,
    ainID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ainID#">,
    ftID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ftID#">,
    bID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.bID#">,
    fSort = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.fSort#">,
    fStatus = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.fStatus#">
    WHERE ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ID#">
    </cfquery>
    </cftransaction>
    <!---Delete any existing relationships.--->
    <cfinvoke 
    component="MCMS.component.app.flyer.Flyer"
    method="deleteFlyerSiteRel"
    returnvariable="deleteFlyerSiteRelRet">
    <cfinvokeargument name="fID" value="#ARGUMENTS.ID#"/>
    </cfinvoke>
    <!---Create site relationships.--->
    <cfloop index="siteNo" list="#ARGUMENTS.siteNo#">
    <cfinvoke 
    component="MCMS.component.app.flyer.Flyer"
    method="insertFlyerSiteRel"
    returnvariable="insertFlyerSiteRelRet">
    <cfinvokeargument name="fID" value="#ARGUMENTS.ID#"/>
    <cfinvokeargument name="siteNo" value="#siteNo#"/>
    <cfinvokeargument name="fsrStatus" value="1"/>
    </cfinvoke>
    </cfloop>
    </cfif>
    <cfcatch type="any">
    <cfset result.message = "There was an error updating the record.">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="updateFlyerPage" access="public" returntype="struct">
    <cfargument name="ID" type="numeric" required="yes">
    <cfargument name="fpName" type="string" required="yes"> 
    <cfargument name="fID" type="numeric" required="yes">  
    <cfargument name="ftempID" type="numeric" required="yes">  
    <cfargument name="fpSort" type="numeric" required="yes">  
    <cfargument name="fpStatus" type="numeric" required="yes"> 
    <cfset result.message = "You have successfully updated the record.">
    <cftry>
    <!---Check for profanity in the text.--->
    <cfinvoke 
    component="MCMS.component.utility.Regex"
    method="regexProfanity"
    returnvariable="regexProfanityRet">
    <cfinvokeargument name="profanityString" value="#ARGUMENTS.fpName#"/>
    </cfinvoke>
    <!---Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.app.flyer.Flyer"
    method="getFlyerPage"
    returnvariable="getCheckFlyerPageRet">
    <cfinvokeargument name="excludeID" value="#ARGUMENTS.ID#"/>
    <cfinvokeargument name="fID" value="#ARGUMENTS.fID#"/>
    <cfinvokeargument name="fpSort" value="#ARGUMENTS.fpSort#"/>
    <cfinvokeargument name="fpStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckFlyerPageRet.recordcount NEQ 0>
    <cfset result.message = "The Sort/Page No. #ARGUMENTS.fpSort# already exists, please choose an alternate sort/page no.">
    <cfelseif regexProfanityRet CONTAINS '$%&*!'>
    <cfset result.message = "Some text contained profanity, please remove any profanity from your text.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_flyer_page SET
    fpName = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.fpName#">,
    fID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.fID#">,
    ftempID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ftempID#">,
    fpSort = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.fpSort#">,
    fpStatus = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.fpStatus#">
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
    
    <cffunction name="updateFlyerType" access="public" returntype="struct">
    <cfargument name="ID" type="numeric" required="yes">
    <cfargument name="ftName" type="string" required="yes">
    <cfargument name="ftDescription" type="string" required="yes">
    <cfargument name="ftSort" type="numeric" required="yes">
    <cfargument name="ftStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully updated the record.">
    <cftry>
    <!---Check for profanity in the text.--->
    <cfinvoke 
    component="MCMS.component.utility.Regex"
    method="regexProfanity"
    returnvariable="regexProfanityRet">
    <cfinvokeargument name="profanityString" value="#ARGUMENTS.ftDescription#"/>
    </cfinvoke>
    <!---Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.app.flyer.Flyer"
    method="getFlyerType"
    returnvariable="getCheckFlyerTypeRet">
    <cfinvokeargument name="excludeID" value="#ARGUMENTS.ID#"/>
    <cfinvokeargument name="ftName" value="#ARGUMENTS.ftName#"/>
    <cfinvokeargument name="ftStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckFlyerTypeRet.recordcount NEQ 0>
    <cfset result.message = "The name #ARGUMENTS.ftName# already exists, please enter a new name.">
    <cfelseif regexProfanityRet CONTAINS '$%&*!'>
    <cfset result.message = "Some text contained profanity, please remove any profanity from your text.">
    <!---Check length restriction.--->
    <cfelseif LEN(ARGUMENTS.ftDescription) GT 1024>
    <cfset result.message = "The description is longer than 1024 characters, please enter a new description under 1024 characters.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_flyer_type SET
    ftName = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.ftName#">,
    ftDescription = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.ftDescription#">,
    ftSort = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ftSort#">,
    ftStatus = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ftStatus#">
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
    
    <cffunction name="updateFlyerTemplate" access="public" returntype="struct">
    <cfargument name="ID" type="numeric" required="yes">
    <cfargument name="ftempName" type="string" required="yes">
    <cfargument name="ftempDescription" type="string" required="yes">
    <cfargument name="imgID" type="numeric" required="yes">
    <cfargument name="ftempFile" type="string" required="yes">
    <cfargument name="ftempZoneCount" type="string" required="yes">
    <cfargument name="ftempSort" type="numeric" required="yes">
    <cfargument name="ftempStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully updated the record.">
    <cftry>
    <!---Check for profanity in the text.--->
    <cfinvoke 
    component="MCMS.component.utility.Regex"
    method="regexProfanity"
    returnvariable="regexProfanityRet">
    <cfinvokeargument name="profanityString" value="#ARGUMENTS.ftempDescription#"/>
    </cfinvoke>
    <!---Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.app.flyer.Flyer"
    method="getFlyerTemplate"
    returnvariable="getCheckFlyerTemplateRet">
    <cfinvokeargument name="excludeID" value="#ARGUMENTS.ID#"/>
    <cfinvokeargument name="ftempName" value="#ARGUMENTS.ftempName#"/>
    <cfinvokeargument name="ftempStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckFlyerTemplateRet.recordcount NEQ 0>
    <cfset result.message = "The name #ARGUMENTS.ftempName# already exists, please enter a new name.">
    <cfelseif regexProfanityRet CONTAINS '$%&*!'>
    <cfset result.message = "Some text contained profanity, please remove any profanity from your text.">
    <!---Check length restriction.--->
    <cfelseif LEN(ARGUMENTS.ftempDescription) GT 1024>
    <cfset result.message = "The description is longer than 1024 characters, please enter a new description under 1024 characters.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_flyer_template SET
    ftempName = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.ftempName#">,
    ftempDescription = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.ftempDescription#">,
    imgID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.imgID#">,
    ftempFile = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.ftempFile#">,
    ftempZoneCount = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ftempZoneCount#">,
    ftempSort = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ftempSort#">,
    ftempStatus = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ftempStatus#">
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
    
    <cffunction name="updateFlyerTemplateZoneRel" access="public" returntype="struct"> 
    <cfargument name="ID" type="numeric" required="yes"> 
    <cfargument name="ftempID" type="numeric" required="yes">  
    <cfargument name="fzID" type="numeric" required="yes">  
    <cfargument name="ftempzrStatus" type="numeric" required="yes"> 
    <cfset result.message = "You have successfully updated the record.">
    <cftry>
    <!---Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.app.flyer.Flyer"
    method="getFlyerTemplateZoneRel"
    returnvariable="getCheckFlyerTemplateZoneRelRet">
    <cfinvokeargument name="excludeID" value="#ARGUMENTS.ID#"/>
    <cfinvokeargument name="ftempID" value="#ARGUMENTS.ftempID#"/>
    <cfinvokeargument name="fzID" value="#ARGUMENTS.fzID#"/>
    <cfinvokeargument name="ftempzrStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckFlyerTemplateZoneRelRet.recordcount NEQ 0>
    <cfset result.message = "The template and zone already exists, please choose an alternate template and zone combination.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_flyer_template_zone_rel SET
    ftempID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ftempID#">,
    fzID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.fzID#">,
    ftempzrStatus = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ftempzrStatus#">
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
    
    <cffunction name="updateFlyerZone" access="public" returntype="struct">
    <cfargument name="ID" type="numeric" required="yes">
    <cfargument name="fzName" type="string" required="yes">
    <cfargument name="fzDescription" type="string" required="yes">
    <cfargument name="fzCode" type="string" required="yes">
    <cfargument name="fzSort" type="numeric" required="yes">
    <cfargument name="fzStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully updated the record.">
    <cftry>
    <!---Check for profanity in the text.--->
    <cfinvoke 
    component="MCMS.component.utility.Regex"
    method="regexProfanity"
    returnvariable="regexProfanityRet">
    <cfinvokeargument name="profanityString" value="#ARGUMENTS.fzDescription#"/>
    </cfinvoke>
    <!---Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.app.flyer.Flyer"
    method="getFlyerZone"
    returnvariable="getCheckFlyerZoneRet">
    <cfinvokeargument name="excludeID" value="#ARGUMENTS.ID#"/>
    <cfinvokeargument name="fzName" value="#ARGUMENTS.fzName#"/>
    <cfinvokeargument name="fzStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckFlyerZoneRet.recordcount NEQ 0>
    <cfset result.message = "The name #ARGUMENTS.fzName# already exists, please enter a new name.">
    <cfelseif regexProfanityRet CONTAINS '$%&*!'>
    <cfset result.message = "Some text contained profanity, please remove any profanity from your text.">
    <!---Check length restriction.--->
    <cfelseif LEN(ARGUMENTS.fzDescription) GT 1024>
    <cfset result.message = "The description is longer than 1024 characters, please enter a new description under 1024 characters.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_flyer_zone SET
    fzName = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.fzName#">,
    fzDescription = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.fzDescription#">,
    fzCode = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.fzCode#">,
    fzSort = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.fzSort#">,
    fzStatus = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.fzStatus#">
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
    
    <cffunction name="updateFlyerZoneType" access="public" returntype="struct">
    <cfargument name="ID" type="numeric" required="yes">
    <cfargument name="fztName" type="string" required="yes">
    <cfargument name="fztSort" type="numeric" required="yes">
    <cfargument name="fztStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully updated the record.">
    <cftry>
    <!---Check for profanity in the text.--->
    <cfinvoke 
    component="MCMS.component.utility.Regex"
    method="regexProfanity"
    returnvariable="regexProfanityRet">
    <cfinvokeargument name="profanityString" value="#ARGUMENTS.fztName#"/>
    </cfinvoke>
    <!---Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.app.flyer.Flyer"
    method="getFlyerZoneType"
    returnvariable="getCheckFlyerZoneTypeRet">
    <cfinvokeargument name="excludeID" value="#ARGUMENTS.ID#"/>
    <cfinvokeargument name="fztName" value="#ARGUMENTS.fztName#"/>
    <cfinvokeargument name="fztStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckFlyerZoneTypeRet.recordcount NEQ 0>
    <cfset result.message = "The name #ARGUMENTS.fztName# already exists, please enter a new name.">
    <cfelseif regexProfanityRet CONTAINS '$%&*!'>
    <cfset result.message = "Some text contained profanity, please remove any profanity from your text.">
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_flyer_zone_type SET
    fztName = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.fztName#">,
    fztSort = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.fztSort#">,
    fztStatus = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.fztStatus#">
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
    
    <cffunction name="updateFlyerList" access="public" returntype="struct">
    <cfargument name="ID" type="numeric" required="yes">
    <cfargument name="fStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully updated the records.">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_flyer SET
    fStatus = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.fStatus#">
    WHERE ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ID#">
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error updating the records.">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="updateFlyerPageList" access="public" returntype="struct">
    <cfargument name="ID" type="numeric" required="yes">
    <cfargument name="fpStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully updated the records.">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_flyer_page SET
    fpStatus = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.fpStatus#">
    WHERE ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ID#">
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error updating the records.">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="updateFlyerTemplateZoneRelList" access="public" returntype="struct">
    <cfargument name="ID" type="numeric" required="yes">
    <cfargument name="ftempzrStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully updated the records.">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_flyer_template_zone_rel SET
    ftempzrStatus = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ftempzrStatus#">
    WHERE ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ID#">
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error updating the records.">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="updateFlyerTypeList" access="public" returntype="struct">
    <cfargument name="ID" type="numeric" required="yes">
    <cfargument name="ftStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully updated the records.">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_flyer_type SET
    ftStatus = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ftStatus#">
    WHERE ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ID#">
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error updating the records.">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="updateFlyerTemplateList" access="public" returntype="struct">
    <cfargument name="ID" type="numeric" required="yes">
    <cfargument name="ftempStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully updated the records.">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_flyer_template SET
    ftempStatus = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ftempStatus#">
    WHERE ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ID#">
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error updating the records.">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="updateFlyerZoneList" access="public" returntype="struct">
    <cfargument name="ID" type="numeric" required="yes">
    <cfargument name="fzStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully updated the records.">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_flyer_zone SET
    fzStatus = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.fzStatus#">
    WHERE ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ID#">
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error updating the records.">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="updateFlyerZoneTypeList" access="public" returntype="struct">
    <cfargument name="ID" type="numeric" required="yes">
    <cfargument name="fztStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully updated the records.">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_flyer_zone_type SET
    fztStatus = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.fztStatus#">
    WHERE ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ID#">
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error updating the records.">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="deleteFlyer" access="public" returntype="struct">
    <cfargument name="ID" type="string" required="yes">
    <cfset result.message = "You have successfully deleted the record(s).">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    DELETE FROM tbl_flyer
    WHERE ID IN (<cfqueryparam cfsqltype="cf_sql_integer" list="yes" value="#ARGUMENTS.ID#">)
    </cfquery>
    </cftransaction>
    <!---Delete any existing relationships.--->
    <cfinvoke 
    component="MCMS.component.app.flyer.Flyer"
    method="deleteFlyerSiteRel"
    returnvariable="result">
    <cfinvokeargument name="fID" value="#ARGUMENTS.ID#"/>
    </cfinvoke>
    <cfinvoke 
    component="MCMS.component.app.flyer.Flyer"
    method="deleteFlyerPage"
    returnvariable="result">
    <cfinvokeargument name="fID" value="#ARGUMENTS.ID#"/>
    </cfinvoke>
    <cfinvoke 
    component="MCMS.component.app.flyer.Flyer"
    method="deleteFlyerPageProductZoneRel"
    returnvariable="result">
    <cfinvokeargument name="fID" value="#ARGUMENTS.ID#"/>
    </cfinvoke>
    <cfcatch type="any">
    <cfset result.message = "There was an error deleting the record(s).">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction> 
    
    <cffunction name="deleteFlyerSiteRel" access="public" returntype="struct">
    <cfargument name="ID" type="string" required="yes" default="0">
    <cfargument name="fID" type="string" required="yes" default="0">
    <cfset result.message = "You have successfully deleted the record(s).">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    DELETE FROM tbl_flyer_site_rel
    WHERE ID IN (<cfqueryparam cfsqltype="cf_sql_integer" list="yes" value="#ARGUMENTS.ID#">)
    OR fID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.fID#">
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error deleting the record(s).">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction> 
    
    <cffunction name="deleteFlyerPage" access="public" returntype="struct">
    <cfargument name="ID" type="string" required="yes" default="0">
    <cfargument name="fID" type="string" required="yes" default="0">
    <cfset result.message = "You have successfully deleted the record(s).">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    DELETE FROM tbl_flyer_page
    WHERE ID IN (<cfqueryparam cfsqltype="cf_sql_integer" list="yes" value="#ARGUMENTS.ID#">)
    OR fID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.fID#">
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error deleting the record(s).">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="deleteFlyerTemplateZoneRel" access="public" returntype="struct">
    <cfargument name="ID" type="string" required="yes">
    <cfset result.message = "You have successfully removed the record(s).">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    DELETE FROM tbl_flyer_template_zone_rel
    WHERE ID IN (<cfqueryparam cfsqltype="cf_sql_integer" list="yes" value="#ARGUMENTS.ID#">)
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error deleting the record(s).">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction> 
    
    <cffunction name="deleteFlyerPageProductZoneRel" access="public" returntype="struct">
    <cfargument name="ID" type="string" required="yes" default="0">
    <cfargument name="fID" type="string" required="yes" default="0">
    <cfset result.message = "You have successfully removed the record(s).">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    DELETE FROM tbl_flyer_pg_prod_zone_rel
    WHERE ID IN (<cfqueryparam cfsqltype="cf_sql_integer" list="yes" value="#ARGUMENTS.ID#">)
    OR fID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.fID#">
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error deleting the record(s).">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="deleteFlyerType" access="public" returntype="struct">
    <cfargument name="ID" type="string" required="yes">
    <cfset result.message = "You have successfully deleted the record(s).">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    DELETE FROM tbl_flyer_type
    WHERE ID IN (<cfqueryparam cfsqltype="cf_sql_integer" list="yes" value="#ARGUMENTS.ID#">)
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error deleting the record(s).">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction> 
    
    <cffunction name="deleteFlyerTemplate" access="public" returntype="struct">
    <cfargument name="ID" type="string" required="yes">
    <cfset result.message = "You have successfully deleted the record(s).">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    DELETE FROM tbl_flyer_template
    WHERE ID IN (<cfqueryparam cfsqltype="cf_sql_integer" list="yes" value="#ARGUMENTS.ID#">)
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error deleting the record(s).">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction> 
    
    <cffunction name="deleteFlyerZone" access="public" returntype="struct">
    <cfargument name="ID" type="string" required="yes">
    <cfset result.message = "You have successfully deleted the record(s).">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    DELETE FROM tbl_flyer_zone
    WHERE ID IN (<cfqueryparam cfsqltype="cf_sql_integer" list="yes" value="#ARGUMENTS.ID#">)
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error deleting the record(s).">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction> 
    
    <cffunction name="deleteFlyerZoneType" access="public" returntype="struct">
    <cfargument name="ID" type="string" required="yes">
    <cfset result.message = "You have successfully deleted the record(s).">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    DELETE FROM tbl_flyer_zone_type
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