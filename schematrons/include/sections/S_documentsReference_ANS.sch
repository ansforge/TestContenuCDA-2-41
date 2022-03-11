<?xml version="1.0" encoding="UTF-8"?>

<!--  S_documentsReferences_ANS.sch
    
     Vérification de la conformité de la section FR-Documents-references (1.2.250.1.213.1.1.2.55) créée par l'ANS
        
    Historique :
    31/01/2017 : Création
    04/07/2017 : Ajout de la contrainte sur le nombre des templateIds et renommage du schématron
    08/08/2017 : Ajout des contraintes sur les id et le text
    02/10/2019 : Modification du code de la section (remplacement de 'LP72255-0' par '55107-7')
    30/01/2020 : NMA : Suppression du test sur le nombre de templateId
    
-->

<pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="S_documentsReferences_ANS">
    <title>Vérification de la conformité de la section FR-Documents-references (1.2.250.1.213.1.1.2.55) créée par l'ANS</title>
    
    <rule context='*[cda:templateId/@root = "1.2.250.1.213.1.1.2.55"]'>
        
        <!-- Verifier que le templateId est utilisé pour une section -->
        <assert test="../cda:section"> 
            [S_documentsReferences_ANS.sch] Erreur de conformité CI-SIS : Cet élément ne peut être utilisé que comme section.
        </assert>
        
        <assert test="count(cda:id)=1">
            [S_citationDocuments_ANS.sch] Erreur de conformité CI-SIS : La section Références externes doit contenir un et un seul élément id.
        </assert>
        
        <assert test="cda:text">
            [S_citationDocuments_ANS.sch] Erreur de conformité CI-SIS : La section Références externes doit contenir un élément text.
        </assert>
        
        <assert test='cda:code[@code = "55107-7"]'>
            [S_documentsReferences_ANS.sch] Erreur de conformité CI-SIS : Le code de cette section doit être '55107-7'
        </assert>

        <assert test='cda:code[@codeSystem = "2.16.840.1.113883.6.1"]'> 
            [S_documentsReferences_ANS.sch] Erreur de conformité CI-SIS : Le code de la section doit être un code LOINC  
            system (2.16.840.1.113883.6.1). 
        </assert> 
        
        <assert test='//cda:templateId[@root = "1.3.6.1.4.1.19376.1.5.3.1.4.4"]'> 
            [S_documentsReferences_ANS.sch] Erreur de conformité CI-SIS : L'entrée FR-References-externes (1.3.6.1.4.1.19376.1.5.3.1.4.4) est obligatoirement présente dans cette section.
        </assert> 
        
    </rule>

</pattern>
