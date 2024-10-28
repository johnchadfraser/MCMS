<cfcomponent>
    <cffunction name="getIndexCollection" access="public" returntype="query" hint="Get Index Collection data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="ID" type="numeric" required="yes" default="0">
    <cfargument name="excludeID" type="numeric" required="yes" default="0">
    <cfargument name="icName" type="string" required="yes" default="">
    <cfargument name="icaID" type="numeric" required="yes" default="0">
    <cfargument name="ictID" type="numeric" required="yes" default="0">
    <cfargument name="icStatus" type="string" required="yes" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="icName">
    <cfset var rsIndexCollection = "" >
    <cftry>
    <cfquery name="rsIndexCollection" datasource="#application.mcmsDSN#">
    SELECT * FROM v_index_collection WHERE 0=0
    <cfif ARGUMENTS.ID NEQ 0>
    AND ID = <cfqueryparam value="#ARGUMENTS.ID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.excludeID NEQ 0>
    AND ID <> <cfqueryparam value="#ARGUMENTS.excludeID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(icName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(icDescription) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">)
    </cfif>
    <cfif ARGUMENTS.icName NEQ "">
    AND UPPER(icName) = <cfqueryparam value="#UCASE(ARGUMENTS.icName)#" cfsqltype="cf_sql_varchar">
    </cfif>
    <cfif ARGUMENTS.icaID NEQ 0>
    AND icaID = <cfqueryparam value="#ARGUMENTS.icaID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.ictID NEQ 0>
    AND ictID = <cfqueryparam value="#ARGUMENTS.ictID#" cfsqltype="cf_sql_integer">
    </cfif>
    AND icStatus IN (<cfqueryparam value="#ARGUMENTS.icStatus#" list="yes" cfsqltype="cf_sql_integer">)
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsIndexCollection = StructNew()>
    <cfset rsIndexCollection.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsIndexCollection>
    </cffunction>
    
    <cffunction name="getIndexCollectionType" access="public" returntype="query" hint="Get Index Collection Type data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="ID" type="numeric" required="yes" default="0">
    <cfargument name="excludeID" type="numeric" required="yes" default="0">
    <cfargument name="ictStatus" type="string" required="yes" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="ictName">
    <cfset var rsIndexCollectionType = "" >
    <cftry>
    <cfquery name="rsIndexCollectionType" datasource="#application.mcmsDSN#">
    SELECT * FROM v_index_collection_type WHERE 0=0
    <cfif ARGUMENTS.ID NEQ 0>
    AND ID = <cfqueryparam value="#ARGUMENTS.ID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.excludeID NEQ 0>
    AND ID <> <cfqueryparam value="#ARGUMENTS.excludeID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND UPPER(ictName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">
    </cfif>
    AND ictStatus IN (<cfqueryparam value="#ARGUMENTS.ictStatus#" list="yes" cfsqltype="cf_sql_integer">)
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsIndexCollectionType = StructNew()>
    <cfset rsIndexCollectionType.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsIndexCollectionType>
    </cffunction>
    
    <cffunction name="getIndexCollectionAction" access="public" returntype="query" hint="Get Index Collection Action data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="ID" type="numeric" required="yes" default="0">
    <cfargument name="excludeID" type="numeric" required="yes" default="0">
    <cfargument name="icaStatus" type="string" required="yes" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="icaName">
    <cfset var rsIndexCollectionAction = "" >
    <cftry>
    <cfquery name="rsIndexCollectionAction" datasource="#application.mcmsDSN#">
    SELECT * FROM v_index_collection_action WHERE 0=0
    <cfif ARGUMENTS.ID NEQ 0>
    AND ID = <cfqueryparam value="#ARGUMENTS.ID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.excludeID NEQ 0>
    AND ID <> <cfqueryparam value="#ARGUMENTS.excludeID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND UPPER(icaName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">
    </cfif>
    AND icaStatus IN (<cfqueryparam value="#ARGUMENTS.icaStatus#" list="yes" cfsqltype="cf_sql_integer">)
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsIndexCollectionAction = StructNew()>
    <cfset rsIndexCollectionAction.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsIndexCollectionAction>
    </cffunction>
    
    <cffunction name="getIndexCollectionReport" access="public" returntype="query" hint="Get Index Collection Report data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="orderBy" type="string" required="yes" default="icName">
    <cfset var rsIndexCollectionReport = "" >
    <cftry>
    <cfquery name="rsIndexCollectionReport" datasource="#application.mcmsDSN#">
    SELECT icName AS Collection, icDescription AS Description, icaName AS Action, ictName AS Type, icCategory AS Category_Status, icExtension AS File_Extensions, icURLPath AS URL, icDirectory AS Directory, userFName || ' ' || userLName AS Name, userEmail AS Email, TO_CHAR(icDate, 'MM/DD/YYYY') AS Date_Modifed, sName AS Status FROM v_index_collection WHERE 0=0
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(icName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(icDescription) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">)
    </cfif>
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsIndexCollectionReport = StructNew()>
    <cfset rsIndexCollectionReport.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsIndexCollectionReport>
    </cffunction>
    
    <cffunction name="getIndexCollectionTypeReport" access="public" returntype="query" hint="Get Index Collection Type Report data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="orderBy" type="string" required="yes" default="ictName">
    <cfset var rsIndexCollectionTypeReport = "" >
    <cftry>
    <cfquery name="rsIndexCollectionTypeReport" datasource="#application.mcmsDSN#">
    SELECT ictName AS Name, ictDescription AS Description, sSort AS Sort, sStatus AS Status FROM v_index_collection_type WHERE 0=0
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND UPPER(ictName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">
    </cfif>
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsIndexCollectionTypeReport = StructNew()>
    <cfset rsIndexCollectionTypeReport.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsIndexCollectionTypeReport>
    </cffunction>
    
    <cffunction name="getIndexCollectionActionReport" access="public" returntype="query" hint="Get Index Collection Action Report data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="orderBy" type="string" required="yes" default="icaName">
    <cfset var rsIndexCollectionActionReport = "" >
    <cftry>
    <cfquery name="rsIndexCollectionActionReport" datasource="#application.mcmsDSN#">
    SELECT icaName AS Name, icaDescription AS Description, sSort AS Sort, sStatus AS Status FROM v_index_collection_action WHERE 0=0
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND UPPER(icaName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">
    </cfif>
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsIndexCollectionActionReport = StructNew()>
    <cfset rsIndexCollectionActionReport.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsIndexCollectionActionReport>
    </cffunction>
    
    <cffunction name="insertIndexCollection" access="public" returntype="struct">
    <cfargument name="icName" type="string" required="yes">
    <cfargument name="icDescription" type="string" required="yes">
    <cfargument name="icaID" type="numeric" required="yes">
    <cfargument name="ictID" type="numeric" required="yes">
    <cfargument name="icCategory" type="numeric" required="yes">
    <cfargument name="icExtension" type="string" required="yes">
    <cfargument name="icURLPath" type="string" required="yes">
    <cfargument name="icDirectory" type="string" required="yes">
    <cfargument name="icStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully inserted the record.">
    <cftry>
    <!---Check for profanity in the text.--->
    <cfinvoke 
    component="MCMS.component.utility.Regex"
    method="regexProfanity"
    returnvariable="regexProfanityRet">
    <cfinvokeargument name="profanityString" value="#ARGUMENTS.icDescription#"/>
    </cfinvoke>
    <!---Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.app.index_manager"
    method="getIndexCollection"
    returnvariable="getCheckIndexCollectionRet">
    <cfinvokeargument name="icName" value="#ARGUMENTS.icName#"/>
    <cfinvokeargument name="icaID" value="#ARGUMENTS.icaID#"/>
    <cfinvokeargument name="icStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckIndexCollectionRet.recordcount NEQ 0>
    <cfset result.message = "The name #ARGUMENTS.icName# already exists, please enter a new name.">
    <cfelseif regexProfanityRet CONTAINS '$%&*!'>
    <cfset result.message = "Some text contained profanity, please remove any profanity from your text.">
    <!---Check length restriction.--->
    <cfelseif LEN(ARGUMENTS.icDescription) GT 1048>
    <cfset result.message = "The description is longer than 1048 characters, please enter a new description under 1048 characters.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    INSERT INTO tbl_index_collection (icName,icDescription,icaID,ictID,icCategory,icExtension,icURLPath,icDirectory,userID,icStatus) VALUES
    (
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.icName#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.icDescription#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.icaID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ictID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.icCategory#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.icExtension#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.icURLPath#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.icDirectory#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#session.userID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.icStatus#">
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
    
    <cffunction name="updateIndexCollection" access="public" returntype="struct">
    <cfargument name="ID" type="numeric" required="yes">
    <cfargument name="icName" type="string" required="yes">
    <cfargument name="icDescription" type="string" required="yes">
    <cfargument name="icaID" type="numeric" required="yes">
    <cfargument name="ictID" type="numeric" required="yes">
    <cfargument name="icCategory" type="numeric" required="yes">
    <cfargument name="icExtension" type="string" required="yes">
    <cfargument name="icURLPath" type="string" required="yes">
    <cfargument name="icDirectory" type="string" required="yes">
    <cfargument name="icStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully updated the record.">
    <cftry>
    <!---Check for profanity in the text.--->
    <cfinvoke 
    component="MCMS.component.utility.Regex"
    method="regexProfanity"
    returnvariable="regexProfanityRet">
    <cfinvokeargument name="profanityString" value="#ARGUMENTS.icDescription#"/>
    </cfinvoke>
    <!---Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.app.index_manager"
    method="getIndexCollection"
    returnvariable="getCheckIndexCollectionRet">
    <cfinvokeargument name="excludeID" value="#ARGUMENTS.ID#"/>
    <cfinvokeargument name="icName" value="#ARGUMENTS.icName#"/>
    <cfinvokeargument name="icStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckIndexCollectionRet.recordcount NEQ 0>
    <cfset result.message = "The name #ARGUMENTS.icName# already exists, please enter a new name.">
    <cfelseif regexProfanityRet CONTAINS '$%&*!'>
    <cfset result.message = "Some text contained profanity, please remove any profanity from your text.">
    <!---Check length restriction.--->
    <cfelseif LEN(ARGUMENTS.icDescription) GT 1048>
    <cfset result.message = "The description is longer than 1048 characters, please enter a new description under 1048 characters.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_index_collection SET
    icName = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.icName#">,
    icDescription = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.icDescription#">,
    icaID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.icaID#">,
    ictID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ictID#">,
    icCategory = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.icCategory#">,
    icExtension = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.icExtension#">,
    icURLPath = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.icURLPath#">,
    icDirectory = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.icDirectory#">,
    userID = <cfqueryparam cfsqltype="cf_sql_integer" value="#session.userID#">,
    icDate = <cfqueryparam cfsqltype="cf_sql_date" value="#Now()#">,
    icStatus = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.icStatus#">
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
    
    <cffunction name="updateIndexCollectionList" access="public" returntype="struct">
    <cfargument name="ID" type="numeric" required="yes">
    <cfargument name="icStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully updated the records.">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_index_collection SET
    icStatus = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.icStatus#">
    WHERE ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ID#">
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error updating the records.">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="deleteIndexCollection" access="public" returntype="struct">
    <cfargument name="ID" type="string" required="yes">
    <cfset result.message = "You have successfully deleted the record(s).">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    DELETE FROM tbl_index_collection
    WHERE ID IN (<cfqueryparam cfsqltype="cf_sql_integer" list="yes" value="#ARGUMENTS.ID#">)
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error deleting the record(s).">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction> 
    
    <cffunction name="setIndexCollection" access="public" returntype="struct" hint="Set Index Collection.">
    <cfargument name="ID" type="numeric" required="yes" default="0">
    <cfset result.message = "">
    <cftry>
	<cfif Find("Windows", Server.OS.Name)>
    <!---Get the action type, name, and category flag for the collection.--->
    <cfinvoke 
    component="MCMS.component.app.index_manager"
    method="getIndexCollection"
    returnvariable="getIndexCollectionRet">
    <cfinvokeargument name="ID" value="#ARGUMENTS.ID#"/>
    <cfinvokeargument name="icStatus" value="1"/>
    </cfinvoke>
    <cfset this.collectionName = LCASE(getIndexCollectionRet.icName)>
    <!--- Verify if Verity is up, and if so does it have any collections? --->
    <cfcollection name="getCollectionRet" action="list" />
    <!---Check for the existing collection.--->
    <cfquery name="getCheckCollectionRet" dbtype="query">
    SELECT * FROM getCollectionRet
    WHERE NAME = <cfqueryparam cfsqltype="cf_sql_varchar" value="#this.collectionName#">
    </cfquery>
	<cfif getCollectionRet.recordcount EQ 0>
    <cfset result.message = 'Search is down or the "<u>#this.collectionName#</u>" collection has not been setup on this server!'>
    <cfelse>
    <cfset this.collectionAction = getIndexCollectionRet.icaName>
    <cfset this.collectionCategory = getIndexCollectionRet.icCategory>
    <cfset this.collectionExtension = getIndexCollectionRet.icExtension>
    <cfset this.collectionURLPath = getIndexCollectionRet.icURLPath>
    <cfset this.collectionDirectory = getIndexCollectionRet.icDirectory>
    <!---Create the collection path variable.--->
    <cfset this.collectionPath = application.indexManagerPath>
    <cfswitch expression="#LCASE(this.collectionAction)#">
    <cfcase value="create">
    <cfif getCheckCollectionRet.recordcount NEQ 0>
    <cfset result.message = "The #this.collectionName# collection has already been created.">
    <cfelse>
    <cfcollection action="create" collection="#this.collectionName#"
    path="#this.collectionPath#" categories="#YesNoFormat(this.collectionCategory)#">
    <!---Build the index.--->
    <cfindex action="update" collection="#this.collectionName#" extensions="#this.collectionExtension#" key="#this.collectionDirectory#" type="path" urlpath="#this.collectionURLPath#" recurse="yes" language="english">
    <cfinvoke 
    component="MCMS.component.utility.Email"
    method="sendEmail"
    returnvariable="sendEmailRet">
    <cfinvokeargument name="subject" value="#UCASE(this.collectionName)# Index - Created"/>
    <cfinvokeargument name="to" value="#session.userUsername#"/>
    <cfinvokeargument name="from" value="#session.userUsername#"/>
    <cfinvokeargument name="body" value="The #this.collectionName# - #this.collectionDirectory# - #this.collectionExtension# - #this.collectionURLPath# index creation has completed."/>
    <cfinvokeargument name="emailType" value="html"/>
    <cfinvokeargument name="type" value="admin"/>
    </cfinvoke>
    <cfset result.message = "The #this.collectionName# collection is being created. It may take some time to complete. You will be notified via Email when it is complete.">
    </cfif> 
    </cfcase>
    <cfcase value="optimize">
    <cfif getCheckCollectionRet.recordcount EQ 0>
    <cfset result.message = "The #this.collectionName# collection does not exist, you must create it.">
    <cfelse>
    <!---Rebuild the index.--->
    <cfthread action="run" name="#this.collectionName#RefreshIndex" priority="high">
    <cfindex action="refresh" collection="#this.collectionName#" extensions="#this.collectionExtension#" key="#this.collectionDirectory#" type="path" urlpath="#this.collectionURLPath#"> 
    <cfcollection action="optimize" collection="#this.collectionName#">
    <cfinvoke 
    component="MCMS.component.utility.Email"
    method="sendEmail"
    returnvariable="sendEmailRet">
    <cfinvokeargument name="subject" value="#UCASE(this.collectionName)# Index - Optimized"/>
    <cfinvokeargument name="to" value="#session.userUsername#"/>
    <cfinvokeargument name="from" value="#session.userUsername#"/>
    <cfinvokeargument name="body" value="The #this.collectionName# index optimization has completed."/>
    <cfinvokeargument name="emailType" value="html"/>
    <cfinvokeargument name="type" value="admin"/>
    </cfinvoke>
    </cfthread>
    <cfset result.message = "The #this.collectionName# collection is being optimized. It may take some time to complete. You will be notified via Email when it is complete.">
    </cfif>
    </cfcase>
    <cfcase value="delete">
    <cfif getCheckCollectionRet.recordcount EQ 0>
    <cfset result.message = "The #this.collectionName# collection does not exist, you must create it.">
    <cfelse>
    <cfthread action="run" name="#this.collectionName#DeleteIndex" priority="high">
    <cfcollection action="delete" collection="#this.collectionName#">
    <cfinvoke 
    component="MCMS.component.utility.Email"
    method="sendEmail"
    returnvariable="sendEmailRet">
    <cfinvokeargument name="subject" value="#UCASE(this.collectionName)# Index - Deleted"/>
    <cfinvokeargument name="to" value="#session.userUsername#"/>
    <cfinvokeargument name="from" value="#session.userUsername#"/>
    <cfinvokeargument name="body" value="The #this.collectionName# index has been deleted."/>
    <cfinvokeargument name="emailType" value="html"/>
    <cfinvokeargument name="type" value="admin"/>
    </cfinvoke>
    </cfthread>
    <cfset result.message = "The #this.collectionName# collection has been deleted. It may take some time to complete. You will be notified via Email when it is complete.">
    </cfif>
    </cfcase>
    </cfswitch>
    </cfif>
	<cfelse>
    <cfset result.message = "No index collections are configured for this server type.">
    </cfif>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset result = StructNew()>
    <cfset result.message = "There was an error executing the collection.">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>  
</cfcomponent>