<!--- <CFCACHECONTENT ACTION = "cache" CACHENAME = "betaaudio" GROUP = "group1"> --->

<!--- <CFIF NOT IsDefined('client.ClientID')>
<CFSET client.ClientID = "0121BDA5-E147-7A54-F31C6D9989F9BDC6">
</CFIF> --->

<cfif IsDefined('URL.refresh')>
<CFCACHE TIMESPAN="#CreateTimespan(0, 0, 0, 1)#" >
<!--- <cfelse>
<CFCACHE TIMESPAN="#CreateTimespan(30, 0, 0, 0)#" > --->
</cfif>

<!--- <cfflush interval="100"> --->

<CFIF left(CGI.QUERY_STRING,5) EQ 'http:'>
<!--- <cfoutput>#CGI.QUERY_STRING#</cfoutput> <cfabort> --->
<CFLOCATION ADDTOKEN="NO" URL="#CGI.QUERY_STRING#&sa=Search&client=pub-3964018303872303&forid=1&ie=ISO-8859-1&oe=ISO-8859-1&cof=GALT:##008000;GL:1;DIV:##336699;VLC:663399;AH:center;BGC:FFFFFF;LBGC:336699;ALC:0000FF;LC:0000FF;T:000000;GFNT:0000FF;GIMP:0000FF;FORID:1;&hl=en">
</CFIF> 

<!--- <CFINCLUDE TEMPLATE="_loginlogic.cfm"> --->

<CFQUERY NAME="all" DATASOURCE="#ds#">
select count(ID) as Parts from PART
WHERE Status <> 0
</CFQUERY>

<CFQUERY NAME="tracks" DATASOURCE="#ds#">
select * from PART
<CFIF IsDefined('YR')>WHERE year LIKE '%#YR#%'</CFIF>
ORDER BY <CFIF IsDefined('OP')>ID ASC,</CFIF> year DESC, month DESC, day DESC, No DESC
</CFQUERY>

<CFQUERY NAME="tracksASC" DATASOURCE="#ds#">
select * from PART
ORDER BY  year, month, Album, no
</CFQUERY>

<CFQUERY NAME="A" DATASOURCE="#ds#">
select sum(length) as SumTotal from PART
WHERE Status <> 0
</CFQUERY>

<CFSET statusList = "composing,recording,editing,mastering">

<HTML>

<HEAD>
<TITLE><CFOUTPUT>#chr(174)# #all.Parts# works 1982-2017 #chr(169)# #chr(174)# ROTHKAMM</CFOUTPUT></TITLE>
<CFINCLUDE TEMPLATE="_javascript.cfm">

<meta name="viewport" content="width=800">

<LINK HREF="css.css" REL="stylesheet" TYPE="text/css">
</HEAD>

<BODY>  
<div id="margin-left:auto; margin-right:auto;">

<DIV ID="Layer1"><!--- CONTENT --->
<TABLE WIDTH="800" BORDER="0" ALIGN="center" CELLPADDING="1" CELLSPACING="0"  BGCOLOR="FFFFFF">
  <TR>
    <TD VALIGN="TOP" BGCOLOR="FFFFFF"><TABLE WIDTH="100%" BORDER="0" CELLPADDING="0" CELLSPACING="5" BGCOLOR="FFFFFF">


<!--- BACKGROUND="pictures/23.gif" --->
 <TR><TD COLSPAN="9" CLASS="styleTiny" ALIGN="CENTER" VALIGN="BOTTOM"><IMG SRC="pictures/shim.gif" WIDTH="6" HEIGHT="16"><CFLOOP FROM="1982" TO="2018" INDEX="i" step="1"><A HREF="<CFOUTPUT>#script_name#?YR=#i#</CFOUTPUT>"><!--- <IMG SRC="pictures/20.gif" WIDTH="7" HEIGHT="6" border=0> ---><CFOUTPUT>#right(i,2)#</CFOUTPUT></A><IMG SRC="pictures/shim.gif" WIDTH="4" HEIGHT="2"></CFLOOP><!--- <A HREF="<CFOUTPUT>#script_name#?YR=2</CFOUTPUT>">[+]</A> ---></TD>
</TR> 

<TR>
<TD COLSPAN="9" VALIGN="top" BGCOLOR="FFFFFF"  CLASS="style1" ALIGN="CENTER" ><STRONG CLASS="styleTiny"><CFOUTPUT>#all.parts#</CFOUTPUT> works  - <CFOUTPUT>#Evaluate(int((A.SumTotal/60)/60))# hours #Evaluate(int((A.SumTotal/60) mod 60))# minutes #NumberFormat(Evaluate(A.SumTotal mod 60),'00')# seconds</CFOUTPUT></STRONG></TD>
</TR>

<cfscript>
SumTotal = 0;
TimeTotal = 0;

t = ArrayNew(1);
tt = ArrayNew(1); tt[1] = 0;

PrevYear = tracks.year-1;
</cfscript>

<CFLOOP QUERY="tracks" startRow=3  ><cfscript>
if (year LT PrevYear) 
   {ArrayAppend(t,  SumTotal);   SumTotal = 0;
    ArrayAppend(tt, Int(TimeTotal/60)); TimeTotal = 0;
   }
PrevYear = year;
SumTotal = SumTotal + 1;
TimeTotal = TimeTotal + length;
</cfscript></CFLOOP>
<cfscript>ArrayAppend(t, SumTotal); ArrayAppend(tt, Int(TimeTotal/60));</cfscript>

<TR>
<TD COLSPAN="9" CLASS="style2c" ALIGN="CENTER" HALIGN="TOP"> <!---BACKGROUND="pictures/23.gif" ---><cfoutput><cfloop to="1" from="#Evaluate(ArrayLen(t)-3)#" index="i" step="-1" ><IMG SRC="pictures/shimRedBlink.gif" height='#Evaluate(t[i]*6)#' WIDTH="8" Title="|#t[i]#" ><IMG SRC="pictures/shimGold.gif" height='#tt[i+1]/5#' WIDTH="8" Title="-#tt[i+1]#"><IMG SRC="pictures/shim.gif" WIDTH="0" HEIGHT="2"></cfloop></cfoutput></TD>
</TR>

<!--- <TR>
<TD COLSPAN="7" CLASS="style2c" BACKGROUND="pictures/23.gif"><cfloop from="1" to="#ArrayLen(tt)#" index="i" ><IMG SRC="pictures/shimRedBlink.gif" height='<cfoutput>#tt[i]#</cfoutput>' width="23"></cfloop></TD>
</TR> --->

<TR>
<!---<TD VALIGN="top" BGCOLOR="FFFFFF"  ></TD>---> 
<TD VALIGN="top" BGCOLOR="FFFFFF"  CLASS="style2b"  >album</TD>
<TD VALIGN="top" BGCOLOR="FFFFFF"  CLASS="style2b"><A HREF="<CFOUTPUT>#script_name#</CFOUTPUT>">year</A></TD>
<TD VALIGN="top" BGCOLOR="FFFFFF"  CLASS="style2b"  ><A HREF="<CFOUTPUT>#script_name#?OP=1</CFOUTPUT>">opus</A></TD>
<TD VALIGN="top" BGCOLOR="FFFFFF"  CLASS="style2b"  >work</TD>
<!--- <TD VALIGN="top" BGCOLOR="FFFFFF"  CLASS="style2b"  >time</TD> --->
<TD VALIGN="top" BGCOLOR="FFFFFF"  CLASS="style2b" >city</TD>
<!--- <TD VALIGN="top" BGCOLOR="FFFFFF"  CLASS="style2b"  ALIGN="center">OGG</TD> --->
<!--- <TD VALIGN="top" BGCOLOR="FFFFFF"  CLASS="style2b"  ALIGN="center">MP3</TD> --->

<!--- <TD VALIGN="top" BGCOLOR="FFFFFF"  CLASS="style2b"  >stat</TD> --->
<!--- <TD  ALIGN="center" VALIGN="top"  ><IMG SRC="pictures/shim.gif" WIDTH="7" HEIGHT="16"></TD>--->
</TR>



<CFSET SumTotal = 0>
<CFSET PrevYear = tracks.year-1>

<CFOUTPUT QUERY="tracks">  
 
<cfscript> 

// if(NOT IsDefined('client.ClientID')) MP3s = MP3Samples;

MP3ok = 0; 
OGGok = 0; 

For (i=0;i LTE 10; i=i+1){
if(FileExists('#MP3s##Numberformat(ID,"0000")#' & '#Numberformat(i,"00")#' & '.mp3')) 
MP3ok = '#Numberformat(ID,"0000")#' & '#Numberformat(i,"00")#';
};

For (i=0;i LTE 99; i=i+1){
if(FileExists('#OGGs##Numberformat(ID,"0000")#' & '#Numberformat(i,"00")#' & '.ogg')) 
OGGok = '#Numberformat(ID,"0000")#' & '#Numberformat(i,"00")#';
}; 

WorkLength = int(length/60) & ':' & NumberFormat(length mod 60,'00');

if (length GT 3599) {
WorkLength = int(length/3600) & ':' & 
	NumberFormat((length mod 3600)/60,'00') & ':' & 
	NumberFormat(length mod 60,'00');

};
</cfscript>

<cfif year LT PrevYear >

<!--- <TR><TD VALIGN="top" width="23" CLASS="style2" NOWRAP>#year#<IMG SRC="pictures/shim.gif" WIDTH="1" HEIGHT="12" ALIGN="TOP"></TD> MM_showHideLayers('Comment#currentrow#','','show'); MM_showHideLayers('Comment#currentrow#','','hide');--->

<TR><TD COLSPAN="7"><IMG SRC="pictures/shimblack.gif" WIDTH="100%" HEIGHT="1"></TD></TR>
</cfif>
<CFSET PrevYear = year>
<!--- onMouseOver="this.style.backgroundColor='dddddd'" onMouseOut="this.style.backgroundColor=''" --->
 <TR  >
 

<!------------------------------------- Work----------------------------------------------------------- --->
<TD ALIGN="RIGHT" VALIGN="top" CLASS="style2fade" >
<CFIF trim(album) NEQ ''>
<CFLOOP list="#album#" delimiters="," index="calbum">

<CFQUERY NAME="thisArtist" DATASOURCE="#ds#">
select artist from Album
WHERE Name like "%#calbum#%"
</CFQUERY>

 <CFSET WebName = Replace(trim(calbum)," ","+","ALL")>
 <A HREF='album.cfm?#WebName#'>#calbum#
<!---
<CFIF FileExists('#GetDirectoryFromPath(ExpandPath("*.*"))#pictures/albumcover/small/#thisArtist.artist#-#Trim(calbum)#.jpg')>
  <IMG SRC="pictures/albumcover/small/#thisArtist.artist#-#calbum#.jpg" ALIGN="ABSMIDDLE" BORDER="0" HEIGHT="32" Title='Icon for "#trim(calbum)#"'>
 <CFELSE>
  <IMG SRC="pictures/icons/noalbum.jpg"  height="24" ALIGN="ABSMIDDLE" BORDER="0" Title='No Icon for "#trim(calbum)#"'> </A>
  </CFIF>--->
 <br /> 
</CFLOOP>
</CFIF></TD>


<!---<TD ALIGN="LEFT" VALIGN="top" CLASS="style3c" ><b>#album#<b/></TD>--->

 <TD VALIGN="top" NOWRAP   CLASS="style2"><!--- <IMG SRC="pictures/20.gif" WIDTH="8" HEIGHT="6"> --->#Right(year,4)#<IMG SRC="pictures/shim.gif" WIDTH="1" HEIGHT="12" ALIGN="TOP"></TD>

<TD ALIGN="CENTER" VALIGN="top"   CLASS="style2"  ><STRONG>#ID#</STRONG></TD>
<!---
<CFSET google_string = '"' & Replace(TRIM(name),' ','+','ALL') & '"' & '+' & REReplace(TRIM(artist),'(,| )','+','ALL')>
<cfset MP3Location = 'MP3320'>
--->


<TD VALIGN="top" CLASS="style3c"><!---<A HREF='work.cfm?opus=#ID#'>---><CFIF MP3ok GT 1><a href="MP3320/#MP3ok#.mp3"></CFIF><CFIF status EQ 0><strike></CFIF><B>#name#</B><!---</A>---> <SPAN CLASS="style2cfade">#WorkLength#</SPAN><br>
    <span class="style2cfade">#artist#<!---#ReReplace(Replace(artist,","," ","ALL"),"(Frank Rothkamm|Frank H. Rothkamm)","#chr(174)#")#--->
        <CFIF len(trim(sample)) GT 1>
          ( sample by: #sample# )
        </CFIF>
    </span>      <!--- <cfif status LT 3> <EM>unfinished</EM></cfif> ---></TD>
 
 
<TD VALIGN="top" CLASS="style2cfade"  >#Replace(city,",","<br>")# </TD>


<!---
<TD VALIGN="top" NOWRAP   CLASS="style2cfade" ALIGN="CENTER" ><CFIF OGGok  GT 1><a href="OGG/#OGGok#.ogg"><IMG SRC="pictures/download_3.gif" WIDTH="24" HEIGHT="24" BORDER="0" ALIGN="ABSMIDDLE" CLASS="style3" title='[DOWNLOAD] #artist# "#trim(name)#"' ID="#ID#"></a></CFIF></TD>
--->

<!---
<TD VALIGN="top" NOWRAP   CLASS="style2cfade" ALIGN="center" ><CFIF MP3ok GT 1><a href="MP3320/#MP3ok#.mp3"><IMG SRC="pictures/download_3.gif" WIDTH="24" HEIGHT="24" BORDER="0" ALIGN="ABSMIDDLE" CLASS="style3" title='[DOWNLOAD] #artist# "#trim(name)#"' ID="#ID#"></a></CFIF></TD>
--->

<!--- <TD ALIGN="right" VALIGN="top" CLASS="style3" ><A href='http://www.google.com/custom?q=#google_string#' TARGET="_blank"><IMG SRC="pictures/google.gif" ALT="Google track" WIDTH="16" HEIGHT="16" BORDER="0" Title='[GOOGLE] #google_string#'></A></TD> --->





<!---
<TD ALIGN="RIGHT" VALIGN="middle" CLASS="style3"><!--- <CFIF status EQ 5> --->
  <CFIF MP3ok EQ 1><A HREF='javascript:return();' TARGET="PlayerFrame"><IMG SRC="pictures/icon_audio.gif" WIDTH="12" HEIGHT="12" BORDER="0" ALIGN="ABSMIDDLE" CLASS="style3" title='[PLAY] #artist# "#trim(name)#"' ID="#ID#" onClick="<CFIF IsDefined('client.ClientID')>PlayMP3(#ID#);<CFELSE>javascript:loginmsg();</CFIF>" ></A>
    <CFELSE>&nbsp;</CFIF><!--- <IMG SRC="pictures/icon_audio.gif" WIDTH="12" HEIGHT="12" BORDER="0" ALIGN="ABSMIDDLE" CLASS="style3"></A>
</CFIF> ---></TD>
--->

 </TR>


<CFSET SumTotal = SumTotal + length>
</CFOUTPUT> 	

<TR>
 <TD COLSPAN="9"><IMG SRC="pictures/shim.gif" WIDTH="10" HEIGHT="5"></TD>
</TR> 
</TABLE></TD>
</TR>
</TABLE></TD></TR></TABLE>

</DIV> 
</BODY>


</HTML>
