<CFINCLUDE template="security.cfm">

<!--- <CFIF NOT Find('#adminIP#','#cgi.REMOTE_ADDR#')><CFLOCATION URL="projects.cfm" ADDTOKEN="no"></CFIF> --->


<CFIF IsDefined('submit')>
<CFIF FindNoCase(Trim(submit),'save')>
<CFQUERY DATASOURCE="#ds#">
update news set 
releasedate='#trim(releasedate)#',
body='#trim(body)#',
summary='#trim(summary)#', 
headline='#trim(headline)#',
links='#trim(links)#',
ProjectID='#trim(ProjectID)#',
ProductID='#trim(ProductID)#'
where ID='#ID#'
</CFQUERY>
</CFIF>
<CFIF FindNoCase(Trim(submit),'add')> 
<CFINSERT DATASOURCE="#ds#" TABLENAME="news">
</CFIF>
</CFIF>

<CFQUERY NAME="all" DATASOURCE="#ds#">
select * from news
ORDER BY ReleaseDate DESC
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
  <FORM ACTION="#script_name#" NAME="addit" METHOD="post">
<TR>
<TD><INPUT NAME="releasedate" TYPE="text" CLASS="style2" VALUE='#DateFormat(Now(),"YYYY-MM-DD")#'>
<INPUT NAME="ProjectID" TYPE="text" CLASS="style2" SIZE="3"><INPUT NAME="ProductID" TYPE="text" CLASS="style2" SIZE="3">
<BR>
	<INPUT NAME="headline" TYPE="text" CLASS="style2" VALUE="" MAXLENGTH="200" SIZE="80">
	<TEXTAREA NAME="summary" COLS="72" ROWS="5" CLASS="style1"></TEXTAREA></TD>
<TD ALIGN="right"><INPUT NAME="submit" TYPE="submit" CLASS="style2b" VALUE="add"></TD>
</TR>
<TR>
<TD COLSPAN="2"><TEXTAREA NAME="body" COLS="72" ROWS="20" CLASS="style1"></TEXTAREA>
<BR>
<TEXTAREA NAME="links" COLS="100" ROWS="4" CLASS="style2"></TEXTAREA></TD>
</TR>
<INPUT TYPE="hidden"  NAME="ID" VALUE=''>
</FORM></CFOUTPUT>

<CFOUTPUT QUERY="all">
<FORM ACTION="#script_name#?ID=#ID#" NAME="saveit" METHOD="post">
<TR>
<TD><INPUT NAME="releasedate" TYPE="text" CLASS="style2" VALUE="#DateFormat(releasedate,"YYYY-MM-DD")#" SIZE="30"><INPUT NAME="ProjectID" TYPE="text" CLASS="style2" SIZE="3" VALUE="#ProjectID#" ><INPUT NAME="ProductID" TYPE="text" CLASS="style2" SIZE="3" VALUE="#ProductID#" >
<BR>
<INPUT NAME="headline" TYPE="text" CLASS="style2" VALUE="#Trim(headline)#" MAXLENGTH="200" SIZE="80"><BR>
<TEXTAREA NAME="summary" COLS="72" ROWS="5" CLASS="style1">#Trim(summary)#</TEXTAREA></TD>
<TD ALIGN="right"><INPUT NAME="submit" TYPE="submit" CLASS="style2b" VALUE="save"></TD>
</TR>
<TR>
<TD COLSPAN="2"><TEXTAREA NAME="body" COLS="72" ROWS="20" CLASS="style1">#Trim(body)#</TEXTAREA><BR>
<TEXTAREA NAME="links" COLS="100" ROWS="4" CLASS="style2">#trim(links)#</TEXTAREA></TD>

</TR>
<INPUT TYPE="hidden"  NAME="ID" VALUE='#Trim(ID)#'>
</FORM>
</CFOUTPUT>
</TABLE>
</BODY>
</HTML>
