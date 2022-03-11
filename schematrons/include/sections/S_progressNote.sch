<!--  IHE PCC Progress Note Section: 1.3.6.1.4.1.19376.1.5.3.1.1.13.2.7 

    03/07/17 : NMA : Ajout de la contrainte sur le nombre des templateIds et renommage du schématron
    10/10/17 : NMA : Suppression du test sur le nombre de templateIds
-->

<pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="S_progressNote">
    
    <title>IHE PCC Progress Note Section</title>
    
    <rule context='*[cda:templateId/@root="1.3.6.1.4.1.19376.1.5.3.1.1.13.2.7"]'>
        
        <!-- Verifier que le templateId est utilisé pour une section -->
        <assert test='../cda:section'> 
            [S_progressNote] Erreur de conformité PCC: Ce template ne peut être utilisé que pour une section. 
        </assert>
        
        <!-- Vérifier le code de la section --> 
        <assert test='cda:code[@code = "18733-6"]'> 
            [S_progressNote] Erreur de conformité PCC: Le code de la section 'Progress Note' doit être 18733-6
        </assert> 
        
        <assert test='cda:code[@codeSystem = "2.16.840.1.113883.6.1"]'> 
            [S_progressNote] Erreur de conformité PCC: L'élément 'codeSystem' de la section 'Results' 
            doit être codé à partir de la nomenclature LOINC 
            (2.16.840.1.113883.6.1). 
        </assert>
        
        <assert test='cda:title'>
            [S_progressNote] Erreur de conformité PCC: Cette section doit avoir un titre significatif de son contenu.
        </assert>
        
        <assert test='cda:id'>
            [S_progressNote] Erreur de conformité PCC: Les sections doivent avoir un identifiant unique permettant de les identifier.
        </assert>
        
    </rule>
    
</pattern>