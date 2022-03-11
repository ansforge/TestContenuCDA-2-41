<?xml version="1.0" encoding="UTF-8"?>

<!-- E_traitementPrescritSubordonnee_fr
     ......................................................................................................................................................
     Vérification de la conformité de l'entrée FR-Traitement-prescrit-subordonnee au spécifications du CI-SIS.
     ......................................................................................................................................................
     Historique :
     - 09/06/2020 : Création
     - 30/11/2020 : Finalisation
-->

    <pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="E_traitementPrescritSubordonnee_fr">
        <title>CI-SIS Entrée "FR-Traitement-prescrit-subordonnee"</title>
        
        <rule context="//cda:entry/cda:substanceAdministration/cda:entryRelationship[@typeCode='COMP']/cda:substanceAdministration[@classCode='SBADM'][@moodCode='INT'][cda:templateId[@root='1.2.250.1.213.1.1.3.83.1']]">
            <!-- Vérification conformité CI-SIS -->
            <assert test="cda:id">
                [1] [E_traitementPrescritSubordonnee_fr.sch] Erreur de conformité CI-SIS : 
                L'entrée "FR-Traitement-prescrit-subordonnee" doit posséder un élément 'id' (Conformité aux spécifications CI-SIS)
            </assert>    
            <assert test="cda:text">
                [1] [E_traitementPrescritSubordonnee_fr.sch] Erreur de conformité CI-SIS : 
                L'entrée "FR-Traitement-prescrit-subordonnee" doit posséder un élément 'text' (Conformité aux spécifications CI-SIS)
            </assert>    
            <assert test="cda:statusCode">
                [1] [E_traitementPrescritSubordonnee_fr.sch] Erreur de conformité CI-SIS : 
                L'entrée "FR-Traitement-prescrit-subordonnee" doit posséder un élément 'statusCode' (Conformité aux spécifications CI-SIS)
            </assert>    
            <assert test="cda:consumable">
                [1] [E_traitementPrescritSubordonnee_fr.sch] Erreur de conformité CI-SIS : 
                L'entrée "FR-Traitement-prescrit-subordonnee" doit posséder un élément 'consumable' (Conformité aux spécifications CI-SIS)
            </assert>    
        </rule>   
    </pattern>
