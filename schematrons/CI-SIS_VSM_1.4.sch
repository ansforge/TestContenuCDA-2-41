<?xml version="1.0" encoding="UTF-8"?>

<!-- CI-SIS_VSM_1.4
        
        Schématron du Volet de Synthèse Médicale (VSM 2013)
        Auteur : ANS 
        Historique :
        27/09/2019 Création 
        09/06/2020 Suppression du contrôle de la section Traitement au long court qui est fait dans le schématron S_traitementAuLongCours_ASIP.sch
-->
<schema xmlns="http://purl.oclc.org/dsdl/schematron" defaultPhase="CI-SIS_VSM_1.4"
        xmlns:cda="urn:hl7-org:v3" queryBinding="xslt2"
        xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" schemaVersion="CI-SIS_VSM_1.4.sch">

        <title>Vérification de conformité du document aux spécifications du modèle VSM_1.4</title>
        <ns prefix="cda" uri="urn:hl7-org:v3"/>
        <ns prefix="xsi" uri="http://www.w3.org/2001/XMLSchema-instance"/>
        <ns prefix="jdv" uri="http://esante.gouv.fr"/>
        <ns prefix="svs" uri="urn:ihe:iti:svs:2008"/>

        <!--  Abstract patterns  -->
        <include href="abstract/dansJeuDeValeurs.sch"/>
        <include href="abstract/IVL_TS.sch"/>

        <phase id="CI-SIS_VSM_1.4">
                <active pattern="variables"/>
                <p>Vérification complète de la conformité au CI-SIS</p>
        </phase>
        
        <pattern id="variables">

                <rule context="cda:ClinicalDocument">
                        <!-- Verifier le templateId du modèle VSM 2013 -->
                        <assert test="cda:templateId[@root='1.2.250.1.213.1.1.1.13']"> 
                                [VSM] Le templateId "Conformité au VSM" (1.2.250.1.213.1.1.1.13) doit être présent.
                        </assert>
                        <!-- Verifier le code du modèle VSM 2013 -->
                       <assert test="cda:code[@code='SYNTH' and @codeSystem='1.2.250.1.213.1.1.4.12']"> 
                                [VSM] L'élément code doit avoir @code ="SYNTH" et @codeSystem = "1.2.250.1.213.1.1.4.12"/>. 
                        </assert>
                </rule>
                
                <rule context="cda:ClinicalDocument/cda:component/cda:structuredBody">
                        <!-- Vérifier la présence de la section "Pathologies, antécédents, allergies et facteurs de risque"-->
                        <assert test="cda:component/cda:section/cda:templateId[@root='1.2.250.1.213.1.1.2.29']"> 
                                [VSM] Erreur de conformité au volet VSM : La section "Pathologies, antécédents, allergies et facteurs de risque" (1.2.250.1.213.1.1.2.29) doit être présente.
                        </assert>
                        
                        <!-- Verifier la présence de la section "Résultats"-->
                        <assert test="cda:component/cda:section/cda:templateId[@root='1.3.6.1.4.1.19376.1.5.3.1.3.27']"> 
                                [VSM] Erreur de conformité au volet VSM : La section "Résultats" (1.3.6.1.4.1.19376.1.5.3.1.3.27) doit être présente.
                        </assert>
                        
                        <!--  Verifier la présence de la section "Traitement au long cours"-->
                        <assert test="cda:component/cda:section/cda:templateId[@root='1.2.250.1.213.1.1.2.32']"> 
                                [VSM] Erreur de conformité au volet VSM : La section "Traitement au long cours" (1.2.250.1.213.1.1.2.32) doit être présente.
                        </assert>
                </rule>
                
                <!-- [Modif 09/06/2020] Suppression de ce contrôle car la vérification est faite dans le schématron S_traitementAuLongCours_ASIP.sch 
                <rule context="cda:ClinicalDocument/cda:component/cda:structuredBody/cda:component/cda:section[cda:templateId[@root='1.2.250.1.213.1.1.2.32']]">
                        <assert test="cda:component/cda:section[cda:templateId[@root='1.3.6.1.4.1.19376.1.5.3.1.3.19']]/cda:text"> 
                            [VSM] Erreur de conformité au volet VSM : Dans une section "Traitements" (1.3.6.1.4.1.19376.1.5.3.1.3.19) l'élément text est obligatoire.
                    </assert>
                </rule>
                -->
                
                <rule context="cda:ClinicalDocument">
                        <!-- Verifier la présence d'un participant pour le médecin traitant -->
                        <assert test="count(cda:participant[@typeCode='INF']/cda:functionCode[@code='PCP']) =1 
                                and count(cda:participant[@typeCode='INF']/cda:functionCode[@displayName='Médecin Traitant']) =1                                                                                 
                                and count(cda:participant[@typeCode='INF']/cda:functionCode[@codeSystem='2.16.840.1.113883.5.88']) =1">
                                [VSM] Un participant pour le médecin traitant est obligatoire avec typeCode='INF' et functionCode@code='PCP', functionCode@displayName='Médecin Traitant' et functionCode@codeSystem='2.16.840.1.113883.5.88'.
                        </assert>
                </rule>
                
                <rule context="cda:ClinicalDocument">
                        <!-- Vérifier le contenu des attributs de l'acte documenté -->
                        <assert test="(cda:documentationOf/cda:serviceEvent/cda:code[@code='34117-2']) 
                                and (cda:documentationOf/cda:serviceEvent/cda:code[@displayName='Historique et clinique'])                                                                                  
                                and (cda:documentationOf/cda:serviceEvent/cda:code[@codeSystem='2.16.840.1.113883.6.1'])                                                                              
                                and (cda:documentationOf/cda:serviceEvent/cda:code[@codeSystemName='LOINC'])">
                                [VSM] L'acte documenté doit être documentationOf/serviceEvent/code@code='34117-2', @displayName='Historique et clinique', @codeSystem='2.16.840.1.113883.6.1' et @codeSystemName='LOINC'.
                        </assert>
                </rule>
                
        </pattern>
</schema>
