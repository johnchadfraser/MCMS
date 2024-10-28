<cfcomponent>
    <cffunction name="getPWFItem" access="public" returntype="query" hint="Get PWF Item data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="ID" type="string" required="yes" default="0">
    <cfargument name="excludeID" type="numeric" required="yes" default="0">
    <cfargument name="excludepwfisID" type="string" required="yes" default="0">
    <cfargument name="sID" type="string" required="yes" default="">
    <cfargument name="pID" type="string" required="yes" default="">
    <cfargument name="ppID" type="numeric" required="yes" default="0">
    <cfargument name="skuID" type="string" required="yes" default="">
    <cfargument name="siteNo" type="string" required="yes" default="100">
    <cfargument name="deptNo" type="string" required="yes" default="0">
    <cfargument name="pwfiDate" type="string" required="yes" default="">
    <cfargument name="pwfiDateDue" type="string" required="yes" default="">
    <cfargument name="pwfiDateHistory" type="string" required="yes" default="">
    <cfargument name="pwfisID" type="string" required="yes" default="0">
    <cfargument name="pwfiStatus" type="string" required="yes" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="pwfiDateDue, ppID, pwfiQOH DESC, pName, pwfiStatus">
    <cfset var rsPWFItem = "" >
    <cftry>
    <cfquery name="rsPWFItem" datasource="#application.mcmsDSN#">
    SELECT * FROM v_pwf_item WHERE 0=0
    <cfif ARGUMENTS.ID NEQ 0>
    AND ID IN (<cfqueryparam value="#ARGUMENTS.ID#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    <cfif ARGUMENTS.excludeID NEQ 0>
    AND ID <> <cfqueryparam value="#ARGUMENTS.excludeID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.excludepwfisID NEQ 0>
    AND pwfisID NOT IN (<cfqueryparam value="#ARGUMENTS.excludepwfisID#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(skuID) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(pName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(skuUPC) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">)
    </cfif>
    <cfif ARGUMENTS.pID NEQ "">
    AND pID IN (<cfqueryparam value="#ARGUMENTS.pID#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    <cfif ARGUMENTS.ppID NEQ 0>
    AND ppID = <cfqueryparam value="#ARGUMENTS.ppID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.siteNo NEQ 100>
    AND siteNo IN (<cfqueryparam value="#ARGUMENTS.siteNo#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    <cfif ARGUMENTS.deptNo NEQ 0>
    AND deptNo IN (<cfqueryparam value="#ARGUMENTS.deptNo#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    <cfif ARGUMENTS.sID NEQ "">
    AND sID IN (<cfqueryparam value="#ARGUMENTS.sID#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    <cfif ARGUMENTS.skuID NEQ "">
    AND UPPER(skuID) IN (<cfqueryparam value="#UCASE(ARGUMENTS.skuID)#" list="yes" cfsqltype="cf_sql_varchar">)
    </cfif>
    <cfif ARGUMENTS.pwfiDate NEQ ''>
    AND pwfiDate >= <cfqueryparam value="#ARGUMENTS.pwfiDate#" cfsqltype="cf_sql_date">
    </cfif>
    <cfif ARGUMENTS.pwfiDateDue NEQ ''>
    AND pwfiDateDue >= <cfqueryparam value="#ARGUMENTS.pwfiDateDue#" cfsqltype="cf_sql_date">
    </cfif>
    <cfif ARGUMENTS.pwfiDateHistory NEQ ''>
    AND pwfiDateDue >= <cfqueryparam value="#ARGUMENTS.pwfiDateHistory#" cfsqltype="cf_sql_date">
    </cfif>
    <cfif ARGUMENTS.pwfisID NEQ 0>
    AND pwfisID IN (<cfqueryparam value="#ARGUMENTS.pwfisID#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    AND pwfiStatus IN (<cfqueryparam value="#ARGUMENTS.pwfiStatus#" list="yes" cfsqltype="cf_sql_integer">)
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsPWFItem = StructNew()>
    <cfset rsPWFItem.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsPWFItem>
    </cffunction>
    
    <cffunction name="getPWFItemLog" access="public" returntype="query" hint="Get PWF Item Log data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="ID" type="numeric" required="yes" default="0">
    <cfargument name="excludeID" type="numeric" required="yes" default="0">
    <cfargument name="sID" type="string" required="yes" default="">
    <cfargument name="pID" type="string" required="yes" default="">
    <cfargument name="ppID" type="numeric" required="yes" default="0">
    <cfargument name="pwfiID" type="numeric" required="yes" default="0">
    <cfargument name="skuID" type="string" required="yes" default="">
    <cfargument name="siteNo" type="string" required="yes" default="100">
    <cfargument name="deptNo" type="string" required="yes" default="0">
    <cfargument name="pwfiDate" type="string" required="yes" default="">
    <cfargument name="pwfiDateHistory" type="string" required="yes" default="">
    <cfargument name="pwfisID" type="string" required="yes" default="0">
    <cfargument name="pwfilStatus" type="string" required="yes" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="pID, sID, pwfilDate DESC">
    <cfset var rsPWFItemLog = "" >
    <cftry>
    <cfquery name="rsPWFItemLog" datasource="#application.mcmsDSN#">
    SELECT * FROM v_pwf_item_log WHERE 0=0
    <cfif ARGUMENTS.ID NEQ 0>
    AND ID = <cfqueryparam value="#ARGUMENTS.ID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.excludeID NEQ 0>
    AND ID <> <cfqueryparam value="#ARGUMENTS.excludeID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(skuID) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(pName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">)
    </cfif>
    <cfif ARGUMENTS.pID NEQ "">
    AND pID IN (<cfqueryparam value="#ARGUMENTS.pID#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    <cfif ARGUMENTS.pwfiID NEQ 0>
    AND pwfiID = <cfqueryparam value="#ARGUMENTS.pwfiID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.ppID NEQ 0>
    AND ppID = <cfqueryparam value="#ARGUMENTS.ppID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.siteNo NEQ 100>
    AND siteNo IN (<cfqueryparam value="#ARGUMENTS.siteNo#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    <cfif ARGUMENTS.deptNo NEQ 0>
    AND deptNo IN (<cfqueryparam value="#ARGUMENTS.deptNo#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    <cfif ARGUMENTS.sID NEQ "">
    AND sID IN (<cfqueryparam value="#ARGUMENTS.sID#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    <cfif ARGUMENTS.skuID NEQ "">
    AND UPPER(skuID) IN (<cfqueryparam value="#UCASE(ARGUMENTS.skuID)#" list="yes" cfsqltype="cf_sql_varchar">)
    </cfif>
    <cfif ARGUMENTS.pwfiDate NEQ ''>
    AND pwfiDate >= <cfqueryparam value="#ARGUMENTS.pwfiDate#" cfsqltype="cf_sql_date">
    </cfif>
    <cfif ARGUMENTS.pwfiDateHistory NEQ ''>
    AND pwfiDate <= <cfqueryparam value="#ARGUMENTS.pwfiDateHistory#" cfsqltype="cf_sql_date">
    </cfif>
    <cfif ARGUMENTS.pwfisID NEQ 0>
    AND pwfisID IN (<cfqueryparam value="#ARGUMENTS.pwfisID#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    AND pwfilStatus IN (<cfqueryparam value="#ARGUMENTS.pwfilStatus#" list="yes" cfsqltype="cf_sql_integer">)
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsPWFItemLog = StructNew()>
    <cfset rsPWFItemLog.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsPWFItemLog>
    </cffunction>
    
    <cffunction name="getPWFItemImageRel" access="public" returntype="query" hint="Get PWF Item Image Rel. data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="ID" type="numeric" required="yes" default="0">
    <cfargument name="excludeID" type="numeric" required="yes" default="0">
    <cfargument name="sID" type="string" required="yes" default="">
    <cfargument name="pID" type="string" required="yes" default="">
    <cfargument name="pwfiID" type="numeric" required="yes" default="0">
    <cfargument name="pwfiasID" type="string" required="yes" default="">
    <cfargument name="imgID" type="string" required="yes" default="0">
    <cfargument name="ppID" type="numeric" required="yes" default="0">
    <cfargument name="skuID" type="string" required="yes" default="">
    <cfargument name="siteNo" type="string" required="yes" default="100">
    <cfargument name="deptNo" type="string" required="yes" default="0">
    <cfargument name="pwfiDate" type="string" required="yes" default="">
    <cfargument name="pwfiDateHistory" type="string" required="yes" default="">
    <cfargument name="pwfisID" type="string" required="yes" default="0">
    <cfargument name="pwfiStatus" type="string" required="yes" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="imgName, pID, sID">
    <cfset var rsPWFItemImageRel = "" >
    <cftry>
    <cfquery name="rsPWFItemImageRel" datasource="#application.mcmsDSN#">
    SELECT * FROM v_pwf_item_image_rel WHERE 0=0
    <cfif ARGUMENTS.ID NEQ 0>
    AND ID = <cfqueryparam value="#ARGUMENTS.ID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.excludeID NEQ 0>
    AND ID <> <cfqueryparam value="#ARGUMENTS.excludeID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(skuID) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(pName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">)
    </cfif>
    <cfif ARGUMENTS.pID NEQ "">
    AND pID IN (<cfqueryparam value="#ARGUMENTS.pID#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    <cfif ARGUMENTS.pwfiasID NEQ "">
    AND pwfiasID IN (<cfqueryparam value="#ARGUMENTS.pwfiasID#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    <cfif ARGUMENTS.pwfiID NEQ 0>
    AND pwfiID = <cfqueryparam value="#ARGUMENTS.pwfiID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.imgID NEQ 0>
    AND imgID = <cfqueryparam value="#ARGUMENTS.imgID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.ppID NEQ 0>
    AND ppID = <cfqueryparam value="#ARGUMENTS.ppID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.siteNo NEQ 100>
    AND siteNo IN (<cfqueryparam value="#ARGUMENTS.siteNo#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    <cfif ARGUMENTS.deptNo NEQ 0>
    AND deptNo IN (<cfqueryparam value="#ARGUMENTS.deptNo#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    <cfif ARGUMENTS.sID NEQ "">
    AND sID IN (<cfqueryparam value="#ARGUMENTS.sID#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    <cfif ARGUMENTS.skuID NEQ "">
    AND UPPER(skuID) IN (<cfqueryparam value="#UCASE(ARGUMENTS.skuID)#" list="yes" cfsqltype="cf_sql_varchar">)
    </cfif>
    <cfif ARGUMENTS.pwfiDate NEQ ''>
    AND pwfiDate >= <cfqueryparam value="#ARGUMENTS.pwfiDate#" cfsqltype="cf_sql_date">
    </cfif>
    <cfif ARGUMENTS.pwfiDateHistory NEQ ''>
    AND pwfiDate <= <cfqueryparam value="#ARGUMENTS.pwfiDateHistory#" cfsqltype="cf_sql_date">
    </cfif>
    <cfif ARGUMENTS.pwfisID NEQ 0>
    AND pwfisID IN (<cfqueryparam value="#ARGUMENTS.pwfisID#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    AND pwfiirStatus IN (<cfqueryparam value="#ARGUMENTS.pwfiirStatus#" list="yes" cfsqltype="cf_sql_integer">)
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsPWFItemImageRel = StructNew()>
    <cfset rsPWFItemImageRel.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsPWFItemImageRel>
    </cffunction>
    
    <cffunction name="getPWFImageApprovalStatus" access="public" returntype="query" hint="Get PWF Image Approval Status data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="ID" type="numeric" required="yes" default="0">
    <cfargument name="excludeID" type="numeric" required="yes" default="0">
    <cfargument name="pwfiasName" type="string" required="yes" default="">
    <cfargument name="pwfiasStatus" type="string" required="yes" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="pwfiasSort, pwfiasName">
    <cfset var rsPWFImageApprovalStatus = "" >
    <cftry>
    <cfquery name="rsPWFImageApprovalStatus" datasource="#application.mcmsDSN#">
    SELECT * FROM v_pwf_image_approval_status WHERE 0=0
    <cfif ARGUMENTS.ID NEQ 0>
    AND ID = <cfqueryparam value="#ARGUMENTS.ID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.excludeID NEQ 0>
    AND ID <> <cfqueryparam value="#ARGUMENTS.excludeID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(pwfiasName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(pwfiasDescription) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">)
    </cfif>
    <cfif ARGUMENTS.pwfiasName NEQ "">
    AND UPPER(pwfiasName) = <cfqueryparam value="#UCASE(ARGUMENTS.pwfiasName)#" cfsqltype="cf_sql_varchar">
    </cfif>
    AND pwfiasStatus IN (<cfqueryparam value="#ARGUMENTS.pwfiasStatus#" list="yes" cfsqltype="cf_sql_integer">)
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsPWFImageApprovalStatus = StructNew()>
    <cfset rsPWFImageApprovalStatus.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsPWFImageApprovalStatus>
    </cffunction>
    
    <cffunction name="getPWFImageApprovalType" access="public" returntype="query" hint="Get PWF Image Approval Type data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="ID" type="numeric" required="yes" default="0">
    <cfargument name="excludeID" type="numeric" required="yes" default="0">
    <cfargument name="pwfiatName" type="string" required="yes" default="">
    <cfargument name="pwfiatStatus" type="string" required="yes" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="pwfiatSort, pwfiatName">
    <cfset var rsPWFImageApprovalType = "" >
    <cftry>
    <cfquery name="rsPWFImageApprovalType" datasource="#application.mcmsDSN#">
    SELECT * FROM v_pwf_image_approval_type WHERE 0=0
    <cfif ARGUMENTS.ID NEQ 0>
    AND ID = <cfqueryparam value="#ARGUMENTS.ID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.excludeID NEQ 0>
    AND ID <> <cfqueryparam value="#ARGUMENTS.excludeID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(pwfiatName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(pwfiatDescription) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">)
    </cfif>
    <cfif ARGUMENTS.pwfiatName NEQ "">
    AND UPPER(pwfiatName) = <cfqueryparam value="#UCASE(ARGUMENTS.pwfiatName)#" cfsqltype="cf_sql_varchar">
    </cfif>
    AND pwfiatStatus IN (<cfqueryparam value="#ARGUMENTS.pwfiatStatus#" list="yes" cfsqltype="cf_sql_integer">)
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsPWFImageApprovalType = StructNew()>
    <cfset rsPWFImageApprovalType.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsPWFImageApprovalType>
    </cffunction>
    
    <cffunction name="getPWFImageViewGroupType" access="public" returntype="query" hint="Get PWF Image View Group Type data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="ID" type="numeric" required="yes" default="0">
    <cfargument name="excludeID" type="numeric" required="yes" default="0">
    <cfargument name="pwfivgtName" type="string" required="yes" default="">
    <cfargument name="deptNo" type="string" required="yes" default="0">
    <cfargument name="pwfivgtStatus" type="string" required="yes" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="pwfivgtSort, pwfivgtName">
    <cfset var rsPWFImageViewGroupType = "" >
    <cftry>
    <cfquery name="rsPWFImageViewGroupType" datasource="#application.mcmsDSN#">
    SELECT * FROM v_pwf_image_view_group_type WHERE 0=0
    <cfif ARGUMENTS.ID NEQ 0>
    AND ID = <cfqueryparam value="#ARGUMENTS.ID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.excludeID NEQ 0>
    AND ID <> <cfqueryparam value="#ARGUMENTS.excludeID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(pwfivgtName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(pwfivgtDescription) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">)
    </cfif>
    <cfif ARGUMENTS.pwfivgtName NEQ "">
    AND UPPER(pwfivgtName) = <cfqueryparam value="#UCASE(ARGUMENTS.pwfivgtName)#" cfsqltype="cf_sql_varchar">
    </cfif>
    <cfif ARGUMENTS.deptNo NEQ 0>
    AND deptNo IN (<cfqueryparam value="#ARGUMENTS.deptNo#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    AND pwfivgtStatus IN (<cfqueryparam value="#ARGUMENTS.pwfivgtStatus#" list="yes" cfsqltype="cf_sql_integer">)
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsPWFImageViewGroupType = StructNew()>
    <cfset rsPWFImageViewGroupType.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsPWFImageViewGroupType>
    </cffunction>
    
    <cffunction name="getPWFImageViewType" access="public" returntype="query" hint="Get PWF Image View Type data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="ID" type="numeric" required="yes" default="0">
    <cfargument name="excludeID" type="numeric" required="yes" default="0">
    <cfargument name="pwfivtName" type="string" required="yes" default="">
    <cfargument name="pwfivtStatus" type="string" required="yes" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="pwfivtSort, pwfivtName">
    <cfset var rsPWFImageViewType = "" >
    <cftry>
    <cfquery name="rsPWFImageViewType" datasource="#application.mcmsDSN#">
    SELECT * FROM v_pwf_image_view_type WHERE 0=0
    <cfif ARGUMENTS.ID NEQ 0>
    AND ID = <cfqueryparam value="#ARGUMENTS.ID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.excludeID NEQ 0>
    AND ID <> <cfqueryparam value="#ARGUMENTS.excludeID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(pwfivtName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(pwfivtDescription) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">)
    </cfif>
    <cfif ARGUMENTS.pwfivtName NEQ "">
    AND UPPER(pwfivtName) = <cfqueryparam value="#UCASE(ARGUMENTS.pwfivtName)#" cfsqltype="cf_sql_varchar">
    </cfif>
    AND pwfivtStatus IN (<cfqueryparam value="#ARGUMENTS.pwfivtStatus#" list="yes" cfsqltype="cf_sql_integer">)
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsPWFImageViewType = StructNew()>
    <cfset rsPWFImageViewType.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsPWFImageViewType>
    </cffunction>
    
    <cffunction name="getPWFImageViewGroupTypeRel" access="public" returntype="query" hint="Get PWF Image View Group Type Rel data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="ID" type="numeric" required="yes" default="0">
    <cfargument name="excludeID" type="numeric" required="yes" default="0">
    <cfargument name="excludepwfivtID" type="string" required="yes" default="0">
    <cfargument name="pwfivtID" type="string" required="yes" default="0">
    <cfargument name="pwfivgtID" type="string" required="yes" default="0">
    <cfargument name="pwfivgtrStatus" type="string" required="yes" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="pwfivgtSort, pwfivtSort">
    <cfset var rsPWFImageViewGroupTypeRel = "" >
    <cftry>
    <cfquery name="rsPWFImageViewGroupTypeRel" datasource="#application.mcmsDSN#">
    SELECT * FROM v_pwf_image_v_group_type_rel WHERE 0=0
    <cfif ARGUMENTS.ID NEQ 0>
    AND ID = <cfqueryparam value="#ARGUMENTS.ID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.excludeID NEQ 0>
    AND ID <> <cfqueryparam value="#ARGUMENTS.excludeID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.excludepwfivtID NEQ 0>
    AND pwfivtID NOT IN (<cfqueryparam value="#ARGUMENTS.excludepwfivtID#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(pwfivgtName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(pwfivtName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">)
    </cfif>
    <cfif ARGUMENTS.pwfivtID NEQ 0>
    AND pwfivtID IN (<cfqueryparam value="#ARGUMENTS.pwfivtID#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    <cfif ARGUMENTS.pwfivgtID NEQ 0>
    AND pwfivgtID IN (<cfqueryparam value="#ARGUMENTS.pwfivgtID#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    AND pwfivgtrStatus IN (<cfqueryparam value="#ARGUMENTS.pwfivgtrStatus#" list="yes" cfsqltype="cf_sql_integer">)
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsPWFImageViewGroupTypeRel = StructNew()>
    <cfset rsPWFImageViewGroupTypeRel.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsPWFImageViewGroupTypeRel>
    </cffunction>
    
    <cffunction name="getPWFImageApprovalStatusTypeRel" access="public" returntype="query" hint="Get PWF Image Approval Status Type Rel data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="ID" type="numeric" required="yes" default="0">
    <cfargument name="excludeID" type="numeric" required="yes" default="0">
    <cfargument name="pwfiatID" type="string" required="yes" default="0">
    <cfargument name="pwfiasID" type="string" required="yes" default="0">
    <cfargument name="pwfiatsrStatus" type="string" required="yes" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="pwfiasSort, pwfiatSort">
    <cfset var rsPWFImageApprovalStatusTypeRel = "" >
    <cftry>
    <cfquery name="rsPWFImageApprovalStatusTypeRel" datasource="#application.mcmsDSN#">
    SELECT * FROM v_pwf_image_approval_t_s_rel WHERE 0=0
    <cfif ARGUMENTS.ID NEQ 0>
    AND ID = <cfqueryparam value="#ARGUMENTS.ID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.excludeID NEQ 0>
    AND ID <> <cfqueryparam value="#ARGUMENTS.excludeID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(pwfiasName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(pwfiatName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">)
    </cfif>
    <cfif ARGUMENTS.pwfiasID NEQ 0>
    AND pwfiasID IN (<cfqueryparam value="#ARGUMENTS.pwfiasID#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    <cfif ARGUMENTS.pwfiatID NEQ 0>
    AND pwfiatID IN (<cfqueryparam value="#ARGUMENTS.pwfiatID#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    AND pwfiatsrStatus IN (<cfqueryparam value="#ARGUMENTS.pwfiatsrStatus#" list="yes" cfsqltype="cf_sql_integer">)
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsPWFImageApprovalStatusTypeRel = StructNew()>
    <cfset rsPWFImageApprovalStatusTypeRel.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsPWFImageApprovalStatusTypeRel>
    </cffunction>
    
    <cffunction name="getPWFItemConditionType" access="public" returntype="query" hint="Get PWF Item Condition Type data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="ID" type="numeric" required="yes" default="0">
    <cfargument name="excludeID" type="numeric" required="yes" default="0">
    <cfargument name="pwfictName" type="string" required="yes" default="">
    <cfargument name="pwfictStatus" type="string" required="yes" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="pwfictSort, pwfictName">
    <cfset var rsPWFItemConditionType = "" >
    <cftry>
    <cfquery name="rsPWFItemConditionType" datasource="#application.mcmsDSN#">
    SELECT * FROM v_pwf_item_condition_type WHERE 0=0
    <cfif ARGUMENTS.ID NEQ 0>
    AND ID = <cfqueryparam value="#ARGUMENTS.ID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.excludeID NEQ 0>
    AND ID <> <cfqueryparam value="#ARGUMENTS.excludeID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(pwfictName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(pwfictDescription) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">)
    </cfif>
    <cfif ARGUMENTS.pwfictName NEQ "">
    AND UPPER(pwfictName) = <cfqueryparam value="#UCASE(ARGUMENTS.pwfictName)#" cfsqltype="cf_sql_varchar">
    </cfif>
    AND pwfictStatus IN (<cfqueryparam value="#ARGUMENTS.pwfictStatus#" list="yes" cfsqltype="cf_sql_integer">)
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsPWFItemConditionType = StructNew()>
    <cfset rsPWFItemConditionType.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsPWFItemConditionType>
    </cffunction>
    
    <cffunction name="getPWFItemPaidOutType" access="public" returntype="query" hint="Get PWF Item Paid Out Type data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="ID" type="numeric" required="yes" default="0">
    <cfargument name="excludeID" type="numeric" required="yes" default="0">
    <cfargument name="pwfipotName" type="string" required="yes" default="">
    <cfargument name="pwfipotStatus" type="string" required="yes" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="pwfipotSort, pwfipotName">
    <cfset var rsPWFItemPaidOutType = "" >
    <cftry>
    <cfquery name="rsPWFItemPaidOutType" datasource="#application.mcmsDSN#">
    SELECT * FROM v_pwf_item_paid_out_type WHERE 0=0
    <cfif ARGUMENTS.ID NEQ 0>
    AND ID = <cfqueryparam value="#ARGUMENTS.ID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.excludeID NEQ 0>
    AND ID <> <cfqueryparam value="#ARGUMENTS.excludeID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(pwfipotName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(pwfipotDescription) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">)
    </cfif>
    <cfif ARGUMENTS.pwfipotName NEQ "">
    AND UPPER(pwfipotName) = <cfqueryparam value="#UCASE(ARGUMENTS.pwfipotName)#" cfsqltype="cf_sql_varchar">
    </cfif>
    AND pwfipotStatus IN (<cfqueryparam value="#ARGUMENTS.pwfipotStatus#" list="yes" cfsqltype="cf_sql_integer">)
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsPWFItemPaidOutType = StructNew()>
    <cfset rsPWFItemPaidOutType.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsPWFItemPaidOutType>
    </cffunction>
    
    <cffunction name="getPWFItemStatus" access="public" returntype="query" hint="Get PWF Item Status data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="ID" type="string" required="yes" default="0">
    <cfargument name="excludeID" type="numeric" required="yes" default="0">
    <cfargument name="pwfisName" type="string" required="yes" default="">
    <cfargument name="pwfisStatus" type="string" required="yes" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="pwfisSort, pwfisName">
    <cfset var rsPWFItemStatus = "" >
    <cftry>
    <cfquery name="rsPWFItemStatus" datasource="#application.mcmsDSN#">
    SELECT * FROM v_pwf_item_status WHERE 0=0
    <cfif ARGUMENTS.ID NEQ 0>
    AND ID IN (<cfqueryparam value="#ARGUMENTS.ID#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    <cfif ARGUMENTS.excludeID NEQ 0>
    AND ID <> <cfqueryparam value="#ARGUMENTS.excludeID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(pwfisName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(pwfisDescription) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">)
    </cfif>
    <cfif ARGUMENTS.pwfisName NEQ "">
    AND UPPER(pwfisName) = <cfqueryparam value="#UCASE(ARGUMENTS.pwfisName)#" cfsqltype="cf_sql_varchar">
    </cfif>
    AND pwfisStatus IN (<cfqueryparam value="#ARGUMENTS.pwfisStatus#" list="yes" cfsqltype="cf_sql_integer">)
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsPWFItemStatus = StructNew()>
    <cfset rsPWFItemStatus.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsPWFItemStatus>
    </cffunction>
    
    <cffunction name="getPWFItemStatusFilter" access="public" returntype="query" hint="Get PWF Item Status Filter data.">
    <cfargument name="ID" type="string" required="yes" default="0">
    <cfargument name="urID" type="numeric" required="yes" default="0">
    <cfargument name="byPass" type="string" required="yes" default="false">
    <cfargument name="pwfisStatus" type="string" required="yes" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="pwfisSort, pwfisName">
    <cfset var rsPWFItemStatusFilter = "" >
    <cftry>
    <cfset this.pwfisList = '1,2'>
    <!---Determine which statuses should be displayed based on item status. Then determine if the user role can modify the status.--->
    <cfswitch expression="#ARGUMENTS.ID#">
    <cfcase value="1,12,13" delimiters=",">
    <cfif ListContains(application.pwfAdministratorUserRole, ARGUMENTS.urID) OR ListContains(application.pwfPhotographerUserRole, ARGUMENTS.urID)>
    <cfset this.pwfisList = '1,2,12,13'>
    <cfelse>
    <cfset this.pwfisList = 0>
    </cfif>
    </cfcase>
    <cfcase value="2">
    <cfif ListContains(application.pwfAdministratorUserRole, ARGUMENTS.urID) OR ListContains(application.pwfReceivingUserRole, ARGUMENTS.urID) OR ListContains(application.pwfPhotographerUserRole, ARGUMENTS.urID)>
    <cfset this.pwfisList = '2,5,12,13'>
    <cfelse>
    <cfset this.pwfisList = 0>
    </cfif>
    </cfcase>
    <!---Disabled.--->
    <!---
    <cfcase value="3">
    <cfif ListContains(application.pwfAdministratorUserRole, ARGUMENTS.urID) OR ListContains(application.pwfReceivingUserRole, ARGUMENTS.urID)>
    <cfset this.pwfisList = '3,4,12'>
    <cfelse>
    <cfset this.pwfisList = 0>
    </cfif>
    </cfcase>
    <cfcase value="4">
    <cfif ListContains(application.pwfAdministratorUserRole, ARGUMENTS.urID) OR ListContains(application.pwfPhotographerUserRole, ARGUMENTS.urID)>
    <cfset this.pwfisList = '4,5,12'>
    <cfelse>
    <cfset this.pwfisList = 0>
    </cfif>
    </cfcase>
	--->
    <cfcase value="5">
    <cfif ListContains(application.pwfAdministratorUserRole, ARGUMENTS.urID) OR ListContains(application.pwfPhotographerUserRole, ARGUMENTS.urID)>
    <cfset this.pwfisList = '5,6,12,13'>
    <cfelse>
    <cfset this.pwfisList = 0>
    </cfif>
    </cfcase>
    <cfcase value="6">
    <cfif ListContains(application.pwfAdministratorUserRole, ARGUMENTS.urID) OR ListContains(application.pwfMerchandisingUserRole, ARGUMENTS.urID)>
    <cfset this.pwfisList = '6,7,8,12,13'>
    <cfelse>
    <cfset this.pwfisList = 0>
    </cfif>
    </cfcase>
    <cfcase value="7">
    <cfif ListContains(application.pwfAdministratorUserRole, ARGUMENTS.urID) OR ListContains(application.pwfPhotographerUserRole, ARGUMENTS.urID)>
    <cfset this.pwfisList = '7,9,12,13'>
    <cfelse>
    <cfset this.pwfisList = 0>
    </cfif>
    </cfcase>
    <cfcase value="8">
    <cfif ListContains(application.pwfAdministratorUserRole, ARGUMENTS.urID) OR ListContains(application.pwfPhotographerUserRole, ARGUMENTS.urID)>
    <cfset this.pwfisList = '6,8,12,13'>
    <cfelse>
    <cfset this.pwfisList = 0>
    </cfif>
    </cfcase>
    <cfcase value="9">
    <cfif ListContains(application.pwfAdministratorUserRole, ARGUMENTS.urID) OR ListContains(application.pwfReceivingUserRole, ARGUMENTS.urID)>
    <cfset this.pwfisList = '9,10,11,12,13,14'>
    <cfelseif ListContains(application.pwfPhotographerUserRole, ARGUMENTS.urID) OR ListContains(application.pwfMerchandisingUserRole, ARGUMENTS.urID)>
    <cfset this.pwfisList = '9,14'>
    <cfelse>
    <cfset this.pwfisList = 0>
    </cfif>
    </cfcase>
    <cfcase value="10">
    <cfif ListContains(application.pwfAdministratorUserRole, ARGUMENTS.urID) OR ListContains(application.pwfReceivingUserRole, ARGUMENTS.urID)>
    <cfset this.pwfisList = '10,11,12,13,14'>
    <cfelse>
    <cfset this.pwfisList = 0>
    </cfif>
    </cfcase>
    <cfcase value="11">
    <cfif ListContains(application.pwfAdministratorUserRole, ARGUMENTS.urID) OR ListContains(application.pwfReceivingUserRole, ARGUMENTS.urID)>
    <cfset this.pwfisList = '11,12,13,14'>
    <cfelse>
    <cfset this.pwfisList = 0>
    </cfif>
    </cfcase>
    <cfcase value="14">
        <cfif ListContains(application.pwfAdministratorUserRole, ARGUMENTS.urID) OR ListContains(application.pwfReceivingUserRole, ARGUMENTS.urID) OR ListContains(application.pwfPhotographerUserRole, ARGUMENTS.urID)>
    <cfset this.pwfisList = '2,12,13,14'>
    <cfelse>
    <cfset this.pwfisList = 0>
    </cfif>
    </cfcase>
    </cfswitch>
    <cfquery name="rsPWFItemStatusFilter" datasource="#application.mcmsDSN#">
    SELECT * FROM v_pwf_item_status WHERE 0=0
    <cfif this.pwfisList EQ 0>
    AND ID = <cfqueryparam value="#this.pwfisList#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.byPass NEQ 'true'>
    AND ID IN (<cfqueryparam value="#this.pwfisList#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    AND pwfisStatus IN (<cfqueryparam value="#ARGUMENTS.pwfisStatus#" list="yes" cfsqltype="cf_sql_integer">)
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsPWFItemStatusFilter = StructNew()>
    <cfset rsPWFItemStatusFilter.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsPWFItemStatusFilter>
    </cffunction>
    
    <cffunction name="getPWFItemReport" access="public" returntype="query" hint="Get PWF Item Report data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="siteNo" type="string" required="yes" default="100">
    <cfargument name="deptNo" type="string" required="yes" default="0">
    <cfargument name="args" type="string" required="yes" default="">
    <cfargument name="orderBy" type="string" required="yes" default="pwfiDateDue, ppID, pwfiQOH DESC, pName, pwfiStatus">
    <cfset var rsPWFItemReport = "" >
    <cftry>
    <cfquery name="rsPWFItemReport" datasource="#application.mcmsDSN#">
    SELECT skuID AS SKU, skuMPN AS MPN, TO_CHAR(skuUPC) AS UPC, skuDCL AS DCL, pwfiQOH AS QOH, productID AS Product_ID, pName AS Product, skuDescription AS Sku_Description, pwfisName AS Item_Status, TO_CHAR(pwfiDateRequested, 'mm/dd/yyyy') AS Date_Requested, TO_CHAR(pwfiDateDue, 'mm/dd/yyyy') AS Date_Due, TO_CHAR(pwfiDate, 'mm/dd/yyyy') AS Date_Update, TO_CHAR(pDateUpdate, 'mm/dd/yyyy') AS Product_Date_Update, ppName AS Priority, vName AS Vendor, bName AS Brand, pSkuList AS Product_Skus, siteName AS Site, siteNo, deptName AS Department, deptNo, TO_CHAR(userFName || ' ' || userLName) AS Username, pwfiRefNo AS Reference_No, pwfivgtName AS View_Group_Type, pwfipotName AS Paid_Out_Type, pwfictName AS Condition_Type, sName FROM v_pwf_item WHERE 0=0
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(skuID) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(pName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(pDescription) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">)
    </cfif>
    <!---AND pwfiDate >= <cfqueryparam value="#DateAdd('d', '-#application.pwfItemHistoryDayRange#', Now())#" cfsqltype="cf_sql_date">--->
    <cfif ARGUMENTS.siteNo NEQ 100>
    AND siteNo IN (<cfqueryparam value="#ARGUMENTS.siteNo#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    <cfif ARGUMENTS.deptNo NEQ 0>
    AND deptNo IN (<cfqueryparam value="#ARGUMENTS.deptNo#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    <cfif ListGetAt(ARGUMENTS.args, 1) NEQ 0>
    AND ppID IN (<cfqueryparam value="#ListGetAt(ARGUMENTS.args, 1)#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    <cfif ListGetAt(ARGUMENTS.args, 2) NEQ 0>
    AND pwfisID IN (<cfqueryparam value="#ListGetAt(ARGUMENTS.args, 2)#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsPWFItemReport = StructNew()>
    <cfset rsPWFItemReport.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsPWFItemReport>
    </cffunction>
    
    <cffunction name="getPWFItemHistoryReport" access="public" returntype="query" hint="Get PWF Item Report data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="siteNo" type="string" required="yes" default="100">
    <cfargument name="deptNo" type="string" required="yes" default="0">
    <cfargument name="args" type="string" required="yes" default="">
    <cfargument name="orderBy" type="string" required="yes" default="pwfiDateDue, ppID, pwfiQOH DESC, pName, pwfiStatus">
    <cfset var rsPWFItemHistoryReport = "" >
    <cftry>
    <cfquery name="rsPWFItemHistoryReport" datasource="#application.mcmsDSN#">
    SELECT skuID AS SKU, skuMPN AS MPN, TO_CHAR(skuUPC) AS UPC, skuDCL AS DCL, productID AS Product_ID, pName AS Product, pwfisName AS Item_Status, TO_CHAR(pwfiDate, 'mm/dd/yyyy') AS Date_Update, TO_CHAR(pDateUpdate, 'mm/dd/yyyy') AS Product_Date_Update, ppName AS Priority, vName AS Vendor, bName AS Brand, pSkuList AS Product_Skus, siteName AS Site, siteNo, deptName AS Department, deptNo, TO_CHAR(userFName || ' ' || userLName) AS Username, pwfiRefNo AS Reference_No, pwfivgtName AS View_Group_Type, pwfipotName AS Paid_Out_Type, pwfictName AS Condition_Type, sName FROM v_pwf_item WHERE 0=0
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(skuID) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(pName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(pDescription) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">)
    </cfif>
    <!---AND pwfiDate <= <cfqueryparam value="#DateAdd('d', application.pwfItemHistoryDayRange, Now())#" cfsqltype="cf_sql_date">--->
    <cfif ARGUMENTS.siteNo NEQ 100>
    AND siteNo IN (<cfqueryparam value="#ARGUMENTS.siteNo#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    <cfif ARGUMENTS.deptNo NEQ 0>
    AND deptNo IN (<cfqueryparam value="#ARGUMENTS.deptNo#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    <cfif ListGetAt(ARGUMENTS.args, 1) NEQ 0>
    AND ppID IN (<cfqueryparam value="#ListGetAt(ARGUMENTS.args, 1)#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    <cfif ListGetAt(ARGUMENTS.args, 2) NEQ 0>
    AND pwfisID IN (<cfqueryparam value="#ListGetAt(ARGUMENTS.args, 2)#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsPWFItemHistoryReport = StructNew()>
    <cfset rsPWFItemHistoryReport.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsPWFItemHistoryReport>
    </cffunction>
    
    <cffunction name="getPWFImageApprovalStatusReport" access="public" returntype="query" hint="Get PWF Image Approval Status Report data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="orderBy" type="string" required="yes" default="pwfiasSort, pwfiasName">
    <cfset var rsPWFImageApprovalStatusReport = "" >
    <cftry>
    <cfquery name="rsPWFImageApprovalStatusReport" datasource="#application.mcmsDSN#">
    SELECT ID, pwfiasName, pwfiasDescription, sortName, sName FROM v_pwf_image_approval_status WHERE 0=0
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(pwfiasName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(pwfiasDescription) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">)
    </cfif>
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsPWFImageApprovalStatusReport = StructNew()>
    <cfset rsPWFImageApprovalStatusReport.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsPWFImageApprovalStatusReport>
    </cffunction>
    
    <cffunction name="getPWFImageApprovalTypeReport" access="public" returntype="query" hint="Get PWF Image Approval Type Report data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="orderBy" type="string" required="yes" default="pwfiatSort, pwfiatName">
    <cfset var rsPWFImageApprovalTypeReport = "" >
    <cftry>
    <cfquery name="rsPWFImageApprovalTypeReport" datasource="#application.mcmsDSN#">
    SELECT ID, pwfiatName, pwfiatDescription, sortName, sName FROM v_pwf_image_approval_type WHERE 0=0
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(pwfiatName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(pwfiatDescription) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">)
    </cfif>
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsPWFImageApprovalTypeReport = StructNew()>
    <cfset rsPWFImageApprovalTypeReport.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsPWFImageApprovalTypeReport>
    </cffunction>
    
    <cffunction name="getPWFImageViewGroupTypeReport" access="public" returntype="query" hint="Get PWF Image View Group Type Report data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="orderBy" type="string" required="yes" default="pwfivgtSort, pwfivgtName">
    <cfset var rsPWFImageViewGroupTypeReport = "" >
    <cftry>
    <cfquery name="rsPWFImageViewGroupTypeReport" datasource="#application.mcmsDSN#">
    SELECT ID, pwfivgtName, pwfivgtDescription, sortName, sName FROM v_pwf_image_view_group_type WHERE 0=0
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(pwfivgtName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(pwfivgtDescription) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">)
    </cfif>
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsPWFImageViewGroupTypeReport = StructNew()>
    <cfset rsPWFImageViewGroupTypeReport.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsPWFImageViewGroupTypeReport>
    </cffunction>
    
    <cffunction name="getPWFImageViewTypeReport" access="public" returntype="query" hint="Get PWF Image View Type Report data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="orderBy" type="string" required="yes" default="pwfivtSort, pwfivtName">
    <cfset var rsPWFImageViewTypeReport = "" >
    <cftry>
    <cfquery name="rsPWFImageViewTypeReport" datasource="#application.mcmsDSN#">
    SELECT ID, pwfivtName, pwfivtDescription, sortName, sName FROM v_pwf_image_view_type WHERE 0=0
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(pwfivtName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(pwfivtDescription) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">)
    </cfif>
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsPWFImageViewTypeReport = StructNew()>
    <cfset rsPWFImageViewTypeReport.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsPWFImageViewTypeReport>
    </cffunction>
    
    <cffunction name="getPWFItemConditionTypeReport" access="public" returntype="query" hint="Get PWF Item Condition Type Report data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="orderBy" type="string" required="yes" default="pwfictSort, pwfictName">
    <cfset var rsPWFItemConditionTypeReport = "" >
    <cftry>
    <cfquery name="rsPWFItemConditionTypeReport" datasource="#application.mcmsDSN#">
    SELECT ID, pwfictName, pwfictDescription, sortName, sName FROM v_pwf_item_condition_type WHERE 0=0
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(pwfictName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(pwfictDescription) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">)
    </cfif>
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsPWFItemConditionTypeReport = StructNew()>
    <cfset rsPWFItemConditionTypeReport.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsPWFItemConditionTypeReport>
    </cffunction>
    
    <cffunction name="getPWFItemPaidOutTypeReport" access="public" returntype="query" hint="Get PWF Item Paid Out Type Report data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="orderBy" type="string" required="yes" default="pwfipotSort, pwfipotName">
    <cfset var rsPWFItemPaidOutTypeReport = "" >
    <cftry>
    <cfquery name="rsPWFItemPaidOutTypeReport" datasource="#application.mcmsDSN#">
    SELECT ID, pwfipotName, pwfipotDescription, sortName, sName FROM v_pwf_item_paid_out_type WHERE 0=0
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(pwfipotName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(pwfipotDescription) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">)
    </cfif>
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsPWFItemPaidOutTypeReport = StructNew()>
    <cfset rsPWFItemPaidOutTypeReport.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsPWFItemPaidOutTypeReport>
    </cffunction>
    
    <cffunction name="getPWFItemStatusReport" access="public" returntype="query" hint="Get PWF Item Status Report data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="orderBy" type="string" required="yes" default="pwfisSort, pwfisName">
    <cfset var rsPWFItemStatusReport = "" >
    <cftry>
    <cfquery name="rsPWFItemStatusReport" datasource="#application.mcmsDSN#">
    SELECT ID, pwfisName, pwfisDescription, sortName, sName FROM v_pwf_item_status WHERE 0=0
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(pwfisName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(pwfisDescription) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">)
    </cfif>
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsPWFItemStatusReport = StructNew()>
    <cfset rsPWFItemStatusReport.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsPWFItemStatusReport>
    </cffunction>
    
    <cffunction name="insertPWFItem" access="public" returntype="struct">
    <cfargument name="sID" type="numeric" required="yes">
    <cfargument name="skuID" type="numeric" required="yes">
    <cfargument name="pID" type="numeric" required="yes">
    <cfargument name="ppID" type="numeric" required="yes">
    <cfargument name="skuUPC" type="string" required="yes">
    <cfargument name="deptNo" type="numeric" required="yes">
    <cfargument name="userID" type="numeric" required="yes">
    <cfargument name="pwfivgtID" type="numeric" required="yes">
    <cfargument name="pwfiDeliverable" type="numeric" required="yes">
    <cfargument name="pwfisID" type="numeric" required="yes">
    <cfargument name="pwfiStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully inserted the record.">
    <cftry>
    <!---Check for a change of the record.--->
    <cfinvoke 
    component="MCMS.component.app.photography_workflow.PhotographyWorkflow"
    method="getPWFItem"
    returnvariable="getCheckPWFItemRet">
    <cfinvokeargument name="sID" value="#ARGUMENTS.sID#"/>
    <cfinvokeargument name="pwfiStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckPWFItemRet.recordcount NEQ 0>
    <cfif ARGUMENTS.pwfivgtID NEQ getCheckPWFItemRet.pwfivgtID>
    <cfset result.message = "Some sku(s) may already have a photo request processing. By changing it you may interupt the photography process.  Please contact the Photography group to change this request.">
    <cfelse>
    <cfset result.message = "You have successfully updated the records.">
    </cfif>
    <cfelse>
    <!---Create barcode for scanning UPC.--->
    <cfset textStyle = StructNew()> 
	<cfset textStyle.font = "Free 3 of 9 Regular">
    <cfset textStyle.style = "plain"> 
	<cfset textStyle.size = 32>
	<cfset this.originalImage=ImageNew('#application.repositoryPath#\image\sku\barcode\barcode_template.png')>   
    <cfset ImageSetDrawingColor(this.originalImage,"black")> 
    <cfset ImageDrawText(this.originalImage,'*#ARGUMENTS.skuUPC#*',10,45,textStyle)> 
    <cfimage source="#this.originalImage#" action="write" destination="#application.repositoryPath#\image\sku\barcode\#ARGUMENTS.skuUPC#.png" overwrite="yes">
    
    <!---If the item is undeliverable/sample bypass QOH query.--->
    <cfif ARGUMENTS.pwfiDeliverable EQ 0>
    <!---Find site of sku based on QOH.--->
    <cfinvoke 
    component="MCMS.component.app.interface.Interface"
    method="getSkuQOH_ERP"
    returnvariable="rsSkuQOH_ERP">
    <cfinvokeargument name="sku" value="#TRIM(ARGUMENTS.skuID)#"/>
    <cfinvokeargument name="siteNo" value="300,114"/>
    <cfinvokeargument name="deptNo" value="#ARGUMENTS.deptNo#"/>
    <cfinvokeargument name="qoh" value="0"/>
    <cfinvokeargument name="orderBy" value="SITENO DESC"/>
    </cfinvoke>
    <cfelse>
    <!---Since we are not checking the QOH set the recordcount to '0'.--->
    <cfset rsSkuQOH_ERP.recordcount = 0>
    </cfif>
    
    <cfset this.pwfiQOH = 0>
	<cfif rsSkuQOH_ERP.recordcount EQ 0 AND ARGUMENTS.pwfiDeliverable EQ 0>
    <cfset result.message = "No record of sku #TRIM(ARGUMENTS.skuID)# could be found in the ERP system to pull for a Photo Request.">
    <cfelse>
    <!---If the item is undeliverable/sample bypass QOH query and set default siteNo.--->
    <cfif ARGUMENTS.pwfiDeliverable EQ 1>
    <cfset this.siteNo = 98>
    <cfelse>
    <cfif rsSkuQOH_ERP.siteNo EQ 300>
    <!---Change the siteNo to the system siteNo for the DC value.--->
    <cfset this.siteNo = 98>
    <cfset this.pwfiQOH = rsSkuQOH_ERP.DC_QOH>
    <cfelseif ARGUMENTS.ppID NEQ 101>
    <!---Change the siteNo to the system siteNo for the DC value when the item is not critical and possibly 114.--->
    <cfset this.siteNo = 98>
    <cfset this.pwfiQOH = 1>
    <cfelse>
    <cfset this.siteNo = rsSkuQOH_ERP.siteNo>
    <cfset this.pwfiQOH = rsSkuQOH_ERP.DC_QOH>
    </cfif>
    </cfif>
    
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    INSERT INTO tbl_pwf_item (sID,pID,siteNo,deptNo,userID,pwfivgtID,pwfiQOH,pwfiDeliverable,pwfiByPass,pwfisID,pwfiStatus) VALUES
    (
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.sID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.pID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#this.siteNo#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.deptNo#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.userID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.pwfivgtID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#this.pwfiQOH#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.pwfiDeliverable#">,
    <!---Set the bypass if the item is undeliverable.--->
    <cfqueryparam cfsqltype="cf_sql_integer" value="#Iif(ARGUMENTS.pwfiDeliverable EQ 0, DE('0'), DE('1'))#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.pwfisID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.pwfiStatus#">
    )
    </cfquery>
    <!---Get latest item id.--->
    <cfinvoke 
    component="MCMS.component.cms.Cms"
    method="getMaxValueSQL"
    returnvariable="pwfiIDValue">
    <cfinvokeargument name="tableName" value="tbl_pwf_item"/>
    </cfinvoke>
    <cfinvoke 
    component="MCMS.component.app.photography_workflow.PhotographyWorkflow"
    method="insertPWFItemLog"
    >
    <cfinvokeargument name="pwfiID" value="#pwfiIDValue#"/>
    <cfinvokeargument name="userID" value="#ARGUMENTS.userID#"/>
    <cfinvokeargument name="pwfilLog" value="New photo request created. #Iif(ARGUMENTS.pwfiDeliverable EQ 1, DE('The item was marked as Undeliverable/Sample.  This could mean the item is not in inventory and it may be supplied by the user requesting the photography as a sample.'), DE(''))#"/>
    <cfinvokeargument name="pwfisID" value="#ARGUMENTS.pwfisID#"/>
    <cfinvokeargument name="pwfilStatus" value="1"/>
    </cfinvoke>
    </cftransaction>
    </cfif>
    </cfif>
    <cfcatch type="any">
    <cfset result.message = "There was an error inserting the record.">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="insertPWFItemLog" access="public" returntype="struct">
    <cfargument name="pwfiID" type="numeric" required="yes">
    <cfargument name="userID" type="numeric" required="yes">
    <cfargument name="pwfilLog" type="string" required="yes" default="Update.">
    <cfargument name="pwfisID" type="numeric" required="yes">
    <cfargument name="pwfilStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully inserted the record.">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    INSERT INTO tbl_pwf_item_log (pwfiID,userID,pwfilLog,pwfisID,pwfilStatus) VALUES
    (
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.pwfiID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.userID#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.pwfilLog#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.pwfisID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.pwfilStatus#">
    )
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error inserting the record.">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="insertPWFItemImageRel" access="public" returntype="struct">
    <cfargument name="pwfiID" type="numeric" required="yes">
    <cfargument name="pwfiName" type="string" required="yes">
    <cfargument name="pwfivtID" type="numeric" required="yes">
    <cfargument name="pwfiatID" type="numeric" required="yes">
    <cfargument name="pwfiasID" type="numeric" required="yes">
    <cfargument name="pwfiirRemoteFilePath" type="string" required="yes">
    <cfargument name="pwfiirNote" type="string" required="yes">
    <cfargument name="imgName" type="string" required="yes">
    <cfargument name="altName" type="string" required="yes">
    <cfargument name="imgFile" type="string" required="yes">
    <cfargument name="imgtID" type="numeric" required="yes">
    <cfargument name="imgSort" type="numeric" required="yes">
    <cfargument name="imgStatus" type="numeric" required="yes">
    <cfargument name="pwfisID" type="numeric" required="yes">
    <cfargument name="pwfiirStatus" type="numeric" required="yes">
    <cfargument name="imgCountID" type="numeric" required="yes">
    <cfargument name="imgCount" type="numeric" required="yes">
    <cfargument name="userEmail" type="string" required="yes">
    <cfset result.message = "You have successfully inserted the record.">
    <cftry>
    <!---Insert the image and then record the relationship.--->
    <cftransaction>
    <cfinvoke 
    component="MCMS.component.app.image.Image" 
    method="insertImage" 
    >
    <cfinvokeargument name="imgName" value="#ARGUMENTS.imgName#">
    <cfinvokeargument name="altName" value="#ARGUMENTS.altName#">
    <cfinvokeargument name="imgFile" value="#ARGUMENTS.imgFile#">
    <cfinvokeargument name="imgtID" value="#ARGUMENTS.imgtID#">
    <cfinvokeargument name="imgSort" value="#ARGUMENTS.imgSort#">
    <cfinvokeargument name="imgStatus" value="1">
    <cfinvokeargument name="imgCountID" value="#id#">                 
    </cfinvoke>
    <!--- Get newly inserted image ID. --->
    <cfinvoke 
    component="MCMS.component.cms.Cms"
    method="getMaxValueSQL"
    returnvariable="imgID">
    <cfinvokeargument name="tableName" value="tbl_image"/>
    </cfinvoke>
    <cfquery datasource="#application.mcmsDSN#">
    INSERT INTO tbl_pwf_item_image_rel (pwfiID,imgID,pwfivtID,pwfiatID,pwfiasID,pwfiirRemoteFilePath,pwfiirNote,pwfiirStatus) VALUES
    (
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.pwfiID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#imgID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.pwfivtID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.pwfiatID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.pwfiasID#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#LEFT(Evaluate(ARGUMENTS.pwfiirRemoteFilePath),10)#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.pwfiirNote#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.pwfiirStatus#">
    )
    </cfquery>
    <!---Insert log entry.--->
    <cfinvoke 
    component="MCMS.component.app.photography_workflow.PhotographyWorkflow"
    method="insertPWFItemLog"
    >
    <cfinvokeargument name="pwfiID" value="#ARGUMENTS.pwfiID#"/>
    <cfinvokeargument name="userID" value="#session.userID#"/>
    <cfinvokeargument name="pwfilLog" value="Photo submitted for approval."/>
    <cfinvokeargument name="pwfisID" value="#ARGUMENTS.pwfisID#"/>
    <cfinvokeargument name="pwfilStatus" value="1"/>
    </cfinvoke>
    <!---Send email to item owner informing them of the photo upload.--->
    <cfif ARGUMENTS.imgCount EQ ARGUMENTS.imgCountID>
    <cfinvoke 
    component="MCMS.component.utility.Email"
    method="sendEmail">
    <cfinvokeargument name="subject" value="Photography Workflow INSERT - #ARGUMENTS.pwfiName#"/>
    <cfinvokeargument name="to" value="#ARGUMENTS.userEmail#"/>
    <cfinvokeargument name="from" value="#application.pwfPhotographerEmail#"/>
    <cfinvokeargument name="body" value=""/>
    <cfinvokeargument name="ID" value="#ARGUMENTS.pwfiID#"/>
    <cfinvokeargument name="emailTemplate" value="/#application.mcmsAppAdminPath#/photography_workflow/view/inc_pwf_insert_item_image_rel_email_template.cfm"/>
    </cfinvoke>
    <!---Update the item status.--->
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_pwf_item SET
    pwfiDate = <cfqueryparam cfsqltype="cf_sql_date" value="#DateFormat(Now(), application.dateFormat)#">,
    pwfisID = <cfqueryparam cfsqltype="cf_sql_integer" value="6">
    WHERE ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.pwfiID#">
    </cfquery>
    </cfif>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error inserting the record.">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="insertPWFImageViewGroupType" access="public" returntype="struct">
    <cfargument name="pwfivgtName" type="string" required="yes">
    <cfargument name="pwfivgtDescription" type="string" required="yes">
    <cfargument name="deptNo" type="numeric" required="yes">
    <cfargument name="pwfivgtSort" type="numeric" required="yes">
    <cfargument name="pwfivgtStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully inserted the record.">
    <cftry>
    <!---Check for profanity in the text.--->
    <cfinvoke 
    component="MCMS.component.utility.Regex"
    method="regexProfanity"
    returnvariable="regexProfanityRet">
    <cfinvokeargument name="profanityString" value="#TRIM(ARGUMENTS.pwfivgtDescription)#"/>
    </cfinvoke>
    <!---Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.app.photography_workflow.PhotographyWorkflow"
    method="getPWFImageViewGroupType"
    returnvariable="getCheckPWFImageViewGroupTypeRet">
    <cfinvokeargument name="pwfivgtName" value="#TRIM(ARGUMENTS.pwfivgtName)#"/>
    <cfinvokeargument name="pwfivgtStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckPWFImageViewGroupTypeRet.recordcount NEQ 0>
    <cfset result.message = "The name #TRIM(ARGUMENTS.pwfivgtName)# already exists, please enter a new name.">
    <cfelseif regexProfanityRet CONTAINS '$%&*!'>
    <cfset result.message = "Some text contained profanity, please remove any profanity from your text.">
    <!---Check length restriction.--->
    <cfelseif LEN(ARGUMENTS.pwfivgtDescription) GT 255>
    <cfset result.message = "The description is longer than 255 characters, please enter a new description under 255 characters.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    INSERT INTO tbl_pwf_image_view_group_type (pwfivgtName,pwfivgtDescription,deptNo,pwfivgtSort,pwfivgtStatus) VALUES
    (
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#TRIM(ARGUMENTS.pwfivgtName)#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#TRIM(ARGUMENTS.pwfivgtDescription)#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.deptNo#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.pwfivgtSort#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.pwfivgtStatus#">
    )
    </cfquery>
    </cftransaction>
    <!---Set a result ID to be included with a link to the update form.--->
    <cfinvoke 
    component="MCMS.component.cms.Cms"
    method="getMaxValueSQL"
    returnvariable="getMaxValueSQLRet">
    <cfinvokeargument name="tableName" value="tbl_pwf_image_view_group_type"/>
    </cfinvoke>
    <cfset this.ID = getMaxValueSQLRet>
    <!---Forward to update form.--->
    <cflocation url="/#application.mcmsAppAdminPath#/photography_workflow/index.cfm?appID=200&mcmsPageID=Image%20View%20Group%20Type&mcmsID=update&ID=#this.ID#&queryString=#url.queryString#" addtoken="no">
    </cfif>
    <cfcatch type="any">
    <cfset result.message = "There was an error inserting the record.">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="insertPWFImageViewType" access="public" returntype="struct">
    <cfargument name="pwfivtName" type="string" required="yes">
    <cfargument name="pwfivtDescription" type="string" required="yes">
    <cfargument name="pwfivtSort" type="numeric" required="yes">
    <cfargument name="pwfivtStatus" type="numeric" required="yes">
    <!---Include Image View Group Type Relationship.--->
    <cfargument name="pwfivgtID" type="string" required="yes">
    <cfset result.message = "You have successfully inserted the record.">
    <cftry>
    <!---Check for profanity in the text.--->
    <cfinvoke 
    component="MCMS.component.utility.Regex"
    method="regexProfanity"
    returnvariable="regexProfanityRet">
    <cfinvokeargument name="profanityString" value="#TRIM(ARGUMENTS.pwfivtDescription)#"/>
    </cfinvoke>
    <!---Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.app.photography_workflow.PhotographyWorkflow"
    method="getPWFImageViewType"
    returnvariable="getCheckPWFImageViewTypeRet">
    <cfinvokeargument name="pwfivtName" value="#TRIM(ARGUMENTS.pwfivtName)#"/>
    <cfinvokeargument name="pwfivtStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckPWFImageViewTypeRet.recordcount NEQ 0>
    <cfset result.message = "The name #TRIM(ARGUMENTS.pwfivtName)# already exists, please enter a new name.">
    <cfelseif regexProfanityRet CONTAINS '$%&*!'>
    <cfset result.message = "Some text contained profanity, please remove any profanity from your text.">
    <!---Check length restriction.--->
    <cfelseif LEN(ARGUMENTS.pwfivtDescription) GT 255>
    <cfset result.message = "The description is longer than 255 characters, please enter a new description under 255 characters.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    INSERT INTO tbl_pwf_image_view_type (pwfivtName,pwfivtDescription,pwfivtSort,pwfivtStatus) VALUES
    (
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#TRIM(ARGUMENTS.pwfivtName)#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#TRIM(ARGUMENTS.pwfivtDescription)#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.pwfivtSort#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.pwfivtStatus#">
    )
    </cfquery>
    <!---Get latest item id.--->
    <cfinvoke 
    component="MCMS.component.cms.Cms"
    method="getMaxValueSQL"
    returnvariable="pwfivtIDValue">
    <cfinvokeargument name="tableName" value="tbl_pwf_image_view_type"/>
    </cfinvoke>
    <!---Insert relationship(s).--->
    <cfloop list="#ARGUMENTS.pwfivgtID#" index="i">
    <cfinvoke 
    component="MCMS.component.app.photography_workflow.PhotographyWorkflow" 
    method="insertPWFImageViewGroupTypeRel" 
    >
    <cfinvokeargument name="pwfivtID" value="#pwfivtIDValue#">
    <cfinvokeargument name="pwfivgtID" value="#i#"> >  
    <cfinvokeargument name="pwfivgtrStatus" value="1">                     
    </cfinvoke>
    </cfloop>
    </cftransaction>
    </cfif>
    <cfcatch type="any">
    <cfset result.message = "There was an error inserting the record.">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="insertPWFImageApprovalType" access="public" returntype="struct">
    <cfargument name="pwfiatName" type="string" required="yes">
    <cfargument name="pwfiatDescription" type="string" required="yes">
    <cfargument name="pwfiatSort" type="numeric" required="yes">
    <cfargument name="pwfiatStatus" type="numeric" required="yes">
    <!---Include Image Approval Status Type Relationship.--->
    <cfargument name="pwfiasID" type="string" required="yes">
    <cfset result.message = "You have successfully inserted the record.">
    <cftry>
    <!---Check for profanity in the text.--->
    <cfinvoke 
    component="MCMS.component.utility.Regex"
    method="regexProfanity"
    returnvariable="regexProfanityRet">
    <cfinvokeargument name="profanityString" value="#TRIM(ARGUMENTS.pwfiatDescription)#"/>
    </cfinvoke>
    <!---Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.app.photography_workflow.PhotographyWorkflow"
    method="getPWFImageApprovalType"
    returnvariable="getCheckPWFImageApprovalTypeRet">
    <cfinvokeargument name="pwfiatName" value="#TRIM(ARGUMENTS.pwfiatName)#"/>
    <cfinvokeargument name="pwfiatStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckPWFImageApprovalTypeRet.recordcount NEQ 0>
    <cfset result.message = "The name #TRIM(ARGUMENTS.pwfiatName)# already exists, please enter a new name.">
    <cfelseif regexProfanityRet CONTAINS '$%&*!'>
    <cfset result.message = "Some text contained profanity, please remove any profanity from your text.">
    <!---Check length restriction.--->
    <cfelseif LEN(ARGUMENTS.pwfiatDescription) GT 255>
    <cfset result.message = "The description is longer than 255 characters, please enter a new description under 255 characters.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    INSERT INTO tbl_pwf_image_approval_type (pwfiatName,pwfiatDescription,pwfiatSort,pwfiatStatus) VALUES
    (
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#TRIM(ARGUMENTS.pwfiatName)#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#TRIM(ARGUMENTS.pwfiatDescription)#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.pwfiatSort#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.pwfiatStatus#">
    )
    </cfquery>
    <!---Get latest item id.--->
    <cfinvoke 
    component="MCMS.component.cms.Cms"
    method="getMaxValueSQL"
    returnvariable="pwfiatIDValue">
    <cfinvokeargument name="tableName" value="tbl_pwf_image_approval_type"/>
    </cfinvoke>
    <!---Insert relationship(s).--->
    <cfloop list="#ARGUMENTS.pwfiasID#" index="i">
    <cfinvoke 
    component="MCMS.component.app.photography_workflow.PhotographyWorkflow" 
    method="insertPWFImageApprovalStatusTypeRel" 
    >
    <cfinvokeargument name="pwfiatID" value="#pwfiatIDValue#">
    <cfinvokeargument name="pwfiasID" value="#i#"> >  
    <cfinvokeargument name="pwfiatsrStatus" value="1">                     
    </cfinvoke>
    </cfloop>
    </cftransaction>
    </cfif>
    <cfcatch type="any">
    <cfset result.message = "There was an error inserting the record.">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="insertPWFImageViewGroupTypeRel" access="public" returntype="struct">
    <cfargument name="pwfivtID" type="numeric" required="yes">
    <cfargument name="pwfivgtID" type="numeric" required="yes">
    <cfargument name="pwfivgtrStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully inserted the record.">
    <cftry>
    <!---Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.app.photography_workflow.PhotographyWorkflow"
    method="getPWFImageViewGroupTypeRel"
    returnvariable="getCheckPWFImageViewGroupTypeRelRet">
    <cfinvokeargument name="pwfivtID" value="#ARGUMENTS.pwfivtID#"/>
    <cfinvokeargument name="pwfivgtID" value="#ARGUMENTS.pwfivgtID#"/>
    <cfinvokeargument name="pwfivgtrStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckPWFImageViewGroupTypeRelRet.recordcount NEQ 0>
    <cfset result.message = "The record already has this relationship, please try again.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    INSERT INTO tbl_pwf_image_v_group_type_rel (pwfivtID,pwfivgtID,pwfivgtrStatus) VALUES
    (
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.pwfivtID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.pwfivgtID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.pwfivgtrStatus#">
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
    
    <cffunction name="insertPWFImageApprovalStatusTypeRel" access="public" returntype="struct">
    <cfargument name="pwfiasID" type="numeric" required="yes">
    <cfargument name="pwfiatID" type="numeric" required="yes">
    <cfargument name="pwfiatsrStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully inserted the record.">
    <cftry>
    <!---Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.app.photography_workflow.PhotographyWorkflow"
    method="getPWFImageApprovalStatusTypeRel"
    returnvariable="getCheckPWFImageApprovalStatusTypeRelRet">
    <cfinvokeargument name="pwfiasID" value="#ARGUMENTS.pwfiasID#"/>
    <cfinvokeargument name="pwfiatID" value="#ARGUMENTS.pwfiatID#"/>
    <cfinvokeargument name="pwfiatsrStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckPWFImageApprovalStatusTypeRelRet.recordcount NEQ 0>
    <cfset result.message = "The record already has this relationship, please try again.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    INSERT INTO tbl_pwf_image_approval_t_s_rel (pwfiasID,pwfiatID,pwfiatsrStatus) VALUES
    (
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.pwfiasID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.pwfiatID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.pwfiatsrStatus#">
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
    
    <cffunction name="updatePWFItem" access="public" returntype="struct">
    <cfargument name="ID" type="numeric" required="yes">
    <cfargument name="pwfiDeliverable" type="numeric" required="yes">
    <cfargument name="pwfiRefNo" type="string" required="yes">
    <cfargument name="pwfiByPass" type="numeric" required="yes">
    <cfargument name="pwfivgtID" type="numeric" required="yes">
    <cfargument name="pwfictID" type="numeric" required="yes">
    <cfargument name="pwfipotID" type="numeric" required="yes">
    <cfargument name="siteNo" type="numeric" required="yes">
    <cfargument name="pwfiQOH" type="numeric" required="yes">
    <cfargument name="pwfisID" type="numeric" required="yes">
    <cfargument name="pwfisIDTemp" type="numeric" required="yes">
    <cfargument name="pwfiStatus" type="numeric" required="yes">
    <!---Log entry.--->
    <cfargument name="pwfilLog" type="string" required="yes" default="Status update.">
    <cfset result.message = "You have successfully updated the record.">
    <cftry>
    <!---Change the byPass back to default if the item status has changed.--->
    <cfif ARGUMENTS.pwfisID NEQ ARGUMENTS.pwfisIDTemp>
    <cfset ARGUMENTS.pwfiByPass = 0>
    </cfif>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_pwf_item SET
    pwfiDeliverable = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.pwfiDeliverable#">,
    pwfiDate = <cfqueryparam cfsqltype="cf_sql_date" value="#DateFormat(Now(), application.dateFormat)#">,
    pwfiRefNo = <cfqueryparam cfsqltype="cf_sql_varchar" value="#TRIM(ARGUMENTS.pwfiRefNo)#">,
    pwfiByPass = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.pwfiByPass#">,
    pwfivgtID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.pwfivgtID#">,
    pwfictID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.pwfictID#">,
    pwfipotID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.pwfipotID#">,
    siteNo = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.siteNo#">,
    pwfiQOH = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.pwfiQOH#">,
    pwfisID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.pwfisID#">,
    pwfiStatus = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.pwfiStatus#">
    WHERE ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ID#">
    </cfquery>
    <!---Insert log entry.--->
    <cfinvoke 
    component="MCMS.component.app.photography_workflow.PhotographyWorkflow"
    method="insertPWFItemLog"
    >
    <cfinvokeargument name="pwfiID" value="#ARGUMENTS.ID#"/>
    <cfinvokeargument name="userID" value="#session.userID#"/>
    <cfinvokeargument name="pwfilLog" value="#ARGUMENTS.pwfilLog#"/>
    <cfinvokeargument name="pwfisID" value="#ARGUMENTS.pwfisID#"/>
    <cfinvokeargument name="pwfilStatus" value="1"/>
    </cfinvoke>
    <!---Only do pipeline actions if the status has changed.--->
	<cfif ARGUMENTS.pwfisID NEQ ARGUMENTS.pwfisIDTemp>
    <!---Begin pipeline logic to handle email notifications, logs, and status changes.--->
    <cfinvoke 
    component="MCMS.component.app.photography_workflow.PhotographyWorkflow"
    method="setPWFPipeline"
    returnvariable="setPWFPipelineRet">
    <cfinvokeargument name="pwfiID" value="#ARGUMENTS.ID#"/>
    <cfinvokeargument name="pwfisID" value="#ARGUMENTS.pwfisID#"/>
    <cfinvokeargument name="pwfisIDTemp" value="#ARGUMENTS.pwfisIDTemp#"/>
    <cfinvokeargument name="userID" value="#session.userID#"/>
    <cfinvokeargument name="userEmail" value="#session.userUsername#"/>
    <cfinvokeargument name="userUsername" value="#session.username#"/>
    </cfinvoke>
    </cfif>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error updating the record.">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="updatePWFItemQOH" access="public" returntype="void">
    <cftry>
    <cfthread action="run" name="pwfSkuQOHUpdate" siteDSN="#application.mcmsDSN#" qohdsn="#application.qohdsn#">
    <!---Get any item has has a QOH of 0.--->
    <cfquery name="getPWFItemRet" datasource="#siteDSN#">
    SELECT ID, skuID, pwfisID FROM v_pwf_item
    WHERE pwfiQOH = <cfqueryparam value="0" cfsqltype="cf_sql_integer">
    ORDER BY pwfiDateDue DESC, skuID
    </cfquery>
    <!---If any item has a QOH of 0 then update the item(s).--->
    <cfif getPWFItemRet.recordcount NEQ 0>
    <!---Only update up to 250.--->
    <cfoutput query="getPWFItemRet" maxrows="250">
    <cfquery name="getSkuQOH_ERP" datasource="#qohdsn#">
    SELECT SITE_QOH FROM SKU_PRICE_INFO_V
    WHERE 0=0
    AND SKU = <cfqueryparam value="#getPWFItemRet.skuID#" cfsqltype="cf_sql_varchar">
    AND SITENO IN (<cfqueryparam value="300,802" list="yes" cfsqltype="cf_sql_varchar">)
    AND SITE_QOH > <cfqueryparam value="0" cfsqltype="cf_sql_numeric">
    ORDER BY SITENO, SKU
    </cfquery>
    <cfif getSkuQOH_ERP.recordcount EQ 0>
    <cfset this.pwfiQOH = 0>
    <cfelse>
    <cfset this.pwfiQOH = getSkuQOH_ERP.SITE_QOH>
    </cfif>
    <!---If there is a QOH for this item update the record.--->
    <cfif this.pwfiQOH NEQ 0>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_pwf_item SET
    pwfiQOH = <cfqueryparam cfsqltype="cf_sql_integer" value="#this.pwfiQOH#">
    WHERE ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#getPWFItemRet.ID#">
    </cfquery>
    <!---Insert log entry.--->
    <cfquery datasource="#application.mcmsDSN#">
    INSERT INTO tbl_pwf_item_log (pwfiID,userID,pwfilLog,pwfisID) VALUES
    (
    <cfqueryparam cfsqltype="cf_sql_integer" value="#getPWFItemRet.ID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="101">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="The QOH has been updated.">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#getPWFItemRet.pwfisID#">
    )
    </cfquery>
    <cflog file="pwf_sku_qoh_update" text="Update: PWF Item QOH Update! Item:#getPWFItemRet.ID# Sku:#getPWFItemRet.skuID# has been update to a QOH of #this.pwfiQOH#." type="information"/>
    </cfif>
    </cfoutput>
    </cfif>
    </cfthread>
    <cfcatch type="any">
    <cflog file="pwf_sku_qoh_error" text="Error: PWF Item QOH Update! Check pwfiID: #getPWFItemRet.ID#" type="error"/>
    </cfcatch>
    </cftry>
    </cffunction>
    
    <cffunction name="updatePWFItemInstructionLog" access="public" returntype="struct">
    <cfargument name="pwfiID" type="numeric" required="yes">
    <cfargument name="userID" type="numeric" required="yes">
    <cfargument name="pwfisID" type="numeric" required="yes">
    <cfargument name="pwfiDateDue" type="date" required="yes">
    <cfargument name="pwfilLog" type="string" required="yes" default="Status update.">
    <cfargument name="pwfiInstruction" type="string" required="yes" default="">
    <cfset result.message = "You have successfully updated the record.">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_pwf_item SET
    pwfiInstruction = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.pwfiInstruction#">,
    pwfiDate = <cfqueryparam cfsqltype="cf_sql_date" value="#DateFormat(Now(), application.dateFormat)#">,
    pwfiDateDue = <cfqueryparam cfsqltype="cf_sql_date" value="#ARGUMENTS.pwfiDateDue#">,
    pwfisID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.pwfisID#">
    WHERE ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.pwfiID#">
    </cfquery>
    <cfif ARGUMENTS.pwfilLog NEQ ''>
    <!---Insert log entry.--->
    <cfinvoke 
    component="MCMS.component.app.photography_workflow.PhotographyWorkflow"
    method="insertPWFItemLog"
    >
    <cfinvokeargument name="pwfiID" value="#ARGUMENTS.pwfiID#"/>
    <cfinvokeargument name="userID" value="#ARGUMENTS.userID#"/>
    <cfinvokeargument name="pwfilLog" value="#ARGUMENTS.pwfilLog#"/>
    <cfinvokeargument name="pwfisID" value="#ARGUMENTS.pwfisID#"/>
    <cfinvokeargument name="pwfilStatus" value="1"/>
    </cfinvoke>
    </cfif>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error updating the record.">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="updatePWFItemImageRel" access="public" returntype="struct">
    <cfargument name="ID" type="numeric" required="yes">
    <cfargument name="imgID" type="numeric" required="yes">
    <cfargument name="pwfiID" type="numeric" required="yes">
    <cfargument name="pwfisID" type="numeric" required="yes">
    <cfargument name="pwfivtID" type="numeric" required="yes">
    <cfargument name="pwfiatID" type="numeric" required="yes">
    <cfargument name="pwfiasID" type="numeric" required="yes">
    <cfargument name="pwfiirRemoteFilePath" type="string" required="yes">
    <cfargument name="pwfiirNote" type="string" required="yes">
    <cfargument name="imgName" type="string" required="yes">
    <cfargument name="altName" type="string" required="yes">
    <cfargument name="imgFile" type="string" required="yes">
    <cfargument name="tempImgFile" type="string" required="yes">
    <cfargument name="imgtID" type="numeric" required="yes">
    <cfargument name="imgSort" type="numeric" required="yes">
    <cfargument name="imgStatus" type="numeric" required="yes">
    <cfargument name="pwfiirStatus" type="numeric" required="yes">
    <cfargument name="imgCountID" type="numeric" required="yes">
    <cfargument name="imgCount" type="numeric" required="yes">
    <!---Log entry.--->
    <cfargument name="pwfilLog" type="string" required="yes" default="Photo update.">
    <!---Include a list of all photo approval statuses for item status switching.--->
    <cfargument name="pwfiasIDList" type="string" required="yes" default="0">
    <!---Email arguments.--->
    <cfargument name="uaID" type="numeric" required="yes">
    <cfargument name="userEmail" type="string" required="yes" default="#session.userEmail#">
    <cfset result.message = "You have successfully updated the record.">
    <cftry>
    <!---Update the image and then record the relationship if it is being updated.--->
    <cfif ARGUMENTS.imgFile NEQ ''>
    <cfinvoke 
    component="MCMS.component.app.image.Image" 
    method="updateImage"
    returnvariable="result"
    >
    <cfinvokeargument name="ID" value="#ARGUMENTS.imgID#">
    <cfinvokeargument name="uaID" value="#ARGUMENTS.uaID#">
    <cfinvokeargument name="imgName" value="#ARGUMENTS.imgName#">
    <cfinvokeargument name="altName" value="#ARGUMENTS.altName#">
    <cfinvokeargument name="imgFile" value="#ARGUMENTS.imgFile#">
    <cfinvokeargument name="tempImgFile" value="#ARGUMENTS.tempImgFile#">
    <cfinvokeargument name="imgtID" value="#ARGUMENTS.imgtID#">
    <cfinvokeargument name="imgSort" value="#ARGUMENTS.imgSort#">
    <cfinvokeargument name="imgStatus" value="1">
    <cfinvokeargument name="imgCountID" value="#ARGUMENTS.imgCountID#">                 
    </cfinvoke>
    <!---If any image is uploaded it forces the item status back to 'Ready'.--->
    <cfset ARGUMENTS.pwfisID = 6>
    <!---If any image is uploaded it forces the item approval statuses back to 'Pending & Reshot'.--->
    <cfset ARGUMENTS.pwfiasID = 1>
    <cfset ARGUMENTS.pwfiatID = 3>
    <!---Update the item status.--->
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_pwf_item SET
    pwfiDate = <cfqueryparam cfsqltype="cf_sql_date" value="#DateFormat(Now(), application.dateFormat)#">,
    pwfisID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.pwfisID#">
    WHERE ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.pwfiID#">
    </cfquery>
    </cfif>
    <!---If the Approval Status is 'Approved' and all images are approved then update the item status.--->
    <cfif ARGUMENTS.pwfiasID EQ 2>
    <!---Now replace this images status in the list and evaluate if there are any other images in the list that are approved to them update the item status.--->
    <cfset updateItemStatus = 'true'>
    <cfset replacepwfiasIDList = ListSetAt(ARGUMENTS.pwfiasIDList, ARGUMENTS.imgCountID, 2)>
    <cfif ListContains(replacepwfiasIDList, 1) OR ListContains(replacepwfiasIDList, 3)>
    <cfset updateItemStatus = 'false'>
    </cfif>
    <cfif updateItemStatus EQ 'true'>
    <!---Update the item status.--->
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_pwf_item SET
    pwfiDate = <cfqueryparam cfsqltype="cf_sql_date" value="#DateFormat(Now(), application.dateFormat)#">,
    pwfisID = <cfqueryparam cfsqltype="cf_sql_integer" value="7">
    WHERE ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.pwfiID#">
    </cfquery>
    </cfif>
    </cfif>
    <!---If the Approval Status is 'Not Approved'.--->
    <cfif ARGUMENTS.pwfiasID EQ 3>
    <!---Update the item status.--->
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_pwf_item SET
    pwfiDate = <cfqueryparam cfsqltype="cf_sql_date" value="#DateFormat(Now(), application.dateFormat)#">,
    pwfisID = <cfqueryparam cfsqltype="cf_sql_integer" value="8">
    WHERE ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.pwfiID#">
    </cfquery>
    </cfif>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_pwf_item_image_rel SET
	pwfiID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.pwfiID#">,
    imgID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.imgID#">,
    pwfivtID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.pwfivtID#">,
    pwfiatID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.pwfiatID#">,
    pwfiasID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.pwfiasID#">,
    pwfiirNote = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.pwfiirNote#">,
    pwfiirStatus = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.pwfiirStatus#">
    WHERE ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ID#">
    </cfquery>
    <!---Insert log entry.--->
    <cfinvoke 
    component="MCMS.component.app.photography_workflow.PhotographyWorkflow"
    method="insertPWFItemLog"
    >
    <cfinvokeargument name="pwfiID" value="#ARGUMENTS.pwfiID#"/>
    <cfinvokeargument name="userID" value="#session.userID#"/>
    <cfinvokeargument name="pwfilLog" value="#ARGUMENTS.pwfilLog#"/>
    <cfinvokeargument name="pwfisID" value="#ARGUMENTS.pwfisID#"/>
    <cfinvokeargument name="pwfilStatus" value="1"/>
    </cfinvoke>
    <!---Send email notification when an image is reuploaded and or a not approved is switched to reshot.--->
	<cfif ARGUMENTS.pwfiasID EQ 3>
    <cfinvoke 
    component="MCMS.component.utility.Email"
    method="sendEmail">
    <cfinvokeargument name="subject" value="Photography Workflow NOT APPROVED - #ARGUMENTS.imgName#"/>
    <cfinvokeargument name="to" value="#application.pwfPhotographerEmail#"/>
    <cfinvokeargument name="from" value="#ARGUMENTS.userEmail#"/>
    <cfinvokeargument name="body" value=""/>
    <cfinvokeargument name="ID" value="#ARGUMENTS.ID#"/>
    <cfinvokeargument name="emailTemplate" value="/#application.mcmsAppAdminPath#/photography_workflow/view/inc_pwf_item_image_rel_email_template.cfm"/>
    </cfinvoke>
    <cfelseif ARGUMENTS.pwfiasID EQ 2 AND ARGUMENTS.pwfilLog NEQ ''>
    <cfinvoke 
    component="MCMS.component.utility.Email"
    method="sendEmail">
    <cfinvokeargument name="subject" value="Photography Workflow APPROVED - #ARGUMENTS.imgName#"/>
    <cfinvokeargument name="to" value="#ARGUMENTS.userEmail#"/>
    <cfinvokeargument name="from" value="#application.pwfPhotographerEmail#"/>
    <cfinvokeargument name="body" value=""/>
    <cfinvokeargument name="ID" value="#ARGUMENTS.ID#"/>
    <cfinvokeargument name="emailTemplate" value="/#application.mcmsAppAdminPath#/photography_workflow/view/inc_pwf_item_image_rel_email_template.cfm"/>
    </cfinvoke>
    <!---Send email for re-shot photo.--->
    <cfelseif ARGUMENTS.pwfiatID EQ 3>
    <cfinvoke 
    component="MCMS.component.utility.Email"
    method="sendEmail">
    <cfinvokeargument name="subject" value="Photography Workflow RE-SHOT - #ARGUMENTS.imgName#"/>
    <cfinvokeargument name="to" value="#ARGUMENTS.userEmail#"/>
    <cfinvokeargument name="from" value="#application.pwfPhotographerEmail#"/>
    <cfinvokeargument name="body" value=""/>
    <cfinvokeargument name="ID" value="#ARGUMENTS.ID#"/>
    <cfinvokeargument name="emailTemplate" value="/#application.mcmsAppAdminPath#/photography_workflow/view/inc_pwf_item_image_rel_email_template.cfm"/>
    </cfinvoke>
    </cfif>
    <cfcatch type="any">
    <cfset result.message = "There was an error updating the record.">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="updatePWFImageViewGroupType" access="public" returntype="struct">
    <cfargument name="ID" type="numeric" required="yes">
    <cfargument name="pwfivgtName" type="string" required="yes">
    <cfargument name="pwfivgtDescription" type="string" required="yes">
    <cfargument name="deptNo" type="numeric" required="yes">
    <cfargument name="pwfivtID" type="string" required="yes">
    <cfargument name="pwfivgtSort" type="numeric" required="yes">
    <cfargument name="pwfivgtStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully updated the record.">
    <cftry>
    <!---Check for profanity in the text.--->
    <cfinvoke 
    component="MCMS.component.utility.Regex"
    method="regexProfanity"
    returnvariable="regexProfanityRet">
    <cfinvokeargument name="profanityString" value="#TRIM(ARGUMENTS.pwfivgtDescription)#"/>
    </cfinvoke>
    <!---Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.app.photography_workflow.PhotographyWorkflow"
    method="getPWFImageViewGroupType"
    returnvariable="getCheckPWFImageViewGroupTypeRet">
    <cfinvokeargument name="excludeID" value="#ARGUMENTS.ID#"/>
    <cfinvokeargument name="pwfivgtName" value="#TRIM(ARGUMENTS.pwfivgtName)#"/>
    <cfinvokeargument name="pwfivgtStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckPWFImageViewGroupTypeRet.recordcount NEQ 0>
    <cfset result.message = "The name #TRIM(ARGUMENTS.pwfivgtName)# already exists, please enter a new name.">
    <cfelseif regexProfanityRet CONTAINS '$%&*!'>
    <cfset result.message = "Some text contained profanity, please remove any profanity from your text.">
    <!---Check length restriction.--->
    <cfelseif LEN(ARGUMENTS.pwfivgtDescription) GT 255>
    <cfset result.message = "The description is longer than 255 characters, please enter a new description under 255 characters.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_pwf_image_view_group_type SET
    pwfivgtName = <cfqueryparam cfsqltype="cf_sql_varchar" value="#TRIM(ARGUMENTS.pwfivgtName)#">,
    pwfivgtDescription = <cfqueryparam cfsqltype="cf_sql_varchar" value="#TRIM(ARGUMENTS.pwfivgtDescription)#">,
    deptNo = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.deptNo#">,
    pwfivgtSort = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.pwfivgtSort#">,
    pwfivgtStatus = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.pwfivgtStatus#">
    WHERE ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ID#">
    </cfquery>
    <!---Delete any existing relationships.--->
    <cfinvoke 
    component="MCMS.component.app.photography_workflow.PhotographyWorkflow"
    method="deletePWFImageViewGroupTypeRel"
    >
    <cfinvokeargument name="pwfivgtID" value="#ARGUMENTS.ID#"/>
    </cfinvoke>
    <!---Now insert any relationships.--->
    <cfloop list="#ARGUMENTS.pwfivtID#" index="i">
    <cfinvoke 
    component="MCMS.component.app.photography_workflow.PhotographyWorkflow"
    method="insertPWFImageViewGroupTypeRel"
    >
    <cfinvokeargument name="pwfivgtID" value="#ARGUMENTS.ID#"/>
    <cfinvokeargument name="pwfivtID" value="#i#"/>
    <cfinvokeargument name="pwfivgtrStatus" value="1"/>
    </cfinvoke>
    </cfloop>
    </cftransaction>
    </cfif>
    <cfcatch type="any">
    <cfset result.message = "There was an error updating the record.">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="updatePWFImageViewType" access="public" returntype="struct">
    <cfargument name="ID" type="numeric" required="yes">
    <cfargument name="pwfivtName" type="string" required="yes">
    <cfargument name="pwfivtDescription" type="string" required="yes">
    <cfargument name="pwfivtSort" type="numeric" required="yes">
    <cfargument name="pwfivtStatus" type="numeric" required="yes">
    <!---Include Image View Group Type Relationship.--->
    <cfargument name="pwfivgtID" type="string" required="yes">
    <cfset result.message = "You have successfully updated the record.">
    <cftry>
    <!---Check for profanity in the text.--->
    <cfinvoke 
    component="MCMS.component.utility.Regex"
    method="regexProfanity"
    returnvariable="regexProfanityRet">
    <cfinvokeargument name="profanityString" value="#TRIM(ARGUMENTS.pwfivtDescription)#"/>
    </cfinvoke>
    <!---Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.app.photography_workflow.PhotographyWorkflow"
    method="getPWFImageViewType"
    returnvariable="getCheckPWFImageViewTypeRet">
    <cfinvokeargument name="excludeID" value="#ARGUMENTS.ID#"/>
    <cfinvokeargument name="pwfivtName" value="#TRIM(ARGUMENTS.pwfivtName)#"/>
    <cfinvokeargument name="pwfivtStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckPWFImageViewTypeRet.recordcount NEQ 0>
    <cfset result.message = "The name #TRIM(ARGUMENTS.pwfivtName)# already exists, please enter a new name.">
    <cfelseif regexProfanityRet CONTAINS '$%&*!'>
    <cfset result.message = "Some text contained profanity, please remove any profanity from your text.">
    <!---Check length restriction.--->
    <cfelseif LEN(ARGUMENTS.pwfivtDescription) GT 255>
    <cfset result.message = "The description is longer than 255 characters, please enter a new description under 255 characters.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_pwf_image_view_type SET
    pwfivtName = <cfqueryparam cfsqltype="cf_sql_varchar" value="#TRIM(ARGUMENTS.pwfivtName)#">,
    pwfivtDescription = <cfqueryparam cfsqltype="cf_sql_varchar" value="#TRIM(ARGUMENTS.pwfivtDescription)#">,
    pwfivtSort = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.pwfivtSort#">,
    pwfivtStatus = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.pwfivtStatus#">
    WHERE ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ID#">
    </cfquery>
    <!---Delete any existing relationships.--->
    <cfinvoke 
    component="MCMS.component.app.photography_workflow.PhotographyWorkflow"
    method="deletePWFImageViewGroupTypeRel"
    >
    <cfinvokeargument name="pwfivtID" value="#ARGUMENTS.ID#">
    </cfinvoke>
    <!---Insert relationship(s).--->
    <cfloop list="#ARGUMENTS.pwfivgtID#" index="i">
    <cfinvoke 
    component="MCMS.component.app.photography_workflow.PhotographyWorkflow" 
    method="insertPWFImageViewGroupTypeRel" 
    >
    <cfinvokeargument name="pwfivtID" value="#ARGUMENTS.ID#">
    <cfinvokeargument name="pwfivgtID" value="#i#"> >  
    <cfinvokeargument name="pwfivgtrStatus" value="1">                     
    </cfinvoke>
    </cfloop>
    </cftransaction>
    </cfif>
    <cfcatch type="any">
    <cfset result.message = "There was an error updating the record.">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="updatePWFImageApprovalType" access="public" returntype="struct">
    <cfargument name="ID" type="numeric" required="yes">
    <cfargument name="pwfiatName" type="string" required="yes">
    <cfargument name="pwfiatDescription" type="string" required="yes">
    <cfargument name="pwfiatSort" type="numeric" required="yes">
    <cfargument name="pwfiatStatus" type="numeric" required="yes">
    <!---Include Image Approval Status Type Relationship.--->
    <cfargument name="pwfiasID" type="string" required="yes">
    <cfset result.message = "You have successfully updated the record.">
    <cftry>
    <!---Check for profanity in the text.--->
    <cfinvoke 
    component="MCMS.component.utility.Regex"
    method="regexProfanity"
    returnvariable="regexProfanityRet">
    <cfinvokeargument name="profanityString" value="#TRIM(ARGUMENTS.pwfiatDescription)#"/>
    </cfinvoke>
    <!---Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.app.photography_workflow.PhotographyWorkflow"
    method="getPWFImageApprovalType"
    returnvariable="getCheckPWFImageApprovalTypeRet">
    <cfinvokeargument name="excludeID" value="#ARGUMENTS.ID#"/>
    <cfinvokeargument name="pwfiatName" value="#TRIM(ARGUMENTS.pwfiatName)#"/>
    <cfinvokeargument name="pwfiatStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckPWFImageApprovalTypeRet.recordcount NEQ 0>
    <cfset result.message = "The name #TRIM(ARGUMENTS.pwfiatName)# already exists, please enter a new name.">
    <cfelseif regexProfanityRet CONTAINS '$%&*!'>
    <cfset result.message = "Some text contained profanity, please remove any profanity from your text.">
    <!---Check length restriction.--->
    <cfelseif LEN(ARGUMENTS.pwfiatDescription) GT 255>
    <cfset result.message = "The description is longer than 255 characters, please enter a new description under 255 characters.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_pwf_image_approval_type SET
    pwfiatName = <cfqueryparam cfsqltype="cf_sql_varchar" value="#TRIM(ARGUMENTS.pwfiatName)#">,
    pwfiatDescription = <cfqueryparam cfsqltype="cf_sql_varchar" value="#TRIM(ARGUMENTS.pwfiatDescription)#">,
    pwfiatSort = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.pwfiatSort#">,
    pwfiatStatus = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.pwfiatStatus#">
    WHERE ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ID#">
    </cfquery>
    <!---Delete any existing relationships.--->
    <cfinvoke 
    component="MCMS.component.app.photography_workflow.PhotographyWorkflow"
    method="deletePWFImageApprovalStatusTypeRel"
    >
    <cfinvokeargument name="pwfiatID" value="#ARGUMENTS.ID#">
    </cfinvoke>
    <!---Insert relationship(s).--->
    <cfloop list="#ARGUMENTS.pwfiasID#" index="i">
    <cfinvoke 
    component="MCMS.component.app.photography_workflow.PhotographyWorkflow" 
    method="insertPWFImageApprovalStatusTypeRel" 
    >
    <cfinvokeargument name="pwfiatID" value="#ARGUMENTS.ID#">
    <cfinvokeargument name="pwfiasID" value="#i#"> >  
    <cfinvokeargument name="pwfiatsrStatus" value="1">                     
    </cfinvoke>
    </cfloop>
    </cftransaction>
    </cfif>
    <cfcatch type="any">
    <cfset result.message = "There was an error updating the record.">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="setPWFPipeline" access="package" returntype="struct" hint="Return PWF pipeline results. This acts as a handler to control actions based on the Item status">
    <cfargument name="pwfiID" type="numeric" required="yes" default="0">
    <cfargument name="pwfisID" type="numeric" required="yes" default="0">
    <cfargument name="pwfisIDTemp" type="numeric" required="yes" default="0">
    <cfargument name="userID" type="numeric" required="yes" default="0">
    <cfargument name="userEmail" type="string" required="yes" default="">
    <cfargument name="userUsername" type="string" required="yes" default="">
    
    <cfset result = StructNew()>
    <cfset result.message = 'Photography Workflow pipleine action completed.'>
    <cfset result.emailSubject = 'Photography Worklow'>
    <cfset result.toEmail = application.webmasterEmail>
    <cfset result.fromEmail = application.webmasterEmail>
    <cfset result.ccEmail = ''>
    <cfset result.logMessage = 'Status Changed.'>
    <cfset result.emailBody = ''>
    
    <cftry>
    <!---Get the PWF Item data.--->
    <cfinvoke 
    component="MCMS.component.app.photography_workflow.PhotographyWorkflow"
    method="getPWFItem"
    returnvariable="getPWFItemRet">
    <cfinvokeargument name="ID" value="#ARGUMENTS.pwfiID#"/>
    <cfinvokeargument name="pwfiStatus" value="1"/>
    </cfinvoke>
    
    <!---Get each status name for the log message.--->
    <cfinvoke 
    component="MCMS.component.app.photography_workflow.PhotographyWorkflow"
    method="getPWFItemStatus"
    returnvariable="getCurrentPWFItemStatusRet">
    <cfinvokeargument name="ID" value="#ARGUMENTS.pwfisIDTemp#"/>
    <cfinvokeargument name="pwfisStatus" value="1"/>
    </cfinvoke>
    
    <cfset this.currentStatusName = getCurrentPWFItemStatusRet.pwfisName>
    
    <cfinvoke 
    component="MCMS.component.app.photography_workflow.PhotographyWorkflow"
    method="getPWFItemStatus"
    returnvariable="getNewPWFItemStatusRet">
    <cfinvokeargument name="ID" value="#ARGUMENTS.pwfisID#"/>
    <cfinvokeargument name="pwfisStatus" value="1"/>
    </cfinvoke>
    
    <cfset this.newStatusName = getNewPWFItemStatusRet.pwfisName>
    
    <cfswitch expression="#ARGUMENTS.pwfisID#">
    <cfdefaultcase></cfdefaultcase>
    
    <cfcase value="1">
    <!---Actions for "New to Queue".--->
    <cfset result.emailSubject = 'Photography Workflow - #UCASE(this.newStatusName)# - #getPWFItemRet.pName#'>
    <cfset result.toEmail = application.pwfPhotographerEmail>
    <cfset result.fromEmail = ARGUMENTS.userEmail>
    <cfset result.emailBody = 'This item has been set to new to queue status by #ARGUMENTS.userUsername#.'>
    <cfset result.logMessage = 'Status was changed from #this.currentStatusName# to #this.newStatusName#.'>
    </cfcase>
    
    <cfcase value="2">
    <!---Actions for "On Order".--->
    <cfset result.emailSubject = 'Photography Workflow - #UCASE(this.newStatusName)# - #getPWFItemRet.pName#'>
    <!---Determine which email address to send the request.--->
    <cfif getPWFItemRet.siteNo EQ 98>
    <cfset result.toEmail = application.pwfReceivingEmail>
    <cfelseif getPWFItemRet.siteNo EQ 114>
    <cfset result.toEmail = application.webmasterEmail>
    <!---Change to this for Prod.
    <cfset result.toEmail = '114-receiving.intranet.sw'>
	--->
    </cfif>
    <cfset result.fromEmail = ARGUMENTS.userEmail>
    <cfset result.emailBody = 'This item has been requested by #ARGUMENTS.userUsername# for receiving to stage for delivery to the Photography group for processing.'>
    <cfset result.logMessage = 'Status was changed from #this.currentStatusName# to #this.newStatusName#.'>
    </cfcase>
    
    <cfcase value="3">
    <!---Actions for "Staging".--->
    <cfset result.emailSubject = 'Photography Workflow - #UCASE(this.newStatusName)# - #getPWFItemRet.pName#'>
    <!---Determine which email address to send the request.--->
    <cfif getPWFItemRet.siteNo EQ 98>
    <cfset result.toEmail = application.pwfReceivingEmail>
    <cfelseif getPWFItemRet.siteNo EQ 114>
    <cfset result.toEmail = application.webmasterEmail>
    <!---Change to this for Prod.
    <cfset result.toEmail = '114-receiving.intranet.sw'>
	--->
    </cfif>
    <cfset result.fromEmail = ARGUMENTS.userEmail>
    <cfset result.ccEmail = application.pwfPhotographerEmail>
    <cfset result.emailBody = 'This item is being staged by #ARGUMENTS.userUsername# for delivery to the Photography group for processing.'>
    <cfset result.logMessage = 'Status was changed from #this.currentStatusName# to #this.newStatusName#.'>
    </cfcase>
    
    <cfcase value="4">
    <!---Actions for "Shipping".--->
    <cfset result.emailSubject = 'Photography Workflow - #UCASE(this.newStatusName)# - #getPWFItemRet.pName#'>
    <!---Determine which email address to send the request.--->
    <cfif getPWFItemRet.siteNo EQ 98>
    <cfset result.toEmail = application.pwfReceivingEmail>
    <cfelseif getPWFItemRet.siteNo EQ 114>
    <cfset result.toEmail = application.webmasterEmail>
    <!---Change to this for Prod.
    <cfset result.toEmail = '114-receiving.intranet.sw'>
	--->
    </cfif>
    <cfset result.fromEmail = ARGUMENTS.userEmail>
    <cfset result.ccEmail = application.pwfPhotographerEmail>
    <cfset result.emailBody = 'This item is being shipped by #ARGUMENTS.userUsername# to the Photography group for processing.'>
    <cfset result.logMessage = 'Status was changed from #this.currentStatusName# to #this.newStatusName#.'>
    </cfcase>
    
    <cfcase value="5">
    <!---Actions for "In Studio".--->
    <cfset result.emailSubject = 'Photography Workflow - #UCASE(this.newStatusName)# - #getPWFItemRet.pName#'>
    <!---Determine which email address to send the request.--->
    <cfif getPWFItemRet.siteNo EQ 98>
    <cfset result.toEmail = application.pwfReceivingEmail>
    <cfelseif getPWFItemRet.siteNo EQ 114>
    <cfset result.toEmail = application.webmasterEmail>
    <!---Change to this for Prod.
    <cfset result.toEmail = '114-receiving.intranet.sw'>
	--->
    </cfif>
    <cfset result.fromEmail = ARGUMENTS.userEmail>
    <cfset result.emailBody = 'This item has been recieved by #ARGUMENTS.userUsername# to be processed.'>
    <cfset result.logMessage = 'Status was changed from #this.currentStatusName# to #this.newStatusName#.'>
    </cfcase>
    
    <cfcase value="6">
    <!---Actions for "Shot".--->
    <cfset result.emailSubject = 'Photography Workflow - #UCASE(this.newStatusName)# - #getPWFItemRet.pName#'>
    <!---Determine which email address to send the request.--->
    <cfset result.toEmail = getPWFItemRet.userEmail>
    <cfset result.fromEmail = ARGUMENTS.userEmail>
    <cfset result.emailBody = 'This item is ready for photography approval.'>
    <cfset result.logMessage = 'Status was changed from #this.currentStatusName# to #this.newStatusName#.'>
    </cfcase>
    
    <cfcase value="7">
    <!---Actions for "Approved".--->
    <cfset result.emailSubject = 'Photography Workflow - #UCASE(this.newStatusName)# - #getPWFItemRet.pName#'>
    <!---Determine which email address to send the request.--->
    <cfset result.toEmail = application.pwfPhotographerEmail>
    <cfset result.fromEmail = ARGUMENTS.userEmail>
    <cfset result.emailBody = 'This items photography has been approved.'>
    <cfset result.logMessage = 'Status was changed from #this.currentStatusName# to #this.newStatusName#.'>
    </cfcase>
    
    <cfcase value="8">
    <!---Actions for "Not Approved".--->
    <cfset result.emailSubject = 'Photography Workflow - #UCASE(this.newStatusName)# - #getPWFItemRet.pName#'>
    <!---Determine which email address to send the request.--->
    <cfset result.toEmail = application.pwfPhotographerEmail>
    <cfset result.fromEmail = ARGUMENTS.userEmail>
    <cfset result.emailBody = 'This items photography has NOT been approved.'>
    <cfset result.logMessage = 'Status was changed from #this.currentStatusName# to #this.newStatusName#.'>
    </cfcase>
    
    <cfcase value="9">
    <!---Actions for "Complete".--->
    <cfset result.emailSubject = 'Photography Workflow - #UCASE(this.newStatusName)# - #getPWFItemRet.pName#'>
    <!---Determine which email address to send the request.--->
    <cfif getPWFItemRet.siteNo EQ 98>
    <cfset result.toEmail = application.pwfReceivingEmail>
    <cfelseif getPWFItemRet.siteNo EQ 114>
    <cfset result.toEmail = application.webmasterEmail>
    <!---Change to this for Prod.
    <cfset result.toEmail = '114-receiving.intranet.sw'>
	--->
    </cfif>
    <cfset result.fromEmail = ARGUMENTS.userEmail>
    <cfset result.emailBody = 'This item has been set to complete by #ARGUMENTS.userUsername# for receiving to receive for return to inventory.'>
    <cfset result.logMessage = 'Status was changed from #this.currentStatusName# to #this.newStatusName#.'>
    </cfcase>
    
    <cfcase value="10">
    <!---Actions for "Returned".--->
    <cfset result.emailSubject = 'Photography Workflow - #UCASE(this.newStatusName)# - #getPWFItemRet.pName#'>
    <!---Determine which email address to send the request.--->
    <cfif getPWFItemRet.siteNo EQ 98>
    <cfset result.toEmail = application.pwfReceivingEmail>
    <cfelseif getPWFItemRet.siteNo EQ 114>
    <cfset result.toEmail = application.webmasterEmail>
    <!---Change to this for Prod.
    <cfset result.toEmail = '114-receiving.intranet.sw'>
	--->
    </cfif>
    <cfset result.fromEmail = ARGUMENTS.userEmail>
    <cfset result.emailBody = 'This item has been returned and recieved by #ARGUMENTS.userUsername# and returned to inventory.'>
    <cfset result.logMessage = 'Status was changed from #this.currentStatusName# to #this.newStatusName#.'>
    </cfcase>
    
    <cfcase value="11">
    <!---Actions for "Returned".--->
    <cfset result.emailSubject = 'Photography Workflow - #UCASE(this.newStatusName)# - #getPWFItemRet.pName#'>
    <!---Determine which email address to send the request.--->
    <cfif getPWFItemRet.siteNo EQ 98>
    <cfset result.toEmail = application.pwfReceivingEmail>
    <cfelseif getPWFItemRet.siteNo EQ 114>
    <cfset result.toEmail = application.webmasterEmail>
    <!---Change to this for Prod.
    <cfset result.toEmail = '114-receiving.intranet.sw'>
	--->
    </cfif>
    <cfset result.fromEmail = ARGUMENTS.userEmail>
    <cfset result.emailBody = 'This item has been paid out #ARGUMENTS.userUsername#.'>
    <cfset result.logMessage = 'Status was changed from #this.currentStatusName# to #this.newStatusName#.'>
    </cfcase>
    
    <cfcase value="12">
    <!---Actions for "Error".--->
    <cfset result.emailSubject = 'Photography Workflow - #UCASE(this.newStatusName)# - #getPWFItemRet.pName#'>
    <!---Determine which email address to send the request.--->
    <cfset result.toEmail = application.webmasterEmail>
    <cfset result.fromEmail = ARGUMENTS.userEmail>
    <cfset result.emailBody = 'This item has been errored #ARGUMENTS.userUsername#. Please identify why the item has been errored in an attempt to prevent further errors.'>
    <cfset result.logMessage = 'Status was changed from #this.currentStatusName# to #this.newStatusName#.'>
    </cfcase>
    
    <cfcase value="14">
    <!---Actions for "Pending".--->
    <cfset result.emailSubject = 'Photography Workflow - #UCASE(this.newStatusName)# - #getPWFItemRet.pName#'>
    <cfset result.toEmail = application.pwfPhotographerEmail>
    <cfset result.fromEmail = ARGUMENTS.userEmail>
    <cfset result.emailBody = 'This item has been set to update existing by #ARGUMENTS.userUsername#.'>
    <cfset result.logMessage = 'Status was changed from #this.currentStatusName# to #this.newStatusName#.'>
    </cfcase>
    </cfswitch>
    
    <!---Insert Item Log record.--->
    <cfinvoke 
    component="MCMS.component.app.photography_workflow.PhotographyWorkflow"
    method="insertPWFItemLog"
    >
    <cfinvokeargument name="pwfiID" value="#ARGUMENTS.pwfiID#"/>
    <cfinvokeargument name="userID" value="#ARGUMENTS.userID#"/>
    <cfinvokeargument name="pwfilLog" value="#result.logMessage#"/>
    <cfinvokeargument name="pwfisID" value="#ARGUMENTS.pwfisID#"/>
    <cfinvokeargument name="pwfilStatus" value="1"/>
    </cfinvoke>
    
    <!--- Send email notifications if the toEmail is not NULL. And the status is Ready or Not Approved. --->
    <cfif result.toEmail NEQ '' AND (ARGUMENTS.pwfisID EQ 6 OR ARGUMENTS.pwfisID EQ 8)>
    <cfinvoke 
    component="MCMS.component.utility.Email"
    method="sendEmail">
    <cfinvokeargument name="subject" value="#result.emailSubject#"/>
    <cfinvokeargument name="to" value="#result.toEmail#"/>
    <cfinvokeargument name="from" value="#result.fromEmail#"/>
    <cfinvokeargument name="cc" value="#result.ccEmail#"/>
    <cfinvokeargument name="body" value="#result.emailBody#"/>
    <cfinvokeargument name="ID" value="#ARGUMENTS.pwfiID#"/>
    <cfinvokeargument name="emailTemplate" value="/#application.mcmsAppAdminPath#/photography_workflow/view/inc_pwf_pipeline_email_template.cfm"/>
    </cfinvoke>
    </cfif>
    
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset result = StructNew()>
    <cfset result.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="updatePWFItemList" access="public" returntype="struct">
    <cfargument name="ID" type="numeric" required="yes">
    <cfargument name="pwfisID" type="numeric" required="yes">
    <cfargument name="pwfisIDTemp" type="numeric" required="yes">
    <cfset result.message = "You have successfully updated the records.">
    <cftry>
    <!---Update the Item record.--->
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_pwf_item SET
    <!---Only update the date if the status has changed.--->
	<cfif ARGUMENTS.pwfisID NEQ ARGUMENTS.pwfisIDTemp>
    pwfiDate = <cfqueryparam cfsqltype="cf_sql_date" value="#Now()#">,
    </cfif>
    pwfisID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.pwfisID#">
    WHERE ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ID#">
    </cfquery>
    <!---Only do pipeline actions if the status has changed.--->
	<cfif ARGUMENTS.pwfisID NEQ ARGUMENTS.pwfisIDTemp>
    <!---Begin pipeline logic to handle email notifications, logs, and status changes.--->
    <cfinvoke 
    component="MCMS.component.app.photography_workflow.PhotographyWorkflow"
    method="setPWFPipeline"
    returnvariable="setPWFPipelineRet">
    <cfinvokeargument name="pwfiID" value="#ARGUMENTS.ID#"/>
    <cfinvokeargument name="pwfisID" value="#ARGUMENTS.pwfisID#"/>
    <cfinvokeargument name="pwfisIDTemp" value="#ARGUMENTS.pwfisIDTemp#"/>
    <cfinvokeargument name="userID" value="#session.userID#"/>
    <cfinvokeargument name="userEmail" value="#session.userUsername#"/>
    <cfinvokeargument name="userUsername" value="#session.username#"/>
    </cfinvoke>
    </cfif>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error updating the records.">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="updatePWFImageViewGroupTypeList" access="public" returntype="struct">
    <cfargument name="ID" type="numeric" required="yes">
    <cfargument name="pwfivgtStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully updated the records.">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_pwf_image_view_group_type SET
    pwfivgtStatus = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.pwfivgtStatus#">
    WHERE ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ID#">
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error updating the records.">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="updatePWFImageViewTypeList" access="public" returntype="struct">
    <cfargument name="ID" type="numeric" required="yes">
    <cfargument name="pwfivtStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully updated the records.">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_pwf_image_view_type SET
    pwfivtStatus = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.pwfivtStatus#">
    WHERE ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ID#">
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error updating the records.">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="updatePWFImageApprovalTypeList" access="public" returntype="struct">
    <cfargument name="ID" type="numeric" required="yes">
    <cfargument name="pwfiatStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully updated the records.">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_pwf_image_approval_type SET
    pwfiatStatus = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.pwfiatStatus#">
    WHERE ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ID#">
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error updating the records.">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="deletePWFItem" access="public" returntype="struct">
    <cfargument name="ID" type="string" required="yes" default="0">
    <cfargument name="sID" type="string" required="yes" default="0">
    <cfif ARGUMENTS.ID EQ 0>
    <cfset result.message = "You have successfully updated the record(s).">
    <cfelse>
    <cfset result.message = "You have successfully deleted the record(s).">
    </cfif>
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    DELETE FROM tbl_pwf_item
    WHERE ID IN (<cfqueryparam cfsqltype="cf_sql_integer" list="yes" value="#ARGUMENTS.ID#">)
    OR sID IN (<cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.sID#">)
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error deleting the record(s).">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="deletePWFItemImageRel" access="public" returntype="struct">
    <cfargument name="ID" type="string" required="yes" default="0">
    <cfargument name="pwfivtID" type="string" required="yes" default="0">
    <cfset result.message = "You have successfully deleted the record(s).">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    DELETE FROM tbl_pwf_item_image_rel
    WHERE ID IN (<cfqueryparam cfsqltype="cf_sql_integer" list="yes" value="#ARGUMENTS.ID#">)
    OR pwfivtID IN (<cfqueryparam cfsqltype="cf_sql_integer" list="yes" value="#ARGUMENTS.pwfivtID#">)
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error deleting the record(s).">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="deletePWFImageViewGroupType" access="public" returntype="struct">
    <cfargument name="ID" type="string" required="yes">
    <cfset result.message = "You have successfully deleted the record(s).">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    DELETE FROM tbl_pwf_image_view_group_type
    WHERE ID IN (<cfqueryparam cfsqltype="cf_sql_integer" list="yes" value="#ARGUMENTS.ID#">)
    </cfquery>
    <!---Delete any existing relationships.--->
    <cfinvoke 
    component="MCMS.component.app.photography_workflow.PhotographyWorkflow"
    method="deletePWFImageViewGroupTypeRel"
    >
    <cfinvokeargument name="pwfivgtID" value="#ARGUMENTS.ID#">
    </cfinvoke>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error deleting the record(s).">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="deletePWFImageViewType" access="public" returntype="struct">
    <cfargument name="ID" type="string" required="yes">
    <cfset result.message = "You have successfully deleted the record(s).">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    DELETE FROM tbl_pwf_image_view_type
    WHERE ID IN (<cfqueryparam cfsqltype="cf_sql_integer" list="yes" value="#ARGUMENTS.ID#">)
    </cfquery>
    <!---Delete any existing relationships.--->
    <cfinvoke 
    component="MCMS.component.app.photography_workflow.PhotographyWorkflow"
    method="deletePWFItemImageRel"
    >
    <cfinvokeargument name="pwfivtID" value="#ARGUMENTS.ID#">
    </cfinvoke>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error deleting the record(s).">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="deletePWFImageApprovalType" access="public" returntype="struct">
    <cfargument name="ID" type="string" required="yes">
    <cfset result.message = "You have successfully deleted the record(s).">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    DELETE FROM tbl_pwf_image_approval_type
    WHERE ID IN (<cfqueryparam cfsqltype="cf_sql_integer" list="yes" value="#ARGUMENTS.ID#">)
    </cfquery>
    <!---Delete any existing relationships.--->
    <cfinvoke 
    component="MCMS.component.app.photography_workflow.PhotographyWorkflow"
    method="deletePWFImageApprovalStatusTypeRel"
    >
    <cfinvokeargument name="pwfiatID" value="#ARGUMENTS.ID#">
    </cfinvoke>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error deleting the record(s).">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="deletePWFImageViewGroupTypeRel" access="public" returntype="struct">
    <cfargument name="ID" type="string" required="yes" default="0">
    <cfargument name="pwfivgtID" type="string" required="yes" default="0">
    <cfargument name="pwfivtID" type="string" required="yes" default="0">
    <cfset result.message = "You have successfully deleted the record(s).">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    DELETE FROM tbl_pwf_image_v_group_type_rel
    WHERE ID IN (<cfqueryparam cfsqltype="cf_sql_integer" list="yes" value="#ARGUMENTS.ID#">)
    OR (pwfivgtID IN (<cfqueryparam cfsqltype="cf_sql_integer" list="yes" value="#ARGUMENTS.pwfivgtID#">) 
    OR pwfivtID IN (<cfqueryparam cfsqltype="cf_sql_integer" list="yes" value="#ARGUMENTS.pwfivtID#">))
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error deleting the record(s).">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction> 
    
    <cffunction name="deletePWFImageApprovalStatusTypeRel" access="public" returntype="struct">
    <cfargument name="ID" type="string" required="yes" default="0">
    <cfargument name="pwfiasID" type="string" required="yes" default="0">
    <cfargument name="pwfiatID" type="string" required="yes" default="0">
    <cfset result.message = "You have successfully deleted the record(s).">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    DELETE FROM tbl_pwf_image_approval_t_s_rel
    WHERE ID IN (<cfqueryparam cfsqltype="cf_sql_integer" list="yes" value="#ARGUMENTS.ID#">)
    OR (pwfiasID IN (<cfqueryparam cfsqltype="cf_sql_integer" list="yes" value="#ARGUMENTS.pwfiasID#">) 
    OR pwfiatID IN (<cfqueryparam cfsqltype="cf_sql_integer" list="yes" value="#ARGUMENTS.pwfiatID#">))
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error deleting the record(s).">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>  
</cfcomponent>