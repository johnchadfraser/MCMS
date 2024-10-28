<cfcomponent>

    <cffunction name="setBanner" access="public" returntype="string" output="yes" hint="Displays a Banner called via a script.">

        <cfargument name="mcmsBannerID" type="numeric" required="yes" default="0">

        <cfset var banner = "" >

        <cftry>
        
            <cfsilent>

                <cfinvoke component="MCMS.component.app.banner.Banner"
                    method="getBanner"
                    returnvariable="getBannerRet">
                        <cfinvokeargument name="ID" value="#ARGUMENTS.mcmsBannerID#"/>
                        <cfinvokeargument name="bDateRel" value="#Now()#"/>
                        <cfinvokeargument name="bDateExp" value="#Now()#"/>
                        <cfinvokeargument name="bStatus" value="1"/>
                </cfinvoke>

            </cfsilent>

            <cfsavecontent variable="banner">

                <cfprocessingdirective suppresswhitespace="yes">

                    <!---Deliver in javascript format.--->
                    <cfcontent type="application/x-javascript; charset=utf-8">

                    <!---Block any debug info.--->
                    <cfsetting showdebugoutput="no">

                    <cfif getBannerRet.recordcount NEQ 0>

                        <cfset bannerQueryString = "?mcmsBannerID=#ARGUMENTS.mcmsBannerID#">
                    
                        <cfoutput query="getBannerRet">
                        
                            <!---Check to see if the file exists.--->
                            <cfhttp result="checkFileExists" 
                                method="GET" 
                                charset="utf-8" 
                                url="#application.mcmsCDNURL#/#application.mcmsRepositoryDir#/image/#imgtPath#/#URLEncodedFormat(imgFile)#">
                            </cfhttp>

                            <!---If the file exists then show it.--->
                            <cfif checkFileExists.statusCode EQ "200 OK">

                                document.writeln('<a href="#bURL#" target="#bTarget#"><img src="#application.mcmsCDNURL#/#application.mcmsRepositoryDir#/image/#imgtPath#/#imgFile#"alt="#bName#" width="#btWidth#" height="#btHeight#" vspace="5" hspace="5" border="#bBorder#" name="#bName#" style="border-color:##000000;" /></a>');

                            </cfif>

                        </cfoutput>

                    </cfif>

                </cfprocessingdirective>

            </cfsavecontent>

            <!---Catch any errors.--->
            <cfcatch type="any">

                <cfset banner = StructNew()>
                <cfset banner.message = "There was an error with the setBanner function.">
            
            </cfcatch>

        </cftry>

        <cfreturn banner>

    </cffunction>
     
    <cffunction name="getBanner" access="public" returntype="query" hint="Get Banner data.">
        
        <cfargument name="keywords" type="string" required="yes" default="All">
        <cfargument name="ID" type="numeric" required="yes" default="0">
        <cfargument name="excludeID" type="numeric" required="yes" default="0">
        <cfargument name="bName" type="string" required="yes" default="">
        <cfargument name="bDateRel" type="string" required="yes" default="">
        <cfargument name="bDateExp" type="string" required="yes" default="">
        <cfargument name="btID" type="string" required="yes" default="0">
        <cfargument name="btStatus" type="string" required="no" default="1">
        <cfargument name="bStatus" type="string" required="yes" default="1,3">
        <cfargument name="orderBy" type="string" required="yes" default="bName">
        
        <cfset var rsBanner = "" >

        <cftry>

            <cfquery name="rsBanner" datasource="mcms_dev">

                SELECT * FROM v_banner WHERE 0=0

                <cfif ARGUMENTS.ID NEQ 0>

                    AND ID = <cfqueryparam value="#ARGUMENTS.ID#" cfsqltype="cf_sql_integer">

                </cfif>
                <cfif ARGUMENTS.excludeID NEQ 0>

                    AND ID <> <cfqueryparam value="#ARGUMENTS.excludeID#" cfsqltype="cf_sql_integer">

                </cfif>

                <cfif ARGUMENTS.keywords NEQ 'All'>
                    
                    AND (UPPER(bName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(bDescription) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">)
                
                </cfif>

                <cfif ARGUMENTS.bName NEQ "">

                    AND UPPER(bName) = <cfqueryparam value="#UCASE(ARGUMENTS.bName)#" cfsqltype="cf_sql_varchar">
                
                </cfif>

                <cfif ARGUMENTS.bDateRel NEQ "">

                    AND bDateRel <= <cfqueryparam value="#ARGUMENTS.bDateRel#" cfsqltype="cf_sql_date">
                
                </cfif>

                <cfif ARGUMENTS.bDateExp NEQ "">

                    AND bDateExp >= <cfqueryparam value="#ARGUMENTS.bDateExp#" cfsqltype="cf_sql_date">
                
                </cfif>

                <cfif ARGUMENTS.btID NEQ 0>

                    AND btID IN (<cfqueryparam value="#ARGUMENTS.btID#" list="yes" cfsqltype="cf_sql_integer">)
                
                </cfif>

                AND btStatus IN (<cfqueryparam value="#ARGUMENTS.btStatus#" list="yes" cfsqltype="cf_sql_integer">)
                AND bStatus IN (<cfqueryparam value="#ARGUMENTS.bStatus#" list="yes" cfsqltype="cf_sql_integer">)
                ORDER BY #ARGUMENTS.orderBy#

            </cfquery>

            <!---Catch any errors.--->
            <cfcatch type="any">

                <cfset rsBanner = StructNew()>
                <cfset rsBanner.message = "There was an error with the query.">
            
            </cfcatch>

        </cftry>

        <cfreturn rsBanner>

    </cffunction>
    
    <cffunction name="getBannerSiteRel" access="public" returntype="any" hint="Get Banner Site Relationship data.">

        <cfargument name="keywords" type="string" required="no" default="All">
        <cfargument name="ID" type="numeric" required="yes" default="0">
        <cfargument name="bID" type="numeric" required="yes" default="0">
        <cfargument name="btID" type="numeric" required="yes" default="0">
        <cfargument name="siteNo" type="string" required="yes" default="100">
        <cfargument name="imgtStatus" type="string" required="no" default="1">
        <cfargument name="btStatus" type="string" required="no" default="1">
        <cfargument name="bsrStatus" type="string" required="yes" default="1,3">
        <cfargument name="orderBy" type="string" required="yes" default="siteNo">

        <cfset var rsBannerSiteRel = "" >

        <cftry>

            <cfquery name="rsBannerSiteRel" datasource="#application.mcmsDSN#">

                SELECT * FROM v_banner_site_rel WHERE 0=0

                <cfif ARGUMENTS.keywords NEQ 'All'>

                    AND siteNo LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> 

                </cfif>

                <cfif ARGUMENTS.ID NEQ 0>

                    AND ID = <cfqueryparam value="#ARGUMENTS.ID#" cfsqltype="cf_sql_integer">

                </cfif>

                <cfif ARGUMENTS.bID NEQ 0>

                    AND bID = <cfqueryparam value="#ARGUMENTS.bID#" cfsqltype="cf_sql_integer">

                </cfif>

                <cfif ARGUMENTS.btID NEQ 0>

                    AND btID = <cfqueryparam value="#ARGUMENTS.btID#" cfsqltype="cf_sql_integer">

                </cfif>

                <cfif ARGUMENTS.siteNo NEQ 100>

                    AND siteNo IN (<cfqueryparam value="#ARGUMENTS.siteNo#" list="yes" cfsqltype="cf_sql_integer">)

                </cfif>

                AND imgtStatus IN (<cfqueryparam value="#ARGUMENTS.imgtStatus#" list="yes" cfsqltype="cf_sql_integer">)
                AND btStatus IN (<cfqueryparam value="#ARGUMENTS.btStatus#" list="yes" cfsqltype="cf_sql_integer">)
                AND bsrStatus IN (<cfqueryparam value="#ARGUMENTS.bsrStatus#" list="yes" cfsqltype="cf_sql_integer">)
                ORDER BY #ARGUMENTS.orderBy#

            </cfquery>

            <!---Catch any errors.--->
            <cfcatch type="any">

                <cfset rsBannerSiteRel = StructNew()>
                <cfset rsBannerSiteRel.message = "There was an error with the query.">
            
            </cfcatch>

        </cftry>

        <cfreturn rsBannerSiteRel>

    </cffunction>

    <cffunction name="insertBannerLog" access="public" returntype="struct" hint="Insert banner log/hit/analytics data.">
        
        <cfargument name="bID" type="numeric" required="yes">
        <cfargument name="blHost" type="string" required="yes">
        <cfargument name="blRemoteAddress" type="string" required="yes">
        <cfargument name="blReferrer" type="string" required="yes">
        <cfargument name="blPage" type="string" required="yes">
        
        <cftry>

            <cfinvoke component="MCMS.component.app.banner.Banner"
                method="getBanner"
                returnvariable="getBannerRet">
                    <cfinvokeargument name="ID" value="#ARGUMENTS.bID#"/>
                    <cfinvokeargument name="bDateRel" value="#Now()#"/>
                    <cfinvokeargument name="bDateExp" value="#Now()#"/>
                    <cfinvokeargument name="bStatus" value="1"/>
            </cfinvoke>

            <cfif getBannerRet.recordcount NEQ 0>

                <cftransaction>

                    <cfquery datasource="#application.mcmsDSN#">

                        INSERT INTO tbl_banner_log (bID, blHost, blRemoteAddress, blPage, blReferrer) VALUES (
                            <cfqueryparam value="#ARGUMENTS.bID#" cfsqltype="cf_sql_integer">,
                            <cfqueryparam value="#ARGUMENTS.blHost#" cfsqltype="cf_sql_varchar">,
                            <cfqueryparam value="#ARGUMENTS.blRemoteAddress#" cfsqltype="cf_sql_varchar">,
                            <cfqueryparam value="#ARGUMENTS.blPage#" cfsqltype="cf_sql_varchar">,
                            <cfqueryparam value="#ARGUMENTS.blReferrer#" cfsqltype="cf_sql_varchar">
                        )

                    </cfquery>

                </cftransaction>

                <cflocation url="#getBannerRet.bURL#" addtoken="no">

            </cfif>

            <cfcatch type="any">

                <cfset result.message = "There was an error inserting the banner log record.">
                <cflog file="taskLoggerError" text="#cfcatch.message# #cfcatch.detail#">

                <cflocation url="//#CGI.SERVER_NAME#" addtoken="no">

            </cfcatch>

        </cftry>

        <cfreturn result>

    </cffunction>
   
</cfcomponent>