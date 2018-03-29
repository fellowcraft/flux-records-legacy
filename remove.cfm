<!--- <CFIF NOT IsDefined('email')><CFSET email='Enter your email address here'></CFIF> --->

<CFIF IsDefined('URL.email')>
<CFQUERY datasource="rothkamm">
INSERT into remove (email) 
VALUES ('#trim(email)#')
</CFQUERY>
removed
</CFIF>
<cfabort>


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<LINK HREF="css.css" REL="stylesheet" TYPE="text/css">
<title>remove</title>
</head>

<body>
<p>&nbsp;</p>
<p>&nbsp;</p>
<CFIF IsDefined('Email')>
  <div align="CENTER"><cfoutput><span class="style1Trans">#email#</span></cfoutput><span class="style1Trans"> has been removed.</span>
      <CFELSE>
  </div>
  <form id="form1" name="form1" method="post" action="remove.cfm">
  <label>
  <div align="CENTER"><span class="style1Trans">Enter email address to be removed<br />
      <br />
    </span>
      <input name="Email" type="text" size="40" value=""/>
  </div>
  </label>
  <label>
  <div align="CENTER">
    <input name="Submit" type="submit" class="style1b" value="Remove" />
  </div>
  </label>
    </form
</CFIF>
</body>
</html>
