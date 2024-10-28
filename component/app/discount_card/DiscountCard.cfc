<cfcomponent>
    <cffunction name="getDiscountCard" access="public" returntype="query" hint="Get Discount Card data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="ID" type="string" required="yes" default="0">
    <cfargument name="siteNo" type="string" required="yes" default="100">
    <cfargument name="dctCode" type="string" required="yes" default="E">
    <cfargument name="dcDate" type="string" required="yes" default="#DateFormat(DateAdd('yyyy', '-5', Now()), application.dateFormat)#">
    <cfargument name="dcStatus" type="string" required="yes" default="A">
    <cfargument name="orderBy" type="string" required="yes" default="NAME">
    <cfset var rsDiscountCard = "" >
    <cftry>
    <cfquery name="rsDiscountCard" datasource="#application.retaildsn#">
    SELECT CUSTOMER_ID AS ID, FIRST_NAME AS dcFName, NAME AS dcLName, CONTACT AS dcContact, DATE_CREATED AS dcDate, PRIMARY_SITE_NO AS siteNo, THIS_YEAR_AMT AS dcAmount, TYPE_CD AS dctCode, STATUS_CD AS dcStatus FROM TMX.CUSTOMER WHERE 0=0
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND UPPER(NAME) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"/>
    </cfif>
    <cfif ARGUMENTS.ID NEQ 0>
    AND CUSTOMER_ID IN (<cfqueryparam value="#ARGUMENTS.ID#" list="yes" cfsqltype="cf_sql_varchar"/>) 
    </cfif> 
    <cfif ARGUMENTS.dctCode NEQ ''>
    AND TYPE_CD = <cfqueryparam value="#ARGUMENTS.dctCode#" cfsqltype="cf_sql_varchar"/> 
    </cfif>
    <cfif ARGUMENTS.dcDate NEQ ''>
    AND DATE_CREATED > <cfqueryparam value="#ARGUMENTS.dcDate#" cfsqltype="cf_sql_date"/>
    </cfif>
    <cfif ARGUMENTS.siteNo NEQ 100>
    <cfif ARGUMENTS.siteNo EQ 98 OR ARGUMENTS.siteNo EQ 101>
    AND PRIMARY_SITE_NO IN (<cfqueryparam value="1" list="yes" cfsqltype="cf_sql_integer"/>)
    <cfelse>
    AND PRIMARY_SITE_NO IN (<cfqueryparam value="#ARGUMENTS.siteNo#" list="yes" cfsqltype="cf_sql_integer"/>)
    </cfif>
    </cfif>
    AND STATUS_CD = <cfqueryparam value="#ARGUMENTS.dcStatus#" cfsqltype="cf_sql_varchar"/> 
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsDiscountCard = StructNew()>
    <cfset rsDiscountCard.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsDiscountCard>
    </cffunction>
    
    <cffunction name="getDiscountCardType" access="public" returntype="query" hint="Get Discount Card Type data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="ID" type="numeric" required="yes" default="0">
    <cfargument name="excludeID" type="numeric" required="yes" default="0">
    <cfargument name="dctName" type="string" required="yes" default="">
    <cfargument name="dctCode" type="string" required="yes" default="">
    <cfargument name="dctStatus" type="string" required="yes" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="dctName">
    <cfset var rsDiscountCardType = "" >
    <cftry>
    <cfquery name="rsDiscountCardType" datasource="#application.mcmsDSN#">
    SELECT * FROM v_discount_card_type WHERE 0=0
    <cfif ARGUMENTS.ID NEQ 0>
    AND ID = <cfqueryparam value="#ARGUMENTS.ID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.excludeID NEQ 0>
    AND ID <> <cfqueryparam value="#ARGUMENTS.excludeID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND UPPER(dctName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">
    </cfif>
    <cfif ARGUMENTS.dctName NEQ ''>
    AND dctName = <cfqueryparam value="#ARGUMENTS.dctName#" cfsqltype="cf_sql_varchar">
    </cfif>
    <cfif ARGUMENTS.dctCode NEQ ''>
    AND dctCode = <cfqueryparam value="#ARGUMENTS.dctCode#" cfsqltype="cf_sql_varchar">
    </cfif>
    AND dctStatus IN (<cfqueryparam value="#ARGUMENTS.dctStatus#" list="yes" cfsqltype="cf_sql_integer">)
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsDiscountCardType = StructNew()>
    <cfset rsDiscountCardType.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsDiscountCardType>
    </cffunction>
    
    <cffunction name="getDiscountCardReport" access="public" returntype="query" hint="Get Discount Card Report data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="siteNo" type="string" required="yes" default="100">
    <cfargument name="dctCode" type="string" required="yes" default="E">
    <cfargument name="dcDate" type="string" required="yes" default="#DateFormat(DateAdd('yyyy', '-5', Now()), application.dateFormat)#">
    <cfargument name="dcStatus" type="string" required="yes" default="A">
    <cfargument name="orderBy" type="string" required="yes" default="NAME, PRIMARY_SITE_NO">
    <cfset var rsDiscountCardReport = "" >
    <cftry>
    <cfquery name="rsDiscountCardReport" datasource="#application.retaildsn#">
    SELECT CUSTOMER_ID AS ID, FIRST_NAME AS dcFName, NAME AS dcLName, CONTACT AS dcContact, TO_CHAR(DATE_CREATED, 'MM/DD/YYYY') AS dcDate, PRIMARY_SITE_NO AS siteNo, THIS_YEAR_AMT AS dcAmount, TYPE_CD AS dctCode, STATUS_CD AS dcStatus FROM TMX.CUSTOMER WHERE 0=0
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND UPPER(NAME) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">
    </cfif>
    <cfif ARGUMENTS.dctCode NEQ ''>
    AND TYPE_CD = <cfqueryparam value="#ARGUMENTS.dctCode#" cfsqltype="cf_sql_varchar"/> 
    </cfif>
    <cfif ARGUMENTS.dcDate NEQ ''>
    AND DATE_CREATED > <cfqueryparam value="#ARGUMENTS.dcDate#" cfsqltype="cf_sql_date"/>
    </cfif>
    AND PRIMARY_SITE_NO IN (<cfqueryparam value="#Iif(ARGUMENTS.siteNo EQ 100, DE(session.siteNo), DE(ARGUMENTS.siteNo))#" list="yes" cfsqltype="cf_sql_integer"/>)
    AND STATUS_CD = <cfqueryparam value="#ARGUMENTS.dcStatus#" cfsqltype="cf_sql_varchar"/> 
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsDiscountCardReport = StructNew()>
    <cfset rsDiscountCardReport.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsDiscountCardReport>
    </cffunction>   
    
    <cffunction name="getDiscountCardTypeReport" access="public" returntype="query" hint="Get Discount Card Type Report data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="orderBy" type="string" required="yes" default="dctSort, dctName">
    <cfset var rsDiscountCardTypeReport = "" >
    <cftry>
    <cfquery name="rsDiscountCardTypeReport" datasource="#application.mcmsDSN#">
    SELECT dctName AS Name, dctDescription AS Description, dctCode AS Code, sortName AS Sort, sName AS Status FROM v_discount_card_type WHERE 0=0
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND UPPER(dctName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">
    </cfif>
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsDiscountCardTypeReport = StructNew()>
    <cfset rsDiscountCardTypeReport.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsDiscountCardTypeReport>
    </cffunction> 
    
    <cffunction name="insertDiscountCardType" access="public" returntype="struct">
    <cfargument name="dctName" type="string" required="yes">
    <cfargument name="dctDescription" type="string" required="yes">
    <cfargument name="dctCode" type="string" required="yes">
    <cfargument name="dctSort" type="numeric" required="yes">
    <cfargument name="dctStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully inserted the record.">
    <cftry>
    <!---Check for profanity in the text.--->
    <cfinvoke 
    component="MCMS.component.utility.Regex"
    method="regexProfanity"
    returnvariable="regexProfanityRet">
    <cfinvokeargument name="profanityString" value="#ARGUMENTS.dctDescription#"/>
    </cfinvoke>
    <!---Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.app.discount_card.DiscountCard"
    method="getDiscountCardType"
    returnvariable="getCheckDiscountCardTypeRet">
    <cfinvokeargument name="dctName" value="#ARGUMENTS.dctName#"/>
    <cfinvokeargument name="dctCode" value="#ARGUMENTS.dctCode#"/>
    <cfinvokeargument name="dctStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckDiscountCardTypeRet.recordcount NEQ 0>
    <cfset result.message = "The name #ARGUMENTS.dctName# already exists with this Code, please enter a new name/code.">
    <cfelseif regexProfanityRet CONTAINS '$%&*!'>
    <cfset result.message = "Some text contained profanity, please remove any profanity from your text.">
    <!---Check length restriction.--->
    <cfelseif LEN(ARGUMENTS.dctDescription) GT 512>
    <cfset result.message = "The description is longer than 512 characters, please enter a new description under 512 characters.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    INSERT INTO tbl_discount_card_type (dctName,dctDescription,dctCode,dctSort,dctStatus) VALUES
    (
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.dctName#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.dctDescription#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.dctCode#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.dctSort#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.dctStatus#">
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
    
    <cffunction name="updateDiscountCardType" access="public" returntype="struct">
    <cfargument name="ID" type="numeric" required="yes">
    <cfargument name="dctName" type="string" required="yes">
    <cfargument name="dctDescription" type="string" required="yes">
    <cfargument name="dctCode" type="string" required="yes">
    <cfargument name="dctSort" type="numeric" required="yes">
    <cfargument name="dctStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully updated the record.">
    <cftry>
    <!---Check for profanity in the text.--->
    <cfinvoke 
    component="MCMS.component.utility.Regex"
    method="regexProfanity"
    returnvariable="regexProfanityRet">
    <cfinvokeargument name="profanityString" value="#ARGUMENTS.dctDescription#"/>
    </cfinvoke>
    <!---Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.app.discount_card.DiscountCard"
    method="getDiscountCardType"
    returnvariable="getCheckDiscountCardTypeRet">
    <cfinvokeargument name="excludeID" value="#ARGUMENTS.ID#"/>
    <cfinvokeargument name="dctName" value="#ARGUMENTS.dctName#"/>
    <cfinvokeargument name="dctCode" value="#ARGUMENTS.dctCode#"/>
    <cfinvokeargument name="dctStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckDiscountCardTypeRet.recordcount NEQ 0>
    <cfset result.message = "The name #ARGUMENTS.dctName# already exists with this Code, please enter a new name/code.">
    <cfelseif regexProfanityRet CONTAINS '$%&*!'>
    <cfset result.message = "Some text contained profanity, please remove any profanity from your text.">
    <!---Check length restriction.--->
    <cfelseif LEN(ARGUMENTS.dctDescription) GT 512>
    <cfset result.message = "The description is longer than 512 characters, please enter a new description under 512 characters.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_discount_card_type SET
    dctName = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.dctName#">,
    dctDescription = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.dctDescription#">,
    dctCode = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.dctCode#">,
    dctSort = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.dctSort#">,
    dctStatus = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.dctStatus#">
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
    
    <cffunction name="updateDiscountCardTypeList" access="public" returntype="struct">
    <cfargument name="ID" type="numeric" required="yes">
    <cfargument name="dctStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully updated the records.">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_discount_card_type SET
    dctStatus = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.dctStatus#">
    WHERE ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ID#">
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error updating the records.">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="deleteDiscountCardType" access="public" returntype="struct">
    <cfargument name="ID" type="string" required="yes">
    <cfset result.message = "You have successfully deleted the record(s).">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    DELETE FROM tbl_discount_card_type
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