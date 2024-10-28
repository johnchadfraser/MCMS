<cfcomponent>
    <cffunction name="getProduct" access="public" returntype="query" hint="Get Product data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="ID" type="string" required="yes" default="0">
    <cfargument name="productID" type="string" required="yes" default="">
    <cfargument name="excludeID" type="string" required="yes" default="0">
    <cfargument name="pName" type="string" required="yes" default="">
    <cfargument name="ptID" type="string" required="yes" default="0">
    <cfargument name="pStatus" type="string" required="yes" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="pName">
    <cfset var rsProduct = "" >
    <cftry>
    <cfquery name="rsProduct" datasource="#application.mcmsDSN#">
    SELECT * FROM v_product WHERE 0=0
    <cfif ARGUMENTS.ID NEQ 0>
    AND ID IN (<cfqueryparam value="#ARGUMENTS.ID#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    <cfif ARGUMENTS.productID NEQ ''>
    AND productID IN (<cfqueryparam value="#ARGUMENTS.productID#" list="yes" cfsqltype="cf_sql_varchar">)
    </cfif>
    <cfif ARGUMENTS.excludeID NEQ 0>
    AND ID NOT IN (<cfqueryparam value="#ARGUMENTS.excludeID#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(pName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(pDescription) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(productID) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">)
    </cfif>
    <cfif ARGUMENTS.pName NEQ "">
    AND UPPER(pName) = <cfqueryparam value="#UCASE(ARGUMENTS.pName)#" cfsqltype="cf_sql_varchar">
    </cfif>
    <cfif ARGUMENTS.ptID NEQ 0>
    AND ptID = <cfqueryparam value="#ARGUMENTS.ptID#" cfsqltype="cf_sql_integer">
    </cfif>
    AND pStatus IN (<cfqueryparam value="#ARGUMENTS.pStatus#" list="yes" cfsqltype="cf_sql_integer">)
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsProduct = StructNew()>
    <cfset rsProduct.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsProduct>
    </cffunction>
    
    <cffunction name="getProductNameBind" access="remote" returntype="string" output="yes">
    <cfargument name="keywords" type="string" required="yes" default="">
    <cfargument name="deptNo" type="string" required="yes" default="0">
    <cfargument name="dsn" type="string" required="yes" default="swweb">
    <cfargument name="pStatus" type="string" required="yes" default="0">
    <cfargument name="orderBy" type="string" required="yes" default="pName">
    <cfset var rsBind = "" >
    <cfquery name="rsBind" datasource="#ARGUMENTS.dsn#">
    SELECT DISTINCT pName FROM v_product_department_rel WHERE 0=0
    AND UPPER(pName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">
    <cfif ARGUMENTS.deptNo NEQ 0>
    AND deptNo IN (<cfqueryparam value="#ARGUMENTS.deptNo#" list="yes" separator="|" cfsqltype="cf_sql_integer">)
    </cfif>
    <cfif ARGUMENTS.pStatus NEQ 0>
    AND pStatus IN (<cfqueryparam value="#ARGUMENTS.pStatus#" list="yes" separator="|" cfsqltype="cf_sql_integer">)
    </cfif>
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <cfif rsBind.recordcount NEQ 0>
    <cfset IDList = ValueList(rsBind.pName, ',') & ",none">
    <cfelse>
    <cfset IDList = ''>
    </cfif>
    <cfreturn IDList>
    </cffunction>
    
    <cffunction name="getProductAttributeValueBind" access="remote" returntype="string" output="yes">
    <cfargument name="keywords" type="string" required="yes" default="">
    <cfargument name="paID" type="string" required="yes" default="0">
    <cfargument name="dsn" type="string" required="yes" default="swweb">
    <cfargument name="pavStatus" type="string" required="yes" default="1">
    <cfargument name="orderBy" type="string" required="yes" default="pavValue">
    <cfset var rsBind = "" >
    <cfquery name="rsBind" datasource="#ARGUMENTS.dsn#">
    SELECT DISTINCT pavValue FROM v_product_attribute_value WHERE 0=0
    AND (UPPER(pavValue) LIKE <cfqueryparam value="#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> AND pavValue NOT LIKE <cfqueryparam value="#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">)
    <cfif ARGUMENTS.paID NEQ 0>
    AND paID = <cfqueryparam value="#ARGUMENTS.paID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.pavStatus NEQ 0>
    AND pavStatus = <cfqueryparam value="#ARGUMENTS.pavStatus#" cfsqltype="cf_sql_integer">
    </cfif>
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <cfif rsBind.recordcount NEQ 0>
    <cfset IDList = ValueList(rsBind.pavValue, ',') & ",none">
    <cfelse>
    <cfset IDList = ''>
    </cfif>
    <cfreturn IDList>
    </cffunction>
    
    <cffunction name="getProductDetail" access="public" returntype="query" hint="Get Product Detail data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="ID" type="numeric" required="yes" default="0">
    <cfargument name="excludeID" type="numeric" required="yes" default="0">
    <cfargument name="pdName" type="string" required="yes" default="">
    <cfargument name="pID" type="numeric" required="yes" default="0">
    <cfargument name="pdDateRel" type="string" required="yes" default="">
    <cfargument name="pdDateExp" type="string" required="yes" default="">
    <cfargument name="pdtID" type="numeric" required="yes" default="0">
    <cfargument name="pdStatus" type="string" required="yes" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="pdName">
    <cfset var rsProductDetail = "" >
    <cftry>
    <cfquery name="rsProductDetail" datasource="#application.mcmsDSN#">
    SELECT * FROM v_product_detail WHERE 0=0
    <cfif ARGUMENTS.ID NEQ 0>
    AND ID = <cfqueryparam value="#ARGUMENTS.ID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.excludeID NEQ 0>
    AND ID <> <cfqueryparam value="#ARGUMENTS.excludeID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(pdName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(pdDescription) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(pID) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">)
    </cfif>
    <cfif ARGUMENTS.pdName NEQ "">
    AND UPPER(pdName) = <cfqueryparam value="#UCASE(ARGUMENTS.pdName)#" cfsqltype="cf_sql_varchar">
    </cfif>
    <cfif ARGUMENTS.pID NEQ 0>
    AND pID = <cfqueryparam value="#ARGUMENTS.pID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.pdtID NEQ 0>
    AND pdtID = <cfqueryparam value="#ARGUMENTS.pdtID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.pdDateRel NEQ "">
    AND pdDateRel <= <cfqueryparam value="#DateFormat(ARGUMENTS.pdDateRel, application.dateFormat)#" cfsqltype="cf_sql_date"> 
    </cfif>
    <cfif ARGUMENTS.pdDateExp NEQ "">
    AND pdDateExp >= <cfqueryparam value="#DateFormat(ARGUMENTS.pdDateExp, application.dateFormat)#" cfsqltype="cf_sql_date">
    </cfif>
    AND pdStatus IN (<cfqueryparam value="#ARGUMENTS.pdStatus#" list="yes" cfsqltype="cf_sql_integer">)
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsProductDetail = StructNew()>
    <cfset rsProductDetail.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsProductDetail>
    </cffunction>
    
    <cffunction name="getProductDocumentRel" access="public" returntype="query" hint="Get Product Document Rel. data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="ID" type="numeric" required="yes" default="0">
    <cfargument name="excludeID" type="numeric" required="yes" default="0">
    <cfargument name="docName" type="string" required="yes" default="">
    <cfargument name="pID" type="numeric" required="yes" default="0">
    <cfargument name="docID" type="numeric" required="yes" default="0">
    <cfargument name="docDateRel" type="string" required="yes" default="">
    <cfargument name="docDateExp" type="string" required="yes" default="">
    <cfargument name="doctID" type="string" required="yes" default="0">
    <cfargument name="pdrStatus" type="string" required="yes" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="docName">
    <cfset var rsProductDocumentRel = "" >
    <cftry>
    <cfquery name="rsProductDocumentRel" datasource="#application.mcmsDSN#">
    SELECT * FROM v_product_document_rel WHERE 0=0
    <cfif ARGUMENTS.ID NEQ 0>
    AND ID = <cfqueryparam value="#ARGUMENTS.ID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.excludeID NEQ 0>
    AND ID <> <cfqueryparam value="#ARGUMENTS.excludeID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(docName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(docDescription) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(pID) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">)
    </cfif>
    <cfif ARGUMENTS.docName NEQ "">
    AND UPPER(docName) = <cfqueryparam value="#UCASE(ARGUMENTS.docName)#" cfsqltype="cf_sql_varchar">
    </cfif>
    <cfif ARGUMENTS.pID NEQ 0>
    AND pID = <cfqueryparam value="#ARGUMENTS.pID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.docID NEQ 0>
    AND docID = <cfqueryparam value="#ARGUMENTS.docID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.doctID NEQ 0>
    AND doctID IN (<cfqueryparam value="#ARGUMENTS.doctID#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    <cfif ARGUMENTS.docDateRel NEQ "">
    AND docDateRel <= <cfqueryparam value="#DateFormat(ARGUMENTS.docDateRel, application.dateFormat)#" cfsqltype="cf_sql_date"> 
    </cfif>
    <cfif ARGUMENTS.docDateExp NEQ "">
    AND docDateExp >= <cfqueryparam value="#DateFormat(ARGUMENTS.docDateExp, application.dateFormat)#" cfsqltype="cf_sql_date">
    </cfif>
    AND pdrStatus IN (<cfqueryparam value="#ARGUMENTS.pdrStatus#" list="yes" cfsqltype="cf_sql_integer">)
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsProductDocumentRel = StructNew()>
    <cfset rsProductDocumentRel.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsProductDocumentRel>
    </cffunction>
    
    <cffunction name="getProductAdItemRel" access="public" returntype="query" hint="Get Product Ad Item Rel. data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="ID" type="numeric" required="yes" default="0">
    <cfargument name="excludeID" type="numeric" required="yes" default="0">
    <cfargument name="ainName" type="string" required="yes" default="">
    <cfargument name="pName" type="string" required="yes" default="">
    <cfargument name="pID" type="numeric" required="yes" default="0">
    <cfargument name="ainID" type="numeric" required="yes" default="0">
    <cfargument name="userID" type="numeric" required="yes" default="0">
    <cfargument name="pDateRel" type="string" required="yes" default="">
    <cfargument name="pDateExp" type="string" required="yes" default="">
    <cfargument name="ainDateStart" type="string" required="yes" default="">
    <cfargument name="ainDateEnd" type="string" required="yes" default="">
    <cfargument name="pairStatus" type="string" required="yes" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="ainDateStart DESC, ainName">
    <cfset var rsProductAdItemRel = "">
    <cftry>
    <cfquery name="rsProductAdItemRel" datasource="#application.mcmsDSN#">
    SELECT * FROM v_product_ad_item_rel WHERE 0=0
    <cfif ARGUMENTS.ID NEQ 0>
    AND ID = <cfqueryparam value="#ARGUMENTS.ID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.excludeID NEQ 0>
    AND ID <> <cfqueryparam value="#ARGUMENTS.excludeID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(ainName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(pName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(pID) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">)
    </cfif>
    <cfif ARGUMENTS.pName NEQ "">
    AND UPPER(pName) = <cfqueryparam value="#UCASE(ARGUMENTS.pName)#" cfsqltype="cf_sql_varchar">
    </cfif>
    <cfif ARGUMENTS.ainName NEQ "">
    AND UPPER(ainName) = <cfqueryparam value="#UCASE(ARGUMENTS.ainName)#" cfsqltype="cf_sql_varchar">
    </cfif>
    <cfif ARGUMENTS.pID NEQ 0>
    AND pID = <cfqueryparam value="#ARGUMENTS.pID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.userID NEQ 0>
    AND userID = <cfqueryparam value="#ARGUMENTS.userID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.ainID NEQ 0>
    AND ainID = <cfqueryparam value="#ARGUMENTS.ainID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.pDateRel NEQ "">
    AND pDateRel <= <cfqueryparam value="#DateFormat(ARGUMENTS.pDateRel, application.dateFormat)#" cfsqltype="cf_sql_date"> 
    </cfif>
    <cfif ARGUMENTS.pDateExp NEQ "">
    AND pDateExp >= <cfqueryparam value="#DateFormat(ARGUMENTS.pDateExp, application.dateFormat)#" cfsqltype="cf_sql_date">
    </cfif>
    <cfif ARGUMENTS.ainDateStart NEQ "">
    AND ainDateStart <= <cfqueryparam value="#DateFormat(ARGUMENTS.ainDateStart, application.dateFormat)#" cfsqltype="cf_sql_date"> 
    </cfif>
    <cfif ARGUMENTS.ainDateEnd NEQ "">
    AND ainDateEnd >= <cfqueryparam value="#DateFormat(ARGUMENTS.ainDateEnd, application.dateFormat)#" cfsqltype="cf_sql_date">
    </cfif>
    AND pairStatus IN (<cfqueryparam value="#ARGUMENTS.pairStatus#" list="yes" cfsqltype="cf_sql_integer">)
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsProductAdItemRel = StructNew()>
    <cfset rsProductAdItemRel.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsProductAdItemRel>
    </cffunction>
    
    <cffunction name="setProductID" access="public" returntype="string" hint="Set Product ID based on ID.">
    <cfset var productID = "" >
    <cftry>
    <!---Get the next product ID.--->
    <cfinvoke 
    component="MCMS.component.cms.Cms"
    method="getMaxValueSQL"
    returnvariable="pID">
    <cfinvokeargument name="tableName" value="tbl_product"/>
    </cfinvoke>
    <cfif pID NEQ ''>
    <cfset productID = application.productIDSeedPrefix & (application.productIDSeedNumber + pID + 1)>
    <cfelse>
    <cfset productID = application.productIDSeedPrefix & (application.productIDSeedNumber + 100 + 1)>
    </cfif>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset productID = StructNew()>
    <cfset productID.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn productID>
    </cffunction>
    
    <cffunction name="getProductDetailType" access="public" returntype="query" hint="Get Product Detail Type data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="ID" type="numeric" required="yes" default="0">
    <cfargument name="excludeID" type="numeric" required="yes" default="0">
    <cfargument name="pdtName" type="string" required="yes" default="">
    <cfargument name="pdtStatus" type="string" required="yes" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="pdtName">
    <cfset var rsProductDetailType = "" >
    <cftry>
    <cfquery name="rsProductDetailType" datasource="#application.mcmsDSN#" cachedWithin="#request.queryCache#">
    SELECT * FROM v_product_detail_type WHERE 0=0
    <cfif ARGUMENTS.ID NEQ 0>
    AND ID = <cfqueryparam value="#ARGUMENTS.ID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.excludeID NEQ 0>
    AND ID <> <cfqueryparam value="#ARGUMENTS.excludeID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(pdtName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(pdtDescription) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">)
    </cfif>
    <cfif ARGUMENTS.pdtName NEQ "">
    AND UPPER(pdtName) = <cfqueryparam value="#UCASE(ARGUMENTS.pdtName)#" cfsqltype="cf_sql_varchar">
    </cfif>
    AND pdtStatus IN (<cfqueryparam value="#ARGUMENTS.pdtStatus#" list="yes" cfsqltype="cf_sql_integer">)
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsProductDetailType = StructNew()>
    <cfset rsProductDetailType.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsProductDetailType>
    </cffunction>
    
    <cffunction name="getProductAttribute" access="public" returntype="query" hint="Get Product Attribute data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="ID" type="string" required="yes" default="">
    <cfargument name="excludeID" type="string" required="yes" default="0">
    <cfargument name="paName" type="string" required="yes" default="">
    <cfargument name="patID" type="numeric" required="yes" default="0">
    <cfargument name="paStatus" type="string" required="yes" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="paSort, paName">
    <cfset var rsProductAttribute = "" >
    <cftry>
    <cfquery name="rsProductAttribute" datasource="#application.mcmsDSN#">
    SELECT * FROM v_product_attribute WHERE 0=0
    <cfif ARGUMENTS.ID NEQ ''>
    AND ID IN (<cfqueryparam value="#ARGUMENTS.ID#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    <cfif ARGUMENTS.excludeID NEQ 0>
    AND ID NOT IN (<cfqueryparam value="#ARGUMENTS.excludeID#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(paName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(paDescription) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">)
    </cfif>
    <cfif ARGUMENTS.paName NEQ ''>
    AND paName = <cfqueryparam value="#ARGUMENTS.paName#" cfsqltype="cf_sql_varchar">
    </cfif>
    <cfif ARGUMENTS.patID NEQ 0>
    AND patID = <cfqueryparam value="#ARGUMENTS.patID#" cfsqltype="cf_sql_integer">
    </cfif>
    AND paStatus IN (<cfqueryparam value="#ARGUMENTS.paStatus#" list="yes" cfsqltype="cf_sql_integer">)
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsProductAttribute = StructNew()>
    <cfset rsProductAttribute.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsProductAttribute>
    </cffunction>
    
    <cffunction name="getProductAttributeValue" access="public" returntype="query" hint="Get Product Attribute Value data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="ID" type="numeric" required="yes" default="0">
    <cfargument name="excludeID" type="numeric" required="yes" default="0">
    <cfargument name="pavValue" type="string" required="yes" default="">
    <cfargument name="paID" type="numeric" required="yes" default="0">
    <cfargument name="pavStatus" type="string" required="yes" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="pavSort, paName">
    <cfset var rsProductAttributeValue = "" >
    <cftry>
    <cfquery name="rsProductAttributeValue" datasource="#application.mcmsDSN#">
    SELECT * FROM v_product_attribute_value WHERE 0=0
    <cfif ARGUMENTS.ID NEQ 0>
    AND ID = <cfqueryparam value="#ARGUMENTS.ID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.excludeID NEQ 0>
    AND ID <> <cfqueryparam value="#ARGUMENTS.excludeID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(paName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(pavValue) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">)
    </cfif>
    <cfif ARGUMENTS.pavValue NEQ ''>
    AND pavValue = <cfqueryparam value="#ARGUMENTS.pavValue#" cfsqltype="cf_sql_varchar">
    </cfif>
    <cfif ARGUMENTS.paID NEQ 0>
    AND paID = <cfqueryparam value="#ARGUMENTS.paID#" cfsqltype="cf_sql_integer">
    </cfif>
    AND pavStatus IN (<cfqueryparam value="#ARGUMENTS.pavStatus#" list="yes" cfsqltype="cf_sql_integer">)
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsProductAttributeValue = StructNew()>
    <cfset rsProductAttributeValue.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsProductAttributeValue>
    </cffunction>
    
    <cffunction name="getProductAttributeType" access="public" returntype="query" hint="Get Product Attribute Type data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="ID" type="numeric" required="yes" default="0">
    <cfargument name="excludeID" type="numeric" required="yes" default="0">
    <cfargument name="patName" type="string" required="yes" default="">
    <cfargument name="patStatus" type="string" required="yes" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="patName">
    <cfset var rsProductAttributeType = "" >
    <cftry>
    <cfquery name="rsProductAttributeType" datasource="#application.mcmsDSN#" cachedWithin="#request.queryCache#">
    SELECT * FROM v_product_attribute_type WHERE 0=0
    <cfif ARGUMENTS.ID NEQ 0>
    AND ID = <cfqueryparam value="#ARGUMENTS.ID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.excludeID NEQ 0>
    AND ID <> <cfqueryparam value="#ARGUMENTS.excludeID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND UPPER(patName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">
    </cfif>
    <cfif ARGUMENTS.patName NEQ "">
    AND UPPER(patName) = <cfqueryparam value="#UCASE(ARGUMENTS.patName)#" cfsqltype="cf_sql_varchar">
    </cfif>
    AND patStatus IN (<cfqueryparam value="#ARGUMENTS.patStatus#" list="yes" cfsqltype="cf_sql_integer">)
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsProductAttributeType = StructNew()>
    <cfset rsProductAttributeType.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsProductAttributeType>
    </cffunction>
    
    <cffunction name="getProductAttributeRel" access="public" returntype="query" hint="Get Product Attribute Rel. data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="ID" type="numeric" required="yes" default="0">
    <cfargument name="excludeID" type="numeric" required="yes" default="0">
    <cfargument name="pID" type="string" required="yes" default="0">
    <cfargument name="paID" type="string" required="yes" default="0">
    <cfargument name="paStatus" type="string" required="yes" default="1,3">
    <cfargument name="parStatus" type="string" required="yes" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="paID,pName">
    <cfset var rsProductAttributeRel = "" >
    <cftry>
    <cfquery name="rsProductAttributeRel" datasource="#application.mcmsDSN#">
    SELECT * FROM v_product_attribute_rel WHERE 0=0
    <cfif ARGUMENTS.ID NEQ 0>
    AND ID = <cfqueryparam value="#ARGUMENTS.ID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.excludeID NEQ 0>
    AND ID <> <cfqueryparam value="#ARGUMENTS.excludeID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(pName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(paName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">)
    </cfif>
    <cfif ARGUMENTS.pID NEQ 0>
    AND pID IN (<cfqueryparam value="#ARGUMENTS.pID#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    <cfif ARGUMENTS.paID NEQ 0>
    AND paID IN (<cfqueryparam value="#ARGUMENTS.paID#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    AND paStatus IN (<cfqueryparam value="#ARGUMENTS.paStatus#" list="yes" cfsqltype="cf_sql_integer">)
    AND parStatus IN (<cfqueryparam value="#ARGUMENTS.parStatus#" list="yes" cfsqltype="cf_sql_integer">)
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsProductAttributeRel = StructNew()>
    <cfset rsProductAttributeRel.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsProductAttributeRel>
    </cffunction>
    
    <cffunction name="getProductAttributeDepartmentRel" access="public" returntype="query" hint="Get Product Attribute Department Rel. data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="ID" type="numeric" required="yes" default="0">
    <cfargument name="excludeID" type="numeric" required="yes" default="0">
    <cfargument name="cID" type="string" required="yes" default="0">
    <cfargument name="paID" type="string" required="yes" default="0">
    <cfargument name="deptNo" type="string" required="yes" default="">
    <cfargument name="padrStatus" type="string" required="yes" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="paName">
    <cfset var rsProductAttributeDepartmentRel = "" >
    <cftry>
    <cfquery name="rsProductAttributeDepartmentRel" datasource="#application.mcmsDSN#">
    SELECT * FROM v_product_attribute_dept_rel WHERE 0=0
    <cfif ARGUMENTS.ID NEQ 0>
    AND ID = <cfqueryparam value="#ARGUMENTS.ID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.excludeID NEQ 0>
    AND ID <> <cfqueryparam value="#ARGUMENTS.excludeID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(paName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(deptName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">)
    </cfif>
    <cfif ARGUMENTS.cID NEQ 0>
    AND cID IN (<cfqueryparam value="#ARGUMENTS.cID#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    <cfif ARGUMENTS.paID NEQ 0>
    AND paID IN (<cfqueryparam value="#ARGUMENTS.paID#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    <cfif ARGUMENTS.deptNo NEQ ''>
    AND deptNo IN (<cfqueryparam value="#ARGUMENTS.deptNo#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    AND padrStatus IN (<cfqueryparam value="#ARGUMENTS.padrStatus#" list="yes" cfsqltype="cf_sql_integer">)
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsProductAttributeDepartmentRel = StructNew()>
    <cfset rsProductAttributeDepartmentRel.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsProductAttributeDepartmentRel>
    </cffunction>
    
    <cffunction name="getProductAttributeUOMRel" access="public" returntype="query" hint="Get Product Attribute UOM Rel. data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="ID" type="numeric" required="yes" default="0">
    <cfargument name="excludeID" type="numeric" required="yes" default="0">
    <cfargument name="paID" type="string" required="yes" default="">
    <cfargument name="uomID" type="string" required="yes" default="">
    <cfargument name="pauomrStatus" type="string" required="yes" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="paName">
    <cfset var rsProductAttributeUOMRel = "" >
    <cftry>
    <cfquery name="rsProductAttributeUOMRel" datasource="#application.mcmsDSN#">
    SELECT * FROM v_product_attribute_uom_rel WHERE 0=0
    <cfif ARGUMENTS.ID NEQ 0>
    AND ID = <cfqueryparam value="#ARGUMENTS.ID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.excludeID NEQ 0>
    AND ID <> <cfqueryparam value="#ARGUMENTS.excludeID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(paName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(uomName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">)
    </cfif>
    <cfif ARGUMENTS.paID NEQ ''>
    AND paID IN (<cfqueryparam value="#ARGUMENTS.paID#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    <cfif ARGUMENTS.uomID NEQ ''>
    AND uomID IN (<cfqueryparam value="#ARGUMENTS.uomID#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    AND pauomrStatus IN (<cfqueryparam value="#ARGUMENTS.pauomrStatus#" list="yes" cfsqltype="cf_sql_integer">)
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsProductAttributeUOMRel = StructNew()>
    <cfset rsProductAttributeUOMRel.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsProductAttributeUOMRel>
    </cffunction>
    
    <cffunction name="getProductAttrSeparatorRel" access="public" returntype="query" hint="Get Product Attribute Separator Rel. data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="ID" type="numeric" required="yes" default="0">
    <cfargument name="excludeID" type="numeric" required="yes" default="0">
    <cfargument name="paID" type="string" required="yes" default="">
    <cfargument name="sepID" type="string" required="yes" default="">
    <cfargument name="paseprStatus" type="string" required="yes" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="paName">
    <cfset var rsProductAttrSeparatorRel = "" >
    <cftry>
    <cfquery name="rsProductAttrSeparatorRel" datasource="#application.mcmsDSN#">
    SELECT * FROM v_product_attr_separator_rel WHERE 0=0
    <cfif ARGUMENTS.ID NEQ 0>
    AND ID = <cfqueryparam value="#ARGUMENTS.ID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.excludeID NEQ 0>
    AND ID <> <cfqueryparam value="#ARGUMENTS.excludeID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(paName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(sepName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">)
    </cfif>
    <cfif ARGUMENTS.paID NEQ ''>
    AND paID IN (<cfqueryparam value="#ARGUMENTS.paID#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    <cfif ARGUMENTS.sepID NEQ ''>
    AND sepID IN (<cfqueryparam value="#ARGUMENTS.sepID#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    AND paseprStatus IN (<cfqueryparam value="#ARGUMENTS.paseprStatus#" list="yes" cfsqltype="cf_sql_integer">)
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsProductAttrSeparatorRel = StructNew()>
    <cfset rsProductAttrSeparatorRel.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsProductAttrSeparatorRel>
    </cffunction>
    
    <cffunction name="getProductAttributeExtDepartmentRel" access="public" returntype="query" hint="Get Product Attribute Ext. Department Rel. data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="ID" type="numeric" required="yes" default="0">
    <cfargument name="excludeID" type="numeric" required="yes" default="0">
    <cfargument name="cID" type="string" required="yes" default="0">
    <cfargument name="paeID" type="string" required="yes" default="0">
    <cfargument name="deptNo" type="string" required="yes" default="">
    <cfargument name="paedrStatus" type="string" required="yes" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="deptNo,paeName">
    <cfset var rsProductAttributeExtDepartmentRel = "" >
    <cftry>
    <cfquery name="rsProductAttributeExtDepartmentRel" datasource="#application.mcmsDSN#">
    SELECT * FROM v_product_attr_ext_dept_rel WHERE 0=0
    <cfif ARGUMENTS.ID NEQ 0>
    AND ID = <cfqueryparam value="#ARGUMENTS.ID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.excludeID NEQ 0>
    AND ID <> <cfqueryparam value="#ARGUMENTS.excludeID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(paeName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(deptName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">)
    </cfif>
    <cfif ARGUMENTS.cID NEQ 0>
    AND cID IN (<cfqueryparam value="#ARGUMENTS.cID#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    <cfif ARGUMENTS.paeID NEQ 0>
    AND paeID IN (<cfqueryparam value="#ARGUMENTS.paeID#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    <cfif ARGUMENTS.deptNo NEQ ''>
    AND deptNo IN (<cfqueryparam value="#ARGUMENTS.deptNo#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    AND paedrStatus IN (<cfqueryparam value="#ARGUMENTS.paedrStatus#" list="yes" cfsqltype="cf_sql_integer">)
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsProductAttributeExtDepartmentRel = StructNew()>
    <cfset rsProductAttributeExtDepartmentRel.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsProductAttributeExtDepartmentRel>
    </cffunction>
    
    <cffunction name="getDistinctProductAttributeExtDepartmentRel" access="public" returntype="query" hint="Get Distinct Product Attribute Ext. Department Rel. data.">
    <cfargument name="excludePAEID" type="string" required="yes" default="0">
    <cfargument name="cID" type="string" required="yes" default="0">
    <cfargument name="paeID" type="string" required="yes" default="0">
    <cfargument name="deptNo" type="string" required="yes" default="">
    <cfargument name="paedrStatus" type="string" required="yes" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="paeSort, paeName, paeDescription, paetID, paeRequired, paeDefaultValue, paeID">
    <cfset var rsDistinctProductAttributeExtDepartmentRel = "" >
    <cftry>
    <cfquery name="rsDistinctProductAttributeExtDepartmentRel" datasource="#application.mcmsDSN#" cachedWithin="#request.queryCache#">
    SELECT paeSort, paeName, paeDescription, paetID, paeRequired, paeDefaultValue, paeID FROM v_product_attr_ext_dept_rel WHERE 0=0
    <cfif ARGUMENTS.excludePAEID NEQ 0>
    AND paeID NOT IN (<cfqueryparam value="#ARGUMENTS.excludePAEID#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    <cfif ARGUMENTS.cID NEQ 0>
    AND cID IN (<cfqueryparam value="#ARGUMENTS.cID#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    <cfif ARGUMENTS.paeID NEQ 0>
    AND paeID IN (<cfqueryparam value="#ARGUMENTS.paeID#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    <cfif ARGUMENTS.deptNo NEQ ''>
    AND deptNo IN (<cfqueryparam value="#ARGUMENTS.deptNo#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    AND paeStatus IN (<cfqueryparam value="1" list="yes" cfsqltype="cf_sql_integer">)
    AND paedrStatus IN (<cfqueryparam value="#ARGUMENTS.paedrStatus#" list="yes" cfsqltype="cf_sql_integer">)
    GROUP BY #ARGUMENTS.orderBy#
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsProductDistinctAttributeExtDepartmentRel = StructNew()>
    <cfset rsProductDistinctAttributeExtDepartmentRel.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsDistinctProductAttributeExtDepartmentRel>
    </cffunction>
    
    <cffunction name="getProductAttributeExt" access="public" returntype="query" hint="Get Product Attribute Ext. data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="ID" type="string" required="yes" default="0">
    <cfargument name="excludeID" type="string" required="yes" default="0">
    <cfargument name="paeName" type="string" required="yes" default="">
    <cfargument name="paetID" type="numeric" required="yes" default="0">
    <cfargument name="paeStatus" type="string" required="yes" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="paeSort, paeName">
    <cfset var rsProductAttributeExt = "" >
    <cftry>
    <cfquery name="rsProductAttributeExt" datasource="#application.mcmsDSN#" cachedWithin="#request.queryCache#">
    SELECT * FROM v_product_attribute_ext WHERE 0=0
    <cfif ARGUMENTS.ID NEQ 0>
    AND ID IN (<cfqueryparam value="#ARGUMENTS.ID#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    <cfif ARGUMENTS.excludeID NEQ 0>
    AND ID NOT IN (<cfqueryparam value="#ARGUMENTS.excludeID#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(paeName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(paeDescription) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">)
    </cfif>
    <cfif ARGUMENTS.paeName NEQ ''>
    AND paeName = <cfqueryparam value="#ARGUMENTS.paeName#" cfsqltype="cf_sql_varchar">
    </cfif>
    <cfif ARGUMENTS.paetID NEQ 0>
    AND paetID = <cfqueryparam value="#ARGUMENTS.paetID#" cfsqltype="cf_sql_integer">
    </cfif>
    AND paeStatus IN (<cfqueryparam value="#ARGUMENTS.paeStatus#" list="yes" cfsqltype="cf_sql_integer">)
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsProductAttributeExt = StructNew()>
    <cfset rsProductAttributeExt.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsProductAttributeExt>
    </cffunction>
    
    <cffunction name="getProductAttributeExtType" access="public" returntype="query" hint="Get Product Attribute Ext. Type data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="ID" type="numeric" required="yes" default="0">
    <cfargument name="excludeID" type="numeric" required="yes" default="0">
    <cfargument name="paetName" type="string" required="yes" default="">
    <cfargument name="paetStatus" type="string" required="yes" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="paetName">
    <cfset var rsProductAttributeExtType = "" >
    <cftry>
    <cfquery name="rsProductAttributeExtType" datasource="#application.mcmsDSN#" cachedWithin="#request.queryCache#">
    SELECT * FROM v_product_attribute_ext_type WHERE 0=0
    <cfif ARGUMENTS.ID NEQ 0>
    AND ID = <cfqueryparam value="#ARGUMENTS.ID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.excludeID NEQ 0>
    AND ID <> <cfqueryparam value="#ARGUMENTS.excludeID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(paetName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(paetDescription) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">)
    </cfif>
    <cfif ARGUMENTS.paetName NEQ "">
    AND UPPER(paetName) = <cfqueryparam value="#UCASE(ARGUMENTS.paetName)#" cfsqltype="cf_sql_varchar">
    </cfif>
    AND paetStatus IN (<cfqueryparam value="#ARGUMENTS.paetStatus#" list="yes" cfsqltype="cf_sql_integer">)
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsProductAttributeExtType = StructNew()>
    <cfset rsProductAttributeExtType.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsProductAttributeExtType>
    </cffunction>
    
    <cffunction name="getProductAttributeExtRel" access="public" returntype="query" hint="Get Product Attribute Ext. Rel. data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="ID" type="numeric" required="yes" default="0">
    <cfargument name="excludeID" type="numeric" required="yes" default="0">
    <cfargument name="pID" type="string" required="yes" default="0">
    <cfargument name="paeNameAlt" type="string" required="yes" default="">
    <cfargument name="paeID" type="string" required="yes" default="0">
    <cfargument name="paerStatus" type="string" required="yes" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="pName">
    <cfset var rsProductAttributeExtRel = "" >
    <cftry>
    <cfquery name="rsProductAttributeExtRel" datasource="#application.mcmsDSN#">
    SELECT * FROM v_product_attribute_ext_rel WHERE 0=0
    <cfif ARGUMENTS.ID NEQ 0>
    AND ID = <cfqueryparam value="#ARGUMENTS.ID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.excludeID NEQ 0>
    AND ID <> <cfqueryparam value="#ARGUMENTS.excludeID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(pName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(paeName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">)
    </cfif>
    <cfif ARGUMENTS.pID NEQ 0>
    AND pID IN (<cfqueryparam value="#ARGUMENTS.pID#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    <cfif ARGUMENTS.paeNameAlt NEQ ''>
    AND paeNameAlt = <cfqueryparam value="#ARGUMENTS.paeNameAlt#" cfsqltype="cf_sql_varchar">
    </cfif>
    <cfif ARGUMENTS.paeID NEQ 0>
    AND paeID IN (<cfqueryparam value="#ARGUMENTS.paeID#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    AND paerStatus IN (<cfqueryparam value="#ARGUMENTS.paerStatus#" list="yes" cfsqltype="cf_sql_integer">)
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsProductAttributeExtRel = StructNew()>
    <cfset rsProductAttributeExtRel.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsProductAttributeExtRel>
    </cffunction>
    
    <cffunction name="getDistinctProductAttributeExtRel" access="public" returntype="query" hint="Get Distinct Product Attribute Ext. Rel. data.">
    <cfargument name="paeID" type="string" required="yes" default="0">
    <cfargument name="pID" type="string" required="yes" default="0">
    <cfargument name="paerValue" type="string" required="yes" default="">
    <cfargument name="paerStatus" type="string" required="yes" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="pID">
    <cfset var rsDistinctProductAttributeExtRel = "" >
    <cftry>
    <cfquery name="rsDistinctProductAttributeExtRel" datasource="#application.mcmsDSN#">
    SELECT DISTINCT pID FROM v_product_attribute_ext_rel WHERE 0=0
    <cfif ARGUMENTS.paeID NEQ 0>
    AND paeID IN (<cfqueryparam value="#ARGUMENTS.paeID#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    <cfif ARGUMENTS.pID NEQ 0>
    AND pID = <cfqueryparam value="#ARGUMENTS.pID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.paerValue NEQ ''>
    AND paerValue IN (<cfqueryparam value="#ARGUMENTS.paerValue#" list="yes" cfsqltype="cf_sql_varchar">)
    </cfif>
    AND paerStatus IN (<cfqueryparam value="#ARGUMENTS.paerStatus#" list="yes" cfsqltype="cf_sql_integer">)
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsDistinctProductAttributeExtRel = StructNew()>
    <cfset rsDistinctProductAttributeExtRel.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsDistinctProductAttributeExtRel>
    </cffunction>
    
    <cffunction name="getProductSkuAttributeRel" access="public" returntype="query" hint="Get Product Sku Attribute Rel. data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="ID" type="numeric" required="yes" default="0">
    <cfargument name="excludeID" type="numeric" required="yes" default="0">
    <cfargument name="excludeIDList" type="string" required="yes" default="0">
    <cfargument name="excludepaIDList" type="string" required="yes" default="0">
    <cfargument name="excludepavValue" type="string" required="yes" default="x">
    <cfargument name="pID" type="string" required="yes" default="0">
    <cfargument name="sID" type="string" required="yes" default="0">
    <cfargument name="paID" type="string" required="yes" default="0">
    <cfargument name="pavID" type="string" required="yes" default="0">
    <cfargument name="psaraltValue" type="string" required="yes" default="">
    <cfargument name="paIDList" type="string" required="yes" default="0">
    <cfargument name="pavIDList" type="string" required="yes" default="0">
    <cfargument name="psaraltValueList" type="string" required="yes" default="">
    <cfargument name="pavValue" type="string" required="yes" default="xxxxxxx">
    <cfargument name="paStatus" type="string" required="yes" default="1,3">
    <cfargument name="psarStatus" type="string" required="yes" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="pName">
    <cfset var rsProductSkuAttributeRel = "" >
    <cftry>
    <cfquery name="rsProductSkuAttributeRel" datasource="#application.mcmsDSN#">
    SELECT * FROM v_product_sku_attribute_rel WHERE 0=0
    <cfif ARGUMENTS.ID NEQ 0>
    AND ID = <cfqueryparam value="#ARGUMENTS.ID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.excludeID NEQ 0>
    AND ID <> <cfqueryparam value="#ARGUMENTS.excludeID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.excludeIDList NEQ 0>
    AND ID NOT IN (<cfqueryparam value="#ARGUMENTS.excludeIDList#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    <cfif ARGUMENTS.excludepaIDList NEQ 0>
    AND paID NOT IN (<cfqueryparam value="#ARGUMENTS.excludepaIDList#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    <cfif ARGUMENTS.excludepavValue NEQ 'x'>
    AND pavValue NOT IN (<cfqueryparam value="#ARGUMENTS.excludepavValue#" list="yes" cfsqltype="cf_sql_varchar">)
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
    <cfif ARGUMENTS.paID NEQ 0>
    AND paID IN (<cfqueryparam value="#ARGUMENTS.paID#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    <cfif ARGUMENTS.pavID NEQ 0>
    AND pavID IN (<cfqueryparam value="#ARGUMENTS.pavID#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    <cfif ARGUMENTS.psaraltValue NEQ ''>
    AND psaraltValue IN (<cfqueryparam value="#ARGUMENTS.psaraltValue#" list="yes" cfsqltype="cf_sql_varchar">)
    </cfif>
    <cfif ARGUMENTS.paIDList NEQ 0>
    AND paID IN (<cfqueryparam value="#ARGUMENTS.paIDList#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    <cfif ARGUMENTS.pavIDList NEQ 0>
    AND pavID IN (<cfqueryparam value="#ARGUMENTS.pavIDList#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    <cfif ARGUMENTS.psaraltValueList NEQ ''>
    AND psaraltValue IN (<cfqueryparam value="#ARGUMENTS.psaraltValueList#" list="yes" cfsqltype="cf_sql_varchar">)
    </cfif>
    <cfif ARGUMENTS.pavValue NEQ 'xxxxxxx'>
    AND pavValue IN (<cfqueryparam value="#ARGUMENTS.pavValue#" list="yes" cfsqltype="cf_sql_varchar">)
    </cfif>
    AND paStatus IN (<cfqueryparam value="#ARGUMENTS.paStatus#" list="yes" cfsqltype="cf_sql_integer">)
    AND psarStatus IN (<cfqueryparam value="#ARGUMENTS.psarStatus#" list="yes" cfsqltype="cf_sql_integer">)
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsProductSkuAttributeRel = StructNew()>
    <cfset rsProductSkuAttributeRel.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsProductSkuAttributeRel>
    </cffunction>
    
    <cffunction name="getProductSkuAttributeRelDuplicate" access="public" returntype="query" hint="Check for Duplicate Product Sku Attribute Rel. data.">
    <cfargument name="pID" type="string" required="yes" default="0">
    <cfargument name="sID" type="string" required="yes" default="0">
    <cfargument name="skuID" type="string" required="yes" default="">
    <cfargument name="excludesID" type="string" required="yes" default="0">
    <cfargument name="paIDList" type="string" required="yes" default="0">
    <cfargument name="pavIDList" type="string" required="yes" default="0">
    <cfargument name="psaraltValueList" type="string" required="yes" default="">
    <cfargument name="paCount" type="numeric" required="yes" default="0">
    <cfargument name="psarStatus" type="string" required="yes" default="1,3">
    <cfset var rsProductSkuAttributeRelDuplicate = "" >
    <cfset whereClause = ''>
    <cftry>
    <cfif ARGUMENTS.paIDList EQ 0>
    <cfquery name="rsProductSkuAttributeRelDuplicate" datasource="#application.mcmsDSN#">
    SELECT * FROM DUAL
    </cfquery>
    <cfelse>
    <cfif ARGUMENTS.paCount EQ 1>
    <cfset whereClause = 'Q1.sID=Q1.sID'>
    <cfelse>
    <cfloop index="i" from="1" to="#ARGUMENTS.paCount-1#"> 
    <cfset whereClause = whereClause & Iif(whereClause NEQ '', DE(' AND '), DE('')) & 'Q' & i & '.sID=' & 'Q' & i+1 & '.sID'>
    </cfloop>
    </cfif>
    <cfquery name="rsProductSkuAttributeRelDuplicate" datasource="#application.mcmsDSN#">
    SELECT * FROM
    <cfloop index="i" from="1" to="#ARGUMENTS.paCount#">
    (
    SELECT pID, paID, pavID, sID, skuID from V_PRODUCT_SKU_ATTRIBUTE_REL
    WHERE 0=0
    <cfif ARGUMENTS.pID NEQ 0>
    AND pID IN (<cfqueryparam value="#ARGUMENTS.pID#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    <cfif ARGUMENTS.excludesID NEQ 0>
    AND sID NOT IN (<cfqueryparam value="#ARGUMENTS.excludesID#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    <cfif ARGUMENTS.skuID NEQ ''>
    AND skuID IN (<cfqueryparam value="#ARGUMENTS.skuID#" list="yes" cfsqltype="cf_sql_varchar">)
    </cfif>
    <cfif ARGUMENTS.paIDList NEQ 0>
    AND paID = <cfqueryparam value="#ListGetAt(ARGUMENTS.paIDList, i)#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.pavIDList NEQ 0>
    AND pavID = <cfqueryparam value="#ListGetAt(ARGUMENTS.pavIDList, i)#" cfsqltype="cf_sql_integer">
    </cfif> 
    <cfif ARGUMENTS.psaraltValueList NEQ ''>
    AND psaraltValue = <cfqueryparam value="#ListGetAt(ARGUMENTS.psaraltValueList, i)#" cfsqltype="cf_sql_varchar">
    </cfif> 
    ) Q#i#
    <cfif i LT ARGUMENTS.paCount>
    ,
    </cfif>
	</cfloop>
    WHERE
    #whereClause#
    </cfquery>
    </cfif>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsProductSkuAttributeRelDuplicate = StructNew()>
    <cfset rsProductSkuAttributeRelDuplicate.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsProductSkuAttributeRelDuplicate>
    </cffunction>
    
    <cffunction name="getProductDepartmentRel" access="public" returntype="query" hint="Get Product Department Rel. data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="ID" type="string" required="yes" default="0">
    <cfargument name="excludeID" type="numeric" required="yes" default="0">
    <cfargument name="excludeUserID" type="numeric" required="yes" default="99">
    <cfargument name="cID" type="string" required="yes" default="0">
    <cfargument name="pID" type="string" required="yes" default="0">
    <cfargument name="ptID" type="numeric" required="yes" default="0">
    <cfargument name="vID" type="numeric" required="yes" default="0">
    <cfargument name="bID" type="numeric" required="yes" default="0">
    <cfargument name="ppID" type="numeric" required="yes" default="0">
    <cfargument name="pesID" type="string" required="yes" default="0">
    <cfargument name="deptNo" type="string" required="yes" default="0">
    <cfargument name="pStatus" type="string" required="yes" default="1,2,3">
    <cfargument name="pdrStatus" type="string" required="yes" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="pName">
    <cfset var rsProductDepartmentRel = "" >
    <cftry>
    <cfquery name="rsProductDepartmentRel" datasource="#application.mcmsDSN#">
    SELECT * FROM v_product_department_rel WHERE 0=0
    <cfif ARGUMENTS.ID NEQ 0>
    AND ID IN (<cfqueryparam value="#ARGUMENTS.ID#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    <cfif ARGUMENTS.excludeID NEQ 0>
    AND ID <> <cfqueryparam value="#ARGUMENTS.excludeID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.excludeUserID NEQ 99>
    AND userID <> <cfqueryparam value="#ARGUMENTS.excludeUserID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(pName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">
    OR UPPER(productID) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">
    OR UPPER(pSkuList) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">  
    OR UPPER(vName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">
    OR UPPER(bName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">
    OR UPPER(deptName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">
    )
    </cfif>
    <cfif ARGUMENTS.cID NEQ 0>
    AND cID IN (<cfqueryparam value="#ARGUMENTS.cID#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    <cfif ARGUMENTS.pID NEQ 0>
    AND pID IN (<cfqueryparam value="#ARGUMENTS.pID#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    <cfif ARGUMENTS.ptID NEQ 0>
    AND ptID = <cfqueryparam value="#ARGUMENTS.ptID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.vID NEQ 0>
    AND vID = <cfqueryparam value="#ARGUMENTS.vID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.bID NEQ 0>
    AND bID = <cfqueryparam value="#ARGUMENTS.bID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.ppID NEQ 0>
    AND ppID = <cfqueryparam value="#ARGUMENTS.ppID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.pesID NEQ 0>
    AND pesID IN (<cfqueryparam value="#ARGUMENTS.pesID#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    <cfif ARGUMENTS.deptNo NEQ 0>
    AND deptNo IN (<cfqueryparam value="#ARGUMENTS.deptNo#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    <cfif ARGUMENTS.pStatus NEQ 0>
    AND pStatus IN (<cfqueryparam value="#ARGUMENTS.pStatus#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    AND pdrStatus IN (<cfqueryparam value="#ARGUMENTS.pdrStatus#" list="yes" cfsqltype="cf_sql_integer">)
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsProductDepartmentRel = StructNew()>
    <cfset rsProductDepartmentRel.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsProductDepartmentRel>
    </cffunction>
    
    <cffunction name="getProductList" access="public" returntype="query" hint="Get Product List data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="cID" type="numeric" required="yes" default="0">
    <cfargument name="catID" type="numeric" required="yes" default="0">
    <cfargument name="scatID" type="numeric" required="yes" default="0">
    <cfargument name="lcatID" type="numeric" required="yes" default="0">
    <cfargument name="pID" type="string" required="yes" default="0">
    <cfset var rsProductList = "" >
    <cftry>
    <cfif ARGUMENTS.catID NEQ 0 AND ARGUMENTS.keywords EQ 'All'>
    <cfquery name="rsProductCategoryRel" datasource="#application.mcmsDSN#">
    SELECT DISTINCT pID FROM v_product_category_rel WHERE 0=0
    AND cID = <cfqueryparam value="#ARGUMENTS.cID#" cfsqltype="cf_sql_integer"> 
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(pName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> 
    OR UPPER(pKeyword) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> 
    OR UPPER(productID) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">
    OR UPPER(bName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">
    OR UPPER(vName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">
    OR UPPER(catName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">
    OR UPPER(catKeyword) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">
    )
    </cfif>
    <cfif ARGUMENTS.catID NEQ 0>
    AND catID = <cfqueryparam value="#ARGUMENTS.catID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.pID NEQ 0>
    AND pID IN (<cfqueryparam value="#ARGUMENTS.pID#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    AND cID = <cfqueryparam value="#application.catalogID#" cfsqltype="cf_sql_integer">
    AND pcrStatus = <cfqueryparam value="1" cfsqltype="cf_sql_integer">
    </cfquery>
    <cfif rsProductCategoryRel.recordcount EQ 0>
    <cfset ARGUMENTS.pID = 0>
    <cfelse>
    <cfset ARGUMENTS.pID = ValueList(rsProductCategoryRel.pID)>
    </cfif> 
    <cfelseif ARGUMENTS.scatID NEQ 0>
    <cfquery name="rsProductSecCategoryRel" datasource="#application.mcmsDSN#">
    SELECT DISTINCT pID FROM tbl_product_sec_category_rel WHERE 0=0
    AND scatID = <cfqueryparam value="#ARGUMENTS.scatID#" cfsqltype="cf_sql_integer">
    AND cID = <cfqueryparam value="#ARGUMENTS.cID#" cfsqltype="cf_sql_integer">
    <cfif ARGUMENTS.pID NEQ 0>
    AND pID IN (<cfqueryparam value="#ARGUMENTS.pID#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    AND pscrStatus = <cfqueryparam value="1" cfsqltype="cf_sql_integer">
    </cfquery>
    <cfset ARGUMENTS.pID = ValueList(rsProductSecCategoryRel.pID)>
    </cfif>
    <!---Get the products.--->
    <cfinvoke 
    component="MCMS.component.app.product.Product"
    method="getProductImageRel"
    returnvariable="rsProductList">
    <cfinvokeargument name="keywords" value="#ARGUMENTS.keywords#"/>
    <cfinvokeargument name="cID" value="#ARGUMENTS.cID#"/>
    <cfinvokeargument name="pID" value="#ARGUMENTS.pID#"/>
    <cfinvokeargument name="pDateRel" value="#Now()#"/>
    <cfinvokeargument name="pDateExp" value="#Now()#"/>
    <cfinvokeargument name="pStatus" value="1"/>
    <cfinvokeargument name="pirPrimaryImage" value="1"/>
    <cfinvokeargument name="pirStatus" value="1"/>
	</cfinvoke>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsProductList = StructNew()>
    <cfset rsProductList.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsProductList>
    </cffunction>
    
    <cffunction name="getProductTemplate" access="public" returntype="query" hint="Get Product Template data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="ID" type="numeric" required="yes" default="0">
    <cfargument name="excludeID" type="numeric" required="yes" default="0">
    <cfargument name="pTempName" type="string" required="yes" default="">
    <cfargument name="cID" type="string" required="yes" default="0">
    <cfargument name="ptCode" type="string" required="yes" default="">
    <cfargument name="pTempStatus" type="string" required="yes" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="pTempName">
    <cfset var rsProductTemplate = "" >
    <cftry>
    <cfquery name="rsProductTemplate" datasource="#application.mcmsDSN#" cachedWithin="#request.queryCache#">
    SELECT * FROM v_product_template WHERE 0=0
    <cfif ARGUMENTS.ID NEQ 0>
    AND ID = <cfqueryparam value="#ARGUMENTS.ID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.excludeID NEQ 0>
    AND ID <> <cfqueryparam value="#ARGUMENTS.excludeID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(pTempName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(pTempFile) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">)
    </cfif>
    <cfif ARGUMENTS.pTempName NEQ "">
    AND UPPER(pTempName) = <cfqueryparam value="#UCASE(ARGUMENTS.pTempName)#" cfsqltype="cf_sql_varchar">
    </cfif>
    <cfif ARGUMENTS.ptCode NEQ "">
    AND UPPER(ptCode) = <cfqueryparam value="#UCASE(ARGUMENTS.ptCode)#" cfsqltype="cf_sql_varchar">
    </cfif>
    <cfif ARGUMENTS.cID NEQ 0>
    AND cID IN (<cfqueryparam value="#ARGUMENTS.cID#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    AND pTempStatus IN (<cfqueryparam value="#ARGUMENTS.pTempStatus#" list="yes" cfsqltype="cf_sql_integer">)
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsProductTemplate = StructNew()>
    <cfset rsProductTemplate.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsProductTemplate>
    </cffunction>
    
    <cffunction name="getProductCategoryRel" access="public" returntype="query" hint="Get Product Category Rel. data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="ID" type="numeric" required="yes" default="0">
    <cfargument name="excludeID" type="numeric" required="yes" default="0">
    <cfargument name="pID" type="string" required="yes" default="0">
    <cfargument name="cID" type="string" required="yes" default="0">
    <cfargument name="catID" type="string" required="yes" default="0">
    <cfargument name="pcrStatus" type="string" required="yes" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="catSort,catName">
    <cfset var rsProductCategoryRel = "" >
    <cftry>
    <cfquery name="rsProductCategoryRel" datasource="#application.mcmsDSN#">
    SELECT * FROM v_product_category_rel WHERE 0=0
    <cfif ARGUMENTS.ID NEQ 0>
    AND ID = <cfqueryparam value="#ARGUMENTS.ID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.excludeID NEQ 0>
    AND ID <> <cfqueryparam value="#ARGUMENTS.excludeID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(pName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(catName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">)
    </cfif>
    <cfif ARGUMENTS.pID NEQ 0>
    AND pID IN (<cfqueryparam value="#ARGUMENTS.pID#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    <cfif ARGUMENTS.cID NEQ 0>
    AND cID IN (<cfqueryparam value="#ARGUMENTS.cID#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    <cfif ARGUMENTS.catID NEQ 0>
    AND catID IN (<cfqueryparam value="#ARGUMENTS.catID#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    AND pcrStatus IN (<cfqueryparam value="#ARGUMENTS.pcrStatus#" list="yes" cfsqltype="cf_sql_integer">)
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsProductCategoryRel = StructNew()>
    <cfset rsProductCategoryRel.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsProductCategoryRel>
    </cffunction>
    
    <cffunction name="getProductSecondaryCategoryRel" access="public" returntype="query" hint="Get Product Secondary Category Rel. data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="ID" type="numeric" required="yes" default="0">
    <cfargument name="excludeID" type="numeric" required="yes" default="0">
    <cfargument name="pID" type="string" required="yes" default="0">
    <cfargument name="cID" type="string" required="yes" default="0">
    <cfargument name="scatID" type="string" required="yes" default="0">
    <cfargument name="pscrStatus" type="string" required="yes" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="scatSort,scatName">
    <cfset var rsProductSecondaryCategoryRel = "" >
    <cftry>
    <cfquery name="rsProductSecondaryCategoryRel" datasource="#application.mcmsDSN#">
    SELECT * FROM v_product_sec_category_rel WHERE 0=0
    <cfif ARGUMENTS.ID NEQ 0>
    AND ID = <cfqueryparam value="#ARGUMENTS.ID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.excludeID NEQ 0>
    AND ID <> <cfqueryparam value="#ARGUMENTS.excludeID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(pName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(scatName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">)
    </cfif>
    <cfif ARGUMENTS.pID NEQ 0>
    AND pID IN (<cfqueryparam value="#ARGUMENTS.pID#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    <cfif ARGUMENTS.cID NEQ 0>
    AND cID IN (<cfqueryparam value="#ARGUMENTS.cID#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    <cfif ARGUMENTS.scatID NEQ 0>
    AND scatID IN (<cfqueryparam value="#ARGUMENTS.scatID#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    AND pscrStatus IN (<cfqueryparam value="#ARGUMENTS.pscrStatus#" list="yes" cfsqltype="cf_sql_integer">)
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsProductSecondaryCategoryRel = StructNew()>
    <cfset rsProductSecondaryCategoryRel.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsProductSecondaryCategoryRel>
    </cffunction>
    
    <cffunction name="getProductLineCategoryRel" access="public" returntype="query" hint="Get Product Line Category Rel. data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="ID" type="numeric" required="yes" default="0">
    <cfargument name="excludeID" type="numeric" required="yes" default="0">
    <cfargument name="pID" type="string" required="yes" default="0">
    <cfargument name="cID" type="string" required="yes" default="0">
    <cfargument name="lcatID" type="string" required="yes" default="0">
    <cfargument name="plcrStatus" type="string" required="yes" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="lcatSort,lcatName">
    <cfset var rsProductLineCategoryRel = "" >
    <cftry>
    <cfquery name="rsProductLineCategoryRel" datasource="#application.mcmsDSN#">
    SELECT * FROM v_product_line_category_rel WHERE 0=0
    <cfif ARGUMENTS.ID NEQ 0>
    AND ID = <cfqueryparam value="#ARGUMENTS.ID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.excludeID NEQ 0>
    AND ID <> <cfqueryparam value="#ARGUMENTS.excludeID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(pName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(lcatName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">)
    </cfif>
    <cfif ARGUMENTS.pID NEQ 0>
    AND pID IN (<cfqueryparam value="#ARGUMENTS.pID#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    <cfif ARGUMENTS.cID NEQ 0>
    AND cID IN (<cfqueryparam value="#ARGUMENTS.cID#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    <cfif ARGUMENTS.lcatID NEQ 0>
    AND lcatID IN (<cfqueryparam value="#ARGUMENTS.lcatID#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    AND plcrStatus IN (<cfqueryparam value="#ARGUMENTS.plcrStatus#" list="yes" cfsqltype="cf_sql_integer">)
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsProductLineCategoryRel = StructNew()>
    <cfset rsProductLineCategoryRel.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsProductLineCategoryRel>
    </cffunction>
    
    <cffunction name="getProductSecondaryLineCategoryRel" access="public" returntype="query" hint="Get Product Secondary Line Category Rel. data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="ID" type="numeric" required="yes" default="0">
    <cfargument name="excludeID" type="numeric" required="yes" default="0">
    <cfargument name="pID" type="string" required="yes" default="0">
    <cfargument name="cID" type="string" required="yes" default="0">
    <cfargument name="slcatID" type="string" required="yes" default="0">
    <cfargument name="pslcrStatus" type="string" required="yes" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="slcatSort,slcatName">
    <cfset var rsProductSecondaryLineCategoryRel = "" >
    <cftry>
    <cfquery name="rsProductSecondaryLineCategoryRel" datasource="#application.mcmsDSN#">
    SELECT * FROM v_product_sec_line_cat_rel WHERE 0=0
    <cfif ARGUMENTS.ID NEQ 0>
    AND ID = <cfqueryparam value="#ARGUMENTS.ID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.excludeID NEQ 0>
    AND ID <> <cfqueryparam value="#ARGUMENTS.excludeID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(pName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(slcatName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">)
    </cfif>
    <cfif ARGUMENTS.pID NEQ 0>
    AND pID IN (<cfqueryparam value="#ARGUMENTS.pID#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    <cfif ARGUMENTS.cID NEQ 0>
    AND cID IN (<cfqueryparam value="#ARGUMENTS.cID#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    <cfif ARGUMENTS.slcatID NEQ 0>
    AND slcatID IN (<cfqueryparam value="#ARGUMENTS.slcatID#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    AND pslcrStatus IN (<cfqueryparam value="#ARGUMENTS.pslcrStatus#" list="yes" cfsqltype="cf_sql_integer">)
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsProductSecondaryLineCategoryRel = StructNew()>
    <cfset rsProductSecondaryLineCategoryRel.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsProductSecondaryLineCategoryRel>
    </cffunction>
    
    <cffunction name="getProductImageRel" access="public" returntype="query" hint="Get Product Image Rel. data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="ID" type="numeric" required="yes" default="0">
    <cfargument name="excludeID" type="numeric" required="yes" default="0">
    <cfargument name="pID" type="string" required="yes" default="0">
    <cfargument name="imgID" type="string" required="yes" default="0">
    <cfargument name="pirPrimaryImage" type="numeric" required="yes" default="100">
    <cfargument name="pStatus" type="string" required="yes" default="1,3">
    <cfargument name="pirStatus" type="string" required="yes" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="pName">
    <cfset var rsProductImageRel = "" >
    <cftry>
    <cfquery name="rsProductImageRel" datasource="#application.mcmsDSN#">
    SELECT * FROM v_product_image_rel WHERE 0=0
    <cfif ARGUMENTS.ID NEQ 0>
    AND ID = <cfqueryparam value="#ARGUMENTS.ID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.excludeID NEQ 0>
    AND ID <> <cfqueryparam value="#ARGUMENTS.excludeID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(pName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(imgName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">)
    </cfif>
    <cfif ARGUMENTS.pID NEQ 0>
    AND pID IN (<cfqueryparam value="#ARGUMENTS.pID#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    <cfif ARGUMENTS.imgID NEQ 0>
    AND imgID IN (<cfqueryparam value="#ARGUMENTS.imgID#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    <cfif ARGUMENTS.pirPrimaryImage NEQ 100>
    AND pirPrimaryImage = <cfqueryparam value="#ARGUMENTS.pirPrimaryImage#" cfsqltype="cf_sql_integer">
    </cfif>
    AND pStatus IN (<cfqueryparam value="#ARGUMENTS.pStatus#" list="yes" cfsqltype="cf_sql_integer">)
    AND pirStatus IN (<cfqueryparam value="#ARGUMENTS.pirStatus#" list="yes" cfsqltype="cf_sql_integer">)
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsProductImageRel = StructNew()>
    <cfset rsProductImageRel.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsProductImageRel>
    </cffunction>
    
    <cffunction name="getProductImageRelLookup" access="public" returntype="query" hint="Get Product Image Rel. Lookup data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="pirStatus" type="string" required="yes" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="pName">
    <cfset var rsProductImageRel = "" >
    <cftry>
    <cfquery name="rsProductImageRel" datasource="#application.mcmsDSN#">
    SELECT imgID, imgName, imgtPath, imgFile, imgtWidthThumb, pName, imgName, pirPrimaryImage, imgDateUpdate, userFName, userLName FROM v_product_image_rel WHERE 0=0
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(pName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(imgName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">)
    </cfif>
    AND pirStatus IN (<cfqueryparam value="#ARGUMENTS.pirStatus#" list="yes" cfsqltype="cf_sql_integer">)
    AND rowNum <= 10
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsProductImageRel = StructNew()>
    <cfset rsProductImageRel.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsProductImageRel>
    </cffunction>
    
    <cffunction name="getProductDocumentRelLookup" access="public" returntype="query" hint="Get Product Document Rel. Lookup data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="pdrStatus" type="string" required="yes" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="pName">
    <cfset var rsProductDocumentRelLookup = "" >
    <cftry>
    <cfquery name="rsProductDocumentRelLookup" datasource="#application.mcmsDSN#">
    SELECT docID, docName, doctName, doctPath, docFile, pName, docDateExp, docDateUpdate, userFName, userLName FROM v_product_document_rel WHERE 0=0
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(pName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(docName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">)
    </cfif>
    AND pdrStatus IN (<cfqueryparam value="#ARGUMENTS.pdrStatus#" list="yes" cfsqltype="cf_sql_integer">)
    AND rowNum <= 10
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsProductDocumentRelLookup = StructNew()>
    <cfset rsProductDocumentRelLookup.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsProductDocumentRelLookup>
    </cffunction>
    
    <cffunction name="getProductRatingRel" access="public" returntype="query" hint="Get Product Rating Rel. data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="ID" type="numeric" required="yes" default="0">
    <cfargument name="excludeID" type="numeric" required="yes" default="0">
    <cfargument name="cstID" type="string" required="yes" default="0">
    <cfargument name="pID" type="string" required="yes" default="0">
    <cfargument name="prrName" type="string" required="yes" default="">
    <cfargument name="prrEmail" type="string" required="yes" default="">
    <cfargument name="prrStatus" type="string" required="yes" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="prrName">
    <cfset var rsProductRatingRel = "" >
    <cftry>
    <cfquery name="rsProductRatingRel" datasource="#application.mcmsDSN#">
    SELECT * FROM v_product_rating_rel WHERE 0=0
    <cfif ARGUMENTS.ID NEQ 0>
    AND ID = <cfqueryparam value="#ARGUMENTS.ID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.excludeID NEQ 0>
    AND ID <> <cfqueryparam value="#ARGUMENTS.excludeID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(prrName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(prrEmail) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">)
    </cfif>
    <cfif ARGUMENTS.cstID NEQ 0>
    AND cstID IN (<cfqueryparam value="#ARGUMENTS.cstID#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    <cfif ARGUMENTS.pID NEQ 0>
    AND pID IN (<cfqueryparam value="#ARGUMENTS.pID#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    <cfif ARGUMENTS.prrName NEQ ''>
    AND prrName = <cfqueryparam value="#ARGUMENTS.prrName#" cfsqltype="cf_sql_varchar">
    </cfif>
    <cfif ARGUMENTS.prrEmail NEQ ''>
    AND prrEmail = <cfqueryparam value="#ARGUMENTS.prrEmail#" cfsqltype="cf_sql_varchar">
    </cfif>
    AND prrStatus IN (<cfqueryparam value="#ARGUMENTS.prrStatus#" list="yes" cfsqltype="cf_sql_integer">)
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsProductRatingRel = StructNew()>
    <cfset rsProductRatingRel.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsProductRatingRel>
    </cffunction>
    
    <cffunction name="getProductShipType" access="public" returntype="query" hint="Get Product Ship Type data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="ID" type="numeric" required="yes" default="0">
    <cfargument name="excludeID" type="numeric" required="yes" default="0">
    <cfargument name="pstStatus" type="string" required="yes" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="pstName">
    <cfset var rsProductShipType = "" >
    <cftry>
    <cfquery name="rsProductShipType" datasource="#application.mcmsDSN#">
    SELECT * FROM tbl_product_ship_type WHERE 0=0
    <cfif ARGUMENTS.ID NEQ 0>
    AND ID = <cfqueryparam value="#ARGUMENTS.ID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.excludeID NEQ 0>
    AND ID <> <cfqueryparam value="#ARGUMENTS.excludeID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND UPPER(pstName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">
    </cfif>
    AND pstStatus IN (<cfqueryparam value="#ARGUMENTS.pstStatus#" list="yes" cfsqltype="cf_sql_integer">)
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsProductShipType = StructNew()>
    <cfset rsProductShipType.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsProductShipType>
    </cffunction>
    
    <cffunction name="getProductType" access="public" returntype="query" hint="Get Product Type data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="ID" type="numeric" required="yes" default="0">
    <cfargument name="excludeID" type="numeric" required="yes" default="0">
    <cfargument name="ptName" type="string" required="yes" default="">
    <cfargument name="ptStatus" type="string" required="yes" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="ptName">
    <cfset var rsProductType = "" >
    <cftry>
    <cfquery name="rsProductType" datasource="#application.mcmsDSN#">
    SELECT * FROM v_product_type WHERE 0=0
    <cfif ARGUMENTS.ID NEQ 0>
    AND ID = <cfqueryparam value="#ARGUMENTS.ID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.excludeID NEQ 0>
    AND ID <> <cfqueryparam value="#ARGUMENTS.excludeID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND UPPER(ptName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">
    </cfif>
    <cfif ARGUMENTS.ptName NEQ "">
    AND UPPER(ptName) = <cfqueryparam value="#UCASE(ARGUMENTS.ptName)#" cfsqltype="cf_sql_varchar">
    </cfif>
    AND ptStatus IN (<cfqueryparam value="#ARGUMENTS.ptStatus#" list="yes" cfsqltype="cf_sql_integer">)
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsProductType = StructNew()>
    <cfset rsProductType.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsProductType>
    </cffunction>
    
    <cffunction name="getProductExportStatus" access="public" returntype="query" hint="Get Product Export Status data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="ID" type="string" required="yes" default="0">
    <cfargument name="excludeID" type="numeric" required="yes" default="0">
    <cfargument name="pesName" type="string" required="yes" default="">
    <cfargument name="pesStatus" type="string" required="yes" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="pesName">
    <cfset var rsProductExportStatus = "" >
    <cftry>
    <cfquery name="rsProductExportStatus" datasource="#application.mcmsDSN#">
    SELECT * FROM v_product_export_status WHERE 0=0
    <cfif ARGUMENTS.ID NEQ 0>
    AND ID IN (<cfqueryparam value="#ARGUMENTS.ID#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    <cfif ARGUMENTS.excludeID NEQ 0>
    AND ID <> <cfqueryparam value="#ARGUMENTS.excludeID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND UPPER(pesName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">
    </cfif>
    <cfif ARGUMENTS.pesName NEQ "">
    AND UPPER(pesName) = <cfqueryparam value="#UCASE(ARGUMENTS.pesName)#" cfsqltype="cf_sql_varchar">
    </cfif>
    AND pesStatus IN (<cfqueryparam value="#ARGUMENTS.pesStatus#" list="yes" cfsqltype="cf_sql_integer">)
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsProductExportStatus = StructNew()>
    <cfset rsProductExportStatus.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsProductExportStatus>
    </cffunction>
    
    <cffunction name="getProductPriority" access="public" returntype="query" hint="Get Product Priority data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="ID" type="numeric" required="yes" default="0">
    <cfargument name="excludeID" type="numeric" required="yes" default="0">
    <cfargument name="ppName" type="string" required="yes" default="">
    <cfargument name="ppStatus" type="string" required="yes" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="ppName">
    <cfset var rsProductPriority = "" >
    <cftry>
    <cfquery name="rsProductPriority" datasource="#application.mcmsDSN#">
    SELECT * FROM v_product_priority WHERE 0=0
    <cfif ARGUMENTS.ID NEQ 0>
    AND ID = <cfqueryparam value="#ARGUMENTS.ID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.excludeID NEQ 0>
    AND ID <> <cfqueryparam value="#ARGUMENTS.excludeID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND UPPER(ppName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">
    </cfif>
    <cfif ARGUMENTS.ppName NEQ "">
    AND UPPER(ppName) = <cfqueryparam value="#UCASE(ARGUMENTS.ppName)#" cfsqltype="cf_sql_varchar">
    </cfif>
    AND ppStatus IN (<cfqueryparam value="#ARGUMENTS.ppStatus#" list="yes" cfsqltype="cf_sql_integer">)
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsProductPriority = StructNew()>
    <cfset rsProductPriority.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsProductPriority>
    </cffunction>
    
    <cffunction name="getProductHistory" access="public" returntype="query" hint="Get Product History data from cookie.">
    <cfset var result = "" >
    <cftry>
    <cfinvoke 
    component="MCMS.component.cms.Cookie"
    method="getCookie"
    returnvariable="productHistory">
    <cfinvokeargument name="name" value="productHistory"/>
    <cfinvokeargument name="domain" value="#CGI.SERVER_NAME#"/>
    <cfinvokeargument name="secure" value="no"/>
    </cfinvoke>
    <!---Filter the results.--->
    <cfquery name="productHistory" dbtype="query">
    SELECT * FROM productHistory WHERE 0=0 AND UPPER(name) LIKE <cfqueryparam value="%#UCASE('productHistory')#%" cfsqltype="cf_sql_varchar">
    </cfquery>
    <cfif productHistory.recordcount NEQ 0>
    <cfset pIDList = Replace(ValueList(productHistory.name), 'PRODUCTHISTORY.PID', '', 'ALL')>
    <cfset pURLList = ValueList(productHistory.value)>
    <cfelse>
    <cfset pIDList = 1>
    <cfset pURLList = ''>
    </cfif>
    <!---Create a new structure including the product information and url.--->
    <cfset result = QueryNew('rowid,pname,url', 'varchar,varchar,varchar')>
    <!---Now return the Product Information.--->
    <cfinvoke 
    component="MCMS.component.app.product.Product"
    method="getProduct"
    returnvariable="rsProduct">
    <cfinvokeargument name="productID" value="#pIDList#"/>
    <cfinvokeargument name="pStatus" value="1"/>
    </cfinvoke>
    <cfset productCount = rsProduct.recordcount>
    <cfloop index="i" from="1" to="#productCount#">
    <cfset temp = QueryAddRow(result)>
    <cfset temp = QuerySetCell(result, 'rowid', i, i)>
	<cfset temp = QuerySetCell(result, 'pname', rsProduct.pName, i)>
    <cfset temp = QuerySetCell(result, 'url', ListGetAt(pURLList, i))>
    </cfloop>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsProductHistory = StructNew()>
    <cfset rsProductHistory.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="getProductReport" access="public" returntype="query" hint="Get Product Report data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="deptNo" type="string" required="yes" default="0">
    <cfargument name="args" type="string" required="yes" default="">
    <cfargument name="orderBy" type="string" required="yes" default="pDateRel DESC">
    <cfset var rsProductReport = "" >
    <cftry>
    <cfquery name="rsProductReport" datasource="#application.mcmsDSN#">
    SELECT productID, pName AS Name, pPageTitle AS Page_Title, TO_CHAR(pDate, 'mm/dd/yyyy') AS Product_Date, TO_CHAR(pDateRel, 'mm/dd/yyyy') AS Date_Release, TO_CHAR(pDateUpdate, 'mm/dd/yyyy') AS Date_Updated, TO_CHAR(userFName || ' ' || userLName) AS Username, TO_CHAR(pDescription) AS Description, vName AS Vendor, bName AS Brand, pBulletPoint AS Bullet_Point, pKeyword AS Keywords, pMetaDescription AS Meta, pCSL AS CSL, pMPN AS MPN, pstName AS Ship_Type, ptName AS Type, pesName AS Export_Status, sName AS Status FROM v_product_department_rel WHERE 0=0
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(pName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(pDescription) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">)
    </cfif>
    <cfif ARGUMENTS.deptNo NEQ 0>
    AND deptNo IN (<cfqueryparam value="#ARGUMENTS.deptNo#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    <cfif ListGetAt(ARGUMENTS.args, 1) NEQ 0>
    AND cID IN (<cfqueryparam value="#ListGetAt(ARGUMENTS.args, 1)#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    <cfif ListGetAt(ARGUMENTS.args, 2) NEQ 0>
    AND pesID IN (<cfqueryparam value="#ListGetAt(ARGUMENTS.args, 2)#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    <cfif ListGetAt(ARGUMENTS.args, 3) NEQ 0>
    AND pStatus IN (<cfqueryparam value="#ListGetAt(ARGUMENTS.args, 3)#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsProductReport = StructNew()>
    <cfset rsProductReport.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsProductReport>
    </cffunction>
    
    <cffunction name="getProductDepartmentRelReport" access="public" returntype="query" hint="Get Product Department Relationship Report data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="deptNo" type="string" required="yes" default="0">
    <cfargument name="args" type="string" required="yes" default="">
    <cfargument name="orderBy" type="string" required="yes" default="pDateRel DESC, ainDateStart, ppID DESC, ainID, pesID">
    <cfset var rsProductDepartmentRelReport = "" >
    <cftry>
    <cfquery name="rsProductDepartmentRelReport" datasource="#application.mcmsDSN#">
    SELECT pName AS Name, productID AS Product_Id, ptName AS Product_Type, TO_CHAR(pDateUpdate,'MM/DD/YYYY') AS Date_Update, userFName || ' ' || userLName AS Product_User, pesName AS Export_Status, sName AS Status FROM v_product_department_rel WHERE 0=0
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(pName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">
    OR UPPER(productID) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">  
    OR UPPER(vName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">
    OR UPPER(bName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">
    OR UPPER(deptName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">
    )
    </cfif>
    <cfif ARGUMENTS.deptNo NEQ 0>
    AND deptNo IN (<cfqueryparam value="#ARGUMENTS.deptNo#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    <cfif ListGetAt(ARGUMENTS.args, 1) NEQ 0>
    AND cID IN (<cfqueryparam value="#ListGetAt(ARGUMENTS.args, 1)#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    <cfif ListGetAt(ARGUMENTS.args, 2) NEQ 0>
    AND ainID IN (<cfqueryparam value="#ListGetAt(ARGUMENTS.args, 2)#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    <cfif ListGetAt(ARGUMENTS.args, 3) NEQ 0>
    AND ppID IN (<cfqueryparam value="#ListGetAt(ARGUMENTS.args, 3)#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    <cfif ListGetAt(ARGUMENTS.args, 4) NEQ 0>
    AND ptID IN (<cfqueryparam value="#ListGetAt(ARGUMENTS.args, 4)#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    <cfif ListGetAt(ARGUMENTS.args, 5) NEQ 0>
    AND pesID IN (<cfqueryparam value="#ListGetAt(ARGUMENTS.args, 5)#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    <cfif ListGetAt(ARGUMENTS.args, 6) NEQ 0>
    AND pStatus IN (<cfqueryparam value="#ListGetAt(ARGUMENTS.args, 6)#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsProductDepartmentRelReport = StructNew()>
    <cfset rsProductDepartmentRelReport.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsProductDepartmentRelReport>
    </cffunction>
    
    <cffunction name="getProductAdItemRelReport" access="public" returntype="query" hint="Get Product Ad Item Relationship Report data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="siteNo" type="string" required="yes" default="100">
    <cfargument name="deptNo" type="string" required="yes" default="0">
    <cfargument name="args" type="string" required="yes" default="">
    <cfargument name="orderBy" type="string" required="yes" default="ainID DESC, pName">
    <cfset var rsProductAdItemRelReport = "" >
    <cftry>
    <cfquery name="rsProductAdItemRelReport" datasource="#application.mcmsDSN#">
    SELECT productID, pName AS Name, ainName AS Ad_Name, TO_CHAR(ainDateStart,'MM/DD/YYYY') AS Ad_Start_Date, TO_CHAR(ainDateEnd,'MM/DD/YYYY') AS Ad_End_Date, userFName || ' ' || userLName AS Username, vName AS Vendor, bName AS Brand, sName AS Status FROM v_product_ad_item_rel WHERE 0=0
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(pName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">
    OR UPPER(productID) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">  
    OR UPPER(vName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">
    OR UPPER(bName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">
    )
    </cfif>
    <cfif ListGetAt(ARGUMENTS.args, 1) NEQ 0>
    AND userID = <cfqueryparam value="#ListGetAt(ARGUMENTS.args, 1)#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ListGetAt(ARGUMENTS.args, 2) NEQ 0>
    AND ainID = <cfqueryparam value="#ListGetAt(ARGUMENTS.args, 2)#" cfsqltype="cf_sql_integer">
    </cfif>
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsProductAdItemRelReport = StructNew()>
    <cfset rsProductAdItemRelReport.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsProductAdItemRelReport>
    </cffunction>
    
    <cffunction name="getProductImageRelReport" access="public" returntype="query" hint="Get Product Image Rel. Report data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="orderBy" type="string" required="yes" default="pName">
    <cfset var rsProductImageReport = "" >
    <cftry>
    <cfquery name="rsProductImageReport" datasource="#application.mcmsDSN#">
    SELECT pName As Name, imgName As Image, sName As Status FROM v_product_image_rel WHERE 0=0
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(pName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(imgName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">)
    </cfif>
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsProductImageReport = StructNew()>
    <cfset rsProductImageReport.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsProductImageReport>
    </cffunction>
    
    <cffunction name="getProductAttributeReport" access="public" returntype="query" hint="Get Product Attribute Report data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="orderBy" type="string" required="yes" default="paName">
    <cfset var rsProductAttributeReport = "" >
    <cftry>
    <cfquery name="rsProductAttributeReport" datasource="#application.mcmsDSN#">
    SELECT paName AS Name, paNameAlt AS Name_Alt, paDescription AS Decription, paCode AS Code, paERPCode AS ERP_Code, paPOSCode AS POS_Code, TO_CHAR(paDate, 'mm/dd/yyyy') AS Attribute_Date, TO_CHAR(paDateUpdate, 'mm/dd/yyyy') AS Date_Update, TO_CHAR(userFName || ' ' || userLName) AS Username, DECODE(paRequired, 1, 'Yes', 'No') AS Required, paDefaultValue AS Default_Value, paRegEx AS RegEx, paRangeStart AS Range_Start, paRangeEnd AS Range_End, paComponent AS Component, paMethod AS Method, paArgumentList AS Arguments, patName AS Type, sortName AS Sort, sName AS Status FROM v_product_attribute WHERE 0=0
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(paName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(paDescription) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">)
    </cfif>
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsProductAttributeReport = StructNew()>
    <cfset rsProductAttributeReport.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsProductAttributeReport>
    </cffunction>
    
    <cffunction name="getProductAttributeExtReport" access="public" returntype="query" hint="Get Product Attribute Ext Report data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="orderBy" type="string" required="yes" default="paeName">
    <cfset var rsProductAttributeExtReport = "" >
    <cftry>
    <cfquery name="rsProductAttributeExtReport" datasource="#application.mcmsDSN#">
    SELECT paeName AS Name, paeNameAlt AS Name_Alt, paeDescription AS Decription, paeCode AS Ext_Code, paeERPCode AS ERP_Code, paePOSCode AS POS_Code, TO_CHAR(paeDate, 'mm/dd/yyyy') AS Ext_Date, TO_CHAR(paeDateUpdate, 'mm/dd/yyyy') AS Date_Update, TO_CHAR(userFName || ' ' || userLName) AS Username, DECODE(paeRequired, 1, 'Yes', 'No') AS Required, paeDefaultValue AS Default_Value, paeRegEx AS RegEx, paetName AS Type, sortName AS Sort, sName AS Status FROM v_product_attribute_ext WHERE 0=0
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(paeName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(paeDescription) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">)
    </cfif>
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsProductAttributeExtReport = StructNew()>
    <cfset rsProductAttributeExtReport.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsProductAttributeExtReport>
    </cffunction>
    
    <cffunction name="getProductAttributeExtRelReport" access="public" returntype="query" hint="Get Product Attribute Ext Rel. Report data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="orderBy" type="string" required="yes" default="pName">
    <cfset var rsProductAttributeExtRelReport = "" >
    <cftry>
    <cfquery name="rsProductAttributeExtRelReport" datasource="#application.mcmsDSN#">
    SELECT pName AS Product, paeName AS Ext_Name, paerValue AS Value, sName AS Status FROM v_product_attribute_ext_rel WHERE 0=0
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(pName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(paeName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">)
    </cfif>
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsProductAttributeExtRelReport = StructNew()>
    <cfset rsProductAttributeExtRelReport.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsProductAttributeExtRelReport>
    </cffunction>
    
    <cffunction name="getProductAttributeExtTypeReport" access="public" returntype="query" hint="Get Product Attribute Ext Type Report data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="orderBy" type="string" required="yes" default="paetName">
    <cfset var rsProductAttributeExtTypeReport = "" >
    <cftry>
    <cfquery name="rsProductAttributeExtTypeReport" datasource="#application.mcmsDSN#">
    SELECT paetName AS Name, paetDescription AS Description, sortName AS Sort, sName AS Status FROM v_product_attribute_ext_type WHERE 0=0
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND UPPER(paetName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">
    </cfif>
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsProductAttributeExtTypeReport = StructNew()>
    <cfset rsProductAttributeExtTypeReport.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsProductAttributeExtTypeReport>
    </cffunction>
    
    <cffunction name="getProductAttributeRelReport" access="public" returntype="query" hint="Get Product Attribute Rel. Report data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="orderBy" type="string" required="yes" default="pName">
    <cfset var rsProductAttributeRelReport = "" >
    <cftry>
    <cfquery name="rsProductAttributeRelReport" datasource="#application.mcmsDSN#">
    SELECT pName AS Product, paName AS Attribute_Name, sName AS Status FROM v_product_attribute_rel WHERE 0=0
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(pName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(paName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">)
    </cfif>
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsProductAttributeRelReport = StructNew()>
    <cfset rsProductAttributeRelReport.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsProductAttributeRelReport>
    </cffunction>
    
    <cffunction name="getProductAttributeTypeReport" access="public" returntype="query" hint="Get Product Attribute Type Report data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="orderBy" type="string" required="yes" default="patName">
    <cfset var rsProductAttributeTypeReport = "" >
    <cftry>
    <cfquery name="rsProductAttributeTypeReport" datasource="#application.mcmsDSN#">
    SELECT patName AS Name, patDescription AS Description, sortName AS Sort, sName AS Status FROM v_product_attribute_type WHERE 0=0
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND UPPER(patName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">
    </cfif>
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsProductAttributeTypeReport = StructNew()>
    <cfset rsProductAttributeTypeReport.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsProductAttributeTypeReport>
    </cffunction>
    
    <cffunction name="getProductAttributeValueReport" access="public" returntype="query" hint="Get Product Attribute Value Report data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="orderBy" type="string" required="yes" default="paName">
    <cfset var rsProductAttributeValueReport = "" >
    <cftry>
    <cfquery name="rsProductAttributeValueReport" datasource="#application.mcmsDSN#">
    SELECT paName AS Name, pavValue AS Value, pavCode AS Code, pavERPCode AS ERP_Code, pavPOSCode AS POS_Code, TO_CHAR(pavDate, 'mm/dd/yyyy') AS Value_Date, TO_CHAR(pavDateUpdate, 'mm/dd/yyyy') AS Date_Update, TO_CHAR(userFName || ' ' || userLName) AS Username, imgFile AS Image, sortName AS Sort, sName AS Status FROM v_product_attribute_value WHERE 0=0
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(paName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(pavValue) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">)
    </cfif>
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsProductAttributeValueReport = StructNew()>
    <cfset rsProductAttributeValueReport.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsProductAttributeValueReport>
    </cffunction>
    
    <cffunction name="getProductShipTypeReport" access="public" returntype="query" hint="Get Product Ship Type Report data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="orderBy" type="string" required="yes" default="pstName">
    <cfset var rsProductShipTypeReport = "" >
    <cftry>
    <cfquery name="rsProductShipTypeReport" datasource="#application.mcmsDSN#">
    SELECT smName AS Ship_Method, smCode AS Code, pstName AS Name, sortName AS Sort, sName AS Status  FROM v_product_ship_type WHERE 0=0
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND UPPER(pstName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">
    </cfif>
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsProductShipTypeReport = StructNew()>
    <cfset rsProductShipTypeReport.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsProductShipTypeReport>
    </cffunction>
    
    <cffunction name="getProductTypeReport" access="public" returntype="query" hint="Get Product Type Report data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="orderBy" type="string" required="yes" default="ptName">
    <cfset var rsProductTypeReport = "" >
    <cftry>
    <cfquery name="rsProductTypeReport" datasource="#application.mcmsDSN#">
    SELECT ptName AS Name, sortName AS Sort, sName AS Status  FROM v_product_type WHERE 0=0
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND UPPER(ptName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">
    </cfif>
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsProductTypeReport = StructNew()>
    <cfset rsProductTypeReport.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsProductTypeReport>
    </cffunction>
    
    <cffunction name="getProductRatingRelReport" access="public" returntype="query" hint="Get Product Rating Rel. Report data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="orderBy" type="string" required="yes" default="pName">
    <cfset var rsProductRatingRelReport = "" >
    <cftry>
    <cfquery name="rsProductRatingRelReport" datasource="#application.mcmsDSN#">
    SELECT pName AS Name, TO_CHAR(prrComment) AS Comments, cstFName || ' ' || cstLName AS Customer, prrName AS Customer_Alt, prrEmail AS Email, TO_CHAR(prrDate, 'MM/DD/YYYY') AS Rating_Date, prrValue AS Rating, sName AS Status FROM v_product_rating_rel WHERE 0=0
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(pName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(prrEmail) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">)
    </cfif>
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsProductRatingRelReport = StructNew()>
    <cfset rsProductRatingRelReport.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsProductRatingRelReport>
    </cffunction>
    
    <cffunction name="getProductTemplateReport" access="public" returntype="query" hint="Get Product Template Report data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="orderBy" type="string" required="yes" default="pTempName">
    <cfset var rsProductTemplateReport = "" >
    <cftry>
    <cfquery name="rsProductTemplateReport" datasource="#application.mcmsDSN#">
    SELECT pTempName AS Name, pTempDescription AS Description, ptCode, ptERPCode, ptPOSCode, cName AS Catalog, pTempFile AS Template_File, sortName AS Sort, sName AS Status FROM v_product_template WHERE 0=0
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(pTempName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(pTempDescription) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">)
    </cfif>
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsProductTemplateReport = StructNew()>
    <cfset rsProductTemplateReport.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsProductTemplateReport>
    </cffunction>
    
    <cffunction name="getDistinctProductSkuAttributeRel" access="public" returntype="query" hint="Get Distinct Product Sku Attribute Rel. data.">
    <cfargument name="pID" type="numeric" required="yes" default="0">
    <cfargument name="paID" type="string" required="yes" default="0">
    <cfargument name="pavID" type="string" required="yes" default="0">
    <cfargument name="psarStatus" type="string" required="yes" default="1,2,3">
    <cfargument name="orderBy" type="string" required="yes" default="paSort, paID">
    <cfset var rsDistinctProductSkuAttributeRel = "" >
    <cftry>
    <cfquery name="rsDistinctProductSkuAttributeRel" datasource="#application.mcmsDSN#">
    SELECT DISTINCT pavValue, pavID, paSort, paID FROM v_product_sku_attribute_rel WHERE 0=0
    <cfif ARGUMENTS.pID NEQ 0>
    AND pID = <cfqueryparam value="#ARGUMENTS.pID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.paID NEQ 0>
    AND paID IN (<cfqueryparam value="#ARGUMENTS.paID#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    <cfif ARGUMENTS.pavID NEQ 0>
    AND pavID IN (<cfqueryparam value="#ARGUMENTS.pavID#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    AND pDateExp >= <cfqueryparam value="#DateFormat(Now(), application.dateFormat)#" cfsqltype="cf_sql_date">
    AND skuDateExp >= <cfqueryparam value="#DateFormat(Now(), application.dateFormat)#" cfsqltype="cf_sql_date">
    AND paStatus IN (<cfqueryparam value="#ARGUMENTS.psarStatus#" list="yes" cfsqltype="cf_sql_integer">)
    AND pavStatus IN (<cfqueryparam value="#ARGUMENTS.psarStatus#" list="yes" cfsqltype="cf_sql_integer">)
    AND skuStatus IN (<cfqueryparam value="#ARGUMENTS.psarStatus#" list="yes" cfsqltype="cf_sql_integer">)
    AND pStatus IN (<cfqueryparam value="#ARGUMENTS.psarStatus#" list="yes" cfsqltype="cf_sql_integer">)
    AND psarStatus IN (<cfqueryparam value="#ARGUMENTS.psarStatus#" list="yes" cfsqltype="cf_sql_integer">)
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsDistinctProductSkuAttributeRel = StructNew()>
    <cfset rsDistinctProductSkuAttributeRel.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsDistinctProductSkuAttributeRel>
    </cffunction>
    
    <cffunction name="insertProduct" access="public" returntype="struct">
    <cfargument name="vID" type="numeric" required="yes">
    <cfargument name="bID" type="numeric" required="yes">
    <cfargument name="pesID" type="numeric" required="yes">
    <cfargument name="pName" type="string" required="yes">
    <cfargument name="productID" type="string" required="yes">
    <cfargument name="productIDTemp" type="string" required="yes">
    <cfargument name="pPageTitle" type="string" required="yes">
    <cfargument name="pDateRel" type="string" required="yes" default="#Now()#">
    <cfargument name="pDateExp" type="string" required="yes" default="#DateAdd('yyyy', 10, Now())#">
    <cfargument name="pBulletPoint" type="string" required="yes">
    <cfargument name="pDescription" type="string" required="yes">
    <cfargument name="pKeyword" type="string" required="yes">
    <cfargument name="pMetaDescription" type="string" required="yes">
    <cfargument name="pCSL" type="string" required="yes">
    <cfargument name="pMPN" type="string" required="yes">
    <cfargument name="pstID" type="numeric" required="yes">
    <cfargument name="ptID" type="numeric" required="yes">
    <cfargument name="cID" type="string" required="yes">
    <cfargument name="deptNo" type="string" required="yes">
    <cfargument name="ptempID" type="numeric" required="yes">
    <cfargument name="ppID" type="numeric" required="yes">
    <cfargument name="pSort" type="numeric" required="yes">
    <cfargument name="pStatus" type="numeric" required="yes">
    <!---Include relationships--->
    <cfargument name="ainID" type="string" required="yes">
    <!---Include sku list to match ERP.--->
    <cfargument name="pSkuList" type="string" required="yes" default="">
    <cfset result.message = "You have successfully inserted the record. Please wait while the product is built an you are taken to the update screen.">
    <cftry>
    <!---Get the actual product ID.--->
    <cfif ARGUMENTS.productID EQ ARGUMENTS.productIDTemp>
    <cfinvoke 
    component="MCMS.component.app.product.Product"
    method="setProductID"
    returnvariable="setProductID">
    </cfinvoke>
    <cfelse>
    <cfset setProductID = ARGUMENTS.productID>
    </cfif>
    <!---Check for profanity in the text.--->
    <cfinvoke 
    component="MCMS.component.utility.Regex"
    method="regexProfanity"
    returnvariable="regexProfanityRet">
    <cfinvokeargument name="profanityString" value="#TRIM(ARGUMENTS.pDescription)#"/>
    </cfinvoke>
    
    <!---Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.app.product.Product"
    method="getProduct"
    returnvariable="getCheckProductRet">
    <cfinvokeargument name="pName" value="#TRIM(ARGUMENTS.pName)#"/>
    <cfinvokeargument name="pStatus" value="1,2,3"/>
    </cfinvoke>
    
    <cfinvoke 
    component="MCMS.component.app.product.Product"
    method="getProduct"
    returnvariable="getCheckProductIDRet">
    <cfinvokeargument name="productID" value="#TRIM(ARGUMENTS.productID)#"/>
    <cfinvokeargument name="pStatus" value="1,2,3"/>
    </cfinvoke>
    
    <cfif getCheckProductRet.recordcount EQ 0 AND getCheckProductIDRet.recordcount NEQ 0>
    <!---Get a new productID becuase the original was taken by another user.--->
    <cfinvoke 
    component="MCMS.component.app.product.Product"
    method="setProductID"
    returnvariable="setProductID">
    </cfinvoke>
    </cfif>
    
    <cfif getCheckProductRet.recordcount NEQ 0>
    <cfset result.message = "The name #TRIM(ARGUMENTS.pName)# already exists, please enter a new name.">
    <cfelseif regexProfanityRet CONTAINS '$%&*!'>
    <cfset result.message = "Some text contained profanity, please remove any profanity from your text.">
    <!---Check length restriction.--->
    <cfelseif LEN(ARGUMENTS.pBulletPoint) GT 2048>
    <cfset result.message = "The bullet points are longer than 2048 characters, please enter new bullet points under 255 characters.">
    <cfelseif LEN(ARGUMENTS.pMetaDescription) GT 512>
    <cfset result.message = "The meta description is longer than 512 characters, please enter a new description under 512 characters.">
    <cfelse>
    <cftransaction>
    <!---Create bullet point tags.--->
    <cfinvoke 
    component="MCMS.component.utility.List"
    method="setBulletList"
    returnvariable="setBulletListRet">
    <cfinvokeargument name="listValue" value="#TRIM(ARGUMENTS.pBulletPoint)#"/>
    <cfinvokeargument name="type" value="unordered"/>
    </cfinvoke>
    <cfquery datasource="#application.mcmsDSN#">
    INSERT INTO tbl_product (productID,vID,bID,pesID,pDateRel,pDateExp,pName,pPageTitle,pBulletPoint,pDescription,pKeyword,pMetaDescription,pCSL,pMPN,pSkuList,pstID,userID,ptID,ppID,pSort,pStatus) VALUES
    (
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#TRIM(setProductID)#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.vID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.bID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.pesID#">,
    <cfqueryparam cfsqltype="cf_sql_date" value="#DateFormat(ARGUMENTS.pDateRel, application.dateFormat)#">,
    <cfqueryparam cfsqltype="cf_sql_date" value="#DateFormat(ARGUMENTS.pDateExp, application.dateFormat)#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#TRIM(ARGUMENTS.pName)#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#TRIM(ARGUMENTS.pPageTitle)#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#setBulletListRet#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#TRIM(Replace(ARGUMENTS.pDescription, '&amp;', '&', 'ALL'))#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#TRIM(ARGUMENTS.pKeyword)#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#TRIM(Replace(ARGUMENTS.pMetaDescription, '&amp;', '&', 'ALL'))#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#TRIM(ARGUMENTS.pCSL)#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#TRIM(ARGUMENTS.pMPN)#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#TRIM(ListRemoveDuplicates(ARGUMENTS.pSkuList))#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.pstID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#session.userID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ptID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ppID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.pSort#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.pStatus#">
    )
    </cfquery>
    </cftransaction>
    <!---Set a result ID to be included with a link to the update form.--->
    <cfinvoke 
    component="MCMS.component.cms.Cms"
    method="getMaxValueSQL"
    returnvariable="getMaxValueSQLRet">
    <cfinvokeargument name="tableName" value="tbl_product"/>
    </cfinvoke>
    <cfset this.ID = getMaxValueSQLRet>
    <!---Make required updates to product status based on type of request.--->
    <cfinvoke 
    component="MCMS.component.app.product.Product" 
    method="updateProductStatus" 
    >
    <cfinvokeargument name="pID" value="#this.ID#">
    <cfinvokeargument name="pwfID" value="101">
    <cfinvokeargument name="pwfcComment" value="Product created.">
    <cfinvokeargument name="pStatus" value="3">
    </cfinvoke>
    <!---Insert Relationships--->
    <!---Insert Detail (Default) relationships.--->
    <cfinvoke 
    component="MCMS.component.app.product.Product"
    method="insertProductDetail"
    >
    <cfinvokeargument name="pID" value="#this.ID#"/>
    <cfinvokeargument name="pdName" value="Detail"/>
    <cfinvokeargument name="pdDescription" value="#ARGUMENTS.pDescription#"/>
    <cfinvokeargument name="pdDateRel" value="#ARGUMENTS.pDateRel#"/>
    <cfinvokeargument name="pdDateExp" value="#ARGUMENTS.pDateExp#"/>
    <cfinvokeargument name="pdtID" value="1"/>
    <cfinvokeargument name="pdSort" value="1"/>
    <cfinvokeargument name="pdStatus" value="1"/>
    </cfinvoke>
    <cfloop index="catalogID" from="1" to="#ListLen(ARGUMENTS.cID)#">
    <!---Insert Catalog relationships.--->
    <cfinvoke 
    component="MCMS.component.app.catalog.Catalog"
    method="insertCatalogProductRel">
    <cfinvokeargument name="pID" value="#this.ID#"/>
    <cfinvokeargument name="cID" value="#ListGetAt(ARGUMENTS.cID, catalogID)#"/>
    <cfinvokeargument name="cprDiscount" value="0"/>
    <cfinvokeargument name="cprDateExp" value="#DateFormat(ARGUMENTS.pDateExp, application.dateFormat)#"/>
    <cfinvokeargument name="cprStatus" value="1"/>
    </cfinvoke>
    </cfloop>
    <!---Insert Ad Item relationships.--->
    <cfloop index="aditemnameID" from="1" to="#ListLen(ARGUMENTS.ainID)#">
    <cfinvoke 
    component="MCMS.component.app.product.Product"
    method="insertProductAdItemRel">
    <cfinvokeargument name="pID" value="#this.ID#"/>
    <cfinvokeargument name="ainID" value="#ListGetAt(ARGUMENTS.ainID, aditemnameID)#"/>
    <cfinvokeargument name="pairStatus" value="1"/>
    </cfinvoke>
    </cfloop>
    <!---Insert Product Department Relationships.--->
    <cfloop index="i" from="1" to="#ListLen(ARGUMENTS.cID)#">
    <cfloop index="ii" from="1" to="#ListLen(ARGUMENTS.deptNo)#">
    <!---Insert Product Department relationships.--->
    <cfinvoke 
    component="MCMS.component.app.product.Product"
    method="insertProductDepartmentRel">
    <cfinvokeargument name="cID" value="#ListGetAt(ARGUMENTS.cID, i)#"/>
    <cfinvokeargument name="pID" value="#this.ID#"/>
    <cfinvokeargument name="deptNo" value="#ListGetAt(ARGUMENTS.deptNo, ii)#"/>
    <cfinvokeargument name="pdrStatus" value="1"/>
    </cfinvoke>
    </cfloop>
    </cfloop>
    <!---Insert Product Template relationships.--->
    <cfinvoke 
    component="MCMS.component.app.product.Product"
    method="insertProductAttributeExtRel">
    <cfinvokeargument name="pID" value="#this.ID#"/>
    <cfinvokeargument name="paeID" value="103"/>
    <cfinvokeargument name="paerValue" value="#ARGUMENTS.ptempID#"/>
    <cfinvokeargument name="paerStatus" value="1"/>
    </cfinvoke>
    <!---Insert Product Media Request.--->
    <cfinvoke 
    component="MCMS.component.app.product_workflow.ProductWorkflow"
    method="insertProductWorkflowRequest"
    >
    <cfinvokeargument name="pID" value="#this.ID#"/>
    <cfinvokeargument name="pwfID" value="111"/>
    <cfinvokeargument name="pwfrRequest" value="Images/Documents are need for #ARGUMENTS.pName#."/>
    <cfinvokeargument name="pwfrtID" value="4"/>
    <cfinvokeargument name="pwfrDateRequired" value="#ARGUMENTS.pDateRel#"/>
    <!---Switched to Bypassed to speed up production.--->
    <cfinvokeargument name="pwfrsID" value="3"/>
    <cfinvokeargument name="pwfrStatus" value="1"/>
    </cfinvoke>
    <!---Insert Sku Records if pSkuList is not null.--->
    <cfif ARGUMENTS.pSkuList NEQ ''>
    <cfinvoke 
    component="MCMS.component.app.sku.Sku"
    method="insertSkuFromERP"
    returnvariable="result"
    >
    <cfinvokeargument name="pID" value="#this.ID#"/>
    <cfif ListLen(ARGUMENTS.deptNo) EQ 1>
    <cfinvokeargument name="deptNo" value="#ARGUMENTS.deptNo#"/>
    </cfif>
    <cfinvokeargument name="pSkuList" value="#ListRemoveDuplicates(ARGUMENTS.pSkuList)#"/>
    <cfinvokeargument name="resultMessage" value="#result.message#"/>
    </cfinvoke>
    </cfif>
    <!---Forward to update form.--->
    <cfset ajaxOnLoad("function() {
    lAjax('layoutIndex', #url.appID#, 'Product' ,'/#application.mcmsAppAdminPath#/product/view/inc_product.cfm','Description','update', #this.ID#);
	}")>
    </cfif>
    <cfcatch type="any">
    <cfset result.message = "There was an error inserting the record. A duplicate product ID may have been found causing this error.  Please check with the System Administrator or use the Sku Manager/Product application to find the product ID.">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="insertProductImport" access="public" returntype="struct">
    <cfargument name="productID" type="string" required="yes">
    <cfargument name="pName" type="string" required="yes">
    <cfargument name="pBulletPoint" type="string" required="yes">
    <cfargument name="pDescription" type="string" required="yes">
    <cfargument name="pMetaDescription" type="string" required="yes">
    <cfargument name="cID" type="numeric" required="yes">
    <cfargument name="deptNo" type="string" required="yes">
    <cfargument name="ptCode" type="string" required="yes">
    <cfargument name="userID" type="numeric" required="yes" default="101">
    <cfset result.message = "You have successfully inserted the record(s).">
    <cftry>
    <!---Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.app.product.Product"
    method="getProduct"
    returnvariable="getCheckProductRet">
    <cfinvokeargument name="productID" value="#TRIM(ARGUMENTS.productID)#"/>
    <cfinvokeargument name="pStatus" value="1,2,3"/>
    </cfinvoke>
    <!---Create bullet point tags.--->
    <cfinvoke 
    component="MCMS.component.utility.List"
    method="setBulletList"
    returnvariable="setBulletListRet">
    <cfinvokeargument name="listValue" value="#TRIM(ARGUMENTS.pBulletPoint)#"/>
    <cfinvokeargument name="type" value="unordered"/>
    </cfinvoke>
    <cfif getCheckProductRet.recordcount NEQ 0>
    <!---If product exists update it.--->
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_product SET
    pName = <cfqueryparam cfsqltype="cf_sql_varchar" value="#TRIM(ARGUMENTS.pName)#">,
    pPageTitle = <cfqueryparam cfsqltype="cf_sql_varchar" value="#TRIM(ARGUMENTS.pName)#">,
    pBulletPoint = <cfqueryparam cfsqltype="cf_sql_varchar" value="#setBulletListRet#">,
    pDescription = <cfqueryparam cfsqltype="cf_sql_varchar" value="#TRIM(Replace(ARGUMENTS.pDescription, '&amp;', '&', 'ALL'))#">,
    pMetaDescription = <cfqueryparam cfsqltype="cf_sql_varchar" value="#TRIM(Replace(ARGUMENTS.pMetaDescription, '&amp;', '&', 'ALL'))#">,
    pDateUpdate = <cfqueryparam cfsqltype="cf_sql_date" value="#DateFormat(Now(), 'mm/dd/yyyy')#">,
    ptID = <cfqueryparam cfsqltype="cf_sql_integer" value="5">
    WHERE productID = <cfqueryparam cfsqltype="cf_sql_varchar" value="#TRIM(ARGUMENTS.productID)#">
    </cfquery>
    </cftransaction>
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    INSERT INTO tbl_product (productID,vID,bID,pesID,pDateRel,pDateExp,pName,pPageTitle,pBulletPoint,pDescription,pMetaDescription,pMPN,userID,ptID,ppID,pSort,pStatus) VALUES
    (
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#TRIM(ARGUMENTS.productID)#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="0">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="0">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="101">,
    <cfqueryparam cfsqltype="cf_sql_date" value="#DateFormat(Now(), 'mm/dd/yyyy')#">,
    <cfqueryparam cfsqltype="cf_sql_date" value="#DateFormat(DateAdd('yyyy', 10, Now()), 'mm/dd/yyyy')#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#TRIM(ARGUMENTS.pName)#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#TRIM(ARGUMENTS.pName)#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#setBulletListRet#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#TRIM(Replace(ARGUMENTS.pDescription, '&amp;', '&', 'ALL'))#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#TRIM(Replace(ARGUMENTS.pMetaDescription, '&amp;', '&', 'ALL'))#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="0">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#TRIM(ARGUMENTS.userID)#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="4">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="106">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="1">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="3">
    )
    </cfquery>
    </cftransaction>
    <!---Set a result ID to be included with a link to the update form.--->
    <cfinvoke 
    component="MCMS.component.cms.Cms"
    method="getMaxValueSQL"
    returnvariable="getMaxValueSQLRet">
    <cfinvokeargument name="tableName" value="tbl_product"/>
    </cfinvoke>
    <cfset result.ID = getMaxValueSQLRet>
    <!---Make required updates to product status based on type of request.--->
    <cfinvoke 
    component="MCMS.component.app.product.Product" 
    method="updateProductStatus" 
    >
    <cfinvokeargument name="pID" value="#result.ID#">
    <cfinvokeargument name="pwfID" value="101">
    <cfinvokeargument name="pwfcComment" value="Product created.">
    <cfinvokeargument name="pStatus" value="3">
    </cfinvoke>
    <!---Insert Relationships--->
    <!---Insert Detail (Default) relationships.--->
    <cfinvoke 
    component="MCMS.component.app.product.Product"
    method="insertProductDetail"
    >
    <cfinvokeargument name="pID" value="#result.ID#"/>
    <cfinvokeargument name="pdName" value="Detail"/>
    <cfinvokeargument name="pdDescription" value="#TRIM(ARGUMENTS.pDescription)#"/>
    <cfinvokeargument name="pdDateRel" value="#DateFormat(Now(), 'mm/dd/yyyy')#"/>
    <cfinvokeargument name="pdDateExp" value="#DateFormat(DateAdd('yyyy', 10, Now()), 'mm/dd/yyyy')#"/>
    <cfinvokeargument name="pdtID" value="1"/>
    <cfinvokeargument name="pdSort" value="1"/>
    <cfinvokeargument name="pdStatus" value="1"/>
    </cfinvoke>
    <!---Insert Catalog relationships.--->
    <cfinvoke 
    component="MCMS.component.app.catalog.Catalog"
    method="insertCatalogProductRel">
    <cfinvokeargument name="pID" value="#result.ID#"/>
    <cfinvokeargument name="cID" value="#TRIM(ARGUMENTS.cID)#"/>
    <cfinvokeargument name="cprDiscount" value="0"/>
    <cfinvokeargument name="cprDateExp" value="#DateFormat(DateAdd('yyyy', 10, Now()), 'mm/dd/yyyy')#"/>
    <cfinvokeargument name="cprStatus" value="1"/>
    </cfinvoke>
    <!---Insert Product Department relationships.--->
    <cfinvoke 
    component="MCMS.component.app.product.Product"
    method="insertProductDepartmentRel">
    <cfinvokeargument name="cID" value="#TRIM(ARGUMENTS.cID)#"/>
    <cfinvokeargument name="pID" value="#result.ID#"/>
    <cfinvokeargument name="deptNo" value="#TRIM(ARGUMENTS.deptNo)#"/>
    <cfinvokeargument name="pdrStatus" value="1"/>
    </cfinvoke>
    <!---Insert Product Template relationships.--->
    <!---First get product template ID by code.--->
    <cfinvoke 
    component="MCMS.component.app.product.Product"
    method="getProductTemplate"
    returnvariable="getCheckProductTemplateRet">
    <cfinvokeargument name="ptCode" value="#TRIM(ARGUMENTS.ptCode)#"/>
    <cfinvokeargument name="ptempStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckProductTemplateRet.recordcount NEQ 0>
    <cfinvoke 
    component="MCMS.component.app.product.Product"
    method="insertProductAttributeExtRel">
    <cfinvokeargument name="pID" value="#result.ID#"/>
    <cfinvokeargument name="paeID" value="103"/>
    <cfinvokeargument name="paerValue" value="#getCheckProductTemplateRet.ID#"/>
    <cfinvokeargument name="paerStatus" value="1"/>
    </cfinvoke>
    </cfif>
    <!---Insert Product Media Request.--->
    <cfinvoke 
    component="MCMS.component.app.product_workflow.ProductWorkflow"
    method="insertProductWorkflowRequest"
    >
    <cfinvokeargument name="pID" value="#result.ID#"/>
    <cfinvokeargument name="pwfID" value="111"/>
    <cfinvokeargument name="pwfrRequest" value="Images/Documents are need for #ARGUMENTS.pName#."/>
    <cfinvokeargument name="pwfrtID" value="4"/>
    <cfinvokeargument name="pwfrDateRequired" value="#DateFormat(Now(), 'mm/dd/yyyy')#"/>
    <cfinvokeargument name="pwfrsID" value="1"/>
    <cfinvokeargument name="pwfrStatus" value="1"/>
    </cfinvoke>
    </cfif>
    <cfcatch type="any">
    <cflog file="insertProductImport" application="no" type="error" text="The product import failed. Message: #cfcatch.message# Detail: #cfcatch.detail#">
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="insertProductDetail" access="public" returntype="struct">
    <cfargument name="pID" type="numeric" required="yes">
    <cfargument name="pdName" type="string" required="yes">
    <cfargument name="pdDescription" type="string" required="yes">
    <cfargument name="pdDateRel" type="string" required="yes">
    <cfargument name="pdDateExp" type="string" required="yes">
    <cfargument name="pdtID" type="numeric" required="yes">
    <cfargument name="pdSort" type="numeric" required="yes">
    <cfargument name="pdStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully inserted the record.">
    <cftry>
    <!---Check for profanity in the text.--->
    <cfinvoke 
    component="MCMS.component.utility.Regex"
    method="regexProfanity"
    returnvariable="regexProfanityRet">
    <cfinvokeargument name="profanityString" value="#TRIM(ARGUMENTS.pdDescription)#"/>
    </cfinvoke>
    <!---Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.app.product.Product"
    method="getProductDetail"
    returnvariable="getCheckProductDetailRet">
    <cfinvokeargument name="pID" value="#ARGUMENTS.pID#"/>
    <cfinvokeargument name="pdtID" value="#ARGUMENTS.pdtID#"/>
    <cfinvokeargument name="pdStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckProductDetailRet.recordcount NEQ 0>
    <cfset result.message = "The product detail already exists, please select another type.">
    <cfelseif regexProfanityRet CONTAINS '$%&*!'>
    <cfset result.message = "Some text contained profanity, please remove any profanity from your text.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    INSERT INTO tbl_product_detail (pID,pdName,pdDescription,pdDateRel,pdDateExp,pdtID,userID,pdSort,pdStatus) VALUES
    (
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.pID#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#TRIM(ARGUMENTS.pdName)#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#TRIM(Replace(ARGUMENTS.pdDescription, '&amp;', '&', 'ALL'))#">,
    <cfqueryparam cfsqltype="cf_sql_date" value="#DateFormat(ARGUMENTS.pdDateRel, application.dateFormat)#">,
    <cfqueryparam cfsqltype="cf_sql_date" value="#DateFormat(ARGUMENTS.pdDateExp, application.dateFormat)#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.pdtID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#session.userID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.pdSort#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.pdStatus#">
    )
    </cfquery>
    </cftransaction>
    <!---Make required updates to product status based on type of request.--->
    <cfinvoke 
    component="MCMS.component.app.product.Product" 
    method="updateProductStatus" 
    >
    <cfinvokeargument name="pID" value="#ARGUMENTS.pID#">
    <cfinvokeargument name="pwfID" value="103">
    <cfinvokeargument name="pwfcComment" value="Product detail created.">
    <cfinvokeargument name="pStatus" value="3">
    </cfinvoke>
    </cfif>
    <cfcatch type="any">
    <cfset result.message = "There was an error inserting the record.">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="insertProductAttribute" access="public" returntype="struct">
    <cfargument name="paName" type="string" required="yes">
    <cfargument name="paNameAlt" type="string" required="yes">
    <cfargument name="paDescription" type="string" required="yes">
    <cfargument name="paCode" type="string" required="yes">
    <cfargument name="paERPCode" type="string" required="yes">
    <cfargument name="paPOSCode" type="string" required="yes">
    <cfargument name="paRequired" type="numeric" required="yes">
    <cfargument name="paDefaultValue" type="string" required="yes">
    <cfargument name="paRegEx" type="string" required="yes">
    <cfargument name="patID" type="numeric" required="yes">
    <cfargument name="patFieldCount" type="numeric" required="yes">
    <cfargument name="paRangeStart" type="numeric" required="yes">
    <cfargument name="paRangeEnd" type="numeric" required="yes">
    <cfargument name="paComponent" type="string" required="yes">
    <cfargument name="paMethod" type="string" required="yes">
    <cfargument name="paValueColumn" type="string" required="yes">
    <cfargument name="paNameColumn" type="string" required="yes">
    <cfargument name="paArgumentList" type="string" required="yes">
    <cfargument name="paLOVList" type="string" required="yes">
    <cfargument name="paSort" type="numeric" required="yes">
    <cfargument name="paStatus" type="numeric" required="yes">
    <!---Relationship arguments.--->
    <cfargument name="cID" type="string" required="yes">
    <cfargument name="deptNo" type="string" required="yes">
    <cfargument name="uomID" type="string" required="yes">
    <cfargument name="sepID" type="string" required="yes">
    <cfset result.message = "You have successfully inserted the record.">
    <cftry>
    <!---Check for profanity in the text.--->
    <cfinvoke 
    component="MCMS.component.utility.Regex"
    method="regexProfanity"
    returnvariable="regexProfanityRet">
    <cfinvokeargument name="profanityString" value="#TRIM(ARGUMENTS.paDescription)#"/>
    </cfinvoke>
    <!---Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.app.product.Product"
    method="getProductAttribute"
    returnvariable="getCheckProductAttributeRet">
    <cfinvokeargument name="paName" value="#TRIM(ARGUMENTS.paName)#"/>
    <cfinvokeargument name="paStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckProductAttributeRet.recordcount NEQ 0>
    <cfset result.message = "The name #TRIM(ARGUMENTS.paName)# already exists, please enter a new name.">
    <cfelseif regexProfanityRet CONTAINS '$%&*!'>
    <cfset result.message = "Some text contained profanity, please remove any profanity from your text.">
    <cfelseif LEN(ARGUMENTS.paDescription) GT 1024>
    <cfset result.message = "The description is longer than 1024 characters, please enter a new description under 1024 characters.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    INSERT INTO tbl_product_attribute (paName,paNameAlt,paDescription,paCode,paERPCode,paPOSCode,paRequired,paDefaultValue,paRegEx,patID,patFieldCount, userID,paRangeStart,paRangeEnd,paComponent,paMethod,paValueColumn,paNameColumn,paArgumentList,paLOVList,paSort,paStatus) VALUES
    (
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#TRIM(ARGUMENTS.paName)#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#TRIM(ARGUMENTS.paNameAlt)#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#TRIM(ARGUMENTS.paDescription)#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#TRIM(ARGUMENTS.paCode)#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#TRIM(ARGUMENTS.paERPCode)#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#TRIM(ARGUMENTS.paPOSCode)#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.paRequired#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#TRIM(ARGUMENTS.paDefaultValue)#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#TRIM(ARGUMENTS.paRegEx)#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.patID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.patFieldCount#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#session.userID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.paRangeStart#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.paRangeEnd#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#TRIM(ARGUMENTS.paComponent)#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#TRIM(ARGUMENTS.paMethod)#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#TRIM(ARGUMENTS.paValueColumn)#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#TRIM(ARGUMENTS.paNameColumn)#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#TRIM(ARGUMENTS.paArgumentList)#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#TRIM(ARGUMENTS.paLOVList)#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.paSort#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.paStatus#">
    )
    </cfquery>
    </cftransaction>
    <!--- Get newly inserted attribute ID. --->
    <cfinvoke 
    component="MCMS.component.cms.Cms"
    method="getMaxValueSQL"
    returnvariable="paID">
    <cfinvokeargument name="tableName" value="tbl_product_attribute"/>
    </cfinvoke>
    <cfset var.paID = paID>
    <!---Create department relationships.--->
    <cfinvoke 
    component="MCMS.component.app.product.Product"
    method="insertProductAttributeDepartmentRel"
    returnvariable="insertProductAttributeDepartmentRelRet">
    <cfinvokeargument name="cID" value="#ARGUMENTS.cID#"/>
    <cfinvokeargument name="paID" value="#var.paID#"/>
    <cfinvokeargument name="deptNo" value="#ARGUMENTS.deptNo#"/>
    <cfinvokeargument name="padrStatus" value="1"/>
    </cfinvoke>
    <!---Create UOM relationships.--->
    <cfinvoke 
    component="MCMS.component.app.product.Product"
    method="insertProductAttributeUOMRel"
    returnvariable="insertProductAttributeUOMRelRet">
    <cfinvokeargument name="paID" value="#var.paID#"/>
    <cfinvokeargument name="uomID" value="#ARGUMENTS.uomID#"/>
    <cfinvokeargument name="pauomrStatus" value="1"/>
    </cfinvoke>
    <!---Create Separator relationships.--->
    <cfinvoke 
    component="MCMS.component.app.product.Product"
    method="insertProductAttrSeparatorRel"
    returnvariable="insertProductAttrSeparatorRelRet">
    <cfinvokeargument name="paID" value="#var.paID#"/>
    <cfinvokeargument name="sepID" value="#ARGUMENTS.sepID#"/>
    <cfinvokeargument name="paseprStatus" value="1"/>
    </cfinvoke>
    </cfif>
    <cfcatch type="any">
    <cfset result.message = "There was an error inserting the record.">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="insertProductAttributeExt" access="public" returntype="struct">
    <cfargument name="paeName" type="string" required="yes">
    <cfargument name="paeNameAlt" type="string" required="yes">
    <cfargument name="paeDescription" type="string" required="yes">
    <cfargument name="paeCode" type="string" required="yes">
    <cfargument name="paeERPCode" type="string" required="yes">
    <cfargument name="paePOSCode" type="string" required="yes">
    <cfargument name="paeRequired" type="numeric" required="yes">
    <cfargument name="paeDefaultValue" type="string" required="yes">
    <cfargument name="paeRegEx" type="string" required="yes">
    <cfargument name="paetID" type="numeric" required="yes">
    <cfargument name="paeSort" type="numeric" required="yes">
    <cfargument name="paeStatus" type="numeric" required="yes">
    <!---Relationship arguments.--->
    <cfargument name="cID" type="string" required="yes">
    <cfargument name="deptNo" type="string" required="yes">
    <cfset result.message = "You have successfully inserted the record.">
    <cftry>
    <!---Check for profanity in the text.--->
    <cfinvoke 
    component="MCMS.component.utility.Regex"
    method="regexProfanity"
    returnvariable="regexProfanityRet">
    <cfinvokeargument name="profanityString" value="#TRIM(ARGUMENTS.paeDescription)#"/>
    </cfinvoke>
    <!---Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.app.product.Product"
    method="getProductAttributeExt"
    returnvariable="getCheckProductAttributeExtRet">
    <cfinvokeargument name="paeName" value="#TRIM(ARGUMENTS.paeName)#"/>
    <cfinvokeargument name="paeStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckProductAttributeExtRet.recordcount NEQ 0>
    <cfset result.message = "The name #TRIM(ARGUMENTS.paeName)# already exists, please enter a new name.">
    <cfelseif regexProfanityRet CONTAINS '$%&*!'>
    <cfset result.message = "Some text contained profanity, please remove any profanity from your text.">
    <cfelseif LEN(ARGUMENTS.paeDescription) GT 2048>
    <cfset result.message = "The description is longer than 2048 characters, please enter a new description under 2048 characters.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    INSERT INTO tbl_product_attribute_ext (paeName,paeNameAlt,paeDescription,paeCode,paeERPCode,paePOSCode,paeRequired,paeDefaultValue,paeRegEx,paetID,userID,paeSort,paeStatus) VALUES
    (
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#TRIM(ARGUMENTS.paeName)#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#TRIM(ARGUMENTS.paeNameAlt)#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#TRIM(ARGUMENTS.paeDescription)#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#TRIM(ARGUMENTS.paeCode)#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#TRIM(ARGUMENTS.paeERPCode)#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#TRIM(ARGUMENTS.paePOSCode)#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.paeRequired#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#TRIM(ARGUMENTS.paeDefaultValue)#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#TRIM(ARGUMENTS.paeRegEx)#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.paetID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#session.userID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.paeSort#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.paeStatus#">
    )
    </cfquery>
    </cftransaction>
    <!--- Get newly inserted attribute ext. ID. --->
    <cfinvoke 
    component="MCMS.component.cms.Cms"
    method="getMaxValueSQL"
    returnvariable="paeID">
    <cfinvokeargument name="tableName" value="tbl_product_attribute_ext"/>
    </cfinvoke>
    <cfset var.paeID = paeID>
    <!---Create department relationships.--->
    <cfinvoke 
    component="MCMS.component.app.product.Product"
    method="insertProductAttributeExtDepartmentRel"
    returnvariable="insertProductAttributeExtDepartmentRelRet">
    <cfinvokeargument name="cID" value="#ARGUMENTS.cID#"/>
    <cfinvokeargument name="paeID" value="#var.paeID#"/>
    <cfinvokeargument name="deptNo" value="#ARGUMENTS.deptNo#"/>
    <cfinvokeargument name="paedrStatus" value="1"/>
    </cfinvoke>
    </cfif>
    <cfcatch type="any">
    <cfset result.message = "There was an error inserting the record.">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="insertProductAttributeExtRel" access="public" returntype="struct">
    <cfargument name="pID" type="numeric" required="yes">
    <cfargument name="paeID" type="numeric" required="yes">
    <cfargument name="paerValue" type="string" required="yes">
    <cfargument name="paerStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully inserted the record.">
    <cftry>
    <!---Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.app.product.Product"
    method="getProductAttributeExtRel"
    returnvariable="getCheckProductAttributeExtRelRet">
    <cfinvokeargument name="pID" value="#ARGUMENTS.pID#"/>
    <cfinvokeargument name="paeID" value="#ARGUMENTS.paeID#"/>
    <cfinvokeargument name="paerValue" value="#TRIM(ARGUMENTS.paerValue)#"/>
    <cfinvokeargument name="paerStatus" value="1,3"/>
    </cfinvoke>
    <cfif getCheckProductAttributeExtRelRet.recordcount NEQ 0>
    <cfset result.message = "The product already has this attribute ext. relationship, please select another attribute.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    INSERT INTO tbl_product_attribute_ext_rel (pID,paeID,paerValue,paerStatus) VALUES
    (
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.pID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.paeID#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#TRIM(ARGUMENTS.paerValue)#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.paerStatus#">
    )
    </cfquery>
    </cftransaction>
    <!---If compliance authorization is required notify by email and add the sku attributes dynamically.--->
    <cfif ListContains(application.complianceAuthorizationAttributeExtList, ARGUMENTS.paeID) AND ListContains('18', ARGUMENTS.paerValue)>
    <!---Insert the attributes based on the compliance attribute ext.--->
    <cfloop list="#application.complianceAuthorizationAttributeList#" index="i">
    <cfinvoke 
    component="MCMS.component.app.product.Product"
    method="insertProductAttributeRel">
    <cfinvokeargument name="pID" value="#ARGUMENTS.pID#">
    <cfinvokeargument name="paID" value="#i#"/>
    <cfinvokeargument name="parStatus" value="1"/>
    </cfinvoke>
    </cfloop>
    <cfinvoke 
    component="MCMS.component.app.product.Product"
    method="getProduct"
    returnvariable="rs">
    <cfinvokeargument name="ID" value="#ARGUMENTS.pID#"/>
    <cfinvokeargument name="pStatus" value="1,2,3"/>
    </cfinvoke>
    <!---This authorization covers Special Handling.--->
    <cfset this.emailBody = "
	<h3>#application.companyName# Product - #rs.pName# Compliance Authorization</h3>
	#LSDateFormat(Now())# - #LSTimeFormat(Now())#
	<br/>
	<p>
	#rs.pName#(#rs.productID#/#rs.ID#) requires Compliance Authorization.<br><br>
	This product may not have skus assigned to it in the Commerce Workflow yet.  This message is to inform you to check #rs.pName# skus before its release date on #DateFormat(rs.pDateRel, application.dateFormat)#.<br><br>
	To update skus that require compliance authorization, please access the Sku Manager application via the link below.
	</p>
	<div align='center'><a href='//#CGI.SERVER_NAME#' class='textBold'>Commerce Dashboard</a></div>
	">
    <cfinvoke 
    component="MCMS.component.utility.Email"
    method="sendEmail">
    <cfinvokeargument name="subject" value="#application.companyName# - Compliance Authorization"/>
    <cfinvokeargument name="to" value="#application.complianceEmail#"/>
    <cfinvokeargument name="from" value="#application.noReplyEmail#"/>
    <cfinvokeargument name="body" value="#this.emailBody#"/>
    <cfinvokeargument name="ID" value="#ARGUMENTS.pID#"/>
    <cfinvokeargument name="emailTemplate" value=""/>
    </cfinvoke>
    </cfif>
    </cfif>
    <cfcatch type="any">
    <cfset result.message = "There was an error inserting the record.">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="insertProductAttributeRel" access="public" returntype="struct">
    <cfargument name="pID" type="numeric" required="yes">
    <cfargument name="paID" type="numeric" required="yes">
    <cfargument name="parStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully inserted the record.">
    <cftry>
    <!---Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.app.product.Product"
    method="getProductAttributeRel"
    returnvariable="getCheckProductAttributeRelRet">
    <cfinvokeargument name="pID" value="#ARGUMENTS.pID#"/>
    <cfinvokeargument name="paID" value="#ARGUMENTS.paID#"/>
    <cfinvokeargument name="parStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckProductAttributeRelRet.recordcount NEQ 0>
    <cfset result.message = "The product already has this attribute relationship, please select another attribute.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    INSERT INTO tbl_product_attribute_rel (pID,paID,parStatus) VALUES
    (
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.pID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.paID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.parStatus#">
    )
    </cfquery>
    <!---Create the default value of the product attribute rel.--->
    <!---First get any skus for this product.--->
    <cfinvoke 
    component="MCMS.component.app.sku.Sku"
    method="getSku"
    returnvariable="getSkuRet">
    <cfinvokeargument name="pID" value="#ARGUMENTS.pID#"/>
    <cfinvokeargument name="skuStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getSkuRet.recordcount NEQ 0>
    <cfset this.skuList = ValueList(getSkuRet.ID)>
    <!---Loop over the skus and add some default values for the skus.--->
    <cfloop list="#this.skuList#" index="i">
    <!---Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.app.product.Product"
    method="getProductSkuAttributeRel"
    returnvariable="getCheckProductSkuAttributeRelRet">
    <cfinvokeargument name="sID" value="#i#"/>
    <cfinvokeargument name="pID" value="#ARGUMENTS.pID#"/>
    <cfinvokeargument name="paID" value="#ARGUMENTS.paID#"/>
    <cfinvokeargument name="psarStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckProductSkuAttributeRelRet.recordcount EQ 0>
    <cfinvoke 
    component="MCMS.component.app.product.Product"
    method="insertProductSkuAttributeRel"
    >
    <cfinvokeargument name="pID" value="#ARGUMENTS.pID#"/>
    <cfinvokeargument name="sID" value="#i#"/>
    <cfinvokeargument name="paID" value="#ARGUMENTS.paID#"/>
    <cfinvokeargument name="pavID" value="0"/>
    <cfinvokeargument name="psaraltValue" value=""/>
	<cfinvokeargument name="psarStatus" value="1"/>
    </cfinvoke>
    </cfif>
    </cfloop>
    </cfif>
    </cftransaction>
    <!---Make required updates to product status based on type of request.--->
    <cfinvoke 
    component="MCMS.component.app.product.Product" 
    method="updateProductStatus" 
    >
    <cfinvokeargument name="pID" value="#ARGUMENTS.pID#">
    <cfinvokeargument name="pwfID" value="105">
    <cfinvokeargument name="pwfcComment" value="Product attribute relationship created.">
    <cfinvokeargument name="pStatus" value="3">
    </cfinvoke>
    </cfif>
    <cfcatch type="any">
    <cfset result.message = "There was an error inserting the record.">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="insertProductAttributeExtType" access="public" returntype="struct">
    <cfargument name="paetName" type="string" required="yes">
    <cfargument name="paetDescription" type="string" required="yes">
    <cfargument name="paetSort" type="numeric" required="yes">
    <cfargument name="paetStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully inserted the record.">
    <cftry>
    <!---Check for profanity in the text.--->
    <cfinvoke 
    component="MCMS.component.utility.Regex"
    method="regexProfanity"
    returnvariable="regexProfanityRet">
    <cfinvokeargument name="profanityString" value="#TRIM(ARGUMENTS.paetDescription)#"/>
    </cfinvoke>
    <!---Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.app.product.Product"
    method="getProductAttributeExtType"
    returnvariable="getCheckProductAttributeExtTypeRet">
    <cfinvokeargument name="paetName" value="#TRIM(ARGUMENTS.paetName)#"/>
    <cfinvokeargument name="paetStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckProductAttributeExtTypeRet.recordcount NEQ 0>
    <cfset result.message = "The name #TRIM(ARGUMENTS.paetName)# already exists, please enter a new name.">
    <cfelseif regexProfanityRet CONTAINS '$%&*!'>
    <cfset result.message = "Some text contained profanity, please remove any profanity from your text.">
    <!---Check length restriction.--->
    <cfelseif LEN(ARGUMENTS.paetDescription) GT 2048>
    <cfset result.message = "The description is longer than 2048 characters, please enter a new description under 2048 characters.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    INSERT INTO tbl_product_attribute_ext_type (paetName,paetDescription,paetSort,paetStatus) VALUES
    (
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#TRIM(ARGUMENTS.paetName)#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#TRIM(ARGUMENTS.paetDescription)#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.paetSort#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.paetStatus#">
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
    
    <cffunction name="insertProductAttributeType" access="public" returntype="struct">
    <cfargument name="patName" type="string" required="yes">
    <cfargument name="patDescription" type="string" required="yes">
    <cfargument name="patSort" type="numeric" required="yes">
    <cfargument name="patStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully inserted the record.">
    <cftry>
    <!---Check for profanity in the text.--->
    <cfinvoke 
    component="MCMS.component.utility.Regex"
    method="regexProfanity"
    returnvariable="regexProfanityRet">
    <cfinvokeargument name="profanityString" value="#TRIM(ARGUMENTS.patDescription)#"/>
    </cfinvoke>
    <!---Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.app.product.Product"
    method="getProductAttributeType"
    returnvariable="getCheckProductAttributeTypeRet">
    <cfinvokeargument name="patName" value="#TRIM(ARGUMENTS.patName)#"/>
    <cfinvokeargument name="patStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckProductAttributeTypeRet.recordcount NEQ 0>
    <cfset result.message = "The name #TRIM(ARGUMENTS.patName)# already exists, please enter a new name.">
    <cfelseif regexProfanityRet CONTAINS '$%&*!'>
    <cfset result.message = "Some text contained profanity, please remove any profanity from your text.">
    <!---Check length restriction.--->
    <cfelseif LEN(ARGUMENTS.patDescription) GT 2048>
    <cfset result.message = "The description is longer than 2048 characters, please enter a new description under 2048 characters.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    INSERT INTO tbl_product_attribute_type (patName,patDescription,patSort,patStatus) VALUES
    (
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#TRIM(ARGUMENTS.patName)#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#TRIM(ARGUMENTS.patDescription)#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.patSort#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.patStatus#">
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
    
    <cffunction name="setAttributeValueStandardization" access="public" returntype="struct">
    <cfargument name="valueString" type="string" required="yes" default="">
    <cfset result = StructNew()>
    <cfset result.valueString = ARGUMENTS.valueString>
    <cfset result.message = ''>
    <!---INITIAL CLEANUP.--->
    <!---Replace "" with "--->
	<cfset result.valueString = Replace(result.valueString, '""', '"', 'ALL')>
    <!---Replace '' with '--->
	<cfset result.valueString = Replace(result.valueString, "''", "'", 'ALL')>
    <!---Replace / with ' / '--->
	<cfset result.valueString = Replace(result.valueString, "/", " / ", 'ALL')>
    
    <!---START: STANDARD UOM--->
    
    <!---INCHES--->
    <cfif REFind("['^0-9]/g", result.valueString) NEQ 1>
    <!---Do not override " for example or quoted words.--->
	<!---Replace " with 'in.'--->
	<cfset result.valueString = Replace(result.valueString, ' " ', ' in. ', 'ALL')>
    <cfset result.valueString = Replace(result.valueString, ' "', ' in.', 'ALL')>
    <!---Replace numeric variances--->
    <cfloop index="i" from="0" to="9">
    <cfset result.valueString = Replace(result.valueString, '#i#"', '#i# in.', 'ALL')>
	<cfset result.valueString = Replace(result.valueString, '#i#" ', '#i# in. ', 'ALL')>
    <cfset result.valueString = Replace(result.valueString, '#i#in. ', '#i# in. ', 'ALL')>
    </cfloop>
    <!---Replace variances--->
    <cfset result.valueString = Replace(result.valueString, ' in ', ' in. ', 'ALL')>
    <cfset result.valueString = Replace(result.valueString, ' in', ' in.', 'ALL')>
	<cfset result.valueString = Replace(result.valueString, " ins ", " in. ", "ALL")>
    <cfset result.valueString = Replace(result.valueString, " ins", " in.", "ALL")>
	<cfset result.valueString = Replace(result.valueString, " inch ", " in. ", "ALL")>
    <cfset result.valueString = Replace(result.valueString, " inch", " in.", "ALL")>
    <cfset result.valueString = Replace(result.valueString, " inches ", " in. ", "ALL")>
    <cfset result.valueString = Replace(result.valueString, " inches", " in.", "ALL")>
    <cfset result.valueString = Replace(result.valueString, " In ", " in. ", "ALL")>
    <cfset result.valueString = Replace(result.valueString, " In", " in.", "ALL")>
    <cfset result.valueString = Replace(result.valueString, " Ins ", " in. ", "ALL")>
    <cfset result.valueString = Replace(result.valueString, " Ins", " in.", "ALL")>
    <cfset result.valueString = Replace(result.valueString, " Inch ", " in. ", "ALL")>
    <cfset result.valueString = Replace(result.valueString, " Inch", " in.", "ALL")>
    <cfset result.valueString = Replace(result.valueString, " Inches ", " in. ", "ALL")>
    <cfset result.valueString = Replace(result.valueString, " Inches", " in.", "ALL")>
    <cfset result.valueString = Replace(result.valueString, " INCH ", " in. ", "ALL")>
    <cfset result.valueString = Replace(result.valueString, " INCH", " in.", "ALL")>
    <cfset result.valueString = Replace(result.valueString, " INCHES ", " in. ", "ALL")>
    <cfset result.valueString = Replace(result.valueString, " INCHES", " in.", "ALL")>
    <!---Replace numeric variances--->
    <cfloop index="i" from="0" to="9">
    <cfset result.valueString = Replace(result.valueString, '#i#in', '#i# in.', 'ALL')>
	<cfset result.valueString = Replace(result.valueString, '#i#in ', '#i# in. ', 'ALL')>
    <cfset result.valueString = Replace(result.valueString, '#i#in. ', '#i# in. ', 'ALL')>
    <cfset result.valueString = Replace(result.valueString, '#i#ins', '#i# in.', 'ALL')>
	<cfset result.valueString = Replace(result.valueString, '#i#ins ', '#i# in. ', 'ALL')>
    <cfset result.valueString = Replace(result.valueString, '#i#ins. ', '#i# in. ', 'ALL')>
    <cfset result.valueString = Replace(result.valueString, '#i#inch', '#i# in.', 'ALL')>
	<cfset result.valueString = Replace(result.valueString, '#i#inch ', '#i# in. ', 'ALL')>
    <cfset result.valueString = Replace(result.valueString, '#i#inch. ', '#i# in. ', 'ALL')>
    <cfset result.valueString = Replace(result.valueString, '#i#inches', '#i# in.', 'ALL')>
	<cfset result.valueString = Replace(result.valueString, '#i#inches ', '#i# in. ', 'ALL')>
    <cfset result.valueString = Replace(result.valueString, '#i#inches. ', '#i# in. ', 'ALL')>
    <cfset result.valueString = Replace(result.valueString, '#i#Inch', '#i# in.', 'ALL')>
	<cfset result.valueString = Replace(result.valueString, '#i#Inch ', '#i# in. ', 'ALL')>
    <cfset result.valueString = Replace(result.valueString, '#i#Inch. ', '#i# in. ', 'ALL')>
    <cfset result.valueString = Replace(result.valueString, '#i#Inches', '#i# in.', 'ALL')>
	<cfset result.valueString = Replace(result.valueString, '#i#Inches ', '#i# in. ', 'ALL')>
    <cfset result.valueString = Replace(result.valueString, '#i#Inches. ', '#i# in. ', 'ALL')>
    <cfset result.valueString = Replace(result.valueString, '#i#In', '#i# in.', 'ALL')>
	<cfset result.valueString = Replace(result.valueString, '#i#In ', '#i# in. ', 'ALL')>
    <cfset result.valueString = Replace(result.valueString, '#i#In. ', '#i# in. ', 'ALL')>
    <cfset result.valueString = Replace(result.valueString, '#i#Ins', '#i# in.', 'ALL')>
	<cfset result.valueString = Replace(result.valueString, '#i#Ins ', '#i# in. ', 'ALL')>
    <cfset result.valueString = Replace(result.valueString, '#i#Ins. ', '#i# in. ', 'ALL')>
    <cfset result.valueString = Replace(result.valueString, '#i#IN', '#i# in.', 'ALL')>
	<cfset result.valueString = Replace(result.valueString, '#i#IN ', '#i# in. ', 'ALL')>
    <cfset result.valueString = Replace(result.valueString, '#i#IN. ', '#i# in. ', 'ALL')>
    <cfset result.valueString = Replace(result.valueString, '#i#INS', '#i# in.', 'ALL')>
	<cfset result.valueString = Replace(result.valueString, '#i#INS ', '#i# in. ', 'ALL')>
    <cfset result.valueString = Replace(result.valueString, '#i#INS. ', '#i# in. ', 'ALL')>
    <cfset result.valueString = Replace(result.valueString, '#i#INCHES', '#i# in.', 'ALL')>
	<cfset result.valueString = Replace(result.valueString, '#i#INCHES ', '#i# in. ', 'ALL')>
    <cfset result.valueString = Replace(result.valueString, '#i#INCHES. ', '#i# in. ', 'ALL')>
    </cfloop>
    </cfif>

    <!---FEET--->
    <!---Do not override "'s" for example or quoted words.--->
    <cfif REFind("['^0-9]/g", result.valueString) NEQ 1>
    <!---Replace variances--->
	<cfset result.valueString = Replace(result.valueString, " ' ", ' ft. ', 'ALL')>
    <cfset result.valueString = Replace(result.valueString, " '", ' ft.', 'ALL')>
    <!---Replace numeric variances.--->
    <cfloop index="i" from="0" to="9">
    <cfset result.valueString = Replace(result.valueString, "#i#'", "#i# ft.", 'ALL')>
	<cfset result.valueString = Replace(result.valueString, "#i#' ", "#i# ft. ", 'ALL')>
    <cfset result.valueString = Replace(result.valueString, "#i#ft. ", "#i# ft. ", 'ALL')>
    </cfloop>
    
    <!---Replace variances--->
	<cfset result.valueString = Replace(result.valueString, " feet ", " ft. ", "ALL")>
    <cfset result.valueString = Replace(result.valueString, " feet", " ft.", "ALL")>
    <cfset result.valueString = Replace(result.valueString, " Feet ", " ft. ", "ALL")>
    <cfset result.valueString = Replace(result.valueString, " Feet", " ft.", "ALL")>
    <cfset result.valueString = Replace(result.valueString, " FEET ", " ft. ", "ALL")>
    <cfset result.valueString = Replace(result.valueString, " FEET", " ft.", "ALL")>
    <cfset result.valueString = Replace(result.valueString, " foot ", " ft. ", "ALL")>
    <cfset result.valueString = Replace(result.valueString, " foot", " ft.", "ALL")>
    <cfset result.valueString = Replace(result.valueString, " Foot ", " ft. ", "ALL")>
    <cfset result.valueString = Replace(result.valueString, " Foot", " ft.", "ALL")>
    <cfset result.valueString = Replace(result.valueString, " FOOT ", " ft. ", "ALL")>
    <cfset result.valueString = Replace(result.valueString, " FOOT", " ft.", "ALL")>
	<cfset result.valueString = Replace(result.valueString, ' ft ', ' ft. ', 'ALL')>
    <cfset result.valueString = Replace(result.valueString, ' ft', ' ft.', 'ALL')>
    <cfset result.valueString = Replace(result.valueString, ' Ft ', ' ft. ', 'ALL')>
    <cfset result.valueString = Replace(result.valueString, ' Ft', ' ft.', 'ALL')>
    <!---Replace numeric variances.--->
    <cfloop index="i" from="0" to="9">

    <cfset result.valueString = Replace(result.valueString, '#i#ft', '#i# ft.', 'ALL')>
	<cfset result.valueString = Replace(result.valueString, '#i#ft ', '#i# ft. ', 'ALL')>
    <cfset result.valueString = Replace(result.valueString, '#i#ft. ', '#i# ft. ', 'ALL')>
    <cfset result.valueString = Replace(result.valueString, '#i#FT', '#i# ft.', 'ALL')>
	<cfset result.valueString = Replace(result.valueString, '#i#FT ', '#i# ft. ', 'ALL')>
    <cfset result.valueString = Replace(result.valueString, '#i#FT. ', '#i# ft. ', 'ALL')>
    <cfset result.valueString = Replace(result.valueString, '#i#Ft', '#i# ft.', 'ALL')>
	<cfset result.valueString = Replace(result.valueString, '#i#Ft ', '#i# ft. ', 'ALL')>
    <cfset result.valueString = Replace(result.valueString, '#i#Ft. ', '#i# ft. ', 'ALL')>
    <cfset result.valueString = Replace(result.valueString, '#i#Feet', '#i# ft.', 'ALL')>
	<cfset result.valueString = Replace(result.valueString, '#i#Feet ', '#i# ft. ', 'ALL')>
    <cfset result.valueString = Replace(result.valueString, '#i#Feet. ', '#i# ft. ', 'ALL')>
    <cfset result.valueString = Replace(result.valueString, '#i#FEET', '#i# ft.', 'ALL')>
	<cfset result.valueString = Replace(result.valueString, '#i#FEET ', '#i# ft. ', 'ALL')>
    <cfset result.valueString = Replace(result.valueString, '#i#FEET. ', '#i# ft. ', 'ALL')>
    <cfset result.valueString = Replace(result.valueString, '#i#Foot', '#i# ft.', 'ALL')>
	<cfset result.valueString = Replace(result.valueString, '#i#Foot ', '#i# ft. ', 'ALL')>
    <cfset result.valueString = Replace(result.valueString, '#i#Foot. ', '#i# ft. ', 'ALL')>
    <cfset result.valueString = Replace(result.valueString, '#i#FOOT', '#i# ft.', 'ALL')>
	<cfset result.valueString = Replace(result.valueString, '#i#FOOT ', '#i# ft. ', 'ALL')>
    <cfset result.valueString = Replace(result.valueString, '#i#FOOT. ', '#i# ft. ', 'ALL')>
    </cfloop>
    </cfif>
    
    <!---CUBIC--->
    <!---Replace variances--->
	<cfset result.valueString = Replace(result.valueString, " cubic ", " cu. ", "ALL")>
    <cfset result.valueString = Replace(result.valueString, " cubic", " cu.", "ALL")>
    <cfset result.valueString = Replace(result.valueString, " Cubic ", " cu. ", "ALL")>
    <cfset result.valueString = Replace(result.valueString, " Cubic", " cu.", "ALL")>
    <cfset result.valueString = Replace(result.valueString, " CUBIC ", " cu. ", "ALL")>
    <cfset result.valueString = Replace(result.valueString, " CUBIC", " cu.", "ALL")>
    
    <!---DOZEN--->
    <!---Replace variances--->
	<cfset result.valueString = Replace(result.valueString, " dozen ", " doz. ", "ALL")>
    <cfset result.valueString = Replace(result.valueString, " dozen", " dov.", "ALL")>
    <cfset result.valueString = Replace(result.valueString, " Dozen ", " doz. ", "ALL")>
    <cfset result.valueString = Replace(result.valueString, " Dozen", " doz.", "ALL")>
    <cfset result.valueString = Replace(result.valueString, " Doz ", " doz. ", "ALL")>
    <cfset result.valueString = Replace(result.valueString, " Doz", " doz.", "ALL")>
    <cfset result.valueString = Replace(result.valueString, " DOZEN ", " doz. ", "ALL")>
    <cfset result.valueString = Replace(result.valueString, " DOZEN", " doz.", "ALL")>
    <cfset result.valueString = Replace(result.valueString, " DOZ ", " doz. ", "ALL")>
    <cfset result.valueString = Replace(result.valueString, " DOZ", " doz.", "ALL")>
    
    <!---GALLON--->
    <!---Replace variances--->
	<cfset result.valueString = Replace(result.valueString, " gallon ", " gal. ", "ALL")>
    <cfset result.valueString = Replace(result.valueString, " gallon", " gal.", "ALL")>
    <cfset result.valueString = Replace(result.valueString, " Gallon ", " gal. ", "ALL")>
    <cfset result.valueString = Replace(result.valueString, " Gallon", " gal.", "ALL")>
    <cfset result.valueString = Replace(result.valueString, " Gal ", " gal. ", "ALL")>
    <cfset result.valueString = Replace(result.valueString, " Gal", " gal.", "ALL")>
    <cfset result.valueString = Replace(result.valueString, " GALLON ", " gal. ", "ALL")>
    <cfset result.valueString = Replace(result.valueString, " GALLON", " gal.", "ALL")>
    <cfset result.valueString = Replace(result.valueString, " GAL ", " gal. ", "ALL")>
    <cfset result.valueString = Replace(result.valueString, " GAL", " gal.", "ALL")>
    <cfset result.valueString = Replace(result.valueString, " G ", " gal. ", "ALL")>
    <cfset result.valueString = Replace(result.valueString, " G", " gal.", "ALL")>
    
    <!---GRAIN--->
    <!---Replace variances
	<cfset result.valueString = Replace(result.valueString, " grain ", " gr. ", "ALL")>
    <cfset result.valueString = Replace(result.valueString, " grain", " gr.", "ALL")>
    <cfset result.valueString = Replace(result.valueString, " Grain ", " gr. ", "ALL")>
    <cfset result.valueString = Replace(result.valueString, " Grain", " gr.", "ALL")>
    <cfset result.valueString = Replace(result.valueString, " Gr ", " gr. ", "ALL")>
    <cfset result.valueString = Replace(result.valueString, " Gr", " gr.", "ALL")>
    <cfset result.valueString = Replace(result.valueString, " gr ", " gr. ", "ALL")>
    <cfset result.valueString = Replace(result.valueString, " gr", " gr.", "ALL")>
    <cfset result.valueString = Replace(result.valueString, " GRAIN ", " gr. ", "ALL")>
    <cfset result.valueString = Replace(result.valueString, " GRAIN", " gr.", "ALL")>
    <cfset result.valueString = Replace(result.valueString, " GR ", " gr. ", "ALL")>
    <cfset result.valueString = Replace(result.valueString, " GR", " gr.", "ALL")>--->
    
    <!---POUNDS--->
    <!---Replace variances--->
	<cfset result.valueString = Replace(result.valueString, " lbs ", " lb. ", "ALL")>
    <cfset result.valueString = Replace(result.valueString, " lbs", " lb.", "ALL")>
    <cfset result.valueString = Replace(result.valueString, " Lbs ", " lb. ", "ALL")>
    <cfset result.valueString = Replace(result.valueString, " Lbs", " lb.", "ALL")>
    <cfset result.valueString = Replace(result.valueString, " LBS ", " lb. ", "ALL")>
    <cfset result.valueString = Replace(result.valueString, " LBS", " lb.", "ALL")>
    <cfset result.valueString = Replace(result.valueString, " pound ", " lb. ", "ALL")>
    <cfset result.valueString = Replace(result.valueString, " pound", " lb.", "ALL")>
    <cfset result.valueString = Replace(result.valueString, " pounds ", " lb. ", "ALL")>
    <cfset result.valueString = Replace(result.valueString, " pounds", " lb.", "ALL")>
	<cfset result.valueString = Replace(result.valueString, " lb ", " lb. ", "ALL")>
    <cfset result.valueString = Replace(result.valueString, " lb", " lb.", "ALL")>
    <cfset result.valueString = Replace(result.valueString, " Lb ", " lb. ", "ALL")>
    <cfset result.valueString = Replace(result.valueString, " Lb", " lb.", "ALL")>
    <cfset result.valueString = Replace(result.valueString, " LB ", " lb. ", "ALL")>
    <cfset result.valueString = Replace(result.valueString, " LB", " lb.", "ALL")>
    <!---Replace numeric variances--->
    <cfloop index="i" from="0" to="9">
    <cfset result.valueString = Replace(result.valueString, '#i#lb', '#i# lb.', 'ALL')>
	<cfset result.valueString = Replace(result.valueString, '#i#lb ', '#i# lb. ', 'ALL')>
    <cfset result.valueString = Replace(result.valueString, '#i#lb. ', '#i# lb. ', 'ALL')>
    <cfset result.valueString = Replace(result.valueString, '#i#Lb', '#i# lb.', 'ALL')>
	<cfset result.valueString = Replace(result.valueString, '#i#Lb ', '#i# lb. ', 'ALL')>
    <cfset result.valueString = Replace(result.valueString, '#i#Lb. ', '#i# lb. ', 'ALL')>
    <cfset result.valueString = Replace(result.valueString, '#i#Lbs', '#i# lb.', 'ALL')>
	<cfset result.valueString = Replace(result.valueString, '#i#Lbs ', '#i# lb. ', 'ALL')>
    <cfset result.valueString = Replace(result.valueString, '#i#Lbs. ', '#i# lb. ', 'ALL')>
    <cfset result.valueString = Replace(result.valueString, '#i#LBS', '#i# lb.', 'ALL')>
	<cfset result.valueString = Replace(result.valueString, '#i#LBS ', '#i# lb. ', 'ALL')>
    <cfset result.valueString = Replace(result.valueString, '#i#LBS. ', '#i# lb. ', 'ALL')>
    </cfloop>
    
    <!---OUNCES--->
    <!---Replace variances--->
	<cfset result.valueString = Replace(result.valueString, " oz ", " oz. ", "ALL")>
    <cfset result.valueString = Replace(result.valueString, " oz", " oz.", "ALL")>
    <cfset result.valueString = Replace(result.valueString, " ounce ", " oz. ", "ALL")>
    <cfset result.valueString = Replace(result.valueString, " ounce", " oz.", "ALL")>
    <cfset result.valueString = Replace(result.valueString, " Ounce ", " oz. ", "ALL")>
    <cfset result.valueString = Replace(result.valueString, " Ounce", " oz.", "ALL")>
    <cfset result.valueString = Replace(result.valueString, " OUNCE ", " oz. ", "ALL")>
    <cfset result.valueString = Replace(result.valueString, " OUNCE", " oz.", "ALL")>
    <cfset result.valueString = Replace(result.valueString, " OZ ", " oz. ", "ALL")>
    <cfset result.valueString = Replace(result.valueString, " OZ", " oz.", "ALL")>
    <cfset result.valueString = Replace(result.valueString, " Oz ", " oz. ", "ALL")>
    <cfset result.valueString = Replace(result.valueString, " Oz", " oz.", "ALL")>
    <!---Replace numeric variances--->
    <cfloop index="i" from="0" to="9">
    <cfset result.valueString = Replace(result.valueString, '#i#oz', '#i# oz.', 'ALL')>
	<cfset result.valueString = Replace(result.valueString, '#i#oz ', '#i# oz. ', 'ALL')>
    <cfset result.valueString = Replace(result.valueString, '#i#oz. ', '#i# oz. ', 'ALL')>
    <cfset result.valueString = Replace(result.valueString, '#i#OZ', '#i# oz.', 'ALL')>
	<cfset result.valueString = Replace(result.valueString, '#i#OZ ', '#i# oz. ', 'ALL')>
    <cfset result.valueString = Replace(result.valueString, '#i#OZ. ', '#i# oz. ', 'ALL')>
    <cfset result.valueString = Replace(result.valueString, '#i#Oz', '#i# oz.', 'ALL')>
	<cfset result.valueString = Replace(result.valueString, '#i#Oz ', '#i# oz. ', 'ALL')>
    <cfset result.valueString = Replace(result.valueString, '#i#Oz. ', '#i# oz. ', 'ALL')>
    </cfloop>
    
    <!---PINT--->
    <!---Replace variances--->
	<cfset result.valueString = Replace(result.valueString, " pint ", " pt. ", "ALL")>
    <cfset result.valueString = Replace(result.valueString, " pint", " pt.", "ALL")>
    <cfset result.valueString = Replace(result.valueString, " Pint ", " pt. ", "ALL")>
    <cfset result.valueString = Replace(result.valueString, " Pint", " pt.", "ALL")>
    <cfset result.valueString = Replace(result.valueString, " Pt ", " pt. ", "ALL")>
    <cfset result.valueString = Replace(result.valueString, " Pt", " pt.", "ALL")>
    <cfset result.valueString = Replace(result.valueString, " pt ", " pt. ", "ALL")>
    <cfset result.valueString = Replace(result.valueString, " pt", " pt.", "ALL")>
    <cfset result.valueString = Replace(result.valueString, " PINT ", " pt. ", "ALL")>
    <cfset result.valueString = Replace(result.valueString, " PINT", " pt.", "ALL")>
    <cfset result.valueString = Replace(result.valueString, " PT ", " pt. ", "ALL")>
    <cfset result.valueString = Replace(result.valueString, " PT", " pt.", "ALL")>
    
    <!---QUART--->
    <!---Replace variances--->
	<cfset result.valueString = Replace(result.valueString, " quart ", " qt. ", "ALL")>
    <cfset result.valueString = Replace(result.valueString, " quart", " qt.", "ALL")>
    <cfset result.valueString = Replace(result.valueString, " Quart ", " qt. ", "ALL")>
    <cfset result.valueString = Replace(result.valueString, " Quart", " qt.", "ALL")>
    <cfset result.valueString = Replace(result.valueString, " Qt ", " qt. ", "ALL")>
    <cfset result.valueString = Replace(result.valueString, " Qt", " qt.", "ALL")>
    <cfset result.valueString = Replace(result.valueString, " qt ", " qt. ", "ALL")>
    <cfset result.valueString = Replace(result.valueString, " qt", " qt.", "ALL")>
    <cfset result.valueString = Replace(result.valueString, " QUART ", " qt. ", "ALL")>
    <cfset result.valueString = Replace(result.valueString, " QUART", " qt.", "ALL")>
    <cfset result.valueString = Replace(result.valueString, " QT ", " qt. ", "ALL")>
    <cfset result.valueString = Replace(result.valueString, " QT", " qt.", "ALL")>
    
    <!---SQUARE--->
    <!---Replace variances--->
	<cfset result.valueString = Replace(result.valueString, " square ", " sq. ", "ALL")>
    <cfset result.valueString = Replace(result.valueString, " square", " sq.", "ALL")>
    <cfset result.valueString = Replace(result.valueString, " Square ", " sq. ", "ALL")>
    <cfset result.valueString = Replace(result.valueString, " Square", " sq.", "ALL")>
    <cfset result.valueString = Replace(result.valueString, " Sq ", " sq. ", "ALL")>
    <cfset result.valueString = Replace(result.valueString, " Sq", " sq.", "ALL")>
    <cfset result.valueString = Replace(result.valueString, " sq ", " sq. ", "ALL")>
    <cfset result.valueString = Replace(result.valueString, " sq", " sq.", "ALL")>
    <cfset result.valueString = Replace(result.valueString, " SQUARE ", " sq. ", "ALL")>
    <cfset result.valueString = Replace(result.valueString, " SQUARE", " sq.", "ALL")>
    <cfset result.valueString = Replace(result.valueString, " SQ ", " sq. ", "ALL")>
    <cfset result.valueString = Replace(result.valueString, " SQ", " sq.", "ALL")>
    
    <!---RPM--->
    <!---Replace variances--->
    <cfset result.valueString = Replace(result.valueString, " RPM ", " rpm ", "ALL")>
    <cfset result.valueString = Replace(result.valueString, " RPM", " rpm", "ALL")>
    
    <!---MPH--->
    <!---Replace variances--->
    <cfset result.valueString = Replace(result.valueString, " MPH ", " mph ", "ALL")>
    <cfset result.valueString = Replace(result.valueString, " MPH", " mph", "ALL")>
    
    <!---FPS--->
    <!---Replace variances--->
    <cfset result.valueString = Replace(result.valueString, " FPS ", " fps ", "ALL")>
    <cfset result.valueString = Replace(result.valueString, " FPS", " fps", "ALL")>
    
    <!---YARDS--->
    <!---Replace variances--->
	<cfset result.valueString = Replace(result.valueString, " yds ", " yd. ", "ALL")>
    <cfset result.valueString = Replace(result.valueString, " yds", " yd.", "ALL")>
    <cfset result.valueString = Replace(result.valueString, " yrds ", " yd. ", "ALL")>
    <cfset result.valueString = Replace(result.valueString, " yrds", " yd.", "ALL")>
	<cfset result.valueString = Replace(result.valueString, " yard ", " yd. ", "ALL")>
    <cfset result.valueString = Replace(result.valueString, " yard", " yd.", "ALL")>
    <cfset result.valueString = Replace(result.valueString, " yards ", " yd. ", "ALL")>
    <cfset result.valueString = Replace(result.valueString, " yards", " yd.", "ALL")>
    <cfset result.valueString = Replace(result.valueString, " Yards ", " yd. ", "ALL")>
    <cfset result.valueString = Replace(result.valueString, " Yards", " yd.", "ALL")>
    <cfset result.valueString = Replace(result.valueString, " YARDS ", " yd. ", "ALL")>
    <cfset result.valueString = Replace(result.valueString, " YARDS", " yd.", "ALL")>
	<cfset result.valueString = Replace(result.valueString, " yd ", " yd. ", "ALL")>
    <cfset result.valueString = Replace(result.valueString, " yd", " yd.", "ALL")>
    <!---Replace numeric variances--->
    <cfloop index="i" from="0" to="9">
    <cfset result.valueString = Replace(result.valueString, '#i#yd', '#i# yd.', 'ALL')>
	<cfset result.valueString = Replace(result.valueString, '#i#yd ', '#i# yd. ', 'ALL')>
    <cfset result.valueString = Replace(result.valueString, '#i#yd. ', '#i# yd. ', 'ALL')>
    </cfloop>
    
    <!---END: STANDARD UOM--->
    
    <!---START: METRIC UOM--->
    
    <!---MILLIMETERS.--->
    <!---Replace variances--->
	<cfset result.valueString = Replace(result.valueString, " mm ", " mm. ", "ALL")>
    <cfset result.valueString = Replace(result.valueString, " mm", " mm.", "ALL")>
    <cfset result.valueString = Replace(result.valueString, " MM ", " mm. ", "ALL")>
    <cfset result.valueString = Replace(result.valueString, " MM", " mm.", "ALL")>
    <!---Replace numeric variances--->
    <cfloop index="i" from="0" to="9">
    <cfset result.valueString = Replace(result.valueString, '#i#mm', '#i# mm.', 'ALL')>
	<cfset result.valueString = Replace(result.valueString, '#i#mm ', '#i# mm. ', 'ALL')>
    <cfset result.valueString = Replace(result.valueString, '#i#mm. ', '#i# mm. ', 'ALL')>
    <cfset result.valueString = Replace(result.valueString, '#i#MM', '#i# mm.', 'ALL')>
	<cfset result.valueString = Replace(result.valueString, '#i#MM ', '#i# mm. ', 'ALL')>
    <cfset result.valueString = Replace(result.valueString, '#i#MM. ', '#i# mm. ', 'ALL')>
    </cfloop>
    
    <!---CENTIMETER--->
    <!---Replace variances--->
	<cfset result.valueString = Replace(result.valueString, " cm ", " cm. ", "ALL")>
    <cfset result.valueString = Replace(result.valueString, " cm", " cm.", "ALL")>
    <cfset result.valueString = Replace(result.valueString, " CM ", " cm. ", "ALL")>
    <cfset result.valueString = Replace(result.valueString, " CM", " cm.", "ALL")>
    <!---Replace numeric variances--->
    <cfloop index="i" from="0" to="9">
    <cfset result.valueString = Replace(result.valueString, '#i#cm', '#i# cm.', 'ALL')>
	<cfset result.valueString = Replace(result.valueString, '#i#cm ', '#i# cm. ', 'ALL')>
    <cfset result.valueString = Replace(result.valueString, '#i#cm. ', '#i# cm. ', 'ALL')>
    <cfset result.valueString = Replace(result.valueString, '#i#CM', '#i# cm.', 'ALL')>
	<cfset result.valueString = Replace(result.valueString, '#i#CM ', '#i# cm. ', 'ALL')>
    <cfset result.valueString = Replace(result.valueString, '#i#CM. ', '#i# cm. ', 'ALL')>
    </cfloop>
    
    <!---MILLILITER--->
    <!---Replace variances--->
	<cfset result.valueString = Replace(result.valueString, " ml ", " ml. ", "ALL")>
    <cfset result.valueString = Replace(result.valueString, " ml", " ml.", "ALL")>
    <cfset result.valueString = Replace(result.valueString, " ML ", " ml. ", "ALL")>
    <cfset result.valueString = Replace(result.valueString, " ML", " ml.", "ALL")>
    <!---Replace numeric variances--->
    <cfloop index="i" from="0" to="9">
    <cfset result.valueString = Replace(result.valueString, '#i#ml', '#i# ml.', 'ALL')>
	<cfset result.valueString = Replace(result.valueString, '#i#ml ', '#i# ml. ', 'ALL')>
    <cfset result.valueString = Replace(result.valueString, '#i#ml. ', '#i# ml. ', 'ALL')>
    <cfset result.valueString = Replace(result.valueString, '#i#ML', '#i# ml.', 'ALL')>
	<cfset result.valueString = Replace(result.valueString, '#i#ML ', '#i# ml. ', 'ALL')>
    <cfset result.valueString = Replace(result.valueString, '#i#ML. ', '#i# ml. ', 'ALL')>
    </cfloop>
    
    <!---GRAM--->
    <!---Replace variances--->
	<cfset result.valueString = Replace(result.valueString, " gram ", " g. ", "ALL")>
    <cfset result.valueString = Replace(result.valueString, " gram", " g.", "ALL")>
    <cfset result.valueString = Replace(result.valueString, " Gram ", " g. ", "ALL")>
    <cfset result.valueString = Replace(result.valueString, " Gram", " g.", "ALL")>
    <cfset result.valueString = Replace(result.valueString, " Gr ", " g. ", "ALL")>
    <cfset result.valueString = Replace(result.valueString, " Gr", " g.", "ALL")>
    <cfset result.valueString = Replace(result.valueString, " gr ", " g. ", "ALL")>
    <cfset result.valueString = Replace(result.valueString, " gr", " g.", "ALL")>
    <cfset result.valueString = Replace(result.valueString, " GRAM ", " g. ", "ALL")>
    <cfset result.valueString = Replace(result.valueString, " GRAM", " g.", "ALL")>
    <cfset result.valueString = Replace(result.valueString, " GR ", " g. ", "ALL")>
    <cfset result.valueString = Replace(result.valueString, " GR", " g.", "ALL")>
    
    <!---KILOBYTE--->
    <!---Replace variances--->
	<cfset result.valueString = Replace(result.valueString, " kb ", " KB ", "ALL")>
    <cfset result.valueString = Replace(result.valueString, " kb", " KB", "ALL")>
    <cfset result.valueString = Replace(result.valueString, " Kb ", " KB ", "ALL")>
    <cfset result.valueString = Replace(result.valueString, " Kb", " KB", "ALL")>
    
    <!---MEGABYTE--->
    <!---Replace variances--->
	<cfset result.valueString = Replace(result.valueString, " mb ", " MB ", "ALL")>
    <cfset result.valueString = Replace(result.valueString, " mb", " MB", "ALL")>
    <cfset result.valueString = Replace(result.valueString, " Mb ", " MB ", "ALL")>
    <cfset result.valueString = Replace(result.valueString, " Mb", " MB", "ALL")>
    
    <!---GIGABYTE--->
    <!---Replace variances--->
	<cfset result.valueString = Replace(result.valueString, " gb ", " GB ", "ALL")>
    <cfset result.valueString = Replace(result.valueString, " gb", " GB", "ALL")>
    <cfset result.valueString = Replace(result.valueString, " Gb ", " GB ", "ALL")>
    <cfset result.valueString = Replace(result.valueString, " Gb", " GB", "ALL")>
    
    <!---WATT--->
    <!---Replace variances--->
	<cfset result.valueString = Replace(result.valueString, " watt ", " W ", "ALL")>
    <cfset result.valueString = Replace(result.valueString, " watt", " W", "ALL")>
    <cfset result.valueString = Replace(result.valueString, " Watt ", " W ", "ALL")>
    <cfset result.valueString = Replace(result.valueString, " Watt", " W", "ALL")>
    <cfset result.valueString = Replace(result.valueString, " WATT ", " W ", "ALL")>
    <cfset result.valueString = Replace(result.valueString, " WATT", " W", "ALL")>
    
    <!---END: METRIC UOM--->
    
    <!---START: SPECIAL CHARACTERS--->
    
    <!---X--->
    <!---Replace x with X--->
	<cfset result.valueString = Replace(result.valueString, " x ", " X ", "ALL")>
    <cfset result.valueString = Replace(result.valueString, ".x", ". X ", "ALL")>
    
    
    <!---Replace '  ' with ' '--->
	<cfset result.valueString = Replace(result.valueString, "  ", " ", "ALL")>
    <!---Replace '..' with '.'--->
	<cfset result.valueString = Replace(result.valueString, "..", ".", "ALL")>
    <!---Replace all other special character variances.--->
    <cfset result.valueString = Replace(result.valueString, "!", "", "ALL")>
    <cfset result.valueString = Replace(result.valueString, "?", "", "ALL")>
    <cfset result.valueString = Replace(result.valueString, "##", "No.", "ALL")>
    <cfset result.valueString = Replace(result.valueString, "^", "", "ALL")>
    <cfset result.valueString = Replace(result.valueString, "&", "and", "ALL")>
    <cfset result.valueString = Replace(result.valueString, ";", "", "ALL")>
    <cfset result.valueString = Replace(result.valueString, "*", "", "ALL")>
    <cfset result.valueString = Replace(result.valueString, "~", "", "ALL")>
    <cfset result.valueString = Replace(result.valueString, "`", "", "ALL")>
    <cfset result.valueString = Replace(result.valueString, "{", "", "ALL")>
    <cfset result.valueString = Replace(result.valueString, "}", "", "ALL")>
    <cfset result.valueString = Replace(result.valueString, "[", "", "ALL")>
    <cfset result.valueString = Replace(result.valueString, "]", "", "ALL")>
    <cfset result.valueString = Replace(result.valueString, "\", "/", "ALL")>
    <cfset result.valueString = Replace(result.valueString, "<", "", "ALL")>
    <cfset result.valueString = Replace(result.valueString, ">", "", "ALL")>
    
    <!---END: SPECIAL CHARACTERS--->
    
    <!---Trim the result.valueString.--->
	<cfset result.valueString = TRIM(result.valueString)>
    
    <!---Notify that a change has been performed.--->
    <cfif result.valueString NEQ ARGUMENTS.valueString>
    <cfset result.message = 'A change occured to the attribute value <u>#ARGUMENTS.valueString#</u>. It was changed to <u>#result.valueString#</u>.'>
    </cfif>
    
    <cfreturn result>
    </cffunction>
    
    <cffunction name="insertProductAttributeValue" access="public" returntype="struct">
    <cfargument name="paID" type="numeric" required="yes">
    <cfargument name="pavValue" type="string" required="yes">
    <cfargument name="pavCode" type="string" required="yes">
    <cfargument name="pavERPCode" type="string" required="yes">
    <cfargument name="pavPOSCode" type="string" required="yes">
    <cfargument name="imgID" type="numeric" required="yes">
    <cfargument name="pavSort" type="numeric" required="yes">
    <cfargument name="pavStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully inserted the record.">
    <cftry>
    <!---First standardize the value.
    <cfinvoke 
    component="MCMS.component.app.product.Product"
    method="setAttributeValueStandardization"
    returnvariable="setAttributeValueStandardizationRet">
    <cfinvokeargument name="valueString" value="#ARGUMENTS.pavValue#"/>
    </cfinvoke>
    <cfset ARGUMENTS.pavValue = setAttributeValueStandardizationRet.valueString>
	--->
    <!---Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.app.product.Product"
    method="getProductAttributeValue"
    returnvariable="getCheckProductAttributeValueRet">
    <cfinvokeargument name="paID" value="#ARGUMENTS.paID#"/>
    <cfinvokeargument name="pavValue" value="#TRIM(ARGUMENTS.pavValue)#"/>
    <cfinvokeargument name="pavStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckProductAttributeValueRet.recordcount NEQ 0>
    <cfset result.message = "The value #TRIM(ARGUMENTS.pavValue)# already exists for this attribute, please enter a new value.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    INSERT INTO tbl_product_attribute_value (paID,pavValue,pavCode,pavERPCode,pavPOSCode,imgID,userID,pavSort,pavStatus) VALUES
    (
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.paID#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#TRIM(ARGUMENTS.pavValue)#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#TRIM(ARGUMENTS.pavCode)#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#TRIM(ARGUMENTS.pavERPCode)#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#TRIM(ARGUMENTS.pavPOSCode)#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.imgID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#session.userID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.pavSort#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.pavStatus#">
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
    
    <cffunction name="setProductWarning" access="public" returntype="string" hint="Set the Product Warning.">
    <cfargument name="pID" type="numeric" required="yes" default="0">
    <cfargument name="type" type="string" required="yes" default="due">
    <cfset var setProductWarning = "">
    <cftry>
    <cfsilent>
    <cfinvoke 
    component="MCMS.component.app.product.Product" 
    method="getProduct" 
    returnvariable="getProductRet">
    <cfinvokeargument name="ID" value="#ARGUMENTS.pID#">
    <cfinvokeargument name="pStatus" value="1,2,3">
    </cfinvoke>
    </cfsilent>
    <cfsavecontent variable="setProductWarning">
    <cfprocessingdirective suppresswhitespace="yes">
    <cfswitch expression="#ARGUMENTS.type#">
    <cfcase value="due">
    <cfset dueDateMessage = ''>
    <cfif getProductRet.pDateRel LT DateAdd('d',0,Now()) AND getProductRet.pesID EQ 101 AND getProductRet.pStatus NEQ 1>
    <cfset dueDateMessage = "This products release date is #DateFormat(getProductRet.pDateRel, application.dateFormat)#!<br/>Please complete the product configuration, switch it's status to 'Active', or change it's release date.">
    <div id="warning">
    <span class='glyphicon glyphicon-exclamation-sign'></span><br />
    <cfoutput>#dueDateMessage#</cfoutput>
    </div>
    <cfelseif DateAdd('d',7,Now()) GT getProductRet.pDateRel AND getProductRet.pesID EQ 101 AND getProductRet.pStatus NEQ 1>
    <cfset dueDate = DateDiff('d', DateAdd('d',0,Now()), getProductRet.pDateRel)>
    <cfset dueDateMessage = "This products release date is in #dueDate# day(s)!<br/>Please complete the product configuration, switch it's status to 'Active', or change it's release date.">
    <div id="warning">
    <span class='glyphicon glyphicon-alert'></span><br />
    <cfoutput>#dueDateMessage#</cfoutput>
    </div>
    </cfif>
    </cfcase>
    <cfcase value="icon">
    <cfif getProductRet.pDateRel LT DateAdd('d',0,Now()) AND getProductRet.pesID EQ 101 AND getProductRet.pStatus NEQ 1>
    <span class='glyphicon glyphicon-exclamation-sign'></span>
    <cfelseif DateAdd('d',7,Now()) GT getProductRet.pDateRel AND getProductRet.pesID EQ 101 AND getProductRet.pStatus NEQ 1>
    <span class='glyphicon glyphicon-alert'></span>
    <cfelse>
    <span class="glyphicon glyphicon-check"></span>
    </cfif>
    </cfcase>
    <cfdefaultcase></cfdefaultcase>
    </cfswitch>
    </cfprocessingdirective>
    </cfsavecontent>
    <!---Catch any errors.--->
    <cfcatch type="any">
    There was an error with the function.
    <cfdump var="#CFCATCH#">
    </cfcatch>
    </cftry>
    <cfreturn setProductWarning>
    </cffunction>
    
    <cffunction name="setProductRatingStar" access="public" returntype="string" hint="Set the Product Rating star and average.">
    <cfargument name="pID" type="numeric" required="yes" default="0">
    <cfargument name="type" type="string" required="yes" default="average">
    <cfargument name="prrStatus" type="string" required="yes" default="1,3">
    <cfset var setProductRatingStar = "">
    <cfset var rsProductRatingStar = "">
    <cftry>
    <!---Display average or single rating based on type.--->
    <cfif ARGUMENTS.type EQ "average">
    <cfquery name="rsProductRatingStar" datasource="#application.mcmsDSN#">
    SELECT AVG(prrValue) AS prrValue FROM v_product_rating_rel WHERE 0=0
    AND pID = <cfqueryparam value="#ARGUMENTS.pID#" cfsqltype="cf_sql_integer">
    AND prrStatus =  <cfqueryparam value="#ARGUMENTS.prrStatus#" cfsqltype="cf_sql_integer">
    </cfquery>
    <cfelse>
    <cfquery name="rsProductRatingStar" datasource="#application.mcmsDSN#">
    SELECT prrValue FROM v_product_rating_rel WHERE 0=0
    AND pID = <cfqueryparam value="#ARGUMENTS.pID#" cfsqltype="cf_sql_integer">
    AND prrStatus =  <cfqueryparam value="#ARGUMENTS.prrStatus#" cfsqltype="cf_sql_integer">
    </cfquery>
    </cfif>
    <cfif rsProductRatingStar.prrValue NEQ "">
    <cfset this.prrValue = Round(rsProductRatingStar.prrValue)>
    <cfelseif rsProductRatingStar.prrValue EQ "">
    <cfset this.prrValue = "">
    <cfelse>
    <cfset this.prrValue = 0>
    </cfif>
    <cfsavecontent variable="setProductRatingStar">
    <cfprocessingdirective suppresswhitespace="yes">
    <cfoutput>
    <strong>
    <cfswitch expression="#this.prrValue#">
    <cfcase value="0">
    <img src="//#CGI.SERVER_NAME#/images/icon/rating_star_none.gif" alt="rating" name="rating" width="75" hspace="5" vspace="0" align="absmiddle" id="productRatingStar" /> #NumberFormat(rsProductRatingStar.prrValue, '_._')# out of 5
    </cfcase>
    <cfcase value="1">
    <img src="//#CGI.SERVER_NAME#/images/icon/rating_star_one.gif" alt="rating" name="rating" width="75" hspace="5" vspace="0" align="absmiddle" id="productRatingStar" /> #NumberFormat(rsProductRatingStar.prrValue, '_._')# out of 5
    </cfcase>
    <cfcase value="2">
    <img src="//#CGI.SERVER_NAME#/images/icon/rating_star_two.gif" alt="rating" name="rating" width="75" hspace="5" vspace="0" align="absmiddle" id="productRatingStar" /> #NumberFormat(rsProductRatingStar.prrValue, '_._')# out of 5
    </cfcase>
    <cfcase value="3">
    <img src="//#CGI.SERVER_NAME#/images/icon/rating_star_three.gif" alt="rating" name="rating" width="75" hspace="5" vspace="0" align="absmiddle" id="productRatingStar" /> #NumberFormat(rsProductRatingStar.prrValue, '_._')# out of 5
    </cfcase>
    <cfcase value="4">
    <img src="//#CGI.SERVER_NAME#/images/icon/rating_star_four.gif" alt="rating" name="rating" width="75" hspace="5" vspace="0" align="absmiddle" id="productRatingStar" /> #NumberFormat(rsProductRatingStar.prrValue, '_._')# out of 5
    </cfcase>
    <cfcase value="5">
    <img src="//#CGI.SERVER_NAME#/images/icon/rating_star_five.gif" alt="rating" name="rating" width="75" hspace="5" vspace="0" align="absmiddle" id="productRatingStar" /> #NumberFormat(rsProductRatingStar.prrValue, '_._')# out of 5
    </cfcase>
    </cfswitch>
    </strong>
    </cfoutput>
    </cfprocessingdirective>
    </cfsavecontent>
    <!---Catch any errors.--->
    <cfcatch type="any">
    There was an error with the function.
    <cfdump var="#CFCATCH#">
    </cfcatch>
    </cftry>
    <cfreturn setProductRatingStar>
    </cffunction>
    
    <cffunction name="setProductCategory" access="public" returntype="struct" hint="A special method to control product category relationships.">
    <cfargument name="pID" type="numeric" required="yes">
    <cfargument name="cID" type="string" required="yes" hint="Catalog Relationship List.">
    <cfargument name="catIDList" type="string" required="yes" hint="Category List.">
    <cfargument name="scatIDList" type="string" required="yes" hint="Secondary Category List.">
    <cfargument name="lcatIDList" type="string" required="yes" hint="Line Category List.">
    <cfargument name="slcatIDList" type="string" required="yes" hint="Secondary Line Category List.">
    <cfset result.message = "You have successfully updated the record(s).">
    <cftry>
    <!---Insert Product Category Relationships.--->
    <cfloop index="catalogID" from="1" to="#ListLen(ARGUMENTS.cID)#">
    <!---Begin with Categories.--->
    <!---Delete any relationships that are 0.--->
    <cfif ARGUMENTS.catIDList EQ 0>
    <cfinvoke 
    component="MCMS.component.app.product.Product"
    method="deleteProductCategoryRel">
    <cfinvokeargument name="pID" value="#ARGUMENTS.pID#"/>
    <cfinvokeargument name="cID" value="#ListGetAt(ARGUMENTS.cID, catalogID)#"/>
    </cfinvoke>
    </cfif>
    <cfloop index="catID" from="1" to="#ListLen(ARGUMENTS.catIDList)#">
    <!---First Remove any existing relationships.--->
    <cfinvoke 
    component="MCMS.component.app.product.Product"
    method="deleteProductCategoryRel">
    <cfinvokeargument name="pID" value="#ARGUMENTS.pID#"/>
    <cfinvokeargument name="cID" value="#ListGetAt(ARGUMENTS.cID, catalogID)#"/>
    </cfinvoke>
    <!---Insert Category relationships.--->
    <cfinvoke 
    component="MCMS.component.app.product.Product"
    method="insertProductCategoryRel">
    <cfinvokeargument name="pID" value="#ARGUMENTS.pID#"/>
    <cfinvokeargument name="cID" value="#ListGetAt(ARGUMENTS.cID, catalogID)#"/>
    <cfinvokeargument name="catID" value="#ListGetAt(ARGUMENTS.catIDList, catID)#"/>
    <cfinvokeargument name="pcrStatus" value="1"/>
    </cfinvoke>
    </cfloop>
    <!---Now Secondary Categories.--->
    <!---Delete any relationships that are 0.--->
    <cfif ARGUMENTS.scatIDList EQ 0>
    <cfinvoke 
    component="MCMS.component.app.product.Product"
    method="deleteProductSecondaryCategoryRel">
    <cfinvokeargument name="pID" value="#ARGUMENTS.pID#"/>
    <cfinvokeargument name="cID" value="#ListGetAt(ARGUMENTS.cID, catalogID)#"/>
    </cfinvoke>
    </cfif>
    <cfloop index="scatID" from="1" to="#ListLen(ARGUMENTS.scatIDList)#">
    <!---First Remove any existing relationships.--->
    <cfinvoke 
    component="MCMS.component.app.product.Product"
    method="deleteProductSecondaryCategoryRel">
    <cfinvokeargument name="pID" value="#ARGUMENTS.pID#"/>
    <cfinvokeargument name="cID" value="#ListGetAt(ARGUMENTS.cID, catalogID)#"/>
    </cfinvoke>
    <!---Insert Secondary Category relationships.--->
    <cfinvoke 
    component="MCMS.component.app.product.Product"
    method="insertProductSecondaryCategoryRel">
    <cfinvokeargument name="pID" value="#ARGUMENTS.pID#"/>
    <cfinvokeargument name="cID" value="#ListGetAt(ARGUMENTS.cID, catalogID)#"/>
    <cfinvokeargument name="scatID" value="#ListGetAt(ARGUMENTS.scatIDList, scatID)#"/>
    <cfinvokeargument name="pscrStatus" value="1"/>
    </cfinvoke>
    </cfloop>
    <!---Now Line Categories.--->
    <!---Delete any relationships that are 0.--->
    <cfif ARGUMENTS.lcatIDList EQ 0>
    <cfinvoke 
    component="MCMS.component.app.product.Product"
    method="deleteProductLineCategoryRel">
    <cfinvokeargument name="pID" value="#ARGUMENTS.pID#"/>
    <cfinvokeargument name="cID" value="#ListGetAt(ARGUMENTS.cID, catalogID)#"/>
    </cfinvoke>
    </cfif>
    <cfif ARGUMENTS.lcatIDList NEQ 0>
    <cfloop index="lcatID" from="1" to="#ListLen(ARGUMENTS.lcatIDList)#">
    <!---First Remove any existing relationships.--->
    <cfinvoke 
    component="MCMS.component.app.product.Product"
    method="deleteProductLineCategoryRel">
    <cfinvokeargument name="pID" value="#ARGUMENTS.pID#"/>
    <cfinvokeargument name="cID" value="#ListGetAt(ARGUMENTS.cID, catalogID)#"/>
    </cfinvoke>
    <!---Insert Category relationships.--->
    <cfinvoke 
    component="MCMS.component.app.product.Product"
    method="insertProductLineCategoryRel">
    <cfinvokeargument name="pID" value="#ARGUMENTS.pID#"/>
    <cfinvokeargument name="cID" value="#ListGetAt(ARGUMENTS.cID, catalogID)#"/>
    <cfinvokeargument name="lcatID" value="#ListGetAt(ARGUMENTS.lcatIDList, lcatID)#"/>
    <cfinvokeargument name="plcrStatus" value="1"/>
    </cfinvoke>
    </cfloop>
    </cfif>
    <!---Now Sec. Line Categories.--->
    <!---Delete any relationships that are 0.--->
    <cfif ARGUMENTS.slcatIDList EQ 0>
    <cfinvoke 
    component="MCMS.component.app.product.Product"
    method="deleteProductSecondaryLineCategoryRel">
    <cfinvokeargument name="pID" value="#ARGUMENTS.pID#"/>
    <cfinvokeargument name="cID" value="#ListGetAt(ARGUMENTS.cID, catalogID)#"/>
    </cfinvoke>
    </cfif>
    <cfif ARGUMENTS.slcatIDList NEQ 0>
    <cfloop index="slcatID" from="1" to="#ListLen(ARGUMENTS.slcatIDList)#">
    <!---First Remove any existing relationships.--->
    <cfinvoke 
    component="MCMS.component.app.product.Product"
    method="deleteProductSecondaryLineCategoryRel">
    <cfinvokeargument name="pID" value="#ARGUMENTS.pID#"/>
    <cfinvokeargument name="cID" value="#ListGetAt(ARGUMENTS.cID, catalogID)#"/>
    </cfinvoke>
    <!---Insert Category relationships.--->
    <cfinvoke 
    component="MCMS.component.app.product.Product"
    method="insertProductSecondaryLineCategoryRel">
    <cfinvokeargument name="pID" value="#ARGUMENTS.pID#"/>
    <cfinvokeargument name="cID" value="#ListGetAt(ARGUMENTS.cID, catalogID)#"/>
    <cfinvokeargument name="slcatID" value="#ListGetAt(ARGUMENTS.slcatIDList, slcatID)#"/>
    <cfinvokeargument name="pslcrStatus" value="1"/>
    </cfinvoke>
    </cfloop>
    </cfif>
    </cfloop>
    <cfcatch type="any">
    <cfset result.message = "There was an error inserting the record.">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="insertProductImageRel" access="public" returntype="struct">
    <cfargument name="pID" type="numeric" required="yes">
    <cfargument name="imgID" type="numeric" required="yes">
    <cfargument name="pirPrimaryImage" type="numeric" required="yes">
    <cfargument name="pirSort" type="numeric" required="yes">
    <cfargument name="pirStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully inserted the record.">
    <cftry>
    <!---Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.app.product.Product"
    method="getProductImageRel"
    returnvariable="getCheckProductImageRelRet">
    <cfinvokeargument name="pID" value="#ARGUMENTS.pID#"/>
    <cfinvokeargument name="imgID" value="#ARGUMENTS.imgID#"/>
    <cfinvokeargument name="pirStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckProductImageRelRet.recordcount NEQ 0>
    <cfset result.message = "The product already has this image relationship, please select another image.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    INSERT INTO tbl_product_image_rel (pID,imgID,pirPrimaryImage,pirSort,pirStatus) VALUES
    (
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.pID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.imgID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.pirPrimaryImage#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.pirSort#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.pirStatus#">
    )
    </cfquery>
    </cftransaction>
    <!---Make required updates to product status based on type of request.--->
    <cfinvoke 
    component="MCMS.component.app.product.Product" 
    method="updateProductStatus" 
    >
    <cfinvokeargument name="pID" value="#ARGUMENTS.pID#">
    <cfinvokeargument name="pwfID" value="104">
    <cfinvokeargument name="pwfcComment" value="Product image relationship created.">
    <cfinvokeargument name="pStatus" value="3">
    </cfinvoke>
    </cfif>
    <cfcatch type="any">
    <cfset result.message = "There was an error inserting the record.">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="insertProductDocumentRel" access="public" returntype="struct">
    <cfargument name="pID" type="numeric" required="yes">
    <cfargument name="docID" type="numeric" required="yes">
    <cfargument name="pdrStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully inserted the record.">
    <cftry>
    <!---Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.app.product.Product"
    method="getProductDocumentRel"
    returnvariable="getCheckProductDocumentRelRet">
    <cfinvokeargument name="pID" value="#ARGUMENTS.pID#"/>
    <cfinvokeargument name="docID" value="#ARGUMENTS.docID#"/>
    <cfinvokeargument name="pdrStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckProductDocumentRelRet.recordcount NEQ 0>
    <cfset result.message = "The product already has this document relationship, please select another document.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    INSERT INTO tbl_product_document_rel (pID,docID,pdrStatus) VALUES
    (
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.pID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.docID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.pdrStatus#">
    )
    </cfquery>
    </cftransaction>
    <!---Make required updates to product status based on type of request.--->
    <cfinvoke 
    component="MCMS.component.app.product.Product" 
    method="updateProductStatus" 
    >
    <cfinvokeargument name="pID" value="#ARGUMENTS.pID#">
    <cfinvokeargument name="pwfID" value="110">
    <cfinvokeargument name="pwfcComment" value="Product document relationship created.">
    <cfinvokeargument name="pStatus" value="3">
    </cfinvoke>
    </cfif>
    <cfcatch type="any">
    <cfset result.message = "There was an error inserting the record.">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="insertProductAdItemRel" access="public" returntype="struct">
    <cfargument name="pID" type="numeric" required="yes">
    <cfargument name="ainID" type="numeric" required="yes">
    <cfargument name="pairStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully inserted the record.">
    <cftry>
    <!---Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.app.product.Product"
    method="getProductAdItemRel"
    returnvariable="getCheckProductAdItemRelRet">
    <cfinvokeargument name="pID" value="#ARGUMENTS.pID#"/>
    <cfinvokeargument name="ainID" value="#ARGUMENTS.ainID#"/>
    <cfinvokeargument name="pairStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckProductAdItemRelRet.recordcount NEQ 0>
    <cfset result.message = "The product already has this ad item relationship, please select another ad item.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    INSERT INTO tbl_product_ad_item_rel (pID,ainID,pairStatus) VALUES
    (
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.pID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ainID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.pairStatus#">
    )
    </cfquery>
    <!---Insert the ad item too.--->
    <cfquery name="getCheckAdItemRet" datasource="#application.mcmsDSN#">
    SELECT * FROM tbl_ad_item WHERE 0=0
    AND pID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.pID#">
    AND ainID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ainID#">
    </cfquery>
    <cfif getCheckAdItemRet.recordcount EQ 0>
    <cfquery datasource="#application.mcmsDSN#">
    INSERT INTO tbl_ad_item (ainID,pID,aiMonth,aiComment,userID,aiStatus) VALUES
    (
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ainID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.pID#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#monthAsString(DatePart('m', '#Now()#'))#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="Added when product was inserted or updated by Product application.">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#session.userID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="1">
    )
    </cfquery>
    </cfif>
    </cftransaction>
    </cfif>
    <cfcatch type="any">
    <cfset result.message = "There was an error inserting the record.">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="insertProductCategoryRel" access="public" returntype="struct">
    <cfargument name="cID" type="numeric" required="yes">
    <cfargument name="pID" type="numeric" required="yes">
    <cfargument name="catID" type="numeric" required="yes">
    <cfargument name="pcrStatus" type="numeric" required="yes" default="1">
    <cfset result.message = "You have successfully inserted the record.">
    <cftry>
    <!---Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.app.product.Product"
    method="getProductCategoryRel"
    returnvariable="getCheckProductCategoryRelRet">
    <cfinvokeargument name="cID" value="#ARGUMENTS.cID#"/>
    <cfinvokeargument name="pID" value="#ARGUMENTS.pID#"/>
    <cfinvokeargument name="catID" value="#ARGUMENTS.catID#"/>
    <cfinvokeargument name="pcrStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckProductCategoryRelRet.recordcount NEQ 0>
    <cfset result.message = "The product already has this category relationship, please select another category.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    INSERT INTO tbl_product_category_rel (cID,pID,catID,pcrStatus) VALUES
    (
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.cID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.pID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.catID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.pcrStatus#">
    )
    </cfquery>
    </cftransaction>
    <!---Make required updates to product status based on type of request.--->
    <cfinvoke 
    component="MCMS.component.app.product.Product" 
    method="updateProductStatus" 
    >
    <cfinvokeargument name="pID" value="#ARGUMENTS.pID#">
    <cfinvokeargument name="pwfID" value="106">
    <cfinvokeargument name="pwfcComment" value="Product category relationship created/updated.">
    <cfinvokeargument name="pStatus" value="3">
    </cfinvoke>
    </cfif>
    <cfcatch type="any">
    <cfset result.message = "There was an error inserting the record.">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="insertProductSecondaryCategoryRel" access="public" returntype="struct">
    <cfargument name="cID" type="numeric" required="yes">
    <cfargument name="pID" type="numeric" required="yes">
    <cfargument name="scatID" type="numeric" required="yes">
    <cfargument name="cesID" type="numeric" required="yes" default="101">
    <cfargument name="pscrStatus" type="numeric" required="yes" default="1">
    <cfset result.message = "You have successfully inserted the record.">
    <cftry>
    <!---Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.app.product.Product"
    method="getProductSecondaryCategoryRel"
    returnvariable="getCheckProductSecondaryCategoryRelRet">
    <cfinvokeargument name="cID" value="#ARGUMENTS.cID#"/>
    <cfinvokeargument name="pID" value="#ARGUMENTS.pID#"/>
    <cfinvokeargument name="scatID" value="#ARGUMENTS.scatID#"/>
    <cfinvokeargument name="pscrStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckProductSecondaryCategoryRelRet.recordcount NEQ 0>
    <cfset result.message = "The product already has this secondary category relationship, please select another secondary category.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    INSERT INTO tbl_product_sec_category_rel (cID,pID,scatID,pscrStatus) VALUES
    (
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.cID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.pID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.scatID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.pscrStatus#">
    )
    </cfquery>
    </cftransaction>
    <!---Make required updates to product status based on type of request.--->
    <cfinvoke 
    component="MCMS.component.app.product.Product" 
    method="updateProductStatus" 
    >
    <cfinvokeargument name="pID" value="#ARGUMENTS.pID#">
    <cfinvokeargument name="pwfID" value="106">
    <cfinvokeargument name="pwfcComment" value="Product secondary category relationship created/updated.">
    <cfinvokeargument name="pStatus" value="3">
    </cfinvoke>
    </cfif>
    <cfcatch type="any">
    <cfset result.message = "There was an error inserting the record.">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="insertProductLineCategoryRel" access="public" returntype="struct">
    <cfargument name="cID" type="numeric" required="yes">
    <cfargument name="pID" type="numeric" required="yes">
    <cfargument name="lcatID" type="numeric" required="yes">
    <cfargument name="plcrStatus" type="numeric" required="yes" default="1">
    <cfset result.message = "You have successfully inserted the record.">
    <cftry>
    <!---Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.app.product.Product"
    method="getProductLineCategoryRel"
    returnvariable="getCheckProductLineCategoryRelRet">
    <cfinvokeargument name="cID" value="#ARGUMENTS.cID#"/>
    <cfinvokeargument name="pID" value="#ARGUMENTS.pID#"/>
    <cfinvokeargument name="lcatID" value="#ARGUMENTS.lcatID#"/>
    <cfinvokeargument name="plcrStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckProductLineCategoryRelRet.recordcount NEQ 0>
    <cfset result.message = "The product already has this line category relationship, please select another line category.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    INSERT INTO tbl_product_line_category_rel (cID,pID,lcatID,plcrStatus) VALUES
    (
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.cID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.pID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.lcatID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.plcrStatus#">
    )
    </cfquery>
    </cftransaction>
    <!---Make required updates to product status based on type of request.--->
    <cfinvoke 
    component="MCMS.component.app.product.Product" 
    method="updateProductStatus" 
    >
    <cfinvokeargument name="pID" value="#ARGUMENTS.pID#">
    <cfinvokeargument name="pwfID" value="106">
    <cfinvokeargument name="pwfcComment" value="Product line category relationship created/updated.">
    <cfinvokeargument name="pStatus" value="3">
    </cfinvoke>
    </cfif>
    <cfcatch type="any">
    <cfset result.message = "There was an error inserting the record.">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="insertProductSecondaryLineCategoryRel" access="public" returntype="struct">
    <cfargument name="cID" type="numeric" required="yes">
    <cfargument name="pID" type="numeric" required="yes">
    <cfargument name="slcatID" type="numeric" required="yes">
    <cfargument name="pslcrStatus" type="numeric" required="yes" default="1">
    <cfset result.message = "You have successfully inserted the record.">
    <cftry>
    <!---Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.app.product.Product"
    method="getProductSecondaryLineCategoryRel"
    returnvariable="getCheckProductSecondaryLineCategoryRelRet">
    <cfinvokeargument name="cID" value="#ARGUMENTS.cID#"/>
    <cfinvokeargument name="pID" value="#ARGUMENTS.pID#"/>
    <cfinvokeargument name="slcatID" value="#ARGUMENTS.slcatID#"/>
    <cfinvokeargument name="pslcrStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckProductSecondaryLineCategoryRelRet.recordcount NEQ 0>
    <cfset result.message = "The product already has this secondary line category relationship, please select another secondary line category.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    INSERT INTO tbl_product_sec_line_cat_rel (cID,pID,slcatID,pslcrStatus) VALUES
    (
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.cID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.pID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.slcatID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.pslcrStatus#">
    )
    </cfquery>
    </cftransaction>
    <!---Make required updates to product status based on type of request.--->
    <cfinvoke 
    component="MCMS.component.app.product.Product" 
    method="updateProductStatus" 
    >
    <cfinvokeargument name="pID" value="#ARGUMENTS.pID#">
    <cfinvokeargument name="pwfID" value="106">
    <cfinvokeargument name="pwfcComment" value="Product secondary line category relationship created/updated.">
    <cfinvokeargument name="pStatus" value="3">
    </cfinvoke>
    </cfif>
    <cfcatch type="any">
    <cfset result.message = "There was an error inserting the record.">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="insertProductDepartmentRel" access="public" returntype="struct">
    <cfargument name="cID" type="numeric" required="yes">
    <cfargument name="pID" type="numeric" required="yes">
    <cfargument name="deptNo" type="numeric" required="yes">
    <cfargument name="pdrStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully inserted the record.">
    <cftry>
    <!---Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.app.product.Product"
    method="getProductDepartmentRel"
    returnvariable="getCheckProductDepartmentRelRet">
    <cfinvokeargument name="cID" value="#ARGUMENTS.cID#"/>
    <cfinvokeargument name="pID" value="#ARGUMENTS.pID#"/>
    <cfinvokeargument name="deptNo" value="#ARGUMENTS.deptNo#"/>
    <cfinvokeargument name="pdrStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckProductDepartmentRelRet.recordcount NEQ 0>
    <cfset result.message = "The product already has this department relationship, please select another product/department.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    INSERT INTO tbl_product_department_rel (cID,pID,deptNo,pdrStatus) VALUES
    (
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.cID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.pID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.deptNo#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.pdrStatus#">
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
    
    <cffunction name="insertProductAttributeDepartmentRel" access="public" returntype="struct">
    <cfargument name="cID" type="string" required="yes">
    <cfargument name="paID" type="numeric" required="yes">
    <cfargument name="deptNo" type="string" required="yes">
    <cfargument name="padrStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully inserted the record.">
    <cftry>
    <cftransaction>
    <!---Need to loop over cID and deptno.--->
    <cfloop index="i" from="1" to="#ListLen(ARGUMENTS.cID)#">
    <cfloop index="ii" from="1" to="#ListLen(ARGUMENTS.deptNo)#">
    <cfquery datasource="#application.mcmsDSN#">
    INSERT INTO tbl_product_attribute_dept_rel (cID,paID,deptNo,padrStatus) VALUES
    (
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ListGetAt(ARGUMENTS.cID, i)#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.paID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ListGetAt(ARGUMENTS.deptNo, ii)#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.padrStatus#">
    )
    </cfquery>
    </cfloop>
    </cfloop>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error inserting the record.">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="insertProductAttributeUOMRel" access="public" returntype="struct">
    <cfargument name="paID" type="numeric" required="yes">
    <cfargument name="uomID" type="string" required="yes">
    <cfargument name="pauomrStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully inserted the record.">
    <cftry>
    <cftransaction>
    <!---Need to loop over uomID.--->
    <cfloop index="i" from="1" to="#ListLen(ARGUMENTS.uomID)#">
    <cfquery datasource="#application.mcmsDSN#">
    INSERT INTO tbl_product_attribute_uom_rel (paID,uomID,pauomrStatus) VALUES
    (
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.paID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ListGetAt(ARGUMENTS.uomID, i)#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.pauomrStatus#">
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
    
    <cffunction name="insertProductAttrSeparatorRel" access="public" returntype="struct">
    <cfargument name="paID" type="numeric" required="yes">
    <cfargument name="sepID" type="string" required="yes">
    <cfargument name="paseprStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully inserted the record.">
    <cftry>
    <cftransaction>
    <!---Need to loop over sepID.--->
    <cfloop index="i" from="1" to="#ListLen(ARGUMENTS.sepID)#">
    <cfquery datasource="#application.mcmsDSN#">
    INSERT INTO tbl_product_attr_separator_rel (paID,sepID,paseprStatus) VALUES
    (
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.paID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ListGetAt(ARGUMENTS.sepID, i)#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.paseprStatus#">
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
    
    <cffunction name="insertProductAttributeExtDepartmentRel" access="public" returntype="struct">
    <cfargument name="cID" type="string" required="yes">
    <cfargument name="paeID" type="numeric" required="yes">
    <cfargument name="deptNo" type="string" required="yes">
    <cfargument name="paedrStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully inserted the record.">
    <cftry>
    <cftransaction>
    <!---Need to loop over cID and deptno.--->
    <cfloop index="i" from="1" to="#ListLen(ARGUMENTS.cID)#">
    <cfloop index="ii" from="1" to="#ListLen(ARGUMENTS.deptNo)#">
    <cfquery datasource="#application.mcmsDSN#">
    INSERT INTO tbl_product_attr_ext_dept_rel (cID,paeID,deptNo,paedrStatus) VALUES
    (
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ListGetAt(ARGUMENTS.cID, i)#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.paeID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ListGetAt(ARGUMENTS.deptNo, ii)#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.paedrStatus#">
    )
    </cfquery>
    </cfloop>
    </cfloop>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error inserting the record.">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="insertProductShipType" access="public" returntype="struct">
    <cfargument name="smID" type="numeric" required="yes">
    <cfargument name="pstName" type="string" required="yes">
    <cfargument name="pstDescription" type="string" required="yes">
    <cfargument name="pstSort" type="numeric" required="yes">
    <cfargument name="pstStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully inserted the record.">
    <cftry>
    <!---Check for profanity in the text.--->
    <cfinvoke 
    component="MCMS.component.utility.Regex"
    method="regexProfanity"
    returnvariable="regexProfanityRet">
    <cfinvokeargument name="profanityString" value="#TRIM(ARGUMENTS.pstDescription)#"/>
    </cfinvoke>
    <!---Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.app.product.Product"
    method="getProductShipType"
    returnvariable="getCheckProductShipTypeRet">
    <cfinvokeargument name="pstName" value="#TRIM(ARGUMENTS.pstName)#"/>
    <cfinvokeargument name="pstStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckProductShipTypeRet.recordcount NEQ 0>
    <cfset result.message = "The name #TRIM(ARGUMENTS.pstName)# already exists, please enter a new name.">
    <cfelseif regexProfanityRet CONTAINS '$%&*!'>
    <cfset result.message = "Some text contained profanity, please remove any profanity from your text.">
    <!---Check length restriction.--->
    <cfelseif LEN(ARGUMENTS.patDescription) GT 2048>
    <cfset result.message = "The description is longer than 2048 characters, please enter a new description under 2048 characters.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    INSERT INTO tbl_product_ship_type (smID,pstName,pstDescription,pstSort,pstStatus) VALUES
    (
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.smID#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#TRIM(ARGUMENTS.pstName)#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#TRIM(ARGUMENTS.pstDescription)#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.pstSort#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.pstStatus#">
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
    
    <cffunction name="insertProductType" access="public" returntype="struct">
    <cfargument name="ptName" type="string" required="yes">
    <cfargument name="ptSort" type="numeric" required="yes">
    <cfargument name="ptStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully inserted the record.">
    <cftry>
    <!---Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.app.product.Product"
    method="getProductType"
    returnvariable="getCheckProductTypeRet">
    <cfinvokeargument name="ptName" value="#TRIM(ARGUMENTS.ptName)#"/>
    <cfinvokeargument name="ptStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckProductTypeRet.recordcount NEQ 0>
    <cfset result.message = "The name #TRIM(ARGUMENTS.ptName)# already exists, please enter a new name.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    INSERT INTO tbl_product_type (ptName,ptSort,ptStatus) VALUES
    (
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#TRIM(ARGUMENTS.ptName)#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ptSort#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ptStatus#">
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
    
    <cffunction name="insertProductSkuAttributeRel" access="public" returntype="struct">
    <cfargument name="pID" type="numeric" required="yes">
    <cfargument name="sID" type="numeric" required="yes">
    <cfargument name="paID" type="numeric" required="yes">
    <cfargument name="pavID" type="numeric" required="yes">
    <cfargument name="psaraltValue" type="string" required="yes">
    <cfargument name="psarStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully inserted the record.">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    INSERT INTO tbl_product_sku_attribute_rel (pID,sID,paID,pavID,psaraltValue,psarStatus) VALUES
    (
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.pID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.sID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.paID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.pavID#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#TRIM(ARGUMENTS.psaraltValue)#">, 
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.psarStatus#">
    )
    </cfquery>
    </cftransaction>
    <!---Make required updates to product status based on type of request.--->
    <cfinvoke 
    component="MCMS.component.app.product.Product" 
    method="updateProductStatus" 
    >
    <cfinvokeargument name="pID" value="#ARGUMENTS.pID#">
    <cfinvokeargument name="pwfID" value="107">
    <cfinvokeargument name="pwfcComment" value="Product sku attribute relationship created.">
    <cfinvokeargument name="pStatus" value="3">
    </cfinvoke>
    <cfcatch type="any">
    <cfset result.message = "There was an error updating the record.">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="insertProductTemplate" access="public" returntype="struct">
    <cfargument name="pTempName" type="string" required="yes">
    <cfargument name="pTempDescription" type="string" required="yes">
    <cfargument name="ptCode" type="string" required="yes">
    <cfargument name="ptERPCode" type="string" required="yes">
    <cfargument name="ptPOSCode" type="string" required="yes">
    <cfargument name="pTempFile" type="string" required="yes">
    <cfargument name="cID" type="numeric" required="yes">
    <cfargument name="pTempSort" type="numeric" required="yes">
    <cfargument name="pTempStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully inserted the record.">
    <cftry>
    <!---Check for profanity in the text.--->
    <cfinvoke 
    component="MCMS.component.utility.Regex"
    method="regexProfanity"
    returnvariable="regexProfanityRet">
    <cfinvokeargument name="profanityString" value="#TRIM(ARGUMENTS.pTempDescription)#"/>
    </cfinvoke>
    <!---Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.app.product.Product"
    method="getProductTemplate"
    returnvariable="getCheckProductTemplateRet">
    <cfinvokeargument name="pTempName" value="#TRIM(ARGUMENTS.pTempName)#"/>
    <cfinvokeargument name="pTempStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckProductTemplateRet.recordcount NEQ 0>
    <cfset result.message = "The name #TRIM(ARGUMENTS.pTempName)# already exists, please enter a new name.">
    <cfelseif regexProfanityRet CONTAINS '$%&*!'>
    <cfset result.message = "Some text contained profanity, please remove any profanity from your text.">
    <!---Check length restriction.--->
    <cfelseif LEN(ARGUMENTS.pTempDescription) GT 512>
    <cfset result.message = "The description is longer than 512 characters, please enter a new description under 512 characters.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    INSERT INTO tbl_product_template (pTempName,pTempDescription,ptCode,ptERPCode,ptPOSCode,pTempFile,cID,pTempSort,pTempStatus) VALUES
    (
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#TRIM(ARGUMENTS.pTempName)#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#TRIM(ARGUMENTS.pTempDescription)#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#TRIM(ARGUMENTS.ptCode)#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#TRIM(ARGUMENTS.ptERPCode)#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#TRIM(ARGUMENTS.ptPOSCode)#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#TRIM(ARGUMENTS.pTempFile)#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.cID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.pTempSort#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.pTempStatus#">
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
    
    <cffunction name="updateProduct" access="public" returntype="struct">
    <cfargument name="ID" type="numeric" required="yes">
    <cfargument name="vID" type="numeric" required="yes">
    <cfargument name="bID" type="numeric" required="yes">
    <cfargument name="pesID" type="numeric" required="yes">
    <cfargument name="pName" type="string" required="yes">
    <cfargument name="productID" type="string" required="yes">
    <cfargument name="productIDTemp" type="string" required="yes">
    <cfargument name="pPageTitle" type="string" required="yes">
    <cfargument name="pDateRel" type="string" required="yes" default="#Now()#">
    <cfargument name="temppDateRel" type="string" required="yes" default="#Now()#">
    <cfargument name="pDateExp" type="string" required="yes" default="#DateAdd('yyyy', 10, Now())#">
    <cfargument name="pBulletPoint" type="string" required="yes">
    <cfargument name="pDescription" type="string" required="yes">
    <cfargument name="pKeyword" type="string" required="yes">
    <cfargument name="pMetaDescription" type="string" required="yes">
    <cfargument name="pCSL" type="string" required="yes">
    <cfargument name="pMPN" type="string" required="yes">
    <cfargument name="pstID" type="numeric" required="yes">
    <cfargument name="ptID" type="numeric" required="yes">
    <cfargument name="cID" type="string" required="yes">
    <cfargument name="deptNo" type="string" required="yes">
    <cfargument name="ptempID" type="numeric" required="yes">
    <cfargument name="ppID" type="numeric" required="yes">
    <cfargument name="pSort" type="numeric" required="yes">
    <cfargument name="pStatus" type="numeric" required="yes">
    <!---Include any relationships.--->
    <cfargument name="ainID" type="string" required="yes">
    <!---Include any skus from ERP.--->
    <cfargument name="pSkuList" type="string" required="yes" default="">
    <cfargument name="temppSkuList" type="string" required="yes" default="">
    <cfset result.message = "You have successfully updated the record.">
    <cftry>
    <!---Check for profanity in the text.--->
    <cfinvoke 
    component="MCMS.component.utility.Regex"
    method="regexProfanity"
    returnvariable="regexProfanityRet">
    <cfinvokeargument name="profanityString" value="#TRIM(ARGUMENTS.pDescription)#"/>
    </cfinvoke>
    <!---Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.app.product.Product"
    method="getProduct"
    returnvariable="getCheckProductRet">
    <cfinvokeargument name="excludeID" value="#ARGUMENTS.ID#"/>
    <cfinvokeargument name="pName" value="#TRIM(ARGUMENTS.pName)#"/>
    <cfinvokeargument name="pStatus" value="1,2,3"/>
    </cfinvoke>
    <cfinvoke 
    component="MCMS.component.app.product.Product"
    method="getProduct"
    returnvariable="getCheckProductIDRet">
    <cfinvokeargument name="excludeID" value="#ARGUMENTS.ID#"/>
    <cfinvokeargument name="productID" value="#TRIM(ARGUMENTS.productID)#"/>
    <cfinvokeargument name="pStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckProductRet.recordcount NEQ 0 OR getCheckProductIDRet.recordcount NEQ 0>
    <cfset result.message = "The name #TRIM(ARGUMENTS.pName)# and or product ID #TRIM(ARGUMENTS.productID)# already exists, please enter a new name. The product may have been created under another department as well.  Please confrm this with the System Administrator.">
    <cfelseif regexProfanityRet CONTAINS '$%&*!'>
    <cfset result.message = "Some text contained profanity, please remove any profanity from your text.">
    <!---Check length restriction.--->
    <cfelseif LEN(ARGUMENTS.pBulletPoint) GT 2048>
    <cfset result.message = "The bullet points are longer than 2048 characters, please enter new bullet points under 255 characters.">
    <cfelseif LEN(ARGUMENTS.pMetaDescription) GT 512>
    <cfset result.message = "The meta description is longer than 512 characters, please enter a new description under 512 characters.">
    <cfelse>
    <!---Create bullet point tags.--->
    <cfinvoke 
    component="MCMS.component.utility.List"
    method="setBulletList"
    returnvariable="setBulletListRet">
    <cfinvokeargument name="listValue" value="#TRIM(ARGUMENTS.pBulletPoint)#"/>
    <cfinvokeargument name="type" value="unordered"/>
    </cfinvoke>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_product SET
    vID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.vID#">,
    bID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.bID#">,
    pName = <cfqueryparam cfsqltype="cf_sql_varchar" value="#TRIM(ARGUMENTS.pName)#">,
    productID = <cfqueryparam cfsqltype="cf_sql_varchar" value="#TRIM(ARGUMENTS.productID)#">,
    pPageTitle = <cfqueryparam cfsqltype="cf_sql_varchar" value="#TRIM(ARGUMENTS.pPageTitle)#">,
    pDateRel = <cfqueryparam cfsqltype="cf_sql_date" value="#DateFormat(ARGUMENTS.pDateRel, application.dateFormat)#">,
    pDateExp = <cfqueryparam cfsqltype="cf_sql_date" value="#DateFormat(ARGUMENTS.pDateExp, application.dateFormat)#">,
    pDateUpdate = <cfqueryparam cfsqltype="cf_sql_date" value="#Now()#">,
    pBulletPoint = <cfqueryparam cfsqltype="cf_sql_varchar" value="#setBulletListRet#">,
    pDescription = <cfqueryparam cfsqltype="cf_sql_varchar" value="#TRIM(Replace(ARGUMENTS.pDescription, '&amp;', '&', 'ALL'))#">,
    pKeyword = <cfqueryparam cfsqltype="cf_sql_varchar" value="#TRIM(ARGUMENTS.pKeyword)#">,
    pMetaDescription = <cfqueryparam cfsqltype="cf_sql_varchar" value="#TRIM(Replace(ARGUMENTS.pMetaDescription, '&amp;', '&', 'ALL'))#">,
    pCSL = <cfqueryparam cfsqltype="cf_sql_varchar" value="#TRIM(ARGUMENTS.pCSL)#">,
    pMPN = <cfqueryparam cfsqltype="cf_sql_varchar" value="#TRIM(ARGUMENTS.pMPN)#">,
    pSkuList = <cfqueryparam cfsqltype="cf_sql_varchar" value="#TRIM(ListRemoveDuplicates(ARGUMENTS.pSkuList))#">,
    pstID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.pstID#">,
    ptID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ptID#">,
    ppID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ppID#">,
    pSort = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.pSort#">
    WHERE ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ID#">
    </cfquery>
    </cftransaction>
    <!---Insert Sku Records if pSkuList is not null.--->
    <cfif ARGUMENTS.pSkuList NEQ '' OR ARGUMENTS.temppSkuList NEQ ''>
    <cfinvoke 
    component="MCMS.component.app.sku.Sku"
    method="insertSkuFromERP"
    >
    <cfinvokeargument name="pID" value="#ARGUMENTS.ID#"/>
    <cfif ListLen(ARGUMENTS.deptNo) EQ 1>
    <cfinvokeargument name="deptNo" value="#ARGUMENTS.deptNo#"/>
    </cfif>
    <cfinvokeargument name="pSkuList" value="#ListRemoveDuplicates(ARGUMENTS.pSkuList)#"/>
    <cfinvokeargument name="temppSkuList" value="#ARGUMENTS.temppSkuList#"/>
    <cfinvokeargument name="reportMessage" value="#result.message#"/>
    </cfinvoke>
    </cfif>
    <!---Make required updates to product status based on type of request.--->
    <cfset this.pwfcComment = "Product description update.">
    <cfif ARGUMENTS.pDateRel NEQ ARGUMENTS.temppDateRel>
    <cfset this.pwfcComment = "Product release date updated.">
    </cfif>
    <cfinvoke 
    component="MCMS.component.app.product.Product" 
    method="updateProductStatus" 
    returnvariable="result">
    <cfinvokeargument name="pID" value="#ARGUMENTS.ID#">
    <cfinvokeargument name="pwfID" value="101">
    <cfinvokeargument name="pwfcComment" value="#this.pwfcComment#">
    <cfinvokeargument name="pStatus" value="#ARGUMENTS.pStatus#">
    </cfinvoke>
    <!---Update Relationships--->
    <!--- Obtain product detail ID. --->
    <cfinvoke 
    component="MCMS.component.app.product.Product"
    method="getProductDetail"
    returnvariable="getProductDetailRet">
    <cfinvokeargument name="pID" value="#ARGUMENTS.ID#"/>
    <cfinvokeargument name="pdStatus" value="1"/>
    </cfinvoke>
    <cfif getProductDetailRet.recordcount NEQ 0>
    <cfinvoke 
    component="MCMS.component.app.product.Product"
    method="updateProductDetail"
    returnvariable="updateProductDetailRet">
    <cfinvokeargument name="ID" value="#getProductDetailRet.ID#"/>
    <cfinvokeargument name="pID" value="#ARGUMENTS.ID#"/>
    <cfinvokeargument name="pdName" value="Detail"/>
    <cfinvokeargument name="pdDescription" value="#ARGUMENTS.pDescription#"/>
    <cfinvokeargument name="pdDateRel" value="#ARGUMENTS.pDateRel#"/>
    <cfinvokeargument name="pdDateExp" value="#ARGUMENTS.pDateExp#"/>
    <cfinvokeargument name="pdtID" value="1"/>
    <cfinvokeargument name="pdSort" value="1"/>
    <cfinvokeargument name="pdStatus" value="1"/>
    </cfinvoke>
    <cfelse>
    <cfif ARGUMENTS.pDescription NEQ ''>
    <cfinvoke 
    component="MCMS.component.app.product.Product"
    method="insertProductDetail"
    >
    <cfinvokeargument name="pID" value="#ARGUMENTS.ID#"/>
    <cfinvokeargument name="pdName" value="Detail"/>
    <cfinvokeargument name="pdDescription" value="#ARGUMENTS.pDescription#"/>
    <cfinvokeargument name="pdDateRel" value="#ARGUMENTS.pDateRel#"/>
    <cfinvokeargument name="pdDateExp" value="#ARGUMENTS.pDateExp#"/>
    <cfinvokeargument name="pdtID" value="1"/>
    <cfinvokeargument name="pdSort" value="1"/>
    <cfinvokeargument name="pdStatus" value="1"/>
    </cfinvoke>
    </cfif>
    </cfif>
    <!---Delete current relationships.--->
    <cfinvoke 
    component="MCMS.component.app.catalog.Catalog"
    method="deleteCatalogProductRel">
    <cfinvokeargument name="pID" value="#ARGUMENTS.ID#"/>
    </cfinvoke>
    <cfinvoke 
    component="MCMS.component.app.product.Product"
    method="deleteProductAdItemRel">
    <cfinvokeargument name="pID" value="#ARGUMENTS.ID#"/>
    </cfinvoke>
    <cfinvoke 
    component="MCMS.component.app.product.Product"
    method="deleteProductDepartmentRel">
    <cfinvokeargument name="pID" value="#ARGUMENTS.ID#"/>
    </cfinvoke>
    <cfinvoke 
    component="MCMS.component.app.product.Product"
    method="deleteProductAttributeExtRel">
    <cfinvokeargument name="pID" value="#ARGUMENTS.ID#"/>
    <cfinvokeargument name="paeID" value="103"/>
    </cfinvoke>
    <cfloop index="catalogID" from="1" to="#ListLen(ARGUMENTS.cID)#">
    <!---Insert Catalog relationships.--->
    <cfinvoke 
    component="MCMS.component.app.catalog.Catalog"
    method="insertCatalogProductRel">
    <cfinvokeargument name="pID" value="#ARGUMENTS.ID#"/>
    <cfinvokeargument name="cID" value="#ListGetAt(ARGUMENTS.cID, catalogID)#"/>
    <cfinvokeargument name="cprDiscount" value="0"/>
    <cfinvokeargument name="cprDateExp" value="#DateFormat(ARGUMENTS.pDateExp, application.dateFormat)#"/>
    <cfinvokeargument name="cprStatus" value="1"/>
    </cfinvoke>
    </cfloop>
    <!---Insert Ad Item relationships.--->
    <cfloop index="aditemnameID" from="1" to="#ListLen(ARGUMENTS.ainID)#">
    <cfinvoke 
    component="MCMS.component.app.product.Product"
    method="insertProductAdItemRel">
    <cfinvokeargument name="pID" value="#ARGUMENTS.ID#"/>
    <cfinvokeargument name="ainID" value="#ListGetAt(ARGUMENTS.ainID, aditemnameID)#"/>
    <cfinvokeargument name="pairStatus" value="1"/>
    </cfinvoke>
    </cfloop>
    <!---Insert Product Department Relationships.--->
    <cfloop index="i" from="1" to="#ListLen(ARGUMENTS.cID)#">
    <cfloop index="ii" from="1" to="#ListLen(ARGUMENTS.deptNo)#">
    <!---Insert Product Department relationships.--->
    <cfinvoke 
    component="MCMS.component.app.product.Product"
    method="insertProductDepartmentRel">
    <cfinvokeargument name="cID" value="#ListGetAt(ARGUMENTS.cID, i)#"/>
    <cfinvokeargument name="pID" value="#ARGUMENTS.ID#"/>
    <cfinvokeargument name="deptNo" value="#ListGetAt(ARGUMENTS.deptNo, ii)#"/>
    <cfinvokeargument name="pdrStatus" value="1"/>
    </cfinvoke>
    </cfloop>
    </cfloop>
    <!---Insert Product Template relationships.--->
    <cfinvoke 
    component="MCMS.component.app.product.Product"
    method="insertProductAttributeExtRel">
    <cfinvokeargument name="pID" value="#ARGUMENTS.ID#"/>
    <cfinvokeargument name="paeID" value="103"/>
    <cfinvokeargument name="paerValue" value="#ARGUMENTS.ptempID#"/>
    <cfinvokeargument name="paerStatus" value="1"/>
    </cfinvoke>
    </cfif>
    <cfcatch type="any">
    <cfset result.message = "There was an error updating the record.">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="updateProductDetail" access="public" returntype="struct">
    <cfargument name="ID" type="numeric" required="yes">
    <cfargument name="pID" type="numeric" required="yes">
    <cfargument name="pdName" type="string" required="yes">
    <cfargument name="pdDescription" type="string" required="yes">
    <cfargument name="pdDateRel" type="string" required="yes">
    <cfargument name="pdDateExp" type="string" required="yes">
    <cfargument name="pdtID" type="numeric" required="yes">
    <cfargument name="pdSort" type="numeric" required="yes">
    <cfargument name="pdStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully updated the record.">
    <cftry>
    <!---Check for profanity in the text.--->
    <cfinvoke 
    component="MCMS.component.utility.Regex"
    method="regexProfanity"
    returnvariable="regexProfanityRet">
    <cfinvokeargument name="profanityString" value="#TRIM(ARGUMENTS.pdDescription)#"/>
    </cfinvoke>
    <!---Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.app.product.Product"
    method="getProductDetail"
    returnvariable="getCheckProductDetailRet">
    <cfinvokeargument name="excludeID" value="#ARGUMENTS.ID#"/>
    <cfinvokeargument name="pID" value="#ARGUMENTS.pID#"/>
    <cfinvokeargument name="pdtID" value="#ARGUMENTS.pdtID#"/>
    <cfinvokeargument name="pdStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckProductDetailRet.recordcount NEQ 0>
    <cfset result.message = "The detail type already exists, please try again.">
    <cfelseif regexProfanityRet CONTAINS '$%&*!'>
    <cfset result.message = "Some text contained profanity, please remove any profanity from your text.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_product_detail SET
    pID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.pID#">,
    pdName = <cfqueryparam cfsqltype="cf_sql_varchar" value="#TRIM(ARGUMENTS.pdName)#">,
    pdDescription = <cfqueryparam cfsqltype="cf_sql_varchar" value="#TRIM(Replace(ARGUMENTS.pdDescription, '&amp;', '&', 'ALL'))#">,
    pdDateRel = <cfqueryparam cfsqltype="cf_sql_date" value="#DateFormat(ARGUMENTS.pdDateRel, application.dateFormat)#">,
    pdDateExp = <cfqueryparam cfsqltype="cf_sql_date" value="#DateFormat(ARGUMENTS.pdDateExp, application.dateFormat)#">,
    pdDateUpdate = <cfqueryparam cfsqltype="cf_sql_date" value="#DateFormat(Now(), application.dateFormat)#">,
    pdtID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.pdtID#">,
    userID = <cfqueryparam cfsqltype="cf_sql_integer" value="#session.userID#">,
    pdSort = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.pdSort#">,
    pdStatus = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.pdStatus#">
    WHERE ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ID#">
    </cfquery>
    </cftransaction>
    <!---Update the product description too.--->
    <cfif ARGUMENTS.pdDescription NEQ '' AND NOT IsNull(ARGUMENTS.pdDescription)> 
	<cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_product SET
    pDescription = <cfqueryparam cfsqltype="cf_sql_varchar" value="#TRIM(Replace(ARGUMENTS.pdDescription, '&amp;', '&', 'ALL'))#">
    WHERE pID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.pID#">
    </cfquery>
    </cftransaction>
    </cfif>
    <!---Make required updates to product status based on type of request.--->
    <cfinvoke 
    component="MCMS.component.app.product.Product" 
    method="updateProductStatus" 
    returnvariable="result">
    <cfinvokeargument name="pID" value="#ARGUMENTS.pID#">
    <cfinvokeargument name="pwfID" value="103">
    <cfinvokeargument name="pwfcComment" value="Product detail update.">
    <cfinvokeargument name="pStatus" value="3">
    </cfinvoke>
    </cfif>
    <cfcatch type="any">
    <cfset result.message = "There was an error updating the record.">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="updateProductAttribute" access="public" returntype="struct">
    <cfargument name="ID" type="numeric" required="yes">
    <cfargument name="paName" type="string" required="yes">
    <cfargument name="paNameAlt" type="string" required="yes">
    <cfargument name="paDescription" type="string" required="yes">
    <cfargument name="paCode" type="string" required="yes">
    <cfargument name="paERPCode" type="string" required="yes">
    <cfargument name="paPOSCode" type="string" required="yes">
    <cfargument name="paRequired" type="numeric" required="yes">
    <cfargument name="paDefaultValue" type="string" required="yes">
    <cfargument name="paRegEx" type="string" required="yes">
    <cfargument name="paRangeStart" type="numeric" required="yes">
    <cfargument name="paRangeEnd" type="numeric" required="yes">
    <cfargument name="paComponent" type="string" required="yes">
    <cfargument name="paMethod" type="string" required="yes">
    <cfargument name="paValueColumn" type="string" required="yes">
    <cfargument name="paNameColumn" type="string" required="yes">
    <cfargument name="paArgumentList" type="string" required="yes">
    <cfargument name="paLOVList" type="string" required="yes">
    <cfargument name="patID" type="numeric" required="yes">
    <cfargument name="patFieldCount" type="numeric" required="yes">
    <cfargument name="paSort" type="numeric" required="yes">
    <cfargument name="paStatus" type="numeric" required="yes">
    <!---Relationship arguments.--->
    <cfargument name="cID" type="string" required="yes">
    <cfargument name="deptNo" type="string" required="yes">
    <cfargument name="uomID" type="string" required="yes">
    <cfargument name="sepID" type="string" required="yes">
    <cfset result.message = "You have successfully updated the record.">
    <cftry>
    <!---Check for profanity in the text.--->
    <cfinvoke 
    component="MCMS.component.utility.Regex"
    method="regexProfanity"
    returnvariable="regexProfanityRet">
    <cfinvokeargument name="profanityString" value="#TRIM(ARGUMENTS.paDescription)#"/>
    </cfinvoke>
    <!---Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.app.product.Product"
    method="getProductAttribute"
    returnvariable="getCheckProductAttributeRet">
    <cfinvokeargument name="excludeID" value="#ARGUMENTS.ID#"/>
    <cfinvokeargument name="paName" value="#TRIM(ARGUMENTS.paName)#"/>
    <cfinvokeargument name="paStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckProductAttributeRet.recordcount NEQ 0>
    <cfset result.message = "The name #TRIM(ARGUMENTS.paName)# already exists, please enter a new name.">
    <cfelseif regexProfanityRet CONTAINS '$%&*!'>
    <cfset result.message = "Some text contained profanity, please remove any profanity from your text.">
    <!---Check length restriction.--->
    <cfelseif LEN(ARGUMENTS.paDescription) GT 1024>
    <cfset result.message = "The description is longer than 1024 characters, please enter a new description under 1024 characters.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_product_attribute SET
    paName = <cfqueryparam cfsqltype="cf_sql_varchar" value="#TRIM(ARGUMENTS.paName)#">,
    paNameAlt = <cfqueryparam cfsqltype="cf_sql_varchar" value="#TRIM(ARGUMENTS.paNameAlt)#">,
    paDescription = <cfqueryparam cfsqltype="cf_sql_varchar" value="#TRIM(ARGUMENTS.paDescription)#">,
    paCode = <cfqueryparam cfsqltype="cf_sql_varchar" value="#TRIM(ARGUMENTS.paCode)#">,
    paERPCode = <cfqueryparam cfsqltype="cf_sql_varchar" value="#TRIM(ARGUMENTS.paERPCode)#">,
    paPOSCode = <cfqueryparam cfsqltype="cf_sql_varchar" value="#TRIM(ARGUMENTS.paPOSCode)#">,
    paRequired = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.paRequired#">,
    paDefaultValue = <cfqueryparam cfsqltype="cf_sql_varchar" value="#TRIM(ARGUMENTS.paDefaultValue)#">,
    paRegEx = <cfqueryparam cfsqltype="cf_sql_varchar" value="#TRIM(ARGUMENTS.paRegEx)#">,
    patID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.patID#">,
    patFieldCount = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.patFieldCount#">,
    paDateUpdate = <cfqueryparam cfsqltype="cf_sql_timestamp" value="#Now()#">,
    userID = <cfqueryparam cfsqltype="cf_sql_integer" value="#session.userID#">,
    paRangeStart = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.paRangeStart#">,
    paRangeEnd = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.paRangeEnd#">,
    paComponent = <cfqueryparam cfsqltype="cf_sql_varchar" value="#TRIM(ARGUMENTS.paComponent)#">,
    paMethod = <cfqueryparam cfsqltype="cf_sql_varchar" value="#TRIM(ARGUMENTS.paMethod)#">,
    paValueColumn = <cfqueryparam cfsqltype="cf_sql_varchar" value="#TRIM(ARGUMENTS.paValueColumn)#">,
    paNameColumn = <cfqueryparam cfsqltype="cf_sql_varchar" value="#TRIM(ARGUMENTS.paNameColumn)#">,
    paArgumentList = <cfqueryparam cfsqltype="cf_sql_varchar" value="#TRIM(ARGUMENTS.paArgumentList)#">,
    paLOVList = <cfqueryparam cfsqltype="cf_sql_varchar" value="#TRIM(ARGUMENTS.paLOVList)#">,
    paSort = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.paSort#">,
    paStatus = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.paStatus#">
    WHERE ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ID#">
    </cfquery>
    </cftransaction>
    <!---Delete any existing relationships.--->
    <cfinvoke 
    component="MCMS.component.app.product.Product"
    method="deleteProductAttributeDepartmentRel"
    returnvariable="deleteProductAttributeDepartmentRelRet">
    <cfinvokeargument name="paID" value="#ARGUMENTS.ID#"/>
    </cfinvoke>
    <cfinvoke 
    component="MCMS.component.app.product.Product"
    method="deleteProductAttributeUOMRel"
    returnvariable="deleteProductAttributeUOMRelRet">
    <cfinvokeargument name="paID" value="#ARGUMENTS.ID#"/>
    </cfinvoke>
    <cfinvoke 
    component="MCMS.component.app.product.Product"
    method="deleteProductAttrSeparatorRel"
    returnvariable="deleteProductAttrSeparatorRelRet">
    <cfinvokeargument name="paID" value="#ARGUMENTS.ID#"/>
    </cfinvoke>
    <!---Create department relationships.--->
    <cfinvoke 
    component="MCMS.component.app.product.Product"
    method="insertProductAttributeDepartmentRel"
    returnvariable="insertProductAttributeDepartmentRelRet">
    <cfinvokeargument name="cID" value="#ARGUMENTS.cID#"/>
    <cfinvokeargument name="paID" value="#ARGUMENTS.ID#"/>
    <cfinvokeargument name="deptNo" value="#ARGUMENTS.deptNo#"/>
    <cfinvokeargument name="padrStatus" value="1"/>
    </cfinvoke>
    <!---Create uom relationships.--->
    <cfinvoke 
    component="MCMS.component.app.product.Product"
    method="insertProductAttributeUOMRel"
    returnvariable="insertProductAttributeUOMRelRet">
    <cfinvokeargument name="paID" value="#ARGUMENTS.ID#"/>
    <cfinvokeargument name="uomID" value="#ARGUMENTS.uomID#"/>
    <cfinvokeargument name="pauomrStatus" value="1"/>
    </cfinvoke>
    <!---Create separator relationships.--->
    <cfinvoke 
    component="MCMS.component.app.product.Product"
    method="insertProductAttrSeparatorRel"
    returnvariable="insertProductAttrSeparatorRelRet">
    <cfinvokeargument name="paID" value="#ARGUMENTS.ID#"/>
    <cfinvokeargument name="sepID" value="#ARGUMENTS.sepID#"/>
    <cfinvokeargument name="paseprStatus" value="1"/>
    </cfinvoke>
    </cfif>
    <cfcatch type="any">
    <cfset result.message = "There was an error updating the record.">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="updateProductAttributeExt" access="public" returntype="struct">
    <cfargument name="ID" type="numeric" required="yes">
    <cfargument name="paeName" type="string" required="yes">
    <cfargument name="paeNameAlt" type="string" required="yes">
    <cfargument name="paeDescription" type="string" required="yes">
    <cfargument name="paeCode" type="string" required="yes">
    <cfargument name="paeERPCode" type="string" required="yes">
    <cfargument name="paePOSCode" type="string" required="yes">
    <cfargument name="paeRequired" type="numeric" required="yes">
    <cfargument name="paeDefaultValue" type="string" required="yes">
    <cfargument name="paeRegEx" type="string" required="yes">
    <cfargument name="paetID" type="numeric" required="yes">
    <cfargument name="paeSort" type="numeric" required="yes">
    <cfargument name="paeStatus" type="numeric" required="yes">
    <!---Relationship arguments.--->
    <cfargument name="cID" type="string" required="yes">
    <cfargument name="deptNo" type="string" required="yes">
    <cfset result.message = "You have successfully updated the record.">
    <cftry>
    <!---Check for profanity in the text.--->
    <cfinvoke 
    component="MCMS.component.utility.Regex"
    method="regexProfanity"
    returnvariable="regexProfanityRet">
    <cfinvokeargument name="profanityString" value="#TRIM(ARGUMENTS.paeDescription)#"/>
    </cfinvoke>
    <!---Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.app.product.Product"
    method="getProductAttributeExt"
    returnvariable="getCheckProductAttributeExtRet">
    <cfinvokeargument name="excludeID" value="#ARGUMENTS.ID#"/>
    <cfinvokeargument name="paeName" value="#TRIM(ARGUMENTS.paeName)#"/>
    <cfinvokeargument name="paeStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckProductAttributeExtRet.recordcount NEQ 0>
    <cfset result.message = "The name #TRIM(ARGUMENTS.paeName)# already exists, please enter a new name.">
    <cfelseif regexProfanityRet CONTAINS '$%&*!'>
    <cfset result.message = "Some text contained profanity, please remove any profanity from your text.">
    <!---Check length restriction.--->
    <cfelseif LEN(ARGUMENTS.paeDescription) GT 2048>
    <cfset result.message = "The meta description is longer than 2048 characters, please enter a new description under 2048 characters.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_product_attribute_ext SET
    paeName = <cfqueryparam cfsqltype="cf_sql_varchar" value="#TRIM(ARGUMENTS.paeName)#">,
    paeNameAlt = <cfqueryparam cfsqltype="cf_sql_varchar" value="#TRIM(ARGUMENTS.paeNameAlt)#">,
    paeDescription = <cfqueryparam cfsqltype="cf_sql_varchar" value="#TRIM(ARGUMENTS.paeDescription)#">,
    paeCode = <cfqueryparam cfsqltype="cf_sql_varchar" value="#TRIM(ARGUMENTS.paeCode)#">,
    paeERPCode = <cfqueryparam cfsqltype="cf_sql_varchar" value="#TRIM(ARGUMENTS.paeERPCode)#">,
    paePOSCode = <cfqueryparam cfsqltype="cf_sql_varchar" value="#TRIM(ARGUMENTS.paePOSCode)#">,
    paeRequired = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.paeRequired#">,
    paeDefaultValue = <cfqueryparam cfsqltype="cf_sql_varchar" value="#TRIM(ARGUMENTS.paeDefaultValue)#">,
    paeRegEx = <cfqueryparam cfsqltype="cf_sql_varchar" value="#TRIM(ARGUMENTS.paeRegEx)#">,
    paetID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.paetID#">,
    paeDateUpdate = <cfqueryparam cfsqltype="cf_sql_timestamp" value="#Now()#">,
    userID = <cfqueryparam cfsqltype="cf_sql_integer" value="#session.userID#">,
    paeSort = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.paeSort#">,
    paeStatus = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.paeStatus#">
    WHERE ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ID#">
    </cfquery>
    </cftransaction>
    <!---Delete any existing relationships.--->
    <cfinvoke 
    component="MCMS.component.app.product.Product"
    method="deleteProductAttributeExtDepartmentRel"
    returnvariable="deleteProductAttributeExtDepartmentRelRet">
    <cfinvokeargument name="paeID" value="#ARGUMENTS.ID#"/>
    </cfinvoke>
    <!---Create department relationships.--->
    <cfinvoke 
    component="MCMS.component.app.product.Product"
    method="insertProductAttributeExtDepartmentRel"
    returnvariable="insertProductAttributeExtDepartmentRelRet">
    <cfinvokeargument name="cID" value="#ARGUMENTS.cID#"/>
    <cfinvokeargument name="paeID" value="#ARGUMENTS.ID#"/>
    <cfinvokeargument name="deptNo" value="#ARGUMENTS.deptNo#"/>
    <cfinvokeargument name="paedrStatus" value="1"/>
    </cfinvoke>
    </cfif>
    <cfcatch type="any">
    <cfset result.message = "There was an error updating the record.">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="updateProductAttributeExtRel" access="public" returntype="struct">
    <cfargument name="ID" type="numeric" required="yes">
    <cfargument name="pID" type="numeric" required="yes">
    <cfargument name="paeID" type="numeric" required="yes">
    <cfargument name="paerValue" type="string" required="yes">
    <cfargument name="paerStatus" type="numeric" required="yes">
    <cfargument name="updateProductStatus" type="string" required="yes" default="true">
    <cfset result.message = "You have successfully updated the record.">
    <cftry>
    <!---Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.app.product.Product"
    method="getProductAttributeExtRel"
    returnvariable="getCheckProductAttributeExtRelRet">
    <cfinvokeargument name="excludeID" value="#ARGUMENTS.ID#"/>
    <cfinvokeargument name="pID" value="#ARGUMENTS.pID#"/>
    <cfinvokeargument name="paeID" value="#ARGUMENTS.paeID#"/>
    <cfinvokeargument name="paerValue" value="#TRIM(ARGUMENTS.paerValue)#"/>
    <cfinvokeargument name="paerStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckProductAttributeExtRelRet.recordcount NEQ 0>
    <cfset result.message = "The attribute ext. relationship already exists, please try again.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_product_attribute_ext_rel SET
    pID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.pID#">,
    paeID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.paeID#">,
    paerValue = <cfqueryparam cfsqltype="cf_sql_varchar" value="#TRIM(ARGUMENTS.paerValue)#">,
    paerStatus = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.paerStatus#">
    WHERE ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ID#">
    </cfquery>
    </cftransaction>
    <!---If compliance authorization is required notify by email.--->
    <cfif ListContains(application.complianceAuthorizationAttributeExtList, ARGUMENTS.paeID) AND ListContains('18', ARGUMENTS.paerValue)>
    <!---Insert the attributes based on the compliance attribute ext.--->
    <cfloop list="#application.complianceAuthorizationAttributeList#" index="i">
    <cfinvoke 
    component="MCMS.component.app.product.Product"
    method="insertProductAttributeRel">
    <cfinvokeargument name="pID" value="#ARGUMENTS.pID#">
    <cfinvokeargument name="paID" value="#i#"/>
    <cfinvokeargument name="parStatus" value="1"/>
    </cfinvoke>
    </cfloop>
    <cfinvoke 
    component="MCMS.component.app.product.Product"
    method="getProduct"
    returnvariable="rs">
    <cfinvokeargument name="ID" value="#ARGUMENTS.pID#"/>
    <cfinvokeargument name="pStatus" value="1,2,3"/>
    </cfinvoke>
    <!---This authorization covers Special Handling.--->
    <cfset this.emailBody = "
	<h3>#application.companyName# Product - #rs.pName# Compliance Authorization</h3>
	#LSDateFormat(Now())# - #LSTimeFormat(Now())#
	<br/>
	<p>
	#rs.pName# (#rs.productID#/#rs.ID#) requires Compliance Authorization.<br><br>
	This product may not have skus assigned to it in the Commerce Workflow yet.  This message is to inform you to check #rs.pName# skus before its release date on #DateFormat(rs.pDateRel, application.dateFormat)#.<br><br>
	To update skus that require compliance authorization, please access the Sku Manager application via the link below.
	</p>
	<div align='center'><a href='//#CGI.SERVER_NAME#' class='textBold'>Commerce Dashboard</a></div>
	">
    <cfinvoke 
    component="MCMS.component.utility.Email"
    method="sendEmail">
    <cfinvokeargument name="subject" value="#application.companyName# - Compliance Authorization"/>
    <cfinvokeargument name="to" value="#application.complianceEmail#"/>
    <cfinvokeargument name="from" value="#application.noReplyEmail#"/>
    <cfinvokeargument name="body" value="#this.emailBody#"/>
    <cfinvokeargument name="ID" value="#ARGUMENTS.pID#"/>
    <cfinvokeargument name="emailTemplate" value=""/>
    </cfinvoke>
    </cfif>
    <!---Make required updates to product status based on type of request if updateProductStatus = true.--->
    <cfif ARGUMENTS.updateProductStatus EQ 'true'>
    <cfinvoke 
    component="MCMS.component.app.product.Product" 
    method="updateProductStatus" 
    returnvariable="result">
    <cfinvokeargument name="pID" value="#ARGUMENTS.pID#">
    <cfinvokeargument name="pwfID" value="102">
    <cfinvokeargument name="pwfcComment" value="Product attribute extension update.">
    <cfinvokeargument name="pStatus" value="3">
    </cfinvoke>
    </cfif>
    </cfif>
    <cfcatch type="any">
    <cfset result.message = "There was an error updating the record.">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="updateProductSkuAttributeRel" access="public" returntype="struct">
    <cfargument name="ID" type="any" required="yes">
    <cfargument name="pID" type="numeric" required="yes">
    <cfargument name="sID" type="numeric" required="yes">
    <cfargument name="paCount" type="numeric" required="yes">
    <cfargument name="paID" type="numeric" required="yes">
    <cfargument name="pavID" type="numeric" required="yes">
    <cfargument name="psaraltValue" type="string" required="yes">
    <cfargument name="paIDList" type="string" required="yes">
    <cfargument name="pavIDList" type="string" required="yes">
    <cfargument name="psarStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully updated the record.">
    <cftry>
    <!---Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.app.product.Product"
    method="getProductSkuAttributeRelDuplicate"
    returnvariable="getCheckProductSkuAttributeRelDuplicateRet">
    <cfinvokeargument name="sID" value="#ARGUMENTS.sID#"/>
    <cfinvokeargument name="pID" value="#ARGUMENTS.pID#"/>
    <cfinvokeargument name="paIDList" value="#ARGUMENTS.paIDList#"/>
    <cfinvokeargument name="pavIDList" value="#ARGUMENTS.pavIDList#"/>
    <cfinvokeargument name="paCount" value="#ARGUMENTS.paCount#"/>
    <cfinvokeargument name="psarStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckProductSkuAttributeRelDuplicateRet.recordcount GTE ARGUMENTS.paCount>
    <cfset result.message = "The sku attribute configuration you have chosen already exist for Sku: #getCheckProductSkuAttributeRelDuplicateRet.skuID#, please choose another sku attribute configuration.">
    <!---If the value updated is not a valid attribute value create it now.--->
    <cfelseif ARGUMENTS.ID EQ ''>
    <!---Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.app.product.Product"
    method="getProductAttributeValue"
    returnvariable="getCheckProductAttributeValueRet">
    <cfinvokeargument name="paID" value="#ARGUMENTS.paID#"/>
    <cfinvokeargument name="pavValue" value="#TRIM(ARGUMENTS.psaraltValue)#"/>
    <cfinvokeargument name="pavStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckProductAttributeValueRet.recordcount NEQ 0>
    <cfset this.pavID = getCheckProductAttributeValueRet.ID>
    <cfelse>
    <cfinvoke 
    component="MCMS.component.cms.Cms"
    method="getMaxValueSQL"
    returnvariable="getMaxValueSQLRet">
    <cfinvokeargument name="tableName" value="tbl_product_attribute_value"/>
    </cfinvoke>
    <cfset this.pavID = getMaxValueSQLRet>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    INSERT INTO tbl_product_attribute_value (paID,pavValue,userID,pavSort,pavStatus) VALUES
    (
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.paID#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#TRIM(ARGUMENTS.psaraltValue)#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#session.userID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="1">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="1">
    )
    </cfquery>
    </cftransaction>
    </cfif>
    <cfinvoke 
    component="MCMS.component.app.product.Product"
    method="insertProductSkuAttributeRel"
    >
    <cfinvokeargument name="pID" value="#ARGUMENTS.pID#"/>
    <cfinvokeargument name="sID" value="#ARGUMENTS.sID#"/>
    <cfinvokeargument name="paID" value="#ARGUMENTS.paID#"/>
    <cfinvokeargument name="pavID" value="#this.pavID#"/>
    <cfinvokeargument name="psaraltValue" value="#TRIM(ARGUMENTS.psaraltValue)#"/>
	<cfinvokeargument name="psarStatus" value="1"/>
    </cfinvoke>
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_product_sku_attribute_rel SET
    pavID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.pavID#">,
    psaraltValue = <cfqueryparam cfsqltype="cf_sql_varchar" value="#TRIM(ARGUMENTS.psaraltValue)#">, 
    psarStatus = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.psarStatus#">
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
    
    <cffunction name="updateProductAttributeDepartmentRel" access="public" returntype="struct">
    <cfargument name="ID" type="numeric" required="yes">
    <cfargument name="cID" type="numeric" required="yes">
    <cfargument name="paID" type="numeric" required="yes">
    <cfargument name="deptNo" type="numeric" required="yes">
    <cfargument name="padrStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully updated the record.">
    <cftry>
    <!---Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.app.product.Product"
    method="getProductAttributeDepartmentRel"
    returnvariable="getCheckProductAttributeDepartmentRelRet">
    <cfinvokeargument name="excludeID" value="#ARGUMENTS.ID#"/>
    <cfinvokeargument name="cID" value="#ARGUMENTS.cID#"/>
    <cfinvokeargument name="paID" value="#ARGUMENTS.paID#"/>
    <cfinvokeargument name="deptNo" value="#ARGUMENTS.deptNo#"/>
    <cfinvokeargument name="padrStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckProductAttributeDepartmentRelRet.recordcount NEQ 0>
    <cfset result.message = "The product attribute already has this department relationship, please select another attribute/department.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_product_attribute_dept_rel SET
    cID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.cID#">,
    paID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.paID#">,
    deptNo = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.deptNo#">,
    padrStatus = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.padrStatus#">
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
    
    <cffunction name="updateProductDepartmentRel" access="public" returntype="struct">
    <cfargument name="ID" type="numeric" required="yes">
    <cfargument name="cID" type="numeric" required="yes">
    <cfargument name="pID" type="numeric" required="yes">
    <cfargument name="deptNo" type="numeric" required="yes">
    <cfargument name="pdrStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully updated the record.">
    <cftry>
    <!---Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.app.product.Product"
    method="getProductDepartmentRel"
    returnvariable="getCheckProductDepartmentRelRet">
    <cfinvokeargument name="excludeID" value="#ARGUMENTS.ID#"/>
    <cfinvokeargument name="cID" value="#ARGUMENTS.cID#"/>
    <cfinvokeargument name="pID" value="#ARGUMENTS.pID#"/>
    <cfinvokeargument name="deptNo" value="#ARGUMENTS.deptNo#"/>
    <cfinvokeargument name="pdrStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckProductDepartmentRelRet.recordcount NEQ 0>
    <cfset result.message = "The product already has this department relationship, please select another product/department.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_product_department_rel SET
    cID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.cID#">,
    pID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.pID#">,
    deptNo = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.deptNo#">,
    pdrStatus = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.pdrStatus#">
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
    
    <cffunction name="updateProductAttributeExtType" access="public" returntype="struct">
    <cfargument name="ID" type="numeric" required="yes">
    <cfargument name="paetName" type="string" required="yes">
    <cfargument name="paetDescription" type="string" required="yes">
    <cfargument name="paetSort" type="numeric" required="yes">
    <cfargument name="paetStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully updated the record.">
    <cftry>
    <!---Check for profanity in the text.--->
    <cfinvoke 
    component="MCMS.component.utility.Regex"
    method="regexProfanity"
    returnvariable="regexProfanityRet">
    <cfinvokeargument name="profanityString" value="#TRIM(ARGUMENTS.paetDescription)#"/>
    </cfinvoke>
    <!---Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.app.product.Product"
    method="getProductAttributeExtType"
    returnvariable="getCheckProductAttributeExtTypeRet">
    <cfinvokeargument name="excludeID" value="#ARGUMENTS.ID#"/>
    <cfinvokeargument name="paetName" value="#TRIM(ARGUMENTS.paetName)#"/>
    <cfinvokeargument name="paetStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckProductAttributeExtTypeRet.recordcount NEQ 0>
    <cfset result.message = "The name #TRIM(ARGUMENTS.paetName)# already exists, please enter a new name.">
    <cfelseif regexProfanityRet CONTAINS '$%&*!'>
    <cfset result.message = "Some text contained profanity, please remove any profanity from your text.">
    <!---Check length restriction.--->
    <cfelseif LEN(ARGUMENTS.paetDescription) GT 2024>
    <cfset result.message = "The description is longer than 2024 characters, please enter a new description under 2024 characters.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_product_attribute_ext_type SET
    paetName = <cfqueryparam cfsqltype="cf_sql_varchar" value="#TRIM(ARGUMENTS.paetName)#">,
    paetDescription = <cfqueryparam cfsqltype="cf_sql_varchar" value="#TRIM(ARGUMENTS.paetDescription)#">,
    paetSort = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.paetSort#">,
    paetStatus = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.paetStatus#">
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
    
    <cffunction name="updateProductAttributeType" access="public" returntype="struct">
    <cfargument name="ID" type="numeric" required="yes">
    <cfargument name="patName" type="string" required="yes">
    <cfargument name="patDescription" type="string" required="yes">
    <cfargument name="patSort" type="numeric" required="yes">
    <cfargument name="patStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully updated the record.">
    <cftry>
    <!---Check for profanity in the text.--->
    <cfinvoke 
    component="MCMS.component.utility.Regex"
    method="regexProfanity"
    returnvariable="regexProfanityRet">
    <cfinvokeargument name="profanityString" value="#TRIM(ARGUMENTS.patDescription)#"/>
    </cfinvoke>
    <!---Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.app.product.Product"
    method="getProductAttributeType"
    returnvariable="getCheckProductAttributeTypeRet">
    <cfinvokeargument name="excludeID" value="#ARGUMENTS.ID#"/>
    <cfinvokeargument name="patName" value="#TRIM(ARGUMENTS.patName)#"/>
    <cfinvokeargument name="patStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckProductAttributeTypeRet.recordcount NEQ 0>
    <cfset result.message = "The name #TRIM(ARGUMENTS.patName)# already exists, please enter a new name.">
    <cfelseif regexProfanityRet CONTAINS '$%&*!'>
    <cfset result.message = "Some text contained profanity, please remove any profanity from your text.">
    <!---Check length restriction.--->
    <cfelseif LEN(ARGUMENTS.patDescription) GT 2024>
    <cfset result.message = "The description is longer than 2024 characters, please enter a new description under 2024 characters.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_product_attribute_type SET
    patName = <cfqueryparam cfsqltype="cf_sql_varchar" value="#TRIM(ARGUMENTS.patName)#">,
    patDescription = <cfqueryparam cfsqltype="cf_sql_varchar" value="#TRIM(ARGUMENTS.patDescription)#">,
    patSort = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.patSort#">,
    patStatus = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.patStatus#">
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
    
    <cffunction name="updateProductAttributeValue" access="public" returntype="struct">
    <cfargument name="ID" type="numeric" required="yes">
    <cfargument name="paID" type="numeric" required="yes">
    <cfargument name="pavValue" type="string" required="yes">
    <cfargument name="pavCode" type="string" required="yes">
    <cfargument name="pavERPCode" type="string" required="yes">
    <cfargument name="pavPOSCode" type="string" required="yes">
    <cfargument name="imgID" type="numeric" required="yes">
    <cfargument name="pavSort" type="numeric" required="yes">
    <cfargument name="pavStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully updated the record.">
    <cftry>
    <!---Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.app.product.Product"
    method="getProductAttributeValue"
    returnvariable="getCheckProductAttributeValueRet">
    <cfinvokeargument name="excludeID" value="#ARGUMENTS.ID#"/>
    <cfinvokeargument name="paID" value="#ARGUMENTS.paID#"/>
    <cfinvokeargument name="pavValue" value="#TRIM(ARGUMENTS.pavValue)#"/>
    <cfinvokeargument name="pavStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckProductAttributeValueRet.recordcount NEQ 0>
    <cfset result.message = "The value #TRIM(ARGUMENTS.pavValue)# already exists for this attribute, please enter a new value.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_product_attribute_value SET
    paID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.paID#">,
    pavValue = <cfqueryparam cfsqltype="cf_sql_varchar" value="#TRIM(ARGUMENTS.pavValue)#">,
    pavCode = <cfqueryparam cfsqltype="cf_sql_varchar" value="#TRIM(ARGUMENTS.pavCode)#">,
    pavERPCode = <cfqueryparam cfsqltype="cf_sql_varchar" value="#TRIM(ARGUMENTS.pavERPCode)#">,
    pavPOSCode = <cfqueryparam cfsqltype="cf_sql_varchar" value="#TRIM(ARGUMENTS.pavPOSCode)#">,
    imgID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.imgID#">,
    pavDateUpdate = <cfqueryparam cfsqltype="cf_sql_timestamp" value="#Now()#">,
    userID = <cfqueryparam cfsqltype="cf_sql_integer" value="#session.userID#">,
    pavSort = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.pavSort#">,
    pavStatus = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.pavStatus#">
    WHERE ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ID#">
    </cfquery>
    <!---Now set all skus that use this product sku attribute and product sku attribute value - Ready for Export.--->
    <cfquery name="rsSkuList" datasource="#application.mcmsDSN#">
    SELECT pID, skuID, pName, productID, paName, pavValue FROM v_product_sku_attribute_rel 
    WHERE 0=0
    AND paID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.paID#">
    AND pavID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ID#">
    </cfquery>
    <cfif rsSkuList.recordcount NEQ 0>
    <cfloop query="rsSkuList">
    <cfinvoke 
    component="MCMS.component.app.product.Product" 
    method="updateProductStatus" 
    >
    <cfinvokeargument name="pID" value="#rsSkuList.pID#">
    <cfinvokeargument name="pesID" value="103">
    <cfinvokeargument name="pwfcComment" value="Product sku attribute value updated.">
    <cfinvokeargument name="pStatus" value="1">
    </cfinvoke>	
    <cflog text="The sku #rsSkuList.skuID# attribute value of #rsSkuList.paName# for #rsSkuList.pName# (#rsSkuList.productID#) has been updated to #rsSkuList.pavValue# and is now ready for export." log="application" type="information" file="skuAttributeValueUpdateLog">
	</cfloop>
    </cfif>
    </cftransaction>
    </cfif>
    <cfcatch type="any">
    <cfset result.message = "There was an error updating the record.">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="updateProductShipType" access="public" returntype="struct">
    <cfargument name="ID" type="numeric" required="yes">
    <cfargument name="smID" type="numeric" required="yes">
    <cfargument name="pstName" type="string" required="yes">
    <cfargument name="pstDescription" type="string" required="yes">
    <cfargument name="pstSort" type="numeric" required="yes">
    <cfargument name="pstStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully updated the record.">
    <cftry>
    <!---Check for profanity in the text.--->
    <cfinvoke 
    component="MCMS.component.utility.Regex"
    method="regexProfanity"
    returnvariable="regexProfanityRet">
    <cfinvokeargument name="profanityString" value="#TRIM(ARGUMENTS.pstDescription)#"/>
    </cfinvoke>
    <!---Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.app.product.Product"
    method="getProductShipType"
    returnvariable="getCheckProductShipTypeRet">
    <cfinvokeargument name="excludeID" value="#ARGUMENTS.ID#"/>
    <cfinvokeargument name="pstName" value="#TRIM(ARGUMENTS.pstName)#"/>
    <cfinvokeargument name="pstStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckProductShipTypeRet.recordcount NEQ 0>
    <cfset result.message = "The name #TRIM(ARGUMENTS.pstName)# already exists, please enter a new name.">
    <cfelseif regexProfanityRet CONTAINS '$%&*!'>
    <cfset result.message = "Some text contained profanity, please remove any profanity from your text.">
    <!---Check length restriction.--->
    <cfelseif LEN(ARGUMENTS.pstDescription) GT 2024>
    <cfset result.message = "The description is longer than 2024 characters, please enter a new description under 2024 characters.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_product_ship_type SET
    smID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.smID#">,
    pstName = <cfqueryparam cfsqltype="cf_sql_varchar" value="#TRIM(ARGUMENTS.pstName)#">,
    pstDescription = <cfqueryparam cfsqltype="cf_sql_varchar" value="#TRIM(ARGUMENTS.pstDescription)#">,
    pstSort = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.pstSort#">,
    pstStatus = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.pstStatus#">
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
    
    <cffunction name="updateProductType" access="public" returntype="struct">
    <cfargument name="ID" type="numeric" required="yes">
    <cfargument name="ptName" type="string" required="yes">
    <cfargument name="ptSort" type="numeric" required="yes">
    <cfargument name="ptStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully updated the record.">
    <cftry>
    <!---Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.app.product.Product"
    method="getProductType"
    returnvariable="getCheckProductTypeRet">
    <cfinvokeargument name="excludeID" value="#ARGUMENTS.ID#"/>
    <cfinvokeargument name="ptName" value="#TRIM(ARGUMENTS.ptName)#"/>
    <cfinvokeargument name="ptStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckProductTypeRet.recordcount NEQ 0>
    <cfset result.message = "The name #TRIM(ARGUMENTS.ptName)# already exists, please enter a new name.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_product_type SET
    ptName = <cfqueryparam cfsqltype="cf_sql_varchar" value="#TRIM(ARGUMENTS.ptName)#">,
    ptSort = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ptSort#">,
    ptStatus = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ptStatus#">
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
    
    <cffunction name="updateProductImageRel" access="public" returntype="struct">
    <cfargument name="ID" type="numeric" required="yes">
    <cfargument name="pID" type="numeric" required="yes">
    <cfargument name="imgID" type="numeric" required="yes">
    <cfargument name="pirPrimaryImage" type="numeric" required="yes">
    <cfargument name="pirSort" type="numeric" required="yes">
    <cfargument name="pirStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully updated the record.">
    <cftry>
    <!---Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.app.product.Product"
    method="getProductImageRel"
    returnvariable="getCheckProductImageRelRet">
    <cfinvokeargument name="excludeID" value="#ARGUMENTS.ID#"/>
    <cfinvokeargument name="pID" value="#ARGUMENTS.pID#"/>
    <cfinvokeargument name="imgID" value="#ARGUMENTS.imgID#"/>
    <cfinvokeargument name="pirStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckProductImageRelRet.recordcount NEQ 0>
    <cfset result.message = "The image relationship already exists, please select another image.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_product_image_rel SET
    pID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.pID#">,
    imgID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.imgID#">,
    pirPrimaryImage = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.pirPrimaryImage#">,
    pirSort = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.pirSort#">,
    pirStatus = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.pirStatus#">
    WHERE ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ID#">
    </cfquery>
    </cftransaction>
    <!---Make required updates to product status based on type of request.--->
    <cfinvoke 
    component="MCMS.component.app.product.Product" 
    method="updateProductStatus" 
    returnvariable="result">
    <cfinvokeargument name="pID" value="#ARGUMENTS.pID#">
    <cfinvokeargument name="pwfID" value="104">
    <cfinvokeargument name="pwfcComment" value="Product image update.">
    <cfinvokeargument name="pStatus" value="3">
    </cfinvoke>
    </cfif>
    <cfcatch type="any">
    <cfset result.message = "There was an error updating the record.">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="updateProductDepartmentCategoryRel" access="public" returntype="struct">
    <cfargument name="ID" type="numeric" required="yes">
    <cfargument name="paID" type="numeric" required="yes">
    <cfargument name="deptNo" type="numeric" required="yes">
    <cfargument name="catID" type="numeric" required="yes">
    <cfargument name="padcrStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully updated the record.">
    <cftry>
    <!---Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.app.product.Product"
    method="getProductDepartmentCategoryRel"
    returnvariable="getCheckProductDepartmentCategoryRelRet">
    <cfinvokeargument name="excludeID" value="#ARGUMENTS.ID#"/>
    <cfinvokeargument name="paID" value="#ARGUMENTS.paID#"/>
    <cfinvokeargument name="deptNo" value="#ARGUMENTS.deptNo#"/>
    <cfinvokeargument name="catID" value="#ARGUMENTS.catID#"/>
    <cfinvokeargument name="padcrStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckProductDepartmentCategoryRelRet.recordcount NEQ 0>
    <cfset result.message = "The product attribute already has this department/category relationship, please select another attribute.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_product_department_category_rel SET
    paID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.paID#">,
    deptNo = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.deptNo#">,
    catID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.catID#">,
    padcrStatus = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.padcrStatus#">
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
    
    <cffunction name="updateProductTemplate" access="public" returntype="struct">
    <cfargument name="ID" type="numeric" required="yes">
    <cfargument name="pTempName" type="string" required="yes">
    <cfargument name="pTempDescription" type="string" required="yes">
    <cfargument name="ptCode" type="string" required="yes">
    <cfargument name="ptERPCode" type="string" required="yes">
    <cfargument name="ptPOSCode" type="string" required="yes">
    <cfargument name="pTempFile" type="string" required="yes">
    <cfargument name="pTempSort" type="numeric" required="yes">
    <cfargument name="pTempStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully updated the record.">
    <cftry>
    <!---Check for profanity in the text.--->
    <cfinvoke 
    component="MCMS.component.utility.Regex"
    method="regexProfanity"
    returnvariable="regexProfanityRet">
    <cfinvokeargument name="profanityString" value="#TRIM(ARGUMENTS.pTempDescription)#"/>
    </cfinvoke>
    <!---Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.app.product.Product"
    method="getProductTemplate"
    returnvariable="getCheckProductTemplateRet">
    <cfinvokeargument name="excludeID" value="#ARGUMENTS.ID#"/>
    <cfinvokeargument name="pTempName" value="#TRIM(ARGUMENTS.pTempName)#"/>
    <cfinvokeargument name="pTempStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckProductTemplateRet.recordcount NEQ 0>
    <cfset result.message = "The name #TRIM(ARGUMENTS.pTempName)# already exists, please enter a new name.">
    <cfelseif regexProfanityRet CONTAINS '$%&*!'>
    <cfset result.message = "Some text contained profanity, please remove any profanity from your text.">
    <!---Check length restriction.--->
    <cfelseif LEN(ARGUMENTS.pTempDescription) GT 512>
    <cfset result.message = "The description is longer than 512 characters, please enter a new description under 512 characters.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_product_template SET
    pTempName = <cfqueryparam cfsqltype="cf_sql_varchar" value="#TRIM(ARGUMENTS.pTempName)#">,
    pTempDescription = <cfqueryparam cfsqltype="cf_sql_varchar" value="#TRIM(ARGUMENTS.pTempDescription)#">,
    ptCode = <cfqueryparam cfsqltype="cf_sql_varchar" value="#TRIM(ARGUMENTS.ptCode)#">,
    ptERPCode = <cfqueryparam cfsqltype="cf_sql_varchar" value="#TRIM(ARGUMENTS.ptERPCode)#">,
    ptPOSCode = <cfqueryparam cfsqltype="cf_sql_varchar" value="#TRIM(ARGUMENTS.ptPOSCode)#">,
    pTempFile = <cfqueryparam cfsqltype="cf_sql_varchar" value="#TRIM(ARGUMENTS.pTempFile)#">,
    cID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.cID#">,
    pTempSort = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.pTempSort#">,
    pTempStatus = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.pTempStatus#">
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
    
    <cffunction name="updateProductStatus" access="public" returntype="struct" hint="Update the product status and add a comment to the workflow.">
    <cfargument name="pID" type="numeric" required="yes">
    <cfargument name="pwfID" type="numeric" required="yes" default="101">
    <cfargument name="pwfcComment" type="string" required="yes" default="">
    <cfargument name="toEmail" type="string" required="yes" default="false">
    <cfargument name="pesID" type="numeric" required="yes" default="0">
    <cfargument name="pStatus" type="numeric" required="yes" default="3">
    <cfset result.message = "The product status has been updated. You may need to review the product again to ensure your changes are correct.">
    <cftry>
    <cfif ARGUMENTS.pesID EQ 104>
    <!---Remove the product from the export queue if it has been exported.--->
    <cfinvoke 
    component="MCMS.component.app.product_export.atg.ExportProductATG"
    method="deleteProductExportATG">
    <cfinvokeargument name="pID" value="#ARGUMENTS.pID#"/>
    </cfinvoke>
    <cfinvoke 
    component="MCMS.component.app.product_export.atg.ExportSkuATG"
    method="deleteSkuExportATG">
    <cfinvokeargument name="pID" value="#ARGUMENTS.pID#"/>
    </cfinvoke>
    <cfinvoke 
    component="MCMS.component.app.product_export.atg.ExportMediaATG"
    method="deleteMediaExportATG">
    <cfinvokeargument name="pID" value="#ARGUMENTS.pID#"/>
    </cfinvoke>
    </cfif>
    <!---Check the product status for active and update the export status to "ready".--->
    <cfif ARGUMENTS.pStatus EQ 1>
    <cfset this.pesID = 102>
    <cfelseif ARGUMENTS.pStatus EQ 2>
    <cfset this.pesID = 103>
    <!---Remove the product from the export queue.--->
    <cfinvoke 
    component="MCMS.component.app.product_export.atg.ExportProductATG"
    method="deleteProductExportATG">
    <cfinvokeargument name="pID" value="#ARGUMENTS.pID#"/>
    </cfinvoke>
    <cfinvoke 
    component="MCMS.component.app.product_export.atg.ExportSkuATG"
    method="deleteSkuExportATG">
    <cfinvokeargument name="pID" value="#ARGUMENTS.pID#"/>
    </cfinvoke>
    <cfinvoke 
    component="MCMS.component.app.product_export.atg.ExportMediaATG"
    method="deleteMediaExportATG">
    <cfinvokeargument name="pID" value="#ARGUMENTS.pID#"/>
    </cfinvoke>
    <cfelse>
    <cfset this.pesID = 101>
    <!---Remove the product from the export queue.--->
    <cfinvoke 
    component="MCMS.component.app.product_export.atg.ExportProductATG"
    method="deleteProductExportATG">
    <cfinvokeargument name="pID" value="#ARGUMENTS.pID#"/>
    </cfinvoke>
    <cfinvoke 
    component="MCMS.component.app.product_export.atg.ExportSkuATG"
    method="deleteSkuExportATG">
    <cfinvokeargument name="pID" value="#ARGUMENTS.pID#"/>
    </cfinvoke>
    <cfinvoke 
    component="MCMS.component.app.product_export.atg.ExportMediaATG"
    method="deleteMediaExportATG">
    <cfinvokeargument name="pID" value="#ARGUMENTS.pID#"/>
    </cfinvoke>
    </cfif>
    <cfif ARGUMENTS.pesID NEQ 0>
    <cfset this.pesID = ARGUMENTS.pesID>
    </cfif>   
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_product SET
    pesID = <cfqueryparam cfsqltype="cf_sql_integer" value="#this.pesID#">,
    pDateUpdate = <cfqueryparam cfsqltype="cf_sql_date" value="#DateFormat(Now(), application.dateFormat)#">,
    <cfif session.urID NEQ 102>
    userID = <cfqueryparam cfsqltype="cf_sql_integer" value="#session.userID#">,
    </cfif>
    pStatus = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.pStatus#">
    WHERE ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.pID#">
    </cfquery>
    </cftransaction>
    <!---Insert Product Workflow Comments.--->
    <cfinvoke 
    component="MCMS.component.app.product_workflow.ProductWorkflow"
    method="insertProductWorkflowComment">
    <cfinvokeargument name="pID" value="#ARGUMENTS.pID#"/>
    <cfinvokeargument name="pwfID" value="#ARGUMENTS.pwfID#"/>
    <cfinvokeargument name="pwfcComment" value="#ARGUMENTS.pwfcComment#"/>
    <cfinvokeargument name="userID" value="#session.userID#"/>
    <cfinvokeargument name="pwfcStatus" value="1"/>
    </cfinvoke>
    <!---Update category statuses.--->
    <cfinvoke 
    component="MCMS.component.app.category.Category"
    method="updateCategoryExportStatus">
    <cfinvokeargument name="pID" value="#ARGUMENTS.pID#"/>
    <cfinvokeargument name="cesID" value="102"/>
    </cfinvoke>
    <!---Send email if toEmail argument is not false.--->
    <cfif ARGUMENTS.toEmail NEQ false>
    <cfinvoke 
    component="MCMS.component.app.product.Product"
    method="getProduct"
    returnvariable="rs">
    <cfinvokeargument name="ID" value="#ARGUMENTS.pID#"/>
    <cfinvokeargument name="pStatus" value="1,2,3"/>
    </cfinvoke>
    <cfset this.emailBody = "
    <h3>#application.companyName# Product - #rs.pName# Update</div></h3>
	#LSDateFormat(Now())# - #LSTimeFormat(Now())#
	<br/>
	<p>
	#ARGUMENTS.pwfcComment#
	</p>
	<div align='center'><a href='//#CGI.SERVER_NAME#' class='textBold'>Commerce Dashboard</a></div>
	">
    <cfinvoke 
    component="MCMS.component.utility.Email"
    method="sendEmail">
    <cfinvokeargument name="subject" value="#application.companyName# - Product Update"/>
    <cfinvokeargument name="to" value="#ARGUMENTS.toEmail#"/>
    <cfinvokeargument name="from" value="#application.noReplyEmail#"/>
    <cfinvokeargument name="body" value="#this.emailBody#"/>
    <cfinvokeargument name="emailTemplate" value=""/>
    </cfinvoke>
    </cfif>
    <cfcatch type="any">
    <cfset result.message = "There was an error updating the record.">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="updateProductForStatus" access="public" returntype="struct" hint="Update the product status.">
    <cfargument name="pID" type="numeric" required="yes">
    <cfargument name="pStatus" type="numeric" required="yes" default="3">
    <cfset result.message = "The product status has been updated.">
    <cftry>
    <cfinvoke 
    component="MCMS.component.app.product.Product" 
    method="updateProductStatus" 
    returnvariable="result">
    <cfinvokeargument name="pID" value="#ARGUMENTS.pID#">
    <cfinvokeargument name="pwfID" value="101">
    <cfinvokeargument name="pwfcComment" value="Product status update.">
    <cfinvokeargument name="pStatus" value="#ARGUMENTS.pStatus#">
    </cfinvoke>
    <cfcatch type="any">
    <cfset result.message = "There was an error updating the record.">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="updateProductList" access="public" returntype="struct">
    <cfargument name="ID" type="numeric" required="yes">
    <cfargument name="pStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully updated the records.">
    <cftry>
    <!---Make required updates to product status based on type of request.--->
    <cfinvoke 
    component="MCMS.component.app.product.Product" 
    method="updateProductStatus" 
    returnvariable="result">
    <cfinvokeargument name="pID" value="#ARGUMENTS.ID#">
    <cfinvokeargument name="pwfID" value="101">
    <cfinvokeargument name="pwfcComment" value="Product status update.">
    <cfinvokeargument name="pStatus" value="#ARGUMENTS.pStatus#">
    </cfinvoke>
    <cfcatch type="any">
    <cfset result.message = "There was an error updating the records.">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="updateProductTypeList" access="public" returntype="struct">
    <cfargument name="ID" type="numeric" required="yes">
    <cfargument name="ptStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully updated the records.">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_product_type SET
    ptStatus = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ptStatus#">
    WHERE ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ID#">
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error updating the records.">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="updateProductShipTypeList" access="public" returntype="struct">
    <cfargument name="ID" type="numeric" required="yes">
    <cfargument name="pstStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully updated the records.">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_product_ship_type SET
    pstStatus = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.pstStatus#">
    WHERE ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ID#">
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error updating the records.">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="updateProductAttributeList" access="public" returntype="struct">
    <cfargument name="ID" type="numeric" required="yes">
    <cfargument name="paStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully updated the records.">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_product_attribute SET
    paStatus = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.paStatus#">
    WHERE ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ID#">
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error updating the records.">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="updateProductAttributeExtList" access="public" returntype="struct">
    <cfargument name="ID" type="numeric" required="yes">
    <cfargument name="paeStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully updated the records.">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_product_attribute_ext SET
    paeStatus = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.paeStatus#">
    WHERE ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ID#">
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error updating the records.">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="updateProductAttributeExtTypeList" access="public" returntype="struct">
    <cfargument name="ID" type="numeric" required="yes">
    <cfargument name="paetStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully updated the records.">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_product_attribute_ext_type SET
    paetStatus = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.paetStatus#">
    WHERE ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ID#">
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error updating the records.">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="updateProductAttributeTypeList" access="public" returntype="struct">
    <cfargument name="ID" type="numeric" required="yes">
    <cfargument name="patStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully updated the records.">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_product_attribute_type SET
    patStatus = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.patStatus#">
    WHERE ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ID#">
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error updating the records.">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="updateProductAttributeValueList" access="public" returntype="struct">
    <cfargument name="ID" type="numeric" required="yes">
    <cfargument name="pavStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully updated the records.">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_product_attribute_value SET
    pavStatus = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.pavStatus#">
    WHERE ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ID#">
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error updating the records.">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="updateProductAttributeDepartmentRelList" access="public" returntype="struct">
    <cfargument name="ID" type="numeric" required="yes">
    <cfargument name="padrStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully updated the records.">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_product_attibute_dept_rel SET
    padrStatus = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.padrStatus#">
    WHERE ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ID#">
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error updating the records.">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="updateProductDepartmentRelList" access="public" returntype="struct">
    <cfargument name="ID" type="numeric" required="yes">
    <cfargument name="pdrStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully updated the records.">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_product_department_rel SET
    pdrStatus = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.pdrStatus#">
    WHERE ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ID#">
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error updating the records.">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="updateProductRatingRelList" access="public" returntype="struct">
    <cfargument name="ID" type="numeric" required="yes">
    <cfargument name="prrStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully updated the records.">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_product_rating_rel SET
    prrStatus = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.prrStatus#">
    WHERE ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ID#">
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error updating the records.">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="updateProductTemplateList" access="public" returntype="struct">
    <cfargument name="ID" type="numeric" required="yes">
    <cfargument name="pTempStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully updated the records.">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_product_template SET
    pTempStatus = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.pTempStatus#">
    WHERE ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ID#">
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error updating the records.">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="deleteProduct" access="public" returntype="struct">
    <cfargument name="ID" type="string" required="yes">
    <cfset result.message = "You have successfully deleted the record(s).">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    DELETE FROM tbl_product
    WHERE ID IN (<cfqueryparam cfsqltype="cf_sql_integer" list="yes" value="#ARGUMENTS.ID#">)
    </cfquery>
    </cftransaction>
    <cfinvoke 
    component="MCMS.component.app.product.Product"
    method="deleteProductDetail">
    <cfinvokeargument name="pID" value="#ARGUMENTS.ID#"/>
    </cfinvoke>
    <cfinvoke 
    component="MCMS.component.app.product.Product"
    method="deleteProductCategoryRel">
    <cfinvokeargument name="pID" value="#ARGUMENTS.ID#"/>
    </cfinvoke>
    <cfinvoke 
    component="MCMS.component.app.product.Product"
    method="deleteProductSecondaryCategoryRel">
    <cfinvokeargument name="pID" value="#ARGUMENTS.ID#"/>
    </cfinvoke>
    <cfinvoke 
    component="MCMS.component.app.product.Product"
    method="deleteProductLineCategoryRel">
    <cfinvokeargument name="pID" value="#ARGUMENTS.ID#"/>
    </cfinvoke>
    <cfinvoke 
    component="MCMS.component.app.product.Product"
    method="deleteProductLineCategoryRel">
    <cfinvokeargument name="pID" value="#ARGUMENTS.ID#"/>
    </cfinvoke>
    <cfinvoke 
    component="MCMS.component.app.product.Product"
    method="deleteProductSecondaryLineCategoryRel">
    <cfinvokeargument name="pID" value="#ARGUMENTS.ID#"/>
    </cfinvoke>
    <cfinvoke 
    component="MCMS.component.app.product.Product"
    method="deleteProductImageRel">
    <cfinvokeargument name="pID" value="#ARGUMENTS.ID#"/>
    </cfinvoke>
    <cfinvoke 
    component="MCMS.component.app.product.Product"
    method="deleteProductDocumentRel">
    <cfinvokeargument name="pID" value="#ARGUMENTS.ID#"/>
    </cfinvoke>
    <cfinvoke 
    component="MCMS.component.app.product.Product"
    method="deleteProductAttributeRel">
    <cfinvokeargument name="pID" value="#ARGUMENTS.ID#"/>
    </cfinvoke>
    <cfinvoke 
    component="MCMS.component.app.product.Product"
    method="deleteProductAttributeExtRel">
    <cfinvokeargument name="pID" value="#ARGUMENTS.ID#"/>
    </cfinvoke>
    <cfinvoke 
    component="MCMS.component.app.product.Product"
    method="deleteProductSkuAttributeRel">
    <cfinvokeargument name="pID" value="#ARGUMENTS.ID#"/>
    </cfinvoke>
    <cfinvoke 
    component="MCMS.component.app.product.Product"
    method="deleteProductDepartmentRel">
    <cfinvokeargument name="pID" value="#ARGUMENTS.ID#"/>
    </cfinvoke>
    <cfinvoke 
    component="MCMS.component.app.product_export.atg.ExportProductATG"
    method="deleteProductExportATG">
    <cfinvokeargument name="pID" value="#ARGUMENTS.ID#"/>
    </cfinvoke>
    <!---Delete Catalog Relationships.--->
    <cfquery datasource="#application.mcmsDSN#">
    DELETE FROM tbl_catalog_product_rel
    WHERE pID IN (<cfqueryparam cfsqltype="cf_sql_integer" list="yes" value="#ARGUMENTS.ID#">)
    </cfquery>
    <!---Delete Cart Relationships.--->
    <cfquery datasource="#application.mcmsDSN#">
    DELETE FROM tbl_cart
    WHERE pID IN (<cfqueryparam cfsqltype="cf_sql_integer" list="yes" value="#ARGUMENTS.ID#">)
    </cfquery>
    <!---Delete Document Relationships.--->
    <cfquery datasource="#application.mcmsDSN#">
    DELETE FROM tbl_product_document_rel
    WHERE pID IN (<cfqueryparam cfsqltype="cf_sql_integer" list="yes" value="#ARGUMENTS.ID#">)
    </cfquery>
    <!---Delete Skus.--->
    <cfquery datasource="#application.mcmsDSN#">
    DELETE FROM tbl_sku
    WHERE pID IN (<cfqueryparam cfsqltype="cf_sql_integer" list="yes" value="#ARGUMENTS.ID#">)
    </cfquery>
    <!---Delete Price.--->
    <cfquery datasource="#application.mcmsDSN#">
    DELETE FROM tbl_price
    WHERE pID IN (<cfqueryparam cfsqltype="cf_sql_integer" list="yes" value="#ARGUMENTS.ID#">)
    </cfquery>
    <!---Delete Worflow Relationships.--->
    <cfquery datasource="#application.mcmsDSN#">
    DELETE FROM tbl_product_wf_comment
    WHERE pID IN (<cfqueryparam cfsqltype="cf_sql_integer" list="yes" value="#ARGUMENTS.ID#">)
    </cfquery>
    <cfquery datasource="#application.mcmsDSN#">
    DELETE FROM tbl_product_wf_status_rel
    WHERE pID IN (<cfqueryparam cfsqltype="cf_sql_integer" list="yes" value="#ARGUMENTS.ID#">)
    </cfquery>
    <cfquery datasource="#application.mcmsDSN#">
    DELETE FROM tbl_product_workflow_request
    WHERE pID IN (<cfqueryparam cfsqltype="cf_sql_integer" list="yes" value="#ARGUMENTS.ID#">)
    </cfquery>
    <cfcatch type="any">
    <cfset result.message = "There was an error deleting the record(s).">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="deleteProductDetail" access="public" returntype="struct">
    <cfargument name="ID" type="string" required="yes" default="0">
    <cfargument name="pID" type="string" required="yes" default="0">
    <cfset result.message = "You have successfully deleted the record(s).">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    DELETE FROM tbl_product_detail
    WHERE ID IN (<cfqueryparam cfsqltype="cf_sql_integer" list="yes" value="#ARGUMENTS.ID#">)
    OR pID IN (<cfqueryparam cfsqltype="cf_sql_integer" list="yes" value="#ARGUMENTS.pID#">)
    </cfquery>
    </cftransaction>
    <cfif ARGUMENTS.pID NEQ 0>
    <!---Make required updates to product status based on type of request.--->
    <cfinvoke 
    component="MCMS.component.app.product.Product" 
    method="updateProductStatus" 
    returnvariable="result">
    <cfinvokeargument name="pID" value="#ARGUMENTS.pID#">
    <cfinvokeargument name="pwfID" value="103">
    <cfinvokeargument name="pwfcComment" value="Product detail deleted.">
    <cfinvokeargument name="pStatus" value="3">
    </cfinvoke>
    </cfif>
    <cfcatch type="any">
    <cfset result.message = "There was an error deleting the record(s).">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="deleteProductType" access="public" returntype="struct">
    <cfargument name="ID" type="string" required="yes">
    <cfset result.message = "You have successfully deleted the record(s).">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    DELETE FROM tbl_product_type
    WHERE ID IN (<cfqueryparam cfsqltype="cf_sql_integer" list="yes" value="#ARGUMENTS.ID#">)
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error deleting the record(s).">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="deleteProductShipType" access="public" returntype="struct">
    <cfargument name="ID" type="string" required="yes">
    <cfset result.message = "You have successfully deleted the record(s).">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    DELETE FROM tbl_product_ship_type
    WHERE ID IN (<cfqueryparam cfsqltype="cf_sql_integer" list="yes" value="#ARGUMENTS.ID#">)
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error deleting the record(s).">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="deleteProductCategoryRel" access="public" returntype="struct">
    <cfargument name="ID" type="string" required="yes" default="0">
    <cfargument name="pID" type="string" required="yes" default="0">
    <cfargument name="cID" type="string" required="yes" default="0">
    <cfargument name="catID" type="string" required="yes" default="0">
    <cfset result.message = "You have successfully deleted the record(s).">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    DELETE FROM tbl_product_category_rel
    WHERE ID IN (<cfqueryparam cfsqltype="cf_sql_integer" list="yes" value="#ARGUMENTS.ID#">)
    OR (pID IN (<cfqueryparam cfsqltype="cf_sql_integer" list="yes" value="#ARGUMENTS.pID#">) 
    <cfif ARGUMENTS.cID NEQ 0>
    AND cID IN (<cfqueryparam cfsqltype="cf_sql_integer" list="yes" value="#ARGUMENTS.cID#">)
    </cfif> 
    <cfif ARGUMENTS.catID NEQ 0>
    AND catID IN (<cfqueryparam cfsqltype="cf_sql_integer" list="yes" value="#ARGUMENTS.catID#">)
    </cfif>
    )
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error deleting the record(s).">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="deleteProductSecondaryCategoryRel" access="public" returntype="struct">
    <cfargument name="ID" type="string" required="yes" default="0">
    <cfargument name="pID" type="string" required="yes" default="0">
    <cfargument name="cID" type="string" required="yes" default="0">
    <cfargument name="scatID" type="string" required="yes" default="0">
    <cfset result.message = "You have successfully deleted the record(s).">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    DELETE FROM tbl_product_sec_category_rel
    WHERE ID IN (<cfqueryparam cfsqltype="cf_sql_integer" list="yes" value="#ARGUMENTS.ID#">)
    OR (pID IN (<cfqueryparam cfsqltype="cf_sql_integer" list="yes" value="#ARGUMENTS.pID#">) 
    <cfif ARGUMENTS.cID NEQ 0>
    AND cID IN (<cfqueryparam cfsqltype="cf_sql_integer" list="yes" value="#ARGUMENTS.cID#">) 
    </cfif>
    <cfif ARGUMENTS.scatID NEQ 0>
    AND scatID IN (<cfqueryparam cfsqltype="cf_sql_integer" list="yes" value="#ARGUMENTS.scatID#">)
    </cfif>
    )
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error deleting the record(s).">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="deleteProductLineCategoryRel" access="public" returntype="struct">
    <cfargument name="ID" type="string" required="yes" default="0">
    <cfargument name="pID" type="string" required="yes" default="0">
    <cfargument name="cID" type="string" required="yes" default="0">
    <cfargument name="lcatID" type="string" required="yes" default="0">
    <cfset result.message = "You have successfully deleted the record(s).">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    DELETE FROM tbl_product_line_category_rel
    WHERE ID IN (<cfqueryparam cfsqltype="cf_sql_integer" list="yes" value="#ARGUMENTS.ID#">)
    OR (pID IN (<cfqueryparam cfsqltype="cf_sql_integer" list="yes" value="#ARGUMENTS.pID#">)
    <cfif ARGUMENTS.cID NEQ 0> 
    AND cID IN (<cfqueryparam cfsqltype="cf_sql_integer" list="yes" value="#ARGUMENTS.cID#">) 
    </cfif>
    <cfif ARGUMENTS.lcatID NEQ 0>
    AND lcatID IN (<cfqueryparam cfsqltype="cf_sql_integer" list="yes" value="#ARGUMENTS.lcatID#">)
    </cfif>
    )
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error deleting the record(s).">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="deleteProductSecondaryLineCategoryRel" access="public" returntype="struct">
    <cfargument name="ID" type="string" required="yes" default="0">
    <cfargument name="pID" type="string" required="yes" default="0">
    <cfargument name="cID" type="string" required="yes" default="0">
    <cfargument name="slcatID" type="string" required="yes" default="0">
    <cfset result.message = "You have successfully deleted the record(s).">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    DELETE FROM tbl_product_sec_line_cat_rel
    WHERE ID IN (<cfqueryparam cfsqltype="cf_sql_integer" list="yes" value="#ARGUMENTS.ID#">)
    OR (pID IN (<cfqueryparam cfsqltype="cf_sql_integer" list="yes" value="#ARGUMENTS.pID#">)
    <cfif ARGUMENTS.cID NEQ 0> 
    AND cID IN (<cfqueryparam cfsqltype="cf_sql_integer" list="yes" value="#ARGUMENTS.cID#">) 
    </cfif>
    <cfif ARGUMENTS.slcatID NEQ 0>
    AND slcatID IN (<cfqueryparam cfsqltype="cf_sql_integer" list="yes" value="#ARGUMENTS.slcatID#">)
    </cfif>
    )
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error deleting the record(s).">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="deleteProductImageRel" access="public" returntype="struct">
    <cfargument name="ID" type="string" required="yes" default="0">
    <cfargument name="pID" type="string" required="yes" default="0">
    <cfset result.message = "You have successfully deleted the record(s).">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    DELETE FROM tbl_product_image_rel
    WHERE ID IN (<cfqueryparam cfsqltype="cf_sql_integer" list="yes" value="#ARGUMENTS.ID#">)
    OR pID IN (<cfqueryparam cfsqltype="cf_sql_integer" list="yes" value="#ARGUMENTS.pID#">)
    </cfquery>
    </cftransaction>
    <cfif ARGUMENTS.pID NEQ 0>
    <!---Make required updates to product status based on type of request.--->
    <cfinvoke 
    component="MCMS.component.app.product.Product" 
    method="updateProductStatus" 
    returnvariable="result">
    <cfinvokeargument name="pID" value="#ARGUMENTS.pID#">
    <cfinvokeargument name="pwfID" value="104">
    <cfinvokeargument name="pwfcComment" value="Product image relationhip deleted.">
    <cfinvokeargument name="pStatus" value="3">
    </cfinvoke>
    </cfif>
    <cfcatch type="any">
    <cfset result.message = "There was an error deleting the record(s).">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction> 
    
    <cffunction name="deleteProductDocumentRel" access="public" returntype="struct">
    <cfargument name="ID" type="string" required="yes" default="0">
    <cfargument name="pID" type="string" required="yes" default="0">
    <cfset result.message = "You have successfully deleted the record(s).">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    DELETE FROM tbl_product_document_rel
    WHERE ID IN (<cfqueryparam cfsqltype="cf_sql_integer" list="yes" value="#ARGUMENTS.ID#">)
    OR pID IN (<cfqueryparam cfsqltype="cf_sql_integer" list="yes" value="#ARGUMENTS.pID#">)
    </cfquery>
    </cftransaction>
    <cfif ARGUMENTS.pID NEQ 0>
    <!---Make required updates to product status based on type of request.--->
    <cfinvoke 
    component="MCMS.component.app.product.Product" 
    method="updateProductStatus" 
    returnvariable="result">
    <cfinvokeargument name="pID" value="#ARGUMENTS.pID#">
    <cfinvokeargument name="pwfID" value="104">
    <cfinvokeargument name="pwfcComment" value="Product document relationship deleted.">
    <cfinvokeargument name="pStatus" value="3">
    </cfinvoke>
    </cfif>
    <cfcatch type="any">
    <cfset result.message = "There was an error deleting the record(s).">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="deleteProductAdItemRel" access="public" returntype="struct">
    <cfargument name="ID" type="string" required="yes" default="0">
    <cfargument name="pID" type="string" required="yes" default="0">
    <cfset result.message = "You have successfully deleted the record(s).">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    DELETE FROM tbl_product_ad_item_rel
    WHERE ID IN (<cfqueryparam cfsqltype="cf_sql_integer" list="yes" value="#ARGUMENTS.ID#">)
    OR pID IN (<cfqueryparam cfsqltype="cf_sql_integer" list="yes" value="#ARGUMENTS.pID#">)
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error deleting the record(s).">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="deleteProductAttributeRel" access="public" returntype="struct">
    <cfargument name="ID" type="string" required="yes" default="0">
    <cfargument name="paID" type="string" required="yes" default="0">
    <cfargument name="pID" type="string" required="yes" default="0">
    <cfset result.message = "You have successfully deleted the record(s).">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    DELETE FROM tbl_product_attribute_rel
    <cfif ARGUMENTS.paID NEQ 0 AND ARGUMENTS.pID NEQ 0>
    WHERE paID IN (<cfqueryparam cfsqltype="cf_sql_integer" list="yes" value="#ARGUMENTS.paID#">)
    AND pID IN (<cfqueryparam cfsqltype="cf_sql_integer" list="yes" value="#ARGUMENTS.pID#">)
    <cfelse>
    WHERE ID IN (<cfqueryparam cfsqltype="cf_sql_integer" list="yes" value="#ARGUMENTS.ID#">)
    OR pID IN (<cfqueryparam cfsqltype="cf_sql_integer" list="yes" value="#ARGUMENTS.pID#">)
    </cfif>
    </cfquery>
    <cfquery datasource="#application.mcmsDSN#">
    DELETE FROM tbl_product_sku_attribute_rel
    WHERE (pID IN (<cfqueryparam cfsqltype="cf_sql_integer" list="yes" value="#ARGUMENTS.pID#">)
    AND paID IN (<cfqueryparam cfsqltype="cf_sql_integer" list="yes" value="#ARGUMENTS.paID#">))
    </cfquery>
    </cftransaction>
    <cfif ARGUMENTS.pID NEQ 0>
    <!---Make required updates to product status based on type of request.--->
    <cfinvoke 
    component="MCMS.component.app.product.Product" 
    method="updateProductStatus" 
    returnvariable="result">
    <cfinvokeargument name="pID" value="#ARGUMENTS.pID#">
    <cfinvokeargument name="pwfID" value="105">
    <cfinvokeargument name="pwfcComment" value="Product attribute relationship deleted.">
    <cfinvokeargument name="pStatus" value="3">
    </cfinvoke>
    </cfif>
    <cfcatch type="any">
    <cfset result.message = "There was an error deleting the record(s).">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction> 
    
    <cffunction name="deleteProductAttributeExtRel" access="public" returntype="struct">
    <cfargument name="ID" type="string" required="yes" default="0">
    <cfargument name="cID" type="string" required="yes" default="0">
    <cfargument name="pID" type="string" required="yes" default="0">
    <cfargument name="paeID" type="string" required="yes" default="0">
    <cfset result.message = "You have successfully deleted the record(s).">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    DELETE FROM tbl_product_attribute_ext_rel
    WHERE ID IN (<cfqueryparam cfsqltype="cf_sql_integer" list="yes" value="#ARGUMENTS.ID#">)
    OR (
    pID IN (<cfqueryparam cfsqltype="cf_sql_integer" list="yes" value="#ARGUMENTS.pID#">)
    <cfif ARGUMENTS.cID NEQ 0>
    AND cID IN (<cfqueryparam cfsqltype="cf_sql_integer" list="yes" value="#ARGUMENTS.cID#">)
	</cfif>
    <cfif ARGUMENTS.paeID NEQ 0>
    AND paeID IN (<cfqueryparam cfsqltype="cf_sql_integer" list="yes" value="#ARGUMENTS.paeID#">)</cfif>
    )
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error deleting the record(s).">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>  
    
    <cffunction name="deleteProductAttribute" access="public" returntype="struct">
    <cfargument name="ID" type="string" required="yes">
    <cfset result.message = "You have successfully deleted the record(s).">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    DELETE FROM tbl_product_attribute
    WHERE ID IN (<cfqueryparam cfsqltype="cf_sql_integer" list="yes" value="#ARGUMENTS.ID#">)
    </cfquery>
    </cftransaction>
    <cfinvoke 
    component="MCMS.component.app.product.Product"
    method="deleteProductAttributeDepartmentRel"
    returnvariable="deleteProductAttributeDepartmentRelRet">
    <cfinvokeargument name="paID" value="#ARGUMENTS.ID#"/>
    </cfinvoke>
    <cfcatch type="any">
    <cfset result.message = "There was an error deleting the record(s).">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction> 
    
    <cffunction name="deleteProductSkuAttributeRel" access="public" returntype="struct">
    <cfargument name="ID" type="string" required="yes" default="0">
    <cfargument name="sID" type="string" required="yes" default="0">
    <cfargument name="pID" type="string" required="yes" default="0">
    <cfargument name="paID" type="string" required="yes" default="0">
    <cfset result.message = "You have successfully deleted the record(s).">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    DELETE FROM tbl_product_sku_attribute_rel
    WHERE ID IN (<cfqueryparam cfsqltype="cf_sql_integer" list="yes" value="#ARGUMENTS.ID#">)
    OR (sID IN (<cfqueryparam cfsqltype="cf_sql_integer" list="yes" value="#ARGUMENTS.sID#">)
    OR pID IN (<cfqueryparam cfsqltype="cf_sql_integer" list="yes" value="#ARGUMENTS.pID#">))
    <cfif ARGUMENTS.paID NEQ 0>
    AND paID IN (<cfqueryparam cfsqltype="cf_sql_integer" list="yes" value="#ARGUMENTS.paID#">)
    </cfif>
    </cfquery>
    </cftransaction>
    <cfif ARGUMENTS.pID NEQ 0>
    <!---Make required updates to product status based on type of request.--->
    <cfinvoke 
    component="MCMS.component.app.product.Product" 
    method="updateProductStatus" 
    returnvariable="result">
    <cfinvokeargument name="pID" value="#ARGUMENTS.pID#">
    <cfinvokeargument name="pwfID" value="107">
    <cfinvokeargument name="pwfcComment" value="Product sku attribute relationship deleted.">
    <cfinvokeargument name="pStatus" value="3">
    </cfinvoke>
    </cfif>
    <cfcatch type="any">
    <cfset result.message = "There was an error deleting the record(s).">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>

    <cffunction name="deleteProductAttributeType" access="public" returntype="struct">
    <cfargument name="ID" type="string" required="yes">
    <cfset result.message = "You have successfully deleted the record(s).">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    DELETE FROM tbl_product_attribute_type
    WHERE ID IN (<cfqueryparam cfsqltype="cf_sql_integer" list="yes" value="#ARGUMENTS.ID#">)
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error deleting the record(s).">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="deleteProductAttributeValue" access="public" returntype="struct">
    <cfargument name="ID" type="string" required="yes">
    <cfset result.message = "You have successfully deleted the record(s).">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    DELETE FROM tbl_product_attribute_value
    WHERE ID IN (<cfqueryparam cfsqltype="cf_sql_integer" list="yes" value="#ARGUMENTS.ID#">)
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error deleting the record(s).">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction> 
    
    <cffunction name="deleteProductAttributeExt" access="public" returntype="struct">
    <cfargument name="ID" type="string" required="yes">
    <cfset result.message = "You have successfully deleted the record(s).">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    DELETE FROM tbl_product_attribute_ext
    WHERE ID IN (<cfqueryparam cfsqltype="cf_sql_integer" list="yes" value="#ARGUMENTS.ID#">)
    </cfquery>
    </cftransaction>
    <cfinvoke 
    component="MCMS.component.app.product.Product"
    method="deleteProductAttributeExtDepartmentRel"
    returnvariable="deleteProductAttributeExtDepartmentRelRet">
    <cfinvokeargument name="paeID" value="#ARGUMENTS.ID#"/>
    </cfinvoke>
    <cfcatch type="any">
    <cfset result.message = "There was an error deleting the record(s).">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="deleteProductAttributeExtType" access="public" returntype="struct">
    <cfargument name="ID" type="string" required="yes">
    <cfset result.message = "You have successfully deleted the record(s).">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    DELETE FROM tbl_product_attribute_ext_type
    WHERE ID IN (<cfqueryparam cfsqltype="cf_sql_integer" list="yes" value="#ARGUMENTS.ID#">)
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error deleting the record(s).">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="deleteProductAttributeDepartmentRel" access="public" returntype="struct">
    <cfargument name="ID" type="string" required="yes" default="0">
    <cfargument name="paID" type="string" required="yes" default="0">
    <cfset result.message = "You have successfully deleted the record(s).">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    DELETE FROM tbl_product_attribute_dept_rel
    WHERE ID IN (<cfqueryparam cfsqltype="cf_sql_integer" list="yes" value="#ARGUMENTS.ID#">)
    OR paID IN (<cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.paID#">)
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error deleting the record(s).">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="deleteProductAttributeUOMRel" access="public" returntype="struct">
    <cfargument name="ID" type="string" required="yes" default="0">
    <cfargument name="paID" type="string" required="yes" default="0">
    <cfset result.message = "You have successfully deleted the record(s).">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    DELETE FROM tbl_product_attribute_uom_rel
    WHERE ID IN (<cfqueryparam cfsqltype="cf_sql_integer" list="yes" value="#ARGUMENTS.ID#">)
    OR paID IN (<cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.paID#">)
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error deleting the record(s).">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="deleteProductAttrSeparatorRel" access="public" returntype="struct">
    <cfargument name="ID" type="string" required="yes" default="0">
    <cfargument name="paID" type="string" required="yes" default="0">
    <cfset result.message = "You have successfully deleted the record(s).">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    DELETE FROM tbl_product_attr_separator_rel
    WHERE ID IN (<cfqueryparam cfsqltype="cf_sql_integer" list="yes" value="#ARGUMENTS.ID#">)
    OR paID IN (<cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.paID#">)
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error deleting the record(s).">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="deleteProductAttributeExtDepartmentRel" access="public" returntype="struct">
    <cfargument name="ID" type="string" required="yes" default="0">
    <cfargument name="paeID" type="string" required="yes" default="0">
    <cfset result.message = "You have successfully deleted the record(s).">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    DELETE FROM tbl_product_attr_ext_dept_rel
    WHERE ID IN (<cfqueryparam cfsqltype="cf_sql_integer" list="yes" value="#ARGUMENTS.ID#">)
    OR paeID IN (<cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.paeID#">)
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error deleting the record(s).">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction> 
    
    <cffunction name="deleteProductDepartmentRel" access="public" returntype="struct">
    <cfargument name="ID" type="string" required="yes" default="0">
    <cfargument name="cID" type="string" required="yes" default="0">
    <cfargument name="pID" type="string" required="yes" default="0">
    <cfargument name="deptNo" type="string" required="yes" default="0">
    <cfset result.message = "You have successfully deleted the record(s).">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    DELETE FROM tbl_product_department_rel
    WHERE ID IN (<cfqueryparam cfsqltype="cf_sql_integer" list="yes" value="#ARGUMENTS.ID#">)
    OR (pID IN (<cfqueryparam cfsqltype="cf_sql_integer" list="yes" value="#ARGUMENTS.pID#">) 
    <cfif ARGUMENTS.cID NEQ 0>AND cID IN (<cfqueryparam cfsqltype="cf_sql_integer" list="yes" value="#ARGUMENTS.cID#">)</cfif>
    <cfif ARGUMENTS.deptNo NEQ 0>AND deptNo IN (<cfqueryparam cfsqltype="cf_sql_integer" list="yes" value="#ARGUMENTS.deptNo#">)</cfif>)
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error deleting the record(s).">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="deleteProductTemplate" access="public" returntype="struct">
    <cfargument name="ID" type="string" required="yes">
    <cfset result.message = "You have successfully deleted the record(s).">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    DELETE FROM tbl_product_template
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