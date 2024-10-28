<cfcomponent>
    <cffunction name="getSku" access="public" returntype="query" hint="Get Sku data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="ID" type="string" required="yes" default="0">
    <cfargument name="excludeID" type="string" required="yes" default="0">
    <cfargument name="pID" type="string" required="yes" default="">
    <cfargument name="skuID" type="string" required="yes" default="">
    <cfargument name="skuQOH" type="numeric" required="yes" default="0">
    <cfargument name="skuDateRel" type="string" required="yes" default="">
    <cfargument name="skuDateExp" type="string" required="yes" default="">
    <cfargument name="skuStatus" type="string" required="yes" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="ID">
    <cfset var rsSku = "" >
    <cftry>
    <cfquery name="rsSku" datasource="#application.mcmsDSN#">
    SELECT * FROM v_sku WHERE 0=0
    <cfif ARGUMENTS.ID NEQ 0>
    AND ID IN (<cfqueryparam value="#ARGUMENTS.ID#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    <cfif ARGUMENTS.excludeID NEQ 0>
    AND ID NOT IN (<cfqueryparam value="#ARGUMENTS.excludeID#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(skuID) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(pName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(productID) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(skuMPN) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(skuUPC) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">)
    </cfif>
    <cfif ARGUMENTS.pID NEQ "" AND ARGUMENTS.pID NEQ 0>
    AND pID IN (<cfqueryparam value="#ARGUMENTS.pID#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    <cfif ARGUMENTS.skuID NEQ "">
    AND UPPER(skuID) IN (<cfqueryparam value="#UCASE(ARGUMENTS.skuID)#" list="yes" cfsqltype="cf_sql_varchar">)
    </cfif>
    <cfif ARGUMENTS.skuQOH NEQ 0>
    AND skuQOH >= <cfqueryparam value="#ARGUMENTS.skuQOH#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.skuDateRel NEQ "">
    AND skuDateRel <= <cfqueryparam value="#DateFormat(ARGUMENTS.skuDateRel, application.dateFormat)#" cfsqltype="cf_sql_date">
	</cfif>
    <cfif ARGUMENTS.skuDateExp NEQ "">
    AND skuDateExp >= <cfqueryparam value="#DateFormat(ARGUMENTS.skuDateExp, application.dateFormat)#" cfsqltype="cf_sql_date">
	</cfif>
    AND skuStatus IN (<cfqueryparam value="#ARGUMENTS.skuStatus#" list="yes" cfsqltype="cf_sql_integer">)
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsSku = StructNew()>
    <cfset rsSku.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsSku>
    </cffunction>
    
    <cffunction name="getSkuIDBind" access="remote" returntype="string" output="yes">
    <cfargument name="keywords" type="string" required="yes" default="">
    <cfargument name="dsn" type="string" required="yes" default="swweb">
    <cfargument name="deptNo" type="string" required="yes" default="0">
    <cfargument name="orderBy" type="string" required="yes" default="skuID">
    <cfset var rsBind = "" >
    <cfquery name="rsBind" datasource="#ARGUMENTS.dsn#">
    SELECT DISTINCT skuID FROM v_sku_department_rel WHERE 0=0
    AND skuID LIKE <cfqueryparam value="#ARGUMENTS.keywords#%" cfsqltype="cf_sql_varchar">
    AND deptNo IN (<cfqueryparam value="#ARGUMENTS.deptNo#" list="yes" separator="|" cfsqltype="cf_sql_numeric">)
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <cfif rsBind.recordcount NEQ 0>
    <cfset IDList = ValueList(rsBind.skuID, ',') & ",none">
    <cfelse>
    <cfset IDList = ''>
    </cfif>
    <cfreturn IDList>
    </cffunction>
    
    <cffunction name="getSkuDepartmentRel" access="public" returntype="query" hint="Get Sku Department Rel. data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="ID" type="string" required="yes" default="0">
    <cfargument name="excludeID" type="string" required="yes" default="0">
    <cfargument name="cID" type="numeric" required="yes" default="0">
    <cfargument name="pID" type="string" required="yes" default="0">
    <cfargument name="vID" type="numeric" required="yes" default="0">
    <cfargument name="bID" type="numeric" required="yes" default="0">
    <cfargument name="ainID" type="numeric" required="yes" default="0">
    <cfargument name="ppID" type="numeric" required="yes" default="0">
    <cfargument name="pesID" type="numeric" required="yes" default="0">
    <cfargument name="deptNo" type="string" required="yes" default="0">
    <cfargument name="skuID" type="string" required="yes" default="">
    <cfargument name="skuQOH" type="numeric" required="yes" default="0">
    <cfargument name="skuDateRel" type="string" required="yes" default="">
    <cfargument name="skuDateExp" type="string" required="yes" default="">
    <cfargument name="pStatus" type="string" required="yes" default="1,3">
    <cfargument name="skuStatus" type="string" required="yes" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="ID">
    <cfset var rsSkuDepartmentRel = "" >
    <cftry>
    <cfquery name="rsSkuDepartmentRel" datasource="#application.mcmsDSN#">
    SELECT * FROM v_sku_department_rel WHERE 0=0
    <cfif ARGUMENTS.ID NEQ 0>
    AND ID IN (<cfqueryparam value="#ARGUMENTS.ID#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    <cfif ARGUMENTS.excludeID NEQ 0>
    AND ID NOT IN (<cfqueryparam value="#ARGUMENTS.excludeID#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(skuID) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> 
    OR UPPER(pName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">
    OR UPPER(productID) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">  
    OR UPPER(vName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">
    OR UPPER(bName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">
    OR UPPER(deptName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">
    )
    </cfif>
    <cfif ARGUMENTS.cID NEQ 0>
    AND cID = <cfqueryparam value="#ARGUMENTS.cID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.pID NEQ 0>
    AND pID IN (<cfqueryparam value="#ARGUMENTS.pID#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    <cfif ARGUMENTS.vID NEQ 0>
    AND vID = <cfqueryparam value="#ARGUMENTS.vID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.bID NEQ 0>
    AND bID = <cfqueryparam value="#ARGUMENTS.bID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.ainID NEQ 0>
    AND ainID = <cfqueryparam value="#ARGUMENTS.ainID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.ppID NEQ 0>
    AND ppID = <cfqueryparam value="#ARGUMENTS.ppID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.pesID NEQ 0>
    AND pesID = <cfqueryparam value="#ARGUMENTS.pesID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.deptNo NEQ 0>
    AND deptNo IN (<cfqueryparam value="#ARGUMENTS.deptNo#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    <cfif ARGUMENTS.skuID NEQ "">
    AND UPPER(skuID) = <cfqueryparam value="#UCASE(ARGUMENTS.skuID)#" cfsqltype="cf_sql_varchar">
    </cfif>
    <cfif ARGUMENTS.skuQOH NEQ 0>
    AND skuQOH >= <cfqueryparam value="#ARGUMENTS.skuQOH#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.skuDateRel NEQ "">
    AND skuDateRel <= <cfqueryparam value="#DateFormat(ARGUMENTS.skuDateRel, application.dateFormat)#" cfsqltype="cf_sql_date">
	</cfif>
    <cfif ARGUMENTS.skuDateExp NEQ "">
    AND skuDateExp >= <cfqueryparam value="#DateFormat(ARGUMENTS.skuDateExp, application.dateFormat)#" cfsqltype="cf_sql_date">
	</cfif>
    <cfif ARGUMENTS.pStatus NEQ 0>
    AND pStatus IN (<cfqueryparam value="#ARGUMENTS.pStatus#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    AND skuStatus IN (<cfqueryparam value="#ARGUMENTS.skuStatus#" list="yes" cfsqltype="cf_sql_integer">)
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsSkuDepartmentRel = StructNew()>
    <cfset rsSkuDepartmentRel.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsSkuDepartmentRel>
    </cffunction>
    
    <cffunction name="getDistinctSkuDepartmentRel" access="public" returntype="query" hint="Get Distinct Sku Department Rel. data.">
    <cfargument name="deptNo" type="string" required="yes" default="0">
    <cfargument name="pID" type="numeric" required="yes" default="0">
    <cfargument name="bID" type="numeric" required="yes" default="0">
    <cfargument name="skuStatus" type="string" required="yes" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="pID">
    <cfset var rsDistinctSkuDepartmentRel = "" >
    <cftry>
    <cfquery name="rsDistinctSkuDepartmentRel" datasource="#application.mcmsDSN#">
    SELECT DISTINCT pID FROM v_sku_department_rel WHERE 0=0
    <cfif ARGUMENTS.deptNo NEQ 0>
    AND deptNo IN (<cfqueryparam value="#ARGUMENTS.deptNo#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    <cfif ARGUMENTS.pID NEQ 0>
    AND pID = <cfqueryparam value="#ARGUMENTS.pID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.bID NEQ 0>
    AND bID = <cfqueryparam value="#ARGUMENTS.bID#" cfsqltype="cf_sql_integer">
    </cfif>
    AND skuStatus IN (<cfqueryparam value="#ARGUMENTS.skuStatus#" list="yes" cfsqltype="cf_sql_integer">)
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsDistinctSkuDepartmentRel = StructNew()>
    <cfset rsDistinctSkuDepartmentRel.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsDistinctSkuDepartmentRel>
    </cffunction>
    
    <cffunction name="getSkuLookup" access="public" returntype="query" hint="Get Sku Lookup data.">
    <cfargument name="skuID" type="string" required="yes" default="">
    <cfargument name="skuStatus" type="string" required="yes" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="skuSort,skuID">
    <cfset var rsSkuLookup = "" >
    <cftry>
    <cfquery name="rsSkuLookup" datasource="#application.mcmsDSN#">
    SELECT ID, skuID, pID, pName, skuMPN, skuUPC, userFName, userLName, skuDateUpdate FROM v_sku WHERE 0=0
    <cfif ARGUMENTS.skuID NEQ "">
    AND UPPER(skuID) = <cfqueryparam value="#UCASE(ARGUMENTS.skuID)#" cfsqltype="cf_sql_varchar">
    </cfif>
    AND skuStatus IN (<cfqueryparam value="#ARGUMENTS.skuStatus#" list="yes" cfsqltype="cf_sql_integer">)
    AND rowNum <= 10
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsSkuLookup = StructNew()>
    <cfset rsSkuLookup.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsSkuLookup>
    </cffunction>
    
    <cffunction name="getSkuReport" access="public" returntype="query" hint="Get Sku Report data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="siteNo" type="string" required="yes" default="100">
    <cfargument name="deptNo" type="string" required="yes" default="0">
    <cfargument name="args" type="string" required="yes" default="">
    <cfargument name="orderBy" type="string" required="yes" default="skuID">
    <cfset var rsSkuReport = "" >
    <cftry>
    <cfquery name="rsSkuReport" datasource="#application.mcmsDSN#">
    SELECT skuID AS SkuID, pName AS Product, TO_CHAR(skuDateUpdate,'MM/DD/YYYY') AS Date_Update, TO_CHAR(skuDateRel,'MM/DD/YYYY') AS Date_Rel, TO_CHAR(skuDateExp,'MM/DD/YYYY') AS Date_Exp, skuMPN AS MPN, skuUPC AS UPC, userfName || ' ' || userlName AS Sku_User, sName AS Status FROM v_sku_department_rel WHERE 0=0
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(skuID) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(pName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">)
    </cfif>
    <cfif ARGUMENTS.deptNo NEQ 0>
    AND deptNo IN (<cfqueryparam value="#ARGUMENTS.deptNo#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    <cfif ListGetAt(ARGUMENTS.args, 1) NEQ 0>
    AND pID IN (<cfqueryparam value="#ListGetAt(ARGUMENTS.args, 1)#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    <cfif ListGetAt(ARGUMENTS.args, 2) NEQ 0>
    AND bID IN (<cfqueryparam value="#ListGetAt(ARGUMENTS.args, 2)#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsSkuReport = StructNew()>
    <cfset rsSkuReport.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsSkuReport>
    </cffunction>
    
    <cffunction name="insertSku" access="public" returntype="struct">
    <cfargument name="pID" type="numeric" required="yes">
    <cfargument name="skuID" type="string" required="yes">
    <cfargument name="skuMPN" type="string" required="yes">
    <cfargument name="skuUPC" type="string" required="yes">
    <cfargument name="skuWeight" type="string" required="yes">
    <cfargument name="skuHeight" type="string" required="yes">
    <cfargument name="skuLength" type="string" required="yes">
    <cfargument name="skuOversize" type="numeric" required="yes">
    <cfargument name="skuOverWeight" type="numeric" required="yes">
    <cfargument name="skuHazmat" type="numeric" required="yes">
    <cfargument name="skuRestricted" type="numeric" required="yes">
    <cfargument name="skuQOH" type="numeric" required="yes">
    <cfargument name="skuDateRel" type="string" required="yes">
    <cfargument name="skuDateExp" type="string" required="yes">
    <cfargument name="skuSort" type="numeric" required="yes">
    <cfargument name="skuStatus" type="numeric" required="yes">
    <cfargument name="paCount" type="numeric" required="yes">
    <cfargument name="paIDList" type="string" required="yes">
    <cfargument name="pavIDList" type="string" required="yes">
    <cfargument name="psaraltValueList" type="string" required="yes">
    <cfset result.message = "You have successfully inserted the record.">
    <cftry>
    <!---Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.app.sku.Sku"
    method="getSku"
    returnvariable="getCheckSkuRet">
    <cfinvokeargument name="skuID" value="#TRIM(ARGUMENTS.skuID)#"/>
    <cfinvokeargument name="skuStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckSkuRet.recordcount NEQ 0>
    <cfset result.message = "The sku #TRIM(ARGUMENTS.skuID)# already exists under #getCheckSkuRet.pName#, please enter a new sku ID or re-assign this sku to this product. <br><br>
	
	<a href=""javascript:void(0);"" onclick=""javascript:ColdFusion.Window.create('ProductSkuWindow#getCheckSkuRet.ID#', 'Product Sku', '/#application.mcmsAppAdminPath#/product/view/inc_update_product_sku_window.cfm?appID=#url.appID#&ID=#getCheckSkuRet.ID#&pID=#TRIM(ARGUMENTS.pID)#&taskReassign=true', {x:100,y:100,height:600,width:1024,modal:true,closable:true,draggable:true,resizable:true,center:true,initshow:true,minheight:600,minwidth:1024})"><span class="glyphicon glyphicon-check"></span>Re-assign Sku?</a>"
	>
    <cfelse>
    <!---Now match the value up to an existing product attribute value.--->
    <cfinvoke 
    component="MCMS.component.app.product_attribute.ProductAttribute"
    method="setProductAttributeValue"
    returnvariable="pavIDListResult">
    <cfinvokeargument name="paIDList" value="#TRIM(ARGUMENTS.paIDList)#"/>
    <cfinvokeargument name="pavIDList" value="#TRIM(ARGUMENTS.pavIDList)#"/>
    <cfinvokeargument name="psaraltValueList" value="#TRIM(ARGUMENTS.psaraltValueList)#"/>
    <cfinvokeargument name="pavStatus" value="1,2,3"/>
    </cfinvoke>
    <!---Remove the check for duplicates for compliance attributes.--->
	<cfset paIDList = TRIM(ARGUMENTS.paIDList)>
    <cfset pavIDList = TRIM(ARGUMENTS.pavIDList)>
    <cfset psaraltValueList = TRIM(ARGUMENTS.psaraltValueList)>
    <cfset paIDCheckList = ''>
    <cfset pavIDCheckList = ''>
    <cfset psaraltValueCheckList = ''>
    <cfset loopcount = 0>
    <cfset loopcountCheck = 0>
    <cfloop index="i" list="#paIDList#">
    <cfset loopcount = loopcount+1>
    <cfif ListContains(application.complianceAuthorizationAttributeList, i)>
    <!---Skip attribute...--->
    <cfelse>
    <cfset paIDCheckList = ListPrepend(paIDCheckList, i)>
    <cfset pavIDCheckValue = ListGetAt(pavIDList,loopcount)>
    <cfif IsNumeric(pavIDCheckValue)>
    <cfset pavIDCheckList = ListPrepend(pavIDCheckList, ListGetAt(pavIDList,loopcount))>
    <cfelse>
    <cfset pavIDCheckList = ListPrepend(pavIDCheckList, 0)>
    </cfif>
    <cfset psaraltValueCheckList = ListPrepend(psaraltValueCheckList, ListGetAt(psaraltValueList,loopcount))>
    <cfset loopCountCheck = loopCountCheck+1>
    </cfif>
    </cfloop>
    <cfif paIDCheckList NEQ ''>
    <!---Check for a duplicate record by attribute.--->
    <cfinvoke 
    component="MCMS.component.app.product.Product"
    method="getProductSkuAttributeRelDuplicate"
    returnvariable="getCheckProductSkuAttributeRelDuplicateRet">
    <cfinvokeargument name="pID" value="#ARGUMENTS.pID#"/>
    <cfinvokeargument name="skuID" value="#ARGUMENTS.skuID#"/>
    <cfinvokeargument name="paIDList" value="#paIDCheckList#"/>
    <cfinvokeargument name="pavIDList" value="#pavIDCheckList#"/>
    <cfinvokeargument name="psaraltValueList" value="#psaraltValueCheckList#"/>
    <cfinvokeargument name="paCount" value="#loopCountCheck#"/>
    <cfinvokeargument name="psarStatus" value="1,2,3"/>
    </cfinvoke>
    <cfelse>
    <cfset getCheckProductSkuAttributeRelDuplicateRet.recordcount = 0>
    </cfif>
    <cfif getCheckProductSkuAttributeRelDuplicateRet.recordcount NEQ 0>
    <cfset result.message = "#ValueList(getCheckProductSkuAttributeRelDuplicateRet.sID)# <br>The sku attribute configuration you have chosen already exist for Sku: #getCheckProductSkuAttributeRelDuplicateRet.skuID#, please choose another sku attribute configuration.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    INSERT INTO tbl_sku (pID,skuID,skuMPN,skuUPC,skuWeight,skuHeight,skuWidth,skuLength,skuOversize,skuOverWeight,skuHazmat,skuRestricted,skuQOH,skuDateRel,skuDateExp,userID,skuSort,skuStatus) VALUES
    (
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.pID#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#TRIM(ARGUMENTS.skuID)#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#TRIM(ARGUMENTS.skuMPN)#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#TRIM(ARGUMENTS.skuUPC)#">,
    <cfqueryparam cfsqltype="cf_sql_float" value="#ARGUMENTS.skuWeight#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#TRIM(ARGUMENTS.skuHeight)#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#TRIM(ARGUMENTS.skuWidth)#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#TRIM(ARGUMENTS.skuLength)#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.skuOversize#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.skuOverWeight#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.skuHazmat#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.skuRestricted#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.skuQOH#">,
    <cfqueryparam cfsqltype="cf_sql_date" value="#DateFormat(ARGUMENTS.skuDateRel, application.dateFormat)#">,
    <cfqueryparam cfsqltype="cf_sql_date" value="#DateFormat(ARGUMENTS.skuDateExp, application.dateFormat)#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#session.userID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.skuSort#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.skuStatus#">
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
    <cfinvokeargument name="pwfcComment" value="Product sku created.">
    <cfinvokeargument name="pStatus" value="3">
    </cfinvoke>
    <!---Get the sku last created.--->
    <cfinvoke 
    component="MCMS.component.cms.Cms"
    method="getMaxValueSQL"
    returnvariable="sID">
    <cfinvokeargument name="tableName" value="tbl_sku"/>
    </cfinvoke>

	<cfloop index="i" from="1" to="#ARGUMENTS.paCount#">
    <cfinvoke 
    component="MCMS.component.app.product.Product"
    method="insertProductSkuAttributeRel"
    returnvariable="result">
    <cfinvokeargument name="sID" value="#sID#"/>
    <cfinvokeargument name="pID" value="#ARGUMENTS.pID#"/>
    <cfinvokeargument name="paID" value="#TRIM(ListGetAt(ARGUMENTS.paIDList, i))#"/>
    <cfinvokeargument name="pavID" value="#TRIM(ListGetAt(pavIDListResult, i))#"/>
    <cfinvokeargument name="psaraltValue" value="#TRIM(ListGetAt(ARGUMENTS.psaraltValueList, i))#"/>
    <cfinvokeargument name="psarStatus" value="1"/>
    </cfinvoke>
    </cfloop>
    </cfif>
    </cfif>
    <cfcatch type="any">
    <cfset result.message = "There was an error inserting the record. A duplicate sku ID may have been found causing this error.  Please check with the System Administrator or use the Sku Manager to find the sku ID.">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="insertSkuFromERP" access="public" returntype="struct">
    <cfargument name="pID" type="numeric" required="yes">
    <cfargument name="deptNo" type="string" required="yes">
    <cfargument name="pSkuList" type="string" required="yes">
    <cfargument name="temppSkuList" type="string" required="yes" default="">
    <cfargument name="resultMessage" type="any" required="yes" default="">
    <cfset result.message = ARGUMENTS.resultMessage>
    <cfset reportMessage = ''>
    <cftry>
    <cfset loopcount = 0>
    <!---Refactor deptNo filter based on ERP system.--->
    <cfif ListLen(ARGUMENTS.deptNo) EQ 1>
    <cfset this.deptNo = ARGUMENTS.deptNo>
    <cfif ListFind('1', this.deptNo)>
    <cfset this.deptNo = '1,4'>
    <cfelseif ListFind('2', this.deptNo)>
    <cfset this.deptNo = '2,4'>
    <cfelseif ListFind('3', this.deptNo)>
    <cfset this.deptNo = '3,7,17,37'>
    <cfelseif ListFind('4', this.deptNo)>
    <cfset this.deptNo = '1,4,7'>
    <cfelseif ListFind('5', this.deptNo)>
    <cfset this.deptNo = '5'>
    <cfelseif ListFind('7', this.deptNo)>
    <cfset this.deptNo = '3,4,7'>
    <cfelseif ListFind('17', this.deptNo)>
    <cfset this.deptNo = '3,7,17'>
    <cfelseif ListFind('37', this.deptNo)>
    <cfset this.deptNo = '3,7,37'>
    </cfif>
    </cfif>
    <cfloop index="skuID" list="#ARGUMENTS.pSkuList#">
    <cfset loopcount = loopcount+1>
    <!---Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.app.sku.Sku"
    method="getSku"
    returnvariable="getCheckSkuRet">
    <cfinvokeargument name="skuID" value="#TRIM(skuID)#"/>
    <cfinvokeargument name="skuStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckSkuRet.recordcount NEQ 0>
    <!---If the sku exists update it to this product and remove it from the other product.--->
    <cftransaction>
    <cfif getCheckSkuRet.pID NEQ ARGUMENTS.pID>
    <!---Find the product in the list and remove it while removing any leading or trailing commas.--->
    <cfset newSkuList = Replace(getCheckSkuRet.pSkuList, TRIM(skuID), '')>
    <cfset newSkuList = REReplace(newSkuList, ',+$', '')>
	<cfset newSkuList = REReplace(newSkuList, '^,', '')>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_product SET
    pSkuList = <cfqueryparam cfsqltype="cf_sql_varchar" value="#newSkuList#">,
    userID = <cfqueryparam cfsqltype="cf_sql_integer" value="#session.userID#">
    WHERE ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#getCheckSkuRet.pID#">
    </cfquery>
    </cfif>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_sku SET
    pID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.pID#">,
    skuDateUpdate = <cfqueryparam cfsqltype="cf_sql_date" value="#DateFormat(Now(), application.dateFormat)#">,
    userID = <cfqueryparam cfsqltype="cf_sql_integer" value="#session.userID#">
    WHERE skuID = <cfqueryparam cfsqltype="cf_sql_varchar" value="#TRIM(skuID)#">
    </cfquery>
    </cftransaction>
    <cfset result.message = result.message & "<br/><strong>#getCheckSkuRet.skuID#</strong> already exists. It has been updated to this product if it was not already.<br/>">
    <cfset reportMessage = reportMessage & "<br/><strong>#getCheckSkuRet.skuID#</strong> already exists. It has been updated to this product if it was not already.<br/>">
    <cfelse>
    <cfinvoke 
    component="MCMS.component.app.interface.Interface"
    method="getSkuQOH_ERP"
    returnvariable="rsSkuQOH_ERP">
    <cfinvokeargument name="sku" value="#TRIM(skuID)#"/>
    <cfif ListLen(ARGUMENTS.deptNo) EQ 1>
    <cfinvokeargument name="deptNo" value="#this.deptNo#"/>
    </cfif>
    </cfinvoke>
    <cfif rsSkuQOH_ERP.recordcount EQ 0>
    <cfset result.message = result.message & "<br/><strong>#TRIM(skuID)#</strong> was not found in the interface. It has not been inserted. It is possible the sku does not exist in department(s) #this.deptNo#.<br/>">
    <cfset reportMessage = reportMessage & "<br/><strong>#TRIM(skuID)#</strong> was not found in the interface. It has not been inserted. It is possible the sku does not exist in department(s) #this.deptNo#.<br/>">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    INSERT INTO tbl_sku (pID,skuID,skuHeight,skuWidth,skuLength,skuMPN,skuUPC,skuDCL,skuDescription,skuDateRel,skuDateExp,userID,skuSort,skuStatus) VALUES
    (
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.pID#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#TRIM(rsSkuQOH_ERP.SKU)#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="0">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="0">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="0">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#TRIM(rsSkuQOH_ERP.MPN)#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#TRIM(rsSkuQOH_ERP.UPC)#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#TRIM(rsSkuQOH_ERP.DCL)#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#TRIM(rsSkuQOH_ERP.NAME)#">,
    <cfqueryparam cfsqltype="cf_sql_date" value="#DateFormat(Now(), application.dateFormat)#">,
    <cfqueryparam cfsqltype="cf_sql_date" value="#DateFormat(DateAdd('yyyy', 10, Now()), application.dateFormat)#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#session.userID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#loopcount#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="3">
    )
    </cfquery>
    </cftransaction>
    <!---Get the sID just inserted to create the list price record.--->
    <cfinvoke 
    component="MCMS.component.cms.Cms"
    method="getMaxValueSQL"
    returnvariable="getMaxValueSQLRet">
    <cfinvokeargument name="tableName" value="tbl_sku"/>
    </cfinvoke>
    <cfset result.sID = getMaxValueSQLRet>
    <!---Insert the list price record.--->
    <cfinvoke 
    component="MCMS.component.app.price.Price"
    method="insertPrice">
    <cfinvokeargument name="pID" value="#ARGUMENTS.pID#"/>
    <cfinvokeargument name="sID" value="#result.sID#"/>
    <cfinvokeargument name="pPrice" value="#TRIM(rsSkuQOH_ERP.LIST_PRICE)#"/>
    <cfinvokeargument name="pMaxRange" value="1"/>
    <cfinvokeargument name="ptID" value="1"/>
    <cfinvokeargument name="pDateRel" value="#DateFormat(Now(), application.dateFormat)#"/>
    <cfinvokeargument name="pDateExp" value="#DateFormat(DateAdd('yyyy', 10, Now()), application.dateFormat)#"/>
    <cfinvokeargument name="pSort" value="1"/>
    <cfinvokeargument name="pStatus" value="1"/>
    </cfinvoke>
    <!---Insert any sku attributes.--->
    <cfinvoke 
    component="MCMS.component.app.product.Product" 
    method="getProductAttributeRel" 
    returnvariable="getProductAttributeRelRet">
    <cfinvokeargument name="pID" value="#ARGUMENTS.pID#">
    <cfinvokeargument name="paStatus" value="1,3">
    <cfinvokeargument name="parStatus" value="1,3">
    <cfinvokeargument name="orderBy" value="paName">
    </cfinvoke>
    <cfif getProductAttributeRelRet.recordcount NEQ 0>
    <cfset this.paIDList = ValueList(getProductAttributeRelRet.paID)>
    <cfloop from="1" to="#getProductAttributeRelRet.recordcount#" index="i">
    <cfinvoke 
    component="MCMS.component.app.product.Product"
    method="insertProductSkuAttributeRel"
    returnvariable="result">
    <cfinvokeargument name="sID" value="#getMaxValueSQLRet#"/>
    <cfinvokeargument name="pID" value="#ARGUMENTS.pID#"/>
    <cfinvokeargument name="paID" value="#TRIM(ListGetAt(this.paIDList, i))#"/>
    <cfinvokeargument name="pavID" value="0"/>
    <cfinvokeargument name="psaraltValue" value="x"/>
    <cfinvokeargument name="psarStatus" value="1"/>
    </cfinvoke>
    </cfloop>
    </cfif>
    <cfset result.message = result.message & "<br/><strong>#TRIM(skuID)#</strong> has been inserted successfully.<br/>">
    <cfset reportMessage = reportMessage & "<br/><strong>#TRIM(skuID)#</strong> has been inserted successfully.<br/>">
    </cfif>
    </cfif>
    </cfloop>
    <!---Check for any removed skus from the list.--->
    <cfif ARGUMENTS.temppSkuList NEQ ''>
    <cfset this.skuIDDeleteList = ''>
    <cfloop index="i" list="#ARGUMENTS.temppSkuList#">
    <cfif ListContains(ARGUMENTS.pSkuList, i)>
    <cfelse>
    <cfset this.skuIDDeleteList = i>
    </cfif>  
    </cfloop>
    <cfif this.skuIDDeleteList NEQ ''>
    <cfinvoke 
    component="MCMS.component.app.sku.Sku"
    method="getSku"
    returnvariable="getSkuRet">
    <cfinvokeargument name="skuID" value="#TRIM(this.skuIDDeleteList)#"/>
    <cfinvokeargument name="skuStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getSkuRet.recordcount NEQ 0>
    <cfset this.sIDDeleteList = ValueList(getSkuRet.ID)>
    <cfinvoke 
    component="MCMS.component.app.sku.Sku"
    method="deleteSku">
    <cfinvokeargument name="ID" value="#this.sIDDeleteList#"/>
    </cfinvoke>
    <cfinvoke 
    component="MCMS.component.app.price.Price"
    method="deletePrice">
    <cfinvokeargument name="sID" value="#this.sIDDeleteList#"/>
    </cfinvoke>
    <cfset reportMessage = reportMessage & "<br/><strong>#TRIM(this.skuIDDeleteList)#</strong> has been deleted successfully.<br/>">
    </cfif>
    </cfif>
    </cfif>
    <!---Send an email to ensure the user knows which skus were successfully processed.--->
    <!---This authorization covers Special Handling.--->
    <cfinvoke 
    component="MCMS.component.app.product.Product"
    method="getProduct"
    returnvariable="getProductRet">
    <cfinvokeargument name="ID" value="#ARGUMENTS.pID#"/>
    <cfinvokeargument name="pStatus" value="1,2,3"/>
    </cfinvoke>
    <cfset this.emailBody = "
	<h3>#application.companyName# Product - #getProductRet.pName# Sku Interface Report</h3>
	#LSDateFormat(Now())# - #LSTimeFormat(Now())#
	<br/><br/>
	<u>Note: Any skus that are created from the interface are in 'Preview' status and still require attribute values.</u>
	<br/>
	<p>
	This notification is to inform you of what sku interface actions have occurred for #getProductRet.pName#.<br/>
	#reportMessage#
	</p>
	<div align='center'><a href='//#CGI.SERVER_NAME#' class='textBold'>Commerce Dashboard</a></div>
	">
    <cfinvoke 
    component="MCMS.component.utility.Email"
    method="sendEmail">
    <cfinvokeargument name="subject" value="#application.companyName# - #getProductRet.pName# Sku Interface Report"/>
    <cfinvokeargument name="to" value="#session.userUsername#"/>
    <cfinvokeargument name="from" value="#application.noReplyEmail#"/>
    <cfinvokeargument name="body" value="#this.emailBody#"/>
    <cfinvokeargument name="ID" value="#ARGUMENTS.pID#"/>
    <cfinvokeargument name="emailTemplate" value=""/>
    </cfinvoke>
    <cfcatch type="any">
    <cfset result.message = "There was an error inserting the sku record(s) during the Sku ERP interface. Please check with the System Administrator.">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="insertSkuImport" access="public" returntype="struct">
    <cfargument name="productID" type="string" required="yes">
    <cfargument name="skuID" type="string" required="yes">
    <cfargument name="skuMPN" type="string" required="yes">
    <cfargument name="skuUPC" type="string" required="yes">
    <cfargument name="userID" type="numeric" required="yes" default="101">
    <cfset result.message = "You have successfully inserted the record.">
    <cftry>
    <!---Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.app.sku.Sku"
    method="getSku"
    returnvariable="getCheckSkuRet">
    <cfinvokeargument name="skuID" value="#TRIM(ARGUMENTS.skuID)#"/>
    <cfinvokeargument name="skuStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckSkuRet.recordcount NEQ 0>
    <cfquery name="getProductID" datasource="#application.mcmsDSN#">
    SELECT ID FROM tbl_product WHERE 0=0
    AND UPPER(productID) = <cfqueryparam value="#UCASE(TRIM(ARGUMENTS.productID))#" cfsqltype="cf_sql_varchar">
    </cfquery>
    <cfif getProductID.recordcount NEQ 0>
    <cfset this.pID = getProductID.ID>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_sku SET 
    skuMPN = <cfqueryparam cfsqltype="cf_sql_varchar" value="#TRIM(ARGUMENTS.skuMPN)#">,
    skuUPC = <cfqueryparam cfsqltype="cf_sql_varchar" value="#TRIM(ARGUMENTS.skuUPC)#">,
    skuDateUpdate = <cfqueryparam cfsqltype="cf_sql_date" value="#DateFormat(Now(), 'mm/dd/yyyy')#">
    WHERE 0=0
    AND pID = <cfqueryparam cfsqltype="cf_sql_integer" value="#this.pID#">
    AND skuID = <cfqueryparam cfsqltype="cf_sql_varchar" value="#TRIM(ARGUMENTS.skuID)#">
    </cfquery>
    </cftransaction>
    </cfif>
    <cfelse>
    <!---Get pID based on productID.--->
    <cfquery name="getProductID" datasource="#application.mcmsDSN#">
    SELECT ID FROM tbl_product WHERE 0=0
    AND UPPER(productID) = <cfqueryparam value="#UCASE(TRIM(ARGUMENTS.productID))#" cfsqltype="cf_sql_varchar">
    </cfquery>
    <cfif getProductID.recordcount NEQ 0>
    <cfset this.pID = getProductID.ID>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    INSERT INTO tbl_sku (pID,skuID,skuMPN,skuUPC,skuWeight,skuHeight,skuWidth,skuLength,skuOversize,skuOverWeight,skuHazmat,skuRestricted,skuQOH,skuDateRel,skuDateExp,userID,skuSort,skuStatus) VALUES
    (
    <cfqueryparam cfsqltype="cf_sql_integer" value="#this.pID#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#TRIM(ARGUMENTS.skuID)#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#TRIM(ARGUMENTS.skuMPN)#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#TRIM(ARGUMENTS.skuUPC)#">,
    <cfqueryparam cfsqltype="cf_sql_float" value="0">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="0">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="0">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="0">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="0">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="0">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="0">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="0">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="0">,
    <cfqueryparam cfsqltype="cf_sql_date" value="#DateFormat(Now(), 'mm/dd/yyyy')#">,
    <cfqueryparam cfsqltype="cf_sql_date" value="#DateFormat(DateAdd('yyyy', 10, Now()), 'mm/dd/yyyy')#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#TRIM(ARGUMENTS.userID)#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="1">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="3">
    )
    </cfquery>
    </cftransaction>
    <!---Make required updates to product status based on type of request.--->
    <cfinvoke 
    component="MCMS.component.app.product.Product" 
    method="updateProductStatus" 
    >
    <cfinvokeargument name="pID" value="#this.pID#">
    <cfinvokeargument name="pwfID" value="107">
    <cfinvokeargument name="pwfcComment" value="Product sku created.">
    <cfinvokeargument name="pStatus" value="3">
    </cfinvoke>
    </cfif>
    </cfif>
    <cfcatch type="any">
    <cflog file="insertSkuImport" application="no" type="error" text="The sku import failed. Message: #cfcatch.message# Detail: #cfcatch.detail#">
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="insertSkuComplianceImport" access="public" returntype="struct">
    <cfargument name="skuID" type="string" required="yes">
    <cfargument name="purchaseRestriction" type="string" required="yes" default="FALSE">
    <cfargument name="purchaseRestrictionCode" type="string" required="yes" default="None">
    <cfset result.message = "You have successfully inserted the record.">
    <cftry>
    <!---Get the sku.--->
    <cfinvoke 
    component="MCMS.component.app.sku.Sku"
    method="getSku"
    returnvariable="getCheckSkuRet">
    <cfinvokeargument name="skuID" value="#TRIM(ARGUMENTS.skuID)#"/>
    <cfinvokeargument name="skuStatus" value="1,2,3"/>
    </cfinvoke>
    <!---Check to see if the sku exists.--->
    <cfif getCheckSkuRet.recordcount NEQ 0>
    <cfset this.pID = getCheckSkuRet.pID>
    <cfset this.sID = getCheckSkuRet.ID>
    <!---Set the product attributes to be updated.--->
    <cfset this.paIDList = '211,212'>
    <!---Set the product values to get the pavID's.--->
    <cfset this.pavValueList = UCASE(ARGUMENTS.purchaseRestriction) & ',' & ARGUMENTS.purchaseRestrictionCode>
    <cfset loopcount = 0>
    <cfloop index="i" list="#this.paIDList#">
    <cfset loopcount = loopcount+1>
    <cflock name="skuComplianceImport" timeout="5">
    <!---Get the pavID value.--->
    <cfinvoke 
    component="MCMS.component.app.product.Product" 
    method="getProductAttributeValue" 
    returnvariable="getProductAttributeValueRet">
    <cfinvokeargument name="paID" value="#i#">
    <cfinvokeargument name="pavValue" value="#ListGetAt(this.pavValueList, loopcount)#">
    </cfinvoke>
    <cfset this.pavID = getProductAttributeValueRet.ID>
    <!---First delete any existing record.--->
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    DELETE FROM tbl_product_sku_attribute_rel
    WHERE 0=0
    AND pID = <cfqueryparam cfsqltype="cf_sql_integer" value="#this.pID#">
    AND sID = <cfqueryparam cfsqltype="cf_sql_integer" value="#this.sID#">
    AND paID = <cfqueryparam cfsqltype="cf_sql_integer" value="#i#">
    </cfquery>
    <!---Now insert the new record.--->
    <cfquery datasource="#application.mcmsDSN#">
    INSERT INTO tbl_product_sku_attribute_rel (pID,sID,paID,pavID,psaraltValue,psarStatus) VALUES
    (
    <cfqueryparam cfsqltype="cf_sql_integer" value="#this.pID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#this.sID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#i#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#this.pavID#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="">, 
    <cfqueryparam cfsqltype="cf_sql_integer" value="1">
    )
    </cfquery>
	<!---Update the sku date.--->
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_sku SET 
    skuDateUpdate = <cfqueryparam cfsqltype="cf_sql_date" value="#DateFormat(Now(), 'mm/dd/yyyy')#">
    WHERE 0=0
    AND pID = <cfqueryparam cfsqltype="cf_sql_integer" value="#this.pID#">
    AND skuID = <cfqueryparam cfsqltype="cf_sql_varchar" value="#TRIM(ARGUMENTS.skuID)#">
    </cfquery>
    </cftransaction>
    </cflock>
    </cfloop>
    </cfif>
    <cfcatch type="any">
    <cflog file="insertSkuComplianceImport" application="no" type="error" text="The sku compliance import failed. Message: #cfcatch.message# Detail: #cfcatch.detail#">
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="updateSku" access="public" returntype="struct">
    <cfargument name="ID" type="numeric" required="yes">
    <cfargument name="pID" type="numeric" required="yes">
    <cfargument name="skuID" type="string" required="yes">
    <cfargument name="skuMPN" type="string" required="yes">
    <cfargument name="skuUPC" type="string" required="yes">
    <cfargument name="skuWeight" type="string" required="yes">
    <cfargument name="skuHeight" type="string" required="yes">
    <cfargument name="skuLength" type="string" required="yes">
    <cfargument name="skuOversize" type="numeric" required="yes">
    <cfargument name="skuOverWeight" type="numeric" required="yes">
    <cfargument name="skuHazmat" type="numeric" required="yes">
    <cfargument name="skuRestricted" type="numeric" required="yes">
    <cfargument name="skuQOH" type="numeric" required="yes">
    <cfargument name="skuDateRel" type="string" required="yes">
    <cfargument name="skuDateExp" type="string" required="yes">
    <cfargument name="skuSort" type="numeric" required="yes">
    <cfargument name="skuStatus" type="numeric" required="yes">
    <cfargument name="paCount" type="numeric" required="yes">
    <cfargument name="paIDList" type="string" required="yes">
    <cfargument name="pavIDList" type="string" required="yes">
    <cfargument name="psaraltValueList" type="string" required="yes">
    <cfset result.message = "You have successfully updated the record.">
    <cftry>
    <!---Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.app.sku.Sku"
    method="getSku"
    returnvariable="getCheckSkuRet">
    <cfinvokeargument name="excludeID" value="#ARGUMENTS.ID#"/>
    <cfinvokeargument name="skuID" value="#TRIM(ARGUMENTS.skuID)#"/>
    <cfinvokeargument name="skuStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckSkuRet.recordcount NEQ 0>
    <cfset result.message = "The sku #TRIM(ARGUMENTS.skuID)# already exists, please enter a new sku.">
    <cfelse>
    
    <!---Now match the value up to an existing product attribute value.--->
    <cftry>
    <cfinvoke 
    component="MCMS.component.app.product_attribute.ProductAttribute"
    method="setProductAttributeValue"
    returnvariable="pavIDListResult">
    <cfinvokeargument name="paIDList" value="#TRIM(ARGUMENTS.paIDList)#"/>
    <cfinvokeargument name="pavIDList" value="#TRIM(ARGUMENTS.pavIDList)#"/>
    <cfinvokeargument name="psaraltValueList" value="#TRIM(ARGUMENTS.psaraltValueList)#"/>
    <cfinvokeargument name="pavStatus" value="1,2,3"/>
    <cfinvokeargument name="formType" value="update"/>
    </cfinvoke>
    <cfcatch type="any">
    </cfcatch>
    </cftry>
    
    <!---Check for a duplicate record by attribute.--->
    <cfinvoke 
    component="MCMS.component.app.product.Product"
    method="getProductSkuAttributeRelDuplicate"
    returnvariable="getCheckProductSkuAttributeRelDuplicateRet">
    <cfinvokeargument name="pID" value="#ARGUMENTS.pID#"/>
    <cfinvokeargument name="excludesID" value="#ARGUMENTS.ID#"/>
    <cfinvokeargument name="paIDList" value="#ARGUMENTS.paIDList#"/>
    <cfinvokeargument name="pavIDList" value="#pavIDListResult#"/>
    <cfinvokeargument name="psaraltValueList" value="#ARGUMENTS.psaraltValueList#"/>
    <cfinvokeargument name="paCount" value="#ARGUMENTS.paCount#"/>
    <cfinvokeargument name="psarStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckProductSkuAttributeRelDuplicateRet.recordcount NEQ 0>
    <cfset result.message = "The sku attribute configuration you have chosen already exist for Sku: #getCheckProductSkuAttributeRelDuplicateRet.skuID#, please choose another sku attribute configuration.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_sku SET
    pID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.pID#">,
    skuID = <cfqueryparam cfsqltype="cf_sql_varchar" value="#TRIM(ARGUMENTS.skuID)#">, 
    skuMPN = <cfqueryparam cfsqltype="cf_sql_varchar" value="#TRIM(ARGUMENTS.skuMPN)#">,
    skuUPC = <cfqueryparam cfsqltype="cf_sql_varchar" value="#TRIM(ARGUMENTS.skuUPC)#">,
    skuWeight = <cfqueryparam cfsqltype="cf_sql_float" value="#ARGUMENTS.skuWeight#">,
    skuHeight = <cfqueryparam cfsqltype="cf_sql_varchar" value="#TRIM(ARGUMENTS.skuHeight)#">,
    skuWidth = <cfqueryparam cfsqltype="cf_sql_varchar" value="#TRIM(ARGUMENTS.skuWidth)#">,
    skuLength = <cfqueryparam cfsqltype="cf_sql_varchar" value="#TRIM(ARGUMENTS.skuLength)#">,
    skuOversize = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.skuOversize#">,
    skuOverWeight = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.skuOverWeight#">,
    skuHazmat = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.skuHazmat#">,
    skuRestricted = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.skuRestricted#">,
    skuDateRel = <cfqueryparam cfsqltype="cf_sql_date" value="#DateFormat(ARGUMENTS.skuDateRel, application.dateFormat)#">,
    skuDateExp = <cfqueryparam cfsqltype="cf_sql_date" value="#DateFormat(ARGUMENTS.skuDateExp, application.dateFormat)#">,
    skuDateUpdate = <cfqueryparam cfsqltype="cf_sql_date" value="#DateFormat(Now(), application.dateFormat)#">,
    userID = <cfqueryparam cfsqltype="cf_sql_integer" value="#session.userID#">,
    skuQOH = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.skuQOH#">,
    skuSort = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.skuSort#">,
    skuStatus = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.skuStatus#">
    WHERE ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ID#">
    </cfquery>
    <!---If the sku has been reassigned update any pricing.--->
    <cfinvoke 
    component="MCMS.component.app.price.Price"
    method="getPrice"
    returnvariable="getCheckPriceRet">
    <cfinvokeargument name="skuID" value="#TRIM(ARGUMENTS.skuID)#"/>
    <cfinvokeargument name="pStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckPriceRet.recordcount NEQ 0>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_price SET
    pID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.pID#">
    WHERE sID = <cfqueryparam cfsqltype="cf_sql_integer" value="#TRIM(ARGUMENTS.ID)#">
    </cfquery>
    </cfif>
    </cftransaction>
    <!---Make required updates to product status based on type of request.--->
    <cfinvoke 
    component="MCMS.component.app.product.Product" 
    method="updateProductStatus" 
    >
    <cfinvokeargument name="pID" value="#ARGUMENTS.pID#">
    <cfinvokeargument name="pwfID" value="107">
    <cfinvokeargument name="pwfcComment" value="Product sku updated.">
    <cfinvokeargument name="pStatus" value="3">
    </cfinvoke>
    <!---Delete any existing relationships.--->
    <cfinvoke 
    component="MCMS.component.app.product.Product"
    method="deleteProductSkuAttributeRel">
    <cfinvokeargument name="sID" value="#ARGUMENTS.ID#"/>
    </cfinvoke>
    <!---Create new relationships.--->
    <cfloop index="i" from="1" to="#ARGUMENTS.paCount#">
    <cfinvoke 
    component="MCMS.component.app.product.Product"
    method="insertProductSkuAttributeRel"
    returnvariable="result">
    <cfinvokeargument name="sID" value="#ARGUMENTS.ID#"/>
    <cfinvokeargument name="pID" value="#ARGUMENTS.pID#"/>
    <cfinvokeargument name="paID" value="#TRIM(ListGetAt(ARGUMENTS.paIDList, i))#"/>
    <cfinvokeargument name="pavID" value="#TRIM(ListGetAt(pavIDListResult, i))#"/>
    <cfinvokeargument name="psaraltValue" value="#TRIM(ListGetAt(ARGUMENTS.psaraltValueList, i))#"/>
    <cfinvokeargument name="psarStatus" value="1"/>
    </cfinvoke>
    </cfloop>
    <!---Now check if all skus have been compliance updated to warrant an email to be sent to the product user.--->
    <cfinvoke 
    component="MCMS.component.app.sku.Sku"
    method="getSku"
    returnvariable="getSkuRet">
    <cfinvokeargument name="pID" value="#ARGUMENTS.pID#"/>
    </cfinvoke>
    
    <cfinvoke 
    component="MCMS.component.app.product.Product"
    method="getProductSkuAttributeRel"
    returnvariable="getProductSkuAttributeRelRet">
    <cfinvokeargument name="pID" value="#ARGUMENTS.pID#"/>
    <cfinvokeargument name="paID" value="212"/>
    <cfinvokeargument name="excludepavValue" value="0"/>
    </cfinvoke>
	
    <cfif getSkuRet.recordcount EQ getProductSkuAttributeRelRet.recordcount>
    <cfset result.message = result.message & " " & "Email notification(s) have been sent to any product where the compliance updates are complete.">
    <cfinvoke 
    component="MCMS.component.utility.Email"
    method="sendEmail">
    <cfinvokeargument name="subject" value="Compliance Completed - #getSkuRet.pName# (#getSkuRet.productID#)"/>
    <cfinvokeargument name="to" value="#getSkuRet.userEmail#"/>
    <cfinvokeargument name="from" value="#session.userUsername#"/>
    <cfinvokeargument name="cc" value=""/>
    <cfinvokeargument name="bcc" value=""/>
    <cfinvokeargument name="body" value=""/>
    <cfinvokeargument name="ID" value="#getSkuRet.pID#"/>
    <cfinvokeargument name="emailTemplate" value="/#application.mcmsAppAdminPath#/sku_manager/view/inc_sku_compliance_email_template.cfm"/>
    <cfinvokeargument name="emailType" value="html"/>
    <cfinvokeargument name="type" value="admin"/>
    </cfinvoke>
    </cfif>
    </cfif>
    </cfif>
    <cfcatch type="any">
    <cfset result.message = "There was an error updating the record.">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="updateSkuList" access="public" returntype="struct">
    <cfargument name="ID" type="numeric" required="yes">
    <cfargument name="skuStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully updated the records.">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_sku SET
    skuStatus = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.skuStatus#">
    WHERE ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ID#">
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error updating the records.">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="deleteSku" access="public" returntype="struct">
    <cfargument name="ID" type="string" required="yes">
    <cfset result.message = "You have successfully deleted/updates the record(s).">
    <cftry>
    <cfinvoke 
    component="MCMS.component.app.product.Product" 
    method="deleteProductSkuAttributeRel" 
    returnvariable="result">
    <cfinvokeargument name="sID" value="#ARGUMENTS.ID#">
    </cfinvoke>
    <cfinvoke 
    component="MCMS.component.app.photography_workflow.PhotographyWorkflow" 
    method="deletePWFItem" 
    returnvariable="result">
    <cfinvokeargument name="sID" value="#ARGUMENTS.ID#">
    </cfinvoke>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    DELETE FROM tbl_sku
    WHERE ID IN (<cfqueryparam cfsqltype="cf_sql_integer" list="yes" value="#ARGUMENTS.ID#">)
    </cfquery>
    </cftransaction>
    <!---Delete any product sku rel. data.--->
    <cfcatch type="any">
    <cfset result.message = "There was an error deleting the record(s).">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>   
</cfcomponent>