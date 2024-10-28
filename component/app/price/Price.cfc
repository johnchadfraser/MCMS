<cfcomponent>
    <cffunction name="getPrice" access="public" returntype="query" hint="Get Price data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="ID" type="numeric" required="yes" default="0">
    <cfargument name="excludeID" type="numeric" required="yes" default="0">
    <cfargument name="pID" type="string" required="yes" default="">
    <cfargument name="productID" type="string" required="yes" default="">
    <cfargument name="sID" type="string" required="yes" default="">
    <cfargument name="skuID" type="string" required="yes" default="">
    <cfargument name="ptID" type="string" required="yes" default="0">
    <cfargument name="pMaxPrice" type="numeric" required="yes" default="0">
    <cfargument name="priceDateRel" type="string" required="yes" default="">
    <cfargument name="priceDateExp" type="string" required="yes" default="">
    <cfargument name="pStatus" type="string" required="yes" default="1,2,3">
    <cfargument name="priceStatus" type="string" required="yes" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="pID,sID">
    <cfset var rsPrice = "" >
    <cftry>
    <cfquery name="rsPrice" datasource="#application.mcmsDSN#">
    SELECT * FROM v_price WHERE 0=0
    <cfif ARGUMENTS.ID NEQ 0>
    AND ID = <cfqueryparam value="#ARGUMENTS.ID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.excludeID NEQ 0>
    AND ID <> <cfqueryparam value="#ARGUMENTS.excludeID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.keywords NEQ 'All'>
    <cfloop list="#ARGUMENTS.keywords#" delimiters=" " index="kw">
    AND (UPPER(pID) LIKE <cfqueryparam value="%#UCASE(kw)#%" cfsqltype="cf_sql_varchar"> 
    OR UPPER(skuID) LIKE <cfqueryparam value="%#UCASE(kw)#%" cfsqltype="cf_sql_varchar"> 
    OR UPPER(productID) LIKE <cfqueryparam value="%#UCASE(kw)#%" cfsqltype="cf_sql_varchar">
    )
    </cfloop>
    </cfif>
    <cfif ARGUMENTS.pID NEQ "">
    AND pID IN (<cfqueryparam value="#ARGUMENTS.pID#" cfsqltype="cf_sql_integer">)
    </cfif>
    <cfif ARGUMENTS.productID NEQ "">
    AND UPPER(productID) = <cfqueryparam value="#UCASE(ARGUMENTS.productID)#" cfsqltype="cf_sql_varchar">
    </cfif>
    <cfif ARGUMENTS.sID NEQ "">
    AND sID IN (<cfqueryparam value="#ARGUMENTS.sID#" cfsqltype="cf_sql_integer">)
    </cfif>
    <cfif ARGUMENTS.skuID NEQ "">
    AND skuID = <cfqueryparam value="#ARGUMENTS.skuID#" cfsqltype="cf_sql_varchar">
    </cfif>
    <cfif ARGUMENTS.ptID NEQ 0>
    AND ptID = <cfqueryparam value="#ARGUMENTS.ptID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.pMaxPrice NEQ 0>
    AND (pMaxPrice <= <cfqueryparam value="#ARGUMENTS.pMaxPrice#" cfsqltype="cf_sql_integer"> OR pMaxPrice = <cfqueryparam value="0" cfsqltype="cf_sql_integer">)
    </cfif>
    <cfif ARGUMENTS.priceDateRel NEQ "">
    AND priceDateRel <= <cfqueryparam value="#DateFormat(ARGUMENTS.priceDateRel, application.dateFormat)#" cfsqltype="cf_sql_date"> 
    </cfif>
    <cfif ARGUMENTS.priceDateExp NEQ "">
    AND priceDateExp >= <cfqueryparam value="#DateFormat(ARGUMENTS.priceDateExp, application.dateFormat)#" cfsqltype="cf_sql_date">
    </cfif>
    AND pStatus IN (<cfqueryparam value="#ARGUMENTS.pStatus#" list="yes" cfsqltype="cf_sql_integer">)
    AND priceStatus IN (<cfqueryparam value="#ARGUMENTS.priceStatus#" list="yes" cfsqltype="cf_sql_integer">)
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsPrice = StructNew()>
    <cfset rsPrice.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsPrice>
    </cffunction>
    
    <cffunction name="getPriceProductSkuDepartmentRel" access="public" returntype="query" hint="Get Price data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="ID" type="numeric" required="yes" default="0">
    <cfargument name="excludeID" type="numeric" required="yes" default="0">
    <cfargument name="cID" type="string" required="yes" default="">
    <cfargument name="pID" type="string" required="yes" default="">
    <cfargument name="productID" type="string" required="yes" default="">
    <cfargument name="sID" type="string" required="yes" default="">
    <cfargument name="skuID" type="string" required="yes" default="">
    <cfargument name="ptID" type="string" required="yes" default="">
    <cfargument name="pMaxPrice" type="numeric" required="yes" default="0">
    <cfargument name="priceDateRel" type="string" required="yes" default="">
    <cfargument name="priceDateExp" type="string" required="yes" default="">
    <cfargument name="pesID" type="string" required="yes" default="">
    <cfargument name="deptNo" type="string" required="yes" default="">
    <cfargument name="ppID" type="string" required="yes" default="">
    <cfargument name="skuStatus" type="string" required="yes" default="1,2,3">
    <cfargument name="pStatus" type="string" required="yes" default="1,2,3">
    <cfargument name="priceStatus" type="string" required="yes" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="pID,sID">
    <cfset var rsPriceProductSkuDepartmentRel = "" >
    <cftry>
    <cfquery name="rsPriceProductSkuDepartmentRel" datasource="#application.mcmsDSN#">
    SELECT * FROM v_price_product_sku_dept_rel WHERE 0=0
    <cfif ARGUMENTS.ID NEQ 0>
    AND ID = <cfqueryparam value="#ARGUMENTS.ID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.excludeID NEQ 0>
    AND ID <> <cfqueryparam value="#ARGUMENTS.excludeID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (pID LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR sID LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">)
    </cfif>
    <cfif ARGUMENTS.cID NEQ "">
    AND cID IN (<cfqueryparam value="#ARGUMENTS.cID#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    <cfif ARGUMENTS.pID NEQ "">
    AND pID IN (<cfqueryparam value="#ARGUMENTS.pID#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    <cfif ARGUMENTS.productID NEQ "">
    AND UPPER(productID) = <cfqueryparam value="#UCASE(ARGUMENTS.productID)#" cfsqltype="cf_sql_varchar">
    </cfif>
    <cfif ARGUMENTS.sID NEQ "">
    AND sID IN (<cfqueryparam value="#ARGUMENTS.sID#" cfsqltype="cf_sql_integer">)
    </cfif>
    <cfif ARGUMENTS.skuID NEQ "">
    AND skuID = <cfqueryparam value="#ARGUMENTS.skuID#" cfsqltype="cf_sql_varchar">
    </cfif>
    <cfif ARGUMENTS.ptID NEQ "">
    AND ptID IN (<cfqueryparam value="#ARGUMENTS.ptID#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    <cfif ARGUMENTS.pesID NEQ "">
    AND pesID IN (<cfqueryparam value="#ARGUMENTS.pesID#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    <cfif ARGUMENTS.ppID NEQ "">
    AND ppID IN (<cfqueryparam value="#ARGUMENTS.ppID#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    <cfif ARGUMENTS.deptNo NEQ "">
    AND deptNo IN (<cfqueryparam value="#ARGUMENTS.deptNo#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    <cfif ARGUMENTS.pMaxPrice NEQ 0>
    AND (pMaxPrice <= <cfqueryparam value="#ARGUMENTS.pMaxPrice#" cfsqltype="cf_sql_integer"> OR pMaxPrice = <cfqueryparam value="0" cfsqltype="cf_sql_integer">)
    </cfif>
    <cfif ARGUMENTS.priceDateRel NEQ "">
    AND priceDateRel <= <cfqueryparam value="#DateFormat(ARGUMENTS.priceDateRel, application.dateFormat)#" cfsqltype="cf_sql_date"> 
    </cfif>
    <cfif ARGUMENTS.priceDateExp NEQ "">
    AND priceDateExp >= <cfqueryparam value="#DateFormat(ARGUMENTS.priceDateExp, application.dateFormat)#" cfsqltype="cf_sql_date">
    </cfif>
    AND pStatus IN (<cfqueryparam value="#ARGUMENTS.pStatus#" list="yes" cfsqltype="cf_sql_integer">)
    AND skuStatus IN (<cfqueryparam value="#ARGUMENTS.skuStatus#" list="yes" cfsqltype="cf_sql_integer">)
    AND priceStatus IN (<cfqueryparam value="#ARGUMENTS.priceStatus#" list="yes" cfsqltype="cf_sql_integer">)
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsPriceProductSkuDepartmentRel = StructNew()>
    <cfset rsPriceProductSkuDepartmentRel.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsPriceProductSkuDepartmentRel>
    </cffunction>
    
    <cffunction name="getPriceReport" access="public" returntype="query" hint="Get Price Report data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="orderBy" type="string" required="yes" default="sID">
    <cfset var rsPriceReport = "" >
    <cftry>
    <cfquery name="rsPriceReport" datasource="#application.mcmsDSN#">
    SELECT sID AS Sku, pPrice AS Price, pMaxRange AS Range, TO_CHAR(priceDateUpdate,'MM/DD/YYYY') AS Date_Update, userFName || ' ' || userlName AS Price_User, ptName AS Price_Type, sortName AS Sort, sName AS Status  FROM v_price WHERE 0=0
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (pID LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR sID LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">)
    </cfif>
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsPriceReport = StructNew()>
    <cfset rsPriceReport.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsPriceReport>
    </cffunction> 
    
    <cffunction name="getPriceType" access="public" returntype="query" hint="Get Price Type data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="ID" type="string" required="yes" default="0">
    <cfargument name="excludeID" type="numeric" required="yes" default="0">
    <cfargument name="ptName" type="string" required="yes" default="">
    <cfargument name="ptStatus" type="string" required="yes" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="ptSort, ptName">
    <cfset var rsPriceType = "" >
    <cftry>
    <cfquery name="rsPriceType" datasource="#application.mcmsDSN#" cachedWithin="#request.queryCache#">
    SELECT * FROM v_price_type WHERE 0=0
    <cfif ARGUMENTS.ID NEQ 0>
    AND ID IN (<cfqueryparam value="#ARGUMENTS.ID#" cfsqltype="cf_sql_integer" list="yes">)
    </cfif>
    <cfif ARGUMENTS.excludeID NEQ 0>
    AND ID <> <cfqueryparam value="#ARGUMENTS.excludeID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (ptName LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">)
    </cfif>
    <cfif ARGUMENTS.ptName NEQ "">
    AND ptName = <cfqueryparam value="#ARGUMENTS.ptName#" cfsqltype="cf_sql_varchar">
    </cfif>
    AND ptStatus IN (<cfqueryparam value="#ARGUMENTS.ptStatus#" list="yes" cfsqltype="cf_sql_integer">)
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsPriceType = StructNew()>
    <cfset rsPriceType.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsPriceType>
    </cffunction>
    
    <cffunction name="insertPrice" access="public" returntype="struct">
    <cfargument name="pID" type="numeric" required="yes">
    <cfargument name="sID" type="numeric" required="yes">
    <cfargument name="pPrice" type="string" required="yes">
    <cfargument name="pMaxRange" type="numeric" required="yes" default="0">
    <cfargument name="ptID" type="numeric" required="yes">
    <cfargument name="pDateRel" type="date" required="yes">
    <cfargument name="pDateExp" type="date" required="yes">
    <cfargument name="pSort" type="numeric" required="yes">
    <cfargument name="pStatus" type="numeric" required="yes">
    <!---Include override price/date option.--->
    <cfargument name="pPriceOverride" type="string" required="yes" default="0.00">
    <cfargument name="pDateRelOverride" type="date" required="yes" default="#DateFormat(Now(), application.dateFormat)#">
    <cfargument name="pDateExpOverride" type="date" required="yes" default="#DateFormat(DateAdd('d', 15, Now()), application.dateFormat)#">
    <cfset result.message = "You have successfully inserted the record.">
    <cftry>
    <!---Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.app.price.Price"
    method="getPrice"
    returnvariable="getCheckPriceRet">
    <cfinvokeargument name="pID" value="#ARGUMENTS.pID#"/>
    <cfinvokeargument name="sID" value="#ARGUMENTS.sID#"/>
    <cfinvokeargument name="pMaxRange" value="#ARGUMENTS.pMaxRange#"/>
    <cfinvokeargument name="ptID" value="#ARGUMENTS.ptID#"/>
    <cfinvokeargument name="pStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckPriceRet.recordcount NEQ 0>
    <cfset result.message = "The price and range already exists for Sku: #getCheckPriceRet.skuID#, please try again.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    INSERT INTO tbl_price (pID,sID,pPrice,pMaxRange,ptID,pDateRel,pDateExp,userID,pSort,pStatus) VALUES
    (
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.pID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.sID#">,
    <cfqueryparam cfsqltype="cf_sql_float" value="#Iif(ARGUMENTS.pPriceOverride NEQ '0.00', DE(ARGUMENTS.pPriceOverride), DE(ARGUMENTS.pPrice))#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.pMaxRange#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ptID#">,
    <cfqueryparam cfsqltype="cf_sql_date" value="#Iif(ARGUMENTS.pPriceOverride NEQ '0.00', DE(ARGUMENTS.pDateRelOverride), DE(ARGUMENTS.pDateRel))#">,
    <cfqueryparam cfsqltype="cf_sql_date" value="#Iif(ARGUMENTS.pPriceOverride NEQ '0.00', DE(ARGUMENTS.pDateExpOverride), DE(ARGUMENTS.pDateExp))#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#session.userID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.pSort#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.pStatus#">
    )
    </cfquery>
    </cftransaction>
    <!---Make required updates to product status based on type of request.--->
    <cfinvoke 
    component="MCMS.component.app.product.Product" 
    method="updateProductStatus" 
    >
    <cfinvokeargument name="pID" value="#ARGUMENTS.pID#">
    <cfinvokeargument name="pwfID" value="108">
    <cfinvokeargument name="pwfcComment" value="Product price created.">
    <cfinvokeargument name="pStatus" value="3">
    </cfinvoke>
    </cfif>
    <cfcatch type="any">
    <cfset result.message = "There was an error inserting the record.">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="insertPriceImport" access="public" returntype="struct">
    <cfargument name="productID" type="string" required="yes">
    <cfargument name="skuID" type="string" required="yes">
    <cfargument name="pPrice" type="string" required="yes">
    <cfargument name="userID" type="numeric" required="yes" default="101">
    <cfset result.message = "You have successfully inserted the record.">
    <cftry>
    <!---Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.app.price.Price"
    method="getPrice"
    returnvariable="getCheckPriceRet">
    <cfinvokeargument name="productID" value="#TRIM(ARGUMENTS.productID)#"/>
    <cfinvokeargument name="skuID" value="#TRIM(ARGUMENTS.skuID)#"/>
    <cfinvokeargument name="pStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckPriceRet.recordcount NEQ 0>
    <!---If price exists update it.--->
    <cfquery name="getSkuIDProductID" datasource="#application.mcmsDSN#">
    SELECT ID, pID FROM v_sku WHERE 0=0
    AND UPPER(productID) = <cfqueryparam value="#UCASE(TRIM(ARGUMENTS.productID))#" cfsqltype="cf_sql_varchar">
    AND skuID = <cfqueryparam value="#TRIM(ARGUMENTS.skuID)#" cfsqltype="cf_sql_varchar">
    </cfquery>
    <cfif getSkuIDProductID.recordcount NEQ 0>
    <cfset this.pID = getSkuIDProductID.pID>
    <cfset this.sID = getSkuIDProductID.ID>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_price SET 
    pPrice = <cfqueryparam cfsqltype="cf_sql_float" value="#TRIM(ARGUMENTS.pPrice)#">,
    pDateUpdate = <cfqueryparam cfsqltype="cf_sql_date" value="#DateFormat(Now(), 'mm/dd/yyyy')#">
    WHERE 0=0
    AND pID = <cfqueryparam cfsqltype="cf_sql_integer" value="#this.pID#">
    AND sID = <cfqueryparam cfsqltype="cf_sql_integer" value="#this.sID#">
    AND ptID = <cfqueryparam cfsqltype="cf_sql_integer" value="1">
    </cfquery>
    </cftransaction>
    </cfif>
    <cfelse>
    <!---Get sID and pID based on productID from the sku table/view.--->
    <cfquery name="getSkuIDProductID" datasource="#application.mcmsDSN#">
    SELECT ID, pID FROM v_sku WHERE 0=0
    AND UPPER(productID) = <cfqueryparam value="#UCASE(TRIM(ARGUMENTS.productID))#" cfsqltype="cf_sql_varchar">
    AND skuID = <cfqueryparam value="#TRIM(ARGUMENTS.skuID)#" cfsqltype="cf_sql_varchar">
    </cfquery>
    <cfif getSkuIDProductID.recordcount NEQ 0>
    <cfset this.pID = getSkuIDProductID.pID>
    <cfset this.sID = getSkuIDProductID.ID>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    INSERT INTO tbl_price (pID,sID,pPrice,pMaxRange,ptID,pDateRel,pDateExp,userID,pSort,pStatus) VALUES
    (
    <cfqueryparam cfsqltype="cf_sql_integer" value="#this.pID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#this.sID#">,
    <cfqueryparam cfsqltype="cf_sql_float" value="#TRIM(ARGUMENTS.pPrice)#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="1">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="1">,
    <cfqueryparam cfsqltype="cf_sql_date" value="#DateFormat(Now(), 'mm/dd/yyyy')#">,
    <cfqueryparam cfsqltype="cf_sql_date" value="#DateFormat(DateAdd('yyyy', 10, Now()), 'mm/dd/yyyy')#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#TRIM(ARGUMENTS.userID)#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="1">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="1">
    )
    </cfquery>
    </cftransaction>
    <!---Make required updates to product status based on type of request.--->
    <cfinvoke 
    component="MCMS.component.app.product.Product" 
    method="updateProductStatus" 
    >
    <cfinvokeargument name="pID" value="#this.pID#">
    <cfinvokeargument name="pwfID" value="108">
    <cfinvokeargument name="pwfcComment" value="Product price created.">
    <cfinvokeargument name="pStatus" value="3">
    </cfinvoke>
    </cfif>
    </cfif>
    <cfcatch type="any">
    <cflog file="insertPriceImport" application="no" type="error" text="The price import failed. Message: #cfcatch.message# Detail: #cfcatch.detail#">
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="updatePriceChangeImport" access="public" returntype="struct">
    <cfargument name="sku" type="string" required="yes" default="0">
    <cfargument name="type" type="string" required="yes" default="0">
    <cfargument name="price" type="string" required="yes" default="0.00">
    <cfargument name="daterelease" type="string" required="yes" default="01/01/1999">
    <cfargument name="dateexpire" type="string" required="yes" default="01/01/1999">
    <cfset result.message = "">
    <cftry>
    
    <!---Get product data required to complete import.--->
    <cfquery name="getSkuIDProductID" datasource="#application.mcmsDSN#">
    SELECT ID, pID, productID, pName, userID FROM v_sku WHERE 0=0
    AND skuID = <cfqueryparam value="#TRIM(ARGUMENTS.sku)#" cfsqltype="cf_sql_varchar">
    </cfquery>
    
    <cfif getSkuIDProductID.recordcount EQ 0>
    <!---If the sku does not exists create notification.--->
    <cfset result.message = "<span style='color:##FF0000;'>#TRIM(ARGUMENTS.sku)# does not exist in this system.</span><br/>">
    	
    <cfelse>
    <cfset this.pID = getSkuIDProductID.pID>
    <cfset this.productID = getSkuIDProductID.productID>
    <cfset this.pName = getSkuIDProductID.pName>
    <cfset this.sID = getSkuIDProductID.ID>
    <cfset this.userID = getSkuIDProductID.userID>
    
    <!---Add a successful message.--->
    <cfset result.message = result.message & "<span style='color:##008000;'>#TRIM(ARGUMENTS.sku)# - #this.pName# | #this.productID# - price has been updated to #DollarFormat(TRIM(ARGUMENTS.price))#.</span><br/>">
    
    <!---Check for a existing record.--->
    <cfinvoke 
    component="MCMS.component.app.price.Price"
    method="getPrice"
    returnvariable="getCheckPriceRet">
    <cfinvokeargument name="skuID" value="#TRIM(ARGUMENTS.sku)#"/>
    <cfinvokeargument name="ptID" value="#ARGUMENTS.type#"/>
    <cfinvokeargument name="pStatus" value="1,2,3"/>
    </cfinvoke>
    
    <cfif getCheckPriceRet.recordcount NEQ 0>
    <!---If price exists update it.--->
    <cftransaction>
    <!---Record the price history.--->
    <cfquery datasource="#application.mcmsDSN#">
    INSERT INTO tbl_price_history (pID,sID,phPrice,phMaxRange,ptID,phDateRel,phDateExp,userID,phStatus) VALUES
    (
    <cfqueryparam cfsqltype="cf_sql_integer" value="#this.pID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#this.sID#">,
    <cfqueryparam cfsqltype="cf_sql_float" value="#getCheckPriceRet.pPrice#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#getCheckPriceRet.pMaxRange#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#getCheckPriceRet.ptID#">,
    <cfqueryparam cfsqltype="cf_sql_date" value="#getCheckPriceRet.pDateRel#">,
    <cfqueryparam cfsqltype="cf_sql_date" value="#getCheckPriceRet.pDateExp#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#getCheckPriceRet.userID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="1">
    )
    </cfquery>
    <!---Update the price.--->
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_price SET 
    pPrice = <cfqueryparam cfsqltype="cf_sql_float" value="#TRIM(ARGUMENTS.price)#">,
    pDateUpdate = <cfqueryparam cfsqltype="cf_sql_date" value="#DateFormat(Now(), 'mm/dd/yyyy')#">,
    pDateRel = <cfqueryparam cfsqltype="cf_sql_date" value="#DateFormat(ARGUMENTS.daterelease, 'mm/dd/yyyy')#">,
    pDateExp = <cfqueryparam cfsqltype="cf_sql_date" value="#DateFormat(ARGUMENTS.dateexpire, 'mm/dd/yyyy')#">,
    pStatus = <cfqueryparam cfsqltype="cf_sql_integer" value="1">
    WHERE 0=0
    AND pID = <cfqueryparam cfsqltype="cf_sql_integer" value="#this.pID#">
    AND sID = <cfqueryparam cfsqltype="cf_sql_integer" value="#this.sID#">
    AND ptID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.type#">
    </cfquery>
    <!---Now update the product's type.--->
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_product SET 
    ptID = <cfqueryparam cfsqltype="cf_sql_integer" value="8">,
    pDateUpdate = <cfqueryparam cfsqltype="cf_sql_date" value="#DateFormat(Now(), 'mm/dd/yyyy')#">
    WHERE 0=0
    AND ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#this.pID#">
    </cfquery>
    </cftransaction>
    
    <cfelse>

    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    INSERT INTO tbl_price (pID,sID,pPrice,pMaxRange,ptID,pDateRel,pDateExp,userID,pSort,pStatus) VALUES
    (
    <cfqueryparam cfsqltype="cf_sql_integer" value="#this.pID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#this.sID#">,
    <cfqueryparam cfsqltype="cf_sql_float" value="#TRIM(ARGUMENTS.price)#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="1">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.type#">,
    <cfqueryparam cfsqltype="cf_sql_date" value="#DateFormat(ARGUMENTS.daterelease, 'mm/dd/yyyy')#">,
    <cfqueryparam cfsqltype="cf_sql_date" value="#DateFormat(ARGUMENTS.dateexpire, 'mm/dd/yyyy')#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#this.userID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="1">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="1">
    )
    </cfquery>
    </cftransaction>
    
    <!---Update the product type to price change.--->
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_product SET 
    pDateUpdate = <cfqueryparam cfsqltype="cf_sql_date" value="#DateFormat(Now(), 'mm/dd/yyyy')#">,
    ptID = <cfqueryparam cfsqltype="cf_sql_integer" value="8">
    WHERE 0=0
    AND ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#this.pID#">
    </cfquery>
    <!---Create a request log about the price change.--->
    <cfquery datasource="#application.mcmsDSN#">
    INSERT INTO tbl_product_workflow_request (pID,pwfID,pwfrRequest,pwfrtID,pwfrDateRequired,pwfrsID,pwfrUserID,pwfrStatus) VALUES
    (
    <cfqueryparam cfsqltype="cf_sql_integer" value="#this.pID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="111">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="A price change was made to this products sku - #TRIM(ARGUMENTS.sku)#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="2">,
    <cfqueryparam cfsqltype="cf_sql_date" value="#DateFormat(Now(), 'mm/dd/yyyy')#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="2">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#this.userID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="1">
    )
    </cfquery>
    </cfif>
    <cflog file="updatePriceChangeImport" application="no" type="information" text="A price change import for sku #TRIM(ARGUMENTS.sku)# at $#TRIM(ARGUMENTS.price)# has been completed.">
    </cfif>    
    <cfcatch type="any">
    <cflog file="updatePriceChangeImport" application="no" type="error" text="The price change import failed. Message: #cfcatch.message# Detail: #cfcatch.detail#">
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="updatePrice" access="public" returntype="struct">
    <cfargument name="ID" type="numeric" required="yes">
    <cfargument name="pID" type="numeric" required="yes">
    <cfargument name="sID" type="numeric" required="yes">
    <cfargument name="pPrice" type="string" required="yes">
    <cfargument name="pMaxRange" type="numeric" required="yes">
    <cfargument name="ptID" type="numeric" required="yes">
    <cfargument name="pDateRel" type="date" required="yes">
    <cfargument name="pDateExp" type="date" required="yes">
    <cfargument name="pSort" type="numeric" required="yes">
    <cfargument name="pStatus" type="numeric" required="yes">
    <!---Include override price/date option.--->
    <cfargument name="pPriceOverride" type="string" required="yes" default="0.00">
    <cfargument name="pDateRelOverride" type="date" required="yes" default="#DateFormat(Now(), application.dateFormat)#">
    <cfargument name="pDateExpOverride" type="date" required="yes" default="#DateFormat(DateAdd('d', 15, Now()), application.dateFormat)#">
    <cfset result.message = "You have successfully updated the record.">
    <cftry>
    <!---Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.app.price.Price"
    method="getPrice"
    returnvariable="getCheckPriceRet">
    <cfinvokeargument name="excludeID" value="#ARGUMENTS.ID#"/>
    <cfinvokeargument name="pID" value="#ARGUMENTS.pID#"/>
    <cfinvokeargument name="sID" value="#ARGUMENTS.sID#"/>
    <cfinvokeargument name="pMaxRange" value="#ARGUMENTS.pMaxRange#"/>
    <cfinvokeargument name="ptID" value="#ARGUMENTS.ptID#"/>
    <cfinvokeargument name="pStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckPriceRet.recordcount NEQ 0>
    <cfset result.message = "The price and range already exists for Sku: #getCheckPriceRet.skuID#, please try again. UPDATE">
    <cfelse>
    <!---Record the price history.--->
    <cfinvoke 
    component="MCMS.component.app.price.Price"
    method="getPrice"
    returnvariable="getCheckPriceRet">
    <cfinvokeargument name="ID" value="#ARGUMENTS.ID#"/>
    <cfinvokeargument name="pStatus" value="1,2,3"/>
    </cfinvoke>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    INSERT INTO tbl_price_history (pID,sID,phPrice,phMaxRange,ptID,phDateRel,phDateExp,userID,phStatus) VALUES
    (
    <cfqueryparam cfsqltype="cf_sql_integer" value="#getCheckPriceRet.pID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#getCheckPriceRet.sID#">,
    <cfqueryparam cfsqltype="cf_sql_float" value="#getCheckPriceRet.pPrice#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#getCheckPriceRet.pMaxRange#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#getCheckPriceRet.ptID#">,
    <cfqueryparam cfsqltype="cf_sql_date" value="#getCheckPriceRet.pDateRel#">,
    <cfqueryparam cfsqltype="cf_sql_date" value="#getCheckPriceRet.pDateExp#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#getCheckPriceRet.userID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="1">
    )
    </cfquery>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_price SET
    pID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.pID#">,
    sID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.sID#">,
    pPrice = <cfqueryparam cfsqltype="cf_sql_float" value="#Iif(ARGUMENTS.pPriceOverride NEQ '0.00', DE(ARGUMENTS.pPriceOverride), DE(ARGUMENTS.pPrice))#">,
    pMaxRange = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.pMaxRange#">,
    ptID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ptID#">,
    pDateRel = <cfqueryparam cfsqltype="cf_sql_date" value="#Iif(ARGUMENTS.pPriceOverride NEQ '0.00', DE(ARGUMENTS.pDateRelOverride), DE(ARGUMENTS.pDateRel))#">,
    pDateExp = <cfqueryparam cfsqltype="cf_sql_date" value="#Iif(ARGUMENTS.pPriceOverride NEQ '0.00', DE(ARGUMENTS.pDateExpOverride), DE(ARGUMENTS.pDateExp))#">,
    pDateUpdate = <cfqueryparam cfsqltype="cf_sql_date" value="#DateFormat(Now(), application.dateFormat)#">,
    userID = <cfqueryparam cfsqltype="cf_sql_integer" value="#session.userID#">,
    pSort = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.pSort#">,
    pStatus = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.pStatus#">
    WHERE ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ID#">
    </cfquery>
    </cftransaction>
    <!---Make required updates to product status based on type of request.--->
    <cfinvoke 
    component="MCMS.component.app.product.Product" 
    method="updateProductStatus" 
    >
    <cfinvokeargument name="pID" value="#ARGUMENTS.pID#">
    <cfinvokeargument name="pwfID" value="108">
    <cfinvokeargument name="pwfcComment" value="Product price updated.">
    <cfinvokeargument name="pStatus" value="3">
    </cfinvoke>
    </cfif>
    <cfcatch type="any">
    <cfset result.message = "There was an error updating the record.">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
        
    <cffunction name="updatePriceList" access="public" returntype="struct">
    <cfargument name="ID" type="numeric" required="yes">
    <cfargument name="pStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully updated the records.">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_price SET
    pStatus = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.pStatus#">
    WHERE ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ID#">
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error updating the records.">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="deletePrice" access="public" returntype="struct">
    <cfargument name="ID" type="string" required="yes" default="0">
    <cfargument name="sID" type="string" required="yes" default="0">
    <cfset result.message = "You have successfully deleted the record(s).">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    DELETE FROM tbl_price
    WHERE ID IN (<cfqueryparam cfsqltype="cf_sql_integer" list="yes" value="#ARGUMENTS.ID#">)
    OR sID IN (<cfqueryparam cfsqltype="cf_sql_integer" list="yes" value="#ARGUMENTS.sID#">)
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error deleting the record(s).">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
</cfcomponent>