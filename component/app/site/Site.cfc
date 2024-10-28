<cfcomponent> 
    <cffunction name="getSite" access="public" returntype="query" hint="Get Site data.">
    <cfargument name="keywords" type="string" required="no" default="All">
    <cfargument name="ID" type="numeric" required="yes" default="0">
    <cfargument name="excludeID" type="numeric" required="yes" default="0">
    <cfargument name="siteNo" type="string" required="yes" default="100">
    <cfargument name="excludeSiteNo" type="string" required="yes" default="100">
    <cfargument name="siteName" type="string" required="yes" default="">
    <cfargument name="siteDateSet" type="string" required="yes" default="">
    <cfargument name="siteDateOpen" type="string" required="yes" default="">
    <cfargument name="siteDateOpenGT" type="string" required="yes" default="">
    <cfargument name="siteDateClose" type="string" required="yes" default="">
    <cfargument name="stID" type="string" required="yes" default="0">
    <cfargument name="stStatus" type="string" required="no" default="1">
    <cfargument name="siteStatus" type="string" required="yes" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="siteName">
    <cfset var rsSite = "" >
    <cftry>
    <cfquery name="rsSite" datasource="#application.mcmsDSN#">
    SELECT * FROM v_site WHERE 0=0
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(siteName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"><cfif IsNumeric(ARGUMENTS.keywords)> OR siteNo = <cfqueryparam value="#ARGUMENTS.keywords#" cfsqltype="cf_sql_integer"></cfif>)
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
    <cfif ARGUMENTS.excludeSiteNo NEQ 100>
    AND siteNo NOT IN (<cfqueryparam value="#ARGUMENTS.excludeSiteNo#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    <cfif ARGUMENTS.siteName NEQ "">
    AND siteName = <cfqueryparam value="#ARGUMENTS.siteName#" cfsqltype="cf_sql_varchar">
    </cfif>
    <cfif ARGUMENTS.siteDateSet NEQ "">
    AND siteDateSet <= <cfqueryparam value="#ARGUMENTS.siteDateSet#" cfsqltype="cf_sql_date">
    </cfif>
    <cfif ARGUMENTS.siteDateOpen NEQ "">
    AND siteDateOpen <= <cfqueryparam value="#ARGUMENTS.siteDateOpen#" cfsqltype="cf_sql_date">
    </cfif>
    <cfif ARGUMENTS.siteDateOpenGT NEQ "">
    AND siteDateOpen >= <cfqueryparam value="#ARGUMENTS.siteDateOpenGT#" cfsqltype="cf_sql_date">
    </cfif>
    <cfif ARGUMENTS.siteDateClose NEQ "">
    AND siteDateClose >= <cfqueryparam value="#ARGUMENTS.siteDateClose#" cfsqltype="cf_sql_date">
    </cfif>
    <cfif ARGUMENTS.stID NEQ 0>
    AND stID IN (<cfqueryparam value="#ARGUMENTS.stID#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    AND stStatus IN (<cfqueryparam value="#ARGUMENTS.stStatus#" list="yes" cfsqltype="cf_sql_integer">)
    AND siteStatus IN (<cfqueryparam value="#ARGUMENTS.siteStatus#" list="yes" cfsqltype="cf_sql_integer">)
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsSite = StructNew()>
    <cfset rsSite.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsSite>
    </cffunction>
    
    <cffunction name="getSiteGroup" access="public" returntype="query" hint="Get Site Group data.">
    <cfargument name="keywords" type="string" required="no" default="All">
    <cfargument name="ID" type="numeric" required="yes" default="0">
    <cfargument name="excludeID" type="numeric" required="yes" default="0">
    <cfargument name="sgName" type="string" required="yes" default="">
    <cfargument name="sgStatus" type="string" required="yes" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="sgName">
    <cfset var rsSiteGroup = "" >
    <cftry>
    <cfquery name="rsSiteGroup" datasource="#application.mcmsDSN#">
    SELECT * FROM v_site_group WHERE 0=0
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(sgName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">)
    </cfif>
    <cfif ARGUMENTS.ID NEQ 0>
    AND ID = <cfqueryparam value="#ARGUMENTS.ID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.excludeID NEQ 0>
    AND ID <> <cfqueryparam value="#ARGUMENTS.excludeID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.sgName NEQ "">
    AND sgName = <cfqueryparam value="#ARGUMENTS.sgName#" cfsqltype="cf_sql_varchar">
    </cfif>
    AND sgStatus IN (<cfqueryparam value="#ARGUMENTS.sgStatus#" list="yes" cfsqltype="cf_sql_integer">)
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsSiteGroup = StructNew()>
    <cfset rsSiteGroup.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsSiteGroup>
    </cffunction>
    
    <cffunction name="getSiteGroupZone" access="public" returntype="query" hint="Get Site Group Zone data.">
    <cfargument name="keywords" type="string" required="no" default="All">
    <cfargument name="ID" type="numeric" required="yes" default="0">
    <cfargument name="excludeID" type="numeric" required="yes" default="0">
    <cfargument name="sgzName" type="string" required="yes" default="">
    <cfargument name="sgzStatus" type="string" required="yes" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="sgzName">
    <cfset var rsSiteGroupZone = "" >
    <cftry>
    <cfquery name="rsSiteGroupZone" datasource="#application.mcmsDSN#">
    SELECT * FROM v_site_group_zone WHERE 0=0
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(sgzName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">)
    </cfif>
    <cfif ARGUMENTS.ID NEQ 0>
    AND ID = <cfqueryparam value="#ARGUMENTS.ID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.excludeID NEQ 0>
    AND ID <> <cfqueryparam value="#ARGUMENTS.excludeID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.sgzName NEQ "">
    AND sgzName = <cfqueryparam value="#ARGUMENTS.sgzName#" cfsqltype="cf_sql_varchar">
    </cfif>
    AND sgzStatus IN (<cfqueryparam value="#ARGUMENTS.sgzStatus#" list="yes" cfsqltype="cf_sql_integer">)
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsSiteGroupZone = StructNew()>
    <cfset rsSiteGroupZone.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsSiteGroupZone>
    </cffunction>
    
    <cffunction name="getSiteGroupZoneDeptRel" access="public" returntype="query" hint="Get Site Group Zone Dept. Rel. data.">
    <cfargument name="keywords" type="string" required="no" default="All">
    <cfargument name="ID" type="numeric" required="yes" default="0">
    <cfargument name="excludeID" type="numeric" required="yes" default="0">
    <cfargument name="sgID" type="numeric" required="yes" default="0">
    <cfargument name="sgzID" type="numeric" required="yes" default="0">
    <cfargument name="deptNo" type="string" required="yes" default="0">
    <cfargument name="sgStatus" type="string" required="yes" default="1,3">
    <cfargument name="sgzStatus" type="string" required="yes" default="1,3">
    <cfargument name="deptStatus" type="string" required="yes" default="1,3">
    <cfargument name="sgzdrStatus" type="string" required="yes" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="sgName, deptNo">
    <cfset var rsSiteGroupZoneDeptRel = "" >
    <cftry>
    <cfquery name="rsSiteGroupZoneDeptRel" datasource="#application.mcmsDSN#">
    SELECT * FROM v_site_group_zone_dept_rel WHERE 0=0
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(sgName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(sgzName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(deptName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">)
    </cfif>
    <cfif ARGUMENTS.ID NEQ 0>
    AND ID = <cfqueryparam value="#ARGUMENTS.ID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.excludeID NEQ 0>
    AND ID <> <cfqueryparam value="#ARGUMENTS.excludeID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.sgID NEQ 0>
    AND sgID = <cfqueryparam value="#ARGUMENTS.sgID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.sgzID NEQ 0>
    AND sgzID = <cfqueryparam value="#ARGUMENTS.sgzID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.deptNo NEQ 0>
    AND deptNo IN (<cfqueryparam value="#ARGUMENTS.deptNo#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    AND sgStatus IN (<cfqueryparam value="#ARGUMENTS.sgStatus#" list="yes" cfsqltype="cf_sql_integer">)
    AND sgzStatus IN (<cfqueryparam value="#ARGUMENTS.sgzStatus#" list="yes" cfsqltype="cf_sql_integer">)
    AND deptStatus IN (<cfqueryparam value="#ARGUMENTS.deptStatus#" list="yes" cfsqltype="cf_sql_integer">)
    AND sgzdrStatus IN (<cfqueryparam value="#ARGUMENTS.sgzdrStatus#" list="yes" cfsqltype="cf_sql_integer">)
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsSiteGroupZoneDeptRel = StructNew()>
    <cfset rsSiteGroupZoneDeptRel.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsSiteGroupZoneDeptRel>
    </cffunction>
    
    <cffunction name="getSiteGroupZoneSiteRel" access="public" returntype="query" hint="Get Site Group Zone Site Rel. data.">
    <cfargument name="keywords" type="string" required="no" default="All">
    <cfargument name="ID" type="numeric" required="yes" default="0">
    <cfargument name="excludeID" type="numeric" required="yes" default="0">
    <cfargument name="sgID" type="numeric" required="yes" default="0">
    <cfargument name="sgzID" type="numeric" required="yes" default="0">
    <cfargument name="siteNo" type="string" required="yes" default="100">
    <cfargument name="siteDateOpen" type="string" required="yes" default="">
    <cfargument name="siteDateClose" type="string" required="yes" default="">
    <cfargument name="sgStatus" type="string" required="yes" default="1,3">
    <cfargument name="sgzStatus" type="string" required="yes" default="1,3">
    <cfargument name="siteStatus" type="string" required="yes" default="1,3">
    <cfargument name="sgzsrStatus" type="string" required="yes" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="sgName, siteNo">
    <cfset var rsSiteGroupZoneSiteRel = "" >
    <cftry>
    <cfquery name="rsSiteGroupZoneSiteRel" datasource="#application.mcmsDSN#">
    SELECT * FROM v_site_group_zone_site_rel WHERE 0=0
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(sgName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(sgzName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(siteName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">)
    </cfif>
    <cfif ARGUMENTS.ID NEQ 0>
    AND ID = <cfqueryparam value="#ARGUMENTS.ID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.excludeID NEQ 0>
    AND ID <> <cfqueryparam value="#ARGUMENTS.excludeID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.sgID NEQ 0>
    AND sgID = <cfqueryparam value="#ARGUMENTS.sgID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.sgzID NEQ 0>
    AND sgzID = <cfqueryparam value="#ARGUMENTS.sgzID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.siteNo NEQ 100>
    AND siteNo IN (<cfqueryparam value="#ARGUMENTS.siteNo#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    <cfif ARGUMENTS.siteDateOpen NEQ "">
    AND siteDateOpen >= <cfqueryparam value="#ARGUMENTS.siteDateOpen#" cfsqltype="cf_sql_date">
    </cfif>
    <cfif ARGUMENTS.siteDateClose NEQ "">
    AND siteDateClose >= <cfqueryparam value="#ARGUMENTS.siteDateClose#" cfsqltype="cf_sql_date">
    </cfif>
    AND sgStatus IN (<cfqueryparam value="#ARGUMENTS.sgStatus#" list="yes" cfsqltype="cf_sql_integer">)
    AND sgzStatus IN (<cfqueryparam value="#ARGUMENTS.sgzStatus#" list="yes" cfsqltype="cf_sql_integer">)
    AND siteStatus IN (<cfqueryparam value="#ARGUMENTS.siteStatus#" list="yes" cfsqltype="cf_sql_integer">)
    AND sgzsrStatus IN (<cfqueryparam value="#ARGUMENTS.sgzsrStatus#" list="yes" cfsqltype="cf_sql_integer">)
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsSiteGroupZoneSiteRel = StructNew()>
    <cfset rsSiteGroupZoneSiteRel.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsSiteGroupZoneSiteRel>
    </cffunction>
    
    <cffunction name="getSiteReport" access="public" returntype="query" hint="Get Site Report data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="siteNo" type="string" required="yes" default="100">
	<cfargument name="orderBy" type="string" required="yes" default="siteName">
	<cfset var rsSiteReport = "" >
    <cftry>
    <cfquery name="rsSiteReport" datasource="#application.mcmsDSN#">
    SELECT siteNo AS Site_No, siteName AS Name, saAddress AS Address, saAddressExt AS Address_Ext,
    saCity AS City, saStateProv AS State_Prov, saZipCode AS Zip_Code, saZipCodeExt AS Zip_Code_Ext,
    saCountry AS Country, 
    saTelArea AS Tel_Area, saTelPrefix || '-' || saTelSuffix AS Telephone, 
    saFaxArea AS Fax_Area, saFaxPrefix || '-' || saFaxSuffix AS Fax,
    saMapURL AS Map_URL, saGPS AS GPS, saMapX AS Map_X, saMapY AS Map_Y, saLattitude, saLongitude, stID AS Type, satID AS Address_Type,
    TO_CHAR(siteDateOpen,'MM/DD/YYYY') AS Open_Date, TO_CHAR(siteDateGrand,'MM/DD/YYYY') AS Grand_Date, TO_CHAR(siteDateClose,'MM/DD/YYYY') AS Close_Date,
    siteStatus AS Status
    FROM v_site_address WHERE 0=0
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND UPPER(siteName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">
    </cfif>
    <cfif ARGUMENTS.siteNo NEQ 100>
    AND siteNo IN (<cfqueryparam value="#ARGUMENTS.siteNo#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsSiteReport = StructNew()>
    <cfset rsSiteReport.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsSiteReport>
    </cffunction>

    <cffunction name="getSiteListReport" access="public" returntype="query" hint="Get Site Report data.">
    <cfset var rsSiteListReport = "" >
    <cftry>
    <cfquery name="rsSiteListReport" datasource="#application.mcmsDSN#">
    SELECT site, name, address, city, state_prov, zip_code, country, manager, email, telephone, fax FROM (
    SELECT sa.siteNo AS Site, sa.siteName AS Name,
    CASE WHEN sa.saAddressExt IS NOT NULL
    THEN sa.saAddressExt || ' - ' || sa.saAddress
    WHEN sa.saAddressExt IS NULL
    THEN sa.saAddress
    END AS Address,
    sa.saCity AS City, sa.saStateProv AS State_Prov,
    CASE WHEN sa.saZipCodeExt IS NOT NULL
    THEN sa.saZipCode || '-' || sa.saZipCodeExt
    WHEN sa.saZipCodeExt IS NULL
    THEN sa.saZipCode
    END AS Zip_Code,
    sa.saCountry AS Country, 
    usr.urName AS Role,
    usr.userFName || ' ' || usr.userLName AS Manager,
    usr.userEmail AS Email,
    '(' || sa.saTelArea || ') ' || sa.saTelPrefix || '-' || sa.saTelSuffix AS Telephone, 
    '(' || sa.saFaxArea || ') ' || sa.saFaxPrefix || '-' || sa.saFaxSuffix AS Fax,
    row_number() over (partition by sa.siteNo order by urID) rn
    FROM v_site_address sa, v_user_site_rel usr   
    WHERE (sa.siteno = usr.siteno(+))
    AND sa.siteStatus = 1 AND sa.satID = 1 AND usr.urID IN (104,105,106) AND usr.userStatus = 1
    ORDER BY sa.siteNo, usr.urID
    ) result
    WHERE rn = 1
    ORDER BY state_prov, site
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsSiteListReport = StructNew()>
    <cfset rsSiteListReport.message = "There was an error with the query.">
    </cfcatch>
    </cftry>
    <cfreturn rsSiteListReport>
    </cffunction>
    
    <cffunction name="getSiteGroupReport" access="public" returntype="query" hint="Get Site Group Report data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
	<cfargument name="orderBy" type="string" required="yes" default="sgName">
	<cfset var rsSiteGroupReport = "" >
    <cftry>
    <cfquery name="rsSiteGroupReport" datasource="#application.mcmsDSN#">
    SELECT sgName AS Name, sName AS Status
    FROM v_site_group WHERE 0=0
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND UPPER(sgName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">
    </cfif>
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsSiteGroupReport = StructNew()>
    <cfset rsSiteGroupReport.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsSiteGroupReport>
    </cffunction>
    
    <cffunction name="getSiteGroupZoneReport" access="public" returntype="query" hint="Get Site Group Zone Report data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
	<cfargument name="orderBy" type="string" required="yes" default="sgzName">
	<cfset var rsSiteGroupZoneReport = "" >
    <cftry>
    <cfquery name="rsSiteGroupZoneReport" datasource="#application.mcmsDSN#">
    SELECT sgzName AS Name, sName AS Status
    FROM v_site_group_zone WHERE 0=0
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND UPPER(sgzName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">
    </cfif>
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsSiteGroupZoneReport = StructNew()>
    <cfset rsSiteGroupZoneReport.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsSiteGroupZoneReport>
    </cffunction>
    
    <cffunction name="getSiteGroupZoneDeptRelReport" access="public" returntype="query" hint="Get Site Group Zone Dept. Rel. Report data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="deptNo" type="string" required="yes" default="0">
	<cfargument name="orderBy" type="string" required="yes" default="sgName, deptNo">
	<cfset var rsSiteGroupZoneDeptRelReport = "" >
    <cftry>
    <cfquery name="rsSiteGroupZoneDeptRelReport" datasource="#application.mcmsDSN#">
    SELECT sgName AS Site_Group, sgzName AS Site_Zone, deptName AS Dept_Name, sgID, sgzID, deptNo, sName AS Status
    FROM v_site_group_zone_dept_rel WHERE 0=0
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(sgName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(sgzName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(deptName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">)
    </cfif>
    <cfif ARGUMENTS.siteNo NEQ 0>
    AND deptNo IN (<cfqueryparam value="#ARGUMENTS.deptNo#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsSiteGroupZoneDeptRelReport = StructNew()>
    <cfset rsSiteGroupZoneDeptRelReport.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsSiteGroupZoneDeptRelReport>
    </cffunction>
    
    <cffunction name="getSiteGroupZoneSiteRelEQReport" access="public" returntype="query" hint="Get Site Group Zone Site Rel. Excel Quick Report data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="siteNo" type="string" required="yes" default="100">
	<cfargument name="orderBy" type="string" required="yes" default="sgzName">
	<cfset var rsSiteGroupZoneDeptRelExcelQuickReport = "" >
    <cftry>
    <cfquery name="rsSiteGroupZoneDeptRelExcelQuickReport" datasource="#application.mcmsDSN#">
    SELECT sgzName AS Group_Name, siteName AS Site_Name, siteNo
    FROM v_site_group_zone_site_rel WHERE 0=0
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND UPPER(sgzName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(siteName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">)
    </cfif>
    <cfif ARGUMENTS.siteNo NEQ 100>
    AND siteNo IN (<cfqueryparam value="#ARGUMENTS.siteNo#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsSiteGroupZoneDeptRelExcelQuickReport = StructNew()>
    <cfset rsSiteGroupZoneDeptRelExcelQuickReport.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsSiteGroupZoneDeptRelExcelQuickReport>
    </cffunction>
    
    <cffunction name="getSiteExcelQuickReport" access="public" returntype="query" hint="Get Site Excel Quick Report data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="siteStatus" type="string" required="yes" default="1,3">
	<cfargument name="orderBy" type="string" required="yes" default="siteName">
	<cfset var getSiteExcelQuickReport = "" >
    <cftry>
    <cfquery name="getSiteExcelQuickReport" datasource="#application.mcmsDSN#">
    SELECT siteNo AS Site_No, siteName AS Name, saAddress AS Address, saAddressExt AS Address_Ext,
    saCity AS City, saStateProv AS State_Prov, saZipCode AS Zip_Code, saZipCodeExt AS Zip_Code_Ext,
    saCountry AS Country, 
    saTelArea AS Tel_Area, saTelPrefix || '-' || saTelSuffix AS Telephone, 
    saFaxArea AS Fax_Area, saFaxPrefix || '-' || saFaxSuffix AS Fax,
    saMapURL AS Map_URL, saGPS AS GPS, saMapX AS Map_X, saMapY AS Map_Y, stID AS Type, satID AS Address_Type,
    TO_CHAR(siteDateOpen,'MM/DD/YYYY') AS Open_Date, TO_CHAR(siteDateGrand,'MM/DD/YYYY') AS Grand_Date, TO_CHAR(siteDateClose,'MM/DD/YYYY') AS Close_Date,
    sName AS Status
    FROM v_site_address WHERE 0=0
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND UPPER(siteName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">
    </cfif>
    AND siteStatus IN (<cfqueryparam value="#ARGUMENTS.siteStatus#" list="yes" cfsqltype="cf_sql_integer">)
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset getSiteExcelQuickReport = StructNew()>
    <cfset getSiteExcelQuickReport.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn getSiteExcelQuickReport>
    </cffunction>
    
    <cffunction name="getSitePDFQuickReport" access="public" returntype="query" hint="Get Site PDF Quick Report data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
	<cfargument name="orderBy" type="string" required="yes" default="siteNo">
	<cfset var rsSitePDFQuickReport = "" >
    <cftry>
    <!---Get Site Address.--->
    <cfinvoke 
    component="MCMS.component.app.site.Site"
    method="getSiteAddress"
    returnvariable="getSiteAddressRet">
    <cfinvokeargument name="stID" value="1"/>
    <cfinvokeargument name="siteStatus" value="1"/>
    <cfinvokeargument name="saStatus" value="1"/>
    <cfinvokeargument name="orderBy" value="siteNo"/>
    </cfinvoke>
    <!---Generate PDF.--->
    <cfdocument format="pdf" unit="in" margintop=".15" marginright=".15" marginbottom=".15" marginleft=".15" orientation="portrait" pagetype="letter">
    <cfdocumentsection>
    <link href="/MCMS/css/main.css" rel="stylesheet" type="text/css">
    <style type="text/css">
	table {
	font-family: Arial, Helvetica, sans-serif;
	font-size: 11.5px;
	}
	</style>
    <table width="100%" border="0" cellpadding="5" cellspacing="0">
    <tr>
	<cfoutput query="getSiteAddressRet">
    <!---Get Store Manager.--->
    <cfsilent>
    <cfinvoke 
    component="MCMS.component.cms.User"
    method="getUserSiteRel"
    returnvariable="getUserSiteRelRet">
    <cfinvokeargument name="urID" value="#application.urIDStoreManager#,#application.urIDRegionalOfficeManager#"/>
    <cfinvokeargument name="stID" value="1"/>
    <cfinvokeargument name="siteNo" value="#getSiteAddressRet.siteNo#"/>
    <cfinvokeargument name="usrStatus" value="1"/>
    <cfinvokeargument name="orderBy" value="urID"/>
    </cfinvoke>
    </cfsilent>
    <td>
    <table width="100%"  border="0" cellspacing="0" cellpadding="3">
    <tr>
    <th bgcolor="##CCCCCC">#UCASE(LEFT(siteName,21))#</th>
    <th bgcolor="##CCCCCC">###siteNo#</th>
    </tr>
    <tr>
    <td colspan="2" nowrap>
    #saAddress#<br/>
    <cfif saAddressExt NEQ ''>#saAddressExt#<br/></cfif>
    #saCity#, #saStateProv#<br/>
    #saZipCode#<cfif saZipCodeExt NEQ ''>-#saZipCodeExt#</cfif> #saCountry#<br/>
    <strong>Tel:</strong> (#saTelArea#)#saTelPrefix#-#saTelSuffix#<br/>
    <cfif saFaxArea NEQ ''><strong>Fax:</strong> (#saFaxArea#)#saFaxPrefix#-#saFaxSuffix#<br/></cfif>
    </td>
    </tr>
    <cfif getUserSiteRelRet.recordcount NEQ 0>
    <tr>
    <td>
    <strong>Manager(s):</strong><br/>
    <cfloop query="getUserSiteRelRet">
    #userFName# #userLName# (#Replace(urName, 'Manager', 'Man.', 'ALL')#)<br/>
    </cfloop>
    </td>
    </tr>
    </cfif>
    </tr>
    </table>
    <cfif CurrentRow MOD 18 EQ 0>
    <cfdocumentitem type="pagebreak"/>
    </cfif>
    </td>
    <cfif CurrentRow MOD 3 EQ 0>
    <tr>
    </cfif>
	</cfoutput>
    </tr>
    </table>
    </cfdocumentsection>
    </cfdocument>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsSitePDFQuickReport = StructNew()>
    <cfset rsSitePDFQuickReport.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsSitePDFQuickReport>
    </cffunction>
    
    <cffunction name="getSiteType" access="public" returntype="query" hint="Get Site Type data.">
    <cfargument name="keywords" type="string" required="no" default="All">
    <cfargument name="ID" type="numeric" required="yes" default="0">
    <cfargument name="stStatus" type="string" required="yes" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="stName">
    <cfset var rsSiteType = "" >
    <cftry>
    <cfquery name="rsSiteType" datasource="#application.mcmsDSN#">
    SELECT * FROM tbl_site_type WHERE 0=0
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND UPPER(stName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">
    </cfif>
    <cfif ARGUMENTS.ID NEQ 0>
    AND ID = <cfqueryparam value="#ARGUMENTS.ID#" cfsqltype="cf_sql_integer">
    </cfif>
    AND stStatus IN (<cfqueryparam value="#ARGUMENTS.stStatus#" list="yes" cfsqltype="cf_sql_integer">)
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsSiteType = StructNew()>
    <cfset rsSiteType.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsSiteType>
    </cffunction>
    
    <cffunction name="getSiteAddress" access="public" returntype="query">
    <cfargument name="keywords" type="string" required="no" default="All">
    <cfargument name="ID" type="numeric" required="yes" default="0">
    <cfargument name="excludeID" type="numeric" required="yes" default="0">
    <cfargument name="siteNo" type="string" required="yes" default="100">
    <cfargument name="excludeSiteNo" type="string" required="no" default="100">
    <cfargument name="siteDateSet" type="string" required="yes" default="">
    <cfargument name="siteDateOpen" type="string" required="yes" default="">
    <cfargument name="siteDateClose" type="string" required="yes" default="">
    <cfargument name="stID" type="string" required="yes" default="0">
    <cfargument name="siteStatus" type="string" required="yes" default="1,3">
    <cfargument name="saStatus" type="string" required="yes" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="siteNo">
	<cfset var rsSiteAddress = "" >
    <cftry>
    <cfquery name="rsSiteAddress" datasource="#application.mcmsDSN#">
    SELECT * FROM v_site_address WHERE 0=0
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(siteName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> <cfif IsNumeric(ARGUMENTS.keywords)> OR siteNo = <cfqueryparam value="#ARGUMENTS.keywords#" cfsqltype="cf_sql_integer"></cfif>)
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
    <cfif ARGUMENTS.excludeSiteNo NEQ 100>
    AND siteNo NOT IN (<cfqueryparam value="#ARGUMENTS.excludeSiteNo#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    <cfif ARGUMENTS.siteDateSet NEQ "">
    AND siteDateSet <= <cfqueryparam value="#ARGUMENTS.siteDateSet#" cfsqltype="cf_sql_date">
    </cfif>
    <cfif ARGUMENTS.siteDateOpen NEQ "">
    AND siteDateOpen >= <cfqueryparam value="#ARGUMENTS.siteDateOpen#" cfsqltype="cf_sql_date">
    </cfif>
    <cfif ARGUMENTS.siteDateClose NEQ "">
    AND siteDateClose >= <cfqueryparam value="#ARGUMENTS.siteDateClose#" cfsqltype="cf_sql_date">
    </cfif>
    <cfif ARGUMENTS.stID NEQ 0>
    AND stID IN (<cfqueryparam value="#ARGUMENTS.stID#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    AND siteStatus IN (<cfqueryparam value="#ARGUMENTS.siteStatus#" list="yes" cfsqltype="cf_sql_integer">)
    AND saStatus IN (<cfqueryparam value="#ARGUMENTS.saStatus#" list="yes" cfsqltype="cf_sql_integer">)
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsSiteAddress = StructNew()>
    <cfset rsSiteAddress.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsSiteAddress>
    </cffunction>  
    
    <cffunction name="getSiteAddressType" access="public" returntype="query" hint="Get Site Address Type data.">
    <cfargument name="keywords" type="string" required="no" default="All">
    <cfargument name="ID" type="numeric" required="yes" default="0">
    <cfargument name="satStatus" type="string" required="yes" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="satName">
    <cfset var rsSiteAddressType = "" >
    <cftry>
    <cfquery name="rsSiteAddressType" datasource="#application.mcmsDSN#">
    SELECT * FROM tbl_site_address_type WHERE 0=0
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND UPPER(satName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">
    </cfif>
    <cfif ARGUMENTS.ID NEQ 0>
    AND ID = <cfqueryparam value="#ARGUMENTS.ID#" cfsqltype="cf_sql_integer">
    </cfif>
    AND satStatus IN (<cfqueryparam value="#ARGUMENTS.satStatus#" list="yes" cfsqltype="cf_sql_integer">)
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsSiteAddressType = StructNew()>
    <cfset rsSiteAddressType.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsSiteAddressType>
    </cffunction> 
    
    <cffunction name="getSiteLocator" access="remote" returnType="struct" output="false" hint="Site Locator data." >
    <cfargument name="mapID" type="string" required="yes" default="site" />
	<cfset var getSiteAddressRet = "" >
    <!---Becuse of the remote call you must hardcode the dsn name.--->
    <cfset var siteDSN = application.mcmsDSN>
	<cfset var result = StructNew()>
    <cftry>
    <!---Construct method to filter sites. Each case could query to filter sites by siteNo.--->
    <cfswitch expression="#ARGUMENTS.mapID#">
    <cfcase value="site">
    <cfset excludeSiteNo = 100>
    </cfcase>
    <cfcase value="event">
    <cfset excludeSiteNo = 100>
    </cfcase>
    <cfcase value="employment">
    <cfset excludeSiteNo = 100>
    </cfcase>
    <cfcase value="fishing_report">
    <cfset excludeSiteNo = 100>
    </cfcase>
    <cfcase value="brag">
    <cfset excludeSiteNo = 100>
    </cfcase>
    <cfdefaultcase>
    <cfset excludeSiteNo = 100>
    </cfdefaultcase>
    </cfswitch>
    <!---Get sites.--->
    <cfquery name="getSiteAddressRet" datasource="#siteDSN#">
    SELECT * FROM v_site_address WHERE 0=0
    AND siteNo NOT IN (<cfqueryparam value="#excludeSiteNo#" list="yes" cfsqltype="cf_sql_integer">)
    AND stID = <cfqueryparam value="1" cfsqltype="cf_sql_integer">
    AND siteStatus IN (<cfqueryparam value="1,3" list="yes" cfsqltype="cf_sql_integer">)
    AND saStatus IN (<cfqueryparam value="1,3" list="yes" cfsqltype="cf_sql_integer">)
    ORDER BY siteName
    </cfquery>
	<cfset sites = ArrayNew(1)>
	<cfset j = 1>
	<cfloop query="getSiteAddressRet">
	<cfset site = StructNew()>
	<cfset a = StructInsert(site, "siteNo", getSiteAddressRet.siteNo, 0)>
	<cfset a = StructInsert(site, "siteName", getSiteAddressRet.siteName, 0)>
	<cfset a = StructInsert(site, "siteStateProv", getSiteAddressRet.saStateProv, 0)>
	<cfset a = StructInsert(site, "siteDateGrand", getSiteAddressRet.siteDateGrand, 0)>
	<cfset a = StructInsert(site, "siteDateOpen", getSiteAddressRet.siteDateOpen, 0)>
	<cfset a = StructInsert(site, "siteDateClose", getSiteAddressRet.siteDateClose, 0)>
	<cfset a = StructInsert(site, "siteMapX", getSiteAddressRet.saMapX, 0)>
	<cfset a = StructInsert(site, "siteMapY", getSiteAddressRet.saMapY, 0)>
	<cfset sites[j] = site>
	<cfset j = j +1>
	</cfloop>
	<cfset a = StructInsert(result, "sites", sites,0)>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset result = "There was an error with Site Locator.">
    
    </cfcatch>
    </cftry>
	<cfreturn result>
	</cffunction>
    
    <cffunction name="getSiteHour" access="public" returntype="query">
    <cfargument name="keywords" type="string" required="no" default="All">
    <cfargument name="ID" type="numeric" required="yes" default="0">
    <cfargument name="excludeID" type="numeric" required="yes" default="0">
    <cfargument name="siteNo" type="string" required="yes" default="100">
    <cfargument name="excludeSiteNo" type="string" required="no" default="100">
    <cfargument name="shrDateExp" type="string" required="yes" default="">
    <cfargument name="dayName" type="string" required="yes" default="">
    <cfargument name="shrStatus" type="string" required="yes" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="siteNo">
	<cfset var rsSiteHour = "" >
    <cftry>
    <cfquery name="rsSiteHour" datasource="#application.mcmsDSN#">
    SELECT * FROM v_site_hour WHERE 0=0
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(siteName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR siteNo LIKE <cfqueryparam value="%#ARGUMENTS.keywords#%" cfsqltype="cf_sql_varchar"> OR UPPER(dayName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">)
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
    <cfif ARGUMENTS.excludeSiteNo NEQ 100>
    AND siteNo NOT IN (<cfqueryparam value="#ARGUMENTS.excludeSiteNo#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    <cfif ARGUMENTS.shrDateExp NEQ "">
    AND shrDateExp >= <cfqueryparam value="#ARGUMENTS.shrDateExp#" cfsqltype="cf_sql_date">
    </cfif>
    <cfif ARGUMENTS.dayName NEQ "">
    AND dayName = <cfqueryparam value="#ARGUMENTS.dayName#" cfsqltype="cf_sql_varchar">
    </cfif>
    AND shrStatus IN (<cfqueryparam value="#ARGUMENTS.shrStatus#" list="yes" cfsqltype="cf_sql_integer">)
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsSiteHour = StructNew()>
    <cfset rsSiteHour.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsSiteHour>
    </cffunction>
    
    <cffunction name="getSiteHourReport" access="public" returntype="query">
    <cfargument name="keywords" type="string" required="no" default="All">
    <cfargument name="siteNo" type="numeric" required="no" default="100">
	<cfargument name="orderBy" type="string" required="yes" default="siteNo">
	<cfset var rsSiteHourReport = "" >
    <cftry>
    <cfquery name="rsSiteHourReport" datasource="#application.mcmsDSN#">
    SELECT siteNo AS Site_No, siteName AS Site, dayName AS Day, timeOpen AS Open_Time, timeClose AS Close_Time, 
    TO_CHAR(shrDateExp,'MM/DD/YYYY') AS Date_Expires, sName AS Status 
    FROM v_site_hour WHERE 0=0
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (siteNo LIKE <cfqueryparam value="%#ARGUMENTS.keywords#%" cfsqltype="cf_sql_varchar"> OR UPPER(siteName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">)
    </cfif>
    <cfif ARGUMENTS.siteNo NEQ 100>
    AND siteNo = <cfqueryparam value="#ARGUMENTS.siteNo#" cfsqltype="cf_sql_integer">
    </cfif>
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsSiteHourReport = StructNew()>
    <cfset rsSiteHourReport.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsSiteHourReport>
    </cffunction>
    
    <cffunction name="getSiteHourExcelQuickReport" access="public" returntype="query">
    <cfargument name="shrStatus" type="string" required="yes" default="1,3">
    <cfargument name="keywords" type="string" required="no" default="All">
	<cfargument name="orderBy" type="string" required="yes" default="siteNo">
	<cfset var getSiteHourExcelQuickReport = "" >
    <cftry>
    <cfquery name="getSiteHourExcelQuickReport" datasource="#application.mcmsDSN#">
    SELECT siteNo AS Site_No, siteName AS Site, dayName AS Day, timeOpen AS Open_Time, timeClose AS Close_Time, 
    TO_CHAR(shrDateExp,'MM/DD/YYYY') AS Date_Expires, sName AS Status 
    FROM v_site_hour WHERE 0=0
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (siteNo LIKE <cfqueryparam value="%#ARGUMENTS.keywords#%" cfsqltype="cf_sql_varchar"> OR UPPER(siteName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">)
    </cfif>
    AND shrDateExp >= <cfqueryparam value="#Now()#" cfsqltype="cf_sql_date">
    AND shrStatus IN (<cfqueryparam value="#ARGUMENTS.shrStatus#" list="yes" cfsqltype="cf_sql_integer">)
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset getSiteHourExcelQuickReport = StructNew()>
    <cfset getSiteHourExcelQuickReport.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn getSiteHourExcelQuickReport>
    </cffunction>
    
    <cffunction name="insertSite" access="public" returntype="struct">
    <cfargument name="siteNo" type="numeric" required="yes">
    <cfargument name="siteName" type="string" required="yes">
    <cfargument name="imgID" type="numeric" required="yes">
    <cfargument name="siteDateSet" type="date" required="yes">
    <cfargument name="siteDateOpen" type="date" required="yes">
    <cfargument name="siteDateGrand" type="date" required="yes">
    <cfargument name="siteDateClose" type="date" required="yes">
    <cfargument name="stID" type="numeric" required="yes">
    <cfargument name="siteSort" type="numeric" required="yes">
    <cfargument name="siteStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully inserted the record.">
    <cftry>
    <!---Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.app.site.Site"
    method="getSite"
    returnvariable="getCheckSiteRet">
    <cfinvokeargument name="siteNo" value="#ARGUMENTS.siteNo#"/>
    <cfinvokeargument name="siteName" value="#ARGUMENTS.siteName#"/>
    <cfinvokeargument name="siteStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckSiteRet.recordcount NEQ 0>
    <cfset result.message = "The name #ARGUMENTS.siteName# with number #ARGUMENTS.siteNo# already exists, please enter a new name.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    INSERT INTO tbl_site (siteNo,siteName,imgID,siteDateSet,siteDateOpen,siteDateGrand,siteDateClose,stID,siteSort,siteStatus) VALUES
    (
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.siteNo#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.siteName#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.imgID#">,
    <cfqueryparam cfsqltype="cf_sql_date" value="#ARGUMENTS.siteDateSet#">,
    <cfqueryparam cfsqltype="cf_sql_date" value="#ARGUMENTS.siteDateOpen#">,
    <cfqueryparam cfsqltype="cf_sql_date" value="#ARGUMENTS.siteDateGrand#">,
    <cfqueryparam cfsqltype="cf_sql_timestamp" value="#ARGUMENTS.siteDateClose#" null="#YesNoFormat(Compare(Trim(ARGUMENTS.siteDateClose), "") EQ 0)#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.stID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.siteSort#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.siteStatus#">
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
    
    <cffunction name="insertSiteGroup" access="public" returntype="struct">
    <cfargument name="sgName" type="string" required="yes">
    <cfargument name="sgStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully inserted the record.">
    <cftry>
    <!---Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.app.site.Site"
    method="getSiteGroup"
    returnvariable="getCheckSiteGroupRet">
    <cfinvokeargument name="sgName" value="#ARGUMENTS.sgName#"/>
    <cfinvokeargument name="sgStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckSiteGroupRet.recordcount NEQ 0>
    <cfset result.message = "The name #ARGUMENTS.sgName# already exists, please enter a new name.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    INSERT INTO tbl_site_group (sgName,sgStatus) VALUES
    (
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.sgName#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.sgStatus#">
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
    
    <cffunction name="insertSiteGroupZone" access="public" returntype="struct">
    <cfargument name="sgzName" type="string" required="yes">
    <cfargument name="sgID" type="numeric" required="yes">
    <cfargument name="sgzStatus" type="numeric" required="yes">
    <!---Relationship arguments.--->
    <cfargument name="siteNo" type="string" required="yes">
    <cfargument name="deptNo" type="string" required="yes">
    <cfset result.message = "You have successfully inserted the record.">
    <cftry>
    <!---Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.app.site.Site"
    method="getSiteGroupZone"
    returnvariable="getCheckSiteGroupZoneRet">
    <cfinvokeargument name="sgzName" value="#ARGUMENTS.sgzName#"/>
    <cfinvokeargument name="sgzStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckSiteGroupZoneRet.recordcount NEQ 0>
    <cfset result.message = "The name #ARGUMENTS.sgzName# already exists, please enter a new name.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    INSERT INTO tbl_site_group_zone (sgzName,sgzStatus) VALUES
    (
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.sgzName#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.sgzStatus#">
    )
    </cfquery>
    </cftransaction>
    <!---Get the Site Group Zone just added.--->
    <cfinvoke 
    component="MCMS.component.cms.Cms"
    method="getMaxValueSQL"
    returnvariable="sgzID">
    <cfinvokeargument name="tableName" value="tbl_site_group_zone"/>
    </cfinvoke>
    <!---Create site relationships.--->
    <cfloop index="siteNo" list="#ARGUMENTS.siteNo#">
    <cfinvoke 
    component="MCMS.component.app.site.Site"
    method="insertSiteGroupZoneSiteRel"
    returnvariable="insertSiteGroupZoneSiteRelRet">
    <cfinvokeargument name="sgzID" value="#sgzID#"/>
    <cfinvokeargument name="sgID" value="#ARGUMENTS.sgID#"/>
    <cfinvokeargument name="siteNo" value="#siteNo#"/>
    <cfinvokeargument name="sgzsrStatus" value="1"/>
    </cfinvoke>
    </cfloop>
    <!---Create department relationships.--->
    <cfloop index="deptNo" list="#ARGUMENTS.deptNo#">
    <cfinvoke 
    component="MCMS.component.cms.User"
    method="insertSiteGroupZoneDeptRel"
    returnvariable="insertSiteGroupZoneDeptRelRet">
    <cfinvokeargument name="sgzID" value="#sgzID#"/>
    <cfinvokeargument name="sgID" value="#ARGUMENTS.sgID#"/>
    <cfinvokeargument name="deptNo" value="#deptNo#"/>
    <cfinvokeargument name="sgzdrStatus" value="1"/>
    </cfinvoke>
    </cfloop>
    </cfif>
    <cfcatch type="any">
    <cfset result.message = "There was an error inserting the record.">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="insertSiteGroupZoneSiteRel" access="public" returntype="struct">
    <cfargument name="sgID" type="numeric" required="yes">
    <cfargument name="sgzID" type="numeric" required="yes">
    <cfargument name="siteNo" type="numeric" required="yes">
    <cfargument name="sgzsrStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully inserted the record.">
    <cftry>
    <!---Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.app.site.Site"
    method="getSiteGroupZoneSiteRel"
    returnvariable="getCheckSiteGroupZoneSiteRelRet">
    <cfinvokeargument name="sgID" value="#ARGUMENTS.sgID#"/>
    <cfinvokeargument name="sgzID" value="#ARGUMENTS.sgzID#"/>
    <cfinvokeargument name="siteNo" value="#ARGUMENTS.siteNo#"/>
    <cfinvokeargument name="sgzsrStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckSiteGroupZoneSiteRelRet.recordcount NEQ 0>
    <cfset result.message = "A record for this relationship already exists, please enter a try again.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    INSERT INTO tbl_site_group_zone_site_rel (sgID,sgzID,siteNo,sgzsrStatus) VALUES
    (
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.sgID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.sgzID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.siteNo#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.sgzsrStatus#">
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
    
    <cffunction name="insertSiteGroupZoneDeptRel" access="public" returntype="struct">
    <cfargument name="sgID" type="numeric" required="yes">
    <cfargument name="sgzID" type="numeric" required="yes">
    <cfargument name="deptNo" type="numeric" required="yes">
    <cfargument name="sgzdrStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully inserted the record.">
    <cftry>
    <!---Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.app.site.Site"
    method="getSiteGroupZoneDeptRel"
    returnvariable="getCheckSiteGroupZoneDeptRelRet">
    <cfinvokeargument name="sgID" value="#ARGUMENTS.sgID#"/>
    <cfinvokeargument name="sgzID" value="#ARGUMENTS.sgzID#"/>
    <cfinvokeargument name="deptNo" value="#ARGUMENTS.deptNo#"/>
    <cfinvokeargument name="sgzdrStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckSiteGroupZoneDeptRelRet.recordcount NEQ 0>
    <cfset result.message = "A record for this relationship already exists, please enter a try again.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    INSERT INTO tbl_site_group_zone_dept_rel (sgID,sgzID,deptNo,sgzdrStatus) VALUES
    (
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.sgID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.sgzID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.deptNo#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.sgzdrStatus#">
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
    
    <cffunction name="insertSiteAddress" access="public" returntype="struct">
    <cfargument name="siteNo" type="numeric" required="yes">
    <cfargument name="saAddress" type="string" required="yes">
    <cfargument name="saAddressExt" type="string" required="yes">
    <cfargument name="saCity" type="string" required="yes">
    <cfargument name="saStateProv" type="string" required="yes">
    <cfargument name="saZipCode" type="string" required="yes">
    <cfargument name="saZipCodeExt" type="string" required="yes">
    <cfargument name="saCountry" type="string" required="yes">
    <cfargument name="saTelArea" type="string" required="yes">
    <cfargument name="saTelPrefix" type="string" required="yes">
    <cfargument name="saTelSuffix" type="string" required="yes">
    <cfargument name="saFaxArea" type="string" required="yes">
    <cfargument name="saFaxPrefix" type="string" required="yes">
    <cfargument name="saFaxSuffix" type="string" required="yes">
    <cfargument name="saMapURL" type="string" required="yes">
    <cfargument name="saGPS" type="string" required="yes">
    <cfargument name="saMapX" type="string" required="yes">
    <cfargument name="saMapY" type="string" required="yes">
    <cfargument name="saLattitude" type="string" required="yes">
    <cfargument name="saLongitude" type="string" required="yes">
    <cfargument name="satID" type="numeric" required="yes">
    <cfargument name="saStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully inserted the record.">
    <cftry>
    <!---Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.app.site.Site"
    method="getSiteAddress"
    returnvariable="getCheckSiteAddressRet">
    <cfinvokeargument name="siteNo" value="#ARGUMENTS.siteNo#"/>
    <cfinvokeargument name="satID" value="#ARGUMENTS.satID#"/>
    <cfinvokeargument name="saStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckSiteAddressRet.recordcount NEQ 0>
    <cfset result.message = "The site no. of #ARGUMENTS.siteNo# already exists with this address type, please try again.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    INSERT INTO tbl_site_address (siteNo,saAddress,saAddressExt,saCity,saStateProv,saZipCode,saZipCodeExt,saCountry,saTelArea,saTelPrefix,saTelSuffix,saFaxArea,saFaxPrefix,saFaxSuffix,saMapURL,saGPS,saMapX,saMapY,saLattitude,saLongitude,satID,saStatus) VALUES
    (
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.siteNo#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.saAddress#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.saAddressExt#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.saCity#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.saStateProv#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.saZipCode#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.saZipCodeExt#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.saCountry#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.saTelArea#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.saTelPrefix#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.saTelSuffix#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.saFaxArea#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.saFaxPrefix#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.saFaxSuffix#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.saMapURL#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.saGPS#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.saMapX#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.saMapY#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.saLattitude#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.saLongitude#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.satID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.saStatus#">
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
    
    <cffunction name="insertSiteHour" access="public" returntype="struct">
    <cfargument name="siteNo" type="string" required="yes">
    <cfargument name="dayName" type="string" required="yes">
    <cfargument name="timeOpen" type="string" required="yes">
    <cfargument name="timeClose" type="string" required="yes">
    <cfargument name="shrDateExp" type="date" required="yes">
    <cfargument name="shrSort" type="string" required="yes">
    <cfargument name="shrStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully inserted the record.">
    <cftry>
    <!---Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.app.site.Site"
    method="getSiteHour"
    returnvariable="getCheckSiteHourRet">
    <cfinvokeargument name="siteNo" value="#ARGUMENTS.siteNo#"/>
    <cfinvokeargument name="dayName" value="#ARGUMENTS.dayName#"/>
    <cfinvokeargument name="siteStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckSiteHourRet.recordcount NEQ 0>
    <cfset result.message = "A record for #ARGUMENTS.dayName# already exists, please enter a new day.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    INSERT INTO tbl_site_hour (siteNo,dayName,timeOpen,timeClose,shrDateExp,shrSort,shrStatus) VALUES
    (
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.siteNo#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.dayName#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.timeOpen#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.timeClose#">,
    <cfqueryparam cfsqltype="cf_sql_date" value="#ARGUMENTS.shrDateExp#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.shrSort#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.shrStatus#">
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
    
    <cffunction name="updateSite" access="public" returntype="struct">
    <cfargument name="ID" type="numeric" required="yes">
    <cfargument name="siteNo" type="string" required="yes">
    <cfargument name="siteName" type="string" required="yes">
    <cfargument name="imgID" type="string" required="yes">
    <cfargument name="siteDateSet" type="date" required="yes">
    <cfargument name="siteDateOpen" type="date" required="yes">
    <cfargument name="siteDateGrand" type="date" required="yes">
    <cfargument name="siteDateClose" type="string" required="yes">
    <cfargument name="stID" type="numeric" required="yes">
    <cfargument name="siteSort" type="numeric" required="yes">
    <cfargument name="siteStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully updated the record.">
    <cftry>
    <!---Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.app.site.Site"
    method="getSite"
    returnvariable="getCheckSiteRet">
    <cfinvokeargument name="excludeID" value="#ARGUMENTS.ID#"/>
    <cfinvokeargument name="siteNo" value="#ARGUMENTS.siteNo#"/>
    <cfinvokeargument name="siteName" value="#ARGUMENTS.siteName#"/>
    <cfinvokeargument name="siteStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckSiteRet.recordcount NEQ 0>
    <cfset result.message = "The name #ARGUMENTS.siteName# with number #ARGUMENTS.siteNo# already exists, please enter a new name.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_site SET
    siteNo = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.siteNo#">,
    siteName = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.siteName#">,
    imgID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.imgID#">,
    siteDateSet = <cfqueryparam cfsqltype="cf_sql_date" value="#ARGUMENTS.siteDateSet#">,
    siteDateOpen = <cfqueryparam cfsqltype="cf_sql_date" value="#ARGUMENTS.siteDateOpen#">,
    siteDateGrand = <cfqueryparam cfsqltype="cf_sql_date" value="#ARGUMENTS.siteDateGrand#">,
    siteDateClose = <cfqueryparam cfsqltype="cf_sql_timestamp" value="#ARGUMENTS.siteDateClose#" null="#YesNoFormat(Compare(Trim(ARGUMENTS.siteDateClose), "") EQ 0)#">,
    stID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.stID#">,
    siteSort = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.siteSort#">,
    siteStatus = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.siteStatus#">
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
    
    <cffunction name="updateSiteGroup" access="public" returntype="struct">
    <cfargument name="ID" type="numeric" required="yes">
    <cfargument name="sgName" type="string" required="yes">
    <cfargument name="sgStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully updated the record.">
    <cftry>
    <!---Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.app.site.Site"
    method="getSiteGroup"
    returnvariable="getCheckSiteGroupRet">
    <cfinvokeargument name="excludeID" value="#ARGUMENTS.ID#"/>
    <cfinvokeargument name="sgName" value="#ARGUMENTS.sgName#"/>
    <cfinvokeargument name="sgStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckSiteGroupRet.recordcount NEQ 0>
    <cfset result.message = "The name #ARGUMENTS.sgName#, please enter a new name.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_site_group SET
    sgName = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.sgName#">,
    sgStatus = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.sgStatus#">
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
    
    <cffunction name="updateSiteGroupZone" access="public" returntype="struct">
    <cfargument name="ID" type="numeric" required="yes">
    <cfargument name="sgzName" type="string" required="yes">
    <cfargument name="sgzStatus" type="numeric" required="yes">
    <!---Relationship arguments.--->
    <cfargument name="sgID" type="numeric" required="yes">
    <cfargument name="siteNo" type="string" required="yes">
    <cfargument name="deptNo" type="string" required="yes">
    <cfset result.message = "You have successfully updated the record.">
    <cftry>
    <!---Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.app.site.Site"
    method="getSiteGroupZone"
    returnvariable="getCheckSiteGroupZoneRet">
    <cfinvokeargument name="excludeID" value="#ARGUMENTS.ID#"/>
    <cfinvokeargument name="sgzName" value="#ARGUMENTS.sgzName#"/>
    <cfinvokeargument name="sgzStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckSiteGroupZoneRet.recordcount NEQ 0>
    <cfset result.message = "The name #ARGUMENTS.sgzName#, please enter a new name.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_site_group_zone SET
    sgzName = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.sgzName#">,
    sgzStatus = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.sgzStatus#">
    WHERE ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ID#">
    </cfquery>
    </cftransaction>
    <!---Delete any existing relationships.--->
    <cfinvoke 
    component="MCMS.component.app.site.Site"
    method="deleteSiteGroupZoneSiteRel"
    returnvariable="deleteSiteGroupZoneSiteRelRet">
    <cfinvokeargument name="sgzID" value="#ARGUMENTS.ID#"/>
    </cfinvoke>
    <cfinvoke 
    component="MCMS.component.app.site.Site"
    method="deleteSiteGroupZoneDeptRel"
    returnvariable="deleteSiteGroupZoneDeptRelRet">
    <cfinvokeargument name="sgzID" value="#ARGUMENTS.ID#"/>
    </cfinvoke>
    <!---Create site relationships.--->
    <cfloop index="siteNo" list="#ARGUMENTS.siteNo#">
    <cfinvoke 
    component="MCMS.component.app.site.Site"
    method="insertSiteGroupZoneSiteRel"
    returnvariable="insertSiteGroupZoneSiteRelRet">
    <cfinvokeargument name="sgzID" value="#ARGUMENTS.ID#"/>
    <cfinvokeargument name="sgID" value="#ARGUMENTS.sgID#"/>
    <cfinvokeargument name="siteNo" value="#siteNo#"/>
    <cfinvokeargument name="sgzsrStatus" value="1"/>
    </cfinvoke>
    </cfloop>
    <!---Create department relationships.--->
    <cfloop index="deptNo" list="#ARGUMENTS.deptNo#">
    <cfinvoke 
    component="MCMS.component.app.site.Site"
    method="insertSiteGroupZoneDeptRel"
    returnvariable="insertSiteGroupZoneDeptRelRet">
    <cfinvokeargument name="sgzID" value="#ARGUMENTS.ID#"/>
    <cfinvokeargument name="sgID" value="#ARGUMENTS.sgID#"/>
    <cfinvokeargument name="deptNo" value="#deptNo#"/>
    <cfinvokeargument name="sgzdrStatus" value="1"/>
    </cfinvoke>
    </cfloop>
    </cfif>
    <cfcatch type="any">
    <cfset result.message = "There was an error updating the record.">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="updateSiteAddress" access="public" returntype="struct">
    <cfargument name="ID" type="numeric" required="yes">
    <cfargument name="siteNo" type="numeric" required="yes">
    <cfargument name="saAddress" type="string" required="yes">
    <cfargument name="saAddressExt" type="string" required="yes">
    <cfargument name="saCity" type="string" required="yes">
    <cfargument name="saStateProv" type="string" required="yes">
    <cfargument name="saZipCode" type="string" required="yes">
    <cfargument name="saZipCodeExt" type="string" required="yes">
    <cfargument name="saCountry" type="string" required="yes">
    <cfargument name="saTelArea" type="string" required="yes">
    <cfargument name="saTelPrefix" type="string" required="yes">
    <cfargument name="saTelSuffix" type="string" required="yes">
    <cfargument name="saFaxArea" type="string" required="yes">
    <cfargument name="saFaxPrefix" type="string" required="yes">
    <cfargument name="saFaxSuffix" type="string" required="yes">
    <cfargument name="saMapURL" type="string" required="yes">
    <cfargument name="saGPS" type="string" required="yes">
    <cfargument name="saMapX" type="string" required="yes">
    <cfargument name="saMapY" type="string" required="yes">
    <cfargument name="saLattitude" type="string" required="yes">
    <cfargument name="saLongitude" type="string" required="yes">
    <cfargument name="satID" type="numeric" required="yes">
    <cfargument name="saStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully updated the record.">
    <cftry>
    <!---Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.app.site.Site"
    method="getSiteAddress"
    returnvariable="getCheckSiteAddressRet">
    <cfinvokeargument name="excludeID" value="#ARGUMENTS.ID#"/>
    <cfinvokeargument name="siteNo" value="#ARGUMENTS.siteNo#"/>
    <cfinvokeargument name="satID" value="#ARGUMENTS.satID#"/>
    <cfinvokeargument name="saStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckSiteAddressRet.recordcount NEQ 0>
    <cfset result.message = "The site no. of #ARGUMENTS.siteNo# already exists with this address type, please try again.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_site_address SET
    siteNo = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.siteNo#">,
    saAddress = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.saAddress#">,
    saAddressExt = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.saAddressExt#">,
    saCity = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.saCity#">,
    saStateProv = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.saStateProv#">,
    saZipCode = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.saZipCode#">,
    saZipCodeExt = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.saZipCodeExt#">,
    saCountry = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.saCountry#">,
    saTelArea = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.saTelArea#">,
    saTelPrefix = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.saTelPrefix#">,
    saTelSuffix = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.saTelSuffix#">,
    saFaxArea = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.saFaxArea#">,
    saFaxPrefix = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.saFaxPrefix#">,
    saFaxSuffix = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.saFaxSuffix#">,
    saMapURL = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.saMapURL#">,
    saGPS = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.saGPS#">,
    saMapX = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.saMapX#">,
    saMapY = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.saMapY#">,
    saLattitude = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.saLattitude#">,
    saLongitude = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.saLongitude#">,
    satID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.satID#">,
    saStatus = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.saStatus#">
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
    
    <cffunction name="updateSiteHour" access="public" returntype="struct">
    <cfargument name="ID" type="numeric" required="yes">
    <cfargument name="uaID" type="numeric" required="yes">
    <cfargument name="siteNo" type="string" required="yes">
    <cfargument name="dayName" type="string" required="yes">
    <cfargument name="timeOpen" type="string" required="yes">
    <cfargument name="timeClose" type="string" required="yes">
    <cfargument name="shrDateExp" type="date" required="yes">
    <cfargument name="shrSort" type="string" required="yes">
    <cfargument name="shrStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully updated the record.">
    <cftry>
    <!---Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.app.site.Site"
    method="getSiteHour"
    returnvariable="getCheckSiteHourRet">
    <cfinvokeargument name="excludeID" value="#ARGUMENTS.ID#"/>
    <cfinvokeargument name="siteNo" value="#ARGUMENTS.siteNo#"/>
    <cfinvokeargument name="dayName" value="#ARGUMENTS.dayName#"/>
    <cfinvokeargument name="shrStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckSiteHourRet.recordcount NEQ 0>
    <cfset result.message = "A record for #ARGUMENTS.dayName# already exists, please enter a new day.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_site_hour SET
    siteNo = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.siteNo#">,
    dayName = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.dayName#">,
    timeOpen = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.timeOpen#">,
    timeClose = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.timeClose#">,
    shrDateExp = <cfqueryparam cfsqltype="cf_sql_date" value="#ARGUMENTS.shrDateExp#">,
    shrSort = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.shrSort#">,
    <cfif ARGUMENTS.uaID NEQ 101>
    shrDateUpdate = <cfqueryparam cfsqltype="cf_sql_timestamp" value="#Now()#">,
    userID = <cfqueryparam cfsqltype="cf_sql_integer" value="#session.userID#">,
    </cfif>
    shrStatus = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.shrStatus#">
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
    
    <cffunction name="updateSiteList" access="public" returntype="struct">
    <cfargument name="ID" type="numeric" required="yes">
    <cfargument name="siteStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully updated the records.">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_site SET
    siteStatus = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.siteStatus#">
    WHERE ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ID#">
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error updating the records.">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="updateSiteGroupList" access="public" returntype="struct">
    <cfargument name="ID" type="numeric" required="yes">
    <cfargument name="sgStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully updated the records.">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_site_group SET
    sgStatus = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.sgStatus#">
    WHERE ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ID#">
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error updating the records.">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="updateSiteGroupZoneList" access="public" returntype="struct">
    <cfargument name="ID" type="numeric" required="yes">
    <cfargument name="sgzStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully updated the records.">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_site_group_zone SET
    sgzStatus = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.sgzStatus#">
    WHERE ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ID#">
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error updating the records.">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="updateSiteAddressList" access="public" returntype="struct">
    <cfargument name="ID" type="numeric" required="yes">
    <cfargument name="saStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully updated the records.">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_site_address SET
    saStatus = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.saStatus#">
    WHERE ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ID#">
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error updating the records.">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="updateSiteHourList" access="public" returntype="struct">
    <cfargument name="ID" type="numeric" required="yes">
    <cfargument name="shrStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully updated the records.">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_site_hour SET
    shrStatus = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.shrStatus#">
    WHERE ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ID#">
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error updating the records.">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <!---Due to the level of importance the sites have to overall CMS/DB functionality, deletes will be limited to the master record only.--->
    
    <cffunction name="deleteSite" access="public" returntype="struct">
    <cfargument name="ID" type="string" required="yes">
    <cfset result.message = "You have successfully deleted the record(s).">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    DELETE FROM tbl_site
    WHERE ID IN (<cfqueryparam cfsqltype="cf_sql_integer" list="yes" value="#ARGUMENTS.ID#">)
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error deleting the record(s).">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="deleteSiteGroup" access="public" returntype="struct">
    <cfargument name="ID" type="string" required="yes">
    <cfset result.message = "You have successfully deleted the record(s).">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    DELETE FROM tbl_site_group
    WHERE ID IN (<cfqueryparam cfsqltype="cf_sql_integer" list="yes" value="#ARGUMENTS.ID#">)
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error deleting the record(s).">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="deleteSiteGroupZone" access="public" returntype="struct">
    <cfargument name="ID" type="string" required="yes">
    <cfset result.message = "You have successfully deleted the record(s).">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    DELETE FROM tbl_site_group_zone
    WHERE ID IN (<cfqueryparam cfsqltype="cf_sql_integer" list="yes" value="#ARGUMENTS.ID#">)
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error deleting the record(s).">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="deleteSiteGroupZoneSiteRel" access="public" returntype="struct">
    <cfargument name="ID" type="string" required="yes" default="0">
    <cfargument name="sgzID" type="string" required="yes" default="0">
    <cfset result.message = "You have successfully deleted the record(s).">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    DELETE FROM tbl_site_group_zone_site_rel
    WHERE ID IN (<cfqueryparam cfsqltype="cf_sql_integer" list="yes" value="#ARGUMENTS.ID#">)
    OR sgzID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.sgzID#">
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error deleting the record(s).">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="deleteSiteGroupZoneDeptRel" access="public" returntype="struct">
    <cfargument name="ID" type="string" required="yes" default="0">
    <cfargument name="sgzID" type="string" required="yes" default="0">
    <cfset result.message = "You have successfully deleted the record(s).">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    DELETE FROM tbl_site_group_zone_dept_rel
    WHERE ID IN (<cfqueryparam cfsqltype="cf_sql_integer" list="yes" value="#ARGUMENTS.ID#">)
    OR sgzID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.sgzID#">
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error deleting the record(s).">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="deleteSiteAddress" access="public" returntype="struct">
    <cfargument name="ID" type="string" required="yes">
    <cfset result.message = "You have successfully deleted the record(s).">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    DELETE FROM tbl_site_address
    WHERE ID IN (<cfqueryparam cfsqltype="cf_sql_integer" list="yes" value="#ARGUMENTS.ID#">)
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error deleting the record(s).">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="deleteSiteHour" access="public" returntype="struct">
    <cfargument name="ID" type="string" required="yes">
    <cfset result.message = "You have successfully deleted the record(s).">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    DELETE FROM tbl_site_hour
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