<cfcomponent>
    <cffunction name="setQRCodeGenerator" access="public" returntype="any" hint="Get QR Code Generator data.">
    <cfargument name="qrWidth" type="numeric" required="yes" default="100">
    <cfargument name="qrHeight" type="numeric" required="yes" default="100">
    <cfargument name="qrURL" type="string" required="yes" default="">
    <cfset var QRCodeGenerator = "" >
    <cftry>
    <cfif ARGUMENTS.qrURL NEQ ''>
    <cfsavecontent variable="QRCodeGenerator">
    <cfhttp url="http://chart.apis.google.com/chart?chs=#ARGUMENTS.qrWidth#x#ARGUMENTS.qrHeight#&cht=qr&chl=#ARGUMENTS.qrURL#" result="qrCode" getasbinary="yes"/>
    <cfimage action="writeToBrowser" source="#qrCode.filecontent#" />
    </cfsavecontent>
    </cfif>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset QRCodeGenerator = StructNew()>
    <cfset QRCodeGenerator.message = "There was an error with the QR code generator.">
    
    </cfcatch>
    </cftry>
    <cfreturn QRCodeGenerator>
</cffunction>
</cfcomponent>