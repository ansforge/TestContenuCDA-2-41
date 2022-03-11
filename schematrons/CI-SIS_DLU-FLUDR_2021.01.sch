<?xml version="1.0" encoding="UTF-8" standalone="no"?>
<!-- 
   Schématron CI-SIS_DLU-FLUDR_2021.01.sch
   Vérification de la conformité au modèle du document DLU_FLUDR_2021.01 (Fiche de retour du service des urgences vers l'Ehpad)
   ......................................................................................................................................................    
   Auteur : ANS
   ......................................................................................................................................................    
   Historique :t
       13/12/2016 : Création
       14/03/2018 : MAJ du pattern variables
       19/02/2021 : Test de la présence des sections, du templateId du volet et du code       
   ...................................................................................................................................................... 
       -->

<schema xmlns="http://purl.oclc.org/dsdl/schematron" 
        xmlns:cda="urn:hl7-org:v3" 
        xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" 
        queryBinding="xslt2" schemaVersion="CI-SIS_DLU-FLUDR_2021.01.sch">
    
        <title>Rapport de conformité du document aux spécifications du volet DLU-FLUDR_2021.01</title>
        <ns prefix="cda" uri="urn:hl7-org:v3"/>
        <ns prefix="xsi" uri="http://www.w3.org/2001/XMLSchema-instance"/>
        <ns prefix="jdv" uri="http://esante.gouv.fr"/>
        <ns prefix="svs" uri="urn:ihe:iti:svs:2008"/>
    
        <!-- Abstract patterns -->        
        <include href="abstract/dansJeuDeValeurs.sch"/>
        <include href="abstract/IVL_TS.sch"/>   
        
        <!-- Schématrons JDV spécifiques au DLU-FLUDR -->
        <include href="include/jeuxDeValeurs/DLU-FLUDR_2021.01/JDV_CheckListDLU-FLUDR.sch"/>
        <include href="include/jeuxDeValeurs/DLU-FLUDR_2021.01/JDV_ProtheseObjetPersonnel-CISIS.sch"/>
        
        <!-- Schématron Entete spécifique au DLU-FLUDR -->        
        <include href="include/specificationsVolets/DLU-FLUDR_2021.01/Entete/Entete_DLU-FLUDR.sch"/>
        
        <!-- Schématron Section spécifique au DLU-FLUDR -->        
        <include href="include/specificationsVolets/DLU-FLUDR_2021.01/Sections/S_ResultatsEvenements_DLU-FLUDR.sch"/>
        
        <phase id="CI-SIS_DLU-FLUDR_2021.01">
                <active pattern="variables"/>
                <active pattern="JDV_CheckListDLU-FLUDR"/>
                <active pattern="JDV_ProtheseObjetPersonnel-CISIS"/>
                <active pattern="Entete_DLU-FLUDR"/>
                <active pattern="S_ResultatsEvenements_DLU-FLUDR"/>
        </phase>
        
        <pattern id="variables">
                <let name="JDV_CheckListDLU-FLUDR" value ="'../jeuxDeValeurs/JDV_ChecklistFLUDR-CISIS.xml'"/>
                <let name="JDV_ProtheseObjetPersonnel-CISIS" value ="'../jeuxDeValeurs/JDV_ProtheseObjetPersonnel-CISIS.xml'"/>
                <rule context="cda:ClinicalDocument">
                        <assert test="cda:templateId[@root='1.2.250.1.213.1.1.1.24']"> 
                                [CI-SIS_DLU-FLUDR_2021.01] Le templateId "1.2.250.1.213.1.1.1.24" (Conformité au modèle DLU-FLUDR du CI-SIS) doit être présent.
                        </assert>
                        <assert test="./cda:code[@code='34133-9' and @codeSystem='2.16.840.1.113883.6.1']"> 
                                [CI-SIS_DLU-FLUDR_2021.01] L'élément code doit avoir @code ="34133-9" et @codeSystem = "2.16.840.1.113883.6.1"/>. 
                        </assert>
                        <assert test="count(cda:component/cda:structuredBody/cda:component/cda:section/cda:templateId[@root='1.3.6.1.4.1.19376.1.7.3.1.1.13.7'])=1"> 
                                [CI-SIS_DLU-FLUDR_2021.01] La section "Resultats d'évenements : Retour du patient à l'EHPAD" doit être présente une fois. Cardinalité [1..1].
                        </assert>
                        <assert test="count(cda:component/cda:structuredBody/cda:component/cda:section/cda:templateId[@root='1.3.6.1.4.1.19376.1.5.3.1.3.7'])=1"> 
                                [CI-SIS_DLU-FLUDR_2021.01] La section "Diagnostic de sortie episode de soins (structurée)" doit être présente une fois. Cardinalité [1..1].
                        </assert>
                        <assert test="count(cda:component/cda:structuredBody/cda:component/cda:section/cda:templateId[@root='1.3.6.1.4.1.19376.1.5.3.1.3.22'])=1"> 
                                [CI-SIS_DLU-FLUDR_2021.01] La section "Traitements-a-la-sortie (structurée)" doit être présente une fois. Cardinalité [1..1].
                        </assert>
                        <assert test="count(cda:component/cda:structuredBody/cda:component/cda:section/cda:templateId[@root='1.2.250.1.213.1.1.2.53'])=1"> 
                                [CI-SIS_DLU-FLUDR_2021.01] La section "Protheses et objets personnels" doit être présente une fois. Cardinalité [1..1].
                        </assert>
                        <assert test="count(cda:component/cda:structuredBody/cda:component/cda:section/cda:templateId[@root='1.2.250.1.213.1.1.2.37'])=1"> 
                                [CI-SIS_DLU-FLUDR_2021.01] La section "Documents ajoutés" doit être présente une fois. Cardinalité [1..1].
                        </assert>
                        <assert test="count(cda:component/cda:structuredBody/cda:component/cda:section/cda:templateId[@root='1.3.6.1.4.1.19376.1.4.1.2.16'])&lt; 2"> 
                                [CI-SIS_DLU-FLUDR_2021.01] La section "Commentaire non codé" ne peut être présente qu'une fois. Cardinalité [0..1].
                        </assert>
                        
                </rule>
        </pattern>
</schema>
