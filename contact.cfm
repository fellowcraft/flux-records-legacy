<HTML>

<!-- (c) rothkamm 2004-2006 | Rothkamm.com case study | coldfusion 5 | dreamweaver 8 | sql server 2000 | windows 2000 server -->

<HEAD>
<TITLE><CFOUTPUT>#ds##script_name#</CFOUTPUT></TITLE>
<CFINCLUDE TEMPLATE="_javascript.cfm">
<!--- <cfinclude template="js/emailcheck.js"> --->
<LINK HREF="css.css" REL="stylesheet" TYPE="text/css"></HEAD>

<CFOUTPUT>
    <SCRIPT TYPE="TEXT/JAVASCRIPT">
	    function Import_vCard() {
	       <CFIF IsDefined('client.ClientID')>
		    location.href = 'doc/' + 'rothkamm.vcf';           
	      <CFELSE>
		  alert('*** Protected *** :: Log-in or Register :: Registration is FREE, easy and confidential.');
		  MM_showHideLayers('HereA','','show');
		  window.scroll(0,0);
	      </CFIF> };
	   </SCRIPT>
</CFOUTPUT>

<BODY ><div id="margin-left:auto; margin-right:auto;">
<DIV ID="Layer2"><CFINCLUDE TEMPLATE="_header.cfm"></DIV>
<CFINCLUDE template="_layers.cfm">

<DIV ID="Layer1"><!--- CONTENT --->
<TABLE WIDTH="100%" BORDER="0" ALIGN="right" CELLPADDING="1" CELLSPACING="0"  BGCOLOR="#3F3F3F">
  <TR>
    <TD VALIGN="top"> 
	<TABLE WIDTH="100%" BORDER="0" ALIGN="center" CELLPADDING="20" CELLSPACING="0" BGCOLOR="#ffffff">
   
  <TR>
<TD WIDTH="350" 
    ALIGN="CENTER" 
    VALIGN="MIDDLE" 
    CLASS="style3"><a href="https://www.youtube.com/channel/UCxXM8NaAs5lF0g-ueiZwHqw"><IMG SRC="pictures/icons/icon-youtube-b.png" 
    WIDTH="100" 
    HSPACE=10 
    VSPACE=10></a><a href="https://www.facebook.com/rothkamm"><IMG SRC="pictures/icons/icon-facebook-b.png" 
    WIDTH="100" 
    HSPACE=10 
    VSPACE=10></a><a href="https://instagram.com/rothkamm"><IMG SRC="pictures/icons/icon-instagram-b.png" 
    WIDTH="100" 
    HSPACE=10 
    VSPACE=10></a><a href="https://github.com/lfus"><IMG SRC="pictures/icons/icon_GitHub-Mark.png" 
    WIDTH="100" 
    HEIGHT="97"    
    HSPACE=10 
    VSPACE=10></a>
    </TD>

<TD VALIGN="middle" CLASS="style3">
     <!--- 
      <BR>
      <BR>
      <STRONG>address:</STRONG><BR>
      <!---Lodge For Utopian Science<BR>
      Frank Rothkamm
      Flux Records --->
      4188 Angeles Vista Blvd<BR> 
      View Park CA 90008<BR>
    <!---<BR>
     <BR>
    <STRONG>cell</STRONG>:<BR> 646-<SCRIPT>document.write('6'+'9'+'6-'+'9909');</SCRIPT>
    <BR>--->
    <BR>
    <BR>
    --->
     <SCRIPT>var a = "9" + String.fromCharCode(0x40) + "lf" + "us.org"; document.write('<a href="mailto:' + a + '">' + a + '</a>');</SCRIPT>
    <!---
     <BR>
      <BR>
 
   <STRONG>skype</STRONG>:<BR> 
     <SCRIPT>var a = "live:" + "frankrothkamm"; document.write(a);</SCRIPT>
      <BR>
     <br>
      <BR>
      <STRONG>web:</STRONG><BR>
      <A HREF="http://lfus.org">lfus.org</A><BR>
      <A HREF="http://IFORMM.COM">iformm.com</A><BR>
      <A HREF="http://rothkamm.com">rothkamm.com</A><BR>
      <A HREF="http://fluxrecords.com">fluxrecords.com</A><BR>
      <A HREF="http://supermodern.com">supermodern.com</A><BR>
      <BR>
      <br>
  <!---    <STRONG>social media:</STRONG><br>
      <A HREF="http://youtube.com/rothkamm">youtube.com/rothkamm</A><br>
      <A HREF="http://facebook.com/rothkamm">facebook.com/rothkamm</A><br>
      <br>  
      --->
</P>
  --->  
  </TD>
</TR>
<!--- 
<TR ALIGN="RIGHT">
<TD COLSPAN="2" VALIGN="TOP" CLASS="style3"><IMG WIDTH="100%"  HEIGHT="1" SRC="pictures/E1E1E1.gif"><BR>
<!--- <IMG SRC="pictures/E1E1E1.gif" WIDTH="5" HEIGHT="5" BORDER="0"><A HREF="javascript:Import_vCard()">vcf card <IMG SRC="pictures/vcf.gif" WIDTH="16" HEIGHT="12" BORDER="0" ALIGN="top"></A> ---></TD>
</TR> --->
    </TABLE>
<!---<CFINCLUDE TEMPLATE="foot.cfm">---></TD></TR></TABLE></TD></TR></TABLE>
</DIV>
</BODY>
</HTML>
