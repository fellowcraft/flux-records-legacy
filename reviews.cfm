<cfif NOT IsDefined('Album')><cfset Album = ""></cfif>


<CFQUERY NAME="reviews" DATASOURCE="#ds#">
select * from reviews
<cfif Album NEQ "">
where Album = '#Album#' 
</cfif>
ORDER BY DateTime DESC

</CFQUERY>

<CFQUERY NAME="maxAlbums" DATASOURCE="#ds#" CACHEDWITHIN="#CreateTimeSpan(0, 0, 0, 0)#">
SELECT count(distinct(album)) As Freq
FROM reviews
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
<DIV ID="menue"><CFINCLUDE TEMPLATE="_menue2.cfm"></DIV>
<DIV ID="Layer2"><CFINCLUDE TEMPLATE="_header.cfm"></DIV>
<!--- <CFINCLUDE template="_layers.cfm"> --->

<DIV ID="Layer1"><!--- CONTENT --->
<TABLE WIDTH="100%" BORDER="0" ALIGN="right" CELLPADDING="1" CELLSPACING="0"  BGCOLOR="#3F3F3F">
 
  <TR>

    <TD VALIGN="top"><TABLE BORDER="0" WIDTH="100%" CELLPADDING="0" CELLSPACING="0" BGCOLOR="#FFFFFF">
          <TD  ALIGN="LEFT" VALIGN="TOP" CLASS="style1" ><TABLE CELLPADDING="10" CELLSPACING="0" WIDTH="100%">
<TR>
<TD VALIGN="TOP" CLASS="style3"><TABLE BORDER="0" CELLPADDING="0" CELLSPACING="9" WIDTH="100%" BGCOLOR="FFFFFF">

<TR><TD COLSPAN="6" ALIGN="center" BGCOLOR="FFFFFF"><BR><BR><IMG SRC="http://chart.apis.google.com/chart?cht=p&chco=990000|5A5A5A|FFCC33|00AF00|AAAAAA&chd=t:<CFOUTPUT>#reviews.recordcount#,#maxAlbums.Freq#</CFOUTPUT>&chs=400x200&chl=<CFOUTPUT>#reviews.recordcount# reviews|#maxAlbums.Freq# albums</CFOUTPUT>"><BR><BR><BR><BR></TD></TR>

<CFOUTPUT QUERY="reviews">
<TR>
<TD ALIGN="right" VALIGN="top" CLASS="style2"><IMG WIDTH="#Evaluate(Int((580/recordcount)*currentrow))#" HEIGHT="2" SRC="pictures/3F3F3F.gif"></TD>
</TR>

<TR >
<TD CLASS="style3" VALIGN="TOP" ><!--- onMouseOver="this.style.backgroundColor='EBCD29'" onMouseOut='this.style.backgroundColor=""' [#numberformat(currentrow,"00")#] javascript:MM_showHideLayers('Here#currentrow#','','show'); javascript:showreview("#ID#")--->
 <CFLOOP list="#album#" index="i" delimiters=","><A HREF="http://rothkamm.com?#i#"><IMG SRC="pictures/icons/#lcase(Replace(trim(i),' ','_','ALL'))#.jpg" BORDER="0" ALIGN="absmiddle" ></A> <SPAN CLASS="subT1">#i#</SPAN> </CFLOOP><BR>
<!---  [No #Evaluate(abs(recordcount-currentrow)+1)# #DateFormat(DateTime,"YYYY/MM")# ---><A HREF='review.cfm?ID=#ID#'>#tagline#</A>
<BR>
#DateFormat(DateTime,"YYYY")#
<BR>
<IMG SRC="pictures/icon_illustration.gif"> #author# <EM>#Ucase(company)#</EM></TD>
</TR>
<!--- <TR>
  <TD CLASS="style2cTrans" VALIGN="TOP" ><img src="pictures/shim.gif" width="14" height="17"><br>
    <span class="style2cblack">#REReplace(REReplace(REReplace(text,Chr(9),'&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ','ALL') ,'  ','&nbsp;&nbsp;', 'ALL') ,Chr(10),'<br>','ALL')#</span><br>
    <img src="pictures/shim.gif" width="14" height="17"></TD>
</TR> --->

</CFOUTPUT>
</TABLE>


</TD></TR></TABLE></TD>
</TR>
</TABLE></TD>
</TR>
</TABLE></TD></TR></TABLE>
</DIV>

<CFINCLUDE TEMPLATE="foot.cfm">

</BODY>
</HTML>
