<cfcomponent>
    <cffunction name="getOrder" access="public" returntype="query" hint="Get Order data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="ID" type="numeric" required="yes" default="0">
    <cfargument name="excludeID" type="numeric" required="yes" default="0">
    <cfargument name="orderID" type="string" required="yes" default="">
    <cfargument name="siteNo" type="string" required="yes" default="100">
    <cfargument name="cartID" type="numeric" required="yes" default="0">
    <cfargument name="cstID" type="numeric" required="yes" default="0">
    <cfargument name="cID" type="string" required="yes" default="0">
    <cfargument name="orderDate" type="string" required="yes" default="">
    <cfargument name="orderDateProcess" type="string" required="yes" default="">
    <cfargument name="orderDateShip" type="string" required="yes" default="">
    <cfargument name="orderDateHistory" type="string" required="yes" default="">
    <cfargument name="smID" type="numeric" required="yes" default="0">
    <cfargument name="ssID" type="numeric" required="yes" default="0">
    <cfargument name="stID" type="numeric" required="yes" default="0">
    <cfargument name="ordertID" type="numeric" required="yes" default="0">
    <cfargument name="userID" type="numeric" required="yes" default="0">
    <cfargument name="orderStatus" type="string" required="yes" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="cID, orderDate DESC">
    <cfset var rsOrder = "" >
    <cftry>
    <cfquery name="rsOrder" datasource="#application.mcmsDSN#">
    SELECT * FROM v_order WHERE 0=0
    <cfif ARGUMENTS.ID NEQ 0>
    AND ID = <cfqueryparam value="#ARGUMENTS.ID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.excludeID NEQ 0>
    AND ID <> <cfqueryparam value="#ARGUMENTS.excludeID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(orderID) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(cstFName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(cstLName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(cstAccount) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(orderPO) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(cstEmail) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">)
    </cfif>
    <cfif ARGUMENTS.orderID NEQ "">
    AND UPPER(orderID) = <cfqueryparam value="#UCASE(ARGUMENTS.orderID)#" cfsqltype="cf_sql_varchar">
    </cfif>
    <cfif ARGUMENTS.cartID NEQ 0>
    AND cartID = <cfqueryparam value="#ARGUMENTS.cartID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.cstID NEQ 0>
    AND cstID = <cfqueryparam value="#ARGUMENTS.cstID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.cID NEQ 0>
    AND cID IN (<cfqueryparam value="#ARGUMENTS.cID#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    <cfif ARGUMENTS.orderDate NEQ "">
    AND orderDate <= <cfqueryparam value="#ARGUMENTS.orderDate#" cfsqltype="cf_sql_date">
    </cfif>
    <cfif ARGUMENTS.orderDateProcess NEQ "">
    AND orderDateProcess <= <cfqueryparam value="#ARGUMENTS.orderDateProcess#" cfsqltype="cf_sql_date">
    </cfif>
    <cfif ARGUMENTS.orderDateShip NEQ "">
    AND orderDateShip <= <cfqueryparam value="#ARGUMENTS.orderDateShip#" cfsqltype="cf_sql_date">
    </cfif>
    <cfif ARGUMENTS.orderDateHistory NEQ "">
    AND orderDateHistory <= <cfqueryparam value="#ARGUMENTS.orderDateHistory#" cfsqltype="cf_sql_date">
    </cfif>
    <cfif ARGUMENTS.smID NEQ 0>
    AND smID = <cfqueryparam value="#ARGUMENTS.smID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.ssID NEQ 0>
    AND ssID = <cfqueryparam value="#ARGUMENTS.ssID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.stID NEQ 0>
    AND stID = <cfqueryparam value="#ARGUMENTS.stID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.ordertID NEQ 0>
    AND ordertID = <cfqueryparam value="#ARGUMENTS.ordertID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.userID NEQ 0>
    AND userID = <cfqueryparam value="#ARGUMENTS.userID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.siteNo NEQ 100>
    AND siteNo IN (<cfqueryparam value="#ARGUMENTS.siteNo#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    AND orderStatus IN (<cfqueryparam value="#ARGUMENTS.orderStatus#" list="yes" cfsqltype="cf_sql_integer">)
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsOrder = StructNew()>
    <cfset rsOrder.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfset request.catalogID = rsOrder.cID>
    <cfset request.catalogName = rsOrder.cName>
    <cfreturn rsOrder>
    </cffunction>
    
    <cffunction name="getOrderLine" access="public" returntype="query" hint="Get Order Line data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="ID" type="numeric" required="yes" default="0">
    <cfargument name="excludeID" type="numeric" required="yes" default="0">
    <cfargument name="orderID" type="string" required="yes" default="0">
    <cfargument name="oID" type="numeric" required="yes" default="0">
    <cfargument name="pID" type="numeric" required="yes" default="0">
    <cfargument name="sID" type="numeric" required="yes" default="0">
    <cfargument name="userID" type="numeric" required="yes" default="0">
    <cfargument name="orderlStatus" type="string" required="yes" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="orderID, pID, orderDate DESC">
    <cfset var rsOrderLine = "" >
    <cftry>
    <cfquery name="rsOrderLine" datasource="#application.mcmsDSN#">
    SELECT * FROM v_order_line WHERE 0=0
    <cfif ARGUMENTS.ID NEQ 0>
    AND ID = <cfqueryparam value="#ARGUMENTS.ID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.excludeID NEQ 0>
    AND ID <> <cfqueryparam value="#ARGUMENTS.excludeID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.orderID NEQ 0>
    AND orderID = <cfqueryparam value="#ARGUMENTS.orderID#" cfsqltype="cf_sql_varchar">
    </cfif>
    <cfif ARGUMENTS.oID NEQ 0>
    AND oID = <cfqueryparam value="#ARGUMENTS.oID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.pID NEQ 0>
    AND pID = <cfqueryparam value="#ARGUMENTS.pID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.sID NEQ 0>
    AND sID = <cfqueryparam value="#ARGUMENTS.sID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.userID NEQ 0>
    AND userID = <cfqueryparam value="#ARGUMENTS.userID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND UPPER(orderID) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">
    </cfif>
    AND orderlStatus IN (<cfqueryparam value="#ARGUMENTS.orderlStatus#" list="yes" cfsqltype="cf_sql_integer">)
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsOrderLine = StructNew()>
    <cfset rsOrderLine.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsOrderLine>
    </cffunction>
    
    <cffunction name="getOrderID" access="public" returntype="string">
    <cfset var orderID = 0>
    <cftry>
    <cfinvoke 
    component="MCMS.component.cms.Cms"
    method="getMaxValueSQL"
    returnvariable="oID">
    <cfinvokeargument name="tableName" value="tbl_order"/>
    </cfinvoke>
    <cfif oID EQ ''>
    <cfset this.oID = 100>
    <cfelse>
    <cfset this.oID = oID+1>
    </cfif>
    <cfset orderID = application.catalogID & '-' & DateFormat(Now(), 'mmddyy') & '-' & TimeFormat(Now(), 'HHmm') & '-' & this.oID>
    <cfcatch type="any">
    <cfset orderID = 0>
    </cfcatch>
    </cftry>
    <cfreturn orderID>
    </cffunction>
    
    <cffunction name="setOrderStatus" access="public" returntype="string" hint="Contol the path for order status based on the orders 'ssID'.">
    <cfargument name="orderID" type="numeric" required="yes" default="0">
    <cfargument name="ssID" type="numeric" required="yes" default="0">
    <cfargument name="sendEmail" type="string" required="yes" default="false">
    <cfset var ssIDList = 0>
    <cftry>
    <!---Get order information.--->
    <cfinvoke 
    component="MCMS.component.app.order.Order"
    method="getOrder"
    returnvariable="getOrderRet">
    <cfinvokeargument name="ID" value="#ARGUMENTS.orderID#"/>
    <cfinvokeargument name="orderStatus" value="1"/>
    </cfinvoke>
    <!---Set the default emails for orders.--->
    <cfset this.emailAddressOrder = application.webmasterEmail>
	<cfset this.emailAddressReply = application.webmasterEmail>
    <cfset this.emailAddressVerify = application.webmasterEmail>
    <cfset this.emailAddressShipping = application.webmasterEmail>
    <!---Get the various value for the email from the Catalog ID.--->
    <cfinvoke 
    component="MCMS.component.app.catalog.Catalog"
    method="getCatalogAttributeRel"
    returnvariable="getCatalogAttributeRelRet">
    <cfinvokeargument name="cID" value="#getOrderRet.cID#"/>
    <cfinvokeargument name="caName" value="orderEmail"/>
    <cfinvokeargument name="carStatus" value="1"/>
    </cfinvoke>
    <cfif getCatalogAttributeRelRet.recordcount NEQ 0>
    <cfset this.emailAddressOrder = getCatalogAttributeRelRet.carValue>
    </cfif>
    <cfinvoke 
    component="MCMS.component.app.catalog.Catalog"
    method="getCatalogAttributeRel"
    returnvariable="getCatalogAttributeRelRet">
    <cfinvokeargument name="cID" value="#getOrderRet.cID#"/>
    <cfinvokeargument name="caName" value="orderEmailReply"/>
    <cfinvokeargument name="carStatus" value="1"/>
    </cfinvoke>
    <cfif getCatalogAttributeRelRet.recordcount NEQ 0>
    <cfset this.emailAddressReply = getCatalogAttributeRelRet.carValue>
    </cfif>
    <cfinvoke 
    component="MCMS.component.app.catalog.Catalog"
    method="getCatalogAttributeRel"
    returnvariable="getCatalogAttributeRelRet">
    <cfinvokeargument name="cID" value="#getOrderRet.cID#"/>
    <cfinvokeargument name="caName" value="shippingEmail"/>
    <cfinvokeargument name="carStatus" value="1"/>
    </cfinvoke>
    <cfif getCatalogAttributeRelRet.recordcount NEQ 0>
    <cfset this.emailAddressShipping = getCatalogAttributeRelRet.carValue>
    </cfif>
    <cfinvoke 
    component="MCMS.component.app.catalog.Catalog"
    method="getCatalogAttributeRel"
    returnvariable="getCatalogAttributeRelRet">
    <cfinvokeargument name="cID" value="#getOrderRet.cID#"/>
    <cfinvokeargument name="caName" value="orderVerifyEmail"/>
    <cfinvokeargument name="carStatus" value="1"/>
    </cfinvoke>
    <cfif getCatalogAttributeRelRet.recordcount NEQ 0>
    <cfset this.emailAddressVerify = getCatalogAttributeRelRet.carValue>
    </cfif>
    <cfswitch expression="#ARGUMENTS.ssID#">
    <cfdefaultcase>
    <cfset ssIDList = '101,103,104'>
    </cfdefaultcase>
    <cfcase value="102">
    <cfset ssIDList = '102,103,104'>
    <cfif ARGUMENTS.sendEmail EQ 'true'>
    <!--- Send Back Order email notification. --->
    <cfinvoke 
    component="MCMS.component.utility.Email"
    method="sendEmail">
    <cfinvokeargument name="subject" value="Order ###getOrderRet.orderID# Back Order."/>
    <cfinvokeargument name="to" value="#getOrderRet.orderEmail#"/>
    <cfinvokeargument name="from" value="#this.emailAddressReply#"/>
    <cfinvokeargument name="emailTemplate" value="/#application.mcmsAppAdminPath#/order/view/inc_order_ship_status_email.cfm"/>
    <cfinvokeargument name="ID" value="#ARGUMENTS.orderID#"/>
    <cfinvokeargument name="type" value="default"/>
    </cfinvoke>
    <!--- Send Back Order email notification to System Administrator. --->
    <cfinvoke 
    component="MCMS.component.utility.Email"
    method="sendEmail">
    <cfinvokeargument name="subject" value="Order ###getOrderRet.orderID# Back Order."/>
    <cfinvokeargument name="to" value="#this.emailAddressOrder#"/>
    <cfinvokeargument name="from" value="#this.emailAddressReply#"/>
    <cfinvokeargument name="emailTemplate" value="/#application.mcmsAppAdminPath#/order/view/inc_order_ship_status_email.cfm"/>
    <cfinvokeargument name="ID" value="#ARGUMENTS.orderID#"/>
    <cfinvokeargument name="type" value="admin"/>
    </cfinvoke>
    </cfif>
    </cfcase>
    <cfcase value="103">
    <cfset ssIDList = '103,104,105'>
    <cfif ARGUMENTS.sendEmail EQ 'true'>
    <!--- Send Verified email notification. --->
    <cfinvoke 
    component="MCMS.component.utility.Email"
    method="sendEmail">
    <cfinvokeargument name="subject" value="Order ###getOrderRet.orderID# Verified."/>
    <cfinvokeargument name="to" value="#getOrderRet.orderEmail#"/>
    <cfinvokeargument name="from" value="#this.emailAddressReply#"/>
    <cfinvokeargument name="emailTemplate" value="/#application.mcmsAppAdminPath#/order/view/inc_order_ship_status_email.cfm"/>
    <cfinvokeargument name="ID" value="#ARGUMENTS.orderID#"/>
    <cfinvokeargument name="type" value="default"/>
    </cfinvoke>
    <!--- Send Verified email notification to System Administrator. --->
    <cfinvoke 
    component="MCMS.component.utility.Email"
    method="sendEmail">
    <cfinvokeargument name="subject" value="Order ###getOrderRet.orderID# Verified."/>
    <cfinvokeargument name="to" value="#this.emailAddressVerify#"/>
    <cfinvokeargument name="from" value="#this.emailAddressReply#"/>
    <cfinvokeargument name="emailTemplate" value="/#application.mcmsAppAdminPath#/order/view/inc_order_ship_status_email.cfm"/>
    <cfinvokeargument name="ID" value="#ARGUMENTS.orderID#"/>
    <cfinvokeargument name="type" value="admin"/>
    </cfinvoke>
    </cfif>
    </cfcase>
    <cfcase value="104">
    <cfset ssIDList = '104,109'>
    <cfif ARGUMENTS.sendEmail EQ 'true'>
    <!--- Send Cancelled email notification. --->
    <cfinvoke 
    component="MCMS.component.utility.Email"
    method="sendEmail">
    <cfinvokeargument name="subject" value="Order ###getOrderRet.orderID# Cancelled."/>
    <cfinvokeargument name="to" value="#getOrderRet.orderEmail#"/>
    <cfinvokeargument name="from" value="#this.emailAddressReply#"/>
    <cfinvokeargument name="emailTemplate" value="/#application.mcmsAppAdminPath#/order/view/inc_order_ship_status_email.cfm"/>
    <cfinvokeargument name="ID" value="#ARGUMENTS.orderID#"/>
    <cfinvokeargument name="type" value="default"/>
    </cfinvoke>
    <!--- Send Cancelled email notification to System Administrator. --->
    <cfinvoke 
    component="MCMS.component.utility.Email"
    method="sendEmail">
    <cfinvokeargument name="subject" value="Order ###getOrderRet.orderID# Cancelled."/>
    <cfinvokeargument name="to" value="#this.emailAddressOrder#"/>
    <cfinvokeargument name="from" value="#this.emailAddressReply#"/>
    <cfinvokeargument name="emailTemplate" value="/#application.mcmsAppAdminPath#/order/view/inc_order_ship_status_email.cfm"/>
    <cfinvokeargument name="ID" value="#ARGUMENTS.orderID#"/>
    <cfinvokeargument name="type" value="admin"/>
    </cfinvoke>
    </cfif>
    </cfcase>
    <cfcase value="105">
    <cfset ssIDList = '105,106,107'>
    <cfif ARGUMENTS.sendEmail EQ 'true'>
    <!--- Send Adjusted email notification. --->
    <cfinvoke 
    component="MCMS.component.utility.Email"
    method="sendEmail">
    <cfinvokeargument name="subject" value="Order ###getOrderRet.orderID# Adjusted."/>
    <cfinvokeargument name="to" value="#this.emailAddressShipping#"/>
    <cfinvokeargument name="from" value="#this.emailAddressReply#"/>
    <cfinvokeargument name="emailTemplate" value="/#application.mcmsAppAdminPath#/order/view/inc_order_ship_status_email.cfm"/>
    <cfinvokeargument name="ID" value="#ARGUMENTS.orderID#"/>
    <cfinvokeargument name="type" value="default"/>
    </cfinvoke>
    </cfif>
    </cfcase>
    <cfcase value="106">
    <cfset ssIDList = '106,107,108,109'>
    <cfif ARGUMENTS.sendEmail EQ 'true'>
    <!--- Send Shipped email notification. --->
    <cfinvoke 
    component="MCMS.component.utility.Email"
    method="sendEmail">
    <cfinvokeargument name="subject" value="Order ###getOrderRet.orderID# Shipped."/>
    <cfinvokeargument name="to" value="#getOrderRet.orderEmail#"/>
    <cfinvokeargument name="from" value="#this.emailAddressReply#"/>
    <cfinvokeargument name="emailTemplate" value="/#application.mcmsAppAdminPath#/order/view/inc_order_ship_status_email.cfm"/>
    <cfinvokeargument name="ID" value="#ARGUMENTS.orderID#"/>
    <cfinvokeargument name="type" value="default"/>
    </cfinvoke>
    <!--- Send Ship email notification to System Administrator. --->
    <cfinvoke 
    component="MCMS.component.utility.Email"
    method="sendEmail">
    <cfinvokeargument name="subject" value="Order ###getOrderRet.orderID# Shipped."/>
    <cfinvokeargument name="to" value="#this.emailAddressShipping#"/>
    <cfinvokeargument name="from" value="#this.emailAddressReply#"/>
    <cfinvokeargument name="emailTemplate" value="/#application.mcmsAppAdminPath#/order/view/inc_order_ship_status_email.cfm"/>
    <cfinvokeargument name="ID" value="#ARGUMENTS.orderID#"/>
    <cfinvokeargument name="type" value="admin"/>
    </cfinvoke>
    </cfif>
    </cfcase>
    <cfcase value="107">
    <cfset ssIDList = '107,108,109'>
    <cfif ARGUMENTS.sendEmail EQ 'true'>
    <!--- Send Received email notification to System Administrator. --->
    <cfinvoke 
    component="MCMS.component.utility.Email"
    method="sendEmail">
    <cfinvokeargument name="subject" value="Order ###getOrderRet.orderID# Received."/>
    <cfinvokeargument name="to" value="#this.emailAddressVerify#"/>
    <cfinvokeargument name="from" value="#session.userUsername#"/>
    <cfinvokeargument name="emailTemplate" value="/#application.mcmsAppAdminPath#/order/view/inc_order_ship_status_email.cfm"/>
    <cfinvokeargument name="ID" value="#ARGUMENTS.orderID#"/>
    <cfinvokeargument name="type" value="admin"/>
    </cfinvoke>
    </cfif>
    </cfcase>
    <cfcase value="108">
    <cfset ssIDList = '106,108'>
    <cfif ARGUMENTS.sendEmail EQ 'true'>
    <!--- Send Return email notification. --->
    <cfinvoke 
    component="MCMS.component.utility.Email"
    method="sendEmail">
    <cfinvokeargument name="subject" value="Order ###getOrderRet.orderID# Return."/>
    <cfinvokeargument name="to" value="#getOrderRet.orderEmail#"/>
    <cfinvokeargument name="from" value="#this.emailAddressReply#"/>
    <cfinvokeargument name="emailTemplate" value="/#application.mcmsAppAdminPath#/order/view/inc_order_ship_status_email.cfm"/>
    <cfinvokeargument name="ID" value="#ARGUMENTS.orderID#"/>
    <cfinvokeargument name="type" value="default"/>
    </cfinvoke>
    <!--- Send Return email notification to System Administrator. --->
    <cfinvoke 
    component="MCMS.component.utility.Email"
    method="sendEmail">
    <cfinvokeargument name="subject" value="Order ###getOrderRet.orderID# Return."/>
    <cfinvokeargument name="to" value="#this.emailAddressOrder#"/>
    <cfinvokeargument name="from" value="#this.emailAddressReply#"/>
    <cfinvokeargument name="emailTemplate" value="/#application.mcmsAppAdminPath#/order/view/inc_order_ship_status_email.cfm"/>
    <cfinvokeargument name="ID" value="#ARGUMENTS.orderID#"/>
    <cfinvokeargument name="type" value="admin"/>
    </cfinvoke>
    </cfif>
    </cfcase>
    <cfcase value="109">
    <cfset ssIDList = '104,106,109'>
    <!--- No email just archive order. --->
    </cfcase>
    </cfswitch>
    <cfcatch type="any">
    <cfset ssIDList = 0>
    </cfcatch>
    </cftry>
    <cfreturn ssIDList>
    </cffunction>
    
    <cffunction name="setOrderEmailMessage" access="public" returntype="string" hint="Return a email message based on orders status.">
    <cfargument name="ssID" type="numeric" required="yes" default="0">
    <cfargument name="ordertID" type="numeric" required="yes" default="1">
    <cfargument name="type" type="string" required="yes" default="default">
    <cfset var orderEmailMessage = ''>
    <cftry>
    <cfswitch expression="#ARGUMENTS.ssID#">
    <cfdefaultcase>
    <cfif ARGUMENTS.type EQ 'default'>
    <cfset orderEmailMessage = 'Thank you for your order.'>
    <cfelseif ARGUMENTS.type EQ 'admin'>
    <cfset orderEmailMessage = 'Thank you for your order.'>
    </cfif>
    </cfdefaultcase>
    <cfcase value="102">
    <cfif ARGUMENTS.type EQ 'default'>
    <cfset orderEmailMessage = 'Your order has been Back-Ordered. We will notify you when your items become available.'>
    <cfelseif ARGUMENTS.type EQ 'admin'>
    <cfset orderEmailMessage = 'This order has been Back Ordered.'>
    </cfif>
    </cfcase>
    <cfcase value="103">
    <cfif ARGUMENTS.type EQ 'default'>
    <cfset orderEmailMessage = 'Your order has been Verified and recieved. We will notify you when the status of your order changes.'>
    <cfelseif ARGUMENTS.type EQ 'admin'>
    <cfset orderEmailMessage = 'This order has been Verified by #session.userName#.'>
    </cfif>
    </cfcase>
    <cfcase value="104">
    <cfif ARGUMENTS.type EQ 'default'>
    <cfset orderEmailMessage = 'Your order has been Cancelled. For more information please contact customer service.'>
    <cfelseif ARGUMENTS.type EQ 'admin'>
    <cfset orderEmailMessage = 'This order has been Cancelled.'>
    </cfif>
    </cfcase>
    <cfcase value="105">
    <cfif ARGUMENTS.type EQ 'default'>
    <cfset orderEmailMessage = 'The order has been Adjusted and is ready to be shipped.'>
    <cfelseif ARGUMENTS.type EQ 'admin'>
    <cfset orderEmailMessage = 'This order has been Adjusted.'>
    </cfif>
    </cfcase>
    <cfcase value="106">
    <cfif ARGUMENTS.type EQ 'default'>
    <cfset orderEmailMessage = 'Your order has been Shipped.'>
    <cfelseif ARGUMENTS.type EQ 'admin'>
    <cfset orderEmailMessage = 'This order has been Shipped.'>
    </cfif>
    </cfcase>
    <cfcase value="107">
    <cfif ARGUMENTS.type EQ 'default'>
    <cfset orderEmailMessage = 'Your order has been Received.'>
    <cfelseif ARGUMENTS.type EQ 'admin'>
    <cfset orderEmailMessage = 'This order has been Received.'>
    </cfif>
    </cfcase>
    <cfcase value="108">
    <cfif ARGUMENTS.type EQ 'default'>
    <cfset orderEmailMessage = 'Your order has been Returned. We will notify you when the status of your order changes.'>
    <cfelseif ARGUMENTS.type EQ 'admin'>
    <cfset orderEmailMessage = 'This order has been Returned. Please process the order.'>
    </cfif>
    </cfcase>
    <cfcase value="109">
    <!---Archived does not require a message.--->
    </cfcase>
    </cfswitch>
    <cfcatch type="any">
    <cfset orderEmailMessage = ''>
    </cfcatch>
    </cftry>
    <cfreturn orderEmailMessage>
    </cffunction>
    
    <cffunction name="getOrderShipStatus" access="public" returntype="query" hint="Get Order Ship Status data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="ID" type="string" required="yes" default="0">
    <cfargument name="excludeID" type="numeric" required="yes" default="0">
    <cfargument name="ssName" type="string" required="yes" default="">
    <cfargument name="ssStatus" type="string" required="yes" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="ssStatus">
    <cfset var rsOrderShipStatus = "" >
    <cftry>
    <cfquery name="rsOrderShipStatus" datasource="#application.mcmsDSN#">
    SELECT * FROM tbl_ship_status WHERE 0=0
    <cfif ARGUMENTS.ID NEQ 0>
    AND ID IN (<cfqueryparam value="#ARGUMENTS.ID#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    <cfif ARGUMENTS.excludeID NEQ 0>
    AND ID <> <cfqueryparam value="#ARGUMENTS.excludeID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(ssName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">)
    </cfif>
    <cfif ARGUMENTS.ssName NEQ "">
    AND UPPER(ssName) = <cfqueryparam value="#UCASE(ARGUMENTS.ssName)#" cfsqltype="cf_sql_varchar">
    </cfif>
    AND ssStatus IN (<cfqueryparam value="#ARGUMENTS.ssStatus#" list="yes" cfsqltype="cf_sql_integer">)
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsOrderShipStatus = StructNew()>
    <cfset rsOrderShipStatus.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsOrderShipStatus>
    </cffunction>
    
    <cffunction name="getOrderReport" access="public" returntype="query" hint="Get Order Report data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="siteNo" type="string" required="yes" default="100">
    <cfargument name="deptNo" type="string" required="yes" default="0">
    <cfargument name="args" type="string" required="yes" default="0">
    <cfargument name="orderBy" type="string" required="yes" default="orderDate">
    <cfset var rsOrderReport = "" >
    <cftry>
    <cfquery name="rsOrderReport" datasource="#application.mcmsDSN#">
    SELECT orderID AS Order_Id, cstAccount AS Account_EmpID, cName AS Catalog, cstfName || ' ' || cstlName AS Cust_Name, orderEmail AS Cust_Email, orderTelArea || ' ' || orderTelPrefix || '-' || orderTelSuffix AS Cust_Tel,
    siteNo, orderPO, orderAddress, orderAddressExt, orderCity, orderStateProv, orderZipCode, orderZipCodeExt, orderCountry, orderTax, orderShipping, TO_CHAR(orderTotal, '$9,999.00') AS Order_Total, TO_CHAR(orderDate, 'mm/dd/yyyy') AS Order_Date, TO_CHAR(orderDateProcess, 'mm/dd/yyyy') AS Order_Date_Process, TO_CHAR(orderDateShip, 'mm/dd/yyyy') AS Order_Date_Ship, TO_CHAR(orderDateHistory, 'mm/dd/yyyy') AS Order_Date_History, userfName || ' ' || userlName AS User_Name, userEmail AS User_Email, smName AS Ship_Method, orderComment, orderGiftMessage, orderGiftWrap, ssName As Ship_Status, sName As Status FROM v_order WHERE 0=0
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(orderID) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(cstFName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(cstLName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">)
    </cfif>
    <cfif ARGUMENTS.siteNo NEQ 100>
    AND siteNo IN (<cfqueryparam value="#ARGUMENTS.siteNo#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    <cfif ListGetAt(ARGUMENTS.args, 1) NEQ 0>
    AND ssID = <cfqueryparam value="#ListGetAt(ARGUMENTS.args, 1)#" cfsqltype="cf_sql_integer">
    </cfif>
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsOrderReport = StructNew()>
    <cfset rsOrderReport.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsOrderReport>
    </cffunction>
    
    <cffunction name="insertOrder" access="public" returntype="struct">
    <cfargument name="orderPO" type="string" required="yes" default="">
    <cfargument name="cartID" type="string" required="yes" default="0">
    <cfargument name="cstID" type="numeric" required="yes" default="0">
    <cfargument name="cID" type="numeric" required="yes" default="#application.catalogID#">
    <cfargument name="orderComment" type="string" required="yes" default="">
    <cfargument name="orderGiftMessage" type="string" required="yes" default="">
    <cfargument name="orderGiftWrap" type="numeric" required="yes" default="0">
    <cfargument name="orderTax" type="string" required="yes" default="0.00">
    <cfargument name="orderShipping" type="string" required="yes" default="0.00">
    <cfargument name="orderTotal" type="string" required="yes" default="0.00">
    <cfargument name="smID" type="numeric" required="yes" default="0">
    <cfargument name="ssID" type="numeric" required="yes" default="101">
    <cfargument name="stID" type="numeric" required="yes" default="0">
    <cfargument name="ordertID" type="numeric" required="yes" default="0">
    <cfargument name="userID" type="numeric" required="yes" default="0">
    <!---Get arguments of products/skus in cart.--->
    <cfargument name="pIDList" type="string" required="yes" default="0">
    <cfargument name="sIDList" type="string" required="yes" default="0">
    <cfargument name="skuQuantityList" type="string" required="yes" default="0">
    <cfargument name="skuPriceList" type="string" required="yes" default="0">
    <!---Get siteNo when applicable.--->
    <cfargument name="siteNo" type="numeric" required="yes" default="100">
    <cfset result.message = application.orderMessage>
    <cfset result.error = false>
    <cftry>
    <!---First check the sku QOH.--->
    <cfloop index="i" from="1" to="#ListLen(ARGUMENTS.sIDList)#">
    <cfinvoke 
    component="MCMS.component.app.sku.Sku"
    method="getSku"
    returnvariable="getSkuRet">
    <cfinvokeargument name="ID" value="#ListGetAt(ARGUMENTS.sIDList, i)#"/>
    <cfinvokeargument name="skuStatus" value="1"/>
    </cfinvoke>
    <cfif getSkuRet.skuQOH LT ListGetAt(ARGUMENTS.skuQuantityList, i)>
    <cfset result.error = true>
    <cfset result.message = 'You added a total of #ListGetAt(ARGUMENTS.skuQuantityList, i)# of #getSkuRet.pName# (Item No. #getSkuRet.skuID#) to your cart.<br/> Unfortunately, another customer has since purchased this item. There is now #getSkuRet.skuQOH# available.  Please adjust your cart to continue.<br/><br/>
	<a href="/cart/">My Cart</a>
	'>
    </cfif>
    <cfbreak>
    </cfloop>
    <!---If QOH is available continue.--->
    <cfif result.error EQ false>
    <!---Get order ID.--->
    <cfinvoke 
    component="MCMS.component.app.order.Order"
    method="getOrderID"
    returnvariable="orderID">
    </cfinvoke>
    <cfset this.orderID = orderID>
    <!---Get the Customer's information.--->
    <cfinvoke 
    component="MCMS.component.app.customer.Customer"
    method="getCustomerAddress"
    returnvariable="getCustomerAddressRet">
    <cfinvokeargument name="cstID" value="#ARGUMENTS.cstID#"/>
    <cfinvokeargument name="cstatID" value="1"/>
    <cfinvokeargument name="cstaStatus" value="1"/>
    <cfinvokeargument name="orderBy" value="cstaSort"/>
    </cfinvoke>
    <cfset ARGUMENTS.orderEmail = session.cstUsername>
    <cfset ARGUMENTS.orderTelArea = getCustomerAddressRet.cstaTelArea>
    <cfset ARGUMENTS.orderTelPrefix = getCustomerAddressRet.cstaTelPrefix>
    <cfset ARGUMENTS.orderTelSuffix = getCustomerAddressRet.cstaTelSuffix>
    <!---Get Shipping Address based on Ship Method.--->
    <!---Record Customer to Site Rel. when smID = 100 (if applicable).--->
    <cfif ARGUMENTS.smID EQ 100>
    <cfinvoke 
    component="MCMS.component.app.site.Site"
    method="getSiteAddress"
    returnvariable="getSiteAddressRet">
    <cfinvokeargument name="siteNo" value="#ARGUMENTS.siteNo#"/>
    <cfinvokeargument name="stID" value="1"/>
    <cfinvokeargument name="saStatus" value="#Iif(url.mcmsPreview EQ true, DE('1,3'), DE('1'))#"/>
    </cfinvoke>
    <cfset ARGUMENTS.orderAddress = getSiteAddressRet.saAddress>
    <cfset ARGUMENTS.orderAddressExt = getSiteAddressRet.saAddressExt>
    <cfset ARGUMENTS.orderCity = getSiteAddressRet.saCity>
    <cfset ARGUMENTS.orderStateProv = getSiteAddressRet.saStateProv>
    <cfset ARGUMENTS.orderZipCode = getSiteAddressRet.saZipCode>
    <cfset ARGUMENTS.orderZipCodeExt = getSiteAddressRet.saZipCodeExt>
    <cfset ARGUMENTS.orderCountry = getSiteAddressRet.saCountry>
    <!---Since the Customer has chosen a Ship to Store, record this.--->
    <cfinvoke 
    component="MCMS.component.app.customer.Customer"
    method="insertCustomerSiteRel"
    returnvariable="getSiteAddressRet">
    <cfinvokeargument name="cstID" value="#ARGUMENTS.cstID#"/>
    <cfinvokeargument name="siteNo" value="#ARGUMENTS.siteNo#"/>
    <cfinvokeargument name="cstsrStatus" value="1"/>
    </cfinvoke>
    <!---Get Shipping Address based on Ship Method from Customer Shipping Address.--->
    <cfelse>
    <cfset ARGUMENTS.orderAddress = getCustomerAddressRet.cstaAddress>
    <cfset ARGUMENTS.orderAddressExt = getCustomerAddressRet.cstaAddressExt>
    <cfset ARGUMENTS.orderCity = getCustomerAddressRet.cstaCity>
    <cfset ARGUMENTS.orderStateProv = getCustomerAddressRet.cstaStateProv>
    <cfset ARGUMENTS.orderZipCode = getCustomerAddressRet.cstaZipCode>
    <cfset ARGUMENTS.orderZipCodeExt = getCustomerAddressRet.cstaZipCodeExt>
    <cfset ARGUMENTS.orderCountry = getCustomerAddressRet.cstaCountry>
    </cfif>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    INSERT INTO tbl_order (orderID,orderPO,cartID,cstID,cID,siteNo,orderAddress,orderAddressExt,orderCity,orderStateProv,orderZipCode,orderZipCodeExt,orderCountry,orderEmail,orderTelArea,orderTelPrefix,orderTelSuffix,orderComment,orderGiftMessage,orderGiftWrap,orderTax,orderShipping,orderTotal,smID,ssID,stID,ordertID,userID,orderStatus) VALUES
    (
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#this.orderID#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.orderPO#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.cartID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.cstID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#application.catalogID#">,  
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.siteNo#">,  
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.orderAddress#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.orderAddressExt#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.orderCity#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.orderStateProv#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.orderZipCode#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.orderZipCodeExt#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.orderCountry#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.orderEmail#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.orderTelArea#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.orderTelPrefix#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.orderTelSuffix#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.orderComment#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.orderGiftMessage#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.orderGiftWrap#">,
    <cfqueryparam cfsqltype="cf_sql_float" value="#ARGUMENTS.orderTax#">,
    <cfqueryparam cfsqltype="cf_sql_float" value="#ARGUMENTS.orderShipping#">,
    <cfqueryparam cfsqltype="cf_sql_float" value="#ARGUMENTS.orderTotal#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.smID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ssID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.stID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ordertID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.userID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="1">
    )
    </cfquery>
    </cftransaction>
    <!---Insert Order Lines.--->
    <cfloop index="i" from="1" to="#ListLen(ARGUMENTS.sIDList)#">
    <cfinvoke 
    component="MCMS.component.app.order.Order"
    method="insertOrderLine"
    returnvariable="insertOrderLineRet">
    <cfinvokeargument name="orderID" value="#this.orderID#"/>
    <cfinvokeargument name="cstID" value="#ARGUMENTS.cstID#"/>
    <cfinvokeargument name="pID" value="#ListGetAt(ARGUMENTS.pIDList, i)#"/>
    <cfinvokeargument name="sID" value="#ListGetAt(ARGUMENTS.sIDList, i)#"/>
    <cfinvokeargument name="orderlQuantity" value="#ListGetAt(ARGUMENTS.skuQuantityList, i)#"/>
    <cfinvokeargument name="orderlPrice" value="#Evaluate(ListGetAt(ARGUMENTS.skuPriceList, i)/ListGetAt(ARGUMENTS.skuQuantityList, i))#"/>
    <cfinvokeargument name="orderlTotal" value="#ListGetAt(ARGUMENTS.skuPriceList, i)#"/>
    <cfinvokeargument name="cstaStatus" value="1"/>
    </cfinvoke>
    <!---Update Quantity on Hand.--->
    <cfinvoke 
    component="MCMS.component.app.sku.Sku"
    method="updateSkuQOH"
    returnvariable="updateSkuQOHRet">
    <cfinvokeargument name="ID" value="#ListGetAt(ARGUMENTS.sIDList, i)#"/>
    <cfinvokeargument name="skuQOH" value="#ListGetAt(ARGUMENTS.skuQuantityList, i)#"/>
    </cfinvoke>
    </cfloop>
    <!---Insert Order Transactions.--->
    <!---LOGIC STILL REQUIRED.--->
    
    <!---Send email confirmation to the customer.--->
    <!---Get the oID--->
    <cfinvoke 
    component="MCMS.component.cms.Cms"
    method="getMaxValueSQL"
    returnvariable="oID">
    <cfinvokeargument name="tableName" value="tbl_order"/>
    </cfinvoke>
    <cfset this.oID = oID>
    <cfinvoke 
    component="MCMS.component.utility.Email"
    method="sendEmail">
    <cfinvokeargument name="subject" value="#application.catalogName# Order"/>
    <cfinvokeargument name="to" value="#session.cstUsername#"/>
    <cfinvokeargument name="from" value="#application.orderEmail#"/>
    <cfinvokeargument name="emailTemplate" value="/checkout/view/inc_checkout_order_email.cfm"/>
    <cfinvokeargument name="ID" value="#this.oID#"/>
    <cfinvokeargument name="type" value="default"/>
    </cfinvoke>
    <!---Send email confirmation to the fulfiller.--->
    <cfinvoke 
    component="MCMS.component.utility.Email"
    method="sendEmail">
    <cfinvokeargument name="subject" value="#application.catalogName# Order"/>
    <cfinvokeargument name="to" value="#application.orderEmail#"/>
    <cfinvokeargument name="from" value="#session.cstUsername#"/>
    <cfinvokeargument name="emailTemplate" value="/checkout/view/inc_checkout_order_email.cfm"/>
    <cfinvokeargument name="ID" value="#this.oID#"/>
    <cfinvokeargument name="type" value="admin"/>
    </cfinvoke>
    <!---Clear out the cart.--->
    <cfinvoke 
    component="cfc.cart"
    method="emptyCart">
    </cfinvoke>
    <cflocation url="?mcmsID=checkout_confirmation&orderID=#this.oID#" addtoken="no"/>
    </cfif>
    <cfcatch type="any">
    <cfset result.message = "There was an error inserting the record.">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="insertOrderLine" access="public" returntype="struct">
    <cfargument name="orderID" type="string" required="yes" default="">
    <cfargument name="cstID" type="numeric" required="yes" default="0">
    <cfargument name="pID" type="numeric" required="yes" default="0">
    <cfargument name="sID" type="numeric" required="yes" default="0">
    <cfargument name="orderlQuantity" type="numeric" required="yes" default="0">
    <cfargument name="orderlPrice" type="string" required="yes" default="0.00">
    <cfargument name="orderlTotal" type="string" required="yes" default="0.00">
    <cfargument name="orderlComment" type="string" required="yes" default="">
    <cfargument name="orderlsID" type="numeric" required="yes" default="1">
    <cfargument name="userID" type="numeric" required="yes" default="0">
    <cfset result.message = "You have successfully inserted the record.">
    <cftry>
    <!---Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.app.order.Order"
    method="getOrderLine"
    returnvariable="getCheckOrderLineRet">
    <cfinvokeargument name="orderID" value="#ARGUMENTS.orderID#"/>
    <cfinvokeargument name="pID" value="#ARGUMENTS.pID#"/>
    <cfinvokeargument name="sID" value="#ARGUMENTS.sID#"/>
    <cfinvokeargument name="orderlStatus" value="1,2,3"/>
    </cfinvoke>
    <!---If the line already exists, delete it and recreate it..--->
    <cfif getCheckOrderLineRet.recordcount NEQ 0>
    <cfinvoke 
    component="MCMS.component.app.order.Order"
    method="deleteOrderLine">
    <cfinvokeargument name="ID" value="#getCheckOrderLineRet.ID#"/>
    </cfinvoke>
	</cfif>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    INSERT INTO tbl_order_line (orderID,cstID,pID,sID,orderlQuantity,orderlPrice,orderlTotal,orderlComment,orderlsID,userID,orderlStatus) VALUES
    (
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.orderID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.cstID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.pID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.sID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.orderlQuantity#">,
    <cfqueryparam cfsqltype="cf_sql_float" value="#ARGUMENTS.orderlPrice#">,
    <cfqueryparam cfsqltype="cf_sql_float" value="#ARGUMENTS.orderlTotal#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.orderlComment#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.orderlsID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.userID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="1">
    )
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error inserting the record.">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="updateOrderShippingInformation" access="public" returntype="struct">
    <cfargument name="ID" type="numeric" required="yes">
    <cfargument name="orderAddress" type="string" required="yes">
    <cfargument name="orderCity" type="string" required="yes">
    <cfargument name="orderStateProv" type="string" required="yes">
    <cfargument name="orderZipCode" type="string" required="yes">
    <cfargument name="orderZipCodeExt" type="string" required="yes" default="">
    <cfset result.message = "You have successfully updated the record.">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_order SET
    orderAddress = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.orderAddress#">,
    orderCity = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.orderCity#">,
    orderStateProv = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.orderStateProv#">,
    orderZipCode = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.orderZipCode#">,
    orderZipCodeExt = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.orderZipCodeExt#">
    WHERE ID = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.ID#">
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error updating the record.">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="updateOrderContactInformation" access="public" returntype="struct">
    <cfargument name="ID" type="numeric" required="yes">
    <cfargument name="orderEmail" type="string" required="yes">
    <cfargument name="orderTelArea" type="string" required="yes" default="">
    <cfargument name="orderTelPrefix" type="string" required="yes">
    <cfargument name="orderTelSuffix" type="string" required="yes">
    <cfset result.message = "You have successfully updated the record.">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_order SET
    orderEmail = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.orderEmail#">,
    orderTelArea = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.orderTelArea#">,
    orderTelPrefix = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.orderTelPrefix#">,
    orderTelSuffix = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.orderTelSuffix#">
    WHERE ID = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.ID#">
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error updating the record.">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="updateOrderShipStatus" access="public" returntype="struct">
    <cfargument name="ID" type="numeric" required="yes">
    <cfargument name="orderPO" type="numeric" required="yes" default="0">
    <cfargument name="ssID" type="numeric" required="yes">
    <cfset result.message = "You have successfully updated the record.">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_order SET
    <cfif ARGUMENTS.orderPO NEQ 0>
    orderPO = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.orderPO#">,
    </cfif>
    ssID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ssID#">,
    userID = <cfqueryparam cfsqltype="cf_sql_integer" value="#session.userID#">,
    orderDateProcess = <cfqueryparam cfsqltype="cf_sql_date" value="#Now()#">,
    orderDateHistory = <cfqueryparam cfsqltype="cf_sql_date" value="#Now()#">
    WHERE ID = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.ID#">
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error updating the record.">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="updateOrderList" access="public" returntype="struct">
    <cfargument name="ID" type="numeric" required="yes">
    <cfargument name="orderStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully updated the records.">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_order SET
    orderStatus = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.orderStatus#">
    WHERE ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ID#">
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error updating the records.">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="deleteOrder" access="public" returntype="struct">
    <cfargument name="ID" type="string" required="yes">
    <cfset result.message = "You have successfully deleted the record(s).">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    DELETE FROM tbl_order
    WHERE ID IN (<cfqueryparam cfsqltype="cf_sql_integer" list="yes" value="#ARGUMENTS.ID#">)
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error deleting the record(s).">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction> 
      
    <cffunction name="deleteOrderLine" access="public" returntype="struct">
    <cfargument name="ID" type="string" required="yes">
    <cfset result.message = "You have successfully deleted the record(s).">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    DELETE FROM tbl_order_line
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