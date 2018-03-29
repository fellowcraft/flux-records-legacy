<cfinclude template="security.cfm">

<!--- <CFIF NOT IsDefined('URL.dada')><CFLOCATION URL="projects.cfm" ADDTOKEN="no"></CFIF> --->

<!--- <CFIF IsDefined('edit')><CFLOCATION ADDTOKEN="no" URL="editlog.cfm?PID=#ProjectID#"></CFIF> --->
<!--- <CFIF IsDefined('submit')><CFUPDATE DATASOURCE="#ds#" TABLENAME="reviews"></CFIF> --->

<CFIF IsDefined('submit')>
<CFIF FindNoCase(Trim(submit),'save')>
<CFUPDATE DATASOURCE="#ds#" TABLENAME="reviews">
</CFIF>
<CFIF FindNoCase(Trim(submit),'add')> 
<CFINSERT DATASOURCE="#ds#" TABLENAME="reviews">
</CFIF>
</CFIF>



<CFQUERY NAME="all" DATASOURCE="#ds#">
select * from Reviews
ORDER BY ID DESC
</CFQUERY>




<HTML>


<HEAD>
<TITLE>edit reviews</TITLE>

<LINK HREF="css.css" REL="stylesheet" TYPE="text/css">


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
<CFOUTPUT>
<FORM ACTION="#script_name#" METHOD="post">
<TR>
  <TD CLASS="style3b">ID<BR><!--- <INPUT NAME="ID" TYPE="text" CLASS="style3b" VALUE="" SIZE="30"> ---></TD>
  <TD CLASS="style3b">author<BR><INPUT NAME="author" TYPE="text" CLASS="style2" VALUE=""></TD>
  <TD CLASS="style3b">company<BR><INPUT NAME="company" TYPE="text" CLASS="style2" VALUE=""></TD>
  <TD CLASS="style3b">link<BR><INPUT NAME="link" TYPE="text" CLASS="style2" VALUE=""></TD>
  <TD CLASS="style3b">datetime<BR><INPUT NAME="datetime" TYPE="text" CLASS="style2" VALUE=""></TD>
  <TD CLASS="style3b">media<BR><INPUT NAME="media" TYPE="text" CLASS="style2" VALUE=""></TD>
  <TD CLASS="style3b">album<BR><INPUT NAME="album" TYPE="text" CLASS="style2" VALUE=""></TD>
</TR>
<TR>
<TD COLSPAN="6" CLASS="style3b">tagline<TEXTAREA NAME="tagline" COLS="120" ROWS="1" CLASS="style2"></TEXTAREA></TD>
</TR>
<TR>
<TD COLSPAN="6"><TEXTAREA NAME="Text" COLS="90" ROWS="20" CLASS="style1"></TEXTAREA></TD>
</TR>

<TR>
<TD COLSPAN="6" ALIGN="CENTER"><INPUT NAME="submit" TYPE="submit" CLASS="style2b" VALUE="add" WIDTH="50"><BR><BR></TD>
</TR>



</FORM>
</CFOUTPUT>

<CFOUTPUT QUERY="all">
<FORM ACTION="#script_name#" METHOD="post">
<TR>
  <TD CLASS="style3b">ID<BR>#Trim(ID)#</TD>
  <TD CLASS="style3b">author<BR><INPUT NAME="author" TYPE="text" CLASS="style2" VALUE="#Trim(author)#"></TD>
  <TD CLASS="style3b">company<BR><INPUT NAME="company" TYPE="text" CLASS="style2" VALUE="#Trim(company)#"></TD>
  <TD CLASS="style3b">link<BR><INPUT NAME="link" TYPE="text" CLASS="style2" VALUE="#Trim(link)#"></TD>
  <TD CLASS="style3b">datetime<BR><INPUT NAME="datetime" TYPE="text" CLASS="style2" VALUE="#Trim(datetime)#"></TD>
  <TD CLASS="style3b">media<BR><INPUT NAME="media" TYPE="text" CLASS="style2" VALUE="#Trim(media)#"></TD>
  <TD CLASS="style3b">album<BR><INPUT NAME="album" TYPE="text" CLASS="style2" VALUE="#Trim(album)#"></TD>
 <INPUT NAME="ID" TYPE="hidden" VALUE="#Trim(ID)#">

</TR>

<TR>
<TD COLSPAN="6" CLASS="style3b">tagline<TEXTAREA NAME="tagline" COLS="120" ROWS="1" CLASS="style2">#Trim(tagline)#</TEXTAREA></TD>
</TR>

<TR>
<TD COLSPAN="6"><TEXTAREA NAME="Text" COLS="90" ROWS="20" CLASS="style1">#Trim(Text)#</TEXTAREA></TD>
</TR>

<TR>
<TD COLSPAN="6" ALIGN="CENTER"><INPUT NAME="submit" TYPE="submit" CLASS="style2b" VALUE="save" ><BR><BR></TD>
</TR>

</FORM>
</CFOUTPUT>
</TABLE>


</BODY>
</HTML>
