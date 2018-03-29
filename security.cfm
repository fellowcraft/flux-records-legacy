
<CFIF NOT IsDefined('client.clientID')>

<!--- <CFLOCATION url="records.cfm"> --->
404 
<cfabort>
</CFIF>



<CFQUERY NAME="this_client" DATASOURCE="#ds#">
SELECT * FROM CUSTOMERS
WHERE PAYER_ID = '#client.clientID#'
</CFQUERY>

<CFIF (NOT Find("9@lfus.org",this_client.payer_email)) 
     AND 
      (NOT Find("baskaru@outlook.com",this_client.payer_email)) 
       
      
      >
Sorry, <cfoutput>#this_client.payer_email#</cfoutput> is not authorized. 
<cfabort>
<!--- <CFLOCATION url="register.cfm">--->
</CFIF>
