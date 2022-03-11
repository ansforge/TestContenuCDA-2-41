<?xml version="1.0" encoding="UTF-8"?>

<!--                  
   E_dispositifMedicalPrescrit.sch
    Teste la conformité du contenu des entrées dispositif medical prescrit( 2.16.840.1.113883.10.20.1.34 ) sépcifiées dans le volet eP-MED-DM
    
    Historique :
    01/09/2021 : Création
    
-->


<pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="E_dispositifMedicalPrescrit">
    
    <rule context="*[cda:templateId/@root='1.2.250.1.213.1.1.2.222']/cda:entry/cda:supply[cda:templateId/@root='2.16.840.1.113883.10.20.1.34']">
        
        <!-- [1..1] Entrée FR-En-rapport-avec-ALD -->
        <assert test="count(cda:entryRelationship/cda:observation/cda:templateId[@root='1.2.250.1.213.1.1.3.48.13'])=1">
            [E_dispositifMedicalPrescrit.sch] Erreur de conformité CI-SIS : l'entrée FR-En-rapport-avec-ALD (1.2.250.1.213.1.1.3.48.13) est obligatoire.
        </assert>
        <!--<!-\- [1..1] Entrée FR-En-rapport-avec-accident-travail -\->
        <assert test="count(cda:entryRelationship/cda:observation/cda:templateId[@root='1.2.250.1.213.1.1.3.48.14'])=1">
            [E_dispositifMedicalPrescrit.sch] Erreur de conformité CI-SIS : l'entrée FR-En-rapport-avec-accident-travail (1.2.250.1.213.1.1.3.48.14) est obligatoire.
        </assert>
        <!-\- [1..1] Entrée FR-Non-remboursable -\->
        <assert test="count(cda:entryRelationship/cda:observation/cda:templateId[@root='1.2.250.1.213.1.1.3.48.15'])=1">
            [E_dispositifMedicalPrescrit.sch] Erreur de conformité CI-SIS : l'entrée FR-Non-remboursable (1.2.250.1.213.1.1.3.48.15) est obligatoire.
        </assert>
        <!-\- [1..1] Entrée FR-En-rapport-avec-la-prevention -\->
        <assert test="count(cda:entryRelationship/cda:observation/cda:templateId[@root='1.2.250.1.213.1.1.3.48.224'])=1">
            [E_dispositifMedicalPrescrit.sch] Erreur de conformité CI-SIS : l'entrée FR-En-rapport-avec-la-prevention (1.2.250.1.213.1.1.3.48.224) est obligatoire.
        </assert>-->
    </rule>
    
    
    
</pattern>