<cfcomponent hint="Export component for ATG Price data export.">
    
    <cffunction name="getExportPriceATG" access="public" returntype="query" hint="Get Export Price ATG data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="excludeID" type="string" required="yes" default="0">
    <cfargument name="ID" type="string" required="yes" default="0">
    <cfargument name="pID" type="string" required="yes" default="0">
    <cfargument name="sID" type="string" required="yes" default="0">
    <cfargument name="cID" type="string" required="yes" default="0">
    <cfargument name="pesID" type="string" required="yes" default="0">
    <cfargument name="productTID" type="string" required="yes" default="0" hint="Product Type.">
    <cfargument name="startDateRange" type="string" required="yes" default="#DateFormat(Now(), application.dateFormat)#">
    <cfargument name="endDateRange" type="string" required="yes" default="#DateFormat(Now(), application.dateFormat)#">
    <cfargument name="deptNo" type="string" required="yes" default="0">
    <cfargument name="ptID" type="string" required="yes" default="0">
    <cfargument name="orderBy" type="string" required="yes" default="ID">
    <cfset var rsExportPriceATG = "" >
    <cftry>
    <cfquery name="rsExportPriceATG" datasource="#application.mcmsDSN#">
    SELECT * FROM v_export_price_atg WHERE 0=0
    <cfif ARGUMENTS.ID NEQ 0>
    AND ID = <cfqueryparam value="#ARGUMENTS.ID#" cfsqltype="cf_sql_varchar">
    </cfif>
    <cfif ARGUMENTS.excludeID NEQ 0>
    AND ID <> <cfqueryparam value="#ARGUMENTS.excludeID#" cfsqltype="cf_sql_varchar">
    </cfif>
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(pName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(skuID) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">)
    </cfif>
    <cfif ARGUMENTS.pID NEQ 0>
    AND pID IN (<cfqueryparam value="#ARGUMENTS.pID#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    <cfif ARGUMENTS.sID NEQ 0>
    AND sID IN (<cfqueryparam value="#ARGUMENTS.sID#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    <cfif ARGUMENTS.cID NEQ 0>
    AND cID IN (<cfqueryparam value="#ARGUMENTS.cID#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    <cfif ARGUMENTS.pesID NEQ 0>
    AND pesID IN (<cfqueryparam value="#ARGUMENTS.pesID#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    <cfif ARGUMENTS.productTID NEQ 0>
    AND productTID IN (<cfqueryparam value="#ARGUMENTS.productTID#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    <cfif ARGUMENTS.startDateRange NEQ DateFormat(Now(), application.dateFormat)>
    AND TO_CHAR(pDateUpdate) >= <cfqueryparam value="#ARGUMENTS.startDateRange#" cfsqltype="cf_sql_date">
    </cfif>
    <cfif ARGUMENTS.endDateRange NEQ DateFormat(Now(), application.dateFormat)>
    AND TO_CHAR(pDateUpdate) <= <cfqueryparam value="#ARGUMENTS.endDateRange#" cfsqltype="cf_sql_date">
    </cfif>
    <cfif ARGUMENTS.deptNo NEQ 0>
    AND deptNo IN (<cfqueryparam value="#ARGUMENTS.deptNo#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    <cfif ARGUMENTS.ptID NEQ 0>
    AND ptID IN (<cfqueryparam value="#ARGUMENTS.ptID#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    <!---Catch any bad records, filter pricing that has expired, only pull List and Sale types.--->
    AND skuID <> 'NULL' 
    AND pDateExp >= <cfqueryparam value="#DateFormat(Now(), application.dateFormat)#" cfsqltype="cf_sql_date">
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cflog file="export_price_atg" text="Error: getExportPriceATG" type="error"/>
    
    </cfcatch>
    </cftry>
    <cfreturn rsExportPriceATG>
    </cffunction>
    
    <cffunction name="getExportPriceATGExcel" access="public" returntype="any" hint="Get Export Price ATG data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="args" type="string" required="yes" default="0,0,0,0,0,0">
    <cfargument name="excludeID" type="string" required="yes" default="0">
    <cfargument name="ID" type="string" required="yes" default="0">
    <cfargument name="pID" type="string" required="yes" default="0">
    <cfargument name="cID" type="string" required="yes" default="0">
    <cfargument name="orderBy" type="string" required="yes" default="ID">
    <!---Control the sql pulled for the excel report.--->
    <cfargument name="getSQL" type="string" required="yes" default="false">
    <cfset var rsExportPriceATGExcel = "" >
    <cftry>
    <cfquery name="rsExportPriceATGExcel" datasource="#application.mcmsDSN#">
    SELECT ptID || ':' || skuID AS ID, ptID AS priceList, skuID AS skuId, pPrice as listPrice FROM v_export_price_atg WHERE 0=0
    <cfif ARGUMENTS.ID NEQ 0>
    AND ID = <cfqueryparam value="#ARGUMENTS.ID#" cfsqltype="cf_sql_varchar">
    </cfif>
    <cfif ARGUMENTS.excludeID NEQ 0>
    AND ID <> <cfqueryparam value="#ARGUMENTS.excludeID#" cfsqltype="cf_sql_varchar">
    </cfif>
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(pName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(skuID) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">)
    </cfif>
    <cfif ARGUMENTS.pID NEQ 0>
    AND pID IN (<cfqueryparam value="#ARGUMENTS.pID#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    <cfif ARGUMENTS.cID NEQ 0>
    AND cID IN (<cfqueryparam value="#ARGUMENTS.cID#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    <cfif ListGetAt(ARGUMENTS.args, 1) NEQ 0>
    AND deptNo IN (<cfqueryparam value="#ListGetAt(ARGUMENTS.args, 1)#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    <cfif ListGetAt(ARGUMENTS.args, 2) NEQ 0>
    AND cID IN (<cfqueryparam value="#ListGetAt(ARGUMENTS.args, 2)#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    <cfif ListGetAt(ARGUMENTS.args, 3) NEQ 0>
    AND pesID IN (<cfqueryparam value="#ListGetAt(ARGUMENTS.args, 3)#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    <cfif ListGetAt(ARGUMENTS.args, 4) NEQ 0>
    AND productTID IN (<cfqueryparam value="#ListGetAt(ARGUMENTS.args, 4)#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    <cfif ListGetAt(ARGUMENTS.args, 5) NEQ 0>
    AND TO_CHAR(pDateUpdate) = <cfqueryparam value="#ListGetAt(ARGUMENTS.args, 5)#" cfsqltype="cf_sql_date">
    </cfif>
    <cfif ListGetAt(ARGUMENTS.args, 6) NEQ 0>
    AND ptID IN (<cfqueryparam value="#ListGetAt(ARGUMENTS.args, 6)#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    <!---Catch any bad records, filter pricing that has expired, only pull List and Sale types.--->
    AND skuID <> 'NULL' 
    AND pDateExp >= <cfqueryparam value="#DateFormat(Now(), application.dateFormat)#" cfsqltype="cf_sql_date">
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <cfif ARGUMENTS.getSQL EQ 'true'>
    <!---Now return the SQL list of columns in camel case.--->
    <cfset rsExportPriceATGExcel = "ID,priceList,skuId,listPrice">
    </cfif>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cflog file="export_price_atg" text="Error: getExportPriceATGExcel" type="error"/>
    
    </cfcatch>
    </cftry>
    <cfreturn rsExportPriceATGExcel>
    </cffunction>
    
    <cffunction name="getExportPriceChangeSaleATGExcel" access="public" returntype="any" hint="Get Export Price ATG data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="args" type="string" required="yes" default="0,0,0,0,0,0">
    <cfargument name="excludeID" type="string" required="yes" default="0">
    <cfargument name="ID" type="string" required="yes" default="0">
    <cfargument name="pID" type="string" required="yes" default="0">
    <cfargument name="cID" type="string" required="yes" default="0">
    <cfargument name="orderBy" type="string" required="yes" default="ID">
    <!---Control the sql pulled for the excel report.--->
    <cfargument name="getSQL" type="string" required="yes" default="false">
    <cfset var rsExportPriceChangeSaleATGExcel = "" >
    <cftry>
    <cfquery name="rsExportPriceChangeSaleATGExcel" datasource="#application.mcmsDSN#">
    SELECT skuID AS ID, TO_CHAR(pDateRel, 'MM/DD/YYYY') AS salePriceStartDate, TO_CHAR(pDateExp, 'MM/DD/YYYY') AS salePriceEndDate FROM v_export_price_atg WHERE 0=0
    <cfif ARGUMENTS.ID NEQ 0>
    AND ID = <cfqueryparam value="#ARGUMENTS.ID#" cfsqltype="cf_sql_varchar">
    </cfif>
    <cfif ARGUMENTS.excludeID NEQ 0>
    AND ID <> <cfqueryparam value="#ARGUMENTS.excludeID#" cfsqltype="cf_sql_varchar">
    </cfif>
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(pName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(skuID) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">)
    </cfif>
    <cfif ARGUMENTS.pID NEQ 0>
    AND pID IN (<cfqueryparam value="#ARGUMENTS.pID#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    <cfif ARGUMENTS.cID NEQ 0>
    AND cID IN (<cfqueryparam value="#ARGUMENTS.cID#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    <cfif ListGetAt(ARGUMENTS.args, 1) NEQ 0>
    AND deptNo IN (<cfqueryparam value="#ListGetAt(ARGUMENTS.args, 1)#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    <cfif ListGetAt(ARGUMENTS.args, 2) NEQ 0>
    AND cID IN (<cfqueryparam value="#ListGetAt(ARGUMENTS.args, 2)#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    <cfif ListGetAt(ARGUMENTS.args, 3) NEQ 0>
    AND pesID IN (<cfqueryparam value="#ListGetAt(ARGUMENTS.args, 3)#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    <cfif ListGetAt(ARGUMENTS.args, 4) NEQ 0>
    AND productTID IN (<cfqueryparam value="#ListGetAt(ARGUMENTS.args, 4)#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    <cfif ListGetAt(ARGUMENTS.args, 5) NEQ 0>
    AND TO_CHAR(pDateUpdate) = <cfqueryparam value="#ListGetAt(ARGUMENTS.args, 5)#" cfsqltype="cf_sql_date">
    </cfif>
    <cfif ListGetAt(ARGUMENTS.args, 6) NEQ 0>
    AND ptID IN (<cfqueryparam value="#ListGetAt(ARGUMENTS.args, 6)#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    <!---Catch any bad records, filter pricing that has expired, only pull List and Sale types.--->
    AND skuID <> 'NULL' 
    AND pDateExp >= <cfqueryparam value="#DateFormat(Now(), application.dateFormat)#" cfsqltype="cf_sql_date">
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <cfif ARGUMENTS.getSQL EQ 'true'>
    <!---Now return the SQL list of columns in camel case.--->
    <cfset rsExportPriceChangeSaleATGExcel = "ID,salePriceStartDate,salePriceEndDate">
    </cfif>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cflog file="export_price_atg" text="Error: getExportPriceChangeSaleATGExcel" type="error"/>
    
    </cfcatch>
    </cftry>
    <cfreturn rsExportPriceChangeSaleATGExcel>
    </cffunction>
</cfcomponent>