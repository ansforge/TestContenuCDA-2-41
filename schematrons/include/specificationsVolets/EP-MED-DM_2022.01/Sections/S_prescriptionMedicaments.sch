<?xml version="1.0" encoding="UTF-8"?>

<!-- S_prescriptions_fr
     ......................................................................................................................................................
     Vérification de la conformité de la section "FR-Prescription-medicaments"
     ......................................................................................................................................................
     Historique :
        - 01/09/2021 : creation
-->

<pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="S_prescriptionMedicaments">
    <title>CI-SIS section "FR-Prescription-medicaments"</title>
    
    
    <rule context="*[cda:templateId/@root='1.3.6.1.4.1.19376.1.9.1.2.1']">
        
        <assert test="cda:templateId[@root='1.2.250.1.213.1.1.2.171']">
            [1] [S_prescriptions_fr.sch] Erreur de conformité CI-SIS : 
            La section "FR-Prescription-medicaments" doit avoir un templateId dont l'attribut @root="1.2.250.1.213.1.1.2.171" (Conformité de la section au format CI-SIS)
        </assert>
        
        <!-- Conformité au format CI-SIS de l'entrée "FR-Traitement-prescrit" -->
        <assert test="cda:entry/cda:substanceAdministration/cda:templateId[@root='1.2.250.1.213.1.1.3.83']">
            [2] [S_prescriptions_fr.sch] Erreur de conformité CI-SIS :
            La section "FR-Prescription-medicaments" ne peut contenir que des entrées de type "FR-Traitement-prescrit" (cardinalité [1..*]),
            dont le templateId' doit être @root="1.2.250.1.213.1.1.3.83" (conformité de l'entrée au format CI-SIS).
        </assert>
    </rule>
</pattern>
