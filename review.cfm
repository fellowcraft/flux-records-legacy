<CFQUERY NAME="review" DATASOURCE="#ds#">
select * from <cfif IsDefined('url.radio_playlist')>radio<cfelse>reviews</cfif>
where ID = #trim(left(ID,3))#
</CFQUERY>

<CFQUERY NAME="author" DATASOURCE="#ds#">
select * from links
where CompanyName like <cfif IsDefined('url.radio_playlist')>'%#review.station#%'<cfelse>'%#review.company#%'</cfif>
</CFQUERY>

<HTML>

<HEAD>
<TITLE><CFOUTPUT>#ds##script_name#</CFOUTPUT></TITLE>
</HEAD>
<BODY>

<div id="Layer1"><!--- CONTENT --->
<CFOUTPUT>
Album: <a href=/album.cfm?#Replace(review.album,' ','+','ALL')#>#review.album#</a><br>
Author: #review.author#<br>
Publication: #review.company#<br>
Date: #DateFormat(review.datetime,'M/D/YYY')#
<br><br>
#REReplace(review.text,'(#Chr(13)##Chr(10)#| #chr(10)#)','<br>','ALL')#
<br><br>
[ Permalink: http://rothkamm.com?review.cfm?ID=#ID# ]
</CFOUTPUT>
</div>
</BODY>
</HTML>
