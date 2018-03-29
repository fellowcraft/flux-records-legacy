<CFSILENT><CFSET ds="rothkamm">

<CFAPPLICATION NAME="#ds#" 
 SESSIONMANAGEMENT="Yes" 
 CLIENTMANAGEMENT="YES" >

<!--- SQL injection defense --->

<CFIF REFindNoCase("(declare|convert|select|\(|\|\-\-')|%3d|%2b",CGI.QUERY_STRING)>404.1<CFABORT></CFIF>

<CFIF IsDefined('URL.ID')>
 <cfif NOT IsValid("integer", URL.ID)>404.2<CFABORT></cfif>
</CFIF>

<CFIF IsDefined('URL.opus')>
 <cfif NOT IsValid("integer", URL.opus)>404.3<CFABORT></cfif>
</CFIF>

<!---
<!--- <cfif NOT IsDefined('client.clientID')> --->
<CFFILE ACTION="append"
        FILE="#GetDirectoryFromPath(GetCurrentTemplatePath())#\logs#DateFormat(now(),'YYYYMM')#.txt"
        OUTPUT="#Now()# IP:#REMOTE_ADDR# PATH:#SCRIPT_NAME#?#QUERY_STRING#">
<!--- </cfif> --->
--->


<CFSET drive = "/var/www/html/rothkamm">
<CFSET root="http://rothkamm.com/"> 
<CFSET MediaPath="http://rothkamm.com/records/MP3">
<CFSET media_URL="http://rothkamm.com/">
<CFSET Media = "#drive#/ROTHKAMM/NewMedia/">
<CFSET FLACs = "#drive#/ROTHKAMM/FLAC/">
<CFSET OGGs = "#drive#/ROTHKAMM/OGG/">
<CFSET MP3s = "#drive#/ROTHKAMM/MP3320/">
<CFSET MP3L = "#drive#/ROTHKAMM/MP3320/">
<cfset MP3Location = 'MP3320'>
<cfset OGGLocation = 'OGG'>
<cfset FLACLocation = 'FLAC'>
<CFSET MP3samples = "#drive#/ROTHKAMM/MP3sample/">
<CFSET pictures = "pictures"> 


<CFSET server_URL = "https://rothkamm.com">


<CFSET rootIP = "138.128.120.17">

<CFSET adminIP = "127.0.0.1">
<CFSET adminIP = "192.168.0.">
<CFSET adminIP = "99.2.222.241">

<CFSET METAcontent = "#chr(174)#">


</CFSILENT>

<!---
<CFIF NOT Find('#adminIP#','#cgi.REMOTE_ADDR#')>
<script type="text/javascript">

  var _gaq = _gaq || [];
  _gaq.push(['_setAccount', 'UA-3849360-1']);
  _gaq.push(['_trackPageview']);

  (function() {
    var ga = document.createElement('script'); ga.type = 'text/javascript'; ga.async = true;
    ga.src = ('https:' == document.location.protocol ? 'https://ssl' : 'http://www') + '.google-analytics.com/ga.js';
    var s = document.getElementsByTagName('script')[0]; s.parentNode.insertBefore(ga, s);
  })();

</script> 
</CFIF>
--->

<!DOCTYPE html>
