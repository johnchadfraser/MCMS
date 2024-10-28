<cfcomponent>
    <cffunction name="getFishingReport" access="public" returntype="query" hint="Get Fishing Report data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="siteNo" type="string" required="yes" default="100">
    <cfargument name="ID" type="numeric" required="yes" default="0">
    <cfargument name="excludeID" type="numeric" required="yes" default="0">
    <cfargument name="frlID" type="numeric" required="yes" default="0">
    <cfargument name="frDateExp" type="string" required="yes" default="">
    <cfargument name="frlStatus" type="string" required="no" default="1">
    <cfargument name="frStatus" type="string" required="yes" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="frlName">
    <cfset var rsFishingReport = "" >
    <cftry>
    <cfquery name="rsFishingReport" datasource="#application.mcmsDSN#">
    SELECT * FROM v_fishing_report WHERE 0=0
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(frlName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(frDescription) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">)
    </cfif>
    <cfif ARGUMENTS.siteNo NEQ 100>
    AND siteNo IN (<cfqueryparam value="#ARGUMENTS.siteNo#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    <cfif ARGUMENTS.ID NEQ 0>
    AND ID = <cfqueryparam value="#ARGUMENTS.ID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.excludeID NEQ 0>
    AND ID <> <cfqueryparam value="#ARGUMENTS.excludeID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.frlID NEQ 0>
    AND frlID = <cfqueryparam value="#UCASE(ARGUMENTS.frlID)#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.frDateExp NEQ "">
    AND frDateExp >= <cfqueryparam value="#ARGUMENTS.frDateExp#" cfsqltype="cf_sql_date">
	</cfif>
    AND frlStatus IN (<cfqueryparam value="#ARGUMENTS.frlStatus#" list="yes" cfsqltype="cf_sql_integer">)
    AND frStatus IN (<cfqueryparam value="#ARGUMENTS.frStatus#" list="yes" cfsqltype="cf_sql_integer">)
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsFishingReport = StructNew()>
    <cfset rsFishingReport.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsFishingReport>
    </cffunction>
    
    <cffunction name="getFishingReportLocation" access="public" returntype="query" hint="Get Fishing Report Location data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="siteNo" type="string" required="yes" default="100">
    <cfargument name="ID" type="numeric" required="yes" default="0">
    <cfargument name="excludeID" type="numeric" required="yes" default="0">
    <cfargument name="frlName" type="string" required="yes" default="">
    <cfargument name="siteStatus" type="string" required="no" default="1">
    <cfargument name="frltStatus" type="string" required="no" default="1">
    <cfargument name="frlStatus" type="string" required="yes" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="frlName">
    <cfset var rsFishingReportLocation = "" >
    <cftry>
    <cfquery name="rsFishingReportLocation" datasource="#application.mcmsDSN#">
    SELECT * FROM v_fishing_report_location WHERE 0=0
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(frlName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">)
    </cfif>
    <cfif ARGUMENTS.siteNo NEQ 100>
    AND siteNo IN (<cfqueryparam value="#ARGUMENTS.siteNo#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    <cfif ARGUMENTS.ID NEQ 0>
    AND ID = <cfqueryparam value="#ARGUMENTS.ID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.excludeID NEQ 0>
    AND ID <> <cfqueryparam value="#ARGUMENTS.excludeID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.frlName NEQ "">
    AND frlName = <cfqueryparam value="#ARGUMENTS.frlName#" cfsqltype="cf_sql_varchar">
    </cfif>
    AND siteStatus IN (<cfqueryparam value="#ARGUMENTS.siteStatus#" list="yes" cfsqltype="cf_sql_integer">)
    AND frltStatus IN (<cfqueryparam value="#ARGUMENTS.frltStatus#" list="yes" cfsqltype="cf_sql_integer">)
    AND frlStatus IN (<cfqueryparam value="#ARGUMENTS.frlStatus#" list="yes" cfsqltype="cf_sql_integer">)
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsFishingReportLocation = StructNew()>
    <cfset rsFishingReportLocation.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsFishingReportLocation>
    </cffunction>
    
    <cffunction name="getFishingReportRegulation" access="public" returntype="query" hint="Get Fishing Report Regulation data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="siteNo" type="string" required="yes" default="100">
    <cfargument name="ID" type="numeric" required="yes" default="0">
    <cfargument name="excludeID" type="numeric" required="yes" default="0">
    <cfargument name="frregName" type="string" required="yes" default="">
    <cfargument name="siteStatus" type="string" required="no" default="1">
    <cfargument name="frregStatus" type="string" required="yes" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="frregName">
    <cfset var rsFishingReportRegulation = "" >
    <cftry>
    <cfquery name="rsFishingReportRegulation" datasource="#application.mcmsDSN#">
    SELECT * FROM v_fishing_report_regulation WHERE 0=0
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND UPPER(frregName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">
    </cfif>
    <cfif ARGUMENTS.siteNo NEQ 100>
    AND siteNo IN (<cfqueryparam value="#ARGUMENTS.siteNo#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    <cfif ARGUMENTS.ID NEQ 0>
    AND ID = <cfqueryparam value="#ARGUMENTS.ID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.excludeID NEQ 0>
    AND ID <> <cfqueryparam value="#ARGUMENTS.excludeID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.frregName NEQ "">
    AND frregName = <cfqueryparam value="#ARGUMENTS.frregName#" cfsqltype="cf_sql_varchar">
    </cfif>
    AND siteStatus IN (<cfqueryparam value="#ARGUMENTS.siteStatus#" list="yes" cfsqltype="cf_sql_integer">)
    AND frregStatus IN (<cfqueryparam value="#ARGUMENTS.frregStatus#" list="yes" cfsqltype="cf_sql_integer">)
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsFishingReportRegulation = StructNew()>
    <cfset rsFishingReportRegulation.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsFishingReportRegulation>
    </cffunction>
    
    <cffunction name="getFishingReportRating" access="public" returntype="query" hint="Get Fishing Report Rating data.">
    <cfargument name="ID" type="numeric" required="yes" default="0">
    <cfargument name="frrStatus" type="string" required="yes" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="frrName">
    <cfset var rsFishingReportRating = "" >
    <cftry>
    <cfquery name="rsFishingReportRating" datasource="#application.mcmsDSN#">
    SELECT * FROM tbl_fishing_report_rating WHERE 0=0
    <cfif ARGUMENTS.ID NEQ 0>
    AND ID = <cfqueryparam value="#ARGUMENTS.ID#" cfsqltype="cf_sql_integer">
    </cfif>
    AND frrStatus IN (<cfqueryparam value="#ARGUMENTS.frrStatus#" list="yes" cfsqltype="cf_sql_integer">)
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsFishingReportRating = StructNew()>
    <cfset rsFishingReportRating.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsFishingReportRating>
    </cffunction>
    
    <cffunction name="getFRLocationType" access="public" returntype="query" hint="Get Fishing Report Location Type data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="ID" type="numeric" required="yes" default="0">
    <cfargument name="frltStatus" type="string" required="yes" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="frltName">
    <cfset var rsFRLocationType = "" >
    <cftry>
    <cfquery name="rsFRLocationType" datasource="#application.mcmsDSN#">
    SELECT * FROM tbl_fr_location_type WHERE 0=0
    <cfif ARGUMENTS.ID NEQ 0>
    AND ID = <cfqueryparam value="#ARGUMENTS.ID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND UPPER(frltName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">
    </cfif>
    AND frltStatus IN (<cfqueryparam value="#ARGUMENTS.frltStatus#" list="yes" cfsqltype="cf_sql_integer">)
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsFRLocationType = StructNew()>
    <cfset rsFRLocationType.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsFRLocationType>
    </cffunction>
    
    <cffunction name="getFRLocationImage" access="public" returntype="query" hint="Get Fishing Report Location Image data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="ID" type="numeric" required="yes" default="0">
    <cfargument name="frlID" type="numeric" required="yes" default="0">
    <cfargument name="imgID" type="numeric" required="yes" default="0">
    <cfargument name="siteStatus" type="string" required="no" default="1">
    <cfargument name="imgStatus" type="string" required="no" default="1">
    <cfargument name="frlirStatus" type="string" required="yes" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="frlName">
    <cfset var rsFRLocationImage = "" >
    <cftry>
    <cfquery name="rsFRLocationImage" datasource="#application.mcmsDSN#">
    SELECT * FROM v_fr_location_image_rel WHERE 0=0
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND UPPER(frlName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">
    </cfif>
    <cfif ARGUMENTS.ID NEQ 0>
    AND ID = <cfqueryparam value="#ARGUMENTS.ID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.frlID NEQ 0>
    AND frlID = <cfqueryparam value="#ARGUMENTS.frlID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.imgID NEQ 0>
    AND imgID = <cfqueryparam value="#ARGUMENTS.imgID#" cfsqltype="cf_sql_integer">
    </cfif>
    AND imgStatus IN (<cfqueryparam value="#ARGUMENTS.imgStatus#" list="yes" cfsqltype="cf_sql_integer">)
    AND siteStatus IN (<cfqueryparam value="#ARGUMENTS.siteStatus#" list="yes" cfsqltype="cf_sql_integer">)
    AND frlirStatus IN (<cfqueryparam value="#ARGUMENTS.frlirStatus#" list="yes" cfsqltype="cf_sql_integer">)
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsFRLocationImage = StructNew()>
    <cfset rsFRLocationImage.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsFRLocationImage>
    </cffunction>
        
    <cffunction name="getFRReport" access="public" returntype="query" hint="Get FR Report data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
	  <cfargument name="siteNo" type="string" required="yes" default="100">
    <cfargument name="orderBy" type="string" required="yes" default="frlName">
    <cfset var rsFishingReport = "" >
    <cfquery name="rsFishingReport" datasource="#application.mcmsDSN#">
    SELECT frlName AS Name, TO_CHAR(frDescription) AS Description, TO_CHAR(frDateExp,'MM/DD/YYYY') AS Expiration_Date, frltName AS Type, frrName AS Rating, siteName AS Site, sName AS Status FROM v_fishing_report WHERE 0=0
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(frlName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(frDescription) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">)
    </cfif>
    <cfif ARGUMENTS.siteNo NEQ 100>
    AND siteNo IN (<cfqueryparam value="#ARGUMENTS.siteNo#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <cfreturn rsFishingReport>
    </cffunction>
    
    <cffunction name="getFRExcelQuickReport" access="public" returntype="query" hint="Get FR Excel Quick Report data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
	<cfargument name="frlStatus" type="string" required="no" default="1,3">
    <cfargument name="frStatus" type="string" required="yes" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="frlName">
    <cfset var rsFishingReport = "" >
    <cftry>
    <cfquery name="rsFishingReport" datasource="#application.mcmsDSN#">
    SELECT frlName AS Name, TO_CHAR(frDescription) AS Description, TO_CHAR(frDateExp,'MM/DD/YYYY') AS Expiration_Date, frltName AS Type, frrName AS Rating, siteName AS Site, sName AS Status FROM v_fishing_report WHERE 0=0
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND UPPER(frlName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">
    </cfif>
    AND frDateExp >= <cfqueryparam value="#Now()#" cfsqltype="cf_sql_date">
    AND frlStatus IN (<cfqueryparam value="#ARGUMENTS.frlStatus#" list="yes" cfsqltype="cf_sql_integer">)
    AND frStatus IN (<cfqueryparam value="#ARGUMENTS.frStatus#" list="yes" cfsqltype="cf_sql_integer">)
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsEventListingExcelQuickReport = StructNew()>
    <cfset rsEventListingExcelQuickReport.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsFishingReport>
    </cffunction>
    
    <cffunction name="getFRLocationReport" access="public" returntype="query" hint="Get FR Location Report data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
	  <cfargument name="siteNo" type="string" required="yes" default="100">
    <cfargument name="orderBy" type="string" required="yes" default="frlName">
    <cfset var rsFishingReport = "" >
    <cfquery name="rsFishingReport" datasource="#application.mcmsDSN#">
    SELECT frlName AS Location_Name, frlAccess AS Location_Access, frltName AS Location_Type, frRegName AS Regulation, frlGPS AS GPS_Coords, frlWeatherURL AS Weather_URL, siteName AS Site, sName AS Status FROM v_fishing_report_location WHERE 0=0
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND UPPER(frlName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">
    </cfif>
    <cfif ARGUMENTS.siteNo NEQ 100>
    AND siteNo IN (<cfqueryparam value="#ARGUMENTS.siteNo#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <cfreturn rsFishingReport>
    </cffunction>
    
    <cffunction name="getFRRegulationReport" access="public" returntype="query" hint="Get FR Regulation Report data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
	  <cfargument name="siteNo" type="string" required="yes" default="100">
    <cfargument name="orderBy" type="string" required="yes" default="frregName">
    <cfset var rsFishingReport = "" >
    <cfquery name="rsFishingReport" datasource="#application.mcmsDSN#">
    SELECT frRegName AS Name, frRegURL AS URL, siteName AS Site, sName AS Status FROM v_fishing_report_regulation WHERE 0=0
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND UPPER(frregName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">
    </cfif>
    <cfif ARGUMENTS.siteNo NEQ 100>
    AND siteNo IN (<cfqueryparam value="#ARGUMENTS.siteNo#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <cfreturn rsFishingReport>
    </cffunction>
    
    <cffunction name="getFRLocationImageReport" access="public" returntype="query" hint="Get FR Location Image Report data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
	  <cfargument name="siteNo" type="string" required="yes" default="100">
    <cfargument name="orderBy" type="string" required="yes" default="frlName">
    <cfset var rsFishingReport = "" >
    <cfquery name="rsFishingReport" datasource="#application.mcmsDSN#">
    SELECT imgName AS Image_Name, frlName AS Location_Name, imgFile AS Image_File, siteName AS Site, sName AS Status FROM v_fr_location_image_rel WHERE 0=0
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND UPPER(frlName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">
    </cfif>
    <cfif ARGUMENTS.siteNo NEQ 100>
    AND siteNo IN (<cfqueryparam value="#ARGUMENTS.siteNo#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <cfreturn rsFishingReport>
    </cffunction>
	
    <cffunction name="insertFishingReport" access="public" returntype="struct">
    <cfargument name="frlID" type="numeric" required="yes">
    <cfargument name="frDescription" type="string" required="yes">
    <cfargument name="frDate" type="date" required="yes">
    <cfargument name="frDateExp" type="date" required="yes">
    <cfargument name="frrID" type="numeric" required="yes">
    <cfargument name="frStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully inserted the record.">
    <cftry>
    <!---Check for profanity in the text.--->
    <cfinvoke 
    component="MCMS.component.utility.Regex"
    method="regexProfanity"
    returnvariable="regexProfanityRet">
    <cfinvokeargument name="profanityString" value="#ARGUMENTS.frDescription#"/>
    </cfinvoke>
    <!---Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.app.fishing_report.FishingReport"
    method="getFishingReport"
    returnvariable="getCheckFishingReportRet">
    <cfinvokeargument name="frlID" value="#ARGUMENTS.frlID#"/>
    <cfinvokeargument name="frDescription" value="#ARGUMENTS.frDescription#"/>
    <cfinvokeargument name="frStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckFishingReportRet.recordcount NEQ 0>
    <cfset result.message = "The description entered already exists for this location, please try again.">
    <cfelseif regexProfanityRet CONTAINS '$%&*!'>
    <cfset result.message = "Some text contained profanity, please remove any profanity from your text.">
    <!---Check length restriction.--->
    <cfelseif LEN(ARGUMENTS.frDescription) GT 4096>
    <cfset result.message = "The description is longer than 4096 characters, please enter a new name under 4096 characters.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    INSERT INTO tbl_fishing_report (frlID,frDescription,frDate,frDateExp,frrID,frStatus) VALUES
    (
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.frlID#">,
    <cfqueryparam cfsqltype="cf_sql_clob" value="#ARGUMENTS.frDescription#">,
    <cfqueryparam cfsqltype="cf_sql_date" value="#ARGUMENTS.frDate#">,
    <cfqueryparam cfsqltype="cf_sql_date" value="#ARGUMENTS.frDateExp#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.frrID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.frStatus#">
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
    
    <cffunction name="insertFishingReportLocation" access="public" returntype="struct">
    <cfargument name="siteNo" type="string" required="yes">
    <cfargument name="frlName" type="string" required="yes">
    <cfargument name="frlAccess" type="string" required="yes">
    <cfargument name="frltID" type="numeric" required="yes">
    <cfargument name="frRegID" type="numeric" required="yes">
    <cfargument name="frlGPS" type="string" required="yes">
    <cfargument name="frlWeatherUrl" type="string" required="yes">
    <cfargument name="frlStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully inserted the record.">
    <cftry>-
    <!---Check for profanity in the text.--->
    <cfinvoke 
    component="MCMS.component.utility.Regex"
    method="regexProfanity"
    returnvariable="regexProfanityRet">
    <cfinvokeargument name="profanityString" value="#ARGUMENTS.frlAccess#"/>
    </cfinvoke>
    <!---Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.app.fishing_report.FishingReport"
    method="getFishingReportLocation"
    returnvariable="getCheckFRLocationRet">
    <cfinvokeargument name="siteNo" value="#ARGUMENTS.siteNo#"/>
    <cfinvokeargument name="frlName" value="#ARGUMENTS.frlName#"/>
    <cfinvokeargument name="frlStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckFRLocationRet.recordcount NEQ 0>
    <cfset result.message = "The name #ARGUMENTS.frlName# already exists, please try again.">
    <cfelseif regexProfanityRet CONTAINS '$%&*!'>
    <cfset result.message = "Some text contained profanity, please remove any profanity from your text.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    INSERT INTO tbl_fishing_report_location (siteNo,frlName,frlAccess,frltID,frRegID,frlGps,frlWeatherUrl,frlStatus) VALUES
    (
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.siteNo#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.frlName#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.frlAccess#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.frltID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.frRegID#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.frlGps#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.frlWeatherUrl#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.frlStatus#">
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
    
    <cffunction name="insertFishingReportRegulation" access="public" returntype="struct">
    <cfargument name="siteNo" type="string" required="yes">
    <cfargument name="frregName" type="string" required="yes">
    <cfargument name="frRegUrl" type="string" required="yes">
    <cfargument name="frRegTarget" type="string" required="yes">
    <cfargument name="frregStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully inserted the record.">
    <cftry>
    <!---Check for profanity in the text.--->
    <cfinvoke 
    component="MCMS.component.utility.Regex"
    method="regexProfanity"
    returnvariable="regexProfanityRet">
    <cfinvokeargument name="profanityString" value="#ARGUMENTS.frregName#"/>
    </cfinvoke>
    <!---Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.app.fishing_report.FishingReport"
    method="getFishingReportRegulation"
    returnvariable="getCheckFRRegulationRet">
    <cfinvokeargument name="siteNo" value="#ARGUMENTS.siteNo#"/>
    <cfinvokeargument name="frregName" value="#ARGUMENTS.frregName#"/>
    <cfinvokeargument name="frregStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckFRRegulationRet.recordcount NEQ 0>
    <cfset result.message = "The name #ARGUMENTS.frregName# already exists, please try again.">
    <cfelseif regexProfanityRet CONTAINS '$%&*!'>
    <cfset result.message = "Some text contained profanity, please remove any profanity from your text.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    INSERT INTO tbl_fishing_report_regulation (siteNo,frregName,frRegUrl,frRegTarget,frregStatus) VALUES
    (
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.siteNo#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.frregName#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.frRegUrl#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.frRegTarget#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.frregStatus#">
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
    
    <cffunction name="insertFRLocationImage" access="public" returntype="struct">
    <cfargument name="frlID" type="numeric" required="yes">
    <cfargument name="imgID" type="string" required="yes">
    <cfargument name="frlirStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully inserted the record.">
    <cftry>
    <!---Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.app.fishing_report.FishingReport"
    method="getFRLocationImage"
    returnvariable="getFRLocationImageRet">
    <cfinvokeargument name="frlID" value="#ARGUMENTS.frlID#"/>
    <cfinvokeargument name="imgID" value="#ARGUMENTS.imgID#"/>
    <cfinvokeargument name="frlirStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getFRLocationImageRet.recordcount NEQ 0>
    <cfset result.message = "The image selected already exists for this location, please try again.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    INSERT INTO tbl_fr_location_image_rel (frlID,imgID,frlirStatus) VALUES
    (
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.frlID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.imgID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.frlirStatus#">
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
    
    <cffunction name="updateFishingReport" access="public" returntype="struct">
    <cfargument name="ID" type="numeric" required="yes">
    <cfargument name="frlID" type="numeric" required="yes">
    <cfargument name="frDescription" type="string" required="yes">
    <cfargument name="frDate" type="date" required="yes">
    <cfargument name="frDateExp" type="date" required="yes">
    <cfargument name="frrID" type="numeric" required="yes">
    <cfargument name="frStatus" type="numeric" required="yes">
    <!---Email arguments.--->
    <cfargument name="emailNotify" type="string" required="yes" default="false">
    <cfset result.message = "You have successfully updated the record.">
    <cftry>
    <!---Check for profanity in the text.--->
    <cfinvoke 
    component="MCMS.component.utility.Regex"
    method="regexProfanity"
    returnvariable="regexProfanityRet">
    <cfinvokeargument name="profanityString" value="#ARGUMENTS.frDescription#"/>
    </cfinvoke>
    <!---Check for a duplicate record.--->
    <cfinvoke
    component="MCMS.component.app.fishing_report.FishingReport"
    method="getFishingReport"
    returnvariable="getCheckFishingReportRet">
    <cfinvokeargument name="excludeID" value="#ARGUMENTS.ID#"/>
    <cfinvokeargument name="frlID" value="#ARGUMENTS.frlID#"/>
    <cfinvokeargument name="frDescription" value="#ARGUMENTS.frDescription#"/>
    <cfinvokeargument name="frStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckFishingReportRet.recordcount NEQ 0>
    <cfset result.message = "The description entered already exists for this location, please try again.">
    <cfelseif regexProfanityRet CONTAINS '$%&*!'>
    <cfset result.message = "Some text contained profanity, please remove any profanity from your text.">
    <!---Check length restriction.--->
    <cfelseif LEN(ARGUMENTS.frDescription) GT 4096>
    <cfset result.message = "The description is longer than 4096 characters, please enter a new name under 4096 characters.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_fishing_report SET
    frlID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.frlID#">,
    frDescription = <cfqueryparam cfsqltype="cf_sql_clob" value="#ARGUMENTS.frDescription#">,
    frDate = <cfqueryparam cfsqltype="cf_sql_date" value="#ARGUMENTS.frDate#">,
    frDateExp = <cfqueryparam cfsqltype="cf_sql_date" value="#ARGUMENTS.frDateExp#">,
    frrID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.frrID#">,
    frStatus = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.frStatus#">
    WHERE ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ID#">
    </cfquery>
    </cftransaction>
    <!---Get a list of users to send a fishing report update to.--->
    <!---Schedule to be created for the emails being sent to those subscribed to this fishing report
		
		<cfinvoke
    component="MCMS.component.app.subscription.Subscription"
    method="getFRSubscriptionRel"
    returnvariable="getFRSubscriptionRelRet">
    <cfinvokeargument name="frlID" value="#ARGUMENTS.frlID#"/>
    <cfinvokeargument name="frlStatus" value="1"/>
    <cfinvokeargument name="subStatus" value="1"/>
    </cfinvoke>
    <cfinvoke 
      component="MCMS.component.app.fishing_report.FishingReport"
      method="getFishingReport"
      returnvariable="getFishingReportRet">
	  <cfinvokeargument name="frlID" value="#ARGUMENTS.frlID#"/>
	  <cfinvokeargument name="frStatus" value="1"/>
    </cfinvoke>
    <cfif ARGUMENTS.frStatus EQ 1 AND ARGUMENTS.emailNotify EQ 'true'>
    <cfset this.emailContent = 'This message is being sent to inform you that the <b>#getFishingReportRet.frlName#</b> fishing report for the <b>#getFishingReportRet.siteName#</b> store has been updated with the following description:<br> #ARGUMENTS.frDescription#<br> Thank you.'>
    <cfset this.subEmail = ValueList(getFRSubscriptionRelRet.subEmail)>
    <!---Send email notification to site managers.--->
    <cfinvoke 
    component="MCMS.component.utility.Email"
    method="sendEmail">
    <cfinvokeargument name="subject" value=""/>
    <cfinvokeargument name="to" value="jjohnson@sportsmanswarehouse.com"/>
    <cfinvokeargument name="from" value="info@sportsmanswarehouse.com"/>
    <cfinvokeargument name="bcc" value="jjohnson@sportsmanswarehouse.com"/>
    <cfinvokeargument name="body" value="#this.emailContent#"/>
    <cfinvokeargument name="emailType" value="html"/>
    <cfinvokeargument name="type" value="admin"/>
    </cfinvoke>
    </cfif>--->
    </cfif>
    <cfcatch type="any">
    <cfset result.message = "There was an error updating the record.">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="updateFishingReportLocation" access="public" returntype="struct">
    <cfargument name="ID" type="numeric" required="yes">
    <cfargument name="siteNo" type="string" required="yes">
    <cfargument name="frlName" type="string" required="yes">
    <cfargument name="frlAccess" type="string" required="yes">
    <cfargument name="frltID" type="numeric" required="yes">
    <cfargument name="frRegID" type="numeric" required="yes">
    <cfargument name="frlGPS" type="string" required="yes">
    <cfargument name="frlWeatherUrl" type="string" required="yes">
    <cfargument name="frlStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully updated the record.">
    <cftry>
    <!---Check for profanity in the text.--->
    <cfinvoke 
    component="MCMS.component.utility.Regex"
    method="regexProfanity"
    returnvariable="regexProfanityRet">
    <cfinvokeargument name="profanityString" value="#ARGUMENTS.frlAccess#"/>
    </cfinvoke>
    <!---Check for a duplicate record.--->
    <cfinvoke
    component="MCMS.component.app.fishing_report.FishingReport"
    method="getFishingReportLocation"
    returnvariable="getCheckFRLocationRet">
    <cfinvokeargument name="excludeID" value="#ARGUMENTS.ID#"/>
    <cfinvokeargument name="siteNo" value="#ARGUMENTS.siteNo#"/>
    <cfinvokeargument name="frlName" value="#ARGUMENTS.frlName#"/>
    <cfinvokeargument name="frlStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckFRLocationRet.recordcount NEQ 0>
    <cfset result.message = "The name #ARGUMENTS.frlName# already exists, please try again.">
    <cfelseif regexProfanityRet CONTAINS '$%&*!'>
    <cfset result.message = "Some text contained profanity, please remove any profanity from your text.">
    <!---Check length restriction.--->
    <cfelseif LEN(ARGUMENTS.frlAccess) GT 512>
    <cfset result.message = "The description is longer than 512 characters, please enter a new name under 512 characters.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_fishing_report_location SET
    siteNo = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.siteNo#">,
    frlName = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.frlName#">,
    frlAccess = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.frlAccess#">,
    frltID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.frltID#">,
    frRegID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.frRegID#">,
    frlGps = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.frlGps#">,
    frlWeatherUrl = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.frlWeatherUrl#">,
    frlStatus = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.frlStatus#">
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
    
    <cffunction name="updateFishingReportRegulation" access="public" returntype="struct">
    <cfargument name="ID" type="numeric" required="yes">
    <cfargument name="siteNo" type="string" required="yes">
    <cfargument name="frregName" type="string" required="yes">
    <cfargument name="frRegUrl" type="string" required="yes">
    <cfargument name="frRegTarget" type="string" required="yes">
    <cfargument name="frregStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully updated the record.">
    <cftry>
    <!---Check for profanity in the text.--->
    <cfinvoke 
    component="MCMS.component.utility.Regex"
    method="regexProfanity"
    returnvariable="regexProfanityRet">
    <cfinvokeargument name="profanityString" value="#ARGUMENTS.frregName#"/>
    </cfinvoke>
    <!---Check for a duplicate record.--->
    <cfinvoke
    component="MCMS.component.app.fishing_report.FishingReport"
    method="getFishingReportRegulation"
    returnvariable="getCheckFRReguationRet">
    <cfinvokeargument name="excludeID" value="#ARGUMENTS.ID#"/>
    <cfinvokeargument name="siteNo" value="#ARGUMENTS.siteNo#"/>
    <cfinvokeargument name="frregName" value="#ARGUMENTS.frregName#"/>
    <cfinvokeargument name="frregStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckFRReguationRet.recordcount NEQ 0>
    <cfset result.message = "The name #ARGUMENTS.frregName# already exists, please try again.">
    <cfelseif regexProfanityRet CONTAINS '$%&*!'>
    <cfset result.message = "Some text contained profanity, please remove any profanity from your text.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_fishing_report_regulation SET
    siteNo = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.siteNo#">,
    frregName = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.frregName#">,
    frRegUrl = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.frRegUrl#">,
    frRegTarget = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.frRegTarget#">,
    frregStatus = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.frregStatus#">
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
    
    <cffunction name="updateFRLocationImage" access="public" returntype="struct">
    <cfargument name="ID" type="numeric" required="yes">
    <cfargument name="frlID" type="numeric" required="yes">
    <cfargument name="imgID" type="string" required="yes">
    <cfargument name="frlirStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully updated the record.">
    <cftry>
    <!---Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.app.fishing_report.FishingReport"
    method="getFRLocationImage"
    returnvariable="getCheckFRLocationImageRet">
    <cfinvokeargument name="frlID" value="#ARGUMENTS.frlID#"/>
    <cfinvokeargument name="imgID" value="#ARGUMENTS.imgID#"/>
    <cfinvokeargument name="frlirStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckFRLocationImageRet.recordcount NEQ 0>
    <cfset result.message = "The image selected already exists for this location, please try again.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_fr_location_image_rel SET
    frlID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.frlID#">,
    imgID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.imgID#">,
    frlirStatus = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.frlirStatus#">
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

    <cffunction name="updateFishingReportList" access="public" returntype="struct">
    <cfargument name="ID" type="numeric" required="yes">
    <cfargument name="frStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully updated the records.">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_fishing_report SET
    frStatus = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.frStatus#">
    WHERE ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ID#">
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error updating the records.">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="updateFishingReportLocationList" access="public" returntype="struct">
    <cfargument name="ID" type="numeric" required="yes">
    <cfargument name="frlStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully updated the records.">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_fishing_report_location SET
    frlStatus = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.frlStatus#">
    WHERE ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ID#">
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error updating the records.">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="updateFishingReportRegulationList" access="public" returntype="struct">
    <cfargument name="ID" type="numeric" required="yes">
    <cfargument name="frregStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully updated the records.">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_fishing_report_regulation SET
    frregStatus = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.frregStatus#">
    WHERE ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ID#">
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error updating the records.">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="updateFRLocationImageList" access="public" returntype="struct">
    <cfargument name="ID" type="numeric" required="yes">
    <cfargument name="frlirStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully updated the records.">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_fr_location_image_rel SET
    frlirStatus = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.frlirStatus#">
    WHERE ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ID#">
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error updating the records.">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="deleteFishingReport" access="public" returntype="struct">
    <cfargument name="ID" type="string" required="yes" default="0">
    <cfargument name="frlID" type="string" required="yes" default="0">
    <cfset result.message = "You have successfully deleted the record(s).">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    DELETE FROM tbl_fishing_report
    WHERE ID IN (<cfqueryparam cfsqltype="cf_sql_integer" list="yes" value="#ARGUMENTS.ID#">)
    OR frlID IN (<cfqueryparam cfsqltype="cf_sql_integer" list="yes" value="#ARGUMENTS.frlID#">)
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error deleting the record(s).">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>  
    
    <cffunction name="deleteFishingReportLocation" access="public" returntype="struct">
    <cfargument name="ID" type="string" required="yes">
    <cfset result.message = "You have successfully deleted the record(s).">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    DELETE FROM tbl_fishing_report_location
    WHERE ID IN (<cfqueryparam cfsqltype="cf_sql_integer" list="yes" value="#ARGUMENTS.ID#">)
    </cfquery>
    </cftransaction>
    <cfinvoke 
    component="MCMS.component.app.fishing_report.FishingReport"
    method="deleteFishingReport"
    returnvariable="deleteFishingReportRet">
    <cfinvokeargument name="frlID" value="#ARGUMENTS.ID#"/>
    </cfinvoke>
    <cfinvoke 
    component="MCMS.component.app.fishing_report.FishingReport"
    method="deleteFRLocationImage"
    returnvariable="deleteFRLocationImageRet">
    <cfinvokeargument name="frlID" value="#ARGUMENTS.ID#"/>
    </cfinvoke>
    <cfcatch type="any">
    <cfset result.message = "There was an error deleting the record(s).">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="deleteFishingReportRegulation" access="public" returntype="struct">
    <cfargument name="ID" type="string" required="yes">
    <cfset result.message = "You have successfully deleted the record(s).">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    DELETE FROM tbl_fishing_report_regulation
    WHERE ID IN (<cfqueryparam cfsqltype="cf_sql_integer" list="yes" value="#ARGUMENTS.ID#">)
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error deleting the record(s).">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="deleteFRLocationImage" access="public" returntype="struct">
    <cfargument name="ID" type="string" required="yes" default="0">
    <cfargument name="frlID" type="numeric" required="yes" default="0">
    <cfset result.message = "You have successfully deleted the record(s).">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    DELETE FROM tbl_fr_location_image_rel
    WHERE ID IN (<cfqueryparam cfsqltype="cf_sql_integer" list="yes" value="#ARGUMENTS.ID#">)
    OR frlID = <cfqueryparam value="#ARGUMENTS.frlID#" cfsqltype="cf_sql_integer">
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error deleting the record(s).">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
</cfcomponent>