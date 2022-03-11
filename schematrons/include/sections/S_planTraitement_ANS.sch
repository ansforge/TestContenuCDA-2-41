<?xml version="1.0" encoding="UTF-8"?>

<!--  S_planTraitement_ANS.sch
    
     Vérification de la conformité de la section FR-Plan-de-traitement (1.2.250.1.213.1.1.2.32) créée par l'ANS
    
    Historique :
    17/08/2017 : LBE : Création
    30/01/2020 : NMA : Suppression du test sur le nombre de templateId
    27/08/2020 : ANS : Modification du message d'erreur sur absence de l'élément text si présence d'une sous-section Traitements
-->

<pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="S_planTraitement_ANS">
    
    <title>Vérification de la conformité de la section FR-Plan-de-traitement (1.2.250.1.213.1.1.2.32) créée par l'ANS</title>
    
    <rule context='*[cda:templateId/@root = "1.2.250.1.213.1.1.2.32"]'>
        
        <assert test="../cda:section"> 
            [S_planTraitement_ANS.sch] Erreur de conformité CI-SIS : Cet élément ne peut être utilisé que comme section.
        </assert>
        
        <assert test="count(cda:id)=1">
            [S_planTraitement_ANS.sch] Erreur de conformité CI-SIS : La section doit contenir un élément 'id' unique.
        </assert>
        
        <!-- Vérifier le code de la section -->
        <assert test='cda:code[@code = "18776-5"]'>
            [S_planTraitement_ANS.sch] Erreur de conformité CI-SIS :: Le code de la section doit être '18776-5'
        </assert>
        
        <assert test='cda:code[@codeSystem = "2.16.840.1.113883.6.1"]'>
            [S_planTraitement_ANS.sch] Erreur de conformité CI-SIS : L'élément 'codeSystem' doit être codé à partir de la nomenclature LOINC (2.16.840.1.113883.6.1).
        </assert>
        
        <assert test="not(cda:component/cda:section) or cda:component/cda:section/cda:templateId/@root='1.3.6.1.4.1.19376.1.5.3.1.3.19'">
            [S_planTraitement_ANS.sch] Erreur de conformité CI-SIS : La sous-section optionnelle est la section Traitements (Medications - 1.3.6.1.4.1.19376.1.5.3.1.3.19).         
        </assert>
        
        <assert test="(not(cda:component/cda:section) and cda:text) or (cda:component/cda:section and not(cda:text))">
            [S_planTraitement_ANS.sch] Erreur de conformité CI-SIS : 
            La section doit contenir un élément 'text' s’il n’y a pas de sous-section Traitements (1.3.6.1.4.1.19376.1.5.3.1.3.19).
            La section ne doit pas contenir d’élément 'text' s’il y a une sous-section Traitements (1.3.6.1.4.1.19376.1.5.3.1.3.19)
        </assert>

    </rule>

</pattern>
