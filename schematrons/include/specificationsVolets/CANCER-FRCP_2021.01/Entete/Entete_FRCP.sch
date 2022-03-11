<?xml version="1.0" encoding="UTF-8"?>

<!--                  
    Entete_FRCP.sch
    Teste la conformité de l'entete de la FRCP au CI-SIS
    
    Auteur : ANS
    
    Historique :
    30/01/2018 : Création
    29/07/2020 : Ne pas contrôler le nom du participant pour le médecin traitant (participant typeCode ='INF' et fonctionCode code="PCP")
    21/04/2021 : Modification des contrôles effectués
-->

<pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="Entete_FRCP">   
        
    <!-- l'élément documentationOf/serviceEvent/code est obligatoire  --> 
    <rule context="cda:ClinicalDocument/cda:documentationOf">
        <assert test="cda:serviceEvent/cda:code">
            [Entete_FRCP] Le code de l'élément documentationOf est obligatoire.            
        </assert>
    </rule>
    <rule context="cda:ClinicalDocument/cda:componentOf">
        <assert test="count(cda:encompassingEncounter/cda:id)>2">
            [Entete_FRCP] L'élément componentOf doit au minimum comporter les identiants du RRC, du gestionnaire et de la RCP.          
        </assert>        
        <assert test="cda:encompassingEncounter/cda:location/cda:healthCareFacility/cda:location/cda:name">
            [Entete_FRCP] Le nom de l'établissement est obligatoire.         
        </assert>        
        <assert test="cda:encompassingEncounter/cda:location/cda:healthCareFacility/cda:location/cda:addr">
            [Entete_FRCP] L'adresse de l'établissement est obligatoire.         
        </assert>
    </rule>
</pattern>