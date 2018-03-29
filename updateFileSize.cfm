<!--- <cfinclude template="security.cfm"> --->


<!--- 
<CFX_AudioInfo FOLDER="E:/rothkamm/ROTHKAMM/MP3">

<cfoutput>#AudioInfo.recordcount#</cfoutput>

<CFOUTPUT QUERY="AudioInfo">

#File# - #BitRate# - #Seconds#
.
<br />

</CFOUTPUT> --->


<CFIF IsDefined('url.RequestTimeOut')>
<CFSETTING RequestTimeOut="#url.RequestTimeOut#">
<CFELSE>
<CFSETTING RequestTimeOut="3600">
</CFIF>




<CFDIRECTORY  ACTION="LIST" DIRECTORY="/var/www/html/rothkamm/ROTHKAMM/MP3320" FILTER="*.mp3" SORT="name ASC" NAME="main">


<CFOUTPUT QUERY="main">

<cfif len(name) GT 8>
<!--- 
<cfset MP3inSeconds = size / (320*92) >

#name# - #MP3inSeconds#  - #size#
 --->

<!--- <cfscript>
For (i=0;i LTE 10; i=i+1){

NewVersion = '#left(name,"4")#' & '#Numberformat(i,"00")#' & '.mp3';

if(FileExists('#NewVersion#'))  
name = NewVersion; 
};
</cfscript> --->



<cfset MP3File = GetFileInfo('/var/www/html/rothkamm/ROTHKAMM/MP3320/#name#') >
<cfset FileSizeSeconds = int(MP3File.Size/40000)>
<!--- mp3AudioHeader.getTrackLengthAsString()--->
<!--- display --->
#name# - #FileSizeSeconds# - #DateFormat(MP3File.LastModified,'YYYY-MM-DD')#


<cfif FileSizeSeconds GTE 4>

<CFQUERY NAME="new" DATASOURCE="rothkamm">
UPDATE    PART
SET       length = #FileSizeSeconds#,
          last_modified = '#DateFormat(dateLastModified,"YYYY-MM-DD")#'
WHERE     ID = #left(name,4)#

</CFQUERY>

</cfif>

<!--- 
<cfoutput>MP3File.getFrequency() : #MP3File.getFrequency()# Hz</cfoutput><br>
<cfoutput>MP3File.getVersion() : #MP3File.getVersion()#</cfoutput><br> --->

<!--- <cfoutput>MP3File.isCopyRighted() : #MP3File.isCopyRighted()#</cfoutput><br>
<cfoutput>MP3File.getChannelMode() : #MP3File.getChannelMode()#</cfoutput><br>
 --->

<br /> 




</cfif>



</CFOUTPUT>

