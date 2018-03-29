<CFQUERY NAME="all" DATASOURCE="#ds#">
select count(ID) as Parts from PART
WHERE Status <> 0
</CFQUERY>

<CFQUERY NAME="records" DATASOURCE="#ds#">
SELECT  * from Album
</CFQUERY>

<CFQUERY NAME="FluxCDcomposed" DATASOURCE="#ds#">
SELECT  * from Album
where Released <= '#DateFormat(now(),"YYYY-MM-DD")#'
ORDER by RIGHT(Composed,4) DESC, Released DESC 
<!--- ORDER by RAND() --->
</CFQUERY>

<CFQUERY NAME="A" DATASOURCE="#ds#">
select ID, Status from PART
WHERE Status <> 0
</CFQUERY>

<CFQUERY NAME="AllReviews" DATASOURCE="#ds#" >
select ID from reviews
</CFQUERY>

<CFQUERY NAME="album" DATASOURCE="#ds#">
SELECT AlbumID FROM Album
</CFQUERY>

<CFQUERY NAME="track" DATASOURCE="#ds#">
SELECT ID  FROM PART 
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

<HTML>

<HEAD>
<TITLE><CFOUTPUT>#records.recordcount# albums #A.recordcount# works #AllReviews.recordcount# reviews 1 bio 0 contact #chr(169)# #chr(174)# ROTHKAMM 1982-#DateFormat(now(),'YYYY')# </CFOUTPUT></TITLE>

<meta name="viewport" content="width=device-width, initial-scale=1.0">

<CFINCLUDE template="favicon.cfm">

<LINK HREF="css.css" REL="stylesheet" TYPE="text/css"></HEAD>

<BODY>
<TABLE ID="LayerE" WIDTH="50%" CELLPADDING="10" CELLSPACING="10" BGCOLOR="EBCD29" >
<TR>
<TD><br />
<br />
<br />
</TD> 
</TR>
<TR>
<TD ALIGN="right" 
    valign="buttom" 
    CLASS="style2"><A HREF="albums.cfm"><span class="style6"><cfoutput>#album.recordcount#</cfoutput > ALBUMS</span></a></TD> 


</TR>
<TR>

<TD ALIGN="right" 
    valign="buttom" 
    CLASS="style2"><A HREF="works.cfm"><span class="style6"><cfoutput>#track.recordcount#</cfoutput > WORKS</span></A></TD>

</TR>
<TR>

<TD ALIGN="right" 
    valign="buttom" 
    CLASS="style2"><A HREF="press.cfm" ><span class="style6"><cfoutput>#reviews.recordcount#</cfoutput > REVIEWS</span></A></TD>

</TR>
<TR>

<TD ALIGN="right" 
    valign="buttom" 
    CLASS="style2"><A HREF="biography.cfm" ><span class="style6">1 BIOGRAPHY</span></A></TD>

</TR>
<!---
<TR>
<TD ALIGN="right" 
    valign="buttom" 
    CLASS="style2"><A HREF="register.cfm" ><span class="style6">0 CONTACT</span></A></TD>

</TR>
--->
<TD ALIGN="right" 
    valign="buttom" 
    CLASS="style2">
<a href="https://www.youtube.com/channel/UCxXM8NaAs5lF0g-ueiZwHqw"><IMG SRC="pictures/icons/icon-youtube-b.png" WIDTH="31" HSPACE=10 VSPACE=2></a><a href="https://www.facebook.com/rothkamm"><IMG SRC="pictures/icons/icon-facebook-b.png" WIDTH="31" HSPACE=10 VSPACE=2></a><a href="https://github.com/lfus/wp"><IMG SRC="pictures/icons/icon_GitHub-Mark.png" WIDTH="31" HSPACE=10 VSPACE=2></a><a href="https://twitter.com/rothkamm"><IMG SRC="pictures/icons/twitter.jpg" WIDTH="31" HSPACE=10 VSPACE=2></a><a href="https://play.google.com/store/music/artist?id=Avxn4ftlroneg4hradcznfcivlu"><IMG SRC="pictures/icons/icon_google_play.jpg"  WIDTH="31" HSPACE=10 VSPACE=2></a><a href="http://frankrothkamm.bandcamp.com"><IMG SRC="pictures/icons/bandcamp_60x60_black.jpg" WIDTH="31" HSPACE=10 VSPACE=2></a></TD>
</TR>





<TR>
<TD ALIGN="right" >
<cfoutput query="FluxCDcomposed" startRow="1" maxRows="590">

<CFSET URLAlbum = URLencodedFormat(Trim(name)) >

<CFSET AlbumImage = 'pictures/albumcover/small/#URLencodedFormat(Artist)#-#URLAlbum#.jpg' >

<CFSET URLAlbum = Replace(URLAlbum,"%20","+","ALL")>

<A HREF='album.cfm?#URLAlbum#'><IMG WIDTH=10 VSPACE=6 HSPACE=6 SRC='#AlbumImage#' BORDER="1" TITLE="#Artist# #name# #NameExt# #Composed#"></A>

<CFIF (currentrow) MOD 10 EQ 0><BR></CFIF>
</cfoutput>
</TD>
</TR>


<TR>
<TD ALIGN="right" 
    valign="buttom" 
    CLASS="style2">

<!-- Begin MailChimp Signup Form -->
<link href="//cdn-images.mailchimp.com/embedcode/classic-081711.css" rel="stylesheet" type="text/css">
<style type="text/css">
#mc_embed_signup{
background:#fff; 
clear:left; 
font:10px Helvetica,Arial,sans-serif; 
}
/* Add your own MailChimp form style overrides in your site stylesheet or in this style block.
	   We recommend moving this block and the preceding CSS link to the HEAD of your HTML file. */
</style>
<div id="mc_embed_signup">
<form action="//lfus.us11.list-manage.com/subscribe/post?u=50f5ee81acb6d99647f3b9269&amp;id=d6e8a8620e" method="post" id="mc-embedded-subscribe-form" name="mc-embedded-subscribe-form" class="validate" target="_blank" novalidate>
<!---
<div id="mc_embed_signup_scroll">
	<h2>Subscribe to my private list. Unsubscribe anytime.</h2>
<div class="indicates-required"><span class="asterisk">*</span> indicates required</div>
--->
<div class="mc-field-group">
	<label for="mce-EMAIL">Email Address  <span class="asterisk">*</span>
</label>
	<input type="email" value="" name="EMAIL" class="required email" id="mce-EMAIL">
</div>
<!---
<div class="mc-field-group">
	<label for="mce-FNAME">First Name </label>
	<input type="text" value="" name="FNAME" class="" id="mce-FNAME">
</div>
<div class="mc-field-group">
	<label for="mce-LNAME">Last Name </label>
	<input type="text" value="" name="LNAME" class="" id="mce-LNAME">
</div>
--->
<div id="mce-responses" class="clear">
		<div class="response" id="mce-error-response" style="display:none"></div>
		<div class="response" id="mce-success-response" style="display:none"></div>
	</div>    <!-- real people should not fill this in and expect good things - do not remove this or risk form bot signups-->
    <div style="position: absolute; left: -5000px;" aria-hidden="true"><input type="text" name="b_50f5ee81acb6d99647f3b9269_d6e8a8620e" tabindex="-1" value=""></div>
<div class="clear"><input type="submit" value="Subscribe" name="subscribe" id="mc-embedded-subscribe" class="button"></div>
<p align=center >FHR Editions &#176; 2520 Cimarron Street &#176; Los Angeles, CA 90018 &#176; USA<br>
<img src="pictures/FHRseal.jpg" WIDTH=100 VSPACE=10 TITLE="The Royal Seal of the FHR Editions">
</p>
</div>
</form>
</div>
<!--End mc_embed_signup-->
</TD>
</TR>

<TR>
<TD><br />
<br />
<br />
</TD> 
</TR>

</TABLE>
</BODY>
</HTML>
