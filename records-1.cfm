<CFQUERY NAME="FluxCD" DATASOURCE="#ds#">
SELECT  * from Album
where <!---label like '%Flux Records%' AND --->  Released > '1994-01-01' AND  Released <= '#DateFormat(now(),"YYYY-MM-DD")#'
AND label like '%Flux Records%' OR label like '%Monochrome Vision%' OR label like '%baskaru%'
ORDER by Released DESC
</CFQUERY>
<HTML>

<!-- (c) rothkamm 2004 | Rothkamm.com case study | coldfusion mx 6.1 | dreamweaver mx 7.0 | sql server 2000 | fireworks MX 6.0 | photoshop 7.0 | windows 2003 server -->

<HEAD>
<TITLE><CFOUTPUT>#ds##script_name#</CFOUTPUT> </TITLE>
<CFINCLUDE TEMPLATE="_javascript.cfm">
<LINK HREF="css.css" REL="stylesheet" TYPE="text/css">
</HEAD>

<BODY >
<div id="margin-left:auto; margin-right:auto;">
<DIV ID="menue"><CFINCLUDE TEMPLATE="_menue2.cfm"></DIV>
<DIV ID="Layer2"><CFINCLUDE TEMPLATE="_header.cfm"></DIV>
<cfinclude template="_layers.cfm">
<DIV ID="Layer1"><!--- CONTENT --->
<TABLE WIDTH="100%" BORDER="0" ALIGN="right" CELLPADDING="1" CELLSPACING="0"  BGCOLOR="#3F3F3F">

  <TR>
  
    <TD VALIGN="TOP"><TABLE BORDER="0"  WIDTH="100%" CELLPADDING="10" CELLSPACING="0" BGCOLOR="#FFFFFF">
	     		 

	    <TR>
        
         <TD ALIGN="center" VALIGN="middle" ><TABLE BORDER="0"  CELLPADDING="0" CELLSPACING="8" <!--- CLASS="style2bTransb" ---> BACKGROUND="pictures/shimWhiteChecker.gif">
<cfoutput query="FluxCD">
<CFIF (currentrow-1) MOD 3 EQ 0><TR></CFIF>
<TD  ALIGN="CENTER" NOWRAP VALIGN="TOP"><A HREF='album.cfm?#Replace(name," ","-","ALL")#'><IMG SRC='product/small/#trim(lcase(Replace(name," ","","ALL")))#cd.jpg' BORDER="0"></A></TD>
<TD width="94" align="center" class="style2b"><A HREF='album.cfm?#Replace(name," ","-","ALL")#'><strong>#name#</strong><cfif NameExt neq ''><br />(#NameExt#)</cfif></A><br /><SPAN CLASS="styleTiny">#DateFormat(Released,"M/D/YYYY")#</SPAN></TD>
<CFIF (currentrow-1) MOD 3 EQ 2></TR></CFIF>
</cfoutput>
</TABLE></TD>
		</TR>
		
		
</TABLE><CFINCLUDE TEMPLATE="foot.cfm"></TD></TR></TABLE>              
                          
                          
    </TD></TR></TABLE>


</DIV>
</BODY>

</HTML>




