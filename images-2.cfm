
<!--- <CFCACHE ACTION="CLIENTCACHE" timespan="#createTimeSpan(1,0,0,0)#"> --->
<!--- <CFINCLUDE TEMPLATE="_loginlogic.cfm"> --->

<CFIF IsDefined('Regenerate')>
<CFQUERY DATASOURCE='#ds#'>DELETE FROM pics</CFQUERY>
</CFIF>

<CFSET n=0>

<!--- <CFIF NOT IsDefined('client.ClientID')>
<CFSET client.ClientID = "0121BDA5-E147-7A54-F31C6D9989F9BDC6">
</CFIF> --->

<HTML>

<!-- (c) rothkamm 2004 | Rothkamm.com case study | coldfusion mx 6.1 | dreamweaver mx 7.0 | sql server 2000 | fireworks MX 6.0 | photoshop 7.0 | windows 2003 server -->
<!-- (c) frank rothkamm 2015 railo 3.3.4 vim mysql gimp darktable centos -->
<HEAD>
<TITLE><CFOUTPUT>#ds##script_name#</CFOUTPUT> </TITLE>
<CFINCLUDE TEMPLATE="_javascript.cfm">
<LINK HREF="css.css" REL="stylesheet" TYPE="text/css">
</HEAD>

<SCRIPT TYPE="TEXT/JAVASCRIPT">
function CloseOnUnFocus() { 
if (window.a) { ClosedWindow = a.close(); }
}
</SCRIPT>

<BODY  >
<div id="margin-left:auto; margin-right:auto;">
<DIV ID="menue"><CFINCLUDE TEMPLATE="_menue2.cfm"></DIV>
<DIV ID="Layer2"><CFINCLUDE TEMPLATE="_header.cfm"></DIV>
<CFINCLUDE template="_layers.cfm">

<DIV ID="Layer1"><!--- CONTENT --->
<TABLE WIDTH="100%" BORDER="0" ALIGN="right" CELLPADDING="1" CELLSPACING="0"  BGCOLOR="3F3F3F">

<!--- <CFQUERY DATASOURCE='#ds#' NAME='ns'>
	SELECT n FROM pics
</CFQUERY> --->
  <TR>
 
    <TD><TABLE WIDTH="100%"  BORDER="0" ALIGN="center" CELLPADDING="0" CELLSPACING="10" BGCOLOR="FFFFFF">
<TR>
<TD></TD>
</TR>

<CFDIRECTORY  ACTION="LIST" DIRECTORY="#GetDirectoryFromPath(ExpandPath("*.*"))#image" SORT="name ASC" NAME="main">
<CFOUTPUT QUERY="main">
<CFIF (type EQ 'DIR') AND (NOT name is ".") AND (NOT name is "..") AND (NOT Find("_",name)) AND (NOT Find("albumcover",name))>
<CFSET cDir = '#name#'>
	 		 
	 <CFDIRECTORY ACTION="list" sort="name ASC" FILTER="*.jpg" DIRECTORY="#GetDirectoryFromPath(ExpandPath("*.*"))#image/#cDir#/thumbs" NAME="alljpg">
	 <TR><TD CLASS="style2b" COLSPAN="2" WIDTH="615">&nbsp;<SPAN CLASS="style2cfade">#name#</SPAN></TD>
<!--- <TD CLASS="style3"><A HREF="download.cfm/#left(cDir,3)#/#cDir#.pdf"><IMG SRC="pictures/pdf_c.gif" WIDTH="16" HEIGHT="16" BORDER="0" ALIGN="TOP"></A></TD> --->
</TR>
	 
	 <TR ALIGN="LEFT">
     <TD COLSPAN="2" VALIGN="MIDDLE" CLASS="style2c" ><CFLOOP QUERY="alljpg">
<SCRIPT TYPE="TEXT/JAVASCRIPT">
	    function photodetail_#n#(Motion) {
	<!---       <CFIF IsDefined('client.ClientID')> --->
		    <CFIF IsDefined('Regenerate')>
			<!------------------ START Improve speed --------------------------------------->
			<!-----------------Conditional Execution of CFX Tag----------------------->
			<CFX_IMAGE ACTION="READ" FILE="#GetDirectoryFromPath(ExpandPath("*.*"))#image\#cDir#\#name#">
			<CFQUERY DATASOURCE='#ds#'>INSERT INTO pics 
		     (cDir,name,IMG_WIDTH,IMG_HEIGHT,n) 
		     VALUES ('#cDir#','#name#','#IMG_WIDTH#','#IMG_HEIGHT#','#n#')
			</CFQUERY>
			<CFELSE><!-----------------Otherwise Read from database---------------------------->  
		    <CFQUERY DATASOURCE='#ds#' NAME='p'>
			 SELECT * FROM pics WHERE n = '#n#'
			</CFQUERY>
			 Photo('#n#',Motion) 
			</CFIF> 
			<!------------------ END Improve speed --------------------------------------->
		  <!--- <CFELSE> 
		  alert('*** Protected *** :: Log-in or Register :: Registration is FREE, easy and confidential ::');
		  MM_showHideLayers('HereA','','show');
		  window.scroll(0,0);
	      </CFIF> javascript:photodetail_#n#(); ---> };
	   </SCRIPT><A HREF="<!--- <CFIF IsDefined('client.ClientID')> --->image/#cDir#/#name#<!--- <CFELSE>javascript:loginmsg();</CFIF> --->"><IMG SRC="image/#cDir#/thumbs/#name#" BORDER="0" ALIGN="TOP" ></A><CFIF ((currentrow) mod 5) EQ 0><BR><IMG WIDTH="21"  HEIGHT="21" SRC="pictures/shim.gif"><BR>
<CFELSE><CFIF NOT currentrow EQ alljpg.recordcount><IMG WIDTH="21"  HEIGHT="21" SRC="pictures/shim.gif"></CFIF></CFIF><CFSET n=n+1></CFLOOP></TD>       
</TR>
	
    <!--- 
    <TR><TD COLSPAN="2" ALIGN="right" VALIGN="top"  CLASS="style3" ><A HREF="download.cfm/#left(cDir,3)#/#cDir#.pdf"><IMG SRC="pictures/pdf_c.gif" WIDTH="16" HEIGHT="16" BORDER="0" ALIGN="TOP"> <IMG SRC="pictures/download.gif" WIDTH="13" HEIGHT="13" BORDER="0" ALIGN="TOP"> download as PDF</A><BR><IMG SRC="pictures/shim.gif" WIDTH="50" HEIGHT="30"></TD>
	  
      </TR> 
     --->
</CFIF>  
</CFOUTPUT>
</TABLE></TD>
  </TR>
</TABLE></TD></TR></TABLE>

</DIV>
</BODY>

</HTML>
