<?xml version="1.0" encoding="UTF-8"?>


<!-- S_historiqueExamensBiologiques_ANS.sch
    
     Vérification de la conformité de la section FR-Historique-des-examens-biologiques (1.2.250.1.213.1.1.2.28) créée par l'ANS
    
    Au 17/08/2017, cette section est utilisée par le volet CVAC
    
    Historique :
    17/08/2017 : LBE : Création
    30/01/2020 : NMA : Suppression du test sur le nombre de templateId
    
-->

<pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="S_historiqueExamensBiologiques_ANS">
    
    <title>Vérification de la conformité de la section FR-Historique-des-examens-biologiques (1.2.250.1.213.1.1.2.28) créée par l'ANS</title>
    
    <rule context='*[cda:templateId/@root = "1.2.250.1.213.1.1.2.28"]'>
        
        <!-- Verifier que le templateId est utilisé pour une section -->
        <assert test="../cda:section"> 
            [S_historiqueExamensBiologiques_ANS.sch] Erreur de conformité CI-SIS : Cet élément ne peut être utilisé que comme section.
        </assert>
        
        <assert test="count(cda:id)=1">
            [S_historiqueExamensBiologiques_ANS.sch] Erreur de conformité CI-SIS : La section doit contenir un élément 'id' unique.
        </assert>
        
        <assert test="cda:text">
            [S_historiqueExamensBiologiques_ANS.sch] Erreur de conformité CI-SIS : La section doit contenir un élément 'text'.
        </assert>
        
        <!-- Vérifier le code de la section -->
        <assert test='cda:code[@code = "26436-6"]'>
            [S_historiqueExamensBiologiques_ANS.sch] Erreur de conformité CI-SIS : Le 'code' de cette section doit être '57074-7'.
        </assert>
        
        <assert test='cda:code[@codeSystem = "2.16.840.1.113883.6.1"]'>
            [S_historiqueExamensBiologiques_ANS.sch] Erreur de conformité CI-SIS : L'élément 'codeSystem' doit être codé à partir de la nomenclature LOINC (2.16.840.1.113883.6.1).
        </assert>
        
        <!-- Vérification des sous-sections optionnelles -->
        <assert test="not(cda:component/cda:section) or cda:component/cda:section/cda:templateId/@root='1.3.6.1.4.1.19376.1.7.3.1.1.13.7'">
            [S_historiqueExamensBiologiques_ANS.sch] Erreur de conformité CI-SIS : Cette section peut contenir une sous-section FR-Resultats-evenements (1.3.6.1.4.1.19376.1.7.3.1.1.13.7).
        </assert>

    </rule>

</pattern>
