<!--- <cfif len(CGI.QUERY_STRING) GT 2 AND len(CGI.QUERY_STRING) LT 30><cfelse><cflocation addtoken="no" url="news.cfm"><cfabort></cfif> --->
<cfprocessingdirective pageEncoding="utf-8">

<!--- <CFIF NOT IsDefined('client.ClientID')>
<CFSET client.ClientID = "0121BDA5-E147-7A54-F31C6D9989F9BDC6">
</CFIF> --->
<!--- ReReplace(URLDecode(QUERY_STRING),"(%20|-)"," ","ALL") --->

<CFIF CGI.QUERY_STRING LT 1>
<CFSET QUERY_STRING = 'Music After Sculptures'>
</CFIF>

<CFQUERY NAME="general" DATASOURCE="#ds#">
select * from Album
where Name COLLATE UTF8_GENERAL_CI like '#URLDecode(QUERY_STRING)#'
LIMIT 1 
</CFQUERY>

<!---<CFDUMP var="#general#"><cfabort>  --->    

<cfif general.recordcount LT 1>***not found*** [ <cfoutput><A HREF="#server_URL#">#server_URL#</A></cfoutput> ]<cfabort></cfif>

 <cfset ProjectID = general.AlbumID >

<CFQUERY NAME="album" DATASOURCE="#ds#">
SELECT *
FROM Album
where Name like '%#TRIM(general.Name)#%'
<!--- WHERE  AlbumID = '#ProjectID#' --->
</CFQUERY>

<CFQUERY NAME="tracks" DATASOURCE="#ds#">
select * from PART
where album like '%#TRIM(general.Name)#%'
ORDER BY <CFIF album.RndOrder GT 0>rand()<CFELSE>No</CFIF>
</CFQUERY>

<CFQUERY NAME="trackLocations" DATASOURCE="#ds#">
select distinct City from PART
where album like '%#TRIM(general.Name)#%'
</CFQUERY>
<CFQUERY NAME="instruments" DATASOURCE="#ds#">
select distinct instruments from PART
where album like '%#TRIM(general.Name)#%'
</CFQUERY>


<CFQUERY NAME="NextAlbum" DATASOURCE="#ds#">
SELECT Name, Composed, Label
FROM Album
WHERE  Right(Composed,4) >=  '#Right(album.Composed,4)#' 
ORDER by RIGHT(Composed,4) DESC,Name DESC
</CFQUERY>

<CFQUERY NAME="LastAlbum" DATASOURCE="#ds#">
SELECT Name, Released, Label
FROM Album
WHERE  Right(Composed,4) <=  '#Right(album.Composed,4)#' 
ORDER by RIGHT(Composed,4) DESC,Name DESC
</CFQUERY>

<CFQUERY NAME="TT" DATASOURCE="#ds#">
Select sum(length) as seconds from PART
where album like '%#TRIM(general.Name)#%'
</CFQUERY> 

<HTML>


<HEAD>
<CFINCLUDE template="favicon.cfm">
<cfscript>
R = ReREplace(album.Artist,'(Frank Rothkamm|Frank H. Rothkamm|Frank Genius|Frank|rothkamm|ROTHKAMM|Frank Genius|Rothkamm)','#chr(174)#','ALL');
V = ReREplace(album.VisualArt,'(Frank Rothkamm|Frank H. Rothkamm|Frank Genius|Frank|rothkamm|ROTHKAMM|Frank Genius|Rothkamm)','#chr(174)#','ALL');
O = ReREplace(album.Other,'(Frank Rothkamm|Frank H. Rothkamm|Frank Genius|Frank|rothkamm|ROTHKAMM|Frank Genius|Rothkamm)','#chr(174)#','ALL');

R = album.Artist;
V = album.VisualArt;
O = album.Other;


</cfscript>
<TITLE><CFOUTPUT>#album.Name# (#album.Composed#) #album.NameExt# #album.catalogNo# #chr(169)# #chr(174)# ROTHKAMM Album with Opus <CFLOOP QUERY="tracks">#ID# </CFLOOP> </CFOUTPUT></TITLE>
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<LINK HREF="css.css" REL="stylesheet" TYPE="text/css">

<LINK TYPE="text/css" HREF="/skin/jplayer.blue.monday.css" REL="stylesheet" />

<script src="https://code.jquery.com/jquery-1.11.2.min.js"></script>
<script src="https://code.jquery.com/jquery-migrate-1.2.1.min.js"></script>

<SCRIPT TYPE="text/javascript" SRC="/js/jquery.jplayer.min.js"></SCRIPT>
<SCRIPT TYPE="text/javascript" SRC="/js/jplayer.playlist.min.js"></SCRIPT>
<CFSET cover_image = "http://" & #cgi.server_name# & "/pictures/albumcover/" & #URLencodedFormat(album.Artist)# & "-" & #URLencodedFormat(album.Name)# & ".jpg">




<SCRIPT TYPE="text/javascript">
<!--- jplayer --->
<CFIF tracks.recordcount NEQ 0>
//<![CDATA[
$(document).ready(function(){

	new jPlayerPlaylist({
		jPlayer: "#jquery_jplayer_1",
		cssSelectorAncestor: "#jp_container_1"
	}, [

<CFSET FirstMP3 = ''>

<CFLOOP QUERY="tracks">
<CFSCRIPT>

loc = "";
newname = "";
msg = "";
Version = "-1";
//OGG
// For (i=0;i LTE 99; i=i+1){

// OGGfile = '#OGGs##Numberformat(ID,"0000")#' & '#Numberformat(i,"00")#' & '.ogg';

// if(FileExists('#OGGfile#'))  
// newname = '#server_URL#/#OGGLocation#/' & '#Numberformat(ID,"0000")#' & '#Numberformat(i,"00")#' & '.ogg'; 
// };

//if(IsDefined('client.clientID')) 
// locOGG = '#newname#'; 
//else loc = 'http://rothkamm.com/MP3/404.mp3';  
// if (locOGG EQ "") msg = "[file missing]" 

//MP3
For (i=0;i LTE 99; i=i+1){

MP3file = '#MP3s##Numberformat(ID,"0000")#' & '#Numberformat(i,"00")#' & '.mp3';

if(FileExists('#MP3file#')) { 
newname = '#server_URL#/#MP3Location#/' & '#Numberformat(ID,"0000")#' & '#Numberformat(i,"00")#' & '.mp3'; 
Version = '#Numberformat(i,"00")#';
};
};

//if(IsDefined('client.clientID')) 
locMP3  = '#newname#'; 
//else loc = 'http://rothkamm.com/MP3/404.mp3';  
if (locMP3 EQ "") msg = "[file missing]" 

TrackName = REReplace(tracks.name,"(#chr(10)#|#chr(13)#)"," ","ALL");
TrackName = REReplace(TrackName,"'","`","All");


//LeftTrackName = Left(TrackName,0);
 
x = 1;

</CFSCRIPT>
		{
			title:'<cfoutput><b>[#currentrow#] opus #tracks.ID#.#Version# (#year#)</b/><br/><i>#Evaluate(int(tracks.length/60))#:#NumberFormat(Evaluate(tracks.length mod 60),'00')#</i><!--- <cfloop index = "i" list="#TrackName#" delimiters=" "><cfif x EQ 10 OR x EQ 20><br/></cfif><cfset x=x+1>#i# </cfloop>---><br/> <br/>#TrackName#<br/>#msg#<br></cfoutput>',
<!---	oga:'<cfoutput>#locOGG#</cfoutput>', --->
	    mp3:'<cfoutput>#locMP3#</cfoutput>',
<!---   free: true,
        poster: '<cfoutput>#cover_image#</cfoutput>'
        size: { width: "280px", height: "280px"}
       --->  
		},
<CFIF FirstMP3 EQ ''><CFSET FirstMP3 = locMP3></CFIF>

</CFLOOP>		
	], {
        playlistOptions: {  autoPlay: false },
		swfPath: "/js",
		supplied: "mp3",
        volume: "100",
		smoothPlayBar: true,
		keyEnabled: false,
	});

$("#jplayer_inspector_1").jPlayerInspector({jPlayer:$("#jquery_jplayer_1")});

});

//]]>

</SCRIPT>

  
<CFINCLUDE template="favicon.cfm">


<meta property="fb:app_id" content="367367553687587">

<meta property='og:title' content="<cfoutput>#album.Name# (#album.Composed#) #album.NameExt#</cfoutput>"> 
<meta property="og:type" content="music.album">
<meta property="og:site_name" content="ROTHKAMM">
<meta property="og:description" content="<cfoutput>#R#</cfoutput> (sound artist) <cfoutput>#V#</cfoutput> (visual artist)">
<!--- <meta property="og:audio" content="<cfoutput>#FirstMP3#</cfoutput>"> --->
<!--- <meta property="og:audio:type" content="audio/vnd.facebook.bridge">  --->

<CFSET cover_image = "http://" & #cgi.server_name# & "/pictures/albumcover/" & #URLencodedFormat(album.Artist)# & "-" & #URLencodedFormat(album.Name)# & ".jpg">
<link rel="image_src"        href="<cfoutput>#cover_image#</cfoutput>">
<meta property="og:image" content="<cfoutput>#cover_image#</cfoutput>">
<meta property="og:url"   content="http://<cfoutput>#cgi.server_name#/#script_name#?#URLencodedFormat(album.Name)#</cfoutput>">

<meta name="twitter:card" content="summary_large_image">
<meta name="twitter:site" content="@chr174">
<meta name="twitter:title" content="<cfoutput>#album.Name# (#album.Composed#) #album.NameExt#</cfoutput>">
<meta name="twitter:description" content="Album by <cfoutput>#V#</cfoutput> (visual artist) ">
<meta name="twitter:image" content="http://<cfoutput>#cgi.server_name#</cfoutput>/pictures/albumcover/<cfoutput>#URLencodedFormat(album.Artist)#-#URLencodedFormat(album.Name)#</cfoutput>.jpg">
</HEAD>

<BODY>





<!--- Album Cover --->

<cfoutput><CENTER><IMG CLASS="picBig" SRC="pictures/albumcover/#URLencodedFormat(album.Artist)#-#URLencodedFormat(trim(album.Name))#.jpg"  BORDER="0" title='#trim(general.Name)# - #R# (sound artist) - #V# (visual artist)'></CENTER></cfoutput>

<!--- jplayer instance --->
<DIV ID="jquery_jplayer_1" CLASS="jp-jplayer"></DIV>
<!---<A NAME="contentPlayer"> </A> --->
	<DIV  align="center" CLASS="style2c"  >
   <DIV ID="jp_container_1" CLASS="jp-audio" ALIGN="CENTER" >
			<DIV CLASS="jp-type-playlist" >
				<DIV CLASS="jp-gui jp-interface" >

				<UL CLASS="jp-controls" >
			<!---		<LI><A HREF="javascript:;" CLASS="jp-previous" TABINDEX="1">previous</A></LI> --->
						<LI><A HREF="javascript:;" CLASS="jp-play" TABINDEX="1" >play</A></LI>
						<LI><A HREF="javascript:;" CLASS="jp-pause" TABINDEX="1" >pause</A></LI>
				<!---		<LI><A HREF="javascript:;" CLASS="jp-next" TABINDEX="1">next</A></LI> --->
			<!---			<LI><A HREF="javascript:;" CLASS="jp-stop" TABINDEX="1">stop</A></LI> --->
                    <!---    <LI><A HREF="javascript:;" CLASS="jp-mute" TABINDEX="1" TITLE="mute">mute</A></LI>
						<LI><A HREF="javascript:;" CLASS="jp-unmute" TABINDEX="1" TITLE="unmute">unmute</A></LI>
						<LI><A HREF="javascript:;" CLASS="jp-volume-max" TABINDEX="1" TITLE="max volume">max volume</A></LI>
			        --->
                   </UL>
<DIV CLASS="jp-progress"> 
<DIV CLASS="jp-seek-bar">
<DIV CLASS="jp-play-bar">
</DIV>
</DIV>
</DIV>
       <!---   <DIV CLASS="jp-volume-bar" ALIGN="LEFT">
						<DIV CLASS="jp-volume-bar-value"></DIV>
					    </DIV>
                     --->

<DIV CLASS="jp-current-time"></DIV>
<!---		<DIV CLASS="jp-duration"></DIV>--->
</DIV>
				<DIV CLASS="jp-playlist"  >
		        <UL>
					<LI></LI>
				</UL>
				</DIV>
		
<DIV CLASS="jp-no-solution">
<CFLOOP QUERY="tracks">
<CFSCRIPT>

loc = "";
newname = "";
msg = "";

//OGG
// For (i=0;i LTE 10; i=i+1){

// OGGfile = '#OGGs##Numberformat(ID,"0000")#' & '#Numberformat(i,"00")#' & '.ogg';

// if(FileExists('#OGGfile#'))  
// newname = '#server_URL#/#OGGLocation#/' & '#Numberformat(ID,"0000")#' & '#Numberformat(i,"00")#' & '.ogg'; 
// };

//if(IsDefined('client.clientID')) 
// locOGG = '#newname#'; 
//else loc = 'http://rothkamm.com/MP3/404.mp3';  
// if (locOGG EQ "") msg = "[file missing]" 
</CFSCRIPT>

<CFOUTPUT><a href="#newname#">#name# opus #ID#</a></CFOUTPUT><br>

</CFLOOP>
			</DIV>
		</DIV>
</CFIF>
</DIV>



<!--- Compact Disc --->
<CFIF trim(album.Format) EQ 'Compact Disc'>
<CENTER><CFIF FileExists('#GetDirectoryFromPath(ExpandPath("*.*"))#pictures\CD\#album.name#.jpg')><IMG SRC="pictures/CD/<cfoutput>#album.name#</cfoutput>.jpg" CLASS="pic" ALIGN="middle"></CENTER></CFIF>
</CFIF>


<!--- Title  --->

  <DIV ALIGN="center" VALIGN="middle" CLASS="style2cfade" ><BR><BR><STRONG><cfoutput>[ #R#</cfoutput> <cfoutput>#album.Name#</cfoutput> ]</STRONG><BR><BR></DIV>


<!--- Description text --->
<CFIF FileExists('#GetDirectoryFromPath(ExpandPath("*.*"))#linernotes\#trim(general.Name)#.htm')>
<TABLE WIDTH="75%" ALIGN="CENTER">
<TR >
<TD  CLASS="style3r" ALIGN="justify"><CFINCLUDE TEMPLATE="linernotes/#trim(general.Name)#.htm"></TD>
</TR>
</TABLE>
</CFIF>

<!--- Description text 2--->
<CFIF FileExists('#GetDirectoryFromPath(ExpandPath("*.*"))#linernotes\#general.AlbumID#.htm')>
<TABLE WIDTH="75%" ALIGN="CENTER">
<TR  >
<TD  CLASS="style3r" ALIGN="justify"><CFINCLUDE TEMPLATE="linernotes/#general.AlbumID#.htm"></TD>
</TR>
</TABLE>
</CFIF>
<BR>
<BR>


<!--- infobox --->
<cfoutput><TABLE WIDTH="75%" ALIGN="CENTER" CELLPADDING="3" CELLSPACING="0" CLASS="style2bTrans"  BGCOLOR="##FFFFFF">
    
    <TR>
      <TD VALIGN="TOP" BGCOLOR="##EBCD29" CLASS="styleTiny" width="50%">&nbsp;</TD>

<CFSET AlbumIcon = 'pictures/albumcover/small/#trim(album.Artist)#-#URLencodedFormat(trim(album.Name))#.jpg'> 
    
      <TD BGCOLOR="##EBCD29"> &nbsp</TD>
   </TR>
   <CFIF trim(album.CatalogNo) NEQ ''>
   <TR>
      <TD ALIGN="RIGHT" VALIGN="TOP" CLASS="styleTiny">Catalog No:</TD>
      <TD VALIGN="TOP">#album.CatalogNo#.#album.AlbumID#</TD>
   </TR>
   </CFIF>
   <TR>
    <TD ALIGN="RIGHT" VALIGN="TOP" CLASS="styleTiny"  >Title:</TD>
    <TD VALIGN="TOP"  ><STRONG>#album.Name#</STRONG><cfif trim(album.NameExt) NEQ ''><br><i>(#album.NameExt#)</i></cfif></TD>
   </TR>


<TR>
      <TD ALIGN="RIGHT" VALIGN="TOP" CLASS="styleTiny">Sound Artist:</TD>
      <TD VALIGN="TOP"><STRONG>#R#<cfif trim(album.Other) NEQ ''><br><i>#O#<br></i></cfif></TD>
   </TR>
   <CFIF album.VisualArt NEQ ''>
   <TR>
      <TD ALIGN="RIGHT" VALIGN="TOP" CLASS="styleTiny">Visual Artist:</TD>
      <TD VALIGN="TOP">#Replace(V,",","<br>","ALL")#</TD>
   </TR>

<cfscript>

LabelWithLink = ""

if(find("com",album.label)) {
  LabelWithLink = '<a href="http://#album.label#">#album.label#</a>'
} else {
  LabelWithLink = album.label
}

</cfscript>

  <TR>
      <TD ALIGN="RIGHT" VALIGN="TOP" CLASS="styleTiny">Label:</TD>
      <TD VALIGN="TOP">#LabelWithLink#</TD>
  </TR>
  </CFIF>
<cfscript>
if(TT.seconds GTE 3600) { 
TimeLength = int(TT.seconds/60/60) & ":" & NumberFormat(int(TT.seconds/60 mod 60),'00') & ":" & NumberFormat(TT.seconds mod 60,'00');  }
else {
TimeLength = int(TT.seconds/60) & ":" & NumberFormat(TT.seconds mod 60,'00') ; }
</cfscript>
<TR>
    <TD ALIGN="RIGHT" VALIGN="TOP" CLASS="styleTiny">Length:</TD>
    <TD VALIGN="TOP">#TimeLength# (#TT.seconds#s) </TD>
  </TR>
   <CFIF trim(album.Composed) NEQ ''>
  <TR>
    <TD ALIGN="RIGHT" VALIGN="TOP" nowrap CLASS="styleTiny"  >Composed:</TD>
    <TD VALIGN="TOP"  >#album.Composed#</TD>
  </TR>
  </CFIF>
  <TR>
    <TD ALIGN="RIGHT" VALIGN="TOP" nowrap CLASS="styleTiny"  >Location:</TD>
    <TD VALIGN="TOP"  ><cfloop query="trackLocations">#City#<BR></cfloop></TD>
  </TR>
   <CFIF instruments.recordcount GT 0>
   <TR>

    <cfset strList = ValueList(instruments.instruments)>
    <cfset listStruct = {} />

    <cfloop list="#strList#" index="i">
        <cfset listStruct[i] = i />
     </cfloop>

    <TD ALIGN="RIGHT" VALIGN="TOP" CLASS="styleTiny">Instruments:</TD>
    <TD VALIGN="TOP"><cfloop list="#structKeyList(listStruct)#" index="i">#Replace(i,",","<br>","ALL")#<br /></cfloop></TD>
  </TR>
  </CFIF>
   <TR>
    <TD ALIGN="RIGHT" VALIGN="TOP" nowrap CLASS="styleTiny"  >Release Date:</TD>
    <TD VALIGN="TOP"  ><CFIF DateFormat(album.Released,"YYYYMMDD") LTE DateFormat(now(),"YYYYMMDD")>#DateFormat(album.Released,"M/D/YYYY")#<CFELSE>TBA</CFIF></TD>
  </TR>
  <CFIF album.Edition NEQ ''>
  <TR>
    <TD ALIGN="RIGHT" VALIGN="TOP" nowrap CLASS="styleTiny"  >Edition Size:</TD>
    <TD VALIGN="TOP"  >#album.Edition#</TD>
  </TR>
  </CFIF>
 <TR>
    <TD ALIGN="RIGHT" VALIGN="TOP" CLASS="styleTiny">Format:</TD>
    <TD VALIGN="TOP">#Replace(album.Format,",","<br>","ALL")#</TD>
  </TR>
 <CFIF album.Parts NEQ ''>
   <TR>
    <TD ALIGN="RIGHT" VALIGN="TOP" CLASS="styleTiny">Parts:</TD>
    <TD VALIGN="TOP">#Replace(album.Parts,",","<br>","ALL")#</SPAN></TD>
  </TR>
  </CFIF>
  <CFIF album.UPC NEQ ''>
  <TR>
    <TD ALIGN="RIGHT" VALIGN="TOP" CLASS="styleTiny"  >UPC:</TD>
    <TD VALIGN="TOP"  >#album.UPC#</TD>
  </TR>
  </CFIF> 
  <CFIF album.FileUnder NEQ ''>
  <TR>
    <TD ALIGN="RIGHT" VALIGN="TOP" CLASS="styleTiny" >File Under:</TD>
    <TD VALIGN="TOP" >#Replace(album.FileUnder,",","<br>","ALL")#</SPAN></TD>
  </TR>
  </CFIF> 

<CFIF FileExists('#GetDirectoryFromPath(ExpandPath("*.*"))#pdf\rothkamm-#trim(general.Name)#-score.pdf')>
<TR>
<TD  ALIGN="RIGHT" VALIGN="TOP" CLASS="styleTiny">Score:</STRONG> </TD>
<TD VALIGN="TOP"><CFOUTPUT><A HREF='pdf/rothkamm-#trim(general.Name)#-score.pdf' TARGET="">http://rothkamm.com/pdf/rothkamm-#trim(general.Name)#-score.pdf</A></CFOUTPUT></TD>
</TR>
</CFIF>

<CFIF FileExists('#GetDirectoryFromPath(ExpandPath("*.*"))#midi\rothkamm-#trim(general.Name)#.mid')>
<TR>
<TD  ALIGN="RIGHT" VALIGN="TOP" CLASS="styleTiny">Midi:</STRONG> </TD>
<TD VALIGN="TOP"><CFOUTPUT><A HREF='pdf/rothkamm-#trim(general.Name)#.mid' TARGET="">http://rothkamm.com/midi/rothkamm-#trim(general.Name)#.mid</A></CFOUTPUT></TD>
</TR>
</CFIF>





</TABLE></cfoutput>




<!--- Album Options --->
<TABLE CELLPADDING="0" CELLSPACING="0" BORDER="0"  WIDTH="100%">

<!--- <CFIF FileExists('#GetDirectoryFromPath(ExpandPath("*.*"))#/pictures/albumcover/small/#trim(album.Artist)#-#trim(album.Name)#.jpg')>
<TR onMouseOver="this.style.backgroundColor='EBCD29'" onMouseOut='this.style.backgroundColor=""'  >
<TD CLASS="style2cTrans"><cfoutput>[#trim(general.Name)#]<STRONG> <A HREF="pictures/albumcover/#album.Artist#-#URLencodedFormat(trim(general.Name))#.jpg">Image</A></STRONG></cfoutput></TD>
<TD ALIGN="RIGHT" CLASS="style2cTrans" WIDTH="20"><CFOUTPUT><A HREF='pictures/albumcover/#album.Artist#-#URLencodedFormat(trim(general.Name))#.jpg'><IMG SRC="pictures/gif.gif" WIDTH="13" HEIGHT="16" BORDER="0" ALIGN="ABSMIDDLE" TITLE="::: #ds# #trim(general.Name)# ::: download/view high-resolution image"></A></CFOUTPUT></TD>
</TR>
</CFIF> --->

<CFIF FileExists('#GetDirectoryFromPath(ExpandPath("*.*"))#pdf\rothkamm-#trim(general.Name)#.pdf')>
<TR onMouseOver="this.style.backgroundColor='EBCD29'" onMouseOut='this.style.backgroundColor=""' >
<TD CLASS="style2cTrans"><cfoutput>[#trim(general.Name)#]<STRONG> <A HREF="pdf/rothkamm-#trim(general.Name)#.pdf">Press Release</A></STRONG></cfoutput></TD>
<TD ALIGN="RIGHT" CLASS="style2cTrans"  width="20"><CFOUTPUT><A HREF='pdf/rothkamm-#trim(general.Name)#.pdf'><IMG SRC="pictures/pdf_c.gif" WIDTH="16" HEIGHT="14" BORDER="0" ALIGN="ABSMIDDLE" TITLE="::: #ds# #trim(general.Name)# ::: download the press release"></A></CFOUTPUT></TD>
</TR>
</CFIF>

<CFIF FileExists('#GetDirectoryFromPath(ExpandPath("*.*"))#pdf\rothkamm-#trim(general.Name)#-4to.pdf')>
<TR onMouseOver="this.style.backgroundColor='EBCD29'" onMouseOut='this.style.backgroundColor=""' >
<TD CLASS="style2cTrans"><CFOUTPUT>[#trim(general.Name)#]<STRONG> <A HREF="pdf/rothkamm-#trim(general.Name)#-4to.pdf">4to</A></STRONG></CFOUTPUT></TD>
<TD ALIGN="RIGHT" CLASS="style2cTrans" ><CFOUTPUT><A HREF='pdf/rothkamm-#trim(general.Name)#-4to.pdf'><IMG SRC="pictures/pdf_c.gif" WIDTH="16" HEIGHT="14" BORDER="0" ALIGN="ABSMIDDLE" TITLE="::: #ds# #trim(general.Name)# ::: download the 4to"></A></CFOUTPUT></TD>
</TR>
</CFIF>

<CFIF FileExists('#GetDirectoryFromPath(ExpandPath("*.*"))#pdf\rothkamm-#trim(general.Name)#-artwork.pdf')>
<TR onMouseOver="this.style.backgroundColor='EBCD29'" onMouseOut='this.style.backgroundColor=""' >
<TD CLASS="style2cTrans"><cfoutput>[#trim(general.Name)#]<STRONG> <A HREF="pdf/rothkamm-#trim(general.Name)#-artwork.pdf">Art Work</A></STRONG> </cfoutput></TD>
<TD ALIGN="RIGHT" CLASS="style2cTrans"   width="20" ><CFOUTPUT><A HREF="pdf/rothkamm-#trim(general.Name)#-artwork.pdf" ><IMG SRC="pictures/pdf_c.gif" WIDTH="16" HEIGHT="14" BORDER="0" ALIGN="ABSMIDDLE" TITLE="::: #ds# #trim(general.Name)# ::: download the art work"></A></CFOUTPUT></TD>
</TR>
</CFIF>


<!---
<CFIF FileExists('#GetDirectoryFromPath(ExpandPath("*.*"))#pdf\rothkamm-#trim(general.Name)#-score.pdf')>
<TR onMouseOver="this.style.backgroundColor='EBCD29'" onMouseOut='this.style.backgroundColor=""'>
<TD CLASS="style2cTrans"><cfoutput>[#trim(general.Name)#]<STRONG> <A HREF="pdf/rothkamm-#trim(general.Name)#-score.pdf" TARGET="">Score</A></STRONG> </cfoutput></TD>
<TD ALIGN="RIGHT" CLASS="style2cTrans" ><CFOUTPUT><A HREF='pdf/rothkamm-#trim(general.Name)#-score.pdf' TARGET=""><IMG SRC="pictures/pdf_c.gif" WIDTH="16" HEIGHT="14" BORDER="0" ALIGN="ABSMIDDLE" TITLE="::: #ds# #trim(general.Name)# ::: download the score"></A></CFOUTPUT></TD>
</TR>
</CFIF>
--->


</TABLE>






<!--- google --->
<!--- <TABLE align="CENTER">
<TR>
<TD><div align="CENTER"><a href='http://google.com//#sclient=psy-ab&hl=en&site=&source=hp&q=<cfoutput>%22#album.artist#%22+%22#album.name#%22</cfoutput>' target=""><img src="pictures/cheleasebitmapORG.gif" width="15" height="15" border="0" ></a></div>
</TD>
</TR>--->

<!---
<CFINCLUDE TEMPLATE="foot.cfm">
--->
</DIV>




</BODY>
</HTML>
