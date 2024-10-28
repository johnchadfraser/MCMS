<cfcomponent>
	<cffunction name="regexProfanity" access="public" returntype="string">
	<cfargument name="profanityString" type="string" required="yes">
	<cfset regexProfanity="">
	<cfset myList = application.regexProfanity>
	<cfloop list="#myList#" index="id">
	<cfset lowerList = LCASE(id) & "|">
	<cfset upperList = UCASE(id) & "|">
	<cfset idLength = LEN(id)>
	<cfset lenCount = 0>
	<cfloop index="lenID" from="1" to="#idLength#">
	<cfset lenCount = lenCount+1>
	<cfset lenExpLeft = Iif(IsDefined('lenExpLeft'), Evaluate(DE('lenExpLeft')), DE('')) & Replace(lowerList, LEFT(lowerList,lenCount), UCASE(LEFT(lowerList,lenCount)), 'ALL')>
	<cfset lenExpRight = Iif(IsDefined('lenExpRight'), Evaluate(DE('lenExpRight')), DE('')) & Replace(lowerList, RIGHT(lowerList,lenCount), UCASE(RIGHT(lowerList,lenCount)), 'ALL')>
	</cfloop>
	<cfset lenExp = lenExpLeft & lenExpRight>
	</cfloop>
	<cfset thisList = Iif(IsDefined('thisList'), Evaluate(DE('thisList')), DE('shit')) & "|" 
	& lenExp
	& "xxx"
	>
	<cfset correctWords = Replace(thisList, '||', '', 'ALL')>
	<cfset regexProfanity = REReplace(ARGUMENTS.profanityString, correctWords, '$%&*!', 'ALL')>
	<cfreturn regexProfanity>
	</cffunction>
	
	<cffunction name="regexQueryBuilder" access="public" returntype="string">
	<cfargument name="queryBuilderString" type="string" required="yes">
	<cfset regexQueryBuilder="">
	<cfset myList = application.queryBuilderRestricted>
	<cfloop list="#myList#" index="id">
	<cfset lowerList = LCASE(id) & "|">
	<cfset upperList = UCASE(id) & "|">
	<cfset idLength = LEN(id)>
	<cfset lenCount = 0>
	<cfloop index="lenID" from="1" to="#idLength#">
	<cfset lenCount = lenCount+1>
	<cfset lenExpLeft = Iif(IsDefined('lenExpLeft'), Evaluate(DE('lenExpLeft')), DE('')) & Replace(lowerList, LEFT(lowerList,lenCount), UCASE(LEFT(lowerList,lenCount)), 'ALL')>
	<cfset lenExpRight = Iif(IsDefined('lenExpRight'), Evaluate(DE('lenExpRight')), DE('')) & Replace(lowerList, RIGHT(lowerList,lenCount), UCASE(RIGHT(lowerList,lenCount)), 'ALL')>
	</cfloop>
	<cfset lenExp = lenExpLeft & lenExpRight>
	</cfloop>
	<cfset thisList = Iif(IsDefined('thisList'), Evaluate(DE('thisList')), DE('tbl_user')) & "|" 
	& lenExp
	& "xxx"
	>
	<cfset correctWords = Replace(thisList, '||', '', 'ALL')>
	<cfset regexQueryBuilder = REReplace(ARGUMENTS.queryBuilderString, correctWords, '$%&*!', 'ALL')>
	<cfreturn regexQueryBuilder>
	</cffunction>
</cfcomponent>