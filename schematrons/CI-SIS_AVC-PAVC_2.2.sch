<?xml version="1.0" encoding="UTF-8"?>

<!-- 
    CI-SIS_AVC-PAVC_2.2.sch
    ANS
   
    ......................................................................................................................................................    
    Historique :
       05/10/17 : Création
       14/03/18 : MAJ du pattern variables
       10/09/2021 :  Modification du nom du schematron
                            
 -->
<schema xmlns="http://purl.oclc.org/dsdl/schematron" defaultPhase="CI-SIS_AVC-PAVC_2.2"
    xmlns:cda="urn:hl7-org:v3" queryBinding="xslt2"
    xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" schemaVersion="CI-SIS_AVC-PAVC_2.2.sch">
    <title>Vérification de la conformité au modèle AVC-PAVC</title>
    <ns prefix="cda" uri="urn:hl7-org:v3"/>
    <ns prefix="xsi" uri="http://www.w3.org/2001/XMLSchema-instance"/>
    <ns prefix="jdv" uri="http://esante.gouv.fr"/>
    <ns prefix="svs" uri="urn:ihe:iti:svs:2008"/>
     
    <!--=<<o#%@O[ Abstract patterns ]O@%#o>>=-->
    
    <include href="abstract/dansJeuDeValeurs.sch"/>
    <include href="abstract/IVL_TS.sch"/>   
    
    
    <!--=<<o#%@O[ JDV ]O@%#o>>=-->
    <include href="include/jeuxDeValeurs/AVC_2.2/JDV_Appareillage_AVC.sch"/>
    <include href="include/jeuxDeValeurs/AVC_2.2/JDV_Activite_AVC.sch"/>
    <include href="include/jeuxDeValeurs/AVC_2.2/JDV_GIR_AVC.sch"/>
    <include href="include/jeuxDeValeurs/AVC_2.2/JDV_TraitementPreventif_AVC.sch"/>
    <include href="include/jeuxDeValeurs/AVC_2.2/JDV_TraitementSuivi_AVC.sch"/>
    <include href="include/jeuxDeValeurs/AVC_2.2/JDV_Juridique_AVC.sch"/>
    <include href="include/jeuxDeValeurs/AVC_2.2/JDV_SeverityObservation_AVC.sch"/>
    
    <!--Entete-->
    <include href="include/specificationsVolets/AVC_2.2/Entete/Entete_AVC.sch"/>
    
    
    <phase id="CI-SIS_AVC-PAVC_2.2">
        <active pattern="variables"/>
        <active pattern="JDV_Appareillage_AVC"/>
        <active pattern="JDV_Activite_AVC"/>
        <active pattern="JDV_GIR_AVC"/>
        <active pattern="JDV_Juridique_AVC"/>
        <active pattern="JDV_TraitementSuivi_AVC"/>
        <active pattern="JDV_TraitementPreventif_AVC"/>
        <active pattern="JDV_SeverityObservation_AVC"/>
        <active pattern="Entete_AVC"/>
        
    </phase>
     
    <pattern id="variables">
        
        <let name="jdv_AVC_Appareillage" value="'../jeuxDeValeurs/JDV_Taille-CISIS.xml'"/>
        <let name="jdv_AVC_Activite" value="'../jeuxDeValeurs/JDV_Activite-CISIS.xml'"/> 
        <let name="jdv_AVC_GIR" value="'../jeuxDeValeurs/JDV_GIR-CISIS.xml'"/> 
        <let name="jdv_AVC_Juridique" value="'../jeuxDeValeurs/JDV_Juridique-CISIS.xml'"/> 
        <let name="jdv_AVC_TraitementPreventif" value="'../jeuxDeValeurs/JDV_TraitementPreventif-CISIS.xml'"/> 
        <let name="jdv_AVC_TraitementSuivi" value="'../jeuxDeValeurs/JDV_TraitementSuivi-CISIS.xml'"/> 
        <let name="jdv_AVC_Severite" value="'../jeuxDeValeurs/JDV_HL7_SeverityObservation-CISIS.xml'"/>
        
        <rule context="cda:ClinicalDocument">
            <assert test="cda:templateId[@root='1.2.250.1.213.1.1.1.25']"> 
                [CI-SIS_AVC-PAVC_2.2] Le template du modèle AVC-PAVC (1.2.250.1.213.1.1.1.25) doit être présent.
            </assert>
            
            <assert test="./cda:code[@code='11488-4' and @codeSystem='2.16.840.1.113883.6.1']"> 
                [CI-SIS_AVC-PAVC_2.2] L'élément code doit avoir @code ="11488-4" et @codeSystem = "2.16.840.1.113883.6.1"/>. 
            </assert>
        </rule>
   </pattern>      
     
    
</schema>

