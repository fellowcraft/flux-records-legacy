
<CFINCLUDE template="/security.cfm">

<CFQUERY DATASOURCE="rothkamm" NAME="all" >
SELECT DISTINCT email
FROM         People
WHERE status <> 1
UNION
SELECT DISTINCT PAYER_EMAIL As 'email'
FROM         CUSTOMERS
WHERE status <> 1
UNION
SELECT DISTINCT email
FROM         links
where status < 1 or status = 2
</CFQUERY>

<!--- <CFOUTPUT>#all.recordcount#</CFOUTPUT> --->
<BR>
<CFIF url.part EQ "1">
<CFLOOP QUERY="all" startRow="1" endRow="#Evaluate(all.recordcount/2)#" ><CFIF REFindNoCase('[0-9a-z\-]@[0-9a-z\-]*\.',email)><CFOUTPUT>#Trim(email)#,</CFOUTPUT></CFIF></CFLOOP>
<CFELSEIF url.part EQ "2">
<CFLOOP QUERY="all" startRow="#Evaluate(all.recordcount/2)#" endRow="#all.recordcount#" ><CFIF REFindNoCase('[0-9a-z\-]@[0-9a-z\-]*\.',email)><CFOUTPUT>#Trim(email)#,</CFOUTPUT></CFIF></CFLOOP>
</CFIF>
