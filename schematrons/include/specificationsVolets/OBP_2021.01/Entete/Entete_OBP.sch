<?xml version="1.0" encoding="UTF-8"?>

<!--                  
    Entete_OBP.sch
    Teste la conformité de l'entete du volet OBP au CI-SIS
    
    Historique :
    07/02/2018 :  NMA : Création
    
-->


<pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="Entete_OBP">
    
    <rule context='cda:ClinicalDocument'>
         
        <assert test="cda:participant">
            [Entete_OBP] Le médecin traitant est un élément obligatoire des modèles OBP
        </assert>
        
        <assert test="cda:participant[@typeCode='INF'] or cda:participant[@typeCode='CON']">
            [Entete_OBP] L'attribut typeCode de l'élément participant prend la valeur typeCode='INF' s'il s'agit du médecin traitant et typeCode='CON' s'il s'agit d'un correspondant.
        </assert>
        <assert test="cda:participant/cda:associatedEntity/cda:telecom">
            [Entete_OBP] L'adresse de télécomunication telecom est obligatoire et a une cardinalité [1..*]
        </assert>
        
    </rule>
    <rule context="cda:ClinicalDocument/cda:documentationOf/cda:serviceEvent">
        <assert test="not(../../cda:templateId[@root='1.2.250.1.213.1.1.1.12.1']) or cda:code[@code='57055-6']">
            [Entete_OBP] L'attribut code de documentationOf/serviceEvent/Code est fixé à '57055-6' pour le SAP
        </assert>
        <assert test="not(../../cda:templateId[@root='1.2.250.1.213.1.1.1.12.2']) and not(../../cda:templateId[@root='1.2.250.1.213.1.1.1.12.3'])  or cda:code[@code='57057-2']">
            [Entete_OBP] L'attribut code de documentationOf/serviceEvent/Code est fixé à '57057-2' pour le SNM et le SNE
        </assert>
        
        <assert test="(not(../../cda:templateId[@root='1.2.250.1.213.1.1.1.12.4']) and not(../../cda:templateId[@root='1.2.250.1.213.1.1.1.12.5']) ) or cda:code[@code='63893-2']">
            [Entete_OBP] L'attribut code de documentationOf/serviceEvent/Code est fixé à '63893-2' pour le SCM et le SCE
        </assert>
        
    </rule>
    
    
</pattern>