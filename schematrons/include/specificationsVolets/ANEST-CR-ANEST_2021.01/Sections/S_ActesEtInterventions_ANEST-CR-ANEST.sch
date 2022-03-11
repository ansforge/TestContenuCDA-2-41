<?xml version="1.0" encoding="UTF-8"?>
<!-- 
   ......................................................................................................................................................    
  S_ActesEtInterventions_ANEST-CR-ANEST.sh
   Schématron de vérification de la conformité au modèle du CI-SIS de la section FR-Actes-et-interventions (1.3.6.1.4.1.19376.1.5.3.1.1.13.2.11) dans le document ANEST-CR-ANEST 
   Section FR-Actes-et-interventions : Acte chirurgical, Types d'anesthésies, Abord veineux, Cathéter intra artériel, Ventilation, Intubation, Transfusion
   ANEST-CR-ANEST : Compte rendu d'anesthésie
   auteur : ANS
   ......................................................................................................................................................    
    Historique :
    29/09/2020 : SBM : Création
    08/06/2021 : ANS : MAJ du test sur l'élément title
   ......................................................................................................................................................    
-->

<pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="S_ActesEtInterventions_ANEST-CR-ANEST">
    <title>CI-SIS ANEST-CR-ANEST Section Actes et interventions </title>
    
    <rule context='*[cda:templateId/@root="1.3.6.1.4.1.19376.1.5.3.1.1.13.2.11"]'>
        
        <!-- Variables  --> 
        <let name="EntréeAbordVeineuxPeriph" value='.//cda:procedure[cda:templateId/@root = "1.3.6.1.4.1.19376.1.5.3.1.4.19" and cda:code/cda:originalText/cda:reference/@value="abord-veineux-peripherique"]'/>
        <let name="EntréeAbordVeineuxCentral" value='.//cda:procedure[cda:templateId/@root = "1.3.6.1.4.1.19376.1.5.3.1.4.19" and cda:code/cda:originalText/cda:reference/@value="abord-veineux-central"]'/>
        <let name="EntréeCatheter" value='.//cda:procedure[cda:templateId/@root = "1.3.6.1.4.1.19376.1.5.3.1.4.19" and cda:text/cda:reference/@value="#catheter"]'/>
        <let name="EntréeVentilationAuMasque" value='.//cda:procedure[cda:templateId/@root = "1.3.6.1.4.1.19376.1.5.3.1.4.19" and cda:text/cda:reference/@value="#ventilation-masque"]'/>
        <let name="EntréeVentilationDispoSuprag" value='.//cda:procedure[cda:templateId/@root = "1.3.6.1.4.1.19376.1.5.3.1.4.19" and cda:text/cda:reference/@value="#ventilation-dispositif-supraglottique"]'/>
        <let name="EntréeIntubation" value='.//cda:procedure[cda:templateId/@root = "1.3.6.1.4.1.19376.1.5.3.1.4.19" and cda:code/cda:originalText/cda:reference/@value="#intubation"]'/>
        <let name="EntréeTransfusion" value='.//cda:procedure[cda:templateId/@root = "1.3.6.1.4.1.19376.1.5.3.1.4.19" and cda:text/cda:reference/@value="#transfusion"]'/>
        
        <!-- Vérifier le title de la section 'FR-Actes-et-interventions' -->
        <assert test='.//cda:title/text()="Actes réalisés au cours de l’intervention"'>
            [S_ActesEtInterventions_ANEST-CR-ANEST] Erreur de conformité au modèle ANEST-CR-ANEST : Une section FR-Actes-et-interventions (1.3.6.1.4.1.19376.1.5.3.1.1.13.2.11) doit obligatoirement contenir le title 'Actes réalisés au cours de l’intervention'
        </assert>
        <!-- Vérifier que la section 'FR-Actes-et-interventions' contient [1..*] entrée FR-Acte 1.3.6.1.4.1.19376.1.5.3.1.4.19 : Acte chirurgical ayant nécessité une anesthésie -->
        <assert test='count(.//cda:procedure[cda:templateId/@root = "1.3.6.1.4.1.19376.1.5.3.1.4.19" and cda:code/@code="JQGA003"])&gt;=1'>
            [S_ActesEtInterventions_ANEST-CR-ANEST] Erreur de conformité au modèle ANEST-CR-ANEST : Une section FR-Actes-et-interventions (1.3.6.1.4.1.19376.1.5.3.1.1.13.2.11) doit obligatoirement contenir une ou plusieurs entrées de type FR-Acte (1.3.6.1.4.1.19376.1.5.3.1.4.19)  avec un élément code dont l'attribut @code='JQGA003'.
        </assert>
        
        <!-- Vérifier que la section 'FR-Actes-et-interventions' contient [1..*] entrée FR-Acte 1.3.6.1.4.1.19376.1.5.3.1.4.19 : Type d'anesthésie -->
        <assert test='count(.//cda:procedure[cda:templateId/@root = "1.3.6.1.4.1.19376.1.5.3.1.4.19" and (cda:code/@code="MED-581" or cda:code/@code="MED-582"
            or cda:code/@code="MED-583" or cda:code/@code="MED-584" or cda:code/@code="MED-585" or cda:code/@code="MED-586" or cda:code/@code="MED-587" or cda:code/@code="MED-588")])&gt;=1'>
            [S_ActesEtInterventions_ANEST-CR-ANEST] Erreur de conformité au modèle ANEST-CR-ANEST : Une section FR-Actes-et-interventions (1.3.6.1.4.1.19376.1.5.3.1.1.13.2.11) doit obligatoirement contenir une ou plusieurs entrées de type FR-Acte (1.3.6.1.4.1.19376.1.5.3.1.4.19) avec un élément code dont l'attribut @code 
            doit faire partie du jeu de valeurs ../jeuxDeValeurs/JDV_TypeAnesthesie-CISIS.xml.
        </assert>
        
        <!-- Vérifier que la section 'FR-Actes-et-interventions' contient [0..1] entrée FR-Acte 1.3.6.1.4.1.19376.1.5.3.1.4.19 : Abord veineux périphérique -->
        <assert test='not($EntréeAbordVeineuxPeriph) or
            (count($EntréeAbordVeineuxPeriph)=1 and $EntréeAbordVeineuxPeriph/cda:code/@code="MED-658")'>
            Si elle existe, l'entrée FR-Acte (1.3.6.1.4.1.19376.1.5.3.1.4.19) facultative de l'abord veineux périphérique doit avoir un élément code avec l'attribut @code='MED-658' et une cardinalité [0..1].
        </assert>
        
        <!-- Vérifier que la section 'FR-Actes-et-interventions' contient [0..1] entrée FR-Acte 1.3.6.1.4.1.19376.1.5.3.1.4.19 : Abord veineux central-->
        <assert test='not($EntréeAbordVeineuxCentral) or
            (count($EntréeAbordVeineuxCentral)=1 and $EntréeAbordVeineuxCentral/cda:code/@code="EPLF002")'>
            Si elle existe, l'entrée FR-Acte (1.3.6.1.4.1.19376.1.5.3.1.4.19) facultative de l'abord veineux central doit avoir un élément code avec l'attribut @code='EPLF002' et une cardinalité [0..1].
        </assert>
        
        <!-- Vérifier que la section 'FR-Actes-et-interventions' contient [0..1] entrée FR-Acte 1.3.6.1.4.1.19376.1.5.3.1.4.19 : Pose d'un Cathéter intra artériel -->
        <assert test='not($EntréeCatheter) or
            (count($EntréeCatheter)=1 and $EntréeCatheter/cda:code/@code="MED-632")'>
            Si elle existe, l'entrée FR-Acte (1.3.6.1.4.1.19376.1.5.3.1.4.19) facultative de la pose du cathéter intra artériel doit avoir un élément code avec l'attribut @code='MED-632' et une cardinalité [0..1].
        </assert>
        <!-- Vérifier que la section 'FR-Actes-et-interventions' contient [0..1] entrée FR-Acte 1.3.6.1.4.1.19376.1.5.3.1.4.19 : Ventilation : au masque / avec dispositif supraglottique -->
        <assert test='(not($EntréeVentilationAuMasque) or
            (count($EntréeVentilationAuMasque)=1 and $EntréeVentilationAuMasque/cda:code/@code="GLLP003"))
            or
            (not($EntréeVentilationDispoSuprag) or
            (count($EntréeVentilationDispoSuprag)=1 and $EntréeVentilationDispoSuprag/cda:code/@code="GDFA014"))'>
            Si elle existe, l'entrée FR-Acte (1.3.6.1.4.1.19376.1.5.3.1.4.19) facultative de l'acte de ventilation doit avoir un élément code avec l'attribut @code='GLLP003' ou  @code='GDFA014' et une cardinalité [0..1].
        </assert>
        
        <!-- Vérifier que la section 'FR-Actes-et-interventions' contient [0..1] entrée FR-Acte 1.3.6.1.4.1.19376.1.5.3.1.4.19 : Intubation -->
        <assert test='not($EntréeIntubation) or
            (count($EntréeIntubation)=1 and $EntréeIntubation/cda:code/@code="GELD004")'>
            Si elle existe, l'entrée FR-Acte (1.3.6.1.4.1.19376.1.5.3.1.4.19) facultative  de l'acte d'intubation doit avoir un élément code avec l'attribut @code='GELD004' et une cardinalité [0..1].
        </assert>
        
        <!-- Vérifier que la section 'FR-Actes-et-interventions' contient [0..1] entrée FR-Acte 1.3.6.1.4.1.19376.1.5.3.1.4.19 : Transfusion -->
        <assert test='not($EntréeTransfusion) or
            (count($EntréeTransfusion)=1 and $EntréeTransfusion/cda:code/@code="FELF006")'>
            Si elle existe, l'entrée FR-Acte (1.3.6.1.4.1.19376.1.5.3.1.4.19) facultative  de l'acte de transfusion doit avoir un élément code avec l'attribut @code='FELF006' et une cardinalité [0..1].
        </assert>
    </rule>
</pattern>
            
            