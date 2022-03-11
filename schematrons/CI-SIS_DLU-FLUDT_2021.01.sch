<?xml version="1.0" encoding="UTF-8" standalone="no"?>
<!-- 
   Schématron : CI-SIS_DLU-FLUDT_2021.01.sch
   Vérification de la conformité au modèle du document DLU_FLUDT_2021.01 (Fiche de transfert de l'EHPAD vers le service des urgences)
   ...................................................................................................................................................... 
   auteur : ANS
   ......................................................................................................................................................     
    Historique :
       06/11/2017 : Création
       14/03/2018 : Suppression du pattern variables
       06/01/2021 : Ajout du contrôle du JDV_ProtheseObjetPersonnel
       19/02/2021 : Test de la présence des sections, du templateId du volet et du code
   ......................................................................................................................................................
       -->

<schema xmlns="http://purl.oclc.org/dsdl/schematron" 
        xmlns:cda="urn:hl7-org:v3" 
        xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" queryBinding="xslt2" schemaVersion="CI-SIS_DLU-FLUDT_2021.01.sch">
    
        <title>Rapport de conformité au modèle DLU-FLUDT</title>
        <ns prefix="cda" uri="urn:hl7-org:v3"/>
        <ns prefix="xsi" uri="http://www.w3.org/2001/XMLSchema-instance"/>
        <ns prefix="jdv" uri="http://esante.gouv.fr"/>
        <ns prefix="svs" uri="urn:ihe:iti:svs:2008"/>
    
        <!-- Abstract patterns -->
        <include href="abstract/dansJeuDeValeurs.sch"/>
        <include href="abstract/IVL_TS.sch"/>   
        
        <!-- Schématrons JDV spécifiques au DLU-FLUDT -->
        <include href="include/jeuxDeValeurs/DLU-FLUDT_2021.01/JDV_ProtheseObjetPersonnel.sch"/>
        
        <!-- Schématron Entete spécifiques au DLU-FLUDT -->
        <include href="include/specificationsVolets/DLU-FLUDT_2021.01/Entete/Entete_DLU-FLUDT.sch"/>
        
        
        <!-- Schématron Section spécifiques au DLU-FLUDT -->
        <include href="include/specificationsVolets/DLU-FLUDT_2021.01/Sections/S_ResultatsEvenements_DLU-FLUDT.sch"/>
        <include href="include/specificationsVolets/DLU-FLUDT_2021.01/Sections/S_ResultatsExamens_DLU-FLUDT.sch"/>
        
        <phase id="CI-SIS_DLU-FLUDT_2021.01">
           <active pattern="variables"/>
           <active pattern="Entete_DLU-FLUDT"/>
           <active pattern="JDV_ProtheseObjetPersonnel"/>
                <active pattern="S_ResultatsEvenements_DLU-FLUDT"/>
                <active pattern="S_ResultatsExamens_DLU-FLUDT"/>
        </phase>
        
        <pattern id="variables">
                <let name="JDV_ProtheseObjetPersonnel" value = "'../jeuxDeValeurs/JDV_ProtheseObjetPersonnel-CISIS.xml'"/>
                <rule context="cda:ClinicalDocument">
                        <assert test="cda:templateId[@root='1.2.250.1.213.1.1.1.23']"> 
                                [CI-SIS_DLU-FLUDT_2021.01] Le templateId "1.2.250.1.213.1.1.1.23" (Conformité au modèle DLU-FLUDT du CI-SIS) doit être présent.
                        </assert>
                        <assert test="./cda:code[@code='34133-9' and @codeSystem='2.16.840.1.113883.6.1']"> 
                                [CI-SIS_DLU-FLUDT_2021.01] L'élément code doit avoir @code ="34133-9" et @codeSystem = "2.16.840.1.113883.6.1"/>. 
                        </assert>
                        <assert test="count(cda:component/cda:structuredBody/cda:component/cda:section/cda:templateId[@root='1.3.6.1.4.1.19376.1.7.3.1.1.13.7'])=1"> 
                                [CI-SIS_DLU-FLUDT_2021.01] La section "Resultats d'évenements : Transfert du patient de l'EHPAD vers le SU" doit être présente une fois. Cardinalité [1..1].
                        </assert>
                        <assert test="count(cda:component/cda:structuredBody/cda:component/cda:section/cda:templateId[@root='1.3.6.1.4.1.19376.1.5.3.1.3.25'])=1"> 
                                [CI-SIS_DLU-FLUDT_2021.01] La section "Signes vitaux : Pouls / Température / Poids / Tension artérielle haute / Tension artérielle basse" doit être présente une fois. Cardinalité [1..1].
                        </assert>
                        <assert test="count(cda:component/cda:structuredBody/cda:component/cda:section/cda:templateId[@root='1.3.6.1.4.1.19376.1.5.3.1.3.28'])=1"> 
                                [CI-SIS_DLU-FLUDT_2021.01] La section "Resultats d'examens : Patient Conscient et éveillé / Eveillable / Non éveillable + Douleurs récentes" doit être présente une fois. Cardinalité [1..1].
                        </assert>
                        <assert test="count(cda:component/cda:structuredBody/cda:component/cda:section/cda:templateId[@root='1.3.6.1.4.1.19376.1.5.3.1.3.19'])=1"> 
                                [CI-SIS_DLU-FLUDT_2021.01] La section "Traitements" doit être présente une fois. Cardinalité [1..1].
                        </assert>
                        <assert test="count(cda:component/cda:structuredBody/cda:component/cda:section/cda:templateId[@root='1.3.6.1.4.1.19376.1.7.3.1.1.13.5'])=1"> 
                                [CI-SIS_DLU-FLUDT_2021.01] La section "Evaluation fonctionnelle du sommeil et de l'alimentation : date et l’heure du dernier repas" doit être présente une fois. Cardinalité [1..1].
                        </assert>
                        <assert test="count(cda:component/cda:structuredBody/cda:component/cda:section/cda:templateId[@root='1.2.250.1.213.1.1.2.53'])=1"> 
                                [CI-SIS_DLU-FLUDT_2021.01] La section "Protheses et objets personnels" doit être présente une fois. Cardinalité [1..1].
                        </assert>
                        <assert test="count(cda:component/cda:structuredBody/cda:component/cda:section/cda:templateId[@root='1.3.6.1.4.1.19376.1.4.1.2.16'])&lt; 2"> 
                                [CI-SIS_DLU-FLUDT_2021.01] La section "Commentaire non codé" ne peut être présente qu'une fois. Cardinalité [0..1].
                        </assert>
                        
                </rule>
        </pattern>
        
</schema>
