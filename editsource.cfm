<cfinclude template="security.cfm" >


<CFIF IsDefined('Submit')>
<CFIF NOT Find('192.168.0.',REMOTE_ADDR)>
*** ERROR *** contact <script>var a = "ad" + "min" + String.fromCharCode(0x40) + "rothkamm.com"; document.write('<a href="mailto:' + a + '">' + a + '</a>'); </script> for editing privileges.
<CFELSE>
<CFFILE ACTION="WRITE" FILE="#GetDirectoryFromPath(ExpandPath('*.*'))##sourcefile#" OUTPUT="#textarea#">
</CFIF>
</CFIF>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3.org/TR/html4/loose.dtd">
<HTML>
<HEAD>
<TITLE>rothkamm source</TITLE>
<META HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=iso-8859-1">
<STYLE TYPE="text/css">
<!--
.style4 {font-family: "Courier New", Courier, mono; font-size: 12px; }
-->
</STYLE>
</HEAD>

<CFFILE ACTION="READ" FILE="#GetDirectoryFromPath(ExpandPath('*.*'))##sourcefile#" VARIABLE="body">

<FORM NAME="formtext" METHOD="post" ACTION="<CFOUTPUT>#script_name#</CFOUTPUT>">
<TABLE WIDTH="800" BORDER="0" CELLSPACING="0" CELLPADDING="0">
<TR>
<TD COLSPAN="2" CLASS="style4">
<TEXTAREA NAME="textarea" COLS="120" ROWS="40" WRAP="VIRTUAL" CLASS="style4"><CFOUTPUT>#body#</CFOUTPUT></TEXTAREA>
<INPUT NAME="sourcefile" TYPE="hidden" VALUE="<CFOUTPUT>#sourcefile#</CFOUTPUT>">
</TD></TR>
<TR><TD CLASS="style4">
[ <A HREF="<CFOUTPUT>#sourcefile#</CFOUTPUT>">rothkamm.com<CFOUTPUT>#sourcefile#</CFOUTPUT></a><CFIF IsDefined('Submit')> was saved</CFIF> ] </TD>
<TD ALIGN="RIGHT"><INPUT TYPE="submit" NAME="Submit" VALUE="Save Document" CLASS="style4"></TD>
</TR>
</TABLE></FORM>
</BODY>
</HTML>
