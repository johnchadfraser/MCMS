<cfcomponent>

    <cffunction name="getSubscription" access="public" returntype="query" hint="Get Subscription data.">
    
        <cfargument name="keywords" type="string" required="yes" default="All">
        <cfargument name="ID" type="numeric" required="yes" default="0">
        <cfargument name="excludeID" type="numeric" required="yes" default="0">
        <cfargument name="subFName" type="string" required="yes" default="">
        <cfargument name="subEmail" type="string" required="yes" default="">
        <cfargument name="subStateProv" type="string" required="yes" default="">
        <cfargument name="subZipCode" type="string" required="yes" default="">
        <cfargument name="subTelArea" type="string" required="yes" default="">
        <cfargument name="subStatus" type="string" required="yes" default="1,3">
        <cfargument name="orderBy" type="string" required="yes" default="subLName">

        <cfset var rsSubscription = "" >

        <cftry>

            <cfquery name="rsSubscription" datasource="#application.mcmsDSN#">

                SELECT * FROM tbl_subscription WHERE 0=0

                <cfif ARGUMENTS.ID NEQ 0>

                    AND ID = <cfqueryparam value="#ARGUMENTS.ID#" cfsqltype="cf_sql_integer">

                </cfif>

                <cfif ARGUMENTS.excludeID NEQ 0>

                    AND ID <> <cfqueryparam value="#ARGUMENTS.excludeID#" cfsqltype="cf_sql_integer">

                </cfif>

                <cfif ARGUMENTS.keywords NEQ 'All'>

                    AND (UPPER(subFName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(subLName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(subEmail) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">)
                
                </cfif>

                <cfif ARGUMENTS.subFName NEQ "">

                    AND UPPER(subFName) = <cfqueryparam value="#UCASE(ARGUMENTS.subFName)#" cfsqltype="cf_sql_varchar">

                </cfif>

                <cfif ARGUMENTS.subEmail NEQ "">

                    AND UPPER(subEmail) = <cfqueryparam value="#UCASE(ARGUMENTS.subEmail)#" cfsqltype="cf_sql_varchar">

                </cfif>

                <cfif ARGUMENTS.subStateProv NEQ "">

                    AND UPPER(subStateProv) IN (<cfqueryparam value="#UCASE(ARGUMENTS.subStateProv)#" list="yes" cfsqltype="cf_sql_varchar">)

                </cfif>

                <cfif ARGUMENTS.subZipCode NEQ "">

                    AND UPPER(subZipCode) IN (<cfqueryparam value="#UCASE(ARGUMENTS.subZipCode)#" list="yes" cfsqltype="cf_sql_varchar">)

                </cfif>

                <cfif ARGUMENTS.subTelArea NEQ "">

                    AND UPPER(subTelArea) IN (<cfqueryparam value="#UCASE(ARGUMENTS.subTelArea)#" list="yes" cfsqltype="cf_sql_varchar">)

                </cfif>

                AND subStatus IN (<cfqueryparam value="#ARGUMENTS.subStatus#" list="yes" cfsqltype="cf_sql_integer">)
                ORDER BY #ARGUMENTS.orderBy#

            </cfquery>

            <!---Catch any errors.--->
            <cfcatch type="any">

                <cfset rsSubscription = StructNew()>
                <cfset rsSubscription.message = "There was an error with the query.">
            
            </cfcatch>

        </cftry>

        <cfreturn rsSubscription>

    </cffunction>
    
    <cffunction name="insertSubscription" access="public" returntype="struct">

        <cfargument name="subEmail" type="string" required="yes">
        <cfargument name="subPassword" type="string" required="yes" default="password">
        <cfargument name="subFName" type="string" required="yes">
        <cfargument name="subLName" type="string" required="yes">
        <cfargument name="subTelArea" type="string" required="yes">
        <cfargument name="subTelPrefix" type="string" required="yes">
        <cfargument name="subTelSuffix" type="string" required="yes">
        <cfargument name="subZipCode" type="string" required="yes">
        <cfargument name="subZipCodeExt" type="string" required="no" default="0">
        <cfargument name="subStateProv" type="string" required="yes">
        <cfargument name="subCountry" type="string" required="yes">
        <cfargument name="subStatus" type="numeric" required="yes" default="1">

        <cfset result.message = "You have successfully inserted the record.">

        <cftry>

            <!---Check for a duplicate record.--->
            <cfinvoke component="MCMS.component.app.subscription.Subscription"
                method="getSubscription"
                returnvariable="getCheckSubscriptionRet">
                    <cfinvokeargument name="subEmail" value="#ARGUMENTS.subEmail#"/>
                    <cfinvokeargument name="subStatus" value="1,2,3"/>
            </cfinvoke>

            <cfif getCheckSubscriptionRet.recordcount NEQ 0>

                <cfset result.message = "The name #ARGUMENTS.subEmail# already exists, please enter a new email.">

            <cfelse>

                <cftransaction>

                    <cfquery datasource="#application.mcmsDSN#">

                    INSERT INTO tbl_subscription (subEmail,subPassword,subFName,subLName,subTelArea,subTelPrefix,subTelSuffix,subZipCode,subZipCodeExt,subStateProv,subCountry,subStatus) VALUES
                    (
                    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.subEmail#">,
                    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.subPassword#">,
                    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.subFName#">,
                    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.subLName#">,
                    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.subTelArea#">,
                    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.subTelPrefix#">,
                    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.subTelSuffix#">,
                    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.subZipCode#">,
                    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.subZipCodeExt#">,
                    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.subStateProv#">,
                    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.subCountry#">,
                    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.subStatus#">
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
  
    <cffunction name="updateSubscription" access="public" returntype="struct">

        <cfargument name="ID" type="numeric" required="yes">
        <cfargument name="subEmail" type="string" required="yes">
        <cfargument name="subPassword" type="string" required="yes" default="password">
        <cfargument name="subFName" type="string" required="yes">
        <cfargument name="subLName" type="string" required="yes">
        <cfargument name="subTelArea" type="string" required="yes">
        <cfargument name="subTelPrefix" type="string" required="yes">
        <cfargument name="subTelSuffix" type="string" required="yes">
        <cfargument name="subZipCode" type="string" required="yes">
        <cfargument name="subZipCodeExt" type="string" required="yes">
        <cfargument name="subStateProv" type="string" required="yes">
        <cfargument name="subCountry" type="string" required="yes">
        <cfargument name="subStatus" type="numeric" required="yes">

        <cfset result.message = "You have successfully updated the record.">

        <cftry>
            <!---Check for a duplicate record.--->
            <cfinvoke component="MCMS.component.app.subscription.Subscription"
                method="getSubscription"
                returnvariable="getCheckSubscriptionRet">
                    <cfinvokeargument name="excludeID" value="#ARGUMENTS.ID#"/>
                    <cfinvokeargument name="subEmail" value="#ARGUMENTS.subEmail#"/>
                    <cfinvokeargument name="subStatus" value="1,2,3"/>
            </cfinvoke>

            <cfif getCheckSubscriptionRet.recordcount NEQ 0>
                
                <cfset result.message = "The name #ARGUMENTS.subEmail# already exists, please enter a email.">

            <cfelse>

                <cftransaction>
                    
                    <cfquery datasource="#application.mcmsDSN#">

                        UPDATE tbl_subscription SET
                        subEmail = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.subEmail#">,
                        subPassword = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.subPassword#">,
                        subFName = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.subFName#">,
                        subLName = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.subLName#">,
                        subTelArea = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.subTelArea#">,
                        subTelPrefix = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.subTelPrefix#">,
                        subTelSuffix = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.subTelSuffix#">,
                        subZipCode = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.subZipCode#">,
                        subZipCodeExt = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.subZipCodeExt#">,
                        subStateProv = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.subStateProv#">,
                        subCountry = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.subCountry#">,
                        subStatus = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.subStatus#">
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

</cfcomponent>