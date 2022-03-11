<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:cml="http://www.xml-cml.org/schema" xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
  xmlns="http://www.w3.org/1999/xhtml" xmlns:dc="http://purl.org/dc/elements/1.1/" version="2.0">

<xsl:param name="title" />
  <xsl:template match="/">
    <xsl:apply-templates />
  </xsl:template>


  <xsl:template match="svrl:schematron-output">
    <html>
      <head>
        <title>schematron failed unit tests</title>
    <!-- CSS only -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous"/>
<!-- JavaScript Bundle with Popper -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM" crossorigin="anonymous"></script>
      </head>
      <body>
	  <div style="margin:50px">
	  <h1 class="display-5">Validation sémantique : <xsl:value-of select="$title" /> </h1>
<table class="table table-striped table-hover">
  <thead>
    <tr>
      <th scope="col">Erreur</th>
      <th scope="col" style="width: 50%">Location</th>
    </tr>
  </thead>
  <tbody>
		<xsl:apply-templates />
		
  </tbody>
</table>		
		</div>
      </body>
    </html>
  </xsl:template>

  <xsl:template match="svrl:failed-assert">
  

    <tr>
      <td>	  
		  <xsl:call-template name="break">
		<xsl:with-param name="text" select="svrl:text" />
		</xsl:call-template>
	</td>
      <td class=".small">
	  <xsl:value-of select="preceding-sibling::svrl:active-pattern[1]/svrl:title" />
	  <small><xsl:value-of select="@location" /></small></td>

    </tr>
	


    <xsl:apply-templates />
  </xsl:template>

    <xsl:template match="svrl:successful-report">
	
    <tr>
      <td>	  
		  <xsl:call-template name="break">
		<xsl:with-param name="text" select="svrl:text" />
		</xsl:call-template>
	</td>
      <td class=".small"><small><xsl:value-of select="@location" /></small></td>

    </tr>
	

  

        <xsl:apply-templates />
    </xsl:template>

  <xsl:template match="*">
    <!-- drop these -->
  </xsl:template>
  
<xsl:template name="break">
  <xsl:param name="text" select="string(.)"/>
  <xsl:choose>
    <xsl:when test="contains($text, '&#xa;')">
      <xsl:value-of select="substring-before($text, '&#xa;')"/>
      <br/>
      <xsl:call-template name="break">
        <xsl:with-param 
          name="text" 
          select="substring-after($text, '&#xa;')"
        />
      </xsl:call-template>
    </xsl:when>
    <xsl:otherwise>
      <xsl:value-of select="$text"/>
    </xsl:otherwise>
  </xsl:choose>
</xsl:template>  
  
</xsl:stylesheet>
