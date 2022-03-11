<?xml version="1.0" encoding="UTF-8"?>
<!-- 
    CI-SIS_AVC-AUNV_2.2.sch - ANS
    ......................................................................................................................................................    
    Historique :
        29/10/2013 : Création
        15/04/2015 : Ajout du schematron AVC_codedPhysicalExam20150415.sch ( vérification de la presence des sous sections obligatoires)
                     Ajout du schematron neurologicPhysicalExam20110627.sch
                     Mise à jour du schematron AVC_CodedReasonForReferralEntries20131030.sch -> AVC_CodedReasonForReferralEntries20150417.sch
                     Ajout du schematron immunoHemato20150506.sch
                     Ajout du schematron RankinScoreSection20150506.sch
                     Ajout du schematron GlasgowScoreSection20150506.sch
                     Ajout du schematron bilanPretherapeutique20150506.sch
                     Ajout du schematron AVC_activeProblemSection20150417.sch
                     Maj des include telecom20110728.sch                         -> telecom20150317.sch
                     Maj des include codedListOfSurgeries20120718.sch            -> codedListOfSurgeries20150319.sch
       14/03/2018 :  MAJ du pattern variables
       28/10/2020 :  Suppression des schématrons de JDV génériques déjà testé à partir de CI-SIS_StructurationMinimale.sch
       10/09/2021 :  Modification du nom du schematron
-->
<schema xmlns="http://purl.oclc.org/dsdl/schematron" defaultPhase="CI-SIS_AVC-AUNV_2.2"
    xmlns:cda="urn:hl7-org:v3" queryBinding="xslt2"
    xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" schemaVersion="CI-SIS_AVC-AUNV_2.2.sch">
    <title>Vérification de la conformité au modèle AVC-AUNV_2.2</title>
    <ns prefix="cda" uri="urn:hl7-org:v3"/>
    <ns prefix="xsi" uri="http://www.w3.org/2001/XMLSchema-instance"/>
    <ns prefix="jdv" uri="http://esante.gouv.fr"/>
    <ns prefix="svs" uri="urn:ihe:iti:svs:2008"/>
    
    <!-- Abstract patterns -->
    <include href="abstract/dansJeuDeValeurs.sch"/>
    <include href="abstract/IVL_TS.sch"/>   
    
    <!-- JDV -->
    <include href="include/jeuxDeValeurs/AVC_2.2/JDV_ModeDeTransport.sch"/>
    <include href="include/jeuxDeValeurs/AVC_2.2/JDV_TopoTrouble.sch"/>
    <include href="include/jeuxDeValeurs/AVC_2.2/JDV_Lateralite.sch"/>
    <include href="include/jeuxDeValeurs/AVC_2.2/JDV_LateraliteManuelle.sch"/>
    <include href="include/jeuxDeValeurs/AVC_2.2/JDV_TroubleVisuel.sch"/>
    <include href="include/jeuxDeValeurs/AVC_2.2/JDV_AutresSymptomesAVC.sch"/>
    <include href="include/jeuxDeValeurs/AVC_2.2/JDV_TypeDiabete.sch"/>
    <include href="include/jeuxDeValeurs/AVC_2.2/JDV_TypeMigraine.sch"/>
    <include href="include/jeuxDeValeurs/AVC_2.2/JDV_CddFA.sch"/>
    <include href="include/jeuxDeValeurs/AVC_2.2/JDV_SiteIntervention.sch"/>
    <include href="include/jeuxDeValeurs/AVC_2.2/JDV_AutreSymptomeExNeuro.sch"/>
    <include href="include/jeuxDeValeurs/AVC_2.2/JDV_NIHSSConsInt.sch"/>
    <include href="include/jeuxDeValeurs/AVC_2.2/JDV_NIHSSLocqInt.sch"/>
    <include href="include/jeuxDeValeurs/AVC_2.2/JDV_NIHSSLoccInt.sch"/>
    <include href="include/jeuxDeValeurs/AVC_2.2/JDV_NIHSSOculInt.sch"/>
    <include href="include/jeuxDeValeurs/AVC_2.2/JDV_NIHSSCvInt.sch"/>
    <include href="include/jeuxDeValeurs/AVC_2.2/JDV_NIHSSPfInt.sch"/>
    <include href="include/jeuxDeValeurs/AVC_2.2/JDV_NIHSSMsInt.sch"/>
    <include href="include/jeuxDeValeurs/AVC_2.2/JDV_NIHSSMiInt.sch"/>
    <include href="include/jeuxDeValeurs/AVC_2.2/JDV_NIHSSAtaxInt.sch"/>
    <include href="include/jeuxDeValeurs/AVC_2.2/JDV_NIHSSSensInt.sch"/>
    <include href="include/jeuxDeValeurs/AVC_2.2/JDV_NIHSSLangInt.sch"/>
    <include href="include/jeuxDeValeurs/AVC_2.2/JDV_NIHSSDysInt.sch"/>
    <include href="include/jeuxDeValeurs/AVC_2.2/JDV_NIHSSNeglInt.sch"/>
    <include href="include/jeuxDeValeurs/AVC_2.2/JDV_InterpretationECG.sch"/>
    <include href="include/jeuxDeValeurs/AVC_2.2/JDV_TypeLesionImagerie.sch"/>
    <include href="include/jeuxDeValeurs/AVC_2.2/JDV_territoireInfarctus.sch"/>
    <include href="include/jeuxDeValeurs/AVC_2.2/JDV_ArtereAnt.sch"/>
    <include href="include/jeuxDeValeurs/AVC_2.2/JDV_ArterePost.sch"/>
    <include href="include/jeuxDeValeurs/AVC_2.2/JDV_ArtereTronc.sch"/>
    <include href="include/jeuxDeValeurs/AVC_2.2/JDV_ArtereCervelet.sch"/>
    <include href="include/jeuxDeValeurs/AVC_2.2/JDV_HemisphereLobaire.sch"/>
    <include href="include/jeuxDeValeurs/AVC_2.2/JDV_HemisphereProfond.sch"/>
    <include href="include/jeuxDeValeurs/AVC_2.2/JDV_CerveletLoc.sch"/>
    <include href="include/jeuxDeValeurs/AVC_2.2/JDV_LocaThromboseVeineuse.sch"/>
    <include href="include/jeuxDeValeurs/AVC_2.2/JDV_TypeTraitementIV.sch"/>
    <include href="include/jeuxDeValeurs/AVC_2.2/JDV_StatutEvt.sch"/>
    <include href="include/jeuxDeValeurs/AVC_2.2/JDV_ScoreFisher.sch"/>        
    
    <!--Entete-->
    <include href="include/specificationsVolets/AVC_2.2/Entete/Entete_AVC.sch"/>
    
    <!-- ::::::::::::::::::::::::::::::::::::: -->
    <!--           Phase en vigueur            -->
    <!-- ::::::::::::::::::::::::::::::::::::: -->
    
    <phase id="CI-SIS_AVC-AUNV_2.2">
        <active pattern="variables"/>
        
        <!-- JDV -->
        <active pattern="JDV_ModeDeTransport"/>
        <active pattern="JDV_TopoTrouble"/>
        <active pattern="JDV_Lateralite"/>
        <active pattern="JDV_LateraliteManuelle"/>
        <active pattern="JDV_TroubleVisuel"/>
        <active pattern="JDV_AutresSymptomesAVC"/>
        <active pattern="JDV_TypeDiabete"/>
        <active pattern="JDV_TypeMigraine"/>
        <active pattern="JDV_CddFA"/>
        <active pattern="JDV_SiteIntervention"/>
        <active pattern="JDV_AutreSymptomeExNeuro"/>
        <active pattern="JDV_NIHSSConsInt"/>
        <active pattern="JDV_NIHSSLocqInt"/>
        <active pattern="JDV_NIHSSLoccInt"/>
        <active pattern="JDV_NIHSSOculInt"/>
        <active pattern="JDV_NIHSSCvInt"/>
        <active pattern="JDV_NIHSSPfInt"/>
        <active pattern="JDV_NIHSSMsInt"/>
        <active pattern="JDV_NIHSSMiInt"/>
        <active pattern="JDV_NIHSSAtaxInt"/>
        <active pattern="JDV_NIHSSSensInt"/>
        <active pattern="JDV_NIHSSLangInt"/>
        <active pattern="JDV_NIHSSDysInt"/>
        <active pattern="JDV_NIHSSNeglInt"/>
        <active pattern="JDV_InterpretationECG"/>
        <active pattern="JDV_TypeLesionImagerie"/>
        <active pattern="JDV_territoireInfarctus"/>
        <active pattern="JDV_ArtereAnt"/>
        <active pattern="JDV_ArterePost"/>
        <active pattern="JDV_ArtereTronc"/>
        <active pattern="JDV_ArtereCervelet"/>
        <active pattern="JDV_HemisphereLobaire"/>
        <active pattern="JDV_HemisphereProfond"/>
        <active pattern="JDV_CerveletLoc"/>
        <active pattern="JDV_LocaThromboseVeineuse"/>
        <active pattern="JDV_TypeTraitementIV"/>
        <active pattern="JDV_StatutEvt"/>
        <active pattern="JDV_ScoreFisher"/>        
        
        <!--Entete-->
        <active pattern="Entete_AVC"/>
        
    </phase>
    
    <!--=<<o#%@O[ Variables globales ]O@%#o>>=-->
    <pattern id="variables">

        <!-- chemins relatifs des fichiers jeux de valeurs -->
        <let name="JDV_ModeDeTransport" value="'../jeuxDeValeurs/JDV_ModeDeTransport-CISIS.xml'"/>
        <let name="JDV_TopoTrouble" value="'../jeuxDeValeurs/JDV_TopoTrouble-CISIS.xml'"/>
        <let name="JDV_Lateralite" value="'../jeuxDeValeurs/JDV_Lateralite-CISIS.xml'"/>
        <let name="JDV_LateraliteManuelle" value="'../jeuxDeValeurs/JDV_LateraliteManuelle-CISIS.xml'"/>
        <let name="JDV_TroubleVisuel" value="'../jeuxDeValeurs/JDV_TroubleVisuel-CISIS.xml'"/>
        <let name="JDV_AutresSymptomesAVC" value="'../jeuxDeValeurs/JDV_AutresSymptomesAVC-CISIS.xml'"/>
        <let name="JDV_TypeDiabete" value="'../jeuxDeValeurs/JDV_TypeDiabete-CISIS.xml'"/>
        <let name="JDV_TypeMigraine" value="'../jeuxDeValeurs/JDV_TypeMigraine-CISIS.xml'"/>
        <let name="JDV_CddFA" value="'../jeuxDeValeurs/JDV_CddFA-CISIS.xml'"/>
        <let name="JDV_SiteIntervention" value="'../jeuxDeValeurs/JDV_SiteIntervention-CISIS.xml'"/>
        <let name="JDV_AutreSymptomeExNeuro" value="'../jeuxDeValeurs/JDV_AutreSymptomeExNeuro-CISIS.xml'"/>
        <let name="JDV_NIHSSConsInt" value="'../jeuxDeValeurs/JDV_NIHSSConsInt-CISIS.xml'"/>  
        <let name="JDV_NIHSSLocqInt" value="'../jeuxDeValeurs/JDV_NIHSSLocqInt-CISIS.xml'"/>  
        <let name="JDV_NIHSSLoccInt" value="'../jeuxDeValeurs/JDV_NIHSSLoccInt-CISIS.xml'"/>  
        <let name="JDV_NIHSSOculInt" value="'../jeuxDeValeurs/JDV_NIHSSOculInt-CISIS.xml'"/>
        <let name="JDV_NIHSSCvInt" value="'../jeuxDeValeurs/JDV_NIHSSCvInt-CISIS.xml'"/>
        <let name="JDV_NIHSSPfInt" value="'../jeuxDeValeurs/JDV_NIHSSPfInt-CISIS.xml'"/>
        <let name="JDV_NIHSSMsInt" value="'../jeuxDeValeurs/JDV_NIHSSMsInt-CISIS.xml'"/>
        <let name="JDV_NIHSSMiInt" value="'../jeuxDeValeurs/JDV_NIHSSMiInt-CISIS.xml'"/>
        <let name="JDV_NIHSSAtaxInt" value="'../jeuxDeValeurs/JDV_NIHSSAtaxInt-CISIS.xml'"/>
        <let name="JDV_NIHSSSensInt" value="'../jeuxDeValeurs/JDV_NIHSSSensInt-CISIS.xml'"/>
        <let name="JDV_NIHSSLangInt" value="'../jeuxDeValeurs/JDV_NIHSSLangInt-CISIS.xml'"/>
        <let name="JDV_NIHSSDysInt" value="'../jeuxDeValeurs/JDV_NIHSSDysInt-CISIS.xml'"/>
        <let name="JDV_NIHSSNeglInt" value="'../jeuxDeValeurs/JDV_NIHSSNeglInt-CISIS.xml'"/>
        <let name="JDV_InterpretationECG" value="'../jeuxDeValeurs/JDV_InterpretationECG-CISIS.xml'"/>
        <let name="JDV_TypeLesionImagerie" value="'../jeuxDeValeurs/JDV_TypeLesionImagerie-CISIS.xml'"/>
        <let name="JDV_territoireInfarctus" value="'../jeuxDeValeurs/JDV_territoireInfarctus-CISIS.xml'"/>
        <let name="JDV_ArtereAnt" value="'../jeuxDeValeurs/JDV_ArtereAnt-CISIS.xml'"/>
        <let name="JDV_ArterePost" value="'../jeuxDeValeurs/JDV_ArterePost-CISIS.xml'"/>
        <let name="JDV_ArtereTronc" value="'../jeuxDeValeurs/JDV_ArtereTronc-CISIS.xml'"/>
        <let name="JDV_ArtereCervelet" value="'../jeuxDeValeurs/JDV_ArtereCervelet-CISIS.xml'"/>
        <let name="JDV_HemisphereLobaire" value="'../jeuxDeValeurs/JDV_HemisphereLobaire-CISIS.xml'"/>
        <let name="JDV_HemisphereProfond" value="'../jeuxDeValeurs/JDV_HemisphereProfond-CISIS.xml'"/>
        <let name="JDV_CerveletLoc" value="'../jeuxDeValeurs/JDV_CerveletLoc-CISIS.xml'"/>
        <let name="JDV_LocaThromboseVeineuse" value="'../jeuxDeValeurs/JDV_LocaThromboseVeineuse-CISIS.xml'"/>
        <let name="JDV_TypeTraitementIV" value="'../jeuxDeValeurs/JDV_TypeTraitementIV-CISIS.xml'"/>
        <let name="JDV_StatutEvt" value="'../jeuxDeValeurs/JDV_StatutEvt-CISIS.xml'"/>
        <let name="JDV_ScoreFisher" value="'../jeuxDeValeurs/JDV_ScoreFisher-CISIS.xml'"/>
                
        <rule context="cda:ClinicalDocument">
            <assert test="cda:templateId[@root='1.2.250.1.213.1.1.1.15']"> 
                [CI-SIS_AVC-AUNV_2.2] Le template du modèle AVC-AUNV (1.2.250.1.213.1.1.1.15) doit être présent.
            </assert>
            
            <assert test="./cda:code[@code='34133-9' and @codeSystem='2.16.840.1.113883.6.1']"> 
                [CI-SIS_AVC-AUNV_2.2] L'élément code doit avoir @code ="34133-9" et @codeSystem = "2.16.840.1.113883.6.1"/>. 
            </assert>
        </rule>
    </pattern>
</schema>
