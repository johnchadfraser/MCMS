<cfcomponent>
    <cffunction name="getVendor" access="public" returntype="query" hint="Get Vendor data."> 
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="ID" type="numeric" required="yes" default="0">
    <cfargument name="excludeID" type="numeric" required="yes" default="0">
    <cfargument name="vID" type="numeric" required="yes" default="1">
    <cfargument name="vName" type="string" required="yes" default="">
    <cfargument name="vStatus" type="string" required="yes" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="vName">
    <cfset var rsVendor = "" >
    <cftry>
    <cfquery name="rsVendor" datasource="#application.mcmsDSN#">
    SELECT * FROM v_vendor WHERE 0=0
    <cfif ARGUMENTS.ID NEQ 0>
    AND ID = <cfqueryparam value="#ARGUMENTS.ID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.excludeID NEQ 0>
    AND ID <> <cfqueryparam value="#ARGUMENTS.excludeID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(vName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(vDescription) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">
    OR vendorID LIKE <cfqueryparam value="%#ARGUMENTS.keywords#%" cfsqltype="cf_sql_varchar">)
    </cfif>
    <cfif ARGUMENTS.vID NEQ 1>
    AND ID = <cfqueryparam value="#ARGUMENTS.vID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.vName NEQ "">
    AND UPPER(vName) = <cfqueryparam value="#UCASE(ARGUMENTS.vName)#" cfsqltype="cf_sql_varchar">
    </cfif>
    AND vStatus IN (<cfqueryparam value="#ARGUMENTS.vStatus#" list="yes" cfsqltype="cf_sql_integer">)
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsVendor = StructNew()>
    <cfset rsVendor.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsVendor>
    </cffunction>
    
    <cffunction name="getVendorDepartmentRel" access="public" returntype="query" hint="Get Vendor Department Rel. data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="ID" type="numeric" required="yes" default="0">
    <cfargument name="excludeID" type="numeric" required="yes" default="0">
    <cfargument name="vID" type="string" required="yes" default="0">
    <cfargument name="deptNo" type="string" required="yes" default="0">
    <cfargument name="vName" type="string" required="yes" default="">
    <cfargument name="vStatus" type="string" required="yes" default="1,3">
    <cfargument name="vdrStatus" type="string" required="yes" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="vName">
    <cfset var rsVendorDepartmentRel = "" >
    <cftry>
    <cfquery name="rsVendorDepartmentRel" datasource="#application.mcmsDSN#">
    SELECT * FROM v_vendor_department_rel WHERE 0=0
    <cfif ARGUMENTS.ID NEQ 0>
    AND ID = <cfqueryparam value="#ARGUMENTS.ID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.excludeID NEQ 0>
    AND ID <> <cfqueryparam value="#ARGUMENTS.excludeID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(vName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(vDescription) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">)
    </cfif>
    <cfif ARGUMENTS.vID NEQ 0>
    AND vID IN (<cfqueryparam value="#ARGUMENTS.vID#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    <cfif ARGUMENTS.deptNo NEQ 0>
    AND deptNo IN (<cfqueryparam value="#ARGUMENTS.deptNo#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    <cfif ARGUMENTS.vName NEQ "">
    AND UPPER(vName) = <cfqueryparam value="#UCASE(ARGUMENTS.vName)#" cfsqltype="cf_sql_varchar">
    </cfif>
    AND vStatus IN (<cfqueryparam value="#ARGUMENTS.vStatus#" list="yes" cfsqltype="cf_sql_integer">)
    AND vdrStatus IN (<cfqueryparam value="#ARGUMENTS.vdrStatus#" list="yes" cfsqltype="cf_sql_integer">)
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsVendorDepartmentRel = StructNew()>
    <cfset rsVendorDepartmentRel.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsVendorDepartmentRel>
    </cffunction>
    
    <cffunction name="getVendorBind" access="remote" returntype="string">
    <cfargument name="keywords" type="string" required="yes" default="">
    <cfargument name="siteDSN" type="string" required="yes" default="">
    <cfargument name="vStatus" type="string" required="yes" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="vName">
    <cfset var rsBind = "" >
    <cfquery name="rsBind" datasource="#ARGUMENTS.mcmsDSN#">
    SELECT vName AS vName FROM v_vendor WHERE 0=0
    AND UPPER(vName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">
    AND vStatus IN (<cfqueryparam value="#ARGUMENTS.vStatus#" list="yes" cfsqltype="cf_sql_integer">)
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <cfif rsBind.recordcount NEQ 0>
    <cfset IDList = ValueList(rsBind.vName, ',') & ",none">
    <cfelse>
    <cfset IDList = ''>
    </cfif>
    <cfreturn IDList>
    </cffunction>
    
    <cffunction name="getVendorContactBind" access="remote" returntype="string">
    <cfargument name="keywords" type="string" required="yes" default="">
    <cfargument name="siteDSN" type="string" required="yes" default="">
    <cfargument name="vStatus" type="string" required="yes" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="vclName">
    <cfset var rsBind = "" >
    <cfquery name="rsBind" datasource="#ARGUMENTS.mcmsDSN#">
    SELECT vcfName || ' ' || vclName  || ' - ' || vName AS vcName FROM v_vendor_contact WHERE 0=0
    AND (UPPER(vcLName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(vcFName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">)
    AND vcStatus IN (<cfqueryparam value="#ARGUMENTS.vStatus#" list="yes" cfsqltype="cf_sql_integer">)
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <cfif rsBind.recordcount NEQ 0>
    <cfset IDList = ValueList(rsBind.vcName, ',') & ",none">
    <cfelse>
    <cfset IDList = ''>
    </cfif>
    <cfreturn IDList>
    </cffunction>
    
    <cffunction name="getVendorBrandBind" access="remote" returntype="any" hint="Get Vendor binded Brand data.">
    <cfargument name="ID" type="string" required="yes" default="0">
    <cfargument name="siteDSN" type="string" required="yes" default="">
    <cftry>
    <cfset data = ''>
	<cfset result = ArrayNew(2)>
    <cfset i = 0>
    <cfquery name="data" datasource="#ARGUMENTS.mcmsDSN#">
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
    <cfset result[i][2] = "Type in a vendor name and hit 'Enter'...">
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
    <cfargument name="siteDSN" type="string" required="yes" default="">
    <cftry>
    <cfset data = ''>
    <cfset result = ArrayNew(2)>
    <cfset i = 0>
    <cfquery name="data" datasource="#ARGUMENTS.mcmsDSN#">
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
    <cfset result[1][2] = 'Select a Vendor first...'>
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
    
    <cffunction name="getVendorContact" access="public" returntype="query" hint="Get Vendor Contact data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="ID" type="numeric" required="yes" default="0">
    <cfargument name="excludeID" type="numeric" required="yes" default="0">
    <cfargument name="vID" type="string" required="yes" default="1">
    <cfargument name="vcName" type="string" required="yes" default="">
    <cfargument name="vStatus" type="string" required="yes" default="1">
    <cfargument name="vcStatus" type="string" required="yes" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="vcfName">
    <cfset var rsVendorContact = "" >
    <cftry>
    <cfquery name="rsVendorContact" datasource="#application.mcmsDSN#">
    SELECT * FROM v_vendor_contact WHERE 0=0
    <cfif ARGUMENTS.ID NEQ 0>
    AND ID = <cfqueryparam value="#ARGUMENTS.ID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.excludeID NEQ 0>
    AND ID <> <cfqueryparam value="#ARGUMENTS.excludeID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(vName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR vendorID LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(vcfName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">  OR UPPER(vclName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">)
    </cfif>
    <cfif ARGUMENTS.vID NEQ 1>
    AND vID IN (<cfqueryparam value="#ARGUMENTS.vID#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    <cfif ARGUMENTS.vcName NEQ "">
    AND UPPER(vcName) = <cfqueryparam value="#UCASE(ARGUMENTS.vcName)#" cfsqltype="cf_sql_varchar">
    </cfif>
    AND vStatus IN (<cfqueryparam value="#ARGUMENTS.vStatus#" list="yes" cfsqltype="cf_sql_integer">)
    AND vcStatus IN (<cfqueryparam value="#ARGUMENTS.vcStatus#" list="yes" cfsqltype="cf_sql_integer">)
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsVendorContact = StructNew()>
    <cfset rsVendorContact.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsVendorContact>
    </cffunction>
    
    <cffunction name="getBrand" access="public" returntype="query" hint="Get Brand data."> 
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="ID" type="numeric" required="yes" default="0">
    <cfargument name="bID" type="numeric" required="yes" default="1">
    <cfargument name="excludeID" type="numeric" required="yes" default="0">
    <cfargument name="bName" type="string" required="yes" default="">
    <cfargument name="bStatus" type="string" required="yes" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="bName">
    <cfset var rsBrand = "" >
    <cftry>
    <cfquery name="rsBrand" datasource="#application.mcmsDSN#">
    SELECT * FROM v_brand WHERE 0=0
    <cfif ARGUMENTS.ID NEQ 0>
    AND ID = <cfqueryparam value="#ARGUMENTS.ID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.excludeID NEQ 0>
    AND ID <> <cfqueryparam value="#ARGUMENTS.excludeID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(bName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(bDescription) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">)
    </cfif>
    <cfif ARGUMENTS.bID NEQ 1>
    AND ID = <cfqueryparam value="#ARGUMENTS.bID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.bName NEQ "">
    AND UPPER(bName) = <cfqueryparam value="#UCASE(ARGUMENTS.bName)#" cfsqltype="cf_sql_varchar">
    </cfif>
    AND bStatus IN (<cfqueryparam value="#ARGUMENTS.bStatus#" list="yes" cfsqltype="cf_sql_integer">)
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsBrand = StructNew()>
    <cfset rsBrand.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsBrand>
    </cffunction>
    
    <cffunction name="getBrandBind" access="remote" returntype="string">
    <cfargument name="keywords" type="string" required="yes" default="">
    <cfargument name="siteDSN" type="string" required="yes" default="">
    <cfargument name="bStatus" type="string" required="yes" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="bName">
    <cfset var rsBind = "" >
    <cfquery name="rsBind" datasource="#ARGUMENTS.mcmsDSN#">
    SELECT bName AS bName FROM v_brand WHERE 0=0
    AND UPPER(bName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">
    AND bStatus IN (<cfqueryparam value="#ARGUMENTS.bStatus#" list="yes" cfsqltype="cf_sql_integer">)
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <cfif rsBind.recordcount NEQ 0>
    <cfset IDList = ValueList(rsBind.bName, ',') & ",none">
    <cfelse>
    <cfset IDList = ''>
    </cfif>
    <cfreturn IDList>
    </cffunction>
    
    <cffunction name="getBrandVendorRel" access="public" returntype="query" hint="Get Brand Vendor Relationship data."> 
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="ID" type="numeric" required="yes" default="0">
    <cfargument name="excludeID" type="numeric" required="yes" default="0">
    <cfargument name="bID" type="numeric" required="yes" default="0">
    <cfargument name="vID" type="numeric" required="yes" default="0">
    <cfargument name="bName" type="string" required="yes" default="">
    <cfargument name="vName" type="string" required="yes" default="">
    <cfargument name="bvrStatus" type="string" required="yes" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="bName">
    <cfset var rsBrandVendorRel = "" >
    <cftry>
    <cfquery name="rsBrandVendorRel" datasource="#application.mcmsDSN#">
    SELECT * FROM v_brand_vendor_rel WHERE 0=0
    <cfif ARGUMENTS.ID NEQ 0>
    AND ID = <cfqueryparam value="#ARGUMENTS.ID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.excludeID NEQ 0>
    AND ID <> <cfqueryparam value="#ARGUMENTS.excludeID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(bName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(bDescription) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(vName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(vDescription) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">)
    </cfif>
    <cfif ARGUMENTS.bName NEQ "">
    AND UPPER(bName) = <cfqueryparam value="#UCASE(ARGUMENTS.bName)#" cfsqltype="cf_sql_varchar">
    </cfif>
    <cfif ARGUMENTS.vName NEQ "">
    AND UPPER(vName) = <cfqueryparam value="#UCASE(ARGUMENTS.vName)#" cfsqltype="cf_sql_varchar">
    </cfif>
    <cfif ARGUMENTS.bID NEQ 0>
    AND bID = <cfqueryparam value="#ARGUMENTS.bID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.vID NEQ 0>
    AND vID = <cfqueryparam value="#ARGUMENTS.vID#" cfsqltype="cf_sql_integer">
    </cfif>
    AND bvrStatus IN (<cfqueryparam value="#ARGUMENTS.bvrStatus#" list="yes" cfsqltype="cf_sql_integer">)
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsBrandVendorRel = StructNew()>
    <cfset rsBrandVendorRel.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsBrandVendorRel>
    </cffunction>
    
    <cffunction name="getVendorReport" access="public" returntype="query" hint="Get Vendor Report data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="orderBy" type="string" required="yes" default="vName">
    <cfset var rsVendorReport = "" >
    <cftry>
    <cfquery name="rsVendorReport" datasource="#application.mcmsDSN#">
    SELECT vName As Name, vendorID AS Vendor_ID, vDescription As Description, TO_CHAR(vDate, 'mm/dd/yyyy') As Vendor_Date, sortName As Sort, sName As Status FROM v_vendor WHERE 0=0
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(vName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(vDescription) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR vendorID LIKE <cfqueryparam value="%#ARGUMENTS.keywords#%" cfsqltype="cf_sql_varchar">)
    </cfif>
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsVendorReport = StructNew()>
    <cfset rsVendorReport.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsVendorReport>
    </cffunction>
    
    <cffunction name="getVendorContactReport" access="public" returntype="query" hint="Get Vendor Contact Report data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="orderBy" type="string" required="yes" default="vName">
    <cfset var rsVendorContactReport = "" >
    <cftry>
    <cfquery name="rsVendorContactReport" datasource="#application.mcmsDSN#">
    SELECT vName As Vendor_Name, vcfName || ' ' || vclName As Contact_Name, vcAddress As Address, vcAddressExt As Address_Ext, vcCity As City, vcStateProv As State, vcZipCode As Zip, vcZipCodeExt As Zip_Ext, vcCountry As Country, vcTelArea || '-' || vcTelPrefix || '-' || vcTelSuffix As Telephone, vcFaxArea || '-' || vcFaxPrefix || '-' || vcFaxSuffix As Fax, vcEmail As Email, vcURL As URL, vcSourceUrl As Source_URL, vcSourceUsername As Source_Username, vcSourcePassword As Source_Password, TO_CHAR(vcDate, 'mm/dd/yyyy') As C_Date, sortName As Sort, sName As Status FROM v_vendor_contact WHERE 0=0
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (vendorID LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(vcfName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(vclName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">)
    </cfif>
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsVendorContactReport = StructNew()>
    <cfset rsVendorContactReport.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsVendorContactReport>
    </cffunction>
    
    <cffunction name="getBrandReport" access="public" returntype="query" hint="Get Brand Report data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="orderBy" type="string" required="yes" default="bName">
    <cfset var rsBrandReport = "" >
    <cftry>
    <cfquery name="rsBrandReport" datasource="#application.mcmsDSN#">
    SELECT bName As Name, bDescription As Description, imgName As Image_Name, imgFile As Image_File, TO_CHAR(bDate, 'mm/dd/yyyy') As Brand_Date, sortName As Sort, sName As Status FROM v_brand WHERE 0=0
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(bName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(bDescription) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">)
    </cfif>
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsBrandReport = StructNew()>
    <cfset rsBrandReport.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsBrandReport>
    </cffunction>
    
    <cffunction name="getBrandVendorRelReport" access="public" returntype="query" hint="Get Brand Vendor Rel. Report data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="orderBy" type="string" required="yes" default="bName">
    <cfset var rsBrandVendorRelReport = "" >
    <cftry>
    <cfquery name="rsBrandVendorRelReport" datasource="#application.mcmsDSN#">
    SELECT bName As Brand, bDescription As Brand_Description, TO_CHAR(bDate, 'mm/dd/yyyy') As Brand_Date, vName As Vendor, vDescription As Vendor_Description, vendorID AS Vendor_ID, TO_CHAR(vDate, 'mm/dd/yyyy') As Vendor_Date, sName As Status FROM v_brand_vendor_rel WHERE 0=0
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(bName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(bDescription) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(vName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(vDescription) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR vendorID LIKE <cfqueryparam value="%#ARGUMENTS.keywords#%" cfsqltype="cf_sql_varchar">)
    </cfif>
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsBrandVendorRelReport = StructNew()>
    <cfset rsBrandVendorRelReport.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsBrandVendorRelReport>
    </cffunction>
    
    <cffunction name="insertVendor" access="public" returntype="struct">
    <cfargument name="vendorID" type="string" required="yes">
    <cfargument name="vName" type="string" required="yes">
    <cfargument name="vDescription" type="string" required="yes">
    <cfargument name="vSort" type="numeric" required="yes">
    <cfargument name="vStatus" type="numeric" required="yes">
    <!---Relationship arguments.--->
    <cfargument name="deptNo" type="string" required="yes">
    <cfset result.message = "You have successfully inserted the record.">
    <cftry>
    <!---Check for profanity in the text.--->
    <cfinvoke 
    component="MCMS.component.utility.Regex"
    method="regexProfanity"
    returnvariable="regexProfanityRet">
    <cfinvokeargument name="profanityString" value="#TRIM(ARGUMENTS.vDescription)#"/>
    </cfinvoke>
    <!---Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.app.vendor.Vendor"
    method="getVendor"
    returnvariable="getCheckVendorRet">
    <cfinvokeargument name="vName" value="#TRIM(ARGUMENTS.vName)#"/>
    <cfinvokeargument name="vStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckVendorRet.recordcount NEQ 0>
    <cfset result.message = "The name #TRIM(ARGUMENTS.vName)# already exists, please enter a new name.">
    <cfelseif regexProfanityRet CONTAINS '$%&*!'>
    <cfset result.message = "Some text contained profanity, please remove any profanity from your text.">
    <cfelseif LEN(ARGUMENTS.vDescription) GT 2048>
    <cfset result.message = "The description is longer than 2048 characters, please enter a new description under 2048 characters.">
    <cfelse>
    <!---Email notification to system administrator for a new vendor.
    <cfset this.emailBody = '
	A new vendor #ARGUMENTS.vName# has been created and added to the database. Check to see if the vendor record requires adjustment. Note that the vendor will be placed in a preview status.
	'>
    <cfinvoke 
    component="MCMS.component.utility.Email"
    method="sendEmail"
    returnvariable="sendEmailRet">
    <cfinvokeargument name="subject" value="NEW Vendor Added"/>
    <cfinvokeargument name="to" value="#application.webmasterEmail#"/>
    <cfinvokeargument name="from" value="#session.userUsername#"/>
    <cfinvokeargument name="cc" value=""/>
    <cfinvokeargument name="bcc" value=""/>
    <cfinvokeargument name="body" value="#this.emailBody#"/>
    <cfinvokeargument name="emailType" value="html"/>
    </cfinvoke>--->
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    INSERT INTO tbl_vendor (vendorID,vName,vDescription,vSort,vStatus) VALUES
    (
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#TRIM(ARGUMENTS.vendorID)#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#TRIM(ARGUMENTS.vName)#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#TRIM(ARGUMENTS.vDescription)#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.vSort#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.vStatus#">
    )
    </cfquery>
    </cftransaction>
    <!--- Get newly inserted vendor ID. --->
    <cfinvoke 
    component="MCMS.component.cms.Cms"
    method="getMaxValueSQL"
    returnvariable="vID">
    <cfinvokeargument name="tableName" value="tbl_vendor"/>
    </cfinvoke>
    <cfset var.vID = vID>
    <!---Create catalog/department relationships.--->
    <cfinvoke 
    component="MCMS.component.app.vendor.Vendor"
    method="insertVendorDepartmentRel"
    returnvariable="insertVendorDepartmentRelRet">
    <cfinvokeargument name="vID" value="#var.vID#"/>
    <cfinvokeargument name="deptNo" value="#ARGUMENTS.deptNo#"/>
    <cfinvokeargument name="vdrStatus" value="1"/>
    </cfinvoke>
    </cfif>
    <cfcatch type="any">
    <cfset result.message = "There was an error inserting the record.">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="insertVendorDepartmentRel" access="public" returntype="struct">
    <cfargument name="vID" type="numeric" required="yes">
    <cfargument name="deptNo" type="string" required="yes">
    <cfargument name="vdrStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully inserted the record.">
    <cftry>
    <cftransaction>
    <cfloop index="i" from="1" to="#ListLen(ARGUMENTS.deptNo)#">
    <cfquery datasource="#application.mcmsDSN#">
    INSERT INTO tbl_vendor_department_rel (vID,deptNo,vdrStatus) VALUES
    (
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.vID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ListGetAt(ARGUMENTS.deptNo, i)#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.vdrStatus#">
    )
    </cfquery>
    </cfloop>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error inserting the record.">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="insertVendorContact" access="public" returntype="struct"> 
    <cfargument name="vID" type="numeric" required="yes">
    <cfargument name="vcfName" type="string" required="yes">
    <cfargument name="vclName" type="string" required="yes">
    <cfargument name="vcAddress" type="string" required="yes">
    <cfargument name="vcAddressExt" type="string" required="yes">
    <cfargument name="vcCity" type="string" required="yes">
    <cfargument name="vcStateProv" type="string" required="yes">
    <cfargument name="vcZipCode" type="string" required="yes">
    <cfargument name="vcZipCodeExt" type="string" required="yes">
    <cfargument name="vcCountry" type="string" required="yes">
    <cfargument name="vcTelArea" type="string" required="yes">
    <cfargument name="vcTelPrefix" type="string" required="yes">
    <cfargument name="vcTelSuffix" type="string" required="yes">
    <cfargument name="vcFaxArea" type="string" required="yes">
    <cfargument name="vcFaxPrefix" type="string" required="yes">
    <cfargument name="vcFaxSuffix" type="string" required="yes">
    <cfargument name="vcEmail" type="string" required="yes">
    <cfargument name="vcUrl" type="string" required="yes">
    <cfargument name="vcSourceUsername" type="string" required="yes">
    <cfargument name="vcSourcePassword" type="string" required="yes">
    <cfargument name="vcSourceUrl" type="string" required="yes">
    <cfargument name="vcSort" type="numeric" required="yes">
    <cfargument name="vcStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully inserted the record.">
    <cftry>
    <!---Check for profanity in the text.--->
    <cfinvoke 
    component="MCMS.component.utility.Regex"
    method="regexProfanity"
    returnvariable="regexProfanityRet">
    <cfinvokeargument name="profanityString" value="#TRIM(ARGUMENTS.vcfName)#"/>
    </cfinvoke>
    <!---Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.app.vendor.Vendor"
    method="getVendorContact"
    returnvariable="getCheckVendorContactRet">
    <cfinvokeargument name="vID" value="#ARGUMENTS.vID#"/>
    <cfinvokeargument name="vcStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckVendorContactRet.recordcount NEQ 0>
    <cfset result.message = "The vendor contact already exists, please try again.">
    <cfelseif regexProfanityRet CONTAINS '$%&*!'>
    <cfset result.message = "Some text contained profanity, please remove any profanity from your text.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    INSERT INTO tbl_vendor_contact (vID,vcfName,vclName,vcAddress,vcAddressExt,vcCity,vcStateProv,vcZipCode,vcZipCodeExt,vcCountry,vcTelArea,vcTelPrefix,vcTelSuffix,vcFaxArea,vcFaxPrefix,vcFaxSuffix,vcEmail,vcUrl,vcSourceUsername,vcSourcePassword,vcSourceUrl,vcSort,vcStatus) VALUES
    (
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.vID#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#TRIM(ARGUMENTS.vcfName)#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#TRIM(ARGUMENTS.vclName)#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#TRIM(ARGUMENTS.vcAddress)#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#TRIM(ARGUMENTS.vcAddressExt)#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#TRIM(ARGUMENTS.vcCity)#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#TRIM(ARGUMENTS.vcStateProv)#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#TRIM(ARGUMENTS.vcZipCode)#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#TRIM(ARGUMENTS.vcZipCodeExt)#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#TRIM(ARGUMENTS.vcCountry)#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#TRIM(ARGUMENTS.vcTelArea)#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#TRIM(ARGUMENTS.vcTelPrefix)#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#TRIM(ARGUMENTS.vcTelSuffix)#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#TRIM(ARGUMENTS.vcFaxArea)#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#TRIM(ARGUMENTS.vcFaxPrefix)#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#TRIM(ARGUMENTS.vcFaxSuffix)#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#TRIM(ARGUMENTS.vcEmail)#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#TRIM(ARGUMENTS.vcUrl)#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#TRIM(ARGUMENTS.vcSourceUsername)#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#TRIM(ARGUMENTS.vcSourcePassword)#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#TRIM(ARGUMENTS.vcSourceUrl)#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.vcSort#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.vcStatus#">
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
    
    <cffunction name="insertBrand" access="public" returntype="struct">
    <cfargument name="bName" type="string" required="yes">
    <cfargument name="bDescription" type="string" required="yes">
    <cfargument name="imgID" type="numeric" required="yes">
    <cfargument name="bSort" type="numeric" required="yes">
    <cfargument name="bStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully inserted the record.">
    <cftry>
    <!---Check for profanity in the text.--->
    <cfinvoke 
    component="MCMS.component.utility.Regex"
    method="regexProfanity"
    returnvariable="regexProfanityRet">
    <cfinvokeargument name="profanityString" value="#TRIM(ARGUMENTS.bDescription)#"/>
    </cfinvoke>
    <!---Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.app.vendor.Vendor"
    method="getBrand"
    returnvariable="getCheckBrandRet">
    <cfinvokeargument name="bName" value="#TRIM(ARGUMENTS.bName)#"/>
    <cfinvokeargument name="bStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckBrandRet.recordcount NEQ 0>
    <cfset result.message = "The name #TRIM(ARGUMENTS.bName)# already exists, please enter a new name.">
    <cfelseif regexProfanityRet CONTAINS '$%&*!'>
    <cfset result.message = "Some text contained profanity, please remove any profanity from your text.">
    <cfelseif LEN(ARGUMENTS.bDescription) GT 1048>
    <cfset result.message = "The description is longer than 1048 characters, please enter a new description under 1048 characters.">
    <cfelse>
    <!---Email notification to system administrator for a new brand.--->
    <cfset this.emailBody = '
	A new brand #ARGUMENTS.bName# has been created and added to the database. Check to see if the brand record requires adjustment or a relationship to a vendor. Note that the brand will be placed in a preview status.
	'>
    <cfinvoke 
    component="MCMS.component.utility.Email"
    method="sendEmail"
    returnvariable="sendEmailRet">
    <cfinvokeargument name="subject" value="NEW Brand Added"/>
    <cfinvokeargument name="to" value="#application.webmasterEmail#"/>
    <cfinvokeargument name="from" value="#session.userUsername#"/>
    <cfinvokeargument name="cc" value=""/>
    <cfinvokeargument name="bcc" value=""/>
    <cfinvokeargument name="body" value="#this.emailBody#"/>
    <cfinvokeargument name="emailType" value="html"/>
    </cfinvoke>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    INSERT INTO tbl_brand (bName,bDescription,imgID,bSort,bStatus) VALUES
    (
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#TRIM(ARGUMENTS.bName)#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#TRIM(ARGUMENTS.bDescription)#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.imgID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.bSort#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.bStatus#">
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
    
    <cffunction name="insertBrandVendorRel" access="public" returntype="struct">
    <cfargument name="bID" type="numeric" required="yes">
    <cfargument name="vID" type="numeric" required="yes">
    <cfargument name="bvrStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully inserted the record.">
    <cftry>
    <!---Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.app.vendor.Vendor"
    method="getBrandVendorRel"
    returnvariable="getCheckBrandVendorRelRet">
    <cfinvokeargument name="bID" value="#ARGUMENTS.bID#"/>
    <cfinvokeargument name="vID" value="#ARGUMENTS.vID#"/>
    <cfinvokeargument name="bvrStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckBrandVendorRelRet.recordcount NEQ 0>
    <cfset result.message = "The brand vendor relationship already exists, please try again.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    INSERT INTO tbl_brand_vendor_rel (bID,vID,bvrStatus) VALUES
    (
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.bID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.vID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.bvrStatus#">
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
    
    <cffunction name="updateVendor" access="public" returntype="struct">
    <cfargument name="ID" type="numeric" required="yes">
    <cfargument name="vendorID" type="string" required="yes">
    <cfargument name="vName" type="string" required="yes">
    <cfargument name="vDescription" type="string" required="yes">
    <cfargument name="vSort" type="numeric" required="yes">
    <cfargument name="vStatus" type="numeric" required="yes">
    <!---Relationship arguments.--->
    <cfargument name="deptNo" type="string" required="yes">
    <cfset result.message = "You have successfully updated the record.">
    <cftry>
    <!---Check for profanity in the text.--->
    <cfinvoke 
    component="MCMS.component.utility.Regex"
    method="regexProfanity"
    returnvariable="regexProfanityRet">
    <cfinvokeargument name="profanityString" value="#TRIM(ARGUMENTS.vDescription)#"/>
    </cfinvoke>
    <!---Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.app.vendor.Vendor"
    method="getVendor"
    returnvariable="getCheckVendorRet">
    <cfinvokeargument name="excludeID" value="#ARGUMENTS.ID#"/>
    <cfinvokeargument name="vName" value="#TRIM(ARGUMENTS.vName)#"/>
    <cfinvokeargument name="vStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckVendorRet.recordcount NEQ 0>
    <cfset result.message = "The name #TRIM(ARGUMENTS.vName)# already exists, please enter a new name.">
    <cfelseif regexProfanityRet CONTAINS '$%&*!'>
    <cfset result.message = "Some text contained profanity, please remove any profanity from your text.">
    <cfelseif LEN(ARGUMENTS.vDescription) GT 2048>
    <cfset result.message = "The description is longer than 2048 characters, please enter a new description under 2048 characters.">
	<cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_vendor SET
    vendorID = <cfqueryparam cfsqltype="cf_sql_varchar" value="#TRIM(ARGUMENTS.vendorID)#">,
    vName = <cfqueryparam cfsqltype="cf_sql_varchar" value="#TRIM(ARGUMENTS.vName)#">,
    vDescription = <cfqueryparam cfsqltype="cf_sql_varchar" value="#TRIM(ARGUMENTS.vDescription)#">,
    vSort = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.vSort#">,
    vStatus = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.vStatus#">
    WHERE ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ID#">
    </cfquery>
    </cftransaction>
    <!---Delete any existing relationships.--->
    <cfinvoke 
    component="MCMS.component.app.vendor.Vendor"
    method="deleteVendorDepartmentRel"
    returnvariable="deleteVendorDepartmentRelRet">
    <cfinvokeargument name="vID" value="#ARGUMENTS.ID#"/>
    </cfinvoke>
    <!---Create vendor/department relationships.--->
    <cfinvoke 
    component="MCMS.component.app.vendor.Vendor"
    method="insertVendorDepartmentRel"
    returnvariable="insertVendorDepartmentRelRet">
    <cfinvokeargument name="vID" value="#ARGUMENTS.ID#"/>
    <cfinvokeargument name="deptNo" value="#ARGUMENTS.deptNo#"/>
    <cfinvokeargument name="vdrStatus" value="1"/>
    </cfinvoke>
    </cfif>
    <cfcatch type="any">
    <cfset result.message = "There was an error updating the record.">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="updateVendorContact" access="public" returntype="struct">
    <cfargument name="ID" type="numeric" required="yes">
    <cfargument name="vID" type="numeric" required="yes">
    <cfargument name="vcfName" type="string" required="yes">
    <cfargument name="vclName" type="string" required="yes">
    <cfargument name="vcAddress" type="string" required="yes">
    <cfargument name="vcAddressExt" type="string" required="yes">
    <cfargument name="vcCity" type="string" required="yes">
    <cfargument name="vcStateProv" type="string" required="yes">
    <cfargument name="vcZipCode" type="string" required="yes">
    <cfargument name="vcZipCodeExt" type="string" required="yes">
    <cfargument name="vcCountry" type="string" required="yes">
    <cfargument name="vcTelArea" type="string" required="yes">
    <cfargument name="vcTelPrefix" type="string" required="yes">
    <cfargument name="vcTelSuffix" type="string" required="yes">
    <cfargument name="vcFaxArea" type="string" required="yes">
    <cfargument name="vcFaxPrefix" type="string" required="yes">
    <cfargument name="vcFaxSuffix" type="string" required="yes">
    <cfargument name="vcEmail" type="string" required="yes">
    <cfargument name="vcUrl" type="string" required="yes">
    <cfargument name="vcSourceUsername" type="string" required="yes">
    <cfargument name="vcSourcePassword" type="string" required="yes">
    <cfargument name="vcSourceUrl" type="string" required="yes">
    <cfargument name="vcSort" type="numeric" required="yes">
    <cfargument name="vcStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully updated the record.">
    <cftry>
    <!---Check for profanity in the text.--->
    <cfinvoke 
    component="MCMS.component.utility.Regex"
    method="regexProfanity"
    returnvariable="regexProfanityRet">
    <cfinvokeargument name="profanityString" value="#TRIM(ARGUMENTS.vcfName)#"/>
    </cfinvoke>
    <!---Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.app.vendor.Vendor"
    method="getVendorContact"
    returnvariable="getCheckVendorContactRet">
    <cfinvokeargument name="excludeID" value="#ARGUMENTS.ID#"/>
    <cfinvokeargument name="vID" value="#ARGUMENTS.vID#"/>
    <cfinvokeargument name="vcStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckVendorContactRet.recordcount NEQ 0>
    <cfset result.message = "The vendor contact already exists, please try again.">
    <cfelseif regexProfanityRet CONTAINS '$%&*!'>
    <cfset result.message = "Some text contained profanity, please remove any profanity from your text.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_vendor_contact SET
    vID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.vID#">,
    vcfName = <cfqueryparam cfsqltype="cf_sql_varchar" value="#TRIM(ARGUMENTS.vcfName)#">,
    vclName = <cfqueryparam cfsqltype="cf_sql_varchar" value="#TRIM(ARGUMENTS.vclName)#">,
    vcAddress = <cfqueryparam cfsqltype="cf_sql_varchar" value="#TRIM(ARGUMENTS.vcAddress)#">,
    vcAddressExt = <cfqueryparam cfsqltype="cf_sql_varchar" value="#TRIM(ARGUMENTS.vcAddressExt)#">,
    vcCity = <cfqueryparam cfsqltype="cf_sql_varchar" value="#TRIM(ARGUMENTS.vcCity)#">,
    vcStateProv = <cfqueryparam cfsqltype="cf_sql_varchar" value="#TRIM(ARGUMENTS.vcStateProv)#">,
    vcZipCode = <cfqueryparam cfsqltype="cf_sql_varchar" value="#TRIM(ARGUMENTS.vcZipCode)#">,
    vcZipCodeExt = <cfqueryparam cfsqltype="cf_sql_varchar" value="#TRIM(ARGUMENTS.vcZipCodeExt)#">,
    vcCountry = <cfqueryparam cfsqltype="cf_sql_varchar" value="#TRIM(ARGUMENTS.vcCountry)#">,
    vcTelArea = <cfqueryparam cfsqltype="cf_sql_varchar" value="#TRIM(ARGUMENTS.vcTelArea)#">,
    vcTelPrefix = <cfqueryparam cfsqltype="cf_sql_varchar" value="#TRIM(ARGUMENTS.vcTelPrefix)#">,
    vcTelSuffix = <cfqueryparam cfsqltype="cf_sql_varchar" value="#TRIM(ARGUMENTS.vcTelSuffix)#">,
    vcFaxArea = <cfqueryparam cfsqltype="cf_sql_varchar" value="#TRIM(ARGUMENTS.vcFaxArea)#">,
    vcFaxPrefix = <cfqueryparam cfsqltype="cf_sql_varchar" value="#TRIM(ARGUMENTS.vcFaxPrefix)#">,
    vcFaxSuffix = <cfqueryparam cfsqltype="cf_sql_varchar" value="#TRIM(ARGUMENTS.vcFaxSuffix)#">,
    vcEmail = <cfqueryparam cfsqltype="cf_sql_varchar" value="#TRIM(ARGUMENTS.vcEmail)#">,
    vcUrl = <cfqueryparam cfsqltype="cf_sql_varchar" value="#TRIM(ARGUMENTS.vcUrl)#">,
    vcSourceUsername = <cfqueryparam cfsqltype="cf_sql_varchar" value="#TRIM(ARGUMENTS.vcSourceUsername)#">,
    vcSourcePassword = <cfqueryparam cfsqltype="cf_sql_varchar" value="#TRIM(ARGUMENTS.vcSourcePassword)#">,
    vcSourceUrl = <cfqueryparam cfsqltype="cf_sql_varchar" value="#TRIM(ARGUMENTS.vcSourceUrl)#">,
    vcSort = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.vcSort#">,
    vcStatus = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.vcStatus#">
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
    
    <cffunction name="updateBrand" access="public" returntype="struct">
    <cfargument name="ID" type="numeric" required="yes">
    <cfargument name="bName" type="string" required="yes">
    <cfargument name="bDescription" type="string" required="yes">
    <cfargument name="imgID" type="numeric" required="yes">
    <cfargument name="bSort" type="numeric" required="yes">
    <cfargument name="bStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully updated the record.">
    <cftry>
    <!---Check for profanity in the text.--->
    <cfinvoke 
    component="MCMS.component.utility.Regex"
    method="regexProfanity"
    returnvariable="regexProfanityRet">
    <cfinvokeargument name="profanityString" value="#TRIM(ARGUMENTS.bDescription)#"/>
    </cfinvoke>
    <!---Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.app.vendor.Vendor"
    method="getBrand"
    returnvariable="getCheckBrandRet">
    <cfinvokeargument name="excludeID" value="#ARGUMENTS.ID#"/>
    <cfinvokeargument name="bName" value="#TRIM(ARGUMENTS.bName)#"/>
    <cfinvokeargument name="bStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckBrandRet.recordcount NEQ 0>
    <cfset result.message = "The name #TRIM(ARGUMENTS.bName)# already exists, please enter a new name.">
    <cfelseif regexProfanityRet CONTAINS '$%&*!'>
    <cfset result.message = "Some text contained profanity, please remove any profanity from your text.">
    <cfelseif LEN(ARGUMENTS.bDescription) GT 1048>
    <cfset result.message = "The description is longer than 1048 characters, please enter a new description under 1048 characters.">
	<cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_brand SET
    bName = <cfqueryparam cfsqltype="cf_sql_varchar" value="#TRIM(ARGUMENTS.bName)#">,
    bDescription = <cfqueryparam cfsqltype="cf_sql_varchar" value="#TRIM(ARGUMENTS.bDescription)#">,
    imgID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.imgID#">,
    bDate = <cfqueryparam cfsqltype="cf_sql_timestamp" value="#Now()#">,
    bSort = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.bSort#">,
    bStatus = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.bStatus#">
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
    
    <cffunction name="updateBrandVendorRel" access="public" returntype="struct">
    <cfargument name="ID" type="numeric" required="yes">
    <cfargument name="bID" type="numeric" required="yes">
    <cfargument name="vID" type="numeric" required="yes">
    <cfargument name="bvrStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully updated the record.">
    <cftry>
    <!---Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.app.vendor.Vendor"
    method="getBrandVendorRel"
    returnvariable="getCheckBrandVendorRelRet">
    <cfinvokeargument name="excludeID" value="#ARGUMENTS.ID#"/>
    <cfinvokeargument name="bID" value="#ARGUMENTS.bID#"/>
    <cfinvokeargument name="vID" value="#ARGUMENTS.vID#"/>
    <cfinvokeargument name="bvrStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckBrandVendorRelRet.recordcount NEQ 0>
    <cfset result.message = "The brand vendor relationship already exists, please try again.">
	<cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_brand_vendor_rel SET
    bID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.bID#">,
    vID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.vID#">,
    bvrStatus = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.bvrStatus#">
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
    
    <cffunction name="updateVendorList" access="public" returntype="struct">
    <cfargument name="ID" type="numeric" required="yes">
    <cfargument name="vStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully updated the records.">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_vendor SET
    vStatus = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.vStatus#">
    WHERE ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ID#">
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error updating the records.">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="updateVendorContactList" access="public" returntype="struct">
    <cfargument name="ID" type="numeric" required="yes">
    <cfargument name="vcStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully updated the records.">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_vendor_contact SET
    vcStatus = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.vcStatus#">
    WHERE ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ID#">
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error updating the records.">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="updateBrandList" access="public" returntype="struct">
    <cfargument name="ID" type="numeric" required="yes">
    <cfargument name="bStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully updated the records.">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_brand SET
    bStatus = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.bStatus#">
    WHERE ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ID#">
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error updating the records.">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="updateBrandVendorRelList" access="public" returntype="struct">
    <cfargument name="ID" type="numeric" required="yes">
    <cfargument name="bvrStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully updated the records.">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_brand_vendor_rel SET
    bvrStatus = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.bvrStatus#">
    WHERE ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ID#">
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error updating the records.">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="deleteVendor" access="public" returntype="struct">
    <cfargument name="ID" type="string" required="yes">
    <cfset result.message = "You have successfully deleted the record(s).">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    DELETE FROM tbl_vendor
    WHERE ID IN (<cfqueryparam cfsqltype="cf_sql_integer" list="yes" value="#ARGUMENTS.ID#">)
    </cfquery>
    </cftransaction>
    <cfinvoke 
    component="MCMS.component.app.vendor.Vendor"
    method="deleteVendorContact"
    returnvariable="deleteVendorContactRet">
    <cfinvokeargument name="vID" value="#ARGUMENTS.ID#"/>
    </cfinvoke>
    <cfcatch type="any">
    <cfset result.message = "There was an error deleting the record(s).">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="deleteVendorDepartmentRel" access="public" returntype="struct">
    <cfargument name="ID" type="string" required="yes" default="0">
    <cfargument name="vID" type="string" required="yes" default="0">
    <cfset result.message = "You have successfully deleted the record(s).">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    DELETE FROM tbl_vendor_department_rel
    WHERE ID IN (<cfqueryparam cfsqltype="cf_sql_integer" list="yes" value="#ARGUMENTS.ID#">)
    OR vID IN (<cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.vID#">)
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error deleting the record(s).">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="deleteVendorContact" access="public" returntype="struct">
    <cfargument name="ID" type="string" required="yes">
    <cfargument name="vID" type="string" required="yes" default="0">
    <cfset result.message = "You have successfully deleted the record(s).">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    DELETE FROM tbl_vendor_contact
    WHERE ID IN (<cfqueryparam cfsqltype="cf_sql_integer" list="yes" value="#ARGUMENTS.ID#">)
    OR vID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.vID#">
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error deleting the record(s).">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction> 
    
    <cffunction name="deleteBrand" access="public" returntype="struct">
    <cfargument name="ID" type="string" required="yes">
    <cfset result.message = "You have successfully deleted the record(s).">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    DELETE FROM tbl_brand
    WHERE ID IN (<cfqueryparam cfsqltype="cf_sql_integer" list="yes" value="#ARGUMENTS.ID#">)
    </cfquery>
    </cftransaction>
    <cfinvoke 
    component="MCMS.component.app.vendor.Vendor"
    method="deleteBrandVendorRel"
    returnvariable="deleteBrandVendorRelRet">
    <cfinvokeargument name="bID" value="#ARGUMENTS.ID#"/>
    </cfinvoke>
    <cfcatch type="any">
    <cfset result.message = "There was an error deleting the record(s).">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="deleteBrandVendorRel" access="public" returntype="struct">
    <cfargument name="ID" type="string" required="yes">
    <cfset result.message = "You have successfully deleted the record(s).">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    DELETE FROM tbl_brand_vendor_rel
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