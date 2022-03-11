<?xml version="1.0" encoding="UTF-8"?>

<!--                  -=<<o#%@O[ childFunctionalStatusEatingSleeping.sch ]O@%#o>>=-
    
    Teste la conformité de la section "Eating and sleeping Assessment" (1.3.6.1.4.1.19376.1.7.3.1.1.13.5)
    aux spécifications d'IHE PCC v3.0
       
    Historique :
    24/06/11 : CRI : Création
    14/11/16 : NMA : Modification du code dans le message d'erreur
    29/06/2017 : LBE : Ajout de la vérification de présence de l'entrée simple observation et de la balise text + conventions de nommage 
    30/01/2020 : NMA : Suppression du test sur le nombre de templateId
-->


<pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="S_childFunctionalStatusEatingSleeping">
    <title>IHE PCC v3.0 Eating and sleeping Assessment</title>
    <rule context='*[cda:templateId/@root="1.3.6.1.4.1.19376.1.7.3.1.1.13.5"]'> 

        
        <!-- Verifier que le templateId est utilisé pour une section -->        
        <assert test='../cda:section'> 
            [S_childFonctionalStatusEatingSleeping.sch] Erreur de conformité PCC : 'Eating and sleeping Assessment' ne peut être utilisé que comme section.
        </assert>
        
        <!-- Vérifier le code de la section --> 
        <assert test='cda:code[@code = "47420-5"]'> 
            [S_childFonctionalStatusEatingSleeping.sch] Erreur de conformité PCC : Le code de la section 'Eating and sleeping Assessment' doit être '47420-5'
        </assert> 
        
        <assert test='cda:code[@codeSystem = "2.16.840.1.113883.6.1"]'> 
            [S_childFonctionalStatusEatingSleeping.sch] Erreur de conformité PCC : L'élément 'codeSystem' de la section 'Eating and sleeping Assessment' doit être codé dans la nomenclature LOINC 
            (2.16.840.1.113883.6.1). 
        </assert> 
        
        <assert test="cda:text">
            [S_childFonctionalStatusEatingSleeping.sch] Erreur de conformité PCC : L'élément child fonctional status eating sleeping doit contenir un élément text
        </assert>
        
        <assert test="cda:entry/cda:observation/cda:templateId[@root='1.3.6.1.4.1.19376.1.5.3.1.4.13']">
            [S_childFonctionalStatusEatingSleeping.sch] Erreur de conformité PCC : L'élément child fonctional status eating sleeping doit contenir une entrée simpleObservation
        </assert>
    </rule>
</pattern>
