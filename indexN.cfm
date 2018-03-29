
<CFQUERY NAME="all" DATASOURCE="#ds#">
select count(ID) as Parts from PART
WHERE Status <> 0
</CFQUERY>

<CFQUERY NAME="records" DATASOURCE="#ds#">
SELECT  * from Album
</CFQUERY>

<CFQUERY NAME="solo" DATASOURCE="#ds#">
SELECT  * from Album
where solo = '1' 
and Released <= '<CFOUTPUT>#DateFormat(now(),"YYYY-MM-DD")#</CFOUTPUT>'
<!--- ORDER by Composed DESC --->
</CFQUERY>
<CFQUERY NAME="FluxCD" DATASOURCE="#ds#">
SELECT  * from Album
where solo = '1'
<!--- OR label like '%Flux Records%'---> <!--- AND Released > '1994-01-01' --->
AND  Released <= '#DateFormat(now(),"YYYY-MM-DD")#' 
<!--- AND label like '%Flux Records%' OR label like '%Monochrome Vision%' OR label like '%baskaru%' --->
ORDER by Released DESC
</CFQUERY>

<CFQUERY NAME="FluxCDcomposed" DATASOURCE="#ds#">
SELECT  * from Album
<!--- where solo = '1' --->
where Released <= '#DateFormat(now(),"YYYY-MM-DD")#'
ORDER by RIGHT(Composed,4) DESC, Released DESC
<!---- ORDER by RAND() --->
</CFQUERY>


<CFQUERY NAME="A" DATASOURCE="#ds#">
select ID, Status from PART
WHERE Status <> 0
</CFQUERY>


<CFQUERY NAME="FluxCDfuture" DATASOURCE="#ds#">
SELECT  * from Album
where solo = '1'
AND  Released > '#DateFormat(now(),"YYYY-MM-DD")#'
ORDER by RIGHT(Composed,4) DESC,Name DESC
</CFQUERY>

<CFQUERY NAME="other" DATASOURCE="#ds#">
SELECT  * from Album
where solo =  'rem' or solo = 'col' or solo = 'com'
ORDER by RIGHT(Composed,4) DESC,Name DESC
</CFQUERY>

<HTML>

<HEAD>
<TITLE><CFOUTPUT>#records.recordcount# albums #A.recordcount# works ROTHKAMM 1982-#DateFormat(now(),'YYYY')#  
</CFOUTPUT>
</TITLE>

<meta name="viewport" content="width=device-width, initial-scale=1.0">

<CFINCLUDE template="favicon.cfm">

<LINK HREF="css.css" REL="stylesheet" TYPE="text/css"></HEAD>

<BODY>

<DIV ID="Layer1"><!--- CONTENT --->
<TABLE  WIDTH="100%" 
        BORDER="0" 
        ALIGN="right" 
        CELLPADDING="0" 
        CELLSPACING="0"  
        BGCOLOR="FFFFFF">

<!---
<cfoutput query="FluxCD" maxRows="1">
<CFSET URLAlbum = URLencodedFormat(Trim(name)) >
<TR>

<CFSET AlbumImage = 'pictures/albumcover/small/#URLencodedFormat(artist)#-#URLAlbum#.jpg' > 

<TD ALIGN="CENTER" 
    NOWRAP 
    VALIGN="TOP" 
    colspan=3><A HREF='album.cfm?#URLAlbum#'><IMG SRC='#AlbumImage#' WIDTH="280" BORDER="0"></A><br />.</TD>

<TD WIDTH="100%" 
    ALIGN="center" 
    VALIGN="MIDDLE" 
    CLASS="style2bigger" 
    colspan=3><SPAN CLASS="styleTiny">#Evaluate(solo.recordcount + other.recordcount)# of #records.recordcount#<br /><br /></SPAN><A HREF='album.cfm?#URLAlbum#'><STRONG>#name#</STRONG></A><SPAN CLASS="styleTiny"><cfif NameExt neq ''><br /> <br />(#NameExt#)</cfif><BR /> <BR />released <CFIF DateFormat(Released,"YYYYMMDD") LTE DateFormat(now(),"YYYYMMDD")>#DateFormat(Released,"full")#<CFELSE> </CFIF></i></SPAN></TD>

</TR>
</cfoutput>
--->

<cfoutput query="FluxCDcomposed" startRow="1">

<CFSET URLAlbum = URLencodedFormat(Trim(name)) >

<CFIF (currentrow-1) MOD 3 EQ 0><TR></CFIF>

<CFSET AlbumImage = 'pictures/albumcover/small/#URLencodedFormat(Artist)#-#URLAlbum#.jpg' > 

<CFSET URLAlbum = Replace(URLAlbum,"%20","+","ALL")>

<TD  ALIGN="CENTER" 
    VALIGN="TOP"><A HREF='album.cfm?#URLAlbum#'><IMG CLASS="pic" SRC='#AlbumImage#' BORDER="0" TITLE="#Artist# #name# #NameExt# #Composed#"></A></TD>

<CFSCRIPT>

// R = createObject("component","reroth");

<!--- R = ReREplace(Artist,'(Frank Rothkamm|Frank H. Rothkamm|Frank Genius|Frank|rothkamm|ROTHKAMM|Frank Genius|Rothkamm)','#chr(174)#','ALL'); --->
<!---  Reroth = ReREplace(Artist,'(Frank Rothkamm|Frank H. Rothkamm|Frank Genius|Frank|rothkamm|ROTHKAMM|Frank Genius|Rothkamm)','#chr(174)#','ALL'); --->
</CFSCRIPT>

<!---

<TD 
    ALIGN="center" 
    CLASS="style2b">#Artist#<br/><A HREF='album.cfm?#URLAlbum#'><STRONG>#Trim(name)#</STRONG><cfif NameExt neq ''><BR />(#Left(NameExt,40)#)</cfif><BR />#Composed#</A></TD>

--->

<CFIF (currentrow-1) MOD 3 EQ 2></TR></CFIF>
</cfoutput>




</TABLE>

</TABLE><CFINCLUDE TEMPLATE="foot.cfm"></TD>
</TR>
</TABLE>
<BR />
<BR />
<BR />
</DIV>
</BODY>
</HTML>
