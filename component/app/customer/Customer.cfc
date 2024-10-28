<cfcomponent>
    <cffunction name="getCustomer" access="public" returntype="query" hint="Get Customer data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="ID" type="numeric" required="yes" default="0">
    <cfargument name="excludeID" type="numeric" required="yes" default="0">
    <cfargument name="cstLName" type="string" required="yes" default="">
    <cfargument name="csttID" type="string" required="yes" default="0">
    <cfargument name="cstStatus" type="string" required="yes" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="cstLName">
    <cfset var rsCustomer = "" >
    <cftry>
    <cfquery name="rsCustomer" datasource="#application.mcmsDSN#">
    SELECT * FROM v_customer WHERE 0=0
    <cfif ARGUMENTS.ID NEQ 0>
    AND ID = <cfqueryparam value="#ARGUMENTS.ID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.excludeID NEQ 0>
    AND ID <> <cfqueryparam value="#ARGUMENTS.excludeID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(cstLName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(cstEmail) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">)
    </cfif>
    <cfif ARGUMENTS.cstLName NEQ "">
    AND UPPER(cstLName) = <cfqueryparam value="#UCASE(ARGUMENTS.cstLName)#" cfsqltype="cf_sql_varchar">
    </cfif>
    <cfif ARGUMENTS.csttID NEQ 0>
    AND csttID = <cfqueryparam value="#ARGUMENTS.csttID#" cfsqltype="cf_sql_integer">
    </cfif>
    AND cstStatus IN (<cfqueryparam value="#ARGUMENTS.cstStatus#" list="yes" cfsqltype="cf_sql_integer">)
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsCustomer = StructNew()>
    <cfset rsCustomer.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsCustomer>
    </cffunction>
    
    <cffunction name="getCustomerType" access="public" returntype="query" hint="Get Customer Type data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="ID" type="numeric" required="yes" default="0">
    <cfargument name="excludeID" type="numeric" required="yes" default="0">
    <cfargument name="csttName" type="string" required="yes" default="">
    <cfargument name="csttStatus" type="string" required="yes" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="csttName">
    <cfset var rsCustomerType = "" >
    <cftry>
    <cfquery name="rsCustomerType" datasource="#application.mcmsDSN#">
    SELECT * FROM v_customer_type WHERE 0=0
    <cfif ARGUMENTS.ID NEQ 0>
    AND ID = <cfqueryparam value="#ARGUMENTS.ID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.excludeID NEQ 0>
    AND ID <> <cfqueryparam value="#ARGUMENTS.excludeID#" cfsqltype="cf_sql_integer">
    </cfif>
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND UPPER(csttName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">
    </cfif>
    <cfif ARGUMENTS.csttName NEQ "">
    AND UPPER(csttName) = <cfqueryparam value="#UCASE(ARGUMENTS.csttName)#" cfsqltype="cf_sql_varchar">
    </cfif>
    AND csttStatus IN (<cfqueryparam value="#ARGUMENTS.csttStatus#" list="yes" cfsqltype="cf_sql_integer">)
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsCustomerType = StructNew()>
    <cfset rsCustomerType.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsCustomerType>
    </cffunction>
    
    <cffunction name="getCustomerReport" access="public" returntype="query" hint="Get Customer Report data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="orderBy" type="string" required="yes" default="cstLName">
    <cfset var rsCustomerReport = "" >
    <cftry>
    <cfquery name="rsCustomerReport" datasource="#application.mcmsDSN#">
    SELECT cstFName || ' ' || cstLName AS Name, cstEmail As Email, sName As Status FROM v_customer WHERE 0=0
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(cstLName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(cstEmail) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">)
    </cfif>
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsCustomerReport = StructNew()>
    <cfset rsCustomerReport.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsCustomerReport>
    </cffunction>
    
    <cffunction name="getCustomerTypeReport" access="public" returntype="query" hint="Get Customer Type Report data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="orderBy" type="string" required="yes" default="csttName">
    <cfset var rsCustomerTypeReport = "" >
    <cftry>
    <cfquery name="rsCustomerTypeReport" datasource="#application.mcmsDSN#">
    SELECT csttName AS Name, sortName as Sort, sName AS Status FROM v_customer_type WHERE 0=0
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND UPPER(csttName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">
    </cfif>
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsCustomerTypeReport = StructNew()>
    <cfset rsCustomerTypeReport.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsCustomerTypeReport>
    </cffunction>
    
    <cffunction name="insertCustomer" access="public" returntype="struct">
    <cfargument name="cstFName" type="string" required="yes">
    <cfargument name="cstLName" type="string" required="yes">
    <cfargument name="cstEmail" type="string" required="yes">
    <cfargument name="cstPassword" type="string" required="yes">
    <cfargument name="cstTaxExemptNo" type="string" required="yes">
    <cfargument name="cstAccount" type="string" required="yes">
    <cfargument name="csttID" type="numeric" required="yes">
    <cfargument name="userID" type="numeric" required="yes">
    <cfargument name="cstStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully inserted the record.">
    <cftry>
    <!---Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.app.customer.Customer"
    method="getCustomer"
    returnvariable="getCheckCustomerRet">
    <cfinvokeargument name="cstEmail" value="#TRIM(ARGUMENTS.cstEmail)#"/>
    <cfinvokeargument name="cstStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckCustomerRet.recordcount NEQ 0>
    <cfset result.message = "The customer email #TRIM(ARGUMENTS.cstEmail)# already exists, please enter a new email.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    INSERT INTO tbl_customer (cstFName,cstLName,cstEmail,cstPassword,csttaxExemptNo,cstAccount,cstIP,csttID,userID,cstStatus) VALUES
    (
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#TRIM(ARGUMENTS.cstFName)#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#TRIM(ARGUMENTS.cstLName)#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#TRIM(ARGUMENTS.cstEmail)#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#TRIM(ARGUMENTS.cstPassword)#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#TRIM(ARGUMENTS.cstTaxExemptNo)#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#TRIM(ARGUMENTS.cstAccount)#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#CGI.REMOTE_ADDR#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.csttID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.userID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.cstStatus#">
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
    
    <cffunction name="insertCustomerType" access="public" returntype="struct">
    <cfargument name="csttName" type="string" required="yes">
    <cfargument name="csttDescription" type="string" required="yes">
    <cfargument name="csttSort" type="numeric" required="yes">
    <cfargument name="csttStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully inserted the record.">
    <cftry>
    <!---Check for profanity in the text.--->
    <cfinvoke 
    component="MCMS.component.utility.Regex"
    method="regexProfanity"
    returnvariable="regexProfanityRet">
    <cfinvokeargument name="profanityString" value="#TRIM(ARGUMENTS.cstDescription)#"/>
    </cfinvoke>
    <!---Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.app.customer.Customer"
    method="getCustomerType"
    returnvariable="getCheckCustomerTypeRet">
    <cfinvokeargument name="csttName" value="#TRIM(ARGUMENTS.csttName)#"/>
    <cfinvokeargument name="csttStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckCustomerTypeRet.recordcount NEQ 0>
    <cfset result.message = "The name #TRIM(ARGUMENTS.csttName)# already exists, please enter a new name.">
    <cfelseif regexProfanityRet CONTAINS '$%&*!'>
    <cfset result.message = "Some text contained profanity, please remove any profanity from your text.">
    <!---Check length restriction.--->
    <cfelseif LEN(ARGUMENTS.csttDescription) GT 2048>
    <cfset result.message = "The description is longer than 2048 characters, please enter a new description under 2048 characters.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    INSERT INTO tbl_customer (csttName,csttDescription,csttSort,csttStatus) VALUES
    (
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#TRIM(ARGUMENTS.csttName)#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#TRIM(ARGUMENTS.csttDescription)#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.csttSort#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.csttStatus#">
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
    
    <cffunction name="updateCustomer" access="public" returntype="struct">
    <cfargument name="ID" type="numeric" required="yes">
    <cfargument name="cstFName" type="string" required="yes">
    <cfargument name="cstLName" type="string" required="yes">
    <cfargument name="cstEmail" type="string" required="yes">
    <cfargument name="cstPassword" type="string" required="yes">
    <cfargument name="cstTaxExemptNo" type="string" required="yes">
    <cfargument name="cstAccount" type="string" required="yes">
    <cfargument name="csttID" type="numeric" required="yes">
    <cfargument name="userID" type="numeric" required="yes">
    <cfargument name="cstStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully updated the record.">
    <cftry>
    <!---Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.app.customer.Customer"
    method="getCustomer"
    returnvariable="getCheckCustomerRet">
    <cfinvokeargument name="excludeID" value="#ARGUMENTS.ID#"/>
    <cfinvokeargument name="cstEmail" value="#TRIM(ARGUMENTS.cstEmail)#"/>
    <cfinvokeargument name="cstStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckCustomerRet.recordcount NEQ 0>
    <cfset result.message = "The email #TRIM(ARGUMENTS.cstEmail)# already exists, please enter a new email.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_customer SET
    cstFName = <cfqueryparam cfsqltype="cf_sql_varchar" value="#TRIM(ARGUMENTS.cstFName)#">,
    cstLName = <cfqueryparam cfsqltype="cf_sql_varchar" value="#TRIM(ARGUMENTS.cstLName)#">,
    cstEmail = <cfqueryparam cfsqltype="cf_sql_varchar" value="#TRIM(ARGUMENTS.cstEmail)#">,
    cstPassword = <cfqueryparam cfsqltype="cf_sql_varchar" value="#TRIM(ARGUMENTS.cstPassword)#">,
    cstTaxExemptNo = <cfqueryparam cfsqltype="cf_sql_varchar" value="#TRIM(ARGUMENTS.cstTaxExemptNo)#">,
    cstAccount = <cfqueryparam cfsqltype="cf_sql_varchar" value="#TRIM(ARGUMENTS.cstAccount)#">,
    cstIP = <cfqueryparam cfsqltype="cf_sql_varchar" value="#CGI.REMOTE_ADDR#">,
    csttID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.csttID#">,
    userID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.userID#">,
    cstStatus = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.cstStatus#">
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
    
    <cffunction name="updateCustomerType" access="public" returntype="struct">
    <cfargument name="ID" type="numeric" required="yes">
    <cfargument name="csttName" type="string" required="yes">
    <cfargument name="csttDescription" type="string" required="yes">
    <cfargument name="csttSort" type="numeric" required="yes">
    <cfargument name="csttStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully updated the record.">
    <cftry>
    <!---Check for profanity in the text.--->
    <cfinvoke 
    component="MCMS.component.utility.Regex"
    method="regexProfanity"
    returnvariable="regexProfanityRet">
    <cfinvokeargument name="profanityString" value="#TRIM(ARGUMENTS.cstDescription)#"/>
    </cfinvoke>
    <!---Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.app.customer.Customer"
    method="getCustomerType"
    returnvariable="getCheckCustomerTypeRet">
    <cfinvokeargument name="excludeID" value="#ARGUMENTS.ID#"/>
    <cfinvokeargument name="csttName" value="#TRIM(ARGUMENTS.csttName)#"/>
    <cfinvokeargument name="csttStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckCustomerTypeRet.recordcount NEQ 0>
    <cfset result.message = "The name #TRIM(ARGUMENTS.csttName)# already exists, please enter a new name.">
    <cfelseif regexProfanityRet CONTAINS '$%&*!'>
    <cfset result.message = "Some text contained profanity, please remove any profanity from your text.">
    <!---Check length restriction.--->
    <cfelseif LEN(ARGUMENTS.csttDescription) GT 2048>
    <cfset result.message = "The description is longer than 2048 characters, please enter a new description under 2048 characters.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_customer_type SET
    csttName = <cfqueryparam cfsqltype="cf_sql_varchar" value="#TRIM(ARGUMENTS.csttName)#">,
    csttDescription = <cfqueryparam cfsqltype="cf_sql_varchar" value="#TRIM(ARGUMENTS.csttDescription)#">,
    csttSort = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.csttSort#">,
    csttStatus = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.csttStatus#">
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
    
    <cffunction name="updateCustomerList" access="public" returntype="struct">
    <cfargument name="ID" type="numeric" required="yes">
    <cfargument name="cstStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully updated the records.">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_customer SET
    cstStatus = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.cstStatus#">
    WHERE ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ID#">
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error updating the records.">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="updateCustomerTypeList" access="public" returntype="struct">
    <cfargument name="ID" type="numeric" required="yes">
    <cfargument name="csttStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully updated the records.">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_customer_type SET
    csttStatus = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.csttStatus#">
    WHERE ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ID#">
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error updating the records.">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="deleteCustomer" access="public" returntype="struct">
    <cfargument name="ID" type="string" required="yes">
    <cfset result.message = "You have successfully deleted the record(s).">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    DELETE FROM tbl_customer
    WHERE ID IN (<cfqueryparam cfsqltype="cf_sql_integer" list="yes" value="#ARGUMENTS.ID#">)
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error deleting the record(s).">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="deleteCustomerType" access="public" returntype="struct">
    <cfargument name="ID" type="string" required="yes">
    <cfset result.message = "You have successfully deleted the record(s).">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    DELETE FROM tbl_customer_type
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