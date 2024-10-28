<cfcomponent>
    <cffunction name="getSign" access="public" returntype="query" hint="Get Sign data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="ID" type="numeric" required="yes" default="0">
    <cfargument name="excludeID" type="string" required="yes" default="0">
    <cfargument name="sbsSKU" type="string" required="yes" default="0">
    <cfargument name="sbsName" type="string" required="yes" default="">
    <cfargument name="deptNo" type="string" required="yes" default="0">
    <cfargument name="sbstID" type="numeric" required="yes" default="0">
    <cfargument name="sbsStatus" type="string" required="yes" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="sbsSKU">
    <cfset var rsSign = "" >
    <cftry>
    <cfquery name="rsSign" datasource="#application.mcmsDSN#">
    SELECT * FROM v_sb_sign WHERE 0=0
    <cfif ARGUMENTS.ID NEQ 0>
    AND ID = <cfqueryparam value="#ARGUMENTS.ID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.excludeID NEQ 0>
    AND ID NOT IN (<cfqueryparam value="#ARGUMENTS.excludeID#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (sbsSKU LIKE <cfqueryparam value="%#ARGUMENTS.keywords#%" cfsqltype="cf_sql_integer">)
    </cfif>
    <cfif ARGUMENTS.sbsSKU NEQ 0>
    AND sbsSKU = <cfqueryparam value="#ARGUMENTS.sbsSKU#" cfsqltype="cf_sql_varchar">
    </cfif>
    <cfif ARGUMENTS.sbsName NEQ ''>
    AND sbsName = <cfqueryparam value="#ARGUMENTS.sbsName#" cfsqltype="cf_sql_varchar">
    </cfif>
    <cfif ARGUMENTS.deptNo NEQ 0>
    AND deptNo IN (<cfqueryparam value="#ARGUMENTS.deptNo#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    <cfif ARGUMENTS.sbstID NEQ 0>
    AND sbstID = <cfqueryparam value="#ARGUMENTS.sbstID#" cfsqltype="cf_sql_integer">
    </cfif>
    AND sbsStatus IN (<cfqueryparam value="#ARGUMENTS.sbsStatus#" list="yes" cfsqltype="cf_sql_integer">)
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsSign = StructNew()>
    <cfset rsSign.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsSign>
    </cffunction>
    
    <cffunction name="getSignQRCode" access="public" returntype="query" hint="Get Sign QR Code data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="ID" type="numeric" required="yes" default="0">
    <cfargument name="excludeID" type="numeric" required="yes" default="0">
    <cfargument name="sbsID" type="string" required="yes" default="0">
    <cfargument name="sbsqrcURL" type="string" required="yes" default="">
    <cfargument name="sbsStatus" type="string" required="yes" default="1,3">
    <cfargument name="sbsqrcStatus" type="string" required="yes" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="ID">
    <cfset var rsSignQRCode = "" >
    <cftry>
    <cfquery name="rsSignQRCode" datasource="#application.mcmsDSN#">
    SELECT * FROM v_sb_sign_qr_code WHERE 0=0
    <cfif ARGUMENTS.ID NEQ 0>
    AND ID = <cfqueryparam value="#ARGUMENTS.ID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.excludeID NEQ 0>
    AND ID <> <cfqueryparam value="#ARGUMENTS.excludeID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(sbsName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">)
    </cfif>
    <cfif ARGUMENTS.sbsID NEQ 0>
    AND sbsID IN (<cfqueryparam value="#ARGUMENTS.sbsID#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    <cfif ARGUMENTS.sbsqrcURL NEQ ''>
    AND sbsqrcURL = <cfqueryparam value="#ARGUMENTS.sbsqrcURL#" cfsqltype="cf_sql_varchar">
    </cfif>
    AND sbsStatus IN (<cfqueryparam value="#ARGUMENTS.sbsStatus#" list="yes" cfsqltype="cf_sql_integer">)
    AND sbsqrcStatus IN (<cfqueryparam value="#ARGUMENTS.sbsqrcStatus#" list="yes" cfsqltype="cf_sql_integer">)
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsSignQRCode = StructNew()>
    <cfset rsSignQRCode.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsSignQRCode>
    </cffunction>
 
    <cffunction name="getSignType" access="public" returntype="query" hint="Get Sign Type data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="ID" type="numeric" required="yes" default="0">
    <cfargument name="excludeID" type="numeric" required="yes" default="0">
    <cfargument name="sbstName" type="string" required="yes" default="">
    <cfargument name="sbstStatus" type="string" required="yes" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="sbstSort, sbstName">
    <cfset var rsSignType = "" >
    <cftry>
    <cfquery name="rsSignType" datasource="#application.mcmsDSN#">
    SELECT * FROM v_sb_sign_type WHERE 0=0
    <cfif ARGUMENTS.ID NEQ 0>
    AND ID = <cfqueryparam value="#ARGUMENTS.ID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.excludeID NEQ 0>
    AND ID <> <cfqueryparam value="#ARGUMENTS.excludeID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND UPPER(sbstName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">
    </cfif>
    <cfif ARGUMENTS.sbstName NEQ ''>
    AND sbstName = <cfqueryparam value="#ARGUMENTS.sbstName#" cfsqltype="cf_sql_varchar">
    </cfif>
    AND sbstStatus IN (<cfqueryparam value="#ARGUMENTS.sbstStatus#" list="yes" cfsqltype="cf_sql_integer">)
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsSignType = StructNew()>
    <cfset rsSignType.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsSignType>
    </cffunction>
    
    <cffunction name="getSignSkuRel" access="public" returntype="query" hint="Get Sign Sku Rel. data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="ID" type="numeric" required="yes" default="0">
    <cfargument name="excludeID" type="numeric" required="yes" default="0">
    <cfargument name="sbsID" type="numeric" required="yes" default="0">
    <cfargument name="sbsIDRel" type="numeric" required="yes" default="0">
    <cfargument name="sbsSKU" type="string" required="yes" default="">
    <cfargument name="deptNo" type="numeric" required="yes" default="0">
    <cfargument name="sbssrStatus" type="string" required="yes" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="deptNo, sbsSKU">
    <cfset var rsSignSkuRel = "" >
    <cftry>
    <cfquery name="rsSignSkuRel" datasource="#application.mcmsDSN#">
    SELECT * FROM v_sb_sign_sku_rel WHERE 0=0
    <cfif ARGUMENTS.ID NEQ 0>
    AND ID = <cfqueryparam value="#ARGUMENTS.ID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.excludeID NEQ 0>
    AND ID <> <cfqueryparam value="#ARGUMENTS.excludeID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.sbsID NEQ 0>
    AND sbsID = <cfqueryparam value="#ARGUMENTS.sbsID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.sbsIDRel NEQ 0>
    AND sbsIDRel = <cfqueryparam value="#ARGUMENTS.sbsIDRel#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (sbsSKU LIKE <cfqueryparam value="%#ARGUMENTS.keywords#%" cfsqltype="cf_sql_integer">)
    </cfif>
    <cfif ARGUMENTS.sbsSKU NEQ ''>
    AND sbsSKU = <cfqueryparam value="#ARGUMENTS.sbsSKU#" cfsqltype="cf_sql_varchar">
    </cfif>
    <cfif ARGUMENTS.deptNo NEQ 0>
    AND deptNo = <cfqueryparam value="#ARGUMENTS.deptNo#" cfsqltype="cf_sql_integer">
    </cfif>
    AND sbssrStatus IN (<cfqueryparam value="#ARGUMENTS.sbssrStatus#" list="yes" cfsqltype="cf_sql_integer">)
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsSignSkuRel = StructNew()>
    <cfset rsSignSkuRel.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsSignSkuRel>
    </cffunction>
    
    <cffunction name="getSignTemplate" access="public" returntype="query" hint="Get Sign Template data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="ID" type="numeric" required="yes" default="0">
    <cfargument name="excludeID" type="numeric" required="yes" default="0">
    <cfargument name="sbstplName" type="string" required="yes" default="">
    <cfargument name="sbstplStatus" type="string" required="yes" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="ID, sbstplName">
    <cfset var rsSignTemplate = "" >
    <cftry>
    <cfquery name="rsSignTemplate" datasource="#application.mcmsDSN#">
    SELECT * FROM v_sb_sign_template WHERE 0=0
    <cfif ARGUMENTS.ID NEQ 0>
    AND ID = <cfqueryparam value="#ARGUMENTS.ID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.excludeID NEQ 0>
    AND ID <> <cfqueryparam value="#ARGUMENTS.excludeID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(sbstplName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(sbstplDescription) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">)
    </cfif>
    <cfif ARGUMENTS.sbstplName NEQ "">
    AND UPPER(sbstplName) = <cfqueryparam value="#UCASE(ARGUMENTS.sbstplName)#" cfsqltype="cf_sql_varchar">
    </cfif>
    AND sbstplStatus IN (<cfqueryparam value="#ARGUMENTS.sbstplStatus#" list="yes" cfsqltype="cf_sql_integer">)
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsSignTemplate = StructNew()>
    <cfset rsSignTemplate.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsSignTemplate>
    </cffunction>
    
    <cffunction name="getSignTemplateRel" access="public" returntype="query" hint="Get Sign Template Rel. data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="ID" type="numeric" required="yes" default="0">
    <cfargument name="excludeID" type="numeric" required="yes" default="0">
    <cfargument name="sbsID" type="numeric" required="yes" default="0">
    <cfargument name="sbstplID" type="numeric" required="yes" default="0">
    <cfargument name="sbsSKU" type="string" required="yes" default="0">
    <cfargument name="sbsName" type="string" required="yes" default="">
    <cfargument name="deptNo" type="string" required="yes" default="0">
    <cfargument name="userID" type="numeric" required="yes" default="0">
    <cfargument name="sbstID" type="numeric" required="yes" default="0">
    <cfargument name="sbsStatus" type="string" required="yes" default="1,3">
    <cfargument name="sbstplrStatus" type="string" required="yes" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="sbstplID, deptNo, sbstplName">
    <cfset var rsSignTemplateRel = "" >
    <cftry>
    <cfquery name="rsSignTemplateRel" datasource="#application.mcmsDSN#">
    SELECT * FROM v_sb_sign_template_rel WHERE 0=0
    <cfif ARGUMENTS.ID NEQ 0>
    AND ID = <cfqueryparam value="#ARGUMENTS.ID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.excludeID NEQ 0>
    AND ID <> <cfqueryparam value="#ARGUMENTS.excludeID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(sbstplName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(sbsName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"><cfif IsNumeric(ARGUMENTS.keywords)> OR sbsSKU LIKE <cfqueryparam value="%#ARGUMENTS.keywords#%" cfsqltype="cf_sql_varchar"></cfif>)
    </cfif>
    <cfif ARGUMENTS.sbsID NEQ 0>
    AND sbsID = <cfqueryparam value="#ARGUMENTS.sbsID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.sbstplID NEQ 0>
    AND sbstplID = <cfqueryparam value="#ARGUMENTS.sbstplID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.sbsSKU NEQ 0>
    AND sbsSKU = <cfqueryparam value="#ARGUMENTS.sbsSKU#" cfsqltype="cf_sql_varchar">
    </cfif>
    <cfif ARGUMENTS.sbsName NEQ ''>
    AND sbsName = <cfqueryparam value="#ARGUMENTS.sbsName#" cfsqltype="cf_sql_varchar">
    </cfif>
    <cfif ARGUMENTS.deptNo NEQ 0>
    AND deptNo IN (<cfqueryparam value="#ARGUMENTS.deptNo#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    <cfif ARGUMENTS.userID NEQ 0>
    AND userID = <cfqueryparam value="#ARGUMENTS.userID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.sbstID NEQ 0>
    AND sbstID = <cfqueryparam value="#ARGUMENTS.sbstID#" cfsqltype="cf_sql_integer">
    </cfif>
    AND sbsStatus IN (<cfqueryparam value="#ARGUMENTS.sbsStatus#" list="yes" cfsqltype="cf_sql_integer">)
    AND sbstplrStatus IN (<cfqueryparam value="#ARGUMENTS.sbstplrStatus#" list="yes" cfsqltype="cf_sql_integer">)
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsSignTemplateRel = StructNew()>
    <cfset rsSignTemplateRel.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsSignTemplateRel>
    </cffunction>
    
    <cffunction name="getTemplateAttributeType" access="public" returntype="query" hint="Get Template Attribute Type data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="ID" type="numeric" required="yes" default="0">
    <cfargument name="excludeID" type="numeric" required="yes" default="0">
    <cfargument name="sbtplatName" type="string" required="yes" default="">
    <cfargument name="sbtplatRequired" type="string" required="yes" default="0">
    <cfargument name="sbtplatStatus" type="string" required="yes" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="sbtplatSort, sbtplatName">
    <cfset var rsTemplateAttributeType = "" >
    <cftry>
    <cfquery name="rsTemplateAttributeType" datasource="#application.mcmsDSN#">
    SELECT * FROM v_sb_template_attribute_type WHERE 0=0
    <cfif ARGUMENTS.ID NEQ 0>
    AND ID = <cfqueryparam value="#ARGUMENTS.ID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.excludeID NEQ 0>
    AND ID <> <cfqueryparam value="#ARGUMENTS.excludeID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(sbtplatName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">)
    </cfif>
    <cfif ARGUMENTS.sbtplatName NEQ "">
    AND sbtplatName = <cfqueryparam value="#ARGUMENTS.sbtplatName#" cfsqltype="cf_sql_varchar">
    </cfif>
    <cfif ARGUMENTS.sbtplatRequired NEQ 0>
    AND sbtplatRequired IN (<cfqueryparam value="#ARGUMENTS.sbtplatRequired#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    AND sbtplatStatus IN (<cfqueryparam value="#ARGUMENTS.sbtplatStatus#" list="yes" cfsqltype="cf_sql_integer">)
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsTemplateAttributeType = StructNew()>
    <cfset rsTemplateAttributeType.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsTemplateAttributeType>
    </cffunction>
    
    <cffunction name="getTemplateAttributeCSS" access="public" returntype="query" hint="Get Template Attribute CSS data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="ID" type="numeric" required="yes" default="0">
    <cfargument name="excludeID" type="numeric" required="yes" default="0">
    <cfargument name="sbtplatID" type="numeric" required="yes" default="0">
    <cfargument name="sbstplID" type="numeric" required="yes" default="0">
    <cfargument name="deptNo" type="string" required="yes" default="0">
    <cfargument name="sbstID" type="numeric" required="yes" default="0">
    <cfargument name="sbtplacStatus" type="string" required="yes" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="sbtplatName, sbstplName">
    <cfset var rsTemplateAttributeCSS = "" >
    <cftry>
    <cfquery name="rsTemplateAttributeCSS" datasource="#application.mcmsDSN#">
    SELECT * FROM v_sb_template_attribute_css WHERE 0=0
    <cfif ARGUMENTS.ID NEQ 0>
    AND ID = <cfqueryparam value="#ARGUMENTS.ID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.excludeID NEQ 0>
    AND ID <> <cfqueryparam value="#ARGUMENTS.excludeID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(sbtplatName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">)
    </cfif>
    <cfif ARGUMENTS.sbtplatID NEQ 0>
    AND sbtplatID = <cfqueryparam value="#ARGUMENTS.sbtplatID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.sbstplID NEQ 0>
    AND sbstplID = <cfqueryparam value="#ARGUMENTS.sbstplID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.deptNo NEQ 0>
    AND deptNo IN (<cfqueryparam value="#ARGUMENTS.deptNo#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    <cfif ARGUMENTS.sbstID NEQ 0>
    AND sbstID = <cfqueryparam value="#ARGUMENTS.sbstID#" cfsqltype="cf_sql_integer">
    </cfif>
    AND sbtplacStatus IN (<cfqueryparam value="#ARGUMENTS.sbtplacStatus#" list="yes" cfsqltype="cf_sql_integer">)
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsTemplateAttributeCSS = StructNew()>
    <cfset rsTemplateAttributeCSS.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsTemplateAttributeCSS>
    </cffunction>
    
    <cffunction name="getSignTemplateAttributeDepartmentRel" access="public" returntype="query" hint="Get Sign Template Attribute Department Rel. data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="ID" type="numeric" required="yes" default="0">
    <cfargument name="excludeID" type="numeric" required="yes" default="0">
    <cfargument name="sbsID" type="string" required="yes" default="0">
    <cfargument name="sbtplatdrID" type="string" required="yes" default="0">
    <cfargument name="sbstplID" type="numeric" required="yes" default="0">
    <cfargument name="sbtplatID" type="string" required="yes" default="0">
    <cfargument name="deptNo" type="numeric" required="yes" default="0">
    <cfargument name="sbstpladrStatus" type="string" required="yes" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="deptNo, sbstplName">
    <cfset var rsSignTemplateAttributeDepartmentRel = "" >
    <cftry>
    <cfquery name="rsSignTemplateAttributeDepartmentRel" datasource="#application.mcmsDSN#">
    SELECT * FROM v_sb_sign_tpl_attr_dept_rel WHERE 0=0
    <cfif ARGUMENTS.ID NEQ 0>
    AND ID = <cfqueryparam value="#ARGUMENTS.ID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.excludeID NEQ 0>
    AND ID <> <cfqueryparam value="#ARGUMENTS.excludeID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(sbstplName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">)
    </cfif>
    <cfif ARGUMENTS.sbsID NEQ 0>
    AND sbsID IN (<cfqueryparam value="#ARGUMENTS.sbsID#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    <cfif ARGUMENTS.sbtplatdrID NEQ 0>
    AND sbtplatdrID IN (<cfqueryparam value="#ARGUMENTS.sbtplatdrID#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    <cfif ARGUMENTS.sbstplID NEQ 0>
    AND sbstplID = <cfqueryparam value="#ARGUMENTS.sbstplID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.sbtplatID NEQ 0>
    AND sbtplatID IN (<cfqueryparam value="#ARGUMENTS.sbtplatID#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    <cfif ARGUMENTS.deptNo NEQ 0>
    AND deptNo = <cfqueryparam value="#ARGUMENTS.deptNo#" cfsqltype="cf_sql_integer">
    </cfif>
    AND sbstpladrStatus IN (<cfqueryparam value="#ARGUMENTS.sbstpladrStatus#" list="yes" cfsqltype="cf_sql_integer">)
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsSignTemplateAttributeDepartmentRel = StructNew()>
    <cfset rsSignTemplateAttributeDepartmentRel.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsSignTemplateAttributeDepartmentRel>
    </cffunction>
    
    <cffunction name="getTemplateAttributeTypeDepartmentRel" access="public" returntype="query" hint="Get Template Attribute Type Department Rel. data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="ID" type="numeric" required="yes" default="0">
    <cfargument name="excludeID" type="numeric" required="yes" default="0">
    <cfargument name="sbstplID" type="numeric" required="yes" default="0">
    <cfargument name="sbtplatID" type="numeric" required="yes" default="0">
    <cfargument name="sbtplatRequired" type="string" required="yes" default="0">
    <cfargument name="deptNo" type="numeric" required="yes" default="0">
    <cfargument name="sbstID" type="numeric" required="yes" default="0">
    <cfargument name="sbtplatdrStatus" type="string" required="yes" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="sbtplatSort, ID">
    <cfset var rsTemplateAttributeTypeDepartmentRel = "" >
    <cftry>
    <cfquery name="rsTemplateAttributeTypeDepartmentRel" datasource="#application.mcmsDSN#">
    SELECT * FROM v_sb_tpl_attr_type_dept_rel WHERE 0=0
    <cfif ARGUMENTS.ID NEQ 0>
    AND ID = <cfqueryparam value="#ARGUMENTS.ID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.excludeID NEQ 0>
    AND ID <> <cfqueryparam value="#ARGUMENTS.excludeID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(sbstplName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(sbtplatName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">)
    </cfif>
    <cfif ARGUMENTS.sbstplID NEQ 0>
    AND sbstplID = <cfqueryparam value="#ARGUMENTS.sbstplID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.sbtplatID NEQ 0>
    AND sbtplatID = <cfqueryparam value="#ARGUMENTS.sbtplatID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.sbtplatRequired NEQ 0>
    AND sbtplatRequired IN (<cfqueryparam value="#ARGUMENTS.sbtplatRequired#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    <cfif ARGUMENTS.deptNo NEQ 0>
    AND deptNo = <cfqueryparam value="#ARGUMENTS.deptNo#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.sbstID NEQ 0>
    AND sbstID = <cfqueryparam value="#ARGUMENTS.sbstID#" cfsqltype="cf_sql_integer">
    </cfif>
    AND sbtplatdrStatus IN (<cfqueryparam value="#ARGUMENTS.sbtplatdrStatus#" list="yes" cfsqltype="cf_sql_integer">)
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsTemplateAttributeTypeDepartmentRel = StructNew()>
    <cfset rsTemplateAttributeTypeDepartmentRel.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsTemplateAttributeTypeDepartmentRel>
    </cffunction>
    
    <cffunction name="getTemplateItemAttributeDCLRel" access="public" returntype="query" hint="Get Template Item Attribute DCL Rel. data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="ID" type="numeric" required="yes" default="0">
    <cfargument name="excludeID" type="numeric" required="yes" default="0">
    <cfargument name="sbstplID" type="numeric" required="yes" default="0">
    <cfargument name="deptNo" type="numeric" required="yes" default="0">
    <cfargument name="sbtpliadclrStatus" type="string" required="yes" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="sbstplName, deptNo">
    <cfset var rsTemplateItemAttributeDCLRel = "" >
    <cftry>
    <cfquery name="rsTemplateItemAttributeDCLRel" datasource="#application.mcmsDSN#">
    SELECT * FROM v_sb_tpl_item_attr_dcl_rel WHERE 0=0
    <cfif ARGUMENTS.ID NEQ 0>
    AND ID = <cfqueryparam value="#ARGUMENTS.ID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.excludeID NEQ 0>
    AND ID <> <cfqueryparam value="#ARGUMENTS.excludeID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND UPPER(sbstplName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">
    </cfif>
    <cfif ARGUMENTS.sbstplID NEQ 0>
    AND sbstplID = <cfqueryparam value="#ARGUMENTS.sbstplID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.deptNo NEQ 0>
    AND deptNo = <cfqueryparam value="#ARGUMENTS.deptNo#" cfsqltype="cf_sql_integer">
    </cfif>
    AND sbtpliadclrStatus IN (<cfqueryparam value="#ARGUMENTS.sbtpliadclrStatus#" list="yes" cfsqltype="cf_sql_integer">)
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsTemplateItemAttributeDCLRel = StructNew()>
    <cfset rsTemplateItemAttributeDCLRel.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsTemplateItemAttributeDCLRel>
    </cffunction>
    
    <cffunction name="getSignReport" access="public" returntype="query" hint="Get Sign Report data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="siteNo" type="string" required="yes" default="100">
    <cfargument name="deptNo" type="string" required="yes" default="0">
    <cfargument name="args" type="string" required="yes" default="0">
    <cfargument name="orderBy" type="string" required="yes" default="sbsSKU">
    <cfset var rsSignReport = "" >
    <cftry>
    <cfquery name="rsSignReport" datasource="#application.mcmsDSN#">
    SELECT sbsSKU AS SKU, sbsName AS Name, sbstplName AS Template, sbsPriceOriginal AS Original_Price, deptName AS Department, userLName AS Username, sbstName AS Type, sName AS Status FROM v_sb_sign_template_rel WHERE 0=0
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(sbsSKU) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">)
    </cfif>
    <cfif ARGUMENTS.deptNo NEQ 0>
    AND deptNo = <cfqueryparam value="#ARGUMENTS.deptNo#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ListGetAt(ARGUMENTS.args, 1) NEQ 0>
    AND sbstplID = <cfqueryparam value="#ListGetAt(ARGUMENTS.args, 1)#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ListGetAt(ARGUMENTS.args, 2) NEQ 0>
    AND sbstID = <cfqueryparam value="#ListGetAt(ARGUMENTS.args, 2)#" cfsqltype="cf_sql_integer">
    </cfif>
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsSignReport = StructNew()>
    <cfset rsSignReport.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsSignReport>
    </cffunction>
    
    <cffunction name="getSignPrice" access="public" returntype="query" hint="Get Sign Price data.">
    <cfargument name="sbsSKU" type="string" required="yes" default="">
    <cfargument name="siteNo" type="numeric" required="yes" default="0">
    <cfargument name="deptNo" type="numeric" required="yes" default="0">
    <cfargument name="classNo" type="numeric" required="yes" default="0">
    <cfargument name="lineNo" type="numeric" required="yes" default="0">
    <cfargument name="manufacturerID" type="string" required="yes" default="0">
    <cfargument name="importerID" type="string" required="yes" default="0">
    <cfargument name="modelID" type="string" required="yes" default="0">
    <cfargument name="orderBy" type="string" required="yes" default="SKU, siteNo, deptNo, classNo, lineNo">
    <cfset var rsSignPrice = "" >
    <cftry>
    <cfquery name="rsSignPrice" datasource="swprd">
    SELECT * FROM v_sb_sign_price WHERE 0=0
    <cfif ARGUMENTS.sbsSKU NEQ ''>
    AND SKU IN (<cfqueryparam value="#ARGUMENTS.sbsSKU#" list="yes" cfsqltype="cf_sql_varchar">)
    </cfif>
    <cfif ARGUMENTS.siteNo NEQ 100>
    AND siteNo = <cfqueryparam value="#ARGUMENTS.siteNo#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.deptNo NEQ 0>
    AND deptNo = <cfqueryparam value="#ARGUMENTS.deptNo#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.classNo NEQ 0>
    AND classNo = <cfqueryparam value="#ARGUMENTS.classNo#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.lineNo NEQ 0>
    AND lineNo = <cfqueryparam value="#ARGUMENTS.lineNo#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.manufacturerID NEQ 0>
    AND manufacturerID IN (<cfqueryparam value="#ARGUMENTS.manufacturerID#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    <cfif ARGUMENTS.importerID NEQ 0>
    AND importerID IN (<cfqueryparam value="#ARGUMENTS.importerID#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    <cfif ARGUMENTS.modelID NEQ 0>
    AND modelID IN (<cfqueryparam value="#ARGUMENTS.modelID#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsSignPrice = StructNew()>
    <cfset rsSignPrice.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsSignPrice>
    </cffunction>
    
    <cffunction name="getSignQRCodeReport" access="public" returntype="query" hint="Get Sign QR Code Report data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="orderBy" type="string" required="yes" default="sbsName, sbsSku">
    <cfset var rsSignTypeReport = "" >
    <cftry>
    <cfquery name="rsSignQRCodeReport" datasource="#application.mcmsDSN#">
    SELECT sbsName AS Name, sbssku AS Sku, sbsqrcURL AS URL, sName AS Status FROM v_sb_sign_qr_code WHERE 0=0
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(sbsName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(sbsSku) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">)
    </cfif>
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsSignQRCodeReport = StructNew()>
    <cfset rsSignQRCodeReport.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsSignQRCodeReport>
    </cffunction>
    
    <cffunction name="getSignTypeReport" access="public" returntype="query" hint="Get Sign Type Report data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="orderBy" type="string" required="yes" default="sbstName">
    <cfset var rsSignTypeReport = "" >
    <cftry>
    <cfquery name="rsSignTypeReport" datasource="#application.mcmsDSN#">
    SELECT sbstName AS Name, TO_CHAR(sbstDescription) AS Description, sortName AS Sort, sName AS Status FROM v_sb_sign_type WHERE 0=0
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND UPPER(sbstName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">
    </cfif>
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsSignTypeReport = StructNew()>
    <cfset rsSignTypeReport.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsSignTypeReport>
    </cffunction>
    
    <cffunction name="getSignTemplateReport" access="public" returntype="query" hint="Get Sign Template Report data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="orderBy" type="string" required="yes" default="sbstplName">
    <cfset var rsSignTemplateReport = "" >
    <cftry>
    <cfquery name="rsSignTemplateReport" datasource="#application.mcmsDSN#">
    SELECT sbstplName AS Name, TO_CHAR(sbstplDescription) AS Description, sbstplFormatUnit AS Unit, sbstplFormatOrientation AS Orientation, sbstplFormatPageType AS Page_Type, sbstplWidth AS Page_Width, sbstplHeight AS Page_Height, sbstplMargin AS Margin, sbstplCellWidth AS Cell_Width, sbstplCellHeight AS Cell_Height, sbstplCellCount AS Cell_Count, sbstplCellColumnCount AS Cell_ColumnCount, sbstplCellVAlign AS Cell_V_Align, sbstplLogo AS Logo, sbstplTemplateImage AS Template_Image, TO_CHAR(sbstplDateUpdate, 'MM/DD/YYYY') AS Date_Updated, sName AS Status FROM v_sb_sign_template WHERE 0=0
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(sbstblName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(sbstblDescription) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">)
    </cfif>
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsSignTemplateReport = StructNew()>
    <cfset rsSignTemplateReport.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsSignTemplateReport>
    </cffunction>
    
    <cffunction name="getTemplateAttributeTypeDepartmentRelReport" access="public" returntype="query" hint="Get Template Attribute Type Department Rel. Report data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="siteNo" type="string" required="yes" default="100">
    <cfargument name="deptNo" type="string" required="yes" default="0">
    <cfargument name="args" type="string" required="yes" default="0">
    <cfargument name="orderBy" type="string" required="yes" default="deptNo">
    <cfset var rsTemplateAttributeTypeDepartmentRelReport = "" >
    <cftry>
    <cfquery name="rsTemplateAttributeTypeDepartmentRelReport" datasource="#application.mcmsDSN#">
    SELECT sbtplatName AS Attribute, sbstplName AS Template, deptName AS Department, sbstName AS Type, sbtplatdrRequired AS Required, sName AS Status FROM v_sb_tpl_attr_type_dept_rel WHERE 0=0
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(sbstplName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(sbtplatdrName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">)
    </cfif>
    <cfif ARGUMENTS.deptNo NEQ 0>
    AND deptNo = <cfqueryparam value="#ARGUMENTS.deptNo#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ListGetAt(ARGUMENTS.args, 1) NEQ 0>
    AND sbstplID = <cfqueryparam value="#ListGetAt(ARGUMENTS.args, 1)#" cfsqltype="cf_sql_integer">
    </cfif>
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsTemplateAttributeTypeDepartmentRelReport = StructNew()>
    <cfset rsTemplateAttributeTypeDepartmentRelReport.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsTemplateAttributeTypeDepartmentRelReport>
    </cffunction>
    
    <cffunction name="getTemplateItemAttributeDCLRelReport" access="public" returntype="query" hint="Get Template Item Attribute DCL Rel. Report data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="siteNo" type="string" required="yes" default="100">
    <cfargument name="deptNo" type="string" required="yes" default="0">
    <cfargument name="args" type="string" required="yes" default="0">
    <cfargument name="orderBy" type="string" required="yes" default="deptNo">
    <cfset var rsTemplateItemAttributeDCLRelReport = "" >
    <cftry>
    <cfquery name="rsTemplateItemAttributeDCLRelReport" datasource="#application.mcmsDSN#">
    SELECT sbstplName AS Template, deptName AS Department, manufacturerID, importerID, modelID, DCL, sName AS Status FROM v_sb_tpl_item_attr_dcl_rel WHERE 0=0
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND UPPER(sbstplName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">
    </cfif>
    <cfif ARGUMENTS.deptNo NEQ 0>
    AND deptNo = <cfqueryparam value="#ARGUMENTS.deptNo#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ListGetAt(ARGUMENTS.args, 1) NEQ 0>
    AND sbstplID = <cfqueryparam value="#ListGetAt(ARGUMENTS.args, 1)#" cfsqltype="cf_sql_integer">
    </cfif>
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsTemplateItemAttributeDCLRelReport = StructNew()>
    <cfset rsTemplateItemAttributeDCLRelReport.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsTemplateItemAttributeDCLRelReport>
    </cffunction>
    
    <cffunction name="getTemplateAttributeCSSReport" access="public" returntype="query" hint="Get Template Attribute CSS Report data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="siteNo" type="string" required="yes" default="100">
    <cfargument name="deptNo" type="string" required="yes" default="0">
    <cfargument name="args" type="string" required="yes" default="0">
    <cfargument name="orderBy" type="string" required="yes" default="deptNo, sbtplatSort">
    <cfset var rsTemplateAttributeCSSReport = "" >
    <cftry>
    <cfquery name="rsTemplateAttributeCSSReport" datasource="#application.mcmsDSN#">
    SELECT sbtplatName AS Attribute, sbstplName AS Template, deptName AS Department, sbstName AS Type, sbtplacFont AS Font, sbtplacFontSize AS Font_Size, sbtplacFontWeight AS Font_Weight, sbtplacFontColor AS Font_Color, sbtplacFontLength AS Length, sName AS Status FROM v_sb_template_attribute_css WHERE 0=0
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(sbstplName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(sbtplatName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">)
    </cfif>
    <cfif ARGUMENTS.deptNo NEQ 0>
    AND deptNo = <cfqueryparam value="#ARGUMENTS.deptNo#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ListGetAt(ARGUMENTS.args, 1) NEQ 0>
    AND sbstplID = <cfqueryparam value="#ListGetAt(ARGUMENTS.args, 1)#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ListGetAt(ARGUMENTS.args, 2) NEQ 0>
    AND sbstID = <cfqueryparam value="#ListGetAt(ARGUMENTS.args, 2)#" cfsqltype="cf_sql_integer">
    </cfif>
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsTemplateAttributeCSSReport = StructNew()>
    <cfset rsTemplateAttributeCSSReport.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsTemplateAttributeCSSReport>
    </cffunction>
    
    <cffunction name="insertSign" access="public" returntype="struct">
    <cfargument name="sbsSKU" type="string" required="yes">
    <cfargument name="sbsName" type="string" required="yes">
    <cfargument name="sbsMFGCode" type="string" required="yes">
    <cfargument name="sbsPriceOriginal" type="string" required="yes">
    <cfargument name="deptNo" type="numeric" required="yes">
    <cfargument name="userID" type="numeric" required="yes">
    <cfargument name="sbstID" type="numeric" required="yes">
    <cfargument name="sbsStatus" type="numeric" required="yes">
    <!---Relationship arguments.--->
    <cfargument name="sbstplID" type="numeric" required="yes">
    <cfargument name="sbtplatdrCount" type="numeric" required="yes">
    <cfargument name="sbsGroupCount" type="numeric" required="yes">
    <cfset result.message = "You have successfully inserted the record.">
    <cftry>
    <!---Check for a duplicate record.--->
    <cfif ARGUMENTS.sbsSku EQ 1>
    <cfset ARGUMENTS.sbsSku = ARGUMENTS.sbsName>
    </cfif>
    <cfinvoke 
    component="MCMS.component.app.sign_builder.SignBuilder"
    method="getSignTemplateRel"
    returnvariable="getCheckSignTemplateRelRet">
    <cfinvokeargument name="sbsSKU" value="#ARGUMENTS.sbsSKU#"/>
    <cfinvokeargument name="deptNo" value="#ARGUMENTS.deptNo#"/>
    <cfinvokeargument name="sbstplID" value="#ARGUMENTS.sbstplID#"/>
    <cfinvokeargument name="sbstplrStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckSignTemplateRelRet.recordcount NEQ 0>
    <cfset result.message = "The SKU #ARGUMENTS.sbsSKU# already exists for this template, please enter a new SKU and/or template.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    INSERT INTO tbl_sb_sign (sbsSKU,sbsName,sbsMFGCode,sbsPriceOriginal,deptNo,userID,sbstID,sbsStatus) VALUES
    (
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#Iif(ARGUMENTS.sbsSKU EQ '', DE(ARGUMENTS.sbsName), DE(ARGUMENTS.sbsSKU))#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#Iif(ARGUMENTS.sbsName EQ '', DE(form.sbstpladrValue1), DE(ARGUMENTS.sbsName))#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.sbsMFGCode#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.sbsPriceOriginal#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.deptNo#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.userID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.sbstID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.sbsStatus#">
    )
    </cfquery>
    </cftransaction>
    <!---Get the Sign ID.--->
    <cfinvoke 
    component="MCMS.component.cms.Cms"
    method="getMaxValueSQL"
    returnvariable="getMaxValueSQLRet">
    <cfinvokeargument name="tableName" value="tbl_sb_sign"/>
    </cfinvoke>
    <cfset this.sbsID = getMaxValueSQLRet>
    <!---Insert template relationship.--->
    <cfinvoke 
    component="MCMS.component.app.sign_builder.SignBuilder"
    method="insertSignTemplateRel"
    returnvariable="insertSignTemplateRelRet">
    <cfinvokeargument name="sbsID" value="#this.sbsID#"/>
    <cfinvokeargument name="sbstplID" value="#ARGUMENTS.sbstplID#"/>
    <cfinvokeargument name="sbstplrStatus" value="1"/>
    </cfinvoke>
    <!---Insert sign attribute values.--->
    <cfloop index="i" from="1" to="#ARGUMENTS.sbtplatdrCount#">
    <cfinvoke 
    component="MCMS.component.app.sign_builder.SignBuilder"
    method="insertSignTemplateAttributeDepartmentRel"
    returnvariable="insertSignTemplateAttributeDepartmentRelRet">
    <cfinvokeargument name="sbsID" value="#this.sbsID#"/>
    <cfinvokeargument name="sbtplatdrID" value="#Evaluate('form.sbtplatdrID#i#')#"/>
    <cfinvokeargument name="sbstpladrValue" value="#Evaluate('form.sbstpladrValue#i#')#"/>
    <cfinvokeargument name="sbstpladrSort" value="#Evaluate('form.sbstpladrSort#i#')#"/>
    <cfinvokeargument name="sbstpladrStatus" value="1"/>
    </cfinvoke>
    </cfloop>
    <!---Insert SKUs for group sign if applicable.--->
    <cfif ARGUMENTS.sbstID EQ 2>
    <cfloop index="ig" from="1" to="#ARGUMENTS.sbsGroupCount#">
    <cfif Evaluate('form.sbsSKUGroup#ig#') NEQ ''>
    <cfinvoke 
    component="MCMS.component.app.sign_builder.SignBuilder"
    method="insertSignSkuRel"
    returnvariable="result">
    <cfinvokeargument name="sbsID" value="#this.sbsID#"/>
    <cfinvokeargument name="sbsIDRel" value="#Evaluate('form.sbsSKUGroup#ig#')#"/>
    <cfinvokeargument name="sbssrSort" value="#Evaluate('form.sbssrSort#ig#')#"/>
    <cfinvokeargument name="sbssrStatus" value="1"/>
    </cfinvoke>
    </cfif>
    </cfloop>
    </cfif>
    </cfif>
    <cfcatch type="any">
    <cfset result.message = "There was an error inserting the record.">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="insertSignQRCode" access="public" returntype="struct">
    <cfargument name="sbsID" type="numeric" required="yes">
    <cfargument name="sbsqrcURL" type="string" required="yes">
    <cfargument name="sbsqrcStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully inserted the record.">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    INSERT INTO tbl_sb_sign_qr_code (sbsID,sbsqrcURL,sbsqrcStatus) VALUES
    (
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.sbsID#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.sbsqrcURL#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.sbsqrcStatus#">
    )
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error inserting the record.">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="insertSignSkuRel" access="public" returntype="struct">
    <cfargument name="sbsID" type="numeric" required="yes">
    <cfargument name="sbsIDRel" type="numeric" required="yes">
    <cfargument name="sbssrSort" type="numeric" required="yes">
    <cfargument name="sbssrStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully inserted the record.">
    <cftry>
    <!---Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.app.sign_builder.SignBuilder"
    method="getSignSkuRel"
    returnvariable="getCheckSignSkuRelRet">
    <cfinvokeargument name="sbsID" value="#ARGUMENTS.sbsID#"/>
    <cfinvokeargument name="sbsIDRel" value="#ARGUMENTS.sbsIDRel#"/>
    <cfinvokeargument name="sbssrStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckSignSkuRelRet.recordcount NEQ 0>
    <cfset result.message = "The name relationship already exists, please enter a new SKU.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    INSERT INTO tbl_sb_sign_sku_rel (sbsID,sbsIDRel,sbssrSort,sbssrStatus) VALUES
    (
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.sbsID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.sbsIDRel#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.sbssrSort#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.sbssrStatus#">
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
    
    <cffunction name="insertTemplateAttributeCSS" access="public" returntype="struct">
    <cfargument name="sbstplID" type="numeric" required="yes">
    <cfargument name="sbtplatID" type="numeric" required="yes">
    <cfargument name="deptNo" type="numeric" required="yes">
    <cfargument name="sbstID" type="numeric" required="yes">
    <cfargument name="sbtplacFont" type="string" required="yes">
    <cfargument name="sbtplacFontSize" type="numeric" required="yes">
    <cfargument name="sbtplacFontWeight" type="string" required="yes">
    <cfargument name="sbtplacFontColor" type="string" required="yes">
    <cfargument name="sbtplacFontLength" type="numeric" required="yes">
    <cfargument name="sbtplacFontAlign" type="string" required="yes">
    <cfargument name="sbtplacStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully inserted the record.">
    <cftry>
    <!---Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.app.sign_builder.SignBuilder"
    method="getTemplateAttributeCSS"
    returnvariable="getCheckTemplateAttributeCSSRet">
    <cfinvokeargument name="sbstplID" value="#ARGUMENTS.sbstplID#"/>
    <cfinvokeargument name="sbtplatID" value="#ARGUMENTS.sbtplatID#"/>
    <cfinvokeargument name="deptNo" value="#ARGUMENTS.deptNo#"/>
    <cfinvokeargument name="sbstID" value="#ARGUMENTS.sbstID#"/>
    <cfinvokeargument name="sbtplatdrStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckTemplateAttributeCSSRet.recordcount NEQ 0>
    <cfset result.message = "The style already exists for this template, attribute, and department, please try again.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    INSERT INTO tbl_sb_template_attribute_css (sbstplID,sbtplatID,deptNo,sbstID,sbtplacFont,sbtplacFontSize,sbtplacFontWeight,sbtplacFontColor,sbtplacFontLength,sbtplacFontAlign,sbtplacStatus) VALUES
    (
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.sbstplID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.sbtplatID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.deptNo#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.sbstID#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.sbtplacFont#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.sbtplacFontSize#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.sbtplacFontWeight#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.sbtplacFontColor#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.sbtplacFontLength#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.sbtplacFontAlign#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.sbtplacStatus#">
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
    
    <cffunction name="insertSignType" access="public" returntype="struct">
    <cfargument name="sbstName" type="string" required="yes">
    <cfargument name="sbstDescription" type="string" required="yes">
    <cfargument name="sbstSort" type="numeric" required="yes">
    <cfargument name="sbstStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully inserted the record.">
    <cftry>
    <!---Check for profanity in the text.--->
    <cfinvoke 
    component="MCMS.component.utility.Regex"
    method="regexProfanity"
    returnvariable="regexProfanityRet">
    <cfinvokeargument name="profanityString" value="#ARGUMENTS.sbstDescription#"/>
    </cfinvoke>
    <!---Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.app.sign_builder.SignBuilder"
    method="getSignType"
    returnvariable="getCheckSignTypeRet">
    <cfinvokeargument name="sbstName" value="#ARGUMENTS.sbstName#"/>
    <cfinvokeargument name="sbstStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckSignTypeRet.recordcount NEQ 0>
    <cfset result.message = "The name #ARGUMENTS.sbtsName# already exists, please enter a new name.">
    <cfelseif regexProfanityRet CONTAINS '$%&*!'>
    <cfset result.message = "Some text contained profanity, please remove any profanity from your text.">
    <!---Check length restriction.--->
    <cfelseif LEN(ARGUMENTS.sbstDescription) GT 1024>
    <cfset result.message = "The description is longer than 1024 characters, please enter a new description under 1024 characters.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    INSERT INTO tbl_sb_sign_type (sbstName,sbstDescription,sbstSort,sbstStatus) VALUES
    (
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.sbstName#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.sbstDescription#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.sbstSort#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.sbstStatus#">
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
    
    <cffunction name="insertSignTemplate" access="public" returntype="struct">
    <cfargument name="sbstplName" type="string" required="yes">
    <cfargument name="sbstplDescription" type="string" required="yes">
    <cfargument name="sbstplFormatUnit" type="string" required="yes">
    <cfargument name="sbstplFormatOrientation" type="string" required="yes">
    <cfargument name="sbstplFormatPageType" type="string" required="yes">
    <cfargument name="sbstplWidth" type="numeric" required="yes">
    <cfargument name="sbstplHeight" type="numeric" required="yes">
    <cfargument name="sbstplMargin" type="numeric" required="yes">
    <cfargument name="sbstplCellWidth" type="numeric" required="yes">
    <cfargument name="sbstplCellHeight" type="numeric" required="yes">
    <cfargument name="sbstplCellCount" type="numeric" required="yes">
    <cfargument name="sbstplCellColumnCount" type="numeric" required="yes">
    <cfargument name="sbstplCellVAlign" type="string" required="yes">
    <cfargument name="sbstplMaxRow" type="numeric" required="yes">
    <cfargument name="sbstplLogo" type="string" required="yes">
    <cfargument name="sbstplTemplateImage" type="string" required="yes">
    <cfargument name="sbstplStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully inserted the record.">
    <cftry>
    <!---Check for profanity in the text.--->
    <cfinvoke 
    component="MCMS.component.utility.Regex"
    method="regexProfanity"
    returnvariable="regexProfanityRet">
    <cfinvokeargument name="profanityString" value="#ARGUMENTS.sbstplDescription#"/>
    </cfinvoke>
    <!---Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.app.sign_builder.SignBuilder"
    method="getSignTemplate"
    returnvariable="getCheckSignTemplateRet">
    <cfinvokeargument name="sbstplName" value="#ARGUMENTS.sbstplName#"/>
    <cfinvokeargument name="sbstplStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckSignTemplateRet.recordcount NEQ 0>
    <cfset result.message = "The name #ARGUMENTS.sbtplName# already exists, please enter a new name.">
    <cfelseif regexProfanityRet CONTAINS '$%&*!'>
    <cfset result.message = "Some text contained profanity, please remove any profanity from your text.">
    <!---Check length restriction.--->
    <cfelseif LEN(ARGUMENTS.sbstplDescription) GT 1024>
    <cfset result.message = "The description is longer than 1024 characters, please enter a new description under 1024 characters.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    INSERT INTO tbl_sb_sign_template (sbstplName,sbstplDescription,sbstplFormatUnit,sbstplFormatOrientation,sbstplFormatPageType,sbstplWidth,sbstplHeight,sbstplMargin,sbstplCellWidth,sbstplCellHeight,sbstplCellCount,sbstplCellColumnCount,sbstplMaxRow,sbstplCellVAlign,sbstplLogo,sbstplTemplateImage,sbstplStatus) VALUES
    (
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.sbstplName#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.sbstplDescription#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.sbstplFormatUnit#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.sbstplFormatOrientation#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.sbstplFormatPageType#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.sbstplWidth#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.sbstplHeight#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.sbstplMargin#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.sbstplCellWidth#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.sbstplCellHeight#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.sbstplCellCount#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.sbstplCellColumnCount#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.sbstplMaxRow#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.sbstplCellVAlign#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.sbstplLogo#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.sbstplTemplateImage#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.sbstplStatus#">
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
    
    <cffunction name="insertSignTemplateRel" access="public" returntype="struct">
    <cfargument name="sbsID" type="numeric" required="yes">
    <cfargument name="sbstplID" type="numeric" required="yes">
    <cfargument name="sbstplrStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully inserted the record.">
    <cftry>
    <!---Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.app.sign_builder.SignBuilder"
    method="getSignTemplateRel"
    returnvariable="getCheckSignTemplateRelRet">
    <cfinvokeargument name="sbsID" value="#ARGUMENTS.sbsID#"/>
    <cfinvokeargument name="sbstplID" value="#ARGUMENTS.sbstplID#"/>
    <cfinvokeargument name="sbstplrStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckSignTemplateRelRet.recordcount NEQ 0>
    <cfset result.message = "The sign/sku already exists for this template, please enter a sign/sku and template.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    INSERT INTO tbl_sb_sign_template_rel (sbsID,sbstplID,sbstplrStatus) VALUES
    (
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.sbsID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.sbstplID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.sbstplrStatus#">
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
    
    <cffunction name="insertSignTemplateAttributeDepartmentRel" access="public" returntype="struct">
    <cfargument name="sbsID" type="numeric" required="yes">
    <cfargument name="sbtplatdrID" type="numeric" required="yes">
    <cfargument name="sbstpladrValue" type="string" required="yes">
    <cfargument name="sbstpladrSort" type="numeric" required="yes">
    <cfargument name="sbstpladrStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully inserted the record.">
    <cftry>
    <!---Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.app.sign_builder.SignBuilder"
    method="getSignTemplateAttributeDepartmentRel"
    returnvariable="getCheckSignTemplateAttributeDepartmentRelRet">
    <cfinvokeargument name="sbsID" value="#ARGUMENTS.sbsID#"/>
    <cfinvokeargument name="sbtplatdrID" value="#ARGUMENTS.sbtplatdrID#"/>
    <cfinvokeargument name="sbstpladrStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckSignTemplateAttributeDepartmentRelRet.recordcount NEQ 0>
    <cfset result.message = "The value already exists for this template, please try again.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    INSERT INTO tbl_sb_sign_tpl_attr_dept_rel (sbsID,sbtplatdrID,sbstpladrValue,sbstpladrSort,sbstpladrStatus) VALUES
    (
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.sbsID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.sbtplatdrID#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.sbstpladrValue#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.sbstpladrSort#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.sbstpladrStatus#">
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
    
    <cffunction name="insertTemplateAttributeTypeDepartmentRel" access="public" returntype="struct">
    <cfargument name="sbstplID" type="numeric" required="yes">
    <cfargument name="sbtplatID" type="numeric" required="yes">
    <cfargument name="deptNo" type="numeric" required="yes">
    <cfargument name="sbstID" type="numeric" required="yes">
    <cfargument name="sbtplatdrRequired" type="numeric" required="yes">
    <cfargument name="sbtplatdrStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully inserted the record.">
    <cftry>
    <!---Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.app.sign_builder.SignBuilder"
    method="getTemplateAttributeTypeDepartmentRel"
    returnvariable="getCheckTemplateAttributeTypeDepartmentRelRet">
    <cfinvokeargument name="sbstplID" value="#ARGUMENTS.sbstplID#"/>
    <cfinvokeargument name="sbtplatID" value="#ARGUMENTS.sbtplatID#"/>
    <cfinvokeargument name="deptNo" value="#ARGUMENTS.deptNo#"/>
    <cfinvokeargument name="sbstID" value="#ARGUMENTS.sbstID#"/>
    <cfinvokeargument name="sbtplatdrStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckTemplateAttributeTypeDepartmentRelRet.recordcount NEQ 0>
    <cfset result.message = "The attribute already exists for this template and department, please try again.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    INSERT INTO tbl_sb_tpl_attr_type_dept_rel (sbstplID,sbtplatID,deptNo,sbstID,sbtplatdrRequired,sbtplatdrStatus) VALUES
    (
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.sbstplID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.sbtplatID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.deptNo#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.sbstID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.sbtplatdrRequired#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.sbtplatdrStatus#">
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
    
    <cffunction name="insertTemplateItemAttributeDCLRel" access="public" returntype="struct">
    <cfargument name="sbstplID" type="numeric" required="yes">
    <cfargument name="deptNo" type="numeric" required="yes">
    <cfargument name="manufacturerID" type="string" required="yes">
    <cfargument name="importerID" type="string" required="yes">
    <cfargument name="modelID" type="string" required="yes">
    <cfargument name="DCL" type="string" required="yes">
    <cfargument name="sbtpliadclrStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully inserted the record.">
    <cftry>
    <!---Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.app.sign_builder.SignBuilder"
    method="getTemplateItemAttributeDCLRel"
    returnvariable="getCheckTemplateItemAttributeDCLRelRet">
    <cfinvokeargument name="sbstplID" value="#ARGUMENTS.sbstplID#"/>
    <cfinvokeargument name="deptNo" value="#ARGUMENTS.deptNo#"/>
    <cfinvokeargument name="sbtpliadclrStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckTemplateItemAttributeDCLRelRet.recordcount NEQ 0>
    <cfset result.message = "An item attribute already exists for this template and department, please try again.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    INSERT INTO tbl_sb_tpl_item_attr_dcl_rel (sbstplID,deptNo,manufacturerID,importerID,modelID,DCL,sbtpliadclrStatus) VALUES
    (
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.sbstplID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.deptNo#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.manufacturerID#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.importerID#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.modelID#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.DCL#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.sbtpliadclrStatus#">
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
    
    <cffunction name="updateSign" access="public" returntype="struct">
    <cfargument name="ID" type="numeric" required="yes">
    <cfargument name="IDList" type="string" required="yes">
    <cfargument name="sbsSKU" type="string" required="yes">
    <cfargument name="sbsName" type="string" required="yes">
    <cfargument name="sbsMFGCode" type="string" required="yes">
    <cfargument name="sbsPriceOriginal" type="string" required="yes">
    <cfargument name="deptNo" type="numeric" required="yes">
    <cfargument name="userID" type="numeric" required="yes">
    <cfargument name="sbstID" type="numeric" required="yes">
    <cfargument name="sbsStatus" type="numeric" required="yes">
    <!---Relationship arguments.--->
    <cfargument name="sbstplID" type="numeric" required="yes">
    <cfargument name="sbtplatdrCount" type="numeric" required="yes">
    <cfargument name="sbsGroupCount" type="string" required="yes">
    <cfset result.message = "You have successfully updated the record.">
    <cftry>
    <!---Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.app.sign_builder.SignBuilder"
    method="getSign"
    returnvariable="getCheckSignRet">
    <cfinvokeargument name="excludeID" value="#ARGUMENTS.IDList#"/>
    <cfinvokeargument name="sbsSKU" value="#ARGUMENTS.sbsSKU#"/>
    <cfinvokeargument name="sbsName" value="#ARGUMENTS.sbsName#"/>
    <cfinvokeargument name="deptNo" value="#ARGUMENTS.deptNo#"/>
    <cfinvokeargument name="sbsStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckSignRet.recordcount NEQ 0>
    <cfset result.message = "The SKU #ARGUMENTS.sbsSKU# already exists, please enter a new SKU.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_sb_sign SET
    sbsSKU = <cfqueryparam cfsqltype="cf_sql_varchar" value="#Iif(ARGUMENTS.sbsSKU EQ 1, DE(ARGUMENTS.sbsName), DE(ARGUMENTS.sbsSKU))#">,
    sbsName = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.sbsName#">,
    sbsMFGCode = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.sbsMFGCode#">,
    sbsPriceOriginal = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.sbsPriceOriginal#">,
    deptNo = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.deptNo#">,
    userID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.userID#">,
    sbstID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.sbstID#">,
    sbsStatus = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.sbsStatus#">
    WHERE ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ID#">
    </cfquery>
    </cftransaction>
    <!---Delete any values first.--->
    <cfinvoke 
    component="MCMS.component.app.sign_builder.SignBuilder"
    method="deleteSignTemplateAttributeDepartmentRel"
    returnvariable="deleteSignTemplateAttributeDepartmentRelRet">
    <cfinvokeargument name="sbsID" value="#ARGUMENTS.ID#"/>
    </cfinvoke>
    <!---Insert sign attribute values.--->
    <cfloop index="i" from="1" to="#ARGUMENTS.sbtplatdrCount#">
    <cfinvoke 
    component="MCMS.component.app.sign_builder.SignBuilder"
    method="insertSignTemplateAttributeDepartmentRel"
    returnvariable="insertSignTemplateAttributeDepartmentRelRet">
    <cfinvokeargument name="sbsID" value="#ARGUMENTS.ID#"/>
    <cfinvokeargument name="sbtplatdrID" value="#Evaluate('form.sbtplatdrID#i#')#"/>
    <cfinvokeargument name="sbstpladrValue" value="#Evaluate('form.sbstpladrValue#i#')#"/>
    <cfinvokeargument name="sbstpladrSort" value="#Evaluate('form.sbstpladrSort#i#')#"/>
    <cfinvokeargument name="sbstpladrStatus" value="1"/>
    </cfinvoke>
    </cfloop>
    <!---Insert SKUs for group sign if applicable.--->
    <cfif ARGUMENTS.sbstID EQ 2>
    <!---Delete any values first.--->
    <cfinvoke 
    component="MCMS.component.app.sign_builder.SignBuilder"
    method="deleteSignSkuRel"
    returnvariable="deleteSignSkuRelRet">
    <cfinvokeargument name="sbsID" value="#ARGUMENTS.ID#"/>
    </cfinvoke>
    <cfloop index="ig" from="1" to="#ARGUMENTS.sbsGroupCount#">
    <cfif Evaluate('form.sbsSKUGroup#ig#') NEQ ''>
    <cfinvoke 
    component="MCMS.component.app.sign_builder.SignBuilder"
    method="insertSignSkuRel"
    returnvariable="result">
    <cfinvokeargument name="sbsID" value="#ARGUMENTS.ID#"/>
    <cfinvokeargument name="sbsIDRel" value="#Evaluate('form.sbsSKUGroup#ig#')#"/>
    <cfinvokeargument name="sbssrSort" value="#Evaluate('form.sbssrSort#ig#')#"/>
    <cfinvokeargument name="sbssrStatus" value="1"/>
    </cfinvoke>
    </cfif>
    </cfloop>
    </cfif>
    </cfif>
    <cfcatch type="any">
    <cfset result.message = "There was an error updating the record.">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="updateSignQRCode" access="public" returntype="struct">
    <cfargument name="ID" type="numeric" required="yes">
    <cfargument name="sbsqrcURL" type="string" required="yes">
    <cfargument name="sbsqrcStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully updated the record.">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_sb_sign_qr_code SET
    sbsqrcURL = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.sbsqrcURL#">,
    sbsqrcStatus = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.sbsqrcStatus#">
    WHERE ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ID#">
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error updating the record.">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="updateTemplateAttributeCSS" access="public" returntype="struct">
    <cfargument name="ID" type="numeric" required="yes">
    <cfargument name="sbstplID" type="numeric" required="yes">
    <cfargument name="sbtplatID" type="numeric" required="yes">
    <cfargument name="deptNo" type="numeric" required="yes">
    <cfargument name="sbstID" type="numeric" required="yes">
    <cfargument name="sbtplacFont" type="string" required="yes">
    <cfargument name="sbtplacFontSize" type="numeric" required="yes">
    <cfargument name="sbtplacFontWeight" type="string" required="yes">
    <cfargument name="sbtplacFontColor" type="string" required="yes">
    <cfargument name="sbtplacFontLength" type="numeric" required="yes">
    <cfargument name="sbtplacFontAlign" type="string" required="yes">
    <cfargument name="sbtplacStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully updated the record.">
    <cftry>
    <!---Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.app.sign_builder.SignBuilder"
    method="getTemplateAttributeCSS"
    returnvariable="getCheckTemplateAttributeCSSRet">
    <cfinvokeargument name="excludeID" value="#ARGUMENTS.ID#"/>
    <cfinvokeargument name="sbstplID" value="#ARGUMENTS.sbstplID#"/>
    <cfinvokeargument name="sbtplatID" value="#ARGUMENTS.sbtplatID#"/>
    <cfinvokeargument name="deptNo" value="#ARGUMENTS.deptNo#"/>
    <cfinvokeargument name="sbstID" value="#ARGUMENTS.sbstID#"/>
    <cfinvokeargument name="sbtplatdrStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckTemplateAttributeCSSRet.recordcount NEQ 0>
    <cfset result.message = "The style already exists for this template, attribute, and department, please try again.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_sb_template_attribute_css SET
	sbstplID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.sbstplID#">,
    sbtplatID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.sbtplatID#">,
    deptNo = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.deptNo#">,
    sbstID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.sbstID#">,
    sbtplacFont = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.sbtplacFont#">,
    sbtplacFontSize = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.sbtplacFontSize#">,
    sbtplacFontWeight = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.sbtplacFontWeight#">,
    sbtplacFontColor = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.sbtplacFontColor#">,
    sbtplacFontLength = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.sbtplacFontLength#">,
    sbtplacFontAlign = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.sbtplacFontAlign#">,
    sbtplacStatus = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.sbtplacStatus#">
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
    
    <cffunction name="updateSignType" access="public" returntype="struct">
    <cfargument name="ID" type="numeric" required="yes">
    <cfargument name="sbstName" type="string" required="yes">
    <cfargument name="sbstDescription" type="string" required="yes">
    <cfargument name="sbstSort" type="numeric" required="yes">
    <cfargument name="sbstStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully updated the record.">
    <cftry>
    <!---Check for profanity in the text.--->
    <cfinvoke 
    component="MCMS.component.utility.Regex"
    method="regexProfanity"
    returnvariable="regexProfanityRet">
    <cfinvokeargument name="profanityString" value="#ARGUMENTS.sbstDescription#"/>
    </cfinvoke>
    <!---Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.app.sign_builder.SignBuilder"
    method="getSignType"
    returnvariable="getCheckSignTypeRet">
    <cfinvokeargument name="excludeID" value="#ARGUMENTS.ID#"/>
    <cfinvokeargument name="sbstName" value="#ARGUMENTS.sbstName#"/>
    <cfinvokeargument name="sbstStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckSignTypeRet.recordcount NEQ 0>
    <cfset result.message = "The name #ARGUMENTS.sbstName# already exists, please enter a new name.">
    <cfelseif regexProfanityRet CONTAINS '$%&*!'>
    <cfset result.message = "Some text contained profanity, please remove any profanity from your text.">
    <!---Check length restriction.--->
    <cfelseif LEN(ARGUMENTS.sbstDescription) GT 1024>
    <cfset result.message = "The description is longer than 1024 characters, please enter a new description under 1024 characters.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_sb_sign_type SET
    sbstName = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.sbstName#">,
    sbstDescription = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.sbstDescription#">,
    sbstSort = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.sbstSort#">,
    sbstStatus = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.sbstStatus#">
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
    
    <cffunction name="updateSignTemplate" access="public" returntype="struct">
    <cfargument name="ID" type="numeric" required="yes">
    <cfargument name="sbstplName" type="string" required="yes">
    <cfargument name="sbstplDescription" type="string" required="yes">
    <cfargument name="sbstplFormatUnit" type="string" required="yes">
    <cfargument name="sbstplFormatOrientation" type="string" required="yes">
    <cfargument name="sbstplFormatPageType" type="string" required="yes">
    <cfargument name="sbstplWidth" type="numeric" required="yes">
    <cfargument name="sbstplHeight" type="numeric" required="yes">
    <cfargument name="sbstplMargin" type="numeric" required="yes">
    <cfargument name="sbstplCellWidth" type="numeric" required="yes">
    <cfargument name="sbstplCellHeight" type="numeric" required="yes">
    <cfargument name="sbstplCellCount" type="numeric" required="yes">
    <cfargument name="sbstplCellColumnCount" type="numeric" required="yes">
    <cfargument name="sbstplMaxRow" type="numeric" required="yes">
    <cfargument name="sbstplCellVAlign" type="string" required="yes">
    <cfargument name="sbstplLogo" type="string" required="yes">
    <cfargument name="sbstplTemplateImage" type="string" required="yes">
    <cfargument name="sbstplStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully updated the record.">
    <cftry>
	<!---Check for profanity in the text.--->
    <cfinvoke 
    component="MCMS.component.utility.Regex"
    method="regexProfanity"
    returnvariable="regexProfanityRet">
    <cfinvokeargument name="profanityString" value="#ARGUMENTS.sbstplDescription#"/>
    </cfinvoke>
    <!---Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.app.sign_builder.SignBuilder"
    method="getSignTemplate"
    returnvariable="getCheckSignTemplateRet">
    <cfinvokeargument name="excludeID" value="#ARGUMENTS.ID#"/>
    <cfinvokeargument name="sbstplName" value="#ARGUMENTS.sbstplName#"/>
    <cfinvokeargument name="sbstplStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckSignTemplateRet.recordcount NEQ 0>
    <cfset result.message = "The name #ARGUMENTS.sbstplName# already exists, please enter a new name.">
    <cfelseif regexProfanityRet CONTAINS '$%&*!'>
    <cfset result.message = "Some text contained profanity, please remove any profanity from your text.">
    <!---Check length restriction.--->
    <cfelseif LEN(ARGUMENTS.sbstplDescription) GT 1024>
    <cfset result.message = "The description is longer than 1024 characters, please enter a new description under 1024 characters.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_sb_sign_template SET
    sbstplName = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.sbstplName#">,
    sbstplDescription = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.sbstplDescription#">,
    sbstplFormatUnit = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.sbstplFormatUnit#">,
    sbstplFormatOrientation = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.sbstplFormatOrientation#">,
    sbstplFormatPageType = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.sbstplFormatPageType#">,
    sbstplWidth = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.sbstplWidth#">,
    sbstplHeight = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.sbstplHeight#">,
    sbstplMargin = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.sbstplMargin#">,
    sbstplCellWidth = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.sbstplCellWidth#">,
    sbstplCellHeight = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.sbstplCellHeight#">,
    sbstplCellCount = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.sbstplCellCount#">,
    sbstplCellColumnCount = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.sbstplCellColumnCount#">,
    sbstplMaxRow = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.sbstplMaxRow#">,
    sbstplCellVAlign = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.sbstplCellVAlign#">,
    sbstplLogo = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.sbstplLogo#">,
    sbstplTemplateImage = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.sbstplTemplateImage#">,
    sbstplStatus = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.sbstplStatus#">
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
    
    <cffunction name="updateTemplateAttributeTypeDepartmentRel" access="public" returntype="struct">
    <cfargument name="ID" type="numeric" required="yes">
    <cfargument name="sbstplID" type="numeric" required="yes">
    <cfargument name="sbtplatID" type="numeric" required="yes">
    <cfargument name="deptNo" type="numeric" required="yes">
    <cfargument name="sbstID" type="numeric" required="yes">
    <cfargument name="sbtplatdrRequired" type="numeric" required="yes">
    <cfargument name="sbtplatdrStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully updated the record.">
    <cftry>
    <!---Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.app.sign_builder.SignBuilder"
    method="getTemplateAttributeTypeDepartmentRel"
    returnvariable="getCheckTemplateAttributeTypeDepartmentRelRet">
    <cfinvokeargument name="excludeID" value="#ARGUMENTS.ID#"/>
    <cfinvokeargument name="sbstplID" value="#ARGUMENTS.sbstplID#"/>
    <cfinvokeargument name="sbtplatID" value="#ARGUMENTS.sbtplatID#"/>
    <cfinvokeargument name="deptNo" value="#ARGUMENTS.deptNo#"/>
    <cfinvokeargument name="sbstID" value="#ARGUMENTS.sbstID#"/>
    <cfinvokeargument name="sbtplatdrStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckTemplateAttributeTypeDepartmentRelRet.recordcount NEQ 0>
    <cfset result.message = "The attribute already exists for this template and department, please try again.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_sb_tpl_attr_type_dept_rel SET
	sbstplID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.sbstplID#">,
    sbtplatID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.sbtplatID#">,
    deptNo = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.deptNo#">,
    sbstID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.sbstID#">,
    sbtplatdrRequired = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.sbtplatdrRequired#">,
    sbtplatdrStatus = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.sbtplatdrStatus#">
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
    
    <cffunction name="updateTemplateItemAttributeDCLRel" access="public" returntype="struct">
    <cfargument name="ID" type="numeric" required="yes">
    <cfargument name="sbstplID" type="numeric" required="yes">
    <cfargument name="deptNo" type="numeric" required="yes">
    <cfargument name="manufacturerID" type="string" required="yes">
    <cfargument name="importerID" type="string" required="yes">
    <cfargument name="modelID" type="string" required="yes">
    <cfargument name="DCL" type="string" required="yes">
    <cfargument name="sbtpliadclrStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully updated the record.">
    <cftry>
    <!---Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.app.sign_builder.SignBuilder"
    method="getTemplateItemAttributeDCLRel"
    returnvariable="getCheckTemplateItemAttributeDCLRelRet">
    <cfinvokeargument name="excludeID" value="#ARGUMENTS.ID#"/>
    <cfinvokeargument name="sbstplID" value="#ARGUMENTS.sbstplID#"/>
    <cfinvokeargument name="deptNo" value="#ARGUMENTS.deptNo#"/>
    <cfinvokeargument name="sbtpliadclrStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckTemplateItemAttributeDCLRelRet.recordcount NEQ 0>
    <cfset result.message = "An attribute already exists for this template and department, please try again.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_sb_tpl_item_attr_dcl_rel SET
	sbstplID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.sbstplID#">,
    deptNo = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.deptNo#">,
    manufacturerID = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.manufacturerID#">,
    importerID = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.importerID#">,
    modelID = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.modelID#">,
    DCL = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.DCL#">,
    sbtpliadclrStatus = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.sbtpliadclrStatus#">
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
    
    <cffunction name="updateSignList" access="public" returntype="struct">
    <cfargument name="ID" type="numeric" required="yes">
    <cfargument name="sbsStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully updated the records.">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_sb_sign SET
    sbsStatus = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.sbsStatus#">
    WHERE ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ID#">
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error updating the records.">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="updateSignQRCodeList" access="public" returntype="struct">
    <cfargument name="ID" type="numeric" required="yes">
    <cfargument name="sbsqrcStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully updated the records.">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_sb_sign_qr_code SET
    sbsqrcStatus = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.sbsqrcStatus#">
    WHERE ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ID#">
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error updating the records.">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="updateSignTypeList" access="public" returntype="struct">
    <cfargument name="ID" type="numeric" required="yes">
    <cfargument name="sbstStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully updated the records.">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_sb_sign_type SET
    sbstStatus = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.sbstStatus#">
    WHERE ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ID#">
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error updating the records.">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="updateSignTemplateList" access="public" returntype="struct">
    <cfargument name="ID" type="numeric" required="yes">
    <cfargument name="sbstplStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully updated the records.">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_sb_sign_template SET
    sbstplStatus = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.sbstplStatus#">
    WHERE ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ID#">
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error updating the records.">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="updateTemplateAttributeTypeDepartmentRelList" access="public" returntype="struct">
    <cfargument name="ID" type="numeric" required="yes">
    <cfargument name="sbtplatdrStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully updated the records.">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_sb_tpl_attr_type_dept_rel SET
    sbtplatdrStatus = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.sbtplatdrStatus#">
    WHERE ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ID#">
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error updating the records.">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="updateTemplateItemAttributeDCLRelList" access="public" returntype="struct">
    <cfargument name="ID" type="numeric" required="yes">
    <cfargument name="sbtpliadclrStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully updated the records.">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_sb_tpl_item_attr_dcl_rel SET
    sbtpliadclrStatus = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.sbtpliadclrStatus#">
    WHERE ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ID#">
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error updating the records.">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="updateTemplateAttributeCSSList" access="public" returntype="struct">
    <cfargument name="ID" type="numeric" required="yes">
    <cfargument name="sbtplacStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully updated the records.">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_sb_template_attribute_css SET
    sbtplacStatus = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.sbtplacStatus#">
    WHERE ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ID#">
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error updating the records.">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="deleteSign" access="public" returntype="struct">
    <cfargument name="ID" type="string" required="yes">
    <cfset result.message = "You have successfully deleted the record(s). #ARGUMENTS.ID#">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    DELETE FROM tbl_sb_sign
    WHERE ID IN (<cfqueryparam cfsqltype="cf_sql_integer" list="yes" value="#ARGUMENTS.ID#">)
    </cfquery>
    </cftransaction>
    <cfinvoke 
    component="MCMS.component.app.sign_builder.SignBuilder"
    method="deleteSignQRCode"
    returnvariable="result">
    <cfinvokeargument name="sbsID" value="#ARGUMENTS.ID#"/>
    </cfinvoke>
    <cfinvoke 
    component="MCMS.component.app.sign_builder.SignBuilder"
    method="deleteSignTemplateRel"
    returnvariable="result">
    <cfinvokeargument name="sbsID" value="#ARGUMENTS.ID#"/>
    </cfinvoke>
    <cfinvoke 
    component="MCMS.component.app.sign_builder.SignBuilder"
    method="deleteSignSkuRel"
    returnvariable="deleteSignSkuRelRet">
    <cfinvokeargument name="sbsID" value="#ARGUMENTS.ID#"/>
    </cfinvoke>
    <cfinvoke 
    component="MCMS.component.app.sign_builder.SignBuilder"
    method="deleteSignTemplateAttributeDepartmentRel"
    returnvariable="deleteSignTemplateAttributeDepartmentRelRet">
    <cfinvokeargument name="sbsID" value="#ARGUMENTS.ID#"/>
    </cfinvoke>
    <cfcatch type="any">
    <cfset result.message = "There was an error deleting the record(s).">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="updateSignUserDepartment" access="public" returntype="struct">
    <cfargument name="currentUserID" type="numeric" required="yes">
    <cfargument name="deptNo" type="numeric" required="yes">
    <cfargument name="newUserID" type="numeric" required="yes">
    <cfset result.message = "You have successfully updated the record(s).">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_sb_sign SET
    userID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.newUserID#">
    WHERE userID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.currentUserID#">
    AND deptNo = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.deptNo#">
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error updating the record.">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="deleteSignQRCode" access="public" returntype="struct">
    <cfargument name="ID" type="string" required="yes" default="0">
    <cfargument name="sbsID" type="string" required="yes" default="0">
    <cfset result.message = "You have successfully deleted the record(s). #ARGUMENTS.ID#">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    DELETE FROM tbl_sb_sign_qr_code
    WHERE ID IN (<cfqueryparam cfsqltype="cf_sql_integer" list="yes" value="#ARGUMENTS.ID#">)
    OR sbsID IN (<cfqueryparam cfsqltype="cf_sql_integer" list="yes" value="#ARGUMENTS.sbsID#">)
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error deleting the record(s).">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction> 
    
    <cffunction name="deleteSignSkuRel" access="public" returntype="struct">
    <cfargument name="ID" type="string" required="yes" default="0">
    <cfargument name="sbsID" type="string" required="yes" default="0">
    <cfset result.message = "You have successfully deleted the record(s).">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    DELETE FROM tbl_sb_sign_sku_rel
    WHERE ID IN (<cfqueryparam cfsqltype="cf_sql_integer" list="yes" value="#ARGUMENTS.ID#">)
    OR sbsID IN (<cfqueryparam cfsqltype="cf_sql_integer" list="yes" value="#ARGUMENTS.sbsID#">)
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error deleting the record(s).">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="deleteSignType" access="public" returntype="struct">
    <cfargument name="ID" type="string" required="yes">
    <cfset result.message = "You have successfully deleted the record(s).">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    DELETE FROM tbl_sb_sign_type
    WHERE ID IN (<cfqueryparam cfsqltype="cf_sql_integer" list="yes" value="#ARGUMENTS.ID#">)
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error deleting the record(s).">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="deleteSignTemplate" access="public" returntype="struct">
    <cfargument name="ID" type="string" required="yes">
    <cfset result.message = "You have successfully deleted the record(s).">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    DELETE FROM tbl_sb_sign_template
    WHERE ID IN (<cfqueryparam cfsqltype="cf_sql_integer" list="yes" value="#ARGUMENTS.ID#">)
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error deleting the record(s).">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="deleteSignTemplateRel" access="public" returntype="struct">
    <cfargument name="ID" type="string" required="yes" default="0">
    <cfargument name="sbsID" type="string" required="yes" default="0">
    <cfset result.message = "You have successfully deleted the record(s). #ARGUMENTS.sbsID#">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    DELETE FROM tbl_sb_sign_template_rel
    WHERE ID IN (<cfqueryparam cfsqltype="cf_sql_integer" list="yes" value="#ARGUMENTS.ID#">)
    OR sbsID IN (<cfqueryparam cfsqltype="cf_sql_integer" list="yes" value="#ARGUMENTS.sbsID#">)
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error deleting the record(s).">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction> 
    
    <cffunction name="deleteTemplateAttribute" access="public" returntype="struct">
    <cfargument name="ID" type="string" required="yes">
    <cfset result.message = "You have successfully deleted the record(s).">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    DELETE FROM tbl_sb_template_attribute
    WHERE ID IN (<cfqueryparam cfsqltype="cf_sql_integer" list="yes" value="#ARGUMENTS.ID#">)
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error deleting the record(s).">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="deleteTemplateAttributeType" access="public" returntype="struct">
    <cfargument name="ID" type="string" required="yes">
    <cfset result.message = "You have successfully deleted the record(s).">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    DELETE FROM tbl_sb_template_attribute_type
    WHERE ID IN (<cfqueryparam cfsqltype="cf_sql_integer" list="yes" value="#ARGUMENTS.ID#">)
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error deleting the record(s).">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="deleteSignTemplateAttributeDepartmentRel" access="public" returntype="struct">
    <cfargument name="ID" type="string" required="yes" default="0">
    <cfargument name="sbsID" type="string" required="yes" default="0">
    <cfset result.message = "You have successfully deleted the record(s).">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    DELETE FROM tbl_sb_sign_tpl_attr_dept_rel
    WHERE ID IN (<cfqueryparam cfsqltype="cf_sql_integer" list="yes" value="#ARGUMENTS.ID#">)
    OR sbsID IN (<cfqueryparam cfsqltype="cf_sql_integer" list="yes" value="#ARGUMENTS.sbsID#">)
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error deleting the record(s).">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction> 
    
    <cffunction name="deleteTemplateAttributeTypeDepartmentRel" access="public" returntype="struct">
    <cfargument name="ID" type="string" required="yes">
    <cfset result.message = "You have successfully deleted the record(s).">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    DELETE FROM tbl_sb_tpl_attr_type_dept_rel
    WHERE ID IN (<cfqueryparam cfsqltype="cf_sql_integer" list="yes" value="#ARGUMENTS.ID#">)
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error deleting the record(s).">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="deleteTemplateItemAttributeDCLRel" access="public" returntype="struct">
    <cfargument name="ID" type="string" required="yes">
    <cfset result.message = "You have successfully deleted the record(s).">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    DELETE FROM tbl_sb_tpl_item_attr_dcl_rel
    WHERE ID IN (<cfqueryparam cfsqltype="cf_sql_integer" list="yes" value="#ARGUMENTS.ID#">)
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error deleting the record(s).">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>  
    
    <cffunction name="deleteTemplateAttributeCSS" access="public" returntype="struct">
    <cfargument name="ID" type="string" required="yes">
    <cfset result.message = "You have successfully deleted the record(s).">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    DELETE FROM tbl_sb_template_attribute_css
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