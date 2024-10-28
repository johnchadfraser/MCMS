<cfcomponent>
    <cffunction name="getTV" access="public" returntype="any" hint="Get TV data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="ID" type="numeric" required="yes" default="0">
    <cfargument name="excludeID" type="numeric" required="yes" default="0">
    <cfargument name="tvName" type="string" required="yes" default="">
    <cfargument name="tvIPAddress" type="numeric" required="yes" default="0">
    <cfargument name="tvtID" type="string" required="yes" default="0">
    <cfargument name="tvStatus" type="string" required="yes" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="tvName">
    <cfset var rsTV = "">
    <cftry>
    <cfquery name="rsTV" datasource="#application.mcmsDSN#">
    SELECT * FROM v_tv WHERE 0=0
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(tvName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(tvDescription) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">)
    </cfif>
    <cfif ARGUMENTS.ID NEQ 0>
    AND ID = <cfqueryparam value="#ARGUMENTS.ID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.excludeID NEQ 0>
    AND ID <> <cfqueryparam value="#ARGUMENTS.excludeID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.tvName NEQ "">
    AND tvName = <cfqueryparam value="#ARGUMENTS.tvName#" cfsqltype="cf_sql_varchar">
    </cfif>
    <cfif ARGUMENTS.tvIPAddress NEQ 0>
    AND tvIPAddress = <cfqueryparam value="#ARGUMENTS.tvIPAddress#" cfsqltype="cf_sql_integer">
    </cfif>
    AND tvStatus IN (<cfqueryparam value="#ARGUMENTS.tvStatus#" list="yes" cfsqltype="cf_sql_integer">)
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsTV = StructNew()>
    <cfset rsTV.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsTV>
    </cffunction>
    
    <cffunction name="getTVListing" access="public" returntype="any" hint="Get TV Listing data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="ID" type="numeric" required="yes" default="0">
    <cfargument name="excludeID" type="numeric" required="yes" default="0">
    <cfargument name="tvName" type="string" required="yes" default="">
    <cfargument name="tvtID" type="string" required="yes" default="0">
    <cfargument name="tvID" type="string" required="yes" default="0">
    <cfargument name="tvsID" type="string" required="yes" default="0">
    <cfargument name="tvlDateRel" type="string" required="yes" default="">
    <cfargument name="tvlDateExp" type="string" required="yes" default="">
    <cfargument name="tvStatus" type="string" required="no" default="1">
    <cfargument name="tvsStatus" type="string" required="no" default="1">
    <cfargument name="tvlStatus" type="string" required="yes" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="tvName">
    <cfset var rsTVListing = "">
    <cftry>
    <cfquery name="rsTVListing" datasource="#application.mcmsDSN#">
    SELECT * FROM v_tv_listing WHERE 0=0
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(tvName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(tvsName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(tvsDescription) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">)
    </cfif>
    <cfif ARGUMENTS.ID NEQ 0>
    AND ID = <cfqueryparam value="#ARGUMENTS.ID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.excludeID NEQ 0>
    AND ID <> <cfqueryparam value="#ARGUMENTS.excludeID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.tvID NEQ 0>
    AND tvID IN (<cfqueryparam value="#ARGUMENTS.tvID#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    <cfif ARGUMENTS.tvsID NEQ 0>
    AND tvsID IN (<cfqueryparam value="#ARGUMENTS.tvsID#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    <cfif ARGUMENTS.tvlDateRel NEQ "">
    AND tvlDateRel = <cfqueryparam value="#ARGUMENTS.tvlDateRel#" cfsqltype="cf_sql_date">
    </cfif>
    <cfif ARGUMENTS.tvlDateExp NEQ "">
    AND tvlDateExp = <cfqueryparam value="#ARGUMENTS.tvlDateExp#" cfsqltype="cf_sql_date">
    </cfif>
    <cfif ARGUMENTS.tvName NEQ "">
    AND tvName = <cfqueryparam value="#ARGUMENTS.tvName#" cfsqltype="cf_sql_varchar">
    </cfif>
    <cfif ARGUMENTS.tvtID NEQ 0>
    AND tvtID = <cfqueryparam value="#ARGUMENTS.tvtID#" cfsqltype="cf_sql_integer">
    </cfif>
    AND tvStatus IN (<cfqueryparam value="#ARGUMENTS.tvStatus#" list="yes" cfsqltype="cf_sql_integer">)
    AND tvsStatus IN (<cfqueryparam value="#ARGUMENTS.tvsStatus#" list="yes" cfsqltype="cf_sql_integer">)
    AND tvlStatus IN (<cfqueryparam value="#ARGUMENTS.tvlStatus#" list="yes" cfsqltype="cf_sql_integer">)
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsTVListing = StructNew()>
    <cfset rsTVListing.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsTVListing>
    </cffunction>
    
    <cffunction name="getTVListingSiteRel" access="public" returntype="any" hint="Get TV Listing Site Rel. data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="ID" type="numeric" required="yes" default="0">
    <cfargument name="excludeID" type="numeric" required="yes" default="0">
    <cfargument name="tvName" type="string" required="yes" default="">
    <cfargument name="tvlID" type="string" required="yes" default="0">
    <cfargument name="tvlDateRel" type="string" required="yes" default="">
    <cfargument name="tvlDateExp" type="string" required="yes" default="">
    <cfargument name="siteStatus" type="string" required="no" default="1">
    <cfargument name="tvStatus" type="string" required="no" default="1">
    <cfargument name="tvlStatus" type="string" required="yes" default="1,2,3">
    <cfargument name="tvlsrStatus" type="string" required="yes" default="1,2,3">
    <cfargument name="orderBy" type="string" required="yes" default="tvName">
    <!---Relationships--->
    <cfargument name="siteNo" type="string" required="yes" default="100">
    <cfset var rsTVListingSiteRel = "">
    <cftry>
    <cfquery name="rsTVListingSiteRel" datasource="#application.mcmsDSN#">
    SELECT * FROM v_tv_listing_site_rel WHERE 0=0
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(tvName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(tvDescription) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(siteName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">  OR UPPER(siteNo) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">)
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
    <cfif ARGUMENTS.tvlDateRel NEQ "">
    AND tvlDateRel = <cfqueryparam value="#ARGUMENTS.tvlDateRel#" cfsqltype="cf_sql_date">
    </cfif>
    <cfif ARGUMENTS.tvlDateExp NEQ "">
    AND tvlDateExp = <cfqueryparam value="#ARGUMENTS.tvlDateExp#" cfsqltype="cf_sql_date">
    </cfif>
    <cfif ARGUMENTS.tvName NEQ "">
    AND tvName = <cfqueryparam value="#ARGUMENTS.tvName#" cfsqltype="cf_sql_varchar">
    </cfif>
    <cfif ARGUMENTS.tvlID NEQ 0>
    AND tvlID = <cfqueryparam value="#ARGUMENTS.tvlID#" cfsqltype="cf_sql_integer">
    </cfif>
    AND siteStatus IN (<cfqueryparam value="#ARGUMENTS.siteStatus#" list="yes" cfsqltype="cf_sql_integer">)
    AND tvStatus IN (<cfqueryparam value="#ARGUMENTS.tvStatus#" list="yes" cfsqltype="cf_sql_integer">)
    AND tvlStatus IN (<cfqueryparam value="#ARGUMENTS.tvlStatus#" list="yes" cfsqltype="cf_sql_integer">)
    AND tvlsrStatus IN (<cfqueryparam value="#ARGUMENTS.tvlsrStatus#" list="yes" cfsqltype="cf_sql_integer">)
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsTVListingSiteRel = StructNew()>
    <cfset rsTVListingSitetRel.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsTVListingSiteRel>
    </cffunction>
    
    <cffunction name="getTVListingDepartmentRel" access="public" returntype="any" hint="Get TV Listing Department Rel. data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="ID" type="numeric" required="yes" default="0">
    <cfargument name="excludeID" type="numeric" required="yes" default="0">
    <cfargument name="tvName" type="string" required="yes" default="">
    <cfargument name="tvlID" type="string" required="yes" default="0">
    <cfargument name="tvlDateRel" type="string" required="yes" default="">
    <cfargument name="tvlDateExp" type="string" required="yes" default="">
    <cfargument name="deptStatus" type="string" required="no" default="1">
    <cfargument name="tvStatus" type="string" required="no" default="1">
    <cfargument name="tvlStatus" type="string" required="yes" default="1,2,3">
    <cfargument name="tvldrStatus" type="string" required="yes" default="1,2,3">
    <cfargument name="orderBy" type="string" required="yes" default="tvName">
    <!---Relationships--->
    <cfargument name="deptNo" type="string" required="yes" default="0">
    <cfset var rsTVListingDepartmentRel = "">
    <cftry>
    <cfquery name="rsTVListingDepartmentRel" datasource="#application.mcmsDSN#">
    SELECT * FROM v_tv_listing_dept_rel WHERE 0=0
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(tvName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(tvDescription) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(deptName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">)
    </cfif>
    <cfif ARGUMENTS.ID NEQ 0>
    AND ID = <cfqueryparam value="#ARGUMENTS.ID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.excludeID NEQ 0>
    AND ID <> <cfqueryparam value="#ARGUMENTS.excludeID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.deptNo NEQ 0>
    AND deptNo IN (<cfqueryparam value="#ARGUMENTS.deptNo#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    <cfif ARGUMENTS.tvlDateRel NEQ "">
    AND tvlDateRel = <cfqueryparam value="#ARGUMENTS.tvlDateRel#" cfsqltype="cf_sql_date">
    </cfif>
    <cfif ARGUMENTS.tvlDateExp NEQ "">
    AND tvlDateExp = <cfqueryparam value="#ARGUMENTS.tvlDateExp#" cfsqltype="cf_sql_date">
    </cfif>
    <cfif ARGUMENTS.tvName NEQ "">
    AND tvName = <cfqueryparam value="#ARGUMENTS.tvName#" cfsqltype="cf_sql_varchar">
    </cfif>
    <cfif ARGUMENTS.tvlID NEQ 0>
    AND tvlID = <cfqueryparam value="#ARGUMENTS.tvlID#" cfsqltype="cf_sql_integer">
    </cfif>
    AND (deptStatus IN (<cfqueryparam value="#ARGUMENTS.deptStatus#" list="yes" cfsqltype="cf_sql_integer">) OR deptStatus IS NULL)
    AND tvStatus IN (<cfqueryparam value="#ARGUMENTS.tvStatus#" list="yes" cfsqltype="cf_sql_integer">)
    AND tvlStatus IN (<cfqueryparam value="#ARGUMENTS.tvlStatus#" list="yes" cfsqltype="cf_sql_integer">)
    AND tvldrStatus IN (<cfqueryparam value="#ARGUMENTS.tvldrStatus#" list="yes" cfsqltype="cf_sql_integer">)
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsTVListingDepartmentRel = StructNew()>
    <cfset rsTVListingDepartmentRel.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsTVListingDepartmentRel>
    </cffunction>
    
    <cffunction name="getTVSpot" access="public" returntype="any" hint="Get TV Spot data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="ID" type="numeric" required="yes" default="0">
    <cfargument name="excludeID" type="numeric" required="yes" default="0">
    <cfargument name="tvsName" type="string" required="yes" default="">
    <cfargument name="tvstID" type="string" required="yes" default="0">
    <cfargument name="tvstStatus" type="string" required="no" default="1">
    <cfargument name="tvsStatus" type="string" required="yes" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="tvsName">
    <cfset var rsTVSpot = "">
    <cftry>
    <cfquery name="rsTVSpot" datasource="#application.mcmsDSN#">
    SELECT * FROM v_tv_spot WHERE 0=0
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(tvsName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(tvsDescription) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">)
    </cfif>
    <cfif ARGUMENTS.ID NEQ 0>
    AND ID = <cfqueryparam value="#ARGUMENTS.ID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.excludeID NEQ 0>
    AND ID <> <cfqueryparam value="#ARGUMENTS.excludeID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.tvsName NEQ "">
    AND tvsName = <cfqueryparam value="#ARGUMENTS.tvsName#" cfsqltype="cf_sql_varchar">
    </cfif>
    <cfif ARGUMENTS.tvstID NEQ 0>
    AND tvstID = <cfqueryparam value="#ARGUMENTS.tvstID#" cfsqltype="cf_sql_integer">
    </cfif>
    AND tvstStatus IN (<cfqueryparam value="#ARGUMENTS.tvstStatus#" list="yes" cfsqltype="cf_sql_integer">)
    AND tvsStatus IN (<cfqueryparam value="#ARGUMENTS.tvsStatus#" list="yes" cfsqltype="cf_sql_integer">)
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsTVSpot = StructNew()>
    <cfset rsTVSpot.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsTVSpot>
    </cffunction>
    
    <cffunction name="getTVSpotType" access="public" returntype="any" hint="Get TV Spot Type data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="ID" type="numeric" required="yes" default="0">
    <cfargument name="excludeID" type="numeric" required="yes" default="0">
    <cfargument name="tvstName" type="string" required="yes" default="">
    <cfargument name="tvstStatus" type="string" required="yes" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="tvstName">
    <cfset var rsTVSpotType = "">
    <cftry>
    <cfquery name="rsTVSpotType" datasource="#application.mcmsDSN#">
    SELECT * FROM v_tv_spot_type WHERE 0=0
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(tvstName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(tvstDescription) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">)
    </cfif>
    <cfif ARGUMENTS.ID NEQ 0>
    AND ID = <cfqueryparam value="#ARGUMENTS.ID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.excludeID NEQ 0>
    AND ID <> <cfqueryparam value="#ARGUMENTS.excludeID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.tvstName NEQ "">
    AND tvstName = <cfqueryparam value="#ARGUMENTS.tvstName#" cfsqltype="cf_sql_varchar">
    </cfif>
    AND tvstStatus IN (<cfqueryparam value="#ARGUMENTS.tvstStatus#" list="yes" cfsqltype="cf_sql_integer">)
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsTVSpotType = StructNew()>
    <cfset rsTVSpotType.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsTVSpotType>
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
    
    <cffunction name="getVendorBrandBind" access="remote" returntype="any" hint="Get Vendor binded Brand data.">
    <cfargument name="ID" type="string" required="yes" default="0">
    <cfargument name="dsn" type="string" required="yes" default="swweb">
    <cftry>
    <cfset data = ''>
	<cfset result = ArrayNew(2)>
    <cfset i = 0>
    <cfquery name="data" datasource="#ARGUMENTS.dsn#">
    SELECT ID, vName FROM (
    SELECT ID, vName
    <cfif ARGUMENTS.ID NEQ 0 AND IsNumeric(ARGUMENTS.ID)> 
    ,CASE WHEN ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ID#" />
    THEN 0 
    ELSE 1 
    END AS Sort
    </cfif>
    FROM v_vendor WHERE 0=0
    AND vStatus IN (<cfqueryparam value="1,3" list="yes" cfsqltype="cf_sql_integer">)) d
    ORDER BY 
    <cfif ARGUMENTS.ID NEQ 0>Sort,</cfif> vName
    </cfquery>
    <cfif data.RecordCount NEQ 0>
    <cfloop index="i" from="1" to="#data.RecordCount#">
    <cfif i EQ 1 AND ARGUMENTS.ID EQ 0>
    <cfset result[i][1] = ''>
    <cfset result[i][2] = "None">
    <cfelseif i EQ 1>
    <cfset result[i][1] = data.ID[i]>
    <cfset result[i][2] = data.vName[i]>
    </cfif>
	<cfset result[i+1][1] = data.ID[i]>
    <cfset result[i+1][2] = data.vName[i]>
    </cfloop>
    </cfif>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset result = StructNew()>
    <cfset result.message = "There was an error with the query.">
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="getBrandVendorBind" access="remote" returntype="any" hint="Get Brand Vendor binded data.">
    <cfargument name="ID" type="string" required="yes" default="0">
    <cfargument name="bID" type="string" required="yes" default="0">
    <cfargument name="dsn" type="string" required="no" default="swweb">
    <cftry>
    <cfset data = ''>
    <cfset result = ArrayNew(2)>
    <cfset i = 0>
    <cfquery name="data" datasource="#ARGUMENTS.dsn#">
    SELECT bID, vID, bName FROM (
    SELECT bID, vID, bName
    <cfif ARGUMENTS.bID NEQ 0 AND IsNumeric(ARGUMENTS.bID)>
    ,CASE WHEN bID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.bID#" />
    THEN 0 
    ELSE 1 
    END AS Sort
    </cfif>
    FROM v_brand_vendor_rel WHERE 0=0
    <cfif ARGUMENTS.ID NEQ 0 AND IsNumeric(ARGUMENTS.ID)>
    AND vID = <cfqueryparam value="#ARGUMENTS.ID#" cfsqltype="cf_sql_integer">
    <cfelse>
    AND 0=1
    </cfif>
    AND bvrStatus IN (<cfqueryparam value="1,3" list="yes" cfsqltype="cf_sql_integer">)) d
    ORDER BY 
    <cfif ARGUMENTS.bID NEQ 0>Sort,</cfif> bName
    </cfquery>
    <cfif data.RecordCount EQ 0>
    <cfset result[1][1] = ''>
    <cfset result[1][2] = 'None'>
    <cfelse>
    <cfset result[1][1] = ''>
    <cfset result[1][2] = 'Select a Brand...'>
    <cfloop index="i" from="1" to="#data.RecordCount#">
	<cfset result[i][1] = data.bID[i]>
    <cfset result[i][2] = data.bName[i]>
    </cfloop>
    </cfif>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset result = StructNew()>
    <cfset result.message = "There was an error with the query.">
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="getTVReport" access="public" returntype="query" hint="Get TV Report data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="orderBy" type="string" required="yes" default="tvName">
    <cfset var rsTV = "" >
    <cfquery name="rsTV" datasource="#application.mcmsDSN#">
    SELECT tvName AS Name, TO_CHAR(tvDescription) AS Description, TO_CHAR(tvDateUpdate,'MM/DD/YYYY') AS Update_Date, sName AS Status FROM v_tv WHERE 0=0
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(tvName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(tvDescription) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">)
    </cfif>
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <cfreturn rsTV>
    </cffunction>
    
    <cffunction name="getTVSpotReport" access="public" returntype="query" hint="Get TV Spot Report data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="orderBy" type="string" required="yes" default="tvsName">
    <cfset var rsTV = "" >
    <cfquery name="rsTV" datasource="#application.mcmsDSN#">
    SELECT tvsName AS Name, TO_CHAR(tvsDescription) AS Description, tvstName AS Type, TO_CHAR(tvsDateRel,'MM/DD/YYYY') AS Release_Date, TO_CHAR(tvsDateExp,'MM/DD/YYYY') AS Exp_Date, TO_CHAR(tvsDateUpdate,'MM/DD/YYYY') AS Update_Date, tvsPath, tvsSourceURL, tvsSourceID, tvsDuration AS Duration_Seconds, vName AS Vendor, bName AS Brand, imgFile AS Image_File, sName AS Status FROM v_tv_spot WHERE 0=0
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(tvsName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(tvsDescription) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">)
    </cfif>
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <cfreturn rsTV>
    </cffunction>
    
    <cffunction name="getTVListingReport" access="public" returntype="query" hint="Get TV Listing Report data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="orderBy" type="string" required="yes" default="tvName">
    <cfset var rsTV = "" >
    <cfquery name="rsTV" datasource="#application.mcmsDSN#">
    SELECT tvsName AS Name, tvName AS TV, TO_CHAR(tvsDescription) AS Description, tvstName AS Type, TO_CHAR(tvsDateRel,'MM/DD/YYYY') AS Release_Date, TO_CHAR(tvsDateExp,'MM/DD/YYYY') AS Exp_Date, TO_CHAR(tvsDateUpdate,'MM/DD/YYYY') AS Update_Date, tvsPath, tvsSourceURL, tvsSourceID, tvsDuration AS Duration_Seconds, vName AS Vendor, bName AS Brand, imgFile AS Image_File, sortName AS Sort, sName AS Status FROM v_tv_listing WHERE 0=0
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(tvName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(tvsName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(tvsDescription) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">)
    </cfif>
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <cfreturn rsTV>
    </cffunction>
    
    <cffunction name="insertTV" access="public" returntype="struct">
    <cfargument name="tvName" type="string" required="yes">
    <cfargument name="tvDescription" type="string" required="yes">
    <cfargument name="tvIPAddress" type="numeric" required="yes">
    <cfargument name="tvStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully inserted the record.">
    <cftry>
    <!---Check for profanity in the text.--->
    <cfinvoke 
    component="MCMS.component.utility.Regex"
    method="regexProfanity"
    returnvariable="regexProfanityRet">
    <cfinvokeargument name="profanityString" value="#ARGUMENTS.tvDescription#"/>
    </cfinvoke>
    <!---Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.app.tv.TV"
    method="getTV"
    returnvariable="getCheckTVRet">
    <cfinvokeargument name="tvName" value="#ARGUMENTS.tvName#"/>
    <cfinvokeargument name="tvIPAddress" value="#ARGUMENTS.tvIPAddress#"/>
    <cfinvokeargument name="tvStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckTVRet.recordcount NEQ 0>
    <cfset result.message = "The name #ARGUMENTS.tvName# already exists, please try again.">
    <cfelseif regexProfanityRet CONTAINS '$%&*!'>
    <cfset result.message = "Some text contained profanity, please remove any profanity from your text.">
    <!---Check length restriction.--->
    <cfelseif LEN(ARGUMENTS.tvDescription) GT 255>
    <cfset result.message = "The description is longer than 255 characters, please enter a new description under 255 characters.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    INSERT INTO tbl_tv (tvName,tvDescription,tvIPAddress,userID,tvStatus) VALUES
    (
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.tvName#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.tvDescription#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.tvIPAddress#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#session.userID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.tvStatus#">
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
    
    <cffunction name="insertTVSpot" access="public" returntype="struct">
    <cfargument name="tvsName" type="string" required="yes">
    <cfargument name="tvsDescription" type="string" required="yes">
    <cfargument name="tvsDateRel" type="string" required="yes">
    <cfargument name="tvsDateExp" type="string" required="yes">
    <cfargument name="tvsPath" type="string" required="yes" default="none">
    <cfargument name="tvsSourceURL" type="string" required="yes" default="none">
    <cfargument name="tvsSourceID" type="string" required="yes" default="none">
    <cfargument name="tvsDuration" type="numeric" required="yes" default="none">
    <cfargument name="vID" type="string" required="yes">
    <cfargument name="bID" type="string" required="yes">
    <cfargument name="imgID" type="numeric" required="yes">
    <cfargument name="tvstID" type="numeric" required="yes">
    <cfargument name="tvsStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully inserted the record.">
    <cftry>
    <!---Check for profanity in the text.--->
    <cfinvoke 
    component="MCMS.component.utility.Regex"
    method="regexProfanity"
    returnvariable="regexProfanityRet">
    <cfinvokeargument name="profanityString" value="#ARGUMENTS.tvsDescription#"/>
    </cfinvoke>
    <!---Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.app.tv.TV"
    method="getTVSpot"
    returnvariable="getCheckTVSpotRet">
    <cfinvokeargument name="tvsName" value="#ARGUMENTS.tvsName#"/>
    <cfinvokeargument name="tvsStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckTVSpotRet.recordcount NEQ 0>
    <cfset result.message = "The name #ARGUMENTS.tvsName# already exists, please try again.">
    <cfelseif regexProfanityRet CONTAINS '$%&*!'>
    <cfset result.message = "Some text contained profanity, please remove any profanity from your text.">
    <!---Check length restriction.--->
    <cfelseif LEN(ARGUMENTS.tvsDescription) GT 255>
    <cfset result.message = "The description is longer than 255 characters, please enter a new description under 255 characters.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    INSERT INTO tbl_tv_spot (tvsName,tvsDescription,tvsDateRel,tvsDateExp,tvsPath,tvsSourceURL,tvsSourceID,tvsDuration,vID,bID,imgID,userID,tvstID,tvsStatus) VALUES
    (
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.tvsName#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.tvsDescription#">,
    <cfqueryparam cfsqltype="cf_sql_date" value="#ARGUMENTS.tvsDateRel#">,
    <cfqueryparam cfsqltype="cf_sql_date" value="#ARGUMENTS.tvsDateExp#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#Iif(ARGUMENTS.tvsPath EQ '', DE('none'), DE(ARGUMENTS.tvsPath))#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#Iif(ARGUMENTS.tvsSourceURL EQ '', DE('none'), DE(ARGUMENTS.tvsSourceURL))#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#Iif(ARGUMENTS.tvsSourceID EQ '', DE('none'), DE(ARGUMENTS.tvsSourceID))#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.tvsDuration#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#Iif(ARGUMENTS.vID EQ '', DE('0'), DE(ARGUMENTS.vID))#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#Iif(ARGUMENTS.bID EQ '', DE('0'), DE(ARGUMENTS.bID))#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.imgID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#session.userID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.tvstID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.tvsStatus#">
    )
    </cfquery>
    </cftransaction>
    <!--- Get newly inserted task ID. --->
    <cfinvoke 
    component="MCMS.component.cms.Cms"
    method="getMaxValueSQL"
    returnvariable="tvsID">
    <cfinvokeargument name="tableName" value="tbl_tv_spot"/>
    </cfinvoke>
    <!---Redirect if it is an Ad spot.--->
    <cfif ARGUMENTS.tvstID EQ 2>
    <cfset result.message = "You have successfully inserted the record. You will now be redirected to complete the TV spot.">
    <!---Forward to update form.--->
    <cfset ajaxOnLoad("function() {
    lAjax('layoutIndex', #url.appID#, 'TVSpot' ,'/#application.mcmsAppAdminPath#/tv/view/inc_tv_spot.cfm','TV Spot','update', #tvsID#);
    }")>
    </cfif>
    </cfif>
    <cfcatch type="any">
    <cfset result.message = "There was an error inserting the record.">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="insertTVListing" access="public" returntype="struct">
    <cfargument name="tvID" type="numeric" required="yes">
    <cfargument name="tvsID" type="numeric" required="yes">
    <cfargument name="tvlStatus" type="numeric" required="yes">
    <!---Include relationships.--->
    <cfargument name="siteNo" type="string" required="yes">
    <cfargument name="deptNo" type="string" required="yes">
    <cfset result.message = "You have successfully inserted the record. You will now be redirected to complete the TV Listing.">
    <cftry>
    <!---Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.app.tv.TV"
    method="getTVListing"
    returnvariable="getCheckTVListingRet">
    <cfinvokeargument name="tvID" value="#ARGUMENTS.tvID#"/>
    <cfinvokeargument name="tvsID" value="#ARGUMENTS.tvsID#"/>
    <cfinvokeargument name="tvlStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckTVListingRet.recordcount NEQ 0>
    <cfset result.message = "The tv listing already exists for this spot on this TV, please try again.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    INSERT INTO tbl_tv_listing (tvID, tvsID, tvlSort, tvlStatus) VALUES
    (
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.tvID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.tvsID#">,
    <!---Set the listing sort to '0' so it isn't added until the sort is chosen.--->
    <cfqueryparam cfsqltype="cf_sql_integer" value="0">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.tvlStatus#">
    )
    </cfquery>
    <!---Get latest TV Listing.--->
    <cfinvoke 
    component="MCMS.component.cms.Cms"
    method="getMaxValueSQL"
    returnvariable="tvlID">
    <cfinvokeargument name="tableName" value="tbl_tv_listing"/>
    </cfinvoke>
    <cfset var.tvlID = tvlID>
    <!---Insert site relationships.--->
    <cfloop list="#ARGUMENTS.siteNo#" index="i">
    <cfinvoke 
    component="MCMS.component.app.tv.TV"
    method="insertTVListingSiteRel">
    <cfinvokeargument name="tvlID" value="#var.tvlID#"/>
    <cfinvokeargument name="siteNo" value="#i#"/>
    <cfinvokeargument name="tvlsrStatus" value="1"/>
    </cfinvoke>
    </cfloop>
    <!---Insert department relationships.--->
    <cfloop list="#ARGUMENTS.deptNo#" index="i">
    <cfinvoke 
    component="MCMS.component.app.tv.TV"
    method="insertTVListingDepartmentRel">
    <cfinvokeargument name="tvlID" value="#var.tvlID#"/>
    <cfinvokeargument name="deptNo" value="#i#"/>
    <cfinvokeargument name="tvldrStatus" value="1"/>
    </cfinvoke>
    </cfloop>
    </cftransaction>
    <!---Forward to update form.--->
    <cfset ajaxOnLoad("function() {
    lAjax('layoutIndex', #url.appID#, 'TVListing' ,'/#application.mcmsAppAdminPath#/tv/view/inc_tv_listing.cfm','TV Listing','update', #tvlID#);
    }")>
    </cfif>
    <cfcatch type="any">
    <cfset result.message = "There was an error inserting the record.">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="insertTVListingSiteRel" access="public" returntype="struct">
    <cfargument name="tvlID" type="numeric" required="yes">
    <cfargument name="siteNo" type="numeric" required="yes">
    <cfargument name="tvlsrStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully inserted the record.">
    <cftry>
    <cfinvoke 
    component="MCMS.component.app.tv.TV"
    method="getTVListingSiteRel"
    returnvariable="getCheckTVListingSiteRelRet">
    <cfinvokeargument name="tvlID" value="#ARGUMENTS.tvlID#"/>
    <cfinvokeargument name="siteNo" value="#ARGUMENTS.siteNo#"/>
    <cfinvokeargument name="tvlsrStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckTVListingSiteRelRet.recordcount EQ 0>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    INSERT INTO tbl_tv_listing_site_rel (tvlID,siteNo,tvlsrStatus) VALUES
    (
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.tvlID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.siteNo#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.tvlsrStatus#">
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
    
    <cffunction name="insertTVListingDepartmentRel" access="public" returntype="struct">
    <cfargument name="tvlID" type="numeric" required="yes">
    <cfargument name="deptNo" type="numeric" required="yes">
    <cfargument name="tvldrStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully inserted the record.">
    <cftry>
    <cfinvoke 
    component="MCMS.component.app.tv.TV"
    method="getTVListingDepartmentRel"
    returnvariable="getCheckTVListingDepartmentRelRet">
    <cfinvokeargument name="tvlID" value="#ARGUMENTS.tvlID#"/>
    <cfinvokeargument name="deptNo" value="#ARGUMENTS.deptNo#"/>
    <cfinvokeargument name="tvldrStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckTVListingDepartmentRelRet.recordcount EQ 0>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    INSERT INTO tbl_tv_listing_dept_rel (tvlID,deptNo,tvldrStatus) VALUES
    (
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.tvlID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.deptNo#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.tvldrStatus#">
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
    
    <cffunction name="insertTVImageRel" access="public" returntype="struct">
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
    <cfinvokeargument name="imgtID" value="#application.tvSpotImageType#">
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
	UPDATE tbl_tv_spot SET
    imgID = <cfqueryparam cfsqltype="cf_sql_integer" value="#var.imgID#">,
    tvsDateUpdate = <cfqueryparam cfsqltype="cf_sql_timestamp" value="#Now()#">,
    userID = <cfqueryparam cfsqltype="cf_sql_integer" value="#session.userID#">
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
    
    <cffunction name="updateTV" access="public" returntype="struct">
    <cfargument name="ID" type="numeric" required="yes">
    <cfargument name="tvName" type="string" required="yes">
    <cfargument name="tvDescription" type="string" required="yes">
    <cfargument name="tvIPAddress" type="numeric" required="yes">
    <cfargument name="tvStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully updated the record.">
    <cftry>
    <!---Check for profanity in the text.--->
    <cfinvoke 
    component="MCMS.component.utility.Regex"
    method="regexProfanity"
    returnvariable="regexProfanityRet">
    <cfinvokeargument name="profanityString" value="#ARGUMENTS.tvDescription#"/>
    </cfinvoke>
    <!---Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.app.tv.TV"
    method="getTV"
    returnvariable="getCheckTVRet">
    <cfinvokeargument name="excludeID" value="#ARGUMENTS.ID#"/>
    <cfinvokeargument name="tvName" value="#ARGUMENTS.tvName#"/>
    <cfinvokeargument name="tvIPAddress" value="#ARGUMENTS.tvIPAddress#"/>
    <cfinvokeargument name="tvStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckTVRet.recordcount NEQ 0>
    <cfset result.message = "The name #ARGUMENTS.tvName# already exists, please try again.">
    <cfelseif regexProfanityRet CONTAINS '$%&*!'>
    <cfset result.message = "Some text contained profanity, please remove any profanity from your text.">
    <!---Check length restriction.--->
    <cfelseif LEN(ARGUMENTS.tvDescription) GT 255>
    <cfset result.message = "The description is longer than 255 characters, please enter a new description under 255 characters.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_tv SET
    tvName = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.tvName#">,
    tvDescription = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.tvDescription#">,
    tvIPAddress = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.tvIPAddress#">,
    tvDateUpdate = <cfqueryparam cfsqltype="cf_sql_timestamp" value="#Now()#">,
    userID = <cfqueryparam cfsqltype="cf_sql_integer" value="#session.userID#">,
    tvStatus = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.tvStatus#">
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
    
    <cffunction name="updateTVSpot" access="public" returntype="struct">
    <cfargument name="ID" type="numeric" required="yes">
    <cfargument name="tvsName" type="string" required="yes">
    <cfargument name="tvsDescription" type="string" required="yes">
    <cfargument name="tvsDateRel" type="string" required="yes">
    <cfargument name="tvsDateExp" type="string" required="yes">
    <cfargument name="tvsPath" type="string" required="yes" default="none">
    <cfargument name="tvsSourceURL" type="string" required="yes" default="none">
    <cfargument name="tvsSourceID" type="string" required="yes" default="none">
    <cfargument name="tvsDuration" type="numeric" required="yes">
    <cfargument name="vID" type="string" required="yes">
    <cfargument name="bID" type="string" required="yes">
    <cfargument name="imgID" type="numeric" required="yes">
    <cfargument name="tvsStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully updated the record.">
    <cftry>
    <!---Check for profanity in the text.--->
    <cfinvoke 
    component="MCMS.component.utility.Regex"
    method="regexProfanity"
    returnvariable="regexProfanityRet">
    <cfinvokeargument name="profanityString" value="#ARGUMENTS.tvsDescription#"/>
    </cfinvoke>
    <!---Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.app.tv.TV"
    method="getTVSpot"
    returnvariable="getCheckTVSpotRet">
    <cfinvokeargument name="excludeID" value="#ARGUMENTS.ID#"/>
    <cfinvokeargument name="tvsName" value="#ARGUMENTS.tvsName#"/>
    <cfinvokeargument name="tvsStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckTVSpotRet.recordcount NEQ 0>
    <cfset result.message = "The name #ARGUMENTS.tvsName# already exists, please try again.">
    <cfelseif regexProfanityRet CONTAINS '$%&*!'>
    <cfset result.message = "Some text contained profanity, please remove any profanity from your text.">
    <!---Check length restriction.--->
    <cfelseif LEN(ARGUMENTS.tvsDescription) GT 255>
    <cfset result.message = "The description is longer than 255 characters, please enter a new description under 255 characters.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_tv_spot SET
    tvsName = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.tvsName#">,
    tvsDescription = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.tvsDescription#">,
    tvsDateRel = <cfqueryparam cfsqltype="cf_sql_date" value="#ARGUMENTS.tvsDateRel#">,
    tvsDateExp = <cfqueryparam cfsqltype="cf_sql_date" value="#ARGUMENTS.tvsDateExp#">,
    tvsDateUpdate = <cfqueryparam cfsqltype="cf_sql_timestamp" value="#Now()#">,
    tvsPath = <cfqueryparam cfsqltype="cf_sql_varchar" value="#Iif(ARGUMENTS.tvsPath EQ '', DE('none'), DE(ARGUMENTS.tvsPath))#">,
    tvsSourceURL = <cfqueryparam cfsqltype="cf_sql_varchar" value="#Iif(ARGUMENTS.tvsSourceURL EQ '', DE('none'), DE(ARGUMENTS.tvsSourceURL))#">,
    tvsSourceID = <cfqueryparam cfsqltype="cf_sql_varchar" value="#Iif(ARGUMENTS.tvsSourceID EQ '', DE('none'), DE(ARGUMENTS.tvsSourceID))#">,
    tvsDuration = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.tvsDuration#">,
    vID = <cfqueryparam cfsqltype="cf_sql_integer" value="#Iif(ARGUMENTS.vID EQ '', DE('0'), DE(ARGUMENTS.vID))#">,
    bID = <cfqueryparam cfsqltype="cf_sql_integer" value="#Iif(ARGUMENTS.bID EQ '', DE('0'), DE(ARGUMENTS.bID))#">,
    imgID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.imgID#">,
    userID = <cfqueryparam cfsqltype="cf_sql_integer" value="#session.userID#">,
    tvsStatus = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.tvsStatus#">
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
    
    <cffunction name="updateTVListing" access="public" returntype="struct">
    <cfargument name="ID" type="numeric" required="yes">
    <cfargument name="tvlSort" type="string" required="yes">
    <cfargument name="tvlStatus" type="numeric" required="yes">
    <!---Include relationships.--->
    <cfargument name="siteNo" type="string" required="yes">
    <cfargument name="deptNo" type="string" required="yes">
    <cfset result.message = "You have successfully updated the record.">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_tv_listing SET
    tvlStatus = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.tvlStatus#">
    WHERE ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ID#">
    </cfquery>
    <!---Now manage sort order.--->
    <cfset loopcount = 0>
    <cfloop list="#ARGUMENTS.tvlSort#" index="i">
    <cfset loopcount = loopcount+1>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_tv_listing SET
    tvlSort = <cfqueryparam cfsqltype="cf_sql_integer" value="#loopcount#">
    WHERE ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#i#">
    </cfquery>
    </cfloop>
    <!---Update relationships.--->
    <!---First delete records.--->
    <cfinvoke 
    component="MCMS.component.app.tv.TV"
    method="deleteTVListingSiteRel">
    <cfinvokeargument name="tvlID" value="#ARGUMENTS.ID#"/>
    </cfinvoke>
    <cfinvoke 
    component="MCMS.component.app.tv.TV"
    method="deleteTVListingDepartmentRel">
    <cfinvokeargument name="tvlID" value="#ARGUMENTS.ID#"/>
    </cfinvoke>
    <!---Insert site relationships.--->
    <cfloop list="#ARGUMENTS.siteNo#" index="i">
    <cfinvoke 
    component="MCMS.component.app.tv.TV"
    method="insertTVListingSiteRel">
    <cfinvokeargument name="tvlID" value="#ARGUMENTS.ID#"/>
    <cfinvokeargument name="siteNo" value="#i#"/>
    <cfinvokeargument name="tvlsrStatus" value="1"/>
    </cfinvoke>
    </cfloop>
    <!---Insert department relationships.--->
    <cfloop list="#ARGUMENTS.deptNo#" index="i">
    <cfinvoke 
    component="MCMS.component.app.tv.TV"
    method="insertTVListingDepartmentRel">
    <cfinvokeargument name="tvlID" value="#ARGUMENTS.ID#"/>
    <cfinvokeargument name="deptNo" value="#i#"/>
    <cfinvokeargument name="tvldrStatus" value="1"/>
    </cfinvoke>
    </cfloop>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error updating the record.">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="updateTVList" access="public" returntype="struct">
    <cfargument name="ID" type="numeric" required="yes">
    <cfargument name="tvStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully updated the records.">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_tv SET
    tvStatus = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.tvStatus#">
    WHERE ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ID#">
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error updating the records.">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="updateTVSpotList" access="public" returntype="struct">
    <cfargument name="ID" type="numeric" required="yes">
    <cfargument name="tvsStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully updated the records.">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_tv_spot SET
    tvsStatus = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.tvsStatus#">
    WHERE ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ID#">
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error updating the records.">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="updateTVListingList" access="public" returntype="struct">
    <cfargument name="ID" type="numeric" required="yes">
    <cfargument name="tvlStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully updated the records.">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_tv_listing SET
    tvlStatus = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.tvlStatus#">
    WHERE ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ID#">
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error updating the records.">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="deleteTV" access="public" returntype="struct">
    <cfargument name="ID" type="string" required="yes">
    <cfset result.message = "You have successfully deleted the record(s).">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    DELETE FROM tbl_tv
    WHERE ID IN (<cfqueryparam cfsqltype="cf_sql_integer" list="yes" value="#ARGUMENTS.ID#">)
    </cfquery>
    </cftransaction>
    <cfinvoke 
    component="MCMS.component.app.tv.TV"
    method="deleteTVListing">
    <cfinvokeargument name="tvID" value="#ARGUMENTS.ID#"/>
    </cfinvoke>
    <cfcatch type="any">
    <cfset result.message = "There was an error deleting the record(s).">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="deleteTVSpot" access="public" returntype="struct">
    <cfargument name="ID" type="string" required="yes">
    <cfset result.message = "You have successfully deleted the record(s).">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    DELETE FROM tbl_tv_spot
    WHERE ID IN (<cfqueryparam cfsqltype="cf_sql_integer" list="yes" value="#ARGUMENTS.ID#">)
    </cfquery>
    </cftransaction>
    <cfinvoke 
    component="MCMS.component.app.tv.TV"
    method="deleteTVListing">
    <cfinvokeargument name="tvsID" value="#ARGUMENTS.ID#"/>
    </cfinvoke>
    <cfcatch type="any">
    <cfset result.message = "There was an error deleting the record(s).">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="deleteTVListing" access="public" returntype="struct">
    <cfargument name="ID" type="string" required="yes" default="0">
    <cfargument name="tvID" type="numeric" required="yes" default="0">
    <cfargument name="tvsID" type="numeric" required="yes" default="0">
    <cfset result.message = "You have successfully deleted the record(s).">
    <cftry>
    <cftransaction>
    <cfif ARGUMENTS.tvID NEQ 0 OR ARGUMENTS.tvsID NEQ 0>
    <cfquery name="getTVListingID" datasource="#application.mcmsDSN#">
    SELECT ID FROM tbl_tv_listing
    WHERE tvID IN (<cfqueryparam cfsqltype="cf_sql_integer" list="yes" value="#ARGUMENTS.tvID#">)
    OR tvsID IN (<cfqueryparam cfsqltype="cf_sql_integer" list="yes" value="#ARGUMENTS.tvsID#">)
    </cfquery>
    <cfset ARGUMENTS.ID = ValueList(getTVListingID.ID)>
    </cfif>
    <cfquery datasource="#application.mcmsDSN#">
    DELETE FROM tbl_tv_listing
    WHERE ID IN (<cfqueryparam cfsqltype="cf_sql_integer" list="yes" value="#ARGUMENTS.ID#">)
    </cfquery>
    <cfinvoke 
    component="MCMS.component.app.tv.TV"
    method="deleteTVListingSiteRel">
    <cfinvokeargument name="tvlID" value="#ARGUMENTS.ID#"/>
    </cfinvoke>
    <cfinvoke 
    component="MCMS.component.app.tv.TV"
    method="deleteTVListingDepartmentRel">
    <cfinvokeargument name="tvlID" value="#ARGUMENTS.ID#"/>
    </cfinvoke>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error deleting the record(s).">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction> 
    
    <cffunction name="deleteTVListingSiteRel" access="public" returntype="struct">
    <cfargument name="ID" type="string" required="yes" default="0">
    <cfargument name="tvlID" type="string" required="yes" default="0">
    <cfset result.message = "You have successfully deleted the record(s).">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    DELETE FROM tbl_tv_listing_site_rel
    WHERE ID IN (<cfqueryparam cfsqltype="cf_sql_integer" list="yes" value="#ARGUMENTS.ID#">)
    OR tvlID IN (<cfqueryparam cfsqltype="cf_sql_integer" list="yes" value="#ARGUMENTS.tvlID#">)
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error deleting the record(s).">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="deleteTVListingDepartmentRel" access="public" returntype="struct">
    <cfargument name="ID" type="string" required="yes" default="0">
    <cfargument name="tvlID" type="string" required="yes" default="0">
    <cfset result.message = "You have successfully deleted the record(s).">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    DELETE FROM tbl_tv_listing_dept_rel
    WHERE ID IN (<cfqueryparam cfsqltype="cf_sql_integer" list="yes" value="#ARGUMENTS.ID#">)
    OR tvlID IN (<cfqueryparam cfsqltype="cf_sql_integer" list="yes" value="#ARGUMENTS.tvlID#">)
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error deleting the record(s).">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="deleteTVImageRel" access="public" returntype="struct">
    <cfargument name="ID" type="numeric" required="yes" default="0">
    <cfset result.message = "You have successfully updated the record.">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_tv_spot SET
    imgID = <cfqueryparam cfsqltype="cf_sql_integer" value="0"> 
    WHERE ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ID#">
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error updating the record.">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction> 
</cfcomponent>