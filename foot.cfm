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
    CLASS="style2"><A HREF="albums.cfm"><span class="style6"><cfoutput>#album.recordcount#</cfoutput > ALBUMS<!---<cfoutput>#chr(174)#</cfoutput>---></span></a></TD> 


</TR>
<TR>

<TD ALIGN="right" 
    valign="buttom" 
    CLASS="style2"><A HREF="works.cfm"><span class="style6"><cfoutput>#track.recordcount#</cfoutput > WORKS<!---<cfoutput>#chr(174)#</cfoutput>---></span></A></TD>

</TR>
<TR>

<TD ALIGN="right" 
    valign="buttom" 
    CLASS="style2"><A HREF="press.cfm" ><span class="style6"><cfoutput>#reviews.recordcount#</cfoutput > REVIEWS<!---<cfoutput>#chr(174)#</cfoutput>---></span></A></TD>

</TR>
<TR>

<TD ALIGN="right" 
    valign="buttom" 
    CLASS="style2"><A HREF="biography.cfm" ><span class="style6">1 BIO<!---<cfoutput>#chr(174)#</cfoutput>---></span></A></TD>

</TR>
<TR>

<TD ALIGN="right" 
    valign="buttom" 
    CLASS="style2"><A HREF="register.cfm" ><span class="style6">0 CONTACT<!---<cfoutput>#chr(174)#</cfoutput>---></span></A></TD>

</TR>
<TR>

<TD><br />
<br />
<br />
<br />
</TR>
</TABLE>
