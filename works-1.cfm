<!--- <CFCACHECONTENT ACTION = "cache" CACHENAME = "betaaudio" GROUP = "group1"> --->

<cfinclude template="_index_queries.cfm">

<!--- <CFIF NOT IsDefined('client.ClientID')>
<CFSET client.ClientID = "0121BDA5-E147-7A54-F31C6D9989F9BDC6">
</CFIF> --->

<cfif IsDefined('URL.refresh')>
<CFCACHE TIMESPAN="#CreateTimespan(0, 0, 0, 1)#" >
<!--- <cfelse>
<CFCACHE TIMESPAN="#CreateTimespan(30, 0, 0, 0)#" > --->
</cfif>

<!--- <cfflush interval="100"> --->

<!--- <center>
<form method="get" action="http://www.google.com/custom" target="_top">
<table bgcolor="#ffffff">
<tr><td nowrap="nowrap" valign="top" align="left" height="32">
<a href="http://www.google.com/">
<img src="http://www.google.com/logos/Logo_25wht.gif" border="0" alt="Google" align="middle"></img></a>
<input type="text" name="q" size="31" maxlength="255" value=""></input>
<input type="submit" name="sa" value="Search"></input>
<input type="hidden" name="client" value="pub-3964018303872303"></input>
<input type="hidden" name="forid" value="1"></input>
<input type="hidden" name="ie" value="ISO-8859-1"></input>
<input type="hidden" name="oe" value="ISO-8859-1"></input>
<input type="hidden" name="cof" value="GALT:#008000;GL:1;DIV:#336699;VLC:663399;AH:center;BGC:FFFFFF;LBGC:336699;ALC:0000FF;LC:0000FF;T:000000;GFNT:0000FF;GIMP:0000FF;FORID:1;"></input>
<input type="hidden" name="hl" value="en"></input>
</td></tr></table>
</form>
</center> --->

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
<TITLE>Frank Rothkamm | <CFOUTPUT>#all.Parts#</CFOUTPUT> works | 1982-2016</TITLE>
<CFINCLUDE TEMPLATE="_javascript.cfm">

<meta name="viewport" content="width=622">

<LINK HREF="css.css" REL="stylesheet" TYPE="text/css">
</HEAD>

<BODY>  
<div id="margin-left:auto; margin-right:auto;">
<DIV ID="Layer2"><CFINCLUDE TEMPLATE="_header.cfm"></DIV>
<CFINCLUDE template="_layers.cfm">

<DIV ID="Layer1"><!--- CONTENT --->
<TABLE WIDTH="100%" BORDER="0" ALIGN="right" CELLPADDING="1" CELLSPACING="0"  BGCOLOR="#3F3F3F">
  <TR>
    <TD VALIGN="TOP" BGCOLOR="#3F3F3F"><TABLE WIDTH="100%" BORDER="0" CELLPADDING="0" CELLSPACING="5" BGCOLOR="#FFFFFF">


<!--- BACKGROUND="pictures/23.gif" --->
 <TR><TD COLSPAN="9" CLASS="style2b" ALIGN="CENTER" VALIGN="BOTTOM"><IMG SRC="pictures/shim.gif" WIDTH="6" HEIGHT="16"><CFLOOP FROM="1982" TO="2016" INDEX="i" step="1"><A HREF="<CFOUTPUT>#script_name#?YR=#i#</CFOUTPUT>"><!--- <IMG SRC="pictures/20.gif" WIDTH="7" HEIGHT="6" border=0> ---><CFOUTPUT>#right(i,2)#</CFOUTPUT></A><IMG SRC="pictures/shim.gif" WIDTH="4" HEIGHT="2"></CFLOOP><!--- <A HREF="<CFOUTPUT>#script_name#?YR=2</CFOUTPUT>">[+]</A> ---></TD>
</TR> 

<TR>
<TD COLSPAN="9" VALIGN="top" BGCOLOR="#FFFFFF"  CLASS="style1" ALIGN="CENTER" ><STRONG CLASS="styleTiny"><CFOUTPUT>#all.parts#</CFOUTPUT> works  - <CFOUTPUT>#Evaluate(int((A.SumTotal/60)/60))# hours #Evaluate(int((A.SumTotal/60) mod 60))# minutes #NumberFormat(Evaluate(A.SumTotal mod 60),'00')# seconds</CFOUTPUT></STRONG></TD>
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
 <TD VALIGN="top" BGCOLOR="#FFFFFF"  CLASS="style2b"><A HREF="<CFOUTPUT>#script_name#</CFOUTPUT>">year</A></TD>
 <TD VALIGN="top" BGCOLOR="#FFFFFF"  CLASS="style2b"  ><A HREF="<CFOUTPUT>#script_name#?OP=1</CFOUTPUT>">opus</A></TD>
<TD VALIGN="top" BGCOLOR="#FFFFFF"  CLASS="style2b"  >album</TD>
<TD VALIGN="top" BGCOLOR="#FFFFFF"  CLASS="style2b"  >work<!--- <IMG SRC="pictures/shim.gif" WIDTH="160" HEIGHT="1" ALIGN="RIGHT"> ---></TD>
<!--- <TD VALIGN="top" BGCOLOR="#FFFFFF"  CLASS="style2b"  >time</TD> --->
<TD VALIGN="top" BGCOLOR="#FFFFFF"  CLASS="style2b"  >city</TD>

<!--- <TD VALIGN="top" BGCOLOR="#FFFFFF"  CLASS="style2b"  >stat</TD> --->
<!--- <TD  ALIGN="center" VALIGN="top"  ><IMG SRC="pictures/shim.gif" WIDTH="7" HEIGHT="16"></TD>--->
</TR>



<CFSET SumTotal = 0>
<CFSET PrevYear = tracks.year-1>

<CFOUTPUT QUERY="tracks">  
<!--- <cfif NOT Find( --->
 
<cfif year LT PrevYear >

<!--- <TR><TD VALIGN="top" width="23" CLASS="style2" NOWRAP>#year#<IMG SRC="pictures/shim.gif" WIDTH="1" HEIGHT="12" ALIGN="TOP"></TD> MM_showHideLayers('Comment#currentrow#','','show'); MM_showHideLayers('Comment#currentrow#','','hide');--->

<TR><TD COLSPAN="5"><IMG SRC="pictures/shimblack.gif" WIDTH="100%" HEIGHT="1"></TD></TR>
</cfif>
<CFSET PrevYear = year>
<!--- onMouseOver="this.style.backgroundColor='dddddd'" onMouseOut="this.style.backgroundColor=''" --->
 <TR  >
 
 <TD ROWSPAN="2" VALIGN="top" NOWRAP   CLASS="style2"><!--- <IMG SRC="pictures/20.gif" WIDTH="8" HEIGHT="6"> --->#Right(year,4)#<IMG SRC="pictures/shim.gif" WIDTH="1" HEIGHT="12" ALIGN="TOP"></TD>

<TD ALIGN="CENTER" VALIGN="top"   CLASS="style3"  ><STRONG>#ID#</STRONG></TD>

<CFSET google_string = '"' & Replace(TRIM(name),' ','+','ALL') & '"' & '+' & REReplace(TRIM(artist),'(,| )','+','ALL')>

<!--- <cfscript>
if ( find('Frank Genius',artist) or find('Frank Rothkamm',artist) or find('Frank H. Rothkamm',artist) or find('Frank H. Rothkamm',artist) )  collaborator = '';  
</cfscript>  --->



<!--- <CFIF IsDefined('client.ClientID')>
 <CFIF client.ClientID EQ "0121BDA5-E147-7A54-F31C6D9989F9BDC6">  --->  
<cfset MP3Location = 'MP3320'>
<!--- <cfset MP3s = MP3L>  --->
<!---  <CFELSE>
  <cfset MP3Location = 'MP3'>
  <cfset MP3s = MP3s>
 </CFIF> 
</CFIF> --->


<cfscript> 

// if(NOT IsDefined('client.ClientID')) MP3s = MP3Samples;

MP3ok = 0; 

For (i=0;i LTE 10; i=i+1){
if(FileExists('#MP3L##Numberformat(ID,"0000")#' & '#Numberformat(i,"00")#' & '.mp3')) 
MP3ok = 1;
};

</cfscript>


 
 <!--- <TD VALIGN="top" CLASS="style3c" >
  <CFIF MP3ok EQ 1><A HREF='javascript:return();' title='[PLAY] #artist# "#trim(name)#"' onClick="<CFIF IsDefined('client.ClientID')>top.frames['PlayerFrame'].location.href='playwork.cfm?mp3=#ID#'<CFELSE>javascript:loginmsg();</CFIF>"></CFIF>
   <CFIF status EQ 0><strike></CFIF><B>#name#</B></A> <SPAN CLASS="Tiny">#Evaluate(int(length/60))#:#NumberFormat(Evaluate(length mod 60),'00')#</SPAN><cfif status LT 3> <EM>unfinished</EM></cfif></TD>
 --->

<!--- album icon --->
<TD ALIGN="center" VALIGN="middle" CLASS="style3" ><CFIF trim(album) NEQ ''><CFLOOP list="#album#" delimiters="," index="calbum"><CFSET album_icon = REReplace(trim(lcase(calbum)),"( |,)","_","all")><A HREF='http://rothkamm.com/album.cfm?#REReplace(trim(calbum),"( |,)","-","all")#'><CFIF FileExists('#GetDirectoryFromPath(ExpandPath("*.*"))#pictures/icons/#album_icon#.jpg')><IMG SRC="pictures/icons/#URLencodedFormat(album_icon)#.jpg" ALIGN="ABSMIDDLE" BORDER="0" Title='Released on album "#trim(calbum)#"'><CFELSE><IMG SRC="pictures/icons/noalbum.jpg" width="30"  height="30" ALIGN="ABSMIDDLE" BORDER="0" Title='To be released on album "#trim(calbum)#"'> </A></CFIF></CFLOOP></CFIF></TD>

<cfscript>
WorkLength = int(length/60) & ':' & NumberFormat(length mod 60,'00');

if (length GT 3599) {
WorkLength = int(length/3600) & ':' & 
	NumberFormat((length mod 3600)/60,'00') & ':' & 
	NumberFormat(length mod 60,'00');

};

</cfscript>

<TD VALIGN="top" CLASS="style3c"><A HREF='work.cfm?opus=#ID#'><CFIF status EQ 0><strike></CFIF><B>#name#</B></A> <SPAN CLASS="style2cfade">#WorkLength#</SPAN><!--- <cfif status LT 3> <EM>unfinished</EM></cfif> ---></TD>
 
 
 
<!--- <CFQUERY DATASOURCE="#ds#" NAME="ThisID">SELECT ProjectID FROM Project WHERE title like '%#trim(Album)#%'</CFQUERY> --->

<!--- <TD VALIGN="top" CLASS="style3" onMouseOver="this.style.backgroundColor='EBCD29'" onMouseOut='this.style.backgroundColor=""'><A HREF="projectdetail.cfm?ProjectID=#ThisID.ProjectID#">#UCase(left(album,4))#</A></TD> --->

<!--- <CFQUERY DATASOURCE="#ds#" NAME="hits" >
SELECT   COUNT(MP3) AS FREQ
FROM     playlists
WHERE    MP3 like '#trim(ID)#'
</CFQUERY> --->

<TD VALIGN="top" NOWRAP   CLASS="style2cfade"  >#Replace(city,",","<br>")# <!--- #hits.FREQ# ---></TD>

<!--- <TD ALIGN="right" VALIGN="top" CLASS="style3" ><A href='http://www.google.com/custom?q=#google_string#' TARGET="_blank"><IMG SRC="pictures/google.gif" ALT="Google track" WIDTH="16" HEIGHT="16" BORDER="0" Title='[GOOGLE] #google_string#'></A></TD> --->





<!---
<TD ALIGN="RIGHT" VALIGN="middle" CLASS="style3"><!--- <CFIF status EQ 5> --->
  <CFIF MP3ok EQ 1><A HREF='javascript:return();' TARGET="PlayerFrame"><IMG SRC="pictures/icon_audio.gif" WIDTH="12" HEIGHT="12" BORDER="0" ALIGN="ABSMIDDLE" CLASS="style3" title='[PLAY] #artist# "#trim(name)#"' ID="#ID#" onClick="<CFIF IsDefined('client.ClientID')>PlayMP3(#ID#);<CFELSE>javascript:loginmsg();</CFIF>" ></A>
    <CFELSE>&nbsp;</CFIF><!--- <IMG SRC="pictures/icon_audio.gif" WIDTH="12" HEIGHT="12" BORDER="0" ALIGN="ABSMIDDLE" CLASS="style3"></A>
</CFIF> ---></TD>
--->

<!---
<TD ALIGN="RIGHT" VALIGN="middle" CLASS="style3"><CFIF MP3ok EQ 1><A  HREF="javascript:ShowViewCart('AddToCart=true&opus=#ID#')"><IMG SRC="pictures/cart.gif" ALT="Buy Now" WIDTH="15" HEIGHT="11" BORDER="0" TITLE="[BUY] #trim(artist)#-#trim(name)#.mp3"></A></CFIF></TD>
--->

 </TR>
 <TR>
   <TD ALIGN="CENTER" VALIGN="top"   CLASS="style3"  >&nbsp;</TD>
   <TD VALIGN="top" CLASS="style3c" >&nbsp;<!--- <br /><img src="pictures/shim.gif" width="20" height="5"> ---></TD>
   <TD VALIGN="top" CLASS="style2cfade"  >#Replace(artist,","," ","ALL")#<CFIF len(trim(sample)) GT 1> <SPAN CLASS="style2cfade">( sample by: #sample# )</SPAN></CFIF></TD>
   <TD ALIGN="RIGHT" VALIGN="top" CLASS="style3">&nbsp;</TD>
<!---    <TD ALIGN="RIGHT" VALIGN="top" CLASS="style3">&nbsp;</TD> --->
 </TR>

<CFSET SumTotal = SumTotal + length>
</CFOUTPUT> 	

<TR>
 <TD COLSPAN="5"><IMG SRC="pictures/shim.gif" WIDTH="10" HEIGHT="10"></TD>
<!--- <TD ><!--- <CFOUTPUT>#tracks.recordcount# tracks</CFOUTPUT> ---></TD>
<TD <!--- <CFOUTPUT>#Evaluate(int((SumTotal/60)/60))#:#Evaluate(int((SumTotal/60) mod 60))#:#NumberFormat(Evaluate(SumTotal mod 60),'00')#</CFOUTPUT> ---></TD>--->

</TR> 
</TABLE></TD>
</TR>
</TABLE></TD></TR></TABLE>
<!--- <IFRAME SRC="blank.html" HEIGHT="1" WIDTH="500" FRAMEBORDER="0" NAME="PlayerFrame" ></IFRAME> --->
<!------------------------------ Comments ---->
<!--- <CFOUTPUT QUERY="tracks" >
<!--- <CFIF album NEQ ''> --->
<DIV ID="Comment#currentrow#" STYLE="position:absolute; margin-left: -300px; left:50%;  top:#Evaluate(currentrow*19+20)#; z-index: 1; visibility: hidden;" onMouseOver="MM_showHideLayers('Comment#currentrow#','','show')" onMouseOut="MM_showHideLayers('Comment#currentrow#','','hide')" ><Table BORDER="0" CELLPADDING="0" CELLSPACING="10" WIDTH="600" HEIGHT="200" BACKGROUND="pictures/shimWhiteChecker.gif" CLASS="style2bTrans">
<TR><TD ALIGN="CENTER" VALIGN="TOP"><CFIF status GTE 4><IMG SRC="product/sm/#trim(album)#CD.jpg" ALIGN="ABSMIDDLE"></CFIF><IMG SRC="pictures/3F3F3F.gif" WIDTH="1" HEIGHT="170" ALIGN="ABSMIDDLE"><SPAN CLASS="style2b">#month#/#day#/#year#</SPAN><IMG SRC="pictures/3F3F3F.gif" WIDTH="#Evaluate(max(length/10,1))#" HEIGHT="168" ALIGN="ABSMIDDLE"><SPAN CLASS="style2b">#Evaluate(int(length/60))#:#NumberFormat(Evaluate(length mod 60),'00')#</SPAN></TD></TR>

<TR><TD ALIGN="CENTER"><SPAN CLASS="style3Trans"><STRONG><EM>#trim(album)#</EM> #name#</STRONG></SPAN></TD>
</TR>

<TR>
<TD CLASS="style2c"><CFIF status LT 4>"<EM>#name#</EM> &lt;beta version&gt; is still UNFINISHED or in its 2ND FORM - composition, recording and editing are somewhat close to completion, but no spatialization or TRIPHONY (movement of sounds in 3D space) is present."</CFIF></TD>
</TR>

<TR>
<TD ALIGN="right" VALIGN="buttom" NOWRAP CLASS="style2bTrans"  HEIGHT="9"><A HREF="javascript:MM_showHideLayers('Comment#currentrow#','','hide');" TITLE="close"><SPAN CLASS="style3Trans"><IMG SRC="pictures/remove.gif" WIDTH="9" HEIGHT="9" BORDER="0" ALIGN="bottom"></SPAN></A></TD>
</TR></Table></DIV>
</CFIF> 
</CFOUTPUT> --->
 
</DIV> 
</BODY>

</HTML>
