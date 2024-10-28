<cfcomponent>
	<cffunction name="getTweet" access="public" returntype="query" >
		<cfargument name="userName" type="string" required="yes" default="">
        <cfargument name="userPassword" type="string" required="yes" default="">
        <cfargument name="screenName" type="string" required="yes" default="">
        <cfargument name="count" type="string" required="yes" default="">
		<cfset result="">
        <cfhttp method="get" url="https://api.twitter.com/1/statuses/user_timeline.json?include_entities=true&include_rts=true&screen_name=#ARGUMENTS.screenName#&count=#ARGUMENTS.count#" password="#ARGUMENTS.userPassword#" userName="#ARGUMENTS.userName#" charset="utf-8" result="result" />
        <cfset tweet = DeserializeJSON(result.FileContent.toString())>
        <cfset result = QueryNew("name, image, text", "varchar, varchar, varchar")>
        <cfloop index="i" from="1" to="#ARGUMENTS.count#">
        <cfset newRow = QueryAddRow(result, 1)>
        <cfset tmp = QuerySetCell(result, "name", tweet[i].user.name)> 
        <cfset tmp = QuerySetCell(result, "image", tweet[i].user.profile_image_url)>
        <cfset tmp = QuerySetCell(result, "text", tweet[i].text)> 
        </cfloop>
		<cfreturn result>
	</cffunction>
</cfcomponent>