<?xml version="1.0" encoding="UTF-8"?>
<!--
  Title : cda_asip.xsl /style.xsl    
  =======================================================================================================================================================
  This StyleSheet is based on the StyleSheet "Modular CDA XSL StyleSheet (cda_modular.xsl)" made by Alchuler Associates LCC.
  Below is the original declaration of Alschuler Associates LCC
  Title: Modular CDA XSL StyleSheet
  Original Filename: style.xsl 
  Version: 3.0
  Revision History: 8/12/09 Jingdong Li updated 
  Specification: ANSI/HL7 CDA, R2-2005  
  The current version and documentation are available at www.alschulerassociates.com/cda/?topic=cda-xsl. 
  We welcome feedback to tools@alschulerassociates.com
  The stylesheet is the cumulative work of several developers; the most significant prior milestones were the foundation work from HL7 
  Germany and Finland (Tyylitiedosto) and HL7 US (Calvin Beebe), and the presentation approach from Tony Schaller, medshare GmbH provided at IHIC 2009. 
  =======================================================================================================================================================
  Suivi des version de la feuille de style française (ANS) :
    - The original StyleSheet has been modified for FRANCE in order to :
          - Translate the labels from english to french
          - Edit supplementary informations
          - Detect a Xades envelopping signature of a Clinical Document
          - add comments in case of impossibility to edit pdf files in nonXMLBody and within structuredBody with IE/EDGE and Firefox 3.x
   - Version : 1.2 (05/06/2019)
  =======================================================================================================================================================
-->
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:n1="urn:hl7-org:v3" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
  xmlns:exsl="http://exslt.org/common" exclude-result-prefixes="xsl">
  <xsl:import href="utility.xsl"/>
  <xsl:param name="limit-pdf" select="'no'"/>
  <xsl:param name="vocFile" select="'cda_l10n.xml'"/>
  <xsl:variable name="vocMessages" select="document($vocFile)"/>
  <xsl:variable name="lc" select="'abcdefghijklmnopqrstuvwxyz'"/>
  <xsl:variable name="uc" select="'ABCDEFGHIJKLMNOPQRSTUVWXYZ'"/>
  <xsl:variable name="simple-sanitizer-match">
    <xsl:text>&#10;&#13;&#34;&#39;&#58;&#59;&#63;&#96;&#123;&#125;&#8220;&#8221;&#8222;&#8218;&#8217;</xsl:text>
  </xsl:variable>
  <xsl:variable name="simple-sanitizer-replace" select="'***************'"/>
  <xsl:key name="util-i18nkey" match="translation" use="@key"/>
  <xsl:param name="textlangDefault" select="'fr-FR'"/>
  <xsl:param name="textLang">
    <xsl:choose>
      <xsl:when test="/n1:ClinicalDocument/n1:languageCode/@code">
        <xsl:value-of select="/n1:ClinicalDocument/n1:languageCode/@code"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="$textlangDefault"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:param>
  <xsl:variable name="textLangLowerCase">
    <xsl:call-template name="caseDown">
      <xsl:with-param name="data" select="$textLang"/>
    </xsl:call-template>
  </xsl:variable>
  <xsl:variable name="textLangPartLowerCase" select="substring($textLangLowerCase, 1, 2)"/>
  <xsl:variable name="textLangDefaultLowerCase">
    <xsl:call-template name="caseDown">
      <xsl:with-param name="data" select="$textlangDefault"/>
    </xsl:call-template>
  </xsl:variable>
  <xsl:variable name="textLangDefaultPartLowerCase"
    select="substring($textLangDefaultLowerCase, 1, 2)"/>

  <xsl:template name="getLocalizedString">
    <xsl:param name="pre" select="''"/>
    <xsl:param name="key"/>
    <xsl:param name="post" select="''"/>

    <xsl:for-each select="$vocMessages">
      <xsl:variable name="translation" select="key('util-i18nkey', $key)"/>
      <xsl:choose>
        <xsl:when test="$translation/value[@lang = $textLangLowerCase]">
          <xsl:value-of
            select="concat($pre, $translation/value[@lang = $textLangLowerCase]/text(), $post)"/>
        </xsl:when>

        <xsl:when test="$translation/value[substring(@lang, 1, 2) = $textLangPartLowerCase]">
          <xsl:value-of
            select="concat($pre, $translation/value[substring(@lang, 1, 2) = $textLangPartLowerCase]/text(), $post)"
          />
        </xsl:when>

        <xsl:when test="$translation/value[@lang = $textLangDefaultLowerCase]">
          <xsl:value-of
            select="concat($pre, $translation/value[@lang = $textLangDefaultLowerCase]/text(), $post)"
          />
        </xsl:when>

        <xsl:when test="$translation/value[substring(@lang, 1, 2) = $textLangDefaultPartLowerCase]">
          <xsl:value-of
            select="concat($pre, $translation/value[substring(@lang, 1, 2) = $textLangDefaultPartLowerCase]/text(), $post)"
          />
        </xsl:when>
        <xsl:when test="$translation/value[@lang = 'en-us']">
          <xsl:value-of select="concat($pre, $translation/text(), $post)"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:value-of select="concat($pre, $key, $post)"/>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:for-each>
  </xsl:template>
  <!-- show StructuredBody  -->
  <xsl:template match="n1:component/n1:structuredBody">
    <xsl:for-each select="n1:component/n1:section">
      <xsl:comment>Début de section</xsl:comment>
      <xsl:call-template name="section"/>
      <xsl:comment>Fin de section</xsl:comment>
    </xsl:for-each>
  </xsl:template>
  <!-- show nonXMLBody -->
  <xsl:template match="n1:component/n1:nonXMLBody | n1:observationMedia">
    <xsl:param name="usemap"/>
    <xsl:variable name="renderID">
      <xsl:choose>
        <xsl:when test="@ID">
          <xsl:value-of select="@ID"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:value-of select="concat(generate-id(.), '_', local-name(.))"/>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <xsl:variable name="renderAltText">
      <xsl:variable name="i18nid">
        <xsl:call-template name="getLocalizedString">
          <xsl:with-param name="key" select="'id'"/>
        </xsl:call-template>
      </xsl:variable>
      <xsl:if test="n1:id">
        <xsl:value-of select="concat($i18nid, ' = ', n1:id[1]/@root, ' ', n1:id[1]/@extension)"/>
      </xsl:if>
    </xsl:variable>
    <xsl:variable name="renderElement"
      select="self::n1:nonXMLBody/n1:text | self::n1:observationMedia/n1:value"/>
    <xsl:choose>
      <!-- if there is a reference, use that in an IFRAME -->
      <xsl:when test="$renderElement/n1:reference">
        <xsl:variable name="source" select="string('$renderElement/nl:reference/@value')"/>
        <xsl:variable name="lcSource" select="translate($source, $uc, $lc)"/>
        <xsl:variable name="scrubbedSource"
          select="translate($source, $simple-sanitizer-match, $simple-sanitizer-replace)"/>
        <xsl:message><xsl:value-of select="$source"/>, <xsl:value-of select="$lcSource"
          /></xsl:message>
        <xsl:choose>
          <xsl:when test="contains($lcSource, 'javascript')">
            <p>
              <xsl:call-template name="getLocalizedString">
                <xsl:with-param name="key" select="'javascript-injection-warning'"/>
              </xsl:call-template>
            </p>
            <xsl:message>
              <xsl:call-template name="getLocalizedString">
                <xsl:with-param name="key" select="'javascript-injection-warning'"/>
              </xsl:call-template>
            </xsl:message>
          </xsl:when>
          <xsl:when test="not($source = $scrubbedSource)">
            <p>
              <xsl:call-template name="getLocalizedString">
                <xsl:with-param name="key" select="'malicious-content-warning'"/>
              </xsl:call-template>
            </p>
            <xsl:message>
              <xsl:call-template name="getLocalizedString">
                <xsl:with-param name="key" select="'malicious-content-warning'"/>
              </xsl:call-template>
            </xsl:message>
          </xsl:when>
          <xsl:when test="$renderElement[starts-with(@mediaType, 'image/')]">
            <img alt="{$renderAltText}" title="{$renderAltText}" src="{$scrubbedSource}">
              <xsl:if test="string-length($usemap) &gt; 0">
                <xsl:attribute name="usemap">
                  <xsl:value-of select="$usemap"/>
                </xsl:attribute>
              </xsl:if>
            </img>
          </xsl:when>
          <xsl:otherwise>
            <xsl:comment>[if lte IE 9]&gt;
                  <xsl:call-template name="getLocalizedString">
                      <xsl:with-param name="key" select="'iframe-warning-ie9'"/>
                  </xsl:call-template>
              &lt;![endif]</xsl:comment>
            <xsl:comment>[if gt IE 9]&gt;</xsl:comment>
            <xsl:choose>
              <xsl:when test="$renderElement/@mediaType = 'application/pdf' and $limit-pdf = 'yes'">
                <div style="font-style: italic;">
                  <xsl:call-template name="getLocalizedString">
                    <xsl:with-param name="key" select="'iframe-warning-sandboxed-pdf'"/>
                  </xsl:call-template>
                </div>
              </xsl:when>
              <xsl:otherwise>
                <iframe name="{$renderID}" id="{$renderID}" width="100%" height="600"
                  title="{$renderAltText}">
                  <xsl:if
                    test="$renderElement/@mediaType != 'application/pdf' or $limit-pdf = 'yes'">
                    <xsl:attribute name="sandbox"/>
                  </xsl:if>
                  <xsl:attribute name="src">
                    <xsl:value-of select="$source"/>
                  </xsl:attribute>
                </iframe>
              </xsl:otherwise>
            </xsl:choose>
            <xsl:comment>&lt;![endif]</xsl:comment>
          </xsl:otherwise>

        </xsl:choose>
      </xsl:when>
      <!-- This is an image of some sort -->
      <xsl:when test="$renderElement[starts-with(@mediaType, 'image/')]">
        <img alt="{$renderAltText}" title="{$renderAltText}">
          <xsl:if test="string-length($usemap) &gt; 0">
            <xsl:attribute name="usemap">
              <xsl:value-of select="$usemap"/>
            </xsl:attribute>
          </xsl:if>
          <xsl:attribute name="src">
            <xsl:value-of
              select="concat('data:', $renderElement/@mediaType, ';base64,', $renderElement/text())"
            />
          </xsl:attribute>
        </img>
      </xsl:when>
      <!-- This is plain text -->
      <xsl:when test="$renderElement[not(@mediaType) or @mediaType = 'text/plain']">
        <pre title="{$renderAltText}">
                    <xsl:value-of select="$renderElement/text()"/>
                </pre>
      </xsl:when>

      <xsl:when test="$renderElement[@representation = 'B64']">
        <xsl:variable name="source" select="string('$renderElement/nl:reference/@value')"/>
        <xsl:variable name="vendor" select="system-property('xsl:vendor')"/>
        <xsl:comment>[if lte IE 9]&gt;
                    <xsl:call-template name="getLocalizedString">
                        <xsl:with-param name="key" select="'iframe-warning-pdf-ie9'"/>
                    </xsl:call-template>
                &lt;![endif]
        </xsl:comment>
        <xsl:comment>[if gt IE 9]&gt;</xsl:comment>
        <xsl:if test="$vendor != 'libxslt' and $vendor != 'Transformiix'">
          <xsl:call-template name="getLocalizedString">
            <xsl:with-param name="pre" select="' '"/>
            <xsl:with-param name="key"
              select="'Ce document contient un fichier PDF qui ne peut être affiché par ce navigateur'"
            />
          </xsl:call-template>
        </xsl:if>
        <xsl:choose>
          <xsl:when test="$renderElement/@mediaType = 'application/pdf' and $limit-pdf = 'yes'">
            <div style="font-style: italic;">
              <xsl:call-template name="getLocalizedString">
                <xsl:with-param name="key" select="'iframe-warning-sandboxed-pdf'"/>
              </xsl:call-template>
            </div>
          </xsl:when>
          <xsl:otherwise>
            <iframe name="{$renderID}" id="{$renderID}" width="100%" height="600"
              title="{$renderAltText}">
              <xsl:if test="$renderElement/@mediaType != 'application/pdf' or $limit-pdf = 'yes'">
                <xsl:attribute name="sandbox"/>
              </xsl:if>
              <xsl:attribute name="src">
                <xsl:value-of select="concat('data:', $renderElement/@mediaType, ';base64,', $renderElement/text())" />
              </xsl:attribute>
            </iframe>
          </xsl:otherwise>
        </xsl:choose>
        <xsl:comment>&lt;![endif]</xsl:comment>
      </xsl:when>
      <xsl:otherwise>
        <CENTER>Impossible d'afficher le texte.</CENTER>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <!-- top level component/section: display title and text,
     and process any nested component/sections
   -->
  <xsl:template name="section">
    <xsl:call-template name="section-title">
      <xsl:with-param name="title" select="n1:title"/>
    </xsl:call-template>
    <xsl:call-template name="section-author"/>
    <xsl:call-template name="section-text"/>
    <xsl:for-each select="n1:component/n1:section">
      <xsl:call-template name="nestedSection">
        <xsl:with-param name="margin" select="2"/>
      </xsl:call-template>
    </xsl:for-each>
  </xsl:template>

  <!-- top level section title -->
  <xsl:template name="section-title">
    <xsl:param name="title"/>
    <h3>
      <a name="{generate-id($title)}" href="#toc">
        <xsl:value-of select="$title"/>
      </a>
    </h3>
  </xsl:template>
  <!-- section author -->
  <xsl:template name="section-author">
    <xsl:if test="count(n1:author) &gt; 0">
      <div style="margin-left : 2em;">

        <xsl:text>Auteur(s) : </xsl:text>
        <br/>

        <xsl:for-each select="n1:author/n1:assignedAuthor">
          <xsl:choose>
            <xsl:when test="n1:assignedPerson/n1:name">
              <xsl:call-template name="show-name">
                <xsl:with-param name="name" select="n1:assignedPerson/n1:name"/>
              </xsl:call-template>

              <xsl:if test="n1:representedOrganization">
                <xsl:text>(</xsl:text>
                <xsl:call-template name="show-name">
                  <xsl:with-param name="name" select="n1:representedOrganization/n1:name"/>
                </xsl:call-template>
                <xsl:text>)</xsl:text>
                <br/>
              </xsl:if>
            </xsl:when>
            <xsl:when test="n1:assignedAuthoringDevice/n1:softwareName">
              <xsl:value-of select="n1:assignedAuthoringDevice/n1:softwareName"/>
            </xsl:when>
            <xsl:otherwise>
              <xsl:for-each select="n1:id">
                <xsl:call-template name="show-id"/>
                <br/>
              </xsl:for-each>
            </xsl:otherwise>
          </xsl:choose>
        </xsl:for-each>
        <br/>
      </div>
    </xsl:if>
  </xsl:template>
  <!-- top-level section Text   -->
  <xsl:template name="section-text">
    <div>
      <xsl:apply-templates select="n1:text"/>
    </div>
  </xsl:template>

  <!-- nested component/section -->
  <xsl:template name="nestedSection">
    <xsl:param name="margin"/>
    <h4 style="margin-left : {$margin}em;">
      <xsl:value-of select="n1:title"/>
    </h4>
    <div style="margin-left : {$margin}em;">
      <xsl:apply-templates select="n1:text"/>
    </div>
    <xsl:for-each select="n1:component/n1:section">
      <xsl:call-template name="nestedSection">
        <xsl:with-param name="margin" select="2 * $margin"/>
      </xsl:call-template>
    </xsl:for-each>
  </xsl:template>
  
  
  <!--Activation des lien linkHtml-->
  <xsl:template match="//n1:linkHtml">
    <a href="{@href}" target="_blank">
      <xsl:apply-templates /></a>
  </xsl:template>
  
  <!--   paragraph  -->
  <xsl:template match="n1:paragraph">
    <p>
      <xsl:apply-templates/>
    </p>
  </xsl:template>
  <!--   pre format  -->
  <xsl:template match="n1:pre">
    <pre>
      <xsl:apply-templates/>
    </pre>
  </xsl:template>
  <!--   Content w/ deleted text is hidden -->
  <xsl:template match="n1:content[@revised = 'delete']"/>
  <!--   content  -->
  <xsl:template match="n1:content">
    <xsl:apply-templates/>
  </xsl:template>
  <!-- line break -->
  <xsl:template match="n1:br">
    <xsl:element name="br">
      <xsl:apply-templates/>
    </xsl:element>
  </xsl:template>
  <!--   list  -->
  <xsl:template match="n1:list">
    <xsl:if test="n1:caption">
      <p>
        <b>
          <xsl:apply-templates select="n1:caption"/>
        </b>
      </p>
    </xsl:if>
    <ul>
      <xsl:for-each select="n1:item">
        <li>
          <xsl:apply-templates/>
        </li>
      </xsl:for-each>
    </ul>
  </xsl:template>
  <xsl:template match="n1:list[@listType = 'ordered']">
    <xsl:if test="n1:caption">
      <span style="font-weight:bold; ">
        <xsl:apply-templates select="n1:caption"/>
      </span>
    </xsl:if>
    <ol>
      <xsl:for-each select="n1:item">
        <li>
          <xsl:apply-templates/>
        </li>
      </xsl:for-each>
    </ol>
  </xsl:template>
  <!--   caption  -->
  <xsl:template match="n1:caption">
    <xsl:apply-templates/>
    <xsl:text>: </xsl:text>
  </xsl:template>
  <!--  Tables   -->
  <xsl:template
    match="n1:table/@* | n1:thead/@* | n1:tfoot/@* | n1:tbody/@* | n1:colgroup/@* | n1:col/@* | n1:tr/@* | n1:th/@* | n1:td/@*">
    <xsl:copy>
      <xsl:copy-of select="@*"/>
      <xsl:apply-templates/>
    </xsl:copy>
  </xsl:template>
  <xsl:template match="n1:table">
    <table class="narr_table">
      <xsl:copy-of select="@*"/>
      <xsl:apply-templates/>
    </table>
  </xsl:template>
  <xsl:template match="n1:thead">
    <thead>
      <xsl:copy-of select="@*"/>
      <xsl:apply-templates/>
    </thead>
  </xsl:template>
  <xsl:template match="n1:tfoot">
    <tfoot>
      <xsl:copy-of select="@*"/>
      <xsl:apply-templates/>
    </tfoot>
  </xsl:template>
  <xsl:template match="n1:tbody">
    <tbody>
      <xsl:copy-of select="@*"/>
      <xsl:apply-templates/>
    </tbody>
  </xsl:template>
  <xsl:template match="n1:colgroup">
    <colgroup>
      <xsl:copy-of select="@*"/>
      <xsl:apply-templates/>
    </colgroup>
  </xsl:template>
  <xsl:template match="n1:col">
    <col>
      <xsl:copy-of select="@*"/>
      <xsl:apply-templates/>
    </col>
  </xsl:template>
  <xsl:template match="n1:tr">
    <tr>
      <xsl:copy-of select="@*"/>
      <xsl:apply-templates/>
    </tr>
  </xsl:template>
  <xsl:template match="n1:th">
    <th class="narr_th">
      <xsl:copy-of select="@*"/>
      <xsl:apply-templates/>
    </th>
  </xsl:template>
  <xsl:template match="n1:td">
    <td class="narr_td">
      <xsl:copy-of select="@*"/>
      <xsl:apply-templates/>
    </td>

  </xsl:template>
  <xsl:template match="n1:table/n1:caption">
    <span style="font-weight:bold; ">
      <xsl:apply-templates/>
    </span>
  </xsl:template>
  <!--   RenderMultiMedia 
    this currently only handles GIF's and JPEG's.  It could, however,
    be extended by including other image MIME types in the predicate
    and/or by generating <object> or <applet> tag with the correct
    params depending on the media type  @ID  =$imageRef  referencedObject
    -->
  <xsl:template match="n1:renderMultiMedia">
    <xsl:variable name="imageRef" select="@referencedObject"/>
    <xsl:choose>
      <xsl:when test="//n1:regionOfInterest[@ID = $imageRef]">
        <!-- Here is where the Region of Interest image referencing goes -->
        <xsl:if
          test="
            //n1:regionOfInterest[@ID = $imageRef]//n1:observationMedia/n1:value[@mediaType = 'image/gif' or
            @mediaType = 'image/jpeg' or @mediaType = 'image/png']">
          <br clear="all"/>
          <xsl:element name="img">
            <xsl:attribute name="src">
              <xsl:value-of
                select="//n1:regionOfInterest[@ID = $imageRef]//n1:observationMedia/n1:value/n1:reference/@value"
              />
            </xsl:attribute>
          </xsl:element>
        </xsl:if>
        <!-- Here is where the Region of Interest image referencing goes -->
        <xsl:if
          test="//n1:regionOfInterest[@ID = $imageRef]//n1:observationMedia/n1:value[@mediaType = 'text/xml' or @mediaType = 'application/pdf']">
          <br clear="all"/>
          <xsl:element name="p">

            <xsl:value-of
              select="//n1:regionOfInterest[@ID = $imageRef]//n1:observationMedia/n1:value/n1:reference/@value"
            />
          </xsl:element>
        </xsl:if>
      </xsl:when>
      <xsl:otherwise>
        <xsl:variable name="vendor" select="system-property('xsl:vendor')"/>
        <xsl:variable name="node-set" select="function-available('exsl:node-set')"/>
        <!-- Here is where the direct MultiMedia image referencing goes -->
        <xsl:if
          test="//n1:observationMedia[@ID = $imageRef]/n1:value[@mediaType = 'image/gif' or @mediaType = 'image/jpeg' or @mediaType = 'image/png']">
          <br clear="all"/>
          <xsl:element name="IMG">
            <!--
            <xsl:attribute name='alt'>L'image du document ne peut pas être visualisée avec ce navigateur.</xsl:attribute>
            -->
            <xsl:attribute name="id">
              <xsl:value-of select="$imageRef"/>
            </xsl:attribute>
            <xsl:attribute name="src">data:<xsl:value-of
                select="//n1:observationMedia[@ID = $imageRef]/n1:value/@mediaType"/>;base64,
                <xsl:value-of select="//n1:observationMedia[@ID = $imageRef]/n1:value"/>
            </xsl:attribute>
          </xsl:element>
        </xsl:if>
        <!--SESAM VITAL 1  -->
        <xsl:if test="//n1:observationMedia[@ID = $imageRef]/n1:value[@mediaType = 'text/xml']">
          <br clear="all"/>
          <xsl:choose>
            <xsl:when test="$vendor = 'libxslt' and $node-set">
              <!-- Le navigateur est soit safari version 3.x et superieure 
        soit google chrome version 2.x et superieure -->
              <!-- On peut donc afficher le sesam -->
              <xsl:element name="object">
                <xsl:attribute name="type">
                  <xsl:value-of select="//n1:observationMedia[@ID = $imageRef]/n1:value/@mediaType"
                  />
                </xsl:attribute>

                <xsl:attribute name="id">
                  <xsl:value-of select="$imageRef"/>
                </xsl:attribute>
                <xsl:attribute name="data">data:<xsl:value-of
                    select="//n1:observationMedia[@ID = $imageRef]/n1:value/@mediaType"/>;base64,
                    <xsl:value-of select="//n1:observationMedia[@ID = $imageRef]/n1:value"/>
                </xsl:attribute>
              </xsl:element>
            </xsl:when>

            <xsl:when test="$vendor = 'Transformiix' and $node-set">
              <!-- Le navigateur est firefox  -->
              <!-- On peut donc afficher le sesam -->
              <xsl:element name="object">
                <xsl:attribute name="type">
                  <xsl:value-of select="//n1:observationMedia[@ID = $imageRef]/n1:value/@mediaType"
                  />
                </xsl:attribute>

                <xsl:attribute name="id">
                  <xsl:value-of select="$imageRef"/>
                </xsl:attribute>
                <xsl:attribute name="data">data:<xsl:value-of
                    select="//n1:observationMedia[@ID = $imageRef]/n1:value/@mediaType"/>;base64,
                    <xsl:value-of select="//n1:observationMedia[@ID = $imageRef]/n1:value"/>
                </xsl:attribute>
              </xsl:element>
            </xsl:when>
            <xsl:otherwise>
              <xsl:text>Ce document contient des données (SESAM vitale) qui ne peuvent être affichées par ce navigateur.</xsl:text>
            </xsl:otherwise>
          </xsl:choose>
        </xsl:if>
        <!--Données cliniques rapportés  -->
        <xsl:if
          test="//n1:observationMedia[@ID = $imageRef]/n1:value[@mediaType = 'application/pdf']">
          <xsl:choose>
            <xsl:when test="$vendor = 'libxslt' and $node-set">
              <!-- Le navigateur est soit safari version 3.x et superieure 
        soit google chrome version 2.x et superieure -->
              <!-- On peut donc afficher le pdf -->
              <xsl:element name="object">
                <xsl:attribute name="id">
                  <xsl:value-of select="$imageRef"/>
                </xsl:attribute>
                <xsl:attribute name="type">
                  <xsl:value-of select="//n1:observationMedia[@ID = $imageRef]/n1:value/@mediaType"
                  />
                </xsl:attribute>
                <xsl:attribute name="width">800px></xsl:attribute>
                <xsl:attribute name="height">600px</xsl:attribute>
                <xsl:attribute name="data">data:<xsl:value-of
                    select="//n1:observationMedia[@ID = $imageRef]/n1:value/@mediaType"
                    />;base64,<xsl:value-of select="//n1:observationMedia[@ID = $imageRef]/n1:value"
                  />
                </xsl:attribute>
              </xsl:element>
            </xsl:when>
            <xsl:when test="$vendor = 'Transformiix' and $node-set">
              <!-- Le navigateur est firefox -->
              <!-- On peut donc afficher le pdf -->
              <xsl:element name="object">
                <xsl:attribute name="id">
                  <xsl:value-of select="$imageRef"/>
                </xsl:attribute>
                <xsl:attribute name="type">
                  <xsl:value-of select="//n1:observationMedia[@ID = $imageRef]/n1:value/@mediaType"
                  />
                </xsl:attribute>
                <xsl:attribute name="width">800px></xsl:attribute>
                <xsl:attribute name="height">600px</xsl:attribute>
                <xsl:attribute name="data">data:<xsl:value-of
                    select="//n1:observationMedia[@ID = $imageRef]/n1:value/@mediaType"
                    />;base64,<xsl:value-of select="//n1:observationMedia[@ID = $imageRef]/n1:value"
                  />
                </xsl:attribute>
              </xsl:element>
            </xsl:when>
            <xsl:otherwise>
              <!-- Navigateur non pris en charge, IE -->
              <xsl:text>Ce document contient un fichier PDF qui ne peut être affiché par ce navigateur.</xsl:text>
            </xsl:otherwise>
          </xsl:choose>
        </xsl:if>

      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  <!--    Stylecode processing   
    Supports Bold, Underline and Italics display
    -->
  <xsl:template match="//n1:*[@styleCode]">
    <xsl:if test="@styleCode = 'Bold'">
      <xsl:element name="b">
        <xsl:apply-templates/>
      </xsl:element>
    </xsl:if>
    <xsl:if test="@styleCode = 'Italics'">
      <xsl:element name="i">
        <xsl:apply-templates/>
      </xsl:element>
    </xsl:if>
    <xsl:if test="@styleCode = 'Underline'">
      <xsl:element name="u">
        <xsl:apply-templates/>
      </xsl:element>
    </xsl:if>
    <xsl:if
      test="contains(@styleCode, 'Bold') and contains(@styleCode, 'Italics') and not(contains(@styleCode, 'Underline'))">
      <xsl:element name="b">
        <xsl:element name="i">
          <xsl:apply-templates/>
        </xsl:element>
      </xsl:element>
    </xsl:if>
    <xsl:if
      test="contains(@styleCode, 'Bold') and contains(@styleCode, 'Underline') and not(contains(@styleCode, 'Italics'))">
      <xsl:element name="b">
        <xsl:element name="u">
          <xsl:apply-templates/>
        </xsl:element>
      </xsl:element>
    </xsl:if>
    <xsl:if
      test="contains(@styleCode, 'Italics') and contains(@styleCode, 'Underline') and not(contains(@styleCode, 'Bold'))">
      <xsl:element name="i">
        <xsl:element name="u">
          <xsl:apply-templates/>
        </xsl:element>
      </xsl:element>
    </xsl:if>
    <xsl:if
      test="contains(@styleCode, 'Italics') and contains(@styleCode, 'Underline') and contains(@styleCode, 'Bold')">
      <xsl:element name="b">
        <xsl:element name="i">
          <xsl:element name="u">
            <xsl:apply-templates/>
          </xsl:element>
        </xsl:element>
      </xsl:element>
    </xsl:if>
    <xsl:if
      test="not(contains(@styleCode, 'Italics') or contains(@styleCode, 'Underline') or contains(@styleCode, 'Bold'))">
      <xsl:apply-templates/>
    </xsl:if>
  </xsl:template>
  <!--    Superscript or Subscript   -->
  <xsl:template match="n1:sup">
    <xsl:element name="sup">
      <xsl:apply-templates/>
    </xsl:element>
  </xsl:template>
  <xsl:template match="n1:sub">
    <xsl:element name="sub">
      <xsl:apply-templates/>
    </xsl:element>
  </xsl:template>
</xsl:stylesheet>
