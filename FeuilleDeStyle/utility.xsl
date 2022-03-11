<?xml version="1.0" encoding="UTF-8"?>
<!--
  Title : cda_asip.xsl / utility.xsl
  =======================================================================================================================================================
  This StyleSheet is based on the StyleSheet "Modular CDA XSL StyleSheet (cda_modular.xsl)" made by Alchuler Associates LCC.
  Below is the original declaration of Alschuler Associates LCC
  Title: Modular CDA XSL StyleSheet
  Original Filename: utility.xsl 
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
        - Add comments in case of impossibility to edit pdf files in nonXMLBody and within structuredBody with IE/EDGE and Firefox 3.x
    - 28/10/2015 : Version : 1.1.1
    - 24/05/2019 : Ajout commentaire participant
    - 31/12/2019 : Mise en forme informations de ce module (aucune modification du code)
    - 12/03/2020 : Ajout template guardian pour afficher plusieurs représentants du patient
  =======================================================================================================================================================
-->
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:n1="urn:hl7-org:v3" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
	<!-- show-signature -->
	<xsl:template name="show-sig">
		<xsl:param name="sig"/>
		<xsl:choose>
			<xsl:when test="$sig/@code = &apos;S&apos;">
				<xsl:text>Signé</xsl:text>
			</xsl:when>
			<xsl:when test="$sig/@code = &apos;I&apos;">
				<xsl:text>Signature attendue</xsl:text>
			</xsl:when>
			<xsl:when test="$sig/@code = &apos;X&apos;">
				<xsl:text>Signature requise</xsl:text>
			</xsl:when>
		</xsl:choose>
	</xsl:template>

	<!-- show-id -->
	<xsl:template name="show-id">
		<xsl:param name="id"/>
		<xsl:choose>
			<xsl:when test="not($id)">
				<xsl:if test="not(@nullFlavor)">
					<xsl:if test="@extension">
						<xsl:value-of select="@extension"/>
					</xsl:if>
					<xsl:text> [</xsl:text>
					<xsl:value-of select="@root"/>
					<xsl:text>]</xsl:text>
				</xsl:if>
			</xsl:when>
			<xsl:otherwise>
				<xsl:if test="not($id/@nullFlavor)">
					<xsl:if test="$id/@extension">
						<xsl:value-of select="$id/@extension"/>
					</xsl:if>
					<xsl:text> [</xsl:text>
					<xsl:value-of select="$id/@root"/>
					<xsl:text>]</xsl:text>
				</xsl:if>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	
	<!-- show-identifiant -->
	<xsl:template name="show-identifiant">
		<xsl:param name="id"/>
		<xsl:choose>
			<xsl:when test="not($id)">
				<xsl:if test="not(@nullFlavor)">
					<xsl:if test="@extension">
						<xsl:value-of select="@extension"/>
					</xsl:if>
				</xsl:if>
			</xsl:when>
			<xsl:otherwise>
				<xsl:if test="not($id/@nullFlavor)">
					<xsl:if test="$id/@extension">
						<xsl:value-of select="$id/@extension"/>
					</xsl:if>
				</xsl:if>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<!-- show-idName -->
	<xsl:template name="show-idName">
		<xsl:param name="id"/>
		<xsl:choose>
			<xsl:when test="not($id)">
				<xsl:if test="not(@nullFlavor)">
					<xsl:if test="@extension">
						<xsl:value-of select="@extension"/>
					</xsl:if>
					<xsl:text> [</xsl:text>
					<xsl:value-of select="@root"/>
					<xsl:text>]</xsl:text>
				</xsl:if>
			</xsl:when>
			<xsl:otherwise>
				<xsl:if test="not($id/@nullFlavor)">
					<xsl:if test="$id/@extension">
						<xsl:value-of select="$id/@extension"/>
					</xsl:if>
					<xsl:text> [</xsl:text>
					<xsl:value-of select="$id/@root"/>
					<xsl:text>]</xsl:text>
				</xsl:if>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<!-- show-realm -->
	<xsl:template name="show-realmCode">
		<xsl:param name="realmCode"/>
		<xsl:choose>
			<xsl:when test="not($realmCode)">
				<xsl:if test="not(@nullFlavor)">
					<xsl:if test="@code">
						<xsl:value-of select="@code"/>
					</xsl:if>
				</xsl:if>
			</xsl:when>
			<xsl:otherwise>
				<xsl:if test="not($realmCode/@nullFlavor)">
					<xsl:if test="$realmCode/@code">
						<xsl:value-of select="$realmCode/@code"/>
					</xsl:if>
				</xsl:if>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<!-- show-typeId -->
	<xsl:template name="show-typeId">
		<xsl:param name="typeId"/>
		<xsl:choose>
			<xsl:when test="not($typeId)">
				<xsl:if test="not(@nullFlavor)">
					<xsl:if test="@extension">
						<xsl:value-of select="@extension"/>
					</xsl:if>
					<xsl:text> [</xsl:text>
					<xsl:value-of select="@root"/>
					<xsl:text>]</xsl:text>
				</xsl:if>
			</xsl:when>
			<xsl:otherwise>
				<xsl:if test="not($typeId/@nullFlavor)">
					<xsl:if test="$typeId/@extension">
						<xsl:value-of select="$typeId/@extension"/>
					</xsl:if>
					<xsl:text> [</xsl:text>
					<xsl:value-of select="$typeId/@root"/>
					<xsl:text>]</xsl:text>
				</xsl:if>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<!-- show-languageCode -->
	<xsl:template name="show-languageCode">
		<xsl:param name="languageCode"/>
		<xsl:choose>
			<xsl:when test="not($languageCode)">
				<xsl:if test="not(@nullFlavor)">
					<xsl:if test="@code">
						<xsl:value-of select="@code"/>
					</xsl:if>
				</xsl:if>
			</xsl:when>
			<xsl:otherwise>
				<xsl:if test="not($languageCode/@nullFlavor)">
					<xsl:if test="$languageCode/@code">
						<xsl:value-of select="$languageCode/@code"/>
					</xsl:if>
				</xsl:if>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<!-- show-templateId -->
	<xsl:template name="show-templateId">
		<xsl:param name="templateId"/>
		<xsl:choose>
			<xsl:when test="not($templateId)">
				<xsl:if test="not(@nullFlavor)">	
					<xsl:value-of select="@root"/>
					<xsl:if test="@extension">
						<xsl:text> [</xsl:text>
						<xsl:value-of select="@extension"/>						
						<xsl:text>]</xsl:text>
					</xsl:if>
				</xsl:if>
			</xsl:when>
			<xsl:otherwise>
				<xsl:if test="not($templateId/@nullFlavor)">					
					<xsl:value-of select="$templateId/@root"/>
					<xsl:if test="$templateId/@extension">
						<xsl:text> [</xsl:text>
						<xsl:value-of select="$templateId/@extension"/>					
						<xsl:text>]</xsl:text>
					</xsl:if>
				</xsl:if>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<!-- show-name	-->
	<xsl:template name="show-name">
		<xsl:param name="name"/>
		<xsl:choose>
			<xsl:when test="$name/n1:family">
			<xsl:choose> 
					<xsl:when test="$name/n1:suffix">
						<xsl:for-each select="$name/n1:suffix">
							<span style="font-weight:bold; ">
								<xsl:value-of select="."/>
							</span>
							<xsl:text> </xsl:text>
						</xsl:for-each>
					</xsl:when>
					<xsl:otherwise>
						<xsl:for-each select="$name/n1:prefix">
							<span style="font-weight:bold; ">
								<xsl:value-of select="."/>
							</span>
							<xsl:text> </xsl:text>
						</xsl:for-each>
					</xsl:otherwise>
				</xsl:choose>
				<xsl:for-each select="$name/n1:given">
					<span style="font-weight:bold; ">
						<xsl:value-of select="."/>
						<xsl:text> </xsl:text>
					</span>
				</xsl:for-each>
				<xsl:for-each select="$name/n1:family">
					<span style="font-weight:bold; ">
						<xsl:value-of select="."/>
					</span>
					<xsl:if test="@qualifier">
						<xsl:choose>
							<xsl:when test="@qualifier = &apos;BR&apos;">
								<xsl:text> (Nom de famille) </xsl:text>
							</xsl:when>
							<xsl:when test="@qualifier = &apos;SP&apos;">
								<xsl:text> (Nom d'usage) </xsl:text>
							</xsl:when>
							<xsl:otherwise>
								<xsl:value-of select="@qualifier"/>
							</xsl:otherwise>
						</xsl:choose>
					</xsl:if>
					<xsl:text> </xsl:text>
				</xsl:for-each>
			</xsl:when>
			<xsl:otherwise>
				<span style="font-weight:bold; ">
					<xsl:value-of select="$name"/>
				</span>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<!-- show-patient-name	-->
	<xsl:template name="show-patient-name">
		<xsl:param name="name"/>
		<xsl:if test="$name/n1:prefix">
			<tr>
				<td width="20%">
					<span class="td_label">
						<xsl:text>Civilité</xsl:text>
					</span>
				</td>
				<td colspan="3">
					<xsl:for-each select="$name/n1:prefix">
						<xsl:value-of select="."/>
						<br/>
					</xsl:for-each>
				</td>
			</tr>
		</xsl:if>
		
		<xsl:for-each select="$name/n1:family">
			<xsl:choose>
				<xsl:when test="@qualifier">
					<xsl:choose>
						<xsl:when test="@qualifier = &apos;BR&apos;">
							<tr>
								<td width="20%">
									<span class="td_label">
										<xsl:text>Nom de naissance</xsl:text>
									</span>
								</td>
								<td colspan="3">
									<span style="font-weight:bold; ">
										<xsl:value-of select="."/>
									</span>
								</td>
							</tr>
							<tr>
								<td width="20%">
									<span class="td_label">
										<xsl:text>Prénom(s)</xsl:text>
									</span>
								</td>
								<td colspan="3">
									<xsl:variable name="count" select="count($name/n1:given[@qualifier != &apos;CL&apos; or not(@qualifier)])"/>
									<xsl:for-each select="$name/n1:given[@qualifier != &apos;CL&apos; or not(@qualifier)]">
										<xsl:choose>
											<xsl:when test="@qualifier = &apos;BR&apos;">
												<span style="font-weight:bold; ">
													<xsl:value-of select="."/>
												</span>	
											</xsl:when>
											<xsl:otherwise>
												<xsl:value-of select="."/>
											</xsl:otherwise>
										</xsl:choose>
										<xsl:if test="$count > 1">
											<xsl:if test="(position() != last()) and (position() > 1)">
												<xsl:text>, </xsl:text>
											</xsl:if>
											<xsl:if test="position() = 1">
												<xsl:text> [</xsl:text>
											</xsl:if>
											<xsl:if test="position() = last()">
												<xsl:text>]</xsl:text>
											</xsl:if>
										</xsl:if>
									</xsl:for-each>
								</td>
							</tr>
						</xsl:when>
						<xsl:when test="@qualifier = &apos;SP&apos;">
							<tr>
								<td width="20%">
									<span class="td_label">
										<xsl:text>Nom d'usage</xsl:text>
									</span>
								</td>
									<td colspan="3">
											<xsl:value-of select="."/>
									</td>
							</tr>
						</xsl:when>
						<xsl:when test="@qualifier = &apos;CL&apos;">
							<tr>
								<td width="20%">
									<span class="td_label">
										<xsl:text>Nom et prénom utilisés</xsl:text>
									</span>
								</td>
								<td colspan="3">
										<span style="font-weight:bold; ">
											<xsl:value-of select="."/>
											<xsl:text>&#160;</xsl:text>
											<xsl:for-each select="$name/n1:given">
												<xsl:if test="@qualifier = &apos;CL&apos;">
													<xsl:value-of select="."/>
												</xsl:if>
												<xsl:text>&#160;</xsl:text>
											</xsl:for-each>	
										</span>	
								</td>
							</tr>
						</xsl:when>
					</xsl:choose>
				</xsl:when>
				<xsl:otherwise>
					<tr>
						<td width="20%">
							<span class="td_label">
								<xsl:text>Nom</xsl:text>
							</span>
						</td>
						<td colspan="3">
								<xsl:value-of select="."/>
						</td>
					</tr>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:for-each>
	</xsl:template>

	<!-- show-guardian	-->	
	<xsl:template name="show-guardian">
		<xsl:param name="guardian"/>
		<xsl:for-each select="$guardian/n1:guardianPerson">
					<xsl:call-template name="show-name">
						<xsl:with-param name="name" select="."/>
					</xsl:call-template>					
					<br/>
					<br/>
					<xsl:for-each select="$guardian/n1:addr">
						<xsl:call-template name="show-address">
							<xsl:with-param name="address" select="."/>
						</xsl:call-template>
						<br/>
					</xsl:for-each>
					<xsl:for-each select="$guardian/n1:telecom">
						<xsl:call-template name="show-telecom">
							<xsl:with-param name="telecom" select="."/>
						</xsl:call-template>
						<br/>
					</xsl:for-each>
		</xsl:for-each>
		<xsl:for-each select="$guardian/n1:guardianOrganization">
					<xsl:call-template name="show-name">
						<xsl:with-param name="name" select="."/>
					</xsl:call-template>
					<br/>
					<xsl:for-each select="$guardian/n1:addr">
						<xsl:call-template name="show-address">
							<xsl:with-param name="address" select="."/>
						</xsl:call-template>
						<br/>
					</xsl:for-each>
					<xsl:for-each select="$guardian/n1:telecom">
						<xsl:call-template name="show-telecom">
							<xsl:with-param name="telecom" select="."/>
						</xsl:call-template>
						<br/>
					</xsl:for-each>
		</xsl:for-each>
	</xsl:template>
	
	<!-- show-gender	-->
	<xsl:template name="show-gender">
		<xsl:choose>
			<xsl:when test="@code = &apos;M&apos;">
				<xsl:text>Masculin</xsl:text>
			</xsl:when>
			<xsl:when test="@code = &apos;F&apos;">
				<xsl:text>Féminin</xsl:text>
			</xsl:when>
			<xsl:when test="@code = &apos;U&apos;">
				<xsl:text>Inconnu</xsl:text>
			</xsl:when>
		</xsl:choose>

	</xsl:template>

	<!-- show-typeRelationship	-->
	<xsl:template name="show-typeRelationship">
		<xsl:param name="typeContact"/>
		<xsl:choose>
			<xsl:when test="$typeContact/@code = &apos;MTH&apos;">
				<xsl:text>(Mère)</xsl:text>
			</xsl:when>
			<xsl:when test="$typeContact/@code = &apos;FTH&apos;">
				<xsl:text>(Père)</xsl:text>
			</xsl:when>
			<xsl:when test="$typeContact/@code = &apos;&apos;"/>
			<xsl:otherwise>
				<xsl:text>(</xsl:text>
				<xsl:value-of select="$typeContact"/>
				<xsl:text>)</xsl:text>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<!-- show-contactInfo -->
	<xsl:template name="show-contactInfo">
		<xsl:param name="contact"/>
		<xsl:call-template name="show-address">
			<xsl:with-param name="address" select="$contact/n1:addr"/>
		</xsl:call-template>
		<xsl:for-each select="$contact/n1:telecom">
			<xsl:call-template name="show-telecom">
				<xsl:with-param name="telecom" select="."/>
			</xsl:call-template>
		</xsl:for-each>
	</xsl:template>
	
	<!-- show-address-city -->
	<xsl:template name="show-address-city">
		<xsl:param name="address"/>
		<xsl:choose>
			<xsl:when test="$address">
				<xsl:if test="$address/@use">
					<xsl:text> </xsl:text>
					<xsl:call-template name="translateTelecomCode">
						<xsl:with-param name="code" select="$address/@use"/>
					</xsl:call-template>
					<xsl:text>:</xsl:text>
					<br/>
				</xsl:if>
				<xsl:if test="string-length($address/n1:city) > 0">
					<xsl:text> </xsl:text>
					<xsl:value-of select="$address/n1:city"/>
				</xsl:if>
			</xsl:when>
		</xsl:choose>
	</xsl:template>
	
	<!-- show-address-county -->
	<xsl:template name="show-address-county">
		<xsl:param name="address"/>
		<xsl:choose>
			<xsl:when test="$address">
				<xsl:if test="$address/@use">
					<xsl:text> </xsl:text>
					<xsl:call-template name="translateTelecomCode">
						<xsl:with-param name="code" select="$address/@use"/>
					</xsl:call-template>
					<xsl:text>:</xsl:text>
					<br/>
				</xsl:if>
				<xsl:if test="string-length($address/n1:county) > 0">
					<xsl:text> </xsl:text>
					<xsl:value-of select="$address/n1:county"/>
				</xsl:if>
			</xsl:when>
		</xsl:choose>
	</xsl:template>

	<!-- show-address	-->
	<xsl:template name="show-address">
		<xsl:param name="address"/>
		<xsl:choose>
			<xsl:when test="$address">
				<xsl:if test="$address/@use">
					<xsl:text> </xsl:text>
					<xsl:call-template name="translateTelecomCode">
						<xsl:with-param name="code" select="$address/@use"/>
					</xsl:call-template>
					<xsl:text>:</xsl:text>
					<br/>
				</xsl:if>
				<xsl:for-each select="$address/n1:streetAddressLine">
					<xsl:value-of select="."/>
					<br/>
				</xsl:for-each>
				<xsl:if test="$address/n1:streetName">
					<xsl:value-of select="$address/n1:houseNumber"/>
					<xsl:text> </xsl:text>
					<xsl:value-of select="$address/n1:streetNameType"/>
					<xsl:text> </xsl:text>
					<xsl:value-of select="$address/n1:streetName"/>
					<br/>
				</xsl:if>
				<xsl:if test="string-length($address/n1:postalCode) > 0">
					<xsl:value-of select="$address/n1:postalCode"/>
				</xsl:if>
				<xsl:if test="string-length($address/n1:city) > 0">
					<xsl:text> </xsl:text>
					<xsl:value-of select="$address/n1:city"/>
				</xsl:if>
				<xsl:if test="string-length($address/n1:state) > 0">
					<xsl:text> </xsl:text>
					<xsl:value-of select="$address/n1:state"/>
				</xsl:if>
				<xsl:if test="string-length($address/n1:country) > 0">
					<xsl:text> </xsl:text>
					<xsl:value-of select="$address/n1:country"/>
				</xsl:if>
			</xsl:when>
			<xsl:otherwise>
				<xsl:text>addresse non renseignée</xsl:text>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<!-- show-telecom	-->
	<xsl:template name="show-telecom">
		<xsl:param name="telecom"/>
		<xsl:choose>
			<xsl:when test="$telecom">
				<xsl:variable name="type" select="substring-before($telecom/@value, ':')"/>
				<xsl:variable name="value" select="substring-after($telecom/@value, ':')"/>
				<xsl:if test="$type">
					<xsl:call-template name="translateTelecomCode">
						<xsl:with-param name="code" select="$type"/>
					</xsl:call-template>
					<xsl:if test="@use">
						<xsl:text> (</xsl:text>
						<xsl:call-template name="translateTelecomCode">
							<xsl:with-param name="code" select="@use"/>
						</xsl:call-template>
						<xsl:text>)</xsl:text>
					</xsl:if>
					<xsl:text>: </xsl:text>
					<xsl:text> </xsl:text>
					<xsl:value-of select="$value"/>
				</xsl:if>
			</xsl:when>
			<xsl:otherwise>
				<xsl:text>Coordonnées téléphoniques non renseignées</xsl:text>
			</xsl:otherwise>
		</xsl:choose>
		<br/>
	</xsl:template>

	<!-- show-recipientType -->
	<xsl:template name="show-recipientType">
		<xsl:param name="typeCode"/>
		<xsl:choose>
			<xsl:when test="$typeCode = 'PRCP'">Destinataire principal :</xsl:when>
			<xsl:when test="$typeCode = 'TRC'">Autre destinataire :</xsl:when>
			<xsl:otherwise>Recipient:</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<!-- Convert Telecom URL to display text -->
	<xsl:template name="translateTelecomCode">
		<xsl:param name="code"/>
		<xsl:choose>
			<!-- lookup table Telecom URI -->
			<xsl:when test="$code = 'tel'">
				<xsl:text>Tel</xsl:text>
			</xsl:when>
			<xsl:when test="$code = 'fax'">
				<xsl:text>Fax</xsl:text>
			</xsl:when>
			<xsl:when test="$code = 'http'">
				<xsl:text>Page Web</xsl:text>
			</xsl:when>
			<xsl:when test="$code = 'mailto'">
				<xsl:text>E-mail</xsl:text>
			</xsl:when>
			<xsl:when test="$code = 'H'">
				<xsl:text>Domicile</xsl:text>
			</xsl:when>
			<xsl:when test="$code = 'HV'">
				<xsl:text>Domicile secondaire</xsl:text>
			</xsl:when>
			<xsl:when test="$code = 'HP'">
				<xsl:text>Domicile principal</xsl:text>
			</xsl:when>
			<xsl:when test="$code = 'WP'">
				<xsl:text>Travail</xsl:text>
			</xsl:when>
			<xsl:when test="$code = 'PUB'">
				<xsl:text>Bureau standard</xsl:text>
			</xsl:when>
			<xsl:when test="$code = 'DIR'">
				<xsl:text>Numéro direct</xsl:text>
			</xsl:when>
			<xsl:when test="$code = 'EC'">
				<xsl:text>Numéro d'urgence</xsl:text>
			</xsl:when>
			<xsl:when test="$code = 'MC'">
				<xsl:text>Mobile</xsl:text>
			</xsl:when>
			<xsl:when test="$code = 'PG'">
				<xsl:text>Beeper</xsl:text>
			</xsl:when>
			<xsl:otherwise>
				<xsl:text>{$code='</xsl:text>
				<xsl:value-of select="$code"/>
				<xsl:text>'?}</xsl:text>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<!-- convert RoleClassAssociative code to display text -->
	<xsl:template name="translateRoleAssoCode">
		<xsl:param name="code"/>
		<xsl:choose>
			<xsl:when test="$code = 'AFFL'">
				<xsl:text>affiliate</xsl:text>
			</xsl:when>
			<xsl:when test="$code = 'AGNT'">
				<xsl:text>agent</xsl:text>
			</xsl:when>
			<xsl:when test="$code = 'ASSIGNED'">
				<xsl:text>assigned entity</xsl:text>
			</xsl:when>
			<xsl:when test="$code = 'COMPAR'">
				<xsl:text>commissioning party</xsl:text>
			</xsl:when>
			<xsl:when test="$code = 'CON'">
				<xsl:text>contact</xsl:text>
			</xsl:when>
			<xsl:when test="$code = 'ECON'">
				<xsl:text>contact d'urgence</xsl:text>
			</xsl:when>
			<xsl:when test="$code = 'NOK'">
				<xsl:text>proche</xsl:text>
			</xsl:when>
			<xsl:when test="$code = 'SGNOFF'">
				<xsl:text>signing authority</xsl:text>
			</xsl:when>
			<xsl:when test="$code = 'GUARD'">
				<xsl:text>tuteur</xsl:text>
			</xsl:when>
			<xsl:when test="$code = 'GUAR'">
				<xsl:text>tuteur</xsl:text>
			</xsl:when>
			<xsl:when test="$code = 'CIT'">
				<xsl:text>citoyen</xsl:text>
			</xsl:when>
			<xsl:when test="$code = 'COVPTY'">
				<xsl:text>covered party</xsl:text>
			</xsl:when>
			<xsl:when test="$code = 'CAREGIVER'">
				<xsl:text>intervenant à domicile</xsl:text>
			</xsl:when>
			<xsl:when test="$code = 'PROV'">
				<xsl:text>PS</xsl:text>
			</xsl:when>
			<xsl:otherwise>
				<xsl:text>code='</xsl:text>
				<xsl:value-of select="$code"/>
				<xsl:text>'</xsl:text>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<!-- convert relatedEntity/code@code to display text -->
	<xsl:template name="translate-related-code">
		<xsl:param name="code"/>
		<xsl:choose>
			<xsl:when test="$code = 'FAMMEMB'">
				<xsl:text>(Membre de la famille) : </xsl:text>
			</xsl:when>
			<xsl:when test="$code = 'CHILD'">
				<xsl:text>(Enfant) : </xsl:text>
			</xsl:when>
			<xsl:when test="$code = 'DAU'">
				<xsl:text>(Fille) : </xsl:text>
			</xsl:when>
			<xsl:when test="$code = 'SON'">
				<xsl:text>(Fils) : </xsl:text>
			</xsl:when>
			<xsl:when test="$code = 'GRNDDAU'">
				<xsl:text>(Petite-fille) : </xsl:text>
			</xsl:when>
			<xsl:when test="$code = 'GRNDSON'">
				<xsl:text>(Petit-fils) : </xsl:text>
			</xsl:when>
			<xsl:when test="$code = 'FTH'">
				<xsl:text>(Père) : </xsl:text>
			</xsl:when>
			<xsl:when test="$code = 'MTH'">
				<xsl:text>(Mère) : </xsl:text>
			</xsl:when>
			<xsl:when test="$code = 'NFTH'">
				<xsl:text>(Père naturel) : </xsl:text>
			</xsl:when>
			<xsl:when test="$code = 'NMTH'">
				<xsl:text>(Mère naturelle) : </xsl:text>
			</xsl:when>
			<xsl:when test="$code = 'GRFTH'">
				<xsl:text>(Grand-père) : </xsl:text>
			</xsl:when>
			<xsl:when test="$code = 'GRMTH'">
				<xsl:text>(Grand-mère) : </xsl:text>
			</xsl:when>
			<xsl:when test="$code = 'BRO'">
				<xsl:text>(Frère) : </xsl:text>
			</xsl:when>
			<xsl:when test="$code = 'SIS'">
				<xsl:text>(Soeur) : </xsl:text>
			</xsl:when>
			<xsl:when test="$code = 'HUSB'">
				<xsl:text>(Mari) : </xsl:text>
			</xsl:when>
			<xsl:when test="$code = 'WIFE'">
				<xsl:text>(Epouse) : </xsl:text>
			</xsl:when>
			<xsl:when test="$code = 'DOMPART'">
				<xsl:text>(Partenaire PACS) : </xsl:text>
			</xsl:when>
			<xsl:when test="$code = 'ROOM'">
				<xsl:text>(Personne vivant sous le même toit) : </xsl:text>
			</xsl:when>
			<xsl:when test="$code = 'FRND'">
				<xsl:text>(Ami) : </xsl:text>
			</xsl:when>
			<xsl:when test="$code = 'NBOR'">
				<xsl:text>(Voisin) : </xsl:text>
			</xsl:when>
			<xsl:when test="$code = 'TUTEUR'">
				<xsl:text>(Relation de tuteur légal) : </xsl:text>
			</xsl:when>
			<xsl:when test="$code = 'SIGOTHR'">
				<xsl:text>(Autre relation) : </xsl:text>
			</xsl:when>
			<xsl:otherwise>
				<xsl:text>{$code='</xsl:text>
				<xsl:value-of select="$code"/>
				<xsl:text>'?}</xsl:text>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<!-- show time -->
	<xsl:template name="show-time">
		<xsl:param name="datetime"/>
		<xsl:choose>
			<xsl:when test="not($datetime)">
				<xsl:call-template name="formatDateTime">
					<xsl:with-param name="date" select="@value"/>
				</xsl:call-template>
				<xsl:text> </xsl:text>
			</xsl:when>
			<xsl:otherwise>
				<xsl:call-template name="formatDateTime">
					<xsl:with-param name="date" select="$datetime/@value"/>
				</xsl:call-template>
				<xsl:text> </xsl:text>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<!-- show assignedEntity-name -->
	<xsl:template name="show-assignedEntity-name">
		<xsl:param name="asgnEntity"/>
		<xsl:if test="$asgnEntity/n1:assignedPerson/n1:name">
			<xsl:call-template name="show-name">
				<xsl:with-param name="name" select="$asgnEntity/n1:assignedPerson/n1:name"/>
			</xsl:call-template>
			<br/>
		</xsl:if>
		<xsl:for-each select="$asgnEntity/n1:id">
			<xsl:call-template name="show-id"/>
		</xsl:for-each>
	</xsl:template>

	<!-- show assignedEntity-orga -->
	<xsl:template name="show-assignedEntity-orga">
		<xsl:param name="asgnEntity"/>
		<xsl:if test="$asgnEntity/n1:representedOrganization/n1:name">
			<xsl:value-of select="$asgnEntity/n1:representedOrganization/n1:name"/>
			<xsl:if
				test="$asgnEntity/n1:representedOrganization/n1:asOrganizationPartOf/n1:wholeOrganization/n1:name">
				<br/>
				<xsl:text>au sein de : </xsl:text>
				<xsl:value-of
					select="$asgnEntity/n1:representedOrganization/n1:asOrganizationPartOf/n1:wholeOrganization/n1:name"
				/>
			</xsl:if>
		</xsl:if>
	</xsl:template>

	<!-- show assignedEntity-orga-id -->
	<xsl:template name="show-assignedEntity-orga-id">
		<xsl:param name="asgnEntity"/>
		<xsl:if test="$asgnEntity/n1:representedOrganization/n1:id">
			<xsl:for-each select="$asgnEntity/n1:representedOrganization/n1:id">
				<xsl:call-template name="show-id"/>
				<br/>
			</xsl:for-each>
		</xsl:if>
	</xsl:template>

	<!-- show relatedEntity -->
	<xsl:template name="show-relatedEntity">
		<xsl:param name="relatedEntity"/>
		<xsl:if test="$relatedEntity/n1:code">
			<xsl:call-template name="translate-related-code">
				<xsl:with-param name="code" select="$relatedEntity/n1:code/@code"/>
			</xsl:call-template>
		</xsl:if>
		<xsl:if test="$relatedEntity/n1:relatedPerson/n1:name">
			<xsl:call-template name="show-name">
				<xsl:with-param name="name" select="$relatedEntity/n1:relatedPerson/n1:name"/>
			</xsl:call-template>
		</xsl:if>
	</xsl:template>
	
	<!-- show associatedEntity -->
	<xsl:template name="show-associatedEntity">
		<xsl:param name="assoEntity"/>
		<xsl:choose>
			<xsl:when test="$assoEntity/n1:associatedPerson">
				<xsl:for-each select="$assoEntity/n1:associatedPerson/n1:name">
					<xsl:call-template name="show-name">
						<xsl:with-param name="name" select="."/>
					</xsl:call-template>
					<br/>
				</xsl:for-each>
			</xsl:when>
			<xsl:when test="$assoEntity/n1:scopingOrganization">
				<xsl:for-each select="$assoEntity/n1:scopingOrganization">
					<xsl:if test="n1:name">
						<xsl:call-template name="show-name">
							<xsl:with-param name="name" select="n1:name"/>
						</xsl:call-template>
						<br/>
					</xsl:if>
					<xsl:if test="n1:standardIndustryClassCode">
						<xsl:value-of select="n1:standardIndustryClassCode/@displayName"/>
						<xsl:text> code:</xsl:text>
						<xsl:value-of select="n1:standardIndustryClassCode/@code"/>
					</xsl:if>
				</xsl:for-each>
			</xsl:when>
			<xsl:when test="$assoEntity/n1:code">
				<xsl:call-template name="show-code">
					<xsl:with-param name="code" select="$assoEntity/n1:code"/>
				</xsl:call-template>
			</xsl:when>
			<xsl:when test="$assoEntity/n1:id">
				<xsl:value-of select="$assoEntity/n1:id/@extension"/>
				<xsl:text> </xsl:text>
				<xsl:value-of select="$assoEntity/n1:id/@root"/>
			</xsl:when>
		</xsl:choose>
	</xsl:template>

	<!-- show code -->
	<!-- if originalText present, return it, otherwise, check and return attribute displayName -->
	<xsl:template name="show-code">
		<xsl:param name="code"/>
		<xsl:if test="$code/@code">
			<xsl:choose>
				<xsl:when test="$code/@code = 'PRELV'">
					<xsl:text>Préleveur : </xsl:text>
				</xsl:when>
				<xsl:otherwise>
					<xsl:text>(</xsl:text>
					<xsl:value-of select="$code/@code"/>
					<xsl:text>) </xsl:text>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:if>
		<xsl:choose>
		<xsl:when test="$code/@displayName">
			<xsl:text> </xsl:text>
			<xsl:value-of select="$code/@displayName"/>
			<xsl:text> </xsl:text>
		</xsl:when>
		</xsl:choose>
		<xsl:choose>
		<xsl:when test="$code/n1:originalText">
				<xsl:text> </xsl:text>
				<xsl:value-of select="$code/n1:originalText"/>
		</xsl:when> 
		</xsl:choose>
	</xsl:template> 

	
	<xsl:template name="show-consent">
		<xsl:param name="code"/>
		<xsl:if test="$code/@code">
			<xsl:choose>
				<xsl:when test="$code/@code = 'completed'">
					<xsl:text>(donné)</xsl:text>
				</xsl:when>
				<xsl:otherwise>
					<xsl:text>(</xsl:text>
					<xsl:value-of select="$code/@code"/>
					<xsl:text>) </xsl:text>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:if>

	</xsl:template> 
	
	<!-- show Translation code -->
	<xsl:template name="show-translation-code">
		<xsl:param name="code"/>
		<xsl:if test="$code/@code">
			<xsl:choose>
				<xsl:when test="$code/@code = 'PRELV'">
					<xsl:text>Préleveur : </xsl:text>
				</xsl:when>
				<xsl:otherwise>
					<xsl:text>(</xsl:text>
					<xsl:value-of select="$code/@code"/>
					<xsl:text>) </xsl:text>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:if>
		<xsl:choose>
			<xsl:when test="$code/@displayName">
				<xsl:text> </xsl:text>
				<xsl:value-of select="$code/@displayName"/>
				<xsl:text> </xsl:text>
			</xsl:when>
		</xsl:choose>
		<xsl:choose>
			<xsl:when test="$code/n1:originalText">
				<xsl:text> </xsl:text>
				<xsl:value-of select="$code/n1:originalText"/>
			</xsl:when> 
		</xsl:choose>
	</xsl:template> 
	
	
	<!-- DEBUT Ajout commentaire participant 24/05/2019 -->	
	<!-- show participantOriginalText -->
	<xsl:template name="show-participantOriginalText">
		<xsl:param name="participantOriginalText"/>
		<xsl:text> </xsl:text>
		<xsl:value-of select="n1:functionCode/n1:originalText"/>
		<xsl:text> </xsl:text>
	</xsl:template>
	<!-- FIN Ajout commentaire participant 24/05/2019 -->
	
	<!-- show classCode -->
	<xsl:template name="show-actClassCode">
		<xsl:param name="clsCode"/>
		<xsl:choose>
			<xsl:when test="$clsCode = 'ACT'">
				<xsl:text>healthcare service</xsl:text>
			</xsl:when>
			<xsl:when test="$clsCode = 'ACCM'">
				<xsl:text>accommodation</xsl:text>
			</xsl:when>
			<xsl:when test="$clsCode = 'ACCT'">
				<xsl:text>account</xsl:text>
			</xsl:when>
			<xsl:when test="$clsCode = 'ACSN'">
				<xsl:text>accession</xsl:text>
			</xsl:when>
			<xsl:when test="$clsCode = 'ADJUD'">
				<xsl:text>financial adjudication</xsl:text>
			</xsl:when>
			<xsl:when test="$clsCode = 'CONS'">
				<xsl:text>consent</xsl:text>
			</xsl:when>
			<xsl:when test="$clsCode = 'CONTREG'">
				<xsl:text>container registration</xsl:text>
			</xsl:when>
			<xsl:when test="$clsCode = 'CTTEVENT'">
				<xsl:text>clinical trial timepoint event</xsl:text>
			</xsl:when>
			<xsl:when test="$clsCode = 'DISPACT'">
				<xsl:text>disciplinary action</xsl:text>
			</xsl:when>
			<xsl:when test="$clsCode = 'ENC'">
				<xsl:text>encounter</xsl:text>
			</xsl:when>
			<xsl:when test="$clsCode = 'INC'">
				<xsl:text>incident</xsl:text>
			</xsl:when>
			<xsl:when test="$clsCode = 'INFRM'">
				<xsl:text>inform</xsl:text>
			</xsl:when>
			<xsl:when test="$clsCode = 'INVE'">
				<xsl:text>invoice element</xsl:text>
			</xsl:when>
			<xsl:when test="$clsCode = 'LIST'">
				<xsl:text>working list</xsl:text>
			</xsl:when>
			<xsl:when test="$clsCode = 'MPROT'">
				<xsl:text>monitoring program</xsl:text>
			</xsl:when>
			<xsl:when test="$clsCode = 'PCPR'">
				<xsl:text>care provision</xsl:text>
			</xsl:when>
			<xsl:when test="$clsCode = 'PROC'">
				<xsl:text>procedure</xsl:text>
			</xsl:when>
			<xsl:when test="$clsCode = 'REG'">
				<xsl:text>registration</xsl:text>
			</xsl:when>
			<xsl:when test="$clsCode = 'REV'">
				<xsl:text>review</xsl:text>
			</xsl:when>
			<xsl:when test="$clsCode = 'SBADM'">
				<xsl:text>substance administration</xsl:text>
			</xsl:when>
			<xsl:when test="$clsCode = 'SPCTRT'">
				<xsl:text>speciment treatment</xsl:text>
			</xsl:when>
			<xsl:when test="$clsCode = 'SUBST'">
				<xsl:text>substitution</xsl:text>
			</xsl:when>
			<xsl:when test="$clsCode = 'TRNS'">
				<xsl:text>transportation</xsl:text>
			</xsl:when>
			<xsl:when test="$clsCode = 'VERIF'">
				<xsl:text>verification</xsl:text>
			</xsl:when>
			<xsl:when test="$clsCode = 'XACT'">
				<xsl:text>financial transaction</xsl:text>
			</xsl:when>
		</xsl:choose>
	</xsl:template>

	<!-- show classCode of relatedEntity -->
	<xsl:template name="show-relatedEntityClass">
		<xsl:param name="clsCode"/>
		<xsl:choose>
			<xsl:when test="$clsCode = 'ECON'">
				<xsl:text>Contact en cas d'urgence</xsl:text>
			</xsl:when>
			<xsl:when test="$clsCode = 'NOK'">
				<xsl:text>Personne de confiance</xsl:text>
			</xsl:when>
			<xsl:when test="$clsCode = 'CON'">
				<xsl:text>Informateur</xsl:text>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="clsCode"/>
				<xsl:text>  </xsl:text>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<!-- show participationType -->
	<xsl:template name="show-participationType">
		<xsl:param name="ptype"/>
		<xsl:choose>
			<xsl:when test="$ptype = 'PPRF'">
				<xsl:text>Exécutant principal</xsl:text>
			</xsl:when>
			<xsl:when test="$ptype = 'PRF'">
				<xsl:text>Exécutant</xsl:text>
			</xsl:when>
			<xsl:when test="$ptype = 'VRF'">
				<xsl:text>Valideur</xsl:text>
			</xsl:when>
			<xsl:when test="$ptype = 'SPRF'">
				<xsl:text>Autre exécutant</xsl:text>
			</xsl:when>
		</xsl:choose>
	</xsl:template>

	<!-- show participationFunction -->
	<xsl:template name="show-participationFunction">
		<xsl:param name="pFunction"/>
		<xsl:choose>
			<xsl:when test="$pFunction = 'ADMPHYS'">
				<xsl:text>Médecin instruisant</xsl:text>
			</xsl:when>
			<xsl:when test="$pFunction = 'ANEST'">
				<xsl:text>Anesthésiste</xsl:text>
			</xsl:when>
			<xsl:when test="$pFunction = 'ANRS'">
				<xsl:text>Infirmière anesthésiste</xsl:text>
			</xsl:when>
			<xsl:when test="$pFunction = 'ATTPHYS'">
				<xsl:text>Médecin traitant</xsl:text>
			</xsl:when>
			<xsl:when test="$pFunction = 'DISPHYS'">
				<xsl:text>Médecin autorisant la sortie</xsl:text>
			</xsl:when>
			<xsl:when test="$pFunction = 'FASST'">
				<xsl:text>Premier assistant chirurgien</xsl:text>
			</xsl:when>
			<xsl:when test="$pFunction = 'MDWF'">
				<xsl:text>Sage-femme</xsl:text>
			</xsl:when>
			<xsl:when test="$pFunction = 'NASST'">
				<xsl:text>Aide soignant(e)</xsl:text>
			</xsl:when>
			<xsl:when test="$pFunction = 'PCP'">
				<xsl:text>Médecin de famille</xsl:text>
			</xsl:when>
			<xsl:when test="$pFunction = 'PRISURG'">
				<xsl:text>Chirurgien responsable</xsl:text>
			</xsl:when>
			<xsl:when test="$pFunction = 'RNDPHYS'">
				<xsl:text>Médecin coordinateur</xsl:text>
			</xsl:when>
			<xsl:when test="$pFunction = 'SASST'">
				<xsl:text>Deuxième assistant chirurgien</xsl:text>
			</xsl:when>
			<xsl:when test="$pFunction = 'SNRS'">
				<xsl:text>Infirmière de salle d'opération</xsl:text>
			</xsl:when>
			<xsl:when test="$pFunction = 'TASST'">
				<xsl:text>Autre assistant</xsl:text>
			</xsl:when>
		</xsl:choose>
	</xsl:template>

	<!-- formatDateTime -->
	<xsl:template name="formatDateTime">
		<xsl:param name="date"/>
		<!-- day -->
		<xsl:choose>
			<xsl:when test="substring($date, 7, 1) = &quot;0&quot;">
				<xsl:value-of select="substring($date, 8, 1)"/>
				<xsl:text> </xsl:text>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="substring($date, 7, 2)"/>
				<xsl:text> </xsl:text>
			</xsl:otherwise>
		</xsl:choose>
		<!-- month -->
		<xsl:variable name="month" select="substring($date, 5, 2)"/>
		<xsl:choose>
			<xsl:when test="$month = '01'">
				<xsl:text>Janvier </xsl:text>
			</xsl:when>
			<xsl:when test="$month = '02'">
				<xsl:text>Février </xsl:text>
			</xsl:when>
			<xsl:when test="$month = '03'">
				<xsl:text>Mars </xsl:text>
			</xsl:when>
			<xsl:when test="$month = '04'">
				<xsl:text>Avril </xsl:text>
			</xsl:when>
			<xsl:when test="$month = '05'">
				<xsl:text>Mai </xsl:text>
			</xsl:when>
			<xsl:when test="$month = '06'">
				<xsl:text>Juin </xsl:text>
			</xsl:when>
			<xsl:when test="$month = '07'">
				<xsl:text>Juillet </xsl:text>
			</xsl:when>
			<xsl:when test="$month = '08'">
				<xsl:text>Août </xsl:text>
			</xsl:when>
			<xsl:when test="$month = '09'">
				<xsl:text>Septembre </xsl:text>
			</xsl:when>
			<xsl:when test="$month = '10'">
				<xsl:text>Octobre </xsl:text>
			</xsl:when>
			<xsl:when test="$month = '11'">
				<xsl:text>Novembre </xsl:text>
			</xsl:when>
			<xsl:when test="$month = '12'">
				<xsl:text>Décembre </xsl:text>
			</xsl:when>
		</xsl:choose>
		<!-- year -->
		<xsl:value-of select="substring($date, 1, 4)"/>
		<!-- time and US timezone -->
		<xsl:if test="string-length($date) > 8">
			<xsl:text>, </xsl:text>
			<!-- time -->
			<xsl:variable name="time">
				<xsl:value-of select="substring($date, 9, 6)"/>
			</xsl:variable>
			<xsl:variable name="hh">
				<xsl:value-of select="substring($time, 1, 2)"/>
			</xsl:variable>
			<xsl:variable name="mm">
				<xsl:value-of select="substring($time, 3, 2)"/>
			</xsl:variable>
			<xsl:variable name="ss">
				<xsl:value-of select="substring($time, 5, 2)"/>
			</xsl:variable>
			<xsl:if test="string-length($hh) &gt; 1">
				<xsl:value-of select="$hh"/>
				<xsl:if
					test="string-length($mm) &gt; 1 and not(contains($mm, '-')) and not(contains($mm, '+'))">
					<xsl:text>:</xsl:text>
					<xsl:value-of select="$mm"/>
					<xsl:if
						test="string-length($ss) &gt; 1 and not(contains($ss, '-')) and not(contains($ss, '+'))">
						<xsl:text>:</xsl:text>
						<xsl:value-of select="$ss"/>
					</xsl:if>
				</xsl:if>
			</xsl:if>
			<!-- time zone -->
			<xsl:variable name="tzon">
				<xsl:choose>
					<xsl:when test="contains($date, '+')">
						<xsl:text>+</xsl:text>
						<xsl:value-of select="substring-after($date, '+')"/>
					</xsl:when>
					<xsl:when test="contains($date, '-')">
						<xsl:text>-</xsl:text>
						<xsl:value-of select="substring-after($date, '-')"/>
					</xsl:when>
				</xsl:choose>
			</xsl:variable>
			<xsl:choose>
				<!-- reference: http://www.timeanddate.com/library/abbreviations/timezones/na/ -->
				<xsl:when test="$tzon = '-0500'">
					<xsl:text>, EST</xsl:text>
				</xsl:when>
				<xsl:when test="$tzon = '-0600'">
					<xsl:text>, CST</xsl:text>
				</xsl:when>
				<xsl:when test="$tzon = '-0700'">
					<xsl:text>, MST</xsl:text>
				</xsl:when>
				<xsl:when test="$tzon = '-0800'">
					<xsl:text>, PST</xsl:text>
				</xsl:when>
				<xsl:otherwise>
					<xsl:text> </xsl:text>
					<xsl:value-of select="$tzon"/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:if>
	</xsl:template>

	<!-- convert to lower case -->
	<xsl:template name="caseDown">
		<xsl:param name="data"/>
		<xsl:if test="$data">
			<xsl:value-of
				select="translate($data, 'ABCDEFGHIJKLMNOPQRSTUVWXYZ', 'abcdefghijklmnopqrstuvwxyz')"/>
		</xsl:if>
	</xsl:template>

	<!-- convert to upper case -->
	<xsl:template name="caseUp">
		<xsl:param name="data"/>
		<xsl:if test="$data">
			<xsl:value-of
				select="translate($data, 'abcdefghijklmnopqrstuvwxyz', 'ABCDEFGHIJKLMNOPQRSTUVWXYZ')"/>
		</xsl:if>
	</xsl:template>
	
	<!-- convert first character to upper case -->
	<xsl:template name="firstCharCaseUp">
		<xsl:param name="data"/>
		<xsl:if test="$data">
			<xsl:call-template name="caseUp">
				<xsl:with-param name="data" select="substring($data, 1, 1)"/>
			</xsl:call-template>
			<xsl:value-of select="substring($data, 2)"/>
		</xsl:if>
	</xsl:template>
	
	<!-- show-noneFlavor -->
	<xsl:template name="show-noneFlavor"> </xsl:template>
</xsl:stylesheet>