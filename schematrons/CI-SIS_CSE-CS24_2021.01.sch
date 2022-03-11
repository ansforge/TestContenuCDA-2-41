<?xml version="1.0" encoding="UTF-8"?>
<!-- 
    Schématron du CS24 : CI-SIS_CSE-CS24_2021.01.sch
    ANS
    Vérification de la conformité au Certificats de Santé de l'Enfant - CS24 du CI-SIS.
    ......................................................................................................................................................
    Historique :
        27/05/2011 : FMY : Création
        31/05/2011 : FMY : Externalisation du plus grand nombre de patterns, contôle de authorSpecialty, 2 phases : "latotale" et "minimale"
        15/06/2011 : Organisation des sous-répertoires de composants
        24/06/2011 : CRI : Adaptation du module initial CI-SIS_StructurationCommuneCDAr2.sch en CI-SIS_CertificatSante.sch pour le volet
                           "Certificats de Santé de l'Enfant" (CS8, CS9 et CS24).
        08/10/2012 : FMY : CI-SIS 1.3 => retrait des include assignedAuthor, confidentialityCode et custodianOrganization. 
                           Maj des include assignedEntity (addr & telecom optionnels) et addr (contrôle structure des adresses)
        22/05/2015 : JDS : Utilisation du schématron CSENeurologicEnt20130326.sch (dernière version)         
                           Mise à jour du schématron CSEgeneralAppEnt20120306.sch -> CSEgeneralAppEnt20150522.sch
                           Maj des include telecom20110728.sch                    -> telecom20150317.sch
        14/03/2018 : NMA : MAJ du pattern variables
        09/06/2020 : APE : Ajout du contrôle de présence des sections obligatoires  
        26/01/2021 : ANS : Mise en conformité dernière version 2021.01     
        23/02/2021 : ANS : Ajout des sous-répertoires pour les schématrons specificationsVolets/CSE/Entrées et specificationsVolets/CSE/Sections   
                     et jeuxDeValeurs/CSE-CS8/
                     Modification des noms des JDV. 
    ......................................................................................................................................................               
-->
<schema xmlns="http://purl.oclc.org/dsdl/schematron" defaultPhase="CI-SIS_CSE-CS24_2021.01"
    xmlns:cda="urn:hl7-org:v3" queryBinding="xslt2"
    xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" schemaVersion="CI-SIS_CSE-CS24_2021.01.sch">
    <title>Vérification de conformité du document aux spécifications du modèle CSE-CS24_2021.01</title>
    <ns prefix="cda" uri="urn:hl7-org:v3"/>
    <ns prefix="xsi" uri="http://www.w3.org/2001/XMLSchema-instance"/>
    <ns prefix="jdv" uri="http://esante.gouv.fr"/>
    <ns prefix="svs" uri="urn:ihe:iti:svs:2008"/>
    
    <!-- Abstract patterns -->    
    <include href="abstract/dansJeuDeValeurs.sch"/>
    <include href="abstract/IVL_TS.sch"/>   
    
    <!-- Entete -->    
    <include href="include/specificationsVolets/CSE-CS24_2021.01/Entete/Entete_CSE.sch"/>
    
    <!-- Sections spécifiques au volet -->    
    <include href="../schematrons/include/specificationsVolets/CSE-CS24_2021.01/Sections/S_codedPhysicalExam_CSE-CS24.sch"/>
    
    <!--= Entrées spécifiques au volet -->    
    <include href="include/specificationsVolets/CSE-CS24_2021.01/Entrees/E_abdomen_CSE-CS24.sch"/>
    <include href="include/specificationsVolets/CSE-CS24_2021.01/Entrees/E_codedSocialHistory_CSE-CS24.sch"/>
    <include href="include/specificationsVolets/CSE-CS24_2021.01/Entrees/E_ears_CSE-CS24.sch"/>
    <include href="include/specificationsVolets/CSE-CS24_2021.01/Entrees/E_eatingSleeping_CSE-CS24.sch"/>
    <include href="include/specificationsVolets/CSE-CS24_2021.01/Entrees/E_endocrine_CSE-CS24.sch"/>
    <include href="include/specificationsVolets/CSE-CS24_2021.01/Entrees/E_eyes_CSE-CS24.sch"/>
    <include href="include/specificationsVolets/CSE-CS24_2021.01/Entrees/E_generalApp_CSE-CS24.sch"/>
    <include href="include/specificationsVolets/CSE-CS24_2021.01/Entrees/E_genitalia_CSE-CS24.sch"/>
    <include href="include/specificationsVolets/CSE-CS24_2021.01/Entrees/E_heart_CSE-CS24.sch"/>
    <include href="include/specificationsVolets/CSE-CS24_2021.01/Entrees/E_historyOfPastIllness_CSE-CS24.sch"/>
    <include href="include/specificationsVolets/CSE-CS24_2021.01/Entrees/E_integumentary_CSE-CS24.sch"/>
    <include href="include/specificationsVolets/CSE-CS24_2021.01/Entrees/E_lymphatic_CSE-CS24.sch"/>
    <include href="include/specificationsVolets/CSE-CS24_2021.01/Entrees/E_musculo_CSE-CS24.sch"/>
    <include href="include/specificationsVolets/CSE-CS24_2021.01/Entrees/E_neurologic_CSE-CS24.sch"/>
    <include href="include/specificationsVolets/CSE-CS24_2021.01/Entrees/E_respiratory_CSE-CS24.sch"/>
    <include href="include/specificationsVolets/CSE-CS24_2021.01/Entrees/E_teeth_CSE-CS24.sch"/> 
    <include href="include/specificationsVolets/CSE-CS24_2021.01/Entrees/E_developpementPsychomoteur_CSE-CS24.sch"/>
    
    <!-- JDV -->    
    <include href="include/jeuxDeValeurs/CSE-CS24_2021.01/JDV_Activite-CISIS.sch"/>    
    <include href="include/jeuxDeValeurs/CSE-CS24_2021.01/JDV_CauseAccidentDom-CISIS.sch"/>
    <include href="include/jeuxDeValeurs/CSE-CS24_2021.01/JDV_NiveauEtude-CISIS.sch"/>
    <include href="include/jeuxDeValeurs/CSE-CS24_2021.01/JDV_Profession-CISIS.sch"/>
    <include href="include/jeuxDeValeurs/CSE-CS24_2021.01/JDV_TypeGarde-CISIS.sch"/>
    <include href="include/jeuxDeValeurs/CSE-CS24_2021.01/JDV_VaccinCSE24-CISIS.sch"/>
    <include href="include/jeuxDeValeurs/CSE-CS8_2021.01/JDV_CertitudeDiagnostic-CISIS.sch"/>
    
    <!-- ::::::::::::::::::::::::::::::::::::: -->
    <!--           Phase en vigueur            -->    
    <!-- ::::::::::::::::::::::::::::::::::::: -->
    <phase id="CI-SIS_CSE-CS24_2021.01">
        <active pattern="variables"/>
        <p>Vérification complète de la conformité au CI-SIS</p>
        
        <!-- Entete -->        
        <active pattern="Entete_CSE"/>
        
        <!-- Sections spécifiques -->        
        <active pattern="S_codedPhysicalExam_CSE-CS24"/>
        
        <!-- Entrées spécifiques -->        
        <active pattern="E_abdomen_CSE-CS24"/>
        <active pattern="E_codedSocialHistory_CSE-CS24"/>
        <active pattern="E_ears_CSE-CS24"/>
        <active pattern="E_eatingSleeping_CSE-CS24"/>
        <active pattern="E_endocrine_CSE-CS24"/>
        <active pattern="E_eyes_CSE-CS24"/>
        <active pattern="E_generalApp_CSE-CS24"/>
        <active pattern="E_genitalia_CSE-CS24"/>
        <active pattern="E_heart_CSE-CS24"/>
        <active pattern="E_historyOfPastIllness_CSE-CS24"/>
        <active pattern="E_integumentary_CSE-CS24"/>
        <active pattern="E_lymphatic_CSE-CS24"/>
        <active pattern="E_musculo_CSE-CS24"/>
        <active pattern="E_neurologic_CSE-CS24"/>
        <active pattern="E_respiratory_CSE-CS24"/>
        <active pattern="E_teeth_CSE-CS24"/>
        <active pattern="E_developpementPsychomoteur_CSE-CS24"/>
        
        <!-- JDV -->        
        <active pattern="JDV_Activite-CISIS"/>
        <active pattern="JDV_CauseAccidentDom-CISIS"/>
        <active pattern="JDV_NiveauEtude-CISIS"/>
        <active pattern="JDV_Profession-CISIS"/>        
        <active pattern="JDV_TypeGarde-CISIS"/>
        <active pattern="JDV_VaccinCSE24-CISIS"/>
        <active pattern="JDV_CertitudeDiagnostic-CISIS"/>
        
        
    </phase>
    
    <!-- Variables globales -->
    
    <pattern id="variables">
        
        <!-- chemins relatifs des fichiers jeux de valeurs -->
        <let name="JDV_Activite-CISIS" value="'../jeuxDeValeurs/JDV_Activite-CISIS.xml'"/>
        <let name="JDV_CauseAccidentDom-CISIS" value="'../jeuxDeValeurs/JDV_CauseAccidentDom-CISIS.xml'"/>
        <let name="JDV_NiveauEtude-CISIS" value="'../jeuxDeValeurs/JDV_NiveauEtude-CISIS.xml'"/> 
        <let name="JDV_Profession-CISIS" value="'../jeuxDeValeurs/JDV_Profession-CISIS.xml'"/>         
        <let name="JDV_TypeGarde-CISIS" value="'../jeuxDeValeurs/JDV_TypeGarde-CISIS.xml'"/>
        <let name="JDV_VaccinCSE24-CISIS" value="'../jeuxDeValeurs/JDV_VaccinCSE24-CISIS.xml'"/>
        <let name="JDV_CertitudeDiagnostic-CISIS" value="'../jeuxDeValeurs/JDV_CertitudeDiagnostic-CISIS.xml'"/>
        
        <rule context="cda:ClinicalDocument">
            
            <assert test="./cda:templateId[@root='1.2.250.1.213.1.1.1.5.3']"> 
                [CI-SIS_CSE-CS24_2021.01.sch] Erreur de conformité :
                L'élément ClinicalDocument/templateId doit être présent avec @root="1.2.250.1.213.1.1.1.5.3".
            </assert>
            
            <assert test="cda:templateId[@root='1.2.250.1.213.1.1.1.5']"> 
                [CI-SIS_CSE-CS24_2021.01.sch] Erreur de conformité : 
                Le template parent "Certificat de Santé de l'Enfant" (1.2.250.1.213.1.1.1.5) doit être présent.
            </assert>
            
            <assert test="./cda:code[@code='CERT_DECL' and @codeSystem='1.2.250.1.213.1.1.4.12']"> 
                [CI-SIS_CSE-CS24_2021.01.sch] Erreur de conformité : 
                L'élément code doit avoir @code ="CERT_DECL" et @codeSystem = "1.2.250.1.213.1.1.4.12"/>. 
            </assert>
            
            <assert test="./cda:recordTarget/cda:patientRole/cda:addr/cda:postalCode and not(./cda:recordTarget/cda:patientRole/cda:addr/cda:streetAddressLine)"> 
                [CI-SIS_CSE_CS24.sch] Erreur de conformité :
                L'utilisation des composants élémentaires de l’adresse est obligatoire et le code postal est obligatoire.
            </assert>
            
        </rule>
        
        <rule context="cda:ClinicalDocument/cda:documentationOf/cda:serviceEvent/cda:performer/cda:assignedEntity">
            
            <assert test="cda:assignedPerson"> 
                [CI-SIS_CSE-CS24_2021.01.sch] Erreur de conformité :
                Le PS ayant réalisé l’examen est obligatoire.
            </assert>
            <assert test="cda:representedOrganization/cda:id"> 
                [CI-SIS_CSE-CS24_2021.01.sch] Erreur de conformité :
                L'identifiant de l’organisation est obligatoire.
            </assert>
            <assert test="cda:representedOrganization/cda:name"> 
                [CI-SIS_CSE-CS24_2021.01.sch] Erreur de conformité :
                Le nom de l’organisation est obligatoire.
            </assert>
            <assert test="cda:representedOrganization/cda:addr/cda:postalCode"> 
                [CI-SIS_CSE-CS24_2021.01.sch] Erreur de conformité :
                L'adresse de l’organisation est obligatoire. L'utilisation des composants élémentaires de l’adresse est obligatoire et le code postal est obligatoire.
            </assert>
            
        </rule>
        
        <rule context='cda:ClinicalDocument/cda:component/cda:structuredBody'>
            
            <!-- Présence obligatoire de la section Habitus, Mode de vie (1.3.6.1.4.1.19376.1.5.3.1.3.16.1) -->
            <assert test='cda:component/cda:section/cda:templateId[@root = "1.3.6.1.4.1.19376.1.5.3.1.3.16.1"]'>
                [CI-SIS_CSE-CS24_2021.01.sch] Erreur de conformité : La section Habitus, Mode de vie (1.3.6.1.4.1.19376.1.5.3.1.3.16.1) est obligatoire.  
            </assert>
            
            <!-- Présence obligatoire de la section Antécédents médicaux (1.3.6.1.4.1.19376.1.5.3.1.3.8) -->
            <assert test='cda:component/cda:section/cda:templateId[@root = "1.3.6.1.4.1.19376.1.5.3.1.3.8"]'>
                [CI-SIS_CSE-CS24_2021.01.sch] Erreur de conformité : La section Antécédents médicaux (1.3.6.1.4.1.19376.1.5.3.1.3.8) est obligatoire.  
            </assert>
            
            <!-- Présence obligatoire de la section Examens physiques (1.3.6.1.4.1.19376.1.5.3.1.1.9.15.1) -->
            <assert test='cda:component/cda:section/cda:templateId[@root = "1.3.6.1.4.1.19376.1.5.3.1.1.9.15.1"]'>
                [CI-SIS_CSE-CS24_2021.01.sch] Erreur de conformité : La section Examens physiques (1.3.6.1.4.1.19376.1.5.3.1.1.9.15.1) est obligatoire.  
            </assert>
            
            <!-- Présence obligatoire de la section Evaluation du statut fonctionnel de l'enfant (1.3.6.1.4.1.19376.1.7.3.1.1.13.3) -->
            <assert test='cda:component/cda:section/cda:templateId[@root = "1.3.6.1.4.1.19376.1.7.3.1.1.13.3"]'>
                [CI-SIS_CSE-CS24_2021.01.sch] Erreur de conformité : La section Evaluation du statut fonctionnel de l'enfant (1.3.6.1.4.1.19376.1.7.3.1.1.13.3) est obligatoire.  
            </assert>
            
            <!-- Présence obligatoire de la section Allergies et intolérances (1.3.6.1.4.1.19376.1.5.3.1.3.13) -->
            <assert test='cda:component/cda:section/cda:templateId[@root = "1.3.6.1.4.1.19376.1.5.3.1.3.13"]'>
                [CI-SIS_CSE-CS24_2021.01.sch] Erreur de conformité : La section Allergies et intolérances (1.3.6.1.4.1.19376.1.5.3.1.3.13) est obligatoire.  
            </assert>
            
            <!-- Présence obligatoire de la section Vaccinations (1.3.6.1.4.1.19376.1.5.3.1.3.23) -->
            <assert test='cda:component/cda:section/cda:templateId[@root = "1.3.6.1.4.1.19376.1.5.3.1.3.23"]'>
                [CI-SIS_CSE-CS24_2021.01.sch] Erreur de conformité : La section Vaccinations (1.3.6.1.4.1.19376.1.5.3.1.3.23) est obligatoire.  
            </assert>
            
            <!-- Présence obligatoire de la section Évaluation et plan (non codé) (1.3.6.1.4.1.19376.1.5.3.1.1.13.2.5) -->
            <assert test='cda:component/cda:section/cda:templateId[@root = "1.3.6.1.4.1.19376.1.5.3.1.1.13.2.5"]'>
                [CI-SIS_CSE-CS24_2021.01.sch] Erreur de conformité : La section Évaluation et plan (non codé) (1.3.6.1.4.1.19376.1.5.3.1.1.13.2.5) est obligatoire.  
            </assert>
            
            <!-- Présence obligatoire de la section Plan de soins (1.3.6.1.4.1.19376.1.5.3.1.3.36) -->
            <assert test='cda:component/cda:section/cda:templateId[@root = "1.3.6.1.4.1.19376.1.5.3.1.3.36"]'>
                [CI-SIS_CSE-CS24_2021.01.sch] Erreur de conformité : La section Plan de soins (1.3.6.1.4.1.19376.1.5.3.1.3.36) est obligatoire.  
            </assert>
            
        </rule>
        
    </pattern>
</schema>
