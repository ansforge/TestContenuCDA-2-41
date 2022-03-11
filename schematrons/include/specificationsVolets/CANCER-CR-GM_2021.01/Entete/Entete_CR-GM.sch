<?xml version="1.0" encoding="UTF-8"?>

<!--                  
    Entete_CR-GM.sch
    Teste la conformité de l'entete du volet CR-GM
    
    Historique :
    08/01/2019 :  Création    
-->

<pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="Entete_CR-GM">    
    
    <rule context='cda:ClinicalDocument/cda:author'>
        <assert test="count(cda:author)&lt;4">
            [Entete_CR-GM] Il doit y avoir au maximum 3 auteurs pour le document CR-GM.
        </assert>
        <assert test="cda:assignedAuthor/cda:id">
            [Entete_CR-GM] L'identifiant de l'auteur du document CR-GM est obligatoirement présente.
        </assert>
        <assert test="cda:assignedAuthor/cda:code">
            [Entete_CR-GM] La Profession/spécialité de l’auteur est obligatoirement présente.         
        </assert>
        <assert test="cda:assignedAuthor/cda:assignedPerson">
            [Entete_CR-GM] Identité de l’auteur (Nom, prénom, prefix, etc..)  est obligatoirement présente.         
        </assert>
    </rule>
           
    <rule context='cda:ClinicalDocument/cda:custodian'>
        <assert test="cda:assignedCustodian/cda:representedCustodianOrganization/cda:name">
            [Entete_CR-GM] La Valeur du nom du Laboratoire est obligatoirement présent.         
        </assert>
    </rule>
    
    <rule context='cda:ClinicalDocument/cda:informationRecipient'>
        <assert test="count(cda:informationRecipient)&lt;3">
            [Entete_CR-GM] Il doit y avoir au maximum 2 destinataires en copie du document CR-GM.
        </assert>
    </rule>        
    
    <rule context='cda:ClinicalDocument/cda:legalAuthenticator'>
        <assert test="cda:assignedEntity/cda:representedOrganization/cda:addr">
            [Entete_CR-GM] L'adresse de l'organisation du responsable du document CRGM est obligatoirement présente.         
        </assert>
    </rule>  
    
    <rule context='cda:ClinicalDocument/cda:participant'>
        <assert test="count(../cda:participant)&gt;2">
            [Entete_CR-GM] Il doit y avoir 3 participants au minimum (Le préleveur, le prescripteur et le médecin en charge du patient ).
        </assert>
        <assert test="../cda:participant[@typeCode='PRF'] or ../cda:participant[@typeCode='REF'] or ../cda:participant[@typeCode='RESP']">
            [Entete_CR-GM] L'attribut typeCode de l'élément participant prend la valeur typeCode='PRF' pour le préleveur, typeCode='REF' pour le prescripteur et typeCode='RESP' pour le médecin en charge du patient.
        </assert>
        
        <assert test="cda:associatedEntity/cda:associatedPerson">
            [Entete_CR-GM] Les informations d’identité du PS participant sont obligatoirement présentes.
        </assert>
    </rule>
        
    <rule context="cda:ClinicalDocument/cda:documentationOf">
        <assert test="cda:serviceEvent/cda:code and (cda:serviceEvent/cda:code[@code='51956-1'])">
            [Entete_CR-GM] Le code de l'acte documenté est obligatoire et doit être égal à '51956-1'.            
        </assert>
    </rule>
  
    <rule context="cda:ClinicalDocument/cda:componentOf">
        <assert test="cda:encompassingEncounter/cda:code[@code='AMB']">
            [Entete_CRGM] Le type de prise en charge doit avoir comme code 'AMB'.            
        </assert>
    </rule>
    
</pattern>