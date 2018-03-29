<!--- <CFINCLUDE template="/security.cfm"> --->

<CFIF Not IsDefined("client.clientID")>

<CFIF a EQ "a">
<CFSET client.clientID = "1111">
<CFELSE>
<cfabort>
</CFIF>

</CFIF>


<CFIF IsDefined('print_letter')> 
<CFLOCATION URL="print/env_1.cfm?WHERE LinksID=#LinksID#">
</CFIF> 

<!--- <CFIF IsDefined('print_envelope')>
<CFLOCATION URL="print/env_1.cfm?WHERE LinksID=#LinksID#">
</CFIF>  ---> 
<CFSET LastQuery = CGI.QUERY_STRING>  
  
<CFIF IsDefined('updateDB')>
<CFQUERY NAME="updated" DATASOURCE="#ds#">
UPDATE links SET 
FirstName = '#Trim(FirstName)#' ,
LastName  = '#Trim(LastName)#'  ,
CompanyName = '#Trim(CompanyName)#' ,
Address1  = '#Trim(Address1)#'  ,
Address2  = '#Trim(Address2)#'  ,
city      = '#Trim(city)#'      ,
state     = '#Trim(state)#'     ,
ZIP       = '#Trim(ZIP)#'       ,
country   = '#Trim(country)#'   ,
email     = '#Trim(email)#'     ,
address   = '#Trim(address)#'   ,
phone     = '#Trim(phone)#'     ,
CDs       = '#Trim(CDs)#'       ,
CD2       = '#Trim(CD2)#'       ,
CD3       = '#Trim(CD3)#'       ,
CD4       = '#Trim(CD4)#'       ,
CD5       = '#Trim(CD5)#'       ,
CD6       = '#Trim(CD6)#'       ,
CD7       = '#Trim(CD7)#'       ,
CD8       = '#Trim(CD8)#'       , status = '#Trim(status)#'       ,
category  = '#Trim(category)#' 
WHERE LinksID = '#LinksID#'
</CFQUERY> 

<CFSET Search = '#Trim(Address1)#'>

</CFIF>

<CFIF IsDefined('menue1')>
<CFQUERY NAME="newlink" DATASOURCE="#ds#">
UPDATE links SET category = '#category#'
WHERE LinksID = '#LinksID#'
</CFQUERY>
</CFIF>

<CFIF IsDefined('Delete')>
<CFQUERY DATASOURCE="#ds#">
DELETE from links WHERE LinksID = '#Delete#'
</CFQUERY>
</CFIF>

<CFIF IsDefined('CDed')>
<CFQUERY DATASOURCE="#ds#">
UPDATE links SET CDed = #CreateODBCDateTime(Now())#, CDs = 1
WHERE LinksID = '#LinksID#'
</CFQUERY>
</CFIF>

<CFIF IsDefined('Emailed')>
<CFQUERY DATASOURCE="#ds#">
UPDATE links SET Emailed = #CreateODBCDateTime(Now())#
WHERE LinksID = '#LinksID#'
</CFQUERY>
</CFIF>

<CFIF IsDefined('REcategory')>
<CFQUERY DATASOURCE="#ds#">
 UPDATE links SET category = '#REcategory#'
WHERE LinksID = '#LinksID#'
</CFQUERY>
<CFSET URL.category = REcategory>
</CFIF>


<!--- <CFIF NOT IsDefined('category')><CFSET URL.category = 'press'><CFELSE><CFSET URL.category = category></CFIF> --->
<!--- <CFIF NOT IsDefined('country')><CFSET URL.country = ''><CFELSE><CFSET URL.country = country></CFIF> --->

<CFIF IsDefined('Search')>

 <CFIF NOT IsDefined('textfield')><CFSET textfield = Search></CFIF> 

<CFQUERY NAME="allLinksID" DATASOURCE="#ds#">
SELECT * from links 
where  address like '%#textfield#%' OR
       Address1 like '%#textfield#%' OR 
       Address2 like '%#textfield#%' OR
       FirstName like '%#textfield#%' OR
	   LastName like '%#textfield#%' OR
	   City like '%#textfield#%' OR
       CompanyName like '%#textfield#%' OR
	   email like '%#textfield#%'
</CFQUERY>


<CFELSE>

<CFQUERY NAME="allLinksID" DATASOURCE="#ds#">
SELECT * from links
<!--- WHERE Emailed = '' OR CDed = '' --->
<CFIF IsDefined('category')>
 <CFIF category NEQ ''>
  WHERE category = '#Trim(category)#'
 </CFIF>
<CFELSEIF IsDefined('country')>
  WHERE country = '#Trim(country)#'
<CFELSEIF IsDefined('status')>
  WHERE status = 1
<CFELSEIF IsDefined('Reaction')>
  WHERE Emailed <> ''
<CFELSE>
  WHERE LinksID = '-1'
</CFIF>
order by  LastName, FirstName, CompanyName
</CFQUERY>

</CFIF>

<CFQUERY NAME="allDone" DATASOURCE="#ds#">
SELECT * from links
WHERE category <> ''
<CFIF IsDefined('category')>
AND  category = '#Trim(category)#'
</CFIF>
<CFIF IsDefined('country')>
AND  country = '#Trim(country)#'
</CFIF>
AND (Address1 <> '') AND (status = 0)
order by LastName, FirstName, Companyname, address
</CFQUERY>

<CFQUERY DATASOURCE="#ds#" NAME="cat">
SELECT DISTINCT category FROM links
WHERE category <> ''
AND (Address1 <> '') <!--- AND (Aus = 0) --->
</CFQUERY>

<CFQUERY DATASOURCE="#ds#" NAME="cnt">
SELECT DISTINCT country FROM links
where (Address1 <> '') AND (status = 0)
</CFQUERY>

<CFQUERY DATASOURCE="#ds#" NAME="Qall">
SELECT DISTINCT LinksID FROM links
WHERE (status < 1) AND Address1 <> '' AND category not like '%patron%' 
<!--- AND category not like '' ---><!--- category <> '' AND ---> 
</CFQUERY>

<CFQUERY DATASOURCE="#ds#" NAME="FB01">
SELECT DISTINCT address FROM links
WHERE CDs > 0
</CFQUERY>

<CFQUERY DATASOURCE="#ds#" NAME="FB02">
SELECT DISTINCT address FROM links
WHERE CD2 > 0
</CFQUERY>

<CFQUERY DATASOURCE="#ds#" NAME="MoersWorks">
SELECT DISTINCT address FROM links
WHERE CD2 > 0
</CFQUERY>

<CFQUERY DATASOURCE="#ds#" NAME="FB03">
SELECT DISTINCT address FROM links
WHERE CD4 > 0
</CFQUERY>

<CFQUERY DATASOURCE="#ds#" NAME="LAX">
SELECT DISTINCT address FROM links
WHERE CD5 > 0
</CFQUERY>

<CFQUERY DATASOURCE="#ds#" NAME="USA">
SELECT     COUNT(Address1) AS count
FROM         links
WHERE     ((status < 1) AND Address1 <> '' AND category not like '%patron%'  AND (Country LIKE '%usa%'))
</CFQUERY>

<CFQUERY DATASOURCE="#ds#" NAME="CAN">
SELECT     COUNT(Address1) AS count
FROM         links
WHERE     ((status < 1) AND Address1 <> '' AND category not like '%patron%'  AND (Country LIKE '%canada%'))
</CFQUERY>

<CFQUERY DATASOURCE="#ds#" NAME="WORLD">
SELECT     COUNT(Address1) AS count
FROM         links
WHERE     ((status < 1) AND Address1 <> '' AND category not like '%patron%'  AND (Country NOT LIKE '%usa%') AND (Country NOT LIKE '%canada%') AND (Country <> ''))
</CFQUERY>



<HTML>

<!-- (c) rothkamm 2004 | Rothkamm.com case study | coldfusion mx 6.1 | dreamweaver mx 7.0 | sql server 2000 | fireworks MX 6.0 | photoshop 7.0 | windows 2003 server -->

<HEAD>
<TITLE><CFOUTPUT>#ds##script_name#</CFOUTPUT> </TITLE>
<LINK HREF="css.css" REL="stylesheet" TYPE="text/css">
</HEAD>

<BODY >
<DIV ID="margin-left:auto; margin-right:auto;">
<DIV ID="Layer2"><CFINCLUDE TEMPLATE="_header.cfm"></DIV>
<CFINCLUDE template="_layers.cfm">

<div id="Layer1"><!--- CONTENT --->
<TABLE WIDTH="100%" BORDER="0" ALIGN="right" CELLPADDING="1" CELLSPACING="0"  BGCOLOR="#3F3F3F">

  <TR>
    
    <TD VALIGN="top"><!--- <img src="pictures/topbar.gif"> ---><TABLE WIDTH="100%" BORDER="0" ALIGN="center" CELLPADDING="0" CELLSPACING="10" BGCOLOR="#ffffff">
<TR ALIGN="CENTER">
<TD COLSPAN="3" CLASS="style5"><CFOUTPUT>#Qall.recordcount#</DIV></CFOUTPUT>
  <!--That heyday of the tobacco aristocracy in Virginia - the middle decades of the 18th century -- was the youth of nearly all the leaders of the Revolutionary Virginia and of those who were to become the "Virginia Dynasty" in the young Federal government. Washington was born in 1732; Monroe, the last of the group, in 1758. The biographies and letters of these men reveal a closely intermarried social "Four-Hundred". (from Daniel J. Boorstin "The Americans - The Colonial Experience"  --></TD>
</TR>
 
 <TR>
<TD ALIGN="RIGHT" VALIGN="TOP" NOWRAP CLASS="style3" ><CFOUTPUT QUERY="cat"> <SPAN CLASS="style2b"><A HREF="#script_name#?category=#category#">#category#</A></SPAN> <CFIF Find('#adminIP#',REMOTE_ADDR)><A HREF="print/#category#_1.rtf"></CFIF><IMG SRC="pictures/questionmark.gif" TITLE="Edit Template RTF: Personalization" WIDTH="16" HEIGHT="11" BORDER="0" ALIGN="ABSMIDDLE"></A> <BR>
</CFOUTPUT>
<BR>
[<A HREF="<CFOUTPUT>#script_name#</CFOUTPUT>?Reaction=1" TITLE="show: active/responsive">1</A>]
<BR>
[<A HREF="<CFOUTPUT>#script_name#</CFOUTPUT>?Aus=1" TITLE="show: deactived/non-responsive">0</A>]<BR>
<BR>
<cfoutput>USA: #USA.count#<BR>
CAN: #CAN.count#<BR>
WORLD: #WORLD.count# <A HREF="print/psform_2.cfm?cat=world"><IMG SRC="pictures/generate.gif" TITLE="Generate RTF: Personalization - Envelope - US Customs Form 2976" WIDTH="16" HEIGHT="11" BORDER="0" ALIGN="ABSMIDDLE"></A><BR></cfoutput>
<BR>
<CFOUTPUT><DIV CLASS="style3">
FB01[#FB01.recordcount#]<BR> 
FB02[#FB02.recordcount#]<BR>
FB03[#FB03.recordcount#]<BR>
LAX[#LAX.recordcount#]</DIV></CFOUTPUT><BR></TD>
 
 <TD ALIGN="CENTER" VALIGN="TOP" CLASS="style3" BACKGROUND="pictures/globe.jpg"><DIV ALIGN="JUSTIFY"><CFOUTPUT QUERY="cnt">[#numberformat(currentrow,'00')#]<A HREF="#script_name#?country=#country#"> #lcase(country)#</A> <BR></CFOUTPUT></DIV><BR><IMG SRC="pictures/shim.gif" WIDTH="160" HEIGHT="1"></TD>

<TD ALIGN="RIGHT" VALIGN="TOP" CLASS="style3"><FORM NAME="SearchForm" METHOD="post" ACTION="<CFOUTPUT>#script_name#</CFOUTPUT>"><INPUT NAME="textfield" TYPE="text" CLASS="style2b" SIZE="12"><INPUT NAME="Search" TYPE="submit" CLASS="style2b" VALUE="whois?">
</FORM></TD>
</TR>
<TR ALIGN="CENTER"><TD COLSPAN="3" CLASS="style3">
<!--- <IMG WIDTH="100"  ALIGN="ABSMIDDLE" HEIGHT="1" SRC="pictures/E1E1E1.gif"> <CFOUTPUT>#category#</CFOUTPUT> <IMG WIDTH="100"  ALIGN="ABSMIDDLE" HEIGHT="1" SRC="pictures/E1E1E1.gif"> ---></TD>
    </TR>
  

<CFOUTPUT QUERY="allLinksID">
 
 <CFIF len(address) GT 8>
<CFSET x1 = ReReplace(address,'(http://www.|http://)','','ALL')>
<!--- <CFSET x2 = ReFind('( |/)',x1)>
<CFIF  x2 EQ 0>
<CFSET x2 = len(x1)></CFIF>
<CFSET x3 = left(x1,x2)>
<CFSET x4 = Replace(x3,'/','')> --->
<CFSET show_address = left(x1,6)>
<!--- <CFSET display_link = x4> --->
<CFSET display_link = '<IMG SRC="pictures/outlink.gif" border="0">'>
<CFSET display_address = address>
 <CFELSE>
<CFSET display_address = 'http://google.com/search?q="#CompanyName#"'>
<CFSET display_link = '[?]'>
<CFSET show_address = ''> 
 </CFIF>
 
     <SCRIPT TYPE="TEXT/JAVASCRIPT">
	    function open_link#currentrow#() {
	       <CFIF IsDefined('client.ClientID')>
		  d =  window.open('#display_address#','rothkamm_link',''); d.focus(); 
		  <CFELSE>
		  alert('*** Protected ***');
		  // MM_showHideLayers('HereA','','show');
		  // window.scroll(0,0);
	      </CFIF> }
	   </SCRIPT>


	<TR> 
    <CFIF len(Address1) GT 2 >
	<CFSET addressed = '<IMG SRC="pictures/vcf2.gif" WIDTH="16" HEIGHT="11" BORDER="0">'>
	<CFELSE>
	<CFSET addressed = '<IMG SRC="pictures/questionmark.jpg" WIDTH="16" HEIGHT="11" BORDER="0">'>
	</CFIF>
     
	<CFIF len(Emailed) GT 3>
	<CFSET TDstyle = "style2bstrong">
	<CFELSE>
	<CFSET TDstyle = "style3">
	</CFIF>   
	  
	  <TD VALIGN="top" CLASS="style3" ><CFIF Emailed NEQ ''><IMG HEIGHT="17" WIDTH="7"SRC="pictures/black-box-yellow-border.gif">
</CFIF>#Evaluate(abs(recordcount-currentrow)+1)#.#alldone.recordcount# #DateFormat(created,"M/D/YY")#<BR><CFIF country NEQ ''><IMG SRC="pictures/home.gif" ALIGN="ABSMIDDLE"><SPAN CLASS="style2cfade">#lcase(country)#</SPAN></CFIF><A HREF='#display_address#' CLASS="style3" TARGET="_blank" >#display_link#</A></TD>
    <TD VALIGN="top"  CLASS="#TDstyle#" ><CFIF status NEQ 0><strike></CFIF>
      #FirstName# #LastName#<BR>
         <!--- <CFIF Emailed NEQ '' OR Find('#adminIP#',REMOTE_ADDR)> ---><!--- </CFIF><CFIF Find('192.168.0.',REMOTE_ADDR) OR Find('127.0.0.1',REMOTE_ADDR) OR Find('#adminIP#',REMOTE_ADDR)> ---><cfif CompanyName NEQ ''><STRONG>#CompanyName#</STRONG><BR></cfif>
      <!---  <EM>#show_address#</EM>...<br> --->
#Address1#<BR>
<cfif Address2 NEQ ''>#Address2#<BR></cfif>
	#City# #State# #ZIP#<BR>
	<cfif Country NEQ 'USA'>#Country#</cfif><!--- </CFIF> --->	</TD>
      <TD ALIGN="RIGHT" VALIGN="top" NOWRAP  CLASS="style2cfade" ><A HREF="javascript:;" onClick="MM_showHideLayers('Here#currentrow#','','show')" onMouseDown="MM_showHideLayers('Here#currentrow#','','show')" >#addressed#</A><BR><CFIF CDs GT 0>FB01</CFIF><BR><CFIF CD2 GT 0>FB02</CFIF><BR><CFIF CD3 GT 0>Moers Works</CFIF><BR><CFIF CD4 GT 0>FB03</CFIF><BR><CFIF CD5 GT 0>LAX</CFIF></TD>
    </TR>
   <TR>
     <TD COLSPAN="3" ALIGN="right" VALIGN="top" CLASS="style2"><CFIF len(Emailed) GT 3><IMG WIDTH="256" HEIGHT="2" SRC="pictures/3F3F3F.gif"><CFELSEIF len(CDed) GT 3><IMG WIDTH="128" HEIGHT="2" SRC="pictures/3F3F3F.gif"><CFELSE><IMG WIDTH="15" HEIGHT="2" SRC="pictures/3F3F3F.gif"></CFIF></TD>
</TR>
</CFOUTPUT>
  
 <TR>
      <TD COLSPAN="3" ALIGN="right" VALIGN="top" CLASS="style3" ><IMG WIDTH="100%"  HEIGHT="1" SRC="pictures/E1E1E1.gif"><BR>
        <A HREF="javascript:Add_Link()"><IMG SRC="pictures/E1E1E1.gif" WIDTH="5" HEIGHT="5" BORDER="0">add contact</A></TD>
  </TR>
  
</TABLE>
<CFINCLUDE TEMPLATE="foot.cfm"></TD>
</TR>
</TABLE></TD>
</TR>
</TABLE></td></tr></table>

<!------------------------------ INFO BOXES ------------------------------------>

 
<!--- <CFIF Find('192.168.0.',REMOTE_ADDR) OR Find('127.0.0.1',REMOTE_ADDR) OR Find('#adminIP#',REMOTE_ADDR)> --->
<!--- <CFIF IsDefined('client.ClientID')> --->
<CFOUTPUT QUERY="allLinksID" > 

<DIV ID="Here#currentrow#" STYLE="position:absolute; left:610px; top:#Evaluate(Int((currentrow-1)*85+158))#; z-index: 101; visibility: hidden; border: 1px none ##000000; width: 306px;" >



  <FORM ACTION="#script_name#" METHOD="post" NAME="updateDB"><TABLE WIDTH="310" BORDER="0" CELLPADDING="0" CELLSPACING="10" CLASS="style2b" >
  <TR>
   
    <TD ALIGN="RIGHT" VALIGN="top">
<A HREF="print/psform_1.cfm?WHERE LinksID=#LinksID#"><IMG SRC="pictures/txt.gif" ALT="make PS Form 2976 rtf" WIDTH="13" HEIGHT="16" BORDER="0" ALIGN="MIDDLE"></A> <A HREF="print/env_1.cfm?WHERE LinksID=#LinksID#"><IMG SRC="pictures/mail.jpg" ALT="make envelope rtf" WIDTH="14" HEIGHT="11" BORDER="0" ALIGN="MIDDLE"></A> <CFIF Emailed EQ ''><A HREF="#script_name#?LinksID=#LinksID#&Emailed=yes&category=#category#" CLASS="style2b" TITLE="mark as [E]mailed (admin only)">E</A>
</CFIF> <CFIF CDed EQ ''><A HREF="#script_name#?LinksID=#LinksID#&CDed=yes&category=#category#" CLASS="style2b" TITLE="mark as [P]ackaged">P</A></CFIF> <A HREF="#script_name#?Delete=#LinksID#&category=#category#" CLASS="style2b" TITLE="[D]elete link">D</A> <A HREF="javascript:Add_Link()" CLASS="style2b" TITLE="[A]dd a link">A</A> 
	
	 

<CFSET CC = ''><CFIF IsDefined('category')>
<CFSET CC = '#category#'></CFIF>
<CFSET CL = '#LinksID#'>	

	<SELECT NAME="category" CLASS="style3">
               <OPTION VALUE="" SELECTED>CATEGORY</OPTION>
			   <CFLOOP QUERY="cat">
               <OPTION VALUE="#category#" #IIF(CC EQ category, DE('SELECTED'), DE(''))#>#category#</OPTION>
			   </CFLOOP>
    </SELECT></TD>
  </TR>
  <TR>
  
    <TD ALIGN="RIGHT" VALIGN="top">
	FirstName<INPUT NAME="FirstName" TYPE="text" CLASS="style3" VALUE="#FirstName#" SIZE="40"><BR>
    LastName<INPUT NAME="LastName" TYPE="text" CLASS="style3" VALUE="#LastName#" SIZE="40"><BR>
	CompanyName<INPUT NAME="CompanyName" TYPE="text" CLASS="style3" VALUE="#CompanyName#" SIZE="40"><BR>
	Address1<INPUT NAME="Address1" TYPE="text" CLASS="style3" VALUE="#Address1#" SIZE="40"><BR>
	Address2<INPUT NAME="Address2" TYPE="text" CLASS="style3" VALUE="#Address2#" SIZE="40"><BR>
	City<INPUT NAME="City" TYPE="text" CLASS="style3" VALUE="#City#" SIZE="40"><BR>
	State<INPUT NAME="State" TYPE="text" CLASS="style3" VALUE="#State#" SIZE="40"><BR>
	ZIP<INPUT NAME="ZIP" TYPE="text" CLASS="style3" VALUE="#ZIP#" SIZE="40"><BR>
	country<INPUT NAME="country" TYPE="text" CLASS="style3" VALUE="#country#" SIZE="40"><BR>
	email<INPUT NAME="email" TYPE="text" CLASS="style3" VALUE="#email#" SIZE="40"><BR>
	phone<INPUT NAME="phone" TYPE="text" CLASS="style3" VALUE="#phone#" SIZE="40"><BR>
	www<INPUT NAME="address" TYPE="text" CLASS="style3" VALUE="#address#" SIZE="40"><BR>
	CDs<INPUT NAME="CDs" TYPE="text" CLASS="style3" VALUE="#CDs#" SIZE="40"><BR>
	CD2<INPUT NAME="CD2" TYPE="text" CLASS="style3" VALUE="#CD2#" SIZE="40"><BR>
	CD3<INPUT NAME="CD3" TYPE="text" CLASS="style3" VALUE="#CD3#" SIZE="40"><BR>
	CD4<INPUT NAME="CD4" TYPE="text" CLASS="style3" VALUE="#CD4#" SIZE="40"><BR>
	CD5<INPUT NAME="CD5" TYPE="text" CLASS="style3" VALUE="#CD5#" SIZE="40"><BR>
	CD6<INPUT NAME="CD6" TYPE="text" CLASS="style3" VALUE="#CD6#" SIZE="40"><BR>
	CD7<INPUT NAME="CD7" TYPE="text" CLASS="style3" VALUE="#CD7#" SIZE="40"><BR>
	CD8<INPUT NAME="CD8" TYPE="text" CLASS="style3" VALUE="#CD8#" SIZE="40"><BR> status<INPUT NAME="status" TYPE="text" CLASS="style3" VALUE="#status#" SIZE="40"><BR>
	<INPUT NAME="LinksID" TYPE="hidden" VALUE="#LinksID#">
	<!--- <INPUT NAME="category" TYPE="hidden" VALUE="#category#"> --->
	<INPUT NAME="updateDB" TYPE="submit" CLASS="style3" VALUE="updateDB"></TD>
	
  <TR>
    <TD ALIGN="right" VALIGN="buttom" CLASS="style2"><A HREF="javascript:MM_showHideLayers('Here#currentrow#','','hide');" TITLE="close"><IMG SRC="pictures/remove.gif" BORDER="0" ALIGN="bottom"></A></TD>
  </TR>
</TABLE></FORM>
<!--- <CFELSE><IMG SRC="pictures/SampleRecord.jpg" BORDER="0" USEMAP="##MapSampleRecord#currentrow#">
<MAP NAME="MapSampleRecord#currentrow#">
<AREA SHAPE="RECT" COORDS="289,332,301,343" HREF="javascript:MM_showHideLayers('Here#currentrow#','','hide');">
</MAP> --->


</DIV>
</CFOUTPUT>
<!--- </CFIF> --->


</DIV>
</BODY>

</HTML>
