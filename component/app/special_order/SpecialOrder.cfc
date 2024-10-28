<cfcomponent>
    <cffunction name="getSpecialOrder" access="public" returntype="query" hint="Get Special Order data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="ID" type="string" required="yes" default="0">
    <cfargument name="excludeID" type="numeric" required="yes" default="0">
    <cfargument name="siteNo" type="string" required="yes" default="100">
    <cfargument name="deptNo" type="string" required="yes" default="0">
    <cfargument name="userID" type="numeric" required="yes" default="0">
    <cfargument name="userIDAssigned" type="numeric" required="yes" default="0">
    <cfargument name="vID" type="numeric" required="yes" default="0">
    <cfargument name="csttID" type="numeric" required="yes" default="0">
    <cfargument name="cstLName" type="string" required="yes" default="">
    <cfargument name="sosID" type="string" required="yes" default="0">
    <cfargument name="soStatus" type="string" required="yes" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="cstLName">
    <cfset var rsSpecialOrder = "" >
    <cftry>
    <cfquery name="rsSpecialOrder" datasource="#application.mcmsDSN#">
    SELECT * FROM v_special_order WHERE 0=0
    <cfif ARGUMENTS.ID NEQ 0 AND ARGUMENTS.ID NEQ ''>
    AND ID = <cfqueryparam value="#ARGUMENTS.ID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.excludeID NEQ 0>
    AND ID <> <cfqueryparam value="#ARGUMENTS.excludeID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(cstLName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(userLName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"><cfif IsNumeric(ARGUMENTS.keywords)> OR ID LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"></cfif>)
    </cfif>
    <cfif ARGUMENTS.siteNo NEQ 100>
    AND siteNo IN (<cfqueryparam value="#ARGUMENTS.siteNo#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    <cfif ARGUMENTS.deptNo NEQ 0>
    AND deptNo IN (<cfqueryparam value="#ARGUMENTS.deptNo#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    <cfif ARGUMENTS.userID NEQ 0>
    AND userID = <cfqueryparam value="#ARGUMENTS.userID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.userIDAssigned NEQ 0>
    AND userIDAssigned = <cfqueryparam value="#ARGUMENTS.userIDAssigned#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.vID NEQ 0>
    AND vID = <cfqueryparam value="#ARGUMENTS.vID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.csttID NEQ 0>
    AND csttID = <cfqueryparam value="#ARGUMENTS.csttID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.cstLName NEQ "">
    AND UPPER(cstLName) = <cfqueryparam value="#UCASE(ARGUMENTS.cstLName)#" cfsqltype="cf_sql_varchar">
    </cfif>
    <cfif ARGUMENTS.sosID NEQ 0>
    AND sosID IN (<cfqueryparam value="#ARGUMENTS.sosID#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    AND soStatus IN (<cfqueryparam value="#ARGUMENTS.soStatus#" list="yes" cfsqltype="cf_sql_integer">)
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsSpecialOrder = StructNew()>
    <cfset rsSpecialOrder.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsSpecialOrder>
    </cffunction>
    
    <cffunction name="getSpecialOrderStatus" access="public" returntype="query" hint="Get Special Order Status data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="ID" type="numeric" required="yes" default="0">
    <cfargument name="soID" type="numeric" required="yes" default="0">
    <cfargument name="sosID" type="numeric" required="yes" default="0">
    <cfargument name="excludeID" type="numeric" required="yes" default="0">
    <cfargument name="sosName" type="string" required="yes" default="">
    <cfargument name="sosStatus" type="string" required="yes" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="sosName">
    <cfset var rsSpecialOrderStatus = "" >
    <cftry>
    <!---Control the display of statuses based on sosID as part of the workflow.--->
    <cfif ARGUMENTS.sosID NEQ 0>
    <cfswitch expression="#ARGUMENTS.sosID#">
    <cfcase value="1">
    <cfset ARGUMENTS.excludeID = '2,4,5,6'> 
    </cfcase>
    <cfcase value="2">
    <!---Check for a requisition.--->
    <cfinvoke 
    component="MCMS.component.app.special_order.SpecialOrder"
    method="getSpecialOrderRequisition"
    returnvariable="getSpecialOrderRequisitionRet">
    <cfinvokeargument name="soID" value="#ARGUMENTS.soID#"/>
    <cfinvokeargument name="sorStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getSpecialOrderRequisitionRet.recordcount NEQ 0>
    <cfset ARGUMENTS.excludeID = '1,5,6'>
    <cfelse>
    <cfset ARGUMENTS.excludeID = '1,4,5'>
    </cfif> 
    </cfcase>
    <cfcase value="3">
    <cfset ARGUMENTS.excludeID = '1,2,4,5,6'> 
    </cfcase>
    <cfcase value="4">
    <!---Check to see the transactions equals the balance owed.--->
    <cfinvoke 
    component="MCMS.component.app.special_order.SpecialOrder"
    method="getSpecialOrder"
    returnvariable="getSpecialOrderRet">
    <cfinvokeargument name="ID" value="#ARGUMENTS.soID#"/>
    <cfinvokeargument name="soStatus" value="1"/>
    </cfinvoke>
    <cfset this.soBalance = getSpecialOrderRet.soBalance>
    <cfset this.totalTransactionAmount = '0.00'>
    <cfinvoke 
    component="MCMS.component.app.special_order.SpecialOrder"
    method="getSpecialOrderTransaction"
    returnvariable="getSpecialOrderTransactionRet">
    <cfinvokeargument name="ID" value="#ARGUMENTS.soID#"/>
    <cfinvokeargument name="sotStatus" value="1"/>
    </cfinvoke>
    <cfif getSpecialOrderTransactionRet.recordcount NEQ 0>
    <!---Check transactions for deposits and refunds and calculate.--->
    <cfloop query="getSpecialOrderTransactionRet">
    <!---Check for refund.--->
    <cfif getSpecialOrderTransactionRet.sottID EQ 3>
    <cfset this.totalTransactionAmount = this.totalTransactionAmount-getSpecialOrderTransactionRet.sotAmount>
    <cfelse>
    <cfset this.totalTransactionAmount = this.totalTransactionAmount+getSpecialOrderTransactionRet.sotAmount>
    </cfif>
    </cfloop>
    </cfif>
    <cfset amountOwed = this.soBalance-this.totalTransactionAmount>
    <cfif amountOwed EQ 0>
    <cfset ARGUMENTS.excludeID = '1,2'> 
    <cfelse>
    <cfset ARGUMENTS.excludeID = '1,2,5'> 
    </cfif>
    </cfcase>
    <cfcase value="5">
    <cfset ARGUMENTS.excludeID = '1,2,3,4'> 
    </cfcase>
    </cfswitch>
    </cfif>
    <cfquery name="rsSpecialOrderStatus" datasource="#application.mcmsDSN#">
    SELECT * FROM v_special_order_status WHERE 0=0
    <cfif ARGUMENTS.ID NEQ 0>
    AND ID = <cfqueryparam value="#ARGUMENTS.ID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.excludeID NEQ 0>
    AND ID NOT IN (<cfqueryparam value="#ARGUMENTS.excludeID#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND UPPER(sosName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">
    </cfif>
    <cfif ARGUMENTS.sosName NEQ "">
    AND sosName = <cfqueryparam value="#ARGUMENTS.sosName#" cfsqltype="cf_sql_varchar">
    </cfif>
    AND sosStatus IN (<cfqueryparam value="#ARGUMENTS.sosStatus#" list="yes" cfsqltype="cf_sql_integer">)
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsSpecialOrderStatus = StructNew()>
    <cfset rsSpecialOrderStatus.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsSpecialOrderStatus>
    </cffunction>
    
    <cffunction name="getSpecialOrderItem" access="public" returntype="query" hint="Get Special Order Item data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="ID" type="numeric" required="yes" default="0">
    <cfargument name="excludeID" type="numeric" required="yes" default="0">
    <cfargument name="soID" type="numeric" required="yes" default="0">
    <cfargument name="soiName" type="string" required="yes" default="">
    <cfargument name="soiStatus" type="string" required="yes" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="soiName">
    <cfset var rsSpecialOrderItem = "" >
    <cftry>
    <cfquery name="rsSpecialOrderItem" datasource="#application.mcmsDSN#">
    SELECT * FROM v_special_order_item WHERE 0=0
    <cfif ARGUMENTS.ID NEQ 0>
    AND ID = <cfqueryparam value="#ARGUMENTS.ID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.excludeID NEQ 0>
    AND ID <> <cfqueryparam value="#ARGUMENTS.excludeID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(soiName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(soiDescription) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(soiSKU) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(soiMPN) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(vendorName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">)
    </cfif>
    <cfif ARGUMENTS.soID NEQ 0>
    AND soID = <cfqueryparam value="#ARGUMENTS.soID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.soiName NEQ "">
    AND UPPER(soiName) = <cfqueryparam value="#UCASE(ARGUMENTS.soiName)#" cfsqltype="cf_sql_varchar">
    </cfif>
    AND soiStatus IN (<cfqueryparam value="#ARGUMENTS.soiStatus#" list="yes" cfsqltype="cf_sql_integer">)
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsSpecialOrderItem = StructNew()>
    <cfset rsSpecialOrderItem.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsSpecialOrderItem>
    </cffunction>
    
    <cffunction name="getSpecialOrderItemQuantitySum" access="public" returntype="string" hint="Get Special Order Item data and sum of item quantity.">
    <cfargument name="soID" type="numeric" required="yes" default="0">
    <cfargument name="soiStatus" type="string" required="yes" default="1,3">
    <cfset var rsSpecialOrderItemQuantitySum = "" >
    <cftry>
    <cfquery name="rsSpecialOrderItemQuantitySum" datasource="#application.mcmsDSN#">
    SELECT SUM(soiQuantity) AS total FROM v_special_order_item WHERE 0=0
    <cfif ARGUMENTS.soID NEQ 0>
    AND soID = <cfqueryparam value="#ARGUMENTS.soID#" cfsqltype="cf_sql_integer">
    </cfif>
    AND soiStatus IN (<cfqueryparam value="#ARGUMENTS.soiStatus#" list="yes" cfsqltype="cf_sql_integer">)
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsSpecialOrderItemQuantitySum = StructNew()>
    <cfset rsSpecialOrderItemQuantitySum.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfif rsSpecialOrderItemQuantitySum.total NEQ ''>
    <cfreturn rsSpecialOrderItemQuantitySum.total>
    <cfelse>
    <cfreturn 0>
    </cfif>
    </cffunction>
    
    <cffunction name="getSpecialOrderItemAttribute" access="public" returntype="query" hint="Get Special Order Item Attribute data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="ID" type="numeric" required="yes" default="0">
    <cfargument name="excludeID" type="numeric" required="yes" default="0">
    <cfargument name="soID" type="numeric" required="yes" default="0">
    <cfargument name="soiID" type="numeric" required="yes" default="0">
    <cfargument name="soiaName" type="string" required="yes" default="">
    <cfargument name="soiaStatus" type="string" required="yes" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="ID">
    <cfset var rsSpecialOrderItemAttribute = "" >
    <cftry>
    <cfquery name="rsSpecialOrderItemAttribute" datasource="#application.mcmsDSN#">
    SELECT * FROM v_so_item_attribute WHERE 0=0
    <cfif ARGUMENTS.ID NEQ 0>
    AND ID = <cfqueryparam value="#ARGUMENTS.ID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.excludeID NEQ 0>
    AND ID <> <cfqueryparam value="#ARGUMENTS.excludeID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND UPPER(sosiName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">
    </cfif>
    <cfif ARGUMENTS.soID NEQ 0>
    AND soID = <cfqueryparam value="#ARGUMENTS.soID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.soiID NEQ 0>
    AND soiID = <cfqueryparam value="#ARGUMENTS.soiID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.soiaName NEQ "">
    AND UPPER(soiaName) = <cfqueryparam value="#UCASE(ARGUMENTS.soiaName)#" cfsqltype="cf_sql_varchar">
    </cfif>
    AND soiaStatus IN (<cfqueryparam value="#ARGUMENTS.soiaStatus#" list="yes" cfsqltype="cf_sql_integer">)
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsSpecialOrderItemAttribute = StructNew()>
    <cfset rsSpecialOrderItemAttribute.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsSpecialOrderItemAttribute>
    </cffunction>
    
    <cffunction name="getSpecialOrderLog" access="public" returntype="query" hint="Get Special Order Log data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="ID" type="numeric" required="yes" default="0">
    <cfargument name="excludeID" type="numeric" required="yes" default="0">
    <cfargument name="soID" type="numeric" required="yes" default="0">
    <cfargument name="soltID" type="numeric" required="yes" default="0">
    <cfargument name="solStatus" type="string" required="yes" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="ID">
    <cfset var rsSpecialOrderLog = "" >
    <cftry>
    <cfquery name="rsSpecialOrderLog" datasource="#application.mcmsDSN#">
    SELECT * FROM v_special_order_log WHERE 0=0
    <cfif ARGUMENTS.ID NEQ 0>
    AND ID = <cfqueryparam value="#ARGUMENTS.ID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.excludeID NEQ 0>
    AND ID <> <cfqueryparam value="#ARGUMENTS.excludeID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND UPPER(solDescription) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">
    </cfif>
    <cfif ARGUMENTS.soID NEQ 0>
    AND soID = <cfqueryparam value="#ARGUMENTS.soID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.soltID NEQ 0>
    AND soltID = <cfqueryparam value="#ARGUMENTS.soltID#" cfsqltype="cf_sql_integer">
    </cfif>
    AND solStatus IN (<cfqueryparam value="#ARGUMENTS.solStatus#" list="yes" cfsqltype="cf_sql_integer">)
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsSpecialOrderLog = StructNew()>
    <cfset rsSpecialOrderLog.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsSpecialOrderLog>
    </cffunction>
    
    <cffunction name="getSpecialOrderLogType" access="public" returntype="query" hint="Get Special Order Log Type data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="ID" type="numeric" required="yes" default="0">
    <cfargument name="excludeID" type="numeric" required="yes" default="0">
    <cfargument name="soltName" type="string" required="yes" default="">
    <cfargument name="soltStatus" type="string" required="yes" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="soltName">
    <cfset var rsSpecialOrderLogType = "" >
    <cftry>
    <cfquery name="rsSpecialOrderLogType" datasource="#application.mcmsDSN#">
    SELECT * FROM v_special_order_log_type WHERE 0=0
    <cfif ARGUMENTS.ID NEQ 0>
    AND ID = <cfqueryparam value="#ARGUMENTS.ID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.excludeID NEQ 0>
    AND ID <> <cfqueryparam value="#ARGUMENTS.excludeID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND UPPER(soltName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">
    </cfif>
    <cfif ARGUMENTS.soltName NEQ "">
    AND soltName = <cfqueryparam value="#ARGUMENTS.soltName#" cfsqltype="cf_sql_varchar">
    </cfif>
    AND soltStatus IN (<cfqueryparam value="#ARGUMENTS.soltStatus#" list="yes" cfsqltype="cf_sql_integer">)
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsSpecialOrderLogType = StructNew()>
    <cfset rsSpecialOrderLogType.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsSpecialOrderLogType>
    </cffunction>
    
    <cffunction name="getSpecialOrderTransaction" access="public" returntype="query" hint="Get Special Order Transaction data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="ID" type="numeric" required="yes" default="0">
    <cfargument name="excludeID" type="numeric" required="yes" default="0">
    <cfargument name="siteNo" type="string" required="yes" default="100">
    <cfargument name="deptNo" type="string" required="yes" default="0">
    <cfargument name="soID" type="numeric" required="yes" default="0">
    <cfargument name="sotDate" type="string" required="yes" default="">
    <cfargument name="sotTransactionID" type="string" required="yes" default="">
    <cfargument name="sottID" type="numeric" required="yes" default="0">
    <cfargument name="sotStatus" type="string" required="yes" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="ID">
    <cfset var rsSpecialOrderTransaction = "" >
    <cftry>
    <cfquery name="rsSpecialOrderTransaction" datasource="#application.mcmsDSN#">
    SELECT * FROM v_so_transaction WHERE 0=0
    <cfif ARGUMENTS.ID NEQ 0>
    AND ID = <cfqueryparam value="#ARGUMENTS.ID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.excludeID NEQ 0>
    AND ID <> <cfqueryparam value="#ARGUMENTS.excludeID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(sotRegisterID) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(sotTransactionID) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">)
    </cfif>
    <cfif ARGUMENTS.siteNo NEQ 100>
    AND siteNo IN (<cfqueryparam value="#ARGUMENTS.siteNo#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    <cfif ARGUMENTS.deptNo NEQ 0>
    AND deptNo IN (<cfqueryparam value="#ARGUMENTS.deptNo#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    <cfif ARGUMENTS.soID NEQ 0>
    AND soID = <cfqueryparam value="#ARGUMENTS.soID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.sotTransactionID NEQ "">
    AND UPPER(sotTransactionID) = <cfqueryparam value="#UCASE(ARGUMENTS.sotTransactionID)#" cfsqltype="cf_sql_varchar">
    </cfif>
    <cfif ARGUMENTS.sotDate NEQ "">
    AND TO_CHAR(sotDate, 'MM/DD/YYYY') = <cfqueryparam value="#DateFormat(ARGUMENTS.sotDate, 'mm/dd/yyyy')#" cfsqltype="cf_sql_varchar">
    </cfif>
    <cfif ARGUMENTS.sottID NEQ 0>
    AND sottID = <cfqueryparam value="#ARGUMENTS.sottID#" cfsqltype="cf_sql_integer">
    </cfif>
    AND sotStatus IN (<cfqueryparam value="#ARGUMENTS.sotStatus#" list="yes" cfsqltype="cf_sql_integer">)
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsSpecialOrderTransaction = StructNew()>
    <cfset rsSpecialOrderTransaction.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsSpecialOrderTransaction>
    </cffunction>
    
    <cffunction name="getSpecialOrderTransactionType" access="public" returntype="query" hint="Get Special Order Transaction Type data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="ID" type="numeric" required="yes" default="0">
    <cfargument name="excludeID" type="numeric" required="yes" default="0">
    <cfargument name="sottName" type="string" required="yes" default="">
    <cfargument name="sottStatus" type="string" required="yes" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="sottName">
    <cfset var rsSpecialOrderTransactionType = "" >
    <cftry>
    <cfquery name="rsSpecialOrderTransactionType" datasource="#application.mcmsDSN#">
    SELECT * FROM v_so_transaction_type WHERE 0=0
    <cfif ARGUMENTS.ID NEQ 0>
    AND ID = <cfqueryparam value="#ARGUMENTS.ID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.excludeID NEQ 0>
    AND ID <> <cfqueryparam value="#ARGUMENTS.excludeID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND UPPER(sottName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">
    </cfif>
    <cfif ARGUMENTS.sottName NEQ "">
    AND sottName = <cfqueryparam value="#ARGUMENTS.sottName#" cfsqltype="cf_sql_varchar">
    </cfif>
    AND sottStatus IN (<cfqueryparam value="#ARGUMENTS.sottStatus#" list="yes" cfsqltype="cf_sql_integer">)
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsSpecialOrderTransactionType = StructNew()>
    <cfset rsSpecialOrderTransactionType.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsSpecialOrderTransactionType>
    </cffunction>
    
    <cffunction name="getSpecialOrderRequisition" access="public" returntype="query" hint="Get Special Order Requisition data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="ID" type="numeric" required="yes" default="0">
    <cfargument name="excludeID" type="numeric" required="yes" default="0">
    <cfargument name="soID" type="numeric" required="yes" default="0">
    <cfargument name="sorNumber" type="string" required="yes" default="">
    <cfargument name="siteNo" type="numeric" required="yes" default="100">
    <cfargument name="sortID" type="numeric" required="yes" default="0">
    <cfargument name="sorStatus" type="string" required="yes" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="ID">
    <cfset var rsSpecialOrderRequisition = "" >
    <cftry>
    <cfquery name="rsSpecialOrderRequisition" datasource="#application.mcmsDSN#">
    SELECT * FROM v_so_requisition WHERE 0=0
    <cfif ARGUMENTS.ID NEQ 0>
    AND ID = <cfqueryparam value="#ARGUMENTS.ID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.excludeID NEQ 0>
    AND ID <> <cfqueryparam value="#ARGUMENTS.excludeID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND UPPER(siteName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">
    </cfif>
    <cfif ARGUMENTS.soID NEQ 0>
    AND soID = <cfqueryparam value="#ARGUMENTS.soID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.sorNumber NEQ "">
    AND UPPER(sorNumber) = <cfqueryparam value="#UCASE(ARGUMENTS.sorNumber)#" cfsqltype="cf_sql_varchar">
    </cfif>
    <cfif ARGUMENTS.siteNo NEQ 100>
    AND siteNo = <cfqueryparam value="#ARGUMENTS.siteNo#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.sortID NEQ 0>
    AND sortID = <cfqueryparam value="#ARGUMENTS.sortID#" cfsqltype="cf_sql_integer">
    </cfif>
    AND sorStatus IN (<cfqueryparam value="#ARGUMENTS.sorStatus#" list="yes" cfsqltype="cf_sql_integer">)
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsSpecialOrderRequisition = StructNew()>
    <cfset rsSpecialOrderRequisition.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsSpecialOrderRequisition>
    </cffunction>
    
    <cffunction name="getSpecialOrderRequisitionItemRel" access="public" returntype="query" hint="Get Special Order Requisition Item Rel. data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="ID" type="numeric" required="yes" default="0">
    <cfargument name="excludeID" type="numeric" required="yes" default="0">
    <cfargument name="soID" type="numeric" required="yes" default="0">
    <cfargument name="sorID" type="numeric" required="yes" default="0">
    <cfargument name="soiID" type="numeric" required="yes" default="0">
    <cfargument name="siteNo" type="numeric" required="yes" default="100">
    <cfargument name="deptNo" type="numeric" required="yes" default="0">
    <cfargument name="sorirStatus" type="string" required="yes" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="ID">
    <cfset var rsSpecialOrderRequisitionItemRel = "" >
    <cftry>
    <cfquery name="rsSpecialOrderRequisitionItemRel" datasource="#application.mcmsDSN#">
    SELECT * FROM v_so_requisition_item_rel WHERE 0=0
    <cfif ARGUMENTS.ID NEQ 0>
    AND ID = <cfqueryparam value="#ARGUMENTS.ID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.excludeID NEQ 0>
    AND ID <> <cfqueryparam value="#ARGUMENTS.excludeID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND UPPER(siteName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">
    </cfif>
    <cfif ARGUMENTS.soID NEQ 0>
    AND soID = <cfqueryparam value="#ARGUMENTS.soID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.sorID NEQ 0>
    AND sorID = <cfqueryparam value="#ARGUMENTS.sorID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.soiID NEQ 0>
    AND soiID = <cfqueryparam value="#ARGUMENTS.soiID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.siteNo NEQ 100>
    AND siteNo = <cfqueryparam value="#ARGUMENTS.siteNo#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.deptNo NEQ 0>
    AND deptNo = <cfqueryparam value="#ARGUMENTS.deptNo#" cfsqltype="cf_sql_integer">
    </cfif>
    AND sorirStatus IN (<cfqueryparam value="#ARGUMENTS.sorirStatus#" list="yes" cfsqltype="cf_sql_integer">)
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsSpecialOrderRequisitionItemRel = StructNew()>
    <cfset rsSpecialOrderRequisitionItemRel.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsSpecialOrderRequisitionItemRel>
    </cffunction>
    
    <cffunction name="getSpecialOrderRequisitionItemRelQuantitySum" access="public" returntype="string" hint="Get Special Order Requisition Item Rel. data and sum of item quantity.">
    <cfargument name="soID" type="numeric" required="yes" default="0">
    <cfargument name="sorirStatus" type="string" required="yes" default="1,3">
    <cfset var rsSpecialOrderRequisitionItemRelQuantitySum = '' >
    <cftry>
    <cfquery name="rsSpecialOrderRequisitionItemRelQuantitySum" datasource="#application.mcmsDSN#">
    SELECT SUM(sorirQuantity) AS total FROM v_so_requisition_item_rel WHERE 0=0
    <cfif ARGUMENTS.soID NEQ 0>
    AND soID = <cfqueryparam value="#ARGUMENTS.soID#" cfsqltype="cf_sql_integer">
    </cfif>
    AND sorirStatus IN (<cfqueryparam value="#ARGUMENTS.sorirStatus#" list="yes" cfsqltype="cf_sql_integer">)
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsSpecialOrderRequisitionItemRelQuantitySum = StructNew()>
    <cfset rsSpecialOrderRequisitionItemRelQuantitySum.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfif rsSpecialOrderRequisitionItemRelQuantitySum.total NEQ ''>
    <cfreturn rsSpecialOrderRequisitionItemRelQuantitySum.total>
    <cfelse>
    <cfreturn 0>
    </cfif>
    </cffunction>
    
    <cffunction name="getSpecialOrderRequisitionType" access="public" returntype="query" hint="Get Special Order Requisition Type data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="ID" type="numeric" required="yes" default="0">
    <cfargument name="excludeID" type="numeric" required="yes" default="0">
    <cfargument name="sortName" type="string" required="yes" default="">
    <cfargument name="sortStatus" type="string" required="yes" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="ID">
    <cfset var rsSpecialOrderRequisitionType = "">
    <cftry>
    <cfquery name="rsSpecialOrderRequisitionType" datasource="#application.mcmsDSN#">
    SELECT * FROM v_so_requisition_type WHERE 0=0
    <cfif ARGUMENTS.ID NEQ 0>
    AND ID = <cfqueryparam value="#ARGUMENTS.ID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.excludeID NEQ 0>
    AND ID <> <cfqueryparam value="#ARGUMENTS.excludeID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND UPPER(sortName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">
    </cfif>
    <cfif ARGUMENTS.sortName NEQ "">
    AND sortName = <cfqueryparam value="#ARGUMENTS.sortName#" cfsqltype="cf_sql_varchar">
    </cfif>
    AND sortStatus IN (<cfqueryparam value="#ARGUMENTS.sortStatus#" list="yes" cfsqltype="cf_sql_integer">)
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsSpecialOrderRequisitionType = StructNew()>
    <cfset rsSpecialOrderRequisitionType.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsSpecialOrderRequisitionType>
    </cffunction>
    
    <cffunction name="getSOPADCategoryRel" access="public" returntype="query" hint="Get Special Order Product Attribute Department Category Rel. data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="ID" type="numeric" required="yes" default="0">
    <cfargument name="excludeID" type="numeric" required="yes" default="0">
    <cfargument name="paID" type="numeric" required="yes" default="0">
    <cfargument name="deptNo" type="numeric" required="yes" default="0">
    <cfargument name="catID" type="numeric" required="yes" default="0">
    <cfargument name="sopadcrStatus" type="string" required="yes" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="paSort,paName">
    <!---Determine if this is a category only query.--->
    <cfargument name="distinctCategory" type="string" required="yes" default="false">
    <cfset var rsSOPADCategoryRel = "" >
    <cftry>
    <cfif ARGUMENTS.distinctCategory EQ 'true'>
    <cfquery name="rsSOPADCategoryRel" datasource="#application.mcmsDSN#">
    SELECT DISTINCT catName, catID FROM v_so_pa_d_category_rel WHERE 0=0
    <cfif ARGUMENTS.deptNo NEQ 0>
    AND deptNo = <cfqueryparam value="#ARGUMENTS.deptNo#" cfsqltype="cf_sql_integer">
    </cfif>
    AND sopadcrStatus IN (<cfqueryparam value="#ARGUMENTS.sopadcrStatus#" list="yes" cfsqltype="cf_sql_integer">)
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <cfelse>
    <cfquery name="rsSOPADCategoryRel" datasource="#application.mcmsDSN#">
    SELECT * FROM v_so_pa_d_category_rel WHERE 0=0
    <cfif ARGUMENTS.ID NEQ 0>
    AND ID = <cfqueryparam value="#ARGUMENTS.ID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.excludeID NEQ 0>
    AND ID <> <cfqueryparam value="#ARGUMENTS.excludeID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(paName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(catName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">)
    </cfif>
    <cfif ARGUMENTS.paID NEQ 0>
    AND paID = <cfqueryparam value="#ARGUMENTS.paID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.deptNo NEQ 0>
    AND deptNo = <cfqueryparam value="#ARGUMENTS.deptNo#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.catID NEQ 0>
    AND catID = <cfqueryparam value="#ARGUMENTS.catID#" cfsqltype="cf_sql_integer">
    </cfif>
    AND sopadcrStatus IN (<cfqueryparam value="#ARGUMENTS.sopadcrStatus#" list="yes" cfsqltype="cf_sql_integer">)
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    </cfif>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsSOPADCategoryRel = StructNew()>
    <cfset rsSOPADCategoryRel.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsSOPADCategoryRel>
    </cffunction>
    
    <cffunction name="getSpecialOrderReport" access="public" returntype="query" hint="Get Special Order Report data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="siteNo" type="string" required="yes" default="100">
    <cfargument name="deptNo" type="string" required="yes" default="0">
    <cfargument name="args" type="string" required="yes" default="0">
    <cfargument name="orderBy" type="string" required="yes" default="cstLName">
    <cfset var rsSpecialOrderReport = "" >
    <cftry>
    <cfquery name="rsSpecialOrderReport" datasource="#application.mcmsDSN#">
    SELECT siteName AS Site, siteNo, deptName AS Department, altuserFName || ' ' || altuserLName AS Created_By, userFNameAssigned || ' ' || userLNameAssigned AS Assigned_To, vName AS Vendor, cstFName || ' ' || cstLName AS Customer, cstEmail AS Email, cstDOB AS DOB, cstTelArea || '-' || cstTelPrefix || '-' || cstTelSuffix AS Telephone, cstTelAltArea || '-' || cstTelAltPrefix || '-' || cstTelAltSuffix AS Alt_Telephone, cstAddress AS Address, cstAddressExt AS Address_Ext, cstCity AS City, cstStateProv AS State_Prov, cstZipCode || ' ' || cstZipCodeExt AS ZipCode, cstCountry AS Country, csttName AS Type, soComment AS Comments, soTaxExemptNo AS Tax_No, TO_CHAR(soDate, 'MM/DD/YYYY') AS Order_Date, TO_CHAR(soDateCancelled, 'MM/DD/YYYY') AS Cancelled_Date, TO_CHAR(soDateCompleted, 'MM/DD/YYYY') AS Completed_Date, TO_CHAR(soDateAbandoned, 'MM/DD/YYYY') AS Abandoned_Date, sosName AS Order_Status, soBalance AS Balance, sName AS Status FROM v_special_order WHERE 0=0
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(cstLName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(altuserLName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">)
    </cfif>
    <cfif ARGUMENTS.siteNo NEQ 100>
    AND siteNo IN (<cfqueryparam value="#ARGUMENTS.siteNo#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    <cfif ARGUMENTS.deptNo NEQ 0>
    AND deptNo IN (<cfqueryparam value="#ARGUMENTS.deptNo#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    <cfif ListGetAt(ARGUMENTS.args, 1) NEQ 0>
    AND ID = <cfqueryparam value="#ListGetAt(ARGUMENTS.args, 1)#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ListGetAt(ARGUMENTS.args, 2) NEQ 0>
    AND sosID = <cfqueryparam value="#ListGetAt(ARGUMENTS.args, 2)#" cfsqltype="cf_sql_integer">
    </cfif>
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsSpecialOrderReport = StructNew()>
    <cfset rsSpecialOrderReport.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsSpecialOrderReport>
    </cffunction>
    
    <cffunction name="getSpecialOrderStatusReport" access="public" returntype="query" hint="Get Special Order Status Report data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="orderBy" type="string" required="yes" default="sosName">
    <cfset var rsSpecialOrderStatusReport = "" >
    <cftry>
    <cfquery name="rsSpecialOrderStatusReport" datasource="#application.mcmsDSN#">
    SELECT sosName AS Name, sosMessage As Message, sortName AS Sort, sName AS Status FROM v_special_order_status WHERE 0=0
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND UPPER(sosName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">
    </cfif>
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsSpecialOrderStatusReport = StructNew()>
    <cfset rsSpecialOrderStatusReport.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsSpecialOrderStatusReport>
    </cffunction>
    
    <cffunction name="getSpecialOrderItemReport" access="public" returntype="query" hint="Get Special Order Item Report data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="siteNo" type="string" required="yes" default="100">
    <cfargument name="deptNo" type="string" required="yes" default="0">
    <cfargument name="args" type="string" required="yes" default="0">
    <cfargument name="orderBy" type="string" required="yes" default="cstLName">
    <cfset var rsSpecialOrderItemReport = "" >
    <cftry>
    <cfquery name="rsSpecialOrderItemReport" datasource="#application.mcmsDSN#">
    SELECT soID, soiName AS Item, TO_CHAR(soiDescription) AS Description, bName AS Brand, soiMPN AS MPN, soiSKU AS SKU, soiQuantity AS Quantity, uomName AS UOM, soiQuoteCost AS Quote_Cost, soiQuoteMargin AS Quote_Margin, soiQuoteRetail AS Quote_Retail, soiQuotePreTax AS Quote_PreTax, soiActualCost AS Actual_Cost, soiActualMargin AS Actual_Margin, soiActualRetail AS Actual_Retail, soiActualPreTax AS Actual_PreTax, TO_CHAR(soiDate, 'MM/DD/YYYY') AS Item_Date, siteName AS Site, siteNo, deptName AS Department, vName AS Vendor, cstFName || ' ' || cstLName AS Customer, cstCity AS City, cstStateProv AS State_Prov, cstZipCode || ' ' || cstZipCodeExt AS ZipCode, cstCountry AS Country, soComment AS Comments, soTaxExemptNo AS Tax_No, TO_CHAR(soDate, 'MM/DD/YYYY') AS Order_Date, TO_CHAR(soDateCancelled, 'MM/DD/YYYY') AS Cancelled_Date, TO_CHAR(soDateCompleted, 'MM/DD/YYYY') AS Completed_Date, TO_CHAR(soDateAbandoned, 'MM/DD/YYYY') AS Abandoned_Date, sName AS Status FROM v_special_order_item WHERE 0=0
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(cstLName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(altuserLName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">)
    </cfif>
    <cfif ARGUMENTS.siteNo NEQ 100>
    AND siteNo IN (<cfqueryparam value="#ARGUMENTS.siteNo#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    <cfif ARGUMENTS.deptNo NEQ 0>
    AND deptNo IN (<cfqueryparam value="#ARGUMENTS.deptNo#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    <cfif ListGetAt(ARGUMENTS.args, 1) NEQ 0>
    AND soID = <cfqueryparam value="#ListGetAt(ARGUMENTS.args, 1)#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ListGetAt(ARGUMENTS.args, 2) NEQ 0>
    AND sosID = <cfqueryparam value="#ListGetAt(ARGUMENTS.args, 2)#" cfsqltype="cf_sql_integer">
    </cfif>
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsSpecialOrderItemReport = StructNew()>
    <cfset rsSpecialOrderItemReport.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsSpecialOrderItemReport>
    </cffunction>
    
    <cffunction name="getSpecialOrderLogReport" access="public" returntype="query" hint="Get Special Order Log Report data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="orderBy" type="string" required="yes" default="soltName">
    <cfset var rsSpecialOrderLogReport = "" >
    <cftry>
    <cfquery name="rsSpecialOrderLogReport" datasource="#application.mcmsDSN#">
    SELECT soID AS Order_No, siteName AS Site, siteNo, deptName AS Department, solDescription AS Description, vName AS Vendor, TO_CHAR(soDate, 'MM/DD/YYYY') AS Log_Date, soltName AS Type, sName AS Status FROM v_special_order_log WHERE 0=0
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND UPPER(solDescription) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">
    </cfif>
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsSpecialOrderLogReport = StructNew()>
    <cfset rsSpecialOrderLogReport.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsSpecialOrderLogReport>
    </cffunction>
    
    <cffunction name="getSpecialOrderLogTypeReport" access="public" returntype="query" hint="Get Special Order Log Type Report data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="orderBy" type="string" required="yes" default="soltName">
    <cfset var rsSpecialOrderLogTypeReport = "" >
    <cftry>
    <cfquery name="rsSpecialOrderLogTypeReport" datasource="#application.mcmsDSN#">
    SELECT soltName AS Name, sortName AS Sort, sName AS Status FROM v_special_order_log_type WHERE 0=0
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND UPPER(soltName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">
    </cfif>
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsSpecialOrderLogTypeReport = StructNew()>
    <cfset rsSpecialOrderLogTypeReport.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsSpecialOrderLogTypeReport>
    </cffunction>
    
    <cffunction name="getSpecialOrderTransactionReport" access="public" returntype="query" hint="Get Special Order Transaction Report data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="siteNo" type="string" required="yes" default="100">
    <cfargument name="deptNo" type="string" required="yes" default="0">
    <cfargument name="orderBy" type="string" required="yes" default="cstLName">
    <cfset var rsSpecialOrderTransactionReport = "" >
    <cftry>
    <cfquery name="rsSpecialOrderTransactionReport" datasource="#application.mcmsDSN#">
    SELECT soID, sotAmount AS Amount, sotRegisterID AS Register_ID, sotTransactionID AS Transaction_ID, TO_CHAR(sotDate, 'MM/DD/YYYY') AS Transaction_Date, sottName AS Type, siteName AS Site, siteNo, deptName AS Department, vName AS Vendor, cstFName || ' ' || cstLName AS Customer, cstCity AS City, cstStateProv AS State_Prov, cstZipCode || ' ' || cstZipCodeExt AS ZipCode, cstCountry AS Country, soComment AS Comments, soTaxExemptNo AS Tax_No, TO_CHAR(soDate, 'MM/DD/YYYY') AS Order_Date, TO_CHAR(soDateCancelled, 'MM/DD/YYYY') AS Cancelled_Date, TO_CHAR(soDateCompleted, 'MM/DD/YYYY') AS Completed_Date, TO_CHAR(soDateAbandoned, 'MM/DD/YYYY') AS Abandoned_Date, sosName AS Order_Status, sName AS Status FROM v_so_transaction WHERE 0=0
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(cstLName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(altuserLName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">)
    </cfif>
    <cfif ARGUMENTS.siteNo NEQ 100>
    AND siteNo IN (<cfqueryparam value="#ARGUMENTS.siteNo#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    <cfif ARGUMENTS.deptNo NEQ 0>
    AND deptNo IN (<cfqueryparam value="#ARGUMENTS.deptNo#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsSpecialOrderTransactionReport = StructNew()>
    <cfset rsSpecialOrderTransactionReport.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsSpecialOrderTransactionReport>
    </cffunction>
    
    <cffunction name="getSpecialOrderTransactionTypeReport" access="public" returntype="query" hint="Get Special Order Transaction Type Report data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="orderBy" type="string" required="yes" default="sottName">
    <cfset var rsSpecialOrderTransactionTypeReport = "" >
    <cftry>
    <cfquery name="rsSpecialOrderTransactionTypeReport" datasource="#application.mcmsDSN#">
    SELECT sottName AS Name, sortName AS Sort, sName AS Status FROM v_so_transaction_type WHERE 0=0
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND UPPER(sottName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">
    </cfif>
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsSpecialOrderTransactionTypeReport = StructNew()>
    <cfset rsSpecialOrderTransactionTypeReport.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsSpecialOrderTransactionTypeReport>
    </cffunction>
    
    <cffunction name="getSpecialOrderRequistionReport" access="public" returntype="query" hint="Get Special Order Requistion Report data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="orderBy" type="string" required="yes" default="cstLName">
    <cfset var rsSpecialOrderRequistionReport = "" >
    <cftry>
    <cfquery name="rsSpecialOrderRequistionReport" datasource="#application.mcmsDSN#">
    SELECT sorNumber AS Req_No, sortName AS Req_Type, soiName AS Item, sorQuantity AS Quantity, siteNameFrom AS Site_From, siteNameTo AS Site_To, TO_CHAR(soDateShipExt, 'MM/DD/YYYY') AS Est_Ship_Date, TO_CHAR(sorDate, 'MM/DD/YYYY') AS Req_Date, siteName AS Site, siteNo, deptName AS Department, vName AS Vendor, cstFName || ' ' || cstLName AS Customer, cstCity AS City, cstStateProv AS State_Prov, cstZipCode || ' ' || cstZipCodeExt AS ZipCode, cstCountry AS Country, csttName AS Type, soComment AS Comment, soTaxExemptNo AS Tax_No, TO_CHAR(soDate, 'MM/DD/YYYY') AS Order_Date, TO_CHAR(soDateCancelled, 'MM/DD/YYYY') AS Cancelled_Date, TO_CHAR(soDateCompleted, 'MM/DD/YYYY') AS Completed_Date, TO_CHAR(soDateAbandoned, 'MM/DD/YYYY') AS Abandoned_Date, sosName AS Order_Status, sName AS Status FROM v_so_requisition WHERE 0=0
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(cstLName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(altuserLName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">)
    </cfif>
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsSpecialOrderRequistionReport = StructNew()>
    <cfset rsSpecialOrderRequistionReport.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsSpecialOrderRequistionReport>
    </cffunction>
    
    <cffunction name="getSpecialOrderRequisitionTypeReport" access="public" returntype="query" hint="Get Special Order Requisition Type Report data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="orderBy" type="string" required="yes" default="sortName">
    <cfset var rsSpecialOrderRequisitionTypeReport = "" >
    <cftry>
    <cfquery name="rsSpecialOrderRequisitionTypeReport" datasource="#application.mcmsDSN#">
    SELECT sortName AS Name, sortMessage AS Message, srtName AS Sort, sName AS Status FROM v_so_requisition_type WHERE 0=0
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND UPPER(sortName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">
    </cfif>
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsSpecialOrderRequisitionTypeReport = StructNew()>
    <cfset rsSpecialOrderRequisitionTypeReport.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsSpecialOrderRequisitionTypeReport>
    </cffunction>
    
    <cffunction name="getSOPADCategoryRelReport" access="public" returntype="query" hint="Get Special Order Product Attribute Department Category Rel. Report data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="siteNo" type="string" required="yes" default="100">
    <cfargument name="deptNo" type="string" required="yes" default="0">
    <cfargument name="args" type="string" required="yes" default="0">
    <cfargument name="orderBy" type="string" required="yes" default="paName, deptName, catName">
    <cfset var rsSOPADCategoryRelReportt = "" >
    <cftry>
    <cfquery name="rsSOPADCategoryRelReport" datasource="#application.mcmsDSN#">
    SELECT paName AS Product_Attribute, deptName AS Department, catName AS Category, sopadcrRequired AS Required, sName AS Status FROM v_so_pa_d_category_rel WHERE 0=0
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(paName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(catName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">)
    </cfif>
    <cfif ARGUMENTS.deptNo NEQ 0>
    AND deptNo IN (<cfqueryparam value="#ARGUMENTS.deptNo#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsSOPADCategoryRelReport = StructNew()>
    <cfset rsSOPADCategoryRelReport.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsSOPADCategoryRelReport>
    </cffunction>
    
    <cffunction name="getUserByDepartmentRelBind" access="remote" returntype="any" hint="Get User By Department Rel. binded data.">
    <cfargument name="deptNo" type="string" required="yes" default="0">
    <cfargument name="urID" type="string" required="yes" default="0">
    <cfargument name="dsn" type="string" required="no" default="swweb">
    <cfargument name="orderBy" type="string" required="yes" default="userLName">
    <cftry>
    <cfset data = ''>
    <cfset result = ArrayNew(2)>
    <cfset i = 0>
    <cfquery name="data" datasource="#ARGUMENTS.dsn#">
    SELECT * FROM v_user_department_rel WHERE 0=0
    <cfif ARGUMENTS.deptNo NEQ 0 AND ARGUMENTS.deptNo NEQ '' AND IsNumeric(ARGUMENTS.deptNo)> 
    AND deptNo = <cfqueryparam value="#ARGUMENTS.deptNo#" cfsqltype="cf_sql_integer">
    <cfelse>
    AND 0=1
    </cfif>
    AND urID IN (<cfqueryparam value="#ARGUMENTS.urID#" list="yes" cfsqltype="cf_sql_integer">)
    AND userStatus = <cfqueryparam value="1" cfsqltype="cf_sql_integer">
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <cfif data.RecordCount EQ 0>
    <cfset result[1][1] = ''>
    <cfset result[1][2] = 'Select a Dept. first.'>
    <cfelse>
    <cfloop index="i" from="1" to="#data.RecordCount#">
    <cfif i EQ 1>
    <cfset result[i][1] = ''>
    <cfset result[i][2] = 'Select an Assignee...'>
    </cfif>
	<cfset result[i+1][1] = data.userID[i]>
    <cfset result[i+1][2] = data.userFName[i] & ' ' & data.userLName[i]>
    </cfloop>
    </cfif>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsUserByDepartmentRelBind = StructNew()>
    <cfset rsUserByDepartmentRelBind.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="insertSpecialOrder" access="public" returntype="struct">
    <cfargument name="siteNo" type="numeric" required="yes">
    <cfargument name="deptNo" type="numeric" required="yes">
    <cfargument name="userID" type="numeric" required="yes">
    <cfargument name="altuserFName" type="string" required="yes">
    <cfargument name="altuserLName" type="string" required="yes">
    <cfargument name="userIDAssigned" type="numeric" required="yes">
    <cfargument name="vName" type="string" required="yes">
    <cfargument name="cstFName" type="string" required="yes">
    <cfargument name="cstLName" type="string" required="yes">
    <cfargument name="cstEmail" type="string" required="yes">
    <cfargument name="cstDOB" type="string" required="yes">
    <cfargument name="cstTelArea" type="string" required="yes">
    <cfargument name="cstTelPrefix" type="string" required="yes">
    <cfargument name="cstTelSuffix" type="string" required="yes">
    <cfargument name="cstTelAltArea" type="string" required="yes">
    <cfargument name="cstTelAltPrefix" type="string" required="yes">
    <cfargument name="cstTelAltSuffix" type="string" required="yes">
    <cfargument name="cstAddress" type="string" required="yes">
    <cfargument name="cstAddressExt" type="string" required="yes">
    <cfargument name="cstCity" type="string" required="yes">
    <cfargument name="cstStateProv" type="string" required="yes">
    <cfargument name="cstZipCode" type="string" required="yes">
    <cfargument name="cstZipCodeExt" type="string" required="yes">
    <cfargument name="cstCountry" type="string" required="yes">
    <cfargument name="csttID" type="numeric" required="yes">
    <cfargument name="soComment" type="string" required="yes">
    <cfargument name="soTaxExemptNo" type="string" required="yes">
    <cfargument name="sosID" type="numeric" required="yes">
    <cfargument name="soStatus" type="numeric" required="yes">
    <!---Check for opt-in.--->
    <cfargument name="optIn" type="string" required="yes" default="false">
    <cfset result.message = "You have successfully inserted the record.">
    <cftry>
    <cfif ARGUMENTS.optIn EQ true AND ARGUMENTS.cstEmail NEQ ''>
    <!---Add Opt-in here.--->
    <cfinvoke 
    component="MCMS.component.app.subscription.Subscription"
    method="insertSubscriptionSiteRel"
    returnvariable="result">
    <cfinvokeargument name="siteNo" value="#ARGUMENTS.siteNo#"/>
    <cfinvokeargument name="subEmail" value="#ARGUMENTS.cstEmail#"/>
    <cfinvokeargument name="subPassword" value="password"/>
    <cfinvokeargument name="subFName" value="#ARGUMENTS.cstFName#"/>
    <cfinvokeargument name="subLName" value="#ARGUMENTS.cstLName#"/>
    <cfinvokeargument name="subTelArea" value="#ARGUMENTS.cstTelArea#"/>
    <cfinvokeargument name="subTelPrefix" value="#ARGUMENTS.cstTelPrefix#"/>
    <cfinvokeargument name="subTelSuffix" value="#ARGUMENTS.cstTelSuffix#"/>
    <cfinvokeargument name="subZipCode" value="#IIf(ARGUMENTS.cstZipCode EQ '', DE('0'), DE(ARGUMENTS.cstZipCode))#"/>
    <cfinvokeargument name="subZipCodeExt" value="#ARGUMENTS.cstZipCodeExt#"/>
    <cfinvokeargument name="subStateProv" value="#ARGUMENTS.cstStateProv#"/>
    <cfinvokeargument name="subCountry" value="#ARGUMENTS.cstCountry#"/>
    <cfinvokeargument name="subStatus" value="1"/>
    </cfinvoke>
    </cfif>
    <!---Check for a Vendor.--->
    <cfinvoke 
    component="MCMS.component.app.vendor.Vendor"
    method="getVendor"
    returnvariable="getVendorRet">
    <cfinvokeargument name="vName" value="#ARGUMENTS.vName#"/>
    <cfinvokeargument name="vStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getVendorRet.recordcount NEQ 0>
    <cfset this.vID = getVendorRet.ID>
    <cfelse>
    <!---If the Vendor does not exist, create it, and send an email to an administrator.--->
    <cfinvoke 
    component="MCMS.component.app.vendor.Vendor"
    method="insertVendor"
    returnvariable="insertVendorRet">
    <cfinvokeargument name="vendorID" value="0"/>
    <cfinvokeargument name="vName" value="#ARGUMENTS.vName#"/>
    <cfinvokeargument name="vDescription" value="#ARGUMENTS.vName#"/>
    <cfinvokeargument name="vSort" value="1"/>
    <cfinvokeargument name="vStatus" value="3"/>
    </cfinvoke>
    <!---Get the Vendor ID just added.--->
    <cfinvoke 
    component="MCMS.component.app.vendor.Vendor"
    method="getVendor"
    returnvariable="getVendorRet">
    <cfinvokeargument name="vName" value="#ARGUMENTS.vName#"/>
    <cfinvokeargument name="vStatus" value="1,2,3"/>
    </cfinvoke>
    <cfset this.vID = getVendorRet.ID>
    </cfif>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    INSERT INTO tbl_special_order (siteNo,deptNo,userID,userIP,altuserFName,altuserLName,userIDAssigned,vID,cstFName,cstLName,cstEmail,cstDOB,cstTelArea,cstTelPrefix,cstTelSuffix,cstTelAltArea,cstTelAltPrefix,cstTelAltSuffix,cstAddress,cstAddressExt,cstCity,cstStateProv,cstZipCode,cstZipCodeExt,cstCountry,csttID,soComment,soTaxExemptNo,sosID,soStatus) VALUES
    (
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.siteNo#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.deptNo#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.userID#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#CGI.REMOTE_ADDR#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.altuserFName#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.altuserLName#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.userIDAssigned#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#this.vID#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.cstFName#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.cstLName#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.cstEmail#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.cstDOB#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.cstTelArea#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.cstTelPrefix#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.cstTelSuffix#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.cstTelAltArea#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.cstTelAltPrefix#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.cstTelAltSuffix#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.cstAddress#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.cstAddressExt#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.cstCity#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.cstStateProv#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.cstZipCode#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.cstZipCodeExt#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.cstCountry#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.csttID#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.soComment#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.soTaxExemptNo#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.sosID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.soStatus#">
    )
    </cfquery>
    </cftransaction>
    <!---Set a result ID to be included with a link to the update form.--->
    <cfinvoke 
    component="MCMS.component.cms.Cms"
    method="getMaxValueSQL"
    returnvariable="getMaxValueSQLRet">
    <cfinvokeargument name="tableName" value="tbl_special_order"/>
    </cfinvoke>
    <cfset result.ID = getMaxValueSQLRet>
    <!---Forward to update form.--->
    <cfset ajaxOnLoad("function() {
    lAjax('layoutIndex', #url.appID#, 'SpecialOrder' ,'/#application.mcmsAppAdminPath#/special_order/view/inc_special_order.cfm','Item','update', #result.ID#);
	}")>
    <cfcatch type="any">
    <cfset result.message = "There was an error inserting the record.">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="insertSpecialOrderStatus" access="public" returntype="struct">
    <cfargument name="sosName" type="string" required="yes">
    <cfargument name="sosMessage" type="string" required="yes">
    <cfargument name="sosSort" type="numeric" required="yes">
    <cfargument name="sosStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully inserted the record.">
    <cftry>
    <!---Check for profanity in the text.--->
    <cfinvoke 
    component="MCMS.component.utility.Regex"
    method="regexProfanity"
    returnvariable="regexProfanityRet">
    <cfinvokeargument name="profanityString" value="#ARGUMENTS.sosMessage#"/>
    </cfinvoke>
    <!---Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.app.special_order.SpecialOrder"
    method="getSpecialOrderStatus"
    returnvariable="getCheckSpecialOrderStatusRet">
    <cfinvokeargument name="sosName" value="#ARGUMENTS.sosName#"/>
    <cfinvokeargument name="sosStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckSpecialOrderStatusRet.recordcount NEQ 0>
    <cfset result.message = "The name #ARGUMENTS.sosName# already exists, please enter a new name.">
    <cfelseif regexProfanityRet CONTAINS '$%&*!'>
    <cfset result.message = "Some text contained profanity, please remove any profanity from your text.">
    <!---Check length restriction.--->
    <cfelseif LEN(ARGUMENTS.sosMessage) GT 2048>
    <cfset result.message = "The message is longer than 2048 characters, please enter a new message under 2048 characters.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    INSERT INTO tbl_special_order_status (sosName,sosMessage,sosSort,sosStatus) VALUES
    (
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.sosName#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.sosMessage#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.sosSort#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.sosStatus#">
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
    
    <cffunction name="insertSpecialOrderItem" access="public" returntype="struct">
    <cfargument name="soID" type="numeric" required="yes">
    <cfargument name="soiName" type="string" required="yes">
    <cfargument name="soiDescription" type="string" required="yes">
    <cfargument name="bName" type="string" required="yes">
    <cfargument name="soiMPN" type="string" required="yes">
    <cfargument name="soiSKU" type="string" required="yes">
    <cfargument name="soiQuantity" type="numeric" required="yes">
    <cfargument name="uomID" type="numeric" required="yes">
    <cfargument name="soiQuoteCost" type="string" required="yes">
    <cfargument name="soiQuoteMargin" type="string" required="yes">
    <cfargument name="soiQuoteRetail" type="string" required="yes">
    <cfargument name="soiQuoteFreight" type="string" required="yes">
    <cfargument name="soiQuotePreTax" type="string" required="yes">
    <cfargument name="soiActualCost" type="string" required="yes">
    <cfargument name="soiActualMargin" type="string" required="yes">
    <cfargument name="soiActualRetail" type="string" required="yes">
    <cfargument name="soiActualFreight" type="string" required="yes">
    <cfargument name="soiActualPreTax" type="string" required="yes">
    <cfargument name="soiStatus" type="numeric" required="yes">
    <!---Include other arguments.--->
    <cfargument name="count" type="numeric" required="yes">
    <cfset result.message = "You have successfully inserted the record. To continue with the Special Order you must collect a deposit click the Transaction tab.">
    <cftry>
	<!---Check for a Brand.--->
    <cfset this.bID = 0>
    <cfif ARGUMENTS.bName NEQ "">
    <cfinvoke 
    component="MCMS.component.app.vendor.Vendor"
    method="getBrand"
    returnvariable="getBrandRet">
    <cfinvokeargument name="bName" value="#ARGUMENTS.bName#"/>
    <cfinvokeargument name="bStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getBrandRet.recordcount NEQ 0>
    <cfset this.bID = getBrandRet.ID>
    <cfelse>
    <!---If the Vendor does not exist, create it, and send an email to an administrator.--->
    <cfinvoke 
    component="MCMS.component.app.vendor.Vendor"
    method="insertBrand"
    returnvariable="insertBrandRet">
    <cfinvokeargument name="bName" value="#ARGUMENTS.bName#"/>
    <cfinvokeargument name="bDescription" value="#ARGUMENTS.bName#"/>
    <cfinvokeargument name="bSort" value="1"/>
    <cfinvokeargument name="bStatus" value="3"/>
    </cfinvoke>
    <!---Get the Brand ID just added.--->
    <cfinvoke 
    component="MCMS.component.app.vendor.Vendor"
    method="getBrand"
    returnvariable="getBrandRet">
    <cfinvokeargument name="bName" value="#ARGUMENTS.bName#"/>
    <cfinvokeargument name="bStatus" value="1,2,3"/>
    </cfinvoke>
    <cfset this.bID = getBrandRet.ID>
    </cfif>
    </cfif>
    <!---Prevent an insert of an item when the form is hidden.--->
    <cfif ARGUMENTS.soiName NEQ 0>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    INSERT INTO tbl_special_order_item (soID,soiName,soiDescription,bID,soiMPN,soiSKU,soiQuantity,uomID,soiQuoteCost,soiQuoteMargin,soiQuoteRetail,soiQuoteFreight,soiQuotePreTax,soiActualCost,soiActualMargin,soiActualRetail,soiActualFreight,soiActualPreTax,soiStatus) VALUES
    (
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.soID#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.soiName#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.soiDescription#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#this.bID#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.soiMPN#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.soiSKU#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.soiQuantity#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.uomID#">,
    <cfqueryparam cfsqltype="cf_sql_float" value="#ARGUMENTS.soiQuoteCost#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.soiQuoteMargin#">,
    <cfqueryparam cfsqltype="cf_sql_float" value="#ARGUMENTS.soiQuoteRetail#">,
    <cfqueryparam cfsqltype="cf_sql_float" value="#ARGUMENTS.soiQuoteFreight#">,
    <cfqueryparam cfsqltype="cf_sql_float" value="#ARGUMENTS.soiQuotePreTax#">,
    <cfqueryparam cfsqltype="cf_sql_float" value="#ARGUMENTS.soiActualCost#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.soiActualMargin#">,
    <cfqueryparam cfsqltype="cf_sql_float" value="#ARGUMENTS.soiActualRetail#">,
    <cfqueryparam cfsqltype="cf_sql_float" value="#ARGUMENTS.soiActualFreight#">,
    <cfqueryparam cfsqltype="cf_sql_float" value="#ARGUMENTS.soiActualPreTax#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.soiStatus#">
    )
    </cfquery>
    </cftransaction>
    <cfinvoke 
    component="MCMS.component.cms.Cms"
    method="getMaxValueSQL"
    returnvariable="getMaxValueSQLRet">
    <cfinvokeargument name="tableName" value="tbl_special_order_item"/>
    </cfinvoke>
    <cfset this.soiID = getMaxValueSQLRet>
    <!---Insert Attributes.--->
    <cfif ARGUMENTS.count GT 0>
    <cfloop index="i" from="1" to="#ARGUMENTS.count#">
    <cfinvoke 
    component="MCMS.component.app.special_order.SpecialOrder"
    method="insertSpecialOrderItemAttribute"
    returnvariable="insertSpecialOrderItemAttributeRet">
    <cfinvokeargument name="soID" value="#ARGUMENTS.soID#"/>
    <cfinvokeargument name="soiID" value="#this.soiID#"/>
    <cfinvokeargument name="soiaName" value="#Evaluate('form.soiaName#i#')#"/>
    <cfinvokeargument name="soiaValue" value="#Evaluate('form.soiaValue#i#')#"/>
    <cfinvokeargument name="soiaStatus" value="1"/>
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
    
    <cffunction name="insertSpecialOrderItemAttribute" access="public" returntype="struct">
    <cfargument name="soID" type="numeric" required="yes">
    <cfargument name="soiID" type="numeric" required="yes">
    <cfargument name="soiaName" type="string" required="yes">
    <cfargument name="soiaValue" type="string" required="yes">
    <cfargument name="soiaStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully inserted the record.">
    <cftry>
    <!---Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.app.special_order.SpecialOrder"
    method="getSpecialOrderItemAttribute"
    returnvariable="getCheckSpecialOrderItemAttributeRet">
    <cfinvokeargument name="ID" value="#ARGUMENTS.soiID#"/>
    <cfinvokeargument name="soiaName" value="#ARGUMENTS.soiaName#"/>
    <cfinvokeargument name="soiaStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckSpecialOrderItemAttributeRet.recordcount NEQ 0>
    <cfset result.message = "The name #ARGUMENTS.soiaName# already exists, please enter a new name.">
    <cfinvoke 
    component="MCMS.component.app.special_order.SpecialOrder"
    method="updateSpecialOrderItemAttribute"
    returnvariable="updateSpecialOrderItemAttributeRet">
    <cfinvokeargument name="ID" value="#getCheckSpecialOrderItemAttributeRet.ID#"/>
    <cfinvokeargument name="soiaName" value="#ARGUMENTS.soiaName#"/>
    <cfinvokeargument name="soiaValue" value="#ARGUMENTS.soiaValue#"/>
    <cfinvokeargument name="soiaStatus" value="#ARGUMENTS.soiaStatus#"/>
    </cfinvoke>
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    INSERT INTO tbl_so_item_attribute (soID,soiID,soiaName,soiaValue,soiaStatus) VALUES
    (
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.soID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.soiID#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.soiaName#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.soiaValue#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.soiaStatus#">
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
    
    <cffunction name="insertSpecialOrderLog" access="public" returntype="struct">
    <cfargument name="soID" type="numeric" required="yes">
    <cfargument name="userID" type="numeric" required="yes">
    <cfargument name="solDescription" type="string" required="yes">
    <cfargument name="soltID" type="numeric" required="yes">
    <cfargument name="solStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully inserted the record.">
    <cftry>
    <!---Check length restriction.--->
    <cfif LEN(ARGUMENTS.solDescription) GT 2048>
    <cfset result.message = "The message is longer than 2048 characters, please enter a new message under 2048 characters.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    INSERT INTO tbl_special_order_log (soID,userID,userIP,solDescription,soltID,solStatus) VALUES
    (
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.soID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.userID#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#CGI.REMOTE_ADDR#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.solDescription#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.soltID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.solStatus#">
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
    
    <cffunction name="insertSpecialOrderTransaction" access="public" returntype="struct">
    <cfargument name="soID" type="numeric" required="yes">
    <cfargument name="userID" type="numeric" required="yes">
    <cfargument name="sotAmount" type="string" required="yes">
    <cfargument name="sotRegisterID" type="string" required="yes">
    <cfargument name="sotTransactionID" type="string" required="yes">
    <cfargument name="sottID" type="numeric" required="yes">
    <cfargument name="sotStatus" type="numeric" required="yes">
    <!---Additional arguments.--->
    <cfargument name="soBalance" type="string" required="yes">
    <cfargument name="sosID" type="numeric" required="yes">
    <cfargument name="siteNo" type="numeric" required="yes">
    <cfargument name="siteName" type="string" required="yes">
    <cfargument name="deptName" type="string" required="yes">
    <cfargument name="userEmailAssigned" type="string" required="yes">
    <cfset result.message = "You have successfully inserted the record.">
	<cftry>
    <!---Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.app.special_order.SpecialOrder"
    method="getSpecialOrderTransaction"
    returnvariable="getCheckSpecialOrderTransactionRet">
    <cfinvokeargument name="soID" value="#ARGUMENTS.soID#"/>
    <cfinvokeargument name="sotDate" value="#DateFormat(Now(), 'mm/dd/yyyy')#"/>
    <cfinvokeargument name="sotTransactionID" value="#ARGUMENTS.sotTransactionID#"/>
    <cfinvokeargument name="sotStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckSpecialOrderTransactionRet.recordcount NEQ 0>
    <cfset result.message = "The transaction #ARGUMENTS.sotTransactionID# already exists for this order, please enter a new transaction number.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    INSERT INTO tbl_so_transaction (soID,userID,userIP,sotAmount,sotRegisterID,sotTransactionID,sottID,sotStatus) VALUES
    (
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.soID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.userID#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#CGI.REMOTE_ADDR#">,
    <cfqueryparam cfsqltype="cf_sql_float" value="#ARGUMENTS.sotAmount#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.sotRegisterID#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.sotTransactionID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.sottID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.sotStatus#">
    )
    </cfquery>
    </cftransaction>
    <!---Calculate the remaining balance and write it to the Special Order table.--->
    <cfset this.soBalance = ARGUMENTS.soBalance-ARGUMENTS.sotAmount>
    <!---Update the Special Order status. Set the sosID to 2 if the first transaction is made.--->
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_special_order SET
    userIP = <cfqueryparam cfsqltype="cf_sql_varchar" value="#CGI.REMOTE_ADDR#">,
    userID = <cfqueryparam cfsqltype="cf_sql_integer" value="#session.userID#">,
    soBalance = <cfqueryparam cfsqltype="cf_sql_float" value="#this.soBalance#">,
    sosID = <cfqueryparam cfsqltype="cf_sql_integer" value="#Iif(ARGUMENTS.sosID EQ 1, DE('2'), DE(ARGUMENTS.sosID))#">
    WHERE ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.soID#">
    </cfquery>
    </cftransaction>
    <!---Email notification if the status is pending.--->
    <!---Get the Store Manager email to CC.--->
    <cfinvoke 
    component="MCMS.component.cms.User"
    method="getUserSiteRel"
    returnvariable="getUserSiteRelRet">
    <cfinvokeargument name="urID" value="104"/>
    <cfinvokeargument name="siteNo" value="#ARGUMENTS.siteNo#"/>
    <cfinvokeargument name="usrStatus" value="1"/>
    </cfinvoke>
    <cfif getUserSiteRelRet.recordcount NEQ 0>
    <cfset this.storeManagerEmail = ValueList(getUserSiteRelRet.userEmail, ';')>
    <cfelse>
    <cfset this.storeManagerEmail = ''>
    </cfif>
    <cfswitch expression="#ARGUMENTS.sosID#">
    <!---Send the request to the Buyer.---> 
    <cfcase value="1">
    <cfinvoke 
    component="MCMS.component.utility.Email"
    method="sendEmail"
    returnvariable="sendEmailRet">
    <cfinvokeargument name="subject" value="NEW Special Order Request No.#ARGUMENTS.soID# - #ARGUMENTS.siteName# - #ARGUMENTS.deptName#"/>
    <cfinvokeargument name="to" value="#ARGUMENTS.userEmailAssigned#"/>
    <cfinvokeargument name="from" value="#session.userUsername#"/>
    <cfinvokeargument name="cc" value=""/><!---#this.storeManagerEmail#--->
    <cfinvokeargument name="bcc" value=""/>
    <cfinvokeargument name="body" value=""/>
    <cfinvokeargument name="ID" value="#ARGUMENTS.soID#"/>
    <cfinvokeargument name="emailTemplate" value="/#application.mcmsAppAdminPath#/special_order/view/inc_special_order_new_status_email_template.cfm"/>
    <cfinvokeargument name="emailType" value="html"/>
    </cfinvoke>
    </cfcase>
    </cfswitch>
    <!---Make the Special Order complete if the final transaction is made.--->
    <cfif this.soBalance EQ 0 AND ARGUMENTS.sosID EQ 4>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_special_order SET
    userIP = <cfqueryparam cfsqltype="cf_sql_varchar" value="#CGI.REMOTE_ADDR#">,
    soDateCompleted = <cfqueryparam cfsqltype="cf_sql_timestamp" value="#Now()#">,
    sosID = <cfqueryparam cfsqltype="cf_sql_integer" value="5">
    WHERE ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.soID#">
    </cfquery>
    </cftransaction>
    <cfset result.message = "You have successfully inserted the record.<br /> All transactions have been completed for all items and the Special Order status is now 'Complete'.">
    </cfif>
    </cfif>
    <cfcatch type="any">
    <cfset result.message = "There was an error inserting the record.">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="insertSpecialOrderRequisition" access="public" returntype="struct">
    <cfargument name="soID" type="numeric" required="yes">
    <cfargument name="userID" type="numeric" required="yes">
    <cfargument name="siteNoFrom" type="numeric" required="yes">
    <cfargument name="siteNoTo" type="numeric" required="yes">
    <cfargument name="sorDateShipEst" type="string" required="yes">
    <cfargument name="sorNumber" type="string" required="yes">
    <cfargument name="sortID" type="numeric" required="yes">
    <cfargument name="sorStatus" type="numeric" required="yes">
    <!---Additional arguments.--->
    <cfargument name="itemCount" type="numeric" required="yes">
    <cfargument name="siteNo" type="numeric" required="yes">
    <cfargument name="userEmail" type="string" required="yes">
    <cfset result.message = "You have successfully inserted the record.">
    <cftry>
    <!---Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.app.special_order.SpecialOrder"
    method="getSpecialOrderRequisition"
    returnvariable="getCheckSpecialOrderRequisitionRet">
    <cfinvokeargument name="soID" value="#ARGUMENTS.soID#"/>
    <cfinvokeargument name="sorNumber" value="#ARGUMENTS.sorNumber#"/>
    <cfinvokeargument name="sorStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckSpecialOrderRequisitionRet.recordcount NEQ 0>
    <cfset result.message = "The requistion #ARGUMENTS.sorNumber# already exists for this order, please enter a new requistion number.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    INSERT INTO tbl_so_requisition (soID,userID,siteNoFrom,siteNoTo,sorDateShipEst,sorNumber,sortID,sorStatus) VALUES
    (
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.soID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.userID#">,
	<cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.siteNoFrom#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.siteNoTo#">,
    <cfqueryparam cfsqltype="cf_sql_date" value="#ARGUMENTS.sorDateShipEst#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.sorNumber#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.sortID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.sorStatus#">
    )
    </cfquery>
    </cftransaction>
    <cfinvoke 
    component="MCMS.component.cms.Cms"
    method="getMaxValueSQL"
    returnvariable="getMaxValueSQLRet">
    <cfinvokeargument name="tableName" value="tbl_so_requisition"/>
    </cfinvoke>
    <cfset this.sorID = getMaxValueSQLRet>
    <cfloop index="i" from="1" to="#ARGUMENTS.itemCount#">
    <cfif Evaluate('form.sorirQuantity#i#') NEQ 0>
    <cfinvoke 
    component="MCMS.component.app.special_order.SpecialOrder"
    method="insertSpecialOrderRequisitionItemRel"
    returnvariable="insertSpecialOrderRequisitionItemRelRet">
    <cfinvokeargument name="soID" value="#ARGUMENTS.soID#"/>
    <cfinvokeargument name="sorID" value="#this.sorID#"/>
    <cfinvokeargument name="soiID" value="#Evaluate('form.soiID#i#')#"/>
    <cfinvokeargument name="sorirQuantity" value="#Evaluate('form.sorirQuantity#i#')#"/>
    <cfinvokeargument name="sorirStatus" value="1"/>
    </cfinvoke>
    </cfif>
    </cfloop>
    </cfif>
    <!---Check to see if all requisitions have been made.--->
    <!---First get the sum of all items.--->
    <cfinvoke 
    component="MCMS.component.app.special_order.SpecialOrder"
    method="getSpecialOrderItemQuantitySum"
    returnvariable="itemQuantityTotal">
    <cfinvokeargument name="soID" value="#ARGUMENTS.soID#"/>
    <cfinvokeargument name="soiStatus" value="1"/>
    </cfinvoke>
    <!---Get the sum of all items in requisition.--->
    <cfinvoke 
    component="MCMS.component.app.special_order.SpecialOrder"
    method="getSpecialOrderRequisitionItemRelQuantitySum"
    returnvariable="itemReqQuantityTotal">
    <cfinvokeargument name="soID" value="#ARGUMENTS.soID#"/>
    <cfinvokeargument name="sorirStatus" value="1"/>
    </cfinvoke>
    <cfif itemQuantityTotal EQ itemReqQuantityTotal>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_special_order SET
    userIP = <cfqueryparam cfsqltype="cf_sql_varchar" value="#CGI.REMOTE_ADDR#">,
    sosID = <cfqueryparam cfsqltype="cf_sql_integer" value="4">
    WHERE ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.soID#">
    </cfquery>
    </cftransaction>
    <!---Email notification if the status is ordered.--->
    <!---Get the Store Manager email to CC.--->
    <cfinvoke 
    component="MCMS.component.cms.User"
    method="getUserSiteRel"
    returnvariable="getUserSiteRelRet">
    <cfinvokeargument name="urID" value="104"/>
    <cfinvokeargument name="siteNo" value="#ARGUMENTS.siteNo#"/>
    <cfinvokeargument name="usrStatus" value="1"/>
    </cfinvoke>
    <cfif getUserSiteRelRet.recordcount NEQ 0>
    <cfset this.storeManagerEmail = ValueList(getUserSiteRelRet.userEmail, ';')>
    <cfelse>
    <cfset this.storeManagerEmail = ''>
    </cfif>
    <cfinvoke 
    component="MCMS.component.utility.Email"
    method="sendEmail"
    returnvariable="sendEmailRet">
    <cfinvokeargument name="subject" value="Special Order Request No.#ARGUMENTS.soID# - Ordered"/>
    <cfinvokeargument name="to" value="#ARGUMENTS.userEmail#"/>
    <cfinvokeargument name="from" value="#session.userUsername#"/>
    <cfinvokeargument name="cc" value=""/><!---#this.storeManagerEmail#--->
    <cfinvokeargument name="bcc" value="#session.userUsername#"/>
    <cfinvokeargument name="body" value=""/>
    <cfinvokeargument name="ID" value="#ARGUMENTS.soID#"/>
    <cfinvokeargument name="emailTemplate" value="/#application.mcmsAppAdminPath#/special_order/view/inc_special_order_ordered_status_email_template.cfm"/>
    <cfinvokeargument name="emailType" value="html"/>
    </cfinvoke>
    <cfset result.message = "You have successfully inserted the record.<br /> All requisitions have been completed for all items and the Special Order status is now 'Ordered'. <br />An email notification has been sent.">
    </cfif>
    <cfcatch type="any">
    <cfset result.message = "There was an error inserting the record.">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="insertSpecialOrderRequisitionItemRel" access="public" returntype="struct">
    <cfargument name="soID" type="numeric" required="yes">
    <cfargument name="sorID" type="numeric" required="yes">
    <cfargument name="soiID" type="numeric" required="yes">
    <cfargument name="sorirQuantity" type="numeric" required="yes">
    <cfargument name="sorirStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully inserted the record.">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    INSERT INTO tbl_so_requisition_item_rel (soID,sorID,soiID,sorirQuantity,sorirStatus) VALUES
    (
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.soID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.sorID#">,
	<cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.soiID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.sorirQuantity#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.sorirStatus#">
    )
    </cfquery>
    </cftransaction>
    <!---Update the Items actual cost if it equals 0.--->
    <cfinvoke 
    component="MCMS.component.app.special_order.SpecialOrder"
    method="getSpecialOrderItem"
    returnvariable="getSpecialOrderItemRet">
    <cfinvokeargument name="ID" value="#ARGUMENTS.soiID#"/>
    <cfinvokeargument name="soiStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getSpecialOrderItemRet.soiActualCost EQ 0>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_special_order_item SET
    soiActualCost = <cfqueryparam cfsqltype="cf_sql_float" value="#getSpecialOrderItemRet.soiQuoteCost#">,
    soiActualMargin = <cfqueryparam cfsqltype="cf_sql_integer" value="#getSpecialOrderItemRet.soiQuoteMargin#">,
    soiActualRetail = <cfqueryparam cfsqltype="cf_sql_float" value="#getSpecialOrderItemRet.soiQuoteRetail#">,
    soiActualFreight = <cfqueryparam cfsqltype="cf_sql_float" value="#getSpecialOrderItemRet.soiQuoteFreight#">,
    soiActualPreTax = <cfqueryparam cfsqltype="cf_sql_float" value="#getSpecialOrderItemRet.soiQuotePreTax#">
    WHERE ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.soiID#">
    </cfquery>
    </cftransaction>
    </cfif>
    <cfcatch type="any">
    <cfset result.message = "There was an error inserting the record.">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="insertSpecialOrderRequisitionType" access="public" returntype="struct">
    <cfargument name="sortName" type="string" required="yes">
    <cfargument name="sortMessage" type="string" required="yes">
    <cfargument name="sortSort" type="numeric" required="yes">
    <cfargument name="sortStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully inserted the record.">
    <cftry>
    <!---Check for profanity in the text.--->
    <cfinvoke 
    component="MCMS.component.utility.Regex"
    method="regexProfanity"
    returnvariable="regexProfanityRet">
    <cfinvokeargument name="profanityString" value="#ARGUMENTS.sortMessage#"/>
    </cfinvoke>
    <!---Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.app.special_order.SpecialOrder"
    method="getSpecialOrderRequisitionType"
    returnvariable="getCheckSpecialOrderRequisitionTypeRet">
    <cfinvokeargument name="sortName" value="#ARGUMENTS.sortName#"/>
    <cfinvokeargument name="sortStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckSpecialOrderRequisitionTypeRet.recordcount NEQ 0>
    <cfset result.message = "The name #ARGUMENTS.sortName# already exists, please enter a new name.">
    <cfelseif regexProfanityRet CONTAINS '$%&*!'>
    <cfset result.message = "Some text contained profanity, please remove any profanity from your text.">
    <!---Check length restriction.--->
    <cfelseif LEN(ARGUMENTS.sortMessage) GT 2048>
    <cfset result.message = "The message is longer than 2048 characters, please enter a new message under 2048 characters.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    INSERT INTO tbl_so_requisition_type (sortName,sortMessage,sortSort,sortStatus) VALUES
    (
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.sortName#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.sortMessage#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.sortSort#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.sortStatus#">
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
    
    <cffunction name="insertSpecialOrderTransactionType" access="public" returntype="struct">
    <cfargument name="sottName" type="string" required="yes">
    <cfargument name="sottSort" type="numeric" required="yes">
    <cfargument name="sottStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully inserted the record.">
    <cftry>
    <!---Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.app.special_order.SpecialOrder"
    method="getSpecialOrderTransactionType"
    returnvariable="getCheckSpecialOrderTransactionTypeRet">
    <cfinvokeargument name="sottName" value="#ARGUMENTS.sottName#"/>
    <cfinvokeargument name="sottStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckSpecialOrderTransactionTypeRet.recordcount NEQ 0>
    <cfset result.message = "The name #ARGUMENTS.sottName# already exists, please enter a new name.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    INSERT INTO tbl_so_transaction_type (sottName,sottSort,sottStatus) VALUES
    (
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.sottName#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.sottSort#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.sottStatus#">
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
    
    <cffunction name="insertSpecialOrderLogType" access="public" returntype="struct">
    <cfargument name="soltName" type="string" required="yes">
    <cfargument name="soltSort" type="numeric" required="yes">
    <cfargument name="soltStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully inserted the record.">
    <cftry>
    <!---Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.app.special_order.SpecialOrder"
    method="getSpecialOrderLogType"
    returnvariable="getCheckSpecialOrderLogTypeRet">
    <cfinvokeargument name="soltName" value="#ARGUMENTS.soltName#"/>
    <cfinvokeargument name="soltStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckSpecialOrderLogTypeRet.recordcount NEQ 0>
    <cfset result.message = "The name #ARGUMENTS.soltName# already exists, please enter a new name.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    INSERT INTO tbl_special_order_log_type (soltName,soltSort,soltStatus) VALUES
    (
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.soltName#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.soltSort#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.soltStatus#">
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
    
    <cffunction name="insertSOPADCategoryRel" access="public" returntype="struct">
    <cfargument name="paID" type="numeric" required="yes">
    <cfargument name="deptNo" type="numeric" required="yes">
    <cfargument name="catID" type="numeric" required="yes">
    <cfargument name="sopadcrRequired" type="string" required="yes">
    <cfargument name="sopadcrStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully inserted the record.">
    <cftry>
    <!---Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.app.special_order.SpecialOrder"
    method="getSOPADCategoryRel"
    returnvariable="getCheckSOPADCategoryRelRet">
    <cfinvokeargument name="paID" value="#ARGUMENTS.paID#"/>
    <cfinvokeargument name="deptNo" value="#ARGUMENTS.deptNo#"/>
    <cfinvokeargument name="catID" value="#ARGUMENTS.catID#"/>
    <cfinvokeargument name="sopadcrStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckSOPADCategoryRelRet.recordcount NEQ 0>
    <cfset result.message = "The attribute by department and category already exists in this format, please try again.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    INSERT INTO tbl_so_pa_d_category_rel (paID,deptNo,catID,sopadcrRequired,sopadcrStatus) VALUES
    (
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.paID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.deptNo#">,
	<cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.catID#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.sopadcrRequired#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.sopadcrStatus#">
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
    
    <cffunction name="updateSpecialOrder" access="public" returntype="struct">
    <cfargument name="ID" type="numeric" required="yes">
    <cfargument name="siteNo" type="numeric" required="yes">
    <cfargument name="userIDAssigned" type="numeric" required="yes">
    <cfargument name="soiName" type="string" required="yes">
    <cfargument name="soiDescription" type="string" required="yes">
    <cfargument name="bName" type="string" required="yes">
    <cfargument name="soiMPN" type="string" required="yes">
    <cfargument name="soiSKU" type="string" required="yes">
    <cfargument name="soiQuantity" type="numeric" required="yes">
    <cfargument name="uomID" type="numeric" required="yes">
    <cfargument name="soiQuoteCost" type="string" required="yes">
    <cfargument name="soiQuoteMargin" type="string" required="yes">
    <cfargument name="soiQuoteRetail" type="string" required="yes">
    <cfargument name="soiQuoteFreight" type="string" required="yes">
    <cfargument name="soiQuotePreTax" type="string" required="yes">
    <cfargument name="soiActualCost" type="string" required="yes" default="">
    <cfargument name="soiActualMargin" type="string" required="yes" default="">
    <cfargument name="soiActualRetail" type="string" required="yes" default="">
    <cfargument name="soiActualFreight" type="string" required="yes" default="">
    <cfargument name="soiActualPreTax" type="string" required="yes" default="">
    <cfargument name="sosID" type="numeric" required="yes">
    <cfargument name="soStatus" type="numeric" required="yes" default="1">
    <!---Include other arguments.--->
    <cfargument name="count" type="numeric" required="yes">
    <cfset result.message = "You have successfully updated the record.">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_special_order SET
    userIP = <cfqueryparam cfsqltype="cf_sql_varchar" value="#CGI.REMOTE_ADDR#">,
    userIDAssigned = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.userIDAssigned#">,
    <cfif ARGUMENTS.sosID EQ 3>
    soDateCancelled = <cfqueryparam cfsqltype="cf_sql_timestamp" value="#Now()#">,
    </cfif>
    <cfif ARGUMENTS.sosID EQ 5>
    soDateCompleted = <cfqueryparam cfsqltype="cf_sql_timestamp" value="#Now()#">,
    </cfif>
    <cfif ARGUMENTS.sosID EQ 6>
    soDateAbandoned = <cfqueryparam cfsqltype="cf_sql_timestamp" value="#Now()#">,
    </cfif>
    sosID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.sosID#">,
    soStatus = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.soStatus#">
    WHERE ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ID#">
    </cfquery>
    </cftransaction>
    <!---Do not add items if Special Order is cancelled.--->
    <cfif ARGUMENTS.sosID NEQ 3 AND ARGUMENTS.soiName NEQ ''>
    <!---Insert the Item and Attributes.--->
    <cfinvoke 
    component="MCMS.component.app.special_order.SpecialOrder"
    method="insertSpecialOrderItem"
    returnvariable="result">
    <cfinvokeargument name="soID" value="#ARGUMENTS.ID#"/>
    <cfinvokeargument name="soiName" value="#ARGUMENTS.soiName#"/>
    <cfinvokeargument name="soiDescription" value="#ARGUMENTS.soiDescription#"/>
    <cfinvokeargument name="bName" value="#ARGUMENTS.bName#"/>
    <cfinvokeargument name="soiMPN" value="#ARGUMENTS.soiMPN#"/>
    <cfinvokeargument name="soiSKU" value="#ARGUMENTS.soiSKU#"/>
    <cfinvokeargument name="soiQuantity" value="#ARGUMENTS.soiQuantity#"/>
    <cfinvokeargument name="uomID" value="#ARGUMENTS.uomID#"/>
    <cfinvokeargument name="soiQuoteCost" value="#ARGUMENTS.soiQuoteCost#"/>
    <cfinvokeargument name="soiQuoteMargin" value="#ARGUMENTS.soiQuoteMargin#"/>
    <cfinvokeargument name="soiQuoteRetail" value="#ARGUMENTS.soiQuoteRetail#"/>
    <cfinvokeargument name="soiQuoteFreight" value="#ARGUMENTS.soiQuoteFreight#"/>
    <cfinvokeargument name="soiQuotePreTax" value="#ARGUMENTS.soiQuotePreTax#"/>
    <cfinvokeargument name="soiActualCost" value="#ARGUMENTS.soiActualCost#"/>
    <cfinvokeargument name="soiActualMargin" value="#ARGUMENTS.soiActualMargin#"/>
    <cfinvokeargument name="soiActualRetail" value="#ARGUMENTS.soiActualRetail#"/>
    <cfinvokeargument name="soiActualFreight" value="#ARGUMENTS.soiActualFreight#"/>
    <cfinvokeargument name="soiActualPreTax" value="#ARGUMENTS.soiActualPreTax#"/>
    <cfinvokeargument name="count" value="#ARGUMENTS.count#"/>
    <cfinvokeargument name="soiStatus" value="1"/>
    </cfinvoke>
    </cfif>
    <!---Email notification if the status is pending.--->
    <!---Get the Store Manager email to CC.--->
    <cfinvoke 
    component="MCMS.component.cms.User"
    method="getUserSiteRel"
    returnvariable="getUserSiteRelRet">
    <cfinvokeargument name="urID" value="104"/>
    <cfinvokeargument name="siteNo" value="#ARGUMENTS.siteNo#"/>
    <cfinvokeargument name="usrStatus" value="1"/>
    </cfinvoke>
    <cfif getUserSiteRelRet.recordcount NEQ 0>
    <cfset this.storeManagerEmail = ValueList(getUserSiteRelRet.userEmail, ';')>
    <cfelse>
    <cfset this.storeManagerEmail = ''>
    </cfif>
    <cfswitch expression="#ARGUMENTS.sosID#">
    <!---Send the a notification to the requestee.---> 
    <cfcase value="3">
    <cfinvoke 
    component="MCMS.component.utility.Email"
    method="sendEmail"
    returnvariable="sendEmailRet">
    <cfinvokeargument name="subject" value="Special Order Request No.#ARGUMENTS.ID# - Cancelled"/>
    <cfinvokeargument name="to" value="#ARGUMENTS.userEmail#"/>
    <cfinvokeargument name="from" value="#session.userUsername#"/>
    <cfinvokeargument name="cc" value=""/><!---#this.storeManagerEmail#--->
    <cfinvokeargument name="bcc" value="#session.userUsername#"/>
    <cfinvokeargument name="body" value=""/>
    <cfinvokeargument name="ID" value="#ARGUMENTS.ID#"/>
    <cfinvokeargument name="emailTemplate" value="/#application.mcmsAppAdminPath#/special_order/view/inc_special_order_cancelled_status_email_template.cfm"/>
    <cfinvokeargument name="emailType" value="html"/>
    </cfinvoke>
    </cfcase>
    <cfcase value="4">
    <cfinvoke 
    component="MCMS.component.utility.Email"
    method="sendEmail"
    returnvariable="sendEmailRet">
    <cfinvokeargument name="subject" value="Special Order Request No.#ARGUMENTS.ID# - Ordered"/>
    <cfinvokeargument name="to" value="#ARGUMENTS.userEmail#"/>
    <cfinvokeargument name="from" value="#session.userUsername#"/>
    <cfinvokeargument name="cc" value=""/><!---#this.storeManagerEmail#--->
    <cfinvokeargument name="bcc" value="#session.userUsername#"/>
    <cfinvokeargument name="body" value=""/>
    <cfinvokeargument name="ID" value="#ARGUMENTS.ID#"/>
    <cfinvokeargument name="emailTemplate" value="/#application.mcmsAppAdminPath#/special_order/view/inc_special_order_ordered_status_email_template.cfm"/>
    <cfinvokeargument name="emailType" value="html"/>
    </cfinvoke>
    </cfcase>
    </cfswitch>
    <cfcatch type="any">
    <cfset result.message = "There was an error updating the record.">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="updateSpecialOrderCustomer" access="public" returntype="struct">
    <cfargument name="ID" type="numeric" required="yes">
    <cfargument name="siteNo" type="numeric" required="yes">
    <cfargument name="cstFName" type="string" required="yes">
    <cfargument name="cstLName" type="string" required="yes">
    <cfargument name="cstEmail" type="string" required="yes">
    <cfargument name="cstDOB" type="string" required="yes">
    <cfargument name="cstTelArea" type="string" required="yes">
    <cfargument name="cstTelPrefix" type="string" required="yes">
    <cfargument name="cstTelSuffix" type="string" required="yes">
    <cfargument name="cstTelAltArea" type="string" required="yes">
    <cfargument name="cstTelAltPrefix" type="string" required="yes">
    <cfargument name="cstTelAltSuffix" type="string" required="yes">
    <cfargument name="cstAddress" type="string" required="yes">
    <cfargument name="cstAddressExt" type="string" required="yes">
    <cfargument name="cstCity" type="string" required="yes">
    <cfargument name="cstStateProv" type="string" required="yes">
    <cfargument name="cstZipCode" type="string" required="yes">
    <cfargument name="cstZipCodeExt" type="string" required="yes">
    <cfargument name="cstCountry" type="string" required="yes">
    <cfargument name="soTaxExemptNo" type="string" required="yes">
    <cfargument name="csttID" type="numeric" required="yes">
    <!---Check for opt-in.--->
    <cfargument name="optIn" type="string" required="yes" default="false">
    <cfset result.message = "You have successfully updated the record.">
    <cftry>
    <cfif ARGUMENTS.optIn EQ true AND ARGUMENTS.cstEmail NEQ ''>
    <!---Add Opt-in here.--->
    <cfinvoke 
    component="MCMS.component.app.subscription.Subscription"
    method="insertSubscriptionSiteRel"
    returnvariable="result">
    <cfinvokeargument name="siteNo" value="#ARGUMENTS.siteNo#"/>
    <cfinvokeargument name="subEmail" value="#ARGUMENTS.cstEmail#"/>
    <cfinvokeargument name="subPassword" value="password"/>
    <cfinvokeargument name="subFName" value="#ARGUMENTS.cstFName#"/>
    <cfinvokeargument name="subLName" value="#ARGUMENTS.cstLName#"/>
    <cfinvokeargument name="subTelArea" value="#ARGUMENTS.cstTelArea#"/>
    <cfinvokeargument name="subTelPrefix" value="#ARGUMENTS.cstTelPrefix#"/>
    <cfinvokeargument name="subTelSuffix" value="#ARGUMENTS.cstTelSuffix#"/>
    <cfinvokeargument name="subZipCode" value="#IIf(ARGUMENTS.cstZipCode EQ '', DE('0'), DE(ARGUMENTS.cstZipCode))#"/>
    <cfinvokeargument name="subZipCodeExt" value="#ARGUMENTS.cstZipCodeExt#"/>
    <cfinvokeargument name="subStateProv" value="#ARGUMENTS.cstStateProv#"/>
    <cfinvokeargument name="subCountry" value="#ARGUMENTS.cstCountry#"/>
    <cfinvokeargument name="subStatus" value="1"/>
    </cfinvoke>
    </cfif>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_special_order SET
    userIP = <cfqueryparam cfsqltype="cf_sql_varchar" value="#CGI.REMOTE_ADDR#">,
    cstFName = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.cstFName#">,
    cstLName = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.cstLName#">,
    cstEmail = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.cstEmail#">,
    cstDOB = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.cstDOB#">,
    cstTelArea = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.cstTelArea#">,
    cstTelPrefix = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.cstTelPrefix#">,
    cstTelSuffix = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.cstTelSuffix#">,
    cstTelAltArea = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.cstTelAltArea#">,
    cstTelAltPrefix = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.cstTelAltPrefix#">,
    cstAddress = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.cstAddress#">,
    cstAddressExt = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.cstAddressExt#">,
    cstCity = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.cstCity#">,
    cstStateProv = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.cstStateProv#">,
    cstZipCode = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.cstZipCode#">,
    cstZipCodeExt = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.cstZipCodeExt#">,
    cstCountry = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.cstCountry#">,
    soTaxExemptNo = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.soTaxExemptNo#">,
    csttID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.csttID#">
    WHERE ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ID#">
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error updating the record.">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="updateSpecialOrderStatus" access="public" returntype="struct">
    <cfargument name="ID" type="numeric" required="yes">
    <cfargument name="sosName" type="string" required="yes" default="">
    <cfargument name="sosMessage" type="string" required="yes" default="">
    <cfargument name="sosSort" type="numeric" required="yes">
    <cfargument name="sosStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully updated the record.">
    <cftry>
    <!---Check for profanity in the text.--->
    <cfinvoke 
    component="MCMS.component.utility.Regex"
    method="regexProfanity"
    returnvariable="regexProfanityRet">
    <cfinvokeargument name="profanityString" value="#ARGUMENTS.sosMessage#"/>
    </cfinvoke>
    <!---Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.app.special_order.SpecialOrder"
    method="getSpecialOrderStatus"
    returnvariable="getCheckSpecialOrderStatusRet">
    <cfinvokeargument name="excludeID" value="#ARGUMENTS.ID#"/>
    <cfinvokeargument name="sosName" value="#ARGUMENTS.sosName#"/>
    <cfinvokeargument name="sosStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckSpecialOrderStatusRet.recordcount NEQ 0>
    <cfset result.message = "The name #ARGUMENTS.sosName# already exists, please enter a new name.">
    <cfelseif regexProfanityRet CONTAINS '$%&*!'>
    <cfset result.message = "Some text contained profanity, please remove any profanity from your text.">
    <!---Check length restriction.--->
    <cfelseif LEN(ARGUMENTS.sosMessage) GT 2048>
    <cfset result.message = "The message is longer than 2048 characters, please enter a new message under 2048 characters.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_special_order_status SET
    sosName = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.sosName#">,
    sosMessage = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.sosMessage#">,
    sosSort = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.sosSort#">,
    sosStatus = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.sosStatus#">
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
    
    <cffunction name="updateSpecialOrderItem" access="public" returntype="struct">
    <cfargument name="ID" type="numeric" required="yes">
    <cfargument name="soID" type="numeric" required="yes">
    <cfargument name="soiName" type="string" required="yes">
    <cfargument name="soiDescription" type="string" required="yes">
    <cfargument name="soiMPN" type="string" required="yes">
    <cfargument name="soiSKU" type="string" required="yes">
    <cfargument name="soiQuantity" type="numeric" required="yes">
    <cfargument name="uomID" type="numeric" required="yes">
    <cfargument name="soiQuoteCost" type="string" required="yes">
    <cfargument name="soiQuoteMargin" type="string" required="yes">
    <cfargument name="soiQuoteRetail" type="string" required="yes">
    <cfargument name="soiQuoteFreight" type="string" required="yes">
    <cfargument name="soiQuotePreTax" type="string" required="yes">
    <cfargument name="soiActualCost" type="string" required="yes">
    <cfargument name="soiActualMargin" type="string" required="yes">
    <cfargument name="soiActualRetail" type="string" required="yes">
    <cfargument name="soiActualFreight" type="string" required="yes">
    <cfargument name="soiActualPreTax" type="string" required="yes">
    <cfargument name="soiStatus" type="numeric" required="yes">
    <!---Include other arguments.--->
    <cfargument name="count" type="numeric" required="yes">
    <cfset result.message = "You have successfully updated the record.">
    <cftry>
    <!---Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.app.special_order.SpecialOrder"
    method="getSpecialOrderItem"
    returnvariable="getCheckSpecialOrderItemRet">
    <cfinvokeargument name="excludeID" value="#ARGUMENTS.ID#"/>
    <cfinvokeargument name="soID" value="#ARGUMENTS.soID#"/>
    <cfinvokeargument name="soiName" value="#ARGUMENTS.soiName#"/>
    <cfinvokeargument name="soiStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckSpecialOrderItemRet.recordcount NEQ 0>
    <cfset result.message = "The item #ARGUMENTS.soiName# already exists, please enter a new item name.">
    <cfelse>
    <!---Check for a Brand.--->
    <cfset this.bID = 0>
    <cfif ARGUMENTS.bName NEQ "">
    <cfinvoke 
    component="MCMS.component.app.vendor.Vendor"
    method="getBrand"
    returnvariable="getBrandRet">
    <cfinvokeargument name="bName" value="#ARGUMENTS.bName#"/>
    <cfinvokeargument name="bStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getBrandRet.recordcount NEQ 0>
    <cfset this.bID = getBrandRet.ID>
    <cfelse>
    <!---If the Vendor does not exist, create it, and send an email to an administrator.--->
    <cfinvoke 
    component="MCMS.component.app.vendor.Vendor"
    method="insertBrand"
    returnvariable="insertBrandRet">
    <cfinvokeargument name="bName" value="#ARGUMENTS.bName#"/>
    <cfinvokeargument name="bDescription" value="#ARGUMENTS.bName#"/>
    <cfinvokeargument name="bStatus" value="3"/>
    </cfinvoke>
    <!---Get the Brand ID just added.--->
    <cfinvoke 
    component="MCMS.component.app.vendor.Vendor"
    method="getBrand"
    returnvariable="getBrandRet">
    <cfinvokeargument name="bName" value="#ARGUMENTS.bName#"/>
    <cfinvokeargument name="bStatus" value="1,2,3"/>
    </cfinvoke>
    <cfset this.bID = getBrandRet.ID>
    </cfif>
    </cfif>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_special_order_item SET
    soiName = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.soiName#">,
    soiDescription = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.soiDescription#">,
    bID = <cfqueryparam cfsqltype="cf_sql_integer" value="#this.bID#">,
    soiMPN = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.soiMPN#">,
    soiSKU = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.soiSKU#">,
    soiQuantity = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.soiQuantity#">,
    uomID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.uomID#">,
    soiQuoteCost = <cfqueryparam cfsqltype="cf_sql_float" value="#ARGUMENTS.soiQuoteCost#">,
    soiQuoteMargin = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.soiQuoteMargin#">,
    soiQuoteRetail = <cfqueryparam cfsqltype="cf_sql_float" value="#ARGUMENTS.soiQuoteRetail#">,
    soiQuoteFreight = <cfqueryparam cfsqltype="cf_sql_float" value="#ARGUMENTS.soiQuoteFreight#">,
    soiQuotePreTax = <cfqueryparam cfsqltype="cf_sql_float" value="#ARGUMENTS.soiQuotePreTax#">,
    soiActualCost = <cfqueryparam cfsqltype="cf_sql_float" value="#ARGUMENTS.soiActualCost#">,
    soiActualMargin = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.soiActualMargin#">,
    soiActualRetail = <cfqueryparam cfsqltype="cf_sql_float" value="#ARGUMENTS.soiActualRetail#">,
    soiActualFreight = <cfqueryparam cfsqltype="cf_sql_float" value="#ARGUMENTS.soiActualFreight#">,
    soiActualPreTax = <cfqueryparam cfsqltype="cf_sql_float" value="#ARGUMENTS.soiActualPreTax#">,
    soiDate = <cfqueryparam cfsqltype="cf_sql_timestamp" value="#Now()#">,
    soiStatus = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.soiStatus#">
    WHERE ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ID#">
    </cfquery>
    </cftransaction>
    <!---Insert Attributes.--->
    <cfif ARGUMENTS.count GT 0>
    <cfloop index="i" from="1" to="#ARGUMENTS.count#">
    <cfinvoke 
    component="MCMS.component.app.special_order.SpecialOrder"
    method="insertSpecialOrderItemAttribute"
    returnvariable="insertSpecialOrderItemAttributeRet">
    <cfinvokeargument name="soID" value="#ARGUMENTS.soID#"/>
    <cfinvokeargument name="soiID" value="#ARGUMENTS.ID#"/>
    <cfinvokeargument name="soiaName" value="#Evaluate('form.soiaName#i#')#"/>
    <cfinvokeargument name="soiaValue" value="#Evaluate('form.soiaValue#i#')#"/>
    <cfinvokeargument name="soiaStatus" value="1"/>
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
    
    <cffunction name="updateSpecialOrderItemAttribute" access="public" returntype="struct">
    <cfargument name="ID" type="numeric" required="yes">
    <cfargument name="soiaName" type="string" required="yes">
    <cfargument name="soiaValue" type="string" required="yes">
    <cfargument name="soiaStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully updated the record.">
    <cftry>
    <!---Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.app.special_order.SpecialOrder"
    method="getSpecialOrderItemAttribute"
    returnvariable="getCheckSpecialOrderItemAttributeRet">
    <cfinvokeargument name="excludeID" value="#ARGUMENTS.ID#"/>
    <cfinvokeargument name="soiaName" value="#ARGUMENTS.soiaName#"/>
    <cfinvokeargument name="soiaStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckSpecialOrderItemAttributeRet.recordcount NEQ 0>
    <cfset result.message = "The attribute #ARGUMENTS.soiaName# already exists, please enter a new attribute name.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_so_item_attribute SET
    soiaName = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.soiaName#">,
    soiaValue = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.soiaValue#">,
    soiaStatus = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.soiaStatus#">
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
    
    <cffunction name="updateSpecialOrderLog" access="public" returntype="struct">
    <cfargument name="ID" type="numeric" required="yes">
    <cfargument name="userID" type="numeric" required="yes">
    <cfargument name="solDescription" type="string" required="yes">
    <cfargument name="soltID" type="numeric" required="yes">
    <cfargument name="solStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully updated the record.">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_special_order_log SET
    userID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.userID#">,
    solDescription = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.solDescription#">,
    soltID = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.soltID#">,
    solStatus = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.solStatus#">
    WHERE ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ID#">
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error updating the record.">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="updateSpecialOrderTransaction" access="public" returntype="struct">
    <cfargument name="ID" type="numeric" required="yes">
    <cfargument name="userID" type="numeric" required="yes">
    <cfargument name="sotAmount" type="string" required="yes">
    <cfargument name="sotRegisterID" type="string" required="yes">
    <cfargument name="sotTransactionID" type="string" required="yes">
    <cfargument name="sottID" type="numeric" required="yes">
    <cfargument name="sotStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully updated the record.">
    <cftry>
    <!---Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.app.special_order.SpecialOrder"
    method="getSpecialOrderTransaction"
    returnvariable="getCheckSpecialOrderTransactionRet">
    <cfinvokeargument name="excludeID" value="#ARGUMENTS.ID#"/>
    <cfinvokeargument name="sotDate" value="#DateFormat(Now(), 'mm/dd/yyyy')#"/>
    <cfinvokeargument name="sotTransactionID" value="#ARGUMENTS.sotTransactionID#"/>
    <cfinvokeargument name="sotStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckSpecialOrderTransactionRet.recordcount NEQ 0>
    <cfset result.message = "The transaction #ARGUMENTS.sotTransactionID# already exists for this order, please enter a new transaction number.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_so_transaction SET
    soID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.soID#">,
    userID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.userID#">,
    userIP = <cfqueryparam cfsqltype="cf_sql_varchar" value="#CGI.REMOTE_ADDR#">,
    sotAmount = <cfqueryparam cfsqltype="cf_sql_float" value="#ARGUMENTS.sotAmount#">,
    sotRegisterID = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.sotRegisterID#">,
    sotTransactionID = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.sotTransactionID#">,
    sotDate = <cfqueryparam cfsqltype="cf_sql_timestamp" value="#Now()#">,
    sottID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.sottID#">,
    sotStatus = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.sotStatus#">
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
    
    <cffunction name="updateSpecialOrderRequisition" access="public" returntype="struct">
    <cfargument name="ID" type="numeric" required="yes">
    <cfargument name="userID" type="numeric" required="yes">
    <cfargument name="siteNoFrom" type="numeric" required="yes">
    <cfargument name="siteNoTo" type="numeric" required="yes">
    <cfargument name="sorDateShipEst" type="string" required="yes">
    <cfargument name="sorNumber" type="string" required="yes">
    <cfargument name="sortID" type="numeric" required="yes">
    <cfargument name="sorStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully updated the record.">
    <cftry>
    <!---Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.app.special_order.SpecialOrder"
    method="getSpecialOrderRequisition"
    returnvariable="getCheckSpecialOrderRequisitionRet">
    <cfinvokeargument name="excludeID" value="#ARGUMENTS.ID#"/>
    <cfinvokeargument name="sorNumber" value="#ARGUMENTS.sorNumber#"/>
    <cfinvokeargument name="sorStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckSpecialOrderRequisitionRet.recordcount NEQ 0>
    <cfset result.message = "The requisition #ARGUMENTS.sorNumber# already exists for this order, please enter a new requisition number.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_so_requisition SET
    userID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.userID#">,
	siteNoFrom = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.siteNoFrom#">,
    siteNoTo = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.siteNoTo#">,
    sorDateShipEst = <cfqueryparam cfsqltype="cf_sql_date" value="#ARGUMENTS.sorDateShipEst#">,
    sorNumber = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.sorNumber#">,
    sortID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.sortID#">,
    sorStatus = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.sorStatus#">
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
    
    <cffunction name="updateSpecialOrderRequisitionItemRel" access="public" returntype="struct">
    <cfargument name="ID" type="numeric" required="yes">
    <cfargument name="soID" type="numeric" required="yes">
    <cfargument name="sorID" type="numeric" required="yes">
    <cfargument name="soiID" type="numeric" required="yes">
    <cfargument name="sorirQuantity" type="string" required="yes">
    <cfargument name="sorirStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully updated the record.">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_so_requisition_item_rel SET
    soID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.userID#">,
    sorID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.sorID#">,
	soiID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.soiID#">,
    sorirQuantity = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.sorirQuantity#">,
    sorirStatus = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.sorirStatus#">
    WHERE ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ID#">
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error updating the record.">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="updateSpecialOrderRequisitionType" access="public" returntype="struct">
    <cfargument name="ID" type="numeric" required="yes">
    <cfargument name="sortName" type="string" required="yes" default="">
    <cfargument name="sortMessage" type="string" required="yes" default="">
    <cfargument name="sortSort" type="numeric" required="yes">
    <cfargument name="sortStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully updated the record.">
    <cftry>
    <!---Check for profanity in the text.--->
    <cfinvoke 
    component="MCMS.component.utility.Regex"
    method="regexProfanity"
    returnvariable="regexProfanityRet">
    <cfinvokeargument name="profanityString" value="#ARGUMENTS.sortMessage#"/>
    </cfinvoke>
    <!---Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.app.special_order.SpecialOrder"
    method="getSpecialOrderRequisitionType"
    returnvariable="getCheckSpecialOrderRequisitionTypeRet">
    <cfinvokeargument name="excludeID" value="#ARGUMENTS.ID#"/>
    <cfinvokeargument name="sortName" value="#ARGUMENTS.sortName#"/>
    <cfinvokeargument name="sortStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckSpecialOrderRequisitionTypeRet.recordcount NEQ 0>
    <cfset result.message = "The name #ARGUMENTS.sortName# already exists, please enter a new name.">
    <cfelseif regexProfanityRet CONTAINS '$%&*!'>
    <cfset result.message = "Some text contained profanity, please remove any profanity from your text.">
    <!---Check length restriction.--->
    <cfelseif LEN(ARGUMENTS.sortMessage) GT 2048>
    <cfset result.message = "The message is longer than 2048 characters, please enter a new message under 2048 characters.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_so_requisition_type SET
    sortName = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.sortName#">,
    sortMessage = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.sortMessage#">,
    sortSort = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.sortSort#">,
    sortStatus = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.sortStatus#">
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
    
    <cffunction name="updateSpecialOrderTransactionType" access="public" returntype="struct">
    <cfargument name="ID" type="numeric" required="yes">
    <cfargument name="sottName" type="string" required="yes" default="">
    <cfargument name="sottSort" type="numeric" required="yes">
    <cfargument name="sottStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully updated the record.">
    <cftry>
    <!---Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.app.special_order.SpecialOrder"
    method="getSpecialOrderTransactionType"
    returnvariable="getCheckSpecialOrderTransactionTypeRet">
    <cfinvokeargument name="excludeID" value="#ARGUMENTS.ID#"/>
    <cfinvokeargument name="sottName" value="#ARGUMENTS.sottName#"/>
    <cfinvokeargument name="sottStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckSpecialOrderTransactionTypeRet.recordcount NEQ 0>
    <cfset result.message = "The name #ARGUMENTS.sottName# already exists, please enter a new name.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_so_transaction_type SET
    sottName = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.sottName#">,
    sottSort = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.sottSort#">,
    sottStatus = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.sottStatus#">
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
    
    <cffunction name="updateSpecialOrderLogType" access="public" returntype="struct">
    <cfargument name="ID" type="numeric" required="yes">
    <cfargument name="soltName" type="string" required="yes" default="">
    <cfargument name="soltSort" type="numeric" required="yes">
    <cfargument name="soltStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully updated the record.">
    <cftry>
    <!---Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.app.special_order.SpecialOrder"
    method="getSpecialOrderLogType"
    returnvariable="getCheckSpecialOrderLogTypeRet">
    <cfinvokeargument name="excludeID" value="#ARGUMENTS.ID#"/>
    <cfinvokeargument name="soltName" value="#ARGUMENTS.soltName#"/>
    <cfinvokeargument name="soltStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckSpecialOrderLogTypeRet.recordcount NEQ 0>
    <cfset result.message = "The name #ARGUMENTS.soltName# already exists, please enter a new name.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_special_order_log_type SET
    soltName = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.soltName#">,
    soltSort = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.soltSort#">,
    soltStatus = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.soltStatus#">
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
    
    <cffunction name="updateSOPADCategoryRel" access="public" returntype="struct">
    <cfargument name="ID" type="numeric" required="yes">
    <cfargument name="paID" type="numeric" required="yes">
    <cfargument name="deptNo" type="numeric" required="yes">
    <cfargument name="catID" type="numeric" required="yes">
    <cfargument name="sopadcrRequired" type="string" required="yes">
    <cfargument name="sopadcrStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully updated the record.">
    <cftry>
    <!---Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.app.special_order.SpecialOrder"
    method="getSOPADCategoryRel"
    returnvariable="getCheckSOPADCategoryRelRet">
    <cfinvokeargument name="excludeID" value="#ARGUMENTS.ID#"/>
    <cfinvokeargument name="paID" value="#ARGUMENTS.paID#"/>
    <cfinvokeargument name="deptNo" value="#ARGUMENTS.deptNo#"/>
    <cfinvokeargument name="catID" value="#ARGUMENTS.catID#"/>
    <cfinvokeargument name="sopadcrStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckSOPADCategoryRelRet.recordcount NEQ 0>
    <cfset result.message = "The attribute by department and category already exists in this format, please try again.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_so_pa_d_category_rel SET
    paID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.paID#">,
    deptNo = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.deptNo#">,
	catID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.catID#">,
    sopadcrRequired = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.sopadcrRequired#">,
    sopadcrStatus = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.sopadcrStatus#">
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
    
    <cffunction name="updateSpecialOrderList" access="public" returntype="struct">
    <cfargument name="ID" type="numeric" required="yes">
    <cfargument name="soStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully updated the records.">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_special_order SET
    soStatus = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.soStatus#">
    WHERE ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ID#">
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error updating the records.">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="updateSpecialOrderStatusList" access="public" returntype="struct">
    <cfargument name="ID" type="numeric" required="yes">
    <cfargument name="sosStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully updated the records.">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_special_order_status SET
    sosStatus = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.sosStatus#">
    WHERE ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ID#">
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error updating the records.">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="updateSpecialOrderLogTypeList" access="public" returntype="struct">
    <cfargument name="ID" type="numeric" required="yes">
    <cfargument name="soltStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully updated the records.">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_special_order_log_type SET
    soltStatus = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.soltStatus#">
    WHERE ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ID#">
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error updating the records.">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="updateSpecialOrderTransactionList" access="public" returntype="struct">
    <cfargument name="ID" type="numeric" required="yes">
    <cfargument name="sotStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully updated the records.">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_so_transaction SET
    sotStatus = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.sotStatus#">
    WHERE ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ID#">
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error updating the records.">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="updateSpecialOrderTransactionTypeList" access="public" returntype="struct">
    <cfargument name="ID" type="numeric" required="yes">
    <cfargument name="sottStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully updated the records.">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_so_transaction_type SET
    sottStatus = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.sottStatus#">
    WHERE ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ID#">
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error updating the records.">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="updateSpecialOrderRequisitionList" access="public" returntype="struct">
    <cfargument name="ID" type="numeric" required="yes">
    <cfargument name="sorStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully updated the records.">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_so_requisition SET
    sorStatus = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.sorStatus#">
    WHERE ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ID#">
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error updating the records.">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="updateSpecialOrderRequisitionTypeList" access="public" returntype="struct">
    <cfargument name="ID" type="numeric" required="yes">
    <cfargument name="sortStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully updated the records.">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_so_requisition_type SET
    sortStatus = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.sortStatus#">
    WHERE ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ID#">
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error updating the records.">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="updateSOPADCategoryRelList" access="public" returntype="struct">
    <cfargument name="ID" type="numeric" required="yes">
    <cfargument name="sopadcrStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully updated the records.">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_so_pa_d_category_rel SET
    sopadcrStatus = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.sopadcrStatus#">
    WHERE ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ID#">
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error updating the records.">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="deleteSpecialOrder" access="public" returntype="struct">
    <cfargument name="ID" type="string" required="yes">
    <cfset result.message = "You have successfully deleted the record(s).">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    DELETE FROM tbl_special_order
    WHERE ID IN (<cfqueryparam cfsqltype="cf_sql_integer" list="yes" value="#ARGUMENTS.ID#">)
    </cfquery>
    </cftransaction>
    <!---Delete any Items.--->
    <cfinvoke 
    component="MCMS.component.app.special_order.SpecialOrder"
    method="deleteSpecialOrderItem"
    returnvariable="deleteSpecialOrderItemRet">
    <cfinvokeargument name="soID" value="#ARGUMENTS.ID#"/>
    </cfinvoke>
    <!---Delete any Logs.--->
    <cfinvoke 
    component="MCMS.component.app.special_order.SpecialOrder"
    method="deleteSpecialOrderLog"
    returnvariable="deleteSpecialOrderLogRet">
    <cfinvokeargument name="soID" value="#ARGUMENTS.ID#"/>
    </cfinvoke>
    <!---Delete any transactions.--->
    <cfinvoke 
    component="MCMS.component.app.special_order.SpecialOrder"
    method="deleteSpecialOrderTransaction"
    returnvariable="deleteSpecialOrderTransactionRet">
    <cfinvokeargument name="soID" value="#ARGUMENTS.ID#"/>
    </cfinvoke>
    <!---Delete any requisitions/requistion items.--->
    <cfinvoke 
    component="MCMS.component.app.special_order.SpecialOrder"
    method="deleteSpecialOrderRequisition"
    returnvariable="deleteSpecialOrderRequisitionRet">
    <cfinvokeargument name="soID" value="#ARGUMENTS.ID#"/>
    </cfinvoke>
    <cfinvoke 
    component="MCMS.component.app.special_order.SpecialOrder"
    method="deleteSpecialOrderRequisitionItemRel"
    returnvariable="deleteSpecialOrderRequisitionItemRelRet">
    <cfinvokeargument name="soID" value="#ARGUMENTS.ID#"/>
    </cfinvoke>
    <cfcatch type="any">
    <cfset result.message = "There was an error deleting the record(s).">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="deleteSpecialOrderStatus" access="public" returntype="struct">
    <cfargument name="ID" type="string" required="yes">
    <cfset result.message = "You have successfully deleted the record(s).">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    DELETE FROM tbl_special_order_status
    WHERE ID IN (<cfqueryparam cfsqltype="cf_sql_integer" list="yes" value="#ARGUMENTS.ID#">)
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error deleting the record(s).">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction> 
    
    <cffunction name="deleteSpecialOrderItem" access="public" returntype="struct">
    <cfargument name="ID" type="string" required="yes" default="0">
    <cfargument name="soID" type="string" required="yes" default="0">
    <cfset result.message = "You have successfully deleted the record(s).">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    DELETE FROM tbl_special_order_item
    WHERE ID IN (<cfqueryparam cfsqltype="cf_sql_integer" list="yes" value="#ARGUMENTS.ID#">)
    OR soID IN (<cfqueryparam cfsqltype="cf_sql_integer" list="yes" value="#ARGUMENTS.soID#">)
    </cfquery>
    </cftransaction>
    <cfinvoke 
    component="MCMS.component.app.special_order.SpecialOrder"
    method="deleteSpecialOrderItemAttribute"
    returnvariable="deleteSpecialOrderItemAttributeRet">
    <cfinvokeargument name="soiID" value="#ARGUMENTS.ID#"/>
    <cfinvokeargument name="soID" value="#ARGUMENTS.soID#"/>
    </cfinvoke>
    <cfinvoke 
    component="MCMS.component.app.special_order.SpecialOrder"
    method="deleteSpecialOrderRequisitionItemRel"
    returnvariable="deleteSpecialOrderRequisitionItemRelRet">
    <cfinvokeargument name="soiID" value="#ARGUMENTS.ID#"/>
    <cfinvokeargument name="soID" value="#ARGUMENTS.soID#"/>
    </cfinvoke>
    <cfcatch type="any">
    <cfset result.message = "There was an error deleting the record(s).">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>  
    
    <cffunction name="deleteSpecialOrderItemAttribute" access="public" returntype="struct">
    <cfargument name="ID" type="string" required="yes" default="0">
    <cfargument name="soiID" type="string" required="yes" default="0">
    <cfargument name="soID" type="string" required="yes" default="0">
    <cfset result.message = "You have successfully deleted the record(s).">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    DELETE FROM tbl_so_item_attribute
    WHERE ID IN (<cfqueryparam cfsqltype="cf_sql_integer" list="yes" value="#ARGUMENTS.ID#">) 
    OR soiID IN (<cfqueryparam cfsqltype="cf_sql_integer" list="yes" value="#ARGUMENTS.soiID#">) 
    OR soID IN (<cfqueryparam cfsqltype="cf_sql_integer" list="yes" value="#ARGUMENTS.soID#">) 
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error deleting the record(s).">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="deleteSpecialOrderLog" access="public" returntype="struct">
    <cfargument name="ID" type="string" required="yes" default="0">
    <cfargument name="soID" type="string" required="yes" default="0">
    <cfset result.message = "You have successfully deleted the record(s).">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    DELETE FROM tbl_special_order_log
    WHERE ID IN (<cfqueryparam cfsqltype="cf_sql_integer" list="yes" value="#ARGUMENTS.ID#">)
    OR soID IN (<cfqueryparam cfsqltype="cf_sql_integer" list="yes" value="#ARGUMENTS.soID#">)
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error deleting the record(s).">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="deleteSpecialOrderLogType" access="public" returntype="struct">
    <cfargument name="ID" type="string" required="yes">
    <cfset result.message = "You have successfully deleted the record(s).">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    DELETE FROM tbl_special_order_log_type
    WHERE ID IN (<cfqueryparam cfsqltype="cf_sql_integer" list="yes" value="#ARGUMENTS.ID#">)
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error deleting the record(s).">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="deleteSpecialOrderTransaction" access="public" returntype="struct">
    <cfargument name="ID" type="string" required="yes" default="0">
    <cfargument name="soID" type="string" required="yes" default="0">
    <cfset result.message = "You have successfully deleted the record(s).">
    <cftry>
    <!---Adjust balance owed when a tranasaction is deleted.--->
    <cfinvoke 
    component="MCMS.component.app.special_order.SpecialOrder"
    method="getSpecialOrderTransaction"
    returnvariable="getSpecialOrderTransactionRet">
    <cfinvokeargument name="ID" value="#ARGUMENTS.ID#"/>
    <cfinvokeargument name="sotStatus" value="1,2,3"/>
    </cfinvoke>
    <cfset this.sotAmount = getSpecialOrderTransactionRet.sotAmount>
    <cfset this.soID = getSpecialOrderTransactionRet.soID>
    <!---Get the current balance.--->
    <cfinvoke 
    component="MCMS.component.app.special_order.SpecialOrder"
    method="getSpecialOrder"
    returnvariable="getSpecialOrderRet">
    <cfinvokeargument name="ID" value="#this.soID#"/>
    <cfinvokeargument name="soStatus" value="1,2,3"/>
    </cfinvoke>
    <cfset this.soBalance = getSpecialOrderRet.soBalance>
    <cfif this.soBalance GT 0>
    <cfset this.soBalance = this.soBalance-this.sotAmount>
    </cfif>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_special_order SET
    soBalance = <cfqueryparam cfsqltype="cf_sql_float" value="#DecimalFormat(this.soBalance)#">
    WHERE ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#this.soID#">
    </cfquery>
    </cftransaction>
    <!---Delete the transaction.--->
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    DELETE FROM tbl_so_transaction
    WHERE ID IN (<cfqueryparam cfsqltype="cf_sql_integer" list="yes" value="#ARGUMENTS.ID#">)
    OR soID IN (<cfqueryparam cfsqltype="cf_sql_integer" list="yes" value="#ARGUMENTS.soID#">)
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error deleting the record(s).">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="deleteSpecialOrderTransactionType" access="public" returntype="struct">
    <cfargument name="ID" type="string" required="yes">
    <cfset result.message = "You have successfully deleted the record(s).">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    DELETE FROM tbl_so_transaction_type
    WHERE ID IN (<cfqueryparam cfsqltype="cf_sql_integer" list="yes" value="#ARGUMENTS.ID#">)
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error deleting the record(s).">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="deleteSpecialOrderRequisition" access="public" returntype="struct">
    <cfargument name="ID" type="string" required="yes" default="0">
    <cfargument name="soID" type="string" required="yes" default="0">
    <cfset result.message = "You have successfully deleted the record(s).">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    DELETE FROM tbl_so_requisition
    WHERE ID IN (<cfqueryparam cfsqltype="cf_sql_integer" list="yes" value="#ARGUMENTS.ID#">)
    OR soID IN (<cfqueryparam cfsqltype="cf_sql_integer" list="yes" value="#ARGUMENTS.soID#">)
    </cfquery>
    </cftransaction>
    <cfinvoke 
    component="MCMS.component.app.special_order.SpecialOrder"
    method="deleteSpecialOrderRequisitionItemRel"
    returnvariable="deleteSpecialOrderRequisitionItemRelRet">
    <cfinvokeargument name="sorID" value="#ARGUMENTS.ID#"/>
    </cfinvoke>
    <cfcatch type="any">
    <cfset result.message = "There was an error deleting the record(s).">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="deleteSpecialOrderRequisitionItemRel" access="public" returntype="struct">
    <cfargument name="ID" type="string" required="yes" default="0">
    <cfargument name="soID" type="string" required="yes" default="0">
    <cfargument name="soiID" type="string" required="yes" default="0">
    <cfargument name="sorID" type="string" required="yes" default="0">
    <cfset result.message = "You have successfully deleted the record(s).">
    <cftry>
    <!---Get the count of item rel. requistions to check if the requition should be deleted.--->
    <cfif ARGUMENTS.sorID EQ 0>
    <cfinvoke 
    component="MCMS.component.app.special_order.SpecialOrder"
    method="getSpecialOrderRequisitionItemRel"
    returnvariable="getSpecialOrderRequisitionItemRelRet">
    <cfinvokeargument name="ID" value="#ARGUMENTS.ID#"/>
    <cfinvokeargument name="sorirStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getSpecialOrderRequisitionItemRelRet.recordcount NEQ 0>
    <cfset this.sorID = getSpecialOrderRequisitionItemRelRet.sorID>
    <cfinvoke 
    component="MCMS.component.app.special_order.SpecialOrder"
    method="getSpecialOrderRequisitionItemRel"
    returnvariable="getSpecialOrderRequisitionItemRelRet">
    <cfinvokeargument name="sorID" value="#this.sorID#"/>
    <cfinvokeargument name="sorirStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getSpecialOrderRequisitionItemRelRet.recordcount LTE 1>
    <cfinvoke 
    component="MCMS.component.app.special_order.SpecialOrder"
    method="deleteSpecialOrderRequisition"
    returnvariable="deleteSpecialOrderRequisitionRet">
    <cfinvokeargument name="ID" value="#this.sorID#"/>
    </cfinvoke>
    </cfif>
    </cfif>
    </cfif>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    DELETE FROM tbl_so_requisition_item_rel
    WHERE ID IN (<cfqueryparam cfsqltype="cf_sql_integer" list="yes" value="#ARGUMENTS.ID#">) 
    OR soID IN (<cfqueryparam cfsqltype="cf_sql_integer" list="yes" value="#ARGUMENTS.soID#">)
    OR soiID IN (<cfqueryparam cfsqltype="cf_sql_integer" list="yes" value="#ARGUMENTS.soiID#">)
    OR sorID IN (<cfqueryparam cfsqltype="cf_sql_integer" list="yes" value="#ARGUMENTS.sorID#">)
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error deleting the record(s).">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="deleteSpecialOrderRequisitionType" access="public" returntype="struct">
    <cfargument name="ID" type="string" required="yes">
    <cfset result.message = "You have successfully deleted the record(s).">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    DELETE FROM tbl_so_requisition_type
    WHERE ID IN (<cfqueryparam cfsqltype="cf_sql_integer" list="yes" value="#ARGUMENTS.ID#">)
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error deleting the record(s).">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="deleteSOPADCategoryRel" access="public" returntype="struct">
    <cfargument name="ID" type="string" required="yes">
    <cfset result.message = "You have successfully deleted the record(s).">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    DELETE FROM tbl_so_pa_d_category_rel
    WHERE ID IN (<cfqueryparam cfsqltype="cf_sql_integer" list="yes" value="#ARGUMENTS.ID#">)
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error deleting the record(s).">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="addAttributeLines" access="remote" returntype="struct" output="yes">
    <cfargument name="formName" type="string" default="0">
    <cfargument name="deptNo" type="string" default="0">
    <cfargument name="count" type="numeric" default="0">
    <cfset result = StructNew()>
    <cfset result.formName = ARGUMENTS.formName>
    <cfsavecontent variable="newline">
    <table id="mainTableAlt">
    <tr>
    <td width="10">#ARGUMENTS.count+1#.</td>
    <td width="10" class="bold">Name:</td>
    <td width="10">
    <input type="text" name="soiaName#ARGUMENTS.count+1#" id="soiaName#ARGUMENTS.count+1#" size="16" maxlength="32" message="Please include a value for Attribute Value for line #ARGUMENTS.count+1#.">
    </td>
    <td width="10" class="bold">Value:</td>
    <td width="10">
    <input type="text" name="soiaValue#ARGUMENTS.count+1#" id="soiaValue#ARGUMENTS.count+1#" size="16" maxlength="32" message="Please include a value for Attribute Value for line #ARGUMENTS.count+1#.">
    </td>
    <td>
    <a href="javascript:delIt('#ARGUMENTS.formName#',#ARGUMENTS.count+1#)"><span class="glyphicon glyphicon-remove-circle"></span></a>
    </td>
    </tr>
    </table>
    </cfsavecontent>
    <cfset result.newline = newline>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="attributeLines" access="remote" returntype="struct" output="yes">
    <cfargument name="formName" type="string" default="0">
    <cfargument name="deptNo" type="string" default="0">
    <cfargument name="catID" type="string" default="0">
    <cfset result = StructNew()>
    <cfset result.formName = ARGUMENTS.formName>
    <cfquery name="getSOPADCategoryRelRet" datasource="swweb">
    SELECT * FROM v_so_pa_d_category_rel WHERE 0=0
    <cfif ARGUMENTS.deptNo NEQ 0>
    AND deptNo = <cfqueryparam value="#ARGUMENTS.deptNo#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.catID NEQ 0>
    AND catID = <cfqueryparam value="#ARGUMENTS.catID#" cfsqltype="cf_sql_integer">
    </cfif>
    AND sopadcrStatus = <cfqueryparam value="1" cfsqltype="cf_sql_integer">
    ORDER BY paSort, paName
    </cfquery>
    <cfsavecontent variable="attributeLine">
    <table id="mainTableAlt">
    <cfif getSOPADCategoryRelRet.recordcount EQ 0>
    <tr>
    <td id="required" colspan="5">There are no attributes available for this Category.</td>
    </tr>
    <cfelse>
    <cfoutput query="getSOPADCategoryRelRet">
    <tr>
    <td width="10">#CurrentRow#.</td>
    <td width="10" class="bold">Name:</td>
    <td width="10" nowrap>#paName#</td>
    <td class="bold">Value:</td>
    <td>
    <!---Determine the product type.--->
    <cfswitch expression="#patID#">
    <cfcase value="1">
    <input type="text" name="soiaValue#CurrentRow#" id="soiaValue#CurrentRow#" required="#Iif(sopadcrRequired EQ true, DE('true'), DE('false'))#" message="Please include a value for Attribute Name for line #CurrentRow#.">
    </cfcase>
    <cfcase value="2">
    <cfquery name="getProductAttributeValueRet" datasource="swweb">
    SELECT * FROM v_product_attribute_value WHERE 0=0
    AND paID = <cfqueryparam value="#paID#" cfsqltype="cf_sql_integer">
    AND pavStatus = <cfqueryparam value="1" cfsqltype="cf_sql_integer">
    ORDER BY pavSort, pavValue
    </cfquery>
    <cfif getProductAttributeValueRet.recordcount EQ 0>
    There are no values for this attribute.
    <cfelse>
    <select name="soiaValue#CurrentRow#" id="soiaValue#CurrentRow#" required="#Iif(sopadcrRequired EQ true, DE('true'), DE('false'))#" message="Please include a value for Attribute Name for line #CurrentRow#.">
    <option value="">Select an Value...</option>
    <cfloop query="getProductAttributeValueRet"><option value="#pavValue#">#pavValue#</option>
    </cfloop>
    </select>
    <cfif sopadcrRequired EQ true><span id="required">*</span></cfif>
    </cfif>
    </cfcase>
    </cfswitch>
    <input type="hidden" name="soiaName#CurrentRow#" id="soiaName#CurrentRow#" value="#paName#">
    </td>
    </tr>
    </cfoutput>
    </cfif>
    </table>
    <input type="hidden" name="count" id="count" value="#getSOPADCategoryRelRet.recordcount#">
    </cfsavecontent>
    <cfset result.attributeLine = attributeLine>
    <cfreturn result>
    </cffunction>
</cfcomponent>