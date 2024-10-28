<!---User this form to upload documents in a AJax environment using iFrame.--->
<cfif form.mcmsInsert NEQ false>
<cfinvoke 
component="/#application.mcmsAppAdminPath#/build_manager/component/BuildManager" 
method="insertBuildManagerDocumentRel" 
returnvariable="result">
<cfinvokeargument name="bmID" value="#form.bmID#">
<cfinvokeargument name="docName" value="#form.docName#">
<cfinvokeargument name="docFile" value="#form.docFile#">
</cfinvoke>
</cfif>

<div id="valMessage"></div>
<cfform name="attachDocument" id="attachDocument" enctype="multipart/form-data">
<h2>Attach Document(s) to Build (<cfoutput>#url.bmID#</cfoutput>)</h2>
<table id="mainTableAlt">
<tr>
<td colspan="3"><span class="small">NOTE: Your filename must be a maximum of 64 characters long and no special characters except underscores.
Failure to adhere to this rule may result in error to upload your document.</span></td>
</tr>
<tr>
<td><strong>Name</strong><span id="required">*</span></td>
<td colspan="2"><strong>File</strong><span id="required">*</span></td>
</tr>
<tr>
<td><cfinput type="text" name="docName" id="docName" maxlength="64" size="16" required="yes" message="Please include an Document Name." /></td>
<td>
<cfinput type="file" name="docFile" id="docFile" required="yes" message="Please include a File.">
</td>
<td>
<cfinput type="hidden" name="bmID" id="bmID" value="#url.bmID#" />
<cfinput type="submit" name="mcmsInsert" id="mcmsInsert" value="Insert Document">
</td>
</tr>
</table>
</cfform> 