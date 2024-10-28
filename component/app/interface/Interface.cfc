<cfcomponent>
	<cffunction name="getSkuQOH_TO_ATG" access="public" returntype="query" hint="Get Sku QOH data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="sku" type="numeric" required="yes" default="0">
    <cfargument name="quantity" type="numeric" required="yes" default="0">
    <cfargument name="sw_last_updated" type="string" required="yes" default="">
    <cfargument name="orderBy" type="string" required="yes" default="sku">
    <cfset var rsSkuQOH_TO_ATG = "" >
    <cftry>
    <cfquery name="rsSkuQOH_TO_ATG" datasource="swweb">
    SELECT * FROM to_atg.available_qoh WHERE 0=0
    <cfif ARGUMENTS.sku NEQ 0>
    AND sku = <cfqueryparam value="#ARGUMENTS.sku#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(sku) IN (<cfqueryparam value="#UCASE(ARGUMENTS.keywords)#" list="yes" cfsqltype="cf_sql_varchar">)
    </cfif>
    <cfif ARGUMENTS.quantity NEQ 0>
    AND quantity = <cfqueryparam value="#ARGUMENTS.quantity#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.sw_last_updated NEQ "">
    AND sw_last_updated >= <cfqueryparam value="#DateFormat(ARGUMENTS.sw_last_updated, application.dateFormat)#" cfsqltype="cf_sql_date"> 
    </cfif>
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsSkuQOH_TO_ATG = StructNew()>
    <cfset rsSkuQOH_TO_ATG.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsSkuQOH_TO_ATG>
    </cffunction>
    
    <cffunction name="getSkuQOH_ERP" access="public" returntype="query" hint="Get Sku QOH from ERP data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="sku" type="string" required="yes" default="0">
    <cfargument name="siteNo" type="string" required="yes" default="0">
    <cfargument name="org" type="string" required="yes" default="0">
    <cfargument name="qoh" type="numeric" required="yes" default="0">
    <cfargument name="orderBy" type="string" required="yes" default="SITENO, SKU">
    <cfset var rsSkuQOH_ERP = "" >
    <cftry>
    <cfquery name="rsSkuQOH_ERP" datasource="dwprod">
    SELECT * FROM SKU_PRICE_INFO_V
    WHERE 0=0
    <cfif ARGUMENTS.sku NEQ 0>
    AND SKU IN (<cfqueryparam value="#ARGUMENTS.sku#" list="yes" cfsqltype="cf_sql_varchar">)
    </cfif>
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(SKU) LIKE (<cfqueryparam value="#UCASE(ARGUMENTS.keywords)#%" list="yes" cfsqltype="cf_sql_varchar">) OR UPPER(MPN) LIKE (<cfqueryparam value="#UCASE(ARGUMENTS.keywords)#%" list="yes" cfsqltype="cf_sql_varchar">) OR UPPER(UPC) LIKE (<cfqueryparam value="#UCASE(ARGUMENTS.keywords)#%" list="yes" cfsqltype="cf_sql_varchar">))
    </cfif>
    <cfif ARGUMENTS.siteNo NEQ 0>
    AND SITENO IN (<cfqueryparam value="#ARGUMENTS.siteNo#" list="yes" cfsqltype="cf_sql_varchar">)
    </cfif>
    <cfif ARGUMENTS.org NEQ 0>
    AND SITENO IN (<cfqueryparam value="#ARGUMENTS.org#" list="yes" cfsqltype="cf_sql_varchar">)
    </cfif>
    <cfif ARGUMENTS.qoh NEQ 0>
    AND SITE_QOH >= <cfqueryparam value="#ARGUMENTS.qoh#" cfsqltype="cf_sql_numeric">
    </cfif>
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsSkuQOH_ERP = StructNew()>
    <cfset rsSkuQOH_ERP.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsSkuQOH_ERP>
    </cffunction>
    
    <cffunction name="getSkuQOH_ERPReport" access="public" returntype="query" hint="Get Sku QOH from ERP data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="siteNo" type="string" required="yes" default="0">
    <cfargument name="orderBy" type="string" required="yes" default="SKU">
    <cfset var rsSkuQOH_ERPReport = "" >
    <cftry>
    <!---Query of Query.--->
    <cfquery name="rsSkuQOH_ERPReport" datasource="dwprod">
    SELECT * FROM SKU_PRICE_INFO_V
    WHERE 0=0
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(SKU) IN (<cfqueryparam value="#UCASE(ARGUMENTS.keywords)#" list="yes" cfsqltype="cf_sql_varchar">) OR UPPER(MPN) IN (<cfqueryparam value="#UCASE(ARGUMENTS.keywords)#" list="yes" cfsqltype="cf_sql_varchar">) OR UPPER(UPC) IN (<cfqueryparam value="#UCASE(ARGUMENTS.keywords)#" list="yes" cfsqltype="cf_sql_varchar">))
    </cfif>
    <cfif ARGUMENTS.siteNo NEQ 0>
    AND SITENO IN (<cfqueryparam value="#ARGUMENTS.siteNo#" list="yes" cfsqltype="cf_sql_varchar">)
    </cfif>
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsSkuQOH_ERPReport = StructNew()>
    <cfset rsSkuQOH_ERPReport.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsSkuQOH_ERPReport>
    </cffunction>
    
    <cffunction name="getRestrictionCode" access="public" returntype="query" hint="Get Restriction Code data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="restriction_id" type="numeric" required="yes" default="0">
    <cfargument name="stateprov" type="string" required="yes" default="">
    <cfargument name="county" type="string" required="yes" default="">
    <cfargument name="zipcode" type="string" required="yes" default="">
    <cfargument name="orderBy" type="string" required="yes" default="restriction_id">
    <cfset var rsRestrictionCode = "" >
    <cftry>
    <cfquery name="rsRestrictionCode" datasource="swweb">
    SELECT * FROM to_atg.restriction_code WHERE 0=0
    <cfif ARGUMENTS.restriction_id NEQ 0>
    AND restriction_id = <cfqueryparam value="#ARGUMENTS.restriction_id#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(description) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">)
    </cfif>
    <cfif ARGUMENTS.stateprov NEQ ''>
    AND UPPER(stateprov) IN (<cfqueryparam value="#UCASE(ARGUMENTS.stateprov)#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    <cfif ARGUMENTS.county NEQ ''>
    AND UPPER(county) IN (<cfqueryparam value="#UCASE(ARGUMENTS.county)#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    <cfif ARGUMENTS.zipcode NEQ ''>
    AND UPPER(zipcode) IN (<cfqueryparam value="#UCASE(ARGUMENTS.zipcode)#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsRestrictionCode = StructNew()>
    <cfset rsRestrictionCode.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsRestrictionCode>
    </cffunction>
    
    <cffunction name="getShipRateException" access="public" returntype="query" hint="Get Ship Rate Exception data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="ship_rate_id" type="string" required="yes" default="">
    <cfargument name="ship_carrier" type="string" required="yes" default="">
    <cfargument name="ship_method" type="string" required="yes" default="">
    <cfargument name="exception_type" type="string" required="yes" default="">
    <cfargument name="exception_code" type="string" required="yes" default="">
    <cfargument name="orderBy" type="string" required="yes" default="ship_rate_id, exception_code">
    <cfset var rsShipRateException = "" >
    <cftry>
    <cfquery name="rsShipRateException" datasource="swweb">
    SELECT * FROM to_atg.ship_rate_exception WHERE 0=0
    <cfif ARGUMENTS.ship_rate_id NEQ ''>
    AND ship_rate_id = <cfqueryparam value="#ARGUMENTS.ship_rate_id#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(exception_type) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(exception_code) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">)
    </cfif>
    <cfif ARGUMENTS.ship_carrier NEQ ''>
    AND UPPER(ship_carrier) IN (<cfqueryparam value="#UCASE(ARGUMENTS.ship_carrier)#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    <cfif ARGUMENTS.ship_method NEQ ''>
    AND UPPER(ship_method) IN (<cfqueryparam value="#UCASE(ARGUMENTS.ship_method)#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    <cfif ARGUMENTS.exception_type NEQ ''>
    AND UPPER(exception_type) IN (<cfqueryparam value="#UCASE(ARGUMENTS.exception_type)#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    <cfif ARGUMENTS.exception_code NEQ ''>
    AND UPPER(exception_code) IN (<cfqueryparam value="#UCASE(ARGUMENTS.exception_code)#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsShipRateExceptione = StructNew()>
    <cfset rsShipRateException.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsShipRateException>
    </cffunction>
</cfcomponent>