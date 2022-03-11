<?xml version="1.0" encoding="UTF-8"?>

<!--                  -=<<o#%@O[ E_problemConcernEntry_fr.sch ]O@%#o>>=-
    
    Teste la conformité de l'élément "Problem Concern Entry" (1.3.6.1.4.1.19376.1.5.3.1.4.5.2)
    aux spécifications CI-SIS
    
    Historique :
   26/06/17 : NMA : Création
   26/07/17 : NMA : Suppression du test sur les relationships
    
-->

<pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="E_problemConcernEntry_fr">
    <title>CI-SIS Problem Concern Entry</title>
    <rule context="*[cda:templateId/@root=&quot;1.3.6.1.4.1.19376.1.5.3.1.4.5.2&quot;]">
       
        
        <assert test='cda:code[@nullFlavor="NA"]'>
            [E_problemConcernEntry_fr] Ereur CI-SIS: L’élément code prend la valeur nullFlavor='NA' car l'identification du problème est faite à partir des éléments entryRelationship.</assert>
        
    </rule>
</pattern>