<CFQUERY DATASOURCE="#ds#" NAME="websites">
SELECT * FROM websites
</CFQUERY>

<CFQUERY NAME="allstyles" DATASOURCE="#ds#">
SELECT * FROM Style 
ORDER BY Style
</CFQUERY>

<CFQUERY NAME="allparts" DATASOURCE="#ds#">
SELECT * FROM PART
WHERE status <> 0
ORDER BY YEAR DESC, Month DESC, Day DESC
</CFQUERY>

<CFQUERY NAME="FluxCD" DATASOURCE="#ds#">
SELECT  * from Album
<!--- WHERE Released <= '#DateFormat(now(),"YYYY-MM-DD")#' ---> 
</CFQUERY>

<CFQUERY NAME="SoloAlbum" DATASOURCE="#ds#">
SELECT  * from Album
<!--- WHERE Released <= '#DateFormat(now(),"YYYY-MM-DD")#' ---> 
where solo = 1
</CFQUERY>


<cfset myarray = listToArray(valueList(websites.url))>

<CFIF IsDefined('Regenerate')>
<CFQUERY DATASOURCE='#ds#'>DELETE FROM pics</CFQUERY>
</CFIF>

<CFSET n=0>


<HTML>

<HEAD>
<TITLE><CFOUTPUT>LIFE since 1965 #chr(174)#</CFOUTPUT> </TITLE>

<meta name="viewport" content="width=622">


<CFINCLUDE template="favicon.cfm">

<CFINCLUDE TEMPLATE="_javascript.cfm">
<LINK HREF="css.css" REL="stylesheet" TYPE="text/css">
</HEAD>

<BODY >
<div id="margin-left:auto; margin-right:auto;">
<DIV ID="Layer2"><CFINCLUDE TEMPLATE="_header.cfm"></DIV>
<!--- <cfinclude template="_layers.cfm"> --->
<DIV ID="Layer1"><!--- CONTENT --->
<TABLE WIDTH="100%" BORDER="0" ALIGN="right" CELLPADDING="1" CELLSPACING="0"  BGCOLOR="FFFFFF">

  <TR>
  
    <TD VALIGN="TOP">
    <TABLE WIDTH="100%"  BORDER="0" ALIGN="center" CELLPADDING="0" CELLSPACING="10" BGCOLOR="FFFFFF">

<TR>
        
         <TD ALIGN="left" VALIGN="middle" ><IMG SRC="http://chart.apis.google.com/chart?cht=t&chs=300x160&chd=t:0,100,50&chco=FFFFFF,FF0000,00FF00&chld=US&chtm=world" BORDER="0" CLASS="style2" ID="Image7"><IMG SRC="http://chart.apis.google.com/chart?cht=t&chs=300x160&chd=t:0,100,50&chco=FFFFFF,FF0000,00FF00&chld=DE&chtm=europe" BORDER="0" CLASS="style2" ID="Image7"></TD>
</TR>



<!--- Images 
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
		  MM_showHideLayers('HereA',",'show');
		  window.scroll(0,0);
	      </CFIF> javascript:photodetail_#n#(); ---> };
	   </SCRIPT><A HREF="<!--- <CFIF IsDefined('client.ClientID')> --->image/#cDir#/#name#<!--- <CFELSE>javascript:loginmsg();</CFIF> --->"><IMG SRC="image/#cDir#/thumbs/#name#" BORDER="0" ALIGN="TOP" ></A><CFIF ((currentrow) mod 5) EQ 0><BR><IMG WIDTH="10"  HEIGHT="3" SRC="pictures/shim.gif"><BR>
<CFELSE><CFIF NOT currentrow EQ alljpg.recordcount><IMG WIDTH="22"  HEIGHT="33" SRC="pictures/shim.gif"></CFIF></CFIF><CFSET n=n+1></CFLOOP></TD>       
</TR>
	
 
   
    <!---   <TR><TD COLSPAN="2" ALIGN="right" VALIGN="top"  CLASS="style3" ><A HREF="download.cfm/#left(cDir,3)#/#cDir#.pdf"><IMG SRC="pictures/pdf_c.gif" WIDTH="16" HEIGHT="16" BORDER="0" ALIGN="TOP"> <IMG SRC="pictures/download.gif" WIDTH="13" HEIGHT="13" BORDER="0" ALIGN="TOP"> download as PDF</A><BR><IMG SRC="pictures/shim.gif" WIDTH="50" HEIGHT="30"></TD>
  
	  
      </TR> --->
</CFIF>  
</CFOUTPUT>

--->

</TABLE><TABLE BORDER="0"  WIDTH="100%" CELLPADDING="10" CELLSPACING="0" BGCOLOR="FFFFFF">
	     		 
		
	      <TR> 
		<TD><P class="style3"><span class="style2">F</span>rank Rothkamm (born July 2, 1965) is a German composer and artist who lives and works in the United States of America.  Frank is the founder of Flux Records (est. 1994 in Brooklyn, New York) and the Lodge For Utopian Science (est. 2013 in View Park, Los Angeles). To-date he has released <cfoutput>#FluxCD.recordcount#</cfoutput> albums, <cfoutput>#SoloAlbum.recordcount#</cfoutput> of them solo, and has composed <cfoutput>#allparts.recordcount#</cfoutput> works ranging from the microscopic 4 second "ID 7" (opus 13) to the 7 hour and 27 minute macroscape of "Midtown" (opus 596). <br>
            <br>
            <span class="style2">O</span>riginally interested in drawing in his pre-teen years, as a teenager Frank produced a graphical notation system for music, studied to become a pianist at the "Musikschule" (music school), built his own electronic music studio and worked as both a composer and actor at the "Schloss Theater" (castle theatre) in Moers, Germany. After a stay as postulant at the cloister of Lilienfeld, Austria, he rose to prominence in Moers with FISCH II, a performance involving analog tape music, lights, 4 actor-instrumentalists and a fish.
            <br><br>
            <span class="style2">F</span>rank refused to serve in the army and was forced to work in a hospital in Cologne for his civil service. At the same time he studied privately with Clarence Barlow, lived in the artist-run gallery Atelier Soemmering, where he produced his first body-manipulation works and performed in galleries & clubs, culminating in the release of his first solo album in 1986 via the Maria Bonk Gallery.<br>
            <br>
            <span class="style2">A</span>fter studies in communication science, bionics and philosophy at the Technische Universität Berlin, where he co-founded the CAMP group, studied Csound with Horacio Vaggione and performed at the International Computer Music Conference 1988, he left Europe and moved to Canada. There Frank composed, for his first wife Emily Faryna - FISCH III 5 - his first digital sampling based album, studied privately Forth with Kenneth Newby and wrote his first commercial software - PaintMusic - for Science World of British Columbia. He concluded with coding FM synthesis for computer games (Unlimited Software), working for Rodney Graham and the last FISCH performance in Vancouver, Canada.
           <br><br>
            <span class="style2">M</span>oving to San Francisco in 1990, Frank appeared with his second wife Monique Marquisa de Magdalena in Playboy magazine, organized raves and performed with digital tape music, lights, 2 dancers and a drummer at clubs where he met his third wife Nina Schneider. His first appearance on 12'' vinyl record "Magick Sounds of the Underground' (Hardkiss Records) and on Compact Disc "Death Rave 2000" (21st Circuitry Records), as well as the establishment of his first production company "Suite Zero" followed after writing his first commercials for Levi's 501 (Foote, Cone & Belding) in 1992. <br>
            <br>
            <span class="style2">R</span>elocating to New York in 1993, he suffered his first panic attacks, symptoms of a mental illness that severely and progressively impacted his life for 19 years until starting drug treatment after becoming suicidal. He composed and remixed for the Cranberries, DJ Spooky, Wolfgang Muthspiel, Elliott Sharp, Alfred Harth, Peter Scherer, Corin Curschellas and produced his first industrials for corporate clients like Sears. In 1995 the first of his 2 soundtracks for George Lucas "Star Wars 3D" trailers (New York Film & Animation) appeared. In 1997 his Flux Records released DJ Glove's "Tuning", a 12'' record of a woman tuning a piano, and Frank became the last Freemason of the German-speaking Hermann Lodge to be initiated in Manhattan. The last of his digital sampling based works was Elvis Presley's "Fever" in 2001.<br>
           <br>
            <span class="style2">A</span>fter gaining his first internet client in 1998, a pet sanctuary in upstate New York, Frank moved to Hollywood and for the next 11 years worked on web design, Adobe Coldfusion development and Microsoft server administration for numerous clients - from Vampire Cosmetics to Warner Bros. – all the while moving between Los Angeles and New York. He was bi-coastal from 2001-2004 and 2007-2009. In 2000 he became the Director of Technology for Musicblitz in Culver City and he was the Senior Systems Analyst for the New York Philharmonic from 2006-2009. <br>
            <br>
            <span class="style2">F</span>ollowing the licensing of the Flux Records catalog to ringtone providers, Frank had an epiphany in the summer of 2002 in Hollywood and devised a new method of composition. All works were now created on the verge of sleep through IFORMM, a keyboard instrument he built from 2002 to 2006 with Atari ST and 1st generation MIDI module parts. 2007 saw the destruction of his entire archive of hardware and master tapes in the California Witch Creek wildfire, but Frank continued with the method until 2010, when he released his first syntheastic film - "Birth of Primary Cinema from the Spirit of Sound" - made after he passed out on a flight from New York to Copenhagen.<br>
            <br>
            <span class="style2">F</span>rom 2005-2010 he averaged 3 Compact Disc releases per year on Flux Records. Meanwhile, Moscow-based label Monochrome Vision discovered and released his teenage "Moers Works (1982-1984)" in 2006 and Paris-based label Baskaru issued ALT in 2009 - a survey of this 1989-2002 algorithmic work with analog computers. After his first album of organ music "just 3 organs" (2008) and piano music "Opus Spongebobicum" (2008) he restored a 1924 E.Gabler & Bros. grand piano and went back to practicing Czerny and Mozart.<br>
            <br>
            <span class="style2">F</span>rom 2010-2015 Frank restored a 1935 Steinkamp house in View Park, California, migrated to open-source Linux software and licenses, built a collection of vintage computers, keyboards and related books; and following his diagnosis with the brain processing disorder Tinnitus, formulated <em>psychostochastics</em> as a research discipline and method of composition. The first public result of this was the "Wiener Process" (2010-2014), a 24 hour 24 part Csound score written in 3 computer languages, released on Baskaru as a datastream, download and a 24 Compact Disc box set.<br><br>
            <span class="style2">O</span>n July 2, 2015 his Lodge For Utopian Science started to issue free open source and commercial digital editions of his <em>complete works</em> which commenced with "Stockhausen Star Formula" (2013) and ended over 20 months later on March 3rd, 2017 with "The Last Post" (2016).<br><br>
          </P></TD></TR>
</TABLE><!---<CFINCLUDE TEMPLATE="foot.cfm">---></TD></TR></TABLE>              
                          
                          
    </TD></TR></TABLE>

</DIV>
</BODY>

</HTML>
