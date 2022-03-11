<?xml version="1.0" encoding="UTF-8"?>

<!-- Entete_EP-MED-DM.sch    
     ......................................................................................................................................................
     Vérification de la conformité de l'entête au modèle du document eP-MED-DM du CI-SIS.
     ......................................................................................................................................................
     Historique :
        - 05/06/2020 : Création
        - 30/11/2020 : Mise à jour
-->

<pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="Entete_EP-MED-DM">
  
    <rule context="cda:ClinicalDocument">
        <assert test="./cda:templateId[@root='1.2.250.1.213.1.1.1.39']"> 
            [Entete_EP-MED-DM] Le templateId "1.2.250.1.213.1.1.1.39" doit être présent.
        </assert>
        <assert test="./cda:code[@code='57833-6' and @codeSystem='2.16.840.1.113883.6.1']"> 
            [Entete_EP-MED-DM] L'élément "code" doit avoir les attributs @code="57833-6" et @codeSystem="2.16.840.1.113883.6.1"/>. 
        </assert>
        
    </rule>
    
</pattern>