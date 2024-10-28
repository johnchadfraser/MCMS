<cfcomponent>
    <cffunction name="getAuction" access="public" returntype="query" hint="Get Auction data."> 
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="dateRange" type="string" required="yes" default="false">
    <cfargument name="aDateRel" type="string" required="yes" default="">
    <cfargument name="aDateExp" type="string" required="yes" default="">
    <cfargument name="aDateRelEQ" type="string" required="yes" default="">
    <cfargument name="aDateExpEQ" type="string" required="yes" default="">
    <cfargument name="ID" type="numeric" required="yes" default="0">
    <cfargument name="excludeID" type="numeric" required="yes" default="0">
    <cfargument name="aName" type="string" required="yes" default="">
    <cfargument name="atID" type="numeric" required="yes" default="0">
    <cfargument name="aStatus" type="string" required="yes" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="aDateRel">
    <cfset var rsAuction = "" >
    <cftry>
    <cfquery name="rsAuction" datasource="#application.mcmsDSN#">
    SELECT * FROM v_auction WHERE 0=0
    <cfif ARGUMENTS.ID NEQ 0>
    AND ID = <cfqueryparam value="#ARGUMENTS.ID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.excludeID NEQ 0>
    AND ID <> <cfqueryparam value="#ARGUMENTS.excludeID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(aName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(aDescription) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">)
    </cfif>
    <!---Date Range.--->
    <cfif ARGUMENTS.dateRange EQ "true">
    <cfif ARGUMENTS.aDateRel NEQ "">
    AND aDateRel >= <cfqueryparam value="#ARGUMENTS.aDateRel#" cfsqltype="cf_sql_date">
    </cfif>
    <cfif ARGUMENTS.aDateExp NEQ "">
    AND aDateExp <= <cfqueryparam value="#ARGUMENTS.aDateExp#" cfsqltype="cf_sql_date">
	</cfif>
    <cfelse>
    <cfif ARGUMENTS.aDateRel NEQ "">
    AND aDateRel <= <cfqueryparam value="#ARGUMENTS.aDateRel#" cfsqltype="cf_sql_date">
    </cfif>
    <cfif ARGUMENTS.aDateExp NEQ "">
    AND aDateExp >= <cfqueryparam value="#ARGUMENTS.aDateExp#" cfsqltype="cf_sql_date">
	</cfif>
    </cfif>
    <cfif ARGUMENTS.aDateRelEQ NEQ "">
    AND aDateRel = <cfqueryparam value="#ARGUMENTS.aDateRelEQ#" cfsqltype="cf_sql_date">
    </cfif>
    <cfif ARGUMENTS.aDateExpEQ NEQ "">
    AND aDateExp = <cfqueryparam value="#ARGUMENTS.aDateExpEQ#" cfsqltype="cf_sql_date">
	</cfif>
    <cfif ARGUMENTS.aName NEQ "">
    AND UPPER(aName) = <cfqueryparam value="#UCASE(ARGUMENTS.aName)#" cfsqltype="cf_sql_varchar">
    </cfif>
    <cfif ARGUMENTS.atID NEQ 0>
    AND atID = <cfqueryparam value="#ARGUMENTS.atID#" cfsqltype="cf_sql_integer">
    </cfif>
    AND aStatus IN (<cfqueryparam value="#ARGUMENTS.aStatus#" list="yes" cfsqltype="cf_sql_integer">)
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsAuction = StructNew()>
    <cfset rsAuction.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsAuction>
    </cffunction>
    
    <cffunction name="getAuctionItem" access="public" returntype="query" hint="Get Auction Item data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="ID" type="numeric" required="yes" default="0">
    <cfargument name="excludeID" type="numeric" required="yes" default="0">
    <cfargument name="aID" type="numeric" required="yes" default="0">
    <cfargument name="aiName" type="string" required="yes" default="">
    <cfargument name="aiDateRel" type="string" required="yes" default="">
    <cfargument name="aiDateExp" type="string" required="yes" default="">
    <cfargument name="aiStatus" type="string" required="yes" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="aiName">
    <cfset var rsAuctionItem = "" >
    <cftry>
    <cfquery name="rsAuctionItem" datasource="#application.mcmsDSN#">
    SELECT * FROM v_auction_item WHERE 0=0
    <cfif ARGUMENTS.ID NEQ 0>
    AND ID = <cfqueryparam value="#ARGUMENTS.ID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.excludeID NEQ 0>
    AND ID <> <cfqueryparam value="#ARGUMENTS.excludeID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(aiName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(aiDescription) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">)
    </cfif>
    <cfif ARGUMENTS.aID NEQ 0>
    AND aID = <cfqueryparam value="#ARGUMENTS.aID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.aiDateRel NEQ "">
    AND aiDateRel <= <cfqueryparam value="#ARGUMENTS.aiDateRel#" cfsqltype="cf_sql_date">
    </cfif>
    <cfif ARGUMENTS.aiDateExp NEQ "">
    AND aiDateExp >= <cfqueryparam value="#ARGUMENTS.aiDateExp#" cfsqltype="cf_sql_date">
	</cfif>
    <cfif ARGUMENTS.aiName NEQ "">
    AND UPPER(aiName) = <cfqueryparam value="#UCASE(ARGUMENTS.aiName)#" cfsqltype="cf_sql_varchar">
    </cfif>
    AND aiStatus IN (<cfqueryparam value="#ARGUMENTS.aiStatus#" list="yes" cfsqltype="cf_sql_integer">)
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsAuctionItem = StructNew()>
    <cfset rsAuctionItem.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsAuctionItem>
    </cffunction>
    
    <cffunction name="getAuctionItemAttr" access="public" returntype="query" hint="Get Auction Item Attribute data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="ID" type="numeric" required="yes" default="0">
    <cfargument name="excludeID" type="numeric" required="yes" default="0">
    <cfargument name="aiaName" type="string" required="yes" default="">
    <cfargument name="aiaStatus" type="string" required="yes" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="aiaName">
    <cfset var rsAuctionItemAttribute = "" >
    <cftry>
    <cfquery name="rsAuctionItemAttribute" datasource="#application.mcmsDSN#">
    SELECT * FROM v_auction_item_attribute WHERE 0=0
    <cfif ARGUMENTS.ID NEQ 0>
    AND ID = <cfqueryparam value="#ARGUMENTS.ID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.excludeID NEQ 0>
    AND ID <> <cfqueryparam value="#ARGUMENTS.excludeID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(aiaName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(aiaDescription) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">)
    </cfif>
    <cfif ARGUMENTS.aiaName NEQ "">
    AND UPPER(aiaName) = <cfqueryparam value="#UCASE(ARGUMENTS.aiaName)#" cfsqltype="cf_sql_varchar">
    </cfif>
    AND aiaStatus IN (<cfqueryparam value="#ARGUMENTS.aiaStatus#" list="yes" cfsqltype="cf_sql_integer">)
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsAuctionItemAttribute = StructNew()>
    <cfset rsAuctionItemAttribute.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsAuctionItemAttribute>
    </cffunction>
    
    <cffunction name="getAuctionItemAttrValue" access="public" returntype="query" hint="Get Auction Item Attribute Value data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="ID" type="numeric" required="yes" default="0">
    <cfargument name="excludeID" type="numeric" required="yes" default="0">
    <cfargument name="aiID" type="numeric" required="yes" default="0">
    <cfargument name="aiaID" type="numeric" required="yes" default="0">
    <cfargument name="aiavValue" type="string" required="yes" default="">
    <cfargument name="aiavStatus" type="string" required="yes" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="aiavValue">
    <cfset var rsAuctionItemAttrValue = "" >
    <cftry>
    <cfquery name="rsAuctionItemAttrValue" datasource="#application.mcmsDSN#">
    SELECT * FROM v_auction_item_attr_value WHERE 0=0
    <cfif ARGUMENTS.ID NEQ 0>
    AND ID = <cfqueryparam value="#ARGUMENTS.ID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.excludeID NEQ 0>
    AND ID <> <cfqueryparam value="#ARGUMENTS.excludeID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(aiaName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(aiavValue) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(aiName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">)
    </cfif>
    <cfif ARGUMENTS.aiID NEQ 0>
    AND aiID = <cfqueryparam value="#ARGUMENTS.aiID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.aiaID NEQ 0>
    AND aiaID = <cfqueryparam value="#ARGUMENTS.aiaID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.aiavValue NEQ "">
    AND UPPER(aiavValue) = <cfqueryparam value="#UCASE(ARGUMENTS.aiavValue)#" cfsqltype="cf_sql_varchar">
    </cfif>
    AND aiavStatus IN (<cfqueryparam value="#ARGUMENTS.aiavStatus#" list="yes" cfsqltype="cf_sql_integer">)
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsAuctionItemAttrValue = StructNew()>
    <cfset rsAuctionItemAttrValue.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsAuctionItemAttrValue>
    </cffunction>
    
    <cffunction name="getAuctionBid" access="public" returntype="query" hint="Get Auction Bid data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="ID" type="numeric" required="yes" default="0">
    <cfargument name="excludeID" type="numeric" required="yes" default="0">
    <cfargument name="aiID" type="numeric" required="yes" default="0">
    <cfargument name="abName" type="string" required="yes" default="">
    <cfargument name="abEmail" type="string" required="yes" default="">
    <cfargument name="abAmount" type="string" required="yes" default="">
    <cfargument name="abStatus" type="string" required="yes" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="abName">
    <cfset var rsAuctionBid = "" >
    <cftry>
    <cfquery name="rsAuctionBid" datasource="#application.mcmsDSN#">
    SELECT * FROM v_auction_bid WHERE 0=0
    <cfif ARGUMENTS.ID NEQ 0>
    AND ID = <cfqueryparam value="#ARGUMENTS.ID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.excludeID NEQ 0>
    AND ID <> <cfqueryparam value="#ARGUMENTS.excludeID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND UPPER(abName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">
    </cfif>
    <cfif ARGUMENTS.aiID NEQ 0>
    AND aiID = <cfqueryparam value="#ARGUMENTS.aiID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.abName NEQ "">
    AND UPPER(abName) = <cfqueryparam value="#UCASE(ARGUMENTS.abName)#" cfsqltype="cf_sql_varchar">
    </cfif>
    <cfif ARGUMENTS.abEmail NEQ "">
    AND UPPER(abEmail) = <cfqueryparam value="#UCASE(ARGUMENTS.abEmail)#" cfsqltype="cf_sql_varchar">
    </cfif>
    <cfif ARGUMENTS.abAmount NEQ "">
    AND abAmount = <cfqueryparam value="#ARGUMENTS.abAmount#" cfsqltype="cf_sql_float">
    </cfif>
    AND abStatus IN (<cfqueryparam value="#ARGUMENTS.abStatus#" list="yes" cfsqltype="cf_sql_integer">)
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsAuctionBid = StructNew()>
    <cfset rsAuctionBid.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsAuctionBid>
    </cffunction>
    
    <cffunction name="getAuctionDocumentRel" access="public" returntype="query" hint="Get Auction Document Relationship data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="ID" type="numeric" required="yes" default="0">
    <cfargument name="excludeID" type="numeric" required="yes" default="0">
    <cfargument name="aID" type="string" required="yes" default="0">
    <cfargument name="docID" type="numeric" required="yes" default="0">
    <cfargument name="adrStatus" type="string" required="yes" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="docName">
    <cfset var rsAuctionDocumentRel = "" >
    <cftry>
    <cfquery name="rsAuctionDocumentRel" datasource="#application.mcmsDSN#">
    SELECT * FROM v_auction_document_rel WHERE 0=0
    <cfif ARGUMENTS.ID NEQ 0>
    AND ID = <cfqueryparam value="#ARGUMENTS.ID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.excludeID NEQ 0>
    AND ID <> <cfqueryparam value="#ARGUMENTS.excludeID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(aName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(docName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">)
    </cfif>
    <cfif ARGUMENTS.aID NEQ 0>
    AND aID IN (<cfqueryparam value="#ARGUMENTS.aID#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    <cfif ARGUMENTS.docID NEQ 0>
    AND docID = <cfqueryparam value="#ARGUMENTS.docID#" cfsqltype="cf_sql_integer">
    </cfif>
    AND adrStatus IN (<cfqueryparam value="#ARGUMENTS.adrStatus#" list="yes" cfsqltype="cf_sql_integer">)
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsAuctionDocumentRel = StructNew()>
    <cfset rsAuctionDocumentRel.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsAuctionDocumentRel>
    </cffunction>
    
    <cffunction name="getAuctionItemImageRel" access="public" returntype="query" hint="Get Auction Item Image Relationship data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="ID" type="numeric" required="yes" default="0">
    <cfargument name="excludeID" type="numeric" required="yes" default="0">
    <cfargument name="aiID" type="string" required="yes" default="0">
    <cfargument name="imgID" type="numeric" required="yes" default="0">
    <cfargument name="aiirStatus" type="string" required="yes" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="aiID">
    <cfset var rsAuctionItemImageRel = "" >
    <cftry>
    <cfquery name="rsAuctionItemImageRel" datasource="#application.mcmsDSN#">
    SELECT * FROM v_auction_item_image_rel WHERE 0=0
    <cfif ARGUMENTS.ID NEQ 0>
    AND ID = <cfqueryparam value="#ARGUMENTS.ID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.excludeID NEQ 0>
    AND ID <> <cfqueryparam value="#ARGUMENTS.excludeID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(aiName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(imgName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">)
    </cfif>
    <cfif ARGUMENTS.aiID NEQ 0>
    AND aiID IN (<cfqueryparam value="#ARGUMENTS.aiID#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    <cfif ARGUMENTS.imgID NEQ 0>
    AND imgID = <cfqueryparam value="#ARGUMENTS.imgID#" cfsqltype="cf_sql_integer">
    </cfif>
    AND aiirStatus IN (<cfqueryparam value="#ARGUMENTS.aiirStatus#" list="yes" cfsqltype="cf_sql_integer">)
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsAuctionItemImageRel = StructNew()>
    <cfset rsAuctionItemImageRel.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsAuctionItemImageRel>
    </cffunction>
    
    <cffunction name="getAuctionSiteRel" access="public" returntype="query" hint="Get Auction Site Relationship data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="ID" type="numeric" required="yes" default="0">
    <cfargument name="excludeID" type="numeric" required="yes" default="0">
    <cfargument name="aID" type="string" required="yes" default="0">
    <cfargument name="siteNo" type="string" required="yes" default="100">
    <cfargument name="asrStatus" type="string" required="yes" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="aName">
    <cfset var rsAuctionSiteRel = "" >
    <cftry>
    <cfquery name="rsAuctionSiteRel" datasource="#application.mcmsDSN#">
    SELECT * FROM v_auction_site_rel WHERE 0=0
    <cfif ARGUMENTS.ID NEQ 0>
    AND ID = <cfqueryparam value="#ARGUMENTS.ID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.excludeID NEQ 0>
    AND ID <> <cfqueryparam value="#ARGUMENTS.excludeID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(aName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(siteName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">)
    </cfif>
    <cfif ARGUMENTS.aID NEQ 0>
    AND aID IN (<cfqueryparam value="#ARGUMENTS.aID#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    <cfif ARGUMENTS.siteNo NEQ 100>
    AND siteNo IN (<cfqueryparam value="#ARGUMENTS.siteNo#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    AND asrStatus IN (<cfqueryparam value="#ARGUMENTS.asrStatus#" list="yes" cfsqltype="cf_sql_integer">)
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsAuctionSiteRel = StructNew()>
    <cfset rsAuctionSiteRel.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsAuctionSiteRel>
    </cffunction>
    
    <cffunction name="getAuctionDepartmentRel" access="public" returntype="query" hint="Get Auction Department Relationship data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="ID" type="numeric" required="yes" default="0">
    <cfargument name="excludeID" type="numeric" required="yes" default="0">
    <cfargument name="aID" type="string" required="yes" default="0">
    <cfargument name="deptNo" type="string" required="yes" default="0">
    <cfargument name="adrStatus" type="string" required="yes" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="deptName">
    <cfset var rsAuctionDepartmentRel = "" >
    <cftry>
    <cfquery name="rsAuctionDepartmentRel" datasource="#application.mcmsDSN#">
    SELECT * FROM v_auction_department_rel WHERE 0=0
    <cfif ARGUMENTS.ID NEQ 0>
    AND ID = <cfqueryparam value="#ARGUMENTS.ID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.excludeID NEQ 0>
    AND ID <> <cfqueryparam value="#ARGUMENTS.excludeID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(aName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(deptName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">)
    </cfif>
	<cfif ARGUMENTS.aID NEQ 0>
    AND aID IN (<cfqueryparam value="#ARGUMENTS.aID#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    <cfif ARGUMENTS.deptNo NEQ 0>
    AND deptNo IN (<cfqueryparam value="#ARGUMENTS.deptNo#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    AND adrStatus IN (<cfqueryparam value="#ARGUMENTS.adrStatus#" list="yes" cfsqltype="cf_sql_integer">)
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsAuctionDepartmentRel = StructNew()>
    <cfset rsAuctionDepartmentRel.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsAuctionDepartmentRel>
    </cffunction>
    
    <cffunction name="getAuctionType" access="public" returntype="query" hint="Get Auction Type data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="ID" type="numeric" required="yes" default="0">
    <cfargument name="excludeID" type="numeric" required="yes" default="0">
    <cfargument name="atStatus" type="string" required="yes" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="atName">
    <cfset var rsAuctionType = "" >
    <cftry>
    <cfquery name="rsAuctionType" datasource="#application.mcmsDSN#">
    SELECT * FROM v_auction_type WHERE 0=0
    <cfif ARGUMENTS.ID NEQ 0>
    AND ID = <cfqueryparam value="#ARGUMENTS.ID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.excludeID NEQ 0>
    AND ID <> <cfqueryparam value="#ARGUMENTS.excludeID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND UPPER(atName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">
    </cfif>
    AND atStatus IN (<cfqueryparam value="#ARGUMENTS.atStatus#" list="yes" cfsqltype="cf_sql_integer">)
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsAuctionType = StructNew()>
    <cfset rsAuctionType.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsAuctionType>
    </cffunction>
    
    <cffunction name="getAuctionItemGrade" access="public" returntype="query" hint="Get Auction Item Grade data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="ID" type="numeric" required="yes" default="0">
    <cfargument name="excludeID" type="numeric" required="yes" default="0">
    <cfargument name="aigName" type="string" required="yes" default="">
    <cfargument name="aigStatus" type="string" required="yes" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="aigName">
    <cfset var rsAuctionItemGrade = "" >
    <cftry>
    <cfquery name="rsAuctionItemGrade" datasource="#application.mcmsDSN#">
    SELECT * FROM v_auction_item_grade WHERE 0=0
    <cfif ARGUMENTS.ID NEQ 0>
    AND ID = <cfqueryparam value="#ARGUMENTS.ID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.excludeID NEQ 0>
    AND ID <> <cfqueryparam value="#ARGUMENTS.excludeID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND UPPER(aigName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">
    </cfif>
    <cfif ARGUMENTS.aigName NEQ "">
    AND UPPER(aigName) = <cfqueryparam value="#UCASE(ARGUMENTS.aigName)#" cfsqltype="cf_sql_varchar">
    </cfif>
    AND aigStatus IN (<cfqueryparam value="#ARGUMENTS.aigStatus#" list="yes" cfsqltype="cf_sql_integer">)
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsAuctionItemGrade = StructNew()>
    <cfset rsAuctionItemGrade.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsAuctionItemGrade>
    </cffunction>
    
    <cffunction name="getAuctionReport" access="public" returntype="query" hint="Get Auction Report data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="orderBy" type="string" required="yes" default="aName">
    <cfset var rsAuctionReport = "" >
    <cftry>
    <cfquery name="rsAuctionReport" datasource="#application.mcmsDSN#">
    SELECT aName As Name, aDescription As Description, TO_CHAR(aDateRel, 'mm/dd/yyyy') As Date_Release, TO_CHAR(aDateExp, 'mm/dd/yyyy') As Date_Expires, atName As Type, sName As Status FROM v_auction WHERE 0=0
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(aName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(aDescription) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">)
    </cfif>
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsAuctionReport = StructNew()>
    <cfset rsAuctionReport.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsAuctionReport>
    </cffunction>
    
    <cffunction name="getAuctionItemReport" access="public" returntype="query" hint="Get Auction Item Report data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="orderBy" type="string" required="yes" default="aiName">
    <cfset var rsAuctionItemReport = "" >
    <cftry>
    <cfquery name="rsAuctionItemReport" datasource="#application.mcmsDSN#">
    SELECT aiName As Name, aiDescription As Description, TO_CHAR(aiDateRel, 'mm/dd/yyyy') As Date_Release, TO_CHAR(aiDateExp, 'mm/dd/yyyy') As Date_Expires, aiMfg As MFG, aiSKU As SKU, aiRetailPrice As Retail_Price, aiMinBid As Min_Bid, aiMaxBid As Max_Bid, aigName As Grade, sName As Status FROM v_auction_item WHERE 0=0
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(aiName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(aiDescription) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">)
    </cfif>
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsAuctionItemReport = StructNew()>
    <cfset rsAuctionItemReport.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsAuctionItemReport>
    </cffunction>
    
    <cffunction name="getAuctionItemAttrReport" access="public" returntype="query" hint="Get Auction Item Attribute Report data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="orderBy" type="string" required="yes" default="aiaName">
    <cfset var rsAuctionItemAttrReport = "" >
    <cftry>
    <cfquery name="rsAuctionItemAttrReport" datasource="#application.mcmsDSN#">
    SELECT aiaName As Name, aiaDescription As Description, sortName As Sort, sName As Status FROM v_auction_item_attribute WHERE 0=0
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(aiaName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(aiaDescription) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">)
    </cfif>
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsAuctionItemAttrReport = StructNew()>
    <cfset rsAuctionItemAttrReport.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsAuctionItemAttrReport>
    </cffunction>
    
    <cffunction name="getAuctionItemAttrValueReport" access="public" returntype="query" hint="Get Auction Item Attribute Value data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="orderBy" type="string" required="yes" default="aiavValue">
    <cfset var rsAuctionItemAttrValueReport = "" >
    <cftry>
    <cfquery name="rsAuctionItemAttrValueReport" datasource="#application.mcmsDSN#">
    SELECT aiavValue As Value, aiName As Item, aiaName As Item_Attribute, sortName As Sort, sName As Status FROM v_auction_item_attr_value WHERE 0=0
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(aiaName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(aiavValue) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">)
    </cfif>
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsAuctionItemAttrValueReport = StructNew()>
    <cfset rsAuctionItemAttrValueReport.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsAuctionItemAttrValueReport>
    </cffunction>
    
    <cffunction name="getAuctionItemGradeReport" access="public" returntype="query" hint="Get Auction Item Grade Report data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="orderBy" type="string" required="yes" default="aigName">
    <cfset var rsAuctionItemGradeReport = "" >
    <cftry>
    <cfquery name="rsAuctionItemGradeReport" datasource="#application.mcmsDSN#">
    SELECT aigName As Name, sortName As Sort, sName As Status FROM v_auction_item_grade WHERE 0=0
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND UPPER(aigName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">
    </cfif>
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsAuctionItemGradeReport = StructNew()>
    <cfset rsAuctionItemGradeReport.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsAuctionItemGradeReport>
    </cffunction>
    
    <cffunction name="getAuctionItemImageRelReport" access="public" returntype="query" hint="Get Auction Item Image Relationship Report data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="orderBy" type="string" required="yes" default="aiName">
    <cfset var rsAuctionItemImageRelReport = "" >
    <cftry>
    <cfquery name="rsAuctionItemImageRelReport" datasource="#application.mcmsDSN#">
    SELECT aiName As Item_Name, imgName As Image_Name, imgFile As Image_File, imgtWidth As Image_Width, sName As Status  FROM v_auction_item_image_rel WHERE 0=0
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(aiName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(imgName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">)
    </cfif>
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsAuctionItemImageRelReport = StructNew()>
    <cfset rsAuctionItemImageRelReport.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsAuctionItemImageRelReport>
    </cffunction>
    
    <cffunction name="getAuctionBidReport" access="public" returntype="query" hint="Get Auction Bid Report data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="orderBy" type="string" required="yes" default="abName">
    <cfset var rsAuctionBidReport = "" >
    <cftry>
    <cfquery name="rsAuctionBidReport" datasource="#application.mcmsDSN#">
    SELECT abName As Name, aName As Auction, aiName As Item, abAmount As Amount, abEmail As Email, abTelephone As Telephone,  TO_CHAR(abDate, 'mm/dd/yyyy') As Bid_Date, siteName As Site, sName As Status FROM v_auction_bid WHERE 0=0
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(abName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(aName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">)
    </cfif>
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsAuctionBidReport = StructNew()>
    <cfset rsAuctionBidReport.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsAuctionBidReport>
    </cffunction>
    
    <cffunction name="getAuctionTypeReport" access="public" returntype="query" hint="Get Auction Type Report data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="orderBy" type="string" required="yes" default="atName">
    <cfset var rsAuctionTypeReport = "" >
    <cftry>
    <cfquery name="rsAuctionTypeReport" datasource="#application.mcmsDSN#">
    SELECT atName As Name, atSort As Sort, sName As Status FROM v_auction_type WHERE 0=0
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND UPPER(atName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">
    </cfif>
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsAuctionTypeReport = StructNew()>
    <cfset rsAuctionTypeReport.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsAuctionTypeReport>
    </cffunction>
    
    <cffunction name="insertAuction" access="public" returntype="struct">
    <cfargument name="aName" type="string" required="yes">
    <cfargument name="aDescription" type="string" required="yes">
    <cfargument name="aDateRel" type="string" required="yes">
    <cfargument name="aDateExp" type="string" required="yes">
    <cfargument name="atID" type="numeric" required="yes">
    <cfargument name="aStatus" type="numeric" required="yes">
    <!---Relationship arguments.--->
    <cfargument name="siteNo" type="string" required="yes">
    <cfargument name="deptNo" type="string" required="yes">
    <cfargument name="docID" type="numeric" required="yes">
    <cfset result.message = "You have successfully inserted the record.">
    <cftry>
    <!---Check for profanity in the text.--->
    <cfinvoke 
    component="MCMS.component.utility.Regex"
    method="regexProfanity"
    returnvariable="regexProfanityRet">
    <cfinvokeargument name="profanityString" value="#ARGUMENTS.aDescription#"/>
    </cfinvoke>
    <!---Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.app.auction.Auction"
    method="getAuction"
    returnvariable="getCheckAuctionRet">
    <cfinvokeargument name="aName" value="#ARGUMENTS.aName#"/>
    <cfinvokeargument name="aStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckAuctionRet.recordcount NEQ 0>
    <cfset result.message = "The name #ARGUMENTS.aName# already exists, please enter a new name.">
    <cfelseif regexProfanityRet CONTAINS '$%&*!'>
    <cfset result.message = "Some text contained profanity, please remove any profanity from your text.">
    <!---Check length restriction.--->
    <cfelseif LEN(ARGUMENTS.aDescription) GT 2048>
    <cfset result.message = "The description is longer than 2048 characters, please enter a new description under 2048 characters.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    INSERT INTO tbl_auction (aName,aDescription,aDateRel,aDateExp,atID,aStatus) VALUES
    (
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.aName#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.aDescription#">,
    <cfqueryparam cfsqltype="cf_sql_date" value="#ARGUMENTS.aDateRel#">,
    <cfqueryparam cfsqltype="cf_sql_date" value="#ARGUMENTS.aDateExp#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.atID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.aStatus#">
    )
    </cfquery>
    </cftransaction>
    <!--- Get newly inserted auction ID. --->
    <cfinvoke 
    component="MCMS.component.cms.Cms"
    method="getMaxValueSQL"
    returnvariable="aID">
    <cfinvokeargument name="tableName" value="tbl_auction"/>
    </cfinvoke>
    <cfset var.aID = aID>
    <!---Create site relationships.--->
    <cfloop index="siteNo" list="#ARGUMENTS.siteNo#">
    <cfinvoke 
    component="MCMS.component.app.auction.Auction"
    method="insertAuctionSiteRel"
    returnvariable="insertAuctionSiteRelRet">
    <cfinvokeargument name="aID" value="#var.aID#"/>
    <cfinvokeargument name="siteNo" value="#ARGUMENTS.siteNo#"/>
    <cfinvokeargument name="asrStatus" value="1"/>
    </cfinvoke>
    </cfloop>
    <!---Create department relationships.--->
    <cfloop index="deptNo" list="#ARGUMENTS.deptNo#">
    <cfinvoke 
    component="MCMS.component.app.auction.Auction"
    method="insertAuctionDepartmentRel"
    returnvariable="insertAuctionDepartmentRelRet">
    <cfinvokeargument name="aID" value="#var.aID#"/>
    <cfinvokeargument name="deptNo" value="#ARGUMENTS.deptNo#"/>
    <cfinvokeargument name="adrStatus" value="1"/>
    </cfinvoke>
    </cfloop>
    <!---Create document relationships.--->
    <cfinvoke 
    component="MCMS.component.app.auction.Auction"
    method="insertAuctionDocumentRel"
    returnvariable="insertAuctionDocumentRelRet">
    <cfinvokeargument name="aID" value="#var.aID#"/>
    <cfinvokeargument name="docID" value="#ARGUMENTS.docID#"/>
    <cfinvokeargument name="adrStatus" value="1"/>
    </cfinvoke>
    </cfif>
    <cfcatch type="any">
    <cfset result.message = "There was an error inserting the record.">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="insertAuctionItem" access="public" returntype="struct">
    <cfargument name="aID" type="numeric" required="yes">
    <cfargument name="aiName" type="string" required="yes">
    <cfargument name="aiDescription" type="string" required="yes">
    <cfargument name="aiDateRel" type="string" required="yes">
    <cfargument name="aiDateExp" type="string" required="yes">
    <cfargument name="aiMfg" type="string" required="yes">
    <cfargument name="aiSku" type="string" required="yes">
    <cfargument name="aiRetailPrice" type="string" required="yes">
    <cfargument name="aiMinBid" type="string" required="yes">
    <cfargument name="aiMaxBid" type="string" required="yes">
    <cfargument name="aigID" type="string" required="yes">
    <cfargument name="aiSort" type="numeric" required="yes">
    <cfargument name="aiStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully inserted the record.">
    <cftry>
    <!---Check for profanity in the text.--->
    <cfinvoke 
    component="MCMS.component.utility.Regex"
    method="regexProfanity"
    returnvariable="regexProfanityRet">
    <cfinvokeargument name="profanityString" value="#ARGUMENTS.aiDescription#"/>
    </cfinvoke>
    <!---Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.app.auction.Auction"
    method="getAuctionItem"
    returnvariable="getCheckAuctionItemRet">
    <cfinvokeargument name="aID" value="#ARGUMENTS.aID#"/>
    <cfinvokeargument name="aiName" value="#ARGUMENTS.aiName#"/>
    <cfinvokeargument name="aiStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckAuctionItemRet.recordcount NEQ 0>
    <cfset result.message = "The name #ARGUMENTS.aiName# already exists for this Auction, please enter a new name.">
    <cfelseif regexProfanityRet CONTAINS '$%&*!'>
    <cfset result.message = "Some text contained profanity, please remove any profanity from your text.">
    <!---Check length restriction.--->
    <cfelseif LEN(ARGUMENTS.aiDescription) GT 2048>
    <cfset result.message = "The description is longer than 2048 characters, please enter a new description under 2048 characters.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    INSERT INTO tbl_auction_item (aID,aiName,aiDescription,aiDateRel,aiDateExp,aiMfg,aiSku,aiRetailPrice,aiMinBid,aiMaxBid,aigID,aiSort,aiStatus) VALUES
    (
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.aID#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.aiName#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.aiDescription#">,
    <cfqueryparam cfsqltype="cf_sql_date" value="#ARGUMENTS.aiDateRel#">,
    <cfqueryparam cfsqltype="cf_sql_date" value="#ARGUMENTS.aiDateExp#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.aiMfg#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.aiSku#">,
    <cfqueryparam cfsqltype="cf_sql_float" value="#ARGUMENTS.aiRetailPrice#">,
    <cfqueryparam cfsqltype="cf_sql_float" value="#ARGUMENTS.aiMinBid#">,
    <cfqueryparam cfsqltype="cf_sql_float" value="#ARGUMENTS.aiMaxBid#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.aigID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.aiSort#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.aiStatus#">
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
    
    <cffunction name="insertAuctionBid" access="public" returntype="struct">
    <cfargument name="aID" type="numeric" required="yes">
    <cfargument name="aiID" type="numeric" required="yes">
    <cfargument name="abName" type="string" required="yes">
    <cfargument name="abEmail" type="string" required="yes">
    <cfargument name="abTelephone" type="string" required="yes">
    <cfargument name="abAmount" type="string" required="yes">
    <cfargument name="siteNo" type="numeric" required="yes">
    <cfargument name="abStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully inserted your bid.">
    <cftry>
    <!---Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.app.auction.Auction"
    method="getAuctionBid"
    returnvariable="getCheckAuctionBidRet">
    <cfinvokeargument name="aiID" value="#ARGUMENTS.aiID#"/>
    <cfinvokeargument name="abEmail" value="#ARGUMENTS.abEmail#"/>
    <cfinvokeargument name="abAmount" value="#ARGUMENTS.abAmount#"/>
    <cfinvokeargument name="abStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckAuctionBidRet.recordcount NEQ 0>
    <cfset result.message = "You have already posted a bid for this amount, please try again.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    INSERT INTO tbl_auction_bid (aID,aiID,abName,abEmail,abTelephone,abAmount,siteNo,abStatus) VALUES
    (
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.aID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.aiID#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.abName#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.abEmail#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.abTelephone#">,
    <cfqueryparam cfsqltype="cf_sql_float" value="#ARGUMENTS.abAmount#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.siteNo#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.abStatus#">
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
    
    <cffunction name="insertAuctionItemAttr" access="public" returntype="struct">
    <cfargument name="aiaName" type="string" required="yes">
    <cfargument name="aiaDescription" type="string" required="yes">
    <cfargument name="aiaSort" type="numeric" required="yes">
    <cfargument name="aiaStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully inserted the record.">
    <cftry>
    <!---Check for profanity in the text.--->
    <cfinvoke 
    component="MCMS.component.utility.Regex"
    method="regexProfanity"
    returnvariable="regexProfanityRet">
    <cfinvokeargument name="profanityString" value="#ARGUMENTS.aiaDescription#"/>
    </cfinvoke>
    <!---Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.app.auction.Auction"
    method="getAuctionItemAttr"
    returnvariable="getCheckAuctionItemAttrRet">
    <cfinvokeargument name="aiaName" value="#ARGUMENTS.aiaName#"/>
    <cfinvokeargument name="aiaStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckAuctionItemAttrRet.recordcount NEQ 0>
    <cfset result.message = "The name #ARGUMENTS.aiaName# already exists, please enter a new name.">
    <cfelseif regexProfanityRet CONTAINS '$%&*!'>
    <cfset result.message = "Some text contained profanity, please remove any profanity from your text.">
    <!---Check length restriction.--->
    <cfelseif LEN(ARGUMENTS.aiaDescription) GT 512>
    <cfset result.message = "The description is longer than 512 characters, please enter a new description under 512 characters.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    INSERT INTO tbl_auction_item_attribute (aiaName,aiaDescription,aiaSort,aiaStatus) VALUES
    (
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.aiaName#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.aiaDescription#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.aiaSort#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.aiaStatus#">
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
    
    <cffunction name="insertAuctionItemAttrValue" access="public" returntype="struct">
    <cfargument name="aiID" type="numeric" required="yes">
    <cfargument name="aiaID" type="numeric" required="yes">
    <cfargument name="aiavValue" type="string" required="yes">
    <cfargument name="aiavSort" type="numeric" required="yes">
    <cfargument name="aiavStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully inserted the record.">
    <cftry>
    <!---Check for profanity in the text.--->
    <cfinvoke 
    component="MCMS.component.utility.Regex"
    method="regexProfanity"
    returnvariable="regexProfanityRet">
    <cfinvokeargument name="profanityString" value="#ARGUMENTS.aiavValue#"/>
    </cfinvoke>
    <!---Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.app.auction.Auction"
    method="getAuctionItemAttrValue"
    returnvariable="getCheckAuctionItemAttrValueRet">
    <cfinvokeargument name="aiID" value="#ARGUMENTS.aiID#"/>
    <cfinvokeargument name="aiaID" value="#ARGUMENTS.aiaID#"/>
    <cfinvokeargument name="aiavValue" value="#ARGUMENTS.aiavValue#"/>
    <cfinvokeargument name="aiavStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckAuctionItemAttrValueRet.recordcount NEQ 0>
    <cfset result.message = "The value #ARGUMENTS.aiavValue# already exists, please try again.">
    <cfelseif regexProfanityRet CONTAINS '$%&*!'>
    <cfset result.message = "Some value contained profanity, please remove any profanity from your value.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    INSERT INTO tbl_auction_item_attr_value (aiID,aiaID,aiavValue,aiavSort,aiavStatus) VALUES
    (
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.aiID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.aiaID#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.aiavValue#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.aiavSort#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.aiavStatus#">
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
    
    <cffunction name="insertAuctionItemGrade" access="public" returntype="struct">
    <cfargument name="aigName" type="string" required="yes">
    <cfargument name="aigSort" type="numeric" required="yes">
    <cfargument name="aigStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully inserted the record.">
    <cftry>
    <!---Check for profanity in the text.--->
    <cfinvoke 
    component="MCMS.component.utility.Regex"
    method="regexProfanity"
    returnvariable="regexProfanityRet">
    <cfinvokeargument name="profanityString" value="#ARGUMENTS.aigName#"/>
    </cfinvoke>
    <!---Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.app.auction.Auction"
    method="getAuctionItemGrade"
    returnvariable="getCheckAuctionItemGradeRet">
    <cfinvokeargument name="aigName" value="#ARGUMENTS.aigName#"/>
    <cfinvokeargument name="aigStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckAuctionItemGradeRet.recordcount NEQ 0>
    <cfset result.message = "The name #ARGUMENTS.aigName# already exists, please enter a new name.">
    <cfelseif regexProfanityRet CONTAINS '$%&*!'>
    <cfset result.message = "Some text contained profanity, please remove any profanity from your text.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    INSERT INTO tbl_auction_item_grade (aigName,aigSort,aigStatus) VALUES
    (
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.aigName#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.aigSort#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.aigStatus#">
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
    
    <cffunction name="insertAuctionDocumentRel" access="public" returntype="struct">
    <cfargument name="aID" type="numeric" required="yes">
    <cfargument name="docID" type="numeric" required="yes">
    <cfargument name="adrStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully inserted the record.">
    <cftry>
    <!---Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.app.auction.Auction"
    method="getAuctionDocumentRel"
    returnvariable="getCheckAuctionDocumentRelRet">
    <cfinvokeargument name="aID" value="#ARGUMENTS.aID#"/>
    <cfinvokeargument name="docID" value="#ARGUMENTS.docID#"/>
    <cfinvokeargument name="adrStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckAuctionDocumentRelRet.recordcount NEQ 0>
    <cfset result.message = "The auction document relationship already exists, please try again.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    INSERT INTO tbl_auction_document_rel (aID,docID,adrStatus) VALUES
    (
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.aID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.docID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.adrStatus#">
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
    
    <cffunction name="insertAuctionSiteRel" access="public" returntype="struct">
    <cfargument name="aID" type="numeric" required="yes">
    <cfargument name="siteNo" type="numeric" required="yes">
    <cfargument name="asrStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully inserted the record.">
    <cftry>
    <!---Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.app.auction.Auction"
    method="getAuctionSiteRel"
    returnvariable="getCheckAuctionSiteRelRet">
    <cfinvokeargument name="aID" value="#ARGUMENTS.aID#"/>
    <cfinvokeargument name="siteNo" value="#ARGUMENTS.siteNo#"/>
    <cfinvokeargument name="asrStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckAuctionSiteRelRet.recordcount NEQ 0>
    <cfset result.message = "The auction site relationship already exists, please try again.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    INSERT INTO tbl_auction_site_rel (aID,siteNo,asrStatus) VALUES
    (
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.aID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.siteNo#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.asrStatus#">
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
    
    <cffunction name="insertAuctionDepartmentRel" access="public" returntype="struct">
    <cfargument name="aID" type="numeric" required="yes">
    <cfargument name="deptNo" type="numeric" required="yes">
    <cfargument name="adrStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully inserted the record.">
    <cftry>
    <!---Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.app.auction.Auction"
    method="getAuctionDepartmentRel"
    returnvariable="getCheckAuctionDepartmentRelRet">
    <cfinvokeargument name="aID" value="#ARGUMENTS.aID#"/>
    <cfinvokeargument name="deptNo" value="#ARGUMENTS.deptNo#"/>
    <cfinvokeargument name="adrStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckAuctionDepartmentRelRet.recordcount NEQ 0>
    <cfset result.message = "The auction department relationship already exists, please try again.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    INSERT INTO tbl_auction_department_rel (aID,deptNo,adrStatus) VALUES
    (
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.aID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.deptNo#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.adrStatus#">
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
    
    <cffunction name="insertAuctionItemImageRel" access="public" returntype="struct">
    <cfargument name="aiID" type="numeric" required="yes">
    <cfargument name="imgID" type="numeric" required="yes">
    <cfargument name="aiirStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully inserted the record.">
    <cftry>
    <!---Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.app.auction.Auction"
    method="getAuctionItemImageRel"
    returnvariable="getAuctionItemImageRelRet">
    <cfinvokeargument name="aiID" value="#ARGUMENTS.aiID#"/>
    <cfinvokeargument name="imgID" value="#ARGUMENTS.imgID#"/>
    <cfinvokeargument name="aiirStatus" value="1,2,3"/>
    </cfinvoke>
    <!---Check count for 3 auction item images already inserted.--->
    <cfinvoke 
    component="MCMS.component.app.auction.Auction"
    method="getAuctionItemImageRel"
    returnvariable="getAuctionItemImageRelCount">
    <cfinvokeargument name="aiID" value="#ARGUMENTS.aiID#"/>
    <cfinvokeargument name="adrStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getAuctionItemImageRelRet.recordcount NEQ 0>
    <cfset result.message = "The auction item image relationship already exists, please try again.">
    <cfelseif getAuctionItemImageRelCount.recordcount GTE 3>
    <cfset result.message = "The maximum number of auction item images is 3.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    INSERT INTO tbl_auction_item_image_rel (aiID,imgID,aiirStatus) VALUES
    (
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.aiID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.imgID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.aiirStatus#">
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
    
    <cffunction name="updateAuction" access="public" returntype="struct">
    <cfargument name="ID" type="numeric" required="yes">
    <cfargument name="aName" type="string" required="yes">
    <cfargument name="aDescription" type="string" required="yes">
    <cfargument name="aDateRel" type="string" required="yes">
    <cfargument name="aDateExp" type="string" required="yes">
    <cfargument name="atID" type="numeric" required="yes">
    <cfargument name="aStatus" type="numeric" required="yes">
    <!---Relationship arguments.--->
    <cfargument name="siteNo" type="string" required="yes">
    <cfargument name="deptNo" type="string" required="yes">
    <cfargument name="docID" type="numeric" required="yes">
    <cfset result.message = "You have successfully updated the record.">
    <cftry>
    <!---Check for profanity in the text.--->
    <cfinvoke 
    component="MCMS.component.utility.Regex"
    method="regexProfanity"
    returnvariable="regexProfanityRet">
    <cfinvokeargument name="profanityString" value="#ARGUMENTS.aDescription#"/>
    </cfinvoke>
    <!---Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.app.auction.Auction"
    method="getAuction"
    returnvariable="getCheckAuctionRet">
    <cfinvokeargument name="excludeID" value="#ARGUMENTS.ID#"/>
    <cfinvokeargument name="aName" value="#ARGUMENTS.aName#"/>
    <cfinvokeargument name="aStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckAuctionRet.recordcount NEQ 0>
    <cfset result.message = "The name #ARGUMENTS.aName# already exists, please enter a new name.">
    <cfelseif regexProfanityRet CONTAINS '$%&*!'>
    <cfset result.message = "Some text contained profanity, please remove any profanity from your text.">
    <!---Check length restriction.--->
    <cfelseif LEN(ARGUMENTS.aDescription) GT 2048>
    <cfset result.message = "The description is longer than 2048 characters, please enter a new description under 2048 characters.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_auction SET
    aName = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.aName#">,
    aDescription = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.aDescription#">,
    aDateRel = <cfqueryparam cfsqltype="cf_sql_date" value="#ARGUMENTS.aDateRel#">,
    aDateExp = <cfqueryparam cfsqltype="cf_sql_date" value="#ARGUMENTS.aDateExp#">,
    atID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.atID#">,
    aStatus = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.aStatus#">
    WHERE ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ID#">
    </cfquery>
    </cftransaction>
    <!---Delete any existing relationships.--->
    <cfinvoke 
    component="MCMS.component.app.auction.Auction"
    method="deleteAuctionSiteRel"
    returnvariable="deleteAuctionSiteRelRet">
    <cfinvokeargument name="aID" value="#ARGUMENTS.ID#"/>
    </cfinvoke>
    <cfinvoke 
    component="MCMS.component.app.auction.Auction"
    method="deleteAuctionDepartmentRel"
    returnvariable="deleteAuctionDepartmentRelRet">
    <cfinvokeargument name="aID" value="#ARGUMENTS.ID#"/>
    </cfinvoke>
    <cfinvoke 
    component="MCMS.component.app.auction.Auction"
    method="deleteAuctionDocumentRel"
    returnvariable="deleteAuctionDocumentRelRet">
    <cfinvokeargument name="aID" value="#ARGUMENTS.ID#"/>
    </cfinvoke>
    <!---Create site relationships.--->
    <cfloop index="siteNo" list="#ARGUMENTS.siteNo#">
    <cfinvoke 
    component="MCMS.component.app.auction.Auction"
    method="insertAuctionSiteRel"
    returnvariable="insertAuctionSiteRelRet">
    <cfinvokeargument name="aID" value="#ARGUMENTS.ID#"/>
    <cfinvokeargument name="siteNo" value="#ARGUMENTS.siteNo#"/>
    <cfinvokeargument name="asrStatus" value="1"/>
    </cfinvoke>
    </cfloop>
    <!---Create department relationships.--->
    <cfloop index="deptNo" list="#ARGUMENTS.deptNo#">
    <cfinvoke 
    component="MCMS.component.app.auction.Auction"
    method="insertAuctionDepartmentRel"
    returnvariable="insertAuctionDepartmentRelRet">
    <cfinvokeargument name="aID" value="#ARGUMENTS.ID#"/>
    <cfinvokeargument name="deptNo" value="#ARGUMENTS.deptNo#"/>
    <cfinvokeargument name="adrStatus" value="1"/>
    </cfinvoke>
    </cfloop>
    <!---Create document relationships.--->
    <cfinvoke 
    component="MCMS.component.app.auction.Auction"
    method="insertAuctionDocumentRel"
    returnvariable="insertAuctionDocumentRelRet">
    <cfinvokeargument name="aID" value="#ARGUMENTS.ID#"/>
    <cfinvokeargument name="docID" value="#ARGUMENTS.docID#"/>
    <cfinvokeargument name="adrStatus" value="1"/>
    </cfinvoke>
    </cfif>
    <cfcatch type="any">
    <cfset result.message = "There was an error updating the record.">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="updateAuctionItem" access="public" returntype="struct">
    <cfargument name="ID" type="numeric" required="yes">
    <cfargument name="aiName" type="string" required="yes">
    <cfargument name="aiDescription" type="string" required="yes">
    <cfargument name="aiDateRel" type="string" required="yes">
    <cfargument name="aiDateExp" type="string" required="yes">
    <cfargument name="aiMfg" type="string" required="yes">
    <cfargument name="aiSku" type="string" required="yes">
    <cfargument name="aiRetailPrice" type="string" required="yes">
    <cfargument name="aiMinBid" type="string" required="yes">
    <cfargument name="aiMaxBid" type="string" required="yes">
    <cfargument name="aigID" type="numeric" required="yes">
    <cfargument name="aiSort" type="numeric" required="yes">
    <cfargument name="aiStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully updated the record.">
    <cftry>
    <!---Check for profanity in the text.--->
    <cfinvoke 
    component="MCMS.component.utility.Regex"
    method="regexProfanity"
    returnvariable="regexProfanityRet">
    <cfinvokeargument name="profanityString" value="#ARGUMENTS.aiDescription#"/>
    </cfinvoke>
    <!---Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.app.auction.Auction"
    method="getAuctionItem"
    returnvariable="getCheckAuctionItemRet">
    <cfinvokeargument name="excludeID" value="#ARGUMENTS.ID#"/>
    <cfinvokeargument name="aiName" value="#ARGUMENTS.aiName#"/>
    <cfinvokeargument name="aiStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckAuctionItemRet.recordcount NEQ 0>
    <cfset result.message = "The name #ARGUMENTS.aiName# already exists, please enter a new name.">
    <cfelseif regexProfanityRet CONTAINS '$%&*!'>
    <cfset result.message = "Some text contained profanity, please remove any profanity from your text.">
    <!---Check length restriction.--->
    <cfelseif LEN(ARGUMENTS.aiDescription) GT 2048>
    <cfset result.message = "The description is longer than 2048 characters, please enter a new description under 2048 characters.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_auction_item SET
    aiName = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.aiName#">,
    aiDescription = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.aiDescription#">,
    aiDateRel = <cfqueryparam cfsqltype="cf_sql_date" value="#ARGUMENTS.aiDateRel#">,
    aiDateExp = <cfqueryparam cfsqltype="cf_sql_date" value="#ARGUMENTS.aiDateExp#">,
    aiMfg = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.aiMfg#">,
    aiSku = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.aiSku#">,
    aiRetailPrice = <cfqueryparam cfsqltype="cf_sql_float" value="#ARGUMENTS.aiRetailPrice#">,
    aiMinBid = <cfqueryparam cfsqltype="cf_sql_float" value="#ARGUMENTS.aiMinBid#">,
    aiMaxBid = <cfqueryparam cfsqltype="cf_sql_float" value="#ARGUMENTS.aiMaxBid#">,
    aigID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.aigID#">,
    aiSort = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.aiSort#">,
    aiStatus = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.aiStatus#">
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
    
    <cffunction name="updateAuctionItemAttr" access="public" returntype="struct">
    <cfargument name="ID" type="numeric" required="yes">
    <cfargument name="aiaName" type="string" required="yes">
    <cfargument name="aiaDescription" type="string" required="yes">
    <cfargument name="aiaSort" type="numeric" required="yes">
    <cfargument name="aiaStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully updated the record.">
    <cftry>
    <!---Check for profanity in the text.--->
    <cfinvoke 
    component="MCMS.component.utility.Regex"
    method="regexProfanity"
    returnvariable="regexProfanityRet">
    <cfinvokeargument name="profanityString" value="#ARGUMENTS.aiaDescription#"/>
    </cfinvoke>
    <!---Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.app.auction.Auction"
    method="getAuctionItemAttr"
    returnvariable="getCheckAuctionItemAttrRet">
    <cfinvokeargument name="excludeID" value="#ARGUMENTS.ID#"/>
    <cfinvokeargument name="aiaName" value="#ARGUMENTS.aiaName#"/>
    <cfinvokeargument name="aiaStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckAuctionItemAttrRet.recordcount NEQ 0>
    <cfset result.message = "The name #ARGUMENTS.aiaName# already exists, please enter a new name.">
    <cfelseif regexProfanityRet CONTAINS '$%&*!'>
    <cfset result.message = "Some text contained profanity, please remove any profanity from your text.">
    <!---Check length restriction.--->
    <cfelseif LEN(ARGUMENTS.aiaDescription) GT 512>
    <cfset result.message = "The description is longer than 512 characters, please enter a new description under 512 characters.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_auction_item_attribute SET
    aiaName = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.aiaName#">,
    aiaDescription = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.aiaDescription#">,
    aiaSort = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.aiaSort#">,
    aiaStatus = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.aiaStatus#">
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
    
    <cffunction name="updateAuctionItemAttrValue" access="public" returntype="struct">
    <cfargument name="ID" type="numeric" required="yes">
    <cfargument name="aiID" type="numeric" required="yes">
    <cfargument name="aiaID" type="numeric" required="yes">
    <cfargument name="aiavValue" type="string" required="yes">
    <cfargument name="aiavSort" type="numeric" required="yes">
    <cfargument name="aiavStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully updated the record.">
    <cftry>
    <!---Check for profanity in the text.--->
    <cfinvoke 
    component="MCMS.component.utility.Regex"
    method="regexProfanity"
    returnvariable="regexProfanityRet">
    <cfinvokeargument name="profanityString" value="#ARGUMENTS.aiavValue#"/>
    </cfinvoke>
    <!---Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.app.auction.Auction"
    method="getAuctionItemAttrValue"
    returnvariable="getCheckAuctionItemAttrValueRet">
    <cfinvokeargument name="excludeID" value="#ARGUMENTS.ID#"/>
    <cfinvokeargument name="aiID" value="#ARGUMENTS.aiID#"/>
    <cfinvokeargument name="aiaID" value="#ARGUMENTS.aiaID#"/>
    <cfinvokeargument name="aiavValue" value="#ARGUMENTS.aiavValue#"/>
    <cfinvokeargument name="aiavStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckAuctionItemAttrValueRet.recordcount NEQ 0>
    <cfset result.message = "The value #ARGUMENTS.aiavValue# already exists, please enter a new name.">
    <cfelseif regexProfanityRet CONTAINS '$%&*!'>
    <cfset result.message = "Some text contained profanity, please remove any profanity from your text.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_auction_item_attr_value SET
    aiID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.aiID#">,
    aiaID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.aiaID#">,
    aiavValue = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.aiavValue#">,
    aiavSort = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.aiavSort#">,
    aiavStatus = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.aiavStatus#">
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
    
    <cffunction name="updateAuctionItemGrade" access="public" returntype="struct">
    <cfargument name="ID" type="numeric" required="yes">
    <cfargument name="aigName" type="string" required="yes">
    <cfargument name="aigSort" type="numeric" required="yes">
    <cfargument name="aigStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully updated the record.">
    <cftry>
    <!---Check for profanity in the text.--->
    <cfinvoke 
    component="MCMS.component.utility.Regex"
    method="regexProfanity"
    returnvariable="regexProfanityRet">
    <cfinvokeargument name="profanityString" value="#ARGUMENTS.aigName#"/>
    </cfinvoke>
    <!---Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.app.auction.Auction"
    method="getAuctionItemGrade"
    returnvariable="getCheckAuctionItemGradeRet">
    <cfinvokeargument name="excludeID" value="#ARGUMENTS.ID#"/>
    <cfinvokeargument name="aigName" value="#ARGUMENTS.aigName#"/>
    <cfinvokeargument name="aigStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckAuctionItemGradeRet.recordcount NEQ 0>
    <cfset result.message = "The name #ARGUMENTS.aigName# already exists, please enter a new name.">
    <cfelseif regexProfanityRet CONTAINS '$%&*!'>
    <cfset result.message = "Some text contained profanity, please remove any profanity from your text.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_auction_item_grade SET
    aigName = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.aigName#">,
    aigSort = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.aigSort#">,
    aigStatus = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.aigStatus#">
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
    
    <cffunction name="updateAuctionItemImageRel" access="public" returntype="struct">
    <cfargument name="ID" type="numeric" required="yes">
    <cfargument name="aiID" type="numeric" required="yes">
    <cfargument name="imgID" type="numeric" required="yes">
    <cfargument name="aiirStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully updated the record.">
    <cftry>
    <cfinvoke 
    component="MCMS.component.app.auction.Auction"
    method="getAuctionItemImageRel"
    returnvariable="getAuctionItemImageRelRet">
    <cfinvokeargument name="excludeID" value="#ARGUMENTS.ID#"/>
    <cfinvokeargument name="aiID" value="#ARGUMENTS.aiID#"/>
    <cfinvokeargument name="imgID" value="#ARGUMENTS.imgID#"/>
    <cfinvokeargument name="aiirStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getAuctionItemImageRelRet.recordcount NEQ 0>
    <cfset result.message = "The auction item image relationship already exists, please try again.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_auction_item_image_rel SET
    imgID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.imgID#">,
    aiirStatus = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.aiirStatus#">
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
    
    <cffunction name="updateAuctionList" access="public" returntype="struct">
    <cfargument name="ID" type="numeric" required="yes">
    <cfargument name="aStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully updated the records.">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_auction SET
    aStatus = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.aStatus#">
    WHERE ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ID#">
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error updating the records.">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="updateAuctionItemList" access="public" returntype="struct">
    <cfargument name="ID" type="numeric" required="yes">
    <cfargument name="aiStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully updated the records.">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_auction_item SET
    aiStatus = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.aiStatus#">
    WHERE ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ID#">
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error updating the records.">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="updateAuctionItemAttrList" access="public" returntype="struct">
    <cfargument name="ID" type="numeric" required="yes">
    <cfargument name="aiaStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully updated the records.">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_auction_item_attribute SET
    aiaStatus = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.aiaStatus#">
    WHERE ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ID#">
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error updating the records.">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="updateAuctionItemAttrValueList" access="public" returntype="struct">
    <cfargument name="ID" type="numeric" required="yes">
    <cfargument name="aiavStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully updated the records.">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_auction_item_attr_value SET
    aiavStatus = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.aiavStatus#">
    WHERE ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ID#">
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error updating the records.">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="updateAuctionItemGradeList" access="public" returntype="struct">
    <cfargument name="ID" type="numeric" required="yes">
    <cfargument name="aigStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully updated the records.">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_auction_item_grade SET
    aigStatus = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.aigStatus#">
    WHERE ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ID#">
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error updating the records.">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="updateAuctionItemImageRelList" access="public" returntype="struct">
    <cfargument name="ID" type="numeric" required="yes">
    <cfargument name="aiirStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully updated the records.">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_auction_item_image_rel SET
    aiirStatus = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.aiirStatus#">
    WHERE ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ID#">
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error updating the records.">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="deleteAuction" access="public" returntype="struct">
    <cfargument name="ID" type="string" required="yes">
    <cfset result.message = "You have successfully deleted the record(s).">
    <cftry>
    <!---Get all the items associated with this auction. Then delete all the images associated to each item before deleting the auction, as it would break the view.--->
    <cfinvoke 
    component="MCMS.component.app.auction.Auction"
    method="getAuctionItem"
    returnvariable="getAuctionItemRet">
    <cfinvokeargument name="aID" value="#ARGUMENTS.ID#"/>
    <cfinvokeargument name="aiStatus" value="1"/>
    </cfinvoke>
    <cfloop index="aiID" list="#ValueList(getAuctionItemRet.ID)#">
    <cfinvoke 
    component="MCMS.component.app.auction.Auction"
    method="deleteAuctionItemImageRel"
    returnvariable="deleteAuctionItemImageRelRet">
    <cfinvokeargument name="aiID" value="#aiID#"/>
    </cfinvoke>
    </cfloop>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    DELETE FROM tbl_auction
    WHERE ID IN (<cfqueryparam cfsqltype="cf_sql_integer" list="yes" value="#ARGUMENTS.ID#">)
    </cfquery>
    </cftransaction>
    <cfinvoke 
    component="MCMS.component.app.auction.Auction"
    method="deleteAuctionItem"
    returnvariable="deleteAuctionItemRet">
    <cfinvokeargument name="aID" value="#ARGUMENTS.ID#"/>
    </cfinvoke>
    <cfinvoke 
    component="MCMS.component.app.auction.Auction"
    method="deleteAuctionBid"
    returnvariable="deleteAuctionBidRet">
    <cfinvokeargument name="aID" value="#ARGUMENTS.ID#"/>
    </cfinvoke>
    <cfinvoke 
    component="MCMS.component.app.auction.Auction"
    method="deleteAuctionSiteRel"
    returnvariable="deleteAuctionSiteRelRet">
    <cfinvokeargument name="aID" value="#ARGUMENTS.ID#"/>
    </cfinvoke>
    <cfinvoke 
    component="MCMS.component.app.auction.Auction"
    method="deleteAuctionDepartmentRel"
    returnvariable="deleteAuctionDepartmentRelRet">
    <cfinvokeargument name="aID" value="#ARGUMENTS.ID#"/>
    </cfinvoke>
    <cfinvoke 
    component="MCMS.component.app.auction.Auction"
    method="deleteAuctionDocumentRel"
    returnvariable="deleteAuctionDocumentRelRet">
    <cfinvokeargument name="aID" value="#ARGUMENTS.ID#"/>
    </cfinvoke>
    <cfcatch type="any">
    <cfset result.message = "There was an error deleting the record(s).">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="deleteAuctionItem" access="public" returntype="struct">
    <cfargument name="ID" type="string" required="yes" default="0">
    <cfargument name="aID" type="string" required="yes" default="0">
    <cfset result.message = "You have successfully deleted the record(s).">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    DELETE FROM tbl_auction_item
    WHERE ID IN (<cfqueryparam cfsqltype="cf_sql_integer" list="yes" value="#ARGUMENTS.ID#">)
    OR aID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.aID#">
    </cfquery>
    </cftransaction>
    <cfinvoke 
    component="MCMS.component.app.auction.Auction"
    method="deleteAuctionBid"
    returnvariable="deleteAuctionBidRet">
    <cfinvokeargument name="aiID" value="#ARGUMENTS.ID#"/>
    </cfinvoke>
    <cfinvoke 
    component="MCMS.component.app.auction.Auction"
    method="deleteAuctionItemAttrValue"
    returnvariable="deleteAuctionItemAttrValueRet">
    <cfinvokeargument name="aiID" value="#ARGUMENTS.ID#"/>
    </cfinvoke>
    <cfcatch type="any">
    <cfset result.message = "There was an error deleting the record(s).">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="deleteAuctionItemAttr" access="public" returntype="struct">
    <cfargument name="ID" type="string" required="yes">
    <cfset result.message = "You have successfully deleted the record(s).">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    DELETE FROM tbl_auction_item_attribute
    WHERE ID IN (<cfqueryparam cfsqltype="cf_sql_integer" list="yes" value="#ARGUMENTS.ID#">)
    </cfquery>
    </cftransaction>
    <cfinvoke 
    component="MCMS.component.app.auction.Auction"
    method="deleteAuctionItemAttrValue"
    returnvariable="deleteAuctionItemAttrValueRet">
    <cfinvokeargument name="aiaID" value="#ARGUMENTS.ID#"/>
    </cfinvoke>
    <cfcatch type="any">
    <cfset result.message = "There was an error deleting the record(s).">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="deleteAuctionItemAttrValue" access="public" returntype="struct">
    <cfargument name="ID" type="string" required="yes" default="0">
    <cfargument name="aiID" type="string" required="yes" default="0">
    <cfargument name="aiaID" type="string" required="yes" default="0">
    <cfset result.message = "You have successfully deleted the record(s).">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    DELETE FROM tbl_auction_item_attr_value
    WHERE ID IN (<cfqueryparam cfsqltype="cf_sql_integer" list="yes" value="#ARGUMENTS.ID#">)
    OR aiID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.aiID#">
    OR aiaID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.aiaID#">
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error deleting the record(s).">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="deleteAuctionBid" access="public" returntype="struct">
    <cfargument name="ID" type="string" required="yes" default="0">
    <cfargument name="aID" type="string" required="yes" default="0">
    <cfargument name="aiID" type="string" required="yes" default="0">
    <cfset result.message = "You have successfully deleted the record(s).">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    DELETE FROM tbl_auction_bid
    WHERE ID IN (<cfqueryparam cfsqltype="cf_sql_integer" list="yes" value="#ARGUMENTS.ID#">)
    OR aID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.aID#">
    OR aiID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.aiID#">
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error deleting the record(s).">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>    
    
    <cffunction name="deleteAuctionItemGrade" access="public" returntype="struct">
    <cfargument name="ID" type="string" required="yes">
    <cfset result.message = "You have successfully deleted the record(s).">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    DELETE FROM tbl_auction_item_grade
    WHERE ID IN (<cfqueryparam cfsqltype="cf_sql_integer" list="yes" value="#ARGUMENTS.ID#">)
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error deleting the record(s).">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction> 
    
    <cffunction name="deleteAuctionSiteRel" access="public" returntype="struct">
    <cfargument name="ID" type="string" required="yes" default="0">
    <cfargument name="aID" type="string" required="yes" default="0">
    <cfset result.message = "You have successfully deleted the record(s).">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    DELETE FROM tbl_auction_site_rel
    WHERE ID IN (<cfqueryparam cfsqltype="cf_sql_integer" list="yes" value="#ARGUMENTS.ID#">)
    OR aID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.aID#">
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error deleting the record(s).">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction> 
    
    <cffunction name="deleteAuctionDepartmentRel" access="public" returntype="struct">
    <cfargument name="ID" type="string" required="yes" default="0">
    <cfargument name="aID" type="string" required="yes" default="0">
    <cfset result.message = "You have successfully deleted the record(s).">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    DELETE FROM tbl_auction_department_rel
    WHERE ID IN (<cfqueryparam cfsqltype="cf_sql_integer" list="yes" value="#ARGUMENTS.ID#">)
    OR aID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.aID#">
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error deleting the record(s).">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction> 
    
    <cffunction name="deleteAuctionDocumentRel" access="public" returntype="struct">
    <cfargument name="ID" type="string" required="yes" default="0">
    <cfargument name="aID" type="string" required="yes" default="0">
    <cfset result.message = "You have successfully deleted the record(s).">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    DELETE FROM tbl_auction_document_rel
    WHERE ID IN (<cfqueryparam cfsqltype="cf_sql_integer" list="yes" value="#ARGUMENTS.ID#">)
    OR aID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.aID#">
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error deleting the record(s).">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="deleteAuctionItemImageRel" access="public" returntype="struct">
    <cfargument name="ID" type="string" required="yes" default="0">
    <cfargument name="aiID" type="string" required="yes" default="0">
    <cfset result.message = "You have successfully deleted the record(s).">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    DELETE FROM tbl_auction_item_image_rel
    WHERE ID IN (<cfqueryparam cfsqltype="cf_sql_integer" list="yes" value="#ARGUMENTS.ID#">)
    OR aiID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.aiID#">
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error deleting the record(s).">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>   
</cfcomponent>