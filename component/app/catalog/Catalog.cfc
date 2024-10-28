<cfcomponent>
    <cffunction name="getCatalog" access="public" returntype="query" hint="Get Catalog data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="ID" type="string" required="yes" default="0">
    <cfargument name="excludeID" type="numeric" required="yes" default="0">
    <cfargument name="cName" type="string" required="yes" default="">
    <cfargument name="dID" type="string" required="yes" default="0">
    <cfargument name="cStatus" type="string" required="yes" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="cName">
    <cfset var rsCatalog = "" >
    <cftry>
    <cfquery name="rsCatalog" datasource="#application.mcmsDSN#">
    SELECT * FROM v_catalog WHERE 0=0
    <cfif ARGUMENTS.ID NEQ 0>
    AND ID IN (<cfqueryparam value="#ARGUMENTS.ID#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    <cfif ARGUMENTS.excludeID NEQ 0>
    AND ID <> <cfqueryparam value="#ARGUMENTS.excludeID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(cName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(cDescription) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">)
    </cfif>
    <cfif ARGUMENTS.cName NEQ "">
    AND UPPER(cName) = <cfqueryparam value="#UCASE(ARGUMENTS.cName)#" cfsqltype="cf_sql_varchar">
    </cfif>
    <cfif ARGUMENTS.dID NEQ 0>
    AND dID = <cfqueryparam value="#ARGUMENTS.dID#" cfsqltype="cf_sql_integer">
    </cfif>
    AND cStatus IN (<cfqueryparam value="#ARGUMENTS.cStatus#" list="yes" cfsqltype="cf_sql_integer">)
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsCatalog = StructNew()>
    <cfset rsCatalog.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsCatalog>
    </cffunction>
    
    <cffunction name="getCatalogSkuRel" access="public" returntype="query" hint="Get Catalog Sku Relationship data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="ID" type="string" required="yes" default="0">
    <cfargument name="excludeID" type="numeric" required="yes" default="0">
    <cfargument name="cID" type="numeric" required="yes" default="0">
    <cfargument name="pID" type="numeric" required="yes" default="0">
    <cfargument name="cName" type="string" required="yes" default="">
    <cfargument name="pName" type="string" required="yes" default="">
    <cfargument name="productID" type="string" required="yes" default="">
    <cfargument name="skuID" type="string" required="yes" default="">
    <cfargument name="skuMPN" type="string" required="yes" default="">
    <cfargument name="skuUPC" type="string" required="yes" default="">
	<cfargument name="skuStatus" type="string" required="yes" default="1,3">
    <cfargument name="cprStatus" type="string" required="yes" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="pName, skuID">
    <cfset var rsCatalogSkuRel = "" >
    <cftry>
    <cfquery name="rsCatalogSkuRel" datasource="#application.mcmsDSN#">
    SELECT * FROM v_catalog_sku_rel WHERE 0=0
    <cfif ARGUMENTS.ID NEQ 0>
    AND ID IN (<cfqueryparam value="#ARGUMENTS.ID#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    <cfif ARGUMENTS.excludeID NEQ 0>
    AND ID <> <cfqueryparam value="#ARGUMENTS.excludeID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(cName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(pName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(skuID) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(skuMPN) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(skuUPC) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(productID) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">)
    </cfif>
    <cfif ARGUMENTS.cID NEQ 0>
    AND cID = <cfqueryparam value="#ARGUMENTS.cID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.pID NEQ 0>
    AND pID = <cfqueryparam value="#ARGUMENTS.pID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.cName NEQ "">
    AND UPPER(cName) = <cfqueryparam value="#UCASE(ARGUMENTS.cName)#" cfsqltype="cf_sql_varchar">
    </cfif>
    <cfif ARGUMENTS.pName NEQ "">
    AND UPPER(pName) = <cfqueryparam value="#UCASE(ARGUMENTS.pName)#" cfsqltype="cf_sql_varchar">
    </cfif>
    <cfif ARGUMENTS.productID NEQ "">
    AND UPPER(productID) = <cfqueryparam value="#UCASE(ARGUMENTS.productID)#" cfsqltype="cf_sql_varchar">
    </cfif>
    <cfif ARGUMENTS.skuID NEQ "">
    AND UPPER(skuID) = <cfqueryparam value="#UCASE(ARGUMENTS.skuID)#" cfsqltype="cf_sql_varchar">
    </cfif>
    <cfif ARGUMENTS.skuMPN NEQ "">
    AND UPPER(skuMPN) = <cfqueryparam value="#UCASE(ARGUMENTS.skuMPN)#" cfsqltype="cf_sql_varchar">
    </cfif>
    <cfif ARGUMENTS.skuUPC NEQ "">
    AND UPPER(skuUPC) = <cfqueryparam value="#UCASE(ARGUMENTS.skuUPC)#" cfsqltype="cf_sql_varchar">
    </cfif>
    AND skuStatus IN (<cfqueryparam value="#ARGUMENTS.skuStatus#" list="yes" cfsqltype="cf_sql_integer">)
    AND cprStatus IN (<cfqueryparam value="#ARGUMENTS.cprStatus#" list="yes" cfsqltype="cf_sql_integer">)
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsCatalogSkuRel = StructNew()>
    <cfset rsCatalogSkuRel.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsCatalogSkuRel>
    </cffunction>
    
    <cffunction name="getCatalogAttribute" access="public" returntype="query" hint="Get Catalog Attribute data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="ID" type="numeric" required="yes" default="0">
    <cfargument name="excludeID" type="numeric" required="yes" default="0">
    <cfargument name="caName" type="string" required="yes" default="">
    <cfargument name="caStatus" type="string" required="yes" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="caName">
    <cfset var rsCatalogAttribute = "" >
    <cftry>
    <cfquery name="rsCatalogAttribute" datasource="#application.mcmsDSN#">
    SELECT * FROM v_catalog_attribute WHERE 0=0
    <cfif ARGUMENTS.ID NEQ 0>
    AND ID = <cfqueryparam value="#ARGUMENTS.ID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.excludeID NEQ 0>
    AND ID <> <cfqueryparam value="#ARGUMENTS.excludeID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(caName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(caDescription) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">)
    </cfif>
    <cfif ARGUMENTS.caName NEQ "">
    AND UPPER(caName) = <cfqueryparam value="#UCASE(ARGUMENTS.caName)#" cfsqltype="cf_sql_varchar">
    </cfif>
    AND caStatus IN (<cfqueryparam value="#ARGUMENTS.caStatus#" list="yes" cfsqltype="cf_sql_integer">)
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsCatalogAttribute = StructNew()>
    <cfset rsCatalogAttribute.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsCatalogAttribute>
    </cffunction>
    
    <cffunction name="getCatalogAttributeRel" access="public" returntype="query" hint="Get Catalog Attribute Rel. data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="ID" type="numeric" required="yes" default="0">
    <cfargument name="excludeID" type="numeric" required="yes" default="0">
    <cfargument name="caName" type="string" required="yes" default="">
    <cfargument name="cID" type="numeric" required="yes" default="0">
    <cfargument name="caID" type="numeric" required="yes" default="0">
    <cfargument name="carValue" type="string" required="yes" default="">
    <cfargument name="carStatus" type="string" required="yes" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="cID,caID">
    <cfset var rsCatalogAttributeRel = "" >
    <cftry>
    <cfquery name="rsCatalogAttributeRel" datasource="#application.mcmsDSN#">
    SELECT * FROM v_catalog_attribute_rel WHERE 0=0
    <cfif ARGUMENTS.ID NEQ 0>
    AND ID = <cfqueryparam value="#ARGUMENTS.ID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.excludeID NEQ 0>
    AND ID <> <cfqueryparam value="#ARGUMENTS.excludeID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(caName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(carValue) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(cName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">)
    </cfif>
    <cfif ARGUMENTS.caName NEQ "">
    AND UPPER(caName) = <cfqueryparam value="#UCASE(ARGUMENTS.caName)#" cfsqltype="cf_sql_varchar">
    </cfif>
    <cfif ARGUMENTS.carValue NEQ "">
    AND UPPER(carValue) = <cfqueryparam value="#UCASE(ARGUMENTS.carValue)#" cfsqltype="cf_sql_varchar">
    </cfif>
    <cfif ARGUMENTS.cID NEQ 0>
    AND cID = <cfqueryparam value="#ARGUMENTS.cID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.caID NEQ 0>
    AND caID = <cfqueryparam value="#ARGUMENTS.caID#" cfsqltype="cf_sql_integer">
    </cfif>
    AND carStatus IN (<cfqueryparam value="#ARGUMENTS.carStatus#" list="yes" cfsqltype="cf_sql_integer">)
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsCatalogAttributeRel = StructNew()>
    <cfset rsCatalogAttributeRel.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsCatalogAttributeRel>
    </cffunction>
    
    <cffunction name="getCatalogProductRel" access="public" returntype="query" hint="Get Catalog Product Rel. data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="ID" type="numeric" required="yes" default="0">
    <cfargument name="excludeID" type="numeric" required="yes" default="0">
    <cfargument name="cName" type="string" required="yes" default="">
    <cfargument name="cID" type="numeric" required="yes" default="0">
    <cfargument name="pID" type="numeric" required="yes" default="0">
    <cfargument name="cprDateExp" type="string" required="yes" default="">
    <cfargument name="cprStatus" type="string" required="yes" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="cID">
    <cfset var rsCatalogProductRel = "" >
    <cftry>
    <cfquery name="rsCatalogProductRel" datasource="#application.mcmsDSN#">
    SELECT * FROM v_catalog_product_rel WHERE 0=0
    <cfif ARGUMENTS.ID NEQ 0>
    AND ID = <cfqueryparam value="#ARGUMENTS.ID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.excludeID NEQ 0>
    AND ID <> <cfqueryparam value="#ARGUMENTS.excludeID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(cName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">)
    </cfif>
    <cfif ARGUMENTS.cName NEQ "">
    AND UPPER(cName) = <cfqueryparam value="#UCASE(ARGUMENTS.cName)#" cfsqltype="cf_sql_varchar">
    </cfif>
    <cfif ARGUMENTS.cID NEQ 0>
    AND cID = <cfqueryparam value="#ARGUMENTS.cID#" cfsqltype="zcf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.pID NEQ 0>
    AND pID = <cfqueryparam value="#ARGUMENTS.pID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.cprDateExp NEQ "">
    AND cprDateExp >= <cfqueryparam value="#DateFormat(ARGUMENTS.cprDateExp, application.dateFormat)#" cfsqltype="cf_sql_date">
    </cfif>
    AND cprStatus IN (<cfqueryparam value="#ARGUMENTS.cprStatus#" list="yes" cfsqltype="cf_sql_integer">)
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsCatalogProductRel = StructNew()>
    <cfset rsCatalogProductRel.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsCatalogProductRel>
    </cffunction>
    
    <cffunction name="getCatalogShipMethodRel" access="public" returntype="query" hint="Get Catalog Ship Method Rel. data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="ID" type="numeric" required="yes" default="0">
    <cfargument name="excludeID" type="numeric" required="yes" default="0">
    <cfargument name="smName" type="string" required="yes" default="">
    <cfargument name="cID" type="numeric" required="yes" default="0">
    <cfargument name="smID" type="string" required="yes" default="0">
    <cfargument name="csmrStatus" type="string" required="yes" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="cID">
    <cfset var rsCatalogShipMethodRel = "" >
    <cftry>
    <cfquery name="rsCatalogShipMethodRel" datasource="#application.mcmsDSN#">
    SELECT * FROM v_catalog_sm_rel WHERE 0=0
    <cfif ARGUMENTS.ID NEQ 0>
    AND ID = <cfqueryparam value="#ARGUMENTS.ID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.excludeID NEQ 0>
    AND ID <> <cfqueryparam value="#ARGUMENTS.excludeID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(smName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">)
    </cfif>
    <cfif ARGUMENTS.smName NEQ "">
    AND UPPER(smName) = <cfqueryparam value="#UCASE(ARGUMENTS.smName)#" cfsqltype="cf_sql_varchar">
    </cfif>
    <cfif ARGUMENTS.cID NEQ 0>
    AND cID = <cfqueryparam value="#ARGUMENTS.cID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.smID NEQ 0>
    AND smID IN (<cfqueryparam value="#ARGUMENTS.smID#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    AND csmrStatus IN (<cfqueryparam value="#ARGUMENTS.csmrStatus#" list="yes" cfsqltype="cf_sql_integer">)
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsCatalogShipMethodRel = StructNew()>
    <cfset rsCatalogShipMethodRel.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsCatalogShipMethodRel>
    </cffunction>
    
    <cffunction name="getCatalogUserRel" access="public" returntype="query" hint="Get Catalog User Rel. data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="ID" type="numeric" required="yes" default="0">
    <cfargument name="excludeID" type="numeric" required="yes" default="0">
    <cfargument name="cName" type="string" required="yes" default="">
    <cfargument name="cID" type="numeric" required="yes" default="0">
    <cfargument name="userID" type="numeric" required="yes" default="0">
    <cfargument name="curStatus" type="string" required="yes" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="cID">
    <cfset var rsCatalogUserRel = "" >
    <cftry>
    <cfquery name="rsCatalogUserRel" datasource="#application.mcmsDSN#">
    SELECT * FROM v_catalog_user_rel WHERE 0=0
    <cfif ARGUMENTS.ID NEQ 0>
    AND ID = <cfqueryparam value="#ARGUMENTS.ID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.excludeID NEQ 0>
    AND ID <> <cfqueryparam value="#ARGUMENTS.excludeID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(cName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(userLName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">OR UPPER(userFName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">)
    </cfif>
    <cfif ARGUMENTS.cName NEQ "">
    AND UPPER(cName) = <cfqueryparam value="#UCASE(ARGUMENTS.cName)#" cfsqltype="cf_sql_varchar">
    </cfif>
    <cfif ARGUMENTS.cID NEQ 0>
    AND cID = <cfqueryparam value="#ARGUMENTS.cID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.userID NEQ 0>
    AND userID = <cfqueryparam value="#ARGUMENTS.userID#" cfsqltype="cf_sql_integer">
    </cfif>
    AND curStatus IN (<cfqueryparam value="#ARGUMENTS.curStatus#" list="yes" cfsqltype="cf_sql_integer">)
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsCatalogUserRel = StructNew()>
    <cfset rsCatalogUserRel.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsCatalogUserRel>
    </cffunction>

    <cffunction name="getCatalogReport" access="public" returntype="query" hint="Get Catalog Report data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="orderBy" type="string" required="yes" default="cName">
    <cfset var rsCatalogReport = "" >
    <cftry>
    <cfquery name="rsCatalogReport" datasource="#application.mcmsDSN#">
    SELECT cName AS Name, TO_CHAR(cDescription) AS Description, To_CHAR(cDate, 'MM/DD/YYYY') AS Create_Date, To_CHAR(cDateExp, 'MM/DD/YYYY') AS Expire_Date, dName AS Domain, TO_CHAR(userFName || ' ' || userLName) AS Username, sName AS Status FROM v_catalog WHERE 0=0
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(cName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(cDescription) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">)
    </cfif>
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsCatalogReport = StructNew()>
    <cfset rsCatalogReport.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsCatalogReport>
    </cffunction>
    
    <cffunction name="getCatalogAttributeRelReport" access="public" returntype="query" hint="Get Catalog Attribute Rel. Report data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="orderBy" type="string" required="yes" default="cName">
    <cfset var rsCatalogReport = "" >
    <cftry>
    <cfquery name="rsCatalogReport" datasource="#application.mcmsDSN#">
    SELECT caName AS Name, cName AS Catalog, carValue AS Value, TO_CHAR(carDate,'MM/DD/YYYY') AS Car_Date, TO_CHAR(carDateUpdate,'MM/DD/YYYY') AS Date_Update, sName AS Status FROM v_catalog_attribute_rel WHERE 0=0
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(caName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(carValue) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(cName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">)
    </cfif>
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsCatalogReport = StructNew()>
    <cfset rsCatalogReport.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsCatalogReport>
    </cffunction>
    
    <cffunction name="getCatalogUserRelReport" access="public" returntype="query" hint="Get Catalog User Rel. Report data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="orderBy" type="string" required="yes" default="cName">
    <cfset var rsCatalogUserRelReport = "" >
    <cftry>
    <cfquery name="rsCatalogUserRelReport" datasource="#application.mcmsDSN#">
    SELECT cName AS Catalog, TO_CHAR(userFName || ' ' || userLName) AS Username, sName AS Status FROM v_catalog_user_rel WHERE 0=0
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(userLName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(cName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">)
    </cfif>
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsCatalogUserRelReport = StructNew()>
    <cfset rsCatalogUserRelReport.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsCatalogUserRelReport>
    </cffunction>
    
    <cffunction name="insertCatalog" access="public" returntype="struct">
    <cfargument name="cName" type="string" required="yes">
    <cfargument name="cDescription" type="string" required="yes">
    <cfargument name="cDateExp" type="string" required="yes">
    <cfargument name="dID" type="numeric" required="yes">
    <cfargument name="smID" type="string" required="yes">
    <cfargument name="userID" type="numeric" required="yes">
    <cfargument name="cStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully inserted the record.">
    <cftry>
    <!---Check for profanity in the text.--->
    <cfinvoke 
    component="MCMS.component.utility.Regex"
    method="regexProfanity"
    returnvariable="regexProfanityRet">
    <cfinvokeargument name="profanityString" value="#TRIM(ARGUMENTS.cDescription)#"/>
    </cfinvoke>
    <!---Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.app.catalog.Catalog"
    method="getCatalog"
    returnvariable="getCheckCatalogRet">
    <cfinvokeargument name="cName" value="#TRIM(ARGUMENTS.cName)#"/>
    <cfinvokeargument name="cStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckCatalogRet.recordcount NEQ 0>
    <cfset result.message = "The name #TRIM(ARGUMENTS.cName)# already exists, please enter a new name.">
    <cfelseif regexProfanityRet CONTAINS '$%&*!'>
    <cfset result.message = "Some text contained profanity, please remove any profanity from your text.">
    <!---Check length restriction.--->
    <cfelseif LEN(ARGUMENTS.cDescription) GT 2048>
    <cfset result.message = "The description is longer than 2048 characters, please enter a new description under 2048 characters.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    INSERT INTO tbl_catalog (cName,cDescription,cDateExp,dID,userID,cStatus) VALUES
    (
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#TRIM(ARGUMENTS.cName)#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#TRIM(ARGUMENTS.cDescription)#">,
    <cfqueryparam cfsqltype="cf_sql_date" value="#ARGUMENTS.cDateExp#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.dID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.userID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.cStatus#">
    )
    </cfquery>
    </cftransaction>
    <!--- Get newly inserted catalog ID. --->
    <cfinvoke 
    component="MCMS.component.cms.Cms"
    method="getMaxValueSQL"
    returnvariable="cID">
    <cfinvokeargument name="tableName" value="tbl_catalog"/>
    </cfinvoke>
    <cfset var.cID = cID>
    <!---Create catalog/ship method relationships.--->
    <cfloop index="i" from="1" to="#ListLen(ARGUMENTS.smID)#">
    <cfinvoke 
    component="MCMS.component.app.catalog.Catalog"
    method="insertCatalogShipMethodRel"
    returnvariable="insertCatalogShipMethodRelRet">
    <cfinvokeargument name="cID" value="#var.cID#"/>
    <cfinvokeargument name="smID" value="#ListGetAt(ARGUMENTS.smID, i)#"/>
    <cfinvokeargument name="csmrStatus" value="1"/>
    </cfinvoke>
    </cfloop>
    </cfif>
    <cfcatch type="any">
    <cfset result.message = "There was an error inserting the record.">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="insertCatalogShipMethodRel" access="public" returntype="struct">
    <cfargument name="cID" type="numeric" required="yes">
    <cfargument name="smID" type="numeric" required="yes">
    <cfargument name="csmrStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully inserted the record.">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    INSERT INTO tbl_catalog_sm_rel (cID,smID,csmrStatus) VALUES
    (
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.cID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.smID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.csmrStatus#">
    )
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error inserting the record.">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="insertCatalogAttribute" access="public" returntype="struct">
    <cfargument name="caName" type="string" required="yes">
    <cfargument name="caDescription" type="string" required="yes">
    <cfargument name="userID" type="numeric" required="yes">
    <cfargument name="caStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully inserted the record.">
    <cftry>
    <!---Check for profanity in the text.--->
    <cfinvoke 
    component="MCMS.component.utility.Regex"
    method="regexProfanity"
    returnvariable="regexProfanityRet">
    <cfinvokeargument name="profanityString" value="#TRIM(ARGUMENTS.caDescription)#"/>
    </cfinvoke>
    <!---Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.app.catalog.Catalog"
    method="getCatalogAttribute"
    returnvariable="getCheckCatalogAttributeRet">
    <cfinvokeargument name="caName" value="#TRIM(ARGUMENTS.caName)#"/>
    <cfinvokeargument name="caStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckCatalogAttributeRet.recordcount NEQ 0>
    <cfset result.ID = 0>
    <cfset result.message = "The name #TRIM(ARGUMENTS.caName)# already exists, please enter a new name.">
    <cfelseif regexProfanityRet CONTAINS '$%&*!'>
    <cfset result.message = "Some text contained profanity, please remove any profanity from your text.">
    <!---Check length restriction.--->
    <cfelseif LEN(ARGUMENTS.caDescription) GT 2048>
    <cfset result.message = "The description is longer than 2048 characters, please enter a new description under 2048 characters.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    INSERT INTO tbl_catalog_attribute (caName,caDescription,userID,caStatus) VALUES
    (
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#TRIM(ARGUMENTS.caName)#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#TRIM(ARGUMENTS.caDescription)#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.userID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.caStatus#">
    )
    </cfquery>
    </cftransaction>
    <!--- Get newly inserted catalog attribute ID. --->
    <cfinvoke 
    component="MCMS.component.cms.Cms"
    method="getMaxValueSQL"
    returnvariable="caID">
    <cfinvokeargument name="tableName" value="tbl_catalog_attribute"/>
    </cfinvoke>
    <cfset result.ID = caID>
    </cfif>
    <cfcatch type="any">
    <cfset result.message = "There was an error inserting the record.">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="insertCatalogAttributeRel" access="public" returntype="struct">
    <cfargument name="cID" type="numeric" required="yes">
    <cfargument name="caID" type="numeric" required="yes">
    <cfargument name="carValue" type="string" required="yes">
    <cfargument name="userID" type="numeric" required="yes">
    <cfargument name="carStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully inserted the record. <br/>You must now perform an application reset. <a href='/#application.mcmsAppAdminPath#/?mcmsReset=true'>Click here</a>.">
    <cftry>
    <!---Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.app.catalog.Catalog"
    method="getCatalogAttributeRel"
    returnvariable="getCheckCatalogAttributeRelRet">
    <cfinvokeargument name="cID" value="#ARGUMENTS.cID#"/>
    <cfinvokeargument name="caID" value="#ARGUMENTS.caID#"/>
    <cfinvokeargument name="caValue" value="#TRIM(ARGUMENTS.carValue)#"/>
    <cfinvokeargument name="carStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckCatalogAttributeRelRet.recordcount NEQ 0>
    <cfset result.message = "The value #TRIM(ARGUMENTS.carValue)# already exists for this catalog, please enter a new value.">
    <!---Check length restriction.--->
    <cfelseif LEN(ARGUMENTS.carValue) GT 2048>
    <cfset result.message = "The value is longer than 2048 characters, please enter a new value under 2048 characters.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    INSERT INTO tbl_catalog_attribute_rel (cID,caID,carValue,userID,carStatus) VALUES
    (
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.cID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.caID#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.carValue#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.userID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.carStatus#">
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
    
    <cffunction name="insertCatalogProductRel" access="public" returntype="struct">
    <cfargument name="cID" type="numeric" required="yes">
    <cfargument name="pID" type="numeric" required="yes">
    <cfargument name="cprDiscount" type="numeric" required="yes" default="0">
    <cfargument name="cprDateExp" type="string" required="yes">
    <cfargument name="cprStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully inserted the record.">
    <cftry>
    <!---Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.app.catalog.Catalog"
    method="getCatalogProductRel"
    returnvariable="getCheckCatalogProductRelRet">
    <cfinvokeargument name="cID" value="#ARGUMENTS.cID#"/>
    <cfinvokeargument name="pID" value="#ARGUMENTS.pID#"/>
    <cfinvokeargument name="cprStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckCatalogProductRelRet.recordcount NEQ 0>
    <cfset result.message = "The relationship already exists, please try again.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    INSERT INTO tbl_catalog_product_rel (cID,pID,cprDiscount,cprDateExp,cprStatus) VALUES
    (
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.cID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.pID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.cprDiscount#">,
    <cfqueryparam cfsqltype="cf_sql_date" value="#DateFormat(ARGUMENTS.cprDateExp, application.dateFormat)#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.cprStatus#">
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
    
    <cffunction name="insertCatalogUserRel" access="public" returntype="struct">
    <cfargument name="cID" type="numeric" required="yes">
    <cfargument name="userID" type="numeric" required="yes">
    <cfargument name="curStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully inserted the record.">
    <cftry>
    <!---Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.app.catalog.Catalog"
    method="getCatalogUserRel"
    returnvariable="getCheckCatalogUserRelRet">
    <cfinvokeargument name="cID" value="#ARGUMENTS.cID#"/>
    <cfinvokeargument name="userID" value="#ARGUMENTS.userID#"/>
    <cfinvokeargument name="curStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckCatalogUserRelRet.recordcount NEQ 0>
    <cfset result.message = "The relationship already exists, please try again.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    INSERT INTO tbl_catalog_user_rel (cID,userID,curStatus) VALUES
    (
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.cID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.userID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.curStatus#">
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
    
    <cffunction name="updateCatalog" access="public" returntype="struct">
    <cfargument name="ID" type="numeric" required="yes">
    <cfargument name="cName" type="string" required="yes">
    <cfargument name="cDescription" type="string" required="yes">
    <cfargument name="cDateExp" type="string" required="yes">
    <cfargument name="dID" type="numeric" required="yes">
    <cfargument name="smID" type="string" required="yes">
    <cfargument name="userID" type="numeric" required="yes">
    <cfargument name="cStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully updated the record.">
    <cftry>
    <!---Check for profanity in the text.--->
    <cfinvoke 
    component="MCMS.component.utility.Regex"
    method="regexProfanity"
    returnvariable="regexProfanityRet">
    <cfinvokeargument name="profanityString" value="#TRIM(ARGUMENTS.cDescription)#"/>
    </cfinvoke>
    <!---Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.app.catalog.Catalog"
    method="getCatalog"
    returnvariable="getCheckCatalogRet">
    <cfinvokeargument name="excludeID" value="#ARGUMENTS.ID#"/>
    <cfinvokeargument name="cName" value="#TRIM(ARGUMENTS.cName)#"/>
    <cfinvokeargument name="cStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckCatalogRet.recordcount NEQ 0>
    <cfset result.message = "The name #TRIM(ARGUMENTS.cName)# already exists, please enter a new name.">
    <cfelseif regexProfanityRet CONTAINS '$%&*!'>
    <cfset result.message = "Some text contained profanity, please remove any profanity from your text.">
    <!---Check length restriction.--->
    <cfelseif LEN(ARGUMENTS.cDescription) GT 2048>
    <cfset result.message = "The description is longer than 2048 characters, please enter a new description under 2048 characters.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_catalog SET
    cName = <cfqueryparam cfsqltype="cf_sql_varchar" value="#TRIM(ARGUMENTS.cName)#">,
    cDescription = <cfqueryparam cfsqltype="cf_sql_varchar" value="#TRIM(ARGUMENTS.cDescription)#">,
    cDateExp = <cfqueryparam cfsqltype="cf_sql_date" value="#ARGUMENTS.cDateExp#">,
    dID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.dID#">,
    userID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.userID#">,
    cStatus = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.cStatus#">
    WHERE ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ID#">
    </cfquery>
    </cftransaction>
    <!---Delete any existing relationships.--->
    <cfinvoke 
    component="MCMS.component.app.catalog.Catalog"
    method="deleteCatalogShipMethodRel"
    returnvariable="deleteCatalogShipMethodRelRet">
    <cfinvokeargument name="cID" value="#ARGUMENTS.ID#"/>
    </cfinvoke>
    <!---Create catalog/ship method relationships.--->
    <cfloop index="i" from="1" to="#ListLen(ARGUMENTS.smID)#">
    <cfinvoke 
    component="MCMS.component.app.catalog.Catalog"
    method="insertCatalogShipMethodRel"
    returnvariable="insertCatalogShipMethodRelRet">
    <cfinvokeargument name="cID" value="#ARGUMENTS.ID#"/>
    <cfinvokeargument name="smID" value="#ListGetAt(ARGUMENTS.smID, i)#"/>
    <cfinvokeargument name="csmrStatus" value="1"/>
    </cfinvoke>
    </cfloop>
    </cfif>
    <cfcatch type="any">
    <cfset result.message = "There was an error updating the record.">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="updateCatalogAttribute" access="public" returntype="struct">
    <cfargument name="ID" type="numeric" required="yes">
    <cfargument name="caName" type="string" required="yes">
    <cfargument name="caDescription" type="string" required="yes">
    <cfargument name="userID" type="numeric" required="yes">
    <cfargument name="caStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully updated the record.">
    <cftry>
    <!---Check for profanity in the text.--->
    <cfinvoke 
    component="MCMS.component.utility.Regex"
    method="regexProfanity"
    returnvariable="regexProfanityRet">
    <cfinvokeargument name="profanityString" value="#TRIM(ARGUMENTS.caDescription)#"/>
    </cfinvoke>
    <!---Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.app.catalog.Catalog"
    method="getCatalogAttribute"
    returnvariable="getCheckCatalogAttributeRet">
    <cfinvokeargument name="excludeID" value="#ARGUMENTS.ID#"/>
    <cfinvokeargument name="caName" value="#TRIM(ARGUMENTS.caName)#"/>
    <cfinvokeargument name="caStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckCatalogAttributeRet.recordcount NEQ 0>
    <cfset result.message = "The name #TRIM(ARGUMENTS.caName)# already exists, please enter a new name.">
    <cfelseif regexProfanityRet CONTAINS '$%&*!'>
    <cfset result.message = "Some text contained profanity, please remove any profanity from your text.">
    <!---Check length restriction.--->
    <cfelseif LEN(ARGUMENTS.caDescription) GT 2048>
    <cfset result.message = "The description is longer than 2048 characters, please enter a new description under 2048 characters.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_catalog_attribute SET
    caName = <cfqueryparam cfsqltype="cf_sql_varchar" value="#TRIM(ARGUMENTS.caName)#">,
    caDescription = <cfqueryparam cfsqltype="cf_sql_varchar" value="#TRIM(ARGUMENTS.caDescription)#">,
    userID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.userID#">,
    caStatus = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.caStatus#">
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
    
    <cffunction name="updateCatalogAttributeRel" access="public" returntype="struct">
    <cfargument name="ID" type="numeric" required="yes">
    <cfargument name="caID" type="numeric" required="yes">
    <cfargument name="carValue" type="string" required="yes">
    <cfargument name="userID" type="numeric" required="yes">
    <cfargument name="carStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully updated the record. <br/>You must now perform an application reset. <a href='/#application.mcmsAppAdminPath#/?mcmsReset=true'>Click here</a>.">
    <cftry>
    <!---Check for profanity in the text.--->
    <cfinvoke 
    component="MCMS.component.utility.Regex"
    method="regexProfanity"
    returnvariable="regexProfanityRet">
    <cfinvokeargument name="profanityString" value="#TRIM(ARGUMENTS.carValue)#"/>
    </cfinvoke>
    <!---Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.app.catalog.Catalog"
    method="getCatalogAttributeRel"
    returnvariable="getCheckCatalogAttributeRelRet">
    <cfinvokeargument name="excludeID" value="#ARGUMENTS.ID#"/>
    <cfinvokeargument name="cID" value="#ARGUMENTS.ID#"/>
    <cfinvokeargument name="caID" value="#ARGUMENTS.caID#"/>
    <cfinvokeargument name="carValue" value="#TRIM(ARGUMENTS.carValue)#"/>
    <cfinvokeargument name="carStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckCatalogAttributeRelRet.recordcount NEQ 0>
    <cfset result.message = "The value #TRIM(ARGUMENTS.carValue)# already exists for this catalog, please enter a new value.">
    <cfelseif regexProfanityRet CONTAINS '$%&*!'>
    <cfset result.message = "Some text contained profanity, please remove any profanity from your text.">
    <!---Check length restriction.--->
    <cfelseif LEN(ARGUMENTS.carValue) GT 2048>
    <cfset result.message = "The value is longer than 2048 characters, please enter a new value under 2048 characters.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_catalog_attribute_rel SET
    carValue = <cfqueryparam cfsqltype="cf_sql_varchar" value="#TRIM(ARGUMENTS.carValue)#">,
    carDateUpdate = <cfqueryparam cfsqltype="cf_sql_timestamp" value="#Now()#">,
    userID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.userID#">,
    carStatus = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.carStatus#">
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
    
    <cffunction name="updateCatalogUserRel" access="public" returntype="struct">
    <cfargument name="ID" type="numeric" required="yes">
    <cfargument name="cID" type="numeric" required="yes">
    <cfargument name="userID" type="numeric" required="yes">
    <cfargument name="curStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully updated the record.">
    <cftry>
    <!---Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.app.catalog.Catalog"
    method="getCatalogUserRel"
    returnvariable="getCheckCatalogUserRelRet">
    <cfinvokeargument name="excludeID" value="#ARGUMENTS.ID#"/>
    <cfinvokeargument name="cID" value="#ARGUMENTS.cID#"/>
    <cfinvokeargument name="userID" value="#ARGUMENTS.userID#"/>
    <cfinvokeargument name="curStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckCatalogUserRelRet.recordcount NEQ 0>
    <cfset result.message = "The user relationship already exists for this catalog, please try again.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_catalog_user_rel SET
    cID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.cID#">,
    userID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.userID#">,
    curStatus = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.curStatus#">
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
    
    <cffunction name="updateCatalogList" access="public" returntype="struct">
    <cfargument name="ID" type="numeric" required="yes">
    <cfargument name="cStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully updated the records.">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_catalog SET
    cStatus = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.cStatus#">
    WHERE ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ID#">
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error updating the records.">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="updateCatalogAttributeRelList" access="public" returntype="struct">
    <cfargument name="ID" type="numeric" required="yes">
    <cfargument name="carStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully updated the records.">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_catalog_attribute_rel SET
    carStatus = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.carStatus#">
    WHERE ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ID#">
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error updating the records.">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="updateCatalogUserRelList" access="public" returntype="struct">
    <cfargument name="ID" type="numeric" required="yes">
    <cfargument name="curStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully updated the records.">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_catalog_user_rel SET
    curStatus = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.curStatus#">
    WHERE ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ID#">
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error updating the records.">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="deleteCatalog" access="public" returntype="struct">
    <cfargument name="ID" type="string" required="yes">
    <cfset result.message = "You have successfully deleted the record(s).">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    DELETE FROM tbl_catalog
    WHERE ID IN (<cfqueryparam cfsqltype="cf_sql_integer" list="yes" value="#ARGUMENTS.ID#">)
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error deleting the record(s).">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="deleteCatalogAttributeRel" access="public" returntype="struct">
    <cfargument name="ID" type="string" required="yes" default="0">
    <cfargument name="caID" type="string" required="yes" default="0">
    <cfset result.message = "You have successfully deleted the record(s).">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    DELETE FROM tbl_catalog_attribute_rel
    WHERE ID IN (<cfqueryparam cfsqltype="cf_sql_integer" list="yes" value="#ARGUMENTS.ID#">)
    OR caID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.caID#">
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error deleting the record(s).">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="deleteCatalogProductRel" access="public" returntype="struct">
    <cfargument name="ID" type="string" required="yes" default="0">
    <cfargument name="cID" type="string" required="yes" default="0">
    <cfargument name="pID" type="string" required="yes" default="0">
    <cfset result.message = "You have successfully deleted the record(s).">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    DELETE FROM tbl_catalog_product_rel
    WHERE ID IN (<cfqueryparam cfsqltype="cf_sql_integer" list="yes" value="#ARGUMENTS.ID#">)
    OR (cID IN (<cfqueryparam cfsqltype="cf_sql_integer" list="yes" value="#ARGUMENTS.cID#">)
    OR pID IN (<cfqueryparam cfsqltype="cf_sql_integer" list="yes" value="#ARGUMENTS.pID#">))
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error deleting the record(s).">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="deleteCatalogUserRel" access="public" returntype="struct">
    <cfargument name="ID" type="string" required="yes" default="0">
    <cfargument name="cID" type="string" required="yes" default="0">
    <cfargument name="userID" type="string" required="yes" default="0">
    <cfset result.message = "You have successfully deleted the record(s).">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    DELETE FROM tbl_catalog_user_rel
    WHERE ID IN (<cfqueryparam cfsqltype="cf_sql_integer" list="yes" value="#ARGUMENTS.ID#">)
    OR (cID IN (<cfqueryparam cfsqltype="cf_sql_integer" list="yes" value="#ARGUMENTS.cID#">)
    OR userID IN (<cfqueryparam cfsqltype="cf_sql_integer" list="yes" value="#ARGUMENTS.userID#">))
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error deleting the record(s).">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction> 
    
    <cffunction name="deleteCatalogShipMethodRel" access="public" returntype="struct">
    <cfargument name="ID" type="string" required="yes" default="0">
    <cfargument name="cID" type="string" required="yes" default="0">
    <cfargument name="smID" type="string" required="yes" default="0">
    <cfset result.message = "You have successfully deleted the record(s).">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    DELETE FROM tbl_catalog_sm_rel
    WHERE ID IN (<cfqueryparam cfsqltype="cf_sql_integer" list="yes" value="#ARGUMENTS.ID#">)
    OR (cID IN (<cfqueryparam cfsqltype="cf_sql_integer" list="yes" value="#ARGUMENTS.cID#">)
    OR smID IN (<cfqueryparam cfsqltype="cf_sql_integer" list="yes" value="#ARGUMENTS.smID#">))
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error deleting the record(s).">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction> 
</cfcomponent>