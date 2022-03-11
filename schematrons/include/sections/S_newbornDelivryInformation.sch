<?xml version="1.0" encoding="UTF-8"?>

<!--                  -=<<o#%@O[ S_newbornDelivryInformation.sch ]O@%#o>>=-
    
    Teste la conformité de la section "Newborn Delivry Information Section" (1.3.6.1.4.1.19376.1.5.3.1.1.21.2.4) aux spécifications d'IHE PCC v3.0
    
    Historique :
    14/01/2020 : NMA : Création
    30/01/2020 : NMA : Suppression du test sur le nombre de templateId
    
-->

<pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="S_newbornDelivryInformation">
    
    <title>Newborn Delivry Information Section</title>

    <rule context='*[cda:templateId/@root = "1.3.6.1.4.1.19376.1.5.3.1.1.21.2.4"]'>

        <!-- Verifier que le templateId est utilisé correctement -->
        <assert test="../cda:section">
            [S_newbornDelivryInformation] Erreur de conformité PCC : 'Newborn Delivry Information Section' ne peut être utilisé que comme section
        </assert>
        
        <!-- Vérifier le code de la section -->
        <assert test='cda:code[@code = "57075-4"]'>
            [S_newbornDelivryInformation.sch] Erreur de Conformité PCC : Le code de la section Travail et accouchement doit être 57075-4
        </assert>
        
        <assert test='cda:code[@codeSystem = "2.16.840.1.113883.6.1"]'>
            [S_newbornDelivryInformation.sch] Erreur de conformité PCC : L'élément 'codeSystem' de la section 'Travail et accouchement' doit
            être codé dans la nomenclature LOINC (2.16.840.1.113883.6.1)
        </assert>
     
        <assert test='cda:component/cda:section/cda:templateId[@root = "1.3.6.1.4.1.19376.1.5.3.1.1.9.15.1"]'>
            [S_newbornDelivryInformation.sch] Erreur de conformité PCC : Cette section comporte obligatoirement une sous-section de type Examen physique codé (1.3.6.1.4.1.19376.1.5.3.1.1.9.15.1)
        </assert>
        
    </rule>

</pattern>
