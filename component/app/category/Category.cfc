<cfcomponent>
    <cffunction name="getCategory" access="public" returntype="query" hint="Get Category data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="ID" type="numeric" required="yes" default="0">
    <cfargument name="excludeID" type="numeric" required="yes" default="0">
    <cfargument name="catNo" type="string" required="yes" default="">
    <cfargument name="catCode" type="string" required="yes" default="">
    <cfargument name="catERPCode" type="string" required="yes" default="">
    <cfargument name="catPOSCode" type="string" required="yes" default="">
    <cfargument name="catName" type="string" required="yes" default="">
    <cfargument name="cesID" type="string" required="yes" default="0">
    <cfargument name="catStatus" type="string" required="yes" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="catName">
    <cfset var rsCategory = "">
    <cftry>
    <cfquery name="rsCategory" datasource="#application.mcmsDSN#">
    SELECT * FROM v_category WHERE 0=0
    <cfif ARGUMENTS.ID NEQ 0>
    AND ID = <cfqueryparam value="#ARGUMENTS.ID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.excludeID NEQ 0>
    AND ID <> <cfqueryparam value="#ARGUMENTS.excludeID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(catName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(catDescription) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">)
    </cfif>
    <cfif ARGUMENTS.catNo NEQ ''>
    AND UPPER(catNo) = <cfqueryparam value="#UCASE(ARGUMENTS.catNo)#" cfsqltype="cf_sql_varchar">
    </cfif>
    <cfif ARGUMENTS.catCode NEQ ''>
    AND UPPER(catCode) = <cfqueryparam value="#UCASE(ARGUMENTS.catCode)#" cfsqltype="cf_sql_varchar">
    </cfif>
    <cfif ARGUMENTS.catERPCode NEQ ''>
    AND UPPER(catERPCode) = <cfqueryparam value="#UCASE(ARGUMENTS.catERPCode)#" cfsqltype="cf_sql_varchar">
    </cfif>
    <cfif ARGUMENTS.catPOSCode NEQ ''>
    AND UPPER(catPOSCode) = <cfqueryparam value="#UCASE(ARGUMENTS.catPOSCode)#" cfsqltype="cf_sql_varchar">
    </cfif>
    <cfif ARGUMENTS.catName NEQ "">
    AND UPPER(catName) = <cfqueryparam value="#UCASE(ARGUMENTS.catName)#" cfsqltype="cf_sql_varchar">
    </cfif>
    <cfif ARGUMENTS.cesID NEQ 0>
    AND cesID IN (<cfqueryparam value="#ARGUMENTS.cesID#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    AND catStatus IN (<cfqueryparam value="#ARGUMENTS.catStatus#" list="yes" cfsqltype="cf_sql_integer">)
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsCategory = StructNew()>
    <cfset rsCategory.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsCategory>
    </cffunction>
    
    <cffunction name="getCategoryMegaMenu" access="public" returntype="query" hint="Get Category Mega Menu data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="ID" type="string" required="yes" default="0">
    <cfargument name="excludeID" type="numeric" required="yes" default="0">
    <cfargument name="cmmName" type="string" required="yes" default="">
    <cfargument name="catID" type="numeric" required="yes" default="0">
    <cfargument name="catDateRel" type="string" required="yes" default="">
    <cfargument name="catDateExp" type="string" required="yes" default="">
    <cfargument name="cmmDateRel" type="string" required="yes" default="">
    <cfargument name="cmmDateExp" type="string" required="yes" default="">
    <cfargument name="cmmStatus" type="string" required="yes" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="cmmName">
    <cfset var rsCategoryMegaMenu = "" >
    <cftry>
    <cfquery name="rsCategoryMegaMenu" datasource="#application.mcmsDSN#">
    SELECT * FROM v_category_mega_menu WHERE 0=0
    <cfif ARGUMENTS.ID NEQ 0>
    AND ID IN (<cfqueryparam value="#ARGUMENTS.ID#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    <cfif ARGUMENTS.excludeID NEQ 0>
    AND ID <> <cfqueryparam value="#ARGUMENTS.excludeID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(catName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(catDescription) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(catNo) = <cfqueryparam value="#UCASE(ARGUMENTS.keywords)#" cfsqltype="cf_sql_varchar">)
    </cfif>
    <cfif ARGUMENTS.catID NEQ 0>
    AND catID = <cfqueryparam value="#ARGUMENTS.catID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.cmmName NEQ "">
    AND UPPER(cmmName) = <cfqueryparam value="#UCASE(ARGUMENTS.cmmName)#" cfsqltype="cf_sql_varchar">
    </cfif>
    <cfif ARGUMENTS.cmmDateRel NEQ "">
    AND cmmDateRel <= <cfqueryparam value="#DateFormat(ARGUMENTS.cmmDateRel, application.dateFormat)#" cfsqltype="cf_sql_date"> 
    </cfif>
    <cfif ARGUMENTS.cmmDateExp NEQ "">
    AND cmmDateExp >= <cfqueryparam value="#DateFormat(ARGUMENTS.cmmDateExp, application.dateFormat)#" cfsqltype="cf_sql_date">
    </cfif>
    <cfif ARGUMENTS.catDateRel NEQ "">
    AND catDateRel <= <cfqueryparam value="#DateFormat(ARGUMENTS.catDateRel, application.dateFormat)#" cfsqltype="cf_sql_date"> 
    </cfif>
    <cfif ARGUMENTS.catDateExp NEQ "">
    AND catDateExp >= <cfqueryparam value="#DateFormat(ARGUMENTS.catDateExp, application.dateFormat)#" cfsqltype="cf_sql_date">
    </cfif>
    AND cmmStatus IN (<cfqueryparam value="#ARGUMENTS.cmmStatus#" list="yes" cfsqltype="cf_sql_integer">)
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsCategoryMegaMenu = StructNew()>
    <cfset rsCategoryMegaMenu.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsCategoryMegaMenu>
    </cffunction>
    
    <cffunction name="getCategoryMegaMenuRel" access="public" returntype="query" hint="Get Category Mega Menu Rel. data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="ID" type="string" required="yes" default="0">
    <cfargument name="excludeID" type="numeric" required="yes" default="0">
    <cfargument name="catName" type="string" required="yes" default="">
    <cfargument name="cmmName" type="string" required="yes" default="">
    <cfargument name="catID" type="numeric" required="yes" default="0">
    <cfargument name="cmmID" type="numeric" required="yes" default="0">
    <cfargument name="catDateRel" type="string" required="yes" default="">
    <cfargument name="catDateExp" type="string" required="yes" default="">
    <cfargument name="cmmDateRel" type="string" required="yes" default="">
    <cfargument name="cmmDateExp" type="string" required="yes" default="">
    <cfargument name="cmmrStatus" type="string" required="yes" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="catName">
    <cfset var rsCategoryMegaMenuRel = "" >
    <cftry>
    <cfquery name="rsCategoryMegaMenuRel" datasource="#application.mcmsDSN#">
    SELECT * FROM v_category_mega_menu_rel WHERE 0=0
    <cfif ARGUMENTS.ID NEQ 0>
    AND ID IN (<cfqueryparam value="#ARGUMENTS.ID#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    <cfif ARGUMENTS.excludeID NEQ 0>
    AND ID <> <cfqueryparam value="#ARGUMENTS.excludeID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(catName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(catDescription) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">)
    </cfif>
    <cfif ARGUMENTS.catID NEQ 0>
    AND catID = <cfqueryparam value="#ARGUMENTS.catID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.cmmID NEQ 0>
    AND cmmID = <cfqueryparam value="#ARGUMENTS.cmmID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.catName NEQ "">
    AND UPPER(catName) = <cfqueryparam value="#UCASE(ARGUMENTS.catName)#" cfsqltype="cf_sql_varchar">
    </cfif>
    <cfif ARGUMENTS.cmmName NEQ "">
    AND UPPER(cmmName) = <cfqueryparam value="#UCASE(ARGUMENTS.cmmName)#" cfsqltype="cf_sql_varchar">
    </cfif>
    <cfif ARGUMENTS.cmmDateRel NEQ "">
    AND cmmDateRel <= <cfqueryparam value="#DateFormat(ARGUMENTS.cmmDateRel, application.dateFormat)#" cfsqltype="cf_sql_date"> 
    </cfif>
    <cfif ARGUMENTS.cmmDateExp NEQ "">
    AND cmmDateExp >= <cfqueryparam value="#DateFormat(ARGUMENTS.cmmDateExp, application.dateFormat)#" cfsqltype="cf_sql_date">
    </cfif>
    <cfif ARGUMENTS.catDateRel NEQ "">
    AND catDateRel <= <cfqueryparam value="#DateFormat(ARGUMENTS.catDateRel, application.dateFormat)#" cfsqltype="cf_sql_date"> 
    </cfif>
    <cfif ARGUMENTS.catDateExp NEQ "">
    AND catDateExp >= <cfqueryparam value="#DateFormat(ARGUMENTS.catDateExp, application.dateFormat)#" cfsqltype="cf_sql_date">
    </cfif>
    AND cmmrStatus IN (<cfqueryparam value="#ARGUMENTS.cmmrStatus#" list="yes" cfsqltype="cf_sql_integer">)
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsCategoryMegaMenuRel = StructNew()>
    <cfset rsCategoryMegaMenuRel.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsCategoryMegaMenuRel>
    </cffunction>
    
    <cffunction name="getSecondaryCategory" access="public" returntype="query" hint="Get Secondary Category data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="ID" type="numeric" required="yes" default="0">
    <cfargument name="excludeID" type="numeric" required="yes" default="0">
    <cfargument name="scatNo" type="string" required="yes" default="">
    <cfargument name="scatCode" type="string" required="yes" default="">
    <cfargument name="scatERPCode" type="string" required="yes" default="">
    <cfargument name="scatPOSCode" type="string" required="yes" default="">
    <cfargument name="scatName" type="string" required="yes" default="">
    <cfargument name="cesID" type="string" required="yes" default="0">
    <cfargument name="scatStatus" type="string" required="yes" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="scatName">
    <cfset var rsSecondaryCategory = "" >
    <cftry>
    <cfquery name="rsSecondaryCategory" datasource="#application.mcmsDSN#">
    SELECT * FROM v_secondary_category WHERE 0=0
    <cfif ARGUMENTS.ID NEQ 0>
    AND ID = <cfqueryparam value="#ARGUMENTS.ID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.excludeID NEQ 0>
    AND ID <> <cfqueryparam value="#ARGUMENTS.excludeID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.scatNo NEQ ''>
    AND UPPER(scatNo) = <cfqueryparam value="#UCASE(ARGUMENTS.scatNo)#" cfsqltype="cf_sql_varchar">
    </cfif>
    <cfif ARGUMENTS.scatCode NEQ ''>
    AND UPPER(scatCode) = <cfqueryparam value="#UCASE(ARGUMENTS.scatCode)#" cfsqltype="cf_sql_varchar">
    </cfif>
    <cfif ARGUMENTS.scatERPCode NEQ ''>
    AND UPPER(scatERPCode) = <cfqueryparam value="#UCASE(ARGUMENTS.scatERPCode)#" cfsqltype="cf_sql_varchar">
    </cfif>
    <cfif ARGUMENTS.scatPOSCode NEQ ''>
    AND UPPER(scatPOSCode) = <cfqueryparam value="#UCASE(ARGUMENTS.scatPOSCode)#" cfsqltype="cf_sql_varchar">
    </cfif>
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(scatName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(scatDescription) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(scatNo) = <cfqueryparam value="#UCASE(ARGUMENTS.keywords)#" cfsqltype="cf_sql_varchar">)
    </cfif>
    <cfif ARGUMENTS.scatName NEQ "">
    AND UPPER(scatName) = <cfqueryparam value="#UCASE(ARGUMENTS.scatName)#" cfsqltype="cf_sql_varchar">
    </cfif>
    <cfif ARGUMENTS.cesID NEQ 0>
    AND cesID IN (<cfqueryparam value="#ARGUMENTS.cesID#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    AND scatStatus IN (<cfqueryparam value="#ARGUMENTS.scatStatus#" list="yes" cfsqltype="cf_sql_integer">)
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsSecondaryCategory = StructNew()>
    <cfset rsSecondaryCategory.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsSecondaryCategory>
    </cffunction>
    
    <cffunction name="getLineCategory" access="public" returntype="query" hint="Get Line Category data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="ID" type="numeric" required="yes" default="0">
    <cfargument name="excludeID" type="numeric" required="yes" default="0">
    <cfargument name="lcatNo" type="string" required="yes" default="">
    <cfargument name="lcatCode" type="string" required="yes" default="">
    <cfargument name="lcatERPCode" type="string" required="yes" default="">
    <cfargument name="lcatPOSCode" type="string" required="yes" default="">
    <cfargument name="lcatName" type="string" required="yes" default="">
    <cfargument name="cesID" type="string" required="yes" default="0">
    <cfargument name="lcatStatus" type="string" required="yes" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="lcatName">
    <cfset var rsLineCategory = "" >
    <cftry>
    <cfquery name="rsLineCategory" datasource="#application.mcmsDSN#">
    SELECT * FROM v_line_category WHERE 0=0
    <cfif ARGUMENTS.ID NEQ 0>
    AND ID = <cfqueryparam value="#ARGUMENTS.ID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.excludeID NEQ 0>
    AND ID <> <cfqueryparam value="#ARGUMENTS.excludeID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(lcatName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(lcatDescription) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(lcatNo) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">)
    </cfif>
    <cfif ARGUMENTS.lcatNo NEQ ''>
    AND UPPER(lcatNo) = <cfqueryparam value="#UCASE(ARGUMENTS.lcatNo)#" cfsqltype="cf_sql_varchar">
    </cfif>
    <cfif ARGUMENTS.lcatCode NEQ ''>
    AND UPPER(lcatCode) = <cfqueryparam value="#UCASE(ARGUMENTS.lcatCode)#" cfsqltype="cf_sql_varchar">
    </cfif>
    <cfif ARGUMENTS.lcatERPCode NEQ ''>
    AND UPPER(lcatERPCode) = <cfqueryparam value="#UCASE(ARGUMENTS.lcatERPCode)#" cfsqltype="cf_sql_varchar">
    </cfif>
    <cfif ARGUMENTS.lcatPOSCode NEQ ''>
    AND UPPER(lcatPOSCode) = <cfqueryparam value="#UCASE(ARGUMENTS.lcatPOSCode)#" cfsqltype="cf_sql_varchar">
    </cfif>
    <cfif ARGUMENTS.lcatName NEQ "">
    AND UPPER(lcatName) = <cfqueryparam value="#UCASE(ARGUMENTS.lcatName)#" cfsqltype="cf_sql_varchar">
    </cfif>
    <cfif ARGUMENTS.cesID NEQ 0>
    AND cesID IN (<cfqueryparam value="#ARGUMENTS.cesID#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    AND lcatStatus IN (<cfqueryparam value="#ARGUMENTS.lcatStatus#" list="yes" cfsqltype="cf_sql_integer">)
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsLineCategory = StructNew()>
    <cfset rsLineCategory.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsLineCategory>
    </cffunction>
    
    <cffunction name="getSecondaryLineCategory" access="public" returntype="query" hint="Get Secondary Line Category data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="ID" type="numeric" required="yes" default="0">
    <cfargument name="excludeID" type="numeric" required="yes" default="0">
    <cfargument name="slcatNo" type="string" required="yes" default="">
    <cfargument name="slcatCode" type="string" required="yes" default="">
    <cfargument name="slcatERPCode" type="string" required="yes" default="">
    <cfargument name="slcatPOSCode" type="string" required="yes" default="">
    <cfargument name="slcatName" type="string" required="yes" default="">
    <cfargument name="cesID" type="string" required="yes" default="0">
    <cfargument name="slcatStatus" type="string" required="yes" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="slcatName">
    <cfset var rsSecondaryLineCategory = "" >
    <cftry>
    <cfquery name="rsSecondaryLineCategory" datasource="#application.mcmsDSN#">
    SELECT * FROM v_sec_line_category WHERE 0=0
    <cfif ARGUMENTS.ID NEQ 0>
    AND ID = <cfqueryparam value="#ARGUMENTS.ID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.excludeID NEQ 0>
    AND ID <> <cfqueryparam value="#ARGUMENTS.excludeID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(slcatName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(slcatDescription) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(slcatNo) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">)
    </cfif>
    <cfif ARGUMENTS.slcatNo NEQ ''>
    AND UPPER(slcatNo) = <cfqueryparam value="#UCASE(ARGUMENTS.slcatNo)#" cfsqltype="cf_sql_varchar">
    </cfif>
    <cfif ARGUMENTS.slcatCode NEQ ''>
    AND UPPER(slcatCode) = <cfqueryparam value="#UCASE(ARGUMENTS.slcatCode)#" cfsqltype="cf_sql_varchar">
    </cfif>
    <cfif ARGUMENTS.slcatERPCode NEQ ''>
    AND UPPER(slcatERPCode) = <cfqueryparam value="#UCASE(ARGUMENTS.slcatERPCode)#" cfsqltype="cf_sql_varchar">
    </cfif>
    <cfif ARGUMENTS.slcatPOSCode NEQ ''>
    AND UPPER(slcatPOSCode) = <cfqueryparam value="#UCASE(ARGUMENTS.slcatPOSCode)#" cfsqltype="cf_sql_varchar">
    </cfif>
    <cfif ARGUMENTS.slcatName NEQ "">
    AND UPPER(slcatName) = <cfqueryparam value="#UCASE(ARGUMENTS.slcatName)#" cfsqltype="cf_sql_varchar">
    </cfif>
    <cfif ARGUMENTS.cesID NEQ 0>
    AND cesID IN (<cfqueryparam value="#ARGUMENTS.cesID#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    AND slcatStatus IN (<cfqueryparam value="#ARGUMENTS.slcatStatus#" list="yes" cfsqltype="cf_sql_integer">)
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsSecondaryLineCategory = StructNew()>
    <cfset rsSecondaryLineCategory.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsSecondaryLineCategory>
    </cffunction>
    
    <cffunction name="getCategorySecondaryCategoryRel" access="public" returntype="query" hint="Get Category Secondary Category Rel. data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="ID" type="numeric" required="yes" default="0">
    <cfargument name="excludeID" type="numeric" required="yes" default="0">
    <cfargument name="cID" type="string" required="yes" default="">
    <cfargument name="catID" type="string" required="yes" default="">
    <cfargument name="scatID" type="string" required="yes" default="">
    <cfargument name="catName" type="string" required="yes" default="">
    <cfargument name="scatName" type="string" required="yes" default="">
    <cfargument name="catStatus" type="string" required="yes" default="1,3">
    <cfargument name="scatStatus" type="string" required="yes" default="1,3">
    <cfargument name="cscrStatus" type="string" required="yes" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="scatSort,scatName">
    <cfset var rsCategorySecondaryCategoryRel = "" >
    <cftry>
    <cfquery name="rsCategorySecondaryCategoryRel" datasource="#application.mcmsDSN#">
    SELECT * FROM v_category_sec_category_rel WHERE 0=0
    <cfif ARGUMENTS.ID NEQ 0>
    AND ID = <cfqueryparam value="#ARGUMENTS.ID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.excludeID NEQ 0>
    AND ID <> <cfqueryparam value="#ARGUMENTS.excludeID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(catName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(scatName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">)
    </cfif>
    <cfif ARGUMENTS.cID NEQ "">
    AND cID IN (<cfqueryparam value="#ARGUMENTS.cID#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    <cfif ARGUMENTS.catID NEQ "">
    AND catID IN (<cfqueryparam value="#ARGUMENTS.catID#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    <cfif ARGUMENTS.scatID NEQ "">
    AND scatID IN (<cfqueryparam value="#ARGUMENTS.scatID#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    <cfif ARGUMENTS.catName NEQ "">
    AND UPPER(catName) = <cfqueryparam value="#UCASE(ARGUMENTS.catName)#" cfsqltype="cf_sql_varchar">
    </cfif>
    <cfif ARGUMENTS.scatName NEQ "">
    AND UPPER(scatName) = <cfqueryparam value="#UCASE(ARGUMENTS.scatName)#" cfsqltype="cf_sql_varchar">
    </cfif>
    AND catStatus IN (<cfqueryparam value="#ARGUMENTS.catStatus#" list="yes" cfsqltype="cf_sql_integer">)
    AND scatStatus IN (<cfqueryparam value="#ARGUMENTS.scatStatus#" list="yes" cfsqltype="cf_sql_integer">)
    AND cscrStatus IN (<cfqueryparam value="#ARGUMENTS.cscrStatus#" list="yes" cfsqltype="cf_sql_integer">)
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsCategorySecondaryCategoryRel = StructNew()>
    <cfset rsCategorySecondaryCategoryRel.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsCategorySecondaryCategoryRel>
    </cffunction>
    
    <cffunction name="getSecondaryCategoryLineCategoryRel" access="public" returntype="query" hint="Get Secondary Category Line Category Rel. data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="ID" type="numeric" required="yes" default="0">
    <cfargument name="excludeID" type="numeric" required="yes" default="0">
    <cfargument name="cID" type="string" required="yes" default="">
    <cfargument name="catID" type="string" required="yes" default="">
    <cfargument name="scatID" type="string" required="yes" default="">
    <cfargument name="lcatID" type="string" required="yes" default="">
    <cfargument name="catName" type="string" required="yes" default="">
    <cfargument name="scatName" type="string" required="yes" default="">
    <cfargument name="lcatName" type="string" required="yes" default="">
    <cfargument name="scatStatus" type="string" required="yes" default="1,3">
    <cfargument name="lcatStatus" type="string" required="yes" default="1,3">
    <cfargument name="sclcrStatus" type="string" required="yes" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="lcatSort,lcatName">
    <cfset var rsSecondaryCategoryLineCategoryRel = "" >
    <cftry>
    <cfquery name="rsSecondaryCategoryLineCategoryRel" datasource="#application.mcmsDSN#">
    SELECT * FROM v_sec_category_l_category_rel WHERE 0=0
    <cfif ARGUMENTS.ID NEQ 0>
    AND ID = <cfqueryparam value="#ARGUMENTS.ID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.excludeID NEQ 0>
    AND ID <> <cfqueryparam value="#ARGUMENTS.excludeID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(catName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(scatName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(lcatName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">)
    </cfif>
    <cfif ARGUMENTS.cID NEQ "">
    AND cID IN (<cfqueryparam value="#ARGUMENTS.cID#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    <cfif ARGUMENTS.catID NEQ "">
    AND catID IN (<cfqueryparam value="#ARGUMENTS.catID#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    <cfif ARGUMENTS.scatID NEQ "">
    AND scatID IN (<cfqueryparam value="#ARGUMENTS.scatID#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    <cfif ARGUMENTS.lcatID NEQ "">
    AND lcatID IN (<cfqueryparam value="#ARGUMENTS.lcatID#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    <cfif ARGUMENTS.catName NEQ "">
    AND UPPER(catName) = <cfqueryparam value="#UCASE(ARGUMENTS.catName)#" cfsqltype="cf_sql_varchar">
    </cfif>
    <cfif ARGUMENTS.scatName NEQ "">
    AND UPPER(scatName) = <cfqueryparam value="#UCASE(ARGUMENTS.scatName)#" cfsqltype="cf_sql_varchar">
    </cfif>
    <cfif ARGUMENTS.lcatName NEQ "">
    AND UPPER(lcatName) = <cfqueryparam value="#UCASE(ARGUMENTS.lcatName)#" cfsqltype="cf_sql_varchar">
    </cfif>
    AND scatStatus IN (<cfqueryparam value="#ARGUMENTS.scatStatus#" list="yes" cfsqltype="cf_sql_integer">)
    AND lcatStatus IN (<cfqueryparam value="#ARGUMENTS.lcatStatus#" list="yes" cfsqltype="cf_sql_integer">)
    AND sclcrStatus IN (<cfqueryparam value="#ARGUMENTS.sclcrStatus#" list="yes" cfsqltype="cf_sql_integer">)
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsSecondaryCategoryLineCategoryRel = StructNew()>
    <cfset rsSecondaryCategoryLineCategoryRel.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsSecondaryCategoryLineCategoryRel>
    </cffunction>
    
    <cffunction name="getLineCategorySecondaryLineCategoryRel" access="public" returntype="query" hint="Get Line Category Secondary Line Category Rel. data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="ID" type="numeric" required="yes" default="0">
    <cfargument name="excludeID" type="numeric" required="yes" default="0">
    <cfargument name="cID" type="string" required="yes" default="">
    <cfargument name="catID" type="string" required="yes" default="">
    <cfargument name="scatID" type="string" required="yes" default="">
    <cfargument name="lcatID" type="string" required="yes" default="">
    <cfargument name="slcatID" type="string" required="yes" default="">
    <cfargument name="catName" type="string" required="yes" default="">
    <cfargument name="scatName" type="string" required="yes" default="">
    <cfargument name="lcatName" type="string" required="yes" default="">
    <cfargument name="slcatName" type="string" required="yes" default="">
    <cfargument name="lcatStatus" type="string" required="yes" default="1,3">
    <cfargument name="slcatStatus" type="string" required="yes" default="1,3">
    <cfargument name="lcslcrStatus" type="string" required="yes" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="slcatName">
    <cfset var rsLineCategorySecondaryLineCategoryRel = "" >
    <cftry>
    <cfquery name="rsLineCategorySecondaryLineCategoryRel" datasource="#application.mcmsDSN#">
    SELECT * FROM v_line_category_slc_rel WHERE 0=0
    <cfif ARGUMENTS.ID NEQ 0>
    AND ID = <cfqueryparam value="#ARGUMENTS.ID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.excludeID NEQ 0>
    AND ID <> <cfqueryparam value="#ARGUMENTS.excludeID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(catName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(scatName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(lcatName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(slcatName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">)
    </cfif>
    <cfif ARGUMENTS.cID NEQ "">
    AND cID IN (<cfqueryparam value="#ARGUMENTS.cID#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    <cfif ARGUMENTS.catID NEQ "">
    AND catID IN (<cfqueryparam value="#ARGUMENTS.catID#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    <cfif ARGUMENTS.scatID NEQ "">
    AND scatID IN (<cfqueryparam value="#ARGUMENTS.scatID#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    <cfif ARGUMENTS.lcatID NEQ "">
    AND lcatID IN (<cfqueryparam value="#ARGUMENTS.lcatID#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    <cfif ARGUMENTS.slcatID NEQ "">
    AND slcatID IN (<cfqueryparam value="#ARGUMENTS.slcatID#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    <cfif ARGUMENTS.catName NEQ "">
    AND UPPER(catName) = <cfqueryparam value="#UCASE(ARGUMENTS.catName)#" cfsqltype="cf_sql_varchar">
    </cfif>
    <cfif ARGUMENTS.scatName NEQ "">
    AND UPPER(scatName) = <cfqueryparam value="#UCASE(ARGUMENTS.scatName)#" cfsqltype="cf_sql_varchar">
    </cfif>
    <cfif ARGUMENTS.lcatName NEQ "">
    AND UPPER(lcatName) = <cfqueryparam value="#UCASE(ARGUMENTS.lcatName)#" cfsqltype="cf_sql_varchar">
    </cfif>
    <cfif ARGUMENTS.slcatName NEQ "">
    AND UPPER(slcatName) = <cfqueryparam value="#UCASE(ARGUMENTS.slcatName)#" cfsqltype="cf_sql_varchar">
    </cfif>
    AND lcatStatus IN (<cfqueryparam value="#ARGUMENTS.lcatStatus#" list="yes" cfsqltype="cf_sql_integer">)
    AND slcatStatus IN (<cfqueryparam value="#ARGUMENTS.slcatStatus#" list="yes" cfsqltype="cf_sql_integer">)
    AND lcslcrStatus IN (<cfqueryparam value="#ARGUMENTS.lcslcrStatus#" list="yes" cfsqltype="cf_sql_integer">)
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsLineCategorySecondaryLineCategoryRel = StructNew()>
    <cfset rsLineCategorySecondaryLineCategoryRel.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsLineCategorySecondaryLineCategoryRel>
    </cffunction>
    
    <cffunction name="getCategoryDepartmentRel" access="public" returntype="query" hint="Get Category Department Rel. data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="ID" type="numeric" required="yes" default="0">
    <cfargument name="excludeID" type="numeric" required="yes" default="0">
    <cfargument name="cID" type="string" required="yes" default="">
    <cfargument name="catID" type="string" required="yes" default="0">
    <cfargument name="deptNo" type="string" required="yes" default="0">
    <cfargument name="catName" type="string" required="yes" default="">
    <cfargument name="cesID" type="string" required="yes" default="0">
    <cfargument name="catStatus" type="string" required="yes" default="1,2,3">
    <cfargument name="cdrStatus" type="string" required="yes" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="catName">
    <cfset var rsCategoryDepartmentRel = "" >
    <cftry>
    <cfquery name="rsCategoryDepartmentRel" datasource="#application.mcmsDSN#">
    SELECT * FROM v_category_department_rel WHERE 0=0
    <cfif ARGUMENTS.ID NEQ 0>
    AND ID = <cfqueryparam value="#ARGUMENTS.ID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.excludeID NEQ 0>
    AND ID <> <cfqueryparam value="#ARGUMENTS.excludeID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(catName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(catDescription) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(catNo) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">)
    </cfif>
    <cfif ARGUMENTS.cID NEQ "">
    AND cID IN (<cfqueryparam value="#ARGUMENTS.cID#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    <cfif ARGUMENTS.catID NEQ 0>
    AND catID IN (<cfqueryparam value="#ARGUMENTS.catID#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    <cfif ARGUMENTS.deptNo NEQ 0>
    AND deptNo IN (<cfqueryparam value="#ARGUMENTS.deptNo#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    <cfif ARGUMENTS.catName NEQ "">
    AND UPPER(catName) = <cfqueryparam value="#UCASE(ARGUMENTS.catName)#" cfsqltype="cf_sql_varchar">
    </cfif>
    <cfif ARGUMENTS.cesID NEQ 0>
    AND cesID IN (<cfqueryparam value="#ARGUMENTS.cesID#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    AND catStatus IN (<cfqueryparam value="#ARGUMENTS.catStatus#" list="yes" cfsqltype="cf_sql_integer">)
    AND cdrStatus IN (<cfqueryparam value="#ARGUMENTS.cdrStatus#" list="yes" cfsqltype="cf_sql_integer">)
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsCategoryDepartmentRel = StructNew()>
    <cfset rsCategoryDepartmentRel.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsCategoryDepartmentRel>
    </cffunction>
    
    <cffunction name="getSecondaryCategoryDepartmentRel" access="public" returntype="query" hint="Get Secondary Category Department Rel. data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="ID" type="numeric" required="yes" default="0">
    <cfargument name="excludeID" type="numeric" required="yes" default="0">
    <cfargument name="cID" type="string" required="yes" default="">
    <cfargument name="scatID" type="string" required="yes" default="">
    <cfargument name="deptNo" type="string" required="yes" default="0">
    <cfargument name="scatName" type="string" required="yes" default="">
    <cfargument name="cesID" type="string" required="yes" default="0">
    <cfargument name="scatStatus" type="string" required="yes" default="1,2,3">
    <cfargument name="scdrStatus" type="string" required="yes" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="scatName">
    <cfset var rsSecondaryCategoryDepartmentRel = "" >
    <cftry>
    <cfquery name="rsSecondaryCategoryDepartmentRel" datasource="#application.mcmsDSN#">
    SELECT * FROM v_sec_category_dept_rel WHERE 0=0
    <cfif ARGUMENTS.ID NEQ 0>
    AND ID = <cfqueryparam value="#ARGUMENTS.ID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.excludeID NEQ 0>
    AND ID <> <cfqueryparam value="#ARGUMENTS.excludeID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(scatName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(scatDescription) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(scatNo) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">)
    </cfif>
    <cfif ARGUMENTS.cID NEQ "">
    AND cID IN (<cfqueryparam value="#ARGUMENTS.cID#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
	<cfif ARGUMENTS.scatID NEQ "">
    AND scatID IN (<cfqueryparam value="#ARGUMENTS.scatID#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    <cfif ARGUMENTS.deptNo NEQ 0>
    AND deptNo IN (<cfqueryparam value="#ARGUMENTS.deptNo#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    <cfif ARGUMENTS.scatName NEQ "">
    AND UPPER(scatName) = <cfqueryparam value="#UCASE(ARGUMENTS.scatName)#" cfsqltype="cf_sql_varchar">
    </cfif>
    <cfif ARGUMENTS.cesID NEQ 0>
    AND cesID IN (<cfqueryparam value="#ARGUMENTS.cesID#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    AND scatStatus IN (<cfqueryparam value="#ARGUMENTS.scatStatus#" list="yes" cfsqltype="cf_sql_integer">)
    AND scdrStatus IN (<cfqueryparam value="#ARGUMENTS.scdrStatus#" list="yes" cfsqltype="cf_sql_integer">)
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsSecondaryCategoryDepartmentRel = StructNew()>
    <cfset rsSecondaryCategoryDepartmentRel.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsSecondaryCategoryDepartmentRel>
    </cffunction>
    
    <cffunction name="getLineCategoryDepartmentRel" access="public" returntype="query" hint="Get Line Category Department Rel. data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="ID" type="numeric" required="yes" default="0">
    <cfargument name="excludeID" type="numeric" required="yes" default="0">
    <cfargument name="cID" type="string" required="yes" default="">
    <cfargument name="lcatID" type="string" required="yes" default="">
    <cfargument name="deptNo" type="string" required="yes" default="0">
    <cfargument name="lcatName" type="string" required="yes" default="">
    <cfargument name="cesID" type="string" required="yes" default="0">
    <cfargument name="lcatStatus" type="string" required="yes" default="1,2,3">
    <cfargument name="lcdrStatus" type="string" required="yes" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="lcatName">
    <cfset var rsLineCategoryDepartmentRel = "" >
    <cftry>
    <cfquery name="rsLineCategoryDepartmentRel" datasource="#application.mcmsDSN#">
    SELECT * FROM v_line_category_dept_rel WHERE 0=0
    <cfif ARGUMENTS.ID NEQ 0>
    AND ID = <cfqueryparam value="#ARGUMENTS.ID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.excludeID NEQ 0>
    AND ID <> <cfqueryparam value="#ARGUMENTS.excludeID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(lcatName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(lcatDescription) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(lcatNo) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">)
    </cfif>
    <cfif ARGUMENTS.cID NEQ "">
    AND cID IN (<cfqueryparam value="#ARGUMENTS.cID#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
	<cfif ARGUMENTS.lcatID NEQ "">
    AND lcatID IN (<cfqueryparam value="#ARGUMENTS.lcatID#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    <cfif ARGUMENTS.deptNo NEQ 0>
    AND deptNo IN (<cfqueryparam value="#ARGUMENTS.deptNo#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    <cfif ARGUMENTS.lcatName NEQ "">
    AND UPPER(lcatName) = <cfqueryparam value="#UCASE(ARGUMENTS.lcatName)#" cfsqltype="cf_sql_varchar">
    </cfif>
    <cfif ARGUMENTS.cesID NEQ 0>
    AND cesID IN (<cfqueryparam value="#ARGUMENTS.cesID#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    AND lcatStatus IN (<cfqueryparam value="#ARGUMENTS.lcatStatus#" list="yes" cfsqltype="cf_sql_integer">)
    AND lcdrStatus IN (<cfqueryparam value="#ARGUMENTS.lcdrStatus#" list="yes" cfsqltype="cf_sql_integer">)
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsLineCategoryDepartmentRel = StructNew()>
    <cfset rsLineCategoryDepartmentRel.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsLineCategoryDepartmentRel>
    </cffunction>
    
    <cffunction name="getSecondaryLineCategoryDepartmentRel" access="public" returntype="query" hint="Get Line Secondary Category Department Rel. data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="ID" type="numeric" required="yes" default="0">
    <cfargument name="excludeID" type="numeric" required="yes" default="0">
    <cfargument name="cID" type="string" required="yes" default="">
    <cfargument name="slcatID" type="string" required="yes" default="">
    <cfargument name="deptNo" type="string" required="yes" default="0">
    <cfargument name="slcatName" type="string" required="yes" default="">
    <cfargument name="cesID" type="string" required="yes" default="0">
    <cfargument name="slcatStatus" type="string" required="yes" default="1,2,3">
    <cfargument name="slcdrStatus" type="string" required="yes" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="slcatName">
    <cfset var rsSecondaryLineCategoryDepartmentRel = "" >
    <cftry>
    <cfquery name="rsSecondaryLineCategoryDepartmentRel" datasource="#application.mcmsDSN#">
    SELECT * FROM v_sec_line_category_dept_rel WHERE 0=0
    <cfif ARGUMENTS.ID NEQ 0>
    AND ID = <cfqueryparam value="#ARGUMENTS.ID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.excludeID NEQ 0>
    AND ID <> <cfqueryparam value="#ARGUMENTS.excludeID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(slcatName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(slcatDescription) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(slcatNo) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">)
    </cfif>
    <cfif ARGUMENTS.cID NEQ "">
    AND cID IN (<cfqueryparam value="#ARGUMENTS.cID#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
	<cfif ARGUMENTS.slcatID NEQ "">
    AND slcatID IN (<cfqueryparam value="#ARGUMENTS.slcatID#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    <cfif ARGUMENTS.deptNo NEQ 0>
    AND deptNo IN (<cfqueryparam value="#ARGUMENTS.deptNo#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    <cfif ARGUMENTS.slcatName NEQ "">
    AND UPPER(slcatName) = <cfqueryparam value="#UCASE(ARGUMENTS.slcatName)#" cfsqltype="cf_sql_varchar">
    </cfif>
    <cfif ARGUMENTS.cesID NEQ 0>
    AND cesID IN (<cfqueryparam value="#ARGUMENTS.cesID#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    AND slcatStatus IN (<cfqueryparam value="#ARGUMENTS.slcatStatus#" list="yes" cfsqltype="cf_sql_integer">)
    AND slcdrStatus IN (<cfqueryparam value="#ARGUMENTS.slcdrStatus#" list="yes" cfsqltype="cf_sql_integer">)
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsSecondaryLineCategoryDepartmentRel = StructNew()>
    <cfset rsSecondaryLineCategoryDepartmentRel.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsSecondaryLineCategoryDepartmentRel>
    </cffunction>
    
    <cffunction name="getCategoryExportStatus" access="public" returntype="query" hint="Get Category Export Status data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="ID" type="string" required="yes" default="0">
    <cfargument name="excludeID" type="numeric" required="yes" default="0">
    <cfargument name="cesName" type="string" required="yes" default="">
    <cfargument name="cesStatus" type="string" required="yes" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="cesName">
    <cfset var rsCategoryExportStatus = "" >
    <cftry>
    <cfquery name="rsCategoryExportStatus" datasource="#application.mcmsDSN#">
    SELECT * FROM v_category_export_status WHERE 0=0
    <cfif ARGUMENTS.ID NEQ 0>
    AND ID IN (<cfqueryparam value="#ARGUMENTS.ID#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    <cfif ARGUMENTS.excludeID NEQ 0>
    AND ID <> <cfqueryparam value="#ARGUMENTS.excludeID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND UPPER(cesName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">
    </cfif>
    <cfif ARGUMENTS.cesName NEQ "">
    AND UPPER(cesName) = <cfqueryparam value="#UCASE(ARGUMENTS.cesName)#" cfsqltype="cf_sql_varchar">
    </cfif>
    AND cesStatus IN (<cfqueryparam value="#ARGUMENTS.cesStatus#" list="yes" cfsqltype="cf_sql_integer">)
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsCategoryExportStatus = StructNew()>
    <cfset rsCategoryExportStatus.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsCategoryExportStatus>
    </cffunction>
    
    <cffunction name="setCategoryID" access="public" returntype="string" hint="Set Category ID based on ID.">
    <cfset var categoryID = "" >
    <cftry>
    <!---Get the next category ID.--->
    <cfinvoke 
    component="MCMS.component.cms.Cms"
    method="getMaxValueSQL"
    returnvariable="catID">
    <cfinvokeargument name="tableName" value="tbl_category"/>
    </cfinvoke>
    <cfif catID NEQ ''>
    <cfset categoryID = application.categoryIDSeedPrefix & (application.categoryIDSeedNumber + catID + 1)>
    <cfelse>
    <cfset categoryID = application.categoryIDSeedPrefix & (application.categoryIDSeedNumber + 100 + 1)>
    </cfif>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset categoryID = StructNew()>
    <cfset categoryID.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn categoryID>
    </cffunction>
    
    <cffunction name="setSecondaryCategoryID" access="public" returntype="string" hint="Set Secondary Category ID based on ID.">
    <cfset var scategoryID = "" >
    <cftry>
    <!---Get the next category ID.--->
    <cfinvoke 
    component="MCMS.component.cms.Cms"
    method="getMaxValueSQL"
    returnvariable="scatID">
    <cfinvokeargument name="tableName" value="tbl_secondary_category"/>
    </cfinvoke>
    <cfif scatID NEQ ''>
    <cfset scategoryID = application.secondaryCategoryIDSeedPrefix & (application.secondaryCategoryIDSeedNumber + scatID + 1)>
    <cfelse>
    <cfset scategoryID = application.secondaryCategoryIDSeedPrefix & (application.secondaryCategoryIDSeedNumber + 100 + 1)>
    </cfif>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset scategoryID = StructNew()>
    <cfset scategoryID.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn scategoryID>
    </cffunction>
    
    <cffunction name="setLineCategoryID" access="public" returntype="string" hint="Set Line Category ID based on ID.">
    <cfset var lcategoryID = "" >
    <cftry>
    <!---Get the next category ID.--->
    <cfinvoke 
    component="MCMS.component.cms.Cms"
    method="getMaxValueSQL"
    returnvariable="lcatID">
    <cfinvokeargument name="tableName" value="tbl_line_category"/>
    </cfinvoke>
    <cfif lcatID NEQ ''>
    <cfset lcategoryID = application.lineCategoryIDSeedPrefix & (application.lineCategoryIDSeedNumber + lcatID + 1)>
    <cfelse>
    <cfset lcategoryID = application.lineCategoryIDSeedPrefix & (application.lineCategoryIDSeedNumber + 100 + 1)>
    </cfif>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset lcategoryID = StructNew()>
    <cfset lcategoryID.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn lcategoryID>
    </cffunction>
    
    <cffunction name="setSecondaryLineCategoryID" access="public" returntype="string" hint="Set Secondary Line Category ID based on ID.">
    <cfset var slcategoryID = "" >
    <cftry>
    <!---Get the next category ID.--->
    <cfinvoke 
    component="MCMS.component.cms.Cms"
    method="getMaxValueSQL"
    returnvariable="slcatID">
    <cfinvokeargument name="tableName" value="tbl_sec_line_category"/>
    </cfinvoke>
    <cfif slcatID NEQ ''>
    <cfset slcategoryID = application.secondaryLineCategoryIDSeedPrefix & (application.secondaryLineCategoryIDSeedNumber + slcatID + 1)>
    <cfelse>
    <cfset slcategoryID = application.secondaryLineCategoryIDSeedPrefix & (application.secondaryLineCategoryIDSeedNumber + 100 + 1)>
    </cfif>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset slcategoryID = StructNew()>
    <cfset slcategoryID.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn slcategoryID>
    </cffunction>
    
    <cffunction name="getCategoryReport" access="public" returntype="query" hint="Get Category Report data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="orderBy" type="string" required="yes" default="catName">
    <cfset var rsCategoryReport = "" >
    <cftry>
    <cfquery name="rsCategoryReport" datasource="#application.mcmsDSN#">
    SELECT catNo AS Cat_No, altCatNo AS Alt_Cat_No, catCode, catERPCode, catPOSCode, catName AS Name, catPageTitle AS Page_Title, TO_CHAR(catDescription) AS Description, TO_CHAR(catLongDescription) AS Long_Description, catKeyword AS Keyword, imgFile, catList, cesName, isShipToStore, sName AS Status FROM v_category_department_rel WHERE 0=0
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(catName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(catDescription) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">)
    </cfif>
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsCategoryReport = StructNew()>
    <cfset rsCategoryReport.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsCategoryReport>
    </cffunction>
    
    <cffunction name="getSecondaryCategoryReport" access="public" returntype="query" hint="Get Secondary Category Report data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="orderBy" type="string" required="yes" default="scatName">
    <cfset var rsSecondaryCategoryReport = "" >
    <cftry>
    <cfquery name="rsSecondaryCategoryReport" datasource="#application.mcmsDSN#">
    SELECT scatNo As Cat_No, altsCatNo As Alt_Cat_No, scatCode, scatERPCode, scatPOSCode, scatName As Name, scatPageTitle AS Page_Title, TO_CHAR(scatDescription) As Description, TO_CHAR(scatLongDescription) As Long_Description, scatKeyword As Keyword, imgFile, scatList, cesName, isShipToStore, sName As Status FROM v_secondary_category WHERE 0=0
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(scatName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(scatDescription) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(scatNo) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">)
    </cfif>
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsSecondaryCategoryReport = StructNew()>
    <cfset rsSecondaryCategoryReport.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsSecondaryCategoryReport>
    </cffunction>
    
    <cffunction name="getLineCategoryReport" access="public" returntype="query" hint="Get Line Category Report data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="orderBy" type="string" required="yes" default="lcatName">
    <cfset var rsLineCategoryReport = "" >
    <cftry>
    <cfquery name="rsLineCategoryReport" datasource="#application.mcmsDSN#">
    SELECT lcatNo As Cat_No, altlCatNo As Alt_Cat_No, lcatCode, lcatERPCode, lcatPOSCode, lcatName As Name, lcatPageTitle AS Page_Title, TO_CHAR(lcatDescription) As Description, TO_CHAR(lcatLongDescription) As Long_Description, lcatKeyword As Keyword, imgFile, lcatList, cesName, isShipToStore, sName As Status FROM v_line_category WHERE 0=0
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(lcatName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(lcatDescription) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(lcatNo) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">)
    </cfif>
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsLineCategoryReport = StructNew()>
    <cfset rsLineCategoryReport.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsLineCategoryReport>
    </cffunction>
    
    <cffunction name="getSecondaryLineCategoryReport" access="public" returntype="query" hint="Get Secondary Line Category Report data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="orderBy" type="string" required="yes" default="slcatName">
    <cfset var rsSecondaryLineCategoryReport = "" >
    <cftry>
    <cfquery name="rsSecondaryLineCategoryReport" datasource="#application.mcmsDSN#">
    SELECT slcatNo As Cat_No, altslCatNo As Alt_Cat_No, slcatCode, slcatERPCode, slcatPOSCode, slcatName As Name, slcatPageTitle AS Page_Title, TO_CHAR(slcatDescription) As Description, TO_CHAR(slcatLongDescription) As Long_Description, slcatKeyword As Keyword, imgFile, slcatList, cesName, isShipToStore, sName As Status FROM v_sec_line_category WHERE 0=0
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(slcatName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(slcatDescription) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(slcatNo) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">)
    </cfif>
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsSecondaryLineCategoryReport = StructNew()>
    <cfset rsSecondaryLineCategoryReport.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsSecondaryLineCategoryReport>
    </cffunction>
    
    <cffunction name="insertCategory" access="public" returntype="struct">
    <cfargument name="altCatNo" type="string" required="yes" default="0">
    <cfargument name="catCode" type="string" required="yes">
    <cfargument name="catERPCode" type="string" required="yes">
    <cfargument name="catPOSCode" type="string" required="yes">
    <cfargument name="catName" type="string" required="yes">
    <cfargument name="catPageTitle" type="string" required="yes">
    <cfargument name="catDescription" type="string" required="yes">
    <cfargument name="catLongDescription" type="string" required="yes">
    <cfargument name="catDateRel" type="string" required="yes">
    <cfargument name="catDateExp" type="string" required="yes">
    <cfargument name="catKeyword" type="string" required="yes">
    <cfargument name="imgID" type="numeric" required="yes">
    <cfargument name="catList" type="numeric" required="yes">
    <cfargument name="catSort" type="numeric" required="yes">
    <cfargument name="cesID" type="numeric" required="yes">
    <cfargument name="isShipToStore" type="string" required="yes" default="true">
    <cfargument name="catStatus" type="numeric" required="yes">
    <!---Relationship arguments.--->
    <cfargument name="cID" type="string" required="yes">
    <cfargument name="cmmID" type="string" required="yes">
    <cfargument name="deptNo" type="string" required="yes">
    <cfset result.message = "You have successfully inserted the record.">
    <cftry>
    <!---Get the actual category ID.--->
    <cfinvoke 
    component="MCMS.component.app.category.Category"
    method="setCategoryID"
    returnvariable="setCategoryID">
    </cfinvoke>
    <!---Check for profanity in the text.--->
    <cfinvoke 
    component="MCMS.component.utility.Regex"
    method="regexProfanity"
    returnvariable="regexProfanityRet">
    <cfinvokeargument name="profanityString" value="#TRIM(ARGUMENTS.catDescription)#"/>
    </cfinvoke>
    <!---Check for a duplicate record in all category tables.--->
    <cfinvoke 
    component="MCMS.component.app.category.Category"
    method="categoryExists"
    returnvariable="categoryExistsRet">
    <cfinvokeargument name="catName" value="#TRIM(ARGUMENTS.catName)#"/>
    </cfinvoke>
    <cfif categoryExistsRet NEQ "false">
    <cfset result.message = "#categoryExistsRet# The name #TRIM(ARGUMENTS.catName)# already exists, please enter a new name.">
    <cfelseif regexProfanityRet CONTAINS '$%&*!'>
    <cfset result.message = "Some text contained profanity, please remove any profanity from your text.">
    <!---Check length restriction.--->
    <cfelseif LEN(ARGUMENTS.catDescription) GT 2048>
    <cfset result.message = "The description is longer than 2048 characters, please enter a new description under 2048 characters.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    INSERT INTO tbl_category (catNo,altCatNo,catCode,catERPCode,catPOSCode,catName,catPageTitle,catDescription,catLongDescription,catDateRel,catDateExp,catKeyword,imgID,catList,catDateUpdate,userID,catSort,cesID,isShipToStore,catStatus) VALUES
    (
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#setCategoryID#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#TRIM(ARGUMENTS.altCatNo)#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#TRIM(ARGUMENTS.catCode)#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#TRIM(ARGUMENTS.catERPCode)#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#TRIM(ARGUMENTS.catPOSCode)#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#TRIM(ARGUMENTS.catName)#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#TRIM(ARGUMENTS.catPageTitle)#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#TRIM(ARGUMENTS.catDescription)#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#TRIM(ARGUMENTS.catLongDescription)#">,
    <cfqueryparam cfsqltype="cf_sql_date" value="#ARGUMENTS.catDateRel#">,
    <cfqueryparam cfsqltype="cf_sql_date" value="#ARGUMENTS.catDateExp#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#TRIM(ARGUMENTS.catKeyword)#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.imgID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.catList#">,
    <cfqueryparam cfsqltype="cf_sql_timestamp" value="#Now()#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#session.userID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.catSort#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.cesID#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.isShipToStore#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.catStatus#">
    )
    </cfquery>
    </cftransaction>
    <!--- Get newly inserted category ID. --->
    <cfinvoke 
    component="MCMS.component.cms.Cms"
    method="getMaxValueSQL"
    returnvariable="catID">
    <cfinvokeargument name="tableName" value="tbl_category"/>
    </cfinvoke>
    <cfset var.catID = catID>
    <!---Create catalog/department relationships.--->
    <cfinvoke 
    component="MCMS.component.app.category.Category"
    method="insertCategoryDepartmentRel"
    returnvariable="insertCategoryDepartmentRelRet">
    <cfinvokeargument name="cID" value="#ARGUMENTS.cID#"/>
    <cfinvokeargument name="catID" value="#var.catID#"/>
    <cfinvokeargument name="deptNo" value="#ARGUMENTS.deptNo#"/>
    <cfinvokeargument name="cdrStatus" value="1"/>
    </cfinvoke>
    <!---Create mega menu relationships.--->
    <cfinvoke 
    component="MCMS.component.app.category.Category"
    method="insertCategoryMegaMenuRel"
    returnvariable="insertCategoryDepartmentRelRet">
    <cfinvokeargument name="catID" value="#var.catID#"/>
    <cfinvokeargument name="cmmID" value="#ARGUMENTS.cmmID#"/>
    <cfinvokeargument name="cmmrStatus" value="1"/>
    </cfinvoke>
    </cfif>
    <cfcatch type="any">
    <cfset result.message = "There was an error inserting the record. It is possible the Category No. already exists.">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="insertSecondaryCategory" access="public" returntype="struct">
    <cfargument name="scatNo" type="string" required="yes" default="0">
    <cfargument name="altsCatNo" type="string" required="yes" default="0">
    <cfargument name="scatCode" type="string" required="yes">
    <cfargument name="scatERPCode" type="string" required="yes">
    <cfargument name="scatPOSCode" type="string" required="yes">
    <cfargument name="scatName" type="string" required="yes">
    <cfargument name="scatPageTitle" type="string" required="yes">
    <cfargument name="scatDescription" type="string" required="yes">
    <cfargument name="scatLongDescription" type="string" required="yes">
    <cfargument name="scatDateRel" type="string" required="yes">
	<cfargument name="scatDateExp" type="string" required="yes">
    <cfargument name="scatKeyword" type="string" required="yes">
    <cfargument name="imgID" type="numeric" required="yes">
    <cfargument name="scatList" type="numeric" required="yes">
    <cfargument name="scatSort" type="numeric" required="yes">
    <cfargument name="cesID" type="numeric" required="yes">
    <cfargument name="isShipToStore" type="string" required="yes" default="true">
    <cfargument name="scatStatus" type="numeric" required="yes">
    <!---Relationship arguments.--->
    <cfargument name="cID" type="string" required="yes">
    <cfargument name="catID" type="string" required="yes">
    <cfargument name="deptNo" type="string" required="yes">
    <cfset result.message = "You have successfully inserted the record.">
    <cftry>
    <!---Check for profanity in the text.--->
    <cfinvoke 
    component="MCMS.component.utility.Regex"
    method="regexProfanity"
    returnvariable="regexProfanityRet">
    <cfinvokeargument name="profanityString" value="#TRIM(ARGUMENTS.scatDescription)#"/>
    </cfinvoke>
    <!---Check for a duplicate record in all category tables.--->
    <cfinvoke 
    component="MCMS.component.app.category.Category"
    method="categoryExists"
    returnvariable="categoryExistsRet">
    <cfinvokeargument name="catName" value="#TRIM(ARGUMENTS.scatName)#"/>
    </cfinvoke>
    <cfif categoryExistsRet NEQ "false">
    <cfset result.message = "#categoryExistsRet# The name #TRIM(ARGUMENTS.scatName)# already exists, please enter a new name.">
    <cfelseif regexProfanityRet CONTAINS '$%&*!'>
    <cfset result.message = "Some text contained profanity, please remove any profanity from your text.">
    <!---Check length restriction.--->
    <cfelseif LEN(ARGUMENTS.scatDescription) GT 2048>
    <cfset result.message = "The description is longer than 2048 characters, please enter a new description under 2048 characters.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    INSERT INTO tbl_secondary_category (scatNo,altsCatNo,scatCode,scatERPCode,scatPOSCode,scatName,scatPageTitle,scatDescription,scatLongDescription,scatDateRel,scatDateExp,scatKeyword,imgID,scatList,scatDateUpdate,userID,scatSort,cesID,isShipToStore,scatStatus) VALUES
    (
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#TRIM(ARGUMENTS.scatNo)#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#TRIM(ARGUMENTS.altsCatNo)#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#TRIM(ARGUMENTS.scatCode)#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#TRIM(ARGUMENTS.scatERPCode)#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#TRIM(ARGUMENTS.scatPOSCode)#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#TRIM(ARGUMENTS.scatName)#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#TRIM(ARGUMENTS.scatPageTitle)#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#TRIM(ARGUMENTS.scatDescription)#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#TRIM(ARGUMENTS.scatLongDescription)#">,
    <cfqueryparam cfsqltype="cf_sql_date" value="#ARGUMENTS.scatDateRel#">,
	<cfqueryparam cfsqltype="cf_sql_date" value="#ARGUMENTS.scatDateExp#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#TRIM(ARGUMENTS.scatKeyword)#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.imgID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.scatList#">,
    <cfqueryparam cfsqltype="cf_sql_timestamp" value="#Now()#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#session.userID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.scatSort#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.cesID#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.isShipToStore#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.scatStatus#">
    )
    </cfquery>
    </cftransaction>
    <!--- Get newly inserted secondary category ID. --->
    <cfinvoke 
    component="MCMS.component.cms.Cms"
    method="getMaxValueSQL"
    returnvariable="scatID">
    <cfinvokeargument name="tableName" value="tbl_secondary_category"/>
    </cfinvoke>
    <cfset var.scatID = scatID>
    <!---Create department relationships.--->
    <cfinvoke 
    component="MCMS.component.app.category.Category"
    method="insertSecondaryCategoryDepartmentRel"
    returnvariable="insertSecondaryCategoryDepartmentRelRet">
    <cfinvokeargument name="cID" value="#ARGUMENTS.cID#"/>
    <cfinvokeargument name="scatID" value="#var.scatID#"/>
    <cfinvokeargument name="deptNo" value="#ARGUMENTS.deptNo#"/>
    <cfinvokeargument name="scdrStatus" value="1"/>
    </cfinvoke>
    <cfinvoke 
    component="MCMS.component.app.category.Category"
    method="insertCategorySecondaryCategoryRel"
    returnvariable="insertCategorySecondaryCategoryRelRet">
    <cfinvokeargument name="cID" value="#ARGUMENTS.cID#"/>
    <cfinvokeargument name="catID" value="#ARGUMENTS.catID#"/>
    <cfinvokeargument name="scatID" value="#var.scatID#"/>
    <cfinvokeargument name="cscrStatus" value="1"/>
    </cfinvoke>
    </cfif>
    <cfcatch type="any">
    <cfset result.message = "There was an error inserting the record. It is possible the Secondary Category No. already exists.">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="insertLineCategory" access="public" returntype="struct">
    <cfargument name="lcatNo" type="string" required="yes" default="0">
    <cfargument name="altlCatNo" type="string" required="yes" default="0">
    <cfargument name="lcatCode" type="string" required="yes">
    <cfargument name="lcatERPCode" type="string" required="yes">
    <cfargument name="lcatPOSCode" type="string" required="yes">
    <cfargument name="lcatName" type="string" required="yes">
    <cfargument name="lcatPageTitle" type="string" required="yes">
    <cfargument name="lcatDescription" type="string" required="yes">
    <cfargument name="lcatLongDescription" type="string" required="yes">
    <cfargument name="lcatDateRel" type="string" required="yes">
	<cfargument name="lcatDateExp" type="string" required="yes">
    <cfargument name="lcatKeyword" type="string" required="yes">
    <cfargument name="imgID" type="numeric" required="yes">
    <cfargument name="lcatList" type="numeric" required="yes">
    <cfargument name="lcatSort" type="numeric" required="yes">
    <cfargument name="isShipToStore" type="string" required="yes" default="true">
    <cfargument name="lcatStatus" type="numeric" required="yes">
    <!---Relationship arguments.--->
    <cfargument name="cID" type="string" required="yes">
    <cfargument name="scatID" type="string" required="yes">
    <cfargument name="deptNo" type="string" required="yes">
    <cfset result.message = "You have successfully inserted the record.">
    <cftry>
    <!---Check for profanity in the text.--->
    <cfinvoke 
    component="MCMS.component.utility.Regex"
    method="regexProfanity"
    returnvariable="regexProfanityRet">
    <cfinvokeargument name="profanityString" value="#TRIM(ARGUMENTS.lcatDescription)#"/>
    </cfinvoke>
    <!---Check for a duplicate record in all category tables.--->
    <cfinvoke 
    component="MCMS.component.app.category.Category"
    method="categoryExists"
    returnvariable="categoryExistsRet">
    <cfinvokeargument name="catName" value="#TRIM(ARGUMENTS.lcatName)#"/>
    </cfinvoke>
    <cfif categoryExistsRet NEQ "false">
    <cfset result.message = "#categoryExistsRet# The name #TRIM(ARGUMENTS.lcatName)# already exists, please enter a new name.">
    <cfelseif regexProfanityRet CONTAINS '$%&*!'>
    <cfset result.message = "Some text contained profanity, please remove any profanity from your text.">
    <!---Check length restriction.--->
    <cfelseif LEN(ARGUMENTS.lcatDescription) GT 2048>
    <cfset result.message = "The description is longer than 2048 characters, please enter a new description under 2048 characters.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    INSERT INTO tbl_line_category (lcatNo,altlCatNo,lcatCode,lcatERPCode,lcatPOSCode,lcatName,lcatPageTitle,lcatDescription,lcatLongDescription,lcatDateRel,lcatDateExp,lcatKeyword,imgID,lcatList,lcatDateUpdate,userID,lcatSort,cesID,isShipToStore,lcatStatus) VALUES
    (
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#TRIM(ARGUMENTS.lcatNo)#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#TRIM(ARGUMENTS.altlCatNo)#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#TRIM(ARGUMENTS.lcatCode)#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#TRIM(ARGUMENTS.lcatERPCode)#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#TRIM(ARGUMENTS.lcatPOSCode)#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#TRIM(ARGUMENTS.lcatName)#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#TRIM(ARGUMENTS.lcatPageTitle)#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#TRIM(ARGUMENTS.lcatDescription)#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#TRIM(ARGUMENTS.lcatLongDescription)#">,
    <cfqueryparam cfsqltype="cf_sql_date" value="#ARGUMENTS.lcatDateRel#">,
	<cfqueryparam cfsqltype="cf_sql_date" value="#ARGUMENTS.lcatDateExp#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#TRIM(ARGUMENTS.lcatKeyword)#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.imgID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.lcatList#">,
    <cfqueryparam cfsqltype="cf_sql_timestamp" value="#Now()#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#session.userID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.lcatSort#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.cesID#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.isShipToStore#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.lcatStatus#">
    )
    </cfquery>
    </cftransaction>
    <!--- Get newly inserted ine category ID. --->
    <cfinvoke 
    component="MCMS.component.cms.Cms"
    method="getMaxValueSQL"
    returnvariable="lcatID">
    <cfinvokeargument name="tableName" value="tbl_line_category"/>
    </cfinvoke>
    <cfset var.lcatID = lcatID>
    <!---Create catalog/department relationships.--->
    <cfinvoke 
    component="MCMS.component.app.category.Category"
    method="insertLineCategoryDepartmentRel"
    returnvariable="insertLineCategoryDepartmentRelRet">
    <cfinvokeargument name="cID" value="#ARGUMENTS.cID#"/>
    <cfinvokeargument name="lcatID" value="#var.lcatID#"/>
    <cfinvokeargument name="deptNo" value="#ARGUMENTS.deptNo#"/>
    <cfinvokeargument name="lcdrStatus" value="1"/>
    </cfinvoke>
    <cfinvoke 
    component="MCMS.component.app.category.Category"
    method="insertSecondaryCategoryLineCategoryRel"
    returnvariable="insertSecondaryCategoryLineCategoryRelRet">
    <cfinvokeargument name="cID" value="#ARGUMENTS.cID#"/>
    <cfinvokeargument name="scatID" value="#ARGUMENTS.scatID#"/>
    <cfinvokeargument name="lcatID" value="#var.lcatID#"/>
    <cfinvokeargument name="sclcrStatus" value="1"/>
    </cfinvoke>
    </cfif>
    <cfcatch type="any">
    <cfset result.message = "There was an error inserting the record. It is possible the Line Category No. already exists.">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="insertSecondaryLineCategory" access="public" returntype="struct">
    <cfargument name="slcatNo" type="string" required="yes" default="0">
    <cfargument name="altslCatNo" type="string" required="yes" default="0">
    <cfargument name="slcatCode" type="string" required="yes">
    <cfargument name="slcatERPCode" type="string" required="yes">
    <cfargument name="slcatPOSCode" type="string" required="yes">
    <cfargument name="slcatName" type="string" required="yes">
    <cfargument name="slcatPageTitle" type="string" required="yes">
    <cfargument name="slcatDescription" type="string" required="yes">
    <cfargument name="slcatLongDescription" type="string" required="yes">
    <cfargument name="slcatDateRel" type="string" required="yes">
	<cfargument name="slcatDateExp" type="string" required="yes">
    <cfargument name="slcatKeyword" type="string" required="yes">
    <cfargument name="imgID" type="numeric" required="yes">
    <cfargument name="slcatList" type="numeric" required="yes">
    <cfargument name="slcatSort" type="numeric" required="yes">
    <cfargument name="isShipToStore" type="string" required="yes" default="true">
    <cfargument name="slcatStatus" type="numeric" required="yes">
    <!---Relationship arguments.--->
    <cfargument name="cID" type="string" required="yes">
    <cfargument name="lcatID" type="string" required="yes">
    <cfargument name="deptNo" type="string" required="yes">
    <cfset result.message = "You have successfully inserted the record.">
    <cftry>
    <!---Check for profanity in the text.--->
    <cfinvoke 
    component="MCMS.component.utility.Regex"
    method="regexProfanity"
    returnvariable="regexProfanityRet">
    <cfinvokeargument name="profanityString" value="#TRIM(ARGUMENTS.slcatDescription)#"/>
    </cfinvoke>
    <!---Check for a duplicate record in all category tables.--->
    <cfinvoke 
    component="MCMS.component.app.category.Category"
    method="categoryExists"
    returnvariable="categoryExistsRet">
    <cfinvokeargument name="catName" value="#TRIM(ARGUMENTS.slcatName)#"/>
    </cfinvoke>
    <cfif categoryExistsRet NEQ "false">
    <cfset result.message = "#categoryExistsRet# The name #TRIM(ARGUMENTS.slcatName)# already exists, please enter a new name.">
    <cfelseif regexProfanityRet CONTAINS '$%&*!'>
    <cfset result.message = "Some text contained profanity, please remove any profanity from your text.">
    <!---Check length restriction.--->
    <cfelseif LEN(ARGUMENTS.slcatDescription) GT 2048>
    <cfset result.message = "The description is longer than 2048 characters, please enter a new description under 2048 characters.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    INSERT INTO tbl_sec_line_category (slcatNo,altslCatNo,slcatCode,slcatERPCode,slcatPOSCode,slcatName,slcatPageTitle,slcatDescription,slcatLongDescription,slcatDateRel,slcatDateExp,slcatKeyword,imgID,slcatList,slcatDateUpdate,userID,slcatSort,cesID,isShipToStore,slcatStatus) VALUES
    (
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#TRIM(ARGUMENTS.slcatNo)#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#TRIM(ARGUMENTS.altslCatNo)#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#TRIM(ARGUMENTS.slcatCode)#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#TRIM(ARGUMENTS.slcatERPCode)#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#TRIM(ARGUMENTS.slcatPOSCode)#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#TRIM(ARGUMENTS.slcatName)#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#TRIM(ARGUMENTS.slcatPageTitle)#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#TRIM(ARGUMENTS.slcatDescription)#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#TRIM(ARGUMENTS.slcatLongDescription)#">,
    <cfqueryparam cfsqltype="cf_sql_date" value="#ARGUMENTS.slcatDateRel#">,
	<cfqueryparam cfsqltype="cf_sql_date" value="#ARGUMENTS.slcatDateExp#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#TRIM(ARGUMENTS.slcatKeyword)#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.imgID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.slcatList#">,
    <cfqueryparam cfsqltype="cf_sql_timestamp" value="#Now()#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#session.userID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.slcatSort#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.cesID#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.isShipToStore#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.slcatStatus#">
    )
    </cfquery>
    </cftransaction>
    <!--- Get newly inserted ine category ID. --->
    <cfinvoke 
    component="MCMS.component.cms.Cms"
    method="getMaxValueSQL"
    returnvariable="slcatID">
    <cfinvokeargument name="tableName" value="tbl_sec_line_category"/>
    </cfinvoke>
    <cfset var.slcatID = slcatID>
    <!---Create catalog/department relationships.--->
    <cfinvoke 
    component="MCMS.component.app.category.Category"
    method="insertSecondaryLineCategoryDepartmentRel"
    returnvariable="insertSecondaryLineCategoryDepartmentRelRet">
    <cfinvokeargument name="cID" value="#ARGUMENTS.cID#"/>
    <cfinvokeargument name="slcatID" value="#var.slcatID#"/>
    <cfinvokeargument name="deptNo" value="#ARGUMENTS.deptNo#"/>
    <cfinvokeargument name="slcdrStatus" value="1"/>
    </cfinvoke>
    <cfinvoke 
    component="MCMS.component.app.category.Category"
    method="insertLineCategorySecondaryLineCategoryRel"
    returnvariable="insertLineCategorySecondaryLineCategoryRelRet">
    <cfinvokeargument name="cID" value="#ARGUMENTS.cID#"/>
    <cfinvokeargument name="lcatID" value="#ARGUMENTS.lcatID#"/>
    <cfinvokeargument name="slcatID" value="#var.slcatID#"/>
    <cfinvokeargument name="lcslcrStatus" value="1"/>
    </cfinvoke>
    </cfif>
    <cfcatch type="any">
    <cfset result.message = "There was an error inserting the record. It is possible the Line Category No. already exists.">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="getCategoryNameBind" access="remote" returntype="string" output="yes">
    <cfargument name="keywords" type="string" required="yes" default="">
    <cfargument name="dsn" type="string" required="yes" default="swweb">
    <cfset var rsBind = "" >
    <cfquery name="rsBindCategory" datasource="#ARGUMENTS.dsn#">
    SELECT ID, catName FROM tbl_category WHERE 0=0
    AND imgID = <cfqueryparam cfsqltype="cf_sql_integer" value="0">
    AND UPPER(catName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">
    ORDER BY catName
    </cfquery>
    <cfquery name="rsBindSecondaryCategory" datasource="#ARGUMENTS.dsn#">
    SELECT ID, scatName AS catName FROM tbl_secondary_category WHERE 0=0
    AND imgID = <cfqueryparam cfsqltype="cf_sql_integer" value="0">
    AND UPPER(scatName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">
    ORDER BY scatName
    </cfquery>
    <cfquery name="rsBindLineCategory" datasource="#ARGUMENTS.dsn#">
    SELECT ID, lcatName AS catName FROM tbl_line_category WHERE 0=0
    AND imgID = <cfqueryparam cfsqltype="cf_sql_integer" value="0">
    AND UPPER(lcatName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">
    ORDER BY lcatName
    </cfquery>
    <cfset IDList = ''>
    <cfif rsBindCategory.recordcount NEQ 0>
    <cfset IDList = ValueList(rsBindCategory.catName, ',')>
    </cfif>
    <cfif rsBindSecondaryCategory.recordcount NEQ 0>
    <cfset IDList = Iif(IDList NEQ '', DE('#IDList#,'), DE('')) & ValueList(rsBindSecondaryCategory.catName, ',')>
    </cfif>
    <cfif rsBindLineCategory.recordcount NEQ 0>
    <cfset IDList = Iif(IDList NEQ '', DE('#IDList#,'), DE('')) & ValueList(rsBindLineCategory.catName, ',')>
    </cfif>
    <cfreturn IDList>
    </cffunction>
    
    <cffunction name="insertCategoryDepartmentRel" access="public" returntype="struct">
    <cfargument name="cID" type="string" required="yes">
    <cfargument name="catID" type="numeric" required="yes">
    <cfargument name="deptNo" type="string" required="yes">
    <cfargument name="cdrStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully inserted the record.">
    <cftry>
    <cftransaction>
    <cfloop index="i" from="1" to="#ListLen(ARGUMENTS.cID)#">
    <cfloop index="ii" from="1" to="#ListLen(ARGUMENTS.deptNo)#">
    <cfquery datasource="#application.mcmsDSN#">
    INSERT INTO tbl_category_department_rel (cID,catID,deptNo,cdrStatus) VALUES
    (
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ListGetAt(ARGUMENTS.cID, i)#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.catID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ListGetAt(ARGUMENTS.deptNo, ii)#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.cdrStatus#">
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
    
    <cffunction name="insertCategoryMegaMenuRel" access="public" returntype="struct">
    <cfargument name="catID" type="numeric" required="yes">
    <cfargument name="cmmID" type="string" required="yes">
    <cfargument name="cmmrStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully inserted the record.">
    <cftry>
    <cftransaction>
    <cfloop index="i" from="1" to="#ListLen(ARGUMENTS.cmmID)#">
    <cfquery datasource="#application.mcmsDSN#">
    INSERT INTO tbl_category_mega_menu_rel (catID,cmmID,cmmrStatus) VALUES
    (
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.catID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ListGetAt(ARGUMENTS.cmmID, i)#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.cmmrStatus#">
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
    
    <cffunction name="insertSecondaryCategoryDepartmentRel" access="public" returntype="struct">
    <cfargument name="cID" type="string" required="yes">
    <cfargument name="scatID" type="numeric" required="yes">
    <cfargument name="deptNo" type="string" required="yes">
    <cfargument name="scdrStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully inserted the record.">
    <cftry>
    <cftransaction>
    <cfloop index="i" from="1" to="#ListLen(ARGUMENTS.cID)#">
    <cfloop index="ii" from="1" to="#ListLen(ARGUMENTS.deptNo)#">
    <cfquery datasource="#application.mcmsDSN#">
    INSERT INTO tbl_sec_category_dept_rel (cID,scatID,deptNo,scdrStatus) VALUES
    (
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ListGetAt(ARGUMENTS.cID, i)#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.scatID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ListGetAt(ARGUMENTS.deptNo, ii)#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.scdrStatus#">
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
    
    <cffunction name="insertCategorySecondaryCategoryRel" access="public" returntype="struct">
    <cfargument name="cID" type="string" required="yes">
    <cfargument name="catID" type="string" required="yes">
    <cfargument name="scatID" type="numeric" required="yes">
    <cfargument name="cscrStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully inserted the record.">
    <cftry>
    <cftransaction>
    <cfloop index="i" from="1" to="#ListLen(ARGUMENTS.cID)#">
    <cfloop index="ii" from="1" to="#ListLen(ARGUMENTS.catID)#">
    <cfquery datasource="#application.mcmsDSN#">
    INSERT INTO tbl_category_sc_rel (cID,catID,scatID,cscrStatus) VALUES
    (
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ListGetAt(ARGUMENTS.cID, i)#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ListGetAt(ARGUMENTS.catID, ii)#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.scatID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.cscrStatus#">
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
    
    <cffunction name="insertLineCategoryDepartmentRel" access="public" returntype="struct">
    <cfargument name="cID" type="string" required="yes">
    <cfargument name="lcatID" type="numeric" required="yes">
    <cfargument name="deptNo" type="string" required="yes">
    <cfargument name="lcdrStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully inserted the record.">
    <cftry>
    <cftransaction>
    <cfloop index="i" from="1" to="#ListLen(ARGUMENTS.cID)#">
    <cfloop index="ii" from="1" to="#ListLen(ARGUMENTS.deptNo)#">
    <cfquery datasource="#application.mcmsDSN#">
    INSERT INTO tbl_line_category_dept_rel (cID,lcatID,deptNo,lcdrStatus) VALUES
    (
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ListGetAt(ARGUMENTS.cID, i)#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.lcatID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ListGetAt(ARGUMENTS.deptNo, ii)#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.lcdrStatus#">
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
    
    <cffunction name="insertSecondaryLineCategoryDepartmentRel" access="public" returntype="struct">
    <cfargument name="cID" type="string" required="yes">
    <cfargument name="slcatID" type="numeric" required="yes">
    <cfargument name="deptNo" type="string" required="yes">
    <cfargument name="slcdrStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully inserted the record.">
    <cftry>
    <cftransaction>
    <cfloop index="i" from="1" to="#ListLen(ARGUMENTS.cID)#">
    <cfloop index="ii" from="1" to="#ListLen(ARGUMENTS.deptNo)#">
    <cfquery datasource="#application.mcmsDSN#">
    INSERT INTO tbl_sec_line_category_dept_rel (cID,slcatID,deptNo,slcdrStatus) VALUES
    (
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ListGetAt(ARGUMENTS.cID, i)#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.slcatID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ListGetAt(ARGUMENTS.deptNo, ii)#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.slcdrStatus#">
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
    
    <cffunction name="insertSecondaryCategoryLineCategoryRel" access="public" returntype="struct">
    <cfargument name="cID" type="string" required="yes">
    <cfargument name="scatID" type="string" required="yes">
    <cfargument name="lcatID" type="numeric" required="yes">
    <cfargument name="sclcrStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully inserted the record.">
    <cftry>
    <cftransaction>
    <cfloop index="i" from="1" to="#ListLen(ARGUMENTS.cID)#">
    <cfloop index="ii" from="1" to="#ListLen(ARGUMENTS.scatID)#">
    <cfquery datasource="#application.mcmsDSN#">
    INSERT INTO tbl_sec_category_lc_rel (cID,scatID,lcatID,sclcrStatus) VALUES
    (
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ListGetAt(ARGUMENTS.cID, i)#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ListGetAt(ARGUMENTS.scatID, ii)#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.lcatID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.sclcrStatus#">
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
    
    <cffunction name="insertLineCategorySecondaryLineCategoryRel" access="public" returntype="struct">
    <cfargument name="cID" type="string" required="yes">
    <cfargument name="lcatID" type="string" required="yes">
    <cfargument name="slcatID" type="numeric" required="yes">
    <cfargument name="lcslcrStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully inserted the record.">
    <cftry>
    <cftransaction>
    <cfloop index="i" from="1" to="#ListLen(ARGUMENTS.cID)#">
    <cfloop index="ii" from="1" to="#ListLen(ARGUMENTS.lcatID)#">
    <cfquery datasource="#application.mcmsDSN#">
    INSERT INTO tbl_line_category_slc_rel (cID,lcatID,slcatID,lcslcrStatus) VALUES
    (
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ListGetAt(ARGUMENTS.cID, i)#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ListGetAt(ARGUMENTS.lcatID, ii)#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.slcatID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.lcslcrStatus#">
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
    
    <cffunction name="updateCategory" access="public" returntype="struct">
    <cfargument name="ID" type="numeric" required="yes">
    <cfargument name="altCatNo" type="string" required="yes" default="0">
    <cfargument name="catCode" type="string" required="yes">
    <cfargument name="catERPCode" type="string" required="yes">
    <cfargument name="catPOSCode" type="string" required="yes">
    <cfargument name="catName" type="string" required="yes">
    <cfargument name="catPageTitle" type="string" required="yes">
    <cfargument name="catDescription" type="string" required="yes">
    <cfargument name="catLongDescription" type="string" required="yes">
    <cfargument name="catDateRel" type="string" required="yes">
	<cfargument name="catDateExp" type="string" required="yes">
    <cfargument name="catKeyword" type="string" required="yes">
    <cfargument name="imgID" type="numeric" required="yes">
    <cfargument name="catList" type="numeric" required="yes">
    <cfargument name="catSort" type="numeric" required="yes">
    <cfargument name="cesID" type="numeric" required="yes">
    <cfargument name="isShipToStore" type="string" required="yes" default="true">
    <cfargument name="catStatus" type="numeric" required="yes">
    <!---Relationship arguments.--->
    <cfargument name="cID" type="string" required="yes">
    <cfargument name="cmmID" type="string" required="yes">
    <cfargument name="deptNo" type="string" required="yes">
    <cfset result.message = "You have successfully updated the record.">
    <cftry>
    <!---Check for profanity in the text.--->
    <cfinvoke 
    component="MCMS.component.utility.Regex"
    method="regexProfanity"
    returnvariable="regexProfanityRet">
    <cfinvokeargument name="profanityString" value="#TRIM(ARGUMENTS.catDescription)#"/>
    </cfinvoke>
    <!---Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.app.category.Category"
    method="getCategory"
    returnvariable="getCheckCategoryRet">
    <cfinvokeargument name="excludeID" value="#ARGUMENTS.ID#"/>
    <cfinvokeargument name="catName" value="#TRIM(ARGUMENTS.catName)#"/>
    <cfinvokeargument name="catStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckCategoryRet.recordcount NEQ 0>
    <cfset result.message = "The name #TRIM(ARGUMENTS.catName)# already exists, please enter a new name.">
    <cfelseif regexProfanityRet CONTAINS '$%&*!'>
    <cfset result.message = "Some text contained profanity, please remove any profanity from your text.">
    <!---Check length restriction.--->
    <cfelseif LEN(ARGUMENTS.catDescription) GT 2048>
    <cfset result.message = "The description is longer than 2048 characters, please enter a new description under 2048 characters.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_category SET
    altCatNo = <cfqueryparam cfsqltype="cf_sql_varchar" value="#TRIM(ARGUMENTS.altCatNo)#">,
    catCode = <cfqueryparam cfsqltype="cf_sql_varchar" value="#TRIM(ARGUMENTS.catCode)#">,
    catERPCode = <cfqueryparam cfsqltype="cf_sql_varchar" value="#TRIM(ARGUMENTS.catERPCode)#">,
    catPOSCode = <cfqueryparam cfsqltype="cf_sql_varchar" value="#TRIM(ARGUMENTS.catPOSCode)#">,
    catName = <cfqueryparam cfsqltype="cf_sql_varchar" value="#TRIM(ARGUMENTS.catName)#">,
    catPageTitle = <cfqueryparam cfsqltype="cf_sql_varchar" value="#TRIM(ARGUMENTS.catPageTitle)#">,
    catDescription = <cfqueryparam cfsqltype="cf_sql_varchar" value="#TRIM(ARGUMENTS.catDescription)#">,
    catLongDescription = <cfqueryparam cfsqltype="cf_sql_varchar" value="#TRIM(ARGUMENTS.catLongDescription)#">,
    catDateRel = <cfqueryparam cfsqltype="cf_sql_date" value="#ARGUMENTS.catDateRel#">,
	catDateExp = <cfqueryparam cfsqltype="cf_sql_date" value="#ARGUMENTS.catDateExp#">,
    catKeyword = <cfqueryparam cfsqltype="cf_sql_varchar" value="#TRIM(ARGUMENTS.catKeyword)#">,
    imgID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.imgID#">,
    catList = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.catList#">,
    catDateUpdate = <cfqueryparam cfsqltype="cf_sql_timestamp" value="#Now()#">,
    userID = <cfqueryparam cfsqltype="cf_sql_integer" value="#session.userID#">,
    catSort = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.catSort#">,
    cesID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.cesID#">,
    isShipToStore = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.isShipToStore#">,
    catStatus = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.catStatus#">
    WHERE ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ID#">
    </cfquery>
    </cftransaction>
    <!---Delete any existing relationships.--->
    <cfinvoke 
    component="MCMS.component.app.category.Category"
    method="deleteCategoryDepartmentRel"
    returnvariable="deleteCategoryDepartmentRelRet">
    <cfinvokeargument name="catID" value="#ARGUMENTS.ID#"/>
    </cfinvoke>
    <cfinvoke 
    component="MCMS.component.app.category.Category"
    method="deleteCategoryMegaMenuRel"
    returnvariable="deleteCategoryMegaMenuRelRet">
    <cfinvokeargument name="catID" value="#ARGUMENTS.ID#"/>
    </cfinvoke>
    <!---Create catalog/department relationships.--->
    <cfinvoke 
    component="MCMS.component.app.category.Category"
    method="insertCategoryDepartmentRel"
    returnvariable="insertCategoryDepartmentRelRet">
    <cfinvokeargument name="cID" value="#ARGUMENTS.cID#"/>
    <cfinvokeargument name="catID" value="#ARGUMENTS.ID#"/>
    <cfinvokeargument name="deptNo" value="#ARGUMENTS.deptNo#"/>
    <cfinvokeargument name="cdrStatus" value="1"/>
    </cfinvoke>
    <!---Create mega menu relationships.--->
    <cfinvoke 
    component="MCMS.component.app.category.Category"
    method="insertCategoryMegaMenuRel"
    returnvariable="insertCategoryMegaMenuRelRet">
    <cfinvokeargument name="catID" value="#ARGUMENTS.ID#"/>
    <cfinvokeargument name="cmmID" value="#ARGUMENTS.cmmID#"/>
    <cfinvokeargument name="cmmrStatus" value="1"/>
    </cfinvoke>
    </cfif>
    <cfcatch type="any">
    <cfset result.message = "There was an error updating the record.">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="updateSecondaryCategory" access="public" returntype="struct">
    <cfargument name="ID" type="numeric" required="yes">
    <cfargument name="scatNo" type="string" required="yes">
    <cfargument name="altsCatNo" type="string" required="yes" default="0">
    <cfargument name="scatCode" type="string" required="yes">
    <cfargument name="scatERPCode" type="string" required="yes">
    <cfargument name="scatPOSCode" type="string" required="yes">
    <cfargument name="scatName" type="string" required="yes">
    <cfargument name="scatDescription" type="string" required="yes">
    <cfargument name="scatLongDescription" type="string" required="yes">
    <cfargument name="scatDateRel" type="string" required="yes">
	<cfargument name="scatDateExp" type="string" required="yes">
    <cfargument name="scatKeyword" type="string" required="yes">
    <cfargument name="imgID" type="numeric" required="yes">
    <cfargument name="scatList" type="numeric" required="yes">
    <cfargument name="scatSort" type="numeric" required="yes">
    <cfargument name="cesID" type="numeric" required="yes">
    <cfargument name="isShipToStore" type="string" required="yes" default="true">
    <cfargument name="scatStatus" type="numeric" required="yes">
    <!---Relationship arguments.--->
    <cfargument name="cID" type="string" required="yes">
    <cfargument name="catID" type="string" required="yes">
    <cfargument name="deptNo" type="string" required="yes">
    <cfset result.message = "You have successfully updated the record.">
    <cftry>
    <!---Check for profanity in the text.--->
    <cfinvoke 
    component="MCMS.component.utility.Regex"
    method="regexProfanity"
    returnvariable="regexProfanityRet">
    <cfinvokeargument name="profanityString" value="#TRIM(ARGUMENTS.scatDescription)#"/>
    </cfinvoke>
    <!---Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.app.category.Category"
    method="getSecondaryCategory"
    returnvariable="getCheckSecondaryCategoryRet">
    <cfinvokeargument name="excludeID" value="#ARGUMENTS.ID#"/>
    <cfinvokeargument name="scatNo" value="#TRIM(ARGUMENTS.scatNo)#"/>
    <cfinvokeargument name="scatName" value="#TRIM(ARGUMENTS.scatName)#"/>
    <cfinvokeargument name="scatStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckSecondaryCategoryRet.recordcount NEQ 0>
    <cfset result.message = "The name #TRIM(ARGUMENTS.scatName)# already exists or the Cat No. matches, please enter a new name.">
    <cfelseif regexProfanityRet CONTAINS '$%&*!'>
    <cfset result.message = "Some text contained profanity, please remove any profanity from your text.">
    <!---Check length restriction.--->
    <cfelseif LEN(ARGUMENTS.scatDescription) GT 2048>
    <cfset result.message = "The description is longer than 2048 characters, please enter a new description under 2048 characters.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_secondary_category SET
    scatNo = <cfqueryparam cfsqltype="cf_sql_varchar" value="#TRIM(ARGUMENTS.scatNo)#">,
    altsCatNo = <cfqueryparam cfsqltype="cf_sql_varchar" value="#TRIM(ARGUMENTS.altsCatNo)#">,
    scatCode = <cfqueryparam cfsqltype="cf_sql_varchar" value="#TRIM(ARGUMENTS.scatCode)#">,
    scatERPCode = <cfqueryparam cfsqltype="cf_sql_varchar" value="#TRIM(ARGUMENTS.scatERPCode)#">,
    scatPOSCode = <cfqueryparam cfsqltype="cf_sql_varchar" value="#TRIM(ARGUMENTS.scatPOSCode)#">,
    scatName = <cfqueryparam cfsqltype="cf_sql_varchar" value="#TRIM(ARGUMENTS.scatName)#">,
    scatPageTitle = <cfqueryparam cfsqltype="cf_sql_varchar" value="#TRIM(ARGUMENTS.scatPageTitle)#">,
    scatDescription = <cfqueryparam cfsqltype="cf_sql_varchar" value="#TRIM(ARGUMENTS.scatDescription)#">,
    scatLongDescription = <cfqueryparam cfsqltype="cf_sql_varchar" value="#TRIM(ARGUMENTS.scatLongDescription)#">,
    scatDateRel = <cfqueryparam cfsqltype="cf_sql_date" value="#ARGUMENTS.scatDateRel#">,
	scatDateExp = <cfqueryparam cfsqltype="cf_sql_date" value="#ARGUMENTS.scatDateExp#">,
    scatKeyword = <cfqueryparam cfsqltype="cf_sql_varchar" value="#TRIM(ARGUMENTS.scatKeyword)#">,
    imgID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.imgID#">,
    scatList = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.scatList#">,
    scatDateUpdate = <cfqueryparam cfsqltype="cf_sql_timestamp" value="#Now()#">,
    userID = <cfqueryparam cfsqltype="cf_sql_integer" value="#session.userID#">,
    scatSort = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.scatSort#">,
    cesID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.cesID#">,
    isShipToStore = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.isShipToStore#">,
    scatStatus = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.scatStatus#">
    WHERE ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ID#">
    </cfquery>
    </cftransaction>
    <!---Delete any existing relationships.--->
    <cfinvoke 
    component="MCMS.component.app.category.Category"
    method="deleteSecondaryCategoryDepartmentRel"
    returnvariable="deleteSecondaryCategoryDepartmentRelRet">
    <cfinvokeargument name="scatID" value="#ARGUMENTS.ID#"/>
    </cfinvoke>
    <cfinvoke 
    component="MCMS.component.app.category.Category"
    method="deleteCategorySecondaryCategoryRel"
    returnvariable="deleteCategorySecondaryCategoryRelRet">
    <cfinvokeargument name="scatID" value="#ARGUMENTS.ID#"/>
    </cfinvoke>
    <!---Create department/catalog relationships.--->
    <cfinvoke 
    component="MCMS.component.app.category.Category"
    method="insertSecondaryCategoryDepartmentRel"
    returnvariable="insertSecondaryCategoryDepartmentRelRet">
    <cfinvokeargument name="cID" value="#ARGUMENTS.cID#"/>
    <cfinvokeargument name="scatID" value="#ARGUMENTS.ID#"/>
    <cfinvokeargument name="deptNo" value="#ARGUMENTS.deptNo#"/>
    <cfinvokeargument name="scdrStatus" value="1"/>
    </cfinvoke>
    <!---Create category/secondary category relationships.--->
    <cfinvoke 
    component="MCMS.component.app.category.Category"
    method="insertCategorySecondaryCategoryRel"
    returnvariable="insertCategorySecondaryCategoryRelRet">
    <cfinvokeargument name="cID" value="#ARGUMENTS.cID#"/>
    <cfinvokeargument name="catID" value="#ARGUMENTS.catID#"/>
    <cfinvokeargument name="scatID" value="#ARGUMENTS.ID#"/>
    <cfinvokeargument name="cscrStatus" value="1"/>
    </cfinvoke>
    </cfif>
    <cfcatch type="any">
    <cfset result.message = "There was an error updating the record.">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="updateLineCategory" access="public" returntype="struct">
    <cfargument name="ID" type="numeric" required="yes">
    <cfargument name="lcatNo" type="string" required="yes">
    <cfargument name="altlCatNo" type="string" required="yes" default="0">
    <cfargument name="lcatCode" type="string" required="yes">
    <cfargument name="lcatERPCode" type="string" required="yes">
    <cfargument name="lcatPOSCode" type="string" required="yes">
    <cfargument name="lcatName" type="string" required="yes">
    <cfargument name="lcatPageTitle" type="string" required="yes">
    <cfargument name="lcatDescription" type="string" required="yes">
    <cfargument name="lcatLongDescription" type="string" required="yes">
    <cfargument name="lcatDateRel" type="string" required="yes">
	<cfargument name="lcatDateExp" type="string" required="yes">
    <cfargument name="lcatKeyword" type="string" required="yes">
    <cfargument name="imgID" type="numeric" required="yes">
    <cfargument name="lcatList" type="numeric" required="yes">
    <cfargument name="lcatSort" type="numeric" required="yes">
    <cfargument name="isShipToStore" type="string" required="yes" default="true">
    <cfargument name="lcatStatus" type="numeric" required="yes">
    <!---Relationship arguments.--->
    <cfargument name="cID" type="string" required="yes">
    <cfargument name="scatID" type="string" required="yes">
    <cfargument name="deptNo" type="string" required="yes">
    <cfset result.message = "You have successfully updated the record.">
    <cftry>
    <!---Check for profanity in the text.--->
    <cfinvoke 
    component="MCMS.component.utility.Regex"
    method="regexProfanity"
    returnvariable="regexProfanityRet">
    <cfinvokeargument name="profanityString" value="#TRIM(ARGUMENTS.lcatDescription)#"/>
    </cfinvoke>
    <!---Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.app.category.Category"
    method="getLineCategory"
    returnvariable="getCheckLineCategoryRet">
    <cfinvokeargument name="excludeID" value="#ARGUMENTS.ID#"/>
    <cfinvokeargument name="lcatNo" value="#TRIM(ARGUMENTS.lcatNo)#"/>
    <cfinvokeargument name="lcatName" value="#TRIM(ARGUMENTS.lcatName)#"/>
    <cfinvokeargument name="scatStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckLineCategoryRet.recordcount NEQ 0>
    <cfset result.message = "The name #TRIM(ARGUMENTS.lcatName)# or category no. already exists, please enter a new name.">
    <cfelseif regexProfanityRet CONTAINS '$%&*!'>
    <cfset result.message = "Some text contained profanity, please remove any profanity from your text.">
    <!---Check length restriction.--->
    <cfelseif LEN(ARGUMENTS.lcatDescription) GT 2048>
    <cfset result.message = "The description is longer than 2048 characters, please enter a new description under 2048 characters.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_line_category SET
    lcatNo = <cfqueryparam cfsqltype="cf_sql_varchar" value="#TRIM(ARGUMENTS.lcatNo)#">,
    altlCatNo = <cfqueryparam cfsqltype="cf_sql_varchar" value="#TRIM(ARGUMENTS.altlCatNo)#">,
    lcatCode = <cfqueryparam cfsqltype="cf_sql_varchar" value="#TRIM(ARGUMENTS.lcatCode)#">,
    lcatERPCode = <cfqueryparam cfsqltype="cf_sql_varchar" value="#TRIM(ARGUMENTS.lcatERPCode)#">,
    lcatPOSCode = <cfqueryparam cfsqltype="cf_sql_varchar" value="#TRIM(ARGUMENTS.lcatPOSCode)#">,
    lcatName = <cfqueryparam cfsqltype="cf_sql_varchar" value="#TRIM(ARGUMENTS.lcatName)#">,
    lcatPageTitle = <cfqueryparam cfsqltype="cf_sql_varchar" value="#TRIM(ARGUMENTS.lcatPageTitle)#">,
    lcatDescription = <cfqueryparam cfsqltype="cf_sql_varchar" value="#TRIM(ARGUMENTS.lcatDescription)#">,
    lcatLongDescription = <cfqueryparam cfsqltype="cf_sql_varchar" value="#TRIM(ARGUMENTS.lcatLongDescription)#">,
    lcatDateRel = <cfqueryparam cfsqltype="cf_sql_date" value="#ARGUMENTS.lcatDateRel#">,
    lcatDateExp = <cfqueryparam cfsqltype="cf_sql_date" value="#ARGUMENTS.lcatDateExp#">,
    lcatKeyword = <cfqueryparam cfsqltype="cf_sql_varchar" value="#TRIM(ARGUMENTS.lcatKeyword)#">,
    imgID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.imgID#">,
    lcatList = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.lcatList#">,
    lcatDateUpdate = <cfqueryparam cfsqltype="cf_sql_timestamp" value="#Now()#">,
    userID = <cfqueryparam cfsqltype="cf_sql_integer" value="#session.userID#">,
    lcatSort = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.lcatSort#">,
    cesID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.cesID#">,
    isShipToStore = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.isShipToStore#">,
    lcatStatus = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.lcatStatus#">
    WHERE ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ID#">
    </cfquery>
    </cftransaction>
    <!---Delete any existing relationships.--->
    <cfinvoke 
    component="MCMS.component.app.category.Category"
    method="deleteLineCategoryDepartmentRel"
    returnvariable="deleteLineCategoryDepartmentRelRet">
    <cfinvokeargument name="lcatID" value="#ARGUMENTS.ID#"/>
    </cfinvoke>
    <cfinvoke 
    component="MCMS.component.app.category.Category"
    method="deleteSecondaryCategoryLineCategoryRel"
    returnvariable="deleteSecondaryCategoryLineCategoryRelRet">
    <cfinvokeargument name="lcatID" value="#ARGUMENTS.ID#"/>
    </cfinvoke>
    <!---Create department/catalog relationships.--->
    <cfinvoke 
    component="MCMS.component.app.category.Category"
    method="insertLineCategoryDepartmentRel"
    returnvariable="insertLineCategoryDepartmentRelRet">
    <cfinvokeargument name="cID" value="#ARGUMENTS.cID#"/>
    <cfinvokeargument name="lcatID" value="#ARGUMENTS.ID#"/>
    <cfinvokeargument name="deptNo" value="#ARGUMENTS.deptNo#"/>
    <cfinvokeargument name="lcdrStatus" value="1"/>
    </cfinvoke>
    <!---Create sec. category/line category relationships.--->
    <cfinvoke 
    component="MCMS.component.app.category.Category"
    method="insertSecondaryCategoryLineCategoryRel"
    returnvariable="insertSecondaryCategoryLineCategoryRelRet">
    <cfinvokeargument name="cID" value="#ARGUMENTS.cID#"/>
    <cfinvokeargument name="scatID" value="#ARGUMENTS.scatID#"/>
    <cfinvokeargument name="lcatID" value="#ARGUMENTS.ID#"/>
    <cfinvokeargument name="sclcrStatus" value="1"/>
    </cfinvoke>
    </cfif>
    <cfcatch type="any">
    <cfset result.message = "There was an error updating the record.">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="updateSecondaryLineCategory" access="public" returntype="struct">
    <cfargument name="ID" type="numeric" required="yes">
    <cfargument name="slcatNo" type="string" required="yes">
    <cfargument name="altslCatNo" type="string" required="yes" default="0">
    <cfargument name="slcatCode" type="string" required="yes">
    <cfargument name="slcatERPCode" type="string" required="yes">
    <cfargument name="slcatPOSCode" type="string" required="yes">
    <cfargument name="slcatName" type="string" required="yes">
    <cfargument name="slcatPageTitle" type="string" required="yes">
    <cfargument name="slcatDescription" type="string" required="yes">
    <cfargument name="slcatLongDescription" type="string" required="yes">
    <cfargument name="slcatDateRel" type="string" required="yes">
	<cfargument name="slcatDateExp" type="string" required="yes">
    <cfargument name="slcatKeyword" type="string" required="yes">
    <cfargument name="imgID" type="numeric" required="yes">
    <cfargument name="slcatList" type="numeric" required="yes">
    <cfargument name="slcatSort" type="numeric" required="yes">
    <cfargument name="isShipToStore" type="string" required="yes" default="true">
    <cfargument name="slcatStatus" type="numeric" required="yes">
    <!---Relationship arguments.--->
    <cfargument name="cID" type="string" required="yes">
    <cfargument name="lcatID" type="string" required="yes">
    <cfargument name="deptNo" type="string" required="yes">
    <cfset result.message = "You have successfully updated the record.">
    <cftry>
    <!---Check for profanity in the text.--->
    <cfinvoke 
    component="MCMS.component.utility.Regex"
    method="regexProfanity"
    returnvariable="regexProfanityRet">
    <cfinvokeargument name="profanityString" value="#TRIM(ARGUMENTS.slcatDescription)#"/>
    </cfinvoke>
    <!---Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.app.category.Category"
    method="getSecondaryLineCategory"
    returnvariable="getCheckSecondaryLineCategoryRet">
    <cfinvokeargument name="excludeID" value="#ARGUMENTS.ID#"/>
    <cfinvokeargument name="slcatNo" value="#TRIM(ARGUMENTS.slcatNo)#"/>
    <cfinvokeargument name="slcatName" value="#TRIM(ARGUMENTS.slcatName)#"/>
    <cfinvokeargument name="slcatStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckSecondaryLineCategoryRet.recordcount NEQ 0>
    <cfset result.message = "The name #TRIM(ARGUMENTS.slcatName)# or category no. already exists, please enter a new name.">
    <cfelseif regexProfanityRet CONTAINS '$%&*!'>
    <cfset result.message = "Some text contained profanity, please remove any profanity from your text.">
    <!---Check length restriction.--->
    <cfelseif LEN(ARGUMENTS.slcatDescription) GT 2048>
    <cfset result.message = "The description is longer than 2048 characters, please enter a new description under 2048 characters.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_sec_line_category SET
    slcatNo = <cfqueryparam cfsqltype="cf_sql_varchar" value="#TRIM(ARGUMENTS.slcatNo)#">,
    altslCatNo = <cfqueryparam cfsqltype="cf_sql_varchar" value="#TRIM(ARGUMENTS.altslCatNo)#">,
    slcatCode = <cfqueryparam cfsqltype="cf_sql_varchar" value="#TRIM(ARGUMENTS.slcatCode)#">,
    slcatERPCode = <cfqueryparam cfsqltype="cf_sql_varchar" value="#TRIM(ARGUMENTS.slcatERPCode)#">,
    slcatPOSCode = <cfqueryparam cfsqltype="cf_sql_varchar" value="#TRIM(ARGUMENTS.slcatPOSCode)#">,
    slcatName = <cfqueryparam cfsqltype="cf_sql_varchar" value="#TRIM(ARGUMENTS.slcatName)#">,
    slcatPageTitle = <cfqueryparam cfsqltype="cf_sql_varchar" value="#TRIM(ARGUMENTS.slcatPageTitle)#">,
    slcatDescription = <cfqueryparam cfsqltype="cf_sql_varchar" value="#TRIM(ARGUMENTS.slcatDescription)#">,
    slcatLongDescription = <cfqueryparam cfsqltype="cf_sql_varchar" value="#TRIM(ARGUMENTS.slcatLongDescription)#">,
    slcatDateRel = <cfqueryparam cfsqltype="cf_sql_date" value="#ARGUMENTS.slcatDateRel#">,
    slcatDateExp = <cfqueryparam cfsqltype="cf_sql_date" value="#ARGUMENTS.slcatDateExp#">,
    slcatKeyword = <cfqueryparam cfsqltype="cf_sql_varchar" value="#TRIM(ARGUMENTS.slcatKeyword)#">,
    imgID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.imgID#">,
    slcatList = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.slcatList#">,
    slcatDateUpdate = <cfqueryparam cfsqltype="cf_sql_timestamp" value="#Now()#">,
    userID = <cfqueryparam cfsqltype="cf_sql_integer" value="#session.userID#">,
    slcatSort = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.slcatSort#">,
    cesID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.cesID#">,
    isShipToStore = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.isShipToStore#">,
    slcatStatus = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.slcatStatus#">
    WHERE ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ID#">
    </cfquery>
    </cftransaction>
    <!---Delete any existing relationships.--->
    <cfinvoke 
    component="MCMS.component.app.category.Category"
    method="deleteSecondaryLineCategoryDepartmentRel"
    returnvariable="deleteSecondaryLineCategoryDepartmentRelRet">
    <cfinvokeargument name="slcatID" value="#ARGUMENTS.ID#"/>
    </cfinvoke>
    <cfinvoke 
    component="MCMS.component.app.category.Category"
    method="deleteLineCategorySecondaryLineCategoryRel"
    returnvariable="deleteLineCategorySecondaryLineCategoryRelRet">
    <cfinvokeargument name="slcatID" value="#ARGUMENTS.ID#"/>
    </cfinvoke>
    <!---Create department/catalog relationships.--->
    <cfinvoke 
    component="MCMS.component.app.category.Category"
    method="insertSecondaryLineCategoryDepartmentRel"
    returnvariable="insertSecondaryLineCategoryDepartmentRelRet">
    <cfinvokeargument name="cID" value="#ARGUMENTS.cID#"/>
    <cfinvokeargument name="slcatID" value="#ARGUMENTS.ID#"/>
    <cfinvokeargument name="deptNo" value="#ARGUMENTS.deptNo#"/>
    <cfinvokeargument name="slcdrStatus" value="1"/>
    </cfinvoke>
    <!---Create line category/sec. line category relationships.--->
    <cfinvoke 
    component="MCMS.component.app.category.Category"
    method="insertLineCategorySecondaryLineCategoryRel"
    returnvariable="insertLineCategorySecondaryLineCategoryRelRet">
    <cfinvokeargument name="cID" value="#ARGUMENTS.cID#"/>
    <cfinvokeargument name="lcatID" value="#ARGUMENTS.lcatID#"/>
    <cfinvokeargument name="slcatID" value="#ARGUMENTS.ID#"/>
    <cfinvokeargument name="lcslcrStatus" value="1"/>
    </cfinvoke>
    </cfif>
    <cfcatch type="any">
    <cfset result.message = "There was an error updating the record.">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="updateCategoryDepartmentRel" access="public" returntype="struct">
    <cfargument name="ID" type="numeric" required="yes">
    <cfargument name="cID" type="numeric" required="yes">
    <cfargument name="catID" type="numeric" required="yes">
    <cfargument name="deptNo" type="numeric" required="yes">
    <cfargument name="cdrStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully updated the record.">
    <cftry>
    <!---Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.app.category.Category"
    method="getCategoryDepartmentRel"
    returnvariable="getCheckCategoryDepartmentRet">
    <cfinvokeargument name="excludeID" value="#ARGUMENTS.ID#"/>
    <cfinvokeargument name="catID" value="#ARGUMENTS.catID#"/>
    <cfinvokeargument name="cID" value="#ARGUMENTS.cID#"/>
    <cfinvokeargument name="deptNo" value="#ARGUMENTS.deptNo#"/>
    <cfinvokeargument name="cdrStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckCategoryDepartmentRet.recordcount NEQ 0>
    <cfset result.message = "The category department relationship already exists, please try again.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_category_department_rel SET
    cID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.cID#">,
    catID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.catID#">,
    deptNo = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.deptNo#">,
    cdrStatus = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.cdrStatus#">
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
    
    <cffunction name="updateSecondaryCategoryDepartmentRel" access="public" returntype="struct">
    <cfargument name="ID" type="numeric" required="yes">
    <cfargument name="cID" type="numeric" required="yes">
    <cfargument name="scatID" type="numeric" required="yes">
    <cfargument name="deptNo" type="numeric" required="yes">
    <cfargument name="scdrStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully updated the record.">
    <cftry>
    <!---Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.app.category.Category"
    method="getSecondaryCategoryDepartmentRel"
    returnvariable="getCheckSecondaryCategoryDepartmentRet">
    <cfinvokeargument name="excludeID" value="#ARGUMENTS.ID#"/>
    <cfinvokeargument name="cID" value="#ARGUMENTS.cID#"/>
    <cfinvokeargument name="scatID" value="#ARGUMENTS.scatID#"/>
    <cfinvokeargument name="deptNo" value="#ARGUMENTS.deptNo#"/>
    <cfinvokeargument name="scdrStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckSecondaryCategoryDepartmentRet.recordcount NEQ 0>
    <cfset result.message = "The secondary category department relationship already exists, please try again.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_sec_category_dept_rel SET
    cID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.cID#">,
    scatID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.scatID#">,
    deptNo = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.deptNo#">,
    scdrStatus = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.scdrStatus#">
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
    
    <cffunction name="updateLineCategoryDepartmentRel" access="public" returntype="struct">
    <cfargument name="ID" type="numeric" required="yes">
    <cfargument name="cID" type="numeric" required="yes">
    <cfargument name="lcatID" type="numeric" required="yes">
    <cfargument name="deptNo" type="numeric" required="yes">
    <cfargument name="lcdrStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully updated the record.">
    <cftry>
    <!---Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.app.category.Category"
    method="getLineCategoryDepartmentRel"
    returnvariable="getCheckLineCategoryDepartmentRet">
    <cfinvokeargument name="excludeID" value="#ARGUMENTS.ID#"/>
    <cfinvokeargument name="cID" value="#ARGUMENTS.cID#"/>
    <cfinvokeargument name="lcatID" value="#ARGUMENTS.lcatID#"/>
    <cfinvokeargument name="deptNo" value="#ARGUMENTS.deptNo#"/>
    <cfinvokeargument name="lcdrStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckLineCategoryDepartmentRet.recordcount NEQ 0>
    <cfset result.message = "The line category department relationship already exists, please try again.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_line_category_dept_rel SET
    cID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.cID#">,
    lcatID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.lcatID#">,
    deptNo = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.deptNo#">,
    lcdrStatus = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.lcdrStatus#">
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
    
    <cffunction name="updateSecondaryLineCategoryDepartmentRel" access="public" returntype="struct">
    <cfargument name="ID" type="numeric" required="yes">
    <cfargument name="cID" type="numeric" required="yes">
    <cfargument name="slcatID" type="numeric" required="yes">
    <cfargument name="deptNo" type="numeric" required="yes">
    <cfargument name="slcdrStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully updated the record.">
    <cftry>
    <!---Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.app.category.Category"
    method="getSecondaryLineCategoryDepartmentRel"
    returnvariable="getCheckSecondaryLineCategoryDepartmentRet">
    <cfinvokeargument name="excludeID" value="#ARGUMENTS.ID#"/>
    <cfinvokeargument name="cID" value="#ARGUMENTS.cID#"/>
    <cfinvokeargument name="slcatID" value="#ARGUMENTS.slcatID#"/>
    <cfinvokeargument name="deptNo" value="#ARGUMENTS.deptNo#"/>
    <cfinvokeargument name="slcdrStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckSecondaryLineCategoryDepartmentRet.recordcount NEQ 0>
    <cfset result.message = "The secondary line category department relationship already exists, please try again.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_sec_line_category_dept_rel SET
    cID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.cID#">,
    slcatID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.slcatID#">,
    deptNo = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.deptNo#">,
    slcdrStatus = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.slcdrStatus#">
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
    
    <cffunction name="updateCategoryExportStatus" access="public" returntype="struct" hint="Update the category export status.">
    <cfargument name="pID" type="numeric" required="yes">
    <cfargument name="cesID" type="numeric" required="yes" default="0">
    <cfset result.message = "The category export status has been updated. You may need to review the product/category again to ensure your changes are correct.">
    <cftry>
    <cfset this.cesID = 101>
    <cfif ARGUMENTS.cesID NEQ 0>
    <cfset this.cesID = ARGUMENTS.cesID>
    </cfif>
    <!---Get the category IDs for this product that will need to be exported and update the export status.--->
    <!---Update category.--->
    <cfinvoke 
    component="MCMS.component.app.product.Product" 
    method="getProductCategoryRel" 
    returnvariable="getProductCategoryRelRet">
    <cfinvokeargument name="pID" value="#ARGUMENTS.pID#">
    <cfinvokeargument name="pcrStatus" value="1,2,3">
    </cfinvoke>
    <cfif getProductCategoryRelRet.recordcount NEQ 0>
    <cfset this.catIDList = ValueList(getProductCategoryRelRet.catID)>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_category SET
    cesID = <cfqueryparam cfsqltype="cf_sql_integer" value="#this.cesID#">,
    catDateUpdate = <cfqueryparam cfsqltype="cf_sql_timestamp" value="#Now()#">
    WHERE ID IN (<cfqueryparam cfsqltype="cf_sql_integer" list="yes" value="#this.catIDList#">)
    </cfquery>
    </cftransaction>
    </cfif>  
    <!---Update secondary category.--->
    <cfinvoke 
    component="MCMS.component.app.product.Product" 
    method="getProductSecondaryCategoryRel" 
    returnvariable="getProductSecondaryCategoryRelRet">
    <cfinvokeargument name="pID" value="#ARGUMENTS.pID#">
    <cfinvokeargument name="pscrStatus" value="1,2,3">
    </cfinvoke>
    <cfif getProductSecondaryCategoryRelRet.recordcount NEQ 0>
    <cfset this.scatIDList = ValueList(getProductSecondaryCategoryRelRet.scatID)>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_secondary_category SET
    cesID = <cfqueryparam cfsqltype="cf_sql_integer" value="#this.cesID#">,
    scatDateUpdate = <cfqueryparam cfsqltype="cf_sql_timestamp" value="#Now()#">
    WHERE ID IN (<cfqueryparam cfsqltype="cf_sql_integer" list="yes" value="#this.scatIDList#">)
    </cfquery>
    </cftransaction>
    </cfif>
    <!---Update line category.--->
    <cfinvoke 
    component="MCMS.component.app.product.Product" 
    method="getProductLineCategoryRel" 
    returnvariable="getProductLineCategoryRelRet">
    <cfinvokeargument name="pID" value="#ARGUMENTS.pID#">
    <cfinvokeargument name="plcrStatus" value="1,2,3">
    </cfinvoke>
    <cfif getProductLineCategoryRelRet.recordcount NEQ 0>
    <cfset this.lcatIDList = ValueList(getProductLineCategoryRelRet.lcatID)>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_line_category SET
    cesID = <cfqueryparam cfsqltype="cf_sql_integer" value="#this.cesID#">,
    lcatDateUpdate = <cfqueryparam cfsqltype="cf_sql_timestamp" value="#Now()#">
    WHERE ID IN (<cfqueryparam cfsqltype="cf_sql_integer" list="yes" value="#this.lcatIDList#">)
    </cfquery>
    </cftransaction>
    </cfif>
    <!---Update secondary line category.--->
    <cfinvoke 
    component="MCMS.component.app.product.Product" 
    method="getProductSecondaryLineCategoryRel" 
    returnvariable="getProductSecondaryLineCategoryRelRet">
    <cfinvokeargument name="pID" value="#ARGUMENTS.pID#">
    <cfinvokeargument name="pslcrStatus" value="1,2,3">
    </cfinvoke>
    <cfif getProductSecondaryLineCategoryRelRet.recordcount NEQ 0>
    <cfset this.slcatIDList = ValueList(getProductSecondaryLineCategoryRelRet.slcatID)>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_sec_line_category SET
    cesID = <cfqueryparam cfsqltype="cf_sql_integer" value="#this.cesID#">,
    slcatDateUpdate = <cfqueryparam cfsqltype="cf_sql_timestamp" value="#Now()#">
    WHERE ID IN (<cfqueryparam cfsqltype="cf_sql_integer" list="yes" value="#this.slcatIDList#">)
    </cfquery>
    </cftransaction>
    </cfif>
    <cfcatch type="any">
    <cfset result.message = "There was an error updating the record.">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="updateCategoryStatus" access="public" returntype="struct">
    <cfargument name="ID" type="string" required="yes">
    <cfargument name="cesID" type="numeric" required="yes">
    <cfset result.message = "You have successfully updated the records.">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_category SET
    cesID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.cesID#">
    WHERE catNo = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.ID#">
    </cfquery>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_secondary_category SET
    cesID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.cesID#">
    WHERE scatNo = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.ID#">
    </cfquery>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_line_category SET
    cesID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.cesID#">
    WHERE lcatNo = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.ID#">
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error updating the records.">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="updateCategoryList" access="public" returntype="struct">
    <cfargument name="ID" type="numeric" required="yes">
    <cfargument name="catStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully updated the records.">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_category SET
    catStatus = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.catStatus#">
    WHERE ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ID#">
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error updating the records.">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="updateCategoryDepartmentRelList" access="public" returntype="struct">
    <cfargument name="ID" type="numeric" required="yes">
    <cfargument name="cdrStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully updated the records.">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_category_department_rel SET
    cdrStatus = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.cdrStatus#">
    WHERE ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ID#">
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error updating the records.">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="updateSecondaryCategoryList" access="public" returntype="struct">
    <cfargument name="ID" type="numeric" required="yes">
    <cfargument name="scatStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully updated the records.">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_secondary_category SET
    scatStatus = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.scatStatus#">
    WHERE ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ID#">
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error updating the records.">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="updateSecondaryCategoryDepartmentRelList" access="public" returntype="struct">
    <cfargument name="ID" type="numeric" required="yes">
    <cfargument name="scdrStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully updated the records.">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_sec_category_dept_rel SET
    scdrStatus = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.scdrStatus#">
    WHERE ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ID#">
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error updating the records.">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="updateLineCategoryList" access="public" returntype="struct">
    <cfargument name="ID" type="numeric" required="yes">
    <cfargument name="lcatStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully updated the records.">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_line_category SET
    lcatStatus = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.lcatStatus#">
    WHERE ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ID#">
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error updating the records.">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="updateLineCategoryDepartmentRelList" access="public" returntype="struct">
    <cfargument name="ID" type="numeric" required="yes">
    <cfargument name="lcdrStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully updated the records.">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_line_category_dept_rel SET
    lcdrStatus = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.lcdrStatus#">
    WHERE ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ID#">
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error updating the records.">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="updateSecondaryLineCategoryDepartmentRelList" access="public" returntype="struct">
    <cfargument name="ID" type="numeric" required="yes">
    <cfargument name="slcdrStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully updated the records.">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_sec_line_category_dept_rel SET
    slcdrStatus = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.slcdrStatus#">
    WHERE ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ID#">
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error updating the records.">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="deleteCategory" access="public" returntype="struct">
    <cfargument name="ID" type="string" required="yes">
    <cfset result.message = "You have successfully deleted the record(s).">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    DELETE FROM tbl_category
    WHERE ID IN (<cfqueryparam cfsqltype="cf_sql_integer" list="yes" value="#ARGUMENTS.ID#">)
    </cfquery>
	<cfinvoke 
    component="MCMS.component.app.category.Category"
    method="deleteCategoryMegaMenuRel"
    returnvariable="result">
    <cfinvokeargument name="catID" value="#ARGUMENTS.ID#"/>
    </cfinvoke>
    <cfinvoke 
    component="MCMS.component.app.category.Category"
    method="deleteCategoryDepartmentRel"
    returnvariable="result">
    <cfinvokeargument name="catID" value="#ARGUMENTS.ID#"/>
    </cfinvoke>
    <cfinvoke 
    component="MCMS.component.app.category.Category"
    method="deleteSecondaryCategoryLineCategoryRel"
    returnvariable="result">
    <cfinvokeargument name="catID" value="#ARGUMENTS.ID#"/>
    </cfinvoke>
    <cfinvoke 
    component="MCMS.component.app.product.Product"
    method="deleteProductCategoryRel"
    returnvariable="result">
    <cfinvokeargument name="catID" value="#ARGUMENTS.ID#"/>
    </cfinvoke>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error deleting the record(s).">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="deleteSecondaryCategory" access="public" returntype="struct">
    <cfargument name="ID" type="string" required="yes">
    <cfset result.message = "You have successfully deleted the record(s).">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    DELETE FROM tbl_secondary_category
    WHERE ID IN (<cfqueryparam cfsqltype="cf_sql_integer" list="yes" value="#ARGUMENTS.ID#">)
    </cfquery>
    <cfinvoke 
    component="MCMS.component.app.category.Category"
    method="deleteSecondaryCategoryDepartmentRel"
    returnvariable="result">
    <cfinvokeargument name="scatID" value="#ARGUMENTS.ID#"/>
    </cfinvoke>
    <cfinvoke 
    component="MCMS.component.app.category.Category"
    method="deleteSecondaryCategoryLineCategoryRel"
    returnvariable="result">
    <cfinvokeargument name="scatID" value="#ARGUMENTS.ID#"/>
    </cfinvoke>
    <cfinvoke 
    component="MCMS.component.app.product.Product"
    method="deleteProductSecondaryCategoryRel"
    returnvariable="result">
    <cfinvokeargument name="scatID" value="#ARGUMENTS.ID#"/>
    </cfinvoke>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error deleting the record(s).">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction> 
    
    <cffunction name="deleteLineCategory" access="public" returntype="struct">
    <cfargument name="ID" type="string" required="yes">
    <cfset result.message = "You have successfully deleted the record(s).">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    DELETE FROM tbl_line_category
    WHERE ID IN (<cfqueryparam cfsqltype="cf_sql_integer" list="yes" value="#ARGUMENTS.ID#">)
    </cfquery>
    <cfinvoke 
    component="MCMS.component.app.category.Category"
    method="deleteLineCategoryDepartmentRel"
    returnvariable="result">
    <cfinvokeargument name="lcatID" value="#ARGUMENTS.ID#"/>
    </cfinvoke>
    <cfinvoke 
    component="MCMS.component.app.category.Category"
    method="deleteSecondaryCategoryLineCategoryRel"
    returnvariable="result">
    <cfinvokeargument name="lcatID" value="#ARGUMENTS.ID#"/>
    </cfinvoke>
    <cfinvoke 
    component="MCMS.component.app.product.Product"
    method="deleteProductLineCategoryRel"
    returnvariable="result">
    <cfinvokeargument name="lcatID" value="#ARGUMENTS.ID#"/>
    </cfinvoke>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error deleting the record(s).">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction> 
    
    <cffunction name="deleteSecondaryLineCategory" access="public" returntype="struct">
    <cfargument name="ID" type="string" required="yes">
    <cfset result.message = "You have successfully deleted the record(s).">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    DELETE FROM tbl_sec_line_category
    WHERE ID IN (<cfqueryparam cfsqltype="cf_sql_integer" list="yes" value="#ARGUMENTS.ID#">)
    </cfquery>
    <cfinvoke 
    component="MCMS.component.app.category.Category"
    method="deleteSecondaryLineCategoryDepartmentRel"
    returnvariable="result">
    <cfinvokeargument name="slcatID" value="#ARGUMENTS.ID#"/>
    </cfinvoke>
    <cfinvoke 
    component="MCMS.component.app.category.Category"
    method="deleteLineCategorySecondaryLineCategoryRel"
    returnvariable="result">
    <cfinvokeargument name="slcatID" value="#ARGUMENTS.ID#"/>
    </cfinvoke>
    <cfinvoke 
    component="MCMS.component.app.product.Product"
    method="deleteProductSecondaryLineCategoryRel"
    returnvariable="result">
    <cfinvokeargument name="slcatID" value="#ARGUMENTS.ID#"/>
    </cfinvoke>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error deleting the record(s).">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="deleteCategoryMegaMenuRel" access="public" returntype="struct">
    <cfargument name="ID" type="string" required="yes" default="0">
    <cfargument name="catID" type="string" required="yes" default="0">
    <cfset result.message = "You have successfully deleted the record(s).">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    DELETE FROM tbl_category_mega_menu_rel
    WHERE ID IN (<cfqueryparam cfsqltype="cf_sql_integer" list="yes" value="#ARGUMENTS.ID#">)
    OR catID IN (<cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.catID#">)
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error deleting the record(s).">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="deleteCategoryDepartmentRel" access="public" returntype="struct">
    <cfargument name="ID" type="string" required="yes" default="0">
    <cfargument name="catID" type="string" required="yes" default="0">
    <cfset result.message = "You have successfully deleted the record(s).">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    DELETE FROM tbl_category_department_rel
    WHERE ID IN (<cfqueryparam cfsqltype="cf_sql_integer" list="yes" value="#ARGUMENTS.ID#">)
    OR catID IN (<cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.catID#">)
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error deleting the record(s).">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="deleteSecondaryCategoryDepartmentRel" access="public" returntype="struct">
    <cfargument name="ID" type="string" required="yes" default="0">
    <cfargument name="scatID" type="string" required="yes" default="0">
    <cfset result.message = "You have successfully deleted the record(s).">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    DELETE FROM tbl_sec_category_dept_rel
    WHERE ID IN (<cfqueryparam cfsqltype="cf_sql_integer" list="yes" value="#ARGUMENTS.ID#">)
    OR scatID IN (<cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.scatID#">)
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error deleting the record(s).">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="deleteCategorySecondaryCategoryRel" access="public" returntype="struct">
    <cfargument name="ID" type="string" required="yes" default="0">
    <cfargument name="scatID" type="string" required="yes" default="0">
    <cfargument name="catID" type="string" required="yes" default="0">
    <cfset result.message = "You have successfully deleted the record(s).">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    DELETE FROM tbl_category_sc_rel
    WHERE ID IN (<cfqueryparam cfsqltype="cf_sql_integer" list="yes" value="#ARGUMENTS.ID#">)
    OR scatID IN (<cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.scatID#">)
    OR catID IN (<cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.catID#">)
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error deleting the record(s).">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="deleteLineCategoryDepartmentRel" access="public" returntype="struct">
    <cfargument name="ID" type="string" required="yes" default="0">
    <cfargument name="lcatID" type="string" required="yes" default="0">
    <cfset result.message = "You have successfully deleted the record(s).">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    DELETE FROM tbl_line_category_dept_rel
    WHERE ID IN (<cfqueryparam cfsqltype="cf_sql_integer" list="yes" value="#ARGUMENTS.ID#">)
    OR lcatID IN (<cfqueryparam cfsqltype="cf_sql_integer" list="yes" value="#ARGUMENTS.lcatID#">)
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error deleting the record(s).">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="deleteSecondaryLineCategoryDepartmentRel" access="public" returntype="struct">
    <cfargument name="ID" type="string" required="yes" default="0">
    <cfargument name="slcatID" type="string" required="yes" default="0">
    <cfset result.message = "You have successfully deleted the record(s).">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    DELETE FROM tbl_sec_line_category_dept_rel
    WHERE ID IN (<cfqueryparam cfsqltype="cf_sql_integer" list="yes" value="#ARGUMENTS.ID#">)
    OR slcatID IN (<cfqueryparam cfsqltype="cf_sql_integer" list="yes" value="#ARGUMENTS.slcatID#">)
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error deleting the record(s).">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="deleteSecondaryCategoryLineCategoryRel" access="public" returntype="struct">
    <cfargument name="ID" type="string" required="yes" default="0">
    <cfargument name="lcatID" type="string" required="yes" default="0">
    <cfargument name="scatID" type="string" required="yes" default="0">
    <cfargument name="catID" type="string" required="yes" default="0">
    <cfset result.message = "You have successfully deleted the record(s).">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    DELETE FROM tbl_sec_category_lc_rel
    WHERE ID IN (<cfqueryparam cfsqltype="cf_sql_integer" list="yes" value="#ARGUMENTS.ID#">)
    OR lcatID IN (<cfqueryparam cfsqltype="cf_sql_integer" list="yes" value="#ARGUMENTS.lcatID#">)
    OR scatID IN (<cfqueryparam cfsqltype="cf_sql_integer" list="yes" value="#ARGUMENTS.scatID#">)
    <cfif ARGUMENTS.catID NEQ 0>
    OR catID IN (<cfqueryparam cfsqltype="cf_sql_integer" list="yes" value="#ARGUMENTS.catID#">)
    </cfif>
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error deleting the record(s).">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="deleteLineCategorySecondaryLineCategoryRel" access="public" returntype="struct">
    <cfargument name="ID" type="string" required="yes" default="0">
    <cfargument name="slcatID" type="string" required="yes" default="0">
    <cfargument name="lcatID" type="string" required="yes" default="0">
    <cfargument name="catID" type="string" required="yes" default="0">
    <cfset result.message = "You have successfully deleted the record(s).">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    DELETE FROM tbl_line_category_slc_rel
    WHERE ID IN (<cfqueryparam cfsqltype="cf_sql_integer" list="yes" value="#ARGUMENTS.ID#">)
    OR slcatID IN (<cfqueryparam cfsqltype="cf_sql_integer" list="yes" value="#ARGUMENTS.slcatID#">)
    OR lcatID IN (<cfqueryparam cfsqltype="cf_sql_integer" list="yes" value="#ARGUMENTS.lcatID#">)
    <cfif ARGUMENTS.catID NEQ 0>
    OR catID IN (<cfqueryparam cfsqltype="cf_sql_integer" list="yes" value="#ARGUMENTS.catID#">)
    </cfif>
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error deleting the record(s).">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="categoryExists" access="public" returntype="string">
    <cfargument name="catName" type="string" required="yes" default="">
    <cfset found = "false">
    <cfinvoke 
    component="MCMS.component.app.category.Category"
    method="getCategory"
    returnvariable="getCategoryRet">
    <cfinvokeargument name="catName" value="#ARGUMENTS.catName#"/>
    <cfinvokeargument name="catStatus" value="1"/>
    </cfinvoke>
    <cfif getCategoryRet.RecordCount NEQ 0>
    <cfset found = "Found a match in Category.">
    </cfif>
    <cfinvoke 
    component="MCMS.component.app.category.Category"
    method="getSecondaryCategory"
    returnvariable="getSecondaryCategoryRet">
    <cfinvokeargument name="scatName" value="#ARGUMENTS.catName#"/>
    <cfinvokeargument name="scatStatus" value="1"/>
    </cfinvoke>
    <cfif getSecondaryCategoryRet.RecordCount NEQ 0>
    <cfset found = "Found a match in Secondary Category.">
    </cfif>
    <cfinvoke 
    component="MCMS.component.app.category.Category"
    method="getLineCategory"
    returnvariable="getLineCategoryRet">
    <cfinvokeargument name="lcatName" value="#ARGUMENTS.catName#"/>
    <cfinvokeargument name="lcatStatus" value="1"/>
    </cfinvoke>
    <cfif getLineCategoryRet.RecordCount NEQ 0>
    <cfset found = "Found a match in Line Category.">
    </cfif>
    <cfinvoke 
    component="MCMS.component.app.category.Category"
    method="getSecondaryLineCategory"
    returnvariable="getSecondaryLineCategoryRet">
    <cfinvokeargument name="slcatName" value="#ARGUMENTS.catName#"/>
    <cfinvokeargument name="slcatStatus" value="1"/>
    </cfinvoke>
    <cfif getSecondaryLineCategoryRet.RecordCount NEQ 0>
    <cfset found = "Found a match in Secondary Line Category.">
    </cfif>
    <cfreturn found>
    </cffunction>
</cfcomponent>