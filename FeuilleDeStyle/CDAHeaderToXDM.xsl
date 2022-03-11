<?xml version="1.0" encoding="UTF-8"?>
<!-- This a xslt stylesheet redacted by ASIP Santé in purpose to generate a xml metatada document 
    that fulfill the demands of the XDM profil.
    The required elements are created by using the function "call-template", which means that they are created even if they 
    don't exist, fields will only be empty. (Except for the level 1 element)
    However, optionnal elements are created thanks to the function "apply-template", which means that elements gonna be created 
    only if they already exist
    
    Author : LBE
    Date of creation : 03/10/2017 (american notation)
    -->
<xsl:stylesheet 
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
	version="2.0"
    xmlns:exsl="http://exslt.org/common" 
	extension-element-prefixes="exsl"
	exclude-result-prefixes="exsl">

    <xsl:output method="xml" indent="yes" encoding="utf-8"/>

    <!-- Declaration des variables-->
    <!-- Variables propres à l'auteur -->
    <xsl:variable name="assignedAuthorId_extension"
        select="ClinicalDocument/author/assignedAuthor/id/@extension"/>
    <!-- Id de l'auteur -->
    <xsl:variable name="assignedAuthorId_root"
        select="ClinicalDocument/author/assignedAuthor/id/@root"/>
    <xsl:variable name="authorCode" select="ClinicalDocument/author/assignedAuthor/code"/>
    <xsl:variable name="authorCode_code" select="$authorCode/@code"/>
    <xsl:variable name="authorCode_displayName" select="$authorCode/@displayName"/>
    <xsl:variable name="authorCode_codeSystem" select="$authorCode/@codeSystem"/>
    <xsl:variable name="authorFunctionCode_displayName"
        select="ClinicalDocument/author/functionCde/@displayName"/>
    
    <xsl:variable name="representedOrganization_name" select="ClinicalDocument/author/assignedAuthor/representedOrganization/name"/>
    <xsl:variable name="representedOrganization_identification" select = "ClinicalDocument/author/assignedAuthor/representedOrganization/id"/>
    <!-- Variables propres au patient -->
    <xsl:variable name="patientId_root" select="ClinicalDocument/recordTarget/patientRole/id/@root"/>
    <xsl:variable name="patientId_extension"
        select="ClinicalDocument/recordTarget/patientRole/id/@extension"/>
    <xsl:variable name="PatientBirthTime"
        select="ClinicalDocument/recordTarget/patientRole/patient/birthTime/@value"/>
    <xsl:variable name="PatientSex"
        select="ClinicalDocument/recordTarget/patientRole/patient/administrativeGenderCode/@code"/>

    <!-- Variables identification du document  -->
    <xsl:variable name="idRoot" select="ClinicalDocument/id/@root"/>
    <xsl:variable name="idExtension" select="ClinicalDocument/id/@extension"/>
    <xsl:variable name="title" select="ClinicalDocument/title"/>
    <!-- Variables liées à la confidentialité -->
    <xsl:variable name="confidentiality_code" select="ClinicalDocument/confidentialityCode/@code"/>
    <xsl:variable name="confidentiality_dislayName"
        select="ClinicalDocument/confidentialityCode/@displayName"/>
    <xsl:variable name="confidentiality_codeSystem"
        select="ClinicalDocument/confidentialityCode/@codeSystem"/>

    <!-- Variables DocumentationOf -->
    <xsl:variable name="service"
        select="ClinicalDocument/documentationOf/serviceEvent/effectiveTime"/>
    <!-- Variables HealthCare facility -->
    <xsl:variable name="healthCareFacility"
        select="ClinicalDocument/componentOf/encompassingEncounter/location/healthCareFacility/code"/>
    <!-- Variable standard Industry Class Code -->
    <xsl:variable name="standardIndustryClassCode"
        select="ClinicalDocument/documentationOf/serviceEvent/performer/assignedEntity/representedOrganization/standardIndustryClassCode"/>

    <xsl:variable name="serviceEvent" select="ClinicalDocument/documentationOf/serviceEvent/code"/>
    <!-- Elements racines -->
    <xsl:template match="/">
        <ns5:SubmitObjectsRequest xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
            xmlns:xsd="http://www.w3.org/2001/XMLSchema"
            xmlns:ns5="urn:oasis:names:tc:ebxml-regrep:xsd:lcm:3.0">
            <RegistryObjectList xmlns="urn:oasis:names:tc:ebxml-regrep:xsd:rim:3.0">
                <!-- registryPackage -->
                <xsl:call-template name="regitryPackage"/>
                <!-- extrinsecObject -->
                <xsl:call-template name="extrinsecObject"/>
            </RegistryObjectList>
        </ns5:SubmitObjectsRequest>
    </xsl:template>

    <!-- *** EXTRINSEC OBJECT *** -->
    <xsl:template name="extrinsecObject">
        <ExtrinsicObject id="70e100f6-3ee8-466c-a81e-33fe8a9e128e"
            objectType="urn:uuid:7edca82f-054d-47f2-a032-9b2a5b5186c1" mimeType="text/xml"
            xmlns:ns2="urn:oasis:names:tc:ebxml-regrep:xsd:rim:3.0">
            <!-- Slot -->
            <xsl:variable name="document-uri" select="document-uri(.)"/>
            <xsl:variable name="filename" select="(tokenize($document-uri, '/'))[last()]"/>
            <Slot name="hash">
                <ValueList>
                    <Value>6adf25a04eef5cb1557b3341e0f33ebc775c98dc</Value>
                    <!-- Hash du document en SHA1 -->
                </ValueList>
            </Slot>
            <Slot name="size">
                <ValueList>
                    <Value>144745</Value>
                    <!-- Taille en octet du document-->
                </ValueList>
            </Slot>
            <Slot name="URI">
                <ValueList>
                    <Value>
                        <xsl:value-of select="$filename"/>
                    </Value>
                    <!-- Nom du fichier CDA dans le zip-->
                </ValueList>
            </Slot>

            <xsl:apply-templates select="ClinicalDocument"/>
            <xsl:call-template name="legalAuthenticator"/>
            <!-- ServiceStartTime -->
            <xsl:call-template name="serviceStartTime"/>
            <!-- service stop time -->
            <xsl:apply-templates
                select="ClinicalDocument/documentationOf/serviceEvent/effectiveTime/high"/>

            <!-- Patient -->
            <xsl:call-template name="patientId"/>
            <xsl:call-template name="sourcePatientId"/>
            <xsl:apply-templates select="ClinicalDocument/recordTarget/patientRole/patient/name"/>

            <!--title-->
            <xsl:call-template name="title"/>
            <!-- Classification -->
            <!-- author -->
            <classification id="cla11"
                classificationScheme="urn:uuid:93606bcf-9494-43ec-9b4e-a7748d1a838d"
                classifiedObject="70e100f6-3ee8-466c-a81e-33fe8a9e128e" nodeRepresentation="">

                <xsl:apply-templates select="ClinicalDocument/author/assignedAuthor"/>
            </classification>
            <!-- FormatCode -->
            <xsl:call-template name="formatCode"/>
            <!--  healthcare Facility -->
            <xsl:call-template name="healthCareFacility"/>
            <!-- standardIndustryClassCode -->
            <xsl:call-template name="standardIndustryClassCode"/>
            <!-- confidentiality -->
            <xsl:call-template name="confidentialityCode"/>
            <!-- service event -->
            <xsl:apply-templates select="ClinicalDocument/documentationOf/serviceEvent"/>
            <!-- type  -->
            <xsl:call-template name="type"/>
            <!-- ExternalIdnetifier-->
            <xsl:call-template name="id">
                <xsl:with-param name="xds">XDSDocumentEntry</xsl:with-param>
            </xsl:call-template>
            <xsl:call-template name="patientId_externalIdentifier">
                <xsl:with-param name="xds">XDSDocumentEntry</xsl:with-param>
            </xsl:call-template>
        </ExtrinsicObject>
    </xsl:template>
    <!-- ************************ -->
    <!-- *** REGISTRY PACKAGE *** -->

    <xsl:template name="regitryPackage">
        <ns2:RegistryPackage id="SubmissionSet01"
            xmlns:ns2="urn:oasis:names:tc:ebxml-regrep:xsd:rim:3.0">
            <!-- Slot -->
            <Slot name="submissionTime">
                <ValueList>
                    <Value>En fonction de la soumission</Value>
                    <!-- Heure de la soumission au format AAAAMMJJHHMMSS éventuellement avec l'offset UTC, à renseigner avec l'heure de constitution du fichier metadata.xml -->
                </ValueList>
            </Slot>
            <Description>
                <LocalizedString xml:lang="FR" charset="UTF8" value="{$title}"/>
                <!-- Titre du lot de soumission. Pour un lot de soumission monodocument, peut reprendre le titre du document -->
            </Description>
            <!-- author -->
            <classification id="author"
                classificationScheme="urn:uuid:93606bcf-9494-43ec-9b4e-a7748d1a838d"
                classifiedObject="70e100f6-3ee8-466c-a81e-33fe8a9e128e" nodeRepresentation="">

                <xsl:apply-templates select="ClinicalDocument/author/assignedAuthor"/>
            </classification>
            <!-- healthCareFacility -->
            <xsl:call-template name="healthCareFacility">
                
            </xsl:call-template>
            <!-- ExternalIdnetifier-->
            <xsl:call-template name="patientId_externalIdentifier">
                <xsl:with-param name="xds">XDSSumissionsSet</xsl:with-param>
              
            </xsl:call-template>
            <ExternalIdentifier id="SubmissionSet01_e004" registryObject="SubmissionSet01"
                identificationScheme="urn:uuid:554ac39e-e3fe-47fe-b233-965d2a147832"
                value="A fournir par le logiciel lors de la constitution du lot">
                <ns2:Name>
                    <ns2:LocalizedString xml:lang="FR" charset="UTF8"
                        value="XDSSubmissionSet.sourceId"/>
                </ns2:Name>
            </ExternalIdentifier>
            <xsl:call-template name="id">
                <xsl:with-param name="xds">XDSSumissionsSet</xsl:with-param>
            </xsl:call-template>
        </ns2:RegistryPackage>
    </xsl:template>
    <!-- ************************ -->


    <!-- *** ELM NIV 1** -->
    <xsl:template name="type">
        <Classification id="Type"
            classificationScheme="urn:uuid:f0306f51-975f-434e-a61c-c59651d33983"
            classifiedObject="efbb37ce-cec0-42d4-ba59-71eec9fc789e" nodeRepresentation="{ClinicalDocument/code/@code}">
            <Slot name="codingScheme">
                <ValueList>
                    <Value><xsl:value-of select="ClinicalDocument/code/@codeSystem"/></Value>
                </ValueList>
            </Slot>
            <Name>
                <LocalizedString xml:lang="FR" charset="UTF8" value="{ClinicalDocument/code/@displayName}"/>
            </Name>
        </Classification>
    </xsl:template>
    <xsl:template match="ClinicalDocument">
        <!--CreationTime -->
        <Slot name="creationTime">
            <ValueList>
                <Value>
                    <xsl:value-of select="effectiveTime/@value"/>
                </Value>
            </ValueList>
        </Slot>
        <!-- languageCode -->
        <Slot name="languageCode">
            <ValueList>
                <Value>
                    <xsl:value-of select="languageCode/@code"/>
                </Value>
            </ValueList>
        </Slot>

    </xsl:template>
    <!-- UniqueId -->
    <xsl:template name="id">
        <xsl:param name="xds"/>
        <xsl:choose>
            <xsl:when test="$idExtension != ''">
                <ExternalIdentifier id="uniqueId" registryObject="" identificationScheme="urn:uuid:"
                    value="{$idRoot}^{$idExtension}">
                    <Name>
                        <LocalizedString xml:lang="FR" charset="UTF8"
                            value="{$xds}.uniqueId"/>
                    </Name>
                </ExternalIdentifier>
            </xsl:when>
            <xsl:otherwise>
                <ExternalIdentifier id="uniqueId" registryObject="" identificationScheme="urn:uuid:"
                    value="{$idRoot}">
                    <Name>
                        <LocalizedString xml:lang="FR" charset="UTF8"
                            value="{$xds}.uniqueId"/>
                    </Name>
                </ExternalIdentifier>
            </xsl:otherwise>
        </xsl:choose>

    </xsl:template>
    <!-- PatientId -->
    <xsl:template name="patientId_externalIdentifier">
        <xsl:param name="xds"/>
        <ExternalIdentifier id="PatientId" registryObject="70e100f6-3ee8-466c-a81e-33fe8a9e128e"
            identificationScheme="urn:uuid:2e82c1f6-a085-4c72-9da3-8640a32e42ab"
            value=" {$patientId_extension}^^^&amp;{$patientId_root}&amp;^INS-C^^DateEffective^'">
            <Name>
                <LocalizedString xml:lang="FR" charset="UTF8" value="{$xds}.patientId"/>
            </Name>
        </ExternalIdentifier>
    </xsl:template>
    <!-- Title -->
    <xsl:template name="title">
        <Name>
            <LocalizedString xml:lang="FR" charset="UTF8" value="{$title}"/>
        </Name>

    </xsl:template>

    <!-- *************** -->
    <!-- CLASSIFICATION -->
    <!--Classifiction format, doit être conforme à la matrice de déduction de la métadonnée à partir du contenu CDA -->

    <!-- Si le CDA est structuré -->
    <xsl:template name="formatCode">
        <xsl:variable name="formatCode_metadata">
            <xsl:for-each select="ClinicalDocument/templateId">

                <xsl:choose>
                    <!-- CR-BIO -->
                    <xsl:when test="@root = '1.3.6.1.4.1.19376.1.3.3'">
                        <formatCode>
                            <xsl:value-of select="'urn:ihe:lab:xd-lab:2008'"/>
                        </formatCode>
                        <codingScheme>
                            <xsl:value-of select="'1.3.6.1.4.1.19376.1.2.3'"/>
                        </codingScheme>
                        <formatCodeDisplayName>Compte rendu structuré d’examens de biologie
                            médicale</formatCodeDisplayName>
                    </xsl:when>
                    <!--AVK -->
                    <xsl:when test="@root = '1.2.250.1.213.1.1.1.2.1.1'">
                        <formatCode>
                            <xsl:value-of select="'urn:asip:ci-sis:avk:2009'"/>
                        </formatCode>
                        <codingScheme>
                            <xsl:value-of select="'1.2.250.1.213.1.1.4.2.282'"/>
                        </codingScheme>
                        <formatCodeDisplayName>Fiche patient à risque en cardiologie - Traitement
                            AVK</formatCodeDisplayName>
                    </xsl:when>
                    <!-- TAP -->
                    <xsl:when test="@root = '1.2.250.1.213.1.1.1.2.1.2'">
                        <formatCode>
                            <xsl:value-of select="'urn:asip:ci-sis:tap:2009'"/>
                        </formatCode>
                        <codingScheme>
                            <xsl:value-of select="'1.2.250.1.213.1.1.4.2.282'"/>
                        </codingScheme>
                        <formatCodeDisplayName>Fiche patient à risque en cardiologie - Traitement
                            Antiaggrégant Plaquettaire/Stent</formatCodeDisplayName>
                    </xsl:when>
                    <!-- DCI -->
                    <xsl:when test="@root = '1.2.250.1.213.1.1.1.2.1.3'">
                        <formatCode>
                            <xsl:value-of select="'urn:asip:ci-sis:dci:2009'"/>
                        </formatCode>
                        <codingScheme>
                            <xsl:value-of select="'1.2.250.1.213.1.1.4.2.282'"/>
                        </codingScheme>
                        <formatCodeDisplayName>Fiche patient à risque en cardiologie -
                            Défibrillateur Cardiaque Interne</formatCodeDisplayName>
                    </xsl:when>
                    <!-- PSC -->
                    <xsl:when test="@root = '1.2.250.1.213.1.1.1.2.1.4'">
                        <formatCode>
                            <xsl:value-of select="'urn:asip:ci-sis:psc:2009'"/>
                        </formatCode>
                        <codingScheme>
                            <xsl:value-of select="'1.2.250.1.213.1.1.4.2.282'"/>
                        </codingScheme>
                        <formatCodeDisplayName>Fiche patient à risque en cardiologie - Porteur d'un
                            simulateur cardiaque</formatCodeDisplayName>
                    </xsl:when>
                    <!-- PPV -->
                    <xsl:when test="@root = '1.2.250.1.213.1.1.1.2.1.5'">
                        <formatCode>
                            <xsl:value-of select="'urn:asip:ci-sis:ppv:2009'"/>
                        </formatCode>
                        <codingScheme>
                            <xsl:value-of select="'1.2.250.1.213.1.1.4.2.282'"/>
                        </codingScheme>
                        <formatCodeDisplayName>Fiche patient à risque en cardiologie - Porteur d'une
                            Prothèse Valvulaire</formatCodeDisplayName>
                    </xsl:when>
                    <!-- CVA -->
                    <xsl:when test="@root = '1.2.250.1.213.1.1.1.10'">
                        <formatCode>
                            <xsl:value-of select="'urn:ihe:pcc:ic:2009'"/>
                        </formatCode>
                        <codingScheme>
                            <xsl:value-of select="'1.3.6.1.4.1.19376.1.2.3'"/>
                        </codingScheme>
                        <formatCodeDisplayName>Carnet de vaccination</formatCodeDisplayName>
                    </xsl:when>
                    <!-- VSM -->
                    <xsl:when test="@root = '1.2.250.1.213.1.1.1.13'">
                        <formatCode>
                            <xsl:value-of select="'urn:asip:ci-sis:vsm:2012'"/>
                        </formatCode>
                        <codingScheme>
                            <xsl:value-of select="'1.2.250.1.213.1.1.4.2.282'"/>
                        </codingScheme>
                        <formatCodeDisplayName>Synthèse Médicale</formatCodeDisplayName>
                    </xsl:when>
                    <!-- CS8 -->
                    <xsl:when test="@root = '1.2.250.1.213.1.1.1.5.1'">
                        <formatCode>
                            <xsl:value-of select="'urn:ihe:qrph:hbs:2009'"/>
                        </formatCode>
                        <codingScheme>
                            <xsl:value-of select="'1.3.6.1.4.1.19376.1.2.3'"/>
                        </codingScheme>
                        <formatCodeDisplayName>Certificat de santé du 8ème jour de
                            l'enfant</formatCodeDisplayName>
                    </xsl:when>
                    <!-- CS9 -->
                    <xsl:when test="@root = '1.2.250.1.213.1.1.1.5.2'">
                        <formatCode>
                            <xsl:value-of select="'urn:asip:ci-sis:cs9:2012'"/>
                        </formatCode>
                        <codingScheme>
                            <xsl:value-of select="'1.2.250.1.213.1.1.4.2.282'"/>
                        </codingScheme>
                        <formatCodeDisplayName>Certificat du 9ème mois de
                            l'enfant</formatCodeDisplayName>
                    </xsl:when>
                    <!-- CS24 -->
                    <xsl:when test="@root = '1.3.6.1.4.1.19376.1.3.3'">
                        <formatCode>
                            <xsl:value-of select="'urn:asip:ci-sis:cs24:2012'"/>
                        </formatCode>
                        <codingScheme>
                            <xsl:value-of select="'1.2.250.1.213.1.1.4.2.282'"/>
                        </codingScheme>
                        <formatCodeDisplayName>Certificat du 24ème mois de
                            l'enfant</formatCodeDisplayName>
                    </xsl:when>
                    <!-- IDAP -->
                    <xsl:when test="@root = '1.2.250.1.213.1.1.1.9'">
                        <formatCode>
                            <xsl:value-of select="'urn:asip:ci-sis:idap:2011'"/>
                        </formatCode>
                        <codingScheme>
                            <xsl:value-of select="'1.2.250.1.213.1.1.4.2.282'"/>
                        </codingScheme>
                        <formatCodeDisplayName>Information et Directives Anticipées du
                            Patient</formatCodeDisplayName>
                    </xsl:when>
                    <!-- FRCP -->
                    <xsl:when test="@root = '1.2.250.1.213.1.1.1.8'">
                        <formatCode>
                            <xsl:value-of select="'urn:asip:ci-sis:frcp:2011'"/>
                        </formatCode>
                        <codingScheme>
                            <xsl:value-of select="'1.2.250.1.213.1.1.4.2.282'"/>
                        </codingScheme>
                        <formatCodeDisplayName>Fiche de réunion de concertation
                            pluridisciplinaire</formatCodeDisplayName>
                    </xsl:when>
                    <!-- CRH -->
                    <xsl:when test="@root = '1.2.250.1.213.1.1.1.3.1'">
                        <formatCode>
                            <xsl:value-of select="'urn:asip:ci-sis:crh:2009'"/>
                        </formatCode>
                        <codingScheme>
                            <xsl:value-of select="'1.2.250.1.213.1.1.4.2.282'"/>
                        </codingScheme>
                        <formatCodeDisplayName>Compte Rendu
                            d'Hospitalisation</formatCodeDisplayName>
                    </xsl:when>
                    <!-- CR ACP -->
                    <!-- modèle générique -->
                    <xsl:when test="@root = '1.3.6.1.4.1.19376.1.8.1.1.1'">
                        <formatCode>
                            <xsl:value-of select="'urn:ihe:pat:apsr:all:2010'"/>
                        </formatCode>
                        <codingScheme>
                            <xsl:value-of select="'1.3.6.1.4.1.19376.1.2.3'"/>
                        </codingScheme>
                        <formatCodeDisplayName> Compte rendu d'anatomie et de cytologie
                            pathologiques - modèle générique</formatCodeDisplayName>
                    </xsl:when>
                    <!-- sein -->
                    <xsl:when test="@root = '1.3.6.1.4.1.19376.1.8.1.1.2.1'">
                        <formatCode>
                            <xsl:value-of select="'urn:ihe:pat:apsr:breast:2010'"/>
                        </formatCode>
                        <codingScheme>
                            <xsl:value-of select="'1.3.6.1.4.1.19376.1.2.3'"/>
                        </codingScheme>
                        <formatCodeDisplayName>Compte rendu d'anatomie et de cytologie pathologiques
                            - sein</formatCodeDisplayName>
                    </xsl:when>
                    <!-- côlon -->
                    <xsl:when test="@root = '1.3.6.1.4.1.19376.1.8.1.1.2.2'">
                        <formatCode>
                            <xsl:value-of select="'urn:ihe:pat:apsr:colon:2010'"/>
                        </formatCode>
                        <codingScheme>
                            <xsl:value-of select="'1.3.6.1.4.1.19376.1.2.3'"/>
                        </codingScheme>
                        <formatCodeDisplayName>Compte rendu d'anatomie et de cytologie pathologiques
                            - côlon</formatCodeDisplayName>
                    </xsl:when>
                    <!-- prostate -->
                    <xsl:when test="@root = '1.3.6.1.4.1.19376.1.8.1.1.2.3'">
                        <formatCode>
                            <xsl:value-of select="'urn:ihe:pat:apsr:prostate:2010'"/>
                        </formatCode>
                        <codingScheme>
                            <xsl:value-of select="'1.3.6.1.4.1.19376.1.2.3'"/>
                        </codingScheme>
                        <formatCodeDisplayName>Compte rendu d'anatomie et de cytologie pathologiques
                            - prostate</formatCodeDisplayName>
                    </xsl:when>
                    <!-- thyroïde -->
                    <xsl:when test="@root = '1.3.6.1.4.1.19376.1.8.1.1.2.4'">
                        <formatCode>
                            <xsl:value-of select="'urn:ihe:pat:apsr:thyroid:2010'"/>
                        </formatCode>
                        <codingScheme>
                            <xsl:value-of select="'1.3.6.1.4.1.19376.1.2.3'"/>
                        </codingScheme>
                        <formatCodeDisplayName>Compte rendu d'anatomie et de cytologie pathologiques
                            - thyroïde</formatCodeDisplayName>
                    </xsl:when>
                    <!-- poumon -->
                    <xsl:when test="@root = '1.3.6.1.4.1.19376.1.8.1.1.2.5'">
                        <formatCode>
                            <xsl:value-of select="'urn:ihe:pat:apsr:lung:2010'"/>
                        </formatCode>
                        <codingScheme>
                            <xsl:value-of select="'1.3.6.1.4.1.19376.1.2.3'"/>
                        </codingScheme>
                        <formatCodeDisplayName>Compte rendu d'anatomie et de cytologie pathologiques
                            - poumon</formatCodeDisplayName>
                    </xsl:when>
                    <!-- mélanome cutané -->
                    <xsl:when test="@root = '1.3.6.1.4.1.19376.1.8.1.1.2.6'">
                        <formatCode>
                            <xsl:value-of select="'urn:ihe:pat:apsr:skin:2010'"/>
                        </formatCode>
                        <codingScheme>
                            <xsl:value-of select="'1.3.6.1.4.1.19376.1.2.3'"/>
                        </codingScheme>
                        <formatCodeDisplayName>Compte rendu d'anatomie et de cytologie pathologiques
                            - mélanome cutané</formatCodeDisplayName>
                    </xsl:when>
                    <!-- rein -->
                    <xsl:when test="@root = '1.3.6.1.4.1.19376.1.8.1.1.2.7'">
                        <formatCode>
                            <xsl:value-of select="'urn:ihe:pat:apsr:kidney:2010'"/>
                        </formatCode>
                        <codingScheme>
                            <xsl:value-of select="'1.3.6.1.4.1.19376.1.2.3'"/>
                        </codingScheme>
                        <formatCodeDisplayName>Compte rendu d'anatomie et de cytologie pathologiques
                            - rein</formatCodeDisplayName>
                    </xsl:when>
                    <!-- col de l'utérus -->
                    <xsl:when test="@root = '1.3.6.1.4.1.19376.1.8.1.1.2.8'">
                        <formatCode>
                            <xsl:value-of
                                select="
                                    '-ACP
                            urn:ihe:pat:apsr:cervix:2010'"
                            />
                        </formatCode>
                        <codingScheme>
                            <xsl:value-of select="'1.3.6.1.4.1.19376.1.2.3'"/>
                        </codingScheme>
                        <formatCodeDisplayName>Compte rendu d'anatomie et de cytologie pathologiques
                            - col de l'utérus</formatCodeDisplayName>
                    </xsl:when>
                    <!-- corps utérin -->
                    <xsl:when test="@root = '1.3.6.1.4.1.19376.1.8.1.1.2.9'">
                        <formatCode>
                            <xsl:value-of select="'urn:ihe:pat:apsr:endometrium:2010'"/>
                        </formatCode>
                        <codingScheme>
                            <xsl:value-of select="'1.3.6.1.4.1.19376.1.2.3'"/>
                        </codingScheme>
                        <formatCodeDisplayName>Compte rendu d'anatomie et de cytologie pathologiques
                            - corps utérin</formatCodeDisplayName>
                    </xsl:when>
                    <!-- ovaires -->
                    <xsl:when test="@root = '1.3.6.1.4.1.19376.1.8.1.1.2.10'">
                        <formatCode>
                            <xsl:value-of select="'urn:ihe:pat:apsr:ovary:2010'"/>
                        </formatCode>
                        <codingScheme>
                            <xsl:value-of select="'1.3.6.1.4.1.19376.1.2.3'"/>
                        </codingScheme>
                        <formatCodeDisplayName>Compte rendu d'anatomie et de cytologie pathologiques
                            - ovaires</formatCodeDisplayName>
                    </xsl:when>
                    <!-- oesophage -->
                    <xsl:when test="@root = '1.3.6.1.4.1.19376.1.8.1.1.2.11'">
                        <formatCode>
                            <xsl:value-of select="'urn:ihe:pat:apsr:esophagus:2010'"/>
                        </formatCode>
                        <codingScheme>
                            <xsl:value-of select="'1.3.6.1.4.1.19376.1.2.3'"/>
                        </codingScheme>
                        <formatCodeDisplayName>Compte rendu d'anatomie et de cytologie pathologiques
                            - oesophage</formatCodeDisplayName>
                    </xsl:when>
                    <!-- estomac -->
                    <xsl:when test="@root = '1.3.6.1.4.1.19376.1.8.1.1.2.12'">
                        <formatCode>
                            <xsl:value-of select="'urn:ihe:pat:apsr:stomach:2010'"/>
                        </formatCode>
                        <codingScheme>
                            <xsl:value-of select="'1.3.6.1.4.1.19376.1.2.3'"/>
                        </codingScheme>
                        <formatCodeDisplayName>Compte rendu d'anatomie et de cytologie pathologiques
                            - estomac</formatCodeDisplayName>
                    </xsl:when>
                    <!-- foie -->
                    <xsl:when test="@root = '1.3.6.1.4.1.19376.1.8.1.1.2.13'">
                        <formatCode>
                            <xsl:value-of select="'urn:ihe:pat:apsr:liver:2010'"/>
                        </formatCode>
                        <codingScheme>
                            <xsl:value-of select="'1.3.6.1.4.1.19376.1.2.3'"/>
                        </codingScheme>
                        <formatCodeDisplayName>Compte rendu d'anatomie et de cytologie pathologiques
                            - foie</formatCodeDisplayName>
                    </xsl:when>
                    <!-- pancréas -->
                    <xsl:when test="@root = '1.3.6.1.4.1.19376.1.8.1.1.2.14'">
                        <formatCode>
                            <xsl:value-of select="'urn:ihe:pat:apsr:pancreas:2010'"/>
                        </formatCode>
                        <codingScheme>
                            <xsl:value-of select="'1.3.6.1.4.1.19376.1.2.3'"/>
                        </codingScheme>
                        <formatCodeDisplayName>Compte rendu d'anatomie et de cytologie pathologiques
                            - pancréas</formatCodeDisplayName>
                    </xsl:when>
                    <!-- testicule -->
                    <xsl:when test="@root = '1.3.6.1.4.1.19376.1.8.1.1.2.15'">
                        <formatCode>
                            <xsl:value-of select="'urn:ihe:pat:apsr:testis:2010'"/>
                        </formatCode>
                        <codingScheme>
                            <xsl:value-of select="'1.3.6.1.4.1.19376.1.2.3'"/>
                        </codingScheme>
                        <formatCodeDisplayName>Compte rendu d'anatomie et de cytologie pathologiques
                            - testicule</formatCodeDisplayName>
                    </xsl:when>
                    <!-- vessie -->
                    <xsl:when test="@root = '1.3.6.1.4.1.19376.1.8.1.1.2.16'">
                        <formatCode>
                            <xsl:value-of select="'urn:ihe:pat:apsr:urinary_bladder:2010'"/>
                        </formatCode>
                        <codingScheme>
                            <xsl:value-of select="'1.3.6.1.4.1.19376.1.2.3'"/>
                        </codingScheme>
                        <formatCodeDisplayName>Compte rendu d'anatomie et de cytologie pathologiques
                            - vessie</formatCodeDisplayName>
                    </xsl:when>
                    <!-- cavité buccale -->
                    <xsl:when test="@root = '1.3.6.1.4.1.19376.1.8.1.1.2.17'">
                        <formatCode>
                            <xsl:value-of select="'urn:ihe:pat:apsr:lip_oral_cavity:2010'"/>
                        </formatCode>
                        <codingScheme>
                            <xsl:value-of select="'1.3.6.1.4.1.19376.1.2.3'"/>
                        </codingScheme>
                        <formatCodeDisplayName>Compte rendu d'anatomie et de cytologie pathologiques
                            - cavité buccale</formatCodeDisplayName>
                    </xsl:when>
                    <!-- pharynx -->
                    <xsl:when test="@root = '1.3.6.1.4.1.19376.1.8.1.1.2.18'">
                        <formatCode>
                            <xsl:value-of select="'urn:ihe:pat:apsr:pharynx:2010'"/>
                        </formatCode>
                        <codingScheme>
                            <xsl:value-of select="'1.3.6.1.4.1.19376.1.2.3'"/>
                        </codingScheme>
                        <formatCodeDisplayName>Compte rendu d'anatomie et de cytologie pathologiques
                            - pharynx</formatCodeDisplayName>
                    </xsl:when>
                    <!--  glandes salivaires-->
                    <xsl:when test="@root = '1.3.6.1.4.1.19376.1.8.1.1.2.19'">
                        <formatCode>
                            <xsl:value-of select="'urn:ihe:pat:apsr:salivary_gland:2010'"/>
                        </formatCode>
                        <codingScheme>
                            <xsl:value-of select="'1.3.6.1.4.1.19376.1.2.3'"/>
                        </codingScheme>
                        <formatCodeDisplayName>Compte rendu d'anatomie et de cytologie pathologiques
                            - glandes salivaires</formatCodeDisplayName>
                    </xsl:when>
                    <!-- larynx -->
                    <xsl:when test="@root = '1.3.6.1.4.1.19376.1.8.1.1.2.20'">
                        <formatCode>
                            <xsl:value-of select="'urn:ihe:pat:apsr:larynx:2010'"/>
                        </formatCode>
                        <codingScheme>
                            <xsl:value-of select="'1.3.6.1.4.1.19376.1.2.3'"/>
                        </codingScheme>
                        <formatCodeDisplayName>Compte rendu d'anatomie et de cytologie pathologiques
                            - larynx</formatCodeDisplayName>
                    </xsl:when>
                    <!-- hors profils -->
                    <!-- <xsl:otherwise >
                        <formatCode> <xsl:value-of select="'null'"/></formatCode>
                        <codingScheme><xsl:value-of select="'null'"/></codingScheme>
                    </xsl:otherwise>           -->
                </xsl:choose>
            </xsl:for-each>
        </xsl:variable>

        <xsl:variable name="formatCode" select="exsl:node-set($formatCode_metadata)/formatCode"/>
        <xsl:variable name="codingScheme" select="exsl:node-set($formatCode_metadata)/codingScheme"/>
        <xsl:variable name="formatCodeDisplayName"
            select="exsl:node-set($formatCode_metadata)/formatCodeDisplayName"/>

        <xsl:choose>
            <xsl:when test="$formatCode != '' and $codingScheme != ''">
                <Classification id="formatCode" classificationScheme="" classifiedObject=""
                    nodeRepresentation="{$formatCode}">
                    <Slot name="codingScheme">
                        <ValueList>
                            <Value>
                                <xsl:value-of select="$codingScheme"/>
                            </Value>
                        </ValueList>
                    </Slot>
                    <Name>
                        <LocalizedString xml:lang="FR" charset="UTF8"
                            value="{$formatCodeDisplayName}"/>
                    </Name>
                </Classification>
            </xsl:when>
            <xsl:otherwise>
                <Classification id="formatCode" classificationScheme="" classifiedObject=""
                    nodeRepresentation="urn:asipSante:modelesHorsProfils:2011">
                    <Slot name="codingScheme">
                        <ValueList>
                            <Value> 1.2.250.1.213.1.1.4.2.282</Value>
                        </ValueList>
                    </Slot>
                    <Name>
                        <LocalizedString xml:lang="FR" charset="UTF8"
                            value="formatCode à prendre pour les documents utilisant un modèle non référencé dans le CI-SIS"
                        />
                    </Name>
                </Classification>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

    <xsl:template name="healthCareFacility">
      
        <Classification id="healthCareFacility"
            classificationScheme="urn:uuid:f33fb8ac-18af-42cc-ae0e-ed0b0bdb91e1" classifiedObject=""
            nodeRepresentation="{$healthCareFacility/@code}">
            <Slot name="codingScheme">
                <ValueList>
                    <Value>
                        <xsl:value-of select="$healthCareFacility/@codeSystem"/>
                    </Value>
                </ValueList>
            </Slot>
            <Name>
                <LocalizedString xml:lang="FR" charset="UTF8"
                    value="{$healthCareFacility/@displayName}"/>
            </Name>
        </Classification>
    </xsl:template>
    <xsl:template name="standardIndustryClassCode">
        <Classification id="standardIndustryClassCode"
            classificationScheme="urn:uuid:cccf5598-8b07-4b77-a05e-ae952c785ead" classifiedObject=""
            nodeRepresentation="{$standardIndustryClassCode/@code}">
            <Slot name="codingScheme">
                <ValueList>
                    <Value>
                        <xsl:value-of select="$standardIndustryClassCode/@codeSystem"/>
                    </Value>
                </ValueList>
            </Slot>
            <Name>
                <LocalizedString xml:lang="FR" charset="UTF8"
                    value="{$standardIndustryClassCode/@displayName}"/>
            </Name>
        </Classification>
    </xsl:template>
    <xsl:template name="confidentialityCode">
        <Classification id="confidentialityCode"
            classificationScheme="urn:uuid:f4f85eac-e6cb-4883-b524-f2705394840f" classifiedObject=""
            nodeRepresentation="{$confidentiality_code}">
            <Slot name="codingScheme">
                <ValueList>
                    <Value>
                        <xsl:value-of select="$confidentiality_codeSystem"/>
                    </Value>
                </ValueList>
            </Slot>
            <Name>
                <LocalizedString xml:lang="FR" charset="UTF8" value="{$confidentiality_dislayName}"
                />
            </Name>
        </Classification>
    </xsl:template>
    <xsl:template name="serviceEvent" match="ClinicalDocument/documentationOf/serviceEvent">
        <xsl:for-each select="code">
            <Classification nodeRepresentation="{@code}" classifiedObject="theDocument"
                classificationScheme="urn:uuid:2c6b8cb7-8b2a-4051-b291-b1ae6a575ef4"
                id="serviceEvent">
                <!-- nodeRepresentation correspond à l'eventCode, à renseigner avec la valeur de documentationOf/serviceEvent/code@code dans le CDA. Si cet élément est multivalué dans le CDA, il convient de répéter la classification pour chaque code -->
                <Slot name="codingScheme">
                    <ValueList>
                        <Value>
                            <xsl:value-of select="@codeSystem"/>
                        </Value>
                        <!-- OID de la nomenclature utilisé pour coder l'eventCode, à renseigner avec la valeur de documentationOf/serviceEvent/code@codeSystem dans le CDA -->
                    </ValueList>
                </Slot>
                <Name>
                    <LocalizedString value="{@displayName}"/>
                    <!-- Libellé de l'eventCode, à renseigner avec la valeur de documentationOf/serviceEvent/code@displayName dans le CDA -->
                </Name>
            </Classification>
        </xsl:for-each>
    </xsl:template>
    <!-- ************** -->
    <!-- *** DOCUMENTATION OF *** -->
    <!--service start time -->
    <xsl:template name="serviceStartTime">
        <Slot name="serviceStartTime">
            <ValueList>
                <Value>
                    <xsl:value-of select="$service/low/@value"/>
                </Value>
                <!-- Heure de début de prise en charge, à renseigner avec la valeur de documentationOf/serviceEvent/effectiveTime@low dans le CDA -->
            </ValueList>
        </Slot>

    </xsl:template>
    <!-- service stop time -->
    <xsl:template match="ClinicalDocument/documentationOf/serviceEvent/effectiveTime/high">
        <Slot name="serviceStopTime">
            <ValueList>
                <Value>
                    <xsl:value-of select="@value"/>
                </Value>
            </ValueList>
        </Slot>
    </xsl:template>
    <!-- ************************ -->
    <!-- *** LEGAL AUTHENTICATOR *** -->
    <xsl:template name="legalAuthenticator">
        <!-- Condition du choix du type d'dentifiant -->
        <xsl:variable name="temp"
            select="ClinicalDocument/legalAuthenticator/assignedEntity/id/@extension"/>
        <xsl:variable name="typeIdentifiant">
            <xsl:choose>
                <xsl:when test="contains($temp, '/')">EI</xsl:when>
                <xsl:otherwise>IDNPS</xsl:otherwise>
            </xsl:choose>
        </xsl:variable>

        <Slot name="legalAuthenticator">
            <ValueList>
                <Value><xsl:value-of
                        select="ClinicalDocument/legalAuthenticator/assignedEntity/id/@extension"
                        />^<xsl:value-of
                        select="ClinicalDocument/legalAuthenticator/assignedEntity/assignedPerson/name/family"
                        />^<xsl:value-of
                        select="ClinicalDocument/legalAuthenticator/assignedEntity/assignedPerson/name/given"
                        />^^^^^^&amp;<xsl:value-of
                        select="ClinicalDocument/legalAuthenticator/assignedEntity/id/@root"/>
                        "&amp;ISO^D^^^<xsl:value-of select="$typeIdentifiant"/></Value>
            </ValueList>
        </Slot>
    </xsl:template>
    <!-- *************************** -->
    <!-- *** PATIENT *** -->
    <xsl:template match="ClinicalDocument/recordTarget/patientRole/patient/name">
        <Slot name="SourcePatientInfo">
            <ValueList>
                <!--Condition de choix du type de nom -->
                <xsl:variable name="NameType">
                    <!-- varibale du type de de nom -->
                    <xsl:choose>
                        <xsl:when test="family/@qualifier = 'SP'"><!-- Si SP-->D</xsl:when>
                        <xsl:when test="family/@qualifier"><!-- Si BR--> L</xsl:when>
                        <xsl:when test="family/@qualifier"><!-- Si CL-->S</xsl:when>
                        <xsl:otherwise>U</xsl:otherwise>
                    </xsl:choose>
                </xsl:variable>

                <Value>PID-5|<xsl:value-of select="family"/>^<xsl:value-of select="given"
                        />^^^^^<xsl:value-of select="$NameType"/></Value>
                <Value>PID-7|<xsl:value-of select="$PatientBirthTime"/></Value>
                <Value>PID-8|<xsl:value-of select="$PatientSex"/></Value>
            </ValueList>
        </Slot>
    </xsl:template>
    <xsl:template name="patientId">
        <Slot name="PatientId">
            <ValueList>
                <Value>
                    <xsl:value-of select="$patientId_extension"/>^^^&amp;<xsl:value-of
                        select="$patientId_root"/>&amp;^INS-C^^DateEffective^</Value>
            </ValueList>
        </Slot>
    </xsl:template>
    <xsl:template name="sourcePatientId">
        <Slot name="sourcePatientId">
            <ValueList>
                <Value>
                    <xsl:value-of select="$patientId_extension"/>^^^&amp;<xsl:value-of
                        select="$patientId_root"/>&amp;ISO </Value>
            </ValueList>
        </Slot>
    </xsl:template>
    <!-- *************** -->
    <!-- *** AUTEUR *** -->
    <xsl:template name="author" match="ClinicalDocument/author/assignedAuthor">

        <xsl:call-template name="authorPerson"/>
        <xsl:call-template name="organization"/>
        <xsl:call-template name="authorSpeciality"/>
        <xsl:call-template name="authorRole"/>
    </xsl:template>

    <xsl:template name="organization" match="representedOrganization">
        <Slot name="authorInstitution">
            <ValueList>
                <Value>
                    <xsl:value-of select="$representedOrganization_name"/>^^^^^<xsl:value-of select="$representedOrganization_identification/@root"
                        />^IDNST^^^<xsl:value-of select="$representedOrganization_identification/@extension"/>
                </Value>
            </ValueList>
        </Slot>
    </xsl:template>
    <xsl:template name="authorPerson">
        <Slot name="authorPerson">
            <ValueList>
                <Value>
                    <xsl:value-of select="$assignedAuthorId_extension"/>^<xsl:value-of select="assignedPerson/name/family"/>^<xsl:value-of select="assignedPerson/name/given"/>^^^^^^&amp;<xsl:value-of select="$assignedAuthorId_root"/>&amp;^D^^^IDNPS;
                </Value>
            </ValueList>
        </Slot>
    </xsl:template>
    <xsl:template name="authorSpeciality">
        <Slot name="authorSpecialty">
            <ValueList>
                <Value>
                    <xsl:value-of select="$authorCode_code"/>^<xsl:value-of
                        select="$authorCode_displayName"/>^<xsl:value-of
                        select="$authorCode_codeSystem"/></Value>
                <!-- Specialité de l'auteur, à renseigner avec des valeurs issues du CDA concaténées comme suit: "author/assignedAuthor/code@code" + "^" + "author/assignedAuthor/code@displayName" + "^" + "author/assignedAuthor/code@codeSystem -->
            </ValueList>
        </Slot>
    </xsl:template>
    <xsl:template name="authorRole">
        <xsl:if test="$authorFunctionCode_displayName">
            <Slot name="authorRole">
                <ValueList>
                    <Value>
                        <xsl:value-of select="$authorFunctionCode_displayName"/>/</Value>
                    <!-- Specialité de l'auteur, à renseigner avec des valeurs issues du CDA concaténées comme suit: "author/assignedAuthor/code@code" + "^" + "author/assignedAuthor/code@displayName" + "^" + "author/assignedAuthor/code@codeSystem -->
                </ValueList>
            </Slot>
        </xsl:if>
    </xsl:template>
    <!-- ***** -->
</xsl:stylesheet>
