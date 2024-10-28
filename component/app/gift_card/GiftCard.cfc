<cfcomponent>
    <cffunction name="getGiftCard" access="public" returntype="query" hint="Get Gift Card data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="OLD_GC_SERIAL_NUMBER" type="numeric" required="yes" default="0">
    <cfargument name="excludeOLD_GC_SERIAL_NUMBER" type="numeric" required="yes" default="0">
    <cfargument name="LAST_NAME" type="string" required="yes" default="">
    <cfargument name="orderBy" type="string" required="yes" default="SW_STAGE_FLAG, LAST_NAME">
    <cfset var rsGiftCard = "" >
    <cftry>
    <cfquery name="rsGiftCard" datasource="prod1">
    SELECT * FROM swsvs.sw_gc_exchange WHERE 0=0
    <cfif ARGUMENTS.OLD_GC_SERIAL_NUMBER NEQ 0>
    AND OLD_GC_SERIAL_NUMBER = <cfqueryparam value="#ARGUMENTS.OLD_GC_SERIAL_NUMBER#" cfsqltype="cf_sql_numeric">
    </cfif>
    <cfif ARGUMENTS.excludeOLD_GC_SERIAL_NUMBER NEQ 0>
    AND OLD_GC_SERIAL_NUMBER <> <cfqueryparam value="#ARGUMENTS.excludeOLD_GC_SERIAL_NUMBER#" cfsqltype="cf_sql_numeric">
    </cfif>
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(OLD_GC_SERIAL_NUMBER) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(SW_REPLACEMENT_CARD_NUMBER) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(LAST_NAME) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(CITY) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(STATE) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(ZIP) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(EMAIL_ADDRESS) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">)
    </cfif>
    <cfif ARGUMENTS.LAST_NAME NEQ "">
    AND UPPER(LAST_NAME) = <cfqueryparam value="#UCASE(ARGUMENTS.LAST_NAME)#" cfsqltype="cf_sql_varchar">
    </cfif>
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsGiftCard = StructNew()>
    <cfset rsGiftCard.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsGiftCard>
    </cffunction>
    
    <cffunction name="getGiftCardReport" access="public" returntype="query" hint="Get GiftCard Report data.">
    <cfargument name="keywords" type="string" required="yes" default="All">
    <cfargument name="orderBy" type="string" required="yes" default="LAST_NAME">
    <cfset var rsGiftCardReport = "" >
    <cftry>
    <cfquery name="rsGiftCardReport" datasource="prod1">
    SELECT OLD_GC_SERIAL_NUMBER AS GIFT_CARD, OLD_GC_BALANCE AS BALANCE, CONCAT(CHR(96), SW_REPLACEMENT_CARD_NUMBER) AS REPLACEMENT_CARD_NUMBER, CONCAT(CHR(96), SW_REPLACEMENT_ORDER_NUMBER) AS ORDER_NO,  LAST_NAME, FIRST_NAME, ADDRESS1, ADDRESS2, CITY, STATE, ZIP, COUNTRY, EMAIL_ADDRESS, TELEPHONE, TO_CHAR(SW_ENTERED_DATE,'MM/DD/YYYY') AS ENTERED_DATE, SW_ENTERED_BY, SW_STAGE_FLAG, SW_VERIFIED_BY, TO_CHAR(SW_VERIFIED_DATE,'MM/DD/YYYY') AS VERIFIED_DATE, TO_CHAR(SW_DEVALUE_SUBMIT_DATE,'MM/DD/YYYY') AS DEVALUE_SUBMIT_DATE, TO_CHAR(SW_DEVALUE_VERIFY_DATE,'MM/DD/YYYY') AS DEVALUE_VERIFY_DATE, TO_CHAR(SW_REPLACEMENT_GEN_DATE,'MM/DD/YYYY') AS REPLACEMENT_GEN_DATE, TO_CHAR(SW_REPLACEMENT_VERIFY_DATE,'MM/DD/YYYY') AS REPLACEMENT_VERIFY_DATE
    FROM swsvs.sw_gc_exchange WHERE 0=0
    <cfif ARGUMENTS.keywords NEQ 'All'>
    AND (UPPER(OLD_GC_SERIAL_NUMBER) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(LAST_NAME) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(CITY) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(STATE) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(ZIP) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar"> OR UPPER(EMAIL_ADDRESS) LIKE <cfqueryparam value="%#UCASE(ARGUMENTS.keywords)#%" cfsqltype="cf_sql_varchar">)
    </cfif>
    ORDER BY #ARGUMENTS.orderBy#
    </cfquery>
    <!---Catch any errors.--->
    <cfcatch type="any">
    <cfset rsGiftCardReport = StructNew()>
    <cfset rsGiftCardReport.message = "There was an error with the query.">
    
    </cfcatch>
    </cftry>
    <cfreturn rsGiftCardReport>
    </cffunction>
    
    <cffunction name="insertGiftCard" access="public" returntype="struct">
    <cfargument name="OLD_GC_SERIAL_NUMBER" type="numeric" required="yes">
    <cfargument name="OLD_GC_BALANCE" type="string" required="yes">
    <cfargument name="FIRST_NAME" type="string" required="yes">
    <cfargument name="LAST_NAME" type="string" required="yes">
    <cfargument name="ADDRESS1" type="string" required="yes">
    <cfargument name="ADDRESS2" type="string" required="yes">
    <cfargument name="CITY" type="string" required="yes">
    <cfargument name="STATE" type="string" required="yes">
    <cfargument name="ZIP" type="string" required="yes">
    <cfargument name="COUNTRY" type="string" required="yes">
    <cfargument name="EMAIL_ADDRESS" type="string" required="yes">
    <cfargument name="TELEPHONE" type="string" required="yes">
    <cfargument name="SW_ENTERED_BY" type="string" required="yes">
    <cfset result.message = "You have successfully inserted the record.">
    <cftry>
    <!---Check for a duplicate record.--->
    <cfinvoke 
    component="MCMS.component.app.gift_card.GiftCard"
    method="getGiftCard"
    returnvariable="getCheckGiftCardRet">
    <cfinvokeargument name="OLD_GC_SERIAL_NUMBER" value="#ARGUMENTS.OLD_GC_SERIAL_NUMBER#"/>
    </cfinvoke>
    <cfif getCheckGiftCardRet.recordcount NEQ 0>
    <cfset result.message = "The name #ARGUMENTS.OLD_GC_SERIAL_NUMBER# already exists, please enter a new Gift Card number.">
    <cfelse>
    <cftransaction>
    <cfquery datasource="prod1">
    INSERT INTO swsvs.sw_gc_exchange (OLD_GC_SERIAL_NUMBER,OLD_GC_BALANCE,FIRST_NAME,LAST_NAME,ADDRESS1,ADDRESS2,CITY,STATE,ZIP,COUNTRY,EMAIL_ADDRESS,TELEPHONE,SW_ENTERED_BY) VALUES
    (
    <cfqueryparam cfsqltype="cf_sql_numeric" value="#ARGUMENTS.OLD_GC_SERIAL_NUMBER#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.OLD_GC_BALANCE#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.FIRST_NAME#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.LAST_NAME#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.ADDRESS1#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.ADDRESS2#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.CITY#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.STATE#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.ZIP#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.COUNTRY#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.EMAIL_ADDRESS#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.TELEPHONE#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.SW_ENTERED_BY#">
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
    
    <cffunction name="updateGiftCard" access="public" returntype="struct">
    <cfargument name="OLD_GC_SERIAL_NUMBER" type="numeric" required="yes">
    <cfargument name="OLD_GC_BALANCE" type="string" required="yes">
    <cfargument name="FIRST_NAME" type="string" required="yes">
    <cfargument name="LAST_NAME" type="string" required="yes">
    <cfargument name="ADDRESS1" type="string" required="yes">
    <cfargument name="ADDRESS2" type="string" required="yes">
    <cfargument name="CITY" type="string" required="yes">
    <cfargument name="STATE" type="string" required="yes">
    <cfargument name="ZIP" type="string" required="yes">
    <cfargument name="COUNTRY" type="string" required="yes">
    <cfargument name="EMAIL_ADDRESS" type="string" required="yes">
    <cfargument name="TELEPHONE" type="string" required="yes">
    <cfargument name="SW_STAGE_FLAG" type="numeric" required="yes">
    <cfargument name="SW_VERIFIED_BY" type="string" required="yes" default="">
    <cfargument name="SW_VERIFIED_DATE" type="string" required="yes" default="">
    <cfset result.message = "You have successfully updated the record.">
    <cftry>
    <cftransaction>
    <cfquery datasource="prod1">
    UPDATE swsvs.sw_gc_exchange SET
    OLD_GC_BALANCE = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.OLD_GC_BALANCE#">,
    FIRST_NAME = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.FIRST_NAME#">,
    LAST_NAME = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.LAST_NAME#">,
    ADDRESS1 = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.ADDRESS1#">,
    ADDRESS2 = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.ADDRESS2#">,
    CITY = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.CITY#">,
    STATE = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.STATE#">,
    ZIP = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.ZIP#">,
    COUNTRY = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.COUNTRY#">,
    EMAIL_ADDRESS = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.EMAIL_ADDRESS#">,
    TELEPHONE = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.TELEPHONE#">,
    <cfif ARGUMENTS.SW_VERIFIED_BY NEQ "">
    SW_VERIFIED_BY = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.SW_VERIFIED_BY#">,
    SW_VERIFIED_DATE = <cfqueryparam cfsqltype="cf_sql_timestamp" value="#ARGUMENTS.SW_VERIFIED_DATE#">,
    </cfif>
    SW_STAGE_FLAG = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.SW_STAGE_FLAG#">
    WHERE OLD_GC_SERIAL_NUMBER = <cfqueryparam cfsqltype="cf_sql_numeric" value="#ARGUMENTS.OLD_GC_SERIAL_NUMBER#">
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error updating the record.">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>
    
    <cffunction name="deleteGiftCard" access="public" returntype="struct">
    <cfargument name="OLD_GC_SERIAL_NUMBER" type="string" required="yes">
    <cfset result.message = "You have successfully deleted the record(s).">
    <cftry>
    <cftransaction>
    <cfquery datasource="prod1">
    DELETE FROM swsvs.sw_gc_exchange
    WHERE OLD_GC_SERIAL_NUMBER IN (<cfqueryparam cfsqltype="cf_sql_numeric" list="yes" value="#ARGUMENTS.OLD_GC_SERIAL_NUMBER#">)
    </cfquery>
    </cftransaction>
    <cfcatch type="any">
    <cfset result.message = "There was an error deleting the record(s).">
    
    </cfcatch>
    </cftry>
    <cfreturn result>
    </cffunction>    
</cfcomponent>