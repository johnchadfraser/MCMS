<cfcomponent> 

    <cffunction name="getInstagramHashTag" access="public" returntype="any" output="yes">

        <cfargument name="apiURL" type="string" required="yes" default="https://www.instagram.com/explore/tags/">
        <cfargument name="hashTag" type="string" required="yes" default="">
        <cfargument name="params" type="string" required="yes" default="__a=1">
    
        <cfset result = ''>

        <!---Set query object here to avoid null result error.--->
        <cfset columnList = "id,hashTag,userID,fullName,userName,timestampValue,imgProfile,imgThumbnail,imgOriginal,isVideo">
        <cfset columnType = "bigint,varchar,bigint,varchar,varchar,varchar,varchar,varchar,varchar,varchar">

        <!---Create the query object.--->
        <cfset myQuery = QueryNew(columnList, columnType)>

        <cftry>

            <!---Create any objects needed.--->
            <cfset objInstagram = CreateObject("component", application.mcmsComponentPath & '/social/instagram/Instagram')>

            <!---Construct the apiURL.--->
            <cfset this.apiURLString = arguments.apiURL & arguments.hashTag & '/?' & arguments.params>

            <!---Get the data via api.--->
            <cfhttp url="#this.apiURLString#" method="get" result="igHashTag">

                <cfhttpparam type="header" name="Content-Type"  value="application/json"/>

            </cfhttp>

            <cfset data = igHashTag.filecontent>

            <!---Deserialize the json.--->
            <cfset data = DeserializeJSON(data, false)> 
            
            <cfset data = data.graphql.hashtag.edge_hashtag_to_media>

            <cfset recordcount = data.count>

            <cfif recordcount NEQ 0>

                <cfset data = data.edges>

                <cfset QueryAddRow(myQuery, recordcount)>
                
                <cfloop index="i" from="1" to="#recordcount#">

                    <!---Convert timestamp to locale.--->
                    <cfset timeData = dateAdd("s", data[i].node.taken_at_timestamp, createDateTime(1970, 1, 1, 0, 0, 0))>
                    <cfset timeData = dateAdd("h", '-7', timeData)>
                    <cfset timeData = CreateODBCDateTime(timeData)>

                    <!---Create isVideo value to filter records.--->
                    <cfset isVideo = data[i].node.is_video>

                    <!---Only pull images not video and recent posts based on timestamp.--->
                    <cfif isVideo EQ 'NO' AND timeData LTE CreateODBCDateTime(Now())>  

                        <cfset QuerySetCell(myQuery, "id", data[i].node.id, i)>
                        <cfset QuerySetCell(myQuery, "hashTag", '##' & arguments.hashTag, i)>
                        <cfset QuerySetCell(myQuery, "userID", data[i].node.owner.id, i)>
                        <cfset QuerySetCell(myQuery, "timestampValue", timeData, i)>
                        <cfset QuerySetCell(myQuery, "imgThumbnail", data[i].node.thumbnail_resources[1].src, i)>
                        <cfset QuerySetCell(myQuery, "imgOriginal", data[i].node.thumbnail_resources[5].src, i)>
                        <cfset QuerySetCell(myQuery, "isVideo", isVideo, i)>

                        <!---Add user info.--->
                        <cfset getInstagramUserInfoRet = objInstagram.getInstagramUserInfo(userID=data[i].node.owner.id)>

                        <cfset QuerySetCell(myQuery, "fullName", getInstagramUserInfoRet.fullName, i)>
                        <cfset QuerySetCell(myQuery, "userName", getInstagramUserInfoRet.userName, i)>
                        <cfset QuerySetCell(myQuery, "imgProfile", getInstagramUserInfoRet.imgProfile, i)>

                    </cfif>

                </cfloop>

                <!---Query the results to return not NULL data.--->

                <cfquery name="myQuery" dbtype="query">

                    SELECT * FROM myQuery
                    WHERE id IS NOT NULL

                </cfquery>

                <cfset result = myQuery>

            </cfif>

            <!---Catch any errors.--->
            <cfcatch type="any">
                
				<cflog file="getInstagramHashTagError" text="#cfcatch.message# #cfcatch.detail#">

            </cfcatch>

        </cftry>
            
        <cfreturn result>
    
    </cffunction>

    <cffunction name="getInstagramUserInfo" access="public" returntype="any" output="yes">

        <cfargument name="apiURL" type="string" required="yes" default="https://i.instagram.com/api/v1/users/">
        <cfargument name="userID" type="string" required="yes" default="0">
        <cfargument name="pathExt" type="string" required="yes" default="info">
        <cfargument name="params" type="string" required="yes" default="">
    
        <cfset result = ''>

        <cftry>

            <!---Construct the apiURL.--->
            <cfset this.apiURLString = arguments.apiURL & arguments.userID & '/' & arguments.pathExt & '/' & arguments.params>

            <!---Get the data via api.--->
            <cfhttp url="#this.apiURLString#" method="get" result="igUserInfo">

                <cfhttpparam type="header" name="Content-Type"  value="application/json"/>

            </cfhttp>

            <cfset data = igUserInfo.filecontent>

            <cfset data = DeserializeJSON(data, false)> 

            <cfset data = data.user>

            <cfset columnList = "id,userName,fullName,imgProfile">
            <cfset columnType = "bigint,varchar,varchar,varchar">

            <!---Create the query object.--->
            <cfset myQuery = QueryNew(columnList, columnType)>

            <cfset QueryAddRow(myQuery, 1)>

            <cfset QuerySetCell(myQuery, "id", data.pk)>
            <cfset QuerySetCell(myQuery, "userName", data.username)>
            <cfset QuerySetCell(myQuery, "fullName", data.full_name)>
            <cfset QuerySetCell(myQuery, "imgProfile", data.profile_pic_url)>

            <cfset result = myQuery>

            <!---Catch any errors.--->
            <cfcatch type="any">
                
                <cflog file="getInstagramUserInfoError" text="#cfcatch.message# #cfcatch.detail#">

            </cfcatch>

        </cftry>
            
        <cfreturn result>
    
    </cffunction>
    
</cfcomponent>