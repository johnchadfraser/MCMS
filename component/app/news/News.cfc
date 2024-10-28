<cfcomponent>
    <cffunction name="getNews" access="public" returntype="any" hint="Get News data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="siteNo" type="string" required="yes" default="100">
    <cfargument name="ID" type="numeric" required="yes" default="0">
    <cfargument name="excludeID" type="numeric" required="yes" default="0">
    <cfargument name="newsName" type="string" required="yes" default="">
    <cfargument name="newsDateRel" type="string" required="yes" default="">
    <cfargument name="newsDateExp" type="string" required="yes" default="">
    <cfargument name="stID" type="numeric" required="yes" default="0">
    <cfargument name="siteDateClose" type="string" required="yes" default="">
    <cfargument name="ntID" type="string" required="yes" default="0">
    <cfargument name="ntStatus" type="string" required="no" default="1">
    <cfargument name="newsStatus" type="string" required="yes" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="newsName">
    <cfset var rsNews = "">
    <cftry>
    <cfquery name="rsNews" datasource="#application.mcmsDSN#">
    SELECT * FROM v_news WHERE 0=0
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(newsName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(newsDescription) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">)
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
    <cfif ARGUMENTS.newsDateRel NEQ "">
    AND newsDateRel <= <cfqueryparam value="#ARGUMENTS.newsDateRel#" cfsqltype="cf_sql_date">
    </cfif>
    <cfif ARGUMENTS.newsDateExp NEQ "">
    AND newsDateExp >= <cfqueryparam value="#ARGUMENTS.newsDateExp#" cfsqltype="cf_sql_date">
    </cfif>
    <cfif ARGUMENTS.newsName NEQ "">
    AND newsName = <cfqueryparam value="#ARGUMENTS.newsName#" cfsqltype="cf_sql_varchar">
    </cfif>
    <cfif ARGUMENTS.stID NEQ 0>
    AND stID = <cfqueryparam value="#ARGUMENTS.stID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.siteDateClose NEQ "">
    AND siteDateClose = <cfqueryparam value="#ARGUMENTS.siteDateClose#" cfsqltype="cf_sql_varchar">
    </cfif>
    <cfif ARGUMENTS.ntID NEQ 0>
    AND ntID = <cfqueryparam value="#ARGUMENTS.ntID#" cfsqltype="cf_sql_integer">
    </cfif>
    AND ntStatus IN (<cfqueryparam value="#ARGUMENTS.ntStatus#" list="yes" cfsqltype="cf_sql_integer">)
    AND newsStatus IN (<cfqueryparam value="#ARGUMENTS.newsStatus#" list="yes" cfsqltype="cf_sql_integer">)
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsNews = StructNew()>
    <cfset rsNews.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsNews>
    </cffunction>
    
    <cffunction name="getNewsEventRel" access="public" returntype="any" hint="Get News Event Rel. data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="siteNo" type="string" required="yes" default="100">
    <cfargument name="ID" type="numeric" required="yes" default="0">
    <cfargument name="excludeID" type="numeric" required="yes" default="0">
    <cfargument name="newsName" type="string" required="yes" default="">
    <cfargument name="newsID" type="string" required="yes" default="0">
    <cfargument name="evtID" type="string" required="yes" default="0">    
    <cfargument name="newsStatus" type="string" required="no" default="1">
    <cfargument name="evtStatus" type="string" required="no" default="1">
    <cfargument name="nerStatus" type="string" required="yes" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="newsName">
    <cfset var rsNewsEventRel = "">
    <cftry>
    <cfquery name="rsNewsEventRel" datasource="#application.mcmsDSN#">
    SELECT * FROM v_news_event_rel WHERE 0=0
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(newsName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(evtName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">)
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
    <cfif ARGUMENTS.newsName NEQ "">
    AND newsName = <cfqueryparam value="#ARGUMENTS.newsName#" cfsqltype="cf_sql_varchar">
    </cfif>
    <cfif ARGUMENTS.newsID NEQ 0>
    AND newsID = <cfqueryparam value="#ARGUMENTS.newsID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.evtID NEQ 0>
    AND evtID = <cfqueryparam value="#ARGUMENTS.evtID#" cfsqltype="cf_sql_integer">
    </cfif>
    AND newsStatus IN (<cfqueryparam value="#ARGUMENTS.newsStatus#" list="yes" cfsqltype="cf_sql_integer">)
    AND evtStatus IN (<cfqueryparam value="#ARGUMENTS.evtStatus#" list="yes" cfsqltype="cf_sql_integer">)
    AND nerStatus IN (<cfqueryparam value="#ARGUMENTS.nerStatus#" list="yes" cfsqltype="cf_sql_integer">)
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsNewsEventRel = StructNew()>
    <cfset rsNewsEventRel.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsNewsEventRel>
    </cffunction>
    
    <cffunction name="getNewsDocumentRel" access="public" returntype="any" hint="Get News Document Rel. data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="siteNo" type="string" required="yes" default="100">
    <cfargument name="ID" type="numeric" required="yes" default="0">
    <cfargument name="excludeID" type="numeric" required="yes" default="0">
    <cfargument name="newsName" type="string" required="yes" default="">
    <cfargument name="newsID" type="string" required="yes" default="0">
    <cfargument name="docID" type="string" required="yes" default="0">    
    <cfargument name="ndrStatus" type="string" required="yes" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="newsName">
    <cfset var rsNewsDocumentRel = "">
    <cftry>
    <cfquery name="rsNewsDocumentRel" datasource="#application.mcmsDSN#">
    SELECT * FROM v_news_document_rel WHERE 0=0
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(newsName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(docName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">)
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
    <cfif ARGUMENTS.newsName NEQ "">
    AND newsName = <cfqueryparam value="#ARGUMENTS.newsName#" cfsqltype="cf_sql_varchar">
    </cfif>
    <cfif ARGUMENTS.newsID NEQ 0>
    AND newsID = <cfqueryparam value="#ARGUMENTS.newsID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.docID NEQ 0>
    AND docID = <cfqueryparam value="#ARGUMENTS.docID#" cfsqltype="cf_sql_integer">
    </cfif>
    AND ndrStatus IN (<cfqueryparam value="#ARGUMENTS.ndrStatus#" list="yes" cfsqltype="cf_sql_integer">)
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsNewsDocumentRel = StructNew()>
    <cfset rsNewsDocumentRel.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsNewsDocumentRel>
    </cffunction>
    
    <cffunction name="getNewsImageRel" access="public" returntype="any" hint="Get News Image Rel. data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="siteNo" type="string" required="yes" default="100">
    <cfargument name="ID" type="numeric" required="yes" default="0">
    <cfargument name="excludeID" type="numeric" required="yes" default="0">
    <cfargument name="newsName" type="string" required="yes" default="">
    <cfargument name="newsID" type="string" required="yes" default="0">
    <cfargument name="imgID" type="string" required="yes" default="0">    
    <cfargument name="nirStatus" type="string" required="yes" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="newsName">
    <cfset var rsNewsImageRel = "">
    <cftry>
    <cfquery name="rsNewsImageRel" datasource="#application.mcmsDSN#">
    SELECT * FROM v_news_image_rel WHERE 0=0
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(newsName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(imgName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">)
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
    <cfif ARGUMENTS.newsName NEQ "">
    AND newsName = <cfqueryparam value="#ARGUMENTS.newsName#" cfsqltype="cf_sql_varchar">
    </cfif>
    <cfif ARGUMENTS.newsID NEQ 0>
    AND newsID = <cfqueryparam value="#ARGUMENTS.newsID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.imgID NEQ 0>
    AND imgID = <cfqueryparam value="#ARGUMENTS.imgID#" cfsqltype="cf_sql_integer">
    </cfif>
    AND nirStatus IN (<cfqueryparam value="#ARGUMENTS.nirStatus#" list="yes" cfsqltype="cf_sql_integer">)
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsNewsImageRel = StructNew()>
    <cfset rsNewsImageRel.message = "There was an error with the query.">
    <cfif url.mcmsDebug EQ true>
    <cfdump var="#rsNews#">
    </cfif>
    </cfcatch>
    </cftry>
    <cfreturn rsNewsImageRel>
    </cffunction>
      
    <cffunction name="getNewsReport" access="public" returntype="query" hint="Get News Report data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
	<cfargument name="siteNo" type="string" required="yes" default="100">
    <cfargument name="orderBy" type="string" required="yes" default="newsName">
    <cfset var rsNewsReport = "" >
    <cftry>
    <cfquery name="rsNewsReport" datasource="#application.mcmsDSN#">
    SELECT newsName AS Name, TO_CHAR(newsDescription) AS Description, TO_CHAR(newsDateRel,'MM/DD/YYYY') AS Release_Date, TO_CHAR(newsDateExp,'MM/DD/YYYY') AS Expiration_Date, siteName AS Site, sName AS Status FROM v_news WHERE 0=0
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(newsName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(newsDescription) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">)
    </cfif>
    <cfif ARGUMENTS.siteNo NEQ 100>
    AND siteNo IN (<cfqueryparam value="#ARGUMENTS.siteNo#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsNewsReport = StructNew()>
    <cfset rsNewsReport.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsNewsReport>
    </cffunction>
    
    <cffunction name="getNewsExcelQuickReport" access="public" returntype="query" hint="Get News Excel Quick Report data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="newsStatus" type="string" required="yes" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="newsName">
    <cfset var rsNewsReport = "" >
    <cftry>
    <cfquery name="rsNewsReport" datasource="#application.mcmsDSN#">
    SELECT newsName AS Name, TO_CHAR(newsDescription) AS Description, TO_CHAR(newsDateRel,'MM/DD/YYYY') AS Release_Date, TO_CHAR(newsDateExp,'MM/DD/YYYY') AS Expiration_Date, siteName AS Site, sName AS Status FROM v_news WHERE 0=0
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(newsName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(newsDescription) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">)
    </cfif>
    AND newsDateExp >= <cfqueryparam value="#Now()#" cfsqltype="cf_sql_date">
    AND newsStatus IN (<cfqueryparam value="#ARGUMENTS.newsStatus#" list="yes" cfsqltype="cf_sql_integer">)
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsNewsReport = StructNew()>
    <cfset rsNewsReport.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsNewsReport>
    </cffunction>
    
    <cffunction name="getNewsEventRelReport" access="public" returntype="query" hint="Get News Event Rel. Report data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
	<cfargument name="siteNo" type="string" required="yes" default="100">
    <cfargument name="orderBy" type="string" required="yes" default="newsName">
    <cfset var rsNewsEventRelReport = "" >
    <cftry>
    <cfquery name="rsNewsEventRelReport" datasource="#application.mcmsDSN#">
    SELECT evtName AS Event_Name, newsName AS Name, siteName AS Site, sName AS Status  FROM v_news_event_rel WHERE 0=0
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(newsName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(evtName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">)
    </cfif>
    <cfif ARGUMENTS.siteNo NEQ 100>
    AND siteNo IN (<cfqueryparam value="#ARGUMENTS.siteNo#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsNewsEventRelReport = StructNew()>
    <cfset rsNewsEventRelReport.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsNewsEventRelReport>
    </cffunction>
    
    <cffunction name="getNewsDocumentRelReport" access="public" returntype="query" hint="Get News Document Rel. Report data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
	<cfargument name="siteNo" type="string" required="yes" default="100">
    <cfargument name="orderBy" type="string" required="yes" default="newsName">
    <cfset var rsNewsDocumentRelReport = "" >
    <cftry>
    <cfquery name="rsNewsDocumentRelReport" datasource="#application.mcmsDSN#">
    SELECT docName AS Doc_Name, newsName AS News_Name, TO_CHAR(docDescription) AS Doc_Description, docFile AS Doc_File, TO_CHAR(docDateRel,'MM/DD/YYYY') AS Release_Date, TO_CHAR(docDateExp,'MM/DD/YYYY') AS Expiration_Date, siteName AS Site, sName AS Status FROM v_news_document_rel WHERE 0=0
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(newsName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(docName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">)
    </cfif>
    <cfif ARGUMENTS.siteNo NEQ 100>
    AND siteNo IN (<cfqueryparam value="#ARGUMENTS.siteNo#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsNewsDocumentRelReport = StructNew()>
    <cfset rsNewsDocumentRelReport.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsNewsDocumentRelReport>
    </cffunction>
    
    <cffunction name="getNewsImageRelReport" access="public" returntype="query" hint="Get News Image Rel. Report data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
	<cfargument name="siteNo" type="string" required="yes" default="100">
    <cfargument name="orderBy" type="string" required="yes" default="newsName">
    <cfset var rsNewsImageRelReport = "" >
    <cftry>
    <cfquery name="rsNewsImageRelReport" datasource="#application.mcmsDSN#">
    SELECT imgName AS Image_Name, newsName As News_Name, imgFile AS Image_File, imgtWidth AS Image_Width, siteName AS Site, sName AS Status FROM v_news_image_rel WHERE 0=0
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(newsName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(imgName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">)
    </cfif>
    <cfif ARGUMENTS.siteNo NEQ 100>
    AND siteNo IN (<cfqueryparam value="#ARGUMENTS.siteNo#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsNewsImageRelReport = StructNew()>
    <cfset rsNewsImageRelReport.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsNewsImageRelReport>
    </cffunction>
      
    <cffunction name="insertNews" access="public" returntype="struct">
    <cfargument name="newsName" type="string" required="yes">
    <cfargument name="newsDescription" type="string" required="yes">
    <cfargument name="newsDate" type="date" required="yes">
    <cfargument name="newsDateRel" type="date" required="yes">
    <cfargument name="newsDateExp" type="date" required="yes">
    <cfargument name="newsUrl" type="string" required="yes">
    <cfargument name="newsUrlName" type="string" required="yes">
    <cfargument name="newsTarget" type="string" required="yes">
    <cfargument name="ntID" type="numeric" required="yes">
    <cfargument name="newsStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully inserted the record.">
    <cftry>
    <!---Check for profanity in the text.--->
    <cfinvoke 
    component="MCMS.component.utility.Regex"
    method="regexProfanity"
    returnvariable="regexProfanityRet">
    <cfinvokeargument name="profanityString" value="#ARGUMENTS.newsDescription#"/>
    </cfinvoke>
    <!---Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.app.news.News"
    method="getNews"
    returnvariable="getCheckEventRet">
    <cfinvokeargument name="siteNo" value="#ARGUMENTS.siteNo#"/>
    <cfinvokeargument name="newsName" value="#ARGUMENTS.newsName#"/>
    <cfinvokeargument name="newsStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckEventRet.recordcount NEQ 0>
    <cfset result.message = "The name #ARGUMENTS.newsName# already exists, please try again.">
    <cfelseif regexProfanityRet CONTAINS '$%&*!'>
    <cfset result.message = "Some text contained profanity, please remove any profanity from your text.">
    <!---Check length restriction.--->
    <cfelseif LEN(ARGUMENTS.newsDescription) GT 4096>
    <cfset result.message = "The description is longer than 4096 characters, please enter a new name under 4096 characters.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    INSERT INTO tbl_news (newsName,newsDescription,siteNo,newsDate,newsDateRel,newsDateExp,newsUrl,newsUrlName,newsTarget,ntID,newsStatus) VALUES
    (
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.newsName#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.newsDescription#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.siteNo#">,
    <cfqueryparam cfsqltype="cf_sql_date" value="#ARGUMENTS.newsDate#">,
    <cfqueryparam cfsqltype="cf_sql_date" value="#ARGUMENTS.newsDateRel#">,
    <cfqueryparam cfsqltype="cf_sql_date" value="#ARGUMENTS.newsDateExp#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.newsUrl#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.newsUrlName#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.newsTarget#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ntID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.newsStatus#">
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
    
    <cffunction name="insertNewsEventRel" access="public" returntype="struct">
    <cfargument name="newsID" type="numeric" required="yes">
    <cfargument name="evtID" type="numeric" required="yes">
    <cfargument name="nerStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully inserted the record.">
    <cftry>
    <cfinvoke 
    component="MCMS.component.app.news.News"
    method="getNewsEventRel"
    returnvariable="getCheckEventRelRet">
    <cfinvokeargument name="newsID" value="#ARGUMENTS.newsID#"/>
    <cfinvokeargument name="evtID" value="#ARGUMENTS.evtID#"/>
    <cfinvokeargument name="nerStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckEventRelRet.recordcount NEQ 0>
    <cfset result.message = "The news event relationship already exists, please try again.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    INSERT INTO tbl_news_event_rel (newsID,evtID,nerStatus) VALUES
    (
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.newsID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.evtID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.nerStatus#">
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
    
    <cffunction name="insertNewsDocumentRel" access="public" returntype="struct">
    <cfargument name="newsID" type="numeric" required="yes">
    <cfargument name="docID" type="numeric" required="yes">
    <cfargument name="ndrStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully inserted the record.">
    <cftry>
    <cfinvoke 
    component="MCMS.component.app.news.News"
    method="getNewsDocumentRel"
    returnvariable="getCheckNewsDocumentRelRet">
    <cfinvokeargument name="newsID" value="#ARGUMENTS.newsID#"/>
    <cfinvokeargument name="docID" value="#ARGUMENTS.docID#"/>
    <cfinvokeargument name="ndrStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckNewsDocumentRelRet.recordcount NEQ 0>
    <cfset result.message = "The news document relationship already exists, please try again.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    INSERT INTO tbl_news_document_rel (newsID,docID,ndrStatus) VALUES
    (
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.newsID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.docID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ndrStatus#">
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
    
    <cffunction name="insertNewsImageRel" access="public" returntype="struct">
    <cfargument name="newsID" type="numeric" required="yes">
    <cfargument name="imgID" type="numeric" required="yes">
    <cfargument name="nirStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully inserted the record.">
    <cftry>
    <cfinvoke 
    component="MCMS.component.app.news.News"
    method="getNewsImageRel"
    returnvariable="getCheckNewsImageRelRet">
    <cfinvokeargument name="newsID" value="#ARGUMENTS.newsID#"/>
    <cfinvokeargument name="imgID" value="#ARGUMENTS.imgID#"/>
    <cfinvokeargument name="nirStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckNewsImageRelRet.recordcount NEQ 0>
    <cfset result.message = "The news image relationship already exists, please try again.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    INSERT INTO tbl_news_image_rel (newsID,imgID,nirStatus) VALUES
    (
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.newsID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.imgID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.nirStatus#">
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
    
    <cffunction name="updateNews" access="public" returntype="struct">
    <cfargument name="ID" type="numeric" required="yes">
    <cfargument name="uaID" type="numeric" required="yes">
    <cfargument name="newsName" type="string" required="yes">
    <cfargument name="newsDescription" type="string" required="yes">
    <cfargument name="newsDate" type="date" required="yes">
    <cfargument name="newsDateRel" type="date" required="yes">
    <cfargument name="newsDateExp" type="date" required="yes">
    <cfargument name="newsUrl" type="string" required="yes">
    <cfargument name="newsUrlName" type="string" required="yes">
    <cfargument name="newsTarget" type="string" required="yes">
    <cfargument name="newsStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully updated the record.">
    <cftry>
    <!---Check for profanity in the text.--->
    <cfinvoke 
    component="MCMS.component.utility.Regex"
    method="regexProfanity"
    returnvariable="regexProfanityRet">
    <cfinvokeargument name="profanityString" value="#ARGUMENTS.newsDescription#"/>
    </cfinvoke>
    <!---Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.app.news.News"
    method="getNews"
    returnvariable="getCheckNewsRet">
    <cfinvokeargument name="excludeID" value="#ARGUMENTS.ID#"/>
    <cfinvokeargument name="siteNo" value="#ARGUMENTS.siteNo#"/>
    <cfinvokeargument name="newsName" value="#ARGUMENTS.newsName#"/>
    <cfinvokeargument name="newsStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckNewsRet.recordcount NEQ 0>
    <cfset result.message = "The name #ARGUMENTS.newsName# already exists, please try again.">
    <cfelseif regexProfanityRet CONTAINS '$%&*!'>
    <cfset result.message = "Some text contained profanity, please remove any profanity from your text.">
    <!---Check length restriction.--->
    <cfelseif LEN(ARGUMENTS.newsDescription) GT 4096>
    <cfset result.message = "The description is longer than 4096 characters, please enter a new name under 4096 characters.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_news SET
    newsName = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.newsName#">,
    newsDescription = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.newsDescription#">,
    siteNo = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.siteNo#">,
    newsDate = <cfqueryparam cfsqltype="cf_sql_date" value="#ARGUMENTS.newsDate#">,
    newsDateRel = <cfqueryparam cfsqltype="cf_sql_date" value="#ARGUMENTS.newsDateRel#">,
    newsDateExp = <cfqueryparam cfsqltype="cf_sql_date" value="#ARGUMENTS.newsDateExp#">,
    newsUrl = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.newsUrl#">,
    newsUrlName = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.newsUrlName#">,
    newsTarget = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.newsTarget#">,
		<cfif ARGUMENTS.uaID NEQ 101>
    newsDateUpdate = <cfqueryparam cfsqltype="cf_sql_timestamp" value="#Now()#">,
    userID = <cfqueryparam cfsqltype="cf_sql_integer" value="#session.userID#">,
    </cfif>
    newsStatus = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.newsStatus#">
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
    
    <cffunction name="updateNewsEventRel" access="public" returntype="struct">
    <cfargument name="ID" type="numeric" required="yes">
    <cfargument name="newsID" type="numeric" required="yes">
    <cfargument name="evtID" type="numeric" required="yes">
    <cfargument name="nerStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully updated the record.">
    <cftry>
    <!---Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.app.news.News"
    method="getNewsEventRel"
    returnvariable="getCheckNewsEventRelRet">
    <cfinvokeargument name="excludeID" value="#ARGUMENTS.ID#"/>
    <cfinvokeargument name="newsID" value="#ARGUMENTS.newsID#"/>
    <cfinvokeargument name="evtID" value="#ARGUMENTS.evtID#"/>
    <cfinvokeargument name="nerStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckNewsEventRelRet.recordcount NEQ 0>
    <cfset result.message = "The news event relationship already exists, please try again.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_news_event_rel SET
    newsID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.newsID#">,
    evtID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.evtID#">,
    nerStatus = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.nerStatus#">
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
    
    <cffunction name="updateNewsDocumentRel" access="public" returntype="struct">
    <cfargument name="ID" type="numeric" required="yes">
    <cfargument name="newsID" type="numeric" required="yes">
    <cfargument name="docID" type="numeric" required="yes">
    <cfargument name="ndrStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully updated the record.">
    <cftry>
    <!---Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.app.news.News"
    method="getNewsDocumentRel"
    returnvariable="getCheckNewsDocumentRelRet">
    <cfinvokeargument name="excludeID" value="#ARGUMENTS.ID#"/>
    <cfinvokeargument name="newsID" value="#ARGUMENTS.newsID#"/>
    <cfinvokeargument name="docID" value="#ARGUMENTS.docID#"/>
    <cfinvokeargument name="ndrStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckNewsDocumentRelRet.recordcount NEQ 0>
    <cfset result.message = "The news document relationship already exists, please try again.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_news_document_rel SET
    newsID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.newsID#">,
    docID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.docID#">,
    ndrStatus = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ndrStatus#">
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
    
    <cffunction name="updateNewsImageRel" access="public" returntype="struct">
    <cfargument name="ID" type="numeric" required="yes">
    <cfargument name="newsID" type="numeric" required="yes">
    <cfargument name="imgID" type="numeric" required="yes">
    <cfargument name="nirStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully updated the record.">
    <cftry>
    <!---Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.app.news.News"
    method="getNewsImageRel"
    returnvariable="getCheckNewsImageRelRet">
    <cfinvokeargument name="excludeID" value="#ARGUMENTS.ID#"/>
    <cfinvokeargument name="newsID" value="#ARGUMENTS.newsID#"/>
    <cfinvokeargument name="imgID" value="#ARGUMENTS.imgID#"/>
    <cfinvokeargument name="nirStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckNewsImageRelRet.recordcount NEQ 0>
    <cfset result.message = "The news image relationship already exists, please try again.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_news_image_rel SET
    newsID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.newsID#">,
    imgID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.imgID#">,
    nirStatus = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.nirStatus#">
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
    
    <cffunction name="updateNewsList" access="public" returntype="struct">
    <cfargument name="ID" type="numeric" required="yes">
    <cfargument name="newsStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully updated the records.">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_news SET
    newsStatus = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.newsStatus#">
    WHERE ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ID#">
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error updating the records.">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="updateNewsEventRelList" access="public" returntype="struct">
    <cfargument name="ID" type="numeric" required="yes">
    <cfargument name="nerStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully updated the records.">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_news_event_rel SET
    nerStatus = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.nerStatus#">
    WHERE ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ID#">
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error updating the records.">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="updateNewsDocumentRelList" access="public" returntype="struct">
    <cfargument name="ID" type="numeric" required="yes">
    <cfargument name="ndrStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully updated the records.">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_news_document_rel SET
    ndrStatus = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ndrStatus#">
    WHERE ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ID#">
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error updating the records.">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="updateNewsImageRelList" access="public" returntype="struct">
    <cfargument name="ID" type="numeric" required="yes">
    <cfargument name="nirStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully updated the records.">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_news_image_rel SET
    nirStatus = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.nirStatus#">
    WHERE ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ID#">
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error updating the records.">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="deleteNews" access="public" returntype="struct">
    <cfargument name="ID" type="string" required="yes">
    <cfset result.message = "You have successfully deleted the record(s).">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    DELETE FROM tbl_news
    WHERE ID IN (<cfqueryparam cfsqltype="cf_sql_integer" list="yes" value="#ARGUMENTS.ID#">)
    </cfquery>
    </cftransaction>
    <cfinvoke 
    component="MCMS.component.app.news.News"
    method="deleteNewsEventRel"
    returnvariable="deleteNewsEventRelRet">
    <cfinvokeargument name="newsID" value="#ARGUMENTS.ID#"/>
    </cfinvoke>
    <cfinvoke 
    component="MCMS.component.app.news.News"
    method="deleteNewsDocumentRel"
    returnvariable="deleteNewsDocumentRelRet">
    <cfinvokeargument name="newsID" value="#ARGUMENTS.ID#"/>
    </cfinvoke>
    <cfinvoke 
    component="MCMS.component.app.news.News"
    method="deleteNewsImageRel"
    returnvariable="deleteNewsImageRelRet">
    <cfinvokeargument name="newsID" value="#ARGUMENTS.ID#"/>
    </cfinvoke>
    <cfcatch type="any">
    <cfset result.message = "There was an error deleting the record(s).">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="deleteNewsEventRel" access="public" returntype="struct">
    <cfargument name="ID" type="string" required="yes" default="0">
    <cfargument name="newsID" type="numeric" required="yes" default="0">
    <cfset result.message = "You have successfully deleted the record(s).">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    DELETE FROM tbl_news_event_rel
    WHERE ID IN (<cfqueryparam cfsqltype="cf_sql_integer" list="yes" value="#ARGUMENTS.ID#">)
    OR newsID = <cfqueryparam value="#ARGUMENTS.newsID#" cfsqltype="cf_sql_integer">
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error deleting the record(s).">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="deleteNewsDocumentRel" access="public" returntype="struct">
    <cfargument name="ID" type="string" required="yes" default="0">
    <cfargument name="newsID" type="numeric" required="yes" default="0">
    <cfset result.message = "You have successfully deleted the record(s).">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    DELETE FROM tbl_news_document_rel 
    WHERE ID IN (<cfqueryparam cfsqltype="cf_sql_integer" list="yes" value="#ARGUMENTS.ID#">)
    OR newsID = <cfqueryparam value="#ARGUMENTS.newsID#" cfsqltype="cf_sql_integer">  
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error deleting the record(s).">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="deleteNewsImageRel" access="public" returntype="struct">
    <cfargument name="ID" type="string" required="yes" default="0">
    <cfargument name="newsID" type="numeric" required="yes" default="0">
    <cfset result.message = "You have successfully deleted the record(s).">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    DELETE FROM tbl_news_image_rel
    WHERE ID IN (<cfqueryparam cfsqltype="cf_sql_integer" list="yes" value="#ARGUMENTS.ID#">)
    OR newsID = <cfqueryparam value="#ARGUMENTS.newsID#" cfsqltype="cf_sql_integer">
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error deleting the record(s).">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction> 
</cfcomponent>