<cfcomponent>
    <cffunction name="getMerchItem" access="public" returntype="query" hint="Get Merch Item data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="ID" type="numeric" required="yes" default="0">
    <cfargument name="excludeID" type="numeric" required="yes" default="0">
    <cfargument name="miName" type="string" required="yes" default="">
    <cfargument name="deptNo" type="string" required="yes" default="0">
    <cfargument name="miSort" type="string" required="yes" default="0">
    <cfargument name="miStatus" type="string" required="yes" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="miName">
    <cfset var rsMerchItem = "" >
    <cftry>
    <cfquery name="rsMerchItem" datasource="#application.mcmsDSN#">
    SELECT * FROM v_merch_item WHERE 0=0
    <cfif ARGUMENTS.ID NEQ 0>
    AND ID = <cfqueryparam value="#ARGUMENTS.ID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.excludeID NEQ 0>
    AND ID <> <cfqueryparam value="#ARGUMENTS.excludeID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(miName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(miDescription) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">)
    </cfif>
    <cfif ARGUMENTS.miName NEQ "">
    AND UPPER(miName) = <cfqueryparam value="#UCASE(ARGUMENTS.miName)#" cfsqltype="cf_sql_varchar">
    </cfif>
    <cfif ARGUMENTS.deptNo NEQ 0>
    AND deptNo IN (<cfqueryparam value="#ARGUMENTS.deptNo#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    <cfif ARGUMENTS.miSort NEQ 0>
    AND miSort = <cfqueryparam value="#ARGUMENTS.miSort#" cfsqltype="cf_sql_integer">
    </cfif>
    AND miStatus IN (<cfqueryparam value="#ARGUMENTS.miStatus#" list="yes" cfsqltype="cf_sql_integer">)
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsMerchItem = StructNew()>
    <cfset rsMerchItem.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsMerchItem>
    </cffunction>
    
    <cffunction name="getMerchItemSiteRel" access="public" returntype="query" hint="Get Merch Item Site Rel. data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="ID" type="numeric" required="yes" default="0">
    <cfargument name="excludeID" type="string" required="yes" default="0">
    <cfargument name="miID" type="numeric" required="yes" default="0">
    <cfargument name="siteNo" type="string" required="yes" default="100">
    <cfargument name="deptNo" type="numeric" required="yes" default="0">
    <cfargument name="altDeptNo" type="numeric" required="yes" default="0">
    <cfargument name="miName" type="string" required="yes" default="">
    <cfargument name="siteName" type="string" required="yes" default="">
    <cfargument name="misrStatus" type="string" required="yes" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="siteName">
    <cfset var rsMerchItemSiteRel = "" >
    <cftry>
    <cfquery name="rsMerchItemSiteRel" datasource="#application.mcmsDSN#">
    SELECT * FROM v_merch_item_site_rel WHERE 0=0
    <cfif ARGUMENTS.ID NEQ 0>
    AND ID = <cfqueryparam value="#ARGUMENTS.ID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.excludeID NEQ 0>
    AND ID NOT IN (<cfqueryparam value="#ARGUMENTS.excludeID#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(miName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(siteName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">)
    </cfif>
    <cfif ARGUMENTS.miID NEQ 0>
    AND miID = <cfqueryparam value="#ARGUMENTS.miID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.siteNo NEQ 100>
    AND siteNo IN (<cfqueryparam value="#ARGUMENTS.siteNo#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    <cfif ARGUMENTS.deptNo NEQ 0>
    AND deptNo = <cfqueryparam value="#ARGUMENTS.deptNo#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.altDeptNo NEQ 0>
    AND altDeptNo = <cfqueryparam value="#ARGUMENTS.altDeptNo#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.miName NEQ "">
    AND UPPER(miName) = <cfqueryparam value="#UCASE(ARGUMENTS.miName)#" cfsqltype="cf_sql_varchar">
    </cfif>
    AND misrStatus IN (<cfqueryparam value="#ARGUMENTS.misrStatus#" list="yes" cfsqltype="cf_sql_integer">)
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsMerchItemSiteRel = StructNew()>
    <cfset rsMerchItemSiteRel.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsMerchItemSiteRel>
    </cffunction>

    <cffunction name="getMerchItemFixtureRel" access="public" returntype="query" hint="Get Merch Item Fixture Rel. data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="ID" type="numeric" required="yes" default="0">
    <cfargument name="excludeID" type="string" required="yes" default="0">
    <cfargument name="miID" type="string" required="yes" default="0">
    <cfargument name="mfiID" type="string" required="yes" default="0">
    <cfargument name="miName" type="string" required="yes" default="">
    <cfargument name="mfName" type="string" required="yes" default="">
    <cfargument name="mifrStatus" type="string" required="yes" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="mfName">
    <cfset var rsMerchItemFixtureRel = "" >
    <cftry>
    <cfquery name="rsMerchItemFixtureRel" datasource="#application.mcmsDSN#">
    SELECT * FROM v_merch_item_fixture_rel WHERE 0=0
    <cfif ARGUMENTS.ID NEQ 0>
    AND ID = <cfqueryparam value="#ARGUMENTS.ID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.excludeID NEQ 0>
    AND ID NOT IN (<cfqueryparam value="#ARGUMENTS.excludeID#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(miName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(mfName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">)
    </cfif>
    <cfif ARGUMENTS.miID NEQ 0>
    AND miID IN (<cfqueryparam value="#ARGUMENTS.miID#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    <cfif ARGUMENTS.mfiID NEQ 0>
    AND mfiID IN (<cfqueryparam value="#ARGUMENTS.mfiID#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    <cfif ARGUMENTS.miName NEQ "">
    AND UPPER(miName) = <cfqueryparam value="#UCASE(ARGUMENTS.miName)#" cfsqltype="cf_sql_varchar">
    </cfif>
    <cfif ARGUMENTS.mfName NEQ "">
    AND UPPER(mfName) = <cfqueryparam value="#UCASE(ARGUMENTS.mfName)#" cfsqltype="cf_sql_varchar">
    </cfif>
    AND mifrStatus IN (<cfqueryparam value="#ARGUMENTS.mifrStatus#" list="yes" cfsqltype="cf_sql_integer">)
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsMerchItemFixtureRel = StructNew()>
    <cfset rsMerchItemFixtureRel.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsMerchItemFixtureRel>
    </cffunction>
    
    <cffunction name="getMerchItemImageRel" access="public" returntype="query" hint="Get Merch Item Image Rel. data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="ID" type="numeric" required="yes" default="0">
    <cfargument name="excludeID" type="string" required="yes" default="0">
    <cfargument name="miID" type="numeric" required="yes" default="0">
    <cfargument name="imgID" type="numeric" required="yes" default="0">
    <cfargument name="miName" type="string" required="yes" default="">
    <cfargument name="imgName" type="string" required="yes" default="">
    <cfargument name="miirStatus" type="string" required="yes" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="miirSort">
    <cfset var rsMerchItemImageRel = "" >
    <cftry>
    <cfquery name="rsMerchItemImageRel" datasource="#application.mcmsDSN#">
    SELECT * FROM v_merch_item_image_rel WHERE 0=0
    <cfif ARGUMENTS.ID NEQ 0>
    AND ID = <cfqueryparam value="#ARGUMENTS.ID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.excludeID NEQ 0>
    AND ID NOT IN (<cfqueryparam value="#ARGUMENTS.excludeID#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(miName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(imgName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">)
    </cfif>
    <cfif ARGUMENTS.miID NEQ 0>
    AND miID = <cfqueryparam value="#ARGUMENTS.miID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.imgID NEQ 0>
    AND imgID = <cfqueryparam value="#ARGUMENTS.imgID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.miName NEQ "">
    AND UPPER(miName) = <cfqueryparam value="#UCASE(ARGUMENTS.miName)#" cfsqltype="cf_sql_varchar">
    </cfif>
    <cfif ARGUMENTS.imgName NEQ "">
    AND UPPER(imgName) = <cfqueryparam value="#UCASE(ARGUMENTS.imgName)#" cfsqltype="cf_sql_varchar">
    </cfif>
    AND miirStatus IN (<cfqueryparam value="#ARGUMENTS.miirStatus#" list="yes" cfsqltype="cf_sql_integer">)
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsMerchItemImageRel = StructNew()>
    <cfset rsMerchItemImageRel.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsMerchItemImageRel>
    </cffunction>
    
    <cffunction name="getMerchItemDocumentRel" access="public" returntype="query" hint="Get Merch Item Document Rel. data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="ID" type="numeric" required="yes" default="0">
    <cfargument name="excludeID" type="string" required="yes" default="0">
    <cfargument name="miID" type="numeric" required="yes" default="0">
    <cfargument name="docID" type="numeric" required="yes" default="0">
    <cfargument name="miName" type="string" required="yes" default="">
    <cfargument name="docName" type="string" required="yes" default="">
    <cfargument name="midrStatus" type="string" required="yes" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="docName">
    <cfset var rsMerchItemDocumentRel = "" >
    <cftry>
    <cfquery name="rsMerchItemDocumentRel" datasource="#application.mcmsDSN#">
    SELECT * FROM v_merch_item_document_rel WHERE 0=0
    <cfif ARGUMENTS.ID NEQ 0>
    AND ID = <cfqueryparam value="#ARGUMENTS.ID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.excludeID NEQ 0>
    AND ID NOT IN (<cfqueryparam value="#ARGUMENTS.excludeID#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(miName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(docName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">)
    </cfif>
    <cfif ARGUMENTS.miID NEQ 0>
    AND miID = <cfqueryparam value="#ARGUMENTS.miID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.docID NEQ 0>
    AND docID = <cfqueryparam value="#ARGUMENTS.docID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.miName NEQ "">
    AND UPPER(miName) = <cfqueryparam value="#UCASE(ARGUMENTS.miName)#" cfsqltype="cf_sql_varchar">
    </cfif>
    <cfif ARGUMENTS.docName NEQ "">
    AND UPPER(docName) = <cfqueryparam value="#UCASE(ARGUMENTS.docName)#" cfsqltype="cf_sql_varchar">
    </cfif>
    AND midrStatus IN (<cfqueryparam value="#ARGUMENTS.midrStatus#" list="yes" cfsqltype="cf_sql_integer">)
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsMerchItemDocumentRel = StructNew()>
    <cfset rsMerchItemDocumentRel.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsMerchItemDocumentRel>
    </cffunction>
    
    <cffunction name="getMerchSection" access="public" returntype="query" hint="Get Merch Section data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="ID" type="numeric" required="yes" default="0">
    <cfargument name="excludeID" type="numeric" required="yes" default="0">
    <cfargument name="msName" type="string" required="yes" default="">
    <cfargument name="msID" type="numeric" required="yes" default="0">
    <cfargument name="deptNo" type="string" required="yes" default="0">
    <cfargument name="altDeptNo" type="string" required="yes" default="0">
    <cfargument name="mstID" type="numeric" required="yes" default="0">
    <cfargument name="msSort" type="string" required="yes" default="0">
    <cfargument name="msStatus" type="string" required="yes" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="msName">
    <cfset var rsMerchSection = "" >
    <cftry>
    <cfquery name="rsMerchSection" datasource="#application.mcmsDSN#">
    SELECT * FROM v_merch_section WHERE 0=0
    <cfif ARGUMENTS.ID NEQ 0>
    AND ID = <cfqueryparam value="#ARGUMENTS.ID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.excludeID NEQ 0>
    AND ID <> <cfqueryparam value="#ARGUMENTS.excludeID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(msName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(msDescription) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(msMeta) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">)
    </cfif>
    <cfif ARGUMENTS.msName NEQ "">
    AND UPPER(msName) = <cfqueryparam value="#UCASE(ARGUMENTS.msName)#" cfsqltype="cf_sql_varchar">
    </cfif>
    <cfif ARGUMENTS.msID NEQ 0>
    AND msID = <cfqueryparam value="#ARGUMENTS.msID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.deptNo NEQ 0>
    AND deptNo IN (<cfqueryparam value="#ARGUMENTS.deptNo#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    <cfif ARGUMENTS.altDeptNo NEQ 0>
    AND altDeptNo IN (<cfqueryparam value="#ARGUMENTS.altDeptNo#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    <cfif ARGUMENTS.mstID NEQ 0>
    AND mstID = <cfqueryparam value="#ARGUMENTS.mstID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.msSort NEQ 0>
    AND msSort = <cfqueryparam value="#ARGUMENTS.msSort#" cfsqltype="cf_sql_integer">
    </cfif>
    AND msStatus IN (<cfqueryparam value="#ARGUMENTS.msStatus#" list="yes" cfsqltype="cf_sql_integer">)
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsMerchSection = StructNew()>
    <cfset rsMerchSection.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsMerchSection>
    </cffunction>
    
    <cffunction name="getMerchFixture" access="public" returntype="query" hint="Get Merch Fixture data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="ID" type="numeric" required="yes" default="0">
    <cfargument name="excludeID" type="numeric" required="yes" default="0">
    <cfargument name="mfName" type="string" required="yes" default="">
    <cfargument name="mfID" type="numeric" required="yes" default="0">
    <cfargument name="msID" type="string" required="yes" default="0">
    <cfargument name="deptNo" type="string" required="yes" default="0">
    <cfargument name="mfSort" type="string" required="yes" default="0">
    <cfargument name="mfStatus" type="string" required="yes" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="mfName">
    <cfset var rsMerchFixture = "" >
    <cftry>
    <cfquery name="rsMerchFixture" datasource="#application.mcmsDSN#">
    SELECT * FROM v_merch_fixture WHERE 0=0
    <cfif ARGUMENTS.ID NEQ 0>
    AND ID = <cfqueryparam value="#ARGUMENTS.ID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.excludeID NEQ 0>
    AND ID <> <cfqueryparam value="#ARGUMENTS.excludeID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(mfName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(mfDescription) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(mfMeta) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">)
    </cfif>
    <cfif ARGUMENTS.mfName NEQ "">
    AND UPPER(mfName) = <cfqueryparam value="#UCASE(ARGUMENTS.mfName)#" cfsqltype="cf_sql_varchar">
    </cfif>
    <cfif ARGUMENTS.mfID NEQ 0>
    AND mfID = <cfqueryparam value="#ARGUMENTS.mfID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.msID NEQ 0>
    AND msID IN (<cfqueryparam value="#ARGUMENTS.msID#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    <cfif ARGUMENTS.deptNo NEQ 0>
    AND deptNo IN (<cfqueryparam value="#ARGUMENTS.deptNo#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    <cfif ARGUMENTS.mfSort NEQ 0>
    AND mfSort = <cfqueryparam value="#ARGUMENTS.mfSort#" cfsqltype="cf_sql_integer">
    </cfif>
    AND mfStatus IN (<cfqueryparam value="#ARGUMENTS.mfStatus#" list="yes" cfsqltype="cf_sql_integer">)
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsMerchFixture = StructNew()>
    <cfset rsMerchFixture.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsMerchFixture>
    </cffunction>
    
    <cffunction name="getMerchFixtureSectionRel" access="public" returntype="query" hint="Get Merch Fixture Section Rel. data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="ID" type="numeric" required="yes" default="0">
    <cfargument name="excludeID" type="string" required="yes" default="0">
    <cfargument name="mfName" type="string" required="yes" default="">
    <cfargument name="msName" type="string" required="yes" default="">
    <cfargument name="mfID" type="string" required="yes" default="0">
    <cfargument name="msID" type="string" required="yes" default="0">
    <cfargument name="mfiID" type="string" required="yes" default="0">
    <cfargument name="msiID" type="string" required="yes" default="0">
    <cfargument name="deptNo" type="string" required="yes" default="0">
    <cfargument name="altDeptNo" type="string" required="yes" default="0">
    <cfargument name="mfsrStatus" type="string" required="yes" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="msID">
    <cfset var rsMerchFixtureSectionRel = "" >
    <cftry>
    <cfquery name="rsMerchFixtureSectionRel" datasource="#application.mcmsDSN#">
    SELECT * FROM v_merch_fixture_section_rel WHERE 0=0
    <cfif ARGUMENTS.ID NEQ 0>
    AND ID = <cfqueryparam value="#ARGUMENTS.ID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.excludeID NEQ 0>
    AND ID NOT IN (<cfqueryparam value="#ARGUMENTS.excludeID#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(mfName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(mfDescription) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(mfMeta) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">)
    </cfif>
    <cfif ARGUMENTS.mfName NEQ "">
    AND UPPER(mfName) = <cfqueryparam value="#UCASE(ARGUMENTS.mfName)#" cfsqltype="cf_sql_varchar">
    </cfif>
    <cfif ARGUMENTS.mfID NEQ 0>
    AND mfID IN (<cfqueryparam value="#ARGUMENTS.mfID#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    <cfif ARGUMENTS.msID NEQ 0>
    AND msID IN (<cfqueryparam value="#ARGUMENTS.msID#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    <cfif ARGUMENTS.mfiID NEQ 0>
    AND mfiID IN (<cfqueryparam value="#ARGUMENTS.mfiID#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    <cfif ARGUMENTS.msiID NEQ 0>
    AND msiID IN (<cfqueryparam value="#ARGUMENTS.msiID#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    <cfif ARGUMENTS.deptNo NEQ 0>
    AND deptNo IN (<cfqueryparam value="#ARGUMENTS.deptNo#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    <cfif ARGUMENTS.altDeptNo NEQ 0>
    AND altDeptNo IN (<cfqueryparam value="#ARGUMENTS.altDeptNo#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    AND mfsrStatus IN (<cfqueryparam value="#ARGUMENTS.mfsrStatus#" list="yes" cfsqltype="cf_sql_integer">)
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsMerchFixtureSectionRel = StructNew()>
    <cfset rsMerchFixtureSectionRel.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsMerchFixtureSectionRel>
    </cffunction>
    
    <cffunction name="getMerchMap" access="public" returntype="query" hint="Get Merch Map data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="ID" type="numeric" required="yes" default="0">
    <cfargument name="excludeID" type="numeric" required="yes" default="0">
    <cfargument name="mmName" type="string" required="yes" default="">
    <cfargument name="deptNo" type="string" required="yes" default="0">
    <cfargument name="altDeptNo" type="string" required="yes" default="0">
    <cfargument name="mmSort" type="string" required="yes" default="0">
    <cfargument name="mmStatus" type="string" required="yes" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="mmName">
    <cfset var rsMerchMap = "" >
    <cftry>
    <cfquery name="rsMerchMap" datasource="#application.mcmsDSN#">
    SELECT * FROM v_merch_map WHERE 0=0
    <cfif ARGUMENTS.ID NEQ 0>
    AND ID = <cfqueryparam value="#ARGUMENTS.ID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.excludeID NEQ 0>
    AND ID <> <cfqueryparam value="#ARGUMENTS.excludeID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(mmName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(mmDescription) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">)
    </cfif>
    <cfif ARGUMENTS.mmName NEQ "">
    AND UPPER(mmName) = <cfqueryparam value="#UCASE(ARGUMENTS.mmName)#" cfsqltype="cf_sql_varchar">
    </cfif>
    <cfif ARGUMENTS.deptNo NEQ 0>
    AND deptNo IN (<cfqueryparam value="#ARGUMENTS.deptNo#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    <cfif ARGUMENTS.altDeptNo NEQ 0>
    AND altdDeptNo IN (<cfqueryparam value="#ARGUMENTS.altDeptNo#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    <cfif ARGUMENTS.mmSort NEQ 0>
    AND mmSort = <cfqueryparam value="#ARGUMENTS.mmSort#" cfsqltype="cf_sql_integer">
    </cfif>
    AND mmStatus IN (<cfqueryparam value="#ARGUMENTS.mmStatus#" list="yes" cfsqltype="cf_sql_integer">)
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsMerchMap = StructNew()>
    <cfset rsMerchMap.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsMerchMap>
    </cffunction>
    
    <cffunction name="getMerchMapSiteRel" access="public" returntype="query" hint="Get Merch Map Site Rel. data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="ID" type="numeric" required="yes" default="0">
    <cfargument name="excludeID" type="numeric" required="yes" default="0">
    <cfargument name="mmID" type="numeric" required="yes" default="0">
    <cfargument name="siteNo" type="string" required="yes" default="100">
    <cfargument name="deptNo" type="string" required="yes" default="0">
    <cfargument name="mmName" type="string" required="yes" default="">
    <cfargument name="siteName" type="string" required="yes" default="">
    <cfargument name="mmsrStatus" type="string" required="yes" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="mmName">
    <cfset var rsMerchMapSiteRel = "" >
    <cftry>
    <cfquery name="rsMerchMapSiteRel" datasource="#application.mcmsDSN#">
    SELECT * FROM v_merch_map_site_rel WHERE 0=0
    <cfif ARGUMENTS.ID NEQ 0>
    AND ID = <cfqueryparam value="#ARGUMENTS.ID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.excludeID NEQ 0>
    AND ID <> <cfqueryparam value="#ARGUMENTS.excludeID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(mmName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(siteName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">)
    </cfif>
    <cfif ARGUMENTS.mmID NEQ 0>
    AND mmID = <cfqueryparam value="#ARGUMENTS.mmID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.siteNo NEQ 100>
    AND siteNo IN (<cfqueryparam value="#ARGUMENTS.siteNo#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    <cfif ARGUMENTS.deptNo NEQ 0>
    AND deptNo IN (<cfqueryparam value="#ARGUMENTS.deptNo#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    <cfif ARGUMENTS.mmName NEQ "">
    AND UPPER(mmName) = <cfqueryparam value="#UCASE(ARGUMENTS.mmName)#" cfsqltype="cf_sql_varchar">
    </cfif>
    <cfif ARGUMENTS.siteName NEQ "">
    AND UPPER(siteName) = <cfqueryparam value="#UCASE(ARGUMENTS.siteName)#" cfsqltype="cf_sql_varchar">
    </cfif>
    AND mmsrStatus IN (<cfqueryparam value="#ARGUMENTS.mmsrStatus#" list="yes" cfsqltype="cf_sql_integer">)
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsMerchMapSiteRel = StructNew()>
    <cfset rsMerchMapSiteRel.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsMerchMapSiteRel>
    </cffunction>
    
    <cffunction name="getMerchSectionType" access="public" returntype="query" hint="Get Merch Section Type data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="ID" type="numeric" required="yes" default="0">
    <cfargument name="excludeID" type="numeric" required="yes" default="0">
    <cfargument name="mstName" type="string" required="yes" default="">
    <cfargument name="deptNo" type="string" required="yes" default="0">
    <cfargument name="mstStatus" type="string" required="yes" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="mstName">
    <cfset var rsMerchSectionType = "" >
    <cftry>
    <cfquery name="rsMerchSectionType" datasource="#application.mcmsDSN#">
    SELECT * FROM v_merch_section_type WHERE 0=0
    <cfif ARGUMENTS.ID NEQ 0>
    AND ID = <cfqueryparam value="#ARGUMENTS.ID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.excludeID NEQ 0>
    AND ID <> <cfqueryparam value="#ARGUMENTS.excludeID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND UPPER(mstName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">
    </cfif>
    <cfif ARGUMENTS.mstName NEQ "">
    AND UPPER(mstName) = <cfqueryparam value="#UCASE(ARGUMENTS.mstName)#" cfsqltype="cf_sql_varchar">
    </cfif>
    <cfif ARGUMENTS.deptNo NEQ 0>
    AND deptNo IN (<cfqueryparam value="#ARGUMENTS.deptNo#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    AND mstStatus IN (<cfqueryparam value="#ARGUMENTS.mstStatus#" list="yes" cfsqltype="cf_sql_integer">)
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsMerchSectionType = StructNew()>
    <cfset rsMerchSectionType.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsMerchSectionType>
    </cffunction>
    
    <cffunction name="getMerchItemReport" access="public" returntype="query" hint="Get Merch Item Report data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="deptNo" type="string" required="yes" default="0">
    <cfargument name="orderBy" type="string" required="yes" default="miName">
    <cfset var rsMerchItemReport = "" >
    <cftry>
    <cfquery name="rsMerchItemReport" datasource="#application.mcmsDSN#">
    SELECT miName AS Name, miDescription AS Description, deptNo, altDeptNo, deptName AS Department, altDeptName AS Alt_Department, TO_CHAR(miDate, 'MM/DD/YYYY') AS Date_Created, sortName AS Sort, sName AS Status FROM v_merch_item WHERE 0=0
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(miName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(miDescription) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">)
    </cfif>
    <cfif ARGUMENTS.deptNo NEQ 0>
    AND deptNo IN (<cfqueryparam value="#ARGUMENTS.deptNo#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsMerchItemReport = StructNew()>
    <cfset rsMerchItemReport.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsMerchItemReport>
    </cffunction>
    
    <cffunction name="getMerchSectionReport" access="public" returntype="query" hint="Get Merch Section Report data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="deptNo" type="string" required="yes" default="0">
    <cfargument name="orderBy" type="string" required="yes" default="msName">
    <cfset var rsMerchSectionReport = "" >
    <cftry>
    <cfquery name="rsMerchSectionReport" datasource="#application.mcmsDSN#">
    SELECT msID, msName AS Section, msDescription AS Description, deptNo, altDeptNo, deptName AS Department, altDeptName AS Alt_Department, mstName AS Type, sortName AS Sort, sName AS Status FROM v_merch_section WHERE 0=0
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(msName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(msDescription) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">)
    </cfif>
    <cfif ARGUMENTS.deptNo NEQ 0>
    AND deptNo IN (<cfqueryparam value="#ARGUMENTS.deptNo#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsMerchSectionReport = StructNew()>
    <cfset rsMerchSectionReport.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsMerchSectionReport>
    </cffunction>
    
    <cffunction name="getMerchFixtureReport" access="public" returntype="query" hint="Get Merch Fixture Report data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="deptNo" type="string" required="yes" default="0">
    <cfargument name="orderBy" type="string" required="yes" default="mfName">
    <cfset var rsMerchFixtureReport = "" >
    <cftry>
    <cfquery name="rsMerchFixtureReport" datasource="#application.mcmsDSN#">
    SELECT mfID, mfName AS Fixture, mfDescription AS Description, deptNo, altDeptNo, deptName AS Department, altDeptName AS Alt_Department, sortName AS Sort, sName AS Status FROM v_merch_fixture WHERE 0=0
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(mfName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(mfDescription) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">)
    </cfif>
    <cfif ARGUMENTS.deptNo NEQ 0>
    AND deptNo IN (<cfqueryparam value="#ARGUMENTS.deptNo#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsMerchFixtureReport = StructNew()>
    <cfset rsMerchFixtureReport.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsMerchFixtureReport>
    </cffunction>
    
    <cffunction name="getMerchMapReport" access="public" returntype="query" hint="Get Merch Region Map Report data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="deptNo" type="string" required="yes" default="0">
    <cfargument name="orderBy" type="string" required="yes" default="mmName">
    <cfset var rsMerchMapReport = "" >
    <cftry>
    <cfquery name="rsMerchMapReport" datasource="#application.mcmsDSN#">
    SELECT mmName AS Name, mmDescription AS Description, mmFile AS Map_File, imgName AS Map_Image, deptNo, deptName AS Department, sortName AS Sort, sName AS Status FROM v_merch_map WHERE 0=0
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(mmName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(mmDescription) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">)
    </cfif>
    <cfif ARGUMENTS.deptNo NEQ 0>
    AND deptNo IN (<cfqueryparam value="#ARGUMENTS.deptNo#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsMerchMapReport = StructNew()>
    <cfset rsMerchMapReport.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsMerchMapReport>
    </cffunction>
    
    <cffunction name="getMerchSectionTypeReport" access="public" returntype="query" hint="Get Merch Section Type Report data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="deptNo" type="string" required="yes" default="0">
    <cfargument name="orderBy" type="string" required="yes" default="mstName">
    <cfset var rsMerchSectionTypeReport = "" >
    <cftry>
    <cfquery name="rsMerchSectionTypeReport" datasource="#application.mcmsDSN#">
    SELECT mstName AS Name, deptNo, deptname AS Department, sortName AS Sort, sName as Status FROM v_merch_section_type WHERE 0=0
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND UPPER(mstName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">
    </cfif>
    <cfif ARGUMENTS.deptNo NEQ 0>
    AND deptNo IN (<cfqueryparam value="#ARGUMENTS.deptNo#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsMerchSectionTypeReport = StructNew()>
    <cfset rsMerchSectionTypeReport.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsMerchSectionTypeReport>
    </cffunction>
    
    <cffunction name="insertMerchItem" access="public" returntype="struct">
    <cfargument name="miName" type="string" required="yes">
    <cfargument name="miDescription" type="string" required="yes">
    <cfargument name="miMeta" type="string" required="yes">
    <cfargument name="deptNo" type="numeric" required="yes">
    <cfargument name="altDeptNo" type="numeric" required="yes">
    <cfargument name="miSort" type="numeric" required="yes">
    <cfargument name="miStatus" type="numeric" required="yes">
    <!---Relationship arguments.--->
    <cfargument name="siteNo" type="string" required="yes">
    <cfargument name="mfiID" type="string" required="yes">
    <cfset result.message = "You have successfully inserted the record. You can now attach documents and images to this item.">
    <cftry>
    <!---Check for profanity in the text.--->
    <cfinvoke 
    component="MCMS.component.utility.Regex"
    method="regexProfanity"
    returnvariable="regexProfanityRet">
    <cfinvokeargument name="profanityString" value="#ARGUMENTS.miDescription#"/>
    </cfinvoke>
    <!---Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.app.merchandising.Merchandising"
    method="getMerchItem"
    returnvariable="getCheckMerchItemRet">
    <cfinvokeargument name="miName" value="#ARGUMENTS.miName#"/>
    <cfinvokeargument name="miStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckMerchItemRet.recordcount NEQ 0>
    <cfset result.message = "The name #ARGUMENTS.miName# already exists, please enter a new name.">
    <cfelseif regexProfanityRet CONTAINS '$%&*!'>
    <cfset result.message = "Some text contained profanity, please remove any profanity from your text.">
    <!---Check length restriction.--->
    <cfelseif LEN(ARGUMENTS.miDescription) GT 1024>
    <cfset result.message = "The description is longer than 1024 characters, please enter a new description under 1024 characters.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    INSERT INTO tbl_merch_item (miName,miDescription,miMeta,deptNo,altDeptNo,DCL,userID,miSort,miStatus) VALUES
    (
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.miName#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.miDescription#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.miMeta#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.deptNo#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.altDeptNo#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.DCL#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#session.userID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.miSort#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.miStatus#">
    )
    </cfquery>
    </cftransaction>
    <!---Get ID and return to result struct.--->
    <cfinvoke 
    component="MCMS.component.cms.Cms"
    method="getMaxValueSQL"
    returnvariable="miID">
    <cfinvokeargument name="tableName" value="tbl_merch_item"/>
    </cfinvoke>
    <cfset this.miID = miID>
    <!---Create site relationships.--->
    <!---First clean up "All Sites" 100.--->
    <cfif ListContains(ARGUMENTS.siteNo, 100)>
    <cfset ARGUMENTS.siteNo = 100>
    </cfif>
    <cfloop index="siteNo" list="#ARGUMENTS.siteNo#">
    <cfinvoke 
    component="MCMS.component.app.merchandising.Merchandising"
    method="insertMerchItemSiteRel"
    returnvariable="insertMerchItemSiteRelRet">
    <cfinvokeargument name="miID" value="#this.miID#"/>
    <cfinvokeargument name="siteNo" value="#siteNo#"/>
    <cfinvokeargument name="misrStatus" value="1"/>
    </cfinvoke>
    </cfloop>
    <!---Create fixture relationships.--->
    <cfloop index="mfiID" list="#ARGUMENTS.mfiID#">
    <cfinvoke 
    component="MCMS.component.app.merchandising.Merchandising"
    method="insertMerchItemFixtureRel"
    returnvariable="insertMerchItemFixtureRelRet">
    <cfinvokeargument name="miID" value="#this.miID#"/>
    <cfinvokeargument name="mfiID" value="#mfiID#"/>
    <cfinvokeargument name="mifrStatus" value="1"/>
    </cfinvoke>
    </cfloop>
    <!---Forward to update form.--->
    <cfset ajaxOnLoad("function() {ColdFusion.Layout.selectTab('layoutIndex','Item'); ColdFusion.navigate('/#application.mcmsAppAdminPath#/merchandising/view/inc_merch_item.cfm?appID=#url.appID#&mcmsPageID=&mcmsID=update&ID=#this.miID#&taskShowqueryString=', 'Item');}")>
    </cfif>
    <cfcatch type="any">
    <cfset result.message = "There was an error inserting the record.">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="insertMerchItemDocumentRel" access="public" returntype="struct">
    <cfargument name="miID" type="numeric" required="yes">
    <cfargument name="docID" type="numeric" required="yes">
    <cfargument name="midrStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully inserted the record.">
    <cftry>
    <!---Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.app.merchandising.Merchandising"
    method="getMerchItemDocumentRel"
    returnvariable="getCheckMerchItemDocumentRelRet">
    <cfinvokeargument name="miID" value="#ARGUMENTS.miID#"/>
    <cfinvokeargument name="docID" value="#ARGUMENTS.docID#"/>
    <cfinvokeargument name="midrStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckMerchItemDocumentRelRet.recordcount NEQ 0>
    <cfset result.message = "The document #getCheckMerchItemDocumentRelRet.docName# already exists for this item, please choose a new document.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    INSERT INTO tbl_merch_item_document_rel (miID,docID,midrStatus) VALUES
    (
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.miID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.docID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.midrStatus#">
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
    
    <cffunction name="insertMerchItemImageRel" access="public" returntype="struct">
    <cfargument name="miID" type="numeric" required="yes">
    <cfargument name="imgID" type="numeric" required="yes">
    <cfargument name="miirSort" type="numeric" required="yes">
    <cfargument name="miirStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully inserted the record.">
    <cftry>
    <!---Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.app.merchandising.Merchandising"
    method="getMerchItemImageRel"
    returnvariable="getCheckMerchItemImageRelRet">
    <cfinvokeargument name="miID" value="#ARGUMENTS.miID#"/>
    <cfinvokeargument name="imgID" value="#ARGUMENTS.imgID#"/>
    <cfinvokeargument name="miirStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckMerchItemImageRelRet.recordcount NEQ 0>
    <cfset result.message = "The image #getCheckMerchItemImageRelRet.imgName# already exists for this item, please choose a new image.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    INSERT INTO tbl_merch_item_image_rel (miID,imgID,miirSort,miirStatus) VALUES
    (
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.miID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.imgID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.miirSort#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.miirStatus#">
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
    
    <cffunction name="insertMerchSection" access="public" returntype="struct">
    <cfargument name="msID" type="numeric" required="yes">
    <cfargument name="msName" type="string" required="yes">
    <cfargument name="msDescription" type="string" required="yes">
    <cfargument name="msMeta" type="string" required="yes">
    <cfargument name="deptNo" type="numeric" required="yes">
    <cfargument name="altDeptNo" type="numeric" required="yes">
    <cfargument name="mstID" type="numeric" required="yes">
    <cfargument name="msSort" type="numeric" required="yes">
    <cfargument name="msStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully inserted the record.">
    <cftry>
    <!---Check for profanity in the text.--->
    <cfinvoke 
    component="MCMS.component.utility.Regex"
    method="regexProfanity"
    returnvariable="regexProfanityRet">
    <cfinvokeargument name="profanityString" value="#ARGUMENTS.msDescription#"/>
    </cfinvoke>
    <!---Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.app.merchandising.Merchandising"
    method="getMerchSection"
    returnvariable="getCheckMerchSectionRet">
    <cfinvokeargument name="msID" value="#ARGUMENTS.msID#"/>
    <cfinvokeargument name="msName" value="#ARGUMENTS.msName#"/>
    <cfinvokeargument name="msStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckMerchSectionRet.recordcount NEQ 0>
    <cfset result.message = "The name #ARGUMENTS.msName# already exists for Section #ARGUMENTS.msID#, please enter a new unique name.">
    <cfelseif regexProfanityRet CONTAINS '$%&*!'>
    <cfset result.message = "Some text contained profanity, please remove any profanity from your text.">
    <!---Check length restriction.--->
    <cfelseif LEN(ARGUMENTS.msDescription) GT 1024>
    <cfset result.message = "The description is longer than 1024 characters, please enter a new description under 1024 characters.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    INSERT INTO tbl_merch_section (msID,msName,msDescription,msMeta,deptNo,altDeptNo,mstID,userID,msSort,msStatus) VALUES
    (
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.msID#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.msName#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.msDescription#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.msMeta#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.deptNo#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.altDeptNo#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.mstID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#session.userID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.msSort#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.msStatus#">
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
    
    <cffunction name="insertMerchFixture" access="public" returntype="struct">
    <cfargument name="mfID" type="numeric" required="yes">
    <cfargument name="mfName" type="string" required="yes">
    <cfargument name="mfDescription" type="string" required="yes">
    <cfargument name="mfMeta" type="string" required="yes">
    <cfargument name="deptNo" type="numeric" required="yes">
    <cfargument name="altDeptNo" type="numeric" required="yes">
    <cfargument name="mfSort" type="numeric" required="yes">
    <cfargument name="mfStatus" type="numeric" required="yes">
    <!---Relationship arguments.--->
    <cfargument name="msiID" type="string" required="yes">
    <cfset result.message = "You have successfully inserted the record.">
    <cftry>
    <!---Check for profanity in the text.--->
    <cfinvoke 
    component="MCMS.component.utility.Regex"
    method="regexProfanity"
    returnvariable="regexProfanityRet">
    <cfinvokeargument name="profanityString" value="#ARGUMENTS.mfDescription#"/>
    </cfinvoke>
    <!---Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.app.merchandising.Merchandising"
    method="getMerchFixtureSectionRel"
    returnvariable="getCheckMerchFixtureSectionRelRet">
    <cfinvokeargument name="mfID" value="#ARGUMENTS.mfID#"/>
    <cfinvokeargument name="msiID" value="#ARGUMENTS.msiID#"/>
    <cfinvokeargument name="mfStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckMerchFixtureSectionRelRet.recordcount NEQ 0>
    <cfset result.message = "The fixture #ARGUMENTS.mfID# already exists for these section(s), please enter a new fixture ID/Section(s).">
    <cfelseif regexProfanityRet CONTAINS '$%&*!'>
    <cfset result.message = "Some text contained profanity, please remove any profanity from your text.">
    <!---Check length restriction.--->
    <cfelseif LEN(ARGUMENTS.mfDescription) GT 1024>
    <cfset result.message = "The description is longer than 1024 characters, please enter a new description under 1024 characters.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    INSERT INTO tbl_merch_fixture (mfID,mfName,mfDescription,mfMeta,deptNo,altDeptNo,userID,mfSort,mfStatus) VALUES
    (
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.mfID#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.mfName#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.mfDescription#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.mfMeta#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.deptNo#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.altDeptNo#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#session.userID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.mfSort#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.mfStatus#">
    )
    </cfquery>
    </cftransaction>
    <!---Get the mfiID just added.--->
    <cfinvoke 
    component="MCMS.component.cms.Cms"
    method="getMaxValueSQL"
    returnvariable="mfiID">
    <cfinvokeargument name="tableName" value="tbl_merch_fixture"/>
    </cfinvoke>
    <cfset this.mfiID = mfiID>
    <!---Create fixture relationships.--->
    <cfloop index="msiID" list="#ARGUMENTS.msiID#">
    <cfinvoke 
    component="MCMS.component.app.merchandising.Merchandising"
    method="insertMerchFixtureSectionRel"
    returnvariable="insertMerchFixtureSectionRelRet">
    <cfinvokeargument name="mfiID" value="#this.mfiID#"/>
    <cfinvokeargument name="msiID" value="#msiID#"/>
    <cfinvokeargument name="mfsrStatus" value="1"/>
    </cfinvoke>
    </cfloop>
    </cfif>
    <cfcatch type="any">
    <cfset result.message = "There was an error inserting the record.">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="insertMerchMap" access="public" returntype="struct">
    <cfargument name="mmName" type="string" required="yes">
    <cfargument name="mmDescription" type="string" required="yes">
    <cfargument name="mmFile" type="string" required="yes" default="">
    <cfargument name="deptNo" type="numeric" required="yes">
    <cfargument name="altDeptNo" type="numeric" required="yes">
    <cfargument name="mmSort" type="numeric" required="yes">
    <cfargument name="mmStatus" type="numeric" required="yes">
    <!---Relationship arguments.--->
    <cfargument name="siteNo" type="string" required="yes">
    <cfset result.message = "You have successfully inserted the record. You can now attach an image to this map.">
    <cftry>
    <!---Check for profanity in the text.--->
    <cfinvoke 
    component="MCMS.component.utility.Regex"
    method="regexProfanity"
    returnvariable="regexProfanityRet">
    <cfinvokeargument name="profanityString" value="#ARGUMENTS.mmDescription#"/>
    </cfinvoke>
    <!---Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.app.merchandising.Merchandising"
    method="getMerchMap"
    returnvariable="getCheckMerchMapRet">
    <cfinvokeargument name="mmName" value="#ARGUMENTS.mmName#"/>
    <cfinvokeargument name="deptNo" value="#ARGUMENTS.deptNo#"/>
    <cfinvokeargument name="altDeptNo" value="#ARGUMENTS.altDeptNo#"/>
    <cfinvokeargument name="mmStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckMerchMapRet.recordcount NEQ 0>
    <cfset result.message = "The name #ARGUMENTS.mmName# already exists, please enter a new name.">
    <cfelseif regexProfanityRet CONTAINS '$%&*!'>
    <cfset result.message = "Some text contained profanity, please remove any profanity from your text.">
    <!---Check length restriction.--->
    <cfelseif LEN(ARGUMENTS.mmDescription) GT 1024>
    <cfset result.message = "The description is longer than 1024 characters, please enter a new description under 1024 characters.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    INSERT INTO tbl_merch_map (mmName,mmDescription,mmFile,deptNo,altDeptNo,userID,mmSort,mmStatus) VALUES
    (
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.mmName#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.mmDescription#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.mmFile#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.deptNo#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.altDeptNo#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#session.userID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.mmSort#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.mmStatus#">
    )
    </cfquery>
    </cftransaction>
    <!---Get ID and return to result struct.--->
    <cfinvoke 
    component="MCMS.component.cms.Cms"
    method="getMaxValueSQL"
    returnvariable="mmID">
    <cfinvokeargument name="tableName" value="tbl_merch_map"/>
    </cfinvoke>
    <cfset this.mmID = mmID>
    <!---Create site relationships.--->
    <!---First clean up "All Sites" 100.--->
    <cfif ListContains(ARGUMENTS.siteNo, 100)>
    <cfset ARGUMENTS.siteNo = 100>
    </cfif>
    <cfloop index="siteNo" list="#ARGUMENTS.siteNo#">
    <cfinvoke 
    component="MCMS.component.app.merchandising.Merchandising"
    method="insertMerchMapSiteRel"
    returnvariable="insertMerchMapSiteRelRet">
    <cfinvokeargument name="mmID" value="#this.mmID#"/>
    <cfinvokeargument name="siteNo" value="#siteNo#"/>
    <cfinvokeargument name="mmsrStatus" value="1"/>
    </cfinvoke>
    </cfloop>
    <!---Forward to update form.--->
    <cfset ajaxOnLoad("function() {ColdFusion.Layout.selectTab('layoutIndex','Map'); ColdFusion.navigate('/#application.mcmsAppAdminPath#/merchandising/view/inc_merch_map.cfm?appID=#url.appID#&mcmsPageID=&mcmsID=update&ID=#this.mmID#&taskShowqueryString=', 'Map');}")>
    </cfif>
    <cfcatch type="any">
    <cfset result.message = "There was an error inserting the record.">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="insertMerchMapSiteRel" access="public" returntype="struct">
    <cfargument name="mmID" type="numeric" required="yes">
    <cfargument name="siteNo" type="numeric" required="yes">
    <cfargument name="mmsrStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully inserted the record.">
    <cftry>
    <!---Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.app.merchandising.Merchandising"
    method="getMerchMapSiteRel"
    returnvariable="getCheckMerchMapSiteRelRet">
    <cfinvokeargument name="mmID" value="#ARGUMENTS.mmID#"/>
    <cfinvokeargument name="siteNo" value="#ARGUMENTS.siteNo#"/>
    <cfinvokeargument name="mmsrStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckMerchMapSiteRelRet.recordcount NEQ 0>
    <cfset result.message = "The site #getCheckMerchMapSiteRelRet.siteName# already exists for this region map, please choose a new site.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    INSERT INTO tbl_merch_map_site_rel (mmID,siteNo,mmsrStatus) VALUES
    (
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.mmID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.siteNo#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.mmsrStatus#">
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
    
    <cffunction name="insertMerchItemFixtureRel" access="public" returntype="struct">
    <cfargument name="miID" type="numeric" required="yes">
    <cfargument name="mfiID" type="numeric" required="yes">
    <cfargument name="mifrStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully inserted the record.">
    <cftry>
    <!---Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.app.merchandising.Merchandising"
    method="getMerchItemFixtureRel"
    returnvariable="getCheckMerchItemFixtureRelRet">
    <cfinvokeargument name="miID" value="#ARGUMENTS.miID#"/>
    <cfinvokeargument name="mfiID" value="#ARGUMENTS.mfiID#"/>
    <cfinvokeargument name="mifrStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckMerchItemFixtureRelRet.recordcount NEQ 0>
    <cfset result.message = "The relationship #getCheckMerchItemFixtureRelRet.mfName# already exists for this section, please choose a new fixture.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    INSERT INTO tbl_merch_item_fixture_rel (miID,mfiID,mifrStatus) VALUES
    (
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.miID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.mfiID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.mifrStatus#">
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
    
    <cffunction name="insertMerchItemSiteRel" access="public" returntype="struct">
    <cfargument name="miID" type="numeric" required="yes">
    <cfargument name="siteNo" type="numeric" required="yes">
    <cfargument name="misrStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully inserted the record.">
    <cftry>
    <!---Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.app.merchandising.Merchandising"
    method="getMerchItemSiteRel"
    returnvariable="getCheckMerchItemSiteRelRet">
    <cfinvokeargument name="miID" value="#ARGUMENTS.miID#"/>
    <cfinvokeargument name="siteNo" value="#ARGUMENTS.siteNo#"/>
    <cfinvokeargument name="misrStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckMerchItemSiteRelRet.recordcount NEQ 0>
    <cfset result.message = "The site #getCheckMerchMapSiteRelRet.siteName# already exists for this item, please choose a new site.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    INSERT INTO tbl_merch_item_site_rel (miID,siteNo,misrStatus) VALUES
    (
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.miID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.siteNo#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.misrStatus#">
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
    
    <cffunction name="insertMerchFixtureSectionRel" access="public" returntype="struct">
    <cfargument name="mfiID" type="numeric" required="yes">
    <cfargument name="msiID" type="numeric" required="yes">
    <cfargument name="mfsrStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully inserted the record.">
    <cftry>
    <!---Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.app.merchandising.Merchandising"
    method="getMerchFixtureSectionRel"
    returnvariable="getCheckMerchFixtureSectionRelRet">
    <cfinvokeargument name="mfiID" value="#ARGUMENTS.mfiID#"/>
    <cfinvokeargument name="msiID" value="#ARGUMENTS.msiID#"/>
    <cfinvokeargument name="mfsrStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckMerchFixtureSectionRelRet.recordcount NEQ 0>
    <cfset result.message = "The relationship #getCheckMerchFixtureSectionRelRet.mfName# already exists for this section, please choose a new section.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    INSERT INTO tbl_merch_fixture_section_rel (mfiID,msiID,mfsrStatus) VALUES
    (
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.mfiID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.msiID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.mfsrStatus#">
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
    
    <cffunction name="insertMerchSectionType" access="public" returntype="struct">
    <cfargument name="mstName" type="string" required="yes">
    <cfargument name="deptNo" type="numeric" required="yes">
    <cfargument name="mstSort" type="numeric" required="yes">
    <cfargument name="mstStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully inserted the record.">
    <cftry>
    <!---Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.app.merchandising.Merchandising"
    method="getMerchSectionType"
    returnvariable="getCheckMerchSectionTypeRet">
    <cfinvokeargument name="mstName" value="#ARGUMENTS.mstName#"/>
    <cfinvokeargument name="mstStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckMerchSectionTypeRet.recordcount NEQ 0>
    <cfset result.message = "The name #ARGUMENTS.mstName# already exists, please enter a new name.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    INSERT INTO tbl_merch_section_type (mstName,deptNo,mstSort,mstStatus) VALUES
    (
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.mstName#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.deptNo#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.mstSort#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.mstStatus#">
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
    
    <cffunction name="updateMerchItem" access="public" returntype="struct">
    <cfargument name="ID" type="numeric" required="yes">
    <cfargument name="uaID" type="numeric" required="yes">
    <cfargument name="miName" type="string" required="yes">
    <cfargument name="miDescription" type="string" required="yes">
    <cfargument name="miMeta" type="string" required="yes">
    <cfargument name="deptNo" type="numeric" required="yes">
    <cfargument name="altDeptNo" type="numeric" required="yes">
    <cfargument name="DCL" type="string" required="yes">
    <cfargument name="miSort" type="numeric" required="yes">
    <cfargument name="miStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully updated the record.">
    <cftry>
    <!---Check for profanity in the text.--->
    <cfinvoke 
    component="MCMS.component.utility.Regex"
    method="regexProfanity"
    returnvariable="regexProfanityRet">
    <cfinvokeargument name="profanityString" value="#ARGUMENTS.miDescription#"/>
    </cfinvoke>
    <!---Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.app.merchandising.Merchandising"
    method="getMerchItem"
    returnvariable="getCheckMerchItemRet">
    <cfinvokeargument name="excludeID" value="#ARGUMENTS.ID#"/>
    <cfinvokeargument name="miName" value="#ARGUMENTS.miName#"/>
    <cfinvokeargument name="miStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckMerchItemRet.recordcount NEQ 0>
    <cfset result.message = "The name #ARGUMENTS.miName# already exists, please enter a new name.">
    <cfelseif regexProfanityRet CONTAINS '$%&*!'>
    <cfset result.message = "Some text contained profanity, please remove any profanity from your text.">
    <!---Check length restriction.--->
    <cfelseif LEN(ARGUMENTS.miDescription) GT 1024>
    <cfset result.message = "The description is longer than 1024 characters, please enter a new description under 1024 characters.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_merch_item SET
    miName = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.miName#">,
    miDescription = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.miDescription#">,
    miMeta = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.miMeta#">,
    deptNo = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.deptNo#">,
    DCL = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.DCL#">,
    altDeptNo = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.altDeptNo#">,
    miSort = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.miSort#">,
	<cfif ARGUMENTS.uaID NEQ 101>
    miDateUpdate = <cfqueryparam cfsqltype="cf_sql_timestamp" value="#Now()#">,
    userID = <cfqueryparam cfsqltype="cf_sql_integer" value="#session.userID#">,
    </cfif>
    miStatus = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.miStatus#">
    WHERE ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ID#">
    </cfquery>
    </cftransaction>
    <!---Delete any existing relationships.--->
    <cfinvoke 
    component="MCMS.component.app.merchandising.Merchandising"
    method="deleteMerchItemFixtureRel"
    returnvariable="deleteMerchItemFixtureRelRet">
    <cfinvokeargument name="miID" value="#ARGUMENTS.ID#"/>
    </cfinvoke>
    <cfinvoke 
    component="MCMS.component.app.merchandising.Merchandising"
    method="deleteMerchItemSiteRel"
    returnvariable="deleteMerchItemSiteRelRet">
    <cfinvokeargument name="miID" value="#ARGUMENTS.ID#"/>
    </cfinvoke>
    <!---Create site and fixture relationships.--->
    <cfloop index="mfiID" list="#ARGUMENTS.mfiID#">
    <cfinvoke 
    component="MCMS.component.app.merchandising.Merchandising"
    method="insertMerchItemFixtureRel"
    returnvariable="insertMerchItemFixtureRelRet">
    <cfinvokeargument name="miID" value="#ARGUMENTS.ID#"/>
    <cfinvokeargument name="mfiID" value="#mfiID#"/>
    <cfinvokeargument name="mifrStatus" value="1"/>
    </cfinvoke>
    </cfloop>
    <cfloop index="siteNo" list="#ARGUMENTS.siteNo#">
    <cfinvoke 
    component="MCMS.component.app.merchandising.Merchandising"
    method="insertMerchItemSiteRel"
    returnvariable="insertMerchItemSiteRelRet">
    <cfinvokeargument name="miID" value="#ARGUMENTS.ID#"/>
    <cfinvokeargument name="siteNo" value="#siteNo#"/>
    <cfinvokeargument name="misrStatus" value="1"/>
    </cfinvoke>
    </cfloop>
    </cfif>
    <cfcatch type="any">
    <cfset result.message = "There was an error updating the record.">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="updateMerchSection" access="public" returntype="struct">
    <cfargument name="ID" type="numeric" required="yes">
    <cfargument name="uaID" type="numeric" required="yes">
    <cfargument name="msID" type="numeric" required="yes">
    <cfargument name="msName" type="string" required="yes">
    <cfargument name="msDescription" type="string" required="yes">
	<cfargument name="msMeta" type="string" required="yes">
    <cfargument name="mstID" type="numeric" required="yes">
    <cfargument name="deptNo" type="numeric" required="yes">
    <cfargument name="altDeptNo" type="numeric" required="yes">
    <cfargument name="msSort" type="numeric" required="yes">
    <cfargument name="msStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully updated the record.">
    <cftry>
    <!---Check for profanity in the text.--->
    <cfinvoke 
    component="MCMS.component.utility.Regex"
    method="regexProfanity"
    returnvariable="regexProfanityRet">
    <cfinvokeargument name="profanityString" value="#ARGUMENTS.msDescription#"/>
    </cfinvoke>
    <!---Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.app.merchandising.Merchandising"
    method="getMerchSection"
    returnvariable="getCheckMerchSectionRet">
    <cfinvokeargument name="excludeID" value="#ARGUMENTS.ID#"/>
    <cfinvokeargument name="msID" value="#ARGUMENTS.msID#"/>
    <cfinvokeargument name="msName" value="#ARGUMENTS.msName#"/>
    <cfinvokeargument name="msStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckMerchSectionRet.recordcount NEQ 0>
    <cfset result.message = "The name #ARGUMENTS.msName# already exists with section #ARGUMENTS.msID#, please enter a new unique name.">
    <cfelseif regexProfanityRet CONTAINS '$%&*!'>
    <cfset result.message = "Some text contained profanity, please remove any profanity from your text.">
    <!---Check length restriction.--->
    <cfelseif LEN(ARGUMENTS.msDescription) GT 1024>
    <cfset result.message = "The description is longer than 1024 characters, please enter a new description under 1024 characters.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_merch_section SET
    msID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.msID#">,
    msName = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.msName#">,
    msDescription = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.msDescription#">,
	msMeta = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.msMeta#">,
    deptNo = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.deptNo#">,
    altDeptNo = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.altDeptNo#">,
    mstID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.mstID#">,
	<cfif ARGUMENTS.uaID NEQ 101>
    msDateUpdate = <cfqueryparam cfsqltype="cf_sql_timestamp" value="#Now()#">,
    userID = <cfqueryparam cfsqltype="cf_sql_integer" value="#session.userID#">,
    </cfif>
    msSort = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.msSort#">,
    msStatus = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.msStatus#">
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
    
    <cffunction name="updateMerchFixture" access="public" returntype="struct">
    <cfargument name="ID" type="numeric" required="yes">
    <cfargument name="uaID" type="numeric" required="yes">
    <cfargument name="mfID" type="numeric" required="yes">
    <cfargument name="mfName" type="string" required="yes">
    <cfargument name="mfDescription" type="string" required="yes">
    <cfargument name="mfMeta" type="string" required="yes">
    <cfargument name="deptNo" type="numeric" required="yes">
    <cfargument name="altDeptNo" type="numeric" required="yes">
    <cfargument name="mfSort" type="numeric" required="yes">
    <cfargument name="mfStatus" type="numeric" required="yes">
    <!---Relationship arguments.--->
    <cfargument name="mfsrID" type="string" required="yes">
    <cfargument name="msiID" type="string" required="yes">
    <cfset result.message = "You have successfully updated the record.">
    <cftry>
    <!---Check for profanity in the text.--->
    <cfinvoke 
    component="MCMS.component.utility.Regex"
    method="regexProfanity"
    returnvariable="regexProfanityRet">
    <cfinvokeargument name="profanityString" value="#ARGUMENTS.mfDescription#"/>
    </cfinvoke>
    <!---Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.app.merchandising.Merchandising"
    method="getMerchFixtureSectionRel"
    returnvariable="getCheckMerchFixtureSectionRelRet">
    <cfinvokeargument name="excludeID" value="#ARGUMENTS.mfsrID#"/>
    <cfinvokeargument name="mfID" value="#ARGUMENTS.mfID#"/>
    <cfinvokeargument name="msiID" value="#ARGUMENTS.msiID#"/>
    <cfinvokeargument name="mfStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckMerchFixtureSectionRelRet.recordcount NEQ 0>
    <cfset result.message = "The fixture #ARGUMENTS.mfID# already exists for these section(s), please enter a new fixture ID/Section(s).">
    <cfelseif regexProfanityRet CONTAINS '$%&*!'>
    <cfset result.message = "Some text contained profanity, please remove any profanity from your text.">
    <!---Check length restriction.--->
    <cfelseif LEN(ARGUMENTS.mfDescription) GT 1024>
    <cfset result.message = "The description is longer than 1024 characters, please enter a new description under 1024 characters.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_merch_fixture SET
    mfID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.mfID#">,
    mfName = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.mfName#">,
    mfDescription = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.mfDescription#">,
    mfMeta = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.mfMeta#">,
    deptNo = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.deptNo#">,
    altDeptNo = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.altDeptNo#">,
    mfSort = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.mfSort#">,
	<cfif ARGUMENTS.uaID NEQ 101>
    mfDateUpdate = <cfqueryparam cfsqltype="cf_sql_timestamp" value="#Now()#">,
    userID = <cfqueryparam cfsqltype="cf_sql_integer" value="#session.userID#">,
    </cfif>
    mfStatus = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.mfStatus#">
    WHERE ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ID#">
    </cfquery>
    </cftransaction>
    <!---Delete any existing relationships.--->
    <cfinvoke 
    component="MCMS.component.app.merchandising.Merchandising"
    method="deleteMerchFixtureSectionRel"
    returnvariable="deleteMerchFixtureSectionRelRet">
    <cfinvokeargument name="mfiID" value="#ARGUMENTS.ID#"/>
    </cfinvoke>
    <!---Create section relationships.--->
    <cfloop index="msiID" list="#ARGUMENTS.msiID#">
    <cfinvoke 
    component="MCMS.component.app.merchandising.Merchandising"
    method="insertMerchFixtureSectionRel"
    returnvariable="insertMerchFixtureSectionRelRet">
    <cfinvokeargument name="mfiID" value="#ARGUMENTS.ID#"/>
    <cfinvokeargument name="msiID" value="#msiID#"/>
    <cfinvokeargument name="mfsrStatus" value="1"/>
    </cfinvoke>
    </cfloop>
    </cfif>
    <cfcatch type="any">
    <cfset result.message = "There was an error updating the record.">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="updateMerchMap" access="public" returntype="struct">
    <cfargument name="ID" type="numeric" required="yes">
    <cfargument name="mmName" type="string" required="yes">
    <cfargument name="mmDescription" type="string" required="yes">
    <cfargument name="mmFile" type="string" required="yes" default="">
    <cfargument name="deptNo" type="numeric" required="yes">
    <cfargument name="altDeptNo" type="numeric" required="yes">
    <cfargument name="mmSort" type="numeric" required="yes">
    <cfargument name="mmStatus" type="numeric" required="yes">
    <!---Relationship arguments.--->
    <cfargument name="siteNo" type="string" required="yes">
    <cfset result.message = "You have successfully updated the record.">
    <cftry>
    <!---Check for profanity in the text.--->
    <cfinvoke 
    component="MCMS.component.utility.Regex"
    method="regexProfanity"
    returnvariable="regexProfanityRet">
    <cfinvokeargument name="profanityString" value="#ARGUMENTS.mmDescription#"/>
    </cfinvoke>
    <!---Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.app.merchandising.Merchandising"
    method="getMerchMap"
    returnvariable="getCheckMerchMapRet">
    <cfinvokeargument name="excludeID" value="#ARGUMENTS.ID#"/>
    <cfinvokeargument name="mmName" value="#ARGUMENTS.mmName#"/>
    <cfinvokeargument name="deptNo" value="#ARGUMENTS.deptNo#"/>
    <cfinvokeargument name="altDeptNo" value="#ARGUMENTS.altDeptNo#"/>
    <cfinvokeargument name="mmStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckMerchMapRet.recordcount NEQ 0>
    <cfset result.message = "The name #ARGUMENTS.mmName# already exists, please enter a new name.">
    <cfelseif regexProfanityRet CONTAINS '$%&*!'>
    <cfset result.message = "Some text contained profanity, please remove any profanity from your text.">
    <!---Check length restriction.--->
    <cfelseif LEN(ARGUMENTS.mmDescription) GT 1024>
    <cfset result.message = "The description is longer than 1024 characters, please enter a new description under 1024 characters.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_merch_map SET
    mmName = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.mmName#">,
    mmDescription = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.mmDescription#">,
    mmFile = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.mmFile#">,
    deptNo = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.deptNo#">,
    altDeptNo = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.altDeptNo#">,
    mmSort = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.mmSort#">,
    mmStatus = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.mmStatus#">
    WHERE ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ID#">
    </cfquery>
    </cftransaction>
    <!---Delete any existing relationships.--->
    <cfinvoke 
    component="MCMS.component.app.merchandising.Merchandising"
    method="deleteMerchMapSiteRel"
    >
    <cfinvokeargument name="mmID" value="#ARGUMENTS.ID#"/>
    </cfinvoke>
    <!---Create site relationships.--->
    <cfloop index="siteNo" list="#ARGUMENTS.siteNo#">
    <cfinvoke 
    component="MCMS.component.app.merchandising.Merchandising"
    method="insertMerchMapSiteRel"
    >
    <cfinvokeargument name="mmID" value="#ARGUMENTS.ID#"/>
    <cfinvokeargument name="siteNo" value="#siteNo#"/>
    <cfinvokeargument name="mmsrStatus" value="1"/>
    </cfinvoke>
    </cfloop>
    </cfif>
    <cfcatch type="any">
    <cfset result.message = "There was an error updating the record.">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="updateMerchMapImage" access="public" returntype="struct">
    <cfargument name="ID" type="numeric" required="yes">
    <cfargument name="imgID" type="numeric" required="yes">
    <cfset result.message = "You have successfully updated the record.">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_merch_map SET
    imgID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.imgID#">
    WHERE ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ID#">
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error updating the record.">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="updateMerchItemImageRel" access="public" returntype="struct">
    <cfargument name="ID" type="numeric" required="yes">
    <cfargument name="miirSort" type="numeric" required="yes">
    <cfset result.message = "You have successfully updated the record.">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_merch_item_image_rel SET
    miirSort = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.miirSort#">
    WHERE ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ID#">
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error updating the record.">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="updateMerchSectionType" access="public" returntype="struct">
    <cfargument name="ID" type="numeric" required="yes">
    <cfargument name="mstName" type="string" required="yes">
    <cfargument name="deptNo" type="numeric" required="yes">
    <cfargument name="mstSort" type="numeric" required="yes">
    <cfargument name="mstStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully updated the record.">
    <cftry>
    <!---Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.app.merchandising.Merchandising"
    method="getMerchSectionType"
    returnvariable="getCheckMerchSectionTypeRet">
    <cfinvokeargument name="excludeID" value="#ARGUMENTS.ID#"/>
    <cfinvokeargument name="mstName" value="#ARGUMENTS.mstName#"/>
    <cfinvokeargument name="mstStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckMerchSectionTypeRet.recordcount NEQ 0>
    <cfset result.message = "The name #ARGUMENTS.mstName# already exists, please enter a new name.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_merch_section_type SET
    mstName = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.mstName#">,
    deptNo = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.deptNo#">,
    mstSort = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.mstSort#">,
    mstStatus = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.mstStatus#">
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
    
    <cffunction name="updateMerchItemList" access="public" returntype="struct">
    <cfargument name="ID" type="numeric" required="yes">
    <cfargument name="miStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully updated the records.">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_merch_item SET
    miStatus = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.miStatus#">
    WHERE ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ID#">
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error updating the records.">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="updateMerchSectionList" access="public" returntype="struct">
    <cfargument name="ID" type="numeric" required="yes">
    <cfargument name="msStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully updated the records.">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_merch_section SET
    msStatus = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.msStatus#">
    WHERE ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ID#">
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error updating the records.">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="updateMerchFixtureList" access="public" returntype="struct">
    <cfargument name="ID" type="numeric" required="yes">
    <cfargument name="mfStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully updated the records.">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_merch_fixture SET
    mfStatus = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.mfStatus#">
    WHERE ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ID#">
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error updating the records.">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="updateMerchMapList" access="public" returntype="struct">
    <cfargument name="ID" type="numeric" required="yes">
    <cfargument name="mmStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully updated the records.">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_merch_map SET
    mmStatus = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.mmStatus#">
    WHERE ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ID#">
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error updating the records.">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="updateMerchSectionTypeList" access="public" returntype="struct">
    <cfargument name="ID" type="numeric" required="yes">
    <cfargument name="mstStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully updated the records.">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_merch_section_type SET
    mstStatus = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.mstStatus#">
    WHERE ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ID#">
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error updating the records.">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="deleteMerchItem" access="public" returntype="struct">
    <cfargument name="ID" type="string" required="yes">
    <cfset result.message = "You have successfully deleted the record(s).">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    DELETE FROM tbl_merch_item
    WHERE ID IN (<cfqueryparam cfsqltype="cf_sql_integer" list="yes" value="#ARGUMENTS.ID#">)
    </cfquery>
    </cftransaction>
    <!---Delete any existing relationships.--->
    <cfinvoke 
    component="MCMS.component.app.merchandising.Merchandising"
    method="deleteMerchItemSiteRel">
    <cfinvokeargument name="miID" value="#ARGUMENTS.ID#"/>
    </cfinvoke>
    <cfinvoke 
    component="MCMS.component.app.merchandising.Merchandising"
    method="deleteMerchItemFixtureRel">
    <cfinvokeargument name="miID" value="#ARGUMENTS.ID#"/>
    </cfinvoke>
    <cfinvoke 
    component="MCMS.component.app.merchandising.Merchandising"
    method="deleteMerchItemImageRel">
    <cfinvokeargument name="miID" value="#ARGUMENTS.ID#"/>
    </cfinvoke>
    <cfinvoke 
    component="MCMS.component.app.merchandising.Merchandising"
    method="deleteMerchItemDocumentRel">
    <cfinvokeargument name="miID" value="#ARGUMENTS.ID#"/>
    </cfinvoke>
    <cfcatch type="any">
    <cfset result.message = "There was an error deleting the record(s).">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="deleteMerchItemDocumentRel" access="public" returntype="struct">
    <cfargument name="ID" type="string" required="yes" default="0">
    <cfargument name="miID" type="string" required="yes" default="0">
    <cfset result.message = "You have successfully deleted the record(s).">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    DELETE FROM tbl_merch_item_document_rel
    WHERE ID IN (<cfqueryparam cfsqltype="cf_sql_integer" list="yes" value="#ARGUMENTS.ID#">)
    OR miID IN (<cfqueryparam cfsqltype="cf_sql_integer" list="yes" value="#ARGUMENTS.miID#">)
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error deleting the record(s).">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="deleteMerchItemImageRel" access="public" returntype="struct">
    <cfargument name="ID" type="string" required="yes" default="0">
    <cfargument name="miID" type="string" required="yes" default="0">
    <cfset result.message = "You have successfully deleted the record(s).">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    DELETE FROM tbl_merch_item_image_rel
    WHERE ID IN (<cfqueryparam cfsqltype="cf_sql_integer" list="yes" value="#ARGUMENTS.ID#">)
    OR miID IN (<cfqueryparam cfsqltype="cf_sql_integer" list="yes" value="#ARGUMENTS.miID#">)
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error deleting the record(s).">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="deleteMerchItemFixtureRel" access="public" returntype="struct">
    <cfargument name="ID" type="string" required="yes" default="0">
    <cfargument name="miID" type="string" required="yes" default="0">
    <cfset result.message = "You have successfully deleted the record(s).">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    DELETE FROM tbl_merch_item_fixture_rel
    WHERE ID IN (<cfqueryparam cfsqltype="cf_sql_integer" list="yes" value="#ARGUMENTS.ID#">)
    OR miID IN (<cfqueryparam cfsqltype="cf_sql_integer" list="yes" value="#ARGUMENTS.miID#">)
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error deleting the record(s).">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="deleteMerchItemSiteRel" access="public" returntype="struct">
    <cfargument name="ID" type="string" required="yes" default="0">
    <cfargument name="miID" type="string" required="yes" default="0">
    <cfset result.message = "You have successfully deleted the record(s).">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    DELETE FROM tbl_merch_item_site_rel
    WHERE ID IN (<cfqueryparam cfsqltype="cf_sql_integer" list="yes" value="#ARGUMENTS.ID#">)
    OR miID IN (<cfqueryparam cfsqltype="cf_sql_integer" list="yes" value="#ARGUMENTS.miID#">)
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error deleting the record(s).">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>  
    
    <cffunction name="deleteMerchSection" access="public" returntype="struct">
    <cfargument name="ID" type="string" required="yes">
    <cfset result.message = "You have successfully deleted the record(s).">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    DELETE FROM tbl_merch_section
    WHERE ID IN (<cfqueryparam cfsqltype="cf_sql_integer" list="yes" value="#ARGUMENTS.ID#">)
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error deleting the record(s).">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="deleteMerchFixture" access="public" returntype="struct">
    <cfargument name="ID" type="string" required="yes">
    <cfset result.message = "You have successfully deleted the record(s).">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    DELETE FROM tbl_merch_fixture
    WHERE ID IN (<cfqueryparam cfsqltype="cf_sql_integer" list="yes" value="#ARGUMENTS.ID#">)
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error deleting the record(s).">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="deleteMerchMap" access="public" returntype="struct">
    <cfargument name="ID" type="string" required="yes">
    <cfset result.message = "You have successfully deleted the record(s).">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    DELETE FROM tbl_merch_map
    WHERE ID IN (<cfqueryparam cfsqltype="cf_sql_integer" list="yes" value="#ARGUMENTS.ID#">)
    </cfquery>
    </cftransaction>
    <!---Delete any existing relationships.--->
    <cfinvoke 
    component="MCMS.component.app.merchandising.Merchandising"
    method="deleteMerchMapSiteRel">
    <cfinvokeargument name="mmID" value="#ARGUMENTS.ID#"/>
    </cfinvoke>
    <cfcatch type="any">
    <cfset result.message = "There was an error deleting the record(s).">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="deleteMerchMapSiteRel" access="public" returntype="struct">
    <cfargument name="ID" type="string" required="yes" default="0">
    <cfargument name="mmID" type="string" required="yes" default="0">
    <cfset result.message = "You have successfully deleted the record(s).">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    DELETE FROM tbl_merch_map_site_rel
    WHERE ID IN (<cfqueryparam cfsqltype="cf_sql_integer" list="yes" value="#ARGUMENTS.ID#">)
    OR mmID IN (<cfqueryparam cfsqltype="cf_sql_integer" list="yes" value="#ARGUMENTS.mmID#">)
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error deleting the record(s).">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="deleteMerchFixtureSectionRel" access="public" returntype="struct">
    <cfargument name="ID" type="string" required="yes" default="0">
    <cfargument name="mfiID" type="string" required="yes" default="0">
    <cfset result.message = "You have successfully deleted the record(s).">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    DELETE FROM tbl_merch_fixture_section_rel
    WHERE ID IN (<cfqueryparam cfsqltype="cf_sql_integer" list="yes" value="#ARGUMENTS.ID#">) OR mfiID IN (<cfqueryparam cfsqltype="cf_sql_integer" list="yes" value="#ARGUMENTS.mfiID#">)
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error deleting the record(s).">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="deleteMerchSectionType" access="public" returntype="struct">
    <cfargument name="ID" type="string" required="yes">
    <cfset result.message = "You have successfully deleted the record(s).">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    DELETE FROM tbl_merch_section_type
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