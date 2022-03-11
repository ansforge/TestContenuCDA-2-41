<?xml version="1.0" encoding="UTF-8"?>

<!--                  -=<<o#%@O[ E_immunizations_fr.sch ]O@%#o>>=-
    
    Teste la conformité de l'entrée "Vaccination" (Immunizations - 1.3.6.1.4.1.19376.1.5.3.1.4.12) aux spécifications françaises. 

    Historique :
    06/07/2017 : Création
    02/08/2017 : Correction du test sur les entryRelationship
    25/07/2019 : Mise à jour des libellés des messages.
    25/07/2019 : Suppression du contrôle sur le numéro de lot qui n'est plus obligatoire.
    09/10/2019 : Suppression des contrôle sur la voie d'administration et la dose à administrer qui ne sont plus obligatoires.
-->

<pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="E_immunizations_fr">
    <title>CI-SIS Entrée Vaccination</title>
        
    <rule context="*[cda:templateId/@root='1.3.6.1.4.1.19376.1.5.3.1.4.12']">
        
        <assert test='count(cda:id)=1'>
            [E_immunizations_fr] Erreur de Conformité CI-SIS : 
            Une entrée 'Immunization' ne peut avoir qu'un seul identifiant (id).
        </assert>
        
        <assert test='count(cda:statusCode)=1'>
            [E_immunizations_fr] Erreur de Conformité CI-SIS :
            Une entrée 'Immunization' doit comporter un (et un seul) élément statusCode.
        </assert>
        
        <assert test="count(cda:text/cda:reference[@value])=1">
            [E_immunizations_fr] Erreur de Conformité CI-SIS :
            Une entrée 'Immunization' doit comporter un (et un seul) élément 'text' avec une 'reference'.
        </assert>

        <assert test="count(cda:effectiveTime)=1">
            [E_immunizations_fr] Erreur de Conformité CI-SIS :
            Une entrée 'Immunization' doit comporter un (et un seul) élément 'effectiveTime'.
        </assert>
        
        <!-- la voie d'administration n'est plus obligatoire (suppression du contrôle) -->
        <!-- <assert test="count(cda:routeCode)=1">
            [E_immunizations_fr] Erreur de Conformité CI-SIS :
            Une entrée 'Immunization' doit comporter un (et un seul) élément 'routeCode' pour préciser la voie d'administration.
        </assert> -->
        
        <!-- la dose à administrer n'est plus obligatoire (suppression du contrôle) -->
        <!-- <assert test="count(cda:doseQuantity)=1">
            [E_immunizations_fr] Erreur de Conformité CI-SIS :
            Une entrée 'Immunization' doit comporter un (et un seul) élément 'doseQuantity' pour préciser la dose à administrer.
        </assert> -->
        
        <assert test='count(cda:consumable/cda:manufacturedProduct/cda:manufacturedMaterial/cda:code/cda:originalText/cda:reference)=1 or cda:consumable/cda:manufacturedProduct/cda:manufacturedMaterial/cda:code/@nullFlavor'>
            [E_immunizations_fr] Erreur de conformité CI-SIS :
            Une entrée 'Immunization' doit comporter un (et un seul) élément 'consumable' pour décrire le produit (manufacturedProduct) avec une entrée de type Product Entry.
            Cette entrée 'Product Entry' doit comporter un élément 'code' et une description narrative via une référence à l'élément narratif de la section (originalText/reference).
        </assert>
        
        <!-- le numéro de lot n'est plus obligatoire (suppression du contrôle) -->
        <!-- <assert test='count(cda:consumable/cda:manufacturedProduct/cda:manufacturedMaterial/cda:lotNumberText)=1'>
            [E_immunizations_fr] Erreur de conformité CI-SIS : Le numéro de lot du produit est obligatoire
        </assert> -->
        
        <assert test="not(cda:entryRelationship) or 
            cda:entryRelationship[@typeCode='CAUS']/cda:observation/cda:templateId[@root='2.16.840.1.113883.10.20.1.28'] or 
            cda:entryRelationship[@typeCode='SUBJ']/cda:act/cda:templateId[@root='1.3.6.1.4.1.19376.1.5.3.1.4.2'] or
            cda:entryRelationship[@typeCode='SUBJ']/cda:observation/cda:templateId[@root='2.16.840.1.113883.10.20.1.46'] or 
            cda:entryRelationship[@typeCode='REFR']/cda:supply/cda:templateId[@root='1.3.6.1.4.1.19376.1.5.3.1.4.7.3']">
            [E_immunizations_fr] Erreur de conformité CI-SIS : 
            Dans une entrée 'Immunization', les éléments 'entryRelationship' ne sont pas obligatoires.
            S'ils sont présents, ils doivent respecter les exigences suivantes :
            - Réaction observée ('entryRelationship' avec typeCode='CAUS') : doit comporter une entrée de type 'observation' avec un OID="2.16.840.1.113883.10.20.1.28".
            - Commentaire ('entryRelationship' avec typeCode='SUBJ') : doit comporter une entrée de type 'act' avec un OID="1.3.6.1.4.1.19376.1.5.3.1.4.2".
            - Rang de la vaccination ('entryRelationship' avec typeCode='SUBJ') : doit comporter une entrée de type 'observation' avec un OID="2.16.840.1.113883.10.20.1.46".
            - Lien avec la prescription ('entryRelationship' avec typeCode 'REFR') : doit comporter une entrée de type 'supply' avec un OID="1.3.6.1.4.1.19376.1.5.3.1.4.7.3".
        </assert>
        
        <assert test="count(cda:entryRelationship[@typeCode='REFR']/cda:supply/cda:templateId[@root='1.3.6.1.4.1.19376.1.5.3.1.4.7.3'])&lt;2">
            [E_immunizations_fr] Erreur de conformité CI-SIS : 
            Dans une entrée 'Immunization', il ne peut y avoir qu'un seul élément 'entryRelationship' (typeCode 'REFR') décrivant le lien avec la prescription (entrée de type 'supply' avec un OID="1.3.6.1.4.1.19376.1.5.3.1.4.7.3").
        </assert>
        
        <assert test="count(cda:entryRelationship[@typeCode='SUBJ']/cda:act/cda:templateId[@root='2.16.840.1.113883.10.20.1.46'])&lt;2">
            [E_immunizations_fr] Erreur de conformité CI-SIS :
            Dans une entrée 'Immunization', il ne peut y avoir qu'un seul élément 'entryRelationship' (typeCode 'SUBJ') décrivant le rang de la vaccination (entrée de type 'observation' avec un OID="2.16.840.1.113883.10.20.1.46").
        </assert>
        
        <assert test="count(cda:entryRelationship[@typeCode='SUBJ']/cda:act/cda:templateId[@root='1.3.6.1.4.1.19376.1.5.3.1.4.2'])&lt;2">
            [E_immunizations_fr] Erreur de conformité CI-SIS : L'élément entryRelationship représentant le commentaire ne peut être présent qu'une fois
            Dans une entrée 'Immunization', il ne peut y avoir qu'un seul élément 'entryRelationship' (typeCode 'SUBJ') portant un commentaire (entrée de type 'act' avec un OID="1.3.6.1.4.1.19376.1.5.3.1.4.2").            
        </assert>
        
        <assert test="not(cda:entryRelationship[@typeCode='SUBJ']/cda:observation[cda:templateId/@root='2.16.840.1.113883.10.20.1.46']) or (cda:entryRelationship[@typeCode='SUBJ']/cda:observation[cda:templateId/@root='2.16.840.1.113883.10.20.1.46']
            and cda:entryRelationship[@typeCode='SUBJ']/cda:observation[cda:templateId/@root='2.16.840.1.113883.10.20.1.46']/cda:code/@code='30973-2')">
            [E_immunizations_fr] Erreur de conformité CI-SIS :
            Dans une entrée 'Immunization', l'entryRelationship (typeCode 'SUBJ') décrivant le rang de la vaccination (entrée de type 'observation' avec un OID="2.16.840.1.113883.10.20.1.46") doit obligatoirement avoir le code @code='30973-2'.
        </assert>
    </rule>
      
</pattern>
