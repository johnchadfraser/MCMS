<cfcomponent>
    <cffunction name="setCookie" access="public" returntype="any" hint="Sets a cookie.">
    <cfargument name="name" type="string" required="yes" default="id" hint="Name of cookie structure.">
    <cfargument name="domain" type="string" required="yes" default="#CGI.SERVER_NAME#" hint="Use this to set cookie values for other servers.">
    <cfargument name="expires" type="string" required="yes" default="never" hint="Now, date value (mm/dd/yy), or never.">
    <cfargument name="path" type="string" required="yes" default="/" hint="Path used for a specific cookie.">
    <cfargument name="secure" type="string" required="yes" default="no" hint="Yes or no."> 
    <cfargument name="valueList" type="string" required="yes" default="" hint="A list fo key/value pairs for cookie ie: firstName,Bob|lastName,Smith.">
    <cftry>
    <cfcookie name="cookieid" value="#ARGUMENTS.name#" domain="#ARGUMENTS.domain#" path="#ARGUMENTS.path#" secure="#ARGUMENTS.secure#" expires="#ARGUMENTS.expires#">
    <!---Parse the valueList to create cookie values.--->
    <cfloop index="i" list="#ARGUMENTS.valueList#" delimiters="|">
    <cfset cookiename = cookie.cookieid & '.' & ListFirst(i, ',')>
    <cfset cookievalue = ListLast(i, ',')>
    <cfif StructKeyExists(cookie, cookiename)>
    <cfset StructUpdate(cookie, cookiename, cookievalue)>
    <cfelse>
    <cfset StructInsert(cookie, cookiename, cookievalue)>
    </cfif>
    </cfloop>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfdump var="#CFCATCH#">
    </cfcatch>
    </cftry>
    </cffunction>
    
    <cffunction name="getCookie" access="public" returntype="any" hint="Gets cookie data.">
    <cfargument name="name" type="string" required="yes" default="id" hint="Name of cookie structure.">
    <cfargument name="domain" type="string" required="yes" default="#CGI.SERVER_NAME#" hint="Use this to set cookie values for other servers.">
    <cfargument name="path" type="string" required="yes" default="/" hint="Path used for a specific cookie.">
    <cfargument name="secure" type="string" required="yes" default="no" hint="Yes or no."> 
    <cfset result = QueryNew('rowid,name,value', 'varchar,varchar,varchar')>
    <cfset rowid = 0>
    <cfset cookieList = StructKeyList(cookie, '||')>
    <cfset cookieListLen = ListLen(cookieList, '||')>
    <cftry>
    <cfloop index="i" list="#cookieList#" delimiters="||">
    <cfset rowid = rowid+1>
    <cfset temp = QueryAddRow(result)>
    <cfset temp = QuerySetCell(result, 'rowid', rowid, rowid)>
	<cfset temp = QuerySetCell(result, 'name', i, rowid)>
    <cfset temp = QuerySetCell(result, 'value', Evaluate(i), rowid)>
    <cfif rowID EQ cookieListLen>
    <cfbreak>
    </cfif>
    </cfloop>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfdump var="#CFCATCH#">
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>  
</cfcomponent>