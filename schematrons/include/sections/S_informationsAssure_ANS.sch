<?xml version="1.0" encoding="UTF-8"?>

<!--  S_informationAssure_ANS.sch
    
     Vérification de la conformité de la section FR-Informations-assure (1.2.250.1.213.1.1.2.38) créée par l'ANS
    
    Au 17/08/2017, cette section est utilisée par le volet CR-RTN
    
    Historique :
    17/08/2017 : Création
    20/10/2017 : Suppression du test sur la nomenclature utilisée pour coder la section
    30/01/2020 : Suppression du test sur le nombre de templateId
    10/09/2021 : Correction du code LOINC 35525-5 (au lieu de 35525-4)
    
-->


<pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="S_informationAssure_ANS">
    
    <title>Vérification de la conformité de la section FR-Informations-assure (1.2.250.1.213.1.1.2.38) créée par l'ANS</title>
    
    <rule context='*[cda:templateId/@root = "1.2.250.1.213.1.1.2.38"]'>
        
        <!-- Verifier que le templateId est utilisé pour une section -->
        <assert test="../cda:section"> 
            [S_InformationAssure_ANS.sch] Erreur de conformité CI-SIS : Cet élément ne peut être utilisé que comme section.
        </assert>
        
        <assert test="count(cda:id)=1">
            [S_InformationAssure_ANS.sch] Erreur de conformité CI-SIS : La section doit contenir un élément 'id'.
        </assert>
        
        <assert test="cda:text">
            [S_InformationAssure_ANS.sch] Erreur de conformité CI-SIS : La section doit contenir un élément 'text'
        </assert>        
        
        <!-- Vérifier le code de la section -->
        <assert test='cda:code[@code = "35525-5"]'>
            [S_InformationAssure_ANS.sch] Erreur de conformité CI-SIS : Le 'code' de la section doit être '35525-5'.
        </assert>

        <!-- Vérification des entrées optionnelles -->
        <assert test="not(cda:entry) or cda:entry/cda:organizer/cda:templateId/@root='1.2.250.1.213.1.1.3.18'">
            [S_InformationAssure_ANS.sch] Erreur de conformité CI-SIS : Les entrées optionnelles autorisées sont FR-Document-attache (1.2.250.1.213.1.1.3.18).    
        </assert>

    </rule>

</pattern>
