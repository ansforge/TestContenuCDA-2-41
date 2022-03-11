<?xml version="1.0" encoding="UTF-8"?>

<!-- S_laborAndDelivery_ANS.sch
    
     Vérification de la conformité de la section FR-Travail-et-accouchement-non-code (1.2.250.1.213.1.1.2.13) créée par l'ANS
    
    Au 17/08/2017, cette section est utilisée par les volets OBS_SNE, CSE_CS8
    
    Historique :
    17/08/2017 : LBE : Création
    14/01/2020 : NMA : Supprimer le test que cette entrée hérite de Labor and Delivry d'IHE car c'est une section narrative et celle d'IHE est codée
    30/01/2020 : NMA : Suppression du test sur le nombre de templateId
    
-->

<pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="S_laborAndDelivery_ANS">
    
    <title>Vérification de la conformité de la section FR-Travail-et-accouchement-non-code (1.2.250.1.213.1.1.2.13) créée par l'ANS</title>

    <rule context='*[cda:templateId/@root = "1.2.250.1.213.1.1.2.13"]'>
        
        <!-- Verifier que le templateId est utilisé pour une section -->
        <assert test="../cda:section"> 
            [S_laborAndDelivery_ANS.sch] Erreur de conformité CI-SIS : Cet élément ne peut être utilisé que comme section.
        </assert>
        
        <assert test="count(cda:id)=1">
            [S_laborAndDelivery_ANS.sch] Erreur de conformité CI-SIS : La section doit contenir un élément 'id' unique.
        </assert>
        
        <assert test="cda:text">
            [S_laborAndDelivery_ANS.sch] Erreur de conformité CI-SIS : La section doit contenir un élément 'text'.
        </assert> 
        
        <!-- Vérifier le code de la section -->
        <assert test='cda:code[@code = "57074-7"]'>
            [S_laborAndDelivery_ANS.sch] Erreur de conformité CI-SIS : Le code de cette section doit être '57074-7'.
        </assert>
        
        <assert test='cda:code[@codeSystem = "2.16.840.1.113883.6.1"]'>
            [S_laborAndDelivery_ANS.sch] Erreur de conformité CI-SIS : L'élément 'codeSystem' doit être codé à partir de la nomenclature LOINC (2.16.840.1.113883.6.1).
        </assert>

    </rule>

</pattern>
