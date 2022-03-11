<?xml version="1.0" encoding="UTF-8"?><schema xmlns="http://purl.oclc.org/dsdl/schematron" xmlns:cda="urn:hl7-org:v3" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" defaultPhase="CI-SIS_IPS-FR_2022.01" queryBinding="xslt2" schemaVersion="CI-SIS_IPS-FR_2022.01.sch">

        <title>Rapport de conformité du document aux spécifications du volet IPS-FR_2022.01</title>
        <ns prefix="cda" uri="urn:hl7-org:v3"/>
        <ns prefix="xsi" uri="http://www.w3.org/2001/XMLSchema-instance"/>
        <ns prefix="jdv" uri="http://esante.gouv.fr"/>
        <ns prefix="svs" uri="urn:ihe:iti:svs:2008"/>

        
        <!--Suppressed abstract pattern dansJeuDeValeurs was here-->
        <!--Suppressed abstract pattern IVL_TS was here-->

        <phase id="CI-SIS_IPS-FR_2022.01">
                <active pattern="variables"/>
                <p>Vérification de la conformité au CI-SIS</p>
        </phase>

        <pattern id="variables">

                <rule context="cda:ClinicalDocument">
                        
                        <assert test="cda:templateId[@root = '1.2.250.1.213.1.1.1.13']">
                                [IPS-FR_2022.01] Le templateId "1.2.250.1.213.1.1.1.13" doit être
                                présent. </assert>
                        
                        <assert test="cda:code[@code = '60591-5' and @codeSystem = '2.16.840.1.113883.6.1']"> [IPS-FR_2022.01] Le code LOINC du document est "60591-5"
                                (2.16.840.1.113883.6.1). </assert>
                        
                        <assert test="                                         count(cda:participant[@typeCode = 'INF']/cda:functionCode[@code = 'PCP']) = 1                                         and count(cda:participant[@typeCode = 'INF']/cda:functionCode[@displayName = 'Médecin Traitant']) = 1                                         and count(cda:participant[@typeCode = 'INF']/cda:functionCode[@codeSystem = '2.16.840.1.113883.5.88']) = 1"> [IPS-FR_2022.01] Un participant pour le médecin traitant est
                                obligatoire avec @typeCode='INF' et functionCode@code='PCP',
                                functionCode@displayName='Médecin Traitant' et
                                functionCode@codeSystem='2.16.840.1.113883.5.88'. </assert>
                        
                        <assert test="                                         (cda:documentationOf/cda:serviceEvent/cda:code[@code = '34117-2'])                                         and (cda:documentationOf/cda:serviceEvent/cda:code[@displayName = 'Historique et clinique'])                                         and (cda:documentationOf/cda:serviceEvent/cda:code[@codeSystem = '2.16.840.1.113883.6.1'])                                         and (cda:documentationOf/cda:serviceEvent/cda:code[@codeSystemName = 'LOINC'])"> [IPS-FR_2022.01] L'acte documenté doit être
                                documentationOf/serviceEvent/code@code='34117-2',
                                @displayName='Historique et clinique',
                                @codeSystem='2.16.840.1.113883.6.1' et @codeSystemName='LOINC'.
                        </assert>
                </rule>

                <rule context="cda:ClinicalDocument/cda:component/cda:structuredBody">
                        
                        
                        <assert test="cda:component/cda:section/cda:templateId[@root = '1.3.6.1.4.1.19376.1.5.3.1.3.19']"> 
                                [IPS-FR_2022.01] Erreur de conformité : La section FR-Traitements (1.3.6.1.4.1.19376.1.5.3.1.3.19) doit être présente.
                        </assert>
                        
                        
                        <assert test="cda:component/cda:section/cda:templateId[@root = '1.3.6.1.4.1.19376.1.5.3.1.3.13']"> 
                                [IPS-FR_2022.01] Erreur de conformité : La section FR-Allergies-et-intolerances (1.3.6.1.4.1.19376.1.5.3.1.3.13) doit être présente. 
                        </assert>
                        
                        
                        <assert test="cda:component/cda:section/cda:templateId[@root = '1.3.6.1.4.1.19376.1.5.3.1.3.6']"> 
                                [IPS-FR_2022.01] Erreur de conformité : La section FR-Problemes-actifs (1.3.6.1.4.1.19376.1.5.3.1.3.6) doit être présente. 
                        </assert>
                        
                        
                        <assert test="cda:component/cda:section/cda:templateId[@root = '1.3.6.1.4.1.19376.1.5.3.1.3.11']"> 
                                [IPS-FR_2022.01] Erreur de conformité : La section FR-Antecedents-chirurgicaux (1.3.6.1.4.1.19376.1.5.3.1.3.11) doit être présente. 
                        </assert>
                        
                        
                        <assert test="cda:component/cda:section/cda:templateId[@root = '1.3.6.1.4.1.19376.1.5.3.1.1.5.3.5']"> 
                                [IPS-FR_2022.01] Erreur de conformité : La section FR-Dispositifs-medicaux (1.3.6.1.4.1.19376.1.5.3.1.1.5.3.5) doit être présente. 
                        </assert>

                </rule>
                
        </pattern>
</schema>