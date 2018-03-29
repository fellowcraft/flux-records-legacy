<CFQUERY NAME="reviews" DATASOURCE="#ds#">
select * from <cfif IsDefined('url.radio_playlist')>radio<cfelse>reviews</cfif>
where ID = #trim(left(ID,3))#
</CFQUERY>

<CFQUERY NAME="author" DATASOURCE="#ds#">
select * from links
where CompanyName like <cfif IsDefined('url.radio_playlist')>'%#reviews.station#%'<cfelse>'%#reviews.company#%'</cfif>
</CFQUERY>

<!--- <CFINCLUDE TEMPLATE="_loginlogic.cfm"> 
<CFCACHE TIMESPAN="#CreateTimespan(30, 0, 0, 0)#" >
--->
<HTML>

<!-- (c) rothkamm 2004/2006 | rothkamm.com case study | coldfusion 5.0 | dreamweaver mx 7.0 | sql server 2000 | fireworks MX 6.0 | photoshop 8.0 | flash 6.0 | windows 2000 server | -->

<HEAD>
<TITLE><CFOUTPUT>#ds##script_name#</CFOUTPUT></TITLE>
<CFINCLUDE TEMPLATE="_javascript.cfm">
<LINK HREF="css.css" REL="stylesheet" TYPE="text/css">
</HEAD>
<BODY><div id="margin-left:auto; margin-right:auto;">
<div id="menue"><CFINCLUDE TEMPLATE="_menue2.cfm"></div>
<div id="Layer2"><CFINCLUDE TEMPLATE="_header.cfm"></div>
<CFINCLUDE template="_layers.cfm">

<div id="Layer1"><!--- CONTENT --->
<TABLE WIDTH="100%" BORDER="0" ALIGN="right" CELLPADDING="1" CELLSPACING="0"  BGCOLOR="#3F3F3F">
 
  <TR>

    <TD VALIGN="top"><TABLE BORDER="0" WIDTH="100%" CELLPADDING="0" CELLSPACING="0" BGCOLOR="#FFFFFF">
          <TD  ALIGN="LEFT" VALIGN="TOP" CLASS="style1" ><TABLE CELLPADDING="10" CELLSPACING="0" width="100%">
<TR>
<TD VALIGN="TOP" CLASS="style3"><CFOUTPUT QUERY="reviews"><TABLE WIDTH="100%">
<TR>


<TD ROWSPAN="2" ALIGN="CENTER" VALIGN="MIDDLE" CLASS="style2b" nowrap="nowrap"><IMG SRC="pictures/shim.gif" WIDTH="65" HEIGHT="1"><br>
<cfloop list="#lcase(album)#" index="i"><cfscript>
if   (Find('ProjectID',HTTP_REFERER) AND listlen(album) EQ 1) 
     {lnk='javascript:history.back();';} 
else {lnk='http://rothkamm.com?#i#';} 
</cfscript><A HREF="#lnk#"><img src="pictures/back.gif" width="16" height="16" border="0" align="absmiddle"> <IMG SRC="pictures/icons/#Replace(i,' ','_','ALL')#.jpg" BORDER="0" align="absmiddle" > </cfloop></A></TD>

<cfif IsDefined('url.radio_playlist')>

<TD ALIGN="CENTER" VALIGN="BOTTOM" CLASS="style2cc"><IMG SRC="pictures/shim.gif" WIDTH="265" HEIGHT="1"><br><SPAN CLASS="style1b">#trim(DJ)#</SPAN><BR><A HREF="#link#" TARGET="_blank"><IMG SRC="pictures/outlink.gif" WIDTH="13" HEIGHT="10" BORDER="0" ALIGN="ABSMIDDLE"></A> <SPAN CLASS="style1b"><EM>#Ucase(station)#&nbsp;</EM></SPAN><SPAN CLASS="style27">#REReplace(author.city,"[0-9]","","ALL")# - #Ucase(author.country)# - #dateformat(datetime,"YYYY")#</SPAN></TD>

<cfelse>

<TD ALIGN="CENTER" VALIGN="BOTTOM" CLASS="style2cc"><IMG SRC="pictures/shim.gif" WIDTH="265" HEIGHT="1"><br><SPAN CLASS="style1b">#trim(author)#</SPAN><BR><A HREF="#link#" TARGET="_blank"><IMG SRC="pictures/outlink.gif" WIDTH="13" HEIGHT="10" BORDER="0" ALIGN="ABSMIDDLE"></A> <SPAN CLASS="style1b"><EM>#Ucase(company)#&nbsp;</EM></SPAN><SPAN CLASS="style27">#REReplace(author.city,"[0-9]","","ALL")# - #Ucase(author.country)# - #dateformat(datetime,"YYYY")#</SPAN></TD>


</cfif>


</TR>
<TR>
<TD ALIGN="center" VALIGN="buttom" CLASS="style2"><SPAN CLASS="style2cfade">ROTHKAMM <EM>#album#</EM></SPAN></TD>
</TR>
<TR>
<TD COLSPAN="2" CLASS="style1Trans"><br><SPAN CLASS="style5">"</SPAN><BR>
<SPAN CLASS="style3">#REReplace(REReplace(REReplace(text,Chr(9),'&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ','ALL') ,'  ','&nbsp;&nbsp;', 'ALL') ,Chr(10),'<br>','ALL')#</SPAN><br>
<br><SPAN CLASS="style5">"</SPAN></TD>
</TR>
</TABLE></CFOUTPUT>


</TD></TR></TABLE>
<CFINCLUDE TEMPLATE="foot.cfm"></TD>
</TR>
</TABLE></TD>
</TR>
</TABLE></TD></TR></TABLE>
</div>
</BODY>
</HTML>