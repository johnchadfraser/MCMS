<cfcomponent>  

    <cffunction name="getBrag" access="public" returntype="any" output="yes" hint="Get Brag data.">

        <cfargument name="siteNo" type="numeric" required="yes" default="100">

        <cfset result = "">

        <cftry>

            <cfscript>
                
                objInstagram = CreateObject("component", application.mcmsComponentPath & '/social/instagram/Instagram');
                objSocial = CreateObject("component", application.mcmsComponentPath & '/social/Social');

                //Get the hashtag for this site.--->
                bragHashTag = objSocial.getSocialTagSiteRel(siteNo=arguments.siteNo,stID=4);

                result = objInstagram.getInstagramHashTag(hashTag=Replace(bragHashTag.sTag, '##', '', 'All'));

            </cfscript>

            <!---Catch any errors.--->
            <cfcatch type="any">
                
                <cflog file="getBragError" text="#cfcatch.message# #cfcatch.detail#">

            </cfcatch>

        </cftry>

        <cfreturn result/>

    </cffunction>

    <cffunction name="setBragWidget" access="public" returntype="string" output="yes" hint="Displays Brag Widget.">

        <cfargument name="siteNo" type="numeric" required="yes" default="100">

        <cfset result = "">
        <cfset widgetHTML = "">

        <cftry>

            <cfsavecontent variable="result">

                <cfprocessingdirective suppresswhitespace="yes">

                    <!---Deliver in javascript format.--->
                    <cfcontent type="application/x-javascript; charset=utf-8">

                    <cfsetting showdebugoutput="no">

                    <cfoutput>

                    /**
                     * Get HTML asynchronously
                     * @param  {String}   url      The URL to get HTML from
                     * @param  {Function} callback A callback funtion. Pass in "response" variable to use returned HTML.
                     */

                    var getHTML = function ( url, callback ) {

                        // Feature detection
                        if ( !window.XMLHttpRequest ) return;

                        // Create new request
                        var xhr = new XMLHttpRequest();

                        // Setup callback
                        xhr.onload = function() {
                            if ( callback && typeof( callback ) === 'function' ) {
                                callback( this.responseXML );
                            }
                        }

                        // Get the HTML
                        xhr.open( 'GET', url );
                        xhr.responseType = 'document';
                        xhr.send();

                    };

                    getHTML( '#application.mcmsCDNURL#/widget/brag/view/widget.cfm?siteNo=#arguments.siteNo#', function (response) {
                        document.documentElement.innerHTML = response.documentElement.innerHTML;
                    });

                    </cfoutput>

                </cfprocessingdirective>

            </cfsavecontent>

            <!---Catch any errors.--->
            <cfcatch type="any">
                    
                <cflog file="setBragWidgetError" text="#cfcatch.message# #cfcatch.detail#">

            </cfcatch>

        </cftry>

        <cfreturn result>

        </cffunction>
    
</cfcomponent>