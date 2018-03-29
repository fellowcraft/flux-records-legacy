<CFQUERY DATASOURCE="#ds#" NAME="websites">
SELECT * FROM websites
</CFQUERY>

<CFQUERY NAME="allstyles" DATASOURCE="#ds#">
SELECT * FROM Style 
ORDER BY Style
</CFQUERY>

<CFQUERY NAME="allparts" DATASOURCE="#ds#">
SELECT * FROM PART
WHERE status <> 0
ORDER BY YEAR DESC, Month DESC, Day DESC
</CFQUERY>

<CFQUERY NAME="FluxCD" DATASOURCE="#ds#">
SELECT  * from Album
<!--- WHERE Released <= '#DateFormat(now(),"YYYY-MM-DD")#' ---> 
</CFQUERY>

<CFQUERY NAME="SoloAlbum" DATASOURCE="#ds#">
SELECT  * from Album
<!--- WHERE Released <= '#DateFormat(now(),"YYYY-MM-DD")#' ---> 
where solo = 1
</CFQUERY>

<CFQUERY NAME="reviews" DATASOURCE="#ds#">
select DateTime,
       ID,
       text,
       album,
       tagline,
       author,
       company
       from reviews 
<!---
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
--->
</CFQUERY>

<HTML>

<HEAD>
<TITLE><CFOUTPUT>LIFE since 1965 #chr(169)# #chr(174)# ROTHKAMM</CFOUTPUT> </TITLE>

<meta name="viewport" content="width=device-width, initial-scale=1.0">

<CFINCLUDE template="favicon.cfm">

<LINK HREF="css.css" REL="stylesheet" TYPE="text/css">
</HEAD>

<CFFILE action="read" FILE="bio.txt" VARIABLE="bio">

<BODY>
<div id="Layer1">
<TABLE WIDTH="80%" BORDER="0" ALIGN="center" CELLPADDING="8" CELLSPACING="0"  BGCOLOR="FFFFFF">

<cfscript>

bio = trim(bio);
bio = REReplace(bio,'#chr(10)#','<br>','ALL');
bio = Replace(bio,'FluxCD','#FluxCD.recordcount#','ALL');
bio = Replace(bio,'SoloAlbum','#SoloAlbum.recordcount#','ALL');
bio = Replace(bio,'allparts','#allparts.recordcount#','ALL');
bio = Replace(bio,'allreviews','#reviews.recordcount#','ALL');

</cfscript>


<TD CLASS="style6">
<CFOUTPUT>#bio#
</CFOUTPUT>
</TD>


<!---

<TD CLASS="style6"><CFOUTPUT>#bio#</CFOUTPUT></TD>

<TD CLASS="style6"><CFINCLUDE template="biotxt.cfm"></TD>

--->

</TR>
</TABLE>
</div>
</BODY>

</HTML>
