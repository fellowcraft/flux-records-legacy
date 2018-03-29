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


<TABLE ID="LayerE" WIDTH="100%" CELLPADDING="0" CELLSPACING="3" BGCOLOR="EBCD29" >
<TR>
<TD><br />
<br />
<br />
</TD> 
</TR>
<TR>
<TD ALIGN="right" 
    valign="buttom" 
    CLASS="style2"><A HREF="albums"><span class="style6"><cfoutput>#album.recordcount#</cfoutput><br>ALBUMS<!---<cfoutput>#chr(174)#</cfoutput>---></span></a></TD> 

<TD ALIGN="right" 
    valign="buttom" 
    CLASS="style2"><A HREF="works"><span class="style6"><cfoutput>#track.recordcount#</cfoutput><br> WORKS<!---<cfoutput>#chr(174)#</cfoutput>---></span></A></TD>


<TD ALIGN="right" 
    valign="buttom" 
    CLASS="style2"><A HREF="reviews" ><span class="style6"><cfoutput>#reviews.recordcount#</cfoutput><br>REVIEWS<!---<cfoutput>#chr(174)#</cfoutput>---></span></A></TD>

<!---<TD ALIGN="right" valign="buttom" nowrap="nowrap" CLASS="style3"><A HREF="images.cfm" >images</A></TD>--->

<TD ALIGN="right" 
    valign="buttom" 
    CLASS="style2"><A HREF="bio" ><span class="style6">1<br>BIO<!---<cfoutput>#chr(174)#</cfoutput>---></span></A></TD>

<TD ALIGN="right" 
    valign="buttom" 
    CLASS="style2"><A HREF="contact" ><span class="style6">0<br>CONTACT<!---<cfoutput>#chr(174)#</cfoutput>---></span></A></TD>
<!---
<TD ALIGN="right" 
    valign="buttom" 
    nowrap="nowrap" 
    CLASS="style2"><A HREF="register.cfm" ><span class="style6">List<!---<cfoutput>#chr(174)#</cfoutput>---></span></A></TD>
--->
</TR>
<TR>
<TD><br />
<br />
<br />
<br />
</TR>
</TABLE>
