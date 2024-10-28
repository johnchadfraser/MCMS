<cfcomponent>
    <cffunction name="getSocial" access="public" returntype="query" hint="Get Social data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="ID" type="numeric" required="yes" default="0">
    <cfargument name="excludeID" type="numeric" required="yes" default="0">
    <cfargument name="socName" type="string" required="yes" default="">
    <cfargument name="soctID" type="string" required="yes" default="0">
    <cfargument name="socStatus" type="string" required="yes" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="socName">
    <cfset var rsSocial = "" >
    <cftry>
    <cfquery name="rsSocial" datasource="#application.mcmsDSN#">
    SELECT * FROM v_social WHERE 0=0
    <cfif ARGUMENTS.ID NEQ 0>
    AND ID = <cfqueryparam value="#ARGUMENTS.ID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.excludeID NEQ 0>
    AND ID <> <cfqueryparam value="#ARGUMENTS.excludeID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(socName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(socDescription) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">)
    </cfif>
    <cfif ARGUMENTS.socName NEQ "">
    AND UPPER(socName) = <cfqueryparam value="#UCASE(ARGUMENTS.socName)#" cfsqltype="cf_sql_varchar">
    </cfif>
    <cfif ARGUMENTS.soctID NEQ 0>
    AND soctID = <cfqueryparam value="#ARGUMENTS.soctID#" cfsqltype="cf_sql_integer">
    </cfif>
    AND socStatus IN (<cfqueryparam value="#ARGUMENTS.socStatus#" list="yes" cfsqltype="cf_sql_integer">)
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsSocial = StructNew()>
    <cfset rsSocial.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsSocial>
    </cffunction>
    
    <cffunction name="getSocialType" access="public" returntype="query" hint="Get Social Type data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="ID" type="numeric" required="yes" default="0">
    <cfargument name="excludeID" type="numeric" required="yes" default="0">
    <cfargument name="soctStatus" type="string" required="yes" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="soctName">
    <cfset var rsSocialType = "" >
    <cftry>
    <cfquery name="rsSocialType" datasource="#application.mcmsDSN#">
    SELECT * FROM v_social_type WHERE 0=0
    <cfif ARGUMENTS.ID NEQ 0>
    AND ID = <cfqueryparam value="#ARGUMENTS.ID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.excludeID NEQ 0>
    AND ID <> <cfqueryparam value="#ARGUMENTS.excludeID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND UPPER(soctName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">
    </cfif>
    AND soctStatus IN (<cfqueryparam value="#ARGUMENTS.soctStatus#" list="yes" cfsqltype="cf_sql_integer">)
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsSocialType = StructNew()>
    <cfset rsSocialType.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsSocialType>
    </cffunction>
    
    <cffunction name="getSocialReport" access="public" returntype="query" hint="Get Social Report data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="orderBy" type="string" required="yes" default="socName">
    <cfset var rsSocialReport = "" >
    <cftry>
    <cfquery name="rsSocialReport" datasource="#application.mcmsDSN#">
    SELECT socName AS Name, TO_CHAR(socDescription) AS Description, socMeta AS Meta, socURL as URL, socTarget AS Target, socFeedURL AS Feed, socFeedFormat AS Format, socTags as Tags, socArgument As Arguments, socLogo AS Logo, socSourceID AS Source_ID, socSourceTitle AS Title, socSourceThumb AS Thumb, socUsername AS Username, socPassword AS Password, socScreenname AS Screenname, socCount AS Count, TO_CHAR(socDate, 'MM/DD/YYYY') AS Date_Created, TO_CHAR(socDateExp, 'MM/DD/YYYY') AS Date_Expires, soctName AS Type, sortname AS Sort, sName AS Status FROM v_social WHERE 0=0
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(socName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(socDescription) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">)
    </cfif>
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsSocialReport = StructNew()>
    <cfset rsSocialReport.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsSocialReport>
    </cffunction>
    
    <cffunction name="getSocialTypeReport" access="public" returntype="query" hint="Get Social Type Report data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="orderBy" type="string" required="yes" default="soctName">
    <cfset var rsSocialTypeReport = "" >
    <cftry>
    <cfquery name="rsSocialTypeReport" datasource="#application.mcmsDSN#">
    SELECT soctName AS Name, TO_CHAR(soctDescription) AS Description, sName AS Status FROM v_social_type WHERE 0=0
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(soctName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(soctDescription) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">)
    </cfif>
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsSocialTypeReport = StructNew()>
    <cfset rsSocialTypeReport.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsSocialTypeReport>
    </cffunction>
    
    <cffunction name="insertSocial" access="public" returntype="struct">
    <cfargument name="socName" type="string" required="yes">
    <cfargument name="socDescription" type="string" required="yes">
    <cfargument name="socMeta" type="string" required="yes">
    <cfargument name="socURL" type="string" required="yes">
    <cfargument name="socTarget" type="string" required="yes">
    <cfargument name="socFeedURL" type="string" required="yes">
    <cfargument name="socFeedFormat" type="string" required="yes">
    <cfargument name="socTags" type="string" required="yes">
    <cfargument name="socArgument" type="string" required="yes">
    <cfargument name="socLogo" type="string" required="yes">
    <cfargument name="socSourceID" type="string" required="yes">
    <cfargument name="socSourceTitle" type="string" required="yes">
    <cfargument name="socSourceThumb" type="string" required="yes">
    <cfargument name="socUsername" type="string" required="yes">
    <cfargument name="socPassword" type="string" required="yes">
    <cfargument name="socScreenName" type="string" required="yes">
    <cfargument name="socCount" type="numeric" required="yes">
    <cfargument name="socDateExp" type="string" required="yes">
    <cfargument name="soctID" type="numeric" required="yes">
    <cfargument name="socSort" type="numeric" required="yes">
    <cfargument name="socStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully inserted the record.">
    <cftry>
    <!---Check for profanity in the text.--->
    <cfinvoke 
    component="MCMS.component.utility.Regex"
    method="regexProfanity"
    returnvariable="regexProfanityRet">
    <cfinvokeargument name="profanityString" value="#ARGUMENTS.socDescription#"/>
    </cfinvoke>
    <!---Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.app.social.Social"
    method="getSocial"
    returnvariable="getCheckSocialRet">
    <cfinvokeargument name="socName" value="#ARGUMENTS.socName#"/>
    <cfinvokeargument name="socStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckSocialRet.recordcount NEQ 0>
    <cfset result.message = "The name #ARGUMENTS.socName# already exists, please enter a new name.">
    <cfelseif regexProfanityRet CONTAINS '$%&*!'>
    <cfset result.message = "Some text contained profanity, please remove any profanity from your text.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    INSERT INTO tbl_social (socName,socDescription,socMeta,socURL,socTarget,socFeedURL,socFeedFormat,socTags,socArgument,socLogo,socSourceID,socSourceTitle,socSourceThumb,socUsername,socPassword,socScreenName,socCount,socDateExp,soctID,socSort,socStatus) VALUES
    (
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.socName#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.socDescription#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.socMeta#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.socURL#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.socTarget#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.socFeedURL#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.socFeedFormat#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.socTags#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.socArgument#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.socLogo#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.socSourceID#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.socSourceTitle#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.socSourceThumb#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.socUsername#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.socPassword#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.socScreenName#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.socCount#">,
    <cfqueryparam cfsqltype="cf_sql_date" value="#ARGUMENTS.socDateExp#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.soctID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.socSort#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.socStatus#">
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
    
    <cffunction name="insertSocialType" access="public" returntype="struct">
    <cfargument name="soctName" type="string" required="yes">
    <cfargument name="soctDescription" type="string" required="yes">
    <cfargument name="soctStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully inserted the record.">
    <cftry>
    <!---Check for profanity in the text.--->
    <cfinvoke 
    component="MCMS.component.utility.Regex"
    method="regexProfanity"
    returnvariable="regexProfanityRet">
    <cfinvokeargument name="profanityString" value="#ARGUMENTS.soctDescription#"/>
    </cfinvoke>
    <!---Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.app.social.Social"
    method="getSocialType"
    returnvariable="getCheckSocialTypeRet">
    <cfinvokeargument name="soctName" value="#ARGUMENTS.soctName#"/>
    <cfinvokeargument name="soctStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckSocialTypeRet.recordcount NEQ 0>
    <cfset result.message = "The name #ARGUMENTS.soctName# already exists, please enter a new name.">
    <cfelseif regexProfanityRet CONTAINS '$%&*!'>
    <cfset result.message = "Some text contained profanity, please remove any profanity from your text.">
    <!---Check length restriction.--->
    <cfelseif LEN(ARGUMENTS.soctDescripton) GT 512>
    <cfset result.message = "The description is longer than 512 characters, please enter a new name under 512 characters.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    INSERT INTO tbl_social_type (soctName,soctDescription,soctStatus) VALUES
    (
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.soctName#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.soctDescription#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.soctStatus#">
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
    
    <cffunction name="updateSocial" access="public" returntype="struct">
    <cfargument name="ID" type="numeric" required="yes">
    <cfargument name="socName" type="string" required="yes">
    <cfargument name="socDescription" type="string" required="yes">
    <cfargument name="socMeta" type="string" required="yes">
    <cfargument name="socURL" type="string" required="yes">
    <cfargument name="socTarget" type="string" required="yes">
    <cfargument name="socFeedURL" type="string" required="yes">
    <cfargument name="socFeedFormat" type="string" required="yes">
    <cfargument name="socTags" type="string" required="yes">
    <cfargument name="socArgument" type="string" required="yes">
    <cfargument name="socLogo" type="string" required="yes">
    <cfargument name="socSourceID" type="string" required="yes">
    <cfargument name="socSourceTitle" type="string" required="yes">
    <cfargument name="socSourceThumb" type="string" required="yes">
    <cfargument name="socUsername" type="string" required="yes">
    <cfargument name="socPassword" type="string" required="yes">
    <cfargument name="socScreenName" type="string" required="yes">
    <cfargument name="socCount" type="numeric" required="yes">
    <cfargument name="socDateExp" type="string" required="yes">
    <cfargument name="soctID" type="numeric" required="yes">
    <cfargument name="socSort" type="numeric" required="yes">
    <cfargument name="socStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully updated the record.">
    <cftry>
    <!---Check for profanity in the text.--->
    <cfinvoke 
    component="MCMS.component.utility.Regex"
    method="regexProfanity"
    returnvariable="regexProfanityRet">
    <cfinvokeargument name="profanityString" value="#ARGUMENTS.socDescription#"/>
    </cfinvoke>
    <!---Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.app.social.Social"
    method="getSocial"
    returnvariable="getCheckSocialRet">
    <cfinvokeargument name="excludeID" value="#ARGUMENTS.ID#"/>
    <cfinvokeargument name="socName" value="#ARGUMENTS.socName#"/>
    <cfinvokeargument name="socStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckSocialRet.recordcount NEQ 0>
    <cfset result.message = "The name #ARGUMENTS.socName# already exists, please enter a new name.">
    <cfelseif regexProfanityRet CONTAINS '$%&*!'>
    <cfset result.message = "Some text contained profanity, please remove any profanity from your text.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_social SET
    socName = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.socName#">,
    socDescription = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.socDescription#">,
    socMeta = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.socMeta#">,
    socURL = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.socURL#">,
    socTarget = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.socTarget#">,
    socFeedURL = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.socFeedURL#">,
    socFeedFormat = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.socFeedFormat#">,
    socTags = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.socTags#">,
    socArgument = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.socArgument#">,
    socLogo = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.socLogo#">,
    socSourceID = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.socSourceID#">,
    socSourceTitle = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.socSourceTitle#">,
    socSourceThumb = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.socSourceThumb#">,
    socUsername = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.socUsername#">,
    socPassword = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.socPassword#">,
    socScreenName = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.socScreenName#">,
    socCount = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.socCount#">,
    socDateExp = <cfqueryparam cfsqltype="cf_sql_date" value="#ARGUMENTS.socDateExp#">,
    soctID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.soctID#">,
    socSort = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.socSort#">,
    socStatus = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.socStatus#">
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
    
    <cffunction name="updateSocialType" access="public" returntype="struct">
    <cfargument name="ID" type="numeric" required="yes">
    <cfargument name="soctName" type="string" required="yes">
    <cfargument name="soctDescription" type="string" required="yes">
    <cfargument name="soctStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully updated the record.">
    <cftry>
    <!---Check for profanity in the text.--->
    <cfinvoke 
    component="MCMS.component.utility.Regex"
    method="regexProfanity"
    returnvariable="regexProfanityRet">
    <cfinvokeargument name="profanityString" value="#ARGUMENTS.soctDescription#"/>
    </cfinvoke>
    <!---Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.app.social.Social"
    method="getSocialType"
    returnvariable="getCheckSocialTypeRet">
    <cfinvokeargument name="excludeID" value="#ARGUMENTS.ID#"/>
    <cfinvokeargument name="soctName" value="#ARGUMENTS.soctName#"/>
    <cfinvokeargument name="soctStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckSocialTypeRet.recordcount NEQ 0>
    <cfset result.message = "The name #ARGUMENTS.soctName# already exists, please enter a new name.">
    <cfelseif regexProfanityRet CONTAINS '$%&*!'>
    <cfset result.message = "Some text contained profanity, please remove any profanity from your text.">
    <!---Check length restriction.--->
    <cfelseif LEN(ARGUMENTS.soctDescripton) GT 512>
    <cfset result.message = "The description is longer than 512 characters, please enter a new name under 512 characters.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_social_type SET
    soctName = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.soctName#">,
    soctDescription = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.soctDescription#">,
    soctStatus = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.soctStatus#">
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
    
    <cffunction name="updateSocialList" access="public" returntype="struct">
    <cfargument name="ID" type="numeric" required="yes">
    <cfargument name="socStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully updated the records.">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_social SET
    socStatus = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.socStatus#">
    WHERE ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ID#">
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error updating the records.">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="updateSocialTypeList" access="public" returntype="struct">
    <cfargument name="ID" type="numeric" required="yes">
    <cfargument name="soctStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully updated the records.">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_social_type SET
    soctStatus = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.soctStatus#">
    WHERE ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ID#">
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error updating the records.">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="deleteSocial" access="public" returntype="struct">
    <cfargument name="ID" type="string" required="yes">
    <cfset result.message = "You have successfully deleted the record(s).">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    DELETE FROM tbl_social
    WHERE ID IN (<cfqueryparam cfsqltype="cf_sql_integer" list="yes" value="#ARGUMENTS.ID#">)
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error deleting the record(s).">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction> 
    
    <cffunction name="deleteSocialType" access="public" returntype="struct">
    <cfargument name="ID" type="string" required="yes">
    <cfset result.message = "You have successfully deleted the record(s).">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    DELETE FROM tbl_social_type
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