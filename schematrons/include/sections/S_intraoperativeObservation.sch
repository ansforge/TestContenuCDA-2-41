<?xml version="1.0" encoding="UTF-8"?>

<!--                  -=<<o#%@O[ intraoperativeObservation.sch ]O@%#o>>=-
    
    Teste la conformité de la section "Intraoperative Observation Section" (1.3.6.1.4.1.19376.1.8.1.2.2)
    aux spécifications d'IHE PaLM Suppl.APSR 2.0 (Rev 2.1 – 2018-09-28)
    
    Historique :
    21/12/2018 : NNA : Création
    30/01/2020 : NMA : Suppression du test sur le nombre de templateId
   
    
-->

<pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="S_intraoperativeObservation">

    <title>IHE Palm_Suppl_APSR V2.0 Intraoperative Observation Section</title>

    <rule context="*[cda:templateId/@root='1.3.6.1.4.1.19376.1.8.1.2.2']">
        
        <!-- Verifier que le templateId est utilisé pour une section -->
        <assert test="../cda:section"> 
            [S_intraoperativeObservation.sch] Erreur de Conformité APSR : Cet élément ne peut être utilisé que comme section.
        </assert>
        
                
        <!--Vérifier que les éléments text et title sont utilisés -->
        <assert test="cda:text">
            [S_intraoperativeObservation.sch] Erreur de conformité APSR : La section "Intraoperative Observation" doit contenir un élément text"
        </assert>
        
        <assert test="cda:title">
            [S_intraoperativeObservation.sch] Erreur de conformité APSR : La section "Intraoperative Observation" doit contenir un élément title"
        </assert>
                
    </rule>
    
</pattern>
