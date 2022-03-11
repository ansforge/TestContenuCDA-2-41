<?xml version="1.0" encoding="UTF-8"?>
<!-- 
   CI-SIS_TLM-DA_2021.01.csh
   
   Auteur : ANS
   ......................................................................................................................................................    
   Historique :
   16/09/2021 : Création schématron TLM-DA_2021.01
   ......................................................................................................................................................       
-->

<schema xmlns="http://purl.oclc.org/dsdl/schematron" defaultPhase="CI-SIS_TLM-DA_2021.01"
  xmlns:cda="urn:hl7-org:v3" queryBinding="xslt2"
  xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" schemaVersion="CI-SIS_TLM-DA_2021.01.sch">
  <title>Vérification de la conformité au modèle TLM-DA_2021.01</title>
  <ns prefix="cda" uri="urn:hl7-org:v3"/>
  <ns prefix="xsi" uri="http://www.w3.org/2001/XMLSchema-instance"/>
  <ns prefix="jdv" uri="http://esante.gouv.fr"/>
  <ns prefix="svs" uri="urn:ihe:iti:svs:2008"/>

  <!-- Abstract patterns -->
  <include href="abstract/dansJeuDeValeurs.sch"/>
  <include href="abstract/IVL_TS.sch"/>

  <!-- Sections spécifiques au document TLM-DA -->
  <include href="include/sections/S_anamneseEtFacteursDeRisques_ANS.sch"/>
  <include href="include/sections/S_anamnese_ANS.sch"/>

  <!-- Entrées spécifiques au document TLM-DA -->
  <!-- Néant -->

  <!-- Entete spécifiques au document TLM-DA -->
  <include href="include/specificationsVolets/TLM-DA_2021.01/Entete_TLM-DA.sch"/>
  
  <!-- JDV spécifiques au document TLM-DA -->
  <include href="include/jeuxDeValeurs/TLM-DA_2021.01/JDV_SeverityObservation.sch"/>

  <phase id="CI-SIS_TLM-DA_2021.01">
    
    <active pattern="variables"/>

    <!-- Entete -->
    <active pattern="Entete_TLM-DA"/>

    <!-- Sections -->
    <active pattern="S_anamneseEtFacteursDeRisques_ANS"/>
    <active pattern="S_anamnese_ANS"/>
    
    <!-- JDV -->
    <active pattern="JDV_SeverityObservation"/>
    
  </phase>

  <pattern id="variables">
    
    <let name="jdv_Severite" value="'../jeuxDeValeurs/JDV_HL7_SeverityObservation-CISIS.xml'"/> 

    <rule context="cda:ClinicalDocument">
      <assert test="cda:templateId[@root = '1.2.250.1.213.1.1.1.38']"> 
        [CI-SIS_TLM-DA_2021.01] Erreur de conformité : Le templateID du modèle TLM-DA (1.2.250.1.213.1.1.1.38) doit être présent.
      </assert>
    </rule>

    <rule context="cda:ClinicalDocument/cda:component/cda:structuredBody">
      <!-- Présence obligatoire de la section Anamnèse et facteurs de risques (1.2.250.1.213.1.1.2.68) -->
      <assert test='cda:component/cda:section/cda:templateId[@root = "1.2.250.1.213.1.1.2.68"]'>
        [CI-SIS_TLM-DA_2021.01] Erreur de conformité : La section Anamnèse et facteurs de risques (1.2.250.1.213.1.1.2.68) est obligatoire.
      </assert>
      
      <!-- Présence obligatoire de la section FR-Traitements (1.3.6.1.4.1.19376.1.5.3.1.3.19) -->
      <assert test="cda:component/cda:section[cda:templateId[@root = '1.3.6.1.4.1.19376.1.5.3.1.3.19']]">
        [CI-SIS_TLM-DA_2021.01] Erreur de conformité : La section FR-Traitements (1.3.6.1.4.1.19376.1.5.3.1.3.19) est obligatoire.
      </assert>
    </rule>

    <rule
      context="cda:ClinicalDocument/cda:component/cda:structuredBody/cda:component/cda:section[cda:templateId[@root = '1.2.250.1.213.1.1.2.68']]">
      <!-- Présence obligatoire de la section Anamnèse (1.2.250.1.213.1.1.2.69) -->
      <assert test="cda:component/cda:section[cda:templateId[@root = '1.2.250.1.213.1.1.2.69']]">
        [CI-SIS_TLM-DA_2021.01] Erreur de conformité : La section Anamnèse (1.2.250.1.213.1.1.2.69) est obligatoire.
      </assert>
    </rule>

  </pattern>
</schema>
