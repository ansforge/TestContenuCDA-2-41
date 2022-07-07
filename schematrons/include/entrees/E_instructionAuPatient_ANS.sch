<?xml version="1.0" encoding="UTF-8"?>

<!--             
    
    E_instructionAuPatient_ANS.sch :
    Contenu :
       Contrôle la conformité des éléments FR-Instruction-au-patient conformément au volet Modèles de contenu CDA.
    Paramètres d'appel :
        Néant
    Historique :
    29/06/2022 : Création  
    
-->

<pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="E_instructionAuPatient_ANS">
    <title>FR-Instruction-au-patient</title>
    <rule context="*[cda:templateId/@root='1.2.250.1.213.1.1.3.48.35']">
        
        <assert test="cda:templateId/@root='1.3.6.1.4.1.19376.1.5.3.1.4.13'">
            [E_instructionAuPatient.sch] Erreur de conformité CI-SIS : Le templateId parent FR-SimpleObservation "1.3.6.1.4.1.19376.1.5.3.1.4.13" est obligatoire
        </assert>
        <assert test="cda:code/@code='PINSTRUCT' and cda:code/@codeSystem='1.3.6.1.4.1.19376.1.5.3.2'">
            [E_instructionAuPatient.sch] Erreur de conformité CI-SIS : Les attributs de l'élément code prennent les valeurs suivantes :
            
            code=’PINSTRUCT’
            codeSystem=’1.3.6.1.4.1.19376.1.5.3.2’
            codeSystemName=’IHEActCode’
        </assert>
        
    </rule>
    
</pattern>

