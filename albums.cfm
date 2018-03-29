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
<!--- ORDER by RAND() --->
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

<BODY >

<DIV CLASS="Layer1" >

<TABLE  
        BORDER="0" 
        ALIGN="center" 
        CELLPADDING="0" 
        CELLSPACING="5"  
        BGCOLOR="FFFFFF"
        >
<cfscript>
prev_year = ""
</cfscript>

<cfoutput query="FluxCDcomposed" startRow="1">

<CFSET URLAlbum = URLencodedFormat(Trim(name)) >

<CFIF (currentrow-1) MOD 3 EQ 0><TR></CFIF>

<CFSET AlbumImage = 'pictures/albumcover/small/#URLencodedFormat(Artist)#-#URLAlbum#.jpg' > 

<CFSET URLAlbum = Replace(URLAlbum,"%20","+","ALL")>

<TD  WIDTH="33.33%"
     ALIGN="CENTER" 
    VALIGN="MIDDLE"
    
    ><A HREF='album.cfm?#URLAlbum#'><IMG CLASS="pic" SRC='#AlbumImage#' BORDER="0" TITLE="#Artist# #name# #NameExt# #Composed#"></A></TD>


<CFIF (currentrow-1) MOD 3 EQ 2></TR></CFIF>
</cfoutput>

</TABLE>
</DIV>
</BODY>
</HTML>
