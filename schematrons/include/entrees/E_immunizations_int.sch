<?xml version="1.0" encoding="UTF-8"?>

<!--                  -=<<o#%@O[ immunizationsEnt.sch ]O@%#o>>=-
    
    Définition: Teste les entrées relatives à la vaccination du volet du CI-SIS Certificats de santé de l'enfant 
    CS9, et CS24 pour la section "Immunizations Section" 
    
    Historique :
    24/06/2011 : Création
    26/06/2017 : Mise en conformité avec IHE-PCC
    03/08/2017 : Correction du test sur le substanceAdministration
    25/07/2019 : Mise à jour des libellés des erreurs
   30/01/2020 : NMA : Mise à jour du test sur le nombre de templateId
    
-->


<pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="E_immunizations_int">
    <title>IHE PCC v3.0 Immunizations Section</title>
    
    <!-- ****** Contexte = Entrée Immunizations****** -->
    
    <rule context="*[cda:templateId/@root='1.3.6.1.4.1.19376.1.5.3.1.4.12']">
        <let name="count_templateId" value="count(cda:templateId)"/>
        <assert test='(@negationInd="true" or @negationInd="false") and @classCode="SBADM" and (@moodCode="EVN" or @moodCode="INT")'>
            [E_immunizations_int.sch] Erreur de Conformité PCC : 
            Dans une entrée 'Immunization', l'attribut negationInd doit prendre la valeur 'true' (la vaccination n'a pas eu lieu) ou la valeur 'false' (la vaccination a eu lieu).
        </assert>

        <assert test='cda:templateId[@root="2.16.840.1.113883.10.20.1.24"]'>
            [E_immunizations_int.sch] Erreur de Conformité PCC : 
            Dans une entrée 'Immunization', l'OID du template CCD parent (2.16.840.1.113883.10.20.1.24) est obligatoire.
        </assert>
        
        <assert test="$count_templateId&gt;1">
            [E_immunizations_int.sch] Erreur de Conformité PCC : 
            Une entrée 'Immunization' doit comporter au minimum deux templateId (cardinalité [2..*])
        </assert>
        
        <assert test='cda:id'>
            [E_immunizations_int.sch] Erreur de Conformité PCC :  
            Dans une entrée 'Immunization', l'élément 'id' (identifiant de l'entrée) est obligatoire.
        </assert>
        
        <assert test='cda:code[@code and @codeSystem]'>
            [E_immunizations_int.sch] Erreur de Conformité PCC : 
            Dans une entrée 'Immunization', l'élément 'code' (type de vaccination) est obligatoire. Les attributs 'code' et 'codeSystem' sont obligatoires. 
            Le type de vaccination permet de préciser s'il s'agit d'un primo-vaccination ou d'un rappel. Si l'information n'est pas connue, utiliser le code='IMMUNIZ' (vaccination sans autre précision).             
        </assert>
        
        <assert test='cda:statusCode[@code="completed"]'>
            [E_immunizations_int.sch] Erreur de Conformité PCC : 
            Dans une entrée 'Immunization', l'élément 'statusCode' est obligatoire et doit prendre la valeur 'completed'.
        </assert>
        
        <assert test='cda:effectiveTime[@value or @nullFlavor]'>
            [E_immunizations_int.sch] Erreur de Conformité PCC :            
            Dans une entrée 'Immunization', l'élément 'effectiveTime' est obligatoire.
            Il permet d'indiquer la date de la vaccination. Si la date est inconnue, utiliser l'attribut nullFlavor="UNK".
        </assert>
        
        <assert test='cda:consumable//cda:manufacturedProduct//cda:templateId[@root="1.3.6.1.4.1.19376.1.5.3.1.4.7.2"]'>
            [E_immunizations_int.sch] Erreur de Conformité PCC :  
            Dans une entrée 'Immunization', l'élément 'consumable' est obligatoire.
            Il doit comporter une entrée 'manufacturedProduc' conforme au template 'Product Entry template' (1.3.6.1.4.1.19376.1.5.3.1.4.7.2).
        </assert>
    </rule>
      
</pattern>
