<cfcomponent>
	<cffunction name="getImage" access="public" returntype="query" hint="Get Image data.">
    <cfargument name="keywords" type="string" required="no" default="All">
    <cfargument name="ID" type="numeric" required="yes" default="0">
    <cfargument name="userID" type="string" required="yes" default="0">
    <cfargument name="excludeID" type="string" required="yes" default="0">
    <cfargument name="imgName" type="string" required="yes" default="">
    <cfargument name="imgtID" type="string" required="yes" default="0">
    <cfargument name="netID" type="string" required="yes" default="#application.networkID#">
    <cfargument name="imgtStatus" type="string" required="no" default="1">
    <cfargument name="imgStatus" type="string" required="yes" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="imgName">
	<cfset var rsImage = "" >
    <cftry>
	<cfquery name="rsImage" datasource="#application.mcmsDSN#">
	SELECT * FROM v_image WHERE 0=0
	<cfif ARGUMENTS.keywords NEQ 'All'>
	AND UPPER(imgName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">
	</cfif>
	<cfif ARGUMENTS.ID NEQ 0>
	AND ID = <cfqueryparam value="#ARGUMENTS.ID#" cfsqltype="cf_sql_integer">
	</cfif>
  <cfif ARGUMENTS.userID NEQ 0>
	AND userID IN (<cfqueryparam value="#ARGUMENTS.userID#" list="yes" cfsqltype="cf_sql_integer">)
	</cfif>
    <cfif ARGUMENTS.excludeID NEQ 0>
	AND ID NOT IN (<cfqueryparam value="#ARGUMENTS.excludeID#" list="yes" cfsqltype="cf_sql_integer">)
	</cfif>
	<cfif ARGUMENTS.imgName NEQ "">
	AND imgName = <cfqueryparam value="#ARGUMENTS.imgName#" cfsqltype="cf_sql_varchar">
	</cfif>
	<cfif ARGUMENTS.imgtID NEQ 0>
	AND imgtID IN (<cfqueryparam value="#ARGUMENTS.imgtID#" list="yes" cfsqltype="cf_sql_integer">)
	</cfif>
    <cfif ARGUMENTS.netID NEQ 0>
    AND netID IN (<cfqueryparam value="#ARGUMENTS.netID#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
	AND imgtStatus IN (<cfqueryparam value="#ARGUMENTS.imgtStatus#" list="yes" cfsqltype="cf_sql_integer">)
    AND imgStatus IN (<cfqueryparam value="#ARGUMENTS.imgStatus#" list="yes" cfsqltype="cf_sql_integer">)
	ORDER BY #ARGUMENTS.orderBy#
	</cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsImage = StructNew()>
    <cfset rsImage.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
	<cfreturn rsImage>
	</cffunction>
    
    <cffunction name="getImageBind" access="remote" returntype="string" output="yes">
    <cfargument name="keywords" type="string" required="yes" default="">
    <cfargument name="imgtID" type="string" required="yes" default="0">
    <cfargument name="netID" type="string" required="yes" default="0">
    <cfargument name="imgtStatus" type="string" required="no" default="1">
    <cfargument name="imgStatus" type="string" required="yes" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="imgName">
    <cfset var rsBind = "" >
    <cfquery name="rsBind" datasource="#application.mcmsDSN#">
    SELECT imgName FROM v_image WHERE 0=0
    AND UPPER(imgName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">
    <cfif ARGUMENTS.imgtID NEQ 0>
	AND imgtID IN (<cfqueryparam value="#ARGUMENTS.imgtID#" list="yes" cfsqltype="cf_sql_integer">)
	</cfif>
    <cfif ARGUMENTS.netID NEQ 0>
    AND netID IN (<cfqueryparam value="#ARGUMENTS.netID#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    AND imgStatus IN (<cfqueryparam value="#ARGUMENTS.imgStatus#" list="yes" cfsqltype="cf_sql_tinyint">)
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <cfif rsBind.recordcount NEQ 0>
    <cfset IDList = ValueList(rsBind.imgName, ',') & ",none">
    <cfelse>
    <cfset IDList = ''>
    </cfif>
    <cfreturn IDList>
    </cffunction>
    
    <cffunction name="getImageType" access="public" returntype="query" hint="Get Image Type data.">
    <cfargument name="keywords" type="string" required="no" default="All">
    <cfargument name="ID" type="string" required="yes" default="0">
    <cfargument name="excludeID" type="numeric" required="yes" default="0">
    <cfargument name="imgtName" type="string" required="yes" default="">
    <cfargument name="imgtStatus" type="string" required="yes" default="1,3">
    <cfargument name="orderBy" type="string" required="yes" default="imgtName">
	<cfset var rsImageType = "" >
    <cftry>
	<cfquery name="rsImageType" datasource="#application.mcmsDSN#">
	SELECT * FROM tbl_image_type WHERE 0=0
	<cfif ARGUMENTS.keywords NEQ 'All'>
	AND UPPER(imgtName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">
	</cfif>
	<cfif ARGUMENTS.ID NEQ 0>
	AND ID IN (<cfqueryparam value="#ARGUMENTS.ID#" list="yes" cfsqltype="cf_sql_integer">)
	</cfif>
    <cfif ARGUMENTS.excludeID NEQ 0>
	AND ID <> <cfqueryparam value="#ARGUMENTS.excludeID#" cfsqltype="cf_sql_integer">
	</cfif>
	<cfif ARGUMENTS.imgtName NEQ "">
	AND imgtName = <cfqueryparam value="#ARGUMENTS.imgtName#" cfsqltype="cf_sql_varchar">
	</cfif>
	AND imgtStatus IN (<cfqueryparam value="#ARGUMENTS.imgtStatus#" list="yes" cfsqltype="cf_sql_integer">)
	ORDER BY #ARGUMENTS.orderBy#
	</cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsImageType = StructNew()>
    <cfset rsImageType.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
	<cfreturn rsImageType>
	</cffunction>
	
	<cffunction name="getImageReport" access="public" returntype="query" hint="Get Image Report data.">
    <cfargument name="keywords" type="string" required="no" default="All">
    <cfargument name="orderBy" type="string" required="yes" default="imgName, imgtID">
	<cfset var rsImageReport = "" >
    <cftry>
	<cfquery name="rsImageReport" datasource="#application.mcmsDSN#">
	SELECT imgName AS Name, imgFile AS Image, imgtName AS Type, userFName AS FirstName, userLName AS LastName, sName AS Status FROM v_image 
	WHERE 0=0
	<cfif ARGUMENTS.keywords NEQ 'All'>
	AND UPPER(imgName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">
	</cfif>
	</cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsImageReport = StructNew()>
    <cfset rsImageReport.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
	<cfreturn rsImageReport>
	</cffunction>
    
    <cffunction name="getImageTypeReport" access="public" returntype="query" hint="Get Image Type Report data.">
    <cfargument name="keywords" type="string" required="no" default="All">
    <cfargument name="orderBy" type="string" required="yes" default="imgtName">
	<cfset var rsImageTypeReport = "" >
    <cftry>
	<cfquery name="rsImageTypeReport" datasource="#application.mcmsDSN#">
	SELECT imgtName AS Name, imgtPath AS Path, imgtWidth AS Width, imgtWidthLarge AS Large, imgtWidthThumb AS Thumb, imgtWidthAlt AS Alt, imgtStatus AS Status FROM tbl_image_type 
	WHERE 0=0
	<cfif ARGUMENTS.keywords NEQ 'All'>
	AND UPPER(imgtName) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">
	</cfif>
	ORDER BY #ARGUMENTS.orderBy#
	</cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsImageTypeReport = StructNew()>
    <cfset rsImageTypeReport.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
	<cfreturn rsImageTypeReport>
	</cffunction>
    
    <cffunction name="insertImage" access="public" returntype="struct">
    <cfargument name="imgName" type="string" required="yes">
    <cfargument name="imgFile" type="string" required="yes">
    <cfargument name="imgtID" type="numeric" required="yes">
    <cfargument name="netID" type="numeric" required="yes">
    <cfargument name="imgStatus" type="numeric" required="yes">
    <!---Passed image count id.--->
    <cfargument name="imgCountID" type="numeric" required="yes">
    <!---Passed if image type is a banner.--->
    <cfargument name="btID" type="numeric" required="yes">
    <cfset result.message = "You have successfully inserted the record.">
    <cftry>
    <!---Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.app.image.Image"
    method="getImage"
    returnvariable="getCheckImageRet">
    <cfinvokeargument name="imgName" value="#ARGUMENTS.imgName#"/>
    <cfinvokeargument name="imgtStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckImageRet.recordcount NEQ 0>
    <cfset ARGUMENTS.imgName = ARGUMENTS.imgName & ARGUMENTS.imgCountID>
    </cfif>
    <!---Upload the file.--->
    <!---First get the imgtPath.--->
    <cfinvoke 
    component="MCMS.component.app.image.Image"
    method="getImageType"
    returnvariable="getImageTypePathRet">
    <cfinvokeargument name="ID" value="#ARGUMENTS.imgtID#"/>
    <cfinvokeargument name="imgtStatus" value="1,3"/>
    </cfinvoke>
    <!---Create width variables for resizing.--->
    <cfset this.imgtWidth = getImageTypePathRet.imgtWidth>
    <cfset this.imgtWidthLarge = getImageTypePathRet.imgtWidthLarge>
    <cfset this.imgtWidthThumb = getImageTypePathRet.imgtWidthThumb>
    <cfset this.imgtWidthAlt = getImageTypePathRet.imgtWidthAlt>
    <cfset this.imgtPath = getImageTypePathRet.imgtPath>
    <!---If the image is a banner image then gather the size from the banner type table.--->
    <cfif ARGUMENTS.imgtID EQ 8>
    <cfinvoke 
    component="MCMS.component.app.banner.Banner"
    method="getBannerType"
    returnvariable="getBannerTypeRet">
    <cfinvokeargument name="ID" value="#ARGUMENTS.btID#"/>
    <cfinvokeargument name="btStatus" value="1,3"/>
    </cfinvoke>
    <cfset this.imgtWidth = getBannerTypeRet.btWidth>
    <cfset this.btHeight = getBannerTypeRet.btHeight>
    </cfif>
    <!---Contruct the temp path for the image to be uploaded.--->
    <cfset this.imageTempPath = '#application.mcmsRepositoryDir#/image/temp'>
    <!---Contruct the path for the image to be resized and uploaded.--->
    <cfset this.imagePath = '#application.mcmsRepositoryDir#/image/#this.imgtPath#'>
	<!---Check to see the temp directory exists.--->
    <cfif NOT DirectoryExists(this.imageTempPath)>
    <cfdirectory action="create" directory="#this.imageTempPath#">
    </cfif>
    <!---Check to see the file directory exists and create variants of folders i.e.: thumb and alt.--->
    <cfif NOT DirectoryExists(this.imagePath)>
    <cfdirectory action="create" directory="#this.imagePath#">
    </cfif>
    <cfif NOT DirectoryExists(this.imagePath & '/large')>
    <cfdirectory action="create" directory="#this.imagePath#/large">
    </cfif>
    <cfif NOT DirectoryExists(this.imagePath & '/thumb')>
    <cfdirectory action="create" directory="#this.imagePath#/thumb">
    </cfif>
    <cfif NOT DirectoryExists(this.imagePath & '/alt')>
    <cfdirectory action="create" directory="#this.imagePath#/alt">
    </cfif>
    <cftry>
    <cffile action="upload" accept="#application.imageMIME#" destination="#this.imageTempPath#" nameConflict="makeunique" fileField="form.imgFile#ARGUMENTS.imgCountID#">
    <!---Check the image size.--->
    <cfif (CFFILE.FileSize GT (application.maxImageSize * 1024))>
    <cfset this.uploadFailed = "An error occured while uploading your file. The image file size you have uploaded is to large.  Please make sure the original image is smaller than 2mb/2000kb.">
    <cfset result.message = this.uploadFailed>
    <cfelse>
    <!--- Create the variable for insert of file name and file type --->
    <cfset this.fileName = CFFILE.ServerFileName & '.' & CFFILE.ServerFileExt>
    <!---Create source path from temp directory to collect the image and resize.--->
    <cfset this.fileSource = this.imageTempPath & '/' & this.fileName>
    <cfif CFFILE.ServerFileExt EQ 'swf' OR CFFILE.ServerFileExt EQ 'flv'>
    <cffile action="upload" accept="#application.imageMIME#" destination="#this.imagePath#/#this.fileName#" nameConflict="makeunique" fileField="form.imgFile#ARGUMENTS.imgCountID#">
    <cfelse>
    <!---Resize default file.--->
    <cfimage action="resize" width="#this.imgtWidth#" height="#Iif(IsDefined('this.btHeight'), Evaluate(DE('this.btHeight')), DE(''))#" source="#this.fileSource#" destination="#this.imagePath#/#this.fileName#" overwrite="yes">
    <cfimage action="writetobrowser" source="#this.imagePath#/#this.fileName#" destination="#this.imagePath#/#this.fileName#" overwrite="yes" quality="1">
    <!---Resize large file.--->
    <cfimage action="resize" width="#this.imgtWidthLarge#" height="" source="#this.fileSource#" destination="#this.imagePath#/large/#this.fileName#" overwrite="yes">
    <cfimage action="writetobrowser" source="#this.imagePath#/large/#this.fileName#" destination="#this.imagePath#/large/#this.fileName#" overwrite="yes" quality="1">
	<!---Resize thumbnail file.--->
    <cfimage action="resize" width="#this.imgtWidthThumb#" height="" source="#this.fileSource#" destination="#this.imagePath#/thumb/#this.fileName#" overwrite="yes">
    <cfimage action="writetobrowser" source="#this.imagePath#/thumb/#this.fileName#" destination="#this.imagePath#/thumb/#this.fileName#" overwrite="yes" quality="1">
    <!---Resize alt file.--->
    <cfimage action="resize" width="#this.imgtWidthAlt#" height="" source="#this.fileSource#" destination="#this.imagePath#/alt/#this.fileName#" overwrite="yes">
    <cfimage action="writetobrowser" source="#this.imagePath#/alt/#this.fileName#" destination="#this.imagePath#/alt/#this.fileName#" overwrite="yes" quality="1">
    </cfif>
    </cfif>
    <cfcatch type="any">
    <cfset this.uploadFailed = "An error occured while uploading your file, only common file types permitted. Types permitted include, JPG/JPEG, GIF, PNG, FLV, or SWF.">
    <cfset result.message = this.uploadFailed>
    </cfcatch>
    </cftry>
    <cfif NOT IsDefined('this.uploadFailed')>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    INSERT INTO tbl_image (imgName,imgFile,imgtID,netID,userID,imgStatus) VALUES
    (
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.imgName#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#this.fileName#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.imgtID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.netID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#session.userID#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.imgStatus#">
    )
    </cfquery>
    </cftransaction>
    <!--- Get newly inserted image ID. --->
    <cfinvoke 
    component="MCMS.component.cms.Cms"
    method="getMaxValueSQL"
    returnvariable="imgID">
    <cfinvokeargument name="tableName" value="tbl_image"/>
    </cfinvoke>
    <!---Now ftp to remote sites.--->
    <cfinvoke 
    component="MCMS.component.app.image.Image"
    method="setImageSFTPUpload"
    returnvariable="setImageSFTPUploadRet">
    <cfinvokeargument name="imgID" value="#imgID#" />
    </cfinvoke>
    </cfif>
    <cfcatch type="any">
    <cfset result.message = "There was an error inserting the record.">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="insertImageType" access="public" returntype="struct">
    <cfargument name="imgtName" type="string" required="yes">
    <cfargument name="imgtPath" type="string" required="yes">
    <cfargument name="imgtWidth" type="string" required="yes">
    <cfargument name="imgtWidthLarge" type="string" required="yes">
    <cfargument name="imgtWidthThumb" type="string" required="yes">
    <cfargument name="imgtWidthAlt" type="string" required="yes">
    <cfargument name="imgtStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully inserted the record.">
    <cftry>
    <!---Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.app.image.Image"
    method="getImageType"
    returnvariable="getCheckImageTypeRet">
    <cfinvokeargument name="imgtName" value="#ARGUMENTS.imgtName#"/>
    <cfinvokeargument name="imgtStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckImageTypeRet.recordcount NEQ 0>
    <cfset result.message = "The name #ARGUMENTS.imgtName# already exists, please enter a new name.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    INSERT INTO tbl_image_type (imgtName,imgtPath,imgtWidth,imgtWidthLarge,imgtWidthThumb,imgtWidthAlt,imgtStatus) VALUES
    (
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.imgtName#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.imgtPath#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.imgtWidth#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.imgtWidthLarge#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.imgtWidthThumb#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.imgtWidthAlt#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.imgtStatus#">
    )
    </cfquery>
    </cftransaction>
    </cfif>
    <cfcatch type="any">
    <cfset result.message = "There was an error inserting the record.">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="updateImage" access="public" returntype="struct">
    <cfargument name="ID" type="numeric" required="yes">
    <cfargument name="uaID" type="numeric" required="yes">
    <cfargument name="imgName" type="string" required="yes">
    <cfargument name="imgFile" type="string" required="yes">
    <cfargument name="tempImgFile" type="string" required="yes">
    <cfargument name="imgtID" type="numeric" required="yes">
    <cfargument name="imgStatus" type="numeric" required="yes">
    <!---Passed if image type is a banner.--->
    <cfargument name="btID" type="numeric" required="yes">
    <cfset result.message = "You have successfully updated the record.">
    <cftry>
    <!---Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.app.image.Image"
    method="getImage"
    returnvariable="getCheckImageRet">
    <cfinvokeargument name="excludeID" value="#ARGUMENTS.ID#"/>
    <cfinvokeargument name="imgName" value="#ARGUMENTS.imgName#"/>
    <cfinvokeargument name="imgStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckImageRet.recordcount NEQ 0>
    <cfset result.message = "The name #ARGUMENTS.imgName# #ARGUMENTS.ID# #getCheckImageRet.recordcount# already exists, please enter a new name.">
    <cfelse>
    <!---Upload the file if one was uploaded.--->
    <cfset this.fileName = ARGUMENTS.tempImgFile>
    <cfif ARGUMENTS.imgFile NEQ "">
    <!---First get the imgtPath.--->
    <cfinvoke 
    component="MCMS.component.app.image.Image"
    method="getImageType"
    returnvariable="getImageTypePathRet">
    <cfinvokeargument name="ID" value="#ARGUMENTS.imgtID#"/>
    <cfinvokeargument name="imgtStatus" value="1,3"/>
    </cfinvoke>
    <!---Create width variables for resizing.--->
    <cfset this.imgtWidth = getImageTypePathRet.imgtWidth>
    <cfset this.imgtWidthLarge = getImageTypePathRet.imgtWidthLarge>
    <cfset this.imgtWidthThumb = getImageTypePathRet.imgtWidthThumb>
    <cfset this.imgtWidthAlt = getImageTypePathRet.imgtWidthAlt>
    <cfset this.imgtPath = getImageTypePathRet.imgtPath>
    <!---If the image is a banner image then gather the size from the banner type table.--->
    <cfif ARGUMENTS.imgtID EQ 8>
    <cfinvoke 
    component="MCMS.component.app.banner.Banner"
    method="getBannerType"
    returnvariable="getBannerTypeRet">
    <cfinvokeargument name="ID" value="#ARGUMENTS.btID#"/>
    <cfinvokeargument name="btStatus" value="1,3"/>
    </cfinvoke>
    <cfset this.imgtWidth = getBannerTypeRet.btWidth>
    <cfset this.btHeight = getBannerTypeRet.btHeight>
    </cfif>
    <!---Contruct the temp path for the image to be uploaded.--->
    <cfset this.imageTempPath = '#application.mcmsRepositoryDir#/image/temp'>
    <!---Contruct the path for the image to be resized and uploaded.--->
    <cfset this.imagePath = '#application.mcmsRepositoryDir#/image/#this.imgtPath#'>
	<!---Check to see the temp directory exists.--->
    <cfif NOT DirectoryExists(this.imageTempPath)>
    <cfdirectory action="create" directory="#this.imageTempPath#">
    </cfif>
    <!---Check to see the file directory exists and create variants of folders i.e.: thumb and alt.--->
    <cfif NOT DirectoryExists(this.imagePath)>
    <cfdirectory action="create" directory="#this.imagePath#">
    </cfif>
    <cfif NOT DirectoryExists(this.imagePath & '/large')>
    <cfdirectory action="create" directory="#this.imagePath#/large">
    </cfif>
    <cfif NOT DirectoryExists(this.imagePath & '/thumb')>
    <cfdirectory action="create" directory="#this.imagePath#/thumb">
    </cfif>
    <cfif NOT DirectoryExists(this.imagePath & '/alt')>
    <cfdirectory action="create" directory="#this.imagePath#/alt">
    </cfif>
    <cftry>
    <cffile action="upload" accept="#application.imageMIME#" destination="#this.imageTempPath#" nameConflict="makeunique" fileField="form.imgFile">
    <!---Check the image size.--->
    <cfif (CFFILE.FileSize GT (application.maxImageSize * 1024))>
    <cfset this.uploadFailed = "An error occured while uploading your file. The image file size you have uploaded is to large.  Please make sure the original image is smaller than 2mb/2000kb.">
    <cfset result.message = this.uploadFailed>
    <cfelse>
    <!--- Create the variable for insert of file name and file type --->
    <cfset this.fileName = CFFILE.ServerFileName & '.' & CFFILE.ServerFileExt>
    <!---Create source path from temp directory to collect the image and resize.--->
    <cfset this.fileSource = this.imageTempPath & '/' & this.fileName>
     <cfif CFFILE.ServerFileExt EQ 'swf' OR CFFILE.ServerFileExt EQ 'flv'>
    <cffile action="upload" accept="#application.imageMIME#" destination="#this.imagePath#/#this.fileName#" nameConflict="makeunique" fileField="form.imgFile#ARGUMENTS.imgCountID#">
    <cfelse>
    <!---Resize default file.--->
    <cfimage action="resize" width="#this.imgtWidth#" height="#Iif(IsDefined('this.btHeight'), Evaluate(DE('this.btHeight')), DE(''))#" source="#this.fileSource#" destination="#this.imagePath#/#this.fileName#" overwrite="yes">
    <cfimage action="writetobrowser" source="#this.imagePath#/#this.fileName#" destination="#this.imagePath#/#this.fileName#" overwrite="yes" quality="1">
    <!---Resize large file.--->
    <cfimage action="resize" width="#this.imgtWidthLarge#" height="" source="#this.fileSource#" destination="#this.imagePath#/large/#this.fileName#" overwrite="yes">
    <cfimage action="writetobrowser" source="#this.imagePath#/large/#this.fileName#" destination="#this.imagePath#/large/#this.fileName#" overwrite="yes" quality="1">
	<!---Resize thumbnail file.--->
    <cfimage action="resize" width="#this.imgtWidthThumb#" height="" source="#this.fileSource#" destination="#this.imagePath#/thumb/#this.fileName#" overwrite="yes">
    <cfimage action="writetobrowser" source="#this.imagePath#/thumb/#this.fileName#" destination="#this.imagePath#/thumb/#this.fileName#" overwrite="yes" quality="1">
    <!---Resize alt file.--->
    <cfimage action="resize" width="#this.imgtWidthAlt#" height="" source="#this.fileSource#" destination="#this.imagePath#/alt/#this.fileName#" overwrite="yes">
    <cfimage action="writetobrowser" source="#this.imagePath#/alt/#this.fileName#" destination="#this.imagePath#/alt/#this.fileName#" overwrite="yes" quality="1">
    </cfif>
    </cfif>
    <cfcatch type="any">
    <cfset this.uploadFailed = "An error occured while uploading your file, only common file types permitted. Types permitted include, JPG/JPEG, GIF, PNG, SWF, or FLV.">
    <cfset result.message = this.uploadFailed>
    </cfcatch>
    </cftry>
    </cfif>
    <cfif NOT IsDefined("this.uploadFailed")>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_image SET
    imgName = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.imgName#">,
    imgFile = <cfqueryparam cfsqltype="cf_sql_varchar" value="#this.fileName#">,
    imgtID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.imgtID#">,
	<cfif ARGUMENTS.uaID NEQ 101>
    imgDateUpdate = <cfqueryparam cfsqltype="cf_sql_timestamp" value="#Now()#">,
    userID = <cfqueryparam cfsqltype="cf_sql_integer" value="#session.userID#">,
    </cfif>
    imgStatus = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.imgStatus#">
    WHERE ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ID#">
    </cfquery>
    </cftransaction>
    </cfif>
    <!---Now ftp to remote sites.--->
    <cfinvoke 
    component="MCMS.component.app.image.Image"
    method="setImageSFTPUpload"
    returnvariable="setImageSFTPUploadRet">
    <cfinvokeargument name="imgID" value="#ARGUMENTS.ID#" />
    </cfinvoke>
    </cfif>
    <cfcatch type="any">
    <cfset result.message = "There was an error updating the record.">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="setImageSFTPUpload" access="public" returntype="struct">
    <cfargument name="imgID" type="numeric" required="yes" default="0">
    <cfset result.message = "You have successfully uploaded the record(s).">
    <cfset result.connection = ''>
    <!---Query the image.--->
    <cfinvoke 
    component="MCMS.component.app.image.Image"
    method="getImage"
    returnvariable="getImageRet">
    <cfinvokeargument name="ID" value="#ARGUMENTS.imgID#"/>
    <cfinvokeargument name="imgStatus" value="1,2,3"/>
    </cfinvoke>
    
    <cfif getImageRet.recordcount NEQ 0>
    <cfset this.fileName = getImageRet.imgFile>
    
    <!---Set DEV SW server settings for the connection.--->
    <cfset swDEVFTPServerIP = application.swDEVFTPServerIP>
    <cfset swDEVFTPServerPort = application.swDEVFTPServerPort>
    <cfset swDEVFTPSecureServer = application.swDEVFTPSecureServer>
    <cfset swDEVServerURL = application.swDEVServerURL>
    <cfset swDEVFTPKeyFilePath = Iif(application.swDEVFTPKeyFilePath NEQ 'none', DE(application.swDEVFTPKeyFilePath), DE(''))>
    <cfset swDEVFTPUsername = application.swDEVFTPUsername>
    <cfset swDEVFTPPassword = Iif(application.swDEVFTPPassword NEQ 'none', DE(application.swDEVFTPPassword), DE(''))>
    
    <!---Set PROD SW server settings for the connection.--->
    <cfset swPRODFTPServerIP = application.swPRODFTPServerIP>
    <cfset swPRODFTPServerPort = application.swPRODFTPServerPort>
    <cfset swPRODFTPSecureServer = application.swPRODFTPSecureServer>
    <cfset swPRODServerURL = application.swPRODServerURL>
    <cfset swPRODFTPKeyFilePath = Iif(application.swPRODFTPKeyFilePath NEQ 'none', DE(application.swPRODFTPKeyFilePath), DE(''))>
    <cfset swPRODFTPUsername = application.swPRODFTPUsername>
    <cfset swPRODFTPPassword = Iif(application.swPRODFTPPassword NEQ 'none', DE(application.swPRODFTPPassword), DE(''))>

    
    
    <cfset this.path = getImageRet.imgtPath>
    <cfset loopPathList = "#this.path#,#this.path#/thumb,#this.path#/alt">
    
    <cfset swDEVFTPRemotePath = '#application.mcmsCDNURL#/#application.mcmsRepositoryDir#/image'>
    <cfset swPRODFTPRemotePath = '#application.mcmsCDNURL#/#application.mcmsRepositoryDir#/image'>
	
    <cftry>
    <!---Connect to SW DEV Server.--->
    <cfset swDEVConnectionStatus.succeeded = ''>
    <cfftp connection="swDEVConnection" action="open" server="#swDEVFTPServerIP#" port="#swDEVFTPServerPort#" secure="#swDEVFTPSecureServer#" username="#swDEVFTPUsername#" password="#swDEVFTPPassword#" stoponerror="no" result="swDEVConnectionStatus" retrycount="3" timeout="5" passive="no">
    <cfcatch type="any">
    <cfset result.message = "There was an error uploading the record(s).">
    <!---If connection failed send error(s).--->
    <cfif swDEVConnectionStatus.succeeded NEQ ''>
	<cfif swDEVConnectionStatus.succeeded EQ 'NO'>
	<cfset result.connection = "#result.connection# <br> swDEVConnection Failed: #swDEVConnectionStatus.errorText#">
    <cfelse>
    <cfset result.connection = result.connection>
	</cfif>
    <cfelse>
    <cfset result.connection = "swDEVConnection Failed: Could not return a result.  FTP service may be down.">
    </cfif>
    <cfset this.messageBody = 
    '
    <h1>A Web Site Error Has Occured</h1>
    <table id="tableMain">
    <tr>
    <td>Submitted by Host Machine: #CGI.HTTP_HOST#</td>
    </tr>
    <tr>
    <td>Submitted by Referrer: #CGI.HTTP_REFERER#</td>
    </tr>
    <cfif IsDefined("session.userUsername")>
    <tr>
    <td>Submitted by: #session.userName# (#session.userUsername#)</td>
    </tr>
    </cfif>
    <tr>
    <td>Template:#CGI.SCRIPT_NAME#?#CGI.QUERY_STRING#</td>
    </tr>
    <tr>
    <td id="titlesmall">Diagostics Below</td>
    </tr>
    <tr>
    <td>
	<b>Type:</b> #CFCATCH.Type#<br>
	<b>Message:</b> #CFCATCH.Message#<br><br>
    <b>Detail:</b> #CFCATCH.Detail#<br><br>
	Connection Results: #result.connection#
    </td>
    </tr>
    </table>
    '
    >
    <cfinvoke 
    component="MCMS.component.utility.Utility.Email"
    method="sendEmail">
    <cfinvokeargument name="subject" value="#application.companyName# Image Upload Error/SFTP Connection Error"/>
    <cfinvokeargument name="to" value="#application.webmasterEmail#"/>
    <cfinvokeargument name="from" value="#application.noReplyEmail#"/>
    <cfinvokeargument name="cc" value=""/>
    <cfinvokeargument name="bcc" value=""/>
    <cfinvokeargument name="body" value="#this.messageBody#"/>
    <cfinvokeargument name="emailType" value="html"/>
    <cfinvokeargument name="type" value="admin"/>
    </cfinvoke>
    </cfcatch>
    </cftry>
    
    <cftry>
    <!---Connect to SW PROD Server.--->
    <cfset swPRODConnectionStatus.succeeded = ''>
    <cfftp connection="swPRODConnection" action="open" server="#swPRODFTPServerIP#" secure="#swPRODFTPSecureServer#" port="#swPRODFTPServerPort#" username="#swPRODFTPUsername#" password="#swPRODFTPPassword#" stoponerror="no" result="swPRODConnectionStatus" retrycount="3" timeout="5" passive="no">
    <cfcatch type="any">
    <cfset result.message = "There was an error uploading the record(s).">
    <!---If connection failed send error(s).--->
    <cfif swPRODConnectionStatus.succeeded NEQ ''>
	<cfif swPRODConnectionStatus.succeeded EQ 'NO'>
	<cfset result.connection = "#result.connection# <br> swPRODConnection Failed: #swPRODConnectionStatus.errorText#">
    <cfelse>
    <cfset result.connection = result.connection>
	</cfif>
    <cfelse>
    <cfset result.connection = "swPRODConnectionStatus Failed: Could not return a result.  FTP service may be down.">
    </cfif>
    <cfset this.messageBody = 
    '
    <h1>A Web Site Error Has Occured</h1>
    <table id="tableMain">
    <tr>
    <td>Submitted by Host Machine: #CGI.HTTP_HOST#</td>
    </tr>
    <tr>
    <td>Submitted by Referrer: #CGI.HTTP_REFERER#</td>
    </tr>
    <cfif IsDefined("session.userUsername")>
    <tr>
    <td>Submitted by: #session.userName# (#session.userUsername#)</td>
    </tr>
    </cfif>
    <tr>
    <td>Template:#CGI.SCRIPT_NAME#?#CGI.QUERY_STRING#</td>
    </tr>
    <tr>
    <td id="titlesmall">Diagostics Below</td>
    </tr>
    <tr>
    <td>
	<b>Type:</b> #CFCATCH.Type#<br>
	<b>Message:</b> #CFCATCH.Message#<br><br>
    <b>Detail:</b> #CFCATCH.Detail#<br><br>
	Connection Results: #result.connection#
    </td>
    </tr>
    </table>
    '
    >
    <cfinvoke 
    component="MCMS.component.utility.Utility.Email"
    method="sendEmail">
    <cfinvokeargument name="subject" value="#application.companyName# Image Upload Error/SFTP Connection Error"/>
    <cfinvokeargument name="to" value="#application.webmasterEmail#"/>
    <cfinvokeargument name="from" value="#application.noReplyEmail#"/>
    <cfinvokeargument name="cc" value=""/>
    <cfinvokeargument name="bcc" value=""/>
    <cfinvokeargument name="body" value="#this.messageBody#"/>
    <cfinvokeargument name="emailType" value="html"/>
    <cfinvokeargument name="type" value="admin"/>
    </cfinvoke>
    </cfcatch>
    </cftry>

    <!---Loop over all files for upload.--->
    <cfloop list="#loopPathList#" index="i" delimiters=",">
    
    <!---Use only SW servers.--->
    <cfif swDEVConnectionStatus.succeeded EQ 'YES'>
    <cfftp connection="swDEVConnection" action="putFile" name="uploadFile" result="swDevUpload" transferMode="auto" localFile="#application.mcmsRepositoryDir#\image\#i#\#this.fileName#" remoteFile="#swDEVFTPRemotePath#/#i#/#this.fileName#">
    <cflog file="swDevFTPLog" application="no" text="#swDEVFTPRemotePath#/#i#/#this.fileName# uploaded by #session.userName#.">
    </cfif>
    
    <cfif swPRODConnectionStatus.succeeded EQ 'YES'>
    <cfftp connection="swPRODConnection" action="putFile" name="uploadFile" result="swProdUpload" transferMode="auto" localFile="#application.mcmsRepositoryDir#\image\#i#\#this.fileName#" remoteFile="#swPRODFTPRemotePath#/#i#/#this.fileName#">
    <cflog file="swProdFTPLog" application="no" text="#swPRODFTPRemotePath#/#i#/#this.fileName# uploaded by #session.userName#.">
    </cfif>
	</cfloop>
	<!---Close the connections.--->
    <cfif swDEVConnectionStatus.succeeded NEQ ''>
    <cfftp connection="swDEVConnection" action="close">
    </cfif>
    <cfif swPRODConnectionStatus.succeeded NEQ ''>
    <cfftp connection="swPRODConnection" action="close">
    </cfif>
	</cfif>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="updateImageType" access="public" returntype="struct">
    <cfargument name="ID" type="numeric" required="yes">
    <cfargument name="imgtName" type="string" required="yes">
    <cfargument name="imgtPath" type="string" required="yes">
    <cfargument name="imgtWidth" type="string" required="yes">
    <cfargument name="imgtWidthLarge" type="string" required="yes">
    <cfargument name="imgtWidthThumb" type="string" required="yes">
    <cfargument name="imgtWidthAlt" type="string" required="yes">
    <cfargument name="imgtStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully updated the record.">
    <cftry>
    <!---Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.app.image.Image"
    method="getImageType"
    returnvariable="getCheckImageTypeRet">
    <cfinvokeargument name="excludeID" value="#ARGUMENTS.ID#"/>
    <cfinvokeargument name="imgtName" value="#ARGUMENTS.imgtName#"/>
    <cfinvokeargument name="imgtStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getCheckImageTypeRet.recordcount NEQ 0>
    <cfset result.message = "The name #ARGUMENTS.imgtName# already exists, please enter a new name.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_image_type SET
    imgtName = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.imgtName#">,
    imgtPath = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.imgtPath#">,
    imgtWidth = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.imgtWidth#">,
    imgtWidthLarge = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.imgtWidthLarge#">,
    imgtWidthThumb = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.imgtWidthThumb#">,
    imgtWidthAlt = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.imgtWidthAlt#">,
    imgtStatus = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.imgtStatus#">
    WHERE ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ID#">
    </cfquery>
    </cftransaction>
    </cfif>
    <cfcatch type="any">
    <cfset result.message = "There was an error updating the record.">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="updateImageList" access="public" returntype="struct">
    <cfargument name="ID" type="numeric" required="yes">
    <cfargument name="imgStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully updated the records.">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_image SET
    imgStatus = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.imgStatus#">
    WHERE ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ID#">
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error updating the records.">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="updateImageTypeList" access="public" returntype="struct">
    <cfargument name="ID" type="numeric" required="yes">
    <cfargument name="imgtStatus" type="numeric" required="yes">
    <cfset result.message = "You have successfully updated the records.">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_image_type SET
    imgtStatus = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.imgtStatus#">
    WHERE ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.ID#">
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error updating the records.">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="deleteImage" access="public" returntype="struct">
    <cfargument name="ID" type="string" required="yes">
    <cfset result.message = "You have successfully deleted the record(s).">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    DELETE FROM tbl_image
    WHERE ID IN (<cfqueryparam cfsqltype="cf_sql_integer" list="yes" value="#ARGUMENTS.ID#">)
    </cfquery>
    <!---Delete Fishing Report Relationship images.--->
    <cfquery datasource="#application.mcmsDSN#">
    DELETE FROM tbl_fr_location_image_rel
    WHERE imgID IN (<cfqueryparam cfsqltype="cf_sql_integer" list="yes" value="#ARGUMENTS.ID#">)
    </cfquery>
    <!---Delete Event Relationship images.--->
    <cfquery datasource="#application.mcmsDSN#">
    DELETE FROM tbl_event_image_rel
    WHERE imgID IN (<cfqueryparam cfsqltype="cf_sql_integer" list="yes" value="#ARGUMENTS.ID#">)
    </cfquery>
    <!---Delete News Relationship images.--->
    <cfquery datasource="#application.mcmsDSN#">
    DELETE FROM tbl_news_image_rel
    WHERE imgID IN (<cfqueryparam cfsqltype="cf_sql_integer" list="yes" value="#ARGUMENTS.ID#">)
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error deleting the record(s).">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
     
    <cffunction name="deleteImageType" access="public" returntype="struct">
    <cfargument name="ID" type="string" required="yes">
    <cfset result.message = "You have successfully deleted the record(s).">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    DELETE FROM tbl_image_type
    WHERE ID IN (<cfqueryparam cfsqltype="cf_sql_integer" list="yes" value="#ARGUMENTS.ID#">)
    </cfquery>
    </cftransaction>
    <cfif ARGUMENTS.ID NEQ 0>
    <cfinvoke 
    component="MCMS.component.app.image.Image"
    method="getImage"
    returnvariable="getImageRet">
    <cfinvokeargument name="imgtID" value="#ARGUMENTS.ID#"/>
    <cfinvokeargument name="imgStatus" value="1,2,3"/>
    </cfinvoke>
    <cfif getImageRet.recordcount NEQ 0>
    <cfset imgID = ValueList(getImageRet.ID)>
    <cfinvoke 
    component="MCMS.component.app.image.Image"
    method="deleteImage"
    returnvariable="deleteImageRet">
    <cfinvokeargument name="ID" value="#imgID#"/>
    </cfinvoke>
    </cfif>
    </cfif>
    <cfcatch type="any">
    <cfset result.message = "There was an error deleting the record(s).">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction> 
</cfcomponent>