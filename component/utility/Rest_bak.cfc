<cfcomponent>

<cffunction name="getRestfulFormatResponse" access="public" returntype="any" output="false" hint="Format response data from a restful service.">
<cfargument name="restResponse" type="any" required="true" hint="Response of REST Service."/>
<cfargument name="restResponseFormat" type="string" required="true" default="XML" hint="Format of response."/>
<cfargument name="restResponseColumns" type="string" required="true" default="id" hint="List of columns to include."/>
<cfset var restQuery = '' />
<cfswitch expression="#ARGUMENTS.restResponseFormat#">
<cfcase value="XML">
<cfxml variable="result">
<cfoutput>#restResponse.FileContent#</cfoutput>
</cfxml>
<cfset result = result.xmlRoot.xmlChildren[1].xmlChildren>
<cfset resultLength = ArrayLen(result)>
<!--- Create a query object with data.---> 
<cfset restQuery = QueryNew(ARGUMENTS.restResponseColumns)>
<cfset temp = QueryAddRow(restQuery, resultLength)>
<cfloop index="i" from="1" to="#resultLength#">
<cfloop index="colName" list="#ARGUMENTS.restResponseColumns#">
<cfset colValue = Evaluate('result[#i#].#colName#.XmlText')>
<cfset temp = QuerySetCell(restQuery, colName, colValue, i)>
</cfloop>
</cfloop>
</cfcase>
<cfdefaultcase>
<!---None.--->
</cfdefaultcase>
</cfswitch>
<cfreturn restQuery /> 
</cffunction>

<cffunction name="getRestfulService" access="public" returntype="any" output="false" hint="Get data from a restful service.">
<cfargument name="restURL" type="string" required="true" hint="Host URL of REST Service."/>
<cfargument name="restURLPort" type="string" required="true" default="80" hint="Port of server for REST service."/>
<cfargument name="restPath" type="string" required="true" hint="Path of server for REST service."/>
<cfargument name="restMethod" type="string" required="true" hint="Path of server for REST service."/>
<cfargument name="restCharset" type="string" required="true" default="utf-8" hint="Charset of the REST Service"/>
<cfargument name="restHTTPMethod" type="string" required="true" default="get" hint="The HTTP method for the REST Service."/>
<cfargument name="restColumns" type="string" required="true" default="get" hint="List of columns for the response method for the REST Service."/>
<cfargument name="restParameters" type="string" required="true" default="atg-rest-output=xml,atg-rest-depth=2" hint="The control parameters for the REST Service."/>
<cfset var result = '' />
<cfhttp url="#ARGUMENTS.restURL#:#ARGUMENTS.restURLPort#/#ARGUMENTS.restPath#/#ARGUMENTS.restMethod#" charset="#ARGUMENTS.restCharset#" method="#ARGUMENTS.restHTTPMethod#" result="result">
<!---Loop parameters.--->
<cfloop index="i" list="#ARGUMENTS.restParameters#">
<cfset this.name = ListGetAt(i, 1, '=')>
<cfset this.value = ListGetAt(i, 2, '=')>
<cfhttpparam type="formfield" name="#this.name#" value="#this.value#"/>
</cfloop>
</cfhttp>
<!---Throw an error if the request fails.--->
<cfswitch expression="#result.responseHeader.status_code#">
<cfcase value="200">
<!--- Good response, do nothing. --->
</cfcase>
<cfcase value="503">
<cfthrow message="Your call to Web Services failed and returned an HTTP status of 503. That means: Service unavailable. An internal problem prevented us from returning data to you.">
</cfcase>
<cfcase value="403">
<cfthrow message="Your call to Web Services failed and returned an HTTP status  of 403. That means: Forbidden. You do not have permission to  access this resource, or are over your rate limit.">
</cfcase>
<cfcase value="400">
<cfthrow message="Your call to Web Services failed  and returned an HTTP status of 400.  That means: Bad request. The parameters passed to the service did not match as expected. The exact error is returned in the XML response.">
</cfcase>
<cfdefaultcase>
<cfthrow message="Your call to Web Services returned an unexpected HTTP status of: #cfhttp.responseHeader.status_code#">
</cfdefaultcase>
</cfswitch>
<!---Parse and format the response into a query format.--->
<cfinvoke 
component="MCMS.component.utility.Rest"
method="getRestfulFormatResponse"
returnvariable="result">
<cfinvokeargument name="restResponse" value="#result#"/>
<cfinvokeargument name="restResponseFormat" value="xml"/>
<cfinvokeargument name="restResponseColumns" value="#ARGUMENTS.restColumns#"/>
</cfinvoke>
<cfreturn result /> 
</cffunction>
</cfcomponent>