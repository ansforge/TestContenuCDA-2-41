<?xml version="1.0" encoding="UTF-8"?>

<!-- E_supplyEntry_int -=
     Vérifie la conformité par rapport au profil IHE PCC de l'entrée Supply Entry (1.3.6.1.4.1.19376.1.5.3.1.4.7.3)
    
    26/06/2017 : Création
    21/05/2019 : Suppression de l'élément time sous supply
    11/10/2019 : L'élément time du supply peut prendre la valeur nullFlavor
    16/10/2019 : Modification des libellés des messages d'erreurs.
    30/01/2020 : NMA : Mise à jour du test sur le nombre de templateId
-->

<pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="E_supplyEntry_int">
    <title>IHE PCC v3.0Supply entry</title>
    <rule context="*[cda:templateId/@root='1.3.6.1.4.1.19376.1.5.3.1.4.7.3']">
        
        <let name="count_templateId" value="count(cda:templateId)"/>
        <let name="count_id" value="count(cda:id)"/>
        
        <assert test="../../cda:entryRelationship[@typeCode = 'REFR' and  @inversionInd = 'false']">
            [E_supplyEntry_int.sch] Errreur de conformité PCC : Dans l'entrée 'Prescription', l'entryRelationShip doit contenir les attributs 
            @typeCode et @inversionInd fixés respectivement aux valeurs 'REFR' et 'false'
        </assert>
        
        <assert test="@classCode='SPLY' and (@moodCode='INT' or @moodCode='EVN')">
            [E_supplyEntry_int.sch] Errreur de conformité PCC : Dans l'entrée 'Prescription', l'élément 'supply' doit contenir l'attribut @classCode fixé à la valeur 'SPLY' et l'attribut @moodCode fixé à la valeur 'INT' ou 'EVN'
        </assert>
        
        <assert test="$count_templateId&gt;1">
            [E_supplyEntry_int.sch] Errreur de conformité PCC : L'entrée 'Prescription' doit contenir au minimum deux templateId.
        </assert>
        
        <assert test="$count_id=1">
            [E_supplyEntry_int.sch] Errreur de conformité PCC : L'entrée 'Prescription' doit contenir un élément id (cardinalité [1..1]).
        </assert>

    </rule>

    <rule context="*[cda:templateId/@root='1.3.6.1.4.1.19376.1.5.3.1.4.7.3']/cda:quantity">
        <assert test="@value">
            [E_supplyEntry_int.sch] Errreur de conformité PCC : Dans l'entrée 'Prescription', l'élément 'quantity' (s'il est présent) doit avoir un attribut 'value'.  
        </assert>
    </rule>
    
    <!-- Auteur -->
   
    <rule context="*[cda:templateId/@root='1.3.6.1.4.1.19376.1.5.3.1.4.7.3']/cda:author">
        
        <assert test="cda:time[@value or @nullFlavor]">
            [E_supplyEntry_int.sch] Errreur de conformité PCC : Dans l'entrée 'Prescription', l'élément 'time' doit être présent dans l'élément 'author' avec un attribut 'value'. Le nullFlavor est autorisé.
        </assert>
        
        <assert test="cda:assignedAuthor">
            [E_supplyEntry_int.sch] Errreur de conformité PCC : Dans l'entrée 'Prescription', l'élément 'author' doit contenir un élément 'assignedAuthor'. 
        </assert>
        
        <assert test="cda:assignedAuthor/cda:assignedPerson/cda:name or cda:assignedAuthor/cda:representedOrganization/cda:name">
            [E_supplyEntry_int.sch] Errreur de conformité PCC : Dans l'entrée 'Prescription', un élément 'assignedPerson' et/ou un élément 'representedOrganization' doit être présent. Ces éléments doivent contenir un élément 'name' pour identifier le prescripteur ou l'organization.
        </assert>
        
    </rule>
    
    <!-- performer -->
    
    <rule context="*[cda:templateId/@root='1.3.6.1.4.1.19376.1.5.3.1.4.7.3']/cda:performer">
        <assert test="@typeCode='PRF'">
            [E_supplyEntry_int.sch] Errreur de conformité PCC : Dans l'entrée 'Prescription', l'élément 'performer' doit contenir un attribut typeCode='PRF'.
        </assert>
        <assert test="cda:time[@value]">
            [E_supplyEntry_int.sch] Errreur de conformité PCC : Dans l'entrée 'Prescription', l'élément 'performer' doit contenir un élément 'time' avec un attribut 'value'.
        </assert>
        <assert test="cda:assignedEntity">
            [E_supplyEntry_int.sch] Errreur de conformité PCC : Dans l'entrée 'Prescription', l'élément 'performer' doit contenir un élément 'assignedEntity'. 
        </assert>
        <assert test="cda:assignedEntity/cda:assignedPerson/cda:name or cda:assignedEntity/cda:representedOrganization/cda:name">
            [E_supplyEntry_int.sch] Errreur de conformité PCC : Dans l'entrée 'Prescription', l'élément 'performer/assignedEntity' doit contenir un élément 'assignedPerson/name' et/ou un élément 'representedOrganization/name'.
        </assert>
       
    </rule>
</pattern>
