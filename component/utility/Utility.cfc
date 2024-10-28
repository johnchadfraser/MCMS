<cfcomponent>
  <cffunction name="getRandomID" access="public" returntype="string">
  <cfargument name="list" type="string" required="yes" default="0">
  <cfif ListLen(ARGUMENTS.list) LTE 1>
  <cfset randomID = ARGUMENTS.list>
  <cfelse>
  <cfset listID = RandRange(1, ListLen(ARGUMENTS.list))>
  <cfset randomID = ListGetAt(ARGUMENTS.list, listID, ',')>
  </cfif>
  <cfreturn randomID>
  </cffunction>
  
  <cffunction name="getMaxValueSQL" access="public" returntype="string" output="yes" hint="Get max value of table ID for SQL. 0 is an error.">
  <cfargument name="tableName" type="string" required="yes" default="DUAL">
  <cfset var rsMaxValueSQL = "" >
  <cftry>
  <cfset isSQL = 'SELECT MAX(ID) AS ID FROM ' & ARGUMENTS.tableName>
  <cfquery name="rsMaxValueSQL" datasource="#application.mcmsDSN#">
  #PreserveSingleQuotes(isSQL)#
  </cfquery>
  <cfreturn rsMaxValueSQL.ID>
  <cfcatch type="any">
  <!---Check for zero for error.--->
  <cfreturn 0>
  </cfcatch>
  </cftry>
  </cffunction>
  
  <cffunction name="getIPAddressPadding" access="public" returntype="string" output="no" hint="Pads the IP addrress.">
  <cfargument name="ipAddress" type="string" required="yes" default="#CGI.REMOTE_ADDR#">
  <cfset var result = ''>
  <cfset ipx = ''>
  <cfloop index="ip" list="#ARGUMENTS.ipAddress#" delimiters=".">
  <cfif LEN(ip) EQ 1>
  <cfset ipx = ipx & '00#ip#.'>
  <cfelseif LEN(ip) EQ 2>
  <cfset ipx = ipx & '0#ip#.'>
  <cfelse>
  <cfset ipx = ipx & ip & '.'>
  </cfif>
  <cfset result = LEFT(ipx, 15)>
  </cfloop>
  <cfreturn result>
  </cffunction> 
</cfcomponent>