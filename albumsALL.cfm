<!--- --->

<cfinclude template="_index_queries.cfm">

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

<!---
<CFQUERY NAME="com" DATASOURCE="#ds#">
SELECT  * from Album
where solo =  'com'
ORDER by Released DESC
</CFQUERY>

<CFQUERY NAME="col" DATASOURCE="#ds#">
SELECT  * from Album
where solo =  'col' 
ORDER by Released DESC
</CFQUERY>

<CFQUERY NAME="rem" DATASOURCE="#ds#">
SELECT  * from Album
where solo =  'rem' 
ORDER by Released DESC
</CFQUERY> --->

<CFQUERY NAME="FluxCD" DATASOURCE="#ds#">
SELECT  * from Album
<!--- AND label like '%Flux Records%' OR label like '%Monochrome Vision%' OR label like '%baskaru%' --->

where  Released <= '#DateFormat(now(),"YYYY-MM-DD")#'
ORDER by Released DESC
</CFQUERY>

<CFQUERY NAME="FluxCDcomposed" DATASOURCE="#ds#">
SELECT  * from Album
ORDER by RIGHT(Composed,4) DESC,Name DESC
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
<TITLE>Frank Rothkamm <CFOUTPUT>
#records.recordcount# albums #solo.recordcount# solo #other.recordcount# for or with others #Evaluate(records.recordcount - solo.recordcount - other.recordcount)# in production composed 1982-#DateFormat(now(),'YYYY')#
<!--- 1986-#DateFormat(FluxCD.Released,"YYYY")#--->
</CFOUTPUT>
</TITLE>

<meta name="viewport" content="width=622">

<CFINCLUDE TEMPLATE="_javascript.cfm">

<LINK HREF="css.css" REL="stylesheet" TYPE="text/css"></HEAD>

<BODY>
<div id="margin-left:auto; margin-right:auto;">
<CFINCLUDE template="_layers.cfm">

<DIV ID="Layer1"><!--- CONTENT --->
<TABLE  WIDTH="100%" 
        BORDER="0" 
        ALIGN="right" 
        CELLPADDING="1" 
        CELLSPACING="0"  
        BGCOLOR="3F3F3F">

<TR>
 <TD VALIGN="TOP" 
        BGCOLOR="3F3F3F"><!---<IMG SRC="pictures/cover/frank_rothkamm_wiener_process.jpg" WIDTH="622" HSPACE="0" VSPACE="0">---><TABLE 
        WIDTH="100%" 
        BORDER="0" 
        CELLPADDING="0" 
        CELLSPACING="5" 
        BGCOLOR="FFFFFF">

<TR>
 <TD   COLSPAN="5" 
        ALIGN="center"><TABLE 
        BORDER="0"  
        CELLPADDING="0" 
        CELLSPACING="8" 
        BACKGROUND="pictures/shimWhiteChecker.gif">

<TR>
 <TD COLSPAN="6"><IMG SRC="pictures/shim.gif" WIDTH="100%" HEIGHT="1"></TD>
</TR>

<!---
<TR>
<TD COLSPAN="6" 
    CLASS="style3b"><IMG SRC="pictures/shim.gif" WIDTH="56"
HEIGHT="40"><EM CLASS="secHeadmedia1">FRANK ROTHKAMM</EM></TD>
</TR>
<TR>
<TD COLSPAN="6"><IMG SRC="pictures/shim.gif" WIDTH="100%" HEIGHT="1"></TD>
</TR>
--->


<cfoutput query="FluxCD" maxRows="1">
<TR>

<CFIF FileExists('#GetDirectoryFromPath(ExpandPath("*.*"))#pictures/albumcover/small/#artist#-#Name#.jpg')>
<CFSET AlbumImage = 'pictures/albumcover/small/#artist#-#URLencodedFormat(Name)#.jpg' > 
<CFELSE>
<CFSET AlbumImage = 'pictures/albumcover/small/genericcd.jpg'>
</CFIF>

<TD ALIGN="CENTER" 
    NOWRAP 
    VALIGN="TOP" 
    colspan=3><A HREF='album.cfm?#Replace(name," ","-","ALL")#'><IMG SRC='#AlbumImage#' WIDTH="280" BORDER="0"></A><br />.</TD>

<TD WIDTH="94" 
    ALIGN="center" 
    VALIGN="MIDDLE" 
    CLASS="style2bigger" 
    colspan=3><SPAN CLASS="styleTiny">#Evaluate(solo.recordcount + other.recordcount)# of #records.recordcount#<br /><br /></SPAN><A HREF='album.cfm?#Replace(name," ","-","ALL")#'><STRONG>#name#</STRONG></A><SPAN CLASS="styleTiny"><cfif NameExt neq ''><br /> <br />(#NameExt#)</cfif><BR /> <BR />released <CFIF DateFormat(Released,"YYYYMMDD") LTE DateFormat(now(),"YYYYMMDD")>#DateFormat(Released,"full")#<CFELSE> </CFIF></i></SPAN></TD>

</TR>
</cfoutput>


<cfoutput query="FluxCDcomposed" startRow="1">
<CFIF (currentrow-1) MOD 3 EQ 0><TR></CFIF>

<CFIF FileExists('#GetDirectoryFromPath(ExpandPath("*.*"))#pictures/albumcover/small/#Trim(artist)#-#Trim(Name)#.jpg')>
<CFSET AlbumImage = 'pictures/albumcover/small/#Trim(artist)#-#URLencodedFormat(Trim(Name))#.jpg' > 
<CFELSE>
<CFSET AlbumImage = 'product/small/genericcd.jpg'>
</CFIF>

<TD  ALIGN="CENTER" 
    NOWRAP VALIGN="TOP"><A HREF='album.cfm?#Replace(Trim(name)," ","-","ALL")#'><IMG SRC='#AlbumImage#' WIDTH="96" BORDER="0"></A></TD>

<TD WIDTH="94" 
    ALIGN="center" 
    CLASS="style2b">#Artist#<br /><A HREF='album.cfm?#Replace(Trim(name)," ","-","ALL")#'><STRONG>#Trim(name)#</STRONG><cfif NameExt neq ''><BR />(#Left(NameExt,40)#)</cfif></A><BR /><SPAN CLASS="styleTiny">#Composed#</SPAN></TD>

<CFIF (currentrow-1) MOD 3 EQ 2></TR></CFIF>
</cfoutput>



</TABLE>

</TABLE><!---<CFINCLUDE TEMPLATE="foot.cfm">---></TD>
</TR>
</TABLE>
<BR />
<IMG SRC="pictures/shim.gif" WIDTH="100" HEIGHT="50">
</DIV>
</BODY>
</HTML>
