<?xml version="1.0" encoding="UTF-8"?>
<!-- 
    modeleEntete_fr.sch :
    Contenu :
       Test la conformité des éléments d'entête de niveau en fonction des contraintes décrites dans le volet de stucturation Minimale 
    Paramètres d'appel :
        Néant
    Historique :
        19/06/2017 : LBE : Création
-->
<pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="modeleEntete_fr">
   <rule context="cda:ClinicalDocument">
       <let name="count_realmCode" value="count(cda:realmCode)"/>
       <let name="count_templateId" value="count(cda:templateId)"/>
       <let name="count_recordTarget" value="count(cda:recordTarget)"/>
       <let name="count_legalAuthenticator" value="count(cda:legalAuthenticator)"/>
       <let name="count_inFulfillmentOf" value="count(cda:inFulfillmentOf)"/>
       <let name="count_relatedDocument" value="count(cda:relatedDocument)"/>
       
       <!-- conformité du RealmCode -->
       <assert test="$count_realmCode=1">
           [modeleEntete_fr.sch] Erreur de conformité CI-SIS : L'élément realmCode doit être présent qu'une seule fois (cardinalité [1..1]) 
       </assert>
       <assert test="cda:realmCode[@code='FR']">
           [modeleEntete_fr.sch] Erreur de conformité CI-SIS : L'élément realmCode doit comporter l'attribut @code fixé à la valeur 'FR'
       </assert>
       <!--conformité du  typeId -->
       <assert test="cda:typeId[@root='2.16.840.1.113883.1.3'] and cda:typeId[@extension='POCD_HD000040']">
           [modeleEntete_fr.sch] Erreur de conformité CI-SIS : L'élément typeId doit contenir les attributs @root fixé à '2.16.840.1.113883.1.3' et @extension fixé à 'POCD_HD000040'
       </assert>
       <!-- conformité des templateId -->
       <assert test="$count_templateId &gt;=3">
           [modeleEntete_fr.sch] Erreur de conformité CI-SIS : L'élément templateId doit contenir au moins trois occurences
       </assert>
       <assert test="cda:templateId[@root='2.16.840.1.113883.2.8.2.1']">
           [modeleEntete_fr.sch] Erreur de conformité CI-SIS : l'élément templateId contenant l'attribut @root fixé à la valeur '2.16.840.1.113883.2.8.2.1' doit être présent, cela représente la déclaration de conformité aux spécifications HL7 France
       </assert>
       <assert test="cda:templateId[@root='1.2.250.1.213.1.1.1.1']">
           [modeleEntete_fr.sch] Erreur de conformité CI-SIS : l'élément templateId contenant l'attribut @root fixé à la valeur '1.2.250.1.213.1.1.1.1' doit être présent, cela représente la déclaration de conformité aux spécifications du CI-SIS
       </assert>
       <!-- conformité  id  -->
       <assert test="cda:id[@root]">
           [modeleEntete_fr.sch] Erreur de conformité CI-SIS : l'élément id doit contenir une valeur d'OID dans l'attribut @root           
       </assert>
       <!-- conformité code  -->
       <assert test="cda:code[@code] and cda:code[@codeSystem] and cda:code[@displayName]">
           [modeleEntete_fr.sch] Erreur de conformité CI-SIS : l'élément code doit contenir les attributs @code, @codeSystem, et @displayName
       </assert>
       <!-- Conformité title -->
       <assert test="cda:title">
           [modeleEntete_fr.sch] Erreur de conformité CI-SIS : l'élément title doit être présent
       </assert>
       <!-- conformité effectiveTime -->
       <assert test="cda:effectiveTime[@value]">
           [modeleEntete_fr.sch] Erreur de conformité CI-SIS : l'élément effectiveTime doit contenir l'attribut @value
       </assert>
 <!--      <!-\- ConfidentailityCode -\->
       <assert test="cda:confidentialityCode[@codeSystem='2.16.840.1.113883.5.25'] and ((cda:confidentialityCode[@code='N']) or
           (cda:confidentialityCode[@code='R']) or (cda:confidentialityCode[@code='V']))">
           [modeleEntete_fr.sch] Erreur de conformité CI-SIS : L'élément confidentialityCode doit contenir l'attribut @codeSystem fixé à  2.16.840.1.113883.5.25. Les valeurs possibles dans les attributs @code et @displayName, sont respectivement :
           'N' et 'Normal', ou 
           'R' et 'Restreint', ou 
           'V' et 'Très restreint'           
       </assert> --> 
       <!-- conformité language code -->
       <assert test="cda:languageCode[@code='fr-FR']">
           [modeleEntete_fr.sch] Erreur de conformité CI-SIS : L'élément languageCode doit être présent et contenir l'attribut @code fixé à la valeur 'fr-FR'
       </assert>
       
      <!-- conformité recordTarget -->
       <assert test="$count_recordTarget=1">
           [modeleEntete_fr.sch] Erreur de conformité CI-SIS : L'élément recordTarget doit être présent qu'une seule fois (cardinalité [1..1])
       </assert>
       
       <!-- conformité legalAuthenticator -->
       <assert test="$count_legalAuthenticator=1">
           [modeleEntete_fr.sch] Erreur de conformité CI-SIS : L'élément legalAuthenticator doit être présent qu'une seule fois (cardinalité [1..1])
       </assert>
       
       <!-- conformité inFulfillmentOf -->
       <assert test="$count_inFulfillmentOf&lt;=1">
           [modeleEntete_fr.sch] Erreur de conformité CI-SIS : L'élément inFulfillmentOf ne peut être présent qu'une seule fois au maximum (cardinalité [0..1])
       </assert>
       
       <!-- conformité documentaiton -->
       <assert test="cda:documentationOf">
           [modeleEntete_fr.sch] Erreur de conformité CI-SIS : L'élément documentationOf doit être présent au moins une fois (cardinalité [1..*])
       </assert>
       <!-- conformité relatedDocument -->
       <assert test="$count_relatedDocument&lt;=1">
           [modeleEntete_fr.sch] Erreur de conformité CI-SIS : L'élément relatedDocuement doit être présent qu'une seule fois au maximum (cardinalité [0..1])
       </assert>
       
       <!-- conformité componentOf -->
       <assert test="cda:componentOf">
           [modeleEntete_fr.sch] Erreur de conformité CI-SIS : L'élément componentOf est obligatoire (cardinalité [1..1])
       </assert>
   </rule>
</pattern>
