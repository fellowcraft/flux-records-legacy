<cfinclude template="security.cfm" >

<CFIF NOT IsDefined('URL.PID')><CFLOCATION URL="projects.cfm" ADDTOKEN="no"></CFIF>


<CFIF IsDefined('submit')>
<CFIF FindNoCase(Trim(submit),'save')>
<CFQUERY DATASOURCE="#ds#">
update ProjectLog set EntryDate='#EntryDate#',ENTRY='#Entry#' where ProjectLogID='#ProjectLogID#'
</CFQUERY>
</CFIF>
<CFIF FindNoCase(Trim(submit),'add')> 
<CFQUERY DATASOURCE="#ds#">
INSERT INTO ProjectLog (EntryDate,Entry,ProjectID) VALUES ('#EntryDate#','#Entry#','#ProjectID#')
</CFQUERY>
</CFIF>
</CFIF>

<CFQUERY NAME="all" DATASOURCE="#ds#">
select * from ProjectLog
where ProjectID = '#PID#'
ORDER BY EntryDate DESC
</CFQUERY>




<HTML>

<!-- (c) rothkamm 2004 | Rothkamm.com case study | coldfusion mx 6.1 | dreamweaver mx 7.0 | sql server 2000 | fireworks MX 6.0 | photoshop 7.0 | windows 2003 server -->


<HEAD>
<TITLE><CFOUTPUT>#now()#</CFOUTPUT></TITLE>

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
<A HREF="edit.cfm?dada" CLASS="style1b">&lt;&lt; projects</A><BR>
<TABLE WIDTH="600" BORDER="0" ALIGN="CENTER" CELLPADDING="0" CELLSPACING="0" BGCOLOR="#E9E9E9">
<CFOUTPUT>
  <FORM ACTION="#script_name#?PID=#PID#" NAME="addit" METHOD="post">
<TR>
<TD><INPUT NAME="EntryDate" TYPE="text" CLASS="style2" VALUE="#DateFormat(Now(),'YYYY-MM-DD')#" SIZE="30"></TD>
<TD ALIGN="right"><INPUT NAME="submit" TYPE="submit" CLASS="style2b" VALUE="add"></TD>
</TR>
<TR>
<TD COLSPAN="2"><TEXTAREA NAME="Entry" COLS="100" ROWS="10" CLASS="style1"></TEXTAREA></TD>
</TR>


<INPUT TYPE="hidden"  NAME="ProjectID" VALUE='#PID#'>
</FORM></CFOUTPUT>

<CFOUTPUT QUERY="all">
<FORM ACTION="#script_name#?PID=#PID#" NAME="saveit" METHOD="post">
<TR>
<TD><INPUT NAME="EntryDate" TYPE="text" CLASS="style2" VALUE="#DateFormat(Trim(EntryDate),'YYYY-MM-DD')#" SIZE="30"></TD>
<TD ALIGN="right"><INPUT NAME="submit" TYPE="submit" CLASS="style2b" VALUE="save"></TD>
</TR>
<TR>
<TD COLSPAN="2"><TEXTAREA NAME="Entry" COLS="100" ROWS="20" CLASS="style1">#Trim(Entry)#</TEXTAREA></TD>
</TR>
<INPUT TYPE="hidden"  NAME="ProjectLogID" VALUE='#Trim(ProjectLogID)#'>
</FORM>
</CFOUTPUT>
</TABLE>
</BODY>
</HTML>
