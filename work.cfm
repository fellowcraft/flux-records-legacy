<!--- <CFCACHECONTENT ACTION = "cache" CACHENAME = "betaaudio" GROUP = "group1"> --->

<CFIF NOT IsDefined('opus')>
404 - Not Found. <a href="works.cfm">back</a> 
<CFABORT>
</CFIF>

<!--- <CFIF NOT IsDefined('client.ClientID')>
<CFSET client.ClientID = "0121BDA5-E147-7A54-F31C6D9989F9BDC6">
</CFIF> --->

<cfif IsDefined('URL.refresh')>
<CFCACHE TIMESPAN="#CreateTimespan(0, 0, 0, 0)#" >
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
WHERE ID = #opus#
</CFQUERY>

<CFQUERY NAME="tracks" DATASOURCE="#ds#">
select * from PART
WHERE ID = #opus# <CFIF IsDefined('YR')>AND year LIKE '%#YR#%'</CFIF>
ORDER BY year DESC, month DESC, day DESC, No DESC
</CFQUERY>

<CFQUERY NAME="tracksASC" DATASOURCE="#ds#">
select * from PART
WHERE ID = #opus#
ORDER BY  year, month, Album, no
</CFQUERY>

<CFQUERY NAME="A" DATASOURCE="#ds#">
select sum(length) as SumTotal from PART
WHERE Status <> 0
</CFQUERY>

<CFSET statusList = "composing,recording,editing,mastering">

<HTML>

<HEAD>
<TITLE><CFOUTPUT>#Replace(tracks.artist,"Frank Rothkamm|Frank H. Rothkamm","#chr(174)#","ALL")# -  #tracks.name# (#tracks.year#) |  opus #tracks.ID#</CFOUTPUT></TITLE>

<meta name="viewport" content="width=622">

<CFINCLUDE TEMPLATE="_javascript.cfm">
<LINK HREF="css.css" REL="stylesheet" TYPE="text/css">
    

<link rel="stylesheet" href="/skin/circle.player.css">
<script type="text/javascript" src="/js/jquery.min.js"></script>
<script type="text/javascript" src="/js/jquery.jplayer.min.js"></script>
<script type="text/javascript" src="/js/jquery.transform2d.js"></script>
<script type="text/javascript" src="/js/jquery.grab.js"></script>
<script type="text/javascript" src="/js/mod.csstransforms.min.js"></script>
<script type="text/javascript" src="/js/circle.player.js"></script>

<script type="text/javascript">
//<![CDATA[

$(document).ready(function(){

	/*
	 * Instance CirclePlayer inside jQuery doc ready
	 *
	 * CirclePlayer(jPlayerSelector, media, options)
	 *   jPlayerSelector: String - The css selector of the jPlayer div.
	 *   media: Object - The media object used in jPlayer("setMedia",media).
	 *   options: Object - The jPlayer options.
	 *
	 * Multiple instances must set the cssSelectorAncestor in the jPlayer options. Defaults to "#cp_container_1" in CirclePlayer.
	 *
	 * The CirclePlayer uses the default supplied:"m4a, oga" if not given, which is different from the jPlayer default of supplied:"mp3"
	 * Note that the {wmode:"window"} option is set to ensure playback in Firefox 3.6 with the Flash solution.
	 * However, the OGA format would be used in this case with the HTML solution.
	 */

	var myCirclePlayer = new CirclePlayer("#jquery_jplayer_1",
		
<CFLOOP QUERY="tracks">
<CFSCRIPT>

tracksdisplayname =  '#Trim(ReReplace(tracks.name,"(#Chr(13)#|#Chr(10)#|#Chr(39)#)"," ","ALL"))#';

loc = "";
msg = "";
newname = "";

//OGG
For (i=0;i LTE 99; i=i+1){

OGGfile = '#OGGs##Numberformat(ID,"0000")#' & '#Numberformat(i,"00")#' & '.ogg';

if(FileExists('#OGGfile#'))  
newname = '#server_URL#/#OGGLocation#/' & '#Numberformat(ID,"0000")#' & '#Numberformat(i,"00")#' & '.ogg'; 
};
 
locOGG = '#newname#'; 

if (locOGG EQ "") { msg = "[file missing]"; 
loc = 'http://rothkamm.com/OGG/404.ogg'; 
};

For (i=0;i LTE 99; i=i+1){

//MP3
MP3file = '#MP3s##Numberformat(ID,"0000")#' & '#Numberformat(i,"00")#' & '.mp3';

if(FileExists('#MP3file#'))  
newname = '#server_URL#/#MP3Location#/' & '#Numberformat(ID,"0000")#' & '#Numberformat(i,"00")#' & '.mp3'; 
};
 
locMP3 = '#newname#'; 

if (locOGG EQ "") { msg = "[file missing]"; 
loc = 'http://rothkamm.com/MP3/404.mp3'; 
};



</CFSCRIPT>
		{ <!---
			title:'<cfoutput>[#NumberFormat(currentrow,'00')#] <!--- #tracks.city#  ---> #URLencodedFormat(tracks.name)# #tracksdisplayname# #Evaluate(int(tracks.length/60))#:#NumberFormat(Evaluate(tracks.length mod 60),'00')# #msg#</cfoutput>', --->
			oga: '<cfoutput>#locOGG#</cfoutput>',
			mp3: '<cfoutput>#locMP3#</cfoutput>'
		},		
</CFLOOP>
        {
		cssSelectorAncestor: "#cp_container_1",
		swfPath: "/js",
		wmode: "window",
		supplied:"oga, mp3",
		keyEnabled: true
	});

	$("#jplayer_inspector").jPlayerInspector({jPlayer:$("#jquery_jplayer_1")});
});
//]]>
</script>
<meta name="description" content="<cfoutput>Produced by Frank Rothkamm in #tracks.city# with #tracks.instruments#.</cfoutput> ">
<meta property="og:title" content="<cfoutput>#tracks.artist# - #tracks.name# (#tracks.year#)</cfoutput>" />
<meta property="og:image" content="<cfoutput>#server_URL#</cfoutput>/pictures/albumcover/small/generic.jpg" />
<meta property="og:audio" content="<cfoutput>#locMP3#</cfoutput>" />
<meta property="og:audio:secure_src" content="<cfoutput>#locMP3#</cfoutput>" />
<meta property="og:audio:artist" content="<cfoutput>#tracks.artist#</cfoutput>" />
<meta property="og:audio:title"  content="<cfoutput>#tracks.name#</cfoutput>" />
<meta property="og:audio:album"  content="<cfoutput>#tracks.album#</cfoutput>" />

<meta property="og:audio:type" content="audio/mpeg" />
</HEAD>


<BODY>
<!--- The jPlayer div must not be hidden. Keep it at the root of the body element to avoid any such problems. --->
<div id="jquery_jplayer_1" class="cp-jplayer"></div>
<div id="margin-left:auto; margin-right:auto;">
<DIV ID="Layer2"><CFINCLUDE TEMPLATE="_header.cfm"></DIV>
<!---<CFINCLUDE template="_layers.cfm">--->

<cfscript>if (tracks.month LT 1) tracks.month = 0;</cfscript>

<DIV ID="Layer1"><!--- CONTENT --->
<TABLE WIDTH="100%" BORDER="0" ALIGN="right" CELLPADDING="1" CELLSPACING="0"  BGCOLOR="FFFFFF">
  <TR>
    <TD VALIGN="TOP" BGCOLOR="FFFFFF"><TABLE WIDTH="100%" BORDER="0" CELLPADDING="0" CELLSPACING="5" BGCOLOR="FFFFFF">
	

<TR><TD COLSPAN="8" ALIGN="center" bgcolor="FFFFFF"><BR><BR>
<!---
<cfscript>
if (len(tracks.month) LT 1) safe_month  = 1; else safe_month = max(1,tracks.month);
if (len(tracks.day) LT 1)   safe_day    = 1; else safe_day   = max(1,tracks.day);
</cfscript>

		<IMG SRC="http://chart.apis.google.com/chart?cht=p&chco=990000|5A5A5A|FFCC33|00AF00|AAAAAA&chd=t:<cfoutput>#opus#,#tracks.year#,#safe_month#,#safe_day#,#tracks.length#&chs=400x200&chl=opus(#opus#)|year(#tracks.year#)|month(#safe_month#)|day(#safe_day#)|seconds(#tracks.length#)</cfoutput>">
		
--->	
			<!-- The container for the interface can go where you want to display it. Show and hide it as you need. -->

			<div id="cp_container_1" class="cp-container">

				<div class="cp-buffer-holder"> <!-- .cp-gt50 only needed when buffer is > than 50% -->
					<div class="cp-buffer-1"></div>
					<div class="cp-buffer-2"></div>
				</div>
				<div class="cp-progress-holder"> <!-- .cp-gt50 only needed when progress is > than 50% -->
					<div class="cp-progress-1"></div>
					<div class="cp-progress-2"></div>
				</div>
				<div class="cp-circle-control"></div>
				<ul class="cp-controls">
					<li><a class="cp-play" tabindex="1">play</a></li>
					<li><a class="cp-pause" style="display:none;" tabindex="1">pause</a></li> <!-- Needs the inline style here, or jQuery.show() uses display:inline instead of display:block -->
				</ul> 
        	</div>
<BR><BR></TD></TR>
<TR>
 <TD VALIGN="top" BGCOLOR="#FFFFFF"  CLASS="style2b"><b>date</b> (last modified)</TD>
 <TD VALIGN="top" BGCOLOR="#FFFFFF"  CLASS="style2b">opus</TD>
<TD VALIGN="top" BGCOLOR="#FFFFFF"  CLASS="style2b"  >work<!--- <IMG SRC="pictures/shim.gif" WIDTH="160" HEIGHT="1" ALIGN="RIGHT"> ---></TD>
<TD VALIGN="top" BGCOLOR="#FFFFFF"  CLASS="style2b"  >time</TD>
<!--- <TD VALIGN="top" BGCOLOR="#FFFFFF"  CLASS="style2b"  >album</TD> --->
<!--- <TD VALIGN="top" BGCOLOR="#FFFFFF"  CLASS="style2b"  >time</TD> --->
<TD VALIGN="top" BGCOLOR="#FFFFFF"  CLASS="style2b"  >city</TD>
<!--- <TD VALIGN="top" BGCOLOR="#FFFFFF"  CLASS="style2b"  ALIGN="right">FLAC</TD> --->
<TD VALIGN="top" BGCOLOR="#FFFFFF"  CLASS="style2b"  ALIGN="center">MP3</TD>
<TD VALIGN="top" BGCOLOR="#FFFFFF"  CLASS="style2b"  ALIGN="center">OGG</TD>
<!--- <TD VALIGN="top" BGCOLOR="#FFFFFF"  CLASS="style2b"  >stat</TD> --->
<TD ALIGN="CENTER" VALIGN="TOP"  ><!--- <img src="pictures/cd.gif" width="16" height="16"> ---></TD>
</TR>



<CFSET SumTotal = 0>
<CFSET PrevYear = tracks.year-1>

<CFOUTPUT QUERY="tracks">  
<!--- <cfif NOT Find( --->
 
<cfif year LT PrevYear >

<!--- <TR><TD VALIGN="top" width="23" CLASS="style2" NOWRAP>#year#<IMG SRC="pictures/shim.gif" WIDTH="1" HEIGHT="12" ALIGN="TOP"></TD> MM_showHideLayers('Comment#currentrow#','','show'); MM_showHideLayers('Comment#currentrow#','','hide');--->

<TR><TD COLSPAN="6"><IMG SRC="pictures/shimblack.gif" WIDTH="100%" HEIGHT="1"></TD></TR>
</cfif>
<CFSET PrevYear = year>
<!--- onMouseOver="this.style.backgroundColor='dddddd'" onMouseOut="this.style.backgroundColor=''" --->
 <TR  >
 
 <TD ROWSPAN="2" VALIGN="top" ALIGN="left" NOWRAP   CLASS="style2cfade"><!--- <IMG SRC="pictures/20.gif" WIDTH="8" HEIGHT="6"> ---><!---<a href="works.cfm?YR=#Right(year,4)#">---><b>#Right(year,4)#</a>/#NumberFormat(month,'00')#/#NumberFormat(day,'00')#</b> (#DateFormat(last_modified,'YYYY/MM/DD')#)<IMG SRC="pictures/shim.gif" WIDTH="1" HEIGHT="12" ALIGN="TOP"></TD>

<TD ALIGN="left" VALIGN="top" ALIGN="left" CLASS="style2c" ><STRONG>#ID#</STRONG></TD>

<CFSET google_string = '"' & Replace(TRIM(name),' ','+','ALL') & '"' & '+' & REReplace(TRIM(artist),'(,| )','+','ALL')>

<!--- <cfscript>
if ( find('Frank Genius',artist) or find('Frank Rothkamm',artist) or find('Frank H. Rothkamm',artist) or find('Frank H. Rothkamm',artist) )  collaborator = '';  
</cfscript>  --->



<!--- <CFIF IsDefined('client.ClientID')>
 <CFIF client.ClientID EQ "0121BDA5-E147-7A54-F31C6D9989F9BDC6">   ---> 
 <!---  <cfset MP3Location = 'MP3L'>
  <cfset MP3s = MP3L>  --->
<!---  <CFELSE>
  <cfset MP3Location = 'MP3'>
  <cfset MP3s = MP3s>
 </CFIF> 
</CFIF> --->


<cfscript> 

// if(NOT IsDefined('client.ClientID')) MP3s = MP3Samples;

OGGok = 0; 
FLACok= 0;
MP3ok=0;

For (i=0;i LTE 99; i=i+1){
if(FileExists('#MP3s##Numberformat(ID,"0000")#' & '#Numberformat(i,"00")#' & '.mp3')) 
MP3ok = '#Numberformat(ID,"0000")#' & '#Numberformat(i,"00")#';
}; 

For (i=0;i LTE 99; i=i+1){
if(FileExists('#OGGs##Numberformat(ID,"0000")#' & '#Numberformat(i,"00")#' & '.ogg')) 
OGGok = '#Numberformat(ID,"0000")#' & '#Numberformat(i,"00")#';
}; 

For (i=0;i LTE 99; i=i+1){
if(FileExists('#FLACs##Numberformat(ID,"0000")#' & '#Numberformat(i,"00")#' & '.flac')) 
FLACok =  '#Numberformat(ID,"0000")#' & '#Numberformat(i,"00")#';
}; 

if(length GT 3599) { 
TimeLength = int(length/60/60) & ':' & NumberFormat(length/60 mod 60,'00') & ':' & NumberFormat(length mod 60,'00'); }
else {
TimeLength = int(length/60) & ':' & NumberFormat(length mod 60,'00'); }

</cfscript>

 
 <TD VALIGN="top" CLASS="style3c" ><CFIF status EQ 0><strike></CFIF>   <b class="bb">#name#</b>   <!--- <cfif status LT 3> <EM>unfinished</EM></cfif> ---></TD>
 <TD VALIGN="top" CLASS="style3c" >#TimeLength#</TD>

<!--- <CFQUERY DATASOURCE="#ds#" NAME="ThisID">SELECT ProjectID FROM Project WHERE title like '%#trim(Album)#%'</CFQUERY> --->

<!--- <TD VALIGN="top" CLASS="style3" onMouseOver="this.style.backgroundColor='EBCD29'" onMouseOut='this.style.backgroundColor=""'><A HREF="projectdetail.cfm?ProjectID=#ThisID.ProjectID#">#UCase(left(album,4))#</A></TD> --->

<!--- <CFQUERY DATASOURCE="#ds#" NAME="hits" >
SELECT   COUNT(MP3) AS FREQ
FROM     playlists
WHERE    MP3 like '#trim(ID)#'
</CFQUERY> --->

<TD VALIGN="top" NOWRAP   CLASS="style2cfade"  >#Replace(city,",","<br>")# <!--- #hits.FREQ# ---></TD>
<!---<TD VALIGN="top" NOWRAP   CLASS="style2cfade" ALIGN="right" ><CFIF FLACok GT 1><a href="FLAC/#FLACok#.flac"><IMG SRC="pictures/download_3.gif" WIDTH="24" HEIGHT="24" BORDER="0" ALIGN="ABSMIDDLE" CLASS="style3" title='[DOWNLOAD] #artist# "#trim(name)#"' ID="#ID#"></a></CFIF></TD>--->
<TD VALIGN="top" NOWRAP   CLASS="style2cfade" ALIGN="center" ><CFIF MP3ok GT 1><a href="MP3320/#MP3ok#.mp3"><IMG SRC="pictures/download_3.gif" WIDTH="24" HEIGHT="24" BORDER="0" ALIGN="ABSMIDDLE" CLASS="style3" title='[DOWNLOAD] #artist# "#trim(name)#"' ID="#ID#"></a></CFIF></TD>
<TD VALIGN="top" NOWRAP   CLASS="style2cfade" ALIGN="CENTER" ><CFIF OGGok  GT 1><a href="OGG/#OGGok#.ogg"><IMG SRC="pictures/download_3.gif" WIDTH="24" HEIGHT="24" BORDER="0" ALIGN="ABSMIDDLE" CLASS="style3" title='[DOWNLOAD] #artist# "#trim(name)#"' ID="#ID#"></a></CFIF></TD>

<!--- <TD ALIGN="right" VALIGN="top" CLASS="style3" ><A href='http://www.google.com/custom?q=#google_string#' TARGET="_blank"><IMG SRC="pictures/google.gif" ALT="Google track" WIDTH="16" HEIGHT="16" BORDER="0" Title='[GOOGLE] #google_string#'></A></TD> --->

<cfscript>AlbumName = Replace(trim(album)," ","%20","ALL");</cfscript>

<CFSET album_icon = REReplace(trim(lcase(album)),"( |,)","_","all")>

<TD ALIGN="CENTER" VALIGN="middle" CLASS="style3" ><CFIF trim(album) NEQ ''><CFLOOP list="#album#" delimiters="," index="calbum"><CFSET WebName = Replace(trim(calbum)," ","%20","ALL")><CFSET album_icon = calbum>
<A HREF='album.cfm?#WebName#'><CFIF FileExists('#GetDirectoryFromPath(ExpandPath("*.*"))#pictures/albumcover/small/#artist#-#album_icon#.jpg')><IMG SRC="pictures/albumcover/small/#artist#-#album_icon#.jpg" ALIGN="ABSMIDDLE" BORDER="0" HEIGHT="30" Title='Released on album "#trim(calbum)#"'><CFELSE><IMG SRC="pictures/icons/noalbum.jpg" width="30"  height="30" ALIGN="ABSMIDDLE" BORDER="0" Title='To be released on album "#trim(calbum)#"'> </A></CFIF></CFLOOP></CFIF></TD>




<!--- <TD ALIGN="RIGHT" VALIGN="middle" CLASS="style3"><!--- <CFIF status EQ 5> --->
  <CFIF MP3ok EQ 1><A HREF='javascript:return();' TARGET="PlayerFrame"><IMG SRC="pictures/download_3.gif" WIDTH="12" HEIGHT="12" BORDER="0" ALIGN="ABSMIDDLE" CLASS="style3" title='[PLAY] #artist# "#trim(name)#"' ID="#ID#" onClick="<CFIF IsDefined('client.ClientID')>PlayMP3(#ID#);<CFELSE>javascript:loginmsg();</CFIF>"></A>
    <CFELSE>&nbsp;NILL</CFIF><!--- <IMG SRC="pictures/download_3.gif" WIDTH="12" HEIGHT="12" BORDER="0" ALIGN="ABSMIDDLE" CLASS="style3"></A>
</CFIF> ---></TD> --->
 </TR>
 <TR>
   <TD ALIGN="CENTER" VALIGN="top"   CLASS="style3"  >&nbsp;</TD>
   <TD colspan="2" VALIGN="top" CLASS="style2cfade"  >#ReReplace(Replace(artist,","," ","ALL"),"(Frank Rothkamm|Frank H. Rothkamm)","#chr(174)#")#<CFIF len(trim(sample)) GT 1> <SPAN CLASS="style2cfade">( sample by: #sample# )</SPAN></CFIF><!--- <br /><img src="pictures/shim.gif" width="20" height="5"> ---></TD>
   <TD VALIGN="top" NOWRAP   CLASS="style2cfade"  >&nbsp;</TD>
   <TD ALIGN="center" VALIGN="top"   CLASS="style3" >&nbsp;</TD>

<!---    <TD ALIGN="RIGHT" VALIGN="top" CLASS="style3">&nbsp;</TD> --->
 </TR>	

<CFSET SumTotal = SumTotal + length>
</CFOUTPUT> 	

<TR>
 <TD><IMG SRC="pictures/shim.gif" WIDTH="10" HEIGHT="10"></TD>
 <TD align="RIGHT" ><!--- <CFOUTPUT>#tracks.recordcount# tracks</CFOUTPUT> ---></TD>
<TD COLSPAN="8" class="style2cfade"><!--- <CFOUTPUT>#Evaluate(int((SumTotal/60)/60))#:#Evaluate(int((SumTotal/60) mod 60))#:#NumberFormat(Evaluate(SumTotal mod 60),'00')#</CFOUTPUT> ---><EM><cfoutput>#tracks.Instruments#</cfoutput></EM></TD>
</TR> 
</TABLE>
<!--- <CFINCLUDE TEMPLATE="foot.cfm"> ---></TD>
</TR>
</TABLE></TD></TR></TABLE>

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
<CFINCLUDE template="foot.cfm"> 
</DIV>
</BODY>

</HTML>
