<!--- <cfinclude template="_index_queries.cfm"> --->

<cfprocessingdirective pageEncoding="utf-8">

<CFQUERY NAME="reviews" DATASOURCE="#ds#">
select DateTime,
       ID,
       text,
       album,
       tagline,
       author,
       company
       from reviews 
UNION
select ReleaseDate as 'DateTime',
       ID,
       body as 'text',    
       keywords as 'album',
       Headline as 'tagline',  
       ProjectID as 'author',
       links as 'company'
       from news 
where ProjectID > 0
ORDER by DateTime Desc
</CFQUERY>

<CFQUERY NAME="AllReviews" DATASOURCE="#ds#" >
select ID from reviews
</CFQUERY>

<CFQUERY NAME="dupAlbums" DATASOURCE="#ds#" >
select ID from reviews where Album like '%,%';
</CFQUERY>

<CFQUERY NAME="maxAlbums" DATASOURCE="#ds#" >
SELECT distinct(Album) 
FROM reviews
</CFQUERY>

<CFSET ReviewedAlbums = maxAlbums.recordcount-dupAlbums.recordcount>

<CFQUERY NAME="news" DATASOURCE="#ds#">
select * from news
where ProjectID > 0
ORDER BY ReleaseDate DESC
</CFQUERY>

<CFQUERY NAME="newsvals" DATASOURCE="#ds#">
select releasedate from news
where ProjectID > 0
ORDER BY ReleaseDate
</CFQUERY>

<CFQUERY NAME="solo" DATASOURCE="rothkamm">
SELECT  * from Album
where solo = '1' and Released < '#DateFormat(now(),"M-D-YYYY")#'
ORDER by Released DESC
</CFQUERY>

<CFSET METAcontent="#news.Headline#">

<HTML>

<HEAD>
<TITLE><CFOUTPUT>#chr(174)# #AllReviews.recordcount#</CFOUTPUT> ROTHKAMM reviews </TITLE>
<LINK HREF="css.css" REL="stylesheet" TYPE="text/css">

<meta name="viewport" content="width=device-width, initial-scale=1.0">

</HEAD>
<BODY>
<DIV ID="Layer1"><!--- CONTENT --->
<TABLE WIDTH="75%" BORDER="0" ALIGN="CENTER" CELLPADDING="1" CELLSPACING="0"  BGCOLOR="ffffff">

<TR>
<TD ALIGN="center" VALIGN="TOP" COLSPAN="2"><BR><BR><IMG SRC="http://chart.apis.google.com/chart?cht=p&chco=990000|5A5A5A|FFCC33|00AF00|AAAAAA&chd=t:<CFOUTPUT>#AllReviews.recordcount#,#ReviewedAlbums#,#news.recordcount#</CFOUTPUT>&chs=300x150&chl=<CFOUTPUT>#AllReviews.recordcount# reviews|#ReviewedAlbums# CD albums|#news.recordcount# PRs</CFOUTPUT>"><BR><BR><!---<BR><IMG SRC="<cfoutput>#pictures#</cfoutput>/shimblack.gif" WIDTH="100%" HEIGHT="1">---></TD>
</TR>


<CFOUTPUT QUERY="reviews">

<TR>
<TD CLASS="style2" HEIGHT="20" COLSPAN="2"> <SPAN CLASS="style2cfade">#DateFormat(DateTime,"MM/YYYY")#</SPAN></TD>
</TR>

<CFIF album NEQ ''> 

<TR>
<TD CLASS="style3r" VALIGN="TOP" COLSPAN="2">
<CFLOOP list="#album#" index="i" delimiters=","><A HREF="http://rothkamm.com/album.cfm?#i#"><IMG SRC="pictures/icons/generic.jpg" BORDER="0" ALIGN="absmiddle" ></A> <SPAN CLASS="subT1">#i#</SPAN> </CFLOOP>
<BR>
<A HREF='review.cfm?ID=#ID#'>#tagline#</A>
<!---
<BR><BR>
#REReplace(text,'(#Chr(13)##Chr(10)#| #chr(10)#)','<br>','ALL')#
--->
<BR>
<IMG SRC="pictures/icon_illustration.gif"> #author# <EM>#Ucase(company)#</EM></TD>
</TR>

<CFELSE>
<!--- news release --->

<CFIF FileExists('#GetDirectoryFromPath(ExpandPath("*.*"))#press\FluxRecords[#NumberFormat(ID,'00')#].pdf')>
 <CFSET PDFlink = "press/FluxRecords[#NumberFormat(ID,'00')#].pdf">
<CFELSE>
 <CFSET PDFlink = "#ID#">
</CFIF>

<TR onMouseOver="this.style.backgroundColor='EBCD29'" onMouseOut='this.style.backgroundColor=""' >
<TD CLASS="style2cTrans"><A HREF="#PDFlink#"><IMG SRC="press/FluxRecords[#NumberFormat(ID,'00')#].pdf.png"></A></TD>          
<TD VALIGN="middle" CLASS="tiny" ALIGN="center"><A HREF="#PDFlink#">#trim(tagline)#</A><BR>
  <BR>
  Flux Record PDF No. <EM>#Trim(ID)#</EM>|#DateFormat(DateTime, 'm/d/yyyy')#</SPAN></TD>
</TR>
 

</CFIF>
</CFOUTPUT>

</TABLE>
</DIV>
</BODY>
</HTML>
