<?xml version="1.0" encoding="UTF-8"?>

<!-- Entete_EP-MED.sch    
     ......................................................................................................................................................
     Vérification de la conformité de l'entête au modèle du document eP-MED du CI-SIS.
     ......................................................................................................................................................
     Historique :
        - 05/06/2020 : Création
        - 30/11/2020 : Mise à jour
-->

<pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="Entete_EP-MED_2021.01">
    
    <rule context="cda:ClinicalDocument">
        <!-- Conformité spécifications HL7 France -->
        <assert test="cda:templateId[@root='2.16.840.1.113883.2.8.2.1']"> 
            [EP-MED_2021.01] Erreur de conformité : Le templateId "2.16.840.1.113883.2.8.2.1" est obligatoire.
        </assert>
        <!-- Conformité spécifications au CI-SIS -->
        <assert test="cda:templateId[@root='1.2.250.1.213.1.1.1.1']"> 
            [EP-MED_2021.01] Erreur de conformité : Le templateId "1.2.250.1.213.1.1.1.1" est obligatoire.
        </assert>
        <!-- Conformité au Volet IHE Pharm suppl. PRE -->
        <assert test="cda:templateId[@root='1.3.6.1.4.1.19376.1.9.1.1.1']"> 
            [EP-MED_2021.01] Erreur de conformité : Le templateId "1.3.6.1.4.1.19376.1.9.1.1.1" est obligatoire.
        </assert>
        <!-- Conformité au volet IHE PCC -->
        <assert test="cda:templateId[@root='1.3.6.1.4.1.19376.1.5.3.1.1.1']"> 
            [EP-MED_2021.01] Erreur de conformité : Le templateId "1.3.6.1.4.1.19376.1.5.3.1.1.1" est obligatoire.
        </assert>
        <!-- Conformité au modèle de document eP-MED v2020.01 -->
        <assert test="cda:templateId[@root='1.2.250.1.213.1.1.1.39']"> 
            [EP-MED_2021.01] Erreur de conformité : Le templateId "1.2.250.1.213.1.1.1.27" est obligatoire.
        </assert>            
        
        <assert test="./cda:code[@code='57833-6' and @codeSystem='2.16.840.1.113883.6.1']"> 
            [EP-MED_2021.01] Erreur de conformité : L'élément "code" doit avoir les attributs @code="57833-6" et @codeSystem="2.16.840.1.113883.6.1"/>. 
        </assert>
        
    </rule>
    
</pattern>