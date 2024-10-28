<cfcomponent>
    <cffunction name="getEvent" access="public" returntype="any" hint="Get Event data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="siteNo" type="string" required="yes" default="100">
    <cfargument name="deptNo" type="string" required="yes" default="0">
    <cfargument name="ID" type="numeric" required="yes" default="0">
    <cfargument name="excludeID" type="numeric" required="yes" default="0">
    <cfargument name="evtName" type="string" required="yes" default="">
    <cfargument name="evtID" type="string" required="yes" default="0">
    <cfargument name="evttStatus" type="string" required="no" default="1">
    <cfargument name="evtStatus" type="string" required="yes" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="evtName">
    <cfset var rsEvent = "">
    <cftry>
    <cfquery name="rsEvent" datasource="#application.mcmsDSN#">
    SELECT * FROM v_event WHERE 0=0
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(evtName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(evtDescription) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">)
    </cfif>
    <cfif ARGUMENTS.siteNo NEQ 100>
    AND siteNo IN (<cfqueryparam value="#ARGUMENTS.siteNo#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    <cfif ARGUMENTS.deptNo NEQ 0>
    AND deptNo IN (<cfqueryparam value="0,#ARGUMENTS.deptNo#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    <cfif ARGUMENTS.ID NEQ 0>
    AND ID = <cfqueryparam value="#ARGUMENTS.ID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.excludeID NEQ 0>
    AND ID <> <cfqueryparam value="#ARGUMENTS.excludeID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.evtName NEQ "">
    AND evtName = <cfqueryparam value="#ARGUMENTS.evtName#" cfsqltype="cf_sql_varchar">
    </cfif>
    <cfif ARGUMENTS.evtID NEQ 0>
    AND evtID = <cfqueryparam value="#ARGUMENTS.evtID#" cfsqltype="cf_sql_integer">
    </cfif>
    AND evttStatus IN (<cfqueryparam value="#ARGUMENTS.evttStatus#" list="yes" cfsqltype="cf_sql_integer">)
    AND evtStatus IN (<cfqueryparam value="#ARGUMENTS.evtStatus#" list="yes" cfsqltype="cf_sql_integer">)
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsEvent = StructNew()>
    <cfset rsEvent.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsEvent>
    </cffunction>
    
    <cffunction name="getEventListing" access="public" returntype="any" hint="Get Event Listing data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="siteNo" type="string" required="yes" default="100">
    <cfargument name="deptNo" type="string" required="yes" default="0">
    <cfargument name="dateRange" type="string" required="yes" default="false">
    <cfargument name="evtlDateStart" type="string" required="yes" default="">
    <cfargument name="evtlDateExp" type="string" required="yes" default="">
    <cfargument name="evtlDateStartEQ" type="string" required="yes" default="">
    <cfargument name="evtlDateExpEQ" type="string" required="yes" default="">
    <cfargument name="evtlTimeStart" type="string" required="yes" default="">
    <cfargument name="evtlTimeEnd" type="string" required="yes" default="">
    <cfargument name="ID" type="numeric" required="yes" default="0">
    <cfargument name="excludeID" type="numeric" required="yes" default="0">
    <cfargument name="evtName" type="string" required="yes" default="">
    <cfargument name="evtID" type="string" required="yes" default="0">
    <cfargument name="siteStatus" type="string" required="no" default="1">
    <cfargument name="deptStatus" type="string" required="no" default="1">
    <cfargument name="evtStatus" type="string" required="no" default="1">
    <cfargument name="evtlStatus" type="string" required="yes" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="evtName">
    <cfset var rsEventListing = "">
    <cftry>
    <cfquery name="rsEventListing" datasource="#application.mcmsDSN#">
    SELECT * FROM v_event_listing WHERE 0=0
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(evtName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(evtDescription) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(siteName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">  OR UPPER(siteNo) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(deptName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">)
    </cfif>
    <cfif ARGUMENTS.ID NEQ 0>
    AND ID = <cfqueryparam value="#ARGUMENTS.ID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.excludeID NEQ 0>
    AND ID <> <cfqueryparam value="#ARGUMENTS.excludeID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.siteNo NEQ 100>
    AND siteNo IN (<cfqueryparam value="#ARGUMENTS.siteNo#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    <cfif ARGUMENTS.deptNo NEQ 0>
    AND deptNo IN (<cfqueryparam value="#ARGUMENTS.deptNo#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    <!---Date Range.--->
    <cfif ARGUMENTS.dateRange EQ "true">
    <cfif ARGUMENTS.evtlDateStart NEQ "">
    AND evtlDateStart >= <cfqueryparam value="#ARGUMENTS.evtlDateStart#" cfsqltype="cf_sql_date">
    </cfif>
    <cfif ARGUMENTS.evtlDateExp NEQ "">
    AND evtlDateExp <= <cfqueryparam value="#ARGUMENTS.evtlDateExp#" cfsqltype="cf_sql_date">
	</cfif>
    <cfelse>
    <cfif ARGUMENTS.evtlDateStart NEQ "">
    AND evtlDateStart <= <cfqueryparam value="#ARGUMENTS.evtlDateStart#" cfsqltype="cf_sql_date">
    </cfif>
    <cfif ARGUMENTS.evtlDateExp NEQ "">
    AND evtlDateExp >= <cfqueryparam value="#ARGUMENTS.evtlDateExp#" cfsqltype="cf_sql_date">
	</cfif>
    </cfif>
    <cfif ARGUMENTS.evtlDateStartEQ NEQ "">
    AND evtlDateStart = <cfqueryparam value="#ARGUMENTS.evtlDateStartEQ#" cfsqltype="cf_sql_date">
    </cfif>
    <cfif ARGUMENTS.evtlDateExpEQ NEQ "">
    AND evtlDateExp = <cfqueryparam value="#ARGUMENTS.evtlDateExpEQ#" cfsqltype="cf_sql_date">
	</cfif>
    <cfif ARGUMENTS.evtlTimeStart NEQ "">
    AND evtlTimeStart = <cfqueryparam value="#ARGUMENTS.evtlTimeStart#" cfsqltype="cf_sql_varchar">
    </cfif>
    <cfif ARGUMENTS.evtlTimeEnd NEQ "">
    AND evtlTimeEnd = <cfqueryparam value="#ARGUMENTS.evtlTimeEnd#" cfsqltype="cf_sql_varchar">
    </cfif>
    <cfif ARGUMENTS.evtName NEQ "">
    AND evtName = <cfqueryparam value="#ARGUMENTS.evtName#" cfsqltype="cf_sql_varchar">
    </cfif>
    <cfif ARGUMENTS.evtID NEQ 0>
    AND evtID = <cfqueryparam value="#ARGUMENTS.evtID#" cfsqltype="cf_sql_integer">
    </cfif>
    AND siteStatus IN (<cfqueryparam value="#ARGUMENTS.siteStatus#" list="yes" cfsqltype="cf_sql_integer">)
    AND (deptStatus IN (<cfqueryparam value="#ARGUMENTS.deptStatus#" list="yes" cfsqltype="cf_sql_integer">) OR deptStatus IS NULL)
    AND evtStatus IN (<cfqueryparam value="#ARGUMENTS.evtStatus#" list="yes" cfsqltype="cf_sql_integer">)
    AND evtlStatus IN (<cfqueryparam value="#ARGUMENTS.evtlStatus#" list="yes" cfsqltype="cf_sql_integer">)
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsEventListing = StructNew()>
    <cfset rsEventListing.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsEventListing>
    </cffunction>
    
    <cffunction name="getEventBind" access="remote" returntype="string" output="yes">
    <cfargument name="keywords" type="string" required="yes" default="">
    <cfargument name="siteNo" type="string" required="yes" default="100">
    <cfargument name="evtStatus" type="string" required="yes" default="1">
    <cfargument name="orderBy" type="string" required="yes" default="evtName">
    <cfset var rsBind = "" >
    <cfset this.siteNo = Replace(ARGUMENTS.siteNo, "|", ",", "All")>
    <cfquery name="rsBind" datasource="#application.mcmsDSN#">
    SELECT '(' || siteNo || ') ' || evtName AS evtName FROM v_event WHERE 0=0
    AND UPPER(evtName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">
    <cfif ARGUMENTS.siteNo NEQ 100>
    AND siteNo IN (<cfqueryparam value="#this.siteNo#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    AND evtStatus IN (<cfqueryparam value="#ARGUMENTS.evtStatus#" list="yes" cfsqltype="cf_sql_tinyint">)
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <cfif rsBind.recordcount NEQ 0>
    <cfset IDList = ValueList(rsBind.evtName, ',') & ",none">
    <cfelse>
    <cfset IDList = ''>
    </cfif>
    <cfreturn IDList>
    </cffunction>
    
    <cffunction name="getEventDocument" access="public" returntype="any" hint="Get Event Document data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="siteNo" type="string" required="yes" default="100">
    <cfargument name="deptNo" type="string" required="yes" default="0">
    <cfargument name="ID" type="numeric" required="yes" default="0">
    <cfargument name="excludeID" type="numeric" required="yes" default="0">
    <cfargument name="evtName" type="string" required="yes" default="">
    <cfargument name="evtID" type="string" required="yes" default="0">
    <cfargument name="docID" type="string" required="yes" default="0">
    <cfargument name="docDateRel" type="string" required="yes" default="">
    <cfargument name="docDateExp" type="string" required="yes" default="">
    <cfargument name="evtStatus" type="string" required="no" default="1">
    <cfargument name="docStatus" type="string" required="no" default="1">
    <cfargument name="evtdrStatus" type="string" required="yes" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="evtName">
    <cfset var rsEventDocument = "">
    <cftry>
    <cfquery name="rsEventDocument" datasource="#application.mcmsDSN#">
    SELECT * FROM v_event_document_rel WHERE 0=0
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(evtName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(docDescription) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">)
    </cfif>
    <cfif ARGUMENTS.siteNo NEQ 100>
    AND siteNo IN (<cfqueryparam value="#ARGUMENTS.siteNo#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    <cfif ARGUMENTS.deptNo NEQ 0>
    AND deptNo IN (<cfqueryparam value="#ARGUMENTS.deptNo#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    <cfif ARGUMENTS.ID NEQ 0>
    AND ID = <cfqueryparam value="#ARGUMENTS.ID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.excludeID NEQ 0>
    AND ID <> <cfqueryparam value="#ARGUMENTS.excludeID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.evtName NEQ "">
    AND evtName = <cfqueryparam value="#ARGUMENTS.evtName#" cfsqltype="cf_sql_varchar">
    </cfif>
    <cfif ARGUMENTS.docDateRel NEQ "">
    AND docDateRel <= <cfqueryparam value="#ARGUMENTS.docDateRel#" cfsqltype="cf_sql_date">
    </cfif>
    <cfif ARGUMENTS.docDateExp NEQ "">
    AND docDateExp >= <cfqueryparam value="#ARGUMENTS.docDateExp#" cfsqltype="cf_sql_date">
    </cfif>
    <cfif ARGUMENTS.evtID NEQ 0>
    AND evtID = <cfqueryparam value="#ARGUMENTS.evtID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.docID NEQ 0>
    AND docID = <cfqueryparam value="#ARGUMENTS.docID#" cfsqltype="cf_sql_integer">
    </cfif>
    AND evtStatus IN (<cfqueryparam value="#ARGUMENTS.evtStatus#" list="yes" cfsqltype="cf_sql_integer">)
    AND docStatus IN (<cfqueryparam value="#ARGUMENTS.docStatus#" list="yes" cfsqltype="cf_sql_integer">)
    AND evtdrStatus IN (<cfqueryparam value="#ARGUMENTS.evtdrStatus#" list="yes" cfsqltype="cf_sql_integer">)
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsEventDocument = StructNew()>
    <cfset rsEventDocument.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsEventDocument>
    </cffunction>
    
    <cffunction name="getEventImage" access="public" returntype="any" hint="Get Event Image data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="ID" type="numeric" required="yes" default="0">
    <cfargument name="excludeID" type="numeric" required="yes" default="0">
    <cfargument name="evtName" type="string" required="yes" default="">
    <cfargument name="evtID" type="string" required="yes" default="0">
    <cfargument name="imgID" type="string" required="yes" default="0">
    <cfargument name="evtStatus" type="string" required="no" default="1">
    <cfargument name="imgtStatus" type="string" required="no" default="1">
    <cfargument name="imgStatus" type="string" required="no" default="1">
    <cfargument name="evtirStatus" type="string" required="yes" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="evtName">
    <cfset var rsEventImage = "">
    <cftry>
    <cfquery name="rsEventImage" datasource="#application.mcmsDSN#">
    SELECT * FROM v_event_image_rel WHERE 0=0
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(evtName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(imgName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">)
    </cfif>
    <cfif ARGUMENTS.ID NEQ 0>
    AND ID = <cfqueryparam value="#ARGUMENTS.ID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.excludeID NEQ 0>
    AND ID <> <cfqueryparam value="#ARGUMENTS.excludeID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.evtName NEQ "">
    AND evtName = <cfqueryparam value="#ARGUMENTS.evtName#" cfsqltype="cf_sql_varchar">
    </cfif>
    <cfif ARGUMENTS.evtID NEQ 0>
    AND evtID = <cfqueryparam value="#ARGUMENTS.evtID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.imgID NEQ 0>
    AND imgID = <cfqueryparam value="#ARGUMENTS.imgID#" cfsqltype="cf_sql_integer">
    </cfif>
    AND evtStatus IN (<cfqueryparam value="#ARGUMENTS.evtStatus#" list="yes" cfsqltype="cf_sql_integer">)
    AND imgtStatus IN (<cfqueryparam value="#ARGUMENTS.imgtStatus#" list="yes" cfsqltype="cf_sql_integer">)
    AND imgStatus IN (<cfqueryparam value="#ARGUMENTS.imgStatus#" list="yes" cfsqltype="cf_sql_integer">)
    AND evtirStatus IN (<cfqueryparam value="#ARGUMENTS.evtirStatus#" list="yes" cfsqltype="cf_sql_integer">)
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsEventImage = StructNew()>
    <cfset rsEventImage.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsEventImage>
    </cffunction>
    
    <cffunction name="getEventReport" access="public" returntype="query" hint="Get Event Report data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
	  <cfargument name="siteNo" type="string" required="yes" default="100">
    <cfargument name="deptNo" type="string" required="yes" default="0">
    <cfargument name="orderBy" type="string" required="yes" default="evtName">
    <cfset var rsEvent = "" >
    <cfquery name="rsEvent" datasource="#application.mcmsDSN#">
    SELECT evtName AS Name, TO_CHAR(evtDescription) AS Description, siteName AS Site, deptName AS Department, sName AS Status FROM v_event WHERE 0=0
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(evtName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(evtDescription) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">)
    </cfif>
    <cfif ARGUMENTS.siteNo NEQ 100>
    AND siteNo IN (<cfqueryparam value="#ARGUMENTS.siteNo#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    <cfif ARGUMENTS.deptNo NEQ 0>
    AND deptNo IN (<cfqueryparam value="#ARGUMENTS.deptNo#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <cfreturn rsEvent>
    </cffunction>
    
    <cffunction name="getEventListingReport" access="public" returntype="query" hint="Get Event Listing Report data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
	  <cfargument name="siteNo" type="string" required="yes" default="100">
    <cfargument name="deptNo" type="string" required="yes" default="0">
    <cfargument name="orderBy" type="string" required="yes" default="evtName">
    <cfset var rsEvent = "" >
    <cfquery name="rsEvent" datasource="#application.mcmsDSN#">
    SELECT evtName AS Name, siteName AS Site, TO_CHAR(evtlDateRel,'MM/DD/YYYY') AS Release_Date, TO_CHAR(evtlDateStart,'MM/DD/YYYY') AS Start_Date, TO_CHAR(evtlDateExp,'MM/DD/YYYY') AS Expiration_Date, evtlTimeStart AS Time_Start, evtlTimeEnd As Time_End, sName AS Status FROM v_event_listing WHERE 0=0
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(evtName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(evtDescription) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">)
    </cfif>
    <cfif ARGUMENTS.siteNo NEQ 100>
    AND siteNo IN (<cfqueryparam value="#ARGUMENTS.siteNo#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    <cfif ARGUMENTS.deptNo NEQ 0>
    AND deptNo IN (<cfqueryparam value="#ARGUMENTS.deptNo#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <cfreturn rsEvent>
    </cffunction>
    
    <cffunction name="getEventListingExcelQuickReport" access="public" returntype="query" hint="Get Event Listing Excel Quick Report data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="evtStatus" type="string" required="no" default="1,3">
    <cfargument name="evtlStatus" type="string" required="yes" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="evtName">
    <cfset var rsEventListingExcelQuickReport = "" >
    <cftry>
    <cfquery name="rsEventListingExcelQuickReport" datasource="#application.mcmsDSN#">
    SELECT evtName AS Name, siteName AS Site, TO_CHAR(evtlDateRel,'MM/DD/YYYY') AS Release_Date, TO_CHAR(evtlDateStart,'MM/DD/YYYY') AS Start_Date, TO_CHAR(evtlDateExp,'MM/DD/YYYY') AS Expiration_Date, evtlTimeStart AS Time_Start, evtlTimeEnd As Time_End, sName AS Status FROM v_event_listing WHERE 0=0
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(evtName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(evtDescription) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">)
    </cfif>
    AND evtlDateExp >= <cfqueryparam value="#Now()#" cfsqltype="cf_sql_date">
    AND evtStatus IN (<cfqueryparam value="#ARGUMENTS.evtStatus#" list="yes" cfsqltype="cf_sql_integer">)
    AND evtlStatus IN (<cfqueryparam value="#ARGUMENTS.evtlStatus#" list="yes" cfsqltype="cf_sql_integer">)
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsEventListingExcelQuickReport = StructNew()>
    <cfset rsEventListingExcelQuickReport.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsEventListingExcelQuickReport>
    </cffunction>
    
    <cffunction name="getEventDocumentReport" access="public" returntype="query" hint="Get Event Document Report data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
	  <cfargument name="siteNo" type="string" required="yes" default="100">
    <cfargument name="deptNo" type="string" required="yes" default="0">
    <cfargument name="orderBy" type="string" required="yes" default="evtName">
    <cfset var rsEvent = "" >
    <cfquery name="rsEvent" datasource="#application.mcmsDSN#">
    SELECT docName AS Doc_Name, evtName AS Event_Name, docDescription AS Doc_Description, docFile AS Doc_File, TO_CHAR(docDateExp,'MM/DD/YYYY') AS Doc_Date, TO_CHAR(docDateExp,'MM/DD/YYYY') AS Expiration_Date, sName AS Status FROM v_event_document_rel WHERE 0=0
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(docName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(docDescription) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">)
    </cfif>
    <cfif ARGUMENTS.siteNo NEQ 100>
    AND siteNo IN (<cfqueryparam value="#ARGUMENTS.siteNo#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    <cfif ARGUMENTS.deptNo NEQ 0>
    AND deptNo IN (<cfqueryparam value="#ARGUMENTS.deptNo#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <cfreturn rsEvent>
    </cffunction>
    
    <cffunction name="getEventImageReport" access="public" returntype="query" hint="Get Event Image Report data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="orderBy" type="string" required="yes" default="evtName">
    <cfset var rsEvent = "" >
    <cfquery name="rsEvent" datasource="#application.mcmsDSN#">
    SELECT imgName AS Image_Name, evtName AS Event_Name, imgFile AS Image_File, imgtWidth AS Image_Width, sname AS Status FROM v_event_image_rel WHERE 0=0
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(evtName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(imgName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">)
    </cfif>
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <cfreturn rsEvent>
    </cffunction>
    
    <cffunction name="insertEvent" access="public" returntype="struct">
    <cfargument name="evtName" type="string" required="yes">
    <cfargument name="evtDescription" type="string" required="yes">
    <cfargument name="siteNo" type="numeric" required="yes">
    <cfargument name="deptNo" type="numeric" required="yes">
    <cfargument name="evtStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully inserted the record.">
    <cftry>
    <!---Check for profanity in the text.--->
    <cfinvoke 
    component="MCMS.component.utility.Regex"
    method="regexProfanity"
    returnvariable="regexProfanityRet">
    <cfinvokeargument name="profanityString" value="#ARGUMENTS.evtDescription#"/>
    </cfinvoke>
    <!---Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.app.event.Event"
    method="getEvent"
    returnvariable="getCheckEventRet">
    <cfinvokeargument name="siteNo" value="#ARGUMENTS.siteNo#"/>
    <cfinvokeargument name="evtName" value="#ARGUMENTS.evtName#"/>
    <cfinvokeargument name="evtStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckEventRet.recordcount NEQ 0>
    <cfset result.message = "The name #ARGUMENTS.evtName# already exists, please try again.">
    <cfelseif regexProfanityRet CONTAINS '$%&*!'>
    <cfset result.message = "Some text contained profanity, please remove any profanity from your text.">
    <!---Check length restriction.--->
    <cfelseif LEN(ARGUMENTS.evtDescription) GT 2048>
    <cfset result.message = "The description is longer than 2048 characters, please enter a new description under 2048 characters.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    INSERT INTO tbl_event (evtName,evtDescription,siteNo,deptNo,evtStatus) VALUES
    (
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.evtName#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.evtDescription#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.siteNo#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.deptNo#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.evtStatus#">
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
    
    <cffunction name="insertEventListing" access="public" returntype="struct">
    <cfargument name="evtName" type="string" required="yes">
    <cfargument name="siteNo" type="numeric" required="yes">
    <cfargument name="evtlInformation" type="string" required="yes">
    <cfargument name="evtlDateStart" type="date" required="yes">
    <cfargument name="evtlDateRel" type="date" required="yes">
    <cfargument name="evtlDateExp" type="date" required="yes">
    <cfargument name="evtlTimeStart" type="string" required="yes">
    <cfargument name="evtlTimeEnd" type="string" required="yes">
    <cfargument name="evtlContactName" type="string" required="yes">
    <cfargument name="evtlTelephone" type="string" required="yes">
    <cfargument name="evtlEmail" type="string" required="yes">
    <cfargument name="evtlStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully inserted the record.">
    <cftry>
    <!---Check for profanity in the text.--->
    <cfinvoke 
    component="MCMS.component.utility.Regex"
    method="regexProfanity"
    returnvariable="regexProfanityRet">
    <cfinvokeargument name="profanityString" value="#ARGUMENTS.evtlInformation#"/>
    </cfinvoke>
    <!---Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.app.event.Event"
    method="getEventListing"
    returnvariable="getCheckEventRet">
    <cfinvokeargument name="evtName" value="#Replace(ARGUMENTS.evtName, '(#ARGUMENTS.siteNo#) ', '', 'All')#"/>
    <cfinvokeargument name="siteNo" value="#ARGUMENTS.siteNo#"/>
    <cfinvokeargument name="evtlDateRelEQ" value="#ARGUMENTS.evtlDateRel#"/>
    <cfinvokeargument name="evtlDateExpEQ" value="#ARGUMENTS.evtlDateExp#"/>
    <cfinvokeargument name="evtlTimeStart" value="#ARGUMENTS.evtlTimeStart#"/>
    <cfinvokeargument name="evtlTimeEnd" value="#ARGUMENTS.evtlTimeEnd#"/>
    <cfinvokeargument name="evtStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckEventRet.recordcount NEQ 0>
    <cfset result.message = "The event listing already exists for these dates, please try again.">
    <cfelseif regexProfanityRet CONTAINS '$%&*!'>
    <cfset result.message = "Some text contained profanity, please remove any profanity from your text.">
    <!---Check length restriction.--->
    <cfelseif LEN(ARGUMENTS.evtlInformation) GT 2048>
    <cfset result.message = "The information is longer than 2048 characters, please enter a new information under 2048 characters.">
    <cfelse>
    <!---Get the evtID.--->
    <cfinvoke 
    component="MCMS.component.app.event.Event"
    method="getEvent"
    returnvariable="getEventIDRet">
    <cfinvokeargument name="siteNo" value="#ARGUMENTS.siteNo#"/>
    <cfinvokeargument name="evtName" value="#Replace(ARGUMENTS.evtName, '(#ARGUMENTS.siteNo#) ', '', 'All')#"/>
    <cfinvokeargument name="evtStatus" value="1,3"/>
    </cfinvoke>
    <cfif getEventIDRet.recordcount NEQ 0>
    <cfset this.evtID = getEventIDRet.ID>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    INSERT INTO tbl_event_listing (evtID, siteNo, evtlInformation, evtlDateStart, evtlDateRel, evtlDateExp, evtlTimeStart, evtlTimeEnd, evtlContactName, evtlTelephone, evtlEmail, evtlStatus) VALUES
    (
    <cfqueryparam cfsqltype="cf_sql_integer" value="#this.evtID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.siteNo#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.evtlInformation#">,
    <cfqueryparam cfsqltype="cf_sql_date" value="#ARGUMENTS.evtlDateStart#">,
    <cfqueryparam cfsqltype="cf_sql_date" value="#ARGUMENTS.evtlDateRel#">,
    <cfqueryparam cfsqltype="cf_sql_date" value="#ARGUMENTS.evtlDateExp#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.evtlTimeStart#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.evtlTimeEnd#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.evtlContactName#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.evtlTelephone#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.evtlEmail#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.evtlStatus#">
    )
    </cfquery>
    </cftransaction>
    <cfelse>
    <cfset result.message = "There was an error inserting the record when applying the Event ID. Please check that the Event Name has been correctly selected.">
    </cfif>
    </cfif>
    <cfcatch type="any">
    <cfset result.message = "There was an error inserting the record.">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="insertEventDocument" access="public" returntype="struct">
    <cfargument name="evtID" type="numeric" required="yes">
    <cfargument name="docID" type="numeric" required="yes">
    <cfargument name="evtdrStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully inserted the document.">
    <cftry>
    <cfinvoke 
    component="MCMS.component.app.event.Event"
    method="getEventDocument"
    returnvariable="getCheckEventRet">
    <cfinvokeargument name="evtID" value="#ARGUMENTS.evtID#"/>
    <cfinvokeargument name="docID" value="#ARGUMENTS.docID#"/>
    <cfinvokeargument name="evtdrStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckEventRet.recordcount NEQ 0>
    <cfset result.message = "The event document relationship already exists, please try again.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    INSERT INTO tbl_event_document_rel (evtID,docID,evtdrStatus) VALUES
    (
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.evtID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.docID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.evtdrStatus#">
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
    
    <cffunction name="insertEventImage" access="public" returntype="struct">
    <cfargument name="evtID" type="numeric" required="yes">
    <cfargument name="imgID" type="numeric" required="yes">
    <cfargument name="evtirStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully inserted the image.">
    <cftry>
    <cfinvoke 
    component="MCMS.component.app.event.Event"
    method="getEventImage"
    returnvariable="getCheckEventRet">
    <cfinvokeargument name="evtID" value="#ARGUMENTS.evtID#"/>
    <cfinvokeargument name="imgID" value="#ARGUMENTS.imgID#"/>
    <cfinvokeargument name="evtirStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckEventRet.recordcount NEQ 0>
    <cfset result.message = "The event image relationship already exists, please try again.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    INSERT INTO tbl_event_image_rel (evtID,imgID,evtirStatus) VALUES
    (
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.evtID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.imgID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.evtirStatus#">
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

    <cffunction name="updateEvent" access="public" returntype="struct">
    <cfargument name="ID" type="numeric" required="yes">
    <cfargument name="evtName" type="string" required="yes">
    <cfargument name="evtDescription" type="string" required="yes">
    <cfargument name="siteNo" type="numeric" required="yes">
    <cfargument name="deptNo" type="numeric" required="yes">
    <cfargument name="evtStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully updated the record.">
    <cftry>
    <!---Check for profanity in the text.--->
    <cfinvoke 
    component="MCMS.component.utility.Regex"
    method="regexProfanity"
    returnvariable="regexProfanityRet">
    <cfinvokeargument name="profanityString" value="#ARGUMENTS.evtDescription#"/>
    </cfinvoke>
    <!---Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.app.event.Event"
    method="getEvent"
    returnvariable="getCheckEventRet">
    <cfinvokeargument name="excludeID" value="#ARGUMENTS.ID#"/>
    <cfinvokeargument name="siteNo" value="#ARGUMENTS.siteNo#"/>
    <cfinvokeargument name="evtName" value="#ARGUMENTS.evtName#"/>
    <cfinvokeargument name="evtStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckEventRet.recordcount NEQ 0>
    <cfset result.message = "The name #ARGUMENTS.evtName# already exists, please try again.">
    <cfelseif regexProfanityRet CONTAINS '$%&*!'>
    <cfset result.message = "Some text contained profanity, please remove any profanity from your text.">
    <!---Check length restriction.--->
    <cfelseif LEN(ARGUMENTS.evtDescription) GT 2048>
    <cfset result.message = "The description is longer than 2048 characters, please enter a new description under 2048 characters.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_event SET
    evtName = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.evtName#">,
    evtDescription = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.evtDescription#">,
    siteNo = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.siteNo#">,
    deptNo = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.deptNo#">,
    evtStatus = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.evtStatus#">
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
    
    <cffunction name="updateEventListing" access="public" returntype="struct">
    <cfargument name="ID" type="numeric" required="yes">
    <cfargument name="evtlInformation" type="string" required="yes">
    <cfargument name="evtlDateStart" type="date" required="yes">
    <cfargument name="evtlDateRel" type="date" required="yes">
    <cfargument name="evtlDateExp" type="date" required="yes">
    <cfargument name="evtlTimeStart" type="string" required="yes">
    <cfargument name="evtlTimeEnd" type="string" required="yes">
    <cfargument name="evtlContactName" type="string" required="yes">
    <cfargument name="evtlTelephone" type="string" required="yes">
    <cfargument name="evtlEmail" type="string" required="yes">
    <cfargument name="evtlStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully updated the record.">
    <cftry>
    <!---Check for profanity in the text.--->
    <cfinvoke 
    component="MCMS.component.utility.Regex"
    method="regexProfanity"
    returnvariable="regexProfanityRet">
    <cfinvokeargument name="profanityString" value="#ARGUMENTS.evtlInformation#"/>
    </cfinvoke>
    <!---Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.app.event.Event"
    method="getEventListing"
    returnvariable="getCheckEventRet">
    <cfinvokeargument name="excludeID" value="#ARGUMENTS.ID#"/>
    <cfinvokeargument name="evtlDateRelEQ" value="#ARGUMENTS.evtlDateRel#"/>
    <cfinvokeargument name="evtlDateExpEQ" value="#ARGUMENTS.evtlDateExp#"/>
    <cfinvokeargument name="evtlTimeStart" value="#ARGUMENTS.evtlTimeStart#"/>
    <cfinvokeargument name="evtlTimeEnd" value="#ARGUMENTS.evtlTimeEnd#"/>
    <cfinvokeargument name="evtlStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckEventRet.recordcount NEQ 0>
    <cfset result.message = "The event listing already exists for these dates, please try again.">
    <cfelseif regexProfanityRet CONTAINS '$%&*!'>
    <cfset result.message = "Some text contained profanity, please remove any profanity from your text.">
    <!---Check length restriction.--->
    <cfelseif LEN(ARGUMENTS.evtlInformation) GT 2048>
    <cfset result.message = "The infomation is longer than 2048 characters, please enter a new information under 2048 characters.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_event_listing SET
    evtlInformation = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.evtlInformation#">,
    evtlDateStart = <cfqueryparam cfsqltype="cf_sql_date" value="#ARGUMENTS.evtlDateStart#">,
    evtlDateRel = <cfqueryparam cfsqltype="cf_sql_date" value="#ARGUMENTS.evtlDateRel#">,
    evtlDateExp = <cfqueryparam cfsqltype="cf_sql_date" value="#ARGUMENTS.evtlDateExp#">,
    evtlTimeStart = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.evtlTimeStart#">,
    evtlTimeEnd = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.evtlTimeEnd#">,
    evtlContactName = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.evtlContactName#">,
    evtlTelephone = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.evtlTelephone#">,
    evtlEmail = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.evtlEmail#">,
    evtlStatus = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.evtlStatus#">
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
    
    <cffunction name="updateEventDocument" access="public" returntype="struct">
    <cfargument name="ID" type="numeric" required="yes">
    <cfargument name="evtID" type="numeric" required="yes">
    <cfargument name="docID" type="numeric" required="yes">
    <cfargument name="evtdrStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully updated the record.">
    <cftry>
    <cfinvoke 
    component="MCMS.component.app.event.Event"
    method="getEventDocument"
    returnvariable="getCheckEventRet">
    <cfinvokeargument name="excludeID" value="#ARGUMENTS.ID#"/>
    <cfinvokeargument name="evtID" value="#ARGUMENTS.evtID#"/>
    <cfinvokeargument name="docID" value="#ARGUMENTS.docID#"/>
    <cfinvokeargument name="evtdrStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckEventRet.recordcount NEQ 0>
    <cfset result.message = "The event document relationship already exists, please try again.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_event_document_rel SET
    docID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.docID#">,
    evtdrStatus = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.evtdrStatus#">
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
    
    <cffunction name="updateEventImage" access="public" returntype="struct">
    <cfargument name="ID" type="numeric" required="yes">
    <cfargument name="evtID" type="numeric" required="yes">
    <cfargument name="imgID" type="numeric" required="yes">
    <cfargument name="evtirStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully updated the record.">
    <cftry>
    <cfinvoke 
    component="MCMS.component.app.event.Event"
    method="getEventImage"
    returnvariable="getCheckEventRet">
    <cfinvokeargument name="excludeID" value="#ARGUMENTS.ID#"/>
    <cfinvokeargument name="evtID" value="#ARGUMENTS.evtID#"/>
    <cfinvokeargument name="imgID" value="#ARGUMENTS.imgID#"/>
    <cfinvokeargument name="evtirStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckEventRet.recordcount NEQ 0>
    <cfset result.message = "The event image relationship already exists, please try again.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_event_image_rel SET
    imgID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.imgID#">,
    evtirStatus = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.evtirStatus#">
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
    
    <cffunction name="updateEventList" access="public" returntype="struct">
    <cfargument name="ID" type="numeric" required="yes">
    <cfargument name="evtStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully updated the records.">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_event SET
    evtStatus = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.evtStatus#">
    WHERE ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ID#">
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error updating the records.">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="updateEventListingList" access="public" returntype="struct">
    <cfargument name="ID" type="numeric" required="yes">
    <cfargument name="evtlStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully updated the records.">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_event_listing SET
    evtlStatus = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.evtlStatus#">
    WHERE ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ID#">
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error updating the records.">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="updateEventDocumentList" access="public" returntype="struct">
    <cfargument name="ID" type="numeric" required="yes">
    <cfargument name="evtdrStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully updated the records.">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_event_document_rel SET
    evtdrStatus = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.evtdrStatus#">
    WHERE ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ID#">
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error updating the records.">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="updateEventImageList" access="public" returntype="struct">
    <cfargument name="ID" type="numeric" required="yes">
    <cfargument name="evtirStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully updated the records.">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_event_image_rel SET
    evtirStatus = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.evtirStatus#">
    WHERE ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ID#">
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error updating the records.">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="deleteEvent" access="public" returntype="struct">
    <cfargument name="ID" type="string" required="yes">
    <cfset result.message = "You have successfully deleted the record(s).">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    DELETE FROM tbl_event
    WHERE ID IN (<cfqueryparam cfsqltype="cf_sql_integer" list="yes" value="#ARGUMENTS.ID#">)
    </cfquery>
    </cftransaction>
    <cfinvoke 
    component="MCMS.component.app.event.Event"
    method="deleteEventListing"
    returnvariable="deleteEventListingRet">
    <cfinvokeargument name="evtID" value="#ARGUMENTS.ID#"/>
    </cfinvoke>
    <cfinvoke 
    component="MCMS.component.app.event.Event"
    method="deleteEventDocument"
    returnvariable="deleteEventDocumentRet">
    <cfinvokeargument name="evtID" value="#ARGUMENTS.ID#"/>
    </cfinvoke>
    <cfinvoke 
    component="MCMS.component.app.event.Event"
    method="deleteEventImage"
    returnvariable="deleteEventImageRet">
    <cfinvokeargument name="evtID" value="#ARGUMENTS.ID#"/>
    </cfinvoke>
    <cfcatch type="any">
    <cfset result.message = "There was an error deleting the record(s).">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="deleteEventListing" access="public" returntype="struct">
    <cfargument name="ID" type="string" required="yes" default="0">
    <cfargument name="evtID" type="numeric" required="yes" default="0">
    <cfset result.message = "You have successfully deleted the record(s).">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    DELETE FROM tbl_event_listing
    WHERE ID IN (<cfqueryparam cfsqltype="cf_sql_integer" list="yes" value="#ARGUMENTS.ID#">)
    OR evtID IN (<cfqueryparam cfsqltype="cf_sql_integer" list="yes" value="#ARGUMENTS.evtID#">)
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error deleting the record(s).">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>  
    
    <cffunction name="deleteEventDocument" access="public" returntype="struct">
    <cfargument name="ID" type="string" required="yes" default="0">
    <cfargument name="evtID" type="numeric" required="yes" default="0">
    <cfset result.message = "You have successfully deleted the record(s).">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    DELETE FROM tbl_event_document_rel
    WHERE ID IN (<cfqueryparam cfsqltype="cf_sql_integer" list="yes" value="#ARGUMENTS.ID#">)
    OR evtID IN (<cfqueryparam cfsqltype="cf_sql_integer" list="yes" value="#ARGUMENTS.evtID#">)
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error deleting the record(s).">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction> 
    
    <cffunction name="deleteEventImage" access="public" returntype="struct">
    <cfargument name="ID" type="string" required="yes" default="0">
    <cfargument name="evtID" type="numeric" required="yes" default="0">
    <cfset result.message = "You have successfully deleted the record(s).">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    DELETE FROM tbl_event_image_rel
    WHERE ID IN (<cfqueryparam cfsqltype="cf_sql_integer" list="yes" value="#ARGUMENTS.ID#">)
    OR evtID IN ( <cfqueryparam cfsqltype="cf_sql_integer" list="yes" value="#ARGUMENTS.evtID#">)
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error deleting the record(s).">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction> 
</cfcomponent>