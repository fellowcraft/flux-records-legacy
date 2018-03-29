<!--- <cfif len(CGI.QUERY_STRING) GT 2 AND len(CGI.QUERY_STRING) LT 30><cfelse><cflocation addtoken="no" url="news.cfm"><cfabort></cfif> --->


<!--- <CFIF NOT IsDefined('client.ClientID')>
<CFSET client.ClientID = "0121BDA5-E147-7A54-F31C6D9989F9BDC6">
</CFIF> --->


<CFIF CGI.QUERY_STRING LT 1>
<CFSET QUERY_STRING = 'Music After Sculptures'>
</CFIF>

<CFQUERY NAME="general" DATASOURCE="#ds#">
select * from Album 
where Name COLLATE UTF8_GENERAL_CI like '%#ReReplace(QUERY_STRING,"(%20|-)"," ","ALL")#%'
</CFQUERY>

<!--- <CFDUMP var="#general#"><cfabort>  --->    

 <cfif general.recordcount LT 1>***not found*** [ <cfoutput><A HREF="#server_URL#">#server_URL#</A></cfoutput> ]<cfabort></cfif>

 <cfset ProjectID = general.AlbumID >

<CFQUERY NAME="product" DATASOURCE="#ds#">
select * from product
where ProjectID = '#ProjectID#' AND class = 'Compact Disc' AND OnSale > 0 
</CFQUERY>

<!--- <CFIF product.recordcount LT 1>***not available (yet)*** [ <A HREF="http://rothkamm.com">rothkamm.com</A> ]<CFABORT></CFIF> --->

<CFQUERY NAME="MP3" DATASOURCE="#ds#">
select * from product
where ProjectID = '#ProjectID#' AND class = 'mp3' AND onsale > 0
</CFQUERY>

<CFQUERY NAME="FLAC" DATASOURCE="#ds#">
select * from product
where ProjectID = '#ProjectID#' AND class = 'flac' AND onsale > 0
</CFQUERY>

<CFQUERY NAME="tracks" DATASOURCE="#ds#">
select * from PART
where album like '%#TRIM(general.Name)#%'
ORDER BY No
</CFQUERY>

<CFQUERY NAME="trackLocations" DATASOURCE="#ds#">
select distinct City from PART
where album like '%#TRIM(general.Name)#%'
</CFQUERY>
<CFQUERY NAME="instruments" DATASOURCE="#ds#">
select distinct instruments from PART
where album like '%#TRIM(general.Name)#%'
</CFQUERY>
<!---
<CFQUERY NAME="reviews" DATASOURCE="#ds#">
select * from reviews
where album like '%#left(TRIM(general.Name),30)#%'
ORDER BY rank ASC, datetime DESC
</CFQUERY>

<CFQUERY NAME="radio_station" DATASOURCE="#ds#">
select * from radio
where album like '%#TRIM(general.Name)#%'
ORDER BY datetime DESC
</CFQUERY>
--->
<CFQUERY NAME="album" DATASOURCE="#ds#">
SELECT *
FROM Album
where Name like '%#TRIM(general.Name)#%'
<!--- WHERE  AlbumID = '#ProjectID#' --->
</CFQUERY>


<CFQUERY NAME="NextAlbum" DATASOURCE="#ds#">
SELECT Name, Released, Label
FROM Album
WHERE  Date(Released) >  '#DateFormat(album.Released,'YYYY-MM-DD')#' 
  AND  Date(Released) <= '#DateFormat(now(),'YYYY-MM-DD')#' 
  AND (Solo = 1)
ORDER BY Released ASC LIMIT 0,1
</CFQUERY>

<CFQUERY NAME="LastAlbum" DATASOURCE="#ds#">
SELECT Name, Released, Label
FROM Album
WHERE Date(Released) <  '#DateFormat(album.Released,'YYYY-MM-DD')#' 
  AND Date(Released) <= '#DateFormat(now(),'YYYY-MM-DD')#' 
  AND (Solo = 1) 
ORDER BY Released DESC LIMIT 0,1
</CFQUERY>


<!--- <CFQUERY NAME="NextAlbum" DATASOURCE="#ds#">
SELECT Name, Composed, Label
FROM Album
WHERE  Composed >  #Left(album.Composed,4)#
  AND  Date(Released) <= '#DateFormat(now(),'YYYY-MM-DD')#' 
  AND (Solo = 1)
ORDER BY Composed ASC LIMIT 0,1
</CFQUERY>

<CFQUERY NAME="LastAlbum" DATASOURCE="#ds#">
SELECT Name, Composed, Label
FROM Album
WHERE      Composed  <    #Left(album.Composed,4)# 
  AND Date(Released) <= '#DateFormat(now(),'YYYY-MM-DD')#' 
  AND (Solo = 1) 
ORDER BY Composed DESC LIMIT 0,1
</CFQUERY>
--->

<CFQUERY NAME="TT" DATASOURCE="#ds#">
Select sum(length) as seconds from PART
where album like '%#TRIM(general.Name)#%'
</CFQUERY> 


<!--- <CFSET GoogleString = "&sa=Search&client=pub-3964018303872303&forid=1&ie=ISO-8859-1&oe=ISO-8859-1&cof=GALT:##008000;GL:1;DIV:##336699;VLC:663399;AH:center;BGC:FFFFFF;LBGC:336699;ALC:0000FF;LC:0000FF;T:000000;GFNT:0000FF;GIMP:0000FF;FORID:1;&hl=en"> --->

<HTML>

<!--- (c) rothkamm 2004/6 | rothkamm.com case study | coldfusion 5.0 | dreamweaver mx 7.0 | sql server 2000 | fireworks MX 6.0 | photoshop 7.0 | windows 2000 server --->

<HEAD>
<TITLE><CFOUTPUT>#album.Artist# - #album.Name#</CFOUTPUT></TITLE>
<META HTTP-EQUIV="EXPIRES" CONTENT="0">
<CFINCLUDE TEMPLATE="_javascript.cfm">
<LINK HREF="css.css" REL="stylesheet" TYPE="text/css">

 <LINK TYPE="text/css" HREF="/skin/jplayer.blue.monday.css" REL="stylesheet" />
 <script src="//code.jquery.com/jquery-2.1.4.min.js"></script>
<!--- <script src="//code.jquery.com/jquery-migrate-1.2.1.min.js"></script> --->
 
 <SCRIPT TYPE="text/javascript" SRC="/js2/jquery.jplayer.min.js"></SCRIPT>
 <SCRIPT TYPE="text/javascript" SRC="/js/jplayer.playlist.min.js"></SCRIPT> 

<SCRIPT TYPE="text/javascript">
<!--- jplayer --->
<CFIF tracks.recordcount NEQ 0>
//<![CDATA[
$(document).ready(function(){

	new jPlayerPlaylist({
		jPlayer: "#jquery_jplayer_1",
		cssSelectorAncestor: "#jp_container_1"
	}, [
	
<CFLOOP QUERY="tracks">
<CFSCRIPT>

loc = "";
newname = "";
msg = "";

//OGG
For (i=0;i LTE 10; i=i+1){

OGGfile = '#OGGs##Numberformat(ID,"0000")#' & '#Numberformat(i,"00")#' & '.ogg';

if(FileExists('#OGGfile#'))  
newname = '#server_URL#/#OGGLocation#/' & '#Numberformat(ID,"0000")#' & '#Numberformat(i,"00")#' & '.ogg'; 
};

//if(IsDefined('client.clientID')) 
locOGG = '#newname#'; 
//else loc = 'http://rothkamm.com/MP3/404.mp3';  
if (locOGG EQ "") msg = "[file missing]" 

//MP3
For (i=0;i LTE 10; i=i+1){

MP3file = '#MP3s##Numberformat(ID,"0000")#' & '#Numberformat(i,"00")#' & '.mp3';

if(FileExists('#MP3file#'))  
newname = '#server_URL#/#MP3Location#/' & '#Numberformat(ID,"0000")#' & '#Numberformat(i,"00")#' & '.mp3'; 
};

//if(IsDefined('client.clientID')) 
locMP3 = '#newname#'; 
//else loc = 'http://rothkamm.com/MP3/404.mp3';  
if (locMP3 EQ "") msg = "[file missing]" 


</CFSCRIPT>
		{
			title:'<cfoutput><b>[#currentrow#]</b/> <!--- #tracks.city#  --->#REReplace(tracks.name,"(#chr(10)#|#chr(13)#|')"," ","ALL")# (#Evaluate(int(tracks.length/60))#:#NumberFormat(Evaluate(tracks.length mod 60),'00')#) opus #tracks.ID# (#year#) #msg# <a href="work.cfm?opus=#tracks.ID#" target="_blank"><img src="pictures/download_3.gif" border=0 WIDTH="10" valign="middle"></a></cfoutput>',
			oga:'<cfoutput>#locOGG#</cfoutput>',
	        mp3:'<cfoutput>#locMP3#</cfoutput>'
		},
</CFLOOP>		
	], {
		swfPath: "/js",
		supplied: "oga, mp3",
		wmode: "window",
		smoothPlayBar: true,
		keyEnabled: true
	});

	//$("#jplayer_inspector_1").jPlayerInspector({jPlayer:$("#jquery_jplayer_1")});
});
//]]>
</SCRIPT>

  
<link rel="shortcut icon" href="<cfoutput>pictures/albumcover/thumbs/#Replace(album.Artist,' ','%20','ALL')#-#Replace(album.Name,' ','%20','ALL')#</cfoutput>.jpg">
<link rel="apple-touch-icon" href="<cfoutput>pictures/albumcover/thumbs/#Replace(album.Artist,' ','%20','ALL')#-#Replace(album.Name,' ','%20','ALL')#</cfoutput>.jpg">
<meta name="apple-mobile-web-app-capable" content="yes">

<meta name="title" content="<cfoutput>#album.Name# (#DateFormat(album.Released,'YYYY')#</cfoutput>)">
<meta property="og:title" content="<cfoutput>#album.Name# (#DateFormat(album.Released,'YYYY')#</cfoutput>)">
<meta property="og:type" content="album">
<meta property="og:site_name" content="Frank Rothkamm">
<meta property="og:description" content="conceptual sound art album by <cfoutput>#album.Artist#</cfoutput>">

<link rel="image_src" href="http://<cfoutput>#cgi.server_name#</cfoutput>/pictures/albumcover/<cfoutput>#Replace(album.Artist,' ','%20','ALL')#-#Replace(album.Name,' ','%20','ALL')#</cfoutput>.jpg">
<meta property="og:image" content="http://<cfoutput>#cgi.server_name#</cfoutput>/pictures/albumcover/<cfoutput>#Replace(album.Artist,' ','%20','ALL')#-#Replace(album.Name,' ','%20','ALL')#</cfoutput>.jpg">
<meta property="og:url"   content="http://<cfoutput>#cgi.server_name#/#script_name#?#query_string#</cfoutput>">

<!---
<meta name="medium"         content="video">
<meta name="video_height"   content="105">
<meta name="video_width"    content="400">
<meta name="video_type"     content="application/x-shockwave-flash">  
<meta property="og:video" content="http://s1.bcbits.com/player.swf?size=venti&album=2122943794"> 
<meta property="og:video:secure_url" content="https://s1.bcbits.com/player.swf?size=venti&album=2122943794">       
<meta property="og:video:type" content="application/x-shockwave-flash">
<meta property="og:video:height" content="105">
<meta property="og:video:width" content="400">

 <meta property="fb:app_id"      content="165661066782720"> 
 <meta property="fb:admins" content=""> 
--->
<meta name="twitter:card" content="summary_large_image">
<meta name="twitter:site" content="@rothkamm">
<!--- <meta name="twitter:creator" content="@rothkamm"> --->
<meta name="twitter:title" content="<cfoutput>#album.Name# (#DateFormat(album.Released,'YYYY')#</cfoutput>)">
<meta name="twitter:description" content="conceptual sound art album by <cfoutput>#album.Artist#</cfoutput>">
<meta name="twitter:image" content="http://<cfoutput>#cgi.server_name#</cfoutput>/pictures/albumcover/<cfoutput>#Replace(album.Artist,' ','%20','ALL')#-#Replace(album.Name,' ','%20','ALL')#</cfoutput>.jpg">
</HEAD>

<BODY>
<DIV ID="jquery_jplayer_1" CLASS="jp-jplayer"></DIV>
<DIV ID="margin-left:auto; margin-right:auto;">
<!--- <DIV ID="menue"><CFINCLUDE TEMPLATE="_menue2.cfm"></DIV>
<DIV ID="Layer2"><CFINCLUDE TEMPLATE="_header.cfm"></DIV> --->
<CFINCLUDE template="_layers.cfm">

<DIV ID="Layer1">
<TABLE WIDTH="100%" BORDER="0" ALIGN="right" CELLPADDING="1" CELLSPACING="0"  BGCOLOR="#3F3F3F">
<TR>
<TD><TABLE BORDER="0" CELLPADDING="0" CELLSPACING="9" WIDTH="100%" BGCOLOR="#FFFFFF">
<TR>
<TD ALIGN="CENTER" VALIGN="TOP" CLASS="style3c" ><TABLE CELLPADDING="0" CELLSPACING="0" WIDTH="100%">

<TR><TD COLSPAN="3" ALIGN="RIGHT"><IMG SRC="pictures/shim.gif" HEIGHT="38" WIDTH="10"></TD></TR>

<!--- Album Cover --->
<TR>
<TD VALIGN="MIDDLE" WIDTH="168" ALIGN="CENTER"><CFIF NOT Len(LastAlbum.Name) LT 1><A HREF="album.cfm?<cfoutput>#LastAlbum.Name#</cfoutput>"><IMG SRC="pictures/back.gif" ALT="last album" WIDTH="16" HEIGHT="16" BORDER="0"></A><CFELSE><IMG SRC="pictures/shim.gif" HEIGHT="16" WIDTH="16"></CFIF></TD>

<TD><CFIF FileExists('#GetDirectoryFromPath(ExpandPath("*.*"))#/pictures/albumcover/small/#trim(album.Artist)#-#trim(album.Name)#.jpg')><cfoutput><A HREF="pictures/albumcover/#trim(album.Artist)#-#trim(album.Name)#.jpg"><IMG  SRC="pictures/albumcover/small/#album.Artist#-#trim(album.Name)#.jpg"  BORDER="0" name='SlideShow' title='[Object] "#album.Artist#-#trim(general.Name)#'></A></cfoutput><CFELSE><IMG SRC="pictures/albumcover/small/generic.jpg" name='SlideShow' ALIGN="TOP" ></CFIF></TD>

<TD VALIGN="MIDDLE" ALIGN="CENTER" WIDTH="165" ><CFIF NOT Len(NextAlbum.Name) LT 1><A HREF="album.cfm?<cfoutput>#NextAlbum.Name#</cfoutput>"><IMG SRC="pictures/forward.gif" ALT="next album" WIDTH="16" HEIGHT="16" BORDER="0"></A><CFELSE><IMG SRC="pictures/shim.gif" HEIGHT="16" WIDTH="16"></CFIF></TD>

</TR>

</TABLE></TD></TR>

<!---
<!--- Shopping Cart --->
<TR><TD CLASS="style2cTrans">
<TABLE BORDER="0" CELLPADDING="0" CELLSPACING="0" WIDTH="100%" BGCOLOR="FFFFFF">
	<TR> 
      <TD ROWSPAN="3"  VALIGN="middle" CLASS="style3Trans" HEIGHT="40"><img src="pictures/shim.gif" WIDTH=15 HEIGHT=40 ALIGN="MIDDLE"><STRONG><cfoutput>#album.Artist# [ #album.Name# <CFIF len(album.NameExt) GT 1>(#album.NameExt#)</CFIF> ]</cfoutput></STRONG>
        <!--- <CFIF FileExists('#GetDirectoryFromPath(ExpandPath("*.*"))#newmedia\preview\#album.artist#-#album.name#.mp3')><cfoutput><A HREF='newmedia/preview/#album.artist#-#album.name#.mp3'><IMG SRC="pictures/icon_audio.gif" WIDTH="12" HEIGHT="12" HSPACE="4" VSPACE="8" BORDER="0" ALIGN="absmiddle" CLASS="style2bstrong" title='Download the Trailer: "#album.artist#-#album.name#"'></A></cfoutput></CFIF> ---></TD>
<!---     
<CFIF product.recordcount NEQ 0 AND product.OnSale EQ 1>
 <cfoutput query="product">    
 <CFIF len(product.price) LT 1><CFSET ProductPrice = 0.00>
 <CFELSE>
 <CFSET ProductPrice = NumberFormat(product.price, "__.__")>
</CFIF> 	  
<TD ALIGN="right" 
    VALIGN="top"  
    CLASS="style3Trans"
    
    ><STRONG>#album.Format# </STRONG><IMG SRC="pictures/blink_arrow.gif" WIDTH="4" HEIGHT="7"></TD>
	  <!---<TD ALIGN="right" VALIGN="top" CLASS="style3Trans" >$<cfoutput>#ProductPrice#</cfoutput><A HREF="#GooglePlay#"> <IMG SRC="pictures/cart_add.gif" WIDTH="22" HEIGHT="15" BORDER="0" ALIGN="top"></A></TD>--->
<TD ALIGN="right" VALIGN="top" CLASS="style3Trans" >$<cfoutput>#ProductPrice#</cfoutput><A HREF="javascript:ShowViewCart('AddToCart=true&opus=<cfoutput>#Evaluate(product.ID+10000)#</cfoutput>')"> <IMG SRC="pictures/cart_add.gif" WIDTH="22" HEIGHT="15" BORDER="0" ALIGN="top"></A></TD>
	 
 </cfoutput>
<CFELSE>
     <TD> </TD><TD> </TD>
</CFIF>
     </TR>
--->

<!---

	<TR>
	  
	  <CFIF FLAC.recordcount NEQ 0 >
      <cfoutput query="FLAC">
      <TD ALIGN="right" VALIGN="top"  CLASS="style3Trans" >FLAC Edition <IMG SRC="pictures/blink_arrow.gif" WIDTH="4" HEIGHT="7"></TD>
      <TD ALIGN="right" VALIGN="top"  CLASS="style3Trans" HEIGHT="15"><CFIF Promo EQ 1 AND DateDiff("d",now(),Promo_end) GT 0><EM>(#DateDiff("d",now(),Promo_end)# days left)</EM>&nbsp;&nbsp; $&nbsp; <STRONG>FREE</STRONG> <A HREF="<CFIF IsDefined('client.ClientID')>add_promo.cfm?ID=#ID#<CFELSE>javascript:loginmsg();</CFIF>"><IMG SRC="pictures/cart_add.gif" WIDTH="22" HEIGHT="15" BORDER="0" ALIGN="absmiddle"></A><CFELSE> $#NumberFormat(price, "__.__")# <A HREF="javascript:ShowViewCart('AddToCart=true&opus=#Evaluate(ID+10000)#')"><IMG SRC="pictures/cart_add.gif" WIDTH="22" HEIGHT="15" BORDER="0" ALIGN="absmiddle"></A></CFIF></TD>
       </cfoutput>
	   <CFELSE>
       <TD> </TD><TD> </TD>
	   </CFIF>
	  	</TR>

--->



	<TR>      
	<!---  <CFIF len(album.GooglePlay) NEQ 0 > --->
 
    <CFIF FileExists('#GetDirectoryFromPath(ExpandPath("*.*"))#/MP3r/Frank_Rothkamm=#Replace(album.name," ","_","ALL")#=[MP3].zip')>

    <!--- <CFIF MP3.recordcount NEQ 0 > --->

     <!--- <cfoutput query="MP3"> --->
    
      
<!---      <TD ALIGN="right" VALIGN="top"  CLASS="style3Trans" ><STRONG>Google Play</STRONG> <IMG SRC="pictures/blink_arrow.gif" WIDTH="4" HEIGHT="7"></TD> --->
	
<!---	  <TD ALIGN="right" VALIGN="middle"  CLASS="style3Trans" HEIGHT="15"> <A HREF="#GooglePlay#"><IMG SRC="pictures/download_3.gif" WIDTH="24" HEIGHT="24" BORDER="0" HSPACE="10" ALIGN="absmiddle"></A></TD> --->

<TD ALIGN="right" VALIGN="middle"  CLASS="style3Trans" HEIGHT="15"> <A HREF='/MP3r/Frank_Rothkamm=<cfoutput>#Replace(album.name," ","_","ALL")#=[MP3].zip</cfoutput>'><IMG SRC="pictures/download_3.gif" WIDTH="24" HEIGHT="24" BORDER="0" HSPACE="10" ALIGN="absmiddle"></A></TD>
<!---      
      <!---<TD ALIGN="right" VALIGN="top"  CLASS="style3Trans" HEIGHT="15"><CFIF Promo EQ 1 AND DateDiff("d",now(),Promo_end) GT 0><EM>(#DateDiff("d",now(),Promo_end)# days left)</EM>&nbsp;&nbsp; $&nbsp; <STRONG>FREE</STRONG> <A HREF="<CFIF IsDefined('client.ClientID')>add_promo.cfm?ID=#ID#<CFELSE>javascript:loginmsg();</CFIF>"><IMG SRC="pictures/cart_add.gif" WIDTH="22" HEIGHT="15" BORDER="0" ALIGN="absmiddle"></A><CFELSE> $#NumberFormat(price, "__.__")# <A HREF="#GooglePlay#"><IMG SRC="pictures/cart_add.gif" WIDTH="22" HEIGHT="15" BORDER="0" ALIGN="absmiddle"></A></CFIF></TD>--->

      <TD ALIGN="right" VALIGN="bottom"  CLASS="style3Trans" ><STRONG>MP3</STRONG> <IMG SRC="pictures/blink_arrow.gif" WIDTH="4" HEIGHT="7"></TD>
	  <TD ALIGN="right" VALIGN="bottom"  CLASS="style3Trans" HEIGHT="15"><CFIF Promo EQ 1 AND DateDiff("d",now(),Promo_end) GT 0><EM>(#DateDiff("d",now(),Promo_end)# days left)</EM>&nbsp;&nbsp; $&nbsp; <STRONG>FREE</STRONG> <A HREF="<CFIF IsDefined('client.ClientID')>add_promo.cfm?ID=#ID#<CFELSE>javascript:loginmsg();</CFIF>"><IMG SRC="pictures/cart_add.gif" WIDTH="22" HEIGHT="15" BORDER="0" ALIGN="absmiddle"></A><CFELSE> $#NumberFormat(price, "__.__")# <A HREF="javascript:ShowViewCart('AddToCart=true&opus=#Evaluate(ID+10000)#')"><IMG SRC="pictures/cart_add.gif" WIDTH="22" HEIGHT="15" BORDER="0" ALIGN="absmiddle"></A></CFIF></TD>
--->	   
        <CFELSE>
        <TD> </TD><TD> </TD>
        </CFIF>

	  	</TR>  
	  <!--- <TR>
      <TD COLSPAN="3" ALIGN="center" VALIGN="top" ><IMG WIDTH="340"  HEIGHT="25" SRC="pictures/shim.gif"></TD>
	</TR>   --->


</TABLE></TD></TR>
--->


<!--- Compact Disc --->
<CFIF trim(album.Format) EQ 'Compact Disc'>
<TR CLASS="styleTiny"><TD CLASS="styleTiny" ALIGN="CENTER"><CFIF FileExists('#GetDirectoryFromPath(ExpandPath("*.*"))#pictures\CD\#album.name#.jpg')><IMG SRC="pictures/CD/<cfoutput>#album.name#</cfoutput>.jpg" ALIGN="middle"></CFIF></TD></TR>
</CFIF>

<!--- infobox --->
<cfoutput><TR><TD><TABLE WIDTH="280" HEIGHT="280"ALIGN="CENTER" CELLPADDING="3" CELLSPACING="0" CLASS="style2bTrans"  BGCOLOR="##FFFFFF">
    
    <TR>
      <TD VALIGN="TOP" BGCOLOR="##EBCD29" CLASS="styleTiny">&nbsp;</TD>

<CFIF FileExists('#GetDirectoryFromPath(ExpandPath("*.*"))#pictures/icons/#lcase(Replace(album.Name," ","_","ALL"))#.jpg')>
<CFSET AlbumIcon = 'pictures/icons/#lcase(Replace(album.Name,' ','_','ALL'))#.jpg' > 
<CFELSE>
<CFSET AlbumIcon = 'pictures/icons/generic.jpg' >
</CFIF>
    
      <TD BGCOLOR="##EBCD29"><SPAN CLASS="styleTiny"><IMG SRC="#AlbumIcon#"></SPAN></TD>
    </TR>
    <CFIF album.CatalogNo NEQ ''>
    <TR>
      <TD ALIGN="RIGHT" VALIGN="TOP" CLASS="styleTiny">Catalog No:</TD>
      <TD VALIGN="TOP">#album.CatalogNo#</TD>
    </TR>
    </CFIF>
     <TR>
      <TD ALIGN="RIGHT" VALIGN="TOP" CLASS="styleTiny">Artist:</TD>
      <TD VALIGN="TOP">#album.Artist#</TD>
    </TR>
 
  <TR>
    <TD ALIGN="RIGHT" VALIGN="TOP" CLASS="styleTiny"  >Title:</TD>
    <TD VALIGN="TOP"  ><STRONG>#album.Name#</STRONG><cfif album.NameExt NEQ ''><br>(#album.NameExt#)</cfif></TD>
  </TR>
  <TR>
    <TD ALIGN="RIGHT" VALIGN="TOP" CLASS="styleTiny">Label:</TD>
    <TD VALIGN="TOP">#album.label#</TD>
  </TR>
<cfscript>
if(TT.seconds GT 3599) { 
TimeLength = int(TT.seconds/60/60) & ':' & NumberFormat(TT.seconds/60 mod 60,'00') & ':' & NumberFormat(TT.seconds mod 60,'00'); }
else {
TimeLength = int(TT.seconds/60) & ':' & NumberFormat(TT.seconds mod 60,'00'); }
</cfscript>
<TR>
    <TD ALIGN="RIGHT" VALIGN="TOP" CLASS="styleTiny">Length:</TD>
    <TD VALIGN="TOP">#TimeLength#</TD>
  </TR>
  <TR>
    <TD ALIGN="RIGHT" VALIGN="TOP" nowrap CLASS="styleTiny"  >Composed:</TD>
    <TD VALIGN="TOP"  >#album.Composed#</TD>
  </TR>
  <TR>
    <TD ALIGN="RIGHT" VALIGN="TOP" nowrap CLASS="styleTiny"  >Location:</TD>
    <TD VALIGN="TOP"  ><cfloop query="trackLocations">#City#<BR></cfloop></TD>
  </TR>
   <CFIF instruments.recordcount GT 0>
   <TR>
    <TD ALIGN="RIGHT" VALIGN="TOP" CLASS="styleTiny">Instruments:</TD>
    <TD VALIGN="TOP"><cfoutput query="instruments">#Replace(instruments,",","<br>","ALL")#<br /></cfoutput></TD>
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
</TABLE></TD></TR></cfoutput>



<!--- jplayer instance --->
<TR>
<TD><A NAME="contentPlayer"> </A> 
<TABLE CELLPADDING="0" CELLSPACING="0" BORDER="0" CLASS="style2c" WIDTH="100%">
<TR>
  <TD CLASS="style2cfade" nowrap="nowrap" ALIGN="CENTER">
		<DIV ID="jp_container_1" CLASS="jp-audio" >
			<DIV CLASS="jp-type-playlist" >
				<DIV CLASS="jp-gui jp-interface">
					<UL CLASS="jp-controls">
						<LI><A HREF="javascript:;" CLASS="jp-previous" TABINDEX="1">previous</A></LI>
						<LI><A HREF="javascript:;" CLASS="jp-play" TABINDEX="1">play</A></LI>
						<LI><A HREF="javascript:;" CLASS="jp-pause" TABINDEX="1">pause</A></LI>
						<LI><A HREF="javascript:;" CLASS="jp-next" TABINDEX="1">next</A></LI>
						<LI><A HREF="javascript:;" CLASS="jp-stop" TABINDEX="1">stop</A></LI>
						<LI><A HREF="javascript:;" CLASS="jp-mute" TABINDEX="1" TITLE="mute">mute</A></LI>
						<LI><A HREF="javascript:;" CLASS="jp-unmute" TABINDEX="1" TITLE="unmute">unmute</A></LI>
						<LI><A HREF="javascript:;" CLASS="jp-volume-max" TABINDEX="1" TITLE="max volume">max volume</A></LI>
					</UL>
					<DIV CLASS="jp-progress" ALIGN="LEFT">
						<DIV CLASS="jp-seek-bar">
							<DIV CLASS="jp-play-bar"></DIV>
						</DIV>
					</DIV>
					<DIV CLASS="jp-volume-bar" ALIGN="LEFT">
						<DIV CLASS="jp-volume-bar-value"></DIV>
					</DIV>
					<DIV CLASS="jp-current-time"></DIV>
					<DIV CLASS="jp-duration" ALIGN="LEFT"></DIV>
		            <!---			
                        <UL CLASS="jp-toggles" ALIGN="LEFT">
						<LI><A HREF="javascript:;" CLASS="jp-shuffle" TABINDEX="1" TITLE="shuffle">shuffle</A></LI>
						<LI><A HREF="javascript:;" CLASS="jp-shuffle-off" TABINDEX="1" TITLE="shuffle off">shuffle off</A></LI>
						<LI><A HREF="javascript:;" CLASS="jp-repeat" TABINDEX="1" TITLE="repeat">repeat</A></LI>
						<LI><A HREF="javascript:;" CLASS="jp-repeat-off" TABINDEX="1" TITLE="repeat off">repeat off</A></LI>
					</UL>
                    --->
				</DIV>
				<DIV CLASS="jp-playlist" ALIGN="CENTER">
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
For (i=0;i LTE 10; i=i+1){

OGGfile = '#OGGs##Numberformat(ID,"0000")#' & '#Numberformat(i,"00")#' & '.ogg';

if(FileExists('#OGGfile#'))  
newname = '#server_URL#/#OGGLocation#/' & '#Numberformat(ID,"0000")#' & '#Numberformat(i,"00")#' & '.ogg'; 
};

//if(IsDefined('client.clientID')) 
locOGG = '#newname#'; 
//else loc = 'http://rothkamm.com/MP3/404.mp3';  
if (locOGG EQ "") msg = "[file missing]" 
</CFSCRIPT>

<CFOUTPUT><a href="#newname#">#name# opus #ID#</a></CFOUTPUT><br>

</CFLOOP>
<!---				<SPAN>Update Required</SPAN>
					To play the media you will need to either update your browser to a recent version or update your <A HREF="http://get.adobe.com/flashplayer/" TARGET="_blank">Flash plugin</A>.
				</DIV> --->
			</DIV>
		</DIV></TD>
		</TR>
		</TABLE>		
</TD>
</TR>
</CFIF>


<!--- Title  --->
<TR> 
  <TD ALIGN="center" VALIGN="middle" CLASS="style2cfade" ><BR><BR><STRONG><cfoutput>#album.Artist# [ #album.Name# ]</cfoutput></STRONG></TD>
</TR>

  




<!--- Description text --->
<CFIF FileExists('#GetDirectoryFromPath(ExpandPath("*.*"))#linernotes\#trim(general.Name)#.htm')>
<TR><TD><TABLE CELLPADDING="0" CELLSPACING="0" BORDER="0" WIDTH="100%">
<TR>
<TD COLSPAN="2" CLASS="style3"><CFINCLUDE TEMPLATE="linernotes/#trim(general.Name)#.htm"></TD>
</TR>
</TABLE></TD></TR>
</CFIF>



<!--- Album Options --->
<TR><TD CLASS="style2cTrans"><TABLE CELLPADDING="0" CELLSPACING="1" BORDER="0" CLASS="style2" WIDTH="100%">

<CFIF FileExists('#GetDirectoryFromPath(ExpandPath("*.*"))#/pictures/albumcover/small/#trim(album.Artist)#-#trim(album.Name)#.jpg')>
<TR onMouseOver="this.style.backgroundColor='EBCD29'" onMouseOut='this.style.backgroundColor=""'  >
<TD CLASS="style2cTrans"><cfoutput>[#trim(general.Name)#]<STRONG> <A HREF="pictures/albumcover/#album.Artist#-#trim(general.Name)#.jpg">Cover</A></STRONG></cfoutput></TD>
<TD ALIGN="RIGHT" CLASS="style2cTrans" WIDTH="20"><CFOUTPUT><A HREF='pictures/albumcover/#album.Artist#-#trim(general.Name)#.jpg'><IMG SRC="pictures/gif.gif" WIDTH="13" HEIGHT="16" BORDER="0" ALIGN="ABSMIDDLE" TITLE="::: #ds# #trim(general.Name)# ::: download/view high-resolution image"></A></CFOUTPUT></TD>
</TR>
</CFIF>

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
<TD CLASS="style2cTrans"><cfoutput>[#trim(general.Name)#]<STRONG> <A HREF="pdf/rothkamm-#trim(general.Name)#-artwork.pdf" TARGET="_blank">Art Work</A></STRONG> </cfoutput></TD>
<TD ALIGN="RIGHT" CLASS="style2cTrans"   width="20" ><CFOUTPUT><A HREF="pdf/rothkamm-#trim(general.Name)#-artwork.pdf" ><IMG SRC="pictures/pdf_c.gif" WIDTH="16" HEIGHT="14" BORDER="0" ALIGN="ABSMIDDLE" TITLE="::: #ds# #trim(general.Name)# ::: download the art work"></A></CFOUTPUT></TD>
</TR>
</CFIF>

<CFIF FileExists('#GetDirectoryFromPath(ExpandPath("*.*"))#pdf\rothkamm-#trim(general.Name)#-score.pdf')>
<TR onMouseOver="this.style.backgroundColor='EBCD29'" onMouseOut='this.style.backgroundColor=""'>
<TD CLASS="style2cTrans"><cfoutput>[#trim(general.Name)#]<STRONG> <A HREF="pdf/rothkamm-#trim(general.Name)#-score.pdf" TARGET="_blank">Score</A></STRONG> </cfoutput></TD>
<TD ALIGN="RIGHT" CLASS="style2cTrans" ><CFOUTPUT><A HREF='pdf/rothkamm-#trim(general.Name)#-score.pdf' TARGET="_blank"><IMG SRC="pictures/pdf_c.gif" WIDTH="16" HEIGHT="14" BORDER="0" ALIGN="ABSMIDDLE" TITLE="::: #ds# #trim(general.Name)# ::: download the score"></A></CFOUTPUT></TD>
</TR>
</CFIF>

</TABLE>






<!--- google --->
<!--- <TABLE align="CENTER">
<TR>
<TD><div align="CENTER"><a href='http://google.com//#sclient=psy-ab&hl=en&site=&source=hp&q=<cfoutput>%22#album.artist#%22+%22#album.name#%22</cfoutput>' target="_blank"><img src="pictures/cheleasebitmapORG.gif" width="15" height="15" border="0" ></a></div>
</TD>
</TR>--->

</TABLE></TD>
</TR></TABLE><!---<CFINCLUDE TEMPLATE="foot.cfm">---></TD>
</TR>
</TABLE></DIV>




</BODY>
</HTML>
