<?xml version="1.0" encoding="UTF-8"?>

<!--                  -=<<o#%@O[ E_AllergiesAndIntoleranceConcern_int.sch ]O@%#o>>=-
    
    Teste la conformité d'une entrée utilisée dans le volet du CI-SIS aux spécifications de l'entrée 
    PCC allergies and Intolerance Concern (1.3.6.1.4.1.19376.1.5.3.1.4.5.3)  
    
    
    Historique :
    03/08/11 : CRI : Création
    21/06/17 : LBE : Ajout de contrôle et conventions de nommage
    22/06/17 : NMA : Ajout de la contrainte sur le nombre de templateIds
    
-->

<pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="E_allergiesAndIntoleranceConcern_int">
    <title>IHE PCC v3.0 Allergies and Intolerance Concern</title>
    <rule context="*[cda:templateId/@root='1.3.6.1.4.1.19376.1.5.3.1.4.5.3']">
        <let name="count_templateId" value="count(cda:templateId)"/>
        
        <assert test='cda:templateId[@root = "2.16.840.1.113883.10.20.1.27"] and
            cda:templateId[@root = "1.3.6.1.4.1.19376.1.5.3.1.4.5.1"]'>
            [E_allergiesAndIntoleranceConcern_int] Erreur de Conformité PCC: Les déclarations de conformité aux templates des parents 
            CCD 'Problem Act' (2.16.840.1.113883.10.20.1.27) 
            et PCC 'Concern Entry' (1.3.6.1.4.1.19376.1.5.3.1.4.5.1) sont requises pour l'entrée 'Allergy and Intolerance Concern'.</assert>
       
        <assert test="$count_templateId&gt;2">
            [E_allergiesAndIntoleranceConcern_int] Erreur de conformité PCC : Dans l'élément "allergies And Intolerance Concern", il doit y avoir au minimum trois templateIds
        </assert>
        
        <assert test='cda:entryRelationship[@typeCode="SUBJ"]//cda:templateId[@root="1.3.6.1.4.1.19376.1.5.3.1.4.6"]'>
            
            [E_allergiesAndIntoleranceConcern_int] Erreur de Conformité PCC: Cette entrée 'Allergy and Intolerance Concern' doit contenir une ou plusieurs entrées se conformant
            au template de l'entrée 'Allergy and Intolerance' (1.3.6.1.4.1.19376.1.5.3.1.4.6).
            Ces entrées sont reliées à l'entrée 'Allergy and Intolerance Concern' par des éléments entryRelationshipdont les attributs 
            'typeCode' et 'inversionInd' prendront respectivement les valeurs 'SUBJ' et 'false'.
        </assert>
        
    </rule>
    
</pattern>
