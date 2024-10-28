<cfcomponent>
    <cffunction name="setSearchResult" access="public" returntype="any" hint="Set Search Result data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="criteria" type="string" required="yes" default="*">
    <cfargument name="collection" type="string" required="yes" default="">
    <cfargument name="collectionType" type="string" required="yes" default="simple">
    <cfargument name="resultPath" type="string" required="yes" default="/search" hint="Path from root to result page.">
    <cfargument name="maxRows" type="numeric" required="yes" default="#request.rowCount#">
    <cfset var result = "">
    <cftry>
    <cfsavecontent variable="result">
    <cfif ARGUMENTS.keywords NEQ 'All'>
    <cfset ARGUMENTS.keywords = ARGUMENTS.keywords & ARGUMENTS.criteria>
    </cfif>
    <!--- Verify if Solor is up, and if so does it have any collections?--->
    <cfcollection name="getCollectionRet" action="list" />
	<cfif getCollectionRet.recordcount EQ 0 OR ARGUMENTS.collection EQ ''>
    <p>
    <span id="message">Search is down or the "<u><cfoutput>#ARGUMENTS.collection#</cfoutput></u>" collection has not been setup on this server!</span>
    </p>
    <cfelse> 
    <!---Query form.--->
    <cfinclude template="/search/view/inc_query.cfm">
    <!---Clean up the keywords.--->
    <cfset this.keywords = LCASE(TRIM(ARGUMENTS.keywords))>
	<cfsearch name="getSearchRet" collection="#ARGUMENTS.collection#" criteria="CF_CUSTOM2 <SUBSTRING> #Replace(this.keywords, '*', '', 'ALL')#" suggestions="always" status="info" maxrows="#ARGUMENTS.maxRows#">
    <cfif IsDefined('info.SuggestedQuery')>
    <cfif info.SuggestedQuery NEQ ''>
    <cfoutput>
    <br><br>
    <p>
    <span id="message">Did you mean: </span><a href="#ARGUMENTS.resultPath#/?keywords=#info.SuggestedQuery#" id="searchSuggestLink"><u>#info.SuggestedQuery#?</u></a>
    </p>
    </cfoutput>
    </cfif>
    </cfif>
    <cfif ARGUMENTS.keywords NEQ 'All' AND ARGUMENTS.keywords NEQ ''>
    <cfset loopcount = 0>
    <cfoutput query="getSearchRet">
    <cfset loopcount = loopcount+1>
    <br><br>
    <p>
    <a href="#custom3#" id="searchTitle" style="text-decoration:underline;">#LEFT(custom1, 64)#<cfif LEN(custom1) GT 64>...</cfif></a>
    <br />
    <a href="#custom3#" id="searchLink">#custom3#<img id="search" src="/#application.mcmsDir#/assets/icon/search.gif" border="0" hspace="5" vspace="3" align="absmiddle"></a>- #Round(size/10)#kb
    <!---Display rank as star.--->
    <cfswitch expression="#Mid(NumberFormat(score, '.99'), 3, 1)#">
    <cfcase value="8,9">
    <img title="5 Stars" id="starFiveIcon" src="/#application.mcmsDir#/assets/icon/rating_star_five.gif" border="0" hspace="5" vspace="3" align="absmiddle">
    </cfcase>
    <cfcase value="5,6,7">
    <img title="4 Stars" id="starFourIcon" src="/#application.mcmsDir#/assets/icon/rating_star_four.gif" border="0" hspace="5" vspace="3" align="absmiddle">
    </cfcase>
    <cfcase value="3,4">
    <img title="3 Stars" id="starThreeIcon" src="/#application.mcmsDir#/assets/icon/rating_star_three.gif" border="0" hspace="5" vspace="3" align="absmiddle">
    </cfcase>
    <cfcase value="2">
    <img title="2 Stars" id="starTwoIcon" src="/#application.mcmsDir#/assets/icon/rating_star_two.gif" border="0" hspace="5" vspace="3" align="absmiddle">
    </cfcase> 
    <cfcase value="1">
    <img title="1 Star" id="starOneIcon" src="/#application.mcmsDir#/assets/icon/rating_star_one.gif" border="0" hspace="5" vspace="3" align="absmiddle">
    </cfcase>       
    <cfdefaultcase>
    <img title="Star None" id="starNoneIcon" src="/#application.mcmsDir#/assets/icon/rating_star_none.gif" border="0" hspace="5" vspace="3" align="absmiddle">
    </cfdefaultcase>
    </cfswitch>
    <br>
    <cfif custom2 EQ ''>
    &nbsp;&nbsp;No summary available.
    <cfelse>
    <cfloop list="#ARGUMENTS.keywords#" index="buzzWord">
	<!--- Replace occurrences of the current buzz word with all lowercase letters --->
	<cfset this.custom2 = Replace(custom2, Replace(buzzWord, '*', '', 'ALL'), '<b>#buzzWord#</b>', 'All')>
	<!--- Replace occurrences of the current buzz word where the word has its first letter capitalized. --->
	<cfset cappedBuzzWord = UCASE(LEFT(Replace(buzzWord, '*', '', 'ALL'), 1 ) ) & RIGHT(Replace(buzzWord, '*', '', 'ALL'), LEN(Replace(buzzWord, '*', '', 'ALL'))-1)>
	<cfset this.custom2 = Replace(this.custom2, Replace(cappedBuzzWord, '*', '', 'ALL'), '<b>#cappedBuzzWord#</b>', 'All' )>
	</cfloop>
    #LEFT(Replace(this.custom2, '*', '', 'ALL'), 128)#<cfif LEN(this.custom2) GT 128>...</cfif><br />
    </cfif>
    </p>
    </cfoutput>
    </cfif>
    <cfif loopcount EQ 0>
    <br><br>
    <p>
    <span id="message">There were no results for your search, please try again.</span>
    </p>
    </cfif>
    </cfif>
    </cfsavecontent>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset result = '<span id="message">Search is down or the "<u>#ARGUMENTS.collection#</u>" collection has not been setup on this server!</span>'>
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>   
</cfcomponent>