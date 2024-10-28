<cfcomponent>
    <cffunction name="getNewsletter" access="public" returntype="query" hint="Get Newsletter data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="ID" type="numeric" required="yes" default="0">
    <cfargument name="excludeID" type="numeric" required="yes" default="0">
    <cfargument name="nName" type="string" required="yes" default="">
    <cfargument name="nDateRel" type="string" required="yes" default="">
    <cfargument name="nDateExp" type="string" required="yes" default="">
    <cfargument name="ntID" type="string" required="yes" default="0">
    <cfargument name="ntStatus" type="string" required="no" default="1,2,3">
    <cfargument name="nStatus" type="string" required="yes" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="nName">
    <cfset var rsNewsletter = "" >
    <cftry>
    <cfquery name="rsNewsletter" datasource="#application.mcmsDSN#">
    SELECT * FROM v_newsletter WHERE 0=0
    <cfif ARGUMENTS.ID NEQ 0>
    AND ID = <cfqueryparam value="#ARGUMENTS.ID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.excludeID NEQ 0>
    AND ID <> <cfqueryparam value="#ARGUMENTS.excludeID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(nName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(nDescription) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">)
    </cfif>
    <cfif ARGUMENTS.nName NEQ "">
    AND UPPER(nName) = <cfqueryparam value="#UCASE(ARGUMENTS.nName)#" cfsqltype="cf_sql_varchar">
    </cfif>
    <cfif ARGUMENTS.nDateRel NEQ "">
    AND nDateRel <= <cfqueryparam value="#ARGUMENTS.nDateRel#" cfsqltype="cf_sql_date">
    </cfif>
    <cfif ARGUMENTS.nDateExp NEQ "">
    AND nDateExp >= <cfqueryparam value="#ARGUMENTS.nDateExp#" cfsqltype="cf_sql_date">
    </cfif>
    <cfif ARGUMENTS.ntID NEQ 0>
    AND ntID = <cfqueryparam value="#ARGUMENTS.ntID#" cfsqltype="cf_sql_integer">
    </cfif>
    AND ntStatus IN (<cfqueryparam value="#ARGUMENTS.ntStatus#" list="yes" cfsqltype="cf_sql_integer">)
    AND nStatus IN (<cfqueryparam value="#ARGUMENTS.nStatus#" list="yes" cfsqltype="cf_sql_integer">)
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsNewsletter = StructNew()>
    <cfset rsNewsletter.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsNewsletter>
    </cffunction>
    
    <cffunction name="getNewsletterTemplate" access="public" returntype="query" hint="Get Newsletter Template data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="ID" type="numeric" required="yes" default="0">
    <cfargument name="excludeID" type="numeric" required="yes" default="0">
    <cfargument name="ntName" type="string" required="yes" default="">
    <cfargument name="ntStatus" type="string" required="no" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="ntName">
    <cfset var rsNewsletterTemplate = "" >
    <cftry>
    <cfquery name="rsNewsletterTemplate" datasource="#application.mcmsDSN#">
    SELECT * FROM tbl_newsletter_template WHERE 0=0
    <cfif ARGUMENTS.ID NEQ 0>
    AND ID = <cfqueryparam value="#ARGUMENTS.ID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.excludeID NEQ 0>
    AND ID <> <cfqueryparam value="#ARGUMENTS.excludeID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(ntName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(ntDescription) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">)
    </cfif>
    <cfif ARGUMENTS.ntName NEQ "">
    AND UPPER(ntName) = <cfqueryparam value="#UCASE(ARGUMENTS.ntName)#" cfsqltype="cf_sql_varchar">
    </cfif>
    AND ntStatus IN (<cfqueryparam value="#ARGUMENTS.ntStatus#" list="yes" cfsqltype="cf_sql_integer">)
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsNewsletterTemplate = StructNew()>
    <cfset rsNewsletterTemplate.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsNewsletterTemplate>
    </cffunction>
    
    <cffunction name="getNewsletterMessage" access="public" returntype="query" hint="Get Newsletter Message data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="ID" type="numeric" required="yes" default="0">
    <cfargument name="excludeID" type="numeric" required="yes" default="0">
    <cfargument name="nID" type="numeric" required="yes" default="0">
    <cfargument name="siteNo" type="string" required="yes" default="100">
    <cfargument name="nDateRel" type="string" required="yes" default="">
    <cfargument name="nDateExp" type="string" required="yes" default="">
    <cfargument name="ntID" type="string" required="yes" default="0">
    <cfargument name="stID" type="string" required="yes" default="1">
    <cfargument name="ntStatus" type="string" required="no" default="1">
    <cfargument name="nStatus" type="string" required="no" default="1">
    <cfargument name="nmStatus" type="string" required="yes" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="nName">
    <cfset var rsNewsletterMessage = "" >
    <cftry>
    <cfquery name="rsNewsletterMessage" datasource="#application.mcmsDSN#">
    SELECT * FROM v_newsletter_message WHERE 0=0
    <cfif ARGUMENTS.ID NEQ 0>
    AND ID = <cfqueryparam value="#ARGUMENTS.ID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.excludeID NEQ 0>
    AND ID <> <cfqueryparam value="#ARGUMENTS.excludeID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(nmMessage) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(nDescription) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(siteName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(siteNo) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">)
    </cfif>
    <cfif ARGUMENTS.nID NEQ 0>
    AND nID = <cfqueryparam value="#ARGUMENTS.nID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.siteNo NEQ 100>
    AND siteNo IN (<cfqueryparam value="#ARGUMENTS.siteNo#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    <cfif ARGUMENTS.nDateRel NEQ "">
    AND nDateRel <= <cfqueryparam value="#ARGUMENTS.nDateRel#" cfsqltype="cf_sql_date">
    </cfif>
    <cfif ARGUMENTS.nDateExp NEQ "">
    AND nDateExp >= <cfqueryparam value="#ARGUMENTS.nDateExp#" cfsqltype="cf_sql_date">
    </cfif>
    <cfif ARGUMENTS.ntID NEQ 0>
    AND ntID = <cfqueryparam value="#ARGUMENTS.ntID#" cfsqltype="cf_sql_integer">
    </cfif>
    AND (stID = <cfqueryparam value="#ARGUMENTS.stID#" cfsqltype="cf_sql_integer"> OR stID IS NULL)
    AND ntStatus IN (<cfqueryparam value="#ARGUMENTS.ntStatus#" list="yes" cfsqltype="cf_sql_integer">)
    AND nStatus IN (<cfqueryparam value="#ARGUMENTS.nStatus#" list="yes" cfsqltype="cf_sql_integer">)
    AND nmStatus IN (<cfqueryparam value="#ARGUMENTS.nmStatus#" list="yes" cfsqltype="cf_sql_integer">)
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsNewsletterMessage = StructNew()>
    <cfset rsNewsletterMessage.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsNewsletterMessage>
    </cffunction>
    
    <cffunction name="getNewsletterSiteRel" access="public" returntype="query" hint="Get Newsletter Site Relationship data.">
    <cfargument name="keywords" type="string" required="no" default="All">
    <cfargument name="ID" type="numeric" required="yes" default="0">
    <cfargument name="nID" type="numeric" required="yes" default="0">
    <cfargument name="siteNo" type="string" required="yes" default="100">
    <cfargument name="nDateRel" type="string" required="yes" default="">
    <cfargument name="nDateExp" type="string" required="yes" default="">
    <cfargument name="nStatus" type="string" required="no" default="1">
    <cfargument name="siteStatus" type="string" required="no" default="1">
    <cfargument name="nsrStatus" type="string" required="yes" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="siteNo">
    <cfargument name="groupBy" type="string" required="yes" default="">
	<cfset var rsNewsletterSiteRel = "" >
    <cftry>
    <cfquery name="rsNewsletterSiteRel" datasource="#application.mcmsDSN#">
    SELECT #Iif(ARGUMENTS.groupBy NEQ '', DE(ARGUMENTS.groupBy), DE('*'))# FROM v_newsletter_site_rel WHERE 0=0
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND siteNo LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> 
    </cfif>
    <cfif ARGUMENTS.ID NEQ 0>
    AND ID = <cfqueryparam value="#ARGUMENTS.ID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.nID NEQ 0>
    AND nID = <cfqueryparam value="#ARGUMENTS.nID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.siteNo NEQ 100>
    AND siteNo IN (<cfqueryparam value="#ARGUMENTS.siteNo#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    <cfif ARGUMENTS.nDateRel NEQ "">
    AND nDateRel <= <cfqueryparam value="#ARGUMENTS.nDateRel#" cfsqltype="cf_sql_date">
    </cfif>
    <cfif ARGUMENTS.nDateExp NEQ "">
    AND nDateExp >= <cfqueryparam value="#ARGUMENTS.nDateExp#" cfsqltype="cf_sql_date">
    </cfif>
    AND (stID = <cfqueryparam value="1" cfsqltype="cf_sql_integer"> OR stID IS NULL)
    AND nStatus IN (<cfqueryparam value="#ARGUMENTS.nStatus#" list="yes" cfsqltype="cf_sql_integer">)
    AND (siteStatus IN (<cfqueryparam value="#ARGUMENTS.siteStatus#" list="yes" cfsqltype="cf_sql_integer">) OR siteStatus IS NULL)
    AND nsrStatus IN (<cfqueryparam value="#ARGUMENTS.nsrStatus#" list="yes" cfsqltype="cf_sql_integer">)
    <cfif ARGUMENTS.groupBy NEQ "">
    GROUP BY #ARGUMENTS.groupBy#
    <cfelse>
    ORDER BY #ARGUMENTS.orderBy#
    </cfif>
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsNewsletterSiteRel = StructNew()>
    <cfset rsNewsletterSiteRel.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsNewsletterSiteRel>
    </cffunction>
    
    <cffunction name="getNewsletterSchedule" access="public" returntype="query" hint="Get Newsletter Schedule data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="ID" type="numeric" required="yes" default="0">
    <cfargument name="excludeID" type="numeric" required="yes" default="0">
    <cfargument name="nID" type="numeric" required="yes" default="0">
    <cfargument name="siteNo" type="string" required="yes" default="100">
    <cfargument name="siteNoAll" type="string" required="yes" default="100" hint="Required to filter All Site schedules.">
    <cfargument name="nsDate" type="string" required="yes" default="">
    <cfargument name="nsDateTime" type="string" required="yes" default="" hint="Prevents the newsletter from being sent twice in on day.">
    <cfargument name="nDateRel" type="string" required="yes" default="">
    <cfargument name="nDateExp" type="string" required="yes" default="">
    <cfargument name="ntID" type="string" required="yes" default="0">
    <cfargument name="stID" type="string" required="yes" default="1">
    <cfargument name="ntStatus" type="string" required="no" default="1">
    <cfargument name="nStatus" type="string" required="no" default="1">
    <cfargument name="nsStatus" type="string" required="yes" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="nName, nsDate">
    <cfset var rsNewsletterSchedule = "" >
    <cftry>
    <cfquery name="rsNewsletterSchedule" datasource="#application.mcmsDSN#">
    SELECT * FROM v_newsletter_schedule WHERE 0=0
    <cfif ARGUMENTS.ID NEQ 0>
    AND ID = <cfqueryparam value="#ARGUMENTS.ID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.excludeID NEQ 0>
    AND ID <> <cfqueryparam value="#ARGUMENTS.excludeID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(nName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(nDescription) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(siteName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(siteNo) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">)
    </cfif>
    <cfif ARGUMENTS.nID NEQ 0>
    AND nID = <cfqueryparam value="#ARGUMENTS.nID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.siteNo NEQ 100>
    AND siteNo IN (<cfqueryparam value="#ARGUMENTS.siteNo#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    <cfif ARGUMENTS.siteNoAll NEQ 100>
    AND siteNo = <cfqueryparam value="#ARGUMENTS.siteNoAll#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.nsDate NEQ "">
    AND nsDate >= <cfqueryparam value="#DateFormat(ARGUMENTS.nsDate, 'm/d/yyyy')# #TimeFormat('12:01:00 AM', 'h:mm:ss tt')#" cfsqltype="cf_sql_timestamp">
    </cfif>
    <!---To prevent sending a newsletter twice on one day.--->
    <cfif ARGUMENTS.nsDateTime NEQ "">
    AND (nsDate BETWEEN <cfqueryparam value="#DateFormat(ARGUMENTS.nsDateTime, 'm/d/yyyy')# #TimeFormat('12:01:00 AM', 'h:mm:ss tt')#" cfsqltype="cf_sql_timestamp"> AND <cfqueryparam value="#DateFormat(ARGUMENTS.nsDateTime, 'm/d/yyyy')# #TimeFormat('11:59:00 PM', 'h:mm:ss tt')#" cfsqltype="cf_sql_timestamp">)
    </cfif>
    <cfif ARGUMENTS.nDateRel NEQ "">
    AND nDateRel <= <cfqueryparam value="#ARGUMENTS.nDateRel#" cfsqltype="cf_sql_date">
    </cfif>
    <cfif ARGUMENTS.nDateExp NEQ "">
    AND nDateExp >= <cfqueryparam value="#ARGUMENTS.nDateExp#" cfsqltype="cf_sql_date">
    </cfif>
    <cfif ARGUMENTS.ntID NEQ 0>
    AND ntID = <cfqueryparam value="#ARGUMENTS.ntID#" cfsqltype="cf_sql_integer">
    </cfif>
    AND (stID = <cfqueryparam value="#ARGUMENTS.stID#" cfsqltype="cf_sql_integer"> OR stID IS NULL)
    AND ntStatus IN (<cfqueryparam value="#ARGUMENTS.ntStatus#" list="yes" cfsqltype="cf_sql_integer">)
    AND nStatus IN (<cfqueryparam value="#ARGUMENTS.nStatus#" list="yes" cfsqltype="cf_sql_integer">)
    AND nsStatus IN (<cfqueryparam value="#ARGUMENTS.nsStatus#" list="yes" cfsqltype="cf_sql_integer">)
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsNewsletterSchedule = StructNew()>
    <cfset rsNewsletterSchedule.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsNewsletterSchedule>
    </cffunction>
    
    <cffunction name="getNewsletterBounceLog" access="public" returntype="query" hint="Get Newsletter Bounce Log data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="ID" type="numeric" required="yes" default="0">
    <cfargument name="excludeID" type="numeric" required="yes" default="0">
    <cfargument name="nID" type="numeric" required="yes" default="0">
    <cfargument name="subID" type="numeric" required="yes" default="0">
    <cfargument name="erbtID" type="numeric" required="yes" default="0">
    <cfargument name="nblDate" type="string" required="yes" default="">
    <cfargument name="nblDateStart" type="string" required="yes" default="">
    <cfargument name="nblDateEnd" type="string" required="yes" default="">
    <cfargument name="nblStatus" type="string" required="yes" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="nID">
    <!---Pass additional arguments.--->
    <cfargument name="maxRows" type="string" required="yes" default="-1">
    <cfargument name="distinct" type="string" required="yes" default="false">
    <cfset var rsNewsletterBounceLog = "" >
    <cftry>
    <cfquery name="rsNewsletterBounceLog" datasource="#application.mcmsDSN#" maxrows="#ARGUMENTS.maxRows#">
    <cfif ARGUMENTS.distinct EQ true>
    SELECT nID, nName FROM v_newsletter_bounce_log
    <cfelse>
    SELECT * FROM v_newsletter_bounce_log 
    </cfif>
    WHERE 0=0
    <cfif ARGUMENTS.ID NEQ 0>
    AND ID = <cfqueryparam value="#ARGUMENTS.ID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.excludeID NEQ 0>
    AND ID <> <cfqueryparam value="#ARGUMENTS.excludeID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(nName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(nDescription) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">)
    </cfif>
    <cfif ARGUMENTS.nID NEQ 0>
    AND nID = <cfqueryparam value="#ARGUMENTS.nID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.subID NEQ 0>
    AND subID = <cfqueryparam value="#ARGUMENTS.subID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.erbtID NEQ 0>
    AND erbtID = <cfqueryparam value="#ARGUMENTS.erbtID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.nblDate NEQ "">
    AND TO_CHAR(nblDate, 'MM/DD/YYYY') = <cfqueryparam value="#ARGUMENTS.nblDate#" cfsqltype="cf_sql_varchar">
    </cfif>
    <cfif ARGUMENTS.nblDateStart NEQ "">
    AND nblDateStart >= <cfqueryparam value="#ARGUMENTS.nblDateStart#" cfsqltype="cf_sql_date">
    </cfif>
    <cfif ARGUMENTS.nblDateEnd NEQ "">
    AND nblDateEnd <= <cfqueryparam value="#ARGUMENTS.nblDateEnd#" cfsqltype="cf_sql_date">
	</cfif>
    AND nblStatus IN (<cfqueryparam value="#ARGUMENTS.nblStatus#" list="yes" cfsqltype="cf_sql_integer">)
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsNewsletterBounceLog = StructNew()>
    <cfset rsNewsletterBounceLog.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsNewsletterBounceLog>
    </cffunction>
    
    <cffunction name="getNewsletterIncentive" access="public" returntype="query" hint="Get Newsletter Incentive data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="ID" type="numeric" required="yes" default="0">
    <cfargument name="excludeID" type="numeric" required="yes" default="0">
    <cfargument name="niName" type="string" required="yes" default="">
    <cfargument name="niDateRel" type="string" required="yes" default="">
    <cfargument name="niDateExp" type="string" required="yes" default="">
    <cfargument name="niCode" type="string" required="yes" default="0">
    <cfargument name="niStatus" type="string" required="yes" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="niName">
    <cfset var rsNewsletterIncentive = "" >
    <cftry>
    <cfquery name="rsNewsletterIncentive" datasource="#application.mcmsDSN#">
    SELECT * FROM v_newsletter_incentive WHERE 0=0
    <cfif ARGUMENTS.ID NEQ 0>
    AND ID = <cfqueryparam value="#ARGUMENTS.ID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.excludeID NEQ 0>
    AND ID <> <cfqueryparam value="#ARGUMENTS.excludeID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(niName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(niDescription) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(niCode) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">)
    </cfif>
    <cfif ARGUMENTS.niName NEQ "">
    AND UPPER(niName) = <cfqueryparam value="#UCASE(ARGUMENTS.niName)#" cfsqltype="cf_sql_varchar">
    </cfif>
    <cfif ARGUMENTS.niDateRel NEQ "">
    AND niDateRel <= <cfqueryparam value="#ARGUMENTS.niDateRel#" cfsqltype="cf_sql_date">
    </cfif>
    <cfif ARGUMENTS.niDateExp NEQ "">
    AND niDateExp >= <cfqueryparam value="#ARGUMENTS.niDateExp#" cfsqltype="cf_sql_date">
    </cfif>
    <cfif ARGUMENTS.niCode NEQ 0>
    AND niCode = <cfqueryparam value="#ARGUMENTS.niCode#" cfsqltype="cf_sql_varchar">
    </cfif>
    AND niStatus IN (<cfqueryparam value="#ARGUMENTS.niStatus#" list="yes" cfsqltype="cf_sql_integer">)
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsNewsletterIncentive = StructNew()>
    <cfset rsNewsletterIncentive.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsNewsletterIncentive>
    </cffunction>
    
    <cffunction name="getNewsletterReport" access="public" returntype="query" hint="Get Newsletter Report data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="orderBy" type="string" required="yes" default="nName">
    <cfset var rsNewsletterReport = "" >
    <cftry>
    <cfquery name="rsNewsletterReport" datasource="#application.mcmsDSN#">
    SELECT nName AS Name, nDescription AS Description, ntName AS Template, TO_CHAR(nDateRel,'MM/DD/YYYY') AS Release_Date, TO_CHAR(nDateExp,'MM/DD/YYYY') AS Expiration_Date, sName AS Status FROM v_newsletter WHERE 0=0
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(nName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(nDescription) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">)
    </cfif>
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsNewsletterReport = StructNew()>
    <cfset rsNewsletterReport.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsNewsletterReport>
    </cffunction>
    
    <cffunction name="getNewsletterTemplateReport" access="public" returntype="query" hint="Get Newsletter Template Report data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="orderBy" type="string" required="yes" default="ntName">
    <cfset var rsNewsletterTemplateReport = "" >
    <cftry>
    <cfquery name="rsNewsletterTemplateReport" datasource="#application.mcmsDSN#">
    SELECT ntName AS Name, ntDescription AS Description FROM tbl_newsletter_template WHERE 0=0
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(ntName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(ntDescription) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">)
    </cfif>
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsNewsletterTemplateReport = StructNew()>
    <cfset rsNewsletterTemplateReport.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsNewsletterTemplateReport>
    </cffunction>
    
    <cffunction name="getNewsletterMessageReport" access="public" returntype="query" hint="Get Newsletter Message Report data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="orderBy" type="string" required="yes" default="nName">
    <cfset var rsNewsletterMessageReport = "" >
    <cftry>
    <cfquery name="rsNewsletterMessageReport" datasource="#application.mcmsDSN#">
    SELECT nName AS Name, siteName AS Site, TO_CHAR(nmMessage) AS Message, ntName AS Template, TO_CHAR(nDateRel,'MM/DD/YYYY') AS Release_Date, TO_CHAR(nDateExp,'MM/DD/YYYY') AS Expiration_Date, sName AS Status FROM v_newsletter_message WHERE 0=0
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(nmMessage) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(nDescription) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">)
    </cfif>
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsNewsletterMessageReport = StructNew()>
    <cfset rsNewsletterMessageReport.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsNewsletterMessageReport>
    </cffunction>
    
    <cffunction name="getNewsletterScheduleReport" access="public" returntype="query" hint="Get Newsletter Schedule Report data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="siteNo" type="string" required="yes" default="100">
    <cfargument name="orderBy" type="string" required="yes" default="nName">
    <cfset var rsNewsletterScheduleReport = "" >
    <cftry>
    <cfquery name="rsNewsletterScheduleReport" datasource="#application.mcmsDSN#">
    SELECT nName AS Name, siteName AS Site, ntName AS Template, nsCount AS Count,TO_CHAR(nsDate,'MM/DD/YYYY') AS Sent_Date, TO_CHAR(nDateExp,'MM/DD/YYYY') AS Expiration_Date, sName AS Status FROM v_newsletter_schedule WHERE 0=0
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(nmMessage) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(nDescription) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">)
    </cfif>
    <cfif ARGUMENTS.siteNo NEQ 100>
    AND siteNo IN (<cfqueryparam value="#ARGUMENTS.siteNo#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsNewsletterScheduleReport = StructNew()>
    <cfset rsNewsletterScheduleReport.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsNewsletterScheduleReport>
    </cffunction>
    
    <cffunction name="getNewsletterIncentiveReport" access="public" returntype="query" hint="Get Newsletter Incentive Report data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="orderBy" type="string" required="yes" default="nName">
    <cfset var rsNewsletterIncentiveReport = "" >
    <cftry>
    <cfquery name="rsNewsletterIncentiveReport" datasource="#application.mcmsDSN#">
    SELECT niName As Name, nName AS Newsletter, TO_CHAR(niDescription) AS Description, niCode AS Code, TO_CHAR(niDateRel,'MM/DD/YYYY') AS Release_Date, TO_CHAR(niDateExp,'MM/DD/YYYY') AS Expiration_Date, bName AS Banner, sName AS Status FROM v_newsletter_incentive WHERE 0=0
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(niDescription) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(niName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">)
    </cfif>
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsNewsletterIncentiveReport = StructNew()>
    <cfset rsNewsletterIncentiveReport.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsNewsletterIncentiveReport>
    </cffunction>
    
    <cffunction name="insertNewsletter" access="public" returntype="struct">
    <cfargument name="nName" type="string" required="yes">
    <cfargument name="nDescription" type="string" required="yes">
    <cfargument name="nNotes" type="string" required="yes">
    <cfargument name="nDateRel" type="date" required="yes">
    <cfargument name="nDateExp" type="date" required="yes">
    <cfargument name="ntID" type="numeric" required="yes">
    <cfargument name="nStatus" type="numeric" required="yes">
    <!---Email arguments.--->
    <cfargument name="emailNotify" type="string" required="yes">
    <!---Relationship arguments.--->
    <cfargument name="siteNo" type="string" required="yes">
    <cfset result.message = "You have successfully inserted the record.">
    <cftry>
    <!---Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.app.newsletter.Newsletter"
    method="getNewsletter"
    returnvariable="getCheckNewsletterRet">
    <cfinvokeargument name="nName" value="#ARGUMENTS.nName#"/>
    <cfinvokeargument name="nStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckNewsletterRet.recordcount NEQ 0>
    <cfset result.message = "The name #ARGUMENTS.nName# already exists, please enter a new name.">
    <!---Check length restriction.--->
    <cfelseif LEN(ARGUMENTS.nDescription) GT 255>
    <cfset result.message = "The description is longer than 255 characters, please enter a new description under 255 characters.">
    <cfelseif LEN(ARGUMENTS.nNotes) GT 1024>
    <cfset result.message = "The notes is longer than 1024 characters, please enter new notes under 1024 characters.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    INSERT INTO tbl_newsletter (nName,nDescription,nNotes,nDateRel,nDateExp,ntID,nStatus) VALUES
    (
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.nName#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.nDescription#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.nNotes#">,
    <cfqueryparam cfsqltype="cf_sql_date" value="#ARGUMENTS.nDateRel#">,
    <cfqueryparam cfsqltype="cf_sql_date" value="#ARGUMENTS.nDateExp#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ntID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.nStatus#">
    )
    </cfquery>
    </cftransaction>
    <!---Get a list of site managers to send a notification too based on their role and site relationships.--->
    <cfinvoke
    component="MCMS.component.cms.User"
    method="getUserSiteRel"
    returnvariable="getUserSiteRelRet">
    <cfinvokeargument name="urID" value="104"/>
    <cfif ARGUMENTS.siteNo DOES NOT CONTAIN 100>
    <cfinvokeargument name="siteNo" value="#ARGUMENTS.siteNo#"/>
    </cfif>
    <cfinvokeargument name="usrStatus" value="1"/>
    </cfinvoke>
    <!---Get the nID just added.--->
    <cfinvoke 
    component="MCMS.component.app.newsletter.Newsletter"
    method="getNewsletter"
    returnvariable="getNewsletterIDRet">
    <cfinvokeargument name="nName" value="#ARGUMENTS.nName#"/>
    <cfinvokeargument name="nStatus" value="1,2,3"/>
    </cfinvoke>
    <cfset this.nID = getNewsletterIDRet.ID>
    <!---Create site relationships.--->
    <cfloop index="siteNo" list="#ARGUMENTS.siteNo#">
    <cfinvoke 
    component="MCMS.component.app.newsletter.Newsletter"
    method="insertNewsletterSiteRel"
    returnvariable="insertNewsletterSiteRelRet">
    <cfinvokeargument name="nID" value="#this.nID#"/>
    <cfinvokeargument name="siteNo" value="#siteNo#"/>
    <cfinvokeargument name="nsrStatus" value="1"/>
    </cfinvoke>
    </cfloop>
    <!---Do not send newsletter notifcation for preview nesletters.--->
    <cfif ARGUMENTS.nStatus EQ 1 AND ARGUMENTS.emailNotify EQ 'true' AND getUserSiteRelRet.recordcount NEQ 0>
    <cfset this.emailContent = '
	#session.userName# has inserted a new newsletter called "#ARGUMENTS.nName#". The newsletter requires your message. The release dates for this newsletter are between #DateFormat(ARGUMENTS.nDateRel, application.dateFormat)# - #DateFormat(ARGUMENTS.nDateExp, application.dateFormat)#. You may receive duplicate notifications of this due to corrections made by the Marketing Dept. or if you are responsible for multiple sites. Please <a href="http://#CGI.HTTP_HOST#/#application.mcmsAppAdminPath#/?appID=#url.appID#">Sign-In</a> and create your message to ensure it can be reviewed and your newsletter can be sent, thank you.
	<br/><br/>
	#ARGUMENTS.nNotes#
	'>
    <cfset this.siteManagerEmail = ValueList(getUserSiteRelRet.userEmail)>
    <!---Send email notification to site managers.--->
    <cfinvoke 
    component="MCMS.component.utility.Email"
    method="sendEmail">
    <cfinvokeargument name="subject" value="#ARGUMENTS.nName# Newsletter Message Required by #DateFormat(ARGUMENTS.nDateRel, application.dateFormat)#"/>
    <cfinvokeargument name="to" value="#application.webmasterEmail#"/>
    <cfinvokeargument name="from" value="#session.userUsername#"/>
    <cfinvokeargument name="cc" value="#this.siteManagerEmail#"/>
    <cfinvokeargument name="bcc" value=""/>
    <cfinvokeargument name="body" value="#this.emailContent#"/>
    <cfinvokeargument name="emailType" value="html"/>
    <cfinvokeargument name="type" value="admin"/>
    </cfinvoke>
    </cfif>
    </cfif>
    <cfcatch type="any">
    <cfset result.message = "There was an error inserting the record.">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="insertNewsletterTemplate" access="public" returntype="struct">
    <cfargument name="ntName" type="string" required="yes">
    <cfargument name="ntDescription" type="string" required="yes">
    <cfargument name="ntFile" type="string" required="yes">
    <cfargument name="ntStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully inserted the record.">
    <cftry>
    <!---Check for profanity in the text.--->
    <cfinvoke 
    component="MCMS.component.utility.Regex"
    method="regexProfanity"
    returnvariable="regexProfanityRet">
    <cfinvokeargument name="profanityString" value="#ARGUMENTS.ntDescription#"/>
    </cfinvoke>
    <!---Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.app.newsletter.Newsletter"
    method="getNewsletterTemplate"
    returnvariable="getCheckNewsletterTemplateRet">
    <cfinvokeargument name="ntName" value="#ARGUMENTS.ntName#"/>
    <cfinvokeargument name="ntStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckNewsletterTemplateRet.recordcount NEQ 0>
    <cfset result.message = "The name #ARGUMENTS.ntName# already exists, please enter a new name.">
    <cfelseif regexProfanityRet CONTAINS '$%&*!'>
    <cfset result.message = "Some text contained profanity, please remove any profanity from your text.">
    <!---Check length restriction.--->
    <cfelseif LEN(ARGUMENTS.ntDescription) GT 255>
    <cfset result.message = "The description is longer than 255 characters, please enter a new description under 255 characters.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    INSERT INTO tbl_newsletter_template (ntName,ntDescription,ntFile,ntStatus) VALUES
    (
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.ntName#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.ntDescription#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.ntFile#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ntStatus#">
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
    
    <cffunction name="insertNewsletterMessage" access="public" returntype="struct">
    <cfargument name="nID" type="numeric" required="yes">
    <cfargument name="siteNo" type="numeric" required="yes">
    <cfargument name="nmSubject" type="string" required="yes">
    <cfargument name="nmMessage" type="string" required="yes">
    <cfargument name="nmStatus" type="numeric" required="yes">
    <!---Email arguments.--->
    <cfargument name="emailNotify" type="string" required="yes">
    <cfif ARGUMENTS.nmStatus EQ 1>
    <cfset result.message = "You have successfully inserted the record for immediate approval.">
    <cfelseif ARGUMENTS.nmStatus EQ 3>
    <cfset result.message = "You have successfully inserted the record for review.">
    <cfelse>
    <cfset result.message = "You have successfully inserted the record.">
    </cfif>
    <cftry>
    <!---Check for profanity in the text.--->
    <cfinvoke 
    component="MCMS.component.utility.Regex"
    method="regexProfanity"
    returnvariable="regexProfanityRet">
    <cfinvokeargument name="profanityString" value="#ARGUMENTS.nmMessage#"/>
    </cfinvoke>
    <!---Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.app.newsletter.Newsletter"
    method="getNewsletterMessage"
    returnvariable="getCheckNewsletterMessageRet">
    <cfinvokeargument name="nID" value="#ARGUMENTS.nID#"/>
    <cfinvokeargument name="siteNo" value="#ARGUMENTS.siteNo#"/>
    <cfinvokeargument name="nmStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckNewsletterMessageRet.recordcount NEQ 0>
    <cfset result.message = "The message for your site and this newsletter already exists, please try again.">
    <cfelseif regexProfanityRet CONTAINS '$%&*!'>
    <cfset result.message = "Some text contained profanity, please remove any profanity from your message.">
    <!---Check length restriction.--->
    <cfelseif LEN(ARGUMENTS.nmMessage) GT 4096>
    <cfset result.message = "The message is longer than 4096 characters, please enter a new message under 4096 characters.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    INSERT INTO tbl_newsletter_message (nID,siteNo,nmSubject,nmMessage,nmStatus) VALUES
    (
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.nID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.siteNo#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.nmSubject#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.nmMessage#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.nmStatus#">
    )
    </cfquery>
    </cftransaction>
    <!---Do not send message notifcation for preview messages.--->
    <cfif ARGUMENTS.emailNotify EQ 'true'>
    <!---Get newsletter details to send in email notification.--->
    <cfinvoke 
    component="MCMS.component.app.newsletter.Newsletter"
    method="getNewsletter"
    returnvariable="getNewsletterRet">
    <cfinvokeargument name="ID" value="#ARGUMENTS.nID#"/>
    <cfinvokeargument name="nStatus" value="1"/>
    </cfinvoke>
    <cfset this.emailContent = '
	#session.userName# has inserted the message for #getNewsletterRet.nName#. The newsletter and message can now be modified, approved, and sent.
	'>
    <!---Send email notification to Marketing.--->
    <cfinvoke 
    component="MCMS.component.utility.Email"
    method="sendEmail">
    <cfinvokeargument name="subject" value="#getNewsletterRet.nName# Message Inserted for #ARGUMENTS.siteNo#"/>
    <cfinvokeargument name="to" value="#application.newsletterAdminEmail#"/>
    <cfinvokeargument name="from" value="#session.userUsername#"/>
    <cfinvokeargument name="cc" value=""/>
    <cfinvokeargument name="bcc" value="#application.webmasterEmail#"/>
    <cfinvokeargument name="body" value="#this.emailContent#"/>
    <cfinvokeargument name="emailType" value="html"/>
    <cfinvokeargument name="type" value="admin"/>
    </cfinvoke>
    </cfif>
    </cfif>
    <cfcatch type="any">
    <cfset result.message = "There was an error inserting the record.">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="insertNewsletterSiteRel" access="public" returntype="struct">
    <cfargument name="nID" type="numeric" required="yes">
    <cfargument name="siteNo" type="numeric" required="yes">
    <cfargument name="nsrStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully inserted the record.">
    <cftry>
	<!---Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.app.newsletter.Newsletter"
    method="getNewsletterSiteRel"
    returnvariable="getCheckNewsletterSiteRelRet">
    <cfinvokeargument name="nID" value="#ARGUMENTS.nID#"/>
    <cfinvokeargument name="siteNo" value="#ARGUMENTS.siteNo#"/>
    <cfinvokeargument name="nsrStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckNewsletterSiteRelRet.recordcount NEQ 0>
    <cfset result.message = "The newsletter site relationship already exists, please try again.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    INSERT INTO tbl_newsletter_site_rel (nID,siteNo,nsrStatus) VALUES
    (
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.nID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.siteNo#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.nsrStatus#">
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
    
    <cffunction name="insertNewsletterSchedule" access="public" returntype="struct">
    <cfargument name="nID" type="numeric" required="yes">
    <cfargument name="siteNo" type="numeric" required="yes">
    <cfargument name="testBlast" type="string" required="yes">
    <cfargument name="subStateProv" type="string" required="yes">
    <cfargument name="subZipCode" type="string" required="yes">
    <cfargument name="subTelArea" type="string" required="yes">
    <cfargument name="iID" type="string" required="yes">
    <cfargument name="nsStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully scheduled and sent the newsletter.">
    <cftry>
    <!---Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.app.newsletter.Newsletter"
    method="getNewsletterSchedule"
    returnvariable="getCheckNewsletterScheduleRet">
    <cfinvokeargument name="nID" value="#ARGUMENTS.nID#"/>
    <cfinvokeargument name="siteNo" value="#ARGUMENTS.siteNo#"/>
    <cfinvokeargument name="nsDateTime" value="#Now()#"/>
    <cfinvokeargument name="nsStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckNewsletterScheduleRet.recordcount NEQ 0>
    <cfset result.message = "A schedule already exists for this site #ARGUMENTS.siteNo# and newsletter today, please enter choose a different template or try again tommorrow.">
    <cfelse> 
    <!---BEGIN SCHEDULER--->
    <cfthread action="run" name="newsletterEmailBlast#ARGUMENTS.nID#" newsletterDelayTime="#application.newsletterDelayTime#" newsletterEmailBatchSize="#application.newsletterEmailBatchSize#" siteNo="#ARGUMENTS.siteNo#" newsletterServer="http://#Replace(CGI.SERVER_NAME, 'extranet', 'newsletter', 'ALL')#" newsletterServerEmailPort="#application.newsletterServerEmailPort#" subStateProv="#ARGUMENTS.subStateProv#" subZipCode="#ARGUMENTS.subZipCode#" subTelArea="#ARGUMENTS.subTelArea#" iID="#ARGUMENTS.iID#" nID="#ARGUMENTS.nID#" testBlast="#ARGUMENTS.testBlast#">
    <!---Get the newsletter name for the thread.--->
    <cfinvoke 
    component="MCMS.component.app.newsletter.Newsletter"
    method="getNewsletter"
    returnvariable="getNewsletterRet">
    <cfinvokeargument name="ID" value="#nID#"/>
    <cfinvokeargument name="nStatus" value="1"/>
    </cfinvoke>
    <cfset this.newletterThreadName = getNewsletterRet.nName & DateFormat(Now(), 'mm/dd/yyyy')>
    <!---Create the schedules.--->
    <cfsilent>
    <!---Get a subscriptions for this site.--->
    <!---If 100 or "All Sites" filter based on state/prov, tel area code, or zip code.--->
    <cfif siteNo EQ 100 AND iID EQ 0>
    <cfinvoke 
    component="MCMS.component.app.subscription.Subscription"
    method="getSubscription"
    returnvariable="getSubscriptionRet">
    <cfinvokeargument name="subStateProv" value="#subStateProv#">
    <cfinvokeargument name="subZipCode" value="#subZipCode#">
    <cfinvokeargument name="subTelArea" value="#subTelArea#">
    <cfinvokeargument name="subStatus" value="1"/>
    </cfinvoke>
    <cfelseif siteNo EQ 100 AND iID NEQ 0>
    <cfinvoke 
    component="MCMS.component.app.subscription.Subscription"
    method="getSubscriptionImportRel"
    returnvariable="getSubscriptionRet">
    <cfinvokeargument name="iID" value="#iID#">
    <cfinvokeargument name="subStateProv" value="#subStateProv#">
    <cfinvokeargument name="subZipCode" value="#subZipCode#">
    <cfinvokeargument name="subTelArea" value="#subTelArea#">
    <cfinvokeargument name="sirStatus" value="1"/>
    </cfinvoke>
    <cfelse>
    <cfinvoke 
    component="MCMS.component.app.subscription.Subscription"
    method="getSubscriptionSiteRel"
    returnvariable="getSubscriptionRet">
    <cfinvokeargument name="siteNo" value="#siteNo#"/>
    <cfinvokeargument name="ssrStatus" value="1"/>
    <cfinvokeargument name="orderBy" value="subEmail"/>
    </cfinvoke>
    </cfif>
    <!---Get the curent schedules.--->
    <cfset local.totalCountToday = 0>
    <cfinvoke 
    component="MCMS.component.app.newsletter.Newsletter"
    method="getNewsletterSchedule"
    returnvariable="getNewsletterScheduleRet">
    <cfinvokeargument name="nsDate" value="#Now()#"/>
    <cfinvokeargument name="stID" value="1"/>
    <cfinvokeargument name="nsStatus" value="1"/>
    <cfinvokeargument name="orderBy" value="nsDate DESC"/>
    </cfinvoke>
    <cfif getNewsletterScheduleRet.recordcount NEQ 0>
    <cfset local.totalCountToday = Evaluate(ValueList(getNewsletterScheduleRet.nsCount, '+'))>
    </cfif>
    </cfsilent>
    <cfif getNewsletterScheduleRet.recordcount EQ 0>
    <cfset local.scheduleTimeStart = TimeFormat(Now(), 'hh:mm tt')>
    <cfelse>
    <!---Get the latest schedule and calculate the time of it's last schedule to build on top of.--->
    <cfset local.scheduleTimeStart = TimeFormat(DateAdd('s', (local.totalCountToday+2)*newsletterDelayTime, getNewsletterScheduleRet.nsDate), 'hh:mm tt')>
	<!---If the scheduleTimeStart is less than now use the current time. This ensures that the scheduled task are not created after time has elapsed.--->
    <cfif local.scheduleTimeStart LT TimeFormat(Now(), 'hh:mm tt')>
    <cfset local.scheduleTimeStart = TimeFormat(Now(), 'hh:mm tt')>
    </cfif>
    </cfif>
    <!---Set the scheduleDate.--->
    <cfset local.scheduleDate = DateFormat(Now(), 'mm/dd/yyyy')>
    <cfif getSubscriptionRet.recordcount EQ 0>
    <cfset result.message = "There are no subscriptions for this site, please try again.">
    <cfelse>
    <!---Create a variable for the total amount of subscriptions.--->
    <cfset local.subscriptionTotal = getSubscriptionRet.recordcount>
    <!---Create the total number of schedules to be created.--->
    <cfset local.scheduleCount = Ceiling(local.subscriptionTotal/newsletterEmailBatchSize)>
    <!---Calculate the total time (seconds) that it will take to run the schedules.--->
    <cfset local.scheduleTimeTotal = local.scheduleCount*newsletterDelayTime>
    <!---Create parameters to record schedule.--->
    <cfset nsParameter = "">
    <cfif subStateProv NEQ "">
    <cfset nsParameter = subStateProv>
    </cfif>
    <cfif subZipCode NEQ "">
    <cfset nsParameter = nsParameter & '|' & subZipCode>
    </cfif>
    <cfif subTelArea NEQ "">
    <cfset nsParameter = nsParameter & '|' & subTelArea>
    </cfif>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    INSERT INTO tbl_newsletter_schedule (nID,siteNo,nsCount,nsParameter,nsTimeDelay,nsStatus) VALUES
    (
    <cfqueryparam cfsqltype="cf_sql_integer" value="#nID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#siteNo#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#local.scheduleCount#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#nsParameter#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#newsletterDelayTime#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="1">
    )
    </cfquery>
    </cftransaction>
    <!---Create the schedules.--->
    <cfloop index="id"from="1" to="#local.scheduleCount#">
    <!---Add the sequential time to the delaytime values + 1 extra to begin after the last schedule.--->
    <cfset local.scheduleTime = TimeFormat(DateAdd('s', (newsletterDelayTime*id)+newsletterDelayTime, local.scheduleTimeStart), 'hh:mm tt')>
    <!---If the scheduleTime passes 11:00 PM set the schedule task to the next day.--->
    <cfif ParseDateTime(local.scheduleDate & '11:00 PM') LT ParseDateTime(local.scheduleDate & local.scheduleTime) AND local.scheduleDate EQ DateFormat(Now(), 'mm/dd/yyyy')>
    <!---Add a day to the scheduler.--->
    <cfset local.scheduleDate = DateFormat(DateAdd('d', 1, local.scheduleDate), 'mm/dd/yyyy')>
    <!---Renew the scheduler to begin early the next day.--->
	<cfset local.setTime = '00:01'>
	<cfset local.scheduleTime = TimeFormat(DateAdd('s', newsletterDelayTime*id, local.setTime), 'hh:mm tt')>
    </cfif>
    <!---Create the range from where to begin quering for this scheduled task.--->
    <cfset local.startRow = ((id-1)*newsletterEmailBatchSize)+1>
    <!---Create range of total subscription records for this scheduled task.---> 
    <cfset local.endRow = Min(local.startRow + (newsletterEmailBatchSize-1), local.subscriptionTotal)> 
    <!--- Create schedules called 'siteNo & '-newsletter' & id' where id is the loop index. ---> 
    <cfset local.scheduleID = siteNo & "-newsletter" & id>
    <!--- Create timeout based on batch size and an estimated 250 emails per 60 seconds. ---> 
    <cfset local.timeOut = (newsletterEmailBatchSize/250)*60>
    <!--- Make sure you need to do something. ---> 
    <cfif local.startRow LE local.endRow> 
    <cfschedule 
    action="update" 
    task="#local.scheduleID#" 
    operation="httprequest" 
    url="#newsletterServer#:#newsletterServerEmailPort#/newsletter/schedule_manager.cfm?scheduleID=#local.scheduleID#&startRow=#local.startRow#&endRow=#local.endRow#&siteNo=#siteNo#&subStateProv=#subStateProv#&subZipCode=#subZipCode#&subTelArea=#subTelArea#&iID=#iID#&nID=#nID#&testBlast=#testBlast#" 
    startdate="#local.scheduleDate#"
    starttime="#local.scheduleTime#"
    interval="once"
    requesttimeout="#local.timeOut#"
    >
    </cfif> 
    </cfloop>
    <!---END SCHEDULER--->
    </cfif>
    <!---Run garbage collection.--->
    <cfset runtime = CreateObject("java", "java.lang.Runtime").getRuntime()>
	<cfset runtime.gc()>
    </cfthread>
    </cfif>
    <cfcatch type="any">
    <cfset result.message = "There was an error inserting the record.">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="insertNewsletterBounceLogScheduledTask" access="public" returntype="void" hint="Insert Newsletter Bounce Log using this scheduled task.">
    <cftry>
    <cfparam name="this.nID" type="numeric" default="0">
    <cfparam name="this.subID" type="numeric" default="0">
    <cfparam name="this.subEmail" type="string" default="">
    <cfparam name="this.siteNo" type="numeric" default="100">
    <cfparam name="this.smtpCode" type="string" default="0">
    <cfparam name="this.ercID" type="numeric" default="0">
    <cfthread action="run" 
    name="taskNewsletterBounceLog" 
    nID="#this.nID#"
    subID="#this.subID#"  
    subEmail="#this.subEmail#"
    siteNo="#this.siteNo#"
    smtpCode="#this.smtpCode#" 
    ercID="#this.ercID#" 
    newsletterEmailServerIP="#application.newsletterEmailServerIP#" 
    newsletterFailToUsername="#application.newsletterFailToUsername#"
    newsletterFailToPassword="#application.newsletterFailToPassword#"
    newsletterEmailResponseCodeType="#application.newsletterEmailResponseCodeType#"
    repositoryPath="#application.repositoryPath#"
    companyName="#application.companyName#"
    webmasterEmail="#application.webmasterEmail#"
    newsletterFailTo="#application.newsletterFailTo#"
    >
    <cfset VARIABLES.nID = nID>
    <cfset VARIABLES.subID = subID>
    <cfset VARIABLES.subEmail = subEmail>
    <cfset VARIABLES.siteNo = siteNo>
    <cfset VARIABLES.smtpCode = smtpCode>
    <cfset VARIABLES.ercID = ercID>
    <cfset VARIABLES.newsletterEmailServerIP = newsletterEmailServerIP>
    <cfset VARIABLES.newsletterFailToUsername = newsletterFailToUsername>
    <cfset VARIABLES.newsletterFailToPassword = newsletterFailToPassword>
    <cfset VARIABLES.newsletterEmailResponseCodeType = newsletterEmailResponseCodeType>
    <cfset VARIABLES.repositoryPath = repositoryPath>
    <cfset VARIABLES.companyName = companyName>
    <cfset VARIABLES.webmasterEmail = webmasterEmail>
    <cfset VARIABLES.newsletterFailTo = newsletterFailTo>
    
    <cfpop 
    server="#VARIABLES.newsletterEmailServerIP#"
    username="#VARIABLES.newsletterFailToUsername#"
    password="#VARIABLES.newsletterFailToPassword#"
    action="getAll"
    name="GetBounceEmail"
    maxrows="250"
    > 
    
    <cfif GetBounceEmail.recordcount NEQ 0>
    <cfloop query="GetBounceEmail">
    <!---Check to see that this is an email newsletter bounce.--->
    <cfif GetBounceEmail.from CONTAINS "System Administrator" AND GetBounceEmail.body CONTAINS "nID:">
    <!--- Check that it is POP3 format. --->
    <cfif VARIABLES.newsletterEmailResponseCodeType EQ 1>

    <cfset decodedString = GetBounceEmail.body>
    
    <!--- Find nID. --->	
    <cfset nIDString = REFind("nID:(\d+)", decodedString, 1, "TRUE")>
    <cfif nIDString.len[1] NEQ 0>
    <cfset VARIABLES.nID = Mid(decodedString, nIDString.pos[2], nIDString.len[2])>   
    </cfif>
    
    <!--- Find subID. --->	
    
    <cfset subIDString = REFind("subID:(\d+)", decodedString, 1, "TRUE")>
    <cfif subIDString.len[1] NEQ 0>
    <cfset VARIABLES.subID = Mid(decodedString, subIDString.pos[2], subIDString.len[2])> 
    </cfif>
    
    <!--- Find subEmail. --->	
    
	<cfset subEmailString = REFind("subEmail:([-+.\w]{1,64}@[-.\w]{1,64}\.[-.\w]{2,6})", decodedString, 1, "TRUE")>
    <cfif subEmailString.len[1] NEQ 0>
	<cfset VARIABLES.subEmail = Mid(decodedString, subEmailString.pos[2], subEmailString.len[2])>
    </cfif>

    <!--- Find siteNo. --->	
    
    <cfset siteNoString = REFind("siteNo:(\d+)", decodedString, 1, "TRUE")>
    <cfif siteNoString.len[1] NEQ 0>
    <cfset VARIABLES.siteNo = Mid(decodedString, siteNoString.pos[2], siteNoString.len[2])>
    </cfif>
    </cfif>
    
    <!--- Parse email for SMTP code. --->
    
    <cfset headerString = REFind("#application.newsletterHeaderString#", decodedString, 1, "TRUE")>
    <cfif headerString.len[1] NEQ 0>
    <cfset VARIABLES.smtpCode = TRIM(Mid(decodedString, headerString.pos[1]+headerString.len[1]+5, headerString.len[1]-1))>
    </cfif>
    <!--- Look up the ercID based on the smtpCode. --->
    
    <cfinvoke 
    component="MCMS.component.utility.Email"
    method="getEmailResponseCode"
    returnvariable="getEmailResponseCodeRet">
    <cfinvokeargument name="ercCode" value="#VARIABLES.smtpCode#"/>
    <cfinvokeargument name="ercStatus" value="1,3"/>
    </cfinvoke>
    
    <cfif getEmailResponseCodeRet.recordcount EQ 0>
    <cfset VARIABLES.ercID = '101'>
    <cfset VARIABLES.erbtID = '1'>
    <cfelse>
    <cfset VARIABLES.ercID = getEmailResponseCodeRet.ID>
    <cfset VARIABLES.erbtID = getEmailResponseCodeRet.erbtID>
    </cfif>
 
    <!--- Log bounce. --->
    <cfinvoke 
    component="MCMS.component.app.newsletter.Newsletter"
    method="insertNewsletterBounceLog"
    returnvariable="insertNewsletterBounceLogRet">
    <cfinvokeargument name="nID" value="#VARIABLES.nID#"/>
    <cfinvokeargument name="subID" value="#VARIABLES.subID#"/>
    <cfinvokeargument name="subEmail" value="#VARIABLES.subEmail#"/>
    <cfinvokeargument name="siteNo" value="#VARIABLES.siteNo#"/>
    <cfinvokeargument name="ercID" value="#VARIABLES.ercID#"/>
    <cfinvokeargument name="nblStatus" value="1"/>
    </cfinvoke>
    
    <!--- Update subscription status when hard. --->
    <cfif VARIABLES.erbtID EQ 1>
    <cfinvoke 
    component="MCMS.component.app.newsletter.Newsletter"
    method="updateNewsletterSubscriptionLists"
    returnvariable="updateNewsletterSubscriptionListsRet">
    <cfinvokeargument name="subID" value="#VARIABLES.subID#"/>
    <cfinvokeargument name="subEmail" value="#VARIABLES.subEmail#"/>
    <cfinvokeargument name="siteNo" value="#VARIABLES.siteNo#"/>
    </cfinvoke>
    </cfif>  
    </cfif>
    </cfloop>   
    
    <cflock name="deleteMail" timeout="240">
    <cfpop 
    server="#VARIABLES.newsletterEmailServerIP#"
    username="#VARIABLES.newsletterFailToUsername#"
    password="#VARIABLES.newsletterFailToPassword#"
    action="delete"
    name="delete"
    maxrows="250"
    >
    </cflock>

    <cfinvoke 
    component="MCMS.component.utility.Email"
    method="sendEmail">
    <cfinvokeargument name="subject" value="#VARIABLES.companyName# Newsletter Bounce Report"/>
    <cfinvokeargument name="to" value="#VARIABLES.webmasterEmail#"/>
    <cfinvokeargument name="from" value="#VARIABLES.newsletterFailTo#"/>
    <cfinvokeargument name="body" value=""/>
    <cfinvokeargument name="ID" value="#VARIABLES.nID#"/>
    <cfinvokeargument name="emailTemplate" value="/newsletter/view/inc_newsletter_email_bounce.cfm"/>
    </cfinvoke>
    </cfif> 
    </cfthread>
    
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfinvoke 
    component="MCMS.component.utility.Email"
    method="sendEmail">
    <cfinvokeargument name="subject" value="An exception occurred while logging a newsletter bounce."/>
    <cfinvokeargument name="to" value="#application.webmasterEmail#"/>
    <cfinvokeargument name="from" value="#application.newsletterFailTo#"/>
    <cfinvokeargument name="body" value="Cause: #CFCATCH.Message#<br>Detail: #CFCATCH.Detail#<br>nID: #this.nID#<br>subID: #this.subID#<br>siteNo: #this.siteNo#<br> #this.smtpCode# - #this.ercID#"/>
    <cfinvokeargument name="emailType" value="html"/>
    <cfinvokeargument name="type" value="admin"/>
    </cfinvoke>
    <cflog text="An error occurred logging a newsletter bounce. #CFCATCH.Message# | #CFCATCH.Detail#" log="application" type="error" file="newsletterBounce">
    </cfcatch>
    </cftry>
    </cffunction> 
    
    <cffunction name="purgeBounceEmail" access="public" returntype="void" hint="Purge email folder that is used to record bounces.">
    <cftry>
    <cfthread action="run" 
    name="taskPurgeBounceEmail" 
    newsletterEmailServerIP="#application.newsletterEmailServerIP#" 
    newsletterFailToUsername="#application.newsletterFailToUsername#"
    newsletterFailToPassword="#application.newsletterFailToPassword#"
    repositoryPath="#application.repositoryPath#"
    companyName="#application.companyName#"
    webmasterEmail="#application.webmasterEmail#"
    newsletterFailTo="#application.newsletterFailTo#"
    >
    <cfset VARIABLES.newsletterEmailServerIP = newsletterEmailServerIP>
    <cfset VARIABLES.newsletterFailToUsername = newsletterFailToUsername>
    <cfset VARIABLES.newsletterFailToPassword = newsletterFailToPassword>
    <cfset VARIABLES.repositoryPath = repositoryPath>
    <cfset VARIABLES.companyName = companyName>
    <cfset VARIABLES.webmasterEmail = webmasterEmail>
    <cfset VARIABLES.newsletterFailTo = newsletterFailTo>
    
    <!---Delete emails.--->
    <cfpop 
    server="#VARIABLES.newsletterEmailServerIP#"
    username="#VARIABLES.newsletterFailToUsername#"
    password="#VARIABLES.newsletterFailToPassword#"
    action="delete"
    > 
    <cflog text="The purge email process has completed." log="application" type="information" file="purgeEmailBounce">
    </cfthread>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfinvoke 
    component="MCMS.component.utility.Email"
    method="sendEmail">
    <cfinvokeargument name="subject" value="An exception occurred while purging the email bounce folder."/>
    <cfinvokeargument name="to" value="#application.webmasterEmail#"/>
    <cfinvokeargument name="from" value="#application.newsletterFailTo#"/>
    <cfinvokeargument name="body" value="Cause: #CFCATCH.Message#<br>Detail: #CFCATCH.Detail#"/>
    <cfinvokeargument name="emailType" value="html"/>
    <cfinvokeargument name="type" value="admin"/>
    </cfinvoke>
    </cfcatch>
    </cftry>
    </cffunction>
    
    <cffunction name="insertNewsletterBounceLog" access="public" returntype="struct" hint="Insert Newsletter Bounce log.">
    <cfargument name="nID" type="numeric" required="yes">
    <cfargument name="subID" type="numeric" required="yes">
    <cfargument name="subEmail" type="string" required="yes">
    <cfargument name="siteNo" type="numeric" required="yes">
    <cfargument name="ercID" type="numeric" required="yes">
    <cfargument name="nblStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully inserted the record.">
    <cftry>
    <!---Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.app.newsletter.Newsletter"
    method="getNewsletterBounceLog"
    returnvariable="getNewsletterBounceLogRet">
    <cfinvokeargument name="nID" value="#ARGUMENTS.nID#"/>
    <cfinvokeargument name="subID" value="#ARGUMENTS.subID#"/>
    <cfinvokeargument name="nblStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getNewsletterBounceLogRet.recordcount EQ 0>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    INSERT INTO tbl_newsletter_bounce_log (nID,subID,subEmail,siteNo,ercID,nblStatus) VALUES
    (
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.nID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.subID#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.subEmail#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.siteNo#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ercID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.nblStatus#">
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
    
    <cffunction name="updateNewsletterSubscriptionLists" access="public" returntype="struct">
    <cfargument name="subID" type="numeric" required="yes">
    <cfargument name="subEmail" type="string" required="yes">
    <cfargument name="siteNo" type="numeric" required="yes">
    <cfset result.message = "You have successfully updated the records.">
    <cftry>
    <cfinvoke 
    component="MCMS.component.app.subscription.Subscription"
    method="updateSubscriptionList"
    returnvariable="updateSubscriptionListRet">
    <cfinvokeargument name="ID" value="#ARGUMENTS.subID#"/>
    <cfinvokeargument name="subStatus" value="2"/>
    </cfinvoke>
    <cfinvoke 
    component="MCMS.component.app.subscription.Subscription"
    method="updateSubscriptionSiteRelList"
    returnvariable="updateSubscriptionSiteRelListRet">
    <cfinvokeargument name="subID" value="#ARGUMENTS.subID#"/>
    <cfinvokeargument name="ssrStatus" value="2"/>
    </cfinvoke>
    <cfif ARGUMENTS.siteNo EQ 100>
    <cfinvoke 
    component="MCMS.component.app.subscription.Subscription"
    method="updateSubscriptionImportList"
    returnvariable="updateSubscriptionImportListRet">
    <cfinvokeargument name="subEmail" value="#ARGUMENTS.subEmail#"/>
    <cfinvokeargument name="siStatus" value="2"/>
    </cfinvoke>
    </cfif>
    <cfcatch type="any">
    <cfset result.message = "There was an error updating the records.">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="insertNewsletterIncentive" access="public" returntype="struct">
    <cfargument name="nID" type="numeric" required="yes">
    <cfargument name="niName" type="string" required="yes">
    <cfargument name="niDescription" type="string" required="yes">
    <cfargument name="niCode" type="string" required="yes">
    <cfargument name="niDateRel" type="string" required="yes">
    <cfargument name="niDateExp" type="string" required="yes">
    <cfargument name="bID" type="numeric" required="yes">
    <cfargument name="niStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully inserted the record.">
    <cftry>
    <!---Check for profanity in the text.--->
    <cfinvoke 
    component="MCMS.component.utility.Regex"
    method="regexProfanity"
    returnvariable="regexProfanityRet">
    <cfinvokeargument name="profanityString" value="#ARGUMENTS.niDescription#"/>
    </cfinvoke>
    <!---Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.app.newsletter.Newsletter"
    method="getNewsletterIncentive"
    returnvariable="getCheckNewsletterIncentiveRet">
    <cfinvokeargument name="nID" value="#ARGUMENTS.nID#"/>
    <cfinvokeargument name="niCode" value="#ARGUMENTS.niCode#"/>
    <cfinvokeargument name="niStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckNewsletterIncentiveRet.recordcount NEQ 0>
    <cfset result.message = "The incentive already exists, please try again.">
    <cfelseif regexProfanityRet CONTAINS '$%&*!'>
    <cfset result.message = "Some text contained profanity, please remove any profanity from your description.">
    <!---Check length restriction.--->
    <cfelseif LEN(ARGUMENTS.niDescription) GT 1024>
    <cfset result.message = "The message is longer than 1024 characters, please enter a new message under 1024 characters.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    INSERT INTO tbl_newsletter_incentive (nID,niName,niDescription,niCode,niDateRel,niDateExp,bID,niStatus) VALUES
    (
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.nID#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.niName#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.niDescription#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.niCode#">,
    <cfqueryparam cfsqltype="cf_sql_date" value="#ARGUMENTS.niDateRel#">,
    <cfqueryparam cfsqltype="cf_sql_date" value="#ARGUMENTS.niDateExp#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.bID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.niStatus#">
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
    
    <cffunction name="updateNewsletter" access="public" returntype="struct">
    <cfargument name="ID" type="numeric" required="yes">
    <cfargument name="uaID" type="numeric" required="yes">
    <cfargument name="nName" type="string" required="yes">
    <cfargument name="nDescription" type="string" required="yes">
    <cfargument name="nNotes" type="string" required="yes">
    <cfargument name="nDateRel" type="date" required="yes">
    <cfargument name="nDateExp" type="date" required="yes">
    <cfargument name="ntID" type="numeric" required="yes">
    <cfargument name="nStatus" type="numeric" required="yes">
    <!---Email arguments.--->
    <cfargument name="emailNotify" type="string" required="yes">
    <!---Relationship arguments.--->
    <cfargument name="siteNo" type="string" required="yes">
    <cfset result.message = "You have successfully updated the record.">
    <cftry>
    <!---Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.app.newsletter.Newsletter"
    method="getNewsletter"
    returnvariable="getCheckNewsletterRet">
    <cfinvokeargument name="excludeID" value="#ARGUMENTS.ID#"/>
    <cfinvokeargument name="nName" value="#ARGUMENTS.nName#"/>
    <cfinvokeargument name="nStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckNewsletterRet.recordcount NEQ 0>
    <cfset result.message = "The name #ARGUMENTS.nName# already exists, please enter a new name.">
    <!---Check length restriction.--->
    <cfelseif LEN(ARGUMENTS.nDescription) GT 255>
    <cfset result.message = "The description is longer than 255 characters, please enter a new description under 255 characters.">
    <cfelseif LEN(ARGUMENTS.nNotes) GT 1024>
    <cfset result.message = "The notes is longer than 1024 characters, please enter new notes under 1024 characters.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_newsletter SET
    nName = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.nName#">,
    nDescription = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.nDescription#">,
    nNotes = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.nNotes#">,
    nDateRel = <cfqueryparam cfsqltype="cf_sql_date" value="#ARGUMENTS.nDateRel#">,
    nDateExp = <cfqueryparam cfsqltype="cf_sql_date" value="#ARGUMENTS.nDateExp#">,
    ntID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ntID#">,
    <cfif ARGUMENTS.uaID NEQ 101>
    nDateUpdate = <cfqueryparam cfsqltype="cf_sql_timestamp" value="#Now()#">,
    userID = <cfqueryparam cfsqltype="cf_sql_integer" value="#session.userID#">,
    </cfif>
    nStatus = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.nStatus#">
    WHERE ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ID#">
    </cfquery>
    </cftransaction>
    <!---Get a list of site managers to send a notification too based on their role and site relationships.--->
    <cfinvoke
    component="MCMS.component.cms.User"
    method="getUserSiteRel"
    returnvariable="getUserSiteRelRet">
    <cfinvokeargument name="urID" value="104"/>
    <cfif ARGUMENTS.siteNo DOES NOT CONTAIN 100>
    <cfinvokeargument name="siteNo" value="#ARGUMENTS.siteNo#"/>
    </cfif>
    <cfinvokeargument name="usrStatus" value="1"/>
    </cfinvoke>
    <!---Delete any existing relationships.--->
    <cfinvoke 
    component="MCMS.component.app.newsletter.Newsletter"
    method="deleteNewsletterSiteRel"
    returnvariable="deleteNewsletterSiteRelRet">
    <cfinvokeargument name="nID" value="#ARGUMENTS.ID#"/>
    </cfinvoke>
    <!---Create site relationships.--->
    <cfloop index="siteNo" list="#ARGUMENTS.siteNo#">
    <cfinvoke 
    component="MCMS.component.app.newsletter.Newsletter"
    method="insertNewsletterSiteRel"
    returnvariable="insertNewsletterSiteRelRet">
    <cfinvokeargument name="nID" value="#ARGUMENTS.ID#"/>
    <cfinvokeargument name="siteNo" value="#siteNo#"/>
    <cfinvokeargument name="nsrStatus" value="1"/>
    </cfinvoke>
    </cfloop>
    <!---Do not send newsletter notifcation for preview nesletters.--->
    <cfif ARGUMENTS.nStatus EQ 1 AND ARGUMENTS.emailNotify EQ 'true' AND getUserSiteRelRet.recordcount NEQ 0>
    <cfset this.emailContent = '
	#session.userName# has updated a new newsletter called "#ARGUMENTS.nName#". The newsletter requires your message. The release dates for this newsletter are between #DateFormat(ARGUMENTS.nDateRel, application.dateFormat)# - #DateFormat(ARGUMENTS.nDateExp, application.dateFormat)#. You may receive duplicate notifications of this due to corrections made by the Marketing Dept. or if you are responsible for multiple sites. Please <a href="http://#CGI.HTTP_HOST#/#application.mcmsAppAdminPath#/?appID=#url.appID#">Sign-In</a> and create your message to ensure it can be reviewed and your newsletter can be sent, thank you.
	<br/><br/>
	#ARGUMENTS.nNotes#
	'>
    <cfset this.siteManagerEmail = ValueList(getUserSiteRelRet.userEmail)>
    <!---Send email notification to site managers.--->
    <cfinvoke 
    component="MCMS.component.utility.Email"
    method="sendEmail">
    <cfinvokeargument name="subject" value="#ARGUMENTS.nName# Newsletter Message Required by #DateFormat(ARGUMENTS.nDateRel, application.dateFormat)#"/>
    <cfinvokeargument name="to" value="#application.webmasterEmail#"/>
    <cfinvokeargument name="from" value="#session.userUsername#"/>
    <cfinvokeargument name="cc" value="#this.siteManagerEmail#"/>
    <cfinvokeargument name="bcc" value=""/>
    <cfinvokeargument name="body" value="#this.emailContent#"/>
    <cfinvokeargument name="emailType" value="html"/>
    <cfinvokeargument name="type" value="admin"/>
    </cfinvoke>
    </cfif>
    </cfif>
    <cfcatch type="any">
    <cfset result.message = "There was an error updating the record.">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="updateNewsletterTemplate" access="public" returntype="struct">
    <cfargument name="ID" type="numeric" required="yes">
    <cfargument name="ntName" type="string" required="yes">
    <cfargument name="ntDescription" type="string" required="yes">
    <cfargument name="ntFile" type="string" required="yes">
    <cfargument name="ntStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully updated the record.">
    <cftry>
    <!---Check for profanity in the text.--->
    <cfinvoke 
    component="MCMS.component.utility.Regex"
    method="regexProfanity"
    returnvariable="regexProfanityRet">
    <cfinvokeargument name="profanityString" value="#ARGUMENTS.ntDescription#"/>
    </cfinvoke>
    <!---Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.app.newsletter.Newsletter"
    method="getNewsletterTemplate"
    returnvariable="getCheckNewsletterTemplateRet">
    <cfinvokeargument name="excludeID" value="#ARGUMENTS.ID#"/>
    <cfinvokeargument name="ntName" value="#ARGUMENTS.ntName#"/>
    <cfinvokeargument name="ntStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckNewsletterTemplateRet.recordcount NEQ 0>
    <cfset result.message = "The name #ARGUMENTS.ntName# already exists, please enter a new name.">
    <cfelseif regexProfanityRet CONTAINS '$%&*!'>
    <cfset result.message = "Some text contained profanity, please remove any profanity from your text.">
    <!---Check length restriction.--->
    <cfelseif LEN(ARGUMENTS.ntDescription) GT 255>
    <cfset result.message = "The description is longer than 255 characters, please enter a new description under 255 characters.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_newsletter_template SET
    ntName = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.ntName#">,
    ntDescription = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.ntDescription#">,
    ntFile = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.ntFile#">,
    ntStatus = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ntStatus#">
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
    
    <cffunction name="updateNewsletterMessage" access="public" returntype="struct">
    <cfargument name="ID" type="numeric" required="yes">
    <cfargument name="uaID" type="numeric" required="yes">
    <cfargument name="nID" type="string" required="yes">
    <cfargument name="nmSubject" type="string" required="yes">
    <cfargument name="nmMessage" type="string" required="yes">
    <cfargument name="nmStatus" type="numeric" required="yes">
    <!---Email arguments.--->
    <cfargument name="emailNotify" type="string" required="yes">
    <cfif ARGUMENTS.nmStatus EQ 1>
    <cfset result.message = "You have successfully updated the record for immediate approval.">
    <cfelseif ARGUMENTS.nmStatus EQ 3>
    <cfset result.message = "You have successfully updated the record for review.">
    <cfelse>
    <cfset result.message = "You have successfully updated the record.">
    </cfif>
    <cftry>
    <!---Check for profanity in the text.--->
    <cfinvoke 
    component="MCMS.component.utility.Regex"
    method="regexProfanity"
    returnvariable="regexProfanityRet">
    <cfinvokeargument name="profanityString" value="#ARGUMENTS.nmMessage#"/>
    </cfinvoke>
    <!---Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.app.newsletter.Newsletter"
    method="getNewsletterMessage"
    returnvariable="getCheckNewsletterMessageRet">
    <cfinvokeargument name="excludeID" value="#ARGUMENTS.ID#"/>
    <cfinvokeargument name="nID" value="#ARGUMENTS.nID#"/>
    <cfinvokeargument name="siteNo" value="#ARGUMENTS.siteNo#"/>
    <cfinvokeargument name="nmStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckNewsletterMessageRet.recordcount NEQ 0>
    <cfset result.message = "The message for your site and this newsletter already exists, please try again.">
    <cfelseif regexProfanityRet CONTAINS '$%&*!'>
    <cfset result.message = "Some text contained profanity, please remove any profanity from your message.">
    <!---Check length restriction.--->
    <cfelseif LEN(ARGUMENTS.nmMessage) GT 4096>
    <cfset result.message = "The message is longer than 4096 characters, please enter a new message under 4096 characters.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_newsletter_message SET
    nID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.nID#">,
    siteNo = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.siteNo#">,
    nmSubject = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.nmSubject#">,
    nmMessage = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.nmMessage#">,
    <cfif ARGUMENTS.uaID NEQ 101>
    nmDateUpdate = <cfqueryparam cfsqltype="cf_sql_timestamp" value="#Now()#">,
    userID = <cfqueryparam cfsqltype="cf_sql_integer" value="#session.userID#">,
    </cfif>
    nmStatus = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.nmStatus#">
    WHERE ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ID#">
    </cfquery>
    </cftransaction>
    <!---Do not send message notifcation for preview messages.--->
    <cfif ARGUMENTS.emailNotify EQ 'true'>
    <!---Get a list of site managers to send a notification too based on their role and site relationships.--->
    <cfinvoke
    component="MCMS.component.cms.User"
    method="getUserSiteRel"
    returnvariable="getUserSiteRelRet">
    <cfinvokeargument name="urID" value="104"/>
    <cfif ARGUMENTS.siteNo DOES NOT CONTAIN 100>
    <cfinvokeargument name="siteNo" value="#ARGUMENTS.siteNo#"/>
    </cfif>
    <cfinvokeargument name="usrStatus" value="1"/>
    </cfinvoke>
    <cfset this.siteManagerEmail = ValueList(getUserSiteRelRet.userEmail)>
    <!---Get newsletter details to send in email notification.--->
    <cfinvoke 
    component="MCMS.component.app.newsletter.Newsletter"
    method="getNewsletter"
    returnvariable="getNewsletterRet">
    <cfinvokeargument name="ID" value="#ARGUMENTS.nID#"/>
    <cfinvokeargument name="nStatus" value="1"/>
    </cfinvoke>
    <cfset this.emailContent = '
	#session.userName# has updated the message for #getNewsletterRet.nName#. The newsletter and message can now be modified or sent. If the newsletter is already scheduled it will now contain the new message as of #TimeFormat(Now(), 'short')#.
	'>
    <!---Send email notification to Marketing.--->
    <cfinvoke 
    component="MCMS.component.utility.Email"
    method="sendEmail">
    <cfinvokeargument name="subject" value="#getNewsletterRet.nName# Message Updated for #ARGUMENTS.siteNo#"/>
    <cfinvokeargument name="to" value="#application.newsletterAdminEmail#"/>
    <cfinvokeargument name="from" value="#session.userUsername#"/>
    <cfinvokeargument name="cc" value="#this.siteManagerEmail#"/>
    <cfinvokeargument name="bcc" value="#application.webmasterEmail#"/>
    <cfinvokeargument name="body" value="#this.emailContent#"/>
    <cfinvokeargument name="emailType" value="html"/>
    <cfinvokeargument name="type" value="admin"/>
    </cfinvoke>
    </cfif>
    </cfif>
    <cfcatch type="any">
    <cfset result.message = "There was an error updating the record.">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="updateNewsletterIncentive" access="public" returntype="struct">
    <cfargument name="ID" type="numeric" required="yes">
    <cfargument name="nID" type="numeric" required="yes">
    <cfargument name="niName" type="string" required="yes">
    <cfargument name="niDescription" type="string" required="yes">
    <cfargument name="niCode" type="string" required="yes">
    <cfargument name="niDateRel" type="string" required="yes">
    <cfargument name="niDateExp" type="string" required="yes">
    <cfargument name="bID" type="numeric" required="yes">
    <cfargument name="niStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully updated the record.">
    <cftry>
    <!---Check for profanity in the text.--->
    <cfinvoke 
    component="MCMS.component.utility.Regex"
    method="regexProfanity"
    returnvariable="regexProfanityRet">
    <cfinvokeargument name="profanityString" value="#ARGUMENTS.niDescription#"/>
    </cfinvoke>
    <!---Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.app.newsletter.Newsletter"
    method="getNewsletterIncentive"
    returnvariable="getCheckNewsletterIncentiveRet">
    <cfinvokeargument name="excludeID" value="#ARGUMENTS.ID#"/>
    <cfinvokeargument name="nID" value="#ARGUMENTS.nID#"/>
    <cfinvokeargument name="niCode" value="#ARGUMENTS.niCode#"/>
    <cfinvokeargument name="niStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckNewsletterIncentiveRet.recordcount NEQ 0>
    <cfset result.message = "The incentive #ARGUMENTS.niName# already exists with the Code #ARGUMENTS.niCode#, please enter a new name/code.">
    <cfelseif regexProfanityRet CONTAINS '$%&*!'>
    <cfset result.message = "Some text contained profanity, please remove any profanity from your text.">
    <!---Check length restriction.--->
    <cfelseif LEN(ARGUMENTS.niDescription) GT 1024>
    <cfset result.message = "The description is longer than 1024 characters, please enter a new description under 1024 characters.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_newsletter_incentive SET
    nID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.nID#">,
    niName = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.niName#">,
    niDescription = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.niDescription#">,
    niCode = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.niCode#">,
    niDateRel = <cfqueryparam cfsqltype="cf_sql_date" value="#ARGUMENTS.niDateRel#">,
    niDateExp = <cfqueryparam cfsqltype="cf_sql_date" value="#ARGUMENTS.niDateExp#">,
    bID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.bID#">,
    niStatus = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.niStatus#">
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
    
    <cffunction name="updateNewsletterList" access="public" returntype="struct">
    <cfargument name="ID" type="numeric" required="yes">
    <cfargument name="nStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully updated the records.">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_newsletter SET
    nStatus = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.nStatus#">
    WHERE ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ID#">
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error updating the records.">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="updateNewsletterTemplateList" access="public" returntype="struct">
    <cfargument name="ID" type="numeric" required="yes">
    <cfargument name="ntStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully updated the records.">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_newsletter_template SET
    ntStatus = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ntStatus#">
    WHERE ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ID#">
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error updating the records.">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="updateNewsletterMessageList" access="public" returntype="struct">
    <cfargument name="ID" type="numeric" required="yes">
    <cfargument name="nmStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully updated the records.">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_newsletter_message SET
    nmStatus = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.nmStatus#">
    WHERE ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ID#">
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error updating the records.">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="updateNewsletterIncentiveList" access="public" returntype="struct">
    <cfargument name="ID" type="numeric" required="yes">
    <cfargument name="niStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully updated the records.">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_newsletter_incentive SET
    niStatus = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.niStatus#">
    WHERE ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ID#">
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error updating the records.">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="deleteNewsletter" access="public" returntype="struct">
    <cfargument name="ID" type="string" required="yes">
    <cfset result.message = "You have successfully deleted the record(s).">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    DELETE FROM tbl_newsletter
    WHERE ID IN (<cfqueryparam cfsqltype="cf_sql_integer" list="yes" value="#ARGUMENTS.ID#">)
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error deleting the record(s).">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction> 
    
    <cffunction name="deleteNewsletterTemplate" access="public" returntype="struct">
    <cfargument name="ID" type="string" required="yes">
    <cfset result.message = "You have successfully deleted the record(s).">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    DELETE FROM tbl_newsletter_template
    WHERE ID IN (<cfqueryparam cfsqltype="cf_sql_integer" list="yes" value="#ARGUMENTS.ID#">)
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error deleting the record(s).">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction> 
    
    <cffunction name="deleteNewsletterMessage" access="public" returntype="struct">
    <cfargument name="ID" type="string" required="yes">
    <cfset result.message = "You have successfully deleted the record(s).">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    DELETE FROM tbl_newsletter_message
    WHERE ID IN (<cfqueryparam cfsqltype="cf_sql_integer" list="yes" value="#ARGUMENTS.ID#">)
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error deleting the record(s).">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="deleteNewsletterSiteRel" access="public" returntype="struct">
    <cfargument name="ID" type="string" required="yes" default="0">
    <cfargument name="nID" type="string" required="yes" default="0">
    <cfset result.message = "You have successfully deleted the record(s).">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    DELETE FROM tbl_newsletter_site_rel
    WHERE ID IN (<cfqueryparam cfsqltype="cf_sql_integer" list="yes" value="#ARGUMENTS.ID#">)
    OR nID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.nID#">
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error deleting the record(s).">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>  
    
    <cffunction name="deleteNewsletterIncentive" access="public" returntype="struct">
    <cfargument name="ID" type="string" required="yes">
    <cfset result.message = "You have successfully deleted the record(s).">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    DELETE FROM tbl_newsletter_incentive
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