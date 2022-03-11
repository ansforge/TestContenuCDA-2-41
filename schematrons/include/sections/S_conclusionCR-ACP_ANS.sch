<?xml version="1.0" encoding="UTF-8"?>


<!--  S_conclusionCR-ACP_ANS.sch
    
    Vérification de la conformité de la section FR-Conclusion-du-CR-ACP (1.2.250.1.213.1.1.2.34) créée par l'ANS
    
    Au 17/08/2017, cette section est utilisée par les volets FRCP, OBS_SNM
    
    Historique :
    17/08/2017 : ANS : Création
    30/01/2020 : ANS : Suppression du test sur le nombre de templateId
    24/07/2020 : ANS : Modification des sous-sections contrôlées
-->

<pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="S_conclusionCR-ACP_ANS">
    <title>Vérification de la conformité de la section FR-Conclusion-du-CR-ACP (1.2.250.1.213.1.1.2.34) créée par l'ANS</title>
    
    <rule context='*[cda:templateId/@root = "1.2.250.1.213.1.1.2.34"]'>

        <assert test="count(cda:id)=1">
            [S_conclusionCR-ACP_ANS.sch] Erreur de conformité CI-SIS : La section doit contenir un id (cardinalité [1..1])
        </assert>
        
        <assert test="cda:text">
            [S_conclusionCR-ACP_ANS.sch] Erreur de conformité CI-SIS : La section doit contenir un élément text
        </assert>
        
        <!-- Verifier que le templateId est utilisé pour une section -->
        <assert test="../cda:section"> 
            [S_conclusionCR-ACP_ANS.sch] Erreur de conformité CI-SIS : Cet élément ne peut être utilisé que comme section.
        </assert>
        
        <!-- Vérifier le code de la section -->
        <assert test='cda:code[@code = "30954-2"]'>
            [S_conclusionCR-ACP_ANS.sch] Erreur de conformité CI-SIS : Le code de la section doit être 30954-2
        </assert>
        
        <assert test='cda:code[@codeSystem = "2.16.840.1.113883.6.1"]'>
            [S_conclusionCR-ACP_ANS.sch] Erreur de conformité CI-SIS : Le code de la section doit être codé à partir de la nomenclature LOINC (2.16.840.1.113883.6.1).
        </assert>
        
        <!-- Vérification des sous-sections optionnelles -->
        <assert test="not(cda:component/cda:section) 
            or cda:component/cda:section/cda:templateId/@root='1.3.6.1.4.1.19376.1.5.3.1.4.13' 
            or cda:component/cda:section/cda:templateId/@root='1.3.6.1.4.1.19376.1.8.1.2.6'
            or cda:component/cda:section/cda:templateId/@root='1.3.6.1.4.1.19376.1.8.1.2.5'
            or cda:component/cda:section/cda:templateId/@root='1.3.6.1.4.1.19376.1.4.1.2.16'">
            [S_conclusionCR-ACP_ANS.sch] Erreur de conformité CI-SIS : Les sous sections optionelles autorisées sont : 
            FR-Simple-Observation (1.3.6.1.4.1.19376.1.5.3.1.4.13)
            FR-Prelevements (1.3.6.1.4.1.19376.1.8.1.2.6)  
            FR-Conclusion-diagnostic (1.3.6.1.4.1.19376.1.8.1.2.5)            
            FR-Commentaire-non-code (1.3.6.1.4.1.19376.1.4.1.2.16)                      
        </assert>

    </rule>

</pattern>
