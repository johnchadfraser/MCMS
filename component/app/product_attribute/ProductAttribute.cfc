<cfcomponent>
<cffunction name="getProductAttributeSecondaryCategoryRel" access="public" returntype="query" hint="Get Product Attribute Secondary Category Rel data.">
<cfargument name="keywords" type="string" required="yes" default="All">
<cfargument name="ID" type="string" required="yes" default="0">
<cfargument name="paID" type="string" required="yes" default="">
<cfargument name="excludeID" type="string" required="yes" default="0">
<cfargument name="paName" type="string" required="yes" default="">
<cfargument name="scatID" type="string" required="yes" default="">
<cfargument name="paStatus" type="string" required="yes" default="1">
<cfargument name="scatStatus" type="string" required="yes" default="1">
<cfargument name="pascrStatus" type="string" required="yes" default="1,3">
<cfargument name="orderBy" type="string" required="yes" default="paName">
<cfset var rsProductAttributeSecondaryCategoryRel = "" >
<cftry>
<cfquery name="rsProductAttributeSecondaryCategoryRel" datasource="#application.mcmsDSN#">
SELECT * FROM v_product_attr_sec_cat_rel WHERE 0=0
<cfif ARGUMENTS.ID NEQ 0>
AND ID IN (<cfqueryparam value="#ARGUMENTS.ID#" list="yes" cfsqltype="cf_sql_integer">)
</cfif>
<cfif ARGUMENTS.excludeID NEQ 0>
AND ID NOT IN (<cfqueryparam value="#ARGUMENTS.excludeID#" list="yes" cfsqltype="cf_sql_integer">)
</cfif>
<cfif ARGUMENTS.keywords NEQ 'All'>
AND (UPPER(paName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(scatName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">)
</cfif>
<cfif ARGUMENTS.paID NEQ ''>
AND paID IN (<cfqueryparam value="#ARGUMENTS.paID#" list="yes" cfsqltype="cf_sql_integer">)
</cfif>
<cfif ARGUMENTS.scatID NEQ ''>
AND scatID IN (<cfqueryparam value="#ARGUMENTS.scatID#" list="yes" cfsqltype="cf_sql_integer">)
</cfif>
<cfif ARGUMENTS.paName NEQ "">
AND UPPER(paName) = <cfqueryparam value="#UCASE(ARGUMENTS.paName)#" cfsqltype="cf_sql_varchar">
</cfif>
AND paStatus IN (<cfqueryparam value="#ARGUMENTS.paStatus#" list="yes" cfsqltype="cf_sql_integer">)
AND scatStatus IN (<cfqueryparam value="#ARGUMENTS.scatStatus#" list="yes" cfsqltype="cf_sql_integer">)
AND pascrStatus IN (<cfqueryparam value="#ARGUMENTS.pascrStatus#" list="yes" cfsqltype="cf_sql_integer">)
ORDER BY #ARGUMENTS.orderBy#
</cfquery>
<!---Catch any errors.--->
<cfcatch type="any">
<cfset rsProductAttributeSecondaryCategoryRel = StructNew()>
<cfset rsProductAttributeSecondaryCategoryRel.message = "There was an error with the query.">
<cfif url.mcmsDebug EQ true>
<cfdump var="#CFCATCH#">
</cfif>
</cfcatch>
</cftry>
<cfreturn rsProductAttributeSecondaryCategoryRel>
</cffunction>

<cffunction name="getProductAttributeLineCategoryRel" access="public" returntype="query" hint="Get Product Attribute Line Category Rel data.">
<cfargument name="keywords" type="string" required="yes" default="All">
<cfargument name="ID" type="string" required="yes" default="0">
<cfargument name="paID" type="string" required="yes" default="">
<cfargument name="excludeID" type="string" required="yes" default="0">
<cfargument name="paName" type="string" required="yes" default="">
<cfargument name="lcatID" type="string" required="yes" default="">
<cfargument name="paStatus" type="string" required="yes" default="1">
<cfargument name="lcatStatus" type="string" required="yes" default="1">
<cfargument name="palcrStatus" type="string" required="yes" default="1,3">
<cfargument name="orderBy" type="string" required="yes" default="paName">
<cfset var rsProductAttributeLineCategoryRel = "" >
<cftry>
<cfquery name="rsProductAttributeLineCategoryRel" datasource="#application.mcmsDSN#">
SELECT * FROM v_product_attr_line_cat_rel WHERE 0=0
<cfif ARGUMENTS.ID NEQ 0>
AND ID IN (<cfqueryparam value="#ARGUMENTS.ID#" list="yes" cfsqltype="cf_sql_integer">)
</cfif>
<cfif ARGUMENTS.excludeID NEQ 0>
AND ID NOT IN (<cfqueryparam value="#ARGUMENTS.excludeID#" list="yes" cfsqltype="cf_sql_integer">)
</cfif>
<cfif ARGUMENTS.keywords NEQ 'All'>
AND (UPPER(paName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(lcatName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">)
</cfif>
<cfif ARGUMENTS.paID NEQ ''>
AND paID IN (<cfqueryparam value="#ARGUMENTS.paID#" list="yes" cfsqltype="cf_sql_integer">)
</cfif>
<cfif ARGUMENTS.lcatID NEQ ''>
AND lcatID IN (<cfqueryparam value="#ARGUMENTS.lcatID#" list="yes" cfsqltype="cf_sql_integer">)
</cfif>
<cfif ARGUMENTS.paName NEQ "">
AND UPPER(paName) = <cfqueryparam value="#UCASE(ARGUMENTS.paName)#" cfsqltype="cf_sql_varchar">
</cfif>
AND paStatus IN (<cfqueryparam value="#ARGUMENTS.paStatus#" list="yes" cfsqltype="cf_sql_integer">)
AND lcatStatus IN (<cfqueryparam value="#ARGUMENTS.lcatStatus#" list="yes" cfsqltype="cf_sql_integer">)
AND palcrStatus IN (<cfqueryparam value="#ARGUMENTS.palcrStatus#" list="yes" cfsqltype="cf_sql_integer">)
ORDER BY #ARGUMENTS.orderBy#
</cfquery>
<!---Catch any errors.--->
<cfcatch type="any">
<cfset rsProductAttributeLineCategoryRel = StructNew()>
<cfset rsProductAttributeLineCategoryRel.message = "There was an error with the query.">
<cfif url.mcmsDebug EQ true>
<cfdump var="#CFCATCH#">
</cfif>
</cfcatch>
</cftry>
<cfreturn rsProductAttributeLineCategoryRel>
</cffunction>

<cffunction name="getProductAttributeSecondaryLineCategoryRel" access="public" returntype="query" hint="Get Product Attribute Secondary Line Category Rel data.">
<cfargument name="keywords" type="string" required="yes" default="All">
<cfargument name="ID" type="string" required="yes" default="0">
<cfargument name="paID" type="string" required="yes" default="">
<cfargument name="excludeID" type="string" required="yes" default="0">
<cfargument name="paName" type="string" required="yes" default="">
<cfargument name="slcatID" type="string" required="yes" default="">
<cfargument name="paStatus" type="string" required="yes" default="1">
<cfargument name="slcatStatus" type="string" required="yes" default="1">
<cfargument name="paslcrStatus" type="string" required="yes" default="1,3">
<cfargument name="orderBy" type="string" required="yes" default="paName">
<cfset var rsProductAttributeSecondaryLineCategoryRel = "" >
<cftry>
<cfquery name="rsProductAttributeSecondaryLineCategoryRel" datasource="#application.mcmsDSN#">
SELECT * FROM v_product_attr_sec_l_cat_rel WHERE 0=0
<cfif ARGUMENTS.ID NEQ 0>
AND ID IN (<cfqueryparam value="#ARGUMENTS.ID#" list="yes" cfsqltype="cf_sql_integer">)
</cfif>
<cfif ARGUMENTS.excludeID NEQ 0>
AND ID NOT IN (<cfqueryparam value="#ARGUMENTS.excludeID#" list="yes" cfsqltype="cf_sql_integer">)
</cfif>
<cfif ARGUMENTS.keywords NEQ 'All'>
AND (UPPER(paName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(slcatName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">)
</cfif>
<cfif ARGUMENTS.paID NEQ ''>
AND paID IN (<cfqueryparam value="#ARGUMENTS.paID#" list="yes" cfsqltype="cf_sql_integer">)
</cfif>
<cfif ARGUMENTS.slcatID NEQ ''>
AND slcatID IN (<cfqueryparam value="#ARGUMENTS.slcatID#" list="yes" cfsqltype="cf_sql_integer">)
</cfif>
<cfif ARGUMENTS.paName NEQ "">
AND UPPER(paName) = <cfqueryparam value="#UCASE(ARGUMENTS.paName)#" cfsqltype="cf_sql_varchar">
</cfif>
AND paStatus IN (<cfqueryparam value="#ARGUMENTS.paStatus#" list="yes" cfsqltype="cf_sql_integer">)
AND slcatStatus IN (<cfqueryparam value="#ARGUMENTS.slcatStatus#" list="yes" cfsqltype="cf_sql_integer">)
AND paslcrStatus IN (<cfqueryparam value="#ARGUMENTS.paslcrStatus#" list="yes" cfsqltype="cf_sql_integer">)
ORDER BY #ARGUMENTS.orderBy#
</cfquery>
<!---Catch any errors.--->
<cfcatch type="any">
<cfset rsProductAttributeSecondaryLineCategoryRel = StructNew()>
<cfset rsProductAttributeSecondaryLineCategoryRel.message = "There was an error with the query.">
<cfif url.mcmsDebug EQ true>
<cfdump var="#CFCATCH#">
</cfif>
</cfcatch>
</cftry>
<cfreturn rsProductAttributeSecondaryLineCategoryRel>
</cffunction>

<cffunction name="getDistrinctProductAttributeValue" access="public" returntype="query" hint="Get distinct product attribute value.">
<cfargument name="keywords" type="string" required="yes" default="All">
<cfargument name="ID" type="numeric" required="yes" default="0">
<cfargument name="paID" type="numeric" required="yes" default="0">
<cfargument name="excludeID" type="numeric" required="yes" default="0">
<cfargument name="pavStatus" type="string" required="yes" default="1,3">
<cfargument name="orderBy" type="string" required="yes" default="pavValue">
<cfset var rsProductAttributeValue = "" >
<cftry>
<!---First get a distinct collection of values.--->
<cfquery name="rsProductAttributeValue" datasource="#application.mcmsDSN#">
SELECT DISTINCT pavValue, ID FROM tbl_product_attribute_value WHERE 0=0
<cfif ARGUMENTS.ID NEQ 0>
AND ID = <cfqueryparam value="#ARGUMENTS.ID#" cfsqltype="cf_sql_integer">
</cfif>
<cfif ARGUMENTS.excludeID NEQ 0>
AND ID <> <cfqueryparam value="#ARGUMENTS.excludeID#" cfsqltype="cf_sql_integer">
</cfif>
<cfif ARGUMENTS.keywords NEQ 'All'>
AND (UPPER(pavValue) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">)
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
<cfif url.mcmsDebug EQ true>
<cfdump var="#CFCATCH#">
</cfif>
</cfcatch>
</cftry>
<cfreturn rsProductAttributeValue>
</cffunction>

<cffunction name="setProductAttributeReset" access="public" returntype="string" output="yes" hint="Set Reset button.">
<cfargument name="formName" type="string" required="yes" default="">
<cfargument name="currentRow" type="numeric" required="yes" default="0">  
<cfargument name="patFieldCount" type="numeric" required="yes" default="0"> 
<cfargument name="uomID" type="string" required="yes" default="0">
<cfargument name="sepID" type="string" required="yes" default="0">
<cfargument name="paDefaultValue" type="string" required="yes" default=""> 
<cfset result = ''> 
<cfsavecontent variable="result">
<cfif ARGUMENTS.patFieldCount GT 1>
<span class="glyphicon glyphicon-refresh" onClick="javascript: resetSelected('#ARGUMENTS.formName#', 'parValue','#ARGUMENTS.currentRow#', '#ARGUMENTS.patFieldCount#', '#Iif(ARGUMENTS.uomID EQ 0, DE('0'), DE('#ListLen(ARGUMENTS.uomID)#'))#', '#Iif(ARGUMENTS.sepID EQ 0, DE('0'), DE('#ListLen(ARGUMENTS.sepID)#'))#');"></span>
</cfif>
<!---Label for results.--->
<div id="#ARGUMENTS.formName#parValue#ARGUMENTS.currentRow#Label" style="display:none; font-size:10px;">
<cfif ARGUMENTS.patFieldCount GT 1><label for="parValue#ARGUMENTS.currentRow#" style="font-weight:bold">Result:&nbsp;<input type="#Iif(ARGUMENTS.patFieldCount GT 1, DE('text'), DE('hidden'))#" name="parValue#ARGUMENTS.currentRow#" id="parValue#ARGUMENTS.currentRow#" size="64" readonly style="border:0;" value="#ARGUMENTS.paDefaultValue#"></label></cfif></div>
</cfsavecontent>
<cfreturn result> 
</cffunction>

<cffunction name="setRecommendedProductAttribute" access="public" returntype="string" output="yes" hint="Set Recommended Attributes.">
<cfargument name="scatIDList" type="string" required="yes" default="0">
<cfargument name="lcatIDList" type="string" required="yes" default="0">
<cfargument name="slcatIDList" type="string" required="yes" default="0">
<cfset result = 0> 
<cfinvoke 
component="MCMS.component.app.product_attribute.ProductAttribute"
method="getProductAttributeSecondaryCategoryRel"
returnvariable="getProductAttributeSecondaryCategoryRelRet">
<cfinvokeargument name="scatID" value="#ARGUMENTS.scatIDList#"/>
</cfinvoke>
<cfif getProductAttributeSecondaryCategoryRelRet.recordcount EQ 0>
<cfset result = 0>
<cfelse>
<cfset result = ListRemoveDuplicates(ValueList(getProductAttributeSecondaryCategoryRelRet.paID))>
</cfif>
<cfinvoke 
component="MCMS.component.app.product_attribute.ProductAttribute"
method="getProductAttributeLineCategoryRel"
returnvariable="getProductAttributeLineCategoryRelRet">
<cfinvokeargument name="lcatID" value="#ARGUMENTS.lcatIDList#"/>
</cfinvoke>
<cfif getProductAttributeLineCategoryRelRet.recordcount EQ 0>
<cfset result = result>
<cfelse>
<cfset result = result & ',' & ListRemoveDuplicates(ValueList(getProductAttributeLineCategoryRelRet.paID))>
</cfif>
<cfinvoke 
component="MCMS.component.app.product_attribute.ProductAttribute"
method="getProductAttributeSecondaryLineCategoryRel"
returnvariable="getProductAttributeSecondaryLineCategoryRelRet">
<cfinvokeargument name="slcatID" value="#ARGUMENTS.slcatIDList#"/>
</cfinvoke>
<cfif getProductAttributeSecondaryLineCategoryRelRet.recordcount EQ 0>
<cfset result = result>
<cfelse>
<cfset result = result & ',' & ListRemoveDuplicates(ValueList(getProductAttributeSecondaryLineCategoryRelRet.paID))>
</cfif>
<cfreturn ListRemoveDuplicates(result)> 
</cffunction>

<cffunction name="setProductAttributeNextValue" access="public" returntype="string" output="yes" hint="Set Next value to focus too.">
<cfargument name="currentIndex" type="numeric" required="yes" default="0">
<cfargument name="currentRow" type="numeric" required="yes" default="0">  
<cfargument name="patFieldCount" type="numeric" required="yes" default="0"> 
<cfargument name="uomID" type="string" required="yes" default="0">
<cfargument name="sepID" type="string" required="yes" default="0">
<cfset nextField = ''> 
<!---Rules for Values.--->
<!---Set the order of indexing based on uomID and sepID for javascript.--->
<cfif ARGUMENTS.uomID EQ 0 AND ARGUMENTS.sepID EQ 0 AND ARGUMENTS.patFieldCount NEQ ARGUMENTS.currentIndex>
<cfset nextField = 'parValue#ARGUMENTS.currentRow#Option#ARGUMENTS.currentIndex+1#'>
<cfelseif ARGUMENTS.uomID EQ 0 AND ARGUMENTS.sepID NEQ 0 AND ARGUMENTS.patFieldCount NEQ ARGUMENTS.currentIndex>
<cfset nextField = 'separator#ARGUMENTS.currentRow#Option#ARGUMENTS.currentIndex#'>
<cfelseif ARGUMENTS.uomID NEQ 0 AND ARGUMENTS.sepID EQ 0>
<cfset nextField = 'uom#ARGUMENTS.currentRow#Option#ARGUMENTS.currentIndex#'>
<cfelseif ARGUMENTS.uomID NEQ 0 AND ARGUMENTS.sepID NEQ 0>
<cfset nextField = 'uom#ARGUMENTS.currentRow#Option#ARGUMENTS.currentIndex#'>
<cfelseif ARGUMENTS.patFieldCount EQ ARGUMENTS.currentIndex AND ARGUMENTS.sepID NEQ 0>
<cfset nextField = ''>
<cfelseif ARGUMENTS.patFieldCount EQ 1 AND ARGUMENTS.uomID EQ 0 AND ARGUMENTS.sepID EQ 0>
<cfset nextField = ''>
<cfelse>
<cfset nextField = ''>
</cfif>
<cfreturn nextField> 
</cffunction>

<cffunction name="setProductAttributeUOM" access="public" returntype="string" output="yes" hint="Set UOM.">
<cfargument name="formName" type="string" required="yes" default="">
<cfargument name="currentIndex" type="numeric" required="yes" default="0">
<cfargument name="currentRow" type="numeric" required="yes" default="0"> 
<cfargument name="paName" type="string" required="yes" default="">  
<cfargument name="patFieldCount" type="numeric" required="yes" default="0">
<cfargument name="paRequired" type="numeric" required="yes" default="0"> 
<cfargument name="uomID" type="string" required="yes" default="0">
<cfargument name="sepID" type="string" required="yes" default="0">
<cfset result = ''>
<cfsavecontent variable="result">
<cfinvoke 
component="MCMS.component.utility.List" 
method="getUOM" 
returnvariable="getUOMRet">
<cfif ARGUMENTS.uomID NEQ 100>
<cfinvokeargument name="ID" value="#ARGUMENTS.uomID#">
</cfif>
<cfinvokeargument name="uomStatus" value="1,3">
</cfinvoke>
<!---Rules for UOM.--->
<cfif ARGUMENTS.patFieldCount EQ ARGUMENTS.currentIndex AND ARGUMENTS.sepID EQ 0>
<cfset nextFieldUOM = ''>
<cfelseif ARGUMENTS.sepID EQ 0>
<cfset nextFieldUOM = 'parValue#ARGUMENTS.currentRow#Option#ARGUMENTS.currentIndex+1#'>
<cfelseif ARGUMENTS.patFieldCount EQ ARGUMENTS.currentIndex AND ARGUMENTS.sepID NEQ 0>
<cfset nextFieldUOM = ''>
<cfelse>
<cfset nextFieldUOM = 'separator#ARGUMENTS.currentRow#Option#ARGUMENTS.currentIndex#'>
</cfif> 
<select name="uom#ARGUMENTS.currentRow#Option#ARGUMENTS.currentIndex#" id="uom#ARGUMENTS.currentRow#Option#ARGUMENTS.currentIndex#" onChange="javascript: setValue('#ARGUMENTS.formName#', 'parValue#ARGUMENTS.currentRow#', this, 'true', '#nextFieldUOM#');" disabled="true" required="#ARGUMENTS.paRequired#" message="Please select a #ARGUMENTS.paName# UOM #ARGUMENTS.currentIndex#.">
<option value=""></option>
<cfoutput query="getUOMRet">
<option value="#getUOMRet.uomName#">#getUOMRet.uomName#</option>
</cfoutput>
</select>
</cfsavecontent>
<cfreturn result> 
</cffunction>

<cffunction name="setProductAttributeSeparator" access="public" returntype="string" output="yes" hint="Set Separator.">
<cfargument name="formName" type="string" required="yes" default="">
<cfargument name="currentIndex" type="numeric" required="yes" default="0">
<cfargument name="currentRow" type="numeric" required="yes" default="0"> 
<cfargument name="paName" type="string" required="yes" default="">  
<cfargument name="patFieldCount" type="numeric" required="yes" default="0">
<cfargument name="paRequired" type="numeric" required="yes" default="0"> 
<cfargument name="uomID" type="string" required="yes" default="0">
<cfargument name="sepID" type="string" required="yes" default="0">
<cfset result = ''>
<cfsavecontent variable="result">
<cfinvoke 
component="MCMS.component.utility.List" 
method="getSeparator" 
returnvariable="getSeparatorRet">
<cfif ARGUMENTS.sepID NEQ 100>
<cfinvokeargument name="ID" value="#ARGUMENTS.sepID#">
</cfif>
<cfinvokeargument name="sepStatus" value="1,3">
</cfinvoke>
<!---Rules for Separator.--->
<cfif ARGUMENTS.patFieldCount EQ ARGUMENTS.currentIndex>
<cfset nextFieldSeparator = ''>
<cfelse>
<cfset nextFieldSeparator = 'parValue#ARGUMENTS.currentRow#Option#ARGUMENTS.currentIndex+1#'>
</cfif>
<cfif ARGUMENTS.patFieldCount NEQ ARGUMENTS.currentIndex>
<select name="separator#ARGUMENTS.currentRow#Option#ARGUMENTS.currentIndex#" id="separator#ARGUMENTS.currentRow#Option#ARGUMENTS.currentIndex#" onChange="javascript: setValue('#ARGUMENTS.formName#','parValue#ARGUMENTS.currentRow#', this, 'true', '#nextFieldSeparator#');" disabled="true" required="#ARGUMENTS.paRequired#" message="Please select a #ARGUMENTS.paName# Separator #ARGUMENTS.currentIndex#.">
<option value=""></option>
<cfoutput query="getSeparatorRet">
<option value="#getSeparatorRet.sepName# ">#getSeparatorRet.sepName#</option>
</cfoutput>
</select>
</cfif>
</cfsavecontent>
<cfreturn result> 
</cffunction>

<cffunction name="setProductAttributeValue" access="public" returntype="any" output="no" hint="Sets the Product Attribute Value if it does not exist.">
<cfargument name="paIDList" type="string" required="yes" default="">
<cfargument name="pavIDList" type="string" required="yes" default="">
<cfargument name="psaraltValueList" type="string" required="yes" default="">
<cfargument name="pavStatus" type="string" required="yes" default="1,3">
<cfargument name="formType" type="string" required="yes" default="">
<cfset result = ''>
<cftry>
<!---First check to see if the value exists.--->
<!---Loop all paIDList values.--->
<cfset loopcount = 0>
<cfloop index="i" list="#ARGUMENTS.paIDList#">
<cfset loopcount = loopcount+1>
<cfif ListContains(application.complianceAuthorizationAttributeList, TRIM(ListGetAt(ARGUMENTS.paIDList, loopcount))) AND ARGUMENTS.formType EQ '' AND ARGUMENTS.formType NEQ 'byPassComplianceCheck'>
<cfset result = ListAppend(result, 0)>
<cfelse>
<cfinvoke 
component="MCMS.component.app.product.Product" 
method="getProductAttributeValue" 
returnvariable="getProductAttributeValueRet">
<cfinvokeargument name="paID" value="#i#">
<!---If the alt value is not x use it to match.--->
<cfif TRIM(ListGetAt(ARGUMENTS.psaraltValueList, loopcount)) EQ 'x'>
<cfinvokeargument name="pavValue" value="#TRIM(ListGetAt(ARGUMENTS.pavIDList, loopcount))#">
<cfelse>
<cfinvokeargument name="pavValue" value="#TRIM(ListGetAt(ARGUMENTS.psaraltValueList, loopcount))#">
</cfif>
<cfinvokeargument name="pavStatus" value="#ARGUMENTS.pavStatus#">
</cfinvoke>
<!---If the pavValue exists as a product attribute value pass the ID for the value.--->
<cfif getProductAttributeValueRet.recordcount NEQ 0>
<cfset result = ListAppend(result, getProductAttributeValueRet.ID)>
<!---If not matched, add it to the product attribute value table then append the new value to the list.--->
<cfelse>
<cfquery name="getMaxValueSQLRet" datasource="#application.mcmsDSN#">
SELECT last_number
FROM all_sequences
WHERE sequence_owner = 'SWWEB'
AND sequence_name = 'SQ_PRODUCT_ATTRIBUTE_VALUE'
</cfquery>
<cfset this.pavID = getMaxValueSQLRet.last_number>
<cfinvoke 
component="MCMS.component.app.product.Product"
method="insertProductAttributeValue">
<cfinvokeargument name="paID" value="#i#"/>
<!---If the alt value is not x use it to match.--->
<cfif TRIM(ListGetAt(ARGUMENTS.psaraltValueList, loopcount)) EQ 'x'>
<cfinvokeargument name="pavValue" value="#TRIM(ListGetAt(ARGUMENTS.pavIDList, loopcount))#"/>
<cfelse>
<cfinvokeargument name="pavValue" value="#TRIM(ListGetAt(ARGUMENTS.psaraltValueList, loopcount))#">
</cfif>
<cfinvokeargument name="pavCode" value=""/>
<cfinvokeargument name="pavERPCode" value=""/>
<cfinvokeargument name="pavPOSCode" value=""/>
<cfinvokeargument name="imgID" value="0"/>
<cfinvokeargument name="pavSort" value="1"/>
<cfinvokeargument name="pavStatus" value="1"/>
</cfinvoke>
<!---Add newly inserted pavID to list.--->
<cfif loopcount EQ 1 OR result EQ ''>
<cfset result = this.pavID>
<cfelse>
<cfset result = ListAppend(result, '#this.pavID#')>
</cfif>
</cfif>
</cfif>
</cfloop>
<cflog file="skuManagerUpdate" text="#result#">
<cfcatch type="any">
<cfset pavIDList.message = "There was an error inserting the record.">
<cfif url.mcmsDebug EQ true>
<cfdump var="#CFCATCH#">
</cfif>
</cfcatch>
</cftry>
<cfreturn result> 
</cffunction>

<cffunction name="setProductAttributeType" access="public" returntype="any" hint="A special method to control product attribute types for forms.">
<cfargument name="pID" type="numeric" required="yes" default="0">
<cfargument name="sID" type="numeric" required="yes" default="0">
<cfargument name="paID" type="numeric" required="yes" default="0">
<cfargument name="paName" type="string" required="yes" default="Default">
<cfargument name="patID" type="numeric" required="yes">
<cfargument name="patFieldCount" type="numeric" required="yes">
<cfargument name="paRequired" type="numeric" required="yes" default="0">
<cfargument name="paDefaultValue" type="string" required="yes" default="">
<cfargument name="paRegex" type="string" required="yes" default="">
<cfargument name="paRangeStart" type="string" required="yes" value="">
<cfargument name="paRangeEnd" type="string" required="yes" value="">
<cfargument name="paComponent" type="string" required="yes" value="">
<cfargument name="paMethod" type="string" required="yes" value="">
<cfargument name="paValueColumn" type="string" required="yes" value="">
<cfargument name="paNameColumn" type="string" required="yes" value="">
<cfargument name="paArgumentList" type="string" required="yes" value="">
<cfargument name="paLOVList" type="string" required="yes" value="">
<cfargument name="uomID" type="string" required="yes" default="">
<cfargument name="sepID" type="string" required="yes" default="">
<cfargument name="currentRow" type="string" required="yes" default="1">
<cfargument name="formName" type="string" required="yes" default="">
<cfargument name="formType" type="string" required="yes" default="">
<cfargument name="appSource" type="string" required="yes" default="">
<cfargument name="fieldSize" type="numeric" required="yes" default="12">
<cfset result.message = "You have successfully updated the record(s).">
<cftry>
<!---Based on type control the values for menus etc..--->
<!---Call and set attribute object.--->
<cfsilent>
<cfobject name="attributeObj" component="MCMS.component.app.product_attribute.ProductAttribute">
<cfif ARGUMENTS.pID NEQ 0>
<cfinvoke 
component="MCMS.component.app.product.Product" 
method="getProductSkuAttributeRel" 
returnvariable="getProductSkuAttributeRelRet">
<cfinvokeargument name="pID" value="#ARGUMENTS.pID#">
<cfinvokeargument name="sID" value="#ARGUMENTS.sID#">
<cfinvokeargument name="paID" value="#ARGUMENTS.paID#">
<cfinvokeargument name="paStatus" value="1,3">
<cfinvokeargument name="psarStatus" value="1,3">
</cfinvoke>
<cfif getProductSkuAttributeRelRet.recordcount NEQ 0>
<cfset ARGUMENTS.paDefaultValue = Replace(getProductSkuAttributeRelRet.pavValue, '##' , '' , 'ALL')>
</cfif>
</cfif>
<!---Clean up any hash signs in pavValue.--->
<cfset ARGUMENTS.paDefaultValue = Replace(ARGUMENTS.paDefaultValue, '##', '', 'ALL')>
<cfset this.pavValue = Iif(ARGUMENTS.paDefaultValue NEQ '', DE(ARGUMENTS.paDefaultValue), DE('x'))>
</cfsilent>
<!---DO NOT CHANGE THE 'cfform' CODE BELOW!--->
<!--<cfform name="#ARGUMENTS.formName#">-->
<cfsavecontent variable="result">
<cfif ListContains(application.complianceAuthorizationAttributeList, ARGUMENTS.paID) AND ARGUMENTS.appSource EQ 'product'>
To be completed by Compliance.
<cfinput type="hidden" size="10" name="#ARGUMENTS.formType#psaraltValue#ARGUMENTS.currentRow#" id="#ARGUMENTS.formType#psaraltValue#ARGUMENTS.currentRow#" value="x" required="no">
<cfinput type="hidden" size="10" name="parValue#ARGUMENTS.currentRow#" id="parValue#ARGUMENTS.currentRow#" value="0" required="no">
<cfelse>
<cfswitch expression="#ARGUMENTS.patID#">
<!---Textfield Auto Complete.--->
<cfcase value="1">
<cfinput type="text" name="#ARGUMENTS.formType#psaraltValue#ARGUMENTS.currentRow#" id="#ARGUMENTS.formType#psaraltValue#ARGUMENTS.currentRow#" autosuggest="cfc:MCMS.component.app.product.Product.getProductAttributeValueBind({cfautosuggestvalue}, '#ARGUMENTS.paID#', '#application.mcmsDSN#', '1')" size="#ARGUMENTS.fieldSize#" maxlength="255" autosuggestminlength="2" maxresultsdisplayed="16" typeahead="no" autosuggestbinddelay="1" bindonload="yes" showautosuggestloadingicon="false" required="yes" message="Please select a #ARGUMENTS.paName#." onFocus="this.select()" value="#this.pavValue#" validate="regular_expression" pattern="#Iif(ARGUMENTS.paRegex EQ '', DE('^(.(?!,))*$'), DE(ARGUMENTS.paRegex))#" class="yui-ac-input" autocomplete="off" title="#this.pavValue#" style="cursor:pointer;">
<cfinput type="hidden" name="parValue#ARGUMENTS.currentRow#" id="parValue#ARGUMENTS.currentRow#" value="0">
</cfcase>
<!---Textfield.--->
<cfcase value="14">
<cfinput type="text" name="#ARGUMENTS.formType#psaraltValue#ARGUMENTS.currentRow#" id="#ARGUMENTS.formType#psaraltValue#ARGUMENTS.currentRow#" size="#ARGUMENTS.fieldSize#" maxlength="255" required="yes" message="Please select a #ARGUMENTS.paName#." onFocus="this.select()" value="#this.pavValue#" validate="regular_expression" pattern="#Iif(ARGUMENTS.paRegex EQ '', DE('^(.(?!,))*$'), DE(ARGUMENTS.paRegex))#" class="yui-ac-input" title="#this.pavValue#" style="cursor:pointer;">
<cfinput type="hidden" name="parValue#ARGUMENTS.currentRow#" id="parValue#ARGUMENTS.currentRow#" value="0">
</cfcase>
<!---Menu Query.--->
<cfcase value="2">
<!---Queries.--->
<cftry>
<cfsilent>
<cfinvoke
component="MCMS.component.app.product_attribute.ProductAttribute"
method="getMenuQuery"
returnvariable="getMenuQueryRet">
<cfinvokeargument name="paID" value="#ARGUMENTS.paID#"/>
<cfinvokeargument name="excludeID" value="0"/>
<cfinvokeargument name="excludeDefaultValue" value="#ARGUMENTS.paDefaultValue#"/>
<cfinvokeargument name="paComponent" value="#ARGUMENTS.paComponent#"/>
<cfinvokeargument name="paMethod" value="#ARGUMENTS.paMethod#"/>
<cfinvokeargument name="paValueColumn" value="#ARGUMENTS.paValueColumn#"/>
<cfinvokeargument name="paNameColumn" value="#ARGUMENTS.paNameColumn#"/>
<cfinvokeargument name="paArgumentList" value="#ARGUMENTS.paArgumentList#"/>
<cfinvokeargument name="paLOVList" value="#ARGUMENTS.paLOVList#"/>
</cfinvoke>
</cfsilent>
<cfselect name="parValue#ARGUMENTS.currentRow#" id="parValue#ARGUMENTS.currentRow#" required="#ARGUMENTS.paRequired#" message="Please select a #ARGUMENTS.paName#." style="width:100px;">
<cfif ARGUMENTS.paDefaultValue EQ ''>
<option value="N/A" selected>N/A</option>
</cfif>
<cfoutput query="getMenuQueryRet">
<option value="#Iif(ARGUMENTS.paValueColumn EQ '', 'TRIM(Value)', Evaluate(DE('#ARGUMENTS.paValueColumn#')))#" <cfif Iif(ARGUMENTS.paValueColumn EQ '', 'TRIM(Value)', Evaluate(DE('#ARGUMENTS.paValueColumn#'))) EQ ARGUMENTS.paDefaultValue>selected</cfif>>#Iif(ARGUMENTS.paNameColumn EQ '', 'TRIM(Name)', Evaluate(DE('#ARGUMENTS.paNameColumn#')))#</option>
</cfoutput>
</cfselect>
<cfcatch type="any">
Menu query not setup.
</cfcatch>
</cftry>
</cfcase>
<!---Yes/No.--->
<cfcase value="3">
<!---Queries.--->
<cfsilent>
<cfinvoke 
component="MCMS.component.utility.List" 
method="getYesNoList" 
returnvariable="getYesNoListRet">
</cfinvoke>
</cfsilent>
<label style="vertical-align:middle;">
<cfloop query="getYesNoListRet">
<cfinput type="radio" name="parValue#ARGUMENTS.currentRow#" id="parValue#ARGUMENTS.currentRow#" value="#UCASE(getYesNoListRet.Name)#" required="#ARGUMENTS.paRequired#" message="Please choose a #ARGUMENTS.paName#." checked="#Iif(ARGUMENTS.paDefaultValue EQ getYesNoListRet.Name, DE('YES'), DE('NO'))#" style="vertical-align:middle; margin-right:0px;">
<cfoutput>#getYesNoListRet.Name#&nbsp;</cfoutput>
</cfloop>
</label>
</cfcase>
<!---True/False.--->
<cfcase value="4">
<!---Queries.--->
<cfsilent>
<cfinvoke 
component="MCMS.component.utility.List" 
method="getTrueFalseList" 
returnvariable="getTrueFalseListRet">
</cfinvoke>
</cfsilent>
<cfloop query="getTrueFalseListRet">
<cfinput type="radio" name="parValue#ARGUMENTS.currentRow#" id="parValue#ARGUMENTS.currentRow#" value="#UCASE(getTrueFalseListRet.Name)#" required="#ARGUMENTS.paRequired#" message="Please choose a #ARGUMENTS.paName#." checked="#Iif(ARGUMENTS.paDefaultValue EQ getTrueFalseListRet.Name, DE('TRUE'), DE('FALSE'))#">
<cfoutput>#getTrueFalseListRet.Name#</cfoutput>
</cfloop>
</cfcase>
<!---Radio.--->
<cfcase value="5">
<!---If a LOV is not null and no component is used.--->
<cfif ARGUMENTS.paLOVList NEQ '' AND ARGUMENTS.paComponent EQ ''>
<cfloop index="i" list="#ARGUMENTS.paLOVList#">
<cfinput type="radio" name="parValue#ARGUMENTS.currentRow#" id="parValue#ARGUMENTS.currentRow#" value="#i#" required="#ARGUMENTS.paRequired#" message="Please choose a #ARGUMENTS.paName#." checked="#Iif(ARGUMENTS.paDefaultValue EQ i, DE('true'), DE('false'))#">
<cfoutput>#i#</cfoutput>
</cfloop>
<cfelse>
<!---If Component available check other required fields.--->
<cfif ARGUMENTS.paMethod EQ ''>
No method available.
<cfelse>
<!---Queries.--->
<cfsilent>
<cfinvoke 
component="MCMS.component.app.product_attribute.ProductAttribute"
method="getMenuQuery"
returnvariable="getMenuQueryRet">
<cfinvokeargument name="paID" value="#ARGUMENTS.paID#"/>
<cfinvokeargument name="excludeID" value="0"/>
<cfinvokeargument name="excludeDefaultValue" value="#ARGUMENTS.paDefaultValue#"/>
<cfinvokeargument name="paComponent" value="#ARGUMENTS.paComponent#"/>
<cfinvokeargument name="paMethod" value="#ARGUMENTS.paMethod#"/>
<cfinvokeargument name="paValueColumn" value="#ARGUMENTS.paValueColumn#"/>
<cfinvokeargument name="paNameColumn" value="#ARGUMENTS.paNameColumn#"/>
<cfinvokeargument name="paArgumentList" value="#ARGUMENTS.paArgumentList#"/>
<cfinvokeargument name="paLOVList" value="#ARGUMENTS.paLOVList#"/>
</cfinvoke>
</cfsilent>
<cfloop query="getMenuQueryRet">
<cfinput type="radio" name="parValue#ARGUMENTS.currentRow#" id="parValue#ARGUMENTS.currentRow#" value="#Evaluate('getMenuQueryRet.#ARGUMENTS.paValueColumn#')#" required="#ARGUMENTS.paRequired#" message="Please choose a #ARGUMENTS.paName#." checked="#Iif(ARGUMENTS.paDefaultValue EQ Evaluate('getMenuQueryRet.#ARGUMENTS.paValueColumn#'), DE('true'), DE('false'))#">
<cfoutput>#Evaluate('getMenuQueryRet.#ARGUMENTS.paNameColumn#')#</cfoutput>
</cfloop>
</cfif>
</cfif>
</cfcase>
<!---Multiple Choice (Checkbox).--->
<cfcase value="6">
<!---If a LOV is not null and no component is used.--->
<cfif ARGUMENTS.paLOVList NEQ '' AND ARGUMENTS.paComponent EQ ''>
<cfloop index="i" list="#ARGUMENTS.paLOVList#">
<cfinput type="checkbox" name="parValue#ARGUMENTS.currentRow#" id="parValue#ARGUMENTS.currentRow#" value="#i#" required="#ARGUMENTS.paRequired#" message="Please choose a #ARGUMENTS.paName#." checked="#Iif(ARGUMENTS.paDefaultValue EQ i, DE('true'), DE('false'))#">
<cfoutput>#i#</cfoutput>
</cfloop>
<cfelse>
<!---If Component available check other required fields.--->
<cfif ARGUMENTS.paMethod EQ ''>
No method available.
<cfelse>
<!---Queries.--->
<cfsilent>
<cfinvoke 
component="MCMS.component.app.product_attribute.ProductAttribute"
method="getMenuQuery"
returnvariable="getMenuQueryRet">
<cfinvokeargument name="paID" value="#ARGUMENTS.paID#"/>
<cfinvokeargument name="excludeID" value="0"/>
<cfinvokeargument name="excludeDefaultValue" value="#ARGUMENTS.paDefaultValue#"/>
<cfinvokeargument name="paComponent" value="#ARGUMENTS.paComponent#"/>
<cfinvokeargument name="paMethod" value="#ARGUMENTS.paMethod#"/>
<cfinvokeargument name="paValueColumn" value="#ARGUMENTS.paValueColumn#"/>
<cfinvokeargument name="paNameColumn" value="#ARGUMENTS.paNameColumn#"/>
<cfinvokeargument name="paArgumentList" value="#ARGUMENTS.paArgumentList#"/>
<cfinvokeargument name="paLOVList" value="#ARGUMENTS.paLOVList#"/>
</cfinvoke>
</cfsilent>
<cfloop query="getMenuQueryRet">
<cfinput type="checkbox" name="parValue#ARGUMENTS.currentRow#" id="parValue#ARGUMENTS.currentRow#" value="#Evaluate('getMenuQueryRet.#ARGUMENTS.paValueColumn#')#" required="#ARGUMENTS.paRequired#" message="Please choose a #ARGUMENTS.paName#." checked="#Iif(ARGUMENTS.paDefaultValue EQ Evaluate('getMenuQueryRet.#ARGUMENTS.paValueColumn#'), DE('true'), DE('false'))#">
<cfoutput>#Evaluate('getMenuQueryRet.#ARGUMENTS.paNameColumn#')#</cfoutput>
</cfloop>
</cfif>
</cfif>
</cfcase>
<!---Menu (Numeric).--->
<cfcase value="7">
<!---Queries.--->
<cfsilent>
<cfinvoke 
component="MCMS.component.utility.List" 
method="getNumericList" 
returnvariable="getNumericListRet">
<cfinvokeargument name="totalCount" value="#ARGUMENTS.paRangeEnd#">
<cfinvokeargument name="startCount" value="#ARGUMENTS.paRangeStart#">
</cfinvoke>
</cfsilent>
<cftry>
<cfselect name="parValue#ARGUMENTS.currentRow#" id="parValue#ARGUMENTS.currentRow#" required="#ARGUMENTS.paRequired#" message="Please select a #ARGUMENTS.paName#.">
<cfif ARGUMENTS.paDefaultValue EQ ''>
<option value="N/A" selected>N/A</option>
</cfif>
<cfoutput query="getNumericListRet">
<option value="#Iif(ARGUMENTS.paValueColumn EQ '', 'TRIM(Value)', Evaluate(DE('#ARGUMENTS.paValueColumn#')))#" <cfif Iif(ARGUMENTS.paValueColumn EQ '', 'TRIM(Value)', Evaluate(DE('#ARGUMENTS.paValueColumn#'))) EQ ARGUMENTS.paDefaultValue>selected</cfif>>#Iif(ARGUMENTS.paNameColumn EQ '', 'TRIM(Name)', Evaluate(DE('#ARGUMENTS.paNameColumn#')))#</option>
</cfoutput>
</cfselect>
<cfcatch type="any">
Menu numeric not setup.
</cfcatch>
</cftry>
</cfcase>
<!---Menu (Numeric Decimal).--->
<cfcase value="8">
<cftry>
<!---Queries.--->
<cfsilent>
<cfinvoke 
component="MCMS.component.utility.List" 
method="getNumericList" 
returnvariable="getNumericListRet">
<cfinvokeargument name="totalCount" value="#ARGUMENTS.paRangeEnd#">
<cfinvokeargument name="startCount" value="#ARGUMENTS.paRangeStart#">
</cfinvoke>
<cfinvoke 
component="MCMS.component.utility.List" 
method="getFloatList" 
returnvariable="getFloatListRet">
<cfinvokeargument name="totalCount" value="100">
<cfinvokeargument name="startCount" value="1">
</cfinvoke>
</cfsilent>
<cfselect name="parValue#ARGUMENTS.currentRow#" id="parValue#ARGUMENTS.currentRow#" required="#ARGUMENTS.paRequired#" message="Please select a #ARGUMENTS.paName#.">
<cfif ARGUMENTS.paDefaultValue EQ ''>
<option value="N/A" selected>N/A</option>
</cfif>
<cfoutput query="#Iif(i MOD 2 EQ 0, DE('getFloatListRet'), DE('getNumericListRet'))#">
<option value="#Iif(ARGUMENTS.paValueColumn EQ '', 'TRIM(Value)', Evaluate(DE('#ARGUMENTS.paValueColumn#')))#" <cfif Iif(ARGUMENTS.paValueColumn EQ '', 'TRIM(Value)', Evaluate(DE('#ARGUMENTS.paValueColumn#'))) EQ ARGUMENTS.paDefaultValue>selected</cfif>>#Iif(ARGUMENTS.paNameColumn EQ '', 'TRIM(Name)', Evaluate(DE('#ARGUMENTS.paNameColumn#')))#</option>
</cfoutput>
</cfselect>
<cfcatch type="any">
Menu numeric not setup.
</cfcatch>
</cftry>
</cfcase>
<!---Yes/No.--->
<cfcase value="13">
<cfinput type="radio" name="parValue#ARGUMENTS.currentRow#" id="parValue#ARGUMENTS.currentRow#" value="TRUE" required="#ARGUMENTS.paRequired#" message="Please choose a #ARGUMENTS.paName#." checked="#Iif(ARGUMENTS.paDefaultValue EQ 'TRUE', DE('YES'), DE('NO'))#">Yes
<cfinput type="radio" name="parValue#ARGUMENTS.currentRow#" id="parValue#ARGUMENTS.currentRow#" value="FALSE" required="#ARGUMENTS.paRequired#" message="Please choose a #ARGUMENTS.paName#." checked="#Iif(ARGUMENTS.paDefaultValue EQ 'FALSE', DE('YES'), DE('NO'))#">No
</cfcase>
<cfdefaultcase>
None defined.
</cfdefaultcase>
</cfswitch>
<!---Display '*' if required--->
<cfif ARGUMENTS.paRequired EQ 1>
<span id="required">*</span>
</cfif>
</cfif>
<cfoutput>
<cfif ARGUMENTS.formType EQ 'update' AND ARGUMENTS.patFieldCount GT 1 AND (ARGUMENTS.patID EQ 2 OR ARGUMENTS.patID EQ 7 OR ARGUMENTS.patID EQ 8)>
<p class="small"><b>Current Value:</b> <cfif ARGUMENTS.paDefaultValue EQ ''>None!<cfelse>#ARGUMENTS.paDefaultValue#</cfif></p>
</cfif>
<!---Required hidden fields.--->
<input type="hidden" size="10" name="paID#ARGUMENTS.currentRow#" id="paID#ARGUMENTS.currentRow#" value="#ARGUMENTS.paID#">
<cfif ARGUMENTS.patID EQ 1 OR ARGUMENTS.patID EQ 14 OR (ListContains(application.complianceAuthorizationAttributeList, ARGUMENTS.paID) AND ARGUMENTS.appSource EQ 'product')>
<cfelse>
<input type="hidden" size="10" name="#ARGUMENTS.formType#psaraltValue#ARGUMENTS.currentRow#" id="#ARGUMENTS.formType#psaraltValue#ARGUMENTS.currentRow#" value="x">
</cfif>
<input type="hidden" size="10" name="paRequired#ARGUMENTS.currentRow#" id="paRequired#ARGUMENTS.currentRow#" value="#ARGUMENTS.paRequired#">
<input type="hidden" size="10" name="paMessage#ARGUMENTS.currentRow#" id="paMessage#ARGUMENTS.currentRow#" value="Please include a value/option for #ARGUMENTS.paName#.">
<input type="hidden" size="10" name="paRegex#ARGUMENTS.currentRow#" id="paRegex#ARGUMENTS.currentRow#" value="#Iif(ARGUMENTS.paRegex EQ '', DE('^(.(?!,))*$'), DE(ARGUMENTS.paRegex))#">
</cfoutput>
</cfsavecontent>
<!---DO NOT CHANGE THE 'cfform' CODE BELOW!--->
<!--</cfform>-->
<cfcatch type="any">
<cfset result.message = "There was an error inserting the record.">
<cfif url.mcmsDebug EQ true>
<cfdump var="#CFCATCH#">
</cfif>
</cfcatch>
</cftry>
<cfreturn result>
</cffunction>

<cffunction name="getMenuQuery" access="public" returntype="query" hint="Get product attribute values.">
<cfargument name="paID" type="numeric" required="yes" default="0">
<cfargument name="excludeID" type="numeric" required="yes" default="0">
<cfargument name="excludeDefaultValue" type="string" required="yes" default="">
<cfargument name="paComponent" type="string" required="yes" default="">
<cfargument name="paMethod" type="string" required="yes" default="">
<cfargument name="paValueColumn" type="string" required="yes" default="">
<cfargument name="paNameColumn" type="string" required="yes" default="">
<cfargument name="paArgumentList" type="string" required="yes" default="">
<cfargument name="paLOVList" type="string" required="yes" default="">
<cfargument name="paStatus" type="string" required="yes" default="1,3">
<cfset var result = "" >
<cfset var getData = "" >
<cftry>
<!---Check for Component to trump LOV.--->
<cfif ARGUMENTS.paComponent NEQ '' AND ARGUMENTS.paMethod NEQ ''>
<cfinvoke 
component="cfc.#ARGUMENTS.paComponent#" 
method="#ARGUMENTS.paMethod#" 
returnvariable="getData">
<cfinvokeargument name="paID" value="#ARGUMENTS.paID#">
</cfinvoke>
<cfset sql = 'SELECT #ARGUMENTS.paValueColumn#, #ARGUMENTS.paNameColumn# FROM getData ORDER BY #ARGUMENTS.paNameColumn#'>
<cfquery name="result" dbtype="query">
#PreserveSingleQuotes(sql)#
</cfquery>
<!---TO DO: Argument List Upgrade. CF 05/30/2013--->
<cfelseif ARGUMENTS.paLOVList NEQ ''>
<!---Get LOV list from attribute.--->
<cfinvoke 
component="MCMS.component.app.product_attribute.ProductAttribute"
method="getLOV"
returnvariable="result">
<cfinvokeargument name="listValue" value="#ARGUMENTS.paLOVList#"/>
</cfinvoke>
</cfif>
<!---Catch any errors.--->
<cfcatch type="any">
<cfset result = StructNew()>
<cfset result.message = "There was an error with the query.">
<cfif url.mcmsDebug EQ true>
<cfdump var="#CFCATCH#">
</cfif>
</cfcatch>
</cftry>
<cfreturn result>
</cffunction>

<cffunction name="getMultiple" access="remote"> 
<cfargument name="a">  
<cfargument name="b">  
<cfargument name="c">  
<cfreturn "#arguments.a##arguments.b##arguments.c#"> 
</cffunction> 

<cffunction name="getLOV" access="public" returntype="query" hint="List of values.">
<cfargument name="listValue" type="string" required="yes" default="">
<cfset var myQuery = "">
<cftry>
<cfset this.listValueLen = ListLen(ARGUMENTS.listValue)>
<cfset loopcount = 0>
<cfset myQueryList = QueryNew("Name, Value", "varchar, varchar")>
<cfset totalCount = this.listValueLen>
<cfset newRow = QueryAddRow(myQueryList, totalCount)>
<cfloop list="#TRIM(ARGUMENTS.listValue)#" index="i">
<cfset loopcount = loopcount+1>
<cfset temp = QuerySetCell(myQueryList, "Name", i, loopcount)>
<cfset temp = QuerySetCell(myQueryList, "Value", i, loopcount)>
</cfloop>
<cfquery name="myQuery" dbtype="query">
SELECT * FROM myQueryList ORDER BY Name
</cfquery>
<cfcatch type="any">
<cfset myQuery = StructNew()>
<cfset myQuery.message = "There was an error with the query.">
<cfif url.mcmsDebug EQ true>
<cfdump var="#CFCATCH#">
</cfif>
</cfcatch>
</cftry>
<cfreturn myQuery>
</cffunction>

<cffunction name="getProductAttributeValueBind" access="remote" returntype="string" output="yes">
<cfargument name="keywords" type="string" required="yes" default="">
<cfargument name="paID" type="string" required="yes" default="0">
<cfargument name="dsn" type="string" required="yes" default="swweb">
<cfargument name="pavStatus" type="string" required="yes" default="1">
<cfargument name="orderBy" type="string" required="yes" default="pavValue">
<cfset var rsBind = "" >
<cfquery name="rsBind" datasource="#ARGUMENTS.dsn#">
SELECT pavValue FROM v_product_attribute_value WHERE 0=0
AND UPPER(pavValue) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">
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

<cffunction name="setProductAttributeExtType" access="public" returntype="any" hint="A special method to control product attribute extension types for forms.">
<cfargument name="paeID" type="numeric" required="yes">
<cfargument name="paeName" type="string" required="yes" default="Default">
<cfargument name="paerValue" type="string" required="yes">
<cfargument name="paetID" type="numeric" required="yes">
<cfargument name="paeRequired" type="numeric" required="yes" default="0">
<cfargument name="currentRow" type="numeric" required="yes" default="0">
<cfset result.message = "You have successfully updated the record(s).">
<cftry>
<!---Based on type control the values for menus etc..--->
<cfsilent>
<!---Set default value variables.--->
<cfset defaultName = ''>
<cfset defaultValue = ''>
<cfswitch expression="#ARGUMENTS.paeID#">
<!---Product Template.--->
<cfcase value="103">
<cfinvoke 
component="MCMS.component.app.product.Product" 
method="getProductTemplate" 
returnvariable="result">
<cfinvokeargument name="ptempStatus" value="1,2,3">
</cfinvoke>
<!---Do a query of query to manage menu ID/Value pairs.--->
<cfquery name="getQueryRet" dbtype="query">
SELECT ID, ptempName AS Name FROM result
</cfquery>
</cfcase>
<!---Special Handling.--->
<cfcase value="114">
<cfset getQueryRet = QueryNew("Name, ID", "varchar, varchar")>
<cfset totalCount = 1>
<cfset newRow = QueryAddRow(getQueryRet, totalCount)>
<cfset temp = QuerySetCell(getQueryRet, "Name", "None", 1)>
<cfset temp = QuerySetCell(getQueryRet, "ID", "", 1)>
<cfset defaultName = 'Yes'>
<cfset defaultValue = ''>
</cfcase>
<!---Age Restriction.--->
<cfcase value="105">
<cfset getQueryRet = QueryNew("Name, ID", "varchar, varchar")>
<cfset totalCount = 1>
<cfset newRow = QueryAddRow(getQueryRet, totalCount)>
<cfset temp = QuerySetCell(getQueryRet, "Name", "18", 1)>
<cfset temp = QuerySetCell(getQueryRet, "ID", "18", 1)>
<cfset defaultName = 'No'>
<cfset defaultValue = ''>
</cfcase>
<!---Shipping Type.--->
<cfcase value="113">
<cfset getQueryRet = QueryNew("Name, ID", "varchar, varchar")>
<cfset totalCount = 8>
<cfset newRow = QueryAddRow(getQueryRet, totalCount)>
<cfset temp = QuerySetCell(getQueryRet, "Name", "Ammunition (CSA ORM-D)", 1)>
<cfset temp = QuerySetCell(getQueryRet, "ID", "CSA ORM-D", 1)>
<cfset temp = QuerySetCell(getQueryRet, "Name", "Consumer Commodities (CC ORM-D)", 2)>
<cfset temp = QuerySetCell(getQueryRet, "ID", "CC ORM-D", 2)>
<cfset temp = QuerySetCell(getQueryRet, "Name", "Extra Oversized (EOS)", 3)>
<cfset temp = QuerySetCell(getQueryRet, "ID", "EOS", 3)>
<cfset temp = QuerySetCell(getQueryRet, "Name", "Haz-Mat (HM)", 4)>
<cfset temp = QuerySetCell(getQueryRet, "ID", "HM", 4)>
<cfset temp = QuerySetCell(getQueryRet, "Name", "Oversized (OS)", 5)>
<cfset temp = QuerySetCell(getQueryRet, "ID", "OS", 5)>
<cfset temp = QuerySetCell(getQueryRet, "Name", "Kayak/Canoe (KC)", 6)>
<cfset temp = QuerySetCell(getQueryRet, "ID", "KC", 6)>
<cfset temp = QuerySetCell(getQueryRet, "Name", "Oversized Ground Only (OSGO)", 7)>
<cfset temp = QuerySetCell(getQueryRet, "ID", "OSGO", 7)>
<cfset temp = QuerySetCell(getQueryRet, "Name", "Extra Oversized Ground Only (EOSGO)", 8)>
<cfset temp = QuerySetCell(getQueryRet, "ID", "EOSGO", 8)>
</cfcase>
<!---Gun Type.--->
<cfcase value="109">
<cfset getQueryRet = QueryNew("Name, ID", "varchar, varchar")>
<cfset totalCount = 4>
<cfset newRow = QueryAddRow(getQueryRet, totalCount)>
<cfset temp = QuerySetCell(getQueryRet, "Name", "Hand Guns", 1)>
<cfset temp = QuerySetCell(getQueryRet, "ID", "Hand Guns", 1)>
<cfset temp = QuerySetCell(getQueryRet, "Name", "Shot Guns", 2)>
<cfset temp = QuerySetCell(getQueryRet, "ID", "Shot Guns", 2)>
<cfset temp = QuerySetCell(getQueryRet, "Name", "Rifles", 3)>
<cfset temp = QuerySetCell(getQueryRet, "ID", "Rifles", 3)>
<cfset temp = QuerySetCell(getQueryRet, "Name", "Suppressors", 4)>
<cfset temp = QuerySetCell(getQueryRet, "ID", "Suppressors", 4)>
</cfcase>
<cfdefaultcase>
<cfif ARGUMENTS.paetID EQ 2>
<cfset getQueryRet = QueryNew("Name, ID", "varchar, varchar")>
<cfset totalCount = 2>
<cfset newRow = QueryAddRow(getQueryRet, totalCount)>
<cfset temp = QuerySetCell(getQueryRet, "Name", "True", 1)>
<cfset temp = QuerySetCell(getQueryRet, "ID", "true", 1)>
<cfset temp = QuerySetCell(getQueryRet, "Name", "False", 2)>
<cfset temp = QuerySetCell(getQueryRet, "ID", "false", 2)>
</cfif>
</cfdefaultcase>
</cfswitch>
</cfsilent>
<cfsavecontent variable="result">
<cfswitch expression="#ARGUMENTS.paetID#">
<cfcase value="1">
<cfinvoke 
component="MCMS.component.utility.List" 
method="getYesNoList" 
returnvariable="getYesNoListRet">
</cfinvoke>
<select name="paerValue<cfoutput>#ARGUMENTS.currentRow#</cfoutput>" id="paerValue<cfoutput>#ARGUMENTS.currentRow#</cfoutput>">
<cfoutput query="getYesNoListRet">
<option value="#Name#" <cfif Name EQ ARGUMENTS.paerValue>selected</cfif>>#Name#</option>
</cfoutput>
</select>
</cfcase>
<cfcase value="2">
<cfinvoke 
component="MCMS.component.utility.List" 
method="getTrueFalseList" 
returnvariable="getTrueFalseListRet">
</cfinvoke>
<select name="paerValue<cfoutput>#ARGUMENTS.currentRow#</cfoutput>" id="paerValue<cfoutput>#ARGUMENTS.currentRow#</cfoutput>">
<cfoutput query="getTrueFalseListRet">
<option value="#Name#" <cfif Name EQ ARGUMENTS.paerValue>selected</cfif>>#Name#</option>
</cfoutput>
</select>
</cfcase>
<cfcase value="3">
<cfoutput>
<input type="text" size="64" name="paerValue#ARGUMENTS.currentRow#" id="paerValue#ARGUMENTS.currentRow#" value="#ARGUMENTS.paerValue#">
</cfoutput>
</cfcase>
<cfcase value="4">
<cfoutput>
<textarea id="paerValue#ARGUMENTS.currentRow#" name="paerValue#ARGUMENTS.currentRow#" rows="3" cols="80">#ARGUMENTS.paerValue#</textarea>
</cfoutput>
</cfcase>
<cfcase value="5">
<select name="paerValue<cfoutput>#ARGUMENTS.currentRow#</cfoutput>" id="paerValue<cfoutput>#ARGUMENTS.currentRow#</cfoutput>">
<option value="">None</option>
<!---Include any special rule for default values.--->
<cfif defaultValue NEQ ''>
<cfoutput><option value="#defaultValue#" <cfif defaultValue EQ ARGUMENTS.paerValue>selected</cfif>>#defaultName#</option></cfoutput>
</cfif>
<cfoutput query="getQueryRet">
<option value="#ID#" <cfif ID EQ ARGUMENTS.paerValue>selected</cfif>>#Name#</option>
</cfoutput>
</select>
</cfcase>
</cfswitch>
<cfif ARGUMENTS.paeRequired EQ 1>
<span id="required">*</span>
</cfif>
<cfoutput>
<input type="hidden" name="paeID#ARGUMENTS.currentRow#" id="paeID#ARGUMENTS.currentRow#" value="#ARGUMENTS.paeID#">
<input type="hidden" name="paeRequired#ARGUMENTS.currentRow#" id="paeRequired#ARGUMENTS.currentRow#" value="#ARGUMENTS.paeRequired#">
<input type="hidden" name="paeMessage#ARGUMENTS.currentRow#" id="paeMessage#ARGUMENTS.currentRow#" value="Please include a value/option for #ARGUMENTS.paeName#.">
</cfoutput>
</cfsavecontent>
<cfcatch type="any">
<cfset result.message = "There was an error inserting the record.">
<cfif url.mcmsDebug EQ true>
<cfdump var="#CFCATCH#">
</cfif>
</cfcatch>
</cftry>
<cfreturn result>
</cffunction>

<cffunction name="insertProductAttributeSecondaryCategoryRel" access="public" returntype="struct">
<cfargument name="paID" type="numeric" required="yes">
<cfargument name="scatID" type="string" required="yes">
<cfargument name="pascrStatus" type="numeric" required="yes" default="1">
<cfset result.message = "You have successfully inserted the record.">
<cftry>
<cftransaction>
<cfquery datasource="#application.mcmsDSN#">
INSERT INTO tbl_product_attr_sec_cat_rel (paID,scatID,pascrStatus) VALUES
(
<cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.paID#">,
<cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.scatID#">,
<cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.pascrStatus#">
)
</cfquery>
</cftransaction>
<cfcatch type="any">
<cfset result.message = "There was an error inserting the record.">
<cfif url.mcmsDebug EQ true>
<cfdump var="#CFCATCH#">
</cfif>
</cfcatch>
</cftry>
<cfreturn result>
</cffunction>

<cffunction name="insertProductAttributeLineCategoryRel" access="public" returntype="struct">
<cfargument name="paID" type="numeric" required="yes">
<cfargument name="lcatID" type="string" required="yes">
<cfargument name="palcrStatus" type="numeric" required="yes" default="1">
<cfset result.message = "You have successfully inserted the record.">
<cftry>
<cftransaction>
<cfquery datasource="#application.mcmsDSN#">
INSERT INTO tbl_product_attr_line_cat_rel (paID,lcatID,palcrStatus) VALUES
(
<cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.paID#">,
<cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.lcatID#">,
<cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.palcrStatus#">
)
</cfquery>
</cftransaction>
<cfcatch type="any">
<cfset result.message = "There was an error inserting the record.">
<cfif url.mcmsDebug EQ true>
<cfdump var="#CFCATCH#">
</cfif>
</cfcatch>
</cftry>
<cfreturn result>
</cffunction>

<cffunction name="insertProductAttributeSecondaryLineCategoryRel" access="public" returntype="struct">
<cfargument name="paID" type="numeric" required="yes">
<cfargument name="slcatID" type="string" required="yes">
<cfargument name="paslcrStatus" type="numeric" required="yes" default="1">
<cfset result.message = "You have successfully inserted the record.">
<cftry>
<cftransaction>
<cfquery datasource="#application.mcmsDSN#">
INSERT INTO tbl_product_attr_sec_l_cat_rel (paID,slcatID,paslcrStatus) VALUES
(
<cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.paID#">,
<cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.slcatID#">,
<cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.paslcrStatus#">
)
</cfquery>
</cftransaction>
<cfcatch type="any">
<cfset result.message = "There was an error inserting the record.">
<cfif url.mcmsDebug EQ true>
<cfdump var="#CFCATCH#">
</cfif>
</cfcatch>
</cftry>
<cfreturn result>
</cffunction>

<cffunction name="updateProductAttributeCategoryRel" access="public" returntype="struct">
<cfargument name="paID" type="numeric" required="yes">
<cfargument name="scatID" type="string" required="yes">
<cfargument name="lcatID" type="string" required="yes">
<cfargument name="slcatID" type="string" required="yes">
<cfset result.message = "You have successfully updated the record.">
<cftry>
<!---First delete any relationships.--->
<cfinvoke 
component="MCMS.component.app.product_attribute.ProductAttribute"
method="deleteProductAttributeSecondaryCategoryRel">
<cfinvokeargument name="paID" value="#ARGUMENTS.paID#"/>
</cfinvoke>
<cfinvoke 
component="MCMS.component.app.product_attribute.ProductAttribute"
method="deleteProductAttributeLineCategoryRel">
<cfinvokeargument name="paID" value="#ARGUMENTS.paID#"/>
</cfinvoke>
<cfinvoke 
component="MCMS.component.app.product_attribute.ProductAttribute"
method="deleteProductAttributeSecondaryLineCategoryRel">
<cfinvokeargument name="paID" value="#ARGUMENTS.paID#"/>
</cfinvoke>
<!---Secondly insert any relationships.--->
<cfloop index="scatID" list="#form.scatID#">
<cfif scatID NEQ 0>
<cfinvoke 
component="MCMS.component.app.product_attribute.ProductAttribute" 
method="insertProductAttributeSecondaryCategoryRel">
<cfinvokeargument name="paID" value="#ARGUMENTS.paID#">
<cfinvokeargument name="scatID" value="#scatID#">                 
</cfinvoke>
</cfif>
</cfloop>
<cfloop index="lcatID" list="#form.lcatID#">
<cfif lcatID NEQ 0>
<cfinvoke 
component="MCMS.component.app.product_attribute.ProductAttribute" 
method="insertProductAttributeLineCategoryRel">
<cfinvokeargument name="paID" value="#ARGUMENTS.paID#">
<cfinvokeargument name="lcatID" value="#lcatID#">                 
</cfinvoke>
</cfif>
</cfloop>
<cfloop index="slcatID" list="#form.slcatID#">
<cfif slcatID NEQ 0>
<cfinvoke 
component="MCMS.component.app.product_attribute.ProductAttribute" 
method="insertProductAttributeSecondaryLineCategoryRel">
<cfinvokeargument name="paID" value="#ARGUMENTS.paID#">
<cfinvokeargument name="slcatID" value="#slcatID#">                  
</cfinvoke>
</cfif>
</cfloop>
<cfcatch type="any">
<cfset result.message = "There was an error updating the record.">
<cfif url.mcmsDebug EQ true>
<cfdump var="#CFCATCH#">
</cfif>
</cfcatch>
</cftry>
<cfreturn result>
</cffunction>

<cffunction name="deleteProductAttributeSecondaryCategoryRel" access="public" returntype="struct">
<cfargument name="ID" type="string" required="yes" default="0">
<cfargument name="paID" type="string" required="yes" default="0">
<cfset result.message = "You have successfully deleted the record(s).">
<cftry>
<cftransaction>
<cfquery datasource="#application.mcmsDSN#">
DELETE FROM tbl_product_attr_sec_cat_rel
WHERE ID IN (<cfqueryparam cfsqltype="cf_sql_integer" list="yes" value="#ARGUMENTS.ID#">)
OR paID IN (<cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.paID#">)
</cfquery>
</cftransaction>
<cfcatch type="any">
<cfset result.message = "There was an error deleting the record(s).">
<cfif url.mcmsDebug EQ true>
<cfdump var="#CFCATCH#">
</cfif>
</cfcatch>
</cftry>
<cfreturn result>
</cffunction>

<cffunction name="deleteProductAttributeLineCategoryRel" access="public" returntype="struct">
<cfargument name="ID" type="string" required="yes" default="0">
<cfargument name="paID" type="string" required="yes" default="0">
<cfset result.message = "You have successfully deleted the record(s).">
<cftry>
<cftransaction>
<cfquery datasource="#application.mcmsDSN#">
DELETE FROM tbl_product_attr_line_cat_rel
WHERE ID IN (<cfqueryparam cfsqltype="cf_sql_integer" list="yes" value="#ARGUMENTS.ID#">)
OR paID IN (<cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.paID#">)
</cfquery>
</cftransaction>
<cfcatch type="any">
<cfset result.message = "There was an error deleting the record(s).">
<cfif url.mcmsDebug EQ true>
<cfdump var="#CFCATCH#">
</cfif>
</cfcatch>
</cftry>
<cfreturn result>
</cffunction>

<cffunction name="deleteProductAttributeSecondaryLineCategoryRel" access="public" returntype="struct">
<cfargument name="ID" type="string" required="yes" default="0">
<cfargument name="paID" type="string" required="yes" default="0">
<cfset result.message = "You have successfully deleted the record(s).">
<cftry>
<cftransaction>
<cfquery datasource="#application.mcmsDSN#">
DELETE FROM tbl_product_attr_sec_l_cat_rel
WHERE ID IN (<cfqueryparam cfsqltype="cf_sql_integer" list="yes" value="#ARGUMENTS.ID#">)
OR paID IN (<cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.paID#">)
</cfquery>
</cftransaction>
<cfcatch type="any">
<cfset result.message = "There was an error deleting the record(s).">
<cfif url.mcmsDebug EQ true>
<cfdump var="#CFCATCH#">
</cfif>
</cfcatch>
</cftry>
<cfreturn result>
</cffunction>
</cfcomponent>