<cfcomponent>
    <cffunction name="getBSO" access="public" returntype="query" hint="Get BSO data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="ID" type="numeric" required="yes" default="0">
    <cfargument name="excludeID" type="numeric" required="yes" default="0">
	<cfargument name="siteNo" type="string" required="yes" default="100">
    <cfargument name="bsoPONo" type="string" required="yes" default="">
    <cfargument name="bsosID" type="string" required="yes" default="0">
    <cfargument name="bsoStatus" type="string" required="yes" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="bsoDate DESC">
    <cfset var rsBSO = "" >
    <cftry>
    <cfquery name="rsBSO" datasource="#application.mcmsDSN#">
    SELECT * FROM v_bs_order WHERE 0=0
    <cfif ARGUMENTS.ID NEQ 0>
    AND ID = <cfqueryparam value="#ARGUMENTS.ID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.excludeID NEQ 0>
    AND ID <> <cfqueryparam value="#ARGUMENTS.excludeID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(bsoPONo) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(bsocLName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">)
    </cfif>
	<cfif ARGUMENTS.siteNo NEQ 100>
    AND siteNo IN (<cfqueryparam value="#ARGUMENTS.siteNo#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    <cfif ARGUMENTS.bsoPONo NEQ "">
    AND UPPER(bsoPONo) = <cfqueryparam value="#UCASE(ARGUMENTS.bsoPONo)#" cfsqltype="cf_sql_varchar">
    </cfif>
    <cfif ARGUMENTS.bsosID NEQ 0>
    AND bsosID = <cfqueryparam value="#ARGUMENTS.bsosID#" cfsqltype="cf_sql_integer">
    </cfif>
    AND bsoStatus IN (<cfqueryparam value="#ARGUMENTS.bsoStatus#" list="yes" cfsqltype="cf_sql_integer">)
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsBSO = StructNew()>
    <cfset rsBSO.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsBSO>
    </cffunction>

	<cffunction name="getBSOLog" access="public" returntype="query" hint="Get BSO Log data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="ID" type="numeric" required="yes" default="0">
    <cfargument name="excludeID" type="numeric" required="yes" default="0">
	<cfargument name="siteNo" type="string" required="yes" default="100">
    <cfargument name="bsoID" type="numeric" required="yes" default="">
    <cfargument name="bsolStatus" type="string" required="yes" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="bsolDate DESC">
    <cfset var rsBSOLog = "" >
    <cftry>
    <cfquery name="rsBSOLog" datasource="#application.mcmsDSN#">
    SELECT * FROM v_bso_log WHERE 0=0
    <cfif ARGUMENTS.ID NEQ 0>
    AND ID = <cfqueryparam value="#ARGUMENTS.ID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.excludeID NEQ 0>
    AND ID <> <cfqueryparam value="#ARGUMENTS.excludeID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(bsoPONo) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(bsolLog) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">)
    </cfif>
	<cfif ARGUMENTS.siteNo NEQ 100>
    AND siteNo IN (<cfqueryparam value="#ARGUMENTS.siteNo#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    <cfif ARGUMENTS.bsoID NEQ 0>
    AND bsoID = <cfqueryparam value="#ARGUMENTS.bsoID#" cfsqltype="cf_sql_integer">
    </cfif>
    AND bsolStatus IN (<cfqueryparam value="#ARGUMENTS.bsolStatus#" list="yes" cfsqltype="cf_sql_integer">)
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsBSOLog = StructNew()>
    <cfset rsBSOLog.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsBSOLog>
    </cffunction>

	<cffunction name="getBSOSku" access="public" returntype="query" hint="Get BSO data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="ID" type="numeric" required="yes" default="0">
    <cfargument name="excludeID" type="numeric" required="yes" default="0">
    <cfargument name="bsoskuStatus" type="string" required="yes" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="bsoSkuSort, bsoSku">
    <cfset var rsBSOSku = "" >
    <cftry>
    <cfquery name="rsBSOSku" datasource="#application.mcmsDSN#">
    SELECT * FROM v_bso_sku WHERE 0=0
    <cfif ARGUMENTS.ID NEQ 0>
    AND ID = <cfqueryparam value="#ARGUMENTS.ID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.excludeID NEQ 0>
    AND ID <> <cfqueryparam value="#ARGUMENTS.excludeID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(bsoSku) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">)
    </cfif>
    AND bsoskuStatus IN (<cfqueryparam value="#ARGUMENTS.bsoskuStatus#" list="yes" cfsqltype="cf_sql_integer">)
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsBSOSku = StructNew()>
    <cfset rsBSOSku.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsBSOSku>
    </cffunction>

	<cffunction name="getBSOLine" access="public" returntype="query" hint="Get BSO Line data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="ID" type="numeric" required="yes" default="0">
    <cfargument name="excludeID" type="numeric" required="yes" default="0">
	<cfargument name="bsoID" type="numeric" required="yes" default="0">
	<cfargument name="bsoskuID" type="numeric" required="yes" default="0">
    <cfargument name="bsolStatus" type="string" required="yes" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="bsoID, bsoSkuSort">
    <cfset var rsBSOLine = "" >
    <cftry>
    <cfquery name="rsBSOLine" datasource="#application.mcmsDSN#">
    SELECT * FROM v_bso_line WHERE 0=0
    <cfif ARGUMENTS.ID NEQ 0>
    AND ID = <cfqueryparam value="#ARGUMENTS.ID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.excludeID NEQ 0>
    AND ID <> <cfqueryparam value="#ARGUMENTS.excludeID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(bsoSku) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">)
    </cfif>
	<cfif ARGUMENTS.bsoID NEQ 0>
    AND bsoID = <cfqueryparam value="#ARGUMENTS.bsoID#" cfsqltype="cf_sql_integer">
    </cfif>
	<cfif ARGUMENTS.bsoskuID NEQ 0>
    AND bsoskuID = <cfqueryparam value="#ARGUMENTS.bsoskuID#" cfsqltype="cf_sql_integer">
    </cfif>
    AND bsolStatus IN (<cfqueryparam value="#ARGUMENTS.bsolStatus#" list="yes" cfsqltype="cf_sql_integer">)
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsBSOLine = StructNew()>
    <cfset rsBSOLine.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsBSOLine>
    </cffunction>

	<cffunction name="getBSOCustomer" access="public" returntype="query" hint="Get BSO Customer data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="ID" type="numeric" required="yes" default="0">
    <cfargument name="excludeID" type="numeric" required="yes" default="0">
    <cfargument name="bsocFName" type="string" required="yes" default="">
    <cfargument name="bsocLName" type="string" required="yes" default="">
	<cfargument name="bsocTelephone" type="string" required="yes" default="">
    <cfargument name="bsocStatus" type="string" required="yes" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="ID">
    <cfset var rsBSOCustomer = "" >
    <cftry>
    <cfquery name="rsBSOCustomer" datasource="#application.mcmsDSN#">
    SELECT * FROM v_bso_customer WHERE 0=0
    <cfif ARGUMENTS.ID NEQ 0>
    AND ID = <cfqueryparam value="#ARGUMENTS.ID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.excludeID NEQ 0>
    AND ID <> <cfqueryparam value="#ARGUMENTS.excludeID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(bsocFName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(bsocLName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(bsocTelephone) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(bsocEmail) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">)
    </cfif>
	<cfif ARGUMENTS.bsocFName NEQ ''>
    AND UPPER(bsocFName) = <cfqueryparam value="#UCASE(ARGUMENTS.bsocFName)#" cfsqltype="cf_sql_varchar">
    </cfif>
	<cfif ARGUMENTS.bsocLName NEQ ''>
    AND UPPER(bsocLName) = <cfqueryparam value="#UCASE(ARGUMENTS.bsocLName)#" cfsqltype="cf_sql_varchar">
    </cfif>
	<cfif ARGUMENTS.bsocTelephone NEQ ''>
    AND UPPER(bsocTelephone) = <cfqueryparam value="#ARGUMENTS.bsocTelephone#" cfsqltype="cf_sql_varchar">
    </cfif>
    AND bsocStatus IN (<cfqueryparam value="#ARGUMENTS.bsocStatus#" list="yes" cfsqltype="cf_sql_integer">)
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsBSOCustomer = StructNew()>
    <cfset rsBSOCustomer.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsBSOCustomer>
    </cffunction>
    
    <cffunction name="getBSOAttributeType" access="public" returntype="query" hint="Get BSO Attribute Type data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="ID" type="string" required="yes" default="0">
    <cfargument name="excludeID" type="numeric" required="yes" default="0">
    <cfargument name="bsoatStatus" type="string" required="yes" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="bsoatSort">
    <cfset var rsBSOAttributeType = "" >
    <cftry>
    <cfquery name="rsBSOAttributeType" datasource="#application.mcmsDSN#">
    SELECT * FROM v_bsoa_type WHERE 0=0
    <cfif ARGUMENTS.ID NEQ 0>
    AND ID IN (<cfqueryparam value="#ARGUMENTS.ID#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    <cfif ARGUMENTS.excludeID NEQ 0>
    AND ID <> <cfqueryparam value="#ARGUMENTS.excludeID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND UPPER(bsoatName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">
    </cfif>
    AND bsoatStatus IN (<cfqueryparam value="#ARGUMENTS.bsoatStatus#" list="yes" cfsqltype="cf_sql_integer">)
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsBSOAttributeType = StructNew()>
    <cfset rsBSOAttributeType.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsBSOAttributeType>
    </cffunction>

	<cffunction name="getBSOAttribute" access="public" returntype="query" hint="Get BSO Attribute data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="ID" type="numeric" required="yes" default="0">
    <cfargument name="excludeID" type="string" required="yes" default="0">
	<cfargument name="bsoatID" type="numeric" required="yes" default="0">
    <cfargument name="bsoaStatus" type="string" required="yes" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="bsoaSort, bsoatSort">
    <cfset var rsBSOAttribute = "" >
    <cftry>
    <cfquery name="rsBSOAttribute" datasource="#application.mcmsDSN#">
    SELECT * FROM v_bso_attribute WHERE 0=0
    <cfif ARGUMENTS.ID NEQ 0>
    AND ID = <cfqueryparam value="#ARGUMENTS.ID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.excludeID NEQ 0>
    AND ID NOT IN (<cfqueryparam value="#ARGUMENTS.excludeID#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(bsoaName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(bsoaValue) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(bsoatName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">)
    </cfif>
	<cfif ARGUMENTS.bsoatID NEQ 0>
    AND bsoatID = <cfqueryparam value="#ARGUMENTS.bsoatID#" cfsqltype="cf_sql_integer">
    </cfif>
    AND bsoatStatus IN (<cfqueryparam value="#ARGUMENTS.bsoaStatus#" list="yes" cfsqltype="cf_sql_integer">)
	AND bsoaStatus IN (<cfqueryparam value="#ARGUMENTS.bsoaStatus#" list="yes" cfsqltype="cf_sql_integer">)
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsBSOAttribute = StructNew()>
    <cfset rsBSOAttribute.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsBSOAttribute>
    </cffunction>

	<cffunction name="getBSOStatus" access="public" returntype="query" hint="Get BSO Status data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="ID" type="numeric" required="yes" default="0">
    <cfargument name="excludeID" type="numeric" required="yes" default="0">
    <cfargument name="bsosID" type="string" required="yes" default="0">
	<cfargument name="bsosStatus" type="string" required="yes" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="bsosSort">
    <cfset var rsBSOStatus = "" >
    <cftry>
    <cfquery name="rsBSOStatus" datasource="#application.mcmsDSN#">
    SELECT * FROM v_bso_status WHERE 0=0
    <cfif ARGUMENTS.ID NEQ 0>
    AND ID = <cfqueryparam value="#ARGUMENTS.ID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.excludeID NEQ 0>
    AND ID <> <cfqueryparam value="#ARGUMENTS.excludeID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(bsosName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">)
    </cfif>
	<!---Processing--->
	<cfif ARGUMENTS.bsosID EQ 1>
    AND ID IN (<cfqueryparam value="1,6" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
	<!---Ordered--->
	<cfif ARGUMENTS.bsosID EQ 2>
    AND ID IN (<cfqueryparam value="2,3,6" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
	<!---Purchased--->
	<cfif ARGUMENTS.bsosID EQ 3>
    AND ID IN (<cfqueryparam value="3,4" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
	<!---Received--->
	<cfif ARGUMENTS.bsosID EQ 4>
    AND ID IN (<cfqueryparam value="4,5" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
	<!---Completed--->
	<cfif ARGUMENTS.bsosID EQ 5>
    AND ID IN (<cfqueryparam value="5" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
	<!---Cancelled--->
	<cfif ARGUMENTS.bsosID EQ 6>
    AND ID IN (<cfqueryparam value="6" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
	AND bsosStatus IN (<cfqueryparam value="#ARGUMENTS.bsosStatus#" list="yes" cfsqltype="cf_sql_integer">)
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsBSOStatus = StructNew()>
    <cfset rsBSOStatus.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsBSOStatus>
    </cffunction>
    
    <cffunction name="getBSOReport" access="public" returntype="query" hint="Get BSO Report data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
	<cfargument name="siteNo" type="string" required="yes" default="100">
	<cfargument name="deptNo" type="numeric" required="yes" default="0">
    <cfargument name="args" type="string" required="yes" default="0">
    <cfargument name="orderBy" type="string" required="yes" default="ID">
    <cfset var rsBSOReport = "" >
    <cftry>
    <cfquery name="rsBSOReport" datasource="#application.mcmsDSN#">
    SELECT bsoPONo AS PO, bsoReceiptNo As Receipt_No, posID AS Register, siteNo AS Site_No, siteName AS Site, bsocFName || ' ' || bsocLName AS Customer, bsocTelephone AS Telephone, bsocEmail AS Customer_Email, bsocAddress AS Address, bsocAddressAlt AS Address_Alt, bsocZip || ' ' || bsocZipExt AS ZipCode, spName AS State_Prov, cntryName AS Country, bsoSH AS Shipping_Handling, bsoSubtotal AS Subtotal, bsoTax as Tax, bsoTotal as Total, bsosName AS Status, TO_CHAR(bsoDateUpdate, 'mm/dd/yyyy') As Update_Date, TO_CHAR(bsoDateOrdered, 'mm/dd/yyyy') As Order_Date, TO_CHAR(bsoDateReceived, 'mm/dd/yyyy') As Received_Date, TO_CHAR(bsoDate, 'mm/dd/yyyy') As Completed_Date, userFNameOrdered || ' ' || userLNameOrdered AS Ordered_By, userFNameReceived || ' ' || userLNameReceived AS Received_By, userFNameCancelled || ' ' || userLNameCancelled AS Cancelled_By, userFNameCompleted || ' ' || userLNameCompleted AS Completed_By FROM v_bs_order WHERE 0=0
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(bsoPONo) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(bsocLName) LIKE 	<cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">)
    </cfif>
	<cfif ARGUMENTS.siteNo NEQ 100>
    AND siteNo IN (<cfqueryparam value="#ARGUMENTS.siteNo#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    <cfif ListGetAt(ARGUMENTS.args, 1) NEQ 0>
    AND bsosID = <cfqueryparam value="#ListGetAt(ARGUMENTS.args, 1)#" cfsqltype="cf_sql_integer">
    </cfif>
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsBSOReport = StructNew()>
    <cfset rsBSOReport.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsBSOReport>
    </cffunction>

	<cffunction name="getBSOCustomerReport" access="public" returntype="query" hint="Get BSO Report data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="orderBy" type="string" required="yes" default="bsocLName">
    <cfset var rsBSOCustomerReport = "" >
    <cftry>
    <cfquery name="rsBSOCustomerReport" datasource="#application.mcmsDSN#">
    SELECT bsocFName || ' ' || bsocLName AS Customer, bsocTelephone AS Telephone, bsocEmail AS Customer_Email, bsocAddress AS Address, bsocAddressAlt AS Address_Alt, bsocZip || ' ' || bsocZipExt AS ZipCode, spName AS State_Prov, cntryName AS Country FROM v_bso_customer WHERE 0=0
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(bsocFName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(bsocLName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(bsocTelephone) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(bsocEmail) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">)
    </cfif>
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsBSOCustomerReport = StructNew()>
    <cfset rsBSOCustomerReport.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsBSOCustomerReport>
    </cffunction>
    
    <cffunction name="insertBSO" access="public" returntype="struct">
    <cfargument name="siteNo" type="numeric" required="yes">
    <cfargument name="bsocFName" type="string" required="yes">
    <cfargument name="bsocLName" type="string" required="yes">
    <cfargument name="bsocTelephone" type="string" required="yes">
    <cfargument name="bsocEmail" type="string" required="yes">
	<cfargument name="bsocAddress" type="string" required="yes">
	<cfargument name="bsocAddressAlt" type="string" required="yes">
	<cfargument name="bsocZip" type="string" required="yes">
	<cfargument name="bsocZipExt" type="string" required="yes">
	<cfargument name="stateProvID" type="numeric" required="yes">
	<cfargument name="countryID" type="numeric" required="yes">
    <cfset result.message = "You have successfully created the Order No. You will now be redirected to the order for further processing.">
    <cftry>
    <!---Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.app.bso.BSO"
    method="getBSOCustomer"
    returnvariable="getCheckBSOCustomerRet">
    <cfinvokeargument name="bsocFName" value="#ARGUMENTS.bsocFName#"/>
	<cfinvokeargument name="bsocLName" value="#ARGUMENTS.bsocLName#"/>
	<cfinvokeargument name="bsocTelephone" value="#ARGUMENTS.bsocTelephone#"/>
    <cfinvokeargument name="bsocStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckBSOCustomerRet.recordcount NEQ 0>
    <cfset this.bsocID = getCheckBSOCustomerRet.ID>
	<cfelse>
	<!---Insert the customer.--->
	<cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    INSERT INTO tbl_bso_customer (bsocFName, bsocLName, bsocTelephone, bsocEmail, bsocAddress, bsocAddressAlt, bsocZip, bsocZipExt, stateProvID, countryID, userID, bsocStatus) VALUES
    (
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.bsocFName#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.bsocLName#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.bsocTelephone#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.bsocEmail#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.bsocAddress#">,
	<cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.bsocAddressAlt#">,
	<cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.bsocZip#">,
	<cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.bsocZipExt#">,
	<cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.stateProvID#">,
	<cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.countryID#">,
	<cfqueryparam cfsqltype="cf_sql_integer" value="#session.userID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="1">
    )
    </cfquery>
	<!---Get latest customer id.--->
    <cfinvoke 
    component="MCMS.component.cms.Cms"
    method="getMaxValueSQL"
    returnvariable="bsocID">
    <cfinvokeargument name="tableName" value="tbl_bso_customer"/>
    </cfinvoke>
    <cfset this.bsocID = bsocID>
    </cftransaction>
    </cfif>
	<!---Create the order.--->
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    INSERT INTO tbl_bs_order (siteNo, bsocID, userID) VALUES
    (
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.siteNo#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#this.bsocID#">,
	<cfqueryparam cfsqltype="cf_sql_integer" value="#session.userID#">
    )
    </cfquery>
	<!---Get latest customer id.--->
    <cfinvoke 
    component="MCMS.component.cms.Cms"
    method="getMaxValueSQL"
    returnvariable="bsoID">
    <cfinvokeargument name="tableName" value="tbl_bs_order"/>
    </cfinvoke>
    <cfset this.bsoID = bsoID>
    </cftransaction>
	<!---Forward to update form.--->
    <cfset ajaxOnLoad("function() {
    lAjax('layoutIndex', #url.appID#, 'Order' ,'/#application.mcmsAppAdminPath#/bso/view/inc_bso.cfm','Order','update', #this.bsoID#);
    }")>
    <cfcatch type="any">
    <cfset result.message = "There was an error inserting the record.">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>

	<cffunction name="insertBSOLine" access="public" returntype="struct">
    <cfargument name="bsoID" type="numeric" required="yes">
    <cfargument name="bsoskuID" type="numeric" required="yes">
    <cfargument name="bsoaBowMakeID" type="string" required="yes">
	<cfargument name="bsoaBowMakeOther" type="string" required="yes" default="">
    <cfargument name="bsoaBowModel" type="string" required="yes">
	<cfargument name="bsoaCamType" type="string" required="yes">
    <cfargument name="bsoaColor1" type="string" required="yes">
	<cfargument name="bsoaColor2" type="string" required="yes">
	<cfargument name="bsolLength" type="string" required="yes">
	<cfargument name="bsolQty" type="numeric" required="yes">
    <cfset result.message = "You have successfully add the sku(s).">
    <cftry>
    <!---Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.app.bso.BSO"
    method="getBSOLine"
    returnvariable="getCheckBSOLineRet">
    <cfinvokeargument name="bsoID" value="#ARGUMENTS.bsoID#"/>
	<cfinvokeargument name="bsoskuID" value="#ARGUMENTS.bsoskuID#"/>
    <cfinvokeargument name="bsolStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckBSOLineRet.recordcount NEQ 0>
    <cfset result.message = "The sku #getCheckBSOLineRet.bsoSku# already exists, please enter a sku.">
	<cfelse>
	<!---Switch color ID's--->
	<cfif bsoaColor1 EQ 'color1Default'>
	<cfset ARGUMENTS.bsoaColor1 = "Hunter-Green">
	</cfif>
	<cfif bsoaColor2 EQ 'color2Default'>
	<cfset ARGUMENTS.bsoaColor2 = "Brown">
	</cfif>

	<!--Swap the bsoaBowMakeID for "Other".--->
	<cfif ARGUMENTS.bsoaBowMakeOther NEQ ''>
	<cfset ARGUMENTS.bsoaBowMakeID = 0>
	</cfif>
	
	<!---Insert the sku line.--->
	<cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    INSERT INTO tbl_bso_line (bsoID, bsoskuID, bsoaBowMakeID, bsoaBowMakeOther, bsoaBowModel, bsoaCamType, bsoaColor1, bsoaColor2, bsolLength, bsolQty) VALUES
    (
	<cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.bsoID#">,
	<cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.bsoskuID#">,
	<cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.bsoaBowMakeID#">,
	<cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.bsoaBowMakeOther#">,
	<cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.bsoaBowModel#">,
	<cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.bsoaCamType#">,
	<cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.bsoaColor1#">,
	<cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.bsoaColor2#">,
	<cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.bsolLength#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.bsolQty#">
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

	<cffunction name="insertBSOLog" access="public" returntype="struct">
    <cfargument name="bsoID" type="numeric" required="yes">
    <cfargument name="bsolLog" type="string" required="yes">
    <cfset result.message = "You have successfully added the log.">
    <cftry>
	<!---Insert the log.--->
	<cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    INSERT INTO tbl_bso_log (bsoID, bsolLog, userID) VALUES
    (
	<cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.bsoID#">,
	<cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.bsolLog#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#session.userID#">
    )
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error inserting the record.">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>

	<cffunction name="updateBSOCustomer" access="public" returntype="struct">
    <cfargument name="ID" type="numeric" required="yes">
    <cfargument name="bsocFName" type="string" required="yes">
    <cfargument name="bsocLName" type="string" required="yes">
    <cfargument name="bsocEmail" type="string" required="yes">
    <cfargument name="bsocTelephone" type="string" required="yes">
    <cfargument name="bsocAddress" type="string" required="yes">
    <cfargument name="bsocAddressAlt" type="string" required="yes">
	<cfargument name="bsocZip" type="string" required="yes">
	<cfargument name="bsocZipExt" type="string" required="yes">
    <cfargument name="stateProvID" type="numeric" required="yes">
    <cfargument name="countryID" type="numeric" required="yes">
    <cfargument name="bsocStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully updated the record.">
    <cftry>
    <!---Check for a duplicate record.--->
	<cfinvoke 
    component="MCMS.component.app.bso.BSO"
    method="getBSOCustomer"
    returnvariable="getCheckBSOCustomerRet">
	<cfinvokeargument name="excludeID" value="#ARGUMENTS.ID#"/>
    <cfinvokeargument name="bsocFName" value="#ARGUMENTS.bsocFName#"/>
	<cfinvokeargument name="bsocLName" value="#ARGUMENTS.bsocLName#"/>
	<cfinvokeargument name="bsocTelephone" value="#ARGUMENTS.bsocTelephone#"/>
    <cfinvokeargument name="bsocStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckBSOCustomerRet.recordcount NEQ 0>
    <cfset result.message = "The customer already exists with this Telephone No., please enter a Telephone No.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_bso_customer SET
    bsocFName = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.bsocFName#">,
    bsocLName = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.bsocLName#">,
    bsocEmail = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.bsocEmail#">,
    bsocTelephone = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.bsocTelephone#">,
    bsocAddress = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.bsocAddress#">,
    bsocAddressAlt = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.bsocAddressAlt#">,
	bsocZip = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.bsocZip#">,
	bsocZipExt = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.bsocZipExt#">,
    stateProvID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.stateProvID#">,
    countryID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.countryID#">,
    bsocStatus = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.bsocStatus#">
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
    
    <cffunction name="updateBSO" access="public" returntype="struct">
    <cfargument name="ID" type="numeric" required="yes">
    <cfargument name="bsoPONo" type="string" required="yes">
    <cfargument name="bsosID" type="numeric" required="yes">
	<cfargument name="userEmail" type="string" required="yes">
	<cfargument name="bsolLog" type="string" required="yes" default="">
    <cfset result.message = "You have successfully updated the order.">
    <cftry>
	<cfset this.sendEmail = 'false'>
	<!---Set the email subject.--->
	<cfset this.emailSubject = "Bow String Order No. #ARGUMENTS.ID#">
	<!---Set the status ID based on current status ID.--->
	<cfset this.bsosID = ARGUMENTS.bsosID>
	<!---Set to "Purchased" when PO No. is entered.--->
	<cfif this.bsosID EQ 2 AND ARGUMENTS.bsoPONo NEQ ''>
	<cfset this.sendEmail = 'true'>
	<cfset this.bsosID = 3>
	<cfset this.emailSubject = "Bow String Order No. #ARGUMENTS.ID# - PURCHASED">
	</cfif>
	<!---Send email to all parties if the order is cancelled.--->
	<cfif this.bsosID EQ 6>
	<cfset this.sendEmail = 'true'>
	<cfset this.bsosID = 6>
	<cfset this.emailSubject = "Bow String Order No. #ARGUMENTS.ID# - CANCELLED">
	</cfif>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_bs_order SET
	bsoDateUpdate = <cfqueryparam cfsqltype="cf_sql_timestamp" value="#CreateODBCDateTime(Now())#">,
	bsoPONo = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.bsoPONo#">,
	<cfif ARGUMENTS.bsosID EQ 2>
	bsoDateOrdered = <cfqueryparam cfsqltype="cf_sql_timestamp" value="#CreateODBCDateTime(Now())#">,
	userIDOrdered = <cfqueryparam cfsqltype="cf_sql_integer" value="#session.userID#">,
	</cfif>
	<cfif ARGUMENTS.bsosID EQ 4>
	bsoDateReceived = <cfqueryparam cfsqltype="cf_sql_timestamp" value="#CreateODBCDateTime(Now())#">,
	userIDReceived = <cfqueryparam cfsqltype="cf_sql_integer" value="#session.userID#">,
	</cfif>
	<cfif ARGUMENTS.bsosID EQ 5>
	bsoDateCompleted = <cfqueryparam cfsqltype="cf_sql_timestamp" value="#CreateODBCDateTime(Now())#">,
	userIDCompleted = <cfqueryparam cfsqltype="cf_sql_integer" value="#session.userID#">,
	</cfif>
	<cfif ARGUMENTS.bsosID EQ 6>
	userIDCancelled = <cfqueryparam cfsqltype="cf_sql_integer" value="#session.userID#">,
	</cfif>
    bsosID = <cfqueryparam cfsqltype="cf_sql_integer" value="#this.bsosID#">
    WHERE ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ID#">
    </cfquery>
    </cftransaction>
	<cfif ARGUMENTS.bsolLog NEQ ''>
	<cfinvoke 
  	component="MCMS.component.app.bso.BSO" 
  	method="insertBSOLog">
  	<cfinvokeargument name="bsoID" value="#ARGUMENTS.ID#">
	<cfinvokeargument name="bsolLog" value="#ARGUMENTS.bsolLog#">
  	</cfinvoke>
	</cfif>
	<!--- Send reminder email notification. --->
	<cfif this.sendEmail EQ true>
    <cfinvoke 
    component="MCMS.component.utility.Email"
    method="sendEmail">
    <cfinvokeargument name="subject" value="#this.emailSubject#"/>
    <cfinvokeargument name="to" value="#ARGUMENTS.userEmail#"/>
    <cfinvokeargument name="from" value="#session.userUsername#"/>
    <cfinvokeargument name="body" value=""/>
    <cfinvokeargument name="ID" value="#ARGUMENTS.ID#"/>
    <cfinvokeargument name="emailTemplate" value="/#application.mcmsAppAdminPath#/bso/view/inc_bso_email_template.cfm"/>
    </cfinvoke>
	</cfif>
    <cfcatch type="any">
    <cfset result.message = "There was an error updating the record.">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>

	<cffunction name="updateBSOLine" access="public" returntype="struct">
    <cfargument name="ID" type="numeric" required="yes">
	<cfargument name="bsolLength" type="string" required="yes">
    <cfargument name="bsoskuQty" type="numeric" required="yes">
    <cfset result.message = "You have successfully updated the order.">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_bso_line SET
	bsolLength = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.bsolLength#">,
    bsolQty = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.bsoskuQty#">
    WHERE ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ID#">
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error updating the record.">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>

	<cffunction name="updateBSOShippingHandling" access="public" returntype="struct">
    <cfargument name="ID" type="numeric" required="yes">
	<cfargument name="posID" type="string" required="yes" default="">
	<cfargument name="bsoReceiptNo" type="string" required="yes" default="">
    <cfargument name="bsoSH" type="string" required="yes">
	<cfargument name="bsoTax" type="string" required="yes" default="">
	<cfargument name="bsoSubTotal" type="string" required="yes" default="">
    <cfset result.message = "You have successfully updated the order.">
    <cftry>
	<cfset this.bsoSubTotal = ARGUMENTS.bsoSH+ARGUMENTS.bsoSubTotal>
    <cfif ARGUMENTS.posID NEQ ''>
	<cfset this.bsoTotal = ARGUMENTS.bsoTax+this.bsoSubTotal>
	<cfelse>
	<cfset this.bsoTotal = ''>
	</cfif>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_bs_order SET
    posID = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.posID#">,
	bsoReceiptNo = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.bsoReceiptNo#">,
	<cfif ARGUMENTS.bsoSH NEQ ''>
	bsoSH = <cfqueryparam cfsqltype="cf_sql_float" value="#ARGUMENTS.bsoSH#">,
	</cfif>
	<cfif ARGUMENTS.bsoTax NEQ ''>
	bsoTax = <cfqueryparam cfsqltype="cf_sql_float" value="#ARGUMENTS.bsoTax#">,
	</cfif>
	bsoSubTotal = <cfqueryparam cfsqltype="cf_sql_float" value="#this.bsoSubTotal#">,
	<cfif this.bsoTotal NEQ ''>
	bsoTotal = <cfqueryparam cfsqltype="cf_sql_float" value="#this.bsoTotal#">,
	</cfif>
    bsoDateUpdate = <cfqueryparam cfsqltype="cf_sql_timestamp" value="#CreateODBCDateTime(Now())#">
    WHERE ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ID#">
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error updating the record.">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>

	<cffunction name="updateBSOPlaceOrder" access="public" returntype="struct">
    <cfargument name="ID" type="numeric" required="yes">
	<cfargument name="posID" type="string" required="yes" default="">
	<cfargument name="bsoReceiptNo" type="string" required="yes" default="">
    <cfargument name="bsoSH" type="string" required="yes">
	<cfargument name="bsoTax" type="string" required="yes" default="">
	<cfargument name="bsoSubTotal" type="string" required="yes" default="">
	<cfargument name="bsosID" type="numeric" required="yes">
	<cfargument name="bsolLog" type="string" required="yes" default="">
    <cfset result.message = "You have successfully placed the order.">
    <cftry>
	<cfset this.bsoSubTotal = ARGUMENTS.bsoSH+ARGUMENTS.bsoSubTotal>
    <cfif ARGUMENTS.posID NEQ ''>
	<cfset this.bsoTotal = ARGUMENTS.bsoTax+this.bsoSubTotal>
	<cfelse>
	<cfset this.bsoTotal = ''>
	</cfif>
	<cfset this.bsosID = 2>
	<cfset this.emailSubject = "Bow String Order No. #ARGUMENTS.ID# - ORDERED">
	<cfif ARGUMENTS.bsosID EQ 6>
	<cfset this.bsosID = 6>
	<cfset this.emailSubject = "Bow String Order No. #ARGUMENTS.ID# - CANCELLED">
	<cfset result.message = "You have successfully cancelled the order.">
	</cfif>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_bs_order SET
    posID = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.posID#">,
	bsoReceiptNo = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.bsoReceiptNo#">,
	<cfif ARGUMENTS.bsoSH NEQ ''>
	bsoSH = <cfqueryparam cfsqltype="cf_sql_float" value="#ARGUMENTS.bsoSH#">,
	</cfif>
	<cfif ARGUMENTS.bsoTax NEQ ''>
	bsoTax = <cfqueryparam cfsqltype="cf_sql_float" value="#ARGUMENTS.bsoTax#">,
	</cfif>
	bsoSubTotal = <cfqueryparam cfsqltype="cf_sql_float" value="#this.bsoSubTotal#">,
	<cfif this.bsoTotal NEQ ''>
	bsoTotal = <cfqueryparam cfsqltype="cf_sql_float" value="#this.bsoTotal#">,
	</cfif>
    bsoDateUpdate = <cfqueryparam cfsqltype="cf_sql_timestamp" value="#CreateODBCDateTime(Now())#">,
	bsoDateOrdered = <cfqueryparam cfsqltype="cf_sql_timestamp" value="#CreateODBCDateTime(Now())#">,
	userIDOrdered = <cfqueryparam cfsqltype="cf_sql_integer" value="#session.userID#">,
	bsosID = <cfqueryparam cfsqltype="cf_sql_integer" value="#this.bsosID#">
    WHERE ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ID#">
    </cfquery>
    </cftransaction>
	<cfif ARGUMENTS.bsolLog NEQ ''>
	<cfinvoke 
  	component="MCMS.component.app.bso.BSO" 
  	method="insertBSOLog">
  	<cfinvokeargument name="bsoID" value="#ARGUMENTS.ID#">
	<cfinvokeargument name="bsolLog" value="#ARGUMENTS.bsolLog#">
  	</cfinvoke>
	</cfif>
	<!--- Send email notification. --->
    <cfinvoke 
    component="MCMS.component.utility.Email"
    method="sendEmail">
    <cfinvokeargument name="subject" value="#this.emailSubject#"/>
    <cfinvokeargument name="to" value="#application.bsoBuyerEmail#"/>
    <cfinvokeargument name="from" value="#session.userUsername#"/>
    <cfinvokeargument name="body" value=""/>
    <cfinvokeargument name="ID" value="#ARGUMENTS.ID#"/>
    <cfinvokeargument name="emailTemplate" value="/#application.mcmsAppAdminPath#/bso/view/inc_bso_email_template.cfm"/>
    </cfinvoke>
    <cfcatch type="any">
    <cfset result.message = "There was an error updating the record.">
    
    </cfcatch>
    </cftry>
    <cfreturn result>

    </cffunction>
    
    <cffunction name="updateBSOList" access="public" returntype="struct">
    <cfargument name="ID" type="numeric" required="yes">
    <cfargument name="bsoStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully updated the records.">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_bs_order SET
    bsoStatus = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.bsoStatus#">
    WHERE ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ID#">
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error updating the records.">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="deleteBSO" access="public" returntype="struct">
    <cfargument name="ID" type="string" required="yes">
    <cfset result.message = "You have successfully deleted the record(s).">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    DELETE FROM tbl_bs_order
    WHERE ID IN (<cfqueryparam cfsqltype="cf_sql_integer" list="yes" value="#ARGUMENTS.ID#">)
    </cfquery>
    </cftransaction>
	<cfinvoke 
  	component="MCMS.component.app.bso.BSO" 
  	method="deleteBSOLine">
  	<cfinvokeargument name="bsoID" value="#ARGUMENTS.ID#">
  	</cfinvoke>
	<cfinvoke 
  	component="MCMS.component.app.bso.BSO" 
  	method="deleteBSOLog">
  	<cfinvokeargument name="bsoID" value="#ARGUMENTS.ID#">
  	</cfinvoke>
    <cfcatch type="any">
    <cfset result.message = "There was an error deleting the record(s).">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>

	<cffunction name="deleteBSOLine" access="public" returntype="struct">
    <cfargument name="ID" type="string" required="yes" default="0">
	<cfargument name="bsoID" type="string" required="yes" default="0">
    <cfset result.message = "You have successfully deleted the record(s).">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    DELETE FROM tbl_bso_line
    WHERE (ID IN (<cfqueryparam cfsqltype="cf_sql_integer" list="yes" value="#ARGUMENTS.ID#">)
	OR bsoID IN (<cfqueryparam cfsqltype="cf_sql_integer" list="yes" value="#ARGUMENTS.bsoID#">))
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error deleting the record(s).">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>  

	<cffunction name="deleteBSOLog" access="public" returntype="struct">
    <cfargument name="ID" type="string" required="yes" default="0">
	<cfargument name="bsoID" type="string" required="yes" default="0">
    <cfset result.message = "You have successfully deleted the record(s).">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    DELETE FROM tbl_bso_log
    WHERE (ID IN (<cfqueryparam cfsqltype="cf_sql_integer" list="yes" value="#ARGUMENTS.ID#">)
	OR bsoID IN (<cfqueryparam cfsqltype="cf_sql_integer" list="yes" value="#ARGUMENTS.bsoID#">))
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error deleting the record(s).">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction> 
</cfcomponent>