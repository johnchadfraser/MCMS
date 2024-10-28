<cfcomponent> 

    <cffunction name="getSocialTagSiteRel" access="public" returntype="query" hint="Get Social Tag Site Rel.">
        <cfargument name="keywords" type="string" required="yes" default="All">
        <cfargument name="siteNo" type="string" required="yes" default="100">
        <cfargument name="ID" type="numeric" required="yes" default="0">
        <cfargument name="excludeID" type="numeric" required="yes" default="0">
        <cfargument name="stID" type="string" required="yes" default="0">
        <cfargument name="stsrStatus" type="string" required="yes" default="1,3">
        <cfargument name="orderBy" type="string" required="yes" default="siteNo, sTag">

        <cfset var rsSocialTagSiteRel = "" >

        <cftry>

            <cfquery name="rsSocialTagSiteRel" datasource="#APPLICATION.mcmsDSN#">
            
                SELECT * FROM v_social_tag_site_rel WHERE 0=0

                <cfif ARGUMENTS.keywords NEQ 'All'>

                    <cfloop list="#ARGUMENTS.keywords#" delimiters=" " index="kw">

                        AND (UPPER(sTag) LIKE <cfqueryparam value="%#UCASE(kw)#%" cfsqltype="cf_sql_varchar"> 
                        OR UPPER(siteName) LIKE <cfqueryparam value="%#UCASE(kw)#%" cfsqltype="cf_sql_varchar"> 
                        OR UPPER(soctName) LIKE <cfqueryparam value="%#UCASE(kw)#%" cfsqltype="cf_sql_varchar">)

                    </cfloop>

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

                <cfif ARGUMENTS.stID NEQ 0>

                    AND stID IN (<cfqueryparam value="#ARGUMENTS.stID#" cfsqltype="cf_sql_integer">)

                </cfif>

                AND soctStatus IN (<cfqueryparam value="#ARGUMENTS.stsrStatus#" list="yes" cfsqltype="cf_sql_integer">)
                AND stagStatus IN (<cfqueryparam value="#ARGUMENTS.stsrStatus#" list="yes" cfsqltype="cf_sql_integer">)
                AND siteStatus IN (<cfqueryparam value="#ARGUMENTS.stsrStatus#" list="yes" cfsqltype="cf_sql_integer">)
                AND stsrStatus IN (<cfqueryparam value="#ARGUMENTS.stsrStatus#" list="yes" cfsqltype="cf_sql_integer">)
                ORDER BY #ARGUMENTS.orderBy#

            </cfquery>

            <!---Catch any errors.--->
            <cfcatch type="any">
                
                <cflog file="getSocialTagSiteRelError" text="#cfcatch.message# #cfcatch.detail#">

            </cfcatch>

        </cftry>

        <cfreturn rsSocialTagSiteRel>

    </cffunction>
    
</cfcomponent>