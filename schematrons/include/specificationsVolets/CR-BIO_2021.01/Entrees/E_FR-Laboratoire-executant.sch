<?xml version="1.0" encoding="UTF-8"?>
<!-- 
    E_FR-Laboratoire-executant.sch :
    
    Vérification de la conformité d'une entrée FR-Laboratoire-executant (1.3.6.1.4.1.19376.1.3.3.1.7)
    
    Historique :
    13/01/2021 : Création
        
-->
<pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="E_FR-Laboratoire-executant">
    <p>Vérification de la conformité d'une entrée FR-Laboratoire-executant (1.3.6.1.4.1.19376.1.3.3.1.7)</p>
    <rule context="*[cda:templateId/@root = '1.3.6.1.4.1.19376.1.3.3.1.7']">
        
        <assert test="self::cda:performer">
            [E_FR-Laboratoire-executant] Erreur de conformité :
            Un exécutant dans une entrée FR-Laboratoire-executant (1.3.6.1.4.1.19376.1.3.3.1.7) doit être un performer. 
        </assert>      
        
        <assert test="cda:assignedEntity/cda:representedOrganization/cda:id and
                    cda:assignedEntity/cda:representedOrganization/cda:name"> 
            [E_FR-Laboratoire-executant] Erreur de conformité :
            Dans une entrée FR-Laboratoire-executant (1.3.6.1.4.1.19376.1.3.3.1.7), les éléments assignedEntity/representedOrganization/id
            et assignedEntity/representedOrganization/name sont obligatoires. 
        </assert>
        
        <assert test="cda:time"> 
            [E_FR-Laboratoire-executant] Erreur de conformité :
            Dans une entrée FR-Laboratoire-executant (1.3.6.1.4.1.19376.1.3.3.1.7), l'élément time est obligatoire.
        </assert>
        
    </rule>
</pattern>
