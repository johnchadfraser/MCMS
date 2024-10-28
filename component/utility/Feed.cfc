<cfcomponent>

<cffunction name="getStockFeed" access="public" returntype="string" output="yes">
<cfargument name="apiURL" type="string" required="yes" default="https://finance.google.com/finance?q=NASDAQ:SPWH&output=json">
<cfargument name="apiType" type="string" required="yes" default="google">
<cfset result = ''>
<cfhttp url="#ARGUMENTS.apiURL#"/>
<!--- JSON data is sometimes distributed as a JavaScript function. The following REReplace functions strip the function wrapper. ---> 
<cfset sourceData=REReplace(cfhttp.FileContent, "^\s*[[:word:]]*\s*\(\s*","")> 
<cfset sourceData=REReplace(sourceData, "\s*\)\s*$", "")> 

<!--- Test to make sure you have JSON data. ---> 
<cfif IsJSON(sourceData)>
<cfset stockData=DeserializeJSON(sourceData, false)>
<cfset stockData=stockData> 
<cfset data = stockData[1]>

<cfloop from="1" to="#arrayLen(stockData)#" index="i">
<cfloop collection="#data#" item="key">
<cfif key EQ 'l'>
<cfset this.price = data[key]>
<cfelseif key EQ 't'>
<cfset this.stock = data[key]>
<cfelseif key EQ 'e'>
<cfset this.index = data[key]>
<cfelseif key EQ 'c'>
<cfset this.gain = data[key]>
<cfelseif key EQ 'cp'>
<cfset this.gain_percentage = data[key]>
<cfelseif key EQ 'lt'>
<cfset this.datetime = data[key]>
</cfif>
</cfloop> 
</cfloop>

<cfsavecontent variable="result">
<div>
<h1>#this.stock#</h1>
<h2>
#this.price# <span style="font-size:9px;">USD</span>
</h2>
<h3>
<cfif this.gain CONTAINS '-'>
<span style="color:##a94442;">
<span class="glyphicon glyphicon-arrow-down"></span>
#this.gain# (#this.gain_percentage#%)
</span>
<cfelse>
<span style="color:##3c763d;">
<span class="glyphicon glyphicon-arrow-up"></span>
#this.gain# (#this.gain_percentage#%)
</span>
</cfif>
</h3>
<h5>#this.index#: #this.datetime#</h5>
</div>
</cfsavecontent>
<cfelse>
<cfsavecontent variable="result">

</cfsavecontent>
</cfif>     
<cfreturn result>
</cffunction>

<cffunction name="setStock" access="public" returntype="string" output="yes" hint="Displays stock feed.">
<cfset var result = "" >
<cfsilent>
<cfinvoke 
component="root.MCMS.component.utility.Feed"
method="getStockFeed"
returnvariable="getStockFeedRet">
</cfinvoke>
</cfsilent>
<cfsavecontent variable="result">
<cfprocessingdirective suppresswhitespace="yes">
#getStockFeedRet#
</cfprocessingdirective>
</cfsavecontent>
<cfreturn result>
</cffunction>

<cffunction name="setStockSocket" access="remote" returntype="string" output="yes" hint="Displays stock feed.">
<cfset var result = "" >
<script src="/scripts/socket.js" type="text/javascript"></script>
<cfwebsocket name="webSocketObj" onmessage="msgHandler" onerror="errorHandler" onopen="openHandler" subscribeto="stock" />
<cfsavecontent variable="result">
<div id="stockSocket"></div> 
</cfsavecontent>
<cfreturn result>
</cffunction>

</cfcomponent>