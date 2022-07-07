<?xml version="1.0" encoding="UTF-8"?>
<!--
  Title : cda_asip.xsl / headers.xsl
  Version : 1.1.1
  Date de mise à jour 16/06/2015
  This StyleSheet is based on the StyleSheet "Modular CDA XSL StyleSheet (cda_modular.xsl)" made by Alchuler Associates LCC.
  The original StyleSheet has been modified by ASIP Santé (http://www.asipsante.fr) in order to :
  - Translate the labels from english to french
  - Edit supplementary informations
  - Detect a Xades envelopping signature of a Clinical Document
  - add comments in case of impossibility to edit pdf files in nonXMLBody and within structuredBody with IE/EDGE and Firefox 3.x
  
  
  Below is the original declaration of Alschuler Associates LCC
  Title: Modular CDA XSL StyleSheet
  Original Filename: headers.xsl 
  Version: 3.0
  Revision History: 8/12/09 Jingdong Li updated 
  Specification: ANSI/HL7 CDA, R2-2005  
  The current version and documentation are available at www.alschulerassociates.com/cda/?topic=cda-xsl. 
  We welcome feedback to tools@alschulerassociates.com
  The stylesheet is the cumulative work of several developers; the most significant prior milestones were the foundation work from HL7 
  Germany and Finland (Tyylitiedosto) and HL7 US (Calvin Beebe), and the presentation approach from Tony Schaller, medshare GmbH provided at IHIC 2009. 
-->
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:n1="urn:hl7-org:v3" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
  <xsl:import href="utility_CRBIO.xsl"/>
  <!-- header elements -->
  <!-- Document -->			   
  <xsl:template name="documentGeneral"> Document <table class="header_table">
      <tbody>
		<!-- Type -->			 
        <tr>
          <td width="20%">
            <span class="td_label">
              <xsl:text>Identifiant</xsl:text>
            </span>
          </td>
          <td width="80%">
            <xsl:call-template name="show-id">
              <xsl:with-param name="id" select="n1:id"/>
            </xsl:call-template>
          </td>
        </tr>
        <tr>
          <td width="20%">
            <span class="td_label">
              <xsl:text>Version</xsl:text>
            </span>
          </td>
          <td width="80%">
            <xsl:value-of select="n1:versionNumber/@value"/>
          </td>
        </tr>
        <tr>
          <td width="20%">
            <span class="td_label">
              <xsl:text>Type</xsl:text>
            </span>
          </td>
          <td width="80%">
            <xsl:call-template name="show-code">
              <xsl:with-param name="code" select="n1:code"/>
            </xsl:call-template>
            <xsl:if test="n1:code/n1:translation">            
              <xsl:call-template name="show-translation-code">
                <xsl:with-param name="code" select="n1:code/n1:translation"/>
              </xsl:call-template>
            </xsl:if>  
          </td>
        </tr>
        <tr>
          <td width="20%">
            <span class="td_label">
              <xsl:text>Création</xsl:text>
            </span>
          </td>
          <td width="80%">
            <xsl:call-template name="show-time">
              <xsl:with-param name="datetime" select="n1:effectiveTime"/>
            </xsl:call-template>
          </td>
        </tr>
        <tr>
          <td width="20%">
            <span class="td_label">
              <xsl:text>Domaine</xsl:text>
            </span>
          </td>
          <td width="80%">
            <xsl:call-template name="show-realmCode">
              <xsl:with-param name="realmCode" select="n1:realmCode"/>
            </xsl:call-template>
          </td>
        </tr>
        <tr>
          <td width="20%">
            <span class="td_label">
              <xsl:text>Référence au modèle CDA</xsl:text>
            </span>
          </td>
          <td width="80%">
            <xsl:call-template name="show-typeId">
              <xsl:with-param name="typeId" select="n1:typeId"/>
            </xsl:call-template>
          </td>
        </tr>
        <tr>
          <td width="20%">
            <span class="td_label">
              <xsl:text>Conformité</xsl:text>
            </span>
          </td>
          <td width="80%">
            <xsl:for-each select="n1:templateId">
              <xsl:call-template name="show-templateId" />
              <br/>
            </xsl:for-each>
          </td>
        </tr>
        <tr>
          <td width="20%">
            <span class="td_label">
              <xsl:text>Langue principale</xsl:text>
            </span>
          </td>
          <td width="80%">
            <xsl:call-template name="show-languageCode">
              <xsl:with-param name="languageCode" select="n1:languageCode"/>
            </xsl:call-template>
          </td>
        </tr>
        <tr>
          <td width="20%">
            <span class="td_label">
              <xsl:text>Identifiant du lot de versions</xsl:text>
            </span>
          </td>
          <td width="80%">
            <xsl:call-template name="show-id">
              <xsl:with-param name="id" select="n1:setId"/>
            </xsl:call-template>
          </td>
        </tr>
        <xsl:if test="n1:confidentialityCode">
          <tr>
            <td width="20%">
              <span class="td_label">
                <xsl:text>Niveau de confidentialité</xsl:text>
              </span>
            </td>
            <td width="80%">
              <xsl:choose>
                <xsl:when test="n1:confidentialityCode/@code = &apos;N&apos;">
                  <xsl:text>Normal</xsl:text>
                </xsl:when>
                <xsl:when test="n1:confidentialityCode/@code = &apos;R&apos;">
                  <xsl:text>Restreint</xsl:text>
                </xsl:when>
                <xsl:when test="n1:confidentialityCode/@code = &apos;V&apos;">
                  <xsl:text>Très restreint</xsl:text>
                </xsl:when>
              </xsl:choose>
              <xsl:if test="n1:confidentialityCode/n1:originalText">
                <xsl:text> </xsl:text>
                <xsl:value-of select="n1:confidentialityCode/n1:originalText"/>
              </xsl:if>
            </td>
          </tr>
        </xsl:if>
        <xsl:if test="n1:relatedDocument">
          <xsl:for-each select="n1:relatedDocument">
            <tr>
              <td width="20%">
                <span class="td_label">
                  <xsl:text>Identifiant document original</xsl:text>
                </span>
              </td>
              <td width="80%">
                <xsl:for-each select="n1:parentDocument/n1:id">
                  <xsl:call-template name="show-id"/>
                </xsl:for-each>
              </td>
            </tr>
            <tr>
              <td width="20%">
                <span class="td_label">
                  <xsl:text>Version</xsl:text>
                </span>
              </td>
              <td width="80%">
                <xsl:for-each select="n1:parentDocument">
                  <xsl:value-of select="n1:versionNumber/@value"/>
                </xsl:for-each>
              </td>
            </tr>
          </xsl:for-each>
        </xsl:if>
      </tbody>
    </table>
  </xsl:template>
  <!-- author -->
  <xsl:template name="author">
    <xsl:if test="n1:author"> Auteur(s) <table class="header_table">
        <tbody>
          <xsl:for-each select="n1:author/n1:assignedAuthor">
            <tr>
              <td width="20%">
                <span class="td_label">
                  <xsl:text>Auteur</xsl:text>
                </span>
              </td>
              <td width="80%">
                <xsl:if test="n1:assignedPerson">
                <details>
                <summary>  
                <xsl:if test="n1:assignedPerson/n1:name">
                  <xsl:call-template name="show-name">
                    <xsl:with-param name="name" select="n1:assignedPerson/n1:name"/>
                  </xsl:call-template>
                </xsl:if>
                </summary>  
                <xsl:if test="n1:assignedPerson/n1:name">
                  <xsl:call-template name="show-id">
                    <xsl:with-param name="id" select="n1:id"/>
                  </xsl:call-template>
                </xsl:if>
                <xsl:if test="n1:assignedAuthoringDevice/n1:softwareName">
                  <xsl:value-of select="n1:assignedAuthoringDevice/n1:softwareName"/>
                </xsl:if>
                <xsl:if test="n1:addr">
                  <br/><br/>
                  <xsl:call-template name="show-address">
                    <xsl:with-param name="address" select="n1:addr"/>
                  </xsl:call-template>
                </xsl:if>
                <xsl:if test="n1:telecom">
                  <br/><br/>
                  <xsl:for-each select="n1:telecom">
                    <xsl:call-template name="show-telecom">
                      <xsl:with-param name="telecom" select="."/>
                    </xsl:call-template>
                  </xsl:for-each>
                </xsl:if>
                </details>
                </xsl:if>  
              </td>
            </tr>
            <xsl:for-each select="n1:code">
              <tr>
                <td>
                  <span>
                    <xsl:text>Profession/spécialité</xsl:text>
                  </span>
                </td>
                <td>
                  <xsl:call-template name="show-code">
                    <xsl:with-param name="code" select="."/>
                  </xsl:call-template>
                </td>
              </tr>
            </xsl:for-each>
            <xsl:if test="n1:representedOrganization">
              <tr>
                <td width="20%">
                  <span>
                    <xsl:text>Organisation</xsl:text>
                  </span>
                </td>
                <td width="80%">
                  <xsl:if test="n1:representedOrganization">
                  <details>
                  <summary>  
                  <xsl:if test="n1:representedOrganization/n1:name">
                    <xsl:call-template name="show-name">
                      <xsl:with-param name="name" select="n1:representedOrganization/n1:name"/>
                    </xsl:call-template>
                  </xsl:if>
                  </summary>  
                  <xsl:if test="n1:representedOrganization/n1:id">
                    <xsl:for-each select="n1:representedOrganization/n1:id">
                      <xsl:call-template name="show-id">
                        <xsl:with-param name="id" select="n1:representedOrganization/n1:id"/>
                      </xsl:call-template>
                    </xsl:for-each>
                  </xsl:if>
                  <xsl:if test="n1:representedOrganization/n1:addr">
                    <br/><br/>
                    <xsl:call-template name="show-address">
                      <xsl:with-param name="address" select="n1:representedOrganization/n1:addr"/>
                    </xsl:call-template>
                  </xsl:if>
                  <xsl:if test="n1:representedOrganization/n1:telecom">
                    <br/><br/>
                    <xsl:for-each select="n1:representedOrganization/n1:telecom">
                      <xsl:call-template name="show-telecom">
                        <xsl:with-param name="telecom" select="."/>
                      </xsl:call-template>
                    </xsl:for-each>
                  </xsl:if>
                  </details>
                  </xsl:if> 
                </td>
              </tr>
            </xsl:if>
          </xsl:for-each>
        </tbody>
      </table>
    </xsl:if>
  </xsl:template>
  <!--  authenticator -->
  <xsl:template name="authenticator">
    <xsl:if test="n1:authenticator">Approbateur(s)<table class="header_table">
        <tbody>
          <xsl:for-each select="n1:authenticator">
            <tr>
              <td width="20%">
                <span class="td_label">
                  <xsl:text>Approbateur</xsl:text>
                </span>
              </td>
              <td width="80%">
                <xsl:if test="n1:assignedEntity">
                <details>
                <summary>  
                <xsl:if test="n1:assignedEntity/n1:assignedPerson/n1:name">
                  <xsl:call-template name="show-name">
                    <xsl:with-param name="name" select="n1:assignedEntity/n1:assignedPerson/n1:name"/>
                  </xsl:call-template>
                </xsl:if>
                </summary>  
                <xsl:if test="n1:assignedEntity/n1:id">
                  <xsl:call-template name="show-id">
                    <xsl:with-param name="id" select="n1:assignedEntity/n1:id"/>
                  </xsl:call-template>
                </xsl:if>
                <xsl:if test="n1:assignedEntity/n1:addr">
                  <br/><br/>
                  <xsl:call-template name="show-address">
                    <xsl:with-param name="address" select="n1:assignedEntity/n1:addr"/>
                  </xsl:call-template>
                </xsl:if>
                <xsl:if test="n1:assignedEntity/n1:telecom">
                  <br/><br/>
                  <xsl:for-each select="n1:assignedEntity/n1:telecom">
                    <xsl:call-template name="show-telecom">
                      <xsl:with-param name="telecom" select="."/>
                    </xsl:call-template>
                  </xsl:for-each>
                </xsl:if>
                </details>
                </xsl:if>  
              </td>
            </tr>
            <tr>
              <td width="20%">
                <span>
                  <xsl:text>Organisation</xsl:text>
                </span>
              </td>
              <td width="80%" colspan="3">
                <xsl:if test="n1:assignedEntity/n1:representedOrganization">
                <details>
                <summary>  
                <span style="font-weight:bold;">
                  <xsl:call-template name="show-assignedEntity-orga">
                    <xsl:with-param name="asgnEntity" select="n1:assignedEntity"/>
                  </xsl:call-template>
                </span>
                </summary>
                <xsl:call-template name="show-assignedEntity-orga-id">
                  <xsl:with-param name="asgnEntity" select="n1:assignedEntity"/>
                </xsl:call-template>
                <xsl:if test="n1:assignedEntity/n1:representedOrganization/n1:addr">
                  <br/>
                  <xsl:call-template name="show-address">
                    <xsl:with-param name="address"
                      select="n1:assignedEntity/n1:representedOrganization/n1:addr"/>
                  </xsl:call-template>
                  <xsl:if test="n1:assignedEntity/n1:representedOrganization/n1:telecom">
                    <br/><br/>
                    <xsl:for-each select="n1:assignedEntity/n1:representedOrganization/n1:telecom">
                      <xsl:call-template name="show-telecom">
                        <xsl:with-param name="telecom" select="."/>
                      </xsl:call-template>
                    </xsl:for-each>
                  </xsl:if>
                </xsl:if>
                </details>
                </xsl:if>  
              </td>
            </tr>
            <tr>
              <td width="20%">
                <span>
                  <xsl:text>Approuvé le</xsl:text>
                </span>
              </td>
              <td width="80%" colspan="3">
                <xsl:call-template name="show-time">
                  <xsl:with-param name="datetime" select="n1:time"/>
                </xsl:call-template>
              </td>
            </tr>
          </xsl:for-each>
        </tbody>
      </table>
    </xsl:if>
  </xsl:template>
  <!-- legalAuthenticator -->
  <xsl:template name="legalAuthenticator">
    <xsl:if test="n1:legalAuthenticator">Signataire légal<table class="header_table">
        <tbody>
		  <!-- Signataire légal -->							
          <tr>
            <td width="20%">
              <span class="td_label">
                <xsl:text>Signataire</xsl:text>
              </span>
            </td>
            <td width="80%">
              <xsl:if test="n1:legalAuthenticator/n1:assignedEntity">
              <details>
                <summary>
                  <!-- Nom et identifiant du signataire légal -->
                  <xsl:call-template name="show-name">
                    <xsl:with-param name="name" select="n1:legalAuthenticator/n1:assignedEntity/n1:assignedPerson/n1:name"/>
                  </xsl:call-template>
                </summary>
                <xsl:if test="n1:legalAuthenticator/n1:assignedEntity/n1:id">
                  <xsl:for-each select="n1:legalAuthenticator/n1:assignedEntity/n1:id">
                    <xsl:call-template name="show-id">
                      <xsl:with-param name="id" select="n1:legalAuthenticator/n1:assignedEntity/n1:id"/>
                    </xsl:call-template>
                  </xsl:for-each>
                </xsl:if>
              <xsl:if test="n1:legalAuthenticator/n1:assignedEntity/n1:addr">
                <br /><br/>
                <xsl:call-template name="show-address">
                  <xsl:with-param name="address"
                    select="n1:legalAuthenticator/n1:assignedEntity/n1:addr"/>
                </xsl:call-template>
              </xsl:if>
              <xsl:if test="n1:legalAuthenticator/n1:assignedEntity/n1:telecom">
                <br/><br/>
                <xsl:for-each select="n1:legalAuthenticator/n1:assignedEntity/n1:telecom">
                  <xsl:call-template name="show-telecom">
                    <xsl:with-param name="telecom" select="."/>
                  </xsl:call-template>
                </xsl:for-each>
              </xsl:if>
              </details>
              </xsl:if>  
            </td>
          </tr>
          <tr>
            <td width="20%">
              <span class="td_label">
                <xsl:text>Organisation</xsl:text>
              </span>
            </td>
            <td width="80%" colspan="3">
			      <!-- Nom organisation du signataire légal -->
              <xsl:if
                test="n1:legalAuthenticator/n1:assignedEntity/n1:representedOrganization">
              <details>
             <summary>											  	  
              <span style="font-weight:bold;">
                <xsl:call-template name="show-assignedEntity-orga">
                  <xsl:with-param name="asgnEntity" select="n1:legalAuthenticator/n1:assignedEntity"
                  />
                </xsl:call-template>
              </span>
			        </summary>		   
              <xsl:call-template name="show-assignedEntity-orga-id">
                <xsl:with-param name="asgnEntity" select="n1:legalAuthenticator/n1:assignedEntity"/>
              </xsl:call-template>
              <xsl:if
                test="n1:legalAuthenticator/n1:assignedEntity/n1:representedOrganization/n1:addr">
                <br/>
                <xsl:call-template name="show-address">
                  <xsl:with-param name="address"
                    select="n1:legalAuthenticator/n1:assignedEntity/n1:representedOrganization/n1:addr"
                  />
                </xsl:call-template>
                <xsl:if
                  test="n1:legalAuthenticator/n1:assignedEntity/n1:representedOrganization/n1:telecom">
                  <br/><br/>
                  <xsl:for-each
                    select="n1:legalAuthenticator/n1:assignedEntity/n1:representedOrganization/n1:telecom">
                    <xsl:call-template name="show-telecom">
                      <xsl:with-param name="telecom" select="."/>
                    </xsl:call-template>
                  </xsl:for-each>
                </xsl:if>
              </xsl:if>
			       </details>
              </xsl:if>
            </td>
          </tr>
          <tr>
            <td width="20%">
              <span class="td_label">
                <xsl:text>Signature</xsl:text>
              </span>
            </td>
            <td>
              <xsl:call-template name="show-sig">
                <xsl:with-param name="sig" select="n1:legalAuthenticator/n1:signatureCode"/>
              </xsl:call-template>
              <xsl:if test="n1:legalAuthenticator/n1:time/@value">
                <xsl:text> le </xsl:text>
                <xsl:call-template name="show-time">
                  <xsl:with-param name="datetime" select="n1:legalAuthenticator/n1:time"/>
                </xsl:call-template>
              </xsl:if>
            </td>
          </tr>
        </tbody>
      </table>
    </xsl:if>
  </xsl:template>

  <!-- dataEnterer -->
  <xsl:template name="dataEnterer">
    <xsl:if test="n1:dataEnterer"> Rédacteur(s) <table class="header_table">
        <tbody>
          <tr>
            <td width="20%">
              <span class="td_label">
                <xsl:text>Rédacteur</xsl:text>
              </span>
            </td>
            <td width="80%">
              <xsl:if test="n1:dataEnterer/n1:assignedEntity">
              <details>
              <summary>  
              <xsl:if test="n1:dataEnterer/n1:assignedEntity/n1:assignedPerson/n1:name">
              <xsl:call-template name="show-name">
                <xsl:with-param name="name" select="n1:dataEnterer/n1:assignedEntity/n1:assignedPerson/n1:name"/>
              </xsl:call-template>
              </xsl:if>
              </summary>  
              <xsl:if test="n1:dataEnterer/n1:assignedEntity/n1:ic">
                <xsl:call-template name="show-name">
                  <xsl:with-param name="name" select="n1:dataEnterer/n1:assignedEntity/n1:id"/>
                </xsl:call-template>
              </xsl:if>
              <xsl:if test="n1:dataEnterer/n1:assignedEntity/n1:addr">
                <br/><br/>
                <xsl:call-template name="show-address">
                  <xsl:with-param name="address" select="n1:dataEnterer/n1:assignedEntity/n1:addr"/>
                </xsl:call-template>
              </xsl:if>
              <xsl:if test="n1:dataEnterer/n1:assignedEntity/n1:telecom">
                <br/><br/>
                <xsl:for-each select="n1:dataEnterer/n1:assignedEntity/n1:telecom">
                  <xsl:call-template name="show-telecom">
                    <xsl:with-param name="telecom" select="."/>
                  </xsl:call-template>
                </xsl:for-each>
              </xsl:if>
              </details>
              </xsl:if> 
            </td>
          </tr>
          <xsl:if test="n1:dataEnterer/n1:assignedEntity/n1:representedOrganization">
            <tr>
              <td width="20%">
                <span class="td_label">
                  <xsl:text>Organisation</xsl:text>
                </span>
              </td>
              <td width="80%" colspan="3">
                <xsl:if test="n1:dataEnterer/n1:assignedEntity/n1:representedOrganization">
                <details>
                <summary>  
                <span style="font-weight:bold; ">
                  <xsl:call-template name="show-assignedEntity-orga">
                    <xsl:with-param name="asgnEntity" select="n1:dataEnterer/n1:assignedEntity"/>
                  </xsl:call-template>
                </span>
                </summary>
                <xsl:call-template name="show-assignedEntity-orga-id">
                  <xsl:with-param name="asgnEntity" select="n1:dataEnterer/n1:assignedEntity"/>
                </xsl:call-template>
                <xsl:if test="n1:dataEnterer/n1:assignedEntity/n1:representedOrganization/n1:addr">
                  <br/><br/>
                  <xsl:call-template name="show-address">
                    <xsl:with-param name="address"
                      select="n1:dataEnterer/n1:assignedEntity/n1:representedOrganization/n1:addr"/>
                  </xsl:call-template>
                </xsl:if>
                <xsl:if
                  test="n1:dataEnterer/n1:assignedEntity/n1:representedOrganization/n1:telecom">
                  <br/><br/>
                  <xsl:for-each
                    select="n1:dataEnterer/n1:assignedEntity/n1:representedOrganization/n1:telecom">
                    <xsl:call-template name="show-telecom">
                      <xsl:with-param name="telecom" select="."/>
                    </xsl:call-template>
                  </xsl:for-each>
                </xsl:if>
                </details>
                </xsl:if>
              </td>
            </tr>
          </xsl:if>
          <tr>
            <td width="20%">
              <span class="td_label">
                <xsl:text>Rédigé le </xsl:text>
              </span>
            </td>
            <td>
              <xsl:call-template name="show-time">
                <xsl:with-param name="datetime" select="n1:dataEnterer/n1:time"/>
              </xsl:call-template>
            </td>
          </tr>
        </tbody>
      </table>
    </xsl:if>
  </xsl:template>

  <!-- componentOf -->
  <xsl:template name="componentof">
    <xsl:if test="n1:componentOf">Prise en charge<table class="header_table">
        <tbody>
          <xsl:for-each select="n1:componentOf/n1:encompassingEncounter">
            <xsl:if test="n1:id">
              <tr>
                <td width="20%">
                  <span class="td_label">
                    <xsl:text>Identifiant de la rencontre</xsl:text>
                  </span>
                </td>
                <td width="80%">
                  <xsl:call-template name="show-id">
                    <xsl:with-param name="id" select="n1:id"/>
                  </xsl:call-template>
                </td>
              </tr>
              <xsl:if test="n1:code">
                <tr>
                  <td width="20%">
                    <span class="td_label">
                      <xsl:text>Type</xsl:text>
                    </span>
                  </td>
                  <td width="80%">
                    <xsl:call-template name="show-code">
                      <xsl:with-param name="code" select="n1:code"/>
                    </xsl:call-template>
                  </td>
                </tr>
              </xsl:if>
            </xsl:if>
            <xsl:if test="n1:effectiveTime">
              <xsl:if test="n1:effectiveTime/@value">
                <tr>
                  <td width="20%">
                    <span class="td_label">
                      <xsl:text>Date</xsl:text>
                    </span>
                  </td>
                  <td colspan="3" width="80%">
                    <xsl:call-template name="show-time">
                      <xsl:with-param name="datetime" select="n1:effectiveTime"/>
                    </xsl:call-template>
                  </td>
                </tr>
              </xsl:if>
              <xsl:if test="n1:effectiveTime/n1:low">
                <tr>
                  <td width="20%">
                    <span class="td_label">
                      <xsl:text>Début</xsl:text>
                    </span>
                  </td>
                  <td colspan="3" width="80%">
                    <xsl:call-template name="show-time">
                      <xsl:with-param name="datetime" select="n1:effectiveTime/n1:low"/>
                    </xsl:call-template>
                  </td>
                </tr>
              </xsl:if>
              <xsl:if test="n1:effectiveTime/n1:high">
                <tr>
                  <td width="20%">
                    <span class="td_label">
                      <xsl:text>Fin</xsl:text>
                    </span>
                  </td>
                  <td colspan="3" width="80%">
                    <xsl:call-template name="show-time">
                      <xsl:with-param name="datetime" select="n1:effectiveTime/n1:high"/>
                    </xsl:call-template>
                  </td>
                </tr>
              </xsl:if>
            </xsl:if>
            <xsl:if test="n1:location/n1:healthCareFacility">
              <tr>
                <td width="20%">
                  <span class="td_label">
                    <xsl:text>Lieu</xsl:text>
                  </span>
                </td>
                <td width="80%" colspan="3">
                  <xsl:if test="n1:location/n1:healthCareFacility">
                  <details>
                  <summary>  
                  <xsl:choose>
                    <xsl:when test="n1:location/n1:healthCareFacility/n1:location/n1:name">
                      <xsl:call-template name="show-name">
                        <xsl:with-param name="name"
                          select="n1:location/n1:healthCareFacility/n1:location/n1:name"/>
                      </xsl:call-template>
                      <xsl:for-each
                        select="n1:location/n1:healthCareFacility/n1:serviceProviderOrganization/n1:name">
                        <xsl:text> of </xsl:text>
                        <xsl:call-template name="show-name">
                          <xsl:with-param name="name"
                            select="n1:location/n1:healthCareFacility/n1:serviceProviderOrganization/n1:name"
                          />
                        </xsl:call-template>
                      </xsl:for-each>
                    </xsl:when>
                    <xsl:when test="n1:location/n1:healthCareFacility/n1:code">
                      <xsl:call-template name="show-code">
                        <xsl:with-param name="code"
                          select="n1:location/n1:healthCareFacility/n1:code"/>
                      </xsl:call-template>
                    </xsl:when>
                    <xsl:otherwise>
                      <xsl:if test="n1:location/n1:healthCareFacility/n1:id">
                        <xsl:text>id: </xsl:text>
                        <xsl:for-each select="n1:location/n1:healthCareFacility/n1:id">
                          <xsl:call-template name="show-id">
                            <xsl:with-param name="id" select="."/>
                          </xsl:call-template>
                        </xsl:for-each>
                      </xsl:if>
                    </xsl:otherwise>
                  </xsl:choose>
                  </summary>  
                  <xsl:if test="n1:location/n1:healthCareFacility/n1:location/n1:addr">
                    <br/><br/>
                    <xsl:call-template name="show-address">
                      <xsl:with-param name="address"
                        select="n1:location/n1:healthCareFacility/n1:location/n1:addr"/>
                    </xsl:call-template>
                  </xsl:if>
                  </details>
                  </xsl:if>
                </td>
              </tr>
            </xsl:if>
            <xsl:if test="n1:responsibleParty">
              <tr>
                <td>
                  <span class="td_label">
                    <xsl:text>Responsabilité médicale</xsl:text>
                  </span>
                </td>
                <td width="80%" colspan="3">
                  <xsl:if test="n1:responsibleParty/n1:assignedEntity">
                  <details>
                  <summary>  
                    <xsl:call-template name="show-name">
                      <xsl:with-param name="name" select="n1:responsibleParty/n1:assignedEntity/n1:assignedPerson/n1:name"
                      />
                    </xsl:call-template>
                  </summary>  
                  <xsl:call-template name="show-id">
                    <xsl:with-param name="id" select="n1:responsibleParty/n1:assignedEntity/n1:id"
                    />
                  </xsl:call-template>
                  <xsl:if test="n1:responsibleParty/n1:assignedEntity/n1:addr">
                  <br/><br/>
                  <xsl:call-template name="show-address">
                    <xsl:with-param name="address"
                      select="n1:responsibleParty/n1:assignedEntity/n1:addr"/>
                  </xsl:call-template>
                  </xsl:if>
                  <xsl:if test="n1:responsibleParty/n1:assignedEntity/n1:telecom">
                    <br/><br/>
                  <xsl:for-each select="n1:responsibleParty/n1:assignedEntity/n1:telecom">
                    <xsl:call-template name="show-telecom">
                      <xsl:with-param name="telecom" select="."/>
                    </xsl:call-template>
                  </xsl:for-each>
                  </xsl:if>
                  </details>
                  </xsl:if>  
                </td>
              </tr>
              <xsl:if test="n1:responsibleParty/n1:assignedEntity/n1:representedOrganization">
                <tr>
                  <td width="20%">
                    <span class="td_label">
                      <xsl:text>Organisation</xsl:text>
                    </span>
                  </td>
                  <td width="80%" colspan="3">
                    <xsl:if
                      test="n1:responsibleParty/n1:assignedEntity/n1:representedOrganization">
                    <details>
                    <summary>
                    <span style="font-weight:bold; ">
                      <xsl:call-template name="show-assignedEntity-orga">
                        <xsl:with-param name="asgnEntity"
                          select="n1:responsibleParty/n1:assignedEntity"/>
                      </xsl:call-template>
                    </span>
			         		</summary>
                    <xsl:call-template name="show-assignedEntity-orga-id">
                      <xsl:with-param name="asgnEntity"
                        select="n1:responsibleParty/n1:assignedEntity"/>
                    </xsl:call-template>
                    <xsl:if
                      test="n1:responsibleParty/n1:assignedEntity/n1:representedOrganization/n1:addr">
                      <br/>
                      <xsl:call-template name="show-address">
                        <xsl:with-param name="address"
                          select="n1:responsibleParty/n1:assignedEntity/n1:representedOrganization/n1:addr"
                        />
                      </xsl:call-template>
                    </xsl:if>
                    <xsl:if
                      test="n1:responsibleParty/n1:assignedEntity/n1:representedOrganization/n1:telecom">
                      <br/><br/>
                      <xsl:for-each
                        select="n1:responsibleParty/n1:assignedEntity/n1:representedOrganization/n1:telecom">
                        <xsl:call-template name="show-telecom">
                          <xsl:with-param name="telecom" select="."/>
                        </xsl:call-template>
                      </xsl:for-each>
                    </xsl:if>
					           </details>
                    </xsl:if>
                  </td>
                </tr>
              </xsl:if>
            </xsl:if>
          </xsl:for-each>
        </tbody>
      </table>
    </xsl:if>
  </xsl:template>

  <!-- custodian -->
  <xsl:template name="custodian">
    <xsl:if test="n1:custodian"> Organisation chargée de la conservation <table class="header_table">
        <tbody>
          <tr>
            <td width="20%">
              <span class="td_label">
                <xsl:text>Organisation</xsl:text>
              </span>
            </td>
            <td width="80%">
              <!-- Nom de l'organisation -->
              <xsl:if
                test="n1:custodian/n1:assignedCustodian/n1:representedCustodianOrganization">
              <details>
                <summary>
                <xsl:if
                test="n1:custodian/n1:assignedCustodian/n1:representedCustodianOrganization/n1:name">
        				<span style="font-weight:bold;">								  
                <xsl:call-template name="show-name">
                  <xsl:with-param name="name"
                    select="n1:custodian/n1:assignedCustodian/n1:representedCustodianOrganization/n1:name"/>
						
                </xsl:call-template>
				        </span>	 
              </xsl:if>				
			         </summary>
			  <xsl:if test="n1:custodian/n1:assignedCustodian/n1:representedCustodianOrganization/n1:id">
                <xsl:for-each
                    select="n1:custodian/n1:assignedCustodian/n1:representedCustodianOrganization/n1:id">
                    <xsl:call-template name="show-id"/>
                    <xsl:if test="position() != last()">
                      <br/>
                    </xsl:if>
                  </xsl:for-each>
              </xsl:if>			  
              <xsl:for-each
                select="n1:custodian/n1:assignedCustodian/n1:representedCustodianOrganization/n1:id">
                <br/>
                <xsl:call-template name="show-idName"/>
              </xsl:for-each>
              <xsl:if
                test="n1:custodian/n1:assignedCustodian/n1:representedCustodianOrganization/n1:addr">
                <br/><br/>
                <xsl:call-template name="show-address">
                  <xsl:with-param name="address"
                    select="n1:custodian/n1:assignedCustodian/n1:representedCustodianOrganization/n1:addr"
                  />
                </xsl:call-template>
              </xsl:if>
              <xsl:if
                test="n1:custodian/n1:assignedCustodian/n1:representedCustodianOrganization/n1:telecom">
                <br/>
                <xsl:for-each
                  select="n1:custodian/n1:assignedCustodian/n1:representedCustodianOrganization/n1:telecom">
                  <br/>
                  <xsl:call-template name="show-telecom">
                    <xsl:with-param name="telecom" select="."/>
                  </xsl:call-template>
                </xsl:for-each>
              </xsl:if>
			       </details>
              </xsl:if>
            </td>
          </tr>
        </tbody>
      </table>
    </xsl:if>
  </xsl:template>
  
  <!-- documentationOf -->
  <xsl:template name="documentationOf">
    <xsl:if test="n1:documentationOf"> Acte(s) <table class="header_table">
        <tbody>
          <xsl:for-each select="n1:documentationOf">
            <xsl:if test="n1:serviceEvent/n1:code">
              <xsl:variable name="displayName">
                <xsl:call-template name="show-actClassCode">
                  <xsl:with-param name="clsCode" select="n1:serviceEvent/@classCode"/>
                </xsl:call-template>
              </xsl:variable>
              <xsl:if test="$displayName">
                <tr>
                  <td width="20%">
                    <span class="td_label">
                      <xsl:choose>
                        <xsl:when test="n1:serviceEvent/n1:performer">
                          <text>Acte principal</text>
                        </xsl:when>
                        <xsl:otherwise>
                          <text>Acte</text>
                        </xsl:otherwise>
                      </xsl:choose>
                    </span>
                  </td>
                  <td width="80%" colspan="3">
                    <xsl:call-template name="show-code">
                      <xsl:with-param name="code" select="n1:serviceEvent/n1:code"/>
                    </xsl:call-template>
                  </td>
                </tr>
                <xsl:if test="n1:serviceEvent/n1:effectiveTime">
                  <xsl:choose>
                    <xsl:when test="n1:serviceEvent/n1:effectiveTime/@value">
                      <tr>
                        <td width="20%">
                          <span>
                            <xsl:text>Date</xsl:text>
                          </span>
                        </td>
                        <td width="80%">
                          <xsl:call-template name="show-time">
                            <xsl:with-param name="datetime"
                              select="n1:serviceEvent/n1:effectiveTime"/>
                          </xsl:call-template>
                        </td>
                      </tr>
                    </xsl:when>
                    <xsl:when test="n1:serviceEvent/n1:effectiveTime/n1:low">
                      <tr>
                        <td width="20%">
                          <span>
                            <xsl:text>Début</xsl:text>
                          </span>
                        </td>
                        <td width="80%">
                          <xsl:call-template name="show-time">
                            <xsl:with-param name="datetime"
                              select="n1:serviceEvent/n1:effectiveTime/n1:low"/>
                          </xsl:call-template>
                        </td>
                      </tr>
                    </xsl:when>
                    <xsl:when test="n1:serviceEvent/n1:effectiveTime/n1:high">
                      <tr>
                        <td width="20%">
                          <span>
                            <xsl:text>Fin</xsl:text>
                          </span>
                        </td>
                        <td width="80%">
                          <xsl:call-template name="show-time">
                            <xsl:with-param name="datetime"
                              select="n1:serviceEvent/n1:effectiveTime/n1:high"/>
                          </xsl:call-template>
                        </td>
                      </tr>
                    </xsl:when>
                  </xsl:choose>
                </xsl:if>
              </xsl:if>
            </xsl:if>
            <xsl:for-each select="n1:serviceEvent/n1:performer">
              <xsl:variable name="displayName">
                <xsl:call-template name="show-participationType">
                  <xsl:with-param name="ptype" select="@typeCode"/>
                </xsl:call-template>
                <xsl:text> </xsl:text>
                <xsl:if test="n1:functionCode/@code">
                  <xsl:text>(</xsl:text>
                  <xsl:call-template name="show-participationFunction">
                    <xsl:with-param name="pFunction" select="n1:functionCode/@code"/>
                  </xsl:call-template>
                  <xsl:text>)</xsl:text>
                </xsl:if>
              </xsl:variable>
              <tr>
                <td width="20%">
                  <span>
                    <xsl:call-template name="firstCharCaseUp">
                      <xsl:with-param name="data" select="$displayName"/>
                    </xsl:call-template>
                  </span>
                </td>
                <td width="80%" colspan="3">
                  <xsl:if test="n1:assignedEntity">
                  <details>
                  <summary>  
                  <xsl:if test="n1:assignedEntity/n1:assignedPerson/n1:name">
                  <xsl:call-template name="show-name">
                    <xsl:with-param name="name" select="n1:assignedEntity/n1:assignedPerson/n1:name"/>
                  </xsl:call-template>
                  </xsl:if>
                  </summary>  
                  <xsl:if test="n1:assignedEntity/n1:id">
                    <xsl:call-template name="show-id">
                      <xsl:with-param name="id" select="n1:assignedEntity/n1:id"/>
                    </xsl:call-template>
                  </xsl:if>
                  <xsl:if test="n1:assignedEntity/n1:addr">
                    <br/><br/>
                    <xsl:call-template name="show-address">
                      <xsl:with-param name="address" select="n1:assignedEntity/n1:addr"/>
                    </xsl:call-template>
                  </xsl:if>
                  <xsl:if test="n1:assignedEntity/n1:telecom">
                    <br/><br/>
                    <xsl:for-each select="n1:assignedEntity/n1:telecom">
                    <xsl:call-template name="show-telecom">
                      <xsl:with-param name="telecom" select="."/>
                    </xsl:call-template>
                    </xsl:for-each>
                  </xsl:if>
                  </details>
                  </xsl:if>  
                </td>
              </tr>
              <xsl:if test="n1:assignedEntity/n1:representedOrganization">
                <tr>
                  <td width="20%">
                    <span>
                      <xsl:text>Organisation</xsl:text>
                    </span>
                  </td>
                  <td width="80%" colspan="3">
                    <xsl:if test="n1:assignedEntity/n1:representedOrganization">
                    <details>
                    <summary>
                    <span style="font-weight:bold; ">
                      <xsl:call-template name="show-assignedEntity-orga">
                        <xsl:with-param name="asgnEntity" select="n1:assignedEntity"/>
                      </xsl:call-template>
                    </span>
                    </summary>
                    <xsl:call-template name="show-assignedEntity-orga-id">
                      <xsl:with-param name="asgnEntity" select="n1:assignedEntity"/>
                    </xsl:call-template>
                    <xsl:if test="n1:assignedEntity/n1:representedOrganization/n1:addr">
                      <br/>
                      <xsl:call-template name="show-address">
                        <xsl:with-param name="address"
                          select="n1:assignedEntity/n1:representedOrganization/n1:addr"/>
                      </xsl:call-template>
                    </xsl:if>
                    <xsl:if test="n1:assignedEntity/n1:representedOrganization/n1:telecom">
                      <br/><br/>
                      <xsl:for-each select="n1:assignedEntity/n1:representedOrganization/n1:telecom">
                      <xsl:call-template name="show-telecom">
                        <xsl:with-param name="telecom"
                          select="."/>
                      </xsl:call-template>
                      </xsl:for-each>
                    </xsl:if>
                    </details>
                    </xsl:if>
                  </td>
                </tr>
              </xsl:if>
            </xsl:for-each>
          </xsl:for-each>
        </tbody>
      </table>
    </xsl:if>
  </xsl:template>

  <!-- inFulfillmentOf -->
  <xsl:template name="inFulfillmentOf">
    <xsl:if test="n1:inFulfillmentOf"> Prescription <table class="header_table">
        <tbody>
          <xsl:for-each select="n1:inFulfillmentOf">
            <tr>
              <td width="20%">
                <span class="td_label">
                  <xsl:text>Référence prescription</xsl:text>
                </span>
              </td>
              <td width="80%">
                <xsl:for-each select="n1:order">
                  <xsl:for-each select="n1:id">
                    <xsl:call-template name="show-id"/>
                  </xsl:for-each>
                  <xsl:for-each select="n1:code">
                    <br/>
                    <xsl:call-template name="show-code">
                      <xsl:with-param name="code" select="."/>
                    </xsl:call-template>
                  </xsl:for-each>
                  <xsl:for-each select="n1:priorityCode">
                    <br/>
                    <xsl:call-template name="show-code">
                      <xsl:with-param name="code" select="."/>
                    </xsl:call-template>
                  </xsl:for-each>
                </xsl:for-each>
              </td>
            </tr>
          </xsl:for-each>
        </tbody>
      </table>
    </xsl:if>
  </xsl:template>

  <!-- informant -->
  <xsl:template name="informant">
    <xsl:if test="n1:informant"> Informateur(s) <table class="header_table">
        <tbody>
          <xsl:for-each select="n1:informant">
            <xsl:if test="n1:assignedEntity">
              <tr>
                <td width="20%">
                  <span class="td_label">
                    <xsl:text>PS Informateur</xsl:text>
                  </span>
                </td>
                <td width="80%">
                  <xsl:call-template name="show-assignedEntity-name">
                    <xsl:with-param name="asgnEntity" select="n1:assignedEntity"/>
                  </xsl:call-template>
                </td>
              </tr>
              <xsl:if test="n1:assignedEntity/n1:representedOrganization">
                <tr>
                  <td width="20%">
                    <span>
                      <xsl:text>Organisation</xsl:text>
                    </span>
                  </td>
                  <td width="80%" colspan="3">
                    <xsl:if test="n1:assignedEntity/n1:representedOrganization">
                    <details>
                     <summary> 
                    <span style="font-weight:bold;">
                      <xsl:call-template name="show-assignedEntity-orga">
                        <xsl:with-param name="asgnEntity" select="n1:assignedEntity"/>
                      </xsl:call-template>
                    </span>
                     </summary>
                    <xsl:call-template name="show-assignedEntity-orga-id">
                      <xsl:with-param name="asgnEntity" select="n1:assignedEntity"/>
                    </xsl:call-template>
                    <xsl:if test="n1:assignedEntity/n1:representedOrganization/n1:addr">
                      <br/><br/>
                      <xsl:call-template name="show-address">
                        <xsl:with-param name="address"
                          select="n1:assignedEntity/n1:representedOrganization/n1:addr"/>
                      </xsl:call-template>
                      <xsl:if test="n1:assignedEntity/n1:representedOrganization/n1:telecom">
                        <br/><br/>
                        <xsl:for-each
                          select="n1:assignedEntity/n1:representedOrganization/n1:telecom">
                          <xsl:call-template name="show-telecom">
                            <xsl:with-param name="telecom" select="."/>
                          </xsl:call-template>
                        </xsl:for-each>
                      </xsl:if>
                    </xsl:if>
                    </details>
                    </xsl:if>  
                  </td>
                </tr>
              </xsl:if>
            </xsl:if>
            <xsl:if test="n1:relatedEntity">
              <tr>
                <td width="20%">
                  <span>
                    <xsl:call-template name="show-relatedEntityClass">
                      <xsl:with-param name="clsCode" select="n1:relatedEntity/@classCode"/>
                    </xsl:call-template>
                  </span>
                </td>
                <td width="80%">
                  <xsl:if test="n1:relatedEntity">
                  <details>
                    <summary>
                  <xsl:call-template name="show-relatedEntity">
                    <xsl:with-param name="relatedEntity" select="n1:relatedEntity"/>
                  </xsl:call-template>
                    </summary>
                  <xsl:if test="n1:relatedEntity/n1:addr">
                    <br/>
                    <xsl:call-template name="show-address">
                      <xsl:with-param name="address" select="n1:relatedEntity/n1:addr"/>
                    </xsl:call-template>
                  </xsl:if>
                  <xsl:if test="n1:relatedEntity/n1:telecom">
                    <br/><br/>
                    <xsl:for-each select="n1:relatedEntity/n1:telecom">
                      <xsl:call-template name="show-telecom">
                        <xsl:with-param name="telecom" select="."/>
                      </xsl:call-template>
                    </xsl:for-each>
                  </xsl:if>
                  </details>
                  </xsl:if>  
                </td>
              </tr>
            </xsl:if>
          </xsl:for-each>
        </tbody>
      </table>
    </xsl:if>
  </xsl:template>

  <!-- informationRecipient -->
  <xsl:template name="informationRecipient">
    <xsl:if test="n1:informationRecipient"> Destinataire(s) <table class="header_table">
        <tbody>
          <xsl:for-each select="n1:informationRecipient">
            <tr>
              <td width="20%">
                <span class="td_label">
                  <xsl:text>Destinataire</xsl:text>
                </span>
              </td>
              <td width="80%">
                <xsl:if test="n1:intendedRecipient">
                <details>
                 <summary> 
                <xsl:if test="n1:intendedRecipient/n1:informationRecipient/n1:name">
                  <xsl:call-template name="show-name">
                    <xsl:with-param name="name"
                      select="n1:intendedRecipient/n1:informationRecipient/n1:name"/>
                  </xsl:call-template>
                </xsl:if>
                 </summary>
                <xsl:call-template name="show-id">
                  <xsl:with-param name="id" select="n1:intendedRecipient/n1:id"/>
                </xsl:call-template>
                <xsl:if test="n1:intendedRecipient/n1:addr">
                  <br/><br/>
                  <xsl:for-each select="n1:intendedRecipient/n1:addr">
                    <xsl:call-template name="show-address">
                      <xsl:with-param name="address" select="."/>
                    </xsl:call-template>
                  </xsl:for-each>
                </xsl:if>
                <xsl:if test="n1:intendedRecipient/n1:telecom">
                  <br/><br/>
                  <xsl:for-each select="n1:intendedRecipient/n1:telecom">
                    <xsl:call-template name="show-telecom">
                      <xsl:with-param name="telecom" select="."/>
                    </xsl:call-template>
                  </xsl:for-each>
                </xsl:if>
                </details>
                </xsl:if>  
              </td>
            </tr>
            <xsl:if test="n1:intendedRecipient/n1:receivedOrganization">
              <tr>
                <td width="20%">
                  <span class="td_label">
                    <xsl:text>Organisation</xsl:text>
                  </span>
                </td>
                <td width="80%">
                  <xsl:if test="n1:intendedRecipient/n1:receivedOrganization">
                  <details>
                  <summary>  
                  <xsl:if test="n1:intendedRecipient/n1:receivedOrganization/n1:name">
                    <xsl:call-template name="show-name">
                      <xsl:with-param name="name"
                        select="n1:intendedRecipient/n1:receivedOrganization/n1:name"/>
                    </xsl:call-template>
                  </xsl:if>
                  </summary> 
                  <xsl:if test="n1:intendedRecipient/n1:receivedOrganization/n1:id">
                    <xsl:for-each select="n1:intendedRecipient/n1:receivedOrganization/n1:id">
                      <br/>
                      <xsl:call-template name="show-id">
                        <xsl:with-param name="id"
                          select="n1:intendedRecipient/n1:receivedOrganization/n1:id"/>
                      </xsl:call-template>
                    </xsl:for-each>
                  </xsl:if>
                  <xsl:if test="n1:intendedRecipient/n1:receivedOrganization/n1:addr">
                    <br/><br/>
                    <xsl:call-template name="show-address">
                      <xsl:with-param name="address"
                        select="n1:intendedRecipient/n1:receivedOrganization/n1:addr"/>
                    </xsl:call-template>
                  </xsl:if>
                  <xsl:if test="n1:intendedRecipient/n1:receivedOrganization/n1:telecom">
                    <br/><br/>
                    <xsl:for-each select="n1:intendedRecipient/n1:receivedOrganization/n1:telecom">
                      <xsl:call-template name="show-telecom">
                        <xsl:with-param name="telecom" select="."/>
                      </xsl:call-template>
                    </xsl:for-each>
                  </xsl:if>
                  </details>
                  </xsl:if>  
                </td>
              </tr>
            </xsl:if>
          </xsl:for-each>
        </tbody>
      </table>
    </xsl:if>
  </xsl:template>

  <!--Participant-->
  <xsl:template name="participant">
	<xsl:variable name="vendor" select="system-property('xsl:vendor')"/>																	
    <xsl:if test="n1:participant"> Participant(s) 
	     <details>
	       <summary style="display: flex;list-style: none;cursor: pointer;">
	         <xsl:if test="$vendor!='libxslt' and $vendor!='Transformiix'">
	           <span style="width: 100%;border: 1pt solid #00008b;display: none;"/>
	         </xsl:if>
	         <xsl:if test="$vendor='libxslt' or $vendor='Transformiix'">
	           <span style="color: black;width: 100%;border: 1pt solid #00008b;">
	             <xsl:text>+ Voir la liste des participants</xsl:text>
	           </span> 
	         </xsl:if> 
	       </summary> 
        <table class="header_table">																												  
         <tbody>
          <xsl:for-each select="n1:participant">
            <tr>
              <td width="20%">
                <xsl:variable name="participtRole">
                  <xsl:call-template name="translateRoleAssoCode">
                    <xsl:with-param name="code" select="n1:associatedEntity/@classCode"/>
                  </xsl:call-template>
                </xsl:variable>
                <xsl:choose>
                  <xsl:when test="$participtRole">
                    <span class="td_label">
                      <xsl:choose>  
                        <xsl:when test="@typeCode = 'RESP'">
                          <xsl:text>Responsable de l'acte</xsl:text>
                        </xsl:when>                                  
                        <xsl:when test="@typeCode = 'REF'">
                          <xsl:text>Prescripteur</xsl:text>
                        </xsl:when>
                        <xsl:when test="@typeCode = 'REFB'">
                          <xsl:text>Praticien adresseur</xsl:text>
                        </xsl:when>
                        <xsl:when test="@typeCode = 'INF'">
                          <xsl:if test="n1:functionCode">
                            <xsl:choose>
                              <xsl:when test="n1:functionCode/@code = 'PCP'">
                                <xsl:text>Médecin traitant</xsl:text>
                              </xsl:when>
                              <xsl:otherwise>
                                <xsl:text>Informateur</xsl:text>
                              </xsl:otherwise>
                            </xsl:choose>
                          </xsl:if>
                        </xsl:when>
                        <xsl:when test="@typeCode = 'PRF'">
                          <xsl:if test="n1:functionCode">
                            <xsl:choose>
                              <xsl:when test="n1:functionCode/@code = 'ATTPHYS'">
                                <xsl:text>Responsable de l'équipe de soins</xsl:text>
                              </xsl:when>
                              <xsl:when test="n1:functionCode/@code = '353'">
                                <xsl:text>Membre de l'équipe de soins</xsl:text>
                              </xsl:when>
                              <xsl:when test="n1:functionCode/@code = 'CORRE'">
                                <xsl:text>Correspondant</xsl:text>
                              </xsl:when>
                              <xsl:when test="n1:functionCode/@code = 'PRELV'">
                                <xsl:text>Préleveur</xsl:text>
                              </xsl:when>
                              <xsl:otherwise>
                                <xsl:text>Exécutant</xsl:text>
                              </xsl:otherwise>
                            </xsl:choose>
                          </xsl:if>
                        </xsl:when>                     
                        <xsl:when test="@typeCode = 'CON'">
                          <xsl:if test="n1:functionCode">
                            <xsl:choose>
                              <xsl:when test="n1:functionCode/@code = 'CORRE'">
                                <xsl:text>Correspondant</xsl:text>
                              </xsl:when>
                              <xsl:otherwise>
                                <xsl:text>Consultant</xsl:text>
                              </xsl:otherwise>
                            </xsl:choose>
                          </xsl:if>
                        </xsl:when>                        
                        <xsl:when test="@typeCode = 'VRF'">
                          <xsl:text>Vérificateur</xsl:text>
                        </xsl:when>
                        <xsl:when test="@typeCode = 'ADM'">
                          <xsl:text>Responsable de l'admission</xsl:text>
                        </xsl:when>
                        <xsl:when test="@typeCode = 'DIS'">
                          <xsl:text>Responsable de la sortie</xsl:text>
                        </xsl:when>
                        <xsl:when test="@typeCode = 'AUTHEN'">
                          <xsl:text>Valideur des résultats</xsl:text>
                        </xsl:when>
                        <xsl:otherwise>
                          <xsl:text>Participant</xsl:text>
                        </xsl:otherwise>
                      </xsl:choose>
                      <xsl:call-template name="firstCharCaseUp">
                        <xsl:with-param name="data" select="$participtRole"/>
                      </xsl:call-template>
                      <xsl:text>)</xsl:text>
                    </span>
                  </xsl:when>
                  <xsl:otherwise>
                    <span class="td_label">
                      <xsl:text>Participant</xsl:text>
                    </span>
                  </xsl:otherwise>
                </xsl:choose>
              </td>
              <td width="80%">
                <xsl:if test="n1:associatedEntity">
                <details>
                <summary>  
                <xsl:if test="n1:functionCode">
                  <xsl:call-template name="show-code">
                    <xsl:with-param name="code" select="n1:functionCode"/>
                  </xsl:call-template>
                </xsl:if>
                <xsl:call-template name="show-associatedEntity">
                  <xsl:with-param name="assoEntity" select="n1:associatedEntity"/>
                </xsl:call-template>
                </summary>  
                <xsl:if test="n1:associatedEntity/n1:addr">
                  <br/><br />
                  <xsl:call-template name="show-address">
                    <xsl:with-param name="address" select="n1:associatedEntity/n1:addr"/>
                  </xsl:call-template>
                </xsl:if>
                <xsl:if test="n1:associatedEntity/n1:telecom">
                  <br/><br/>
                  <xsl:for-each select="n1:associatedEntity/n1:telecom">
                    <xsl:call-template name="show-telecom">
                      <xsl:with-param name="telecom" select="."/>
                    </xsl:call-template>
                  </xsl:for-each>
                </xsl:if>
                </details>
                </xsl:if>
              </td>
            </tr>
            <xsl:if test="n1:time">
              <xsl:if test="n1:time/n1:low">
                <tr>
                  <td>
                    <span>
                      <xsl:text>Début</xsl:text>
                    </span>
                  </td>
                  <td>
                    <xsl:call-template name="show-time">
                      <xsl:with-param name="datetime" select="n1:time/n1:low"/>
                    </xsl:call-template>
                  </td>
                </tr>
              </xsl:if>
              <xsl:if test="n1:time/n1:high">
                <tr>
                  <td>
                    <span>
                      <xsl:text>Fin</xsl:text>
                    </span>
                  </td>
                  <td>
                    <xsl:call-template name="show-time">
                      <xsl:with-param name="datetime" select="n1:time/n1:high"/>
                    </xsl:call-template>
                  </td>
                </tr>
              </xsl:if>
            </xsl:if>
          </xsl:for-each>
         </tbody>
        </table>
	     </details>
    </xsl:if>
  </xsl:template>

  <!-- recordTarget -->
  <xsl:template name="recordTarget"> Patient <table class="header_table">
      <tbody>
        <xsl:for-each select="n1:recordTarget/n1:patientRole">
          <xsl:if test="not(n1:id/@nullFlavor)">
            <xsl:call-template name="show-patient-name">
              <xsl:with-param name="name" select="n1:patient/n1:name"/>
            </xsl:call-template>
            <tr>
              <td width="20%">
                <span class="td_label">
                  <xsl:text>Date de naissance</xsl:text>
                </span>
              </td>
              <td width="30%">
                <xsl:call-template name="show-time">
                  <xsl:with-param name="datetime" select="n1:patient/n1:birthTime"/>
                </xsl:call-template>
              </td>
            </tr>
            <tr><td width="15%">
                <span class="td_label">
                  <xsl:text>Sexe</xsl:text>
                </span>
              </td>
              <td>
                <xsl:for-each select="n1:patient/n1:administrativeGenderCode">
                  <xsl:call-template name="show-gender"/>
                </xsl:for-each>
              </td></tr>
            <xsl:if test="n1:patient/n1:birthplace/n1:place">
              <tr>
                <td width="20%">
                  <span class="td_label">
                    <xsl:text>Lieu de naissance</xsl:text>
                  </span>
                </td>
                <td colspan="3">
                  <xsl:if test="n1:patient/n1:birthplace/n1:place/n1:name">
                    <xsl:call-template name="show-name">
                      <xsl:with-param name="name" select="n1:patient/n1:birthplace/n1:place/n1:name"
                      />
                    </xsl:call-template>
                    <br/>
                  </xsl:if>
                  <xsl:if test="n1:patient/n1:birthplace/n1:place/n1:addr">
                    <xsl:call-template name="show-address-city">
                      <xsl:with-param name="address"
                        select="n1:patient/n1:birthplace/n1:place//n1:addr"/>
                    </xsl:call-template>
                  </xsl:if>
                </td>
              </tr>
            <tr>
              <td width="20%">
                <xsl:if test="n1:patient/n1:birthplace/n1:place/n1:addr/n1:county">
                  <span class="td_label">
                    <xsl:text>Code INSEE du lieu de naissance</xsl:text>
                  </span>
                </xsl:if>
              </td>
              <td colspan="3">
                <xsl:if test="n1:patient/n1:birthplace/n1:place/n1:addr">
                  <xsl:call-template name="show-address-county">
                    <xsl:with-param name="address" select="n1:patient/n1:birthplace/n1:place/n1:addr"/>
                  </xsl:call-template>
                  <br/>
                </xsl:if>
              </td>
            </tr>
            </xsl:if>
            <tr>
              <td>
                <span class="td_label">
                  <xsl:text>Adresse</xsl:text>
                </span>
              </td>
              <td>
                <xsl:call-template name="show-address">
                  <xsl:with-param name="address" select="n1:addr"/>
                </xsl:call-template>
              </td>
            </tr>
            <xsl:for-each select="n1:telecom">
              <tr>
                <td>
                  <span class="td_label">
                    <xsl:text>Telécom</xsl:text>
                  </span>
                </td>
                <td>
                  <xsl:call-template name="show-telecom">
                    <xsl:with-param name="telecom" select="."/>
                  </xsl:call-template>
                </td>
              </tr>
            </xsl:for-each>
            <tr>
              <td>
                <span class="td_label">
                  <xsl:text>INS</xsl:text>
                </span>
              </td>
              <td>
                <xsl:for-each select="n1:id">
                  <xsl:choose>
                    <xsl:when test="@root = '1.2.250.1.213.1.4.8'">
                      <xsl:call-template name="show-identifiant">
                        <xsl:with-param name="id" select="."/>
                      </xsl:call-template>
                      <xsl:text>&#160;</xsl:text>
                      <xsl:text>[NIR]</xsl:text>
                    </xsl:when>                    
                    <xsl:when test="@root = '1.2.250.1.213.1.4.9'">
                      <xsl:call-template name="show-identifiant">
                        <xsl:with-param name="id" select="."/>
                      </xsl:call-template>
                      <xsl:text>&#160;</xsl:text>
                      <xsl:text>[NIA]</xsl:text>
                    </xsl:when>                    
                    <xsl:when test="@root = '1.2.250.1.213.1.4.10'">
                      <xsl:call-template name="show-identifiant">
                        <xsl:with-param name="id" select="."/>
                      </xsl:call-template>
                      <xsl:text>&#160;</xsl:text>
                      <xsl:text>[TEST]</xsl:text>
                    </xsl:when>
                    <xsl:when test="@root = '1.2.250.1.213.1.4.11'">
                      <xsl:call-template name="show-identifiant">
                        <xsl:with-param name="id" select="."/>
                      </xsl:call-template>
                      <xsl:text>&#160;</xsl:text>
                      <xsl:text>[DEMO]</xsl:text>
                    </xsl:when>
                    <xsl:otherwise>
                      <xsl:text>&#160;</xsl:text>
                    </xsl:otherwise>
                  </xsl:choose>
                  <br/>
                </xsl:for-each>
              </td>
            </tr>
            <tr>
              <td>
                <span class="td_label">
                  <xsl:text>IPP</xsl:text>
                </span>
              </td>
              <td width="80%">
                <xsl:for-each select="n1:id">
                  <xsl:if test="(@root != '1.2.250.1.213.1.4.8') and (@root != '1.2.250.1.213.1.4.9') 
                    and (@root != '1.2.250.1.213.1.4.10') and (@root != '1.2.250.1.213.1.4.11')">
                    <xsl:call-template name="show-id">
                      <xsl:with-param name="id" select="."/>
                    </xsl:call-template>
                    <br/>
                  </xsl:if>  
                </xsl:for-each>
              </td>
            </tr>
          </xsl:if>
        </xsl:for-each>
      </tbody>
    </table>
  </xsl:template>

  <!-- authorization (consent) -->
  <xsl:template name="authorization">
    <xsl:if test="n1:authorization"> Autorisation <table class="header_table">
        <tbody>
          <xsl:for-each select="n1:authorization">
            <tr>
              <td width="20%">
                <span class="td_label">
                  <xsl:text>Autorisation</xsl:text>
                </span>
              </td>
              <td width="80%">
                <xsl:if test="n1:consent/n1:code">
                  <xsl:call-template name="show-code">
                    <xsl:with-param name="code" select="n1:consent/n1:code"/>
                  </xsl:call-template>
                  <br/>
                </xsl:if>
                <xsl:call-template name="show-code">
                  <xsl:with-param name="code" select="n1:consent/n1:statusCode"/>
                </xsl:call-template>
              </td>
            </tr>
          </xsl:for-each>
        </tbody>
      </table>
    </xsl:if>
  </xsl:template>

  <!-- setAndVersion -->
  <xsl:template name="setAndVersion">
    <xsl:if test="n1:setId and n1:versionNumber">
      <table class="header_table">
        <tbody>
          <tr>
            <td width="20%">
              <xsl:text>Identifiant du lot de versions</xsl:text>
            </td>
            <td colspan="3">
              <xsl:text>Identifiant: </xsl:text>
              <xsl:call-template name="show-id">
                <xsl:with-param name="id" select="n1:setId"/>
              </xsl:call-template>
              <xsl:text>  numéro de version: </xsl:text>
              <xsl:value-of select="n1:versionNumber/@value"/>
            </td>
          </tr>
        </tbody>
      </table>
    </xsl:if>
  </xsl:template>
</xsl:stylesheet>