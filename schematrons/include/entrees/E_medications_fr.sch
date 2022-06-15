<?xml version="1.0" encoding="UTF-8"?>

<!-- E_medications_fr.sch
     ......................................................................................................................................................
     Vérification de la conformité de l'entrée FR-Traitement (Medications - 1.3.6.1.4.1.19376.1.5.3.1.4.7)  
     ......................................................................................................................................................
     Historique :
     06/07/2017 : NMA : Création
     28/07/2017 : LBE : Ajout des contraintes sur les nullFlavor
     05/10/2017 : NMA : Suppression du test sur le numéro de lot
     09/10/2019 : NMA : Mise à jour du test sur la doseQuantity
     30/01/2020 : NMA : Mise à jour du test sur le nombre de templateId
     27/02/2020 : APE : 2ème <effectiveTime> (fréquence) non obligatoire car elle peut être exprimée dans un <substanceAdministration> subordonné pour les doses fractionnées, conditionnelles et combinées
     27/02/2020 : APE : Ajout des entryRelationship supplémentaires possibles
     15/03/2022 : ANS : Suppression du test sur la présence de l'effectiveTime
-->

<pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="E_medications_fr">
    <title>CI-SIS Medications</title>
       
    <rule context='*[cda:templateId/@root="1.3.6.1.4.1.19376.1.5.3.1.4.7"]'>
        
        <assert test="count(cda:templateId)&gt;2">
            [E_medications_fr] Erreur de conformité CI-SIS : L'entrée de type "substanceAdministration" doit contenir au minimum trois éléments "templateId".            
        </assert>
        
        <!--<assert test="cda:effectiveTime">
            [E_medications_fr] Erreur de conformité CI-SIS : Un élément "effectiveTime" doit être présent pour préciser la durée du traitement.
        </assert>-->
        
        <assert test="(count(cda:doseQuantity/cda:low)=1 and count(cda:doseQuantity/cda:high)=1) or cda:doseQuantity/@nullFlavor or not(cda:doseQuantity)">
            [E_medications_fr] Erreur de conformité CI-SIS : L'élément "doseQuantity" (dose à administrer) n'est pas obligatoire mais s'il est présent, ces éléments "low" et "high" sont obligatoires et ne doivent être présents qu'une seule fois (cardinalité [1..1]).
            L'élément "doseQuantity" peut aussi prendre la valeur nullFlavor.
        </assert>
        
        <assert test="not(cda:rateQuantity) or cda:rateQuantity/@nullFlavor or (count(cda:rateQuantity/cda:low)=1 and count(cda:rateQuantity/cda:high)=1)">
            [E_medications_fr] Erreur de conformité CI-SIS : L'élément "rateQuantity" (rythme d'administration) n'est pas obligatoire mais s'il est présent, ces éléments "low" et "high" sont obligatoires et ne doivent être présents qu'une seule fois (cardinalité [1..1]).
        </assert>
        
        <assert test="count(cda:maxDoseQuantity)&lt;2 ">
            [E_medications_fr] Erreur de conformité CI-SIS : L'élément "maxDoseQuantity" (dose maximale) ne peut être présent plus d'une fois.
        </assert>
        
        <assert test='cda:consumable/cda:manufacturedProduct/cda:templateId[@root="1.3.6.1.4.1.19376.1.5.3.1.4.7.2"]'>
            [E_medications_fr] Erreur de conformité CI-SIS : L'élément "consumable" doit obligatoirement être présent dans une entrée de type "substanceAdministration".
            Il comportera un élément "manufacturedProduct" de type "Produit de santé" (1.3.6.1.4.1.19376.1.5.3.1.4.7.2).</assert>
        
        <assert test='count(cda:consumable/cda:manufacturedProduct/cda:templateId)&gt;1'>
            [E_medications_fr] Erreur de conformité CI-SIS : L'élément "manufacturedProduct" contient au minimum deux éléments "templateId" : "1.3.6.1.4.1.19376.1.5.3.1.4.7.2" et "2.16.840.1.113883.10.20.1.53".
        </assert>
        
        <assert test='count(cda:consumable/cda:manufacturedProduct/cda:manufacturedMaterial/cda:code/cda:originalText/cda:reference)=1 or cda:consumable/cda:manufacturedProduct/cda:manufacturedMaterial/cda:code/@nullFlavor'>
            [E_medications_fr] Erreur de conformité CI-SIS : L'entréede type "Produit de santé" (1.3.6.1.4.1.19376.1.5.3.1.4.7.2) doit contenir un médicament administré (manufacturedMaterial) avec sa codification CIS-Spécialité
            et une description narrative via une référence à l'élément narratif de la section.
        </assert>

      <assert test="not(cda:entryRelationship)        
            or cda:entryRelationship[@typeCode='RSON']/cda:act/cda:templateId[@root='1.3.6.1.4.1.19376.1.5.3.1.4.4.1']
            or cda:entryRelationship[@typeCode='REFR']/cda:supply/cda:templateId[@root='1.3.6.1.4.1.19376.1.5.3.1.4.7.3']
            or cda:entryRelationship[@typeCode='COMP']/cda:substanceAdministration
            or cda:entryRelationship[@typeCode='SUBJ']/cda:act/cda:templateId[@root='1.3.6.1.4.1.19376.1.5.3.1.4.3']
            or cda:entryRelationship[@typeCode='SUBJ']/cda:act/cda:templateId[@root='1.3.6.1.4.1.19376.1.5.3.1.4.3.1']
            or cda:entryRelationship[@typeCode='COMP']/cda:observation/cda:templateId[@root='1.3.6.1.4.1.19376.1.5.3.1.4.13']
            or cda:entryRelationship[@typeCode='REFR']/cda:substanceAdministration/cda:templateId[@root='1.3.6.1.4.1.19376.1.9.1.3.10']
            or cda:entryRelationship[@typeCode='COMP']/cda:supply/cda:templateId[@root='1.3.6.1.4.1.19376.1.9.1.3.8']
            or cda:entryRelationship[@typeCode='COMP']/cda:act/cda:templateId[@root='1.3.6.1.4.1.19376.1.9.1.3.9.1']
            or cda:entryRelationship[@typeCode='COMP']/cda:supply/cda:templateId[@root='1.3.6.1.4.1.19376.1.9.1.3.15']
            ">
            [E_medications_fr] Erreur de conformité CI-SIS : Seuls les éléments "entryRelationship" optionnels suivants sont autorisés :
            - Motif du traitement : avec un typeCode='RSON' et une entrée Référence interne (1.3.6.1.4.1.19376.1.5.3.1.4.4.1)           
            - Référence de la prescription : avec un typeCode 'REFR' et une entrée Prescription (1.3.6.1.4.1.19376.1.5.3.1.4.7.3)
            - SubstanceAdministration subordonné : avec un typeCode='COMP' et une entrée de type substanceAdministration subordonnée            
            - Instructions au patient : avec un typeCode='SUBJ'  et une entrée Instructions au patient (1.3.6.1.4.1.19376.1.5.3.1.4.3)  
            - Instructions au dispensateur : avec un typeCode='SUBJ'  et une entrée Instructions au dispensateur (1.3.6.1.4.1.19376.1.5.3.1.4.3.1)            
            - Simple Observation : avec un typeCode='COMP' et une entrée Simple Observation (1.3.6.1.4.1.19376.1.5.3.1.4.13)            
            - Référence à un traitement d'un plan de traitement : avec un typeCode='REFR' et une entrée Référence à un traitement d'un plan de traitement (1.3.6.1.4.1.19376.1.9.1.3.10) 
            - Quantité à dispenser : avec un typeCode='COMP' et une entrée Quantité à dispenser (1.3.6.1.4.1.19376.1.9.1.3.8)
            - Autorisation de substitution : avec un typeCode='COMP' et une entrée Autorisation de substitution (1.3.6.1.4.1.19376.1.9.1.3.9.1)
            - Période de renouvellement : avec un typeCode='COMP' et une entrée Période de renouvellement (1.3.6.1.4.1.19376.1.9.1.3.15)
             
        </assert>        
    </rule>
    
    <rule context='*[cda:templateId/@root="1.3.6.1.4.1.19376.1.5.3.1.4.7"]/cda:entryRelationship[@typeCode="RSON"]/cda:act'>
        <report test="cda:templateId[@root != '1.3.6.1.4.1.19376.1.5.3.1.4.4.1'
            and @root !='1.2.250.1.213.1.1.3.36' and @root !='2.16.840.1.113883.10.22.4.31']">
            [E_medications_fr] Erreur de conformité CI-SIS : Dans une entryRelationship qui a un @typeCode="RSON" et qui est de type act, seule une entrée "Référence interne (1.3.6.1.4.1.19376.1.5.3.1.4.4.1)" est admise
        </report>
    </rule>
    
    <rule context='*[cda:templateId/@root="1.3.6.1.4.1.19376.1.5.3.1.4.7"]/cda:entryRelationship[@typeCode="REFR"]/cda:supply'>
        <report test="cda:templateId[@root !='2.16.840.1.113883.10.20.1.34'
            and @root !='1.3.6.1.4.1.19376.1.5.3.1.4.7.3'
            and @root !='1.2.250.1.213.1.1.3.44']">
            [E_medications_fr] Erreur de conformité CI-SIS : Dans une entryRelationship qui a un @typeCode="REFR" et qui est de type supply, seule une entrée "Prescription (1.3.6.1.4.1.19376.1.5.3.1.4.7.3)" est admise
        </report>
    </rule>
    
    <rule context='*[cda:templateId/@root="1.3.6.1.4.1.19376.1.5.3.1.4.7"]/cda:entryRelationship[@typeCode="SUBJ"]/cda:act'>
        <report test="cda:templateId[@root !='2.16.840.1.113883.10.20.1.49'
            and @root !='1.3.6.1.4.1.19376.1.5.3.1.4.3'
            and @root !='1.2.250.1.213.1.1.3.33'
            and @root !='2.16.840.1.113883.10.20.1.43'
            and @root !='1.3.6.1.4.1.19376.1.5.3.1.4.3.1'
            and @root !='1.2.250.1.213.1.1.3.34'
            ]">
            [E_medications_fr] Erreur de conformité CI-SIS : Dans une entryRelationship qui a un @typeCode="SUBJ" et qui est de type act,
            seules des entrées "Instructions au patient (1.3.6.1.4.1.19376.1.5.3.1.4.3)" et "Instructions au dispensateur (1.3.6.1.4.1.19376.1.5.3.1.4.3.1)" sont admises
        </report>
    </rule>
    
    <rule context='*[cda:templateId/@root="1.3.6.1.4.1.19376.1.5.3.1.4.7"]/cda:entryRelationship[@typeCode="COMP"]/cda:observation'>
        <report test="cda:templateId[@root !='1.3.6.1.4.1.19376.1.5.3.1.4.13'
            and @root !='1.2.250.1.213.1.1.3.48'
            and not(starts-with(@root, '1.2.250.1.213.1.1.3.48.'))]">
            [E_medications_fr] Erreur de conformité CI-SIS : Dans une entryRelationship qui a un @typeCode="COMP" et qui est de type observation, seule une entrée "Simple Observation (1.3.6.1.4.1.19376.1.5.3.1.4.13)" est admise
        </report>
    </rule>
    
    <rule context='*[cda:templateId/@root="1.3.6.1.4.1.19376.1.5.3.1.4.7"]/cda:entryRelationship[@typeCode="REFR"]/cda:substanceAdministration'>
        <report test="cda:templateId[@root !='1.3.6.1.4.1.19376.1.9.1.3.10'
            and @root !='1.2.250.1.213.1.1.3.85']">
            [E_medications_fr] Erreur de conformité CI-SIS : Dans une entryRelationship qui a un @typeCode="REFR" et qui est de type substanceAdministration, seule une entrée "Référence à un traitement d'un plan de traitement (1.3.6.1.4.1.19376.1.9.1.3.10)" est admise
        </report>
    </rule>
    
    <rule context='*[cda:templateId/@root="1.3.6.1.4.1.19376.1.5.3.1.4.7"]/cda:entryRelationship[@typeCode="COMP"]/cda:supply'>
        <report test="cda:templateId[@root !='1.3.6.1.4.1.19376.1.9.1.3.8'
            and @root !='1.2.250.1.213.1.1.3.86' and @root !='1.3.6.1.4.1.19376.1.9.1.3.15'
            and @root !='1.2.250.1.213.1.1.3.88']">
            
            [E_medications_fr] Erreur de conformité CI-SIS : Dans une entryRelationship qui a un @typeCode="COMP" et qui est de type supply,
            seules des entrées "Quantité à dispenser (1.3.6.1.4.1.19376.1.9.1.3.8)" et "Période de renouvellement (1.3.6.1.4.1.19376.1.9.1.3.15)" sont admises
        </report>
    </rule>
    
    <rule context='*[cda:templateId/@root="1.3.6.1.4.1.19376.1.5.3.1.4.7"]/cda:entryRelationship[@typeCode="COMP"]/cda:act'>
        <report test="cda:templateId[@root !='1.3.6.1.4.1.19376.1.9.1.3.9.1'
            and @root !='1.2.250.1.213.1.1.3.87']">
            [E_medications_fr] Erreur de conformité CI-SIS : Dans une entryRelationship qui a un @typeCode="COMP" et qui est de type act, seule une entrée "Autorisation de substitution (1.3.6.1.4.1.19376.1.9.1.3.9.1)" est admise
        </report>
    </rule>
    
    <rule context='*[cda:templateId/@root="1.3.6.1.4.1.19376.1.5.3.1.4.7" and not(cda:templateId/@root="1.2.250.1.213.1.1.3.83")]/cda:routeCode'>
        <assert test="@codeSystem='2.16.840.1.113883.5.112' or @codeSystem='0.4.0.127.0.16.1.1.2.1' or (@nullFlavor and not(@codeSystem))">
            [E_medications_fr] Erreur de conformité CI-SIS : Un élément "routeCode" doit provenir du jeu de valeurs JDV_HL7_RouteOfAdministration-CISIS (2.16.840.1.113883.5.112) ou de la terminologie EDQM (0.4.0.127.0.16.1.1.2.1).
        </assert>
    </rule>
    
</pattern>