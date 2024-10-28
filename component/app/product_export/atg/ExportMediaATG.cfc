<cfcomponent hint="Export component for ATG Media data export.">
    <cffunction name="getMediaExport" access="public" returntype="struct" hint="Process to excute functions to populate media export/interface table.">
    <cfargument name="cID" type="numeric" required="yes" default="0">
    <cfset brand = StructNew()>
    <cfset video = StructNew()>
    <cfset video2 = StructNew()>
    
    <cftry>
    <!---Get a list of products that are export approved.--->
    <cfinvoke 
    component="cfc.product"
    method="getProductDepartmentRel"
    returnvariable="getProductExportApprovedRet">
    <cfinvokeargument name="cID" value="#ARGUMENTS.cID#"/>
    <cfinvokeargument name="pesID" value="103"/>
    <cfinvokeargument name="pStatus" value="1"/>
    </cfinvoke>
    
    <cfif getProductExportApprovedRet.recordcount NEQ 0>
    <cfloop query="getProductExportApprovedRet">
    <cfset this.pID = getProductExportApprovedRet.pID>
    <cfset this.startDate = DateFormat(getProductExportApprovedRet.pDateRel, 'm/d/yyyy') & ' ' & '12:00 AM'>
    <cfset this.endDate = DateFormat(getProductExportApprovedRet.pDateExp, 'm/d/yyyy') & ' ' & '12:00 AM'>
    <!---Begin Media Image Insert.--->
    <cfinvoke 
    component="cfc.product" 
    method="getProductImageRel" 
    returnvariable="getProductImageRelRet">
    <cfinvokeargument name="pID" value="#this.pID#">
    <cfinvokeargument name="orderBy" value="pID,ID"/>
    </cfinvoke>
    <!---Get all media images.--->
    <cfset i = 0>
    <cfloop query="getProductImageRelRet">
    <cfset media = StructNew()>
    <cfset i = i+1>
    <!---Media ID.--->
    <cfinvoke 
    component="cfc.image"
    method="setMediaID"
    returnvariable="mediaID">
    <cfinvokeargument name="imgID" value="#getProductImageRelRet.imgID#">
    </cfinvoke>
    <cfset StructInsert(media, 'ID', mediaID)>
    <cfset StructInsert(media, 'pID', this.pID)>
    <cfset StructInsert(media, 'productID', getProductImageRelRet.productID)>
    <cfset StructInsert(media, 'startDate', DateFormat(getProductImageRelRet.pDateRel, 'm/d/yyyy') & ' ' & '12:00 AM')>
    <cfset StructInsert(media, 'endDate', DateFormat(getProductImageRelRet.pDateExp, 'm/d/yyyy') & ' ' & '12:00 AM')>
    <!---Build the path based on the image size.--->
    <cfset getImageExt = RIGHT(getProductImageRelRet.imgName, 6)>
    <cfset getImageExt = LEFT(getImageExt, 2)>
    <!---Loop over the different sizes.--->
    <cfset this.sizeList = "thumb,small,large,original">
    <cfset this.sizeListExt = "_tb.,_sm.,_lg.,_og.">
    <cfset this.sizeListSuffix = "tb,sm,lg,og">
    <cfloop index="i" from="1" to="4">
    <cfset imgDirectory = '/#ListGetAt(this.sizeList, i)#/'>
    <cfset imgFile = Replace(getProductImageRelRet.imgFile, '_tb.', ListGetAt(this.sizeListExt, i), 'ALL')>
    <cfset StructInsert(media, 'ID#i#', media.ID & ListGetAt(this.sizeListSuffix, i))>
    <cfset StructInsert(media, 'name#i#', '/img/products' & imgDirectory & imgFile)>
    <cfset StructInsert(media, 'description#i#', media.productID & " - " & getProductImageRelRet.imgName)>
    <cfset StructInsert(media, 'parentFolder#i#', 'imageFolder')>
    <cfset StructInsert(media, 'path#i#', '/Images')>
    <cfset StructInsert(media, 'url#i#', '/img/products' & imgDirectory & imgFile)>
    <!---Insert structure data into export table.--->
    <cfinvoke 
    component="MCMS.component.app.product_export.atg.ExportMediaATG"
    method="insertExportMediaATG"
    >
    <cfinvokeargument name="ID" value="#Evaluate('media.id#i#')#">
    <cfinvokeargument name="pID" value="#this.pID#">
    <cfinvokeargument name="name" value="#Evaluate('media.name#i#')#">
    <cfinvokeargument name="description" value="#Evaluate('media.description#i#')#">
	<cfinvokeargument name="startDate" value="#media.startDate#">
    <cfinvokeargument name="endDate" value="#media.endDate#">
    <cfinvokeargument name="parentFolder" value="#Evaluate('media.parentFolder#i#')#">
    <cfinvokeargument name="path" value="#Evaluate('media.path#i#')#">
    <cfinvokeargument name="url" value="#Evaluate('media.url#i#')#">
    <cfinvokeargument name="emaStatus" value="1">
    </cfinvoke>
    </cfloop>
    <cfscript>
	StructClear(media);
    </cfscript>
    </cfloop>
    
    <!---Begin Brand Image Insert.--->
    <cfinvoke 
    component="MCMS.component.app.vendor.Vendor"
    method="getBrand"
    returnvariable="getBrandRet">
    <cfinvokeargument name="ID" value="#getProductExportApprovedRet.bID#"/>
    <cfinvokeargument name="bStatus" value="1"/>
	</cfinvoke>
    
    <cfif getBrandRet.recordcount NEQ 0>
    <!---Media ID.--->
    <cfinvoke 
    component="cfc.image"
    method="setMediaID"
    returnvariable="mediaID">
    <cfinvokeargument name="imgID" value="#getBrandRet.imgID#">
    </cfinvoke>
    <cfset StructInsert(brand, 'ID', mediaID)>
    <cfset StructInsert(brand, 'pID', this.pID)>
    <cfset imgDirectory = '/'>
    <cfset imgFile = getBrandRet.imgFile>
    <cfset StructInsert(brand, 'name', '/img/logos' & imgDirectory & imgFile)>
    <cfset StructInsert(brand, 'description', productID & " - " & getBrandRet.imgName)>
    <cfset StructInsert(brand, 'parentFolder', 'imageFolder')>
    <cfset StructInsert(brand, 'path', '/Images')>
    <cfset StructInsert(brand, 'url', '/img/logos' & imgDirectory & imgFile)>
    <!---Insert structure data into export table.--->
    <cfinvoke 
    component="MCMS.component.app.product_export.atg.ExportMediaATG"
    method="insertExportMediaATG"
    >
    <cfinvokeargument name="ID" value="#brand.id#">
    <cfinvokeargument name="pID" value="#this.pID#">
    <cfinvokeargument name="name" value="#brand.name#">
    <cfinvokeargument name="description" value="#brand.description#">
	<cfinvokeargument name="startDate" value="#this.startDate#">
    <cfinvokeargument name="endDate" value="#this.endDate#">
    <cfinvokeargument name="parentFolder" value="#brand.parentFolder#">
    <cfinvokeargument name="path" value="#brand.path#">
    <cfinvokeargument name="url" value="#brand.url#">
    <cfinvokeargument name="emaStatus" value="1">
    </cfinvoke> 
    </cfif>
    
    <!---Begin Media Video Insert.--->
    <cfinvoke 
    component="MCMS.component.app.product_export.atg.ExportMediaATG" 
    method="setVideoURL" 
    returnvariable="setVideoURLRet">
    <cfinvokeargument name="pID" value="#this.pID#">
    </cfinvoke>
    <cfset StructInsert(video, 'url', setVideoURLRet)>
    <cfif video.url NEQ ''>
    <!---Get a unique video media ID.--->
    <cfinvoke 
    component="MCMS.component.app.product_export.atg.ExportMediaATG" 
    method="setVideoID" 
    returnvariable="setVideoIDRet">
    <cfinvokeargument name="pID" value="#this.pID#">
    </cfinvoke>
    <cfset StructInsert(video, 'ID', setVideoIDRet)>
    <cfset StructInsert(video, 'name', getProductImageRelRet.productID & ' - You Tube Video')>
    <cfset StructInsert(video, 'description', getProductImageRelRet.productID & " - You Tube Video")>
    <cfset StructInsert(video, 'parentFolder', 'fld11000089')>
    <cfset StructInsert(video, 'path', 'Messages/' & Year(Now()) & '/you_tube/' & getProductImageRelRet.productID)>
    <!---Insert structure data into export table.---> 
    <cfinvoke 
    component="MCMS.component.app.product_export.atg.ExportMediaATG"
    method="insertExportMediaATG"
    >
    <cfinvokeargument name="ID" value="#video.ID#">
    <cfinvokeargument name="pID" value="#this.pID#">
    <cfinvokeargument name="name" value="#video.name#">
    <cfinvokeargument name="description" value="#video.description#">
	<cfinvokeargument name="startDate" value="#this.startDate#">
    <cfinvokeargument name="endDate" value="#this.endDate#">
    <cfinvokeargument name="parentFolder" value="#video.parentFolder#">
    <cfinvokeargument name="path" value="#video.path#">
    <cfinvokeargument name="url" value="#video.url#">
    <cfinvokeargument name="emaStatus" value="1">
    </cfinvoke> 
    </cfif>
    
    <!---Begin Media Video Insert.--->
    <cfinvoke 
    component="MCMS.component.app.product_export.atg.ExportMediaATG" 
    method="setVideoURL2" 
    returnvariable="setVideoURL2Ret">
    <cfinvokeargument name="pID" value="#this.pID#">
    </cfinvoke>
    <cfset StructInsert(video2, 'url2', setVideoURL2Ret)>
    <cfif video2.url2 NEQ ''>
    <!---Get a unique video media ID.--->
    <cfinvoke 
    component="MCMS.component.app.product_export.atg.ExportMediaATG" 
    method="setVideoID2" 
    returnvariable="setVideoID2Ret">
    <cfinvokeargument name="pID" value="#this.pID#">
    </cfinvoke>
    <cfset StructInsert(video2, 'ID', setVideoID2Ret)>
    <cfset StructInsert(video2, 'name', getProductImageRelRet.productID & ' - You Tube Video 2')>
    <cfset StructInsert(video2, 'description', getProductImageRelRet.productID & " - You Tube Video 2")>
    <cfset StructInsert(video2, 'parentFolder', 'fld11000089')>
    <cfset StructInsert(video2, 'path', 'Messages/' & Year(Now()) & '/you_tube/' & getProductImageRelRet.productID)>
    <!---Insert structure data into export table.---> 
    <cfinvoke 
    component="MCMS.component.app.product_export.atg.ExportMediaATG"
    method="insertExportMediaATG"
    >
    <cfinvokeargument name="ID" value="#video2.ID#">
    <cfinvokeargument name="pID" value="#this.pID#">
    <cfinvokeargument name="name" value="#video2.name#">
    <cfinvokeargument name="description" value="#video2.description#">
	<cfinvokeargument name="startDate" value="#this.startDate#">
    <cfinvokeargument name="endDate" value="#this.endDate#">
    <cfinvokeargument name="parentFolder" value="#video2.parentFolder#">
    <cfinvokeargument name="path" value="#video2.path#">
    <cfinvokeargument name="url" value="#video2.url2#">
    <cfinvokeargument name="emaStatus" value="1">
    </cfinvoke> 
    </cfif>
    
    <!---Begin Media Document Insert.--->
    <!---Get a list of product documents.--->
    <cfinvoke 
    component="cfc.product"
    method="getProductDocumentRel"
    returnvariable="getProductDocumentRelRet">
    <cfinvokeargument name="pID" value="#this.pID#"/>
    <cfinvokeargument name="doctID" value="#application.productDocumentType#"/>
    <cfinvokeargument name="docStatus" value="1"/>
    </cfinvoke>
    <cfif getProductDocumentRelRet.recordcount NEQ 0>
    <cfset i = 0>
    <cfloop query="getProductDocumentRelRet">
    <cfset document = StructNew()>
    <cfset StructInsert(document, 'parentFolder', 'imageFolder')>
    <cfset StructInsert(document, 'path', '/#getProductDocumentRelRet.docName#')>
    <cfset i = i+1>
    <cfinvoke 
    component="MCMS.component.app.product_export.atg.ExportMediaATG" 
    method="setMediaDocument" 
    returnvariable="setMediaDocumentRet">
    <cfinvokeargument name="pID" value="#getProductDocumentRelRet.pID#">
    </cfinvoke>
    <cfset StructInsert(document, 'docID', setMediaDocumentRet.docID)>
    <cfset StructInsert(document, 'name', setMediaDocumentRet.name)>
    <cfset StructInsert(document, 'url', setMediaDocumentRet.url)>
    <cfif document.url NEQ ''>
    <!---Get a unique video media ID.--->
    <cfinvoke 
    component="cfc.document" 
    method="setDocumentID" 
    returnvariable="setDocumentIDRet">
    <cfinvokeargument name="docID" value="#document.docID#">
    </cfinvoke>
    <cfset StructInsert(document, 'ID', setDocumentIDRet)>
    <cfset StructInsert(document, 'description', getProductImageRelRet.productID & " - Document")>
    <!---Insert structure data into export table.--->
    <cfinvoke 
    component="MCMS.component.app.product_export.atg.ExportMediaATG"
    method="insertExportMediaATG"
    >
    <cfinvokeargument name="ID" value="#document.ID#">
    <cfinvokeargument name="pID" value="#this.pID#">
    <cfinvokeargument name="name" value="#document.name#">
    <cfinvokeargument name="description" value="#document.description#">
	<cfinvokeargument name="startDate" value="#this.startDate#">
    <cfinvokeargument name="endDate" value="#this.endDate#">
    <cfinvokeargument name="parentFolder" value="#document.parentFolder#">
    <cfinvokeargument name="path" value="#document.path#">
    <cfinvokeargument name="url" value="#document.url#">
    <cfinvokeargument name="emaStatus" value="1">
    </cfinvoke> 
    </cfif>
    <cfscript>
	StructClear(document);
    </cfscript>
    </cfloop>
    </cfif>
    <!---Clear the structure for the next record.--->
    <cfscript>
	StructClear(brand);
    StructClear(video);
	StructClear(video2);
    </cfscript> 
    </cfloop>
    </cfif>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cflog file="export_media_atg" text="Error: Media Export! Check pID: #this.pID#" type="error"/>
    </cfcatch>
    </cftry>
    <cfreturn media>
    </cffunction>
    
    <cffunction name="getExportMediaATG" access="public" returntype="query" hint="Get Export Media ATG data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="excludeID" type="string" required="yes" default="0">
    <cfargument name="ID" type="string" required="yes" default="0">
    <cfargument name="pID" type="string" required="yes" default="0">
    <cfargument name="cID" type="string" required="yes" default="0">
    <cfargument name="pesID" type="string" required="yes" default="0">
    <cfargument name="deptNo" type="string" required="yes" default="0">
    <cfargument name="orderBy" type="string" required="yes" default="ID">
    <cfset var rsExportMediaATG = "" >
    <cftry>
    <cfquery name="rsExportMediaATG" datasource="#application.mcmsDSN#">
    SELECT * FROM v_export_media_atg WHERE 0=0
    <cfif ARGUMENTS.ID NEQ 0>
    AND ID = <cfqueryparam value="#ARGUMENTS.ID#" cfsqltype="cf_sql_varchar">
    </cfif>
    <cfif ARGUMENTS.excludeID NEQ 0>
    AND ID <> <cfqueryparam value="#ARGUMENTS.excludeID#" cfsqltype="cf_sql_varchar">
    </cfif>
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(name) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(ID) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(description) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">)
    </cfif>
    <cfif ARGUMENTS.pID NEQ 0>
    AND pID IN (<cfqueryparam value="#ARGUMENTS.pID#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    <cfif ARGUMENTS.cID NEQ 0>
    AND cID IN (<cfqueryparam value="#ARGUMENTS.cID#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    <cfif ARGUMENTS.pesID NEQ 0>
    AND pesID IN (<cfqueryparam value="#ARGUMENTS.pesID#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    <cfif ARGUMENTS.deptNo NEQ 0>
    AND deptNo IN (<cfqueryparam value="#ARGUMENTS.deptNo#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cflog file="export_media_atg" text="Error: getExportMediaATG. Check pID: #ARGUMENTS.pID#" type="error"/>
    
    </cfcatch>
    </cftry>
    <cfreturn rsExportMediaATG>
    </cffunction>
    
    <cffunction name="getExportMediaATGExcel" access="public" returntype="any" hint="Get Export Media ATG data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="args" type="string" required="yes" default="0,0,0">
    <cfargument name="excludeID" type="string" required="yes" default="0">
    <cfargument name="ID" type="string" required="yes" default="0">
    <cfargument name="pID" type="string" required="yes" default="0">
    <cfargument name="cID" type="string" required="yes" default="0">
    <cfargument name="orderBy" type="string" required="yes" default="pID, ID, name">
    <!---Control the sql pulled for the excel report.--->
    <cfargument name="getSQL" type="string" required="yes" default="false">
    <cfset var rsExportMediaATG = "" >
    <cftry>
    <cfquery name="rsExportMediaATG" datasource="#application.mcmsDSN#">
    SELECT ID, name, TO_CHAR(description) AS description, parentFolder, url FROM v_export_media_atg WHERE 0=0
    <cfif ARGUMENTS.ID NEQ 0>
    AND ID = <cfqueryparam value="#ARGUMENTS.ID#" cfsqltype="cf_sql_varchar">
    </cfif>
    <cfif ARGUMENTS.excludeID NEQ 0>
    AND ID <> <cfqueryparam value="#ARGUMENTS.excludeID#" cfsqltype="cf_sql_varchar">
    </cfif>
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(name) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(ID) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(description) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">)
    </cfif>
    <cfif ARGUMENTS.pID NEQ 0>
    AND pID IN (<cfqueryparam value="#ARGUMENTS.pID#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    <cfif ARGUMENTS.cID NEQ 0>
    AND cID IN (<cfqueryparam value="#ARGUMENTS.cID#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    <cfif ListGetAt(ARGUMENTS.args, 1) NEQ 0>
    AND deptNo IN (<cfqueryparam value="#ListGetAt(ARGUMENTS.args, 1)#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    <cfif ListGetAt(ARGUMENTS.args, 2) NEQ 0>
    AND cID IN (<cfqueryparam value="#ListGetAt(ARGUMENTS.args, 2)#" list="yes" cfsqltype="cf_sql_integer">)
    </cfif>
    <cfif ListGetAt(ARGUMENTS.args, 3) NEQ 0>
    AND pesID = <cfqueryparam value="#ListGetAt(ARGUMENTS.args, 3)#" cfsqltype="cf_sql_integer">
    </cfif>
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <cfif ARGUMENTS.getSQL EQ 'true'>
    <!---Now return the SQL list of columns in camel case.--->
    <cfset rsExportMediaATG = 'ID,name,description,parentFolder,url'>
    </cfif>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cflog file="export_media_atg" text="Error: getExportMediaATGExcel" type="error"/>
    
    </cfcatch>
    </cftry>
    <cfreturn rsExportMediaATG>
    </cffunction>
    
    <cffunction name="setVideoID" access="public" returntype="string" hint="Set Video ID based on product pID.">
    <cfargument name="pID" type="numeric" required="yes">
    <cfset var mediaID = "">
    <cftry>
    <!---Get the next media ID.--->
    <cfset mediaID = application.mediaIDSeedPrefix & 'v' & (application.mediaIDSeedNumber + ARGUMENTS.pID)>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset mediaID = StructNew()>
    <cfset mediaID.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn mediaID>
    </cffunction>
    
    <cffunction name="setVideoID2" access="public" returntype="string" hint="Set Video ID II based on product pID.">
    <cfargument name="pID" type="numeric" required="yes">
    <cfset var mediaID = "">
    <cftry>
    <!---Get the next media ID.--->
    <cfset mediaID = application.mediaIDSeedPrefix & 'v' & (application.mediaIDSeedNumber + ARGUMENTS.pID) & '-2'>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset mediaID = StructNew()>
    <cfset mediaID.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn mediaID>
    </cffunction>
    
    <cffunction name="insertExportMediaATG" access="public" returntype="struct">
    <cfargument name="ID" type="string" required="yes">
    <cfargument name="pID" type="numeric" required="yes">
    <cfargument name="userID" type="numeric" required="yes" default="101">
    <cfargument name="name" type="string" required="yes" default="">
    <cfargument name="description" type="string" required="yes" default="">
    <cfargument name="startDate" type="string" required="yes" default="#DateFormat(Now(), 'm/d/yyyy')# 12:00 AM">
    <cfargument name="endDate" type="string" required="yes" default="#DateFormat(DateAdd('yyyy', 20, Now()), 'm/d/yyyy')# 12:00 AM">
    <cfargument name="parentFolder" type="string" required="yes" default="">
    <cfargument name="path" type="string" required="yes" default="">
    <cfargument name="url" type="string" required="yes" default="">
    <cfargument name="emaStatus" type="numeric" required="yes" default="1">
    <cfset result.message = "You have successfully inserted the record.">
    <cftry>
    <!---Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.app.product_export.atg.ExportMediaATG"
    method="getExportMediaATG"
    returnvariable="getCheckExportMediaATGRet">
    <cfinvokeargument name="ID" value="#ARGUMENTS.ID#"/>
    </cfinvoke>
    <cfif getCheckExportMediaATGRet.recordcount NEQ 0>
    <!---Update the record.--->
    <cfinvoke 
    component="MCMS.component.app.product_export.atg.ExportMediaATG"
    method="updateExportMediaATG"
    >
    <cfinvokeargument name="ID" value="#ARGUMENTS.ID#">
    <cfinvokeargument name="pID" value="#ARGUMENTS.pID#">
    <cfinvokeargument name="name" value="#ARGUMENTS.name#">
    <cfinvokeargument name="description" value="#ARGUMENTS.description#">
    <cfinvokeargument name="startDate" value="#ARGUMENTS.startDate#">
    <cfinvokeargument name="endDate" value="#ARGUMENTS.endDate#">
    <cfinvokeargument name="parentFolder" value="#ARGUMENTS.parentFolder#">
    <cfinvokeargument name="path" value="#ARGUMENTS.path#">
    <cfinvokeargument name="url" value="#ARGUMENTS.url#">
    <cfinvokeargument name="emaStatus" value="1">
    </cfinvoke>
    <cfelse>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    INSERT INTO tbl_export_media_atg (ID,pID,userID,emaDateUpdated,name,description,startDate,endDate,parentFolder,path,url,emaStatus) VALUES
    (
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.ID#" maxlength="32">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.pID#" maxlength="8">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.userID#" maxlength="8">,
    <cfqueryparam cfsqltype="cf_sql_timestamp" value="#Now()#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.name#" maxlength="255">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.description#" maxlength="2048">,
	<cfqueryparam cfsqltype="cf_sql_varchar" value="#DateFormat(ARGUMENTS.startDate, 'm/d/yyyy')# 12:00 AM">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#DateFormat(ARGUMENTS.endDate, 'm/d/yyyy')# 12:00 AM">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.parentFolder#" maxlength="64">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.path#" maxlength="255">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.url#" maxlength="255">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.emaStatus#" maxlength="8"> 
    )
    </cfquery>
    </cftransaction>
    </cfif>
    <cfcatch type="any">
    <cfset result.message = "There was an error inserting the record.">
    <cflog file="export_media_atg" text="Error: insertExportMediaATG. Check pID: #ARGUMENTS.pID#" type="error"/>
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="updateExportMediaATG" access="public" returntype="struct">
    <cfargument name="ID" type="string" required="yes">
    <cfargument name="pID" type="numeric" required="yes">
    <cfargument name="userID" type="numeric" required="yes" default="101">
    <cfargument name="name" type="string" required="yes" default="">
    <cfargument name="description" type="string" required="yes" default="">
    <cfargument name="startDate" type="string" required="yes" default="#DateFormat(Now(), 'm/d/yyyy')# 12:00 AM">
    <cfargument name="endDate" type="string" required="yes" default="#DateFormat(DateAdd('yyyy', 20, Now()), 'm/d/yyyy')# 12:00 AM">
    <cfargument name="parentFolder" type="string" required="yes" default="">
    <cfargument name="path" type="string" required="yes" default="">
    <cfargument name="url" type="string" required="yes" default="false">
    <cfargument name="emaStatus" type="numeric" required="yes" default="1">
    <cfset result.message = "You have successfully updated the record.">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    UPDATE tbl_export_media_atg SET
    pID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.pID#" maxlength="8">,
    userID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.userID#" maxlength="8">,
    emaDateUpdated = <cfqueryparam cfsqltype="cf_sql_timestamp" value="#Now()#">,
    name = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.name#" maxlength="255">,
    description = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.description#">,
    startDate = <cfqueryparam cfsqltype="cf_sql_varchar" value="#DateFormat(ARGUMENTS.startDate, 'm/d/yyyy')# 12:00 AM">,
    endDate = <cfqueryparam cfsqltype="cf_sql_varchar" value="#DateFormat(ARGUMENTS.endDate, 'm/d/yyyy')# 12:00 AM">,
    parentFolder = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.parentFolder#" maxlength="64">,
	path = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.path#" maxlength="255">,
    url = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.url#" maxlength="255">,
    emaStatus = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.emaStatus#" maxlength="8">
    WHERE ID = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.ID#">
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error updating the record.">
    <cflog file="export_media_atg" text="Error: updateExportMediaATG. Check pID: #ARGUMENTS.pID#" type="error"/>
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="setMediaDocument" access="public" returntype="struct" hint="Function for media documents.">
    <cfargument name="pID" type="numeric" required="yes">
    <cfset result = StructNew()>
    <cftry>
    <!---Get document.--->
    <cfinvoke 
    component="cfc.product"
    method="getProductDocumentRel"
    returnvariable="rs">
    <cfinvokeargument name="pID" value="#ARGUMENTS.pID#"/>
    <cfinvokeargument name="pStatus" value="1"/>
    <cfinvokeargument name="pdrStatus" value="1"/>
    </cfinvoke>
    <cfif rs.recordcount NEQ 0>
    <cfset result.docID = rs.docID>
	<cfset result.name = rs.docName>
    <cfset result.url = '/media/' & rs.docFile>
    </cfif>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cflog file="export_media_atg" text="Error: Product Document for Product - #ARGUMENTS.pID#" type="error"/>
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction> 
    
    <cffunction name="setVideoURL" access="public" returntype="string" hint="Function for video url.">
    <cfargument name="pID" type="numeric" required="yes">
    <cfset result = ''>
    <cftry>
    <cfinvoke 
    component="cfc.product" 
    method="getProductAttributeExtRel" 
    returnvariable="rs">
    <cfinvokeargument name="pID" value="#ARGUMENTS.pID#">
    <cfinvokeargument name="paeNameAlt" value="videoURL">
    <cfinvokeargument name="paerStatus" value="1">
    </cfinvoke>
    <cfif rs.recordcount NEQ 0>
    <cfif rs.paerValue EQ ''>
    <cfset result = ''>
    <cfelse>
    <cfset result = rs.paerValue>
    </cfif>
    </cfif>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cflog file="export_media_atg" text="Error: Media Video URL for Media - #ARGUMENTS.pID#" type="error"/>
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="setVideoURL2" access="public" returntype="string" hint="Function for video URL 2.">
    <cfargument name="pID" type="numeric" required="yes">
    <cfset result = ''>
    <cftry>
    <cfinvoke 
    component="cfc.product" 
    method="getProductAttributeExtRel" 
    returnvariable="rs">
    <cfinvokeargument name="pID" value="#ARGUMENTS.pID#">
    <cfinvokeargument name="paeNameAlt" value="videoURL2">
    <cfinvokeargument name="paerStatus" value="1">
    </cfinvoke>
    <cfif rs.recordcount NEQ 0>
    <cfif rs.paerValue EQ ''>
    <cfset result = ''>
    <cfelse>
    <cfset result = rs.paerValue>
    </cfif>
    </cfif>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cflog file="export_media_atg" text="Error: Media Video URL 2 for Media - #ARGUMENTS.pID#" type="error"/>
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="deleteMediaExportATG" access="public" returntype="struct">
    <cfargument name="pID" type="string" required="yes">
    <cfset result.message = "You have successfully deleted the record(s).">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    DELETE FROM tbl_export_media_atg
    WHERE pID IN (<cfqueryparam cfsqltype="cf_sql_integer" list="yes" value="#ARGUMENTS.pID#">)
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error deleting the record(s).">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="truncateMediaExportATG" access="public" returntype="struct">
    <cfset result.message = "You have successfully deleted the record(s).">
    <cftry>
    <cftransaction>
    <cfquery datasource="#application.mcmsDSN#">
    TRUNCATE TABLE tbl_export_media_atg
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error deleting the record(s).">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
</cfcomponent>