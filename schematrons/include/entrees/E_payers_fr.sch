<?xml version="1.0" encoding="UTF-8"?>

<!--                  -=<<o#%@O[ E_payers_fr.sch ]O@%#o>>=-
    
    Teste la conformité de l'entrée FR-Couverture-sociale (1.3.6.1.4.1.19376.1.5.3.1.4.17) aux spécifications françaises. 

    Historique :
    01/06/2021 : Création
-->

<pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="E_payers_fr">
    <title>CI-SIS Entrée FR-Couverture-sociale</title>
    
    <rule context="*[cda:templateId/@root='1.3.6.1.4.1.19376.1.5.3.1.4.17']">
        
        <assert test='count(cda:id)=1'>
            [E_payers_fr] Erreur de Conformité CI-SIS : 
            Une entrée 'FR-Couverture-sociale' ne peut avoir qu'un seul identifiant (id).
        </assert>
        
        <assert test='count(cda:statusCode)=1'>
            [E_payers_fr] Erreur de Conformité CI-SIS :
            Une entrée 'FR-Couverture-sociale' doit comporter un (et un seul) élément statusCode.
        </assert>
        
        <assert test="count(cda:code)=1">
            [E_payers_fr] Erreur de Conformité CI-SIS :
            Une entrée 'FR-Couverture-sociale' doit comporter un (et un seul) élément 'code'.
        </assert>
        <assert test="cda:code/@code='48768-6'">
            [E_payers_fr] Erreur de Conformité CI-SIS :
            Une entrée 'FR-Couverture-sociale' doit comporter le code 48768-6.
        </assert>
        
        <assert test="count(cda:entryRelationship/cda:act[cda:templateId/@root='1.3.6.1.4.1.19376.1.5.3.1.4.18'])&gt;=1">
            [E_payers_fr] Erreur de Conformité CI-SIS :
            Une entrée 'FR-Couverture-sociale' doit comporter minimum une entryRelationship FR-Organisme-assurance-maladie [1..*].
        </assert>
    </rule>
    
</pattern>
