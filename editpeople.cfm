<CFINCLUDE template="security.cfm">

<!--- <CFIF NOT Find('#adminIP#','#cgi.REMOTE_ADDR#')><CFLOCATION URL="projects.cfm" ADDTOKEN="no"></CFIF> --->
<!--- 
<CFIF IsDefined('edit')><CFLOCATION ADDTOKEN="no" URL="editPeople.cfm?PID=#ProjectID#"></CFIF> --->

<CFSET dmessage = 'no action'>

<CFIF IsDefined('DEmail')>
<CFQUERY NAME="DP" DATASOURCE="#ds#" RESULT="DPr">
DELETE from People 
WHERE  Email = '#trim(Email)#'
</CFQUERY>

<CFQUERY NAME="DC" DATASOURCE="#ds#" RESULT="DCr">
UPDATE CUSTOMERS 
SET Payer_Email = '', status = 1
WHERE  Payer_Email = '#trim(Email)#'
</CFQUERY>

<CFQUERY NAME="DL" DATASOURCE="#ds#" RESULT="DLr">
UPDATE links 
SET Email = ''
WHERE  Email = '#trim(Email)#'
</CFQUERY>

<CFSET dmessage = '#Email# not found'> 

<CFIF DPr.recordcount GT 0><CFSET dmessage = 'Deleted #DPr.recordcount# #Email# in People '></CFIF>
<CFIF DCr.recordcount GT 0><CFSET dmessage = 'Deleted #DCr.recordcount# #Email# in Customers '></CFIF>
<CFIF DLr.recordcount GT 0><CFSET dmessage = 'Deleted #DLr.recordcount# #Email# in Links '></CFIF>

<CFFILE ACTION="append"
        FILE="#GetDirectoryFromPath(GetCurrentTemplatePath())#\logsEditPeople#DateFormat(now(),'YYYYMM')#.txt"
        OUTPUT="#Now()# IP:#REMOTE_ADDR# #dmessage#">

</CFIF>

<CFIF IsDefined('submitPeople')>
<CFQUERY NAME="UP" DATASOURCE="#ds#">
UPDATE People 
SET Email = '#Email#', 
    status   	= '#status#'
WHERE  ID = '#ID#'
</CFQUERY>
</CFIF>

<CFIF IsDefined('submitCustomers')>
<CFQUERY NAME="UC" DATASOURCE="#ds#">
UPDATE CUSTOMERS 
SET Payer_Email = '#Payer_Email#', 
    status   	= '#status#'
WHERE  Payer_ID = '#Payer_ID#'
</CFQUERY>
</CFIF>

<CFIF IsDefined('submitLinks')>
<CFQUERY NAME="UL" DATASOURCE="#ds#">
UPDATE links 
SET Email = '#Email#', 
    status   	= '#status#'
WHERE  linksID = '#linksID#'
</CFQUERY>
</CFIF>

<CFQUERY NAME="all" DATASOURCE="#ds#">
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
where status <> 1
</CFQUERY>

<CFQUERY NAME="People" DATASOURCE="#ds#">
SELECT *
FROM  People
</CFQUERY>

<CFQUERY NAME="CUSTOMERS" DATASOURCE="#ds#">
SELECT payer_email, status, PAYER_ID
FROM  CUSTOMERS
</CFQUERY>

<CFQUERY NAME="links" DATASOURCE="#ds#">
SELECT *
FROM  links
</CFQUERY>



<HTML>

<!-- (c) rothkamm 2004 | Rothkamm.com case study | coldfusion mx 6.1 | dreamweaver mx 7.0 | sql server 2000 | fireworks MX 6.0 | photoshop 7.0 | windows 2003 server -->


<HEAD>
<TITLE>rothkamm - edit People</TITLE>

<HTML>

<!-- (c) rothkamm 2004 | Rothkamm.com case study | coldfusion mx 6.1 | dreamweaver mx 7.0 | sql server 2000 | fireworks MX 6.0 | photoshop 7.0 | windows 2003 server -->


<LINK HREF="css.css" REL="stylesheet" TYPE="text/css">
<HEAD>

<STYLE TYPE="text/css">
<!--
body {
	background-color: 474747;
}
-->
</STYLE></HEAD>

<BODY>
<P>&nbsp;</P>

<TABLE WIDTH="600" BORDER="0" ALIGN="CENTER" CELLPADDING="0" CELLSPACING="0" BGCOLOR="#E9E9E9">
<TR><TD colspan="4">Delete Email</TD></TR>
<FORM ACTION="<CFOUTPUT>#script_name#</CFOUTPUT>" METHOD="post">
<TR>
  <TD><INPUT NAME='Email' TYPE="text" class="style3b" VALUE='' SIZE="50">
<INPUT NAME="DEmail" TYPE="submit" CLASS="style2b" VALUE="Delete">
</TR>
<TR><TD><CFOUTPUT>#dmessage#</CFOUTPUT></TD></TR>
</FORM>
</TABLE>



<TABLE WIDTH="600" BORDER="0" ALIGN="CENTER" CELLPADDING="0" CELLSPACING="0" BGCOLOR="#E9E9E9">
<TR><TD colspan="4">People</TD></TR>
<CFOUTPUT QUERY="People">
<FORM ACTION="#script_name#" METHOD="post">
<TR>
  <TD>#currentrow#</TD>
  <TD><INPUT NAME='Email' TYPE="text" class="style3b" VALUE='#Trim(Email)#' SIZE="50"></TD>
  <TD><INPUT NAME="Status" TYPE="text" class="style3b"  VALUE="#Trim(Status)#" size="2"></TD>
<!---  <TD><INPUT NAME="State" TYPE="text" class="style3b"  VALUE="#Trim(State)#" size="3"></TD> --->
<!--- <TD><INPUT NAME="EndDate" TYPE="text" CLASS="style2" VALUE="#Trim(EndDate)#"></TD> --->
<TD><INPUT NAME="SubmitPeople" TYPE="submit" CLASS="style2b" VALUE="update"></TD>
</TR>
<INPUT TYPE="hidden"  NAME="ID" VALUE='#Trim(ID)#'>
</FORM>
</CFOUTPUT>
</TABLE>

<TABLE WIDTH="600" BORDER="0" ALIGN="CENTER" CELLPADDING="0" CELLSPACING="0" BGCOLOR="#E9E9E9">
<TR><TD colspan="4">CUSTOMERS</TD></TR>
<CFOUTPUT QUERY="CUSTOMERS">
<FORM ACTION="#script_name#" METHOD="post">
<TR>
  <TD>#currentrow#</TD>
  <TD><INPUT NAME='Payer_Email' TYPE="text" class="style3b" VALUE='#Trim(Payer_Email)#' SIZE="50"></TD>
  <TD><INPUT NAME="Status" TYPE="text" class="style3b"  VALUE="#Trim(Status)#" size="2"></TD>
<!---  <TD><INPUT NAME="State" TYPE="text" class="style3b"  VALUE="#Trim(State)#" size="3"></TD> --->
<!--- <TD><INPUT NAME="EndDate" TYPE="text" CLASS="style2" VALUE="#Trim(EndDate)#"></TD> --->
<TD><INPUT NAME="SubmitCustomers" TYPE="submit" CLASS="style2b" VALUE="update"></TD>
</TR>
<INPUT TYPE="hidden"  NAME="Payer_ID" VALUE='#Trim(Payer_ID)#'>
</FORM>
</CFOUTPUT>
</TABLE>

<TABLE WIDTH="600" BORDER="0" ALIGN="CENTER" CELLPADDING="0" CELLSPACING="0" BGCOLOR="#E9E9E9">
<TR><TD colspan="4">links</TD></TR>
<CFOUTPUT QUERY="links">
<FORM ACTION="#script_name#" METHOD="post">
<TR>
  <TD>#currentrow#</TD>
  <TD><INPUT NAME='Email' TYPE="text" class="style3b" VALUE='#Trim(Email)#' SIZE="50"></TD>
  <TD><INPUT NAME="Status" TYPE="text" class="style3b"  VALUE="#Trim(Status)#" size="2"></TD>
<!---  <TD><INPUT NAME="State" TYPE="text" class="style3b"  VALUE="#Trim(State)#" size="3"></TD> --->
    <TD>#CompanyName#</TD>
<TD><INPUT NAME="SubmitLinks" TYPE="submit" CLASS="style2b" VALUE="update"></TD>
</TR>
<INPUT TYPE="hidden"  NAME="LinksID" VALUE='#Trim(LinksID)#'>
</FORM>
</CFOUTPUT>
</TABLE>


</BODY>
</HTML>
