<?xml version="1.0" encoding="UTF-8"?>
<!-- 
   ......................................................................................................................................................    
   E_ListeDesAntecedents-D2LM-FIN
   Schématron de vérification de la conformité au modèle du CI-SIS d'une entrée ListeDesAntecedents dans un document D2LM-FIN 
   
   D2LM_FIN : CR de seconde lecture de mammographie - Fiche d'interprétation nationale
   auteur : ANS
   ......................................................................................................................................................    
    Historique :
       28/07/2020 : SBM : Création
   ......................................................................................................................................................    
-->
    
    <pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="E_ListeDesAntecedents-D2LM-FIN">
        <rule context="/*:component/*:section[*:templateId/@root='1.2.250.1.213.1.1.2.57']/*:component/*:section[*:templateId/@root='1.3.6.1.4.1.19376.1.5.3.1.3.8']/*:entry/*:act[*:templateId/@root='1.3.6.1.4.1.19376.1.5.3.1.4.5.2']">
            
            
            
            <!-- Variables  --> 
            <let name="EntréeAntecedMammographie" value="*:observation/*:code[@code='G-1009']"/>
            <let name="EntréeAntecedPersonnels" value="*:observation/*:code[@code='MED-009']"/>
            <let name="EntréeAntecedFamiliauxConnus" value="*:observation/*:code[@code='MED-010']"/>
            <let name="EntréeAntecedFamiliaux" value="*:observation/*:code[@code='MED-123']"/>
            <let name="EntréeAgeSurvenue" value="*:observation/*:code[@code='MED-070']"/>
            <let name="EntréePatienteInformée" value="*:observation/*:code[@code='MED-016']"/>
            <let name="EntréeMedecinTraitantInformé" value="*:observation/*:code[@code='MED-017']"/>
            <let name="EntréeTraitementHormonal" value="*:observation/*:code[@code='MED-029']"/>
            <let name="EntréeProblèmeCode" value="*:observation[*:templateId/@root ='1.3.6.1.4.1.19376.1.5.3.1.4.5']/*:code[@code='F-01000']"/>
            <let name="EntréeProblèmeVal" value="*:observation[*:templateId/@root ='1.3.6.1.4.1.19376.1.5.3.1.4.5']/*:value[@code='C00-D48']"/>
            
            <!-- Début des assertions --> 
            <!-- Vérifier l'existence de 5 entryRelationship FR-Simple-Observation(1.3.6.1.4.1.19376.1.5.3.1.4.13) au minimum -->
            <assert test="count(*:entryRelationship[@typeCode='REFR']) &gt;= 5" >
                [E_ListeDesAntecedents-D2LM-FIN] 5 entryRelationship @typeCode='REFR' sont obligatoires [5..*].
            </assert>
            <!-- Vérifier l'obligation de l'existence d'une seule entryRelationship portant l'entrée FR-Probleme(1.3.6.1.4.1.19376.1.5.3.1.4.5)-->
            <assert test="count(*:entryRelationship[@typeCode='SUBJ']) = 1" >
                [E_ListeDesAntecedents-D2LM-FIN] Une seule entryRelationship ayant un attribut @typeCode='SUBJ' et de type Problème (1.3.6.1.4.1.19376.1.5.3.1.4.5) est autorisée [1..1]
            </assert>
            
            <!-- Vérifier les valeurs "REFR" et "SUBJ" des attributs @typeCode des entrées FR-Simple-Observation(1.3.6.1.4.1.19376.1.5.3.1.4.13) et FR-Probleme(1.3.6.1.4.1.19376.1.5.3.1.4.5) -->
            <assert test="count(*:entryRelationship[@typeCode!='REFR' and @typeCode!='SUBJ']) = 0">
                [E_ListeDesAntecedents-D2LM-FIN] Seules les valeurs "REFR" et "SUBJ" sont autorisées dans les attributs @typeCode de entryRelationship.
            </assert>
            
            <!-- vérifier que l'entrée FR-Simple-Observation(1.3.6.1.4.1.19376.1.5.3.1.4.13) ayant toujours un templateId  "1.3.6.1.4.1.19376.1.5.3.1.4.13" -->
            <assert test="count(*:entryRelationship[@typeCode='REFR']/*:templateId[@root ='1.3.6.1.4.1.19376.1.5.3.1.4.13'] ) = count(*:entryRelationship[@typeCode='REFR'])">
                [E_ListeDesAntecedents-D2LM-FIN] L'élement entryRelationship ayant un attribut @typeCode="REFR" doit avoir un templateId  "1.3.6.1.4.1.19376.1.5.3.1.4.13"
            </assert> 
            
            <!-- vérifier que l'entrée FR-Probleme(1.3.6.1.4.1.19376.1.5.3.1.4.5) est toujours de type Problème (1.3.6.1.4.1.19376.1.5.3.1.4.5) -->
            <assert test="count(*:entryRelationship[@typeCode='SUBJ']/*:templateId[@root ='1.3.6.1.4.1.19376.1.5.3.1.4.5'] ) = count(*:entryRelationship[@typeCode='SUBJ'])">
                [E_ListeDesAntecedents-D2LM-FIN] l'élement entryRelationship ayant un attribut @typeCode="SUBJ" doit avoir un templateId  "1.3.6.1.4.1.19376.1.5.3.1.4.5"
            </assert> 
            
            <!-- Vérifier le code(@code='F-01000') de l'entrée FR-Probleme(1.3.6.1.4.1.19376.1.5.3.1.4.5)-->
            <assert test="*:entryRelationship[@typeCode='SUBJ']/$EntréeProblèmeCode">
                [E_ListeDesAntecedents-D2LM-FIN]  Le code de l'entrée Problème doit avoir l'attribut @code='F-01000'
            </assert> 
            
            <!-- Vérifier la valeur value(@code='F-01000') de l'entrée FR-Probleme(1.3.6.1.4.1.19376.1.5.3.1.4.5) -->
            <assert test="*:entryRelationship[@typeCode='SUBJ']/$EntréeProblèmeVal">
                [E_ListeDesAntecedents-D2LM-FIN]  La valeur de l'entrée Problème doit avoir l'attribut @code='C00-D48'
            </assert>
            
            <!-- Vérifier les codes des entrées FR-Simple-Observation(1.3.6.1.4.1.19376.1.5.3.1.4.13) obligatoires" -->
            <assert test="count(*:entryRelationship[@typeCode='REFR']/$EntréeAntecedMammographie) = 1  or 
                count(*:entryRelationship[@typeCode='REFR']/$EntréeAntecedPersonnels) &gt;= 1 or 
                count(*:entryRelationship[@typeCode='REFR']/$EntréeAntecedFamiliauxConnus) &gt;= 1 or   
                count(*:entryRelationship[@typeCode='REFR']/$EntréeAntecedFamiliaux) &gt;= 1 or
                count(*:entryRelationship[@typeCode='REFR']/$EntréeTraitementHormonal) = 1">
                [E_ListeDesAntecedents-D2LM-FIN] Les codes des entrées FR-Simple-Observation (1.3.6.1.4.1.19376.1.5.3.1.4.13) obligatoires doivent avoir les attributs @code='G-1009'
                 , @code='MED-009', @code='MED-010', @code='MED-123' et @code='MED-029'.
            </assert> 
            
            <!-- Vérifier les codes des entrées FR-Simple-Observation(1.3.6.1.4.1.19376.1.5.3.1.4.13) optionnelles" -->
            <assert test="not(*:entryRelationship[@typeCode='REFR']) or (count(*:entryRelationship[@typeCode='REFR']/$EntréeAgeSurvenue) &lt;= 1 or 
                count(*:entryRelationship[@typeCode='REFR']/$EntréePatienteInformée) &lt;= 1 or count(*:entryRelationship[@typeCode='REFR']/$EntréeMedecinTraitantInformé) &lt;= 1)">
                [E_ListeDesAntecedents-D2LM-FIN] Si elles existent, les entrées FR-Simple-Observation (1.3.6.1.4.1.19376.1.5.3.1.4.13) facultatives doivent avoir un élément code avec l'attribut @code='MED-070'
                ou @code='MED-016' ou @code='MED-017'.
            </assert> 
            <!-- Fin des assertions --> 
            
        </rule>
    </pattern>
    
