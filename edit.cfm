<cfif NOT IsDefined('client.ClientID')><cfabort></cfif> 
<!--- <CFIF NOT Find('#adminIP#','#cgi.REMOTE_ADDR#')><CFLOCATION URL="projects.cfm" ADDTOKEN="no"></CFIF> --->

<CFIF IsDefined('edit')><CFLOCATION ADDTOKEN="no" URL="editlog.cfm?PID=#ProjectID#"></CFIF>
<CFIF IsDefined('submit')><CFUPDATE DATASOURCE="#ds#" TABLENAME="Project"></CFIF>

<CFQUERY NAME="all" DATASOURCE="#ds#">
select * from Project
ORDER BY Title
</CFQUERY>




<HTML>

<!-- (c) rothkamm 2004 | Rothkamm.com case study | coldfusion mx 6.1 | dreamweaver mx 7.0 | sql server 2000 | fireworks MX 6.0 | photoshop 7.0 | windows 2003 server -->


<HEAD>
<TITLE>Untitled Document</TITLE>

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
<p>&nbsp;</p>
<TABLE WIDTH="600" BORDER="0" ALIGN="CENTER" CELLPADDING="0" CELLSPACING="0" BGCOLOR="#E9E9E9">
<CFOUTPUT QUERY="all">
<FORM ACTION="#script_name#?dada=yes" METHOD="post">
<TR>
<TD class="style3b">#ProjectID#</TD>
  <TD><INPUT NAME="Title" TYPE="text" CLASS="style3b" VALUE="#Trim(Title)#" SIZE="30"></TD>
  <TD><INPUT NAME="Type" TYPE="text" CLASS="style2" VALUE="#Trim(Type)#"></TD>
  <TD><INPUT NAME="status" TYPE="text" CLASS="style2" VALUE="#Trim(Status)#"></TD>
<!--- <TD><INPUT NAME="StartDate" TYPE="text" CLASS="style2" VALUE="#Trim(StartDate)#"></TD>
<TD><INPUT NAME="EndDate" TYPE="text" CLASS="style2" VALUE="#Trim(EndDate)#"></TD> --->
<TD><INPUT NAME="Submit" TYPE="submit" CLASS="style2b" VALUE="save"></TD>
<TD><INPUT NAME="edit" TYPE="submit" CLASS="style2b" ID="edit" VALUE="edit"></TD>
</TR>
<TR>
<TD COLSPAN="4"><TEXTAREA NAME="Concept" COLS="90" ROWS="5" CLASS="style1">#Trim(Concept)#</TEXTAREA></TD>
</TR>
<TR>
<TD COLSPAN="4"><TEXTAREA NAME="Text" COLS="90" ROWS="5" CLASS="style1">#Trim(Text)#</TEXTAREA></TD>
</TR>
<TR>
<TD COLSPAN="4"><TEXTAREA NAME="ZipLink" COLS="90" ROWS="2" CLASS="style1">#Trim(ZipLink)#</TEXTAREA></TD>
</TR>
<INPUT TYPE="hidden"  NAME="ProjectID" VALUE='#Trim(ProjectID)#'>
</FORM>
</CFOUTPUT>
</TABLE>


</BODY>
</HTML>
