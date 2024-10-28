<cfcomponent>
    <cffunction name="getPageViewer" access="public" returntype="query" hint="Get Page Viewer data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="ID" type="numeric" required="yes" default="0">
    <cfargument name="excludeID" type="numeric" required="yes" default="0">
    <cfargument name="pvName" type="string" required="yes" default="">
    <cfargument name="pvtID" type="string" required="yes" default="0">
    <cfargument name="pvStatus" type="string" required="yes" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="pvName">
    <cfset var rsPageViewer = "" >
    <cftry>
    <cfquery name="rsPageViewer" datasource="#application.mcmsDSN#">
    SELECT * FROM v_page_viewer WHERE 0=0
    <cfif ARGUMENTS.ID NEQ 0>
    AND ID = <cfqueryparam value="#ARGUMENTS.ID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.excludeID NEQ 0>
    AND ID <> <cfqueryparam value="#ARGUMENTS.excludeID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(pvName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(pvDescription) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">)
    </cfif>
    <cfif ARGUMENTS.pvName NEQ "">
    AND UPPER(pvName) = <cfqueryparam value="#UCASE(ARGUMENTS.pvName)#" cfsqltype="cf_sql_varchar">
    </cfif>
    <cfif ARGUMENTS.pvtID NEQ 0>
    AND pvtID = <cfqueryparam value="#ARGUMENTS.pvtID#" cfsqltype="cf_sql_integer">
    </cfif>
    AND pvStatus IN (<cfqueryparam value="#ARGUMENTS.pvStatus#" list="yes" cfsqltype="cf_sql_integer">)
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsPageViewer = StructNew()>
    <cfset rsPageViewer.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsPageViewer>
    </cffunction>
    
    <cffunction name="getPageViewerType" access="public" returntype="query" hint="Get Page Viewer Type data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="ID" type="numeric" required="yes" default="0">
    <cfargument name="excludeID" type="numeric" required="yes" default="0">
    <cfargument name="pvtName" type="string" required="yes" default="">
    <cfargument name="pvtStatus" type="string" required="yes" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="pvtName">
    <cfset var rsPageViewerType = "" >
    <cftry>
    <cfquery name="rsPageViewerType" datasource="#application.mcmsDSN#">
    SELECT * FROM tbl_page_viewer_type WHERE 0=0
    <cfif ARGUMENTS.ID NEQ 0>
    AND ID = <cfqueryparam value="#ARGUMENTS.ID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.excludeID NEQ 0>
    AND ID <> <cfqueryparam value="#ARGUMENTS.excludeID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND UPPER(pvtName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">
    </cfif>
    <cfif ARGUMENTS.pvtName NEQ "">
    AND UPPER(pvtName) = <cfqueryparam value="#UCASE(ARGUMENTS.pvtName)#" cfsqltype="cf_sql_varchar">
    </cfif>
    AND pvtStatus IN (<cfqueryparam value="#ARGUMENTS.pvtStatus#" list="yes" cfsqltype="cf_sql_integer">)
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsPageViewerType = StructNew()>
    <cfset rsPageViewerType.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsPageViewerType>
    </cffunction>
    
    <cffunction name="getPageViewerReport" access="public" returntype="query" hint="Get Page Viewer Report data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="orderBy" type="string" required="yes" default="pvName">
    <cfset var rsPageViewerReport = "" >
    <cftry>
    <cfquery name="rsPageViewerReport" datasource="#application.mcmsDSN#">
    SELECT pvName, pvDescription FROM tbl_page_viewer WHERE 0=0
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(pvName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(pvDescription) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">)
    </cfif>
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsPageViewerReport = StructNew()>
    <cfset rsPageViewerReport.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsPageViewerReport>
    </cffunction>
    
    <cffunction name="getPageViewerTypeReport" access="public" returntype="query" hint="Get Page Viewer Type Report data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="orderBy" type="string" required="yes" default="pvtName">
    <cfset var rsPageViewerTypeReport = "" >
    <cftry>
    <cfquery name="rsPageViewerTypeReport" datasource="#application.mcmsDSN#">
    SELECT pvtName FROM tbl_page_viewer_type WHERE 0=0
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND UPPER(pvtName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">
    </cfif>
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsPageViewerTypeReport = StructNew()>
    <cfset rsPageViewerTypeReport.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsPageViewerTypeReport>
    </cffunction>
    
    <cffunction name="insertPageViewer" access="public" returntype="struct">
    <cfargument name="pvName" type="string" required="yes">
    <cfargument name="pvDescription" type="string" required="yes">
    <cfargument name="pvDateRel" type="date" required="yes">
    <cfargument name="pvDateExp" type="date" required="yes">
    <cfargument name="pvtID" type="numeric" required="yes">
    <cfargument name="pvStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully inserted the record.">
    <cftry>
    <!---Check for profanity in the text.--->
    <cfinvoke 
    component="MCMS.component.utility.Regex"
    method="regexProfanity"
    returnvariable="regexProfanityRet">
    <cfinvokeargument name="profanityString" value="#ARGUMENTS.pvDescription#"/>
    </cfinvoke>
    <!---Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.app.page_viewer.PageViewer"
    method="getPageViewer"
    returnvariable="getCheckPageViewerRet">
    <cfinvokeargument name="pvName" value="#ARGUMENTS.pvName#"/>
    <cfinvokeargument name="pvStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckPageViewerRet.recordcount NEQ 0>
    <cfset result.message = "The name #ARGUMENTS.pvName# already exists, please enter a new name.">
    <cfelseif regexProfanityRet CONTAINS '$%&*!'>
    <cfset result.message = "Some text contained profanity, please remove any profanity from your text.">
    <!---Check length restriction.--->
    <cfelseif LEN(ARGUMENTS.pvDescription) GT 2048>
    <cfset result.message = "The description is longer than 2048 characters, please enter a new name under 2048 characters.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    INSERT INTO tbl_page_viewer (pvName,pvDescription,pvDateRel,pvDateExp,pvtID,pvStatus) VALUES
    (
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.pvName#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.pvDescription#">,
    <cfqueryparam cfsqltype="cf_sql_date" value="#ARGUMENTS.pvDateRel#">,
    <cfqueryparam cfsqltype="cf_sql_date" value="#ARGUMENTS.pvDateExp#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.pvtID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.pvStatus#">
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
    
    <cffunction name="insertPageViewerPage" access="public" returntype="struct">
    <cfargument name="docID" type="numeric" required="yes">
    <cfset result.message = "You have successfully inserted the record.">
    <cftry>
    <!---Get Document Path.--->
    <cfinvoke 
    component="MCMS.component.app.document.Document"
    method="getDocument"
    returnvariable="getDocumentRet">
    <cfinvokeargument name="ID" value="#ARGUMENTS.docID#"/>
    <cfinvokeargument name="docStatus" value="1,3"/>
    </cfinvoke>
    <cfset this.doctPath = getDocumentRet.doctPath>
    <cfset this.docFile = getDocumentRet.docFile>
    <!---Contruct the path for the document JPG's to be uploaded too.--->
    <cfset this.documentPath = '#application.repositoryPath#\document\#this.doctPath#\page_viewer'>
    <!---Check to see the directory exists.--->
    <cfif NOT DirectoryExists(this.documentPath)>
    <cfdirectory action="create" directory="#this.documentPath#">
    </cfif>
    <!---Create JPG's form PDF.--->
    <cfpdf action="thumbnail" source="#application.repositoryPath#\document\#this.doctPath#\#this.docFile#" destination="#this.documentPath#" format="jpeg" scale="100" overwrite="yes">
	<!---Now insert the records based on the page count.--->
    <cfpdf action="getInfo" name="getInfo" source="#application.repositoryPath#\document\#this.doctPath#\#this.docFile#">
    <cfset this.totalPages = getInfo.totalpages>
    <cfloop index="index" from="1" to="#this.totalPages#">
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    INSERT INTO tbl_page_viewer_page (pvID,docID,pvpFile,pvpDateExp,pvpSort,pvpStatus) VALUES
    (
    <cfqueryparam cfsqltype="cf_sql_integer" value="100">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.docID#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#Replace(this.docFile, '.pdf', '', 'ALL')#_page_#index#.jpg">,
    <cfqueryparam cfsqltype="cf_sql_date" value="#DateFormat(DateAdd('yyyy', 1, Now()), application.dateFormat)#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#index#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="1">
    )
    </cfquery>
    </cftransaction>
    </cfloop>
    <cfcatch type="any">
    <cfset result.message = "There was an error inserting the record.">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="insertPageViewerType" access="public" returntype="struct">
    <cfargument name="pvtName" type="string" required="yes">
    <cfargument name="pvtWidth" type="numeric" required="yes">
    <cfargument name="pvtHeight" type="numeric" required="yes">
	<cfargument name="pvtCSS" type="string" required="yes">
	<cfargument name="pvtFile" type="string" required="yes">
    <cfargument name="pvtStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully inserted the record.">
    <cftry>
    <!---Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.app.page_viewer.PageViewer"
    method="getPageViewerType"
    returnvariable="getCheckPageViewerTypeRet">
    <cfinvokeargument name="pvtName" value="#ARGUMENTS.pvtName#"/>
    <cfinvokeargument name="pvtStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckPageViewerTypeRet.recordcount NEQ 0>
    <cfset result.message = "The name #ARGUMENTS.pvtName# already exists, please enter a new name.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    INSERT INTO tbl_page_viewer_type (pvtName,pvtWidth,pvtHeight,pvtCSS,pvtFile,pvtStatus) VALUES
    (
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.pvtName#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.pvtWidth#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.pvtHeight#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.pvtCSS#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.pvtFile#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.pvtStatus#">
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
    
    <cffunction name="updatePageViewer" access="public" returntype="struct">
    <cfargument name="ID" type="numeric" required="yes">
    <cfargument name="pvName" type="string" required="yes">
    <cfargument name="pvDescription" type="string" required="yes">
    <cfargument name="pvDateRel" type="date" required="yes">
    <cfargument name="pvDateExp" type="date" required="yes">
    <cfargument name="pvtID" type="numeric" required="yes">
    <cfargument name="pvStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully updated the record.">
    <cftry>
    <!---Check for profanity in the text.--->
    <cfinvoke 
    component="MCMS.component.utility.Regex"
    method="regexProfanity"
    returnvariable="regexProfanityRet">
    <cfinvokeargument name="profanityString" value="#ARGUMENTS.pvDescription#"/>
    </cfinvoke>
    <!---Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.app.page_viewer.PageViewer"
    method="getPageViewer"
    returnvariable="getCheckPageViewerRet">
    <cfinvokeargument name="excludeID" value="#ARGUMENTS.ID#"/>
    <cfinvokeargument name="pvName" value="#ARGUMENTS.pvName#"/>
    <cfinvokeargument name="pvStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckPageViewerRet.recordcount NEQ 0>
    <cfset result.message = "The name #ARGUMENTS.pvName# already exists, please enter a new name.">
    <cfelseif regexProfanityRet CONTAINS '$%&*!'>
    <cfset result.message = "Some text contained profanity, please remove any profanity from your text.">
    <!---Check length restriction.--->
    <cfelseif LEN(ARGUMENTS.pvDescription) GT 2048>
    <cfset result.message = "The description is longer than 2048 characters, please enter a new name under 2048 characters.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_page_viewer SET
    pvName = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.pvName#">,
    pvDescription = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.pvDescription#">,
    pvDateRel = <cfqueryparam cfsqltype="cf_sql_date" value="#ARGUMENTS.pvDateRel#">,
    pvDateExp = <cfqueryparam cfsqltype="cf_sql_date" value="#ARGUMENTS.pvDateExp#">,
    pvtID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.pvtID#">,
    pvStatus = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.pvStatus#">
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
    
    <cffunction name="updatePageViewerType" access="public" returntype="struct">
    <cfargument name="ID" type="numeric" required="yes">
    <cfargument name="pvtName" type="string" required="yes">
    <cfargument name="pvtWidth" type="numeric" required="yes">
    <cfargument name="pvtHeight" type="numeric" required="yes">
	<cfargument name="pvtCSS" type="string" required="yes">
	<cfargument name="pvtFile" type="string" required="yes">
    <cfargument name="pvtStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully updated the record.">
    <cftry>
    <!---Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.app.page_viewer.PageViewer"
    method="getPageViewerType"
    returnvariable="getCheckPageViewerTypeRet">
    <cfinvokeargument name="excludeID" value="#ARGUMENTS.ID#"/>
    <cfinvokeargument name="pvtName" value="#ARGUMENTS.pvtName#"/>
    <cfinvokeargument name="pvtStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckPageViewerTypeRet.recordcount NEQ 0>
    <cfset result.message = "The name #ARGUMENTS.pvtName# already exists, please enter a new name.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_page_viewer_type SET
    pvtName = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.pvtName#">,
    pvtWidth = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.pvtWidth#">,
    pvtHeight = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.pvtHeight#">,
    pvtCSS = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.pvtCSS#">,
    pvtFile = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.pvtFile#">,
    pvtStatus = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.pvtStatus#">
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
    
    <cffunction name="updatePageViewerList" access="public" returntype="struct">
    <cfargument name="ID" type="numeric" required="yes">
    <cfargument name="pvStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully updated the records.">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_page_viewer SET
    pvStatus = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.pvStatus#">
    WHERE ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ID#">
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error updating the records.">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="updatePageViewerTypeList" access="public" returntype="struct">
    <cfargument name="ID" type="numeric" required="yes">
    <cfargument name="pvtStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully updated the records.">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_page_viewer_type SET
    pvtStatus = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.pvtStatus#">
    WHERE ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ID#">
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error updating the records.">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="deletePageViewer" access="public" returntype="struct">
    <cfargument name="ID" type="string" required="yes">
    <cfset result.message = "You have successfully deleted the record(s).">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    DELETE FROM tbl_page_viewer
    WHERE ID IN (<cfqueryparam cfsqltype="cf_sql_integer" list="yes" value="#ARGUMENTS.ID#">)
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error deleting the record(s).">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="deletePageViewerPage" access="public" returntype="struct">
    <cfargument name="ID" type="string" required="yes" default="0">
    <cfargument name="docID" type="numeric" required="yes" default="0">
    <cfset result.message = "You have successfully deleted the record(s).">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    DELETE FROM tbl_page_viewer_page
    WHERE ID IN (<cfqueryparam cfsqltype="cf_sql_integer" list="yes" value="#ARGUMENTS.ID#">)
    OR docID = <cfqueryparam cfsqltype="cf_sql_integer" list="yes" value="#ARGUMENTS.docID#">
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error deleting the record(s).">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction> 
    
    <cffunction name="deletePageViewerType" access="public" returntype="struct">
    <cfargument name="ID" type="string" required="yes">
    <cfset result.message = "You have successfully deleted the record(s).">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    DELETE FROM tbl_page_viewer_type
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